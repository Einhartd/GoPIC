# Lekcja 5: Hybryda MPI + OpenMP (Wielowątkowość w MPI)

Opanowałeś już OpenMP (pamięć współdzieloną) i poznałeś podstawy MPI (pamięć rozproszoną). Nadszedł czas na połączenie obu tych technologii w jeden potężny model hybrydowy: **MPI + OpenMP** (często nazywany "MPI + X").

---

## 1. Architektura Hybrydowa: Kiedy i Po Co?

Wyobraź sobie nowoczesny klaster HPC:
*   Składa się z wielu fizycznych serwerów (węzłów obliczeniowych / Nodes) połączonych szybką siecią (np. InfiniBand).
*   Każdy węzeł posiada 2 procesory AMD EPYC, z których każdy ma po 64 fizyczne rdzenie procesora (łącznie 128 rdzeni na jeden komputer) dzielące wspólną pamięć RAM.

Jak to efektywnie oprogramować?
*   Gdybyśmy uruchomili **tylko MPI** (128 procesów MPI na jednym węźle), sieć i bufory systemowe byłyby przeciążone komunikacją lokalną. Dodatkowo procesy dublowałyby te same struktury w pamięci RAM.
*   Gdybyśmy uruchomili **tylko OpenMP** (jeden proces i 128 wątków), nie moglibyśmy wyjść poza ten jeden komputer.
*   **Hybryda**: Uruchamiamy 1 proces MPI na gniazdo procesora (Socket), a każdy proces MPI tworzy wątki OpenMP na podległych mu rdzeniach. 
    *   MPI zajmuje się komunikacją między procesorami (za pomocą sieci lub szybkiej pamięci współdzielonej jądra).
    *   OpenMP zajmuje się zrównolegleniem obliczeń lokalnych na rdzeniach danego procesora.

---

## 2. Cztery Poziomy Wspierania Wątków w MPI (Thread Safety Levels)

Gdy łączymy wątki (OpenMP) z procesami (MPI), biblioteka MPI musi wiedzieć, jak obsługiwać wywołania funkcji komunikacyjnych z wielu wątków jednocześnie. Standard MPI definiuje 4 poziomy wsparcia:

1.  **`MPI_THREAD_SINGLE`**:
    Tylko jeden wątek (główny) istnieje w programie. Odpowiednik czystego MPI bez OpenMP.
2.  **`MPI_THREAD_FUNNELED`**:
    Program może być wielowątkowy (OpenMP), ale **tylko wątek główny** (Master Thread) może wywoływać funkcje MPI. Wszystkie operacje komunikacji muszą być wywoływane poza regionami równoległymi OpenMP lub wewnątrz bloku `#pragma omp master`.
3.  **`MPI_THREAD_SERIALIZED`**:
    Wiele wątków może wywoływać funkcje MPI, ale **nie jednocześnie**. Wywołania muszą być zserializowane (np. zabezpieczone sekcją `#pragma omp critical`).
4.  **`MPI_THREAD_MULTIPLE`**:
    Dowolny wątek może wywołać dowolną funkcję MPI w dowolnym momencie bez żadnych ograniczeń. Wymaga to w pełni bezpiecznej wątkowo (Thread-Safe) biblioteki MPI, co może narzucać lekki narzut wydajnościowy.

---

## 3. Inicjalizacja Hybrydowa: `MPI_Init_thread`

Aby zgłosić zapotrzebowanie na poziom wsparcia wątków, zamiast standardowego `MPI_Init` używamy funkcji `MPI_Init_thread`:

```cpp
int MPI_Init_thread(
    int* argc,            // Wskaźnik do argc z main
    char*** argv,         // Wskaźnik do argv z main
    int required,         // Pożądany poziom wsparcia (np. MPI_THREAD_FUNNELED)
    int* provided         // Rzeczywiście przydzielony poziom przez bibliotekę MPI
);
```

### Jaki poziom wybrać dla eduPIC?
Dla symulacji cząsteczkowych typu PIC (w tym `eduPIC`) optymalnym wyborem jest **`MPI_THREAD_FUNNELED`**:
1.  Wątki OpenMP wykonują najcięższą pracę lokalnie (ruch cząstek, depozycja ładunku, zderzenia).
2.  Po zakończeniu fazy obliczeniowej wątki są synchronizowane (barierą OpenMP).
3.  Następnie **tylko wątek główny** (Master) wykonuje wywołanie `MPI_Allreduce` w celu synchronizacji globalnej siatki.
4.  Dzięki temu unikamy narzutów związanych z blokowaniem wątków w bibliotece MPI i zachowujemy maksymalną wydajność.

---

## 4. Przykład: Inicjalizacja Hybrydowa MPI + OpenMP

Poniższy program pokazuje poprawny sposób inicjalizacji hybrydowej i weryfikacji przyznanego poziomu bezpieczeństwa:

```cpp
#include <iostream>
#include <mpi.h>
#include <omp.h>

int main(int argc, char* argv[]) {
    int required = MPI_THREAD_FUNNELED;
    int provided;

    // 1. Inicjalizacja z obsługą wątków
    MPI_Init_thread(&argc, &argv, required, &provided);

    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    if (rank == 0) {
        std::cout << "[Master MPI] Inicjalizacja hybrydowa zakonczona." << std::endl;
        std::cout << "[Master MPI] Liczba procesow MPI: " << size << std::endl;
        
        // Sprawdzamy przyznany poziom wsparcia wątków
        if (provided < required) {
            std::cout << "Ostrzezenie: Biblioteka MPI nie wspiera poziomu MPI_THREAD_FUNNELED!" << std::endl;
        } else {
            std::cout << "Sukces: Poziom MPI_THREAD_FUNNELED jest wspierany." << std::endl;
        }
    }

    // 2. Region równoległy OpenMP wewnątrz procesu MPI
    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int num_threads = omp_get_num_threads();
        
        // Zabezpieczone wypisywanie na ekran
        #pragma omp critical
        {
            std::cout << "Proces MPI Rank [" << rank << "] / Watek OpenMP [" 
                      << tid << " z " << num_threads << "]" << std::endl;
        }
        
        // Poniższe wywołanie MPI jest bezpieczne tylko w wątku głównym (tid == 0)
        if (tid == 0) {
            // Wątek główny może wykonywać operacje MPI (np. bariera synchronizująca procesy)
            MPI_Barrier(MPI_COMM_WORLD);
        }
    }

    MPI_Finalize();
    return 0;
}
```

### Kompilacja i uruchomienie hybrydy:
Kompilujemy, łącząc kompilator MPI i flagę OpenMP:
```bash
mpicxx -O3 -fopenmp main.cpp -o program_hybrid
```
Uruchamiamy, określając liczbę procesów MPI oraz liczbę wątków OpenMP na proces:
```bash
export OMP_NUM_THREADS=4
mpirun -np 2 ./program_hybrid
```
Powyższa komenda uruchomi **2 procesy MPI**, a każdy z nich utworzy wewnątrz **4 wątki OpenMP** (łącznie zaangażowanych będzie 8 rdzeni procesora).
