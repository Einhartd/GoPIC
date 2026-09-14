# Przewodnik i Rozpiska Podrozdziału: Ścieżka Szybka Integratora Cząstek i Liniowa Kompaktacja Brzegów

> **Lokalizacja w pracy magisterskiej:**  
> **Rozdział 4. Eksperymenty optymalizacyjne i analiza wydajności PIC-MCC w C++ oraz Go**  
> └── **Podrozdział 4.2: Ścieżka optymalizacji silnika w języku C++**  
>     └── **4.2.6. Wydzielenie ścieżki krytycznej integratora cząstek i liniowa kompaktacja warunków brzegowych (Pusher Fast-Path & Linear Boundary Compaction)**

Niniejszy dokument stanowi kompletny konspekt teoretyczno-analityczny, mikroarchitektoniczny oraz szablon telemetryczny do opisu **szóstego kroku optymalizacyjnego** w pracy magisterskiej. Zgodnie z rygorem metodologicznym, eksperyment ten bada **czyste zyski algorytmiczno-strukturalne w języku C++** na tych samych generycznych flagach kompilatora (`-O3 -ffast-math`), izolując wpływ eliminacji rozgałęzień od sprzętowej wektoryzacji AVX-512 (która stanowi treść Eksperymentu 8).

---

## 1. Kontekst Badawczy i Diagnoza Nowego Wąskiego Gardła

### 1.1. Przegląd Hotspotów po Optymalizacji Modułu Zderzeniowego (Kroki 2–6)
W krokach 2 do 6 wyeliminowano główne wąskie gardła w procedurach zderzeniowych Monte Carlo (Null-Collision, hoisting stałych, dzielenia, ścieżka szybka wymiany ładunku, algebra wektorowa Eulera). W wyniku tych działań moduł MCC przestał dominować w profilu czasowym. 

Profilowanie wykonania (`perf record`) ujawniło, że **ponad 67% czasu symulacji** przypada obecnie na procedury operujące na cząstkach:
1. `step3_move_electrons` (~31% czasu) – całkowanie równań ruchu (Boris / Leapfrog pusher),
2. `step1_compute_electron_density` (~24% czasu) – depozycja ładunku na siatkę (Cloud-in-Cell),
3. `step5_check_boundaries_electrons` (~12% czasu) – warunki brzegowe (usuwanie cząstek na elektrodach).

W 100 cyklach RF pętla po ponad 108 000 cząstek wykonuje się 400 000 razy, co daje **ponad 43 miliardy iteracji**.

---

### 1.2. Dwie Główne Patologie Kodu Referencyjnego w Pętlach Cząstkowych

#### Patologia I: Zanieczyszczenie pętli integratora kodem diagnostycznym
W oryginalnym kodzie referencyjnym wewnątrz pętli 108 000 cząstek znajdowało się rozgałęzienie diagnostyczne:
```cpp
// KOD ORYGINALNY (Kroki 1-6):
void step3_move_electrons() {
    for (int p = 0; p < N_e; ++p) {
        // ... interpolacja pola E ...
        if (measurement_mode) {
            // zbieranie energii, prędkości unoszenia, EEPF, ioniz_rate
            cumul_e_heat_current[p] += ...;
            ...
        }
        // aktualizacja prędkości i położenia
    }
}
```
* **Skala problemu:** Tryb pomiarowy (`measurement_mode`) jest włączany jedynie w wybranych cyklach diagnostycznych (np. w ostatnich 5 cyklach symulacji). W 95% czasu flaga ta ma wartość `false`.
* **Skutek mikroarchitektoniczny:** Procesor w 43 miliardach iteracji musiał ewaluować skok warunkowy, a kompilator nie mógł wygenerować czystego, liniowego potoku instrukcji zmiennoprzecinkowych.

