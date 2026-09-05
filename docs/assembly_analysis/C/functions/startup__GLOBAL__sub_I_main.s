# Function: startup._GLOBAL__sub_I_main
# Mangled Symbol: startup._GLOBAL__sub_I_main
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text.startup._GLOBAL__sub_I_main,"ax",@progbits
	.p2align 4
	.type	_GLOBAL__sub_I_main, @function
_GLOBAL__sub_I_main:
.LFB11229:
	.cfi_startproc
	endbr64	
# C/parallel-only-omp/state.h:257: inline WorkerBuffers worker_buffers;
	cmpb	$0, _ZGV14worker_buffers(%rip)	#, MEM[(char *)&_ZGV14worker_buffers]
	je	.L1503	#,
# C/parallel-only-omp/eduPIC.cc:97: }
	ret	
.L1503:
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	vpxor	%xmm0, %xmm0, %xmm0	# tmp86
# C/parallel-only-omp/state.h:257: inline WorkerBuffers worker_buffers;
	leaq	__dso_handle(%rip), %rdx	#, tmp97
	leaq	worker_buffers(%rip), %rsi	#, tmp85
	leaq	_ZN13WorkerBuffersD1Ev(%rip), %rdi	#, tmp99
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	vmovdqu64	%zmm0, worker_buffers(%rip)	# tmp86, MEM <vector(8) long unsigned int> [(void *)&worker_buffers]
# C/parallel-only-omp/state.h:257: inline WorkerBuffers worker_buffers;
	movb	$1, _ZGV14worker_buffers(%rip)	#, MEM[(char *)&_ZGV14worker_buffers]
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	vmovdqu64	%zmm0, 64+worker_buffers(%rip)	# tmp86, MEM <vector(8) long unsigned int> [(void *)&worker_buffers + 64B]
	vmovdqu64	%zmm0, 128+worker_buffers(%rip)	# tmp86, MEM <vector(8) long unsigned int> [(void *)&worker_buffers + 128B]
	vmovdqu64	%zmm0, 192+worker_buffers(%rip)	# tmp86, MEM <vector(8) long unsigned int> [(void *)&worker_buffers + 192B]
	vmovdqu64	%zmm0, 256+worker_buffers(%rip)	# tmp86, MEM <vector(8) long unsigned int> [(void *)&worker_buffers + 256B]
	vmovdqu64	%zmm0, 320+worker_buffers(%rip)	# tmp86, MEM <vector(8) long unsigned int> [(void *)&worker_buffers + 320B]
# C/parallel-only-omp/state.h:257: inline WorkerBuffers worker_buffers;
	vzeroupper
	jmp	__cxa_atexit@PLT	#
	.cfi_endproc
.LFE11229:
	.size	_GLOBAL__sub_I_main, .-_GLOBAL__sub_I_main
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I_main
	.weak	_ZGV3RMB
	.section	.tbss._ZGV3RMB,"awTG",@nobits,_ZGV3RMB,comdat
	.align 8
	.type	_ZGV3RMB, @gnu_unique_object
	.size	_ZGV3RMB, 8
_ZGV3RMB:
	.zero	8
	.weak	_ZGV3R01
	.section	.tbss._ZGV3R01,"awTG",@nobits,_ZGV3R01,comdat
	.align 8
	.type	_ZGV3R01, @gnu_unique_object
	.size	_ZGV3R01, 8
_ZGV3R01:
	.zero	8
	.weak	_ZGV5MTgen
	.section	.tbss._ZGV5MTgen,"awTG",@nobits,_ZGV5MTgen,comdat
	.align 8
	.type	_ZGV5MTgen, @gnu_unique_object
	.size	_ZGV5MTgen, 8
_ZGV5MTgen:
	.zero	8
	.weak	_ZGV2rd
	.section	.tbss._ZGV2rd,"awTG",@nobits,_ZGV2rd,comdat
	.align 8
	.type	_ZGV2rd, @gnu_unique_object
	.size	_ZGV2rd, 8
_ZGV2rd:
	.zero	8
	.section	.tbss,"awT",@nobits
	.type	__tls_guard, @object
	.size	__tls_guard, 1
__tls_guard:
	.zero	1
	.weak	_ZGV14worker_buffers
	.section	.bss._ZGV14worker_buffers,"awG",@nobits,_ZGV14worker_buffers,comdat
	.align 8
	.type	_ZGV14worker_buffers, @gnu_unique_object
	.size	_ZGV14worker_buffers, 8
