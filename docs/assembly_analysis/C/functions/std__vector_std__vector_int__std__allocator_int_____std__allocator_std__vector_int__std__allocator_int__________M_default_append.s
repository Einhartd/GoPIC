# Function: std::vector<std::vector<int, std::allocator<int> >, std::allocator<std::vector<int, std::allocator<int> > > >::_M_default_append(unsigned long)
# Mangled Symbol: _ZNSt6vectorIS_IiSaIiEESaIS1_EE17_M_default_appendEm
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._ZNSt6vectorIS_IiSaIiEESaIS1_EE17_M_default_appendEm,"axG",@progbits,_ZNSt6vectorIS_IiSaIiEESaIS1_EE17_M_default_appendEm,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIS_IiSaIiEESaIS1_EE17_M_default_appendEm
	.type	_ZNSt6vectorIS_IiSaIiEESaIS1_EE17_M_default_appendEm, @function
_ZNSt6vectorIS_IiSaIiEESaIS1_EE17_M_default_appendEm:
.LFB10553:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/vector.tcc:637:       if (__n != 0)
	testq	%rsi, %rsi	# __n
	je	.L570	#,
# /usr/include/c++/13/bits/vector.tcc:634:     vector<_Tp, _Alloc>::
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	movabsq	$-6148914691236517205, %rdx	#, tmp202
# /usr/include/c++/13/bits/vector.tcc:634:     vector<_Tp, _Alloc>::
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%r15	#
	pushq	%r14	#
	pushq	%r13	#
	pushq	%r12	#
	pushq	%rbx	#
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rdi, %r12	# tmp329, this
	movq	%rsi, %rbx	# tmp330, __n
	andq	$-64, %rsp	#,
	subq	$64, %rsp	#,
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	8(%rdi), %r13	# MEM[(const struct vector *)this_19(D)].D.107139._M_impl.D.106478._M_finish, _27
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	movq	16(%rdi), %rax	# this_19(D)->D.107139._M_impl.D.106478._M_end_of_storage, tmp197
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	(%rdi), %r15	# MEM[(const struct vector *)this_19(D)].D.107139._M_impl.D.106478._M_start, _26
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	subq	%r13, %rax	# _27, tmp197
	sarq	$3, %rax	#, tmp200
	imulq	%rdx, %rax	# tmp202, __navail
# /usr/include/c++/13/bits/vector.tcc:646: 	  if (__navail >= __n)
	cmpq	%rsi, %rax	# __n, __navail
	jb	.L499	#,
	leaq	-1(%rsi), %rax	#, tmp203
	cmpq	$6, %rax	#, tmp203
	jbe	.L527	#,
	movq	%rsi, %rdx	# __n, bnd.1808
	movq	%r13, %rax	# _27, ivtmp.1893
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	vpxor	%xmm0, %xmm0, %xmm0	# tmp209
	shrq	$3, %rdx	#, bnd.1808
	leaq	(%rdx,%rdx,2), %rdx	#, tmp207
	salq	$6, %rdx	#, tmp208
	addq	%r13, %rdx	# _27, _182
	.p2align 4
	.p2align 3
.L501:
	vmovdqu64	%zmm0, (%rax)	# tmp209, MEM <vector(8) long unsigned int> [(int * *)_161]
	addq	$192, %rax	#, ivtmp.1893
	vmovdqu64	%zmm0, -128(%rax)	# tmp209, MEM <vector(8) long unsigned int> [(int * *)_161 + 64B]
	vmovdqu64	%zmm0, -64(%rax)	# tmp209, MEM <vector(8) long unsigned int> [(int * *)_161 + 128B]
	cmpq	%rdx, %rax	# _182, ivtmp.1893
	jne	.L501	#,
	movq	%rbx, %rdx	# __n, niters_vector_mult_vf.1809
	movq	%rbx, %rcx	# __n, tmp.1818
	andq	$-8, %rdx	#, niters_vector_mult_vf.1809
	leaq	(%rdx,%rdx,2), %rax	#, tmp214
	subq	%rdx, %rcx	# niters_vector_mult_vf.1809, tmp.1818
	leaq	0(%r13,%rax,8), %rax	#, tmp.1817
	testb	$7, %bl	#, __n
	je	.L502	#,
