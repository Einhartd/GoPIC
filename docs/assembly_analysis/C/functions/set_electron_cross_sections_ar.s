# Function: set_electron_cross_sections_ar()
# Mangled Symbol: _Z30set_electron_cross_sections_arv
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._Z30set_electron_cross_sections_arv,"axG",@progbits,_Z30set_electron_cross_sections_arv,comdat
	.p2align 4
	.weak	_Z30set_electron_cross_sections_arv
	.type	_Z30set_electron_cross_sections_arv, @function
_Z30set_electron_cross_sections_arv:
.LFB9860:
	.cfi_startproc
	endbr64	
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%rbp	#
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC3(%rip), %rsi	#, tmp151
# C/parallel-only-omp/cross_sections.h:16: inline void set_electron_cross_sections_ar(void){
	pushq	%rbx	#
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	leaq	sigma(%rip), %rbx	#, ivtmp.917
# C/parallel-only-omp/cross_sections.h:16: inline void set_electron_cross_sections_ar(void){
	subq	$72, %rsp	#,
	.cfi_def_cfa_offset 112
	xorl	%ebp, %ebp	# i
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	__printf_chk@PLT	#
# C/parallel-only-omp/cross_sections.h:22:         if (i == 0) {en = DE_CS;} else {en = DE_CS * i;}                            // Energia kinetyczna elektronu [eV]
	movq	.LC1(%rip), %rax	#, tmp284
	vmovsd	.LC0(%rip), %xmm0	#, _126
	movq	%rax, 8(%rsp)	# tmp284, %sfp
	jmp	.L89	#
	.p2align 4
	.p2align 3
.L85:
# C/parallel-only-omp/cross_sections.h:21:     for(i=0; i<CS_RANGES; i++){
	incl	%ebp	# i
# C/parallel-only-omp/cross_sections.h:35:         sigma[E_ELA][i] = qmel * 1.0e-20;       // Przekrój czynny na zderzenia sprężyste e- / Ar [m^2]
	vmulsd	.LC29(%rip), %xmm2, %xmm2	#, qmel, tmp230
# C/parallel-only-omp/cross_sections.h:36:         sigma[E_EXC][i] = qexc * 1.0e-20;       // Przekrój czynny na wzbudzenie e- / Ar [m^2]
	vmovsd	%xmm1, 8000000(%rbx)	# _129, MEM[(double *)_114 + 8000000B]
# C/parallel-only-omp/cross_sections.h:35:         sigma[E_ELA][i] = qmel * 1.0e-20;       // Przekrój czynny na zderzenia sprężyste e- / Ar [m^2]
	vmovsd	%xmm2, (%rbx)	# tmp230, MEM[(double *)_114]
# C/parallel-only-omp/cross_sections.h:37:         sigma[E_ION][i] = qion * 1.0e-20;       // Przekrój czynny na jonizację e- / Ar [m^2]
	vmovsd	%xmm0, 16000000(%rbx)	# _131, MEM[(double *)_114 + 16000000B]
# C/parallel-only-omp/cross_sections.h:21:     for(i=0; i<CS_RANGES; i++){
	addq	$8, %rbx	#, ivtmp.917
	cmpl	$1000000, %ebp	#, i
	je	.L95	#,
# C/parallel-only-omp/cross_sections.h:22:         if (i == 0) {en = DE_CS;} else {en = DE_CS * i;}                            // Energia kinetyczna elektronu [eV]
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp318
	vcvtsi2sdl	%ebp, %xmm4, %xmm0	# i, tmp318, tmp277
# C/parallel-only-omp/cross_sections.h:22:         if (i == 0) {en = DE_CS;} else {en = DE_CS * i;}                            // Energia kinetyczna elektronu [eV]
	vmulsd	.LC1(%rip), %xmm0, %xmm5	#, tmp232, en
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vdivsd	.LC35(%rip), %xmm5, %xmm0	#, en, _122
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vdivsd	.LC36(%rip), %xmm5, %xmm1	#, en, tmp235
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vaddsd	.LC10(%rip), %xmm1, %xmm1	#, tmp235, tmp237
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# _122, tmp237, _126
# C/parallel-only-omp/cross_sections.h:22:         if (i == 0) {en = DE_CS;} else {en = DE_CS * i;}                            // Energia kinetyczna elektronu [eV]
	vmovsd	%xmm5, 8(%rsp)	# en, %sfp
