#include <iostream>
#include <vector>
#include <chrono>
#include <iomanip>
#include <omp.h>

/*
================================================================================
Mikrobenchmark: Badanie zjawiska False Sharing i weryfikacja alignas(64)
Projekt: GoPIC (Symulacja 1D3V PIC/MCC)
Opis:
  Porównanie wydajności aktualizacji struktur liczników wątkowych:
  - Wariant A (UnalignedCounters): rozmiar 48 B (brak wyrównania, elementy wektora
    dzielą te same 64-bajtowe linie pamięci podręcznej -> False Sharing).
  - Wariant B (AlignedCounters): rozmiar 64 B (alignas(64) - każdy wątek operuje
    na niezależnej linii pamięci podręcznej L1/L2 -> izolacja pamięci cache).
================================================================================
*/

// Dokładna struktura liczników używana w GoPIC (C/parallel-only-omp/state.h)
struct UnalignedCounters {
    volatile double accu_center = 0.0;
    volatile unsigned long long counter_center = 0;
    volatile unsigned long long local_abs_pow = 0;
    volatile unsigned long long local_abs_gnd = 0;
    volatile unsigned long long local_coll_e = 0;
    volatile unsigned long long local_coll_i = 0;
};

struct alignas(64) AlignedCounters {
    volatile double accu_center = 0.0;
    volatile unsigned long long counter_center = 0;
    volatile unsigned long long local_abs_pow = 0;
    volatile unsigned long long local_abs_gnd = 0;
    volatile unsigned long long local_coll_e = 0;
    volatile unsigned long long local_coll_i = 0;
};

// Funkcja testowa dla Wariantu A (z False Sharing)
double run_unaligned(int num_threads, long long iterations) {
    std::vector<UnalignedCounters> counters(num_threads);

    auto start = std::chrono::high_resolution_clock::now();

    #pragma omp parallel num_threads(num_threads)
    {
        int tid = omp_get_thread_num();
        for (long long i = 0; i < iterations; ++i) {
            counters[tid].local_coll_e++;
            counters[tid].local_abs_pow += (i & 1);
        }
    }

    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> diff = end - start;

    // Zabezpieczenie przed usunięciem pętli przez optymalizator (Dead Code Elimination)
    unsigned long long dummy = 0;
    for (int t = 0; t < num_threads; ++t) {
        dummy += counters[t].local_coll_e + counters[t].local_abs_pow;
    }
    if (dummy == 42) std::cout << " "; // nigdy nie zajdzie

    return diff.count();
}

// Funkcja testowa dla Wariantu B (z alignas(64) - brak False Sharing)
double run_aligned(int num_threads, long long iterations) {
    std::vector<AlignedCounters> counters(num_threads);

    auto start = std::chrono::high_resolution_clock::now();

    #pragma omp parallel num_threads(num_threads)
    {
        int tid = omp_get_thread_num();
        for (long long i = 0; i < iterations; ++i) {
            counters[tid].local_coll_e++;
            counters[tid].local_abs_pow += (i & 1);
        }
    }

    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> diff = end - start;

    unsigned long long dummy = 0;
    for (int t = 0; t < num_threads; ++t) {
        dummy += counters[t].local_coll_e + counters[t].local_abs_pow;
    }
    if (dummy == 42) std::cout << " ";

    return diff.count();
}

int main(int argc, char* argv[]) {
    long long iterations = 100'000'000; // 10^8 iteracji
    if (argc > 1) {
        iterations = std::atoll(argv[1]);
    }

    int max_threads = omp_get_max_threads();

    std::cout << "========================================================================\n";
    std::cout << "   GoPIC Microbenchmark: False Sharing vs alignas(64) Cache Isolation   \n";
    std::cout << "========================================================================\n";
    std::cout << "Rozmiar struktury Unaligned: " << sizeof(UnalignedCounters) << " bajtow (brak wyrownania)\n";
    std::cout << "Rozmiar struktury Aligned:   " << sizeof(AlignedCounters)   << " bajtow (alignas(64))\n";
    std::cout << "Liczba iteracji per watek:   " << iterations << "\n";
    std::cout << "Dostepne watki OpenMP:       " << max_threads << "\n";
    std::cout << "------------------------------------------------------------------------\n";
    std::cout << std::setw(8)  << "Watki" 
              << std::setw(18) << "Unaligned [s]" 
              << std::setw(18) << "Aligned [s]" 
              << std::setw(16) << "Przyspieszenie" 
              << std::setw(14) << "Efekt" << "\n";
    std::cout << "------------------------------------------------------------------------\n";

    // Testujemy skalowanie dla różnych liczb wątków
    for (int threads = 1; threads <= max_threads; threads *= 2) {
        // Rozgrzewka pamięci cache
        run_unaligned(threads, 1'000'000);
        run_aligned(threads, 1'000'000);

        // Pomiary właściwe
        double t_unaligned = run_unaligned(threads, iterations);
        double t_aligned   = run_aligned(threads, iterations);
        double speedup     = t_unaligned / t_aligned;

        std::cout << std::setw(8)  << threads
                  << std::setw(18) << std::fixed << std::setprecision(4) << t_unaligned
                  << std::setw(18) << std::fixed << std::setprecision(4) << t_aligned
                  << std::setw(15) << std::fixed << std::setprecision(2) << speedup << "x";

        if (threads == 1) {
            std::cout << std::setw(14) << "(baza: 1 watek)\n";
        } else if (speedup > 1.5) {
            std::cout << std::setw(14) << "False Sharing!\n";
        } else {
            std::cout << std::setw(14) << "Brak roznicy\n";
        }
    }

    if (max_threads > 1 && (max_threads & (max_threads - 1)) != 0) {
        // Jeśli max_threads nie jest potęgą dwójki (np. 6 lub 12)
        double t_unaligned = run_unaligned(max_threads, iterations);
        double t_aligned   = run_aligned(max_threads, iterations);
        double speedup     = t_unaligned / t_aligned;

        std::cout << std::setw(8)  << max_threads
                  << std::setw(18) << std::fixed << std::setprecision(4) << t_unaligned
                  << std::setw(18) << std::fixed << std::setprecision(4) << t_aligned
                  << std::setw(15) << std::fixed << std::setprecision(2) << speedup << "x"
                  << std::setw(14) << "False Sharing!\n";
    }

    std::cout << "========================================================================\n";
    std::cout << "Kompilacja na klastrze/lokalnie:\n";
    std::cout << "  g++ -O3 -fopenmp bench_false_sharing.cc -o bench_false_sharing\n";
    std::cout << "Pomiar zdarzen sprzetowych perf stat na Linuksie:\n";
    std::cout << "  perf stat -e cache-misses,L1-dcache-load-misses,L1-dcache-store-misses ./bench_false_sharing\n";
    std::cout << "========================================================================\n";

    return 0;
}
