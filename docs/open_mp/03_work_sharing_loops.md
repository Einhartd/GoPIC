# Kurs OpenMP - Lekcja 3: Zrównoleglanie Pętli (Work-Sharing)

Ręczny podział pracy na podstawie ID wątku (jak w Lekcji 2) bywa uciążliwy. OpenMP dostarcza mechanizm automatycznego dzielenia iteracji pętli `for` pomiędzy wątki.

---

## 1. Dyrektywy `#pragma omp for` i `#pragma omp parallel for`

Pętla `for` może zostać zrównoleglona na dwa sposoby:

### A. Jawne rozbicie (blok i pętla osobno)
Mamy pełną kontrolę nad regionem równoległym:
```cpp
#pragma omp parallel
{
    // ... kod wykonywany przez wszystkie wątki (np. inicjalizacja) ...

    #pragma omp for
    for (int i = 0; i < 100; i++) {
        // Ta pętla zostanie automatycznie podzielona na wątki
    }
}
```

### B. Wersja skrócona (najczęstsza)
Kompilator automatycznie tworzy region równoległy i dzieli pętlę:
```cpp
#pragma omp parallel for
for (int i = 0; i < 100; i++) {
    // Automatyczny podział i równoległe wykonanie
}
```

---

## 2. Warunki zrównoleglania pętli (Canonical Loop Form)
Aby OpenMP mogło zrównoleglić pętlę, musi ona mieć postać kanoniczną. Kompilator musi znać **dokładną liczbę iteracji** przed wejściem do pętli:
*   Pętla musi być sterowana zmienną całkowitoliczbową lub wskaźnikiem/iteratorem (np. `std::vector<int>::iterator`).
*   Krok pętli musi być stały (np. `i++`, `i += 2`, `i--`).
*   **ZABRONIONE** jest przerywanie pętli za pomocą `break`, `goto` lub `return`.

---

## 3. Strategie podziału pętli (`schedule`)

Nie wszystkie pętle mają ten sam koszt obliczeniowy w każdej iteracji. OpenMP pozwala kontrolować podział pracy za pomocą klauzuli `schedule(typ[, chunk_size])`:

### A. `schedule(static [, chunk_size])` – Statyczny
*   **Jak działa**: Iteracje są dzielone na równe bloki (`chunk_size`) i przypisywane wątkom przed uruchomieniem pętli (np. Wątek 0 dostaje iteracje 0-24, Wątek 1 dostaje 25-49).
*   **Kiedy używać**: Gdy czas wykonania każdej iteracji jest stały i przewidywalny (np. interpolacja fizyczna, wektory). Bardzo niski narzut wydajnościowy.

### B. `schedule(dynamic [, chunk_size])` – Dynamiczny
*   **Jak działa**: Wątki pobierają pakiety iteracji o rozmiarze `chunk_size` z globalnej kolejki w trakcie działania pętli. Gdy wątek skończy swój pakiet, pobiera następny.
*   **Kiedy używać**: Gdy czas wykonania poszczególnych iteracji bardzo się różni (np. pętla kolizji cząstek – tylko nieliczne cząstki ulegają zderzeniom, a fizyka zderzenia jest kosztowna). Ma większy narzut, ale zapobiega bezczynności wątków.

---

## 🛠️ Ćwiczenie Praktyczne: Porównanie Harmonogramów
Przebadajmy różnicę w wydajności. Wklej ten kod do pliku `test_omp3.cc`:

```cpp
#include <iostream>
#include <vector>
#include <cmath>
#include <omp.h>

int main() {
    const int size = 20000;
    std::vector<double> dane(size, 0.0);

    double start_time = omp_get_wtime();

    // Każda kolejna iteracja wykonuje znacznie więcej pracy niż poprzednia
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < size; ++i) {
        double val = 0.0;
        for (int j = 0; j < i; ++j) {
            val += std::sin(j) * std::cos(j);
        }
        dane[i] = val;
    }

    double end_time = omp_get_wtime();
    std::cout << "Czas wykonania (static): " << (end_time - start_time) << " s" << std::endl;

    return 0;
}
```

Skompiluj i uruchom:
```bash
g++ -std=c++17 -fopenmp test_omp3.cc -o test_omp3
./test_omp3
```
Następnie zmień `schedule(static)` na `schedule(dynamic, 100)` i porównaj czas działania. 

**Pytanie:**
*   Które harmonogramowanie okazało się szybsze dla tej nierównomiernej pętli i dlaczego?