.L89:
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vmovsd	.LC4(%rip), %xmm1	#,
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vmovsd	.LC5(%rip), %xmm4	#, tmp286
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	.LC6(%rip), %xmm1	#,
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vdivsd	%xmm0, %xmm4, %xmm7	# tmp263, tmp286, _8
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	8(%rsp), %xmm0	# %sfp,
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vmovq	%xmm7, %r14	# _8, _8
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	call	pow@PLT	#
	vmovsd	%xmm0, 16(%rsp)	# tmp264, %sfp
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	8(%rsp), %xmm7	# %sfp, en
	vmovsd	.LC8(%rip), %xmm1	#,
	vdivsd	.LC7(%rip), %xmm7, %xmm4	#, en, _11
	vmovsd	%xmm4, 40(%rsp)	# _11, %sfp
	vmovsd	%xmm4, %xmm4, %xmm0	# _11,
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	.LC9(%rip), %xmm4	#, tmp289
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vaddsd	.LC10(%rip), %xmm0, %xmm0	#, tmp265, tmp159
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmulsd	16(%rsp), %xmm4, %xmm1	# %sfp, tmp289, tmp157
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	8(%rsp), %xmm7	# %sfp, en
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vdivsd	%xmm0, %xmm1, %xmm4	# tmp159, tmp157, _14
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vdivsd	.LC12(%rip), %xmm7, %xmm0	#, en, tmp162
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovq	%xmm4, %r15	# _14, _14
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	.LC11(%rip), %xmm1	#,
	call	pow@PLT	#
	vmovsd	%xmm0, 16(%rsp)	# tmp266, %sfp
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	8(%rsp), %xmm7	# %sfp, en
	vmovsd	.LC13(%rip), %xmm1	#,
	vdivsd	.LC14(%rip), %xmm7, %xmm0	#, en, tmp165
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	.LC10(%rip), %xmm7	#, tmp294
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp169
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	%xmm0, %xmm0, %xmm2	#, tmp267
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vaddsd	16(%rsp), %xmm7, %xmm0	# %sfp, tmp294, tmp167
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vaddsd	%xmm2, %xmm0, %xmm0	# tmp267, tmp167, _20
	vucomisd	%xmm0, %xmm1	# _20, tmp169
	ja	.L93	#,
	vsqrtsd	%xmm0, %xmm0, %xmm6	# _20, _21
	vmovsd	%xmm6, 16(%rsp)	# _21, %sfp
.L84:
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	8(%rsp), %xmm6	# %sfp, en
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	.LC16(%rip), %xmm1	#,
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vdivsd	.LC15(%rip), %xmm6, %xmm3	#, en, tmp170
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	%xmm6, %xmm6, %xmm0	# en,
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vaddsd	.LC10(%rip), %xmm3, %xmm3	#, tmp170, _26
	vmovsd	%xmm3, 32(%rsp)	# _26, %sfp
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	8(%rsp), %xmm6	# %sfp, en
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	%xmm0, 24(%rsp)	# tmp269, %sfp
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	.LC5(%rip), %xmm1	#,
	vdivsd	.LC17(%rip), %xmm6, %xmm0	#, en, tmp175
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovq	%r15, %xmm7	# _14, _14
	vdivsd	16(%rsp), %xmm7, %xmm2	# %sfp, _14, tmp177
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovq	%r14, %xmm7	# _8, _8
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	%xmm0, %xmm0, %xmm1	#, tmp270
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vsubsd	%xmm2, %xmm7, %xmm2	# tmp177, _8, tmp178
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vandpd	.LC18(%rip), %xmm2, %xmm2	#, tmp178, tmp179
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vaddsd	.LC10(%rip), %xmm1, %xmm1	#, tmp270, tmp187
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	32(%rsp), %xmm3	# %sfp, _26
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	.LC19(%rip), %xmm5	#, tmp302
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmulsd	%xmm3, %xmm3, %xmm3	# _26, _26, tmp181
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	.LC20(%rip), %xmm7	#, tmp303
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vdivsd	%xmm3, %xmm5, %xmm3	# tmp181, tmp302, tmp182
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmulsd	24(%rsp), %xmm7, %xmm0	# %sfp, tmp303, tmp185
# C/parallel-only-omp/cross_sections.h:26:         if (en > E_EXC_TH)
	vmovsd	8(%rsp), %xmm6	# %sfp, en
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp187, tmp185, tmp189
# C/parallel-only-omp/cross_sections.h:26:         if (en > E_EXC_TH)
	vcomisd	.LC21(%rip), %xmm6	#, en
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vaddsd	%xmm3, %xmm2, %xmm2	# tmp182, tmp179, tmp184
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vaddsd	%xmm0, %xmm2, %xmm2	# tmp189, tmp184, qmel
	vxorpd	%xmm0, %xmm0, %xmm0	# _131
	vmovsd	%xmm0, %xmm0, %xmm1	#, _129
