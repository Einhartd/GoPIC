# --- Symbol: _Z30step1_compute_electron_densityv ---
	.section	.text._Z30step1_compute_electron_densityv,"axG",@progbits,_Z30step1_compute_electron_densityv,comdat
	.p2align 4
	.weak	_Z30step1_compute_electron_densityv
	.type	_Z30step1_compute_electron_densityv, @function
_Z30step1_compute_electron_densityv:
.LFB3863:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
# simulation.h:30:     for(p=0; p<N_G; p++) e_density[p] = 0;
	movl	$3200, %edx	#,
	leaq	e_density(%rip), %rdi	#, ivtmp.859
	xorl	%esi, %esi	#
# simulation.h:24: inline void step1_compute_electron_density(void){
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	andq	$-64, %rsp	#,
# simulation.h:30:     for(p=0; p<N_G; p++) e_density[p] = 0;
	call	memset@PLT	#
# simulation.h:33:     for(k=0; k<N_e; k++){
	movslq	N_e(%rip), %rdx	# N_e,
	testl	%edx, %edx	# N_e.47_43
	jle	.L173	#,
	movq	%rax, %rdi	#, ivtmp.859
	leaq	x_e(%rip), %rax	#, ivtmp.866
	vxorps	%xmm3, %xmm3, %xmm3	# tmp147
	vmovsd	.LC67(%rip), %xmm5	#, tmp144
	leaq	(%rax,%rdx,8), %r8	#, _45
	vmovddup	.LC76(%rip), %xmm4	#, tmp146
	.p2align 4
	.p2align 3
.L174:
# simulation.h:34:         c0 = x_e[k] * INV_DX;
	vmulsd	(%rax), %xmm5, %xmm1	# MEM[(double *)_56], tmp144, c0
# simulation.h:35:         p  = int(c0);
	vcvttsd2sil	%xmm1, %edx	# c0, p
	movslq	%edx, %rcx	# p, p
# simulation.h:36:         e_density[p]   += (p + 1 - c0) * FACTOR_W;
	leal	1(%rdx), %esi	#, tmp125
	leaq	(%rdi,%rcx,8), %rcx	#, vectp.849
# simulation.h:33:     for(k=0; k<N_e; k++){
	addq	$8, %rax	#, ivtmp.866
# simulation.h:36:         e_density[p]   += (p + 1 - c0) * FACTOR_W;
	vcvtsi2sdl	%esi, %xmm3, %xmm0	# tmp125, tmp147, tmp148
# simulation.h:37:         e_density[p+1] += (c0 - p) * FACTOR_W;
	vcvtsi2sdl	%edx, %xmm3, %xmm2	# p, tmp147, tmp149
# simulation.h:36:         e_density[p]   += (p + 1 - c0) * FACTOR_W;
	vsubsd	%xmm1, %xmm0, %xmm0	# c0, tmp126, tmp127
# simulation.h:37:         e_density[p+1] += (c0 - p) * FACTOR_W;
	vsubsd	%xmm2, %xmm1, %xmm1	# tmp128, c0, tmp129
# simulation.h:36:         e_density[p]   += (p + 1 - c0) * FACTOR_W;
	vunpcklpd	%xmm1, %xmm0, %xmm0	# tmp129, tmp127, tmp124
	vfmadd213pd	(%rcx), %xmm4, %xmm0	# MEM <vector(2) double> [(double *)vectp.849_77], tmp146, vect__7.852
	vmovupd	%xmm0, (%rcx)	# vect__7.852, MEM <vector(2) double> [(double *)vectp.849_77]
# simulation.h:33:     for(k=0; k<N_e; k++){
	cmpq	%rax, %r8	# ivtmp.866, _45
	jne	.L174	#,
.L173:
	leaq	e_density(%rip), %rdx	#, ivtmp.859
	leaq	cumul_e_density(%rip), %rax	#, ivtmp.860