_ZGV14worker_buffers:
	.zero	8
	.weak	f_poisson
	.section	.bss.f_poisson,"awG",@nobits,f_poisson,comdat
	.align 64
	.type	f_poisson, @gnu_unique_object
	.size	f_poisson, 3328
f_poisson:
	.zero	3328
	.weak	g_poisson
	.section	.bss.g_poisson,"awG",@nobits,g_poisson,comdat
	.align 64
	.type	g_poisson, @gnu_unique_object
	.size	g_poisson, 3328
g_poisson:
	.zero	3328
	.weak	inv_denom_thomas
	.section	.bss.inv_denom_thomas,"awG",@nobits,inv_denom_thomas,comdat
	.align 64
	.type	inv_denom_thomas, @gnu_unique_object
	.size	inv_denom_thomas, 3328
inv_denom_thomas:
	.zero	3328
	.weak	w_thomas
	.section	.bss.w_thomas,"awG",@nobits,w_thomas,comdat
	.align 64
	.type	w_thomas, @gnu_unique_object
	.size	w_thomas, 3328
w_thomas:
	.zero	3328
	.weak	RMB
	.section	.tbss.RMB,"awTG",@nobits,RMB,comdat
	.align 8
	.type	RMB, @gnu_unique_object
	.size	RMB, 32
RMB:
	.zero	32
	.weak	R01
	.section	.tbss.R01,"awTG",@nobits,R01,comdat
	.align 8
	.type	R01, @gnu_unique_object
	.size	R01, 16
R01:
	.zero	16
	.weak	MTgen
	.section	.tbss.MTgen,"awTG",@nobits,MTgen,comdat
	.align 8
	.type	MTgen, @gnu_unique_object
	.size	MTgen, 5000
MTgen:
	.zero	5000
	.weak	rd
	.section	.tbss.rd,"awTG",@nobits,rd,comdat
	.align 8
	.type	rd, @gnu_unique_object
	.size	rd, 5000
rd:
	.zero	5000
	.weak	worker_buffers
	.section	.bss.worker_buffers,"awG",@nobits,worker_buffers,comdat
	.align 32
	.type	worker_buffers, @gnu_unique_object
	.size	worker_buffers, 384
worker_buffers:
	.zero	384
	.weak	P_star_i
	.section	.bss.P_star_i,"awG",@nobits,P_star_i,comdat
	.align 8
	.type	P_star_i, @gnu_unique_object
	.size	P_star_i, 8
P_star_i:
	.zero	8
	.weak	nu_star_i
	.section	.bss.nu_star_i,"awG",@nobits,nu_star_i,comdat
	.align 8
	.type	nu_star_i, @gnu_unique_object
	.size	nu_star_i, 8
nu_star_i:
	.zero	8
	.weak	P_star_e
	.section	.bss.P_star_e,"awG",@nobits,P_star_e,comdat
	.align 8
	.type	P_star_e, @gnu_unique_object
	.size	P_star_e, 8
P_star_e:
	.zero	8
	.weak	nu_star_e
	.section	.bss.nu_star_e,"awG",@nobits,nu_star_e,comdat
	.align 8
	.type	nu_star_e, @gnu_unique_object
	.size	nu_star_e, 8
nu_star_e:
	.zero	8
	.weak	measurement_mode
	.section	.bss.measurement_mode,"awG",@nobits,measurement_mode,comdat
	.type	measurement_mode, @gnu_unique_object
	.size	measurement_mode, 1
measurement_mode:
	.zero	1
	.weak	datafile
	.section	.bss.datafile,"awG",@nobits,datafile,comdat
	.align 8
	.type	datafile, @gnu_unique_object
	.size	datafile, 8
datafile:
	.zero	8
	.weak	st0
	.section	.bss.st0,"awG",@nobits,st0,comdat
	.align 32
	.type	st0, @gnu_unique_object
	.size	st0, 80
st0:
	.zero	80
	.weak	arg1
	.section	.bss.arg1,"awG",@nobits,arg1,comdat
	.align 4
	.type	arg1, @gnu_unique_object
	.size	arg1, 4