# C/parallel-only-omp/cross_sections.h:26:         if (en > E_EXC_TH)
	jbe	.L85	#,
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vsubsd	.LC21(%rip), %xmm6, %xmm3	#, en, _36
	vmovsd	%xmm2, 56(%rsp)	# qmel, %sfp
	vmovsd	%xmm3, %xmm3, %xmm0	# _36,
	vmovsd	%xmm3, 48(%rsp)	# _36, %sfp
	vmovsd	.LC9(%rip), %xmm1	#,
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	.LC22(%rip), %xmm1	#,
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	%xmm0, 16(%rsp)	# tmp271, %sfp
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	40(%rsp), %xmm0	# %sfp,
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	8(%rsp), %xmm5	# %sfp, en
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	%xmm0, 24(%rsp)	# tmp272, %sfp
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	.LC12(%rip), %xmm1	#,
	vdivsd	.LC23(%rip), %xmm5, %xmm0	#, en, tmp195
	call	pow@PLT	#
	vmovsd	%xmm0, 32(%rsp)	# tmp273, %sfp
# C/parallel-only-omp/cross_sections.h:28:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vmovsd	8(%rsp), %xmm5	# %sfp, en
# C/parallel-only-omp/cross_sections.h:28:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vmovsd	.LC24(%rip), %xmm1	#,
# C/parallel-only-omp/cross_sections.h:28:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vdivsd	.LC25(%rip), %xmm5, %xmm0	#, en, tmp198
# C/parallel-only-omp/cross_sections.h:28:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vaddsd	.LC10(%rip), %xmm0, %xmm0	#, tmp198, tmp200
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	16(%rsp), %xmm2	# %sfp, _37
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	.LC10(%rip), %xmm6	#, tmp310
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmulsd	.LC26(%rip), %xmm2, %xmm1	#, _37, tmp202
# C/parallel-only-omp/cross_sections.h:28:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vmovsd	%xmm0, %xmm0, %xmm4	#, tmp274
# C/parallel-only-omp/cross_sections.h:28:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vmovsd	48(%rsp), %xmm3	# %sfp, _36
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vaddsd	24(%rsp), %xmm6, %xmm0	# %sfp, tmp310, tmp204
# C/parallel-only-omp/cross_sections.h:28:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vmulsd	.LC27(%rip), %xmm3, %xmm3	#, _36, tmp210
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmulsd	%xmm0, %xmm1, %xmm0	# tmp204, tmp202, tmp206
# C/parallel-only-omp/cross_sections.h:28:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vdivsd	%xmm4, %xmm3, %xmm3	# tmp274, tmp210, tmp212
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vaddsd	32(%rsp), %xmm6, %xmm1	# %sfp, tmp312, tmp207
# C/parallel-only-omp/cross_sections.h:31:         if (en > E_ION_TH)
	vmovsd	8(%rsp), %xmm5	# %sfp, en
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp207, tmp206, tmp209
# C/parallel-only-omp/cross_sections.h:31:         if (en > E_ION_TH)
	vmovsd	56(%rsp), %xmm2	# %sfp, qmel
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vaddsd	%xmm3, %xmm0, %xmm1	# tmp212, tmp209, qexc
# C/parallel-only-omp/cross_sections.h:31:         if (en > E_ION_TH)
	vmovsd	.LC28(%rip), %xmm0	#, tmp213
	vcomisd	%xmm0, %xmm5	# tmp213, en
	ja	.L87	#,
