# Integracja metody Null-Collision w kodzie C (eduPIC)

Niniejszy dokument podsumowuje zmiany wprowadzone w implementacji języka C w katalogu `C/` oraz opisuje procedurę kompilacji i weryfikacji działania obu wersji kolizyjnych (standardowej i zoptymalizowanej).

---

## 1. Wykaz wprowadzonych modyfikacji

Zastosowano mechanizm warunkowej kompilacji preprocesora za pomocą flagi `USE_NULL_COLLISION`. Pozwala to na bezkosztowne przełączanie implementacji w czasie budowania programu.

Wprowadzone zmiany obejmują następujące pliki:

*   **[C/null_collision.h](file:///home/oliwier/Dev/GoPIC/C/null_collision.h)**:
    *   Dodano instrukcje `printf` wewnątrz funkcji `compute_null_collision_params()` w celu wyświetlenia wartości prekomputowanych parametrów $\nu^*$ (maksymalnej częstości kolizji) oraz $P^*$ (maksymalnego prawdopodobieństwa zderzenia) w konsoli podczas uruchamiania.
*   **[C/simulation.h](file:///home/oliwier/Dev/GoPIC/C/simulation.h)**:
    *   Dodano warunkowe dołączenie nagłówka `null_collision.h` pod dyrektywą `#ifdef USE_NULL_COLLISION`.
    *   Zmodyfikowano funkcje `step7_collisions_electrons()` oraz `step8_collision_ions()` tak, aby pod definicją makra `USE_NULL_COLLISION` realizowały zoptymalizowany pod kątem braku funkcji `exp` algorytm z losowaniem kandydatów, a pod blokiem `#else` realizowały dotychczasowy, seryjny algorytm zderzeń standardowych.
*   **[C/eduPIC.cc](file:///home/oliwier/Dev/GoPIC/C/eduPIC.cc)**:
    *   Dodano warunkowe wywołanie funkcji `compute_null_collision_params()` wewnątrz `main()` bezpośrednio po zakończeniu obliczeń przekrojów czynnych (`calc_total_cross_sections()`), tylko wtedy gdy zdefiniowano makro `USE_NULL_COLLISION`.

---

## 2. Instrukcja kompilacji

Kompilację należy przeprowadzać z poziomu katalogu `C/`.

### A. Wersja Standardowa (klasyczne MCC)
Kompilujemy program w tradycyjny sposób, bez definiowania dodatkowych makr:
```bash
g++ -O3 eduPIC.cc -o eduPIC
```

### B. Wersja Zoptymalizowana (Null-Collision)
Definiujemy makro `USE_NULL_COLLISION` za pomocą flagi kompilatora `-D`:
```bash
g++ -O3 -DUSE_NULL_COLLISION eduPIC.cc -o eduPIC_nc
```

---

## 3. Uruchomienie i weryfikacja

Aby przetestować poprawne wdrożenie, zaleca się oczyszczenie starych plików danych z poprzednich symulacji i wykonanie cyklu inicjalizacyjnego (`cycle = 0`).

### Krok 1: Oczyszczenie katalogu z danych wyjściowych
```bash
rm -f picdata.bin conv.dat density.dat eepf.dat ifed.dat info.txt *_xt.dat
```

### Krok 2: Uruchomienie cyklu inicjalizacyjnego
Dla wersji Null-Collision:
```bash
./eduPIC_nc 0
```

### Oczekiwany log startowy
Wersja `eduPIC_nc` powinna wypisać w konsoli poniższe informacje przed rozpoczęciem kroku czasowego:
```text
>> eduPIC: starting...
...
>> eduPIC: Setting e- / Ar cross sections
>> eduPIC: Setting Ar+ / Ar cross sections
>> eduPIC: null-collision: nu*_e = 6.866969e+08, P*_e = 1.258054e-02
>> eduPIC: null-collision: nu*_i = 5.482972e+07, P*_i = 2.001445e-02
>> eduPIC: running initializing cycle
```

Porównanie liczby cząstek po 1 cyklu RF w obu wersjach wykaże drobne różnice statystyczne ze względu na alternatywne losowania RNG, jednak fizyczne średnie gęstości plazmy pozostają statystycznie tożsame.
