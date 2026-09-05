# Function: std::mersenne_twister_engine<unsigned long, 32ul, 624ul, 397ul, 31ul, 2567483615ul, 11ul, 4294967295ul, 7ul, 2636928640ul, 15ul, 4022730752ul, 18ul, 1812433253ul>::_M_gen_rand()
# Mangled Symbol: _ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv,"axG",@progbits,_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv
	.type	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv, @function
_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv:
.LFB11144:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.tcc:406: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	movq	$-2147483648, %rcx	#, tmp177
# /usr/include/c++/13/bits/random.tcc:397:     mersenne_twister_engine<_UIntType, __w, __n, __m, __r, __a, __u, __d,
	movq	%rdi, %rdx	# tmp281, this
	leaq	1792(%rdi), %rsi	#, _195
	movq	%rdi, %rax	# this, ivtmp.2201
# /usr/include/c++/13/bits/random.tcc:406: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	vpbroadcastq	%rcx, %zmm5	# tmp177, tmp176
# /usr/include/c++/13/bits/random.tcc:407: 			   | (_M_x[__k + 1] & __lower_mask));
	movl	$2147483647, %ecx	#, tmp182
# /usr/include/c++/13/bits/random.tcc:408: 	  _M_x[__k] = (_M_x[__k + __m] ^ (__y >> 1)
	vpxor	%xmm6, %xmm6, %xmm6	# tmp191
# /usr/include/c++/13/bits/random.tcc:407: 			   | (_M_x[__k + 1] & __lower_mask));
	vpbroadcastq	%rcx, %zmm4	# tmp182, tmp181
# /usr/include/c++/13/bits/random.tcc:409: 		       ^ ((__y & 0x01) ? __a : 0));
	movl	$1, %ecx	#, tmp189
	vpbroadcastq	%rcx, %zmm3	# tmp189, tmp188
# /usr/include/c++/13/bits/random.tcc:408: 	  _M_x[__k] = (_M_x[__k + __m] ^ (__y >> 1)
	movl	$2567483615, %ecx	#, tmp195
	vpbroadcastq	%rcx, %zmm2	# tmp195, tmp194
	.p2align 4
	.p2align 3
.L833:
# /usr/include/c++/13/bits/random.tcc:407: 			   | (_M_x[__k + 1] & __lower_mask));
	vpandq	8(%rax), %zmm4, %zmm0	# MEM <vector(8) long unsigned int> [(long unsigned int *)_103 + 8B], tmp181, vect__5.2171
	addq	$64, %rax	#, ivtmp.2201
# /usr/include/c++/13/bits/random.tcc:406: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	vpternlogq	$248, -64(%rax), %zmm5, %zmm0	#, MEM <vector(8) long unsigned int> [(long unsigned int *)_103], tmp176, vect___y_46.2172
# /usr/include/c++/13/bits/random.tcc:408: 	  _M_x[__k] = (_M_x[__k + __m] ^ (__y >> 1)
	vpsrlq	$1, %zmm0, %zmm1	#, vect___y_46.2172, vect__8.2176
# /usr/include/c++/13/bits/random.tcc:409: 		       ^ ((__y & 0x01) ? __a : 0));
	vpandq	%zmm3, %zmm0, %zmm0	# tmp188, vect___y_46.2172, vect__10.2178
# /usr/include/c++/13/bits/random.tcc:408: 	  _M_x[__k] = (_M_x[__k + __m] ^ (__y >> 1)
	vpsubq	%zmm0, %zmm6, %zmm0	# vect__10.2178, tmp191, vect__98.2179
	vpandq	%zmm2, %zmm0, %zmm0	# tmp194, vect__98.2179, vect__99.2180
	vpternlogq	$150, 3112(%rax), %zmm1, %zmm0	#, MEM <vector(8) long unsigned int> [(long unsigned int *)_103 + 3176B], vect__8.2176, vect_prephitmp_86.2181
	vmovdqu64	%zmm0, -64(%rax)	# vect_prephitmp_86.2181, MEM <vector(8) long unsigned int> [(long unsigned int *)_103]
	cmpq	%rsi, %rax	# _195, ivtmp.2201
	jne	.L833	#,
# /usr/include/c++/13/bits/random.tcc:407: 			   | (_M_x[__k + 1] & __lower_mask));
	movq	1800(%rdx), %rax	# this_40(D)->_M_x[225], _7
# /usr/include/c++/13/bits/random.tcc:406: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	movq	1792(%rdx), %rcx	# MEM[(long unsigned int *)this_40(D) + 1792B], tmp197
# /usr/include/c++/13/bits/random.tcc:414: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	movq	$-2147483648, %r9	#, tmp227
# /usr/include/c++/13/bits/random.tcc:417: 		       ^ ((__y & 0x01) ? __a : 0));
	movl	$1, %r8d	#, tmp239