arg1:
	.zero	4
	.weak	cycles_done
	.section	.bss.cycles_done,"awG",@nobits,cycles_done,comdat
	.align 4
	.type	cycles_done, @gnu_unique_object
	.size	cycles_done, 4
cycles_done:
	.zero	4
	.weak	no_of_cycles
	.section	.bss.no_of_cycles,"awG",@nobits,no_of_cycles,comdat
	.align 4
	.type	no_of_cycles, @gnu_unique_object
	.size	no_of_cycles, 4
no_of_cycles:
	.zero	4
	.weak	cycle
	.section	.bss.cycle,"awG",@nobits,cycle,comdat
	.align 4
	.type	cycle, @gnu_unique_object
	.size	cycle, 4
cycle:
	.zero	4
	.weak	Time
	.section	.bss.Time,"awG",@nobits,Time,comdat
	.align 8
	.type	Time, @gnu_unique_object
	.size	Time, 8
Time:
	.zero	8
	.weak	N_i_coll
	.section	.bss.N_i_coll,"awG",@nobits,N_i_coll,comdat
	.align 8
	.type	N_i_coll, @gnu_unique_object
	.size	N_i_coll, 8
N_i_coll:
	.zero	8
	.weak	N_e_coll
	.section	.bss.N_e_coll,"awG",@nobits,N_e_coll,comdat
	.align 8
	.type	N_e_coll, @gnu_unique_object
	.size	N_e_coll, 8
N_e_coll:
	.zero	8
	.weak	mean_energy_counter_center
	.section	.bss.mean_energy_counter_center,"awG",@nobits,mean_energy_counter_center,comdat
	.align 8
	.type	mean_energy_counter_center, @gnu_unique_object
	.size	mean_energy_counter_center, 8
mean_energy_counter_center:
	.zero	8
	.weak	mean_energy_accu_center
	.section	.bss.mean_energy_accu_center,"awG",@nobits,mean_energy_accu_center,comdat
	.align 8
	.type	mean_energy_accu_center, @gnu_unique_object
	.size	mean_energy_accu_center, 8
mean_energy_accu_center:
	.zero	8
	.weak	ioniz_rate_xt
	.section	.bss.ioniz_rate_xt,"awG",@nobits,ioniz_rate_xt,comdat
	.align 32
	.type	ioniz_rate_xt, @gnu_unique_object
	.size	ioniz_rate_xt, 640000
ioniz_rate_xt:
	.zero	640000
	.weak	counter_i_xt
	.section	.bss.counter_i_xt,"awG",@nobits,counter_i_xt,comdat
	.align 32
	.type	counter_i_xt, @gnu_unique_object
	.size	counter_i_xt, 640000
counter_i_xt:
	.zero	640000
	.weak	counter_e_xt
	.section	.bss.counter_e_xt,"awG",@nobits,counter_e_xt,comdat
	.align 32
	.type	counter_e_xt, @gnu_unique_object
	.size	counter_e_xt, 640000
counter_e_xt:
	.zero	640000
	.weak	meanei_xt
	.section	.bss.meanei_xt,"awG",@nobits,meanei_xt,comdat
	.align 32
	.type	meanei_xt, @gnu_unique_object
	.size	meanei_xt, 640000
meanei_xt:
	.zero	640000
	.weak	meanee_xt
	.section	.bss.meanee_xt,"awG",@nobits,meanee_xt,comdat
	.align 32
	.type	meanee_xt, @gnu_unique_object
	.size	meanee_xt, 640000
meanee_xt:
	.zero	640000
	.weak	poweri_xt
	.section	.bss.poweri_xt,"awG",@nobits,poweri_xt,comdat
	.align 32
	.type	poweri_xt, @gnu_unique_object
	.size	poweri_xt, 640000
poweri_xt:
	.zero	640000
	.weak	powere_xt
	.section	.bss.powere_xt,"awG",@nobits,powere_xt,comdat
	.align 32
	.type	powere_xt, @gnu_unique_object
	.size	powere_xt, 640000
powere_xt:
	.zero	640000
	.weak	ji_xt
	.section	.bss.ji_xt,"awG",@nobits,ji_xt,comdat
	.align 32
	.type	ji_xt, @gnu_unique_object
	.size	ji_xt, 640000
ji_xt:
	.zero	640000
	.weak	je_xt
	.section	.bss.je_xt,"awG",@nobits,je_xt,comdat
	.align 32
	.type	je_xt, @gnu_unique_object
	.size	je_xt, 640000
