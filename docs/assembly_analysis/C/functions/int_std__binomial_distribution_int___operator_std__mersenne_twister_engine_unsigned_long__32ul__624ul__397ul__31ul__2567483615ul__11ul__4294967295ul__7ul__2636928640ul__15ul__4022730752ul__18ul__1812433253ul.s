# Function: int std::binomial_distribution<int>::operator()<std::mersenne_twister_engine<unsigned long, 32ul, 624ul, 397ul, 31ul, 2567483615ul, 11ul, 4294967295ul, 7ul, 2636928640ul, 15ul, 4022730752ul, 18ul, 1812433253ul> >(std::mersenne_twister_engine<unsigned long, 32ul, 624ul, 397ul, 31ul, 2567483615ul, 11ul, 4294967295ul, 7ul, 2636928640ul, 15ul, 4022730752ul, 18ul, 1812433253ul>&, std::binomial_distribution<int>::param_type const&)
# Mangled Symbol: _ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE,"axG",@progbits,_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE
	.type	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE, @function
_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE:
.LFB10698:
	.cfi_startproc
	endbr64	
	pushq	%r14	#
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13	#
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12	#
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdi, %r12	# tmp728, this
	pushq	%rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdx, %rbp	# tmp730, __param
	movq	%rsi, %rbx	# tmp729, __urng
	addq	$-128, %rsp	#,
	.cfi_def_cfa_offset 176
# /usr/include/c++/13/bits/random.h:3884: 	{ return _M_p; }
	vmovsd	8(%rdx), %xmm6	# __param_84(D)->_M_p, _112
# /usr/include/c++/13/bits/random.tcc:1573: 	const double __p12 = __p <= 0.5 ? __p : 1.0 - __p;
	vmovsd	.LC45(%rip), %xmm5	#, tmp771
# /usr/include/c++/13/bits/random.h:3880: 	{ return _M_t; }
	movl	(%rdx), %r13d	# __param_84(D)->_M_t, _118
# /usr/include/c++/13/bits/random.h:3884: 	{ return _M_p; }
	vmovsd	%xmm6, 112(%rsp)	# _112, %sfp
# /usr/include/c++/13/bits/random.tcc:1573: 	const double __p12 = __p <= 0.5 ? __p : 1.0 - __p;
	vmovsd	%xmm6, 88(%rsp)	# _112, %sfp
# /usr/include/c++/13/bits/random.tcc:1573: 	const double __p12 = __p <= 0.5 ? __p : 1.0 - __p;
	vcomisd	%xmm6, %xmm5	# _112, tmp771
	jnb	.L888	#,
# /usr/include/c++/13/bits/random.tcc:1573: 	const double __p12 = __p <= 0.5 ? __p : 1.0 - __p;
	vmovsd	.LC10(%rip), %xmm2	#, tmp717
	vsubsd	%xmm6, %xmm2, %xmm4	# _112, tmp717, iftmp.153_78
	vmovsd	%xmm4, 88(%rsp)	# iftmp.153_78, %sfp
.L888:
# /usr/include/c++/13/bits/random.tcc:1578: 	if (!__param._M_easy)
	cmpb	$0, 104(%rbp)	#, __param_84(D)->_M_easy
	jne	.L889	#,
# /usr/include/c++/13/bits/random.tcc:1588: 	    const double __np = std::floor(__t * __p12);
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp777
# /usr/include/c++/13/bits/random.tcc:1592: 	    const double __a1 = __param._M_a1;
	vmovsd	64(%rbp), %xmm4	# __param_84(D)->_M_a1, __a1
# /usr/include/c++/13/bits/random.tcc:1588: 	    const double __np = std::floor(__t * __p12);
	vcvtsi2sdl	%r13d, %xmm6, %xmm0	# _118, tmp777, tmp744
# /usr/include/c++/13/bits/random.tcc:1592: 	    const double __a1 = __param._M_a1;
	vmovsd	%xmm4, 16(%rsp)	# __a1, %sfp
# /usr/include/c++/13/bits/random.tcc:1588: 	    const double __np = std::floor(__t * __p12);
	vmovsd	%xmm0, %xmm0, %xmm3	# tmp744, _2
# /usr/include/c++/13/bits/random.tcc:1594: 	    const double __a123 = __param._M_a123;
	vmovsd	72(%rbp), %xmm6	# __param_84(D)->_M_a123, __a123
# /usr/include/c++/13/bits/random.tcc:1588: 	    const double __np = std::floor(__t * __p12);
	vmovsd	%xmm0, 120(%rsp)	# _2, %sfp
# /usr/include/c++/13/bits/random.tcc:1594: 	    const double __a123 = __param._M_a123;
	vmovsd	%xmm6, 64(%rsp)	# __a123, %sfp
# /usr/include/c++/13/bits/random.tcc:1588: 	    const double __np = std::floor(__t * __p12);
	vmulsd	88(%rsp), %xmm0, %xmm0	# %sfp, _2, tmp499
# /usr/include/c++/13/bits/random.tcc:1595: 	    const double __s1s = __param._M_s1 * __param._M_s1;
	vmovsd	40(%rbp), %xmm1	# __param_84(D)->_M_s1, _6
# /usr/include/c++/13/bits/random.tcc:1588: 	    const double __np = std::floor(__t * __p12);
	vrndscalesd	$9, %xmm0, %xmm0, %xmm5	#, tmp499, __np
	vmovsd	.LC10(%rip), %xmm2	#, tmp717
# /usr/include/c++/13/bits/random.tcc:1593: 	    const double __a12 = __a1 + __param._M_s2 * __spi_2;
	vmovsd	48(%rbp), %xmm0	# __param_84(D)->_M_s2, _4
	vsubsd	%xmm5, %xmm3, %xmm3	# __np, _2, tmp716
# /usr/include/c++/13/bits/random.tcc:1593: 	    const double __a12 = __a1 + __param._M_s2 * __spi_2;
	vfmadd231sd	.LC158(%rip), %xmm0, %xmm4	#, _4, __a12
# /usr/include/c++/13/bits/random.tcc:1596: 	    const double __s2s = __param._M_s2 * __param._M_s2;
	vmulsd	%xmm0, %xmm0, %xmm6	# _4, _4, __s2s
# /usr/include/c++/13/bits/random.tcc:1593: 	    const double __a12 = __a1 + __param._M_s2 * __spi_2;
	vmovsd	%xmm4, 24(%rsp)	# __a12, %sfp
# /usr/include/c++/13/bits/random.tcc:1588: 	    const double __np = std::floor(__t * __p12);
	vmovsd	%xmm5, 32(%rsp)	# __np, %sfp
# /usr/include/c++/13/bits/random.tcc:1595: 	    const double __s1s = __param._M_s1 * __param._M_s1;
	vmulsd	%xmm1, %xmm1, %xmm4	# _6, _6, __s1s
