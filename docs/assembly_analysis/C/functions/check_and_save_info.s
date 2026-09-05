# Function: check_and_save_info()
# Mangled Symbol: _Z19check_and_save_infov
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._Z19check_and_save_infov,"axG",@progbits,_Z19check_and_save_infov,comdat
	.p2align 4
	.weak	_Z19check_and_save_infov
	.type	_Z19check_and_save_infov, @function
_Z19check_and_save_infov:
.LFB9928:
	.cfi_startproc
	endbr64	
	pushq	%r13	#
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
# C/parallel-only-omp/io_manager.h:234:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // Gęstość elektronów w środku szczeliny
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp1069
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp483
# C/parallel-only-omp/io_manager.h:228: inline void check_and_save_info(void){
	leaq	16(%rsp), %r13	#,
	.cfi_def_cfa 13, 0
	andq	$-64, %rsp	#,
	pushq	-8(%r13)	#
	pushq	%rbp	#
	movq	%rsp, %rbp	#,
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15	#
	pushq	%r14	#
	pushq	%r13	#
	.cfi_escape 0xf,0x3,0x76,0x68,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	pushq	%r12	#
	pushq	%rbx	#
	subq	$584, %rsp	#,
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	.cfi_escape 0x10,0x3,0x2,0x76,0x58
# C/parallel-only-omp/io_manager.h:234:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // Gęstość elektronów w środku szczeliny
	vmovsd	1600+cumul_e_density(%rip), %xmm0	# cumul_e_density[200], cumul_e_density[200]
# C/parallel-only-omp/io_manager.h:228: inline void check_and_save_info(void){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp944
	movq	%rax, -56(%rbp)	# tmp944, D.132814
	xorl	%eax, %eax	# tmp944
# C/parallel-only-omp/io_manager.h:234:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // Gęstość elektronów w środku szczeliny
	vcvtsi2sdl	no_of_cycles(%rip), %xmm4, %xmm1	# no_of_cycles, tmp1069, tmp916
# C/parallel-only-omp/io_manager.h:234:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // Gęstość elektronów w środku szczeliny
	vdivsd	%xmm1, %xmm0, %xmm0	# _3, cumul_e_density[200], tmp477
# C/parallel-only-omp/io_manager.h:234:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // Gęstość elektronów w środku szczeliny
	vdivsd	.LC74(%rip), %xmm0, %xmm4	#, tmp477, density
# C/parallel-only-omp/io_manager.h:235:     plas_freq  = E_CHARGE * sqrt(density / EPSILON0 / E_MASS);                       // Częstość plazmowa elektronów w środku szczeliny
	vdivsd	.LC75(%rip), %xmm4, %xmm0	#, density, tmp480
# C/parallel-only-omp/io_manager.h:234:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // Gęstość elektronów w środku szczeliny
	vmovsd	%xmm4, -240(%rbp)	# density, %sfp
# C/parallel-only-omp/io_manager.h:235:     plas_freq  = E_CHARGE * sqrt(density / EPSILON0 / E_MASS);                       // Częstość plazmowa elektronów w środku szczeliny
	vmovsd	.LC51(%rip), %xmm4	#, tmp851
	vdivsd	%xmm4, %xmm0, %xmm0	# tmp851, tmp480, _6
	vucomisd	%xmm0, %xmm2	# _6, tmp483
	ja	.L338	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _6, _7
.L225:
# C/parallel-only-omp/io_manager.h:238:     sim_time   = (double)(no_of_cycles) / FREQUENCY;                                 // Całkowity czas symulowany
	vdivsd	.LC76(%rip), %xmm1, %xmm1	#, _3, sim_time
# C/parallel-only-omp/io_manager.h:235:     plas_freq  = E_CHARGE * sqrt(density / EPSILON0 / E_MASS);                       // Częstość plazmowa elektronów w środku szczeliny
	vmovsd	.LC50(%rip), %xmm2	#, tmp850
	vmulsd	%xmm2, %xmm0, %xmm6	# tmp850, _7, plas_freq
	vmovsd	%xmm6, -304(%rbp)	# plas_freq, %sfp
# C/parallel-only-omp/io_manager.h:239:     ecoll_freq = (double)(N_e_coll) / sim_time / (double)(N_e);                      // Średnia częstość zderzeń elektronów
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp1073
	vcvtusi2sdq	N_e_coll(%rip), %xmm6, %xmm0	# N_e_coll, tmp1073, tmp917
# C/parallel-only-omp/io_manager.h:239:     ecoll_freq = (double)(N_e_coll) / sim_time / (double)(N_e);                      // Średnia częstość zderzeń elektronów
	vcvtsi2sdl	N_e(%rip), %xmm6, %xmm3	# N_e, tmp1074, tmp918
# C/parallel-only-omp/io_manager.h:239:     ecoll_freq = (double)(N_e_coll) / sim_time / (double)(N_e);                      // Średnia częstość zderzeń elektronów
	vdivsd	%xmm1, %xmm0, %xmm0	# sim_time, tmp486, tmp487
# C/parallel-only-omp/io_manager.h:239:     ecoll_freq = (double)(N_e_coll) / sim_time / (double)(N_e);                      // Średnia częstość zderzeń elektronów
	vdivsd	%xmm3, %xmm0, %xmm3	# tmp488, tmp487, ecoll_freq
# C/parallel-only-omp/io_manager.h:240:     icoll_freq = (double)(N_i_coll) / sim_time / (double)(N_i);                      // Średnia częstość zderzeń jonów
	vcvtusi2sdq	N_i_coll(%rip), %xmm6, %xmm0	# N_i_coll, tmp1076, tmp919
# C/parallel-only-omp/io_manager.h:239:     ecoll_freq = (double)(N_e_coll) / sim_time / (double)(N_e);                      // Średnia częstość zderzeń elektronów
	vmovq	%xmm3, %r12	# ecoll_freq, ecoll_freq
# C/parallel-only-omp/io_manager.h:240:     icoll_freq = (double)(N_i_coll) / sim_time / (double)(N_i);                      // Średnia częstość zderzeń jonów
	vdivsd	%xmm1, %xmm0, %xmm0	# sim_time, tmp489, tmp490
# C/parallel-only-omp/io_manager.h:240:     icoll_freq = (double)(N_i_coll) / sim_time / (double)(N_i);                      // Średnia częstość zderzeń jonów
	vcvtsi2sdl	N_i(%rip), %xmm6, %xmm1	# N_i, tmp1077, tmp920
# C/parallel-only-omp/io_manager.h:240:     icoll_freq = (double)(N_i_coll) / sim_time / (double)(N_i);                      // Średnia częstość zderzeń jonów
	vdivsd	%xmm1, %xmm0, %xmm3	# tmp491, tmp490, icoll_freq
# C/parallel-only-omp/io_manager.h:236:     meane      = mean_energy_accu_center / (double)(mean_energy_counter_center);     // Średnia energia elektronów w centrum
	vcvtusi2sdq	mean_energy_counter_center(%rip), %xmm6, %xmm1	# mean_energy_counter_center, tmp1079, tmp921
# C/parallel-only-omp/io_manager.h:236:     meane      = mean_energy_accu_center / (double)(mean_energy_counter_center);     // Średnia energia elektronów w centrum
	vmovsd	mean_energy_accu_center(%rip), %xmm0	# mean_energy_accu_center, mean_energy_accu_center
# C/parallel-only-omp/io_manager.h:240:     icoll_freq = (double)(N_i_coll) / sim_time / (double)(N_i);                      // Średnia częstość zderzeń jonów
	vmovq	%xmm3, %rbx	# icoll_freq, icoll_freq
# C/parallel-only-omp/io_manager.h:236:     meane      = mean_energy_accu_center / (double)(mean_energy_counter_center);     // Średnia energia elektronów w centrum
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp492, mean_energy_accu_center, meane
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp502
# C/parallel-only-omp/io_manager.h:237:     kT         = 2.0 * meane * EV_TO_J / 3.0;                                        // Przybliżona temperatura k*T_e w centrum
	vaddsd	%xmm0, %xmm0, %xmm0	# meane, meane, tmp495
# C/parallel-only-omp/io_manager.h:237:     kT         = 2.0 * meane * EV_TO_J / 3.0;                                        // Przybliżona temperatura k*T_e w centrum
	vmulsd	%xmm2, %xmm0, %xmm0	# tmp850, tmp495, tmp496
# C/parallel-only-omp/io_manager.h:237:     kT         = 2.0 * meane * EV_TO_J / 3.0;                                        // Przybliżona temperatura k*T_e w centrum
	vdivsd	.LC16(%rip), %xmm0, %xmm0	#, tmp496, kT
# C/parallel-only-omp/io_manager.h:241:     debye_length = sqrt(EPSILON0 * kT / density) / E_CHARGE;                         // Promień Debye'a elektronów w centrum
	vmulsd	.LC75(%rip), %xmm0, %xmm0	#, kT, tmp500
# C/parallel-only-omp/io_manager.h:241:     debye_length = sqrt(EPSILON0 * kT / density) / E_CHARGE;                         // Promień Debye'a elektronów w centrum
	vdivsd	-240(%rbp), %xmm0, %xmm0	# %sfp, tmp500, _26
	vucomisd	%xmm0, %xmm1	# _26, tmp502
	ja	.L339	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _26, _27
.L228:
	vmovapd	%zmm8, -624(%rbp)	# vect__291.1367, %sfp
# C/parallel-only-omp/io_manager.h:243:     f = fopen("info.txt","w");
	leaq	.LC77(%rip), %rsi	#,
	leaq	.LC78(%rip), %rdi	#, tmp505
	vmovapd	%zmm9, -560(%rbp)	# vect__345.1344, %sfp
	vmovapd	%zmm7, -496(%rbp)	# vect__376.1333, %sfp
# C/parallel-only-omp/io_manager.h:241:     debye_length = sqrt(EPSILON0 * kT / density) / E_CHARGE;                         // Promień Debye'a elektronów w centrum
	vdivsd	%xmm2, %xmm0, %xmm7	# tmp850, _27, debye_length
	vmovsd	%xmm7, -368(%rbp)	# debye_length, %sfp
# C/parallel-only-omp/io_manager.h:243:     f = fopen("info.txt","w");
	vzeroupper
	call	fopen@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	leaq	.LC79(%rip), %rdx	#, tmp507
	movl	$2, %esi	#,