je_xt:
	.zero	640000
	.weak	ui_xt
	.section	.bss.ui_xt,"awG",@nobits,ui_xt,comdat
	.align 32
	.type	ui_xt, @gnu_unique_object
	.size	ui_xt, 640000
ui_xt:
	.zero	640000
	.weak	ue_xt
	.section	.bss.ue_xt,"awG",@nobits,ue_xt,comdat
	.align 32
	.type	ue_xt, @gnu_unique_object
	.size	ue_xt, 640000
ue_xt:
	.zero	640000
	.weak	ni_xt
	.section	.bss.ni_xt,"awG",@nobits,ni_xt,comdat
	.align 32
	.type	ni_xt, @gnu_unique_object
	.size	ni_xt, 640000
ni_xt:
	.zero	640000
	.weak	ne_xt
	.section	.bss.ne_xt,"awG",@nobits,ne_xt,comdat
	.align 32
	.type	ne_xt, @gnu_unique_object
	.size	ne_xt, 640000
ne_xt:
	.zero	640000
	.weak	efield_xt
	.section	.bss.efield_xt,"awG",@nobits,efield_xt,comdat
	.align 32
	.type	efield_xt, @gnu_unique_object
	.size	efield_xt, 640000
efield_xt:
	.zero	640000
	.weak	pot_xt
	.section	.bss.pot_xt,"awG",@nobits,pot_xt,comdat
	.align 32
	.type	pot_xt, @gnu_unique_object
	.size	pot_xt, 640000
pot_xt:
	.zero	640000
	.weak	mean_i_energy_gnd
	.section	.bss.mean_i_energy_gnd,"awG",@nobits,mean_i_energy_gnd,comdat
	.align 8
	.type	mean_i_energy_gnd, @gnu_unique_object
	.size	mean_i_energy_gnd, 8
mean_i_energy_gnd:
	.zero	8
	.weak	mean_i_energy_pow
	.section	.bss.mean_i_energy_pow,"awG",@nobits,mean_i_energy_pow,comdat
	.align 8
	.type	mean_i_energy_pow, @gnu_unique_object
	.size	mean_i_energy_pow, 8
mean_i_energy_pow:
	.zero	8
	.weak	ifed_gnd
	.section	.bss.ifed_gnd,"awG",@nobits,ifed_gnd,comdat
	.align 32
	.type	ifed_gnd, @gnu_unique_object
	.size	ifed_gnd, 800
ifed_gnd:
	.zero	800
	.weak	ifed_pow
	.section	.bss.ifed_pow,"awG",@nobits,ifed_pow,comdat
	.align 32
	.type	ifed_pow, @gnu_unique_object
	.size	ifed_pow, 800
ifed_pow:
	.zero	800
	.weak	eepf
	.section	.bss.eepf,"awG",@nobits,eepf,comdat
	.align 32
	.type	eepf, @gnu_unique_object
	.size	eepf, 16000
eepf:
	.zero	16000
	.weak	N_i_abs_gnd
	.section	.bss.N_i_abs_gnd,"awG",@nobits,N_i_abs_gnd,comdat
	.align 8
	.type	N_i_abs_gnd, @gnu_unique_object
	.size	N_i_abs_gnd, 8
N_i_abs_gnd:
	.zero	8
	.weak	N_i_abs_pow
	.section	.bss.N_i_abs_pow,"awG",@nobits,N_i_abs_pow,comdat
	.align 8
	.type	N_i_abs_pow, @gnu_unique_object
	.size	N_i_abs_pow, 8
N_i_abs_pow:
	.zero	8
	.weak	N_e_abs_gnd
	.section	.bss.N_e_abs_gnd,"awG",@nobits,N_e_abs_gnd,comdat
	.align 8
	.type	N_e_abs_gnd, @gnu_unique_object
	.size	N_e_abs_gnd, 8
N_e_abs_gnd:
	.zero	8
	.weak	N_e_abs_pow
	.section	.bss.N_e_abs_pow,"awG",@nobits,N_e_abs_pow,comdat
	.align 8
	.type	N_e_abs_pow, @gnu_unique_object
	.size	N_e_abs_pow, 8
