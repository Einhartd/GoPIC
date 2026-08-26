#include "constants.h"
#include "state.h"
#include "cross_sections.h"
#include "simulation.h"
#include "io_manager.h"

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
