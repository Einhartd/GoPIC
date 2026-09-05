# Function: double std::normal_distribution<double>::operator()<std::mersenne_twister_engine<unsigned long, 32ul, 624ul, 397ul, 31ul, 2567483615ul, 11ul, 4294967295ul, 7ul, 2636928640ul, 15ul, 4022730752ul, 18ul, 1812433253ul> >(std::mersenne_twister_engine<unsigned long, 32ul, 624ul, 397ul, 31ul, 2567483615ul, 11ul, 4294967295ul, 7ul, 2636928640ul, 15ul, 4022730752ul, 18ul, 1812433253ul>&, std::normal_distribution<double>::param_type const&) [clone .constprop.0]
# Mangled Symbol: _ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0,"ax",@progbits
	.align 2
	.p2align 4
	.type	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0, @function
_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0:
.LFB11283:
	.cfi_startproc
	pushq	%rbx	#
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$32, %rsp	#,
	.cfi_def_cfa_offset 48
# /usr/include/c++/13/bits/random.tcc:1820: 	if (_M_saved_available)
	cmpb	$0, %fs:24+RMB@tpoff	#, RMB._M_saved_available
	jne	.L863	#,
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992+MTgen@tpoff, %rdx	# MTgen._M_p, prephitmp_56
	leaq	MTgen@tpoff, %rbx	#, tmp228
	vxorps	%xmm4, %xmm4, %xmm4	# tmp237
	.p2align 4
	.p2align 3
.L864:
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, prephitmp_56
	ja	.L883	#,
.L866:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%rbx,%rdx,8), %rax	# MTgen._M_x[prephitmp_277], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rcx	#, _164
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp248
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, %fs:4992(%rbx)	# _164, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp167
	shrq	$11, %rdx	#, tmp167
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp167, _168
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _168, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp168
	salq	$7, %rdx	#, tmp168
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _171
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _171, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp169
	salq	$15, %rdx	#, tmp169
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _174
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _174, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _176
	shrq	$18, %rdx	#, _176
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _176, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm0	# __z, tmp237, tmp238
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm5, %xmm0, %xmm0	# tmp248, tmp171, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, _164
	ja	.L884	#,
.L867:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%rbx,%rcx,8), %rax	# MTgen._M_x[prephitmp_280], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rdx	#, _193
	movq	%rdx, %fs:4992(%rbx)	# _193, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp178
	shrq	$11, %rcx	#, tmp178
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp178, _197
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _197, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp179
	salq	$7, %rcx	#, tmp179
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _200
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _200, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp180
	salq	$15, %rcx	#, tmp180
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _203
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _203, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _205
	shrq	$18, %rcx	#, _205
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _205, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm2	# __z, tmp237, tmp239
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm0, %xmm2	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm2, %xmm2	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vcomisd	.LC10(%rip), %xmm2	#, __ret
	jnb	.L878	#,
# /usr/include/c++/13/bits/random.tcc:1830: 		__x = result_type(2.0) * __aurng() - 1.0;
	vmovsd	.LC152(%rip), %xmm7	#, tmp254
	vfmadd132sd	.LC170(%rip), %xmm7, %xmm2	#, tmp254, _285
.L868:
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _193
	ja	.L885	#,
.L869:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rcx	#, _17
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%rbx,%rdx,8), %rdx	# MTgen._M_x[prephitmp_288], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp260
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, %fs:4992(%rbx)	# _17, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rax	# __z, tmp193
	shrq	$11, %rax	#, tmp193
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%eax, %eax	# tmp193, _36
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rax, %rdx	# _36, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rax	# __z, tmp194
	salq	$7, %rax	#, tmp194
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %eax	#, _29
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp195
	salq	$15, %rdx	#, tmp195
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _116
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _116, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _118
	shrq	$18, %rdx	#, _118
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _118, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm1	# __z, tmp237, tmp240
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm6, %xmm1, %xmm1	# tmp260, tmp197, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, _17
	ja	.L886	#,
.L870:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%rbx,%rcx,8), %rax	# MTgen._M_x[prephitmp_291], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rdx	#, prephitmp_56
# /usr/include/c++/13/bits/random.tcc:1832: 		__r2 = __x * __x + __y * __y;
	vmulsd	%xmm2, %xmm2, %xmm3	# _285, _285, _292
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, %fs:4992(%rbx)	# prephitmp_56, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp204
	shrq	$11, %rcx	#, tmp204
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp204, _139
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _139, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp205
	salq	$7, %rcx	#, tmp205
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _142
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _142, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp206
	salq	$15, %rcx	#, tmp206
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _145
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _145, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _147
	shrq	$18, %rcx	#, _147
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _147, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm0	# __z, tmp237, tmp241
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vcomisd	.LC10(%rip), %xmm0	#, __ret
	jnb	.L871	#,
# /usr/include/c++/13/bits/random.tcc:1831: 		__y = result_type(2.0) * __aurng() - 1.0;
	vmovsd	.LC170(%rip), %xmm1	#, __y
	vfmadd213sd	.LC152(%rip), %xmm0, %xmm1	#, __ret, __y
# /usr/include/c++/13/bits/random.tcc:1832: 		__r2 = __x * __x + __y * __y;
	vfmadd231sd	%xmm1, %xmm1, %xmm3	# __y, __y, __r2
# /usr/include/c++/13/bits/random.tcc:1834: 	    while (__r2 > 1.0 || __r2 == 0.0);
	vcomisd	.LC10(%rip), %xmm3	#, __r2
	ja	.L864	#,
# /usr/include/c++/13/bits/random.tcc:1834: 	    while (__r2 > 1.0 || __r2 == 0.0);
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp267
	vucomisd	%xmm7, %xmm3	# tmp267, __r2
	jp	.L877	#,
	je	.L864	#,
	.p2align 4
	.p2align 3
