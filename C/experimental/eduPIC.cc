#include "constants.h"
#include "state.h"
#include "cross_sections.h"
#include "simulation.h"
#include "io_manager.h"

//------------------------------------------------------------------------------------------//
// main                                                                                     //
// command line arguments:                                                                  //
// [1]: number of cycles (0 for init)                                                       //
// [2]: "m" turns on data collection and saving                                             //
//------------------------------------------------------------------------------------------//

int main (int argc, char *argv[]){
    printf(">> eduPIC: starting...\n");
    printf(">> eduPIC: **************************************************************************\n");
    printf(">> eduPIC: Copyright (C) 2021 Z. Donko et al.\n");
    printf(">> eduPIC: This program comes with ABSOLUTELY NO WARRANTY\n");
    printf(">> eduPIC: This is free software, you are welcome to use, modify and redistribute it\n");
    printf(">> eduPIC: according to the GNU General Public License, https://www.gnu.org/licenses/\n");
    printf(">> eduPIC: **************************************************************************\n");

    if (argc == 1) {
        printf(">> eduPIC: error = need starting_cycle argument\n");
        return 1;
    } else {
        strcpy(st0,argv[1]);
        arg1 = atol(st0);
        if (argc > 2) {
            if (strcmp (argv[2],"m") == 0){
                measurement_mode = true;                  // measurements will be done
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
    set_electron_cross_sections_ar();
    set_ion_cross_sections_ar();
    calc_total_cross_sections();

    datafile = fopen("conv.dat","a");
    if (arg1 == 0) {
        if (FILE *file = fopen("picdata.bin", "r")) { fclose(file);
            printf(">> eduPIC: Warning: Data from previous calculation are detected.\n");
            printf("           To start a new simulation from the beginning, please delete all output files before running ./eduPIC 0\n");
            printf("           To continue the existing calculation, please specify the number of cycles to run, e.g. ./eduPIC 100\n");
            exit(0);
        } 
        no_of_cycles = 1;
        cycle = 1;                                        // init cycle
        init(N_INIT);                                     // seed initial electrons & ions
        printf(">> eduPIC: running initializing cycle\n");
        Time = 0;
        do_one_cycle();
        cycles_done = 1;
    } else {
        no_of_cycles = arg1;                              // run number of cycles specified in command line
        load_particle_data();                             // read previous configuration from file
        printf(">> eduPIC: running %d cycle(s)\n",no_of_cycles);
        for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {do_one_cycle();}
        cycles_done += no_of_cycles;
    }
    fclose(datafile);
    save_particle_data();
    if (measurement_mode) {
        check_and_save_info();
    }
    printf(">> eduPIC: simulation of %d cycle(s) is completed.\n",no_of_cycles);
    return 0;
}