# C/parallel-only-omp/io_manager.h:243:     f = fopen("info.txt","w");
	movq	%rax, %r14	# tmp897, _91
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%rax, %rdi	# _91,
# C/parallel-only-omp/io_manager.h:243:     f = fopen("info.txt","w");
	movq	%rax, -432(%rbp)	# _91, %sfp
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC80(%rip), %rdx	#, tmp508
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC82(%rip), %rdx	#, tmp510
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC81(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	movl	$400, %ecx	#,
	leaq	.LC83(%rip), %rdx	#, tmp511
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC84(%rip), %rdx	#, tmp513
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC76(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	movl	$4000, %ecx	#,
	leaq	.LC85(%rip), %rdx	#, tmp514
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	movl	$20, %ecx	#,
	leaq	.LC86(%rip), %rdx	#, tmp515
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC88(%rip), %rdx	#, tmp517
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC87(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	leaq	.LC89(%rip), %rdx	#, tmp519
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC15(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	leaq	.LC91(%rip), %rdx	#, tmp521
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC90(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	leaq	.LC93(%rip), %rdx	#, tmp523
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC92(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	movl	no_of_cycles(%rip), %ecx	# no_of_cycles,
	leaq	.LC94(%rip), %rdx	#, tmp525
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC95(%rip), %rdx	#,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC96(%rip), %rdx	#, tmp527
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC97(%rip), %rdx	#, tmp528
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	-240(%rbp), %xmm0	# %sfp,
	call	__fprintf_chk@PLT	#
	leaq	.LC98(%rip), %rdx	#, tmp529
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	-304(%rbp), %xmm0	# %sfp,
	call	__fprintf_chk@PLT	#
	leaq	.LC99(%rip), %rdx	#, tmp530
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	-368(%rbp), %xmm0	# %sfp,
	call	__fprintf_chk@PLT	#
	vmovq	%r12, %xmm0	# ecoll_freq,
	leaq	.LC100(%rip), %rdx	#, tmp531
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	call	__fprintf_chk@PLT	#
	vmovq	%rbx, %xmm0	# icoll_freq,
	leaq	.LC101(%rip), %rdx	#, tmp532
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	call	__fprintf_chk@PLT	#
	leaq	.LC95(%rip), %rdx	#,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC102(%rip), %rdx	#, tmp534
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC103(%rip), %rdx	#, tmp536
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:266:     c = plas_freq * DT_E;
	vmovsd	.LC52(%rip), %xmm6	#, tmp1082
	vmulsd	-304(%rbp), %xmm6, %xmm1	# %sfp, tmp1082, c
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm1, %xmm1, %xmm0	# c,
	vmovsd	%xmm1, -304(%rbp)	# c, %sfp
	call	__fprintf_chk@PLT	#
	leaq	.LC105(%rip), %rdx	#, tmp538
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:269:     c = DX / debye_length;
	vmovsd	.LC104(%rip), %xmm4	#, tmp1084
# C/parallel-only-omp/io_manager.h:271:     if (c > 1.0) {conditions_OK = false;}
	xorl	%ebx, %ebx	# conditions_OK
# C/parallel-only-omp/io_manager.h:269:     c = DX / debye_length;
	vdivsd	-368(%rbp), %xmm4, %xmm0	# %sfp, tmp1084, c
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm0, -240(%rbp)	# c, %sfp
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:271:     if (c > 1.0) {conditions_OK = false;}
	vmovsd	-240(%rbp), %xmm0	# %sfp, c
	vmovapd	-496(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovapd	-560(%rbp), %zmm9	# %sfp, vect__345.1344
	vcomisd	.LC10(%rip), %xmm0	#, c
	vmovsd	.LC50(%rip), %xmm2	#, tmp850
	vmovapd	-624(%rbp), %zmm8	# %sfp, vect__291.1367
	vmovsd	.LC51(%rip), %xmm4	#, tmp851
	ja	.L229	#,
# C/parallel-only-omp/io_manager.h:268:     if (c > 0.2) {conditions_OK = false;}
	vmovsd	-304(%rbp), %xmm1	# %sfp, c
	vcomisd	.LC106(%rip), %xmm1	#, c
	setbe	%bl	#, conditions_OK
.L229:
# C/parallel-only-omp/io_manager.h:271:     if (c > 1.0) {conditions_OK = false;}
	xorl	%r12d, %r12d	# ivtmp.1696
	leaq	sigma_tot_e(%rip), %r13	#, tmp849
# C/parallel-only-omp/cross_sections.h:110:     nu_max = 0;
	vxorpd	%xmm1, %xmm1, %xmm1	# nu_max
	vmovsd	.LC1(%rip), %xmm3	#, tmp865
	vmovsd	%xmm1, %xmm1, %xmm5	#, tmp549
	.p2align 4
	.p2align 3
.L234:
# C/parallel-only-omp/cross_sections.h:112:         e  = i * DE_CS;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp1086
	vcvtsi2sdl	%r12d, %xmm6, %xmm0	# ivtmp.1696, tmp1086, tmp922
# C/parallel-only-omp/cross_sections.h:112:         e  = i * DE_CS;
	vmulsd	%xmm3, %xmm0, %xmm0	# tmp865, tmp542, e
# C/parallel-only-omp/cross_sections.h:113:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vaddsd	%xmm0, %xmm0, %xmm0	# e, e, tmp545
# C/parallel-only-omp/cross_sections.h:113:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vmulsd	%xmm2, %xmm0, %xmm0	# tmp850, tmp545, tmp546
# C/parallel-only-omp/cross_sections.h:113:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vdivsd	%xmm4, %xmm0, %xmm0	# tmp851, tmp546, _164
	vucomisd	%xmm0, %xmm5	# _164, tmp549
	ja	.L340	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _164, v
.L232:
# C/parallel-only-omp/cross_sections.h:114:         nu = v * sigma_tot_e[i];
	vmulsd	0(%r13,%r12,8), %xmm0, %xmm0	# MEM[(double *)&sigma_tot_e + ivtmp.1696_938 * 8], v, nu
# C/parallel-only-omp/cross_sections.h:111:     for(i=0; i<CS_RANGES; i++){
	incq	%r12	# ivtmp.1696
# C/parallel-only-omp/cross_sections.h:115:         if (nu > nu_max) {nu_max = nu;}
	vmaxsd	%xmm1, %xmm0, %xmm1	# nu_max, nu, nu_max
# C/parallel-only-omp/cross_sections.h:111:     for(i=0; i<CS_RANGES; i++){
	cmpq	$1000000, %r12	#, ivtmp.1696
	jne	.L234	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	-432(%rbp), %rdi	# %sfp,
	vmovapd	%zmm8, -496(%rbp)	# vect__291.1367, %sfp
	leaq	.LC107(%rip), %rdx	#, tmp552
	movl	$2, %esi	#,
	vmovapd	%zmm9, -368(%rbp)	# vect__345.1344, %sfp
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:272:     c = max_electron_coll_freq() * DT_E;
	vmulsd	.LC52(%rip), %xmm1, %xmm1	#, nu_max, c
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm1, %xmm1, %xmm0	# c,
	vmovapd	%zmm7, -304(%rbp)	# vect__376.1333, %sfp
	vmovsd	%xmm1, -240(%rbp)	# c, %sfp
	leaq	sigma_tot_i(%rip), %r13	#, tmp854
	vzeroupper
	call	__fprintf_chk@PLT	#
	vmovapd	-496(%rbp), %zmm8	# %sfp, vect__291.1367
	vmovapd	-368(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-304(%rbp), %zmm7	# %sfp, vect__376.1333
# C/parallel-only-omp/io_manager.h:274:     if (c > 0.05) {conditions_OK = false;}
	xorl	%eax, %eax	#
	vmovsd	-240(%rbp), %xmm1	# %sfp, c
	vucomisd	.LC19(%rip), %xmm1	#, c
	vmovsd	.LC53(%rip), %xmm5	#, tmp855
	cmova	%eax, %ebx	# conditions_OK,, tmp885, conditions_OK
	xorl	%r12d, %r12d	# ivtmp.1689
# C/parallel-only-omp/cross_sections.h:130:     nu_max = 0;
	vxorpd	%xmm1, %xmm1, %xmm1	# nu_max
	vmovsd	.LC1(%rip), %xmm3	#, tmp865
	vmovsd	%xmm1, %xmm1, %xmm4	#, tmp561
	vmovsd	.LC50(%rip), %xmm2	#, tmp850
	.p2align 4
	.p2align 3
.L240:
# C/parallel-only-omp/cross_sections.h:132:         e  = i * DE_CS;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp1087
	vcvtsi2sdl	%r12d, %xmm6, %xmm0	# ivtmp.1689, tmp1087, tmp923
# C/parallel-only-omp/cross_sections.h:132:         e  = i * DE_CS;
	vmulsd	%xmm3, %xmm0, %xmm0	# tmp865, tmp554, e
# C/parallel-only-omp/cross_sections.h:133:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vaddsd	%xmm0, %xmm0, %xmm0	# e, e, tmp557
# C/parallel-only-omp/cross_sections.h:133:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vmulsd	%xmm2, %xmm0, %xmm0	# tmp850, tmp557, tmp558
# C/parallel-only-omp/cross_sections.h:133:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vdivsd	%xmm5, %xmm0, %xmm0	# tmp855, tmp558, _177
	vucomisd	%xmm0, %xmm4	# _177, tmp561
	ja	.L341	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _177, g
.L238:
# C/parallel-only-omp/cross_sections.h:134:         nu = g * sigma_tot_i[i];
	vmulsd	0(%r13,%r12,8), %xmm0, %xmm0	# MEM[(double *)&sigma_tot_i + ivtmp.1689_930 * 8], g, nu
# C/parallel-only-omp/cross_sections.h:131:     for(i=0; i<CS_RANGES; i++){
	incq	%r12	# ivtmp.1689
# C/parallel-only-omp/cross_sections.h:135:         if (nu > nu_max) nu_max = nu;
	vmaxsd	%xmm1, %xmm0, %xmm1	# nu_max, nu, nu_max
# C/parallel-only-omp/cross_sections.h:131:     for(i=0; i<CS_RANGES; i++){
	cmpq	$1000000, %r12	#, ivtmp.1689
	jne	.L240	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	-432(%rbp), %rdi	# %sfp,
	vmovapd	%zmm8, -496(%rbp)	# vect__291.1367, %sfp
	leaq	.LC108(%rip), %rdx	#, tmp564
	movl	$2, %esi	#,
	vmovapd	%zmm9, -368(%rbp)	# vect__345.1344, %sfp
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:275:     c = max_ion_coll_freq() * DT_I;
	vmulsd	.LC54(%rip), %xmm1, %xmm1	#, nu_max, c
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm1, %xmm1, %xmm0	# c,
	vmovapd	%zmm7, -304(%rbp)	# vect__376.1333, %sfp
	vmovsd	%xmm1, -240(%rbp)	# c, %sfp
	vzeroupper
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:277:     if (c > 0.05) {conditions_OK = false;}
	vmovsd	-240(%rbp), %xmm1	# %sfp, c
	vcomisd	.LC19(%rip), %xmm1	#, c
	ja	.L241	#,
# C/parallel-only-omp/io_manager.h:278:     if (conditions_OK == false){
	testb	%bl, %bl	# conditions_OK
	vmovapd	-304(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovapd	-368(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-496(%rbp), %zmm8	# %sfp, vect__291.1367
	jne	.L242	#,
	vzeroupper
.L241:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	-432(%rbp), %rbx	# %sfp, _91
	leaq	.LC95(%rip), %rdx	#,
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
	movq	%rbx, %rdi	# _91,
	call	__fprintf_chk@PLT	#
	leaq	.LC109(%rip), %rdx	#, tmp567
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC95(%rip), %rdx	#,
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:282:         fclose(f);
	movq	%rbx, %rdi	# _91,
	call	fclose@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	xorl	%eax, %eax	#
	leaq	.LC110(%rip), %rsi	#, tmp569
	movl	$2, %edi	#,
	call	__printf_chk@PLT	#
	movq	-56(%rbp), %rax	# D.132814, tmp945
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp945
	jne	.L345	#,
# C/parallel-only-omp/io_manager.h:330: }
	addq	$584, %rsp	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC111(%rip), %rsi	#, tmp571
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
# C/parallel-only-omp/io_manager.h:330: }
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	.cfi_remember_state
	.cfi_def_cfa 13, 0
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	leaq	-16(%r13), %rsp	#,
	.cfi_def_cfa 7, 16
	popq	%r13	#
	.cfi_def_cfa_offset 8
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	jmp	__printf_chk@PLT	#
.L242:
	.cfi_restore_state
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	-432(%rbp), %rbx	# %sfp, _91
	vmovapd	%zmm7, -304(%rbp)	# vect__376.1333, %sfp
	leaq	.LC113(%rip), %rdx	#, tmp573
	movl	$2, %esi	#,
	vmovapd	%zmm8, -496(%rbp)	# vect__291.1367, %sfp
	movl	$1, %eax	#,
	vmovsd	.LC112(%rip), %xmm0	#,
	leaq	cumul_i_density(%rip), %r13	#, tmp857
	vmovapd	%zmm9, -368(%rbp)	# vect__345.1344, %sfp
	leaq	cumul_e_density(%rip), %r12	#, tmp841
	vzeroupper
# C/parallel-only-omp/io_manager.h:80:     c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
	xorl	%r14d, %r14d	# ivtmp.1680
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%rbx, %rdi	# _91,
	call	__fprintf_chk@PLT	#
	movq	%rbx, %rdi	# _91,
	leaq	.LC114(%rip), %rdx	#, tmp574
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC95(%rip), %rdx	#,
	movq	%rbx, %rdi	# _91,
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
	leaq	.LC117(%rip), %rbx	#, tmp856
	call	__fprintf_chk@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC115(%rip), %rsi	#, tmp576
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:79:     f = fopen("density.dat","w");
	leaq	.LC77(%rip), %rsi	#,
	leaq	.LC116(%rip), %rdi	#, tmp578
	call	fopen@PLT	#
# C/parallel-only-omp/io_manager.h:80:     c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1088
	vcvtsi2sdl	no_of_cycles(%rip), %xmm7, %xmm0	# no_of_cycles, tmp1088, tmp924
# C/parallel-only-omp/io_manager.h:80:     c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
	vmovsd	.LC10(%rip), %xmm7	#, tmp1089
# C/parallel-only-omp/io_manager.h:79:     f = fopen("density.dat","w");
	movq	%rax, %r15	# tmp900, _277
# C/parallel-only-omp/io_manager.h:80:     c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
	vdivsd	%xmm0, %xmm7, %xmm0	# tmp580, tmp1089, tmp581
# C/parallel-only-omp/io_manager.h:80:     c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
	vdivsd	.LC74(%rip), %xmm0, %xmm7	#, tmp581, c
	vmovsd	%xmm7, -240(%rbp)	# c, %sfp
	vzeroupper
	.p2align 4
	.p2align 3
.L244:
# C/parallel-only-omp/io_manager.h:82:         fprintf(f,"%8.5f  %12e  %12e\n",m * DX, cumul_e_density[m] * c, cumul_i_density[m] * c);
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1091
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%rbx, %rdx	# tmp856,
# C/parallel-only-omp/io_manager.h:82:         fprintf(f,"%8.5f  %12e  %12e\n",m * DX, cumul_e_density[m] * c, cumul_i_density[m] * c);
	vcvtsi2sdl	%r14d, %xmm7, %xmm0	# ivtmp.1680, tmp1091, tmp925
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movl	$2, %esi	#,
	vmovsd	-240(%rbp), %xmm7	# %sfp, c
	movq	%r15, %rdi	# _277,
	vmulsd	0(%r13,%r14,8), %xmm7, %xmm2	# MEM[(double *)&cumul_i_density + ivtmp.1680_924 * 8], c,
	vmulsd	(%r12,%r14,8), %xmm7, %xmm1	# MEM[(double *)&cumul_e_density + ivtmp.1680_924 * 8], c,
	movl	$3, %eax	#,
# C/parallel-only-omp/io_manager.h:81:     for(m=0; m<N_G; m++){
	incq	%r14	# ivtmp.1680
# C/parallel-only-omp/io_manager.h:82:         fprintf(f,"%8.5f  %12e  %12e\n",m * DX, cumul_e_density[m] * c, cumul_i_density[m] * c);
	vmulsd	.LC104(%rip), %xmm0, %xmm0	#, tmp588, tmp589
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:81:     for(m=0; m<N_G; m++){
	cmpq	$400, %r14	#, ivtmp.1680
	jne	.L244	#,
# C/parallel-only-omp/io_manager.h:84:     fclose(f);
	vmovapd	-304(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovapd	-368(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-496(%rbp), %zmm8	# %sfp, vect__291.1367
	movq	%r15, %rdi	# _277,
	leaq	eepf(%rip), %r13	#, tmp861
	vmovapd	%zmm7, -560(%rbp)	# vect__376.1333, %sfp
	vmovapd	%zmm9, -304(%rbp)	# vect__345.1344, %sfp
	vmovapd	%zmm8, -240(%rbp)	# vect__291.1367, %sfp
	vzeroupper
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:97:     h = 0.0;
	vmovapd	-560(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovapd	-304(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-240(%rbp), %zmm8	# %sfp, vect__291.1367
	movq	%r13, %rax	# tmp861, ivtmp.1675
	leaq	16000(%r13), %rdx	#, _917
	vxorpd	%xmm0, %xmm0, %xmm0	# h
.L245:
	vaddsd	(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_224], 64, 0>, h, stmp_h_263.1395
	addq	$64, %rax	#, ivtmp.1675
	vaddsd	-56(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_224], 64, 64>, stmp_h_263.1395, stmp_h_263.1395
	vaddsd	-48(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_224], 64, 128>, stmp_h_263.1395, stmp_h_263.1395
	vaddsd	-40(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_224], 64, 192>, stmp_h_263.1395, stmp_h_263.1395
	vaddsd	-32(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_224], 64, 256>, stmp_h_263.1395, stmp_h_263.1395
	vaddsd	-24(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_224], 64, 320>, stmp_h_263.1395, stmp_h_263.1395
# C/parallel-only-omp/io_manager.h:98:     for (i=0; i<N_EEPF; i++) {h += eepf[i];}
	vaddsd	-16(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_224], 64, 384>, stmp_h_263.1395, stmp_h_263.1395
	vaddsd	-8(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_224], 64, 448>, stmp_h_263.1395, h
	cmpq	%rdx, %rax	# _917, ivtmp.1675
	jne	.L245	#,
	vmovapd	%zmm8, -496(%rbp)	# vect__291.1367, %sfp
# C/parallel-only-omp/io_manager.h:100:     f = fopen("eepf.dat","w");
	leaq	.LC77(%rip), %rsi	#,
	leaq	.LC118(%rip), %rdi	#, tmp595
# C/parallel-only-omp/io_manager.h:99:     h *= DE_EEPF;
	vmulsd	.LC19(%rip), %xmm0, %xmm4	#, h, h
	vmovapd	%zmm9, -368(%rbp)	# vect__345.1344, %sfp
	vmovsd	%xmm4, -240(%rbp)	# h, %sfp
	leaq	.LC119(%rip), %r12	#, tmp858
	vmovapd	%zmm7, -304(%rbp)	# vect__376.1333, %sfp
# C/parallel-only-omp/io_manager.h:100:     f = fopen("eepf.dat","w");
	vzeroupper
	call	fopen@PLT	#
	xorl	%r14d, %r14d	# ivtmp.1667
	movq	%rax, %rbx	# tmp901, _267
	vzeroupper
	.p2align 4
	.p2align 3
.L250:
# C/parallel-only-omp/io_manager.h:102:         energy = (i + 0.5) * DE_EEPF;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1095
# C/parallel-only-omp/io_manager.h:103:         fprintf(f,"%e  %e\n", energy, eepf[i] / h / sqrt(energy));
	vmovsd	0(%r13,%r14,8), %xmm1	# MEM[(double *)&eepf + ivtmp.1667_903 * 8], MEM[(double *)&eepf + ivtmp.1667_903 * 8]
# C/parallel-only-omp/io_manager.h:102:         energy = (i + 0.5) * DE_EEPF;
	vcvtsi2sdl	%r14d, %xmm7, %xmm2	# ivtmp.1667, tmp1095, tmp926
# C/parallel-only-omp/io_manager.h:103:         fprintf(f,"%e  %e\n", energy, eepf[i] / h / sqrt(energy));
	vdivsd	-240(%rbp), %xmm1, %xmm1	# %sfp, MEM[(double *)&eepf + ivtmp.1667_903 * 8], _273
# C/parallel-only-omp/io_manager.h:102:         energy = (i + 0.5) * DE_EEPF;
	vaddsd	.LC45(%rip), %xmm2, %xmm2	#, tmp597, tmp598
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1097
# C/parallel-only-omp/io_manager.h:102:         energy = (i + 0.5) * DE_EEPF;
	vmulsd	.LC19(%rip), %xmm2, %xmm2	#, tmp598, energy
	vucomisd	%xmm2, %xmm7	# energy, tmp1097
	ja	.L342	#,
# C/parallel-only-omp/io_manager.h:103:         fprintf(f,"%e  %e\n", energy, eepf[i] / h / sqrt(energy));
	vsqrtsd	%xmm2, %xmm2, %xmm0	# energy, _274
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vdivsd	%xmm0, %xmm1, %xmm1	# _274, _273,
.L347:
	movq	%r12, %rdx	# tmp858,
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _267,
	movl	$2, %eax	#,
# C/parallel-only-omp/io_manager.h:101:     for (i=0; i<N_EEPF; i++) {
	incq	%r14	# ivtmp.1667
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm2, %xmm2, %xmm0	# energy,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:101:     for (i=0; i<N_EEPF; i++) {
	cmpq	$2000, %r14	#, ivtmp.1667
	jne	.L250	#,
	vmovapd	-304(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovapd	-368(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-496(%rbp), %zmm8	# %sfp, vect__291.1367
# C/parallel-only-omp/io_manager.h:105:     fclose(f);
	movq	%rbx, %rdi	# _267,
	leaq	ifed_pow(%rip), %r15	#, tmp884
	leaq	ifed_gnd(%rip), %r14	#, tmp852
	vmovapd	%zmm8, -368(%rbp)	# vect__291.1367, %sfp
	vmovapd	%zmm9, -304(%rbp)	# vect__345.1344, %sfp
	vmovapd	%zmm7, -240(%rbp)	# vect__376.1333, %sfp
	vzeroupper
	call	fclose@PLT	#
	vmovapd	-368(%rbp), %zmm8	# %sfp, vect__291.1367
	vmovapd	-304(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-240(%rbp), %zmm7	# %sfp, vect__376.1333
	xorl	%eax, %eax	# ivtmp.1665
# C/parallel-only-omp/io_manager.h:119:     h_gnd = 0.0;
	vxorpd	%xmm5, %xmm5, %xmm5	# h_gnd
# C/parallel-only-omp/io_manager.h:118:     h_pow = 0.0;
	vmovsd	%xmm5, %xmm5, %xmm4	#, h_pow
.L251:
# C/parallel-only-omp/io_manager.h:120:     for (i=0; i<N_IFED; i++) {h_pow += ifed_pow[i]; h_gnd += ifed_gnd[i];}
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp1098
	vcvtsi2sdl	(%r15,%rax), %xmm6, %xmm0	# MEM[(int *)&ifed_pow + ivtmp.1665_904 * 1], tmp1098, tmp927
	vaddsd	%xmm0, %xmm4, %xmm4	# tmp609, h_pow, h_pow
# C/parallel-only-omp/io_manager.h:120:     for (i=0; i<N_IFED; i++) {h_pow += ifed_pow[i]; h_gnd += ifed_gnd[i];}
	vcvtsi2sdl	(%r14,%rax), %xmm6, %xmm0	# MEM[(int *)&ifed_gnd + ivtmp.1665_904 * 1], tmp1099, tmp928
# C/parallel-only-omp/io_manager.h:120:     for (i=0; i<N_IFED; i++) {h_pow += ifed_pow[i]; h_gnd += ifed_gnd[i];}
	addq	$4, %rax	#, ivtmp.1665
# C/parallel-only-omp/io_manager.h:120:     for (i=0; i<N_IFED; i++) {h_pow += ifed_pow[i]; h_gnd += ifed_gnd[i];}
	vaddsd	%xmm0, %xmm5, %xmm5	# tmp611, h_gnd, h_gnd
# C/parallel-only-omp/io_manager.h:120:     for (i=0; i<N_IFED; i++) {h_pow += ifed_pow[i]; h_gnd += ifed_gnd[i];}
	cmpq	$800, %rax	#, ivtmp.1665
	jne	.L251	#,
	vmovapd	%zmm7, -368(%rbp)	# vect__376.1333, %sfp
# C/parallel-only-omp/io_manager.h:125:     f = fopen("ifed.dat","w");
	leaq	.LC77(%rip), %rsi	#,
	leaq	.LC120(%rip), %rdi	#, tmp615
	vmovsd	%xmm5, -304(%rbp)	# h_gnd, %sfp
	vmovapd	%zmm8, -624(%rbp)	# vect__291.1367, %sfp
	vmovsd	%xmm4, -240(%rbp)	# h_pow, %sfp
# C/parallel-only-omp/io_manager.h:123:     mean_i_energy_pow = 0.0;
	movq	$0x000000000, mean_i_energy_pow(%rip)	#, mean_i_energy_pow
# C/parallel-only-omp/io_manager.h:124:     mean_i_energy_gnd = 0.0;
	movq	$0x000000000, mean_i_energy_gnd(%rip)	#, mean_i_energy_gnd
	vmovapd	%zmm9, -560(%rbp)	# vect__345.1344, %sfp
	leaq	.LC121(%rip), %rbx	#, tmp869
# C/parallel-only-omp/io_manager.h:125:     f = fopen("ifed.dat","w");
	vzeroupper
	call	fopen@PLT	#
	vmovapd	-368(%rbp), %zmm7	# %sfp, vect__376.1333
	xorl	%r13d, %r13d	# ivtmp.1649
	movq	%rax, %r12	# tmp903, _235
	vmovapd	%zmm7, -496(%rbp)	# vect__376.1333, %sfp
	vzeroupper
	.p2align 4
	.p2align 3
.L252:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%rbx, %rdx	# tmp869,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _235,
	movl	$3, %eax	#,
# C/parallel-only-omp/io_manager.h:127:         energy = (i + 0.5) * DE_IFED;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1100
	vcvtsi2sdl	%r13d, %xmm7, %xmm3	# ivtmp.1649, tmp1100, tmp929
# C/parallel-only-omp/io_manager.h:128:         fprintf(f,"%6.2f %10.6f %10.6f\n", energy, (double)(ifed_pow[i])/h_pow, (double)(ifed_gnd[i])/h_gnd);
	vcvtsi2sdl	(%r14,%r13,4), %xmm7, %xmm2	# MEM[(int *)&ifed_gnd + ivtmp.1649_894 * 4], tmp1101, tmp930
# C/parallel-only-omp/io_manager.h:127:         energy = (i + 0.5) * DE_IFED;
	vaddsd	.LC45(%rip), %xmm3, %xmm3	#, tmp617, energy
# C/parallel-only-omp/io_manager.h:128:         fprintf(f,"%6.2f %10.6f %10.6f\n", energy, (double)(ifed_pow[i])/h_pow, (double)(ifed_gnd[i])/h_gnd);
	vcvtsi2sdl	(%r15,%r13,4), %xmm7, %xmm1	# MEM[(int *)&ifed_pow + ivtmp.1649_894 * 4], tmp1102, tmp931
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm3, %xmm3, %xmm0	# energy,
	vmovsd	%xmm3, -368(%rbp)	# energy, %sfp
	vdivsd	-304(%rbp), %xmm2, %xmm2	# %sfp, tmp620,
	vdivsd	-240(%rbp), %xmm1, %xmm1	# %sfp, tmp623,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:129:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1105
# C/parallel-only-omp/io_manager.h:129:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vmovsd	-368(%rbp), %xmm3	# %sfp, energy
# C/parallel-only-omp/io_manager.h:129:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vcvtsi2sdl	(%r15,%r13,4), %xmm7, %xmm0	# MEM[(int *)&ifed_pow + ivtmp.1649_894 * 4], tmp1105, tmp932
# C/parallel-only-omp/io_manager.h:129:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vmulsd	%xmm3, %xmm0, %xmm0	# energy, tmp627, tmp628
# C/parallel-only-omp/io_manager.h:129:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vdivsd	-240(%rbp), %xmm0, %xmm0	# %sfp, tmp628, tmp629
# C/parallel-only-omp/io_manager.h:129:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vaddsd	mean_i_energy_pow(%rip), %xmm0, %xmm0	# mean_i_energy_pow, tmp629, tmp630
	vmovsd	%xmm0, mean_i_energy_pow(%rip)	# tmp630, mean_i_energy_pow
# C/parallel-only-omp/io_manager.h:130:         mean_i_energy_gnd += energy * (double)(ifed_gnd[i]) / h_gnd;
	vcvtsi2sdl	(%r14,%r13,4), %xmm7, %xmm0	# MEM[(int *)&ifed_gnd + ivtmp.1649_894 * 4], tmp1107, tmp933
# C/parallel-only-omp/io_manager.h:126:     for (i=0; i<N_IFED; i++) {
	incq	%r13	# ivtmp.1649
# C/parallel-only-omp/io_manager.h:130:         mean_i_energy_gnd += energy * (double)(ifed_gnd[i]) / h_gnd;
	vmulsd	%xmm3, %xmm0, %xmm0	# energy, tmp633, tmp634
# C/parallel-only-omp/io_manager.h:130:         mean_i_energy_gnd += energy * (double)(ifed_gnd[i]) / h_gnd;
	vdivsd	-304(%rbp), %xmm0, %xmm0	# %sfp, tmp634, tmp635
# C/parallel-only-omp/io_manager.h:130:         mean_i_energy_gnd += energy * (double)(ifed_gnd[i]) / h_gnd;
	vaddsd	mean_i_energy_gnd(%rip), %xmm0, %xmm0	# mean_i_energy_gnd, tmp635, tmp636
	vmovsd	%xmm0, mean_i_energy_gnd(%rip)	# tmp636, mean_i_energy_gnd
# C/parallel-only-omp/io_manager.h:126:     for (i=0; i<N_IFED; i++) {
	cmpq	$200, %r13	#, ivtmp.1649
	jne	.L252	#,
# C/parallel-only-omp/io_manager.h:132:     fclose(f);
	vmovapd	-496(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovapd	-560(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-624(%rbp), %zmm8	# %sfp, vect__291.1367
	movq	%r12, %rdi	# _235,
	vmovapd	%zmm7, -368(%rbp)	# vect__376.1333, %sfp
	vmovapd	%zmm9, -304(%rbp)	# vect__345.1344, %sfp
	vmovapd	%zmm8, -240(%rbp)	# vect__291.1367, %sfp
	vzeroupper
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:163:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	movl	no_of_cycles(%rip), %eax	# no_of_cycles, no_of_cycles.294_185
# C/parallel-only-omp/io_manager.h:163:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1109
# C/parallel-only-omp/io_manager.h:163:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	vmovsd	.LC122(%rip), %xmm3	#, tmp640
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vbroadcastsd	.LC126(%rip), %zmm13	#, tmp887
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vbroadcastsd	.LC50(%rip), %zmm10	#, tmp888
# C/parallel-only-omp/io_manager.h:164:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	vmovsd	.LC124(%rip), %xmm12	#, tmp644
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vmovapd	-304(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-240(%rbp), %zmm8	# %sfp, vect__291.1367
# C/parallel-only-omp/io_manager.h:164:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	xorl	%r13d, %r13d	# ivtmp.1647
# C/parallel-only-omp/io_manager.h:172:             if (counter_e_xt[i][j] > 0) {
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp657
# C/parallel-only-omp/io_manager.h:163:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	imull	$4000, %eax, %edx	#, no_of_cycles.294_185, tmp638
# C/parallel-only-omp/io_manager.h:163:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	vcvtsi2sdl	%edx, %xmm7, %xmm0	# tmp638, tmp1109, tmp934
# C/parallel-only-omp/io_manager.h:163:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	vdivsd	%xmm0, %xmm3, %xmm3	# tmp639, tmp640, f1
# C/parallel-only-omp/io_manager.h:164:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	vcvtsi2sdl	%eax, %xmm7, %xmm0	# no_of_cycles.294_185, tmp1110, tmp935
	leaq	pot_xt(%rip), %rax	#, _870
	vmovq	%rax, %xmm22	# _870, _870
	leaq	efield_xt(%rip), %rax	#, _874
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vmovapd	-368(%rbp), %zmm7	# %sfp, vect__376.1333
# C/parallel-only-omp/io_manager.h:164:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	vmulsd	.LC123(%rip), %xmm0, %xmm0	#, tmp641, tmp642
	vmovq	%rax, %xmm21	# _874, _874
	leaq	ne_xt(%rip), %rax	#, _880
# C/parallel-only-omp/io_manager.h:164:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	vdivsd	%xmm0, %xmm12, %xmm12	# tmp642, tmp644, f2
	vbroadcastsd	%xmm3, %zmm3	# f1, vect_cst__794
	vmovq	%rax, %xmm20	# _880, _880
	leaq	ni_xt(%rip), %rax	#, _887
	vbroadcastsd	%xmm12, %zmm12	# f2, vect_cst__898
	vmovq	%rax, %xmm19	# _887, _887
	leaq	counter_e_xt(%rip), %rax	#, tmp846
	vmovq	%rax, %xmm23	# tmp846, tmp846
	leaq	ue_xt(%rip), %rax	#, tmp862
	vmovq	%rax, %xmm24	# tmp862, tmp862
	leaq	je_xt(%rip), %rax	#, _862
	vmovq	%rax, %xmm25	# _862, _862
	leaq	meanee_xt(%rip), %rax	#, _867
	vmovq	%rax, %xmm26	# _867, _867
	leaq	ioniz_rate_xt(%rip), %rax	#, _846
	vmovq	%rax, %xmm27	# _846, _846
	leaq	counter_i_xt(%rip), %rax	#, tmp876
	vmovq	%rax, %xmm28	# tmp876, tmp876
	leaq	ui_xt(%rip), %rax	#, tmp843
	vmovq	%rax, %xmm29	# tmp843, tmp843
	leaq	ji_xt(%rip), %rax	#, _838
	vmovq	%rax, %xmm30	# _838, _838
	leaq	meanei_xt(%rip), %rax	#, _825
	vmovq	%rax, %xmm31	# _825, _825
	.p2align 4
	.p2align 3
.L260:
	vmovq	%xmm22, %rax	# _870, _870
	leaq	poweri_xt(%rip), %r9	#, ivtmp.1414
	leaq	(%rax,%r13), %r11	#, vectp_pot_xt.1304
	vmovq	%xmm21, %rax	# _874, _874
	leaq	0(%r13,%r9), %r15	#, vectp_poweri_xt.1391
	leaq	(%rax,%r13), %r10	#, vectp_efield_xt.1310
	vmovq	%xmm20, %rax	# _880, _880
	leaq	(%rax,%r13), %r8	#, vectp_ne_xt.1316
	vmovq	%xmm19, %rax	# _887, _887
	leaq	(%rax,%r13), %rdi	#, vectp_ni_xt.1322
	vmovq	%xmm23, %rax	# tmp846, tmp846
	addq	%r13, %rax	# ivtmp.1647, vectp_counter_e_xt.1328
	vmovq	%rax, %xmm18	# vectp_counter_e_xt.1328, vectp_counter_e_xt.1328
	vmovq	%xmm24, %rax	# tmp862, tmp862
	addq	%r13, %rax	# ivtmp.1647, vectp.1332
	vmovq	%rax, %xmm17	# vectp.1332, vectp.1332
	vmovq	%xmm25, %rax	# _862, _862
	leaq	(%rax,%r13), %rsi	#, vectp.1341
	vmovq	%xmm26, %rax	# _867, _867
	leaq	(%rax,%r13), %r14	#, vectp.1343
	vmovq	%xmm27, %rax	# _846, _846
	leaq	(%rax,%r13), %r12	#, vectp_ioniz_rate_xt.1349
	vmovq	%xmm28, %rax	# tmp876, tmp876
	addq	%r13, %rax	# ivtmp.1647, vectp_counter_i_xt.1362
	vmovq	%rax, %xmm16	# vectp_counter_i_xt.1362, vectp_counter_i_xt.1362
	vmovq	%xmm29, %rax	# tmp843, tmp843
	addq	%r13, %rax	# ivtmp.1647, vectp.1366
	vmovq	%rax, %xmm15	# vectp.1366, vectp.1366
	vmovq	%xmm30, %rax	# _838, _838
	addq	%r13, %rax	# ivtmp.1647, vectp.1374
	movq	%rax, -240(%rbp)	# vectp.1374, %sfp
	vmovq	%xmm31, %rax	# _825, _825
	leaq	(%rax,%r13), %rbx	#, vectp_meanei_xt.1376
	leaq	powere_xt(%rip), %rax	#, ivtmp.1413
	movq	%rax, -304(%rbp)	# ivtmp.1413, %sfp
	addq	%r13, %rax	# ivtmp.1647, vectp_powere_xt.1388
	vmovq	%rax, %xmm14	# vectp_powere_xt.1388, vectp_powere_xt.1388
	xorl	%eax, %eax	# ivtmp.1595
	jmp	.L259	#
	.p2align 4
	.p2align 3
.L253:
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vxorpd	%xmm0, %xmm0, %xmm0	# vect__354.1339
	movl	$-1, %ecx	#, mask__762.1352
# C/parallel-only-omp/io_manager.h:176:                 ioniz_rate_xt[i][j] *= f2;
	vmovapd	%zmm0, %zmm1	#, vect__327.1351
.L299:
# C/parallel-only-omp/io_manager.h:178:                 ue_xt[i][j]         = 0.0;
	kmovb	%ecx, %k2	# mask__762.1352, mask__762.1352
	vmovupd	%zmm6, (%rdx){%k2}	# tmp657, MEM <vector(8) double> [(double *)_457], mask__762.1352
# C/parallel-only-omp/io_manager.h:179:                 je_xt[i][j]         = 0.0;
	vmovupd	%zmm6, (%rsi,%rax){%k2}	# tmp657, MEM <vector(8) double> [(double *)vectp.1341_872 + ivtmp.1595_456 * 1], mask__762.1352
# C/parallel-only-omp/io_manager.h:180:                 meanee_xt[i][j]     = 0.0;
	vmovupd	%zmm6, (%r14,%rax){%k2}	# tmp657, MEM <vector(8) double> [(double *)vectp.1343_878 + ivtmp.1595_456 * 1], mask__762.1352
	.p2align 4
	.p2align 3
.L254:
# C/parallel-only-omp/io_manager.h:183:             if (counter_i_xt[i][j] > 0) {
	vmovq	%xmm16, %rcx	# vectp_counter_i_xt.1362, vectp_counter_i_xt.1362
# C/parallel-only-omp/io_manager.h:176:                 ioniz_rate_xt[i][j] *= f2;
	vmovupd	%zmm1, (%r12,%rax)	# vect__327.1351, MEM <vector(8) double> [(double *)vectp_ioniz_rate_xt.1349_892 + ivtmp.1595_456 * 1]
# C/parallel-only-omp/io_manager.h:183:             if (counter_i_xt[i][j] > 0) {
	vmovupd	(%rcx,%rax), %zmm5	# MEM <vector(8) double> [(double *)vectp_counter_i_xt.1362_929 + ivtmp.1595_456 * 1], MEM <vector(8) double> [(double *)vectp_counter_i_xt.1362_929 + ivtmp.1595_456 * 1]
	vmovq	%xmm15, %rcx	# vectp.1366, vectp.1366
	leaq	(%rcx,%rax), %rdx	#, _798
# C/parallel-only-omp/io_manager.h:183:             if (counter_i_xt[i][j] > 0) {
	vcmppd	$14, %zmm6, %zmm5, %k1	#, tmp657, MEM <vector(8) double> [(double *)vectp_counter_i_xt.1362_929 + ivtmp.1595_456 * 1], mask__698.1364
# C/parallel-only-omp/io_manager.h:184:                 ui_xt[i][j]     = ui_xt[i][j] / counter_i_xt[i][j];
	vmovupd	(%rdx), %zmm8{%k1}	# MEM <vector(8) double> [(double *)_798], vect__291.1367, mask__698.1364, vect__291.1367
	kortestb	%k1, %k1	# mask__698.1364
# C/parallel-only-omp/io_manager.h:184:                 ui_xt[i][j]     = ui_xt[i][j] / counter_i_xt[i][j];
	vdivpd	%zmm5, %zmm8, %zmm1{%k1}{z}	# MEM <vector(8) double> [(double *)vectp_counter_i_xt.1362_929 + ivtmp.1595_456 * 1], vect__291.1367, vect__282.1368, mask__698.1364,
	jne	.L348	#,
# C/parallel-only-omp/io_manager.h:185:                 ji_xt[i][j]     = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE;
	vxorpd	%xmm1, %xmm1, %xmm1	# vect__260.1372
	movl	$-1, %ecx	#, mask__769.1379
# C/parallel-only-omp/io_manager.h:186:                 meanei_xt[i][j] = meanei_xt[i][j] / counter_i_xt[i][j];
	vmovapd	%zmm1, %zmm2	#, vect__228.1378
.L298:
# C/parallel-only-omp/io_manager.h:188:                 ui_xt[i][j]     = 0.0;
	kmovb	%ecx, %k5	# mask__769.1379, mask__769.1379
	vmovupd	%zmm6, (%rdx){%k5}	# tmp657, MEM <vector(8) double> [(double *)_798], mask__769.1379
# C/parallel-only-omp/io_manager.h:189:                 ji_xt[i][j]     = 0.0;
	movq	-240(%rbp), %rdx	# %sfp, vectp.1374
	vmovupd	%zmm6, (%rdx,%rax){%k5}	# tmp657, MEM <vector(8) double> [(double *)vectp.1374_956 + ivtmp.1595_456 * 1], mask__769.1379
	.p2align 4
	.p2align 3
.L256:
# C/parallel-only-omp/io_manager.h:192:             powere_xt[i][j] = je_xt[i][j] * efield_xt[i][j];
	vmulpd	%zmm4, %zmm0, %zmm0	# vect__400.1312, vect__354.1339, vect__181.1386
# C/parallel-only-omp/io_manager.h:193:             poweri_xt[i][j] = ji_xt[i][j] * efield_xt[i][j];
	vmulpd	%zmm4, %zmm1, %zmm1	# vect__400.1312, vect__260.1372, vect__170.1389
# C/parallel-only-omp/io_manager.h:192:             powere_xt[i][j] = je_xt[i][j] * efield_xt[i][j];
	vmovq	%xmm14, %rcx	# vectp_powere_xt.1388, vectp_powere_xt.1388
# C/parallel-only-omp/io_manager.h:186:                 meanei_xt[i][j] = meanei_xt[i][j] / counter_i_xt[i][j];
	vmovupd	%zmm2, (%rbx,%rax)	# vect__228.1378, MEM <vector(8) double> [(double *)vectp_meanei_xt.1376_962 + ivtmp.1595_456 * 1]
# C/parallel-only-omp/io_manager.h:192:             powere_xt[i][j] = je_xt[i][j] * efield_xt[i][j];
	vmovupd	%zmm0, (%rcx,%rax)	# vect__181.1386, MEM <vector(8) double> [(double *)vectp_powere_xt.1388_992 + ivtmp.1595_456 * 1]
# C/parallel-only-omp/io_manager.h:193:             poweri_xt[i][j] = ji_xt[i][j] * efield_xt[i][j];
	vmovupd	%zmm1, (%r15,%rax)	# vect__170.1389, MEM <vector(8) double> [(double *)vectp_poweri_xt.1391_999 + ivtmp.1595_456 * 1]
	addq	$64, %rax	#, ivtmp.1595
	cmpq	$1600, %rax	#, ivtmp.1595
	je	.L349	#,
.L259:
# C/parallel-only-omp/io_manager.h:168:             pot_xt[i][j]    *= f1;
	vmulpd	(%r11,%rax), %zmm3, %zmm0	# MEM <vector(8) double> [(double *)vectp_pot_xt.1304_788 + ivtmp.1595_456 * 1], vect_cst__794, vect__403.1306
# C/parallel-only-omp/io_manager.h:172:             if (counter_e_xt[i][j] > 0) {
	vmovq	%xmm18, %rcx	# vectp_counter_e_xt.1328, vectp_counter_e_xt.1328
# C/parallel-only-omp/io_manager.h:168:             pot_xt[i][j]    *= f1;
	vmovupd	%zmm0, (%r11,%rax)	# vect__403.1306, MEM <vector(8) double> [(double *)vectp_pot_xt.1304_788 + ivtmp.1595_456 * 1]
# C/parallel-only-omp/io_manager.h:169:             efield_xt[i][j] *= f1;
	vmulpd	(%r10,%rax), %zmm3, %zmm4	# MEM <vector(8) double> [(double *)vectp_efield_xt.1310_802 + ivtmp.1595_456 * 1], vect_cst__794, vect__400.1312
	vmovupd	%zmm4, (%r10,%rax)	# vect__400.1312, MEM <vector(8) double> [(double *)vectp_efield_xt.1310_802 + ivtmp.1595_456 * 1]
# C/parallel-only-omp/io_manager.h:170:             ne_xt[i][j]     *= f1;
	vmulpd	(%r8,%rax), %zmm3, %zmm5	# MEM <vector(8) double> [(double *)vectp_ne_xt.1316_816 + ivtmp.1595_456 * 1], vect_cst__794, vect__397.1318
	vmovupd	%zmm5, (%r8,%rax)	# vect__397.1318, MEM <vector(8) double> [(double *)vectp_ne_xt.1316_816 + ivtmp.1595_456 * 1]
# C/parallel-only-omp/io_manager.h:171:             ni_xt[i][j]     *= f1;
	vmulpd	(%rdi,%rax), %zmm3, %zmm2	# MEM <vector(8) double> [(double *)vectp_ni_xt.1322_830 + ivtmp.1595_456 * 1], vect_cst__794, vect__394.1324
	vmovupd	%zmm2, (%rdi,%rax)	# vect__394.1324, MEM <vector(8) double> [(double *)vectp_ni_xt.1322_830 + ivtmp.1595_456 * 1]
# C/parallel-only-omp/io_manager.h:172:             if (counter_e_xt[i][j] > 0) {
	vmovupd	(%rcx,%rax), %zmm1	# MEM <vector(8) double> [(double *)vectp_counter_e_xt.1328_844 + ivtmp.1595_456 * 1], MEM <vector(8) double> [(double *)vectp_counter_e_xt.1328_844 + ivtmp.1595_456 * 1]
	vmovq	%xmm17, %rcx	# vectp.1332, vectp.1332
	leaq	(%rcx,%rax), %rdx	#, _457
# C/parallel-only-omp/io_manager.h:172:             if (counter_e_xt[i][j] > 0) {
	vcmppd	$14, %zmm6, %zmm1, %k1	#, tmp657, MEM <vector(8) double> [(double *)vectp_counter_e_xt.1328_844 + ivtmp.1595_456 * 1], mask__696.1330
# C/parallel-only-omp/io_manager.h:173:                 ue_xt[i][j]     =  ue_xt[i][j] / counter_e_xt[i][j];
	vmovupd	(%rdx), %zmm7{%k1}	# MEM <vector(8) double> [(double *)_457], vect__376.1333, mask__696.1330, vect__376.1333
	kortestb	%k1, %k1	# mask__696.1330
# C/parallel-only-omp/io_manager.h:173:                 ue_xt[i][j]     =  ue_xt[i][j] / counter_e_xt[i][j];
	vdivpd	%zmm1, %zmm7, %zmm0{%k1}{z}	# MEM <vector(8) double> [(double *)vectp_counter_e_xt.1328_844 + ivtmp.1595_456 * 1], vect__376.1333, vect__372.1334, mask__696.1330,
	je	.L253	#,
# C/parallel-only-omp/io_manager.h:173:                 ue_xt[i][j]     =  ue_xt[i][j] / counter_e_xt[i][j];
	vmovupd	%zmm0, (%rdx){%k1}	# vect__372.1334, MEM <vector(8) double> [(double *)_457], mask__696.1330
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vxorpd	%zmm13, %zmm0, %zmm0	# tmp887, vect__372.1334, vect__363.1337
	leaq	(%r14,%rax), %rcx	#, _810
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vmulpd	%zmm5, %zmm0, %zmm11{%k1}{z}	# vect__397.1318, vect__363.1337, vect__358.1338, mask__696.1330,
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vmulpd	%zmm10, %zmm11, %zmm0{%k1}{z}	# tmp888, vect__358.1338, vect__354.1339, mask__696.1330,
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vmovupd	%zmm0, (%rsi,%rax){%k1}	# vect__354.1339, MEM <vector(8) double> [(double *)vectp.1341_872 + ivtmp.1595_456 * 1], mask__696.1330
# C/parallel-only-omp/io_manager.h:175:                 meanee_xt[i][j] =  meanee_xt[i][j] / counter_e_xt[i][j];
	vmovupd	(%rcx), %zmm9{%k1}	# MEM <vector(8) double> [(double *)_810], vect__345.1344, mask__696.1330, vect__345.1344
# C/parallel-only-omp/io_manager.h:175:                 meanee_xt[i][j] =  meanee_xt[i][j] / counter_e_xt[i][j];
	vdivpd	%zmm1, %zmm9, %zmm5{%k1}{z}	# MEM <vector(8) double> [(double *)vectp_counter_e_xt.1328_844 + ivtmp.1595_456 * 1], vect__345.1344, vect__340.1345, mask__696.1330,
# C/parallel-only-omp/io_manager.h:175:                 meanee_xt[i][j] =  meanee_xt[i][j] / counter_e_xt[i][j];
	vmovupd	%zmm5, (%rcx){%k1}	# vect__340.1345, MEM <vector(8) double> [(double *)_810], mask__696.1330
	kmovb	%k1, %ecx	# mask__696.1330, mask__696.1330
# C/parallel-only-omp/io_manager.h:176:                 ioniz_rate_xt[i][j] *= f2;
	vmulpd	(%r12,%rax), %zmm12, %zmm1{%k1}{z}	# MEM <vector(8) double> [(double *)vectp_ioniz_rate_xt.1349_892 + ivtmp.1595_456 * 1], vect_cst__898, vect__327.1351, mask__696.1330,
	xorb	$-1, %cl	#, mask__696.1330
	je	.L254	#,
	jmp	.L299	#
	.p2align 4
	.p2align 3
.L348:
# C/parallel-only-omp/io_manager.h:185:                 ji_xt[i][j]     = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE;
	vmulpd	%zmm1, %zmm2, %zmm11{%k1}{z}	# vect__282.1368, vect__394.1324, vect__262.1371, mask__698.1364,
# C/parallel-only-omp/io_manager.h:185:                 ji_xt[i][j]     = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE;
	movq	-240(%rbp), %rcx	# %sfp, vectp.1374
# C/parallel-only-omp/io_manager.h:184:                 ui_xt[i][j]     = ui_xt[i][j] / counter_i_xt[i][j];
	vmovupd	%zmm1, (%rdx){%k1}	# vect__282.1368, MEM <vector(8) double> [(double *)_798], mask__698.1364
# C/parallel-only-omp/io_manager.h:185:                 ji_xt[i][j]     = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE;
	vmulpd	%zmm10, %zmm11, %zmm1{%k1}{z}	# tmp888, vect__262.1371, vect__260.1372, mask__698.1364,
# C/parallel-only-omp/io_manager.h:185:                 ji_xt[i][j]     = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE;
	vmovupd	%zmm1, (%rcx,%rax){%k1}	# vect__260.1372, MEM <vector(8) double> [(double *)vectp.1374_956 + ivtmp.1595_456 * 1], mask__698.1364
# C/parallel-only-omp/io_manager.h:186:                 meanei_xt[i][j] = meanei_xt[i][j] / counter_i_xt[i][j];
	vmovupd	(%rbx,%rax), %zmm2	# MEM <vector(8) double> [(double *)vectp_meanei_xt.1376_962 + ivtmp.1595_456 * 1], tmp1155
	kmovb	%k1, %ecx	# mask__698.1364, mask__698.1364
	xorb	$-1, %cl	#, mask__698.1364
	vdivpd	%zmm5, %zmm2, %zmm2{%k1}{z}	# MEM <vector(8) double> [(double *)vectp_counter_i_xt.1362_929 + ivtmp.1595_456 * 1], tmp1155, vect__228.1378, mask__698.1364,
	je	.L256	#,
	jmp	.L298	#
	.p2align 4
	.p2align 3
.L349:
# C/parallel-only-omp/io_manager.h:166:     for (i=0; i<N_G; i++){
	addq	$1600, %r13	#, ivtmp.1647
	cmpq	$640000, %r13	#, ivtmp.1647
	jne	.L260	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	leaq	-144(%rbp), %rax	#, tmp842
	movabsq	$7218835313067847536, %rcx	#, tmp1163
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%r9, -368(%rbp)	# ivtmp.1414, %sfp
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	%rax, %rdi	# tmp842,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rcx, -144(%rbp)	# tmp1163, MEM <char[1:11]> [(void *)&fname]
	movq	%rax, -240(%rbp)	# tmp842, %sfp
	movl	$7627108, -137(%rbp)	#, MEM <char[1:11]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	vzeroupper
	call	fopen@PLT	#
	leaq	1600+pot_xt(%rip), %r12	#, ivtmp.1590
	leaq	.LC128(%rip), %rbx	#, tmp870
	movq	%rax, %r14	# tmp904, _380
	leaq	.LC129(%rip), %r13	#, tmp871
	.p2align 4
	.p2align 3
.L261:
	leaq	-1600(%r12), %r15	#, ivtmp.1582
	.p2align 4
	.p2align 3
.L262:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_216], MEM[(double *)_216]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _380,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1582
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r15, %r12	# ivtmp.1582, ivtmp.1590
	jne	.L262	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _380,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	addq	$1600, %r12	#, ivtmp.1590
	leaq	641600+pot_xt(%rip), %rax	#, tmp1164
	cmpq	%rax, %r12	# tmp1164, ivtmp.1590
	jne	.L261	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r14, %rdi	# _380,
	leaq	1600+efield_xt(%rip), %r14	#, ivtmp.1574
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8673761824059516517, %rax	#, tmp1165
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1165, MEM <char[1:14]> [(void *)&fname]
	movabsq	$32758180202444895, %rax	#, tmp1166
	movq	%rax, -138(%rbp)	# tmp1166, MEM <char[1:14]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r12	# tmp905, _371
	.p2align 4
	.p2align 3
.L264:
	leaq	-1600(%r14), %r15	#, ivtmp.1566
	.p2align 4
	.p2align 3
.L265:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_211], MEM[(double *)_211]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _371,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1566
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r14, %r15	# ivtmp.1574, ivtmp.1566
	jne	.L265	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _371,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	leaq	1600(%r15), %r14	#, ivtmp.1574
	leaq	641600+efield_xt(%rip), %rax	#, tmp1167
	cmpq	%r14, %rax	# ivtmp.1574, tmp1167
	jne	.L264	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r12, %rdi	# _371,
	leaq	1600+ne_xt(%rip), %r12	#, ivtmp.1558
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$7017785197120677230, %rax	#, tmp1168
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1168, MEM <char[1:10]> [(void *)&fname]
	movw	$116, -136(%rbp)	#, MEM <char[1:10]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r14	# tmp906, _362
	.p2align 4
	.p2align 3
.L267:
	leaq	-1600(%r12), %r15	#, ivtmp.1550
	.p2align 4
	.p2align 3
.L268:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_203], MEM[(double *)_203]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _362,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1550
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r15, %r12	# ivtmp.1550, ivtmp.1558
	jne	.L268	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _362,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	addq	$1600, %r12	#, ivtmp.1558
	leaq	641600+ne_xt(%rip), %rax	#, tmp1169
	cmpq	%r12, %rax	# ivtmp.1558, tmp1169
	jne	.L267	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r14, %rdi	# _362,
	leaq	1600+ni_xt(%rip), %r14	#, ivtmp.1542
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$7017785197120678254, %rax	#, tmp1170
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1170, MEM <char[1:10]> [(void *)&fname]
	movw	$116, -136(%rbp)	#, MEM <char[1:10]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r12	# tmp907, _353
	.p2align 4
	.p2align 3
.L270:
	leaq	-1600(%r14), %r15	#, ivtmp.1534
	.p2align 4
	.p2align 3
.L271:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_438], MEM[(double *)_438]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _353,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1534
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r14, %r15	# ivtmp.1542, ivtmp.1534
	jne	.L271	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _353,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	leaq	1600(%r15), %r14	#, ivtmp.1542
	leaq	641600+ni_xt(%rip), %rax	#, tmp1171
	cmpq	%rax, %r14	# tmp1171, ivtmp.1542
	jne	.L270	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r12, %rdi	# _353,
	leaq	1600+je_xt(%rip), %r12	#, ivtmp.1526
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$7017785197120677226, %rax	#, tmp1172
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1172, MEM <char[1:10]> [(void *)&fname]
	movw	$116, -136(%rbp)	#, MEM <char[1:10]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r14	# tmp908, _344
	.p2align 4
	.p2align 3
.L273:
	leaq	-1600(%r12), %r15	#, ivtmp.1518
	.p2align 4
	.p2align 3
.L274:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_715], MEM[(double *)_715]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _344,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1518
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r15, %r12	# ivtmp.1518, ivtmp.1526
	jne	.L274	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _344,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	addq	$1600, %r12	#, ivtmp.1526
	leaq	641600+je_xt(%rip), %rax	#, tmp1173
	cmpq	%r12, %rax	# ivtmp.1526, tmp1173
	jne	.L273	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r14, %rdi	# _344,
	leaq	1600+ji_xt(%rip), %r12	#, ivtmp.1510
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$7017785197120678250, %rax	#, tmp1174
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1174, MEM <char[1:10]> [(void *)&fname]
	movw	$116, -136(%rbp)	#, MEM <char[1:10]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r14	# tmp909, _335
	.p2align 4
	.p2align 3
.L276:
	leaq	-1600(%r12), %r15	#, ivtmp.1502
	.p2align 4
	.p2align 3
.L277:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_702], MEM[(double *)_702]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _335,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1502
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r15, %r12	# ivtmp.1502, ivtmp.1510
	jne	.L277	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _335,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	addq	$1600, %r12	#, ivtmp.1510
	leaq	641600+ji_xt(%rip), %rax	#, tmp1175
	cmpq	%rax, %r12	# tmp1175, ivtmp.1510
	jne	.L276	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r14, %rdi	# _335,
	leaq	1600+powere_xt(%rip), %r12	#, ivtmp.1494
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8673762949341867888, %rax	#, tmp1176
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1176, MEM <char[1:14]> [(void *)&fname]
	movabsq	$32758180202444895, %rax	#, tmp1177
	movq	%rax, -138(%rbp)	# tmp1177, MEM <char[1:14]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r14	# tmp910, _326
	.p2align 4
	.p2align 3
.L279:
	leaq	-1600(%r12), %r15	#, ivtmp.1486
	.p2align 4
	.p2align 3
.L280:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_717], MEM[(double *)_717]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _326,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1486
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r15, %r12	# ivtmp.1486, ivtmp.1494
	jne	.L280	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _326,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	addq	$1600, %r12	#, ivtmp.1494
	leaq	641600+powere_xt(%rip), %rax	#, tmp1178
	cmpq	%rax, %r12	# tmp1178, ivtmp.1494
	jne	.L279	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r14, %rdi	# _326,
	leaq	1600+poweri_xt(%rip), %r14	#, ivtmp.1478
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8673767347388378992, %rax	#, tmp1179
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1179, MEM <char[1:14]> [(void *)&fname]
	movabsq	$32758180202444895, %rax	#, tmp1180
	movq	%rax, -138(%rbp)	# tmp1180, MEM <char[1:14]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r12	# tmp911, _317
	.p2align 4
	.p2align 3
.L282:
	leaq	-1600(%r14), %r15	#, ivtmp.1470
	.p2align 4
	.p2align 3
.L283:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_740], MEM[(double *)_740]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _317,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1470
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r14, %r15	# ivtmp.1478, ivtmp.1470
	jne	.L283	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _317,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	leaq	1600(%r15), %r14	#, ivtmp.1478
	leaq	641600+poweri_xt(%rip), %rax	#, tmp1181
	cmpq	%r14, %rax	# ivtmp.1478, tmp1181
	jne	.L282	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r12, %rdi	# _317,
	leaq	1600+meanee_xt(%rip), %r14	#, ivtmp.1462
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8673762893656843629, %rax	#, tmp1182
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1182, MEM <char[1:14]> [(void *)&fname]
	movabsq	$32758180202444895, %rax	#, tmp1183
	movq	%rax, -138(%rbp)	# tmp1183, MEM <char[1:14]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r12	# tmp912, _308
	.p2align 4
	.p2align 3
.L285:
	leaq	-1600(%r14), %r15	#, ivtmp.1454
	.p2align 4
	.p2align 3
.L286:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_747], MEM[(double *)_747]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _308,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1454
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r14, %r15	# ivtmp.1462, ivtmp.1454
	jne	.L286	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _308,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	leaq	1600(%r15), %r14	#, ivtmp.1462
	leaq	641600+meanee_xt(%rip), %rax	#, tmp1184
	cmpq	%r14, %rax	# ivtmp.1462, tmp1184
	jne	.L285	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r12, %rdi	# _308,
	leaq	1600+meanei_xt(%rip), %r14	#, ivtmp.1446
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8673767291703354733, %rax	#, tmp1185
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1185, MEM <char[1:14]> [(void *)&fname]
	movabsq	$32758180202444895, %rax	#, tmp1186
	movq	%rax, -138(%rbp)	# tmp1186, MEM <char[1:14]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r12	# tmp913, _299
	.p2align 4
	.p2align 3
.L288:
	leaq	-1600(%r14), %r15	#, ivtmp.1438
	.p2align 4
	.p2align 3
.L289:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_170], MEM[(double *)_170]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _299,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1438
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r14, %r15	# ivtmp.1446, ivtmp.1438
	jne	.L289	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _299,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	leaq	1600(%r15), %r14	#, ivtmp.1446
	leaq	641600+meanei_xt(%rip), %rax	#, tmp1187
	cmpq	%r14, %rax	# ivtmp.1446, tmp1187
	jne	.L288	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	-304(%rbp), %r8	# %sfp, ivtmp.1413
	movq	-368(%rbp), %r9	# %sfp, ivtmp.1414
	movq	%r12, %rdi	# _299,
	leaq	1600+ioniz_rate_xt(%rip), %r12	#, ivtmp.1430
	movq	%r8, -496(%rbp)	# ivtmp.1413, %sfp
	movq	%r9, -304(%rbp)	# ivtmp.1414, %sfp
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8392562884964413289, %rax	#, tmp1188
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1188, MEM <char[1:13]> [(void *)&fname]
	movabsq	$32758180202444895, %rax	#, tmp1189
	movq	%rax, -139(%rbp)	# tmp1189, MEM <char[1:13]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	-496(%rbp), %r8	# %sfp, ivtmp.1413
	movq	%rax, %r14	# tmp914, _290
	movq	%r8, -240(%rbp)	# ivtmp.1413, %sfp
	.p2align 4
	.p2align 3
.L291:
	leaq	-1600(%r12), %r15	#, ivtmp.1422
	.p2align 4
	.p2align 3
.L292:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_398], MEM[(double *)_398]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _290,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1422
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r15, %r12	# ivtmp.1422, ivtmp.1430
	jne	.L292	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _290,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	addq	$1600, %r12	#, ivtmp.1430
	leaq	641600+ioniz_rate_xt(%rip), %rax	#, tmp1190
	cmpq	%r12, %rax	# ivtmp.1430, tmp1190
	jne	.L291	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	-240(%rbp), %r8	# %sfp, ivtmp.1413
	movq	-304(%rbp), %r9	# %sfp, ivtmp.1414
	movq	%r14, %rdi	# _290,
	movq	%r8, -368(%rbp)	# ivtmp.1413, %sfp
	movq	%r9, -240(%rbp)	# ivtmp.1414, %sfp
	call	fclose@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	-432(%rbp), %rbx	# %sfp, _91
	leaq	.LC130(%rip), %rdx	#, tmp772
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
	movq	%rbx, %rdi	# _91,
	call	__fprintf_chk@PLT	#
	leaq	.LC133(%rip), %rdx	#, tmp782
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:304:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1191
	vcvtusi2sdq	N_i_abs_pow(%rip), %xmm7, %xmm0	# N_i_abs_pow, tmp1191, tmp936
# C/parallel-only-omp/io_manager.h:304:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vcvtsi2sdl	no_of_cycles(%rip), %xmm7, %xmm1	# no_of_cycles, tmp1192, tmp937
# C/parallel-only-omp/io_manager.h:304:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC92(%rip), %xmm0, %xmm0	#, tmp773, tmp774
# C/parallel-only-omp/io_manager.h:304:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC132(%rip), %xmm1, %xmm1	#, tmp778, tmp779
# C/parallel-only-omp/io_manager.h:304:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	.LC131(%rip), %xmm0, %xmm0	#, tmp774, tmp776
# C/parallel-only-omp/io_manager.h:304:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp779, tmp776, tmp781
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
	leaq	.LC134(%rip), %rdx	#, tmp792
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:305:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1193
	vcvtusi2sdq	N_i_abs_gnd(%rip), %xmm7, %xmm0	# N_i_abs_gnd, tmp1193, tmp938
# C/parallel-only-omp/io_manager.h:305:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vcvtsi2sdl	no_of_cycles(%rip), %xmm7, %xmm1	# no_of_cycles, tmp1194, tmp939
# C/parallel-only-omp/io_manager.h:305:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC92(%rip), %xmm0, %xmm0	#, tmp783, tmp784
# C/parallel-only-omp/io_manager.h:305:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC132(%rip), %xmm1, %xmm1	#, tmp788, tmp789
# C/parallel-only-omp/io_manager.h:305:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	.LC131(%rip), %xmm0, %xmm0	#, tmp784, tmp786
# C/parallel-only-omp/io_manager.h:305:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp789, tmp786, tmp791
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
	leaq	.LC135(%rip), %rdx	#, tmp794
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	mean_i_energy_pow(%rip), %xmm0	# mean_i_energy_pow,
	call	__fprintf_chk@PLT	#
	leaq	.LC136(%rip), %rdx	#, tmp796
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	mean_i_energy_gnd(%rip), %xmm0	# mean_i_energy_gnd,
	call	__fprintf_chk@PLT	#
	leaq	.LC137(%rip), %rdx	#, tmp806
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:308:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1195
	vcvtusi2sdq	N_e_abs_pow(%rip), %xmm7, %xmm0	# N_e_abs_pow, tmp1195, tmp940
# C/parallel-only-omp/io_manager.h:308:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vcvtsi2sdl	no_of_cycles(%rip), %xmm7, %xmm1	# no_of_cycles, tmp1196, tmp941
# C/parallel-only-omp/io_manager.h:308:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC92(%rip), %xmm0, %xmm0	#, tmp797, tmp798
# C/parallel-only-omp/io_manager.h:308:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC132(%rip), %xmm1, %xmm1	#, tmp802, tmp803
# C/parallel-only-omp/io_manager.h:308:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	.LC131(%rip), %xmm0, %xmm0	#, tmp798, tmp800
# C/parallel-only-omp/io_manager.h:308:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp803, tmp800, tmp805
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
	leaq	.LC138(%rip), %rdx	#, tmp816
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:309:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1197
	vcvtusi2sdq	N_e_abs_gnd(%rip), %xmm7, %xmm0	# N_e_abs_gnd, tmp1197, tmp942
# C/parallel-only-omp/io_manager.h:309:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vcvtsi2sdl	no_of_cycles(%rip), %xmm7, %xmm1	# no_of_cycles, tmp1198, tmp943
# C/parallel-only-omp/io_manager.h:309:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC92(%rip), %xmm0, %xmm0	#, tmp807, tmp808
# C/parallel-only-omp/io_manager.h:309:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC132(%rip), %xmm1, %xmm1	#, tmp812, tmp813
# C/parallel-only-omp/io_manager.h:309:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	.LC131(%rip), %xmm0, %xmm0	#, tmp808, tmp810
# C/parallel-only-omp/io_manager.h:309:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp813, tmp810, tmp815
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
	leaq	.LC95(%rip), %rdx	#,
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	movq	-368(%rbp), %r8	# %sfp, ivtmp.1413
	movq	-240(%rbp), %r9	# %sfp, ivtmp.1414
	leaq	640000+powere_xt(%rip), %rcx	#, _404
# C/parallel-only-omp/io_manager.h:314:         power_i = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# power_i
# C/parallel-only-omp/io_manager.h:313:         power_e = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm1	#, power_e
	.p2align 4
	.p2align 3
.L294:
# C/parallel-only-omp/io_manager.h:164:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	xorl	%eax, %eax	# ivtmp.1402
	.p2align 4
	.p2align 3
.L295:
	leaq	(%r8,%rax), %rdx	#, _952
	vaddsd	(%rdx), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_952], 64, 0>, power_e, stmp_power_e_108.1298
	vaddsd	8(%rdx), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_952], 64, 64>, stmp_power_e_108.1298, stmp_power_e_108.1298
	vaddsd	16(%rdx), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_952], 64, 128>, stmp_power_e_108.1298, stmp_power_e_108.1298
	vaddsd	24(%rdx), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_952], 64, 192>, stmp_power_e_108.1298, stmp_power_e_108.1298
	vaddsd	32(%rdx), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_952], 64, 256>, stmp_power_e_108.1298, stmp_power_e_108.1298
	vaddsd	40(%rdx), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_952], 64, 320>, stmp_power_e_108.1298, stmp_power_e_108.1298
# C/parallel-only-omp/io_manager.h:317:                 power_e += powere_xt[i][j];
	vaddsd	48(%rdx), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_952], 64, 384>, stmp_power_e_108.1298, stmp_power_e_108.1298
	vaddsd	56(%rdx), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_952], 64, 448>, stmp_power_e_108.1298, power_e
	leaq	(%r9,%rax), %rdx	#, _865
	addq	$64, %rax	#, ivtmp.1402
	vaddsd	(%rdx), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_865], 64, 0>, power_i, stmp_power_i_109.1302
	vaddsd	8(%rdx), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_865], 64, 64>, stmp_power_i_109.1302, stmp_power_i_109.1302
	vaddsd	16(%rdx), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_865], 64, 128>, stmp_power_i_109.1302, stmp_power_i_109.1302
	vaddsd	24(%rdx), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_865], 64, 192>, stmp_power_i_109.1302, stmp_power_i_109.1302
	vaddsd	32(%rdx), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_865], 64, 256>, stmp_power_i_109.1302, stmp_power_i_109.1302
	vaddsd	40(%rdx), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_865], 64, 320>, stmp_power_i_109.1302, stmp_power_i_109.1302
