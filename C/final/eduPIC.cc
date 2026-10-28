#include "constants.h"
#include "state.h"
#include "cross_sections.h"
#include "simulation.h"
#include "io_manager.h"

/*
Główna funkcja programu eduPIC w zoptymalizowanej równoległej wersji C++ / OpenMP.
Inicjalizuje tablice przekrojów czynnych, parametry Null-Collision oraz prekalkulowane
współczynniki solvera Poissona, a następnie uruchamia symulację na wybraną liczbę cykli RF.
Argumenty wiersza poleceń:
 - argv[1]: liczba cykli RF do wykonania (0 oznacza uruchomienie pierwszego cyklu inicjalizacyjnego).
 - argv[2]: opcjonalna flaga "m" włączająca tryb pomiarowy (zbieranie i zapis diagnostyk).
@param argc Liczba argumentów wiersza poleceń.
@param argv Tablica napisów z argumentami wiersza poleceń.
@return Kod zakończenia programu (0 w przypadku powodzenia, 1 w przypadku braku argumentów).
*/
int main(int argc, char *argv[]) {
    printf(">> eduPIC: starting...\n");

    // Odczyt i walidacja argumentów wiersza poleceń
    if (argc == 1) {
        printf(">> eduPIC: error = need starting_cycle argument\n");
        return 1;
    } else {
        strcpy(st0, argv[1]);
        arg1 = atol(st0);
        if (argc > 2) {
            measurement_mode = (strcmp(argv[2], "m") == 0);
        }
    }
    if (measurement_mode) {
        printf(">> eduPIC: measurement mode: on\n");
    } else {
        printf(">> eduPIC: measurement mode: off\n");
    }

    // Inicjalizacja stabelaryzowanych przekrojów czynnych dla elektronów i jonów
    set_electron_cross_sections_ar();
    set_ion_cross_sections_ar();
    calc_total_cross_sections();

    // Wyznaczenie maksymalnych częstości i prawdopodobieństw dla metody Null-Collision
    compute_null_collision_params();

    // Jednorazowa prekalkulacja współczynników macierzy trójdiagonalnej dla algorytmu Thomasa
    init_poisson_solver();

    // Otwarcie pliku zbieżności conv.dat w trybie dopisywania
    datafile = fopen("conv.dat", "a");

    if (arg1 == 0) {
        // Tryb inicjalizacyjny: sprawdzenie, czy nie istnieją już dane z wcześniejszej symulacji
        if (FILE *file = fopen("picdata.bin", "r")) {
            fclose(file);
            printf(">> eduPIC: Warning: Data from previous calculation are detected.\n");
            printf("           To start a new simulation from the beginning, please delete all output files before running ./eduPIC 0\n");
            printf("           To continue the existing calculation, please specify the number of cycles to run, e.g. ./eduPIC 100\n");
            exit(0);
        }
        no_of_cycles = 1;
        cycle        = 1;

        // Zasianie początkowych makrocząstek i wykonanie pierwszego cyklu RF
        init(N_INIT);
        printf(">> eduPIC: running initializing cycle\n");
        Time = 0;
        do_one_cycle();
        cycles_done = 1;
    } else {
        // Tryb kontynuacji: wczytanie stanu z pliku picdata.bin i wykonanie zadanej liczby cykli
        no_of_cycles = arg1;
        load_particle_data();
        printf(">> eduPIC: running %d cycle(s)\n", no_of_cycles);
        for (cycle = cycles_done + 1; cycle <= cycles_done + no_of_cycles; cycle++) {
            do_one_cycle();
        }
        cycles_done += no_of_cycles;
    }

    fclose(datafile);

    // Zapis zaktualizowanego stanu cząstek do pliku binarnego picdata.bin
    save_particle_data();

    // W trybie pomiarowym weryfikacja warunków stabilności i zapis plików diagnostycznych
    if (measurement_mode) {
        check_and_save_info();
    }
    printf(">> eduPIC: simulation of %d cycle(s) is completed.\n", no_of_cycles);
    return 0;
}
