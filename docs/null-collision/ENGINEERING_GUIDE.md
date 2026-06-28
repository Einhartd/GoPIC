# Metoda Null-Collision w Symulacjach PIC/MCC — Przewodnik dla Inżyniera

> **Dotyczy**: eduPIC / GoPIC — implementacje C++, Python, Go  
> **Źródło**: Donko et al., PSST vol 30, 095017 (2021) — sekcje 2.1 i 5

---

## 1. Problem: Koszt Obliczeniowy Standardowego MCC

W obecnej implementacji eduPIC każda cząstka w każdym kroku czasowym przechodzi przez sekwencję operacji:

```
1. Oblicz v² = vx² + vy² + vz²          → 3 mnożenia, 2 dodawania
2. velocity = sqrt(v²)                    → kosztowny pierwiastek
3. energy = 0.5 × m × v² / EV_TO_J      → mnożenie
4. e_idx = int(energy / DE_CS + 0.5)     → dzielenie + rzutowanie
5. nu = sigma_tot[e_idx] × velocity      → lookup + mnożenie
6. p_coll = 1 - exp(-nu × Δt)           → KOSZTOWNA funkcja exp()
7. r = rng.random()                       → losowanie
8. if r < p_coll: collision_handler()    → warunkowe wywołanie
```

Krok 6 — wywołanie `exp()` — jest **dominującym kosztem** dla każdej cząstki. Przy $N_e \approx 50\,000$ cząstek i $N_T = 4000$ krokach na cykl, w jednym cyklu RF wykonuje się **200 milionów wywołań `exp()`**. To koszt, który wprost przekłada się na czas symulacji.

### Co mówi artykuł (Donko et al., 2021)?

> "One needs to check the collision probability of each particle in every time step using the computationally expensive mathematical expression. A more efficient selection of the colliding particles can be accomplished by the **null-collision method**, where the number of colliding particles is given as $N_{coll}^* = N \cdot P_{coll}^*$, where $P_{coll}^* = \exp(-\nu^* \Delta t)$. Here $\nu^* = \max\{n\sigma_{tot}g\}$ is the maximum collision frequency over the domains of interest."

Autorzy celowo **nie implementują** tej metody w eduPIC — "for simplicity" — ale sugerują ją jako pierwsze i najważniejsze usprawnienie wydajnościowe.

---

## 2. Zasada Metody Null-Collision

### 2.1 Standardowe MCC (obecna implementacja)

Per-cząstka: oblicz $P_{coll}(v_k)$, wylosuj $r$, decyduj o kolizji.

$$P_{coll}(v_k) = 1 - \exp\left(-\nu_{tot}(v_k) \cdot \Delta t\right)$$

**Koszt**: $N$ wywołań `exp()` + $N$ losowań — dla *każdego* kroku.

### 2.2 Metoda Null-Collision

Kluczowa obserwacja: zamiast liczyć $P_{coll}$ dla każdej cząstki indywidualnie, używamy **globalnego górnego ograniczenia** częstości kolizji:

$$\nu^* = \max_{\text{wszystkie energie}} \left\{ n_g \cdot \sigma_{tot}(\varepsilon) \cdot v(\varepsilon) \right\}$$

To jest wartość stała — obliczana raz przed pętlą główną i niezmienna w trakcie symulacji (bo $\sigma_{tot}$, $n_g$ i zakres energii są stałe).

Odpowiadające jej **maksymalne prawdopodobieństwo kolizji**:

$$P^* = 1 - \exp(-\nu^* \Delta t)$$

— również wartość stała, obliczana raz.

#### Algorytm na każdy krok:

```
PRECOMPUTED (raz przed pętlą):
  nu_star = max over all energies { sigma_tot[i] * v(i) }
  P_star = 1 - exp(-nu_star * dt)

PER STEP — metoda Bernoulli:
  N_coll_star = N * P_star           // liczba "kandydatów" do kolizji

  // Losowanie N_coll_star cząstek (bez powtórzeń)
  selected = random_sample(N, count=N_coll_star)

  for each k in selected:
    // Oblicz RZECZYWISTE p_coll dla tej cząstki
    real_nu = sigma_tot[energy_index(k)] * velocity[k]
    real_p  = real_nu / nu_star          // prawdopodobieństwo warunkowe

    if rng.random() < real_p:
       collision_handler(k)              // RZECZYWISTA kolizja
    // else: kolizja "zerowa" — cząstka przelatuje bez zmiany
```

### 2.3 Dlaczego to działa matematycznie?

Metoda jest **statystycznie równoważna** standardowemu MCC:

Łączne prawdopodobieństwo, że cząstka $k$ zostanie wybrana ORAZ przejdzie test warunkowy:

$$P_{coll}(k) = P^* \cdot \frac{\nu(v_k)}{\nu^*} = \left(1 - e^{-\nu^* \Delta t}\right) \cdot \frac{\nu(v_k)}{\nu^*}$$

Gdy $\nu^* \Delta t \ll 1$ (co jest gwarantowane przez warunek stabilności $P_{coll} < 0.05$):

$$P^* \approx \nu^* \Delta t$$

$$P_{coll}(k) \approx \nu(v_k) \Delta t = 1 - e^{-\nu(v_k) \Delta t}$$

— co jest dokładnie oryginalną formułą. Aproksymacja jest dokładna dla małych $P$ (co jest zawsze spełnione w stabilnej symulacji).

---

## 3. Gdzie Jest Przyspieszenie?

### 3.1 Eliminacja `exp()` z pętli wewnętrznej

W standardowym MCC: **N wywołań `exp()` per krok**.  
W null-collision: **1 wywołanie `exp()` obliczone raz** (dla $P^*$), dalej tylko operacje arytmetyczne.

`exp()` to jedna z najwolniejszych funkcji matematycznych — typowo 5–20× wolniejsza niż mnożenie na nowoczesnym CPU. Eliminacja jej z pętli wewnętrznej to **dominująca korzyść** tej metody.

### 3.2 Redukcja liczby iteracji kolizyjnych

Tylko $N_{coll}^* \approx N \cdot P^*$ cząstek jest w ogóle branych pod uwagę dla kolizji.  
Przy $P^* \approx 0.05$ (warunek stabilności) — to maksymalnie 5% cząstek.

Zamiast iterować po **100%** cząstek i sprawdzać każdą: iterujemy po **~5%** i dla każdej wykonujemy jedno porównanie arytmetyczne.

### 3.3 Wektoryzowalność (bonus dla NumPy/SIMD)

Standard: każda cząstka wymaga osobnego `exp()` — trudne do wektoryzacji.  
Null-collision: $N_{coll}^*$ oblicza się jak liczba prób Bernoulliego, losowanie $N_{coll}^*$ cząstek ze zbioru $N$ to dobrze wektoryzowalna operacja (`np.random.choice` lub `np.where`).

### 3.4 Szacowane przyspieszenie

| Operacja | Standardowe MCC | Null-Collision |
|:---------|:----------------|:--------------|
| `exp()` per krok | N (np. 50 000) | 0 (precomputed) |
| Iteracje per krok | N (100%) | ~N×P* (≤5%) |
| Dodatkowe losowanie | 1 per cząstka | 1 per kandydat + 1 selekcja |
| **Całkowite przyspieszenie kroku kolizji** | 1× | **10–30×** |

---

## 4. Implementacja — Szczegóły Techniczne

### 4.1 Obliczanie $\nu^*$ — pułapki

$\nu^* = \max_i \{ \sigma_{tot,e}[i] \cdot v(i) \}$ gdzie $v(i) = \sqrt{2 \varepsilon_i / m_e}$ i $\varepsilon_i = i \cdot \Delta \varepsilon$

Już istnieje w kodzie jako `max_electron_coll_freq()` i `max_ion_coll_freq()` — używana do weryfikacji warunków stabilności. Można ją bezpośrednio wykorzystać.