# /usr/include/c++/13/bits/random.tcc:1596: 	    const double __s2s = __param._M_s2 * __param._M_s2;
	vmovsd	%xmm6, 80(%rsp)	# __s2s, %sfp
# /usr/include/c++/13/bits/random.tcc:1595: 	    const double __s1s = __param._M_s1 * __param._M_s1;
	vmovsd	%xmm4, 72(%rsp)	# __s1s, %sfp
	vmovsd	%xmm2, 8(%rsp)	# tmp717, %sfp
	vmovsd	%xmm3, 56(%rsp)	# tmp716, %sfp
	.p2align 4
	.p2align 3
.L922:
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	4992(%rbx), %rax	# __urng_87(D)->_M_p, _890
# /usr/include/c++/13/bits/random.tcc:1601: 		const double __u = __param._M_s * __aurng();
	vmovsd	80(%rbp), %xmm2	# __param_84(D)->_M_s, _7
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, _890
	ja	.L956	#,
.L890:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rdx	#, _894
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rax,8), %rax	# __urng_87(D)->_M_x[prephitmp_1075], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp794
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, 4992(%rbx)	# _894, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp501
	shrq	$11, %rcx	#, tmp501
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp501, _898
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _898, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp502
	salq	$7, %rcx	#, tmp502
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _901
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _901, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp503
	salq	$15, %rcx	#, tmp503
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _904
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _904, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _906
	shrq	$18, %rcx	#, _906
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _906, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm7, %xmm1	# __z, tmp794, tmp745
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp795
	vaddsd	%xmm7, %xmm1, %xmm1	# tmp795, tmp505, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _894
	ja	.L957	#,
.L891:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rdx,8), %rax	# __urng_87(D)->_M_x[prephitmp_1078], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rcx	#, _923
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp800
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	8(%rsp), %xmm6	# %sfp, tmp717
	vmovsd	.LC173(%rip), %xmm7	#, tmp802
# /usr/include/c++/13/bits/random.tcc:1605: 		if (__u <= __a1)
	vmovsd	16(%rsp), %xmm5	# %sfp, __a1
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, 4992(%rbx)	# _923, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp507
	shrq	$11, %rdx	#, tmp507
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp507, _927
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _927, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp508
	salq	$7, %rdx	#, tmp508
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _930
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _930, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp509
	salq	$15, %rdx	#, tmp509
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _933
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _933, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _935
	shrq	$18, %rdx	#, _935
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _935, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm3, %xmm0	# __z, tmp800, tmp746
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm6, %xmm1	#, __ret, tmp717, tmp720
	vblendvpd	%xmm1, %xmm7, %xmm0, %xmm0	# tmp720, tmp802, __ret, __ret
# /usr/include/c++/13/bits/random.tcc:1601: 		const double __u = __param._M_s * __aurng();
	vmulsd	%xmm0, %xmm2, %xmm0	# __ret, _7, __u
# /usr/include/c++/13/bits/random.tcc:1605: 		if (__u <= __a1)
	vcomisd	%xmm0, %xmm5	# __u, __a1
	jnb	.L958	#,
# /usr/include/c++/13/bits/random.tcc:1617: 		else if (__u <= __a12)
	vmovsd	24(%rsp), %xmm6	# %sfp, __a12
	vcomisd	%xmm0, %xmm6	# __u, __a12
	jnb	.L959	#,
# /usr/include/c++/13/bits/random.tcc:1629: 		else if (__u <= __a123)
	vmovsd	64(%rsp), %xmm6	# %sfp, __a123
	vcomisd	%xmm0, %xmm6	# __u, __a123
	jnb	.L905	#,
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, _923
	ja	.L960	#,
.L906:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rcx,8), %rax	# __urng_87(D)->_M_x[prephitmp_1082], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rdx	#, _836
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp834
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp835
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, 4992(%rbx)	# _836, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp563
	shrq	$11, %rcx	#, tmp563
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp563, _840
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _840, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp564
	salq	$7, %rcx	#, tmp564
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _843
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _843, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp565
	salq	$15, %rcx	#, tmp565
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _846
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _846, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _848
	shrq	$18, %rcx	#, _848
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _848, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm2, %xmm1	# __z, tmp834, tmp751
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm3, %xmm1, %xmm1	# tmp835, tmp567, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _836
	ja	.L961	#,
.L907:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rdx,8), %rax	# __urng_87(D)->_M_x[prephitmp_1085], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %r14	#, _865
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp840
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vmovsd	8(%rsp), %xmm4	# %sfp, tmp717
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%r14, 4992(%rbx)	# _865, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp569
	shrq	$11, %rdx	#, tmp569
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp569, _869
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _869, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp570
	salq	$7, %rdx	#, tmp570
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _872
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _872, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp571
	salq	$15, %rdx	#, tmp571
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _875
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _875, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _877
	shrq	$18, %rdx	#, _877
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _877, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm7, %xmm0	# __z, tmp840, tmp752
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vcomisd	%xmm4, %xmm0	# tmp717, __ret
	jnb	.L945	#,
# /usr/include/c++/13/bits/random.tcc:1643: 		    const double __e1 = -std::log(1.0 - __aurng());
	vsubsd	%xmm0, %xmm4, %xmm0	# __ret, tmp717, _1087
.L908:
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1643: 		    const double __e1 = -std::log(1.0 - __aurng());
	vxorpd	.LC31(%rip), %xmm0, %xmm5	#, tmp737, __e1
	vmovsd	%xmm5, 40(%rsp)	# __e1, %sfp
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %r14	#, _865
	ja	.L962	#,
.L916:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%r14,8), %rax	# __urng_87(D)->_M_x[prephitmp_1090], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%r14), %rdx	#, _778
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp879
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp880
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, 4992(%rbx)	# _778, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp618
	shrq	$11, %rcx	#, tmp618
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp618, _782
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _782, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp619
	salq	$7, %rcx	#, tmp619
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _785
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _785, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp620
	salq	$15, %rcx	#, tmp620
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _788
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _788, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _790
	shrq	$18, %rcx	#, _790
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _790, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm1	# __z, tmp879, tmp757
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm5, %xmm1, %xmm1	# tmp880, tmp622, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _778
	ja	.L963	#,
.L917:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rax	#, tmp624
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp885
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vmovsd	8(%rsp), %xmm3	# %sfp, tmp717
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, 4992(%rbx)	# tmp624, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rdx,8), %rax	# __urng_87(D)->_M_x[prephitmp_1093], __z
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp625
	shrq	$11, %rdx	#, tmp625
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp625, _811
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _811, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp626
	salq	$7, %rdx	#, tmp626
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _814
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _814, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp627
	salq	$15, %rdx	#, tmp627
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _817
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _817, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _819
	shrq	$18, %rdx	#, _819
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _819, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm6, %xmm0	# __z, tmp885, tmp758
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vcomisd	%xmm3, %xmm0	# tmp717, __ret
	jnb	.L948	#,
