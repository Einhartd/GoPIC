# Function: std::binomial_distribution<int>::param_type::_M_initialize()
# Mangled Symbol: _ZNSt21binomial_distributionIiE10param_type13_M_initializeEv
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._ZNSt21binomial_distributionIiE10param_type13_M_initializeEv,"axG",@progbits,_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv
	.type	_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv, @function
_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv:
.LFB10890:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx	# tmp237, this
	subq	$120, %rsp	#,
	.cfi_def_cfa_offset 144
# /usr/include/c++/13/bits/random.tcc:1481:       const double __p12 = _M_p <= 0.5 ? _M_p : 1.0 - _M_p;
	vmovsd	8(%rdi), %xmm5	# this_82(D)->_M_p, _1
# /usr/include/c++/13/bits/random.tcc:1481:       const double __p12 = _M_p <= 0.5 ? _M_p : 1.0 - _M_p;
	vmovsd	.LC45(%rip), %xmm0	#, tmp165
	vcomisd	%xmm5, %xmm0	# _1, tmp165
	jnb	.L797	#,
# /usr/include/c++/13/bits/random.tcc:1481:       const double __p12 = _M_p <= 0.5 ? _M_p : 1.0 - _M_p;
	vmovsd	.LC10(%rip), %xmm6	#, tmp260
	vsubsd	%xmm5, %xmm6, %xmm5	# _1, tmp260, _1
.L797:
# /usr/include/c++/13/bits/random.tcc:1486:       if (_M_t * __p12 >= 8)
	movl	(%rbx), %ebp	# this_82(D)->_M_t, _2
# /usr/include/c++/13/bits/random.tcc:1486:       if (_M_t * __p12 >= 8)
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp261
# /usr/include/c++/13/bits/random.tcc:1483:       _M_easy = true;
	movb	$1, 104(%rbx)	#, this_82(D)->_M_easy
# /usr/include/c++/13/bits/random.tcc:1486:       if (_M_t * __p12 >= 8)
	vcvtsi2sdl	%ebp, %xmm4, %xmm0	# _2, tmp261, tmp256
	vmovsd	%xmm0, %xmm0, %xmm7	# tmp256, _3
	vmovsd	%xmm0, 40(%rsp)	# _3, %sfp
	vmulsd	%xmm0, %xmm5, %xmm0	# _3, _1, _4
# /usr/include/c++/13/bits/random.tcc:1486:       if (_M_t * __p12 >= 8)
	vcomisd	.LC153(%rip), %xmm0	#, _4
	jb	.L823	#,
# /usr/include/c++/13/bits/random.tcc:1489: 	  const double __np = std::floor(_M_t * __p12);
	vrndscalesd	$9, %xmm0, %xmm0, %xmm3	#, _4, __np
	vmovsd	%xmm5, (%rsp)	# _1, %sfp
# /usr/include/c++/13/bits/random.tcc:1490: 	  const double __pa = __np / _M_t;
	vdivsd	%xmm7, %xmm3, %xmm6	# _3, __np, __pa
# /usr/include/c++/13/bits/random.tcc:1491: 	  const double __1p = 1 - __pa;
	vmovsd	.LC10(%rip), %xmm5	#, tmp268
# /usr/include/c++/13/bits/random.tcc:1495: 	    std::sqrt(__np * __1p * std::log(32 * __np
	vmulsd	.LC154(%rip), %xmm3, %xmm0	#, __np, tmp169
# /usr/include/c++/13/bits/random.tcc:1491: 	  const double __1p = 1 - __pa;
	vsubsd	%xmm6, %xmm5, %xmm4	# __pa, tmp268, __1p
# /usr/include/c++/13/bits/random.tcc:1488: 	  _M_easy = false;
	movb	$0, 104(%rbx)	#, this_82(D)->_M_easy
# /usr/include/c++/13/bits/random.tcc:1496: 					     / (81 * __pi_4 * __1p)));
	vmulsd	.LC155(%rip), %xmm4, %xmm1	#, __1p, tmp171
# /usr/include/c++/13/bits/random.tcc:1495: 	    std::sqrt(__np * __1p * std::log(32 * __np
	vmulsd	%xmm3, %xmm4, %xmm2	# __np, __1p, _5