# C/parallel-only-omp/io_manager.h:318:                 power_i += poweri_xt[i][j];
	vaddsd	48(%rdx), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_865], 64, 384>, stmp_power_i_109.1302, stmp_power_i_109.1302
	vaddsd	56(%rdx), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_865], 64, 448>, stmp_power_i_109.1302, power_i
	cmpq	$1600, %rax	#, ivtmp.1402
	jne	.L295	#,
# C/parallel-only-omp/io_manager.h:315:         for (i=0; i<N_G; i++){
	addq	$1600, %r8	#, ivtmp.1413
	addq	$1600, %r9	#, ivtmp.1414
	cmpq	%rcx, %r8	# _404, ivtmp.1413
	jne	.L294	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	-432(%rbp), %rbx	# %sfp, _91
	leaq	.LC140(%rip), %rdx	#, tmp822
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
# C/parallel-only-omp/io_manager.h:321:         power_e /= (double)(N_XT * N_G);
	vmovsd	.LC139(%rip), %xmm2	#, tmp820
# C/parallel-only-omp/io_manager.h:322:         power_i /= (double)(N_XT * N_G);
	vdivsd	%xmm2, %xmm0, %xmm4	# tmp820, power_i, power_i
# C/parallel-only-omp/io_manager.h:321:         power_e /= (double)(N_XT * N_G);
	vdivsd	%xmm2, %xmm1, %xmm7	# tmp820, power_e, power_e
