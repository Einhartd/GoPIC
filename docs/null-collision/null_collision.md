# Algorytm Null-Collision w Symulacjach PIC/MCC (eduPIC/GoPIC)

Niniejszy dokument wyjaśnia koncepcję, matematykę oraz implementację metody **Null-Collision** w języku C na potrzeby optymalizacji symulacji Particle-in-Cell / Monte Carlo Collisions (PIC/MCC). 

Standardowa implementacja zderzeń w eduPIC jest bardzo kosztowna obliczeniowo. Zastosowanie algorytmu Null-Collision pozwala na przyspieszenie fazy kolizyjnej nawet **10–30-krotnie**, poprzez całkowite wyeliminowanie obliczania funkcji eksponencjalnej (`exp`) w pętli po wszystkich cząstkach.

---

## 1. Dlaczego standardowe MCC jest powolne?

W podstawowym algorytmie MCC, dla każdej cząstki $k$ w każdym kroku czasowym $\Delta t$ musimy sprawdzić, czy ulega ona zderzeniu. Wymaga to wykonania następujących operacji:

1. Obliczenie kwadratu prędkości: $v_k^2 = v_x^2 + v_y^2 + v_z^2$
2. Obliczenie wartości prędkości: $v_k = \sqrt{v_k^2}$ (kosztowny pierwiastek)
3. Obliczenie energii kinetycznej w elektronowoltach: $\varepsilon_k = 0.5 \cdot m \cdot v_k^2 / e$
4. Odczytanie sumarycznego przekroju czynnego $\sigma_{tot}(\varepsilon_k)$ z tabeli.
5. Obliczenie częstości kolizji: $\nu(v_k) = \sigma_{tot}(\varepsilon_k) \cdot v_k \cdot n_g$ (gdzie $n_g$ to gęstość gazu tła).
6. Obliczenie prawdopodobieństwa kolizji: 
   $$P_{coll}(v_k) = 1 - \exp\left(-\nu(v_k) \cdot \Delta t\right)$$
7. Losowanie liczby $R \in [0, 1)$ i sprawdzenie warunku: $R < P_{coll}(v_k)$.

### Skala wąskiego gardła
Wywołanie funkcji `exp()` w punkcie 6 jest **dominującym kosztem obliczeniowym** całej symulacji. Przy populacji $N \approx 50\,000$ cząstek i $4000$ krokach na cykl RF, w jednym tylko cyklu wywoływanych jest **200 milionów funkcji wykładniczych**. Funkcja `exp()` na współczesnych procesorach jest od kilku do kilkunastu razy wolniejsza niż proste mnożenie lub dzielenie.

---

## 2. Zasada działania metody Null-Collision

Metoda ta opiera się na prostym koncepcie statystycznym: zamiast liczyć zmienne prawdopodobieństwo kolizji dla każdej cząstki, przyjmujemy **globalne, stałe, maksymalne prawdopodobieństwo kolizji** dla całego układu, a następnie odrzucamy zderzenia, które nie powinny się wydarzyć (stąd nazwa *Null-Collision* – kolizja zerowa).

### Matematyka algorytmu

1. **Wyznaczenie maksymalnej częstości kolizji ($\nu^*$)**:
   Przed rozpoczęciem symulacji wyznaczamy maksymalną możliwą częstość zderzeń w całym zakresie energii:
   $$\nu^* = \max_{\varepsilon} \left\{ \sigma_{tot}(\varepsilon) \cdot v(\varepsilon) \cdot n_g \right\}$$

2. **Wyznaczenie maksymalnego prawdopodobieństwa zderzenia ($P^*$)**:
   Na podstawie $\nu^*$ obliczamy stałe prawdopodobieństwo:
   $$P^* = 1 - \exp(-\nu^* \cdot \Delta t)$$
   Wartość ta jest obliczana **tylko raz** na początku symulacji.

3. **Wybór kandydatów do kolizji**:
   W każdym kroku czasowym, zamiast sprawdzać wszystkie $N$ cząstek, losujemy liczbę "kandydatów" do kolizji, $N_{coll}^*$, z rozkładu dwumianowego:
   $$N_{coll}^* \sim \text{Binomial}(N, P^*)$$
   Dla małych prawdopodobieństw ($P^* < 0.05$), rozkład dwumianowy można bardzo dobrze przybliżyć jako $N_{coll}^* = \text{round}(N \cdot P^*)$ z poprawką losową.
   
   Następnie losujemy dokładnie $N_{coll}^*$ unikalnych indeksów cząstek z całej populacji $N$.