# /usr/include/c++/13/bits/random.tcc:1644: 		    const double __e2 = -std::log(1.0 - __aurng());
	vsubsd	%xmm0, %xmm3, %xmm0	# __ret, tmp717, _1095
.L918:
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1646: 		    const double __y = __param._M_d2
	vmovsd	32(%rbp), %xmm3	# __param_84(D)->_M_d2, _42
# /usr/include/c++/13/bits/random.tcc:1647: 				     + 2 * __s2s * __e1 / __param._M_d2;
	vmovsd	80(%rsp), %xmm5	# %sfp, __s2s
	vaddsd	%xmm5, %xmm5, %xmm4	#, __s2s, _43
# /usr/include/c++/13/bits/random.tcc:1647: 				     + 2 * __s2s * __e1 / __param._M_d2;
	vmulsd	40(%rsp), %xmm4, %xmm1	# %sfp, _43, tmp634
# /usr/include/c++/13/bits/random.tcc:1647: 				     + 2 * __s2s * __e1 / __param._M_d2;
	vdivsd	%xmm3, %xmm1, %xmm1	# _42, tmp634, tmp635
# /usr/include/c++/13/bits/random.tcc:1646: 		    const double __y = __param._M_d2
	vaddsd	%xmm3, %xmm1, %xmm1	# _42, tmp635, __y
# /usr/include/c++/13/bits/random.tcc:1648: 		    __x = std::floor(-__y);
	vxorpd	.LC31(%rip), %xmm1, %xmm2	#, __y, tmp636
# /usr/include/c++/13/bits/random.tcc:1649: 		    __v = -__e2 - __param._M_d2 * __y / (2 * __s2s);
	vmulsd	%xmm1, %xmm3, %xmm3	# __y, _42, tmp638
# /usr/include/c++/13/bits/random.tcc:1649: 		    __v = -__e2 - __param._M_d2 * __y / (2 * __s2s);
	vdivsd	%xmm4, %xmm3, %xmm3	# _43, tmp638, tmp639
# /usr/include/c++/13/bits/random.tcc:1649: 		    __v = -__e2 - __param._M_d2 * __y / (2 * __s2s);
	vsubsd	%xmm3, %xmm0, %xmm1	# tmp639, tmp738, __v
# /usr/include/c++/13/bits/random.tcc:1648: 		    __x = std::floor(-__y);
	vrndscalesd	$9, %xmm2, %xmm2, %xmm2	#, tmp636, __x
.L915:
# /usr/include/c++/13/bits/random.tcc:1653: 		__reject = __reject || __x < -__np || __x > __t - __np;
	vmovsd	32(%rsp), %xmm5	# %sfp, __np
	vxorpd	.LC31(%rip), %xmm5, %xmm0	#, __np, tmp640
# /usr/include/c++/13/bits/random.tcc:1653: 		__reject = __reject || __x < -__np || __x > __t - __np;
	vcomisd	%xmm2, %xmm0	# __x, tmp640
	ja	.L922	#,
# /usr/include/c++/13/bits/random.tcc:1653: 		__reject = __reject || __x < -__np || __x > __t - __np;
	vcomisd	56(%rsp), %xmm2	# %sfp, __x
	ja	.L922	#,
# /usr/include/c++/13/bits/random.tcc:1657: 		      std::lgamma(__np + __x + 1)
	vaddsd	%xmm5, %xmm2, %xmm7	#, __x, _1151
	vmovsd	%xmm1, 104(%rsp)	# __v, %sfp
	vmovsd	%xmm2, 96(%rsp)	# __x, %sfp
# /usr/include/c++/13/bits/random.tcc:1657: 		      std::lgamma(__np + __x + 1)
	vmovsd	%xmm7, 40(%rsp)	# _1151, %sfp
	vaddsd	8(%rsp), %xmm7, %xmm0	# %sfp, _1151, tmp643
	call	lgamma@PLT	#
# /usr/include/c++/13/bits/random.tcc:1658: 		      + std::lgamma(__t - (__np + __x) + 1);
	vmovsd	120(%rsp), %xmm6	# %sfp, _2
# /usr/include/c++/13/bits/random.tcc:1657: 		      std::lgamma(__np + __x + 1)
	vmovsd	%xmm0, 48(%rsp)	# tmp739, %sfp
# /usr/include/c++/13/bits/random.tcc:1658: 		      + std::lgamma(__t - (__np + __x) + 1);
	vsubsd	40(%rsp), %xmm6, %xmm0	# %sfp, _2, tmp645
# /usr/include/c++/13/bits/random.tcc:1658: 		      + std::lgamma(__t - (__np + __x) + 1);
	vaddsd	8(%rsp), %xmm0, %xmm0	# %sfp, tmp645, tmp646
	call	lgamma@PLT	#
# /usr/include/c++/13/bits/random.tcc:1660: 			     + __x * __param._M_lp1p;
	vmovsd	96(%rsp), %xmm2	# %sfp, __x
# /usr/include/c++/13/bits/random.tcc:1656: 		    const double __lfx =
	vaddsd	48(%rsp), %xmm0, %xmm3	# %sfp, tmp740, __lfx
# /usr/include/c++/13/bits/random.tcc:1599: 	    do
	vmovsd	104(%rsp), %xmm1	# %sfp, __v
# /usr/include/c++/13/bits/random.tcc:1659: 		    __reject = __v > __param._M_lf - __lfx
	vmovsd	88(%rbp), %xmm0	# __param_84(D)->_M_lf, __param_84(D)->_M_lf
	vsubsd	%xmm3, %xmm0, %xmm0	# __lfx, __param_84(D)->_M_lf, tmp649
# /usr/include/c++/13/bits/random.tcc:1660: 			     + __x * __param._M_lp1p;
	vfmadd231sd	96(%rbp), %xmm2, %xmm0	# __param_84(D)->_M_lp1p, __x, _62
# /usr/include/c++/13/bits/random.tcc:1599: 	    do
	vcomisd	%xmm0, %xmm1	# _62, __v
	ja	.L922	#,
# /usr/include/c++/13/bits/random.tcc:1663: 		__reject |= __x + __np >= __thr;
	vmovsd	40(%rsp), %xmm7	# %sfp, _1151
	vcomisd	.LC175(%rip), %xmm7	#, _1151
# /usr/include/c++/13/bits/random.tcc:1599: 	    do
	jnb	.L922	#,
# /usr/include/c++/13/bits/random.tcc:1670: 					    __param._M_q);
	vmovsd	16(%rbp), %xmm3	# __param_84(D)->_M_q, _66
