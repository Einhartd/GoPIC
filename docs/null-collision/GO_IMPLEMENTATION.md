# Integracja metody Null-Collision w kodzie Go (GoPIC)

Niniejszy dokument podsumowuje zmiany wprowadzone w implementacji języka Go w katalogu `Go/native_version/` oraz opisuje procedurę kompilacji i weryfikacji działania obu wersji kolizyjnych za pomocą mechanizmu tagów budowania (Go Build Tags).

---

## 1. Wykaz wprowadzonych modyfikacji

W języku Go, zamiast dyrektyw preprocesora `#ifdef` znanych z C/C++, zastosowano idiomy standardu Go – **Build Tags (tagi budowania)**. Pozwala to na warunkową kompilację odpowiednich plików źródłowych w czasie budowania programu.

Wprowadzone zmiany obejmują następujące pliki:

*   **[Go/native_version/state.go](file:///home/oliwier/Dev/GoPIC/Go/native_version/state.go)**:
    *   Dodano 4 nowe pola typu `float64` do struktury `SimulationState` przechowujące parametry prekomputacji: `NuStarE`, `PStarE`, `NuStarI` oraz `PStarI`.
*   **[Go/native_version/run.go](file:///home/oliwier/Dev/GoPIC/Go/native_version/run.go)**:
    *   Dodano wywołanie metody `sim.InitNullCollision()` wewnątrz funkcji `Run()`, bezpośrednio po załadowaniu przekrojów czynnych i wywołaniu `sim.CalcTotalCrossSections()`.
*   **[Go/native_version/simulation.go](file:///home/oliwier/Dev/GoPIC/Go/native_version/simulation.go)**:
    *   Usunięto stare, seryjne metody `Step7CollisionsElectrons()` i `Step8CollisionIons(t int)`, ponieważ zostały one przeniesione do plików warunkowych.
*   **[Go/native_version/simulation_standard.go](file:///home/oliwier/Dev/GoPIC/Go/native_version/simulation_standard.go)** (NOWY PLIK):
    *   Oznaczony tagiem budowania `//go:build !nullcollision`.
    *   Zawiera standardowe (seryjne) metody `Step7CollisionsElectrons()` i `Step8CollisionIons(t int)`.
    *   Zawiera pustą metodę `InitNullCollision()`, która nie wykonuje żadnych operacji.
*   **[Go/native_version/simulation_null.go](file:///home/oliwier/Dev/GoPIC/Go/native_version/simulation_null.go)** (NOWY PLIK):
    *   Oznaczony tagiem budowania `//go:build nullcollision`.
    *   Zawiera metodę `InitNullCollision()`, która oblicza $\nu^*$ oraz $P^*$ dla elektronów i jonów, a następnie wypisuje je w konsoli.
    *   Zawiera zoptymalizowane metody `Step7CollisionsElectrons()` i `Step8CollisionIons(t int)` oparte na algorytmie Null-Collision.
    *   Implementuje pomocnicze metody `randomSample` (częściowy Fisher-Yates do selekcji indeksów) oraz `sampleBinomial` (do wyznaczania liczby kandydatów).

---

## 2. Instrukcja kompilacji

Kompilację należy przeprowadzać z poziomu katalogu `Go/native_version/`.

### A. Wersja Standardowa (klasyczne MCC)
Kompilujemy program bez dodatkowych tagów. Pliki oznaczane `!nullcollision` zostaną automatycznie wybrane:
```bash
go build -o pic_standard ./cmd/pic/main.go
```

### B. Wersja Zoptymalizowana (Null-Collision)
Budujemy binarkę z tagiem `nullcollision`:
```bash
go build -tags nullcollision -o pic_nc ./cmd/pic/main.go
```

---

## 3. Uruchomienie i weryfikacja

### Krok 1: Oczyszczenie katalogu z danych wyjściowych
```bash
rm -f picdata.bin conv.dat density.dat eepf.dat ifed.dat info.txt *_xt.dat
```

### Krok 2: Uruchomienie wersji zoptymalizowanej
```bash
./pic_nc 0
```

### Oczekiwany log startowy
Wersja `pic_nc` powinna wypisać w konsoli:
```text
>> GoPIC: starting...
>> GoPIC: measurement mode: off
>> gopic: Setting e- / Ar cross sections
>> gopic: Setting Ar+ / Ar cross sections
>> GoPIC: null-collision: nu*_e = 6.866969e+08, P*_e = 1.258054e-02
>> GoPIC: null-collision: nu*_i = 5.482972e+07, P*_i = 2.001445e-02
>> GoPIC: running initializing cycle
```
Liczby $\nu^*$ oraz $P^*$ powinny być dokładnie tożsame z wartościami wyliczonymi w implementacji C++.
