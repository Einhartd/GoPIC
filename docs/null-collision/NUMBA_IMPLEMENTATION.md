# Integracja metody Null-Collision w kodzie Python (Numba JIT)

Niniejszy dokument podsumowuje zmiany wprowadzone w zoptymalizowanej za pomocą Numba JIT implementacji języka Python w katalogu `python/numba_version/` oraz opisuje procedurę konfiguracji i weryfikacji działania obu wersji kolizyjnych.

---

## 1. Wykaz wprowadzonych modyfikacji

W wersji Numba JIT, podobnie jak w NumPy, przełączanie wersji zrealizowano za pomocą globalnej flagi konfiguracyjnej `USE_NULL_COLLISION`. Niezbędne parametry są przekazywane bezpośrednio do funkcji kompilowanych przez Numbę (`@njit`), co pozwala na zachowanie maksymalnej wydajności kodu maszynowego.

Wprowadzone zmiany obejmują następujące pliki:

*   **[python/numba_version/constants.py](file:///home/oliwier/Dev/GoPIC/python/numba_version/constants.py)**:
    *   Dodano flagę konfiguracyjną `USE_NULL_COLLISION = True` (typu `bool`), która służy do włączania lub wyłączania metody Null-Collision.
*   **[python/numba_version/state.py](file:///home/oliwier/Dev/GoPIC/python/numba_version/state.py)**:
    *   Dodano pola `nu_star_e`, `P_star_e`, `nu_star_i` oraz `P_star_i` do konstruktora klasy `SimulationState` w celu przechowywania parametrów prekomputacji.
*   **[python/numba_version/collisions.py](file:///home/oliwier/Dev/GoPIC/python/numba_version/collisions.py)**:
    *   Wdrożono funkcję `compute_null_collision_params(sim)` wyznaczającą parametry zderzeniowe przy użyciu istniejących funkcji `max_electron_coll_freq(sim)` i `max_ion_coll_freq(sim)`.
*   **[python/numba_version/main.py](file:///home/oliwier/Dev/GoPIC/python/numba_version/main.py)**:
    *   Dodano warunkowe wywołanie `collisions.compute_null_collision_params(sim)` po wyznaczeniu przekrojów czynnych, jeśli flaga `cs.USE_NULL_COLLISION` jest aktywna.
*   **[python/numba_version/simulation.py](file:///home/oliwier/Dev/GoPIC/python/numba_version/simulation.py)**:
    *   Wprowadzono funkcję pomocniczą `@numba.njit(cache=True) def random_sample_numba(n, count)` realizującą zoptymalizowane częściowe tasowanie Fishera-Yatesa, w pełni kompatybilne z kompilatorem Numba.
    *   Zmodyfikowano sygnatury i kod funkcji zderzeń `@numba.njit` `step7_collisions_electrons` oraz `step8_collisions_ions`, dodając parametry `use_null_collision`, `nu_star` oraz `P_star`.
    *   Wewnątrz metod kolizyjnych zaimplementowano warunkowe ścieżki wykonania: jeśli `use_null_collision` jest aktywne, losowana jest liczba zderzeń z rozkładu dwumianowego `np.random.binomial()`, indeksy kandydatów są wybierane przez `random_sample_numba()`, a testy warunkowe są wykonywane bez powolnych funkcji `math.exp()`. W przeciwnym razie wykonywany jest standardowy algorytm seryjny.
    *   Zaktualizowano wywołania obu funkcji wewnątrz głównej pętli `do_one_cycle()`.

---

## 2. Instrukcja przełączania i weryfikacji

Metodę kolizyjną wybieramy poprzez zmianę wartości w pliku **[constants.py](file:///home/oliwier/Dev/GoPIC/python/numba_version/constants.py)**:

```python
USE_NULL_COLLISION: Final[bool] = True   # Użycie Null-Collision
# lub
USE_NULL_COLLISION: Final[bool] = False  # Użycie standardowego MCC
```

---

## 3. Uruchomienie i testowanie

Uruchomienie symulacji z poziomu katalogu `python/numba_version/`:

### Krok 1: Oczyszczenie katalogu z danych wyjściowych
```bash
rm -f picdata.bin conv.dat density.dat eepf.dat ifed.dat info.txt *_xt.dat
```

### Krok 2: Uruchomienie cyklu inicjalizacyjnego
```bash
./.venv/bin/python main.py 0
```

Numba automatycznie skompiluje zaktualizowane funkcje przy pierwszym wywołaniu, co potrwa kilka sekund. Kolejne cykle będą wykonywane z pełną szybkością natywną.

### Oczekiwany log startowy (przy włączonym `USE_NULL_COLLISION`)
```text
>> PyPIC: starting...
>> PyPIC: measurement mode: OFF
>> PyPIC: Setting e- / Ar cross sections
>> PyPIC: Setting Ar+ / Ar cross sections
>> GoPIC (Numba): null-collision: nu*_e = 6.866969e+08, P*_e = 1.258054e-02
>> GoPIC (Numba): null-collision: nu*_i = 5.482972e+07, P*_i = 2.001445e-02
>> PyPIC: running initializing cycle
```
Wartości prekomputowane przez wersję Numba są identyczne z wersjami C++, Go oraz Python/NumPy.
