# Globalne Strategie Zrównoleglania i Porównanie Języków (C++, Go, Python)

Niniejszy dokument definiuje spójną metodologię i strategie zrównoleglania dla wszystkich trzech języków w projekcie **GoPIC**. Aby porównanie wydajności było naukowe i rzetelne, zachowujemy **identyczny algorytm fizyczny** (dekompozycja cząstek ze współdzieloną siatką) i testujemy dwa główne modele programowania współbieżnego.

---

## 1. Dwa Główne Modele Zrównoleglania

```
                          ┌────────────────────────────────┐
                          │    Strategie Zrównoleglania    │
                          └───────────────┬────────────────┘
                                          │
                  ┌───────────────────────┴───────────────────────┐
                  ▼                                               ▼
         [ Model A: Shared Memory ]                    [ Model B: Message Passing ]
         - Pamięć współdzielona                        - Przesyłanie komunikatów
         - Brak kopii tablic cząstek                   - Osobne przestrzenie adresowe
         - Skalowanie w ramach 1 węzła                 - Skalowanie na klastrach (HPC)
```

### Model A: Pamięć Współdzielona (Shared Memory)
W tym modelu wszystkie wątki/gorutyny mają bezpośredni dostęp do wspólnego obszaru pamięci z cząstkami. Podział dotyczy indeksów pętli cząstek. Wszelkie kolizje przy zapisie na siatkę gęstości są rozwiązywane za pomocą redukcji tablicowych (kopie lokalne siatek scalane po zakończeniu obliczeń).

*   **C++ (OpenMP)**:
    *   *Realizacja*: Dyrektywy `#pragma omp parallel for reduction(+:e_density[0:N_G])` w fazach depozycji.
    *   *RNG*: `thread_local std::mt19937` na każdym wątku.
*   **Go (Worker Pool)**:
    *   *Realizacja*: Gorutyny uruchamiane za pomocą `sync.WaitGroup`. Każdy worker dostaje wycinek (*slice*) cząstek do obliczenia i własną lokalną siatkę gęstości. Scalanie siatek odbywa się sekwencyjnie w pamięci po zakończeniu wątków.
    *   *RNG*: Osobne instancje `rand.Rand` z unikalnymi seedami na gorutynę.
*   **Python (Numba Parallel)**:
    *   *Realizacja*: Wykorzystanie `@njit(parallel=True, fastmath=True)` i pętli `prange` do automatycznego zrównoleglenia przez kompilator Numba (LLVM) w pamięci współdzielonej.
    *   *RNG*: Własne generatory na wątek lub sekwencyjne pre-losowanie w NumPy.

---

### Model B: Przesyłanie Komunikatów (Message Passing)
W tym modelu rezygnujemy z bezpośredniego dostępu do wspólnej pamięci. Procesy/gorutyny działają niezależnie, a synchronizacja i wymiana informacji o siatkach gęstości oraz polach elektrycznych odbywa się poprzez jawne przesyłanie komunikatów.

*   **C++ (MPI)**:
    *   *Realizacja*: Osobne procesy MPI uruchamiane przez `mpirun`. Wymiana siatek gęstości za pomocą `MPI_Allreduce(MPI_IN_PLACE, e_density, ...)`. Pliki i wejście/wyjście obsługiwane wyłącznie przez Mastera (Rank 0).
*   **Go (Coordinator-Worker via Channels)**:
    *   *Realizacja*: Gorutyna Koordynatora (odpowiednik Rank 0) zarządza solverem Poissona i plikami. Gorutyny Pracowników przesyłają swoje tablice gęstości przez kanały (`chan []float64`) do Koordynatora, a ten odsyła im zredukowane pole elektryczne.
*   **Python (MPI / multiprocessing.Queue)**:
    *   *Realizacja*:
        *   *Opcja standardowa*: Zastosowanie biblioteki `mpi4py` (odpowiednik MPI z C++) do uruchomienia rozproszonych procesów Pythona.
        *   *Opcja alternatywna*: Wykorzystanie `multiprocessing.Process` oraz kolejek `Queue` do przesyłania tablic NumPy między procesami.

---

### Model C: Potokowość Asynchroniczna (Pipeline Parallelism - "Out-of-Order PIC")
W tym modelu tradycyjny synchroniczny cykl PIC zostaje rozbity na niezależne etapy potoku obliczeniowego, połączone buforowanymi kolejkami/kanałami. Dane płyną strumieniowo. Dopuszczamy asynchroniczność czasową (np. Mover w kroku $t+1$ może pracować na polu elektrycznym z kroku $t$, podczas gdy Collision Mover kończy krok $t$).

*   **Go**:
    *   *Realizacja*: Wykorzystanie natywnej składni kanałów (`chan`) i gorutyn. Jest to wysoce wydajne dzięki wbudowanemu schedulerowi G-M-P, który przełącza gorutyny w przestrzeni użytkownika przy oczekiwaniu na kanałach bez narzutu jądra OS.
*   **C++ / Python (Ograniczenia technologiczne - kluczowy wniosek badawczy)**:
    *   *C++*: Teoretycznie możliwe, lecz skrajnie trudne w implementacji. Wymagałoby ręcznego pisania niskopoziomowych kolejek typu *lock-free* i synchronizacji wątków systemowych (brak wbudowanych kanałów), co drastycznie zwiększa złożoność kodu.
    *   *Python*: Nieefektywne z powodu narzutu IPC (Inter-Process Communication). Ze względu na blokadę GIL, potok musiałby działać na procesach (`multiprocessing`), co przy przesyłaniu dużych tablic cząstek przez kolejki systemowe wygenerowałoby narzut serializacji paraliżujący wydajność.
    *   *Wniosek*: **Model C jest w praktyce unikalną zaletą języka Go**, pokazującą jak model współbieżności CSP zmienia myślenie o strukturze symulacji fizycznych.

---

## 2. Metodologia Pomiarów i Porównań (Benchmarki)

Aby pomiary były wiarygodne, każde wykonanie testowe musi spełniać następujące warunki:

1.  **Determinizm (RNG Alignment)**:
    Generatory liczb losowych na wątkach/procesach muszą być inicjalizowane deterministycznymi, przewidywalnymi ziarnami (*seeds*). Pozwoli to na weryfikację, czy programy w różnych językach dają **statystycznie i numerycznie identyczne wyniki fizyczne** na koniec symulacji.
2.  **Wykluczenie I/O z pomiarów (Pure Compute)**:
    Zapisy na dysk (np. XT, eepf, ifed) oraz ładowanie cząstek z plików binarnych muszą być mierzone osobno. Czas porównawczy powinien dotyczyć wyłącznie **głównej pętli obliczeniowej cykli** (Move + Collision + Poisson).
3.  **Metryki Skalowania**:
    *   **Czas wykonania ($T_p$)**: Czas trwania symulacji dla $p$ wątków/procesów.
    *   **Przyspieszenie ($S_p$)**: $S_p = T_1 / T_p$.
    *   **Efektywność ($E_p$)**: $E_p = S_p / p \times 100\%$.
4.  **Badanie Narzutów Systemowych**:
    *   **Narzut GC (Garbage Collection)**: Mierzenie czasu wstrzymania programu (Stop-The-World) w Go i Pythonie przy intensywnych alokacjach.
    *   **Page Faults (Błędy stron)**: Weryfikacja, czy implementacje nie alokują niepotrzebnie pamięci na stercie w pętli czasowej.