# /usr/include/c++/13/bits/random.tcc:416: 	  _M_x[__k] = (_M_x[__k + (__m - __n)] ^ (__y >> 1)
	movl	$2567483615, %edi	#, tmp245
# /usr/include/c++/13/bits/random.tcc:414: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	vpbroadcastq	%r9, %zmm6	# tmp227, tmp226
# /usr/include/c++/13/bits/random.tcc:417: 		       ^ ((__y & 0x01) ? __a : 0));
	vpbroadcastq	%r8, %zmm4	# tmp239, tmp238
# /usr/include/c++/13/bits/random.tcc:416: 	  _M_x[__k] = (_M_x[__k + (__m - __n)] ^ (__y >> 1)
	vpbroadcastq	%rdi, %zmm2	# tmp245, tmp244
	vpxor	%xmm3, %xmm3, %xmm3	# tmp241
# /usr/include/c++/13/bits/random.tcc:407: 			   | (_M_x[__k + 1] & __lower_mask));
	movq	%rax, %rsi	# _7, tmp199
# /usr/include/c++/13/bits/random.tcc:406: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	andq	$-2147483648, %rcx	#, tmp197
	andq	$-2147483648, %rax	#, tmp206
# /usr/include/c++/13/bits/random.tcc:407: 			   | (_M_x[__k + 1] & __lower_mask));
	andl	$2147483647, %esi	#, tmp199
# /usr/include/c++/13/bits/random.tcc:406: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	orq	%rsi, %rcx	# tmp199, __y
# /usr/include/c++/13/bits/random.tcc:408: 	  _M_x[__k] = (_M_x[__k + __m] ^ (__y >> 1)
	movq	%rcx, %rsi	# __y, tmp200
# /usr/include/c++/13/bits/random.tcc:409: 		       ^ ((__y & 0x01) ? __a : 0));
	andl	$1, %ecx	#, tmp202
# /usr/include/c++/13/bits/random.tcc:408: 	  _M_x[__k] = (_M_x[__k + __m] ^ (__y >> 1)
	shrq	%rsi	# tmp200
# /usr/include/c++/13/bits/random.tcc:408: 	  _M_x[__k] = (_M_x[__k + __m] ^ (__y >> 1)
	xorq	4968(%rdx), %rsi	# this_40(D)->_M_x[621], tmp201
# /usr/include/c++/13/bits/random.tcc:409: 		       ^ ((__y & 0x01) ? __a : 0));
	negq	%rcx	# tmp203
	andl	$2567483615, %ecx	#, tmp204
	xorq	%rsi, %rcx	# tmp201, tmp205
	movq	%rcx, 1792(%rdx)	# tmp205, this_40(D)->_M_x[224]
# /usr/include/c++/13/bits/random.tcc:407: 			   | (_M_x[__k + 1] & __lower_mask));
	movq	1808(%rdx), %rcx	# this_40(D)->_M_x[226], _20
# /usr/include/c++/13/bits/random.tcc:407: 			   | (_M_x[__k + 1] & __lower_mask));
	movq	%rcx, %rsi	# _20, tmp207
# /usr/include/c++/13/bits/random.tcc:406: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	andq	$-2147483648, %rcx	#, tmp216
# /usr/include/c++/13/bits/random.tcc:407: 			   | (_M_x[__k + 1] & __lower_mask));
	andl	$2147483647, %esi	#, tmp207
# /usr/include/c++/13/bits/random.tcc:406: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	orq	%rsi, %rax	# tmp207, __y
# /usr/include/c++/13/bits/random.tcc:408: 	  _M_x[__k] = (_M_x[__k + __m] ^ (__y >> 1)
	movq	%rax, %rsi	# __y, tmp208
# /usr/include/c++/13/bits/random.tcc:409: 		       ^ ((__y & 0x01) ? __a : 0));
	andl	$1, %eax	#, tmp210
# /usr/include/c++/13/bits/random.tcc:408: 	  _M_x[__k] = (_M_x[__k + __m] ^ (__y >> 1)
	shrq	%rsi	# tmp208
# /usr/include/c++/13/bits/random.tcc:408: 	  _M_x[__k] = (_M_x[__k + __m] ^ (__y >> 1)
	xorq	4976(%rdx), %rsi	# this_40(D)->_M_x[622], tmp209
# /usr/include/c++/13/bits/random.tcc:409: 		       ^ ((__y & 0x01) ? __a : 0));
	negq	%rax	# tmp211
	andl	$2567483615, %eax	#, tmp212
	xorq	%rsi, %rax	# tmp209, tmp213
	leaq	4952(%rdx), %rsi	#, _17
	movq	%rax, 1800(%rdx)	# tmp213, this_40(D)->_M_x[225]