.L500:
	movq	%rbx, %rsi	# __n, niters.1814
	subq	%rdx, %rsi	# niters_vector_mult_vf.1809, niters.1814
	leaq	-1(%rsi), %rdi	#, tmp217
	cmpq	$2, %rdi	#, tmp217
	jbe	.L503	#,
	leaq	(%rdx,%rdx,2), %rdx	#, tmp220
	vpxor	%xmm0, %xmm0, %xmm0	# tmp222
	leaq	0(%r13,%rdx,8), %rdx	#, vectp.1820
	vmovdqu	%ymm0, (%rdx)	# tmp222, MEM <vector(4) long unsigned int> [(int * *)vectp.1820_131]
	vmovdqu	%ymm0, 32(%rdx)	# tmp222, MEM <vector(4) long unsigned int> [(int * *)vectp.1820_131 + 32B]
	vmovdqu	%ymm0, 64(%rdx)	# tmp222, MEM <vector(4) long unsigned int> [(int * *)vectp.1820_131 + 64B]
	movq	%rsi, %rdx	# niters.1814, niters_vector_mult_vf.1816
	andq	$-4, %rdx	#, niters_vector_mult_vf.1816
	leaq	(%rdx,%rdx,2), %rdi	#, tmp227
	subq	%rdx, %rcx	# niters_vector_mult_vf.1816, tmp.1818
	andl	$3, %esi	#, niters.1814
	leaq	(%rax,%rdi,8), %rax	#, tmp.1817
	je	.L502	#,
.L503:
	movq	$0, (%rax)	#, MEM[(struct _Vector_impl_data *)__cur_122]._M_start
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 8(%rax)	#, MEM[(struct _Vector_impl_data *)__cur_122]._M_finish
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 16(%rax)	#, MEM[(struct _Vector_impl_data *)__cur_122]._M_end_of_storage
# /usr/include/c++/13/bits/stl_uninitialized.h:642: 	      for (; __n > 0; --__n, (void) ++__cur)
	cmpq	$1, %rcx	#, tmp.1818
	je	.L502	#,
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 24(%rax)	#, MEM[(struct _Vector_impl_data *)__cur_122 + 24B]._M_start
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 32(%rax)	#, MEM[(struct _Vector_impl_data *)__cur_122 + 24B]._M_finish
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 40(%rax)	#, MEM[(struct _Vector_impl_data *)__cur_122 + 24B]._M_end_of_storage
# /usr/include/c++/13/bits/stl_uninitialized.h:642: 	      for (; __n > 0; --__n, (void) ++__cur)
	cmpq	$2, %rcx	#, tmp.1818
	je	.L502	#,
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 48(%rax)	#, MEM[(struct _Vector_impl_data *)__cur_122 + 48B]._M_start
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 56(%rax)	#, MEM[(struct _Vector_impl_data *)__cur_122 + 48B]._M_finish
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 64(%rax)	#, MEM[(struct _Vector_impl_data *)__cur_122 + 48B]._M_end_of_storage
.L502:
# /usr/include/c++/13/bits/vector.tcc:649: 	      this->_M_impl._M_finish =
	leaq	(%rbx,%rbx,2), %rax	#, tmp232
	leaq	0(%r13,%rax,8), %rax	#, tmp234
	movq	%rax, 8(%r12)	# tmp234, this_19(D)->D.107139._M_impl.D.106478._M_finish
	vzeroupper
# /usr/include/c++/13/bits/vector.tcc:710:     }
	leaq	-40(%rbp), %rsp	#,
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.p2align 4
	.p2align 3