# /usr/include/c++/13/bits/random.tcc:1495: 	    std::sqrt(__np * __1p * std::log(32 * __np
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp171, tmp169, tmp173
# /usr/include/c++/13/bits/random.tcc:1489: 	  const double __np = std::floor(_M_t * __p12);
	vmovsd	%xmm3, 8(%rsp)	# __np, %sfp
# /usr/include/c++/13/bits/random.tcc:1490: 	  const double __pa = __np / _M_t;
	vmovsd	%xmm6, 32(%rsp)	# __pa, %sfp
# /usr/include/c++/13/bits/random.tcc:1491: 	  const double __1p = 1 - __pa;
	vmovsd	%xmm4, 16(%rsp)	# __1p, %sfp
# /usr/include/c++/13/bits/random.tcc:1495: 	    std::sqrt(__np * __1p * std::log(32 * __np
	vmovsd	%xmm2, 24(%rsp)	# _5, %sfp
# /usr/include/c++/13/bits/random.tcc:1495: 	    std::sqrt(__np * __1p * std::log(32 * __np
	call	log@PLT	#
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp174
# /usr/include/c++/13/bits/random.tcc:1495: 	    std::sqrt(__np * __1p * std::log(32 * __np
	vmulsd	24(%rsp), %xmm0, %xmm0	# %sfp, tmp238, _10
	vmovsd	(%rsp), %xmm5	# %sfp, _1
	vucomisd	%xmm0, %xmm1	# _10, tmp174
	ja	.L824	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _10, _11
.L802:
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vcomisd	.LC10(%rip), %xmm0	#, _11
	ja	.L830	#,
	movq	.LC10(%rip), %rax	#, tmp281
	vmovq	.LC31(%rip), %xmm3	#, tmp234
	vmovapd	%xmm3, 48(%rsp)	# tmp234, %sfp
	vmovsd	.LC152(%rip), %xmm6	#, _152
	vmovsd	%xmm6, 64(%rsp)	# _152, %sfp
	movq	%rax, (%rsp)	# tmp281, %sfp
.L803:
# /usr/include/c++/13/bits/random.tcc:1499: 	    std::sqrt(__np * __1p * std::log(32 * _M_t * __1p
	sall	$5, %ebp	#, tmp177
	vmovsd	%xmm5, 72(%rsp)	# _1, %sfp
# /usr/include/c++/13/bits/random.tcc:1499: 	    std::sqrt(__np * __1p * std::log(32 * _M_t * __1p
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp284
# /usr/include/c++/13/bits/random.tcc:1497: 	  _M_d1 = std::round(std::max<double>(1.0, __d1x));
	vmovsd	(%rsp), %xmm5	# %sfp, _150
# /usr/include/c++/13/bits/random.tcc:1500: 					     / (__pi_4 * __pa)));
	vmovsd	32(%rsp), %xmm2	# %sfp, __pa
# /usr/include/c++/13/bits/random.tcc:1497: 	  _M_d1 = std::round(std::max<double>(1.0, __d1x));
	vmovsd	%xmm5, 24(%rbx)	# _150, this_82(D)->_M_d1
# /usr/include/c++/13/bits/random.tcc:1500: 					     / (__pi_4 * __pa)));
	vmulsd	.LC156(%rip), %xmm2, %xmm1	#, __pa, tmp180
# /usr/include/c++/13/bits/random.tcc:1499: 	    std::sqrt(__np * __1p * std::log(32 * _M_t * __1p
	vcvtsi2sdl	%ebp, %xmm6, %xmm0	# tmp177, tmp284, tmp257
	vmulsd	16(%rsp), %xmm0, %xmm0	# %sfp, tmp178, tmp179
# /usr/include/c++/13/bits/random.tcc:1499: 	    std::sqrt(__np * __1p * std::log(32 * _M_t * __1p
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp180, tmp179, tmp182
	call	log@PLT	#
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp183
# /usr/include/c++/13/bits/random.tcc:1499: 	    std::sqrt(__np * __1p * std::log(32 * _M_t * __1p
	vmulsd	24(%rsp), %xmm0, %xmm0	# %sfp, tmp241, _20
	vmovsd	72(%rsp), %xmm5	# %sfp, _1
	vucomisd	%xmm0, %xmm1	# _20, tmp183
	ja	.L826	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _20, _21