> [!WARNING]
> `nu_star` musi uwzględniać GAS_DENSITY w `sigma_tot`, bo `sigma_tot[i] = sigma_raw[i] × n_g`. Funkcje `max_electron_coll_freq` i `max_ion_coll_freq` w obecnym kodzie używają `sigma_tot`, więc już zawierają $n_g$.

### 4.2 Losowanie $N_{coll}^*$ kandydatów

Liczba kandydatów jest zmienna losowa z rozkładu dwumianowego $\text{Bin}(N, P^*)$.

**Wariant 1 — Dokładny (zalecany)**:
```
N_coll_star ~ Binomial(N_e, P_star)
```
Zamiast obliczać dokładny rozkład dwumianowy, wystarczy zliczać kolejne próby Bernoulliego (pętla lub funkcja biblioteczna).

**Wariant 2 — Aproksymacja Poissona** (dla małych $P^*$):
```
N_coll_star ~ Poisson(N_e * P_star)
```
Dobra aproksymacja gdy $P^* < 0.05$ (co jest gwarantowane przez warunki stabilności).

**Wariant 3 — Deterministyczny zaokrąglony** (prostszy):
```
N_coll_star = round(N_e * P_star) + Bernoulli(fraction_part)
```
Akceptowalny w praktyce dla dużych $N_e$.

### 4.3 Wybór $N_{coll}^*$ cząstek z $N$

**Metoda Fishera-Yatesa** (bez powtórzeń, O(N)):
```
Wybierz N_coll_star losowych indeksów z zakresu [0, N_e)
```
W C++: `std::sample` (C++17).  
W Python: `numpy.random.choice(N_e, size=N_coll_star, replace=False)`.  
W Go: własna implementacja shuffle.

**Uwaga**: Dla małych $P^*$ ($< 0.1$) można losować ZE ZWRACANIEM (próbkowanie Poissona) bez istotnej utraty dokładności — upraszcza implementację.

### 4.4 Test warunkowy dla wybranych cząstek

```
for each k in selected_indices:
    real_nu = sigma_tot[energy_index(k)] * velocity[k]
    r = rng.random()
    if r < real_nu / nu_star:
        collision_handler(k)
```

Klucz: zamiast `exp()` wykonujemy tylko **jedno dzielenie i jedno porównanie**.

### 4.5 Specjalna obsługa jonów

Dla jonów dodatkowa komplikacja: prędkość względna $g = |v_{ion} - v_{atom}|$ zależy od losowo próbkowanej prędkości atomu gazu $v_{atom}$.

**Problem**: Maksimum $\nu^*_i = \max\{n_g \sigma_{tot,i}(g) \cdot g\}$ musi uwzględniać rozkład $g$, który jest splotem rozkładu prędkości jonów i Maxwella.

**Praktyczne rozwiązanie** (konserwatywne): 
$$\nu^*_i = \max_i \{ \sigma_{tot,i}[i] \cdot g_{max}(i) \}$$
Gdzie $g_{max}$ to górna granica prędkości względnej. Wybieramy $g_{max}$ z pewnym marginesem (np. 5σ rozkładu Maxwella + maksymalna prędkość jonu). To gwarantuje $P^* \geq P_{coll}$ dla wszystkich cząstek.

**Alternatywa**: Stosować null-collision tylko dla elektronów (prostsze, tam zysk jest największy), a dla jonów pozostawić standardowe MCC.

---

## 5. Trudności i Potencjalne Problemy

### 5.1 Dobór $\nu^*$ — balans między efektywnością a poprawnością

> [!CAUTION]
> $\nu^*$ MUSI być ściśle większe lub równe $\nu(v_k)$ dla **wszystkich** cząstek w symulacji. Naruszenie tego warunku powoduje **zaniżenie częstości kolizji** — błąd fizyczny trudny do wykrycia bez testów regresyjnych.

Jeśli w trakcie symulacji pojawi się cząstka z energią przekraczającą zakres tabel przekrojów czynnych (`CS_RANGES × DE_CS = 1000 eV`), wyrażenie $\nu / \nu^*$ może przekroczyć 1.0, co prowadzi do błędu. Należy klampować: `min(real_nu / nu_star, 1.0)`.

