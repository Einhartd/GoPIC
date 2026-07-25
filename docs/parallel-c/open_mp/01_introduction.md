# Kurs OpenMP - Lekcja 1: Wprowadzenie do Równoległości

Witaj w pierwszej lekcji kursu OpenMP! Zrozumiemy tutaj, jak działa pamięć współdzielona i jak skompilować pierwszy program wielowątkowy.

---

## 1. Architektura Pamięci Współdzielonej (Shared Memory)
Większość nowoczesnych komputerów osobistych i serwerów posiada procesory z wieloma rdzeniami fizycznymi. Wszystkie te rdzenie mają dostęp do **tej samej, wspólnej pamięci operacyjnej (RAM)**.
*   **Zaleta**: Dowolny wątek może czytać i pisać do dowolnego adresu w pamięci bez konieczności przesyłania danych przez sieć.
*   **Zagrożenie**: Dwa wątki mogą jednocześnie modyfikować tę samą komórkę pamięci, co prowadzi do błędów spójności danych (**wyścigów o dane / data races**).

Istnieją też systemy z pamięcią rozproszoną (np. klastry obliczeniowe HPC, gdzie wiele serwerów łączy się siecią InfiniBand). Do ich programowania używa się standardu **MPI (Message Passing Interface)**. My skupiamy się na OpenMP, czyli programowaniu jednego serwera/komputera.

---

## 2. Model Fork-Join
OpenMP opiera się na modelu **Fork-Join** (Rozgałęzienie-Połączenie):

1.  Program rozpoczyna działanie jako pojedynczy proces z jednym wątkiem głównym (**Master Thread**).
2.  Gdy program napotyka dyrektywę równoległą OpenMP, wątek główny tworzy zespół dodatkowych wątków roboczych (**Fork**).
3.  Wszystkie te wątki wykonują kod wewnątrz sekcji równoległej współbieżnie na różnych rdzeniach procesora.
4.  Na końcu sekcji równoległej znajduje się niejawna bariera synchronizacyjna. Wątki czekają na siebie, po czym są niszczone lub usypiane, a wątek główny kontynuuje wykonanie sekwencyjne (**Join**).

```
Wątek Główny (Master) -------------[Fork]============ Wątki Robocze ============[Join]------------ Wątek Główny (Master)
```

---

## 3. Kompilacja z OpenMP
Dyrektywy OpenMP mają postać pragmatów preprocesora:
```cpp
#pragma omp ...
```
Dzięki temu, jeśli kompilator nie obsługuje OpenMP, po prostu zignoruje te linie i skompiluje program sekwencyjnie!

### Flagi kompilacji:
*   **GCC / Clang**: `-fopenmp` (zarówno przy kompilacji, jak i linkowaniu)
*   **MSVC (Windows)**: `/openmp`

### Nagłówek biblioteczny:
Aby korzystać z funkcji pomocniczych OpenMP, należy dołączyć nagłówek:
```cpp
#include <omp.h>
```

---

## 🛠️ Ćwiczenie Praktyczne: Pierwszy Program
Utwórz plik `test_omp.cc` w dowolnym miejscu i wklej poniższy kod:

```cpp
#include <iostream>
#include <omp.h>

int main() {
    #pragma omp parallel
    {
        std::cout << "Hello World od watku nr " << omp_get_thread_num() << std::endl;
    }
    return 0;
}
```

Skompiluj go w terminalu:
```bash
g++ -std=c++17 -fopenmp test_omp.cc -o test_omp
./test_omp
```

**Zaobserwuj:**
*   Ile razy wypisał się napis?
*   Czy wątki wypisują tekst w tej samej kolejności przy każdym uruchomieniu? Dlaczego?
