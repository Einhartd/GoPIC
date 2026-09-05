# Function: double std::normal_distribution<double>::operator()<std::mersenne_twister_engine<unsigned long, 32ul, 624ul, 397ul, 31ul, 2567483615ul, 11ul, 4294967295ul, 7ul, 2636928640ul, 15ul, 4022730752ul, 18ul, 1812433253ul> >(std::mersenne_twister_engine<unsigned long, 32ul, 624ul, 397ul, 31ul, 2567483615ul, 11ul, 4294967295ul, 7ul, 2636928640ul, 15ul, 4022730752ul, 18ul, 1812433253ul>&, std::normal_distribution<double>::param_type const&) [clone .isra.0]
# Mangled Symbol: _ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0,"axG",@progbits,_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE,comdat
	.align 2
	.p2align 4
	.type	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0, @function
_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0:
.LFB11282:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx	# tmp208, this
	subq	$56, %rsp	#,
	.cfi_def_cfa_offset 80
# /usr/include/c++/13/bits/random.tcc:1820: 	if (_M_saved_available)
	cmpb	$0, 24(%rdi)	#, this_1(D)->_M_saved_available
# /usr/include/c++/13/bits/random.tcc:1812:       normal_distribution<_RealType>::
	vmovsd	%xmm0, 24(%rsp)	# tmp210, %sfp
	vmovsd	%xmm1, 32(%rsp)	# tmp211, %sfp
# /usr/include/c++/13/bits/random.tcc:1820: 	if (_M_saved_available)
	jne	.L838	#,
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	4992(%rsi), %rdx	# __urng_4(D)->_M_p, prephitmp_60
	movq	%rsi, %rbp	# tmp209, __urng
	vxorps	%xmm4, %xmm4, %xmm4	# tmp214
	.p2align 4
	.p2align 3
.L839:
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, prephitmp_60
	ja	.L858	#,
.L841:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	0(%rbp,%rdx,8), %rax	# __urng_4(D)->_M_x[prephitmp_277], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rcx	#, _166
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp224
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, 4992(%rbp)	# _166, __urng_4(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp160
	shrq	$11, %rdx	#, tmp160
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp160, _170
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _170, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp161
	salq	$7, %rdx	#, tmp161
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _173
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _173, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp162
	salq	$15, %rdx	#, tmp162
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _176
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _176, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _178
	shrq	$18, %rdx	#, _178
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _178, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm0	# __z, tmp214, tmp215
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm5, %xmm0, %xmm0	# tmp224, tmp164, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, _166
	ja	.L859	#,
.L842:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	0(%rbp,%rcx,8), %rax	# __urng_4(D)->_M_x[prephitmp_280], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rdx	#, _195
	movq	%rdx, 4992(%rbp)	# _195, __urng_4(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp166
	shrq	$11, %rcx	#, tmp166
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp166, _199
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _199, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp167
	salq	$7, %rcx	#, tmp167
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _202
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _202, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp168
	salq	$15, %rcx	#, tmp168
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _205
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _205, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _207
	shrq	$18, %rcx	#, _207
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _207, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm2	# __z, tmp214, tmp216
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm0, %xmm2	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm2, %xmm2	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vcomisd	.LC10(%rip), %xmm2	#, __ret
	jnb	.L853	#,
# /usr/include/c++/13/bits/random.tcc:1830: 		__x = result_type(2.0) * __aurng() - 1.0;
	vmovsd	.LC152(%rip), %xmm7	#, tmp229
	vfmadd132sd	.LC170(%rip), %xmm7, %xmm2	#, tmp229, _285
.L843:
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _195
	ja	.L860	#,
