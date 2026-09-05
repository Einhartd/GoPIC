# Function: std::vector<AlignedThreadCounters, std::allocator<AlignedThreadCounters> >::_M_default_append(unsigned long)
# Mangled Symbol: _ZNSt6vectorI21AlignedThreadCountersSaIS0_EE17_M_default_appendEm
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._ZNSt6vectorI21AlignedThreadCountersSaIS0_EE17_M_default_appendEm,"axG",@progbits,_ZNSt6vectorI21AlignedThreadCountersSaIS0_EE17_M_default_appendEm,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorI21AlignedThreadCountersSaIS0_EE17_M_default_appendEm
	.type	_ZNSt6vectorI21AlignedThreadCountersSaIS0_EE17_M_default_appendEm, @function
_ZNSt6vectorI21AlignedThreadCountersSaIS0_EE17_M_default_appendEm:
.LFB10546:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/vector.tcc:637:       if (__n != 0)
	testq	%rsi, %rsi	# __n
	je	.L492	#,
# /usr/include/c++/13/bits/vector.tcc:634:     vector<_Tp, _Alloc>::
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
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
	movq	%rdi, %r15	# tmp138, this
	movq	%rsi, %r12	# tmp139, __n
	subq	$24, %rsp	#,
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	8(%rdi), %rbx	# MEM[(const struct vector *)this_19(D)].D.106084._M_impl.D.105423._M_finish, __cur
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	movq	16(%rdi), %rax	# this_19(D)->D.106084._M_impl.D.105423._M_end_of_storage, tmp116
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	(%rdi), %r8	# MEM[(const struct vector *)this_19(D)].D.106084._M_impl.D.105423._M_start, _26
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	subq	%rbx, %rax	# __cur, tmp116
	sarq	$6, %rax	#, __navail
# /usr/include/c++/13/bits/vector.tcc:646: 	  if (__navail >= __n)
	cmpq	%rsi, %rax	# __n, __navail
	jb	.L472	#,
	salq	$6, %r12	#, tmp120
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	vpxor	%xmm0, %xmm0, %xmm0	# tmp122
	addq	%rbx, %r12	# __cur, _14
	.p2align 4
	.p2align 3
.L473:
	vmovdqu	%ymm0, 8(%rbx)	# tmp122, MEM <vector(4) long long unsigned int> [(long long unsigned int *)__cur_45 + 8B]
	movq	$0x000000000, (%rbx)	#, MEM[(double *)__cur_45]
	movq	$0, 40(%rbx)	#, MEM[(long long unsigned int *)__cur_45 + 40B]
# /usr/include/c++/13/bits/stl_uninitialized.h:642: 	      for (; __n > 0; --__n, (void) ++__cur)
	addq	$64, %rbx	#, __cur
# /usr/include/c++/13/bits/stl_uninitialized.h:642: 	      for (; __n > 0; --__n, (void) ++__cur)
	cmpq	%rbx, %r12	# __cur, _14
	jne	.L473	#,
# /usr/include/c++/13/bits/vector.tcc:649: 	      this->_M_impl._M_finish =
	movq	%r12, 8(%r15)	# _14, this_19(D)->D.106084._M_impl.D.105423._M_finish
	vzeroupper
# /usr/include/c++/13/bits/vector.tcc:710:     }
	addq	$24, %rsp	#,
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
.L492:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret	
	.p2align 4
	.p2align 3
.L472:
	.cfi_def_cfa 6, 16
	.cfi_offset 3, -56
	.cfi_offset 6, -16
	.cfi_offset 12, -48
	.cfi_offset 13, -40
	.cfi_offset 14, -32
	.cfi_offset 15, -24
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rbx, %rcx	# __cur, _31
# /usr/include/c++/13/bits/vector.tcc:643: 	  if (__size > max_size() || __navail > max_size() - __size)
	movabsq	$144115188075855871, %rdx	#, tmp125
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	subq	%r8, %rcx	# _26, _31
	movq	%rcx, %rax	# _31, tmp123
	sarq	$6, %rax	#, tmp123
# /usr/include/c++/13/bits/vector.tcc:643: 	  if (__size > max_size() || __navail > max_size() - __size)
	subq	%rax, %rdx	# tmp123, tmp124
# /usr/include/c++/13/bits/stl_vector.h:1898: 	if (max_size() - size() < __n)
	cmpq	%rsi, %rdx	# __n, tmp124
	jb	.L495	#,
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	leaq	(%rsi,%rax), %r13	#, _90
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$144115188075855871, %r14	#, tmp142
	cmpq	%r14, %r13	# tmp142, _90
	cmovbe	%r13, %r14	# _90,, iftmp.210_73
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	cmpq	%rsi, %rax	# __n, tmp123
	jb	.L476	#,
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	leaq	(%rax,%rax), %r14	#, iftmp.210_73
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$144115188075855871, %rax	#, tmp141
	cmpq	%rax, %r14	# tmp141, iftmp.210_73
	cmova	%rax, %r14	# iftmp.210_73,, tmp141, iftmp.210_73
.L476:
# /usr/include/c++/13/bits/new_allocator.h:147: 	    return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp),
	salq	$6, %r14	#, _87
	movq	%rcx, (%rsp)	# _31, %sfp
	movq	%r8, 8(%rsp)	# _26, %sfp
	movl	$64, %esi	#,
	movq	%r14, %rdi	# _87,
	call	_ZnwmSt11align_val_t@PLT	#