.L807:
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vcomisd	.LC10(%rip), %xmm0	#, _21
	ja	.L831	#,
	vmovsd	.LC152(%rip), %xmm2	#, _157
	vmovsd	.LC10(%rip), %xmm6	#, _155
	vmovsd	%xmm2, 72(%rsp)	# _157, %sfp
.L808:
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp186
	vmovsd	24(%rsp), %xmm3	# %sfp, _5
# /usr/include/c++/13/bits/random.tcc:1501: 	  _M_d2 = std::round(std::max<double>(1.0, __d2x));
	vmovsd	%xmm6, 32(%rbx)	# _155, this_82(D)->_M_d2
	vucomisd	%xmm3, %xmm0	# _5, tmp186
	ja	.L828	#,
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vsqrtsd	%xmm3, %xmm3, %xmm0	# _5, _126
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmovsd	.LC157(%rip), %xmm1	#, tmp236
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmovsd	(%rsp), %xmm7	# %sfp, _150
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmulsd	8(%rsp), %xmm1, %xmm4	# %sfp, tmp236, tmp187
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vdivsd	%xmm4, %xmm7, %xmm4	# tmp187, _150, tmp189
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vaddsd	.LC10(%rip), %xmm4, %xmm4	#, tmp189, tmp190
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmulsd	%xmm0, %xmm4, %xmm4	# _126, tmp190, _141
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmovsd	%xmm4, 40(%rbx)	# _141, this_82(D)->_M_s1
.L812:
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vmovsd	40(%rsp), %xmm2	# %sfp, _3
	vmulsd	16(%rsp), %xmm2, %xmm3	# %sfp, _3, _30
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vmulsd	%xmm1, %xmm3, %xmm1	# tmp236, _30, tmp197
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vdivsd	%xmm1, %xmm6, %xmm1	# tmp197, _155, tmp199
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vaddsd	.LC10(%rip), %xmm1, %xmm1	#, tmp199, tmp200
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vmulsd	%xmm0, %xmm1, %xmm1	# _126, tmp200, _34
# /usr/include/c++/13/bits/random.tcc:1507: 	  _M_c = 2 * _M_d1 / __np;
	vaddsd	%xmm7, %xmm7, %xmm0	#, _150, tmp202
# /usr/include/c++/13/bits/random.tcc:1507: 	  _M_c = 2 * _M_d1 / __np;
	vdivsd	8(%rsp), %xmm0, %xmm0	# %sfp, tmp202, _36
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vunpcklpd	%xmm0, %xmm1, %xmm2	# _36, _34, tmp203
	vmovsd	%xmm5, 104(%rsp)	# _1, %sfp
	vmovsd	%xmm4, 88(%rsp)	# _141, %sfp
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vmovsd	%xmm3, 80(%rsp)	# _30, %sfp
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vmovupd	%xmm2, 48(%rbx)	# tmp203, MEM <vector(2) double> [(double *)this_82(D) + 48B]
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vmovsd	%xmm6, 96(%rsp)	# _155, %sfp
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vmovsd	%xmm1, 24(%rsp)	# _34, %sfp
# /usr/include/c++/13/bits/random.tcc:1508: 	  _M_a1 = std::exp(_M_c) * _M_s1 * __spi_2;
	call	exp@PLT	#
# /usr/include/c++/13/bits/random.tcc:1509: 	  const double __a12 = _M_a1 + _M_s2 * __spi_2;
	vmovsd	24(%rsp), %xmm1	# %sfp, _34
# /usr/include/c++/13/bits/random.tcc:1508: 	  _M_a1 = std::exp(_M_c) * _M_s1 * __spi_2;
	vmovsd	88(%rsp), %xmm4	# %sfp, _141
# /usr/include/c++/13/bits/random.tcc:1508: 	  _M_a1 = std::exp(_M_c) * _M_s1 * __spi_2;
	vmovsd	.LC158(%rip), %xmm2	#, tmp205
# /usr/include/c++/13/bits/random.tcc:1508: 	  _M_a1 = std::exp(_M_c) * _M_s1 * __spi_2;
	vmulsd	%xmm4, %xmm0, %xmm0	# _141, tmp246, tmp204
# /usr/include/c++/13/bits/random.tcc:1508: 	  _M_a1 = std::exp(_M_c) * _M_s1 * __spi_2;
	vmulsd	%xmm2, %xmm0, %xmm0	# tmp205, tmp204, _39
