#include "../constants.h"
#include "../state.h"
#include "../cross_sections.h"
#include "../simulation.h"
#include "../io_manager.h"
#include "test_helpers.h"
#include <fstream>
#include <cstdio>
#include <cstring>
#include <cstdlib>


int main(int argc, char *argv[]) {
    printf(">> eduPIC_reg: Starting regression runner...\n");
    printf(">> eduPIC_reg: **************************************************************************\n");
    printf(">> eduPIC_reg: Running with bit-perfect RNG state tracking for regression testing.\n");
    printf(">> eduPIC_reg: **************************************************************************\n");

    if (argc == 1) {
        printf(">> eduPIC_reg: error = need starting_cycle argument\n");
        return 1;
    } else {
        strcpy(st0, argv[1]);
        arg1 = atol(st0);
        if (argc > 2) {
            if (strcmp(argv[2], "m") == 0) {
                measurement_mode = true;
            } else {
                measurement_mode = false;
            }
        }
    }

    if (measurement_mode) {
        printf(">> eduPIC_reg: measurement mode: on\n");
    } else {
        printf(">> eduPIC_reg: measurement mode: off\n");
    }

    set_electron_cross_sections_ar();
    set_ion_cross_sections_ar();
    calc_total_cross_sections();

    datafile = fopen("conv.dat", "a");

    if (arg1 == 0) {
        // === INICJALIZACJA ===
        if (FILE *file = fopen("picdata.bin", "r")) {
            fclose(file);
            printf(">> eduPIC_reg: Warning: Data from previous calculation are detected. Deleting old files...\n");
            remove("picdata.bin");
            remove("rng_state.bin");
        } 
        no_of_cycles = 1;
        cycle = 1;
        
        // Zawsze ustawiamy stały seed przy inicjalizacji symulacji regresyjnej
        seed_rng(67);
        
        init(N_INIT);
        printf(">> eduPIC_reg: running initializing cycle\n");
        Time = 0;
        do_one_cycle();
        cycles_done = 1;
        save_particle_data();

        save_rng_state(); // Zapisujemy stan RNG do kontynuacji
    } else {
        // === KONTYNUACJA ===
        no_of_cycles = arg1;
        load_particle_data();
        load_rng_state(); // Odtwarzamy dokładny stan RNG z poprzedniego kroku
        
        printf(">> eduPIC_reg: running %d cycle(s)\n", no_of_cycles);
        for (cycle = cycles_done + 1; cycle <= cycles_done + no_of_cycles; cycle++) {
            do_one_cycle();
        }
        cycles_done += no_of_cycles;
        save_particle_data();
        save_rng_state(); // Zapisujemy zaktualizowany stan RNG dla kolejnych kroków
    }

    fclose(datafile);

    if (measurement_mode) {
        check_and_save_info();
    }

    printf(">> eduPIC_reg: simulation of %d cycle(s) is completed.\n", no_of_cycles);
    return 0;
}