.L570:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret	
	.p2align 4
	.p2align 3
.L499:
	.cfi_def_cfa 6, 16
	.cfi_offset 3, -56
	.cfi_offset 6, -16
	.cfi_offset 12, -48
	.cfi_offset 13, -40
	.cfi_offset 14, -32
	.cfi_offset 15, -24
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%r13, %rsi	# _27, _31
	subq	%r15, %rsi	# _26, _31
	movq	%rsi, %rax	# _31, tmp235
	sarq	$3, %rax	#, tmp235
	imulq	%rax, %rdx	# tmp235, tmp236
# /usr/include/c++/13/bits/vector.tcc:643: 	  if (__size > max_size() || __navail > max_size() - __size)
	movabsq	$384307168202282325, %rax	#, tmp239
	subq	%rdx, %rax	# tmp236, tmp238
# /usr/include/c++/13/bits/stl_vector.h:1898: 	if (max_size() - size() < __n)
	cmpq	%rbx, %rax	# __n, tmp238
	jb	.L573	#,
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	leaq	(%rbx,%rdx), %r8	#, _100
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$384307168202282325, %rax	#, tmp333
	cmpq	%rax, %r8	# tmp333, _100
	cmovbe	%r8, %rax	# _100,, _80
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	cmpq	%rbx, %rdx	# __n, tmp236
	jb	.L507	#,
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	leaq	(%rdx,%rdx), %rax	#, _80
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$384307168202282325, %rdx	#, tmp332
	cmpq	%rdx, %rax	# tmp332, _80
	cmova	%rdx, %rax	# _80,, tmp332, _80
.L507:
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	leaq	(%rax,%rax,2), %r14	#, tmp243
	movq	%r8, 48(%rsp)	# _100, %sfp
	movq	%rsi, 56(%rsp)	# _31, %sfp
	salq	$3, %r14	#, tmp244
	movq	%r14, %rdi	# tmp244,
	call	_Znwm@PLT	#
# /usr/include/c++/13/bits/vector.tcc:668: 		      std::__uninitialized_default_n_a(__new_start + __size,
	movq	56(%rsp), %rsi	# %sfp, _31
	movq	48(%rsp), %r8	# %sfp, _100
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %rcx	# tmp331, _86
# /usr/include/c++/13/bits/vector.tcc:668: 		      std::__uninitialized_default_n_a(__new_start + __size,
	leaq	(%rax,%rsi), %rdx	#, tmp.1855
	leaq	-1(%rbx), %rax	#, tmp246
	cmpq	$6, %rax	#, tmp246
	jbe	.L528	#,
	movq	%rbx, %rdi	# __n, bnd.1846
	movq	%rdx, %rax	# tmp.1855, ivtmp.1911
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	vpxor	%xmm0, %xmm0, %xmm0	# tmp252
	shrq	$3, %rdi	#, bnd.1846
	leaq	(%rdi,%rdi,2), %rdi	#, tmp250
	salq	$6, %rdi	#, tmp251
	addq	%rdx, %rdi	# tmp.1855, _232
	.p2align 4
	.p2align 3
.L509:
	vmovdqu64	%zmm0, (%rax)	# tmp252, MEM <vector(8) long unsigned int> [(int * *)_210]
	addq	$192, %rax	#, ivtmp.1911
	vmovdqu64	%zmm0, -128(%rax)	# tmp252, MEM <vector(8) long unsigned int> [(int * *)_210 + 64B]
	vmovdqu64	%zmm0, -64(%rax)	# tmp252, MEM <vector(8) long unsigned int> [(int * *)_210 + 128B]
	cmpq	%rdi, %rax	# _232, ivtmp.1911
	jne	.L509	#,
	movq	%rbx, %rax	# __n, niters_vector_mult_vf.1847
	andq	$-8, %rax	#, niters_vector_mult_vf.1847
	leaq	(%rax,%rax,2), %rdi	#, tmp257
	leaq	(%rdx,%rdi,8), %rdx	#, tmp.1855
	movq	%rbx, %rdi	# __n, tmp.1856
	subq	%rax, %rdi	# niters_vector_mult_vf.1847, tmp.1856
	testb	$7, %bl	#, __n
	je	.L510	#,