N_e_abs_pow:
	.zero	8
	.weak	cumul_i_density
	.section	.bss.cumul_i_density,"awG",@nobits,cumul_i_density,comdat
	.align 64
	.type	cumul_i_density, @gnu_unique_object
	.size	cumul_i_density, 3328
cumul_i_density:
	.zero	3328
	.weak	cumul_e_density
	.section	.bss.cumul_e_density,"awG",@nobits,cumul_e_density,comdat
	.align 64
	.type	cumul_e_density, @gnu_unique_object
	.size	cumul_e_density, 3328
cumul_e_density:
	.zero	3328
	.weak	i_density
	.section	.bss.i_density,"awG",@nobits,i_density,comdat
	.align 64
	.type	i_density, @gnu_unique_object
	.size	i_density, 3328
i_density:
	.zero	3328
	.weak	e_density
	.section	.bss.e_density,"awG",@nobits,e_density,comdat
	.align 64
	.type	e_density, @gnu_unique_object
	.size	e_density, 3328
e_density:
	.zero	3328
	.weak	pot
	.section	.bss.pot,"awG",@nobits,pot,comdat
	.align 64
	.type	pot, @gnu_unique_object
	.size	pot, 3328
pot:
	.zero	3328
	.weak	efield
	.section	.bss.efield,"awG",@nobits,efield,comdat
	.align 64
	.type	efield, @gnu_unique_object
	.size	efield, 3328
efield:
	.zero	3328
	.weak	vz_i
	.section	.bss.vz_i,"awG",@nobits,vz_i,comdat
	.align 64
	.type	vz_i, @gnu_unique_object
	.size	vz_i, 8000000
vz_i:
	.zero	8000000
	.weak	vy_i
	.section	.bss.vy_i,"awG",@nobits,vy_i,comdat
	.align 64
	.type	vy_i, @gnu_unique_object
	.size	vy_i, 8000000
vy_i:
	.zero	8000000
	.weak	vx_i
	.section	.bss.vx_i,"awG",@nobits,vx_i,comdat
	.align 64
	.type	vx_i, @gnu_unique_object
	.size	vx_i, 8000000
vx_i:
	.zero	8000000
	.weak	x_i
	.section	.bss.x_i,"awG",@nobits,x_i,comdat
	.align 64
	.type	x_i, @gnu_unique_object
	.size	x_i, 8000000
x_i:
	.zero	8000000
	.weak	vz_e
	.section	.bss.vz_e,"awG",@nobits,vz_e,comdat
	.align 64
	.type	vz_e, @gnu_unique_object
	.size	vz_e, 8000000
vz_e:
	.zero	8000000
	.weak	vy_e
	.section	.bss.vy_e,"awG",@nobits,vy_e,comdat
	.align 64
	.type	vy_e, @gnu_unique_object
	.size	vy_e, 8000000
vy_e:
	.zero	8000000
	.weak	vx_e
	.section	.bss.vx_e,"awG",@nobits,vx_e,comdat
	.align 64
	.type	vx_e, @gnu_unique_object
	.size	vx_e, 8000000
vx_e:
	.zero	8000000
	.weak	x_e
	.section	.bss.x_e,"awG",@nobits,x_e,comdat
	.align 64
	.type	x_e, @gnu_unique_object
	.size	x_e, 8000000
x_e:
	.zero	8000000
	.weak	N_i
	.section	.bss.N_i,"awG",@nobits,N_i,comdat
	.align 4
	.type	N_i, @gnu_unique_object
	.size	N_i, 4
N_i:
	.zero	4
	.weak	N_e
	.section	.bss.N_e,"awG",@nobits,N_e,comdat
	.align 4
	.type	N_e, @gnu_unique_object
	.size	N_e, 4
N_e:
	.zero	4
	.weak	sigma_tot_i
	.section	.bss.sigma_tot_i,"awG",@nobits,sigma_tot_i,comdat
	.align 64
	.type	sigma_tot_i, @gnu_unique_object
	.size	sigma_tot_i, 8000000
sigma_tot_i:
	.zero	8000000
	.weak	sigma_tot_e
	.section	.bss.sigma_tot_e,"awG",@nobits,sigma_tot_e,comdat
	.align 64
	.type	sigma_tot_e, @gnu_unique_object
	.size	sigma_tot_e, 8000000
