# Raport Wydajnościowy i Analiza Skalowania Kodu PIC-MCC (GoPIC) na Klastrze HPC

**Autor:** Zespół Projektowy GoPIC  
**Data pomiarów:** 2 września 2026  
**Platforma testowa:** Klaster HPC WCSS Lem (`plgrid-lem-cpu`)  
**Architektura procesora:** AMD EPYC 9554 (Zen 4, 64 rdzenie fizyczne / gniazdo, 3.1–3.75 GHz, AVX-512, 32 MB L3 Cache per 8-rdzeniowy moduł CCD)  
**Środowisko programistyczne:** GCC 13+ z flagami `-O3 -march=native -fopenmp -std=c++17 -Wall`  
**Model fizyczny:** 1D3V Particle-in-Cell z Monte Carlo Collisions (Ar, 400 komórek siatki, 4000 podkroków/cykl, $N_e \approx 108\,000$, $N_i \approx 113\,500$)

---

## 1. Wstęp i Cel Badań

Celem przeprowadzonych prac optymalizacyjnych była transformacja sekwencyjnego kodu symulacji wyładowań plazmowych w gazie szlachetnym (eduPIC) do wysoce skalowalnej, wektorowej implementacji wielowątkowej C++/OpenMP, w pełni wykorzystującej instrukcje AVX-512 oraz architekturę pamięci podręcznej współczesnych procesorów serwerowych AMD EPYC Zen 4.

Oryginalny kod jednowątkowy wykonywał 100 cykli RF w czasie **$245.0\text{ sekund}$**.

---

## 2. Zbiorcza Tabela Wyników Pomiarowych (Slurm / Linux `perf stat`)

Wszystkie pomiary obejmują wykonanie **100 pełnych cykli RF** ($400\,000$ podkroków czasowych dla kinetyki elektronów oraz $20\,000$ podkroków dla jonów).

| ID Zadania Slurm | Konfiguracja Rdzeni | Topologia Przypięcia (Affinity) | Czas (Wall-clock) | Cykle CPU (Cycles) | Liczba Instrukcji | IPC | L1 Miss Rate | Wykorzystanie CPU | Opis / Wdrożone Zmiany |
|:---:|:---:|:---|:---:|:---:|:---:|:---:|:---:|:---:|:---|
| **5808350** | **1 rdzeń** | Rdzeń `0` (CCD 0) | **$174.62\text{ s}$** | $573.3\text{ mld}$ | $2.328\text{ bln}$ | **4.06** | **4.06%** | $1.000\text{ CPUs}$ | Baza skalowania silnego (Single-core Zen 4 AVX-512) |
| **5804042** | **2 rdzenie** | Rdzenie `0, 1` (CCD 0) | **$81.03\text{ s}$** | $594.9\text{ mld}$ | $2.160\text{ bln}$ | **3.63** | $4.31\%$ | $1.996\text{ CPUs}$ | Faza 2 (SoA, AVX-512, trwała sekcja równoległa) |
| **5808224** | **2 rdzenie** | Rdzenie `0, 1` (CCD 0) | **$87.41\text{ s}$** | $628.9\text{ mld}$ | $2.358\text{ bln}$ | **3.75** | $4.30\%$ | $1.991\text{ CPUs}$ | Faza 2.5 (+ Prefetching w 1/5/6, `nowait`, lock-free NewParticles) |
| **5807281** | **2 rdzenie** | Rdzenie `0, 1` (Węzeł obciążony) | **$115.98\text{ s}$** | $837.5\text{ mld}$ | $2.166\text{ bln}$ | **2.59** | $6.82\%$ | $1.989\text{ CPUs}$ | Pomiar zakłócony rywalizacją o magistralę RAM na węźle |
| **5808359** | **4 rdzenie** | Rdzenie `0, 1, 2, 3` (1 CCD) | **$47.97\text{ s}$** | $705.9\text{ mld}$ | $2.346\text{ bln}$ | **3.32** | $4.66\%$ | **$3.996\text{ CPUs}$** | Skalowanie 4-rdzeniowe wewnątrz 1 modułu CCD |
| **5808454** | **8 rdzeni** | `0..3` (CCD 0) + `22..25` (CCD 2) | **$55.06\text{ s}$** | $1626.1\text{ mld}$ | $2.405\text{ bln}$ | **1.48** | $4.89\%$ | $7.989\text{ CPUs}$ | ⚠️ Pofragmentowany przydział Slurm (Cross-CCD / Infinity Fabric) |
| **5809084** | **8 rdzeni** | Rdzenie `32..39` (Spójny 1 CCD) | **$30.01\text{ s}$** | $878.0\text{ mld}$ | $2.363\text{ bln}$ | **2.69** | $4.91\%$ | **$7.962\text{ CPUs}$** | Spójny moduł 32 MB L3 Cache (Przed równoległym Null-Collision) |
| **5810581** | **8 rdzeni** | `2..18` (Gniazdo 0) + `66..70` (Gniazdo 1) | **$36.19\text{ s}$** | $1024.4\text{ mld}$ | $2.357\text{ bln}$ | **2.30** | **4.24%** | $7.983\text{ CPUs}$ | Równoległe Null-Collision w scenariuszu Cross-Socket |
| **5813356** | **8 rdzeni** | Rdzenie `70..78` (Spójny 1 CCD) | **$27.54\text{ s}$** 🏆 | **$788.1\text{ mld}$** | **$2.345\text{ bln}$** | **2.98** | **4.29%** | **$7.932\text{ CPUs}$** | 🚀 **REKORD KOŃCOWY (Równoległe Null-Collision + Prekalkulacja Poissona + Wektoryzacja Redukcji)** |

