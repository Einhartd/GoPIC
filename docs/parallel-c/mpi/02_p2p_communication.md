# Lekcja 2: Komunikacja Punkt-Punkt (Point-to-Point)

W pamięci rozproszonej procesy nie mogą współdzielić zmiennych. Aby przekazać dane z procesu A do procesu B, musimy użyć **komunikacji punkt-punkt (Point-to-Point)**. Oznacza to, że jeden konkretny proces wysyła wiadomość, a drugi konkretny proces ją odbiera.

---

## 1. Wysyłanie i Odbieranie: `MPI_Send` i `MPI_Recv`

Wysyłanie i odbieranie realizowane jest za pomocą dwóch komplementarnych funkcji. Muszą one zawsze występować w parach: jeśli jeden proces woła `MPI_Send`, inny proces musi wywołać `MPI_Recv`.

### Składnia `MPI_Send` (Nadawca):
```cpp
int MPI_Send(
    const void* buf,      // Wskaźnik do wysyłanych danych (bufor)
    int count,            // Liczba wysyłanych elementów (np. 1 dla pojedynczej liczby, 100 dla tablicy)
    MPI_Datatype datatype,// Typ danych MPI (np. MPI_INT, MPI_DOUBLE)
    int dest,             // Ranga procesu docelowego (odbiorcy)
    int tag,              // Unikalny tag wiadomości (liczba całkowita służąca do filtrowania wiadomości)
    MPI_Comm comm         // Komunikator (np. MPI_COMM_WORLD)
);
```

### Składnia `MPI_Recv` (Odbiorca):
```cpp
int MPI_Recv(
    void* buf,            // Wskaźnik do bufora, do którego zostaną zapisane dane
    int count,            // Maksymalna liczba elementów, jaką możemy przyjąć
    MPI_Datatype datatype,// Typ danych MPI
    int source,           // Ranga procesu źródłowego (nadawcy) lub MPI_ANY_SOURCE (dowolny nadawca)
    int tag,              // Oczekiwany tag wiadomości lub MPI_ANY_TAG
    MPI_Comm comm,        // Komunikator
    MPI_Status* status    // Wskaźnik do struktury MPI_Status (lub MPI_STATUS_IGNORE)
);
```

---

## 2. Typy Danych w MPI

Ponieważ programy MPI mogą działać na klastrach składających się z maszyn o różnych architekturach, standard MPI definiuje własne odpowiedniki podstawowych typów danych w C++:

| Typ w C++ | Odpowiednik w MPI |
| :--- | :--- |
| `int` | `MPI_INT` |
| `float` | `MPI_FLOAT` |
| `double` | `MPI_DOUBLE` |
| `char` | `MPI_CHAR` |
| `long long` | `MPI_LONG_LONG` |
| `bool` | `MPI_CXX_BOOL` |

---

## 3. Komunikacja Blokująca vs Nieblokująca

### Komunikacja Blokująca (`MPI_Send` / `MPI_Recv`)
Funkcje te są **blokujące**. Oznacza to, że:
*   `MPI_Send` nie powróci (zablokuje wykonywanie wątku), dopóki system nie zabezpieczy bufora nadawcy (dane zostaną bezpiecznie skopiowane do buforów systemowych lub przesłane do odbiorcy).
*   `MPI_Recv` zablokuje program całkowicie, dopóki wiadomość od nadawcy nie dotrze i dane nie zostaną zapisane w pamięci odbiorcy.

### Zjawisko Zakleszczenia (Deadlock)
Zakleszczenie to sytuacja, w której dwa procesy czekają na siebie nawzajem w nieskończoność. Przy komunikacji blokującej bardzo łatwo o ten błąd.

Wyobraź sobie następujący kod:
```cpp
// BŁĄD: Zakleszczenie!
if (rank == 0) {
    MPI_Recv(data, 100, MPI_DOUBLE, 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE); // czeka na proces 1
    MPI_Send(send_data, 100, MPI_DOUBLE, 1, 0, MPI_COMM_WORLD);
} else if (rank == 1) {
    MPI_Recv(send_data, 100, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE); // czeka na proces 0
    MPI_Send(data, 100, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD);
}
```
Oba procesy rozpoczynają od `MPI_Recv` i blokują się, czekając na wiadomość od partnera. Ponieważ żaden nie przejdzie do `MPI_Send`, program zawiesi się na zawsze.

**Jak tego unikać?**
1.  **Dopasowanie kolejności**: Jeden proces musi najpierw wysyłać, a drugi najpierw odbierać.
2.  **Użycie `MPI_Sendrecv`**: Specjalna funkcja łącząca wysyłanie i odbieranie w jedną bezpieczną, niezakleszczającą się operację.
3.  **Komunikacja Nieblokująca (`MPI_Isend` / `MPI_Irecv`)**: Funkcje te zlecają wysłanie/odbieranie w tle i natychmiast wracają do wykonywania kodu. Wymagają późniejszego wywołania `MPI_Wait` w celu upewnienia się, że transfer się zakończył.

---

## 4. Przykład: Ping-Pong Komunikacyjny

Poniższy program pokazuje bezpieczną wymianę wiadomości (Proces 0 wysyła liczbę do Procesu 1, który ją modyfikuje i odsyła z powrotem):

```cpp
#include <iostream>
#include <mpi.h>

int main(int argc, char* argv[]) {
    MPI_Init(&argc, &argv);

    int rank;
    int size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    if (size < 2) {
        if (rank == 0) {
            std::cerr << "Ten program wymaga co najmniej 2 procesow!" << std::endl;
        }
        MPI_Finalize();
        return 1;
    }

    int ping_pong_count = 0;

    if (rank == 0) {
        // Proces 0 zaczyna: zwiększa licznik i wysyła do 1
        ping_pong_count = 42;
        std::cout << "[Proces 0] Wysylam ping_pong_count = " << ping_pong_count << " do Procesu 1" << std::endl;
        
        MPI_Send(&ping_pong_count, 1, MPI_INT, 1, 0, MPI_COMM_WORLD);
        
        // Czeka na odpowiedź od procesu 1
        MPI_Recv(&ping_pong_count, 1, MPI_INT, 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        std::cout << "[Proces 0] Otrzymalem odpowiedz od Procesu 1: count = " << ping_pong_count << std::endl;

    } else if (rank == 1) {
        // Proces 1 najpierw odbiera
        MPI_Recv(&ping_pong_count, 1, MPI_INT, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        std::cout << "[Proces 1] Otrzymalem ping_pong_count = " << ping_pong_count << std::endl;
        
        // Modyfikuje dane
        ping_pong_count++;
        std::cout << "[Proces 1] Odsylam zmodyfikowany count = " << ping_pong_count << " do Procesu 0" << std::endl;
        
        // Odsyła z powrotem do 0
        MPI_Send(&ping_pong_count, 1, MPI_INT, 0, 0, MPI_COMM_WORLD);
    }

    MPI_Finalize();
    return 0;
}
```