# C/parallel-only-omp/io_manager.h:322:         power_i /= (double)(N_XT * N_G);
	vmovsd	%xmm4, -304(%rbp)	# power_i, %sfp
# C/parallel-only-omp/io_manager.h:321:         power_e /= (double)(N_XT * N_G);
	vmovsd	%xmm7, -240(%rbp)	# power_e, %sfp
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%rbx, %rdi	# _91,
	call	__fprintf_chk@PLT	#
	leaq	.LC141(%rip), %rdx	#, tmp823
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	-240(%rbp), %xmm0	# %sfp,
	call	__fprintf_chk@PLT	#
	leaq	.LC142(%rip), %rdx	#, tmp824
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	-304(%rbp), %xmm0	# %sfp,
	call	__fprintf_chk@PLT	#
	leaq	.LC143(%rip), %rdx	#, tmp826
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:326:         fprintf(f,"Total power density(average)          = %12.3e [W m^{-3}]\n", power_e + power_i);
	vmovsd	-304(%rbp), %xmm4	# %sfp, power_i
	vaddsd	-240(%rbp), %xmm4, %xmm0	# %sfp, power_i, tmp825
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
	xorl	%eax, %eax	#
	leaq	.LC95(%rip), %rdx	#,
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:328:         fclose(f);
	movq	-56(%rbp), %rax	# D.132814, tmp946
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp946
	jne	.L345	#,
	movq	-432(%rbp), %rdi	# %sfp,