.L844:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rcx	#, _19
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	0(%rbp,%rdx,8), %rdx	# __urng_4(D)->_M_x[prephitmp_288], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp234
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, 4992(%rbp)	# _19, __urng_4(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rax	# __z, tmp176
	shrq	$11, %rax	#, tmp176
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%eax, %eax	# tmp176, _40
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rax, %rdx	# _40, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rax	# __z, tmp177
	salq	$7, %rax	#, tmp177
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %eax	#, _23
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp178
	salq	$15, %rdx	#, tmp178
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _32
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _32, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _120
	shrq	$18, %rdx	#, _120
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _120, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm1	# __z, tmp214, tmp217
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm6, %xmm1, %xmm1	# tmp234, tmp180, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, _19
	ja	.L861	#,
.L845:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	0(%rbp,%rcx,8), %rax	# __urng_4(D)->_M_x[prephitmp_291], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rdx	#, prephitmp_60
# /usr/include/c++/13/bits/random.tcc:1832: 		__r2 = __x * __x + __y * __y;
	vmulsd	%xmm2, %xmm2, %xmm3	# _285, _285, _292
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, 4992(%rbp)	# prephitmp_60, __urng_4(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp182
	shrq	$11, %rcx	#, tmp182
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp182, _141
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _141, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp183
	salq	$7, %rcx	#, tmp183
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _144
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _144, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp184
	salq	$15, %rcx	#, tmp184
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _147
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _147, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _149
	shrq	$18, %rcx	#, _149
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _149, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm0	# __z, tmp214, tmp218
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vcomisd	.LC10(%rip), %xmm0	#, __ret
	jnb	.L846	#,
# /usr/include/c++/13/bits/random.tcc:1831: 		__y = result_type(2.0) * __aurng() - 1.0;
	vmovsd	.LC170(%rip), %xmm1	#, __y
	vfmadd213sd	.LC152(%rip), %xmm0, %xmm1	#, __ret, __y
# /usr/include/c++/13/bits/random.tcc:1832: 		__r2 = __x * __x + __y * __y;
	vfmadd231sd	%xmm1, %xmm1, %xmm3	# __y, __y, __r2
# /usr/include/c++/13/bits/random.tcc:1834: 	    while (__r2 > 1.0 || __r2 == 0.0);
	vcomisd	.LC10(%rip), %xmm3	#, __r2
	ja	.L839	#,
# /usr/include/c++/13/bits/random.tcc:1834: 	    while (__r2 > 1.0 || __r2 == 0.0);
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp240
	vucomisd	%xmm7, %xmm3	# tmp240, __r2
	jp	.L852	#,
	je	.L839	#,
	.p2align 4
	.p2align 3
.L852:
	vmovsd	%xmm2, 40(%rsp)	# _285, %sfp
	vmovsd	%xmm1, 16(%rsp)	# __y, %sfp
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	vmovsd	%xmm3, %xmm3, %xmm0	# __r2,
	vmovsd	%xmm3, 8(%rsp)	# __r2, %sfp
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	vmovsd	8(%rsp), %xmm3	# %sfp, __r2
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	vmulsd	.LC171(%rip), %xmm0, %xmm0	#, tmp212, tmp195
	vmovsd	16(%rsp), %xmm1	# %sfp, __y
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	vdivsd	%xmm3, %xmm0, %xmm0	# __r2, tmp195, _17
	vmovsd	40(%rsp), %xmm2	# %sfp, _285
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp197
	vucomisd	%xmm0, %xmm3	# _17, tmp197
	ja	.L855	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _17, __mult
.L851:
# /usr/include/c++/13/bits/random.tcc:1837: 	    _M_saved = __x * __mult;
	vmulsd	%xmm2, %xmm0, %xmm2	# _285, __mult, tmp198
# /usr/include/c++/13/bits/random.tcc:1838: 	    _M_saved_available = true;
	movb	$1, 24(%rbx)	#, this_1(D)->_M_saved_available
# /usr/include/c++/13/bits/random.tcc:1837: 	    _M_saved = __x * __mult;
	vmovsd	%xmm2, 16(%rbx)	# tmp198, this_1(D)->_M_saved
