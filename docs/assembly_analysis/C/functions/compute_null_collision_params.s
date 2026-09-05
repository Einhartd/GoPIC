# Function: compute_null_collision_params()
# Mangled Symbol: _Z29compute_null_collision_paramsv
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._Z29compute_null_collision_paramsv,"axG",@progbits,_Z29compute_null_collision_paramsv,comdat
	.p2align 4
	.weak	_Z29compute_null_collision_paramsv
	.type	_Z29compute_null_collision_paramsv, @function
_Z29compute_null_collision_paramsv:
.LFB9870:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	sigma_tot_e(%rip), %rbp	#, tmp150
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	xorl	%ebx, %ebx	# ivtmp.996
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 64
# C/parallel-only-omp/cross_sections.h:110:     nu_max = 0;
	vxorpd	%xmm3, %xmm3, %xmm3	# nu_max
	vxorps	%xmm6, %xmm6, %xmm6	# tmp159
	vmovsd	.LC1(%rip), %xmm5	#, tmp153
	vmovsd	.LC50(%rip), %xmm4	#, tmp147
	vmovsd	.LC51(%rip), %xmm2	#, tmp148
	vmovsd	%xmm3, %xmm3, %xmm1	#, tmp121
	.p2align 4
	.p2align 3
.L111:
# C/parallel-only-omp/cross_sections.h:112:         e  = i * DE_CS;
	vcvtsi2sdl	%ebx, %xmm6, %xmm0	# ivtmp.996, tmp159, tmp160
# C/parallel-only-omp/cross_sections.h:112:         e  = i * DE_CS;
	vmulsd	%xmm5, %xmm0, %xmm0	# tmp153, tmp114, e
# C/parallel-only-omp/cross_sections.h:113:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vaddsd	%xmm0, %xmm0, %xmm0	# e, e, tmp117
# C/parallel-only-omp/cross_sections.h:113:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vmulsd	%xmm4, %xmm0, %xmm0	# tmp147, tmp117, tmp118
# C/parallel-only-omp/cross_sections.h:113:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vdivsd	%xmm2, %xmm0, %xmm0	# tmp148, tmp118, _42
	vucomisd	%xmm0, %xmm1	# _42, tmp121
	ja	.L123	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _42, v
.L109:
# C/parallel-only-omp/cross_sections.h:114:         nu = v * sigma_tot_e[i];
	vmulsd	0(%rbp,%rbx,8), %xmm0, %xmm0	# MEM[(double *)&sigma_tot_e + ivtmp.996_69 * 8], v, nu
# C/parallel-only-omp/cross_sections.h:111:     for(i=0; i<CS_RANGES; i++){
	incq	%rbx	# ivtmp.996
# C/parallel-only-omp/cross_sections.h:115:         if (nu > nu_max) {nu_max = nu;}
	vmaxsd	%xmm3, %xmm0, %xmm3	# nu_max, nu, nu_max
# C/parallel-only-omp/cross_sections.h:111:     for(i=0; i<CS_RANGES; i++){
	cmpq	$1000000, %rbx	#, ivtmp.996
	jne	.L111	#,
# C/parallel-only-omp/null_collision.h:19:     nu_star_e = max_electron_coll_freq();
	vmovsd	%xmm3, nu_star_e(%rip)	# nu_max, nu_star_e
# C/parallel-only-omp/null_collision.h:20:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	vmulsd	.LC57(%rip), %xmm3, %xmm0	#, nu_max, tmp125
	vmovsd	%xmm3, 8(%rsp)	# nu_max, %sfp
# C/parallel-only-omp/null_collision.h:20:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	xorl	%ebx, %ebx	# ivtmp.989
# C/parallel-only-omp/null_collision.h:20:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	call	exp@PLT	#
	leaq	sigma_tot_i(%rip), %rbp	#, tmp152
# C/parallel-only-omp/null_collision.h:20:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	vmovsd	.LC10(%rip), %xmm7	#, tmp163
# C/parallel-only-omp/cross_sections.h:130:     nu_max = 0;
	vxorpd	%xmm2, %xmm2, %xmm2	# nu_max
# C/parallel-only-omp/null_collision.h:20:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	vsubsd	%xmm0, %xmm7, %xmm1	# tmp156, tmp163, _5
	vmovsd	.LC53(%rip), %xmm8	#, tmp149
# C/parallel-only-omp/null_collision.h:20:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	vmovsd	%xmm1, P_star_e(%rip)	# _5, P_star_e
	vmovsd	%xmm2, %xmm2, %xmm7	#, tmp135
	vxorps	%xmm6, %xmm6, %xmm6	# tmp159
	vmovsd	.LC1(%rip), %xmm5	#, tmp153
	vmovsd	.LC50(%rip), %xmm4	#, tmp147
	vmovsd	8(%rsp), %xmm3	# %sfp, nu_max
	.p2align 4
	.p2align 3
.L116:
# C/parallel-only-omp/cross_sections.h:132:         e  = i * DE_CS;
	vcvtsi2sdl	%ebx, %xmm6, %xmm0	# ivtmp.989, tmp159, tmp161