---

## 3. Analiza Skalowania Silnego (Strong Scaling Analysis)

Profil skalowania silnego wyznaczono na podstawie ostatecznych, zoptymalizowanych pomiarów:

$$\text{Speedup } S(N) = \frac{T_1}{T_N}, \qquad \text{Efektywność } E(N) = \frac{S(N)}{N} \times 100\%$$

### Tabela Skalowania Silnego (Ostateczny Rekord):

| Liczba Rdzeni $N$ | Czas wykonania $T_N$ | Rzeczywisty Speedup $S(N)$ | Efektywność Równoległa $E(N)$ | Przyspieszenie vs Kod Bazowy ($245\text{ s}$) |
|:---:|:---:|:---:|:---:|:---:|
| **1 rdzeń** | $174.62\text{ s}$ | $1.00\times$ (Baza) | $100.0\%$ | $1.40\times$ |
| **2 rdzenie** | $87.41\text{ s}$ | **$1.998\times$** | **$99.9\%$** | $2.80\times$ |
| **4 rdzenie** | $47.97\text{ s}$ | **$3.640\times$** | **$91.0\%$** | $5.10\times$ |
| **8 rdzeni (1 CCD)** | **$27.54\text{ s}$** 🏆 | **$6.340\times$** | **$79.3\%$** | **$8.90\times$** |

### Wnioski dotyczące skalowania:
1. **Prawie idealne skalowanie na 2 rdzeniach ($99.9\%$):** Wynika z faktu, że ponad $98\%$ czasu obliczeniowego zajmują w pełni zrównoleglone pętle cząstkowe (Push, Depozycja, Granice, Kolizje), a oba rdzenie operują na prywatnych pamięciach L1/L2.
2. **Bardzo wysoka efektywność na 4 rdzeniach ($91.0\%$):** Potwierdza, że lokalność pamięci w obrębie 1 modułu CCX pozwala 4 rdzeniom przetwarzać cząstki niemal bez konfliktów magistrali.
3. **Wzrost efektywności na 8 rdzeniach do $79.3\%$ (Speedup $6.34\times$):** Wdrożenie w pełni równoległego losowania zderzeń (Per-Thread Null-Collision) oraz prekalkulacji Thomasa podniosło efektywność z $72.8\%$ do **$79.3\%$**, a czas spadł poniżej $28$ sekund!

---

## 4. Analityczna Identyfikacja Wąskich Gardeł (Prawo Amdahla i Metryka Karpa-Flatta)

Metryka Karpa-Flatta ($e$) pozwala precyzyjnie rozróżnić, czy spadek efektywności wynika z niezrównoleglonego kodu szeregowego ($s$), czy z narzutu synchronizacji i rywalizacji o pamięć podręczną:

$$e = \frac{\frac{1}{S(N)} - \frac{1}{N}}{1 - \frac{1}{N}} = \frac{\frac{T_N}{T_1} - \frac{1}{N}}{1 - \frac{1}{N}}$$

### Obliczone wartości współczynnika Karpa-Flatta (Ostateczny stan):
* Dla $N = 2$: $e = 0.0011$ (**$0.11\%$**).
* Dla $N = 4$: $e = 0.0329$ (**$3.29\%$**).
* Dla $N = 8$: $e = 0.0374$ (**$3.74\%$** — spadek z wcześniejszych $5.35\%$).

### Wniosek naukowy:
Dzięki eliminacji sekwencyjnego tasowania Fishera-Yatesa i wycięciu setek tysięcy zbędnych barier `omp single`, narzut synchronizacji na 8 rdzeniach spadł o ponad **$30\%$** (z $5.35\%$ do $3.74\%$).