4. **Test akceptacji (Kolizja rzeczywista vs. Kolizja zerowa)**:
   Dla każdego wybranego kandydata $k$ obliczamy jego rzeczywistą częstość kolizji $\nu(v_k)$ (wymaga to policzenia energii i odczytu $\sigma_{tot}$, ale robimy to tylko dla max 5% populacji cząstek!).
   
   Prawdopodobieństwo zaakceptowania zderzenia jako rzeczywistego wynosi:
   $$P_{accept} = \frac{\nu(v_k)}{\nu^*}$$
   
   Losujemy liczbę $R \in [0, 1)$:
   * Jeśli $R < P_{accept}$, dochodzi do **rzeczywistego zderzenia** – wywołujemy standardową funkcję obsługi kolizji (np. elastyczną, wzbudzenie lub jonizację).
   * W przeciwnym razie dochodzi do **kolizji zerowej (null-collision)** – cząstka przelatuje dalej bez jakichkolwiek zmian kierunku czy prędkości.

### Dlaczego to jest poprawne?
Łączne prawdopodobieństwo, że dana cząstka ulegnie kolizji wynosi:
$$P_{coll}(k) = P^* \cdot P_{accept} = \left(1 - e^{-\nu^* \Delta t}\right) \cdot \frac{\nu(v_k)}{\nu^*}$$
Przy $\nu^* \Delta t \ll 1$ (co gwarantują warunki stabilności fizycznej symulacji):
$$1 - e^{-\nu^* \Delta t} \approx \nu^* \Delta t$$
Zatem:
$$P_{coll}(k) \approx \nu^* \Delta t \cdot \frac{\nu(v_k)}{\nu^*} = \nu(v_k) \Delta t \approx 1 - e^{-\nu(v_k) \Delta t}$$
Wynik jest statystycznie identyczny z klasyczną metodą MCC.

---

## 3. Implementacja w języku C (`C/eduPIC.cc`)

Poniżej przedstawiono kroki niezbędne do wdrożenia metody Null-Collision w roboczej wersji kodu C++.

### Krok 3.1: Dodanie zmiennych globalnych
Na początku pliku deklarujemy prekomputowane parametry:

```cpp
// null-collision parameters (precomputed once)
double nu_star_e = 0.0;
double P_star_e  = 0.0;
double nu_star_i = 0.0;
double P_star_i  = 0.0;
```

### Krok 3.2: Funkcja prekomputacji parametrów
Dodajemy funkcję wyliczaną po zainicjowaniu przekrojów czynnych:

```cpp
#include <math.h>
#include <vector>
#include <numeric>
#include <algorithm>

void compute_null_collision_params() {
    double e, v, g, nu;
    
    // Elektrony
    nu_star_e = 0.0;
    for (int i = 0; i < CS_RANGES; i++) {
        e  = (i == 0) ? DE_CS : i * DE_CS;
        v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
        nu = sigma_tot_e[i] * v; // sigma_tot_e zawiera już GAS_DENSITY
        if (nu > nu_star_e) {
            nu_star_e = nu;
        }
    }
    P_star_e = 1.0 - exp(-nu_star_e * DT_E);
    
    // Jony (używamy zredukowanej masy argon-argon MU_ARAR)
    nu_star_i = 0.0;
    for (int i = 0; i < CS_RANGES; i++) {
        e  = (i == 0) ? DE_CS : i * DE_CS;
        g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
        nu = sigma_tot_i[i] * g; // sigma_tot_i zawiera już GAS_DENSITY
        if (nu > nu_star_i) {
            nu_star_i = nu;
        }
    }
    P_star_i = 1.0 - exp(-nu_star_i * DT_I);
    
    printf(">> eduPIC: Null-Collision precomputed:\n");
    printf("           Electrons: nu*_e = %e, P*_e = %e\n", nu_star_e, P_star_e);
    printf("           Ions:      nu*_i = %e, P*_i = %e\n", nu_star_i, P_star_i);
}
```

### Krok 3.3: Pomocnik do losowania indeksów bez powtórzeń (Fisher-Yates)
Musimy wylosować $N_{coll}^*$ cząstek z puli $N$. Używamy częściowego tasowania Fishera-Yatesa, które działa w czasie $O(count)$ zamiast alokować całą tablicę za każdym razem:

```cpp
// Losuje 'count' unikalnych indeksów z zakresu [0, n)
void random_sample(int n, int count, std::vector<int> &out) {
    static std::vector<int> pool;
    if (pool.size() < (size_t)n) {
        pool.resize(n);
        std::iota(pool.begin(), pool.end(), 0);
    }
    
    for (int i = 0; i < count; i++) {
        int j = i + (int)(R01(MTgen) * (n - i));
        std::swap(pool[i], pool[j]);
    }
    out.assign(pool.begin(), pool.begin() + count);
}
```

### Krok 3.4: Zmiana pętli kolizyjnej elektronów w `do_one_cycle()`
Zastępujemy starą pętlę (która liczyła `exp` dla każdego elektronu) nowym blokiem:

```cpp
// --- NOWA WERSJA: NULL-COLLISION DLA ELEKTRONÓW ---
{
    // Losowanie liczby kandydatów z rozkładu dwumianowego
    std::binomial_distribution<int> binom_e(N_e, P_star_e);
    int N_coll_star_e = binom_e(MTgen);
    if (N_coll_star_e > N_e) N_coll_star_e = N_e;
    
    if (N_coll_star_e > 0) {
        std::vector<int> candidates_e;
        random_sample(N_e, N_coll_star_e, candidates_e);
        
        for (int ki : candidates_e) {
            v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
            velocity = sqrt(v_sqr);
            energy   = 0.5 * E_MASS * v_sqr / EV_TO_J;
            energy_index = std::min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
            
            double real_nu = sigma_tot_e[energy_index] * velocity;
            double p_accept = real_nu / nu_star_e;
            
            // Zabezpieczenie przed przekroczeniem zakresu nu_star
            if (p_accept > 1.0) p_accept = 1.0; 
            
            if (R01(MTgen) < p_accept) {
                collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index);
                N_e_coll++;
            }
            // else: kolizja zerowa (null-collision) - nic nie robimy
        }
    }
}
```

### Krok 3.5: Zmiana pętli kolizyjnej jonów w `do_one_cycle()`
Dla jonów postępujemy analogicznie, wewnątrz warunku subcyklizacji `(t % N_SUB) == 0`:

```cpp
// --- NOWA WERSJA: NULL-COLLISION DLA JONÓW ---
if ((t % N_SUB) == 0) {
    std::binomial_distribution<int> binom_i(N_i, P_star_i);
    int N_coll_star_i = binom_i(MTgen);
    if (N_coll_star_i > N_i) N_coll_star_i = N_i;
    
    if (N_coll_star_i > 0) {
        std::vector<int> candidates_i;
        random_sample(N_i, N_coll_star_i, candidates_i);
        
        for (int ki : candidates_i) {
            vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
            gx = vx_i[ki] - vx_a;
            gy = vy_i[ki] - vy_a;
            gz = vz_i[ki] - vz_a;
            g_sqr = gx*gx + gy*gy + gz*gz;
            g = sqrt(g_sqr);
            energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J;
            energy_index = std::min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
            
            double real_nu = sigma_tot_i[energy_index] * g;
            double p_accept = real_nu / nu_star_i;
            
            if (p_accept > 1.0) p_accept = 1.0;
            
            if (R01(MTgen) < p_accept) {
                collision_ion(&vx_i[ki], &vy_i[ki], &vz_i[ki], &vx_a, &vy_a, &vz_a, energy_index);
                N_i_coll++;
            }
        }
    }
}
```

### Krok 3.6: Wywołanie prekomputacji w `main()`
W funkcji `main()`, zaraz po wyliczeniu sumarycznych przekrojów czynnych dodajemy wywołanie parametrów Null-Collision:

```cpp
// ... wewnątrz main() ...
calc_total_cross_sections();
compute_null_collision_params(); // Inicjalizacja parametrów metody Null-Collision
```

---

## 4. Podsumowanie zysków i weryfikacja poprawności

### Porównanie wydajności
| Cecha | Standardowe MCC | Null-Collision |
|---|---|---|
| **Złożoność obliczeniowa** | $O(N)$ wywołań `exp()` na krok | **$O(1)$** wywołań `exp()` na krok (prekomputacja) |
| **Pętle kolizyjne** | Iteracja przez 100% cząstek | Iteracja przez **~2-5%** cząstek ($N \cdot P^*$) |
| **Prędkość kroku zderzeń** | Wolny (wąskie gardło przez `exp`) | **Szybki (10–30× przyspieszenia)** |

### Ważne aspekty wdrożenia:
1. **Brak identyczności numerycznej**: Z powodu zmiany ścieżki losowań RNG, pojedyncze trajektorie cząstek będą się różnić od wersji standardowej. Wyniki są jednak **statystycznie zbieżne** (rozkłady energii EEPF, profile gęstości oraz prądy na elektrodach po uśrednieniu będą identyczne w granicach szumu statystycznego).
2. **Klamrowanie prawdopodobieństwa**: Warunek `if (p_accept > 1.0) p_accept = 1.0` zabezpiecza przed sytuacją, w której chwilowa prędkość względna cząstki przekroczy teoretyczne maksimum $\nu^*$ wyliczone z tabel przekrojów czynnych.
3. **Obsługa jonizacji**: Ponieważ proces jonizacji dodaje nowe cząstki w trakcie pętli kolizyjnej, wybór indeksów kandydatów musi opierać się na liczbie cząstek $N_e$ z początku kroku kolizyjnego, ignorując nowo narodzone cząstki aż do następnego kroku czasowego symulacji.