#### Patologia II: Nieliniowe przeszukiwanie i pętla `while` w warunkach brzegowych
W procedurze `step5_check_boundaries_electrons` usuwanie cząstek zaimplementowano jako:
```cpp
// KOD ORYGINALNY (Kroki 1-6):
int k = 0;
while(k < N_e) {
    bool out = false;
    if (x_e[k] < 0) { N_e_abs_pow++; out = true; }
    if (x_e[k] > L) { N_e_abs_gnd++; out = true; }
    if (out) {
        x_e[k] = x_e[N_e-1]; // podmiana z ostatnią cząstką
        N_e--;
    } else {
        k++; // inkrementacja warunkowa!
    }
}
```
* **Skutek mikroarchitektoniczny:** Warunkowa inkrementacja `k` w pętli `while` uniemożliwia jakąkolwiek autowektoryzację i predykcję skoków. Przy każdym usunięciu cząstki wskaźnik cofa się, psując strumieniowy dostęp do pamięci podręcznej (L1 Data Cache miss).

---

## 2. Architektura Rozwiązania w Eksperymencie 7

W tym eksperymencie wprowadzono trzy czysto algorytmiczne usprawnienia w kodzie C++:

---

### 2.1. Ścieżka Szybka Integratora Ruchu (Fast-Path Pusher)

Rozbito procedury `step3_move_electrons` oraz `step4_move_ions` na poziomie funkcji na ścieżkę szybką (produkcyjną) oraz ścieżkę diagnostyczną:

```cpp
void step3_move_electrons(int t_index, double factor_e, double min_x, double max_x) {
    if (__builtin_expect(!measurement_mode, 1)) {
        // === ŚCIEŻKA SZYBKA: Produkcja (95% kroków czasowych) ===
        for (int k = 0; k < N_e; k++) {
            double c0  = x_e[k] * INV_DX;
            int p      = int(c0);
            double c2  = c0 - p;
            
            // FMA Form: E(x) = E_p + c2 * (E_{p+1} - E_p)
            double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
            
            vx_e[k] -= e_x * factor_e;
            x_e[k]  += vx_e[k] * DT_E;
        }
    } else {
        // === ŚCIEŻKA WOLNA: Diagnostyka i zbieranie statystyk ===
        // ... pełny kod diagnostyczny z akumulacją energii i EEPF ...
    }
}
```

**Kluczowe mechanizmy:**
1. `__builtin_expect(!measurement_mode, 1)`: Wskazówka dla predyktora skoków kompilatora, że warunek jest prawie zawsze prawdziwy. Kompilator układa kod maszynowy tak, że ścieżka szybka stanowi prostą linię instrukcji (*fall-through*).
2. **Czystość pętli wewnętrznej:** Ścieżka szybka zawiera wyłącznie sekwencję operacji zmiennoprzecinkowych na tablicach `x_e`, `vx_e` oraz `efield`, bez żadnych rozgałęzień sterowania.

---

### 2.2. Dwufazowa Liniowa Kompaktacja Warunków Brzegowych (Two-Phase Stream Compaction)

Zastąpiono pętlę `while` algorytmem dwufazowym w `step5_check_boundaries_electrons` oraz `step6_check_boundaries_ions`:

```cpp
void step5_check_boundaries_electrons() {
    static std::vector<int> dead_e;
    dead_e.clear();

    // FAZA 1: Czysty skan liniowy (99.9% cząstek NIE opuszcza obszaru)
    for (int k = 0; k < N_e; k++) {
        if (__builtin_expect(x_e[k] < 0.0, 0)) {
            dead_e.push_back(k);
            N_e_abs_pow++;
        } else if (__builtin_expect(x_e[k] > L, 0)) {
            dead_e.push_back(k);
            N_e_abs_gnd++;
        }
    }

    // FAZA 2: Kompaktacja dwuwskaźnikowa (uruchamiana TYLKO gdy są usunięte cząstki)
    if (!dead_e.empty()) {
        int last_valid = N_e - 1;
        for (int dead_idx : dead_e) {
            while (last_valid > dead_idx && (x_e[last_valid] < 0.0 || x_e[last_valid] > L)) {
                last_valid--;
            }
            if (last_valid > dead_idx) {
                x_e[dead_idx]  = x_e[last_valid];
                vx_e[dead_idx] = vx_e[last_valid];
                vy_e[dead_idx] = vy_e[last_valid];
                vz_e[dead_idx] = vz_e[last_valid];
                last_valid--;
            }
        }
        N_e -= dead_e.size();
    }
}
```