# C/parallel-only-omp/cross_sections.h:132:         e  = i * DE_CS;
	vmulsd	%xmm5, %xmm0, %xmm0	# tmp153, tmp128, e
# C/parallel-only-omp/cross_sections.h:133:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vaddsd	%xmm0, %xmm0, %xmm0	# e, e, tmp131
# C/parallel-only-omp/cross_sections.h:133:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vmulsd	%xmm4, %xmm0, %xmm0	# tmp147, tmp131, tmp132
# C/parallel-only-omp/cross_sections.h:133:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vdivsd	%xmm8, %xmm0, %xmm0	# tmp149, tmp132, _29
	vucomisd	%xmm0, %xmm7	# _29, tmp135
	ja	.L124	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _29, g
.L114:
# C/parallel-only-omp/cross_sections.h:134:         nu = g * sigma_tot_i[i];
	vmulsd	0(%rbp,%rbx,8), %xmm0, %xmm0	# MEM[(double *)&sigma_tot_i + ivtmp.989_73 * 8], g, nu
# C/parallel-only-omp/cross_sections.h:131:     for(i=0; i<CS_RANGES; i++){
	incq	%rbx	# ivtmp.989
# C/parallel-only-omp/cross_sections.h:135:         if (nu > nu_max) nu_max = nu;
	vmaxsd	%xmm2, %xmm0, %xmm2	# nu_max, nu, nu_max
# C/parallel-only-omp/cross_sections.h:131:     for(i=0; i<CS_RANGES; i++){
	cmpq	$1000000, %rbx	#, ivtmp.989
	jne	.L116	#,
	vmovsd	%xmm3, 16(%rsp)	# nu_max, %sfp
	vmovsd	%xmm1, 8(%rsp)	# _5, %sfp
# C/parallel-only-omp/null_collision.h:23:     nu_star_i = max_ion_coll_freq();
	vmovsd	%xmm2, nu_star_i(%rip)	# nu_max, nu_star_i
# C/parallel-only-omp/null_collision.h:24:     P_star_i = 1.0 - exp(-nu_star_i * DT_I);
	vmulsd	.LC58(%rip), %xmm2, %xmm0	#, nu_max, tmp139
	call	exp@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC55(%rip), %rsi	#, tmp143
	movl	$2, %edi	#,
	movl	$2, %eax	#,
	vmovsd	8(%rsp), %xmm1	# %sfp, _5
	vmovsd	16(%rsp), %xmm3	# %sfp, nu_max
# C/parallel-only-omp/null_collision.h:24:     P_star_i = 1.0 - exp(-nu_star_i * DT_I);
	vmovsd	.LC10(%rip), %xmm7	#, tmp164
	vsubsd	%xmm0, %xmm7, %xmm0	# tmp158, tmp164, tmp141
# C/parallel-only-omp/null_collision.h:24:     P_star_i = 1.0 - exp(-nu_star_i * DT_I);
	vmovsd	%xmm0, P_star_i(%rip)	# tmp141, P_star_i
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	vmovsd	%xmm3, %xmm3, %xmm0	# nu_max,
	call	__printf_chk@PLT	#
	vmovsd	P_star_i(%rip), %xmm1	# P_star_i,
	vmovsd	nu_star_i(%rip), %xmm0	# nu_star_i,
# C/parallel-only-omp/null_collision.h:28: }
	addq	$40, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC56(%rip), %rsi	#, tmp146
	movl	$2, %edi	#,
# C/parallel-only-omp/null_collision.h:28: }
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$2, %eax	#,
	jmp	__printf_chk@PLT	#
.L123:
	.cfi_restore_state
	vmovsd	%xmm3, 8(%rsp)	# nu_max, %sfp
# C/parallel-only-omp/cross_sections.h:113:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	call	sqrt@PLT	#
	vxorps	%xmm6, %xmm6, %xmm6	# tmp159
	vmovsd	.LC1(%rip), %xmm5	#, tmp153
	vmovsd	.LC51(%rip), %xmm2	#, tmp148
	vmovsd	.LC50(%rip), %xmm4	#, tmp147
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp121
	vmovsd	8(%rsp), %xmm3	# %sfp, nu_max
	jmp	.L109	#
.L124:
	vmovsd	%xmm3, 24(%rsp)	# nu_max, %sfp
	vmovsd	%xmm2, 16(%rsp)	# nu_max, %sfp
	vmovsd	%xmm1, 8(%rsp)	# _5, %sfp
# C/parallel-only-omp/cross_sections.h:133:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	call	sqrt@PLT	#
	vxorps	%xmm6, %xmm6, %xmm6	# tmp159
	vmovsd	.LC1(%rip), %xmm5	#, tmp153
	vmovsd	.LC53(%rip), %xmm8	#, tmp149
	vmovsd	.LC50(%rip), %xmm4	#, tmp147
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp135
	vmovsd	24(%rsp), %xmm3	# %sfp, nu_max
	vmovsd	16(%rsp), %xmm2	# %sfp, nu_max
	vmovsd	8(%rsp), %xmm1	# %sfp, _5
	jmp	.L114	#
	.cfi_endproc
.LFE9870:
	.size	_Z29compute_null_collision_paramsv, .-_Z29compute_null_collision_paramsv
	