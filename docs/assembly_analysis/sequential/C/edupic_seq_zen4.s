	.file	"eduPIC.cc"
# GNU C++17 (Ubuntu 13.3.0-6ubuntu2~24.04.1) version 13.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 13.3.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -march=znver4 -O3 -std=c++17 -ffunction-sections -fno-inline -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.section	.text._ZNSt13random_deviceD2Ev,"axG",@progbits,_ZNSt13random_deviceD5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt13random_deviceD2Ev
	.type	_ZNSt13random_deviceD2Ev, @function
_ZNSt13random_deviceD2Ev:
.LFB2474:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA2474
	endbr64	
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 16
# /usr/include/c++/13/bits/random.h:1664:     { _M_fini(); }
	call	_ZNSt13random_device7_M_finiEv@PLT	#
# /usr/include/c++/13/bits/random.h:1664:     { _M_fini(); }
	addq	$8, %rsp	#,
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE2474:
	.globl	__gxx_personality_v0
	.section	.gcc_except_table._ZNSt13random_deviceD2Ev,"aG",@progbits,_ZNSt13random_deviceD5Ev,comdat
.LLSDA2474:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE2474-.LLSDACSB2474
.LLSDACSB2474:
.LLSDACSE2474:
	.section	.text._ZNSt13random_deviceD2Ev,"axG",@progbits,_ZNSt13random_deviceD5Ev,comdat
	.size	_ZNSt13random_deviceD2Ev, .-_ZNSt13random_deviceD2Ev
	.weak	_ZNSt13random_deviceD1Ev
	.set	_ZNSt13random_deviceD1Ev,_ZNSt13random_deviceD2Ev
	.section	.text._ZSt3minIiERKT_S2_S2_.constprop.0,"ax",@progbits
	.p2align 4
	.type	_ZSt3minIiERKT_S2_S2_.constprop.0, @function
_ZSt3minIiERKT_S2_S2_.constprop.0:
.LFB4721:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_algobase.h:240:       return __a;
	cmpl	$999999, (%rdi)	#, *__a_3(D)
	movq	%rdi, %rax	# __a, __a
	cmovg	%rsi, %rax	# tmp88,, __a
# /usr/include/c++/13/bits/stl_algobase.h:241:     }
	ret	
	.cfi_endproc
.LFE4721:
	.size	_ZSt3minIiERKT_S2_S2_.constprop.0, .-_ZSt3minIiERKT_S2_S2_.constprop.0
	.section	.text._ZNSt6vectorIiSaIiEEixEm.constprop.0,"axG",@progbits,_Z13random_sampleiiRSt6vectorIiSaIiEE,comdat
	.align 2
	.p2align 4
	.type	_ZNSt6vectorIiSaIiEEixEm.constprop.0, @function
_ZNSt6vectorIiSaIiEEixEm.constprop.0:
.LFB4722:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	_ZZ13random_sampleiiRSt6vectorIiSaIiEEE4pool(%rip), %rax	# pool.D.71714._M_impl.D.71053._M_start, pool.D.71714._M_impl.D.71053._M_start
	leaq	(%rax,%rdi,4), %rax	#, tmp86
# /usr/include/c++/13/bits/stl_vector.h:1130:       }
	ret	
	.cfi_endproc
.LFE4722:
	.size	_ZNSt6vectorIiSaIiEEixEm.constprop.0, .-_ZNSt6vectorIiSaIiEEixEm.constprop.0
	.section	.text._ZNSt15__new_allocatorIiED2Ev.constprop.0,"axG",@progbits,_ZNSt12_Vector_baseIiSaIiEE12_Vector_implD5Ev,comdat
	.align 2
	.p2align 4
	.type	_ZNSt15__new_allocatorIiED2Ev.constprop.0, @function
_ZNSt15__new_allocatorIiED2Ev.constprop.0:
.LFB4723:
	.cfi_startproc
# /usr/include/c++/13/bits/new_allocator.h:104:       ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
	ret	
	.cfi_endproc
.LFE4723:
	.size	_ZNSt15__new_allocatorIiED2Ev.constprop.0, .-_ZNSt15__new_allocatorIiED2Ev.constprop.0
	.section	.text._ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD2Ev.constprop.0,"axG",@progbits,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC5IS3_EEPKcRKS3_,comdat
	.align 2
	.p2align 4
	.type	_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD2Ev.constprop.0, @function
_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD2Ev.constprop.0:
.LFB4724:
	.cfi_startproc
# /usr/include/c++/13/bits/basic_string.tcc:242: 	  ~_Guard() { if (_M_guarded) _M_guarded->_M_dispose(); }
	ret	
	.cfi_endproc
.LFE4724:
	.size	_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD2Ev.constprop.0, .-_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD2Ev.constprop.0
	.section	.text._ZNSt15__new_allocatorIcED2Ev.constprop.0,"axG",@progbits,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD5Ev,comdat
	.align 2
	.p2align 4
	.type	_ZNSt15__new_allocatorIcED2Ev.constprop.0, @function
_ZNSt15__new_allocatorIcED2Ev.constprop.0:
.LFB4725:
	.cfi_startproc
# /usr/include/c++/13/bits/new_allocator.h:104:       ~__new_allocator() _GLIBCXX_USE_NOEXCEPT { }
	ret	
	.cfi_endproc
.LFE4725:
	.size	_ZNSt15__new_allocatorIcED2Ev.constprop.0, .-_ZNSt15__new_allocatorIcED2Ev.constprop.0
	.section	.text._ZN9__gnu_cxx11char_traitsIcE2eqERKcS3_.constprop.0.isra.0,"axG",@progbits,_ZN9__gnu_cxx11char_traitsIcE6lengthEPKc,comdat
	.p2align 4
	.type	_ZN9__gnu_cxx11char_traitsIcE2eqERKcS3_.constprop.0.isra.0, @function
_ZN9__gnu_cxx11char_traitsIcE2eqERKcS3_.constprop.0.isra.0:
.LFB4727:
	.cfi_startproc
# /usr/include/c++/13/bits/char_traits.h:137:       { return __c1 == __c2; }
	testb	%dil, %dil	# tmp86
	sete	%al	#, tmp85
# /usr/include/c++/13/bits/char_traits.h:137:       { return __c1 == __c2; }
	ret	
	.cfi_endproc
.LFE4727:
	.size	_ZN9__gnu_cxx11char_traitsIcE2eqERKcS3_.constprop.0.isra.0, .-_ZN9__gnu_cxx11char_traitsIcE2eqERKcS3_.constprop.0.isra.0
	.section	.text._ZSt9__fill_a1IPiiEN9__gnu_cxx11__enable_ifIXsrSt11__is_scalarIT0_E7__valueEvE6__typeET_S8_RKS4_.isra.0,"axG",@progbits,_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPimEET_S3_T0_,comdat
	.p2align 4
	.type	_ZSt9__fill_a1IPiiEN9__gnu_cxx11__enable_ifIXsrSt11__is_scalarIT0_E7__valueEvE6__typeET_S8_RKS4_.isra.0, @function
_ZSt9__fill_a1IPiiEN9__gnu_cxx11__enable_ifIXsrSt11__is_scalarIT0_E7__valueEvE6__typeET_S8_RKS4_.isra.0:
.LFB4728:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_algobase.h:926:     __fill_a1(_ForwardIterator __first, _ForwardIterator __last,
	movq	%rdi, %rcx	# tmp137, __first
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	cmpq	%rdi, %rsi	# __first, __last
	je	.L40	#,
	movq	%rsi, %r8	# __last, tmp114
	movq	%rdi, %rax	# __first, ivtmp.448
	subq	%rdi, %r8	# __first, tmp114
	subq	$4, %r8	#, _15
	movq	%r8, %rdi	# _15, _16
	shrq	$2, %rdi	#, _16
	leaq	1(%rdi), %r9	#, niters.431
	cmpq	$56, %r8	#, _15
	jbe	.L19	#,
	movq	%r9, %r8	# niters.431, bnd.432
	vpbroadcastd	%edx, %zmm0	# ISRA.427, vect_cst__35
	shrq	$4, %r8	#, bnd.432
	salq	$6, %r8	#, tmp117
	leaq	(%r8,%rcx), %r10	#, _24
	andl	$64, %r8d	#, tmp117
	je	.L15	#,
	leaq	64(%rcx), %rax	#, ivtmp.448
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	vmovdqu32	%zmm0, (%rcx)	# vect_cst__35, MEM <vector(16) int> [(int *)_3]
	cmpq	%rax, %r10	# ivtmp.448, _24
	je	.L32	#,
	.p2align 4
	.p2align 3
.L15:
	vmovdqu32	%zmm0, (%rax)	# vect_cst__35, MEM <vector(16) int> [(int *)_3]
	subq	$-128, %rax	#, ivtmp.448
	vmovdqu32	%zmm0, -64(%rax)	# vect_cst__35, MEM <vector(16) int> [(int *)_3]
	cmpq	%rax, %r10	# ivtmp.448, _24
	jne	.L15	#,
.L32:
	movq	%r9, %r8	# niters.431, niters_vector_mult_vf.433
	andq	$-16, %r8	#, niters_vector_mult_vf.433
	andl	$15, %r9d	#, niters.431
	leaq	(%rcx,%r8,4), %rax	#, tmp.440
	je	.L39	#,
.L14:
	subq	%r8, %rdi	# niters_vector_mult_vf.433, _48
	leaq	1(%rdi), %r9	#, niters.437
	cmpq	$6, %rdi	#, _48
	jbe	.L17	#,
	vpbroadcastd	%edx, %ymm0	# ISRA.427, tmp120
	vmovdqu	%ymm0, (%rcx,%r8,4)	# tmp120, MEM <vector(8) int> [(int *)vectp___first.442_68]
	movq	%r9, %rcx	# niters.437, niters_vector_mult_vf.439
	andq	$-8, %rcx	#, niters_vector_mult_vf.439
	andl	$7, %r9d	#, niters.437
	leaq	(%rax,%rcx,4), %rax	#, tmp.440
	je	.L39	#,
.L17:
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	leaq	4(%rax), %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movl	%edx, (%rax)	# ISRA.427, *__first_60
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	cmpq	%rcx, %rsi	# __first, __last
	je	.L39	#,
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	leaq	8(%rax), %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movl	%edx, 4(%rax)	# ISRA.427, MEM[(int *)__first_60 + 4B]
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	cmpq	%rcx, %rsi	# __first, __last
	je	.L39	#,
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	leaq	12(%rax), %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movl	%edx, 8(%rax)	# ISRA.427, MEM[(int *)__first_60 + 8B]
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	cmpq	%rcx, %rsi	# __first, __last
	je	.L39	#,
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	leaq	16(%rax), %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movl	%edx, 12(%rax)	# ISRA.427, MEM[(int *)__first_60 + 12B]
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	cmpq	%rcx, %rsi	# __first, __last
	je	.L39	#,
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	leaq	20(%rax), %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movl	%edx, 16(%rax)	# ISRA.427, MEM[(int *)__first_60 + 16B]
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	cmpq	%rcx, %rsi	# __first, __last
	je	.L39	#,
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	leaq	24(%rax), %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movl	%edx, 20(%rax)	# ISRA.427, MEM[(int *)__first_60 + 20B]
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	cmpq	%rcx, %rsi	# __first, __last
	je	.L39	#,
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movl	%edx, 24(%rax)	# ISRA.427, MEM[(int *)__first_60 + 24B]
	vzeroupper
# /usr/include/c++/13/bits/stl_algobase.h:932:     }
	ret	
	.p2align 4
	.p2align 3
.L39:
	vzeroupper
.L40:
	ret	
.L19:
# /usr/include/c++/13/bits/stl_algobase.h:930:       for (; __first != __last; ++__first)
	xorl	%r8d, %r8d	# niters_vector_mult_vf.433
	jmp	.L14	#
	.cfi_endproc
.LFE4728:
	.size	_ZSt9__fill_a1IPiiEN9__gnu_cxx11__enable_ifIXsrSt11__is_scalarIT0_E7__valueEvE6__typeET_S8_RKS4_.isra.0, .-_ZSt9__fill_a1IPiiEN9__gnu_cxx11__enable_ifIXsrSt11__is_scalarIT0_E7__valueEvE6__typeET_S8_RKS4_.isra.0
	.section	.text._ZNSt11__copy_moveILb0ELb0ESt26random_access_iterator_tagE12__assign_oneIiiEEvPT_PT0_.isra.0,"axG",@progbits,_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mIiiEEPT0_PT_S6_S4_,comdat
	.p2align 4
	.type	_ZNSt11__copy_moveILb0ELb0ESt26random_access_iterator_tagE12__assign_oneIiiEEvPT_PT0_.isra.0, @function
_ZNSt11__copy_moveILb0ELb0ESt26random_access_iterator_tagE12__assign_oneIiiEEvPT_PT0_.isra.0:
.LFB4729:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_algobase.h:398: 	{ *__to = *__from; }
	movl	%esi, (%rdi)	# tmp85, *__to_2(D)
# /usr/include/c++/13/bits/stl_algobase.h:398: 	{ *__to = *__from; }
	ret	
	.cfi_endproc
.LFE4729:
	.size	_ZNSt11__copy_moveILb0ELb0ESt26random_access_iterator_tagE12__assign_oneIiiEEvPT_PT0_.isra.0, .-_ZNSt11__copy_moveILb0ELb0ESt26random_access_iterator_tagE12__assign_oneIiiEEvPT_PT0_.isra.0
	.section	.text._ZSt8__fill_aIPiiEvT_S1_RKT0_.isra.0,"axG",@progbits,_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPimEET_S3_T0_,comdat
	.p2align 4
	.type	_ZSt8__fill_aIPiiEvT_S1_RKT0_.isra.0, @function
_ZSt8__fill_aIPiiEvT_S1_RKT0_.isra.0:
.LFB4730:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_algobase.h:977:     { std::__fill_a1(__first, __last, __value); }
	jmp	_ZSt9__fill_a1IPiiEN9__gnu_cxx11__enable_ifIXsrSt11__is_scalarIT0_E7__valueEvE6__typeET_S8_RKS4_.isra.0	#
	.cfi_endproc
.LFE4730:
	.size	_ZSt8__fill_aIPiiEvT_S1_RKT0_.isra.0, .-_ZSt8__fill_aIPiiEvT_S1_RKT0_.isra.0
	.section	.text._ZSt10__fill_n_aIPimiET_S1_T0_RKT1_St26random_access_iterator_tag.isra.0,"axG",@progbits,_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPimEET_S3_T0_,comdat
	.p2align 4
	.type	_ZSt10__fill_n_aIPimiET_S1_T0_RKT1_St26random_access_iterator_tag.isra.0, @function
_ZSt10__fill_n_aIPimiET_S1_T0_RKT1_St26random_access_iterator_tag.isra.0:
.LFB4731:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_algobase.h:1123:       if (__n <= 0)
	testq	%rsi, %rsi	# __n
	jne	.L52	#,
# /usr/include/c++/13/bits/stl_algobase.h:1130:     }
	movq	%rdi, %rax	# __first,
	ret	
	.p2align 4
	.p2align 3
.L52:
# /usr/include/c++/13/bits/stl_algobase.h:1117:     __fill_n_a(_OutputIterator __first, _Size __n, const _Tp& __value,
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 16
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	leaq	(%rdi,%rsi,4), %rsi	#, _4
	call	_ZSt8__fill_aIPiiEvT_S1_RKT0_.isra.0	#
# /usr/include/c++/13/bits/stl_algobase.h:1130:     }
	movq	%rsi, %rax	# _4,
	addq	$8, %rsp	#,
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE4731:
	.size	_ZSt10__fill_n_aIPimiET_S1_T0_RKT1_St26random_access_iterator_tag.isra.0, .-_ZSt10__fill_n_aIPimiET_S1_T0_RKT1_St26random_access_iterator_tag.isra.0
	.section	.text._ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEpLEl.isra.0,"axG",@progbits,_ZNSt6vectorIiSaIiEE6assignIN9__gnu_cxx17__normal_iteratorIPiS1_EEvEEvT_S7_,comdat
	.align 2
	.p2align 4
	.type	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEpLEl.isra.0, @function
_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEpLEl.isra.0:
.LFB4732:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_iterator.h:1143:       { _M_current += __n; return *this; }
	salq	$2, %rsi	#, tmp88
	addq	%rsi, (%rdi)	# tmp88, this_1(D)->_M_current
# /usr/include/c++/13/bits/stl_iterator.h:1143:       { _M_current += __n; return *this; }
	ret	
	.cfi_endproc
.LFE4732:
	.size	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEpLEl.isra.0, .-_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEpLEl.isra.0
	.section	.text._ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEmmEv.isra.0,"axG",@progbits,_ZNSt6vectorIiSaIiEE6assignIN9__gnu_cxx17__normal_iteratorIPiS1_EEvEEvT_S7_,comdat
	.align 2
	.p2align 4
	.type	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEmmEv.isra.0, @function
_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEmmEv.isra.0:
.LFB4733:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_iterator.h:1125: 	--_M_current;
	subq	$4, (%rdi)	#, this_1(D)->_M_current
# /usr/include/c++/13/bits/stl_iterator.h:1127:       }
	ret	
	.cfi_endproc
.LFE4733:
	.size	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEmmEv.isra.0, .-_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEmmEv.isra.0
	.section	.text._ZSt12__niter_wrapIPiET_RKS1_S1_.isra.0,"axG",@progbits,_ZSt13__copy_move_aILb0EN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET1_T0_S8_S7_,comdat
	.p2align 4
	.type	_ZSt12__niter_wrapIPiET_RKS1_S1_.isra.0, @function
_ZSt12__niter_wrapIPiET_RKS1_S1_.isra.0:
.LFB4734:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_algobase.h:338:     __niter_wrap(const _Iterator&, _Iterator __res)
	movq	%rdi, %rax	# tmp85, __res
# /usr/include/c++/13/bits/stl_algobase.h:339:     { return __res; }
	ret	
	.cfi_endproc
.LFE4734:
	.size	_ZSt12__niter_wrapIPiET_RKS1_S1_.isra.0, .-_ZSt12__niter_wrapIPiET_RKS1_S1_.isra.0
	.section	.text._ZSt14__relocate_a_1IiiENSt9enable_ifIXsrSt24__is_bitwise_relocatableIT_vE5valueEPS2_E4typeES4_S4_S4_RSaIT0_E.isra.0,"axG",@progbits,_ZNSt6vectorIiSaIiEE17_M_default_appendEm,comdat
	.p2align 4
	.type	_ZSt14__relocate_a_1IiiENSt9enable_ifIXsrSt24__is_bitwise_relocatableIT_vE5valueEPS2_E4typeES4_S4_S4_RSaIT0_E.isra.0, @function
_ZSt14__relocate_a_1IiiENSt9enable_ifIXsrSt24__is_bitwise_relocatableIT_vE5valueEPS2_E4typeES4_S4_S4_RSaIT0_E.isra.0:
.LFB4735:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_uninitialized.h:1114:     __relocate_a_1(_Tp* __first, _Tp* __last,
	movq	%rdi, %rax	# tmp87, __first
	movq	%rdx, %rdi	# tmp89, __result
# /usr/include/c++/13/bits/stl_uninitialized.h:1118:       ptrdiff_t __count = __last - __first;
	subq	%rax, %rsi	# __first, _3
# /usr/include/c++/13/bits/stl_uninitialized.h:1119:       if (__count > 0)
	testq	%rsi, %rsi	# _3
	jg	.L59	#,
# /usr/include/c++/13/bits/stl_uninitialized.h:1134:     }
	ret	
	.p2align 4
	.p2align 3
.L59:
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	%rsi, %rdx	# _3,
	movq	%rax, %rsi	# __first,
	jmp	memmove@PLT	#
	.cfi_endproc
.LFE4735:
	.size	_ZSt14__relocate_a_1IiiENSt9enable_ifIXsrSt24__is_bitwise_relocatableIT_vE5valueEPS2_E4typeES4_S4_S4_RSaIT0_E.isra.0, .-_ZSt14__relocate_a_1IiiENSt9enable_ifIXsrSt24__is_bitwise_relocatableIT_vE5valueEPS2_E4typeES4_S4_S4_RSaIT0_E.isra.0
	.section	.text._ZNSt15__new_allocatorIiE8allocateEmPKv.isra.0,"ax",@progbits
	.align 2
	.p2align 4
	.type	_ZNSt15__new_allocatorIiE8allocateEmPKv.isra.0, @function
_ZNSt15__new_allocatorIiE8allocateEmPKv.isra.0:
.LFB4736:
	.cfi_startproc
# /usr/include/c++/13/bits/new_allocator.h:134: 	if (__builtin_expect(__n > this->_M_max_size(), false))
	movq	%rdi, %rax	# __n, tmp89
	shrq	$61, %rax	#, tmp89
	jne	.L66	#,
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	salq	$2, %rdi	#, tmp87
	jmp	_Znwm@PLT	#
	.p2align 4
	.p2align 3
.L66:
# /usr/include/c++/13/bits/new_allocator.h:126:       allocate(size_type __n, const void* = static_cast<const void*>(0))
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 16
# /usr/include/c++/13/bits/new_allocator.h:138: 	    if (__n > (std::size_t(-1) / sizeof(_Tp)))
	shrq	$62, %rdi	#, tmp90
	je	.L62	#,
# /usr/include/c++/13/bits/new_allocator.h:139: 	      std::__throw_bad_array_new_length();
	call	_ZSt28__throw_bad_array_new_lengthv@PLT	#
	.p2align 4
	.p2align 3
.L62:
# /usr/include/c++/13/bits/new_allocator.h:140: 	    std::__throw_bad_alloc();
	call	_ZSt17__throw_bad_allocv@PLT	#
	.cfi_endproc
.LFE4736:
	.size	_ZNSt15__new_allocatorIiE8allocateEmPKv.isra.0, .-_ZNSt15__new_allocatorIiE8allocateEmPKv.isra.0
	.section	.text._ZNSt15__new_allocatorIiE10deallocateEPim.isra.0,"ax",@progbits
	.align 2
	.p2align 4
	.type	_ZNSt15__new_allocatorIiE10deallocateEPim.isra.0, @function
_ZNSt15__new_allocatorIiE10deallocateEPim.isra.0:
.LFB4737:
	.cfi_startproc
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	salq	$2, %rsi	#, tmp85
	jmp	_ZdlPvm@PLT	#
	.cfi_endproc
.LFE4737:
	.size	_ZNSt15__new_allocatorIiE10deallocateEPim.isra.0, .-_ZNSt15__new_allocatorIiE10deallocateEPim.isra.0
	.section	.text._ZNKSt21binomial_distributionIiE10param_type1pEv.isra.0,"axG",@progbits,_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE,comdat
	.align 2
	.p2align 4
	.type	_ZNKSt21binomial_distributionIiE10param_type1pEv.isra.0, @function
_ZNKSt21binomial_distributionIiE10param_type1pEv.isra.0:
.LFB4738:
	.cfi_startproc
# /usr/include/c++/13/bits/random.h:3884: 	{ return _M_p; }
	ret	
	.cfi_endproc
.LFE4738:
	.size	_ZNKSt21binomial_distributionIiE10param_type1pEv.isra.0, .-_ZNKSt21binomial_distributionIiE10param_type1pEv.isra.0
	.section	.text._ZNKSt21binomial_distributionIiE10param_type1tEv.isra.0,"axG",@progbits,_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE,comdat
	.align 2
	.p2align 4
	.type	_ZNKSt21binomial_distributionIiE10param_type1tEv.isra.0, @function
_ZNKSt21binomial_distributionIiE10param_type1tEv.isra.0:
.LFB4739:
	.cfi_startproc
# /usr/include/c++/13/bits/random.h:3879: 	t() const
	movl	%edi, %eax	# tmp85, ISRA.488
# /usr/include/c++/13/bits/random.h:3880: 	{ return _M_t; }
	ret	
	.cfi_endproc
.LFE4739:
	.size	_ZNKSt21binomial_distributionIiE10param_type1tEv.isra.0, .-_ZNKSt21binomial_distributionIiE10param_type1tEv.isra.0
	.section	.text._ZNKSt6vectorIiSaIiEE8capacityEv.isra.0,"axG",@progbits,_ZNSt6vectorIiSaIiEE6assignIN9__gnu_cxx17__normal_iteratorIPiS1_EEvEEvT_S7_,comdat
	.align 2
	.p2align 4
	.type	_ZNKSt6vectorIiSaIiEE8capacityEv.isra.0, @function
_ZNKSt6vectorIiSaIiEE8capacityEv.isra.0:
.LFB4740:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_vector.h:1080: 			 - this->_M_impl._M_start); }
	movq	%rsi, %rax	# tmp91, tmp91
	subq	%rdi, %rax	# tmp90, tmp91
	sarq	$2, %rax	#, tmp89
# /usr/include/c++/13/bits/stl_vector.h:1080: 			 - this->_M_impl._M_start); }
	ret	
	.cfi_endproc
.LFE4740:
	.size	_ZNKSt6vectorIiSaIiEE8capacityEv.isra.0, .-_ZNKSt6vectorIiSaIiEE8capacityEv.isra.0
	.section	.text._ZNSt12_Vector_baseIiSaIiEE11_M_allocateEm.isra.0,"ax",@progbits
	.align 2
	.p2align 4
	.type	_ZNSt12_Vector_baseIiSaIiEE11_M_allocateEm.isra.0, @function
_ZNSt12_Vector_baseIiSaIiEE11_M_allocateEm.isra.0:
.LFB4741:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_vector.h:381: 	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
	testq	%rdi, %rdi	# __n
	je	.L72	#,
# /usr/include/c++/13/bits/alloc_traits.h:482:       { return __a.allocate(__n); }
	jmp	_ZNSt15__new_allocatorIiE8allocateEmPKv.isra.0	#
	.p2align 4
	.p2align 3
.L72:
# /usr/include/c++/13/bits/stl_vector.h:382:       }
	xorl	%eax, %eax	#
	ret	
	.cfi_endproc
.LFE4741:
	.size	_ZNSt12_Vector_baseIiSaIiEE11_M_allocateEm.isra.0, .-_ZNSt12_Vector_baseIiSaIiEE11_M_allocateEm.isra.0
	.section	.text._ZSt8_DestroyIPiEvT_S1_.isra.0,"ax",@progbits
	.p2align 4
	.type	_ZSt8_DestroyIPiEvT_S1_.isra.0, @function
_ZSt8_DestroyIPiEvT_S1_.isra.0:
.LFB4742:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_construct.h:197:     }
	ret	
	.cfi_endproc
.LFE4742:
	.size	_ZSt8_DestroyIPiEvT_S1_.isra.0, .-_ZSt8_DestroyIPiEvT_S1_.isra.0
	.section	.text._ZNKSt19normal_distributionIdE10param_type4meanEv.isra.0,"axG",@progbits,_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE,comdat
	.align 2
	.p2align 4
	.type	_ZNKSt19normal_distributionIdE10param_type4meanEv.isra.0, @function
_ZNKSt19normal_distributionIdE10param_type4meanEv.isra.0:
.LFB4743:
	.cfi_startproc
# /usr/include/c++/13/bits/random.h:2041: 	{ return _M_mean; }
	ret	
	.cfi_endproc
.LFE4743:
	.size	_ZNKSt19normal_distributionIdE10param_type4meanEv.isra.0, .-_ZNKSt19normal_distributionIdE10param_type4meanEv.isra.0
	.section	.text._ZNKSt19normal_distributionIdE10param_type6stddevEv.isra.0,"axG",@progbits,_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE,comdat
	.align 2
	.p2align 4
	.type	_ZNKSt19normal_distributionIdE10param_type6stddevEv.isra.0, @function
_ZNKSt19normal_distributionIdE10param_type6stddevEv.isra.0:
.LFB4744:
	.cfi_startproc
# /usr/include/c++/13/bits/random.h:2045: 	{ return _M_stddev; }
	ret	
	.cfi_endproc
.LFE4744:
	.size	_ZNKSt19normal_distributionIdE10param_type6stddevEv.isra.0, .-_ZNKSt19normal_distributionIdE10param_type6stddevEv.isra.0
	.section	.text._ZNKSt25uniform_real_distributionIdE10param_type1aEv.isra.0,"ax",@progbits
	.align 2
	.p2align 4
	.type	_ZNKSt25uniform_real_distributionIdE10param_type1aEv.isra.0, @function
_ZNKSt25uniform_real_distributionIdE10param_type1aEv.isra.0:
.LFB4745:
	.cfi_startproc
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	ret	
	.cfi_endproc
.LFE4745:
	.size	_ZNKSt25uniform_real_distributionIdE10param_type1aEv.isra.0, .-_ZNKSt25uniform_real_distributionIdE10param_type1aEv.isra.0
	.section	.text._ZNKSt25uniform_real_distributionIdE10param_type1bEv.isra.0,"ax",@progbits
	.align 2
	.p2align 4
	.type	_ZNKSt25uniform_real_distributionIdE10param_type1bEv.isra.0, @function
_ZNKSt25uniform_real_distributionIdE10param_type1bEv.isra.0:
.LFB4746:
	.cfi_startproc
# /usr/include/c++/13/bits/random.h:1808: 	{ return _M_b; }
	ret	
	.cfi_endproc
.LFE4746:
	.size	_ZNKSt25uniform_real_distributionIdE10param_type1bEv.isra.0, .-_ZNKSt25uniform_real_distributionIdE10param_type1bEv.isra.0
	.section	.text._ZNSt12_Vector_baseIiSaIiEE13_M_deallocateEPim.isra.0,"ax",@progbits
	.align 2
	.p2align 4
	.type	_ZNSt12_Vector_baseIiSaIiEE13_M_deallocateEPim.isra.0, @function
_ZNSt12_Vector_baseIiSaIiEE13_M_deallocateEPim.isra.0:
.LFB4747:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# __p
	je	.L80	#,
# /usr/include/c++/13/bits/alloc_traits.h:517:       { __a.deallocate(__p, __n); }
	jmp	_ZNSt15__new_allocatorIiE10deallocateEPim.isra.0	#
	.p2align 4
	.p2align 3
.L80:
# /usr/include/c++/13/bits/stl_vector.h:391:       }
	ret	
	.cfi_endproc
.LFE4747:
	.size	_ZNSt12_Vector_baseIiSaIiEE13_M_deallocateEPim.isra.0, .-_ZNSt12_Vector_baseIiSaIiEE13_M_deallocateEPim.isra.0
	.section	.text._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag.isra.0,"axG",@progbits,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC5IS3_EEPKcRKS3_,comdat
	.align 2
	.p2align 4
	.type	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag.isra.0, @function
_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag.isra.0:
.LFB4748:
	.cfi_startproc
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rsi, %rbp	# tmp97, __beg
	subq	$16, %rsp	#,
	.cfi_def_cfa_offset 48
# /usr/include/c++/13/bits/basic_string.tcc:221:       basic_string<_CharT, _Traits, _Alloc>::
	movq	%rdi, %rbx	# tmp96, this
	movq	%rdx, %r12	# tmp98, __end
# /usr/include/c++/13/bits/stl_iterator_base_funcs.h:106:       return __last - __first;
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp101
	movq	%rax, 8(%rsp)	# tmp101, D.82266
	movq	%rdx, %rax	# __end, tmp101
	subq	%rsi, %rax	# __beg, _4
# /usr/include/c++/13/bits/basic_string.tcc:225: 	size_type __dnew = static_cast<size_type>(std::distance(__beg, __end));
	movq	%rax, (%rsp)	# _4, __dnew
# /usr/include/c++/13/bits/basic_string.tcc:227: 	if (__dnew > size_type(_S_local_capacity))
	cmpq	$15, %rax	#, _4
	ja	.L86	#,
.L82:
# /usr/include/c++/13/bits/basic_string.tcc:247: 	this->_S_copy_chars(_M_data(), __beg, __end);
	movq	%rbx, %rdi	# this,
	call	_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEv@PLT	#
# /usr/include/c++/13/bits/basic_string.tcc:247: 	this->_S_copy_chars(_M_data(), __beg, __end);
	movq	%r12, %rdx	# __end,
	movq	%rbp, %rsi	# __beg,
# /usr/include/c++/13/bits/basic_string.tcc:247: 	this->_S_copy_chars(_M_data(), __beg, __end);
	movq	%rax, %rdi	# tmp100, _8
# /usr/include/c++/13/bits/basic_string.tcc:247: 	this->_S_copy_chars(_M_data(), __beg, __end);
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcPKcS7_@PLT	#
# /usr/include/c++/13/bits/basic_string.tcc:251: 	_M_set_length(__dnew);
	movq	(%rsp), %rsi	# __dnew,
	movq	%rbx, %rdi	# this,
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_set_lengthEm@PLT	#
# /usr/include/c++/13/bits/basic_string.tcc:252:       }
	movq	8(%rsp), %rax	# D.82266, tmp102
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp102
	jne	.L87	#,
	addq	$16, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4
	.p2align 3
.L86:
	.cfi_restore_state
# /usr/include/c++/13/bits/basic_string.tcc:229: 	    _M_data(_M_create(__dnew, size_type(0)));
	movq	%rsp, %rsi	#, tmp92
	xorl	%edx, %edx	#
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERmm@PLT	#
# /usr/include/c++/13/bits/basic_string.tcc:229: 	    _M_data(_M_create(__dnew, size_type(0)));
	movq	%rbx, %rdi	# this,
# /usr/include/c++/13/bits/basic_string.tcc:229: 	    _M_data(_M_create(__dnew, size_type(0)));
	movq	%rax, %rsi	# tmp99, _6
# /usr/include/c++/13/bits/basic_string.tcc:229: 	    _M_data(_M_create(__dnew, size_type(0)));
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEPc@PLT	#
# /usr/include/c++/13/bits/basic_string.tcc:230: 	    _M_capacity(__dnew);
	movq	(%rsp), %rsi	# __dnew,
	movq	%rbx, %rdi	# this,
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE11_M_capacityEm@PLT	#
	jmp	.L82	#
.L87:
# /usr/include/c++/13/bits/basic_string.tcc:252:       }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE4748:
	.size	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag.isra.0, .-_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag.isra.0
	.section	.text._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderC2EPcRKS3_.isra.0,"axG",@progbits,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC5IS3_EEPKcRKS3_,comdat
	.align 2
	.p2align 4
	.type	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderC2EPcRKS3_.isra.0, @function
_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderC2EPcRKS3_.isra.0:
.LFB4749:
	.cfi_startproc
# /usr/include/c++/13/bits/basic_string.h:189: 	: allocator_type(__a), _M_p(__dat) { }
	movq	%rsi, (%rdi)	# tmp85, *this_1(D)._M_p
# /usr/include/c++/13/bits/basic_string.h:189: 	: allocator_type(__a), _M_p(__dat) { }
	ret	
	.cfi_endproc
.LFE4749:
	.size	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderC2EPcRKS3_.isra.0, .-_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderC2EPcRKS3_.isra.0
	.section	.text._ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEdeEv.isra.0,"ax",@progbits
	.align 2
	.p2align 4
	.type	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEdeEv.isra.0, @function
_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEdeEv.isra.0:
.LFB4750:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_iterator.h:1099:       operator*() const _GLIBCXX_NOEXCEPT
	movq	%rdi, %rax	# tmp85, ISRA.528
# /usr/include/c++/13/bits/stl_iterator.h:1100:       { return *_M_current; }
	ret	
	.cfi_endproc
.LFE4750:
	.size	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEdeEv.isra.0, .-_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEdeEv.isra.0
	.section	.text._ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEppEv.isra.0,"ax",@progbits
	.align 2
	.p2align 4
	.type	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEppEv.isra.0, @function
_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEppEv.isra.0:
.LFB4751:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_iterator.h:1111: 	++_M_current;
	addq	$4, (%rdi)	#, this_1(D)->_M_current
# /usr/include/c++/13/bits/stl_iterator.h:1113:       }
	ret	
	.cfi_endproc
.LFE4751:
	.size	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEppEv.isra.0, .-_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEppEv.isra.0
	.section	.text._ZSt9__advanceIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEElEvRT_T0_St26random_access_iterator_tag.isra.0,"axG",@progbits,_ZNSt6vectorIiSaIiEE6assignIN9__gnu_cxx17__normal_iteratorIPiS1_EEvEEvT_S7_,comdat
	.p2align 4
	.type	_ZSt9__advanceIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEElEvRT_T0_St26random_access_iterator_tag.isra.0, @function
_ZSt9__advanceIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEElEvRT_T0_St26random_access_iterator_tag.isra.0:
.LFB4752:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_iterator_base_funcs.h:195: 	__i += __n;
	jmp	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEpLEl.isra.0	#
	.cfi_endproc
.LFE4752:
	.size	_ZSt9__advanceIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEElEvRT_T0_St26random_access_iterator_tag.isra.0, .-_ZSt9__advanceIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEElEvRT_T0_St26random_access_iterator_tag.isra.0
	.section	.text._ZNKSt6vectorIiSaIiEE4sizeEv.isra.0,"ax",@progbits
	.align 2
	.p2align 4
	.type	_ZNKSt6vectorIiSaIiEE4sizeEv.isra.0, @function
_ZNKSt6vectorIiSaIiEE4sizeEv.isra.0:
.LFB4753:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rsi, %rax	# tmp91, tmp91
	subq	%rdi, %rax	# tmp90, tmp91
	sarq	$2, %rax	#, tmp89
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	ret	
	.cfi_endproc
.LFE4753:
	.size	_ZNKSt6vectorIiSaIiEE4sizeEv.isra.0, .-_ZNKSt6vectorIiSaIiEE4sizeEv.isra.0
	.section	.text._ZnwmPv.isra.0,"axG",@progbits,_ZSt10_ConstructIiJEEvPT_DpOT0_,comdat
	.p2align 4
	.type	_ZnwmPv.isra.0, @function
_ZnwmPv.isra.0:
.LFB4754:
	.cfi_startproc
# /usr/include/c++/13/new:174: _GLIBCXX_NODISCARD inline void* operator new(std::size_t, void* __p) _GLIBCXX_USE_NOEXCEPT
	movq	%rdi, %rax	# tmp85, __p
# /usr/include/c++/13/new:175: { return __p; }
	ret	
	.cfi_endproc
.LFE4754:
	.size	_ZnwmPv.isra.0, .-_ZnwmPv.isra.0
	.section	.text._ZSt23__is_constant_evaluatedv,"axG",@progbits,_ZSt23__is_constant_evaluatedv,comdat
	.p2align 4
	.weak	_ZSt23__is_constant_evaluatedv
	.type	_ZSt23__is_constant_evaluatedv, @function
_ZSt23__is_constant_evaluatedv:
.LFB1:
	.cfi_startproc
	endbr64	
# /usr/include/x86_64-linux-gnu/c++/13/bits/c++config.h:551:   }
	xorl	%eax, %eax	#
	ret	
	.cfi_endproc
.LFE1:
	.size	_ZSt23__is_constant_evaluatedv, .-_ZSt23__is_constant_evaluatedv
	.section	.text._ZSt3absd,"axG",@progbits,_ZSt3absd,comdat
	.p2align 4
	.weak	_ZSt3absd
	.type	_ZSt3absd, @function
_ZSt3absd:
.LFB37:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/std_abs.h:72:   { return __builtin_fabs(__x); }
	vandpd	.LC0(%rip), %xmm0, %xmm0	#, tmp86, tmp84
# /usr/include/c++/13/bits/std_abs.h:72:   { return __builtin_fabs(__x); }
	ret	
	.cfi_endproc
.LFE37:
	.size	_ZSt3absd, .-_ZSt3absd
	.section	.text._ZSt3loge,"axG",@progbits,_ZSt3loge,comdat
	.p2align 4
	.weak	_ZSt3loge
	.type	_ZSt3loge, @function
_ZSt3loge:
.LFB78:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/cmath:327:   { return __builtin_logl(__x); }
	jmp	logl@PLT	#
	.cfi_endproc
.LFE78:
	.size	_ZSt3loge, .-_ZSt3loge
	.section	.text._ZSt17__size_to_integerm,"axG",@progbits,_ZSt17__size_to_integerm,comdat
	.p2align 4
	.weak	_ZSt17__size_to_integerm
	.type	_ZSt17__size_to_integerm, @function
_ZSt17__size_to_integerm:
.LFB581:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_algobase.h:1018:   __size_to_integer(unsigned long __n) { return __n; }
	movq	%rdi, %rax	# tmp85, __n
# /usr/include/c++/13/bits/stl_algobase.h:1018:   __size_to_integer(unsigned long __n) { return __n; }
	ret	
	.cfi_endproc
.LFE581:
	.size	_ZSt17__size_to_integerm, .-_ZSt17__size_to_integerm
	.section	.text._ZSt6fill_nIPimiET_S1_T0_RKT1_.isra.0,"axG",@progbits,_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPimEET_S3_T0_,comdat
	.p2align 4
	.type	_ZSt6fill_nIPimiET_S1_T0_RKT1_.isra.0, @function
_ZSt6fill_nIPimiET_S1_T0_RKT1_.isra.0:
.LFB4755:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx	# tmp87, __first
	movq	%rsi, %rdi	# tmp88, __n
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 32
# /usr/include/c++/13/bits/stl_algobase.h:1152:     fill_n(_OI __first, _Size __n, const _Tp& __value)
	movl	%edx, %ebp	# tmp89, ISRA.558
# /usr/include/c++/13/bits/stl_algobase.h:1157:       return std::__fill_n_a(__first, std::__size_to_integer(__n), __value,
	call	_ZSt17__size_to_integerm	#
# /usr/include/c++/13/bits/stl_algobase.h:1159:     }
	addq	$8, %rsp	#,
	.cfi_def_cfa_offset 24
# /usr/include/c++/13/bits/stl_algobase.h:1157:       return std::__fill_n_a(__first, std::__size_to_integer(__n), __value,
	movl	%ebp, %edx	# ISRA.558,
	movq	%rbx, %rdi	# __first,
# /usr/include/c++/13/bits/stl_algobase.h:1159:     }
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
# /usr/include/c++/13/bits/stl_algobase.h:1157:       return std::__fill_n_a(__first, std::__size_to_integer(__n), __value,
	movq	%rax, %rsi	# tmp90, _2
# /usr/include/c++/13/bits/stl_algobase.h:1157:       return std::__fill_n_a(__first, std::__size_to_integer(__n), __value,
	jmp	_ZSt10__fill_n_aIPimiET_S1_T0_RKT1_St26random_access_iterator_tag.isra.0	#
	.cfi_endproc
.LFE4755:
	.size	_ZSt6fill_nIPimiET_S1_T0_RKT1_.isra.0, .-_ZSt6fill_nIPimiET_S1_T0_RKT1_.isra.0
	.section	.text._ZNSt14numeric_limitsIiE3maxEv,"axG",@progbits,_ZNSt14numeric_limitsIiE3maxEv,comdat
	.p2align 4
	.weak	_ZNSt14numeric_limitsIiE3maxEv
	.type	_ZNSt14numeric_limitsIiE3maxEv, @function
_ZNSt14numeric_limitsIiE3maxEv:
.LFB723:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/limits:1068:       max() _GLIBCXX_USE_NOEXCEPT { return __INT_MAX__; }
	movl	$2147483647, %eax	#,
	ret	
	.cfi_endproc
.LFE723:
	.size	_ZNSt14numeric_limitsIiE3maxEv, .-_ZNSt14numeric_limitsIiE3maxEv
	.section	.text._ZNSt13random_deviceclEv,"axG",@progbits,_ZNSt13random_deviceclEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt13random_deviceclEv
	.type	_ZNSt13random_deviceclEv, @function
_ZNSt13random_deviceclEv:
.LFB2479:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.h:1680:     { return this->_M_getval(); }
	jmp	_ZNSt13random_device9_M_getvalEv@PLT	#
	.cfi_endproc
.LFE2479:
	.size	_ZNSt13random_deviceclEv, .-_ZNSt13random_deviceclEv
	.section	.rodata._Z30set_electron_cross_sections_arv.str1.8,"aMS",@progbits,1
	.align 8
.LC5:
	.string	">> eduPIC: Setting e- / Ar cross sections\n"
	.section	.text._Z30set_electron_cross_sections_arv,"axG",@progbits,_Z30set_electron_cross_sections_arv,comdat
	.p2align 4
	.weak	_Z30set_electron_cross_sections_arv
	.type	_Z30set_electron_cross_sections_arv, @function
_Z30set_electron_cross_sections_arv:
.LFB3840:
	.cfi_startproc
	endbr64	
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%rbp	#
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC5(%rip), %rsi	#, tmp151
# cross_sections.h:5: inline void set_electron_cross_sections_ar(void){
	pushq	%rbx	#
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	leaq	sigma(%rip), %rbx	#, ivtmp.579
# cross_sections.h:5: inline void set_electron_cross_sections_ar(void){
	subq	$72, %rsp	#,
	.cfi_def_cfa_offset 112
	xorl	%ebp, %ebp	# i
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	__printf_chk@PLT	#
# cross_sections.h:11:         if (i == 0) {en = DE_CS;} else {en = DE_CS * i;}                            // electron energy
	movq	.LC3(%rip), %rax	#, tmp284
	vmovsd	.LC2(%rip), %xmm0	#, _126
	movq	%rax, 8(%rsp)	# tmp284, %sfp
	jmp	.L110	#
	.p2align 4
	.p2align 3
.L106:
# cross_sections.h:10:     for(i=0; i<CS_RANGES; i++){
	incl	%ebp	# i
# cross_sections.h:24:         sigma[E_ELA][i] = qmel * 1.0e-20;       // cross section for e- / Ar elastic collision
	vmulsd	.LC30(%rip), %xmm2, %xmm2	#, qmel, tmp230
# cross_sections.h:25:         sigma[E_EXC][i] = qexc * 1.0e-20;       // cross section for e- / Ar excitation
	vmovsd	%xmm1, 8000000(%rbx)	# _129, MEM[(double *)_114 + 8000000B]
# cross_sections.h:24:         sigma[E_ELA][i] = qmel * 1.0e-20;       // cross section for e- / Ar elastic collision
	vmovsd	%xmm2, (%rbx)	# tmp230, MEM[(double *)_114]
# cross_sections.h:26:         sigma[E_ION][i] = qion * 1.0e-20;       // cross section for e- / Ar ionization
	vmovsd	%xmm0, 16000000(%rbx)	# _131, MEM[(double *)_114 + 16000000B]
# cross_sections.h:10:     for(i=0; i<CS_RANGES; i++){
	addq	$8, %rbx	#, ivtmp.579
	cmpl	$1000000, %ebp	#, i
	je	.L116	#,
# cross_sections.h:11:         if (i == 0) {en = DE_CS;} else {en = DE_CS * i;}                            // electron energy
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp318
	vcvtsi2sdl	%ebp, %xmm4, %xmm0	# i, tmp318, tmp277
# cross_sections.h:11:         if (i == 0) {en = DE_CS;} else {en = DE_CS * i;}                            // electron energy
	vmulsd	.LC3(%rip), %xmm0, %xmm5	#, tmp232, en
# cross_sections.h:12:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vdivsd	.LC36(%rip), %xmm5, %xmm0	#, en, _122
# cross_sections.h:12:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vdivsd	.LC37(%rip), %xmm5, %xmm1	#, en, tmp235
# cross_sections.h:12:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vaddsd	.LC12(%rip), %xmm1, %xmm1	#, tmp235, tmp237
# cross_sections.h:12:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# _122, tmp237, _126
# cross_sections.h:11:         if (i == 0) {en = DE_CS;} else {en = DE_CS * i;}                            // electron energy
	vmovsd	%xmm5, 8(%rsp)	# en, %sfp
.L110:
# cross_sections.h:12:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vmovsd	.LC6(%rip), %xmm1	#,
	call	pow@PLT	#
# cross_sections.h:12:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vmovsd	.LC7(%rip), %xmm4	#, tmp286
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	.LC8(%rip), %xmm1	#,
# cross_sections.h:12:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vdivsd	%xmm0, %xmm4, %xmm7	# tmp263, tmp286, _8
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	8(%rsp), %xmm0	# %sfp,
# cross_sections.h:12:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vmovq	%xmm7, %r14	# _8, _8
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	call	pow@PLT	#
	vmovsd	%xmm0, 16(%rsp)	# tmp264, %sfp
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	8(%rsp), %xmm7	# %sfp, en
	vmovsd	.LC10(%rip), %xmm1	#,
	vdivsd	.LC9(%rip), %xmm7, %xmm4	#, en, _11
	vmovsd	%xmm4, 40(%rsp)	# _11, %sfp
	vmovsd	%xmm4, %xmm4, %xmm0	# _11,
	call	pow@PLT	#
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	.LC11(%rip), %xmm4	#, tmp289
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vaddsd	.LC12(%rip), %xmm0, %xmm0	#, tmp265, tmp159
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmulsd	16(%rsp), %xmm4, %xmm1	# %sfp, tmp289, tmp157
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	8(%rsp), %xmm7	# %sfp, en
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vdivsd	%xmm0, %xmm1, %xmm4	# tmp159, tmp157, _14
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vdivsd	.LC14(%rip), %xmm7, %xmm0	#, en, tmp162
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovq	%xmm4, %r15	# _14, _14
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	.LC13(%rip), %xmm1	#,
	call	pow@PLT	#
	vmovsd	%xmm0, 16(%rsp)	# tmp266, %sfp
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	8(%rsp), %xmm7	# %sfp, en
	vmovsd	.LC15(%rip), %xmm1	#,
	vdivsd	.LC16(%rip), %xmm7, %xmm0	#, en, tmp165
	call	pow@PLT	#
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	.LC12(%rip), %xmm7	#, tmp294
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp169
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	%xmm0, %xmm0, %xmm2	#, tmp267
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vaddsd	16(%rsp), %xmm7, %xmm0	# %sfp, tmp294, tmp167
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vaddsd	%xmm2, %xmm0, %xmm0	# tmp267, tmp167, _20
	vucomisd	%xmm0, %xmm1	# _20, tmp169
	ja	.L114	#,
	vsqrtsd	%xmm0, %xmm0, %xmm6	# _20, _21
	vmovsd	%xmm6, 16(%rsp)	# _21, %sfp
.L105:
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	8(%rsp), %xmm6	# %sfp, en
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	.LC18(%rip), %xmm1	#,
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vdivsd	.LC17(%rip), %xmm6, %xmm3	#, en, tmp170
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	%xmm6, %xmm6, %xmm0	# en,
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vaddsd	.LC12(%rip), %xmm3, %xmm3	#, tmp170, _26
	vmovsd	%xmm3, 32(%rsp)	# _26, %sfp
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	call	pow@PLT	#
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	8(%rsp), %xmm6	# %sfp, en
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	%xmm0, 24(%rsp)	# tmp269, %sfp
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	.LC7(%rip), %xmm1	#,
	vdivsd	.LC19(%rip), %xmm6, %xmm0	#, en, tmp175
	call	pow@PLT	#
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovq	%r15, %xmm7	# _14, _14
	vdivsd	16(%rsp), %xmm7, %xmm2	# %sfp, _14, tmp177
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovq	%r14, %xmm7	# _8, _8
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	%xmm0, %xmm0, %xmm1	#, tmp270
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vsubsd	%xmm2, %xmm7, %xmm2	# tmp177, _8, tmp178
# cross_sections.h:12:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vandpd	.LC0(%rip), %xmm2, %xmm2	#, tmp178, tmp179
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vaddsd	.LC12(%rip), %xmm1, %xmm1	#, tmp270, tmp187
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	32(%rsp), %xmm3	# %sfp, _26
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	.LC20(%rip), %xmm5	#, tmp302
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmulsd	%xmm3, %xmm3, %xmm3	# _26, _26, tmp181
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	.LC21(%rip), %xmm7	#, tmp303
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vdivsd	%xmm3, %xmm5, %xmm3	# tmp181, tmp302, tmp182
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmulsd	24(%rsp), %xmm7, %xmm0	# %sfp, tmp303, tmp185
# cross_sections.h:15:         if (en > E_EXC_TH)
	vmovsd	8(%rsp), %xmm6	# %sfp, en
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp187, tmp185, tmp189
# cross_sections.h:15:         if (en > E_EXC_TH)
	vcomisd	.LC22(%rip), %xmm6	#, en
# cross_sections.h:14:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vaddsd	%xmm3, %xmm2, %xmm2	# tmp182, tmp179, tmp184
# cross_sections.h:12:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vaddsd	%xmm0, %xmm2, %xmm2	# tmp189, tmp184, qmel
	vxorpd	%xmm0, %xmm0, %xmm0	# _131
	vmovsd	%xmm0, %xmm0, %xmm1	#, _129
# cross_sections.h:15:         if (en > E_EXC_TH)
	jbe	.L106	#,
# cross_sections.h:16:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vsubsd	.LC22(%rip), %xmm6, %xmm3	#, en, _36
	vmovsd	%xmm2, 56(%rsp)	# qmel, %sfp
	vmovsd	%xmm3, %xmm3, %xmm0	# _36,
	vmovsd	%xmm3, 48(%rsp)	# _36, %sfp
	vmovsd	.LC11(%rip), %xmm1	#,
	call	pow@PLT	#
# cross_sections.h:16:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	.LC23(%rip), %xmm1	#,
# cross_sections.h:16:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	%xmm0, 16(%rsp)	# tmp271, %sfp
# cross_sections.h:16:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	40(%rsp), %xmm0	# %sfp,
	call	pow@PLT	#
# cross_sections.h:16:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	8(%rsp), %xmm5	# %sfp, en
# cross_sections.h:16:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	%xmm0, 24(%rsp)	# tmp272, %sfp
# cross_sections.h:16:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	.LC14(%rip), %xmm1	#,
	vdivsd	.LC24(%rip), %xmm5, %xmm0	#, en, tmp195
	call	pow@PLT	#
	vmovsd	%xmm0, 32(%rsp)	# tmp273, %sfp
# cross_sections.h:17:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vmovsd	8(%rsp), %xmm5	# %sfp, en
# cross_sections.h:17:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vmovsd	.LC25(%rip), %xmm1	#,
# cross_sections.h:17:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vdivsd	.LC26(%rip), %xmm5, %xmm0	#, en, tmp198
# cross_sections.h:17:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vaddsd	.LC12(%rip), %xmm0, %xmm0	#, tmp198, tmp200
	call	pow@PLT	#
# cross_sections.h:16:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	16(%rsp), %xmm2	# %sfp, _37
# cross_sections.h:16:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	.LC12(%rip), %xmm6	#, tmp310
# cross_sections.h:16:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmulsd	.LC27(%rip), %xmm2, %xmm1	#, _37, tmp202
# cross_sections.h:17:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vmovsd	%xmm0, %xmm0, %xmm4	#, tmp274
# cross_sections.h:17:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vmovsd	48(%rsp), %xmm3	# %sfp, _36
# cross_sections.h:16:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vaddsd	24(%rsp), %xmm6, %xmm0	# %sfp, tmp310, tmp204
# cross_sections.h:17:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vmulsd	.LC28(%rip), %xmm3, %xmm3	#, _36, tmp210
# cross_sections.h:16:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmulsd	%xmm0, %xmm1, %xmm0	# tmp204, tmp202, tmp206
# cross_sections.h:17:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vdivsd	%xmm4, %xmm3, %xmm3	# tmp274, tmp210, tmp212
# cross_sections.h:16:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vaddsd	32(%rsp), %xmm6, %xmm1	# %sfp, tmp312, tmp207
# cross_sections.h:20:         if (en > E_ION_TH)
	vmovsd	8(%rsp), %xmm5	# %sfp, en
# cross_sections.h:16:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp207, tmp206, tmp209
# cross_sections.h:20:         if (en > E_ION_TH)
	vmovsd	56(%rsp), %xmm2	# %sfp, qmel
# cross_sections.h:16:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vaddsd	%xmm3, %xmm0, %xmm1	# tmp212, tmp209, qexc
# cross_sections.h:20:         if (en > E_ION_TH)
	vmovsd	.LC29(%rip), %xmm0	#, tmp213
	vcomisd	%xmm0, %xmm5	# tmp213, en
	ja	.L108	#,
# cross_sections.h:25:         sigma[E_EXC][i] = qexc * 1.0e-20;       // cross section for e- / Ar excitation
	vmulsd	.LC30(%rip), %xmm1, %xmm1	#, qexc, _129
	vxorpd	%xmm0, %xmm0, %xmm0	# _131
	jmp	.L106	#
	.p2align 4
	.p2align 3
.L108:
# cross_sections.h:21:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vsubsd	%xmm0, %xmm5, %xmm4	# tmp213, en, _51
	vmovsd	%xmm5, %xmm5, %xmm3	# en, en
	vmovsd	%xmm1, 32(%rsp)	# qexc, %sfp
# cross_sections.h:21:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vxorpd	.LC32(%rip), %xmm3, %xmm0	#, en, tmp217
# cross_sections.h:21:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vaddsd	.LC31(%rip), %xmm5, %xmm5	#, en, _53
	vmovsd	%xmm2, 24(%rsp)	# qmel, %sfp
# cross_sections.h:21:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmovsd	%xmm4, 16(%rsp)	# _51, %sfp
# cross_sections.h:21:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmovsd	%xmm5, 8(%rsp)	# _53, %sfp
# cross_sections.h:21:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vdivsd	.LC33(%rip), %xmm0, %xmm0	#, tmp217, tmp219
	call	exp@PLT	#
# cross_sections.h:21:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmovsd	16(%rsp), %xmm4	# %sfp, _51
# cross_sections.h:21:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmovsd	8(%rsp), %xmm5	# %sfp, _53
# cross_sections.h:21:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmovsd	%xmm0, %xmm0, %xmm6	#, tmp275
# cross_sections.h:21:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmulsd	%xmm4, %xmm4, %xmm3	# _51, _51, tmp221
# cross_sections.h:21:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmulsd	.LC35(%rip), %xmm4, %xmm0	#, _51, tmp224
# cross_sections.h:21:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmulsd	.LC34(%rip), %xmm3, %xmm3	#, tmp221, tmp222
# cross_sections.h:21:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmulsd	%xmm5, %xmm5, %xmm5	# _53, _53, tmp226
# cross_sections.h:25:         sigma[E_EXC][i] = qexc * 1.0e-20;       // cross section for e- / Ar excitation
	vmovsd	32(%rsp), %xmm1	# %sfp, qexc
# cross_sections.h:21:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vdivsd	%xmm5, %xmm0, %xmm0	# tmp226, tmp224, tmp227
# cross_sections.h:25:         sigma[E_EXC][i] = qexc * 1.0e-20;       // cross section for e- / Ar excitation
	vmulsd	.LC30(%rip), %xmm1, %xmm1	#, qexc, _129
# cross_sections.h:21:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vfmadd231sd	%xmm6, %xmm3, %xmm0	# tmp275, tmp222, qion
	vmovsd	24(%rsp), %xmm2	# %sfp, qmel
# cross_sections.h:26:         sigma[E_ION][i] = qion * 1.0e-20;       // cross section for e- / Ar ionization
	vmulsd	.LC30(%rip), %xmm0, %xmm0	#, qion, _131
	jmp	.L106	#
.L116:
# cross_sections.h:28: }
	addq	$72, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx	#
	.cfi_def_cfa_offset 32
	popq	%rbp	#
	.cfi_def_cfa_offset 24
	popq	%r14	#
	.cfi_def_cfa_offset 16
	popq	%r15	#
	.cfi_def_cfa_offset 8
	ret	
.L114:
	.cfi_restore_state
# cross_sections.h:13:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	call	sqrt@PLT	#
	vmovsd	%xmm0, 16(%rsp)	# tmp268, %sfp
	jmp	.L105	#
	.cfi_endproc
.LFE3840:
	.size	_Z30set_electron_cross_sections_arv, .-_Z30set_electron_cross_sections_arv
	.section	.rodata._Z25set_ion_cross_sections_arv.str1.8,"aMS",@progbits,1
	.align 8
.LC39:
	.string	">> eduPIC: Setting Ar+ / Ar cross sections\n"
	.section	.text._Z25set_ion_cross_sections_arv,"axG",@progbits,_Z25set_ion_cross_sections_arv,comdat
	.p2align 4
	.weak	_Z25set_ion_cross_sections_arv
	.type	_Z25set_ion_cross_sections_arv, @function
_Z25set_ion_cross_sections_arv:
.LFB3841:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC39(%rip), %rsi	#, tmp104
	movl	$2, %edi	#,
# cross_sections.h:30: inline void set_ion_cross_sections_ar(void){
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 64
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	xorl	%eax, %eax	#
	xorl	%ebx, %ebx	# ivtmp.585
	leaq	sigma(%rip), %rbp	#, tmp136
	call	__printf_chk@PLT	#
	.p2align 4
	.p2align 3
.L120:
	movq	.LC38(%rip), %rax	#, tmp154
	movq	%rax, 8(%rsp)	# tmp154, %sfp
# cross_sections.h:36:         if (i == 0) {e_com = DE_CS;} else {e_com = DE_CS * i;}             // ion energy in the center of mass frame of reference
	testq	%rbx, %rbx	# ivtmp.585
	je	.L119	#,
# cross_sections.h:36:         if (i == 0) {e_com = DE_CS;} else {e_com = DE_CS * i;}             // ion energy in the center of mass frame of reference
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp155
	vcvtsi2sdl	%ebx, %xmm6, %xmm0	# ivtmp.585, tmp155, tmp152
# cross_sections.h:36:         if (i == 0) {e_com = DE_CS;} else {e_com = DE_CS * i;}             // ion energy in the center of mass frame of reference
	vmulsd	.LC3(%rip), %xmm0, %xmm0	#, tmp105, e_com
# cross_sections.h:37:         e_lab = 2.0 * e_com;                                               // ion energy in the laboratory frame of reference
	vaddsd	%xmm0, %xmm0, %xmm7	# e_com, e_com, _17
	vmovsd	%xmm7, 8(%rsp)	# _17, %sfp
.L119:
# cross_sections.h:38:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	.LC40(%rip), %xmm1	#,
	vmovsd	8(%rsp), %xmm0	# %sfp,
	call	pow@PLT	#
# cross_sections.h:38:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	.LC41(%rip), %xmm4	#, tmp157
# cross_sections.h:38:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	%xmm0, 16(%rsp)	# tmp148, %sfp
# cross_sections.h:38:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	.LC36(%rip), %xmm1	#,
# cross_sections.h:38:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vdivsd	8(%rsp), %xmm4, %xmm0	# %sfp, tmp157, tmp110
# cross_sections.h:38:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vaddsd	.LC12(%rip), %xmm0, %xmm0	#, tmp110, tmp112
	call	pow@PLT	#
# cross_sections.h:39:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmovsd	.LC42(%rip), %xmm1	#,
# cross_sections.h:38:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	%xmm0, 24(%rsp)	# tmp149, %sfp
# cross_sections.h:39:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmovsd	8(%rsp), %xmm0	# %sfp,
	call	pow@PLT	#
# cross_sections.h:41:         sigma[I_ISO][i]  = qiso;             // cross section for Ar+ / Ar isotropic part of elastic scattering
	leaq	0(,%rbx,8), %rax	#, tmp129
# cross_sections.h:35:     for(i=0; i<CS_RANGES; i++){
	incq	%rbx	# ivtmp.585
# cross_sections.h:39:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmovsd	8(%rsp), %xmm3	# %sfp, _17
# cross_sections.h:39:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmulsd	.LC43(%rip), %xmm0, %xmm0	#, tmp150, tmp118
# cross_sections.h:39:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vdivsd	.LC18(%rip), %xmm3, %xmm2	#, _17, tmp115
# cross_sections.h:39:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmovsd	.LC12(%rip), %xmm5	#, tmp160
# cross_sections.h:39:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vaddsd	.LC12(%rip), %xmm2, %xmm2	#, tmp115, _13
# cross_sections.h:39:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vaddsd	%xmm3, %xmm5, %xmm1	# _17, tmp160, tmp120
# cross_sections.h:39:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmovsd	.LC44(%rip), %xmm6	#, tmp162
# cross_sections.h:39:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp120, tmp118, tmp122
# cross_sections.h:39:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmulsd	%xmm2, %xmm2, %xmm2	# _13, _13, tmp125
# cross_sections.h:39:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmulsd	%xmm3, %xmm6, %xmm1	# _17, tmp162, tmp123
# cross_sections.h:38:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	.LC45(%rip), %xmm7	#, tmp164
# cross_sections.h:39:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vdivsd	%xmm2, %xmm1, %xmm1	# tmp125, tmp123, tmp126
# cross_sections.h:39:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vaddsd	%xmm1, %xmm0, %xmm0	# tmp126, tmp122, qiso
# cross_sections.h:38:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmulsd	16(%rsp), %xmm7, %xmm1	# %sfp, tmp164, tmp127
# cross_sections.h:41:         sigma[I_ISO][i]  = qiso;             // cross section for Ar+ / Ar isotropic part of elastic scattering
	vmovsd	%xmm0, 24000000(%rbp,%rax)	# qiso, MEM[(double *)&sigma + 24000000B + ivtmp.585_22 * 8]
# cross_sections.h:40:         qback = (qmom-qiso) / 2.0;
	vfmsub132sd	24(%rsp), %xmm0, %xmm1	# %sfp, qiso, _16
# cross_sections.h:40:         qback = (qmom-qiso) / 2.0;
	vmulsd	.LC46(%rip), %xmm1, %xmm1	#, _16, qback
# cross_sections.h:42:         sigma[I_BACK][i] = qback;            // cross section for Ar+ / Ar backward elastic scattering
	vmovsd	%xmm1, 32000000(%rbp,%rax)	# qback, MEM[(double *)&sigma + 32000000B + ivtmp.585_22 * 8]
# cross_sections.h:35:     for(i=0; i<CS_RANGES; i++){
	cmpq	$1000000, %rbx	#, ivtmp.585
	jne	.L120	#,
# cross_sections.h:44: }
	addq	$40, %rsp	#,
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE3841:
	.size	_Z25set_ion_cross_sections_arv, .-_Z25set_ion_cross_sections_arv
	.section	.text._Z25calc_total_cross_sectionsv,"axG",@progbits,_Z25calc_total_cross_sectionsv,comdat
	.p2align 4
	.weak	_Z25calc_total_cross_sectionsv
	.type	_Z25calc_total_cross_sectionsv, @function
_Z25calc_total_cross_sectionsv:
.LFB3842:
	.cfi_startproc
	endbr64	
	vbroadcastsd	.LC48(%rip), %zmm1	#, tmp116
	leaq	sigma(%rip), %rsi	#, tmp100
	leaq	sigma_tot_e(%rip), %rcx	#, ivtmp.629
	leaq	sigma_tot_i(%rip), %rdx	#, ivtmp.638
	leaq	24000000(%rsi), %rax	#, ivtmp.627
	addq	$32000000, %rsi	#, _42
	.p2align 4
	.p2align 3
.L125:
# cross_sections.h:50:         sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY;   // total macroscopic cross section of electrons
	vmovupd	-16000000(%rax), %zmm2	# MEM <vector(8) double> [(double *)_9 + -16000000B], tmp118
	vaddpd	-24000000(%rax), %zmm2, %zmm0	# MEM <vector(8) double> [(double *)_9 + -24000000B], tmp118, vect__3.604
	addq	$64, %rax	#, ivtmp.627
	addq	$64, %rcx	#, ivtmp.629
	addq	$64, %rdx	#, ivtmp.638
# cross_sections.h:50:         sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY;   // total macroscopic cross section of electrons
	vaddpd	-8000064(%rax), %zmm0, %zmm0	# MEM <vector(8) double> [(double *)_9 + -8000000B], vect__3.604, vect__5.608
# cross_sections.h:50:         sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY;   // total macroscopic cross section of electrons
	vmulpd	%zmm1, %zmm0, %zmm0	# tmp116, vect__5.608, vect__6.609
# cross_sections.h:50:         sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY;   // total macroscopic cross section of electrons
	vmovupd	%zmm0, -64(%rcx)	# vect__6.609, MEM <vector(8) double> [(double *)_30]
# cross_sections.h:51:         sigma_tot_i[i] = (sigma[I_ISO][i] + sigma[I_BACK][i]) * GAS_DENSITY;                    // total macroscopic cross section of ions
	vmovupd	-64(%rax), %zmm3	# MEM <vector(8) double> [(double *)_9], tmp119
	vaddpd	7999936(%rax), %zmm3, %zmm0	# MEM <vector(8) double> [(double *)_9 + 8000000B], tmp119, vect__9.618
# cross_sections.h:51:         sigma_tot_i[i] = (sigma[I_ISO][i] + sigma[I_BACK][i]) * GAS_DENSITY;                    // total macroscopic cross section of ions
	vmulpd	%zmm1, %zmm0, %zmm0	# tmp116, vect__9.618, vect__10.619
# cross_sections.h:51:         sigma_tot_i[i] = (sigma[I_ISO][i] + sigma[I_BACK][i]) * GAS_DENSITY;                    // total macroscopic cross section of ions
	vmovupd	%zmm0, -64(%rdx)	# vect__10.619, MEM <vector(8) double> [(double *)_25]
	cmpq	%rsi, %rax	# _42, ivtmp.627
	jne	.L125	#,
	vzeroupper
# cross_sections.h:53: }
	ret	
	.cfi_endproc
.LFE3842:
	.size	_Z25calc_total_cross_sectionsv, .-_Z25calc_total_cross_sectionsv
	.section	.text._Z22max_electron_coll_freqv,"axG",@progbits,_Z22max_electron_coll_freqv,comdat
	.p2align 4
	.weak	_Z22max_electron_coll_freqv
	.type	_Z22max_electron_coll_freqv, @function
_Z22max_electron_coll_freqv:
.LFB3844:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	sigma_tot_e(%rip), %rbp	#, tmp103
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	xorl	%ebx, %ebx	# ivtmp.648
	subq	$24, %rsp	#,
	.cfi_def_cfa_offset 48
# cross_sections.h:71:     nu_max = 0;
	vxorpd	%xmm1, %xmm1, %xmm1	# <retval>
	vxorps	%xmm6, %xmm6, %xmm6	# tmp108
	vmovsd	.LC3(%rip), %xmm5	#, tmp104
	vmovsd	.LC51(%rip), %xmm4	#, tmp105
	vmovsd	.LC52(%rip), %xmm3	#, tmp106
	vmovsd	%xmm1, %xmm1, %xmm2	#, tmp100
	.p2align 4
	.p2align 3
.L132:
# cross_sections.h:73:         e  = i * DE_CS;
	vcvtsi2sdl	%ebx, %xmm6, %xmm0	# ivtmp.648, tmp108, tmp109
# cross_sections.h:73:         e  = i * DE_CS;
	vmulsd	%xmm5, %xmm0, %xmm0	# tmp104, tmp93, e
# cross_sections.h:74:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vaddsd	%xmm0, %xmm0, %xmm0	# e, e, tmp96
# cross_sections.h:74:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vmulsd	%xmm4, %xmm0, %xmm0	# tmp105, tmp96, tmp97
# cross_sections.h:74:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vdivsd	%xmm3, %xmm0, %xmm0	# tmp106, tmp97, _4
	vucomisd	%xmm0, %xmm2	# _4, tmp100
	ja	.L136	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _4, v
.L130:
# cross_sections.h:75:         nu = v * sigma_tot_e[i];
	vmulsd	0(%rbp,%rbx,8), %xmm0, %xmm0	# MEM[(double *)&sigma_tot_e + ivtmp.648_17 * 8], v, nu
# cross_sections.h:72:     for(i=0; i<CS_RANGES; i++){
	incq	%rbx	# ivtmp.648
# cross_sections.h:76:         if (nu > nu_max) {nu_max = nu;}
	vmaxsd	%xmm1, %xmm0, %xmm1	# <retval>, nu, <retval>
# cross_sections.h:72:     for(i=0; i<CS_RANGES; i++){
	cmpq	$1000000, %rbx	#, ivtmp.648
	jne	.L132	#,
# cross_sections.h:79: }
	addq	$24, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	vmovsd	%xmm1, %xmm1, %xmm0	# <retval>,
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
.L136:
	.cfi_restore_state
	vmovsd	%xmm1, 8(%rsp)	# <retval>, %sfp
# cross_sections.h:74:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	call	sqrt@PLT	#
	vxorps	%xmm6, %xmm6, %xmm6	# tmp108
	vmovsd	.LC52(%rip), %xmm3	#, tmp106
	vmovsd	.LC51(%rip), %xmm4	#, tmp105
	vmovsd	.LC3(%rip), %xmm5	#, tmp104
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp100
	vmovsd	8(%rsp), %xmm1	# %sfp, <retval>
	jmp	.L130	#
	.cfi_endproc
.LFE3844:
	.size	_Z22max_electron_coll_freqv, .-_Z22max_electron_coll_freqv
	.section	.text._Z17max_ion_coll_freqv,"axG",@progbits,_Z17max_ion_coll_freqv,comdat
	.p2align 4
	.weak	_Z17max_ion_coll_freqv
	.type	_Z17max_ion_coll_freqv, @function
_Z17max_ion_coll_freqv:
.LFB3845:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	sigma_tot_i(%rip), %rbp	#, tmp104
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	xorl	%ebx, %ebx	# ivtmp.661
	subq	$24, %rsp	#,
	.cfi_def_cfa_offset 48
# cross_sections.h:84:     nu_max = 0;
	vxorpd	%xmm1, %xmm1, %xmm1	# <retval>
	vxorps	%xmm6, %xmm6, %xmm6	# tmp108
	vmovsd	.LC3(%rip), %xmm5	#, tmp103
	vmovsd	.LC51(%rip), %xmm4	#, tmp105
	vmovsd	.LC53(%rip), %xmm3	#, tmp106
	vmovsd	%xmm1, %xmm1, %xmm2	#, tmp100
	.p2align 4
	.p2align 3
.L143:
# cross_sections.h:86:         e  = i * DE_CS;
	vcvtsi2sdl	%ebx, %xmm6, %xmm0	# ivtmp.661, tmp108, tmp109
# cross_sections.h:86:         e  = i * DE_CS;
	vmulsd	%xmm5, %xmm0, %xmm0	# tmp103, tmp93, e
# cross_sections.h:87:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vaddsd	%xmm0, %xmm0, %xmm0	# e, e, tmp96
# cross_sections.h:87:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vmulsd	%xmm4, %xmm0, %xmm0	# tmp105, tmp96, tmp97
# cross_sections.h:87:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vdivsd	%xmm3, %xmm0, %xmm0	# tmp106, tmp97, _4
	vucomisd	%xmm0, %xmm2	# _4, tmp100
	ja	.L147	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _4, g
.L141:
# cross_sections.h:88:         nu = g * sigma_tot_i[i];
	vmulsd	0(%rbp,%rbx,8), %xmm0, %xmm0	# MEM[(double *)&sigma_tot_i + ivtmp.661_17 * 8], g, nu
# cross_sections.h:85:     for(i=0; i<CS_RANGES; i++){
	incq	%rbx	# ivtmp.661
# cross_sections.h:89:         if (nu > nu_max) nu_max = nu;
	vmaxsd	%xmm1, %xmm0, %xmm1	# <retval>, nu, <retval>
# cross_sections.h:85:     for(i=0; i<CS_RANGES; i++){
	cmpq	$1000000, %rbx	#, ivtmp.661
	jne	.L143	#,
# cross_sections.h:92: }
	addq	$24, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	vmovsd	%xmm1, %xmm1, %xmm0	# <retval>,
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
.L147:
	.cfi_restore_state
	vmovsd	%xmm1, 8(%rsp)	# <retval>, %sfp
# cross_sections.h:87:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	call	sqrt@PLT	#
	vxorps	%xmm6, %xmm6, %xmm6	# tmp108
	vmovsd	.LC53(%rip), %xmm3	#, tmp106
	vmovsd	.LC51(%rip), %xmm4	#, tmp105
	vmovsd	.LC3(%rip), %xmm5	#, tmp103
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp100
	vmovsd	8(%rsp), %xmm1	# %sfp, <retval>
	jmp	.L141	#
	.cfi_endproc
.LFE3845:
	.size	_Z17max_ion_coll_freqv, .-_Z17max_ion_coll_freqv
	.section	.text._Z13solve_PoissonPdd,"axG",@progbits,_Z13solve_PoissonPdd,comdat
	.p2align 4
	.weak	_Z13solve_PoissonPdd
	.type	_Z13solve_PoissonPdd, @function
_Z13solve_PoissonPdd:
.LFB3846:
	.cfi_startproc
	endbr64	
	leaq	8(%rsp), %r10	#,
	.cfi_def_cfa 10, 0
	andq	$-64, %rsp	#,
	pushq	-8(%r10)	#
	pushq	%rbp	#
	movq	%rsp, %rbp	#,
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r10	#
	.cfi_escape 0xf,0x3,0x76,0x78,0x6
	pushq	%rbx	#
	subq	$4096, %rsp	#,
	orq	$0, (%rsp)	#,
	subq	$4096, %rsp	#,
	orq	$0, (%rsp)	#,
	subq	$1504, %rsp	#,
	.cfi_escape 0x10,0x3,0x2,0x76,0x70
# poisson.h:13:     pot[0]     = VOLTAGE * cos(OMEGA * tt);         // potential at the powered electrode
	vmulsd	.LC54(%rip), %xmm0, %xmm0	#, tmp243, tmp147
# poisson.h:6: inline void solve_Poisson (xvector rho1, double tt){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp245
	movq	%rax, -56(%rbp)	# tmp245, D.82580
	xorl	%eax, %eax	# tmp245
	movq	%rdi, %rbx	# tmp242, rho1
# poisson.h:13:     pot[0]     = VOLTAGE * cos(OMEGA * tt);         // potential at the powered electrode
	call	cos@PLT	#
	vbroadcastsd	.LC57(%rip), %zmm1	#, tmp234
# poisson.h:14:     pot[N_G-1] = 0.0;                               // potential at the grounded electrode
	movl	$8, %eax	#, ivtmp.800
	leaq	-9712(%rbp), %rsi	#, tmp240
# poisson.h:13:     pot[0]     = VOLTAGE * cos(OMEGA * tt);         // potential at the powered electrode
	vmulsd	.LC55(%rip), %xmm0, %xmm2	#, tmp244, _3
# poisson.h:14:     pot[N_G-1] = 0.0;                               // potential at the grounded electrode
	movq	$0x000000000, 3192+pot(%rip)	#, pot[399]
# poisson.h:13:     pot[0]     = VOLTAGE * cos(OMEGA * tt);         // potential at the powered electrode
	vmovsd	%xmm2, pot(%rip)	# _3, pot[0]
	.p2align 4
	.p2align 3
.L150:
# poisson.h:18:     for(i=1; i<=N_G-2; i++) f[i] = ALPHA * rho1[i];
	vmulpd	(%rbx,%rax), %zmm1, %zmm0	# MEM <vector(8) double> [(double *)rho1_66(D) + ivtmp.800_104 * 1], tmp234, vect__8.703
# poisson.h:18:     for(i=1; i<=N_G-2; i++) f[i] = ALPHA * rho1[i];
	vmovupd	%zmm0, (%rsi,%rax)	# vect__8.703, MEM <vector(8) double> [(double *)&f + ivtmp.800_104 * 1]
	addq	$64, %rax	#, ivtmp.800
	cmpq	$3144, %rax	#, ivtmp.800
	jne	.L150	#,
# poisson.h:18:     for(i=1; i<=N_G-2; i++) f[i] = ALPHA * rho1[i];
	vbroadcastsd	.LC57(%rip), %ymm0	#, tmp161
	vmulpd	3144(%rbx), %ymm0, %ymm0	# MEM <vector(4) double> [(double *)rho1_66(D) + 3144B], tmp161, vect__154.711
# poisson.h:24:     g[1] = f[1]/B;
	movl	$4, %eax	#, ivtmp.771
	leaq	-3264(%rbp), %rcx	#, tmp239
	leaq	-6464(%rbp), %rdx	#, tmp237
# poisson.h:23:     w[1] = C/B;
	vmovsd	.LC42(%rip), %xmm1	#, tmp167
	vmovsd	.LC60(%rip), %xmm3	#, tmp235
	vmovsd	%xmm1, -3256(%rbp)	# tmp167, w[1]
	vmovsd	.LC12(%rip), %xmm4	#, tmp236
# poisson.h:18:     for(i=1; i<=N_G-2; i++) f[i] = ALPHA * rho1[i];
	vmovupd	%ymm0, -6568(%rbp)	# vect__154.711, MEM <vector(4) double> [(double *)&f + 3144B]
# poisson.h:18:     for(i=1; i<=N_G-2; i++) f[i] = ALPHA * rho1[i];
	vmovddup	.LC57(%rip), %xmm0	#, tmp165
	vmulpd	3176(%rbx), %xmm0, %xmm0	# MEM <vector(2) double> [(double *)rho1_66(D) + 3176B], tmp165, vect__210.728
# poisson.h:18:     for(i=1; i<=N_G-2; i++) f[i] = ALPHA * rho1[i];
	vmovupd	%xmm0, -6536(%rbp)	# vect__210.728, MEM <vector(2) double> [(double *)&f + 3176B]
# poisson.h:19:     f[1] -= pot[0];
	vmovsd	-9704(%rbp), %xmm0	# f[1], f[1]
	vsubsd	%xmm2, %xmm0, %xmm0	# _3, f[1], _10
# poisson.h:24:     g[1] = f[1]/B;
	vmulsd	%xmm1, %xmm0, %xmm0	# tmp167, _10, g_I_lsm0.718
# poisson.h:24:     g[1] = f[1]/B;
	vmovsd	%xmm0, -6456(%rbp)	# g_I_lsm0.718, g[1]
.L151:
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vsubsd	%xmm1, %xmm3, %xmm1	# w_I_lsm0.719, tmp235, _14
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vmovsd	-16(%rsi,%rax,8), %xmm5	# MEM[(double *)&f + -16B + ivtmp.771_17 * 8], MEM[(double *)&f + -16B + ivtmp.771_17 * 8]
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vdivsd	%xmm1, %xmm4, %xmm6	# _14, tmp236, _15
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vsubsd	%xmm0, %xmm5, %xmm5	# g_I_lsm0.718, MEM[(double *)&f + -16B + ivtmp.771_17 * 8], tmp173
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vmovsd	%xmm6, -16(%rcx,%rax,8)	# _15, MEM[(double *)&w + -16B + ivtmp.771_17 * 8]
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vdivsd	%xmm1, %xmm5, %xmm5	# _14, tmp173, _21
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vsubsd	%xmm6, %xmm3, %xmm6	# _15, tmp235, _103
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vmovsd	-8(%rsi,%rax,8), %xmm0	# MEM[(double *)&f + -8B + ivtmp.771_17 * 8], MEM[(double *)&f + -8B + ivtmp.771_17 * 8]
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vmovsd	%xmm5, -16(%rdx,%rax,8)	# _21, MEM[(double *)&g + -16B + ivtmp.771_17 * 8]
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vdivsd	%xmm6, %xmm4, %xmm1	# _103, tmp236, w_I_lsm0.719
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vsubsd	%xmm5, %xmm0, %xmm0	# _21, MEM[(double *)&f + -8B + ivtmp.771_17 * 8], tmp180
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vmovsd	%xmm1, -8(%rcx,%rax,8)	# w_I_lsm0.719, MEM[(double *)&w + -8B + ivtmp.771_17 * 8]
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vdivsd	%xmm6, %xmm0, %xmm0	# _103, tmp180, g_I_lsm0.718
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vmovsd	%xmm0, -8(%rdx,%rax,8)	# g_I_lsm0.718, MEM[(double *)&g + -8B + ivtmp.771_17 * 8]
	addq	$2, %rax	#, ivtmp.771
	cmpq	$400, %rax	#, ivtmp.771
	jne	.L151	#,
# poisson.h:31:     pot[N_G-2] = g[N_G-2];
	movl	$3176, %eax	#, ivtmp.766
	leaq	pot(%rip), %rsi	#, ivtmp.750
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vsubsd	-88(%rbp), %xmm3, %xmm3	# w[397], tmp235, _220
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vmovsd	-6528(%rbp), %xmm0	# f[398], f[398]
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vdivsd	%xmm3, %xmm4, %xmm4	# _220, tmp236, tmp184
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vsubsd	-3288(%rbp), %xmm0, %xmm0	# g[397], f[398], tmp186
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vmovsd	%xmm4, -80(%rbp)	# tmp184, w[398]
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vdivsd	%xmm3, %xmm0, %xmm1	# _220, tmp186, _212
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vmovsd	%xmm1, -3280(%rbp)	# _212, g[398]
# poisson.h:31:     pot[N_G-2] = g[N_G-2];
	vmovsd	%xmm1, 3184+pot(%rip)	# _212, pot[398]
	vmovsd	%xmm1, %xmm1, %xmm0	# _212, pot_I_lsm0.721
	.p2align 4
	.p2align 3
.L152:
# poisson.h:32:     for (i=N_G-3; i>0; i--) pot[i] = g[i] - w[i] * pot[i+1];            // potential at the grid points between the electrodes
	vmovsd	(%rdx,%rax), %xmm7	# MEM[(double *)&g + ivtmp.766_13 * 1], tmp248
	vfnmadd132sd	(%rcx,%rax), %xmm7, %xmm0	# MEM[(double *)&w + ivtmp.766_13 * 1], tmp248, pot_I_lsm0.721
# poisson.h:32:     for (i=N_G-3; i>0; i--) pot[i] = g[i] - w[i] * pot[i+1];            // potential at the grid points between the electrodes
	vmovsd	%xmm0, (%rsi,%rax)	# pot_I_lsm0.721, MEM[(double *)&pot + ivtmp.766_13 * 1]
# poisson.h:32:     for (i=N_G-3; i>0; i--) pot[i] = g[i] - w[i] * pot[i+1];            // potential at the grid points between the electrodes
	subq	$8, %rax	#, ivtmp.766
	jne	.L152	#,
	vbroadcastsd	.LC62(%rip), %zmm3	#, tmp241
	leaq	8+efield(%rip), %rdx	#, ivtmp.746
	leaq	pot(%rip), %rax	#, ivtmp.750
	leaq	3136(%rdx), %rcx	#, _31
	.p2align 4
	.p2align 3
.L153:
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vmovupd	(%rax), %zmm6	# MEM <vector(8) double> [(double *)_175], tmp249
	vsubpd	16(%rax), %zmm6, %zmm0	# MEM <vector(8) double> [(double *)_175 + 16B], tmp249, vect__33.682
	addq	$64, %rdx	#, ivtmp.746
	addq	$64, %rax	#, ivtmp.750
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vmulpd	%zmm3, %zmm0, %zmm0	# tmp241, vect__33.682, vect__34.683
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vmovupd	%zmm0, -64(%rdx)	# vect__34.683, MEM <vector(8) double> [(double *)_180]
	cmpq	%rdx, %rcx	# ivtmp.746, _31
	jne	.L153	#,
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vmovupd	3136+pot(%rip), %ymm4	# MEM <vector(4) double> [(double *)&pot + 3136B], tmp250
	vsubpd	3152+pot(%rip), %ymm4, %ymm0	# MEM <vector(4) double> [(double *)&pot + 3152B], tmp250, vect__103.694
	vmovapd	3168+pot(%rip), %xmm5	# MEM <vector(2) double> [(double *)&pot + 3168B], tmp251
# poisson.h:37:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // powered electrode
	vmovsd	.LC67(%rip), %xmm4	#, tmp223
# poisson.h:37:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // powered electrode
	vsubsd	8+pot(%rip), %xmm2, %xmm2	# pot[1], _3, tmp217
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vmulpd	.LC62(%rip){1to4}, %ymm0, %ymm0	#, vect__103.694, vect__102.695
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vmovupd	%ymm0, 3144+efield(%rip)	# vect__102.695, MEM <vector(4) double> [(double *)&efield + 3144B]
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vsubpd	3184+pot(%rip), %xmm5, %xmm0	# MEM <vector(2) double> [(double *)&pot + 3184B], tmp251, vect__125.737
# poisson.h:37:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // powered electrode
	vmovsd	.LC66(%rip), %xmm5	#, tmp222
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vmulpd	.LC62(%rip){1to2}, %xmm0, %xmm0	#, vect__125.737, vect__228.738
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vmovupd	%xmm0, 3176+efield(%rip)	# vect__228.738, MEM <vector(2) double> [(double *)&efield + 3176B]
# poisson.h:37:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // powered electrode
	vmovsd	.LC65(%rip), %xmm0	#, tmp220
	vmulsd	(%rbx), %xmm0, %xmm3	# *rho1_66(D), tmp220, tmp218
# poisson.h:38:     efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + rho1[N_G-1] * DX / (2.0 * EPSILON0);   // grounded electrode
	vmulsd	3192(%rbx), %xmm0, %xmm0	# MEM[(double *)rho1_66(D) + 3192B], tmp220, tmp225
# poisson.h:37:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // powered electrode
	vdivsd	%xmm5, %xmm3, %xmm3	# tmp222, tmp218, tmp221
# poisson.h:38:     efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + rho1[N_G-1] * DX / (2.0 * EPSILON0);   // grounded electrode
	vdivsd	%xmm5, %xmm0, %xmm0	# tmp222, tmp225, tmp228
# poisson.h:37:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // powered electrode
	vfmsub132sd	%xmm4, %xmm3, %xmm2	# tmp223, tmp221, _42
# poisson.h:38:     efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + rho1[N_G-1] * DX / (2.0 * EPSILON0);   // grounded electrode
	vfmadd132sd	%xmm4, %xmm0, %xmm1	# tmp223, tmp228, _50
# poisson.h:37:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // powered electrode
	vmovsd	%xmm2, efield(%rip)	# _42, efield[0]
# poisson.h:38:     efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + rho1[N_G-1] * DX / (2.0 * EPSILON0);   // grounded electrode
	vmovsd	%xmm1, 3192+efield(%rip)	# _50, efield[399]
# poisson.h:39: }
	movq	-56(%rbp), %rax	# D.82580, tmp246
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp246
	jne	.L161	#,
	vzeroupper
	addq	$9696, %rsp	#,
	popq	%rbx	#
	popq	%r10	#
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%rbp	#
	leaq	-8(%r10), %rsp	#,
	.cfi_def_cfa 7, 8
	ret	
.L161:
	.cfi_restore_state
	vzeroupper
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE3846:
	.size	_Z13solve_PoissonPdd, .-_Z13solve_PoissonPdd
	.section	.text._Z19step2_solve_poissond.isra.0,"axG",@progbits,_Z12do_one_cyclev,comdat
	.p2align 4
	.type	_Z19step2_solve_poissond.isra.0, @function
_Z19step2_solve_poissond.isra.0:
.LFB4756:
	.cfi_startproc
	leaq	8(%rsp), %r10	#,
	.cfi_def_cfa 10, 0
	andq	$-64, %rsp	#,
	leaq	i_density(%rip), %rcx	#, tmp105
	leaq	e_density(%rip), %rdx	#, tmp102
	pushq	-8(%r10)	#
	pushq	%rbp	#
	movq	%rsp, %rbp	#,
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r10	#
	.cfi_escape 0xf,0x3,0x76,0x78,0x6
	subq	$3304, %rsp	#,
	vbroadcastsd	.LC51(%rip), %zmm1	#, tmp104
	leaq	-3312(%rbp), %rdi	#, tmp103
# simulation.h:64: inline void step2_solve_poisson(double current_time){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp106
	movq	%rax, -56(%rbp)	# tmp106, D.82611
	xorl	%eax, %eax	# tmp106
	.p2align 4
	.p2align 3
.L163:
# simulation.h:68:         rho[p] = E_CHARGE * (i_density[p] - e_density[p]);  // get charge density
	vmovupd	(%rcx,%rax), %zmm2	# MEM <vector(8) double> [(double *)&i_density + ivtmp.819_21 * 1], tmp109
	vsubpd	(%rdx,%rax), %zmm2, %zmm0	# MEM <vector(8) double> [(double *)&e_density + ivtmp.819_21 * 1], tmp109, vect__4.811
# simulation.h:68:         rho[p] = E_CHARGE * (i_density[p] - e_density[p]);  // get charge density
	vmulpd	%zmm1, %zmm0, %zmm0	# tmp104, vect__4.811, vect__5.812
# simulation.h:68:         rho[p] = E_CHARGE * (i_density[p] - e_density[p]);  // get charge density
	vmovapd	%zmm0, (%rdi,%rax)	# vect__5.812, MEM <vector(8) double> [(double *)&rho + ivtmp.819_21 * 1]
	addq	$64, %rax	#, ivtmp.819
	cmpq	$3200, %rax	#, ivtmp.819
	jne	.L163	#,
# simulation.h:70:     solve_Poisson(rho,Time);                                // compute potential and electric field
	vmovsd	Time(%rip), %xmm0	# Time,
	vzeroupper
	call	_Z13solve_PoissonPdd	#
# simulation.h:71: }
	movq	-56(%rbp), %rax	# D.82611, tmp107
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp107
	jne	.L168	#,
	movq	-8(%rbp), %r10	#,
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	leave	
	leaq	-8(%r10), %rsp	#,
	.cfi_def_cfa 7, 8
	ret	
.L168:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE4756:
	.size	_Z19step2_solve_poissond.isra.0, .-_Z19step2_solve_poissond.isra.0
	.section	.rodata._Z29compute_null_collision_paramsv.str1.8,"aMS",@progbits,1
	.align 8
.LC71:
	.string	">> eduPIC: null-collision: nu*_e = %e, P*_e = %e\n"
	.align 8
.LC72:
	.string	">> eduPIC: null-collision: nu*_i = %e, P*_i = %e\n"
	.section	.text._Z29compute_null_collision_paramsv,"axG",@progbits,_Z29compute_null_collision_paramsv,comdat
	.p2align 4
	.weak	_Z29compute_null_collision_paramsv
	.type	_Z29compute_null_collision_paramsv, @function
_Z29compute_null_collision_paramsv:
.LFB3849:
	.cfi_startproc
	endbr64	
	subq	$24, %rsp	#,
	.cfi_def_cfa_offset 32
# null_collision.h:14:     nu_star_e = max_electron_coll_freq();
	call	_Z22max_electron_coll_freqv	#
	vmovsd	%xmm0, %xmm0, %xmm2	# tmp109, _1
# null_collision.h:14:     nu_star_e = max_electron_coll_freq();
	vmovsd	%xmm0, nu_star_e(%rip)	# _1, nu_star_e
# null_collision.h:15:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	vmovsd	%xmm2, 8(%rsp)	# _1, %sfp
	vmulsd	.LC73(%rip), %xmm0, %xmm0	#, _1, tmp96
	call	exp@PLT	#
# null_collision.h:15:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	vmovsd	.LC12(%rip), %xmm3	#, tmp114
	vsubsd	%xmm0, %xmm3, %xmm1	# tmp110, tmp114, _5
# null_collision.h:15:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	vmovsd	%xmm1, (%rsp)	# _5, %sfp
	vmovsd	%xmm1, P_star_e(%rip)	# _5, P_star_e
# null_collision.h:18:     nu_star_i = max_ion_coll_freq();
	call	_Z17max_ion_coll_freqv	#
# null_collision.h:18:     nu_star_i = max_ion_coll_freq();
	vmovsd	%xmm0, nu_star_i(%rip)	# _6, nu_star_i
# null_collision.h:19:     P_star_i = 1.0 - exp(-nu_star_i * DT_I);
	vmulsd	.LC74(%rip), %xmm0, %xmm0	#, _6, tmp101
	call	exp@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC71(%rip), %rsi	#, tmp105
	movl	$2, %edi	#,
	movl	$2, %eax	#,
	vmovsd	(%rsp), %xmm1	# %sfp, _5
	vmovsd	8(%rsp), %xmm2	# %sfp, _1
# null_collision.h:19:     P_star_i = 1.0 - exp(-nu_star_i * DT_I);
	vmovsd	.LC12(%rip), %xmm4	#, tmp115
	vsubsd	%xmm0, %xmm4, %xmm0	# tmp112, tmp115, tmp103
# null_collision.h:19:     P_star_i = 1.0 - exp(-nu_star_i * DT_I);
	vmovsd	%xmm0, P_star_i(%rip)	# tmp103, P_star_i
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	vmovsd	%xmm2, %xmm2, %xmm0	# _1,
	call	__printf_chk@PLT	#
	vmovsd	P_star_i(%rip), %xmm1	# P_star_i,
	vmovsd	nu_star_i(%rip), %xmm0	# nu_star_i,
	leaq	.LC72(%rip), %rsi	#, tmp108
	movl	$2, %edi	#,
	movl	$2, %eax	#,
# null_collision.h:23: }
	addq	$24, %rsp	#,
	.cfi_def_cfa_offset 8
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	jmp	__printf_chk@PLT	#
	.cfi_endproc
.LFE3849:
	.size	_Z29compute_null_collision_paramsv, .-_Z29compute_null_collision_paramsv
	.section	.text._ZNSt12_Vector_baseIiSaIiEE12_Vector_implD2Ev,"axG",@progbits,_ZNSt12_Vector_baseIiSaIiEE12_Vector_implD5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt12_Vector_baseIiSaIiEE12_Vector_implD2Ev
	.type	_ZNSt12_Vector_baseIiSaIiEE12_Vector_implD2Ev, @function
_ZNSt12_Vector_baseIiSaIiEE12_Vector_implD2Ev:
.LFB3855:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_vector.h:133:       struct _Vector_impl
	ret	
	.cfi_endproc
.LFE3855:
	.size	_ZNSt12_Vector_baseIiSaIiEE12_Vector_implD2Ev, .-_ZNSt12_Vector_baseIiSaIiEE12_Vector_implD2Ev
	.weak	_ZNSt12_Vector_baseIiSaIiEE12_Vector_implD1Ev
	.set	_ZNSt12_Vector_baseIiSaIiEE12_Vector_implD1Ev,_ZNSt12_Vector_baseIiSaIiEE12_Vector_implD2Ev
	.section	.text._Z30step1_compute_electron_densityv,"axG",@progbits,_Z30step1_compute_electron_densityv,comdat
	.p2align 4
	.weak	_Z30step1_compute_electron_densityv
	.type	_Z30step1_compute_electron_densityv, @function
_Z30step1_compute_electron_densityv:
.LFB3863:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
# simulation.h:30:     for(p=0; p<N_G; p++) e_density[p] = 0;
	movl	$3200, %edx	#,
	leaq	e_density(%rip), %rdi	#, ivtmp.859
	xorl	%esi, %esi	#
# simulation.h:24: inline void step1_compute_electron_density(void){
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	andq	$-64, %rsp	#,
# simulation.h:30:     for(p=0; p<N_G; p++) e_density[p] = 0;
	call	memset@PLT	#
# simulation.h:33:     for(k=0; k<N_e; k++){
	movslq	N_e(%rip), %rdx	# N_e,
	testl	%edx, %edx	# N_e.47_43
	jle	.L173	#,
	movq	%rax, %rdi	#, ivtmp.859
	leaq	x_e(%rip), %rax	#, ivtmp.866
	vxorps	%xmm3, %xmm3, %xmm3	# tmp147
	vmovsd	.LC67(%rip), %xmm5	#, tmp144
	leaq	(%rax,%rdx,8), %r8	#, _45
	vmovddup	.LC76(%rip), %xmm4	#, tmp146
	.p2align 4
	.p2align 3
.L174:
# simulation.h:34:         c0 = x_e[k] * INV_DX;
	vmulsd	(%rax), %xmm5, %xmm1	# MEM[(double *)_56], tmp144, c0
# simulation.h:35:         p  = int(c0);
	vcvttsd2sil	%xmm1, %edx	# c0, p
	movslq	%edx, %rcx	# p, p
# simulation.h:36:         e_density[p]   += (p + 1 - c0) * FACTOR_W;
	leal	1(%rdx), %esi	#, tmp125
	leaq	(%rdi,%rcx,8), %rcx	#, vectp.849
# simulation.h:33:     for(k=0; k<N_e; k++){
	addq	$8, %rax	#, ivtmp.866
# simulation.h:36:         e_density[p]   += (p + 1 - c0) * FACTOR_W;
	vcvtsi2sdl	%esi, %xmm3, %xmm0	# tmp125, tmp147, tmp148
# simulation.h:37:         e_density[p+1] += (c0 - p) * FACTOR_W;
	vcvtsi2sdl	%edx, %xmm3, %xmm2	# p, tmp147, tmp149
# simulation.h:36:         e_density[p]   += (p + 1 - c0) * FACTOR_W;
	vsubsd	%xmm1, %xmm0, %xmm0	# c0, tmp126, tmp127
# simulation.h:37:         e_density[p+1] += (c0 - p) * FACTOR_W;
	vsubsd	%xmm2, %xmm1, %xmm1	# tmp128, c0, tmp129
# simulation.h:36:         e_density[p]   += (p + 1 - c0) * FACTOR_W;
	vunpcklpd	%xmm1, %xmm0, %xmm0	# tmp129, tmp127, tmp124
	vfmadd213pd	(%rcx), %xmm4, %xmm0	# MEM <vector(2) double> [(double *)vectp.849_77], tmp146, vect__7.852
	vmovupd	%xmm0, (%rcx)	# vect__7.852, MEM <vector(2) double> [(double *)vectp.849_77]
# simulation.h:33:     for(k=0; k<N_e; k++){
	cmpq	%rax, %r8	# ivtmp.866, _45
	jne	.L174	#,
.L173:
	leaq	e_density(%rip), %rdx	#, ivtmp.859
	leaq	cumul_e_density(%rip), %rax	#, ivtmp.860
# simulation.h:40:     e_density[0]     *= 2.0;
	vmovsd	e_density(%rip), %xmm0	# e_density[0], e_density[0]
	vaddsd	%xmm0, %xmm0, %xmm0	# e_density[0], e_density[0], tmp136
	leaq	3200(%rdx), %rcx	#, _60
	vmovsd	%xmm0, e_density(%rip)	# tmp136, e_density[0]
# simulation.h:41:     e_density[N_G-1] *= 2.0;
	vmovsd	3192+e_density(%rip), %xmm0	# e_density[399], e_density[399]
	vaddsd	%xmm0, %xmm0, %xmm0	# e_density[399], e_density[399], tmp140
	vmovsd	%xmm0, 3192+e_density(%rip)	# tmp140, e_density[399]
	.p2align 4
	.p2align 3
.L175:
# simulation.h:43:     for(p=0; p<N_G; p++) cumul_e_density[p] += e_density[p];
	vmovupd	(%rdx), %zmm6	# MEM <vector(8) double> [(double *)_62], tmp151
	vaddpd	(%rax), %zmm6, %zmm0	# MEM <vector(8) double> [(double *)_64], tmp151, vect__20.844
	addq	$64, %rdx	#, ivtmp.859
	addq	$64, %rax	#, ivtmp.860
	vmovupd	%zmm0, -64(%rax)	# vect__20.844, MEM <vector(8) double> [(double *)_64]
	cmpq	%rcx, %rdx	# _60, ivtmp.859
	jne	.L175	#,
	vzeroupper
# simulation.h:44: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE3863:
	.size	_Z30step1_compute_electron_densityv, .-_Z30step1_compute_electron_densityv
	.section	.text._Z25step1_compute_ion_densityi,"axG",@progbits,_Z25step1_compute_ion_densityi,comdat
	.p2align 4
	.weak	_Z25step1_compute_ion_densityi
	.type	_Z25step1_compute_ion_densityi, @function
_Z25step1_compute_ion_densityi:
.LFB3864:
	.cfi_startproc
	endbr64	
	imull	$-858993459, %edi, %eax	#, tmp163, tmp125
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	andq	$-64, %rsp	#,
# simulation.h:46: inline void step1_compute_ion_density(int t){    
	addl	$429496728, %eax	#, tmp126
	rorx	$2, %eax, %eax	#, tmp126, tmp127
# simulation.h:50:     if ((t % N_SUB) == 0) {                                            // ion density - computed in every N_SUB-th time steps (subcycling)
	cmpl	$214748364, %eax	#, tmp127
	ja	.L180	#,
# simulation.h:51:         for(p=0; p<N_G; p++) i_density[p] = 0;
	leaq	i_density(%rip), %rdi	#, ivtmp.895
	movl	$3200, %edx	#,
	xorl	%esi, %esi	#
	call	memset@PLT	#
# simulation.h:52:         for(k=0; k<N_i; k++){
	movslq	N_i(%rip), %rdx	# N_i,
# simulation.h:51:         for(p=0; p<N_G; p++) i_density[p] = 0;
	movq	%rax, %rdi	#, ivtmp.895
# simulation.h:52:         for(k=0; k<N_i; k++){
	testl	%edx, %edx	# N_i.48_47
	jle	.L181	#,
	leaq	x_i(%rip), %rax	#, ivtmp.902
	vxorps	%xmm3, %xmm3, %xmm3	# tmp164
	vmovsd	.LC67(%rip), %xmm5	#, tmp162
	vmovddup	.LC76(%rip), %xmm4	#, tmp161
	leaq	(%rax,%rdx,8), %r8	#, _54
	.p2align 4
	.p2align 3
.L182:
# simulation.h:53:             c0 = x_i[k] * INV_DX;
	vmulsd	(%rax), %xmm5, %xmm1	# MEM[(double *)_61], tmp162, c0
# simulation.h:54:             p  = int(c0);
	vcvttsd2sil	%xmm1, %edx	# c0, p
	movslq	%edx, %rcx	# p, p
# simulation.h:55:             i_density[p]   += (p + 1 - c0) * FACTOR_W;  
	leal	1(%rdx), %esi	#, tmp141
	leaq	(%rdi,%rcx,8), %rcx	#, vectp.885
# simulation.h:52:         for(k=0; k<N_i; k++){
	addq	$8, %rax	#, ivtmp.902
# simulation.h:55:             i_density[p]   += (p + 1 - c0) * FACTOR_W;  
	vcvtsi2sdl	%esi, %xmm3, %xmm0	# tmp141, tmp164, tmp165
# simulation.h:56:             i_density[p+1] += (c0 - p) * FACTOR_W;
	vcvtsi2sdl	%edx, %xmm3, %xmm2	# p, tmp164, tmp166
# simulation.h:55:             i_density[p]   += (p + 1 - c0) * FACTOR_W;  
	vsubsd	%xmm1, %xmm0, %xmm0	# c0, tmp142, tmp143
# simulation.h:56:             i_density[p+1] += (c0 - p) * FACTOR_W;
	vsubsd	%xmm2, %xmm1, %xmm1	# tmp144, c0, tmp145
# simulation.h:55:             i_density[p]   += (p + 1 - c0) * FACTOR_W;  
	vunpcklpd	%xmm1, %xmm0, %xmm0	# tmp145, tmp143, tmp140
	vfmadd213pd	(%rcx), %xmm4, %xmm0	# MEM <vector(2) double> [(double *)vectp.885_81], tmp161, vect__8.888
	vmovupd	%xmm0, (%rcx)	# vect__8.888, MEM <vector(2) double> [(double *)vectp.885_81]
# simulation.h:52:         for(k=0; k<N_i; k++){
	cmpq	%rax, %r8	# ivtmp.902, _54
	jne	.L182	#,
.L181:
# simulation.h:58:         i_density[0]     *= 2.0;
	vmovsd	i_density(%rip), %xmm0	# i_density[0], i_density[0]
	vaddsd	%xmm0, %xmm0, %xmm0	# i_density[0], i_density[0], tmp152
	vmovsd	%xmm0, i_density(%rip)	# tmp152, i_density[0]
# simulation.h:59:         i_density[N_G-1] *= 2.0;
	vmovsd	3192+i_density(%rip), %xmm0	# i_density[399], i_density[399]
	vaddsd	%xmm0, %xmm0, %xmm0	# i_density[399], i_density[399], tmp156
	vmovsd	%xmm0, 3192+i_density(%rip)	# tmp156, i_density[399]
.L180:
	leaq	i_density(%rip), %rdx	#, ivtmp.895
	leaq	cumul_i_density(%rip), %rax	#, ivtmp.896
	leaq	3200(%rdx), %rcx	#, _65
	.p2align 4
	.p2align 3
.L183:
# simulation.h:61:     for(p=0; p<N_G; p++) cumul_i_density[p] += i_density[p];
	vmovupd	(%rdx), %zmm6	# MEM <vector(8) double> [(double *)_67], tmp168
	vaddpd	(%rax), %zmm6, %zmm0	# MEM <vector(8) double> [(double *)_37], tmp168, vect__22.880
	addq	$64, %rdx	#, ivtmp.895
	addq	$64, %rax	#, ivtmp.896
	vmovupd	%zmm0, -64(%rax)	# vect__22.880, MEM <vector(8) double> [(double *)_37]
	cmpq	%rcx, %rdx	# _65, ivtmp.895
	jne	.L183	#,
	vzeroupper
# simulation.h:62: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE3864:
	.size	_Z25step1_compute_ion_densityi, .-_Z25step1_compute_ion_densityi
	.section	.text._Z20step3_move_electronsi,"axG",@progbits,_Z20step3_move_electronsi,comdat
	.p2align 4
	.weak	_Z20step3_move_electronsi
	.type	_Z20step3_move_electronsi, @function
_Z20step3_move_electronsi:
.LFB3866:
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
# simulation.h:73: inline void step3_move_electrons(int t_index){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp348
	movq	%rax, 24(%rsp)	# tmp348, D.82720
	xorl	%eax, %eax	# tmp348
# simulation.h:77:     for(k=0; k<N_e; k++){                       // move all electrons in every time step
	movslq	N_e(%rip), %rax	# N_e,
	testl	%eax, %eax	# N_e.53_105
	jle	.L188	#,
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	vxorps	%xmm8, %xmm8, %xmm8	# tmp345
	jne	.L190	#,
	leaq	x_e(%rip), %rdx	#, ivtmp.913
	leaq	vx_e(%rip), %rcx	#, ivtmp.914
	leaq	efield(%rip), %r15	#, tmp324
	vmovsd	.LC67(%rip), %xmm7	#, tmp326
	leaq	(%rdx,%rax,8), %rdi	#, _142
	vmovsd	.LC12(%rip), %xmm6	#, tmp328
	vmovsd	.LC77(%rip), %xmm5	#, tmp339
	vmovsd	.LC69(%rip), %xmm4	#, tmp327
	.p2align 4
	.p2align 3
.L191:
# simulation.h:80:         c0  = x_e[k] * INV_DX;
	vmovsd	(%rdx), %xmm3	# MEM[(double *)_177], _157
# simulation.h:80:         c0  = x_e[k] * INV_DX;
	vmulsd	%xmm7, %xmm3, %xmm1	# tmp326, _157, c0
# simulation.h:81:         p   = int(c0);
	vcvttsd2sil	%xmm1, %eax	# c0, p
# simulation.h:82:         c1  = p + 1.0 - c0;
	vcvtsi2sdl	%eax, %xmm8, %xmm2	# p, tmp345, tmp346
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%eax, %rsi	# p, p
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	incl	%eax	# tmp186
# simulation.h:82:         c1  = p + 1.0 - c0;
	vaddsd	%xmm6, %xmm2, %xmm0	# tmp328, _154, tmp182
# simulation.h:82:         c1  = p + 1.0 - c0;
	vsubsd	%xmm1, %xmm0, %xmm0	# c0, tmp182, c1
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	cltq
# simulation.h:83:         c2  = c0 - p;
	vsubsd	%xmm2, %xmm1, %xmm1	# _154, c0, c2
# simulation.h:77:     for(k=0; k<N_e; k++){                       // move all electrons in every time step
	addq	$8, %rdx	#, ivtmp.913
	addq	$8, %rcx	#, ivtmp.914
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vmulsd	(%r15,%rax,8), %xmm1, %xmm1	# efield[_148], c2, tmp189
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vfmadd132sd	(%r15,%rsi,8), %xmm1, %xmm0	# efield[p_155], tmp189, e_x
# simulation.h:115:         vx_e[k] -= e_x * FACTOR_E;
	vfnmadd213sd	-8(%rcx), %xmm5, %xmm0	# MEM[(double *)_179], tmp339, _187
	vmovsd	%xmm0, -8(%rcx)	# _187, MEM[(double *)_179]
# simulation.h:116:         x_e[k]  += vx_e[k] * DT_E;
	vfmadd132sd	%xmm4, %xmm3, %xmm0	# tmp327, _157, _190
	vmovsd	%xmm0, -8(%rdx)	# _190, MEM[(double *)_177]
# simulation.h:77:     for(k=0; k<N_e; k++){                       // move all electrons in every time step
	cmpq	%rdx, %rdi	# ivtmp.913, _142
	jne	.L191	#,
.L188:
# simulation.h:118: }
	movq	24(%rsp), %rax	# D.82720, tmp349
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp349
	jne	.L206	#,
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
.L190:
	.cfi_restore_state
	leaq	x_e(%rip), %r14	#, ivtmp.920
	leaq	20(%rsp), %rsi	#, tmp333
	movslq	%edi, %r13	# t_index, t_index
	leaq	vx_e(%rip), %rbx	#, ivtmp.921
	leaq	(%r14,%rax,8), %rax	#, _120
	leaq	vy_e(%rip), %r12	#, ivtmp.922
	leaq	vz_e(%rip), %rbp	#, ivtmp.923
	leaq	efield(%rip), %r15	#, tmp324
	movq	%rax, 8(%rsp)	# _120, %sfp
	leaq	sigma(%rip), %rax	#, tmp338
	leaq	counter_e_xt(%rip), %r11	#, tmp325
	leaq	ue_xt(%rip), %r10	#, tmp329
	leaq	meanee_xt(%rip), %r9	#, tmp332
	leaq	16(%rsp), %rdi	#, tmp331
	vmovq	%rax, %xmm9	# tmp338, tmp338
	leaq	ioniz_rate_xt(%rip), %r8	#, tmp323
# simulation.h:106:             if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)){
	vmovq	%rsi, %xmm13	# tmp333, tmp333
	vmovsd	.LC67(%rip), %xmm7	#, tmp326
	vmovsd	.LC12(%rip), %xmm6	#, tmp328
	vmovsd	.LC77(%rip), %xmm5	#, tmp339
	vmovsd	.LC69(%rip), %xmm4	#, tmp327
	vmovsd	.LC46(%rip), %xmm10	#, tmp334
	vmovsd	.LC78(%rip), %xmm16	#, tmp340
	vmovsd	.LC51(%rip), %xmm15	#, tmp330
	vmovsd	.LC3(%rip), %xmm14	#, tmp337
	vmovsd	.LC48(%rip), %xmm12	#, tmp335
	vmovsd	.LC79(%rip), %xmm11	#, tmp341
	vmovsd	.LC80(%rip), %xmm17	#, tmp342
	.p2align 4
	.p2align 3
.L197:
# simulation.h:80:         c0  = x_e[k] * INV_DX;
	vmovsd	(%r14), %xmm18	# MEM[(double *)_129], _1
# simulation.h:80:         c0  = x_e[k] * INV_DX;
	vmulsd	%xmm7, %xmm18, %xmm1	# tmp326, _1, c0
# simulation.h:81:         p   = int(c0);
	vcvttsd2sil	%xmm1, %edx	# c0, p
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	leal	1(%rdx), %ecx	#, _6
# simulation.h:82:         c1  = p + 1.0 - c0;
	vcvtsi2sdl	%edx, %xmm8, %xmm0	# p, tmp345, tmp347
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%ecx, %rcx	# _6, _6
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%edx, %rdx	# p, p
# simulation.h:82:         c1  = p + 1.0 - c0;
	vaddsd	%xmm6, %xmm0, %xmm3	# tmp328, _2, tmp195
# simulation.h:90:             mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E;
	vmovsd	(%rbx), %xmm19	# MEM[(double *)_127], pretmp_162
# simulation.h:82:         c1  = p + 1.0 - c0;
	vsubsd	%xmm1, %xmm3, %xmm3	# c0, tmp195, c1
# simulation.h:83:         c2  = c0 - p;
	vsubsd	%xmm0, %xmm1, %xmm1	# _2, c0, c2
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vmulsd	(%r15,%rcx,8), %xmm1, %xmm2	# efield[_6], c2, tmp201
# simulation.h:92:             counter_e_xt[p+1][t_index] += c2;
	imulq	$200, %rcx, %rcx	#, _6, tmp220
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vfmadd231sd	(%r15,%rdx,8), %xmm3, %xmm2	# efield[p_68], c1, e_x
# simulation.h:90:             mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E;
	vmulsd	%xmm10, %xmm2, %xmm0	# tmp334, e_x, tmp202
# simulation.h:90:             mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E;
	vfnmadd132sd	%xmm5, %xmm19, %xmm0	# tmp339, pretmp_162, mean_v
# simulation.h:91:             counter_e_xt[p][t_index]   += c1;
	imulq	$200, %rdx, %rdx	#, p, tmp208
# simulation.h:99:             energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
	vmovq	%xmm13, %rsi	# tmp333,
# simulation.h:97:             meanee_xt[p][t_index]   += c1 * energy;
	vmovsd	%xmm3, %xmm3, %xmm21	# c1, _32
# simulation.h:99:             energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
	movl	$999999, 20(%rsp)	#, D.72182
# simulation.h:92:             counter_e_xt[p+1][t_index] += c2;
	addq	%r13, %rcx	# t_index, tmp221
# simulation.h:91:             counter_e_xt[p][t_index]   += c1;
	addq	%r13, %rdx	# t_index, tmp209
	vaddsd	(%r11,%rdx,8), %xmm3, %xmm20	# counter_e_xt[p_68][t_index_73(D)], c1, tmp215
	vmovsd	%xmm20, (%r11,%rdx,8)	# tmp215, counter_e_xt[p_68][t_index_73(D)]
# simulation.h:92:             counter_e_xt[p+1][t_index] += c2;
	vaddsd	(%r11,%rcx,8), %xmm1, %xmm20	# counter_e_xt[_6][t_index_73(D)], c2, tmp227
	vmovsd	%xmm20, (%r11,%rcx,8)	# tmp227, counter_e_xt[_6][t_index_73(D)]
# simulation.h:93:             ue_xt[p][t_index]   += c1 * mean_v;
	vmovsd	%xmm3, %xmm3, %xmm20	# c1, _19
	vfmadd213sd	(%r10,%rdx,8), %xmm0, %xmm20	# ue_xt[p_68][t_index_73(D)], mean_v, _19
	vmovsd	%xmm20, (%r10,%rdx,8)	# _19, ue_xt[p_68][t_index_73(D)]
# simulation.h:94:             ue_xt[p+1][t_index] += c2 * mean_v;
	vmovsd	%xmm1, %xmm1, %xmm20	# c2, _22
	vfmadd213sd	(%r10,%rcx,8), %xmm0, %xmm20	# ue_xt[_6][t_index_73(D)], mean_v, _22
	vmovsd	%xmm20, (%r10,%rcx,8)	# _22, ue_xt[_6][t_index_73(D)]
# simulation.h:95:             v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vmovsd	(%r12), %xmm20	# MEM[(double *)_125], _24
# simulation.h:95:             v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vmulsd	%xmm20, %xmm20, %xmm20	# _24, _24, tmp249
# simulation.h:95:             v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vfmadd231sd	%xmm0, %xmm0, %xmm20	# mean_v, mean_v, _26
# simulation.h:95:             v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vmovsd	0(%rbp), %xmm0	# MEM[(double *)_124], _27
# simulation.h:95:             v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vfmadd132sd	%xmm0, %xmm20, %xmm0	# _27, _26, v_sqr
# simulation.h:96:             energy = 0.5 * E_MASS * v_sqr / EV_TO_J;
	vmulsd	%xmm16, %xmm0, %xmm20	# tmp340, v_sqr, tmp250
# simulation.h:96:             energy = 0.5 * E_MASS * v_sqr / EV_TO_J;
	vdivsd	%xmm15, %xmm20, %xmm20	# tmp330, tmp250, energy
# simulation.h:97:             meanee_xt[p][t_index]   += c1 * energy;
	vfmadd213sd	(%r9,%rdx,8), %xmm20, %xmm21	# meanee_xt[p_68][t_index_73(D)], energy, _32
	vmovsd	%xmm21, (%r9,%rdx,8)	# _32, meanee_xt[p_68][t_index_73(D)]
# simulation.h:98:             meanee_xt[p+1][t_index] += c2 * energy;
	vmovsd	%xmm1, %xmm1, %xmm21	# c2, _35
	vfmadd213sd	(%r9,%rcx,8), %xmm20, %xmm21	# meanee_xt[_6][t_index_73(D)], energy, _35
	vmovsd	%xmm21, (%r9,%rcx,8)	# _35, meanee_xt[_6][t_index_73(D)]
# simulation.h:99:             energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
	vdivsd	%xmm14, %xmm20, %xmm21	# tmp337, energy, tmp273
# simulation.h:99:             energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
	vaddsd	%xmm10, %xmm21, %xmm21	# tmp334, tmp273, tmp275
# simulation.h:99:             energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
	vcvttsd2sil	%xmm21, %eax	# tmp275, tmp277
	movl	%eax, 16(%rsp)	# tmp277, D.72181
# simulation.h:99:             energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
	call	_ZSt3minIiERKT_S2_S2_.constprop.0	#
# simulation.h:101:             rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	movslq	(%rax), %rax	# *_39, energy_index
# simulation.h:101:             rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	vmovq	%xmm9, %rsi	# tmp338, tmp338
# simulation.h:100:             velocity = sqrt(v_sqr);
	vsqrtsd	%xmm0, %xmm0, %xmm0	# v_sqr, velocity
# simulation.h:106:             if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)){
	vcomisd	%xmm11, %xmm18	# tmp341, _1
# simulation.h:101:             rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	vmulsd	16000000(%rsi,%rax,8), %xmm0, %xmm0	# sigma[2][energy_index_84], velocity, tmp283
# simulation.h:101:             rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	vmulsd	%xmm4, %xmm0, %xmm0	# tmp327, tmp283, tmp284
# simulation.h:101:             rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	vmulsd	%xmm12, %xmm0, %xmm0	# tmp335, tmp284, rate
# simulation.h:102:             ioniz_rate_xt[p][t_index]   += c1 * rate;
	vfmadd213sd	(%r8,%rdx,8), %xmm0, %xmm3	# ioniz_rate_xt[p_68][t_index_73(D)], rate, _45
	vmovsd	%xmm3, (%r8,%rdx,8)	# _45, ioniz_rate_xt[p_68][t_index_73(D)]
# simulation.h:103:             ioniz_rate_xt[p+1][t_index] += c2 * rate;
	vfmadd213sd	(%r8,%rcx,8), %xmm1, %xmm0	# ioniz_rate_xt[_6][t_index_73(D)], c2, _48
	vmovsd	%xmm0, (%r8,%rcx,8)	# _48, ioniz_rate_xt[_6][t_index_73(D)]
# simulation.h:106:             if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)){
	jbe	.L193	#,
# simulation.h:106:             if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)){
	vcomisd	%xmm18, %xmm17	# _1, tmp342
	jbe	.L193	#,
# simulation.h:107:                 energy_index = (int)(energy / DE_EEPF);
	vdivsd	.LC20(%rip), %xmm20, %xmm0	#, energy, tmp309
# simulation.h:107:                 energy_index = (int)(energy / DE_EEPF);
	vcvttsd2sil	%xmm0, %eax	# tmp309, energy_index
# simulation.h:108:                 if (energy_index < N_EEPF) {eepf[energy_index] += 1.0;}
	cmpl	$1999, %eax	#, energy_index
	jle	.L207	#,
.L196:
# simulation.h:109:                 mean_energy_accu_center += energy;
	vaddsd	mean_energy_accu_center(%rip), %xmm20, %xmm20	# mean_energy_accu_center, energy, tmp318
# simulation.h:110:                 mean_energy_counter_center++;
	incq	mean_energy_counter_center(%rip)	# mean_energy_counter_center
# simulation.h:109:                 mean_energy_accu_center += energy;
	vmovsd	%xmm20, mean_energy_accu_center(%rip)	# tmp318, mean_energy_accu_center
	.p2align 4
	.p2align 3
.L193:
# simulation.h:115:         vx_e[k] -= e_x * FACTOR_E;
	vfnmadd132sd	%xmm5, %xmm19, %xmm2	# tmp339, pretmp_162, e_x
# simulation.h:77:     for(k=0; k<N_e; k++){                       // move all electrons in every time step
	addq	$8, %r14	#, ivtmp.920
	addq	$8, %rbx	#, ivtmp.921
	addq	$8, %r12	#, ivtmp.922
	addq	$8, %rbp	#, ivtmp.923
# simulation.h:115:         vx_e[k] -= e_x * FACTOR_E;
	vmovsd	%xmm2, %xmm2, %xmm0	# e_x, _58
# simulation.h:116:         x_e[k]  += vx_e[k] * DT_E;
	vfmadd132sd	%xmm4, %xmm18, %xmm0	# tmp327, _1, _60
# simulation.h:115:         vx_e[k] -= e_x * FACTOR_E;
	vmovsd	%xmm2, -8(%rbx)	# _58, MEM[(double *)_127]
# simulation.h:116:         x_e[k]  += vx_e[k] * DT_E;
	vmovsd	%xmm0, -8(%r14)	# _60, MEM[(double *)_129]
# simulation.h:77:     for(k=0; k<N_e; k++){                       // move all electrons in every time step
	cmpq	%r14, 8(%rsp)	# ivtmp.920, %sfp
	jne	.L197	#,
	jmp	.L188	#
	.p2align 4
	.p2align 3
.L207:
# simulation.h:108:                 if (energy_index < N_EEPF) {eepf[energy_index] += 1.0;}
	leaq	eepf(%rip), %rdx	#, tmp311
	cltq
	vaddsd	(%rdx,%rax,8), %xmm6, %xmm0	# eepf[energy_index_92], tmp328, tmp315
	vmovsd	%xmm0, (%rdx,%rax,8)	# tmp315, eepf[energy_index_92]
	jmp	.L196	#
.L206:
# simulation.h:118: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE3866:
	.size	_Z20step3_move_electronsi, .-_Z20step3_move_electronsi
	.section	.text._Z15step4_move_ionsii,"axG",@progbits,_Z15step4_move_ionsii,comdat
	.p2align 4
	.weak	_Z15step4_move_ionsii
	.type	_Z15step4_move_ionsii, @function
_Z15step4_move_ionsii:
.LFB3867:
	.cfi_startproc
	endbr64	
# simulation.h:133:         if (measurement_mode) {
	imull	$-858993459, %esi, %eax	#, tmp280, tmp159
	addl	$429496728, %eax	#, tmp160
	rorx	$2, %eax, %eax	#, tmp160, tmp161
# simulation.h:121:     if ((t % N_SUB) != 0) return;
	cmpl	$214748364, %eax	#, tmp161
	ja	.L219	#,
# simulation.h:126:     for(k=0; k<N_i; k++){
	movslq	N_i(%rip), %r8	# N_i,
	testl	%r8d, %r8d	# N_i.55_69
	jle	.L219	#,
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	vxorps	%xmm5, %xmm5, %xmm5	# tmp281
	jne	.L211	#,
	leaq	x_i(%rip), %rax	#, ivtmp.933
	leaq	vx_i(%rip), %rcx	#, ivtmp.934
	leaq	efield(%rip), %rsi	#, tmp268
	vmovsd	.LC67(%rip), %xmm8	#, tmp264
	leaq	(%rax,%r8,8), %r9	#, _88
	vmovsd	.LC81(%rip), %xmm6	#, tmp278
	vmovsd	.LC70(%rip), %xmm7	#, tmp267
	.p2align 4
	.p2align 3
.L212:
# simulation.h:127:         c0  = x_i[k] * INV_DX;
	vmovsd	(%rax), %xmm3	# MEM[(double *)_95], _115
# simulation.h:127:         c0  = x_i[k] * INV_DX;
	vmulsd	%xmm8, %xmm3, %xmm1	# tmp264, _115, c0
# simulation.h:128:         p   = int(c0);
	vcvttsd2sil	%xmm1, %edi	# c0, p
# simulation.h:129:         c1  = p + 1 - c0;
	leal	1(%rdi), %edx	#, _112
# simulation.h:129:         c1  = p + 1 - c0;
	vcvtsi2sdl	%edx, %xmm5, %xmm0	# _112, tmp281, tmp282
# simulation.h:131:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%edi, %r8	# p, p
# simulation.h:131:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%edx, %rdx	# _112, _112
# simulation.h:129:         c1  = p + 1 - c0;
	vsubsd	%xmm1, %xmm0, %xmm0	# c0, tmp167, c1
# simulation.h:130:         c2  = c0 - p;
	vcvtsi2sdl	%edi, %xmm5, %xmm2	# p, tmp281, tmp283
# simulation.h:130:         c2  = c0 - p;
	vsubsd	%xmm2, %xmm1, %xmm1	# tmp169, c0, c2
# simulation.h:131:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vmulsd	(%rsi,%rdx,8), %xmm1, %xmm1	# efield[_112], c2, tmp173
# simulation.h:131:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vfmadd132sd	(%rsi,%r8,8), %xmm1, %xmm0	# efield[p_113], tmp173, e_x
# simulation.h:147:         vx_i[k] += e_x * FACTOR_I;
	vfmadd213sd	(%rcx), %xmm6, %xmm0	# MEM[(double *)_93], tmp278, _11
	vmovsd	%xmm0, (%rcx)	# _11, MEM[(double *)_93]
# simulation.h:148:         x_i[k]  += vx_i[k] * DT_I;
	vfmadd132sd	%xmm7, %xmm3, %xmm0	# tmp267, _115, _122
# simulation.h:126:     for(k=0; k<N_i; k++){
	addq	$8, %rax	#, ivtmp.933
	addq	$8, %rcx	#, ivtmp.934
# simulation.h:148:         x_i[k]  += vx_i[k] * DT_I;
	vmovsd	%xmm0, -8(%rax)	# _122, MEM[(double *)_95]
# simulation.h:126:     for(k=0; k<N_i; k++){
	cmpq	%rax, %r9	# ivtmp.933, _88
	jne	.L212	#,
	ret	
	.p2align 4
	.p2align 3
.L211:
	salq	$3, %r8	#, _84
	vmovsd	.LC67(%rip), %xmm8	#, tmp264
	vmovsd	.LC81(%rip), %xmm6	#, tmp278
	vmovsd	.LC70(%rip), %xmm7	#, tmp267
	vmovsd	.LC46(%rip), %xmm12	#, tmp265
	vmovsd	.LC53(%rip), %xmm11	#, tmp274
	vmovsd	.LC51(%rip), %xmm10	#, tmp273
# simulation.h:120: inline void step4_move_ions(int t_index, int t){
	pushq	%r13	#
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movslq	%edi, %r11	# t_index, t_index
	pushq	%r12	#
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
# simulation.h:133:         if (measurement_mode) {
	xorl	%ecx, %ecx	# ivtmp.945
# simulation.h:120: inline void step4_move_ions(int t_index, int t){
	pushq	%rbp	#
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	leaq	efield(%rip), %rsi	#, tmp268
	pushq	%rbx	#
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	leaq	x_i(%rip), %rbp	#, tmp276
	leaq	vx_i(%rip), %rbx	#, tmp271
	leaq	counter_i_xt(%rip), %r10	#, tmp277
	leaq	ui_xt(%rip), %r9	#, tmp266
	leaq	vy_i(%rip), %r13	#, tmp270
	leaq	vz_i(%rip), %r12	#, tmp269
	leaq	meanei_xt(%rip), %rdi	#, tmp275
	.p2align 4
	.p2align 3
.L214:
# simulation.h:127:         c0  = x_i[k] * INV_DX;
	vmovsd	0(%rbp,%rcx), %xmm13	# MEM[(double *)&x_i + ivtmp.945_87 * 1], _2
# simulation.h:127:         c0  = x_i[k] * INV_DX;
	vmulsd	%xmm8, %xmm13, %xmm0	# tmp264, _2, c0
# simulation.h:128:         p   = int(c0);
	vcvttsd2sil	%xmm0, %eax	# c0, p
# simulation.h:129:         c1  = p + 1 - c0;
	leal	1(%rax), %edx	#, _3
# simulation.h:129:         c1  = p + 1 - c0;
	vcvtsi2sdl	%edx, %xmm5, %xmm2	# _3, tmp281, tmp284
# simulation.h:130:         c2  = c0 - p;
	vcvtsi2sdl	%eax, %xmm5, %xmm1	# p, tmp281, tmp285
# simulation.h:131:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%edx, %rdx	# _3, _3
# simulation.h:131:         e_x = c1 * efield[p] + c2 * efield[p+1];
	cltq
# simulation.h:129:         c1  = p + 1 - c0;
	vsubsd	%xmm0, %xmm2, %xmm4	# c0, tmp179, c1
# simulation.h:135:             mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I;
	vmovsd	(%rbx,%rcx), %xmm14	# MEM[(double *)&vx_i + ivtmp.945_87 * 1], pretmp_120
# simulation.h:130:         c2  = c0 - p;
	vsubsd	%xmm1, %xmm0, %xmm0	# tmp180, c0, c2
# simulation.h:131:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vmulsd	(%rsi,%rdx,8), %xmm0, %xmm9	# efield[_3], c2, tmp185
# simulation.h:137:             counter_i_xt[p+1][t_index] += c2;
	imulq	$200, %rdx, %rdx	#, _3, tmp205
# simulation.h:131:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vfmadd231sd	(%rsi,%rax,8), %xmm4, %xmm9	# efield[p_50], c1, e_x
# simulation.h:135:             mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I;
	vmulsd	%xmm12, %xmm9, %xmm1	# tmp265, e_x, tmp187
# simulation.h:135:             mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I;
	vfmadd132sd	%xmm6, %xmm14, %xmm1	# tmp278, pretmp_120, mean_v
# simulation.h:136:             counter_i_xt[p][t_index]   += c1;
	imulq	$200, %rax, %rax	#, p, tmp193
# simulation.h:140:             v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	0(%r13,%rcx), %xmm3	# MEM[(double *)&vy_i + ivtmp.945_87 * 1], _25
# simulation.h:140:             v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmulsd	%xmm3, %xmm3, %xmm3	# _25, _25, tmp235
# simulation.h:137:             counter_i_xt[p+1][t_index] += c2;
	addq	%r11, %rdx	# t_index, tmp206
# simulation.h:136:             counter_i_xt[p][t_index]   += c1;
	addq	%r11, %rax	# t_index, tmp194
	vaddsd	(%r10,%rax,8), %xmm4, %xmm2	# counter_i_xt[p_50][t_index_55(D)], c1, tmp200
	vmovsd	%xmm2, (%r10,%rax,8)	# tmp200, counter_i_xt[p_50][t_index_55(D)]
# simulation.h:137:             counter_i_xt[p+1][t_index] += c2;
	vaddsd	(%r10,%rdx,8), %xmm0, %xmm2	# counter_i_xt[_3][t_index_55(D)], c2, tmp212
	vmovsd	%xmm2, (%r10,%rdx,8)	# tmp212, counter_i_xt[_3][t_index_55(D)]
# simulation.h:138:             ui_xt[p][t_index]   += c1 * mean_v;
	vmovsd	%xmm4, %xmm4, %xmm2	# c1, _20
	vfmadd213sd	(%r9,%rax,8), %xmm1, %xmm2	# ui_xt[p_50][t_index_55(D)], mean_v, _20
	vmovsd	%xmm2, (%r9,%rax,8)	# _20, ui_xt[p_50][t_index_55(D)]
# simulation.h:139:             ui_xt[p+1][t_index] += c2 * mean_v;
	vmovsd	%xmm0, %xmm0, %xmm2	# c2, _23
	vfmadd213sd	(%r9,%rdx,8), %xmm1, %xmm2	# ui_xt[_3][t_index_55(D)], mean_v, _23
	vmovsd	%xmm2, (%r9,%rdx,8)	# _23, ui_xt[_3][t_index_55(D)]
# simulation.h:140:             v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	%xmm1, %xmm1, %xmm2	# mean_v, mean_v
	vfmadd132sd	%xmm1, %xmm3, %xmm2	# mean_v, tmp235, mean_v
# simulation.h:140:             v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r12,%rcx), %xmm1	# MEM[(double *)&vz_i + ivtmp.945_87 * 1], _28
# simulation.h:140:             v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd132sd	%xmm1, %xmm2, %xmm1	# _28, _27, v_sqr
# simulation.h:141:             energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vmulsd	%xmm11, %xmm1, %xmm1	# tmp274, v_sqr, tmp237
# simulation.h:141:             energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vdivsd	%xmm10, %xmm1, %xmm1	# tmp273, tmp237, energy
# simulation.h:142:             meanei_xt[p][t_index]   += c1 * energy;
	vfmadd213sd	(%rdi,%rax,8), %xmm1, %xmm4	# meanei_xt[p_50][t_index_55(D)], energy, _33
	vmovsd	%xmm4, (%rdi,%rax,8)	# _33, meanei_xt[p_50][t_index_55(D)]
# simulation.h:143:             meanei_xt[p+1][t_index] += c2 * energy;
	vfmadd213sd	(%rdi,%rdx,8), %xmm1, %xmm0	# meanei_xt[_3][t_index_55(D)], energy, _36
	vmovsd	%xmm0, (%rdi,%rdx,8)	# _36, meanei_xt[_3][t_index_55(D)]
# simulation.h:147:         vx_i[k] += e_x * FACTOR_I;
	vmovsd	%xmm9, %xmm9, %xmm0	# e_x, e_x
	vfmadd132sd	%xmm6, %xmm14, %xmm0	# tmp278, pretmp_120, e_x
	vmovsd	%xmm0, (%rbx,%rcx)	# _39, MEM[(double *)&vx_i + ivtmp.945_87 * 1]
# simulation.h:148:         x_i[k]  += vx_i[k] * DT_I;
	vfmadd132sd	%xmm7, %xmm13, %xmm0	# tmp267, _2, _41
	vmovsd	%xmm0, 0(%rbp,%rcx)	# _41, MEM[(double *)&x_i + ivtmp.945_87 * 1]
# simulation.h:126:     for(k=0; k<N_i; k++){
	addq	$8, %rcx	#, ivtmp.945
	cmpq	%rcx, %r8	# ivtmp.945, _84
	jne	.L214	#,
# simulation.h:150: }
	popq	%rbx	#
	.cfi_def_cfa_offset 32
	popq	%rbp	#
	.cfi_def_cfa_offset 24
	popq	%r12	#
	.cfi_def_cfa_offset 16
	popq	%r13	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4
	.p2align 3
.L219:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret	
	.cfi_endproc
.LFE3867:
	.size	_Z15step4_move_ionsii, .-_Z15step4_move_ionsii
	.section	.text._Z32step5_check_boundaries_electronsv,"axG",@progbits,_Z32step5_check_boundaries_electronsv,comdat
	.p2align 4
	.weak	_Z32step5_check_boundaries_electronsv
	.type	_Z32step5_check_boundaries_electronsv, @function
_Z32step5_check_boundaries_electronsv:
.LFB3868:
	.cfi_startproc
	endbr64	
# simulation.h:155:     while(k < N_e) {    // check boundaries for all electrons in every time step
	movl	N_e(%rip), %ecx	# N_e, N_e_lsm.953
	testl	%ecx, %ecx	# N_e_lsm.953
	jle	.L250	#,
# simulation.h:152: inline void step5_check_boundaries_electrons(){
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	N_e_abs_gnd(%rip), %r11	# N_e_abs_gnd, N_e_abs_gnd_lsm.951
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
# simulation.h:155:     while(k < N_e) {    // check boundaries for all electrons in every time step
	xorl	%edx, %edx	# N_e_lsm_flag.954
# simulation.h:152: inline void step5_check_boundaries_electrons(){
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
# simulation.h:155:     while(k < N_e) {    // check boundaries for all electrons in every time step
	xorl	%ebp, %ebp	# N_e_abs_gnd_lsm_flag.952
	movq	N_e_abs_pow(%rip), %rbx	# N_e_abs_pow, N_e_abs_pow_lsm.949
	xorl	%r12d, %r12d	# N_e_abs_pow_lsm_flag.950
# simulation.h:153:     int k = 0;
	xorl	%edi, %edi	# k
	leaq	x_e(%rip), %rsi	#, tmp115
# simulation.h:162:             vx_e[k] = vx_e[N_e-1];
	leaq	vx_e(%rip), %r10	#, tmp119
# simulation.h:157:         if (x_e[k] < 0) {N_e_abs_pow++; out = true;}    // the electron is out at the powered electrode
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp96
# simulation.h:163:             vy_e[k] = vy_e[N_e-1];
	leaq	vy_e(%rip), %r9	#, tmp120
# simulation.h:164:             vz_e[k] = vz_e[N_e-1];
	leaq	vz_e(%rip), %r8	#, tmp121
# simulation.h:158:         if (x_e[k] > L) {N_e_abs_gnd++; out = true;}    // the electron is out at the grounded electrode
	vmovsd	.LC82(%rip), %xmm2	#, tmp123
	jmp	.L230	#
	.p2align 4
	.p2align 3
.L246:
	vcomisd	%xmm2, %xmm0	# tmp123, _71
	jbe	.L247	#,
# simulation.h:158:         if (x_e[k] > L) {N_e_abs_gnd++; out = true;}    // the electron is out at the grounded electrode
	incq	%r11	# N_e_abs_gnd_lsm.951
	movl	$1, %ebp	#, N_e_abs_gnd_lsm_flag.952
.L226:
# simulation.h:161:             x_e [k] = x_e [N_e-1];
	decl	%ecx	# N_e_lsm.953
# simulation.h:161:             x_e [k] = x_e [N_e-1];
	movslq	%ecx, %rdx	# N_e_lsm.953, N_e_lsm.953
	vmovsd	(%rsi,%rdx,8), %xmm0	# x_e[_76], _77
# simulation.h:161:             x_e [k] = x_e [N_e-1];
	vmovsd	%xmm0, (%rsi,%rax,8)	# _77, x_e[k_65]
# simulation.h:162:             vx_e[k] = vx_e[N_e-1];
	vmovsd	(%r10,%rdx,8), %xmm0	# vx_e[_76], _79
# simulation.h:162:             vx_e[k] = vx_e[N_e-1];
	vmovsd	%xmm0, (%r10,%rax,8)	# _79, vx_e[k_65]
# simulation.h:163:             vy_e[k] = vy_e[N_e-1];
	vmovsd	(%r9,%rdx,8), %xmm0	# vy_e[_76], _81
# simulation.h:163:             vy_e[k] = vy_e[N_e-1];
	vmovsd	%xmm0, (%r9,%rax,8)	# _81, vy_e[k_65]
# simulation.h:164:             vz_e[k] = vz_e[N_e-1];
	vmovsd	(%r8,%rdx,8), %xmm0	# vz_e[_76], _83
# simulation.h:164:             vz_e[k] = vz_e[N_e-1];
	movl	$1, %edx	#, N_e_lsm_flag.954
	vmovsd	%xmm0, (%r8,%rax,8)	# _83, vz_e[k_65]
# simulation.h:155:     while(k < N_e) {    // check boundaries for all electrons in every time step
	cmpl	%ecx, %edi	# N_e_lsm.953, k
	jge	.L253	#,
.L230:
# simulation.h:157:         if (x_e[k] < 0) {N_e_abs_pow++; out = true;}    // the electron is out at the powered electrode
	movslq	%edi, %rax	# k, k
	vmovsd	(%rsi,%rax,8), %xmm0	# x_e[k_65], _71
# simulation.h:157:         if (x_e[k] < 0) {N_e_abs_pow++; out = true;}    // the electron is out at the powered electrode
	vcomisd	%xmm0, %xmm1	# _71, tmp96
	jbe	.L246	#,
# simulation.h:157:         if (x_e[k] < 0) {N_e_abs_pow++; out = true;}    // the electron is out at the powered electrode
	incq	%rbx	# N_e_abs_pow_lsm.949
	movl	$1, %r12d	#, N_e_abs_pow_lsm_flag.950
	jmp	.L226	#
	.p2align 4
	.p2align 3
.L247:
# simulation.h:166:         } else k++;
	incl	%edi	# k
# simulation.h:155:     while(k < N_e) {    // check boundaries for all electrons in every time step
	cmpl	%ecx, %edi	# N_e_lsm.953, k
	jl	.L230	#,
.L253:
	testb	%dl, %dl	# N_e_lsm_flag.954
	je	.L231	#,
	movl	%ecx, N_e(%rip)	# N_e_lsm.953, N_e
.L231:
	testb	%bpl, %bpl	# N_e_abs_gnd_lsm_flag.952
	je	.L232	#,
	movq	%r11, N_e_abs_gnd(%rip)	# N_e_abs_gnd_lsm.951, N_e_abs_gnd
.L232:
	testb	%r12b, %r12b	# N_e_abs_pow_lsm_flag.950
	je	.L248	#,
	movq	%rbx, N_e_abs_pow(%rip)	# N_e_abs_pow_lsm.949, N_e_abs_pow
.L248:
# simulation.h:168: }
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4
	.p2align 3
.L250:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	ret	
	.cfi_endproc
.LFE3868:
	.size	_Z32step5_check_boundaries_electronsv, .-_Z32step5_check_boundaries_electronsv
	.section	.text._Z27step6_check_boundaries_ionsi,"axG",@progbits,_Z27step6_check_boundaries_ionsi,comdat
	.p2align 4
	.weak	_Z27step6_check_boundaries_ionsi
	.type	_Z27step6_check_boundaries_ionsi, @function
_Z27step6_check_boundaries_ionsi:
.LFB3869:
	.cfi_startproc
	endbr64	
# simulation.h:171:     if ((t % N_SUB) != 0) return;
	movslq	%edi, %rdx	# t, t
	movl	%edi, %eax	# t, tmp121
	imulq	$1717986919, %rdx, %rdx	#, t, tmp118
	sarl	$31, %eax	#, tmp121
	sarq	$35, %rdx	#, tmp120
	subl	%eax, %edx	# tmp121, k
	leal	(%rdx,%rdx,4), %eax	#, tmp124
	sall	$2, %eax	#, tmp125
# simulation.h:171:     if ((t % N_SUB) != 0) return;
	subl	%eax, %edi	# tmp125, t
	jne	.L286	#,
# simulation.h:178:     while (k < N_i) {
	movl	N_i(%rip), %esi	# N_i, N_i_lsm.964
	testl	%esi, %esi	# N_i_lsm.964
	jle	.L286	#,
# simulation.h:170: inline void step6_check_boundaries_ions(int t){
	pushq	%r14	#
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movl	%edi, %edx	# t, k
	pushq	%r13	#
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	N_i_abs_gnd(%rip), %r11	# N_i_abs_gnd, N_i_abs_gnd_lsm.962
	pushq	%r12	#
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
# simulation.h:178:     while (k < N_i) {
	xorl	%ecx, %ecx	# N_i_lsm_flag.965
# simulation.h:170: inline void step6_check_boundaries_ions(int t){
	pushq	%rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
# simulation.h:178:     while (k < N_i) {
	xorl	%r12d, %r12d	# N_i_abs_gnd_lsm_flag.963
# simulation.h:170: inline void step6_check_boundaries_ions(int t){
	pushq	%rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
# simulation.h:178:     while (k < N_i) {
	xorl	%ebp, %ebp	# N_i_abs_pow_lsm_flag.961
	movq	N_i_abs_pow(%rip), %rbx	# N_i_abs_pow, N_i_abs_pow_lsm.960
	leaq	x_i(%rip), %rdi	#, tmp184
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	leaq	vx_i(%rip), %r10	#, tmp193
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	leaq	vy_i(%rip), %r9	#, tmp194
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	leaq	vz_i(%rip), %r8	#, tmp195
# simulation.h:188:         if (x_i[k] > L) {
	vmovsd	.LC82(%rip), %xmm4	#, tmp192
# simulation.h:194:             if (energy_index < N_IFED) ifed_gnd[energy_index]++;
	leaq	ifed_gnd(%rip), %r13	#, tmp198
# simulation.h:186:             if (energy_index < N_IFED) ifed_pow[energy_index]++;
	leaq	ifed_pow(%rip), %r14	#, tmp201
# simulation.h:192:             energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vmovsd	.LC53(%rip), %xmm3	#, tmp196
# simulation.h:192:             energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vmovsd	.LC51(%rip), %xmm2	#, tmp197
	jmp	.L267	#
	.p2align 4
	.p2align 3
.L282:
# simulation.h:188:         if (x_i[k] > L) {
	vcomisd	%xmm4, %xmm0	# tmp192, _96
	jbe	.L283	#,
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r10,%rax,8), %xmm0	# vx_i[k_84], _125
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r9,%rax,8), %xmm1	# vy_i[k_84], _127
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmulsd	%xmm1, %xmm1, %xmm1	# _127, _127, tmp153
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd231sd	%xmm0, %xmm0, %xmm1	# _125, _125, _129
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r8,%rax,8), %xmm0	# vz_i[k_84], _130
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# _130, _129, v_sqr
# simulation.h:192:             energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vmulsd	%xmm3, %xmm0, %xmm0	# tmp196, v_sqr, tmp156
# simulation.h:192:             energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vdivsd	%xmm2, %xmm0, %xmm0	# tmp197, tmp156, energy
# simulation.h:193:             energy_index = (int)(energy / DE_IFED);
	vcvttsd2sil	%xmm0, %ecx	# energy, energy_index
# simulation.h:194:             if (energy_index < N_IFED) ifed_gnd[energy_index]++;
	cmpl	$199, %ecx	#, energy_index
	jg	.L265	#,
# simulation.h:194:             if (energy_index < N_IFED) ifed_gnd[energy_index]++;
	movslq	%ecx, %rcx	# energy_index, energy_index
	incl	0(%r13,%rcx,4)	# ifed_gnd[energy_index_135]
.L265:
# simulation.h:189:             N_i_abs_gnd++;
	incq	%r11	# N_i_abs_gnd_lsm.962
	movl	$1, %r12d	#, N_i_abs_gnd_lsm_flag.963
.L261:
# simulation.h:197:             x_i [k] = x_i [N_i-1];
	decl	%esi	# N_i_lsm.964
# simulation.h:197:             x_i [k] = x_i [N_i-1];
	movslq	%esi, %rcx	# N_i_lsm.964, N_i_lsm.964
	vmovsd	(%rdi,%rcx,8), %xmm0	# x_i[_114], _115
# simulation.h:197:             x_i [k] = x_i [N_i-1];
	vmovsd	%xmm0, (%rdi,%rax,8)	# _115, x_i[k_84]
# simulation.h:198:             vx_i[k] = vx_i[N_i-1];
	vmovsd	(%r10,%rcx,8), %xmm0	# vx_i[_114], _117
# simulation.h:198:             vx_i[k] = vx_i[N_i-1];
	vmovsd	%xmm0, (%r10,%rax,8)	# _117, vx_i[k_84]
# simulation.h:199:             vy_i[k] = vy_i[N_i-1];
	vmovsd	(%r9,%rcx,8), %xmm0	# vy_i[_114], _119
# simulation.h:199:             vy_i[k] = vy_i[N_i-1];
	vmovsd	%xmm0, (%r9,%rax,8)	# _119, vy_i[k_84]
# simulation.h:200:             vz_i[k] = vz_i[N_i-1];
	vmovsd	(%r8,%rcx,8), %xmm0	# vz_i[_114], _121
# simulation.h:200:             vz_i[k] = vz_i[N_i-1];
	movl	$1, %ecx	#, N_i_lsm_flag.965
	vmovsd	%xmm0, (%r8,%rax,8)	# _121, vz_i[k_84]
# simulation.h:178:     while (k < N_i) {
	cmpl	%esi, %edx	# N_i_lsm.964, k
	jge	.L289	#,
.L267:
# simulation.h:180:         if (x_i[k] < 0) {
	movslq	%edx, %rax	# k, k
# simulation.h:180:         if (x_i[k] < 0) {
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp128
# simulation.h:180:         if (x_i[k] < 0) {
	vmovsd	(%rdi,%rax,8), %xmm0	# x_i[k_84], _96
# simulation.h:180:         if (x_i[k] < 0) {
	vcomisd	%xmm0, %xmm1	# _96, tmp128
	jbe	.L282	#,
# simulation.h:183:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r10,%rax,8), %xmm0	# vx_i[k_84], _141
# simulation.h:183:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r9,%rax,8), %xmm1	# vy_i[k_84], _143
# simulation.h:183:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmulsd	%xmm1, %xmm1, %xmm1	# _143, _143, tmp133
# simulation.h:183:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd231sd	%xmm0, %xmm0, %xmm1	# _141, _141, _145
# simulation.h:183:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r8,%rax,8), %xmm0	# vz_i[k_84], _146
# simulation.h:183:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# _146, _145, v_sqr
# simulation.h:184:             energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vmulsd	%xmm3, %xmm0, %xmm0	# tmp196, v_sqr, tmp136
# simulation.h:184:             energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vdivsd	%xmm2, %xmm0, %xmm0	# tmp197, tmp136, energy
# simulation.h:185:             energy_index = (int)(energy / DE_IFED);
	vcvttsd2sil	%xmm0, %ecx	# energy, energy_index
# simulation.h:186:             if (energy_index < N_IFED) ifed_pow[energy_index]++;
	cmpl	$199, %ecx	#, energy_index
	jg	.L262	#,
# simulation.h:186:             if (energy_index < N_IFED) ifed_pow[energy_index]++;
	movslq	%ecx, %rcx	# energy_index, energy_index
	incl	(%r14,%rcx,4)	# ifed_pow[energy_index_151]
.L262:
# simulation.h:181:             N_i_abs_pow++;
	incq	%rbx	# N_i_abs_pow_lsm.960
	movl	$1, %ebp	#, N_i_abs_pow_lsm_flag.961
	jmp	.L261	#
	.p2align 4
	.p2align 3
.L283:
# simulation.h:202:         } else k++;
	incl	%edx	# k
# simulation.h:178:     while (k < N_i) {
	cmpl	%esi, %edx	# N_i_lsm.964, k
	jl	.L267	#,
.L289:
	testb	%cl, %cl	# N_i_lsm_flag.965
	je	.L268	#,
	movl	%esi, N_i(%rip)	# N_i_lsm.964, N_i
.L268:
	testb	%r12b, %r12b	# N_i_abs_gnd_lsm_flag.963
	je	.L269	#,
	movq	%r11, N_i_abs_gnd(%rip)	# N_i_abs_gnd_lsm.962, N_i_abs_gnd
.L269:
	testb	%bpl, %bpl	# N_i_abs_pow_lsm_flag.961
	je	.L284	#,
	movq	%rbx, N_i_abs_pow(%rip)	# N_i_abs_pow_lsm.960, N_i_abs_pow
.L284:
# simulation.h:204: }
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
.L286:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	ret	
	.cfi_endproc
.LFE3869:
	.size	_Z27step6_check_boundaries_ionsi, .-_Z27step6_check_boundaries_ionsi
	.section	.text._Z21step9_collect_xt_datai,"axG",@progbits,_Z21step9_collect_xt_datai,comdat
	.p2align 4
	.weak	_Z21step9_collect_xt_datai
	.type	_Z21step9_collect_xt_datai, @function
_Z21step9_collect_xt_datai:
.LFB3872:
	.cfi_startproc
	endbr64	
# simulation.h:311:     if(!measurement_mode) return;
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	je	.L294	#,
	movslq	%edi, %rax	# t_index, t_index
	leaq	ni_xt(%rip), %r8	#, tmp155
	leaq	pot(%rip), %rdi	#, ivtmp.991
	leaq	pot_xt(%rip), %rsi	#, tmp152
	salq	$3, %rax	#, _37
	leaq	efield_xt(%rip), %rcx	#, tmp153
	leaq	ne_xt(%rip), %rdx	#, tmp154
	addq	%rax, %rsi	# _37, ivtmp.995
	leaq	efield(%rip), %r10	#, ivtmp.999
	addq	%rax, %rcx	# _37, ivtmp.997
	addq	%rax, %rdx	# _37, ivtmp.1001
	leaq	e_density(%rip), %r9	#, ivtmp.1003
	addq	%r8, %rax	# tmp155, ivtmp.1005
	leaq	3200(%rdi), %r11	#, _184
	leaq	i_density(%rip), %r8	#, ivtmp.1007
	.p2align 4
	.p2align 3
.L292:
# simulation.h:314:         pot_xt   [p][t_index] += pot[p];
	vmovsd	3200(%rsi), %xmm0	# MEM[(double *)_59 + 3200B], MEM[(double *)_59 + 3200B]
	vmovhpd	4800(%rsi), %xmm0, %xmm1	# MEM[(double *)_59 + 4800B], MEM[(double *)_59 + 3200B], tmp157
	vmovsd	(%rsi), %xmm0	# MEM[(double *)_59], MEM[(double *)_59]
	vmovhpd	1600(%rsi), %xmm0, %xmm0	# MEM[(double *)_59 + 1600B], MEM[(double *)_59], tmp160
	vinsertf128	$0x1, %xmm1, %ymm0, %ymm0	# tmp157, tmp160, tmp156
# simulation.h:314:         pot_xt   [p][t_index] += pot[p];
	vaddpd	(%rdi), %ymm0, %ymm0	# MEM <vector(4) double> [(double *)_20], tmp156, vect__4.975
	addq	$32, %rdi	#, ivtmp.991
	addq	$6400, %rsi	#, ivtmp.995
	addq	$6400, %rcx	#, ivtmp.997
	addq	$32, %r10	#, ivtmp.999
	addq	$6400, %rdx	#, ivtmp.1001
	addq	$32, %r9	#, ivtmp.1003
	addq	$6400, %rax	#, ivtmp.1005
	addq	$32, %r8	#, ivtmp.1007
	vmovlpd	%xmm0, -6400(%rsi)	# tmp165, MEM[(double *)_59]
	vmovhpd	%xmm0, -4800(%rsi)	# tmp165, MEM[(double *)_59 + 1600B]
	vextractf64x2	$1, %ymm0, %xmm1	#, vect__4.975, tmp168
	valignq	$3, %ymm0, %ymm0, %ymm0	#, vect__4.975, tmp170
	vmovsd	%xmm1, -3200(%rsi)	# tmp168, MEM[(double *)_59 + 3200B]
	vmovsd	%xmm0, -1600(%rsi)	# tmp170, MEM[(double *)_59 + 4800B]
# simulation.h:315:         efield_xt[p][t_index] += efield[p];
	vmovsd	-3200(%rcx), %xmm0	# MEM[(double *)_19 + 3200B], MEM[(double *)_19 + 3200B]
	vmovhpd	-1600(%rcx), %xmm0, %xmm1	# MEM[(double *)_19 + 4800B], MEM[(double *)_19 + 3200B], tmp173
	vmovsd	-6400(%rcx), %xmm0	# MEM[(double *)_19], MEM[(double *)_19]
	vmovhpd	-4800(%rcx), %xmm0, %xmm0	# MEM[(double *)_19 + 1600B], MEM[(double *)_19], tmp176
	vinsertf128	$0x1, %xmm1, %ymm0, %ymm0	# tmp173, tmp176, tmp172
# simulation.h:315:         efield_xt[p][t_index] += efield[p];
	vaddpd	-32(%r10), %ymm0, %ymm0	# MEM <vector(4) double> [(double *)_164], tmp172, vect__7.979
	vmovlpd	%xmm0, -6400(%rcx)	# tmp181, MEM[(double *)_19]
	vmovhpd	%xmm0, -4800(%rcx)	# tmp181, MEM[(double *)_19 + 1600B]
	vextractf64x2	$1, %ymm0, %xmm1	#, vect__7.979, tmp184
	valignq	$3, %ymm0, %ymm0, %ymm0	#, vect__7.979, tmp186
	vmovsd	%xmm1, -3200(%rcx)	# tmp184, MEM[(double *)_19 + 3200B]
	vmovsd	%xmm0, -1600(%rcx)	# tmp186, MEM[(double *)_19 + 4800B]
# simulation.h:316:         ne_xt    [p][t_index] += e_density[p];
	vmovsd	-3200(%rdx), %xmm0	# MEM[(double *)_165 + 3200B], MEM[(double *)_165 + 3200B]
	vmovhpd	-1600(%rdx), %xmm0, %xmm1	# MEM[(double *)_165 + 4800B], MEM[(double *)_165 + 3200B], tmp189
	vmovsd	-6400(%rdx), %xmm0	# MEM[(double *)_165], MEM[(double *)_165]
	vmovhpd	-4800(%rdx), %xmm0, %xmm0	# MEM[(double *)_165 + 1600B], MEM[(double *)_165], tmp192
	vinsertf128	$0x1, %xmm1, %ymm0, %ymm0	# tmp189, tmp192, tmp188
# simulation.h:316:         ne_xt    [p][t_index] += e_density[p];
	vaddpd	-32(%r9), %ymm0, %ymm0	# MEM <vector(4) double> [(double *)_173], tmp188, vect__10.983
	vmovlpd	%xmm0, -6400(%rdx)	# tmp197, MEM[(double *)_165]
	vmovhpd	%xmm0, -4800(%rdx)	# tmp197, MEM[(double *)_165 + 1600B]
	vextractf64x2	$1, %ymm0, %xmm1	#, vect__10.983, tmp200
	valignq	$3, %ymm0, %ymm0, %ymm0	#, vect__10.983, tmp202
	vmovsd	%xmm1, -3200(%rdx)	# tmp200, MEM[(double *)_165 + 3200B]
	vmovsd	%xmm0, -1600(%rdx)	# tmp202, MEM[(double *)_165 + 4800B]
# simulation.h:317:         ni_xt    [p][t_index] += i_density[p];
	vmovsd	-3200(%rax), %xmm0	# MEM[(double *)_174 + 3200B], MEM[(double *)_174 + 3200B]
	vmovhpd	-1600(%rax), %xmm0, %xmm1	# MEM[(double *)_174 + 4800B], MEM[(double *)_174 + 3200B], tmp205
	vmovsd	-6400(%rax), %xmm0	# MEM[(double *)_174], MEM[(double *)_174]
	vmovhpd	-4800(%rax), %xmm0, %xmm0	# MEM[(double *)_174 + 1600B], MEM[(double *)_174], tmp208
	vinsertf128	$0x1, %xmm1, %ymm0, %ymm0	# tmp205, tmp208, tmp204
# simulation.h:317:         ni_xt    [p][t_index] += i_density[p];
	vaddpd	-32(%r8), %ymm0, %ymm0	# MEM <vector(4) double> [(double *)_182], tmp204, vect__13.987
	vmovlpd	%xmm0, -6400(%rax)	# tmp213, MEM[(double *)_174]
	vextractf64x2	$1, %ymm0, %xmm1	#, vect__13.987, tmp216
	vmovhpd	%xmm0, -4800(%rax)	# tmp213, MEM[(double *)_174 + 1600B]
	valignq	$3, %ymm0, %ymm0, %ymm0	#, vect__13.987, tmp218
	vmovsd	%xmm1, -3200(%rax)	# tmp216, MEM[(double *)_174 + 3200B]
	vmovsd	%xmm0, -1600(%rax)	# tmp218, MEM[(double *)_174 + 4800B]
	cmpq	%r11, %rdi	# _184, ivtmp.991
	jne	.L292	#,
	vzeroupper
.L294:
# simulation.h:319: }
	ret	
	.cfi_endproc
.LFE3872:
	.size	_Z21step9_collect_xt_datai, .-_Z21step9_collect_xt_datai
	.section	.rodata._Z18save_particle_datav.str1.1,"aMS",@progbits,1
.LC83:
	.string	"wb"
	.section	.rodata._Z18save_particle_datav.str1.8,"aMS",@progbits,1
	.align 8
.LC84:
	.string	">> eduPIC: data saved : %d electrons %d ions, %d cycles completed, time is %e [s]\n"
	.section	.text._Z18save_particle_datav,"axG",@progbits,_Z18save_particle_datav,comdat
	.p2align 4
	.weak	_Z18save_particle_datav
	.type	_Z18save_particle_datav, @function
_Z18save_particle_datav:
.LFB3903:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
# io_manager.h:14:     f = fopen(fname,"wb");
	leaq	.LC83(%rip), %rsi	#, tmp113
# io_manager.h:8: inline void save_particle_data(){
	subq	$120, %rsp	#,
	.cfi_def_cfa_offset 144
# io_manager.h:8: inline void save_particle_data(){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp157
	movq	%rax, 104(%rsp)	# tmp157, D.82812
	xorl	%eax, %eax	# tmp157
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movl	$7235938, 24(%rsp)	#, MEM <char[1:12]> [(void *)&fname]
	leaq	16(%rsp), %rdi	#, tmp110
	movabsq	$3342080360130505072, %rax	#, tmp160
# io_manager.h:17:     fwrite(&d,sizeof(double),1,f);
	leaq	8(%rsp), %rbp	#, tmp117
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, 16(%rsp)	# tmp160, MEM <char[1:12]> [(void *)&fname]
# io_manager.h:14:     f = fopen(fname,"wb");
	call	fopen@PLT	#
# io_manager.h:15:     fwrite(&Time,sizeof(double),1,f);
	movl	$1, %edx	#,
	movl	$8, %esi	#,
# io_manager.h:14:     f = fopen(fname,"wb");
	movq	%rax, %rbx	# tmp152, tmp114
# io_manager.h:15:     fwrite(&Time,sizeof(double),1,f);
	movq	%rax, %rcx	# tmp114,
	leaq	Time(%rip), %rdi	#, tmp115
	call	fwrite@PLT	#
# io_manager.h:17:     fwrite(&d,sizeof(double),1,f);
	movq	%rbx, %rcx	# tmp114,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	movq	%rbp, %rdi	# tmp117,
# io_manager.h:16:     d = (double)(cycles_done);
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp161
	vcvtsi2sdl	cycles_done(%rip), %xmm1, %xmm0	# cycles_done, tmp161, tmp154
	vmovsd	%xmm0, 8(%rsp)	# tmp116, d
# io_manager.h:17:     fwrite(&d,sizeof(double),1,f);
	call	fwrite@PLT	#
# io_manager.h:19:     fwrite(&d,sizeof(double),1,f);
	movq	%rbx, %rcx	# tmp114,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	movq	%rbp, %rdi	# tmp117,
# io_manager.h:18:     d = (double)(N_e);
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp162
	vcvtsi2sdl	N_e(%rip), %xmm1, %xmm0	# N_e, tmp162, tmp155
	vmovsd	%xmm0, 8(%rsp)	# tmp118, d
# io_manager.h:19:     fwrite(&d,sizeof(double),1,f);
	call	fwrite@PLT	#
# io_manager.h:20:     fwrite(x_e, sizeof(double),N_e,f);
	movslq	N_e(%rip), %rdx	# N_e, N_e
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	x_e(%rip), %rdi	#, tmp122
	call	fwrite@PLT	#
# io_manager.h:21:     fwrite(vx_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rdx	# N_e, N_e
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vx_e(%rip), %rdi	#, tmp125
	call	fwrite@PLT	#
# io_manager.h:22:     fwrite(vy_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rdx	# N_e, N_e
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vy_e(%rip), %rdi	#, tmp128
	call	fwrite@PLT	#
# io_manager.h:23:     fwrite(vz_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rdx	# N_e, N_e
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vz_e(%rip), %rdi	#, tmp131
	call	fwrite@PLT	#
# io_manager.h:25:     fwrite(&d,sizeof(double),1,f);
	movq	%rbx, %rcx	# tmp114,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	movq	%rbp, %rdi	# tmp117,
# io_manager.h:24:     d = (double)(N_i);
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp163
	vcvtsi2sdl	N_i(%rip), %xmm1, %xmm0	# N_i, tmp163, tmp156
	vmovsd	%xmm0, 8(%rsp)	# tmp132, d
# io_manager.h:25:     fwrite(&d,sizeof(double),1,f);
	call	fwrite@PLT	#
# io_manager.h:26:     fwrite(x_i, sizeof(double),N_i,f);
	movslq	N_i(%rip), %rdx	# N_i, N_i
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	x_i(%rip), %rdi	#, tmp136
	call	fwrite@PLT	#
# io_manager.h:27:     fwrite(vx_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rdx	# N_i, N_i
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vx_i(%rip), %rdi	#, tmp139
	call	fwrite@PLT	#
# io_manager.h:28:     fwrite(vy_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rdx	# N_i, N_i
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vy_i(%rip), %rdi	#, tmp142
	call	fwrite@PLT	#
# io_manager.h:29:     fwrite(vz_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rdx	# N_i, N_i
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vz_i(%rip), %rdi	#, tmp145
	call	fwrite@PLT	#
# io_manager.h:30:     fclose(f);
	movq	%rbx, %rdi	# tmp114,
	call	fclose@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	cycles_done(%rip), %r8d	# cycles_done,
	movl	N_i(%rip), %ecx	# N_i,
	leaq	.LC84(%rip), %rsi	#, tmp150
	movl	N_e(%rip), %edx	# N_e,
	movl	$2, %edi	#,
	movl	$1, %eax	#,
	vmovsd	Time(%rip), %xmm0	# Time,
	call	__printf_chk@PLT	#
# io_manager.h:32: }
	movq	104(%rsp), %rax	# D.82812, tmp158
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp158
	jne	.L299	#,
	addq	$120, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
.L299:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE3903:
	.size	_Z18save_particle_datav, .-_Z18save_particle_datav
	.section	.rodata._Z18load_particle_datav.str1.1,"aMS",@progbits,1
.LC85:
	.string	"rb"
	.section	.rodata._Z18load_particle_datav.str1.8,"aMS",@progbits,1
	.align 8
.LC86:
	.string	">> eduPIC: ERROR: No particle data file found, try running initial cycle using argument '0'\n"
	.align 8
.LC87:
	.string	">> eduPIC: data loaded : %d electrons %d ions, %d cycles completed before, time is %e [s]\n"
	.section	.text._Z18load_particle_datav,"axG",@progbits,_Z18load_particle_datav,comdat
	.p2align 4
	.weak	_Z18load_particle_datav
	.type	_Z18load_particle_datav, @function
_Z18load_particle_datav:
.LFB3904:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
# io_manager.h:40:     f = fopen(fname,"rb");
	leaq	.LC85(%rip), %rsi	#, tmp111
# io_manager.h:34: inline void load_particle_data(){
	subq	$120, %rsp	#,
	.cfi_def_cfa_offset 144
# io_manager.h:34: inline void load_particle_data(){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp151
	movq	%rax, 104(%rsp)	# tmp151, D.82820
	xorl	%eax, %eax	# tmp151
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movl	$7235938, 24(%rsp)	#, MEM <char[1:12]> [(void *)&fname]
	movabsq	$3342080360130505072, %rax	#, tmp154
	leaq	16(%rsp), %rdi	#, tmp108
	movq	%rax, 16(%rsp)	# tmp154, MEM <char[1:12]> [(void *)&fname]
# io_manager.h:40:     f = fopen(fname,"rb");
	call	fopen@PLT	#
# io_manager.h:41:     if (f==NULL) {printf(">> eduPIC: ERROR: No particle data file found, try running initial cycle using argument '0'\n"); exit(0); }
	testq	%rax, %rax	# tmp112
	je	.L305	#,
	movq	%rax, %rbx	# tmp150, tmp112
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:212:     return __fread_alias (__ptr, __size, __n, __stream);
	leaq	8(%rsp), %rbp	#, tmp115
	movq	%rax, %rcx	# tmp112,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	leaq	Time(%rip), %rdi	#, tmp114
	call	fread@PLT	#
	movq	%rbx, %rcx	# tmp112,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	movq	%rbp, %rdi	# tmp115,
	call	fread@PLT	#
	movq	%rbx, %rcx	# tmp112,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	movq	%rbp, %rdi	# tmp115,
# io_manager.h:44:     cycles_done = int(d);
	vcvttsd2sil	8(%rsp), %eax	# d, tmp117
	movl	%eax, cycles_done(%rip)	# tmp117, cycles_done
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:212:     return __fread_alias (__ptr, __size, __n, __stream);
	call	fread@PLT	#
# io_manager.h:46:     N_e = int(d);
	vcvttsd2sil	8(%rsp), %ecx	# d, _4
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	x_e(%rip), %rdi	#, tmp121
# io_manager.h:46:     N_e = int(d);
	movl	%ecx, N_e(%rip)	# _4, N_e
# io_manager.h:47:     fread(x_e, sizeof(double),N_e,f);
	movslq	%ecx, %rcx	# _4, _4
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	call	__fread_chk@PLT	#
# io_manager.h:48:     fread(vx_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rcx	# N_e, N_e
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vx_e(%rip), %rdi	#, tmp124
	call	__fread_chk@PLT	#
# io_manager.h:49:     fread(vy_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rcx	# N_e, N_e
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vy_e(%rip), %rdi	#, tmp127
	call	__fread_chk@PLT	#
# io_manager.h:50:     fread(vz_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rcx	# N_e, N_e
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vz_e(%rip), %rdi	#, tmp130
	call	__fread_chk@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:212:     return __fread_alias (__ptr, __size, __n, __stream);
	movq	%rbx, %rcx	# tmp112,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	movq	%rbp, %rdi	# tmp115,
	call	fread@PLT	#
# io_manager.h:52:     N_i = int(d);
	vcvttsd2sil	8(%rsp), %ecx	# d, _13
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	x_i(%rip), %rdi	#, tmp134
# io_manager.h:52:     N_i = int(d);
	movl	%ecx, N_i(%rip)	# _13, N_i
# io_manager.h:53:     fread(x_i, sizeof(double),N_i,f);
	movslq	%ecx, %rcx	# _13, _13
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	call	__fread_chk@PLT	#
# io_manager.h:54:     fread(vx_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rcx	# N_i, N_i
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vx_i(%rip), %rdi	#, tmp137
	call	__fread_chk@PLT	#
# io_manager.h:55:     fread(vy_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rcx	# N_i, N_i
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vy_i(%rip), %rdi	#, tmp140
	call	__fread_chk@PLT	#
# io_manager.h:56:     fread(vz_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rcx	# N_i, N_i
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vz_i(%rip), %rdi	#, tmp143
	call	__fread_chk@PLT	#
# io_manager.h:57:     fclose(f);
	movq	%rbx, %rdi	# tmp112,
	call	fclose@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	cycles_done(%rip), %r8d	# cycles_done,
	movl	N_i(%rip), %ecx	# N_i,
	leaq	.LC87(%rip), %rsi	#, tmp148
	movl	N_e(%rip), %edx	# N_e,
	movl	$2, %edi	#,
	movl	$1, %eax	#,
	vmovsd	Time(%rip), %xmm0	# Time,
	call	__printf_chk@PLT	#
# io_manager.h:59: }
	movq	104(%rsp), %rax	# D.82820, tmp152
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp152
	jne	.L306	#,
	addq	$120, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
.L305:
	.cfi_restore_state
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$2, %edi	#,
	leaq	.LC86(%rip), %rsi	#, tmp113
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# io_manager.h:41:     if (f==NULL) {printf(">> eduPIC: ERROR: No particle data file found, try running initial cycle using argument '0'\n"); exit(0); }
	xorl	%edi, %edi	#
	call	exit@PLT	#
.L306:
# io_manager.h:59: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE3904:
	.size	_Z18load_particle_datav, .-_Z18load_particle_datav
	.section	.rodata._Z12save_densityv.str1.1,"aMS",@progbits,1
.LC88:
	.string	"w"
.LC89:
	.string	"density.dat"
.LC91:
	.string	"%8.5f  %12e  %12e\n"
	.section	.text._Z12save_densityv,"axG",@progbits,_Z12save_densityv,comdat
	.p2align 4
	.weak	_Z12save_densityv
	.type	_Z12save_densityv, @function
_Z12save_densityv:
.LFB3905:
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
# io_manager.h:66:     f = fopen("density.dat","w");
	leaq	.LC88(%rip), %rsi	#, tmp95
# io_manager.h:61: inline void save_density(void){
	pushq	%rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
# io_manager.h:66:     f = fopen("density.dat","w");
	leaq	.LC89(%rip), %rdi	#, tmp96
# io_manager.h:67:     c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
	xorl	%ebx, %ebx	# ivtmp.1021
# io_manager.h:61: inline void save_density(void){
	subq	$16, %rsp	#,
	.cfi_def_cfa_offset 64
	leaq	cumul_i_density(%rip), %r14	#, tmp111
	leaq	cumul_e_density(%rip), %r13	#, tmp110
	leaq	.LC91(%rip), %r12	#, tmp113
# io_manager.h:66:     f = fopen("density.dat","w");
	call	fopen@PLT	#
# io_manager.h:67:     c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp119
# io_manager.h:67:     c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
	vmovsd	.LC12(%rip), %xmm0	#, tmp100
# io_manager.h:67:     c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
	vcvtsi2sdl	no_of_cycles(%rip), %xmm5, %xmm1	# no_of_cycles, tmp119, tmp116
# io_manager.h:66:     f = fopen("density.dat","w");
	movq	%rax, %rbp	# tmp114, _14
# io_manager.h:67:     c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp98, tmp100, tmp99
# io_manager.h:67:     c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
	vdivsd	.LC90(%rip), %xmm0, %xmm6	#, tmp99, c
	vmovsd	%xmm6, 8(%rsp)	# c, %sfp
	.p2align 4
	.p2align 3
.L308:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	8(%rsp), %xmm3	# %sfp, c
# io_manager.h:69:         fprintf(f,"%8.5f  %12e  %12e\n",m * DX, cumul_e_density[m] * c, cumul_i_density[m] * c);
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp121
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmulsd	(%r14,%rbx,8), %xmm3, %xmm2	# MEM[(double *)&cumul_i_density + ivtmp.1021_19 * 8], c,
# io_manager.h:69:         fprintf(f,"%8.5f  %12e  %12e\n",m * DX, cumul_e_density[m] * c, cumul_i_density[m] * c);
	vcvtsi2sdl	%ebx, %xmm4, %xmm0	# ivtmp.1021, tmp121, tmp117
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmulsd	0(%r13,%rbx,8), %xmm3, %xmm1	# MEM[(double *)&cumul_e_density + ivtmp.1021_19 * 8], c,
	movq	%r12, %rdx	# tmp113,
	movl	$2, %esi	#,
	movq	%rbp, %rdi	# _14,
	movl	$3, %eax	#,
# io_manager.h:68:     for(m=0; m<N_G; m++){
	incq	%rbx	# ivtmp.1021
# io_manager.h:69:         fprintf(f,"%8.5f  %12e  %12e\n",m * DX, cumul_e_density[m] * c, cumul_i_density[m] * c);
	vmulsd	.LC65(%rip), %xmm0, %xmm0	#, tmp106, tmp107
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# io_manager.h:68:     for(m=0; m<N_G; m++){
	cmpq	$400, %rbx	#, ivtmp.1021
	jne	.L308	#,
# io_manager.h:72: }
	addq	$16, %rsp	#,
	.cfi_def_cfa_offset 48
# io_manager.h:71:     fclose(f);
	movq	%rbp, %rdi	# _14,
# io_manager.h:72: }
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
# io_manager.h:71:     fclose(f);
	jmp	fclose@PLT	#
	.cfi_endproc
.LFE3905:
	.size	_Z12save_densityv, .-_Z12save_densityv
	.section	.rodata._Z9save_eepfv.str1.1,"aMS",@progbits,1
.LC92:
	.string	"eepf.dat"
.LC93:
	.string	"%e  %e\n"
	.section	.text._Z9save_eepfv,"axG",@progbits,_Z9save_eepfv,comdat
	.p2align 4
	.weak	_Z9save_eepfv
	.type	_Z9save_eepfv, @function
_Z9save_eepfv:
.LFB3906:
	.cfi_startproc
	endbr64	
	pushq	%r13	#
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12	#
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp	#
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	leaq	eepf(%rip), %rbp	#, tmp133
	pushq	%rbx	#
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rbp, %rax	# tmp133, ivtmp.1052
	leaq	16000(%rbp), %rdx	#, _56
# io_manager.h:79:     h = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# h
# io_manager.h:74: inline void save_eepf(void) {
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 80
	.p2align 4
	.p2align 3
.L312:
	vaddsd	(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_1], 64, 0>, h, stmp_h_21.1039
	addq	$64, %rax	#, ivtmp.1052
	vaddsd	-56(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_1], 64, 64>, stmp_h_21.1039, stmp_h_21.1039
	vaddsd	-48(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_1], 64, 128>, stmp_h_21.1039, stmp_h_21.1039
	vaddsd	-40(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_1], 64, 192>, stmp_h_21.1039, stmp_h_21.1039
	vaddsd	-32(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_1], 64, 256>, stmp_h_21.1039, stmp_h_21.1039
	vaddsd	-24(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_1], 64, 320>, stmp_h_21.1039, stmp_h_21.1039
# io_manager.h:80:     for (i=0; i<N_EEPF; i++) {h += eepf[i];}
	vaddsd	-16(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_1], 64, 384>, stmp_h_21.1039, stmp_h_21.1039
	vaddsd	-8(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_1], 64, 448>, stmp_h_21.1039, h
	cmpq	%rdx, %rax	# _56, ivtmp.1052
	jne	.L312	#,
# io_manager.h:82:     f = fopen("eepf.dat","w");
	leaq	.LC88(%rip), %rsi	#, tmp118
	leaq	.LC92(%rip), %rdi	#, tmp119
# io_manager.h:81:     h *= DE_EEPF;
	vmulsd	.LC20(%rip), %xmm0, %xmm6	#, h, h
	vmovsd	%xmm6, 8(%rsp)	# h, %sfp
# io_manager.h:82:     f = fopen("eepf.dat","w");
	call	fopen@PLT	#
	xorl	%ebx, %ebx	# ivtmp.1042
	leaq	.LC93(%rip), %r13	#, tmp135
	movq	%rax, %r12	# tmp136, _16
	.p2align 4
	.p2align 3
.L317:
# io_manager.h:84:         energy = (i + 0.5) * DE_EEPF;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp142
# io_manager.h:85:         fprintf(f,"%e  %e\n", energy, eepf[i] / h / sqrt(energy));
	vmovsd	0(%rbp,%rbx,8), %xmm1	# MEM[(double *)&eepf + ivtmp.1042_36 * 8], MEM[(double *)&eepf + ivtmp.1042_36 * 8]
# io_manager.h:84:         energy = (i + 0.5) * DE_EEPF;
	vcvtsi2sdl	%ebx, %xmm3, %xmm2	# ivtmp.1042, tmp142, tmp139
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp144
	vaddsd	.LC46(%rip), %xmm2, %xmm2	#, tmp121, tmp122
# io_manager.h:85:         fprintf(f,"%e  %e\n", energy, eepf[i] / h / sqrt(energy));
	vdivsd	8(%rsp), %xmm1, %xmm1	# %sfp, MEM[(double *)&eepf + ivtmp.1042_36 * 8], _5
# io_manager.h:84:         energy = (i + 0.5) * DE_EEPF;
	vmulsd	.LC20(%rip), %xmm2, %xmm2	#, tmp122, energy
	vucomisd	%xmm2, %xmm5	# energy, tmp144
	ja	.L323	#,
# io_manager.h:85:         fprintf(f,"%e  %e\n", energy, eepf[i] / h / sqrt(energy));
	vsqrtsd	%xmm2, %xmm2, %xmm0	# energy, _6
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vdivsd	%xmm0, %xmm1, %xmm1	# _6, _5,
.L325:
	movq	%r13, %rdx	# tmp135,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _16,
	movl	$2, %eax	#,
# io_manager.h:83:     for (i=0; i<N_EEPF; i++) {
	incq	%rbx	# ivtmp.1042
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm2, %xmm2, %xmm0	# energy,
	call	__fprintf_chk@PLT	#
# io_manager.h:83:     for (i=0; i<N_EEPF; i++) {
	cmpq	$2000, %rbx	#, ivtmp.1042
	jne	.L317	#,
# io_manager.h:88: }
	addq	$40, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 40
# io_manager.h:87:     fclose(f);
	movq	%r12, %rdi	# _16,
# io_manager.h:88: }
	popq	%rbx	#
	.cfi_def_cfa_offset 32
	popq	%rbp	#
	.cfi_def_cfa_offset 24
	popq	%r12	#
	.cfi_def_cfa_offset 16
	popq	%r13	#
	.cfi_def_cfa_offset 8
# io_manager.h:87:     fclose(f);
	jmp	fclose@PLT	#
.L323:
	.cfi_restore_state
	vmovsd	%xmm1, 24(%rsp)	# _5, %sfp
# io_manager.h:85:         fprintf(f,"%e  %e\n", energy, eepf[i] / h / sqrt(energy));
	vmovsd	%xmm2, %xmm2, %xmm0	# energy,
	vmovsd	%xmm2, 16(%rsp)	# energy, %sfp
	call	sqrt@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	24(%rsp), %xmm1	# %sfp, _5
	vmovsd	16(%rsp), %xmm2	# %sfp, energy
	vdivsd	%xmm0, %xmm1, %xmm1	# tmp137, _5,
	jmp	.L325	#
	.cfi_endproc
.LFE3906:
	.size	_Z9save_eepfv, .-_Z9save_eepfv
	.section	.rodata._Z9save_ifedv.str1.1,"aMS",@progbits,1
.LC94:
	.string	"ifed.dat"
.LC95:
	.string	"%6.2f %10.6f %10.6f\n"
	.section	.text._Z9save_ifedv,"axG",@progbits,_Z9save_ifedv,comdat
	.p2align 4
	.weak	_Z9save_ifedv
	.type	_Z9save_ifedv, @function
_Z9save_ifedv:
.LFB3907:
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
	xorl	%eax, %eax	# ivtmp.1076
	pushq	%rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	leaq	ifed_pow(%rip), %r14	#, tmp144
	leaq	ifed_gnd(%rip), %r13	#, tmp143
	subq	$32, %rsp	#,
	.cfi_def_cfa_offset 80
# io_manager.h:96:     h_gnd = 0.0;
	vxorpd	%xmm6, %xmm6, %xmm6	# h_gnd
	vxorps	%xmm4, %xmm4, %xmm4	# tmp147
# io_manager.h:95:     h_pow = 0.0;
	vmovsd	%xmm6, %xmm6, %xmm5	#, h_pow
	.p2align 4
	.p2align 3
.L327:
# io_manager.h:97:     for (i=0; i<N_IFED; i++) {h_pow += ifed_pow[i]; h_gnd += ifed_gnd[i];}
	vcvtsi2sdl	(%r14,%rax), %xmm4, %xmm0	# MEM[(int *)&ifed_pow + ivtmp.1076_57 * 1], tmp147, tmp148
	vaddsd	%xmm0, %xmm5, %xmm5	# tmp113, h_pow, h_pow
# io_manager.h:97:     for (i=0; i<N_IFED; i++) {h_pow += ifed_pow[i]; h_gnd += ifed_gnd[i];}
	vcvtsi2sdl	0(%r13,%rax), %xmm4, %xmm0	# MEM[(int *)&ifed_gnd + ivtmp.1076_57 * 1], tmp147, tmp149
# io_manager.h:97:     for (i=0; i<N_IFED; i++) {h_pow += ifed_pow[i]; h_gnd += ifed_gnd[i];}
	addq	$4, %rax	#, ivtmp.1076
# io_manager.h:97:     for (i=0; i<N_IFED; i++) {h_pow += ifed_pow[i]; h_gnd += ifed_gnd[i];}
	vaddsd	%xmm0, %xmm6, %xmm6	# tmp115, h_gnd, h_gnd
# io_manager.h:97:     for (i=0; i<N_IFED; i++) {h_pow += ifed_pow[i]; h_gnd += ifed_gnd[i];}
	cmpq	$800, %rax	#, ivtmp.1076
	jne	.L327	#,
# io_manager.h:102:     f = fopen("ifed.dat","w");
	leaq	.LC88(%rip), %rsi	#, tmp118
	leaq	.LC94(%rip), %rdi	#, tmp119
	vmovsd	%xmm6, 16(%rsp)	# h_gnd, %sfp
	vmovsd	%xmm5, 8(%rsp)	# h_pow, %sfp
# io_manager.h:100:     mean_i_energy_pow = 0.0;
	movq	$0x000000000, mean_i_energy_pow(%rip)	#, mean_i_energy_pow
# io_manager.h:101:     mean_i_energy_gnd = 0.0;
	movq	$0x000000000, mean_i_energy_gnd(%rip)	#, mean_i_energy_gnd
# io_manager.h:102:     f = fopen("ifed.dat","w");
	call	fopen@PLT	#
	xorl	%r12d, %r12d	# ivtmp.1060
	movq	%rax, %rbx	# tmp146, _35
	leaq	.LC95(%rip), %rbp	#, tmp142
	vxorps	%xmm4, %xmm4, %xmm4	# tmp147
	vmovsd	16(%rsp), %xmm6	# %sfp, h_gnd
	vmovsd	8(%rsp), %xmm5	# %sfp, h_pow
	.p2align 4
	.p2align 3
.L328:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%rbp, %rdx	# tmp142,
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _35,
	movl	$3, %eax	#,
# io_manager.h:104:         energy = (i + 0.5) * DE_IFED;
	vcvtsi2sdl	%r12d, %xmm4, %xmm3	# ivtmp.1060, tmp147, tmp150
# io_manager.h:105:         fprintf(f,"%6.2f %10.6f %10.6f\n", energy, (double)(ifed_pow[i])/h_pow, (double)(ifed_gnd[i])/h_gnd);
	vcvtsi2sdl	0(%r13,%r12,4), %xmm4, %xmm2	# MEM[(int *)&ifed_gnd + ivtmp.1060_60 * 4], tmp147, tmp151
# io_manager.h:104:         energy = (i + 0.5) * DE_IFED;
	vaddsd	.LC46(%rip), %xmm3, %xmm3	#, tmp121, energy
# io_manager.h:105:         fprintf(f,"%6.2f %10.6f %10.6f\n", energy, (double)(ifed_pow[i])/h_pow, (double)(ifed_gnd[i])/h_gnd);
	vcvtsi2sdl	(%r14,%r12,4), %xmm4, %xmm1	# MEM[(int *)&ifed_pow + ivtmp.1060_60 * 4], tmp147, tmp152
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm3, %xmm3, %xmm0	# energy,
	vdivsd	%xmm6, %xmm2, %xmm2	# h_gnd, tmp124,
	vmovsd	%xmm6, 24(%rsp)	# h_gnd, %sfp
	vdivsd	%xmm5, %xmm1, %xmm1	# h_pow, tmp127,
	vmovsd	%xmm5, 16(%rsp)	# h_pow, %sfp
	vmovsd	%xmm3, 8(%rsp)	# energy, %sfp
	call	__fprintf_chk@PLT	#
# io_manager.h:106:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vxorps	%xmm4, %xmm4, %xmm4	# tmp147
# io_manager.h:106:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vmovsd	8(%rsp), %xmm3	# %sfp, energy
# io_manager.h:106:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vcvtsi2sdl	(%r14,%r12,4), %xmm4, %xmm0	# MEM[(int *)&ifed_pow + ivtmp.1060_60 * 4], tmp147, tmp153
# io_manager.h:106:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vmovsd	16(%rsp), %xmm5	# %sfp, h_pow
# io_manager.h:106:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vmulsd	%xmm3, %xmm0, %xmm0	# energy, tmp131, tmp132
# io_manager.h:106:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vdivsd	%xmm5, %xmm0, %xmm0	# h_pow, tmp132, tmp133
# io_manager.h:106:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vaddsd	mean_i_energy_pow(%rip), %xmm0, %xmm0	# mean_i_energy_pow, tmp133, tmp134
	vmovsd	%xmm0, mean_i_energy_pow(%rip)	# tmp134, mean_i_energy_pow
# io_manager.h:107:         mean_i_energy_gnd += energy * (double)(ifed_gnd[i]) / h_gnd;
	vcvtsi2sdl	0(%r13,%r12,4), %xmm4, %xmm0	# MEM[(int *)&ifed_gnd + ivtmp.1060_60 * 4], tmp147, tmp154
# io_manager.h:103:     for (i=0; i<N_IFED; i++) {
	incq	%r12	# ivtmp.1060
# io_manager.h:107:         mean_i_energy_gnd += energy * (double)(ifed_gnd[i]) / h_gnd;
	vmulsd	%xmm3, %xmm0, %xmm0	# energy, tmp137, tmp138
# io_manager.h:107:         mean_i_energy_gnd += energy * (double)(ifed_gnd[i]) / h_gnd;
	vmovsd	24(%rsp), %xmm6	# %sfp, h_gnd
	vdivsd	%xmm6, %xmm0, %xmm0	# h_gnd, tmp138, tmp139
# io_manager.h:107:         mean_i_energy_gnd += energy * (double)(ifed_gnd[i]) / h_gnd;
	vaddsd	mean_i_energy_gnd(%rip), %xmm0, %xmm0	# mean_i_energy_gnd, tmp139, tmp140
	vmovsd	%xmm0, mean_i_energy_gnd(%rip)	# tmp140, mean_i_energy_gnd
# io_manager.h:103:     for (i=0; i<N_IFED; i++) {
	cmpq	$200, %r12	#, ivtmp.1060
	jne	.L328	#,
# io_manager.h:110: }
	addq	$32, %rsp	#,
	.cfi_def_cfa_offset 48
# io_manager.h:109:     fclose(f);
	movq	%rbx, %rdi	# _35,
# io_manager.h:110: }
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
# io_manager.h:109:     fclose(f);
	jmp	fclose@PLT	#
	.cfi_endproc
.LFE3907:
	.size	_Z9save_ifedv, .-_Z9save_ifedv
	.section	.rodata._Z9save_xt_1PA200_dPc.str1.1,"aMS",@progbits,1
.LC96:
	.string	"%e  "
.LC97:
	.string	"\n"
	.section	.text._Z9save_xt_1PA200_dPc,"axG",@progbits,_Z9save_xt_1PA200_dPc,comdat
	.p2align 4
	.weak	_Z9save_xt_1PA200_dPc
	.type	_Z9save_xt_1PA200_dPc, @function
_Z9save_xt_1PA200_dPc:
.LFB3908:
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
	movq	%rdi, %r14	# tmp98, distr
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rdi	# tmp99, fname
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 64
# io_manager.h:116:     f = fopen(fname,"w");
	leaq	.LC88(%rip), %rsi	#, tmp91
	leaq	1600(%r14), %rbp	#, ivtmp.1096
	leaq	.LC96(%rip), %r13	#, tmp96
	call	fopen@PLT	#
	addq	$641600, %r14	#, _36
	leaq	.LC97(%rip), %r15	#, tmp97
	movq	%rax, %r12	# tmp100, _12
	.p2align 4
	.p2align 3
.L333:
	leaq	-1600(%rbp), %rbx	#, ivtmp.1088
	.p2align 4
	.p2align 3
.L334:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%rbx), %xmm0	# MEM[(double *)_19], MEM[(double *)_19]
	movq	%r13, %rdx	# tmp96,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _12,
	movl	$1, %eax	#,
# io_manager.h:118:         for (j=0; j<N_XT; j++){
	addq	$8, %rbx	#, ivtmp.1088
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# io_manager.h:118:         for (j=0; j<N_XT; j++){
	cmpq	%rbp, %rbx	# ivtmp.1096, ivtmp.1088
	jne	.L334	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r15, %rdx	# tmp97,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _12,
	xorl	%eax, %eax	#
# io_manager.h:117:     for (i=0; i<N_G; i++){
	leaq	1600(%rbx), %rbp	#, ivtmp.1096
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# io_manager.h:117:     for (i=0; i<N_G; i++){
	cmpq	%r14, %rbp	# _36, ivtmp.1096
	jne	.L333	#,
# io_manager.h:124: }
	addq	$8, %rsp	#,
	.cfi_def_cfa_offset 56
# io_manager.h:123:     fclose(f);
	movq	%r12, %rdi	# _12,
# io_manager.h:124: }
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
# io_manager.h:123:     fclose(f);
	jmp	fclose@PLT	#
	.cfi_endproc
.LFE3908:
	.size	_Z9save_xt_1PA200_dPc, .-_Z9save_xt_1PA200_dPc
	.section	.text._Z11norm_all_xtv,"axG",@progbits,_Z11norm_all_xtv,comdat
	.p2align 4
	.weak	_Z11norm_all_xtv
	.type	_Z11norm_all_xtv, @function
_Z11norm_all_xtv:
.LFB3909:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	vxorps	%xmm0, %xmm0, %xmm0	# tmp278
# io_manager.h:141:             if (counter_e_xt[i][j] > 0) {
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp222
# io_manager.h:126: inline void norm_all_xt(void){
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
# io_manager.h:133:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	xorl	%ebx, %ebx	# ivtmp.1250
# io_manager.h:126: inline void norm_all_xt(void){
	andq	$-64, %rsp	#,
# io_manager.h:132:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	vmovsd	.LC98(%rip), %xmm3	#, tmp194
# io_manager.h:133:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	vmovsd	.LC76(%rip), %xmm12	#, tmp198
# io_manager.h:132:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	movl	no_of_cycles(%rip), %eax	# no_of_cycles, no_of_cycles.171_1
# io_manager.h:143:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vbroadcastsd	.LC101(%rip), %zmm13	#, tmp270
# io_manager.h:143:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vbroadcastsd	.LC51(%rip), %zmm10	#, tmp271
# io_manager.h:132:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	imull	$4000, %eax, %edx	#, no_of_cycles.171_1, tmp192
# io_manager.h:132:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	vcvtsi2sdl	%edx, %xmm0, %xmm1	# tmp192, tmp278, tmp279
# io_manager.h:133:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	vcvtsi2sdl	%eax, %xmm0, %xmm0	# no_of_cycles.171_1, tmp278, tmp280
	leaq	pot_xt(%rip), %rax	#, tmp258
# io_manager.h:132:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	vdivsd	%xmm1, %xmm3, %xmm3	# tmp193, tmp194, f1
	vmovq	%rax, %xmm22	# tmp258, tmp258
	leaq	efield_xt(%rip), %rax	#, tmp261
# io_manager.h:133:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	vmulsd	.LC99(%rip), %xmm0, %xmm0	#, tmp195, tmp196
	vbroadcastsd	%xmm3, %zmm3	# f1, vect_cst__222
	vmovq	%rax, %xmm21	# tmp261, tmp261
	leaq	ne_xt(%rip), %rax	#, tmp267
# io_manager.h:133:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	vdivsd	%xmm0, %xmm12, %xmm12	# tmp196, tmp198, f2
	vbroadcastsd	%xmm12, %zmm12	# f2, vect_cst__310
	vmovq	%rax, %xmm20	# tmp267, tmp267
	leaq	ni_xt(%rip), %rax	#, tmp266
	vmovq	%rax, %xmm19	# tmp266, tmp266
	leaq	counter_e_xt(%rip), %rax	#, tmp255
	vmovq	%rax, %xmm18	# tmp255, tmp255
	leaq	ue_xt(%rip), %rax	#, tmp260
	vmovq	%rax, %xmm17	# tmp260, tmp260
	leaq	je_xt(%rip), %rax	#, tmp256
	vmovq	%rax, %xmm23	# tmp256, tmp256
	leaq	meanee_xt(%rip), %rax	#, tmp265
	vmovq	%rax, %xmm24	# tmp265, tmp265
	leaq	ioniz_rate_xt(%rip), %rax	#, tmp257
	vmovq	%rax, %xmm25	# tmp257, tmp257
	leaq	counter_i_xt(%rip), %rax	#, tmp252
	vmovq	%rax, %xmm26	# tmp252, tmp252
	leaq	ui_xt(%rip), %rax	#, tmp259
	vmovq	%rax, %xmm27	# tmp259, tmp259
	leaq	ji_xt(%rip), %rax	#, tmp254
	vmovq	%rax, %xmm28	# tmp254, tmp254
	leaq	meanei_xt(%rip), %rax	#, tmp262
	vmovq	%rax, %xmm29	# tmp262, tmp262
	leaq	powere_xt(%rip), %rax	#, tmp253
	vmovq	%rax, %xmm30	# tmp253, tmp253
	leaq	poweri_xt(%rip), %rax	#, tmp268
	vmovq	%rax, %xmm31	# tmp268, tmp268
	.p2align 4
	.p2align 3
.L346:
	vmovq	%xmm22, %rax	# tmp258, tmp258
	leaq	(%rax,%rbx), %r10	#, vectp_pot_xt.1106
	vmovq	%xmm21, %rax	# tmp261, tmp261
	leaq	(%rax,%rbx), %r9	#, vectp_efield_xt.1112
	vmovq	%xmm20, %rax	# tmp267, tmp267
	leaq	(%rax,%rbx), %r8	#, vectp_ne_xt.1118
	vmovq	%xmm19, %rax	# tmp266, tmp266
	leaq	(%rax,%rbx), %rdi	#, vectp_ni_xt.1124
	vmovq	%xmm18, %rax	# tmp255, tmp255
	addq	%rbx, %rax	# ivtmp.1250, vectp_counter_e_xt.1130
	vmovq	%rax, %xmm16	# vectp_counter_e_xt.1130, vectp_counter_e_xt.1130
	vmovq	%xmm17, %rax	# tmp260, tmp260
	addq	%rbx, %rax	# ivtmp.1250, vectp.1134
	vmovq	%rax, %xmm15	# vectp.1134, vectp.1134
	vmovq	%xmm23, %rax	# tmp256, tmp256
	leaq	(%rax,%rbx), %rsi	#, vectp.1143
	vmovq	%xmm24, %rax	# tmp265, tmp265
	leaq	(%rax,%rbx), %r13	#, vectp.1145
	vmovq	%xmm25, %rax	# tmp257, tmp257
	leaq	(%rax,%rbx), %r12	#, vectp_ioniz_rate_xt.1151
	vmovq	%xmm26, %rax	# tmp252, tmp252
	addq	%rbx, %rax	# ivtmp.1250, vectp_counter_i_xt.1164
	vmovq	%rax, %xmm14	# vectp_counter_i_xt.1164, vectp_counter_i_xt.1164
	vmovq	%xmm27, %rax	# tmp259, tmp259
	addq	%rbx, %rax	# ivtmp.1250, vectp.1168
	movq	%rax, -8(%rsp)	# vectp.1168, %sfp
	vmovq	%xmm28, %rax	# tmp254, tmp254
	addq	%rbx, %rax	# ivtmp.1250, vectp.1176
	movq	%rax, -16(%rsp)	# vectp.1176, %sfp
	vmovq	%xmm29, %rax	# tmp262, tmp262
	leaq	(%rax,%rbx), %r11	#, vectp_meanei_xt.1178
	vmovq	%xmm30, %rax	# tmp253, tmp253
	leaq	(%rax,%rbx), %r15	#, vectp_powere_xt.1190
	vmovq	%xmm31, %rax	# tmp268, tmp268
	leaq	(%rax,%rbx), %r14	#, vectp_poweri_xt.1193
	xorl	%eax, %eax	# ivtmp.1198
	jmp	.L345	#
	.p2align 4
	.p2align 3
.L339:
# io_manager.h:143:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vxorpd	%xmm0, %xmm0, %xmm0	# vect__104.1141
	movl	$-1, %ecx	#, mask__220.1154
# io_manager.h:145:                 ioniz_rate_xt[i][j] *= f2;
	vmovapd	%zmm0, %zmm1	#, vect__110.1153
.L348:
# io_manager.h:147:                 ue_xt[i][j]         = 0.0;
	kmovb	%ecx, %k2	# mask__220.1154, mask__220.1154
	vmovupd	%zmm6, (%rdx){%k2}	# tmp222, MEM <vector(8) double> [(double *)_82], mask__220.1154
# io_manager.h:148:                 je_xt[i][j]         = 0.0;
	vmovupd	%zmm6, (%rsi,%rax){%k2}	# tmp222, MEM <vector(8) double> [(double *)vectp.1143_284 + ivtmp.1198_88 * 1], mask__220.1154
# io_manager.h:149:                 meanee_xt[i][j]     = 0.0;
	vmovupd	%zmm6, 0(%r13,%rax){%k2}	# tmp222, MEM <vector(8) double> [(double *)vectp.1145_290 + ivtmp.1198_88 * 1], mask__220.1154
	.p2align 4
	.p2align 3
.L340:
# io_manager.h:152:             if (counter_i_xt[i][j] > 0) {
	vmovq	%xmm14, %rdx	# vectp_counter_i_xt.1164, vectp_counter_i_xt.1164
# io_manager.h:145:                 ioniz_rate_xt[i][j] *= f2;
	vmovupd	%zmm1, (%r12,%rax)	# vect__110.1153, MEM <vector(8) double> [(double *)vectp_ioniz_rate_xt.1151_304 + ivtmp.1198_88 * 1]
	movq	-8(%rsp), %rcx	# %sfp, vectp.1168
# io_manager.h:152:             if (counter_i_xt[i][j] > 0) {
	vmovupd	(%rdx,%rax), %zmm5	# MEM <vector(8) double> [(double *)vectp_counter_i_xt.1164_341 + ivtmp.1198_88 * 1], MEM <vector(8) double> [(double *)vectp_counter_i_xt.1164_341 + ivtmp.1198_88 * 1]
	leaq	(%rcx,%rax), %rdx	#, _78
# io_manager.h:152:             if (counter_i_xt[i][j] > 0) {
	vcmppd	$14, %zmm6, %zmm5, %k1	#, tmp222, MEM <vector(8) double> [(double *)vectp_counter_i_xt.1164_341 + ivtmp.1198_88 * 1], mask__156.1166
# io_manager.h:153:                 ui_xt[i][j]     = ui_xt[i][j] / counter_i_xt[i][j];
	vmovupd	(%rdx), %zmm8{%k1}	# MEM <vector(8) double> [(double *)_78], vect__118.1169, mask__156.1166, vect__118.1169
	kortestb	%k1, %k1	# mask__156.1166
# io_manager.h:153:                 ui_xt[i][j]     = ui_xt[i][j] / counter_i_xt[i][j];
	vdivpd	%zmm5, %zmm8, %zmm1{%k1}{z}	# MEM <vector(8) double> [(double *)vectp_counter_i_xt.1164_341 + ivtmp.1198_88 * 1], vect__118.1169, vect__119.1170, mask__156.1166,
	jne	.L359	#,
# io_manager.h:154:                 ji_xt[i][j]     = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE;
	vxorpd	%xmm1, %xmm1, %xmm1	# vect__122.1174
	movl	$-1, %ecx	#, mask__227.1181
# io_manager.h:155:                 meanei_xt[i][j] = meanei_xt[i][j] / counter_i_xt[i][j];
	vmovapd	%zmm1, %zmm2	#, vect__125.1180
.L347:
# io_manager.h:157:                 ui_xt[i][j]     = 0.0;
	kmovb	%ecx, %k5	# mask__227.1181, mask__227.1181
	vmovupd	%zmm6, (%rdx){%k5}	# tmp222, MEM <vector(8) double> [(double *)_78], mask__227.1181
# io_manager.h:158:                 ji_xt[i][j]     = 0.0;
	movq	-16(%rsp), %rdx	# %sfp, vectp.1176
	vmovupd	%zmm6, (%rdx,%rax){%k5}	# tmp222, MEM <vector(8) double> [(double *)vectp.1176_368 + ivtmp.1198_88 * 1], mask__227.1181
	.p2align 4
	.p2align 3
.L342:
# io_manager.h:161:             powere_xt[i][j] = je_xt[i][j] * efield_xt[i][j];
	vmulpd	%zmm0, %zmm4, %zmm0	# vect__104.1141, vect__77.1114, vect__130.1188
# io_manager.h:162:             poweri_xt[i][j] = ji_xt[i][j] * efield_xt[i][j];
	vmulpd	%zmm1, %zmm4, %zmm1	# vect__122.1174, vect__77.1114, vect__132.1191
# io_manager.h:155:                 meanei_xt[i][j] = meanei_xt[i][j] / counter_i_xt[i][j];
	vmovupd	%zmm2, (%r11,%rax)	# vect__125.1180, MEM <vector(8) double> [(double *)vectp_meanei_xt.1178_374 + ivtmp.1198_88 * 1]
# io_manager.h:161:             powere_xt[i][j] = je_xt[i][j] * efield_xt[i][j];
	vmovupd	%zmm0, (%r15,%rax)	# vect__130.1188, MEM <vector(8) double> [(double *)vectp_powere_xt.1190_404 + ivtmp.1198_88 * 1]
# io_manager.h:162:             poweri_xt[i][j] = ji_xt[i][j] * efield_xt[i][j];
	vmovupd	%zmm1, (%r14,%rax)	# vect__132.1191, MEM <vector(8) double> [(double *)vectp_poweri_xt.1193_411 + ivtmp.1198_88 * 1]
	addq	$64, %rax	#, ivtmp.1198
	cmpq	$1600, %rax	#, ivtmp.1198
	je	.L360	#,
.L345:
# io_manager.h:137:             pot_xt[i][j]    *= f1;
	vmulpd	(%r10,%rax), %zmm3, %zmm0	# MEM <vector(8) double> [(double *)vectp_pot_xt.1106_127 + ivtmp.1198_88 * 1], vect_cst__222, vect__80.1108
# io_manager.h:141:             if (counter_e_xt[i][j] > 0) {
	vmovq	%xmm16, %rdx	# vectp_counter_e_xt.1130, vectp_counter_e_xt.1130
# io_manager.h:137:             pot_xt[i][j]    *= f1;
	vmovupd	%zmm0, (%r10,%rax)	# vect__80.1108, MEM <vector(8) double> [(double *)vectp_pot_xt.1106_127 + ivtmp.1198_88 * 1]
# io_manager.h:138:             efield_xt[i][j] *= f1;
	vmulpd	(%r9,%rax), %zmm3, %zmm4	# MEM <vector(8) double> [(double *)vectp_efield_xt.1112_93 + ivtmp.1198_88 * 1], vect_cst__222, vect__77.1114
	vmovupd	%zmm4, (%r9,%rax)	# vect__77.1114, MEM <vector(8) double> [(double *)vectp_efield_xt.1112_93 + ivtmp.1198_88 * 1]
# io_manager.h:139:             ne_xt[i][j]     *= f1;
	vmulpd	(%r8,%rax), %zmm3, %zmm5	# MEM <vector(8) double> [(double *)vectp_ne_xt.1118_98 + ivtmp.1198_88 * 1], vect_cst__222, vect__73.1120
	vmovupd	%zmm5, (%r8,%rax)	# vect__73.1120, MEM <vector(8) double> [(double *)vectp_ne_xt.1118_98 + ivtmp.1198_88 * 1]
# io_manager.h:140:             ni_xt[i][j]     *= f1;
	vmulpd	(%rdi,%rax), %zmm3, %zmm2	# MEM <vector(8) double> [(double *)vectp_ni_xt.1124_242 + ivtmp.1198_88 * 1], vect_cst__222, vect__67.1126
	vmovupd	%zmm2, (%rdi,%rax)	# vect__67.1126, MEM <vector(8) double> [(double *)vectp_ni_xt.1124_242 + ivtmp.1198_88 * 1]
# io_manager.h:141:             if (counter_e_xt[i][j] > 0) {
	vmovupd	(%rdx,%rax), %zmm1	# MEM <vector(8) double> [(double *)vectp_counter_e_xt.1130_256 + ivtmp.1198_88 * 1], MEM <vector(8) double> [(double *)vectp_counter_e_xt.1130_256 + ivtmp.1198_88 * 1]
	vmovq	%xmm15, %rdx	# vectp.1134, vectp.1134
	addq	%rax, %rdx	# ivtmp.1198, _82
# io_manager.h:141:             if (counter_e_xt[i][j] > 0) {
	vcmppd	$14, %zmm6, %zmm1, %k1	#, tmp222, MEM <vector(8) double> [(double *)vectp_counter_e_xt.1130_256 + ivtmp.1198_88 * 1], mask__154.1132
# io_manager.h:142:                 ue_xt[i][j]     =  ue_xt[i][j] / counter_e_xt[i][j];
	vmovupd	(%rdx), %zmm7{%k1}	# MEM <vector(8) double> [(double *)_82], vect__31.1135, mask__154.1132, vect__31.1135
	kortestb	%k1, %k1	# mask__154.1132
# io_manager.h:142:                 ue_xt[i][j]     =  ue_xt[i][j] / counter_e_xt[i][j];
	vdivpd	%zmm1, %zmm7, %zmm0{%k1}{z}	# MEM <vector(8) double> [(double *)vectp_counter_e_xt.1130_256 + ivtmp.1198_88 * 1], vect__31.1135, vect__33.1136, mask__154.1132,
	je	.L339	#,
# io_manager.h:142:                 ue_xt[i][j]     =  ue_xt[i][j] / counter_e_xt[i][j];
	vmovupd	%zmm0, (%rdx){%k1}	# vect__33.1136, MEM <vector(8) double> [(double *)_82], mask__154.1132
# io_manager.h:143:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vxorpd	%zmm13, %zmm0, %zmm0	# tmp270, vect__33.1136, vect__102.1139
	leaq	0(%r13,%rax), %rcx	#, _154
# io_manager.h:143:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vmulpd	%zmm0, %zmm5, %zmm11{%k1}{z}	# vect__102.1139, vect__73.1120, vect__103.1140, mask__154.1132,
# io_manager.h:143:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vmulpd	%zmm10, %zmm11, %zmm0{%k1}{z}	# tmp271, vect__103.1140, vect__104.1141, mask__154.1132,
# io_manager.h:143:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vmovupd	%zmm0, (%rsi,%rax){%k1}	# vect__104.1141, MEM <vector(8) double> [(double *)vectp.1143_284 + ivtmp.1198_88 * 1], mask__154.1132
# io_manager.h:144:                 meanee_xt[i][j] =  meanee_xt[i][j] / counter_e_xt[i][j];
	vmovupd	(%rcx), %zmm9{%k1}	# MEM <vector(8) double> [(double *)_154], vect__106.1146, mask__154.1132, vect__106.1146
# io_manager.h:144:                 meanee_xt[i][j] =  meanee_xt[i][j] / counter_e_xt[i][j];
	vdivpd	%zmm1, %zmm9, %zmm5{%k1}{z}	# MEM <vector(8) double> [(double *)vectp_counter_e_xt.1130_256 + ivtmp.1198_88 * 1], vect__106.1146, vect__107.1147, mask__154.1132,
# io_manager.h:144:                 meanee_xt[i][j] =  meanee_xt[i][j] / counter_e_xt[i][j];
	vmovupd	%zmm5, (%rcx){%k1}	# vect__107.1147, MEM <vector(8) double> [(double *)_154], mask__154.1132
	kmovb	%k1, %ecx	# mask__154.1132, mask__154.1132
# io_manager.h:145:                 ioniz_rate_xt[i][j] *= f2;
	vmulpd	(%r12,%rax), %zmm12, %zmm1{%k1}{z}	# MEM <vector(8) double> [(double *)vectp_ioniz_rate_xt.1151_304 + ivtmp.1198_88 * 1], vect_cst__310, vect__110.1153, mask__154.1132,
	xorb	$-1, %cl	#, mask__154.1132
	je	.L340	#,
	jmp	.L348	#
	.p2align 4
	.p2align 3
.L359:
# io_manager.h:154:                 ji_xt[i][j]     = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE;
	vmulpd	%zmm1, %zmm2, %zmm11{%k1}{z}	# vect__119.1170, vect__67.1126, vect__121.1173, mask__156.1166,
# io_manager.h:154:                 ji_xt[i][j]     = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE;
	movq	-16(%rsp), %rcx	# %sfp, vectp.1176
# io_manager.h:153:                 ui_xt[i][j]     = ui_xt[i][j] / counter_i_xt[i][j];
	vmovupd	%zmm1, (%rdx){%k1}	# vect__119.1170, MEM <vector(8) double> [(double *)_78], mask__156.1166
# io_manager.h:154:                 ji_xt[i][j]     = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE;
	vmulpd	%zmm10, %zmm11, %zmm1{%k1}{z}	# tmp271, vect__121.1173, vect__122.1174, mask__156.1166,
# io_manager.h:154:                 ji_xt[i][j]     = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE;
	vmovupd	%zmm1, (%rcx,%rax){%k1}	# vect__122.1174, MEM <vector(8) double> [(double *)vectp.1176_368 + ivtmp.1198_88 * 1], mask__156.1166
# io_manager.h:155:                 meanei_xt[i][j] = meanei_xt[i][j] / counter_i_xt[i][j];
	vmovupd	(%r11,%rax), %zmm2	# MEM <vector(8) double> [(double *)vectp_meanei_xt.1178_374 + ivtmp.1198_88 * 1], tmp342
	kmovb	%k1, %ecx	# mask__156.1166, mask__156.1166
	xorb	$-1, %cl	#, mask__156.1166
	vdivpd	%zmm5, %zmm2, %zmm2{%k1}{z}	# MEM <vector(8) double> [(double *)vectp_counter_i_xt.1164_341 + ivtmp.1198_88 * 1], tmp342, vect__125.1180, mask__156.1166,
	je	.L342	#,
	jmp	.L347	#
	.p2align 4
	.p2align 3
.L360:
# io_manager.h:135:     for (i=0; i<N_G; i++){
	addq	$1600, %rbx	#, ivtmp.1250
	cmpq	$640000, %rbx	#, ivtmp.1250
	jne	.L346	#,
	vzeroupper
# io_manager.h:165: }
	leaq	-40(%rbp), %rsp	#,
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE3909:
	.size	_Z11norm_all_xtv, .-_Z11norm_all_xtv
	.section	.text._Z11save_all_xtv,"axG",@progbits,_Z11save_all_xtv,comdat
	.p2align 4
	.weak	_Z11save_all_xtv
	.type	_Z11save_all_xtv, @function
_Z11save_all_xtv:
.LFB3910:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
# io_manager.h:170:     strcpy(fname,"pot_xt.dat");     save_xt_1(pot_xt, fname);
	leaq	pot_xt(%rip), %rdi	#, tmp86
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$32758180202444895, %rbp	#, tmp89
# io_manager.h:167: inline void save_all_xt(void){
	subq	$104, %rsp	#,
	.cfi_def_cfa_offset 128
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rsp, %rbx	#, tmp83
# io_manager.h:167: inline void save_all_xt(void){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp134
	movq	%rax, 88(%rsp)	# tmp134, D.83079
	xorl	%eax, %eax	# tmp134
# io_manager.h:170:     strcpy(fname,"pot_xt.dat");     save_xt_1(pot_xt, fname);
	movq	%rbx, %rsi	# tmp83,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$7218835313067847536, %rax	#, tmp137
	movq	%rax, (%rsp)	# tmp137, MEM <char[1:11]> [(void *)&fname]
	movl	$7627108, 7(%rsp)	#, MEM <char[1:11]> [(void *)&fname]
# io_manager.h:170:     strcpy(fname,"pot_xt.dat");     save_xt_1(pot_xt, fname);
	call	_Z9save_xt_1PA200_dPc	#
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8673761824059516517, %rax	#, tmp138
# io_manager.h:171:     strcpy(fname,"efield_xt.dat");  save_xt_1(efield_xt, fname);
	movq	%rbx, %rsi	# tmp83,
	leaq	efield_xt(%rip), %rdi	#, tmp91
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, (%rsp)	# tmp138, MEM <char[1:14]> [(void *)&fname]
	movq	%rbp, 6(%rsp)	# tmp89, MEM <char[1:14]> [(void *)&fname]
# io_manager.h:171:     strcpy(fname,"efield_xt.dat");  save_xt_1(efield_xt, fname);
	call	_Z9save_xt_1PA200_dPc	#
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$7017785197120677230, %rax	#, tmp139
# io_manager.h:172:     strcpy(fname,"ne_xt.dat");      save_xt_1(ne_xt, fname);
	movq	%rbx, %rsi	# tmp83,
	leaq	ne_xt(%rip), %rdi	#, tmp95
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, (%rsp)	# tmp139, MEM <char[1:10]> [(void *)&fname]
	movw	$116, 8(%rsp)	#, MEM <char[1:10]> [(void *)&fname]
# io_manager.h:172:     strcpy(fname,"ne_xt.dat");      save_xt_1(ne_xt, fname);
	call	_Z9save_xt_1PA200_dPc	#
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$7017785197120678254, %rax	#, tmp140
# io_manager.h:173:     strcpy(fname,"ni_xt.dat");      save_xt_1(ni_xt, fname);
	movq	%rbx, %rsi	# tmp83,
	leaq	ni_xt(%rip), %rdi	#, tmp99
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, (%rsp)	# tmp140, MEM <char[1:10]> [(void *)&fname]
	movw	$116, 8(%rsp)	#, MEM <char[1:10]> [(void *)&fname]
# io_manager.h:173:     strcpy(fname,"ni_xt.dat");      save_xt_1(ni_xt, fname);
	call	_Z9save_xt_1PA200_dPc	#
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$7017785197120677226, %rax	#, tmp141
# io_manager.h:174:     strcpy(fname,"je_xt.dat");      save_xt_1(je_xt, fname);
	movq	%rbx, %rsi	# tmp83,
	leaq	je_xt(%rip), %rdi	#, tmp103
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, (%rsp)	# tmp141, MEM <char[1:10]> [(void *)&fname]
	movw	$116, 8(%rsp)	#, MEM <char[1:10]> [(void *)&fname]
# io_manager.h:174:     strcpy(fname,"je_xt.dat");      save_xt_1(je_xt, fname);
	call	_Z9save_xt_1PA200_dPc	#
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$7017785197120678250, %rax	#, tmp142
# io_manager.h:175:     strcpy(fname,"ji_xt.dat");      save_xt_1(ji_xt, fname);
	movq	%rbx, %rsi	# tmp83,
	leaq	ji_xt(%rip), %rdi	#, tmp107
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, (%rsp)	# tmp142, MEM <char[1:10]> [(void *)&fname]
	movw	$116, 8(%rsp)	#, MEM <char[1:10]> [(void *)&fname]
# io_manager.h:175:     strcpy(fname,"ji_xt.dat");      save_xt_1(ji_xt, fname);
	call	_Z9save_xt_1PA200_dPc	#
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8673762949341867888, %rax	#, tmp143
# io_manager.h:176:     strcpy(fname,"powere_xt.dat");  save_xt_1(powere_xt, fname);
	movq	%rbx, %rsi	# tmp83,
	leaq	powere_xt(%rip), %rdi	#, tmp112
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, (%rsp)	# tmp143, MEM <char[1:14]> [(void *)&fname]
	movq	%rbp, 6(%rsp)	# tmp89, MEM <char[1:14]> [(void *)&fname]
# io_manager.h:176:     strcpy(fname,"powere_xt.dat");  save_xt_1(powere_xt, fname);
	call	_Z9save_xt_1PA200_dPc	#
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8673767347388378992, %rax	#, tmp144
# io_manager.h:177:     strcpy(fname,"poweri_xt.dat");  save_xt_1(poweri_xt, fname);
	movq	%rbx, %rsi	# tmp83,
	leaq	poweri_xt(%rip), %rdi	#, tmp117
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, (%rsp)	# tmp144, MEM <char[1:14]> [(void *)&fname]
	movq	%rbp, 6(%rsp)	# tmp89, MEM <char[1:14]> [(void *)&fname]
# io_manager.h:177:     strcpy(fname,"poweri_xt.dat");  save_xt_1(poweri_xt, fname);
	call	_Z9save_xt_1PA200_dPc	#
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8673762893656843629, %rax	#, tmp145
# io_manager.h:178:     strcpy(fname,"meanee_xt.dat");  save_xt_1(meanee_xt, fname);
	movq	%rbx, %rsi	# tmp83,
	leaq	meanee_xt(%rip), %rdi	#, tmp122
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, (%rsp)	# tmp145, MEM <char[1:14]> [(void *)&fname]
	movq	%rbp, 6(%rsp)	# tmp89, MEM <char[1:14]> [(void *)&fname]
# io_manager.h:178:     strcpy(fname,"meanee_xt.dat");  save_xt_1(meanee_xt, fname);
	call	_Z9save_xt_1PA200_dPc	#
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8673767291703354733, %rax	#, tmp146
# io_manager.h:179:     strcpy(fname,"meanei_xt.dat");  save_xt_1(meanei_xt, fname);
	movq	%rbx, %rsi	# tmp83,
	leaq	meanei_xt(%rip), %rdi	#, tmp127
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, (%rsp)	# tmp146, MEM <char[1:14]> [(void *)&fname]
	movq	%rbp, 6(%rsp)	# tmp89, MEM <char[1:14]> [(void *)&fname]
# io_manager.h:179:     strcpy(fname,"meanei_xt.dat");  save_xt_1(meanei_xt, fname);
	call	_Z9save_xt_1PA200_dPc	#
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8392562884964413289, %rax	#, tmp147
# io_manager.h:180:     strcpy(fname,"ioniz_xt.dat");   save_xt_1(ioniz_rate_xt, fname);
	movq	%rbx, %rsi	# tmp83,
	leaq	ioniz_rate_xt(%rip), %rdi	#, tmp132
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, (%rsp)	# tmp147, MEM <char[1:13]> [(void *)&fname]
	movq	%rbp, 5(%rsp)	# tmp89, MEM <char[1:13]> [(void *)&fname]
# io_manager.h:180:     strcpy(fname,"ioniz_xt.dat");   save_xt_1(ioniz_rate_xt, fname);
	call	_Z9save_xt_1PA200_dPc	#
# io_manager.h:181: }
	movq	88(%rsp), %rax	# D.83079, tmp135
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp135
	jne	.L365	#,
	addq	$104, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
.L365:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE3910:
	.size	_Z11save_all_xtv, .-_Z11save_all_xtv
	.section	.rodata._Z19check_and_save_infov.str1.1,"aMS",@progbits,1
.LC104:
	.string	"info.txt"
	.section	.rodata._Z19check_and_save_infov.str1.8,"aMS",@progbits,1
	.align 8
.LC105:
	.string	"########################## eduPIC simulation report ############################\n"
	.section	.rodata._Z19check_and_save_infov.str1.1
.LC106:
	.string	"Simulation parameters:\n"
	.section	.rodata._Z19check_and_save_infov.str1.8
	.align 8
.LC107:
	.string	"Gap distance                          = %12.3e [m]\n"
	.align 8
.LC108:
	.string	"# of grid divisions                   = %12d\n"
	.align 8
.LC109:
	.string	"Frequency                             = %12.3e [Hz]\n"
	.align 8
.LC110:
	.string	"# of time steps / period              = %12d\n"
	.align 8
.LC111:
	.string	"# of electron / ion time steps        = %12d\n"
	.align 8
.LC112:
	.string	"Voltage amplitude                     = %12.3e [V]\n"
	.align 8
.LC113:
	.string	"Pressure (Ar)                         = %12.3e [Pa]\n"
	.align 8
.LC115:
	.string	"Temperature                           = %12.3e [K]\n"
	.align 8
.LC117:
	.string	"Superparticle weight                  = %12.3e\n"
	.align 8
.LC118:
	.string	"# of simulation cycles in this run    = %12d\n"
	.align 8
.LC119:
	.string	"--------------------------------------------------------------------------------\n"
	.section	.rodata._Z19check_and_save_infov.str1.1
.LC120:
	.string	"Plasma characteristics:\n"
	.section	.rodata._Z19check_and_save_infov.str1.8
	.align 8
.LC121:
	.string	"Electron density @ center             = %12.3e [m^{-3}]\n"
	.align 8
.LC122:
	.string	"Plasma frequency @ center             = %12.3e [rad/s]\n"
	.align 8
.LC123:
	.string	"Debye length @ center                 = %12.3e [m]\n"
	.align 8
.LC124:
	.string	"Electron collision frequency          = %12.3e [1/s]\n"
	.align 8
.LC125:
	.string	"Ion collision frequency               = %12.3e [1/s]\n"
	.align 8
.LC126:
	.string	"Stability and accuracy conditions:\n"
	.align 8
.LC127:
	.string	"Plasma frequency @ center * DT_E      = %12.3f (OK if less than 0.20)\n"
	.align 8
.LC128:
	.string	"DX / Debye length @ center            = %12.3f (OK if less than 1.00)\n"
	.align 8
.LC130:
	.string	"Max. electron coll. frequency * DT_E  = %12.3f (OK if less than 0.05)\n"
	.align 8
.LC131:
	.string	"Max. ion coll. frequency * DT_I       = %12.3f (OK if less than 0.05)\n"
	.align 8
.LC132:
	.string	"** STABILITY AND ACCURACY CONDITION(S) VIOLATED - REFINE SIMULATION SETTINGS! **\n"
	.align 8
.LC133:
	.string	">> eduPIC: ERROR: STABILITY AND ACCURACY CONDITION(S) VIOLATED!\n"
	.align 8
.LC134:
	.string	">> eduPIC: for details see 'info.txt' and refine simulation settings!\n"
	.align 8
.LC136:
	.string	"Max e- energy for CFL condition       = %12.3f [eV]\n"
	.align 8
.LC137:
	.string	"Check EEPF to ensure that CFL is fulfilled for the majority of the electrons!\n"
	.align 8
.LC138:
	.string	">> eduPIC: saving diagnostics data\n"
	.align 8
.LC139:
	.string	"Particle characteristics at the electrodes:\n"
	.align 8
.LC142:
	.string	"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n"
	.align 8
.LC143:
	.string	"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n"
	.align 8
.LC144:
	.string	"Mean ion energy at powered electrode  = %12.3e [eV]\n"
	.align 8
.LC145:
	.string	"Mean ion energy at grounded electrode = %12.3e [eV]\n"
	.align 8
.LC146:
	.string	"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n"
	.align 8
.LC147:
	.string	"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n"
	.align 8
.LC149:
	.string	"Absorbed power calculated as <j*E>:\n"
	.align 8
.LC150:
	.string	"Electron power density (average)      = %12.3e [W m^{-3}]\n"
	.align 8
.LC151:
	.string	"Ion power density (average)           = %12.3e [W m^{-3}]\n"
	.align 8
.LC152:
	.string	"Total power density(average)          = %12.3e [W m^{-3}]\n"
	.section	.text._Z19check_and_save_infov,"axG",@progbits,_Z19check_and_save_infov,comdat
	.p2align 4
	.weak	_Z19check_and_save_infov
	.type	_Z19check_and_save_infov, @function
_Z19check_and_save_infov:
.LFB3911:
	.cfi_startproc
	endbr64	
	pushq	%r14	#
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r12	#
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp	#
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
# io_manager.h:189:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // e density @ center
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp375
# io_manager.h:183: inline void check_and_save_info(void){
	pushq	%rbx	#
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp213
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 80
# io_manager.h:189:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // e density @ center
	vmovsd	1600+cumul_e_density(%rip), %xmm0	# cumul_e_density[200], cumul_e_density[200]
# io_manager.h:189:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // e density @ center
	vcvtsi2sdl	no_of_cycles(%rip), %xmm7, %xmm1	# no_of_cycles, tmp375, tmp360
# io_manager.h:189:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // e density @ center
	vdivsd	%xmm1, %xmm0, %xmm0	# _3, cumul_e_density[200], tmp207
# io_manager.h:189:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // e density @ center
	vdivsd	.LC90(%rip), %xmm0, %xmm5	#, tmp207, density
# io_manager.h:190:     plas_freq  = E_CHARGE * sqrt(density / EPSILON0 / E_MASS);                       // e plasma frequency @ center
	vdivsd	.LC102(%rip), %xmm5, %xmm0	#, density, tmp210
# io_manager.h:189:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // e density @ center
	vmovsd	%xmm5, 8(%rsp)	# density, %sfp
# io_manager.h:190:     plas_freq  = E_CHARGE * sqrt(density / EPSILON0 / E_MASS);                       // e plasma frequency @ center
	vdivsd	.LC52(%rip), %xmm0, %xmm0	#, tmp210, _6
	vucomisd	%xmm0, %xmm2	# _6, tmp213
	ja	.L384	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _6, _7
.L369:
# io_manager.h:194:     ecoll_freq = (double)(N_e_coll) / sim_time / (double)(N_e);                      // e collision frequency
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp379
# io_manager.h:193:     sim_time   = (double)(no_of_cycles) / FREQUENCY;                                 // simulated time
	vdivsd	.LC103(%rip), %xmm1, %xmm1	#, _3, sim_time
# io_manager.h:190:     plas_freq  = E_CHARGE * sqrt(density / EPSILON0 / E_MASS);                       // e plasma frequency @ center
	vmulsd	.LC51(%rip), %xmm0, %xmm5	#, _7, plas_freq
# io_manager.h:194:     ecoll_freq = (double)(N_e_coll) / sim_time / (double)(N_e);                      // e collision frequency
	vcvtsi2sdl	N_e(%rip), %xmm4, %xmm2	# N_e, tmp380, tmp362
# io_manager.h:194:     ecoll_freq = (double)(N_e_coll) / sim_time / (double)(N_e);                      // e collision frequency
	vcvtusi2sdq	N_e_coll(%rip), %xmm4, %xmm0	# N_e_coll, tmp379, tmp361
# io_manager.h:190:     plas_freq  = E_CHARGE * sqrt(density / EPSILON0 / E_MASS);                       // e plasma frequency @ center
	vmovsd	%xmm5, 16(%rsp)	# plas_freq, %sfp
# io_manager.h:194:     ecoll_freq = (double)(N_e_coll) / sim_time / (double)(N_e);                      // e collision frequency
	vdivsd	%xmm1, %xmm0, %xmm0	# sim_time, tmp216, tmp217
# io_manager.h:194:     ecoll_freq = (double)(N_e_coll) / sim_time / (double)(N_e);                      // e collision frequency
	vdivsd	%xmm2, %xmm0, %xmm6	# tmp218, tmp217, ecoll_freq
# io_manager.h:195:     icoll_freq = (double)(N_i_coll) / sim_time / (double)(N_i);                      // ion collision frequency
	vcvtusi2sdq	N_i_coll(%rip), %xmm4, %xmm0	# N_i_coll, tmp382, tmp363
# io_manager.h:194:     ecoll_freq = (double)(N_e_coll) / sim_time / (double)(N_e);                      // e collision frequency
	vmovq	%xmm6, %r12	# ecoll_freq, ecoll_freq
# io_manager.h:195:     icoll_freq = (double)(N_i_coll) / sim_time / (double)(N_i);                      // ion collision frequency
	vdivsd	%xmm1, %xmm0, %xmm0	# sim_time, tmp219, tmp220
# io_manager.h:195:     icoll_freq = (double)(N_i_coll) / sim_time / (double)(N_i);                      // ion collision frequency
	vcvtsi2sdl	N_i(%rip), %xmm4, %xmm1	# N_i, tmp383, tmp364
# io_manager.h:195:     icoll_freq = (double)(N_i_coll) / sim_time / (double)(N_i);                      // ion collision frequency
	vdivsd	%xmm1, %xmm0, %xmm7	# tmp221, tmp220, icoll_freq
# io_manager.h:191:     meane      = mean_energy_accu_center / (double)(mean_energy_counter_center);     // e mean energy @ center
	vcvtusi2sdq	mean_energy_counter_center(%rip), %xmm4, %xmm1	# mean_energy_counter_center, tmp385, tmp365
# io_manager.h:191:     meane      = mean_energy_accu_center / (double)(mean_energy_counter_center);     // e mean energy @ center
	vmovsd	mean_energy_accu_center(%rip), %xmm0	# mean_energy_accu_center, mean_energy_accu_center
# io_manager.h:195:     icoll_freq = (double)(N_i_coll) / sim_time / (double)(N_i);                      // ion collision frequency
	vmovq	%xmm7, %r14	# icoll_freq, icoll_freq
# io_manager.h:191:     meane      = mean_energy_accu_center / (double)(mean_energy_counter_center);     // e mean energy @ center
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp222, mean_energy_accu_center, meane
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp232
# io_manager.h:192:     kT         = 2.0 * meane * EV_TO_J / 3.0;                                        // k T_e @ center (approximate)
	vaddsd	%xmm0, %xmm0, %xmm0	# meane, meane, tmp225
# io_manager.h:192:     kT         = 2.0 * meane * EV_TO_J / 3.0;                                        // k T_e @ center (approximate)
	vmulsd	.LC51(%rip), %xmm0, %xmm0	#, tmp225, tmp226
# io_manager.h:192:     kT         = 2.0 * meane * EV_TO_J / 3.0;                                        // k T_e @ center (approximate)
	vdivsd	.LC18(%rip), %xmm0, %xmm0	#, tmp226, kT
# io_manager.h:196:     debye_length = sqrt(EPSILON0 * kT / density) / E_CHARGE;                         // e Debye length @ center
	vmulsd	.LC102(%rip), %xmm0, %xmm0	#, kT, tmp230
# io_manager.h:196:     debye_length = sqrt(EPSILON0 * kT / density) / E_CHARGE;                         // e Debye length @ center
	vdivsd	8(%rsp), %xmm0, %xmm0	# %sfp, tmp230, _26
	vucomisd	%xmm0, %xmm1	# _26, tmp232
	ja	.L385	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _26, _27
.L372:
# io_manager.h:198:     f = fopen("info.txt","w");
	leaq	.LC88(%rip), %rsi	#, tmp234
	leaq	.LC104(%rip), %rdi	#, tmp235
# io_manager.h:196:     debye_length = sqrt(EPSILON0 * kT / density) / E_CHARGE;                         // e Debye length @ center
	vdivsd	.LC51(%rip), %xmm0, %xmm6	#, _27, debye_length
	vmovsd	%xmm6, 24(%rsp)	# debye_length, %sfp
# io_manager.h:198:     f = fopen("info.txt","w");
	call	fopen@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	leaq	.LC105(%rip), %rdx	#, tmp237
	movl	$2, %esi	#,
	leaq	.LC119(%rip), %rbp	#, tmp347
# io_manager.h:198:     f = fopen("info.txt","w");
	movq	%rax, %rbx	# tmp355, _91
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%rax, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC106(%rip), %rdx	#, tmp238
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC107(%rip), %rdx	#, tmp240
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC82(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	movl	$400, %ecx	#,
	leaq	.LC108(%rip), %rdx	#, tmp241
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC109(%rip), %rdx	#, tmp243
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC103(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	movl	$4000, %ecx	#,
	leaq	.LC110(%rip), %rdx	#, tmp244
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	movl	$20, %ecx	#,
	leaq	.LC111(%rip), %rdx	#, tmp245
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC112(%rip), %rdx	#, tmp247
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC55(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	leaq	.LC113(%rip), %rdx	#, tmp249
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC17(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	leaq	.LC115(%rip), %rdx	#, tmp251
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC114(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	leaq	.LC117(%rip), %rdx	#, tmp253
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC116(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	movl	no_of_cycles(%rip), %ecx	# no_of_cycles,
	leaq	.LC118(%rip), %rdx	#, tmp255
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	movq	%rbp, %rdx	# tmp347,
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC120(%rip), %rdx	#, tmp257
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC121(%rip), %rdx	#, tmp258
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	8(%rsp), %xmm0	# %sfp,
	call	__fprintf_chk@PLT	#
	leaq	.LC122(%rip), %rdx	#, tmp259
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	16(%rsp), %xmm0	# %sfp,
	call	__fprintf_chk@PLT	#
	leaq	.LC123(%rip), %rdx	#, tmp260
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	24(%rsp), %xmm0	# %sfp,
	call	__fprintf_chk@PLT	#
	vmovq	%r12, %xmm0	# ecoll_freq,
	leaq	.LC124(%rip), %rdx	#, tmp261
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	call	__fprintf_chk@PLT	#
	vmovq	%r14, %xmm0	# icoll_freq,
	leaq	.LC125(%rip), %rdx	#, tmp262
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	call	__fprintf_chk@PLT	#
	movq	%rbp, %rdx	# tmp347,
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC126(%rip), %rdx	#, tmp264
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC127(%rip), %rdx	#, tmp266
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# io_manager.h:221:     c = plas_freq * DT_E;
	vmovsd	.LC69(%rip), %xmm5	#, tmp388
	vmulsd	16(%rsp), %xmm5, %xmm1	# %sfp, tmp388, c
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm1, %xmm1, %xmm0	# c,
	vmovsd	%xmm1, 16(%rsp)	# c, %sfp
	call	__fprintf_chk@PLT	#
	leaq	.LC128(%rip), %rdx	#, tmp268
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# io_manager.h:224:     c = DX / debye_length;
	vmovsd	.LC65(%rip), %xmm0	#, tmp267
# io_manager.h:226:     if (c > 1.0) {conditions_OK = false;}
	xorl	%r12d, %r12d	# conditions_OK
# io_manager.h:224:     c = DX / debye_length;
	vdivsd	24(%rsp), %xmm0, %xmm0	# %sfp, tmp267, c
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm0, 8(%rsp)	# c, %sfp
	call	__fprintf_chk@PLT	#
# io_manager.h:226:     if (c > 1.0) {conditions_OK = false;}
	vmovsd	8(%rsp), %xmm0	# %sfp, c
	vcomisd	.LC12(%rip), %xmm0	#, c
	ja	.L373	#,
# io_manager.h:223:     if (c > 0.2) {conditions_OK = false;}
	vmovsd	16(%rsp), %xmm1	# %sfp, c
	vcomisd	.LC129(%rip), %xmm1	#, c
	setbe	%r12b	#, conditions_OK
.L373:
# io_manager.h:227:     c = max_electron_coll_freq() * DT_E;
	call	_Z22max_electron_coll_freqv	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	leaq	.LC130(%rip), %rdx	#, tmp273
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# io_manager.h:227:     c = max_electron_coll_freq() * DT_E;
	vmulsd	.LC69(%rip), %xmm0, %xmm0	#, tmp356, c
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm0, 8(%rsp)	# c, %sfp
	call	__fprintf_chk@PLT	#
# io_manager.h:229:     if (c > 0.05) {conditions_OK = false;}
	vmovsd	8(%rsp), %xmm0	# %sfp, c
	vcomisd	.LC20(%rip), %xmm0	#, c
	ja	.L374	#,
# io_manager.h:230:     c = max_ion_coll_freq() * DT_I;
	call	_Z17max_ion_coll_freqv	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	leaq	.LC131(%rip), %rdx	#, tmp276
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# io_manager.h:230:     c = max_ion_coll_freq() * DT_I;
	vmulsd	.LC70(%rip), %xmm0, %xmm0	#, tmp357, c
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm0, 8(%rsp)	# c, %sfp
	call	__fprintf_chk@PLT	#
# io_manager.h:232:     if (c > 0.05) {conditions_OK = false;}
	vmovsd	8(%rsp), %xmm0	# %sfp, c
	vcomisd	.LC20(%rip), %xmm0	#, c
	ja	.L375	#,
# io_manager.h:233:     if (conditions_OK == false){
	testb	%r12b, %r12b	# conditions_OK
	je	.L375	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	leaq	.LC136(%rip), %rdx	#, tmp284
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC135(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	leaq	.LC137(%rip), %rdx	#, tmp285
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	movq	%rbp, %rdx	# tmp347,
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC138(%rip), %rsi	#, tmp287
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# io_manager.h:255:         save_density();
	call	_Z12save_densityv	#
# io_manager.h:256:         save_eepf();
	call	_Z9save_eepfv	#
# io_manager.h:257:         save_ifed();
	call	_Z9save_ifedv	#
# io_manager.h:258:         norm_all_xt();
	call	_Z11norm_all_xtv	#
# io_manager.h:259:         save_all_xt();
	call	_Z11save_all_xtv	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	leaq	.LC139(%rip), %rdx	#, tmp288
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC142(%rip), %rdx	#, tmp298
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# io_manager.h:261:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp391
	vcvtusi2sdq	N_i_abs_pow(%rip), %xmm3, %xmm0	# N_i_abs_pow, tmp391, tmp366
# io_manager.h:261:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vcvtsi2sdl	no_of_cycles(%rip), %xmm3, %xmm1	# no_of_cycles, tmp392, tmp367
# io_manager.h:261:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC116(%rip), %xmm0, %xmm0	#, tmp289, tmp290
# io_manager.h:261:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC141(%rip), %xmm1, %xmm1	#, tmp294, tmp295
# io_manager.h:261:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	.LC140(%rip), %xmm0, %xmm0	#, tmp290, tmp292
# io_manager.h:261:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp295, tmp292, tmp297
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
	leaq	.LC143(%rip), %rdx	#, tmp308
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# io_manager.h:262:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp393
	vcvtusi2sdq	N_i_abs_gnd(%rip), %xmm3, %xmm0	# N_i_abs_gnd, tmp393, tmp368
# io_manager.h:262:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vcvtsi2sdl	no_of_cycles(%rip), %xmm3, %xmm1	# no_of_cycles, tmp394, tmp369
# io_manager.h:262:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC116(%rip), %xmm0, %xmm0	#, tmp299, tmp300
# io_manager.h:262:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC141(%rip), %xmm1, %xmm1	#, tmp304, tmp305
# io_manager.h:262:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	.LC140(%rip), %xmm0, %xmm0	#, tmp300, tmp302
# io_manager.h:262:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp305, tmp302, tmp307
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
	leaq	.LC144(%rip), %rdx	#, tmp310
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	mean_i_energy_pow(%rip), %xmm0	# mean_i_energy_pow,
	call	__fprintf_chk@PLT	#
	leaq	.LC145(%rip), %rdx	#, tmp312
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	mean_i_energy_gnd(%rip), %xmm0	# mean_i_energy_gnd,
	call	__fprintf_chk@PLT	#
	leaq	.LC146(%rip), %rdx	#, tmp322
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# io_manager.h:265:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp395
	vcvtusi2sdq	N_e_abs_pow(%rip), %xmm3, %xmm0	# N_e_abs_pow, tmp395, tmp370
# io_manager.h:265:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vcvtsi2sdl	no_of_cycles(%rip), %xmm3, %xmm1	# no_of_cycles, tmp396, tmp371
# io_manager.h:265:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC116(%rip), %xmm0, %xmm0	#, tmp313, tmp314
# io_manager.h:265:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC141(%rip), %xmm1, %xmm1	#, tmp318, tmp319
# io_manager.h:265:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	.LC140(%rip), %xmm0, %xmm0	#, tmp314, tmp316
# io_manager.h:265:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp319, tmp316, tmp321
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
	leaq	.LC147(%rip), %rdx	#, tmp332
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# io_manager.h:266:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp397
	vcvtusi2sdq	N_e_abs_gnd(%rip), %xmm3, %xmm0	# N_e_abs_gnd, tmp397, tmp372
# io_manager.h:266:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vcvtsi2sdl	no_of_cycles(%rip), %xmm3, %xmm1	# no_of_cycles, tmp398, tmp373
# io_manager.h:266:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC116(%rip), %xmm0, %xmm0	#, tmp323, tmp324
# io_manager.h:266:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC141(%rip), %xmm1, %xmm1	#, tmp328, tmp329
# io_manager.h:266:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	.LC140(%rip), %xmm0, %xmm0	#, tmp324, tmp326
# io_manager.h:266:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp329, tmp326, tmp331
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
	movq	%rbp, %rdx	# tmp347,
	movq	%rbx, %rdi	# _91,
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	powere_xt(%rip), %rdx	#, ivtmp.1286
	leaq	poweri_xt(%rip), %rcx	#, ivtmp.1287
# io_manager.h:272:         power_i = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# power_i
	leaq	640000(%rdx), %rdi	#, _221
# io_manager.h:271:         power_e = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm1	#, power_e
	.p2align 4
	.p2align 3
.L377:
# io_manager.h:226:     if (c > 1.0) {conditions_OK = false;}
	xorl	%eax, %eax	# ivtmp.1275
	.p2align 4
	.p2align 3
.L378:
	leaq	(%rdx,%rax), %rsi	#, _220
	vaddsd	(%rsi), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_220], 64, 0>, power_e, stmp_power_e_108.1266
	vaddsd	8(%rsi), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_220], 64, 64>, stmp_power_e_108.1266, stmp_power_e_108.1266
	vaddsd	16(%rsi), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_220], 64, 128>, stmp_power_e_108.1266, stmp_power_e_108.1266
	vaddsd	24(%rsi), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_220], 64, 192>, stmp_power_e_108.1266, stmp_power_e_108.1266
	vaddsd	32(%rsi), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_220], 64, 256>, stmp_power_e_108.1266, stmp_power_e_108.1266
	vaddsd	40(%rsi), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_220], 64, 320>, stmp_power_e_108.1266, stmp_power_e_108.1266
# io_manager.h:275:                 power_e += powere_xt[i][j];
	vaddsd	48(%rsi), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_220], 64, 384>, stmp_power_e_108.1266, stmp_power_e_108.1266
	vaddsd	56(%rsi), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_220], 64, 448>, stmp_power_e_108.1266, power_e
	leaq	(%rcx,%rax), %rsi	#, _160
	addq	$64, %rax	#, ivtmp.1275
	vaddsd	(%rsi), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_160], 64, 0>, power_i, stmp_power_i_109.1270
	vaddsd	8(%rsi), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_160], 64, 64>, stmp_power_i_109.1270, stmp_power_i_109.1270
	vaddsd	16(%rsi), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_160], 64, 128>, stmp_power_i_109.1270, stmp_power_i_109.1270
	vaddsd	24(%rsi), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_160], 64, 192>, stmp_power_i_109.1270, stmp_power_i_109.1270
	vaddsd	32(%rsi), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_160], 64, 256>, stmp_power_i_109.1270, stmp_power_i_109.1270
	vaddsd	40(%rsi), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_160], 64, 320>, stmp_power_i_109.1270, stmp_power_i_109.1270
# io_manager.h:276:                 power_i += poweri_xt[i][j];
	vaddsd	48(%rsi), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_160], 64, 384>, stmp_power_i_109.1270, stmp_power_i_109.1270
	vaddsd	56(%rsi), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_160], 64, 448>, stmp_power_i_109.1270, power_i
	cmpq	$1600, %rax	#, ivtmp.1275
	jne	.L378	#,
# io_manager.h:273:         for (i=0; i<N_G; i++){
	addq	$1600, %rdx	#, ivtmp.1286
	addq	$1600, %rcx	#, ivtmp.1287
	cmpq	%rdi, %rdx	# _221, ivtmp.1286
	jne	.L377	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%rbx, %rdi	# _91,
	leaq	.LC149(%rip), %rdx	#, tmp338
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
# io_manager.h:279:         power_e /= (double)(N_XT * N_G);
	vmovsd	.LC148(%rip), %xmm2	#, tmp336
# io_manager.h:280:         power_i /= (double)(N_XT * N_G);
	vdivsd	%xmm2, %xmm0, %xmm6	# tmp336, power_i, power_i
# io_manager.h:279:         power_e /= (double)(N_XT * N_G);
	vdivsd	%xmm2, %xmm1, %xmm7	# tmp336, power_e, power_e
# io_manager.h:280:         power_i /= (double)(N_XT * N_G);
	vmovsd	%xmm6, 16(%rsp)	# power_i, %sfp
# io_manager.h:279:         power_e /= (double)(N_XT * N_G);
	vmovsd	%xmm7, 8(%rsp)	# power_e, %sfp
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
	movq	%rbx, %rdi	# _91,
	leaq	.LC150(%rip), %rdx	#, tmp339
	movl	$2, %esi	#,
	movl	$1, %eax	#,
	vmovsd	8(%rsp), %xmm0	# %sfp,
	call	__fprintf_chk@PLT	#
	movq	%rbx, %rdi	# _91,
	leaq	.LC151(%rip), %rdx	#, tmp340
	movl	$2, %esi	#,
	movl	$1, %eax	#,
	vmovsd	16(%rsp), %xmm0	# %sfp,
	call	__fprintf_chk@PLT	#
	movq	%rbx, %rdi	# _91,
	leaq	.LC152(%rip), %rdx	#, tmp342
	movl	$2, %esi	#,
	movl	$1, %eax	#,
# io_manager.h:284:         fprintf(f,"Total power density(average)          = %12.3e [W m^{-3}]\n", power_e + power_i);
	vmovsd	16(%rsp), %xmm6	# %sfp, power_i
	vaddsd	8(%rsp), %xmm6, %xmm0	# %sfp, power_i, tmp341
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
	movq	%rbx, %rdi	# _91,
	movq	%rbp, %rdx	# tmp347,
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# io_manager.h:288: }
	addq	$40, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 40
# io_manager.h:286:         fclose(f);
	movq	%rbx, %rdi	# _91,
# io_manager.h:288: }
	popq	%rbx	#
	.cfi_def_cfa_offset 32
	popq	%rbp	#
	.cfi_def_cfa_offset 24
	popq	%r12	#
	.cfi_def_cfa_offset 16
	popq	%r14	#
	.cfi_def_cfa_offset 8
# io_manager.h:286:         fclose(f);
	jmp	fclose@PLT	#
.L374:
	.cfi_restore_state
# io_manager.h:230:     c = max_ion_coll_freq() * DT_I;
	call	_Z17max_ion_coll_freqv	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	leaq	.LC131(%rip), %rdx	#, tmp346
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# io_manager.h:230:     c = max_ion_coll_freq() * DT_I;
	vmulsd	.LC70(%rip), %xmm0, %xmm0	#, tmp358, c
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
.L375:
	movq	%rbp, %rdx	# tmp347,
	movq	%rbx, %rdi	# _91,
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	movq	%rbx, %rdi	# _91,
	leaq	.LC132(%rip), %rdx	#, tmp279
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	movq	%rbp, %rdx	# tmp347,
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# io_manager.h:237:         fclose(f);
	movq	%rbx, %rdi	# _91,
	call	fclose@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC133(%rip), %rsi	#, tmp281
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# io_manager.h:288: }
	addq	$40, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 40
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC134(%rip), %rsi	#, tmp282
	movl	$2, %edi	#,
# io_manager.h:288: }
	popq	%rbx	#
	.cfi_def_cfa_offset 32
	popq	%rbp	#
	.cfi_def_cfa_offset 24
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	xorl	%eax, %eax	#
# io_manager.h:288: }
	popq	%r12	#
	.cfi_def_cfa_offset 16
	popq	%r14	#
	.cfi_def_cfa_offset 8
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	jmp	__printf_chk@PLT	#
.L385:
	.cfi_restore_state
# io_manager.h:196:     debye_length = sqrt(EPSILON0 * kT / density) / E_CHARGE;                         // e Debye length @ center
	call	sqrt@PLT	#
	jmp	.L372	#
.L384:
	vmovsd	%xmm1, 16(%rsp)	# _3, %sfp
# io_manager.h:190:     plas_freq  = E_CHARGE * sqrt(density / EPSILON0 / E_MASS);                       // e plasma frequency @ center
	call	sqrt@PLT	#
	vmovsd	16(%rsp), %xmm1	# %sfp, _3
	jmp	.L369	#
	.cfi_endproc
.LFE3911:
	.size	_Z19check_and_save_infov, .-_Z19check_and_save_infov
	.section	.text._ZN9__gnu_cxx11char_traitsIcE6lengthEPKc,"axG",@progbits,_ZN9__gnu_cxx11char_traitsIcE6lengthEPKc,comdat
	.align 2
	.p2align 4
	.weak	_ZN9__gnu_cxx11char_traitsIcE6lengthEPKc
	.type	_ZN9__gnu_cxx11char_traitsIcE6lengthEPKc, @function
_ZN9__gnu_cxx11char_traitsIcE6lengthEPKc:
.LFB3958:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/char_traits.h:199:     char_traits<_CharT>::
	movq	%rdi, %rcx	# tmp88, __p
# /usr/include/c++/13/bits/char_traits.h:202:       std::size_t __i = 0;
	xorl	%edx, %edx	# <retval>
# /usr/include/c++/13/bits/char_traits.h:203:       while (!eq(__p[__i], char_type()))
	jmp	.L388	#
	.p2align 4
	.p2align 3
.L389:
# /usr/include/c++/13/bits/char_traits.h:204:         ++__i;
	incq	%rdx	# <retval>
.L388:
# /usr/include/c++/13/bits/char_traits.h:203:       while (!eq(__p[__i], char_type()))
	movzbl	(%rcx,%rdx), %edi	# MEM[(const char_type &)__p_8(D) + __i_3 * 1], MEM[(const char_type &)__p_8(D) + __i_3 * 1]
	call	_ZN9__gnu_cxx11char_traitsIcE2eqERKcS3_.constprop.0.isra.0	#
# /usr/include/c++/13/bits/char_traits.h:203:       while (!eq(__p[__i], char_type()))
	testb	%al, %al	# tmp89
	je	.L389	#,
# /usr/include/c++/13/bits/char_traits.h:206:     }
	movq	%rdx, %rax	# <retval>,
	ret	
	.cfi_endproc
.LFE3958:
	.size	_ZN9__gnu_cxx11char_traitsIcE6lengthEPKc, .-_ZN9__gnu_cxx11char_traitsIcE6lengthEPKc
	.section	.text._ZNSt11char_traitsIcE6lengthEPKc,"axG",@progbits,_ZNSt11char_traitsIcE6lengthEPKc,comdat
	.p2align 4
	.weak	_ZNSt11char_traitsIcE6lengthEPKc
	.type	_ZNSt11char_traitsIcE6lengthEPKc, @function
_ZNSt11char_traitsIcE6lengthEPKc:
.LFB1036:
	.cfi_startproc
	endbr64	
	pushq	%rbx	#
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
# /usr/include/c++/13/bits/char_traits.h:393:       length(const char_type* __s)
	movq	%rdi, %rbx	# tmp89, __s
# /usr/include/c++/13/bits/char_traits.h:396: 	if (std::__is_constant_evaluated())
	call	_ZSt23__is_constant_evaluatedv	#
# /usr/include/c++/13/bits/char_traits.h:397: 	  return __gnu_cxx::char_traits<char_type>::length(__s);
	movq	%rbx, %rdi	# __s,
# /usr/include/c++/13/bits/char_traits.h:396: 	if (std::__is_constant_evaluated())
	testb	%al, %al	# tmp90
	je	.L391	#,
# /usr/include/c++/13/bits/char_traits.h:400:       }
	popq	%rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 8
# /usr/include/c++/13/bits/char_traits.h:397: 	  return __gnu_cxx::char_traits<char_type>::length(__s);
	jmp	_ZN9__gnu_cxx11char_traitsIcE6lengthEPKc	#
	.p2align 4
	.p2align 3
.L391:
	.cfi_restore_state
# /usr/include/c++/13/bits/char_traits.h:400:       }
	popq	%rbx	#
	.cfi_def_cfa_offset 8
# /usr/include/c++/13/bits/char_traits.h:399: 	return __builtin_strlen(__s);
	jmp	strlen@PLT	#
	.cfi_endproc
.LFE1036:
	.size	_ZNSt11char_traitsIcE6lengthEPKc, .-_ZNSt11char_traitsIcE6lengthEPKc
	.section	.text._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev,"axG",@progbits,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev
	.type	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev, @function
_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev:
.LFB4067:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/basic_string.h:181:       struct _Alloc_hider : allocator_type // TODO check __is_final
	ret	
	.cfi_endproc
.LFE4067:
	.size	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev, .-_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev
	.weak	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD1Ev
	.set	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD1Ev,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev
	.section	.rodata._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_.str1.8,"aMS",@progbits,1
	.align 8
.LC153:
	.string	"basic_string: construction from null is not valid"
	.section	.text._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_,"axG",@progbits,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC5IS3_EEPKcRKS3_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_
	.type	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_, @function
_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_:
.LFB4208:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbp	# tmp91, this
	movq	%rsi, %rbx	# tmp92, __s
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 32
# /usr/include/c++/13/bits/basic_string.h:642:       : _M_dataplus(_M_local_data(), __a)
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_local_dataEv@PLT	#
# /usr/include/c++/13/bits/basic_string.h:642:       : _M_dataplus(_M_local_data(), __a)
	movq	%rbp, %rdi	# this,
# /usr/include/c++/13/bits/basic_string.h:642:       : _M_dataplus(_M_local_data(), __a)
	movq	%rax, %rsi	# tmp93, _2
# /usr/include/c++/13/bits/basic_string.h:642:       : _M_dataplus(_M_local_data(), __a)
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderC2EPcRKS3_.isra.0	#
# /usr/include/c++/13/bits/basic_string.h:645: 	if (__s == 0)
	testq	%rbx, %rbx	# __s
	je	.L397	#,
# /usr/include/c++/13/bits/basic_string.h:648: 	const _CharT* __end = __s + traits_type::length(__s);
	movq	%rbx, %rdi	# __s,
	vzeroupper
	call	_ZNSt11char_traitsIcE6lengthEPKc	#
# /usr/include/c++/13/bits/basic_string.h:649: 	_M_construct(__s, __end, forward_iterator_tag());
	movq	%rbx, %rsi	# __s,
	movq	%rbp, %rdi	# this,
# /usr/include/c++/13/bits/basic_string.h:648: 	const _CharT* __end = __s + traits_type::length(__s);
	leaq	(%rbx,%rax), %rdx	#, __end
# /usr/include/c++/13/bits/basic_string.h:649: 	_M_construct(__s, __end, forward_iterator_tag());
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag.isra.0	#
# /usr/include/c++/13/bits/basic_string.h:650:       }
	addq	$8, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
.L397:
	.cfi_restore_state
# /usr/include/c++/13/bits/basic_string.h:646: 	  std::__throw_logic_error(__N("basic_string: "
	leaq	.LC153(%rip), %rdi	#, tmp89
	vzeroupper
	call	_ZSt19__throw_logic_errorPKc@PLT	#
	.cfi_endproc
.LFE4208:
	.size	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_, .-_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_
	.weak	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_
	.set	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_
	.section	.rodata._ZNSt13random_deviceC2Ev.str1.1,"aMS",@progbits,1
.LC154:
	.string	"default"
	.section	.text._ZNSt13random_deviceC2Ev,"axG",@progbits,_ZNSt13random_deviceC5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt13random_deviceC2Ev
	.type	_ZNSt13random_deviceC2Ev, @function
_ZNSt13random_deviceC2Ev:
.LFB2468:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA2468
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbp	# tmp95, this
# /usr/include/c++/13/bits/random.h:1658:     random_device() { _M_init("default"); }
	leaq	.LC154(%rip), %rsi	#, tmp87
# /usr/include/c++/13/bits/random.h:1658:     random_device() { _M_init("default"); }
	subq	$72, %rsp	#,
	.cfi_def_cfa_offset 96
# /usr/include/c++/13/bits/random.h:1658:     random_device() { _M_init("default"); }
	leaq	16(%rsp), %rbx	#, tmp94
	leaq	15(%rsp), %rdx	#, tmp85
	movq	%rbx, %rdi	# tmp94,
# /usr/include/c++/13/bits/random.h:1658:     random_device() { _M_init("default"); }
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp97
	movq	%rax, 56(%rsp)	# tmp97, D.83190
	xorl	%eax, %eax	# tmp97
.LEHB0:
# /usr/include/c++/13/bits/random.h:1658:     random_device() { _M_init("default"); }
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_	#
.LEHE0:
# /usr/include/c++/13/bits/random.h:1658:     random_device() { _M_init("default"); }
	movq	%rbx, %rsi	# tmp94,
	movq	%rbp, %rdi	# this,
.LEHB1:
	call	_ZNSt13random_device7_M_initERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT	#
.LEHE1:
# /usr/include/c++/13/bits/random.h:1658:     random_device() { _M_init("default"); }
	movq	%rbx, %rdi	# tmp94,
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT	#
# /usr/include/c++/13/bits/random.h:1658:     random_device() { _M_init("default"); }
	movq	56(%rsp), %rax	# D.83190, tmp98
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp98
	jne	.L403	#,
	addq	$72, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
.L399:
	.cfi_restore_state
# /usr/include/c++/13/bits/random.h:1658:     random_device() { _M_init("default"); }
	movq	%rbx, %rdi	# tmp94,
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@PLT	#
	movq	56(%rsp), %rax	# D.83190, tmp99
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp99
	je	.L400	#,
.L403:
# /usr/include/c++/13/bits/random.h:1658:     random_device() { _M_init("default"); }
	call	__stack_chk_fail@PLT	#
.L402:
	endbr64	
# /usr/include/c++/13/bits/random.h:1658:     random_device() { _M_init("default"); }
	movq	%rax, %rbp	# tmp96, tmp91
	jmp	.L399	#
.L400:
	movq	%rbp, %rdi	# tmp91,
.LEHB2:
	call	_Unwind_Resume@PLT	#
.LEHE2:
	.cfi_endproc
.LFE2468:
	.section	.gcc_except_table._ZNSt13random_deviceC2Ev,"aG",@progbits,_ZNSt13random_deviceC5Ev,comdat
.LLSDA2468:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE2468-.LLSDACSB2468
.LLSDACSB2468:
	.uleb128 .LEHB0-.LFB2468
	.uleb128 .LEHE0-.LEHB0
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB1-.LFB2468
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L402-.LFB2468
	.uleb128 0
	.uleb128 .LEHB2-.LFB2468
	.uleb128 .LEHE2-.LEHB2
	.uleb128 0
	.uleb128 0
.LLSDACSE2468:
	.section	.text._ZNSt13random_deviceC2Ev,"axG",@progbits,_ZNSt13random_deviceC5Ev,comdat
	.size	_ZNSt13random_deviceC2Ev, .-_ZNSt13random_deviceC2Ev
	.weak	_ZNSt13random_deviceC1Ev
	.set	_ZNSt13random_deviceC1Ev,_ZNSt13random_deviceC2Ev
	.section	.text._ZNSt12_Vector_baseIiSaIiEED2Ev,"axG",@progbits,_ZNSt12_Vector_baseIiSaIiEED5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt12_Vector_baseIiSaIiEED2Ev
	.type	_ZNSt12_Vector_baseIiSaIiEED2Ev, @function
_ZNSt12_Vector_baseIiSaIiEED2Ev:
.LFB4241:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	(%rdi), %rax	# this_8(D)->_M_impl.D.71053._M_start, _2
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	16(%rdi), %rsi	# this_8(D)->_M_impl.D.71053._M_end_of_storage, this_8(D)->_M_impl.D.71053._M_end_of_storage
	subq	%rax, %rsi	# _2, tmp88
# /usr/include/c++/13/bits/stl_vector.h:369: 	_M_deallocate(_M_impl._M_start,
	movq	%rax, %rdi	# _2,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	sarq	$2, %rsi	#, tmp91
# /usr/include/c++/13/bits/stl_vector.h:369: 	_M_deallocate(_M_impl._M_start,
	jmp	_ZNSt12_Vector_baseIiSaIiEE13_M_deallocateEPim.isra.0	#
	.cfi_endproc
.LFE4241:
	.size	_ZNSt12_Vector_baseIiSaIiEED2Ev, .-_ZNSt12_Vector_baseIiSaIiEED2Ev
	.weak	_ZNSt12_Vector_baseIiSaIiEED1Ev
	.set	_ZNSt12_Vector_baseIiSaIiEED1Ev,_ZNSt12_Vector_baseIiSaIiEED2Ev
	.section	.text._ZNSt6vectorIiSaIiEED2Ev,"axG",@progbits,_ZNSt6vectorIiSaIiEED5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIiSaIiEED2Ev
	.type	_ZNSt6vectorIiSaIiEED2Ev, @function
_ZNSt6vectorIiSaIiEED2Ev:
.LFB4244:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_vector.h:738:       }
	jmp	_ZNSt12_Vector_baseIiSaIiEED2Ev	#
	.cfi_endproc
.LFE4244:
	.size	_ZNSt6vectorIiSaIiEED2Ev, .-_ZNSt6vectorIiSaIiEED2Ev
	.weak	_ZNSt6vectorIiSaIiEED1Ev
	.set	_ZNSt6vectorIiSaIiEED1Ev,_ZNSt6vectorIiSaIiEED2Ev
	.section	.text._ZNSt25uniform_real_distributionIdE10param_typeC2Edd,"axG",@progbits,_ZNSt25uniform_real_distributionIdE10param_typeC5Edd,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt25uniform_real_distributionIdE10param_typeC2Edd
	.type	_ZNSt25uniform_real_distributionIdE10param_typeC2Edd, @function
_ZNSt25uniform_real_distributionIdE10param_typeC2Edd:
.LFB4411:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.h:1797: 	: _M_a(__a), _M_b(__b)
	vunpcklpd	%xmm1, %xmm0, %xmm1	# tmp89, tmp88, tmp86
	vmovupd	%xmm1, (%rdi)	# tmp86, MEM <vector(2) double> [(double *)this_3(D)]
# /usr/include/c++/13/bits/random.h:1800: 	}
	ret	
	.cfi_endproc
.LFE4411:
	.size	_ZNSt25uniform_real_distributionIdE10param_typeC2Edd, .-_ZNSt25uniform_real_distributionIdE10param_typeC2Edd
	.weak	_ZNSt25uniform_real_distributionIdE10param_typeC1Edd
	.set	_ZNSt25uniform_real_distributionIdE10param_typeC1Edd,_ZNSt25uniform_real_distributionIdE10param_typeC2Edd
	.section	.text._ZNSt25uniform_real_distributionIdEC2Edd,"axG",@progbits,_ZNSt25uniform_real_distributionIdEC5Edd,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt25uniform_real_distributionIdEC2Edd
	.type	_ZNSt25uniform_real_distributionIdEC2Edd, @function
_ZNSt25uniform_real_distributionIdEC2Edd:
.LFB4227:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.h:1841:       : _M_param(__a, __b)
	jmp	_ZNSt25uniform_real_distributionIdE10param_typeC1Edd	#
	.cfi_endproc
.LFE4227:
	.size	_ZNSt25uniform_real_distributionIdEC2Edd, .-_ZNSt25uniform_real_distributionIdEC2Edd
	.weak	_ZNSt25uniform_real_distributionIdEC1Edd
	.set	_ZNSt25uniform_real_distributionIdEC1Edd,_ZNSt25uniform_real_distributionIdEC2Edd
	.section	.text._ZNSt19normal_distributionIdE10param_typeC2Edd,"axG",@progbits,_ZNSt19normal_distributionIdE10param_typeC5Edd,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt19normal_distributionIdE10param_typeC2Edd
	.type	_ZNSt19normal_distributionIdE10param_typeC2Edd, @function
_ZNSt19normal_distributionIdE10param_typeC2Edd:
.LFB4414:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.h:2034: 	: _M_mean(__mean), _M_stddev(__stddev)
	vunpcklpd	%xmm1, %xmm0, %xmm1	# tmp89, tmp88, tmp86
	vmovupd	%xmm1, (%rdi)	# tmp86, MEM <vector(2) double> [(double *)this_3(D)]
# /usr/include/c++/13/bits/random.h:2037: 	}
	ret	
	.cfi_endproc
.LFE4414:
	.size	_ZNSt19normal_distributionIdE10param_typeC2Edd, .-_ZNSt19normal_distributionIdE10param_typeC2Edd
	.weak	_ZNSt19normal_distributionIdE10param_typeC1Edd
	.set	_ZNSt19normal_distributionIdE10param_typeC1Edd,_ZNSt19normal_distributionIdE10param_typeC2Edd
	.section	.text._ZNSt19normal_distributionIdEC2Edd,"axG",@progbits,_ZNSt19normal_distributionIdEC5Edd,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt19normal_distributionIdEC2Edd
	.type	_ZNSt19normal_distributionIdEC2Edd, @function
_ZNSt19normal_distributionIdEC2Edd:
.LFB4230:
	.cfi_startproc
	endbr64	
	pushq	%rbx	#
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
# /usr/include/c++/13/bits/random.h:2071:       normal_distribution(result_type __mean,
	movq	%rdi, %rbx	# tmp87, this
# /usr/include/c++/13/bits/random.h:2073:       : _M_param(__mean, __stddev)
	call	_ZNSt19normal_distributionIdE10param_typeC1Edd	#
# /usr/include/c++/13/bits/random.h:2073:       : _M_param(__mean, __stddev)
	movq	$0x000000000, 16(%rbx)	#, *this_3(D)._M_saved
	movb	$0, 24(%rbx)	#, *this_3(D)._M_saved_available
# /usr/include/c++/13/bits/random.h:2074:       { }
	popq	%rbx	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE4230:
	.size	_ZNSt19normal_distributionIdEC2Edd, .-_ZNSt19normal_distributionIdEC2Edd
	.weak	_ZNSt19normal_distributionIdEC1Edd
	.set	_ZNSt19normal_distributionIdEC1Edd,_ZNSt19normal_distributionIdEC2Edd
	.section	.text._ZNSt12_Vector_baseIiSaIiEE17_Vector_impl_dataC2Ev,"axG",@progbits,_ZNSt12_Vector_baseIiSaIiEE17_Vector_impl_dataC5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt12_Vector_baseIiSaIiEE17_Vector_impl_dataC2Ev
	.type	_ZNSt12_Vector_baseIiSaIiEE17_Vector_impl_dataC2Ev, @function
_ZNSt12_Vector_baseIiSaIiEE17_Vector_impl_dataC2Ev:
.LFB4422:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, (%rdi)	#, *this_2(D)._M_start
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 8(%rdi)	#, *this_2(D)._M_finish
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	movq	$0, 16(%rdi)	#, *this_2(D)._M_end_of_storage
# /usr/include/c++/13/bits/stl_vector.h:101: 	{ }
	ret	
	.cfi_endproc
.LFE4422:
	.size	_ZNSt12_Vector_baseIiSaIiEE17_Vector_impl_dataC2Ev, .-_ZNSt12_Vector_baseIiSaIiEE17_Vector_impl_dataC2Ev
	.weak	_ZNSt12_Vector_baseIiSaIiEE17_Vector_impl_dataC1Ev
	.set	_ZNSt12_Vector_baseIiSaIiEE17_Vector_impl_dataC1Ev,_ZNSt12_Vector_baseIiSaIiEE17_Vector_impl_dataC2Ev
	.section	.text._ZNSt12_Vector_baseIiSaIiEE12_Vector_implC2Ev,"axG",@progbits,_ZNSt12_Vector_baseIiSaIiEE12_Vector_implC5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt12_Vector_baseIiSaIiEE12_Vector_implC2Ev
	.type	_ZNSt12_Vector_baseIiSaIiEE12_Vector_implC2Ev, @function
_ZNSt12_Vector_baseIiSaIiEE12_Vector_implC2Ev:
.LFB4235:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_vector.h:142: 	: _Tp_alloc_type()
	jmp	_ZNSt12_Vector_baseIiSaIiEE17_Vector_impl_dataC2Ev	#
	.cfi_endproc
.LFE4235:
	.size	_ZNSt12_Vector_baseIiSaIiEE12_Vector_implC2Ev, .-_ZNSt12_Vector_baseIiSaIiEE12_Vector_implC2Ev
	.weak	_ZNSt12_Vector_baseIiSaIiEE12_Vector_implC1Ev
	.set	_ZNSt12_Vector_baseIiSaIiEE12_Vector_implC1Ev,_ZNSt12_Vector_baseIiSaIiEE12_Vector_implC2Ev
	.section	.text._ZNSt12_Vector_baseIiSaIiEEC2Ev,"axG",@progbits,_ZNSt12_Vector_baseIiSaIiEEC5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt12_Vector_baseIiSaIiEEC2Ev
	.type	_ZNSt12_Vector_baseIiSaIiEEC2Ev, @function
_ZNSt12_Vector_baseIiSaIiEEC2Ev:
.LFB3857:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_vector.h:315:       _Vector_base() = default;
	jmp	_ZNSt12_Vector_baseIiSaIiEE12_Vector_implC1Ev	#
	.cfi_endproc
.LFE3857:
	.size	_ZNSt12_Vector_baseIiSaIiEEC2Ev, .-_ZNSt12_Vector_baseIiSaIiEEC2Ev
	.weak	_ZNSt12_Vector_baseIiSaIiEEC1Ev
	.set	_ZNSt12_Vector_baseIiSaIiEEC1Ev,_ZNSt12_Vector_baseIiSaIiEEC2Ev
	.section	.text._ZNSt6vectorIiSaIiEEC2Ev,"axG",@progbits,_ZNSt6vectorIiSaIiEEC5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIiSaIiEEC2Ev
	.type	_ZNSt6vectorIiSaIiEEC2Ev, @function
_ZNSt6vectorIiSaIiEEC2Ev:
.LFB3859:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_vector.h:531:       vector() = default;
	jmp	_ZNSt12_Vector_baseIiSaIiEEC2Ev	#
	.cfi_endproc
.LFE3859:
	.size	_ZNSt6vectorIiSaIiEEC2Ev, .-_ZNSt6vectorIiSaIiEEC2Ev
	.weak	_ZNSt6vectorIiSaIiEEC1Ev
	.set	_ZNSt6vectorIiSaIiEEC1Ev,_ZNSt6vectorIiSaIiEEC2Ev
	.section	.text._ZNSt12_Vector_baseIiSaIiEE19_M_get_Tp_allocatorEv,"axG",@progbits,_ZNSt12_Vector_baseIiSaIiEE19_M_get_Tp_allocatorEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt12_Vector_baseIiSaIiEE19_M_get_Tp_allocatorEv
	.type	_ZNSt12_Vector_baseIiSaIiEE19_M_get_Tp_allocatorEv, @function
_ZNSt12_Vector_baseIiSaIiEE19_M_get_Tp_allocatorEv:
.LFB4428:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_vector.h:301:       _M_get_Tp_allocator() _GLIBCXX_NOEXCEPT
	movq	%rdi, %rax	# tmp85, this
# /usr/include/c++/13/bits/stl_vector.h:302:       { return this->_M_impl; }
	ret	
	.cfi_endproc
.LFE4428:
	.size	_ZNSt12_Vector_baseIiSaIiEE19_M_get_Tp_allocatorEv, .-_ZNSt12_Vector_baseIiSaIiEE19_M_get_Tp_allocatorEv
	.section	.text._ZNSt6vectorIiSaIiEE15_M_erase_at_endEPi,"axG",@progbits,_ZNSt6vectorIiSaIiEE15_M_erase_at_endEPi,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIiSaIiEE15_M_erase_at_endEPi
	.type	_ZNSt6vectorIiSaIiEE15_M_erase_at_endEPi, @function
_ZNSt6vectorIiSaIiEE15_M_erase_at_endEPi:
.LFB4434:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rsi, 8(%rdi)	# __pos, this_4(D)->D.71714._M_impl.D.71053._M_finish
	je	.L420	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rsi, 8(%rdi)	# __pos, this_4(D)->D.71714._M_impl.D.71053._M_finish
.L420:
# /usr/include/c++/13/bits/stl_vector.h:1942:       }
	ret	
	.cfi_endproc
.LFE4434:
	.size	_ZNSt6vectorIiSaIiEE15_M_erase_at_endEPi, .-_ZNSt6vectorIiSaIiEE15_M_erase_at_endEPi
	.section	.text._ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEC2ERKS1_,"axG",@progbits,_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEC5ERKS1_,comdat
	.align 2
	.p2align 4
	.weak	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEC2ERKS1_
	.type	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEC2ERKS1_, @function
_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEC2ERKS1_:
.LFB4436:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_iterator.h:1077:       : _M_current(__i) { }
	movq	(%rsi), %rax	# *__i_5(D), *__i_5(D)
	movq	%rax, (%rdi)	# *__i_5(D), *this_3(D)._M_current
# /usr/include/c++/13/bits/stl_iterator.h:1077:       : _M_current(__i) { }
	ret	
	.cfi_endproc
.LFE4436:
	.size	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEC2ERKS1_, .-_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEC2ERKS1_
	.weak	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEC1ERKS1_
	.set	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEC1ERKS1_,_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEC2ERKS1_
	.section	.text._ZNSt6vectorIiSaIiEE5beginEv,"axG",@progbits,_ZNSt6vectorIiSaIiEE5beginEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIiSaIiEE5beginEv
	.type	_ZNSt6vectorIiSaIiEE5beginEv, @function
_ZNSt6vectorIiSaIiEE5beginEv:
.LFB4248:
	.cfi_startproc
	endbr64	
	subq	$24, %rsp	#,
	.cfi_def_cfa_offset 32
# /usr/include/c++/13/bits/stl_vector.h:873:       begin() _GLIBCXX_NOEXCEPT
	movq	%rdi, %rsi	# tmp90, this
# /usr/include/c++/13/bits/stl_vector.h:874:       { return iterator(this->_M_impl._M_start); }
	movq	%rsp, %rdi	#, tmp87
# /usr/include/c++/13/bits/stl_vector.h:873:       begin() _GLIBCXX_NOEXCEPT
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp91
	movq	%rax, 8(%rsp)	# tmp91, D.83261
	xorl	%eax, %eax	# tmp91
# /usr/include/c++/13/bits/stl_vector.h:874:       { return iterator(this->_M_impl._M_start); }
	call	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEC1ERKS1_	#
# /usr/include/c++/13/bits/stl_vector.h:874:       { return iterator(this->_M_impl._M_start); }
	movq	(%rsp), %rax	# D.75613, D.80872
# /usr/include/c++/13/bits/stl_vector.h:874:       { return iterator(this->_M_impl._M_start); }
	movq	8(%rsp), %rdx	# D.83261, tmp92
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp92
	jne	.L425	#,
	addq	$24, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret	
.L425:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE4248:
	.size	_ZNSt6vectorIiSaIiEE5beginEv, .-_ZNSt6vectorIiSaIiEE5beginEv
	.section	.text._ZNSt6vectorIiSaIiEE3endEv,"axG",@progbits,_ZNSt6vectorIiSaIiEE3endEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIiSaIiEE3endEv
	.type	_ZNSt6vectorIiSaIiEE3endEv, @function
_ZNSt6vectorIiSaIiEE3endEv:
.LFB4259:
	.cfi_startproc
	endbr64	
	subq	$24, %rsp	#,
	.cfi_def_cfa_offset 32
# /usr/include/c++/13/bits/stl_vector.h:894:       { return iterator(this->_M_impl._M_finish); }
	leaq	8(%rdi), %rsi	#, tmp87
# /usr/include/c++/13/bits/stl_vector.h:894:       { return iterator(this->_M_impl._M_finish); }
	movq	%rsp, %rdi	#, tmp88
# /usr/include/c++/13/bits/stl_vector.h:893:       end() _GLIBCXX_NOEXCEPT
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp92
	movq	%rax, 8(%rsp)	# tmp92, D.83265
	xorl	%eax, %eax	# tmp92
# /usr/include/c++/13/bits/stl_vector.h:894:       { return iterator(this->_M_impl._M_finish); }
	call	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEC1ERKS1_	#
# /usr/include/c++/13/bits/stl_vector.h:894:       { return iterator(this->_M_impl._M_finish); }
	movq	(%rsp), %rax	# D.75711, D.80875
# /usr/include/c++/13/bits/stl_vector.h:894:       { return iterator(this->_M_impl._M_finish); }
	movq	8(%rsp), %rdx	# D.83265, tmp93
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp93
	jne	.L429	#,
	addq	$24, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret	
.L429:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE4259:
	.size	_ZNSt6vectorIiSaIiEE3endEv, .-_ZNSt6vectorIiSaIiEE3endEv
	.section	.text._ZNSt6vectorIiSaIiEE5beginEv.constprop.0,"axG",@progbits,_Z13random_sampleiiRSt6vectorIiSaIiEE,comdat
	.align 2
	.p2align 4
	.type	_ZNSt6vectorIiSaIiEE5beginEv.constprop.0, @function
_ZNSt6vectorIiSaIiEE5beginEv.constprop.0:
.LFB4757:
	.cfi_startproc
	subq	$24, %rsp	#,
	.cfi_def_cfa_offset 32
# /usr/include/c++/13/bits/stl_vector.h:874:       { return iterator(this->_M_impl._M_start); }
	leaq	_ZZ13random_sampleiiRSt6vectorIiSaIiEEE4pool(%rip), %rsi	#, tmp86
	movq	%rsp, %rdi	#, tmp85
# /usr/include/c++/13/bits/stl_vector.h:873:       begin() _GLIBCXX_NOEXCEPT
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp89
	movq	%rax, 8(%rsp)	# tmp89, D.83269
	xorl	%eax, %eax	# tmp89
# /usr/include/c++/13/bits/stl_vector.h:874:       { return iterator(this->_M_impl._M_start); }
	call	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEC1ERKS1_	#
# /usr/include/c++/13/bits/stl_vector.h:874:       { return iterator(this->_M_impl._M_start); }
	movq	(%rsp), %rax	# D.83255, D.83256
# /usr/include/c++/13/bits/stl_vector.h:874:       { return iterator(this->_M_impl._M_start); }
	movq	8(%rsp), %rdx	# D.83269, tmp90
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp90
	jne	.L433	#,
	addq	$24, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret	
.L433:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE4757:
	.size	_ZNSt6vectorIiSaIiEE5beginEv.constprop.0, .-_ZNSt6vectorIiSaIiEE5beginEv.constprop.0
	.section	.text._ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEplEl.isra.0,"axG",@progbits,_Z13random_sampleiiRSt6vectorIiSaIiEE,comdat
	.align 2
	.p2align 4
	.type	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEplEl.isra.0, @function
_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEplEl.isra.0:
.LFB4758:
	.cfi_startproc
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 48
# /usr/include/c++/13/bits/stl_iterator.h:1147:       operator+(difference_type __n) const _GLIBCXX_NOEXCEPT
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp98
	movq	%rax, 24(%rsp)	# tmp98, D.83281
	xorl	%eax, %eax	# tmp98
# /usr/include/c++/13/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	leaq	(%rdi,%rsi,4), %rax	#, tmp91
# /usr/include/c++/13/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	leaq	8(%rsp), %rsi	#, tmp92
	leaq	16(%rsp), %rdi	#, tmp93
# /usr/include/c++/13/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	movq	%rax, 8(%rsp)	# tmp91, D.83274
# /usr/include/c++/13/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	call	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEC1ERKS1_	#
# /usr/include/c++/13/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	movq	16(%rsp), %rax	# D.83275, D.83276
# /usr/include/c++/13/bits/stl_iterator.h:1148:       { return __normal_iterator(_M_current + __n); }
	movq	24(%rsp), %rdx	# D.83281, tmp99
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp99
	jne	.L437	#,
	addq	$40, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret	
.L437:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE4758:
	.size	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEplEl.isra.0, .-_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEplEl.isra.0
	.section	.text._ZSt4moveIRiEONSt16remove_referenceIT_E4typeEOS2_,"axG",@progbits,_ZSt4moveIRiEONSt16remove_referenceIT_E4typeEOS2_,comdat
	.p2align 4
	.weak	_ZSt4moveIRiEONSt16remove_referenceIT_E4typeEOS2_
	.type	_ZSt4moveIRiEONSt16remove_referenceIT_E4typeEOS2_, @function
_ZSt4moveIRiEONSt16remove_referenceIT_E4typeEOS2_:
.LFB4438:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/move.h:97:     move(_Tp&& __t) noexcept
	movq	%rdi, %rax	# tmp85, __t
# /usr/include/c++/13/bits/move.h:98:     { return static_cast<typename std::remove_reference<_Tp>::type&&>(__t); }
	ret	
	.cfi_endproc
.LFE4438:
	.size	_ZSt4moveIRiEONSt16remove_referenceIT_E4typeEOS2_, .-_ZSt4moveIRiEONSt16remove_referenceIT_E4typeEOS2_
	.section	.text._ZSt4swapIiENSt9enable_ifIXsrSt6__and_IJSt6__not_ISt15__is_tuple_likeIT_EESt21is_move_constructibleIS4_ESt18is_move_assignableIS4_EEE5valueEvE4typeERS4_SE_,"axG",@progbits,_ZSt4swapIiENSt9enable_ifIXsrSt6__and_IJSt6__not_ISt15__is_tuple_likeIT_EESt21is_move_constructibleIS4_ESt18is_move_assignableIS4_EEE5valueEvE4typeERS4_SE_,comdat
	.p2align 4
	.weak	_ZSt4swapIiENSt9enable_ifIXsrSt6__and_IJSt6__not_ISt15__is_tuple_likeIT_EESt21is_move_constructibleIS4_ESt18is_move_assignableIS4_EEE5valueEvE4typeERS4_SE_
	.type	_ZSt4swapIiENSt9enable_ifIXsrSt6__and_IJSt6__not_ISt15__is_tuple_likeIT_EESt21is_move_constructibleIS4_ESt18is_move_assignableIS4_EEE5valueEvE4typeERS4_SE_, @function
_ZSt4swapIiENSt9enable_ifIXsrSt6__and_IJSt6__not_ISt15__is_tuple_likeIT_EESt21is_move_constructibleIS4_ESt18is_move_assignableIS4_EEE5valueEvE4typeERS4_SE_:
.LFB4252:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbp	# tmp94, __a
	movq	%rsi, %rbx	# tmp95, __b
	subq	$24, %rsp	#,
	.cfi_def_cfa_offset 48
# /usr/include/c++/13/bits/move.h:189:     swap(_Tp& __a, _Tp& __b)
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp99
	movq	%rax, 8(%rsp)	# tmp99, D.83288
	xorl	%eax, %eax	# tmp99
# /usr/include/c++/13/bits/move.h:197:       _Tp __tmp = _GLIBCXX_MOVE(__a);
	call	_ZSt4moveIRiEONSt16remove_referenceIT_E4typeEOS2_	#
# /usr/include/c++/13/bits/move.h:198:       __a = _GLIBCXX_MOVE(__b);
	movq	%rbx, %rdi	# __b,
# /usr/include/c++/13/bits/move.h:197:       _Tp __tmp = _GLIBCXX_MOVE(__a);
	movl	(%rax), %eax	# *_1, *_1
	movl	%eax, 4(%rsp)	# *_1, __tmp
# /usr/include/c++/13/bits/move.h:198:       __a = _GLIBCXX_MOVE(__b);
	call	_ZSt4moveIRiEONSt16remove_referenceIT_E4typeEOS2_	#
# /usr/include/c++/13/bits/move.h:199:       __b = _GLIBCXX_MOVE(__tmp);
	leaq	4(%rsp), %rdi	#, tmp92
# /usr/include/c++/13/bits/move.h:198:       __a = _GLIBCXX_MOVE(__b);
	movl	(%rax), %eax	# *_3, _4
	movl	%eax, 0(%rbp)	# _4, *__a_8(D)
# /usr/include/c++/13/bits/move.h:199:       __b = _GLIBCXX_MOVE(__tmp);
	call	_ZSt4moveIRiEONSt16remove_referenceIT_E4typeEOS2_	#
# /usr/include/c++/13/bits/move.h:199:       __b = _GLIBCXX_MOVE(__tmp);
	movl	(%rax), %eax	# *_5, _6
	movl	%eax, (%rbx)	# _6, *__b_10(D)
# /usr/include/c++/13/bits/move.h:200:     }
	movq	8(%rsp), %rax	# D.83288, tmp100
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp100
	jne	.L443	#,
	addq	$24, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
.L443:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE4252:
	.size	_ZSt4swapIiENSt9enable_ifIXsrSt6__and_IJSt6__not_ISt15__is_tuple_likeIT_EESt21is_move_constructibleIS4_ESt18is_move_assignableIS4_EEE5valueEvE4typeERS4_SE_, .-_ZSt4swapIiENSt9enable_ifIXsrSt6__and_IJSt6__not_ISt15__is_tuple_likeIT_EESt21is_move_constructibleIS4_ESt18is_move_assignableIS4_EEE5valueEvE4typeERS4_SE_
	.section	.text._ZNSt19normal_distributionIdEC2Ev,"axG",@progbits,_ZNSt19normal_distributionIdEC5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt19normal_distributionIdEC2Ev
	.type	_ZNSt19normal_distributionIdEC2Ev, @function
_ZNSt19normal_distributionIdEC2Ev:
.LFB4446:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.h:2064:       normal_distribution() : normal_distribution(0.0) { }
	vmovsd	.LC12(%rip), %xmm1	#,
	vxorpd	%xmm0, %xmm0, %xmm0	#
	jmp	_ZNSt19normal_distributionIdEC1Edd	#
	.cfi_endproc
.LFE4446:
	.size	_ZNSt19normal_distributionIdEC2Ev, .-_ZNSt19normal_distributionIdEC2Ev
	.weak	_ZNSt19normal_distributionIdEC1Ev
	.set	_ZNSt19normal_distributionIdEC1Ev,_ZNSt19normal_distributionIdEC2Ev
	.section	.text._ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEE4baseEv,"axG",@progbits,_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEE4baseEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEE4baseEv
	.type	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEE4baseEv, @function
_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEE4baseEv:
.LFB4449:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_iterator.h:1162:       base() const _GLIBCXX_NOEXCEPT
	movq	%rdi, %rax	# tmp85, this
# /usr/include/c++/13/bits/stl_iterator.h:1163:       { return _M_current; }
	ret	
	.cfi_endproc
.LFE4449:
	.size	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEE4baseEv, .-_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEE4baseEv
	.section	.text._ZN9__gnu_cxxneIPiSt6vectorIiSaIiEEEEbRKNS_17__normal_iteratorIT_T0_EESA_,"axG",@progbits,_ZN9__gnu_cxxneIPiSt6vectorIiSaIiEEEEbRKNS_17__normal_iteratorIT_T0_EESA_,comdat
	.p2align 4
	.weak	_ZN9__gnu_cxxneIPiSt6vectorIiSaIiEEEEbRKNS_17__normal_iteratorIT_T0_EESA_
	.type	_ZN9__gnu_cxxneIPiSt6vectorIiSaIiEEEEbRKNS_17__normal_iteratorIT_T0_EESA_, @function
_ZN9__gnu_cxxneIPiSt6vectorIiSaIiEEEEbRKNS_17__normal_iteratorIT_T0_EESA_:
.LFB4260:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx	# tmp92, __rhs
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 32
# /usr/include/c++/13/bits/stl_iterator.h:1244:     { return __lhs.base() != __rhs.base(); }
	call	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEE4baseEv	#
# /usr/include/c++/13/bits/stl_iterator.h:1244:     { return __lhs.base() != __rhs.base(); }
	movq	%rbx, %rdi	# __rhs,
# /usr/include/c++/13/bits/stl_iterator.h:1244:     { return __lhs.base() != __rhs.base(); }
	movq	(%rax), %rbp	# *_1, _2
# /usr/include/c++/13/bits/stl_iterator.h:1244:     { return __lhs.base() != __rhs.base(); }
	call	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEE4baseEv	#
# /usr/include/c++/13/bits/stl_iterator.h:1244:     { return __lhs.base() != __rhs.base(); }
	cmpq	%rbp, (%rax)	# _2, *_3
	setne	%al	#, tmp90
# /usr/include/c++/13/bits/stl_iterator.h:1244:     { return __lhs.base() != __rhs.base(); }
	addq	$8, %rsp	#,
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE4260:
	.size	_ZN9__gnu_cxxneIPiSt6vectorIiSaIiEEEEbRKNS_17__normal_iteratorIT_T0_EESA_, .-_ZN9__gnu_cxxneIPiSt6vectorIiSaIiEEEEbRKNS_17__normal_iteratorIT_T0_EESA_
	.section	.text._ZSt4iotaIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiEvT_S7_T0_,"axG",@progbits,_ZSt4iotaIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiEvT_S7_T0_,comdat
	.p2align 4
	.weak	_ZSt4iotaIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiEvT_S7_T0_
	.type	_ZSt4iotaIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiEvT_S7_T0_, @function
_ZSt4iotaIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiEvT_S7_T0_:
.LFB4250:
	.cfi_startproc
	endbr64	
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movl	%edx, %ebx	# tmp92, __value
	subq	$16, %rsp	#,
	.cfi_def_cfa_offset 48
	movq	%rsp, %r12	#, tmp91
	leaq	8(%rsp), %rbp	#, tmp90
# /usr/include/c++/13/bits/stl_numeric.h:88:     iota(_ForwardIterator __first, _ForwardIterator __last, _Tp __value)
	movq	%rdi, 8(%rsp)	# __first, __first
	movq	%rsi, (%rsp)	# __last, __last
# /usr/include/c++/13/bits/stl_numeric.h:97:       for (; __first != __last; ++__first)
	jmp	.L449	#
	.p2align 4
	.p2align 3
.L450:
# /usr/include/c++/13/bits/stl_numeric.h:99: 	  *__first = __value;
	movq	8(%rsp), %rdi	# MEM[(int * *)&__first],
	call	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEdeEv.isra.0	#
# /usr/include/c++/13/bits/stl_numeric.h:97:       for (; __first != __last; ++__first)
	movq	%rbp, %rdi	# tmp90,
# /usr/include/c++/13/bits/stl_numeric.h:99: 	  *__first = __value;
	movl	%ebx, (%rax)	# __value, *_1
# /usr/include/c++/13/bits/stl_numeric.h:100: 	  ++__value;
	incl	%ebx	# __value
# /usr/include/c++/13/bits/stl_numeric.h:97:       for (; __first != __last; ++__first)
	call	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEppEv.isra.0	#
.L449:
# /usr/include/c++/13/bits/stl_numeric.h:97:       for (; __first != __last; ++__first)
	movq	%r12, %rsi	# tmp91,
	movq	%rbp, %rdi	# tmp90,
	call	_ZN9__gnu_cxxneIPiSt6vectorIiSaIiEEEEbRKNS_17__normal_iteratorIT_T0_EESA_	#
	testb	%al, %al	# tmp94
	jne	.L450	#,
# /usr/include/c++/13/bits/stl_numeric.h:102:     }
	addq	$16, %rsp	#,
	.cfi_def_cfa_offset 32
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE4250:
	.size	_ZSt4iotaIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiEvT_S7_T0_, .-_ZSt4iotaIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiEvT_S7_T0_
	.section	.text._ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEC2ERS2_,"axG",@progbits,_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEC5ERS2_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEC2ERS2_
	.type	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEC2ERS2_, @function
_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEC2ERS2_:
.LFB4544:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.h:174: 	: _M_g(__g) { }
	movq	%rsi, (%rdi)	# tmp85, *this_2(D)._M_g
# /usr/include/c++/13/bits/random.h:174: 	: _M_g(__g) { }
	ret	
	.cfi_endproc
.LFE4544:
	.size	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEC2ERS2_, .-_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEC2ERS2_
	.weak	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEC1ERS2_
	.set	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEC1ERS2_,_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEC2ERS2_
	.section	.text._ZSt3maxIdERKT_S2_S2_,"axG",@progbits,_ZSt3maxIdERKT_S2_S2_,comdat
	.p2align 4
	.weak	_ZSt3maxIdERKT_S2_S2_
	.type	_ZSt3maxIdERKT_S2_S2_, @function
_ZSt3maxIdERKT_S2_S2_:
.LFB4569:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_algobase.h:264:       return __a;
	movq	%rdi, %rax	# __a, __a
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vmovsd	(%rsi), %xmm0	# *__b_6(D), *__b_6(D)
# /usr/include/c++/13/bits/stl_algobase.h:264:       return __a;
	vcomisd	(%rdi), %xmm0	# *__a_5(D), *__b_6(D)
	cmova	%rsi, %rax	# __b,, __a
# /usr/include/c++/13/bits/stl_algobase.h:265:     }
	ret	
	.cfi_endproc
.LFE4569:
	.size	_ZSt3maxIdERKT_S2_S2_, .-_ZSt3maxIdERKT_S2_S2_
	.section	.text._ZNSt21binomial_distributionIiE10param_type13_M_initializeEv,"axG",@progbits,_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv
	.type	_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv, @function
_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv:
.LFB4568:
	.cfi_startproc
	endbr64	
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx	# tmp254, this
	subq	$112, %rsp	#,
	.cfi_def_cfa_offset 144
# /usr/include/c++/13/bits/random.tcc:1481:       const double __p12 = _M_p <= 0.5 ? _M_p : 1.0 - _M_p;
	vmovsd	8(%rdi), %xmm5	# this_84(D)->_M_p, _1
# /usr/include/c++/13/bits/random.tcc:1481:       const double __p12 = _M_p <= 0.5 ? _M_p : 1.0 - _M_p;
	vmovsd	.LC46(%rip), %xmm0	#, tmp171
# /usr/include/c++/13/bits/random.tcc:1478:     binomial_distribution<_IntType>::param_type::
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp278
	movq	%rax, 104(%rsp)	# tmp278, D.83333
	xorl	%eax, %eax	# tmp278
# /usr/include/c++/13/bits/random.tcc:1481:       const double __p12 = _M_p <= 0.5 ? _M_p : 1.0 - _M_p;
	vcomisd	%xmm5, %xmm0	# _1, tmp171
	jnb	.L457	#,
# /usr/include/c++/13/bits/random.tcc:1481:       const double __p12 = _M_p <= 0.5 ? _M_p : 1.0 - _M_p;
	vmovsd	.LC12(%rip), %xmm3	#, tmp281
	vsubsd	%xmm5, %xmm3, %xmm5	# _1, tmp281, _1
.L457:
# /usr/include/c++/13/bits/random.tcc:1486:       if (_M_t * __p12 >= 8)
	movl	(%rbx), %ebp	# this_84(D)->_M_t, _2
# /usr/include/c++/13/bits/random.tcc:1486:       if (_M_t * __p12 >= 8)
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp282
# /usr/include/c++/13/bits/random.tcc:1483:       _M_easy = true;
	movb	$1, 104(%rbx)	#, this_84(D)->_M_easy
# /usr/include/c++/13/bits/random.tcc:1486:       if (_M_t * __p12 >= 8)
	vcvtsi2sdl	%ebp, %xmm4, %xmm0	# _2, tmp282, tmp275
	vmovsd	%xmm0, %xmm0, %xmm7	# tmp275, _3
	vmovsd	%xmm0, 40(%rsp)	# _3, %sfp
	vmulsd	%xmm0, %xmm5, %xmm0	# _3, _1, _4
# /usr/include/c++/13/bits/random.tcc:1486:       if (_M_t * __p12 >= 8)
	vcomisd	.LC155(%rip), %xmm0	#, _4
	jb	.L476	#,
# /usr/include/c++/13/bits/random.tcc:1489: 	  const double __np = std::floor(_M_t * __p12);
	vrndscalesd	$9, %xmm0, %xmm0, %xmm3	#, _4, __np
	vmovsd	%xmm5, (%rsp)	# _1, %sfp
# /usr/include/c++/13/bits/random.tcc:1490: 	  const double __pa = __np / _M_t;
	vdivsd	%xmm7, %xmm3, %xmm2	# _3, __np, __pa
# /usr/include/c++/13/bits/random.tcc:1491: 	  const double __1p = 1 - __pa;
	vmovsd	.LC12(%rip), %xmm5	#, tmp289
# /usr/include/c++/13/bits/random.tcc:1495: 	    std::sqrt(__np * __1p * std::log(32 * __np
	vmulsd	.LC156(%rip), %xmm3, %xmm0	#, __np, tmp175
# /usr/include/c++/13/bits/random.tcc:1491: 	  const double __1p = 1 - __pa;
	vsubsd	%xmm2, %xmm5, %xmm4	# __pa, tmp289, __1p
# /usr/include/c++/13/bits/random.tcc:1488: 	  _M_easy = false;
	movb	$0, 104(%rbx)	#, this_84(D)->_M_easy
# /usr/include/c++/13/bits/random.tcc:1496: 					     / (81 * __pi_4 * __1p)));
	vmulsd	.LC157(%rip), %xmm4, %xmm1	#, __1p, tmp177
# /usr/include/c++/13/bits/random.tcc:1495: 	    std::sqrt(__np * __1p * std::log(32 * __np
	vmulsd	%xmm3, %xmm4, %xmm7	# __np, __1p, _5
# /usr/include/c++/13/bits/random.tcc:1495: 	    std::sqrt(__np * __1p * std::log(32 * __np
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp177, tmp175, tmp179
# /usr/include/c++/13/bits/random.tcc:1489: 	  const double __np = std::floor(_M_t * __p12);
	vmovsd	%xmm3, 8(%rsp)	# __np, %sfp
# /usr/include/c++/13/bits/random.tcc:1490: 	  const double __pa = __np / _M_t;
	vmovsd	%xmm2, 32(%rsp)	# __pa, %sfp
# /usr/include/c++/13/bits/random.tcc:1491: 	  const double __1p = 1 - __pa;
	vmovsd	%xmm4, 16(%rsp)	# __1p, %sfp
# /usr/include/c++/13/bits/random.tcc:1495: 	    std::sqrt(__np * __1p * std::log(32 * __np
	vmovsd	%xmm7, 24(%rsp)	# _5, %sfp
# /usr/include/c++/13/bits/random.tcc:1495: 	    std::sqrt(__np * __1p * std::log(32 * __np
	call	log@PLT	#
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp180
# /usr/include/c++/13/bits/random.tcc:1495: 	    std::sqrt(__np * __1p * std::log(32 * __np
	vmulsd	24(%rsp), %xmm0, %xmm0	# %sfp, tmp255, _10
	vmovsd	(%rsp), %xmm5	# %sfp, _1
	vucomisd	%xmm0, %xmm1	# _10, tmp180
	ja	.L477	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _10, _11
.L462:
# /usr/include/c++/13/bits/random.tcc:1497: 	  _M_d1 = std::round(std::max<double>(1.0, __d1x));
	movq	.LC12(%rip), %rax	#, tmp297
# /usr/include/c++/13/bits/random.tcc:1497: 	  _M_d1 = std::round(std::max<double>(1.0, __d1x));
	leaq	96(%rsp), %r12	#, tmp253
	leaq	80(%rsp), %rsi	#, tmp182
	vmovsd	%xmm5, 48(%rsp)	# _1, %sfp
	movq	%r12, %rdi	# tmp253,
# /usr/include/c++/13/bits/random.tcc:1494: 	  const double __d1x =
	vmovsd	%xmm0, 80(%rsp)	# _11, __d1x
# /usr/include/c++/13/bits/random.tcc:1499: 	    std::sqrt(__np * __1p * std::log(32 * _M_t * __1p
	sall	$5, %ebp	#, tmp185
# /usr/include/c++/13/bits/random.tcc:1497: 	  _M_d1 = std::round(std::max<double>(1.0, __d1x));
	movq	%rax, 96(%rsp)	# tmp297, MEM[(double *)_61]
# /usr/include/c++/13/bits/random.tcc:1497: 	  _M_d1 = std::round(std::max<double>(1.0, __d1x));
	call	_ZSt3maxIdERKT_S2_S2_	#
# /usr/include/c++/13/bits/random.tcc:1497: 	  _M_d1 = std::round(std::max<double>(1.0, __d1x));
	vmovsd	(%rax), %xmm0	# *_12, *_12
	call	round@PLT	#
# /usr/include/c++/13/bits/random.tcc:1499: 	    std::sqrt(__np * __1p * std::log(32 * _M_t * __1p
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp299
# /usr/include/c++/13/bits/random.tcc:1497: 	  _M_d1 = std::round(std::max<double>(1.0, __d1x));
	vmovsd	%xmm0, (%rsp)	# _14, %sfp
# /usr/include/c++/13/bits/random.tcc:1497: 	  _M_d1 = std::round(std::max<double>(1.0, __d1x));
	vmovsd	%xmm0, 24(%rbx)	# _14, this_84(D)->_M_d1
# /usr/include/c++/13/bits/random.tcc:1499: 	    std::sqrt(__np * __1p * std::log(32 * _M_t * __1p
	vcvtsi2sdl	%ebp, %xmm5, %xmm0	# tmp185, tmp299, tmp276
# /usr/include/c++/13/bits/random.tcc:1500: 					     / (__pi_4 * __pa)));
	vmovsd	32(%rsp), %xmm5	# %sfp, __pa
# /usr/include/c++/13/bits/random.tcc:1499: 	    std::sqrt(__np * __1p * std::log(32 * _M_t * __1p
	vmulsd	16(%rsp), %xmm0, %xmm0	# %sfp, tmp186, tmp187
# /usr/include/c++/13/bits/random.tcc:1500: 					     / (__pi_4 * __pa)));
	vmulsd	.LC158(%rip), %xmm5, %xmm1	#, __pa, tmp188
# /usr/include/c++/13/bits/random.tcc:1499: 	    std::sqrt(__np * __1p * std::log(32 * _M_t * __1p
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp188, tmp187, tmp190
	call	log@PLT	#
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp191
# /usr/include/c++/13/bits/random.tcc:1499: 	    std::sqrt(__np * __1p * std::log(32 * _M_t * __1p
	vmulsd	24(%rsp), %xmm0, %xmm0	# %sfp, tmp259, _21
	vmovsd	48(%rsp), %xmm5	# %sfp, _1
	vucomisd	%xmm0, %xmm1	# _21, tmp191
	ja	.L478	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _21, _22
.L465:
# /usr/include/c++/13/bits/random.tcc:1501: 	  _M_d2 = std::round(std::max<double>(1.0, __d2x));
	movq	.LC12(%rip), %rax	#, tmp303
# /usr/include/c++/13/bits/random.tcc:1501: 	  _M_d2 = std::round(std::max<double>(1.0, __d2x));
	leaq	88(%rsp), %rsi	#, tmp193
	movq	%r12, %rdi	# tmp253,
	vmovsd	%xmm5, 48(%rsp)	# _1, %sfp
# /usr/include/c++/13/bits/random.tcc:1498: 	  const double __d2x =
	vmovsd	%xmm0, 88(%rsp)	# _22, __d2x
# /usr/include/c++/13/bits/random.tcc:1501: 	  _M_d2 = std::round(std::max<double>(1.0, __d2x));
	movq	%rax, 96(%rsp)	# tmp303, MEM[(double *)_61]
# /usr/include/c++/13/bits/random.tcc:1501: 	  _M_d2 = std::round(std::max<double>(1.0, __d2x));
	call	_ZSt3maxIdERKT_S2_S2_	#
# /usr/include/c++/13/bits/random.tcc:1501: 	  _M_d2 = std::round(std::max<double>(1.0, __d2x));
	vmovsd	(%rax), %xmm0	# *_23, *_23
	call	round@PLT	#
	vmovsd	24(%rsp), %xmm7	# %sfp, _5
	vmovsd	48(%rsp), %xmm5	# %sfp, _1
	vmovsd	%xmm0, %xmm0, %xmm6	# tmp262, _25
# /usr/include/c++/13/bits/random.tcc:1501: 	  _M_d2 = std::round(std::max<double>(1.0, __d2x));
	vmovsd	%xmm0, 32(%rbx)	# _25, this_84(D)->_M_d2
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp196
	vucomisd	%xmm7, %xmm0	# _5, tmp196
	ja	.L479	#,
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vsqrtsd	%xmm7, %xmm7, %xmm0	# _5, _129
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmovsd	(%rsp), %xmm2	# %sfp, _14
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmovsd	.LC159(%rip), %xmm1	#, tmp251
	vmovsd	%xmm2, %xmm2, %xmm7	# _14, _14
	vmulsd	8(%rsp), %xmm1, %xmm4	# %sfp, tmp251, tmp197
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vdivsd	%xmm4, %xmm2, %xmm4	# tmp197, _14, tmp199
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vaddsd	.LC12(%rip), %xmm4, %xmm4	#, tmp199, tmp200
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmulsd	%xmm0, %xmm4, %xmm4	# _129, tmp200, _151
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmovsd	%xmm4, 40(%rbx)	# _151, this_84(D)->_M_s1
.L468:
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vmovsd	40(%rsp), %xmm3	# %sfp, _3
	vmulsd	16(%rsp), %xmm3, %xmm3	# %sfp, _3, _32
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vmulsd	%xmm1, %xmm3, %xmm1	# tmp251, _32, tmp207
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vdivsd	%xmm1, %xmm6, %xmm1	# tmp207, _25, tmp209
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vaddsd	.LC12(%rip), %xmm1, %xmm1	#, tmp209, tmp210
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vmulsd	%xmm0, %xmm1, %xmm1	# _129, tmp210, _36
# /usr/include/c++/13/bits/random.tcc:1507: 	  _M_c = 2 * _M_d1 / __np;
	vaddsd	%xmm7, %xmm7, %xmm0	#, _14, tmp212
# /usr/include/c++/13/bits/random.tcc:1507: 	  _M_c = 2 * _M_d1 / __np;
	vdivsd	8(%rsp), %xmm0, %xmm0	# %sfp, tmp212, _38
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vunpcklpd	%xmm0, %xmm1, %xmm2	# _38, _36, tmp213
	vmovsd	%xmm5, 72(%rsp)	# _1, %sfp
	vmovsd	%xmm4, 56(%rsp)	# _151, %sfp
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vmovsd	%xmm3, 48(%rsp)	# _32, %sfp
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vmovupd	%xmm2, 48(%rbx)	# tmp213, MEM <vector(2) double> [(double *)this_84(D) + 48B]
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vmovsd	%xmm6, 64(%rsp)	# _25, %sfp
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vmovsd	%xmm1, 24(%rsp)	# _36, %sfp
# /usr/include/c++/13/bits/random.tcc:1508: 	  _M_a1 = std::exp(_M_c) * _M_s1 * __spi_2;
	call	exp@PLT	#
# /usr/include/c++/13/bits/random.tcc:1509: 	  const double __a12 = _M_a1 + _M_s2 * __spi_2;
	vmovsd	24(%rsp), %xmm1	# %sfp, _36
# /usr/include/c++/13/bits/random.tcc:1508: 	  _M_a1 = std::exp(_M_c) * _M_s1 * __spi_2;
	vmovsd	56(%rsp), %xmm4	# %sfp, _151
# /usr/include/c++/13/bits/random.tcc:1508: 	  _M_a1 = std::exp(_M_c) * _M_s1 * __spi_2;
	vmovsd	.LC160(%rip), %xmm2	#, tmp215
# /usr/include/c++/13/bits/random.tcc:1508: 	  _M_a1 = std::exp(_M_c) * _M_s1 * __spi_2;
	vmulsd	%xmm4, %xmm0, %xmm0	# _151, tmp265, tmp214
# /usr/include/c++/13/bits/random.tcc:1508: 	  _M_a1 = std::exp(_M_c) * _M_s1 * __spi_2;
	vmulsd	%xmm2, %xmm0, %xmm0	# tmp215, tmp214, _41
# /usr/include/c++/13/bits/random.tcc:1509: 	  const double __a12 = _M_a1 + _M_s2 * __spi_2;
	vfmadd132sd	%xmm1, %xmm0, %xmm2	# _36, _41, tmp215
# /usr/include/c++/13/bits/random.tcc:1510: 	  const double __s1s = _M_s1 * _M_s1;
	vmulsd	%xmm4, %xmm4, %xmm4	# _151, _151, __s1s
# /usr/include/c++/13/bits/random.tcc:1509: 	  const double __a12 = _M_a1 + _M_s2 * __spi_2;
	vmovsd	%xmm1, 56(%rsp)	# _36, %sfp
# /usr/include/c++/13/bits/random.tcc:1510: 	  const double __s1s = _M_s1 * _M_s1;
	vmovsd	%xmm4, 24(%rsp)	# __s1s, %sfp
# /usr/include/c++/13/bits/random.tcc:1511: 	  _M_a123 = __a12 + (std::exp(_M_d1 / (_M_t * __1p))
	vmovsd	(%rsp), %xmm6	# %sfp, _14
	vmovsd	48(%rsp), %xmm3	# %sfp, _32
# /usr/include/c++/13/bits/random.tcc:1508: 	  _M_a1 = std::exp(_M_c) * _M_s1 * __spi_2;
	vmovsd	%xmm0, 64(%rbx)	# _41, this_84(D)->_M_a1
# /usr/include/c++/13/bits/random.tcc:1511: 	  _M_a123 = __a12 + (std::exp(_M_d1 / (_M_t * __1p))
	vdivsd	%xmm3, %xmm6, %xmm0	# _32, _14, tmp217
# /usr/include/c++/13/bits/random.tcc:1509: 	  const double __a12 = _M_a1 + _M_s2 * __spi_2;
	vmovsd	%xmm2, 40(%rsp)	# tmp215, %sfp
# /usr/include/c++/13/bits/random.tcc:1511: 	  _M_a123 = __a12 + (std::exp(_M_d1 / (_M_t * __1p))
	call	exp@PLT	#
# /usr/include/c++/13/bits/random.tcc:1513: 			     * std::exp(-_M_d1 * _M_d1 / (2 * __s1s)));
	vmovsd	(%rsp), %xmm6	# %sfp, _14
# /usr/include/c++/13/bits/random.tcc:1513: 			     * std::exp(-_M_d1 * _M_d1 / (2 * __s1s)));
	vmovsd	24(%rsp), %xmm5	# %sfp, __s1s
# /usr/include/c++/13/bits/random.tcc:1511: 	  _M_a123 = __a12 + (std::exp(_M_d1 / (_M_t * __1p))
	vmovsd	%xmm0, 48(%rsp)	# _44, %sfp
# /usr/include/c++/13/bits/random.tcc:1513: 			     * std::exp(-_M_d1 * _M_d1 / (2 * __s1s)));
	vxorpd	.LC32(%rip), %xmm6, %xmm0	#, _14, tmp218
# /usr/include/c++/13/bits/random.tcc:1513: 			     * std::exp(-_M_d1 * _M_d1 / (2 * __s1s)));
	vaddsd	%xmm5, %xmm5, %xmm3	#, __s1s, tmp221
# /usr/include/c++/13/bits/random.tcc:1513: 			     * std::exp(-_M_d1 * _M_d1 / (2 * __s1s)));
	vmulsd	%xmm6, %xmm0, %xmm0	# _14, tmp218, tmp220
# /usr/include/c++/13/bits/random.tcc:1513: 			     * std::exp(-_M_d1 * _M_d1 / (2 * __s1s)));
	vdivsd	%xmm3, %xmm0, %xmm0	# tmp221, tmp220, tmp222
	call	exp@PLT	#
# /usr/include/c++/13/bits/random.tcc:1516: 		  * std::exp(-_M_d2 * _M_d2 / (2 * __s2s)));
	vmovsd	64(%rsp), %xmm6	# %sfp, _25
# /usr/include/c++/13/bits/random.tcc:1512: 			     * 2 * __s1s / _M_d1
	vmovsd	48(%rsp), %xmm2	# %sfp, _44
	vaddsd	%xmm2, %xmm2, %xmm2	# _44, _44, tmp223
# /usr/include/c++/13/bits/random.tcc:1512: 			     * 2 * __s1s / _M_d1
	vmulsd	24(%rsp), %xmm2, %xmm2	# %sfp, tmp223, tmp224
# /usr/include/c++/13/bits/random.tcc:1512: 			     * 2 * __s1s / _M_d1
	vdivsd	(%rsp), %xmm2, %xmm2	# %sfp, tmp224, tmp225
# /usr/include/c++/13/bits/random.tcc:1511: 	  _M_a123 = __a12 + (std::exp(_M_d1 / (_M_t * __1p))
	vfmadd213sd	40(%rsp), %xmm0, %xmm2	# %sfp, tmp267, _54
# /usr/include/c++/13/bits/random.tcc:1516: 		  * std::exp(-_M_d2 * _M_d2 / (2 * __s2s)));
	vxorpd	.LC32(%rip), %xmm6, %xmm0	#, _25, tmp227
# /usr/include/c++/13/bits/random.tcc:1511: 	  _M_a123 = __a12 + (std::exp(_M_d1 / (_M_t * __1p))
	vmovsd	%xmm2, 72(%rbx)	# _54, this_84(D)->_M_a123
	vmovsd	%xmm2, 40(%rsp)	# _54, %sfp
# /usr/include/c++/13/bits/random.tcc:1514: 	  const double __s2s = _M_s2 * _M_s2;
	vmovsd	56(%rsp), %xmm1	# %sfp, _36
# /usr/include/c++/13/bits/random.tcc:1516: 		  * std::exp(-_M_d2 * _M_d2 / (2 * __s2s)));
	vmovsd	%xmm6, 24(%rsp)	# _25, %sfp
# /usr/include/c++/13/bits/random.tcc:1514: 	  const double __s2s = _M_s2 * _M_s2;
	vmulsd	%xmm1, %xmm1, %xmm1	# _36, _36, __s2s
# /usr/include/c++/13/bits/random.tcc:1515: 	  _M_s = (_M_a123 + 2 * __s2s / _M_d2
	vaddsd	%xmm1, %xmm1, %xmm1	# __s2s, __s2s, _55
# /usr/include/c++/13/bits/random.tcc:1516: 		  * std::exp(-_M_d2 * _M_d2 / (2 * __s2s)));
	vmovsd	%xmm1, (%rsp)	# _55, %sfp
# /usr/include/c++/13/bits/random.tcc:1516: 		  * std::exp(-_M_d2 * _M_d2 / (2 * __s2s)));
	vmulsd	%xmm6, %xmm0, %xmm0	# _25, tmp227, tmp229
# /usr/include/c++/13/bits/random.tcc:1516: 		  * std::exp(-_M_d2 * _M_d2 / (2 * __s2s)));
	vdivsd	%xmm1, %xmm0, %xmm0	# _55, tmp229, tmp230
	call	exp@PLT	#
# /usr/include/c++/13/bits/random.tcc:1515: 	  _M_s = (_M_a123 + 2 * __s2s / _M_d2
	vmovsd	24(%rsp), %xmm6	# %sfp, _25
# /usr/include/c++/13/bits/random.tcc:1515: 	  _M_s = (_M_a123 + 2 * __s2s / _M_d2
	vmovsd	40(%rsp), %xmm2	# %sfp, _54
# /usr/include/c++/13/bits/random.tcc:1515: 	  _M_s = (_M_a123 + 2 * __s2s / _M_d2
	vmovsd	(%rsp), %xmm1	# %sfp, _55
	vdivsd	%xmm6, %xmm1, %xmm1	# _25, _55, tmp231
# /usr/include/c++/13/bits/random.tcc:1515: 	  _M_s = (_M_a123 + 2 * __s2s / _M_d2
	vfmadd132sd	%xmm0, %xmm2, %xmm1	# tmp268, _54, _62
# /usr/include/c++/13/bits/random.tcc:1517: 	  _M_lf = (std::lgamma(__np + 1)
	vmovsd	.LC12(%rip), %xmm6	#, tmp322
	vaddsd	8(%rsp), %xmm6, %xmm0	# %sfp, tmp322, tmp232
# /usr/include/c++/13/bits/random.tcc:1515: 	  _M_s = (_M_a123 + 2 * __s2s / _M_d2
	vmovsd	%xmm1, 80(%rbx)	# _62, this_84(D)->_M_s
# /usr/include/c++/13/bits/random.tcc:1517: 	  _M_lf = (std::lgamma(__np + 1)
	call	lgamma@PLT	#
# /usr/include/c++/13/bits/random.tcc:1518: 		   + std::lgamma(_M_t - __np + 1));
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp324
# /usr/include/c++/13/bits/random.tcc:1517: 	  _M_lf = (std::lgamma(__np + 1)
	vmovsd	%xmm0, (%rsp)	# tmp269, %sfp
# /usr/include/c++/13/bits/random.tcc:1518: 		   + std::lgamma(_M_t - __np + 1));
	vcvtsi2sdl	(%rbx), %xmm2, %xmm0	# this_84(D)->_M_t, tmp324, tmp277
	vsubsd	8(%rsp), %xmm0, %xmm0	# %sfp, tmp234, tmp235
# /usr/include/c++/13/bits/random.tcc:1518: 		   + std::lgamma(_M_t - __np + 1));
	vaddsd	.LC12(%rip), %xmm0, %xmm0	#, tmp235, tmp236
	call	lgamma@PLT	#
# /usr/include/c++/13/bits/random.tcc:1519: 	  _M_lp1p = std::log(__pa / __1p);
	vmovsd	32(%rsp), %xmm5	# %sfp, __pa
# /usr/include/c++/13/bits/random.tcc:1518: 		   + std::lgamma(_M_t - __np + 1));
	vaddsd	(%rsp), %xmm0, %xmm0	# %sfp, tmp270, tmp238
# /usr/include/c++/13/bits/random.tcc:1517: 	  _M_lf = (std::lgamma(__np + 1)
	vmovsd	%xmm0, 88(%rbx)	# tmp238, this_84(D)->_M_lf
# /usr/include/c++/13/bits/random.tcc:1519: 	  _M_lp1p = std::log(__pa / __1p);
	vdivsd	16(%rsp), %xmm5, %xmm0	# %sfp, __pa, tmp239
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1521: 	  _M_q = -std::log(1 - (__p12 - __pa) / __1p);
	vmovsd	72(%rsp), %xmm5	# %sfp, _1
# /usr/include/c++/13/bits/random.tcc:1521: 	  _M_q = -std::log(1 - (__p12 - __pa) / __1p);
	vmovsd	.LC12(%rip), %xmm7	#, tmp331
# /usr/include/c++/13/bits/random.tcc:1519: 	  _M_lp1p = std::log(__pa / __1p);
	vmovsd	%xmm0, 96(%rbx)	# tmp271, this_84(D)->_M_lp1p
# /usr/include/c++/13/bits/random.tcc:1521: 	  _M_q = -std::log(1 - (__p12 - __pa) / __1p);
	vsubsd	32(%rsp), %xmm5, %xmm0	# %sfp, _1, tmp240
# /usr/include/c++/13/bits/random.tcc:1521: 	  _M_q = -std::log(1 - (__p12 - __pa) / __1p);
	vdivsd	16(%rsp), %xmm0, %xmm0	# %sfp, tmp240, tmp241
# /usr/include/c++/13/bits/random.tcc:1521: 	  _M_q = -std::log(1 - (__p12 - __pa) / __1p);
	vsubsd	%xmm0, %xmm7, %xmm0	# tmp241, tmp331, tmp242
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1521: 	  _M_q = -std::log(1 - (__p12 - __pa) / __1p);
	vxorpd	.LC32(%rip), %xmm0, %xmm0	#, tmp272, tmp244
	vmovsd	%xmm0, 16(%rbx)	# tmp244, this_84(D)->_M_q
	jmp	.L456	#
	.p2align 4
	.p2align 3
.L476:
# /usr/include/c++/13/bits/random.tcc:1525: 	_M_q = -std::log(1 - __p12);
	vmovsd	.LC12(%rip), %xmm3	#, tmp332
	vsubsd	%xmm5, %xmm3, %xmm0	# _1, tmp332, tmp246
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1525: 	_M_q = -std::log(1 - __p12);
	vxorpd	.LC32(%rip), %xmm0, %xmm0	#, tmp273, tmp248
	vmovsd	%xmm0, 16(%rbx)	# tmp248, this_84(D)->_M_q
.L456:
# /usr/include/c++/13/bits/random.tcc:1526:     }
	movq	104(%rsp), %rax	# D.83333, tmp279
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp279
	jne	.L482	#,
	addq	$112, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
.L477:
	.cfi_restore_state
	vmovsd	%xmm5, (%rsp)	# _1, %sfp
# /usr/include/c++/13/bits/random.tcc:1495: 	    std::sqrt(__np * __1p * std::log(32 * __np
	call	sqrt@PLT	#
	vmovsd	(%rsp), %xmm5	# %sfp, _1
	jmp	.L462	#
.L482:
# /usr/include/c++/13/bits/random.tcc:1526:     }
	call	__stack_chk_fail@PLT	#
.L478:
	vmovsd	%xmm5, 48(%rsp)	# _1, %sfp
# /usr/include/c++/13/bits/random.tcc:1499: 	    std::sqrt(__np * __1p * std::log(32 * _M_t * __1p
	call	sqrt@PLT	#
	vmovsd	48(%rsp), %xmm5	# %sfp, _1
	jmp	.L465	#
.L479:
	vmovsd	%xmm5, 64(%rsp)	# _1, %sfp
	vmovsd	%xmm6, 72(%rsp)	# _25, %sfp
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmovsd	24(%rsp), %xmm0	# %sfp,
	call	sqrt@PLT	#
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmovsd	.LC159(%rip), %xmm1	#, tmp251
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmovsd	(%rsp), %xmm6	# %sfp, _14
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmulsd	8(%rsp), %xmm1, %xmm4	# %sfp, tmp251, tmp202
	vmovsd	%xmm1, 56(%rsp)	# tmp251, %sfp
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vdivsd	%xmm4, %xmm6, %xmm4	# tmp202, _14, tmp204
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vaddsd	.LC12(%rip), %xmm4, %xmm4	#, tmp204, tmp205
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmulsd	%xmm0, %xmm4, %xmm4	# tmp263, tmp205, _151
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	vmovsd	24(%rsp), %xmm0	# %sfp,
# /usr/include/c++/13/bits/random.tcc:1505: 	  _M_s1 = std::sqrt(__np * __1p) * (1 + _M_d1 / (4 * __np));
	vmovsd	%xmm4, 40(%rbx)	# _151, this_84(D)->_M_s1
	vmovsd	%xmm4, 48(%rsp)	# _151, %sfp
# /usr/include/c++/13/bits/random.tcc:1506: 	  _M_s2 = std::sqrt(__np * __1p) * (1 + _M_d2 / (4 * (_M_t * __1p)));
	call	sqrt@PLT	#
	vmovsd	72(%rsp), %xmm6	# %sfp, _25
	vmovsd	64(%rsp), %xmm5	# %sfp, _1
	vmovsd	56(%rsp), %xmm1	# %sfp, tmp251
	vmovsd	48(%rsp), %xmm4	# %sfp, _151
	vmovsd	(%rsp), %xmm7	# %sfp, _14
	jmp	.L468	#
	.cfi_endproc
.LFE4568:
	.size	_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv, .-_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv
	.section	.text._ZNSt21binomial_distributionIiE10param_typeC2Eid,"axG",@progbits,_ZNSt21binomial_distributionIiE10param_typeC5Eid,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt21binomial_distributionIiE10param_typeC2Eid
	.type	_ZNSt21binomial_distributionIiE10param_typeC2Eid, @function
_ZNSt21binomial_distributionIiE10param_typeC2Eid:
.LFB4443:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.h:3870: 	: _M_t(__t), _M_p(__p)
	movl	%esi, (%rdi)	# tmp86, *this_3(D)._M_t
# /usr/include/c++/13/bits/random.h:3870: 	: _M_t(__t), _M_p(__p)
	vmovsd	%xmm0, 8(%rdi)	# tmp87, *this_3(D)._M_p
# /usr/include/c++/13/bits/random.h:3875: 	  _M_initialize();
	jmp	_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv	#
	.cfi_endproc
.LFE4443:
	.size	_ZNSt21binomial_distributionIiE10param_typeC2Eid, .-_ZNSt21binomial_distributionIiE10param_typeC2Eid
	.weak	_ZNSt21binomial_distributionIiE10param_typeC1Eid
	.set	_ZNSt21binomial_distributionIiE10param_typeC1Eid,_ZNSt21binomial_distributionIiE10param_typeC2Eid
	.section	.text._ZNSt21binomial_distributionIiEC2Eid,"axG",@progbits,_ZNSt21binomial_distributionIiEC5Eid,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt21binomial_distributionIiEC2Eid
	.type	_ZNSt21binomial_distributionIiEC2Eid, @function
_ZNSt21binomial_distributionIiEC2Eid:
.LFB4256:
	.cfi_startproc
	endbr64	
	pushq	%rbx	#
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
# /usr/include/c++/13/bits/random.h:3916:       binomial_distribution(_IntType __t, double __p = 0.5)
	movq	%rdi, %rbx	# tmp88, this
# /usr/include/c++/13/bits/random.h:3917:       : _M_param(__t, __p), _M_nd()
	call	_ZNSt21binomial_distributionIiE10param_typeC1Eid	#
# /usr/include/c++/13/bits/random.h:3917:       : _M_param(__t, __p), _M_nd()
	leaq	112(%rbx), %rdi	#, tmp87
# /usr/include/c++/13/bits/random.h:3918:       { }
	popq	%rbx	#
	.cfi_def_cfa_offset 8
# /usr/include/c++/13/bits/random.h:3917:       : _M_param(__t, __p), _M_nd()
	jmp	_ZNSt19normal_distributionIdEC1Ev	#
	.cfi_endproc
.LFE4256:
	.size	_ZNSt21binomial_distributionIiEC2Eid, .-_ZNSt21binomial_distributionIiEC2Eid
	.weak	_ZNSt21binomial_distributionIiEC1Eid
	.set	_ZNSt21binomial_distributionIiEC1Eid,_ZNSt21binomial_distributionIiEC2Eid
	.section	.text._ZNSt8__detail4_ModImLm4294967296ELm1ELm0ELb1ELb1EE6__calcEm,"axG",@progbits,_ZNSt8__detail4_ModImLm4294967296ELm1ELm0ELb1ELb1EE6__calcEm,comdat
	.p2align 4
	.weak	_ZNSt8__detail4_ModImLm4294967296ELm1ELm0ELb1ELb1EE6__calcEm
	.type	_ZNSt8__detail4_ModImLm4294967296ELm1ELm0ELb1ELb1EE6__calcEm, @function
_ZNSt8__detail4_ModImLm4294967296ELm1ELm0ELb1ELb1EE6__calcEm:
.LFB4635:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.h:143: 	    __res %= __m;
	movl	%edi, %eax	# tmp85, __res
# /usr/include/c++/13/bits/random.h:145: 	}
	ret	
	.cfi_endproc
.LFE4635:
	.size	_ZNSt8__detail4_ModImLm4294967296ELm1ELm0ELb1ELb1EE6__calcEm, .-_ZNSt8__detail4_ModImLm4294967296ELm1ELm0ELb1ELb1EE6__calcEm
	.section	.text._ZNSt8__detail5__modImLm4294967296ELm1ELm0EEET_S1_,"axG",@progbits,_ZNSt8__detail5__modImLm4294967296ELm1ELm0EEET_S1_,comdat
	.p2align 4
	.weak	_ZNSt8__detail5__modImLm4294967296ELm1ELm0EEET_S1_
	.type	_ZNSt8__detail5__modImLm4294967296ELm1ELm0EEET_S1_, @function
_ZNSt8__detail5__modImLm4294967296ELm1ELm0EEET_S1_:
.LFB4541:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.h:158: 	    return _Mod<_Tp, __m, __a1, __c>::__calc(__x);
	jmp	_ZNSt8__detail4_ModImLm4294967296ELm1ELm0ELb1ELb1EE6__calcEm	#
	.cfi_endproc
.LFE4541:
	.size	_ZNSt8__detail5__modImLm4294967296ELm1ELm0EEET_S1_, .-_ZNSt8__detail5__modImLm4294967296ELm1ELm0EEET_S1_
	.section	.text._ZNSt8__detail4_ModImLm624ELm1ELm0ELb1ELb1EE6__calcEm,"axG",@progbits,_ZNSt8__detail4_ModImLm624ELm1ELm0ELb1ELb1EE6__calcEm,comdat
	.p2align 4
	.weak	_ZNSt8__detail4_ModImLm624ELm1ELm0ELb1ELb1EE6__calcEm
	.type	_ZNSt8__detail4_ModImLm624ELm1ELm0ELb1ELb1EE6__calcEm, @function
_ZNSt8__detail4_ModImLm624ELm1ELm0ELb1ELb1EE6__calcEm:
.LFB4636:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.h:143: 	    __res %= __m;
	movq	%rdi, %rax	# __x, tmp85
	movabsq	$945986875574848801, %rdx	#, tmp87
	shrq	$4, %rax	#, tmp85
	mulq	%rdx	# tmp87
	movq	%rdx, %rax	# tmp86, tmp86
	shrq	%rax	# tmp86
	imulq	$624, %rax, %rdx	#, __res, tmp88
	movq	%rdi, %rax	# __x, __x
	subq	%rdx, %rax	# tmp88, __x
# /usr/include/c++/13/bits/random.h:145: 	}
	ret	
	.cfi_endproc
.LFE4636:
	.size	_ZNSt8__detail4_ModImLm624ELm1ELm0ELb1ELb1EE6__calcEm, .-_ZNSt8__detail4_ModImLm624ELm1ELm0ELb1ELb1EE6__calcEm
	.section	.text._ZNSt8__detail5__modImLm624ELm1ELm0EEET_S1_,"axG",@progbits,_ZNSt8__detail5__modImLm624ELm1ELm0EEET_S1_,comdat
	.p2align 4
	.weak	_ZNSt8__detail5__modImLm624ELm1ELm0EEET_S1_
	.type	_ZNSt8__detail5__modImLm624ELm1ELm0EEET_S1_, @function
_ZNSt8__detail5__modImLm624ELm1ELm0EEET_S1_:
.LFB4542:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.h:158: 	    return _Mod<_Tp, __m, __a1, __c>::__calc(__x);
	jmp	_ZNSt8__detail4_ModImLm624ELm1ELm0ELb1ELb1EE6__calcEm	#
	.cfi_endproc
.LFE4542:
	.size	_ZNSt8__detail5__modImLm624ELm1ELm0EEET_S1_, .-_ZNSt8__detail5__modImLm624ELm1ELm0EEET_S1_
	.section	.text._ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE4seedEm,"axG",@progbits,_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE4seedEm,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE4seedEm
	.type	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE4seedEm, @function
_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE4seedEm:
.LFB4409:
	.cfi_startproc
	endbr64	
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12	# tmp94, this
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rdi	# tmp95, __sd
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
# /usr/include/c++/13/bits/random.tcc:333:       for (size_t __i = 1; __i < state_size; ++__i)
	movl	$1, %ebp	#, __i
# /usr/include/c++/13/bits/random.tcc:331: 	__detail::_Shift<_UIntType, __w>::__value>(__sd);
	call	_ZNSt8__detail5__modImLm4294967296ELm1ELm0EEET_S1_	#
# /usr/include/c++/13/bits/random.tcc:330:       _M_x[0] = __detail::__mod<_UIntType,
	movq	%rax, (%r12)	# tmp96, this_8(D)->_M_x[0]
	.p2align 4
	.p2align 3
.L491:
# /usr/include/c++/13/bits/random.tcc:335: 	  _UIntType __x = _M_x[__i - 1];
	movq	-8(%r12,%rbp,8), %rax	# MEM[(long unsigned int *)this_8(D) + -8B + __i_21 * 8], __x
# /usr/include/c++/13/bits/random.tcc:338: 	  __x += __detail::__mod<_UIntType, __n>(__i);
	movq	%rbp, %rdi	# __i,
# /usr/include/c++/13/bits/random.tcc:336: 	  __x ^= __x >> (__w - 2);
	movq	%rax, %rbx	# __x, _2
	shrq	$30, %rbx	#, _2
# /usr/include/c++/13/bits/random.tcc:336: 	  __x ^= __x >> (__w - 2);
	xorq	%rax, %rbx	# __x, __x
# /usr/include/c++/13/bits/random.tcc:338: 	  __x += __detail::__mod<_UIntType, __n>(__i);
	call	_ZNSt8__detail5__modImLm624ELm1ELm0EEET_S1_	#
# /usr/include/c++/13/bits/random.tcc:337: 	  __x *= __f;
	imulq	$1812433253, %rbx, %rbx	#, __x, __x
# /usr/include/c++/13/bits/random.tcc:338: 	  __x += __detail::__mod<_UIntType, __n>(__i);
	leaq	(%rbx,%rax), %rdi	#, __x
# /usr/include/c++/13/bits/random.tcc:340: 	    __detail::_Shift<_UIntType, __w>::__value>(__x);
	call	_ZNSt8__detail5__modImLm4294967296ELm1ELm0EEET_S1_	#
# /usr/include/c++/13/bits/random.tcc:339: 	  _M_x[__i] = __detail::__mod<_UIntType,
	movq	%rax, (%r12,%rbp,8)	# tmp98, MEM[(long unsigned int *)this_8(D) + __i_21 * 8]
# /usr/include/c++/13/bits/random.tcc:333:       for (size_t __i = 1; __i < state_size; ++__i)
	incq	%rbp	# __i
# /usr/include/c++/13/bits/random.tcc:333:       for (size_t __i = 1; __i < state_size; ++__i)
	cmpq	$624, %rbp	#, __i
	jne	.L491	#,
# /usr/include/c++/13/bits/random.tcc:342:       _M_p = state_size;
	movq	$624, 4992(%r12)	#, this_8(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:343:     }
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE4409:
	.size	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE4seedEm, .-_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE4seedEm
	.section	.text._ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEC2Em,"axG",@progbits,_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEC5Em,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEC2Em
	.type	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEC2Em, @function
_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEC2Em:
.LFB4224:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.h:546:       { seed(__sd); }
	jmp	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE4seedEm	#
	.cfi_endproc
.LFE4224:
	.size	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEC2Em, .-_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEC2Em
	.weak	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEC1Em
	.set	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEC1Em,_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEC2Em
	.section	.text.startup._Z41__static_initialization_and_destruction_0v,"ax",@progbits
	.p2align 4
	.type	_Z41__static_initialization_and_destruction_0v, @function
_Z41__static_initialization_and_destruction_0v:
.LFB4719:
	.cfi_startproc
# state.h:66: inline std::random_device rd{}; 
	cmpb	$0, _ZGV2rd(%rip)	#, MEM[(char *)&_ZGV2rd]
# eduPIC.cc:102: }
	pushq	%rbx	#
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
# state.h:66: inline std::random_device rd{}; 
	je	.L502	#,
.L496:
# state.h:67: inline std::mt19937 MTgen(rd());
	cmpb	$0, _ZGV5MTgen(%rip)	#, MEM[(char *)&_ZGV5MTgen]
	je	.L503	#,
.L497:
# state.h:68: inline std::uniform_real_distribution<> R01(0.0, 1.0);
	cmpb	$0, _ZGV3R01(%rip)	#, MEM[(char *)&_ZGV3R01]
	je	.L504	#,
.L498:
# state.h:69: inline std::normal_distribution<> RMB(0.0, sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS));
	cmpb	$0, _ZGV3RMB(%rip)	#, MEM[(char *)&_ZGV3RMB]
	je	.L505	#,
# eduPIC.cc:102: }
	popq	%rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret	
.L502:
	.cfi_restore_state
# state.h:66: inline std::random_device rd{}; 
	leaq	rd(%rip), %rbx	#, tmp90
# state.h:66: inline std::random_device rd{}; 
	movb	$1, _ZGV2rd(%rip)	#, MEM[(char *)&_ZGV2rd]
# state.h:66: inline std::random_device rd{}; 
	movq	%rbx, %rdi	# tmp90,
	call	_ZNSt13random_deviceC1Ev	#
# state.h:66: inline std::random_device rd{}; 
	leaq	__dso_handle(%rip), %rdx	#, tmp91
	movq	%rbx, %rsi	# tmp90,
	leaq	_ZNSt13random_deviceD1Ev(%rip), %rdi	#, tmp93
	call	__cxa_atexit@PLT	#
	jmp	.L496	#
.L505:
# eduPIC.cc:102: }
	popq	%rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 8
# state.h:69: inline std::normal_distribution<> RMB(0.0, sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS));
	leaq	RMB(%rip), %rdi	#, tmp108
# state.h:69: inline std::normal_distribution<> RMB(0.0, sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS));
	movb	$1, _ZGV3RMB(%rip)	#, MEM[(char *)&_ZGV3RMB]
# state.h:69: inline std::normal_distribution<> RMB(0.0, sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS));
	vmovsd	.LC161(%rip), %xmm1	#,
	vxorpd	%xmm0, %xmm0, %xmm0	#
	jmp	_ZNSt19normal_distributionIdEC1Edd	#
.L504:
	.cfi_restore_state
# state.h:68: inline std::uniform_real_distribution<> R01(0.0, 1.0);
	leaq	R01(%rip), %rdi	#, tmp103
	vmovsd	.LC12(%rip), %xmm1	#,
	vxorpd	%xmm0, %xmm0, %xmm0	#
# state.h:68: inline std::uniform_real_distribution<> R01(0.0, 1.0);
	movb	$1, _ZGV3R01(%rip)	#, MEM[(char *)&_ZGV3R01]
# state.h:68: inline std::uniform_real_distribution<> R01(0.0, 1.0);
	call	_ZNSt25uniform_real_distributionIdEC1Edd	#
	jmp	.L498	#
.L503:
# state.h:67: inline std::mt19937 MTgen(rd());
	leaq	rd(%rip), %rdi	#, tmp96
# state.h:67: inline std::mt19937 MTgen(rd());
	movb	$1, _ZGV5MTgen(%rip)	#, MEM[(char *)&_ZGV5MTgen]
# state.h:67: inline std::mt19937 MTgen(rd());
	call	_ZNSt13random_deviceclEv	#
# state.h:67: inline std::mt19937 MTgen(rd());
	leaq	MTgen(%rip), %rdi	#, tmp98
	movl	%eax, %esi	# tmp109, _16
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEC1Em	#
	jmp	.L497	#
	.cfi_endproc
.LFE4719:
	.size	_Z41__static_initialization_and_destruction_0v, .-_Z41__static_initialization_and_destruction_0v
	.section	.text._ZSt3minImERKT_S2_S2_,"axG",@progbits,_ZSt3minImERKT_S2_S2_,comdat
	.p2align 4
	.weak	_ZSt3minImERKT_S2_S2_
	.type	_ZSt3minImERKT_S2_S2_, @function
_ZSt3minImERKT_S2_S2_:
.LFB4638:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_algobase.h:240:       return __a;
	movq	(%rdi), %rax	# *__a_6(D), tmp92
	cmpq	%rax, (%rsi)	# tmp92, *__b_5(D)
	movq	%rdi, %rax	# __a, __a
	cmovb	%rsi, %rax	# __b,, __a
# /usr/include/c++/13/bits/stl_algobase.h:241:     }
	ret	
	.cfi_endproc
.LFE4638:
	.size	_ZSt3minImERKT_S2_S2_, .-_ZSt3minImERKT_S2_S2_
	.section	.text._ZNSt6vectorIiSaIiEE11_S_max_sizeERKS0_.isra.0,"ax",@progbits
	.p2align 4
	.type	_ZNSt6vectorIiSaIiEE11_S_max_sizeERKS0_.isra.0, @function
_ZNSt6vectorIiSaIiEE11_S_max_sizeERKS0_.isra.0:
.LFB4759:
	.cfi_startproc
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 48
# /usr/include/c++/13/bits/stl_vector.h:1921: 	const size_t __diffmax
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp92
	movq	%rax, 24(%rsp)	# tmp92, D.83389
	movabsq	$2305843009213693951, %rax	#, tmp92
# /usr/include/c++/13/bits/stl_vector.h:1924: 	return (std::min)(__diffmax, __allocmax);
	leaq	16(%rsp), %rsi	#, tmp87
	leaq	8(%rsp), %rdi	#, tmp88
# /usr/include/c++/13/bits/stl_vector.h:1921: 	const size_t __diffmax
	movq	%rax, 8(%rsp)	# tmp85, __diffmax
# /usr/include/c++/13/bits/stl_vector.h:1923: 	const size_t __allocmax = _Alloc_traits::max_size(__a);
	movq	%rax, 16(%rsp)	# tmp85, __allocmax
# /usr/include/c++/13/bits/stl_vector.h:1924: 	return (std::min)(__diffmax, __allocmax);
	call	_ZSt3minImERKT_S2_S2_	#
# /usr/include/c++/13/bits/stl_vector.h:1924: 	return (std::min)(__diffmax, __allocmax);
	movq	(%rax), %rax	# *_1, <retval>
# /usr/include/c++/13/bits/stl_vector.h:1925:       }
	movq	24(%rsp), %rdx	# D.83389, tmp93
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp93
	jne	.L512	#,
	addq	$40, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret	
.L512:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE4759:
	.size	_ZNSt6vectorIiSaIiEE11_S_max_sizeERKS0_.isra.0, .-_ZNSt6vectorIiSaIiEE11_S_max_sizeERKS0_.isra.0
	.section	.rodata._ZNSt6vectorIiSaIiEE17_S_check_init_lenEmRKS0_.isra.0.str1.8,"aMS",@progbits,1
	.align 8
.LC162:
	.string	"cannot create std::vector larger than max_size()"
	.section	.text._ZNSt6vectorIiSaIiEE17_S_check_init_lenEmRKS0_.isra.0,"axG",@progbits,_ZNSt6vectorIiSaIiEE6assignIN9__gnu_cxx17__normal_iteratorIPiS1_EEvEEvT_S7_,comdat
	.p2align 4
	.type	_ZNSt6vectorIiSaIiEE17_S_check_init_lenEmRKS0_.isra.0, @function
_ZNSt6vectorIiSaIiEE17_S_check_init_lenEmRKS0_.isra.0:
.LFB4760:
	.cfi_startproc
	pushq	%rbx	#
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
# /usr/include/c++/13/bits/stl_vector.h:1907:       _S_check_init_len(size_type __n, const allocator_type& __a)
	movq	%rdi, %rbx	# tmp85, __n
# /usr/include/c++/13/bits/stl_vector.h:1909: 	if (__n > _S_max_size(_Tp_alloc_type(__a)))
	call	_ZNSt6vectorIiSaIiEE11_S_max_sizeERKS0_.isra.0	#
# /usr/include/c++/13/bits/stl_vector.h:1909: 	if (__n > _S_max_size(_Tp_alloc_type(__a)))
	cmpq	%rbx, %rax	# __n, tmp86
	jb	.L517	#,
# /usr/include/c++/13/bits/stl_vector.h:1913:       }
	popq	%rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret	
.L517:
	.cfi_restore_state
# /usr/include/c++/13/bits/stl_vector.h:1910: 	  __throw_length_error(
	leaq	.LC162(%rip), %rdi	#, tmp84
	call	_ZSt20__throw_length_errorPKc@PLT	#
	.cfi_endproc
.LFE4760:
	.size	_ZNSt6vectorIiSaIiEE17_S_check_init_lenEmRKS0_.isra.0, .-_ZNSt6vectorIiSaIiEE17_S_check_init_lenEmRKS0_.isra.0
	.section	.text._ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE3minEv,"axG",@progbits,_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE3minEv,comdat
	.p2align 4
	.weak	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE3minEv
	.type	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE3minEv, @function
_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE3minEv:
.LFB4640:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.h:571:       { return 0; }
	xorl	%eax, %eax	#
	ret	
	.cfi_endproc
.LFE4640:
	.size	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE3minEv, .-_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE3minEv
	.section	.text._ZSt3maxImERKT_S2_S2_,"axG",@progbits,_ZSt3maxImERKT_S2_S2_,comdat
	.p2align 4
	.weak	_ZSt3maxImERKT_S2_S2_
	.type	_ZSt3maxImERKT_S2_S2_, @function
_ZSt3maxImERKT_S2_S2_:
.LFB4641:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_algobase.h:264:       return __a;
	movq	(%rsi), %rax	# *__b_6(D), tmp92
	cmpq	%rax, (%rdi)	# tmp92, *__a_5(D)
	movq	%rdi, %rax	# __a, __a
	cmovb	%rsi, %rax	# __b,, __a
# /usr/include/c++/13/bits/stl_algobase.h:265:     }
	ret	
	.cfi_endproc
.LFE4641:
	.size	_ZSt3maxImERKT_S2_S2_, .-_ZSt3maxImERKT_S2_S2_
	.section	.text._ZNKSt12_Vector_baseIiSaIiEE19_M_get_Tp_allocatorEv,"axG",@progbits,_ZNKSt12_Vector_baseIiSaIiEE19_M_get_Tp_allocatorEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNKSt12_Vector_baseIiSaIiEE19_M_get_Tp_allocatorEv
	.type	_ZNKSt12_Vector_baseIiSaIiEE19_M_get_Tp_allocatorEv, @function
_ZNKSt12_Vector_baseIiSaIiEE19_M_get_Tp_allocatorEv:
.LFB4645:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_vector.h:306:       _M_get_Tp_allocator() const _GLIBCXX_NOEXCEPT
	movq	%rdi, %rax	# tmp85, this
# /usr/include/c++/13/bits/stl_vector.h:307:       { return this->_M_impl; }
	ret	
	.cfi_endproc
.LFE4645:
	.size	_ZNKSt12_Vector_baseIiSaIiEE19_M_get_Tp_allocatorEv, .-_ZNKSt12_Vector_baseIiSaIiEE19_M_get_Tp_allocatorEv
	.section	.text._ZNKSt6vectorIiSaIiEE8max_sizeEv,"axG",@progbits,_ZNKSt6vectorIiSaIiEE8max_sizeEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNKSt6vectorIiSaIiEE8max_sizeEv
	.type	_ZNKSt6vectorIiSaIiEE8max_sizeEv, @function
_ZNKSt6vectorIiSaIiEE8max_sizeEv:
.LFB4556:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_vector.h:999:       { return _S_max_size(_M_get_Tp_allocator()); }
	jmp	_ZNSt6vectorIiSaIiEE11_S_max_sizeERKS0_.isra.0	#
	.cfi_endproc
.LFE4556:
	.size	_ZNKSt6vectorIiSaIiEE8max_sizeEv, .-_ZNKSt6vectorIiSaIiEE8max_sizeEv
	.section	.text._ZNKSt6vectorIiSaIiEE12_M_check_lenEmPKc,"axG",@progbits,_ZNKSt6vectorIiSaIiEE12_M_check_lenEmPKc,comdat
	.align 2
	.p2align 4
	.weak	_ZNKSt6vectorIiSaIiEE12_M_check_lenEmPKc
	.type	_ZNKSt6vectorIiSaIiEE12_M_check_lenEmPKc, @function
_ZNKSt6vectorIiSaIiEE12_M_check_lenEmPKc:
.LFB4558:
	.cfi_startproc
	endbr64	
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbp	# tmp108, this
	subq	$32, %rsp	#,
	.cfi_def_cfa_offset 64
# /usr/include/c++/13/bits/stl_vector.h:1896:       _M_check_len(size_type __n, const char* __s) const
	movq	%rdx, %r12	# tmp109, __s
	movq	%rsi, 8(%rsp)	# __n, __n
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp115
	movq	%rax, 24(%rsp)	# tmp115, D.83415
	xorl	%eax, %eax	# tmp115
# /usr/include/c++/13/bits/stl_vector.h:1898: 	if (max_size() - size() < __n)
	call	_ZNKSt6vectorIiSaIiEE8max_sizeEv	#
# /usr/include/c++/13/bits/stl_vector.h:1898: 	if (max_size() - size() < __n)
	movq	8(%rbp), %rsi	# MEM[(int * *)this_10(D) + 8B], MEM[(int * *)this_10(D) + 8B]
	movq	0(%rbp), %rdi	# MEM[(int * *)this_10(D)], MEM[(int * *)this_10(D)]
# /usr/include/c++/13/bits/stl_vector.h:1898: 	if (max_size() - size() < __n)
	movq	%rax, %rdx	# tmp110, _1
# /usr/include/c++/13/bits/stl_vector.h:1898: 	if (max_size() - size() < __n)
	call	_ZNKSt6vectorIiSaIiEE4sizeEv.isra.0	#
# /usr/include/c++/13/bits/stl_vector.h:1898: 	if (max_size() - size() < __n)
	subq	%rax, %rdx	# _2, tmp100
# /usr/include/c++/13/bits/stl_vector.h:1898: 	if (max_size() - size() < __n)
	cmpq	8(%rsp), %rdx	# __n, tmp100
	jb	.L535	#,
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	leaq	16(%rsp), %rdi	#, tmp103
	leaq	8(%rsp), %rsi	#, tmp102
	movq	%rax, %rbx	# tmp111, _2
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	movq	%rax, 16(%rsp)	# _2, D.79299
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	vzeroupper
	call	_ZSt3maxImERKT_S2_S2_	#
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movq	%rbp, %rdi	# this,
	addq	(%rax), %rbx	# *_5, tmp104
	jc	.L528	#,
	call	_ZNKSt6vectorIiSaIiEE8max_sizeEv	#
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	cmpq	%rbx, %rax	# tmp104, tmp113
	cmova	%rbx, %rax	# tmp113,, tmp104, <retval>
.L524:
# /usr/include/c++/13/bits/stl_vector.h:1903:       }
	movq	24(%rsp), %rdx	# D.83415, tmp117
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp117
	jne	.L536	#,
	addq	$32, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
.L528:
	.cfi_restore_state
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	call	_ZNKSt6vectorIiSaIiEE8max_sizeEv	#
	jmp	.L524	#
.L535:
# /usr/include/c++/13/bits/stl_vector.h:1899: 	  __throw_length_error(__N(__s));
	movq	24(%rsp), %rax	# D.83415, tmp116
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp116
	jne	.L537	#,
	movq	%r12, %rdi	# __s,
	vzeroupper
	call	_ZSt20__throw_length_errorPKc@PLT	#
.L536:
# /usr/include/c++/13/bits/stl_vector.h:1903:       }
	call	__stack_chk_fail@PLT	#
.L537:
# /usr/include/c++/13/bits/stl_vector.h:1899: 	  __throw_length_error(__N(__s));
	vzeroupper
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE4558:
	.size	_ZNKSt6vectorIiSaIiEE12_M_check_lenEmPKc, .-_ZNKSt6vectorIiSaIiEE12_M_check_lenEmPKc
	.section	.text._ZN9__gnu_cxxmiIPiSt6vectorIiSaIiEEEENS_17__normal_iteratorIT_T0_E15difference_typeERKS8_SB_,"axG",@progbits,_ZN9__gnu_cxxmiIPiSt6vectorIiSaIiEEEENS_17__normal_iteratorIT_T0_E15difference_typeERKS8_SB_,comdat
	.p2align 4
	.weak	_ZN9__gnu_cxxmiIPiSt6vectorIiSaIiEEEENS_17__normal_iteratorIT_T0_E15difference_typeERKS8_SB_
	.type	_ZN9__gnu_cxxmiIPiSt6vectorIiSaIiEEEENS_17__normal_iteratorIT_T0_E15difference_typeERKS8_SB_, @function
_ZN9__gnu_cxxmiIPiSt6vectorIiSaIiEEEENS_17__normal_iteratorIT_T0_E15difference_typeERKS8_SB_:
.LFB4649:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbp	# tmp94, __rhs
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 32
# /usr/include/c++/13/bits/stl_iterator.h:1337:     { return __lhs.base() - __rhs.base(); }
	call	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEE4baseEv	#
# /usr/include/c++/13/bits/stl_iterator.h:1337:     { return __lhs.base() - __rhs.base(); }
	movq	%rbp, %rdi	# __rhs,
# /usr/include/c++/13/bits/stl_iterator.h:1337:     { return __lhs.base() - __rhs.base(); }
	movq	(%rax), %rbx	# *_1, _2
# /usr/include/c++/13/bits/stl_iterator.h:1337:     { return __lhs.base() - __rhs.base(); }
	call	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEE4baseEv	#
# /usr/include/c++/13/bits/stl_iterator.h:1337:     { return __lhs.base() - __rhs.base(); }
	subq	(%rax), %rbx	# *_3, _2
# /usr/include/c++/13/bits/stl_iterator.h:1337:     { return __lhs.base() - __rhs.base(); }
	addq	$8, %rsp	#,
	.cfi_def_cfa_offset 24
# /usr/include/c++/13/bits/stl_iterator.h:1337:     { return __lhs.base() - __rhs.base(); }
	movq	%rbx, %rax	# _2, tmp91
# /usr/include/c++/13/bits/stl_iterator.h:1337:     { return __lhs.base() - __rhs.base(); }
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
# /usr/include/c++/13/bits/stl_iterator.h:1337:     { return __lhs.base() - __rhs.base(); }
	sarq	$2, %rax	#, tmp92
# /usr/include/c++/13/bits/stl_iterator.h:1337:     { return __lhs.base() - __rhs.base(); }
	ret	
	.cfi_endproc
.LFE4649:
	.size	_ZN9__gnu_cxxmiIPiSt6vectorIiSaIiEEEENS_17__normal_iteratorIT_T0_E15difference_typeERKS8_SB_, .-_ZN9__gnu_cxxmiIPiSt6vectorIiSaIiEEEENS_17__normal_iteratorIT_T0_E15difference_typeERKS8_SB_
	.section	.text._ZSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEET_S7_,"axG",@progbits,_ZSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEET_S7_,comdat
	.p2align 4
	.weak	_ZSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEET_S7_
	.type	_ZSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEET_S7_, @function
_ZSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEET_S7_:
.LFB4653:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/cpp_type_traits.h:607:     __miter_base(_Iterator __it)
	movq	%rdi, %rax	# tmp86, __it
# /usr/include/c++/13/bits/cpp_type_traits.h:608:     { return __it; }
	ret	
	.cfi_endproc
.LFE4653:
	.size	_ZSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEET_S7_, .-_ZSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEET_S7_
	.section	.text._ZSt12__niter_baseIPiET_S1_,"axG",@progbits,_ZSt12__niter_baseIPiET_S1_,comdat
	.p2align 4
	.weak	_ZSt12__niter_baseIPiET_S1_
	.type	_ZSt12__niter_baseIPiET_S1_, @function
_ZSt12__niter_baseIPiET_S1_:
.LFB4682:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_algobase.h:316:     __niter_base(_Iterator __it)
	movq	%rdi, %rax	# tmp85, __it
# /usr/include/c++/13/bits/stl_algobase.h:318:     { return __it; }
	ret	
	.cfi_endproc
.LFE4682:
	.size	_ZSt12__niter_baseIPiET_S1_, .-_ZSt12__niter_baseIPiET_S1_
	.section	.text._ZSt12__relocate_aIPiS0_SaIiEET0_T_S3_S2_RT1_.isra.0,"axG",@progbits,_ZNSt6vectorIiSaIiEE17_M_default_appendEm,comdat
	.p2align 4
	.type	_ZSt12__relocate_aIPiS0_SaIiEET0_T_S3_S2_RT1_.isra.0, @function
_ZSt12__relocate_aIPiS0_SaIiEET0_T_S3_S2_RT1_.isra.0:
.LFB4761:
	.cfi_startproc
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12	# tmp88, __first
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdx, %rdi	# tmp90, __result
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
# /usr/include/c++/13/bits/stl_uninitialized.h:1141:     __relocate_a(_InputIterator __first, _InputIterator __last,
	movq	%rsi, %rbx	# tmp89, __last
# /usr/include/c++/13/bits/stl_uninitialized.h:1147:       return std::__relocate_a_1(std::__niter_base(__first),
	call	_ZSt12__niter_baseIPiET_S1_	#
# /usr/include/c++/13/bits/stl_uninitialized.h:1147:       return std::__relocate_a_1(std::__niter_base(__first),
	movq	%rbx, %rdi	# __last,
# /usr/include/c++/13/bits/stl_uninitialized.h:1147:       return std::__relocate_a_1(std::__niter_base(__first),
	movq	%rax, %rbp	# tmp91, _2
# /usr/include/c++/13/bits/stl_uninitialized.h:1147:       return std::__relocate_a_1(std::__niter_base(__first),
	call	_ZSt12__niter_baseIPiET_S1_	#
# /usr/include/c++/13/bits/stl_uninitialized.h:1147:       return std::__relocate_a_1(std::__niter_base(__first),
	movq	%r12, %rdi	# __first,
# /usr/include/c++/13/bits/stl_uninitialized.h:1147:       return std::__relocate_a_1(std::__niter_base(__first),
	movq	%rax, %rbx	# tmp92, _4
# /usr/include/c++/13/bits/stl_uninitialized.h:1147:       return std::__relocate_a_1(std::__niter_base(__first),
	call	_ZSt12__niter_baseIPiET_S1_	#
# /usr/include/c++/13/bits/stl_uninitialized.h:1147:       return std::__relocate_a_1(std::__niter_base(__first),
	movq	%rbp, %rdx	# _2,
	movq	%rbx, %rsi	# _4,
# /usr/include/c++/13/bits/stl_uninitialized.h:1150:     }
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
# /usr/include/c++/13/bits/stl_uninitialized.h:1147:       return std::__relocate_a_1(std::__niter_base(__first),
	movq	%rax, %rdi	# tmp93, _6
# /usr/include/c++/13/bits/stl_uninitialized.h:1150:     }
	popq	%r12	#
	.cfi_def_cfa_offset 8
# /usr/include/c++/13/bits/stl_uninitialized.h:1147:       return std::__relocate_a_1(std::__niter_base(__first),
	jmp	_ZSt14__relocate_a_1IiiENSt9enable_ifIXsrSt24__is_bitwise_relocatableIT_vE5valueEPS2_E4typeES4_S4_S4_RSaIT0_E.isra.0	#
	.cfi_endproc
.LFE4761:
	.size	_ZSt12__relocate_aIPiS0_SaIiEET0_T_S3_S2_RT1_.isra.0, .-_ZSt12__relocate_aIPiS0_SaIiEET0_T_S3_S2_RT1_.isra.0
	.section	.text._ZNSt6vectorIiSaIiEE11_S_relocateEPiS2_S2_RS0_.isra.0,"axG",@progbits,_ZNSt6vectorIiSaIiEE17_M_default_appendEm,comdat
	.p2align 4
	.type	_ZNSt6vectorIiSaIiEE11_S_relocateEPiS2_S2_RS0_.isra.0, @function
_ZNSt6vectorIiSaIiEE11_S_relocateEPiS2_S2_RS0_.isra.0:
.LFB4762:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_vector.h:509: 	return std::__relocate_a(__first, __last, __result, __alloc);
	jmp	_ZSt12__relocate_aIPiS0_SaIiEET0_T_S3_S2_RT1_.isra.0	#
	.cfi_endproc
.LFE4762:
	.size	_ZNSt6vectorIiSaIiEE11_S_relocateEPiS2_S2_RS0_.isra.0, .-_ZNSt6vectorIiSaIiEE11_S_relocateEPiS2_S2_RS0_.isra.0
	.section	.text._ZSt12__niter_baseIPiSt6vectorIiSaIiEEET_N9__gnu_cxx17__normal_iteratorIS4_T0_EE,"axG",@progbits,_ZSt12__niter_baseIPiSt6vectorIiSaIiEEET_N9__gnu_cxx17__normal_iteratorIS4_T0_EE,comdat
	.p2align 4
	.weak	_ZSt12__niter_baseIPiSt6vectorIiSaIiEEET_N9__gnu_cxx17__normal_iteratorIS4_T0_EE
	.type	_ZSt12__niter_baseIPiSt6vectorIiSaIiEEET_N9__gnu_cxx17__normal_iteratorIS4_T0_EE, @function
_ZSt12__niter_baseIPiSt6vectorIiSaIiEEET_N9__gnu_cxx17__normal_iteratorIS4_T0_EE:
.LFB4687:
	.cfi_startproc
	endbr64	
	subq	$24, %rsp	#,
	.cfi_def_cfa_offset 32
# /usr/include/c++/13/bits/stl_iterator.h:1357:     __niter_base(__gnu_cxx::__normal_iterator<_Iterator, _Container> __it)
	movq	%rdi, 8(%rsp)	# __it, __it
# /usr/include/c++/13/bits/stl_iterator.h:1359:     { return __it.base(); }
	leaq	8(%rsp), %rdi	#, tmp84
	call	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEE4baseEv	#
# /usr/include/c++/13/bits/stl_iterator.h:1359:     { return __it.base(); }
	movq	(%rax), %rax	# *_1, *_1
# /usr/include/c++/13/bits/stl_iterator.h:1359:     { return __it.base(); }
	addq	$24, %rsp	#,
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE4687:
	.size	_ZSt12__niter_baseIPiSt6vectorIiSaIiEEET_N9__gnu_cxx17__normal_iteratorIS4_T0_EE, .-_ZSt12__niter_baseIPiSt6vectorIiSaIiEEET_N9__gnu_cxx17__normal_iteratorIS4_T0_EE
	.section	.text._ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv,"axG",@progbits,_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv
	.type	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv, @function
_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv:
.LFB4701:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.tcc:406: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	movq	$-2147483648, %rcx	#, tmp177
# /usr/include/c++/13/bits/random.tcc:397:     mersenne_twister_engine<_UIntType, __w, __n, __m, __r, __a, __u, __d,
	movq	%rdi, %rdx	# tmp281, this
	leaq	1792(%rdi), %rsi	#, _195
	movq	%rdi, %rax	# this, ivtmp.1581
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
.L548:
# /usr/include/c++/13/bits/random.tcc:407: 			   | (_M_x[__k + 1] & __lower_mask));
	vpandq	8(%rax), %zmm4, %zmm0	# MEM <vector(8) long unsigned int> [(long unsigned int *)_103 + 8B], tmp181, vect__5.1551
	addq	$64, %rax	#, ivtmp.1581
# /usr/include/c++/13/bits/random.tcc:406: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	vpternlogq	$248, -64(%rax), %zmm5, %zmm0	#, MEM <vector(8) long unsigned int> [(long unsigned int *)_103], tmp176, vect___y_46.1552
# /usr/include/c++/13/bits/random.tcc:408: 	  _M_x[__k] = (_M_x[__k + __m] ^ (__y >> 1)
	vpsrlq	$1, %zmm0, %zmm1	#, vect___y_46.1552, vect__8.1556
# /usr/include/c++/13/bits/random.tcc:409: 		       ^ ((__y & 0x01) ? __a : 0));
	vpandq	%zmm3, %zmm0, %zmm0	# tmp188, vect___y_46.1552, vect__10.1558
# /usr/include/c++/13/bits/random.tcc:408: 	  _M_x[__k] = (_M_x[__k + __m] ^ (__y >> 1)
	vpsubq	%zmm0, %zmm6, %zmm0	# vect__10.1558, tmp191, vect__98.1559
	vpandq	%zmm2, %zmm0, %zmm0	# tmp194, vect__98.1559, vect__99.1560
	vpternlogq	$150, 3112(%rax), %zmm1, %zmm0	#, MEM <vector(8) long unsigned int> [(long unsigned int *)_103 + 3176B], vect__8.1556, vect_prephitmp_86.1561
	vmovdqu64	%zmm0, -64(%rax)	# vect_prephitmp_86.1561, MEM <vector(8) long unsigned int> [(long unsigned int *)_103]
	cmpq	%rsi, %rax	# _195, ivtmp.1581
	jne	.L548	#,
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
	leaq	1816(%rdx), %rax	#, ivtmp.1571
	.p2align 4
	.p2align 3
.L549:
# /usr/include/c++/13/bits/random.tcc:415: 			   | (_M_x[__k + 1] & __lower_mask));
	vpandq	8(%rax), %zmm5, %zmm0	# MEM <vector(8) long unsigned int> [(long unsigned int *)_8 + 8B], tmp231, vect__16.1509
	addq	$64, %rax	#, ivtmp.1571
# /usr/include/c++/13/bits/random.tcc:414: 	  _UIntType __y = ((_M_x[__k] & __upper_mask)
	vpternlogq	$248, -64(%rax), %zmm6, %zmm0	#, MEM <vector(8) long unsigned int> [(long unsigned int *)_8], tmp226, vect___y_44.1510
# /usr/include/c++/13/bits/random.tcc:416: 	  _M_x[__k] = (_M_x[__k + (__m - __n)] ^ (__y >> 1)
	vpsrlq	$1, %zmm0, %zmm1	#, vect___y_44.1510, vect__19.1514
# /usr/include/c++/13/bits/random.tcc:417: 		       ^ ((__y & 0x01) ? __a : 0));
	vpandq	%zmm4, %zmm0, %zmm0	# tmp238, vect___y_44.1510, vect__21.1516
# /usr/include/c++/13/bits/random.tcc:416: 	  _M_x[__k] = (_M_x[__k + (__m - __n)] ^ (__y >> 1)
	vpsubq	%zmm0, %zmm3, %zmm0	# vect__21.1516, tmp241, vect__61.1517
	vpandq	%zmm2, %zmm0, %zmm0	# tmp244, vect__61.1517, vect__60.1518
	vpternlogq	$150, -1880(%rax), %zmm1, %zmm0	#, MEM <vector(8) long unsigned int> [(long unsigned int *)_8 + -1816B], vect__19.1514, vect_prephitmp_89.1519
	vmovdqu64	%zmm0, -64(%rax)	# vect_prephitmp_89.1519, MEM <vector(8) long unsigned int> [(long unsigned int *)_8]
	cmpq	%rax, %rsi	# ivtmp.1571, _17
	jne	.L549	#,
# /usr/include/c++/13/bits/random.tcc:420:       _UIntType __y = ((_M_x[__n - 1] & __upper_mask)
	movq	4984(%rdx), %rax	# this_40(D)->_M_x[623], tmp271
# /usr/include/c++/13/bits/random.tcc:415: 			   | (_M_x[__k + 1] & __lower_mask));
	vpbroadcastq	%rcx, %ymm0	# tmp232, tmp255
# /usr/include/c++/13/bits/random.tcc:421: 		       | (_M_x[0] & __lower_mask));
	movq	(%rdx), %rcx	# this_40(D)->_M_x[0], tmp273
# /usr/include/c++/13/bits/random.tcc:415: 			   | (_M_x[__k + 1] & __lower_mask));
	vpand	4960(%rdx), %ymm0, %ymm0	# MEM <vector(4) long unsigned int> [(long unsigned int *)this_40(D) + 4960B], tmp255, vect__103.1529
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
	vpternlogq	$248, 4952(%rdx), %ymm1, %ymm0	#, MEM <vector(4) long unsigned int> [(long unsigned int *)this_40(D) + 4952B], tmp250, vect___y_104.1530
# /usr/include/c++/13/bits/random.tcc:417: 		       ^ ((__y & 0x01) ? __a : 0));
	vpbroadcastq	%r8, %ymm1	# tmp239, tmp262
# /usr/include/c++/13/bits/random.tcc:422:       _M_x[__n - 1] = (_M_x[__m - 1] ^ (__y >> 1)
	movq	%rax, %rcx	# __y, tmp275
# /usr/include/c++/13/bits/random.tcc:416: 	  _M_x[__k] = (_M_x[__k + (__m - __n)] ^ (__y >> 1)
	vpsrlq	$1, %ymm0, %ymm2	#, vect___y_104.1530, vect__107.1534
# /usr/include/c++/13/bits/random.tcc:417: 		       ^ ((__y & 0x01) ? __a : 0));
	vpand	%ymm1, %ymm0, %ymm0	# tmp262, vect___y_104.1530, vect__109.1536
# /usr/include/c++/13/bits/random.tcc:423: 		       ^ ((__y & 0x01) ? __a : 0));
	andl	$1, %eax	#, tmp277
# /usr/include/c++/13/bits/random.tcc:422:       _M_x[__n - 1] = (_M_x[__m - 1] ^ (__y >> 1)
	shrq	%rcx	# tmp275
# /usr/include/c++/13/bits/random.tcc:416: 	  _M_x[__k] = (_M_x[__k + (__m - __n)] ^ (__y >> 1)
	vpxor	%xmm1, %xmm1, %xmm1	# tmp265
	vpsubq	%ymm0, %ymm1, %ymm0	# vect__109.1536, tmp265, vect__110.1537
	vpbroadcastq	%rdi, %ymm1	# tmp245, tmp268
# /usr/include/c++/13/bits/random.tcc:422:       _M_x[__n - 1] = (_M_x[__m - 1] ^ (__y >> 1)
	xorq	3168(%rdx), %rcx	# this_40(D)->_M_x[396], tmp276
# /usr/include/c++/13/bits/random.tcc:416: 	  _M_x[__k] = (_M_x[__k + (__m - __n)] ^ (__y >> 1)
	vpand	%ymm1, %ymm0, %ymm0	# tmp268, vect__110.1537, vect__111.1538
# /usr/include/c++/13/bits/random.tcc:423: 		       ^ ((__y & 0x01) ? __a : 0));
	negq	%rax	# tmp278
# /usr/include/c++/13/bits/random.tcc:416: 	  _M_x[__k] = (_M_x[__k + (__m - __n)] ^ (__y >> 1)
	vpternlogq	$150, 3136(%rdx), %ymm2, %ymm0	#, MEM <vector(4) long unsigned int> [(long unsigned int *)this_40(D) + 3136B], vect__107.1534, vect_prephitmp_112.1539
# /usr/include/c++/13/bits/random.tcc:423: 		       ^ ((__y & 0x01) ? __a : 0));
	andl	$2567483615, %eax	#, tmp279
# /usr/include/c++/13/bits/random.tcc:416: 	  _M_x[__k] = (_M_x[__k + (__m - __n)] ^ (__y >> 1)
	vmovdqu	%ymm0, 4952(%rdx)	# vect_prephitmp_112.1539, MEM <vector(4) long unsigned int> [(long unsigned int *)this_40(D) + 4952B]
# /usr/include/c++/13/bits/random.tcc:423: 		       ^ ((__y & 0x01) ? __a : 0));
	xorq	%rcx, %rax	# tmp276, tmp280
	movq	%rax, 4984(%rdx)	# tmp280, this_40(D)->_M_x[623]
	vzeroupper
# /usr/include/c++/13/bits/random.tcc:425:     }
	ret	
	.cfi_endproc
.LFE4701:
	.size	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv, .-_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv
	.section	.text._ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEclEv,"axG",@progbits,_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEclEv,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEclEv
	.type	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEclEv, @function
_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEclEv:
.LFB4678:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	4992(%rdi), %rax	# this_13(D)->_M_p, _1
# /usr/include/c++/13/bits/random.tcc:453:     mersenne_twister_engine<_UIntType, __w, __n, __m, __r, __a, __u, __d,
	pushq	%rbx	#
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
# /usr/include/c++/13/bits/random.tcc:453:     mersenne_twister_engine<_UIntType, __w, __n, __m, __r, __a, __u, __d,
	movq	%rdi, %rbx	# tmp102, this
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, _1
	ja	.L555	#,
.L553:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rdx	#, tmp97
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	(%rbx,%rax,8), %rax	# this_13(D)->_M_x[prephitmp_47], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, 4992(%rbx)	# tmp97, this_13(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:469:     }
	popq	%rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 8
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp98
	shrq	$11, %rdx	#, tmp98
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp98, _5
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rax, %rdx	# __z, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rax	# __z, tmp99
	salq	$7, %rax	#, tmp99
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %eax	#, _7
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp100
	salq	$15, %rdx	#, tmp100
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _9
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rax, %rdx	# __z, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rax	# __z, _10
	shrq	$18, %rax	#, _10
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:469:     }
	ret	
	.p2align 4
	.p2align 3
.L555:
	.cfi_restore_state
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbx), %rax	# this_13(D)->_M_p, _1
	jmp	.L553	#
	.cfi_endproc
.LFE4678:
	.size	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEclEv, .-_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEclEv
	.section	.text._ZSt18generate_canonicalIdLm53ESt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEET_RT1_,"axG",@progbits,_ZSt18generate_canonicalIdLm53ESt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEET_RT1_,comdat
	.p2align 4
	.weak	_ZSt18generate_canonicalIdLm53ESt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEET_RT1_
	.type	_ZSt18generate_canonicalIdLm53ESt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEET_RT1_, @function
_ZSt18generate_canonicalIdLm53ESt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEET_RT1_:
.LFB4637:
	.cfi_startproc
	endbr64	
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %r12	# tmp130, __urng
	subq	$64, %rsp	#,
	.cfi_def_cfa_offset 96
# /usr/include/c++/13/bits/random.tcc:3359:       const size_t __log2r = std::log(__r) / std::log(2.0L);
	flds	.LC172(%rip)	#
# /usr/include/c++/13/bits/random.tcc:3349:     generate_canonical(_UniformRandomNumberGenerator& __urng)
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp138
	movq	%rax, 56(%rsp)	# tmp138, D.83556
	xorl	%eax, %eax	# tmp138
# /usr/include/c++/13/bits/random.tcc:3359:       const size_t __log2r = std::log(__r) / std::log(2.0L);
	fstpt	(%rsp)	# %sfp
	pushq	8(%rsp)	#
	.cfi_def_cfa_offset 104
	pushq	8(%rsp)	#
	.cfi_def_cfa_offset 112
	call	_ZSt3loge	#
	fstpt	32(%rsp)	# %sfp
# /usr/include/c++/13/bits/random.tcc:3359:       const size_t __log2r = std::log(__r) / std::log(2.0L);
	flds	.LC173(%rip)	#
	fstpt	16(%rsp)	# %sfp
	pushq	24(%rsp)	#
	.cfi_def_cfa_offset 120
	pushq	24(%rsp)	#
	.cfi_def_cfa_offset 128
	call	_ZSt3loge	#
# /usr/include/c++/13/bits/random.tcc:3359:       const size_t __log2r = std::log(__r) / std::log(2.0L);
	fldt	48(%rsp)	# %sfp
# /usr/include/c++/13/bits/random.tcc:3359:       const size_t __log2r = std::log(__r) / std::log(2.0L);
	addq	$32, %rsp	#,
	.cfi_def_cfa_offset 96
# /usr/include/c++/13/bits/random.tcc:3359:       const size_t __log2r = std::log(__r) / std::log(2.0L);
	fdivp	%st, %st(1)	#,
# /usr/include/c++/13/bits/random.tcc:3359:       const size_t __log2r = std::log(__r) / std::log(2.0L);
	flds	.LC174(%rip)	#
	fxch	%st(1)		#
	fcomi	%st(1), %st	#,
	jnb	.L557	#,
	fstp	%st(1)		#
	fisttpq	(%rsp)	# %sfp
	movq	(%rsp), %rcx	# %sfp, __log2r
.L558:
# /usr/include/c++/13/bits/random.tcc:3361: 					  (__b + __log2r - 1UL) / __log2r);
	leaq	52(%rcx), %rax	#, tmp112
# /usr/include/c++/13/bits/random.tcc:3361: 					  (__b + __log2r - 1UL) / __log2r);
	xorl	%edx, %edx	# tmp114
# /usr/include/c++/13/bits/random.tcc:3360:       const size_t __m = std::max<size_t>(1UL,
	leaq	48(%rsp), %rsi	#, tmp115
# /usr/include/c++/13/bits/random.tcc:3360:       const size_t __m = std::max<size_t>(1UL,
	movq	$1, 40(%rsp)	#, D.79809
# /usr/include/c++/13/bits/random.tcc:3361: 					  (__b + __log2r - 1UL) / __log2r);
	divq	%rcx	# __log2r
# /usr/include/c++/13/bits/random.tcc:3360:       const size_t __m = std::max<size_t>(1UL,
	leaq	40(%rsp), %rdi	#, tmp116
# /usr/include/c++/13/bits/random.tcc:3361: 					  (__b + __log2r - 1UL) / __log2r);
	movq	%rax, 48(%rsp)	# tmp113, D.79810
# /usr/include/c++/13/bits/random.tcc:3360:       const size_t __m = std::max<size_t>(1UL,
	call	_ZSt3maxImERKT_S2_S2_	#
# /usr/include/c++/13/bits/random.tcc:3360:       const size_t __m = std::max<size_t>(1UL,
	movq	(%rax), %rbp	# *_6, __m
# /usr/include/c++/13/bits/random.tcc:3365:       for (size_t __k = __m; __k != 0; --__k)
	testq	%rbp, %rbp	# __m
	je	.L562	#,
# /usr/include/c++/13/bits/random.tcc:3364:       _RealType __tmp = _RealType(1);
	movq	.LC12(%rip), %rax	#, tmp151
# /usr/include/c++/13/bits/random.tcc:3363:       _RealType __sum = _RealType(0);
	vxorpd	%xmm0, %xmm0, %xmm0	# __sum
# /usr/include/c++/13/bits/random.tcc:3364:       _RealType __tmp = _RealType(1);
	movq	%rax, (%rsp)	# tmp151, %sfp
	.p2align 4
	.p2align 3
.L560:
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	movq	%r12, %rdi	# __urng,
	vmovsd	%xmm0, 16(%rsp)	# __sum, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEclEv	#
	movq	%rax, %rbx	# tmp134, _34
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE3minEv	#
# /usr/include/c++/13/bits/random.tcc:3368: 	  __tmp *= __r;
	flds	.LC172(%rip)	#
	fmull	(%rsp)	# %sfp
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	subq	%rax, %rbx	# tmp135, tmp117
# /usr/include/c++/13/bits/random.tcc:3365:       for (size_t __k = __m; __k != 0; --__k)
	decq	%rbp	# __m
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp152
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vmovsd	16(%rsp), %xmm0	# %sfp, __sum
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rbx, %xmm4, %xmm1	# tmp117, tmp152, tmp137
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd231sd	(%rsp), %xmm1, %xmm0	# %sfp, tmp118, __sum
# /usr/include/c++/13/bits/random.tcc:3368: 	  __tmp *= __r;
	fstpl	(%rsp)	# %sfp
# /usr/include/c++/13/bits/random.tcc:3365:       for (size_t __k = __m; __k != 0; --__k)
	jne	.L560	#,
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vdivsd	(%rsp), %xmm0, %xmm0	# %sfp, __sum, <retval>
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC12(%rip), %xmm3	#, tmp156
	vcmplesd	%xmm0, %xmm3, %xmm1	#, <retval>, tmp156, tmp129
	vmovsd	.LC171(%rip), %xmm2	#, tmp127
	vblendvpd	%xmm1, %xmm2, %xmm0, %xmm0	# tmp129, tmp127, <retval>, <retval>
.L556:
# /usr/include/c++/13/bits/random.tcc:3381:     }
	movq	56(%rsp), %rax	# D.83556, tmp141
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp141
	jne	.L566	#,
	addq	$64, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4
	.p2align 3
.L557:
	.cfi_restore_state
# /usr/include/c++/13/bits/random.tcc:3359:       const size_t __log2r = std::log(__r) / std::log(2.0L);
	fsubp	%st, %st(1)	#,
	fisttpq	(%rsp)	# %sfp
	movq	(%rsp), %rcx	# %sfp, __log2r
	btcq	$63, %rcx	#, __log2r
	jmp	.L558	#
	.p2align 4
	.p2align 3
.L562:
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vxorpd	%xmm0, %xmm0, %xmm0	# <retval>
	jmp	.L556	#
.L566:
# /usr/include/c++/13/bits/random.tcc:3381:     }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE4637:
	.size	_ZSt18generate_canonicalIdLm53ESt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEET_RT1_, .-_ZSt18generate_canonicalIdLm53ESt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEET_RT1_
	.section	.text._ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEclEv.isra.0,"ax",@progbits
	.align 2
	.p2align 4
	.type	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEclEv.isra.0, @function
_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEclEv.isra.0:
.LFB4763:
	.cfi_startproc
# /usr/include/c++/13/bits/random.h:194: 	                            _Engine>(_M_g);
	jmp	_ZSt18generate_canonicalIdLm53ESt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEET_RT1_	#
	.cfi_endproc
.LFE4763:
	.size	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEclEv.isra.0, .-_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEclEv.isra.0
	.section	.text._ZNSt21binomial_distributionIiE10_M_waitingISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_id.isra.0,"axG",@progbits,_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE,comdat
	.align 2
	.p2align 4
	.type	_ZNSt21binomial_distributionIiE10_M_waitingISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_id.isra.0, @function
_ZNSt21binomial_distributionIiE10_M_waitingISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_id.isra.0:
.LFB4764:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	%esi, %ebp	# tmp114, __t
# /usr/include/c++/13/bits/random.tcc:1538: 	  __aurng(__urng);
	movq	%rdi, %rsi	# __urng,
# /usr/include/c++/13/bits/random.tcc:1531:       binomial_distribution<_IntType>::
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 64
# /usr/include/c++/13/bits/random.tcc:1535: 	_IntType __x = 0;
	xorl	%ebx, %ebx	# <retval>
# /usr/include/c++/13/bits/random.tcc:1531:       binomial_distribution<_IntType>::
	vmovsd	%xmm0, 8(%rsp)	# tmp115, %sfp
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp120
	movq	%rax, 24(%rsp)	# tmp120, D.83582
	xorl	%eax, %eax	# tmp120
# /usr/include/c++/13/bits/random.tcc:1538: 	  __aurng(__urng);
	leaq	16(%rsp), %rax	#, tmp100
	movq	%rax, %rdi	# tmp100,
	call	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEC1ERS2_	#
# /usr/include/c++/13/bits/random.tcc:1536: 	double __sum = 0.0;
	vxorpd	%xmm2, %xmm2, %xmm2	# __sum
	jmp	.L570	#
	.p2align 4
	.p2align 3
.L574:
# /usr/include/c++/13/bits/random.tcc:1544: 	    const double __e = -std::log(1.0 - __aurng());
	movq	16(%rsp), %rdi	# MEM[(struct mersenne_twister_engine & *)&__aurng],
	call	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEclEv.isra.0	#
# /usr/include/c++/13/bits/random.tcc:1544: 	    const double __e = -std::log(1.0 - __aurng());
	vmovsd	.LC12(%rip), %xmm3	#, tmp123
	vsubsd	%xmm0, %xmm3, %xmm0	# tmp116, tmp123, tmp102
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1544: 	    const double __e = -std::log(1.0 - __aurng());
	vxorpd	.LC32(%rip), %xmm0, %xmm0	#, tmp117, __e
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	movl	%ebp, %eax	# __t, tmp106
	subl	%ebx, %eax	# <retval>, tmp106
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp125
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vmovsd	(%rsp), %xmm2	# %sfp, __sum
# /usr/include/c++/13/bits/random.tcc:1548: 	while (__sum <= __q);
	vmovsd	8(%rsp), %xmm5	# %sfp, __q
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vcvtsi2sdl	%eax, %xmm4, %xmm1	# tmp106, tmp125, tmp119
# /usr/include/c++/13/bits/random.tcc:1546: 	    __x += 1;
	leal	1(%rbx), %eax	#, __x
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp107, __e, tmp108
# /usr/include/c++/13/bits/random.tcc:1545: 	    __sum += __e / (__t - __x);
	vaddsd	%xmm0, %xmm2, %xmm2	# tmp108, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:1548: 	while (__sum <= __q);
	vcomisd	%xmm2, %xmm5	# __sum, __q
	jb	.L568	#,
# /usr/include/c++/13/bits/random.tcc:1546: 	    __x += 1;
	movl	%eax, %ebx	# __x, <retval>
.L570:
	vmovsd	%xmm2, (%rsp)	# __sum, %sfp
# /usr/include/c++/13/bits/random.tcc:1542: 	    if (__t == __x)
	cmpl	%ebp, %ebx	# __t, <retval>
	jne	.L574	#,
.L568:
# /usr/include/c++/13/bits/random.tcc:1551:       }
	movq	24(%rsp), %rax	# D.83582, tmp121
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp121
	jne	.L575	#,
	addq	$40, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movl	%ebx, %eax	# <retval>,
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
.L575:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE4764:
	.size	_ZNSt21binomial_distributionIiE10_M_waitingISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_id.isra.0, .-_ZNSt21binomial_distributionIiE10_M_waitingISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_id.isra.0
	.section	.text._ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE,"axG",@progbits,_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE
	.type	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE, @function
_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE:
.LFB4417:
	.cfi_startproc
	endbr64	
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx	# tmp126, this
	subq	$48, %rsp	#,
	.cfi_def_cfa_offset 80
# /usr/include/c++/13/bits/random.tcc:1812:       normal_distribution<_RealType>::
	movq	%rdx, %rbp	# tmp128, __param
# /usr/include/c++/13/bits/random.tcc:1818: 	  __aurng(__urng);
	leaq	32(%rsp), %rdi	#, tmp105
# /usr/include/c++/13/bits/random.tcc:1812:       normal_distribution<_RealType>::
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp135
	movq	%rax, 40(%rsp)	# tmp135, D.83588
	xorl	%eax, %eax	# tmp135
# /usr/include/c++/13/bits/random.tcc:1818: 	  __aurng(__urng);
	call	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEC1ERS2_	#
# /usr/include/c++/13/bits/random.tcc:1820: 	if (_M_saved_available)
	cmpb	$0, 24(%rbx)	#, this_21(D)->_M_saved_available
	jne	.L577	#,
	movq	32(%rsp), %r12	# MEM[(struct mersenne_twister_engine & *)&__aurng], pretmp_58
	.p2align 4
	.p2align 3
.L587:
# /usr/include/c++/13/bits/random.tcc:1830: 		__x = result_type(2.0) * __aurng() - 1.0;
	movq	%r12, %rdi	# pretmp_58,
	call	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEclEv.isra.0	#
# /usr/include/c++/13/bits/random.tcc:1831: 		__y = result_type(2.0) * __aurng() - 1.0;
	movq	%r12, %rdi	# pretmp_58,
# /usr/include/c++/13/bits/random.tcc:1830: 		__x = result_type(2.0) * __aurng() - 1.0;
	vmovsd	.LC175(%rip), %xmm2	#, __x
	vfmadd213sd	.LC176(%rip), %xmm0, %xmm2	#, tmp129, __x
	vmovsd	%xmm2, 8(%rsp)	# __x, %sfp
# /usr/include/c++/13/bits/random.tcc:1831: 		__y = result_type(2.0) * __aurng() - 1.0;
	call	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEclEv.isra.0	#
# /usr/include/c++/13/bits/random.tcc:1831: 		__y = result_type(2.0) * __aurng() - 1.0;
	vmovsd	.LC175(%rip), %xmm1	#, __y
# /usr/include/c++/13/bits/random.tcc:1832: 		__r2 = __x * __x + __y * __y;
	vmovsd	8(%rsp), %xmm2	# %sfp, __x
# /usr/include/c++/13/bits/random.tcc:1831: 		__y = result_type(2.0) * __aurng() - 1.0;
	vfmadd213sd	.LC176(%rip), %xmm0, %xmm1	#, tmp130, __y
# /usr/include/c++/13/bits/random.tcc:1832: 		__r2 = __x * __x + __y * __y;
	vmulsd	%xmm1, %xmm1, %xmm3	# __y, __y, tmp110
# /usr/include/c++/13/bits/random.tcc:1832: 		__r2 = __x * __x + __y * __y;
	vfmadd231sd	%xmm2, %xmm2, %xmm3	# __x, __x, __r2
# /usr/include/c++/13/bits/random.tcc:1834: 	    while (__r2 > 1.0 || __r2 == 0.0);
	vcomisd	.LC12(%rip), %xmm3	#, __r2
	ja	.L587	#,
# /usr/include/c++/13/bits/random.tcc:1834: 	    while (__r2 > 1.0 || __r2 == 0.0);
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp140
	vucomisd	%xmm4, %xmm3	# tmp140, __r2
	jp	.L585	#,
	je	.L587	#,
.L585:
	vmovsd	%xmm1, 24(%rsp)	# __y, %sfp
	vmovsd	%xmm2, 16(%rsp)	# __x, %sfp
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	vmovsd	%xmm3, %xmm3, %xmm0	# __r2,
	vmovsd	%xmm3, 8(%rsp)	# __r2, %sfp
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	vmovsd	8(%rsp), %xmm3	# %sfp, __r2
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	vmulsd	.LC60(%rip), %xmm0, %xmm0	#, tmp131, tmp114
	vmovsd	16(%rsp), %xmm2	# %sfp, __x
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	vdivsd	%xmm3, %xmm0, %xmm0	# __r2, tmp114, _10
	vmovsd	24(%rsp), %xmm1	# %sfp, __y
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp116
	vucomisd	%xmm0, %xmm3	# _10, tmp116
	ja	.L588	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _10, __mult
.L583:
# /usr/include/c++/13/bits/random.tcc:1837: 	    _M_saved = __x * __mult;
	vmulsd	%xmm0, %xmm2, %xmm2	# __mult, __x, tmp117
# /usr/include/c++/13/bits/random.tcc:1838: 	    _M_saved_available = true;
	movb	$1, 24(%rbx)	#, this_21(D)->_M_saved_available
# /usr/include/c++/13/bits/random.tcc:1837: 	    _M_saved = __x * __mult;
	vmovsd	%xmm2, 16(%rbx)	# tmp117, this_21(D)->_M_saved
# /usr/include/c++/13/bits/random.tcc:1839: 	    __ret = __y * __mult;
	vmulsd	%xmm0, %xmm1, %xmm1	# __mult, __y, __ret
	jmp	.L579	#
	.p2align 4
	.p2align 3
.L577:
# /usr/include/c++/13/bits/random.tcc:1822: 	    _M_saved_available = false;
	movb	$0, 24(%rbx)	#, this_21(D)->_M_saved_available
# /usr/include/c++/13/bits/random.tcc:1823: 	    __ret = _M_saved;
	vmovsd	16(%rbx), %xmm1	# this_21(D)->_M_saved, __ret
.L579:
# /usr/include/c++/13/bits/random.tcc:1842: 	__ret = __ret * __param.stddev() + __param.mean();
	vmovsd	8(%rbp), %xmm0	# MEM[(double *)__param_37(D) + 8B], MEM[(double *)__param_37(D) + 8B]
	call	_ZNKSt19normal_distributionIdE10param_type6stddevEv.isra.0	#
	vmovsd	%xmm0, %xmm0, %xmm2	# tmp133, _12
# /usr/include/c++/13/bits/random.tcc:1842: 	__ret = __ret * __param.stddev() + __param.mean();
	vmovsd	0(%rbp), %xmm0	# MEM[(double *)__param_37(D)], MEM[(double *)__param_37(D)]
	call	_ZNKSt19normal_distributionIdE10param_type4meanEv.isra.0	#
# /usr/include/c++/13/bits/random.tcc:1842: 	__ret = __ret * __param.stddev() + __param.mean();
	vfmadd231sd	%xmm1, %xmm2, %xmm0	# __ret, _12, <retval>
# /usr/include/c++/13/bits/random.tcc:1844:       }
	movq	40(%rsp), %rax	# D.83588, tmp136
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp136
	jne	.L590	#,
	addq	$48, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
.L590:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
.L588:
	vmovsd	%xmm1, 16(%rsp)	# __y, %sfp
	vmovsd	%xmm2, 8(%rsp)	# __x, %sfp
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	call	sqrt@PLT	#
	vmovsd	16(%rsp), %xmm1	# %sfp, __y
	vmovsd	8(%rsp), %xmm2	# %sfp, __x
	jmp	.L583	#
	.cfi_endproc
.LFE4417:
	.size	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE, .-_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE
	.section	.text._ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_,"axG",@progbits,_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_
	.type	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_, @function
_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_:
.LFB4233:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	movq	%rdi, %rdx	# this,
	jmp	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE	#
	.cfi_endproc
.LFE4233:
	.size	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_, .-_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_
	.section	.text._ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE,"axG",@progbits,_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE
	.type	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE, @function
_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE:
.LFB4448:
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
	movq	%rdi, %r13	# tmp266, this
	pushq	%rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rsi, %r12	# tmp267, __urng
	movq	%rdx, %rbx	# tmp268, __param
	subq	$160, %rsp	#,
	.cfi_def_cfa_offset 208
# /usr/include/c++/13/bits/random.tcc:1571: 	const _IntType __t = __param.t();
	movl	(%rdx), %edi	# MEM[(int *)__param_88(D)], MEM[(int *)__param_88(D)]
# /usr/include/c++/13/bits/random.tcc:1566:       binomial_distribution<_IntType>::
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp296
	movq	%rax, 152(%rsp)	# tmp296, D.83599
	xorl	%eax, %eax	# tmp296
# /usr/include/c++/13/bits/random.tcc:1571: 	const _IntType __t = __param.t();
	call	_ZNKSt21binomial_distributionIiE10param_type1tEv.isra.0	#
# /usr/include/c++/13/bits/random.tcc:1572: 	const double __p = __param.p();
	vmovsd	8(%rdx), %xmm0	# MEM[(double *)__param_88(D) + 8B], MEM[(double *)__param_88(D) + 8B]
	call	_ZNKSt21binomial_distributionIiE10param_type1pEv.isra.0	#
# /usr/include/c++/13/bits/random.tcc:1573: 	const double __p12 = __p <= 0.5 ? __p : 1.0 - __p;
	vmovsd	.LC46(%rip), %xmm4	#, tmp303
# /usr/include/c++/13/bits/random.tcc:1571: 	const _IntType __t = __param.t();
	movl	%eax, %r14d	# tmp269, __t
# /usr/include/c++/13/bits/random.tcc:1572: 	const double __p = __param.p();
	vmovsd	%xmm0, 120(%rsp)	# __p, %sfp
# /usr/include/c++/13/bits/random.tcc:1573: 	const double __p12 = __p <= 0.5 ? __p : 1.0 - __p;
	vmovsd	%xmm0, 88(%rsp)	# __p, %sfp
# /usr/include/c++/13/bits/random.tcc:1573: 	const double __p12 = __p <= 0.5 ? __p : 1.0 - __p;
	vcomisd	%xmm0, %xmm4	# __p, tmp303
	jnb	.L593	#,
# /usr/include/c++/13/bits/random.tcc:1573: 	const double __p12 = __p <= 0.5 ? __p : 1.0 - __p;
	vmovsd	.LC12(%rip), %xmm2	#, tmp264
	vsubsd	%xmm0, %xmm2, %xmm3	# __p, tmp264, iftmp.85_82
	vmovsd	%xmm3, 88(%rsp)	# iftmp.85_82, %sfp
.L593:
# /usr/include/c++/13/bits/random.tcc:1575: 	  __aurng(__urng);
	leaq	144(%rsp), %rdi	#, tmp193
	movq	%r12, %rsi	# __urng,
	call	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEC1ERS2_	#
# /usr/include/c++/13/bits/random.tcc:1578: 	if (!__param._M_easy)
	cmpb	$0, 104(%rbx)	#, __param_88(D)->_M_easy
	jne	.L594	#,
# /usr/include/c++/13/bits/random.tcc:1586: 	      std::numeric_limits<_IntType>::max() + __naf;
	call	_ZNSt14numeric_limitsIiE3maxEv	#
# /usr/include/c++/13/bits/random.tcc:1586: 	      std::numeric_limits<_IntType>::max() + __naf;
	vxorps	%xmm0, %xmm0, %xmm0	# tmp293
	movq	144(%rsp), %rbp	# MEM[(struct mersenne_twister_engine & *)&__aurng], pretmp_187
# /usr/include/c++/13/bits/random.tcc:1592: 	    const double __a1 = __param._M_a1;
	vmovsd	64(%rbx), %xmm3	# __param_88(D)->_M_a1, __a1
# /usr/include/c++/13/bits/random.tcc:1586: 	      std::numeric_limits<_IntType>::max() + __naf;
	vcvtsi2sdl	%eax, %xmm0, %xmm1	# tmp271, tmp293, tmp294
# /usr/include/c++/13/bits/random.tcc:1588: 	    const double __np = std::floor(__t * __p12);
	vcvtsi2sdl	%r14d, %xmm0, %xmm0	# __t, tmp293, tmp295
# /usr/include/c++/13/bits/random.tcc:1585: 	    const double __thr =
	vaddsd	.LC177(%rip), %xmm1, %xmm7	#, tmp194, __thr
# /usr/include/c++/13/bits/random.tcc:1588: 	    const double __np = std::floor(__t * __p12);
	vmovsd	%xmm0, 128(%rsp)	# _4, %sfp
# /usr/include/c++/13/bits/random.tcc:1585: 	    const double __thr =
	vmovsd	%xmm7, 136(%rsp)	# __thr, %sfp
# /usr/include/c++/13/bits/random.tcc:1588: 	    const double __np = std::floor(__t * __p12);
	vmovsd	%xmm0, %xmm0, %xmm7	# tmp295, _4
	vmulsd	88(%rsp), %xmm0, %xmm0	# %sfp, _4, tmp196
	vrndscalesd	$9, %xmm0, %xmm0, %xmm5	#, tmp196, __np
	vsubsd	%xmm5, %xmm7, %xmm7	# __np, _4, tmp261
	vmovsd	%xmm5, 96(%rsp)	# __np, %sfp
# /usr/include/c++/13/bits/random.tcc:1653: 		__reject = __reject || __x < -__np || __x > __t - __np;
	vxorpd	.LC32(%rip), %xmm5, %xmm5	#, __np, tmp265
# /usr/include/c++/13/bits/random.tcc:1593: 	    const double __a12 = __a1 + __param._M_s2 * __spi_2;
	vmovsd	48(%rbx), %xmm0	# __param_88(D)->_M_s2, _6
# /usr/include/c++/13/bits/random.tcc:1594: 	    const double __a123 = __param._M_a123;
	vmovsd	72(%rbx), %xmm1	# __param_88(D)->_M_a123, __a123
# /usr/include/c++/13/bits/random.tcc:1592: 	    const double __a1 = __param._M_a1;
	vmovsd	%xmm3, 24(%rsp)	# __a1, %sfp
# /usr/include/c++/13/bits/random.tcc:1594: 	    const double __a123 = __param._M_a123;
	vmovsd	%xmm1, 56(%rsp)	# __a123, %sfp
# /usr/include/c++/13/bits/random.tcc:1593: 	    const double __a12 = __a1 + __param._M_s2 * __spi_2;
	vfmadd231sd	.LC160(%rip), %xmm0, %xmm3	#, _6, __a12
# /usr/include/c++/13/bits/random.tcc:1595: 	    const double __s1s = __param._M_s1 * __param._M_s1;
	vmovsd	40(%rbx), %xmm1	# __param_88(D)->_M_s1, _8
# /usr/include/c++/13/bits/random.tcc:1593: 	    const double __a12 = __a1 + __param._M_s2 * __spi_2;
	vmovsd	%xmm3, 32(%rsp)	# __a12, %sfp
# /usr/include/c++/13/bits/random.tcc:1595: 	    const double __s1s = __param._M_s1 * __param._M_s1;
	vmulsd	%xmm1, %xmm1, %xmm6	# _8, _8, __s1s
# /usr/include/c++/13/bits/random.tcc:1596: 	    const double __s2s = __param._M_s2 * __param._M_s2;
	vmulsd	%xmm0, %xmm0, %xmm3	# _6, _6, __s2s
	vmovsd	.LC12(%rip), %xmm4	#, tmp264
# /usr/include/c++/13/bits/random.tcc:1595: 	    const double __s1s = __param._M_s1 * __param._M_s1;
	vmovsd	%xmm6, 64(%rsp)	# __s1s, %sfp
# /usr/include/c++/13/bits/random.tcc:1596: 	    const double __s2s = __param._M_s2 * __param._M_s2;
	vmovsd	%xmm3, 72(%rsp)	# __s2s, %sfp
	vmovsd	%xmm4, 16(%rsp)	# tmp264, %sfp
	vmovsd	%xmm7, 48(%rsp)	# tmp261, %sfp
# /usr/include/c++/13/bits/random.tcc:1653: 		__reject = __reject || __x < -__np || __x > __t - __np;
	vmovsd	%xmm5, 40(%rsp)	# tmp265, %sfp
	.p2align 4
	.p2align 3
.L607:
# /usr/include/c++/13/bits/random.tcc:1601: 		const double __u = __param._M_s * __aurng();
	movq	%rbp, %rdi	# pretmp_187,
# /usr/include/c++/13/bits/random.tcc:1601: 		const double __u = __param._M_s * __aurng();
	vmovsd	80(%rbx), %xmm6	# __param_88(D)->_M_s, _10
	vmovsd	%xmm6, 8(%rsp)	# _10, %sfp
# /usr/include/c++/13/bits/random.tcc:1601: 		const double __u = __param._M_s * __aurng();
	call	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEclEv.isra.0	#
# /usr/include/c++/13/bits/random.tcc:1605: 		if (__u <= __a1)
	vmovsd	24(%rsp), %xmm7	# %sfp, __a1
# /usr/include/c++/13/bits/random.tcc:1601: 		const double __u = __param._M_s * __aurng();
	vmulsd	8(%rsp), %xmm0, %xmm0	# %sfp, tmp272, __u
# /usr/include/c++/13/bits/random.tcc:1605: 		if (__u <= __a1)
	vcomisd	%xmm0, %xmm7	# __u, __a1
	jnb	.L621	#,
# /usr/include/c++/13/bits/random.tcc:1617: 		else if (__u <= __a12)
	vmovsd	32(%rsp), %xmm5	# %sfp, __a12
	vcomisd	%xmm0, %xmm5	# __u, __a12
	jnb	.L622	#,
# /usr/include/c++/13/bits/random.tcc:1629: 		else if (__u <= __a123)
	vmovsd	56(%rsp), %xmm7	# %sfp, __a123
# /usr/include/c++/13/bits/random.tcc:1631: 		    const double __e1 = -std::log(1.0 - __aurng());
	movq	%rbp, %rdi	# pretmp_187,
# /usr/include/c++/13/bits/random.tcc:1629: 		else if (__u <= __a123)
	vcomisd	%xmm0, %xmm7	# __u, __a123
	jb	.L619	#,
# /usr/include/c++/13/bits/random.tcc:1631: 		    const double __e1 = -std::log(1.0 - __aurng());
	call	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEclEv.isra.0	#
# /usr/include/c++/13/bits/random.tcc:1631: 		    const double __e1 = -std::log(1.0 - __aurng());
	vmovsd	16(%rsp), %xmm4	# %sfp, tmp264
	vsubsd	%xmm0, %xmm4, %xmm0	# tmp281, tmp264, tmp210
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1632: 		    const double __e2 = -std::log(1.0 - __aurng());
	movq	%rbp, %rdi	# pretmp_187,
# /usr/include/c++/13/bits/random.tcc:1631: 		    const double __e1 = -std::log(1.0 - __aurng());
	vmovsd	%xmm0, 8(%rsp)	# tmp282, %sfp
# /usr/include/c++/13/bits/random.tcc:1632: 		    const double __e2 = -std::log(1.0 - __aurng());
	call	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEclEv.isra.0	#
# /usr/include/c++/13/bits/random.tcc:1632: 		    const double __e2 = -std::log(1.0 - __aurng());
	vmovsd	16(%rsp), %xmm4	# %sfp, tmp264
	vsubsd	%xmm0, %xmm4, %xmm0	# tmp283, tmp264, tmp212
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1631: 		    const double __e1 = -std::log(1.0 - __aurng());
	vmovsd	8(%rsp), %xmm1	# %sfp, _31
	vxorpd	.LC32(%rip), %xmm1, %xmm2	#, _31, __e1
# /usr/include/c++/13/bits/random.tcc:1632: 		    const double __e2 = -std::log(1.0 - __aurng());
	vmovsd	%xmm0, %xmm0, %xmm5	#, tmp284
# /usr/include/c++/13/bits/random.tcc:1635: 				     + 2 * __s1s * __e1 / __param._M_d1;
	vmovsd	64(%rsp), %xmm6	# %sfp, __s1s
# /usr/include/c++/13/bits/random.tcc:1634: 		    const double __y = __param._M_d1
	vmovsd	24(%rbx), %xmm0	# __param_88(D)->_M_d1, _34
# /usr/include/c++/13/bits/random.tcc:1635: 				     + 2 * __s1s * __e1 / __param._M_d1;
	vaddsd	%xmm6, %xmm6, %xmm4	#, __s1s, _35
# /usr/include/c++/13/bits/random.tcc:1637: 		    __v = (-__e2 + __param._M_d1 * (1 / (__t - __np)
	vmovsd	16(%rsp), %xmm7	# %sfp, tmp264
	vdivsd	48(%rsp), %xmm7, %xmm3	# %sfp, tmp264, tmp219
# /usr/include/c++/13/bits/random.tcc:1635: 				     + 2 * __s1s * __e1 / __param._M_d1;
	vmulsd	%xmm4, %xmm2, %xmm2	# _35, __e1, tmp216
# /usr/include/c++/13/bits/random.tcc:1635: 				     + 2 * __s1s * __e1 / __param._M_d1;
	vdivsd	%xmm0, %xmm2, %xmm2	# _34, tmp216, tmp217
# /usr/include/c++/13/bits/random.tcc:1634: 		    const double __y = __param._M_d1
	vaddsd	%xmm0, %xmm2, %xmm2	# _34, tmp217, __y
# /usr/include/c++/13/bits/random.tcc:1636: 		    __x = std::floor(__y);
	vrndscalesd	$9, %xmm2, %xmm2, %xmm1	#, __y, __x
# /usr/include/c++/13/bits/random.tcc:1638: 						    -__y / (2 * __s1s)));
	vdivsd	%xmm4, %xmm2, %xmm2	# _35, __y, tmp221
# /usr/include/c++/13/bits/random.tcc:1638: 						    -__y / (2 * __s1s)));
	vsubsd	%xmm2, %xmm3, %xmm2	# tmp221, tmp219, tmp222
# /usr/include/c++/13/bits/random.tcc:1637: 		    __v = (-__e2 + __param._M_d1 * (1 / (__t - __np)
	vfmadd132sd	%xmm0, %xmm5, %xmm2	# _34, tmp284, __v
.L603:
# /usr/include/c++/13/bits/random.tcc:1653: 		__reject = __reject || __x < -__np || __x > __t - __np;
	vmovsd	40(%rsp), %xmm5	# %sfp, tmp265
	vcomisd	%xmm1, %xmm5	# __x, tmp265
	ja	.L607	#,
# /usr/include/c++/13/bits/random.tcc:1653: 		__reject = __reject || __x < -__np || __x > __t - __np;
	vcomisd	48(%rsp), %xmm1	# %sfp, __x
	ja	.L607	#,
# /usr/include/c++/13/bits/random.tcc:1657: 		      std::lgamma(__np + __x + 1)
	vaddsd	96(%rsp), %xmm1, %xmm5	# %sfp, __x, _190
	vmovsd	%xmm2, 112(%rsp)	# __v, %sfp
	vmovsd	%xmm1, 104(%rsp)	# __x, %sfp
# /usr/include/c++/13/bits/random.tcc:1657: 		      std::lgamma(__np + __x + 1)
	vmovsd	%xmm5, 8(%rsp)	# _190, %sfp
	vaddsd	16(%rsp), %xmm5, %xmm0	# %sfp, _190, tmp238
	call	lgamma@PLT	#
# /usr/include/c++/13/bits/random.tcc:1658: 		      + std::lgamma(__t - (__np + __x) + 1);
	vmovsd	128(%rsp), %xmm1	# %sfp, _4
# /usr/include/c++/13/bits/random.tcc:1657: 		      std::lgamma(__np + __x + 1)
	vmovsd	%xmm0, 80(%rsp)	# tmp289, %sfp
# /usr/include/c++/13/bits/random.tcc:1658: 		      + std::lgamma(__t - (__np + __x) + 1);
	vsubsd	8(%rsp), %xmm1, %xmm0	# %sfp, _4, tmp240
# /usr/include/c++/13/bits/random.tcc:1658: 		      + std::lgamma(__t - (__np + __x) + 1);
	vaddsd	16(%rsp), %xmm0, %xmm0	# %sfp, tmp240, tmp241
	call	lgamma@PLT	#
# /usr/include/c++/13/bits/random.tcc:1660: 			     + __x * __param._M_lp1p;
	vmovsd	104(%rsp), %xmm1	# %sfp, __x
# /usr/include/c++/13/bits/random.tcc:1656: 		    const double __lfx =
	vaddsd	80(%rsp), %xmm0, %xmm3	# %sfp, tmp290, __lfx
# /usr/include/c++/13/bits/random.tcc:1599: 	    do
	vmovsd	112(%rsp), %xmm2	# %sfp, __v
# /usr/include/c++/13/bits/random.tcc:1659: 		    __reject = __v > __param._M_lf - __lfx
	vmovsd	88(%rbx), %xmm0	# __param_88(D)->_M_lf, __param_88(D)->_M_lf
	vsubsd	%xmm3, %xmm0, %xmm0	# __lfx, __param_88(D)->_M_lf, tmp244
# /usr/include/c++/13/bits/random.tcc:1660: 			     + __x * __param._M_lp1p;
	vfmadd231sd	96(%rbx), %xmm1, %xmm0	# __param_88(D)->_M_lp1p, __x, _66
# /usr/include/c++/13/bits/random.tcc:1599: 	    do
	vcomisd	%xmm0, %xmm2	# _66, __v
	ja	.L607	#,
	vmovsd	8(%rsp), %xmm5	# %sfp, _190
	vcomisd	136(%rsp), %xmm5	# %sfp, _190
	jnb	.L607	#,
# /usr/include/c++/13/bits/random.tcc:1669: 	    const _IntType __z = _M_waiting(__urng, __t - _IntType(__x),
	movl	%r14d, %esi	# __t, tmp256
# /usr/include/c++/13/bits/random.tcc:1667: 	    __x += __np + __naf;
	vmovsd	.LC177(%rip), %xmm7	#, tmp359
# /usr/include/c++/13/bits/random.tcc:1669: 	    const _IntType __z = _M_waiting(__urng, __t - _IntType(__x),
	movq	%r12, %rdi	# __urng,
# /usr/include/c++/13/bits/random.tcc:1667: 	    __x += __np + __naf;
	vaddsd	96(%rsp), %xmm7, %xmm0	# %sfp, tmp359, tmp252
# /usr/include/c++/13/bits/random.tcc:1667: 	    __x += __np + __naf;
	vaddsd	%xmm1, %xmm0, %xmm0	# __x, tmp252, __x
# /usr/include/c++/13/bits/random.tcc:1669: 	    const _IntType __z = _M_waiting(__urng, __t - _IntType(__x),
	vcvttsd2sil	%xmm0, %ebp	# __x, _71
# /usr/include/c++/13/bits/random.tcc:1669: 	    const _IntType __z = _M_waiting(__urng, __t - _IntType(__x),
	subl	%ebp, %esi	# _71, tmp256
	vmovsd	16(%rbx), %xmm0	# __param_88(D)->_M_q, __param_88(D)->_M_q
	call	_ZNSt21binomial_distributionIiE10_M_waitingISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_id.isra.0	#
# /usr/include/c++/13/bits/random.tcc:1671: 	    __ret = _IntType(__x) + __z;
	addl	%ebp, %eax	# _71, <retval>
.L608:
# /usr/include/c++/13/bits/random.tcc:1677: 	if (__p12 != __p)
	vmovsd	88(%rsp), %xmm1	# %sfp, iftmp.85_82
	vucomisd	120(%rsp), %xmm1	# %sfp, iftmp.85_82
	jp	.L616	#,
	jne	.L616	#,
.L592:
# /usr/include/c++/13/bits/random.tcc:1680:       }
	movq	152(%rsp), %rdx	# D.83599, tmp297
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp297
	jne	.L623	#,
	addq	$160, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 48
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
.L621:
	.cfi_restore_state
# /usr/include/c++/13/bits/random.tcc:1607: 		    const double __n = _M_nd(__urng);
	leaq	112(%r13), %rdi	#, tmp198
	movq	%r12, %rsi	# __urng,
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_	#
# /usr/include/c++/13/bits/random.tcc:1608: 		    const double __y = __param._M_s1 * std::abs(__n);
	vmovsd	40(%rbx), %xmm7	# __param_88(D)->_M_s1, _12
	vmovsd	%xmm7, 8(%rsp)	# _12, %sfp
# /usr/include/c++/13/bits/random.tcc:1607: 		    const double __n = _M_nd(__urng);
	vmovsd	%xmm0, 80(%rsp)	# _140, %sfp
# /usr/include/c++/13/bits/random.tcc:1608: 		    const double __y = __param._M_s1 * std::abs(__n);
	call	_ZSt3absd	#
# /usr/include/c++/13/bits/random.tcc:1608: 		    const double __y = __param._M_s1 * std::abs(__n);
	vmulsd	8(%rsp), %xmm0, %xmm1	# %sfp, tmp274, __y
# /usr/include/c++/13/bits/random.tcc:1610: 		    if (!__reject)
	vcomisd	24(%rbx), %xmm1	# __param_88(D)->_M_d1, __y
	jnb	.L607	#,
# /usr/include/c++/13/bits/random.tcc:1612: 			const double __e = -std::log(1.0 - __aurng());
	movq	%rbp, %rdi	# pretmp_187,
	vmovsd	%xmm1, 8(%rsp)	# __y, %sfp
	call	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEclEv.isra.0	#
# /usr/include/c++/13/bits/random.tcc:1612: 			const double __e = -std::log(1.0 - __aurng());
	vmovsd	16(%rsp), %xmm1	# %sfp, tmp264
	vsubsd	%xmm0, %xmm1, %xmm0	# tmp275, tmp264, tmp199
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1613: 			__x = std::floor(__y);
	vmovsd	8(%rsp), %xmm1	# %sfp, __y
# /usr/include/c++/13/bits/random.tcc:1614: 			__v = -__e - __n * __n / 2 + __param._M_c;
	vmovsd	80(%rsp), %xmm6	# %sfp, _140
# /usr/include/c++/13/bits/random.tcc:1612: 			const double __e = -std::log(1.0 - __aurng());
	vmovsd	%xmm0, %xmm0, %xmm2	#, tmp276
# /usr/include/c++/13/bits/random.tcc:1613: 			__x = std::floor(__y);
	vrndscalesd	$9, %xmm1, %xmm1, %xmm1	#, __y, __x
# /usr/include/c++/13/bits/random.tcc:1614: 			__v = -__e - __n * __n / 2 + __param._M_c;
	vmulsd	%xmm6, %xmm6, %xmm0	#, _140, tmp201
# /usr/include/c++/13/bits/random.tcc:1614: 			__v = -__e - __n * __n / 2 + __param._M_c;
	vfnmadd231sd	.LC46(%rip), %xmm0, %xmm2	#, tmp201, _19
# /usr/include/c++/13/bits/random.tcc:1614: 			__v = -__e - __n * __n / 2 + __param._M_c;
	vaddsd	56(%rbx), %xmm2, %xmm2	# __param_88(D)->_M_c, _19, __v
	jmp	.L603	#
	.p2align 4
	.p2align 3
.L619:
# /usr/include/c++/13/bits/random.tcc:1643: 		    const double __e1 = -std::log(1.0 - __aurng());
	call	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEclEv.isra.0	#
# /usr/include/c++/13/bits/random.tcc:1643: 		    const double __e1 = -std::log(1.0 - __aurng());
	vmovsd	16(%rsp), %xmm4	# %sfp, tmp264
	vsubsd	%xmm0, %xmm4, %xmm0	# tmp285, tmp264, tmp223
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1644: 		    const double __e2 = -std::log(1.0 - __aurng());
	movq	%rbp, %rdi	# pretmp_187,
# /usr/include/c++/13/bits/random.tcc:1643: 		    const double __e1 = -std::log(1.0 - __aurng());
	vmovsd	%xmm0, 8(%rsp)	# tmp286, %sfp
# /usr/include/c++/13/bits/random.tcc:1644: 		    const double __e2 = -std::log(1.0 - __aurng());
	call	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEclEv.isra.0	#
# /usr/include/c++/13/bits/random.tcc:1644: 		    const double __e2 = -std::log(1.0 - __aurng());
	vmovsd	16(%rsp), %xmm4	# %sfp, tmp264
	vsubsd	%xmm0, %xmm4, %xmm0	# tmp287, tmp264, tmp225
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1643: 		    const double __e1 = -std::log(1.0 - __aurng());
	vmovsd	8(%rsp), %xmm5	# %sfp, _44
	vxorpd	.LC32(%rip), %xmm5, %xmm2	#, _44, __e1
# /usr/include/c++/13/bits/random.tcc:1646: 		    const double __y = __param._M_d2
	vmovsd	32(%rbx), %xmm3	# __param_88(D)->_M_d2, _47
# /usr/include/c++/13/bits/random.tcc:1647: 				     + 2 * __s2s * __e1 / __param._M_d2;
	vmovsd	72(%rsp), %xmm6	# %sfp, __s2s
	vaddsd	%xmm6, %xmm6, %xmm4	#, __s2s, _48
# /usr/include/c++/13/bits/random.tcc:1647: 				     + 2 * __s2s * __e1 / __param._M_d2;
	vmulsd	%xmm4, %xmm2, %xmm2	# _48, __e1, tmp229
# /usr/include/c++/13/bits/random.tcc:1647: 				     + 2 * __s2s * __e1 / __param._M_d2;
	vdivsd	%xmm3, %xmm2, %xmm2	# _47, tmp229, tmp230
# /usr/include/c++/13/bits/random.tcc:1646: 		    const double __y = __param._M_d2
	vaddsd	%xmm3, %xmm2, %xmm2	# _47, tmp230, __y
# /usr/include/c++/13/bits/random.tcc:1648: 		    __x = std::floor(-__y);
	vxorpd	.LC32(%rip), %xmm2, %xmm1	#, __y, tmp231
# /usr/include/c++/13/bits/random.tcc:1649: 		    __v = -__e2 - __param._M_d2 * __y / (2 * __s2s);
	vmulsd	%xmm2, %xmm3, %xmm3	# __y, _47, tmp233
# /usr/include/c++/13/bits/random.tcc:1649: 		    __v = -__e2 - __param._M_d2 * __y / (2 * __s2s);
	vdivsd	%xmm4, %xmm3, %xmm3	# _48, tmp233, tmp234
# /usr/include/c++/13/bits/random.tcc:1649: 		    __v = -__e2 - __param._M_d2 * __y / (2 * __s2s);
	vsubsd	%xmm3, %xmm0, %xmm2	# tmp234, tmp288, __v
# /usr/include/c++/13/bits/random.tcc:1648: 		    __x = std::floor(-__y);
	vrndscalesd	$9, %xmm1, %xmm1, %xmm1	#, tmp231, __x
	jmp	.L603	#
	.p2align 4
	.p2align 3
.L622:
# /usr/include/c++/13/bits/random.tcc:1619: 		    const double __n = _M_nd(__urng);
	leaq	112(%r13), %rdi	#, tmp203
	movq	%r12, %rsi	# __urng,
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_	#
# /usr/include/c++/13/bits/random.tcc:1620: 		    const double __y = __param._M_s2 * std::abs(__n);
	vmovsd	48(%rbx), %xmm4	# __param_88(D)->_M_s2, _22
	vmovsd	%xmm4, 8(%rsp)	# _22, %sfp
# /usr/include/c++/13/bits/random.tcc:1619: 		    const double __n = _M_nd(__urng);
	vmovsd	%xmm0, 80(%rsp)	# _131, %sfp
# /usr/include/c++/13/bits/random.tcc:1620: 		    const double __y = __param._M_s2 * std::abs(__n);
	call	_ZSt3absd	#
# /usr/include/c++/13/bits/random.tcc:1620: 		    const double __y = __param._M_s2 * std::abs(__n);
	vmulsd	8(%rsp), %xmm0, %xmm1	# %sfp, tmp278, __y
# /usr/include/c++/13/bits/random.tcc:1622: 		    if (!__reject)
	vcomisd	32(%rbx), %xmm1	# __param_88(D)->_M_d2, __y
	jnb	.L607	#,
# /usr/include/c++/13/bits/random.tcc:1624: 			const double __e = -std::log(1.0 - __aurng());
	movq	%rbp, %rdi	# pretmp_187,
	vmovsd	%xmm1, 8(%rsp)	# __y, %sfp
	call	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEclEv.isra.0	#
# /usr/include/c++/13/bits/random.tcc:1624: 			const double __e = -std::log(1.0 - __aurng());
	vmovsd	16(%rsp), %xmm4	# %sfp, tmp264
	vsubsd	%xmm0, %xmm4, %xmm0	# tmp279, tmp264, tmp204
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1625: 			__x = std::floor(-__y);
	vmovsd	8(%rsp), %xmm1	# %sfp, __y
	vxorpd	.LC32(%rip), %xmm1, %xmm1	#, __y, tmp206
# /usr/include/c++/13/bits/random.tcc:1624: 			const double __e = -std::log(1.0 - __aurng());
	vmovsd	%xmm0, %xmm0, %xmm2	#, tmp280
# /usr/include/c++/13/bits/random.tcc:1626: 			__v = -__e - __n * __n / 2;
	vmovsd	80(%rsp), %xmm6	# %sfp, _131
	vmulsd	%xmm6, %xmm6, %xmm0	#, _131, tmp208
# /usr/include/c++/13/bits/random.tcc:1626: 			__v = -__e - __n * __n / 2;
	vfnmadd231sd	.LC46(%rip), %xmm0, %xmm2	#, tmp208, __v
# /usr/include/c++/13/bits/random.tcc:1625: 			__x = std::floor(-__y);
	vrndscalesd	$9, %xmm1, %xmm1, %xmm1	#, tmp206, __x
	jmp	.L603	#
	.p2align 4
	.p2align 3
.L616:
# /usr/include/c++/13/bits/random.tcc:1678: 	  __ret = __t - __ret;
	subl	%eax, %r14d	# <retval>, __t
	movl	%r14d, %eax	# __t, <retval>
# /usr/include/c++/13/bits/random.tcc:1679: 	return __ret;
	jmp	.L592	#
	.p2align 4
	.p2align 3
.L594:
# /usr/include/c++/13/bits/random.tcc:1675: 	  __ret = _M_waiting(__urng, __t, __param._M_q);
	movl	%r14d, %esi	# __t,
	movq	%r12, %rdi	# __urng,
	vmovsd	16(%rbx), %xmm0	# __param_88(D)->_M_q, __param_88(D)->_M_q
	call	_ZNSt21binomial_distributionIiE10_M_waitingISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_id.isra.0	#
	jmp	.L608	#
.L623:
# /usr/include/c++/13/bits/random.tcc:1680:       }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE4448:
	.size	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE, .-_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE
	.section	.text._ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_,"axG",@progbits,_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_
	.type	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_, @function
_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_:
.LFB4258:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/random.h:3981: 	{ return this->operator()(__urng, _M_param); }
	movq	%rdi, %rdx	# this,
	jmp	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE	#
	.cfi_endproc
.LFE4258:
	.size	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_, .-_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_
	.section	.text._ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0,"ax",@progbits
	.align 2
	.p2align 4
	.type	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0, @function
_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0:
.LFB4765:
	.cfi_startproc
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	leaq	RMB(%rip), %rdi	#, tmp83
	leaq	MTgen(%rip), %rsi	#, tmp84
	movq	%rdi, %rdx	# tmp83,
	jmp	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE	#
	.cfi_endproc
.LFE4765:
	.size	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0, .-_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0
	.section	.text._ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0,"ax",@progbits
	.align 2
	.p2align 4
	.type	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0, @function
_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0:
.LFB4766:
	.cfi_startproc
	pushq	%rbx	#
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rsi, %rbx	# tmp101, __p
# /usr/include/c++/13/bits/random.h:1908: 	    __aurng(__urng);
	movq	%rdi, %rsi	# __urng,
# /usr/include/c++/13/bits/random.h:1904: 	operator()(_UniformRandomNumberGenerator& __urng,
	subq	$16, %rsp	#,
	.cfi_def_cfa_offset 32
# /usr/include/c++/13/bits/random.h:1908: 	    __aurng(__urng);
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp105
	movq	%rax, 8(%rsp)	# tmp105, D.83615
	movq	%rsp, %rax	#, tmp105
	movq	%rax, %rdi	# tmp93,
	call	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEC1ERS2_	#
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	movq	(%rsp), %rdi	# MEM[(struct mersenne_twister_engine & *)&__aurng],
	call	_ZNSt8__detail8_AdaptorISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEdEclEv.isra.0	#
	vmovsd	%xmm0, %xmm0, %xmm2	# tmp102, _2
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	8(%rbx), %xmm0	# MEM[(double *)__p_3(D) + 8B], MEM[(double *)__p_3(D) + 8B]
	call	_ZNKSt25uniform_real_distributionIdE10param_type1bEv.isra.0	#
	vmovsd	%xmm0, %xmm0, %xmm1	# tmp103, _4
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	(%rbx), %xmm0	# MEM[(double *)__p_3(D)], MEM[(double *)__p_3(D)]
	call	_ZNKSt25uniform_real_distributionIdE10param_type1aEv.isra.0	#
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vsubsd	%xmm0, %xmm1, %xmm1	# tmp104, _4, tmp97
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd231sd	%xmm2, %xmm1, %xmm0	# _2, tmp97, <retval>
# /usr/include/c++/13/bits/random.h:1910: 	}
	movq	8(%rsp), %rax	# D.83615, tmp106
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp106
	jne	.L629	#,
	vzeroupper
	addq	$16, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx	#
	.cfi_def_cfa_offset 8
	ret	
.L629:
	.cfi_restore_state
	vzeroupper
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE4766:
	.size	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0, .-_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0
	.section	.text._ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0,"ax",@progbits
	.align 2
	.p2align 4
	.type	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0, @function
_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0:
.LFB4767:
	.cfi_startproc
# /usr/include/c++/13/bits/random.h:1900:         { return this->operator()(__urng, _M_param); }
	leaq	R01(%rip), %rsi	#, tmp83
	leaq	MTgen(%rip), %rdi	#, tmp84
	jmp	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0	#
	.cfi_endproc
.LFE4767:
	.size	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0, .-_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0
	.section	.text._Z18collision_electrondPdS_S_i,"axG",@progbits,_Z18collision_electrondPdS_S_i,comdat
	.p2align 4
	.weak	_Z18collision_electrondPdS_S_i
	.type	_Z18collision_electrondPdS_S_i, @function
_Z18collision_electrondPdS_S_i:
.LFB3847:
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
	movslq	%ecx, %r15	# tmp338,
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %r12	# tmp335, vxe
	subq	$152, %rsp	#,
	.cfi_def_cfa_offset 208
# collisions.h:14:     gx = (*vxe);
	vmovsd	(%rdi), %xmm1	# *vxe_106(D), gx
# collisions.h:15:     gy = (*vye);
	vmovsd	(%rsi), %xmm2	# *vye_108(D), gy
# collisions.h:17:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vmovsd	%xmm1, %xmm1, %xmm4	# gx, _3
# collisions.h:17:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vmulsd	%xmm2, %xmm2, %xmm5	# gy, gy, _2
# collisions.h:17:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vfmadd132sd	%xmm1, %xmm5, %xmm4	# gx, _2, _3
# collisions.h:16:     gz = (*vze);
	vmovsd	(%rdx), %xmm3	# *vze_110(D), gz
# collisions.h:6: inline void collision_electron (double xe, double *vxe, double *vye, double *vze, int eindex){
	vmovsd	%xmm0, 104(%rsp)	# tmp334, %sfp
	movq	%rsi, %rbp	# tmp336, vye
# collisions.h:17:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vmulsd	%xmm3, %xmm3, %xmm0	# gz, gz, _4
# collisions.h:6: inline void collision_electron (double xe, double *vxe, double *vye, double *vze, int eindex){
	movq	%rdx, %rbx	# tmp337, vze
# collisions.h:17:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vaddsd	%xmm0, %xmm4, %xmm4	# _4, _3, tmp221
	vsqrtsd	%xmm4, %xmm4, %xmm6	# tmp221, g
# collisions.h:18:     wx = F1 * (*vxe);
	vmovsd	.LC180(%rip), %xmm4	#, tmp222
# collisions.h:17:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vmovsd	%xmm6, (%rsp)	# g, %sfp
# collisions.h:19:     wy = F1 * (*vye);
	vmulsd	%xmm4, %xmm2, %xmm7	# tmp222, gy, wy
# collisions.h:18:     wx = F1 * (*vxe);
	vmulsd	%xmm4, %xmm1, %xmm6	# tmp222, gx, wx
# collisions.h:19:     wy = F1 * (*vye);
	vmovsd	%xmm7, 48(%rsp)	# wy, %sfp
# collisions.h:18:     wx = F1 * (*vxe);
	vmovsd	%xmm6, 40(%rsp)	# wx, %sfp
# collisions.h:20:     wz = F1 * (*vze);
	vmulsd	%xmm4, %xmm3, %xmm6	# tmp222, gz, wz
# collisions.h:24:     if (gx == 0) {theta = 0.5 * PI;}
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp225
# collisions.h:20:     wz = F1 * (*vze);
	vmovsd	%xmm6, 56(%rsp)	# wz, %sfp
# collisions.h:24:     if (gx == 0) {theta = 0.5 * PI;}
	vucomisd	%xmm4, %xmm1	# tmp225, gx
	jp	.L651	#,
# collisions.h:24:     if (gx == 0) {theta = 0.5 * PI;}
	vmovsd	.LC178(%rip), %xmm4	#, theta
# collisions.h:24:     if (gx == 0) {theta = 0.5 * PI;}
	jne	.L651	#,
.L632:
# collisions.h:26:     if (gy == 0) {
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp228
	vucomisd	%xmm0, %xmm2	# tmp228, gy
	jp	.L634	#,
	jne	.L634	#,
# collisions.h:27:         if (gz > 0){phi = 0.5 * PI;} else {phi = - 0.5 * PI;}
	vcomisd	%xmm0, %xmm3	# tmp228, gz
	jbe	.L658	#,
	leaq	136(%rsp), %r13	#, tmp331
	leaq	128(%rsp), %r14	#, tmp333
	vmovsd	.LC179(%rip), %xmm7	#, _279
	vmovsd	%xmm7, 32(%rsp)	# _279, %sfp
	vmovsd	.LC12(%rip), %xmm7	#, _277
	vmovsd	%xmm7, 24(%rsp)	# _277, %sfp
.L636:
	movq	%r14, %rsi	# tmp333,
	movq	%r13, %rdi	# tmp331,
	vmovsd	%xmm4, %xmm4, %xmm0	# theta,
	call	sincos@PLT	#
# collisions.h:39:     t0   =     sigma[E_ELA][eindex];
	leaq	sigma(%rip), %rdx	#, tmp235
	vmovsd	128(%rsp), %xmm7	#, sincostmp_221
	vmovsd	136(%rsp), %xmm6	#, st
	vmovsd	(%rdx,%r15,8), %xmm1	# sigma[0][eindex_126(D)], t0
	vmovsd	%xmm7, 16(%rsp)	# sincostmp_221, %sfp
# collisions.h:40:     t1   = t0 +sigma[E_EXC][eindex];
	vaddsd	8000000(%rdx,%r15,8), %xmm1, %xmm2	# sigma[1][eindex_126(D)], t0, t1
	vmovsd	%xmm1, 80(%rsp)	# t0, %sfp
# collisions.h:41:     t2   = t1 +sigma[E_ION][eindex];
	vaddsd	16000000(%rdx,%r15,8), %xmm2, %xmm3	# sigma[2][eindex_126(D)], t1, t2
	vmovsd	%xmm2, 72(%rsp)	# t1, %sfp
	vmovsd	%xmm3, 64(%rsp)	# t2, %sfp
	vmovsd	%xmm6, 8(%rsp)	# st, %sfp
# collisions.h:42:     rnd  = R01(MTgen);
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:43:     if (rnd < (t0/t2)){                              // elastic scattering
	vmovsd	64(%rsp), %xmm3	# %sfp, t2
	vmovsd	80(%rsp), %xmm1	# %sfp, t0
# collisions.h:43:     if (rnd < (t0/t2)){                              // elastic scattering
	vmovsd	72(%rsp), %xmm2	# %sfp, t1
# collisions.h:43:     if (rnd < (t0/t2)){                              // elastic scattering
	vdivsd	%xmm3, %xmm1, %xmm1	# t2, t0, tmp243
# collisions.h:43:     if (rnd < (t0/t2)){                              // elastic scattering
	vcomisd	%xmm0, %xmm1	# _131, tmp243
	ja	.L664	#,
# collisions.h:47:         energy = 0.5 * E_MASS * g * g;               // electron energy
	vmovsd	(%rsp), %xmm7	# %sfp, g
# collisions.h:46:     } else if (rnd < (t1/t2)){                       // excitation
	vdivsd	%xmm3, %xmm2, %xmm2	# t2, t1, tmp249
# collisions.h:47:         energy = 0.5 * E_MASS * g * g;               // electron energy
	vmulsd	.LC78(%rip), %xmm7, %xmm1	#, g, tmp247
# collisions.h:46:     } else if (rnd < (t1/t2)){                       // excitation
	vcomisd	%xmm0, %xmm2	# _131, tmp249
# collisions.h:47:         energy = 0.5 * E_MASS * g * g;               // electron energy
	vmulsd	%xmm7, %xmm1, %xmm1	# g, tmp247, _294
# collisions.h:46:     } else if (rnd < (t1/t2)){                       // excitation
	jbe	.L660	#,
# collisions.h:48:         energy = fabs(energy - E_EXC_TH * EV_TO_J);  // subtract energy loss for excitation
	vsubsd	.LC182(%rip), %xmm1, %xmm1	#, _294, tmp250
# collisions.h:48:         energy = fabs(energy - E_EXC_TH * EV_TO_J);  // subtract energy loss for excitation
	vandpd	.LC0(%rip), %xmm1, %xmm1	#, tmp250, energy
# collisions.h:49:         g   = sqrt(2.0 * energy / E_MASS);           // relative velocity after energy loss
	vaddsd	%xmm1, %xmm1, %xmm1	# energy, energy, tmp254
# collisions.h:49:         g   = sqrt(2.0 * energy / E_MASS);           // relative velocity after energy loss
	vdivsd	.LC52(%rip), %xmm1, %xmm1	#, tmp254, tmp255
	vsqrtsd	%xmm1, %xmm1, %xmm7	# tmp255, g
	vmovsd	%xmm7, (%rsp)	# g, %sfp
# collisions.h:50:         chi = acos(1.0 - 2.0 * R01(MTgen));          // isotropic scattering
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:50:         chi = acos(1.0 - 2.0 * R01(MTgen));          // isotropic scattering
	vmovsd	.LC12(%rip), %xmm6	#, tmp389
	vfnmadd132sd	.LC175(%rip), %xmm6, %xmm0	#, tmp389, _19
	call	acos@PLT	#
	vmovsd	%xmm0, 64(%rsp)	# tmp346, %sfp
# collisions.h:51:         eta = TWO_PI * R01(MTgen);                   // azimuthal angle
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	16(%rsp), %xmm5	# %sfp, sincostmp_221
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	8(%rsp), %xmm6	# %sfp, st
	vmovsd	32(%rsp), %xmm4	# %sfp, _279
# collisions.h:51:         eta = TWO_PI * R01(MTgen);                   // azimuthal angle
	vmulsd	.LC181(%rip), %xmm0, %xmm2	#, tmp347, eta
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm4, %xmm6, %xmm7	# _279, st, _282
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm5, %xmm4, %xmm3	# sincostmp_221, _279, _285
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	%xmm7, 72(%rsp)	# _282, %sfp
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	%xmm3, 80(%rsp)	# _285, %sfp
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmovsd	24(%rsp), %xmm3	# %sfp, _277
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm5, %xmm3, %xmm7	# sincostmp_221, _277, _291
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm3, %xmm6, %xmm6	# _277, st, _288
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmovsd	%xmm7, 96(%rsp)	# _291, %sfp
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmovsd	%xmm6, 88(%rsp)	# _288, %sfp
	vmovsd	.LC186(%rip), %xmm5	#, tmp332
.L640:
	movq	%r14, %rsi	# tmp333,
	movq	%r13, %rdi	# tmp331,
	vmovsd	%xmm5, 120(%rsp)	# tmp332, %sfp
	vmovsd	%xmm2, %xmm2, %xmm0	# eta,
	call	sincos@PLT	#
	movq	%r14, %rsi	# tmp333,
	movq	%r13, %rdi	# tmp331,
	vmovsd	128(%rsp), %xmm6	#, sincostmp_274
	vmovsd	136(%rsp), %xmm7	#, sincostmp_274
	vmovsd	%xmm6, 112(%rsp)	# sincostmp_274, %sfp
	vmovsd	%xmm7, 104(%rsp)	# sincostmp_274, %sfp
	vmovsd	64(%rsp), %xmm0	# %sfp,
	call	sincos@PLT	#
	vmovsd	136(%rsp), %xmm0	#, sincostmp_275
	vmovsd	128(%rsp), %xmm4	#, sincostmp_275
# collisions.h:91:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	112(%rsp), %xmm6	# %sfp, sincostmp_274
# collisions.h:91:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	8(%rsp), %xmm0, %xmm1	# %sfp, sincostmp_275, tmp320
# collisions.h:91:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	16(%rsp), %xmm2	# %sfp, sincostmp_221
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	72(%rsp), %xmm3	# %sfp, _282
# collisions.h:91:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm6, %xmm1, %xmm1	# sincostmp_274, tmp320, tmp321
# collisions.h:91:     gx = g * (ct * cc - st * sc * ce);
	vfmsub132sd	%xmm4, %xmm1, %xmm2	# sincostmp_275, tmp321, sincostmp_221
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	80(%rsp), %xmm0, %xmm1	# %sfp, sincostmp_275, tmp322
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm6, %xmm1, %xmm1	# sincostmp_274, tmp322, tmp323
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfmadd132sd	%xmm4, %xmm1, %xmm3	# sincostmp_275, tmp323, _282
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	104(%rsp), %xmm7	# %sfp, sincostmp_274
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	24(%rsp), %xmm0, %xmm1	# %sfp, sincostmp_275, tmp324
# collisions.h:91:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	(%rsp), %xmm5	# %sfp, g
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfnmadd132sd	%xmm7, %xmm3, %xmm1	# sincostmp_274, _78, _81
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	96(%rsp), %xmm0, %xmm3	# %sfp, sincostmp_275, tmp325
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	32(%rsp), %xmm0, %xmm0	# %sfp, sincostmp_275, tmp327
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm6, %xmm3, %xmm3	# sincostmp_274, tmp325, tmp326
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	88(%rsp), %xmm3, %xmm4	# %sfp, tmp326, _87
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm7, %xmm4, %xmm0	# sincostmp_274, _87, _90
# collisions.h:91:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm5, %xmm2, %xmm2	# g, _72, gx
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm5, %xmm1, %xmm1	# g, _81, gy
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm5, %xmm0, %xmm0	# g, _90, gz
# collisions.h:97:     (*vxe) = wx + F2 * gx;
	vmovsd	120(%rsp), %xmm5	# %sfp, tmp332
	vfmadd213sd	40(%rsp), %xmm5, %xmm2	# %sfp, tmp332, _92
# collisions.h:98:     (*vye) = wy + F2 * gy;
	vfmadd213sd	48(%rsp), %xmm5, %xmm1	# %sfp, tmp332, _94
# collisions.h:97:     (*vxe) = wx + F2 * gx;
	vmovsd	%xmm2, (%r12)	# _92, *vxe_106(D)
# collisions.h:99:     (*vze) = wz + F2 * gz;
	vfmadd213sd	56(%rsp), %xmm5, %xmm0	# %sfp, tmp332, _96
# collisions.h:98:     (*vye) = wy + F2 * gy;
	vmovsd	%xmm1, 0(%rbp)	# _94, *vye_108(D)
# collisions.h:99:     (*vze) = wz + F2 * gz;
	vmovsd	%xmm0, (%rbx)	# _96, *vze_110(D)
# collisions.h:100: }
	addq	$152, %rsp	#,
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
.L658:
	.cfi_restore_state
	vmovsd	.LC179(%rip), %xmm2	#, _279
	vmovsd	.LC176(%rip), %xmm5	#, _277
	leaq	136(%rsp), %r13	#, tmp331
	leaq	128(%rsp), %r14	#, tmp333
	vmovsd	%xmm2, 32(%rsp)	# _279, %sfp
	vmovsd	%xmm5, 24(%rsp)	# _277, %sfp
	jmp	.L636	#
	.p2align 4
	.p2align 3
.L660:
# collisions.h:54:         energy = fabs(energy - E_ION_TH * EV_TO_J);  // subtract energy loss of ionization
	vsubsd	.LC183(%rip), %xmm1, %xmm1	#, _294, tmp260
# collisions.h:54:         energy = fabs(energy - E_ION_TH * EV_TO_J);  // subtract energy loss of ionization
	vmovq	.LC0(%rip), %xmm3	#, tmp262
	vandpd	%xmm3, %xmm1, %xmm7	# tmp262, tmp260, energy
	vmovsd	%xmm7, 72(%rsp)	# energy, %sfp
# collisions.h:55:         e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:55:         e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
	vmovsd	72(%rsp), %xmm7	# %sfp, energy
# collisions.h:55:         e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
	vmovsd	%xmm0, (%rsp)	# tmp348, %sfp
# collisions.h:55:         e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
	vdivsd	.LC51(%rip), %xmm7, %xmm0	#, energy, tmp263
# collisions.h:55:         e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
	vdivsd	.LC184(%rip), %xmm0, %xmm0	#, tmp263, tmp265
	call	atan@PLT	#
# collisions.h:55:         e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
	vmulsd	(%rsp), %xmm0, %xmm0	# %sfp, tmp349, tmp267
	call	tan@PLT	#
# collisions.h:56:         e_sc = fabs(energy - e_ej);                  // energy of scattered electron after the collision
	vmovq	.LC0(%rip), %xmm3	#, tmp262
# collisions.h:55:         e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
	vmulsd	.LC17(%rip), %xmm0, %xmm1	#, tmp350, tmp268
# collisions.h:56:         e_sc = fabs(energy - e_ej);                  // energy of scattered electron after the collision
	vmovsd	72(%rsp), %xmm7	# %sfp, energy
# collisions.h:55:         e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
	vmulsd	.LC51(%rip), %xmm1, %xmm1	#, tmp268, e_ej
# collisions.h:56:         e_sc = fabs(energy - e_ej);                  // energy of scattered electron after the collision
	vsubsd	%xmm1, %xmm7, %xmm2	# e_ej, energy, tmp271
# collisions.h:56:         e_sc = fabs(energy - e_ej);                  // energy of scattered electron after the collision
	vandpd	%xmm3, %xmm2, %xmm2	# tmp262, tmp271, e_sc
# collisions.h:57:         g    = sqrt(2.0 * e_sc / E_MASS);            // relative velocity of scattered electron
	vaddsd	%xmm2, %xmm2, %xmm0	# e_sc, e_sc, tmp273
# collisions.h:57:         g    = sqrt(2.0 * e_sc / E_MASS);            // relative velocity of scattered electron
	vmovsd	.LC52(%rip), %xmm3	#, tmp275
	vdivsd	%xmm3, %xmm0, %xmm0	# tmp275, tmp273, tmp274
	vsqrtsd	%xmm0, %xmm0, %xmm6	# tmp274, g
# collisions.h:58:         g2   = sqrt(2.0 * e_ej / E_MASS);            // relative velocity of ejected electron
	vaddsd	%xmm1, %xmm1, %xmm0	# e_ej, e_ej, tmp276
# collisions.h:57:         g    = sqrt(2.0 * e_sc / E_MASS);            // relative velocity of scattered electron
	vmovsd	%xmm6, (%rsp)	# g, %sfp
# collisions.h:58:         g2   = sqrt(2.0 * e_ej / E_MASS);            // relative velocity of ejected electron
	vdivsd	%xmm3, %xmm0, %xmm0	# tmp275, tmp276, _32
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp278
	vucomisd	%xmm0, %xmm3	# _32, tmp278
	ja	.L661	#,
	vsqrtsd	%xmm0, %xmm0, %xmm6	# _32, g2
# collisions.h:59:         chi  = acos(sqrt(e_sc / energy));            // scattering angle for scattered electron
	vdivsd	%xmm7, %xmm2, %xmm2	# energy, e_sc, _224
# collisions.h:58:         g2   = sqrt(2.0 * e_ej / E_MASS);            // relative velocity of ejected electron
	vmovsd	%xmm6, 80(%rsp)	# g2, %sfp
.L645:
	vmovsd	%xmm1, 88(%rsp)	# e_ej, %sfp
# collisions.h:59:         chi  = acos(sqrt(e_sc / energy));            // scattering angle for scattered electron
	vsqrtsd	%xmm2, %xmm2, %xmm0	# _224, _34
# collisions.h:59:         chi  = acos(sqrt(e_sc / energy));            // scattering angle for scattered electron
	call	acos@PLT	#
# collisions.h:60:         chi2 = acos(sqrt(e_ej / energy));            // scattering angle for ejected electrons
	vmovsd	88(%rsp), %xmm1	# %sfp, e_ej
# collisions.h:59:         chi  = acos(sqrt(e_sc / energy));            // scattering angle for scattered electron
	vmovsd	%xmm0, 64(%rsp)	# tmp352, %sfp
# collisions.h:60:         chi2 = acos(sqrt(e_ej / energy));            // scattering angle for ejected electrons
	vdivsd	72(%rsp), %xmm1, %xmm1	# %sfp, e_ej, _35
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp279
	vucomisd	%xmm1, %xmm0	# _35, tmp279
	ja	.L662	#,
	vsqrtsd	%xmm1, %xmm1, %xmm0	# _35, _36
.L648:
# collisions.h:60:         chi2 = acos(sqrt(e_ej / energy));            // scattering angle for ejected electrons
	call	acos@PLT	#
	movq	%r14, %rsi	# tmp333,
	movq	%r13, %rdi	# tmp331,
	call	sincos@PLT	#
	vmovsd	128(%rsp), %xmm4	#, sincostmp_229
	vmovsd	136(%rsp), %xmm1	#, sincostmp_229
	vmovsd	%xmm4, 88(%rsp)	# sincostmp_229, %sfp
	vmovsd	%xmm1, 72(%rsp)	# sincostmp_229, %sfp
# collisions.h:61:         eta  = TWO_PI * R01(MTgen);                  // azimuthal angle for scattered electron
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
	movq	%r14, %rsi	# tmp333,
	movq	%r13, %rdi	# tmp331,
# collisions.h:61:         eta  = TWO_PI * R01(MTgen);                  // azimuthal angle for scattered electron
	vmulsd	.LC181(%rip), %xmm0, %xmm2	#, tmp355, eta
# collisions.h:62:         eta2 = eta + PI;                             // azimuthal angle for ejected electron
	vaddsd	.LC185(%rip), %xmm2, %xmm0	#, eta, eta2
	vmovsd	%xmm2, 120(%rsp)	# eta, %sfp
	call	sincos@PLT	#
	vmovsd	128(%rsp), %xmm6	#, sincostmp_276
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vmovsd	72(%rsp), %xmm1	# %sfp, sincostmp_229
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vmovsd	80(%rsp), %xmm9	# %sfp, g2
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vmovsd	16(%rsp), %xmm8	# %sfp, sincostmp_221
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	32(%rsp), %xmm10	# %sfp, _279
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vmovsd	88(%rsp), %xmm4	# %sfp, sincostmp_229
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm8, %xmm10, %xmm5	# sincostmp_221, _279, _285
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vmovsd	8(%rsp), %xmm2	# %sfp, st
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	%xmm5, 80(%rsp)	# _285, %sfp
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm10, %xmm2, %xmm3	# _279, st, _282
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm5, %xmm1, %xmm5	# _285, sincostmp_229, tmp289
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm6, %xmm5, %xmm5	# sincostmp_276, tmp289, tmp290
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfmadd231sd	%xmm3, %xmm4, %xmm5	# _282, sincostmp_229, _46
	vmovsd	136(%rsp), %xmm7	#, sincostmp_276
# collisions.h:70:         x_e[N_e]  = xe;                              // add new electron
	movslq	N_e(%rip), %rdx	# N_e,
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	24(%rsp), %xmm11	# %sfp, _277
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vmulsd	%xmm2, %xmm1, %xmm0	# st, sincostmp_229, tmp287
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	%xmm3, 72(%rsp)	# _282, %sfp
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm2, %xmm11, %xmm2	# st, _277, _288
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm11, %xmm1, %xmm3	# _277, sincostmp_229, tmp291
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vmulsd	%xmm6, %xmm0, %xmm0	# sincostmp_276, tmp287, tmp288
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vfmsub231sd	%xmm8, %xmm4, %xmm0	# sincostmp_221, sincostmp_229, _40
# collisions.h:75:         x_i[N_i]  = xe;                              // add new ion
	movslq	N_i(%rip), %r15	# N_i,
# collisions.h:70:         x_e[N_e]  = xe;                              // add new electron
	leaq	x_e(%rip), %rcx	#, tmp295
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmovsd	%xmm2, 88(%rsp)	# _288, %sfp
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfnmadd132sd	%xmm7, %xmm5, %xmm3	# sincostmp_276, _46, _49
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm8, %xmm11, %xmm5	# sincostmp_221, _277, _291
	vmovsd	%xmm5, 96(%rsp)	# _291, %sfp
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm5, %xmm1, %xmm5	# _291, sincostmp_229, tmp292
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm6, %xmm5, %xmm5	# sincostmp_276, tmp292, tmp293
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm2, %xmm5, %xmm4	# _288, tmp293, _55
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm10, %xmm1, %xmm1	# _279, sincostmp_229, tmp294
# collisions.h:70:         x_e[N_e]  = xe;                              // add new electron
	vmovsd	104(%rsp), %xmm6	# %sfp, xe
	vmovsd	%xmm6, (%rcx,%rdx,8)	# xe, x_e[N_e.112_59]
# collisions.h:71:         vx_e[N_e] = wx + F2 * gx;
	leaq	vx_e(%rip), %rcx	#, tmp298
# collisions.h:71:         vx_e[N_e] = wx + F2 * gx;
	vmovsd	.LC186(%rip), %xmm5	#, tmp332
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vmulsd	%xmm9, %xmm0, %xmm0	# g2, _40, gx
# collisions.h:71:         vx_e[N_e] = wx + F2 * gx;
	vfmadd213sd	40(%rsp), %xmm5, %xmm0	# %sfp, tmp332, _61
# collisions.h:71:         vx_e[N_e] = wx + F2 * gx;
	vmovsd	%xmm0, (%rcx,%rdx,8)	# _61, vx_e[N_e.112_59]
# collisions.h:72:         vy_e[N_e] = wy + F2 * gy;
	leaq	vy_e(%rip), %rcx	#, tmp301
# collisions.h:70:         x_e[N_e]  = xe;                              // add new electron
	movq	%rdx, %rax	#,
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm9, %xmm3, %xmm3	# g2, _49, gy
# collisions.h:72:         vy_e[N_e] = wy + F2 * gy;
	vfmadd213sd	48(%rsp), %xmm5, %xmm3	# %sfp, tmp332, _63
# collisions.h:72:         vy_e[N_e] = wy + F2 * gy;
	vmovsd	%xmm3, (%rcx,%rdx,8)	# _63, vy_e[N_e.112_59]
# collisions.h:73:         vz_e[N_e] = wz + F2 * gz;
	leaq	vz_e(%rip), %rcx	#, tmp304
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm7, %xmm4, %xmm1	# sincostmp_276, _55, _58
# collisions.h:74:         N_e++;
	incl	%eax	# tmp306
# collisions.h:73:         vz_e[N_e] = wz + F2 * gz;
	vmovsd	%xmm5, 112(%rsp)	# tmp332, %sfp
# collisions.h:75:         x_i[N_i]  = xe;                              // add new ion
	movl	%r15d, 104(%rsp)	# N_i.117_67, %sfp
# collisions.h:74:         N_e++;
	movl	%eax, N_e(%rip)	# tmp306, N_e
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm9, %xmm1, %xmm1	# g2, _58, gz
# collisions.h:73:         vz_e[N_e] = wz + F2 * gz;
	vfmadd213sd	56(%rsp), %xmm5, %xmm1	# %sfp, tmp332, _65
# collisions.h:73:         vz_e[N_e] = wz + F2 * gz;
	vmovsd	%xmm1, (%rcx,%rdx,8)	# _65, vz_e[N_e.112_59]
# collisions.h:75:         x_i[N_i]  = xe;                              // add new ion
	leaq	x_i(%rip), %rdx	#, tmp307
	vmovsd	%xmm6, (%rdx,%r15,8)	# xe, x_i[N_i.117_67]
# collisions.h:76:         vx_i[N_i] = RMB(MTgen);                      // velocity is sampled from background thermal distribution
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:76:         vx_i[N_i] = RMB(MTgen);                      // velocity is sampled from background thermal distribution
	leaq	vx_i(%rip), %rdx	#, tmp309
	vmovsd	%xmm0, (%rdx,%r15,8)	# tmp356, vx_i[N_i.117_67]
# collisions.h:77:         vy_i[N_i] = RMB(MTgen);
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:77:         vy_i[N_i] = RMB(MTgen);
	leaq	vy_i(%rip), %rdx	#, tmp311
	vmovsd	%xmm0, (%rdx,%r15,8)	# tmp357, vy_i[N_i.117_67]
# collisions.h:78:         vz_i[N_i] = RMB(MTgen);
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:79:         N_i++;
	movl	104(%rsp), %eax	# %sfp, N_i.117_67
# collisions.h:78:         vz_i[N_i] = RMB(MTgen);
	leaq	vz_i(%rip), %rdx	#, tmp313
	vmovsd	%xmm0, (%rdx,%r15,8)	# tmp358, vz_i[N_i.117_67]
# collisions.h:79:         N_i++;
	vmovsd	120(%rsp), %xmm2	# %sfp, eta
	vmovsd	112(%rsp), %xmm5	# %sfp, tmp332
	incl	%eax	# tmp315
	movl	%eax, N_i(%rip)	# tmp315, N_i
	jmp	.L640	#
	.p2align 4
	.p2align 3
.L664:
# collisions.h:44:         chi = acos(1.0 - 2.0 * R01(MTgen));          // isotropic scattering
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:44:         chi = acos(1.0 - 2.0 * R01(MTgen));          // isotropic scattering
	vmovsd	.LC12(%rip), %xmm5	#, tmp373
	vfnmadd132sd	.LC175(%rip), %xmm5, %xmm0	#, tmp373, _12
	call	acos@PLT	#
	vmovsd	%xmm0, 64(%rsp)	# tmp343, %sfp
# collisions.h:45:         eta = TWO_PI * R01(MTgen);                   // azimuthal angle
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	8(%rsp), %xmm7	# %sfp, st
	vmovsd	32(%rsp), %xmm4	# %sfp, _279
# collisions.h:45:         eta = TWO_PI * R01(MTgen);                   // azimuthal angle
	vmulsd	.LC181(%rip), %xmm0, %xmm2	#, tmp344, eta
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm4, %xmm7, %xmm6	# _279, st, _282
	vmovsd	.LC186(%rip), %xmm5	#, tmp332
	vmovsd	%xmm6, 72(%rsp)	# _282, %sfp
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	16(%rsp), %xmm6	# %sfp, sincostmp_221
	vmulsd	%xmm6, %xmm4, %xmm4	# sincostmp_221, _279, _285
	vmovsd	%xmm4, 80(%rsp)	# _285, %sfp
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmovsd	24(%rsp), %xmm4	# %sfp, _277
	vmulsd	%xmm4, %xmm7, %xmm7	# _277, st, _288
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm6, %xmm4, %xmm3	# sincostmp_221, _277, _291
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmovsd	%xmm7, 88(%rsp)	# _288, %sfp
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmovsd	%xmm3, 96(%rsp)	# _291, %sfp
	jmp	.L640	#
	.p2align 4
	.p2align 3
.L634:
	leaq	136(%rsp), %r13	#, tmp331
	leaq	128(%rsp), %r14	#, tmp333
	vmovsd	%xmm4, 8(%rsp)	# theta, %sfp
# collisions.h:28:     } else {phi = atan2(gz, gy);}
	vmovsd	%xmm2, %xmm2, %xmm1	# gy,
	vmovsd	%xmm3, %xmm3, %xmm0	# gz,
	call	atan2@PLT	#
	movq	%r14, %rsi	# tmp333,
	movq	%r13, %rdi	# tmp331,
	call	sincos@PLT	#
	vmovsd	136(%rsp), %xmm2	#, _277
# collisions.h:32:     cp  = cos(phi);
	vmovsd	128(%rsp), %xmm3	#, _279
	vmovsd	%xmm2, 24(%rsp)	# _277, %sfp
	vmovsd	%xmm3, 32(%rsp)	# _279, %sfp
	vmovsd	8(%rsp), %xmm4	# %sfp, theta
	jmp	.L636	#
	.p2align 4
	.p2align 3
.L651:
	vmovsd	%xmm3, 16(%rsp)	# gz, %sfp
	vmovsd	%xmm2, 8(%rsp)	# gy, %sfp
# collisions.h:25:     else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	vaddsd	%xmm0, %xmm5, %xmm0	# _4, _2, tmp227
	vsqrtsd	%xmm0, %xmm0, %xmm0	# tmp227, _7
# collisions.h:25:     else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	call	atan2@PLT	#
	vmovsd	16(%rsp), %xmm3	# %sfp, gz
	vmovsd	8(%rsp), %xmm2	# %sfp, gy
	vmovsd	%xmm0, %xmm0, %xmm4	# tmp339, theta
	jmp	.L632	#
.L661:
	vmovsd	%xmm2, 88(%rsp)	# e_sc, %sfp
	vmovsd	%xmm1, 64(%rsp)	# e_ej, %sfp
# collisions.h:58:         g2   = sqrt(2.0 * e_ej / E_MASS);            // relative velocity of ejected electron
	call	sqrt@PLT	#
# collisions.h:59:         chi  = acos(sqrt(e_sc / energy));            // scattering angle for scattered electron
	vmovsd	88(%rsp), %xmm2	# %sfp, e_sc
# collisions.h:58:         g2   = sqrt(2.0 * e_ej / E_MASS);            // relative velocity of ejected electron
	vmovsd	%xmm0, 80(%rsp)	# tmp351, %sfp
# collisions.h:59:         chi  = acos(sqrt(e_sc / energy));            // scattering angle for scattered electron
	vdivsd	72(%rsp), %xmm2, %xmm2	# %sfp, e_sc, _224
	vmovsd	64(%rsp), %xmm1	# %sfp, e_ej
	jmp	.L645	#
.L662:
# collisions.h:60:         chi2 = acos(sqrt(e_ej / energy));            // scattering angle for ejected electrons
	vmovsd	%xmm1, %xmm1, %xmm0	# _35,
	call	sqrt@PLT	#
	jmp	.L648	#
	.cfi_endproc
.LFE3847:
	.size	_Z18collision_electrondPdS_S_i, .-_Z18collision_electrondPdS_S_i
	.section	.text._Z4initi,"axG",@progbits,_Z4initi,comdat
	.p2align 4
	.weak	_Z4initi
	.type	_Z4initi, @function
_Z4initi:
.LFB3862:
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
	movslq	%edi, %rax	# tmp118,
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp	#,
	.cfi_def_cfa_offset 80
# simulation.h:11: inline void init(int nseed){
	movl	%eax, 12(%rsp)	# nseed, %sfp
# simulation.h:14:     for (i=0; i<nseed; i++){
	testl	%eax, %eax	# nseed
	jle	.L666	#,
	salq	$3, %rax	#, _27
	xorl	%ebx, %ebx	# ivtmp.1668
	leaq	x_e(%rip), %r15	#, tmp109
	leaq	vx_e(%rip), %r14	#, tmp117
	leaq	vy_e(%rip), %r13	#, tmp110
	leaq	vz_e(%rip), %r12	#, tmp111
	leaq	x_i(%rip), %rbp	#, tmp113
	movq	%rax, (%rsp)	# _27, %sfp
	.p2align 4
	.p2align 3
.L667:
# simulation.h:15:         x_e[i]  = L * R01(MTgen);               // initial random position of the electron
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# simulation.h:16:         vx_e[i] = 0; vy_e[i] = 0; vz_e[i] = 0;  // initial velocity components of the electron
	movq	$0x000000000, (%r14,%rbx)	#, MEM[(double *)&vx_e + ivtmp.1668_4 * 1]
# simulation.h:15:         x_e[i]  = L * R01(MTgen);               // initial random position of the electron
	vmulsd	.LC82(%rip), %xmm0, %xmm0	#, tmp119, tmp92
# simulation.h:16:         vx_e[i] = 0; vy_e[i] = 0; vz_e[i] = 0;  // initial velocity components of the electron
	movq	$0x000000000, 0(%r13,%rbx)	#, MEM[(double *)&vy_e + ivtmp.1668_4 * 1]
# simulation.h:15:         x_e[i]  = L * R01(MTgen);               // initial random position of the electron
	vmovsd	%xmm0, (%r15,%rbx)	# tmp92, MEM[(double *)&x_e + ivtmp.1668_4 * 1]
# simulation.h:16:         vx_e[i] = 0; vy_e[i] = 0; vz_e[i] = 0;  // initial velocity components of the electron
	movq	$0x000000000, (%r12,%rbx)	#, MEM[(double *)&vz_e + ivtmp.1668_4 * 1]
# simulation.h:17:         x_i[i]  = L * R01(MTgen);               // initial random position of the ion
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# simulation.h:18:         vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // initial velocity components of the ion
	leaq	vx_i(%rip), %rax	#, tmp125
	movq	$0x000000000, (%rax,%rbx)	#, MEM[(double *)&vx_i + ivtmp.1668_4 * 1]
# simulation.h:18:         vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // initial velocity components of the ion
	leaq	vy_i(%rip), %rax	#, tmp126
# simulation.h:17:         x_i[i]  = L * R01(MTgen);               // initial random position of the ion
	vmulsd	.LC82(%rip), %xmm0, %xmm0	#, tmp120, tmp101
# simulation.h:17:         x_i[i]  = L * R01(MTgen);               // initial random position of the ion
	vmovsd	%xmm0, 0(%rbp,%rbx)	# tmp101, MEM[(double *)&x_i + ivtmp.1668_4 * 1]
# simulation.h:18:         vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // initial velocity components of the ion
	movq	$0x000000000, (%rax,%rbx)	#, MEM[(double *)&vy_i + ivtmp.1668_4 * 1]
# simulation.h:18:         vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // initial velocity components of the ion
	leaq	vz_i(%rip), %rax	#, tmp127
	movq	$0x000000000, (%rax,%rbx)	#, MEM[(double *)&vz_i + ivtmp.1668_4 * 1]
# simulation.h:14:     for (i=0; i<nseed; i++){
	movq	(%rsp), %rax	# %sfp, _27
	addq	$8, %rbx	#, ivtmp.1668
	cmpq	%rax, %rbx	# _27, ivtmp.1668
	jne	.L667	#,
.L666:
# simulation.h:20:     N_e = nseed;    // initial number of electrons
	movl	12(%rsp), %eax	# %sfp, nseed
	movl	%eax, N_e(%rip)	# nseed, N_e
# simulation.h:21:     N_i = nseed;    // initial number of ions
	movl	%eax, N_i(%rip)	# nseed, N_i
# simulation.h:22: }
	addq	$24, %rsp	#,
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
	.cfi_endproc
.LFE3862:
	.size	_Z4initi, .-_Z4initi
	.section	.text._Z13collision_ionPdS_S_S_S_S_i.isra.0,"axG",@progbits,_Z20step8_collision_ionsi,comdat
	.p2align 4
	.type	_Z13collision_ionPdS_S_S_S_S_i.isra.0, @function
_Z13collision_ionPdS_S_S_S_S_i.isra.0:
.LFB4768:
	.cfi_startproc
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movslq	%ecx, %r13	# tmp216,
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %r12	# tmp210, vx_1
	subq	$104, %rsp	#,
	.cfi_def_cfa_offset 160
# collisions.h:110:     gx = (*vx_1)-(*vx_2);
	vmovsd	(%rdi), %xmm5	# *vx_1_1(D), _2
# collisions.h:111:     gy = (*vy_1)-(*vy_2);
	vmovsd	(%rsi), %xmm4	# *vy_1_5(D), _6
# collisions.h:110:     gx = (*vx_1)-(*vx_2);
	vsubsd	%xmm0, %xmm5, %xmm7	# ISRA.1670, _2, gx
# collisions.h:111:     gy = (*vy_1)-(*vy_2);
	vsubsd	%xmm1, %xmm4, %xmm6	# ISRA.1671, _6, gy
# collisions.h:113:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vmovsd	%xmm7, %xmm7, %xmm9	# gx, _15
# collisions.h:113:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vmulsd	%xmm6, %xmm6, %xmm10	# gy, gy, _14
# collisions.h:113:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vfmadd132sd	%xmm7, %xmm10, %xmm9	# gx, _14, _15
# collisions.h:112:     gz = (*vz_1)-(*vz_2);
	vmovsd	(%rdx), %xmm3	# *vz_1_9(D), _10
# collisions.h:114:     wx = 0.5 * ((*vx_1) + (*vx_2));
	vaddsd	%xmm0, %xmm5, %xmm5	# ISRA.1670, _2, tmp160
# collisions.h:112:     gz = (*vz_1)-(*vz_2);
	vsubsd	%xmm2, %xmm3, %xmm8	# ISRA.1672, _10, gz
# collisions.h:114:     wx = 0.5 * ((*vx_1) + (*vx_2));
	vmulsd	.LC46(%rip), %xmm5, %xmm5	#, tmp160, wx
# collisions.h:113:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vmulsd	%xmm8, %xmm8, %xmm11	# gz, gz, _16
# collisions.h:115:     wy = 0.5 * ((*vy_1) + (*vy_2));
	vaddsd	%xmm1, %xmm4, %xmm4	# ISRA.1671, _6, tmp162
# collisions.h:116:     wz = 0.5 * ((*vz_1) + (*vz_2));
	vaddsd	%xmm2, %xmm3, %xmm2	# ISRA.1672, _10, tmp164
# collisions.h:115:     wy = 0.5 * ((*vy_1) + (*vy_2));
	vmulsd	.LC46(%rip), %xmm4, %xmm4	#, tmp162, wy
# collisions.h:116:     wz = 0.5 * ((*vz_1) + (*vz_2));
	vmulsd	.LC46(%rip), %xmm2, %xmm3	#, tmp164, wz
# collisions.h:120:     if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp166
# collisions.h:102: inline void collision_ion (double *vx_1, double *vy_1, double *vz_1,
	movq	%rsi, %rbp	# tmp211, vy_1
	movq	%rdx, %rbx	# tmp212, vz_1
# collisions.h:113:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vaddsd	%xmm11, %xmm9, %xmm9	# _16, _15, tmp159
# collisions.h:114:     wx = 0.5 * ((*vx_1) + (*vx_2));
	vmovsd	%xmm5, 8(%rsp)	# wx, %sfp
# collisions.h:113:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vsqrtsd	%xmm9, %xmm9, %xmm13	# tmp159, g
# collisions.h:115:     wy = 0.5 * ((*vy_1) + (*vy_2));
	vmovsd	%xmm4, 16(%rsp)	# wy, %sfp
# collisions.h:113:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vmovsd	%xmm13, (%rsp)	# g, %sfp
# collisions.h:116:     wz = 0.5 * ((*vz_1) + (*vz_2));
	vmovsd	%xmm3, 24(%rsp)	# wz, %sfp
# collisions.h:120:     if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	vucomisd	%xmm0, %xmm7	# tmp166, gx
	jp	.L682	#,
# collisions.h:120:     if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	movq	.LC178(%rip), %r14	#, theta
# collisions.h:120:     if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	jne	.L682	#,
.L671:
# collisions.h:121:     if (gy == 0) {
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp169
	vucomisd	%xmm0, %xmm6	# tmp169, gy
	jp	.L673	#,
	jne	.L673	#,
# collisions.h:122:         if (gz > 0){phi = 0.5 * PI;} else {phi = - 0.5 * PI;}
	vcmpnltsd	%xmm8, %xmm0, %xmm0	#, gz, tmp169, tmp209
	vmovsd	.LC187(%rip), %xmm2	#, tmp207
	vmovsd	.LC178(%rip), %xmm1	#, tmp208
	vblendvpd	%xmm0, %xmm2, %xmm1, %xmm6	# tmp209, tmp207, tmp208, phi
	vmovsd	%xmm6, 32(%rsp)	# phi, %sfp
.L675:
# collisions.h:127:     t1  =      sigma[I_ISO][e_index];
	leaq	sigma(%rip), %rax	#, tmp172
	vmovsd	24000000(%rax,%r13,8), %xmm1	# sigma[3][e_index_29(D)], t1
# collisions.h:128:     t2  = t1 + sigma[I_BACK][e_index];
	vaddsd	32000000(%rax,%r13,8), %xmm1, %xmm6	# sigma[4][e_index_29(D)], t1, t2
	vmovsd	%xmm1, 48(%rsp)	# t1, %sfp
	vmovsd	%xmm6, 40(%rsp)	# t2, %sfp
# collisions.h:129:     rnd = R01(MTgen);
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:130:     if  (rnd < (t1 /t2)){                        // isotropic scattering
	vmovsd	48(%rsp), %xmm1	# %sfp, t1
	vdivsd	40(%rsp), %xmm1, %xmm1	# %sfp, t1, tmp178
# collisions.h:130:     if  (rnd < (t1 /t2)){                        // isotropic scattering
	vcomisd	%xmm0, %xmm1	# tmp219, tmp178
	ja	.L688	#,
# collisions.h:133:         chi = PI;                                // scattering angle
	vmovsd	.LC185(%rip), %xmm5	#, chi
	vmovsd	%xmm5, 40(%rsp)	# chi, %sfp
.L677:
	leaq	88(%rsp), %r13	#, tmp181
	leaq	80(%rsp), %r15	#, tmp182
	vmovsd	32(%rsp), %xmm0	# %sfp,
	movq	%r15, %rsi	# tmp182,
	movq	%r13, %rdi	# tmp181,
	call	sincos@PLT	#
	movq	%r15, %rsi	# tmp182,
	movq	%r13, %rdi	# tmp181,
	vmovq	%r14, %xmm0	# theta,
	vmovsd	80(%rsp), %xmm7	#, sincostmp_11
	vmovsd	88(%rsp), %xmm9	#, sincostmp_11
	vmovsd	%xmm7, 72(%rsp)	# sincostmp_11, %sfp
	vmovsd	%xmm9, 64(%rsp)	# sincostmp_11, %sfp
	call	sincos@PLT	#
	movq	%r15, %rsi	# tmp182,
	movq	%r13, %rdi	# tmp181,
	vmovsd	80(%rsp), %xmm1	#, sincostmp_101
	vmovsd	88(%rsp), %xmm5	#, sincostmp_101
	vmovsd	%xmm1, 56(%rsp)	# sincostmp_101, %sfp
	vmovsd	%xmm5, 48(%rsp)	# sincostmp_101, %sfp
	vmovsd	40(%rsp), %xmm0	# %sfp,
	call	sincos@PLT	#
	vmovsd	80(%rsp), %xmm4	#, sincostmp_102
	vmovsd	88(%rsp), %xmm3	#, sincostmp_102
	vmovsd	%xmm4, 40(%rsp)	# sincostmp_102, %sfp
	vmovsd	%xmm3, 32(%rsp)	# sincostmp_102, %sfp
# collisions.h:135:     eta = TWO_PI * R01(MTgen);                   // azimuthal angle
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
	movq	%r15, %rsi	# tmp182,
	movq	%r13, %rdi	# tmp181,
# collisions.h:135:     eta = TWO_PI * R01(MTgen);                   // azimuthal angle
	vmulsd	.LC181(%rip), %xmm0, %xmm0	#, tmp222, eta
	call	sincos@PLT	#
	vmovsd	80(%rsp), %xmm8	#, sincostmp_7
# collisions.h:147:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	32(%rsp), %xmm3	# %sfp, sincostmp_102
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	72(%rsp), %xmm7	# %sfp, sincostmp_11
# collisions.h:147:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	48(%rsp), %xmm5	# %sfp, sincostmp_101
# collisions.h:147:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	40(%rsp), %xmm4	# %sfp, sincostmp_102
	vmovsd	56(%rsp), %xmm1	# %sfp, sincostmp_101
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	64(%rsp), %xmm9	# %sfp, sincostmp_11
# collisions.h:147:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm5, %xmm3, %xmm0	# sincostmp_101, sincostmp_102, tmp191
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm7, %xmm5, %xmm10	# sincostmp_11, sincostmp_101, tmp193
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm7, %xmm1, %xmm2	# sincostmp_11, sincostmp_101, tmp194
# collisions.h:147:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm8, %xmm0, %xmm0	# sincostmp_7, tmp191, tmp192
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm3, %xmm2, %xmm2	# sincostmp_102, tmp194, tmp195
# collisions.h:147:     gx = g * (ct * cc - st * sc * ce);
	vfmsub231sd	%xmm1, %xmm4, %xmm0	# sincostmp_101, sincostmp_102, _55
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm8, %xmm2, %xmm2	# sincostmp_7, tmp195, tmp196
# collisions.h:149:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm9, %xmm5, %xmm5	# sincostmp_11, sincostmp_101, tmp198
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfmadd132sd	%xmm4, %xmm2, %xmm10	# sincostmp_102, tmp196, _62
# collisions.h:149:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm9, %xmm1, %xmm1	# sincostmp_11, sincostmp_101, tmp199
# collisions.h:149:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm3, %xmm1, %xmm1	# sincostmp_102, tmp199, tmp200
# collisions.h:149:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm8, %xmm1, %xmm1	# sincostmp_7, tmp200, tmp201
# collisions.h:149:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm5, %xmm1, %xmm4	# tmp198, tmp201, _72
	vmovsd	88(%rsp), %xmm6	#, sincostmp_7
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm9, %xmm3, %xmm2	# sincostmp_11, sincostmp_102, tmp197
# collisions.h:149:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm7, %xmm3, %xmm3	# sincostmp_11, sincostmp_102, tmp202
# collisions.h:147:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	(%rsp), %xmm12	# %sfp, g
# collisions.h:153:     (*vx_1) = wx + 0.5 * gx;
	vmovsd	.LC46(%rip), %xmm7	#, tmp237
# collisions.h:147:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm12, %xmm0, %xmm0	# g, _55, gx
# collisions.h:153:     (*vx_1) = wx + 0.5 * gx;
	vfmadd213sd	8(%rsp), %xmm7, %xmm0	# %sfp, tmp237, _78
# collisions.h:153:     (*vx_1) = wx + 0.5 * gx;
	vmovsd	%xmm0, (%r12)	# _78, *vx_1_1(D)
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfnmadd132sd	%xmm6, %xmm10, %xmm2	# sincostmp_7, _62, _65
# collisions.h:149:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm3, %xmm4, %xmm6	# tmp202, _72, _75
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm12, %xmm2, %xmm2	# g, _65, gy
# collisions.h:154:     (*vy_1) = wy + 0.5 * gy;
	vfmadd213sd	16(%rsp), %xmm7, %xmm2	# %sfp, tmp239, _80
# collisions.h:154:     (*vy_1) = wy + 0.5 * gy;
	vmovsd	%xmm2, 0(%rbp)	# _80, *vy_1_5(D)
# collisions.h:149:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm12, %xmm6, %xmm1	# g, _75, gz
# collisions.h:155:     (*vz_1) = wz + 0.5 * gz;
	vfmadd213sd	24(%rsp), %xmm7, %xmm1	# %sfp, tmp241, _82
# collisions.h:155:     (*vz_1) = wz + 0.5 * gz;
	vmovsd	%xmm1, (%rbx)	# _82, *vz_1_9(D)
# collisions.h:156: }
	addq	$104, %rsp	#,
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
.L682:
	.cfi_restore_state
	vmovsd	%xmm8, 40(%rsp)	# gz, %sfp
	vmovsd	%xmm6, 32(%rsp)	# gy, %sfp
# collisions.h:120:     if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	vaddsd	%xmm11, %xmm10, %xmm0	# _16, _14, tmp168
# collisions.h:120:     if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	vmovsd	%xmm7, %xmm7, %xmm1	# gx,
# collisions.h:120:     if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	vsqrtsd	%xmm0, %xmm0, %xmm0	# tmp168, _26
# collisions.h:120:     if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	call	atan2@PLT	#
	vmovsd	40(%rsp), %xmm8	# %sfp, gz
	vmovsd	32(%rsp), %xmm6	# %sfp, gy
	vmovq	%xmm0, %r14	# tmp217, theta
	jmp	.L671	#
	.p2align 4
	.p2align 3
.L688:
# collisions.h:131:         chi = acos(1.0 - 2.0 * R01(MTgen));      // scattering angle
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:131:         chi = acos(1.0 - 2.0 * R01(MTgen));      // scattering angle
	vmovsd	.LC12(%rip), %xmm6	#, tmp232
	vfnmadd132sd	.LC175(%rip), %xmm6, %xmm0	#, tmp232, _37
	call	acos@PLT	#
	vmovsd	%xmm0, 40(%rsp)	# tmp221, %sfp
	jmp	.L677	#
	.p2align 4
	.p2align 3
.L673:
# collisions.h:123:     } else {phi = atan2(gz, gy);}
	vmovsd	%xmm6, %xmm6, %xmm1	# gy,
	vmovsd	%xmm8, %xmm8, %xmm0	# gz,
	call	atan2@PLT	#
	vmovsd	%xmm0, 32(%rsp)	# tmp218, %sfp
	jmp	.L675	#
	.cfi_endproc
.LFE4768:
	.size	_Z13collision_ionPdS_S_S_S_S_i.isra.0, .-_Z13collision_ionPdS_S_S_S_S_i.isra.0
	.section	.text._ZSt11__addressofIiEPT_RS0_,"axG",@progbits,_ZSt11__addressofIiEPT_RS0_,comdat
	.p2align 4
	.weak	_ZSt11__addressofIiEPT_RS0_
	.type	_ZSt11__addressofIiEPT_RS0_, @function
_ZSt11__addressofIiEPT_RS0_:
.LFB4703:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/move.h:51:     __addressof(_Tp& __r) _GLIBCXX_NOEXCEPT
	movq	%rdi, %rax	# tmp85, __r
# /usr/include/c++/13/bits/move.h:52:     { return __builtin_addressof(__r); }
	ret	
	.cfi_endproc
.LFE4703:
	.size	_ZSt11__addressofIiEPT_RS0_, .-_ZSt11__addressofIiEPT_RS0_
	.section	.text._ZSt10_ConstructIiJEEvPT_DpOT0_,"axG",@progbits,_ZSt10_ConstructIiJEEvPT_DpOT0_,comdat
	.p2align 4
	.weak	_ZSt10_ConstructIiJEEvPT_DpOT0_
	.type	_ZSt10_ConstructIiJEEvPT_DpOT0_, @function
_ZSt10_ConstructIiJEEvPT_DpOT0_:
.LFB4704:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	call	_ZnwmPv.isra.0	#
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movl	$0, (%rax)	#, MEM[(int *)_3]
# /usr/include/c++/13/bits/stl_construct.h:120:     }
	ret	
	.cfi_endproc
.LFE4704:
	.size	_ZSt10_ConstructIiJEEvPT_DpOT0_, .-_ZSt10_ConstructIiJEEvPT_DpOT0_
	.section	.text._ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPimEET_S3_T0_,"axG",@progbits,_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPimEET_S3_T0_,comdat
	.p2align 4
	.weak	_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPimEET_S3_T0_
	.type	_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPimEET_S3_T0_, @function
_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPimEET_S3_T0_:
.LFB4680:
	.cfi_startproc
	endbr64	
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
# /usr/include/c++/13/bits/stl_uninitialized.h:660:         __uninit_default_n(_ForwardIterator __first, _Size __n)
	movq	%rdi, %rbx	# tmp93, __first
# /usr/include/c++/13/bits/stl_uninitialized.h:662: 	  if (__n > 0)
	testq	%rsi, %rsi	# __n
	jne	.L694	#,
# /usr/include/c++/13/bits/stl_uninitialized.h:671: 	}
	popq	%rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	movq	%rdi, %rax	# __first,
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4
	.p2align 3
.L694:
	.cfi_restore_state
	movq	%rsi, %rbp	# tmp94, __n
# /usr/include/c++/13/bits/stl_uninitialized.h:665: 		= std::__addressof(*__first);
	call	_ZSt11__addressofIiEPT_RS0_	#
	movq	%rax, %r12	# tmp95, __val
# /usr/include/c++/13/bits/stl_uninitialized.h:666: 	      std::_Construct(__val);
	movq	%rax, %rdi	# __val,
	call	_ZSt10_ConstructIiJEEvPT_DpOT0_	#
# /usr/include/c++/13/bits/stl_uninitialized.h:668: 	      __first = std::fill_n(__first, __n - 1, *__val);
	movl	(%r12), %edx	# MEM[(const int &)__val_7], MEM[(const int &)__val_7]
	leaq	-1(%rbp), %rsi	#, tmp90
# /usr/include/c++/13/bits/stl_uninitialized.h:667: 	      ++__first;
	leaq	4(%rbx), %rdi	#, __first
# /usr/include/c++/13/bits/stl_uninitialized.h:671: 	}
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
# /usr/include/c++/13/bits/stl_uninitialized.h:668: 	      __first = std::fill_n(__first, __n - 1, *__val);
	jmp	_ZSt6fill_nIPimiET_S1_T0_RKT1_.isra.0	#
	.cfi_endproc
.LFE4680:
	.size	_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPimEET_S3_T0_, .-_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPimEET_S3_T0_
	.section	.text._ZSt25__uninitialized_default_nIPimET_S1_T0_,"axG",@progbits,_ZSt25__uninitialized_default_nIPimET_S1_T0_,comdat
	.p2align 4
	.weak	_ZSt25__uninitialized_default_nIPimET_S1_T0_
	.type	_ZSt25__uninitialized_default_nIPimET_S1_T0_, @function
_ZSt25__uninitialized_default_nIPimET_S1_T0_:
.LFB4646:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_uninitialized.h:712: 	__uninit_default_n(__first, __n);
	jmp	_ZNSt27__uninitialized_default_n_1ILb1EE18__uninit_default_nIPimEET_S3_T0_	#
	.cfi_endproc
.LFE4646:
	.size	_ZSt25__uninitialized_default_nIPimET_S1_T0_, .-_ZSt25__uninitialized_default_nIPimET_S1_T0_
	.section	.text._ZSt27__uninitialized_default_n_aIPimiET_S1_T0_RSaIT1_E.isra.0,"axG",@progbits,_ZNSt6vectorIiSaIiEE17_M_default_appendEm,comdat
	.p2align 4
	.type	_ZSt27__uninitialized_default_n_aIPimiET_S1_T0_RSaIT1_E.isra.0, @function
_ZSt27__uninitialized_default_n_aIPimiET_S1_T0_RSaIT1_E.isra.0:
.LFB4769:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_uninitialized.h:779:     { return std::__uninitialized_default_n(__first, __n); }
	jmp	_ZSt25__uninitialized_default_nIPimET_S1_T0_	#
	.cfi_endproc
.LFE4769:
	.size	_ZSt27__uninitialized_default_n_aIPimiET_S1_T0_RSaIT1_E.isra.0, .-_ZSt27__uninitialized_default_n_aIPimiET_S1_T0_RSaIT1_E.isra.0
	.section	.rodata._ZNSt6vectorIiSaIiEE17_M_default_appendEm.str1.1,"aMS",@progbits,1
.LC188:
	.string	"vector::_M_default_append"
	.section	.text._ZNSt6vectorIiSaIiEE17_M_default_appendEm,"axG",@progbits,_ZNSt6vectorIiSaIiEE17_M_default_appendEm,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIiSaIiEE17_M_default_appendEm
	.type	_ZNSt6vectorIiSaIiEE17_M_default_appendEm, @function
_ZNSt6vectorIiSaIiEE17_M_default_appendEm:
.LFB4430:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/vector.tcc:637:       if (__n != 0)
	testq	%rsi, %rsi	# __n
	je	.L705	#,
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
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbp	# tmp126, this
	subq	$24, %rsp	#,
	.cfi_def_cfa_offset 80
	movq	8(%rdi), %r13	# MEM[(int * *)this_25(D) + 8B], _43
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	movq	16(%rdi), %rax	# this_25(D)->D.71714._M_impl.D.71053._M_end_of_storage, tmp108
	movq	(%rdi), %r14	# MEM[(int * *)this_25(D)], _42
	movq	%rsi, %rbx	# tmp127, __n
	subq	%r13, %rax	# _43, tmp108
	sarq	$2, %rax	#, __navail
# /usr/include/c++/13/bits/vector.tcc:646: 	  if (__navail >= __n)
	cmpq	%rsi, %rax	# __n, __navail
	jnb	.L708	#,
# /usr/include/c++/13/bits/vector.tcc:639: 	  const size_type __size = size();
	movq	%r13, %rsi	# _43,
	movq	%r14, %rdi	# _42,
# /usr/include/c++/13/bits/vector.tcc:662: 		_M_check_len(__n, "vector::_M_default_append");
	leaq	.LC188(%rip), %rdx	#, tmp112
# /usr/include/c++/13/bits/vector.tcc:639: 	  const size_type __size = size();
	call	_ZNKSt6vectorIiSaIiEE4sizeEv.isra.0	#
# /usr/include/c++/13/bits/vector.tcc:662: 		_M_check_len(__n, "vector::_M_default_append");
	movq	%rbx, %rsi	# __n,
	movq	%rbp, %rdi	# this,
# /usr/include/c++/13/bits/vector.tcc:639: 	  const size_type __size = size();
	movq	%rax, %r15	# tmp129, __size
# /usr/include/c++/13/bits/vector.tcc:662: 		_M_check_len(__n, "vector::_M_default_append");
	call	_ZNKSt6vectorIiSaIiEE12_M_check_lenEmPKc	#
# /usr/include/c++/13/bits/vector.tcc:663: 	      pointer __new_start(this->_M_allocate(__len));
	movq	%rax, %rdi	# _30,
	movq	%rax, 8(%rsp)	# _30, %sfp
	call	_ZNSt12_Vector_baseIiSaIiEE11_M_allocateEm.isra.0	#
# /usr/include/c++/13/bits/vector.tcc:668: 		      std::__uninitialized_default_n_a(__new_start + __size,
	movq	%rbx, %rsi	# __n,
# /usr/include/c++/13/bits/vector.tcc:706: 	      this->_M_impl._M_finish = __new_start + __size + __n;
	addq	%r15, %rbx	# __size, tmp121
# /usr/include/c++/13/bits/vector.tcc:663: 	      pointer __new_start(this->_M_allocate(__len));
	movq	%rax, %r12	# tmp131, tmp113
# /usr/include/c++/13/bits/vector.tcc:668: 		      std::__uninitialized_default_n_a(__new_start + __size,
	leaq	(%rax,%r15,4), %rdi	#, tmp115
	call	_ZSt27__uninitialized_default_n_aIPimiET_S1_T0_RSaIT1_E.isra.0	#
# /usr/include/c++/13/bits/vector.tcc:676: 		  _S_relocate(__old_start, __old_finish,
	movq	%r12, %rdx	# tmp113,
	movq	%r13, %rsi	# _43,
	movq	%r14, %rdi	# _42,
	call	_ZNSt6vectorIiSaIiEE11_S_relocateEPiS2_S2_RS0_.isra.0	#
# /usr/include/c++/13/bits/vector.tcc:704: 			    this->_M_impl._M_end_of_storage - __old_start);
	movq	16(%rbp), %rsi	# this_25(D)->D.71714._M_impl.D.71053._M_end_of_storage, tmp116
# /usr/include/c++/13/bits/vector.tcc:703: 	      _M_deallocate(__old_start,
	movq	%r14, %rdi	# _42,
# /usr/include/c++/13/bits/vector.tcc:704: 			    this->_M_impl._M_end_of_storage - __old_start);
	subq	%r14, %rsi	# _42, tmp116
	sarq	$2, %rsi	#, tmp119
# /usr/include/c++/13/bits/vector.tcc:703: 	      _M_deallocate(__old_start,
	call	_ZNSt12_Vector_baseIiSaIiEE13_M_deallocateEPim.isra.0	#
# /usr/include/c++/13/bits/vector.tcc:707: 	      this->_M_impl._M_end_of_storage = __new_start + __len;
	movq	8(%rsp), %rcx	# %sfp, _30
# /usr/include/c++/13/bits/vector.tcc:706: 	      this->_M_impl._M_finish = __new_start + __size + __n;
	leaq	(%r12,%rbx,4), %rax	#, tmp123
# /usr/include/c++/13/bits/vector.tcc:705: 	      this->_M_impl._M_start = __new_start;
	vmovq	%r12, %xmm1	# tmp113, tmp113
	vpinsrq	$1, %rax, %xmm1, %xmm0	# tmp123, tmp113, tmp120
	vmovdqu	%xmm0, 0(%rbp)	# tmp120, MEM <vector(2) long unsigned int> [(int * *)this_25(D)]
# /usr/include/c++/13/bits/vector.tcc:707: 	      this->_M_impl._M_end_of_storage = __new_start + __len;
	leaq	(%r12,%rcx,4), %rax	#, tmp125
	movq	%rax, 16(%rbp)	# tmp125, this_25(D)->D.71714._M_impl.D.71053._M_end_of_storage
# /usr/include/c++/13/bits/vector.tcc:710:     }
	addq	$24, %rsp	#,
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
.L705:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret	
	.p2align 4
	.p2align 3
.L708:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
# /usr/include/c++/13/bits/vector.tcc:650: 		std::__uninitialized_default_n_a(this->_M_impl._M_finish,
	movq	%r13, %rdi	# _43,
	call	_ZSt27__uninitialized_default_n_aIPimiET_S1_T0_RSaIT1_E.isra.0	#
# /usr/include/c++/13/bits/vector.tcc:649: 	      this->_M_impl._M_finish =
	movq	%rax, 8(%rbp)	# tmp128, this_25(D)->D.71714._M_impl.D.71053._M_finish
# /usr/include/c++/13/bits/vector.tcc:710:     }
	addq	$24, %rsp	#,
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
	.cfi_endproc
.LFE4430:
	.size	_ZNSt6vectorIiSaIiEE17_M_default_appendEm, .-_ZNSt6vectorIiSaIiEE17_M_default_appendEm
	.section	.text._ZNSt6vectorIiSaIiEE6resizeEm,"axG",@progbits,_ZNSt6vectorIiSaIiEE6resizeEm,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIiSaIiEE6resizeEm
	.type	_ZNSt6vectorIiSaIiEE6resizeEm, @function
_ZNSt6vectorIiSaIiEE6resizeEm:
.LFB4247:
	.cfi_startproc
	endbr64	
	movq	%rdi, %rcx	# tmp94, this
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 16
# /usr/include/c++/13/bits/stl_vector.h:1013:       resize(size_type __new_size)
	movq	%rsi, %rdx	# tmp95, __new_size
	movq	(%rdi), %rdi	# MEM[(int * *)this_8(D)], _12
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	movq	8(%rcx), %rsi	# MEM[(int * *)this_8(D) + 8B], MEM[(int * *)this_8(D) + 8B]
	call	_ZNKSt6vectorIiSaIiEE4sizeEv.isra.0	#
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rdx, %rax	# __new_size, _1
	jb	.L714	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rdx	# _1, __new_size
	jb	.L715	#,
# /usr/include/c++/13/bits/stl_vector.h:1019:       }
	addq	$8, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4
	.p2align 3
.L715:
	.cfi_restore_state
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	leaq	(%rdi,%rdx,4), %rsi	#, tmp93
# /usr/include/c++/13/bits/stl_vector.h:1019:       }
	addq	$8, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 8
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	movq	%rcx, %rdi	# this,
	jmp	_ZNSt6vectorIiSaIiEE15_M_erase_at_endEPi	#
	.p2align 4
	.p2align 3
.L714:
	.cfi_restore_state
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rdx	# _1, __new_size
	movq	%rcx, %rdi	# this,
# /usr/include/c++/13/bits/stl_vector.h:1019:       }
	addq	$8, %rsp	#,
	.cfi_def_cfa_offset 8
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	movq	%rdx, %rsi	# __new_size, tmp91
	jmp	_ZNSt6vectorIiSaIiEE17_M_default_appendEm	#
	.cfi_endproc
.LFE4247:
	.size	_ZNSt6vectorIiSaIiEE6resizeEm, .-_ZNSt6vectorIiSaIiEE6resizeEm
	.section	.text._ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mIiiEEPT0_PT_S6_S4_,"axG",@progbits,_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mIiiEEPT0_PT_S6_S4_,comdat
	.p2align 4
	.weak	_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mIiiEEPT0_PT_S6_S4_
	.type	_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mIiiEEPT0_PT_S6_S4_, @function
_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mIiiEEPT0_PT_S6_S4_:
.LFB4715:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
# /usr/include/c++/13/bits/stl_algobase.h:435: 	  const ptrdiff_t _Num = __last - __first;
	subq	%rdi, %rsi	# __first, tmp92
# /usr/include/c++/13/bits/stl_algobase.h:433: 	__copy_m(_Tp* __first, _Tp* __last, _Up* __result)
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdx, %rbx	# tmp93, __result
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 32
# /usr/include/c++/13/bits/stl_algobase.h:435: 	  const ptrdiff_t _Num = __last - __first;
	movq	%rsi, %rbp	# tmp92, _1
# /usr/include/c++/13/bits/stl_algobase.h:436: 	  if (__builtin_expect(_Num > 1, true))
	cmpq	$4, %rsi	#, _1
	jle	.L717	#,
# /usr/include/c++/13/bits/stl_algobase.h:437: 	    __builtin_memmove(__result, __first, sizeof(_Tp) * _Num);
	movq	%rsi, %rdx	# _1,
	movq	%rdi, %rsi	# __first,
	movq	%rbx, %rdi	# __result,
	call	memmove@PLT	#
.L718:
# /usr/include/c++/13/bits/stl_algobase.h:442: 	}
	addq	$8, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
# /usr/include/c++/13/bits/stl_algobase.h:441: 	  return __result + _Num;
	leaq	(%rbx,%rbp), %rax	#, tmp90
# /usr/include/c++/13/bits/stl_algobase.h:442: 	}
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4
	.p2align 3
.L717:
	.cfi_restore_state
# /usr/include/c++/13/bits/stl_algobase.h:438: 	  else if (_Num == 1)
	jne	.L718	#,
# /usr/include/c++/13/bits/stl_algobase.h:440: 	      __assign_one(__result, __first);
	movl	(%rdi), %esi	# *__first_9(D), *__first_9(D)
	movq	%rdx, %rdi	# __result,
	call	_ZNSt11__copy_moveILb0ELb0ESt26random_access_iterator_tagE12__assign_oneIiiEEvPT_PT0_.isra.0	#
	jmp	.L718	#
	.cfi_endproc
.LFE4715:
	.size	_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mIiiEEPT0_PT_S6_S4_, .-_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mIiiEEPT0_PT_S6_S4_
	.section	.text._ZSt14__copy_move_a2ILb0EPiS0_ET1_T0_S2_S1_,"axG",@progbits,_ZSt14__copy_move_a2ILb0EPiS0_ET1_T0_S2_S1_,comdat
	.p2align 4
	.weak	_ZSt14__copy_move_a2ILb0EPiS0_ET1_T0_S2_S1_
	.type	_ZSt14__copy_move_a2ILb0EPiS0_ET1_T0_S2_S1_, @function
_ZSt14__copy_move_a2ILb0EPiS0_ET1_T0_S2_S1_:
.LFB4707:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_algobase.h:506: 			      _Category>::__copy_m(__first, __last, __result);
	jmp	_ZNSt11__copy_moveILb0ELb1ESt26random_access_iterator_tagE8__copy_mIiiEEPT0_PT_S6_S4_	#
	.cfi_endproc
.LFE4707:
	.size	_ZSt14__copy_move_a2ILb0EPiS0_ET1_T0_S2_S1_, .-_ZSt14__copy_move_a2ILb0EPiS0_ET1_T0_S2_S1_
	.section	.text._ZSt14__copy_move_a1ILb0EPiS0_ET1_T0_S2_S1_,"axG",@progbits,_ZSt14__copy_move_a1ILb0EPiS0_ET1_T0_S2_S1_,comdat
	.p2align 4
	.weak	_ZSt14__copy_move_a1ILb0EPiS0_ET1_T0_S2_S1_
	.type	_ZSt14__copy_move_a1ILb0EPiS0_ET1_T0_S2_S1_, @function
_ZSt14__copy_move_a1ILb0EPiS0_ET1_T0_S2_S1_:
.LFB4688:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_algobase.h:533:     { return std::__copy_move_a2<_IsMove>(__first, __last, __result); }
	jmp	_ZSt14__copy_move_a2ILb0EPiS0_ET1_T0_S2_S1_	#
	.cfi_endproc
.LFE4688:
	.size	_ZSt14__copy_move_a1ILb0EPiS0_ET1_T0_S2_S1_, .-_ZSt14__copy_move_a1ILb0EPiS0_ET1_T0_S2_S1_
	.section	.text._ZSt13__copy_move_aILb0EN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET1_T0_S8_S7_,"axG",@progbits,_ZSt13__copy_move_aILb0EN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET1_T0_S8_S7_,comdat
	.p2align 4
	.weak	_ZSt13__copy_move_aILb0EN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET1_T0_S8_S7_
	.type	_ZSt13__copy_move_aILb0EN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET1_T0_S8_S7_, @function
_ZSt13__copy_move_aILb0EN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET1_T0_S8_S7_:
.LFB4654:
	.cfi_startproc
	endbr64	
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12	# tmp90, __first
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdx, %rdi	# tmp92, __result
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
# /usr/include/c++/13/bits/stl_algobase.h:538:     __copy_move_a(_II __first, _II __last, _OI __result)
	movq	%rsi, %rbx	# tmp91, __last
# /usr/include/c++/13/bits/stl_algobase.h:540:       return std::__niter_wrap(__result,
	call	_ZSt12__niter_baseIPiET_S1_	#
# /usr/include/c++/13/bits/stl_algobase.h:540:       return std::__niter_wrap(__result,
	movq	%rbx, %rdi	# __last,
# /usr/include/c++/13/bits/stl_algobase.h:540:       return std::__niter_wrap(__result,
	movq	%rax, %rbp	# tmp93, _2
# /usr/include/c++/13/bits/stl_algobase.h:540:       return std::__niter_wrap(__result,
	call	_ZSt12__niter_baseIPiSt6vectorIiSaIiEEET_N9__gnu_cxx17__normal_iteratorIS4_T0_EE	#
# /usr/include/c++/13/bits/stl_algobase.h:540:       return std::__niter_wrap(__result,
	movq	%r12, %rdi	# __first,
# /usr/include/c++/13/bits/stl_algobase.h:540:       return std::__niter_wrap(__result,
	movq	%rax, %rbx	# tmp94, _3
# /usr/include/c++/13/bits/stl_algobase.h:540:       return std::__niter_wrap(__result,
	call	_ZSt12__niter_baseIPiSt6vectorIiSaIiEEET_N9__gnu_cxx17__normal_iteratorIS4_T0_EE	#
# /usr/include/c++/13/bits/stl_algobase.h:540:       return std::__niter_wrap(__result,
	movq	%rbp, %rdx	# _2,
# /usr/include/c++/13/bits/stl_algobase.h:540:       return std::__niter_wrap(__result,
	movq	%rax, %rdi	# tmp95, _4
# /usr/include/c++/13/bits/stl_algobase.h:540:       return std::__niter_wrap(__result,
	movq	%rbx, %rsi	# _3,
	call	_ZSt14__copy_move_a1ILb0EPiS0_ET1_T0_S2_S1_	#
# /usr/include/c++/13/bits/stl_algobase.h:544:     }
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
# /usr/include/c++/13/bits/stl_algobase.h:540:       return std::__niter_wrap(__result,
	movq	%rax, %rdi	# tmp96, _7
# /usr/include/c++/13/bits/stl_algobase.h:540:       return std::__niter_wrap(__result,
	jmp	_ZSt12__niter_wrapIPiET_RKS1_S1_.isra.0	#
	.cfi_endproc
.LFE4654:
	.size	_ZSt13__copy_move_aILb0EN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET1_T0_S8_S7_, .-_ZSt13__copy_move_aILb0EN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET1_T0_S8_S7_
	.section	.text._ZSt4copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_,"axG",@progbits,_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_,comdat
	.p2align 4
	.weak	_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_
	.type	_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_, @function
_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_:
.LFB4565:
	.cfi_startproc
	endbr64	
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12	# tmp88, __first
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rdi	# tmp89, __last
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
# /usr/include/c++/13/bits/stl_algobase.h:624:     copy(_II __first, _II __last, _OI __result)
	movq	%rdx, %rbp	# tmp90, __result
# /usr/include/c++/13/bits/stl_algobase.h:633: 	     (std::__miter_base(__first), std::__miter_base(__last), __result);
	call	_ZSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEET_S7_	#
# /usr/include/c++/13/bits/stl_algobase.h:633: 	     (std::__miter_base(__first), std::__miter_base(__last), __result);
	movq	%r12, %rdi	# __first,
# /usr/include/c++/13/bits/stl_algobase.h:633: 	     (std::__miter_base(__first), std::__miter_base(__last), __result);
	movq	%rax, %rbx	# tmp91, D.80836
# /usr/include/c++/13/bits/stl_algobase.h:633: 	     (std::__miter_base(__first), std::__miter_base(__last), __result);
	call	_ZSt12__miter_baseIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEET_S7_	#
# /usr/include/c++/13/bits/stl_algobase.h:633: 	     (std::__miter_base(__first), std::__miter_base(__last), __result);
	movq	%rbp, %rdx	# __result,
	movq	%rbx, %rsi	# D.80836,
# /usr/include/c++/13/bits/stl_algobase.h:634:     }
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
# /usr/include/c++/13/bits/stl_algobase.h:633: 	     (std::__miter_base(__first), std::__miter_base(__last), __result);
	movq	%rax, %rdi	# tmp92, D.80837
# /usr/include/c++/13/bits/stl_algobase.h:634:     }
	popq	%r12	#
	.cfi_def_cfa_offset 8
# /usr/include/c++/13/bits/stl_algobase.h:633: 	     (std::__miter_base(__first), std::__miter_base(__last), __result);
	jmp	_ZSt13__copy_move_aILb0EN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET1_T0_S8_S7_	#
	.cfi_endproc
.LFE4565:
	.size	_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_, .-_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_
	.section	.text._ZNSt20__uninitialized_copyILb1EE13__uninit_copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES4_EET0_T_SA_S9_,"axG",@progbits,_ZNSt20__uninitialized_copyILb1EE13__uninit_copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES4_EET0_T_SA_S9_,comdat
	.p2align 4
	.weak	_ZNSt20__uninitialized_copyILb1EE13__uninit_copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES4_EET0_T_SA_S9_
	.type	_ZNSt20__uninitialized_copyILb1EE13__uninit_copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES4_EET0_T_SA_S9_, @function
_ZNSt20__uninitialized_copyILb1EE13__uninit_copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES4_EET0_T_SA_S9_:
.LFB4692:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_uninitialized.h:147:         { return std::copy(__first, __last, __result); }
	jmp	_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_	#
	.cfi_endproc
.LFE4692:
	.size	_ZNSt20__uninitialized_copyILb1EE13__uninit_copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES4_EET0_T_SA_S9_, .-_ZNSt20__uninitialized_copyILb1EE13__uninit_copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES4_EET0_T_SA_S9_
	.section	.text._ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_,"axG",@progbits,_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_,comdat
	.p2align 4
	.weak	_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_
	.type	_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_, @function
_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_:
.LFB4656:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_uninitialized.h:185: 	__uninit_copy(__first, __last, __result);
	jmp	_ZNSt20__uninitialized_copyILb1EE13__uninit_copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES4_EET0_T_SA_S9_	#
	.cfi_endproc
.LFE4656:
	.size	_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_, .-_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_
	.section	.text._ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_iET0_T_S8_S7_RSaIT1_E.isra.0,"ax",@progbits
	.p2align 4
	.type	_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_iET0_T_S8_S7_RSaIT1_E.isra.0, @function
_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_iET0_T_S8_S7_RSaIT1_E.isra.0:
.LFB4770:
	.cfi_startproc
# /usr/include/c++/13/bits/stl_uninitialized.h:373:       return std::uninitialized_copy(__first, __last, __result);
	jmp	_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_	#
	.cfi_endproc
.LFE4770:
	.size	_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_iET0_T_S8_S7_RSaIT1_E.isra.0, .-_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_iET0_T_S8_S7_RSaIT1_E.isra.0
	.section	.text._ZNSt6vectorIiSaIiEE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPiS1_EEEES5_mT_S7_,"axG",@progbits,_ZNSt6vectorIiSaIiEE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPiS1_EEEES5_mT_S7_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIiSaIiEE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPiS1_EEEES5_mT_S7_
	.type	_ZNSt6vectorIiSaIiEE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPiS1_EEEES5_mT_S7_, @function
_ZNSt6vectorIiSaIiEE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPiS1_EEEES5_mT_S7_:
.LFB4564:
	.cfi_startproc
	endbr64	
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rsi, %rdi	# tmp89, __n
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
# /usr/include/c++/13/bits/stl_vector.h:1616: 	_M_allocate_and_copy(size_type __n,
	movq	%rdx, %rbp	# tmp90, __first
	movq	%rcx, %r12	# tmp91, __last
# /usr/include/c++/13/bits/stl_vector.h:1619: 	  pointer __result = this->_M_allocate(__n);
	call	_ZNSt12_Vector_baseIiSaIiEE11_M_allocateEm.isra.0	#
	movq	%rax, %rbx	# tmp92, tmp87
# /usr/include/c++/13/bits/stl_vector.h:1622: 	      std::__uninitialized_copy_a(__first, __last, __result,
	movq	%r12, %rsi	# __last,
	movq	%rbp, %rdi	# __first,
	movq	%rax, %rdx	# tmp87,
	call	_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_iET0_T_S8_S7_RSaIT1_E.isra.0	#
# /usr/include/c++/13/bits/stl_vector.h:1631: 	}
	movq	%rbx, %rax	# tmp87,
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE4564:
	.size	_ZNSt6vectorIiSaIiEE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPiS1_EEEES5_mT_S7_, .-_ZNSt6vectorIiSaIiEE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPiS1_EEEES5_mT_S7_
	.section	.text._ZNSt6vectorIiSaIiEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPiS1_EEEEvT_S7_St20forward_iterator_tag.isra.0,"axG",@progbits,_ZNSt6vectorIiSaIiEE6assignIN9__gnu_cxx17__normal_iteratorIPiS1_EEvEEvT_S7_,comdat
	.align 2
	.p2align 4
	.type	_ZNSt6vectorIiSaIiEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPiS1_EEEEvT_S7_St20forward_iterator_tag.isra.0, @function
_ZNSt6vectorIiSaIiEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPiS1_EEEEvT_S7_St20forward_iterator_tag.isra.0:
.LFB4771:
	.cfi_startproc
	pushq	%r14	#
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13	#
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12	#
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rsi, %r12	# tmp127, __first
	pushq	%rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %rbx	# tmp126, this
	movq	%rdx, %r13	# tmp128, __last
	subq	$32, %rsp	#,
	.cfi_def_cfa_offset 80
# /usr/include/c++/13/bits/stl_iterator_base_funcs.h:106:       return __last - __first;
	leaq	16(%rsp), %r14	#, tmp110
	leaq	8(%rsp), %rdi	#, tmp111
# /usr/include/c++/13/bits/vector.tcc:315:       vector<_Tp, _Alloc>::
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp135
	movq	%rax, 24(%rsp)	# tmp135, D.83825
	xorl	%eax, %eax	# tmp135
	movq	%rsi, 16(%rsp)	# __first, MEM[(struct __normal_iterator *)_18]._M_current
	movq	%rdx, 8(%rsp)	# __last, __last._M_current
# /usr/include/c++/13/bits/stl_iterator_base_funcs.h:106:       return __last - __first;
	movq	%r14, %rsi	# tmp110,
	call	_ZN9__gnu_cxxmiIPiSt6vectorIiSaIiEEEENS_17__normal_iteratorIT_T0_E15difference_typeERKS8_SB_	#
	movq	(%rbx), %rdx	# MEM[(int * *)this_5(D)], _46
# /usr/include/c++/13/bits/vector.tcc:321: 	if (__len > capacity())
	movq	16(%rbx), %rsi	# MEM[(int * *)this_5(D) + 16B], MEM[(int * *)this_5(D) + 16B]
# /usr/include/c++/13/bits/stl_iterator_base_funcs.h:106:       return __last - __first;
	movq	%rax, %rbp	# tmp129, _3
# /usr/include/c++/13/bits/vector.tcc:321: 	if (__len > capacity())
	movq	%rdx, %rdi	# _46,
	call	_ZNKSt6vectorIiSaIiEE8capacityEv.isra.0	#
# /usr/include/c++/13/bits/vector.tcc:321: 	if (__len > capacity())
	cmpq	%rbp, %rax	# _3, tmp130
	jb	.L740	#,
# /usr/include/c++/13/bits/vector.tcc:335: 	else if (size() >= __len)
	movq	8(%rbx), %rsi	# MEM[(int * *)this_5(D) + 8B], MEM[(int * *)this_5(D) + 8B]
	call	_ZNKSt6vectorIiSaIiEE4sizeEv.isra.0	#
# /usr/include/c++/13/bits/vector.tcc:335: 	else if (size() >= __len)
	cmpq	%rbp, %rax	# _3, _17
	jnb	.L741	#,
# /usr/include/c++/13/bits/stl_iterator_base_funcs.h:224:       std::__advance(__i, __d, std::__iterator_category(__i));
	movq	%rax, %rsi	# _17,
	movq	%r14, %rdi	# tmp110,
# /usr/include/c++/13/bits/vector.tcc:339: 	    _ForwardIterator __mid = __first;
	movq	%r12, 16(%rsp)	# __first, MEM[(struct __normal_iterator *)_18]
# /usr/include/c++/13/bits/stl_iterator_base_funcs.h:224:       std::__advance(__i, __d, std::__iterator_category(__i));
	call	_ZSt9__advanceIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEElEvRT_T0_St26random_access_iterator_tag.isra.0	#
# /usr/include/c++/13/bits/vector.tcc:341: 	    std::copy(__first, __mid, this->_M_impl._M_start);
	movq	16(%rsp), %rsi	# MEM[(struct __normal_iterator *)_18],
	movq	%r12, %rdi	# __first,
	vzeroupper
	call	_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_	#
# /usr/include/c++/13/bits/vector.tcc:345: 	      std::__uninitialized_copy_a(__mid, __last,
	movq	8(%rbx), %rdx	# this_5(D)->D.71714._M_impl.D.71053._M_finish, this_5(D)->D.71714._M_impl.D.71053._M_finish
	movq	16(%rsp), %rdi	# MEM[(struct __normal_iterator *)_18],
	movq	%r13, %rsi	# __last,
	call	_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_iET0_T_S8_S7_RSaIT1_E.isra.0	#
# /usr/include/c++/13/bits/vector.tcc:344: 	    this->_M_impl._M_finish =
	movq	%rax, 8(%rbx)	# tmp134, this_5(D)->D.71714._M_impl.D.71053._M_finish
.L731:
# /usr/include/c++/13/bits/vector.tcc:350:       }
	movq	24(%rsp), %rax	# D.83825, tmp137
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp137
	jne	.L739	#,
	addq	$32, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 48
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
.L741:
	.cfi_restore_state
# /usr/include/c++/13/bits/vector.tcc:336: 	  _M_erase_at_end(std::copy(__first, __last, this->_M_impl._M_start));
	movq	%r13, %rsi	# __last,
	movq	%r12, %rdi	# __first,
	vzeroupper
	call	_ZSt4copyIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEES2_ET0_T_S8_S7_	#
	movq	%rax, %rsi	# tmp133, _19
# /usr/include/c++/13/bits/vector.tcc:336: 	  _M_erase_at_end(std::copy(__first, __last, this->_M_impl._M_start));
	movq	24(%rsp), %rax	# D.83825, tmp136
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp136
	jne	.L739	#,
# /usr/include/c++/13/bits/vector.tcc:350:       }
	addq	$32, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 48
# /usr/include/c++/13/bits/vector.tcc:336: 	  _M_erase_at_end(std::copy(__first, __last, this->_M_impl._M_start));
	movq	%rbx, %rdi	# this,
# /usr/include/c++/13/bits/vector.tcc:350:       }
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
# /usr/include/c++/13/bits/vector.tcc:336: 	  _M_erase_at_end(std::copy(__first, __last, this->_M_impl._M_start));
	jmp	_ZNSt6vectorIiSaIiEE15_M_erase_at_endEPi	#
	.p2align 4
	.p2align 3
.L740:
	.cfi_restore_state
# /usr/include/c++/13/bits/vector.tcc:323: 	    _S_check_init_len(__len, _M_get_Tp_allocator());
	movq	%rbp, %rdi	# _3,
	vzeroupper
	call	_ZNSt6vectorIiSaIiEE17_S_check_init_lenEmRKS0_.isra.0	#
# /usr/include/c++/13/bits/vector.tcc:324: 	    pointer __tmp(_M_allocate_and_copy(__len, __first, __last));
	movq	%r12, %rdx	# __first,
	movq	%r13, %rcx	# __last,
	movq	%rbp, %rsi	# _3,
	movq	%rbx, %rdi	# this,
	call	_ZNSt6vectorIiSaIiEE20_M_allocate_and_copyIN9__gnu_cxx17__normal_iteratorIPiS1_EEEES5_mT_S7_	#
# /usr/include/c++/13/bits/vector.tcc:325: 	    std::_Destroy(this->_M_impl._M_start, this->_M_impl._M_finish,
	movq	(%rbx), %rdi	# this_5(D)->D.71714._M_impl.D.71053._M_start, _10
# /usr/include/c++/13/bits/vector.tcc:330: 			  - this->_M_impl._M_start);
	movq	16(%rbx), %rsi	# this_5(D)->D.71714._M_impl.D.71053._M_end_of_storage, tmp113
# /usr/include/c++/13/bits/vector.tcc:324: 	    pointer __tmp(_M_allocate_and_copy(__len, __first, __last));
	movq	%rax, %r12	# tmp131, _9
# /usr/include/c++/13/bits/vector.tcc:330: 			  - this->_M_impl._M_start);
	subq	%rdi, %rsi	# _10, tmp113
	sarq	$2, %rsi	#, tmp116
# /usr/include/c++/13/bits/vector.tcc:328: 	    _M_deallocate(this->_M_impl._M_start,
	call	_ZNSt12_Vector_baseIiSaIiEE13_M_deallocateEPim.isra.0	#
# /usr/include/c++/13/bits/vector.tcc:332: 	    this->_M_impl._M_finish = this->_M_impl._M_start + __len;
	leaq	(%r12,%rbp,4), %rax	#, _16
# /usr/include/c++/13/bits/vector.tcc:331: 	    this->_M_impl._M_start = __tmp;
	vmovq	%r12, %xmm1	# _9, _9
	vpinsrq	$1, %rax, %xmm1, %xmm0	# _16, _9, tmp118
# /usr/include/c++/13/bits/vector.tcc:333: 	    this->_M_impl._M_end_of_storage = this->_M_impl._M_finish;
	movq	%rax, 16(%rbx)	# _16, this_5(D)->D.71714._M_impl.D.71053._M_end_of_storage
# /usr/include/c++/13/bits/vector.tcc:331: 	    this->_M_impl._M_start = __tmp;
	vmovdqu	%xmm0, (%rbx)	# tmp118, MEM <vector(2) long unsigned int> [(int * *)this_5(D)]
	jmp	.L731	#
.L739:
# /usr/include/c++/13/bits/vector.tcc:350:       }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE4771:
	.size	_ZNSt6vectorIiSaIiEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPiS1_EEEEvT_S7_St20forward_iterator_tag.isra.0, .-_ZNSt6vectorIiSaIiEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPiS1_EEEEvT_S7_St20forward_iterator_tag.isra.0
	.section	.text._ZNSt6vectorIiSaIiEE6assignIN9__gnu_cxx17__normal_iteratorIPiS1_EEvEEvT_S7_,"axG",@progbits,_ZNSt6vectorIiSaIiEE6assignIN9__gnu_cxx17__normal_iteratorIPiS1_EEvEEvT_S7_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIiSaIiEE6assignIN9__gnu_cxx17__normal_iteratorIPiS1_EEvEEvT_S7_
	.type	_ZNSt6vectorIiSaIiEE6assignIN9__gnu_cxx17__normal_iteratorIPiS1_EEvEEvT_S7_, @function
_ZNSt6vectorIiSaIiEE6assignIN9__gnu_cxx17__normal_iteratorIPiS1_EEvEEvT_S7_:
.LFB4253:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/stl_vector.h:829: 	{ _M_assign_aux(__first, __last, std::__iterator_category(__first)); }
	jmp	_ZNSt6vectorIiSaIiEE13_M_assign_auxIN9__gnu_cxx17__normal_iteratorIPiS1_EEEEvT_S7_St20forward_iterator_tag.isra.0	#
	.cfi_endproc
.LFE4253:
	.size	_ZNSt6vectorIiSaIiEE6assignIN9__gnu_cxx17__normal_iteratorIPiS1_EEvEEvT_S7_, .-_ZNSt6vectorIiSaIiEE6assignIN9__gnu_cxx17__normal_iteratorIPiS1_EEvEEvT_S7_
	.section	.text._Z13random_sampleiiRSt6vectorIiSaIiEE,"axG",@progbits,_Z13random_sampleiiRSt6vectorIiSaIiEE,comdat
	.p2align 4
	.weak	_Z13random_sampleiiRSt6vectorIiSaIiEE
	.type	_Z13random_sampleiiRSt6vectorIiSaIiEE, @function
_Z13random_sampleiiRSt6vectorIiSaIiEE:
.LFB3850:
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
	movq	%rdx, %r13	# tmp140, out
	pushq	%rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
# null_collision.h:27:     static std::vector<int> pool;
	movzbl	_ZGVZ13random_sampleiiRSt6vectorIiSaIiEEE4pool(%rip), %eax	#, _1
# null_collision.h:26: inline void random_sample(int n , int count, std::vector<int> &out) {
	movl	%edi, %r12d	# tmp138, n
	movslq	%esi, %rbp	# tmp139,
	leaq	_ZZ13random_sampleiiRSt6vectorIiSaIiEEE4pool(%rip), %r14	#, tmp137
# null_collision.h:27:     static std::vector<int> pool;
# null_collision.h:27:     static std::vector<int> pool;
	testb	%al, %al	# _1
	je	.L757	#,
.L745:
# null_collision.h:29:     if (pool.size() < (size_t)n) {
	movq	8+_ZZ13random_sampleiiRSt6vectorIiSaIiEEE4pool(%rip), %rsi	# MEM[(int * *)&pool + 8B],
	movq	_ZZ13random_sampleiiRSt6vectorIiSaIiEEE4pool(%rip), %rdi	# MEM[(int * *)&pool],
# null_collision.h:29:     if (pool.size() < (size_t)n) {
	movslq	%r12d, %rbx	# n, n
# null_collision.h:29:     if (pool.size() < (size_t)n) {
	call	_ZNKSt6vectorIiSaIiEE4sizeEv.isra.0	#
# null_collision.h:29:     if (pool.size() < (size_t)n) {
	cmpq	%rbx, %rax	# n, tmp142
	jb	.L758	#,
.L747:
# null_collision.h:33:     std::iota(pool.begin(), pool.begin() + n, 0);
	call	_ZNSt6vectorIiSaIiEE5beginEv.constprop.0	#
# null_collision.h:33:     std::iota(pool.begin(), pool.begin() + n, 0);
	movq	%rbx, %rsi	# n,
# null_collision.h:33:     std::iota(pool.begin(), pool.begin() + n, 0);
	movq	%rax, %rdi	# tmp143, D.71894
# null_collision.h:33:     std::iota(pool.begin(), pool.begin() + n, 0);
	call	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEplEl.isra.0	#
	movq	%rax, %rbx	# tmp144, D.80637
# null_collision.h:33:     std::iota(pool.begin(), pool.begin() + n, 0);
	call	_ZNSt6vectorIiSaIiEE5beginEv.constprop.0	#
# null_collision.h:33:     std::iota(pool.begin(), pool.begin() + n, 0);
	xorl	%edx, %edx	#
# null_collision.h:33:     std::iota(pool.begin(), pool.begin() + n, 0);
	movq	%rax, %rdi	# tmp145, D.80638
# null_collision.h:33:     std::iota(pool.begin(), pool.begin() + n, 0);
	movq	%rbx, %rsi	# D.80637,
	call	_ZSt4iotaIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiEvT_S7_T0_	#
# null_collision.h:35:     for (int i = 0; i < count; i++) {
	testl	%ebp, %ebp	# count
	jle	.L748	#,
	xorl	%ebx, %ebx	# ivtmp.1742
	.p2align 4
	.p2align 3
.L749:
# null_collision.h:36:         int j = i + (int)(R01(MTgen) * (n - i));
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# null_collision.h:36:         int j = i + (int)(R01(MTgen) * (n - i));
	movl	%r12d, %eax	# n, tmp128
# null_collision.h:36:         int j = i + (int)(R01(MTgen) * (n - i));
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp156
# null_collision.h:36:         int j = i + (int)(R01(MTgen) * (n - i));
	subl	%ebx, %eax	# ivtmp.1742, tmp128
# null_collision.h:36:         int j = i + (int)(R01(MTgen) * (n - i));
	vmovsd	%xmm0, %xmm0, %xmm1	#, tmp146
# null_collision.h:36:         int j = i + (int)(R01(MTgen) * (n - i));
	vcvtsi2sdl	%eax, %xmm2, %xmm0	# tmp128, tmp156, tmp153
	vmulsd	%xmm1, %xmm0, %xmm0	# tmp146, tmp129, tmp130
# null_collision.h:36:         int j = i + (int)(R01(MTgen) * (n - i));
	vcvttsd2sil	%xmm0, %edi	# tmp130, tmp131
# null_collision.h:36:         int j = i + (int)(R01(MTgen) * (n - i));
	addl	%ebx, %edi	# ivtmp.1742, j
# null_collision.h:37:         std::swap(pool[i], pool[j]);
	movslq	%edi, %rdi	# j, j
	call	_ZNSt6vectorIiSaIiEEixEm.constprop.0	#
# null_collision.h:37:         std::swap(pool[i], pool[j]);
	movq	%rbx, %rdi	# ivtmp.1742,
# null_collision.h:37:         std::swap(pool[i], pool[j]);
	movq	%rax, %rsi	# tmp147, _11
# null_collision.h:37:         std::swap(pool[i], pool[j]);
	call	_ZNSt6vectorIiSaIiEEixEm.constprop.0	#
# null_collision.h:37:         std::swap(pool[i], pool[j]);
	vzeroupper
# null_collision.h:37:         std::swap(pool[i], pool[j]);
	movq	%rax, %rdi	# tmp148, _13
# null_collision.h:35:     for (int i = 0; i < count; i++) {
	incq	%rbx	# ivtmp.1742
# null_collision.h:37:         std::swap(pool[i], pool[j]);
	call	_ZSt4swapIiENSt9enable_ifIXsrSt6__and_IJSt6__not_ISt15__is_tuple_likeIT_EESt21is_move_constructibleIS4_ESt18is_move_assignableIS4_EEE5valueEvE4typeERS4_SE_	#
# null_collision.h:35:     for (int i = 0; i < count; i++) {
	cmpq	%rbp, %rbx	# count, ivtmp.1742
	jne	.L749	#,
.L748:
# null_collision.h:39:     out.assign(pool.begin(), pool.begin() + count);
	call	_ZNSt6vectorIiSaIiEE5beginEv.constprop.0	#
# null_collision.h:39:     out.assign(pool.begin(), pool.begin() + count);
	movq	%rbp, %rsi	# count,
# null_collision.h:39:     out.assign(pool.begin(), pool.begin() + count);
	movq	%rax, %rdi	# tmp149, D.72046
# null_collision.h:39:     out.assign(pool.begin(), pool.begin() + count);
	call	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEplEl.isra.0	#
	movq	%rax, %rbx	# tmp150, D.80639
# null_collision.h:39:     out.assign(pool.begin(), pool.begin() + count);
	call	_ZNSt6vectorIiSaIiEE5beginEv.constprop.0	#
# null_collision.h:39:     out.assign(pool.begin(), pool.begin() + count);
	movq	%r13, %rdi	# out,
	movq	%rbx, %rdx	# D.80639,
# null_collision.h:40: }
	popq	%rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp	#
	.cfi_def_cfa_offset 32
# null_collision.h:39:     out.assign(pool.begin(), pool.begin() + count);
	movq	%rax, %rsi	# tmp151, D.80640
# null_collision.h:40: }
	popq	%r12	#
	.cfi_def_cfa_offset 24
	popq	%r13	#
	.cfi_def_cfa_offset 16
	popq	%r14	#
	.cfi_def_cfa_offset 8
# null_collision.h:39:     out.assign(pool.begin(), pool.begin() + count);
	jmp	_ZNSt6vectorIiSaIiEE6assignIN9__gnu_cxx17__normal_iteratorIPiS1_EEvEEvT_S7_	#
	.p2align 4
	.p2align 3
.L757:
	.cfi_restore_state
# null_collision.h:27:     static std::vector<int> pool;
	leaq	_ZGVZ13random_sampleiiRSt6vectorIiSaIiEEE4pool(%rip), %rbx	#, tmp116
	leaq	_ZZ13random_sampleiiRSt6vectorIiSaIiEEE4pool(%rip), %r14	#, tmp137
	movq	%rbx, %rdi	# tmp116,
	call	__cxa_guard_acquire@PLT	#
	testl	%eax, %eax	# tmp141
	je	.L745	#,
# null_collision.h:27:     static std::vector<int> pool;
	movq	%r14, %rdi	# tmp137,
	call	_ZNSt6vectorIiSaIiEEC1Ev	#
# null_collision.h:27:     static std::vector<int> pool;
	leaq	__dso_handle(%rip), %rdx	#, tmp118
	movq	%r14, %rsi	# tmp137,
	leaq	_ZNSt6vectorIiSaIiEED1Ev(%rip), %rdi	#, tmp120
	call	__cxa_atexit@PLT	#
# null_collision.h:27:     static std::vector<int> pool;
	movq	%rbx, %rdi	# tmp116,
	call	__cxa_guard_release@PLT	#
	jmp	.L745	#
	.p2align 4
	.p2align 3
.L758:
# null_collision.h:30:         pool.resize(n);
	movq	%rbx, %rsi	# n,
	movq	%r14, %rdi	# tmp137,
	call	_ZNSt6vectorIiSaIiEE6resizeEm	#
	jmp	.L747	#
	.cfi_endproc
.LFE3850:
	.size	_Z13random_sampleiiRSt6vectorIiSaIiEE, .-_Z13random_sampleiiRSt6vectorIiSaIiEE
	.section	.text._Z26step7_collisions_electronsv,"axG",@progbits,_Z26step7_collisions_electronsv,comdat
	.p2align 4
	.weak	_Z26step7_collisions_electronsv
	.type	_Z26step7_collisions_electronsv, @function
_Z26step7_collisions_electronsv:
.LFB3870:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3870
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
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$264, %rsp	#,
	.cfi_def_cfa_offset 320
# simulation.h:208:     std::binomial_distribution<int> binom_e(N_e, P_star_e);
	movl	N_e(%rip), %esi	# N_e,
	vmovsd	P_star_e(%rip), %xmm0	# P_star_e,
	leaq	96(%rsp), %rbx	#, tmp122
	movq	%rbx, %rdi	# tmp122,
# simulation.h:206: inline void step7_collisions_electrons(){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp193
	movq	%rax, 248(%rsp)	# tmp193, D.83843
	xorl	%eax, %eax	# tmp193
# simulation.h:208:     std::binomial_distribution<int> binom_e(N_e, P_star_e);
	call	_ZNSt21binomial_distributionIiEC1Eid	#
# simulation.h:209:     int N_coll_star_e = binom_e(MTgen);
	leaq	MTgen(%rip), %rsi	#, tmp124
	movq	%rbx, %rdi	# tmp122,
	call	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_	#
# simulation.h:210:     if (N_coll_star_e > N_e) N_coll_star_e = N_e;
	movl	N_e(%rip), %ebp	# N_e, N_e.74_3
# simulation.h:210:     if (N_coll_star_e > N_e) N_coll_star_e = N_e;
	cmpl	%eax, %ebp	# tmp185, N_e.74_3
	cmovle	%ebp, %eax	# N_e.74_3,, tmp185
# simulation.h:212:     if (N_coll_star_e > 0) {
	testl	%eax, %eax	# _33
	jg	.L775	#,
.L759:
# simulation.h:249: }
	movq	248(%rsp), %rax	# D.83843, tmp195
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp195
	jne	.L774	#,
	addq	$264, %rsp	#,
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
.L775:
	.cfi_restore_state
	movl	%eax, %ebx	# tmp185, _33
# simulation.h:213:         std::vector<int> candidates_e;
	leaq	64(%rsp), %rax	#, tmp174
	movq	%rax, %rdi	# tmp174,
	movq	%rax, 24(%rsp)	# tmp174, %sfp
	call	_ZNSt6vectorIiSaIiEEC1Ev	#
# simulation.h:214:         random_sample(N_e, N_coll_star_e, candidates_e);
	movq	24(%rsp), %rdx	# %sfp,
	movl	%ebx, %esi	# _33,
	movl	%ebp, %edi	# N_e.74_3,
.LEHB3:
	call	_Z13random_sampleiiRSt6vectorIiSaIiEE	#
.LEHE3:
# simulation.h:216:         for (int ki : candidates_e) {
	movq	24(%rsp), %rdi	# %sfp,
	leaq	48(%rsp), %rbx	#, tmp179
	call	_ZNSt6vectorIiSaIiEE5beginEv	#
# simulation.h:216:         for (int ki : candidates_e) {
	movq	24(%rsp), %rdi	# %sfp,
# simulation.h:216:         for (int ki : candidates_e) {
	movq	%rax, 48(%rsp)	# tmp186, __for_begin
# simulation.h:216:         for (int ki : candidates_e) {
	call	_ZNSt6vectorIiSaIiEE3endEv	#
	movq	%rax, 56(%rsp)	# tmp187, __for_end
	leaq	56(%rsp), %rax	#, tmp180
	movq	%rax, 16(%rsp)	# tmp180, %sfp
# simulation.h:216:         for (int ki : candidates_e) {
	jmp	.L761	#
	.p2align 4
	.p2align 3
.L763:
# simulation.h:216:         for (int ki : candidates_e) {
	movq	%rbx, %rdi	# tmp179,
	call	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEppEv.isra.0	#
.L761:
# simulation.h:216:         for (int ki : candidates_e) {
	movq	16(%rsp), %rsi	# %sfp,
	movq	%rbx, %rdi	# tmp179,
	call	_ZN9__gnu_cxxneIPiSt6vectorIiSaIiEEEEbRKNS_17__normal_iteratorIT_T0_EESA_	#
	testb	%al, %al	# tmp191
	je	.L776	#,
# simulation.h:216:         for (int ki : candidates_e) {
	movq	48(%rsp), %rdi	# MEM[(int * *)&__for_begin],
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	leaq	vx_e(%rip), %r14	#, tmp176
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	leaq	vy_e(%rip), %r15	#, tmp177
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	leaq	vz_e(%rip), %rbp	#, tmp178
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	leaq	44(%rsp), %rsi	#, tmp150
# simulation.h:216:         for (int ki : candidates_e) {
	call	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEdeEv.isra.0	#
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	leaq	40(%rsp), %rdi	#, tmp151
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	movl	$999999, 44(%rsp)	#, D.72492
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	movslq	(%rax), %r13	# *_4, ki
	vmovsd	(%r14,%r13,8), %xmm0	# vx_e[ki_43], _5
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vmovsd	(%r15,%r13,8), %xmm1	# vy_e[ki_43], _7
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vmulsd	%xmm1, %xmm1, %xmm1	# _7, _7, tmp138
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vfmadd231sd	%xmm0, %xmm0, %xmm1	# _5, _5, _9
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vmovsd	0(%rbp,%r13,8), %xmm0	# vz_e[ki_43], _10
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# _10, _9, v_sqr
# simulation.h:218:             double velocity = sqrt(v_sqr);
	vsqrtsd	%xmm0, %xmm0, %xmm1	# v_sqr, velocity
# simulation.h:219:             double energy   = 0.5 * E_MASS * v_sqr / EV_TO_J;
	vmulsd	.LC78(%rip), %xmm0, %xmm0	#, v_sqr, tmp141
# simulation.h:219:             double energy   = 0.5 * E_MASS * v_sqr / EV_TO_J;
	vdivsd	.LC51(%rip), %xmm0, %xmm0	#, tmp141, energy
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vdivsd	.LC3(%rip), %xmm0, %xmm0	#, energy, tmp145
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vaddsd	.LC46(%rip), %xmm0, %xmm0	#, tmp145, tmp147
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vcvttsd2sil	%xmm0, %eax	# tmp147, tmp149
	movl	%eax, 40(%rsp)	# tmp149, D.72491
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	call	_ZSt3minIiERKT_S2_S2_.constprop.0	#
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	movslq	(%rax), %rsi	# *_16,
# simulation.h:222:             double real_nu = sigma_tot_e[energy_index] * velocity;
	leaq	sigma_tot_e(%rip), %rax	#, tmp152
# simulation.h:224:             if (p_accept > 1.0) p_accept = 1.0;
	vmovsd	.LC12(%rip), %xmm0	#, tmp155
# simulation.h:222:             double real_nu = sigma_tot_e[energy_index] * velocity;
	vmulsd	(%rax,%rsi,8), %xmm1, %xmm1	# sigma_tot_e[energy_index_50], velocity, real_nu
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	movq	%rsi, %r12	#,
# simulation.h:223:             double p_accept = real_nu / nu_star_e;
	vdivsd	nu_star_e(%rip), %xmm1, %xmm1	# nu_star_e, real_nu, p_accept
# simulation.h:224:             if (p_accept > 1.0) p_accept = 1.0;
	vminsd	%xmm1, %xmm0, %xmm1	# p_accept, tmp155, p_accept
	vmovsd	%xmm1, 8(%rsp)	# p_accept, %sfp
# simulation.h:226:             if (R01(MTgen) < p_accept) {
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# simulation.h:226:             if (R01(MTgen) < p_accept) {
	vmovsd	8(%rsp), %xmm1	# %sfp, p_accept
	vcomisd	%xmm0, %xmm1	# tmp190, p_accept
	jbe	.L763	#,
	leaq	0(,%r13,8), %rax	#, _66
# simulation.h:227:                 collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index);
	movl	%r12d, %ecx	# energy_index,
	leaq	0(%rbp,%rax), %rdx	#, tmp157
	leaq	(%r15,%rax), %rsi	#, tmp159
	leaq	(%r14,%rax), %rdi	#, tmp161
	leaq	x_e(%rip), %rax	#, tmp163
	vmovsd	(%rax,%r13,8), %xmm0	# x_e[ki_43], x_e[ki_43]
	call	_Z18collision_electrondPdS_S_i	#
# simulation.h:228:                 N_e_coll++;
	incq	N_e_coll(%rip)	# N_e_coll
	jmp	.L763	#
	.p2align 4
	.p2align 3
.L776:
# simulation.h:231:     }
	movq	24(%rsp), %rdi	# %sfp,
	call	_ZNSt6vectorIiSaIiEED1Ev	#
# simulation.h:249: }
	jmp	.L759	#
.L766:
# simulation.h:231:     }
	movq	24(%rsp), %rdi	# %sfp,
	vzeroupper
	call	_ZNSt6vectorIiSaIiEED1Ev	#
	movq	248(%rsp), %rax	# D.83843, tmp194
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp194
	je	.L767	#,
.L774:
# simulation.h:249: }
	call	__stack_chk_fail@PLT	#
.L770:
	endbr64	
# simulation.h:231:     }
	movq	%rax, %rbx	# tmp192, tmp171
	jmp	.L766	#
.L767:
	movq	%rbx, %rdi	# tmp171,
.LEHB4:
	call	_Unwind_Resume@PLT	#
.LEHE4:
	.cfi_endproc
.LFE3870:
	.section	.gcc_except_table._Z26step7_collisions_electronsv,"aG",@progbits,_Z26step7_collisions_electronsv,comdat
.LLSDA3870:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3870-.LLSDACSB3870
.LLSDACSB3870:
	.uleb128 .LEHB3-.LFB3870
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L770-.LFB3870
	.uleb128 0
	.uleb128 .LEHB4-.LFB3870
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
.LLSDACSE3870:
	.section	.text._Z26step7_collisions_electronsv,"axG",@progbits,_Z26step7_collisions_electronsv,comdat
	.size	_Z26step7_collisions_electronsv, .-_Z26step7_collisions_electronsv
	.section	.text._Z20step8_collision_ionsi,"axG",@progbits,_Z20step8_collision_ionsi,comdat
	.p2align 4
	.weak	_Z20step8_collision_ionsi
	.type	_Z20step8_collision_ionsi, @function
_Z20step8_collision_ionsi:
.LFB3871:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3871
	endbr64	
# simulation.h:277:             if (p_accept > 1.0) p_accept = 1.0;
	imull	$-858993459, %edi, %edi	#, tmp206, tmp138
# simulation.h:251: inline void step8_collision_ions(int t){
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$280, %rsp	#,
	.cfi_def_cfa_offset 336
# simulation.h:277:             if (p_accept > 1.0) p_accept = 1.0;
	addl	$429496728, %edi	#, tmp139
# simulation.h:251: inline void step8_collision_ions(int t){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp218
	movq	%rax, 264(%rsp)	# tmp218, D.83850
	xorl	%eax, %eax	# tmp218
# simulation.h:277:             if (p_accept > 1.0) p_accept = 1.0;
	rorx	$2, %edi, %edi	#, tmp139, tmp140
# simulation.h:252:     if ((t % N_SUB) != 0) return;
	cmpl	$214748364, %edi	#, tmp140
	jbe	.L794	#,
.L777:
# simulation.h:308: }
	movq	264(%rsp), %rax	# D.83850, tmp220
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp220
	jne	.L793	#,
	addq	$280, %rsp	#,
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
.L794:
	.cfi_restore_state
# simulation.h:255:     std::binomial_distribution<int> binom_i(N_i, P_star_i);
	movl	N_i(%rip), %esi	# N_i,
	leaq	112(%rsp), %rbx	#, tmp143
	vmovsd	P_star_i(%rip), %xmm0	# P_star_i,
	movq	%rbx, %rdi	# tmp143,
	call	_ZNSt21binomial_distributionIiEC1Eid	#
# simulation.h:256:     int N_coll_star_i = binom_i(MTgen);
	movq	%rbx, %rdi	# tmp143,
	leaq	MTgen(%rip), %rsi	#, tmp145
	call	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_	#
# simulation.h:257:     if (N_coll_star_i > N_i) N_coll_star_i = N_i;
	movl	N_i(%rip), %ebp	# N_i, N_i.124_4
# simulation.h:257:     if (N_coll_star_i > N_i) N_coll_star_i = N_i;
	cmpl	%eax, %ebp	# tmp207, N_i.124_4
	cmovle	%ebp, %eax	# N_i.124_4,, tmp207
	movl	%eax, %ebx	# tmp207, _35
# simulation.h:259:     if (N_coll_star_i > 0) {
	testl	%eax, %eax	# _35
	jle	.L777	#,
# simulation.h:260:         std::vector<int> candidates_i;
	leaq	80(%rsp), %rax	#, tmp199
	movq	%rax, %r14	# tmp199, tmp199
	movq	%rax, %rdi	# tmp199,
	movq	%rax, 40(%rsp)	# tmp199, %sfp
	call	_ZNSt6vectorIiSaIiEEC1Ev	#
# simulation.h:261:         random_sample(N_i, N_coll_star_i, candidates_i);
	movq	%r14, %rdx	# tmp199,
	movl	%ebx, %esi	# _35,
	movl	%ebp, %edi	# N_i.124_4,
.LEHB5:
	call	_Z13random_sampleiiRSt6vectorIiSaIiEE	#
.LEHE5:
# simulation.h:265:         for (int ki : candidates_i) {
	movq	40(%rsp), %rdi	# %sfp,
	leaq	64(%rsp), %rbx	#, tmp196
	call	_ZNSt6vectorIiSaIiEE5beginEv	#
# simulation.h:265:         for (int ki : candidates_i) {
	movq	40(%rsp), %rdi	# %sfp,
# simulation.h:265:         for (int ki : candidates_i) {
	movq	%rax, 64(%rsp)	# tmp208, __for_begin
# simulation.h:265:         for (int ki : candidates_i) {
	call	_ZNSt6vectorIiSaIiEE3endEv	#
	movq	%rax, 72(%rsp)	# tmp209, __for_end
	leaq	72(%rsp), %rax	#, tmp198
	movq	%rax, 32(%rsp)	# tmp198, %sfp
# simulation.h:265:         for (int ki : candidates_i) {
	jmp	.L780	#
	.p2align 4
	.p2align 3
.L782:
# simulation.h:265:         for (int ki : candidates_i) {
	movq	%rbx, %rdi	# tmp196,
	call	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEppEv.isra.0	#
.L780:
# simulation.h:265:         for (int ki : candidates_i) {
	movq	32(%rsp), %rsi	# %sfp,
	movq	%rbx, %rdi	# tmp196,
	call	_ZN9__gnu_cxxneIPiSt6vectorIiSaIiEEEEbRKNS_17__normal_iteratorIT_T0_EESA_	#
	testb	%al, %al	# tmp216
	je	.L795	#,
# simulation.h:265:         for (int ki : candidates_i) {
	movq	64(%rsp), %rdi	# MEM[(int * *)&__for_begin],
# simulation.h:267:             gx = vx_i[ki] - vx_a;
	leaq	vx_i(%rip), %r14	#, tmp195
# simulation.h:268:             gy = vy_i[ki] - vy_a;
	leaq	vy_i(%rip), %r15	#, tmp201
# simulation.h:269:             gz = vz_i[ki] - vz_a;
	leaq	vz_i(%rip), %rbp	#, tmp197
# simulation.h:265:         for (int ki : candidates_i) {
	call	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEdeEv.isra.0	#
	movslq	(%rax), %r13	# *_5,
# simulation.h:266:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
	vmovsd	%xmm0, (%rsp)	# tmp211, %sfp
# simulation.h:266:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
	vmovsd	%xmm0, 8(%rsp)	# tmp212, %sfp
# simulation.h:266:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# simulation.h:273:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	leaq	60(%rsp), %rsi	#, tmp174
	leaq	56(%rsp), %rdi	#, tmp175
# simulation.h:266:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	vmovsd	%xmm0, %xmm0, %xmm2	# tmp213, _56
# simulation.h:273:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	movl	$999999, 60(%rsp)	#, D.72523
# simulation.h:269:             gz = vz_i[ki] - vz_a;
	vmovsd	%xmm2, 24(%rsp)	# _56, %sfp
# simulation.h:267:             gx = vx_i[ki] - vx_a;
	vmovsd	(%r14,%r13,8), %xmm1	# vx_i[ki_48], vx_i[ki_48]
# simulation.h:268:             gy = vy_i[ki] - vy_a;
	vmovsd	(%r15,%r13,8), %xmm3	# vy_i[ki_48], vy_i[ki_48]
# simulation.h:267:             gx = vx_i[ki] - vx_a;
	vsubsd	(%rsp), %xmm1, %xmm1	# %sfp, vx_i[ki_48], gx
# simulation.h:268:             gy = vy_i[ki] - vy_a;
	vsubsd	8(%rsp), %xmm3, %xmm3	# %sfp, vy_i[ki_48], gy
# simulation.h:270:             g_sqr = gx*gx + gy*gy + gz*gz;
	vmulsd	%xmm3, %xmm3, %xmm3	# gy, gy, tmp164
# simulation.h:270:             g_sqr = gx*gx + gy*gy + gz*gz;
	vfmadd132sd	%xmm1, %xmm3, %xmm1	# gx, tmp164, _11
# simulation.h:269:             gz = vz_i[ki] - vz_a;
	vmovsd	0(%rbp,%r13,8), %xmm0	# vz_i[ki_48], vz_i[ki_48]
	vsubsd	%xmm2, %xmm0, %xmm0	# _56, vz_i[ki_48], gz
# simulation.h:270:             g_sqr = gx*gx + gy*gy + gz*gz;
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# gz, _11, g_sqr
# simulation.h:271:             g = sqrt(g_sqr);
	vsqrtsd	%xmm0, %xmm0, %xmm1	# g_sqr, g
# simulation.h:272:             energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J;
	vmulsd	.LC189(%rip), %xmm0, %xmm0	#, g_sqr, tmp165
# simulation.h:272:             energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J;
	vdivsd	.LC51(%rip), %xmm0, %xmm0	#, tmp165, energy
# simulation.h:273:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vdivsd	.LC3(%rip), %xmm0, %xmm0	#, energy, tmp169
# simulation.h:273:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vaddsd	.LC46(%rip), %xmm0, %xmm0	#, tmp169, tmp171
# simulation.h:273:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vcvttsd2sil	%xmm0, %eax	# tmp171, tmp173
	movl	%eax, 56(%rsp)	# tmp173, D.72522
# simulation.h:273:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	call	_ZSt3minIiERKT_S2_S2_.constprop.0	#
# simulation.h:273:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	movslq	(%rax), %rsi	# *_17,
# simulation.h:275:             double real_nu = sigma_tot_i[energy_index] * g;
	leaq	sigma_tot_i(%rip), %rax	#, tmp176
# simulation.h:277:             if (p_accept > 1.0) p_accept = 1.0;
	vmovsd	.LC12(%rip), %xmm0	#, tmp179
# simulation.h:275:             double real_nu = sigma_tot_i[energy_index] * g;
	vmulsd	(%rax,%rsi,8), %xmm1, %xmm1	# sigma_tot_i[energy_index_67], g, real_nu
# simulation.h:273:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	movq	%rsi, %r12	#,
# simulation.h:276:             double p_accept = real_nu / nu_star_i;
	vdivsd	nu_star_i(%rip), %xmm1, %xmm1	# nu_star_i, real_nu, p_accept
# simulation.h:277:             if (p_accept > 1.0) p_accept = 1.0;
	vminsd	%xmm1, %xmm0, %xmm1	# p_accept, tmp179, p_accept
	vmovsd	%xmm1, 16(%rsp)	# p_accept, %sfp
# simulation.h:279:             if (R01(MTgen) < p_accept) {
	vzeroupper
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# simulation.h:279:             if (R01(MTgen) < p_accept) {
	vmovsd	16(%rsp), %xmm1	# %sfp, p_accept
	vmovsd	24(%rsp), %xmm2	# %sfp, _56
	vcomisd	%xmm0, %xmm1	# tmp215, p_accept
	jbe	.L782	#,
	salq	$3, %r13	#, _84
# simulation.h:280:                 collision_ion(&vx_i[ki], &vy_i[ki], &vz_i[ki], &vx_a, &vy_a, &vz_a, energy_index);
	vmovsd	8(%rsp), %xmm1	# %sfp,
	vmovsd	(%rsp), %xmm0	# %sfp,
	leaq	0(%rbp,%r13), %rdx	#, tmp181
	leaq	(%r15,%r13), %rsi	#, tmp183
	leaq	(%r14,%r13), %rdi	#, tmp185
	movl	%r12d, %ecx	# energy_index,
	call	_Z13collision_ionPdS_S_S_S_S_i.isra.0	#
# simulation.h:281:                 N_i_coll++;
	incq	N_i_coll(%rip)	# N_i_coll
	jmp	.L782	#
	.p2align 4
	.p2align 3
.L795:
# simulation.h:284:     }
	movq	40(%rsp), %rdi	# %sfp,
	call	_ZNSt6vectorIiSaIiEED1Ev	#
	jmp	.L777	#
.L785:
	movq	40(%rsp), %rdi	# %sfp,
	vzeroupper
	call	_ZNSt6vectorIiSaIiEED1Ev	#
	movq	264(%rsp), %rax	# D.83850, tmp219
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp219
	je	.L786	#,
.L793:
# simulation.h:308: }
	call	__stack_chk_fail@PLT	#
.L789:
	endbr64	
# simulation.h:284:     }
	movq	%rax, %rbx	# tmp217, tmp192
	jmp	.L785	#
.L786:
	movq	%rbx, %rdi	# tmp192,
.LEHB6:
	call	_Unwind_Resume@PLT	#
.LEHE6:
	.cfi_endproc
.LFE3871:
	.section	.gcc_except_table._Z20step8_collision_ionsi,"aG",@progbits,_Z20step8_collision_ionsi,comdat
.LLSDA3871:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3871-.LLSDACSB3871
.LLSDACSB3871:
	.uleb128 .LEHB5-.LFB3871
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L789-.LFB3871
	.uleb128 0
	.uleb128 .LEHB6-.LFB3871
	.uleb128 .LEHE6-.LEHB6
	.uleb128 0
	.uleb128 0
.LLSDACSE3871:
	.section	.text._Z20step8_collision_ionsi,"axG",@progbits,_Z20step8_collision_ionsi,comdat
	.size	_Z20step8_collision_ionsi, .-_Z20step8_collision_ionsi
	.section	.rodata._Z12do_one_cyclev.str1.8,"aMS",@progbits,1
	.align 8
.LC190:
	.string	" c = %8d  t = %8d  #e = %8d  #i = %8d\n"
	.section	.rodata._Z12do_one_cyclev.str1.1,"aMS",@progbits,1
.LC191:
	.string	"%8d  %8d  %8d\n"
	.section	.text._Z12do_one_cyclev,"axG",@progbits,_Z12do_one_cyclev,comdat
	.p2align 4
	.weak	_Z12do_one_cyclev
	.type	_Z12do_one_cyclev, @function
_Z12do_one_cyclev:
.LFB3873:
	.cfi_startproc
	endbr64	
	pushq	%r13	#
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12	#
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp	#
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
# simulation.h:327:         t_index = t / N_BIN;        // index for XT distributions        
	movl	$3435973837, %r12d	#, tmp99
# simulation.h:321: inline void do_one_cycle (void){
	pushq	%rbx	#
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC190(%rip), %r13	#, tmp126
# simulation.h:325:     for (t=0; t<N_T; t++){          // the RF period is divided into N_T equal time intervals (time step DT_E)
	xorl	%ebx, %ebx	# t
# simulation.h:321: inline void do_one_cycle (void){
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 48
	jmp	.L798	#
	.p2align 4
	.p2align 3
.L797:
# simulation.h:325:     for (t=0; t<N_T; t++){          // the RF period is divided into N_T equal time intervals (time step DT_E)
	incl	%ebx	# t
# simulation.h:325:     for (t=0; t<N_T; t++){          // the RF period is divided into N_T equal time intervals (time step DT_E)
	cmpl	$4000, %ebx	#, t
	je	.L801	#,
.L798:
# simulation.h:327:         t_index = t / N_BIN;        // index for XT distributions        
	movl	%ebx, %ebp	# t, t
# simulation.h:326:         Time += DT_E;               // update of the total simulated time
	vmovsd	.LC69(%rip), %xmm1	#, tmp128
	vaddsd	Time(%rip), %xmm1, %xmm0	# Time, tmp128, tmp94
	vmovsd	%xmm0, Time(%rip)	# tmp94, Time
# simulation.h:327:         t_index = t / N_BIN;        // index for XT distributions        
	imulq	%r12, %rbp	# tmp99, tmp98
# simulation.h:329:         step1_compute_electron_density();
	call	_Z30step1_compute_electron_densityv	#
# simulation.h:330:         step1_compute_ion_density(t);
	movl	%ebx, %edi	# t,
	call	_Z25step1_compute_ion_densityi	#
# simulation.h:331:         step2_solve_poisson(Time);
	call	_Z19step2_solve_poissond.isra.0	#
# simulation.h:327:         t_index = t / N_BIN;        // index for XT distributions        
	shrq	$36, %rbp	#, t_index
# simulation.h:333:         step3_move_electrons(t_index);
	movl	%ebp, %edi	# t_index,
	call	_Z20step3_move_electronsi	#
# simulation.h:334:         step4_move_ions(t_index, t);
	movl	%ebx, %esi	# t,
	movl	%ebp, %edi	# t_index,
	call	_Z15step4_move_ionsii	#
# simulation.h:336:         step5_check_boundaries_electrons();
	call	_Z32step5_check_boundaries_electronsv	#
# simulation.h:337:         step6_check_boundaries_ions(t);
	movl	%ebx, %edi	# t,
	call	_Z27step6_check_boundaries_ionsi	#
# simulation.h:339:         step7_collisions_electrons();
	call	_Z26step7_collisions_electronsv	#
# simulation.h:340:         step8_collision_ions(t);
	movl	%ebx, %edi	# t,
	call	_Z20step8_collision_ionsi	#
# simulation.h:342:         step9_collect_xt_data(t_index);
	movl	%ebp, %edi	# t_index,
	call	_Z21step9_collect_xt_datai	#
	imull	$652835029, %ebx, %eax	#, t, tmp114
	rorx	$3, %eax, %eax	#, tmp114, tmp115
# simulation.h:344:         if ((t % 1000) == 0){
	cmpl	$4294967, %eax	#, tmp115
	ja	.L797	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	N_i(%rip), %r9d	# N_i,
	movl	N_e(%rip), %r8d	# N_e,
	movl	cycle(%rip), %edx	# cycle,
	movl	%ebx, %ecx	# t,
	movq	%r13, %rsi	# tmp126,
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
# simulation.h:325:     for (t=0; t<N_T; t++){          // the RF period is divided into N_T equal time intervals (time step DT_E)
	incl	%ebx	# t
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	__printf_chk@PLT	#
# simulation.h:325:     for (t=0; t<N_T; t++){          // the RF period is divided into N_T equal time intervals (time step DT_E)
	cmpl	$4000, %ebx	#, t
	jne	.L798	#,
.L801:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movl	N_i(%rip), %r9d	# N_i,
	movl	N_e(%rip), %r8d	# N_e,
	movl	cycle(%rip), %ecx	# cycle,
	leaq	.LC191(%rip), %rdx	#, tmp124
	movq	datafile(%rip), %rdi	# datafile,
# simulation.h:349: }
	addq	$8, %rsp	#,
	.cfi_def_cfa_offset 40
	popq	%rbx	#
	.cfi_def_cfa_offset 32
	popq	%rbp	#
	.cfi_def_cfa_offset 24
	popq	%r12	#
	.cfi_def_cfa_offset 16
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movl	$2, %esi	#,
# simulation.h:349: }
	popq	%r13	#
	.cfi_def_cfa_offset 8
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	xorl	%eax, %eax	#
	jmp	__fprintf_chk@PLT	#
	.cfi_endproc
.LFE3873:
	.size	_Z12do_one_cyclev, .-_Z12do_one_cyclev
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC192:
	.string	">> eduPIC: starting...\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC193:
	.string	">> eduPIC: **************************************************************************\n"
	.align 8
.LC194:
	.string	">> eduPIC: Copyright (C) 2021 Z. Donko et al.\n"
	.align 8
.LC195:
	.string	">> eduPIC: This program comes with ABSOLUTELY NO WARRANTY\n"
	.align 8
.LC196:
	.string	">> eduPIC: This is free software, you are welcome to use, modify and redistribute it\n"
	.align 8
.LC197:
	.string	">> eduPIC: according to the GNU General Public License, https://www.gnu.org/licenses/\n"
	.align 8
.LC198:
	.string	">> eduPIC: error = need starting_cycle argument\n"
	.section	.rodata.str1.1
.LC199:
	.string	"m"
	.section	.rodata.str1.8
	.align 8
.LC200:
	.string	">> eduPIC: measurement mode: on\n"
	.align 8
.LC201:
	.string	">> eduPIC: measurement mode: off\n"
	.section	.rodata.str1.1
.LC202:
	.string	"a"
.LC203:
	.string	"conv.dat"
.LC204:
	.string	"r"
.LC205:
	.string	"picdata.bin"
	.section	.rodata.str1.8
	.align 8
.LC206:
	.string	">> eduPIC: Warning: Data from previous calculation are detected.\n"
	.align 8
.LC207:
	.string	"           To start a new simulation from the beginning, please delete all output files before running ./eduPIC 0\n"
	.align 8
.LC208:
	.string	"           To continue the existing calculation, please specify the number of cycles to run, e.g. ./eduPIC 100\n"
	.align 8
.LC209:
	.string	">> eduPIC: running initializing cycle\n"
	.align 8
.LC210:
	.string	">> eduPIC: running %d cycle(s)\n"
	.align 8
.LC211:
	.string	">> eduPIC: simulation of %d cycle(s) is completed.\n"
	.section	.text.startup.main,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB3912:
	.cfi_startproc
	endbr64	
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	xorl	%eax, %eax	#
# eduPIC.cc:39: int main (int argc, char *argv[]){
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC193(%rip), %r12	#, tmp107
# eduPIC.cc:39: int main (int argc, char *argv[]){
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
# eduPIC.cc:39: int main (int argc, char *argv[]){
	movq	%rsi, %rbp	# tmp145, argv
	movl	%edi, %ebx	# tmp144, argc
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC192(%rip), %rsi	#, tmp106
	movl	$2, %edi	#,
	call	__printf_chk@PLT	#
	movq	%r12, %rsi	# tmp107,
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
	leaq	.LC194(%rip), %rsi	#, tmp108
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
	leaq	.LC195(%rip), %rsi	#, tmp109
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
	leaq	.LC196(%rip), %rsi	#, tmp110
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
	leaq	.LC197(%rip), %rsi	#, tmp111
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
	xorl	%eax, %eax	#
	movq	%r12, %rsi	# tmp107,
	movl	$2, %edi	#,
	call	__printf_chk@PLT	#
# eduPIC.cc:48:     if (argc == 1) {
	cmpl	$1, %ebx	#, argc
	je	.L819	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	8(%rbp), %rsi	# MEM[(char * *)argv_30(D) + 8B], MEM[(char * *)argv_30(D) + 8B]
	movl	$80, %edx	#,
	leaq	st0(%rip), %rdi	#, tmp115
	call	__strcpy_chk@PLT	#
	movq	%rax, %rdi	#, tmp115
# eduPIC.cc:53:         arg1 = atol(st0);
	call	atol@PLT	#
# eduPIC.cc:53:         arg1 = atol(st0);
	movl	%eax, arg1(%rip)	# tmp146, arg1
# eduPIC.cc:54:         if (argc > 2) {
	cmpl	$2, %ebx	#, argc
	jle	.L805	#,
# eduPIC.cc:55:             if (strcmp (argv[2],"m") == 0){
	movq	16(%rbp), %rdi	# MEM[(char * *)argv_30(D) + 16B], MEM[(char * *)argv_30(D) + 16B]
	leaq	.LC199(%rip), %rsi	#, tmp120
	call	strcmp@PLT	#
# eduPIC.cc:55:             if (strcmp (argv[2],"m") == 0){
	testl	%eax, %eax	# tmp147
	jne	.L806	#,
# eduPIC.cc:56:                 measurement_mode = true;                  // measurements will be done
	movb	$1, measurement_mode(%rip)	#, measurement_mode
.L807:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC200(%rip), %rsi	#, tmp121
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	jmp	.L809	#
.L805:
# eduPIC.cc:62:     if (measurement_mode) {
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	jne	.L807	#,
.L808:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC201(%rip), %rsi	#, tmp122
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
.L809:
# eduPIC.cc:67:     set_electron_cross_sections_ar();
	call	_Z30set_electron_cross_sections_arv	#
# eduPIC.cc:68:     set_ion_cross_sections_ar();
	call	_Z25set_ion_cross_sections_arv	#
# eduPIC.cc:69:     calc_total_cross_sections();
	call	_Z25calc_total_cross_sectionsv	#
# eduPIC.cc:71:     compute_null_collision_params();
	call	_Z29compute_null_collision_paramsv	#
# eduPIC.cc:74:     datafile = fopen("conv.dat","a");
	leaq	.LC202(%rip), %rsi	#, tmp123
	leaq	.LC203(%rip), %rdi	#, tmp124
	call	fopen@PLT	#
# eduPIC.cc:74:     datafile = fopen("conv.dat","a");
	movq	%rax, datafile(%rip)	# tmp148, datafile
# eduPIC.cc:75:     if (arg1 == 0) {
	movl	arg1(%rip), %eax	# arg1, arg1.1_7
# eduPIC.cc:75:     if (arg1 == 0) {
	testl	%eax, %eax	# arg1.1_7
	jne	.L810	#,
# eduPIC.cc:76:         if (FILE *file = fopen("picdata.bin", "r")) { fclose(file);
	leaq	.LC205(%rip), %rdi	#, tmp127
	leaq	.LC204(%rip), %rsi	#, tmp126
	call	fopen@PLT	#
	movq	%rax, %rdi	# tmp149, tmp128
# eduPIC.cc:76:         if (FILE *file = fopen("picdata.bin", "r")) { fclose(file);
	testq	%rax, %rax	# tmp128
	je	.L811	#,
# eduPIC.cc:76:         if (FILE *file = fopen("picdata.bin", "r")) { fclose(file);
	call	fclose@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC206(%rip), %rsi	#, tmp129
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
	leaq	.LC207(%rip), %rsi	#, tmp130
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
	movl	$2, %edi	#,
	leaq	.LC208(%rip), %rsi	#, tmp131
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# eduPIC.cc:80:             exit(0);
	xorl	%edi, %edi	#
	call	exit@PLT	#
.L810:
# eduPIC.cc:90:         no_of_cycles = arg1;                              // run number of cycles specified in command line
	movl	%eax, no_of_cycles(%rip)	# arg1.1_7, no_of_cycles
# eduPIC.cc:91:         load_particle_data();                             // read previous configuration from file
	call	_Z18load_particle_datav	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	no_of_cycles(%rip), %edx	# no_of_cycles,
	leaq	.LC210(%rip), %rsi	#, tmp135
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# eduPIC.cc:93:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {do_one_cycle();}
	movl	cycles_done(%rip), %edx	# cycles_done, cycles_done.4_10
	leal	1(%rdx), %eax	#, tmp136
	movl	%eax, cycle(%rip)	# tmp136, cycle
# eduPIC.cc:93:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {do_one_cycle();}
	movl	no_of_cycles(%rip), %eax	# no_of_cycles, no_of_cycles.7_78
# eduPIC.cc:93:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {do_one_cycle();}
	testl	%eax, %eax	# no_of_cycles.7_78
	jle	.L813	#,
	.p2align 4
	.p2align 3
.L814:
# eduPIC.cc:93:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {do_one_cycle();}
	call	_Z12do_one_cyclev	#
# eduPIC.cc:93:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {do_one_cycle();}
	movl	cycle(%rip), %eax	# cycle, tmp151
# eduPIC.cc:93:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {do_one_cycle();}
	movl	no_of_cycles(%rip), %edx	# no_of_cycles, no_of_cycles
	addl	cycles_done(%rip), %edx	# cycles_done, _16
# eduPIC.cc:93:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {do_one_cycle();}
	incl	%eax	# _13
	movl	%eax, cycle(%rip)	# _13, cycle
# eduPIC.cc:93:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {do_one_cycle();}
	cmpl	%edx, %eax	# _16, _13
	jle	.L814	#,
.L812:
# eduPIC.cc:96:     fclose(datafile);
	movq	datafile(%rip), %rdi	# datafile,
# eduPIC.cc:88:         cycles_done = 1;
	movl	%edx, cycles_done(%rip)	# _16, cycles_done
# eduPIC.cc:96:     fclose(datafile);
	call	fclose@PLT	#
# eduPIC.cc:97:     save_particle_data();
	call	_Z18save_particle_datav	#
# eduPIC.cc:98:     if (measurement_mode) {
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	jne	.L820	#,
.L816:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	no_of_cycles(%rip), %edx	# no_of_cycles,
	leaq	.LC211(%rip), %rsi	#, tmp142
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
# eduPIC.cc:102: }
	xorl	%ebx, %ebx	# argc
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	__printf_chk@PLT	#
.L804:
# eduPIC.cc:102: }
	movl	%ebx, %eax	# argc,
	popq	%rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
.L819:
	.cfi_restore_state
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC198(%rip), %rsi	#, tmp113
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# eduPIC.cc:50:         return 1;
	jmp	.L804	#
.L806:
# eduPIC.cc:58:                 measurement_mode = false;
	movb	$0, measurement_mode(%rip)	#, measurement_mode
	jmp	.L808	#
.L820:
# eduPIC.cc:99:         check_and_save_info();
	call	_Z19check_and_save_infov	#
	jmp	.L816	#
.L813:
# eduPIC.cc:93:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {do_one_cycle();}
	addl	%eax, %edx	# no_of_cycles.7_78, _16
	jmp	.L812	#
.L811:
# eduPIC.cc:84:         init(N_INIT);                                     // seed initial electrons & ions
	movl	$1000, %edi	#,
# eduPIC.cc:82:         no_of_cycles = 1;
	movl	$1, no_of_cycles(%rip)	#, no_of_cycles
# eduPIC.cc:83:         cycle = 1;                                        // init cycle
	movl	$1, cycle(%rip)	#, cycle
# eduPIC.cc:84:         init(N_INIT);                                     // seed initial electrons & ions
	call	_Z4initi	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC209(%rip), %rsi	#, tmp132
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# eduPIC.cc:86:         Time = 0;
	movq	$0x000000000, Time(%rip)	#, Time
# eduPIC.cc:87:         do_one_cycle();
	call	_Z12do_one_cyclev	#
	movl	$1, %edx	#, _16
	jmp	.L812	#
	.cfi_endproc
.LFE3912:
	.size	main, .-main
	.section	.text.startup._GLOBAL__sub_I_main,"ax",@progbits
	.p2align 4
	.type	_GLOBAL__sub_I_main, @function
_GLOBAL__sub_I_main:
.LFB4720:
	.cfi_startproc
	endbr64	
# eduPIC.cc:102: }
	jmp	_Z41__static_initialization_and_destruction_0v	#
	.cfi_endproc
.LFE4720:
	.size	_GLOBAL__sub_I_main, .-_GLOBAL__sub_I_main
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I_main
	.weak	_ZGV3RMB
	.section	.bss._ZGV3RMB,"awG",@nobits,_ZGV3RMB,comdat
	.align 8
	.type	_ZGV3RMB, @gnu_unique_object
	.size	_ZGV3RMB, 8
_ZGV3RMB:
	.zero	8
	.weak	_ZGV3R01
	.section	.bss._ZGV3R01,"awG",@nobits,_ZGV3R01,comdat
	.align 8
	.type	_ZGV3R01, @gnu_unique_object
	.size	_ZGV3R01, 8
_ZGV3R01:
	.zero	8
	.weak	_ZGV5MTgen
	.section	.bss._ZGV5MTgen,"awG",@nobits,_ZGV5MTgen,comdat
	.align 8
	.type	_ZGV5MTgen, @gnu_unique_object
	.size	_ZGV5MTgen, 8
_ZGV5MTgen:
	.zero	8
	.weak	_ZGV2rd
	.section	.bss._ZGV2rd,"awG",@nobits,_ZGV2rd,comdat
	.align 8
	.type	_ZGV2rd, @gnu_unique_object
	.size	_ZGV2rd, 8
_ZGV2rd:
	.zero	8
	.weak	_ZGVZ13random_sampleiiRSt6vectorIiSaIiEEE4pool
	.section	.bss._ZGVZ13random_sampleiiRSt6vectorIiSaIiEEE4pool,"awG",@nobits,_ZGVZ13random_sampleiiRSt6vectorIiSaIiEEE4pool,comdat
	.align 8
	.type	_ZGVZ13random_sampleiiRSt6vectorIiSaIiEEE4pool, @gnu_unique_object
	.size	_ZGVZ13random_sampleiiRSt6vectorIiSaIiEEE4pool, 8
_ZGVZ13random_sampleiiRSt6vectorIiSaIiEEE4pool:
	.zero	8
	.weak	_ZZ13random_sampleiiRSt6vectorIiSaIiEEE4pool
	.section	.bss._ZZ13random_sampleiiRSt6vectorIiSaIiEEE4pool,"awG",@nobits,_ZZ13random_sampleiiRSt6vectorIiSaIiEEE4pool,comdat
	.align 16
	.type	_ZZ13random_sampleiiRSt6vectorIiSaIiEEE4pool, @gnu_unique_object
	.size	_ZZ13random_sampleiiRSt6vectorIiSaIiEEE4pool, 24
_ZZ13random_sampleiiRSt6vectorIiSaIiEEE4pool:
	.zero	24
	.weak	RMB
	.section	.bss.RMB,"awG",@nobits,RMB,comdat
	.align 32
	.type	RMB, @gnu_unique_object
	.size	RMB, 32
RMB:
	.zero	32
	.weak	R01
	.section	.bss.R01,"awG",@nobits,R01,comdat
	.align 16
	.type	R01, @gnu_unique_object
	.size	R01, 16
R01:
	.zero	16
	.weak	MTgen
	.section	.bss.MTgen,"awG",@nobits,MTgen,comdat
	.align 32
	.type	MTgen, @gnu_unique_object
	.size	MTgen, 5000
MTgen:
	.zero	5000
	.weak	rd
	.section	.bss.rd,"awG",@nobits,rd,comdat
	.align 32
	.type	rd, @gnu_unique_object
	.size	rd, 5000
rd:
	.zero	5000
	.weak	P_star_i
	.section	.bss.P_star_i,"awG",@nobits,P_star_i,comdat
	.align 8
	.type	P_star_i, @gnu_unique_object
	.size	P_star_i, 8
P_star_i:
	.zero	8
	.weak	nu_star_i
	.section	.bss.nu_star_i,"awG",@nobits,nu_star_i,comdat
	.align 8
	.type	nu_star_i, @gnu_unique_object
	.size	nu_star_i, 8
nu_star_i:
	.zero	8
	.weak	P_star_e
	.section	.bss.P_star_e,"awG",@nobits,P_star_e,comdat
	.align 8
	.type	P_star_e, @gnu_unique_object
	.size	P_star_e, 8
P_star_e:
	.zero	8
	.weak	nu_star_e
	.section	.bss.nu_star_e,"awG",@nobits,nu_star_e,comdat
	.align 8
	.type	nu_star_e, @gnu_unique_object
	.size	nu_star_e, 8
nu_star_e:
	.zero	8
	.weak	measurement_mode
	.section	.bss.measurement_mode,"awG",@nobits,measurement_mode,comdat
	.type	measurement_mode, @gnu_unique_object
	.size	measurement_mode, 1
measurement_mode:
	.zero	1
	.weak	datafile
	.section	.bss.datafile,"awG",@nobits,datafile,comdat
	.align 8
	.type	datafile, @gnu_unique_object
	.size	datafile, 8
datafile:
	.zero	8
	.weak	st0
	.section	.bss.st0,"awG",@nobits,st0,comdat
	.align 32
	.type	st0, @gnu_unique_object
	.size	st0, 80
st0:
	.zero	80
	.weak	arg1
	.section	.bss.arg1,"awG",@nobits,arg1,comdat
	.align 4
	.type	arg1, @gnu_unique_object
	.size	arg1, 4
arg1:
	.zero	4
	.weak	cycles_done
	.section	.bss.cycles_done,"awG",@nobits,cycles_done,comdat
	.align 4
	.type	cycles_done, @gnu_unique_object
	.size	cycles_done, 4
cycles_done:
	.zero	4
	.weak	no_of_cycles
	.section	.bss.no_of_cycles,"awG",@nobits,no_of_cycles,comdat
	.align 4
	.type	no_of_cycles, @gnu_unique_object
	.size	no_of_cycles, 4
no_of_cycles:
	.zero	4
	.weak	cycle
	.section	.bss.cycle,"awG",@nobits,cycle,comdat
	.align 4
	.type	cycle, @gnu_unique_object
	.size	cycle, 4
cycle:
	.zero	4
	.weak	Time
	.section	.bss.Time,"awG",@nobits,Time,comdat
	.align 8
	.type	Time, @gnu_unique_object
	.size	Time, 8
Time:
	.zero	8
	.weak	N_i_coll
	.section	.bss.N_i_coll,"awG",@nobits,N_i_coll,comdat
	.align 8
	.type	N_i_coll, @gnu_unique_object
	.size	N_i_coll, 8
N_i_coll:
	.zero	8
	.weak	N_e_coll
	.section	.bss.N_e_coll,"awG",@nobits,N_e_coll,comdat
	.align 8
	.type	N_e_coll, @gnu_unique_object
	.size	N_e_coll, 8
N_e_coll:
	.zero	8
	.weak	mean_energy_counter_center
	.section	.bss.mean_energy_counter_center,"awG",@nobits,mean_energy_counter_center,comdat
	.align 8
	.type	mean_energy_counter_center, @gnu_unique_object
	.size	mean_energy_counter_center, 8
mean_energy_counter_center:
	.zero	8
	.weak	mean_energy_accu_center
	.section	.bss.mean_energy_accu_center,"awG",@nobits,mean_energy_accu_center,comdat
	.align 8
	.type	mean_energy_accu_center, @gnu_unique_object
	.size	mean_energy_accu_center, 8
mean_energy_accu_center:
	.zero	8
	.weak	ioniz_rate_xt
	.section	.bss.ioniz_rate_xt,"awG",@nobits,ioniz_rate_xt,comdat
	.align 32
	.type	ioniz_rate_xt, @gnu_unique_object
	.size	ioniz_rate_xt, 640000
ioniz_rate_xt:
	.zero	640000
	.weak	counter_i_xt
	.section	.bss.counter_i_xt,"awG",@nobits,counter_i_xt,comdat
	.align 32
	.type	counter_i_xt, @gnu_unique_object
	.size	counter_i_xt, 640000
counter_i_xt:
	.zero	640000
	.weak	counter_e_xt
	.section	.bss.counter_e_xt,"awG",@nobits,counter_e_xt,comdat
	.align 32
	.type	counter_e_xt, @gnu_unique_object
	.size	counter_e_xt, 640000
counter_e_xt:
	.zero	640000
	.weak	meanei_xt
	.section	.bss.meanei_xt,"awG",@nobits,meanei_xt,comdat
	.align 32
	.type	meanei_xt, @gnu_unique_object
	.size	meanei_xt, 640000
meanei_xt:
	.zero	640000
	.weak	meanee_xt
	.section	.bss.meanee_xt,"awG",@nobits,meanee_xt,comdat
	.align 32
	.type	meanee_xt, @gnu_unique_object
	.size	meanee_xt, 640000
meanee_xt:
	.zero	640000
	.weak	poweri_xt
	.section	.bss.poweri_xt,"awG",@nobits,poweri_xt,comdat
	.align 32
	.type	poweri_xt, @gnu_unique_object
	.size	poweri_xt, 640000
poweri_xt:
	.zero	640000
	.weak	powere_xt
	.section	.bss.powere_xt,"awG",@nobits,powere_xt,comdat
	.align 32
	.type	powere_xt, @gnu_unique_object
	.size	powere_xt, 640000
powere_xt:
	.zero	640000
	.weak	ji_xt
	.section	.bss.ji_xt,"awG",@nobits,ji_xt,comdat
	.align 32
	.type	ji_xt, @gnu_unique_object
	.size	ji_xt, 640000
ji_xt:
	.zero	640000
	.weak	je_xt
	.section	.bss.je_xt,"awG",@nobits,je_xt,comdat
	.align 32
	.type	je_xt, @gnu_unique_object
	.size	je_xt, 640000
je_xt:
	.zero	640000
	.weak	ui_xt
	.section	.bss.ui_xt,"awG",@nobits,ui_xt,comdat
	.align 32
	.type	ui_xt, @gnu_unique_object
	.size	ui_xt, 640000
ui_xt:
	.zero	640000
	.weak	ue_xt
	.section	.bss.ue_xt,"awG",@nobits,ue_xt,comdat
	.align 32
	.type	ue_xt, @gnu_unique_object
	.size	ue_xt, 640000
ue_xt:
	.zero	640000
	.weak	ni_xt
	.section	.bss.ni_xt,"awG",@nobits,ni_xt,comdat
	.align 32
	.type	ni_xt, @gnu_unique_object
	.size	ni_xt, 640000
ni_xt:
	.zero	640000
	.weak	ne_xt
	.section	.bss.ne_xt,"awG",@nobits,ne_xt,comdat
	.align 32
	.type	ne_xt, @gnu_unique_object
	.size	ne_xt, 640000
ne_xt:
	.zero	640000
	.weak	efield_xt
	.section	.bss.efield_xt,"awG",@nobits,efield_xt,comdat
	.align 32
	.type	efield_xt, @gnu_unique_object
	.size	efield_xt, 640000
efield_xt:
	.zero	640000
	.weak	pot_xt
	.section	.bss.pot_xt,"awG",@nobits,pot_xt,comdat
	.align 32
	.type	pot_xt, @gnu_unique_object
	.size	pot_xt, 640000
pot_xt:
	.zero	640000
	.weak	mean_i_energy_gnd
	.section	.bss.mean_i_energy_gnd,"awG",@nobits,mean_i_energy_gnd,comdat
	.align 8
	.type	mean_i_energy_gnd, @gnu_unique_object
	.size	mean_i_energy_gnd, 8
mean_i_energy_gnd:
	.zero	8
	.weak	mean_i_energy_pow
	.section	.bss.mean_i_energy_pow,"awG",@nobits,mean_i_energy_pow,comdat
	.align 8
	.type	mean_i_energy_pow, @gnu_unique_object
	.size	mean_i_energy_pow, 8
mean_i_energy_pow:
	.zero	8
	.weak	ifed_gnd
	.section	.bss.ifed_gnd,"awG",@nobits,ifed_gnd,comdat
	.align 32
	.type	ifed_gnd, @gnu_unique_object
	.size	ifed_gnd, 800
ifed_gnd:
	.zero	800
	.weak	ifed_pow
	.section	.bss.ifed_pow,"awG",@nobits,ifed_pow,comdat
	.align 32
	.type	ifed_pow, @gnu_unique_object
	.size	ifed_pow, 800
ifed_pow:
	.zero	800
	.weak	eepf
	.section	.bss.eepf,"awG",@nobits,eepf,comdat
	.align 32
	.type	eepf, @gnu_unique_object
	.size	eepf, 16000
eepf:
	.zero	16000
	.weak	N_i_abs_gnd
	.section	.bss.N_i_abs_gnd,"awG",@nobits,N_i_abs_gnd,comdat
	.align 8
	.type	N_i_abs_gnd, @gnu_unique_object
	.size	N_i_abs_gnd, 8
N_i_abs_gnd:
	.zero	8
	.weak	N_i_abs_pow
	.section	.bss.N_i_abs_pow,"awG",@nobits,N_i_abs_pow,comdat
	.align 8
	.type	N_i_abs_pow, @gnu_unique_object
	.size	N_i_abs_pow, 8
N_i_abs_pow:
	.zero	8
	.weak	N_e_abs_gnd
	.section	.bss.N_e_abs_gnd,"awG",@nobits,N_e_abs_gnd,comdat
	.align 8
	.type	N_e_abs_gnd, @gnu_unique_object
	.size	N_e_abs_gnd, 8
N_e_abs_gnd:
	.zero	8
	.weak	N_e_abs_pow
	.section	.bss.N_e_abs_pow,"awG",@nobits,N_e_abs_pow,comdat
	.align 8
	.type	N_e_abs_pow, @gnu_unique_object
	.size	N_e_abs_pow, 8
N_e_abs_pow:
	.zero	8
	.weak	cumul_i_density
	.section	.bss.cumul_i_density,"awG",@nobits,cumul_i_density,comdat
	.align 32
	.type	cumul_i_density, @gnu_unique_object
	.size	cumul_i_density, 3200
cumul_i_density:
	.zero	3200
	.weak	cumul_e_density
	.section	.bss.cumul_e_density,"awG",@nobits,cumul_e_density,comdat
	.align 32
	.type	cumul_e_density, @gnu_unique_object
	.size	cumul_e_density, 3200
cumul_e_density:
	.zero	3200
	.weak	i_density
	.section	.bss.i_density,"awG",@nobits,i_density,comdat
	.align 32
	.type	i_density, @gnu_unique_object
	.size	i_density, 3200
i_density:
	.zero	3200
	.weak	e_density
	.section	.bss.e_density,"awG",@nobits,e_density,comdat
	.align 32
	.type	e_density, @gnu_unique_object
	.size	e_density, 3200
e_density:
	.zero	3200
	.weak	pot
	.section	.bss.pot,"awG",@nobits,pot,comdat
	.align 32
	.type	pot, @gnu_unique_object
	.size	pot, 3200
pot:
	.zero	3200
	.weak	efield
	.section	.bss.efield,"awG",@nobits,efield,comdat
	.align 32
	.type	efield, @gnu_unique_object
	.size	efield, 3200
efield:
	.zero	3200
	.weak	vz_i
	.section	.bss.vz_i,"awG",@nobits,vz_i,comdat
	.align 32
	.type	vz_i, @gnu_unique_object
	.size	vz_i, 8000000
vz_i:
	.zero	8000000
	.weak	vy_i
	.section	.bss.vy_i,"awG",@nobits,vy_i,comdat
	.align 32
	.type	vy_i, @gnu_unique_object
	.size	vy_i, 8000000
vy_i:
	.zero	8000000
	.weak	vx_i
	.section	.bss.vx_i,"awG",@nobits,vx_i,comdat
	.align 32
	.type	vx_i, @gnu_unique_object
	.size	vx_i, 8000000
vx_i:
	.zero	8000000
	.weak	x_i
	.section	.bss.x_i,"awG",@nobits,x_i,comdat
	.align 32
	.type	x_i, @gnu_unique_object
	.size	x_i, 8000000
x_i:
	.zero	8000000
	.weak	vz_e
	.section	.bss.vz_e,"awG",@nobits,vz_e,comdat
	.align 32
	.type	vz_e, @gnu_unique_object
	.size	vz_e, 8000000
vz_e:
	.zero	8000000
	.weak	vy_e
	.section	.bss.vy_e,"awG",@nobits,vy_e,comdat
	.align 32
	.type	vy_e, @gnu_unique_object
	.size	vy_e, 8000000
vy_e:
	.zero	8000000
	.weak	vx_e
	.section	.bss.vx_e,"awG",@nobits,vx_e,comdat
	.align 32
	.type	vx_e, @gnu_unique_object
	.size	vx_e, 8000000
vx_e:
	.zero	8000000
	.weak	x_e
	.section	.bss.x_e,"awG",@nobits,x_e,comdat
	.align 32
	.type	x_e, @gnu_unique_object
	.size	x_e, 8000000
x_e:
	.zero	8000000
	.weak	N_i
	.section	.bss.N_i,"awG",@nobits,N_i,comdat
	.align 4
	.type	N_i, @gnu_unique_object
	.size	N_i, 4
N_i:
	.zero	4
	.weak	N_e
	.section	.bss.N_e,"awG",@nobits,N_e,comdat
	.align 4
	.type	N_e, @gnu_unique_object
	.size	N_e, 4
N_e:
	.zero	4
	.weak	sigma_tot_i
	.section	.bss.sigma_tot_i,"awG",@nobits,sigma_tot_i,comdat
	.align 32
	.type	sigma_tot_i, @gnu_unique_object
	.size	sigma_tot_i, 8000000
sigma_tot_i:
	.zero	8000000
	.weak	sigma_tot_e
	.section	.bss.sigma_tot_e,"awG",@nobits,sigma_tot_e,comdat
	.align 32
	.type	sigma_tot_e, @gnu_unique_object
	.size	sigma_tot_e, 8000000
sigma_tot_e:
	.zero	8000000
	.weak	sigma
	.section	.bss.sigma,"awG",@nobits,sigma,comdat
	.align 32
	.type	sigma, @gnu_unique_object
	.size	sigma, 40000000
sigma:
	.zero	40000000
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC2:
	.long	-1405695074
	.long	1072703736
	.align 8
.LC3:
	.long	-755914244
	.long	1062232653
	.align 8
.LC6:
	.long	1717986918
	.long	1074423398
	.align 8
.LC7:
	.long	0
	.long	1075314688
	.align 8
.LC8:
	.long	1717986918
	.long	1073112678
	.align 8
.LC9:
	.long	0
	.long	1076756480
	.align 8
.LC10:
	.long	858993459
	.long	1072902963
	.align 8
.LC11:
	.long	-1717986918
	.long	1072798105
	.align 8
.LC12:
	.long	0
	.long	1072693248
	.align 8
.LC13:
	.long	0
	.long	1074003968
	.align 8
.LC14:
	.long	0
	.long	1075183616
	.align 8
.LC15:
	.long	1717986918
	.long	1074816614
	.align 8
.LC16:
	.long	0
	.long	1078853632
	.align 8
.LC17:
	.long	0
	.long	1076101120
	.align 8
.LC18:
	.long	0
	.long	1074266112
	.align 8
.LC19:
	.long	0
	.long	1076363264
	.align 8
.LC20:
	.long	-1717986918
	.long	1068079513
	.align 8
.LC21:
	.long	1202590843
	.long	1065646817
	.align 8
.LC22:
	.long	0
	.long	1076297728
	.align 8
.LC23:
	.long	1717986918
	.long	1074161254
	.align 8
.LC24:
	.long	0
	.long	1077346304
	.align 8
.LC25:
	.long	1717986918
	.long	1073636966
	.align 8
.LC26:
	.long	0
	.long	1079246848
	.align 8
.LC27:
	.long	-1340029796
	.long	1067542642
	.align 8
.LC28:
	.long	-549755814
	.long	1066896719
	.align 8
.LC29:
	.long	-1717986918
	.long	1076861337
	.align 8
.LC30:
	.long	210911779
	.long	1002937505
	.align 8
.LC31:
	.long	0
	.long	1079083008
	.section	.rodata.cst16
	.align 16
.LC32:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC33:
	.long	0
	.long	1075970048
	.align 8
.LC34:
	.long	-343597384
	.long	1068415057
	.align 8
.LC35:
	.long	0
	.long	1083068416
	.align 8
.LC36:
	.long	858993459
	.long	1071854387
	.align 8
.LC37:
	.long	-1717986918
	.long	1069128089
	.align 8
.LC38:
	.long	-755914244
	.long	1063281229
	.align 8
.LC40:
	.long	-1717986918
	.long	-1078355559
	.align 8
.LC41:
	.long	-343597384
	.long	1066317905
	.align 8
.LC42:
	.long	0
	.long	-1075838976
	.align 8
.LC43:
	.long	1337381548
	.long	1007518665
	.align 8
.LC44:
	.long	-70705663
	.long	1008083670
	.align 8
.LC45:
	.long	-1320458388
	.long	1010120376
	.align 8
.LC46:
	.long	0
	.long	1071644672
	.align 8
.LC48:
	.long	-192165988
	.long	1146883006
	.align 8
.LC51:
	.long	630504279
	.long	1007133914
	.align 8
.LC52:
	.long	-1008331679
	.long	967997916
	.align 8
.LC53:
	.long	-515044572
	.long	983861149
	.align 8
.LC54:
	.long	-485508795
	.long	1100238897
	.align 8
.LC55:
	.long	0
	.long	1081032704
	.align 8
.LC57:
	.long	-960023692
	.long	-1065634245
	.align 8
.LC60:
	.long	0
	.long	-1073741824
	.align 8
.LC62:
	.long	0
	.long	1086270464
	.align 8
.LC65:
	.long	-402585907
	.long	1058041040
	.align 8
.LC66:
	.long	-251268040
	.long	1035171958
	.align 8
.LC67:
	.long	0
	.long	1087319040
	.align 8
.LC69:
	.long	1998452712
	.long	1035224431
	.align 8
.LC70:
	.long	1424324066
	.long	1039750859
	.align 8
.LC73:
	.long	1998452712
	.long	-1112259217
	.align 8
.LC74:
	.long	1424324066
	.long	-1107732789
	.align 8
.LC76:
	.long	785383423
	.long	1118065246
	.align 8
.LC77:
	.long	-328822563
	.long	1074393336
	.align 8
.LC78:
	.long	-1008331679
	.long	966949340
	.align 8
.LC79:
	.long	1889785611
	.long	1065814589
	.align 8
.LC80:
	.long	-1030792150
	.long	1066150133
	.align 8
.LC81:
	.long	547230944
	.long	1062022858
	.align 8
.LC82:
	.long	-1717986918
	.long	1067030937
	.align 8
.LC90:
	.long	0
	.long	1085227008
	.align 8
.LC98:
	.long	0
	.long	1080623104
	.align 8
.LC99:
	.long	1424324067
	.long	1039750859
	.set	.LC101,.LC32
	.align 8
.LC102:
	.long	-251268040
	.long	1034123382
	.align 8
.LC103:
	.long	0
	.long	1097456920
	.align 8
.LC114:
	.long	0
	.long	1081466880
	.align 8
.LC116:
	.long	0
	.long	1089541888
	.align 8
.LC129:
	.long	-1717986918
	.long	1070176665
	.align 8
.LC135:
	.long	-1971075289
	.long	1077963452
	.align 8
.LC140:
	.long	-350469331
	.long	1058682594
	.align 8
.LC141:
	.long	-632077287
	.long	1047776206
	.align 8
.LC148:
	.long	0
	.long	1089701888
	.align 8
.LC155:
	.long	0
	.long	1075838976
	.align 8
.LC156:
	.long	0
	.long	1077936128
	.align 8
.LC157:
	.long	379996434
	.long	1078972162
	.align 8
.LC158:
	.long	1413754136
	.long	1072243195
	.align 8
.LC159:
	.long	0
	.long	1074790400
	.align 8
.LC160:
	.long	536225542
	.long	1072958867
	.align 8
.LC161:
	.long	262559291
	.long	1081138792
	.align 8
.LC171:
	.long	-1
	.long	1072693247
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC172:
	.long	1333788672
	.set	.LC173,.LC175+4
	.align 4
.LC174:
	.long	1593835520
	.section	.rodata.cst8
	.align 8
.LC175:
	.long	0
	.long	1073741824
	.align 8
.LC176:
	.long	0
	.long	-1074790400
	.align 8
.LC177:
	.long	-2
	.long	1071644671
	.align 8
.LC178:
	.long	1413754136
	.long	1073291771
	.align 8
.LC179:
	.long	856972295
	.long	1016178214
	.align 8
.LC180:
	.long	-16936979
	.long	1055706213
	.align 8
.LC181:
	.long	1413754136
	.long	1075388923
	.align 8
.LC182:
	.long	-889002329
	.long	1010892412
	.align 8
.LC183:
	.long	85752064
	.long	1011308849
	.align 8
.LC184:
	.long	0
	.long	1077149696
	.align 8
.LC185:
	.long	1413754136
	.long	1074340347
	.align 8
.LC186:
	.long	865730819
	.long	1072693219
	.align 8
.LC187:
	.long	1413754136
	.long	-1074191877
	.align 8
.LC189:
	.long	-515044572
	.long	982812573
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.rel.local.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align 8
	.type	DW.ref.__gxx_personality_v0, @object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.hidden	__dso_handle
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
