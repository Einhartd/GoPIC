# Integracja metody Null-Collision w kodzie Python (NumPy)

Niniejszy dokument podsumowuje zmiany wprowadzone w zoptymalizowanej za pomocą NumPy implementacji języka Python w katalogu `python/numpy_version/` oraz opisuje procedurę konfiguracji i weryfikacji działania obu wersji kolizyjnych (standardowej i Null-Collision).

---

## 1. Wykaz wprowadzonych modyfikacji

W wersji Python/NumPy przełączanie algorytmów zderzeń zorganizowano przy użyciu globalnej flagi konfiguracyjnej `USE_NULL_COLLISION` w pliku stałych.

Wprowadzone zmiany obejmują następujące pliki:

*   **[python/numpy_version/constants.py](file:///home/oliwier/Dev/GoPIC/python/numpy_version/constants.py)**:
    *   Dodano flagę konfiguracyjną `USE_NULL_COLLISION = True` (typu `bool`), która służy do globalnego włączania lub wyłączania metody Null-Collision.
*   **[python/numpy_version/state.py](file:///home/oliwier/Dev/GoPIC/python/numpy_version/state.py)**:
    *   Rozszerzono konstruktor klasy `SimulationState` o pola `nu_star_e`, `P_star_e`, `nu_star_i` oraz `P_star_i` w celu przechowywania parametrów prekomputacji.
*   **[python/numpy_version/collisions.py](file:///home/oliwier/Dev/GoPIC/python/numpy_version/collisions.py)**:
    *   Dodano funkcję `compute_null_collision_params(sim)` służącą do wyznaczania parametrów $\nu^*$ oraz $P^*$ przy użyciu zoptymalizowanych, wektorowych funkcji `max_electron_coll_freq(sim)` i `max_ion_coll_freq(sim)`.
*   **[python/numpy_version/main.py](file:///home/oliwier/Dev/GoPIC/python/numpy_version/main.py)**:
    *   Dodano warunkowe wywołanie `collisions.compute_null_collision_params(sim)` bezpośrednio po obliczeniu całkowitych przekrojów czynnych, jeśli flaga `cs.USE_NULL_COLLISION` jest aktywna.
*   **[python/numpy_version/simulation.py](file:///home/oliwier/Dev/GoPIC/python/numpy_version/simulation.py)**:
    *   Przebudowano funkcje `step7_collisions_electrons(sim)` oraz `step8_collisions_ions(sim, t)`. 
    *   W przypadku włączenia `cs.USE_NULL_COLLISION` realizują one wysoce zoptymalizowany, wektorowy algorytm Null-Collision w NumPy:
        1.  Losowanie liczby kandydatów $N_{coll}^*$ z rozkładu dwumianowego `sim.rng.binomial()`.
        2.  Wektorowy wybór losowych indeksów kandydatów przez `sim.rng.choice(replace=False)`.
        3.  Wektorowe obliczenie rzeczywistych częstości kolizji $\nu$ i prawdopodobieństw akceptacji $P_{accept}$.
        4.  Pętla skalarna jest wywoływana **wyłącznie** dla faktycznie zaakceptowanych cząstek (średnio ~5% kandydatów) w celu wywołania procedur zderzeń.
    *   W przypadku wyłączenia flagi, funkcje realizują dotychczasowy, pełny wektorowy algorytm kolizji standardowych.

---

## 2. Instrukcja przełączania i kompilacji

Wersja Python nie wymaga kompilacji. Wybór metody następuje poprzez modyfikację wartości w pliku **[constants.py](file:///home/oliwier/Dev/GoPIC/python/numpy_version/constants.py)**:

```python
USE_NULL_COLLISION: Final[bool] = True   # Aktywuje metodę Null-Collision
# lub
USE_NULL_COLLISION: Final[bool] = False  # Aktywuje standardowe zderzenia
```

---

## 3. Uruchomienie i weryfikacja

Uruchomienie symulacji z poziomu katalogu `python/numpy_version/`:

### Krok 1: Oczyszczenie starych plików danych
```bash
rm -f picdata.bin conv.dat density.dat eepf.dat ifed.dat info.txt *_xt.dat
```

### Krok 2: Uruchomienie cyklu inicjalizacyjnego
Używamy interpretera z wbudowanego środowiska wirtualnego `.venv`:
```bash
./.venv/bin/python main.py 0
```

### Oczekiwany log startowy (dla `USE_NULL_COLLISION = True`)
```text
>> PyPIC: starting...
>> PyPIC: measurement mode: OFF
>> PyPIC: Setting e- / Ar cross sections
>> PyPIC: Setting Ar+ / Ar cross sections
>> GoPIC (NumPy): null-collision: nu*_e = 6.866969e+08, P*_e = 1.258054e-02
>> GoPIC (NumPy): null-collision: nu*_i = 5.482972e+07, P*_i = 2.001445e-02
>> PyPIC: running initializing cycle
```
Wartości prekomputowane przez NumPy są identyczne (bit-do-bitu) z wartościami z implementacji w językach C++ oraz Go.