# C/parallel-only-omp/cross_sections.h:36:         sigma[E_EXC][i] = qexc * 1.0e-20;       // Przekrój czynny na wzbudzenie e- / Ar [m^2]
	vmulsd	.LC29(%rip), %xmm1, %xmm1	#, qexc, _129
	vxorpd	%xmm0, %xmm0, %xmm0	# _131
	jmp	.L85	#
	.p2align 4
	.p2align 3
.L87:
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vsubsd	%xmm0, %xmm5, %xmm4	# tmp213, en, _51
	vmovsd	%xmm5, %xmm5, %xmm3	# en, en
	vmovsd	%xmm1, 32(%rsp)	# qexc, %sfp
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vxorpd	.LC31(%rip), %xmm3, %xmm0	#, en, tmp217
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vaddsd	.LC30(%rip), %xmm5, %xmm5	#, en, _53
	vmovsd	%xmm2, 24(%rsp)	# qmel, %sfp
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmovsd	%xmm4, 16(%rsp)	# _51, %sfp
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmovsd	%xmm5, 8(%rsp)	# _53, %sfp
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vdivsd	.LC32(%rip), %xmm0, %xmm0	#, tmp217, tmp219
	call	exp@PLT	#
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmovsd	16(%rsp), %xmm4	# %sfp, _51
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmovsd	8(%rsp), %xmm5	# %sfp, _53
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmovsd	%xmm0, %xmm0, %xmm6	#, tmp275
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmulsd	%xmm4, %xmm4, %xmm3	# _51, _51, tmp221
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmulsd	.LC34(%rip), %xmm4, %xmm0	#, _51, tmp224
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmulsd	.LC33(%rip), %xmm3, %xmm3	#, tmp221, tmp222
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmulsd	%xmm5, %xmm5, %xmm5	# _53, _53, tmp226
# C/parallel-only-omp/cross_sections.h:36:         sigma[E_EXC][i] = qexc * 1.0e-20;       // Przekrój czynny na wzbudzenie e- / Ar [m^2]
	vmovsd	32(%rsp), %xmm1	# %sfp, qexc
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vdivsd	%xmm5, %xmm0, %xmm0	# tmp226, tmp224, tmp227
# C/parallel-only-omp/cross_sections.h:36:         sigma[E_EXC][i] = qexc * 1.0e-20;       // Przekrój czynny na wzbudzenie e- / Ar [m^2]
	vmulsd	.LC29(%rip), %xmm1, %xmm1	#, qexc, _129
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vfmadd231sd	%xmm6, %xmm3, %xmm0	# tmp275, tmp222, qion
	vmovsd	24(%rsp), %xmm2	# %sfp, qmel
# C/parallel-only-omp/cross_sections.h:37:         sigma[E_ION][i] = qion * 1.0e-20;       // Przekrój czynny na jonizację e- / Ar [m^2]
	vmulsd	.LC29(%rip), %xmm0, %xmm0	#, qion, _131
	jmp	.L85	#
.L95:
# C/parallel-only-omp/cross_sections.h:39: }
	addq	$72, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx	#
	.cfi_def_cfa_offset 32
	popq	%rbp	#
	.cfi_def_cfa_offset 24
	popq	%r14	#
	.cfi_def_cfa_offset 16
	popq	%r15	#
	.cfi_def_cfa_offset 8
	ret	
.L93:
	.cfi_restore_state
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	call	sqrt@PLT	#
	vmovsd	%xmm0, 16(%rsp)	# tmp268, %sfp
	jmp	.L84	#
	.cfi_endproc
.LFE9860:
	.size	_Z30set_electron_cross_sections_arv, .-_Z30set_electron_cross_sections_arv
	.section	.rodata._Z25set_ion_cross_sections_arv.str1.8,"aMS",@progbits,1
	.align 8
.LC38:
	.string	">> eduPIC: Setting Ar+ / Ar cross sections\n"
	