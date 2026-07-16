# Analiza Złożoności Obliczeniowej i Metryki Wydajności Równoległej

Niniejsze opracowanie zawiera zestawienie złożoności obliczeniowej (Big O) poszczególnych funkcji symulacji eduPIC oraz opis metryk, które pozwolą obiektywnie porównać i ocenić efektywność zrównoleglenia programu.

---

## 1. Złożoność Obliczeniowa (Big O) Funkcji Symulacji

Oznaczenia zmiennych:
*   $N_e$ – liczba elektronów w symulacji (zmienna w czasie, do $1\,000\,000$).
*   $N_i$ – liczba jonów w symulacji (zmienna w czasie, do $1\,000\,000$).
*   $N_G$ – liczba punktów siatki przestrzennej ($N_G = 400$).
*   $N_{sub}$ – parametr subcyklingu jonów ($N_{sub} = 20$, ruch jonów następuje raz na $N_{sub}$ kroków).
*   $N_{coll\_star}$ – liczba kandydatów do zderzenia w metodzie Null-Collision ($N_{coll\_star} \approx P_{star} \cdot N \ll N$).
*   $N_{XT}$ – liczba przedziałów czasowych dla diagnostyk czasoprzestrzennych ($N_{XT} = 200$).

### Zestawienie Złożoności:

| Funkcja | Złożoność Czasowa (Time Complexity) | Złożoność Pamięciowa (Space Complexity) | Opis / Uwagi |
| :--- | :--- | :--- | :--- |
| **`init`** | $O(N_{seed})$ | $O(MAX\_N\_P)$ | Inicjalizacja tablic współrzędnych i prędkości. |
| **`step1_compute_electron_density`** | $O(N_e + N_G)$ | $O(N_G)$ | Czyszczenie tablicy ($O(N_G)$) + Depozycja ładunku ($O(N_e)$). |
| **`step1_compute_ion_density`** | $O(N_i + N_G)$ (co $N_{sub}$ kroków)<br>inaczej $O(N_G)$ | $O(N_G)$ | Wywoływana w pełni tylko przy subcyklingu. Zawsze wykonuje akumulację ($O(N_G)$). |
| **`solve_Poisson`** | $O(N_G)$ | $O(N_G)$ | Algorytm Thomasa (trójprzekątna eliminacja Gaussa) jest liniowy względem $N_G$. |
| **`step3_move_electrons`** | $O(N_e)$ | $O(1)$ | Przesunięcie cząstek + diagnostyki w miejscu. |
| **`step4_move_ions`** | $O(N_i)$ (co $N_{sub}$ kroków)<br>inaczej $O(1)$ | $O(1)$ | Ruch jonów wykonywany tylko podczas subcyklingu. |
| **`step5_check_boundaries_electrons`** | $O(N_e)$ | $O(1)$ | Iteracja po tablicy elektronów i usuwanie cząstek w miejscu. |
| **`step6_check_boundaries_ions`** | $O(N_i)$ (co $N_{sub}$ kroków)<br>inaczej $O(1)$ | $O(1)$ | Filtracja jonów wykonywana tylko podczas subcyklingu. |
| **`step7_collisions_electrons`** | **Null-Collision**: $O(N_{coll\_star\_e})$<br>**Standard**: $O(N_e)$ | $O(N_{coll\_star\_e})$ (Null-Coll)<br>$O(1)$ (Standard) | Metoda Null-Collision redukuje złożoność czasową z $O(N_e)$ do ułamka tej wartości (zazwyczaj $1\% - 5\%$ cząstek trafia do selekcji). |
| **`step8_collision_ions`** | **Null-Collision**: $O(N_{coll\_star\_i})$ (co $N_{sub}$)<br>**Standard**: $O(N_i)$ (co $N_{sub}$) | $O(N_{coll\_star\_i})$ (Null-Coll)<br>$O(1)$ (Standard) | Analogicznie jak dla elektronów, wykonywana podczas subcyklingu. |
| **`step9_collect_xt_data`** | $O(N_G)$ | $O(N_G \cdot N_{XT})$ | Kopiowanie danych siatki do rozkładu czasoprzestrzennego XT. |

---

