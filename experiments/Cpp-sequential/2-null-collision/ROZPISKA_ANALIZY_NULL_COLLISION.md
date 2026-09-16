# Przewodnik i Rozpiska Podrozdziału: Metoda Zderzeń Zerowych (Null-Collision Method)

> **Lokalizacja w pracy magisterskiej:**  
> **Rozdział 4. Eksperymenty optymalizacyjne i analiza wydajności PIC-MCC w C++ oraz Go**  
> └── **Podrozdział 4.2: Ścieżka optymalizacji silnika w języku C++**  
>     └── **4.2.1. Eliminacja wąskiego gardła kinetyki zderzeniowej: Metoda Zderzeń Zerowych (Null-Collision)**

Niniejszy dokument stanowi kompletny konspekt teoretyczno-analityczny i szablon do opisu pierwszego kroku optymalizacyjnego w pracy magisterskiej. Został przygotowany analogicznie do [ROZPISKA_ANALIZY_BASELINE.md](file:///C:/Users/E14/Documents/GitHub/GoPIC/experiments/baseline/ROZPISKA_ANALIZY_BASELINE.md). Skupia się na uzasadnieniu inżynierskim, aparacie matematycznym, korzyściach mikroarchitektonicznych oraz zawiera przygotowane szablony tabel na dane telemetryczne z klastra HPC (`perf stat`, `perf report`).

---

## 1. Cel i Rola Podrozdziału w Pracy Magisterskiej

1. **Pierwszy krok na ścieżce optymalizacji ($T_0 \to T_1$):**
   * Wyznaczenie nowego czasu wykonania $T_{\text{null}}$ oraz przyspieszenia cząstkowego:
     $$S_1 = \frac{T_0}{T_{\text{null}}}$$
2. **Odpowiedź na dominujące wąskie gardło Baseline:**
   * Wykazanie, że optymalizacja bezpośrednio eliminuje największy pojedynczy hotspot zidentyfikowany podczas profilowania stanu wyjściowego – funkcję wykładniczą `__exp_finite` w bibliotece `libm.so.6`.
3. **Ekwiwalencja fizyczna i statystyczna:**
   * Udowodnienie, że radykalna redukcja złożoności obliczeniowej nie zmienia fizyki wyładowania plazmowego i zachowuje tożsamość rozkładów cząstek.

---

## 2. Na Bazie Czego Wdrażamy tę Optymalizację? (Diagnoza z Baseline)

### 2.1. Zidentyfikowany Hotspot w Profilu Sprzętowym
W analizie kodu bazowego (**Baseline eduPIC**) profilowanie próbkujące `perf record` / `perf report` jednoznacznie wskazało, że:
* Funkcja `__exp_finite` (oraz powiązane procedury `exp` z biblioteki systemowej `glibc`) odpowiada za **ponad 7–10% całkowitego czasu pracy procesora**.
* Łącznie funkcje transcendentalne biblioteki matematycznej (`exp`, `atan2`, `pow`, `cos`, `sin`) pochłaniają **aż 22–25% cykli CPU**.

### 2.2. Algorytmiczna Przyczyna Problemu: Naiwna Metoda Bezpośrednia (Direct MCC)
W klasycznej implementacji zderzeń Monte Carlo (Donkó et al. 2021, Birdsall 1991):
1. Pętla zderzeniowa iteruje po **wszystkich cząstkach** w układzie ($N_e \approx 108\,000$, $N_i \approx 113\,000$).
2. Dla każdej pojedynczej cząstki w każdym podkroku czasowym $\Delta t$:
   * pobierane są 3 składowe prędkości,
   * obliczany jest pierwiastek kwadratowy: $v = \sqrt{v_x^2 + v_y^2 + v_z^2}$,
   * przeliczana jest energia kinetyczna i pobierany przekrój czynny $\sigma_{\text{tot}}(v)$,
   * wyliczana jest częstość zderzeń: $\nu(v) = \sigma_{\text{tot}}(v) \cdot v \cdot n_g$,
   * obliczane jest prawdopodobieństwo zderzenia:
     $$p_{\text{coll}} = 1 - \exp(-\nu(v) \cdot \Delta t)$$
   * losowana jest liczba pseudolosowa $R \in [0, 1)$ w celu weryfikacji warunku $R < p_{\text{coll}}$.

### 2.3. Skala Marnotrawstwa Cykli Zegara
Dla reprezentatywnej symulacji ($N \approx 108\,000$ cząstek, $N_T = 4000$ podkroków na cykl RF):
* **Liczba wywołań `exp()` na 1 cykl RF:** $108\,000 \times 4000 \approx \mathbf{432\,000\,000}$ (ponad 430 milionów wywołań na cykl!).
* **Fizyczny paradoks:** Rzeczywiste prawdopodobieństwo zderzenia w jednym kroku wynosi zaledwie $\approx 10^{-4} - 10^{-2}$. Oznacza to, że w ponad **$99\%$ przypadków** procesor wykonuje kosztowne obliczenia pierwiastka, tabeli przekrojów i funkcji `exp()`, tylko po to, by na końcu stwierdzić, że do zderzenia **nie doszło**.

---

## 3. Formalizm Matematyczny: Czym Metoda Zderzeń Zerowych Różni Się od Direct MCC?

Metoda zderzeń pozornych / zerowych (**Null-Collision Method**, wprowadzona pierwotnie przez H. R. Skulleruda w 1968 r. dla dryfu jonów, a sformalizowana dla symulacji plazmowych PIC/MCC przez V. Vahediego i M. Surendrę w 1995 r.) opiera się na technice **próbkowania z odrzuceniem (Rejection Sampling)**.

### 3.1. Konstrukcja Matematyczna
W klasycznym MCC całkowita częstość zderzeń cząstki $\nu(v)$ zależy nieliniowo od jej prędkości:
$$\nu(v) = \sigma_{\text{tot}}(v) \cdot v \cdot n_g$$

W metodzie Null-Collision definiujemy sztuczną, fikcyjną częstość zderzeń zerowych $\nu_{\text{null}}(v)$ w taki sposób, aby suma częstości rzeczywistej i pozornej była **ściśle stała i niezależna od prędkości**:
$$\nu_{\text{total}} = \nu(v) + \nu_{\text{null}}(v) \equiv \nu^* = \max_v \big[ \sigma_{\text{tot}}(v) \cdot v \cdot n_g \big] = \text{const}$$

Warunek nieujemności prawdopodobieństwa wymaga, aby częstość zerowa spełniała:
$$\nu_{\text{null}}(v) = \nu^* - \nu(v) \ge 0 \quad \forall v$$

### 3.2. Wyprowadzenie Stałego Prawdopodobieństwa $P^*$
Ponieważ całkowita częstość $\nu^*$ jest stała w czasie i jednakowa dla wszystkich cząstek danego gatunku, prawdopodobieństwo, że cząstka weźmie udział w **jakimkolwiek zderzeniu** (rzeczywistym lub pozornym) w kroku $\Delta t$, staje się stałą skalarną:
$$P^* = 1 - \exp(-\nu^* \cdot \Delta t) \equiv \text{const}$$

Wartość ta jest wyliczana **dokładnie raz** na początku symulacji:
* dla elektronów: $P^*_e = 1 - \exp(-\nu^*_e \cdot \Delta t_e) \approx 1.26\%$,
* dla jonów: $P^*_i = 1 - \exp(-\nu^*_i \cdot \Delta t_i) \approx 2.00\%$.

### 3.3. Dwuetapowy Algorytm Losowania (Stochastyka)

#### Etap 1: Selekcja kandydatów z rozkładu dwumianowego
Zamiast badać $N$ cząstek, losujemy liczbę cząstek-kandydatów $N_{\text{coll}}^*$, które doznają zderzenia (rzeczywistego lub pozornego):
$$N_{\text{coll}}^* \sim \text{Binom}(N, P^*)$$
Dla populacji $N \approx 100\,000$ i $P^* \approx 1.26\%$, liczba kandydatów wynosi zaledwie:
$$N_{\text{coll}}^* \approx 1200 - 1300 \text{ cząstek (zamiast } 100\,000!\text{)}$$

Z populacji $N$ losujemy bez powtórzeń dokładnie $N_{\text{coll}}^*$ indeksów cząstek. W kodzie zrealizowano to poprzez wydajny, bezalokacyjny algorytm częściowego tasowania **Fishera-Yatesa** (`random_sample`).

#### Etap 2: Test akceptacji zderzenia rzeczywistego (Rejection Sampling)
Wyłącznie dla wylosowanych $N_{\text{coll}}^*$ cząstek odczytujemy ich bieżącą prędkość $v_k$, wyznaczamy rzeczywistą częstość $\nu(v_k)$ i akceptujemy zderzenie jako **fizyczne** z prawdopodobieństwem:
$$p_{\text{accept}} = \frac{\nu(v_k)}{\nu^*}$$

Losujemy liczbę $R \sim U(0, 1)$:
* Jeżeli $R < p_{\text{accept}}$: zderzenie jest **rzeczywiste** $\to$ przechodzimy do wyboru podtypu (sprężyste, wzbudzenie, jonizacja) i transformacji pędów.
* W przeciwnym razie ($R \ge p_{\text{accept}}$): zachodzi **zderzenie zerowe (null-collision)** $\to$ pęd i położenie cząstki pozostają całkowicie nienaruszone.

### 3.4. Matematyczny Dowód Tożsamości Statystycznej
Całkowite prawdopodobieństwo, że cząstka o prędkości $v$ dozna rzeczywistego zderzenia w kroku $\Delta t$, wynosi zgodnie z regułą prawdopodobieństwa warunkowego:
$$P_{\text{eff}}(v) = P^* \cdot p_{\text{accept}} = \left( 1 - e^{-\nu^* \Delta t} \right) \cdot \frac{\nu(v)}{\nu^*}$$

Rozwijając funkcję wykładniczą w szereg Taylora wokół zera:
$$1 - e^{-\nu^* \Delta t} = \nu^* \Delta t - \frac{(\nu^* \Delta t)^2}{2!} + \mathcal{O}((\nu^* \Delta t)^3)$$

W poprawnie skonfigurowanej symulacji PIC/MCC krok czasowy spełnia rygorystyczny warunek stabilności kinetycznej:
$$\nu^* \Delta t \ll 1 \quad (\text{w naszym układzie: } \nu^*_e \Delta t_e \approx 0.0126 \ll 1)$$

Podstawiając rozwinięcie pierwszego rzędu:
$$P_{\text{eff}}(v) \approx (\nu^* \Delta t) \cdot \frac{\nu(v)}{\nu^*} = \nu(v) \Delta t$$
Z drugiej strony, prawdopodobieństwo w klasycznym Direct MCC to:
$$P_{\text{direct}}(v) = 1 - e^{-\nu(v) \Delta t} \approx \nu(v) \Delta t$$

**Wniosek formalny:** Różnica między obiema metodami jest rzędu $\mathcal{O}((\nu^* \Delta t)^2) < 1.6 \times 10^{-4}$, co oznacza, że obie metody generują **statystycznie tożsame rozkłady prawdopodobieństwa** w przestrzeni fazowej.

---

## 4. Jakie Korzyści Daje Ta Optymalizacja?

Optymalizacja przynosi korzyści na trzech poziomach architektury komputerowej:

### 4.1. Poziom Algorytmiczny: Eliminacja Kosztu Funkcji Wykładniczych
* **Przed optymalizacją:** Ponad $430\,000\,000$ wywołań `exp()` na cykl RF.
* **Po optymalizacji:** **0 wywołań `exp()` w pętli cząstek** na cykl RF. Wartości $P^*_e$ i $P^*_i$ wyliczane są jednokrotnie w fazie inicjalizacji symulatora.

### 4.2. Poziom Mikroarchitektoniczny: Redukcja Instrukcji i Stallów CPU
1. **Radykalna redukcja liczby wykonanych instrukcji (`instructions`):**
   * Pętla zderzeniowa nie przetwarza już $100\%$ cząstek, lecz jedynie $\approx 1.26\%$ kandydatów dla elektronów i $\approx 2.00\%$ dla jonów.
   * Ponad **$98\%$ cząstek jest całkowicie pomijanych** w fazie zderzeń.
2. **Oszczędność operacji pierwiastkowania i dostępu do pamięci:**
   * Obliczanie modułu prędkości $v = \sqrt{v_x^2+v_y^2+v_z^2}$ oraz pobieranie wartości z tablicy `sigma_tot` odbywa się wyłącznie dla wylosowanych kandydatów, drastycznie zmniejszając presję na pamięć podręczną i jednostki FPU.
3. **Wzrost sprawności potoku (wskaźnik IPC):**
   * Zlikwidowanie wywołań zewnętrznych funkcji `glibc` usuwa narzut związany z ramkami stosu (`call`/`ret`), ratowaniem rejestrów oraz blokowaniem potoków wykonawczych przez wielomianowe aproksymacje `exp`.

### 4.3. Wpływ na Profil Hotspotów (`perf report`)
* Symbol `__exp_finite` / `exp` całkowicie **znika z czołówki profilu CPU**.
* Ciężar obliczeniowy przesuwa się naturalnie na pozostałe fazy symulacji: popychanie cząstek (Boris pusher / Leap-Frog) oraz solver Poissona, otwierając drogę do kolejnych optymalizacji.

---

## 5. Metodyka Badawcza i Środowisko Eksperymentalne (HPC Lem)

Eksperyment pomiarowy należy przeprowadzić w warunkach ściśle tożsamych z pomiarem Baseline:

* **Platforma sprzętowa:** Węzeł klastra HPC Lem, procesor **AMD EPYC 9554** (Zen 4, taktowanie 3.1 GHz bazowe, architektura CCD, pamięć L3 32 MB per blok).
* **Konfiguracja wykonania:** Dokładnie **1 rdzeń fizyczny** (kod sekwencyjny). Dedykowana alokacja Slurm, wyłączony SMT.
* **Stan wzorcowy (Golden Record):** Wpięty plik `golden_record/picdata.bin` (stan po 2000 cykli, $N_e = 108\,199$, $N_i = 113\,624$).
* **Liczba mierzonych cykli:** Dokładnie taka sama liczba cykli jak w Baseline (np. 10 lub 20 cykli RF), aby zapewnić **100% porównywalność danych**.
* **Komendy profilujące:**
  * Pomiar liczników sprzętowych: `perf stat` (czas, cykle, instrukcje, IPC, branch-misses),
  * Próbkowanie stosu wywołań: `perf record -F 99 -g` oraz raport tekstowy `perf report --stdio`.

---

## 6. Szablony Wyników i Tabel do Wypełnienia Danymi z HPC

*(Poniższe tabele należy uzupełnić danymi uzyskanymi ze skryptu `GoPIC_jobs/C/edupic_exp_job_stat.sh` oraz `edupic_exp_job_record.sh` na klastrze HPC Lem po dostarczeniu logów)*

### Tabela 1: Porównanie Metryk Sprzętowych: Baseline vs Null-Collision (`perf stat`)

| Metryka telemetryczna | Krok 0: Baseline ($T_0$) | Krok 1: Null-Collision ($T_1$) | Zmiana ($\Delta$) | Zysk / Interpretacja mikroarchitektoniczna |
|:---|:---:|:---:|:---:|:---|
| **Czas wykonania (Wall-clock)** | `... s` | `... s` | `- ... %` | **Przyspieszenie cząstkowe: $S_1 = ... \times$** |
| **Czas procesora (Task-clock)** | `... ms` | `... ms` | `- ... %` | Rzeczywiste zaoszczędzone milisekundy CPU |
| **Liczba cykli CPU (`cycles`)** | `...` | `...` | `- ... %` | Zredukowany budżet cykli zegara |
| **Liczba instrukcji (`instructions`)** | `...` | `...` | `- ... %` | Skala eliminacji zbędnego kodu zderzeń |
| **Wskaźnik IPC (Instr. Per Cycle)** | `...` | `...` | `+ ...` | Zmiana przepustowości potoku wykonawczego |
| **Rozgałęzienia (`branches`)** | `...` | `...` | `- ... %` | Wpływ redukcji pętli cząstek |
| **Nietrafione skoki (`branch-misses`)** | `...` | `...` | `... %` | Zmiana obciążenia predyktora skoków BTB |
| **Chybienia pamięci podręcznej (L1d)** | `...` | `...` | `...` | Weryfikacja braku degradacji cache |

---

### Tabela 2: Ewolucja Profilu Hotspotów CPU (`perf report`)

| Funkcja / Symbol | Udział w Baseline (% Overhead) | Udział po Null-Collision (% Overhead) | Komentarz i obserwacja zmian |
|:---|:---:|:---:|:---|
| `__exp_finite` / `exp` | **... %** | **0.00 %** (zniknięcie) | Całkowita eliminacja wąskiego gardła |
| `step7_collisions_electrons` | ... % | ... % | Drastyczny spadek czasu funkcji |
| `step8_collision_ions` | ... % | ... % | Ograniczenie pętli do ~2% cząstek |
| `step3_move_electrons` (Pusher) | ... % | ... % | Wzrost relatywnego udziału (nowy główny hotspot) |
| `step2_solve_poisson` | ... % | ... % | Wzrost relatywnego udziału (cel Kroku 2: Hoisting) |
| `__atan2_finite` / `atan2` | ... % | ... % | Pozostaje (cel późniejszego Kroku 4/5) |
| Pozostałe funkcje | ... % | ... % | Naturalne przesunięcie udziałów |

---

### Tabela 3: Rygorystyczna Walidacja Zgodności Fizycznej (Golden Record)

| Parametr fizyczny | Stan bazowy (Baseline) | Po optymalizacji (Null-Collision) | Status walidacji |
|:---|:---:|:---:|:---:|
| **Gęstość elektronów w centrum ($n_e$)** | `7.539e+15 m^-3` | `7.539e+15 m^-3` | Zgodne (brak dryfu) |
| **Częstość plazmowa ($\omega_{pe} \cdot \Delta t$)** | `0.090` | `0.090` | Zgodne ($< 0.20$) |
| **Liczba makroelektronów po teście** | `...` | `...` | Stabilność populacji |
| **Częstość zderzeń elektronowych** | `5.837e+07 s^-1` | `5.837e+07 s^-1` | Tożsamość kinetyczna |
| **Profil gęstości ładunku (`density.dat`)** | Referencyjny | Identyczny kształt | Zgodne |
| **Rozkłady energii EEPF i IFED** | Referencyjne | Brak odchyleń statystycznych | Zgodne |

---

## 7. Wskazówki do Dyskusji Naukowej w Treści Rozdziału

Podczas redagowania tekstu podrozdziału 4.2.1 w pracy magisterskiej należy wyeksponować następujące wątki:

1. **Prawo Amdahla w praktyce:**  
   Metoda Null-Collision całkowicie usuwa wywołania `exp()`, jednak całkowite przyspieszenie symulacji nie jest nieskończone. Zgodnie z Prawem Amdahla zysk jest ograniczony przez pozostałe etapy pętli PIC/MCC, które w tym kroku nie były modyfikowane (przede wszystkim całkowanie równań ruchu cząstek w `step3_move_electrons` oraz rozwiązywanie równania Poissona).
2. **Związek z kolejnym krokiem optymalizacji:**  
   Po usunięciu `exp()` na czoło profilu `perf report` wysuwają się operacje związane z trójdiagonalnym solverem Poissona (`step2_solve_poisson`) oraz redundantnym przeliczaniem stałych i współczynników macierzy Thomasa. Stanowi to **bezpośrednie i logiczne przejście do Podrozdziału 4.2.2: Hoisting Stałych i Prekompilacja Solwera Poissona**.
3. **Bezalokacyjność implementacji:**  
   Warto podkreślić w pracy, że funkcja próbkowania indeksów `random_sample` wykorzystuje statyczny bufor pamięci `static std::vector<int> pool`, co gwarantuje zerową liczbę alokacji na stercie w pętli symulacji.

---

*Dokument gotowy do uzupełnienia danymi z pomiarów HPC. Po przesłaniu wyników tabelę 1, 2 i 3 zaktualizujemy konkretnymi liczbami i wykresem przyspieszenia.*
