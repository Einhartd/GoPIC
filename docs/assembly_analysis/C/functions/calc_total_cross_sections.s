# Function: calc_total_cross_sections()
# Mangled Symbol: _Z25calc_total_cross_sectionsv
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._Z25calc_total_cross_sectionsv,"axG",@progbits,_Z25calc_total_cross_sectionsv,comdat
	.p2align 4
	.weak	_Z25calc_total_cross_sectionsv
	.type	_Z25calc_total_cross_sectionsv, @function
_Z25calc_total_cross_sectionsv:
.LFB9862:
	.cfi_startproc
	endbr64	
	vbroadcastsd	.LC47(%rip), %zmm1	#, tmp113
	leaq	sigma(%rip), %rsi	#, tmp100
	leaq	sigma_tot_e(%rip), %rcx	#, ivtmp.967
	leaq	sigma_tot_i(%rip), %rdx	#, ivtmp.976
	leaq	24000000(%rsi), %rax	#, ivtmp.965
	addq	$32000000, %rsi	#, _42
	.p2align 4
	.p2align 3
.L104:
# C/parallel-only-omp/cross_sections.h:76:         sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY;
	vmovapd	-16000000(%rax), %zmm2	# MEM <vector(8) double> [(double *)_9 + -16000000B], tmp115
	vaddpd	-24000000(%rax), %zmm2, %zmm0	# MEM <vector(8) double> [(double *)_9 + -24000000B], tmp115, vect__3.942
	addq	$64, %rax	#, ivtmp.965
	addq	$64, %rcx	#, ivtmp.967
	addq	$64, %rdx	#, ivtmp.976
# C/parallel-only-omp/cross_sections.h:76:         sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY;
	vaddpd	-8000064(%rax), %zmm0, %zmm0	# MEM <vector(8) double> [(double *)_9 + -8000000B], vect__3.942, vect__5.946
# C/parallel-only-omp/cross_sections.h:76:         sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY;
	vmulpd	%zmm1, %zmm0, %zmm0	# tmp113, vect__5.946, vect__6.947
# C/parallel-only-omp/cross_sections.h:76:         sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY;
	vmovapd	%zmm0, -64(%rcx)	# vect__6.947, MEM <vector(8) double> [(double *)_30]
# C/parallel-only-omp/cross_sections.h:78:         sigma_tot_i[i] = (sigma[I_ISO][i] + sigma[I_BACK][i]) * GAS_DENSITY;
	vmovapd	-64(%rax), %zmm3	# MEM <vector(8) double> [(double *)_9], tmp116
	vaddpd	7999936(%rax), %zmm3, %zmm0	# MEM <vector(8) double> [(double *)_9 + 8000000B], tmp116, vect__9.956
# C/parallel-only-omp/cross_sections.h:78:         sigma_tot_i[i] = (sigma[I_ISO][i] + sigma[I_BACK][i]) * GAS_DENSITY;
	vmulpd	%zmm1, %zmm0, %zmm0	# tmp113, vect__9.956, vect__10.957
# C/parallel-only-omp/cross_sections.h:78:         sigma_tot_i[i] = (sigma[I_ISO][i] + sigma[I_BACK][i]) * GAS_DENSITY;
	vmovapd	%zmm0, -64(%rdx)	# vect__10.957, MEM <vector(8) double> [(double *)_25]
	cmpq	%rsi, %rax	# _42, ivtmp.965
	jne	.L104	#,
	vzeroupper
# C/parallel-only-omp/cross_sections.h:80: }
	ret	
	.cfi_endproc
.LFE9862:
	.size	_Z25calc_total_cross_sectionsv, .-_Z25calc_total_cross_sectionsv
	.section	.rodata._Z29compute_null_collision_paramsv.str1.8,"aMS",@progbits,1
	.align 8
.LC55:
	.string	">> eduPIC: null-collision: nu*_e = %e, P*_e = %e\n"
	.align 8
.LC56:
	.string	">> eduPIC: null-collision: nu*_i = %e, P*_i = %e\n"
	