# /usr/include/c++/13/bits/random.tcc:407: 			   | (_M_x[__k + 1] & __lower_mask));
	movq	1816(%rdx), %rax	# this_40(D)->_M_x[227], tmp214
	andl	$2147483647, %eax	#, tmp214
# /usr/include/c++/13/bits/random.tcc:406: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	orq	%rax, %rcx	# tmp214, __y
# /usr/include/c++/13/bits/random.tcc:409: 		       ^ ((__y & 0x01) ? __a : 0));
	andl	$1, %eax	#, tmp217
# /usr/include/c++/13/bits/random.tcc:408: 	  _M_x[__k] = (_M_x[__k + __m] ^ (__y >> 1)
	shrq	%rcx	# tmp220
# /usr/include/c++/13/bits/random.tcc:408: 	  _M_x[__k] = (_M_x[__k + __m] ^ (__y >> 1)
	xorq	4984(%rdx), %rcx	# this_40(D)->_M_x[623], tmp221
# /usr/include/c++/13/bits/random.tcc:409: 		       ^ ((__y & 0x01) ? __a : 0));
	negq	%rax	# tmp218
	andl	$2567483615, %eax	#, tmp219
	xorq	%rcx, %rax	# tmp221, tmp222
# /usr/include/c++/13/bits/random.tcc:415: 			   | (_M_x[__k + 1] & __lower_mask));
	movl	$2147483647, %ecx	#, tmp232
	vpbroadcastq	%rcx, %zmm5	# tmp232, tmp231
# /usr/include/c++/13/bits/random.tcc:409: 		       ^ ((__y & 0x01) ? __a : 0));
	movq	%rax, 1808(%rdx)	# tmp222, this_40(D)->_M_x[226]
	leaq	1816(%rdx), %rax	#, ivtmp.2191
	.p2align 4
	.p2align 3
.L834:
# /usr/include/c++/13/bits/random.tcc:415: 			   | (_M_x[__k + 1] & __lower_mask));
	vpandq	8(%rax), %zmm5, %zmm0	# MEM <vector(8) long unsigned int> [(long unsigned int *)_8 + 8B], tmp231, vect__16.2129
	addq	$64, %rax	#, ivtmp.2191
# /usr/include/c++/13/bits/random.tcc:414: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	vpternlogq	$248, -64(%rax), %zmm6, %zmm0	#, MEM <vector(8) long unsigned int> [(long unsigned int *)_8], tmp226, vect___y_44.2130
# /usr/include/c++/13/bits/random.tcc:416: 	  _M_x[__k] = (_M_x[__k + (__m - __n)] ^ (__y >> 1)
	vpsrlq	$1, %zmm0, %zmm1	#, vect___y_44.2130, vect__19.2134
# /usr/include/c++/13/bits/random.tcc:417: 		       ^ ((__y & 0x01) ? __a : 0));
	vpandq	%zmm4, %zmm0, %zmm0	# tmp238, vect___y_44.2130, vect__21.2136
# /usr/include/c++/13/bits/random.tcc:416: 	  _M_x[__k] = (_M_x[__k + (__m - __n)] ^ (__y >> 1)
	vpsubq	%zmm0, %zmm3, %zmm0	# vect__21.2136, tmp241, vect__61.2137
	vpandq	%zmm2, %zmm0, %zmm0	# tmp244, vect__61.2137, vect__60.2138
	vpternlogq	$150, -1880(%rax), %zmm1, %zmm0	#, MEM <vector(8) long unsigned int> [(long unsigned int *)_8 + -1816B], vect__19.2134, vect_prephitmp_89.2139
	vmovdqu64	%zmm0, -64(%rax)	# vect_prephitmp_89.2139, MEM <vector(8) long unsigned int> [(long unsigned int *)_8]
	cmpq	%rax, %rsi	# ivtmp.2191, _17
	jne	.L834	#,
# /usr/include/c++/13/bits/random.tcc:420:       _UIntType __y = ((_M_x[__n - 1] & __upper_mask)
	movq	4984(%rdx), %rax	# this_40(D)->_M_x[623], tmp271
# /usr/include/c++/13/bits/random.tcc:415: 			   | (_M_x[__k + 1] & __lower_mask));
	vpbroadcastq	%rcx, %ymm0	# tmp232, tmp255
# /usr/include/c++/13/bits/random.tcc:421: 		       | (_M_x[0] & __lower_mask));
	movq	(%rdx), %rcx	# this_40(D)->_M_x[0], tmp273
# /usr/include/c++/13/bits/random.tcc:415: 			   | (_M_x[__k + 1] & __lower_mask));
	vpand	4960(%rdx), %ymm0, %ymm0	# MEM <vector(4) long unsigned int> [(long unsigned int *)this_40(D) + 4960B], tmp255, vect__103.2149