# /usr/include/c++/13/bits/vector.tcc:668: 		      std::__uninitialized_default_n_a(__new_start + __size,
	movq	(%rsp), %rcx	# %sfp, _31
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movq	8(%rsp), %r8	# %sfp, _26
	vpxor	%xmm0, %xmm0, %xmm0	# tmp130
# /usr/include/c++/13/bits/new_allocator.h:147: 	    return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp),
	movq	%rax, %r9	# tmp140, _88
	salq	$6, %r12	#, tmp128
# /usr/include/c++/13/bits/vector.tcc:668: 		      std::__uninitialized_default_n_a(__new_start + __size,
	leaq	(%rax,%rcx), %rax	#, __cur
	addq	%rax, %r12	# __cur, _25
	.p2align 4
	.p2align 3
.L477:
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	vmovdqu	%ymm0, 8(%rax)	# tmp130, MEM <vector(4) long long unsigned int> [(long long unsigned int *)__cur_52 + 8B]
	movq	$0x000000000, (%rax)	#, MEM[(double *)__cur_52]
	movq	$0, 40(%rax)	#, MEM[(long long unsigned int *)__cur_52 + 40B]
# /usr/include/c++/13/bits/stl_uninitialized.h:642: 	      for (; __n > 0; --__n, (void) ++__cur)
	addq	$64, %rax	#, __cur
# /usr/include/c++/13/bits/stl_uninitialized.h:642: 	      for (; __n > 0; --__n, (void) ++__cur)
	cmpq	%rax, %r12	# __cur, _25
	jne	.L477	#,
# /usr/include/c++/13/bits/stl_uninitialized.h:1103:       _ForwardIterator __cur = __result;
	movq	%r9, %rdx	# _88, __cur
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	movq	%r8, %rax	# _26, __first
	cmpq	%rbx, %r8	# __cur, _26
	je	.L481	#,
	.p2align 4
	.p2align 3
.L478:
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovdqa64	(%rax), %zmm2	# MEM[(struct AlignedThreadCounters &)__first_36], tmp147
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	addq	$64, %rax	#, __first
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	addq	$64, %rdx	#, __cur
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovdqa64	%zmm2, -64(%rdx)	# tmp147, MEM[(struct AlignedThreadCounters *)__cur_84]
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	cmpq	%rax, %rbx	# __first, __cur
	jne	.L478	#,
.L481:
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%r8, %r8	# _26
	je	.L496	#,
# /usr/include/c++/13/bits/vector.tcc:704: 			    this->_M_impl._M_end_of_storage - __old_start);
	movq	16(%r15), %rsi	# this_19(D)->D.106084._M_impl.D.105423._M_end_of_storage, tmp132
# /usr/include/c++/13/bits/new_allocator.h:167: 	    _GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n),
	movl	$64, %edx	#,
	movq	%r8, %rdi	# _26,
	movq	%r9, 8(%rsp)	# _88, %sfp
# /usr/include/c++/13/bits/vector.tcc:704: 			    this->_M_impl._M_end_of_storage - __old_start);
	subq	%r8, %rsi	# _26, tmp132
# /usr/include/c++/13/bits/new_allocator.h:167: 	    _GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n),
	vzeroupper
	call	_ZdlPvmSt11align_val_t@PLT	#
	movq	8(%rsp), %r9	# %sfp, _88
.L480:
# /usr/include/c++/13/bits/vector.tcc:706: 	      this->_M_impl._M_finish = __new_start + __size + __n;
	movq	%r13, %rcx	# _90, _90
# /usr/include/c++/13/bits/vector.tcc:705: 	      this->_M_impl._M_start = __new_start;
	vmovq	%r9, %xmm1	# _88, _88
# /usr/include/c++/13/bits/vector.tcc:706: 	      this->_M_impl._M_finish = __new_start + __size + __n;
	salq	$6, %rcx	#, _90
	addq	%r9, %rcx	# _88, tmp136
# /usr/include/c++/13/bits/vector.tcc:707: 	      this->_M_impl._M_end_of_storage = __new_start + __len;
	addq	%r14, %r9	# _87, tmp137
# /usr/include/c++/13/bits/vector.tcc:705: 	      this->_M_impl._M_start = __new_start;
	vpinsrq	$1, %rcx, %xmm1, %xmm0	# tmp136, _88, tmp134
# /usr/include/c++/13/bits/vector.tcc:707: 	      this->_M_impl._M_end_of_storage = __new_start + __len;
	movq	%r9, 16(%r15)	# tmp137, this_19(D)->D.106084._M_impl.D.105423._M_end_of_storage
# /usr/include/c++/13/bits/vector.tcc:705: 	      this->_M_impl._M_start = __new_start;
	vmovdqu	%xmm0, (%r15)	# tmp134, MEM <vector(2) long unsigned int> [(struct AlignedThreadCounters * *)this_19(D)]
# /usr/include/c++/13/bits/vector.tcc:710:     }
	addq	$24, %rsp	#,
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
.L496:
	.cfi_restore_state
	vzeroupper
	jmp	.L480	#
.L495:
# /usr/include/c++/13/bits/stl_vector.h:1899: 	  __throw_length_error(__N(__s));
	leaq	.LC144(%rip), %rdi	#, tmp126
	call	_ZSt20__throw_length_errorPKc@PLT	#
	.cfi_endproc
.LFE10546:
	.size	_ZNSt6vectorI21AlignedThreadCountersSaIS0_EE17_M_default_appendEm, .-_ZNSt6vectorI21AlignedThreadCountersSaIS0_EE17_M_default_appendEm
	