.L877:
	vmovsd	%xmm2, 24(%rsp)	# _285, %sfp
	vmovsd	%xmm1, 16(%rsp)	# __y, %sfp
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	vmovsd	%xmm3, %xmm3, %xmm0	# __r2,
	vmovsd	%xmm3, 8(%rsp)	# __r2, %sfp
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	vmovsd	8(%rsp), %xmm3	# %sfp, __r2
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	vmulsd	.LC171(%rip), %xmm0, %xmm0	#, tmp235, tmp217
	vmovsd	16(%rsp), %xmm1	# %sfp, __y
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	vdivsd	%xmm3, %xmm0, %xmm0	# __r2, tmp217, _15
	vmovsd	24(%rsp), %xmm2	# %sfp, _285
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp219
	vucomisd	%xmm0, %xmm3	# _15, tmp219
	ja	.L880	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _15, __mult
.L876:
# /usr/include/c++/13/bits/random.tcc:1837: 	    _M_saved = __x * __mult;
	vmulsd	%xmm2, %xmm0, %xmm2	# _285, __mult, tmp221
# /usr/include/c++/13/bits/random.tcc:1838: 	    _M_saved_available = true;
	movb	$1, %fs:24+RMB@tpoff	#, RMB._M_saved_available
# /usr/include/c++/13/bits/random.tcc:1837: 	    _M_saved = __x * __mult;
	vmovsd	%xmm2, %fs:16+RMB@tpoff	# tmp221, RMB._M_saved
# /usr/include/c++/13/bits/random.tcc:1839: 	    __ret = __y * __mult;
	vmulsd	%xmm0, %xmm1, %xmm0	# __mult, __y, __ret
	jmp	.L865	#
	.p2align 4
	.p2align 3
.L886:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp261
	vmovsd	%xmm2, 16(%rsp)	# _285, %sfp
	vmovsd	%xmm1, 8(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp199
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbx), %rcx	# MTgen._M_p, _17
	vxorps	%xmm4, %xmm4, %xmm4	# tmp237
	vmovsd	16(%rsp), %xmm2	# %sfp, _285
	vmovsd	8(%rsp), %xmm1	# %sfp, __sum
	jmp	.L870	#
	.p2align 4
	.p2align 3
.L885:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp255
	vmovsd	%xmm2, 8(%rsp)	# _285, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp188
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbx), %rdx	# MTgen._M_p, _193
	vxorps	%xmm4, %xmm4, %xmm4	# tmp237
	vmovsd	8(%rsp), %xmm2	# %sfp, _285
	jmp	.L869	#
	.p2align 4
	.p2align 3
.L884:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp249
	vmovsd	%xmm0, 8(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp173
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbx), %rcx	# MTgen._M_p, _164
	vxorps	%xmm4, %xmm4, %xmm4	# tmp237
	vmovsd	8(%rsp), %xmm0	# %sfp, __sum
	jmp	.L867	#
	.p2align 4
	.p2align 3
.L883:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp243
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp162
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbx), %rdx	# MTgen._M_p, prephitmp_56
	vxorps	%xmm4, %xmm4, %xmm4	# tmp237
	jmp	.L866	#
	.p2align 4
	.p2align 3
.L871:
# /usr/include/c++/13/bits/random.tcc:1832: 		__r2 = __x * __x + __y * __y;
	vaddsd	.LC172(%rip), %xmm3, %xmm3	#, _292, __r2
# /usr/include/c++/13/bits/random.tcc:1834: 	    while (__r2 > 1.0 || __r2 == 0.0);
	vcomisd	.LC10(%rip), %xmm3	#, __r2
	ja	.L864	#,
# /usr/include/c++/13/bits/random.tcc:1831: 		__y = result_type(2.0) * __aurng() - 1.0;
	vmovsd	.LC167(%rip), %xmm1	#, __y
	jmp	.L877	#
	.p2align 4
	.p2align 3
.L878:
	vmovsd	.LC167(%rip), %xmm2	#, _285
	jmp	.L868	#
	.p2align 4
	.p2align 3
.L863:
# /usr/include/c++/13/bits/random.tcc:1822: 	    _M_saved_available = false;
	movb	$0, %fs:24+RMB@tpoff	#, RMB._M_saved_available
# /usr/include/c++/13/bits/random.tcc:1823: 	    __ret = _M_saved;
	vmovsd	%fs:16+RMB@tpoff, %xmm0	# RMB._M_saved, __ret
.L865:
# /usr/include/c++/13/bits/random.tcc:1842: 	__ret = __ret * __param.stddev() + __param.mean();
	vmovsd	%fs:RMB@tpoff, %xmm5	# MEM[(const struct param_type *)&RMB]._M_mean, tmp268
	vfmadd132sd	%fs:8+RMB@tpoff, %xmm5, %xmm0	# MEM[(const struct param_type *)&RMB]._M_stddev, tmp268, <retval>
# /usr/include/c++/13/bits/random.tcc:1844:       }
	addq	$32, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx	#
	.cfi_def_cfa_offset 8
	ret	
.L880:
	.cfi_restore_state
	vmovsd	%xmm2, 16(%rsp)	# _285, %sfp
	vmovsd	%xmm1, 8(%rsp)	# __y, %sfp
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	call	sqrt@PLT	#
	vmovsd	16(%rsp), %xmm2	# %sfp, _285
	vmovsd	8(%rsp), %xmm1	# %sfp, __y
	jmp	.L876	#
	.cfi_endproc
.LFE11283:
	.size	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0, .-_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0
	