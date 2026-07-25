# Lekcja 4: Redukcje Zbiorowe (Collective Reductions)

W tej lekcji dowiesz się o najważniejszej operacji komunikacyjnej dla naszej symulacji cząsteczkowej: **redukcji zbiorowej (Collective Reduction)**. Redukcja polega na pobraniu wartości ze wszystkich procesów, wykonaniu na nich operacji matematycznej (np. sumowania) i zapisaniu wyniku.

---

## 1. Dwa typy redukcji: `MPI_Reduce` i `MPI_Allreduce`

W zależności od tego, czy wynik końcowy jest potrzebny tylko jednemu procesowi, czy wszystkim, stosujemy jedną z dwóch funkcji:

### A. Redukcja do jednego odbiorcy: `MPI_Reduce`
Zbiera wartości ze wszystkich procesów, wykonuje na nich operację (np. sumowanie) i zapisuje wynik końcowy **tylko** na wyznaczonym procesie **Root** (zazwyczaj proces 0).

```cpp
int MPI_Reduce(
    const void* sendbuf,  // Dane wejściowe lokalnego procesu (tablica lub pojedyncza zmienna)
    void* recvbuf,        // Bufor wynikowy (ma znaczenie tylko na procesie Root)
    int count,            // Liczba redukowanych elementów
    MPI_Datatype datatype,// Typ danych MPI
    MPI_Op op,            // Operacja matematyczna (np. MPI_SUM)
    int root,             // Ranga procesu odbierającego wynik
    MPI_Comm comm         // Komunikator
);
```

### B. Redukcja globalna (Wszyscy do Wszystkich): `MPI_Allreduce`
Zbiera wartości ze wszystkich procesów, wykonuje na nich operację i zapisuje wynik końcowy w buforze odbiorczym **każdego** procesu w komunikatorze. 
*   Jest to logiczny odpowiednik wywołania najpierw `MPI_Reduce` do procesu 0, a następnie rozesłania wyniku przez `MPI_Bcast` do wszystkich innych procesów. Pod maską jest to jednak wysoce zoptymalizowana pojedyncza operacja sieciowa.

```cpp
int MPI_Allreduce(
    const void* sendbuf,  // Dane wejściowe lokalnego procesu
    void* recvbuf,        // Bufor wynikowy (modyfikowany i dostępny na KAŻDYM procesie)
    int count,            // Liczba redukowanych elementów
    MPI_Datatype datatype,
    MPI_Op op,            // Operacja matematyczna
    MPI_Comm comm         // Komunikator
);
```
*(Zauważ, że `MPI_Allreduce` nie posiada argumentu `root`, ponieważ każdy proces jest odbiorcą).*

---

## 2. Dostępne operacje redukcji (`MPI_Op`)

Standard MPI dostarcza zestaw wbudowanych operacji matematyczno-logicznych:

| Operacja MPI | Opis działania |
| :--- | :--- |
| **`MPI_SUM`** | Sumowanie wartości (kluczowe do zliczania ładunków/cząstek) |
| **`MPI_MAX`** | Znajdowanie wartości maksymalnej |
| **`MPI_MIN`** | Znajdowanie wartości minimalnej |
| **`MPI_PROD`** | Iloczyn wartości |
| **`MPI_LAND`** | Koniunkcja logiczna (AND) |
| **`MPI_LOR`** | Alternatywa logiczna (OR) |

---

## 3. Zastosowanie w Particle-in-Cell (PIC)

Dlaczego `MPI_Allreduce` jest kluczem do zrównoleglenia fizyki symulacji plazmy?

W algorytmie **Particle Decomposition** (Dekompozycja cząstek ze współdzieloną siatką):
1.  Proces 0 ma 50 000 elektronów, a Proces 1 ma drugie 50 000 elektronów.
2.  Oba procesy posiadają lokalną siatkę gęstości ładunku `e_density` o rozmiarze $N_G = 400$.
3.  Każdy proces przeprowadza depozycję ładunku **tylko dla swoich cząstek** na swoją lokalną siatkę.
4.  Po depozycji siatki na obu procesach zawierają tylko "częściowe" gęstości.
5.  Wywołujemy `MPI_Allreduce` z operacją `MPI_SUM` na całej tablicy siatki gęstości ($400$ elementów double).
6.  W rezultacie, **obie stacje robocze otrzymują pełną, zsumowaną globalną siatkę gęstości elektronów**, która jest niezbędna do prawidłowego rozwiązania równania Poissona i wyznaczenia pola elektrycznego.

---

## 4. Przykład: Sumowanie lokalnych siatek gęstości

Poniższy program symuluje depozycję ładunku na 5-węzłowej siatce przez 2 procesy MPI, a następnie agreguje wyniki za pomocą `MPI_Allreduce`:

```cpp
#include <iostream>
#include <vector>
#include <mpi.h>

int main(int argc, char* argv[]) {
    MPI_Init(&argc, &argv);

    int rank;
    int size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    const int N_G = 5; // Siatka o rozmiarze 5 węzłów
    std::vector<double> local_density(N_G, 0.0);

    // Symulacja: Procesy deponują ładunki swoich cząstek w różne miejsca
    if (rank == 0) {
        local_density[1] = 10.0;
        local_density[2] = 5.0;
    } else if (rank == 1) {
        local_density[2] = 5.0;
        local_density[3] = 8.0;
    }

    std::cout << "[Proces " << rank << "] Lokalna gestosc: ";
    for (double val : local_density) std::cout << val << " ";
    std::cout << std::endl;

    // Tablica na globalny, zsumowany wynik (dostępny dla każdego procesu)
    std::vector<double> global_density(N_G, 0.0);

    // Redukcja sumująca lokalne siatki w jedną globalną
    MPI_Allreduce(
        local_density.data(),    // Bufor wejściowy (lokalny)
        global_density.data(),   // Bufor wyjściowy (globalny, na każdym procesie)
        N_G,                     // Liczba redukowanych elementów (rozmiar siatki)
        MPI_DOUBLE,              // Typ danych
        MPI_SUM,                 // Operacja sumowania
        MPI_COMM_WORLD           // Komunikator
    );

    // Każdy proces wyświetla globalną siatkę i widzi dokładnie te same, zsumowane wartości!
    std::cout << "[Proces " << rank << "] Zsumowana GLOBALNA gestosc: ";
    for (double val : global_density) std::cout << val << " ";
    std::cout << std::endl;

    MPI_Finalize();
    return 0;
}
```
