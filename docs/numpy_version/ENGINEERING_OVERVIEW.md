# eduPIC NumPy — Dokument Techniczny dla Inżyniera

> **Przeznaczenie**: Opis decyzji architektonicznych, uzasadnienie zmian i spodziewanych korzyści  
> **Projekt**: GoPIC / eduPIC — reimplementacja PIC/MCC w NumPy  
> **Data**: 25 Czerwca 2026

---

## 1. Kontekst i Cel

Obecna implementacja Python (`native_version/`) jest funkcjonalnie poprawna, ale przepisuje pętle C++ dosłownie na pętle Python. Powoduje to drastyczny spadek wydajności — Python jako język interpretowany narzuca kilkaset nanosekund na każdą iterację pętli, podczas gdy C lub NumPy wykonuje tę samą operację w kilku nanosekund.

Symulacja PIC w trybie produkcyjnym uruchamia setki cykli RF, gdzie każdy cykl zawiera $N_T = 4000$ kroków czasowych, a każdy krok operuje na populacji typowo **20 000–100 000 cząstek**. Przy takich rozmiarach różnica między pętlą Python a zwektoryzowaną operacją NumPy jest odczuwalna: **20–100× przyspieszenie** jest realistyczne.

Celem tej wersji jest dostarczenie implementacji, która:
- Daje wyniki **fizycznie identyczne** z wersją natywną (dla tego samego seedu RNG),
- Jest **znacząco szybsza** dzięki wektoryzacji kluczowych kroków,
- Zachowuje tę samą modularną strukturę kodu (`step1`–`step9`).

---

## 2. Główna Zmiana Architektury Danych: Python `list` → `np.ndarray`

### Dlaczego to jest kluczowe?

Python `list` przechowuje elementy jako ogólne obiekty Pythona (tzw. PyObject). Każdy dostęp wymaga dereferencji wskaźnika i rozpakowania (unboxing) wartości. Gdy iterujemy pętlą po milionach takich elementów, narzut interpretera dominuje czas wykonania.

`np.ndarray` z typem `float64` przechowuje dane jako ciągły blok surowych bajtów w pamięci (identycznie jak tablica C). NumPy operuje na całym bloku przy pomocy skompilowanych procedur BLAS/LAPACK i własnych kerneli w C/Fortran — bez żadnego narzutu Pythona.

### Kluczowe zasady operowania na tablicach cząstek

Tablice cząstek są preallokowane do `MAX_N_P = 1 000 000`, ale **aktywna część to zawsze `[:N_e]` (dla elektronów) lub `[:N_i]` (dla jonów)**. Wszystkie operacje wektorowe operują wyłącznie na tym widoku — zapewnia to poprawność i wydajność.

---

## 3. Uzasadnienie Zmian Krok po Kroku

### Step 1 — Depozycja gęstości (`np.add.at` / `np.bincount`)

**Problem z wersją natywną**: Pętla `for k in range(N_e)` to najkosztowniejszy wzorzec w Pythonie dla dużych populacji.

**Zastosowane rozwiązanie**: Wektoryzacja przez obliczenie wszystkich wag jednocześnie i zastosowanie `np.add.at` jako scatter-add.

**Dlaczego `np.add.at` a nie `density[p] += ...`?** Gdy dwie lub więcej cząstek trafia na ten sam węzeł siatki, standardowe `+=` z NumPy **nie sumuje poprawnie** przy duplikowaniu indeksów (tzw. problem buffered index operations). `np.add.at` jest niebuforowaną operacją i gwarantuje poprawność przy powtarzających się indeksach.

**Alternatywa — `np.bincount`**: Dla bardzo dużych populacji cząstek (>50k) `np.bincount` z parametrem `weights` jest 2–5× szybsze niż `np.add.at`. Jednak `bincount` wymaga oddzielnego wywołania dla lewego i prawego węzła, co komplikuje kod. Wdrożenie powinno zacząć od `np.add.at` (prostsze i poprawne), a przy potrzebie optymalizacji przestawić się na `bincount`.

**Spodziewane przyspieszenie**: 20–50×.

---

### Step 2 — Solver Poissona (`scipy.linalg.solve_banded`)

**Problem z wersją natywną**: Algorytm Thomasa (trójprzebiegi forward/backward) to pętla sekwencyjna — każdy krok zależy od poprzedniego, więc nie można jej zwektoryzować elementarnie.

**Zastosowane rozwiązanie**: Biblioteka `scipy.linalg.solve_banded` implementuje dokładnie ten sam algorytm w skompilowanym Fortranie (LAPACK routine `dgbsv`). Interfejs przyjmuje macierz w formacie pasmowym i wektor prawej strony — to dokładnie odpowiada strukturze naszego układu równań.

**Dodatkowy zysk**: Obliczanie pola elektrycznego `efield[1:-1]` jest teraz jedną operacją wektorową na tablicy NumPy zamiast pętli `for i in range(1, N_G-1)`.

**Ważna optymalizacja**: Macierz trójdiagonalna jest stała (nie zależy od czasu ani od stanu cząstek) — budujemy ją raz przy inicjalizacji i przechowujemy w `sim._thomas_ab`. Solver wywołujemy tylko z aktualizowanym wektorem prawej strony.

**Spodziewane przyspieszenie**: 5–15×.

---

### Step 3/4 — Push cząstek (wektoryzacja Leapfrog)

**Problem z wersją natywną**: Identyczny jak w Step 1 — pętla po wszystkich cząstkach z skalarnymi obliczeniami per cząstka.

**Zastosowane rozwiązanie**: Interpolacja pola elektrycznego na pozycje cząstek i aktualizacja prędkości/pozycji są algebraicznie niezależne między cząstkami — można je wyrazić jako operacje tablicowe. Zastosowanie fancy indexing: `sim.efield[p]` gdzie `p` jest tablicą indeksów pobiera wartości pola dla wszystkich cząstek jednocześnie.

