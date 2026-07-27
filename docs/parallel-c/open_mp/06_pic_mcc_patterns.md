# Kurs OpenMP - Lekcja 6: Wzorce Projektowe w Symulacjach PIC/MCC

W tej lekcji poznasz specjalistyczne wzorce zrównoleglania o wysokiej wydajności, które stosuje się w kodach Particle-in-Cell do rozwiązywania problemów specyficznych dla fizyki plazmy.

---

## 1. Wzorzec 1: Prywatyzacja Siatki (Array Privatization)

### Gdzie występuje problem?
W kroku depozycji ładunku (Charge Deposition):
*   Cząstek leżących w przestrzeni ciągłej jest bardzo dużo ($N_e \approx 100\,000$).
*   Siatka węzłów jest bardzo mała ($N_G = 400$).
Wiele wątków jednocześnie próbuje modyfikować te same elementy siatki gęstości ładunku `e_density[p]`, co prowadzi do wyścigów.

### Rozwiązanie (Prywatyzacja tablicy siatki)
1.  Każdy wątek otrzymuje prywatną kopię tablicy siatki (lokalną).
2.  Wątki deponują ładunki swoich cząstek **wyłącznie do swoich prywatnych kopii** bez blokowania szyny pamięci.
3.  Po zakończeniu pętli, wszystkie wątki sumują (redukują) swoje prywatne siatki do jednej siatki globalnej.

```cpp
double density_local[omp_get_max_threads()][N_G];

#pragma omp parallel
{
    int tid = omp_get_thread_num();
    // Zerowanie lokalnej siatki wątku
    for(int p=0; p<N_G; ++p) density_local[tid][p] = 0.0;

    #pragma omp for
    for (int k = 0; k < N_e; ++k) {
        int p = int(x_e[k] * INV_DX);
        density_local[tid][p] += FACTOR_W; // Bezpieczny, bezkonkurencyjny zapis
    }
}

// Redukcja (sumowanie) siatek lokalnych do globalnej
for (int p = 0; p < N_G; ++p) {
    double sum = 0.0;
    for (int t = 0; t < num_threads; ++t) {
        sum += density_local[t][p];
    }
    e_density[p] = sum;
}
```

---

## 2. Wzorzec 2: Lokalne Bufory Wątków na Nowe Cząstki

### Gdzie występuje problem?
Podczas kolizji (np. jonizacji w zderzeniach elektron-argon):
*   Wątki przetwarzają zderzenia elektronów w pętli równoległej.
*   Zderzenie jonizacyjne powoduje narodziny nowego elektronu i nowego jonu, które muszą trafić na koniec globalnych tablic: `x_e[N_e] = xe; N_e++;`.
*   Zapis do globalnego licznika `N_e` i tablicy w tym samym czasie zepsuje dane.

### Rozwiązanie (Thread-Local Buffers)
1.  Wątki przechowują wygenerowane cząstki w swoich lokalnych, małych buforach wątkowych (`vector` lub tablica statyczna).
2.  Po pętli kolizji, wątki kopiują cząstki z buforów lokalnych do globalnych tablic w sposób uporządkowany (np. przy użyciu sekcji krytycznej tylko przy rezerwacji miejsca w globalnej tablicy, co drastycznie ogranicza narzut synchronizacji).

```cpp
#pragma omp parallel
{
    std::vector<double> local_new_x_e; // Prywatny bufor wątku
    
    #pragma omp for
    for (int k = 0; k < N_candidates; ++k) {
        if (ionization_occurs) {
            local_new_x_e.push_back(new_position);
        }
    }

    if (!local_new_x_e.empty()) {
        int global_start_idx;
        #pragma omp critical // Rezerwacja miejsca w globalnej tablicy
        {
            global_start_idx = N_e;
            N_e += local_new_x_e.size();
        }
        // Bezpieczne kopiowanie danych poza sekcją krytyczną!
        std::copy(local_new_x_e.begin(), local_new_x_e.end(), &x_e[global_start_idx]);
    }
}
```

---

## 3. Wzorzec 3: Równoległa Kompresja Tablicy (Stream Compaction)

### Gdzie występuje problem?
W kroku sprawdzania granic (Boundary Check):
*   Cząstki wykraczające poza obszar symulacji muszą zostać usunięte z tablicy.
*   Tradycyjna sekwencyjna metoda "zamiana z ostatnim" (`x[k] = x[N-1]; N--;`) uniemożliwia zrównoleglenie, ponieważ zależy od globalnego licznika `N` i stale przesuwa elementy w sposób nieprzewidywalny dla wątków.

### Rozwiązanie (Stream Compaction)
Algorytm dwuetapowy:
1.  **Oznaczenie i Zliczanie**: Wątki równolegle sprawdzają granice i oznaczają, które cząstki przeżyły (np. flagą 0 lub 1). Wątki zliczają też, ile cząstek z ich puli przeżyło.
2.  **Suma prefiksowa i Kopiowanie**: Obliczamy pozycje docelowe za pomocą sumy prefiksowej (Prefix Sum) i przepisujemy aktywne cząstki do nowej/tymczasowej tablicy (lub z powrotem) w sposób całkowicie niezależny i bezkonkurencyjny.

---

## 🚀 Gratulacje!
Zakończyłeś teoretyczną część kursu OpenMP. W kolejnych krokach zastosujesz te wzorce bezpośrednio w kodzie równoległym [C/parallel-only-omp/simulation.h](file:///home/oliwier/Dev/GoPIC/C/parallel-only-omp/simulation.h).
