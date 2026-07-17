# Kurs OpenMP - Lekcja 5: Synchronizacja i Redukcja (Reductions)

Gdy wiele wątków musi pisać do wspólnej zmiennej (np. sumować wyniki, zliczać cząstki), potrzebujemy mechanizmów synchronizacji w celu uniknięcia wyścigów o dane.

---

## 1. Klauzula Redukcji: `reduction(operator : zmienna)`

Redukcja to najczęstszy i najbardziej wydajny sposób agregowania wyników z pętli równoległej do jednej zmiennej zewnętrznej.

### Jak działa redukcja?
1.  OpenMP automatycznie tworzy **prywatną kopię** zmiennej dla każdego wątku i inicjalizuje ją wartością neutralną dla danego operatora (np. `0` dla dodawania `+`, `1` dla mnożenia `*`).
2.  Każdy wątek wykonuje swoje obliczenia na swojej lokalnej kopii.
3.  Po zakończeniu pętli, OpenMP bezpiecznie i wydajnie sumuje (redukuje) lokalne wartości wszystkich wątków do zmiennej globalnej.

```cpp
int suma = 0;
#pragma omp parallel for reduction(+:suma)
for (int i = 0; i < 100; i++) {
    suma += i; // Bezpieczne i ekstremalnie szybkie!
}
```

---

## 2. Dyrektywy Synchronizacyjne

Jeśli nie możemy użyć gotowej redukcji, musimy ręcznie kontrolować dostęp do pamięci:

### A. `#pragma omp atomic`
Zabezpiecza pojedynczą operację zapisu/modyfikacji komórki pamięci (np. `+=`, `++`, `-=`). Wykorzystuje niskopoziomowe, sprzętowe instrukcje niepodzielne procesora. Jest to **najszybsza ręczna synchronizacja**.
```cpp
#pragma omp atomic
licznik++; // Operacja atomowa, bezpieczna
```

### B. `#pragma omp critical`
Blokuje cały fragment kodu. Tylko jeden wątek może wejść do sekcji krytycznej w danym czasie. Pozostałe wątki czekają w kolejce. Ma **bardzo wysoki narzut** wydajnościowy. Używaj tylko wtedy, gdy operacja jest złożona (np. wywołanie funkcji, alokacja pamięci).
```cpp
#pragma omp critical
{
    // Tylko jeden wątek wykonuje to na raz
    wyniki.push_back(temp_val); 
}
```

### C. `#pragma omp barrier`
Wymusza punkt synchronizacji w zespole wątków. Wszystkie wątki zatrzymują się w tym miejscu i czekają, aż najwolniejszy wątek do nich dołączy.
```cpp
#pragma omp barrier // Wszystkie wątki czekają tutaj na siebie
```

---

## 🛠️ Ćwiczenie Praktyczne: Redukcja vs Atomic vs Critical
Porównajmy wydajność różnych metod synchronizacji. Wklej ten kod do pliku `test_omp5.cc`:

```cpp
#include <iostream>
#include <omp.h>

int main() {
    const int limit = 100000000;
    long long suma = 0;

    double start = omp_get_wtime();

    // SPOSÓB A: Ręczna sekcja krytyczna (bardzo powolna)
    // #pragma omp parallel for
    // for (int i = 0; i < limit; ++i) {
    //     #pragma omp critical
    //     suma += i;
    // }

    // SPOSÓB B: Operacja atomowa (szybsza, ale wciąż z narzutem szyny pamięci)
    // #pragma omp parallel for
    // for (int i = 0; i < limit; ++i) {
    //     #pragma omp atomic
    //     suma += i;
    // }

    // SPOSÓB C: Klauzula redukcji (ekstremalnie szybka)
    #pragma omp parallel for reduction(+:suma)
    for (int i = 0; i < limit; ++i) {
        suma += i;
    }

    double end = omp_get_wtime();
    std::cout << "Suma: " << suma << ", Czas: " << (end - start) << " s" << std::endl;
    return 0;
}
```

**Zadanie:**
*   Odkomentuj i przetestuj kolejno Sposób A, B oraz C (pamiętaj o komentowaniu pozostałych).
*   Zapisz czasy działania. Która metoda wykazuje najlepsze przyspieszenie i dlaczego?
