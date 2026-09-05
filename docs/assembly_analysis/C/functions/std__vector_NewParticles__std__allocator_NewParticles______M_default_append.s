# Function: std::vector<NewParticles, std::allocator<NewParticles> >::_M_default_append(unsigned long)
# Mangled Symbol: _ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm,"axG",@progbits,_ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm
	.type	_ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm, @function
_ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm:
.LFB10567:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/vector.tcc:637:       if (__n != 0)
	testq	%rsi, %rsi	# __n
	je	.L634	#,
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
	movabsq	$-36011213418661887, %rcx	#, tmp120
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
	movq	%rsi, %rdx	# tmp151, __n
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 96
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	8(%rdi), %rbp	# MEM[(const struct vector *)this_19(D)].D.109241._M_impl.D.108580._M_finish, _27
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	movq	16(%rdi), %rax	# this_19(D)->D.109241._M_impl.D.108580._M_end_of_storage, tmp115
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	(%rdi), %r15	# MEM[(const struct vector *)this_19(D)].D.109241._M_impl.D.108580._M_start, _26
	movq	%rdi, %rbx	# tmp150, this
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	subq	%rbp, %rax	# _27, tmp115
	sarq	$6, %rax	#, tmp118
	imulq	%rcx, %rax	# tmp120, __navail
# /usr/include/c++/13/bits/vector.tcc:646: 	  if (__navail >= __n)
	cmpq	%rsi, %rax	# __n, __navail
	jb	.L618	#,
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	imulq	$131136, %rsi, %r12	#, __n, _68
	movq	%rbp, %rdi	# _27,
	xorl	%esi, %esi	#
	movq	%r12, %rdx	# _68,
	call	memset@PLT	#
# /usr/include/c++/13/bits/vector.tcc:649: 	      this->_M_impl._M_finish =
	leaq	0(%rbp,%r12), %rdx	#, tmp125
	movq	%rdx, 8(%rbx)	# tmp125, this_19(D)->D.109241._M_impl.D.108580._M_finish
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
.L634:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret	
	.p2align 4
	.p2align 3
.L618:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rbp, %r8	# _27, _31
	subq	%r15, %r8	# _26, _31
	movq	%r8, %rax	# _31, tmp126
	sarq	$6, %rax	#, tmp126
	imulq	%rcx, %rax	# tmp120, tmp127
# /usr/include/c++/13/bits/vector.tcc:643: 	  if (__size > max_size() || __navail > max_size() - __size)
	movabsq	$70334401208323, %rcx	#, tmp130
	subq	%rax, %rcx	# tmp127, tmp129
# /usr/include/c++/13/bits/stl_vector.h:1898: 	if (max_size() - size() < __n)
	cmpq	%rsi, %rcx	# __n, tmp129
	jb	.L637	#,
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	leaq	(%rsi,%rax), %r13	#, _80
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$70334401208323, %r12	#, tmp154
	cmpq	%r12, %r13	# tmp154, _80
	cmovbe	%r13, %r12	# _80,, iftmp.252_55
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	cmpq	%rsi, %rax	# __n, tmp127
	jb	.L621	#,
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	leaq	(%rax,%rax), %r12	#, iftmp.252_55
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$70334401208323, %rax	#, tmp153
	cmpq	%rax, %r12	# tmp153, iftmp.252_55
	cmova	%rax, %r12	# iftmp.252_55,, tmp153, iftmp.252_55