sigma_tot_e:
	.zero	8000000
	.weak	sigma
	.section	.bss.sigma,"awG",@nobits,sigma,comdat
	.align 64
	.type	sigma, @gnu_unique_object
	.size	sigma, 40000000
sigma:
	.zero	40000000
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	-1405695074
	.long	1072703736
	.align 8
.LC1:
	.long	-755914244
	.long	1062232653
	.align 8
.LC4:
	.long	1717986918
	.long	1074423398
	.align 8
.LC5:
	.long	0
	.long	1075314688
	.align 8
.LC6:
	.long	1717986918
	.long	1073112678
	.align 8
.LC7:
	.long	0
	.long	1076756480
	.align 8
.LC8:
	.long	858993459
	.long	1072902963
	.align 8
.LC9:
	.long	-1717986918
	.long	1072798105
	.align 8
.LC10:
	.long	0
	.long	1072693248
	.align 8
.LC11:
	.long	0
	.long	1074003968
	.align 8
.LC12:
	.long	0
	.long	1075183616
	.align 8
.LC13:
	.long	1717986918
	.long	1074816614
	.align 8
.LC14:
	.long	0
	.long	1078853632
	.align 8
.LC15:
	.long	0
	.long	1076101120
	.align 8
.LC16:
	.long	0
	.long	1074266112
	.align 8
.LC17:
	.long	0
	.long	1076363264
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC18:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC19:
	.long	-1717986918
	.long	1068079513
	.align 8
.LC20:
	.long	1202590843
	.long	1065646817
	.align 8
.LC21:
	.long	0
	.long	1076297728
	.align 8
.LC22:
	.long	1717986918
	.long	1074161254
	.align 8
.LC23:
	.long	0
	.long	1077346304
	.align 8
.LC24:
	.long	1717986918
	.long	1073636966
	.align 8
.LC25:
	.long	0
	.long	1079246848
	.align 8
.LC26:
	.long	-1340029796
	.long	1067542642
	.align 8
.LC27:
	.long	-549755814
	.long	1066896719
	.align 8
.LC28:
	.long	-1717986918
	.long	1076861337
	.align 8
.LC29:
	.long	210911779
	.long	1002937505
	.align 8
.LC30:
	.long	0
	.long	1079083008
	.section	.rodata.cst16
	.align 16
.LC31:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC32:
	.long	0
	.long	1075970048
	.align 8
.LC33:
	.long	-343597384
	.long	1068415057
	.align 8
.LC34:
	.long	0
	.long	1083068416
	.align 8
.LC35:
	.long	858993459
	.long	1071854387
	.align 8
.LC36:
	.long	-1717986918
	.long	1069128089
	.align 8
.LC37:
	.long	-755914244
	.long	1063281229
	.align 8
.LC39:
	.long	-1717986918
	.long	-1078355559
	.align 8
.LC40:
	.long	-343597384
	.long	1066317905
	.align 8
.LC41:
	.long	0
	.long	-1075838976
	.align 8
.LC42:
	.long	1337381548
	.long	1007518665
	.align 8
.LC43:
	.long	-70705663
	.long	1008083670
	.align 8
.LC44:
	.long	-1320458388
	.long	1010120376
	.align 8
.LC45:
	.long	0
	.long	1071644672
	.align 8
.LC47:
	.long	-192165988
	.long	1146883006
	.align 8
.LC50:
	.long	630504279
	.long	1007133914
	.align 8
.LC51:
	.long	-1008331679
	.long	967997916
	.align 8
.LC52:
	.long	1998452712
	.long	1035224431
	.align 8
.LC53:
	.long	-515044572
	.long	983861149
	.align 8
.LC54:
	.long	1424324066
	.long	1039750859
	.align 8
.LC57:
	.long	1998452712
	.long	-1112259217
	.align 8
.LC58:
	.long	1424324066
	.long	-1107732789
	.align 8
.LC59:
	.long	0
	.long	1087319040
	.align 8
.LC61:
	.long	-328822563
	.long	1074393336
	.align 8
.LC63:
	.long	-1008331679
	.long	966949340
	.align 8
.LC64:
	.long	1889785611
	.long	1065814589
	.align 8
.LC65:
	.long	-1030792150
	.long	1066150133
	.align 8
.LC67:
	.long	547230944
	.long	1062022858
	.align 8
.LC74:
	.long	0
	.long	1085227008
	.align 8