# /usr/include/c++/13/bits/random.tcc:414: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	vpbroadcastq	%r9, %ymm1	# tmp227, tmp250
# /usr/include/c++/13/bits/random.tcc:424:       _M_p = 0;
	movq	$0, 4992(%rdx)	#, this_40(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:421: 		       | (_M_x[0] & __lower_mask));
	andl	$2147483647, %ecx	#, tmp273
# /usr/include/c++/13/bits/random.tcc:420:       _UIntType __y = ((_M_x[__n - 1] & __upper_mask)
	andq	$-2147483648, %rax	#, tmp271
# /usr/include/c++/13/bits/random.tcc:420:       _UIntType __y = ((_M_x[__n - 1] & __upper_mask)
	orq	%rcx, %rax	# tmp273, __y
# /usr/include/c++/13/bits/random.tcc:414: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	vpternlogq	$248, 4952(%rdx), %ymm1, %ymm0	#, MEM <vector(4) long unsigned int> [(long unsigned int *)this_40(D) + 4952B], tmp250, vect___y_104.2150
# /usr/include/c++/13/bits/random.tcc:417: 		       ^ ((__y & 0x01) ? __a : 0));
	vpbroadcastq	%r8, %ymm1	# tmp239, tmp262
# /usr/include/c++/13/bits/random.tcc:422:       _M_x[__n - 1] = (_M_x[__m - 1] ^ (__y >> 1)
	movq	%rax, %rcx	# __y, tmp275
# /usr/include/c++/13/bits/random.tcc:416: 	  _M_x[__k] = (_M_x[__k + (__m - __n)] ^ (__y >> 1)
	vpsrlq	$1, %ymm0, %ymm2	#, vect___y_104.2150, vect__107.2154
# /usr/include/c++/13/bits/random.tcc:417: 		       ^ ((__y & 0x01) ? __a : 0));
	vpand	%ymm1, %ymm0, %ymm0	# tmp262, vect___y_104.2150, vect__109.2156
# /usr/include/c++/13/bits/random.tcc:423: 		       ^ ((__y & 0x01) ? __a : 0));
	andl	$1, %eax	#, tmp277
# /usr/include/c++/13/bits/random.tcc:422:       _M_x[__n - 1] = (_M_x[__m - 1] ^ (__y >> 1)
	shrq	%rcx	# tmp275
# /usr/include/c++/13/bits/random.tcc:416: 	  _M_x[__k] = (_M_x[__k + (__m - __n)] ^ (__y >> 1)
	vpxor	%xmm1, %xmm1, %xmm1	# tmp265
	vpsubq	%ymm0, %ymm1, %ymm0	# vect__109.2156, tmp265, vect__110.2157
	vpbroadcastq	%rdi, %ymm1	# tmp245, tmp268
# /usr/include/c++/13/bits/random.tcc:422:       _M_x[__n - 1] = (_M_x[__m - 1] ^ (__y >> 1)
	xorq	3168(%rdx), %rcx	# this_40(D)->_M_x[396], tmp276
# /usr/include/c++/13/bits/random.tcc:416: 	  _M_x[__k] = (_M_x[__k + (__m - __n)] ^ (__y >> 1)
	vpand	%ymm1, %ymm0, %ymm0	# tmp268, vect__110.2157, vect__111.2158
# /usr/include/c++/13/bits/random.tcc:423: 		       ^ ((__y & 0x01) ? __a : 0));
	negq	%rax	# tmp278
# /usr/include/c++/13/bits/random.tcc:416: 	  _M_x[__k] = (_M_x[__k + (__m - __n)] ^ (__y >> 1)
	vpternlogq	$150, 3136(%rdx), %ymm2, %ymm0	#, MEM <vector(4) long unsigned int> [(long unsigned int *)this_40(D) + 3136B], vect__107.2154, vect_prephitmp_112.2159
# /usr/include/c++/13/bits/random.tcc:423: 		       ^ ((__y & 0x01) ? __a : 0));
	andl	$2567483615, %eax	#, tmp279
# /usr/include/c++/13/bits/random.tcc:416: 	  _M_x[__k] = (_M_x[__k + (__m - __n)] ^ (__y >> 1)
	vmovdqu	%ymm0, 4952(%rdx)	# vect_prephitmp_112.2159, MEM <vector(4) long unsigned int> [(long unsigned int *)this_40(D) + 4952B]
# /usr/include/c++/13/bits/random.tcc:423: 		       ^ ((__y & 0x01) ? __a : 0));
	xorq	%rcx, %rax	# tmp276, tmp280
	movq	%rax, 4984(%rdx)	# tmp280, this_40(D)->_M_x[623]
	vzeroupper
# /usr/include/c++/13/bits/random.tcc:425:     }
	ret	
	.cfi_endproc
.LFE11144:
	.size	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv, .-_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv
	