**Tryb diagnostyczny**: Gromadzenie danych XT (histogramy, energie) wymaga scatter-add operacji analogicznych do Step 1 — stosujemy `np.add.at`.

**Spodziewane przyspieszenie**: 30–80×.

---

### Step 5/6 — Warunki brzegowe (boolean masking)

**Problem z wersją natywną**: Pętla `while k < N_e` z warunkowym usuwaniem cząstek przez zamianę z ostatnim elementem. Ta pętla nie jest wektoryzowalna w prosty sposób ze względu na mutację tablicy w trakcie iteracji.

**Zastosowane rozwiązanie**: Zmiana strategii — zamiast usuwać in-place, konstruujemy maskę boolowską `mask_keep = (x >= 0) & (x <= L)` i **kopiujemy** aktywne cząstki do początku tablicy.

**Kompromis**: Podejście z kopiowaniem zużywa więcej pamięci niż in-place swap i tworzy tymczasowe tablice. Jest jednak drastycznie szybsze dla dużych $N_e$, bo eliminuje wielokrotne przejścia pętli Python. Dla $N_e = 100k$ i $~1\%$ cząstek traconych: kopia ~100k vs. 1000 iteracji pętli Python — kopia wygrywa.

**Zbieranie IFED dla jonów**: Energie pochłanianych jonów zbieramy przez `np.bincount` — wektorowe zliczanie energii do histogramu bez pętli.

**Spodziewane przyspieszenie**: 50–100×.

---

### Step 7/8 — Kolizje MCC (wektoryzacja hybrydowa)

**Problem z wersją natywną**: Kolizje wymagają dla każdej cząstki: obliczenia energii, losowania, i warunkowego wywołania złożonej procedury z wieloma gałęziami (elastic/excitation/ionization). Pełna wektoryzacja jest niemożliwa bez znacznej komplikacji kodu.

**Zastosowane rozwiązanie — strategia dwufazowa**:

1. **Faza wektoryzowana**: Obliczenie energii, prędkości, indeksów przekrojów czynnych i prawdopodobieństw kolizji jednocześnie dla wszystkich cząstek. Losowanie jednym wywołaniem `np.random.random(N_e)`. Identyfikacja kolizjonujących cząstek przez `np.where`.

2. **Faza skalarna**: Wywołanie istniejącego kodu `collision_electron`/`collision_ion` tylko dla cząstek, które faktycznie kolidują.

**Dlaczego ta hybryda jest wystarczająca?** Warunek stabilności symulacji (`P_coll < 0.05`) gwarantuje, że w jednym kroku kolizjonuje co najwyżej ~5% cząstek. Faza skalarna dotyczy zatem ~5% populacji zamiast 100% — zysk z wektoryzacji fazy 1 jest 20× redukcją kosztów.

Istniejące funkcje `collision_electron` i `collision_ion` z `native_version/collisions.py` mogą być użyte **bez modyfikacji** — wymagają tylko, żeby `sim.x_e`, `sim.vx_e` itd. były tablicami NumPy obsługującymi indeksowanie (co jest spełnione).

**Spodziewane przyspieszenie**: 15–30×.

---

### Step 9 — Diagnostyki XT (operacje kolumnowe)

**Problem z wersją natywną**: Pętla `for p in range(N_G)` po 400 węzłach przy każdym kroku w trybie pomiarowym.

**Zastosowane rozwiązanie**: Jeśli tablice XT są `np.ndarray` o kształcie `(N_G, N_XT)`, akumulacja dla kolumny `t_index` to prosta operacja: `sim.ne_xt[:, t_index] += sim.e_density`. Jedna linia zamiast 400 iteracji.

**Spodziewane przyspieszenie**: 10–20×.

---

## 4. Podsumowanie Spodziewanego Przyspieszenia

| Krok | Metoda wektoryzacji | Przyspieszenie |
|:-----|:-------------------|:--------------|
| Step 1 — Depozycja gęstości | `np.add.at` / `np.bincount` | **20–50×** |
| Step 2 — Solver Poissona | `scipy.linalg.solve_banded` | **5–15×** |
| Step 3/4 — Push cząstek | Fancy indexing + array ops | **30–80×** |
| Step 5/6 — Granice | Boolean masking + kopiowanie | **50–100×** |
| Step 7/8 — Kolizje MCC | Wektoryzacja selekcji + ~5% pętla | **15–30×** |
| Step 9 — Diagnostyki XT | Operacje kolumnowe 2D | **10–20×** |
| **Łącznie** | Ważona średnia | **~20–60×** |

---

## 5. Wymagania Niefunkcjonalne

### Poprawność fizyczna

> [!IMPORTANT]
> Wyniki numeryczne (gęstości, energie, EEPF, IFED) muszą być **identyczne** z `native_version` dla tego samego seedu RNG. Konieczne jest wdrożenie testów regresyjnych porównujących wyjścia obu wersji zanim kod zostanie uznany za produkcyjny.

### Pamięć

> [!WARNING]
> Zmiana strategii usuwania cząstek w Step 5/6 (kopiowanie zamiast in-place swap) generuje tymczasowe tablice o rozmiarze ~$N_e \times 4 \times 8$ bajtów. Dla $N_e = 100k$ to ~3.2 MB na krok — akceptowalne, ale warto monitorować peak memory przy bardzo dużych populacjach.

### Zgodność z API

Zachowujemy ten sam interfejs funkcji (`step1_compute_electron_density(sim)` itd.) i tę samą klasę `SimulationState` — umożliwia to wywołanie `io_manager.py` i `main.py` z `native_version` bez modyfikacji (po skopiowaniu).