# /usr/include/c++/13/bits/random.tcc:1669: 	    const _IntType __z = _M_waiting(__urng, __t - _IntType(__x),
	movl	%r13d, %ebp	# _118, _68
# /usr/include/c++/13/bits/random.tcc:1667: 	    __x += __np + __naf;
	vmovsd	32(%rsp), %xmm5	# %sfp, __np
# /usr/include/c++/13/bits/random.tcc:1535: 	_IntType __x = 0;
	xorl	%r14d, %r14d	# __x
# /usr/include/c++/13/bits/random.tcc:1667: 	    __x += __np + __naf;
	vaddsd	.LC176(%rip), %xmm5, %xmm0	#, __np, tmp656
# /usr/include/c++/13/bits/random.tcc:1670: 					    __param._M_q);
	vmovsd	%xmm3, 24(%rsp)	# _66, %sfp
# /usr/include/c++/13/bits/random.tcc:1667: 	    __x += __np + __naf;
	vaddsd	%xmm2, %xmm0, %xmm0	# __x, tmp656, __x
# /usr/include/c++/13/bits/random.tcc:1536: 	double __sum = 0.0;
	movq	$0x000000000, 16(%rsp)	#, %sfp
# /usr/include/c++/13/bits/random.tcc:1669: 	    const _IntType __z = _M_waiting(__urng, __t - _IntType(__x),
	vcvttsd2sil	%xmm0, %r12d	# __x, _67
# /usr/include/c++/13/bits/random.tcc:1669: 	    const _IntType __z = _M_waiting(__urng, __t - _IntType(__x),
	subl	%r12d, %ebp	# _67, _68
	jmp	.L931	#
	.p2align 4
	.p2align 3
.L925:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rax,8), %rdx	# __urng_87(D)->_M_x[prephitmp_1143], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rcx	#, _507
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp908
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp909
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, 4992(%rbx)	# _507, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rax	# __z, tmp659
	shrq	$11, %rax	#, tmp659
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%eax, %eax	# tmp659, _527
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rax, %rdx	# _527, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rax	# __z, tmp660
	salq	$7, %rax	#, tmp660
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %eax	#, _336
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rax, %rdx	# _336, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rax	# __z, tmp661
	salq	$15, %rax	#, tmp661
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %eax	#, _530
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _526
	shrq	$18, %rdx	#, _526
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _526, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm7, %xmm1	# __z, tmp908, tmp759
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm3, %xmm1, %xmm1	# tmp909, tmp663, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, _507
	ja	.L964	#,
.L926:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rax	#, tmp665
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp914
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vmovsd	8(%rsp), %xmm4	# %sfp, tmp717
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, 4992(%rbx)	# tmp665, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rcx,8), %rax	# __urng_87(D)->_M_x[prephitmp_1146], __z
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp666
	shrq	$11, %rdx	#, tmp666
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp666, _204
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rax, %rdx	# __z, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rax	# __z, tmp667
	salq	$7, %rax	#, tmp667
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %eax	#, _510
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp668
	salq	$15, %rdx	#, tmp668
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _414
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _414, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _535
	shrq	$18, %rdx	#, _535
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _535, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm5, %xmm0	# __z, tmp914, tmp760
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vcomisd	%xmm4, %xmm0	# tmp717, __ret
	jnb	.L927	#,
# /usr/include/c++/13/bits/random.tcc:1544: 	    const double __e = -std::log(1.0 - __aurng());
	vsubsd	%xmm0, %xmm4, %xmm0	# __ret, tmp717, tmp674
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1544: 	    const double __e = -std::log(1.0 - __aurng());
	vxorpd	.LC31(%rip), %xmm0, %xmm0	#, tmp741, __e
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	movl	%ebp, %eax	# _68, tmp678
	subl	%r14d, %eax	# __x, tmp678
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp918
# /usr/include/c++/13/bits/random.tcc:1548: 	while (__sum <= __q);
	vmovsd	24(%rsp), %xmm4	# %sfp, _66
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vcvtsi2sdl	%eax, %xmm5, %xmm1	# tmp678, tmp918, tmp761
# /usr/include/c++/13/bits/random.tcc:1546: 	    __x += 1;
	leal	1(%r14), %eax	#, __x
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp679, __e, tmp680
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vaddsd	16(%rsp), %xmm0, %xmm6	# %sfp, tmp680, __sum
	vmovsd	%xmm6, 16(%rsp)	# __sum, %sfp
# /usr/include/c++/13/bits/random.tcc:1548: 	while (__sum <= __q);
	vcomisd	%xmm6, %xmm4	# __sum, _66
	jb	.L929	#,
.L928:
# /usr/include/c++/13/bits/random.tcc:1546: 	    __x += 1;
	movl	%eax, %r14d	# __x, __x
.L931:
# /usr/include/c++/13/bits/random.tcc:1542: 	    if (__t == __x)
	cmpl	%r14d, %ebp	# __x, _68
	je	.L929	#,
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	4992(%rbx), %rax	# __urng_87(D)->_M_p, _540
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, _540
	jbe	.L925	#,
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rax	# __urng_87(D)->_M_p, _540
	jmp	.L925	#
	.p2align 4
	.p2align 3
.L958:
# /usr/include/c++/13/bits/random.tcc:1607: 		    const double __n = _M_nd(__urng);
	leaq	112(%r12), %rdi	#, tmp517
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	movq	%rbx, %rsi	# __urng,
	vmovsd	120(%r12), %xmm1	# MEM[(double *)this_88(D) + 120B],
	vmovsd	112(%r12), %xmm0	# MEM[(double *)this_88(D) + 112B], MEM[(double *)this_88(D) + 112B]
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0	#
	vmovsd	%xmm0, %xmm0, %xmm1	# tmp731, _135
# /usr/include/c++/13/bits/std_abs.h:72:   { return __builtin_fabs(__x); }
	vandpd	.LC18(%rip), %xmm1, %xmm2	#, _135, tmp518
# /usr/include/c++/13/bits/random.tcc:1608: 		    const double __y = __param._M_s1 * std::abs(__n);
	vmulsd	40(%rbp), %xmm2, %xmm2	# __param_84(D)->_M_s1, tmp518, __y
# /usr/include/c++/13/bits/random.tcc:1610: 		    if (!__reject)
	vcomisd	24(%rbp), %xmm2	# __param_84(D)->_M_d1, __y
	jnb	.L922	#,
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	4992(%rbx), %rax	# __urng_87(D)->_M_p, _148
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, _148
	ja	.L965	#,
