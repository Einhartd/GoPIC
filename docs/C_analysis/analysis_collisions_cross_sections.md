# Analiza implementacji równoległej: Kolizje i Przekroje Czynne (OpenMP)

Poniższy raport stanowi dogłębną analizę plików [`collisions.h`](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/collisions.h), [`cross_sections.h`](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/cross_sections.h) oraz [`null_collision.h`](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/null_collision.h) w porównaniu do seryjnego kodu `eduPIC.cc`. W kodzie zoptymalizowanym pod kątem zrównoleglenia (OpenMP) wprowadzono szereg modyfikacji pamięciowych oraz architektonicznych.

## 1. `null_collision.h` – Metoda Null Collision

### Co to jest i jak jest zaimplementowana?
W pliku implementowana jest tzw. metoda Null Collision dla cząstek (elektronów i jonów). 
Tradycyjnie, aby sprawdzić zderzenia metodą Monte Carlo (MCC) dla każdej cząstki, należałoby obliczać prawdopodobieństwo zderzenia zależne od lokalnej gęstości, przekroju czynnego i prędkości. Jest to operacja $O(N)$ o ogromnym koszcie.
Metoda **Null Collision** polega na wyznaczeniu sztucznej, globalnej maksymalnej częstotliwości kolizji ($\nu^*$), która jest wyższa lub równa maksymalnej fizycznej częstotliwości w całym układzie. Wprowadzamy "puste zderzenia" (null collisions), które kompensują tę nadwyżkę (nie zmieniają pędu ani energii cząstki). Dzięki temu prawdopodobieństwo interakcji w kroku czasowym staje się stałe dla całego gazu: $P^* = 1 - \exp(-\nu^* \Delta t)$. 
Pozwala to losować z góry **tylko ułamek cząstek**, omijając skanowanie całej populacji. W kodzie odpowiada za to funkcja `compute_null_collision_params()`, wyliczająca $P^*$. Cząstki do potencjalnego zderzenia są losowane algorytmem przypominającym tasowanie Fishera-Yatesa w funkcji `random_sample()`.
* **Źródło:** [Vahedi & Surendra (1995), "A Monte Carlo collision model..."](https://doi.org/10.1016/0010-4655(94)00171-W)

### Bottleneck i potencjalny Race Condition w `random_sample`
Zastosowano statyczny bufor: `static std::vector<int> pool;`.
Jakkolwiek rezerwowanie pamięci jednorazowo zwiększa wydajność zapobiegając częstym realokacjom, jest to **krytyczne zagrożenie współbieżności** (Data Race), jeżeli funkcja ta byłaby wywołana równolegle przez różne wątki OpenMP bez sekcji `omp critical` lub `omp single`. Aby była w pełni Thread-Safe dla OpenMP, bufor `pool` musiałby być deklarowany jako `thread_local`.

## 2. `cross_sections.h` – Tablicowanie przekrojów czynnych

### Optymalizacje pamięciowe: Lookup Tables vs Obliczenia On-The-Fly
Oryginalne funkcje (np. `set_electron_cross_sections_ar`) bazują na bardzo złożonych wzorach analitycznych wykorzystujących podniesienia do potęgi (`pow`), funkcje wykładnicze (`exp`) oraz pierwiastki. Obliczanie tych wartości on-the-fly wewnątrz pętli zderzeń całkowicie zniszczyłoby wydajność kodu z uwagi na opóźnienia potoków jednostek FPU.
Zamiast tego użyto optymalizacji typu **Lookup Table (LUT)**.
Krzywe przekrojów czynnych są dyskretyzowane w dziedzinie energii (ze stałym krokiem `DE_CS` równym z reguły małemu ułamkowi elektronowolta). Wartości są pre-kalkulowane i ładowane do tablic `sigma[E_ELA]`, `sigma[E_EXC]`, itd.
W trakcie głównej pętli symulacji indeks komórki do odczytu ustala się trywialnie dzieląc energię cząstki przez stałą dyskretyzacji (np. `int index = E / DE_CS;`), co zastępuje precyzyjną i kosztowną interpolację. 
* **Źródło (Lookup Tables):** [Intel 64 and IA-32 Architectures Optimization Reference Manual - Chapter 3.5](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)

## 3. `collisions.h` – Zderzenia (MCC) i Zrównoleglenie (OpenMP)

Chociaż sam plik `collisions.h` nie zawiera dyrektyw `#pragma omp`, jego architektura została przebudowana w taki sposób, aby funkcje `collision_electron` oraz `collision_ion` mogły być wywoływane współbieżnie.

### OpenMP: Radzenie sobie z Race Conditions przy powstawaniu cząstek
Podczas jonizacji (w `collision_electron`) powstaje nowa para elektron-jon. 
W klasycznym kodzie seryjnym `eduPIC.cc` dodawano je bezpośrednio do głównych tablic zwiększając licznik: `x_e[N_e] = xe; N_e++;`. 
Wykonanie tego równolegle z użyciem wielu wątków OpenMP spowodowałoby zjawisko **Race Condition** nadpisując i tracąc cząstki, a nałożenie dyrektywy `#pragma omp atomic update` (bądź `critical`) na operację inkrementacji zabiłoby skalowalność i wywołało serializację.
W `collisions.h` wprowadzono nową strukturę **`NewParticles`**. Jest to model pamięci **Struct of Arrays (SoA)**:
```cpp
struct NewParticles { std::vector<double> x; std::vector<double> vx; ... }
```
Funkcja przyjmuje referencje `NewParticles& new_e, NewParticles& new_i`. Każdy wątek w swojej prywatnej pętli ładuje lokalnie wyprodukowane w jonizacji cząstki do swojej tymczasowej lokalnej instancji. Po wyjściu z sekcji równoległej wątki scalają nowo powstałe cząstki z powrotem do wektorów ogólnych w jednym przebiegu (często z użyciem redukcji lub offsets). Zapewnia to brak konfliktów pamięciowych i idealne ułożenie danych pod wektoryzację procesora w późniejszych etapach symulacji.
* **Źródło (SoA i redukcje OpenMP dla unikania False Sharing):** [OpenMP Application Programming Interface Specification (Reductions & Thread Privacy)](https://www.openmp.org/wp-content/uploads/OpenMP-API-Specification-5-2.pdf)

### Thread-Safety Generatorów Liczb Losowych
W MCC kolizje całkowicie bazują na liczbach pseudolosowych (m.in. przy rozpraszaniu, obliczaniu azymutu `eta` oraz kątów rozproszenia `chi`).
Zastosowanie jednej funkcji `rand()` z biblioteki C standardowo używa ukrytego, współdzielonego globalnego stanu, co w OpenMP grozi katastrofalnym false sharing i w skrajnym wypadku obcięciem wydajności do zera poprzez lockowanie.
Kod OpenMP radzi sobie z tym poprzez użycie makra `R01(MTgen)` opierającego się na silniku Mersenne Twister. Silnik ten został umieszczony w pliku `state.h` jako **`thread_local std::mt19937 MTgen`**. Słowo kluczowe `thread_local` gwarantuje, że każdy wątek OpenMP instancjonuje swoją kopię generatora, zapewniając 100% skalowalność i bezpieczeństwo.
* **Źródło (Thread-Local PRNG):** [C++ Reference: Thread local storage duration](https://en.cppreference.com/w/cpp/language/storage_duration)

### Bottlenecki i Optymalizacje Algorytmiczne (Branch Prediction)
- Zderzenia generują spore obciążenie predyktora skoków (Branch Prediction), w szczególności kod wyliczający kąty Eulera: `if (gx == 0) { ... } else { ... }`. 
- **Brak wektoryzacji matematyki:** Funkcje `sin()`, `cos()`, `atan2()` liczone na pojedynczych wartościach skalarnych mocno limitują IPC (Instructions per cycle). Gdyby MCC przetwarzało bloki cząstek, można by zaaplikować klauzule `#pragma omp simd` i powołać wektorowe wersje SVML (Short Vector Math Library).
- Metoda dopisywania `new_e.push(...)` wykorzystująca `.push_back()` na standardowych wektorach wewnątrz intensywnej funkcji MCC skutkuje dynamiczną alokacją, co może powodować przestoje. Lepszym pomysłem pod kątem wydajności alokacji w pamięci cache byłoby zastosowanie `reserve` w oparciu o estymację wyciągniętą ze współczynnika $P^*$.
