# Function: std::vector<std::array<int, 200ul>, std::allocator<std::array<int, 200ul> > >::_M_default_append(unsigned long)
# Mangled Symbol: _ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm,"axG",@progbits,_ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm
	.type	_ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm, @function
_ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm:
.LFB10560:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/vector.tcc:637:       if (__n != 0)
	testq	%rsi, %rsi	# __n
	je	.L609	#,
# /usr/include/c++/13/bits/vector.tcc:634:     vector<_Tp, _Alloc>::
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	movabsq	$-8116567392432202711, %rdx	#, tmp135
# /usr/include/c++/13/bits/vector.tcc:634:     vector<_Tp, _Alloc>::
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rcx	# tmp187, __n
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 96
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	8(%rdi), %rbp	# MEM[(const struct vector *)this_18(D)].D.108190._M_impl.D.107529._M_finish, _26
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	movq	16(%rdi), %rax	# this_18(D)->D.108190._M_impl.D.107529._M_end_of_storage, tmp130
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	(%rdi), %r15	# MEM[(const struct vector *)this_18(D)].D.108190._M_impl.D.107529._M_start, _25
	movq	%rdi, %rbx	# tmp186, this
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	subq	%rbp, %rax	# _26, tmp130
	sarq	$5, %rax	#, tmp133
	imulq	%rdx, %rax	# tmp135, __navail
# /usr/include/c++/13/bits/vector.tcc:646: 	  if (__navail >= __n)
	cmpq	%rsi, %rax	# __n, __navail
	jnb	.L613	#,
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	subq	%r15, %rbp	# _25, _30
	movq	%rbp, %rax	# _30, tmp156
	sarq	$5, %rax	#, tmp156
	imulq	%rdx, %rax	# tmp135, tmp157
# /usr/include/c++/13/bits/vector.tcc:643: 	  if (__size > max_size() || __navail > max_size() - __size)
	movabsq	$11529215046068469, %rdx	#, tmp160
	subq	%rax, %rdx	# tmp157, tmp159
# /usr/include/c++/13/bits/stl_vector.h:1898: 	if (max_size() - size() < __n)
	cmpq	%rsi, %rdx	# __n, tmp159
	jb	.L614	#,
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	leaq	(%rsi,%rax), %rsi	#, _63
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	cmpq	%rcx, %rax	# __n, tmp157
# /usr/include/c++/13/bits/stl_uninitialized.h:668: 	      __first = std::fill_n(__first, __n - 1, *__val);
	leaq	-1(%rcx), %r13	#, _49
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	movq	%rcx, 24(%rsp)	# __n, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	movq	%rsi, 8(%rsp)	# _63, %sfp
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	jb	.L582	#,
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$11529215046068469, %rdx	#, tmp191
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	addq	%rax, %rax	# __len
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	cmpq	%rdx, %rax	# tmp191, __len
	cmova	%rdx, %rax	# __len,, tmp191, __len
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	imulq	$800, %rax, %rax	#, __len, _9
	movq	%rax, %rdi	# _9,
	movq	%rax, 16(%rsp)	# _9, %sfp
	call	_Znwm@PLT	#
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movl	$800, %edx	#,
	xorl	%esi, %esi	#
# /usr/include/c++/13/bits/vector.tcc:668: 		      std::__uninitialized_default_n_a(__new_start + __size,
	leaq	(%rax,%rbp), %r14	#, _8
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r12	# tmp188, _35
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movq	%r14, %rdi	# _8,
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_algobase.h:1123:       if (__n <= 0)
	movq	24(%rsp), %rcx	# %sfp, __n
	cmpq	$1, %rcx	#, __n
	je	.L583	#,
.L612:
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	imulq	$800, %r13, %r13	#, _49, tmp174
# /usr/include/c++/13/bits/stl_uninitialized.h:667: 	      ++__first;
	leaq	800(%r14), %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	addq	%rcx, %r13	# __first, _78
	.p2align 4
	.p2align 3
