# --- Symbol: _Z29compute_null_collision_paramsv ---
	.section	.text._Z29compute_null_collision_paramsv,"axG",@progbits,_Z29compute_null_collision_paramsv,comdat
	.p2align 4
	.weak	_Z29compute_null_collision_paramsv
	.type	_Z29compute_null_collision_paramsv, @function
_Z29compute_null_collision_paramsv:
.LFB3849:
	.cfi_startproc
	endbr64	
	subq	$24, %rsp	#,
	.cfi_def_cfa_offset 32
# null_collision.h:14:     nu_star_e = max_electron_coll_freq();
	call	_Z22max_electron_coll_freqv	#
	vmovsd	%xmm0, %xmm0, %xmm2	# tmp109, _1
# null_collision.h:14:     nu_star_e = max_electron_coll_freq();
	vmovsd	%xmm0, nu_star_e(%rip)	# _1, nu_star_e
# null_collision.h:15:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	vmovsd	%xmm2, 8(%rsp)	# _1, %sfp
	vmulsd	.LC73(%rip), %xmm0, %xmm0	#, _1, tmp96
	call	exp@PLT	#
# null_collision.h:15:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	vmovsd	.LC12(%rip), %xmm3	#, tmp114
	vsubsd	%xmm0, %xmm3, %xmm1	# tmp110, tmp114, _5
# null_collision.h:15:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	vmovsd	%xmm1, (%rsp)	# _5, %sfp
	vmovsd	%xmm1, P_star_e(%rip)	# _5, P_star_e
# null_collision.h:18:     nu_star_i = max_ion_coll_freq();
	call	_Z17max_ion_coll_freqv	#
# null_collision.h:18:     nu_star_i = max_ion_coll_freq();
	vmovsd	%xmm0, nu_star_i(%rip)	# _6, nu_star_i
# null_collision.h:19:     P_star_i = 1.0 - exp(-nu_star_i * DT_I);
	vmulsd	.LC74(%rip), %xmm0, %xmm0	#, _6, tmp101
	call	exp@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC71(%rip), %rsi	#, tmp105
	movl	$2, %edi	#,
	movl	$2, %eax	#,
	vmovsd	(%rsp), %xmm1	# %sfp, _5
	vmovsd	8(%rsp), %xmm2	# %sfp, _1
# null_collision.h:19:     P_star_i = 1.0 - exp(-nu_star_i * DT_I);
	vmovsd	.LC12(%rip), %xmm4	#, tmp115
	vsubsd	%xmm0, %xmm4, %xmm0	# tmp112, tmp115, tmp103
# null_collision.h:19:     P_star_i = 1.0 - exp(-nu_star_i * DT_I);
	vmovsd	%xmm0, P_star_i(%rip)	# tmp103, P_star_i
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	vmovsd	%xmm2, %xmm2, %xmm0	# _1,
	call	__printf_chk@PLT	#
	vmovsd	P_star_i(%rip), %xmm1	# P_star_i,
	vmovsd	nu_star_i(%rip), %xmm0	# nu_star_i,
	leaq	.LC72(%rip), %rsi	#, tmp108
	movl	$2, %edi	#,
	movl	$2, %eax	#,
# null_collision.h:23: }
	addq	$24, %rsp	#,
	.cfi_def_cfa_offset 8
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	jmp	__printf_chk@PLT	#
	.cfi_endproc
.LFE3849:
	.size	_Z29compute_null_collision_paramsv, .-_Z29compute_null_collision_paramsv