# simulation.h:40:     e_density[0]     *= 2.0;
	vmovsd	e_density(%rip), %xmm0	# e_density[0], e_density[0]
	vaddsd	%xmm0, %xmm0, %xmm0	# e_density[0], e_density[0], tmp136
	leaq	3200(%rdx), %rcx	#, _60
	vmovsd	%xmm0, e_density(%rip)	# tmp136, e_density[0]
# simulation.h:41:     e_density[N_G-1] *= 2.0;
	vmovsd	3192+e_density(%rip), %xmm0	# e_density[399], e_density[399]
	vaddsd	%xmm0, %xmm0, %xmm0	# e_density[399], e_density[399], tmp140
	vmovsd	%xmm0, 3192+e_density(%rip)	# tmp140, e_density[399]
	.p2align 4
	.p2align 3
.L175:
# simulation.h:43:     for(p=0; p<N_G; p++) cumul_e_density[p] += e_density[p];
	vmovupd	(%rdx), %zmm6	# MEM <vector(8) double> [(double *)_62], tmp151
	vaddpd	(%rax), %zmm6, %zmm0	# MEM <vector(8) double> [(double *)_64], tmp151, vect__20.844
	addq	$64, %rdx	#, ivtmp.859
	addq	$64, %rax	#, ivtmp.860
	vmovupd	%zmm0, -64(%rax)	# vect__20.844, MEM <vector(8) double> [(double *)_64]
	cmpq	%rcx, %rdx	# _60, ivtmp.859
	jne	.L175	#,
	vzeroupper
# simulation.h:44: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE3863:
	.size	_Z30step1_compute_electron_densityv, .-_Z30step1_compute_electron_densityv


# --- Symbol: _Z25step1_compute_ion_densityi ---
	.section	.text._Z25step1_compute_ion_densityi,"axG",@progbits,_Z25step1_compute_ion_densityi,comdat
	.p2align 4
	.weak	_Z25step1_compute_ion_densityi
	.type	_Z25step1_compute_ion_densityi, @function
_Z25step1_compute_ion_densityi:
.LFB3864:
	.cfi_startproc
	endbr64	
	imull	$-858993459, %edi, %eax	#, tmp163, tmp125
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	andq	$-64, %rsp	#,
# simulation.h:46: inline void step1_compute_ion_density(int t){    
	addl	$429496728, %eax	#, tmp126
	rorx	$2, %eax, %eax	#, tmp126, tmp127
# simulation.h:50:     if ((t % N_SUB) == 0) {                                            // ion density - computed in every N_SUB-th time steps (subcycling)
	cmpl	$214748364, %eax	#, tmp127
	ja	.L180	#,
# simulation.h:51:         for(p=0; p<N_G; p++) i_density[p] = 0;
	leaq	i_density(%rip), %rdi	#, ivtmp.895
	movl	$3200, %edx	#,
	xorl	%esi, %esi	#
	call	memset@PLT	#
# simulation.h:52:         for(k=0; k<N_i; k++){
	movslq	N_i(%rip), %rdx	# N_i,
# simulation.h:51:         for(p=0; p<N_G; p++) i_density[p] = 0;
	movq	%rax, %rdi	#, ivtmp.895
# simulation.h:52:         for(k=0; k<N_i; k++){
	testl	%edx, %edx	# N_i.48_47
	jle	.L181	#,
	leaq	x_i(%rip), %rax	#, ivtmp.902
	vxorps	%xmm3, %xmm3, %xmm3	# tmp164
	vmovsd	.LC67(%rip), %xmm5	#, tmp162
	vmovddup	.LC76(%rip), %xmm4	#, tmp161
	leaq	(%rax,%rdx,8), %r8	#, _54
	.p2align 4
	.p2align 3
.L182:
# simulation.h:53:             c0 = x_i[k] * INV_DX;
	vmulsd	(%rax), %xmm5, %xmm1	# MEM[(double *)_61], tmp162, c0
