# Function: void std::vector<double, std::allocator<double> >::_M_realloc_insert<double const&>(__gnu_cxx::__normal_iterator<double*, std::vector<double, std::allocator<double> > >, double const&)
# Mangled Symbol: _ZNSt6vectorIdSaIdEE17_M_realloc_insertIJRKdEEEvN9__gnu_cxx17__normal_iteratorIPdS1_EEDpOT_
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._ZNSt6vectorIdSaIdEE17_M_realloc_insertIJRKdEEEvN9__gnu_cxx17__normal_iteratorIPdS1_EEDpOT_,"axG",@progbits,_ZNSt6vectorIdSaIdEE17_M_realloc_insertIJRKdEEEvN9__gnu_cxx17__normal_iteratorIPdS1_EEDpOT_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIdSaIdEE17_M_realloc_insertIJRKdEEEvN9__gnu_cxx17__normal_iteratorIPdS1_EEDpOT_
	.type	_ZNSt6vectorIdSaIdEE17_M_realloc_insertIJRKdEEEvN9__gnu_cxx17__normal_iteratorIPdS1_EEDpOT_, @function
_ZNSt6vectorIdSaIdEE17_M_realloc_insertIJRKdEEEvN9__gnu_cxx17__normal_iteratorIPdS1_EEDpOT_:
.LFB10534:
	.cfi_startproc
	endbr64	
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
# /usr/include/c++/13/bits/stl_vector.h:1898: 	if (max_size() - size() < __n)
	movabsq	$1152921504606846975, %rcx	#, tmp126
# /usr/include/c++/13/bits/vector.tcc:445:       vector<_Tp, _Alloc>::
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 96
	movq	8(%rdi), %r12	# MEM[(double * *)this_18(D) + 8B], _49
	movq	(%rdi), %r13	# MEM[(double * *)this_18(D)], _48
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%r12, %rax	# _49, tmp124
	subq	%r13, %rax	# _48, tmp124
	sarq	$3, %rax	#, tmp125
# /usr/include/c++/13/bits/stl_vector.h:1898: 	if (max_size() - size() < __n)
	cmpq	%rcx, %rax	# tmp126, tmp125
	je	.L401	#,
# /usr/include/c++/13/bits/stl_iterator.h:1337:     { return __lhs.base() - __rhs.base(); }
	movq	%rsi, %r15	# __position, _98
	movq	%rdi, %rbp	# tmp150, this
	movq	%rsi, %r14	# tmp151, __position
	subq	%r13, %r15	# _48, _98
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	cmpq	%r12, %r13	# _49, _48
	je	.L402	#,
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	leaq	(%rax,%rax), %rcx	#, __len
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	cmpq	%rax, %rcx	# tmp125, __len
	jb	.L393	#,
# /usr/include/c++/13/bits/stl_vector.h:381: 	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
	testq	%rcx, %rcx	# __len
	jne	.L403	#,
	xorl	%ebx, %ebx	# _83
# /usr/include/c++/13/bits/stl_vector.h:381: 	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
	xorl	%edi, %edi	# iftmp.162_24
.L384:
# /usr/include/c++/13/bits/vector.tcc:483: 	      ++__new_finish;
	leaq	8(%rdi,%r15), %rcx	#, _92
# /usr/include/c++/13/bits/stl_uninitialized.h:1118:       ptrdiff_t __count = __last - __first;
	subq	%r14, %r12	# __position, _93
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovsd	(%rdx), %xmm0	# MEM[(const type &)__args#0_25(D)], MEM[(const type &)__args#0_25(D)]
	vmovq	%rdi, %xmm2	# iftmp.162_24, iftmp.162_24
# /usr/include/c++/13/bits/stl_uninitialized.h:1133:       return __result + __count;
	leaq	(%rcx,%r12), %rdx	#, tmp135
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovsd	%xmm0, (%rdi,%r15)	# MEM[(const type &)__args#0_25(D)], *_2
	vpinsrq	$1, %rdx, %xmm2, %xmm1	# tmp135, iftmp.162_24, _73
	vmovdqa	%xmm1, (%rsp)	# _73, %sfp
# /usr/include/c++/13/bits/stl_uninitialized.h:1119:       if (__count > 0)
	testq	%r15, %r15	# _98
	jg	.L404	#,
	testq	%r12, %r12	# _93
	jle	.L388	#,
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	%r12, %rdx	# _93,
	movq	%r14, %rsi	# __position,
	movq	%rcx, %rdi	# _92,
	call	memcpy@PLT	#
.L388:
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%r13, %r13	# _48
	jne	.L387	#,