.L508:
	subq	%rax, %rbx	# niters_vector_mult_vf.1847, niters.1852
	leaq	-1(%rbx), %r9	#, tmp260
	cmpq	$2, %r9	#, tmp260
	jbe	.L511	#,
	leaq	(%rax,%rax,2), %rax	#, tmp263
	vpxor	%xmm0, %xmm0, %xmm0	# tmp266
	leaq	(%rsi,%rax,8), %rax	#, tmp265
	addq	%rcx, %rax	# _86, vectp.1858
	vmovdqu	%ymm0, (%rax)	# tmp266, MEM <vector(4) long unsigned int> [(int * *)vectp.1858_346]
	vmovdqu	%ymm0, 32(%rax)	# tmp266, MEM <vector(4) long unsigned int> [(int * *)vectp.1858_346 + 32B]
	vmovdqu	%ymm0, 64(%rax)	# tmp266, MEM <vector(4) long unsigned int> [(int * *)vectp.1858_346 + 64B]
	movq	%rbx, %rax	# niters.1852, niters_vector_mult_vf.1854
	andq	$-4, %rax	#, niters_vector_mult_vf.1854
	leaq	(%rax,%rax,2), %rsi	#, tmp271
	subq	%rax, %rdi	# niters_vector_mult_vf.1854, tmp.1856
	andl	$3, %ebx	#, niters.1852
	leaq	(%rdx,%rsi,8), %rdx	#, tmp.1855
	je	.L510	#,
.L511:
	movq	$0, (%rdx)	#, MEM[(struct _Vector_impl_data *)__cur_337]._M_start
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 8(%rdx)	#, MEM[(struct _Vector_impl_data *)__cur_337]._M_finish
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 16(%rdx)	#, MEM[(struct _Vector_impl_data *)__cur_337]._M_end_of_storage
# /usr/include/c++/13/bits/stl_uninitialized.h:642: 	      for (; __n > 0; --__n, (void) ++__cur)
	cmpq	$1, %rdi	#, tmp.1856
	je	.L510	#,
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 24(%rdx)	#, MEM[(struct _Vector_impl_data *)__cur_337 + 24B]._M_start
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 32(%rdx)	#, MEM[(struct _Vector_impl_data *)__cur_337 + 24B]._M_finish
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 40(%rdx)	#, MEM[(struct _Vector_impl_data *)__cur_337 + 24B]._M_end_of_storage
# /usr/include/c++/13/bits/stl_uninitialized.h:642: 	      for (; __n > 0; --__n, (void) ++__cur)
	cmpq	$2, %rdi	#, tmp.1856
	je	.L510	#,
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 48(%rdx)	#, MEM[(struct _Vector_impl_data *)__cur_337 + 48B]._M_start
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 56(%rdx)	#, MEM[(struct _Vector_impl_data *)__cur_337 + 48B]._M_finish
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 64(%rdx)	#, MEM[(struct _Vector_impl_data *)__cur_337 + 48B]._M_end_of_storage
.L510:
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	cmpq	%r13, %r15	# _27, _26
	je	.L520	#,
	leaq	-24(%r13), %rdi	#, tmp274
	movabsq	$768614336404564651, %rax	#, tmp278
	movq	%r15, %rsi	# _26, ivtmp.1903
	subq	%r15, %rdi	# _26, tmp275
	shrq	$3, %rdi	#, tmp276
	imulq	%rax, %rdi	# tmp278, tmp277
	movabsq	$2305843009213693951, %rax	#, tmp279
	andq	%rax, %rdi	# tmp279, _148
	cmpq	$2, %rdi	#, _148
	jbe	.L529	#,
	movq	%rcx, %rax	# _86, tmp281
	movq	%rcx, %rdx	# _86, __cur
	subq	%r15, %rax	# _26, tmp281
	leaq	-8(%rax), %r9	#, tmp282
	movq	%r15, %rax	# _26, __first
	cmpq	$176, %r9	#, tmp282
	ja	.L574	#,
	.p2align 4
	.p2align 3