# /usr/include/c++/13/bits/random.tcc:1509: 	  const double __a12 = _M_a1 + _M_s2 * __spi_2;
	vfmadd132sd	%xmm1, %xmm0, %xmm2	# _34, _39, tmp205
# /usr/include/c++/13/bits/random.tcc:1510: 	  const double __s1s = _M_s1 * _M_s1;
	vmulsd	%xmm4, %xmm4, %xmm4	# _141, _141, __s1s
# /usr/include/c++/13/bits/random.tcc:1509: 	  const double __a12 = _M_a1 + _M_s2 * __spi_2;
	vmovsd	%xmm1, 88(%rsp)	# _34, %sfp
# /usr/include/c++/13/bits/random.tcc:1510: 	  const double __s1s = _M_s1 * _M_s1;
	vmovsd	%xmm4, 24(%rsp)	# __s1s, %sfp
# /usr/include/c++/13/bits/random.tcc:1511: 	  _M_a123 = __a12 + (std::exp(_M_d1 / (_M_t * __1p))
	vmovsd	(%rsp), %xmm6	# %sfp, _150
	vmovsd	80(%rsp), %xmm3	# %sfp, _30
# /usr/include/c++/13/bits/random.tcc:1508: 	  _M_a1 = std::exp(_M_c) * _M_s1 * __spi_2;
	vmovsd	%xmm0, 64(%rbx)	# _39, this_82(D)->_M_a1
# /usr/include/c++/13/bits/random.tcc:1511: 	  _M_a123 = __a12 + (std::exp(_M_d1 / (_M_t * __1p))
	vdivsd	%xmm3, %xmm6, %xmm0	# _30, _150, tmp207
# /usr/include/c++/13/bits/random.tcc:1509: 	  const double __a12 = _M_a1 + _M_s2 * __spi_2;
	vmovsd	%xmm2, 40(%rsp)	# tmp205, %sfp
# /usr/include/c++/13/bits/random.tcc:1511: 	  _M_a123 = __a12 + (std::exp(_M_d1 / (_M_t * __1p))
	call	exp@PLT	#
# /usr/include/c++/13/bits/random.tcc:1513: 			     * std::exp(-_M_d1 * _M_d1 / (2 * __s1s)));
	vmovsd	24(%rsp), %xmm7	# %sfp, __s1s
# /usr/include/c++/13/bits/random.tcc:1513: 			     * std::exp(-_M_d1 * _M_d1 / (2 * __s1s)));
	vmovsd	(%rsp), %xmm6	# %sfp, _150
# /usr/include/c++/13/bits/random.tcc:1513: 			     * std::exp(-_M_d1 * _M_d1 / (2 * __s1s)));
	vaddsd	%xmm7, %xmm7, %xmm3	#, __s1s, tmp209
# /usr/include/c++/13/bits/random.tcc:1511: 	  _M_a123 = __a12 + (std::exp(_M_d1 / (_M_t * __1p))
	vmovsd	%xmm0, 80(%rsp)	# _42, %sfp
# /usr/include/c++/13/bits/random.tcc:1513: 			     * std::exp(-_M_d1 * _M_d1 / (2 * __s1s)));
	vmulsd	64(%rsp), %xmm6, %xmm0	# %sfp, _150, tmp208
# /usr/include/c++/13/bits/random.tcc:1513: 			     * std::exp(-_M_d1 * _M_d1 / (2 * __s1s)));
	vdivsd	%xmm3, %xmm0, %xmm0	# tmp209, tmp208, tmp210
	call	exp@PLT	#
# /usr/include/c++/13/bits/random.tcc:1516: 		  * std::exp(-_M_d2 * _M_d2 / (2 * __s2s)));
	vmovsd	96(%rsp), %xmm6	# %sfp, _155
# /usr/include/c++/13/bits/random.tcc:1512: 			     * 2 * __s1s / _M_d1
	vmovsd	80(%rsp), %xmm2	# %sfp, _42
# /usr/include/c++/13/bits/random.tcc:1514: 	  const double __s2s = _M_s2 * _M_s2;
	vmovsd	88(%rsp), %xmm1	# %sfp, _34
# /usr/include/c++/13/bits/random.tcc:1512: 			     * 2 * __s1s / _M_d1
	vaddsd	%xmm2, %xmm2, %xmm2	# _42, _42, tmp211