### 5.2 Zwiększone zużycie RNG

Null-collision wymaga losowania w dwóch miejscach: selekcja $N_{coll}^*$ kandydatów oraz test warunkowy. Standardowe MCC wymaga jednego losowania per cząstka (+ losowania w samym `collision_handler`). Całkowita liczba losowań per krok może być podobna lub nieznacznie wyższa dla null-collision, ale unika kosztownego `exp()`.

### 5.3 Brak 1:1 zgodności z wynikami standardowego MCC

Nawet przy identycznym seedzie RNG, wyniki null-collision i standardowego MCC będą **nieidentyczne** na poziomie pojedynczych trajektorii. Są **statystycznie równoważne** — dają tę samą fizykę zbiorczą — ale nie identyczne numerycznie. Konieczne są testy porównawcze oparte na **statystykach** (EEPF, gęstości, energie), nie na porównaniu wartość-po-wartości.

### 5.4 Jonizacja zmienia $N_e$ w trakcie kroku

Jeśli w trakcie obsługi kolizji dochodzi do jonizacji, $N_e$ rośnie. Indeksy wylosowanych kandydatów mogą stać się niepoprawne (wskazywać poza aktywną część tablicy). Rozwiązanie: losuj kandydatów z $N_e$ na początku kroku, ignoruj nowo dodane cząstki w tej rundzie kolizyjnej.

### 5.5 Implementacja dla jonów jest bardziej złożona

Prędkość względna $g$ jest nieznana przed wylosowaniem prędkości atomu. Przy null-collision: $\nu^*_i$ musi być obliczone jako maksimum po możliwych wartościach $g$, co wymaga a priori oszacowania rozkładu $g$. W uproszczonej wersji można konserwatywnie przyjąć $g_{max}$ jako wielokrotność termicznej prędkości, z marginesem bezpieczeństwa.

---

## 6. Kiedy Warto, a Kiedy Nie Warto Implementować?

### Warto, gdy:
- $N_e$ lub $N_i$ jest duże (>10 000) — im więcej cząstek, tym większy zysk z redukcji wywołań `exp()`
- Symulacja jest długa (wiele cykli RF) — koszt jednorazowego obliczenia $\nu^*$ jest amortyzowany
- Przeprowadzasz badania parametryczne — zmiana ciśnienia, napięcia, częstotliwości nie zmienia $\nu^*$ (to funkcja tabel przekrojów czynnych), więc raz obliczona wartość jest reużywalna

### Mniej opłacalne, gdy:
- Walidacja fizyczna — lepiej mieć prostszy, łatwiej weryfikowalny kod standardowego MCC
- Bardzo mała populacja cząstek — narzut implementacji null-collision może być wyższy niż zysk
- Kod i tak korzysta z GPU/SIMD — inne optymalizacje mogą być efektywniejsze

---

## 7. Podsumowanie

| Aspekt | Standardowe MCC | Null-Collision |
|:-------|:----------------|:--------------|
| **Koszt per krok** | N × exp() | ~0 exp() w pętli |
| **Poprawność** | Dokładna | Statystycznie równoważna |
| **Złożoność implementacji** | Prosta | Umiarkowana |
| **Zysk wydajności (kolizje)** | 1× | **10–30×** |
| **Kompatybilność NumPy** | Częściowa | **Lepsza** (batch selection) |
| **Problem z jonami** | Brak | Wymaga ostrożności z $\nu^*_i$ |
| **Zgodność numeryczna** | Referencyjna | Statystyczna (nie numeryczna) |

Null-collision to **rekomendowane usprawnienie** wskazane przez autorów artykułu (sekcja 5) jako pierwsze zadanie dla czytelnika chcącego rozszerzyć kod. Zysk jest realny i znaczący — eliminacja `exp()` z pętli wewnętrznej to dominująca optymalizacja kroku kolizyjnego.