# C/parallel-only-omp/io_manager.h:330: }
	addq	$584, %rsp	#,
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	.cfi_remember_state
	.cfi_def_cfa 13, 0
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	leaq	-16(%r13), %rsp	#,
	.cfi_def_cfa 7, 16
	popq	%r13	#
	.cfi_def_cfa_offset 8
# C/parallel-only-omp/io_manager.h:328:         fclose(f);
	jmp	fclose@PLT	#
.L342:
	.cfi_restore_state
	vmovsd	%xmm1, -624(%rbp)	# _273, %sfp
# C/parallel-only-omp/io_manager.h:103:         fprintf(f,"%e  %e\n", energy, eepf[i] / h / sqrt(energy));
	vmovsd	%xmm2, %xmm2, %xmm0	# energy,
	vmovsd	%xmm2, -560(%rbp)	# energy, %sfp
	call	sqrt@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	-624(%rbp), %xmm1	# %sfp, _273
	vmovsd	-560(%rbp), %xmm2	# %sfp, energy
	vdivsd	%xmm0, %xmm1, %xmm1	# tmp902, _273,
	jmp	.L347	#
.L345:
# C/parallel-only-omp/io_manager.h:328:         fclose(f);
	call	__stack_chk_fail@PLT	#
	.p2align 4
	.p2align 3