# simulation.h:54:             p  = int(c0);
	vcvttsd2sil	%xmm1, %edx	# c0, p
	movslq	%edx, %rcx	# p, p
# simulation.h:55:             i_density[p]   += (p + 1 - c0) * FACTOR_W;  
	leal	1(%rdx), %esi	#, tmp141
	leaq	(%rdi,%rcx,8), %rcx	#, vectp.885
# simulation.h:52:         for(k=0; k<N_i; k++){
	addq	$8, %rax	#, ivtmp.902
# simulation.h:55:             i_density[p]   += (p + 1 - c0) * FACTOR_W;  
	vcvtsi2sdl	%esi, %xmm3, %xmm0	# tmp141, tmp164, tmp165
# simulation.h:56:             i_density[p+1] += (c0 - p) * FACTOR_W;
	vcvtsi2sdl	%edx, %xmm3, %xmm2	# p, tmp164, tmp166
# simulation.h:55:             i_density[p]   += (p + 1 - c0) * FACTOR_W;  
	vsubsd	%xmm1, %xmm0, %xmm0	# c0, tmp142, tmp143
# simulation.h:56:             i_density[p+1] += (c0 - p) * FACTOR_W;
	vsubsd	%xmm2, %xmm1, %xmm1	# tmp144, c0, tmp145
# simulation.h:55:             i_density[p]   += (p + 1 - c0) * FACTOR_W;  
	vunpcklpd	%xmm1, %xmm0, %xmm0	# tmp145, tmp143, tmp140
	vfmadd213pd	(%rcx), %xmm4, %xmm0	# MEM <vector(2) double> [(double *)vectp.885_81], tmp161, vect__8.888
	vmovupd	%xmm0, (%rcx)	# vect__8.888, MEM <vector(2) double> [(double *)vectp.885_81]
# simulation.h:52:         for(k=0; k<N_i; k++){
	cmpq	%rax, %r8	# ivtmp.902, _54
	jne	.L182	#,
.L181:
# simulation.h:58:         i_density[0]     *= 2.0;
	vmovsd	i_density(%rip), %xmm0	# i_density[0], i_density[0]
	vaddsd	%xmm0, %xmm0, %xmm0	# i_density[0], i_density[0], tmp152
	vmovsd	%xmm0, i_density(%rip)	# tmp152, i_density[0]
# simulation.h:59:         i_density[N_G-1] *= 2.0;
	vmovsd	3192+i_density(%rip), %xmm0	# i_density[399], i_density[399]
	vaddsd	%xmm0, %xmm0, %xmm0	# i_density[399], i_density[399], tmp156
	vmovsd	%xmm0, 3192+i_density(%rip)	# tmp156, i_density[399]
.L180:
	leaq	i_density(%rip), %rdx	#, ivtmp.895
	leaq	cumul_i_density(%rip), %rax	#, ivtmp.896
	leaq	3200(%rdx), %rcx	#, _65
	.p2align 4
	.p2align 3
.L183:
# simulation.h:61:     for(p=0; p<N_G; p++) cumul_i_density[p] += i_density[p];
	vmovupd	(%rdx), %zmm6	# MEM <vector(8) double> [(double *)_67], tmp168
	vaddpd	(%rax), %zmm6, %zmm0	# MEM <vector(8) double> [(double *)_37], tmp168, vect__22.880
	addq	$64, %rdx	#, ivtmp.895
	addq	$64, %rax	#, ivtmp.896
	vmovupd	%zmm0, -64(%rax)	# vect__22.880, MEM <vector(8) double> [(double *)_37]
	cmpq	%rcx, %rdx	# _65, ivtmp.895
	jne	.L183	#,
	vzeroupper
# simulation.h:62: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE3864:
	.size	_Z25step1_compute_ion_densityi, .-_Z25step1_compute_ion_densityi