# /usr/include/c++/13/bits/random.tcc:1514: 	  const double __s2s = _M_s2 * _M_s2;
	vmulsd	%xmm1, %xmm1, %xmm1	# _34, _34, __s2s
# /usr/include/c++/13/bits/random.tcc:1512: 			     * 2 * __s1s / _M_d1
	vmulsd	24(%rsp), %xmm2, %xmm2	# %sfp, tmp211, tmp212
# /usr/include/c++/13/bits/random.tcc:1515: 	  _M_s = (_M_a123 + 2 * __s2s / _M_d2
	vaddsd	%xmm1, %xmm1, %xmm1	# __s2s, __s2s, _53
# /usr/include/c++/13/bits/random.tcc:1512: 			     * 2 * __s1s / _M_d1
	vdivsd	(%rsp), %xmm2, %xmm2	# %sfp, tmp212, tmp213
# /usr/include/c++/13/bits/random.tcc:1516: 		  * std::exp(-_M_d2 * _M_d2 / (2 * __s2s)));
	vmovsd	%xmm6, 24(%rsp)	# _155, %sfp
# /usr/include/c++/13/bits/random.tcc:1511: 	  _M_a123 = __a12 + (std::exp(_M_d1 / (_M_t * __1p))
	vfmadd213sd	40(%rsp), %xmm0, %xmm2	# %sfp, tmp248, _52
# /usr/include/c++/13/bits/random.tcc:1516: 		  * std::exp(-_M_d2 * _M_d2 / (2 * __s2s)));
	vmovsd	%xmm1, (%rsp)	# _53, %sfp
# /usr/include/c++/13/bits/random.tcc:1516: 		  * std::exp(-_M_d2 * _M_d2 / (2 * __s2s)));
	vmulsd	72(%rsp), %xmm6, %xmm0	# %sfp, _155, tmp215
# /usr/include/c++/13/bits/random.tcc:1511: 	  _M_a123 = __a12 + (std::exp(_M_d1 / (_M_t * __1p))
	vmovsd	%xmm2, 72(%rbx)	# _52, this_82(D)->_M_a123
	vmovsd	%xmm2, 40(%rsp)	# _52, %sfp
# /usr/include/c++/13/bits/random.tcc:1516: 		  * std::exp(-_M_d2 * _M_d2 / (2 * __s2s)));
	vdivsd	%xmm1, %xmm0, %xmm0	# _53, tmp215, tmp216
	call	exp@PLT	#
# /usr/include/c++/13/bits/random.tcc:1515: 	  _M_s = (_M_a123 + 2 * __s2s / _M_d2
	vmovsd	40(%rsp), %xmm2	# %sfp, _52
# /usr/include/c++/13/bits/random.tcc:1515: 	  _M_s = (_M_a123 + 2 * __s2s / _M_d2
	vmovsd	24(%rsp), %xmm6	# %sfp, _155
	vmovsd	(%rsp), %xmm1	# %sfp, _53
	vdivsd	%xmm6, %xmm1, %xmm1	# _155, _53, tmp217
# /usr/include/c++/13/bits/random.tcc:1515: 	  _M_s = (_M_a123 + 2 * __s2s / _M_d2
	vfmadd132sd	%xmm0, %xmm2, %xmm1	# tmp249, _52, _60
# /usr/include/c++/13/bits/random.tcc:1517: 	  _M_lf = (std::lgamma(__np + 1)
	vmovsd	.LC10(%rip), %xmm6	#, tmp310
	vaddsd	8(%rsp), %xmm6, %xmm0	# %sfp, tmp310, tmp218
# /usr/include/c++/13/bits/random.tcc:1515: 	  _M_s = (_M_a123 + 2 * __s2s / _M_d2
	vmovsd	%xmm1, 80(%rbx)	# _60, this_82(D)->_M_s
# /usr/include/c++/13/bits/random.tcc:1517: 	  _M_lf = (std::lgamma(__np + 1)
	call	lgamma@PLT	#
# /usr/include/c++/13/bits/random.tcc:1518: 		   + std::lgamma(_M_t - __np + 1));
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp312
# /usr/include/c++/13/bits/random.tcc:1517: 	  _M_lf = (std::lgamma(__np + 1)
	vmovsd	%xmm0, (%rsp)	# tmp250, %sfp