# /usr/include/c++/13/bits/random.tcc:1839: 	    __ret = __y * __mult;
	vmulsd	%xmm0, %xmm1, %xmm0	# __mult, __y, __ret
	jmp	.L840	#
	.p2align 4
	.p2align 3
.L861:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbp, %rdi	# __urng,
	vmovsd	%xmm2, 16(%rsp)	# _285, %sfp
	vmovsd	%xmm1, 8(%rsp)	# __sum, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbp), %rcx	# __urng_4(D)->_M_p, _19
	vxorps	%xmm4, %xmm4, %xmm4	# tmp214
	vmovsd	16(%rsp), %xmm2	# %sfp, _285
	vmovsd	8(%rsp), %xmm1	# %sfp, __sum
	jmp	.L845	#
	.p2align 4
	.p2align 3
.L860:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbp, %rdi	# __urng,
	vmovsd	%xmm2, 8(%rsp)	# _285, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbp), %rdx	# __urng_4(D)->_M_p, _195
	vxorps	%xmm4, %xmm4, %xmm4	# tmp214
	vmovsd	8(%rsp), %xmm2	# %sfp, _285
	jmp	.L844	#
	.p2align 4
	.p2align 3
.L859:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbp, %rdi	# __urng,
	vmovsd	%xmm0, 8(%rsp)	# __sum, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbp), %rcx	# __urng_4(D)->_M_p, _166
	vxorps	%xmm4, %xmm4, %xmm4	# tmp214
	vmovsd	8(%rsp), %xmm0	# %sfp, __sum
	jmp	.L842	#
	.p2align 4
	.p2align 3
.L858:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbp, %rdi	# __urng,
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbp), %rdx	# __urng_4(D)->_M_p, prephitmp_60
	vxorps	%xmm4, %xmm4, %xmm4	# tmp214
	jmp	.L841	#
	.p2align 4
	.p2align 3
.L846:
# /usr/include/c++/13/bits/random.tcc:1832: 		__r2 = __x * __x + __y * __y;
	vaddsd	.LC172(%rip), %xmm3, %xmm3	#, _292, __r2
# /usr/include/c++/13/bits/random.tcc:1834: 	    while (__r2 > 1.0 || __r2 == 0.0);
	vcomisd	.LC10(%rip), %xmm3	#, __r2
	ja	.L839	#,
# /usr/include/c++/13/bits/random.tcc:1831: 		__y = result_type(2.0) * __aurng() - 1.0;
	vmovsd	.LC167(%rip), %xmm1	#, __y
	jmp	.L852	#
	.p2align 4
	.p2align 3
.L853:
	vmovsd	.LC167(%rip), %xmm2	#, _285
	jmp	.L843	#
	.p2align 4
	.p2align 3
.L838:
# /usr/include/c++/13/bits/random.tcc:1822: 	    _M_saved_available = false;
	movb	$0, 24(%rdi)	#, this_1(D)->_M_saved_available
# /usr/include/c++/13/bits/random.tcc:1823: 	    __ret = _M_saved;
	vmovsd	16(%rdi), %xmm0	# this_1(D)->_M_saved, __ret
.L840:
# /usr/include/c++/13/bits/random.tcc:1842: 	__ret = __ret * __param.stddev() + __param.mean();
	vmovsd	24(%rsp), %xmm6	# %sfp, ISRA.2210
	vfmadd132sd	32(%rsp), %xmm6, %xmm0	# %sfp, ISRA.2210, <retval>
# /usr/include/c++/13/bits/random.tcc:1844:       }
	addq	$56, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
.L855:
	.cfi_restore_state
	vmovsd	%xmm2, 16(%rsp)	# _285, %sfp
	vmovsd	%xmm1, 8(%rsp)	# __y, %sfp
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	call	sqrt@PLT	#
	vmovsd	16(%rsp), %xmm2	# %sfp, _285
	vmovsd	8(%rsp), %xmm1	# %sfp, __y
	jmp	.L851	#
	.cfi_endproc
.LFE11282:
	.size	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0, .-_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0
	