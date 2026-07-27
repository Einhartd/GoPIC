# Lekcja 1: Wprowadzenie do MPI i Świata Pamięci Rozproszonej

Witaj w pierwszej lekcji kursu MPI! Skoro znasz już OpenMP, wiesz jak pisać programy, w których wiele wątków współdzieli tę samą pamięć (zmienne globalne, tablice itp.). Teraz przechodzimy do zupełnie innego paradygmatu – **pamięci rozproszonej (Distributed Memory)**.

---

## 1. Pamięć Współdzielona (OpenMP) vs Pamięć Rozproszona (MPI)

Wyobraź sobie dwa biura:
*   **OpenMP (Pamięć Współdzielona)**: Wszyscy pracownicy (wątki) siedzą w jednym pokoju przy jednym wielkim stole. Mogą bezpośrednio sięgać po te same dokumenty (zmienne globalne). Jest to proste, ale jeśli dwaj pracownicy spróbują jednocześnie pisać na tej samej kartce, dochodzi do wyścigu (data race). Ponadto nie da się w ten sposób połączyć pracowników siedzących w różnych budynkach.
*   **MPI (Pamięć Rozproszona)**: Każdy pracownik (proces) siedzi w swoim własnym, zamkniętym gabinecie. Nie ma wspólnego biurka. Pracownik z Gabinetu 0 nie może zajrzeć do dokumentów w Gabinecie 1. Jedynym sposobem na wymianę informacji jest wysłanie listu (wiadomości sieciowej). Jest to bezpieczniejsze (brak bezpośrednich wyścigów o pamięć) i pozwala na łączenie tysięcy komputerów w sieć, ale wymaga jawnego przesyłania danych.

| Cecha | OpenMP | MPI |
| :--- | :--- | :--- |
| **Architektura** | Współdzielona pamięć (jeden proces, wiele wątków) | Rozproszona pamięć (wiele niezależnych procesów) |
| **Komunikacja** | Niejawna (odczyt/zapis wspólnych zmiennych) | Jawna (przesyłanie komunikatów przez sieć) |
| **Skalowalność** | Ograniczona do jednej maszyny (np. 64-128 rdzeni) | Prawie nieograniczona (tysiące węzłów na klastrach HPC) |
| **Wyścigi o dane** | Bardzo łatwe do popełnienia (wymagają blokad) | Niemożliwe w obrębie pamięci (procesy nie dzielą zmiennych) |

---

## 2. Paradygmat SPMD (Single Program Multiple Data)

W standardzie MPI dominuje paradygmat **SPMD**. Oznacza to, że:
1.  Piszemy **jeden kod** w C++.
2.  Kompilujemy go do **jednego pliku wykonywalnego** (binarium).
3.  Uruchamiamy go za pomocą programu startowego (np. `mpirun` lub `mpiexec`), wskazując liczbę procesów (np. 4).
4.  System operacyjny uruchamia **4 kopie tego samego programu** (jako 4 osobne procesy w systemie).

### Jak procesy rozróżniają, co mają robić?
Każdy uruchomiony proces otrzymuje swój unikalny identyfikator – liczbę całkowitą od `0` do `N-1` (gdzie `N` to liczba procesów). Identyfikator ten w świecie MPI nazywa się **Rank**.

W kodzie piszemy instrukcje warunkowe bazujące na tym identyfikatorze:
```cpp
int rank;
MPI_Comm_rank(MPI_COMM_WORLD, &rank);

if (rank == 0) {
    // Rób rzeczy przeznaczone dla procesu głównego (Master)
} else {
    // Rób rzeczy dla procesów pomocniczych (Workers)
}
```

---

## 3. Podstawowe API MPI (Inicjalizacja i Środowisko)

Aby napisać poprawny program MPI w C++, musimy dołączyć nagłówek `<mpi.h>` i użyć pięciu podstawowych funkcji:

1.  **`MPI_Init(&argc, &argv)`**:
    Inicjalizuje środowisko MPI. Musi być wywołana na samym początku funkcji `main`, przed jakimkolwiek innym wywołaniem MPI.
2.  **`MPI_Finalize()`**:
    Zamyka środowisko MPI i czyści zasoby. Musi być wywołana na samym końcu działania programu (przed `return 0` w `main`). Po jej wywołaniu nie wolno już używać żadnych funkcji MPI.
3.  **`MPI_Comm_size(communicator, &size)`**:
    Pobiera całkowitą liczbę uruchomionych procesów i zapisuje ją do zmiennej `size`.
4.  **`MPI_Comm_rank(communicator, &rank)`**:
    Pobiera identyfikator (od `0` do `size-1`) aktualnego procesu i zapisuje go do zmiennej `rank`.
5.  **`MPI_Wtime()`**:
    Zwraca czas (w sekundach jako `double`) od pewnego punktu w przeszłości. Używana do precyzyjnego mierzenia czasu wykonania kodu (odpowiednik `omp_get_wtime()`).

### Co to jest `MPI_COMM_WORLD`?
Jest to domyślny **komunikator** w MPI. Komunikator to grupa procesów, które mogą się ze sobą komunikować. `MPI_COMM_WORLD` reprezentuje **wszystkie** procesy uruchomione w ramach danego zadania.

---

## 4. Pierwszy Program: Hello World w MPI

Oto kompletny kod w C++ ilustrujący powyższe pojęcia:

```cpp
#include <iostream>
#include <mpi.h>

int main(int argc, char* argv[]) {
    // 1. Inicjalizacja środowiska MPI
    MPI_Init(&argc, &argv);

    int rank;
    int size;

    // 2. Pobranie rangi (identyfikatora) procesu
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    // 3. Pobranie łącznej liczby procesów
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // Mierzenie czasu
    double start_time = MPI_Wtime();

    // Każdy proces wypisuje swoją własną informację!
    std::cout << "Czesc! Jestem procesem MPI o randze " << rank 
              << " z " << size << " aktywnych procesow." << std::endl;

    // Symulacja pracy
    double end_time = MPI_Wtime();

    if (rank == 0) {
        std::cout << "Proces Master zmierzyl czas wykonania: " 
                  << (end_time - start_time) << " sekund." << std::endl;
    }

    // 4. Zamknięcie środowiska MPI (obowiązkowe!)
    MPI_Finalize();
    return 0;
}
```

---

## 5. Jak kompilować i uruchamiać programy MPI?

Zamiast standardowego `g++` używamy wrappera kompilatora MPI (który automatycznie dołącza odpowiednie biblioteki i nagłówki MPI):

1.  **Kompilacja**:
    ```bash
    mpicxx -O3 main.cpp -o program_mpi
    ```
    *(Dla kodu hybrydowego z OpenMP dodajemy flagę `-fopenmp`: `mpicxx -O3 -fopenmp main.cpp -o program_mpi`)*.

2.  **Uruchomienie (np. na 4 procesach)**:
    ```bash
    mpirun -np 4 ./program_mpi
    ```
    lub na niektórych klastrach:
    ```bash
    mpiexec -n 4 ./program_mpi
    ```

Po uruchomieniu zobaczysz, że linia `Czesc! Jestem procesem...` wypisze się na ekranie **4 razy**, a kolejność wypisywania zależy od tego, jak system operacyjny przydzielił czas procesora poszczególnym procesom (kolejność jest niedeterministyczna).