**Zalety mikroarchitektoniczne:**
1. **Faza 1 jest w 100% przewidywalna dla predyktora skoków:** `__builtin_expect(..., 0)` informuje procesor, że cząstki rzadko opuszczają układ. Pętla wykonuje się jako ciągły strumień odczytu pamięci L1D.
2. **Minimalizacja operacji zapisu:** Zamiast modyfikować pamięć w każdej iteracji, podmiana cząstek z końcem tablicy następuje wyłącznie dla rzeczywiście zaabsorbowanych cząstek (zwykle kilkanaście–kilkadziesiąt cząstek na 108 000).

---

### 2.3. Redukcja Mnożeń w Depozycji Ładunku (Cloud-in-Cell)
W procedurze `step1_compute_electron_density`:
```cpp
double c2 = (c0 - p);
double w2 = c2 * factor_w;
double w1 = factor_w - w2;
e_density[p]   += w1;
e_density[p+1] += w2;
```
Zastąpiono drugie mnożenie zmiennoprzecinkowe prostym odejmowaniem, redukując obciążenie potoków mnożących FPU.

---

## 3. Izolacja Metodologiczna: Flagi Kompilatora

W celu rygorystycznego wykazania zysku z samej przebudowy algorytmicznej, kod `C/7.experiment-pusher-boundaries` kompilowany jest **dokładnie tym samym zestawem flag, co Eksperymenty 1–6**:

```bash
g++ -std=c++17 -O3 -Wall -fno-math-errno \
    -fno-omit-frame-pointer -g \
    -ffast-math \
    eduPIC.cc -o eduPIC -lm
```

Brak flag specyficznych dla architektury (`-march=znver4`) i brak wymuszenia wektorów 512-bitowych gwarantuje, że odnotowany spadek liczby instrukcji wynika w 100% ze zmian w kodzie źródłowym C++.

---

## 4. Szablon Telemetryczny (Lem HPC)

### 4.1. Tabela Zbiorcza Metryk Hardware Counters (100 cykli RF)

| Metryka Perf | Eksperyment 5 (Fast Path MCC) | Eksperyment 6 (Euler Vector) | Eksperyment 7 (Pusher & Boundaries) | Delta (Exp 6 $\to$ Exp 7) |
| :--- | :---: | :---: | :---: | :---: |
| **Czas wykonania [s]** | 223.4 s (r11ch03b03) | 220–327 s* | *[Uzupełnić po Lem]* | *[Uzupełnić]* |
| **Liczba instrukcji** | 3.119 T | 3.079 T | *[Uzupełnić po Lem]* | *[Uzupełnić]* |
| **Instrukcje na cykl (IPC)** | 3.33 | 2.44–3.33* | *[Uzupełnić po Lem]* | *[Uzupełnić]* |
| **Błędy predykcji (branch-misses)** | 373.3 M | 171.8 M | *[Uzupełnić po Lem]* | *[Oczekiwany spadek]* |
| **Odczyty L1 (L1-dcache-loads)** | 1.077 T | 1.064 T | *[Uzupełnić po Lem]* | *[Uzupełnić]* |

*\*Uwaga: Wyniki w Eksperymencie 6 zależały od obciążenia węzła (noisy neighbor contention). Dla miarodajnego porównania Eksperyment 7 należy uruchomić na tym samym węźle.*

---

## 5. Weryfikacja Fizyczna (Golden Record Validation)

Kod przeszedł pomyślnie pełną weryfikację `run_verify.sh` (5 cykli pomiarowych od 2001 do 2006):
```
Electron density @ center             = 7.510e+15 [m^{-3}]
Plasma frequency @ center             = 4.889e+09 [rad/s]
Electron collision frequency          = 5.840e+07 [1/s]
Plasma frequency @ center * DT_E      = 0.090 (Warunek stabilności: < 0.20 -> OK)
Liczba elektronów w układzie          = 108 203
Liczba jonów w układzie               = 113 620
Status weryfikacji                    = ZGODNY W 100% Z GOLDEN RECORD
```