## 2. Metryki Porównawcze Wydajności Równoległej

Aby precyzyjnie porównać wydajność wersji sekwencyjnej z wersją zrównolegloną na HPC, powinieneś zmierzyć i wyliczyć następujące wskaźniki:

### A. Przyspieszenie (Speedup)
Podstawowy wskaźnik pokazujący, ile razy przyspieszyłeś kod:

$$S(p) = \frac{T_1}{T_p}$$

Gdzie:
*   $T_1$ – czas wykonania programu na 1 rdzeniu.
*   $T_p$ – czas wykonania programu na $p$ rdzeniach.

### B. Efektywność (Efficiency)
Pokazuje procentowe wykorzystanie zasobów obliczeniowych:

$$E(p) = \frac{S(p)}{p} \times 100\%$$

*   Wartość $E(p) = 80\%$ oznacza, że średnio procesory przez 20% czasu stoją bezczynnie (czekanie na pamięć, synchronizację).

### C. Wyznaczenie Rzeczywistego Ułamka Sekwencyjnego (Zmienna Amdahla)
Prawo Amdahla mówi, że przyspieszenie jest ograniczane przez część sekwencyjną kodu $s = 1 - P$. Możesz obliczyć rzeczywistą wartość $s$ na podstawie zmierzonego czasu na $p$ rdzeniach:

$$s = \frac{\frac{1}{S(p)} - \frac{1}{p}}{1 - \frac{1}{p}}$$

*   *Zastosowanie*: Wyliczenie $s$ dla np. 16, 32 i 64 rdzeni pokaże Ci, czy narzut na synchronizację/komunikację rośnie wraz z liczbą wątków (jeśli wartość $s$ rośnie przy większej liczbie rdzeni, oznacza to, że kod ma problem np. z False Sharing lub narzutem na blokady).

### D. Skalowanie Silne (Strong Scaling)
Badanie zachowania programu przy **stałym rozmiarze problemu** (np. $N_e = N_i = 100\,000$) i zwiększaniu liczby rdzeni $p$.
*   *Cel*: Sprawdzenie, przy jakiej liczbie rdzeni przyspieszenie przestaje rosnąć (ze względu na Prawo Amdahla i narzuty komunikacyjne).

### E. Skalowanie Słabe (Weak Scaling)
Badanie zachowania programu, gdy **rozmiar problemu rośnie proporcjonalnie do liczby rdzeni** (np. $10\,000$ cząstek na każdy rdzeń).
*   *Cel*: Zmierzenie wydajności zgodnie z Prawem Gustafsona. W idealnym kodzie czas obliczeń $T_p$ powinien pozostać stały przy jednoczesnym zwiększaniu liczby cząstek i liczby rdzeni.

### F. Współczynnik Niezrównoważenia Obciążenia (Load Imbalance Factor)
Pokazuje, jak nierówno rozłożona jest praca pomiędzy wątki OpenMP:

$$\text{Imbalance} = \frac{T_{max} - T_{avg}}{T_{max}}$$

Gdzie:
*   $T_{max}$ – czas wykonania pracy przez najwolniejszy wątek.
*   $T_{avg}$ – średni czas pracy wątków.
*   Wartości bliskie $0$ oznaczają idealne zbalansowanie. Wartości wysokie (np. $0.4$) sugerują potrzebę zmiany harmonogramu OpenMP ze statycznego (`schedule(static)`) na dynamiczny (`schedule(dynamic)`).

### G. Metryki Liczników Sprzętowych (z narzędzia `perf`)
Dla kodu numerycznego krytyczne jest wykorzystanie pamięci podręcznej. Porównaj:
1.  **L1-dcache-load-miss-rate**: Stosunek chybień cache L1 do wszystkich odczytów. Powinien być jak najniższy (optymalnie $< 3\%$).
2.  **LLC-load-miss-rate**: Stosunek chybień cache ostatniego poziomu (L3). Wysoka wartość oznacza, że wątki ciągle sięgają do pamięci RAM, co spowalnia kod.
3.  **IPC (Instructions Per Cycle)**: Liczba instrukcji wykonanych w jednym cyklu zegara. Wyższa wartość oznacza lepsze wykorzystanie potoków procesora.