.L621:
# /usr/include/c++/13/bits/new_allocator.h:147: 	    return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp),
	imulq	$131136, %r12, %rax	#, iftmp.252_55, _77
	movl	$64, %esi	#,
	movq	%rdx, 24(%rsp)	# __n, %sfp
	movq	%r8, 16(%rsp)	# _31, %sfp
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	movq	%r15, %r12	# _26, __first
# /usr/include/c++/13/bits/new_allocator.h:147: 	    return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp),
	movq	%rax, %rdi	# _77,
	movq	%rax, 8(%rsp)	# _77, %sfp
	call	_ZnwmSt11align_val_t@PLT	#
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movq	24(%rsp), %rdx	# %sfp, __n
# /usr/include/c++/13/bits/vector.tcc:668: 		      std::__uninitialized_default_n_a(__new_start + __size,
	movq	16(%rsp), %r8	# %sfp, _31
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	xorl	%esi, %esi	#
# /usr/include/c++/13/bits/new_allocator.h:147: 	    return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp),
	movq	%rax, %r14	# tmp152, _78
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	imulq	$131136, %rdx, %rdx	#, __n, tmp133
# /usr/include/c++/13/bits/vector.tcc:668: 		      std::__uninitialized_default_n_a(__new_start + __size,
	leaq	(%rax,%r8), %rdi	#, tmp134
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_uninitialized.h:1103:       _ForwardIterator __cur = __result;
	movq	%r14, %rdi	# _78, __cur
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	cmpq	%rbp, %r15	# _27, _26
	je	.L625	#,
	.p2align 4
	.p2align 3
.L622:
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movq	%r12, %rsi	# __first,
	movl	$131136, %edx	#,
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	addq	$131136, %r12	#, __first
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	call	memcpy@PLT	#
	movq	%rax, %rdi	#, __cur
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	addq	$131136, %rdi	#, __cur
# /usr/include/c++/13/bits/stl_uninitialized.h:1104:       for (; __first != __last; ++__first, (void)++__cur)
	cmpq	%r12, %rbp	# __first, _27
	jne	.L622	#,
.L625:
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%r15, %r15	# _26
	je	.L624	#,
# /usr/include/c++/13/bits/vector.tcc:704: 			    this->_M_impl._M_end_of_storage - __old_start);
	movq	16(%rbx), %rsi	# this_19(D)->D.109241._M_impl.D.108580._M_end_of_storage, tmp144
# /usr/include/c++/13/bits/new_allocator.h:167: 	    _GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n),
	movl	$64, %edx	#,
	movq	%r15, %rdi	# _26,
# /usr/include/c++/13/bits/vector.tcc:704: 			    this->_M_impl._M_end_of_storage - __old_start);
	subq	%r15, %rsi	# _26, tmp144
# /usr/include/c++/13/bits/new_allocator.h:167: 	    _GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n),
	call	_ZdlPvmSt11align_val_t@PLT	#
.L624:
# /usr/include/c++/13/bits/vector.tcc:707: 	      this->_M_impl._M_end_of_storage = __new_start + __len;
	movq	8(%rsp), %rax	# %sfp, _77
# /usr/include/c++/13/bits/vector.tcc:706: 	      this->_M_impl._M_finish = __new_start + __size + __n;
	imulq	$131136, %r13, %r13	#, _80, tmp147
# /usr/include/c++/13/bits/vector.tcc:705: 	      this->_M_impl._M_start = __new_start;
	vmovq	%r14, %xmm1	# _78, _78
# /usr/include/c++/13/bits/vector.tcc:706: 	      this->_M_impl._M_finish = __new_start + __size + __n;
	addq	%r14, %r13	# _78, tmp148
# /usr/include/c++/13/bits/vector.tcc:705: 	      this->_M_impl._M_start = __new_start;
	vpinsrq	$1, %r13, %xmm1, %xmm0	# tmp148, _78, tmp146
# /usr/include/c++/13/bits/vector.tcc:707: 	      this->_M_impl._M_end_of_storage = __new_start + __len;
	addq	%rax, %r14	# _77, tmp149
# /usr/include/c++/13/bits/vector.tcc:705: 	      this->_M_impl._M_start = __new_start;
	vmovdqu	%xmm0, (%rbx)	# tmp146, MEM <vector(2) long unsigned int> [(struct NewParticles * *)this_19(D)]
# /usr/include/c++/13/bits/vector.tcc:707: 	      this->_M_impl._M_end_of_storage = __new_start + __len;
	movq	%r14, 16(%rbx)	# tmp149, this_19(D)->D.109241._M_impl.D.108580._M_end_of_storage
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
.L637:
	.cfi_restore_state
# /usr/include/c++/13/bits/stl_vector.h:1899: 	  __throw_length_error(__N(__s));
	leaq	.LC144(%rip), %rdi	#, tmp131
	call	_ZSt20__throw_length_errorPKc@PLT	#
	.cfi_endproc
.LFE10567:
	.size	_ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm, .-_ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm
	