# /usr/include/c++/13/bits/random.tcc:1518: 		   + std::lgamma(_M_t - __np + 1));
	vcvtsi2sdl	(%rbx), %xmm6, %xmm0	# this_82(D)->_M_t, tmp312, tmp258
	vsubsd	8(%rsp), %xmm0, %xmm0	# %sfp, tmp220, tmp221
# /usr/include/c++/13/bits/random.tcc:1518: 		   + std::lgamma(_M_t - __np + 1));
	vaddsd	.LC10(%rip), %xmm0, %xmm0	#, tmp221, tmp222
	call	lgamma@PLT	#
# /usr/include/c++/13/bits/random.tcc:1519: 	  _M_lp1p = std::log(__pa / __1p);
	vmovsd	32(%rsp), %xmm7	# %sfp, __pa
# /usr/include/c++/13/bits/random.tcc:1518: 		   + std::lgamma(_M_t - __np + 1));
	vaddsd	(%rsp), %xmm0, %xmm0	# %sfp, tmp251, tmp224
# /usr/include/c++/13/bits/random.tcc:1517: 	  _M_lf = (std::lgamma(__np + 1)
	vmovsd	%xmm0, 88(%rbx)	# tmp224, this_82(D)->_M_lf
# /usr/include/c++/13/bits/random.tcc:1519: 	  _M_lp1p = std::log(__pa / __1p);
	vdivsd	16(%rsp), %xmm7, %xmm0	# %sfp, __pa, tmp225
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1521: 	  _M_q = -std::log(1 - (__p12 - __pa) / __1p);
	vmovsd	104(%rsp), %xmm5	# %sfp, _1
# /usr/include/c++/13/bits/random.tcc:1519: 	  _M_lp1p = std::log(__pa / __1p);
	vmovsd	%xmm0, 96(%rbx)	# tmp252, this_82(D)->_M_lp1p
# /usr/include/c++/13/bits/random.tcc:1521: 	  _M_q = -std::log(1 - (__p12 - __pa) / __1p);
	vsubsd	32(%rsp), %xmm5, %xmm0	# %sfp, _1, tmp226
# /usr/include/c++/13/bits/random.tcc:1521: 	  _M_q = -std::log(1 - (__p12 - __pa) / __1p);
	vmovsd	.LC10(%rip), %xmm5	#, tmp319
# /usr/include/c++/13/bits/random.tcc:1521: 	  _M_q = -std::log(1 - (__p12 - __pa) / __1p);
	vdivsd	16(%rsp), %xmm0, %xmm0	# %sfp, tmp226, tmp227
# /usr/include/c++/13/bits/random.tcc:1521: 	  _M_q = -std::log(1 - (__p12 - __pa) / __1p);
	vsubsd	%xmm0, %xmm5, %xmm0	# tmp227, tmp319, tmp228
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1521: 	  _M_q = -std::log(1 - (__p12 - __pa) / __1p);
	vxorpd	48(%rsp), %xmm0, %xmm0	# %sfp, tmp253, _75
	vmovsd	%xmm0, 16(%rbx)	# _75, this_82(D)->_M_q
# /usr/include/c++/13/bits/random.tcc:1526:     }
	addq	$120, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4
	.p2align 3
.L823:
	.cfi_restore_state
# /usr/include/c++/13/bits/random.tcc:1525: 	_M_q = -std::log(1 - __p12);
	vmovsd	.LC10(%rip), %xmm2	#, tmp321
	vsubsd	%xmm5, %xmm2, %xmm0	# _1, tmp321, tmp231
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1525: 	_M_q = -std::log(1 - __p12);
	vxorpd	.LC31(%rip), %xmm0, %xmm0	#, tmp254, _75
# /usr/include/c++/13/bits/random.tcc:1521: 	  _M_q = -std::log(1 - (__p12 - __pa) / __1p);
	vmovsd	%xmm0, 16(%rbx)	# _75, this_82(D)->_M_q
# /usr/include/c++/13/bits/random.tcc:1526:     }
	addq	$120, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4
	.p2align 3
.L831:
	.cfi_restore_state
	vmovsd	%xmm5, 80(%rsp)	# _1, %sfp
# /usr/include/c++/13/bits/random.tcc:1501: 	  _M_d2 = std::round(std::max<double>(1.0, __d2x));
	call	round@PLT	#
	vmovsd	80(%rsp), %xmm5	# %sfp, _1
	vmovsd	%xmm0, %xmm0, %xmm6	# tmp243, _155
