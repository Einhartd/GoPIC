# Function: set_ion_cross_sections_ar()
# Mangled Symbol: _Z25set_ion_cross_sections_arv
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._Z25set_ion_cross_sections_arv,"axG",@progbits,_Z25set_ion_cross_sections_arv,comdat
	.p2align 4
	.weak	_Z25set_ion_cross_sections_arv
	.type	_Z25set_ion_cross_sections_arv, @function
_Z25set_ion_cross_sections_arv:
.LFB9861:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC38(%rip), %rsi	#, tmp104
	movl	$2, %edi	#,
# C/parallel-only-omp/cross_sections.h:50: inline void set_ion_cross_sections_ar(void){
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 64
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	xorl	%eax, %eax	#
	xorl	%ebx, %ebx	# ivtmp.923
	leaq	sigma(%rip), %rbp	#, tmp137
	call	__printf_chk@PLT	#
	.p2align 4
	.p2align 3
.L99:
	movq	.LC37(%rip), %rax	#, tmp154
	movq	%rax, 8(%rsp)	# tmp154, %sfp
# C/parallel-only-omp/cross_sections.h:56:         if (i == 0) {e_com = DE_CS;} else {e_com = DE_CS * i;}             // Energia jonu w układzie środka masy [eV]
	testq	%rbx, %rbx	# ivtmp.923
	je	.L98	#,
# C/parallel-only-omp/cross_sections.h:56:         if (i == 0) {e_com = DE_CS;} else {e_com = DE_CS * i;}             // Energia jonu w układzie środka masy [eV]
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp155
	vcvtsi2sdl	%ebx, %xmm6, %xmm0	# ivtmp.923, tmp155, tmp152
# C/parallel-only-omp/cross_sections.h:56:         if (i == 0) {e_com = DE_CS;} else {e_com = DE_CS * i;}             // Energia jonu w układzie środka masy [eV]
	vmulsd	.LC1(%rip), %xmm0, %xmm0	#, tmp105, e_com
# C/parallel-only-omp/cross_sections.h:57:         e_lab = 2.0 * e_com;                                               // Energia jonu w układzie laboratoryjnym [eV]
	vaddsd	%xmm0, %xmm0, %xmm7	# e_com, e_com, _17
	vmovsd	%xmm7, 8(%rsp)	# _17, %sfp
.L98:
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	.LC39(%rip), %xmm1	#,
	vmovsd	8(%rsp), %xmm0	# %sfp,
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	.LC40(%rip), %xmm4	#, tmp157
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	%xmm0, 16(%rsp)	# tmp148, %sfp
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	.LC35(%rip), %xmm1	#,
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vdivsd	8(%rsp), %xmm4, %xmm0	# %sfp, tmp157, tmp110
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vaddsd	.LC10(%rip), %xmm0, %xmm0	#, tmp110, tmp112
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmovsd	.LC41(%rip), %xmm1	#,
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	%xmm0, 24(%rsp)	# tmp149, %sfp
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmovsd	8(%rsp), %xmm0	# %sfp,
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:61:         sigma[I_ISO][i]  = qiso;             // Przekrój czynny na izotropową część rozpraszania sprężystego [m^2]
	leaq	0(,%rbx,8), %rax	#, tmp129
# C/parallel-only-omp/cross_sections.h:55:     for(i=0; i<CS_RANGES; i++){
	incq	%rbx	# ivtmp.923
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmovsd	8(%rsp), %xmm3	# %sfp, _17
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmulsd	.LC42(%rip), %xmm0, %xmm0	#, tmp150, tmp118
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vdivsd	.LC16(%rip), %xmm3, %xmm2	#, _17, tmp115
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmovsd	.LC10(%rip), %xmm5	#, tmp160
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vaddsd	.LC10(%rip), %xmm2, %xmm2	#, tmp115, _13
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vaddsd	%xmm3, %xmm5, %xmm1	# _17, tmp160, tmp120
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmovsd	.LC43(%rip), %xmm6	#, tmp162
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp120, tmp118, tmp122
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmulsd	%xmm2, %xmm2, %xmm2	# _13, _13, tmp125
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmulsd	%xmm3, %xmm6, %xmm1	# _17, tmp162, tmp123
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	.LC44(%rip), %xmm7	#, tmp164
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vdivsd	%xmm2, %xmm1, %xmm1	# tmp125, tmp123, tmp126
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vaddsd	%xmm1, %xmm0, %xmm0	# tmp126, tmp122, qiso
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmulsd	16(%rsp), %xmm7, %xmm1	# %sfp, tmp164, tmp127
# C/parallel-only-omp/cross_sections.h:61:         sigma[I_ISO][i]  = qiso;             // Przekrój czynny na izotropową część rozpraszania sprężystego [m^2]
	vmovsd	%xmm0, 24000000(%rbp,%rax)	# qiso, MEM[(double *)&sigma + 24000000B + ivtmp.923_22 * 8]
# C/parallel-only-omp/cross_sections.h:60:         qback = (qmom-qiso) / 2.0;
	vfmsub132sd	24(%rsp), %xmm0, %xmm1	# %sfp, qiso, _16
# C/parallel-only-omp/cross_sections.h:60:         qback = (qmom-qiso) / 2.0;
	vmulsd	.LC45(%rip), %xmm1, %xmm1	#, _16, qback
# C/parallel-only-omp/cross_sections.h:62:         sigma[I_BACK][i] = qback;            // Przekrój czynny na rozpraszanie wsteczne (wymianę ładunku) [m^2]
	vmovsd	%xmm1, 32000000(%rbp,%rax)	# qback, MEM[(double *)&sigma + 32000000B + ivtmp.923_22 * 8]
# C/parallel-only-omp/cross_sections.h:55:     for(i=0; i<CS_RANGES; i++){
	cmpq	$1000000, %rbx	#, ivtmp.923
	jne	.L99	#,
# C/parallel-only-omp/cross_sections.h:64: }
	addq	$40, %rsp	#,
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE9861:
	.size	_Z25set_ion_cross_sections_arv, .-_Z25set_ion_cross_sections_arv
	