.L524:
# /usr/include/c++/13/bits/stl_vector.h:106: 	: _M_start(__x._M_start), _M_finish(__x._M_finish),
	vmovdqu	(%rax), %xmm3	# MEM <vector(2) long unsigned int> [(int * *)__first_157], tmp358
# /usr/include/c++/13/bits/stl_vector.h:107: 	  _M_end_of_storage(__x._M_end_of_storage)
	movq	16(%rax), %rsi	# MEM[(int * *)__first_157 + 16B], MEM[(int * *)__first_157 + 16B]
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	addq	$24, %rax	#, __first
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	addq	$24, %rdx	#, __cur
# /usr/include/c++/13/bits/stl_vector.h:107: 	  _M_end_of_storage(__x._M_end_of_storage)
	movq	%rsi, -8(%rdx)	# MEM[(int * *)__first_157 + 16B], MEM[(int * *)__cur_156 + 16B]
# /usr/include/c++/13/bits/stl_vector.h:106: 	: _M_start(__x._M_start), _M_finish(__x._M_finish),
	vmovdqu	%xmm3, -24(%rdx)	# tmp358, MEM <vector(2) long unsigned int> [(int * *)__cur_156]
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	cmpq	%rax, %r13	# __first, _27
	jne	.L524	#,
.L520:
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%r15, %r15	# _26
	je	.L575	#,
# /usr/include/c++/13/bits/vector.tcc:704: 			    this->_M_impl._M_end_of_storage - __old_start);
	movq	16(%r12), %rsi	# this_19(D)->D.107139._M_impl.D.106478._M_end_of_storage, tmp319
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%r15, %rdi	# _26,
	movq	%r8, 48(%rsp)	# _100, %sfp
	movq	%rcx, 56(%rsp)	# _86, %sfp
# /usr/include/c++/13/bits/vector.tcc:704: 			    this->_M_impl._M_end_of_storage - __old_start);
	subq	%r15, %rsi	# _26, tmp319
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	vzeroupper
	call	_ZdlPvm@PLT	#
	movq	48(%rsp), %r8	# %sfp, _100
	movq	56(%rsp), %rcx	# %sfp, _86
.L515:
# /usr/include/c++/13/bits/vector.tcc:706: 	      this->_M_impl._M_finish = __new_start + __size + __n;
	leaq	(%r8,%r8,2), %rax	#, tmp324
# /usr/include/c++/13/bits/vector.tcc:705: 	      this->_M_impl._M_start = __new_start;
	vmovq	%rcx, %xmm2	# _86, _86
# /usr/include/c++/13/bits/vector.tcc:706: 	      this->_M_impl._M_finish = __new_start + __size + __n;
	leaq	(%rcx,%rax,8), %rax	#, tmp326
# /usr/include/c++/13/bits/vector.tcc:707: 	      this->_M_impl._M_end_of_storage = __new_start + __len;
	addq	%r14, %rcx	# tmp244, tmp327
# /usr/include/c++/13/bits/vector.tcc:705: 	      this->_M_impl._M_start = __new_start;
	vpinsrq	$1, %rax, %xmm2, %xmm0	# tmp326, _86, tmp321
# /usr/include/c++/13/bits/vector.tcc:707: 	      this->_M_impl._M_end_of_storage = __new_start + __len;
	movq	%rcx, 16(%r12)	# tmp327, this_19(D)->D.107139._M_impl.D.106478._M_end_of_storage
