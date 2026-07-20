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
#include <mpi.h>

//------------------------------------------------------------------------------------------//
// main                                                                                     //
// command line arguments:                                                                  //
// [1]: number of cycles (0 for init)                                                       //
// [2]: "m" turns on data collection and saving                                             //
//------------------------------------------------------------------------------------------//

int main (int argc, char *argv[]){

    // MPI init
    int required = MPI_THREAD_FUNNELED;
    int provided;
    MPI_Init_thread(&argc, &argv, required, &provided);

    MPI_Comm_rank(MPI_COMM_WORLD, &mpi_rank);
    MPI_Comm_size(MPI_COMM_WORLD, &mpi_size);

    if (mpi_rank == 0) {
        printf(">> eduPIC: starting...\n");
        printf(">> eduPIC: **************************************************************************\n");
        printf(">> eduPIC: Copyright (C) 2021 Z. Donko et al.\n");
        printf(">> eduPIC: This program comes with ABSOLUTELY NO WARRANTY\n");
        printf(">> eduPIC: This is free software, you are welcome to use, modify and redistribute it\n");
        printf(">> eduPIC: according to the GNU General Public License, https://www.gnu.org/licenses/\n");
        printf(">> eduPIC: **************************************************************************\n");
    }

    //  Check call arguments for cycles and measurement mode
    if (argc == 1) {
        printf(">> eduPIC: error = need starting_cycle argument\n");
        return 1;
    } else {
        strcpy(st0,argv[1]);
        arg1 = atol(st0);
        if (argc > 2) {
            if (strcmp (argv[2],"m") == 0){
                // measurements will be done
                measurement_mode = true;
            } else {
                measurement_mode = false;
            }
        }
    }

    //  Print measurement mode status
    if (mpi_rank == 0){
        if (measurement_mode) {
            printf(">> eduPIC: measurement mode: on\n");
        } else {
            printf(">> eduPIC: measurement mode: off\n");
        }
    }

    //  Prepare cross sections
    set_electron_cross_sections_ar();
    set_ion_cross_sections_ar();
    calc_total_cross_sections();
    
//  Prepare null-collision params
#ifdef USE_NULL_COLLISION
    compute_null_collision_params();
#endif

    //test_cross_sections(); return 1;
    if (mpi_rank == 0){
        datafile = fopen("conv.dat","a");
    }

    if (arg1 == 0) {
        if (mpi_rank == 0) {
            if (FILE *file = fopen("picdata.bin", "r")) { fclose(file);
            printf(">> eduPIC: Warning: Data from previous calculation are detected.\n");
            printf("           To start a new simulation from the beginning, please delete all output files before running ./eduPIC 0\n");
            printf("           To continue the existing calculation, please specify the number of cycles to run, e.g. ./eduPIC 100\n");

            MPI_Abort(MPI_COMM_WORLD, 0);
            exit(0);
        } 
        }

        no_of_cycles = 1;
        // init cycle
        cycle = 1;

        // Distribute init num of electrons to MPI ranks
        int local_N_INIT = N_INIT / mpi_size;
        if (mpi_rank == 0) {
            local_N_INIT += N_INIT % mpi_size;
            printf(">> eduPIC: running initializing cycle\n");
        }
        // seed initial electrons & ions                                    
        init(local_N_INIT);
        Time = 0;

        do_one_cycle();

        cycles_done = 1;
    } else {
        // run number of cycles specified in command line
        no_of_cycles = arg1;

        // read previous configuration from file
        load_particle_data();

        if (mpi_rank == 0) {
            printf(">> eduPIC: running %d cycle(s)\n",no_of_cycles);
        }
        
        //  Do the cycles
        for (cycle=cycles_done+1; cycle<=cycles_done+no_of_cycles; cycle++) {
            do_one_cycle();
        }
        cycles_done += no_of_cycles;
    }

    if (mpi_rank == 0) {
        fclose(datafile);
    }
    
    save_particle_data();

    if (measurement_mode) {
        check_and_save_info();
    }

    if (mpi_rank == 0) {
        printf(">> eduPIC: simulation of %d cycle(s) is completed.\n",no_of_cycles);
    }


    //  End MPI COMM
    MPI_Finalize();
}