# /usr/include/c++/13/bits/random.tcc:1516: 		  * std::exp(-_M_d2 * _M_d2 / (2 * __s2s)));
	vxorpd	48(%rsp), %xmm6, %xmm3	# %sfp, _155, _157
	vmovsd	%xmm3, 72(%rsp)	# _157, %sfp
	jmp	.L808	#
	.p2align 4
	.p2align 3
.L830:
	vmovsd	%xmm5, 72(%rsp)	# _1, %sfp
# /usr/include/c++/13/bits/random.tcc:1497: 	  _M_d1 = std::round(std::max<double>(1.0, __d1x));
	call	round@PLT	#
# /usr/include/c++/13/bits/random.tcc:1513: 			     * std::exp(-_M_d1 * _M_d1 / (2 * __s1s)));
	vmovq	.LC31(%rip), %xmm5	#, tmp234
	vmovapd	%xmm5, 48(%rsp)	# tmp234, %sfp
# /usr/include/c++/13/bits/random.tcc:1497: 	  _M_d1 = std::round(std::max<double>(1.0, __d1x));
	vmovsd	%xmm0, %xmm0, %xmm6	# tmp240, _150
# /usr/include/c++/13/bits/random.tcc:1513: 			     * std::exp(-_M_d1 * _M_d1 / (2 * __s1s)));
	vxorpd	%xmm5, %xmm6, %xmm4	# tmp234, _150, _152
# /usr/include/c++/13/bits/random.tcc:1497: 	  _M_d1 = std::round(std::max<double>(1.0, __d1x));
	vmovsd	%xmm0, (%rsp)	# _150, %sfp
	vmovsd	72(%rsp), %xmm5	# %sfp, _1
# /usr/include/c++/13/bits/random.tcc:1513: 			     * std::exp(-_M_d1 * _M_d1 / (2 * __s1s)));
	vmovsd	%xmm4, 64(%rsp)	# _152, %sfp
	jmp	.L803	#
.L824:
	vmovsd	%xmm5, (%rsp)	# _1, %sfp
# /usr/include/c++/13/bits/random.tcc:1495: 	    std::sqrt(__np * __1p * std::log(32 * __np
	call	sqrt@PLT	#
	vmovsd	(%rsp), %xmm5	# %sfp, _1
	jmp	.L802	#
.L826:
	vmovsd	%xmm5, 72(%rsp)	# _1, %sfp
# /usr/include/c++/13/bits/random.tcc:1499: 	    std::sqrt(__np * __1p * std::log(32 * _M_t * __1p
	call	sqrt@PLT	#
	vmovsd	72(%rsp), %xmm5	# %sfp, _1
	jmp	.L807	#
.L828:
	vmovsd	%xmm6, 104(%rsp)	# _155, %sfp
	vmovsd	%xmm5, 96(%rsp)	# _1, %sfp
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmovsd	24(%rsp), %xmm0	# %sfp,
	call	sqrt@PLT	#
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmovsd	.LC157(%rip), %xmm1	#, tmp236
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmovsd	(%rsp), %xmm5	# %sfp, _150
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmulsd	8(%rsp), %xmm1, %xmm4	# %sfp, tmp236, tmp192
	vmovsd	%xmm1, 88(%rsp)	# tmp236, %sfp
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vdivsd	%xmm4, %xmm5, %xmm4	# tmp192, _150, tmp194
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vaddsd	.LC10(%rip), %xmm4, %xmm4	#, tmp194, tmp195
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmulsd	%xmm0, %xmm4, %xmm4	# tmp244, tmp195, _141
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vmovsd	24(%rsp), %xmm0	# %sfp,
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmovsd	%xmm4, 40(%rbx)	# _141, this_82(D)->_M_s1
	vmovsd	%xmm4, 80(%rsp)	# _141, %sfp
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	call	sqrt@PLT	#
	vmovsd	104(%rsp), %xmm6	# %sfp, _155
	vmovsd	96(%rsp), %xmm5	# %sfp, _1
	vmovsd	88(%rsp), %xmm1	# %sfp, tmp236
	vmovsd	80(%rsp), %xmm4	# %sfp, _141
	vmovsd	(%rsp), %xmm7	# %sfp, _150
	jmp	.L812	#
	.cfi_endproc
.LFE10890:
	.size	_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv, .-_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv
	