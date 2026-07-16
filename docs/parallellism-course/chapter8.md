# Rozdział 8: Programowanie Równoległe na HPC (Superkomputery)

Kiedy rozmiar symulacji fizycznej (np. siatki i liczby cząstek w kodzie eduPIC) przekracza możliwości pojedynczego komputera PC, musimy przenieść obliczenia na superkomputer. Infrastruktura HPC (High-Performance Computing) opiera się na klastrach – tysiącach komputerów (węzłów obliczeniowych – *nodes*) połączonych siecią o ekstremalnie niskich opóźnieniach (np. InfiniBand).

---

## 1. Pamięć Rozproszona (Distributed Memory)

Na superkomputerze węzły obliczeniowe nie współdzielą pamięci RAM. Węzeł A nie może bezpośrednio przeczytać ani modyfikować pamięci węzła B.

```
[ Węzeł A (RAM A) ] <===============> [ Węzeł B (RAM B) ]
                          Sieć InfiniBand
```

Jeśli program na węźle A potrzebuje danych z węzła B, dane te muszą zostać fizycznie spakowane, przesłane przez kartę sieciową i odebrane przez węzeł B. Ten model programowania nazywamy **programowaniem z pamięcią rozproszoną**.

---

## 2. Standard MPI (Message Passing Interface)

MPI to standard biblioteczny definiujący model przesyłania komunikatów. Jest to podstawowe narzędzie pracy w HPC.

### Podstawowe pojęcia:
*   **Proces MPI**: Zamiast wątków, uruchamiamy niezależne procesy (np. 1 proces na każdy rdzeń klastra). Każdy proces ma swój identyfikator (tzw. **Rank**, od 0 do $N-1$) oraz zna całkowitą liczbę procesów (**Size**).
*   **Komunikator (`MPI_COMM_WORLD`)**: Grupa procesów, które mogą się ze sobą komunikować.

### Typy komunikacji:
1.  **Komunikacja punkt-punkt (Point-to-Point)**: Przesyłanie wiadomości od jednego konkretnego procesu do drugiego.
    *   `MPI_Send` – wysłanie bufora danych.
    *   `MPI_Recv` – odebranie bufora danych.
2.  **Komunikacja grupowa (Collective Communication)**: Operacje angażujące wszystkie procesy w komunikatorze jednocześnie.
    *   `MPI_Bcast` (Broadcast) – jeden proces (np. rank 0) wysyła te same dane do wszystkich pozostałych.
    *   `MPI_Scatter` – podzielenie tablicy na równe części i wysłanie każdej części do innego procesu.
    *   `MPI_Gather` – zebranie częściowych wyników ze wszystkich procesów i złożenie ich w jedną dużą tablicę.
    *   `MPI_Reduce` – zebranie danych ze wszystkich procesów i wykonanie na nich operacji matematycznej (np. wyliczenie globalnej sumy energii cząstek).

```
MPI_Scatter:  [ A, B, C, D ]  ===>  Proc 0: [A], Proc 1: [B], Proc 2: [C], Proc 3: [D]
MPI_Gather:   Proc 0: [A], Proc 1: [B]  ===>  [ A, B ]
```

---

## 3. Model Hybrydowy (MPI + OpenMP)

Jest to „złoty standard” nowoczesnych programów obliczeniowych. Łączy zalety obu modeli:
*   Używamy **MPI** do komunikacji między węzłami klastra (pamięć rozproszona, komunikacja sieciowa).
*   Wewnątrz każdego węzła, który posiada np. 64 lub 128 rdzeni, używamy **OpenMP** lub wątków Go/C++ (pamięć współdzielona RAM, brak narzutu sieciowego).

Dzięki temu minimalizujemy liczbę komunikatów sieciowych, co znacząco zwiększa skalowalność programu.

---

## 4. Akceleracja GPU i CPU Affinity

### GPGPU (General-Purpose Computing on GPUs)
Karty graficzne posiadają tysiące małych rdzeni zoptymalizowanych pod kątem operacji SIMD (masowe obliczenia matematyczne na macierzach). 
W HPC przenosi się najbardziej wymagające obliczeniowo części kodu (np. solver Poissona, interpolację pól) do pamięci GPU przy użyciu standardu **CUDA** (dla kart Nvidia) lub dyrektyw **OpenACC / OpenMP Target**.

### Powinowactwo CPU (CPU Affinity / Thread Pinning)
System operacyjny domyślnie potrafi przenosić wątki między rdzeniami procesora (migracja wątków), aby równomiernie schłodzić krzem. W obliczeniach HPC migracja ta jest katastrofalna dla wydajności, ponieważ niszczy lokalność danych w pamięci cache L1/L2 (Rozdział 2).
*   **Thread Pinning**: Wymuszenie w konfiguracji zadania (np. w SLURM), aby konkretny proces/wątek był na stałe „przypięty” do jednego fizycznego rdzenia. Zapobiega to utracie danych z cache i drastycznie skraca czas obliczeń.

---

## Polecana literatura i źródła zewnętrzne:
*   **Książka**: William Gropp, Ewing Lusk, Anthony Skjellum – *„Using MPI: Portable Parallel Programming with the Message-Passing Interface”*.
*   **Podręcznik online**: **LLNL MPI Tutorial** (Lawrence Livermore National Laboratory).
*   **Kurs wideo**: Wykłady wideo o architekturze HPC (np. ośrodki EPCC, HLRS, ICM UW).
