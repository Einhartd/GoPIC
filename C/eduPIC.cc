//-------------------------------------------------------------------//
//         eduPIC : educational 1d3v PIC/MCC simulation code         //
//           version 1.0, release date: March 16, 2021               //
//                       :) Share & enjoy :)                         //
//-------------------------------------------------------------------//
// When you use this code, you are required to acknowledge the       //
// authors by citing the paper:                                      //
// Z. Donko, A. Derzsi, M. Vass, B. Horvath, S. Wilczek              //
// B. Hartmann, P. Hartmann:                                         //
// "eduPIC: an introductory particle based  code for radio-frequency //
// plasma simulation"                                                //
// Plasma Sources Science and Technology, vol 30, pp. 095017 (2021)  //
//-------------------------------------------------------------------//
// Disclaimer: The eduPIC (educational Particle-in-Cell/Monte Carlo  //
// Collisions simulation code), Copyright (C) 2021                   //
// Zoltan Donko et al. is free software: you can redistribute it     //
// and/or modify it under the terms of the GNU General Public License//
// as published by the Free Software Foundation, version 3.          //
// This program is distributed in the hope that it will be useful,   //
// but WITHOUT ANY WARRANTY; without even the implied warranty of    //
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU  //
// General Public License for more details at                        //
// https://www.gnu.org/licenses/gpl-3.0.html.                        //
//-------------------------------------------------------------------//

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
    //test_cross_sections(); return 1;
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
}