.LC75:
	.long	-251268040
	.long	1034123382
	.align 8
.LC76:
	.long	0
	.long	1097456920
	.align 8
.LC81:
	.long	-1717986918
	.long	1067030937
	.align 8
.LC87:
	.long	0
	.long	1081032704
	.align 8
.LC90:
	.long	0
	.long	1081466880
	.align 8
.LC92:
	.long	0
	.long	1089541888
	.align 8
.LC104:
	.long	-402585907
	.long	1058041040
	.align 8
.LC106:
	.long	-1717986918
	.long	1070176665
	.align 8
.LC112:
	.long	-1971075289
	.long	1077963452
	.align 8
.LC122:
	.long	0
	.long	1080623104
	.align 8
.LC123:
	.long	1424324067
	.long	1039750859
	.align 8
.LC124:
	.long	785383423
	.long	1118065246
	.set	.LC126,.LC31
	.align 8
.LC131:
	.long	-350469331
	.long	1058682594
	.align 8
.LC132:
	.long	-632077287
	.long	1047776206
	.align 8
.LC139:
	.long	0
	.long	1089701888
	.align 8
.LC148:
	.long	724393789
	.long	1049348355
	.section	.rodata
	.align 64
.LC149:
	.quad	0
	.quad	2
	.quad	4
	.quad	6
	.quad	8
	.quad	10
	.quad	12
	.quad	14
	.align 64
.LC150:
	.quad	1
	.quad	3
	.quad	5
	.quad	7
	.quad	9
	.quad	11
	.quad	13
	.quad	15
	.align 64
.LC151:
	.long	0
	.long	2
	.long	4
	.long	6
	.long	8
	.long	10
	.long	12
	.long	14
	.long	16
	.long	18
	.long	20
	.long	22
	.long	24
	.long	26
	.long	28
	.long	30
	.section	.rodata.cst8
	.align 8
.LC152:
	.long	0
	.long	-1074790400
	.align 8
.LC153:
	.long	0
	.long	1075838976
	.align 8
.LC154:
	.long	0
	.long	1077936128
	.align 8
.LC155:
	.long	379996434
	.long	1078972162
	.align 8
.LC156:
	.long	1413754136
	.long	1072243195
	.align 8
.LC157:
	.long	0
	.long	1074790400
	.align 8
.LC158:
	.long	536225542
	.long	1072958867
	.align 8
.LC167:
	.long	-2
	.long	1072693247
	.align 8
.LC168:
	.long	0
	.long	1106247680
	.align 8
.LC169:
	.long	0
	.long	1005584384
	.align 8
.LC170:
	.long	0
	.long	1073741824
	.align 8
.LC171:
	.long	0
	.long	-1073741824
	.align 8
.LC172:
	.long	-4
	.long	1072693247
	.align 8
.LC173:
	.long	-1
	.long	1072693247
	.align 8
.LC174:
	.long	0
	.long	1017118720
	.align 8
.LC175:
	.long	-2097152
	.long	1105199103
	.align 8
.LC176:
	.long	-2
	.long	1071644671
	.align 8
.LC177:
	.long	2066167802
	.long	1078091343
	.align 8
.LC178:
	.long	262559291
	.long	1081138792
	.align 8
.LC195:
	.long	-16936979
	.long	1055706213
	.align 8
.LC196:
	.long	1413754136
	.long	1075388923
	.align 8
.LC197:
	.long	-889002329
	.long	1010892412
	.align 8
.LC198:
	.long	-1413493651
	.long	1178318378
	.align 8
.LC199:
	.long	85752064
	.long	1011308849
	.align 8
.LC200:
	.long	-443332832
	.long	1133597403
	.align 8
.LC201:
	.long	865730819
	.long	1072693219
	.align 8
.LC202:
	.long	405425922
	.long	1058742861
	.align 8
.LC203:
	.long	-1760457317
	.long	1042836330
	.align 8
.LC205:
	.long	-485508795
	.long	1100238897
	.align 8
.LC207:
	.long	-751000001
	.long	-1131120195
	.align 8
.LC211:
	.long	0
	.long	1086270464
	.align 8
.LC214:
	.long	1235563633
	.long	1029960215
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.rel.local.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align 8
	.type	DW.ref.__gxx_personality_v0, @object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.hidden	__dso_handle
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