# /usr/include/c++/13/bits/vector.tcc:705: 	      this->_M_impl._M_start = __new_start;
	vmovdqu	%xmm0, (%r12)	# tmp321, MEM <vector(2) long unsigned int> [(struct vector * *)this_19(D)]
# /usr/include/c++/13/bits/vector.tcc:710:     }
	leaq	-40(%rbp), %rsp	#,
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret	
	.p2align 4
	.p2align 3
.L575:
	.cfi_restore_state
	vzeroupper
	jmp	.L515	#
	.p2align 4
	.p2align 3
.L574:
	leaq	1(%rdi), %r9	#, niters.1821
	cmpq	$6, %rdi	#, _148
	jbe	.L517	#,
	movq	%r9, %rdx	# niters.1821, bnd.1822
	movq	%rcx, %rax	# _86, ivtmp.1906
	shrq	$3, %rdx	#, bnd.1822
	leaq	(%rdx,%rdx,2), %rdx	#, tmp286
	salq	$6, %rdx	#, tmp287
	addq	%r15, %rdx	# _26, _195
	.p2align 4
	.p2align 3
.L518:
# /usr/include/c++/13/bits/stl_vector.h:106: 	: _M_start(__x._M_start), _M_finish(__x._M_finish),
	vmovdqu64	(%rsi), %zmm4	# MEM <vector(8) long unsigned int> [(int * *)_173], tmp349
	vmovdqu64	64(%rsi), %zmm5	# MEM <vector(8) long unsigned int> [(int * *)_173 + 64B], tmp350
	addq	$192, %rsi	#, ivtmp.1903
	addq	$192, %rax	#, ivtmp.1906
	vmovdqu64	-64(%rsi), %zmm6	# MEM <vector(8) long unsigned int> [(int * *)_173 + 128B], tmp351
	vmovdqu64	%zmm4, -192(%rax)	# tmp349, MEM <vector(8) long unsigned int> [(int * *)_176]
	vmovdqu64	%zmm5, -128(%rax)	# tmp350, MEM <vector(8) long unsigned int> [(int * *)_176 + 64B]
	vmovdqu64	%zmm6, -64(%rax)	# tmp351, MEM <vector(8) long unsigned int> [(int * *)_176 + 128B]
	cmpq	%rsi, %rdx	# ivtmp.1903, _195
	jne	.L518	#,
	movq	%r9, %r10	# niters.1821, niters_vector_mult_vf.1823
	andq	$-8, %r10	#, niters_vector_mult_vf.1823
	leaq	(%r10,%r10), %rax	#, tmp328
	leaq	(%rax,%r10), %rdx	#, tmp293
	salq	$3, %rdx	#, tmp294
	leaq	(%rcx,%rdx), %rsi	#, tmp.1836
	addq	%r15, %rdx	# _26, tmp.1837
	andl	$7, %r9d	#, niters.1821
	je	.L520	#,
	subq	%r10, %rdi	# niters_vector_mult_vf.1823, _236
	leaq	1(%rdi), %r9	#, niters.1833
	cmpq	$2, %rdi	#, _236
	jbe	.L522	#,
.L526:
	addq	%r10, %rax	# niters_vector_mult_vf.1823, tmp298
	salq	$3, %rax	#, tmp299
	leaq	(%r15,%rax), %rdi	#, vectp.1839
	addq	%rcx, %rax	# _86, vectp.1844
# /usr/include/c++/13/bits/stl_vector.h:106: 	: _M_start(__x._M_start), _M_finish(__x._M_finish),
	vmovdqu	32(%rdi), %ymm1	# MEM <vector(4) long unsigned int> [(int * *)vectp.1839_269 + 32B], MEM <vector(4) long unsigned int> [(int * *)vectp.1839_269 + 32B]
	vmovdqu	64(%rdi), %ymm0	# MEM <vector(4) long unsigned int> [(int * *)vectp.1839_269 + 64B], MEM <vector(4) long unsigned int> [(int * *)vectp.1839_269 + 64B]
	vmovdqu	(%rdi), %ymm7	# MEM <vector(4) long unsigned int> [(int * *)vectp.1839_269], tmp353