.L341:
	vmovapd	%zmm8, -496(%rbp)	# vect__291.1367, %sfp
	vmovsd	%xmm1, -240(%rbp)	# nu_max, %sfp
	vmovapd	%zmm9, -368(%rbp)	# vect__345.1344, %sfp
	vmovapd	%zmm7, -304(%rbp)	# vect__376.1333, %sfp
# C/parallel-only-omp/cross_sections.h:133:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vzeroupper
	call	sqrt@PLT	#
	vmovapd	-496(%rbp), %zmm8	# %sfp, vect__291.1367
	vmovapd	-368(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-304(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovsd	.LC1(%rip), %xmm3	#, tmp865
	vmovsd	.LC53(%rip), %xmm5	#, tmp855
	vmovsd	.LC50(%rip), %xmm2	#, tmp850
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp561
	vmovsd	-240(%rbp), %xmm1	# %sfp, nu_max
	jmp	.L238	#
.L340:
	vmovapd	%zmm8, -496(%rbp)	# vect__291.1367, %sfp
	vmovsd	%xmm1, -240(%rbp)	# nu_max, %sfp
	vmovapd	%zmm9, -368(%rbp)	# vect__345.1344, %sfp
	vmovapd	%zmm7, -304(%rbp)	# vect__376.1333, %sfp
# C/parallel-only-omp/cross_sections.h:113:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vzeroupper
	call	sqrt@PLT	#
	vmovapd	-496(%rbp), %zmm8	# %sfp, vect__291.1367
	vmovapd	-368(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-304(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovsd	.LC1(%rip), %xmm3	#, tmp865
	vmovsd	.LC51(%rip), %xmm4	#, tmp851
	vmovsd	.LC50(%rip), %xmm2	#, tmp850
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp549
	vmovsd	-240(%rbp), %xmm1	# %sfp, nu_max
	jmp	.L232	#
.L339:
	vmovapd	%zmm8, -496(%rbp)	# vect__291.1367, %sfp
	vmovapd	%zmm9, -432(%rbp)	# vect__345.1344, %sfp
	vmovapd	%zmm7, -368(%rbp)	# vect__376.1333, %sfp
# C/parallel-only-omp/io_manager.h:241:     debye_length = sqrt(EPSILON0 * kT / density) / E_CHARGE;                         // Promień Debye'a elektronów w centrum
	vzeroupper
	call	sqrt@PLT	#
	vmovapd	-496(%rbp), %zmm8	# %sfp, vect__291.1367
	vmovapd	-432(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-368(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovsd	.LC50(%rip), %xmm2	#, tmp850
	jmp	.L228	#
.L338:
	vmovapd	%zmm8, -496(%rbp)	# vect__291.1367, %sfp
	vmovsd	%xmm1, -304(%rbp)	# _3, %sfp
	vmovapd	%zmm9, -432(%rbp)	# vect__345.1344, %sfp
	vmovapd	%zmm7, -368(%rbp)	# vect__376.1333, %sfp
# C/parallel-only-omp/io_manager.h:235:     plas_freq  = E_CHARGE * sqrt(density / EPSILON0 / E_MASS);                       // Częstość plazmowa elektronów w środku szczeliny
	vzeroupper
	call	sqrt@PLT	#
	vmovapd	-496(%rbp), %zmm8	# %sfp, vect__291.1367
	vmovapd	-432(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-368(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovsd	-304(%rbp), %xmm1	# %sfp, _3
	jmp	.L225	#
	.cfi_endproc
.LFE9928:
	.size	_Z19check_and_save_infov, .-_Z19check_and_save_infov
	.section	.rodata._ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm.str1.1,"aMS",@progbits,1
.LC144:
	.string	"vector::_M_default_append"
	