.L896:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rdx	#, _546
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rax,8), %rax	# __urng_87(D)->_M_x[prephitmp_1121], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp808
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp525
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, 4992(%rbx)	# _546, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp520
	shrq	$11, %rcx	#, tmp520
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp520, _550
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _550, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp521
	salq	$7, %rcx	#, tmp521
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _553
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _553, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp522
	salq	$15, %rcx	#, tmp522
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _556
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _556, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _558
	shrq	$18, %rcx	#, _558
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _558, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm5, %xmm3	# __z, tmp808, tmp747
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm0, %xmm3, %xmm3	# tmp525, tmp524, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _546
	ja	.L966	#,
.L897:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rax	#, tmp526
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp813
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vmovsd	8(%rsp), %xmm7	# %sfp, tmp717
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, 4992(%rbx)	# tmp526, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rdx,8), %rax	# __urng_87(D)->_M_x[prephitmp_1124], __z
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp527
	shrq	$11, %rdx	#, tmp527
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp527, _579
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _579, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp528
	salq	$7, %rdx	#, tmp528
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _582
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _582, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp529
	salq	$15, %rdx	#, tmp529
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _585
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _585, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _587
	shrq	$18, %rdx	#, _587
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _587, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm0	# __z, tmp813, tmp748
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm3, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vcomisd	%xmm7, %xmm0	# tmp717, __ret
	jnb	.L943	#,
# /usr/include/c++/13/bits/random.tcc:1612: 			const double __e = -std::log(1.0 - __aurng());
	vsubsd	%xmm0, %xmm7, %xmm0	# __ret, tmp717, _1126
.L898:
	vmovsd	%xmm1, 48(%rsp)	# _135, %sfp
	vmovsd	%xmm2, 40(%rsp)	# __y, %sfp
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1613: 			__x = std::floor(__y);
	vmovsd	40(%rsp), %xmm2	# %sfp, __y
# /usr/include/c++/13/bits/random.tcc:1614: 			__v = -__e - __n * __n / 2 + __param._M_c;
	vmovsd	48(%rsp), %xmm1	# %sfp, _135
# /usr/include/c++/13/bits/random.tcc:1613: 			__x = std::floor(__y);
	vrndscalesd	$9, %xmm2, %xmm2, %xmm2	#, __y, __x
# /usr/include/c++/13/bits/random.tcc:1614: 			__v = -__e - __n * __n / 2 + __param._M_c;
	vmulsd	%xmm1, %xmm1, %xmm1	# _135, _135, tmp536
# /usr/include/c++/13/bits/random.tcc:1614: 			__v = -__e - __n * __n / 2 + __param._M_c;
	vfnmadd132sd	.LC45(%rip), %xmm0, %xmm1	#, tmp732, _15
# /usr/include/c++/13/bits/random.tcc:1614: 			__v = -__e - __n * __n / 2 + __param._M_c;
	vaddsd	56(%rbp), %xmm1, %xmm1	# __param_84(D)->_M_c, _15, __v
	jmp	.L915	#
	.p2align 4
	.p2align 3
.L957:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	vmovsd	%xmm1, 48(%rsp)	# __sum, %sfp
	vmovsd	%xmm2, 40(%rsp)	# _7, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rdx	# __urng_87(D)->_M_p, _894
	vmovsd	48(%rsp), %xmm1	# %sfp, __sum
	vmovsd	40(%rsp), %xmm2	# %sfp, _7
	jmp	.L891	#
	.p2align 4
	.p2align 3
.L956:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	vmovsd	%xmm2, 40(%rsp)	# _7, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rax	# __urng_87(D)->_M_p, _890
	vmovsd	40(%rsp), %xmm2	# %sfp, _7
	jmp	.L890	#
	.p2align 4
	.p2align 3
.L964:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	vmovsd	%xmm1, 32(%rsp)	# __sum, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rcx	# __urng_87(D)->_M_p, _507
	vmovsd	32(%rsp), %xmm1	# %sfp, __sum
	jmp	.L926	#
	.p2align 4
	.p2align 3
.L905:
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, _923
	ja	.L967	#,
.L909:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rcx,8), %rax	# __urng_87(D)->_M_x[prephitmp_1098], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rdx	#, _720
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp847
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp848
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, 4992(%rbx)	# _720, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp578
	shrq	$11, %rcx	#, tmp578
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp578, _724
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _724, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp579
	salq	$7, %rcx	#, tmp579
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _727
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _727, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp580
	salq	$15, %rcx	#, tmp580
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _730
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _730, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _732
	shrq	$18, %rcx	#, _732
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _732, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm1	# __z, tmp847, tmp753
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm5, %xmm1, %xmm1	# tmp848, tmp582, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _720
	ja	.L968	#,
.L910:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rdx,8), %rax	# __urng_87(D)->_M_x[prephitmp_1100], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %r14	#, _749
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp853
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vmovsd	8(%rsp), %xmm5	# %sfp, tmp717
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%r14, 4992(%rbx)	# _749, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp584
	shrq	$11, %rdx	#, tmp584
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp584, _753
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _753, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp585
	salq	$7, %rdx	#, tmp585
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _756
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _756, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp586
	salq	$15, %rdx	#, tmp586
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _759
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _759, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _761
	shrq	$18, %rdx	#, _761
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _761, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm6, %xmm0	# __z, tmp853, tmp754
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vcomisd	%xmm5, %xmm0	# tmp717, __ret
	jnb	.L946	#,
# /usr/include/c++/13/bits/random.tcc:1631: 		    const double __e1 = -std::log(1.0 - __aurng());
	vsubsd	%xmm0, %xmm5, %xmm0	# __ret, tmp717, _1102
.L911:
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1631: 		    const double __e1 = -std::log(1.0 - __aurng());
	vxorpd	.LC31(%rip), %xmm0, %xmm2	#, tmp735, __e1
	vmovsd	%xmm2, 40(%rsp)	# __e1, %sfp
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %r14	#, _749
	ja	.L969	#,
.L912:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%r14,8), %rax	# __urng_87(D)->_M_x[prephitmp_1105], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%r14), %rdx	#, _662
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp861
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp862
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, 4992(%rbx)	# _662, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp594
	shrq	$11, %rcx	#, tmp594
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp594, _666
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _666, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp595
	salq	$7, %rcx	#, tmp595
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _669
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _669, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp596
	salq	$15, %rcx	#, tmp596
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _672
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _672, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _674
	shrq	$18, %rcx	#, _674
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _674, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm3, %xmm1	# __z, tmp861, tmp755
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm7, %xmm1, %xmm1	# tmp862, tmp598, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _662
	ja	.L970	#,