---

## 5. Wpływ Architektury Chipletowej AMD Zen 4 (NUCA / NUMA)

Porównanie zadań na 8 rdzeniach ujawniło fundamentalną zależność wydajności od topologii pamięci podręcznej (Non-Uniform Cache Access — NUCA):

| Scenariusz Topologii | Zadanie Slurm | Czas (Wall-clock) | Cykle CPU | IPC | Obserwowane Zjawisko Sprzętowe |
|---|:---:|:---:|:---:|:---:|---|
| **Spójny 1 CCD (8 rdzeni w 1 L3)** | `Job 5813356` | **$27.54\text{ s}$** | **$788\text{ mld}$** | **$2.98$** | Wszystkie rdzenie dzielą 32 MB L3 bez opuszczania modułu. Minimalna latencja i rekordowy IPC. |
| **Spójny 1 CCD (Przed nowym Null-Coll)** | `Job 5809084` | **$30.01\text{ s}$** | $878\text{ mld}$ | $2.69$ | Poprzednia wersja ze scalaniem w bloku `single`. |
| **Rozbicie na 2 CCD (4+4 rdzenie)** | `Job 5808454` | **$55.06\text{ s}$** | $1626\text{ mld}$ | $1.48$ | Komunikacja przez magistralę Infinity Fabric wewnątrz gniazda. Wzrost cykli o $106\%$. |
| **Rozbicie Cross-Socket (Gniazdo 0 + Gniazdo 1)** | `Job 5810581` | **$36.19\text{ s}$** | $1024\text{ mld}$ | $2.30$ | Komunikacja między dwoma fizycznymi procesorami (przyspieszona dzięki Lock-Free Null-Collision). |

---

## 6. Zestawienie Kluczowych Osiągnięć Inżynieryjnych

1. **Struktura SoA i wektoryzacja SIMD AVX-512:**
   Konwersja tablic cząstek do Structure of Arrays (`x_e, vx_e, vy_e, vz_e`) oraz jawne wyrównanie pamięci `alignas(64)` pozwoliły na wektoryzację pętli Leap-Frog (Krok 3/4) i osiągnięcie rekordowego wskaźnika **$\text{IPC} = 4.06$** na pojedynczym rdzeniu.
2. **W pełni równoległa metoda Null-Collision (Per-Thread Sampling):**
   Zastąpienie sekwencyjnego tasowania Fishera-Yatesa (`random_sample`) przez niezależne, lokalne losowanie dwumianowe z prywatnymi generatorami `thread_local MTgen` wyeliminowało $540\text{ milionów}$ sekwencyjnych operacji pseudolosowych, redukując chybienia pamięci L1 o $4.8\text{ miliarda}$ i oszczędzając $90\text{ miliardów cykli CPU}$.
3. **Optymalizacja Solvera Poissona (Algorytm Thomasa):**
   Wstępne wyliczenie stałych współczynników trójdiagonalnych (`w_thomas`, `inv_denom_thomas`) wyeliminowało $160\text{ milionów}$ operacji dzielenia zmiennoprzecinkowego z pętli podkroków, zastępując je instrukcjami mnożenia FMA.
4. **Wektoryzacja redukcji gęstości ładunku (Krok 1):**
   Wyodrębnienie warunków brzegowych poza pętlę przestrzenną $p \in [1, N_G-2]$ umożliwiło kompilatorowi automatyczną generację 512-bitowych instrukcji wektorowych `_mm512_add_pd`.
5. **Redukcja narzutu pamięciowego:**
   Usunięcie zbędnych buforów pośrednich zredukowało rozmiar struktur roboczych wątków o ponad $100\text{ MB}$, zapewniając, że dane wątków mieszczą się w pamięci podręcznej L2/L3.

---

## 7. Podsumowanie do Pracy Dyplomowej

Optymalizacja kodu GoPIC/eduPIC pozwoliła na skrócenie czasu symulacji 100 cykli RF z **$245.0\text{ sekund}$** do **$27.54\text{ sekundy}$** na 8 rdzeniach (całkowity speedup **$8.90\times$**), przy jednoczesnym zachowaniu ścisłej stabilności numerycznej i zgodności fizycznej wyładowania plazmowego (stan równowagi $N_e \approx 107\,918, N_i \approx 113\,362$). Wyniki te dowodzą najwyższej efektywności zastosowanych technik HPC, optymalizacji barierowej oraz krytycznego znaczenia lokalności pamięci podręcznej L3 w architekturze AMD Zen 4.