# /usr/include/c++/13/bits/stl_vector.h:106: 	: _M_start(__x._M_start), _M_finish(__x._M_finish),
	vmovdqu	%ymm1, 32(%rax)	# MEM <vector(4) long unsigned int> [(int * *)vectp.1839_269 + 32B], MEM <vector(4) long unsigned int> [(int * *)vectp.1844_278 + 32B]
# /usr/include/c++/13/bits/stl_vector.h:106: 	: _M_start(__x._M_start), _M_finish(__x._M_finish),
	vmovdqu	%ymm7, (%rax)	# tmp353, MEM <vector(4) long unsigned int> [(int * *)vectp.1844_278]
# /usr/include/c++/13/bits/stl_vector.h:106: 	: _M_start(__x._M_start), _M_finish(__x._M_finish),
	vmovdqu	%ymm0, 64(%rax)	# MEM <vector(4) long unsigned int> [(int * *)vectp.1839_269 + 64B], MEM <vector(4) long unsigned int> [(int * *)vectp.1844_278 + 64B]
	movq	%r9, %rax	# niters.1833, niters_vector_mult_vf.1835
	andq	$-4, %rax	#, niters_vector_mult_vf.1835
	leaq	(%rax,%rax,2), %rax	#, tmp306
	salq	$3, %rax	#, tmp307
	addq	%rax, %rsi	# tmp307, tmp.1836
	addq	%rax, %rdx	# tmp307, tmp.1837
	andl	$3, %r9d	#, niters.1833
	je	.L520	#,
.L522:
# /usr/include/c++/13/bits/stl_vector.h:107: 	  _M_end_of_storage(__x._M_end_of_storage)
	movq	16(%rdx), %rax	# MEM[(struct _Vector_impl_data &)__first_260]._M_end_of_storage, MEM[(struct _Vector_impl_data &)__first_260]._M_end_of_storage
# /usr/include/c++/13/bits/stl_vector.h:106: 	: _M_start(__x._M_start), _M_finish(__x._M_finish),
	vmovdqu	(%rdx), %xmm1	# MEM <vector(2) long unsigned int> [(int * *)__first_260], tmp355
# /usr/include/c++/13/bits/stl_vector.h:107: 	  _M_end_of_storage(__x._M_end_of_storage)
	movq	%rax, 16(%rsi)	# MEM[(struct _Vector_impl_data &)__first_260]._M_end_of_storage, MEM[(struct _Vector_impl_data *)__cur_259]._M_end_of_storage
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	leaq	24(%rdx), %rax	#, __first
# /usr/include/c++/13/bits/stl_vector.h:106: 	: _M_start(__x._M_start), _M_finish(__x._M_finish),
	vmovdqu	%xmm1, (%rsi)	# tmp355, MEM <vector(2) long unsigned int> [(int * *)__cur_259]
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	cmpq	%rax, %r13	# __first, _27
	je	.L520	#,
# /usr/include/c++/13/bits/stl_vector.h:107: 	  _M_end_of_storage(__x._M_end_of_storage)
	movq	40(%rdx), %rax	# MEM[(struct _Vector_impl_data &)__first_260 + 24]._M_end_of_storage, MEM[(struct _Vector_impl_data &)__first_260 + 24]._M_end_of_storage
# /usr/include/c++/13/bits/stl_vector.h:106: 	: _M_start(__x._M_start), _M_finish(__x._M_finish),
	vmovdqu	24(%rdx), %xmm7	# MEM <vector(2) long unsigned int> [(int * *)__first_260 + 24B], tmp356
