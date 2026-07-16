# Analiza Topologii NUMA i Rekomendacje Zrównoleglania dla AMD EPYC 9554

Dokument ten zawiera szczegółową analizę topologii sprzętowej węzła obliczeniowego opartego na procesorach **AMD EPYC 9554** (architektura Zen 4 / Genoa) oraz rekomendacje dotyczące optymalnego zrównoleglania kodu w tym środowisku.

---

## 1. Parametry Sprzętowe Węzła (z logów `lscpu`)

*   **Model Procesora**: `AMD EPYC 9554 64-Core Processor` (rodzina architektury Zen 4, 5nm).
*   **Liczba Gniazd (Sockets)**: `2` (system dwuprocesorowy).
*   **Liczba Fizycznych Rdzeni**: `128` (64 rdzenie na gniazdo).
*   **Hyper-Threading (SMT)**: **Wyłączony** (`Thread(s) per core: 1`).
    *   Wątki logiczne 128–255 zostały wyłączone w BIOS (`Off-line CPU(s) list: 128-255`).
    *   *Konsekwencja*: Każdy wątek aplikacji ma do dyspozycji pełny, fizyczny rdzeń procesora. Jest to konfiguracja optymalna dla obliczeń numerycznych o wysokiej intensywności CPU.
*   **Hierarchia Cache L3**: `512 MiB` łącznie, podzielone na **16 niezależnych bloków** (`16 instances`).
    *   Każdy blok L3 ma rozmiar `32 MiB` i jest współdzielony przez 8 rdzeni w ramach jednego chipletu CCD (8 rdzeni × 8 CCD = 64 rdzenie na procesor).

---

## 2. Topologia Pamięci NUMA (NPS = 1)

Węzeł obliczeniowy jest skonfigurowany w trybie **NPS=1** (NUMA nodes Per Socket = 1). Oznacza to podział na dokładnie dwie domeny pamięci współdzielonej:

*   **Domeny NUMA**: `2` (`NUMA node(s): 2`)
*   **Węzeł NUMA 0 (`node0`)**: Przypisany do rdzeni **0–63** (Socket 0 - pierwszy procesor).
*   **Węzeł NUMA 1 (`node1`)**: Przypisany do rdzeni **64–127** (Socket 1 - drugi procesor).

```
+-----------------------------------------------------------------------+
|                            WĘZEŁ OBLICZENIOWY                         |
|                                                                       |
|  +---------------------------------+  +----------------------------+  |
|  |     PROCESOR 1 (Socket 0)       |  |    PROCESOR 2 (Socket 1)    |  |
|  |                                 |  |                            |  |
|  |  [Rdzenie 0-63]                 |  |  [Rdzenie 64-127]          |  |
|  |  [8 CCDs x 32MB L3 Cache]       |  |  [8 CCDs x 32MB L3 Cache]  |  |
|  +---------------------------------+  +----------------------------+  |
|                  |                                   |                |
|       Szybka pamięć lokalna               Szybka pamięć lokalna       |
|                  v                                   v                |
|        [ Pamięć RAM - Node 0 ]             [ Pamięć RAM - Node 1 ]    |
|                  ^                                   ^                |
|                  +============= Szyna QPI ===========+                |
|                            (Wolniejsze połączenie)                    |
+-----------------------------------------------------------------------+
```

---

## 3. Rekomendowane Podejścia do Zrównoleglania (C/C++)

Ze względu na to, że czas dostępu do pamięci RAM podpiętej do drugiego gniazda (zdalny dostęp NUMA) jest znacznie dłuższy niż do pamięci lokalnej, poniżej przedstawiono dwa warianty uruchamiania programu.

### Wariant A: Model Hybrydowy (2 x MPI + 64 x OpenMP) — Rekomendowany

Jest to najbardziej wydajna konfiguracja dla tej architektury. Zamiast jednego procesu z 128 wątkami, uruchamiamy 2 procesy MPI, z których każdy jest sztywno przypięty do jednego gniazda procesora (jednego węzła NUMA) i zarządza 64 wątkami OpenMP.

*   **Zalety**: Całkowita eliminacja kosztownego transferu danych przez szynę międzyprocesorową (QPI/Infinity Fabric) w trakcie obliczeń. Każdy procesor pracuje wyłącznie na swojej lokalnej pamięci.
*   **Konfiguracja SLURM**:
    ```bash
    #SBATCH --nodes=1
    #SBATCH --ntasks-per-node=2     # 2 procesy MPI (po jednym na procesor)
    #SBATCH --cpus-per-task=64      # 64 rdzenie dla każdego procesu MPI
    
    export OMP_NUM_THREADS=64
    export OMP_PLACES=cores
    export OMP_PROC_BIND=close
    
    # Uruchomienie za pomocą srun (SLURM automatycznie przypnie procesy do gniazd NUMA)
    srun ./twoj_program
    ```

### Wariant B: Czyste OpenMP (1 x 128 wątków) — Uproszczony

Jeśli nie chcesz wdrażać MPI, możesz uruchomić program jako jeden proces z 128 wątkami OpenMP. Aby jednak zminimalizować spadek wydajności spowodowany NUMA, należy bezwzględnie przestrzegać poniższych reguł:

1.  **Zastosowanie polityki First-Touch**:
    Zawsze inicjalizuj duże tablice danych w pętli zrównoleglonej przez OpenMP:
    ```cpp
    #pragma omp parallel for
    for (int i = 0; i < N; i++) {
        tablica[i] = 0.0; // Pamięć zostanie fizycznie przydzielona do tego procesora, 
                          // na którym działa wątek inicjalizujący tę część tablicy.
    }
    ```
2.  **Przypięcie wątków**:
    Przed uruchomieniem programu ustaw zmienne środowiskowe, aby zablokować migrację wątków między procesorami:
    ```bash
    export OMP_NUM_THREADS=128
    export OMP_PLACES=cores
    export OMP_PROC_BIND=spread
    ```
    *   `OMP_PROC_BIND=spread` gwarantuje, że wątki zostaną równomiernie rozłożone: 64 wątki na pierwszy procesor (Node 0) i 64 wątki na drugi procesor (Node 1).