.L913:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rax	#, tmp600
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp867
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vmovsd	8(%rsp), %xmm2	# %sfp, tmp717
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, 4992(%rbx)	# tmp600, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rdx,8), %rax	# __urng_87(D)->_M_x[prephitmp_1108], __z
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp601
	shrq	$11, %rdx	#, tmp601
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp601, _695
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _695, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp602
	salq	$7, %rdx	#, tmp602
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _698
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _698, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp603
	salq	$15, %rdx	#, tmp603
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _701
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _701, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _703
	shrq	$18, %rdx	#, _703
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _703, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm0	# __z, tmp867, tmp756
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vcomisd	%xmm2, %xmm0	# tmp717, __ret
	jnb	.L947	#,
# /usr/include/c++/13/bits/random.tcc:1632: 		    const double __e2 = -std::log(1.0 - __aurng());
	vsubsd	%xmm0, %xmm2, %xmm0	# __ret, tmp717, _1110
.L914:
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1635: 				     + 2 * __s1s * __e1 / __param._M_d1;
	vmovsd	72(%rsp), %xmm7	# %sfp, __s1s
# /usr/include/c++/13/bits/random.tcc:1637: 		    __v = (-__e2 + __param._M_d1 * (1 / (__t - __np)
	vmovsd	8(%rsp), %xmm3	# %sfp, tmp717
# /usr/include/c++/13/bits/random.tcc:1635: 				     + 2 * __s1s * __e1 / __param._M_d1;
	vaddsd	%xmm7, %xmm7, %xmm4	#, __s1s, _30
# /usr/include/c++/13/bits/random.tcc:1632: 		    const double __e2 = -std::log(1.0 - __aurng());
	vmovsd	%xmm0, %xmm0, %xmm5	#, tmp736
# /usr/include/c++/13/bits/random.tcc:1635: 				     + 2 * __s1s * __e1 / __param._M_d1;
	vmulsd	40(%rsp), %xmm4, %xmm1	# %sfp, _30, tmp610
# /usr/include/c++/13/bits/random.tcc:1634: 		    const double __y = __param._M_d1
	vmovsd	24(%rbp), %xmm0	# __param_84(D)->_M_d1, _29
# /usr/include/c++/13/bits/random.tcc:1637: 		    __v = (-__e2 + __param._M_d1 * (1 / (__t - __np)
	vdivsd	56(%rsp), %xmm3, %xmm3	# %sfp, tmp717, tmp613
# /usr/include/c++/13/bits/random.tcc:1635: 				     + 2 * __s1s * __e1 / __param._M_d1;
	vdivsd	%xmm0, %xmm1, %xmm1	# _29, tmp610, tmp611
# /usr/include/c++/13/bits/random.tcc:1634: 		    const double __y = __param._M_d1
	vaddsd	%xmm0, %xmm1, %xmm1	# _29, tmp611, __y
# /usr/include/c++/13/bits/random.tcc:1636: 		    __x = std::floor(__y);
	vrndscalesd	$9, %xmm1, %xmm1, %xmm2	#, __y, __x
# /usr/include/c++/13/bits/random.tcc:1638: 						    -__y / (2 * __s1s)));
	vdivsd	%xmm4, %xmm1, %xmm1	# _30, __y, tmp615
# /usr/include/c++/13/bits/random.tcc:1638: 						    -__y / (2 * __s1s)));
	vsubsd	%xmm1, %xmm3, %xmm1	# tmp615, tmp613, tmp616
# /usr/include/c++/13/bits/random.tcc:1637: 		    __v = (-__e2 + __param._M_d1 * (1 / (__t - __np)
	vfmadd132sd	%xmm0, %xmm5, %xmm1	# _29, tmp736, __v
	jmp	.L915	#
	.p2align 4
	.p2align 3
.L959:
# /usr/include/c++/13/bits/random.tcc:1619: 		    const double __n = _M_nd(__urng);
	leaq	112(%r12), %rdi	#, tmp540
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	movq	%rbx, %rsi	# __urng,
	vmovsd	120(%r12), %xmm1	# MEM[(double *)this_88(D) + 120B],
	vmovsd	112(%r12), %xmm0	# MEM[(double *)this_88(D) + 112B], MEM[(double *)this_88(D) + 112B]
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0	#
	vmovsd	%xmm0, %xmm0, %xmm1	# tmp733, _139
# /usr/include/c++/13/bits/std_abs.h:72:   { return __builtin_fabs(__x); }
	vandpd	.LC18(%rip), %xmm1, %xmm2	#, _139, tmp541
# /usr/include/c++/13/bits/random.tcc:1620: 		    const double __y = __param._M_s2 * std::abs(__n);
	vmulsd	48(%rbp), %xmm2, %xmm2	# __param_84(D)->_M_s2, tmp541, __y
# /usr/include/c++/13/bits/random.tcc:1622: 		    if (!__reject)
	vcomisd	32(%rbp), %xmm2	# __param_84(D)->_M_d2, __y
	jnb	.L922	#,
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	4992(%rbx), %rax	# __urng_87(D)->_M_p, _600
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, _600
	ja	.L971	#,
.L902:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rdx	#, _604
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rax,8), %rax	# __urng_87(D)->_M_x[prephitmp_1113], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp821
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp548
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, 4992(%rbx)	# _604, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp543
	shrq	$11, %rcx	#, tmp543
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp543, _608
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _608, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp544
	salq	$7, %rcx	#, tmp544
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _611
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _611, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp545
	salq	$15, %rcx	#, tmp545
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _614
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _614, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _616
	shrq	$18, %rcx	#, _616
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _616, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm3, %xmm3	# __z, tmp821, tmp749
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm0, %xmm3, %xmm3	# tmp548, tmp547, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _604
	ja	.L972	#,
.L903:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rax	#, tmp549
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp826
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vmovsd	8(%rsp), %xmm5	# %sfp, tmp717
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, 4992(%rbx)	# tmp549, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rdx,8), %rax	# __urng_87(D)->_M_x[prephitmp_1116], __z
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp550
	shrq	$11, %rdx	#, tmp550
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp550, _637
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _637, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp551
	salq	$7, %rdx	#, tmp551
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _640
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _640, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp552
	salq	$15, %rdx	#, tmp552
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _643
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _643, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _645
	shrq	$18, %rdx	#, _645
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _645, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm7, %xmm0	# __z, tmp826, tmp750
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm3, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vcomisd	%xmm5, %xmm0	# tmp717, __ret
	jnb	.L944	#,
# /usr/include/c++/13/bits/random.tcc:1624: 			const double __e = -std::log(1.0 - __aurng());
	vsubsd	%xmm0, %xmm5, %xmm0	# __ret, tmp717, _1118
.L904:
	vmovsd	%xmm1, 48(%rsp)	# _139, %sfp
	vmovsd	%xmm2, 40(%rsp)	# __y, %sfp
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1625: 			__x = std::floor(-__y);
	vmovsd	40(%rsp), %xmm2	# %sfp, __y
	vxorpd	.LC31(%rip), %xmm2, %xmm2	#, __y, tmp559
