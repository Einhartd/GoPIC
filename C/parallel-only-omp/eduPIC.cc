#include "constants.h"
#include "state.h"
#include "cross_sections.h"
#include "simulation.h"
#include "io_manager.h"

PIC_STEP void sort_particles_by_cell(particle_vector &x, particle_vector &vx,
                                    particle_vector &vy, particle_vector &vz, int N_p) {

    if (N_p <= 1) return;

    int num_threads = omp_get_max_threads();
    worker_buffers.init_buffers(num_threads);

    static std::vector<std::vector<int>> thread_bin_counts;
    static std::vector<std::vector<int>> thread_bin_offsets;

    if ((int)thread_bin_counts.size() < num_threads) {
        thread_bin_counts.resize(num_threads, std::vector<int>(N_G, 0));
        thread_bin_offsets.resize(num_threads, std::vector<int>(N_G, 0));
    }

    #pragma omp parallel
    {
        int tid = omp_get_thread_num();
        int nthreads = omp_get_num_threads();

        std::fill(thread_bin_counts[tid].begin(), thread_bin_counts[tid].end(), 0);

        #pragma omp for
        for (int k=0; k<N_p; k++){
            int cell = int(x[k]*INV_DX);
            if(cell<0) cell = 0;
            if(cell>=N_G-1) cell = N_G - 2;
            thread_bin_counts[tid][cell]++;
        }

        // Wyznaczenie globalnych i lokalnych offsetow zapisu
        #pragma omp single
        {
            int running_sum = 0;
            for (int c = 0; c < N_G; c++){
                for (int t = 0; t < nthreads; t++){
                    thread_bin_offsets[t][c] = running_sum;
                    running_sum += thread_bin_counts[t][c];
                }
            }
        }


        // Rownolegly zapis na posortowane pozycje w temp
        #pragma omp for
        for (int k = 0; k < N_p; k++){
            int cell = int(x[k] * INV_DX);
            if (cell < 0) cell = 0;
            if (cell >= N_G - 1) cell = N_G - 2;

            int dst_idx = thread_bin_offsets[tid][cell]++;
            worker_buffers.temp_x[dst_idx] = x[k];
            worker_buffers.temp_vx[dst_idx] = vx[k];
            worker_buffers.temp_vy[dst_idx] = vy[k];
            worker_buffers.temp_vz[dst_idx] = vz[k];
        }

        #pragma omp for
        for (int k = 0; k<N_p; k++){
            x[k] = worker_buffers.temp_x[k];
            vx[k] = worker_buffers.temp_vx[k];
            vy[k] = worker_buffers.temp_vy[k];
            vz[k] = worker_buffers.temp_vz[k];
        }
    }
}



/*
Główna funkcja programu eduPIC (1D3V PIC/MCC).
Inicjalizuje tablice fizyczne, zarządza cyklem życia symulacji i wywołuje pętlę czasową.
Argumenty wiersza poleceń:
 - argv[1]: liczba cykli RF do wykonania (wartość 0 oznacza cykl inicjalizacyjny).
 - argv[2]: opcjonalna flaga "m" włączająca tryb pomiarowy (gromadzenie i zapis diagnostyk).
@param argc Liczba argumentów wiersza poleceń.
@param argv Tablica łańcuchów znakowych argumentów wiersza poleceń.
@return Kod zakończenia programu (0 w przypadku sukcesu, 1 w przypadku błędu argumentów).
*/
int main (int argc, char *argv[]){
    printf(">> eduPIC: starting...\n");

    // Walidacja argumentów linii poleceń
    if (argc == 1) {
        printf(">> eduPIC: error = need starting_cycle argument\n");
        return 1;
    } else {
        strcpy(st0,argv[1]);
        arg1 = atol(st0);
        if (argc > 2) {
            if (strcmp (argv[2],"m") == 0){
                // Włączenie trybu pomiarowego
                measurement_mode = true;
            } else {
                measurement_mode = false;
            }
        }
    }
    if (measurement_mode) {
        printf(">> eduPIC: measurement mode: on\n");
    } else {
        printf(">> eduPIC: measurement mode: off\n");
    }

    // Inicjalizacja tablic przekrojów czynnych
    set_electron_cross_sections_ar();
    set_ion_cross_sections_ar();
    calc_total_cross_sections();
    // Inicjalizacja parametrów dla null-collision
    compute_null_collision_params();
    //test_cross_sections(); return 1;

    // Otwarcie pliku zbieżności conv.dat w trybie dopisywania (append)
    datafile = fopen("conv.dat","a");

    if (arg1 == 0) {
        // Tryb inicjalizacyjny: sprawdzenie, czy nie istnieją już pliki z poprzednich uruchomień
        if (FILE *file = fopen("picdata.bin", "r")) { fclose(file);
            printf(">> eduPIC: Warning: Data from previous calculation are detected.\n");
            printf("           To start a new simulation from the beginning, please delete all output files before running ./eduPIC 0\n");
            printf("           To continue the existing calculation, please specify the number of cycles to run, e.g. ./eduPIC 100\n");
            exit(0);
        } 
        no_of_cycles = 1;
        cycle = 1;

        // Zasianie początkowych makrocząstek w przestrzeni
        init(N_INIT);
        printf(">> eduPIC: running initializing cycle\n");
        Time = 0;
        do_one_cycle();
        cycles_done = 1;
    } else {
        // Tryb kontynuacji: wczytanie stanu z pliku picdata.bin i wykonanie N cykli
        no_of_cycles = arg1;
        load_particle_data();
        printf(">> eduPIC: running %d cycle(s)\n",no_of_cycles);
        for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
            if ((cycle % 5) == 0){
                sort_particles_by_cell(x_e, vx_e, vz_e, vz_e, N_e);
                sort_particles_by_cell(x_i, vx_i, vy_i, vz_i, N_i);
            }
            do_one_cycle();
        }
        cycles_done += no_of_cycles;
    }

    fclose(datafile);
    // Zapis stanu cząstek do pliku binarnego
    save_particle_data();

    // W trybie pomiarowym zapis pełnego zestawu diagnostyk i raportu stabilności
    if (measurement_mode) {
        check_and_save_info();
    }
    printf(">> eduPIC: simulation of %d cycle(s) is completed.\n",no_of_cycles);
}
