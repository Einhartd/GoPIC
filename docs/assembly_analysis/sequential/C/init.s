# --- Symbol: _Z4initi ---
	.section	.text._Z4initi,"axG",@progbits,_Z4initi,comdat
	.p2align 4
	.weak	_Z4initi
	.type	_Z4initi, @function
_Z4initi:
.LFB3862:
	.cfi_startproc
	endbr64	
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movslq	%edi, %rax	# tmp118,
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp	#,
	.cfi_def_cfa_offset 80
# simulation.h:11: inline void init(int nseed){
	movl	%eax, 12(%rsp)	# nseed, %sfp
# simulation.h:14:     for (i=0; i<nseed; i++){
	testl	%eax, %eax	# nseed
	jle	.L666	#,
	salq	$3, %rax	#, _27
	xorl	%ebx, %ebx	# ivtmp.1668
	leaq	x_e(%rip), %r15	#, tmp109
	leaq	vx_e(%rip), %r14	#, tmp117
	leaq	vy_e(%rip), %r13	#, tmp110
	leaq	vz_e(%rip), %r12	#, tmp111
	leaq	x_i(%rip), %rbp	#, tmp113
	movq	%rax, (%rsp)	# _27, %sfp
	.p2align 4
	.p2align 3
.L667:
# simulation.h:15:         x_e[i]  = L * R01(MTgen);               // initial random position of the electron
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# simulation.h:16:         vx_e[i] = 0; vy_e[i] = 0; vz_e[i] = 0;  // initial velocity components of the electron
	movq	$0x000000000, (%r14,%rbx)	#, MEM[(double *)&vx_e + ivtmp.1668_4 * 1]
# simulation.h:15:         x_e[i]  = L * R01(MTgen);               // initial random position of the electron
	vmulsd	.LC82(%rip), %xmm0, %xmm0	#, tmp119, tmp92
# simulation.h:16:         vx_e[i] = 0; vy_e[i] = 0; vz_e[i] = 0;  // initial velocity components of the electron
	movq	$0x000000000, 0(%r13,%rbx)	#, MEM[(double *)&vy_e + ivtmp.1668_4 * 1]
# simulation.h:15:         x_e[i]  = L * R01(MTgen);               // initial random position of the electron
	vmovsd	%xmm0, (%r15,%rbx)	# tmp92, MEM[(double *)&x_e + ivtmp.1668_4 * 1]
# simulation.h:16:         vx_e[i] = 0; vy_e[i] = 0; vz_e[i] = 0;  // initial velocity components of the electron
	movq	$0x000000000, (%r12,%rbx)	#, MEM[(double *)&vz_e + ivtmp.1668_4 * 1]
# simulation.h:17:         x_i[i]  = L * R01(MTgen);               // initial random position of the ion
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# simulation.h:18:         vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // initial velocity components of the ion
	leaq	vx_i(%rip), %rax	#, tmp125
	movq	$0x000000000, (%rax,%rbx)	#, MEM[(double *)&vx_i + ivtmp.1668_4 * 1]
# simulation.h:18:         vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // initial velocity components of the ion
	leaq	vy_i(%rip), %rax	#, tmp126
# simulation.h:17:         x_i[i]  = L * R01(MTgen);               // initial random position of the ion
	vmulsd	.LC82(%rip), %xmm0, %xmm0	#, tmp120, tmp101
# simulation.h:17:         x_i[i]  = L * R01(MTgen);               // initial random position of the ion
	vmovsd	%xmm0, 0(%rbp,%rbx)	# tmp101, MEM[(double *)&x_i + ivtmp.1668_4 * 1]
# simulation.h:18:         vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // initial velocity components of the ion
	movq	$0x000000000, (%rax,%rbx)	#, MEM[(double *)&vy_i + ivtmp.1668_4 * 1]
# simulation.h:18:         vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // initial velocity components of the ion
	leaq	vz_i(%rip), %rax	#, tmp127
	movq	$0x000000000, (%rax,%rbx)	#, MEM[(double *)&vz_i + ivtmp.1668_4 * 1]
# simulation.h:14:     for (i=0; i<nseed; i++){
	movq	(%rsp), %rax	# %sfp, _27
	addq	$8, %rbx	#, ivtmp.1668
	cmpq	%rax, %rbx	# _27, ivtmp.1668
	jne	.L667	#,
.L666:
# simulation.h:20:     N_e = nseed;    // initial number of electrons
	movl	12(%rsp), %eax	# %sfp, nseed
	movl	%eax, N_e(%rip)	# nseed, N_e
# simulation.h:21:     N_i = nseed;    // initial number of ions
	movl	%eax, N_i(%rip)	# nseed, N_i
# simulation.h:22: }
	addq	$24, %rsp	#,
	.cfi_def_cfa_offset 56
	popq	%rbx	#
	.cfi_def_cfa_offset 48
	popq	%rbp	#
	.cfi_def_cfa_offset 40
	popq	%r12	#
	.cfi_def_cfa_offset 32
	popq	%r13	#
	.cfi_def_cfa_offset 24
	popq	%r14	#
	.cfi_def_cfa_offset 16
	popq	%r15	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE3862:
	.size	_Z4initi, .-_Z4initi