# /usr/include/c++/13/bits/random.tcc:1626: 			__v = -__e - __n * __n / 2;
	vmovsd	48(%rsp), %xmm1	# %sfp, _139
	vmulsd	%xmm1, %xmm1, %xmm1	# _139, _139, tmp561
# /usr/include/c++/13/bits/random.tcc:1626: 			__v = -__e - __n * __n / 2;
	vfnmadd132sd	.LC45(%rip), %xmm0, %xmm1	#, tmp734, __v
# /usr/include/c++/13/bits/random.tcc:1625: 			__x = std::floor(-__y);
	vrndscalesd	$9, %xmm2, %xmm2, %xmm2	#, tmp559, __x
	jmp	.L915	#
	.p2align 4
	.p2align 3
.L927:
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	movl	%ebp, %eax	# _68, tmp681
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp924
	vmovsd	.LC177(%rip), %xmm0	#, tmp684
# /usr/include/c++/13/bits/random.tcc:1548: 	while (__sum <= __q);
	vmovsd	24(%rsp), %xmm6	# %sfp, _66
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	subl	%r14d, %eax	# __x, tmp681
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vcvtsi2sdl	%eax, %xmm3, %xmm1	# tmp681, tmp924, tmp762
# /usr/include/c++/13/bits/random.tcc:1546: 	    __x += 1;
	leal	1(%r14), %eax	#, __x
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp682, tmp684, tmp683
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vaddsd	16(%rsp), %xmm0, %xmm2	# %sfp, tmp683, __sum
	vmovsd	%xmm2, 16(%rsp)	# __sum, %sfp
# /usr/include/c++/13/bits/random.tcc:1548: 	while (__sum <= __q);
	vcomisd	%xmm2, %xmm6	# __sum, _66
	jnb	.L928	#,
	.p2align 4
	.p2align 3
.L929:
# /usr/include/c++/13/bits/random.tcc:1671: 	    __ret = _IntType(__x) + __z;
	addl	%r12d, %r14d	# _67, <retval>
.L924:
# /usr/include/c++/13/bits/random.tcc:1677: 	if (__p12 != __p)
	vmovsd	88(%rsp), %xmm7	# %sfp, iftmp.153_78
	vucomisd	112(%rsp), %xmm7	# %sfp, iftmp.153_78
	jp	.L952	#,
	jne	.L952	#,
# /usr/include/c++/13/bits/random.tcc:1680:       }
	subq	$-128, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	movl	%r14d, %eax	# <retval>,
	popq	%rbx	#
	.cfi_def_cfa_offset 40
	popq	%rbp	#
	.cfi_def_cfa_offset 32
	popq	%r12	#
	.cfi_def_cfa_offset 24
	popq	%r13	#
	.cfi_def_cfa_offset 16
	popq	%r14	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4
	.p2align 3
.L952:
	.cfi_restore_state
# /usr/include/c++/13/bits/random.tcc:1678: 	  __ret = __t - __ret;
	subl	%r14d, %r13d	# <retval>, _118
# /usr/include/c++/13/bits/random.tcc:1680:       }
	subq	$-128, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 48
# /usr/include/c++/13/bits/random.tcc:1678: 	  __ret = __t - __ret;
	movl	%r13d, %r14d	# _118, <retval>
# /usr/include/c++/13/bits/random.tcc:1680:       }
	popq	%rbx	#
	.cfi_def_cfa_offset 40
	popq	%rbp	#
	.cfi_def_cfa_offset 32
	popq	%r12	#
	.cfi_def_cfa_offset 24
	movl	%r14d, %eax	# <retval>,
	popq	%r13	#
	.cfi_def_cfa_offset 16
	popq	%r14	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4
	.p2align 3
.L966:
	.cfi_restore_state
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	vmovsd	%xmm3, 96(%rsp)	# __sum, %sfp
	vmovsd	%xmm1, 48(%rsp)	# _135, %sfp
	vmovsd	%xmm2, 40(%rsp)	# __y, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rdx	# __urng_87(D)->_M_p, _546
	vmovsd	96(%rsp), %xmm3	# %sfp, __sum
	vmovsd	48(%rsp), %xmm1	# %sfp, _135
	vmovsd	40(%rsp), %xmm2	# %sfp, __y
	jmp	.L897	#
	.p2align 4
	.p2align 3
.L965:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	vmovsd	%xmm2, 40(%rsp)	# __y, %sfp
	vmovsd	%xmm0, 48(%rsp)	# _135, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rax	# __urng_87(D)->_M_p, _148
	vmovsd	48(%rsp), %xmm1	# %sfp, _135
	vmovsd	40(%rsp), %xmm2	# %sfp, __y
	jmp	.L896	#
	.p2align 4
	.p2align 3
.L968:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	vmovsd	%xmm1, 40(%rsp)	# __sum, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rdx	# __urng_87(D)->_M_p, _720
	vmovsd	40(%rsp), %xmm1	# %sfp, __sum
	jmp	.L910	#
	.p2align 4
	.p2align 3
.L967:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rcx	# __urng_87(D)->_M_p, _923
	jmp	.L909	#
	.p2align 4
	.p2align 3
.L970:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	vmovsd	%xmm1, 48(%rsp)	# __sum, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rdx	# __urng_87(D)->_M_p, _662
	vmovsd	48(%rsp), %xmm1	# %sfp, __sum
	jmp	.L913	#
	.p2align 4
	.p2align 3
.L969:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %r14	# __urng_87(D)->_M_p, _749
	jmp	.L912	#
	.p2align 4
	.p2align 3
.L963:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	vmovsd	%xmm1, 48(%rsp)	# __sum, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rdx	# __urng_87(D)->_M_p, _778
	vmovsd	48(%rsp), %xmm1	# %sfp, __sum
	jmp	.L917	#
	.p2align 4
	.p2align 3
.L962:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %r14	# __urng_87(D)->_M_p, _865
	jmp	.L916	#
	.p2align 4
	.p2align 3
.L961:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	vmovsd	%xmm1, 40(%rsp)	# __sum, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rdx	# __urng_87(D)->_M_p, _836
	vmovsd	40(%rsp), %xmm1	# %sfp, __sum
	jmp	.L907	#
	.p2align 4
	.p2align 3
.L960:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rcx	# __urng_87(D)->_M_p, _923
	jmp	.L906	#
	.p2align 4
	.p2align 3
.L889:
# /usr/include/c++/13/bits/random.tcc:1675: 	  __ret = _M_waiting(__urng, __t, __param._M_q);
	vmovsd	16(%rbp), %xmm4	# __param_84(D)->_M_q, _69
# /usr/include/c++/13/bits/random.tcc:1535: 	_IntType __x = 0;
	xorl	%r14d, %r14d	# <retval>