.L586:
# /usr/include/c++/13/bits/stl_algobase.h:919: 	*__first = __value;
	movq	%rcx, %rdi	# __first,
	movl	$800, %edx	#,
	movq	%r14, %rsi	# _8,
	call	memcpy@PLT	#
	movq	%rax, %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:918:       for (; __first != __last; ++__first)
	addq	$800, %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:918:       for (; __first != __last; ++__first)
	cmpq	%rcx, %r13	# __first, _78
	jne	.L586	#,
.L585:
# /usr/include/c++/13/bits/stl_uninitialized.h:1119:       if (__count > 0)
	testq	%rbp, %rbp	# _30
	jne	.L583	#,
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%r15, %r15	# _25
	jne	.L615	#,
.L589:
# /usr/include/c++/13/bits/vector.tcc:706: 	      this->_M_impl._M_finish = __new_start + __size + __n;
	imulq	$800, 8(%rsp), %rax	#, %sfp, tmp183
# /usr/include/c++/13/bits/vector.tcc:705: 	      this->_M_impl._M_start = __new_start;
	vmovq	%r12, %xmm1	# _35, _35
# /usr/include/c++/13/bits/vector.tcc:706: 	      this->_M_impl._M_finish = __new_start + __size + __n;
	addq	%r12, %rax	# _35, tmp184
# /usr/include/c++/13/bits/vector.tcc:705: 	      this->_M_impl._M_start = __new_start;
	vpinsrq	$1, %rax, %xmm1, %xmm0	# tmp184, _35, tmp182
# /usr/include/c++/13/bits/vector.tcc:707: 	      this->_M_impl._M_end_of_storage = __new_start + __len;
	movq	16(%rsp), %rax	# %sfp, _9
# /usr/include/c++/13/bits/vector.tcc:705: 	      this->_M_impl._M_start = __new_start;
	vmovdqu	%xmm0, (%rbx)	# tmp182, MEM <vector(2) long unsigned int> [(struct array * *)this_18(D)]
# /usr/include/c++/13/bits/vector.tcc:707: 	      this->_M_impl._M_end_of_storage = __new_start + __len;
	addq	%rax, %r12	# _9, tmp185
	movq	%r12, 16(%rbx)	# tmp185, this_18(D)->D.108190._M_impl.D.107529._M_end_of_storage
# /usr/include/c++/13/bits/vector.tcc:710:     }
	addq	$40, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx	#
	.cfi_def_cfa_offset 48
	popq	%rbp	#
	.cfi_def_cfa_offset 40
	popq	%r12	#
	.cfi_def_cfa_offset 32
	popq	%r13	#
	.cfi_def_cfa_offset 24
	popq	%r14	#
	.cfi_def_cfa_offset 16
	popq	%r15	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4
	.p2align 3
.L613:
	.cfi_restore_state
	movq	%rsi, 8(%rsp)	# __n, %sfp
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movl	$800, %edx	#,
	xorl	%esi, %esi	#
	movq	%rbp, %rdi	# _26,
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_algobase.h:1123:       if (__n <= 0)
	movq	8(%rsp), %rcx	# %sfp, __n
# /usr/include/c++/13/bits/stl_uninitialized.h:667: 	      ++__first;
	leaq	800(%rbp), %r13	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:1123:       if (__n <= 0)
	decq	%rcx	# _48
	je	.L579	#,
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	imulq	$800, %rcx, %rcx	#, _48, tmp140
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	leaq	0(%r13,%rcx), %r12	#, _52
	movq	%r13, %rcx	# __first, __first
	.p2align 4
	.p2align 3
