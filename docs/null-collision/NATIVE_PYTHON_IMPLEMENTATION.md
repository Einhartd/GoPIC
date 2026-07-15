# Integracja metody Null-Collision w kodzie Python (Natywnym)

Niniejszy dokument podsumowuje zmiany wprowadzone w klasycznej, natywnej (opartej na standardowych listach) implementacji języka Python w katalogu `python/native_version/` oraz opisuje procedurę konfiguracji i weryfikacji działania obu wersji kolizyjnych.

---

## 1. Wykaz wprowadzonych modyfikacji

Przełączanie metod zderzeń w wersji natywnej opiera się na flagi konfiguracyjnej `USE_NULL_COLLISION` zadeklarowanej w pliku stałych. Ze względu na brak biblioteki NumPy w tym module, do próbkowania dwumianowego zastosowano zoptymalizowane przybliżenie rozkładem normalnym (Gaussa).

Wprowadzone zmiany obejmują następujące pliki:

*   **[python/native_version/constants.py](file:///home/oliwier/Dev/GoPIC/python/native_version/constants.py)**:
    *   Dodano flagę konfiguracyjną `USE_NULL_COLLISION = True` (typu `bool`), która służy do globalnego sterowania metodą zderzeń.
*   **[python/native_version/state.py](file:///home/oliwier/Dev/GoPIC/python/native_version/state.py)**:
    *   Rozszerzono strukturę `SimulationState` o pola `nu_star_e`, `P_star_e`, `nu_star_i` oraz `P_star_i` przeznaczone dla stałych prekomputacji.
*   **[python/native_version/collisions.py](file:///home/oliwier/Dev/GoPIC/python/native_version/collisions.py)**:
    *   Wdrożono funkcję `compute_null_collision_params(sim)` wyznaczającą parametry zderzeniowe na bazie seryjnych funkcji szukania ekstremów `max_electron_coll_freq(sim)` i `max_ion_coll_freq(sim)`.
*   **[python/native_version/main.py](file:///home/oliwier/Dev/GoPIC/python/native_version/main.py)**:
    *   Dodano warunkowe wywołanie `collisions.compute_null_collision_params(sim)` po wygenerowaniu przekrojów czynnych, gdy flaga `cs.USE_NULL_COLLISION` jest aktywna.
*   **[python/native_version/simulation.py](file:///home/oliwier/Dev/GoPIC/python/native_version/simulation.py)**:
    *   Zaktualizowano funkcje `step7_collisions_electrons` oraz `step8_collisions_ions` dodając alternatywną ścieżkę Null-Collision.
    *   **Zoptymalizowany pod kątem braku NumPy algorytm**:
        1.  *Próbkowanie dwumianowe*: Zaimplementowano szybki próbnik `Binomial(N, p)`. Gdy $N \cdot p > 10$, rozkład jest przybliżany rozkładem normalnym przy użyciu `sim.rng.gauss(mu, sigma)`. W przeciwnym wypadku wykonywane są sekwencyjne próby Bernoulli. Zapobiega to kosztownym pętlom rzędu $O(N)$ dla dużych populacji cząstek.
        2.  *Wybór bez powtórzeń*: Wykorzystano wbudowaną w Pythona funkcję `sim.rng.sample(range(N), count)`, która realizuje optymalną selekcję unikalnych kandydatów w czystym Pythonie.
        3.  *Testy i wywołania*: W pętli po wylosowanych kandydatach wyliczane jest prawdopodobieństwo akceptacji i warunkowo wywoływany jest standardowy, jednostkowy moduł kolizji.

---

## 2. Instrukcja konfiguracji i weryfikacji

Wybór metody następuje w pliku **[constants.py](file:///home/oliwier/Dev/GoPIC/python/native_version/constants.py)**:

```python
USE_NULL_COLLISION: Final[bool] = True   # Użycie Null-Collision
# lub
USE_NULL_COLLISION: Final[bool] = False  # Użycie standardowego MCC
```

---

## 3. Uruchomienie i testowanie

Uruchomienie symulacji z poziomu katalogu `python/native_version/`:

### Krok 1: Oczyszczenie katalogu z danych wyjściowych
```bash
rm -f picdata.bin conv.dat density.dat eepf.dat ifed.dat info.txt *_xt.dat
```

### Krok 2: Uruchomienie cyklu inicjalizacyjnego
```bash
./.venv/bin/python main.py 0
```

### Oczekiwany log startowy (przy włączonym `USE_NULL_COLLISION`)
```text
>> PyPIC: starting...
>> PyPIC: measurement mode: OFF
>> PyPIC: Setting e- / Ar cross sections
>> PyPIC: Setting Ar+ / Ar cross sections
>> GoPIC (Native): null-collision: nu*_e = 6.866969e+08, P*_e = 1.258054e-02
>> GoPIC (Native): null-collision: nu*_i = 5.482972e+07, P*_i = 2.001445e-02
>> PyPIC: running initializing cycle
```
Wyliczone parametry $\nu^*$ i $P^*$ są w pełni tożsame ze wszystkimi pozostałymi reimplementacjami.
