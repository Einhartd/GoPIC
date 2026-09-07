# --- Symbol: _Z32step5_check_boundaries_electronsv ---
	.section	.text._Z32step5_check_boundaries_electronsv,"axG",@progbits,_Z32step5_check_boundaries_electronsv,comdat
	.p2align 4
	.weak	_Z32step5_check_boundaries_electronsv
	.type	_Z32step5_check_boundaries_electronsv, @function
_Z32step5_check_boundaries_electronsv:
.LFB3868:
	.cfi_startproc
	endbr64	
# simulation.h:155:     while(k < N_e) {    // check boundaries for all electrons in every time step
	movl	N_e(%rip), %ecx	# N_e, N_e_lsm.953
	testl	%ecx, %ecx	# N_e_lsm.953
	jle	.L250	#,
# simulation.h:152: inline void step5_check_boundaries_electrons(){
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	N_e_abs_gnd(%rip), %r11	# N_e_abs_gnd, N_e_abs_gnd_lsm.951
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
# simulation.h:155:     while(k < N_e) {    // check boundaries for all electrons in every time step
	xorl	%edx, %edx	# N_e_lsm_flag.954
# simulation.h:152: inline void step5_check_boundaries_electrons(){
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
# simulation.h:155:     while(k < N_e) {    // check boundaries for all electrons in every time step
	xorl	%ebp, %ebp	# N_e_abs_gnd_lsm_flag.952
	movq	N_e_abs_pow(%rip), %rbx	# N_e_abs_pow, N_e_abs_pow_lsm.949
	xorl	%r12d, %r12d	# N_e_abs_pow_lsm_flag.950
# simulation.h:153:     int k = 0;
	xorl	%edi, %edi	# k
	leaq	x_e(%rip), %rsi	#, tmp115
# simulation.h:162:             vx_e[k] = vx_e[N_e-1];
	leaq	vx_e(%rip), %r10	#, tmp119
# simulation.h:157:         if (x_e[k] < 0) {N_e_abs_pow++; out = true;}    // the electron is out at the powered electrode
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp96
# simulation.h:163:             vy_e[k] = vy_e[N_e-1];
	leaq	vy_e(%rip), %r9	#, tmp120
# simulation.h:164:             vz_e[k] = vz_e[N_e-1];
	leaq	vz_e(%rip), %r8	#, tmp121
# simulation.h:158:         if (x_e[k] > L) {N_e_abs_gnd++; out = true;}    // the electron is out at the grounded electrode
	vmovsd	.LC82(%rip), %xmm2	#, tmp123
	jmp	.L230	#
	.p2align 4
	.p2align 3
.L246:
	vcomisd	%xmm2, %xmm0	# tmp123, _71
	jbe	.L247	#,
# simulation.h:158:         if (x_e[k] > L) {N_e_abs_gnd++; out = true;}    // the electron is out at the grounded electrode
	incq	%r11	# N_e_abs_gnd_lsm.951
	movl	$1, %ebp	#, N_e_abs_gnd_lsm_flag.952
.L226:
# simulation.h:161:             x_e [k] = x_e [N_e-1];
	decl	%ecx	# N_e_lsm.953
# simulation.h:161:             x_e [k] = x_e [N_e-1];
	movslq	%ecx, %rdx	# N_e_lsm.953, N_e_lsm.953
	vmovsd	(%rsi,%rdx,8), %xmm0	# x_e[_76], _77
# simulation.h:161:             x_e [k] = x_e [N_e-1];
	vmovsd	%xmm0, (%rsi,%rax,8)	# _77, x_e[k_65]
# simulation.h:162:             vx_e[k] = vx_e[N_e-1];
	vmovsd	(%r10,%rdx,8), %xmm0	# vx_e[_76], _79
# simulation.h:162:             vx_e[k] = vx_e[N_e-1];
	vmovsd	%xmm0, (%r10,%rax,8)	# _79, vx_e[k_65]
# simulation.h:163:             vy_e[k] = vy_e[N_e-1];
	vmovsd	(%r9,%rdx,8), %xmm0	# vy_e[_76], _81
# simulation.h:163:             vy_e[k] = vy_e[N_e-1];
	vmovsd	%xmm0, (%r9,%rax,8)	# _81, vy_e[k_65]
# simulation.h:164:             vz_e[k] = vz_e[N_e-1];
	vmovsd	(%r8,%rdx,8), %xmm0	# vz_e[_76], _83
# simulation.h:164:             vz_e[k] = vz_e[N_e-1];
	movl	$1, %edx	#, N_e_lsm_flag.954
	vmovsd	%xmm0, (%r8,%rax,8)	# _83, vz_e[k_65]
# simulation.h:155:     while(k < N_e) {    // check boundaries for all electrons in every time step
	cmpl	%ecx, %edi	# N_e_lsm.953, k
	jge	.L253	#,
.L230:
# simulation.h:157:         if (x_e[k] < 0) {N_e_abs_pow++; out = true;}    // the electron is out at the powered electrode
	movslq	%edi, %rax	# k, k
	vmovsd	(%rsi,%rax,8), %xmm0	# x_e[k_65], _71
# simulation.h:157:         if (x_e[k] < 0) {N_e_abs_pow++; out = true;}    // the electron is out at the powered electrode
	vcomisd	%xmm0, %xmm1	# _71, tmp96
	jbe	.L246	#,
# simulation.h:157:         if (x_e[k] < 0) {N_e_abs_pow++; out = true;}    // the electron is out at the powered electrode
	incq	%rbx	# N_e_abs_pow_lsm.949
	movl	$1, %r12d	#, N_e_abs_pow_lsm_flag.950
	jmp	.L226	#
	.p2align 4
	.p2align 3
.L247:
# simulation.h:166:         } else k++;
	incl	%edi	# k
# simulation.h:155:     while(k < N_e) {    // check boundaries for all electrons in every time step
	cmpl	%ecx, %edi	# N_e_lsm.953, k
	jl	.L230	#,
.L253:
	testb	%dl, %dl	# N_e_lsm_flag.954
	je	.L231	#,
	movl	%ecx, N_e(%rip)	# N_e_lsm.953, N_e
.L231:
	testb	%bpl, %bpl	# N_e_abs_gnd_lsm_flag.952
	je	.L232	#,
	movq	%r11, N_e_abs_gnd(%rip)	# N_e_abs_gnd_lsm.951, N_e_abs_gnd
.L232:
	testb	%r12b, %r12b	# N_e_abs_pow_lsm_flag.950
	je	.L248	#,
	movq	%rbx, N_e_abs_pow(%rip)	# N_e_abs_pow_lsm.949, N_e_abs_pow
.L248:
# simulation.h:168: }
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4
	.p2align 3
.L250:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret	
	.cfi_endproc
.LFE3868:
	.size	_Z32step5_check_boundaries_electronsv, .-_Z32step5_check_boundaries_electronsv