.L580:
# /usr/include/c++/13/bits/stl_algobase.h:919: 	*__first = __value;
	movq	%rcx, %rdi	# __first,
	movl	$800, %edx	#,
	movq	%rbp, %rsi	# _26,
	call	memcpy@PLT	#
	movq	%rax, %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:918:       for (; __first != __last; ++__first)
	addq	$800, %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:918:       for (; __first != __last; ++__first)
	cmpq	%rcx, %r12	# __first, _52
	jne	.L580	#,
	subq	%rbp, %r12	# _26, tmp146
	movabsq	$530343892119149609, %rdx	#, tmp151
	leaq	-1600(%r12), %rax	#, tmp148
	shrq	$5, %rax	#, tmp149
	imulq	%rdx, %rax	# tmp151, tmp150
	movabsq	$576460752303423487, %rdx	#, tmp153
	andq	%rdx, %rax	# tmp153, tmp152
	incq	%rax	# tmp154
	imulq	$800, %rax, %rax	#, tmp154, tmp155
	addq	%rax, %r13	# tmp155, __first
.L579:
# /usr/include/c++/13/bits/vector.tcc:649: 	      this->_M_impl._M_finish =
	movq	%r13, 8(%rbx)	# __first, this_18(D)->D.108190._M_impl.D.107529._M_finish
# /usr/include/c++/13/bits/vector.tcc:710:     }
	addq	$40, %rsp	#,
	.cfi_def_cfa_offset 56
	popq	%rbx	#
	.cfi_def_cfa_offset 48
	popq	%rbp	#
	.cfi_def_cfa_offset 40
	popq	%r12	#
	.cfi_def_cfa_offset 32
	popq	%r13	#
	.cfi_def_cfa_offset 24
	popq	%r14	#
	.cfi_def_cfa_offset 16
	popq	%r15	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4
	.p2align 3
.L609:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret	
	.p2align 4
	.p2align 3
.L582:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$11529215046068469, %rax	#, tmp190
	cmpq	%rax, %rsi	# tmp190, _63
	cmovbe	%rsi, %rax	# _63,, tmp168
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	imulq	$800, %rax, %rax	#, tmp168, _9
	movq	%rax, %rdi	# _9,
	movq	%rax, 16(%rsp)	# _9, %sfp
	call	_Znwm@PLT	#
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	xorl	%esi, %esi	#
	movl	$800, %edx	#,
# /usr/include/c++/13/bits/vector.tcc:668: 		      std::__uninitialized_default_n_a(__new_start + __size,
	leaq	(%rax,%rbp), %r14	#, _8
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r12	# tmp189, _35
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movq	%r14, %rdi	# _8,
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_algobase.h:1123:       if (__n <= 0)
	testq	%r13, %r13	# _49
	jne	.L612	#,
	jmp	.L585	#
	.p2align 4
	.p2align 3
.L583:
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	%r15, %rsi	# _25,
	movq	%rbp, %rdx	# _30,
	movq	%r12, %rdi	# _35,
	call	memmove@PLT	#
# /usr/include/c++/13/bits/vector.tcc:704: 			    this->_M_impl._M_end_of_storage - __old_start);
	movq	16(%rbx), %rsi	# this_18(D)->D.108190._M_impl.D.107529._M_end_of_storage, _62
	subq	%r15, %rsi	# _25, _62
.L588:
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%r15, %rdi	# _25,
	call	_ZdlPvm@PLT	#
	jmp	.L589	#
	.p2align 4
	.p2align 3
.L615:
# /usr/include/c++/13/bits/vector.tcc:704: 			    this->_M_impl._M_end_of_storage - __old_start);
	movq	16(%rbx), %rsi	# this_18(D)->D.108190._M_impl.D.107529._M_end_of_storage, _62
	subq	%r15, %rsi	# _25, _62
	jmp	.L588	#
.L614:
# /usr/include/c++/13/bits/stl_vector.h:1899: 	  __throw_length_error(__N(__s));
	leaq	.LC144(%rip), %rdi	#, tmp161
	call	_ZSt20__throw_length_errorPKc@PLT	#
	.cfi_endproc
.LFE10560:
	.size	_ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm, .-_ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm
	