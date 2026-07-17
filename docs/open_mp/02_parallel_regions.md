# Kurs OpenMP - Lekcja 2: Regiony Równoległe i Funkcje API

W tej lekcji nauczysz się, jak kontrolować liczbę wątków, jak identyfikować poszczególne wątki oraz jak korzystać z wbudowanych funkcji pomocniczych OpenMP.

---

## 1. Dyrektywa `#pragma omp parallel`
Każdy kod umieszczony w bloku pod tą dyrektywą zostanie wykonany przez wszystkie wątki należące do zespołu:

```cpp
#pragma omp parallel
{
    // Ten kod jest uruchamiany współbieżnie przez każdy wątek
}
```

### Ważne zasady:
*   Wątki mają swój własny stos, więc zmienne zadeklarowane **wewnątrz** tego bloku są automatycznie prywatne dla każdego wątku.
*   Zmienne zadeklarowane **na zewnątrz** bloku są współdzielone (wszystkie wątki widzą tę samą instancję zmiennej).

---

## 2. Podstawowe API z `<omp.h>`

Biblioteka OpenMP dostarcza funkcje runtime do pobierania stanu środowiska równoległego:

### A. Identyfikacja wątku: `omp_get_thread_num()`
Zwraca unikalny numer bieżącego wątku z przedziału `[0, N-1]`, gdzie `N` to liczba aktywnych wątków.
*   Wątek główny (Master) zawsze otrzymuje numer `0`.

### B. Pobieranie liczby wątków: `omp_get_num_threads()`
Zwraca liczbę wątków aktualnie wykonujących region równoległy.
*   *Uwaga*: Jeśli wywołasz tę funkcję poza regionem równoległym (np. w sekwencyjnej funkcji `main`), zawsze zwróci `1`!

---

## 3. Kontrola Liczby Wątków

Możesz kontrolować, ile wątków zostanie utworzonych, na trzy sposoby (w kolejności od najwyższego priorytetu):

### Sposób A: Klauzula `num_threads` bezpośrednio w dyrektywie
Najbardziej elastyczny sposób w kodzie:
```cpp
#pragma omp parallel num_threads(4)
{
    // Zostaną utworzone dokładnie 4 wątki (niezależnie od ustawień systemu)
}
```

### Sposób B: Funkcja `omp_set_num_threads()`
Ustawia domyślną liczbę wątków dla kolejnych bloków równoległych w programie:
```cpp
omp_set_num_threads(8);
#pragma omp parallel
{
    // Ten blok (i każdy kolejny) użyje 8 wątków
}
```

### Sposób C: Zmienna środowiskowa `OMP_NUM_THREADS`
Ustawiana przed uruchomieniem skompilowanego programu w konsoli. Zmienia zachowanie programu bez konieczności ponownej kompilacji:
```bash
export OMP_NUM_THREADS=12
./test_omp
```

---

## 🛠️ Ćwiczenie Praktyczne: Podział Pracy według ID
Wklej poniższy kod do pliku `test_omp2.cc`:

```cpp
#include <iostream>
#include <vector>
#include <omp.h>

int main() {
    std::vector<int> dane(16, 0);

    #pragma omp parallel num_threads(4)
    {
        int tid = omp_get_thread_num();
        int n_threads = omp_get_num_threads();
        
        // Każdy wątek wykonuje obliczenia dla swojej ćwiartki wektora
        int chunk_size = dane.size() / n_threads;
        int start = tid * chunk_size;
        int end = start + chunk_size;

        for (int i = start; i < end; ++i) {
            dane[i] = tid * 100 + i;
        }
    }

    // Weryfikacja wyniku (sekwencyjnie)
    for (int val : dane) {
        std::cout << val << " ";
    }
    std::cout << std::endl;

    return 0;
}
```

Skompiluj i uruchom:
```bash
g++ -std=c++17 -fopenmp test_omp2.cc -o test_omp2
./test_omp2
```

**Zastanów się:**
*   Dlaczego ten podział pracy był w 100% bezpieczny i nie spowodował wyścigu o dane (Data Race), mimo że tablica `dane` jest współdzielona?