# /usr/include/c++/13/bits/random.tcc:1675: 	  __ret = _M_waiting(__urng, __t, __param._M_q);
	vmovsd	%xmm4, 16(%rsp)	# _69, %sfp
# /usr/include/c++/13/bits/random.tcc:1536: 	double __sum = 0.0;
	movq	$0x000000000, 8(%rsp)	#, %sfp
	jmp	.L938	#
	.p2align 4
	.p2align 3
.L932:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rdx	#, _952
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rax,8), %rax	# __urng_87(D)->_M_x[prephitmp_1067], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp934
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp690
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, 4992(%rbx)	# _952, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp685
	shrq	$11, %rcx	#, tmp685
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp685, _956
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _956, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp686
	salq	$7, %rcx	#, tmp686
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _959
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _959, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp687
	salq	$15, %rcx	#, tmp687
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _962
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _962, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _964
	shrq	$18, %rcx	#, _964
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _964, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm2, %xmm1	# __z, tmp934, tmp763
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm0, %xmm1, %xmm1	# tmp690, tmp689, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _952
	ja	.L973	#,
.L933:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rax	#, tmp691
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp939
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, 4992(%rbx)	# tmp691, __urng_87(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rdx,8), %rax	# __urng_87(D)->_M_x[prephitmp_1070], __z
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp692
	shrq	$11, %rdx	#, tmp692
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp692, _985
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _985, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp693
	salq	$7, %rdx	#, tmp693
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _988
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _988, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp694
	salq	$15, %rdx	#, tmp694
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _991
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _991, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _993
	shrq	$18, %rdx	#, _993
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _993, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm7, %xmm0	# __z, tmp939, tmp764
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vcomisd	.LC10(%rip), %xmm0	#, __ret
	jnb	.L934	#,
# /usr/include/c++/13/bits/random.tcc:1544: 	    const double __e = -std::log(1.0 - __aurng());
	vmovsd	.LC10(%rip), %xmm4	#, tmp940
	vsubsd	%xmm0, %xmm4, %xmm0	# __ret, tmp940, tmp700
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1544: 	    const double __e = -std::log(1.0 - __aurng());
	vxorpd	.LC31(%rip), %xmm0, %xmm0	#, tmp742, __e
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	movl	%r13d, %eax	# _118, tmp704
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp942
# /usr/include/c++/13/bits/random.tcc:1548: 	while (__sum <= __q);
	vmovsd	16(%rsp), %xmm2	# %sfp, _69
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	subl	%r14d, %eax	# <retval>, tmp704
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vcvtsi2sdl	%eax, %xmm7, %xmm1	# tmp704, tmp942, tmp765
# /usr/include/c++/13/bits/random.tcc:1546: 	    __x += 1;
	leal	1(%r14), %eax	#, __x
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp705, __e, tmp706
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vaddsd	8(%rsp), %xmm0, %xmm3	# %sfp, tmp706, __sum
	vmovsd	%xmm3, 8(%rsp)	# __sum, %sfp
# /usr/include/c++/13/bits/random.tcc:1548: 	while (__sum <= __q);
	vcomisd	%xmm3, %xmm2	# __sum, _69
	jb	.L924	#,
.L935:
# /usr/include/c++/13/bits/random.tcc:1546: 	    __x += 1;
	movl	%eax, %r14d	# __x, <retval>
.L938:
# /usr/include/c++/13/bits/random.tcc:1542: 	    if (__t == __x)
	cmpl	%r14d, %r13d	# <retval>, _118
	je	.L924	#,
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	4992(%rbx), %rax	# __urng_87(D)->_M_p, _948
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, _948
	jbe	.L932	#,
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rax	# __urng_87(D)->_M_p, _948
	jmp	.L932	#
	.p2align 4
	.p2align 3
.L973:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	vmovsd	%xmm1, 24(%rsp)	# __sum, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rdx	# __urng_87(D)->_M_p, _952
	vmovsd	24(%rsp), %xmm1	# %sfp, __sum
	jmp	.L933	#
	.p2align 4
	.p2align 3
.L934:
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	movl	%r13d, %eax	# _118, tmp707
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp948
	vmovsd	.LC177(%rip), %xmm0	#, tmp710
# /usr/include/c++/13/bits/random.tcc:1548: 	while (__sum <= __q);
	vmovsd	16(%rsp), %xmm7	# %sfp, _69
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	subl	%r14d, %eax	# <retval>, tmp707
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vcvtsi2sdl	%eax, %xmm4, %xmm1	# tmp707, tmp948, tmp766
# /usr/include/c++/13/bits/random.tcc:1546: 	    __x += 1;
	leal	1(%r14), %eax	#, __x
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp708, tmp710, tmp709
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vaddsd	8(%rsp), %xmm0, %xmm6	# %sfp, tmp709, __sum
	vmovsd	%xmm6, 8(%rsp)	# __sum, %sfp
# /usr/include/c++/13/bits/random.tcc:1548: 	while (__sum <= __q);
	vcomisd	%xmm6, %xmm7	# __sum, _69
	jnb	.L935	#,
	jmp	.L924	#
.L971:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	vmovsd	%xmm2, 40(%rsp)	# __y, %sfp
	vmovsd	%xmm0, 48(%rsp)	# _139, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rax	# __urng_87(D)->_M_p, _600
	vmovsd	48(%rsp), %xmm1	# %sfp, _139
	vmovsd	40(%rsp), %xmm2	# %sfp, __y
	jmp	.L902	#
.L972:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbx, %rdi	# __urng,
	vmovsd	%xmm3, 96(%rsp)	# __sum, %sfp
	vmovsd	%xmm1, 48(%rsp)	# _139, %sfp
	vmovsd	%xmm2, 40(%rsp)	# __y, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rdx	# __urng_87(D)->_M_p, _604
	vmovsd	96(%rsp), %xmm3	# %sfp, __sum
	vmovsd	48(%rsp), %xmm1	# %sfp, _139
	vmovsd	40(%rsp), %xmm2	# %sfp, __y
	jmp	.L903	#
.L948:
	vmovsd	.LC174(%rip), %xmm0	#, _1095
	jmp	.L918	#
.L946:
	vmovsd	.LC174(%rip), %xmm0	#, _1102
	jmp	.L911	#
.L947:
	vmovsd	.LC174(%rip), %xmm0	#, _1110
	jmp	.L914	#
.L945:
	vmovsd	.LC174(%rip), %xmm0	#, _1087
	jmp	.L908	#
.L943:
	vmovsd	.LC174(%rip), %xmm0	#, _1126
	jmp	.L898	#
.L944:
	vmovsd	.LC174(%rip), %xmm0	#, _1118
	jmp	.L904	#
	.cfi_endproc
.LFE10698:
	.size	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE, .-_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE
	