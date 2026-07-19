# Kurs OpenMP - Lekcja 4: Widoczność Danych (Data Sharing) i Thread-Local Storage

W tej lekcji dowiesz się, jak kontrolować, które dane są współdzielone, a które prywatne dla wątków, oraz poznasz technologię Thread-Local Storage.

---

## 1. Klauzule Data-Sharing w OpenMP

Widocznością zmiennych sterujemy bezpośrednio przy wejściu do bloku równoległego:

### A. `shared(zmienna)`
Wskazuje, że zmienna jest wspólna dla wszystkich wątków. 
*   *Zagrożenie*: Wyścigi o dane (Data Race). Wymaga ostrożności lub synchronizacji przy zapisie.

### B. `private(zmienna)`
Każdy wątek otrzymuje kopię zmiennej na swoim prywatnym stosie.
*   *Ważne*: Kopia prywatna **nie jest inicjalizowana** wartością zmiennej oryginalnej przed blokiem (zawiera śmieci z pamięci).

### C. `firstprivate(zmienna)`
Podobnie jak `private`, ale każdy wątek rozpoczyna z kopią zainicjalizowaną wartością zmiennej sprzed bloku:
```cpp
int start_val = 42;
#pragma omp parallel private(start_val) // start_val w wątkach ma losową wartość!
#pragma omp parallel firstprivate(start_val) // start_val w każdym wątku wynosi 42!
```

---

## 2. Domyślna Widoczność: `default(none)`

Dobrą praktyką w OpenMP jest wyłączenie domyślnej widoczności za pomocą `default(none)`. Wymusza to na programiście jawne zadeklarowanie widoczności dla **każdej** zmiennej zewnętrznej użytej w bloku. Zapobiega to przypadkowym wyścigom o dane:

```cpp
int a = 10, b = 20, c = 0;
#pragma omp parallel default(none) shared(a, b, c)
{
    // Kompilator zgłosiłby błąd, gdybyśmy zapomnieli dodać 'shared' lub 'private' dla a, b lub c!
}
```

---

## 3. Thread-Local Storage (TLS) i `thread_local`

W nowoczesnym C++ (od C++11) istnieje wbudowane słowo kluczowe `thread_local`. Zmienna zadeklarowana jako `thread_local` istnieje przez cały czas życia wątku systemowego (a nie tylko do końca pętli, jak zmienne z klauzulą `private`).

### Kiedy stosować `thread_local`?
*   Gdy zmienna ma duży koszt inicjalizacji (np. generator liczb losowych `std::mt19937` albo dystrybucje statystyczne), i nie chcemy jej tworzyć na nowo w każdym kroku pętli.
*   Gdy chcemy mieć zmienną globalną o unikalnej wartości dla każdego wątku.

### Przykład z RNG (Random Number Generator):
```cpp
#include <random>
#include <omp.h>

// Każdy wątek otrzyma swój własny, niezależny generator, zainicjalizowany unikalnym ziarnem.
inline thread_local std::random_device rd{}; 
inline thread_local std::mt19937 MTgen(rd());
inline thread_local std::uniform_real_distribution<> R01(0.0, 1.0);
```

---

## 🛠️ Ćwiczenie Praktyczne: Detekcja błędów z `default(none)`
Spróbuj skompilować poniższy kod:

```cpp
#include <iostream>
#include <omp.h>

int main() {
    int suma = 0;
    int mnoznik = 3;

    #pragma omp parallel for default(none)
    for (int i = 0; i < 10; ++i) {
        suma += i * mnoznik;
    }

    return 0;
}
```

**Zadanie:**
*   Skompiluj powyższy kod. Zobacz, jaki błąd zgłasza kompilator.
*   Popraw kod, dopisując odpowiednie klauzule `shared` i `private` dla zmiennych `suma` oraz `mnoznik`.