.L390:
# /usr/include/c++/13/bits/vector.tcc:521:       this->_M_impl._M_start = __new_start;
	vmovdqa	(%rsp), %xmm3	# %sfp, _73
# /usr/include/c++/13/bits/vector.tcc:523:       this->_M_impl._M_end_of_storage = __new_start + __len;
	movq	%rbx, 16(%rbp)	# _83, this_18(D)->D.58646._M_impl.D.57959._M_end_of_storage
# /usr/include/c++/13/bits/vector.tcc:521:       this->_M_impl._M_start = __new_start;
	vmovdqu	%xmm3, 0(%rbp)	# _73, MEM <vector(2) long unsigned int> [(double * *)this_18(D)]
# /usr/include/c++/13/bits/vector.tcc:524:     }
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
.L393:
	.cfi_restore_state
	movabsq	$9223372036854775800, %rbx	#, _80
.L383:
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rbx, %rdi	# _80,
	movq	%rdx, (%rsp)	# __args#0, %sfp
	call	_Znwm@PLT	#
	movq	(%rsp), %rdx	# %sfp, __args#0
	movq	%rax, %rdi	# tmp153, iftmp.162_24
# /usr/include/c++/13/bits/vector.tcc:523:       this->_M_impl._M_end_of_storage = __new_start + __len;
	addq	%rax, %rbx	# iftmp.162_24, _83
	jmp	.L384	#
	.p2align 4
	.p2align 3
.L404:
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	%r15, %rdx	# _98,
	movq	%r13, %rsi	# _48,
	movq	%rcx, 24(%rsp)	# _92, %sfp
	call	memmove@PLT	#
# /usr/include/c++/13/bits/stl_uninitialized.h:1119:       if (__count > 0)
	testq	%r12, %r12	# _93
	jg	.L405	#,
.L387:
# /usr/include/c++/13/bits/vector.tcc:520: 		    this->_M_impl._M_end_of_storage - __old_start);
	movq	16(%rbp), %rsi	# this_18(D)->D.58646._M_impl.D.57959._M_end_of_storage, _12
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%r13, %rdi	# _48,
# /usr/include/c++/13/bits/vector.tcc:520: 		    this->_M_impl._M_end_of_storage - __old_start);
	subq	%r13, %rsi	# _48, _12
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
	jmp	.L390	#
	.p2align 4
	.p2align 3
.L402:
	addq	$1, %rax	#, tmp128
	jc	.L393	#,
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$1152921504606846975, %rcx	#, tmp157
	cmpq	%rcx, %rax	# tmp157, tmp128
	movq	%rcx, %rbx	# tmp157, tmp157
	cmovbe	%rax, %rbx	# tmp128,, tmp157
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	salq	$3, %rbx	#, _80
	jmp	.L383	#
	.p2align 4
	.p2align 3
.L405:
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	24(%rsp), %rdi	# %sfp,
	movq	%r14, %rsi	# __position,
	movq	%r12, %rdx	# _93,
	call	memcpy@PLT	#
# /usr/include/c++/13/bits/vector.tcc:520: 		    this->_M_impl._M_end_of_storage - __old_start);
	movq	16(%rbp), %rsi	# this_18(D)->D.58646._M_impl.D.57959._M_end_of_storage, _12
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%r13, %rdi	# _48,
# /usr/include/c++/13/bits/vector.tcc:520: 		    this->_M_impl._M_end_of_storage - __old_start);
	subq	%r13, %rsi	# _48, _12
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
	jmp	.L390	#
.L403:
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$1152921504606846975, %rax	#, tmp156
	cmpq	%rax, %rcx	# tmp156, __len
	cmova	%rax, %rcx	# __len,, tmp156, tmp130
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	leaq	0(,%rcx,8), %rbx	#, _80
	jmp	.L383	#
.L401:
# /usr/include/c++/13/bits/stl_vector.h:1899: 	  __throw_length_error(__N(__s));
	leaq	.LC140(%rip), %rdi	#, tmp127
	call	_ZSt20__throw_length_errorPKc@PLT	#
	.cfi_endproc
.LFE10534:
	.size	_ZNSt6vectorIdSaIdEE17_M_realloc_insertIJRKdEEEvN9__gnu_cxx17__normal_iteratorIPdS1_EEDpOT_, .-_ZNSt6vectorIdSaIdEE17_M_realloc_insertIJRKdEEEvN9__gnu_cxx17__normal_iteratorIPdS1_EEDpOT_
	.section	.rodata._ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm.str1.1,"aMS",@progbits,1
.LC141:
	.string	"vector::_M_default_append"
	