# /usr/include/c++/13/bits/stl_vector.h:107: 	  _M_end_of_storage(__x._M_end_of_storage)
	movq	%rax, 40(%rsi)	# MEM[(struct _Vector_impl_data &)__first_260 + 24]._M_end_of_storage, MEM[(struct _Vector_impl_data *)__cur_259 + 24B]._M_end_of_storage
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	leaq	48(%rdx), %rax	#, __first
# /usr/include/c++/13/bits/stl_vector.h:106: 	: _M_start(__x._M_start), _M_finish(__x._M_finish),
	vmovdqu	%xmm7, 24(%rsi)	# tmp356, MEM <vector(2) long unsigned int> [(int * *)__cur_259 + 24B]
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	cmpq	%rax, %r13	# __first, _27
	je	.L520	#,
# /usr/include/c++/13/bits/stl_vector.h:106: 	: _M_start(__x._M_start), _M_finish(__x._M_finish),
	vmovdqu	48(%rdx), %xmm7	# MEM <vector(2) long unsigned int> [(int * *)__first_260 + 48B], tmp357
# /usr/include/c++/13/bits/stl_vector.h:107: 	  _M_end_of_storage(__x._M_end_of_storage)
	movq	64(%rdx), %rax	# MEM[(struct _Vector_impl_data &)__first_260 + 48]._M_end_of_storage, MEM[(struct _Vector_impl_data &)__first_260 + 48]._M_end_of_storage
	movq	%rax, 64(%rsi)	# MEM[(struct _Vector_impl_data &)__first_260 + 48]._M_end_of_storage, MEM[(struct _Vector_impl_data *)__cur_259 + 48B]._M_end_of_storage
# /usr/include/c++/13/bits/stl_vector.h:106: 	: _M_start(__x._M_start), _M_finish(__x._M_finish),
	vmovdqu	%xmm7, 48(%rsi)	# tmp357, MEM <vector(2) long unsigned int> [(int * *)__cur_259 + 48B]
	jmp	.L520	#
	.p2align 4
	.p2align 3
.L529:
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	movq	%r15, %rax	# _26, __first
	movq	%rcx, %rdx	# _86, __cur
	jmp	.L524	#
	.p2align 4
	.p2align 3
.L527:
# /usr/include/c++/13/bits/vector.tcc:646: 	  if (__navail >= __n)
	movq	%rsi, %rcx	# __n, tmp.1818
# /usr/include/c++/13/bits/stl_uninitialized.h:639: 	  _ForwardIterator __cur = __first;
	movq	%r13, %rax	# _27, tmp.1817
# /usr/include/c++/13/bits/vector.tcc:646: 	  if (__navail >= __n)
	xorl	%edx, %edx	# niters_vector_mult_vf.1809
	jmp	.L500	#
.L528:
# /usr/include/c++/13/bits/vector.tcc:668: 		      std::__uninitialized_default_n_a(__new_start + __size,
	movq	%rbx, %rdi	# __n, tmp.1856
	xorl	%eax, %eax	# niters_vector_mult_vf.1847
	jmp	.L508	#
.L517:
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	movq	%r15, %rdx	# _26, tmp.1837
# /usr/include/c++/13/bits/stl_uninitialized.h:1103:       _ForwardIterator __cur = __result;
	movq	%rcx, %rsi	# _86, tmp.1836
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	xorl	%r10d, %r10d	# niters_vector_mult_vf.1823
	xorl	%eax, %eax	# tmp328
	jmp	.L526	#
.L573:
# /usr/include/c++/13/bits/stl_vector.h:1899: 	  __throw_length_error(__N(__s));
	leaq	.LC144(%rip), %rdi	#, tmp240
	call	_ZSt20__throw_length_errorPKc@PLT	#
	.cfi_endproc
.LFE10553:
	.size	_ZNSt6vectorIS_IiSaIiEESaIS1_EE17_M_default_appendEm, .-_ZNSt6vectorIS_IiSaIiEESaIS1_EE17_M_default_appendEm
	