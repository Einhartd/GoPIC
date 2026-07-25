# Lekcja 3: Komunikacja Zbiorowa (Collective Communication)

W poprzedniej lekcji poznałeś komunikację punkt-punkt, w której dokładnie dwa procesy wymieniały się wiadomościami. Co jednak zrobić, gdy chcemy rozesłać parametry symulacji (np. temperaturę gazu, napięcie na elektrodzie) ze statycznego procesu Master do wszystkich innych 64 procesów? Robienie tego w pętli `for` za pomocą `MPI_Send` byłoby powolne i nieefektywne.

Do tego celu służy **komunikacja zbiorowa (Collective Communication)**, która angażuje wszystkie procesy w komunikatorze jednocześnie.

---

## 1. Dlaczego operacje zbiorowe są wydajniejsze?

Gdyby proces 0 chciał rozesłać wiadomość do 7 procesów za pomocą pętli `for` i `MPI_Send`, musiałby wykonać 7 kolejnych wysyłek, co zajęłoby czas proporcjonalny do $O(P)$ (gdzie $P$ to liczba procesów).

Funkcje zbiorowe MPI pod maską wykorzystują wysoce zoptymalizowane struktury sieciowe (np. **drzewa binarne / hiperkostki**):
1.  W kroku 1: Proces 0 wysyła dane do Procesu 4.
2.  W kroku 2: Proces 0 wysyła do Procesu 2, a Proces 4 wysyła do Procesu 6.
3.  W kroku 3: Procesy 0, 2, 4, 6 wysyłają odpowiednio do procesów 1, 3, 5, 7.
Dzięki temu po zaledwie 3 krokach ($O(\log P)$) wszystkie procesy mają dane! To ogromna różnica wydajnościowa przy dużej liczbie maszyn.

**Złota zasada MPI**: Wszystkie procesy należące do komunikatora (np. `MPI_COMM_WORLD`) **muszą** wywołać tę samą funkcję zbiorową. Jeśli choć jeden proces jej nie wywoła, program się zawiesi.

---

## 2. Podstawowe operacje zbiorowe (One-to-All i All-to-One)

### A. Rozgłaszanie (Broadcast): `MPI_Bcast`
Kopiuje dane z jednego procesu (zwanego **Root**) do wszystkich procesów w komunikatorze.

```cpp
int MPI_Bcast(
    void* buffer,         // Bufor danych (na procesie Root zawiera dane do wysłania, na innych procesach to miejsce na odebrane dane)
    int count,            // Liczba elementów
    MPI_Datatype datatype,// Typ danych MPI
    int root,             // Ranga procesu rozsyłającego (zazwyczaj 0)
    MPI_Comm comm         // Komunikator
);
```

### B. Rozpraszanie (Scatter): `MPI_Scatter`
Dzieli dużą tablicę znajdującą się na procesie Root na równe części i wysyła po jednej części (cunku) do każdego procesu.

```cpp
int MPI_Scatter(
    const void* sendbuf,  // Bufor nadawczy (tylko na procesie Root, rozmiar to: count * size_procesow)
    int sendcount,        // Liczba elementów wysyłanych do pojedynczego procesu
    MPI_Datatype sendtype,// Typ danych nadawanych
    void* recvbuf,        // Bufor odbiorczy na każdym procesie
    int recvcount,        // Liczba elementów odbieranych przez pojedynczy proces (musi być równa sendcount)
    MPI_Datatype recvtype,// Typ danych odbieranych
    int root,             // Ranga procesu dzielącego tablicę
    MPI_Comm comm         // Komunikator
);
```

### C. Zbieranie (Gather): `MPI_Gather`
Odwrotność `MPI_Scatter`. Zbiera po kawałku danych z każdego procesu i łączy je w jedną dużą tablicę na procesie Root.

```cpp
int MPI_Gather(
    const void* sendbuf,  // Lokalny kawałek danych na każdym procesie
    int sendcount,        // Liczba elementów wysyłanych przez proces
    MPI_Datatype sendtype,
    void* recvbuf,        // Bufor zbiorczy (tylko na procesie Root, rozmiar to: sendcount * size_procesow)
    int recvcount,        // Liczba elementów odbieranych od pojedynczego procesu (musi być równa sendcount)
    MPI_Datatype recvtype,
    int root,             // Ranga procesu zbierającego
    MPI_Comm comm         // Komunikator
);
```

---

## 3. Przykład: Scatter, Obliczenia i Gather

Poniższy program ilustruje proces rozpraszania tablicy liczb ze stacji Master (Proces 0), potęgowania ich lokalnie na każdym procesie i zbierania wyników z powrotem na Master:

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

    int elements_per_proc = 2;
    std::vector<double> global_data;
    
    // Tylko Master (Proces 0) inicjalizuje globalną tablicę
    if (rank == 0) {
        global_data.resize(size * elements_per_proc);
        for (size_t i = 0; i < global_data.size(); ++i) {
            global_data[i] = static_cast<double>(i + 1);
        }
        std::cout << "[Master] Dane przed rozproszeniem: ";
        for (double val : global_data) std::cout << val << " ";
        std::cout << std::endl;
    }

    // Każdy proces rezerwuje miejsce na swój lokalny kawałek danych (2 elementy)
    std::vector<double> local_data(elements_per_proc);

    // 1. Rozpraszamy (Scatter) dane do wszystkich procesów
    MPI_Scatter(
        global_data.data(), elements_per_proc, MPI_DOUBLE, // Dane nadawcy (Master)
        local_data.data(), elements_per_proc, MPI_DOUBLE,  // Miejsce u odbiorcy (każdy proces)
        0, MPI_COMM_WORLD                                  // Ranga Root (Master)
    );

    // 2. Każdy proces wykonuje lokalne obliczenia w swojej pamięci
    std::cout << "[Proces " << rank << "] Otrzymalem: " << local_data[0] << ", " << local_data[1] << std::endl;
    local_data[0] *= local_data[0]; // Podniesienie do kwadratu
    local_data[1] *= local_data[1];

    // Bufor na wyniki (tylko na Master)
    std::vector<double> global_results;
    if (rank == 0) {
        global_results.resize(size * elements_per_proc);
    }

    // 3. Zbieramy (Gather) zmodyfikowane dane z powrotem do Master
    MPI_Gather(
        local_data.data(), elements_per_proc, MPI_DOUBLE,    // Dane wysyłane (lokalne wyniki)
        global_results.data(), elements_per_proc, MPI_DOUBLE,// Miejsce zbierania (Master)
        0, MPI_COMM_WORLD                                    // Ranga Root (Master)
    );

    // Master wyświetla ostateczny wynik
    if (rank == 0) {
        std::cout << "[Master] Ostateczny zebrany wynik: ";
        for (double val : global_results) std::cout << val << " ";
        std::cout << std::endl;
    }

    MPI_Finalize();
    return 0;
}
```
