#include <iostream>
#include <vector>
#include <omp.h>

int main() {
    // tworzy wektor o 16 elementowy gdzie kazdy element to 0
    std::vector<int> data(16, 0);

    #pragma omp parallel num_threads(4)
    {
        // id watku
        int tid = omp_get_thread_num();
        // liczba watkow
        int n_threads = omp_get_num_threads();

        // dzielimy liste na chunki w zaleznosci od watkow
        int chunk_size = data.size() / n_threads;
        int start = tid * chunk_size;
        int end = start + chunk_size;

        //  dla wybranego chunku liczymy wartosc w wektorze
        for (int i = start; i < end; i++) {
            data[i] = tid * 100 + i;
        }
    }

    for (int val : data) {
        std::cout << val << " ";
    }
    std::cout << std::endl;

    return 0;
}