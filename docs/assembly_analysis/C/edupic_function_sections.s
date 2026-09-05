	.file	"eduPIC.cc"
# GNU C++17 (Ubuntu 13.3.0-6ubuntu2~24.04.1) version 13.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 13.3.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -march=znver4 -O3 -std=c++17 -fopenmp -ffunction-sections -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.section	.text._ZN13WorkerBuffers12init_buffersEi._omp_fn.0,"ax",@progbits
	.p2align 4
	.type	_ZN13WorkerBuffers12init_buffersEi._omp_fn.0, @function
_ZN13WorkerBuffers12init_buffersEi._omp_fn.0:
.LFB11231:
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
	pushq	%rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
# C/parallel-only-omp/state.h:247:         #pragma omp parallel for schedule(static)
	movq	%rdi, %rbp	# tmp146, .omp_data_i
	call	omp_get_num_threads@PLT	#
	movl	%eax, %ebx	# tmp147, _10
	call	omp_get_thread_num@PLT	#
	movl	%eax, %ecx	# tmp148, _11
	movl	8(%rbp), %eax	# *.omp_data_i_7(D).num_threads, *.omp_data_i_7(D).num_threads
	cltd
	idivl	%ebx	# _10
	cmpl	%edx, %ecx	# tt.179_2, _11
	jl	.L2	#,
.L5:
	imull	%eax, %ecx	# q.178_1, tmp122
	addl	%ecx, %edx	# tmp122, _16
	leal	(%rax,%rdx), %ecx	#, tmp123
	cmpl	%ecx, %edx	# tmp123, _16
	jge	.L7	#,
	movq	0(%rbp), %rcx	# *.omp_data_i_7(D).this, this
	movslq	%edx, %rdx	# _16, _20
	movl	%eax, %eax	# q.178_1, q.178_1
	imulq	$3328, %rdx, %r12	#, _20, _5
	addq	%rdx, %rax	# _20, tmp128
	imulq	$3200, %rdx, %rbp	#, _20, _64
	imulq	$3328, %rax, %rax	#, tmp128, tmp129
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	(%rcx), %r14	# MEM[(struct vector *)this_8].D.102928._M_impl.D.102267._M_start, _43
	movq	48(%rcx), %r13	# MEM[(struct vector *)this_8 + 48B].D.103980._M_impl.D.103319._M_start, ivtmp.885
	leaq	(%r14,%r12), %rbx	#, ivtmp.883
	addq	%rbp, %r13	# _64, ivtmp.885
	addq	24(%rcx), %r12	# MEM[(struct vector *)this_8 + 24B].D.102928._M_impl.D.102267._M_start, ivtmp.884
	addq	192(%rcx), %rbp	# MEM[(struct vector *)this_8 + 192B].D.103980._M_impl.D.103319._M_start, ivtmp.886
	addq	%rax, %r14	# tmp129, _61
	.p2align 4
	.p2align 3
.L4:
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%rbx, %rdi	# ivtmp.883,
	movl	$3328, %edx	#,
	xorl	%esi, %esi	#
	addq	$3328, %rbx	#, ivtmp.883
	call	memset@PLT	#
	movq	%r12, %rdi	# ivtmp.884,
	movl	$3328, %edx	#,
	xorl	%esi, %esi	#
	call	memset@PLT	#
	movq	%r13, %rdi	# ivtmp.885,
	movl	$3200, %edx	#,
	xorl	%esi, %esi	#
	call	memset@PLT	#
	movq	%rbp, %rdi	# ivtmp.886,
	movl	$3200, %edx	#,
	xorl	%esi, %esi	#
	call	memset@PLT	#
	addq	$3328, %r12	#, ivtmp.884
	addq	$3200, %r13	#, ivtmp.885
	addq	$3200, %rbp	#, ivtmp.886
	cmpq	%r14, %rbx	# _61, ivtmp.883
	jne	.L4	#,
.L7:
# C/parallel-only-omp/state.h:247:         #pragma omp parallel for schedule(static)
	popq	%rbx	#
	.cfi_remember_state
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
.L2:
	.cfi_restore_state
	incl	%eax	# q.178_1
	xorl	%edx, %edx	# tt.179_2
	jmp	.L5	#
	.cfi_endproc
.LFE11231:
	.size	_ZN13WorkerBuffers12init_buffersEi._omp_fn.0, .-_ZN13WorkerBuffers12init_buffersEi._omp_fn.0
	.section	.text._ZNSt13random_deviceD2Ev,"axG",@progbits,_ZNSt13random_deviceD5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt13random_deviceD2Ev
	.type	_ZNSt13random_deviceD2Ev, @function
_ZNSt13random_deviceD2Ev:
.LFB2493:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA2493
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
.LFE2493:
	.globl	__gxx_personality_v0
	.section	.gcc_except_table._ZNSt13random_deviceD2Ev,"aG",@progbits,_ZNSt13random_deviceD5Ev,comdat
.LLSDA2493:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE2493-.LLSDACSB2493
.LLSDACSB2493:
.LLSDACSE2493:
	.section	.text._ZNSt13random_deviceD2Ev,"axG",@progbits,_ZNSt13random_deviceD5Ev,comdat
	.size	_ZNSt13random_deviceD2Ev, .-_ZNSt13random_deviceD2Ev
	.weak	_ZNSt13random_deviceD1Ev
	.set	_ZNSt13random_deviceD1Ev,_ZNSt13random_deviceD2Ev
	.section	.text._ZN13WorkerBuffersD2Ev,"axG",@progbits,_ZN13WorkerBuffersD5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZN13WorkerBuffersD2Ev
	.type	_ZN13WorkerBuffersD2Ev, @function
_ZN13WorkerBuffersD2Ev:
.LFB11222:
	.cfi_startproc
	endbr64	
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp	# tmp186, this
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	360(%rdi), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 360B]._M_impl.D.108580._M_start, _159
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _159
	je	.L13	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	376(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 360B]._M_impl.D.108580._M_end_of_storage, tmp152
# /usr/include/c++/13/bits/new_allocator.h:167: 	    _GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n),
	movl	$64, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rdi, %rsi	# _159, tmp152
# /usr/include/c++/13/bits/new_allocator.h:167: 	    _GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n),
	call	_ZdlPvmSt11align_val_t@PLT	#
.L13:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	336(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 336B]._M_impl.D.108580._M_start, _151
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _151
	je	.L14	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	352(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 336B]._M_impl.D.108580._M_end_of_storage, tmp154
# /usr/include/c++/13/bits/new_allocator.h:167: 	    _GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n),
	movl	$64, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rdi, %rsi	# _151, tmp154
# /usr/include/c++/13/bits/new_allocator.h:167: 	    _GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n),
	call	_ZdlPvmSt11align_val_t@PLT	#
.L14:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	312(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 312B]._M_impl.D.107529._M_start, _143
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _143
	je	.L15	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	328(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 312B]._M_impl.D.107529._M_end_of_storage, tmp156
	subq	%rdi, %rsi	# _143, tmp156
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L15:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	288(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 288B]._M_impl.D.107529._M_start, _135
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _135
	je	.L16	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	304(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 288B]._M_impl.D.107529._M_end_of_storage, tmp158
	subq	%rdi, %rsi	# _135, tmp158
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L16:
# /usr/include/c++/13/bits/stl_vector.h:735: 	std::_Destroy(this->_M_impl._M_start, this->_M_impl._M_finish,
	movq	272(%rbp), %r12	# MEM[(struct vector *)this_17(D) + 264B].D.107139._M_impl.D.106478._M_finish, _124
	movq	264(%rbp), %rbx	# MEM[(struct vector *)this_17(D) + 264B].D.107139._M_impl.D.106478._M_start, __first
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	cmpq	%rbx, %r12	# __first, _124
	je	.L17	#,
	.p2align 4
	.p2align 3
.L21:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	(%rbx), %rdi	# MEM[(int * *)__first_156], _172
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _172
	je	.L18	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	16(%rbx), %rsi	# MEM[(int * *)__first_156 + 16B], tmp160
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	addq	$24, %rbx	#, __first
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rdi, %rsi	# _172, tmp160
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	cmpq	%rbx, %r12	# __first, _124
	jne	.L21	#,
.L20:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	264(%rbp), %rbx	# MEM[(struct _Vector_base *)this_17(D) + 264B]._M_impl.D.106478._M_start, __first
.L17:
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rbx, %rbx	# __first
	je	.L22	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	280(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 264B]._M_impl.D.106478._M_end_of_storage, tmp162
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%rbx, %rdi	# __first,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rbx, %rsi	# __first, tmp162
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L22:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	240(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 240B]._M_impl.D.103319._M_start, _119
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _119
	je	.L23	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	256(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 240B]._M_impl.D.103319._M_end_of_storage, tmp164
	subq	%rdi, %rsi	# _119, tmp164
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L23:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	216(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 216B]._M_impl.D.103319._M_start, _111
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _111
	je	.L24	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	232(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 216B]._M_impl.D.103319._M_end_of_storage, tmp166
	subq	%rdi, %rsi	# _111, tmp166
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L24:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	192(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 192B]._M_impl.D.103319._M_start, _103
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _103
	je	.L25	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	208(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 192B]._M_impl.D.103319._M_end_of_storage, tmp168
	subq	%rdi, %rsi	# _103, tmp168
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L25:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	168(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 168B]._M_impl.D.105423._M_start, _95
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _95
	je	.L26	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	184(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 168B]._M_impl.D.105423._M_end_of_storage, tmp170
# /usr/include/c++/13/bits/new_allocator.h:167: 	    _GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n),
	movl	$64, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rdi, %rsi	# _95, tmp170
# /usr/include/c++/13/bits/new_allocator.h:167: 	    _GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n),
	call	_ZdlPvmSt11align_val_t@PLT	#
.L26:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	144(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 144B]._M_impl.D.104373._M_start, _87
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _87
	je	.L27	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	160(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 144B]._M_impl.D.104373._M_end_of_storage, tmp172
	subq	%rdi, %rsi	# _87, tmp172
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L27:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	120(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 120B]._M_impl.D.103319._M_start, _79
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _79
	je	.L28	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	136(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 120B]._M_impl.D.103319._M_end_of_storage, tmp174
	subq	%rdi, %rsi	# _79, tmp174
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L28:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	96(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 96B]._M_impl.D.103319._M_start, _71
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _71
	je	.L29	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	112(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 96B]._M_impl.D.103319._M_end_of_storage, tmp176
	subq	%rdi, %rsi	# _71, tmp176
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L29:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	72(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 72B]._M_impl.D.103319._M_start, _63
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _63
	je	.L30	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	88(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 72B]._M_impl.D.103319._M_end_of_storage, tmp178
	subq	%rdi, %rsi	# _63, tmp178
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L30:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	48(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 48B]._M_impl.D.103319._M_start, _55
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _55
	je	.L31	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	64(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 48B]._M_impl.D.103319._M_end_of_storage, tmp180
	subq	%rdi, %rsi	# _55, tmp180
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L31:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	24(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 24B]._M_impl.D.102267._M_start, _47
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _47
	je	.L32	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	40(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 24B]._M_impl.D.102267._M_end_of_storage, tmp182
	subq	%rdi, %rsi	# _47, tmp182
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L32:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	0(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D)]._M_impl.D.102267._M_start, _39
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _39
	je	.L79	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	16(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D)]._M_impl.D.102267._M_end_of_storage, MEM[(struct _Vector_base *)this_17(D)]._M_impl.D.102267._M_end_of_storage
# C/parallel-only-omp/state.h:179: struct WorkerBuffers {
	popq	%rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rdi, %rsi	# _39, tmp184
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	jmp	_ZdlPvm@PLT	#
	.p2align 4
	.p2align 3
.L18:
	.cfi_restore_state
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	addq	$24, %rbx	#, __first
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	cmpq	%rbx, %r12	# __first, _124
	jne	.L21	#,
	jmp	.L20	#
	.p2align 4
	.p2align 3
.L79:
# C/parallel-only-omp/state.h:179: struct WorkerBuffers {
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE11222:
	.size	_ZN13WorkerBuffersD2Ev, .-_ZN13WorkerBuffersD2Ev
	.weak	_ZN13WorkerBuffersD1Ev
	.set	_ZN13WorkerBuffersD1Ev,_ZN13WorkerBuffersD2Ev
	.section	.rodata._Z30set_electron_cross_sections_arv.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	">> eduPIC: Setting e- / Ar cross sections\n"
	.section	.text._Z30set_electron_cross_sections_arv,"axG",@progbits,_Z30set_electron_cross_sections_arv,comdat
	.p2align 4
	.weak	_Z30set_electron_cross_sections_arv
	.type	_Z30set_electron_cross_sections_arv, @function
_Z30set_electron_cross_sections_arv:
.LFB9860:
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
	leaq	.LC3(%rip), %rsi	#, tmp151
# C/parallel-only-omp/cross_sections.h:16: inline void set_electron_cross_sections_ar(void){
	pushq	%rbx	#
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	leaq	sigma(%rip), %rbx	#, ivtmp.917
# C/parallel-only-omp/cross_sections.h:16: inline void set_electron_cross_sections_ar(void){
	subq	$72, %rsp	#,
	.cfi_def_cfa_offset 112
	xorl	%ebp, %ebp	# i
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	__printf_chk@PLT	#
# C/parallel-only-omp/cross_sections.h:22:         if (i == 0) {en = DE_CS;} else {en = DE_CS * i;}                            // Energia kinetyczna elektronu [eV]
	movq	.LC1(%rip), %rax	#, tmp284
	vmovsd	.LC0(%rip), %xmm0	#, _126
	movq	%rax, 8(%rsp)	# tmp284, %sfp
	jmp	.L89	#
	.p2align 4
	.p2align 3
.L85:
# C/parallel-only-omp/cross_sections.h:21:     for(i=0; i<CS_RANGES; i++){
	incl	%ebp	# i
# C/parallel-only-omp/cross_sections.h:35:         sigma[E_ELA][i] = qmel * 1.0e-20;       // Przekrój czynny na zderzenia sprężyste e- / Ar [m^2]
	vmulsd	.LC29(%rip), %xmm2, %xmm2	#, qmel, tmp230
# C/parallel-only-omp/cross_sections.h:36:         sigma[E_EXC][i] = qexc * 1.0e-20;       // Przekrój czynny na wzbudzenie e- / Ar [m^2]
	vmovsd	%xmm1, 8000000(%rbx)	# _129, MEM[(double *)_114 + 8000000B]
# C/parallel-only-omp/cross_sections.h:35:         sigma[E_ELA][i] = qmel * 1.0e-20;       // Przekrój czynny na zderzenia sprężyste e- / Ar [m^2]
	vmovsd	%xmm2, (%rbx)	# tmp230, MEM[(double *)_114]
# C/parallel-only-omp/cross_sections.h:37:         sigma[E_ION][i] = qion * 1.0e-20;       // Przekrój czynny na jonizację e- / Ar [m^2]
	vmovsd	%xmm0, 16000000(%rbx)	# _131, MEM[(double *)_114 + 16000000B]
# C/parallel-only-omp/cross_sections.h:21:     for(i=0; i<CS_RANGES; i++){
	addq	$8, %rbx	#, ivtmp.917
	cmpl	$1000000, %ebp	#, i
	je	.L95	#,
# C/parallel-only-omp/cross_sections.h:22:         if (i == 0) {en = DE_CS;} else {en = DE_CS * i;}                            // Energia kinetyczna elektronu [eV]
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp318
	vcvtsi2sdl	%ebp, %xmm4, %xmm0	# i, tmp318, tmp277
# C/parallel-only-omp/cross_sections.h:22:         if (i == 0) {en = DE_CS;} else {en = DE_CS * i;}                            // Energia kinetyczna elektronu [eV]
	vmulsd	.LC1(%rip), %xmm0, %xmm5	#, tmp232, en
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vdivsd	.LC35(%rip), %xmm5, %xmm0	#, en, _122
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vdivsd	.LC36(%rip), %xmm5, %xmm1	#, en, tmp235
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vaddsd	.LC10(%rip), %xmm1, %xmm1	#, tmp235, tmp237
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# _122, tmp237, _126
# C/parallel-only-omp/cross_sections.h:22:         if (i == 0) {en = DE_CS;} else {en = DE_CS * i;}                            // Energia kinetyczna elektronu [eV]
	vmovsd	%xmm5, 8(%rsp)	# en, %sfp
.L89:
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vmovsd	.LC4(%rip), %xmm1	#,
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vmovsd	.LC5(%rip), %xmm4	#, tmp286
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	.LC6(%rip), %xmm1	#,
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vdivsd	%xmm0, %xmm4, %xmm7	# tmp263, tmp286, _8
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	8(%rsp), %xmm0	# %sfp,
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vmovq	%xmm7, %r14	# _8, _8
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	call	pow@PLT	#
	vmovsd	%xmm0, 16(%rsp)	# tmp264, %sfp
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	8(%rsp), %xmm7	# %sfp, en
	vmovsd	.LC8(%rip), %xmm1	#,
	vdivsd	.LC7(%rip), %xmm7, %xmm4	#, en, _11
	vmovsd	%xmm4, 40(%rsp)	# _11, %sfp
	vmovsd	%xmm4, %xmm4, %xmm0	# _11,
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	.LC9(%rip), %xmm4	#, tmp289
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vaddsd	.LC10(%rip), %xmm0, %xmm0	#, tmp265, tmp159
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmulsd	16(%rsp), %xmm4, %xmm1	# %sfp, tmp289, tmp157
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	8(%rsp), %xmm7	# %sfp, en
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vdivsd	%xmm0, %xmm1, %xmm4	# tmp159, tmp157, _14
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vdivsd	.LC12(%rip), %xmm7, %xmm0	#, en, tmp162
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovq	%xmm4, %r15	# _14, _14
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	.LC11(%rip), %xmm1	#,
	call	pow@PLT	#
	vmovsd	%xmm0, 16(%rsp)	# tmp266, %sfp
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	8(%rsp), %xmm7	# %sfp, en
	vmovsd	.LC13(%rip), %xmm1	#,
	vdivsd	.LC14(%rip), %xmm7, %xmm0	#, en, tmp165
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	.LC10(%rip), %xmm7	#, tmp294
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp169
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovsd	%xmm0, %xmm0, %xmm2	#, tmp267
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vaddsd	16(%rsp), %xmm7, %xmm0	# %sfp, tmp294, tmp167
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vaddsd	%xmm2, %xmm0, %xmm0	# tmp267, tmp167, _20
	vucomisd	%xmm0, %xmm1	# _20, tmp169
	ja	.L93	#,
	vsqrtsd	%xmm0, %xmm0, %xmm6	# _20, _21
	vmovsd	%xmm6, 16(%rsp)	# _21, %sfp
.L84:
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	8(%rsp), %xmm6	# %sfp, en
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	.LC16(%rip), %xmm1	#,
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vdivsd	.LC15(%rip), %xmm6, %xmm3	#, en, tmp170
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	%xmm6, %xmm6, %xmm0	# en,
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vaddsd	.LC10(%rip), %xmm3, %xmm3	#, tmp170, _26
	vmovsd	%xmm3, 32(%rsp)	# _26, %sfp
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	8(%rsp), %xmm6	# %sfp, en
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	%xmm0, 24(%rsp)	# tmp269, %sfp
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	.LC5(%rip), %xmm1	#,
	vdivsd	.LC17(%rip), %xmm6, %xmm0	#, en, tmp175
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovq	%r15, %xmm7	# _14, _14
	vdivsd	16(%rsp), %xmm7, %xmm2	# %sfp, _14, tmp177
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vmovq	%r14, %xmm7	# _8, _8
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	%xmm0, %xmm0, %xmm1	#, tmp270
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	vsubsd	%xmm2, %xmm7, %xmm2	# tmp177, _8, tmp178
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vandpd	.LC18(%rip), %xmm2, %xmm2	#, tmp178, tmp179
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vaddsd	.LC10(%rip), %xmm1, %xmm1	#, tmp270, tmp187
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	32(%rsp), %xmm3	# %sfp, _26
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	.LC19(%rip), %xmm5	#, tmp302
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmulsd	%xmm3, %xmm3, %xmm3	# _26, _26, tmp181
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmovsd	.LC20(%rip), %xmm7	#, tmp303
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vdivsd	%xmm3, %xmm5, %xmm3	# tmp181, tmp302, tmp182
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vmulsd	24(%rsp), %xmm7, %xmm0	# %sfp, tmp303, tmp185
# C/parallel-only-omp/cross_sections.h:26:         if (en > E_EXC_TH)
	vmovsd	8(%rsp), %xmm6	# %sfp, en
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp187, tmp185, tmp189
# C/parallel-only-omp/cross_sections.h:26:         if (en > E_EXC_TH)
	vcomisd	.LC21(%rip), %xmm6	#, en
# C/parallel-only-omp/cross_sections.h:25:         + 0.05 / pow(1.0 + en/10.0, 2.0) + 0.01 * pow(en, 3.0) / (1.0 + pow(en/12.0, 6.0));
	vaddsd	%xmm3, %xmm2, %xmm2	# tmp182, tmp179, tmp184
# C/parallel-only-omp/cross_sections.h:23:         qmel = fabs(6.0 / pow(1.0 + (en/0.1) + pow(en/0.6,2.0), 3.3)
	vaddsd	%xmm0, %xmm2, %xmm2	# tmp189, tmp184, qmel
	vxorpd	%xmm0, %xmm0, %xmm0	# _131
	vmovsd	%xmm0, %xmm0, %xmm1	#, _129
# C/parallel-only-omp/cross_sections.h:26:         if (en > E_EXC_TH)
	jbe	.L85	#,
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vsubsd	.LC21(%rip), %xmm6, %xmm3	#, en, _36
	vmovsd	%xmm2, 56(%rsp)	# qmel, %sfp
	vmovsd	%xmm3, %xmm3, %xmm0	# _36,
	vmovsd	%xmm3, 48(%rsp)	# _36, %sfp
	vmovsd	.LC9(%rip), %xmm1	#,
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	.LC22(%rip), %xmm1	#,
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	%xmm0, 16(%rsp)	# tmp271, %sfp
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	40(%rsp), %xmm0	# %sfp,
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	8(%rsp), %xmm5	# %sfp, en
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	%xmm0, 24(%rsp)	# tmp272, %sfp
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	.LC12(%rip), %xmm1	#,
	vdivsd	.LC23(%rip), %xmm5, %xmm0	#, en, tmp195
	call	pow@PLT	#
	vmovsd	%xmm0, 32(%rsp)	# tmp273, %sfp
# C/parallel-only-omp/cross_sections.h:28:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vmovsd	8(%rsp), %xmm5	# %sfp, en
# C/parallel-only-omp/cross_sections.h:28:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vmovsd	.LC24(%rip), %xmm1	#,
# C/parallel-only-omp/cross_sections.h:28:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vdivsd	.LC25(%rip), %xmm5, %xmm0	#, en, tmp198
# C/parallel-only-omp/cross_sections.h:28:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vaddsd	.LC10(%rip), %xmm0, %xmm0	#, tmp198, tmp200
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	16(%rsp), %xmm2	# %sfp, _37
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmovsd	.LC10(%rip), %xmm6	#, tmp310
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmulsd	.LC26(%rip), %xmm2, %xmm1	#, _37, tmp202
# C/parallel-only-omp/cross_sections.h:28:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vmovsd	%xmm0, %xmm0, %xmm4	#, tmp274
# C/parallel-only-omp/cross_sections.h:28:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vmovsd	48(%rsp), %xmm3	# %sfp, _36
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vaddsd	24(%rsp), %xmm6, %xmm0	# %sfp, tmp310, tmp204
# C/parallel-only-omp/cross_sections.h:28:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vmulsd	.LC27(%rip), %xmm3, %xmm3	#, _36, tmp210
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vmulsd	%xmm0, %xmm1, %xmm0	# tmp204, tmp202, tmp206
# C/parallel-only-omp/cross_sections.h:28:             + 0.023 * (en-11.5) / pow(1.0 + en/80.0, 1.9);
	vdivsd	%xmm4, %xmm3, %xmm3	# tmp274, tmp210, tmp212
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vaddsd	32(%rsp), %xmm6, %xmm1	# %sfp, tmp312, tmp207
# C/parallel-only-omp/cross_sections.h:31:         if (en > E_ION_TH)
	vmovsd	8(%rsp), %xmm5	# %sfp, en
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp207, tmp206, tmp209
# C/parallel-only-omp/cross_sections.h:31:         if (en > E_ION_TH)
	vmovsd	56(%rsp), %xmm2	# %sfp, qmel
# C/parallel-only-omp/cross_sections.h:27:             qexc = 0.034 * pow(en-11.5, 1.1) * (1.0 + pow(en/15.0, 2.8)) / (1.0 + pow(en/23.0, 5.5))
	vaddsd	%xmm3, %xmm0, %xmm1	# tmp212, tmp209, qexc
# C/parallel-only-omp/cross_sections.h:31:         if (en > E_ION_TH)
	vmovsd	.LC28(%rip), %xmm0	#, tmp213
	vcomisd	%xmm0, %xmm5	# tmp213, en
	ja	.L87	#,
# C/parallel-only-omp/cross_sections.h:36:         sigma[E_EXC][i] = qexc * 1.0e-20;       // Przekrój czynny na wzbudzenie e- / Ar [m^2]
	vmulsd	.LC29(%rip), %xmm1, %xmm1	#, qexc, _129
	vxorpd	%xmm0, %xmm0, %xmm0	# _131
	jmp	.L85	#
	.p2align 4
	.p2align 3
.L87:
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vsubsd	%xmm0, %xmm5, %xmm4	# tmp213, en, _51
	vmovsd	%xmm5, %xmm5, %xmm3	# en, en
	vmovsd	%xmm1, 32(%rsp)	# qexc, %sfp
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vxorpd	.LC31(%rip), %xmm3, %xmm0	#, en, tmp217
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vaddsd	.LC30(%rip), %xmm5, %xmm5	#, en, _53
	vmovsd	%xmm2, 24(%rsp)	# qmel, %sfp
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmovsd	%xmm4, 16(%rsp)	# _51, %sfp
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmovsd	%xmm5, 8(%rsp)	# _53, %sfp
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vdivsd	.LC32(%rip), %xmm0, %xmm0	#, tmp217, tmp219
	call	exp@PLT	#
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmovsd	16(%rsp), %xmm4	# %sfp, _51
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmovsd	8(%rsp), %xmm5	# %sfp, _53
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmovsd	%xmm0, %xmm0, %xmm6	#, tmp275
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmulsd	%xmm4, %xmm4, %xmm3	# _51, _51, tmp221
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmulsd	.LC34(%rip), %xmm4, %xmm0	#, _51, tmp224
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmulsd	.LC33(%rip), %xmm3, %xmm3	#, tmp221, tmp222
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vmulsd	%xmm5, %xmm5, %xmm5	# _53, _53, tmp226
# C/parallel-only-omp/cross_sections.h:36:         sigma[E_EXC][i] = qexc * 1.0e-20;       // Przekrój czynny na wzbudzenie e- / Ar [m^2]
	vmovsd	32(%rsp), %xmm1	# %sfp, qexc
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vdivsd	%xmm5, %xmm0, %xmm0	# tmp226, tmp224, tmp227
# C/parallel-only-omp/cross_sections.h:36:         sigma[E_EXC][i] = qexc * 1.0e-20;       // Przekrój czynny na wzbudzenie e- / Ar [m^2]
	vmulsd	.LC29(%rip), %xmm1, %xmm1	#, qexc, _129
# C/parallel-only-omp/cross_sections.h:32:             qion = 970.0 * (en-15.8) / pow(70.0 + en, 2.0) + 0.06 * pow(en-15.8, 2.0) * exp(-en/9);
	vfmadd231sd	%xmm6, %xmm3, %xmm0	# tmp275, tmp222, qion
	vmovsd	24(%rsp), %xmm2	# %sfp, qmel
# C/parallel-only-omp/cross_sections.h:37:         sigma[E_ION][i] = qion * 1.0e-20;       // Przekrój czynny na jonizację e- / Ar [m^2]
	vmulsd	.LC29(%rip), %xmm0, %xmm0	#, qion, _131
	jmp	.L85	#
.L95:
# C/parallel-only-omp/cross_sections.h:39: }
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
.L93:
	.cfi_restore_state
# C/parallel-only-omp/cross_sections.h:24:                     - 1.1 * pow(en, 1.4) / (1.0 + pow(en/15.0, 1.2)) / sqrt(1.0 + pow(en/5.5, 2.5) + pow(en/60.0, 4.1)))
	call	sqrt@PLT	#
	vmovsd	%xmm0, 16(%rsp)	# tmp268, %sfp
	jmp	.L84	#
	.cfi_endproc
.LFE9860:
	.size	_Z30set_electron_cross_sections_arv, .-_Z30set_electron_cross_sections_arv
	.section	.rodata._Z25set_ion_cross_sections_arv.str1.8,"aMS",@progbits,1
	.align 8
.LC38:
	.string	">> eduPIC: Setting Ar+ / Ar cross sections\n"
	.section	.text._Z25set_ion_cross_sections_arv,"axG",@progbits,_Z25set_ion_cross_sections_arv,comdat
	.p2align 4
	.weak	_Z25set_ion_cross_sections_arv
	.type	_Z25set_ion_cross_sections_arv, @function
_Z25set_ion_cross_sections_arv:
.LFB9861:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC38(%rip), %rsi	#, tmp104
	movl	$2, %edi	#,
# C/parallel-only-omp/cross_sections.h:50: inline void set_ion_cross_sections_ar(void){
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 64
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	xorl	%eax, %eax	#
	xorl	%ebx, %ebx	# ivtmp.923
	leaq	sigma(%rip), %rbp	#, tmp137
	call	__printf_chk@PLT	#
	.p2align 4
	.p2align 3
.L99:
	movq	.LC37(%rip), %rax	#, tmp154
	movq	%rax, 8(%rsp)	# tmp154, %sfp
# C/parallel-only-omp/cross_sections.h:56:         if (i == 0) {e_com = DE_CS;} else {e_com = DE_CS * i;}             // Energia jonu w układzie środka masy [eV]
	testq	%rbx, %rbx	# ivtmp.923
	je	.L98	#,
# C/parallel-only-omp/cross_sections.h:56:         if (i == 0) {e_com = DE_CS;} else {e_com = DE_CS * i;}             // Energia jonu w układzie środka masy [eV]
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp155
	vcvtsi2sdl	%ebx, %xmm6, %xmm0	# ivtmp.923, tmp155, tmp152
# C/parallel-only-omp/cross_sections.h:56:         if (i == 0) {e_com = DE_CS;} else {e_com = DE_CS * i;}             // Energia jonu w układzie środka masy [eV]
	vmulsd	.LC1(%rip), %xmm0, %xmm0	#, tmp105, e_com
# C/parallel-only-omp/cross_sections.h:57:         e_lab = 2.0 * e_com;                                               // Energia jonu w układzie laboratoryjnym [eV]
	vaddsd	%xmm0, %xmm0, %xmm7	# e_com, e_com, _17
	vmovsd	%xmm7, 8(%rsp)	# _17, %sfp
.L98:
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	.LC39(%rip), %xmm1	#,
	vmovsd	8(%rsp), %xmm0	# %sfp,
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	.LC40(%rip), %xmm4	#, tmp157
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	%xmm0, 16(%rsp)	# tmp148, %sfp
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	.LC35(%rip), %xmm1	#,
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vdivsd	8(%rsp), %xmm4, %xmm0	# %sfp, tmp157, tmp110
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vaddsd	.LC10(%rip), %xmm0, %xmm0	#, tmp110, tmp112
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmovsd	.LC41(%rip), %xmm1	#,
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	%xmm0, 24(%rsp)	# tmp149, %sfp
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmovsd	8(%rsp), %xmm0	# %sfp,
	call	pow@PLT	#
# C/parallel-only-omp/cross_sections.h:61:         sigma[I_ISO][i]  = qiso;             // Przekrój czynny na izotropową część rozpraszania sprężystego [m^2]
	leaq	0(,%rbx,8), %rax	#, tmp129
# C/parallel-only-omp/cross_sections.h:55:     for(i=0; i<CS_RANGES; i++){
	incq	%rbx	# ivtmp.923
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmovsd	8(%rsp), %xmm3	# %sfp, _17
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmulsd	.LC42(%rip), %xmm0, %xmm0	#, tmp150, tmp118
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vdivsd	.LC16(%rip), %xmm3, %xmm2	#, _17, tmp115
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmovsd	.LC10(%rip), %xmm5	#, tmp160
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vaddsd	.LC10(%rip), %xmm2, %xmm2	#, tmp115, _13
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vaddsd	%xmm3, %xmm5, %xmm1	# _17, tmp160, tmp120
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmovsd	.LC43(%rip), %xmm6	#, tmp162
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp120, tmp118, tmp122
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmulsd	%xmm2, %xmm2, %xmm2	# _13, _13, tmp125
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vmulsd	%xmm3, %xmm6, %xmm1	# _17, tmp162, tmp123
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmovsd	.LC44(%rip), %xmm7	#, tmp164
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vdivsd	%xmm2, %xmm1, %xmm1	# tmp125, tmp123, tmp126
# C/parallel-only-omp/cross_sections.h:59:         qiso  = 2e-19 * pow(e_lab,-0.5) / (1.0 + e_lab) + 3e-19 * e_lab / pow(1.0 + e_lab / 3.0, 2.0);
	vaddsd	%xmm1, %xmm0, %xmm0	# tmp126, tmp122, qiso
# C/parallel-only-omp/cross_sections.h:58:         qmom  = 1.15e-18 * pow(e_lab,-0.1) * pow(1.0 + 0.015 / e_lab, 0.6);
	vmulsd	16(%rsp), %xmm7, %xmm1	# %sfp, tmp164, tmp127
# C/parallel-only-omp/cross_sections.h:61:         sigma[I_ISO][i]  = qiso;             // Przekrój czynny na izotropową część rozpraszania sprężystego [m^2]
	vmovsd	%xmm0, 24000000(%rbp,%rax)	# qiso, MEM[(double *)&sigma + 24000000B + ivtmp.923_22 * 8]
# C/parallel-only-omp/cross_sections.h:60:         qback = (qmom-qiso) / 2.0;
	vfmsub132sd	24(%rsp), %xmm0, %xmm1	# %sfp, qiso, _16
# C/parallel-only-omp/cross_sections.h:60:         qback = (qmom-qiso) / 2.0;
	vmulsd	.LC45(%rip), %xmm1, %xmm1	#, _16, qback
# C/parallel-only-omp/cross_sections.h:62:         sigma[I_BACK][i] = qback;            // Przekrój czynny na rozpraszanie wsteczne (wymianę ładunku) [m^2]
	vmovsd	%xmm1, 32000000(%rbp,%rax)	# qback, MEM[(double *)&sigma + 32000000B + ivtmp.923_22 * 8]
# C/parallel-only-omp/cross_sections.h:55:     for(i=0; i<CS_RANGES; i++){
	cmpq	$1000000, %rbx	#, ivtmp.923
	jne	.L99	#,
# C/parallel-only-omp/cross_sections.h:64: }
	addq	$40, %rsp	#,
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE9861:
	.size	_Z25set_ion_cross_sections_arv, .-_Z25set_ion_cross_sections_arv
	.section	.text._Z25calc_total_cross_sectionsv,"axG",@progbits,_Z25calc_total_cross_sectionsv,comdat
	.p2align 4
	.weak	_Z25calc_total_cross_sectionsv
	.type	_Z25calc_total_cross_sectionsv, @function
_Z25calc_total_cross_sectionsv:
.LFB9862:
	.cfi_startproc
	endbr64	
	vbroadcastsd	.LC47(%rip), %zmm1	#, tmp113
	leaq	sigma(%rip), %rsi	#, tmp100
	leaq	sigma_tot_e(%rip), %rcx	#, ivtmp.967
	leaq	sigma_tot_i(%rip), %rdx	#, ivtmp.976
	leaq	24000000(%rsi), %rax	#, ivtmp.965
	addq	$32000000, %rsi	#, _42
	.p2align 4
	.p2align 3
.L104:
# C/parallel-only-omp/cross_sections.h:76:         sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY;
	vmovapd	-16000000(%rax), %zmm2	# MEM <vector(8) double> [(double *)_9 + -16000000B], tmp115
	vaddpd	-24000000(%rax), %zmm2, %zmm0	# MEM <vector(8) double> [(double *)_9 + -24000000B], tmp115, vect__3.942
	addq	$64, %rax	#, ivtmp.965
	addq	$64, %rcx	#, ivtmp.967
	addq	$64, %rdx	#, ivtmp.976
# C/parallel-only-omp/cross_sections.h:76:         sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY;
	vaddpd	-8000064(%rax), %zmm0, %zmm0	# MEM <vector(8) double> [(double *)_9 + -8000000B], vect__3.942, vect__5.946
# C/parallel-only-omp/cross_sections.h:76:         sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY;
	vmulpd	%zmm1, %zmm0, %zmm0	# tmp113, vect__5.946, vect__6.947
# C/parallel-only-omp/cross_sections.h:76:         sigma_tot_e[i] = (sigma[E_ELA][i] + sigma[E_EXC][i] + sigma[E_ION][i]) * GAS_DENSITY;
	vmovapd	%zmm0, -64(%rcx)	# vect__6.947, MEM <vector(8) double> [(double *)_30]
# C/parallel-only-omp/cross_sections.h:78:         sigma_tot_i[i] = (sigma[I_ISO][i] + sigma[I_BACK][i]) * GAS_DENSITY;
	vmovapd	-64(%rax), %zmm3	# MEM <vector(8) double> [(double *)_9], tmp116
	vaddpd	7999936(%rax), %zmm3, %zmm0	# MEM <vector(8) double> [(double *)_9 + 8000000B], tmp116, vect__9.956
# C/parallel-only-omp/cross_sections.h:78:         sigma_tot_i[i] = (sigma[I_ISO][i] + sigma[I_BACK][i]) * GAS_DENSITY;
	vmulpd	%zmm1, %zmm0, %zmm0	# tmp113, vect__9.956, vect__10.957
# C/parallel-only-omp/cross_sections.h:78:         sigma_tot_i[i] = (sigma[I_ISO][i] + sigma[I_BACK][i]) * GAS_DENSITY;
	vmovapd	%zmm0, -64(%rdx)	# vect__10.957, MEM <vector(8) double> [(double *)_25]
	cmpq	%rsi, %rax	# _42, ivtmp.965
	jne	.L104	#,
	vzeroupper
# C/parallel-only-omp/cross_sections.h:80: }
	ret	
	.cfi_endproc
.LFE9862:
	.size	_Z25calc_total_cross_sectionsv, .-_Z25calc_total_cross_sectionsv
	.section	.rodata._Z29compute_null_collision_paramsv.str1.8,"aMS",@progbits,1
	.align 8
.LC55:
	.string	">> eduPIC: null-collision: nu*_e = %e, P*_e = %e\n"
	.align 8
.LC56:
	.string	">> eduPIC: null-collision: nu*_i = %e, P*_i = %e\n"
	.section	.text._Z29compute_null_collision_paramsv,"axG",@progbits,_Z29compute_null_collision_paramsv,comdat
	.p2align 4
	.weak	_Z29compute_null_collision_paramsv
	.type	_Z29compute_null_collision_paramsv, @function
_Z29compute_null_collision_paramsv:
.LFB9870:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leaq	sigma_tot_e(%rip), %rbp	#, tmp150
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	xorl	%ebx, %ebx	# ivtmp.996
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 64
# C/parallel-only-omp/cross_sections.h:110:     nu_max = 0;
	vxorpd	%xmm3, %xmm3, %xmm3	# nu_max
	vxorps	%xmm6, %xmm6, %xmm6	# tmp159
	vmovsd	.LC1(%rip), %xmm5	#, tmp153
	vmovsd	.LC50(%rip), %xmm4	#, tmp147
	vmovsd	.LC51(%rip), %xmm2	#, tmp148
	vmovsd	%xmm3, %xmm3, %xmm1	#, tmp121
	.p2align 4
	.p2align 3
.L111:
# C/parallel-only-omp/cross_sections.h:112:         e  = i * DE_CS;
	vcvtsi2sdl	%ebx, %xmm6, %xmm0	# ivtmp.996, tmp159, tmp160
# C/parallel-only-omp/cross_sections.h:112:         e  = i * DE_CS;
	vmulsd	%xmm5, %xmm0, %xmm0	# tmp153, tmp114, e
# C/parallel-only-omp/cross_sections.h:113:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vaddsd	%xmm0, %xmm0, %xmm0	# e, e, tmp117
# C/parallel-only-omp/cross_sections.h:113:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vmulsd	%xmm4, %xmm0, %xmm0	# tmp147, tmp117, tmp118
# C/parallel-only-omp/cross_sections.h:113:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vdivsd	%xmm2, %xmm0, %xmm0	# tmp148, tmp118, _42
	vucomisd	%xmm0, %xmm1	# _42, tmp121
	ja	.L123	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _42, v
.L109:
# C/parallel-only-omp/cross_sections.h:114:         nu = v * sigma_tot_e[i];
	vmulsd	0(%rbp,%rbx,8), %xmm0, %xmm0	# MEM[(double *)&sigma_tot_e + ivtmp.996_69 * 8], v, nu
# C/parallel-only-omp/cross_sections.h:111:     for(i=0; i<CS_RANGES; i++){
	incq	%rbx	# ivtmp.996
# C/parallel-only-omp/cross_sections.h:115:         if (nu > nu_max) {nu_max = nu;}
	vmaxsd	%xmm3, %xmm0, %xmm3	# nu_max, nu, nu_max
# C/parallel-only-omp/cross_sections.h:111:     for(i=0; i<CS_RANGES; i++){
	cmpq	$1000000, %rbx	#, ivtmp.996
	jne	.L111	#,
# C/parallel-only-omp/null_collision.h:19:     nu_star_e = max_electron_coll_freq();
	vmovsd	%xmm3, nu_star_e(%rip)	# nu_max, nu_star_e
# C/parallel-only-omp/null_collision.h:20:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	vmulsd	.LC57(%rip), %xmm3, %xmm0	#, nu_max, tmp125
	vmovsd	%xmm3, 8(%rsp)	# nu_max, %sfp
# C/parallel-only-omp/null_collision.h:20:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	xorl	%ebx, %ebx	# ivtmp.989
# C/parallel-only-omp/null_collision.h:20:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	call	exp@PLT	#
	leaq	sigma_tot_i(%rip), %rbp	#, tmp152
# C/parallel-only-omp/null_collision.h:20:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	vmovsd	.LC10(%rip), %xmm7	#, tmp163
# C/parallel-only-omp/cross_sections.h:130:     nu_max = 0;
	vxorpd	%xmm2, %xmm2, %xmm2	# nu_max
# C/parallel-only-omp/null_collision.h:20:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	vsubsd	%xmm0, %xmm7, %xmm1	# tmp156, tmp163, _5
	vmovsd	.LC53(%rip), %xmm8	#, tmp149
# C/parallel-only-omp/null_collision.h:20:     P_star_e = 1.0 - exp(-nu_star_e * DT_E);
	vmovsd	%xmm1, P_star_e(%rip)	# _5, P_star_e
	vmovsd	%xmm2, %xmm2, %xmm7	#, tmp135
	vxorps	%xmm6, %xmm6, %xmm6	# tmp159
	vmovsd	.LC1(%rip), %xmm5	#, tmp153
	vmovsd	.LC50(%rip), %xmm4	#, tmp147
	vmovsd	8(%rsp), %xmm3	# %sfp, nu_max
	.p2align 4
	.p2align 3
.L116:
# C/parallel-only-omp/cross_sections.h:132:         e  = i * DE_CS;
	vcvtsi2sdl	%ebx, %xmm6, %xmm0	# ivtmp.989, tmp159, tmp161
# C/parallel-only-omp/cross_sections.h:132:         e  = i * DE_CS;
	vmulsd	%xmm5, %xmm0, %xmm0	# tmp153, tmp128, e
# C/parallel-only-omp/cross_sections.h:133:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vaddsd	%xmm0, %xmm0, %xmm0	# e, e, tmp131
# C/parallel-only-omp/cross_sections.h:133:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vmulsd	%xmm4, %xmm0, %xmm0	# tmp147, tmp131, tmp132
# C/parallel-only-omp/cross_sections.h:133:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vdivsd	%xmm8, %xmm0, %xmm0	# tmp149, tmp132, _29
	vucomisd	%xmm0, %xmm7	# _29, tmp135
	ja	.L124	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _29, g
.L114:
# C/parallel-only-omp/cross_sections.h:134:         nu = g * sigma_tot_i[i];
	vmulsd	0(%rbp,%rbx,8), %xmm0, %xmm0	# MEM[(double *)&sigma_tot_i + ivtmp.989_73 * 8], g, nu
# C/parallel-only-omp/cross_sections.h:131:     for(i=0; i<CS_RANGES; i++){
	incq	%rbx	# ivtmp.989
# C/parallel-only-omp/cross_sections.h:135:         if (nu > nu_max) nu_max = nu;
	vmaxsd	%xmm2, %xmm0, %xmm2	# nu_max, nu, nu_max
# C/parallel-only-omp/cross_sections.h:131:     for(i=0; i<CS_RANGES; i++){
	cmpq	$1000000, %rbx	#, ivtmp.989
	jne	.L116	#,
	vmovsd	%xmm3, 16(%rsp)	# nu_max, %sfp
	vmovsd	%xmm1, 8(%rsp)	# _5, %sfp
# C/parallel-only-omp/null_collision.h:23:     nu_star_i = max_ion_coll_freq();
	vmovsd	%xmm2, nu_star_i(%rip)	# nu_max, nu_star_i
# C/parallel-only-omp/null_collision.h:24:     P_star_i = 1.0 - exp(-nu_star_i * DT_I);
	vmulsd	.LC58(%rip), %xmm2, %xmm0	#, nu_max, tmp139
	call	exp@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC55(%rip), %rsi	#, tmp143
	movl	$2, %edi	#,
	movl	$2, %eax	#,
	vmovsd	8(%rsp), %xmm1	# %sfp, _5
	vmovsd	16(%rsp), %xmm3	# %sfp, nu_max
# C/parallel-only-omp/null_collision.h:24:     P_star_i = 1.0 - exp(-nu_star_i * DT_I);
	vmovsd	.LC10(%rip), %xmm7	#, tmp164
	vsubsd	%xmm0, %xmm7, %xmm0	# tmp158, tmp164, tmp141
# C/parallel-only-omp/null_collision.h:24:     P_star_i = 1.0 - exp(-nu_star_i * DT_I);
	vmovsd	%xmm0, P_star_i(%rip)	# tmp141, P_star_i
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	vmovsd	%xmm3, %xmm3, %xmm0	# nu_max,
	call	__printf_chk@PLT	#
	vmovsd	P_star_i(%rip), %xmm1	# P_star_i,
	vmovsd	nu_star_i(%rip), %xmm0	# nu_star_i,
# C/parallel-only-omp/null_collision.h:28: }
	addq	$40, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC56(%rip), %rsi	#, tmp146
	movl	$2, %edi	#,
# C/parallel-only-omp/null_collision.h:28: }
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$2, %eax	#,
	jmp	__printf_chk@PLT	#
.L123:
	.cfi_restore_state
	vmovsd	%xmm3, 8(%rsp)	# nu_max, %sfp
# C/parallel-only-omp/cross_sections.h:113:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	call	sqrt@PLT	#
	vxorps	%xmm6, %xmm6, %xmm6	# tmp159
	vmovsd	.LC1(%rip), %xmm5	#, tmp153
	vmovsd	.LC51(%rip), %xmm2	#, tmp148
	vmovsd	.LC50(%rip), %xmm4	#, tmp147
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp121
	vmovsd	8(%rsp), %xmm3	# %sfp, nu_max
	jmp	.L109	#
.L124:
	vmovsd	%xmm3, 24(%rsp)	# nu_max, %sfp
	vmovsd	%xmm2, 16(%rsp)	# nu_max, %sfp
	vmovsd	%xmm1, 8(%rsp)	# _5, %sfp
# C/parallel-only-omp/cross_sections.h:133:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	call	sqrt@PLT	#
	vxorps	%xmm6, %xmm6, %xmm6	# tmp159
	vmovsd	.LC1(%rip), %xmm5	#, tmp153
	vmovsd	.LC53(%rip), %xmm8	#, tmp149
	vmovsd	.LC50(%rip), %xmm4	#, tmp147
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp135
	vmovsd	24(%rsp), %xmm3	# %sfp, nu_max
	vmovsd	16(%rsp), %xmm2	# %sfp, nu_max
	vmovsd	8(%rsp), %xmm1	# %sfp, _5
	jmp	.L114	#
	.cfi_endproc
.LFE9870:
	.size	_Z29compute_null_collision_paramsv, .-_Z29compute_null_collision_paramsv
	.section	.text._Z25step3_move_electrons_bodyiii,"axG",@progbits,_Z25step3_move_electrons_bodyiii,comdat
	.p2align 4
	.weak	_Z25step3_move_electrons_bodyiii
	.type	_Z25step3_move_electrons_bodyiii, @function
_Z25step3_move_electrons_bodyiii:
.LFB9877:
	.cfi_startproc
	endbr64	
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
	movl	%esi, %r12d	# tmp687, num_threads
	movslq	%edi, %rbx	# tmp686,
	andq	$-32, %rsp	#,
	subq	$64, %rsp	#,
# C/parallel-only-omp/simulation.h:213:     if (__builtin_expect(!measurement_mode, 1)) {
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
# C/parallel-only-omp/simulation.h:214:         int chunk = (N_e + num_threads - 1) / num_threads;
	movl	N_e(%rip), %r13d	# N_e, pretmp_725
# C/parallel-only-omp/simulation.h:213:     if (__builtin_expect(!measurement_mode, 1)) {
	jne	.L127	#,
# C/parallel-only-omp/simulation.h:214:         int chunk = (N_e + num_threads - 1) / num_threads;
	leal	-1(%r13,%rsi), %eax	#, tmp387
	vxorps	%xmm6, %xmm6, %xmm6	# tmp692
# C/parallel-only-omp/simulation.h:214:         int chunk = (N_e + num_threads - 1) / num_threads;
	cltd
	idivl	%esi	# num_threads
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	movl	%r13d, %esi	# pretmp_725, pretmp_725
# C/parallel-only-omp/simulation.h:215:         int k_start = std::min(tid * chunk, N_e);
	imull	%eax, %ebx	# tmp388, tmp390
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%r13d, %ebx	# pretmp_725, tmp390
	cmovg	%r13d, %ebx	# tmp390,, pretmp_725, k
# C/parallel-only-omp/simulation.h:216:         int k_end   = std::min(k_start + chunk, N_e);
	addl	%ebx, %eax	# k, tmp391
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%r13d, %eax	# pretmp_725, tmp391
	cmovle	%eax, %esi	# tmp391,, pretmp_725
# C/parallel-only-omp/simulation.h:219:         int k_unroll_end = k_start + ((k_end - k_start) / 4) * 4;
	movl	%esi, %edi	# _80, tmp392
	subl	%ebx, %edi	# k, tmp392
# C/parallel-only-omp/simulation.h:219:         int k_unroll_end = k_start + ((k_end - k_start) / 4) * 4;
	movl	%edi, %edx	# tmp392, tmp398
	sarl	$31, %edx	#, tmp398
	shrl	$30, %edx	#, tmp399
	leal	(%rdi,%rdx), %eax	#, tmp400
	andl	$3, %eax	#, tmp401
	subl	%edx, %eax	# tmp399, tmp402
	subl	%eax, %edi	# tmp402, _12
# C/parallel-only-omp/simulation.h:219:         int k_unroll_end = k_start + ((k_end - k_start) / 4) * 4;
	leal	(%rdi,%rbx), %eax	#, k_unroll_end
# C/parallel-only-omp/simulation.h:222:         for (; k < k_unroll_end; k += 4) {
	cmpl	%ebx, %eax	# k, k_unroll_end
	jle	.L128	#,
	decl	%edi	# tmp406
	vbroadcastsd	.LC61(%rip), %ymm9	#, tmp656
	vbroadcastsd	.LC52(%rip), %ymm8	#, tmp660
	movslq	%ebx, %r8	# k, _107
	shrl	$2, %edi	#, _120
	vmovsd	.LC59(%rip), %xmm5	#, tmp673
	leaq	0(,%r8,8), %rcx	#, _108
	leaq	vx_e(%rip), %rax	#, tmp405
	leaq	x_e(%rip), %rdx	#, tmp404
	leaq	efield(%rip), %r15	#, tmp667
	addq	%rcx, %rdx	# _108, ivtmp.1076
	addq	%rax, %rcx	# tmp405, ivtmp.1077
	leal	0(,%rdi,4), %eax	#, tmp408
	addq	%r8, %rax	# _107, tmp409
	leaq	32+x_e(%rip), %r8	#, tmp411
	leaq	(%r8,%rax,8), %r8	#, _124
	.p2align 4
	.p2align 3
.L129:
# C/parallel-only-omp/simulation.h:223:             double x0 = x_e[k+0], x1 = x_e[k+1], x2 = x_e[k+2], x3 = x_e[k+3];
	vmovupd	(%rdx), %ymm3	# MEM <vector(4) double> [(double *)_113], MEM <vector(4) double> [(double *)_113]
# C/parallel-only-omp/simulation.h:222:         for (; k < k_unroll_end; k += 4) {
	addq	$32, %rdx	#, ivtmp.1076
	addq	$32, %rcx	#, ivtmp.1077
# C/parallel-only-omp/simulation.h:226:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	vextractf64x2	$1, %ymm3, %xmm10	#, MEM <vector(4) double> [(double *)_113], tmp421
# C/parallel-only-omp/simulation.h:226:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	vmulsd	%xmm5, %xmm3, %xmm4	# tmp673, tmp415, c0_0
# C/parallel-only-omp/simulation.h:227:             int p0 = int(c0_0), p1 = int(c0_1), p2 = int(c0_2), p3 = int(c0_3);
	vcvttsd2sil	%xmm4, %r11d	# c0_0, p0
# C/parallel-only-omp/simulation.h:226:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	vunpckhpd	%xmm3, %xmm3, %xmm0	# tmp416, tmp418
	vmulsd	%xmm5, %xmm0, %xmm0	# tmp673, tmp418, c0_1
# C/parallel-only-omp/simulation.h:227:             int p0 = int(c0_0), p1 = int(c0_1), p2 = int(c0_2), p3 = int(c0_3);
	vcvttsd2sil	%xmm0, %r10d	# c0_1, p1
# C/parallel-only-omp/simulation.h:228:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vcvtsi2sdl	%r10d, %xmm6, %xmm1	# p1, tmp692, tmp693
# C/parallel-only-omp/simulation.h:228:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vsubsd	%xmm1, %xmm0, %xmm1	# tmp427, c0_1, c2_1
# C/parallel-only-omp/simulation.h:226:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	valignq	$3, %ymm3, %ymm3, %ymm7	#, MEM <vector(4) double> [(double *)_113], tmp424
# C/parallel-only-omp/simulation.h:226:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	vmulsd	%xmm5, %xmm10, %xmm10	# tmp673, tmp421, c0_2
# C/parallel-only-omp/simulation.h:227:             int p0 = int(c0_0), p1 = int(c0_1), p2 = int(c0_2), p3 = int(c0_3);
	vcvttsd2sil	%xmm10, %r9d	# c0_2, p2
# C/parallel-only-omp/simulation.h:228:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vcvtsi2sdl	%r9d, %xmm6, %xmm0	# p2, tmp692, tmp694
# C/parallel-only-omp/simulation.h:228:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vsubsd	%xmm0, %xmm10, %xmm11	# tmp428, c0_2, c2_2
# C/parallel-only-omp/simulation.h:230:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	movslq	%r11d, %r12	# p0, p0
# C/parallel-only-omp/simulation.h:226:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	vmulsd	%xmm5, %xmm7, %xmm7	# tmp673, tmp424, c0_3
# C/parallel-only-omp/simulation.h:227:             int p0 = int(c0_0), p1 = int(c0_1), p2 = int(c0_2), p3 = int(c0_3);
	vcvttsd2sil	%xmm7, %eax	# c0_3, p3
# C/parallel-only-omp/simulation.h:228:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vcvtsi2sdl	%eax, %xmm6, %xmm0	# p3, tmp692, tmp695
# C/parallel-only-omp/simulation.h:230:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	vmovsd	(%r15,%r12,8), %xmm12	# efield[p0_330], _20
# C/parallel-only-omp/simulation.h:228:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vsubsd	%xmm0, %xmm7, %xmm10	# tmp429, c0_3, c2_3
# C/parallel-only-omp/simulation.h:230:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	leal	1(%r11), %r12d	#, tmp433
# C/parallel-only-omp/simulation.h:228:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vcvtsi2sdl	%r11d, %xmm6, %xmm7	# p0, tmp692, tmp696
# C/parallel-only-omp/simulation.h:231:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	movslq	%r10d, %r11	# p1, p1
# C/parallel-only-omp/simulation.h:231:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	incl	%r10d	# tmp442
# C/parallel-only-omp/simulation.h:230:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	movslq	%r12d, %r12	# tmp433, tmp434
# C/parallel-only-omp/simulation.h:228:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vsubsd	%xmm7, %xmm4, %xmm4	# tmp437, c0_0, c2_0
# C/parallel-only-omp/simulation.h:231:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	movslq	%r10d, %r10	# tmp442, tmp443
# C/parallel-only-omp/simulation.h:230:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	vmovsd	(%r15,%r12,8), %xmm0	# efield[_21], efield[_21]
	vsubsd	%xmm12, %xmm0, %xmm0	# _20, efield[_21], tmp435
# C/parallel-only-omp/simulation.h:230:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	vfmadd132sd	%xmm4, %xmm12, %xmm0	# c2_0, _20, ex0
# C/parallel-only-omp/simulation.h:231:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	vmovsd	(%r15,%r10,8), %xmm4	# efield[_26], efield[_26]
# C/parallel-only-omp/simulation.h:232:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	movslq	%r9d, %r10	# p2, p2
# C/parallel-only-omp/simulation.h:232:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	incl	%r9d	# tmp449
# C/parallel-only-omp/simulation.h:231:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	vmovsd	(%r15,%r11,8), %xmm7	# efield[p1_331], _25
# C/parallel-only-omp/simulation.h:232:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	movslq	%r9d, %r9	# tmp449, tmp450
# C/parallel-only-omp/simulation.h:231:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	vsubsd	%xmm7, %xmm4, %xmm4	# _25, efield[_26], tmp444
# C/parallel-only-omp/simulation.h:231:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	vfmadd132sd	%xmm1, %xmm7, %xmm4	# c2_1, _25, ex1
# C/parallel-only-omp/simulation.h:232:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	vmovsd	(%r15,%r10,8), %xmm7	# efield[p2_332], _30
# C/parallel-only-omp/simulation.h:232:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	vmovsd	(%r15,%r9,8), %xmm1	# efield[_31], efield[_31]
# C/parallel-only-omp/simulation.h:233:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	movslq	%eax, %r9	# p3, p3
# C/parallel-only-omp/simulation.h:233:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	incl	%eax	# tmp456
# C/parallel-only-omp/simulation.h:232:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	vsubsd	%xmm7, %xmm1, %xmm1	# _30, efield[_31], tmp451
# C/parallel-only-omp/simulation.h:233:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	cltq
# C/parallel-only-omp/simulation.h:232:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	vfmadd132sd	%xmm11, %xmm7, %xmm1	# c2_2, _30, ex2
# C/parallel-only-omp/simulation.h:233:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	vmovsd	(%r15,%r9,8), %xmm11	# efield[p3_333], _35
# C/parallel-only-omp/simulation.h:233:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	vmovsd	(%r15,%rax,8), %xmm7	# efield[_36], efield[_36]
	vsubsd	%xmm11, %xmm7, %xmm7	# _35, efield[_36], tmp458
# C/parallel-only-omp/simulation.h:233:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	vfmadd132sd	%xmm10, %xmm11, %xmm7	# c2_3, _35, ex3
# C/parallel-only-omp/simulation.h:235:             double vn0 = v0 - ex0 * FACTOR_E;
	vunpcklpd	%xmm4, %xmm0, %xmm0	# ex1, ex0, tmp462
	vunpcklpd	%xmm7, %xmm1, %xmm1	# ex3, ex2, tmp461
	vinsertf128	$0x1, %xmm1, %ymm0, %ymm0	# tmp461, tmp462, tmp460
	vfnmadd213pd	-32(%rcx), %ymm9, %ymm0	# MEM <vector(4) double> [(double *)_241], tmp656, vect_vn0_342.1051
# C/parallel-only-omp/simulation.h:241:             x_e[k+0] = x0 + vn0 * DT_E;
	vfmadd231pd	%ymm8, %ymm0, %ymm3	# tmp660, vect_vn0_342.1051, vect__45.1056
# C/parallel-only-omp/simulation.h:240:             vx_e[k+0] = vn0; vx_e[k+1] = vn1; vx_e[k+2] = vn2; vx_e[k+3] = vn3;
	vmovupd	%ymm0, -32(%rcx)	# vect_vn0_342.1051, MEM <vector(4) double> [(double *)_241]
# C/parallel-only-omp/simulation.h:241:             x_e[k+0] = x0 + vn0 * DT_E;
	vmovupd	%ymm3, -32(%rdx)	# vect__45.1056, MEM <vector(4) double> [(double *)_113]
# C/parallel-only-omp/simulation.h:222:         for (; k < k_unroll_end; k += 4) {
	cmpq	%rdx, %r8	# ivtmp.1076, _124
	jne	.L129	#,
	leal	4(%rbx,%rdi,4), %ebx	#, k
	vzeroupper
.L128:
# C/parallel-only-omp/simulation.h:247:         for (; k < k_end; k++) {
	cmpl	%esi, %ebx	# _80, k
	jge	.L176	#,
	movslq	%ebx, %rdi	# k, _349
	subl	%ebx, %esi	# k, tmp472
	leaq	x_e(%rip), %rcx	#, tmp469
	leaq	vx_e(%rip), %r8	#, tmp470
	leaq	0(,%rdi,8), %rdx	#, _348
	addq	%rdi, %rsi	# _349, tmp473
	leaq	efield(%rip), %r15	#, tmp667
	vmovsd	.LC59(%rip), %xmm5	#, tmp673
	leaq	(%rdx,%rcx), %rax	#, ivtmp.1065
	leaq	(%rcx,%rsi,8), %rdi	#, _104
	addq	%r8, %rdx	# tmp470, ivtmp.1066
	vmovsd	.LC61(%rip), %xmm9	#, tmp662
	vmovsd	.LC52(%rip), %xmm8	#, tmp672
	.p2align 4
	.p2align 3
.L132:
# C/parallel-only-omp/simulation.h:248:             double c0 = x_e[k] * INV_DX;
	vmovsd	(%rax), %xmm4	# MEM[(double *)_704], _52
# C/parallel-only-omp/simulation.h:248:             double c0 = x_e[k] * INV_DX;
	vmulsd	%xmm5, %xmm4, %xmm0	# tmp673, _52, c0
# C/parallel-only-omp/simulation.h:249:             int p     = int(c0);
	vcvttsd2sil	%xmm0, %ecx	# c0, p
# C/parallel-only-omp/simulation.h:251:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	movslq	%ecx, %rsi	# p, p
	vmovsd	(%r15,%rsi,8), %xmm7	# efield[p_311], _54
# C/parallel-only-omp/simulation.h:251:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	leal	1(%rcx), %esi	#, tmp480
# C/parallel-only-omp/simulation.h:250:             double c2 = c0 - p;
	vcvtsi2sdl	%ecx, %xmm6, %xmm3	# p, tmp692, tmp697
# C/parallel-only-omp/simulation.h:250:             double c2 = c0 - p;
	vsubsd	%xmm3, %xmm0, %xmm0	# tmp484, c0, c2
# C/parallel-only-omp/simulation.h:251:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	movslq	%esi, %rsi	# tmp480, tmp481
# C/parallel-only-omp/simulation.h:247:         for (; k < k_end; k++) {
	addq	$8, %rax	#, ivtmp.1065
	addq	$8, %rdx	#, ivtmp.1066
# C/parallel-only-omp/simulation.h:251:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	vmovsd	(%r15,%rsi,8), %xmm1	# efield[_55], efield[_55]
	vsubsd	%xmm7, %xmm1, %xmm1	# _54, efield[_55], tmp482
# C/parallel-only-omp/simulation.h:251:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	vfmadd132sd	%xmm1, %xmm7, %xmm0	# tmp482, _54, e_x
# C/parallel-only-omp/simulation.h:252:             double v   = vx_e[k] - e_x * FACTOR_E;
	vfnmadd213sd	-8(%rdx), %xmm9, %xmm0	# MEM[(double *)_682], tmp662, v
# C/parallel-only-omp/simulation.h:253:             vx_e[k]    = v;
	vmovsd	%xmm0, -8(%rdx)	# v, MEM[(double *)_682]
# C/parallel-only-omp/simulation.h:254:             x_e[k]    += v * DT_E;
	vfmadd132sd	%xmm8, %xmm4, %xmm0	# tmp672, _52, _62
	vmovsd	%xmm0, -8(%rax)	# _62, MEM[(double *)_704]
# C/parallel-only-omp/simulation.h:247:         for (; k < k_end; k++) {
	cmpq	%rax, %rdi	# ivtmp.1065, _104
	jne	.L132	#,
.L176:
# C/parallel-only-omp/simulation.h:355: }
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
.L127:
	.cfi_restore_state
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	48+worker_buffers(%rip), %r9	# MEM[(struct vector *)&worker_buffers + 48B].D.103980._M_impl.D.103319._M_start, _363
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	imulq	$3200, %rbx, %r15	#, _64, _362
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
	movslq	%edx, %r14	# tmp688,
	movl	$3200, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	%r15, %r9	# _362, _363
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%r9, %rdi	# _363,
	movq	%r9, 40(%rsp)	# _363, %sfp
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	72+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 72B].D.103980._M_impl.D.103319._M_start, _356
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
	movl	$3200, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	%r15, %rax	# _362, _356
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%rax, %rdi	# _356,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	%rax, 16(%rsp)	# _356, %sfp
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	96+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 96B].D.103980._M_impl.D.103319._M_start, _192
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
	movl	$3200, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	%r15, %rax	# _362, _192
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%rax, %rdi	# _192,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	%rax, 56(%rsp)	# _192, %sfp
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	120+worker_buffers(%rip), %r15	# MEM[(struct vector *)&worker_buffers + 120B].D.103980._M_impl.D.103319._M_start, _362
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
	movl	$3200, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	%r15, %rdi	# _362, _216
	movq	%r15, 32(%rsp)	# _216, %sfp
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	imulq	$16000, %rbx, %rax	#, _64, tmp517
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	144+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 144B].D.105034._M_impl.D.104373._M_start, tmp517
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movl	$16000, %edx	#,
	xorl	%esi, %esi	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	salq	$6, %rbx	#, tmp525
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%rax, %rdi	# _236,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	%rax, 24(%rsp)	# _236, %sfp
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	168+worker_buffers(%rip), %rbx	# MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, _266
# C/parallel-only-omp/simulation.h:267:         worker_buffers.thread_counters[tid].accu_center   = 0.0;
	movq	$0x000000000, (%rbx)	#, _266->accu_center
# C/parallel-only-omp/simulation.h:268:         worker_buffers.thread_counters[tid].counter_center = 0;
	movq	$0, 8(%rbx)	#, _266->counter_center
	call	omp_get_num_threads@PLT	#
	movl	%eax, %r15d	# tmp689, _196
	movl	%eax, 48(%rsp)	# _196, %sfp
	call	omp_get_thread_num@PLT	#
	movq	40(%rsp), %r9	# %sfp, _363
	movl	%eax, %edi	# tmp690, _197
	movl	%eax, 52(%rsp)	# _197, %sfp
	movl	%r13d, %eax	# pretmp_725, pretmp_725
	vxorps	%xmm6, %xmm6, %xmm6	# tmp692
	cltd
	idivl	%r15d	# _196
	cmpl	%edx, %edi	# tt.76_171, _197
	jl	.L178	#,
.L134:
	movl	52(%rsp), %esi	# %sfp, tmp530
	imull	%eax, %esi	# q.75_170, tmp530
	addl	%esi, %edx	# tmp530, _202
	leal	(%rax,%rdx), %esi	#, tmp531
	cmpl	%esi, %edx	# tmp531, _202
	jge	.L142	#,
	movslq	%edx, %rdx	# _202, _549
	movl	%eax, %eax	# q.75_170, q.75_170
# C/parallel-only-omp/simulation.h:306:             energy_index = (int)(energy / DE_EEPF);
	movl	%r12d, 40(%rsp)	# num_threads, %sfp
	movq	32(%rsp), %r12	# %sfp, _216
	movl	%r14d, 32(%rsp)	# t_index, %sfp
	movq	16(%rsp), %r14	# %sfp, _356
	leaq	x_e(%rip), %rcx	#, tmp532
	addq	%rdx, %rax	# _549, tmp537
	leaq	(%rcx,%rax,8), %r8	#, _511
	leaq	0(,%rdx,8), %r10	#, _548
	leaq	vx_e(%rip), %rdi	#, tmp533
	vmovsd	.LC59(%rip), %xmm5	#, tmp673
	movq	%r8, %rax	# _511, _511
	leaq	vy_e(%rip), %r11	#, tmp534
	leaq	vz_e(%rip), %r13	#, tmp535
	leaq	(%r10,%rcx), %rsi	#, ivtmp.1134
	addq	%r10, %rdi	# _548, ivtmp.1135
	addq	%r10, %r11	# _548, ivtmp.1136
	movq	%rbx, %r8	# _266, _266
	addq	%r13, %r10	# tmp535, ivtmp.1137
	movq	%r9, %rbx	# _363, _363
	leaq	efield(%rip), %r15	#, tmp667
	leaq	sigma(%rip), %rcx	#, tmp665
	movq	%rax, %r9	# _511, _511
	vmovsd	.LC61(%rip), %xmm9	#, tmp662
	vmovsd	.LC52(%rip), %xmm8	#, tmp672
	vmovsd	.LC10(%rip), %xmm10	#, tmp668
	vmovsd	.LC45(%rip), %xmm7	#, tmp658
	vmovsd	.LC63(%rip), %xmm16	#, tmp663
	vmovsd	.LC50(%rip), %xmm15	#, tmp670
	vmovsd	.LC1(%rip), %xmm13	#, tmp666
	vmovsd	.LC47(%rip), %xmm12	#, tmp659
	vmovsd	.LC64(%rip), %xmm11	#, tmp664
# C/parallel-only-omp/simulation.h:305:         if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)) {
	vmovsd	.LC65(%rip), %xmm17	#, tmp674
# C/parallel-only-omp/simulation.h:306:             energy_index = (int)(energy / DE_EEPF);
	vmovsd	.LC19(%rip), %xmm18	#, tmp675
	.p2align 4
	.p2align 3
.L141:
# C/parallel-only-omp/simulation.h:277:         c0  = x_e[k] * INV_DX;
	vmulsd	(%rsi), %xmm5, %xmm0	# MEM[(double *)_528], tmp673, c0
# C/parallel-only-omp/simulation.h:278:         p   = int(c0);
	vcvttsd2sil	%xmm0, %edx	# c0, p
# C/parallel-only-omp/simulation.h:279:         c1  = p + 1.0 - c0;
	vcvtsi2sdl	%edx, %xmm6, %xmm3	# p, tmp692, tmp698
# C/parallel-only-omp/simulation.h:281:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%edx, %rax	# p, p
# C/parallel-only-omp/simulation.h:281:         e_x = c1 * efield[p] + c2 * efield[p+1];
	incl	%edx	# tmp548
# C/parallel-only-omp/simulation.h:279:         c1  = p + 1.0 - c0;
	vaddsd	%xmm10, %xmm3, %xmm1	# tmp668, _701, tmp542
# C/parallel-only-omp/simulation.h:279:         c1  = p + 1.0 - c0;
	vsubsd	%xmm0, %xmm1, %xmm1	# c0, tmp542, c1
# C/parallel-only-omp/simulation.h:280:         c2  = c0 - p;
	vsubsd	%xmm3, %xmm0, %xmm0	# _701, c0, c2
# C/parallel-only-omp/simulation.h:281:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%edx, %rdx	# tmp548, tmp549
	vunpcklpd	%xmm0, %xmm1, %xmm4	# c2, c1, tmp544
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	movl	$999999, %r13d	#, tmp699
# C/parallel-only-omp/simulation.h:281:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vmulsd	(%r15,%rdx,8), %xmm0, %xmm0	# efield[_703], c2, tmp550
# C/parallel-only-omp/simulation.h:281:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vfmadd132sd	(%r15,%rax,8), %xmm0, %xmm1	# efield[p_698], tmp550, e_x
	salq	$3, %rax	#, tmp554
# C/parallel-only-omp/simulation.h:283:         mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E;
	vmulsd	%xmm7, %xmm1, %xmm0	# tmp658, e_x, tmp551
# C/parallel-only-omp/simulation.h:283:         mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E;
	vfnmadd213sd	(%rdi), %xmm9, %xmm0	# MEM[(double *)_524], tmp662, mean_v
	leaq	(%rbx,%rax), %rdx	#, vectp.1042
# C/parallel-only-omp/simulation.h:285:         worker_buffers.counter_e[tid][p]   += c1;
	vaddpd	(%rdx), %xmm4, %xmm3	# MEM <vector(2) double> [(value_type &)vectp.1042_83], tmp544, vect__240.1044
	vmovupd	%xmm3, (%rdx)	# vect__240.1044, MEM <vector(2) double> [(value_type &)vectp.1042_83]
	leaq	(%r14,%rax), %rdx	#, vectp.1035
# C/parallel-only-omp/simulation.h:288:         worker_buffers.ue[tid][p]   += c1 * mean_v;
	vmovddup	%xmm0, %xmm3	# mean_v, tmp558
	vfmadd213pd	(%rdx), %xmm4, %xmm3	# MEM <vector(2) double> [(value_type &)vectp.1035_76], tmp544, vect__683.1038
	vmovupd	%xmm3, (%rdx)	# vect__683.1038, MEM <vector(2) double> [(value_type &)vectp.1035_76]
# C/parallel-only-omp/simulation.h:291:         v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vmovsd	(%r11), %xmm3	# MEM[(double *)_521], _674
# C/parallel-only-omp/simulation.h:291:         v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vmulsd	%xmm3, %xmm3, %xmm3	# _674, _674, tmp560
# C/parallel-only-omp/simulation.h:291:         v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vfmadd231sd	%xmm0, %xmm0, %xmm3	# mean_v, mean_v, _672
	movq	56(%rsp), %rdx	# %sfp, _192
# C/parallel-only-omp/simulation.h:291:         v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vmovsd	(%r10), %xmm0	# MEM[(double *)_520], _671
# C/parallel-only-omp/simulation.h:291:         v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vfmadd132sd	%xmm0, %xmm3, %xmm0	# _671, _672, v_sqr
	addq	%rax, %rdx	# tmp554, vectp.1021
# C/parallel-only-omp/simulation.h:292:         energy = 0.5 * E_MASS * v_sqr / EV_TO_J;
	vmulsd	%xmm16, %xmm0, %xmm3	# tmp663, v_sqr, tmp561
# C/parallel-only-omp/simulation.h:292:         energy = 0.5 * E_MASS * v_sqr / EV_TO_J;
	vdivsd	%xmm15, %xmm3, %xmm3	# tmp670, tmp561, energy
# C/parallel-only-omp/simulation.h:294:         worker_buffers.meanee[tid][p]   += c1 * energy;
	vmovddup	%xmm3, %xmm19	# energy, tmp565
	vfmadd213pd	(%rdx), %xmm4, %xmm19	# MEM <vector(2) double> [(value_type &)vectp.1021_225], tmp544, vect__664.1024
	vmovupd	%xmm19, (%rdx)	# vect__664.1024, MEM <vector(2) double> [(value_type &)vectp.1021_225]
# C/parallel-only-omp/simulation.h:297:         energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES-1);
	vdivsd	%xmm13, %xmm3, %xmm19	# tmp666, energy, tmp569
# C/parallel-only-omp/simulation.h:297:         energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES-1);
	vaddsd	%xmm7, %xmm19, %xmm19	# tmp658, tmp569, tmp571
# C/parallel-only-omp/simulation.h:297:         energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES-1);
	vcvttsd2sil	%xmm19, %edx	# tmp571, tmp568
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%r13d, %edx	# tmp699, tmp568
# C/parallel-only-omp/simulation.h:298:         velocity = sqrt(v_sqr);
	vsqrtsd	%xmm0, %xmm0, %xmm0	# v_sqr, velocity
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmovg	%r13d, %edx	# tmp568,, tmp699, tmp568
	addq	%r12, %rax	# _216, vectp.1028
# C/parallel-only-omp/simulation.h:299:         rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	movslq	%edx, %rdx	# tmp568, tmp573
# C/parallel-only-omp/simulation.h:299:         rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	vmulsd	16000000(%rcx,%rdx,8), %xmm0, %xmm0	# sigma[2][_655], velocity, tmp575
# C/parallel-only-omp/simulation.h:299:         rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	vmulsd	%xmm8, %xmm0, %xmm0	# tmp672, tmp575, tmp576
# C/parallel-only-omp/simulation.h:299:         rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	vmulsd	%xmm12, %xmm0, %xmm0	# tmp659, tmp576, rate
# C/parallel-only-omp/simulation.h:301:         worker_buffers.ioniz[tid][p]   += c1 * rate;
	vmovddup	%xmm0, %xmm0	# rate, tmp580
	vfmadd213pd	(%rax), %xmm0, %xmm4	# MEM <vector(2) double> [(value_type &)vectp.1028_70], tmp580, vect__647.1031
	vmovupd	%xmm4, (%rax)	# vect__647.1031, MEM <vector(2) double> [(value_type &)vectp.1028_70]
# C/parallel-only-omp/simulation.h:305:         if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)) {
	vmovsd	(%rsi), %xmm4	# MEM[(double *)_528], prephitmp_624
# C/parallel-only-omp/simulation.h:305:         if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)) {
	vcomisd	%xmm11, %xmm4	# tmp664, prephitmp_624
	jbe	.L137	#,
# C/parallel-only-omp/simulation.h:305:         if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)) {
	vcomisd	%xmm4, %xmm17	# prephitmp_624, tmp674
	jbe	.L137	#,
# C/parallel-only-omp/simulation.h:306:             energy_index = (int)(energy / DE_EEPF);
	vdivsd	%xmm18, %xmm3, %xmm0	# tmp675, energy, tmp584
# C/parallel-only-omp/simulation.h:306:             energy_index = (int)(energy / DE_EEPF);
	vcvttsd2sil	%xmm0, %eax	# tmp584, energy_index
# C/parallel-only-omp/simulation.h:307:             if (energy_index < N_EEPF) {
	cmpl	$1999, %eax	#, energy_index
	jg	.L140	#,
# C/parallel-only-omp/simulation.h:308:                 worker_buffers.eepf[tid][energy_index] += 1.0;
	movq	24(%rsp), %rdx	# %sfp, _236
# C/parallel-only-omp/simulation.h:308:                 worker_buffers.eepf[tid][energy_index] += 1.0;
	cltq
# C/parallel-only-omp/simulation.h:308:                 worker_buffers.eepf[tid][energy_index] += 1.0;
	vaddsd	(%rdx,%rax,8), %xmm10, %xmm0	# MEM <struct array> [(value_type &)_236]._M_elems[_630], tmp668, tmp586
	vmovsd	%xmm0, (%rdx,%rax,8)	# tmp586, MEM <struct array> [(value_type &)_236]._M_elems[_630]
.L140:
# C/parallel-only-omp/simulation.h:310:             worker_buffers.thread_counters[tid].accu_center   += energy;
	vaddsd	(%r8), %xmm3, %xmm3	# _266->accu_center, energy, tmp589
# C/parallel-only-omp/simulation.h:311:             worker_buffers.thread_counters[tid].counter_center++;
	incq	8(%r8)	# _266->counter_center
# C/parallel-only-omp/simulation.h:310:             worker_buffers.thread_counters[tid].accu_center   += energy;
	vmovsd	%xmm3, (%r8)	# tmp589, _266->accu_center
# C/parallel-only-omp/simulation.h:316:         x_e[k]  += vx_e[k] * DT_E;
	vmovsd	(%rsi), %xmm4	# MEM[(double *)_528], prephitmp_624
.L137:
# C/parallel-only-omp/simulation.h:315:         vx_e[k] -= e_x * FACTOR_E;
	vfnmadd213sd	(%rdi), %xmm9, %xmm1	# MEM[(double *)_524], tmp662, e_x
	vmovsd	%xmm1, %xmm1, %xmm0	# e_x, _621
# C/parallel-only-omp/simulation.h:316:         x_e[k]  += vx_e[k] * DT_E;
	vfmadd132sd	%xmm8, %xmm4, %xmm0	# tmp672, prephitmp_624, _618
	addq	$8, %rsi	#, ivtmp.1134
# C/parallel-only-omp/simulation.h:315:         vx_e[k] -= e_x * FACTOR_E;
	vmovsd	%xmm1, (%rdi)	# _621, MEM[(double *)_524]
	addq	$8, %r11	#, ivtmp.1136
	addq	$8, %rdi	#, ivtmp.1135
	addq	$8, %r10	#, ivtmp.1137
# C/parallel-only-omp/simulation.h:316:         x_e[k]  += vx_e[k] * DT_E;
	vmovsd	%xmm0, -8(%rsi)	# _618, MEM[(double *)_528]
	cmpq	%rsi, %r9	# ivtmp.1134, _511
	jne	.L141	#,
	movl	40(%rsp), %r12d	# %sfp, num_threads
	movslq	32(%rsp), %r14	# %sfp,
.L142:
	call	GOMP_barrier@PLT	#
# C/parallel-only-omp/simulation.h:319:     if (measurement_mode) {
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	je	.L176	#,
	movl	$400, %eax	#, q.73_168
	xorl	%edx, %edx	# tt.74_169
	idivl	48(%rsp)	# %sfp
	cmpl	%edx, 52(%rsp)	# tt.74_169, %sfp
	jl	.L179	#,
.L143:
	movl	52(%rsp), %edi	# %sfp, tmp599
	imull	%eax, %edi	# q.73_168, tmp599
	addl	%edx, %edi	# tt.74_169, _257
	leal	(%rax,%rdi), %edx	#, tmp600
	cmpl	%edx, %edi	# tmp600, _257
	jge	.L150	#,
	movslq	%edi, %rdi	# _257, _574
	movslq	%r12d, %rdx	# num_threads, num_threads
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	48+worker_buffers(%rip), %r11	# MEM[(struct vector *)&worker_buffers + 48B].D.103980._M_impl.D.103319._M_start, _386
	movq	72+worker_buffers(%rip), %r10	# MEM[(struct vector *)&worker_buffers + 72B].D.103980._M_impl.D.103319._M_start, _384
	movq	96+worker_buffers(%rip), %r9	# MEM[(struct vector *)&worker_buffers + 96B].D.103980._M_impl.D.103319._M_start, _382
	movq	120+worker_buffers(%rip), %r8	# MEM[(struct vector *)&worker_buffers + 120B].D.103980._M_impl.D.103319._M_start, _380
	movl	%eax, %eax	# q.73_168, q.73_168
	leaq	0(,%rdi,8), %rsi	#, ivtmp.1125
	leaq	counter_e_xt(%rip), %r15	#, tmp661
	leaq	meanee_xt(%rip), %r13	#, tmp669
	imulq	$200, %rdi, %rcx	#, _574, tmp614
	leaq	ioniz_rate_xt(%rip), %rbx	#, tmp671
	imulq	$400, %rdx, %rdx	#, num_threads, tmp612
	addq	%r14, %rcx	# t_index, tmp616
	leaq	ue_xt(%rip), %r14	#, tmp657
	addq	%rdi, %rdx	# _574, tmp613
	addq	%rax, %rdi	# q.73_168, tmp618
	salq	$3, %rdx	#, ivtmp.1126
	salq	$3, %rcx	#, ivtmp.1128
	salq	$3, %rdi	#, _553
	.p2align 4
	.p2align 3
.L149:
# C/parallel-only-omp/simulation.h:324:             for (int t = 0; t < num_threads; t++) {
	testl	%r12d, %r12d	# num_threads
	jle	.L159	#,
	movq	%rsi, %rax	# ivtmp.1125, ivtmp.1114
# C/parallel-only-omp/simulation.h:323:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# iz
# C/parallel-only-omp/simulation.h:323:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm1	#, m_e
# C/parallel-only-omp/simulation.h:323:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm2	#, u_e
# C/parallel-only-omp/simulation.h:323:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm3	#, c_e
	.p2align 4
	.p2align 3
.L148:
# C/parallel-only-omp/simulation.h:325:                 c_e += worker_buffers.counter_e[t][p];
	vaddsd	(%r11,%rax), %xmm3, %xmm3	# MEM[(value_type &)_386 + ivtmp.1114_584 * 1], c_e, c_e
# C/parallel-only-omp/simulation.h:326:                 u_e += worker_buffers.ue[t][p];
	vaddsd	(%r10,%rax), %xmm2, %xmm2	# MEM[(value_type &)_384 + ivtmp.1114_584 * 1], u_e, u_e
# C/parallel-only-omp/simulation.h:327:                 m_e += worker_buffers.meanee[t][p];
	vaddsd	(%r9,%rax), %xmm1, %xmm1	# MEM[(value_type &)_382 + ivtmp.1114_584 * 1], m_e, m_e
# C/parallel-only-omp/simulation.h:328:                 iz  += worker_buffers.ioniz[t][p];
	vaddsd	(%r8,%rax), %xmm0, %xmm0	# MEM[(value_type &)_380 + ivtmp.1114_584 * 1], iz, iz
# C/parallel-only-omp/simulation.h:324:             for (int t = 0; t < num_threads; t++) {
	addq	$3200, %rax	#, ivtmp.1114
	cmpq	%rax, %rdx	# ivtmp.1114, ivtmp.1126
	jne	.L148	#,
.L147:
	addq	$8, %rsi	#, ivtmp.1125
# C/parallel-only-omp/simulation.h:330:             counter_e_xt[p][t_index]   += c_e;
	vaddsd	(%r15,%rcx), %xmm3, %xmm3	# MEM[(double *)&counter_e_xt + ivtmp.1128_566 * 1], c_e, tmp621
# C/parallel-only-omp/simulation.h:331:             ue_xt[p][t_index]          += u_e;
	vaddsd	(%r14,%rcx), %xmm2, %xmm2	# MEM[(double *)&ue_xt + ivtmp.1128_566 * 1], u_e, tmp625
# C/parallel-only-omp/simulation.h:332:             meanee_xt[p][t_index]      += m_e;
	vaddsd	0(%r13,%rcx), %xmm1, %xmm1	# MEM[(double *)&meanee_xt + ivtmp.1128_566 * 1], m_e, tmp629
# C/parallel-only-omp/simulation.h:333:             ioniz_rate_xt[p][t_index]  += iz;
	vaddsd	(%rbx,%rcx), %xmm0, %xmm0	# MEM[(double *)&ioniz_rate_xt + ivtmp.1128_566 * 1], iz, tmp633
# C/parallel-only-omp/simulation.h:330:             counter_e_xt[p][t_index]   += c_e;
	vmovsd	%xmm3, (%r15,%rcx)	# tmp621, MEM[(double *)&counter_e_xt + ivtmp.1128_566 * 1]
# C/parallel-only-omp/simulation.h:331:             ue_xt[p][t_index]          += u_e;
	vmovsd	%xmm2, (%r14,%rcx)	# tmp625, MEM[(double *)&ue_xt + ivtmp.1128_566 * 1]
# C/parallel-only-omp/simulation.h:332:             meanee_xt[p][t_index]      += m_e;
	vmovsd	%xmm1, 0(%r13,%rcx)	# tmp629, MEM[(double *)&meanee_xt + ivtmp.1128_566 * 1]
# C/parallel-only-omp/simulation.h:333:             ioniz_rate_xt[p][t_index]  += iz;
	vmovsd	%xmm0, (%rbx,%rcx)	# tmp633, MEM[(double *)&ioniz_rate_xt + ivtmp.1128_566 * 1]
	addq	$8, %rdx	#, ivtmp.1126
	addq	$1600, %rcx	#, ivtmp.1128
	cmpq	%rsi, %rdi	# ivtmp.1125, _553
	jne	.L149	#,
.L150:
	movl	$2000, %eax	#, q.71_166
	xorl	%edx, %edx	# tt.72_167
	idivl	48(%rsp)	# %sfp
	cmpl	%edx, 52(%rsp)	# tt.72_167, %sfp
	jl	.L180	#,
.L146:
	movl	52(%rsp), %ecx	# %sfp, _197
	imull	%eax, %ecx	# q.71_166, _197
	addl	%ecx, %edx	# tmp635, _283
	leal	(%rax,%rdx), %ecx	#, tmp636
	cmpl	%ecx, %edx	# tmp636, _283
	jge	.L157	#,
	movslq	%r12d, %rdi	# num_threads, _604
	movslq	%edx, %rsi	# _283, _430
	movq	144+worker_buffers(%rip), %r9	# MEM[(struct vector *)&worker_buffers + 144B].D.105034._M_impl.D.104373._M_start, MEM[(struct vector *)&worker_buffers + 144B].D.105034._M_impl.D.104373._M_start
	leaq	eepf(%rip), %r8	#, tmp638
	imulq	$2000, %rdi, %rdx	#, _604, tmp639
	movl	%eax, %eax	# q.71_166, q.71_166
	leaq	(%r8,%rsi,8), %rcx	#, ivtmp.1098
	addq	%rsi, %rax	# _430, tmp645
	leaq	(%r8,%rax,8), %r8	#, _588
	addq	%rsi, %rdx	# _430, tmp640
	imulq	$-16000, %rdi, %rsi	#, _604, _586
	leaq	(%r9,%rdx,8), %rdx	#, ivtmp.1102
	.p2align 4
	.p2align 3
.L156:
# C/parallel-only-omp/simulation.h:340:             for (int t = 0; t < num_threads; t++) {
	testl	%r12d, %r12d	# num_threads
	jle	.L160	#,
	movq	%rsi, %rdi	# _586, tmp677
	leaq	(%rsi,%rdx), %rax	#, ivtmp.1092
# C/parallel-only-omp/simulation.h:339:             double sum_eepf = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# sum_eepf
	negq	%rdi	# tmp677
	andl	$128, %edi	#, tmp677
	je	.L155	#,
# C/parallel-only-omp/simulation.h:341:                 sum_eepf += worker_buffers.eepf[t][i];
	vaddsd	(%rax), %xmm0, %xmm0	# MEM[(value_type &)_132], sum_eepf, sum_eepf
# C/parallel-only-omp/simulation.h:340:             for (int t = 0; t < num_threads; t++) {
	addq	$16000, %rax	#, ivtmp.1092
	cmpq	%rdx, %rax	# ivtmp.1102, ivtmp.1092
	je	.L154	#,
	.p2align 4
	.p2align 3
.L155:
# C/parallel-only-omp/simulation.h:341:                 sum_eepf += worker_buffers.eepf[t][i];
	vaddsd	(%rax), %xmm0, %xmm0	# MEM[(value_type &)_132], sum_eepf, sum_eepf
# C/parallel-only-omp/simulation.h:340:             for (int t = 0; t < num_threads; t++) {
	addq	$32000, %rax	#, ivtmp.1092
# C/parallel-only-omp/simulation.h:341:                 sum_eepf += worker_buffers.eepf[t][i];
	vaddsd	-16000(%rax), %xmm0, %xmm0	# MEM[(value_type &)_132], sum_eepf, sum_eepf
# C/parallel-only-omp/simulation.h:340:             for (int t = 0; t < num_threads; t++) {
	cmpq	%rdx, %rax	# ivtmp.1102, ivtmp.1092
	jne	.L155	#,
.L154:
# C/parallel-only-omp/simulation.h:343:             eepf[i] += sum_eepf;
	vaddsd	(%rcx), %xmm0, %xmm0	# MEM[(double *)_598], sum_eepf, tmp648
	addq	$8, %rcx	#, ivtmp.1098
	vmovsd	%xmm0, -8(%rcx)	# tmp648, MEM[(double *)_598]
	addq	$8, %rdx	#, ivtmp.1102
	cmpq	%rcx, %r8	# ivtmp.1098, _588
	jne	.L156	#,
.L157:
	call	GOMP_barrier@PLT	#
	call	GOMP_single_start@PLT	#
	testb	%al, %al	# tmp691
	je	.L153	#,
# C/parallel-only-omp/simulation.h:349:             for (int t = 0; t < num_threads; t++) {
	testl	%r12d, %r12d	# num_threads
	jle	.L153	#,
	movq	168+worker_buffers(%rip), %rdx	# MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, ivtmp.1085
	movq	mean_energy_counter_center(%rip), %rcx	# mean_energy_counter_center, mean_energy_counter_center_lsm.1017
	movslq	%r12d, %rax	# num_threads, num_threads
	vmovsd	mean_energy_accu_center(%rip), %xmm0	# mean_energy_accu_center, mean_energy_accu_center_lsm.1016
	salq	$6, %rax	#, tmp652
	addq	%rdx, %rax	# ivtmp.1085, _696
	.p2align 4
	.p2align 3
.L158:
# C/parallel-only-omp/simulation.h:351:                 mean_energy_counter_center += worker_buffers.thread_counters[t].counter_center;
	addq	8(%rdx), %rcx	# MEM[(long long unsigned int *)_126 + 8B], mean_energy_counter_center_lsm.1017
# C/parallel-only-omp/simulation.h:350:                 mean_energy_accu_center    += worker_buffers.thread_counters[t].accu_center;
	vaddsd	(%rdx), %xmm0, %xmm0	# MEM[(double *)_126], mean_energy_accu_center_lsm.1016, mean_energy_accu_center_lsm.1016
# C/parallel-only-omp/simulation.h:349:             for (int t = 0; t < num_threads; t++) {
	addq	$64, %rdx	#, ivtmp.1085
	cmpq	%rax, %rdx	# _696, ivtmp.1085
	jne	.L158	#,
	vmovsd	%xmm0, mean_energy_accu_center(%rip)	# mean_energy_accu_center_lsm.1016, mean_energy_accu_center
	movq	%rcx, mean_energy_counter_center(%rip)	# mean_energy_counter_center_lsm.1017, mean_energy_counter_center
.L153:
# C/parallel-only-omp/simulation.h:355: }
	leaq	-40(%rbp), %rsp	#,
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	jmp	GOMP_barrier@PLT	#
.L180:
	.cfi_restore_state
	incl	%eax	# q.71_166
# C/parallel-only-omp/simulation.h:323:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	xorl	%edx, %edx	# tt.72_167
	jmp	.L146	#
.L179:
	incl	%eax	# q.73_168
# C/parallel-only-omp/simulation.h:319:     if (measurement_mode) {
	xorl	%edx, %edx	# tt.74_169
	jmp	.L143	#
.L178:
	incl	%eax	# q.75_170
# C/parallel-only-omp/simulation.h:268:         worker_buffers.thread_counters[tid].counter_center = 0;
	xorl	%edx, %edx	# tt.76_171
	jmp	.L134	#
.L160:
# C/parallel-only-omp/simulation.h:339:             double sum_eepf = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# sum_eepf
	jmp	.L154	#
.L159:
# C/parallel-only-omp/simulation.h:323:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# iz
# C/parallel-only-omp/simulation.h:323:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm1	#, m_e
# C/parallel-only-omp/simulation.h:323:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm2	#, u_e
# C/parallel-only-omp/simulation.h:323:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm3	#, c_e
	jmp	.L147	#
	.cfi_endproc
.LFE9877:
	.size	_Z25step3_move_electrons_bodyiii, .-_Z25step3_move_electrons_bodyiii
	.section	.text._Z20step4_move_ions_bodyiiii,"axG",@progbits,_Z20step4_move_ions_bodyiiii,comdat
	.p2align 4
	.weak	_Z20step4_move_ions_bodyiiii
	.type	_Z20step4_move_ions_bodyiiii, @function
_Z20step4_move_ions_bodyiiii:
.LFB9879:
	.cfi_startproc
	endbr64	
# C/parallel-only-omp/simulation.h:387:     if ((t % N_SUB) != 0) return;
	movslq	%ecx, %rax	# t, t
# C/parallel-only-omp/simulation.h:386: PIC_STEP void step4_move_ions_body(int tid, int num_threads, int t_index, int t) {
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
# C/parallel-only-omp/simulation.h:387:     if ((t % N_SUB) != 0) return;
	imulq	$1717986919, %rax, %rax	#, t, tmp305
# C/parallel-only-omp/simulation.h:386: PIC_STEP void step4_move_ions_body(int tid, int num_threads, int t_index, int t) {
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%r15	#
	pushq	%r14	#
	pushq	%r13	#
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	movslq	%edx, %r13	# tmp520,
# C/parallel-only-omp/simulation.h:387:     if ((t % N_SUB) != 0) return;
	movl	%ecx, %edx	# t, tmp308
# C/parallel-only-omp/simulation.h:386: PIC_STEP void step4_move_ions_body(int tid, int num_threads, int t_index, int t) {
	pushq	%r12	#
# C/parallel-only-omp/simulation.h:387:     if ((t % N_SUB) != 0) return;
	sarl	$31, %edx	#, tmp308
	sarq	$35, %rax	#, tmp307
	subl	%edx, %eax	# tmp308, _1
# C/parallel-only-omp/simulation.h:386: PIC_STEP void step4_move_ions_body(int tid, int num_threads, int t_index, int t) {
	pushq	%rbx	#
# C/parallel-only-omp/simulation.h:387:     if ((t % N_SUB) != 0) return;
	leal	(%rax,%rax,4), %eax	#, tmp311
# C/parallel-only-omp/simulation.h:386: PIC_STEP void step4_move_ions_body(int tid, int num_threads, int t_index, int t) {
	andq	$-32, %rsp	#,
# C/parallel-only-omp/simulation.h:387:     if ((t % N_SUB) != 0) return;
	sall	$2, %eax	#, tmp312
# C/parallel-only-omp/simulation.h:386: PIC_STEP void step4_move_ions_body(int tid, int num_threads, int t_index, int t) {
	subq	$32, %rsp	#,
	.cfi_offset 12, -48
	.cfi_offset 3, -56
# C/parallel-only-omp/simulation.h:387:     if ((t % N_SUB) != 0) return;
	cmpl	%eax, %ecx	# tmp312, t
	jne	.L206	#,
# C/parallel-only-omp/simulation.h:389:     if (__builtin_expect(!measurement_mode, 1)) {
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
# C/parallel-only-omp/simulation.h:390:         int chunk = (N_i + num_threads - 1) / num_threads;
	movl	N_i(%rip), %r14d	# N_i, pretmp_543
	movl	%edi, %r8d	# tmp518, tid
	movl	%esi, %r12d	# tmp519, num_threads
	vxorps	%xmm6, %xmm6, %xmm6	# tmp524
# C/parallel-only-omp/simulation.h:389:     if (__builtin_expect(!measurement_mode, 1)) {
	jne	.L184	#,
# C/parallel-only-omp/simulation.h:390:         int chunk = (N_i + num_threads - 1) / num_threads;
	leal	-1(%r14,%rsi), %eax	#, tmp314
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	movl	%r14d, %edi	# pretmp_543, pretmp_543
# C/parallel-only-omp/simulation.h:390:         int chunk = (N_i + num_threads - 1) / num_threads;
	cltd
	idivl	%esi	# num_threads
# C/parallel-only-omp/simulation.h:391:         int k_start = std::min(tid * chunk, N_i);
	imull	%eax, %r8d	# tmp315, tmp317
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%r14d, %r8d	# pretmp_543, tmp317
	movl	%r8d, %esi	# tmp317, tmp317
	cmovg	%r14d, %esi	# tmp317,, pretmp_543, tmp317
# C/parallel-only-omp/simulation.h:392:         int k_end   = std::min(k_start + chunk, N_i);
	addl	%esi, %eax	# k, tmp318
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%r14d, %eax	# pretmp_543, tmp318
	cmovle	%eax, %edi	# tmp318,, pretmp_543
# C/parallel-only-omp/simulation.h:395:         int k_unroll_end = k_start + ((k_end - k_start) / 4) * 4;
	movl	%edi, %r8d	# _79, tmp319
	subl	%esi, %r8d	# k, tmp319
# C/parallel-only-omp/simulation.h:395:         int k_unroll_end = k_start + ((k_end - k_start) / 4) * 4;
	movl	%r8d, %edx	# tmp319, tmp325
	sarl	$31, %edx	#, tmp325
	shrl	$30, %edx	#, tmp326
	leal	(%r8,%rdx), %eax	#, tmp327
	andl	$3, %eax	#, tmp328
	subl	%edx, %eax	# tmp326, tmp329
	subl	%eax, %r8d	# tmp329, _13
# C/parallel-only-omp/simulation.h:395:         int k_unroll_end = k_start + ((k_end - k_start) / 4) * 4;
	leal	(%r8,%rsi), %eax	#, k_unroll_end
# C/parallel-only-omp/simulation.h:398:         for (; k < k_unroll_end; k += 4) {
	cmpl	%esi, %eax	# k, k_unroll_end
	jle	.L185	#,
	decl	%r8d	# tmp333
	vbroadcastsd	.LC67(%rip), %ymm9	#, tmp516
	vbroadcastsd	.LC54(%rip), %ymm8	#, tmp512
	movslq	%esi, %r9	# k, _490
	shrl	$2, %r8d	#, _464
	vmovsd	.LC59(%rip), %xmm5	#, tmp511
	leaq	0(,%r9,8), %rcx	#, _489
	leaq	vx_i(%rip), %rax	#, tmp332
	leaq	x_i(%rip), %rdx	#, tmp331
	leaq	efield(%rip), %r14	#, tmp515
	addq	%rcx, %rdx	# _489, ivtmp.1200
	addq	%rax, %rcx	# tmp332, ivtmp.1201
	leal	0(,%r8,4), %eax	#, tmp335
	addq	%r9, %rax	# _490, tmp336
	leaq	32+x_i(%rip), %r9	#, tmp338
	leaq	(%r9,%rax,8), %r9	#, _457
	.p2align 4
	.p2align 3
.L186:
# C/parallel-only-omp/simulation.h:399:             double x0 = x_i[k+0], x1 = x_i[k+1], x2 = x_i[k+2], x3 = x_i[k+3];
	vmovupd	(%rdx), %ymm3	# MEM <vector(4) double> [(double *)_481], MEM <vector(4) double> [(double *)_481]
# C/parallel-only-omp/simulation.h:398:         for (; k < k_unroll_end; k += 4) {
	addq	$32, %rdx	#, ivtmp.1200
	addq	$32, %rcx	#, ivtmp.1201
# C/parallel-only-omp/simulation.h:402:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	vextractf64x2	$1, %ymm3, %xmm10	#, MEM <vector(4) double> [(double *)_481], tmp348
# C/parallel-only-omp/simulation.h:402:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	vmulsd	%xmm5, %xmm3, %xmm4	# tmp511, tmp342, c0_0
# C/parallel-only-omp/simulation.h:403:             int p0 = int(c0_0), p1 = int(c0_1), p2 = int(c0_2), p3 = int(c0_3);
	vcvttsd2sil	%xmm4, %ebx	# c0_0, p0
# C/parallel-only-omp/simulation.h:402:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	vunpckhpd	%xmm3, %xmm3, %xmm0	# tmp343, tmp345
	vmulsd	%xmm5, %xmm0, %xmm0	# tmp511, tmp345, c0_1
# C/parallel-only-omp/simulation.h:403:             int p0 = int(c0_0), p1 = int(c0_1), p2 = int(c0_2), p3 = int(c0_3);
	vcvttsd2sil	%xmm0, %r11d	# c0_1, p1
# C/parallel-only-omp/simulation.h:404:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vcvtsi2sdl	%r11d, %xmm6, %xmm1	# p1, tmp524, tmp525
# C/parallel-only-omp/simulation.h:404:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vsubsd	%xmm1, %xmm0, %xmm1	# tmp354, c0_1, c2_1
# C/parallel-only-omp/simulation.h:402:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	valignq	$3, %ymm3, %ymm3, %ymm7	#, MEM <vector(4) double> [(double *)_481], tmp351
# C/parallel-only-omp/simulation.h:402:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	vmulsd	%xmm5, %xmm10, %xmm10	# tmp511, tmp348, c0_2
# C/parallel-only-omp/simulation.h:403:             int p0 = int(c0_0), p1 = int(c0_1), p2 = int(c0_2), p3 = int(c0_3);
	vcvttsd2sil	%xmm10, %r10d	# c0_2, p2
# C/parallel-only-omp/simulation.h:404:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vcvtsi2sdl	%r10d, %xmm6, %xmm0	# p2, tmp524, tmp526
# C/parallel-only-omp/simulation.h:404:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vsubsd	%xmm0, %xmm10, %xmm11	# tmp355, c0_2, c2_2
# C/parallel-only-omp/simulation.h:406:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	movslq	%ebx, %r12	# p0, p0
# C/parallel-only-omp/simulation.h:402:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	vmulsd	%xmm5, %xmm7, %xmm7	# tmp511, tmp351, c0_3
# C/parallel-only-omp/simulation.h:403:             int p0 = int(c0_0), p1 = int(c0_1), p2 = int(c0_2), p3 = int(c0_3);
	vcvttsd2sil	%xmm7, %eax	# c0_3, p3
# C/parallel-only-omp/simulation.h:404:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vcvtsi2sdl	%eax, %xmm6, %xmm0	# p3, tmp524, tmp527
# C/parallel-only-omp/simulation.h:406:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	vmovsd	(%r14,%r12,8), %xmm12	# efield[p0_233], _21
# C/parallel-only-omp/simulation.h:404:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vsubsd	%xmm0, %xmm7, %xmm10	# tmp356, c0_3, c2_3
# C/parallel-only-omp/simulation.h:406:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	leal	1(%rbx), %r12d	#, tmp360
# C/parallel-only-omp/simulation.h:404:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vcvtsi2sdl	%ebx, %xmm6, %xmm7	# p0, tmp524, tmp528
# C/parallel-only-omp/simulation.h:407:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	movslq	%r11d, %rbx	# p1, p1
# C/parallel-only-omp/simulation.h:407:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	incl	%r11d	# tmp369
# C/parallel-only-omp/simulation.h:406:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	movslq	%r12d, %r12	# tmp360, tmp361
# C/parallel-only-omp/simulation.h:404:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vsubsd	%xmm7, %xmm4, %xmm4	# tmp364, c0_0, c2_0
# C/parallel-only-omp/simulation.h:407:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	movslq	%r11d, %r11	# tmp369, tmp370
# C/parallel-only-omp/simulation.h:406:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	vmovsd	(%r14,%r12,8), %xmm0	# efield[_22], efield[_22]
	vsubsd	%xmm12, %xmm0, %xmm0	# _21, efield[_22], tmp362
# C/parallel-only-omp/simulation.h:406:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	vfmadd132sd	%xmm4, %xmm12, %xmm0	# c2_0, _21, ex0
# C/parallel-only-omp/simulation.h:407:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	vmovsd	(%r14,%r11,8), %xmm4	# efield[_27], efield[_27]
# C/parallel-only-omp/simulation.h:408:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	movslq	%r10d, %r11	# p2, p2
# C/parallel-only-omp/simulation.h:408:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	incl	%r10d	# tmp376
# C/parallel-only-omp/simulation.h:407:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	vmovsd	(%r14,%rbx,8), %xmm7	# efield[p1_234], _26
# C/parallel-only-omp/simulation.h:408:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	movslq	%r10d, %r10	# tmp376, tmp377
# C/parallel-only-omp/simulation.h:407:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	vsubsd	%xmm7, %xmm4, %xmm4	# _26, efield[_27], tmp371
# C/parallel-only-omp/simulation.h:407:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	vfmadd132sd	%xmm1, %xmm7, %xmm4	# c2_1, _26, ex1
# C/parallel-only-omp/simulation.h:408:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	vmovsd	(%r14,%r11,8), %xmm7	# efield[p2_235], _31
# C/parallel-only-omp/simulation.h:408:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	vmovsd	(%r14,%r10,8), %xmm1	# efield[_32], efield[_32]
# C/parallel-only-omp/simulation.h:409:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	movslq	%eax, %r10	# p3, p3
# C/parallel-only-omp/simulation.h:409:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	incl	%eax	# tmp383
# C/parallel-only-omp/simulation.h:408:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	vsubsd	%xmm7, %xmm1, %xmm1	# _31, efield[_32], tmp378
# C/parallel-only-omp/simulation.h:409:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	cltq
# C/parallel-only-omp/simulation.h:408:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	vfmadd132sd	%xmm11, %xmm7, %xmm1	# c2_2, _31, ex2
# C/parallel-only-omp/simulation.h:409:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	vmovsd	(%r14,%r10,8), %xmm11	# efield[p3_236], _36
# C/parallel-only-omp/simulation.h:409:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	vmovsd	(%r14,%rax,8), %xmm7	# efield[_37], efield[_37]
	vsubsd	%xmm11, %xmm7, %xmm7	# _36, efield[_37], tmp385
# C/parallel-only-omp/simulation.h:409:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	vfmadd132sd	%xmm10, %xmm11, %xmm7	# c2_3, _36, ex3
# C/parallel-only-omp/simulation.h:411:             double vn0 = v0 + ex0 * FACTOR_I;
	vunpcklpd	%xmm4, %xmm0, %xmm0	# ex1, ex0, tmp389
	vunpcklpd	%xmm7, %xmm1, %xmm1	# ex3, ex2, tmp388
	vinsertf128	$0x1, %xmm1, %ymm0, %ymm0	# tmp388, tmp389, tmp387
	vfmadd213pd	-32(%rcx), %ymm9, %ymm0	# MEM <vector(4) double> [(double *)_475], tmp516, vect_vn0_245.1175
# C/parallel-only-omp/simulation.h:417:             x_i[k+0] = x0 + vn0 * DT_I;
	vfmadd231pd	%ymm8, %ymm0, %ymm3	# tmp512, vect_vn0_245.1175, vect__46.1180
# C/parallel-only-omp/simulation.h:416:             vx_i[k+0] = vn0; vx_i[k+1] = vn1; vx_i[k+2] = vn2; vx_i[k+3] = vn3;
	vmovupd	%ymm0, -32(%rcx)	# vect_vn0_245.1175, MEM <vector(4) double> [(double *)_475]
# C/parallel-only-omp/simulation.h:417:             x_i[k+0] = x0 + vn0 * DT_I;
	vmovupd	%ymm3, -32(%rdx)	# vect__46.1180, MEM <vector(4) double> [(double *)_481]
# C/parallel-only-omp/simulation.h:398:         for (; k < k_unroll_end; k += 4) {
	cmpq	%rdx, %r9	# ivtmp.1200, _457
	jne	.L186	#,
	leal	4(%rsi,%r8,4), %esi	#, k
	vzeroupper
.L185:
# C/parallel-only-omp/simulation.h:423:         for (; k < k_end; k++) {
	cmpl	%edi, %esi	# _79, k
	jge	.L206	#,
	movslq	%esi, %r8	# k, _301
	subl	%esi, %edi	# k, tmp399
	leaq	x_i(%rip), %rcx	#, tmp396
	leaq	vx_i(%rip), %r9	#, tmp397
	leaq	0(,%r8,8), %rdx	#, _299
	addq	%r8, %rdi	# _301, tmp400
	leaq	efield(%rip), %r14	#, tmp515
	vmovsd	.LC59(%rip), %xmm5	#, tmp511
	leaq	(%rdx,%rcx), %rax	#, ivtmp.1189
	leaq	(%rcx,%rdi,8), %rdi	#, _494
	addq	%r9, %rdx	# tmp397, ivtmp.1190
	vmovsd	.LC67(%rip), %xmm8	#, tmp513
	vmovsd	.LC54(%rip), %xmm9	#, tmp510
	.p2align 4
	.p2align 3
.L188:
# C/parallel-only-omp/simulation.h:424:             double c0 = x_i[k] * INV_DX;
	vmovsd	(%rax), %xmm4	# MEM[(double *)_249], _53
# C/parallel-only-omp/simulation.h:424:             double c0 = x_i[k] * INV_DX;
	vmulsd	%xmm5, %xmm4, %xmm0	# tmp511, _53, c0
# C/parallel-only-omp/simulation.h:425:             int p     = int(c0);
	vcvttsd2sil	%xmm0, %ecx	# c0, p
# C/parallel-only-omp/simulation.h:427:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	movslq	%ecx, %rsi	# p, p
	vmovsd	(%r14,%rsi,8), %xmm7	# efield[p_214], _55
# C/parallel-only-omp/simulation.h:427:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	leal	1(%rcx), %esi	#, tmp407
# C/parallel-only-omp/simulation.h:426:             double c2 = c0 - p;
	vcvtsi2sdl	%ecx, %xmm6, %xmm3	# p, tmp524, tmp529
# C/parallel-only-omp/simulation.h:426:             double c2 = c0 - p;
	vsubsd	%xmm3, %xmm0, %xmm0	# tmp411, c0, c2
# C/parallel-only-omp/simulation.h:427:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	movslq	%esi, %rsi	# tmp407, tmp408
# C/parallel-only-omp/simulation.h:423:         for (; k < k_end; k++) {
	addq	$8, %rax	#, ivtmp.1189
	addq	$8, %rdx	#, ivtmp.1190
# C/parallel-only-omp/simulation.h:427:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	vmovsd	(%r14,%rsi,8), %xmm1	# efield[_56], efield[_56]
	vsubsd	%xmm7, %xmm1, %xmm1	# _55, efield[_56], tmp409
# C/parallel-only-omp/simulation.h:427:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	vfmadd132sd	%xmm1, %xmm7, %xmm0	# tmp409, _55, e_x
# C/parallel-only-omp/simulation.h:428:             double v   = vx_i[k] + e_x * FACTOR_I;
	vfmadd213sd	-8(%rdx), %xmm8, %xmm0	# MEM[(double *)_255], tmp513, v
# C/parallel-only-omp/simulation.h:429:             vx_i[k]    = v;
	vmovsd	%xmm0, -8(%rdx)	# v, MEM[(double *)_255]
# C/parallel-only-omp/simulation.h:430:             x_i[k]    += v * DT_I;
	vfmadd132sd	%xmm9, %xmm4, %xmm0	# tmp510, _53, _63
	vmovsd	%xmm0, -8(%rax)	# _63, MEM[(double *)_249]
# C/parallel-only-omp/simulation.h:423:         for (; k < k_end; k++) {
	cmpq	%rdi, %rax	# _494, ivtmp.1189
	jne	.L188	#,
.L206:
# C/parallel-only-omp/simulation.h:485: }
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
.L184:
	.cfi_restore_state
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	192+worker_buffers(%rip), %r15	# MEM[(struct vector *)&worker_buffers + 192B].D.103980._M_impl.D.103319._M_start, _263
# C/parallel-only-omp/simulation.h:436:         worker_buffers.counter_i[tid].fill(0.0);
	movslq	%edi, %rbx	# tid, tid
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
	movl	$3200, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	imulq	$3200, %rbx, %rbx	#, tid, _262
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	%rbx, %r15	# _262, _263
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%r15, %rdi	# _263,
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	216+worker_buffers(%rip), %r9	# MEM[(struct vector *)&worker_buffers + 216B].D.103980._M_impl.D.103319._M_start, _209
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
	movl	$3200, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	%rbx, %r9	# _262, _209
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%r9, %rdi	# _209,
	movq	%r9, 16(%rsp)	# _209, %sfp
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	240+worker_buffers(%rip), %rbx	# MEM[(struct vector *)&worker_buffers + 240B].D.103980._M_impl.D.103319._M_start, _165
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movl	$3200, %edx	#,
	xorl	%esi, %esi	#
	movq	%rbx, %rdi	# _165,
	call	memset@PLT	#
	call	omp_get_num_threads@PLT	#
	movl	%eax, 28(%rsp)	# tmp522, %sfp
	call	omp_get_thread_num@PLT	#
	movq	16(%rsp), %r9	# %sfp, _209
	vxorps	%xmm6, %xmm6, %xmm6	# tmp524
	movl	%eax, %r8d	# tmp523, _147
	movl	%r14d, %eax	# pretmp_543, pretmp_543
	cltd
	idivl	28(%rsp)	# %sfp
	cmpl	%edx, %r8d	# tt.87_131, _147
	jl	.L208	#,
.L189:
	movl	%eax, %esi	# q.86_130, tmp439
	imull	%r8d, %esi	# _147, tmp439
	addl	%esi, %edx	# tmp439, _152
	leal	(%rax,%rdx), %ecx	#, tmp440
	cmpl	%ecx, %edx	# tmp440, _152
	jge	.L193	#,
	movslq	%edx, %r10	# _152, _152
	movl	%eax, %eax	# q.86_130, q.86_130
	leaq	x_i(%rip), %rsi	#, tmp442
	leaq	vx_i(%rip), %rcx	#, tmp443
	salq	$3, %r10	#, _420
	movl	%r13d, 16(%rsp)	# t_index, %sfp
	vmovsd	.LC59(%rip), %xmm5	#, tmp511
	vmovsd	.LC67(%rip), %xmm8	#, tmp513
	vmovsd	.LC54(%rip), %xmm9	#, tmp510
	vmovsd	.LC45(%rip), %xmm11	#, tmp507
	vmovsd	.LC53(%rip), %xmm10	#, tmp509
	vmovsd	.LC50(%rip), %xmm7	#, tmp508
	salq	$3, %rax	#, _394
	leaq	vy_i(%rip), %r11	#, tmp445
	leaq	vz_i(%rip), %rdx	#, tmp446
	addq	%r10, %rsi	# _420, ivtmp.1233
	addq	%r10, %rcx	# _420, ivtmp.1234
	addq	%r10, %r11	# _420, _402
	addq	%rdx, %r10	# tmp446, _399
	movl	%r12d, %r13d	# num_threads, num_threads
	xorl	%edi, %edi	# ivtmp.1239
	movl	%r8d, %r12d	# _147, _147
	leaq	efield(%rip), %r14	#, tmp515
	movq	%r11, %r8	# _402, _402
	movq	%r10, %r11	# _399, _399
	movq	%rax, %r10	# _394, _394
	.p2align 4
	.p2align 3
.L192:
# C/parallel-only-omp/simulation.h:446:         c0  = x_i[k] * INV_DX;
	vmulsd	(%rsi), %xmm5, %xmm1	# MEM[(double *)_410], tmp511, c0
# C/parallel-only-omp/simulation.h:447:         p   = int(c0);
	vcvttsd2sil	%xmm1, %edx	# c0, p
# C/parallel-only-omp/simulation.h:448:         c1  = p + 1 - c0;
	leal	1(%rdx), %eax	#, _69
# C/parallel-only-omp/simulation.h:449:         c2  = c0 - p;
	vcvtsi2sdl	%edx, %xmm6, %xmm3	# p, tmp524, tmp531
# C/parallel-only-omp/simulation.h:448:         c1  = p + 1 - c0;
	vcvtsi2sdl	%eax, %xmm6, %xmm0	# _69, tmp524, tmp530
# C/parallel-only-omp/simulation.h:450:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%edx, %rdx	# p, p
# C/parallel-only-omp/simulation.h:450:         e_x = c1 * efield[p] + c2 * efield[p+1];
	cltq
# C/parallel-only-omp/simulation.h:448:         c1  = p + 1 - c0;
	vsubsd	%xmm1, %xmm0, %xmm0	# c0, tmp449, c1
# C/parallel-only-omp/simulation.h:449:         c2  = c0 - p;
	vsubsd	%xmm3, %xmm1, %xmm1	# tmp450, c0, c2
	vunpcklpd	%xmm1, %xmm0, %xmm4	# c2, c1, tmp451
# C/parallel-only-omp/simulation.h:450:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vmulsd	(%r14,%rax,8), %xmm1, %xmm1	# efield[_69], c2, tmp456
# C/parallel-only-omp/simulation.h:450:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vfmadd132sd	(%r14,%rdx,8), %xmm1, %xmm0	# efield[p_155], tmp456, e_x
	salq	$3, %rdx	#, tmp460
# C/parallel-only-omp/simulation.h:452:         mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I;
	vmulsd	%xmm11, %xmm0, %xmm1	# tmp507, e_x, tmp457
# C/parallel-only-omp/simulation.h:452:         mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I;
	vfmadd213sd	(%rcx), %xmm8, %xmm1	# MEM[(double *)_407], tmp513, mean_v
	leaq	(%r15,%rdx), %rax	#, vectp.1166
	addq	$8, %rsi	#, ivtmp.1233
	addq	$8, %rcx	#, ivtmp.1234
# C/parallel-only-omp/simulation.h:454:         worker_buffers.counter_i[tid][p]   += c1;
	vaddpd	(%rax), %xmm4, %xmm3	# MEM <vector(2) double> [(value_type &)vectp.1166_518], tmp451, vect__82.1168
	vmovupd	%xmm3, (%rax)	# vect__82.1168, MEM <vector(2) double> [(value_type &)vectp.1166_518]
	leaq	(%r9,%rdx), %rax	#, vectp.1152
# C/parallel-only-omp/simulation.h:457:         worker_buffers.ui[tid][p]   += c1 * mean_v;
	vmovddup	%xmm1, %xmm3	# mean_v, tmp464
	addq	%rbx, %rdx	# _165, vectp.1159
	vfmadd213pd	(%rax), %xmm4, %xmm3	# MEM <vector(2) double> [(value_type &)vectp.1152_281], tmp451, vect__88.1155
	vmovupd	%xmm3, (%rax)	# vect__88.1155, MEM <vector(2) double> [(value_type &)vectp.1152_281]
# C/parallel-only-omp/simulation.h:460:         v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r8,%rdi), %xmm3	# MEM[(double *)_402 + ivtmp.1239_412 * 1], _93
# C/parallel-only-omp/simulation.h:460:         v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmulsd	%xmm3, %xmm3, %xmm3	# _93, _93, tmp466
# C/parallel-only-omp/simulation.h:460:         v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd231sd	%xmm1, %xmm1, %xmm3	# mean_v, mean_v, _95
# C/parallel-only-omp/simulation.h:460:         v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r11,%rdi), %xmm1	# MEM[(double *)_399 + ivtmp.1239_412 * 1], _96
	addq	$8, %rdi	#, ivtmp.1239
# C/parallel-only-omp/simulation.h:460:         v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd132sd	%xmm1, %xmm3, %xmm1	# _96, _95, v_sqr
# C/parallel-only-omp/simulation.h:461:         energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vmulsd	%xmm10, %xmm1, %xmm1	# tmp509, v_sqr, tmp467
# C/parallel-only-omp/simulation.h:461:         energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vdivsd	%xmm7, %xmm1, %xmm1	# tmp508, tmp467, energy
# C/parallel-only-omp/simulation.h:463:         worker_buffers.meanei[tid][p]   += c1 * energy;
	vmovddup	%xmm1, %xmm1	# energy, tmp471
	vfmadd213pd	(%rdx), %xmm4, %xmm1	# MEM <vector(2) double> [(value_type &)vectp.1159_525], tmp451, vect__101.1162
	vmovupd	%xmm1, (%rdx)	# vect__101.1162, MEM <vector(2) double> [(value_type &)vectp.1159_525]
# C/parallel-only-omp/simulation.h:467:         vx_i[k] += e_x * FACTOR_I;
	vfmadd213sd	-8(%rcx), %xmm8, %xmm0	# MEM[(double *)_407], tmp513, _107
	vmovsd	%xmm0, -8(%rcx)	# _107, MEM[(double *)_407]
# C/parallel-only-omp/simulation.h:468:         x_i[k]  += vx_i[k] * DT_I;
	vfmadd213sd	-8(%rsi), %xmm9, %xmm0	# MEM[(double *)_410], tmp510, _110
	vmovsd	%xmm0, -8(%rsi)	# _110, MEM[(double *)_410]
	cmpq	%rdi, %r10	# ivtmp.1239, _394
	jne	.L192	#,
	movl	%r12d, %r8d	# _147, _147
	movl	%r13d, %r12d	# num_threads, num_threads
	movslq	16(%rsp), %r13	# %sfp,
.L193:
	movl	%r8d, 16(%rsp)	# _147, %sfp
	call	GOMP_barrier@PLT	#
# C/parallel-only-omp/simulation.h:471:     if (measurement_mode) {
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	movl	16(%rsp), %r8d	# %sfp, _147
	je	.L206	#,
	movl	$400, %eax	#, q.84_128
	xorl	%edx, %edx	# tt.85_129
	idivl	28(%rsp)	# %sfp
	cmpl	%edx, %r8d	# tt.85_129, _147
	jl	.L209	#,
.L194:
	movl	%r8d, %r9d	# _147, _147
	imull	%eax, %r9d	# q.84_128, _147
	addl	%r9d, %edx	# tmp481, _185
	leal	(%rax,%rdx), %ecx	#, tmp482
	cmpl	%ecx, %edx	# tmp482, _185
	jge	.L199	#,
	movslq	%edx, %r9	# _185, _446
	movslq	%r12d, %rdx	# num_threads, num_threads
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	192+worker_buffers(%rip), %r10	# MEM[(struct vector *)&worker_buffers + 192B].D.103980._M_impl.D.103319._M_start, _275
	movq	216+worker_buffers(%rip), %rdi	# MEM[(struct vector *)&worker_buffers + 216B].D.103980._M_impl.D.103319._M_start, _273
	movq	240+worker_buffers(%rip), %rsi	# MEM[(struct vector *)&worker_buffers + 240B].D.103980._M_impl.D.103319._M_start, _271
	movl	%eax, %eax	# q.84_128, q.84_128
	leaq	0(,%r9,8), %r8	#, ivtmp.1224
	imulq	$200, %r9, %rcx	#, _446, tmp489
	leaq	ui_xt(%rip), %rbx	#, tmp506
	leaq	meanei_xt(%rip), %r11	#, tmp514
	imulq	$400, %rdx, %rdx	#, num_threads, tmp487
	addq	%r13, %rcx	# t_index, tmp491
	leaq	counter_i_xt(%rip), %r13	#, tmp517
	addq	%r9, %rdx	# _446, tmp488
	addq	%rax, %r9	# q.84_128, tmp493
	salq	$3, %rdx	#, ivtmp.1225
	salq	$3, %rcx	#, ivtmp.1227
	salq	$3, %r9	#, _425
	.p2align 4
	.p2align 3
.L198:
# C/parallel-only-omp/simulation.h:475:             for (int t2 = 0; t2 < num_threads; t2++) {
	testl	%r12d, %r12d	# num_threads
	jle	.L200	#,
	movq	%r8, %rax	# ivtmp.1224, ivtmp.1214
# C/parallel-only-omp/simulation.h:474:             double c_i = 0.0, u_i = 0.0, m_i = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# m_i
# C/parallel-only-omp/simulation.h:474:             double c_i = 0.0, u_i = 0.0, m_i = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm1	#, u_i
# C/parallel-only-omp/simulation.h:474:             double c_i = 0.0, u_i = 0.0, m_i = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm2	#, c_i
	.p2align 4
	.p2align 3
.L197:
# C/parallel-only-omp/simulation.h:476:                 c_i += worker_buffers.counter_i[t2][p];
	vaddsd	(%r10,%rax), %xmm2, %xmm2	# MEM[(value_type &)_275 + ivtmp.1214_456 * 1], c_i, c_i
# C/parallel-only-omp/simulation.h:477:                 u_i += worker_buffers.ui[t2][p];
	vaddsd	(%rdi,%rax), %xmm1, %xmm1	# MEM[(value_type &)_273 + ivtmp.1214_456 * 1], u_i, u_i
# C/parallel-only-omp/simulation.h:478:                 m_i += worker_buffers.meanei[t2][p];
	vaddsd	(%rsi,%rax), %xmm0, %xmm0	# MEM[(value_type &)_271 + ivtmp.1214_456 * 1], m_i, m_i
# C/parallel-only-omp/simulation.h:475:             for (int t2 = 0; t2 < num_threads; t2++) {
	addq	$3200, %rax	#, ivtmp.1214
	cmpq	%rax, %rdx	# ivtmp.1214, ivtmp.1225
	jne	.L197	#,
.L196:
	addq	$8, %r8	#, ivtmp.1224
# C/parallel-only-omp/simulation.h:480:             counter_i_xt[p][t_index] += c_i;
	vaddsd	0(%r13,%rcx), %xmm2, %xmm2	# MEM[(double *)&counter_i_xt + ivtmp.1227_438 * 1], c_i, tmp496
# C/parallel-only-omp/simulation.h:481:             ui_xt[p][t_index]        += u_i;
	vaddsd	(%rbx,%rcx), %xmm1, %xmm1	# MEM[(double *)&ui_xt + ivtmp.1227_438 * 1], u_i, tmp500
# C/parallel-only-omp/simulation.h:482:             meanei_xt[p][t_index]    += m_i;
	vaddsd	(%r11,%rcx), %xmm0, %xmm0	# MEM[(double *)&meanei_xt + ivtmp.1227_438 * 1], m_i, tmp504
# C/parallel-only-omp/simulation.h:480:             counter_i_xt[p][t_index] += c_i;
	vmovsd	%xmm2, 0(%r13,%rcx)	# tmp496, MEM[(double *)&counter_i_xt + ivtmp.1227_438 * 1]
# C/parallel-only-omp/simulation.h:481:             ui_xt[p][t_index]        += u_i;
	vmovsd	%xmm1, (%rbx,%rcx)	# tmp500, MEM[(double *)&ui_xt + ivtmp.1227_438 * 1]
# C/parallel-only-omp/simulation.h:482:             meanei_xt[p][t_index]    += m_i;
	vmovsd	%xmm0, (%r11,%rcx)	# tmp504, MEM[(double *)&meanei_xt + ivtmp.1227_438 * 1]
	addq	$8, %rdx	#, ivtmp.1225
	addq	$1600, %rcx	#, ivtmp.1227
	cmpq	%r8, %r9	# ivtmp.1224, _425
	jne	.L198	#,
.L199:
# C/parallel-only-omp/simulation.h:485: }
	leaq	-40(%rbp), %rsp	#,
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	jmp	GOMP_barrier@PLT	#
.L208:
	.cfi_restore_state
	incl	%eax	# q.86_130
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%edx, %edx	# tt.87_131
	jmp	.L189	#
.L200:
# C/parallel-only-omp/simulation.h:474:             double c_i = 0.0, u_i = 0.0, m_i = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# m_i
# C/parallel-only-omp/simulation.h:474:             double c_i = 0.0, u_i = 0.0, m_i = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm1	#, u_i
# C/parallel-only-omp/simulation.h:474:             double c_i = 0.0, u_i = 0.0, m_i = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm2	#, c_i
	jmp	.L196	#
.L209:
	incl	%eax	# q.84_128
# C/parallel-only-omp/simulation.h:471:     if (measurement_mode) {
	xorl	%edx, %edx	# tt.85_129
	jmp	.L194	#
	.cfi_endproc
.LFE9879:
	.size	_Z20step4_move_ions_bodyiiii, .-_Z20step4_move_ions_bodyiiii
	.section	.rodata._Z18save_particle_datav.str1.1,"aMS",@progbits,1
.LC69:
	.string	"wb"
	.section	.rodata._Z18save_particle_datav.str1.8,"aMS",@progbits,1
	.align 8
.LC70:
	.string	">> eduPIC: data saved : %d electrons %d ions, %d cycles completed, time is %e [s]\n"
	.section	.text._Z18save_particle_datav,"axG",@progbits,_Z18save_particle_datav,comdat
	.p2align 4
	.weak	_Z18save_particle_datav
	.type	_Z18save_particle_datav, @function
_Z18save_particle_datav:
.LFB9920:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
# C/parallel-only-omp/io_manager.h:19:     f = fopen(fname,"wb");
	leaq	.LC69(%rip), %rsi	#, tmp113
# C/parallel-only-omp/io_manager.h:13: inline void save_particle_data(){
	subq	$120, %rsp	#,
	.cfi_def_cfa_offset 144
# C/parallel-only-omp/io_manager.h:13: inline void save_particle_data(){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp157
	movq	%rax, 104(%rsp)	# tmp157, D.132246
	xorl	%eax, %eax	# tmp157
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movl	$7235938, 24(%rsp)	#, MEM <char[1:12]> [(void *)&fname]
	leaq	16(%rsp), %rdi	#, tmp110
	movabsq	$3342080360130505072, %rax	#, tmp160
# C/parallel-only-omp/io_manager.h:22:     fwrite(&d,sizeof(double),1,f);
	leaq	8(%rsp), %rbp	#, tmp117
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, 16(%rsp)	# tmp160, MEM <char[1:12]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:19:     f = fopen(fname,"wb");
	call	fopen@PLT	#
# C/parallel-only-omp/io_manager.h:20:     fwrite(&Time,sizeof(double),1,f);
	movl	$1, %edx	#,
	movl	$8, %esi	#,
# C/parallel-only-omp/io_manager.h:19:     f = fopen(fname,"wb");
	movq	%rax, %rbx	# tmp152, tmp114
# C/parallel-only-omp/io_manager.h:20:     fwrite(&Time,sizeof(double),1,f);
	movq	%rax, %rcx	# tmp114,
	leaq	Time(%rip), %rdi	#, tmp115
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:22:     fwrite(&d,sizeof(double),1,f);
	movq	%rbx, %rcx	# tmp114,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	movq	%rbp, %rdi	# tmp117,
# C/parallel-only-omp/io_manager.h:21:     d = (double)(cycles_done);
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp161
	vcvtsi2sdl	cycles_done(%rip), %xmm1, %xmm0	# cycles_done, tmp161, tmp154
	vmovsd	%xmm0, 8(%rsp)	# tmp116, d
# C/parallel-only-omp/io_manager.h:22:     fwrite(&d,sizeof(double),1,f);
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:24:     fwrite(&d,sizeof(double),1,f);
	movq	%rbx, %rcx	# tmp114,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	movq	%rbp, %rdi	# tmp117,
# C/parallel-only-omp/io_manager.h:23:     d = (double)(N_e);
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp162
	vcvtsi2sdl	N_e(%rip), %xmm1, %xmm0	# N_e, tmp162, tmp155
	vmovsd	%xmm0, 8(%rsp)	# tmp118, d
# C/parallel-only-omp/io_manager.h:24:     fwrite(&d,sizeof(double),1,f);
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:25:     fwrite(x_e, sizeof(double),N_e,f);
	movslq	N_e(%rip), %rdx	# N_e, N_e
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	x_e(%rip), %rdi	#, tmp122
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:26:     fwrite(vx_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rdx	# N_e, N_e
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vx_e(%rip), %rdi	#, tmp125
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:27:     fwrite(vy_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rdx	# N_e, N_e
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vy_e(%rip), %rdi	#, tmp128
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:28:     fwrite(vz_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rdx	# N_e, N_e
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vz_e(%rip), %rdi	#, tmp131
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:30:     fwrite(&d,sizeof(double),1,f);
	movq	%rbx, %rcx	# tmp114,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	movq	%rbp, %rdi	# tmp117,
# C/parallel-only-omp/io_manager.h:29:     d = (double)(N_i);
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp163
	vcvtsi2sdl	N_i(%rip), %xmm1, %xmm0	# N_i, tmp163, tmp156
	vmovsd	%xmm0, 8(%rsp)	# tmp132, d
# C/parallel-only-omp/io_manager.h:30:     fwrite(&d,sizeof(double),1,f);
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:31:     fwrite(x_i, sizeof(double),N_i,f);
	movslq	N_i(%rip), %rdx	# N_i, N_i
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	x_i(%rip), %rdi	#, tmp136
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:32:     fwrite(vx_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rdx	# N_i, N_i
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vx_i(%rip), %rdi	#, tmp139
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:33:     fwrite(vy_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rdx	# N_i, N_i
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vy_i(%rip), %rdi	#, tmp142
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:34:     fwrite(vz_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rdx	# N_i, N_i
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vz_i(%rip), %rdi	#, tmp145
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:35:     fclose(f);
	movq	%rbx, %rdi	# tmp114,
	call	fclose@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	cycles_done(%rip), %r8d	# cycles_done,
	movl	N_i(%rip), %ecx	# N_i,
	leaq	.LC70(%rip), %rsi	#, tmp150
	movl	N_e(%rip), %edx	# N_e,
	movl	$2, %edi	#,
	movl	$1, %eax	#,
	vmovsd	Time(%rip), %xmm0	# Time,
	call	__printf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:37: }
	movq	104(%rsp), %rax	# D.132246, tmp158
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp158
	jne	.L214	#,
	addq	$120, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
.L214:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE9920:
	.size	_Z18save_particle_datav, .-_Z18save_particle_datav
	.section	.rodata._Z18load_particle_datav.str1.1,"aMS",@progbits,1
.LC71:
	.string	"rb"
	.section	.rodata._Z18load_particle_datav.str1.8,"aMS",@progbits,1
	.align 8
.LC72:
	.string	">> eduPIC: ERROR: No particle data file found, try running initial cycle using argument '0'\n"
	.align 8
.LC73:
	.string	">> eduPIC: data loaded : %d electrons %d ions, %d cycles completed before, time is %e [s]\n"
	.section	.text._Z18load_particle_datav,"axG",@progbits,_Z18load_particle_datav,comdat
	.p2align 4
	.weak	_Z18load_particle_datav
	.type	_Z18load_particle_datav, @function
_Z18load_particle_datav:
.LFB9921:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
# C/parallel-only-omp/io_manager.h:49:     f = fopen(fname,"rb");
	leaq	.LC71(%rip), %rsi	#, tmp111
# C/parallel-only-omp/io_manager.h:43: inline void load_particle_data(){
	subq	$120, %rsp	#,
	.cfi_def_cfa_offset 144
# C/parallel-only-omp/io_manager.h:43: inline void load_particle_data(){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp151
	movq	%rax, 104(%rsp)	# tmp151, D.132255
	xorl	%eax, %eax	# tmp151
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movl	$7235938, 24(%rsp)	#, MEM <char[1:12]> [(void *)&fname]
	movabsq	$3342080360130505072, %rax	#, tmp154
	leaq	16(%rsp), %rdi	#, tmp108
	movq	%rax, 16(%rsp)	# tmp154, MEM <char[1:12]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:49:     f = fopen(fname,"rb");
	call	fopen@PLT	#
# C/parallel-only-omp/io_manager.h:50:     if (f==NULL) {printf(">> eduPIC: ERROR: No particle data file found, try running initial cycle using argument '0'\n"); exit(0); }
	testq	%rax, %rax	# tmp112
	je	.L220	#,
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
# C/parallel-only-omp/io_manager.h:53:     cycles_done = int(d);
	vcvttsd2sil	8(%rsp), %eax	# d, tmp117
	movl	%eax, cycles_done(%rip)	# tmp117, cycles_done
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:212:     return __fread_alias (__ptr, __size, __n, __stream);
	call	fread@PLT	#
# C/parallel-only-omp/io_manager.h:55:     N_e = int(d);
	vcvttsd2sil	8(%rsp), %ecx	# d, _4
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	x_e(%rip), %rdi	#, tmp121
# C/parallel-only-omp/io_manager.h:55:     N_e = int(d);
	movl	%ecx, N_e(%rip)	# _4, N_e
# C/parallel-only-omp/io_manager.h:56:     fread(x_e, sizeof(double),N_e,f);
	movslq	%ecx, %rcx	# _4, _4
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	call	__fread_chk@PLT	#
# C/parallel-only-omp/io_manager.h:57:     fread(vx_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rcx	# N_e, N_e
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vx_e(%rip), %rdi	#, tmp124
	call	__fread_chk@PLT	#
# C/parallel-only-omp/io_manager.h:58:     fread(vy_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rcx	# N_e, N_e
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vy_e(%rip), %rdi	#, tmp127
	call	__fread_chk@PLT	#
# C/parallel-only-omp/io_manager.h:59:     fread(vz_e,sizeof(double),N_e,f);
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
# C/parallel-only-omp/io_manager.h:61:     N_i = int(d);
	vcvttsd2sil	8(%rsp), %ecx	# d, _13
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	x_i(%rip), %rdi	#, tmp134
# C/parallel-only-omp/io_manager.h:61:     N_i = int(d);
	movl	%ecx, N_i(%rip)	# _13, N_i
# C/parallel-only-omp/io_manager.h:62:     fread(x_i, sizeof(double),N_i,f);
	movslq	%ecx, %rcx	# _13, _13
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	call	__fread_chk@PLT	#
# C/parallel-only-omp/io_manager.h:63:     fread(vx_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rcx	# N_i, N_i
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vx_i(%rip), %rdi	#, tmp137
	call	__fread_chk@PLT	#
# C/parallel-only-omp/io_manager.h:64:     fread(vy_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rcx	# N_i, N_i
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vy_i(%rip), %rdi	#, tmp140
	call	__fread_chk@PLT	#
# C/parallel-only-omp/io_manager.h:65:     fread(vz_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rcx	# N_i, N_i
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vz_i(%rip), %rdi	#, tmp143
	call	__fread_chk@PLT	#
# C/parallel-only-omp/io_manager.h:66:     fclose(f);
	movq	%rbx, %rdi	# tmp112,
	call	fclose@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	cycles_done(%rip), %r8d	# cycles_done,
	movl	N_i(%rip), %ecx	# N_i,
	leaq	.LC73(%rip), %rsi	#, tmp148
	movl	N_e(%rip), %edx	# N_e,
	movl	$2, %edi	#,
	movl	$1, %eax	#,
	vmovsd	Time(%rip), %xmm0	# Time,
	call	__printf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:68: }
	movq	104(%rsp), %rax	# D.132255, tmp152
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp152
	jne	.L221	#,
	addq	$120, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
.L220:
	.cfi_restore_state
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$2, %edi	#,
	leaq	.LC72(%rip), %rsi	#, tmp113
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:50:     if (f==NULL) {printf(">> eduPIC: ERROR: No particle data file found, try running initial cycle using argument '0'\n"); exit(0); }
	xorl	%edi, %edi	#
	call	exit@PLT	#
.L221:
# C/parallel-only-omp/io_manager.h:68: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE9921:
	.size	_Z18load_particle_datav, .-_Z18load_particle_datav
	.section	.rodata._Z19check_and_save_infov.str1.1,"aMS",@progbits,1
.LC77:
	.string	"w"
.LC78:
	.string	"info.txt"
	.section	.rodata._Z19check_and_save_infov.str1.8,"aMS",@progbits,1
	.align 8
.LC79:
	.string	"########################## eduPIC simulation report ############################\n"
	.section	.rodata._Z19check_and_save_infov.str1.1
.LC80:
	.string	"Simulation parameters:\n"
	.section	.rodata._Z19check_and_save_infov.str1.8
	.align 8
.LC82:
	.string	"Gap distance                          = %12.3e [m]\n"
	.align 8
.LC83:
	.string	"# of grid divisions                   = %12d\n"
	.align 8
.LC84:
	.string	"Frequency                             = %12.3e [Hz]\n"
	.align 8
.LC85:
	.string	"# of time steps / period              = %12d\n"
	.align 8
.LC86:
	.string	"# of electron / ion time steps        = %12d\n"
	.align 8
.LC88:
	.string	"Voltage amplitude                     = %12.3e [V]\n"
	.align 8
.LC89:
	.string	"Pressure (Ar)                         = %12.3e [Pa]\n"
	.align 8
.LC91:
	.string	"Temperature                           = %12.3e [K]\n"
	.align 8
.LC93:
	.string	"Superparticle weight                  = %12.3e\n"
	.align 8
.LC94:
	.string	"# of simulation cycles in this run    = %12d\n"
	.align 8
.LC95:
	.string	"--------------------------------------------------------------------------------\n"
	.section	.rodata._Z19check_and_save_infov.str1.1
.LC96:
	.string	"Plasma characteristics:\n"
	.section	.rodata._Z19check_and_save_infov.str1.8
	.align 8
.LC97:
	.string	"Electron density @ center             = %12.3e [m^{-3}]\n"
	.align 8
.LC98:
	.string	"Plasma frequency @ center             = %12.3e [rad/s]\n"
	.align 8
.LC99:
	.string	"Debye length @ center                 = %12.3e [m]\n"
	.align 8
.LC100:
	.string	"Electron collision frequency          = %12.3e [1/s]\n"
	.align 8
.LC101:
	.string	"Ion collision frequency               = %12.3e [1/s]\n"
	.align 8
.LC102:
	.string	"Stability and accuracy conditions:\n"
	.align 8
.LC103:
	.string	"Plasma frequency @ center * DT_E      = %12.3f (OK if less than 0.20)\n"
	.align 8
.LC105:
	.string	"DX / Debye length @ center            = %12.3f (OK if less than 1.00)\n"
	.align 8
.LC107:
	.string	"Max. electron coll. frequency * DT_E  = %12.3f (OK if less than 0.05)\n"
	.align 8
.LC108:
	.string	"Max. ion coll. frequency * DT_I       = %12.3f (OK if less than 0.05)\n"
	.align 8
.LC109:
	.string	"** STABILITY AND ACCURACY CONDITION(S) VIOLATED - REFINE SIMULATION SETTINGS! **\n"
	.align 8
.LC110:
	.string	">> eduPIC: ERROR: STABILITY AND ACCURACY CONDITION(S) VIOLATED!\n"
	.align 8
.LC111:
	.string	">> eduPIC: for details see 'info.txt' and refine simulation settings!\n"
	.align 8
.LC113:
	.string	"Max e- energy for CFL condition       = %12.3f [eV]\n"
	.align 8
.LC114:
	.string	"Check EEPF to ensure that CFL is fulfilled for the majority of the electrons!\n"
	.align 8
.LC115:
	.string	">> eduPIC: saving diagnostics data\n"
	.section	.rodata._Z19check_and_save_infov.str1.1
.LC116:
	.string	"density.dat"
.LC117:
	.string	"%8.5f  %12e  %12e\n"
.LC118:
	.string	"eepf.dat"
.LC119:
	.string	"%e  %e\n"
.LC120:
	.string	"ifed.dat"
.LC121:
	.string	"%6.2f %10.6f %10.6f\n"
.LC128:
	.string	"%e  "
.LC129:
	.string	"\n"
	.section	.rodata._Z19check_and_save_infov.str1.8
	.align 8
.LC130:
	.string	"Particle characteristics at the electrodes:\n"
	.align 8
.LC133:
	.string	"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n"
	.align 8
.LC134:
	.string	"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n"
	.align 8
.LC135:
	.string	"Mean ion energy at powered electrode  = %12.3e [eV]\n"
	.align 8
.LC136:
	.string	"Mean ion energy at grounded electrode = %12.3e [eV]\n"
	.align 8
.LC137:
	.string	"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n"
	.align 8
.LC138:
	.string	"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n"
	.align 8
.LC140:
	.string	"Absorbed power calculated as <j*E>:\n"
	.align 8
.LC141:
	.string	"Electron power density (average)      = %12.3e [W m^{-3}]\n"
	.align 8
.LC142:
	.string	"Ion power density (average)           = %12.3e [W m^{-3}]\n"
	.align 8
.LC143:
	.string	"Total power density(average)          = %12.3e [W m^{-3}]\n"
	.section	.text._Z19check_and_save_infov,"axG",@progbits,_Z19check_and_save_infov,comdat
	.p2align 4
	.weak	_Z19check_and_save_infov
	.type	_Z19check_and_save_infov, @function
_Z19check_and_save_infov:
.LFB9928:
	.cfi_startproc
	endbr64	
	pushq	%r13	#
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
# C/parallel-only-omp/io_manager.h:234:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // Gęstość elektronów w środku szczeliny
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp1069
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp483
# C/parallel-only-omp/io_manager.h:228: inline void check_and_save_info(void){
	leaq	16(%rsp), %r13	#,
	.cfi_def_cfa 13, 0
	andq	$-64, %rsp	#,
	pushq	-8(%r13)	#
	pushq	%rbp	#
	movq	%rsp, %rbp	#,
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15	#
	pushq	%r14	#
	pushq	%r13	#
	.cfi_escape 0xf,0x3,0x76,0x68,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	pushq	%r12	#
	pushq	%rbx	#
	subq	$584, %rsp	#,
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	.cfi_escape 0x10,0x3,0x2,0x76,0x58
# C/parallel-only-omp/io_manager.h:234:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // Gęstość elektronów w środku szczeliny
	vmovsd	1600+cumul_e_density(%rip), %xmm0	# cumul_e_density[200], cumul_e_density[200]
# C/parallel-only-omp/io_manager.h:228: inline void check_and_save_info(void){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp944
	movq	%rax, -56(%rbp)	# tmp944, D.132814
	xorl	%eax, %eax	# tmp944
# C/parallel-only-omp/io_manager.h:234:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // Gęstość elektronów w środku szczeliny
	vcvtsi2sdl	no_of_cycles(%rip), %xmm4, %xmm1	# no_of_cycles, tmp1069, tmp916
# C/parallel-only-omp/io_manager.h:234:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // Gęstość elektronów w środku szczeliny
	vdivsd	%xmm1, %xmm0, %xmm0	# _3, cumul_e_density[200], tmp477
# C/parallel-only-omp/io_manager.h:234:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // Gęstość elektronów w środku szczeliny
	vdivsd	.LC74(%rip), %xmm0, %xmm4	#, tmp477, density
# C/parallel-only-omp/io_manager.h:235:     plas_freq  = E_CHARGE * sqrt(density / EPSILON0 / E_MASS);                       // Częstość plazmowa elektronów w środku szczeliny
	vdivsd	.LC75(%rip), %xmm4, %xmm0	#, density, tmp480
# C/parallel-only-omp/io_manager.h:234:     density    = cumul_e_density[N_G / 2] / (double)(no_of_cycles) / (double)(N_T);  // Gęstość elektronów w środku szczeliny
	vmovsd	%xmm4, -240(%rbp)	# density, %sfp
# C/parallel-only-omp/io_manager.h:235:     plas_freq  = E_CHARGE * sqrt(density / EPSILON0 / E_MASS);                       // Częstość plazmowa elektronów w środku szczeliny
	vmovsd	.LC51(%rip), %xmm4	#, tmp851
	vdivsd	%xmm4, %xmm0, %xmm0	# tmp851, tmp480, _6
	vucomisd	%xmm0, %xmm2	# _6, tmp483
	ja	.L338	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _6, _7
.L225:
# C/parallel-only-omp/io_manager.h:238:     sim_time   = (double)(no_of_cycles) / FREQUENCY;                                 // Całkowity czas symulowany
	vdivsd	.LC76(%rip), %xmm1, %xmm1	#, _3, sim_time
# C/parallel-only-omp/io_manager.h:235:     plas_freq  = E_CHARGE * sqrt(density / EPSILON0 / E_MASS);                       // Częstość plazmowa elektronów w środku szczeliny
	vmovsd	.LC50(%rip), %xmm2	#, tmp850
	vmulsd	%xmm2, %xmm0, %xmm6	# tmp850, _7, plas_freq
	vmovsd	%xmm6, -304(%rbp)	# plas_freq, %sfp
# C/parallel-only-omp/io_manager.h:239:     ecoll_freq = (double)(N_e_coll) / sim_time / (double)(N_e);                      // Średnia częstość zderzeń elektronów
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp1073
	vcvtusi2sdq	N_e_coll(%rip), %xmm6, %xmm0	# N_e_coll, tmp1073, tmp917
# C/parallel-only-omp/io_manager.h:239:     ecoll_freq = (double)(N_e_coll) / sim_time / (double)(N_e);                      // Średnia częstość zderzeń elektronów
	vcvtsi2sdl	N_e(%rip), %xmm6, %xmm3	# N_e, tmp1074, tmp918
# C/parallel-only-omp/io_manager.h:239:     ecoll_freq = (double)(N_e_coll) / sim_time / (double)(N_e);                      // Średnia częstość zderzeń elektronów
	vdivsd	%xmm1, %xmm0, %xmm0	# sim_time, tmp486, tmp487
# C/parallel-only-omp/io_manager.h:239:     ecoll_freq = (double)(N_e_coll) / sim_time / (double)(N_e);                      // Średnia częstość zderzeń elektronów
	vdivsd	%xmm3, %xmm0, %xmm3	# tmp488, tmp487, ecoll_freq
# C/parallel-only-omp/io_manager.h:240:     icoll_freq = (double)(N_i_coll) / sim_time / (double)(N_i);                      // Średnia częstość zderzeń jonów
	vcvtusi2sdq	N_i_coll(%rip), %xmm6, %xmm0	# N_i_coll, tmp1076, tmp919
# C/parallel-only-omp/io_manager.h:239:     ecoll_freq = (double)(N_e_coll) / sim_time / (double)(N_e);                      // Średnia częstość zderzeń elektronów
	vmovq	%xmm3, %r12	# ecoll_freq, ecoll_freq
# C/parallel-only-omp/io_manager.h:240:     icoll_freq = (double)(N_i_coll) / sim_time / (double)(N_i);                      // Średnia częstość zderzeń jonów
	vdivsd	%xmm1, %xmm0, %xmm0	# sim_time, tmp489, tmp490
# C/parallel-only-omp/io_manager.h:240:     icoll_freq = (double)(N_i_coll) / sim_time / (double)(N_i);                      // Średnia częstość zderzeń jonów
	vcvtsi2sdl	N_i(%rip), %xmm6, %xmm1	# N_i, tmp1077, tmp920
# C/parallel-only-omp/io_manager.h:240:     icoll_freq = (double)(N_i_coll) / sim_time / (double)(N_i);                      // Średnia częstość zderzeń jonów
	vdivsd	%xmm1, %xmm0, %xmm3	# tmp491, tmp490, icoll_freq
# C/parallel-only-omp/io_manager.h:236:     meane      = mean_energy_accu_center / (double)(mean_energy_counter_center);     // Średnia energia elektronów w centrum
	vcvtusi2sdq	mean_energy_counter_center(%rip), %xmm6, %xmm1	# mean_energy_counter_center, tmp1079, tmp921
# C/parallel-only-omp/io_manager.h:236:     meane      = mean_energy_accu_center / (double)(mean_energy_counter_center);     // Średnia energia elektronów w centrum
	vmovsd	mean_energy_accu_center(%rip), %xmm0	# mean_energy_accu_center, mean_energy_accu_center
# C/parallel-only-omp/io_manager.h:240:     icoll_freq = (double)(N_i_coll) / sim_time / (double)(N_i);                      // Średnia częstość zderzeń jonów
	vmovq	%xmm3, %rbx	# icoll_freq, icoll_freq
# C/parallel-only-omp/io_manager.h:236:     meane      = mean_energy_accu_center / (double)(mean_energy_counter_center);     // Średnia energia elektronów w centrum
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp492, mean_energy_accu_center, meane
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp502
# C/parallel-only-omp/io_manager.h:237:     kT         = 2.0 * meane * EV_TO_J / 3.0;                                        // Przybliżona temperatura k*T_e w centrum
	vaddsd	%xmm0, %xmm0, %xmm0	# meane, meane, tmp495
# C/parallel-only-omp/io_manager.h:237:     kT         = 2.0 * meane * EV_TO_J / 3.0;                                        // Przybliżona temperatura k*T_e w centrum
	vmulsd	%xmm2, %xmm0, %xmm0	# tmp850, tmp495, tmp496
# C/parallel-only-omp/io_manager.h:237:     kT         = 2.0 * meane * EV_TO_J / 3.0;                                        // Przybliżona temperatura k*T_e w centrum
	vdivsd	.LC16(%rip), %xmm0, %xmm0	#, tmp496, kT
# C/parallel-only-omp/io_manager.h:241:     debye_length = sqrt(EPSILON0 * kT / density) / E_CHARGE;                         // Promień Debye'a elektronów w centrum
	vmulsd	.LC75(%rip), %xmm0, %xmm0	#, kT, tmp500
# C/parallel-only-omp/io_manager.h:241:     debye_length = sqrt(EPSILON0 * kT / density) / E_CHARGE;                         // Promień Debye'a elektronów w centrum
	vdivsd	-240(%rbp), %xmm0, %xmm0	# %sfp, tmp500, _26
	vucomisd	%xmm0, %xmm1	# _26, tmp502
	ja	.L339	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _26, _27
.L228:
	vmovapd	%zmm8, -624(%rbp)	# vect__291.1367, %sfp
# C/parallel-only-omp/io_manager.h:243:     f = fopen("info.txt","w");
	leaq	.LC77(%rip), %rsi	#,
	leaq	.LC78(%rip), %rdi	#, tmp505
	vmovapd	%zmm9, -560(%rbp)	# vect__345.1344, %sfp
	vmovapd	%zmm7, -496(%rbp)	# vect__376.1333, %sfp
# C/parallel-only-omp/io_manager.h:241:     debye_length = sqrt(EPSILON0 * kT / density) / E_CHARGE;                         // Promień Debye'a elektronów w centrum
	vdivsd	%xmm2, %xmm0, %xmm7	# tmp850, _27, debye_length
	vmovsd	%xmm7, -368(%rbp)	# debye_length, %sfp
# C/parallel-only-omp/io_manager.h:243:     f = fopen("info.txt","w");
	vzeroupper
	call	fopen@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	leaq	.LC79(%rip), %rdx	#, tmp507
	movl	$2, %esi	#,
# C/parallel-only-omp/io_manager.h:243:     f = fopen("info.txt","w");
	movq	%rax, %r14	# tmp897, _91
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%rax, %rdi	# _91,
# C/parallel-only-omp/io_manager.h:243:     f = fopen("info.txt","w");
	movq	%rax, -432(%rbp)	# _91, %sfp
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC80(%rip), %rdx	#, tmp508
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC82(%rip), %rdx	#, tmp510
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC81(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	movl	$400, %ecx	#,
	leaq	.LC83(%rip), %rdx	#, tmp511
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC84(%rip), %rdx	#, tmp513
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC76(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	movl	$4000, %ecx	#,
	leaq	.LC85(%rip), %rdx	#, tmp514
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	movl	$20, %ecx	#,
	leaq	.LC86(%rip), %rdx	#, tmp515
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC88(%rip), %rdx	#, tmp517
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC87(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	leaq	.LC89(%rip), %rdx	#, tmp519
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC15(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	leaq	.LC91(%rip), %rdx	#, tmp521
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC90(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	leaq	.LC93(%rip), %rdx	#, tmp523
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	.LC92(%rip), %xmm0	#,
	call	__fprintf_chk@PLT	#
	movl	no_of_cycles(%rip), %ecx	# no_of_cycles,
	leaq	.LC94(%rip), %rdx	#, tmp525
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC95(%rip), %rdx	#,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC96(%rip), %rdx	#, tmp527
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC97(%rip), %rdx	#, tmp528
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	-240(%rbp), %xmm0	# %sfp,
	call	__fprintf_chk@PLT	#
	leaq	.LC98(%rip), %rdx	#, tmp529
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	-304(%rbp), %xmm0	# %sfp,
	call	__fprintf_chk@PLT	#
	leaq	.LC99(%rip), %rdx	#, tmp530
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	-368(%rbp), %xmm0	# %sfp,
	call	__fprintf_chk@PLT	#
	vmovq	%r12, %xmm0	# ecoll_freq,
	leaq	.LC100(%rip), %rdx	#, tmp531
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	call	__fprintf_chk@PLT	#
	vmovq	%rbx, %xmm0	# icoll_freq,
	leaq	.LC101(%rip), %rdx	#, tmp532
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
	call	__fprintf_chk@PLT	#
	leaq	.LC95(%rip), %rdx	#,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC102(%rip), %rdx	#, tmp534
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC103(%rip), %rdx	#, tmp536
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:266:     c = plas_freq * DT_E;
	vmovsd	.LC52(%rip), %xmm6	#, tmp1082
	vmulsd	-304(%rbp), %xmm6, %xmm1	# %sfp, tmp1082, c
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm1, %xmm1, %xmm0	# c,
	vmovsd	%xmm1, -304(%rbp)	# c, %sfp
	call	__fprintf_chk@PLT	#
	leaq	.LC105(%rip), %rdx	#, tmp538
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _91,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:269:     c = DX / debye_length;
	vmovsd	.LC104(%rip), %xmm4	#, tmp1084
# C/parallel-only-omp/io_manager.h:271:     if (c > 1.0) {conditions_OK = false;}
	xorl	%ebx, %ebx	# conditions_OK
# C/parallel-only-omp/io_manager.h:269:     c = DX / debye_length;
	vdivsd	-368(%rbp), %xmm4, %xmm0	# %sfp, tmp1084, c
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm0, -240(%rbp)	# c, %sfp
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:271:     if (c > 1.0) {conditions_OK = false;}
	vmovsd	-240(%rbp), %xmm0	# %sfp, c
	vmovapd	-496(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovapd	-560(%rbp), %zmm9	# %sfp, vect__345.1344
	vcomisd	.LC10(%rip), %xmm0	#, c
	vmovsd	.LC50(%rip), %xmm2	#, tmp850
	vmovapd	-624(%rbp), %zmm8	# %sfp, vect__291.1367
	vmovsd	.LC51(%rip), %xmm4	#, tmp851
	ja	.L229	#,
# C/parallel-only-omp/io_manager.h:268:     if (c > 0.2) {conditions_OK = false;}
	vmovsd	-304(%rbp), %xmm1	# %sfp, c
	vcomisd	.LC106(%rip), %xmm1	#, c
	setbe	%bl	#, conditions_OK
.L229:
# C/parallel-only-omp/io_manager.h:271:     if (c > 1.0) {conditions_OK = false;}
	xorl	%r12d, %r12d	# ivtmp.1696
	leaq	sigma_tot_e(%rip), %r13	#, tmp849
# C/parallel-only-omp/cross_sections.h:110:     nu_max = 0;
	vxorpd	%xmm1, %xmm1, %xmm1	# nu_max
	vmovsd	.LC1(%rip), %xmm3	#, tmp865
	vmovsd	%xmm1, %xmm1, %xmm5	#, tmp549
	.p2align 4
	.p2align 3
.L234:
# C/parallel-only-omp/cross_sections.h:112:         e  = i * DE_CS;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp1086
	vcvtsi2sdl	%r12d, %xmm6, %xmm0	# ivtmp.1696, tmp1086, tmp922
# C/parallel-only-omp/cross_sections.h:112:         e  = i * DE_CS;
	vmulsd	%xmm3, %xmm0, %xmm0	# tmp865, tmp542, e
# C/parallel-only-omp/cross_sections.h:113:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vaddsd	%xmm0, %xmm0, %xmm0	# e, e, tmp545
# C/parallel-only-omp/cross_sections.h:113:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vmulsd	%xmm2, %xmm0, %xmm0	# tmp850, tmp545, tmp546
# C/parallel-only-omp/cross_sections.h:113:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vdivsd	%xmm4, %xmm0, %xmm0	# tmp851, tmp546, _164
	vucomisd	%xmm0, %xmm5	# _164, tmp549
	ja	.L340	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _164, v
.L232:
# C/parallel-only-omp/cross_sections.h:114:         nu = v * sigma_tot_e[i];
	vmulsd	0(%r13,%r12,8), %xmm0, %xmm0	# MEM[(double *)&sigma_tot_e + ivtmp.1696_938 * 8], v, nu
# C/parallel-only-omp/cross_sections.h:111:     for(i=0; i<CS_RANGES; i++){
	incq	%r12	# ivtmp.1696
# C/parallel-only-omp/cross_sections.h:115:         if (nu > nu_max) {nu_max = nu;}
	vmaxsd	%xmm1, %xmm0, %xmm1	# nu_max, nu, nu_max
# C/parallel-only-omp/cross_sections.h:111:     for(i=0; i<CS_RANGES; i++){
	cmpq	$1000000, %r12	#, ivtmp.1696
	jne	.L234	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	-432(%rbp), %rdi	# %sfp,
	vmovapd	%zmm8, -496(%rbp)	# vect__291.1367, %sfp
	leaq	.LC107(%rip), %rdx	#, tmp552
	movl	$2, %esi	#,
	vmovapd	%zmm9, -368(%rbp)	# vect__345.1344, %sfp
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:272:     c = max_electron_coll_freq() * DT_E;
	vmulsd	.LC52(%rip), %xmm1, %xmm1	#, nu_max, c
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm1, %xmm1, %xmm0	# c,
	vmovapd	%zmm7, -304(%rbp)	# vect__376.1333, %sfp
	vmovsd	%xmm1, -240(%rbp)	# c, %sfp
	leaq	sigma_tot_i(%rip), %r13	#, tmp854
	vzeroupper
	call	__fprintf_chk@PLT	#
	vmovapd	-496(%rbp), %zmm8	# %sfp, vect__291.1367
	vmovapd	-368(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-304(%rbp), %zmm7	# %sfp, vect__376.1333
# C/parallel-only-omp/io_manager.h:274:     if (c > 0.05) {conditions_OK = false;}
	xorl	%eax, %eax	#
	vmovsd	-240(%rbp), %xmm1	# %sfp, c
	vucomisd	.LC19(%rip), %xmm1	#, c
	vmovsd	.LC53(%rip), %xmm5	#, tmp855
	cmova	%eax, %ebx	# conditions_OK,, tmp885, conditions_OK
	xorl	%r12d, %r12d	# ivtmp.1689
# C/parallel-only-omp/cross_sections.h:130:     nu_max = 0;
	vxorpd	%xmm1, %xmm1, %xmm1	# nu_max
	vmovsd	.LC1(%rip), %xmm3	#, tmp865
	vmovsd	%xmm1, %xmm1, %xmm4	#, tmp561
	vmovsd	.LC50(%rip), %xmm2	#, tmp850
	.p2align 4
	.p2align 3
.L240:
# C/parallel-only-omp/cross_sections.h:132:         e  = i * DE_CS;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp1087
	vcvtsi2sdl	%r12d, %xmm6, %xmm0	# ivtmp.1689, tmp1087, tmp923
# C/parallel-only-omp/cross_sections.h:132:         e  = i * DE_CS;
	vmulsd	%xmm3, %xmm0, %xmm0	# tmp865, tmp554, e
# C/parallel-only-omp/cross_sections.h:133:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vaddsd	%xmm0, %xmm0, %xmm0	# e, e, tmp557
# C/parallel-only-omp/cross_sections.h:133:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vmulsd	%xmm2, %xmm0, %xmm0	# tmp850, tmp557, tmp558
# C/parallel-only-omp/cross_sections.h:133:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vdivsd	%xmm5, %xmm0, %xmm0	# tmp855, tmp558, _177
	vucomisd	%xmm0, %xmm4	# _177, tmp561
	ja	.L341	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _177, g
.L238:
# C/parallel-only-omp/cross_sections.h:134:         nu = g * sigma_tot_i[i];
	vmulsd	0(%r13,%r12,8), %xmm0, %xmm0	# MEM[(double *)&sigma_tot_i + ivtmp.1689_930 * 8], g, nu
# C/parallel-only-omp/cross_sections.h:131:     for(i=0; i<CS_RANGES; i++){
	incq	%r12	# ivtmp.1689
# C/parallel-only-omp/cross_sections.h:135:         if (nu > nu_max) nu_max = nu;
	vmaxsd	%xmm1, %xmm0, %xmm1	# nu_max, nu, nu_max
# C/parallel-only-omp/cross_sections.h:131:     for(i=0; i<CS_RANGES; i++){
	cmpq	$1000000, %r12	#, ivtmp.1689
	jne	.L240	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	-432(%rbp), %rdi	# %sfp,
	vmovapd	%zmm8, -496(%rbp)	# vect__291.1367, %sfp
	leaq	.LC108(%rip), %rdx	#, tmp564
	movl	$2, %esi	#,
	vmovapd	%zmm9, -368(%rbp)	# vect__345.1344, %sfp
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:275:     c = max_ion_coll_freq() * DT_I;
	vmulsd	.LC54(%rip), %xmm1, %xmm1	#, nu_max, c
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm1, %xmm1, %xmm0	# c,
	vmovapd	%zmm7, -304(%rbp)	# vect__376.1333, %sfp
	vmovsd	%xmm1, -240(%rbp)	# c, %sfp
	vzeroupper
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:277:     if (c > 0.05) {conditions_OK = false;}
	vmovsd	-240(%rbp), %xmm1	# %sfp, c
	vcomisd	.LC19(%rip), %xmm1	#, c
	ja	.L241	#,
# C/parallel-only-omp/io_manager.h:278:     if (conditions_OK == false){
	testb	%bl, %bl	# conditions_OK
	vmovapd	-304(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovapd	-368(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-496(%rbp), %zmm8	# %sfp, vect__291.1367
	jne	.L242	#,
	vzeroupper
.L241:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	-432(%rbp), %rbx	# %sfp, _91
	leaq	.LC95(%rip), %rdx	#,
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
	movq	%rbx, %rdi	# _91,
	call	__fprintf_chk@PLT	#
	leaq	.LC109(%rip), %rdx	#, tmp567
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC95(%rip), %rdx	#,
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:282:         fclose(f);
	movq	%rbx, %rdi	# _91,
	call	fclose@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	xorl	%eax, %eax	#
	leaq	.LC110(%rip), %rsi	#, tmp569
	movl	$2, %edi	#,
	call	__printf_chk@PLT	#
	movq	-56(%rbp), %rax	# D.132814, tmp945
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp945
	jne	.L345	#,
# C/parallel-only-omp/io_manager.h:330: }
	addq	$584, %rsp	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC111(%rip), %rsi	#, tmp571
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
# C/parallel-only-omp/io_manager.h:330: }
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	.cfi_remember_state
	.cfi_def_cfa 13, 0
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	leaq	-16(%r13), %rsp	#,
	.cfi_def_cfa 7, 16
	popq	%r13	#
	.cfi_def_cfa_offset 8
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	jmp	__printf_chk@PLT	#
.L242:
	.cfi_restore_state
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	-432(%rbp), %rbx	# %sfp, _91
	vmovapd	%zmm7, -304(%rbp)	# vect__376.1333, %sfp
	leaq	.LC113(%rip), %rdx	#, tmp573
	movl	$2, %esi	#,
	vmovapd	%zmm8, -496(%rbp)	# vect__291.1367, %sfp
	movl	$1, %eax	#,
	vmovsd	.LC112(%rip), %xmm0	#,
	leaq	cumul_i_density(%rip), %r13	#, tmp857
	vmovapd	%zmm9, -368(%rbp)	# vect__345.1344, %sfp
	leaq	cumul_e_density(%rip), %r12	#, tmp841
	vzeroupper
# C/parallel-only-omp/io_manager.h:80:     c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
	xorl	%r14d, %r14d	# ivtmp.1680
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%rbx, %rdi	# _91,
	call	__fprintf_chk@PLT	#
	movq	%rbx, %rdi	# _91,
	leaq	.LC114(%rip), %rdx	#, tmp574
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	leaq	.LC95(%rip), %rdx	#,
	movq	%rbx, %rdi	# _91,
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
	leaq	.LC117(%rip), %rbx	#, tmp856
	call	__fprintf_chk@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC115(%rip), %rsi	#, tmp576
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:79:     f = fopen("density.dat","w");
	leaq	.LC77(%rip), %rsi	#,
	leaq	.LC116(%rip), %rdi	#, tmp578
	call	fopen@PLT	#
# C/parallel-only-omp/io_manager.h:80:     c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1088
	vcvtsi2sdl	no_of_cycles(%rip), %xmm7, %xmm0	# no_of_cycles, tmp1088, tmp924
# C/parallel-only-omp/io_manager.h:80:     c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
	vmovsd	.LC10(%rip), %xmm7	#, tmp1089
# C/parallel-only-omp/io_manager.h:79:     f = fopen("density.dat","w");
	movq	%rax, %r15	# tmp900, _277
# C/parallel-only-omp/io_manager.h:80:     c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
	vdivsd	%xmm0, %xmm7, %xmm0	# tmp580, tmp1089, tmp581
# C/parallel-only-omp/io_manager.h:80:     c = 1.0 / (double)(no_of_cycles) / (double)(N_T);
	vdivsd	.LC74(%rip), %xmm0, %xmm7	#, tmp581, c
	vmovsd	%xmm7, -240(%rbp)	# c, %sfp
	vzeroupper
	.p2align 4
	.p2align 3
.L244:
# C/parallel-only-omp/io_manager.h:82:         fprintf(f,"%8.5f  %12e  %12e\n",m * DX, cumul_e_density[m] * c, cumul_i_density[m] * c);
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1091
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%rbx, %rdx	# tmp856,
# C/parallel-only-omp/io_manager.h:82:         fprintf(f,"%8.5f  %12e  %12e\n",m * DX, cumul_e_density[m] * c, cumul_i_density[m] * c);
	vcvtsi2sdl	%r14d, %xmm7, %xmm0	# ivtmp.1680, tmp1091, tmp925
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movl	$2, %esi	#,
	vmovsd	-240(%rbp), %xmm7	# %sfp, c
	movq	%r15, %rdi	# _277,
	vmulsd	0(%r13,%r14,8), %xmm7, %xmm2	# MEM[(double *)&cumul_i_density + ivtmp.1680_924 * 8], c,
	vmulsd	(%r12,%r14,8), %xmm7, %xmm1	# MEM[(double *)&cumul_e_density + ivtmp.1680_924 * 8], c,
	movl	$3, %eax	#,
# C/parallel-only-omp/io_manager.h:81:     for(m=0; m<N_G; m++){
	incq	%r14	# ivtmp.1680
# C/parallel-only-omp/io_manager.h:82:         fprintf(f,"%8.5f  %12e  %12e\n",m * DX, cumul_e_density[m] * c, cumul_i_density[m] * c);
	vmulsd	.LC104(%rip), %xmm0, %xmm0	#, tmp588, tmp589
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:81:     for(m=0; m<N_G; m++){
	cmpq	$400, %r14	#, ivtmp.1680
	jne	.L244	#,
# C/parallel-only-omp/io_manager.h:84:     fclose(f);
	vmovapd	-304(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovapd	-368(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-496(%rbp), %zmm8	# %sfp, vect__291.1367
	movq	%r15, %rdi	# _277,
	leaq	eepf(%rip), %r13	#, tmp861
	vmovapd	%zmm7, -560(%rbp)	# vect__376.1333, %sfp
	vmovapd	%zmm9, -304(%rbp)	# vect__345.1344, %sfp
	vmovapd	%zmm8, -240(%rbp)	# vect__291.1367, %sfp
	vzeroupper
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:97:     h = 0.0;
	vmovapd	-560(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovapd	-304(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-240(%rbp), %zmm8	# %sfp, vect__291.1367
	movq	%r13, %rax	# tmp861, ivtmp.1675
	leaq	16000(%r13), %rdx	#, _917
	vxorpd	%xmm0, %xmm0, %xmm0	# h
.L245:
	vaddsd	(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_224], 64, 0>, h, stmp_h_263.1395
	addq	$64, %rax	#, ivtmp.1675
	vaddsd	-56(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_224], 64, 64>, stmp_h_263.1395, stmp_h_263.1395
	vaddsd	-48(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_224], 64, 128>, stmp_h_263.1395, stmp_h_263.1395
	vaddsd	-40(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_224], 64, 192>, stmp_h_263.1395, stmp_h_263.1395
	vaddsd	-32(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_224], 64, 256>, stmp_h_263.1395, stmp_h_263.1395
	vaddsd	-24(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_224], 64, 320>, stmp_h_263.1395, stmp_h_263.1395
# C/parallel-only-omp/io_manager.h:98:     for (i=0; i<N_EEPF; i++) {h += eepf[i];}
	vaddsd	-16(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_224], 64, 384>, stmp_h_263.1395, stmp_h_263.1395
	vaddsd	-8(%rax), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_224], 64, 448>, stmp_h_263.1395, h
	cmpq	%rdx, %rax	# _917, ivtmp.1675
	jne	.L245	#,
	vmovapd	%zmm8, -496(%rbp)	# vect__291.1367, %sfp
# C/parallel-only-omp/io_manager.h:100:     f = fopen("eepf.dat","w");
	leaq	.LC77(%rip), %rsi	#,
	leaq	.LC118(%rip), %rdi	#, tmp595
# C/parallel-only-omp/io_manager.h:99:     h *= DE_EEPF;
	vmulsd	.LC19(%rip), %xmm0, %xmm4	#, h, h
	vmovapd	%zmm9, -368(%rbp)	# vect__345.1344, %sfp
	vmovsd	%xmm4, -240(%rbp)	# h, %sfp
	leaq	.LC119(%rip), %r12	#, tmp858
	vmovapd	%zmm7, -304(%rbp)	# vect__376.1333, %sfp
# C/parallel-only-omp/io_manager.h:100:     f = fopen("eepf.dat","w");
	vzeroupper
	call	fopen@PLT	#
	xorl	%r14d, %r14d	# ivtmp.1667
	movq	%rax, %rbx	# tmp901, _267
	vzeroupper
	.p2align 4
	.p2align 3
.L250:
# C/parallel-only-omp/io_manager.h:102:         energy = (i + 0.5) * DE_EEPF;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1095
# C/parallel-only-omp/io_manager.h:103:         fprintf(f,"%e  %e\n", energy, eepf[i] / h / sqrt(energy));
	vmovsd	0(%r13,%r14,8), %xmm1	# MEM[(double *)&eepf + ivtmp.1667_903 * 8], MEM[(double *)&eepf + ivtmp.1667_903 * 8]
# C/parallel-only-omp/io_manager.h:102:         energy = (i + 0.5) * DE_EEPF;
	vcvtsi2sdl	%r14d, %xmm7, %xmm2	# ivtmp.1667, tmp1095, tmp926
# C/parallel-only-omp/io_manager.h:103:         fprintf(f,"%e  %e\n", energy, eepf[i] / h / sqrt(energy));
	vdivsd	-240(%rbp), %xmm1, %xmm1	# %sfp, MEM[(double *)&eepf + ivtmp.1667_903 * 8], _273
# C/parallel-only-omp/io_manager.h:102:         energy = (i + 0.5) * DE_EEPF;
	vaddsd	.LC45(%rip), %xmm2, %xmm2	#, tmp597, tmp598
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1097
# C/parallel-only-omp/io_manager.h:102:         energy = (i + 0.5) * DE_EEPF;
	vmulsd	.LC19(%rip), %xmm2, %xmm2	#, tmp598, energy
	vucomisd	%xmm2, %xmm7	# energy, tmp1097
	ja	.L342	#,
# C/parallel-only-omp/io_manager.h:103:         fprintf(f,"%e  %e\n", energy, eepf[i] / h / sqrt(energy));
	vsqrtsd	%xmm2, %xmm2, %xmm0	# energy, _274
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vdivsd	%xmm0, %xmm1, %xmm1	# _274, _273,
.L347:
	movq	%r12, %rdx	# tmp858,
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _267,
	movl	$2, %eax	#,
# C/parallel-only-omp/io_manager.h:101:     for (i=0; i<N_EEPF; i++) {
	incq	%r14	# ivtmp.1667
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm2, %xmm2, %xmm0	# energy,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:101:     for (i=0; i<N_EEPF; i++) {
	cmpq	$2000, %r14	#, ivtmp.1667
	jne	.L250	#,
	vmovapd	-304(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovapd	-368(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-496(%rbp), %zmm8	# %sfp, vect__291.1367
# C/parallel-only-omp/io_manager.h:105:     fclose(f);
	movq	%rbx, %rdi	# _267,
	leaq	ifed_pow(%rip), %r15	#, tmp884
	leaq	ifed_gnd(%rip), %r14	#, tmp852
	vmovapd	%zmm8, -368(%rbp)	# vect__291.1367, %sfp
	vmovapd	%zmm9, -304(%rbp)	# vect__345.1344, %sfp
	vmovapd	%zmm7, -240(%rbp)	# vect__376.1333, %sfp
	vzeroupper
	call	fclose@PLT	#
	vmovapd	-368(%rbp), %zmm8	# %sfp, vect__291.1367
	vmovapd	-304(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-240(%rbp), %zmm7	# %sfp, vect__376.1333
	xorl	%eax, %eax	# ivtmp.1665
# C/parallel-only-omp/io_manager.h:119:     h_gnd = 0.0;
	vxorpd	%xmm5, %xmm5, %xmm5	# h_gnd
# C/parallel-only-omp/io_manager.h:118:     h_pow = 0.0;
	vmovsd	%xmm5, %xmm5, %xmm4	#, h_pow
.L251:
# C/parallel-only-omp/io_manager.h:120:     for (i=0; i<N_IFED; i++) {h_pow += ifed_pow[i]; h_gnd += ifed_gnd[i];}
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp1098
	vcvtsi2sdl	(%r15,%rax), %xmm6, %xmm0	# MEM[(int *)&ifed_pow + ivtmp.1665_904 * 1], tmp1098, tmp927
	vaddsd	%xmm0, %xmm4, %xmm4	# tmp609, h_pow, h_pow
# C/parallel-only-omp/io_manager.h:120:     for (i=0; i<N_IFED; i++) {h_pow += ifed_pow[i]; h_gnd += ifed_gnd[i];}
	vcvtsi2sdl	(%r14,%rax), %xmm6, %xmm0	# MEM[(int *)&ifed_gnd + ivtmp.1665_904 * 1], tmp1099, tmp928
# C/parallel-only-omp/io_manager.h:120:     for (i=0; i<N_IFED; i++) {h_pow += ifed_pow[i]; h_gnd += ifed_gnd[i];}
	addq	$4, %rax	#, ivtmp.1665
# C/parallel-only-omp/io_manager.h:120:     for (i=0; i<N_IFED; i++) {h_pow += ifed_pow[i]; h_gnd += ifed_gnd[i];}
	vaddsd	%xmm0, %xmm5, %xmm5	# tmp611, h_gnd, h_gnd
# C/parallel-only-omp/io_manager.h:120:     for (i=0; i<N_IFED; i++) {h_pow += ifed_pow[i]; h_gnd += ifed_gnd[i];}
	cmpq	$800, %rax	#, ivtmp.1665
	jne	.L251	#,
	vmovapd	%zmm7, -368(%rbp)	# vect__376.1333, %sfp
# C/parallel-only-omp/io_manager.h:125:     f = fopen("ifed.dat","w");
	leaq	.LC77(%rip), %rsi	#,
	leaq	.LC120(%rip), %rdi	#, tmp615
	vmovsd	%xmm5, -304(%rbp)	# h_gnd, %sfp
	vmovapd	%zmm8, -624(%rbp)	# vect__291.1367, %sfp
	vmovsd	%xmm4, -240(%rbp)	# h_pow, %sfp
# C/parallel-only-omp/io_manager.h:123:     mean_i_energy_pow = 0.0;
	movq	$0x000000000, mean_i_energy_pow(%rip)	#, mean_i_energy_pow
# C/parallel-only-omp/io_manager.h:124:     mean_i_energy_gnd = 0.0;
	movq	$0x000000000, mean_i_energy_gnd(%rip)	#, mean_i_energy_gnd
	vmovapd	%zmm9, -560(%rbp)	# vect__345.1344, %sfp
	leaq	.LC121(%rip), %rbx	#, tmp869
# C/parallel-only-omp/io_manager.h:125:     f = fopen("ifed.dat","w");
	vzeroupper
	call	fopen@PLT	#
	vmovapd	-368(%rbp), %zmm7	# %sfp, vect__376.1333
	xorl	%r13d, %r13d	# ivtmp.1649
	movq	%rax, %r12	# tmp903, _235
	vmovapd	%zmm7, -496(%rbp)	# vect__376.1333, %sfp
	vzeroupper
	.p2align 4
	.p2align 3
.L252:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%rbx, %rdx	# tmp869,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _235,
	movl	$3, %eax	#,
# C/parallel-only-omp/io_manager.h:127:         energy = (i + 0.5) * DE_IFED;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1100
	vcvtsi2sdl	%r13d, %xmm7, %xmm3	# ivtmp.1649, tmp1100, tmp929
# C/parallel-only-omp/io_manager.h:128:         fprintf(f,"%6.2f %10.6f %10.6f\n", energy, (double)(ifed_pow[i])/h_pow, (double)(ifed_gnd[i])/h_gnd);
	vcvtsi2sdl	(%r14,%r13,4), %xmm7, %xmm2	# MEM[(int *)&ifed_gnd + ivtmp.1649_894 * 4], tmp1101, tmp930
# C/parallel-only-omp/io_manager.h:127:         energy = (i + 0.5) * DE_IFED;
	vaddsd	.LC45(%rip), %xmm3, %xmm3	#, tmp617, energy
# C/parallel-only-omp/io_manager.h:128:         fprintf(f,"%6.2f %10.6f %10.6f\n", energy, (double)(ifed_pow[i])/h_pow, (double)(ifed_gnd[i])/h_gnd);
	vcvtsi2sdl	(%r15,%r13,4), %xmm7, %xmm1	# MEM[(int *)&ifed_pow + ivtmp.1649_894 * 4], tmp1102, tmp931
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	%xmm3, %xmm3, %xmm0	# energy,
	vmovsd	%xmm3, -368(%rbp)	# energy, %sfp
	vdivsd	-304(%rbp), %xmm2, %xmm2	# %sfp, tmp620,
	vdivsd	-240(%rbp), %xmm1, %xmm1	# %sfp, tmp623,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:129:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1105
# C/parallel-only-omp/io_manager.h:129:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vmovsd	-368(%rbp), %xmm3	# %sfp, energy
# C/parallel-only-omp/io_manager.h:129:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vcvtsi2sdl	(%r15,%r13,4), %xmm7, %xmm0	# MEM[(int *)&ifed_pow + ivtmp.1649_894 * 4], tmp1105, tmp932
# C/parallel-only-omp/io_manager.h:129:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vmulsd	%xmm3, %xmm0, %xmm0	# energy, tmp627, tmp628
# C/parallel-only-omp/io_manager.h:129:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vdivsd	-240(%rbp), %xmm0, %xmm0	# %sfp, tmp628, tmp629
# C/parallel-only-omp/io_manager.h:129:         mean_i_energy_pow += energy * (double)(ifed_pow[i]) / h_pow;
	vaddsd	mean_i_energy_pow(%rip), %xmm0, %xmm0	# mean_i_energy_pow, tmp629, tmp630
	vmovsd	%xmm0, mean_i_energy_pow(%rip)	# tmp630, mean_i_energy_pow
# C/parallel-only-omp/io_manager.h:130:         mean_i_energy_gnd += energy * (double)(ifed_gnd[i]) / h_gnd;
	vcvtsi2sdl	(%r14,%r13,4), %xmm7, %xmm0	# MEM[(int *)&ifed_gnd + ivtmp.1649_894 * 4], tmp1107, tmp933
# C/parallel-only-omp/io_manager.h:126:     for (i=0; i<N_IFED; i++) {
	incq	%r13	# ivtmp.1649
# C/parallel-only-omp/io_manager.h:130:         mean_i_energy_gnd += energy * (double)(ifed_gnd[i]) / h_gnd;
	vmulsd	%xmm3, %xmm0, %xmm0	# energy, tmp633, tmp634
# C/parallel-only-omp/io_manager.h:130:         mean_i_energy_gnd += energy * (double)(ifed_gnd[i]) / h_gnd;
	vdivsd	-304(%rbp), %xmm0, %xmm0	# %sfp, tmp634, tmp635
# C/parallel-only-omp/io_manager.h:130:         mean_i_energy_gnd += energy * (double)(ifed_gnd[i]) / h_gnd;
	vaddsd	mean_i_energy_gnd(%rip), %xmm0, %xmm0	# mean_i_energy_gnd, tmp635, tmp636
	vmovsd	%xmm0, mean_i_energy_gnd(%rip)	# tmp636, mean_i_energy_gnd
# C/parallel-only-omp/io_manager.h:126:     for (i=0; i<N_IFED; i++) {
	cmpq	$200, %r13	#, ivtmp.1649
	jne	.L252	#,
# C/parallel-only-omp/io_manager.h:132:     fclose(f);
	vmovapd	-496(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovapd	-560(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-624(%rbp), %zmm8	# %sfp, vect__291.1367
	movq	%r12, %rdi	# _235,
	vmovapd	%zmm7, -368(%rbp)	# vect__376.1333, %sfp
	vmovapd	%zmm9, -304(%rbp)	# vect__345.1344, %sfp
	vmovapd	%zmm8, -240(%rbp)	# vect__291.1367, %sfp
	vzeroupper
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:163:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	movl	no_of_cycles(%rip), %eax	# no_of_cycles, no_of_cycles.294_185
# C/parallel-only-omp/io_manager.h:163:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1109
# C/parallel-only-omp/io_manager.h:163:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	vmovsd	.LC122(%rip), %xmm3	#, tmp640
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vbroadcastsd	.LC126(%rip), %zmm13	#, tmp887
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vbroadcastsd	.LC50(%rip), %zmm10	#, tmp888
# C/parallel-only-omp/io_manager.h:164:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	vmovsd	.LC124(%rip), %xmm12	#, tmp644
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vmovapd	-304(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-240(%rbp), %zmm8	# %sfp, vect__291.1367
# C/parallel-only-omp/io_manager.h:164:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	xorl	%r13d, %r13d	# ivtmp.1647
# C/parallel-only-omp/io_manager.h:172:             if (counter_e_xt[i][j] > 0) {
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp657
# C/parallel-only-omp/io_manager.h:163:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	imull	$4000, %eax, %edx	#, no_of_cycles.294_185, tmp638
# C/parallel-only-omp/io_manager.h:163:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	vcvtsi2sdl	%edx, %xmm7, %xmm0	# tmp638, tmp1109, tmp934
# C/parallel-only-omp/io_manager.h:163:     f1 = (double)(N_XT) / (double)(no_of_cycles * N_T);
	vdivsd	%xmm0, %xmm3, %xmm3	# tmp639, tmp640, f1
# C/parallel-only-omp/io_manager.h:164:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	vcvtsi2sdl	%eax, %xmm7, %xmm0	# no_of_cycles.294_185, tmp1110, tmp935
	leaq	pot_xt(%rip), %rax	#, _870
	vmovq	%rax, %xmm22	# _870, _870
	leaq	efield_xt(%rip), %rax	#, _874
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vmovapd	-368(%rbp), %zmm7	# %sfp, vect__376.1333
# C/parallel-only-omp/io_manager.h:164:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	vmulsd	.LC123(%rip), %xmm0, %xmm0	#, tmp641, tmp642
	vmovq	%rax, %xmm21	# _874, _874
	leaq	ne_xt(%rip), %rax	#, _880
# C/parallel-only-omp/io_manager.h:164:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	vdivsd	%xmm0, %xmm12, %xmm12	# tmp642, tmp644, f2
	vbroadcastsd	%xmm3, %zmm3	# f1, vect_cst__794
	vmovq	%rax, %xmm20	# _880, _880
	leaq	ni_xt(%rip), %rax	#, _887
	vbroadcastsd	%xmm12, %zmm12	# f2, vect_cst__898
	vmovq	%rax, %xmm19	# _887, _887
	leaq	counter_e_xt(%rip), %rax	#, tmp846
	vmovq	%rax, %xmm23	# tmp846, tmp846
	leaq	ue_xt(%rip), %rax	#, tmp862
	vmovq	%rax, %xmm24	# tmp862, tmp862
	leaq	je_xt(%rip), %rax	#, _862
	vmovq	%rax, %xmm25	# _862, _862
	leaq	meanee_xt(%rip), %rax	#, _867
	vmovq	%rax, %xmm26	# _867, _867
	leaq	ioniz_rate_xt(%rip), %rax	#, _846
	vmovq	%rax, %xmm27	# _846, _846
	leaq	counter_i_xt(%rip), %rax	#, tmp876
	vmovq	%rax, %xmm28	# tmp876, tmp876
	leaq	ui_xt(%rip), %rax	#, tmp843
	vmovq	%rax, %xmm29	# tmp843, tmp843
	leaq	ji_xt(%rip), %rax	#, _838
	vmovq	%rax, %xmm30	# _838, _838
	leaq	meanei_xt(%rip), %rax	#, _825
	vmovq	%rax, %xmm31	# _825, _825
	.p2align 4
	.p2align 3
.L260:
	vmovq	%xmm22, %rax	# _870, _870
	leaq	poweri_xt(%rip), %r9	#, ivtmp.1414
	leaq	(%rax,%r13), %r11	#, vectp_pot_xt.1304
	vmovq	%xmm21, %rax	# _874, _874
	leaq	0(%r13,%r9), %r15	#, vectp_poweri_xt.1391
	leaq	(%rax,%r13), %r10	#, vectp_efield_xt.1310
	vmovq	%xmm20, %rax	# _880, _880
	leaq	(%rax,%r13), %r8	#, vectp_ne_xt.1316
	vmovq	%xmm19, %rax	# _887, _887
	leaq	(%rax,%r13), %rdi	#, vectp_ni_xt.1322
	vmovq	%xmm23, %rax	# tmp846, tmp846
	addq	%r13, %rax	# ivtmp.1647, vectp_counter_e_xt.1328
	vmovq	%rax, %xmm18	# vectp_counter_e_xt.1328, vectp_counter_e_xt.1328
	vmovq	%xmm24, %rax	# tmp862, tmp862
	addq	%r13, %rax	# ivtmp.1647, vectp.1332
	vmovq	%rax, %xmm17	# vectp.1332, vectp.1332
	vmovq	%xmm25, %rax	# _862, _862
	leaq	(%rax,%r13), %rsi	#, vectp.1341
	vmovq	%xmm26, %rax	# _867, _867
	leaq	(%rax,%r13), %r14	#, vectp.1343
	vmovq	%xmm27, %rax	# _846, _846
	leaq	(%rax,%r13), %r12	#, vectp_ioniz_rate_xt.1349
	vmovq	%xmm28, %rax	# tmp876, tmp876
	addq	%r13, %rax	# ivtmp.1647, vectp_counter_i_xt.1362
	vmovq	%rax, %xmm16	# vectp_counter_i_xt.1362, vectp_counter_i_xt.1362
	vmovq	%xmm29, %rax	# tmp843, tmp843
	addq	%r13, %rax	# ivtmp.1647, vectp.1366
	vmovq	%rax, %xmm15	# vectp.1366, vectp.1366
	vmovq	%xmm30, %rax	# _838, _838
	addq	%r13, %rax	# ivtmp.1647, vectp.1374
	movq	%rax, -240(%rbp)	# vectp.1374, %sfp
	vmovq	%xmm31, %rax	# _825, _825
	leaq	(%rax,%r13), %rbx	#, vectp_meanei_xt.1376
	leaq	powere_xt(%rip), %rax	#, ivtmp.1413
	movq	%rax, -304(%rbp)	# ivtmp.1413, %sfp
	addq	%r13, %rax	# ivtmp.1647, vectp_powere_xt.1388
	vmovq	%rax, %xmm14	# vectp_powere_xt.1388, vectp_powere_xt.1388
	xorl	%eax, %eax	# ivtmp.1595
	jmp	.L259	#
	.p2align 4
	.p2align 3
.L253:
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vxorpd	%xmm0, %xmm0, %xmm0	# vect__354.1339
	movl	$-1, %ecx	#, mask__762.1352
# C/parallel-only-omp/io_manager.h:176:                 ioniz_rate_xt[i][j] *= f2;
	vmovapd	%zmm0, %zmm1	#, vect__327.1351
.L299:
# C/parallel-only-omp/io_manager.h:178:                 ue_xt[i][j]         = 0.0;
	kmovb	%ecx, %k2	# mask__762.1352, mask__762.1352
	vmovupd	%zmm6, (%rdx){%k2}	# tmp657, MEM <vector(8) double> [(double *)_457], mask__762.1352
# C/parallel-only-omp/io_manager.h:179:                 je_xt[i][j]         = 0.0;
	vmovupd	%zmm6, (%rsi,%rax){%k2}	# tmp657, MEM <vector(8) double> [(double *)vectp.1341_872 + ivtmp.1595_456 * 1], mask__762.1352
# C/parallel-only-omp/io_manager.h:180:                 meanee_xt[i][j]     = 0.0;
	vmovupd	%zmm6, (%r14,%rax){%k2}	# tmp657, MEM <vector(8) double> [(double *)vectp.1343_878 + ivtmp.1595_456 * 1], mask__762.1352
	.p2align 4
	.p2align 3
.L254:
# C/parallel-only-omp/io_manager.h:183:             if (counter_i_xt[i][j] > 0) {
	vmovq	%xmm16, %rcx	# vectp_counter_i_xt.1362, vectp_counter_i_xt.1362
# C/parallel-only-omp/io_manager.h:176:                 ioniz_rate_xt[i][j] *= f2;
	vmovupd	%zmm1, (%r12,%rax)	# vect__327.1351, MEM <vector(8) double> [(double *)vectp_ioniz_rate_xt.1349_892 + ivtmp.1595_456 * 1]
# C/parallel-only-omp/io_manager.h:183:             if (counter_i_xt[i][j] > 0) {
	vmovupd	(%rcx,%rax), %zmm5	# MEM <vector(8) double> [(double *)vectp_counter_i_xt.1362_929 + ivtmp.1595_456 * 1], MEM <vector(8) double> [(double *)vectp_counter_i_xt.1362_929 + ivtmp.1595_456 * 1]
	vmovq	%xmm15, %rcx	# vectp.1366, vectp.1366
	leaq	(%rcx,%rax), %rdx	#, _798
# C/parallel-only-omp/io_manager.h:183:             if (counter_i_xt[i][j] > 0) {
	vcmppd	$14, %zmm6, %zmm5, %k1	#, tmp657, MEM <vector(8) double> [(double *)vectp_counter_i_xt.1362_929 + ivtmp.1595_456 * 1], mask__698.1364
# C/parallel-only-omp/io_manager.h:184:                 ui_xt[i][j]     = ui_xt[i][j] / counter_i_xt[i][j];
	vmovupd	(%rdx), %zmm8{%k1}	# MEM <vector(8) double> [(double *)_798], vect__291.1367, mask__698.1364, vect__291.1367
	kortestb	%k1, %k1	# mask__698.1364
# C/parallel-only-omp/io_manager.h:184:                 ui_xt[i][j]     = ui_xt[i][j] / counter_i_xt[i][j];
	vdivpd	%zmm5, %zmm8, %zmm1{%k1}{z}	# MEM <vector(8) double> [(double *)vectp_counter_i_xt.1362_929 + ivtmp.1595_456 * 1], vect__291.1367, vect__282.1368, mask__698.1364,
	jne	.L348	#,
# C/parallel-only-omp/io_manager.h:185:                 ji_xt[i][j]     = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE;
	vxorpd	%xmm1, %xmm1, %xmm1	# vect__260.1372
	movl	$-1, %ecx	#, mask__769.1379
# C/parallel-only-omp/io_manager.h:186:                 meanei_xt[i][j] = meanei_xt[i][j] / counter_i_xt[i][j];
	vmovapd	%zmm1, %zmm2	#, vect__228.1378
.L298:
# C/parallel-only-omp/io_manager.h:188:                 ui_xt[i][j]     = 0.0;
	kmovb	%ecx, %k5	# mask__769.1379, mask__769.1379
	vmovupd	%zmm6, (%rdx){%k5}	# tmp657, MEM <vector(8) double> [(double *)_798], mask__769.1379
# C/parallel-only-omp/io_manager.h:189:                 ji_xt[i][j]     = 0.0;
	movq	-240(%rbp), %rdx	# %sfp, vectp.1374
	vmovupd	%zmm6, (%rdx,%rax){%k5}	# tmp657, MEM <vector(8) double> [(double *)vectp.1374_956 + ivtmp.1595_456 * 1], mask__769.1379
	.p2align 4
	.p2align 3
.L256:
# C/parallel-only-omp/io_manager.h:192:             powere_xt[i][j] = je_xt[i][j] * efield_xt[i][j];
	vmulpd	%zmm4, %zmm0, %zmm0	# vect__400.1312, vect__354.1339, vect__181.1386
# C/parallel-only-omp/io_manager.h:193:             poweri_xt[i][j] = ji_xt[i][j] * efield_xt[i][j];
	vmulpd	%zmm4, %zmm1, %zmm1	# vect__400.1312, vect__260.1372, vect__170.1389
# C/parallel-only-omp/io_manager.h:192:             powere_xt[i][j] = je_xt[i][j] * efield_xt[i][j];
	vmovq	%xmm14, %rcx	# vectp_powere_xt.1388, vectp_powere_xt.1388
# C/parallel-only-omp/io_manager.h:186:                 meanei_xt[i][j] = meanei_xt[i][j] / counter_i_xt[i][j];
	vmovupd	%zmm2, (%rbx,%rax)	# vect__228.1378, MEM <vector(8) double> [(double *)vectp_meanei_xt.1376_962 + ivtmp.1595_456 * 1]
# C/parallel-only-omp/io_manager.h:192:             powere_xt[i][j] = je_xt[i][j] * efield_xt[i][j];
	vmovupd	%zmm0, (%rcx,%rax)	# vect__181.1386, MEM <vector(8) double> [(double *)vectp_powere_xt.1388_992 + ivtmp.1595_456 * 1]
# C/parallel-only-omp/io_manager.h:193:             poweri_xt[i][j] = ji_xt[i][j] * efield_xt[i][j];
	vmovupd	%zmm1, (%r15,%rax)	# vect__170.1389, MEM <vector(8) double> [(double *)vectp_poweri_xt.1391_999 + ivtmp.1595_456 * 1]
	addq	$64, %rax	#, ivtmp.1595
	cmpq	$1600, %rax	#, ivtmp.1595
	je	.L349	#,
.L259:
# C/parallel-only-omp/io_manager.h:168:             pot_xt[i][j]    *= f1;
	vmulpd	(%r11,%rax), %zmm3, %zmm0	# MEM <vector(8) double> [(double *)vectp_pot_xt.1304_788 + ivtmp.1595_456 * 1], vect_cst__794, vect__403.1306
# C/parallel-only-omp/io_manager.h:172:             if (counter_e_xt[i][j] > 0) {
	vmovq	%xmm18, %rcx	# vectp_counter_e_xt.1328, vectp_counter_e_xt.1328
# C/parallel-only-omp/io_manager.h:168:             pot_xt[i][j]    *= f1;
	vmovupd	%zmm0, (%r11,%rax)	# vect__403.1306, MEM <vector(8) double> [(double *)vectp_pot_xt.1304_788 + ivtmp.1595_456 * 1]
# C/parallel-only-omp/io_manager.h:169:             efield_xt[i][j] *= f1;
	vmulpd	(%r10,%rax), %zmm3, %zmm4	# MEM <vector(8) double> [(double *)vectp_efield_xt.1310_802 + ivtmp.1595_456 * 1], vect_cst__794, vect__400.1312
	vmovupd	%zmm4, (%r10,%rax)	# vect__400.1312, MEM <vector(8) double> [(double *)vectp_efield_xt.1310_802 + ivtmp.1595_456 * 1]
# C/parallel-only-omp/io_manager.h:170:             ne_xt[i][j]     *= f1;
	vmulpd	(%r8,%rax), %zmm3, %zmm5	# MEM <vector(8) double> [(double *)vectp_ne_xt.1316_816 + ivtmp.1595_456 * 1], vect_cst__794, vect__397.1318
	vmovupd	%zmm5, (%r8,%rax)	# vect__397.1318, MEM <vector(8) double> [(double *)vectp_ne_xt.1316_816 + ivtmp.1595_456 * 1]
# C/parallel-only-omp/io_manager.h:171:             ni_xt[i][j]     *= f1;
	vmulpd	(%rdi,%rax), %zmm3, %zmm2	# MEM <vector(8) double> [(double *)vectp_ni_xt.1322_830 + ivtmp.1595_456 * 1], vect_cst__794, vect__394.1324
	vmovupd	%zmm2, (%rdi,%rax)	# vect__394.1324, MEM <vector(8) double> [(double *)vectp_ni_xt.1322_830 + ivtmp.1595_456 * 1]
# C/parallel-only-omp/io_manager.h:172:             if (counter_e_xt[i][j] > 0) {
	vmovupd	(%rcx,%rax), %zmm1	# MEM <vector(8) double> [(double *)vectp_counter_e_xt.1328_844 + ivtmp.1595_456 * 1], MEM <vector(8) double> [(double *)vectp_counter_e_xt.1328_844 + ivtmp.1595_456 * 1]
	vmovq	%xmm17, %rcx	# vectp.1332, vectp.1332
	leaq	(%rcx,%rax), %rdx	#, _457
# C/parallel-only-omp/io_manager.h:172:             if (counter_e_xt[i][j] > 0) {
	vcmppd	$14, %zmm6, %zmm1, %k1	#, tmp657, MEM <vector(8) double> [(double *)vectp_counter_e_xt.1328_844 + ivtmp.1595_456 * 1], mask__696.1330
# C/parallel-only-omp/io_manager.h:173:                 ue_xt[i][j]     =  ue_xt[i][j] / counter_e_xt[i][j];
	vmovupd	(%rdx), %zmm7{%k1}	# MEM <vector(8) double> [(double *)_457], vect__376.1333, mask__696.1330, vect__376.1333
	kortestb	%k1, %k1	# mask__696.1330
# C/parallel-only-omp/io_manager.h:173:                 ue_xt[i][j]     =  ue_xt[i][j] / counter_e_xt[i][j];
	vdivpd	%zmm1, %zmm7, %zmm0{%k1}{z}	# MEM <vector(8) double> [(double *)vectp_counter_e_xt.1328_844 + ivtmp.1595_456 * 1], vect__376.1333, vect__372.1334, mask__696.1330,
	je	.L253	#,
# C/parallel-only-omp/io_manager.h:173:                 ue_xt[i][j]     =  ue_xt[i][j] / counter_e_xt[i][j];
	vmovupd	%zmm0, (%rdx){%k1}	# vect__372.1334, MEM <vector(8) double> [(double *)_457], mask__696.1330
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vxorpd	%zmm13, %zmm0, %zmm0	# tmp887, vect__372.1334, vect__363.1337
	leaq	(%r14,%rax), %rcx	#, _810
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vmulpd	%zmm5, %zmm0, %zmm11{%k1}{z}	# vect__397.1318, vect__363.1337, vect__358.1338, mask__696.1330,
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vmulpd	%zmm10, %zmm11, %zmm0{%k1}{z}	# tmp888, vect__358.1338, vect__354.1339, mask__696.1330,
# C/parallel-only-omp/io_manager.h:174:                 je_xt[i][j]     = -ue_xt[i][j] * ne_xt[i][j] * E_CHARGE;
	vmovupd	%zmm0, (%rsi,%rax){%k1}	# vect__354.1339, MEM <vector(8) double> [(double *)vectp.1341_872 + ivtmp.1595_456 * 1], mask__696.1330
# C/parallel-only-omp/io_manager.h:175:                 meanee_xt[i][j] =  meanee_xt[i][j] / counter_e_xt[i][j];
	vmovupd	(%rcx), %zmm9{%k1}	# MEM <vector(8) double> [(double *)_810], vect__345.1344, mask__696.1330, vect__345.1344
# C/parallel-only-omp/io_manager.h:175:                 meanee_xt[i][j] =  meanee_xt[i][j] / counter_e_xt[i][j];
	vdivpd	%zmm1, %zmm9, %zmm5{%k1}{z}	# MEM <vector(8) double> [(double *)vectp_counter_e_xt.1328_844 + ivtmp.1595_456 * 1], vect__345.1344, vect__340.1345, mask__696.1330,
# C/parallel-only-omp/io_manager.h:175:                 meanee_xt[i][j] =  meanee_xt[i][j] / counter_e_xt[i][j];
	vmovupd	%zmm5, (%rcx){%k1}	# vect__340.1345, MEM <vector(8) double> [(double *)_810], mask__696.1330
	kmovb	%k1, %ecx	# mask__696.1330, mask__696.1330
# C/parallel-only-omp/io_manager.h:176:                 ioniz_rate_xt[i][j] *= f2;
	vmulpd	(%r12,%rax), %zmm12, %zmm1{%k1}{z}	# MEM <vector(8) double> [(double *)vectp_ioniz_rate_xt.1349_892 + ivtmp.1595_456 * 1], vect_cst__898, vect__327.1351, mask__696.1330,
	xorb	$-1, %cl	#, mask__696.1330
	je	.L254	#,
	jmp	.L299	#
	.p2align 4
	.p2align 3
.L348:
# C/parallel-only-omp/io_manager.h:185:                 ji_xt[i][j]     = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE;
	vmulpd	%zmm1, %zmm2, %zmm11{%k1}{z}	# vect__282.1368, vect__394.1324, vect__262.1371, mask__698.1364,
# C/parallel-only-omp/io_manager.h:185:                 ji_xt[i][j]     = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE;
	movq	-240(%rbp), %rcx	# %sfp, vectp.1374
# C/parallel-only-omp/io_manager.h:184:                 ui_xt[i][j]     = ui_xt[i][j] / counter_i_xt[i][j];
	vmovupd	%zmm1, (%rdx){%k1}	# vect__282.1368, MEM <vector(8) double> [(double *)_798], mask__698.1364
# C/parallel-only-omp/io_manager.h:185:                 ji_xt[i][j]     = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE;
	vmulpd	%zmm10, %zmm11, %zmm1{%k1}{z}	# tmp888, vect__262.1371, vect__260.1372, mask__698.1364,
# C/parallel-only-omp/io_manager.h:185:                 ji_xt[i][j]     = ui_xt[i][j] * ni_xt[i][j] * E_CHARGE;
	vmovupd	%zmm1, (%rcx,%rax){%k1}	# vect__260.1372, MEM <vector(8) double> [(double *)vectp.1374_956 + ivtmp.1595_456 * 1], mask__698.1364
# C/parallel-only-omp/io_manager.h:186:                 meanei_xt[i][j] = meanei_xt[i][j] / counter_i_xt[i][j];
	vmovupd	(%rbx,%rax), %zmm2	# MEM <vector(8) double> [(double *)vectp_meanei_xt.1376_962 + ivtmp.1595_456 * 1], tmp1155
	kmovb	%k1, %ecx	# mask__698.1364, mask__698.1364
	xorb	$-1, %cl	#, mask__698.1364
	vdivpd	%zmm5, %zmm2, %zmm2{%k1}{z}	# MEM <vector(8) double> [(double *)vectp_counter_i_xt.1362_929 + ivtmp.1595_456 * 1], tmp1155, vect__228.1378, mask__698.1364,
	je	.L256	#,
	jmp	.L298	#
	.p2align 4
	.p2align 3
.L349:
# C/parallel-only-omp/io_manager.h:166:     for (i=0; i<N_G; i++){
	addq	$1600, %r13	#, ivtmp.1647
	cmpq	$640000, %r13	#, ivtmp.1647
	jne	.L260	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	leaq	-144(%rbp), %rax	#, tmp842
	movabsq	$7218835313067847536, %rcx	#, tmp1163
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%r9, -368(%rbp)	# ivtmp.1414, %sfp
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	%rax, %rdi	# tmp842,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rcx, -144(%rbp)	# tmp1163, MEM <char[1:11]> [(void *)&fname]
	movq	%rax, -240(%rbp)	# tmp842, %sfp
	movl	$7627108, -137(%rbp)	#, MEM <char[1:11]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	vzeroupper
	call	fopen@PLT	#
	leaq	1600+pot_xt(%rip), %r12	#, ivtmp.1590
	leaq	.LC128(%rip), %rbx	#, tmp870
	movq	%rax, %r14	# tmp904, _380
	leaq	.LC129(%rip), %r13	#, tmp871
	.p2align 4
	.p2align 3
.L261:
	leaq	-1600(%r12), %r15	#, ivtmp.1582
	.p2align 4
	.p2align 3
.L262:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_216], MEM[(double *)_216]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _380,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1582
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r15, %r12	# ivtmp.1582, ivtmp.1590
	jne	.L262	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _380,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	addq	$1600, %r12	#, ivtmp.1590
	leaq	641600+pot_xt(%rip), %rax	#, tmp1164
	cmpq	%rax, %r12	# tmp1164, ivtmp.1590
	jne	.L261	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r14, %rdi	# _380,
	leaq	1600+efield_xt(%rip), %r14	#, ivtmp.1574
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8673761824059516517, %rax	#, tmp1165
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1165, MEM <char[1:14]> [(void *)&fname]
	movabsq	$32758180202444895, %rax	#, tmp1166
	movq	%rax, -138(%rbp)	# tmp1166, MEM <char[1:14]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r12	# tmp905, _371
	.p2align 4
	.p2align 3
.L264:
	leaq	-1600(%r14), %r15	#, ivtmp.1566
	.p2align 4
	.p2align 3
.L265:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_211], MEM[(double *)_211]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _371,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1566
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r14, %r15	# ivtmp.1574, ivtmp.1566
	jne	.L265	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _371,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	leaq	1600(%r15), %r14	#, ivtmp.1574
	leaq	641600+efield_xt(%rip), %rax	#, tmp1167
	cmpq	%r14, %rax	# ivtmp.1574, tmp1167
	jne	.L264	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r12, %rdi	# _371,
	leaq	1600+ne_xt(%rip), %r12	#, ivtmp.1558
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$7017785197120677230, %rax	#, tmp1168
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1168, MEM <char[1:10]> [(void *)&fname]
	movw	$116, -136(%rbp)	#, MEM <char[1:10]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r14	# tmp906, _362
	.p2align 4
	.p2align 3
.L267:
	leaq	-1600(%r12), %r15	#, ivtmp.1550
	.p2align 4
	.p2align 3
.L268:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_203], MEM[(double *)_203]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _362,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1550
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r15, %r12	# ivtmp.1550, ivtmp.1558
	jne	.L268	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _362,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	addq	$1600, %r12	#, ivtmp.1558
	leaq	641600+ne_xt(%rip), %rax	#, tmp1169
	cmpq	%r12, %rax	# ivtmp.1558, tmp1169
	jne	.L267	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r14, %rdi	# _362,
	leaq	1600+ni_xt(%rip), %r14	#, ivtmp.1542
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$7017785197120678254, %rax	#, tmp1170
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1170, MEM <char[1:10]> [(void *)&fname]
	movw	$116, -136(%rbp)	#, MEM <char[1:10]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r12	# tmp907, _353
	.p2align 4
	.p2align 3
.L270:
	leaq	-1600(%r14), %r15	#, ivtmp.1534
	.p2align 4
	.p2align 3
.L271:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_438], MEM[(double *)_438]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _353,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1534
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r14, %r15	# ivtmp.1542, ivtmp.1534
	jne	.L271	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _353,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	leaq	1600(%r15), %r14	#, ivtmp.1542
	leaq	641600+ni_xt(%rip), %rax	#, tmp1171
	cmpq	%rax, %r14	# tmp1171, ivtmp.1542
	jne	.L270	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r12, %rdi	# _353,
	leaq	1600+je_xt(%rip), %r12	#, ivtmp.1526
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$7017785197120677226, %rax	#, tmp1172
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1172, MEM <char[1:10]> [(void *)&fname]
	movw	$116, -136(%rbp)	#, MEM <char[1:10]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r14	# tmp908, _344
	.p2align 4
	.p2align 3
.L273:
	leaq	-1600(%r12), %r15	#, ivtmp.1518
	.p2align 4
	.p2align 3
.L274:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_715], MEM[(double *)_715]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _344,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1518
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r15, %r12	# ivtmp.1518, ivtmp.1526
	jne	.L274	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _344,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	addq	$1600, %r12	#, ivtmp.1526
	leaq	641600+je_xt(%rip), %rax	#, tmp1173
	cmpq	%r12, %rax	# ivtmp.1526, tmp1173
	jne	.L273	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r14, %rdi	# _344,
	leaq	1600+ji_xt(%rip), %r12	#, ivtmp.1510
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$7017785197120678250, %rax	#, tmp1174
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1174, MEM <char[1:10]> [(void *)&fname]
	movw	$116, -136(%rbp)	#, MEM <char[1:10]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r14	# tmp909, _335
	.p2align 4
	.p2align 3
.L276:
	leaq	-1600(%r12), %r15	#, ivtmp.1502
	.p2align 4
	.p2align 3
.L277:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_702], MEM[(double *)_702]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _335,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1502
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r15, %r12	# ivtmp.1502, ivtmp.1510
	jne	.L277	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _335,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	addq	$1600, %r12	#, ivtmp.1510
	leaq	641600+ji_xt(%rip), %rax	#, tmp1175
	cmpq	%rax, %r12	# tmp1175, ivtmp.1510
	jne	.L276	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r14, %rdi	# _335,
	leaq	1600+powere_xt(%rip), %r12	#, ivtmp.1494
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8673762949341867888, %rax	#, tmp1176
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1176, MEM <char[1:14]> [(void *)&fname]
	movabsq	$32758180202444895, %rax	#, tmp1177
	movq	%rax, -138(%rbp)	# tmp1177, MEM <char[1:14]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r14	# tmp910, _326
	.p2align 4
	.p2align 3
.L279:
	leaq	-1600(%r12), %r15	#, ivtmp.1486
	.p2align 4
	.p2align 3
.L280:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_717], MEM[(double *)_717]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _326,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1486
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r15, %r12	# ivtmp.1486, ivtmp.1494
	jne	.L280	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _326,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	addq	$1600, %r12	#, ivtmp.1494
	leaq	641600+powere_xt(%rip), %rax	#, tmp1178
	cmpq	%rax, %r12	# tmp1178, ivtmp.1494
	jne	.L279	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r14, %rdi	# _326,
	leaq	1600+poweri_xt(%rip), %r14	#, ivtmp.1478
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8673767347388378992, %rax	#, tmp1179
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1179, MEM <char[1:14]> [(void *)&fname]
	movabsq	$32758180202444895, %rax	#, tmp1180
	movq	%rax, -138(%rbp)	# tmp1180, MEM <char[1:14]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r12	# tmp911, _317
	.p2align 4
	.p2align 3
.L282:
	leaq	-1600(%r14), %r15	#, ivtmp.1470
	.p2align 4
	.p2align 3
.L283:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_740], MEM[(double *)_740]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _317,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1470
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r14, %r15	# ivtmp.1478, ivtmp.1470
	jne	.L283	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _317,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	leaq	1600(%r15), %r14	#, ivtmp.1478
	leaq	641600+poweri_xt(%rip), %rax	#, tmp1181
	cmpq	%r14, %rax	# ivtmp.1478, tmp1181
	jne	.L282	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r12, %rdi	# _317,
	leaq	1600+meanee_xt(%rip), %r14	#, ivtmp.1462
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8673762893656843629, %rax	#, tmp1182
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1182, MEM <char[1:14]> [(void *)&fname]
	movabsq	$32758180202444895, %rax	#, tmp1183
	movq	%rax, -138(%rbp)	# tmp1183, MEM <char[1:14]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r12	# tmp912, _308
	.p2align 4
	.p2align 3
.L285:
	leaq	-1600(%r14), %r15	#, ivtmp.1454
	.p2align 4
	.p2align 3
.L286:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_747], MEM[(double *)_747]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _308,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1454
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r14, %r15	# ivtmp.1462, ivtmp.1454
	jne	.L286	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _308,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	leaq	1600(%r15), %r14	#, ivtmp.1462
	leaq	641600+meanee_xt(%rip), %rax	#, tmp1184
	cmpq	%r14, %rax	# ivtmp.1462, tmp1184
	jne	.L285	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	%r12, %rdi	# _308,
	leaq	1600+meanei_xt(%rip), %r14	#, ivtmp.1446
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8673767291703354733, %rax	#, tmp1185
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1185, MEM <char[1:14]> [(void *)&fname]
	movabsq	$32758180202444895, %rax	#, tmp1186
	movq	%rax, -138(%rbp)	# tmp1186, MEM <char[1:14]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	%rax, %r12	# tmp913, _299
	.p2align 4
	.p2align 3
.L288:
	leaq	-1600(%r14), %r15	#, ivtmp.1438
	.p2align 4
	.p2align 3
.L289:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_170], MEM[(double *)_170]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _299,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1438
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r14, %r15	# ivtmp.1446, ivtmp.1438
	jne	.L289	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r12, %rdi	# _299,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	leaq	1600(%r15), %r14	#, ivtmp.1446
	leaq	641600+meanei_xt(%rip), %rax	#, tmp1187
	cmpq	%r14, %rax	# ivtmp.1446, tmp1187
	jne	.L288	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	-304(%rbp), %r8	# %sfp, ivtmp.1413
	movq	-368(%rbp), %r9	# %sfp, ivtmp.1414
	movq	%r12, %rdi	# _299,
	leaq	1600+ioniz_rate_xt(%rip), %r12	#, ivtmp.1430
	movq	%r8, -496(%rbp)	# ivtmp.1413, %sfp
	movq	%r9, -304(%rbp)	# ivtmp.1414, %sfp
	call	fclose@PLT	#
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	movq	-240(%rbp), %rdi	# %sfp,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movabsq	$8392562884964413289, %rax	#, tmp1188
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	leaq	.LC77(%rip), %rsi	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, -144(%rbp)	# tmp1188, MEM <char[1:13]> [(void *)&fname]
	movabsq	$32758180202444895, %rax	#, tmp1189
	movq	%rax, -139(%rbp)	# tmp1189, MEM <char[1:13]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:144:     f = fopen(fname,"w");
	call	fopen@PLT	#
	movq	-496(%rbp), %r8	# %sfp, ivtmp.1413
	movq	%rax, %r14	# tmp914, _290
	movq	%r8, -240(%rbp)	# ivtmp.1413, %sfp
	.p2align 4
	.p2align 3
.L291:
	leaq	-1600(%r12), %r15	#, ivtmp.1422
	.p2align 4
	.p2align 3
.L292:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	(%r15), %xmm0	# MEM[(double *)_398], MEM[(double *)_398]
	movq	%rbx, %rdx	# tmp870,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _290,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	addq	$8, %r15	#, ivtmp.1422
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:146:         for (j=0; j<N_XT; j++){
	cmpq	%r15, %r12	# ivtmp.1422, ivtmp.1430
	jne	.L292	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%r13, %rdx	# tmp871,
	movl	$2, %esi	#,
	movq	%r14, %rdi	# _290,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:145:     for (i=0; i<N_G; i++){
	addq	$1600, %r12	#, ivtmp.1430
	leaq	641600+ioniz_rate_xt(%rip), %rax	#, tmp1190
	cmpq	%r12, %rax	# ivtmp.1430, tmp1190
	jne	.L291	#,
# C/parallel-only-omp/io_manager.h:151:     fclose(f);
	movq	-240(%rbp), %r8	# %sfp, ivtmp.1413
	movq	-304(%rbp), %r9	# %sfp, ivtmp.1414
	movq	%r14, %rdi	# _290,
	movq	%r8, -368(%rbp)	# ivtmp.1413, %sfp
	movq	%r9, -240(%rbp)	# ivtmp.1414, %sfp
	call	fclose@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	-432(%rbp), %rbx	# %sfp, _91
	leaq	.LC130(%rip), %rdx	#, tmp772
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
	movq	%rbx, %rdi	# _91,
	call	__fprintf_chk@PLT	#
	leaq	.LC133(%rip), %rdx	#, tmp782
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:304:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1191
	vcvtusi2sdq	N_i_abs_pow(%rip), %xmm7, %xmm0	# N_i_abs_pow, tmp1191, tmp936
# C/parallel-only-omp/io_manager.h:304:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vcvtsi2sdl	no_of_cycles(%rip), %xmm7, %xmm1	# no_of_cycles, tmp1192, tmp937
# C/parallel-only-omp/io_manager.h:304:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC92(%rip), %xmm0, %xmm0	#, tmp773, tmp774
# C/parallel-only-omp/io_manager.h:304:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC132(%rip), %xmm1, %xmm1	#, tmp778, tmp779
# C/parallel-only-omp/io_manager.h:304:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	.LC131(%rip), %xmm0, %xmm0	#, tmp774, tmp776
# C/parallel-only-omp/io_manager.h:304:         fprintf(f,"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp779, tmp776, tmp781
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
	leaq	.LC134(%rip), %rdx	#, tmp792
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:305:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1193
	vcvtusi2sdq	N_i_abs_gnd(%rip), %xmm7, %xmm0	# N_i_abs_gnd, tmp1193, tmp938
# C/parallel-only-omp/io_manager.h:305:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vcvtsi2sdl	no_of_cycles(%rip), %xmm7, %xmm1	# no_of_cycles, tmp1194, tmp939
# C/parallel-only-omp/io_manager.h:305:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC92(%rip), %xmm0, %xmm0	#, tmp783, tmp784
# C/parallel-only-omp/io_manager.h:305:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC132(%rip), %xmm1, %xmm1	#, tmp788, tmp789
# C/parallel-only-omp/io_manager.h:305:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	.LC131(%rip), %xmm0, %xmm0	#, tmp784, tmp786
# C/parallel-only-omp/io_manager.h:305:         fprintf(f,"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n", N_i_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp789, tmp786, tmp791
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
	leaq	.LC135(%rip), %rdx	#, tmp794
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	mean_i_energy_pow(%rip), %xmm0	# mean_i_energy_pow,
	call	__fprintf_chk@PLT	#
	leaq	.LC136(%rip), %rdx	#, tmp796
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	mean_i_energy_gnd(%rip), %xmm0	# mean_i_energy_gnd,
	call	__fprintf_chk@PLT	#
	leaq	.LC137(%rip), %rdx	#, tmp806
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:308:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1195
	vcvtusi2sdq	N_e_abs_pow(%rip), %xmm7, %xmm0	# N_e_abs_pow, tmp1195, tmp940
# C/parallel-only-omp/io_manager.h:308:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vcvtsi2sdl	no_of_cycles(%rip), %xmm7, %xmm1	# no_of_cycles, tmp1196, tmp941
# C/parallel-only-omp/io_manager.h:308:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC92(%rip), %xmm0, %xmm0	#, tmp797, tmp798
# C/parallel-only-omp/io_manager.h:308:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC132(%rip), %xmm1, %xmm1	#, tmp802, tmp803
# C/parallel-only-omp/io_manager.h:308:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	.LC131(%rip), %xmm0, %xmm0	#, tmp798, tmp800
# C/parallel-only-omp/io_manager.h:308:         fprintf(f,"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_pow * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp803, tmp800, tmp805
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
	leaq	.LC138(%rip), %rdx	#, tmp816
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:309:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp1197
	vcvtusi2sdq	N_e_abs_gnd(%rip), %xmm7, %xmm0	# N_e_abs_gnd, tmp1197, tmp942
# C/parallel-only-omp/io_manager.h:309:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vcvtsi2sdl	no_of_cycles(%rip), %xmm7, %xmm1	# no_of_cycles, tmp1198, tmp943
# C/parallel-only-omp/io_manager.h:309:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC92(%rip), %xmm0, %xmm0	#, tmp807, tmp808
# C/parallel-only-omp/io_manager.h:309:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vmulsd	.LC132(%rip), %xmm1, %xmm1	#, tmp812, tmp813
# C/parallel-only-omp/io_manager.h:309:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	.LC131(%rip), %xmm0, %xmm0	#, tmp808, tmp810
# C/parallel-only-omp/io_manager.h:309:         fprintf(f,"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n", N_e_abs_gnd * WEIGHT / ELECTRODE_AREA / (no_of_cycles * PERIOD));
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp813, tmp810, tmp815
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
	leaq	.LC95(%rip), %rdx	#,
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
	movq	-368(%rbp), %r8	# %sfp, ivtmp.1413
	movq	-240(%rbp), %r9	# %sfp, ivtmp.1414
	leaq	640000+powere_xt(%rip), %rcx	#, _404
# C/parallel-only-omp/io_manager.h:314:         power_i = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# power_i
# C/parallel-only-omp/io_manager.h:313:         power_e = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm1	#, power_e
	.p2align 4
	.p2align 3
.L294:
# C/parallel-only-omp/io_manager.h:164:     f2 = WEIGHT / (ELECTRODE_AREA * DX) / (no_of_cycles * (PERIOD / (double)(N_XT)));
	xorl	%eax, %eax	# ivtmp.1402
	.p2align 4
	.p2align 3
.L295:
	leaq	(%r8,%rax), %rdx	#, _952
	vaddsd	(%rdx), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_952], 64, 0>, power_e, stmp_power_e_108.1298
	vaddsd	8(%rdx), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_952], 64, 64>, stmp_power_e_108.1298, stmp_power_e_108.1298
	vaddsd	16(%rdx), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_952], 64, 128>, stmp_power_e_108.1298, stmp_power_e_108.1298
	vaddsd	24(%rdx), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_952], 64, 192>, stmp_power_e_108.1298, stmp_power_e_108.1298
	vaddsd	32(%rdx), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_952], 64, 256>, stmp_power_e_108.1298, stmp_power_e_108.1298
	vaddsd	40(%rdx), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_952], 64, 320>, stmp_power_e_108.1298, stmp_power_e_108.1298
# C/parallel-only-omp/io_manager.h:317:                 power_e += powere_xt[i][j];
	vaddsd	48(%rdx), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_952], 64, 384>, stmp_power_e_108.1298, stmp_power_e_108.1298
	vaddsd	56(%rdx), %xmm1, %xmm1	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_952], 64, 448>, stmp_power_e_108.1298, power_e
	leaq	(%r9,%rax), %rdx	#, _865
	addq	$64, %rax	#, ivtmp.1402
	vaddsd	(%rdx), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_865], 64, 0>, power_i, stmp_power_i_109.1302
	vaddsd	8(%rdx), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_865], 64, 64>, stmp_power_i_109.1302, stmp_power_i_109.1302
	vaddsd	16(%rdx), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_865], 64, 128>, stmp_power_i_109.1302, stmp_power_i_109.1302
	vaddsd	24(%rdx), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_865], 64, 192>, stmp_power_i_109.1302, stmp_power_i_109.1302
	vaddsd	32(%rdx), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_865], 64, 256>, stmp_power_i_109.1302, stmp_power_i_109.1302
	vaddsd	40(%rdx), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_865], 64, 320>, stmp_power_i_109.1302, stmp_power_i_109.1302
# C/parallel-only-omp/io_manager.h:318:                 power_i += poweri_xt[i][j];
	vaddsd	48(%rdx), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_865], 64, 384>, stmp_power_i_109.1302, stmp_power_i_109.1302
	vaddsd	56(%rdx), %xmm0, %xmm0	# BIT_FIELD_REF <MEM <vector(8) double> [(double *)_865], 64, 448>, stmp_power_i_109.1302, power_i
	cmpq	$1600, %rax	#, ivtmp.1402
	jne	.L295	#,
# C/parallel-only-omp/io_manager.h:315:         for (i=0; i<N_G; i++){
	addq	$1600, %r8	#, ivtmp.1413
	addq	$1600, %r9	#, ivtmp.1414
	cmpq	%rcx, %r8	# _404, ivtmp.1413
	jne	.L294	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	-432(%rbp), %rbx	# %sfp, _91
	leaq	.LC140(%rip), %rdx	#, tmp822
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
# C/parallel-only-omp/io_manager.h:321:         power_e /= (double)(N_XT * N_G);
	vmovsd	.LC139(%rip), %xmm2	#, tmp820
# C/parallel-only-omp/io_manager.h:322:         power_i /= (double)(N_XT * N_G);
	vdivsd	%xmm2, %xmm0, %xmm4	# tmp820, power_i, power_i
# C/parallel-only-omp/io_manager.h:321:         power_e /= (double)(N_XT * N_G);
	vdivsd	%xmm2, %xmm1, %xmm7	# tmp820, power_e, power_e
# C/parallel-only-omp/io_manager.h:322:         power_i /= (double)(N_XT * N_G);
	vmovsd	%xmm4, -304(%rbp)	# power_i, %sfp
# C/parallel-only-omp/io_manager.h:321:         power_e /= (double)(N_XT * N_G);
	vmovsd	%xmm7, -240(%rbp)	# power_e, %sfp
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movq	%rbx, %rdi	# _91,
	call	__fprintf_chk@PLT	#
	leaq	.LC141(%rip), %rdx	#, tmp823
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	-240(%rbp), %xmm0	# %sfp,
	call	__fprintf_chk@PLT	#
	leaq	.LC142(%rip), %rdx	#, tmp824
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
	vmovsd	-304(%rbp), %xmm0	# %sfp,
	call	__fprintf_chk@PLT	#
	leaq	.LC143(%rip), %rdx	#, tmp826
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	movl	$1, %eax	#,
# C/parallel-only-omp/io_manager.h:326:         fprintf(f,"Total power density(average)          = %12.3e [W m^{-3}]\n", power_e + power_i);
	vmovsd	-304(%rbp), %xmm4	# %sfp, power_i
	vaddsd	-240(%rbp), %xmm4, %xmm0	# %sfp, power_i, tmp825
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
	xorl	%eax, %eax	#
	leaq	.LC95(%rip), %rdx	#,
	movl	$2, %esi	#,
	movq	%rbx, %rdi	# _91,
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:328:         fclose(f);
	movq	-56(%rbp), %rax	# D.132814, tmp946
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp946
	jne	.L345	#,
	movq	-432(%rbp), %rdi	# %sfp,
# C/parallel-only-omp/io_manager.h:330: }
	addq	$584, %rsp	#,
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	.cfi_remember_state
	.cfi_def_cfa 13, 0
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	leaq	-16(%r13), %rsp	#,
	.cfi_def_cfa 7, 16
	popq	%r13	#
	.cfi_def_cfa_offset 8
# C/parallel-only-omp/io_manager.h:328:         fclose(f);
	jmp	fclose@PLT	#
.L342:
	.cfi_restore_state
	vmovsd	%xmm1, -624(%rbp)	# _273, %sfp
# C/parallel-only-omp/io_manager.h:103:         fprintf(f,"%e  %e\n", energy, eepf[i] / h / sqrt(energy));
	vmovsd	%xmm2, %xmm2, %xmm0	# energy,
	vmovsd	%xmm2, -560(%rbp)	# energy, %sfp
	call	sqrt@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	vmovsd	-624(%rbp), %xmm1	# %sfp, _273
	vmovsd	-560(%rbp), %xmm2	# %sfp, energy
	vdivsd	%xmm0, %xmm1, %xmm1	# tmp902, _273,
	jmp	.L347	#
.L345:
# C/parallel-only-omp/io_manager.h:328:         fclose(f);
	call	__stack_chk_fail@PLT	#
	.p2align 4
	.p2align 3
.L341:
	vmovapd	%zmm8, -496(%rbp)	# vect__291.1367, %sfp
	vmovsd	%xmm1, -240(%rbp)	# nu_max, %sfp
	vmovapd	%zmm9, -368(%rbp)	# vect__345.1344, %sfp
	vmovapd	%zmm7, -304(%rbp)	# vect__376.1333, %sfp
# C/parallel-only-omp/cross_sections.h:133:         g  = sqrt(2.0 * e * EV_TO_J / MU_ARAR);
	vzeroupper
	call	sqrt@PLT	#
	vmovapd	-496(%rbp), %zmm8	# %sfp, vect__291.1367
	vmovapd	-368(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-304(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovsd	.LC1(%rip), %xmm3	#, tmp865
	vmovsd	.LC53(%rip), %xmm5	#, tmp855
	vmovsd	.LC50(%rip), %xmm2	#, tmp850
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp561
	vmovsd	-240(%rbp), %xmm1	# %sfp, nu_max
	jmp	.L238	#
.L340:
	vmovapd	%zmm8, -496(%rbp)	# vect__291.1367, %sfp
	vmovsd	%xmm1, -240(%rbp)	# nu_max, %sfp
	vmovapd	%zmm9, -368(%rbp)	# vect__345.1344, %sfp
	vmovapd	%zmm7, -304(%rbp)	# vect__376.1333, %sfp
# C/parallel-only-omp/cross_sections.h:113:         v  = sqrt(2.0 * e * EV_TO_J / E_MASS);
	vzeroupper
	call	sqrt@PLT	#
	vmovapd	-496(%rbp), %zmm8	# %sfp, vect__291.1367
	vmovapd	-368(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-304(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovsd	.LC1(%rip), %xmm3	#, tmp865
	vmovsd	.LC51(%rip), %xmm4	#, tmp851
	vmovsd	.LC50(%rip), %xmm2	#, tmp850
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp549
	vmovsd	-240(%rbp), %xmm1	# %sfp, nu_max
	jmp	.L232	#
.L339:
	vmovapd	%zmm8, -496(%rbp)	# vect__291.1367, %sfp
	vmovapd	%zmm9, -432(%rbp)	# vect__345.1344, %sfp
	vmovapd	%zmm7, -368(%rbp)	# vect__376.1333, %sfp
# C/parallel-only-omp/io_manager.h:241:     debye_length = sqrt(EPSILON0 * kT / density) / E_CHARGE;                         // Promień Debye'a elektronów w centrum
	vzeroupper
	call	sqrt@PLT	#
	vmovapd	-496(%rbp), %zmm8	# %sfp, vect__291.1367
	vmovapd	-432(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-368(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovsd	.LC50(%rip), %xmm2	#, tmp850
	jmp	.L228	#
.L338:
	vmovapd	%zmm8, -496(%rbp)	# vect__291.1367, %sfp
	vmovsd	%xmm1, -304(%rbp)	# _3, %sfp
	vmovapd	%zmm9, -432(%rbp)	# vect__345.1344, %sfp
	vmovapd	%zmm7, -368(%rbp)	# vect__376.1333, %sfp
# C/parallel-only-omp/io_manager.h:235:     plas_freq  = E_CHARGE * sqrt(density / EPSILON0 / E_MASS);                       // Częstość plazmowa elektronów w środku szczeliny
	vzeroupper
	call	sqrt@PLT	#
	vmovapd	-496(%rbp), %zmm8	# %sfp, vect__291.1367
	vmovapd	-432(%rbp), %zmm9	# %sfp, vect__345.1344
	vmovapd	-368(%rbp), %zmm7	# %sfp, vect__376.1333
	vmovsd	-304(%rbp), %xmm1	# %sfp, _3
	jmp	.L225	#
	.cfi_endproc
.LFE9928:
	.size	_Z19check_and_save_infov, .-_Z19check_and_save_infov
	.section	.rodata._ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm.str1.1,"aMS",@progbits,1
.LC144:
	.string	"vector::_M_default_append"
	.section	.text._ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm,"axG",@progbits,_ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm
	.type	_ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm, @function
_ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm:
.LFB10525:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/vector.tcc:637:       if (__n != 0)
	testq	%rsi, %rsi	# __n
	je	.L383	#,
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
	movabsq	$5675921253449092805, %rdx	#, tmp135
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
	movq	8(%rdi), %rbp	# MEM[(const struct vector *)this_18(D)].D.102928._M_impl.D.102267._M_finish, _26
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	movq	16(%rdi), %rax	# this_18(D)->D.102928._M_impl.D.102267._M_end_of_storage, tmp130
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	(%rdi), %r15	# MEM[(const struct vector *)this_18(D)].D.102928._M_impl.D.102267._M_start, _25
	movq	%rdi, %rbx	# tmp186, this
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	subq	%rbp, %rax	# _26, tmp130
	sarq	$8, %rax	#, tmp133
	imulq	%rdx, %rax	# tmp135, __navail
# /usr/include/c++/13/bits/vector.tcc:646: 	  if (__navail >= __n)
	cmpq	%rsi, %rax	# __n, __navail
	jnb	.L387	#,
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	subq	%r15, %rbp	# _25, _30
	movq	%rbp, %rax	# _30, tmp156
	sarq	$8, %rax	#, tmp156
	imulq	%rdx, %rax	# tmp135, tmp157
# /usr/include/c++/13/bits/vector.tcc:643: 	  if (__size > max_size() || __navail > max_size() - __size)
	movabsq	$2771445924535689, %rdx	#, tmp160
	subq	%rax, %rdx	# tmp157, tmp159
# /usr/include/c++/13/bits/stl_vector.h:1898: 	if (max_size() - size() < __n)
	cmpq	%rsi, %rdx	# __n, tmp159
	jb	.L388	#,
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
	jb	.L356	#,
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$2771445924535689, %rdx	#, tmp191
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	addq	%rax, %rax	# __len
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	cmpq	%rdx, %rax	# tmp191, __len
	cmova	%rdx, %rax	# __len,, tmp191, __len
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	imulq	$3328, %rax, %rax	#, __len, _9
	movq	%rax, %rdi	# _9,
	movq	%rax, 16(%rsp)	# _9, %sfp
	call	_Znwm@PLT	#
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movl	$3328, %edx	#,
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
	je	.L357	#,
.L386:
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	imulq	$3328, %r13, %r13	#, _49, tmp174
# /usr/include/c++/13/bits/stl_uninitialized.h:667: 	      ++__first;
	leaq	3328(%r14), %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	addq	%rcx, %r13	# __first, _78
	.p2align 4
	.p2align 3
.L360:
# /usr/include/c++/13/bits/stl_algobase.h:919: 	*__first = __value;
	movq	%rcx, %rdi	# __first,
	movl	$3328, %edx	#,
	movq	%r14, %rsi	# _8,
	call	memcpy@PLT	#
	movq	%rax, %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:918:       for (; __first != __last; ++__first)
	addq	$3328, %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:918:       for (; __first != __last; ++__first)
	cmpq	%rcx, %r13	# __first, _78
	jne	.L360	#,
.L359:
# /usr/include/c++/13/bits/stl_uninitialized.h:1119:       if (__count > 0)
	testq	%rbp, %rbp	# _30
	jne	.L357	#,
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%r15, %r15	# _25
	jne	.L389	#,
.L363:
# /usr/include/c++/13/bits/vector.tcc:706: 	      this->_M_impl._M_finish = __new_start + __size + __n;
	imulq	$3328, 8(%rsp), %rax	#, %sfp, tmp183
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
	movq	%r12, 16(%rbx)	# tmp185, this_18(D)->D.102928._M_impl.D.102267._M_end_of_storage
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
.L387:
	.cfi_restore_state
	movq	%rsi, 8(%rsp)	# __n, %sfp
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movl	$3328, %edx	#,
	xorl	%esi, %esi	#
	movq	%rbp, %rdi	# _26,
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_algobase.h:1123:       if (__n <= 0)
	movq	8(%rsp), %rcx	# %sfp, __n
# /usr/include/c++/13/bits/stl_uninitialized.h:667: 	      ++__first;
	leaq	3328(%rbp), %r13	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:1123:       if (__n <= 0)
	decq	%rcx	# _48
	je	.L353	#,
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	imulq	$3328, %rcx, %rcx	#, _48, tmp140
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	leaq	0(%r13,%rcx), %r12	#, _52
	movq	%r13, %rcx	# __first, __first
	.p2align 4
	.p2align 3
.L354:
# /usr/include/c++/13/bits/stl_algobase.h:919: 	*__first = __value;
	movq	%rcx, %rdi	# __first,
	movl	$3328, %edx	#,
	movq	%rbp, %rsi	# _26,
	call	memcpy@PLT	#
	movq	%rax, %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:918:       for (; __first != __last; ++__first)
	addq	$3328, %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:918:       for (; __first != __last; ++__first)
	cmpq	%rcx, %r12	# __first, _52
	jne	.L354	#,
	subq	%rbp, %r12	# _26, tmp146
	movabsq	$55428918490713797, %rdx	#, tmp151
	leaq	-6656(%r12), %rax	#, tmp148
	shrq	$8, %rax	#, tmp149
	imulq	%rdx, %rax	# tmp151, tmp150
	movabsq	$72057594037927935, %rdx	#, tmp153
	andq	%rdx, %rax	# tmp153, tmp152
	incq	%rax	# tmp154
	imulq	$3328, %rax, %rax	#, tmp154, tmp155
	addq	%rax, %r13	# tmp155, __first
.L353:
# /usr/include/c++/13/bits/vector.tcc:649: 	      this->_M_impl._M_finish =
	movq	%r13, 8(%rbx)	# __first, this_18(D)->D.102928._M_impl.D.102267._M_finish
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
.L383:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret	
	.p2align 4
	.p2align 3
.L356:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$2771445924535689, %rax	#, tmp190
	cmpq	%rax, %rsi	# tmp190, _63
	cmovbe	%rsi, %rax	# _63,, tmp168
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	imulq	$3328, %rax, %rax	#, tmp168, _9
	movq	%rax, %rdi	# _9,
	movq	%rax, 16(%rsp)	# _9, %sfp
	call	_Znwm@PLT	#
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	xorl	%esi, %esi	#
	movl	$3328, %edx	#,
# /usr/include/c++/13/bits/vector.tcc:668: 		      std::__uninitialized_default_n_a(__new_start + __size,
	leaq	(%rax,%rbp), %r14	#, _8
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r12	# tmp189, _35
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movq	%r14, %rdi	# _8,
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_algobase.h:1123:       if (__n <= 0)
	testq	%r13, %r13	# _49
	jne	.L386	#,
	jmp	.L359	#
	.p2align 4
	.p2align 3
.L357:
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	%r15, %rsi	# _25,
	movq	%rbp, %rdx	# _30,
	movq	%r12, %rdi	# _35,
	call	memmove@PLT	#
# /usr/include/c++/13/bits/vector.tcc:704: 			    this->_M_impl._M_end_of_storage - __old_start);
	movq	16(%rbx), %rsi	# this_18(D)->D.102928._M_impl.D.102267._M_end_of_storage, _62
	subq	%r15, %rsi	# _25, _62
.L362:
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%r15, %rdi	# _25,
	call	_ZdlPvm@PLT	#
	jmp	.L363	#
	.p2align 4
	.p2align 3
.L389:
# /usr/include/c++/13/bits/vector.tcc:704: 			    this->_M_impl._M_end_of_storage - __old_start);
	movq	16(%rbx), %rsi	# this_18(D)->D.102928._M_impl.D.102267._M_end_of_storage, _62
	subq	%r15, %rsi	# _25, _62
	jmp	.L362	#
.L388:
# /usr/include/c++/13/bits/stl_vector.h:1899: 	  __throw_length_error(__N(__s));
	leaq	.LC144(%rip), %rdi	#, tmp161
	call	_ZSt20__throw_length_errorPKc@PLT	#
	.cfi_endproc
.LFE10525:
	.size	_ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm, .-_ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm
	.section	.text._ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm,"axG",@progbits,_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm
	.type	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm, @function
_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm:
.LFB10532:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/vector.tcc:637:       if (__n != 0)
	testq	%rsi, %rsi	# __n
	je	.L423	#,
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
	movq	8(%rdi), %rbp	# MEM[(const struct vector *)this_18(D)].D.103980._M_impl.D.103319._M_finish, _26
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	movq	16(%rdi), %rax	# this_18(D)->D.103980._M_impl.D.103319._M_end_of_storage, tmp130
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	(%rdi), %r15	# MEM[(const struct vector *)this_18(D)].D.103980._M_impl.D.103319._M_start, _25
	movq	%rdi, %rbx	# tmp186, this
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	subq	%rbp, %rax	# _26, tmp130
	sarq	$7, %rax	#, tmp133
	imulq	%rdx, %rax	# tmp135, __navail
# /usr/include/c++/13/bits/vector.tcc:646: 	  if (__navail >= __n)
	cmpq	%rsi, %rax	# __n, __navail
	jnb	.L427	#,
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	subq	%r15, %rbp	# _25, _30
	movq	%rbp, %rax	# _30, tmp156
	sarq	$7, %rax	#, tmp156
	imulq	%rdx, %rax	# tmp135, tmp157
# /usr/include/c++/13/bits/vector.tcc:643: 	  if (__size > max_size() || __navail > max_size() - __size)
	movabsq	$2882303761517117, %rdx	#, tmp160
	subq	%rax, %rdx	# tmp157, tmp159
# /usr/include/c++/13/bits/stl_vector.h:1898: 	if (max_size() - size() < __n)
	cmpq	%rsi, %rdx	# __n, tmp159
	jb	.L428	#,
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
	jb	.L396	#,
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$2882303761517117, %rdx	#, tmp191
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	addq	%rax, %rax	# __len
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	cmpq	%rdx, %rax	# tmp191, __len
	cmova	%rdx, %rax	# __len,, tmp191, __len
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	imulq	$3200, %rax, %rax	#, __len, _9
	movq	%rax, %rdi	# _9,
	movq	%rax, 16(%rsp)	# _9, %sfp
	call	_Znwm@PLT	#
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movl	$3200, %edx	#,
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
	je	.L397	#,
.L426:
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	imulq	$3200, %r13, %r13	#, _49, tmp174
# /usr/include/c++/13/bits/stl_uninitialized.h:667: 	      ++__first;
	leaq	3200(%r14), %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	addq	%rcx, %r13	# __first, _78
	.p2align 4
	.p2align 3
.L400:
# /usr/include/c++/13/bits/stl_algobase.h:919: 	*__first = __value;
	movq	%rcx, %rdi	# __first,
	movl	$3200, %edx	#,
	movq	%r14, %rsi	# _8,
	call	memcpy@PLT	#
	movq	%rax, %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:918:       for (; __first != __last; ++__first)
	addq	$3200, %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:918:       for (; __first != __last; ++__first)
	cmpq	%rcx, %r13	# __first, _78
	jne	.L400	#,
.L399:
# /usr/include/c++/13/bits/stl_uninitialized.h:1119:       if (__count > 0)
	testq	%rbp, %rbp	# _30
	jne	.L397	#,
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%r15, %r15	# _25
	jne	.L429	#,
.L403:
# /usr/include/c++/13/bits/vector.tcc:706: 	      this->_M_impl._M_finish = __new_start + __size + __n;
	imulq	$3200, 8(%rsp), %rax	#, %sfp, tmp183
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
	movq	%r12, 16(%rbx)	# tmp185, this_18(D)->D.103980._M_impl.D.103319._M_end_of_storage
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
.L427:
	.cfi_restore_state
	movq	%rsi, 8(%rsp)	# __n, %sfp
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movl	$3200, %edx	#,
	xorl	%esi, %esi	#
	movq	%rbp, %rdi	# _26,
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_algobase.h:1123:       if (__n <= 0)
	movq	8(%rsp), %rcx	# %sfp, __n
# /usr/include/c++/13/bits/stl_uninitialized.h:667: 	      ++__first;
	leaq	3200(%rbp), %r13	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:1123:       if (__n <= 0)
	decq	%rcx	# _48
	je	.L393	#,
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	imulq	$3200, %rcx, %rcx	#, _48, tmp140
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	leaq	0(%r13,%rcx), %r12	#, _52
	movq	%r13, %rcx	# __first, __first
	.p2align 4
	.p2align 3
.L394:
# /usr/include/c++/13/bits/stl_algobase.h:919: 	*__first = __value;
	movq	%rcx, %rdi	# __first,
	movl	$3200, %edx	#,
	movq	%rbp, %rsi	# _26,
	call	memcpy@PLT	#
	movq	%rax, %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:918:       for (; __first != __last; ++__first)
	addq	$3200, %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:918:       for (; __first != __last; ++__first)
	cmpq	%rcx, %r12	# __first, _52
	jne	.L394	#,
	subq	%rbp, %r12	# _26, tmp146
	movabsq	$97998327891581993, %rdx	#, tmp151
	leaq	-6400(%r12), %rax	#, tmp148
	shrq	$7, %rax	#, tmp149
	imulq	%rdx, %rax	# tmp151, tmp150
	movabsq	$144115188075855871, %rdx	#, tmp153
	andq	%rdx, %rax	# tmp153, tmp152
	incq	%rax	# tmp154
	imulq	$3200, %rax, %rax	#, tmp154, tmp155
	addq	%rax, %r13	# tmp155, __first
.L393:
# /usr/include/c++/13/bits/vector.tcc:649: 	      this->_M_impl._M_finish =
	movq	%r13, 8(%rbx)	# __first, this_18(D)->D.103980._M_impl.D.103319._M_finish
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
.L423:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret	
	.p2align 4
	.p2align 3
.L396:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$2882303761517117, %rax	#, tmp190
	cmpq	%rax, %rsi	# tmp190, _63
	cmovbe	%rsi, %rax	# _63,, tmp168
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	imulq	$3200, %rax, %rax	#, tmp168, _9
	movq	%rax, %rdi	# _9,
	movq	%rax, 16(%rsp)	# _9, %sfp
	call	_Znwm@PLT	#
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	xorl	%esi, %esi	#
	movl	$3200, %edx	#,
# /usr/include/c++/13/bits/vector.tcc:668: 		      std::__uninitialized_default_n_a(__new_start + __size,
	leaq	(%rax,%rbp), %r14	#, _8
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r12	# tmp189, _35
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movq	%r14, %rdi	# _8,
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_algobase.h:1123:       if (__n <= 0)
	testq	%r13, %r13	# _49
	jne	.L426	#,
	jmp	.L399	#
	.p2align 4
	.p2align 3
.L397:
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	%r15, %rsi	# _25,
	movq	%rbp, %rdx	# _30,
	movq	%r12, %rdi	# _35,
	call	memmove@PLT	#
# /usr/include/c++/13/bits/vector.tcc:704: 			    this->_M_impl._M_end_of_storage - __old_start);
	movq	16(%rbx), %rsi	# this_18(D)->D.103980._M_impl.D.103319._M_end_of_storage, _62
	subq	%r15, %rsi	# _25, _62
.L402:
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%r15, %rdi	# _25,
	call	_ZdlPvm@PLT	#
	jmp	.L403	#
	.p2align 4
	.p2align 3
.L429:
# /usr/include/c++/13/bits/vector.tcc:704: 			    this->_M_impl._M_end_of_storage - __old_start);
	movq	16(%rbx), %rsi	# this_18(D)->D.103980._M_impl.D.103319._M_end_of_storage, _62
	subq	%r15, %rsi	# _25, _62
	jmp	.L402	#
.L428:
# /usr/include/c++/13/bits/stl_vector.h:1899: 	  __throw_length_error(__N(__s));
	leaq	.LC144(%rip), %rdi	#, tmp161
	call	_ZSt20__throw_length_errorPKc@PLT	#
	.cfi_endproc
.LFE10532:
	.size	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm, .-_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm
	.section	.text._ZNSt6vectorISt5arrayIdLm2000EESaIS1_EE17_M_default_appendEm,"axG",@progbits,_ZNSt6vectorISt5arrayIdLm2000EESaIS1_EE17_M_default_appendEm,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorISt5arrayIdLm2000EESaIS1_EE17_M_default_appendEm
	.type	_ZNSt6vectorISt5arrayIdLm2000EESaIS1_EE17_M_default_appendEm, @function
_ZNSt6vectorISt5arrayIdLm2000EESaIS1_EE17_M_default_appendEm:
.LFB10539:
	.cfi_startproc
	endbr64	
# /usr/include/c++/13/bits/vector.tcc:637:       if (__n != 0)
	testq	%rsi, %rsi	# __n
	je	.L463	#,
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
	movabsq	$2066035336255469781, %rdx	#, tmp135
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
	movq	8(%rdi), %rbp	# MEM[(const struct vector *)this_18(D)].D.105034._M_impl.D.104373._M_finish, _26
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	movq	16(%rdi), %rax	# this_18(D)->D.105034._M_impl.D.104373._M_end_of_storage, tmp130
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	(%rdi), %r15	# MEM[(const struct vector *)this_18(D)].D.105034._M_impl.D.104373._M_start, _25
	movq	%rdi, %rbx	# tmp186, this
# /usr/include/c++/13/bits/vector.tcc:641: 					 - this->_M_impl._M_finish);
	subq	%rbp, %rax	# _26, tmp130
	sarq	$7, %rax	#, tmp133
	imulq	%rdx, %rax	# tmp135, __navail
# /usr/include/c++/13/bits/vector.tcc:646: 	  if (__navail >= __n)
	cmpq	%rsi, %rax	# __n, __navail
	jnb	.L467	#,
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	subq	%r15, %rbp	# _25, _30
	movq	%rbp, %rax	# _30, tmp156
	sarq	$7, %rax	#, tmp156
	imulq	%rdx, %rax	# tmp135, tmp157
# /usr/include/c++/13/bits/vector.tcc:643: 	  if (__size > max_size() || __navail > max_size() - __size)
	movabsq	$576460752303423, %rdx	#, tmp160
	subq	%rax, %rdx	# tmp157, tmp159
# /usr/include/c++/13/bits/stl_vector.h:1898: 	if (max_size() - size() < __n)
	cmpq	%rsi, %rdx	# __n, tmp159
	jb	.L468	#,
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
	jb	.L436	#,
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$576460752303423, %rdx	#, tmp191
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	addq	%rax, %rax	# __len
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	cmpq	%rdx, %rax	# tmp191, __len
	cmova	%rdx, %rax	# __len,, tmp191, __len
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	imulq	$16000, %rax, %rax	#, __len, _9
	movq	%rax, %rdi	# _9,
	movq	%rax, 16(%rsp)	# _9, %sfp
	call	_Znwm@PLT	#
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movl	$16000, %edx	#,
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
	je	.L437	#,
.L466:
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	imulq	$16000, %r13, %r13	#, _49, tmp174
# /usr/include/c++/13/bits/stl_uninitialized.h:667: 	      ++__first;
	leaq	16000(%r14), %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	addq	%rcx, %r13	# __first, _78
	.p2align 4
	.p2align 3
.L440:
# /usr/include/c++/13/bits/stl_algobase.h:919: 	*__first = __value;
	movq	%rcx, %rdi	# __first,
	movl	$16000, %edx	#,
	movq	%r14, %rsi	# _8,
	call	memcpy@PLT	#
	movq	%rax, %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:918:       for (; __first != __last; ++__first)
	addq	$16000, %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:918:       for (; __first != __last; ++__first)
	cmpq	%rcx, %r13	# __first, _78
	jne	.L440	#,
.L439:
# /usr/include/c++/13/bits/stl_uninitialized.h:1119:       if (__count > 0)
	testq	%rbp, %rbp	# _30
	jne	.L437	#,
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%r15, %r15	# _25
	jne	.L469	#,
.L443:
# /usr/include/c++/13/bits/vector.tcc:706: 	      this->_M_impl._M_finish = __new_start + __size + __n;
	imulq	$16000, 8(%rsp), %rax	#, %sfp, tmp183
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
	movq	%r12, 16(%rbx)	# tmp185, this_18(D)->D.105034._M_impl.D.104373._M_end_of_storage
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
.L467:
	.cfi_restore_state
	movq	%rsi, 8(%rsp)	# __n, %sfp
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movl	$16000, %edx	#,
	xorl	%esi, %esi	#
	movq	%rbp, %rdi	# _26,
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_algobase.h:1123:       if (__n <= 0)
	movq	8(%rsp), %rcx	# %sfp, __n
# /usr/include/c++/13/bits/stl_uninitialized.h:667: 	      ++__first;
	leaq	16000(%rbp), %r13	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:1123:       if (__n <= 0)
	decq	%rcx	# _48
	je	.L433	#,
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	imulq	$16000, %rcx, %rcx	#, _48, tmp140
# /usr/include/c++/13/bits/stl_algobase.h:1128:       std::__fill_a(__first, __first + __n, __value);
	leaq	0(%r13,%rcx), %r12	#, _52
	movq	%r13, %rcx	# __first, __first
	.p2align 4
	.p2align 3
.L434:
# /usr/include/c++/13/bits/stl_algobase.h:919: 	*__first = __value;
	movq	%rcx, %rdi	# __first,
	movl	$16000, %edx	#,
	movq	%rbp, %rsi	# _26,
	call	memcpy@PLT	#
	movq	%rax, %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:918:       for (; __first != __last; ++__first)
	addq	$16000, %rcx	#, __first
# /usr/include/c++/13/bits/stl_algobase.h:918:       for (; __first != __last; ++__first)
	cmpq	%rcx, %r12	# __first, _52
	jne	.L434	#,
	subq	%rbp, %r12	# _26, tmp146
	movabsq	$48422703193487573, %rdx	#, tmp151
	leaq	-32000(%r12), %rax	#, tmp148
	shrq	$7, %rax	#, tmp149
	imulq	%rdx, %rax	# tmp151, tmp150
	movabsq	$144115188075855871, %rdx	#, tmp153
	andq	%rdx, %rax	# tmp153, tmp152
	incq	%rax	# tmp154
	imulq	$16000, %rax, %rax	#, tmp154, tmp155
	addq	%rax, %r13	# tmp155, __first
.L433:
# /usr/include/c++/13/bits/vector.tcc:649: 	      this->_M_impl._M_finish =
	movq	%r13, 8(%rbx)	# __first, this_18(D)->D.105034._M_impl.D.104373._M_finish
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
.L463:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	.cfi_restore 15
	ret	
	.p2align 4
	.p2align 3
.L436:
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$576460752303423, %rax	#, tmp190
	cmpq	%rax, %rsi	# tmp190, _63
	cmovbe	%rsi, %rax	# _63,, tmp168
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	imulq	$16000, %rax, %rax	#, tmp168, _9
	movq	%rax, %rdi	# _9,
	movq	%rax, 16(%rsp)	# _9, %sfp
	call	_Znwm@PLT	#
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	xorl	%esi, %esi	#
	movl	$16000, %edx	#,
# /usr/include/c++/13/bits/vector.tcc:668: 		      std::__uninitialized_default_n_a(__new_start + __size,
	leaq	(%rax,%rbp), %r14	#, _8
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r12	# tmp189, _35
# /usr/include/c++/13/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movq	%r14, %rdi	# _8,
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_algobase.h:1123:       if (__n <= 0)
	testq	%r13, %r13	# _49
	jne	.L466	#,
	jmp	.L439	#
	.p2align 4
	.p2align 3
.L437:
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	%r15, %rsi	# _25,
	movq	%rbp, %rdx	# _30,
	movq	%r12, %rdi	# _35,
	call	memmove@PLT	#
# /usr/include/c++/13/bits/vector.tcc:704: 			    this->_M_impl._M_end_of_storage - __old_start);
	movq	16(%rbx), %rsi	# this_18(D)->D.105034._M_impl.D.104373._M_end_of_storage, _62
	subq	%r15, %rsi	# _25, _62
.L442:
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%r15, %rdi	# _25,
	call	_ZdlPvm@PLT	#
	jmp	.L443	#
	.p2align 4
	.p2align 3
.L469:
# /usr/include/c++/13/bits/vector.tcc:704: 			    this->_M_impl._M_end_of_storage - __old_start);
	movq	16(%rbx), %rsi	# this_18(D)->D.105034._M_impl.D.104373._M_end_of_storage, _62
	subq	%r15, %rsi	# _25, _62
	jmp	.L442	#
.L468:
# /usr/include/c++/13/bits/stl_vector.h:1899: 	  __throw_length_error(__N(__s));
	leaq	.LC144(%rip), %rdi	#, tmp161
	call	_ZSt20__throw_length_errorPKc@PLT	#
	.cfi_endproc
.LFE10539:
	.size	_ZNSt6vectorISt5arrayIdLm2000EESaIS1_EE17_M_default_appendEm, .-_ZNSt6vectorISt5arrayIdLm2000EESaIS1_EE17_M_default_appendEm
	.section	.text._ZNSt6vectorI21AlignedThreadCountersSaIS0_EE17_M_default_appendEm,"axG",@progbits,_ZNSt6vectorI21AlignedThreadCountersSaIS0_EE17_M_default_appendEm,comdat
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
	.section	.text._ZNSt6vectorIS_IiSaIiEESaIS1_EE17_M_default_appendEm,"axG",@progbits,_ZNSt6vectorIS_IiSaIiEESaIS1_EE17_M_default_appendEm,comdat
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
	.section	.text._ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm,"axG",@progbits,_ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm,comdat
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
	.section	.text._ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm,"axG",@progbits,_ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm,comdat
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
	.section	.text._ZN13WorkerBuffers12init_buffersEi,"axG",@progbits,_ZN13WorkerBuffers12init_buffersEi,comdat
	.align 2
	.p2align 4
	.weak	_ZN13WorkerBuffers12init_buffersEi
	.type	_ZN13WorkerBuffers12init_buffersEi, @function
_ZN13WorkerBuffers12init_buffersEi:
.LFB9786:
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
	movl	%esi, %r13d	# tmp408, num_threads
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$5675921253449092805, %rsi	#, tmp263
# C/parallel-only-omp/state.h:215:     void init_buffers(int num_threads) {
	subq	$56, %rsp	#,
	.cfi_def_cfa_offset 112
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	8(%rdi), %rcx	# MEM[(const struct vector *)this_21(D)].D.102928._M_impl.D.102267._M_finish, _40
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	(%rdi), %rdx	# MEM[(const struct vector *)this_21(D)].D.102928._M_impl.D.102267._M_start, _43
# C/parallel-only-omp/state.h:215:     void init_buffers(int num_threads) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp425
	movq	%rax, 40(%rsp)	# tmp425, D.133572
	xorl	%eax, %eax	# tmp425
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _40, tmp260
	subq	%rdx, %rax	# _43, tmp260
	sarq	$8, %rax	#, tmp261
	imulq	%rsi, %rax	# tmp263, tmp262
# C/parallel-only-omp/state.h:216:         if ((int)e_density.size() >= num_threads) return;
	cmpl	%eax, %r13d	# tmp262, num_threads
	jg	.L689	#,
.L638:
# C/parallel-only-omp/state.h:254:     }
	movq	40(%rsp), %rax	# D.133572, tmp426
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp426
	jne	.L690	#,
	addq	$56, %rsp	#,
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
.L689:
	.cfi_restore_state
# C/parallel-only-omp/state.h:218:         e_density.resize(num_threads);
	movslq	%r13d, %rbp	# num_threads, _3
	movq	%rdi, %rbx	# tmp407, this
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp262
	jb	.L691	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp262, _3
	jnb	.L641	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3328, %rbp, %rax	#, _3, tmp265
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp265, _177
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _177, _40
	je	.L641	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 8(%rdi)	# _177, MEM[(struct vector *)this_21(D)].D.102928._M_impl.D.102267._M_finish
	.p2align 4
	.p2align 3
.L641:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	32(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 24B].D.102928._M_impl.D.102267._M_finish, _162
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	24(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 24B].D.102928._M_impl.D.102267._M_start, _163
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$5675921253449092805, %rsi	#, tmp269
	movq	%rcx, %rax	# _162, tmp266
	subq	%rdx, %rax	# _163, tmp266
	sarq	$8, %rax	#, tmp267
	imulq	%rsi, %rax	# tmp269, tmp268
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp268
	jb	.L692	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp268, _3
	jnb	.L643	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3328, %rbp, %rax	#, _3, tmp272
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp272, _169
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _169, _162
	je	.L643	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 32(%rbx)	# _169, MEM[(struct vector *)this_21(D) + 24B].D.102928._M_impl.D.102267._M_finish
	.p2align 4
	.p2align 3
.L643:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	56(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 48B].D.103980._M_impl.D.103319._M_finish, _154
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	48(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 48B].D.103980._M_impl.D.103319._M_start, _155
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp276
	movq	%rcx, %rax	# _154, tmp273
	subq	%rdx, %rax	# _155, tmp273
	sarq	$7, %rax	#, tmp274
	imulq	%rsi, %rax	# tmp276, tmp275
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp275
	jb	.L693	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp275, _3
	jnb	.L645	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbp, %rax	#, _3, tmp279
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp279, _161
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _161, _154
	je	.L645	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 56(%rbx)	# _161, MEM[(struct vector *)this_21(D) + 48B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L645:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	80(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 72B].D.103980._M_impl.D.103319._M_finish, _146
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	72(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 72B].D.103980._M_impl.D.103319._M_start, _147
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp283
	movq	%rcx, %rax	# _146, tmp280
	subq	%rdx, %rax	# _147, tmp280
	sarq	$7, %rax	#, tmp281
	imulq	%rsi, %rax	# tmp283, tmp282
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp282
	jb	.L694	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp282, _3
	jnb	.L647	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbp, %rax	#, _3, tmp286
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp286, _153
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _153, _146
	je	.L647	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 80(%rbx)	# _153, MEM[(struct vector *)this_21(D) + 72B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L647:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	104(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 96B].D.103980._M_impl.D.103319._M_finish, _138
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	96(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 96B].D.103980._M_impl.D.103319._M_start, _139
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp290
	movq	%rcx, %rax	# _138, tmp287
	subq	%rdx, %rax	# _139, tmp287
	sarq	$7, %rax	#, tmp288
	imulq	%rsi, %rax	# tmp290, tmp289
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp289
	jb	.L695	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp289, _3
	jnb	.L649	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbp, %rax	#, _3, tmp293
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp293, _145
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _145, _138
	je	.L649	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 104(%rbx)	# _145, MEM[(struct vector *)this_21(D) + 96B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L649:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	128(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 120B].D.103980._M_impl.D.103319._M_finish, _130
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	120(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 120B].D.103980._M_impl.D.103319._M_start, _131
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp297
	movq	%rcx, %rax	# _130, tmp294
	subq	%rdx, %rax	# _131, tmp294
	sarq	$7, %rax	#, tmp295
	imulq	%rsi, %rax	# tmp297, tmp296
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp296
	jb	.L696	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp296, _3
	jnb	.L651	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbp, %rax	#, _3, tmp300
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp300, _137
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _137, _130
	je	.L651	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 128(%rbx)	# _137, MEM[(struct vector *)this_21(D) + 120B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L651:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	152(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 144B].D.105034._M_impl.D.104373._M_finish, _122
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	144(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 144B].D.105034._M_impl.D.104373._M_start, _123
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$2066035336255469781, %rsi	#, tmp304
	movq	%rcx, %rax	# _122, tmp301
	subq	%rdx, %rax	# _123, tmp301
	sarq	$7, %rax	#, tmp302
	imulq	%rsi, %rax	# tmp304, tmp303
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp303
	jb	.L697	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp303, _3
	jnb	.L653	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$16000, %rbp, %rax	#, _3, tmp307
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp307, _129
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _129, _122
	je	.L653	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 152(%rbx)	# _129, MEM[(struct vector *)this_21(D) + 144B].D.105034._M_impl.D.104373._M_finish
	.p2align 4
	.p2align 3
.L653:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	176(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 168B].D.106084._M_impl.D.105423._M_finish, _114
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	168(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 168B].D.106084._M_impl.D.105423._M_start, _115
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _114, tmp308
	subq	%rdx, %rax	# _115, tmp308
	sarq	$6, %rax	#, tmp309
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp309
	jb	.L698	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp309, _3
	jnb	.L655	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	movq	%rbp, %rax	# _3, tmp312
	salq	$6, %rax	#, tmp312
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp312, _121
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _121, _114
	je	.L655	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 176(%rbx)	# _121, MEM[(struct vector *)this_21(D) + 168B].D.106084._M_impl.D.105423._M_finish
	.p2align 4
	.p2align 3
.L655:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	200(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 192B].D.103980._M_impl.D.103319._M_finish, _106
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	192(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 192B].D.103980._M_impl.D.103319._M_start, _107
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp316
	movq	%rcx, %rax	# _106, tmp313
	subq	%rdx, %rax	# _107, tmp313
	sarq	$7, %rax	#, tmp314
	imulq	%rsi, %rax	# tmp316, tmp315
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp315
	jb	.L699	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp315, _3
	jnb	.L657	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbp, %rax	#, _3, tmp319
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp319, _113
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _113, _106
	je	.L657	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 200(%rbx)	# _113, MEM[(struct vector *)this_21(D) + 192B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L657:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	224(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 216B].D.103980._M_impl.D.103319._M_finish, _98
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	216(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 216B].D.103980._M_impl.D.103319._M_start, _99
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp323
	movq	%rcx, %rax	# _98, tmp320
	subq	%rdx, %rax	# _99, tmp320
	sarq	$7, %rax	#, tmp321
	imulq	%rsi, %rax	# tmp323, tmp322
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp322
	jb	.L700	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp322, _3
	jnb	.L659	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbp, %rax	#, _3, tmp326
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp326, _105
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _105, _98
	je	.L659	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 224(%rbx)	# _105, MEM[(struct vector *)this_21(D) + 216B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L659:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	248(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 240B].D.103980._M_impl.D.103319._M_finish, _90
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	240(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 240B].D.103980._M_impl.D.103319._M_start, _91
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp330
	movq	%rcx, %rax	# _90, tmp327
	subq	%rdx, %rax	# _91, tmp327
	sarq	$7, %rax	#, tmp328
	imulq	%rsi, %rax	# tmp330, tmp329
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp329
	jb	.L701	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp329, _3
	jnb	.L661	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbp, %rax	#, _3, tmp333
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp333, _97
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _97, _90
	je	.L661	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 248(%rbx)	# _97, MEM[(struct vector *)this_21(D) + 240B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L661:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	272(%rbx), %r15	# MEM[(const struct vector *)this_21(D) + 264B].D.107139._M_impl.D.106478._M_finish, _82
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	264(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 264B].D.107139._M_impl.D.106478._M_start, _83
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-6148914691236517205, %rcx	#, tmp337
	movq	%r15, %rax	# _82, tmp334
	subq	%rdx, %rax	# _83, tmp334
	sarq	$3, %rax	#, tmp335
	imulq	%rcx, %rax	# tmp337, tmp336
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp336
	jb	.L702	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp336, _3
	jnb	.L663	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	leaq	0(%rbp,%rbp,2), %rax	#, tmp342
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	leaq	(%rdx,%rax,8), %r14	#, _89
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%r14, %r15	# _89, _82
	je	.L663	#,
	movq	%r14, %r12	# _89, __first
	.p2align 4
	.p2align 3
.L667:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	(%r12), %rdi	# MEM[(int * *)__first_187], _182
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _182
	je	.L664	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	16(%r12), %rsi	# MEM[(int * *)__first_187 + 16B], tmp344
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	addq	$24, %r12	#, __first
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rdi, %rsi	# _182, tmp344
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	cmpq	%r12, %r15	# __first, _82
	jne	.L667	#,
.L666:
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%r14, 272(%rbx)	# _89, MEM[(struct vector *)this_21(D) + 264B].D.107139._M_impl.D.106478._M_finish
	.p2align 4
	.p2align 3
.L663:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	296(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 288B].D.108190._M_impl.D.107529._M_finish, _74
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	288(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 288B].D.108190._M_impl.D.107529._M_start, _75
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp349
	movq	%rcx, %rax	# _74, tmp346
	subq	%rdx, %rax	# _75, tmp346
	sarq	$5, %rax	#, tmp347
	imulq	%rsi, %rax	# tmp349, tmp348
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp348
	jb	.L703	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp348, _3
	jnb	.L669	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$800, %rbp, %rax	#, _3, tmp352
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp352, _81
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _81, _74
	je	.L669	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 296(%rbx)	# _81, MEM[(struct vector *)this_21(D) + 288B].D.108190._M_impl.D.107529._M_finish
	.p2align 4
	.p2align 3
.L669:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	320(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 312B].D.108190._M_impl.D.107529._M_finish, _66
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	312(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 312B].D.108190._M_impl.D.107529._M_start, _67
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp356
	movq	%rcx, %rax	# _66, tmp353
	subq	%rdx, %rax	# _67, tmp353
	sarq	$5, %rax	#, tmp354
	imulq	%rsi, %rax	# tmp356, tmp355
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp355
	jb	.L704	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp355, _3
	jnb	.L671	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$800, %rbp, %rax	#, _3, tmp359
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp359, _73
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _73, _66
	je	.L671	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 320(%rbx)	# _73, MEM[(struct vector *)this_21(D) + 312B].D.108190._M_impl.D.107529._M_finish
	.p2align 4
	.p2align 3
.L671:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	344(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 336B].D.109241._M_impl.D.108580._M_finish, _58
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	336(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 336B].D.109241._M_impl.D.108580._M_start, _59
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-36011213418661887, %rsi	#, tmp363
	movq	%rcx, %rax	# _58, tmp360
	subq	%rdx, %rax	# _59, tmp360
	sarq	$6, %rax	#, tmp361
	imulq	%rsi, %rax	# tmp363, tmp362
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp362
	jb	.L705	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp362, _3
	jnb	.L673	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$131136, %rbp, %rax	#, _3, tmp366
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp366, _65
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _65, _58
	je	.L673	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 344(%rbx)	# _65, MEM[(struct vector *)this_21(D) + 336B].D.109241._M_impl.D.108580._M_finish
	.p2align 4
	.p2align 3
.L673:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	368(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 360B].D.109241._M_impl.D.108580._M_finish, _50
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	360(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 360B].D.109241._M_impl.D.108580._M_start, _51
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-36011213418661887, %rsi	#, tmp370
	movq	%rcx, %rax	# _50, tmp367
	subq	%rdx, %rax	# _51, tmp367
	sarq	$6, %rax	#, tmp368
	imulq	%rsi, %rax	# tmp370, tmp369
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp369
	jb	.L706	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp369, _3
	jb	.L707	#,
.L676:
# C/parallel-only-omp/state.h:243:         for (int t = 0; t < num_threads; ++t) {
	testl	%r13d, %r13d	# num_threads
	jle	.L681	#,
	leaq	0(%rbp,%rbp,2), %r14	#, tmp378
	xorl	%r12d, %r12d	# ivtmp.1962
	salq	$3, %r14	#, tmp379
	jmp	.L680	#
	.p2align 4
	.p2align 3
.L677:
	addq	$24, %r12	#, ivtmp.1962
	cmpq	%r12, %r14	# ivtmp.1962, tmp379
	je	.L681	#,
.L680:
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	264(%rbx), %rbp	# MEM[(struct vector *)this_21(D) + 264B].D.107139._M_impl.D.106478._M_start, _48
	addq	%r12, %rbp	# ivtmp.1962, _48
# /usr/include/c++/13/bits/stl_vector.h:1080: 			 - this->_M_impl._M_start); }
	movq	0(%rbp), %rdx	# MEM[(const struct vector *)_48].D.110314._M_impl.D.109653._M_start, _190
# /usr/include/c++/13/bits/stl_vector.h:1080: 			 - this->_M_impl._M_start); }
	movq	16(%rbp), %rax	# MEM[(const struct vector *)_48].D.110314._M_impl.D.109653._M_end_of_storage, tmp381
	subq	%rdx, %rax	# _190, tmp381
# /usr/include/c++/13/bits/vector.tcc:72:       if (this->capacity() < __n)
	cmpq	$7996, %rax	#, tmp381
	ja	.L677	#,
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	8(%rbp), %r15	# MEM[(const struct vector *)_48].D.110314._M_impl.D.109653._M_finish, _195
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movl	$8000, %edi	#,
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	subq	%rdx, %r15	# _190, _195
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	call	_Znwm@PLT	#
# /usr/include/c++/13/bits/vector.tcc:80: 	      _S_relocate(this->_M_impl._M_start, this->_M_impl._M_finish,
	movq	0(%rbp), %rdi	# MEM[(struct vector *)_48].D.110314._M_impl.D.109653._M_start, _199
# /usr/include/c++/13/bits/stl_uninitialized.h:1118:       ptrdiff_t __count = __last - __first;
	movq	8(%rbp), %rdx	# MEM[(struct vector *)_48].D.110314._M_impl.D.109653._M_finish, _200
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %rcx	# tmp409, _216
# /usr/include/c++/13/bits/stl_uninitialized.h:1118:       ptrdiff_t __count = __last - __first;
	subq	%rdi, %rdx	# _199, _200
# /usr/include/c++/13/bits/stl_uninitialized.h:1119:       if (__count > 0)
	testq	%rdx, %rdx	# _200
	jle	.L678	#,
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	%rdi, %rsi	# _199,
	movq	%rax, %rdi	# _216,
	call	memmove@PLT	#
# /usr/include/c++/13/bits/vector.tcc:95: 			- this->_M_impl._M_start);
	movq	0(%rbp), %rdi	# MEM[(struct vector *)_48].D.110314._M_impl.D.109653._M_start, _199
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	%rax, %rcx	#, _216
.L678:
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _199
	je	.L679	#,
# /usr/include/c++/13/bits/vector.tcc:95: 			- this->_M_impl._M_start);
	movq	16(%rbp), %rsi	# MEM[(struct vector *)_48].D.110314._M_impl.D.109653._M_end_of_storage, tmp386
	movq	%rcx, 8(%rsp)	# _216, %sfp
	subq	%rdi, %rsi	# _199, tmp386
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
	movq	8(%rsp), %rcx	# %sfp, _216
.L679:
# /usr/include/c++/13/bits/vector.tcc:97: 	  this->_M_impl._M_finish = __tmp + __old_size;
	addq	%rcx, %r15	# _216, tmp389
# /usr/include/c++/13/bits/vector.tcc:96: 	  this->_M_impl._M_start = __tmp;
	vmovq	%rcx, %xmm1	# _216, _216
# C/parallel-only-omp/state.h:243:         for (int t = 0; t < num_threads; ++t) {
	addq	$24, %r12	#, ivtmp.1962
# /usr/include/c++/13/bits/vector.tcc:98: 	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	addq	$8000, %rcx	#, tmp390
# /usr/include/c++/13/bits/vector.tcc:96: 	  this->_M_impl._M_start = __tmp;
	vpinsrq	$1, %r15, %xmm1, %xmm0	# tmp389, _216, tmp388
# /usr/include/c++/13/bits/vector.tcc:98: 	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	movq	%rcx, 16(%rbp)	# tmp390, MEM[(struct vector *)_48].D.110314._M_impl.D.109653._M_end_of_storage
# /usr/include/c++/13/bits/vector.tcc:96: 	  this->_M_impl._M_start = __tmp;
	vmovdqu	%xmm0, 0(%rbp)	# tmp388, MEM <vector(2) long unsigned int> [(int * *)_48]
# C/parallel-only-omp/state.h:243:         for (int t = 0; t < num_threads; ++t) {
	cmpq	%r12, %r14	# ivtmp.1962, tmp379
	jne	.L680	#,
.L681:
	leaq	16(%rsp), %rsi	#, tmp373
	xorl	%ecx, %ecx	#
	xorl	%edx, %edx	#
	leaq	_ZN13WorkerBuffers12init_buffersEi._omp_fn.0(%rip), %rdi	#, tmp374
# C/parallel-only-omp/state.h:247:         #pragma omp parallel for schedule(static)
	movq	%rbx, 16(%rsp)	# this, .omp_data_o.177.this
	movl	%r13d, 24(%rsp)	# num_threads, .omp_data_o.177.num_threads
	call	GOMP_parallel@PLT	#
	jmp	.L638	#
	.p2align 4
	.p2align 3
.L707:
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$131136, %rbp, %rax	#, _3, tmp375
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp375, _57
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _57, _50
	je	.L676	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 368(%rbx)	# _57, MEM[(struct vector *)this_21(D) + 360B].D.109241._M_impl.D.108580._M_finish
	jmp	.L676	#
	.p2align 4
	.p2align 3
.L664:
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	addq	$24, %r12	#, __first
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	cmpq	%r12, %r15	# __first, _82
	jne	.L667	#,
	jmp	.L666	#
	.p2align 4
	.p2align 3
.L692:
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	movq	%rbp, %rsi	# _3, tmp270
# C/parallel-only-omp/state.h:219:         i_density.resize(num_threads);
	leaq	24(%rbx), %rdi	#, tmp271
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp268, tmp270
	call	_ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm	#
	jmp	.L643	#
	.p2align 4
	.p2align 3
.L691:
	movq	%rbp, %rsi	# _3, tmp264
	subq	%rax, %rsi	# tmp262, tmp264
	call	_ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm	#
	jmp	.L641	#
	.p2align 4
	.p2align 3
.L699:
	movq	%rbp, %rsi	# _3, tmp317
# C/parallel-only-omp/state.h:228:         counter_i.resize(num_threads);
	leaq	192(%rbx), %rdi	#, tmp318
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp315, tmp317
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L657	#
	.p2align 4
	.p2align 3
.L701:
	movq	%rbp, %rsi	# _3, tmp331
# C/parallel-only-omp/state.h:230:         meanei.resize(num_threads);
	leaq	240(%rbx), %rdi	#, tmp332
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp329, tmp331
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L661	#
	.p2align 4
	.p2align 3
.L704:
	movq	%rbp, %rsi	# _3, tmp357
# C/parallel-only-omp/state.h:234:         local_ifed_gnd.resize(num_threads);
	leaq	312(%rbx), %rdi	#, tmp358
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp355, tmp357
	call	_ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm	#
	jmp	.L671	#
	.p2align 4
	.p2align 3
.L703:
	movq	%rbp, %rsi	# _3, tmp350
# C/parallel-only-omp/state.h:233:         local_ifed_pow.resize(num_threads);
	leaq	288(%rbx), %rdi	#, tmp351
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp348, tmp350
	call	_ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm	#
	jmp	.L669	#
	.p2align 4
	.p2align 3
.L706:
	movq	%rbp, %rsi	# _3, tmp371
# C/parallel-only-omp/state.h:237:         new_ions.resize(num_threads);
	leaq	360(%rbx), %rdi	#, tmp372
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp369, tmp371
	call	_ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm	#
	jmp	.L676	#
	.p2align 4
	.p2align 3
.L705:
	movq	%rbp, %rsi	# _3, tmp364
# C/parallel-only-omp/state.h:236:         new_electrons.resize(num_threads);
	leaq	336(%rbx), %rdi	#, tmp365
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp362, tmp364
	call	_ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm	#
	jmp	.L673	#
	.p2align 4
	.p2align 3
.L698:
	movq	%rbp, %rsi	# _3, tmp310
# C/parallel-only-omp/state.h:226:         thread_counters.resize(num_threads);
	leaq	168(%rbx), %rdi	#, tmp311
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp309, tmp310
	call	_ZNSt6vectorI21AlignedThreadCountersSaIS0_EE17_M_default_appendEm	#
	jmp	.L655	#
	.p2align 4
	.p2align 3
.L697:
	movq	%rbp, %rsi	# _3, tmp305
# C/parallel-only-omp/state.h:225:         eepf.resize(num_threads);
	leaq	144(%rbx), %rdi	#, tmp306
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp303, tmp305
	call	_ZNSt6vectorISt5arrayIdLm2000EESaIS1_EE17_M_default_appendEm	#
	jmp	.L653	#
	.p2align 4
	.p2align 3
.L702:
	movq	%rbp, %rsi	# _3, tmp338
# C/parallel-only-omp/state.h:232:         absorbed_indices.resize(num_threads);
	leaq	264(%rbx), %rdi	#, tmp339
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp336, tmp338
	call	_ZNSt6vectorIS_IiSaIiEESaIS1_EE17_M_default_appendEm	#
	jmp	.L663	#
	.p2align 4
	.p2align 3
.L700:
	movq	%rbp, %rsi	# _3, tmp324
# C/parallel-only-omp/state.h:229:         ui.resize(num_threads);
	leaq	216(%rbx), %rdi	#, tmp325
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp322, tmp324
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L659	#
	.p2align 4
	.p2align 3
.L694:
	movq	%rbp, %rsi	# _3, tmp284
# C/parallel-only-omp/state.h:222:         ue.resize(num_threads);
	leaq	72(%rbx), %rdi	#, tmp285
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp282, tmp284
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L647	#
	.p2align 4
	.p2align 3
.L693:
	movq	%rbp, %rsi	# _3, tmp277
# C/parallel-only-omp/state.h:221:         counter_e.resize(num_threads);
	leaq	48(%rbx), %rdi	#, tmp278
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp275, tmp277
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L645	#
	.p2align 4
	.p2align 3
.L696:
	movq	%rbp, %rsi	# _3, tmp298
# C/parallel-only-omp/state.h:224:         ioniz.resize(num_threads);
	leaq	120(%rbx), %rdi	#, tmp299
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp296, tmp298
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L651	#
	.p2align 4
	.p2align 3
.L695:
	movq	%rbp, %rsi	# _3, tmp291
# C/parallel-only-omp/state.h:223:         meanee.resize(num_threads);
	leaq	96(%rbx), %rdi	#, tmp292
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp289, tmp291
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L649	#
.L690:
# C/parallel-only-omp/state.h:254:     }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE9786:
	.size	_ZN13WorkerBuffers12init_buffersEi, .-_ZN13WorkerBuffers12init_buffersEi
	.section	.rodata._Z12do_one_cyclev.str1.1,"aMS",@progbits,1
.LC146:
	.string	"%8d  %8d  %8d\n"
	.section	.text._Z12do_one_cyclev,"axG",@progbits,_Z12do_one_cyclev,comdat
	.p2align 4
	.weak	_Z12do_one_cyclev
	.type	_Z12do_one_cyclev, @function
_Z12do_one_cyclev:
.LFB9890:
	.cfi_startproc
	endbr64	
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 16
# C/parallel-only-omp/simulation.h:874:     int num_threads = omp_get_max_threads();
	call	omp_get_max_threads@PLT	#
# C/parallel-only-omp/simulation.h:875:     worker_buffers.init_buffers(num_threads);
	leaq	worker_buffers(%rip), %rdi	#, tmp87
# C/parallel-only-omp/simulation.h:874:     int num_threads = omp_get_max_threads();
	movl	%eax, %esi	# tmp94, num_threads
# C/parallel-only-omp/simulation.h:875:     worker_buffers.init_buffers(num_threads);
	call	_ZN13WorkerBuffers12init_buffersEi	#
	xorl	%ecx, %ecx	#
	xorl	%edx, %edx	#
	xorl	%esi, %esi	#
	leaq	_Z12do_one_cyclev._omp_fn.0(%rip), %rdi	#, tmp88
	call	GOMP_parallel@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movl	N_i(%rip), %r9d	# N_i,
	movl	N_e(%rip), %r8d	# N_e,
	movl	cycle(%rip), %ecx	# cycle,
	movq	datafile(%rip), %rdi	# datafile,
	leaq	.LC146(%rip), %rdx	#, tmp93
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
# C/parallel-only-omp/simulation.h:923: }
	addq	$8, %rsp	#,
	.cfi_def_cfa_offset 8
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	jmp	__fprintf_chk@PLT	#
	.cfi_endproc
.LFE9890:
	.size	_Z12do_one_cyclev, .-_Z12do_one_cyclev
	.section	.rodata._ZNSt6vectorIiSaIiEE17_M_realloc_insertIJRKiEEEvN9__gnu_cxx17__normal_iteratorIPiS1_EEDpOT_.str1.1,"aMS",@progbits,1
.LC147:
	.string	"vector::_M_realloc_insert"
	.section	.text._ZNSt6vectorIiSaIiEE17_M_realloc_insertIJRKiEEEvN9__gnu_cxx17__normal_iteratorIPiS1_EEDpOT_,"axG",@progbits,_ZNSt6vectorIiSaIiEE17_M_realloc_insertIJRKiEEEvN9__gnu_cxx17__normal_iteratorIPiS1_EEDpOT_,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorIiSaIiEE17_M_realloc_insertIJRKiEEEvN9__gnu_cxx17__normal_iteratorIPiS1_EEDpOT_
	.type	_ZNSt6vectorIiSaIiEE17_M_realloc_insertIJRKiEEEvN9__gnu_cxx17__normal_iteratorIPiS1_EEDpOT_, @function
_ZNSt6vectorIiSaIiEE17_M_realloc_insertIJRKiEEEvN9__gnu_cxx17__normal_iteratorIPiS1_EEDpOT_:
.LFB10683:
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
	movabsq	$2305843009213693951, %rcx	#, tmp126
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
	movq	8(%rdi), %r12	# MEM[(int * *)this_18(D) + 8B], _49
	movq	(%rdi), %r13	# MEM[(int * *)this_18(D)], _48
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%r12, %rax	# _49, tmp124
	subq	%r13, %rax	# _48, tmp124
	sarq	$2, %rax	#, tmp125
# /usr/include/c++/13/bits/stl_vector.h:1898: 	if (max_size() - size() < __n)
	cmpq	%rcx, %rax	# tmp126, tmp125
	je	.L733	#,
# /usr/include/c++/13/bits/stl_iterator.h:1337:     { return __lhs.base() - __rhs.base(); }
	movq	%rsi, %r15	# __position, _98
	movq	%rdi, %rbp	# tmp150, this
	movq	%rsi, %r14	# tmp151, __position
	subq	%r13, %r15	# _48, _98
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	cmpq	%r12, %r13	# _49, _48
	je	.L734	#,
# /usr/include/c++/13/bits/stl_vector.h:1901: 	const size_type __len = size() + (std::max)(size(), __n);
	leaq	(%rax,%rax), %rcx	#, __len
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	cmpq	%rax, %rcx	# tmp125, __len
	jb	.L725	#,
# /usr/include/c++/13/bits/stl_vector.h:381: 	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
	testq	%rcx, %rcx	# __len
	jne	.L735	#,
	xorl	%ebx, %ebx	# _83
# /usr/include/c++/13/bits/stl_vector.h:381: 	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
	xorl	%edi, %edi	# iftmp.103_24
.L716:
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movl	(%rdx), %edx	# MEM[(const type &)__args#0_25(D)], MEM[(const type &)__args#0_25(D)]
# /usr/include/c++/13/bits/vector.tcc:483: 	      ++__new_finish;
	leaq	4(%rdi,%r15), %rcx	#, _92
# /usr/include/c++/13/bits/stl_uninitialized.h:1118:       ptrdiff_t __count = __last - __first;
	subq	%r14, %r12	# __position, _93
	vmovq	%rdi, %xmm1	# iftmp.103_24, iftmp.103_24
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movl	%edx, (%rdi,%r15)	# MEM[(const type &)__args#0_25(D)], *_2
# /usr/include/c++/13/bits/stl_uninitialized.h:1133:       return __result + __count;
	leaq	(%rcx,%r12), %rdx	#, tmp135
	vpinsrq	$1, %rdx, %xmm1, %xmm0	# tmp135, iftmp.103_24, _73
	vmovdqa	%xmm0, (%rsp)	# _73, %sfp
# /usr/include/c++/13/bits/stl_uninitialized.h:1119:       if (__count > 0)
	testq	%r15, %r15	# _98
	jg	.L736	#,
	testq	%r12, %r12	# _93
	jle	.L720	#,
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	%r12, %rdx	# _93,
	movq	%r14, %rsi	# __position,
	movq	%rcx, %rdi	# _92,
	call	memcpy@PLT	#
.L720:
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%r13, %r13	# _48
	jne	.L719	#,
.L722:
# /usr/include/c++/13/bits/vector.tcc:521:       this->_M_impl._M_start = __new_start;
	vmovdqa	(%rsp), %xmm2	# %sfp, _73
# /usr/include/c++/13/bits/vector.tcc:523:       this->_M_impl._M_end_of_storage = __new_start + __len;
	movq	%rbx, 16(%rbp)	# _83, this_18(D)->D.110314._M_impl.D.109653._M_end_of_storage
# /usr/include/c++/13/bits/vector.tcc:521:       this->_M_impl._M_start = __new_start;
	vmovdqu	%xmm2, 0(%rbp)	# _73, MEM <vector(2) long unsigned int> [(int * *)this_18(D)]
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
.L725:
	.cfi_restore_state
	movabsq	$9223372036854775804, %rbx	#, _80
.L715:
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rbx, %rdi	# _80,
	movq	%rdx, (%rsp)	# __args#0, %sfp
	call	_Znwm@PLT	#
	movq	(%rsp), %rdx	# %sfp, __args#0
	movq	%rax, %rdi	# tmp153, iftmp.103_24
# /usr/include/c++/13/bits/vector.tcc:523:       this->_M_impl._M_end_of_storage = __new_start + __len;
	addq	%rax, %rbx	# iftmp.103_24, _83
	jmp	.L716	#
	.p2align 4
	.p2align 3
.L736:
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	%r15, %rdx	# _98,
	movq	%r13, %rsi	# _48,
	movq	%rcx, 24(%rsp)	# _92, %sfp
	call	memmove@PLT	#
# /usr/include/c++/13/bits/stl_uninitialized.h:1119:       if (__count > 0)
	testq	%r12, %r12	# _93
	jg	.L737	#,
.L719:
# /usr/include/c++/13/bits/vector.tcc:520: 		    this->_M_impl._M_end_of_storage - __old_start);
	movq	16(%rbp), %rsi	# this_18(D)->D.110314._M_impl.D.109653._M_end_of_storage, _12
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%r13, %rdi	# _48,
# /usr/include/c++/13/bits/vector.tcc:520: 		    this->_M_impl._M_end_of_storage - __old_start);
	subq	%r13, %rsi	# _48, _12
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
	jmp	.L722	#
	.p2align 4
	.p2align 3
.L734:
	addq	$1, %rax	#, tmp128
	jc	.L725	#,
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$2305843009213693951, %rcx	#, tmp157
	cmpq	%rcx, %rax	# tmp157, tmp128
	movq	%rcx, %rbx	# tmp157, tmp157
	cmovbe	%rax, %rbx	# tmp128,, tmp157
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	salq	$2, %rbx	#, _80
	jmp	.L715	#
	.p2align 4
	.p2align 3
.L737:
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	24(%rsp), %rdi	# %sfp,
	movq	%r14, %rsi	# __position,
	movq	%r12, %rdx	# _93,
	call	memcpy@PLT	#
# /usr/include/c++/13/bits/vector.tcc:520: 		    this->_M_impl._M_end_of_storage - __old_start);
	movq	16(%rbp), %rsi	# this_18(D)->D.110314._M_impl.D.109653._M_end_of_storage, _12
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%r13, %rdi	# _48,
# /usr/include/c++/13/bits/vector.tcc:520: 		    this->_M_impl._M_end_of_storage - __old_start);
	subq	%r13, %rsi	# _48, _12
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
	jmp	.L722	#
.L735:
# /usr/include/c++/13/bits/stl_vector.h:1902: 	return (__len < size() || __len > max_size()) ? max_size() : __len;
	movabsq	$2305843009213693951, %rax	#, tmp156
	cmpq	%rax, %rcx	# tmp156, __len
	cmova	%rax, %rcx	# __len,, tmp156, tmp130
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	leaq	0(,%rcx,4), %rbx	#, _80
	jmp	.L715	#
.L733:
# /usr/include/c++/13/bits/stl_vector.h:1899: 	  __throw_length_error(__N(__s));
	leaq	.LC147(%rip), %rdi	#, tmp127
	call	_ZSt20__throw_length_errorPKc@PLT	#
	.cfi_endproc
.LFE10683:
	.size	_ZNSt6vectorIiSaIiEE17_M_realloc_insertIJRKiEEEvN9__gnu_cxx17__normal_iteratorIPiS1_EEDpOT_, .-_ZNSt6vectorIiSaIiEE17_M_realloc_insertIJRKiEEEvN9__gnu_cxx17__normal_iteratorIPiS1_EEDpOT_
	.section	.text._Z32step6_check_boundaries_ions_bodyiii,"axG",@progbits,_Z32step6_check_boundaries_ions_bodyiii,comdat
	.p2align 4
	.weak	_Z32step6_check_boundaries_ions_bodyiii
	.type	_Z32step6_check_boundaries_ions_bodyiii, @function
_Z32step6_check_boundaries_ions_bodyiii:
.LFB9883:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%r15	#
	pushq	%r14	#
	pushq	%r13	#
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
# C/parallel-only-omp/simulation.h:586:     if ((t % N_SUB) != 0) return;
	movslq	%edx, %r13	# t, t
# C/parallel-only-omp/simulation.h:585: PIC_STEP void step6_check_boundaries_ions_body(int tid, int num_threads, int t) {
	pushq	%r12	#
	pushq	%rbx	#
	andq	$-64, %rsp	#,
# C/parallel-only-omp/simulation.h:586:     if ((t % N_SUB) != 0) return;
	imulq	$1717986919, %r13, %r13	#, t, tmp326
# C/parallel-only-omp/simulation.h:585: PIC_STEP void step6_check_boundaries_ions_body(int tid, int num_threads, int t) {
	subq	$64, %rsp	#,
	.cfi_offset 12, -48
	.cfi_offset 3, -56
# C/parallel-only-omp/simulation.h:585: PIC_STEP void step6_check_boundaries_ions_body(int tid, int num_threads, int t) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp608
	movq	%rax, 56(%rsp)	# tmp608, D.133746
	xorl	%eax, %eax	# tmp608
# C/parallel-only-omp/simulation.h:586:     if ((t % N_SUB) != 0) return;
	movl	%edx, %eax	# t, tmp329
	sarl	$31, %eax	#, tmp329
	sarq	$35, %r13	#, tmp328
	subl	%eax, %r13d	# tmp329, stmp_total_abs_149.2025
	leal	0(%r13,%r13,4), %eax	#, tmp332
	sall	$2, %eax	#, tmp333
# C/parallel-only-omp/simulation.h:586:     if ((t % N_SUB) != 0) return;
	subl	%eax, %edx	# tmp333, t
	jne	.L738	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	264+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 264B].D.107139._M_impl.D.106478._M_start, _179
# C/parallel-only-omp/simulation.h:588:     worker_buffers.absorbed_indices[tid].clear();
	movslq	%edi, %r15	# tid, _2
	movl	%edx, %r13d	# t, stmp_total_abs_149.2025
	movl	%edi, %ebx	# tmp595, tid
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	leaq	(%r15,%r15,2), %rcx	#, tmp336
	movslq	%esi, %r12	# tmp596,
	salq	$3, %rcx	#, tmp337
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	%rcx, %rax	# tmp337, _179
# /usr/include/c++/13/bits/stl_vector.h:1606:       { _M_erase_at_end(this->_M_impl._M_start); }
	movq	(%rax), %rdx	# MEM[(struct vector *)_179].D.110314._M_impl.D.109653._M_start, _175
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	8(%rax), %rdx	# MEM[(struct vector *)_179].D.110314._M_impl.D.109653._M_finish, _175
	je	.L740	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 8(%rax)	# _175, MEM[(struct vector *)_179].D.110314._M_impl.D.109653._M_finish
.L740:
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	%r15, %r8	# _2, _173
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	288+worker_buffers(%rip), %rdi	# MEM[(struct vector *)&worker_buffers + 288B].D.108190._M_impl.D.107529._M_start, tmp343
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	imulq	$800, %r15, %r15	#, _2, _104
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
	movl	$800, %edx	#,
	movq	%rcx, 32(%rsp)	# tmp337, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	salq	$6, %r8	#, _173
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	%r8, %rax	# _173, _174
	addq	168+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, _174
	movq	%r8, 40(%rsp)	# _173, %sfp
	addq	%r15, %rdi	# _104, tmp343
# C/parallel-only-omp/simulation.h:589:     worker_buffers.thread_counters[tid].local_abs_pow = 0;
	movq	$0, 16(%rax)	#, _174->local_abs_pow
# C/parallel-only-omp/simulation.h:590:     worker_buffers.thread_counters[tid].local_abs_gnd = 0;
	movq	$0, 24(%rax)	#, _174->local_abs_gnd
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	312+worker_buffers(%rip), %rdi	# MEM[(struct vector *)&worker_buffers + 312B].D.108190._M_impl.D.107529._M_start, tmp351
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
	movl	$800, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	%r15, %rdi	# _104, tmp351
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
# C/parallel-only-omp/simulation.h:594:     int chunk = (N_i + num_threads - 1) / num_threads;
	movl	N_i(%rip), %esi	# N_i, N_i.107_4
# C/parallel-only-omp/simulation.h:598:     for (int k = k_start; k < k_end; k++) {
	movq	40(%rsp), %r8	# %sfp, _173
	movq	32(%rsp), %rcx	# %sfp, tmp337
	leaq	x_i(%rip), %r9	#, tmp570
# C/parallel-only-omp/simulation.h:608:         } else if (__builtin_expect(x_i[k] > L, 0)) {
	vmovsd	.LC81(%rip), %xmm2	#, tmp594
# C/parallel-only-omp/simulation.h:594:     int chunk = (N_i + num_threads - 1) / num_threads;
	leal	-1(%rsi,%r12), %eax	#, tmp359
# C/parallel-only-omp/simulation.h:594:     int chunk = (N_i + num_threads - 1) / num_threads;
	cltd
	idivl	%r12d	# num_threads
# C/parallel-only-omp/simulation.h:595:     int k_start = std::min(tid * chunk, N_i);
	imull	%eax, %ebx	# tmp360, tid
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%esi, %ebx	# N_i.107_4, tmp362
# C/parallel-only-omp/simulation.h:595:     int k_start = std::min(tid * chunk, N_i);
	movl	%ebx, %edx	# tid, tmp362
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmovg	%esi, %edx	# tmp362,, N_i.107_4, _96
# C/parallel-only-omp/simulation.h:596:     int k_end = std::min(k_start + chunk, N_i);
	addl	%edx, %eax	# _96, tmp363
	movslq	%edx, %rbx	# _96, ivtmp.2090
# C/parallel-only-omp/simulation.h:598:     for (int k = k_start; k < k_end; k++) {
	movl	%edx, 52(%rsp)	# _96, k
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%esi, %eax	# N_i.107_4, tmp363
	cmovg	%esi, %eax	# tmp363,, N_i.107_4, _99
# C/parallel-only-omp/simulation.h:598:     for (int k = k_start; k < k_end; k++) {
	cmpl	%eax, %edx	# _99, _96
	jge	.L755	#,
	.p2align 4
	.p2align 3
.L754:
# C/parallel-only-omp/simulation.h:600:         if (__builtin_expect(x_i[k] < 0.0, 0)) {
	vmovsd	(%r9,%rbx,8), %xmm0	# MEM[(double *)&x_i + ivtmp.2090_430 * 8], _9
# C/parallel-only-omp/simulation.h:600:         if (__builtin_expect(x_i[k] < 0.0, 0)) {
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp371
	movl	%ebx, %r14d	# ivtmp.2090, _436
	vcomisd	%xmm0, %xmm1	# _9, tmp371
	ja	.L792	#,
# C/parallel-only-omp/simulation.h:608:         } else if (__builtin_expect(x_i[k] > L, 0)) {
	vcomisd	%xmm2, %xmm0	# tmp594, _9
	ja	.L793	#,
.L749:
# C/parallel-only-omp/simulation.h:598:     for (int k = k_start; k < k_end; k++) {
	incl	%r14d	# tmp401
# C/parallel-only-omp/simulation.h:598:     for (int k = k_start; k < k_end; k++) {
	incq	%rbx	# ivtmp.2090
# C/parallel-only-omp/simulation.h:598:     for (int k = k_start; k < k_end; k++) {
	movl	%r14d, 52(%rsp)	# tmp401, k
# C/parallel-only-omp/simulation.h:598:     for (int k = k_start; k < k_end; k++) {
	cmpl	%ebx, %eax	# ivtmp.2090, _99
	jg	.L754	#,
.L755:
# C/parallel-only-omp/simulation.h:619:     #pragma omp barrier
	call	GOMP_barrier@PLT	#
	call	omp_get_num_threads@PLT	#
	movl	%eax, %ebx	# tmp598, _114
	call	omp_get_thread_num@PLT	#
	xorl	%edx, %edx	# tt.132_80
	movl	%eax, %ecx	# tmp599, _115
	movl	$200, %eax	#, q.131_79
	idivl	%ebx	# _114
	cmpl	%edx, %ecx	# tt.132_80, _115
	jl	.L794	#,
	imull	%eax, %ecx	# q.131_79, tmp402
	addl	%ecx, %edx	# tmp402, _120
	leal	(%rax,%rdx), %ecx	#, tmp403
	cmpl	%ecx, %edx	# tmp403, _120
	jge	.L762	#,
.L756:
	movslq	%r12d, %rsi	# num_threads, num_threads
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	288+worker_buffers(%rip), %r8	# MEM[(struct vector *)&worker_buffers + 288B].D.108190._M_impl.D.107529._M_start, _194
	movq	312+worker_buffers(%rip), %rdi	# MEM[(struct vector *)&worker_buffers + 312B].D.108190._M_impl.D.107529._M_start, _192
	movslq	%edx, %rdx	# _120, _361
	movl	%eax, %r10d	# q.131_79, q.131_79
	leaq	0(,%rdx,4), %r9	#, ivtmp.2085
	imulq	$200, %rsi, %rsi	#, num_threads, tmp407
	addq	%rdx, %r10	# _361, tmp410
	leaq	ifed_pow(%rip), %rbx	#, tmp568
	leaq	ifed_gnd(%rip), %r11	#, tmp569
	salq	$2, %r10	#, _429
	addq	%rdx, %rsi	# _361, tmp408
	salq	$2, %rsi	#, ivtmp.2086
	.p2align 4
	.p2align 3
.L761:
# C/parallel-only-omp/simulation.h:624:         for (int t2 = 0; t2 < num_threads; ++t2) {
	testl	%r12d, %r12d	# num_threads
	jle	.L775	#,
	movq	%r9, %rax	# ivtmp.2085, ivtmp.2076
# C/parallel-only-omp/simulation.h:623:         int sum_pow = 0, sum_gnd = 0;
	xorl	%edx, %edx	# sum_gnd
# C/parallel-only-omp/simulation.h:623:         int sum_pow = 0, sum_gnd = 0;
	xorl	%ecx, %ecx	# sum_pow
	.p2align 4
	.p2align 3
.L760:
# C/parallel-only-omp/simulation.h:625:             sum_pow += worker_buffers.local_ifed_pow[t2][e];
	addl	(%r8,%rax), %ecx	# MEM[(value_type &)_194 + ivtmp.2076_237 * 1], sum_pow
# C/parallel-only-omp/simulation.h:626:             sum_gnd += worker_buffers.local_ifed_gnd[t2][e];
	addl	(%rdi,%rax), %edx	# MEM[(value_type &)_192 + ivtmp.2076_237 * 1], sum_gnd
# C/parallel-only-omp/simulation.h:624:         for (int t2 = 0; t2 < num_threads; ++t2) {
	addq	$800, %rax	#, ivtmp.2076
	cmpq	%rsi, %rax	# ivtmp.2086, ivtmp.2076
	jne	.L760	#,
.L759:
# C/parallel-only-omp/simulation.h:628:         ifed_pow[e] += sum_pow;
	addl	%ecx, (%rbx,%r9)	# sum_pow, MEM[(int *)&ifed_pow + ivtmp.2085_358 * 1]
# C/parallel-only-omp/simulation.h:629:         ifed_gnd[e] += sum_gnd;
	addl	%edx, (%r11,%r9)	# sum_gnd, MEM[(int *)&ifed_gnd + ivtmp.2085_358 * 1]
	addq	$4, %r9	#, ivtmp.2085
	addq	$4, %rsi	#, ivtmp.2086
	cmpq	%r10, %r9	# _429, ivtmp.2085
	jne	.L761	#,
.L762:
	call	GOMP_single_start@PLT	#
	testb	%al, %al	# tmp600
	je	.L763	#,
# C/parallel-only-omp/simulation.h:635:         for (int t2 = 0; t2 < num_threads; ++t2) {
	testl	%r12d, %r12d	# num_threads
	jle	.L763	#,
	leal	-1(%r12), %ecx	#, _321
	vmovq	N_i_abs_pow(%rip), %xmm9	# N_i_abs_pow, tmp602
	vmovq	N_i_abs_gnd(%rip), %xmm8	# N_i_abs_gnd, tmp603
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	168+worker_buffers(%rip), %rdx	# MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, _197
	cmpl	$39, %ecx	#, _321
	jbe	.L776	#,
	vmovdqa64	.LC149(%rip), %zmm0	#, tmp567
	vmovdqa64	.LC150(%rip), %zmm4	#, tmp571
	movl	%ecx, %esi	# _321, bnd.1994
	movq	%rdx, %rax	# _197, ivtmp.2068
	shrl	$4, %esi	#,
	vmovdqa32	.LC151(%rip), %zmm13	#, tmp572
	vpxor	%xmm12, %xmm12, %xmm12	# vect__59.2028
	salq	$10, %rsi	#, tmp432
	vmovdqa64	%zmm12, %zmm11	#, vect__57.2026
	addq	%rdx, %rsi	# _197, _50
	vpxor	%xmm10, %xmm10, %xmm10	# vect_total_abs_149.2024
	.p2align 4
	.p2align 3
.L765:
# C/parallel-only-omp/simulation.h:636:             total_abs += worker_buffers.thread_counters[t2].local_abs_pow + worker_buffers.thread_counters[t2].local_abs_gnd;
	vmovdqu64	16(%rax), %zmm5	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 16B], tmp441
	vmovdqu64	144(%rax), %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 144B], tmp443
	addq	$1024, %rax	#, ivtmp.2068
	vmovdqu64	-624(%rax), %zmm2	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 400B], tmp449
	vmovdqu64	-624(%rax), %zmm3	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 400B], tmp462
	vmovdqu64	-112(%rax), %zmm6	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 912B], tmp483
	vmovdqu64	-112(%rax), %zmm7	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 912B], tmp496
	vpermt2q	-816(%rax), %zmm0, %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 208B], tmp567, tmp443
	vpermt2q	-944(%rax), %zmm0, %zmm5	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 80B], tmp567, tmp441
	vpermt2q	%zmm1, %zmm0, %zmm5	# tmp443, tmp567, tmp445
	vmovdqu64	-752(%rax), %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 272B], tmp447
	vpermt2q	-560(%rax), %zmm0, %zmm2	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 464B], tmp567, tmp449
	vpermt2q	-560(%rax), %zmm4, %zmm3	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 464B], tmp571, tmp462
	vpermt2q	-48(%rax), %zmm0, %zmm6	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 976B], tmp567, tmp483
	vpermt2q	-48(%rax), %zmm4, %zmm7	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 976B], tmp571, tmp496
	vpermt2q	-688(%rax), %zmm0, %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 336B], tmp567, tmp447
	vpermt2q	%zmm2, %zmm0, %zmm1	# tmp449, tmp567, tmp451
	vmovdqu64	-1008(%rax), %zmm2	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 16B], tmp454
	vpermt2q	%zmm1, %zmm0, %zmm5	# tmp451, tmp567, vect_perm_even_273
	vmovdqu64	-880(%rax), %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 144B], tmp456
	vpermt2q	-944(%rax), %zmm4, %zmm2	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 80B], tmp571, tmp454
	vpermt2q	-816(%rax), %zmm4, %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 208B], tmp571, tmp456
	vpermt2q	%zmm1, %zmm0, %zmm2	# tmp456, tmp567, tmp458
	vmovdqu64	-752(%rax), %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 272B], tmp460
	vpermt2q	-688(%rax), %zmm4, %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 336B], tmp571, tmp460
	vpermt2q	%zmm3, %zmm0, %zmm1	# tmp462, tmp567, tmp464
	vmovdqu64	-496(%rax), %zmm3	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 528B], tmp475
	vpermt2q	%zmm1, %zmm0, %zmm2	# tmp464, tmp567, vect_perm_even_271
	vmovdqu64	-368(%rax), %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 656B], tmp477
	vpermt2q	-432(%rax), %zmm0, %zmm3	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 592B], tmp567, tmp475
	vpermt2q	-304(%rax), %zmm0, %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 720B], tmp567, tmp477
	vpermt2q	%zmm1, %zmm0, %zmm3	# tmp477, tmp567, tmp479
	vmovdqu64	-240(%rax), %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 784B], tmp481
	vpermt2q	-176(%rax), %zmm0, %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 848B], tmp567, tmp481
	vpermt2q	%zmm6, %zmm0, %zmm1	# tmp483, tmp567, tmp485
	vmovdqu64	-368(%rax), %zmm6	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 656B], tmp490
	vpermt2q	%zmm1, %zmm0, %zmm3	# tmp485, tmp567, vect_perm_even_68
	vmovdqu64	-496(%rax), %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 528B], tmp488
	vpermt2q	-304(%rax), %zmm4, %zmm6	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 720B], tmp571, tmp490
	vpermt2q	-432(%rax), %zmm4, %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 592B], tmp571, tmp488
	vpermt2q	%zmm6, %zmm0, %zmm1	# tmp490, tmp567, tmp492
	vmovdqu64	-240(%rax), %zmm6	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 784B], tmp494
	vpermt2q	-176(%rax), %zmm4, %zmm6	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_10 + 848B], tmp571, tmp494
	vpermt2q	%zmm7, %zmm0, %zmm6	# tmp496, tmp567, tmp498
# C/parallel-only-omp/simulation.h:636:             total_abs += worker_buffers.thread_counters[t2].local_abs_pow + worker_buffers.thread_counters[t2].local_abs_gnd;
	vmovdqa32	%zmm5, %zmm7	# vect_perm_even_273, vect_patt_247.2018
# C/parallel-only-omp/simulation.h:636:             total_abs += worker_buffers.thread_counters[t2].local_abs_pow + worker_buffers.thread_counters[t2].local_abs_gnd;
	vpermt2q	%zmm6, %zmm0, %zmm1	# tmp498, tmp567, vect_perm_even_12
# C/parallel-only-omp/simulation.h:636:             total_abs += worker_buffers.thread_counters[t2].local_abs_pow + worker_buffers.thread_counters[t2].local_abs_gnd;
	vmovdqa32	%zmm2, %zmm6	# vect_perm_even_271, vect_patt_374.2019
	vpermt2d	%zmm3, %zmm13, %zmm7	# vect_perm_even_68, tmp572, vect_patt_247.2018
# C/parallel-only-omp/simulation.h:637:             N_i_abs_pow += worker_buffers.thread_counters[t2].local_abs_pow;
	vpaddq	%zmm5, %zmm3, %zmm3	# vect_perm_even_273, vect_perm_even_68, tmp507
	vpaddq	%zmm3, %zmm11, %zmm11	# tmp507, vect__57.2026, vect__57.2026
# C/parallel-only-omp/simulation.h:636:             total_abs += worker_buffers.thread_counters[t2].local_abs_pow + worker_buffers.thread_counters[t2].local_abs_gnd;
	vpermt2d	%zmm1, %zmm13, %zmm6	# vect_perm_even_12, tmp572, vect_patt_374.2019
# C/parallel-only-omp/simulation.h:638:             N_i_abs_gnd += worker_buffers.thread_counters[t2].local_abs_gnd;
	vpaddq	%zmm2, %zmm1, %zmm1	# vect_perm_even_271, vect_perm_even_12, tmp508
# C/parallel-only-omp/simulation.h:636:             total_abs += worker_buffers.thread_counters[t2].local_abs_pow + worker_buffers.thread_counters[t2].local_abs_gnd;
	vpaddd	%zmm7, %zmm6, %zmm6	# vect_patt_247.2018, vect_patt_374.2019, vect_patt_365.2020
# C/parallel-only-omp/simulation.h:638:             N_i_abs_gnd += worker_buffers.thread_counters[t2].local_abs_gnd;
	vpaddq	%zmm1, %zmm12, %zmm12	# tmp508, vect__59.2028, vect__59.2028
# C/parallel-only-omp/simulation.h:636:             total_abs += worker_buffers.thread_counters[t2].local_abs_pow + worker_buffers.thread_counters[t2].local_abs_gnd;
	vpaddd	%zmm10, %zmm6, %zmm10	# vect_total_abs_149.2024, vect_patt_365.2020, vect_total_abs_149.2024
	cmpq	%rsi, %rax	# _50, ivtmp.2068
	jne	.L765	#,
	vmovdqa	%ymm12, %ymm1	# vect__59.2028, tmp509
	vextracti64x4	$0x1, %zmm12, %ymm12	# vect__59.2028, tmp510
	andl	$-16, %ecx	#, tmp.1996
	vpaddq	%ymm12, %ymm1, %ymm1	# tmp510, tmp509, _411
	vmovdqa	%xmm1, %xmm0	# _411, tmp511
	vextracti64x2	$0x1, %ymm1, %xmm1	# _411, tmp512
	vpaddq	%xmm1, %xmm0, %xmm0	# tmp512, tmp511, _414
	vpsrldq	$8, %xmm0, %xmm1	#, _414, tmp514
	vpaddq	%xmm1, %xmm0, %xmm0	# tmp514, _414, tmp515
	vmovdqa	%ymm11, %ymm1	# vect__57.2026, tmp517
	vextracti64x4	$0x1, %zmm11, %ymm11	# vect__57.2026, tmp518
	vpaddq	%ymm11, %ymm1, %ymm1	# tmp518, tmp517, _398
	vpaddq	%xmm0, %xmm8, %xmm8	# stmp__59.2029, N_i_abs_gnd_lsm.1990, N_i_abs_gnd_lsm.1990
	vmovdqa	%xmm1, %xmm0	# _398, tmp519
	vextracti64x2	$0x1, %ymm1, %xmm1	# _398, tmp520
	vpaddq	%xmm1, %xmm0, %xmm0	# tmp520, tmp519, _401
	vpsrldq	$8, %xmm0, %xmm1	#, _401, tmp522
	vpaddq	%xmm1, %xmm0, %xmm0	# tmp522, _401, tmp523
	vmovdqa	%ymm10, %ymm1	# vect_total_abs_149.2024, tmp525
	vextracti32x8	$0x1, %zmm10, %ymm10	# vect_total_abs_149.2024, tmp526
	vpaddd	%ymm10, %ymm1, %ymm1	# tmp526, tmp525, _384
	vpaddq	%xmm0, %xmm9, %xmm9	# stmp__57.2027, N_i_abs_pow_lsm.1989, N_i_abs_pow_lsm.1989
	vmovdqa	%xmm1, %xmm0	# _384, tmp527
	vextracti128	$0x1, %ymm1, %xmm1	# _384, tmp528
	vpaddd	%xmm1, %xmm0, %xmm0	# tmp528, tmp527, _387
	vpsrldq	$8, %xmm0, %xmm1	#, _387, tmp530
	vpaddd	%xmm1, %xmm0, %xmm0	# tmp530, _387, _389
	vpsrldq	$4, %xmm0, %xmm1	#, _389, tmp532
	vpaddd	%xmm1, %xmm0, %xmm0	# tmp532, _389, tmp533
	vmovd	%xmm0, %r13d	# tmp533, stmp_total_abs_149.2025
	vzeroupper
.L764:
	movslq	%ecx, %rax	# tmp.1996, tmp.1996
	salq	$6, %rax	#, tmp535
	addq	%rdx, %rax	# _197, ivtmp.2056
	.p2align 4
	.p2align 3
.L766:
# C/parallel-only-omp/simulation.h:636:             total_abs += worker_buffers.thread_counters[t2].local_abs_pow + worker_buffers.thread_counters[t2].local_abs_gnd;
	vmovq	16(%rax), %xmm1	# MEM[(long long unsigned int *)_52 + 16B], tmp604
# C/parallel-only-omp/simulation.h:636:             total_abs += worker_buffers.thread_counters[t2].local_abs_pow + worker_buffers.thread_counters[t2].local_abs_gnd;
	vmovq	24(%rax), %xmm0	# MEM[(long long unsigned int *)_52 + 24B], tmp605
# C/parallel-only-omp/simulation.h:635:         for (int t2 = 0; t2 < num_threads; ++t2) {
	incl	%ecx	# tmp.1996
# C/parallel-only-omp/simulation.h:635:         for (int t2 = 0; t2 < num_threads; ++t2) {
	addq	$64, %rax	#, ivtmp.2056
# C/parallel-only-omp/simulation.h:636:             total_abs += worker_buffers.thread_counters[t2].local_abs_pow + worker_buffers.thread_counters[t2].local_abs_gnd;
	vpaddq	%xmm1, %xmm0, %xmm2	# _336, _335, tmp601
# C/parallel-only-omp/simulation.h:637:             N_i_abs_pow += worker_buffers.thread_counters[t2].local_abs_pow;
	vpaddq	%xmm1, %xmm9, %xmm9	# _336, N_i_abs_pow_lsm.1989, N_i_abs_pow_lsm.1989
# C/parallel-only-omp/simulation.h:638:             N_i_abs_gnd += worker_buffers.thread_counters[t2].local_abs_gnd;
	vpaddq	%xmm0, %xmm8, %xmm8	# _335, N_i_abs_gnd_lsm.1990, N_i_abs_gnd_lsm.1990
# C/parallel-only-omp/simulation.h:636:             total_abs += worker_buffers.thread_counters[t2].local_abs_pow + worker_buffers.thread_counters[t2].local_abs_gnd;
	vmovq	%xmm2, %r9	# tmp601, tmp536
# C/parallel-only-omp/simulation.h:636:             total_abs += worker_buffers.thread_counters[t2].local_abs_pow + worker_buffers.thread_counters[t2].local_abs_gnd;
	addl	%r13d, %r9d	# stmp_total_abs_149.2025, _331
	movl	%r9d, %r13d	# _331, stmp_total_abs_149.2025
# C/parallel-only-omp/simulation.h:635:         for (int t2 = 0; t2 < num_threads; ++t2) {
	cmpl	%ecx, %r12d	# tmp.1996, num_threads
	jg	.L766	#,
	vmovq	%xmm9, N_i_abs_pow(%rip)	# N_i_abs_pow_lsm.1989, N_i_abs_pow
	vmovq	%xmm8, N_i_abs_gnd(%rip)	# N_i_abs_gnd_lsm.1990, N_i_abs_gnd
# C/parallel-only-omp/simulation.h:641:         if (total_abs > 0) {
	testl	%r9d, %r9d	# stmp_total_abs_149.2025
	jle	.L763	#,
# C/parallel-only-omp/simulation.h:642:             int last_valid = N_i - 1;
	movl	N_i(%rip), %ebx	# N_i, N_i.127_60
	movq	264+worker_buffers(%rip), %r11	# MEM[(struct vector *)&worker_buffers + 264B].D.107139._M_impl.D.106478._M_start, ivtmp.2047
	leaq	(%r12,%r12,2), %rdx	#, tmp541
	leaq	x_i(%rip), %rdi	#, tmp583
# C/parallel-only-omp/simulation.h:650:                         vx_i[dead_idx] = vx_i[last_valid];
	leaq	vx_i(%rip), %r14	#, tmp586
# C/parallel-only-omp/simulation.h:651:                         vy_i[dead_idx] = vy_i[last_valid];
	leaq	vy_i(%rip), %r13	#, tmp587
# C/parallel-only-omp/simulation.h:645:                     while (last_valid > dead_idx && (x_i[last_valid] < 0.0 || x_i[last_valid] > L)) {
	vmovsd	.LC81(%rip), %xmm2	#, tmp584
# C/parallel-only-omp/simulation.h:652:                         vz_i[dead_idx] = vz_i[last_valid];
	leaq	vz_i(%rip), %r10	#, tmp588
# C/parallel-only-omp/simulation.h:642:             int last_valid = N_i - 1;
	leal	-1(%rbx), %eax	#, last_valid
	leaq	(%r11,%rdx,8), %r12	#, _153
	.p2align 4
	.p2align 3
.L772:
# /usr/include/c++/13/bits/stl_iterator.h:1077:       : _M_current(__i) { }
	movq	(%r11), %rsi	# MEM[(int * const &)_3], _201
	movq	8(%r11), %r8	# MEM[(int * const &)_3 + 8], _200
# C/parallel-only-omp/simulation.h:644:                 for (int dead_idx : worker_buffers.absorbed_indices[t2]) {
	cmpq	%rsi, %r8	# _201, _200
	je	.L767	#,
# C/parallel-only-omp/simulation.h:645:                     while (last_valid > dead_idx && (x_i[last_valid] < 0.0 || x_i[last_valid] > L)) {
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp577
	.p2align 4
	.p2align 3
.L771:
# C/parallel-only-omp/simulation.h:644:                 for (int dead_idx : worker_buffers.absorbed_indices[t2]) {
	movslq	(%rsi), %rcx	# MEM[(int &)_421],
# C/parallel-only-omp/simulation.h:645:                     while (last_valid > dead_idx && (x_i[last_valid] < 0.0 || x_i[last_valid] > L)) {
	cmpl	%eax, %ecx	# last_valid, dead_idx
	jge	.L768	#,
	movslq	%eax, %rdx	# last_valid, last_valid
	leaq	(%rdi,%rdx,8), %rdx	#, ivtmp.2038
	.p2align 4
	.p2align 3
.L769:
# C/parallel-only-omp/simulation.h:645:                     while (last_valid > dead_idx && (x_i[last_valid] < 0.0 || x_i[last_valid] > L)) {
	vmovsd	(%rdx), %xmm0	# MEM[(double *)_349], _62
# C/parallel-only-omp/simulation.h:645:                     while (last_valid > dead_idx && (x_i[last_valid] < 0.0 || x_i[last_valid] > L)) {
	vcomisd	%xmm0, %xmm1	# _62, tmp577
	ja	.L770	#,
# C/parallel-only-omp/simulation.h:645:                     while (last_valid > dead_idx && (x_i[last_valid] < 0.0 || x_i[last_valid] > L)) {
	vcomisd	%xmm2, %xmm0	# tmp584, _62
	jbe	.L795	#,
.L770:
# C/parallel-only-omp/simulation.h:646:                         last_valid--;
	decl	%eax	# last_valid
# C/parallel-only-omp/simulation.h:645:                     while (last_valid > dead_idx && (x_i[last_valid] < 0.0 || x_i[last_valid] > L)) {
	subq	$8, %rdx	#, ivtmp.2038
	cmpl	%eax, %ecx	# last_valid, dead_idx
	jne	.L769	#,
.L768:
# C/parallel-only-omp/simulation.h:644:                 for (int dead_idx : worker_buffers.absorbed_indices[t2]) {
	addq	$4, %rsi	#, ivtmp.2043
	cmpq	%r8, %rsi	# _200, ivtmp.2043
	jne	.L771	#,
.L767:
# C/parallel-only-omp/simulation.h:643:             for (int t2 = 0; t2 < num_threads; t2++) {
	addq	$24, %r11	#, ivtmp.2047
	cmpq	%r11, %r12	# ivtmp.2047, _153
	jne	.L772	#,
# C/parallel-only-omp/simulation.h:657:             N_i -= total_abs;
	subl	%r9d, %ebx	# _331, tmp564
	movl	%ebx, N_i(%rip)	# tmp564, N_i
.L763:
	movq	56(%rsp), %rax	# D.133746, tmp609
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp609
	jne	.L791	#,
# C/parallel-only-omp/simulation.h:660: }
	leaq	-40(%rbp), %rsp	#,
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	jmp	GOMP_barrier@PLT	#
.L792:
	.cfi_restore_state
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	264+worker_buffers(%rip), %rdi	# MEM[(struct vector *)&worker_buffers + 264B].D.107139._M_impl.D.106478._M_start, _181
	addq	%rcx, %rdi	# tmp337, _181
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	movq	8(%rdi), %rsi	# MEM[(struct vector *)_181].D.110314._M_impl.D.109653._M_finish, _214
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	16(%rdi), %rsi	# MEM[(struct vector *)_181].D.110314._M_impl.D.109653._M_end_of_storage, _214
	je	.L746	#,
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movl	%ebx, (%rsi)	# ivtmp.2090, *_214
# /usr/include/c++/13/bits/stl_vector.h:1288: 	    ++this->_M_impl._M_finish;
	addq	$4, %rsi	#, tmp374
	movq	%rsi, 8(%rdi)	# tmp374, MEM[(struct vector *)_181].D.110314._M_impl.D.109653._M_finish
.L747:
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	168+worker_buffers(%rip), %rdx	# MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, _183
	addq	%r8, %rdx	# _173, _183
# C/parallel-only-omp/simulation.h:602:             worker_buffers.thread_counters[tid].local_abs_pow++;
	incq	16(%rdx)	# _183->local_abs_pow
# C/parallel-only-omp/simulation.h:603:             double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	leaq	vx_i(%rip), %rdx	#, tmp378
	vmovsd	(%rdx,%rbx,8), %xmm0	# MEM[(double *)&vx_i + ivtmp.2090_430 * 8], _15
# C/parallel-only-omp/simulation.h:603:             double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	leaq	vy_i(%rip), %rdx	#, tmp379
	vmovsd	(%rdx,%rbx,8), %xmm1	# MEM[(double *)&vy_i + ivtmp.2090_430 * 8], _17
# C/parallel-only-omp/simulation.h:603:             double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmulsd	%xmm1, %xmm1, %xmm1	# _17, _17, tmp380
# C/parallel-only-omp/simulation.h:603:             double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd231sd	%xmm0, %xmm0, %xmm1	# _15, _15, _19
# C/parallel-only-omp/simulation.h:603:             double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	leaq	vz_i(%rip), %rdx	#, tmp381
	vmovsd	(%rdx,%rbx,8), %xmm0	# MEM[(double *)&vz_i + ivtmp.2090_430 * 8], _20
# C/parallel-only-omp/simulation.h:603:             double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# _20, _19, v_sqr
# C/parallel-only-omp/simulation.h:604:             int energy_index = (int)(v_sqr * FACTOR_ENERGY_IFED);
	vmulsd	.LC148(%rip), %xmm0, %xmm0	#, v_sqr, tmp382
# C/parallel-only-omp/simulation.h:604:             int energy_index = (int)(v_sqr * FACTOR_ENERGY_IFED);
	vcvttsd2sil	%xmm0, %edx	# tmp382, energy_index
# C/parallel-only-omp/simulation.h:605:             if (energy_index < N_IFED) {
	cmpl	$199, %edx	#, energy_index
	jg	.L749	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	288+worker_buffers(%rip), %rsi	# MEM[(struct vector *)&worker_buffers + 288B].D.108190._M_impl.D.107529._M_start, _185
# C/parallel-only-omp/simulation.h:606:                 worker_buffers.local_ifed_pow[tid][energy_index]++;
	movslq	%edx, %rdx	# energy_index, _23
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	%r15, %rsi	# _104, _185
# C/parallel-only-omp/simulation.h:606:                 worker_buffers.local_ifed_pow[tid][energy_index]++;
	incl	(%rsi,%rdx,4)	#* _185
	jmp	.L749	#
.L793:
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	264+worker_buffers(%rip), %rdi	# MEM[(struct vector *)&worker_buffers + 264B].D.107139._M_impl.D.106478._M_start, _187
	addq	%rcx, %rdi	# tmp337, _187
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	movq	8(%rdi), %rsi	# MEM[(struct vector *)_187].D.110314._M_impl.D.109653._M_finish, _218
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	16(%rdi), %rsi	# MEM[(struct vector *)_187].D.110314._M_impl.D.109653._M_end_of_storage, _218
	je	.L752	#,
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movl	%ebx, (%rsi)	# ivtmp.2090, *_218
# /usr/include/c++/13/bits/stl_vector.h:1288: 	    ++this->_M_impl._M_finish;
	addq	$4, %rsi	#, tmp389
	movq	%rsi, 8(%rdi)	# tmp389, MEM[(struct vector *)_187].D.110314._M_impl.D.109653._M_finish
.L753:
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	168+worker_buffers(%rip), %rdx	# MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, _189
	addq	%r8, %rdx	# _173, _189
# C/parallel-only-omp/simulation.h:610:             worker_buffers.thread_counters[tid].local_abs_gnd++;
	incq	24(%rdx)	# _189->local_abs_gnd
# C/parallel-only-omp/simulation.h:611:             double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	leaq	vx_i(%rip), %rdx	#, tmp393
	vmovsd	(%rdx,%rbx,8), %xmm0	# MEM[(double *)&vx_i + ivtmp.2090_430 * 8], _31
# C/parallel-only-omp/simulation.h:611:             double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	leaq	vy_i(%rip), %rdx	#, tmp394
	vmovsd	(%rdx,%rbx,8), %xmm1	# MEM[(double *)&vy_i + ivtmp.2090_430 * 8], _33
# C/parallel-only-omp/simulation.h:611:             double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmulsd	%xmm1, %xmm1, %xmm1	# _33, _33, tmp395
# C/parallel-only-omp/simulation.h:611:             double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd231sd	%xmm0, %xmm0, %xmm1	# _31, _31, _35
# C/parallel-only-omp/simulation.h:611:             double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	leaq	vz_i(%rip), %rdx	#, tmp396
	vmovsd	(%rdx,%rbx,8), %xmm0	# MEM[(double *)&vz_i + ivtmp.2090_430 * 8], _36
# C/parallel-only-omp/simulation.h:611:             double v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# _36, _35, v_sqr
# C/parallel-only-omp/simulation.h:612:             int energy_index = (int)(v_sqr * FACTOR_ENERGY_IFED);
	vmulsd	.LC148(%rip), %xmm0, %xmm0	#, v_sqr, tmp397
# C/parallel-only-omp/simulation.h:612:             int energy_index = (int)(v_sqr * FACTOR_ENERGY_IFED);
	vcvttsd2sil	%xmm0, %edx	# tmp397, energy_index
# C/parallel-only-omp/simulation.h:613:             if (energy_index < N_IFED) {
	cmpl	$199, %edx	#, energy_index
	jg	.L749	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	312+worker_buffers(%rip), %rsi	# MEM[(struct vector *)&worker_buffers + 312B].D.108190._M_impl.D.107529._M_start, _191
# C/parallel-only-omp/simulation.h:614:                 worker_buffers.local_ifed_gnd[tid][energy_index]++;
	movslq	%edx, %rdx	# energy_index, _39
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	%r15, %rsi	# _104, _191
# C/parallel-only-omp/simulation.h:614:                 worker_buffers.local_ifed_gnd[tid][energy_index]++;
	incl	(%rsi,%rdx,4)	#* _191
	jmp	.L749	#
.L738:
# C/parallel-only-omp/simulation.h:660: }
	movq	56(%rsp), %rax	# D.133746, tmp610
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp610
	jne	.L791	#,
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
.L775:
	.cfi_restore_state
# C/parallel-only-omp/simulation.h:623:         int sum_pow = 0, sum_gnd = 0;
	xorl	%edx, %edx	# sum_gnd
# C/parallel-only-omp/simulation.h:623:         int sum_pow = 0, sum_gnd = 0;
	xorl	%ecx, %ecx	# sum_pow
	jmp	.L759	#
.L794:
	incl	%eax	# q.131_79
# C/parallel-only-omp/simulation.h:619:     #pragma omp barrier
	xorl	%edx, %edx	# tt.132_80
	imull	%eax, %ecx	# q.131_79, tmp402
	addl	%ecx, %edx	# tmp402, _120
	leal	(%rax,%rdx), %ecx	#, tmp403
	cmpl	%ecx, %edx	# tmp403, _120
	jl	.L756	#,
	jmp	.L762	#
.L746:
# /usr/include/c++/13/bits/stl_vector.h:1292: 	  _M_realloc_insert(end(), __x);
	leaq	52(%rsp), %rdx	#, tmp375
	movq	%rcx, 24(%rsp)	# tmp337, %sfp
	movq	%r8, 32(%rsp)	# _173, %sfp
	movl	%eax, 40(%rsp)	# _99, %sfp
	call	_ZNSt6vectorIiSaIiEE17_M_realloc_insertIJRKiEEEvN9__gnu_cxx17__normal_iteratorIPiS1_EEDpOT_	#
	movq	24(%rsp), %rcx	# %sfp, tmp337
	movq	32(%rsp), %r8	# %sfp, _173
	movl	40(%rsp), %eax	# %sfp, _99
	leaq	x_i(%rip), %r9	#, tmp570
	vmovsd	.LC81(%rip), %xmm2	#, tmp594
	jmp	.L747	#
	.p2align 4
	.p2align 3
.L795:
# C/parallel-only-omp/simulation.h:648:                     if (last_valid > dead_idx) {
	cmpl	%eax, %ecx	# last_valid, dead_idx
	jge	.L768	#,
# C/parallel-only-omp/simulation.h:649:                         x_i[dead_idx]  = x_i[last_valid];
	movslq	%eax, %rdx	# last_valid, last_valid
# C/parallel-only-omp/simulation.h:653:                         last_valid--;
	decl	%eax	# last_valid
# C/parallel-only-omp/simulation.h:649:                         x_i[dead_idx]  = x_i[last_valid];
	vmovsd	(%rdi,%rdx,8), %xmm0	# x_i[last_valid_240], _63
# C/parallel-only-omp/simulation.h:649:                         x_i[dead_idx]  = x_i[last_valid];
	vmovsd	%xmm0, (%rdi,%rcx,8)	# _63, x_i[dead_idx_139]
# C/parallel-only-omp/simulation.h:650:                         vx_i[dead_idx] = vx_i[last_valid];
	vmovsd	(%r14,%rdx,8), %xmm0	# vx_i[last_valid_240], _64
# C/parallel-only-omp/simulation.h:650:                         vx_i[dead_idx] = vx_i[last_valid];
	vmovsd	%xmm0, (%r14,%rcx,8)	# _64, vx_i[dead_idx_139]
# C/parallel-only-omp/simulation.h:651:                         vy_i[dead_idx] = vy_i[last_valid];
	vmovsd	0(%r13,%rdx,8), %xmm0	# vy_i[last_valid_240], _65
# C/parallel-only-omp/simulation.h:651:                         vy_i[dead_idx] = vy_i[last_valid];
	vmovsd	%xmm0, 0(%r13,%rcx,8)	# _65, vy_i[dead_idx_139]
# C/parallel-only-omp/simulation.h:652:                         vz_i[dead_idx] = vz_i[last_valid];
	vmovsd	(%r10,%rdx,8), %xmm0	# vz_i[last_valid_240], _66
# C/parallel-only-omp/simulation.h:652:                         vz_i[dead_idx] = vz_i[last_valid];
	vmovsd	%xmm0, (%r10,%rcx,8)	# _66, vz_i[dead_idx_139]
	jmp	.L768	#
.L752:
# /usr/include/c++/13/bits/stl_vector.h:1292: 	  _M_realloc_insert(end(), __x);
	leaq	52(%rsp), %rdx	#, tmp390
	movq	%rcx, 24(%rsp)	# tmp337, %sfp
	movq	%r8, 32(%rsp)	# _173, %sfp
	movl	%eax, 40(%rsp)	# _99, %sfp
	call	_ZNSt6vectorIiSaIiEE17_M_realloc_insertIJRKiEEEvN9__gnu_cxx17__normal_iteratorIPiS1_EEDpOT_	#
	movq	24(%rsp), %rcx	# %sfp, tmp337
	movq	32(%rsp), %r8	# %sfp, _173
	movl	40(%rsp), %eax	# %sfp, _99
	leaq	x_i(%rip), %r9	#, tmp570
	vmovsd	.LC81(%rip), %xmm2	#, tmp594
	jmp	.L753	#
.L776:
# C/parallel-only-omp/simulation.h:635:         for (int t2 = 0; t2 < num_threads; ++t2) {
	xorl	%ecx, %ecx	# tmp.1996
	jmp	.L764	#
.L791:
# C/parallel-only-omp/simulation.h:660: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE9883:
	.size	_Z32step6_check_boundaries_ions_bodyiii, .-_Z32step6_check_boundaries_ions_bodyiii
	.section	.text._ZNSt21binomial_distributionIiE10param_type13_M_initializeEv,"axG",@progbits,_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv,comdat
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
	.section	.text._ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv,"axG",@progbits,_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv,comdat
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
	.section	.text._ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0,"axG",@progbits,_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE,comdat
	.align 2
	.p2align 4
	.type	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0, @function
_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0:
.LFB11282:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx	# tmp208, this
	subq	$56, %rsp	#,
	.cfi_def_cfa_offset 80
# /usr/include/c++/13/bits/random.tcc:1820: 	if (_M_saved_available)
	cmpb	$0, 24(%rdi)	#, this_1(D)->_M_saved_available
# /usr/include/c++/13/bits/random.tcc:1812:       normal_distribution<_RealType>::
	vmovsd	%xmm0, 24(%rsp)	# tmp210, %sfp
	vmovsd	%xmm1, 32(%rsp)	# tmp211, %sfp
# /usr/include/c++/13/bits/random.tcc:1820: 	if (_M_saved_available)
	jne	.L838	#,
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	4992(%rsi), %rdx	# __urng_4(D)->_M_p, prephitmp_60
	movq	%rsi, %rbp	# tmp209, __urng
	vxorps	%xmm4, %xmm4, %xmm4	# tmp214
	.p2align 4
	.p2align 3
.L839:
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, prephitmp_60
	ja	.L858	#,
.L841:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	0(%rbp,%rdx,8), %rax	# __urng_4(D)->_M_x[prephitmp_277], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rcx	#, _166
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp224
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, 4992(%rbp)	# _166, __urng_4(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp160
	shrq	$11, %rdx	#, tmp160
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp160, _170
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _170, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp161
	salq	$7, %rdx	#, tmp161
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _173
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _173, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp162
	salq	$15, %rdx	#, tmp162
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _176
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _176, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _178
	shrq	$18, %rdx	#, _178
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _178, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm0	# __z, tmp214, tmp215
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm5, %xmm0, %xmm0	# tmp224, tmp164, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, _166
	ja	.L859	#,
.L842:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	0(%rbp,%rcx,8), %rax	# __urng_4(D)->_M_x[prephitmp_280], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rdx	#, _195
	movq	%rdx, 4992(%rbp)	# _195, __urng_4(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp166
	shrq	$11, %rcx	#, tmp166
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp166, _199
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _199, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp167
	salq	$7, %rcx	#, tmp167
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _202
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _202, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp168
	salq	$15, %rcx	#, tmp168
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _205
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _205, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _207
	shrq	$18, %rcx	#, _207
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _207, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm2	# __z, tmp214, tmp216
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm0, %xmm2	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm2, %xmm2	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vcomisd	.LC10(%rip), %xmm2	#, __ret
	jnb	.L853	#,
# /usr/include/c++/13/bits/random.tcc:1830: 		__x = result_type(2.0) * __aurng() - 1.0;
	vmovsd	.LC152(%rip), %xmm7	#, tmp229
	vfmadd132sd	.LC170(%rip), %xmm7, %xmm2	#, tmp229, _285
.L843:
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _195
	ja	.L860	#,
.L844:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rcx	#, _19
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	0(%rbp,%rdx,8), %rdx	# __urng_4(D)->_M_x[prephitmp_288], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp234
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, 4992(%rbp)	# _19, __urng_4(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rax	# __z, tmp176
	shrq	$11, %rax	#, tmp176
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%eax, %eax	# tmp176, _40
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rax, %rdx	# _40, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rax	# __z, tmp177
	salq	$7, %rax	#, tmp177
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %eax	#, _23
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp178
	salq	$15, %rdx	#, tmp178
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _32
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _32, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _120
	shrq	$18, %rdx	#, _120
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _120, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm1	# __z, tmp214, tmp217
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm6, %xmm1, %xmm1	# tmp234, tmp180, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, _19
	ja	.L861	#,
.L845:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	0(%rbp,%rcx,8), %rax	# __urng_4(D)->_M_x[prephitmp_291], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rdx	#, prephitmp_60
# /usr/include/c++/13/bits/random.tcc:1832: 		__r2 = __x * __x + __y * __y;
	vmulsd	%xmm2, %xmm2, %xmm3	# _285, _285, _292
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, 4992(%rbp)	# prephitmp_60, __urng_4(D)->_M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp182
	shrq	$11, %rcx	#, tmp182
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp182, _141
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _141, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp183
	salq	$7, %rcx	#, tmp183
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _144
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _144, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp184
	salq	$15, %rcx	#, tmp184
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _147
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _147, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _149
	shrq	$18, %rcx	#, _149
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _149, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm0	# __z, tmp214, tmp218
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vcomisd	.LC10(%rip), %xmm0	#, __ret
	jnb	.L846	#,
# /usr/include/c++/13/bits/random.tcc:1831: 		__y = result_type(2.0) * __aurng() - 1.0;
	vmovsd	.LC170(%rip), %xmm1	#, __y
	vfmadd213sd	.LC152(%rip), %xmm0, %xmm1	#, __ret, __y
# /usr/include/c++/13/bits/random.tcc:1832: 		__r2 = __x * __x + __y * __y;
	vfmadd231sd	%xmm1, %xmm1, %xmm3	# __y, __y, __r2
# /usr/include/c++/13/bits/random.tcc:1834: 	    while (__r2 > 1.0 || __r2 == 0.0);
	vcomisd	.LC10(%rip), %xmm3	#, __r2
	ja	.L839	#,
# /usr/include/c++/13/bits/random.tcc:1834: 	    while (__r2 > 1.0 || __r2 == 0.0);
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp240
	vucomisd	%xmm7, %xmm3	# tmp240, __r2
	jp	.L852	#,
	je	.L839	#,
	.p2align 4
	.p2align 3
.L852:
	vmovsd	%xmm2, 40(%rsp)	# _285, %sfp
	vmovsd	%xmm1, 16(%rsp)	# __y, %sfp
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	vmovsd	%xmm3, %xmm3, %xmm0	# __r2,
	vmovsd	%xmm3, 8(%rsp)	# __r2, %sfp
	call	log@PLT	#
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	vmovsd	8(%rsp), %xmm3	# %sfp, __r2
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	vmulsd	.LC171(%rip), %xmm0, %xmm0	#, tmp212, tmp195
	vmovsd	16(%rsp), %xmm1	# %sfp, __y
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	vdivsd	%xmm3, %xmm0, %xmm0	# __r2, tmp195, _17
	vmovsd	40(%rsp), %xmm2	# %sfp, _285
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp197
	vucomisd	%xmm0, %xmm3	# _17, tmp197
	ja	.L855	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _17, __mult
.L851:
# /usr/include/c++/13/bits/random.tcc:1837: 	    _M_saved = __x * __mult;
	vmulsd	%xmm2, %xmm0, %xmm2	# _285, __mult, tmp198
# /usr/include/c++/13/bits/random.tcc:1838: 	    _M_saved_available = true;
	movb	$1, 24(%rbx)	#, this_1(D)->_M_saved_available
# /usr/include/c++/13/bits/random.tcc:1837: 	    _M_saved = __x * __mult;
	vmovsd	%xmm2, 16(%rbx)	# tmp198, this_1(D)->_M_saved
# /usr/include/c++/13/bits/random.tcc:1839: 	    __ret = __y * __mult;
	vmulsd	%xmm0, %xmm1, %xmm0	# __mult, __y, __ret
	jmp	.L840	#
	.p2align 4
	.p2align 3
.L861:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbp, %rdi	# __urng,
	vmovsd	%xmm2, 16(%rsp)	# _285, %sfp
	vmovsd	%xmm1, 8(%rsp)	# __sum, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbp), %rcx	# __urng_4(D)->_M_p, _19
	vxorps	%xmm4, %xmm4, %xmm4	# tmp214
	vmovsd	16(%rsp), %xmm2	# %sfp, _285
	vmovsd	8(%rsp), %xmm1	# %sfp, __sum
	jmp	.L845	#
	.p2align 4
	.p2align 3
.L860:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbp, %rdi	# __urng,
	vmovsd	%xmm2, 8(%rsp)	# _285, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbp), %rdx	# __urng_4(D)->_M_p, _195
	vxorps	%xmm4, %xmm4, %xmm4	# tmp214
	vmovsd	8(%rsp), %xmm2	# %sfp, _285
	jmp	.L844	#
	.p2align 4
	.p2align 3
.L859:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbp, %rdi	# __urng,
	vmovsd	%xmm0, 8(%rsp)	# __sum, %sfp
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbp), %rcx	# __urng_4(D)->_M_p, _166
	vxorps	%xmm4, %xmm4, %xmm4	# tmp214
	vmovsd	8(%rsp), %xmm0	# %sfp, __sum
	jmp	.L842	#
	.p2align 4
	.p2align 3
.L858:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%rbp, %rdi	# __urng,
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	4992(%rbp), %rdx	# __urng_4(D)->_M_p, prephitmp_60
	vxorps	%xmm4, %xmm4, %xmm4	# tmp214
	jmp	.L841	#
	.p2align 4
	.p2align 3
.L846:
# /usr/include/c++/13/bits/random.tcc:1832: 		__r2 = __x * __x + __y * __y;
	vaddsd	.LC172(%rip), %xmm3, %xmm3	#, _292, __r2
# /usr/include/c++/13/bits/random.tcc:1834: 	    while (__r2 > 1.0 || __r2 == 0.0);
	vcomisd	.LC10(%rip), %xmm3	#, __r2
	ja	.L839	#,
# /usr/include/c++/13/bits/random.tcc:1831: 		__y = result_type(2.0) * __aurng() - 1.0;
	vmovsd	.LC167(%rip), %xmm1	#, __y
	jmp	.L852	#
	.p2align 4
	.p2align 3
.L853:
	vmovsd	.LC167(%rip), %xmm2	#, _285
	jmp	.L843	#
	.p2align 4
	.p2align 3
.L838:
# /usr/include/c++/13/bits/random.tcc:1822: 	    _M_saved_available = false;
	movb	$0, 24(%rdi)	#, this_1(D)->_M_saved_available
# /usr/include/c++/13/bits/random.tcc:1823: 	    __ret = _M_saved;
	vmovsd	16(%rdi), %xmm0	# this_1(D)->_M_saved, __ret
.L840:
# /usr/include/c++/13/bits/random.tcc:1842: 	__ret = __ret * __param.stddev() + __param.mean();
	vmovsd	24(%rsp), %xmm6	# %sfp, ISRA.2210
	vfmadd132sd	32(%rsp), %xmm6, %xmm0	# %sfp, ISRA.2210, <retval>
# /usr/include/c++/13/bits/random.tcc:1844:       }
	addq	$56, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
.L855:
	.cfi_restore_state
	vmovsd	%xmm2, 16(%rsp)	# _285, %sfp
	vmovsd	%xmm1, 8(%rsp)	# __y, %sfp
# /usr/include/c++/13/bits/random.tcc:1836: 	    const result_type __mult = std::sqrt(-2 * std::log(__r2) / __r2);
	call	sqrt@PLT	#
	vmovsd	16(%rsp), %xmm2	# %sfp, _285
	vmovsd	8(%rsp), %xmm1	# %sfp, __y
	jmp	.L851	#
	.cfi_endproc
.LFE11282:
	.size	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0, .-_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.isra.0
	.section	.text._ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0,"ax",@progbits
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
	.section	.text._ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE,"axG",@progbits,_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE,comdat
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
	.section	.text.unlikely.__tls_init,"ax",@progbits
.LCOLDB179:
	.section	.text.__tls_init,"ax",@progbits
.LHOTB179:
	.p2align 4
	.type	__tls_init, @function
__tls_init:
.LFB11224:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA11224
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
	subq	$48, %rsp	#,
	.cfi_def_cfa_offset 80
# C/parallel-only-omp/state.h:265: inline thread_local std::random_device rd{}; 
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp143
	movq	%rax, 40(%rsp)	# tmp143, D.134124
	xorl	%eax, %eax	# tmp143
# C/parallel-only-omp/eduPIC.cc:97: }
	cmpb	$0, %fs:__tls_guard@tpoff	#, __tls_guard
	jne	.L974	#,
# C/parallel-only-omp/state.h:265: inline thread_local std::random_device rd{}; 
	cmpb	$0, %fs:_ZGV2rd@tpoff	#, MEM[(char *)&_ZGV2rd]
	movb	$1, %fs:__tls_guard@tpoff	#, __tls_guard
	je	.L990	#,
# C/parallel-only-omp/state.h:266: inline thread_local std::mt19937 MTgen(rd());
	cmpb	$0, %fs:_ZGV5MTgen@tpoff	#, MEM[(char *)&_ZGV5MTgen]
	je	.L991	#,
.L981:
# C/parallel-only-omp/state.h:267: inline thread_local std::uniform_real_distribution<> R01(0.0, 1.0);
	cmpb	$0, %fs:_ZGV3R01@tpoff	#, MEM[(char *)&_ZGV3R01]
	jne	.L983	#,
# /usr/include/c++/13/bits/random.h:1797: 	: _M_a(__a), _M_b(__b)
	movq	.LC10(%rip), %rax	#, tmp149
# C/parallel-only-omp/state.h:267: inline thread_local std::uniform_real_distribution<> R01(0.0, 1.0);
	movb	$1, %fs:_ZGV3R01@tpoff	#, MEM[(char *)&_ZGV3R01]
# /usr/include/c++/13/bits/random.h:1797: 	: _M_a(__a), _M_b(__b)
	movq	$0x000000000, %fs:R01@tpoff	#, MEM[(struct param_type *)&R01]._M_a
# /usr/include/c++/13/bits/random.h:1797: 	: _M_a(__a), _M_b(__b)
	movq	%rax, %fs:8+R01@tpoff	# tmp149, MEM[(struct param_type *)&R01]._M_b
.L983:
# C/parallel-only-omp/state.h:268: inline thread_local std::normal_distribution<> RMB(0.0, sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS));
	cmpb	$0, %fs:_ZGV3RMB@tpoff	#, MEM[(char *)&_ZGV3RMB]
	jne	.L974	#,
# /usr/include/c++/13/bits/random.h:2034: 	: _M_mean(__mean), _M_stddev(__stddev)
	movq	.LC178(%rip), %rax	#, tmp150
# C/parallel-only-omp/state.h:268: inline thread_local std::normal_distribution<> RMB(0.0, sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS));
	movb	$1, %fs:_ZGV3RMB@tpoff	#, MEM[(char *)&_ZGV3RMB]
# /usr/include/c++/13/bits/random.h:2034: 	: _M_mean(__mean), _M_stddev(__stddev)
	movq	$0x000000000, %fs:RMB@tpoff	#, MEM[(struct param_type *)&RMB]._M_mean
# /usr/include/c++/13/bits/random.h:2073:       : _M_param(__mean, __stddev)
	movq	$0x000000000, %fs:16+RMB@tpoff	#, RMB._M_saved
	movb	$0, %fs:24+RMB@tpoff	#, RMB._M_saved_available
# /usr/include/c++/13/bits/random.h:2034: 	: _M_mean(__mean), _M_stddev(__stddev)
	movq	%rax, %fs:8+RMB@tpoff	# tmp150, MEM[(struct param_type *)&RMB]._M_stddev
.L974:
# C/parallel-only-omp/state.h:268: inline thread_local std::normal_distribution<> RMB(0.0, sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS));
	movq	40(%rsp), %rax	# D.134124, tmp145
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp145
	jne	.L992	#,
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
.L990:
	.cfi_restore_state
# /usr/include/c++/13/bits/random.h:1658:     random_device() { _M_init("default"); }
	movq	%fs:0, %rbx	#, tmp140
# /usr/include/c++/13/bits/basic_string.h:189: 	: allocator_type(__a), _M_p(__dat) { }
	movq	%rsp, %r12	#, tmp138
	leaq	16(%rsp), %rbp	#, tmp139
# C/parallel-only-omp/state.h:265: inline thread_local std::random_device rd{}; 
	movb	$1, %fs:_ZGV2rd@tpoff	#, MEM[(char *)&_ZGV2rd]
# /usr/include/c++/13/bits/random.h:1658:     random_device() { _M_init("default"); }
	movq	%r12, %rsi	# tmp138,
# /usr/include/c++/13/bits/char_traits.h:435: 	return static_cast<char_type*>(__builtin_memcpy(__s1, __s2, __n));
	movl	$1634100580, 16(%rsp)	#, MEM <char[1:7]> [(void *)&D.134079 + 16B]
# /usr/include/c++/13/bits/basic_string.h:189: 	: allocator_type(__a), _M_p(__dat) { }
	movq	%rbp, (%rsp)	# tmp139, MEM[(struct _Alloc_hider *)&D.134079]._M_p
# /usr/include/c++/13/bits/char_traits.h:435: 	return static_cast<char_type*>(__builtin_memcpy(__s1, __s2, __n));
	movl	$1953264993, 19(%rsp)	#, MEM <char[1:7]> [(void *)&D.134079 + 16B]
# /usr/include/c++/13/bits/basic_string.h:218:       { _M_string_length = __length; }
	movq	$7, 8(%rsp)	#, D.134079._M_string_length
# /usr/include/c++/13/bits/char_traits.h:358: 	__c1 = __c2;
	movb	$0, 23(%rsp)	#, MEM[(char_type &)&D.134079 + 23]
# /usr/include/c++/13/bits/random.h:1658:     random_device() { _M_init("default"); }
	leaq	rd@tpoff(%rbx), %rdi	#, tmp104
.LEHB0:
	call	_ZNSt13random_device7_M_initERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE@PLT	#
.LEHE0:
# /usr/include/c++/13/bits/basic_string.h:223:       { return _M_dataplus._M_p; }
	movq	(%rsp), %rdi	# D.134079._M_dataplus._M_p, _23
# /usr/include/c++/13/bits/basic_string.h:264: 	if (_M_data() == _M_local_data())
	cmpq	%rbp, %rdi	# tmp139, _23
	je	.L978	#,
# /usr/include/c++/13/bits/basic_string.h:289:       { _Alloc_traits::deallocate(_M_get_allocator(), _M_data(), __size + 1); }
	movq	16(%rsp), %rax	# D.134079.D.38717._M_allocated_capacity, tmp147
	leaq	1(%rax), %rsi	#, tmp108
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L978:
# C/parallel-only-omp/state.h:265: inline thread_local std::random_device rd{}; 
	leaq	rd@tpoff(%rbx), %rsi	#, tmp110
	leaq	__dso_handle(%rip), %rdx	#, tmp112
	leaq	_ZNSt13random_deviceD1Ev(%rip), %rdi	#, tmp113
	call	__cxa_thread_atexit@PLT	#
# C/parallel-only-omp/state.h:266: inline thread_local std::mt19937 MTgen(rd());
	cmpb	$0, %fs:_ZGV5MTgen@tpoff	#, MEM[(char *)&_ZGV5MTgen]
	jne	.L981	#,
.L991:
# C/parallel-only-omp/state.h:266: inline thread_local std::mt19937 MTgen(rd());
	movb	$1, %fs:_ZGV5MTgen@tpoff	#, MEM[(char *)&_ZGV5MTgen]
.LEHB1:
# C/parallel-only-omp/state.h:266: inline thread_local std::mt19937 MTgen(rd());
	call	_ZTH2rd	#
# /usr/include/c++/13/bits/random.h:1680:     { return this->_M_getval(); }
	movq	%fs:0, %rbx	#, tmp140
	leaq	rd@tpoff(%rbx), %rdi	#, tmp117
	call	_ZNSt13random_device9_M_getvalEv@PLT	#
.LEHE1:
# /usr/include/c++/13/bits/random.tcc:333:       for (size_t __i = 1; __i < state_size; ++__i)
	movl	$1, %edx	#, __i
# C/parallel-only-omp/state.h:266: inline thread_local std::mt19937 MTgen(rd());
	movl	%eax, %ecx	# tmp142, MTgen___M_x_I_lsm0.2242
# /usr/include/c++/13/bits/random.tcc:330:       _M_x[0] = __detail::__mod<_UIntType,
	movq	%rcx, %fs:MTgen@tpoff	# MTgen___M_x_I_lsm0.2242, MEM[(struct mersenne_twister_engine *)&MTgen]._M_x[0]
	.p2align 4
	.p2align 3
.L982:
# /usr/include/c++/13/bits/random.tcc:336: 	  __x ^= __x >> (__w - 2);
	movq	%rcx, %rax	# MTgen___M_x_I_lsm0.2242, tmp120
	shrq	$30, %rax	#, tmp120
# /usr/include/c++/13/bits/random.tcc:336: 	  __x ^= __x >> (__w - 2);
	xorq	%rcx, %rax	# MTgen___M_x_I_lsm0.2242, __x
# /usr/include/c++/13/bits/random.tcc:337: 	  __x *= __f;
	imulq	$1812433253, %rax, %rax	#, __x, __x
# /usr/include/c++/13/bits/random.h:143: 	    __res %= __m;
	leal	(%rdx,%rax), %ecx	#, MTgen___M_x_I_lsm0.2242
# /usr/include/c++/13/bits/random.tcc:339: 	  _M_x[__i] = __detail::__mod<_UIntType,
	movq	%rcx, MTgen@tpoff(%rbx,%rdx,8)	# MTgen___M_x_I_lsm0.2242, MEM[(long unsigned int *)&MTgen + __i_28 * 8]
# /usr/include/c++/13/bits/random.tcc:333:       for (size_t __i = 1; __i < state_size; ++__i)
	incq	%rdx	# __i
# /usr/include/c++/13/bits/random.tcc:333:       for (size_t __i = 1; __i < state_size; ++__i)
	cmpq	$624, %rdx	#, __i
	jne	.L982	#,
# /usr/include/c++/13/bits/random.tcc:342:       _M_p = state_size;
	movq	$624, %fs:4992+MTgen@tpoff	#, MEM[(struct mersenne_twister_engine *)&MTgen]._M_p
# /usr/include/c++/13/bits/random.h:546:       { seed(__sd); }
	jmp	.L981	#
.L992:
# C/parallel-only-omp/state.h:268: inline thread_local std::normal_distribution<> RMB(0.0, sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS));
	call	__stack_chk_fail@PLT	#
.L986:
	endbr64	
# /usr/include/c++/13/bits/basic_string.h:804:       { _M_dispose(); }
	movq	%rax, %rbx	# tmp141, tmp115
	jmp	.L979	#
	.section	.gcc_except_table.__tls_init,"a",@progbits
.LLSDA11224:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE11224-.LLSDACSB11224
.LLSDACSB11224:
	.uleb128 .LEHB0-.LFB11224
	.uleb128 .LEHE0-.LEHB0
	.uleb128 .L986-.LFB11224
	.uleb128 0
	.uleb128 .LEHB1-.LFB11224
	.uleb128 .LEHE1-.LEHB1
	.uleb128 0
	.uleb128 0
.LLSDACSE11224:
	.section	.text.__tls_init
	.cfi_endproc
	.section	.text.unlikely.__tls_init
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDAC11224
	.type	__tls_init.cold, @function
__tls_init.cold:
.LFSB11224:
.L979:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -32
	.cfi_offset 6, -24
	.cfi_offset 12, -16
	movq	%r12, %rdi	# tmp138,
	vzeroupper
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv@PLT	#
	movq	40(%rsp), %rax	# D.134124, tmp144
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp144
	jne	.L993	#,
	movq	%rbx, %rdi	# tmp115,
.LEHB2:
	call	_Unwind_Resume@PLT	#
.LEHE2:
.L993:
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE11224:
	.section	.gcc_except_table.__tls_init
.LLSDAC11224:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSEC11224-.LLSDACSBC11224
.LLSDACSBC11224:
	.uleb128 .LEHB2-.LCOLDB179
	.uleb128 .LEHE2-.LEHB2
	.uleb128 0
	.uleb128 0
.LLSDACSEC11224:
	.section	.text.unlikely.__tls_init
	.section	.text.__tls_init
	.size	__tls_init, .-__tls_init
	.section	.text.unlikely.__tls_init
	.size	__tls_init.cold, .-__tls_init.cold
.LCOLDE179:
	.section	.text.__tls_init
.LHOTE179:
	.weak	_ZTH3RMB
	.set	_ZTH3RMB,__tls_init
	.weak	_ZTH3R01
	.set	_ZTH3R01,__tls_init
	.weak	_ZTH5MTgen
	.set	_ZTH5MTgen,__tls_init
	.weak	_ZTH2rd
	.set	_ZTH2rd,__tls_init
	.section	.text._Z4initi,"axG",@progbits,_Z4initi,comdat
	.p2align 4
	.weak	_Z4initi
	.type	_Z4initi, @function
_Z4initi:
.LFB9871:
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
# C/parallel-only-omp/simulation.h:18: inline void init(int nseed) {
	movl	%edi, 28(%rsp)	# nseed, %sfp
# C/parallel-only-omp/simulation.h:19:     for (int i = 0; i < nseed; i++) {
	testl	%edi, %edi	# nseed
	jle	.L1003	#,
	movslq	28(%rsp), %rax	# %sfp, nseed
	xorl	%r12d, %r12d	# ivtmp.2270
	leaq	MTgen@tpoff, %rbp	#, tmp258
	leaq	R01@tpoff, %rbx	#, tmp271
	leaq	x_e(%rip), %r15	#, tmp267
	leaq	vx_e(%rip), %r14	#, tmp260
	leaq	vy_e(%rip), %r13	#, tmp262
	salq	$3, %rax	#, _271
	movq	%rax, 8(%rsp)	# _271, %sfp
	jmp	.L1004	#
	.p2align 4
	.p2align 3
.L996:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rdx	#, _166
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:0(%rbp,%rax,8), %rax	# MTgen._M_x[prephitmp_254], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp295
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp296
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, %fs:4992(%rbp)	# _166, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp172
	shrq	$11, %rcx	#, tmp172
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp172, _170
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _170, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp173
	salq	$7, %rcx	#, tmp173
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _173
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _173, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp174
	salq	$15, %rcx	#, tmp174
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _176
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _176, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _178
	shrq	$18, %rcx	#, _178
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _178, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm5, %xmm1	# __z, tmp295, tmp277
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm6, %xmm1, %xmm1	# tmp296, tmp176, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _166
	ja	.L1009	#,
.L997:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rax	#, tmp182
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp302
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC10(%rip), %xmm3	#, tmp303
	vmovsd	.LC173(%rip), %xmm4	#, tmp304
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, %fs:4992(%rbp)	# tmp182, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:0(%rbp,%rdx,8), %rax	# MTgen._M_x[prephitmp_257], __z
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:(%rbx), %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _26
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp184
	shrq	$11, %rdx	#, tmp184
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp184, _199
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _199, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp185
	salq	$7, %rdx	#, tmp185
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _202
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _202, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp186
	salq	$15, %rdx	#, tmp186
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _205
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _205, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _207
	shrq	$18, %rdx	#, _207
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _207, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm7, %xmm0	# __z, tmp302, tmp278
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm3, %xmm1	#, __ret, tmp303, tmp274
	vblendvpd	%xmm1, %xmm4, %xmm0, %xmm0	# tmp274, tmp304, __ret, __ret
# C/parallel-only-omp/simulation.h:21:         vx_e[i] = 0; vy_e[i] = 0; vz_e[i] = 0;  // Początkowa prędkość 3V elektronu
	leaq	vz_e(%rip), %rax	#, tmp305
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%rbx), %xmm1	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
# C/parallel-only-omp/simulation.h:21:         vx_e[i] = 0; vy_e[i] = 0; vz_e[i] = 0;  // Początkowa prędkość 3V elektronu
	movq	$0x000000000, (%r14,%r12)	#, MEM[(double *)&vx_e + ivtmp.2270_274 * 1]
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vsubsd	%xmm2, %xmm1, %xmm1	# _26, MEM[(const struct param_type *)&R01]._M_b, tmp194
# C/parallel-only-omp/simulation.h:21:         vx_e[i] = 0; vy_e[i] = 0; vz_e[i] = 0;  // Początkowa prędkość 3V elektronu
	movq	$0x000000000, (%rax,%r12)	#, MEM[(double *)&vz_e + ivtmp.2270_274 * 1]
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm1, %xmm2, %xmm0	# tmp194, _26, _29
# C/parallel-only-omp/simulation.h:21:         vx_e[i] = 0; vy_e[i] = 0; vz_e[i] = 0;  // Początkowa prędkość 3V elektronu
	movq	$0x000000000, 0(%r13,%r12)	#, MEM[(double *)&vy_e + ivtmp.2270_274 * 1]
# C/parallel-only-omp/simulation.h:20:         x_e[i]  = L * R01(MTgen);               // Początkowa pozycja elektronu
	vmulsd	.LC81(%rip), %xmm0, %xmm0	#, _29, tmp197
# C/parallel-only-omp/simulation.h:20:         x_e[i]  = L * R01(MTgen);               // Początkowa pozycja elektronu
	vmovsd	%xmm0, (%r15,%r12)	# tmp197, MEM[(double *)&x_e + ivtmp.2270_274 * 1]
# C/parallel-only-omp/simulation.h:22:         x_i[i]  = L * R01(MTgen);               // Początkowa pozycja jonu
	call	_ZTH3R01	#
# C/parallel-only-omp/simulation.h:22:         x_i[i]  = L * R01(MTgen);               // Początkowa pozycja jonu
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992(%rbp), %rax	# MTgen._M_p, _47
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, _47
	ja	.L1010	#,
.L999:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:0(%rbp,%rax,8), %rcx	# MTgen._M_x[prephitmp_265], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rdx	#, _112
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp311
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp312
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, %fs:4992(%rbp)	# _112, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rcx, %rax	# __z, tmp211
	shrq	$11, %rax	#, tmp211
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%eax, %eax	# tmp211, _32
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp212
	salq	$7, %rcx	#, tmp212
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _115
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _115, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp213
	salq	$15, %rcx	#, tmp213
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _118
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _118, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _120
	shrq	$18, %rcx	#, _120
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _120, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm3, %xmm1	# __z, tmp311, tmp279
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm4, %xmm1, %xmm1	# tmp312, tmp215, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _112
	ja	.L1011	#,
.L1000:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rax	#, tmp221
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp318
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, %fs:4992(%rbp)	# tmp221, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:0(%rbp,%rdx,8), %rax	# MTgen._M_x[prephitmp_268], __z
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp223
	shrq	$11, %rdx	#, tmp223
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp223, _141
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _141, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp224
	salq	$7, %rdx	#, tmp224
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _144
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _144, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp225
	salq	$15, %rdx	#, tmp225
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _147
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _147, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _149
	shrq	$18, %rdx	#, _149
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _149, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm5, %xmm0	# __z, tmp318, tmp280
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3371:       if (__builtin_expect(__ret >= _RealType(1), 0))
	vcomisd	.LC10(%rip), %xmm0	#, __ret
	jnb	.L1001	#,
# C/parallel-only-omp/simulation.h:22:         x_i[i]  = L * R01(MTgen);               // Początkowa pozycja jonu
	leaq	x_i(%rip), %rax	#, tmp319
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:(%rbx), %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _17
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%rbx), %xmm1	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm1, %xmm1	# _17, MEM[(const struct param_type *)&R01]._M_b, tmp233
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm1, %xmm2, %xmm0	# tmp233, _17, _266
# C/parallel-only-omp/simulation.h:22:         x_i[i]  = L * R01(MTgen);               // Początkowa pozycja jonu
	vmulsd	.LC81(%rip), %xmm0, %xmm0	#, _266, tmp236
# C/parallel-only-omp/simulation.h:22:         x_i[i]  = L * R01(MTgen);               // Początkowa pozycja jonu
	vmovsd	%xmm0, (%rax,%r12)	# tmp236, MEM[(double *)&x_i + ivtmp.2270_274 * 1]
# C/parallel-only-omp/simulation.h:23:         vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // Początkowa prędkość 3V jonu
	leaq	vx_i(%rip), %rax	#, tmp320
	movq	$0x000000000, (%rax,%r12)	#, MEM[(double *)&vx_i + ivtmp.2270_274 * 1]
# C/parallel-only-omp/simulation.h:23:         vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // Początkowa prędkość 3V jonu
	leaq	vy_i(%rip), %rax	#, tmp321
	movq	$0x000000000, (%rax,%r12)	#, MEM[(double *)&vy_i + ivtmp.2270_274 * 1]
# C/parallel-only-omp/simulation.h:23:         vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // Początkowa prędkość 3V jonu
	leaq	vz_i(%rip), %rax	#, tmp322
	movq	$0x000000000, (%rax,%r12)	#, MEM[(double *)&vz_i + ivtmp.2270_274 * 1]
# C/parallel-only-omp/simulation.h:19:     for (int i = 0; i < nseed; i++) {
	movq	8(%rsp), %rax	# %sfp, _271
	addq	$8, %r12	#, ivtmp.2270
	cmpq	%rax, %r12	# _271, ivtmp.2270
	je	.L1003	#,
.L1004:
# C/parallel-only-omp/simulation.h:20:         x_e[i]  = L * R01(MTgen);               // Początkowa pozycja elektronu
	call	_ZTH3R01	#
# C/parallel-only-omp/simulation.h:20:         x_e[i]  = L * R01(MTgen);               // Początkowa pozycja elektronu
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992(%rbp), %rax	# MTgen._M_p, _162
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, _162
	jbe	.L996	#,
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp290
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp167
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbp), %rax	# MTgen._M_p, _162
	jmp	.L996	#
	.p2align 4
	.p2align 3
.L1011:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp313
	vmovsd	%xmm1, 16(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp217
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbp), %rdx	# MTgen._M_p, _112
	vmovsd	16(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1000	#
	.p2align 4
	.p2align 3
.L1010:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp306
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp206
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbp), %rax	# MTgen._M_p, _47
	jmp	.L999	#
	.p2align 4
	.p2align 3
.L1009:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp297
	vmovsd	%xmm1, 16(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp178
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbp), %rdx	# MTgen._M_p, _166
	vmovsd	16(%rsp), %xmm1	# %sfp, __sum
	jmp	.L997	#
	.p2align 4
	.p2align 3
.L1001:
# C/parallel-only-omp/simulation.h:22:         x_i[i]  = L * R01(MTgen);               // Początkowa pozycja jonu
	leaq	x_i(%rip), %rax	#, tmp324
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:(%rbx), %xmm1	# MEM[(const struct param_type *)&R01]._M_a, _20
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%rbx), %xmm0	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm1, %xmm0, %xmm0	# _20, MEM[(const struct param_type *)&R01]._M_b, tmp246
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	.LC173(%rip), %xmm1, %xmm0	#, _20, _23
# C/parallel-only-omp/simulation.h:22:         x_i[i]  = L * R01(MTgen);               // Początkowa pozycja jonu
	vmulsd	.LC81(%rip), %xmm0, %xmm0	#, _23, tmp250
# C/parallel-only-omp/simulation.h:22:         x_i[i]  = L * R01(MTgen);               // Początkowa pozycja jonu
	vmovsd	%xmm0, (%rax,%r12)	# tmp250, MEM[(double *)&x_i + ivtmp.2270_274 * 1]
# C/parallel-only-omp/simulation.h:23:         vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // Początkowa prędkość 3V jonu
	leaq	vx_i(%rip), %rax	#, tmp325
	movq	$0x000000000, (%rax,%r12)	#, MEM[(double *)&vx_i + ivtmp.2270_274 * 1]
# C/parallel-only-omp/simulation.h:23:         vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // Początkowa prędkość 3V jonu
	leaq	vy_i(%rip), %rax	#, tmp326
	movq	$0x000000000, (%rax,%r12)	#, MEM[(double *)&vy_i + ivtmp.2270_274 * 1]
# C/parallel-only-omp/simulation.h:23:         vx_i[i] = 0; vy_i[i] = 0; vz_i[i] = 0;  // Początkowa prędkość 3V jonu
	leaq	vz_i(%rip), %rax	#, tmp327
	movq	$0x000000000, (%rax,%r12)	#, MEM[(double *)&vz_i + ivtmp.2270_274 * 1]
# C/parallel-only-omp/simulation.h:19:     for (int i = 0; i < nseed; i++) {
	addq	$8, %r12	#, ivtmp.2270
	cmpq	%r12, 8(%rsp)	# ivtmp.2270, %sfp
	jne	.L1004	#,
.L1003:
# C/parallel-only-omp/simulation.h:25:     N_e = nseed;    // Początkowa liczba elektronów
	movl	28(%rsp), %eax	# %sfp, nseed
	movl	%eax, N_e(%rip)	# nseed, N_e
# C/parallel-only-omp/simulation.h:26:     N_i = nseed;    // Początkowa liczba jonów
	movl	%eax, N_i(%rip)	# nseed, N_i
# C/parallel-only-omp/simulation.h:27: }
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
	.cfi_endproc
.LFE9871:
	.size	_Z4initi, .-_Z4initi
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC180:
	.string	">> eduPIC: starting...\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC181:
	.string	">> eduPIC: error = need starting_cycle argument\n"
	.section	.rodata.str1.1
.LC182:
	.string	"m"
	.section	.rodata.str1.8
	.align 8
.LC183:
	.string	">> eduPIC: measurement mode: on\n"
	.align 8
.LC184:
	.string	">> eduPIC: measurement mode: off\n"
	.section	.rodata.str1.1
.LC185:
	.string	"a"
.LC186:
	.string	"conv.dat"
.LC187:
	.string	"r"
.LC188:
	.string	"picdata.bin"
	.section	.rodata.str1.8
	.align 8
.LC189:
	.string	">> eduPIC: Warning: Data from previous calculation are detected.\n"
	.align 8
.LC190:
	.string	"           To start a new simulation from the beginning, please delete all output files before running ./eduPIC 0\n"
	.align 8
.LC191:
	.string	"           To continue the existing calculation, please specify the number of cycles to run, e.g. ./eduPIC 100\n"
	.align 8
.LC192:
	.string	">> eduPIC: running initializing cycle\n"
	.align 8
.LC193:
	.string	">> eduPIC: running %d cycle(s)\n"
	.align 8
.LC194:
	.string	">> eduPIC: simulation of %d cycle(s) is completed.\n"
	.section	.text.startup.main,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB9929:
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
	movq	%rsi, %rbp	# tmp527, argv
	subq	$56, %rsp	#,
	.cfi_def_cfa_offset 112
# C/parallel-only-omp/eduPIC.cc:21: int main (int argc, char *argv[]){
	movl	%edi, %ebx	# tmp526, argc
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC180(%rip), %rsi	#, tmp274
	movl	$2, %edi	#,
# C/parallel-only-omp/eduPIC.cc:21: int main (int argc, char *argv[]){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp549
	movq	%rax, 40(%rsp)	# tmp549, D.134265
	xorl	%eax, %eax	# tmp549
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	__printf_chk@PLT	#
# C/parallel-only-omp/eduPIC.cc:25:     if (argc == 1) {
	cmpl	$1, %ebx	#, argc
	je	.L1079	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	8(%rbp), %rsi	# MEM[(char * *)argv_29(D) + 8B], MEM[(char * *)argv_29(D) + 8B]
	movl	$80, %edx	#,
	leaq	st0(%rip), %rdi	#, tmp277
	call	__strcpy_chk@PLT	#
# /usr/include/stdlib.h:488:   return strtol (__nptr, (char **) NULL, 10);
	movl	$10, %edx	#,
	xorl	%esi, %esi	#
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, %rdi	#, tmp277
# /usr/include/stdlib.h:488:   return strtol (__nptr, (char **) NULL, 10);
	call	__isoc23_strtol@PLT	#
# C/parallel-only-omp/eduPIC.cc:30:         arg1 = atol(st0);
	movl	%eax, arg1(%rip)	# tmp528, arg1
# C/parallel-only-omp/eduPIC.cc:31:         if (argc > 2) {
	cmpl	$2, %ebx	#, argc
	jle	.L1015	#,
# C/parallel-only-omp/eduPIC.cc:32:             if (strcmp (argv[2],"m") == 0){
	movq	16(%rbp), %rdi	# MEM[(char * *)argv_29(D) + 16B], MEM[(char * *)argv_29(D) + 16B]
	leaq	.LC182(%rip), %rsi	#, tmp282
	call	strcmp@PLT	#
# C/parallel-only-omp/eduPIC.cc:32:             if (strcmp (argv[2],"m") == 0){
	testl	%eax, %eax	# tmp529
	jne	.L1016	#,
# C/parallel-only-omp/eduPIC.cc:34:                 measurement_mode = true;
	movb	$1, measurement_mode(%rip)	#, measurement_mode
.L1017:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC183(%rip), %rsi	#, tmp283
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	jmp	.L1019	#
.L1015:
# C/parallel-only-omp/eduPIC.cc:40:     if (measurement_mode) {
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	jne	.L1017	#,
.L1018:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC184(%rip), %rsi	#, tmp284
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
.L1019:
# C/parallel-only-omp/eduPIC.cc:47:     set_electron_cross_sections_ar();
	call	_Z30set_electron_cross_sections_arv	#
# C/parallel-only-omp/eduPIC.cc:48:     set_ion_cross_sections_ar();
	call	_Z25set_ion_cross_sections_arv	#
# C/parallel-only-omp/eduPIC.cc:49:     calc_total_cross_sections();
	call	_Z25calc_total_cross_sectionsv	#
# C/parallel-only-omp/eduPIC.cc:51:     compute_null_collision_params();
	call	_Z29compute_null_collision_paramsv	#
# C/parallel-only-omp/poisson.h:19:     inv_denom_thomas[1] = 1.0 / B;
	movl	$16, %eax	#, ivtmp.2303
	leaq	inv_denom_thomas(%rip), %rcx	#, tmp507
	leaq	w_thomas(%rip), %rdx	#, tmp505
# C/parallel-only-omp/poisson.h:18:     w_thomas[1] = C / B;
	vmovsd	.LC41(%rip), %xmm0	#, tmp286
	vmovsd	.LC171(%rip), %xmm2	#, tmp504
	vmovsd	%xmm0, 8+w_thomas(%rip)	# tmp286, w_thomas[1]
# C/parallel-only-omp/poisson.h:19:     inv_denom_thomas[1] = 1.0 / B;
	vmovsd	%xmm0, 8+inv_denom_thomas(%rip)	# tmp286, inv_denom_thomas[1]
	vmovsd	.LC10(%rip), %xmm1	#, tmp503
	.p2align 4
	.p2align 3
.L1020:
# C/parallel-only-omp/poisson.h:21:         double denom = B - A * w_thomas[i - 1];
	vsubsd	%xmm0, %xmm2, %xmm0	# w_thomas_I_lsm0.2278, tmp504, denom
# C/parallel-only-omp/poisson.h:22:         inv_denom_thomas[i] = 1.0 / denom;
	vdivsd	%xmm0, %xmm1, %xmm0	# denom, tmp503, w_thomas_I_lsm0.2278
# C/parallel-only-omp/poisson.h:22:         inv_denom_thomas[i] = 1.0 / denom;
	vmovsd	%xmm0, (%rcx,%rax)	# w_thomas_I_lsm0.2278, MEM[(double *)&inv_denom_thomas + ivtmp.2303_1353 * 1]
# C/parallel-only-omp/poisson.h:23:         w_thomas[i] = C * inv_denom_thomas[i];
	vmovsd	%xmm0, (%rdx,%rax)	# w_thomas_I_lsm0.2278, MEM[(double *)&w_thomas + ivtmp.2303_1353 * 1]
# C/parallel-only-omp/poisson.h:20:     for (int i = 2; i <= N_G - 2; i++) {
	addq	$8, %rax	#, ivtmp.2303
	cmpq	$3192, %rax	#, ivtmp.2303
	jne	.L1020	#,
# C/parallel-only-omp/eduPIC.cc:58:     datafile = fopen("conv.dat","a");
	leaq	.LC185(%rip), %rsi	#, tmp294
	leaq	.LC186(%rip), %rdi	#, tmp295
	call	fopen@PLT	#
# C/parallel-only-omp/eduPIC.cc:58:     datafile = fopen("conv.dat","a");
	movq	%rax, datafile(%rip)	# tmp530, datafile
# C/parallel-only-omp/eduPIC.cc:60:     if (arg1 == 0) {
	movl	arg1(%rip), %eax	# arg1, arg1.1_6
# C/parallel-only-omp/eduPIC.cc:60:     if (arg1 == 0) {
	testl	%eax, %eax	# arg1.1_6
	jne	.L1021	#,
# C/parallel-only-omp/eduPIC.cc:62:         if (FILE *file = fopen("picdata.bin", "r")) { fclose(file);
	leaq	.LC188(%rip), %rdi	#, tmp298
	leaq	.LC187(%rip), %rsi	#, tmp297
	call	fopen@PLT	#
	movq	%rax, %rdi	# tmp531, tmp299
# C/parallel-only-omp/eduPIC.cc:62:         if (FILE *file = fopen("picdata.bin", "r")) { fclose(file);
	testq	%rax, %rax	# tmp299
	je	.L1022	#,
# C/parallel-only-omp/eduPIC.cc:62:         if (FILE *file = fopen("picdata.bin", "r")) { fclose(file);
	call	fclose@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC189(%rip), %rsi	#, tmp300
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
	leaq	.LC190(%rip), %rsi	#, tmp301
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
	movl	$2, %edi	#,
	leaq	.LC191(%rip), %rsi	#, tmp302
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# C/parallel-only-omp/eduPIC.cc:66:             exit(0);
	xorl	%edi, %edi	#
	call	exit@PLT	#
.L1021:
# C/parallel-only-omp/eduPIC.cc:79:         no_of_cycles = arg1;
	movl	%eax, no_of_cycles(%rip)	# arg1.1_6, no_of_cycles
# C/parallel-only-omp/eduPIC.cc:80:         load_particle_data();
	call	_Z18load_particle_datav	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	no_of_cycles(%rip), %edx	# no_of_cycles,
	leaq	.LC193(%rip), %rsi	#, tmp306
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# C/parallel-only-omp/eduPIC.cc:82:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
	movl	cycles_done(%rip), %edx	# cycles_done, cycles_done.4_9
	leal	1(%rdx), %eax	#, tmp307
	movl	%eax, cycle(%rip)	# tmp307, cycle
# C/parallel-only-omp/eduPIC.cc:82:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
	movl	no_of_cycles(%rip), %eax	# no_of_cycles, no_of_cycles.7_93
# C/parallel-only-omp/eduPIC.cc:82:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
	testl	%eax, %eax	# no_of_cycles.7_93
	jle	.L1024	#,
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %r12	#, tmp523
.L1068:
# C/parallel-only-omp/simulation.h:874:     int num_threads = omp_get_max_threads();
	call	omp_get_max_threads@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	8+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers].D.102928._M_impl.D.102267._M_finish, _88
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$5675921253449092805, %rsi	#, tmp564
# C/parallel-only-omp/simulation.h:874:     int num_threads = omp_get_max_threads();
	movl	%eax, %r13d	# tmp532, num_threads
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	leaq	worker_buffers(%rip), %rax	#, tmp562
	movq	(%rax), %rdx	# MEM[(const struct vector *)&worker_buffers].D.102928._M_impl.D.102267._M_start, _89
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _88, tmp310
	subq	%rdx, %rax	# _89, tmp310
	sarq	$8, %rax	#, tmp311
	imulq	%rsi, %rax	# tmp564, tmp312
# C/parallel-only-omp/state.h:216:         if ((int)e_density.size() >= num_threads) return;
	cmpl	%eax, %r13d	# tmp312, num_threads
	jle	.L1025	#,
# C/parallel-only-omp/state.h:218:         e_density.resize(num_threads);
	movslq	%r13d, %rbx	# num_threads, _94
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp312
	jb	.L1080	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp312, _94
	jnb	.L1027	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3328, %rbx, %rax	#, _94, tmp316
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp316, _243
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _243, _88
	je	.L1027	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 8+worker_buffers(%rip)	# _243, MEM[(struct vector *)&worker_buffers].D.102928._M_impl.D.102267._M_finish
	.p2align 4
	.p2align 3
.L1027:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	32+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 24B].D.102928._M_impl.D.102267._M_finish, _228
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	24+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 24B].D.102928._M_impl.D.102267._M_start, _229
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$5675921253449092805, %rdi	#, tmp567
	movq	%rcx, %rax	# _228, tmp320
	subq	%rdx, %rax	# _229, tmp320
	sarq	$8, %rax	#, tmp321
	imulq	%rdi, %rax	# tmp567, tmp322
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp322
	jb	.L1081	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp322, _94
	jnb	.L1029	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3328, %rbx, %rax	#, _94, tmp326
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp326, _235
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _235, _228
	je	.L1029	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 32+worker_buffers(%rip)	# _235, MEM[(struct vector *)&worker_buffers + 24B].D.102928._M_impl.D.102267._M_finish
	.p2align 4
	.p2align 3
.L1029:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	56+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 48B].D.103980._M_impl.D.103319._M_finish, _220
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	48+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 48B].D.103980._M_impl.D.103319._M_start, _221
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _220, tmp330
	subq	%rdx, %rax	# _221, tmp330
	sarq	$7, %rax	#, tmp331
	imulq	%r12, %rax	# tmp523, tmp332
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp332
	jb	.L1082	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp332, _94
	jnb	.L1031	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbx, %rax	#, _94, tmp336
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp336, _227
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _227, _220
	je	.L1031	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 56+worker_buffers(%rip)	# _227, MEM[(struct vector *)&worker_buffers + 48B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L1031:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	80+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 72B].D.103980._M_impl.D.103319._M_finish, _212
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	72+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 72B].D.103980._M_impl.D.103319._M_start, _213
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _212, tmp340
	subq	%rdx, %rax	# _213, tmp340
	sarq	$7, %rax	#, tmp341
	imulq	%r12, %rax	# tmp523, tmp342
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp342
	jb	.L1083	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp342, _94
	jnb	.L1033	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbx, %rax	#, _94, tmp346
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp346, _219
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _219, _212
	je	.L1033	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 80+worker_buffers(%rip)	# _219, MEM[(struct vector *)&worker_buffers + 72B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L1033:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	104+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 96B].D.103980._M_impl.D.103319._M_finish, _204
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	96+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 96B].D.103980._M_impl.D.103319._M_start, _205
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _204, tmp350
	subq	%rdx, %rax	# _205, tmp350
	sarq	$7, %rax	#, tmp351
	imulq	%r12, %rax	# tmp523, tmp352
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp352
	jb	.L1084	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp352, _94
	jnb	.L1035	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbx, %rax	#, _94, tmp356
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp356, _211
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _211, _204
	je	.L1035	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 104+worker_buffers(%rip)	# _211, MEM[(struct vector *)&worker_buffers + 96B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L1035:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	128+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 120B].D.103980._M_impl.D.103319._M_finish, _196
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	120+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 120B].D.103980._M_impl.D.103319._M_start, _197
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _196, tmp360
	subq	%rdx, %rax	# _197, tmp360
	sarq	$7, %rax	#, tmp361
	imulq	%r12, %rax	# tmp523, tmp362
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp362
	jb	.L1085	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp362, _94
	jnb	.L1037	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbx, %rax	#, _94, tmp366
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp366, _203
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _203, _196
	je	.L1037	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 128+worker_buffers(%rip)	# _203, MEM[(struct vector *)&worker_buffers + 120B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L1037:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	152+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 144B].D.105034._M_impl.D.104373._M_finish, _188
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	144+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 144B].D.105034._M_impl.D.104373._M_start, _189
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$2066035336255469781, %rdi	#, tmp578
	movq	%rcx, %rax	# _188, tmp370
	subq	%rdx, %rax	# _189, tmp370
	sarq	$7, %rax	#, tmp371
	imulq	%rdi, %rax	# tmp578, tmp372
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp372
	jb	.L1086	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp372, _94
	jnb	.L1039	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$16000, %rbx, %rax	#, _94, tmp376
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp376, _195
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _195, _188
	je	.L1039	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 152+worker_buffers(%rip)	# _195, MEM[(struct vector *)&worker_buffers + 144B].D.105034._M_impl.D.104373._M_finish
	.p2align 4
	.p2align 3
.L1039:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	176+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_finish, _180
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	168+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, _181
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _180, tmp380
	subq	%rdx, %rax	# _181, tmp380
	sarq	$6, %rax	#, tmp381
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp381
	jb	.L1087	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp381, _94
	jnb	.L1041	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	movq	%rbx, %rax	# _94, tmp384
	salq	$6, %rax	#, tmp384
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp384, _187
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _187, _180
	je	.L1041	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 176+worker_buffers(%rip)	# _187, MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_finish
	.p2align 4
	.p2align 3
.L1041:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	200+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 192B].D.103980._M_impl.D.103319._M_finish, _172
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	192+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 192B].D.103980._M_impl.D.103319._M_start, _173
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _172, tmp388
	subq	%rdx, %rax	# _173, tmp388
	sarq	$7, %rax	#, tmp389
	imulq	%r12, %rax	# tmp523, tmp390
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp390
	jb	.L1088	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp390, _94
	jnb	.L1043	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbx, %rax	#, _94, tmp394
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp394, _179
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _179, _172
	je	.L1043	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 200+worker_buffers(%rip)	# _179, MEM[(struct vector *)&worker_buffers + 192B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L1043:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	224+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 216B].D.103980._M_impl.D.103319._M_finish, _164
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	216+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 216B].D.103980._M_impl.D.103319._M_start, _165
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _164, tmp398
	subq	%rdx, %rax	# _165, tmp398
	sarq	$7, %rax	#, tmp399
	imulq	%r12, %rax	# tmp523, tmp400
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp400
	jb	.L1089	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp400, _94
	jnb	.L1045	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbx, %rax	#, _94, tmp404
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp404, _171
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _171, _164
	je	.L1045	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 224+worker_buffers(%rip)	# _171, MEM[(struct vector *)&worker_buffers + 216B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L1045:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	248+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 240B].D.103980._M_impl.D.103319._M_finish, _156
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	240+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 240B].D.103980._M_impl.D.103319._M_start, _157
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _156, tmp408
	subq	%rdx, %rax	# _157, tmp408
	sarq	$7, %rax	#, tmp409
	imulq	%r12, %rax	# tmp523, tmp410
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp410
	jb	.L1090	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp410, _94
	jnb	.L1047	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbx, %rax	#, _94, tmp414
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp414, _163
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _163, _156
	je	.L1047	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 248+worker_buffers(%rip)	# _163, MEM[(struct vector *)&worker_buffers + 240B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L1047:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	272+worker_buffers(%rip), %r15	# MEM[(const struct vector *)&worker_buffers + 264B].D.107139._M_impl.D.106478._M_finish, _148
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	264+worker_buffers(%rip), %r14	# MEM[(const struct vector *)&worker_buffers + 264B].D.107139._M_impl.D.106478._M_start, _149
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-6148914691236517205, %rdi	#, tmp590
	movq	%r15, %rax	# _148, tmp418
	subq	%r14, %rax	# _149, tmp418
	sarq	$3, %rax	#, tmp419
	imulq	%rdi, %rax	# tmp590, tmp420
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp420
	jb	.L1091	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp420, _94
	jnb	.L1049	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$24, %rbx, %rax	#, _94, tmp424
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %r14	# tmp424, _155
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%r14, %r15	# _155, _148
	je	.L1049	#,
	movq	%r14, %rbp	# _155, __first
	.p2align 4
	.p2align 3
.L1053:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	0(%rbp), %rdi	# MEM[(int * *)__first_96], _248
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _248
	je	.L1050	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	16(%rbp), %rsi	# MEM[(int * *)__first_96 + 16B], tmp425
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	addq	$24, %rbp	#, __first
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rdi, %rsi	# _248, tmp425
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	cmpq	%rbp, %r15	# __first, _148
	jne	.L1053	#,
.L1052:
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%r14, 272+worker_buffers(%rip)	# _155, MEM[(struct vector *)&worker_buffers + 264B].D.107139._M_impl.D.106478._M_finish
	.p2align 4
	.p2align 3
.L1049:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	296+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 288B].D.108190._M_impl.D.107529._M_finish, _140
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	288+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 288B].D.108190._M_impl.D.107529._M_start, _141
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _140, tmp430
	subq	%rdx, %rax	# _141, tmp430
	sarq	$5, %rax	#, tmp431
	imulq	%r12, %rax	# tmp523, tmp432
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp432
	jb	.L1092	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp432, _94
	jnb	.L1055	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$800, %rbx, %rax	#, _94, tmp436
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp436, _147
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _147, _140
	je	.L1055	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 296+worker_buffers(%rip)	# _147, MEM[(struct vector *)&worker_buffers + 288B].D.108190._M_impl.D.107529._M_finish
	.p2align 4
	.p2align 3
.L1055:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	320+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 312B].D.108190._M_impl.D.107529._M_finish, _132
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	312+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 312B].D.108190._M_impl.D.107529._M_start, _133
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _132, tmp440
	subq	%rdx, %rax	# _133, tmp440
	sarq	$5, %rax	#, tmp441
	imulq	%r12, %rax	# tmp523, tmp442
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp442
	jb	.L1093	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp442, _94
	jnb	.L1057	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$800, %rbx, %rax	#, _94, tmp446
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp446, _139
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _139, _132
	je	.L1057	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 320+worker_buffers(%rip)	# _139, MEM[(struct vector *)&worker_buffers + 312B].D.108190._M_impl.D.107529._M_finish
	.p2align 4
	.p2align 3
.L1057:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	344+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 336B].D.109241._M_impl.D.108580._M_finish, _124
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	336+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 336B].D.109241._M_impl.D.108580._M_start, _125
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-36011213418661887, %rsi	#, tmp453
	movq	%rcx, %rax	# _124, tmp450
	subq	%rdx, %rax	# _125, tmp450
	sarq	$6, %rax	#, tmp451
	imulq	%rsi, %rax	# tmp453, tmp452
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp452
	jb	.L1094	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp452, _94
	jnb	.L1059	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$131136, %rbx, %rax	#, _94, tmp456
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp456, _131
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _131, _124
	je	.L1059	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 344+worker_buffers(%rip)	# _131, MEM[(struct vector *)&worker_buffers + 336B].D.109241._M_impl.D.108580._M_finish
	.p2align 4
	.p2align 3
.L1059:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	368+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 360B].D.109241._M_impl.D.108580._M_finish, _116
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	360+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 360B].D.109241._M_impl.D.108580._M_start, _117
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-36011213418661887, %rsi	#, tmp463
	movq	%rcx, %rax	# _116, tmp460
	subq	%rdx, %rax	# _117, tmp460
	sarq	$6, %rax	#, tmp461
	imulq	%rsi, %rax	# tmp463, tmp462
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp462
	jb	.L1095	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp462, _94
	jnb	.L1062	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$131136, %rbx, %rax	#, _94, tmp469
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp469, _123
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _123, _116
	je	.L1062	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 368+worker_buffers(%rip)	# _123, MEM[(struct vector *)&worker_buffers + 360B].D.109241._M_impl.D.108580._M_finish
	.p2align 4
	.p2align 3
.L1062:
# C/parallel-only-omp/state.h:243:         for (int t = 0; t < num_threads; ++t) {
	testl	%r13d, %r13d	# num_threads
	jle	.L1067	#,
	leaq	(%rbx,%rbx,2), %r14	#, tmp473
	xorl	%ebp, %ebp	# ivtmp.2284
	movl	%r13d, 12(%rsp)	# num_threads, %sfp
	salq	$3, %r14	#, tmp474
	jmp	.L1066	#
	.p2align 4
	.p2align 3
.L1063:
	addq	$24, %rbp	#, ivtmp.2284
	cmpq	%r14, %rbp	# tmp474, ivtmp.2284
	je	.L1096	#,
.L1066:
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	264+worker_buffers(%rip), %rbx	# MEM[(struct vector *)&worker_buffers + 264B].D.107139._M_impl.D.106478._M_start, _114
	addq	%rbp, %rbx	# ivtmp.2284, _114
# /usr/include/c++/13/bits/stl_vector.h:1080: 			 - this->_M_impl._M_start); }
	movq	(%rbx), %rdx	# MEM[(const struct vector *)_114].D.110314._M_impl.D.109653._M_start, _256
# /usr/include/c++/13/bits/stl_vector.h:1080: 			 - this->_M_impl._M_start); }
	movq	16(%rbx), %rax	# MEM[(const struct vector *)_114].D.110314._M_impl.D.109653._M_end_of_storage, tmp477
	subq	%rdx, %rax	# _256, tmp477
# /usr/include/c++/13/bits/vector.tcc:72:       if (this->capacity() < __n)
	cmpq	$7996, %rax	#, tmp477
	ja	.L1063	#,
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	8(%rbx), %r15	# MEM[(const struct vector *)_114].D.110314._M_impl.D.109653._M_finish, _261
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movl	$8000, %edi	#,
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	subq	%rdx, %r15	# _256, _261
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	call	_Znwm@PLT	#
# /usr/include/c++/13/bits/vector.tcc:80: 	      _S_relocate(this->_M_impl._M_start, this->_M_impl._M_finish,
	movq	(%rbx), %rdi	# MEM[(struct vector *)_114].D.110314._M_impl.D.109653._M_start, _265
# /usr/include/c++/13/bits/stl_uninitialized.h:1118:       ptrdiff_t __count = __last - __first;
	movq	8(%rbx), %rdx	# MEM[(struct vector *)_114].D.110314._M_impl.D.109653._M_finish, _266
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r13	# tmp533, _282
# /usr/include/c++/13/bits/stl_uninitialized.h:1118:       ptrdiff_t __count = __last - __first;
	subq	%rdi, %rdx	# _265, _266
# /usr/include/c++/13/bits/stl_uninitialized.h:1119:       if (__count > 0)
	testq	%rdx, %rdx	# _266
	jle	.L1064	#,
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	%rdi, %rsi	# _265,
	movq	%rax, %rdi	# _282,
	call	memmove@PLT	#
# /usr/include/c++/13/bits/vector.tcc:95: 			- this->_M_impl._M_start);
	movq	(%rbx), %rdi	# MEM[(struct vector *)_114].D.110314._M_impl.D.109653._M_start, _265
.L1064:
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _265
	je	.L1065	#,
# /usr/include/c++/13/bits/vector.tcc:95: 			- this->_M_impl._M_start);
	movq	16(%rbx), %rsi	# MEM[(struct vector *)_114].D.110314._M_impl.D.109653._M_end_of_storage, tmp482
	subq	%rdi, %rsi	# _265, tmp482
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L1065:
# /usr/include/c++/13/bits/vector.tcc:97: 	  this->_M_impl._M_finish = __tmp + __old_size;
	addq	%r13, %r15	# _282, tmp485
# /usr/include/c++/13/bits/vector.tcc:96: 	  this->_M_impl._M_start = __tmp;
	vmovq	%r13, %xmm3	# _282, _282
# /usr/include/c++/13/bits/vector.tcc:98: 	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	leaq	8000(%r13), %rcx	#, tmp486
# C/parallel-only-omp/state.h:243:         for (int t = 0; t < num_threads; ++t) {
	addq	$24, %rbp	#, ivtmp.2284
# /usr/include/c++/13/bits/vector.tcc:96: 	  this->_M_impl._M_start = __tmp;
	vpinsrq	$1, %r15, %xmm3, %xmm0	# tmp485, _282, tmp484
# /usr/include/c++/13/bits/vector.tcc:98: 	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	movq	%rcx, 16(%rbx)	# tmp486, MEM[(struct vector *)_114].D.110314._M_impl.D.109653._M_end_of_storage
# /usr/include/c++/13/bits/vector.tcc:96: 	  this->_M_impl._M_start = __tmp;
	vmovdqu	%xmm0, (%rbx)	# tmp484, MEM <vector(2) long unsigned int> [(int * *)_114]
# C/parallel-only-omp/state.h:243:         for (int t = 0; t < num_threads; ++t) {
	cmpq	%r14, %rbp	# tmp474, ivtmp.2284
	jne	.L1066	#,
.L1096:
	movl	12(%rsp), %r13d	# %sfp, num_threads
.L1067:
# C/parallel-only-omp/state.h:247:         #pragma omp parallel for schedule(static)
	leaq	worker_buffers(%rip), %rax	#, tmp601
	leaq	16(%rsp), %rsi	#, tmp467
	xorl	%ecx, %ecx	#
	movl	%r13d, 24(%rsp)	# num_threads, .omp_data_o.177.num_threads
	xorl	%edx, %edx	#
	leaq	_ZN13WorkerBuffers12init_buffersEi._omp_fn.0(%rip), %rdi	#, tmp468
	movq	%rax, 16(%rsp)	# tmp601, .omp_data_o.177.this
	call	GOMP_parallel@PLT	#
.L1025:
	xorl	%ecx, %ecx	#
	xorl	%edx, %edx	#
	xorl	%esi, %esi	#
	leaq	_Z12do_one_cyclev._omp_fn.0(%rip), %rdi	#,
	call	GOMP_parallel@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movl	N_i(%rip), %r9d	# N_i,
	movl	N_e(%rip), %r8d	# N_e,
	movl	cycle(%rip), %ecx	# cycle,
	movq	datafile(%rip), %rdi	# datafile,
	leaq	.LC146(%rip), %rdx	#,
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/eduPIC.cc:82:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
	movl	cycle(%rip), %eax	# cycle, tmp608
# C/parallel-only-omp/eduPIC.cc:82:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
	movl	no_of_cycles(%rip), %edx	# no_of_cycles, no_of_cycles
	addl	cycles_done(%rip), %edx	# cycles_done, _15
# C/parallel-only-omp/eduPIC.cc:82:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
	incl	%eax	# _12
	movl	%eax, cycle(%rip)	# _12, cycle
# C/parallel-only-omp/eduPIC.cc:82:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
	cmpl	%edx, %eax	# _15, _12
	jle	.L1068	#,
.L1023:
# C/parallel-only-omp/eduPIC.cc:88:     fclose(datafile);
	movq	datafile(%rip), %rdi	# datafile,
# C/parallel-only-omp/eduPIC.cc:76:         cycles_done = 1;
	movl	%edx, cycles_done(%rip)	# _15, cycles_done
# C/parallel-only-omp/eduPIC.cc:88:     fclose(datafile);
	call	fclose@PLT	#
# C/parallel-only-omp/eduPIC.cc:90:     save_particle_data();
	call	_Z18save_particle_datav	#
# C/parallel-only-omp/eduPIC.cc:93:     if (measurement_mode) {
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	jne	.L1097	#,
.L1070:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	no_of_cycles(%rip), %edx	# no_of_cycles,
	leaq	.LC194(%rip), %rsi	#, tmp498
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
# C/parallel-only-omp/eduPIC.cc:97: }
	xorl	%ebx, %ebx	# argc
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	__printf_chk@PLT	#
.L1014:
# C/parallel-only-omp/eduPIC.cc:97: }
	movq	40(%rsp), %rax	# D.134265, tmp550
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp550
	jne	.L1098	#,
	addq	$56, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%ebx, %eax	# argc,
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
.L1081:
	.cfi_restore_state
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	movq	%rbx, %rsi	# _94, tmp324
	leaq	24+worker_buffers(%rip), %rdi	#, tmp325
	subq	%rax, %rsi	# tmp322, tmp324
	call	_ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1029	#
.L1080:
	movq	%rbx, %rsi	# _94, tmp314
	leaq	worker_buffers(%rip), %rdi	#,
	subq	%rax, %rsi	# tmp312, tmp314
	call	_ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1027	#
.L1095:
	movq	%rbx, %rsi	# _94, tmp464
	leaq	360+worker_buffers(%rip), %rdi	#, tmp465
	subq	%rax, %rsi	# tmp462, tmp464
	call	_ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm	#
	jmp	.L1062	#
.L1094:
	movq	%rbx, %rsi	# _94, tmp454
	leaq	336+worker_buffers(%rip), %rdi	#, tmp455
	subq	%rax, %rsi	# tmp452, tmp454
	call	_ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm	#
	jmp	.L1059	#
.L1085:
	movq	%rbx, %rsi	# _94, tmp364
	leaq	120+worker_buffers(%rip), %rdi	#, tmp365
	subq	%rax, %rsi	# tmp362, tmp364
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1037	#
.L1084:
	movq	%rbx, %rsi	# _94, tmp354
	leaq	96+worker_buffers(%rip), %rdi	#, tmp355
	subq	%rax, %rsi	# tmp352, tmp354
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1035	#
.L1083:
	movq	%rbx, %rsi	# _94, tmp344
	leaq	72+worker_buffers(%rip), %rdi	#, tmp345
	subq	%rax, %rsi	# tmp342, tmp344
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1033	#
.L1082:
	movq	%rbx, %rsi	# _94, tmp334
	leaq	48+worker_buffers(%rip), %rdi	#, tmp335
	subq	%rax, %rsi	# tmp332, tmp334
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1031	#
.L1093:
	movq	%rbx, %rsi	# _94, tmp444
	leaq	312+worker_buffers(%rip), %rdi	#, tmp445
	subq	%rax, %rsi	# tmp442, tmp444
	call	_ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1057	#
.L1092:
	movq	%rbx, %rsi	# _94, tmp434
	leaq	288+worker_buffers(%rip), %rdi	#, tmp435
	subq	%rax, %rsi	# tmp432, tmp434
	call	_ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1055	#
.L1091:
	movq	%rbx, %rsi	# _94, tmp422
	leaq	264+worker_buffers(%rip), %rdi	#, tmp423
	subq	%rax, %rsi	# tmp420, tmp422
	call	_ZNSt6vectorIS_IiSaIiEESaIS1_EE17_M_default_appendEm	#
	jmp	.L1049	#
.L1090:
	movq	%rbx, %rsi	# _94, tmp412
	leaq	240+worker_buffers(%rip), %rdi	#, tmp413
	subq	%rax, %rsi	# tmp410, tmp412
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1047	#
.L1089:
	movq	%rbx, %rsi	# _94, tmp402
	leaq	216+worker_buffers(%rip), %rdi	#, tmp403
	subq	%rax, %rsi	# tmp400, tmp402
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1045	#
.L1088:
	movq	%rbx, %rsi	# _94, tmp392
	leaq	192+worker_buffers(%rip), %rdi	#, tmp393
	subq	%rax, %rsi	# tmp390, tmp392
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1043	#
.L1087:
	movq	%rbx, %rsi	# _94, tmp382
	leaq	168+worker_buffers(%rip), %rdi	#, tmp383
	subq	%rax, %rsi	# tmp381, tmp382
	call	_ZNSt6vectorI21AlignedThreadCountersSaIS0_EE17_M_default_appendEm	#
	jmp	.L1041	#
.L1086:
	movq	%rbx, %rsi	# _94, tmp374
	leaq	144+worker_buffers(%rip), %rdi	#, tmp375
	subq	%rax, %rsi	# tmp372, tmp374
	call	_ZNSt6vectorISt5arrayIdLm2000EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1039	#
.L1079:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC181(%rip), %rsi	#, tmp275
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# C/parallel-only-omp/eduPIC.cc:27:         return 1;
	jmp	.L1014	#
.L1016:
# C/parallel-only-omp/eduPIC.cc:36:                 measurement_mode = false;
	movb	$0, measurement_mode(%rip)	#, measurement_mode
	jmp	.L1018	#
.L1097:
# C/parallel-only-omp/eduPIC.cc:94:         check_and_save_info();
	call	_Z19check_and_save_infov	#
	jmp	.L1070	#
.L1050:
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	addq	$24, %rbp	#, __first
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	cmpq	%rbp, %r15	# __first, _148
	jne	.L1053	#,
	jmp	.L1052	#
.L1024:
# C/parallel-only-omp/eduPIC.cc:82:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
	addl	%eax, %edx	# no_of_cycles.7_93, _15
	jmp	.L1023	#
.L1022:
# C/parallel-only-omp/eduPIC.cc:72:         init(N_INIT);
	movl	$1000, %edi	#,
# C/parallel-only-omp/eduPIC.cc:68:         no_of_cycles = 1;
	movl	$1, no_of_cycles(%rip)	#, no_of_cycles
# C/parallel-only-omp/eduPIC.cc:69:         cycle = 1;
	movl	$1, cycle(%rip)	#, cycle
# C/parallel-only-omp/eduPIC.cc:72:         init(N_INIT);
	call	_Z4initi	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC192(%rip), %rsi	#, tmp303
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# C/parallel-only-omp/eduPIC.cc:74:         Time = 0;
	movq	$0x000000000, Time(%rip)	#, Time
# C/parallel-only-omp/eduPIC.cc:75:         do_one_cycle();
	call	_Z12do_one_cyclev	#
	movl	$1, %edx	#, _15
	jmp	.L1023	#
.L1098:
# C/parallel-only-omp/eduPIC.cc:97: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE9929:
	.size	main, .-main
	.section	.text._Z18collision_electrondPdS_S_iR12NewParticlesS1_,"axG",@progbits,_Z18collision_electrondPdS_S_iR12NewParticlesS1_,comdat
	.p2align 4
	.weak	_Z18collision_electrondPdS_S_iR12NewParticlesS1_
	.type	_Z18collision_electrondPdS_S_iR12NewParticlesS1_, @function
_Z18collision_electrondPdS_S_iR12NewParticlesS1_:
.LFB9868:
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
	movq	%r8, %r14	# tmp637, new_e
	pushq	%rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rdi, %r12	# tmp633, vxe
	movq	%rsi, %rbp	# tmp634, vye
	subq	$176, %rsp	#,
	.cfi_def_cfa_offset 224
# C/parallel-only-omp/collisions.h:24:     gy = (*vye);
	vmovsd	(%rsi), %xmm2	# *vye_100(D), gy
# C/parallel-only-omp/collisions.h:25:     gz = (*vze);
	vmovsd	(%rdx), %xmm1	# *vze_102(D), gz
# C/parallel-only-omp/collisions.h:23:     gx = (*vxe);
	vmovsd	(%rdi), %xmm3	# *vxe_98(D), gx
# C/parallel-only-omp/collisions.h:14:                                  NewParticles& new_e, NewParticles& new_i) {
	vmovsd	%xmm0, 120(%rsp)	# tmp632, %sfp
# C/parallel-only-omp/collisions.h:26:     double g_perp_sq = gy * gy + gz * gz;
	vmulsd	%xmm1, %xmm1, %xmm0	# gz, gz, tmp378
# C/parallel-only-omp/collisions.h:26:     double g_perp_sq = gy * gy + gz * gz;
	vfmadd231sd	%xmm2, %xmm2, %xmm0	# gy, gy, g_perp_sq
# C/parallel-only-omp/collisions.h:27:     double g_sq      = gx * gx + g_perp_sq;
	vmovsd	%xmm3, %xmm3, %xmm7	# gx, g_sq
# C/parallel-only-omp/collisions.h:31:     wx = F1 * (*vxe);
	vmovsd	.LC195(%rip), %xmm4	#, tmp379
# C/parallel-only-omp/collisions.h:14:                                  NewParticles& new_e, NewParticles& new_i) {
	movq	%rdx, %rbx	# tmp635, vze
# C/parallel-only-omp/collisions.h:32:     wy = F1 * (*vye);
	vmulsd	%xmm4, %xmm2, %xmm6	# tmp379, gy, wy
# C/parallel-only-omp/collisions.h:14:                                  NewParticles& new_e, NewParticles& new_i) {
	movq	%r9, %r13	# tmp638, new_i
# C/parallel-only-omp/collisions.h:32:     wy = F1 * (*vye);
	vmovsd	%xmm6, 64(%rsp)	# wy, %sfp
# C/parallel-only-omp/collisions.h:27:     double g_sq      = gx * gx + g_perp_sq;
	vfmadd132sd	%xmm3, %xmm0, %xmm7	# gx, g_perp_sq, g_sq
# C/parallel-only-omp/collisions.h:29:     double g_perp    = sqrt(g_perp_sq);
	vsqrtsd	%xmm0, %xmm0, %xmm0	# g_perp_sq, g_perp
# C/parallel-only-omp/collisions.h:28:     g  = sqrt(g_sq);
	vsqrtsd	%xmm7, %xmm7, %xmm5	# g_sq, g
# C/parallel-only-omp/collisions.h:27:     double g_sq      = gx * gx + g_perp_sq;
	vmovsd	%xmm7, 104(%rsp)	# g_sq, %sfp
# C/parallel-only-omp/collisions.h:28:     g  = sqrt(g_sq);
	vmovsd	%xmm5, 48(%rsp)	# g, %sfp
# C/parallel-only-omp/collisions.h:31:     wx = F1 * (*vxe);
	vmulsd	%xmm4, %xmm3, %xmm7	# tmp379, gx, wx
# C/parallel-only-omp/collisions.h:33:     wz = F1 * (*vze);
	vmulsd	%xmm4, %xmm1, %xmm4	# tmp379, gz, wz
# C/parallel-only-omp/collisions.h:31:     wx = F1 * (*vxe);
	vmovsd	%xmm7, 56(%rsp)	# wx, %sfp
# C/parallel-only-omp/collisions.h:33:     wz = F1 * (*vze);
	vmovsd	%xmm4, 72(%rsp)	# wz, %sfp
# C/parallel-only-omp/collisions.h:38:     if (g > 0.0) {
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp382
	vcomisd	%xmm4, %xmm5	# tmp382, g
	jbe	.L1162	#,
# C/parallel-only-omp/collisions.h:39:         ct = gx / g;
	vdivsd	%xmm5, %xmm3, %xmm6	# g, gx, ct
# C/parallel-only-omp/collisions.h:40:         st = g_perp / g;
	vdivsd	%xmm5, %xmm0, %xmm5	# g, g_perp, st
# C/parallel-only-omp/collisions.h:39:         ct = gx / g;
	vmovsd	%xmm6, 16(%rsp)	# ct, %sfp
# C/parallel-only-omp/collisions.h:40:         st = g_perp / g;
	vmovsd	%xmm5, 8(%rsp)	# st, %sfp
	vmovsd	.LC10(%rip), %xmm5	#, tmp615
	vmovsd	%xmm5, (%rsp)	# tmp615, %sfp
.L1100:
# C/parallel-only-omp/collisions.h:46:     if (g_perp > 0.0) {
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp383
	vcomisd	%xmm3, %xmm0	# tmp383, g_perp
	jbe	.L1163	#,
# C/parallel-only-omp/collisions.h:47:         cp = gy / g_perp;
	vdivsd	%xmm0, %xmm2, %xmm2	# g_perp, gy, cp
	vmovsd	%xmm2, 32(%rsp)	# cp, %sfp
# C/parallel-only-omp/collisions.h:48:         sp = gz / g_perp;
	vdivsd	%xmm0, %xmm1, %xmm2	# g_perp, gz, sp
	vmovsd	%xmm2, 24(%rsp)	# sp, %sfp
.L1102:
# C/parallel-only-omp/collisions.h:57:     t0   =     sigma[E_ELA][eindex];
	leaq	sigma(%rip), %rax	#, tmp384
	movslq	%ecx, %rcx	# eindex, eindex
	vmovsd	(%rax,%rcx,8), %xmm6	# sigma[0][eindex_117(D)], t0
	vmovsd	%xmm6, 96(%rsp)	# t0, %sfp
# C/parallel-only-omp/collisions.h:58:     t1   = t0 +sigma[E_EXC][eindex];
	vaddsd	8000000(%rax,%rcx,8), %xmm6, %xmm6	# sigma[1][eindex_117(D)], t0, t1
# C/parallel-only-omp/collisions.h:59:     t2   = t1 +sigma[E_ION][eindex];
	vaddsd	16000000(%rax,%rcx,8), %xmm6, %xmm4	# sigma[2][eindex_117(D)], t1, t2
# C/parallel-only-omp/collisions.h:58:     t1   = t0 +sigma[E_EXC][eindex];
	vmovsd	%xmm6, 112(%rsp)	# t1, %sfp
# C/parallel-only-omp/collisions.h:59:     t2   = t1 +sigma[E_ION][eindex];
	vmovsd	%xmm4, 40(%rsp)	# t2, %sfp
# C/parallel-only-omp/collisions.h:60:     rnd  = R01(MTgen);
	call	_ZTH3R01	#
# C/parallel-only-omp/collisions.h:60:     rnd  = R01(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_812
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, pretmp_812
	ja	.L1173	#,
.L1104:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rax,8), %rdx	# MTgen._M_x[prephitmp_937], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rcx	#, prephitmp_834
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp684
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp403
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, %fs:4992+MTgen@tpoff	# prephitmp_834, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rax	# __z, tmp398
	shrq	$11, %rax	#, tmp398
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%eax, %eax	# tmp398, _932
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp399
	salq	$7, %rdx	#, tmp399
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _929
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rax, %rdx	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rax	# __z, tmp400
	salq	$15, %rax	#, tmp400
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %eax	#, _926
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _924
	shrq	$18, %rdx	#, _924
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _924, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm1	# __z, tmp684, tmp647
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm0, %xmm1, %xmm1	# tmp403, tmp402, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, prephitmp_834
	ja	.L1174	#,
.L1105:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rax	#, tmp408
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp690
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, %fs:4992+MTgen@tpoff	# tmp408, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rcx,8), %rax	# MTgen._M_x[prephitmp_834], __z
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	(%rsp), %xmm7	# %sfp, tmp615
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp410
	shrq	$11, %rdx	#, tmp410
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp410, _307
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _307, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp411
	salq	$7, %rdx	#, tmp411
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _310
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _310, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp412
	salq	$15, %rdx	#, tmp412
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _313
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _313, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _315
	shrq	$18, %rdx	#, _315
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _315, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm0	# __z, tmp690, tmp648
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm7, %xmm2	#, __ret, tmp615, tmp619
	vmovsd	.LC173(%rip), %xmm1	#, tmp617
	vblendvpd	%xmm2, %xmm1, %xmm0, %xmm0	# tmp619, tmp617, __ret, __ret
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:R01@tpoff, %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _189
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8+R01@tpoff, %xmm1	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm1, %xmm1	# _189, MEM[(const struct param_type *)&R01]._M_b, tmp420
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm1, %xmm2, %xmm0	# tmp420, _189, _192
# C/parallel-only-omp/collisions.h:61:     double r_t2 = rnd * t2;
	vmulsd	40(%rsp), %xmm0, %xmm3	# %sfp, _192, r_t2
	vmovsd	%xmm3, 40(%rsp)	# r_t2, %sfp
# C/parallel-only-omp/collisions.h:63:     double eta = TWO_PI * R01(MTgen);
	call	_ZTH3R01	#
# C/parallel-only-omp/collisions.h:63:     double eta = TWO_PI * R01(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_839
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, pretmp_839
	ja	.L1175	#,
.L1107:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rax,8), %rdx	# MTgen._M_x[prephitmp_971], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rcx	#, prephitmp_861
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp699
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp433
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, %fs:4992+MTgen@tpoff	# prephitmp_861, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rax	# __z, tmp428
	shrq	$11, %rax	#, tmp428
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%eax, %eax	# tmp428, _966
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp429
	salq	$7, %rdx	#, tmp429
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _963
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rax, %rdx	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rax	# __z, tmp430
	salq	$15, %rax	#, tmp430
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %eax	#, _960
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _958
	shrq	$18, %rdx	#, _958
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _958, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm0	# __z, tmp699, tmp649
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm1, %xmm0, %xmm0	# tmp433, tmp432, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, prephitmp_861
	ja	.L1176	#,
.L1108:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rax	#, tmp438
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp705
	leaq	168(%rsp), %rdi	#, tmp452
	leaq	160(%rsp), %rsi	#, tmp453
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, %fs:4992+MTgen@tpoff	# tmp438, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rcx,8), %rax	# MTgen._M_x[prephitmp_861], __z
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	(%rsp), %xmm5	# %sfp, tmp615
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp440
	shrq	$11, %rdx	#, tmp440
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp440, _322
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _322, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp441
	salq	$7, %rdx	#, tmp441
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _325
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _325, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp442
	salq	$15, %rdx	#, tmp442
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _328
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _328, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _330
	shrq	$18, %rdx	#, _330
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _330, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm6, %xmm1	# __z, tmp705, tmp650
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm0, %xmm1	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm1, %xmm1	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm1, %xmm5, %xmm2	#, __ret, tmp615, tmp622
	vmovsd	.LC173(%rip), %xmm0	#, tmp620
	vblendvpd	%xmm2, %xmm0, %xmm1, %xmm1	# tmp622, tmp620, __ret, __ret
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:R01@tpoff, %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _166
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8+R01@tpoff, %xmm0	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm0, %xmm0	# _166, MEM[(const struct param_type *)&R01]._M_b, tmp450
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm1, %xmm2, %xmm0	# __ret, _166, _186
# C/parallel-only-omp/collisions.h:63:     double eta = TWO_PI * R01(MTgen);
	vmulsd	.LC196(%rip), %xmm0, %xmm0	#, _186, eta
	call	sincos@PLT	#
	vmovsd	160(%rsp), %xmm3	#, sincostmp_1080
	vmovsd	168(%rsp), %xmm7	#, se
# C/parallel-only-omp/collisions.h:67:     if (r_t2 < t0) {                                    // Zderzenie sprężyste (izotropowe)
	vmovsd	96(%rsp), %xmm4	# %sfp, t0
	vmovsd	%xmm3, 88(%rsp)	# sincostmp_1080, %sfp
	vmovsd	%xmm7, 80(%rsp)	# se, %sfp
	vcomisd	40(%rsp), %xmm4	# %sfp, t0
	ja	.L1177	#,
# C/parallel-only-omp/collisions.h:71:         energy = HALF_E_MASS * g_sq;
	vmovsd	104(%rsp), %xmm6	# %sfp, g_sq
# C/parallel-only-omp/collisions.h:70:     } else if (r_t2 < t1) {                             // Wzbudzenie (niesprężyste, izotropowe)
	vmovsd	112(%rsp), %xmm7	# %sfp, t1
# C/parallel-only-omp/collisions.h:71:         energy = HALF_E_MASS * g_sq;
	vmulsd	.LC63(%rip), %xmm6, %xmm0	#, g_sq, _1102
# C/parallel-only-omp/collisions.h:70:     } else if (r_t2 < t1) {                             // Wzbudzenie (niesprężyste, izotropowe)
	vcomisd	40(%rsp), %xmm7	# %sfp, t1
	ja	.L1178	#,
# C/parallel-only-omp/collisions.h:78:         energy = fabs(energy - E_ION_TH * EV_TO_J);
	vsubsd	.LC199(%rip), %xmm0, %xmm0	#, _1102, tmp531
# C/parallel-only-omp/collisions.h:78:         energy = fabs(energy - E_ION_TH * EV_TO_J);
	vandpd	.LC18(%rip), %xmm0, %xmm7	#, tmp531, energy
	vmovsd	%xmm7, 40(%rsp)	# energy, %sfp
# C/parallel-only-omp/collisions.h:81:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy * OPAL_FACTOR)) * EV_TO_J;
	call	_ZTH3R01	#
# C/parallel-only-omp/collisions.h:81:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy * OPAL_FACTOR)) * EV_TO_J;
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_870
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, pretmp_870
	ja	.L1179	#,
.L1125:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rax,8), %rdx	# MTgen._M_x[prephitmp_1003], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rcx	#, prephitmp_892
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp767
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp545
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, %fs:4992+MTgen@tpoff	# prephitmp_892, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rax	# __z, tmp540
	shrq	$11, %rax	#, tmp540
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%eax, %eax	# tmp540, _998
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp541
	salq	$7, %rdx	#, tmp541
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _995
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rax, %rdx	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rax	# __z, tmp542
	salq	$15, %rax	#, tmp542
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %eax	#, _992
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _990
	shrq	$18, %rdx	#, _990
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _990, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm2, %xmm1	# __z, tmp767, tmp655
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm0, %xmm1, %xmm1	# tmp545, tmp544, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, prephitmp_892
	ja	.L1180	#,
.L1126:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rax	#, tmp550
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp773
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, %fs:4992+MTgen@tpoff	# tmp550, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rcx,8), %rax	# MTgen._M_x[prephitmp_892], __z
# C/parallel-only-omp/collisions.h:81:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy * OPAL_FACTOR)) * EV_TO_J;
	vmovsd	40(%rsp), %xmm4	# %sfp, energy
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp552
	shrq	$11, %rdx	#, tmp552
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp552, _421
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _421, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp553
	salq	$7, %rdx	#, tmp553
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _424
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _424, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp554
	salq	$15, %rdx	#, tmp554
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _427
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _427, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _429
	shrq	$18, %rdx	#, _429
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _429, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm7, %xmm0	# __z, tmp773, tmp656
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	(%rsp), %xmm7	# %sfp, tmp615
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm7, %xmm2	#, __ret, tmp615, tmp631
	vmovsd	.LC173(%rip), %xmm1	#, tmp629
	vblendvpd	%xmm2, %xmm1, %xmm0, %xmm0	# tmp631, tmp629, __ret, __ret
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:R01@tpoff, %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _226
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8+R01@tpoff, %xmm1	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm1, %xmm1	# _226, MEM[(const struct param_type *)&R01]._M_b, tmp562
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm0, %xmm2, %xmm1	# __ret, _226, tmp562
# C/parallel-only-omp/collisions.h:81:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy * OPAL_FACTOR)) * EV_TO_J;
	vmulsd	.LC200(%rip), %xmm4, %xmm0	#, energy, tmp564
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%xmm1, 48(%rsp)	# tmp562, %sfp
# C/parallel-only-omp/collisions.h:81:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy * OPAL_FACTOR)) * EV_TO_J;
	call	atan@PLT	#
# C/parallel-only-omp/collisions.h:81:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy * OPAL_FACTOR)) * EV_TO_J;
	vmulsd	48(%rsp), %xmm0, %xmm0	# %sfp, tmp639, tmp566
	call	tan@PLT	#
# C/parallel-only-omp/collisions.h:82:         e_sc = fabs(energy - e_ej);
	vmovsd	40(%rsp), %xmm4	# %sfp, energy
# C/parallel-only-omp/collisions.h:81:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy * OPAL_FACTOR)) * EV_TO_J;
	vmulsd	.LC15(%rip), %xmm0, %xmm3	#, tmp640, tmp567
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp573
# C/parallel-only-omp/collisions.h:81:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy * OPAL_FACTOR)) * EV_TO_J;
	vmulsd	.LC50(%rip), %xmm3, %xmm3	#, tmp567, e_ej
# C/parallel-only-omp/collisions.h:82:         e_sc = fabs(energy - e_ej);
	vsubsd	%xmm3, %xmm4, %xmm11	# e_ej, energy, tmp570
# C/parallel-only-omp/collisions.h:85:         g2   = sqrt(e_ej * TWO_OVER_E_MASS);
	vmulsd	.LC198(%rip), %xmm3, %xmm6	#, e_ej, _24
# C/parallel-only-omp/collisions.h:82:         e_sc = fabs(energy - e_ej);
	vandpd	.LC18(%rip), %xmm11, %xmm11	#, tmp570, e_sc
	vucomisd	%xmm6, %xmm0	# _24, tmp573
	ja	.L1168	#,
# C/parallel-only-omp/collisions.h:85:         g2   = sqrt(e_ej * TWO_OVER_E_MASS);
	vsqrtsd	%xmm6, %xmm6, %xmm6	# _24, g2
# C/parallel-only-omp/collisions.h:87:         cc   = sqrt(e_sc / energy);                     // cos(chi) dla elektronu rozproszonego
	vdivsd	%xmm4, %xmm11, %xmm2	# energy, e_sc, _336
.L1130:
	vsqrtsd	%xmm2, %xmm2, %xmm2	# _336, cc
# C/parallel-only-omp/collisions.h:88:         sc   = sqrt(std::max(0.0, 1.0 - cc * cc));      // sin(chi)
	vmovsd	(%rsp), %xmm1	# %sfp, _27
	vfnmadd231sd	%xmm2, %xmm2, %xmm1	# cc, cc, _27
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp575
	vcomisd	%xmm0, %xmm1	# tmp575, _27
	ja	.L1181	#,
	vxorpd	%xmm1, %xmm1, %xmm1	# sc
.L1131:
# C/parallel-only-omp/collisions.h:90:         double cc2 = sqrt(e_ej / energy);               // cos(chi2) dla elektronu wybitego
	vdivsd	40(%rsp), %xmm3, %xmm0	# %sfp, e_ej, _29
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp576
	vucomisd	%xmm0, %xmm3	# _29, tmp576
	ja	.L1170	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _29, cc2
.L1135:
# C/parallel-only-omp/collisions.h:91:         double sc2 = sqrt(std::max(0.0, 1.0 - cc2 * cc2)); // sin(chi2)
	vmovsd	(%rsp), %xmm3	# %sfp, tmp615
	vfnmadd231sd	%xmm0, %xmm0, %xmm3	# cc2, cc2, tmp615
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp578
	vcomisd	%xmm4, %xmm3	# tmp578, _31
	ja	.L1182	#,
	vxorpd	%xmm3, %xmm3, %xmm3	# _954
.L1136:
# C/parallel-only-omp/collisions.h:95:         double ce2 = -ce;
	vmovsd	88(%rsp), %xmm7	# %sfp, sincostmp_1080
	vxorpd	.LC31(%rip), %xmm7, %xmm13	#, sincostmp_1080, ce2
# C/parallel-only-omp/collisions.h:97:         double gx2 = g2 * (ct * cc2 - st * sc2 * ce2);
	vmovsd	8(%rsp), %xmm12	# %sfp, st
# C/parallel-only-omp/collisions.h:97:         double gx2 = g2 * (ct * cc2 - st * sc2 * ce2);
	vmovsd	16(%rsp), %xmm15	# %sfp, ct
# C/parallel-only-omp/collisions.h:97:         double gx2 = g2 * (ct * cc2 - st * sc2 * ce2);
	vmulsd	%xmm12, %xmm3, %xmm4	# st, _954, tmp580
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmovsd	32(%rsp), %xmm14	# %sfp, cp
	vmulsd	%xmm14, %xmm12, %xmm7	# cp, st, _1091
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm15, %xmm14, %xmm5	# ct, cp, _1094
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm3, %xmm5, %xmm9	# _954, _1094, tmp582
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmovsd	24(%rsp), %xmm10	# %sfp, sp
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmovsd	80(%rsp), %xmm16	# %sfp, se
# C/parallel-only-omp/state.h:159:         if (__builtin_expect(count < (int)CAPACITY, 1)) {
	movl	131072(%r14), %eax	# new_e_156(D)->count, _216
# C/parallel-only-omp/collisions.h:97:         double gx2 = g2 * (ct * cc2 - st * sc2 * ce2);
	vmulsd	%xmm13, %xmm4, %xmm4	# ce2, tmp580, tmp581
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm13, %xmm9, %xmm9	# ce2, tmp582, tmp583
# C/parallel-only-omp/collisions.h:97:         double gx2 = g2 * (ct * cc2 - st * sc2 * ce2);
	vfmsub231sd	%xmm15, %xmm0, %xmm4	# ct, cc2, _36
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vfmadd231sd	%xmm0, %xmm7, %xmm9	# cc2, _1091, _42
# C/parallel-only-omp/collisions.h:97:         double gx2 = g2 * (ct * cc2 - st * sc2 * ce2);
	vmulsd	%xmm6, %xmm4, %xmm8	# g2, _36, gx2
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm10, %xmm3, %xmm4	# sp, _954, tmp584
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vfmadd132sd	%xmm16, %xmm9, %xmm4	# se, _42, _45
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm6, %xmm4, %xmm9	# g2, _45, gy2
# C/parallel-only-omp/collisions.h:99:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmovsd	%xmm10, %xmm10, %xmm4	# sp, sp
	vmulsd	%xmm12, %xmm10, %xmm10	# st, sp, _1097
# C/parallel-only-omp/collisions.h:99:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm15, %xmm4, %xmm4	# ct, sp, _1100
# C/parallel-only-omp/collisions.h:99:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm3, %xmm4, %xmm12	# _954, _1100, tmp585
# C/parallel-only-omp/collisions.h:99:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm13, %xmm12, %xmm12	# ce2, tmp585, tmp586
# C/parallel-only-omp/collisions.h:99:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vfmadd132sd	%xmm10, %xmm12, %xmm0	# _1097, tmp586, _51
# C/parallel-only-omp/collisions.h:99:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm14, %xmm3, %xmm3	# cp, _954, tmp587
# C/parallel-only-omp/collisions.h:99:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vfnmadd132sd	%xmm16, %xmm0, %xmm3	# se, _51, _54
# C/parallel-only-omp/collisions.h:99:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm6, %xmm3, %xmm3	# g2, _54, gz2
# C/parallel-only-omp/collisions.h:102:         new_e.push(xe, wx + F2 * gx2, wy + F2 * gy2, wz + F2 * gz2);
	vmovsd	.LC201(%rip), %xmm6	#, tmp611
	vfmadd213sd	72(%rsp), %xmm6, %xmm3	# %sfp, tmp611, _56
	vfmadd213sd	64(%rsp), %xmm6, %xmm9	# %sfp, tmp611, _58
	vfmadd213sd	56(%rsp), %xmm6, %xmm8	# %sfp, tmp611, _60
# C/parallel-only-omp/state.h:159:         if (__builtin_expect(count < (int)CAPACITY, 1)) {
	cmpl	$4095, %eax	#, _216
	jg	.L1138	#,
# C/parallel-only-omp/state.h:160:             x[count]  = px;
	movslq	%eax, %rdx	# _216, _216
# C/parallel-only-omp/state.h:164:             count++;
	incl	%eax	# tmp594
# C/parallel-only-omp/state.h:160:             x[count]  = px;
	vmovsd	120(%rsp), %xmm0	# %sfp, xe
	leaq	(%r14,%rdx,8), %rdx	#, _1074
	vmovsd	%xmm0, (%rdx)	# xe, *_1074
# C/parallel-only-omp/state.h:161:             vx[count] = pvx;
	vmovsd	%xmm8, 32768(%rdx)	# _60, MEM[(value_type &)_1074 + 32768]
# C/parallel-only-omp/state.h:162:             vy[count] = pvy;
	vmovsd	%xmm9, 65536(%rdx)	# _58, MEM[(value_type &)_1074 + 65536]
# C/parallel-only-omp/state.h:163:             vz[count] = pvz;
	vmovsd	%xmm3, 98304(%rdx)	# _56, MEM[(value_type &)_1074 + 98304]
# C/parallel-only-omp/state.h:164:             count++;
	movl	%eax, 131072(%r14)	# tmp594, new_e_156(D)->count
.L1138:
	vmovsd	%xmm6, 136(%rsp)	# tmp611, %sfp
	vmovsd	%xmm4, 128(%rsp)	# _1100, %sfp
	vmovsd	%xmm10, 112(%rsp)	# _1097, %sfp
	vmovsd	%xmm5, 104(%rsp)	# _1094, %sfp
	vmovsd	%xmm7, 96(%rsp)	# _1091, %sfp
	vmovsd	%xmm11, 48(%rsp)	# e_sc, %sfp
	vmovsd	%xmm2, 40(%rsp)	# cc, %sfp
	vmovsd	%xmm1, (%rsp)	# sc, %sfp
# C/parallel-only-omp/collisions.h:103:         new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
	call	_ZTH3RMB	#
# C/parallel-only-omp/collisions.h:103:         new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0	#
	vmovsd	%xmm0, 152(%rsp)	# tmp643, %sfp
# C/parallel-only-omp/collisions.h:103:         new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
	call	_ZTH3RMB	#
# C/parallel-only-omp/collisions.h:103:         new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0	#
	vmovsd	%xmm0, 144(%rsp)	# tmp644, %sfp
# C/parallel-only-omp/collisions.h:103:         new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
	call	_ZTH3RMB	#
# C/parallel-only-omp/collisions.h:103:         new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0	#
# C/parallel-only-omp/state.h:159:         if (__builtin_expect(count < (int)CAPACITY, 1)) {
	movl	131072(%r13), %eax	# new_i_158(D)->count, _207
# C/parallel-only-omp/state.h:159:         if (__builtin_expect(count < (int)CAPACITY, 1)) {
	vmovsd	(%rsp), %xmm1	# %sfp, sc
	vmovsd	40(%rsp), %xmm2	# %sfp, cc
	vmovsd	48(%rsp), %xmm11	# %sfp, e_sc
	vmovsd	96(%rsp), %xmm7	# %sfp, _1091
	vmovsd	104(%rsp), %xmm5	# %sfp, _1094
	vmovsd	112(%rsp), %xmm10	# %sfp, _1097
	vmovsd	128(%rsp), %xmm4	# %sfp, _1100
	vmovsd	136(%rsp), %xmm6	# %sfp, tmp611
	cmpl	$4095, %eax	#, _207
	jg	.L1140	#,
# C/parallel-only-omp/state.h:160:             x[count]  = px;
	movslq	%eax, %rdx	# _207, _207
# C/parallel-only-omp/state.h:164:             count++;
	incl	%eax	# tmp599
# C/parallel-only-omp/state.h:160:             x[count]  = px;
	vmovsd	120(%rsp), %xmm3	# %sfp, xe
	leaq	0(%r13,%rdx,8), %rdx	#, _348
	vmovsd	%xmm3, (%rdx)	# xe, *_348
# C/parallel-only-omp/state.h:161:             vx[count] = pvx;
	vmovsd	%xmm0, 32768(%rdx)	# _213, MEM[(value_type &)_348 + 32768]
# C/parallel-only-omp/state.h:162:             vy[count] = pvy;
	vmovsd	144(%rsp), %xmm3	# %sfp, _214
	vmovsd	%xmm3, 65536(%rdx)	# _214, MEM[(value_type &)_348 + 65536]
# C/parallel-only-omp/state.h:163:             vz[count] = pvz;
	vmovsd	152(%rsp), %xmm3	# %sfp, _215
	vmovsd	%xmm3, 98304(%rdx)	# _215, MEM[(value_type &)_348 + 98304]
# C/parallel-only-omp/state.h:164:             count++;
	movl	%eax, 131072(%r13)	# tmp599, new_i_158(D)->count
.L1140:
# C/parallel-only-omp/collisions.h:84:         g    = sqrt(e_sc * TWO_OVER_E_MASS);
	vmulsd	.LC198(%rip), %xmm11, %xmm11	#, e_sc, tmp595
	vsqrtsd	%xmm11, %xmm11, %xmm3	# tmp595, g
	vmovsd	%xmm3, 48(%rsp)	# g, %sfp
	jmp	.L1117	#
	.p2align 4
	.p2align 3
.L1178:
# C/parallel-only-omp/collisions.h:72:         energy = fabs(energy - E_EXC_TH * EV_TO_J);
	vsubsd	.LC197(%rip), %xmm0, %xmm0	#, _1102, tmp491
# C/parallel-only-omp/collisions.h:72:         energy = fabs(energy - E_EXC_TH * EV_TO_J);
	vandpd	.LC18(%rip), %xmm0, %xmm0	#, tmp491, energy
# C/parallel-only-omp/collisions.h:73:         g   = sqrt(energy * TWO_OVER_E_MASS);
	vmulsd	.LC198(%rip), %xmm0, %xmm0	#, energy, tmp495
	vsqrtsd	%xmm0, %xmm0, %xmm2	# tmp495, g
	vmovsd	%xmm2, 48(%rsp)	# g, %sfp
# C/parallel-only-omp/collisions.h:74:         cc  = 1.0 - 2.0 * R01(MTgen);                   // cos(chi)
	call	_ZTH3R01	#
# C/parallel-only-omp/collisions.h:74:         cc  = 1.0 - 2.0 * R01(MTgen);                   // cos(chi)
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_956
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, pretmp_956
	ja	.L1183	#,
.L1120:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rax,8), %rdx	# MTgen._M_x[prephitmp_1037], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rcx	#, prephitmp_978
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp743
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp508
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, %fs:4992+MTgen@tpoff	# prephitmp_978, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rax	# __z, tmp503
	shrq	$11, %rax	#, tmp503
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%eax, %eax	# tmp503, _1032
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp504
	salq	$7, %rdx	#, tmp504
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _1029
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rax, %rdx	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rax	# __z, tmp505
	salq	$15, %rax	#, tmp505
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %eax	#, _1026
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _1020
	shrq	$18, %rdx	#, _1020
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _1020, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm7, %xmm1	# __z, tmp743, tmp653
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm0, %xmm1, %xmm1	# tmp508, tmp507, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, prephitmp_978
	ja	.L1184	#,
.L1121:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rax	#, tmp513
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp749
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, %fs:4992+MTgen@tpoff	# tmp513, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rcx,8), %rax	# MTgen._M_x[prephitmp_978], __z
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	(%rsp), %xmm7	# %sfp, tmp615
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp515
	shrq	$11, %rdx	#, tmp515
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp515, _388
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _388, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp516
	salq	$7, %rdx	#, tmp516
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _391
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _391, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp517
	salq	$15, %rdx	#, tmp517
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _394
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _394, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _396
	shrq	$18, %rdx	#, _396
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _396, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm2, %xmm0	# __z, tmp749, tmp654
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm7, %xmm2	#, __ret, tmp615, tmp628
	vmovsd	.LC173(%rip), %xmm1	#, tmp626
	vblendvpd	%xmm2, %xmm1, %xmm0, %xmm0	# tmp628, tmp626, __ret, __ret
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:R01@tpoff, %xmm1	# MEM[(const struct param_type *)&R01]._M_a, _203
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8+R01@tpoff, %xmm2	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm1, %xmm2, %xmm2	# _203, MEM[(const struct param_type *)&R01]._M_b, tmp525
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm0, %xmm1, %xmm2	# __ret, _203, _206
# C/parallel-only-omp/collisions.h:74:         cc  = 1.0 - 2.0 * R01(MTgen);                   // cos(chi)
	vfnmadd132sd	.LC170(%rip), %xmm7, %xmm2	#, tmp615, cc
# C/parallel-only-omp/collisions.h:75:         sc  = sqrt(std::max(0.0, 1.0 - cc * cc));       // sin(chi)
	vfnmadd231sd	%xmm2, %xmm2, %xmm7	# cc, cc, tmp615
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp530
# C/parallel-only-omp/collisions.h:75:         sc  = sqrt(std::max(0.0, 1.0 - cc * cc));       // sin(chi)
	vmovsd	%xmm7, %xmm7, %xmm1	# tmp615, _14
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vcomisd	%xmm0, %xmm7	# tmp530, _14
	ja	.L1185	#,
	vxorpd	%xmm1, %xmm1, %xmm1	# sc
.L1123:
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmovsd	16(%rsp), %xmm6	# %sfp, ct
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmovsd	8(%rsp), %xmm3	# %sfp, st
	vmovsd	32(%rsp), %xmm5	# %sfp, cp
# C/parallel-only-omp/collisions.h:99:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmovsd	24(%rsp), %xmm4	# %sfp, sp
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm5, %xmm3, %xmm7	# cp, st, _1091
# C/parallel-only-omp/collisions.h:99:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm4, %xmm3, %xmm10	# sp, st, _1097
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm6, %xmm5, %xmm5	# ct, cp, _1094
# C/parallel-only-omp/collisions.h:99:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm6, %xmm4, %xmm4	# ct, sp, _1100
	vmovsd	.LC201(%rip), %xmm6	#, tmp611
.L1117:
# C/parallel-only-omp/collisions.h:109:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	88(%rsp), %xmm14	# %sfp, sincostmp_1080
# C/parallel-only-omp/collisions.h:109:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	8(%rsp), %xmm1, %xmm0	# %sfp, sc, tmp600
# C/parallel-only-omp/collisions.h:109:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	16(%rsp), %xmm3	# %sfp, ct
# C/parallel-only-omp/collisions.h:109:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm14, %xmm0, %xmm0	# sincostmp_1080, tmp600, tmp601
# C/parallel-only-omp/collisions.h:110:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm5, %xmm1, %xmm5	# _1094, sc, tmp602
# C/parallel-only-omp/collisions.h:109:     gx = g * (ct * cc - st * sc * ce);
	vfmsub132sd	%xmm2, %xmm0, %xmm3	# cc, tmp601, ct
# C/parallel-only-omp/collisions.h:110:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm14, %xmm5, %xmm5	# sincostmp_1080, tmp602, tmp603
# C/parallel-only-omp/collisions.h:111:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm4, %xmm1, %xmm4	# _1100, sc, tmp605
# C/parallel-only-omp/collisions.h:110:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfmadd132sd	%xmm2, %xmm5, %xmm7	# cc, tmp603, _70
# C/parallel-only-omp/collisions.h:111:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm14, %xmm4, %xmm4	# sincostmp_1080, tmp605, tmp606
# C/parallel-only-omp/collisions.h:110:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	24(%rsp), %xmm1, %xmm0	# %sfp, sc, tmp604
# C/parallel-only-omp/collisions.h:110:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	80(%rsp), %xmm5	# %sfp, se
# C/parallel-only-omp/collisions.h:111:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm10, %xmm4, %xmm2	# _1097, tmp606, _79
# C/parallel-only-omp/collisions.h:111:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	32(%rsp), %xmm1, %xmm1	# %sfp, sc, tmp607
# C/parallel-only-omp/collisions.h:109:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	48(%rsp), %xmm15	# %sfp, g
	vmulsd	%xmm15, %xmm3, %xmm3	# g, _64, gx
# C/parallel-only-omp/collisions.h:113:     (*vxe) = wx + F2 * gx;
	vfmadd213sd	56(%rsp), %xmm6, %xmm3	# %sfp, tmp611, _84
# C/parallel-only-omp/collisions.h:113:     (*vxe) = wx + F2 * gx;
	vmovsd	%xmm3, (%r12)	# _84, *vxe_98(D)
# C/parallel-only-omp/collisions.h:110:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfnmadd132sd	%xmm5, %xmm7, %xmm0	# se, _70, _73
# C/parallel-only-omp/collisions.h:111:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm5, %xmm2, %xmm1	# se, _79, _82
# C/parallel-only-omp/collisions.h:110:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm15, %xmm0, %xmm0	# g, _73, gy
# C/parallel-only-omp/collisions.h:114:     (*vye) = wy + F2 * gy;
	vfmadd213sd	64(%rsp), %xmm6, %xmm0	# %sfp, tmp611, _86
# C/parallel-only-omp/collisions.h:114:     (*vye) = wy + F2 * gy;
	vmovsd	%xmm0, 0(%rbp)	# _86, *vye_100(D)
# C/parallel-only-omp/collisions.h:111:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm15, %xmm1, %xmm1	# g, _82, gz
# C/parallel-only-omp/collisions.h:115:     (*vze) = wz + F2 * gz;
	vfmadd213sd	72(%rsp), %xmm6, %xmm1	# %sfp, tmp611, _88
# C/parallel-only-omp/collisions.h:115:     (*vze) = wz + F2 * gz;
	vmovsd	%xmm1, (%rbx)	# _88, *vze_102(D)
# C/parallel-only-omp/collisions.h:116: }
	addq	$176, %rsp	#,
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
.L1163:
	.cfi_restore_state
# C/parallel-only-omp/collisions.h:50:         cp = 1.0;
	vmovsd	(%rsp), %xmm7	# %sfp, tmp615
# C/parallel-only-omp/collisions.h:51:         sp = 0.0;
	movq	$0x000000000, 24(%rsp)	#, %sfp
# C/parallel-only-omp/collisions.h:50:         cp = 1.0;
	vmovsd	%xmm7, 32(%rsp)	# tmp615, %sfp
	jmp	.L1102	#
	.p2align 4
	.p2align 3
.L1162:
# C/parallel-only-omp/collisions.h:42:         ct = 1.0;
	vmovsd	.LC10(%rip), %xmm3	#, tmp615
# C/parallel-only-omp/collisions.h:43:         st = 0.0;
	movq	$0x000000000, 8(%rsp)	#, %sfp
# C/parallel-only-omp/collisions.h:42:         ct = 1.0;
	vmovsd	%xmm3, (%rsp)	# tmp615, %sfp
	vmovsd	%xmm3, 16(%rsp)	# tmp615, %sfp
	jmp	.L1100	#
	.p2align 4
	.p2align 3
.L1177:
# C/parallel-only-omp/collisions.h:68:         cc = 1.0 - 2.0 * R01(MTgen);                    // cos(chi)
	call	_ZTH3R01	#
# C/parallel-only-omp/collisions.h:68:         cc = 1.0 - 2.0 * R01(MTgen);                    // cos(chi)
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_1023
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, pretmp_1023
	ja	.L1186	#,
.L1112:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rax,8), %rdx	# MTgen._M_x[prephitmp_1069], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rcx	#, prephitmp_1045
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp716
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp467
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, %fs:4992+MTgen@tpoff	# prephitmp_1045, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rax	# __z, tmp462
	shrq	$11, %rax	#, tmp462
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%eax, %eax	# tmp462, _1064
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp463
	salq	$7, %rdx	#, tmp463
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _1061
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rax, %rdx	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rax	# __z, tmp464
	salq	$15, %rax	#, tmp464
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %eax	#, _1058
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _1056
	shrq	$18, %rdx	#, _1056
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _1056, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm2, %xmm1	# __z, tmp716, tmp651
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm0, %xmm1, %xmm1	# tmp467, tmp466, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, prephitmp_1045
	ja	.L1187	#,
.L1113:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rax	#, tmp472
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp722
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, %fs:4992+MTgen@tpoff	# tmp472, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rcx,8), %rax	# MTgen._M_x[prephitmp_1045], __z
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	(%rsp), %xmm6	# %sfp, tmp615
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp474
	shrq	$11, %rdx	#, tmp474
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp474, _355
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _355, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp475
	salq	$7, %rdx	#, tmp475
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _358
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _358, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp476
	salq	$15, %rdx	#, tmp476
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _361
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _361, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _363
	shrq	$18, %rdx	#, _363
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _363, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm2, %xmm0	# __z, tmp722, tmp652
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm6, %xmm2	#, __ret, tmp615, tmp625
	vmovsd	.LC173(%rip), %xmm1	#, tmp623
	vblendvpd	%xmm2, %xmm1, %xmm0, %xmm0	# tmp625, tmp623, __ret, __ret
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:R01@tpoff, %xmm1	# MEM[(const struct param_type *)&R01]._M_a, _196
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8+R01@tpoff, %xmm2	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm1, %xmm2, %xmm2	# _196, MEM[(const struct param_type *)&R01]._M_b, tmp484
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm0, %xmm1, %xmm2	# __ret, _196, _199
# C/parallel-only-omp/collisions.h:68:         cc = 1.0 - 2.0 * R01(MTgen);                    // cos(chi)
	vfnmadd132sd	.LC170(%rip), %xmm6, %xmm2	#, tmp615, cc
# C/parallel-only-omp/collisions.h:69:         sc = sqrt(std::max(0.0, 1.0 - cc * cc));        // sin(chi)
	vfnmadd231sd	%xmm2, %xmm2, %xmm6	# cc, cc, tmp615
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp489
# C/parallel-only-omp/collisions.h:69:         sc = sqrt(std::max(0.0, 1.0 - cc * cc));        // sin(chi)
	vmovsd	%xmm6, %xmm6, %xmm1	# tmp615, _8
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vcomisd	%xmm0, %xmm6	# tmp489, _8
	ja	.L1188	#,
	vxorpd	%xmm1, %xmm1, %xmm1	# sc
.L1115:
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmovsd	8(%rsp), %xmm6	# %sfp, st
	vmovsd	32(%rsp), %xmm5	# %sfp, cp
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmovsd	16(%rsp), %xmm3	# %sfp, ct
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm5, %xmm6, %xmm7	# cp, st, _1091
# C/parallel-only-omp/collisions.h:99:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmovsd	24(%rsp), %xmm4	# %sfp, sp
# C/parallel-only-omp/collisions.h:98:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm3, %xmm5, %xmm5	# ct, cp, _1094
# C/parallel-only-omp/collisions.h:99:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm4, %xmm6, %xmm10	# sp, st, _1097
# C/parallel-only-omp/collisions.h:99:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm3, %xmm4, %xmm4	# ct, sp, _1100
	vmovsd	.LC201(%rip), %xmm6	#, tmp611
	jmp	.L1117	#
	.p2align 4
	.p2align 3
.L1176:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp700
	vmovsd	%xmm0, 80(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp434
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rcx	# MTgen._M_p, prephitmp_861
	vmovsd	80(%rsp), %xmm0	# %sfp, __sum
	jmp	.L1108	#
	.p2align 4
	.p2align 3
.L1175:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp694
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp423
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_839
	jmp	.L1107	#
	.p2align 4
	.p2align 3
.L1174:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp685
	vmovsd	%xmm1, 80(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp404
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rcx	# MTgen._M_p, prephitmp_834
	vmovsd	80(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1105	#
	.p2align 4
	.p2align 3
.L1173:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp679
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp393
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_812
	jmp	.L1104	#
	.p2align 4
	.p2align 3
.L1182:
# C/parallel-only-omp/collisions.h:91:         double sc2 = sqrt(std::max(0.0, 1.0 - cc2 * cc2)); // sin(chi2)
	vsqrtsd	%xmm3, %xmm3, %xmm3	# _31, _954
	jmp	.L1136	#
	.p2align 4
	.p2align 3
.L1185:
# C/parallel-only-omp/collisions.h:75:         sc  = sqrt(std::max(0.0, 1.0 - cc * cc));       // sin(chi)
	vsqrtsd	%xmm1, %xmm1, %xmm1	# _14, sc
	jmp	.L1123	#
	.p2align 4
	.p2align 3
.L1181:
# C/parallel-only-omp/collisions.h:88:         sc   = sqrt(std::max(0.0, 1.0 - cc * cc));      // sin(chi)
	vsqrtsd	%xmm1, %xmm1, %xmm1	# _27, sc
	jmp	.L1131	#
	.p2align 4
	.p2align 3
.L1188:
# C/parallel-only-omp/collisions.h:69:         sc = sqrt(std::max(0.0, 1.0 - cc * cc));        // sin(chi)
	vsqrtsd	%xmm1, %xmm1, %xmm1	# _8, sc
	jmp	.L1115	#
	.p2align 4
	.p2align 3
.L1180:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp768
	vmovsd	%xmm1, 48(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp546
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rcx	# MTgen._M_p, prephitmp_892
	vmovsd	48(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1126	#
	.p2align 4
	.p2align 3
.L1179:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp762
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp535
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_870
	jmp	.L1125	#
	.p2align 4
	.p2align 3
.L1184:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp744
	vmovsd	%xmm1, 40(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp509
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rcx	# MTgen._M_p, prephitmp_978
	vmovsd	40(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1121	#
	.p2align 4
	.p2align 3
.L1183:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp738
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp498
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_956
	jmp	.L1120	#
	.p2align 4
	.p2align 3
.L1187:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp717
	vmovsd	%xmm1, 40(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp468
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rcx	# MTgen._M_p, prephitmp_1045
	vmovsd	40(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1113	#
	.p2align 4
	.p2align 3
.L1186:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp711
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp457
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_1023
	jmp	.L1112	#
.L1168:
	vmovsd	%xmm11, 96(%rsp)	# e_sc, %sfp
	vmovsd	%xmm3, 48(%rsp)	# e_ej, %sfp
# C/parallel-only-omp/collisions.h:85:         g2   = sqrt(e_ej * TWO_OVER_E_MASS);
	vmovsd	%xmm6, %xmm6, %xmm0	# _24,
	call	sqrt@PLT	#
	vmovsd	%xmm0, %xmm0, %xmm6	# tmp641, g2
# C/parallel-only-omp/collisions.h:87:         cc   = sqrt(e_sc / energy);                     // cos(chi) dla elektronu rozproszonego
	vmovsd	96(%rsp), %xmm11	# %sfp, e_sc
	vmovsd	48(%rsp), %xmm3	# %sfp, e_ej
	vdivsd	40(%rsp), %xmm11, %xmm2	# %sfp, e_sc, _336
	jmp	.L1130	#
.L1170:
	vmovsd	%xmm6, 104(%rsp)	# g2, %sfp
	vmovsd	%xmm11, 96(%rsp)	# e_sc, %sfp
	vmovsd	%xmm2, 48(%rsp)	# cc, %sfp
	vmovsd	%xmm1, 40(%rsp)	# sc, %sfp
# C/parallel-only-omp/collisions.h:90:         double cc2 = sqrt(e_ej / energy);               // cos(chi2) dla elektronu wybitego
	call	sqrt@PLT	#
	vmovsd	104(%rsp), %xmm6	# %sfp, g2
	vmovsd	96(%rsp), %xmm11	# %sfp, e_sc
	vmovsd	48(%rsp), %xmm2	# %sfp, cc
	vmovsd	40(%rsp), %xmm1	# %sfp, sc
	jmp	.L1135	#
	.cfi_endproc
.LFE9868:
	.size	_Z18collision_electrondPdS_S_iR12NewParticlesS1_, .-_Z18collision_electrondPdS_S_iR12NewParticlesS1_
	.section	.text._Z25step8_collision_ions_bodyiii,"axG",@progbits,_Z25step8_collision_ions_bodyiii,comdat
	.p2align 4
	.weak	_Z25step8_collision_ions_bodyiii
	.type	_Z25step8_collision_ions_bodyiii, @function
_Z25step8_collision_ions_bodyiii:
.LFB9887:
	.cfi_startproc
	endbr64	
# C/parallel-only-omp/simulation.h:779:     if ((t % N_SUB) != 0) return;
	movslq	%edx, %rcx	# t, t
# C/parallel-only-omp/simulation.h:778: PIC_STEP void step8_collision_ions_body(int tid, int num_threads, int t) {
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
# C/parallel-only-omp/simulation.h:779:     if ((t % N_SUB) != 0) return;
	imulq	$1717986919, %rcx, %rcx	#, t, tmp372
# C/parallel-only-omp/simulation.h:778: PIC_STEP void step8_collision_ions_body(int tid, int num_threads, int t) {
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$312, %rsp	#,
	.cfi_def_cfa_offset 368
# C/parallel-only-omp/simulation.h:778: PIC_STEP void step8_collision_ions_body(int tid, int num_threads, int t) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp679
	movq	%rax, 296(%rsp)	# tmp679, D.134507
	xorl	%eax, %eax	# tmp679
# C/parallel-only-omp/simulation.h:779:     if ((t % N_SUB) != 0) return;
	movl	%edx, %eax	# t, tmp375
	sarl	$31, %eax	#, tmp375
	sarq	$35, %rcx	#, tmp374
	subl	%eax, %ecx	# tmp375, tmp374
	leal	(%rcx,%rcx,4), %eax	#, tmp378
	sall	$2, %eax	#, tmp379
# C/parallel-only-omp/simulation.h:779:     if ((t % N_SUB) != 0) return;
	subl	%eax, %edx	# tmp379, t
	jne	.L1189	#,
	movslq	%esi, %rbp	# tmp659,
# C/parallel-only-omp/simulation.h:782:     int chunk = (N_i + num_threads - 1) / num_threads;
	movl	N_i(%rip), %esi	# N_i, N_i.159_2
	movl	%edx, %r15d	# t, i
	movslq	%edi, %rbx	# tmp658,
# C/parallel-only-omp/simulation.h:782:     int chunk = (N_i + num_threads - 1) / num_threads;
	leal	-1(%rsi,%rbp), %eax	#, tmp381
# C/parallel-only-omp/simulation.h:782:     int chunk = (N_i + num_threads - 1) / num_threads;
	cltd
	idivl	%ebp	# num_threads
# C/parallel-only-omp/simulation.h:783:     int k_start = std::min(tid * chunk, N_i);
	movl	%eax, %r9d	# tmp382, tmp384
	imull	%ebx, %r9d	# tid, tmp384
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%esi, %r9d	# N_i.159_2, tmp384
	cmovg	%esi, %r9d	# tmp384,, N_i.159_2, _44
# C/parallel-only-omp/simulation.h:784:     int k_end = std::min(k_start + chunk, N_i);
	addl	%r9d, %eax	# _44, tmp385
# C/parallel-only-omp/simulation.h:785:     int N_local = k_end - k_start;
	movl	%r9d, 8(%rsp)	# _44, %sfp
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%esi, %eax	# N_i.159_2, tmp385
	cmovle	%eax, %esi	# tmp385,, N_i.159_2
# C/parallel-only-omp/simulation.h:785:     int N_local = k_end - k_start;
	movl	%esi, %r13d	# _437, N_local
	movl	%esi, 16(%rsp)	# _437, %sfp
	subl	%r9d, %r13d	# _44, N_local
# C/parallel-only-omp/simulation.h:787:     if (N_local > 0) {
	testl	%r13d, %r13d	# N_local
	jg	.L1249	#,
.L1191:
	call	GOMP_single_start@PLT	#
	testb	%al, %al	# tmp665
	je	.L1221	#,
.L1262:
# C/parallel-only-omp/simulation.h:821:         for (int t = 0; t < num_threads; ++t) {
	testl	%ebp, %ebp	# num_threads
	jle	.L1221	#,
	movq	168+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, ivtmp.2354
	movq	N_i_coll(%rip), %rcx	# N_i_coll, N_i_coll_lsm.2348
	salq	$6, %rbp	#, tmp619
	leaq	0(%rbp,%rax), %rdx	#, _919
	.p2align 4
	.p2align 3
.L1222:
# C/parallel-only-omp/simulation.h:822:             N_i_coll += worker_buffers.thread_counters[t].local_coll_i;
	addq	40(%rax), %rcx	# MEM[(long long unsigned int *)_914 + 40B], N_i_coll_lsm.2348
# C/parallel-only-omp/simulation.h:823:             worker_buffers.thread_counters[t].local_coll_i = 0;
	movq	$0, 40(%rax)	#, MEM[(long long unsigned int *)_914 + 40B]
# C/parallel-only-omp/simulation.h:821:         for (int t = 0; t < num_threads; ++t) {
	addq	$64, %rax	#, ivtmp.2354
	cmpq	%rdx, %rax	# _919, ivtmp.2354
	jne	.L1222	#,
	movq	%rcx, N_i_coll(%rip)	# N_i_coll_lsm.2348, N_i_coll
.L1221:
	movq	296(%rsp), %rax	# D.134507, tmp680
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp680
	jne	.L1248	#,
# C/parallel-only-omp/simulation.h:826: }
	addq	$312, %rsp	#,
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
	jmp	GOMP_barrier@PLT	#
	.p2align 4
	.p2align 3
.L1249:
	.cfi_restore_state
# /usr/include/c++/13/bits/random.h:3875: 	  _M_initialize();
	leaq	144(%rsp), %r14	#, tmp386
# /usr/include/c++/13/bits/random.h:3870: 	: _M_t(__t), _M_p(__p)
	vmovsd	P_star_i(%rip), %xmm0	# P_star_i, P_star_i.160_7
# /usr/include/c++/13/bits/random.h:3870: 	: _M_t(__t), _M_p(__p)
	movl	%r13d, 144(%rsp)	# N_local, MEM[(struct param_type *)&binom_i]._M_t
# /usr/include/c++/13/bits/random.h:3870: 	: _M_t(__t), _M_p(__p)
	vmovsd	%xmm0, 152(%rsp)	# P_star_i.160_7, MEM[(struct param_type *)&binom_i]._M_p
# /usr/include/c++/13/bits/random.h:3875: 	  _M_initialize();
	movq	%r14, %rdi	# tmp386,
	call	_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv	#
# /usr/include/c++/13/bits/random.h:2034: 	: _M_mean(__mean), _M_stddev(__stddev)
	movq	.LC10(%rip), %rax	#, tmp699
# /usr/include/c++/13/bits/random.h:2034: 	: _M_mean(__mean), _M_stddev(__stddev)
	movq	$0x000000000, 256(%rsp)	#, MEM[(struct param_type *)&binom_i + 112B]._M_mean
# /usr/include/c++/13/bits/random.h:2073:       : _M_param(__mean, __stddev)
	movq	$0x000000000, 272(%rsp)	#, MEM[(struct normal_distribution *)&binom_i + 112B]._M_saved
	movb	$0, 280(%rsp)	#, MEM[(struct normal_distribution *)&binom_i + 112B]._M_saved_available
# /usr/include/c++/13/bits/random.h:2034: 	: _M_mean(__mean), _M_stddev(__stddev)
	movq	%rax, 264(%rsp)	# tmp699, MEM[(struct param_type *)&binom_i + 112B]._M_stddev
# C/parallel-only-omp/simulation.h:789:         int local_N_coll = binom_i(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.h:3981: 	{ return this->operator()(__urng, _M_param); }
	movq	%fs:0, %rax	#, tmp700
	movq	%r14, %rdx	# tmp386,
	movq	%r14, %rdi	# tmp386,
	leaq	MTgen@tpoff(%rax), %rsi	#, tmp391
	call	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE	#
# C/parallel-only-omp/simulation.h:790:         if (local_N_coll > N_local) local_N_coll = N_local;
	cmpl	%eax, %r13d	# tmp661, N_local
	cmovle	%r13d, %eax	# N_local,, tmp661
# C/parallel-only-omp/simulation.h:795:         for (int i = 0; i < local_N_coll; ++i) {
	testl	%eax, %eax	# _66
	jle	.L1191	#,
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	movl	8(%rsp), %r9d	# %sfp, _44
	movl	16(%rsp), %r8d	# %sfp, _437
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp703
	leaq	R01@tpoff, %r12	#, tmp628
	vcvtsi2sdl	%r13d, %xmm4, %xmm0	# N_local, tmp703, tmp667
	leaq	vy_i(%rip), %r14	#, tmp637
	vmovsd	%xmm0, 40(%rsp)	# tmp667, %sfp
	movl	%eax, 52(%rsp)	# _66, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	salq	$6, %rbx	#, tid
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	movl	%ebp, 116(%rsp)	# num_threads, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	%rbx, 64(%rsp)	# tid, %sfp
	leaq	MTgen@tpoff, %rbx	#, tmp633
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	movl	%r9d, 48(%rsp)	# _44, %sfp
	movl	%r8d, 112(%rsp)	# _437, %sfp
	jmp	.L1219	#
	.p2align 4
	.p2align 3
.L1194:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rdx	#, tmp411
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp716
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC10(%rip), %xmm7	#, tmp717
	vmovsd	.LC173(%rip), %xmm6	#, tmp718
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, %fs:4992(%rbx)	# tmp411, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%rbx,%rcx,8), %rdx	# MTgen._M_x[prephitmp_834], __z
# C/parallel-only-omp/simulation.h:796:             int ki = k_start + (int)(R01(MTgen) * N_local);
	movl	48(%rsp), %eax	# %sfp, _44
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:(%r12), %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _80
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rcx	# __z, tmp413
	shrq	$11, %rcx	#, tmp413
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp413, _682
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rdx	# _682, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rcx	# __z, tmp414
	salq	$7, %rcx	#, tmp414
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _685
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rdx	# _685, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rcx	# __z, tmp415
	salq	$15, %rcx	#, tmp415
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _688
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rdx	# _688, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rcx	# __z, _690
	shrq	$18, %rcx	#, _690
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rdx	# _690, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm4, %xmm0	# __z, tmp716, tmp669
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm7, %xmm1	#, __ret, tmp717, tmp642
	vblendvpd	%xmm1, %xmm6, %xmm0, %xmm0	# tmp642, tmp718, __ret, __ret
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%r12), %xmm1	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm1, %xmm1	# _80, MEM[(const struct param_type *)&R01]._M_b, tmp423
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm1, %xmm2, %xmm0	# tmp423, _80, _83
# C/parallel-only-omp/simulation.h:796:             int ki = k_start + (int)(R01(MTgen) * N_local);
	vmulsd	40(%rsp), %xmm0, %xmm0	# %sfp, _83, tmp426
# C/parallel-only-omp/simulation.h:796:             int ki = k_start + (int)(R01(MTgen) * N_local);
	vcvttsd2sil	%xmm0, %ecx	# tmp426, tmp427
# C/parallel-only-omp/simulation.h:796:             int ki = k_start + (int)(R01(MTgen) * N_local);
	leal	(%rcx,%rax), %r13d	#, ki
# C/parallel-only-omp/simulation.h:797:             if (ki >= k_end) ki = k_end - 1;
	movl	112(%rsp), %eax	# %sfp, _437
	leal	-1(%rax), %edx	#, tmp655
	cmpl	%eax, %r13d	# _437, ki
	cmovge	%edx, %r13d	# tmp655,, ki
# C/parallel-only-omp/simulation.h:800:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZTH3RMB	#
# C/parallel-only-omp/simulation.h:800:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0	#
# C/parallel-only-omp/simulation.h:801:             gx = vx_i[ki] - vx_a;
	movslq	%r13d, %r13	# ki, ki
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	vmovsd	%xmm0, 8(%rsp)	# tmp662, %sfp
# C/parallel-only-omp/simulation.h:800:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZTH3RMB	#
# C/parallel-only-omp/simulation.h:800:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0	#
	vmovsd	%xmm0, 16(%rsp)	# tmp663, %sfp
# C/parallel-only-omp/simulation.h:800:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZTH3RMB	#
# C/parallel-only-omp/simulation.h:800:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0	#
# C/parallel-only-omp/simulation.h:801:             gx = vx_i[ki] - vx_a;
	leaq	vx_i(%rip), %rax	#, tmp723
# C/parallel-only-omp/simulation.h:802:             gy = vy_i[ki] - vy_a;
	vmovsd	(%r14,%r13,8), %xmm2	# vy_i[ki_30], vy_i[ki_30]
	vsubsd	16(%rsp), %xmm2, %xmm2	# %sfp, vy_i[ki_30], gy
# C/parallel-only-omp/simulation.h:801:             gx = vx_i[ki] - vx_a;
	vmovsd	(%rax,%r13,8), %xmm1	# vx_i[ki_30], vx_i[ki_30]
# C/parallel-only-omp/simulation.h:804:             g_sqr = gx*gx + gy*gy + gz*gz;
	vmulsd	%xmm2, %xmm2, %xmm2	# gy, gy, tmp437
# C/parallel-only-omp/simulation.h:801:             gx = vx_i[ki] - vx_a;
	vsubsd	8(%rsp), %xmm1, %xmm1	# %sfp, vx_i[ki_30], gx
# C/parallel-only-omp/simulation.h:804:             g_sqr = gx*gx + gy*gy + gz*gz;
	vfmadd132sd	%xmm1, %xmm2, %xmm1	# gx, tmp437, _16
# C/parallel-only-omp/simulation.h:803:             gz = vz_i[ki] - vz_a;
	leaq	vz_i(%rip), %rax	#, tmp726
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	vmovsd	%xmm0, %xmm0, %xmm7	# tmp664, _24
	vmovsd	%xmm0, 32(%rsp)	# _24, %sfp
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	movl	$999999, %edx	#, tmp678
# C/parallel-only-omp/simulation.h:803:             gz = vz_i[ki] - vz_a;
	vmovsd	(%rax,%r13,8), %xmm0	# vz_i[ki_30], vz_i[ki_30]
	vsubsd	%xmm7, %xmm0, %xmm0	# _24, vz_i[ki_30], gz
# C/parallel-only-omp/simulation.h:806:             energy_index = min(int(g_sqr * FACTOR_ENERGY_I + 0.5), CS_RANGES - 1);
	vmovsd	.LC45(%rip), %xmm5	#, tmp728
# C/parallel-only-omp/simulation.h:808:             double real_nu = sigma_tot_i[energy_index] * g;
	leaq	sigma_tot_i(%rip), %rax	#, tmp729
# C/parallel-only-omp/simulation.h:810:             if (p_accept > 1.0) p_accept = 1.0;
	vmovsd	.LC10(%rip), %xmm3	#, tmp730
# C/parallel-only-omp/simulation.h:804:             g_sqr = gx*gx + gy*gy + gz*gz;
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# gz, _16, g_sqr
# C/parallel-only-omp/simulation.h:805:             g = sqrt(g_sqr);
	vsqrtsd	%xmm0, %xmm0, %xmm1	# g_sqr, g
# C/parallel-only-omp/simulation.h:806:             energy_index = min(int(g_sqr * FACTOR_ENERGY_I + 0.5), CS_RANGES - 1);
	vfmadd132sd	.LC202(%rip), %xmm5, %xmm0	#, tmp728, _19
# C/parallel-only-omp/simulation.h:806:             energy_index = min(int(g_sqr * FACTOR_ENERGY_I + 0.5), CS_RANGES - 1);
	vcvttsd2sil	%xmm0, %ebp	# _19, _457
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%edx, %ebp	# tmp678, _457
	cmovg	%edx, %ebp	# _457,, tmp678, _457
# C/parallel-only-omp/simulation.h:808:             double real_nu = sigma_tot_i[energy_index] * g;
	movslq	%ebp, %rbp	# _457, _457
# C/parallel-only-omp/simulation.h:808:             double real_nu = sigma_tot_i[energy_index] * g;
	vmulsd	(%rax,%rbp,8), %xmm1, %xmm1	# sigma_tot_i[_457], g, real_nu
# C/parallel-only-omp/simulation.h:809:             double p_accept = real_nu / nu_star_i;
	vdivsd	nu_star_i(%rip), %xmm1, %xmm1	# nu_star_i, real_nu, p_accept
# C/parallel-only-omp/simulation.h:810:             if (p_accept > 1.0) p_accept = 1.0;
	vminsd	%xmm1, %xmm3, %xmm1	# p_accept, tmp730, p_accept
	vmovsd	%xmm1, 24(%rsp)	# p_accept, %sfp
# C/parallel-only-omp/simulation.h:812:             if (R01(MTgen) < p_accept) {
	call	_ZTH3R01	#
# C/parallel-only-omp/simulation.h:812:             if (R01(MTgen) < p_accept) {
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992(%rbx), %rdx	# MTgen._M_p, _587
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	vmovsd	24(%rsp), %xmm1	# %sfp, p_accept
	cmpq	$623, %rdx	#, _587
	ja	.L1250	#,
.L1198:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rsi	#, _591
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%rbx,%rdx,8), %rdx	# MTgen._M_x[prephitmp_846], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp736
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp737
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rsi, %fs:4992(%rbx)	# _591, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rdi	# __z, tmp450
	shrq	$11, %rdi	#, tmp450
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edi, %edi	# tmp450, _595
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdi, %rdx	# _595, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rdi	# __z, tmp451
	salq	$7, %rdi	#, tmp451
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edi	#, _598
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdi, %rdx	# _598, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rdi	# __z, tmp452
	salq	$15, %rdi	#, tmp452
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edi	#, _601
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdi, %rdx	# _601, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rdi	# __z, _603
	shrq	$18, %rdi	#, _603
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdi, %rdx	# _603, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm4, %xmm2	# __z, tmp736, tmp670
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm6, %xmm2, %xmm2	# tmp737, tmp454, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rsi	#, _591
	ja	.L1251	#,
.L1199:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rsi), %rdx	#, tmp460
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp743
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC173(%rip), %xmm4	#, tmp745
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:(%r12), %xmm3	# MEM[(const struct param_type *)&R01]._M_a, _90
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, %fs:4992(%rbx)	# tmp460, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%rbx,%rsi,8), %rdx	# MTgen._M_x[prephitmp_849], __z
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rsi	# __z, tmp462
	shrq	$11, %rsi	#, tmp462
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%esi, %esi	# tmp462, _624
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rsi, %rdx	# _624, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rsi	# __z, tmp463
	salq	$7, %rsi	#, tmp463
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %esi	#, _627
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rsi, %rdx	# _627, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rsi	# __z, tmp464
	salq	$15, %rsi	#, tmp464
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %esi	#, _630
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rsi, %rdx	# _630, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rsi	# __z, _632
	shrq	$18, %rsi	#, _632
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rsi, %rdx	# _632, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm5, %xmm0	# __z, tmp743, tmp671
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC10(%rip), %xmm5	#, tmp744
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm2, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm5, %xmm2	#, __ret, tmp744, tmp645
	vblendvpd	%xmm2, %xmm4, %xmm0, %xmm0	# tmp645, tmp745, __ret, __ret
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%r12), %xmm2	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm3, %xmm2, %xmm2	# _90, MEM[(const struct param_type *)&R01]._M_b, tmp472
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm2, %xmm3, %xmm0	# tmp472, _90, _93
# C/parallel-only-omp/simulation.h:812:             if (R01(MTgen) < p_accept) {
	vcomisd	%xmm0, %xmm1	# _93, p_accept
	ja	.L1252	#,
# C/parallel-only-omp/simulation.h:795:         for (int i = 0; i < local_N_coll; ++i) {
	incl	%r15d	# i
# C/parallel-only-omp/simulation.h:795:         for (int i = 0; i < local_N_coll; ++i) {
	cmpl	%r15d, 52(%rsp)	# i, %sfp
	je	.L1253	#,
.L1219:
# C/parallel-only-omp/simulation.h:796:             int ki = k_start + (int)(R01(MTgen) * N_local);
	call	_ZTH3R01	#
# C/parallel-only-omp/simulation.h:796:             int ki = k_start + (int)(R01(MTgen) * N_local);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992(%rbx), %rdx	# MTgen._M_p, _645
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _645
	ja	.L1254	#,
.L1193:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rcx	#, _649
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%rbx,%rdx,8), %rdx	# MTgen._M_x[prephitmp_831], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp709
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp710
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, %fs:4992(%rbx)	# _649, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rsi	# __z, tmp401
	shrq	$11, %rsi	#, tmp401
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%esi, %esi	# tmp401, _653
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rsi, %rdx	# _653, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rsi	# __z, tmp402
	salq	$7, %rsi	#, tmp402
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %esi	#, _656
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rsi, %rdx	# _656, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rsi	# __z, tmp403
	salq	$15, %rsi	#, tmp403
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %esi	#, _659
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rsi, %rdx	# _659, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rsi	# __z, _661
	shrq	$18, %rsi	#, _661
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rsi, %rdx	# _661, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm5, %xmm1	# __z, tmp709, tmp668
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm3, %xmm1, %xmm1	# tmp710, tmp405, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, _649
	jbe	.L1194	#,
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp711
	vmovsd	%xmm1, 8(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp407
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbx), %rcx	# MTgen._M_p, _649
	vmovsd	8(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1194	#
	.p2align 4
	.p2align 3
.L1254:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp704
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp396
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbx), %rdx	# MTgen._M_p, _645
	jmp	.L1193	#
	.p2align 4
	.p2align 3
.L1252:
# C/parallel-only-omp/collisions.h:127:     double t1 = sigma[I_ISO][e_index];
	leaq	sigma(%rip), %rdx	#, tmp474
	vmovsd	24000000(%rdx,%rbp,8), %xmm7	# sigma[3][_457], t1
# C/parallel-only-omp/collisions.h:128:     double t2 = t1 + sigma[I_BACK][e_index];
	vaddsd	32000000(%rdx,%rbp,8), %xmm7, %xmm4	# sigma[4][_457], t1, t2
# C/parallel-only-omp/collisions.h:127:     double t1 = sigma[I_ISO][e_index];
	vmovsd	%xmm7, 24(%rsp)	# t1, %sfp
# C/parallel-only-omp/collisions.h:128:     double t2 = t1 + sigma[I_BACK][e_index];
	vmovsd	%xmm4, 56(%rsp)	# t2, %sfp
# C/parallel-only-omp/collisions.h:129:     double rnd = R01(MTgen);
	call	_ZTH3R01	#
# C/parallel-only-omp/collisions.h:129:     double rnd = R01(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992(%rbx), %rdx	# MTgen._M_p, _529
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _529
	ja	.L1255	#,
.L1203:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rsi	#, _533
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%rbx,%rdx,8), %rdx	# MTgen._M_x[prephitmp_855], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp754
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp755
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rsi, %fs:4992(%rbx)	# _533, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rdi	# __z, tmp486
	shrq	$11, %rdi	#, tmp486
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edi, %edi	# tmp486, _537
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdi, %rdx	# _537, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rdi	# __z, tmp487
	salq	$7, %rdi	#, tmp487
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edi	#, _540
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdi, %rdx	# _540, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rdi	# __z, tmp488
	salq	$15, %rdi	#, tmp488
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edi	#, _543
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdi, %rdx	# _543, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rdi	# __z, _545
	shrq	$18, %rdi	#, _545
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdi, %rdx	# _545, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm5, %xmm1	# __z, tmp754, tmp672
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm4, %xmm1, %xmm1	# tmp755, tmp490, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rsi	#, _533
	ja	.L1256	#,
.L1204:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rsi), %rdx	#, tmp496
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp761
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC10(%rip), %xmm7	#, tmp762
	vmovsd	.LC173(%rip), %xmm6	#, tmp763
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, %fs:4992(%rbx)	# tmp496, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%rbx,%rsi,8), %rdx	# MTgen._M_x[prephitmp_858], __z
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:(%r12), %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _196
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rsi	# __z, tmp498
	shrq	$11, %rsi	#, tmp498
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%esi, %esi	# tmp498, _566
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rsi, %rdx	# _566, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rsi	# __z, tmp499
	salq	$7, %rsi	#, tmp499
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %esi	#, _569
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rsi, %rdx	# _569, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rsi	# __z, tmp500
	salq	$15, %rsi	#, tmp500
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %esi	#, _572
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rsi, %rdx	# _572, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rsi	# __z, _574
	shrq	$18, %rsi	#, _574
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rsi, %rdx	# _574, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm3, %xmm0	# __z, tmp761, tmp673
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm7, %xmm1	#, __ret, tmp762, tmp648
	vblendvpd	%xmm1, %xmm6, %xmm0, %xmm0	# tmp648, tmp763, __ret, __ret
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%r12), %xmm1	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm1, %xmm1	# _196, MEM[(const struct param_type *)&R01]._M_b, tmp508
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm1, %xmm2, %xmm0	# tmp508, _196, _199
# C/parallel-only-omp/collisions.h:131:     if (rnd * t2 >= t1) {
	vmulsd	56(%rsp), %xmm0, %xmm0	# %sfp, _199, tmp510
# C/parallel-only-omp/collisions.h:131:     if (rnd * t2 >= t1) {
	vcomisd	24(%rsp), %xmm0	# %sfp, tmp510
	jnb	.L1206	#,
# C/parallel-only-omp/collisions.h:144:     double gx = (*vx_1) - (*vx_2);
	leaq	vx_i(%rip), %rax	#, tmp766
# C/parallel-only-omp/collisions.h:145:     double gy = (*vy_1) - (*vy_2);
	vmovsd	16(%rsp), %xmm13	# %sfp, _85
# C/parallel-only-omp/collisions.h:146:     double gz = (*vz_1) - (*vz_2);
	vmovsd	32(%rsp), %xmm14	# %sfp, _24
# C/parallel-only-omp/collisions.h:145:     double gy = (*vy_1) - (*vy_2);
	vmovsd	(%r14,%r13,8), %xmm2	# MEM <double[1000000]> [(double *)&vy_i][ki_30], _207
# C/parallel-only-omp/collisions.h:144:     double gx = (*vx_1) - (*vx_2);
	vmovsd	(%rax,%r13,8), %xmm3	# MEM <double[1000000]> [(double *)&vx_i][ki_30], _204
# C/parallel-only-omp/collisions.h:146:     double gz = (*vz_1) - (*vz_2);
	leaq	vz_i(%rip), %rax	#, tmp769
# C/parallel-only-omp/collisions.h:145:     double gy = (*vy_1) - (*vy_2);
	vsubsd	%xmm13, %xmm2, %xmm5	# _85, _207, gy
# C/parallel-only-omp/collisions.h:144:     double gx = (*vx_1) - (*vx_2);
	vmovsd	8(%rsp), %xmm12	# %sfp, _84
# C/parallel-only-omp/collisions.h:146:     double gz = (*vz_1) - (*vz_2);
	vmovsd	(%rax,%r13,8), %xmm1	# MEM <double[1000000]> [(double *)&vz_i][ki_30], _210
# C/parallel-only-omp/collisions.h:146:     double gz = (*vz_1) - (*vz_2);
	vsubsd	%xmm14, %xmm1, %xmm4	# _24, _210, gz
# C/parallel-only-omp/collisions.h:147:     double g_perp_sq = gy * gy + gz * gz;
	vmulsd	%xmm4, %xmm4, %xmm0	# gz, gz, tmp517
# C/parallel-only-omp/collisions.h:147:     double g_perp_sq = gy * gy + gz * gz;
	vfmadd231sd	%xmm5, %xmm5, %xmm0	# gy, gy, g_perp_sq
# C/parallel-only-omp/collisions.h:144:     double gx = (*vx_1) - (*vx_2);
	vsubsd	%xmm12, %xmm3, %xmm6	# _84, _204, gx
# C/parallel-only-omp/collisions.h:148:     double g_sq      = gx * gx + g_perp_sq;
	vmovsd	%xmm6, %xmm6, %xmm7	# gx, g_sq
# C/parallel-only-omp/collisions.h:152:     double wx = 0.5 * ((*vx_1) + (*vx_2));
	vaddsd	%xmm12, %xmm3, %xmm3	# _84, _204, tmp518
# C/parallel-only-omp/collisions.h:153:     double wy = 0.5 * ((*vy_1) + (*vy_2));
	vaddsd	%xmm13, %xmm2, %xmm2	# _85, _207, tmp520
# C/parallel-only-omp/collisions.h:152:     double wx = 0.5 * ((*vx_1) + (*vx_2));
	vmulsd	.LC45(%rip), %xmm3, %xmm3	#, tmp518, wx
# C/parallel-only-omp/collisions.h:154:     double wz = 0.5 * ((*vz_1) + (*vz_2));
	vaddsd	%xmm14, %xmm1, %xmm1	# _24, _210, tmp522
# C/parallel-only-omp/collisions.h:152:     double wx = 0.5 * ((*vx_1) + (*vx_2));
	vmovsd	%xmm3, 16(%rsp)	# wx, %sfp
# C/parallel-only-omp/collisions.h:153:     double wy = 0.5 * ((*vy_1) + (*vy_2));
	vmulsd	.LC45(%rip), %xmm2, %xmm3	#, tmp520, wy
	vmovsd	%xmm3, 24(%rsp)	# wy, %sfp
# C/parallel-only-omp/collisions.h:154:     double wz = 0.5 * ((*vz_1) + (*vz_2));
	vmulsd	.LC45(%rip), %xmm1, %xmm3	#, tmp522, wz
	vmovsd	%xmm3, 32(%rsp)	# wz, %sfp
# C/parallel-only-omp/collisions.h:156:     double ct = (g > 0.0) ? (gx / g) : 1.0;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp780
# C/parallel-only-omp/collisions.h:148:     double g_sq      = gx * gx + g_perp_sq;
	vfmadd132sd	%xmm6, %xmm0, %xmm7	# gx, g_perp_sq, g_sq
# C/parallel-only-omp/collisions.h:150:     double g_perp    = sqrt(g_perp_sq);
	vsqrtsd	%xmm0, %xmm0, %xmm0	# g_perp_sq, g_perp
# C/parallel-only-omp/collisions.h:149:     double g         = sqrt(g_sq);
	vsqrtsd	%xmm7, %xmm7, %xmm7	# g_sq, g
	vmovsd	%xmm7, 8(%rsp)	# g, %sfp
# C/parallel-only-omp/collisions.h:156:     double ct = (g > 0.0) ? (gx / g) : 1.0;
	vcomisd	%xmm3, %xmm7	# tmp780, g
	jbe	.L1243	#,
# C/parallel-only-omp/collisions.h:156:     double ct = (g > 0.0) ? (gx / g) : 1.0;
	vdivsd	%xmm7, %xmm6, %xmm6	# g, gx, iftmp.168_226
# C/parallel-only-omp/collisions.h:157:     double st = (g > 0.0) ? (g_perp / g) : 0.0;
	vdivsd	%xmm7, %xmm0, %xmm3	# g, g_perp, iftmp.169_227
# C/parallel-only-omp/collisions.h:156:     double ct = (g > 0.0) ? (gx / g) : 1.0;
	vmovsd	%xmm6, 56(%rsp)	# iftmp.168_226, %sfp
# C/parallel-only-omp/collisions.h:157:     double st = (g > 0.0) ? (g_perp / g) : 0.0;
	vmovsd	%xmm3, 72(%rsp)	# iftmp.169_227, %sfp
# C/parallel-only-omp/collisions.h:158:     double cp = (g_perp > 0.0) ? (gy / g_perp) : 1.0;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp786
	vcomisd	%xmm6, %xmm0	# tmp786, g_perp
	jbe	.L1244	#,
.L1263:
# C/parallel-only-omp/collisions.h:158:     double cp = (g_perp > 0.0) ? (gy / g_perp) : 1.0;
	vdivsd	%xmm0, %xmm5, %xmm5	# g_perp, gy, iftmp.170_228
	vmovsd	%xmm5, 80(%rsp)	# iftmp.170_228, %sfp
# C/parallel-only-omp/collisions.h:159:     double sp = (g_perp > 0.0) ? (gz / g_perp) : 0.0;
	vdivsd	%xmm0, %xmm4, %xmm5	# g_perp, gz, iftmp.171_229
	vmovsd	%xmm5, 88(%rsp)	# iftmp.171_229, %sfp
.L1209:
# C/parallel-only-omp/collisions.h:161:     double cc = 1.0 - 2.0 * R01(MTgen);              // cos(chi)
	call	_ZTH3R01	#
# C/parallel-only-omp/collisions.h:161:     double cc = 1.0 - 2.0 * R01(MTgen);              // cos(chi)
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992(%rbx), %rdx	# MTgen._M_p, _471
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _471
	ja	.L1257	#,
.L1211:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rsi	#, _475
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%rbx,%rdx,8), %rdx	# MTgen._M_x[prephitmp_866], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp795
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rsi, %fs:4992(%rbx)	# _475, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rdi	# __z, tmp532
	shrq	$11, %rdi	#, tmp532
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edi, %edi	# tmp532, _479
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdi, %rdx	# _479, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rdi	# __z, tmp533
	salq	$7, %rdi	#, tmp533
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edi	#, _482
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdi, %rdx	# _482, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rdi	# __z, tmp534
	salq	$15, %rdi	#, tmp534
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edi	#, _485
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdi, %rdx	# _485, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rdi	# __z, _487
	shrq	$18, %rdi	#, _487
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdi, %rdx	# _487, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm5, %xmm1	# __z, tmp795, tmp674
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp796
	vaddsd	%xmm5, %xmm1, %xmm1	# tmp796, tmp536, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rsi	#, _475
	ja	.L1258	#,
.L1212:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rsi), %rdx	#, tmp542
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC10(%rip), %xmm7	#, tmp803
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp802
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp808
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, %fs:4992(%rbx)	# tmp542, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%rbx,%rsi,8), %rdx	# MTgen._M_x[prephitmp_869], __z
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rsi	# __z, tmp544
	shrq	$11, %rsi	#, tmp544
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%esi, %esi	# tmp544, _508
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rsi, %rdx	# _508, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rsi	# __z, tmp545
	salq	$7, %rsi	#, tmp545
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %esi	#, _511
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rsi, %rdx	# _511, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rsi	# __z, tmp546
	salq	$15, %rsi	#, tmp546
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %esi	#, _514
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rsi, %rdx	# _514, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rsi	# __z, _516
	shrq	$18, %rsi	#, _516
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rsi, %rdx	# _516, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm4, %xmm0	# __z, tmp802, tmp675
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm7, %xmm2	#, __ret, tmp803, tmp651
	vmovsd	.LC173(%rip), %xmm1	#, tmp649
	vblendvpd	%xmm2, %xmm1, %xmm0, %xmm0	# tmp651, tmp649, __ret, __ret
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:(%r12), %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _232
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%r12), %xmm1	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm1, %xmm1	# _232, MEM[(const struct param_type *)&R01]._M_b, tmp554
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm1, %xmm2, %xmm0	# tmp554, _232, _235
# C/parallel-only-omp/collisions.h:161:     double cc = 1.0 - 2.0 * R01(MTgen);              // cos(chi)
	vfnmadd132sd	.LC170(%rip), %xmm7, %xmm0	#, tmp805, _235
	vmovsd	%xmm0, %xmm0, %xmm4	# _235, cc
	vmovsd	%xmm0, 96(%rsp)	# cc, %sfp
# C/parallel-only-omp/collisions.h:162:     double sc = sqrt(std::max(0.0, 1.0 - cc * cc));  // sin(chi)
	vmovsd	%xmm7, %xmm7, %xmm0	# tmp805, _239
	vfnmadd231sd	%xmm4, %xmm4, %xmm0	# cc, cc, _239
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vcomisd	%xmm6, %xmm0	# tmp808, _239
	ja	.L1259	#,
	movq	$0x000000000, 104(%rsp)	#, %sfp
.L1214:
# C/parallel-only-omp/collisions.h:164:     double eta = TWO_PI * R01(MTgen);
	call	_ZTH3R01	#
# C/parallel-only-omp/collisions.h:164:     double eta = TWO_PI * R01(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992(%rbx), %rdx	# MTgen._M_p, _452
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _452
	ja	.L1260	#,
.L1216:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%rbx,%rdx,8), %rdi	# MTgen._M_x[prephitmp_886], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rsi	#, _170
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp815
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp816
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rsi, %fs:4992(%rbx)	# _170, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdi, %rdx	# __z, tmp566
	shrq	$11, %rdx	#, tmp566
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp566, _299
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rdi	# _299, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdi, %rdx	# __z, tmp567
	salq	$7, %rdx	#, tmp567
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _205
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdi, %rdx	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rdi	# __z, tmp568
	salq	$15, %rdi	#, tmp568
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edi	#, _331
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdi, %rdx	# _331, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rdi	# __z, _433
	shrq	$18, %rdi	#, _433
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdi, %rdx	# _433, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm4, %xmm1	# __z, tmp815, tmp676
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm5, %xmm1, %xmm1	# tmp816, tmp570, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rsi	#, _170
	ja	.L1261	#,
.L1217:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rsi), %rdx	#, tmp576
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp822
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC10(%rip), %xmm5	#, tmp823
	leaq	136(%rsp), %rdi	#, tmp590
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, %fs:4992(%rbx)	# tmp576, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%rbx,%rsi,8), %rdx	# MTgen._M_x[prephitmp_889], __z
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rsi	# __z, tmp578
	shrq	$11, %rsi	#, tmp578
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%esi, %esi	# tmp578, _50
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rsi	# __z, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rsi, %rdx	# __z, tmp579
	salq	$7, %rdx	#, tmp579
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _55
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rsi, %rdx	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rsi	# __z, tmp580
	salq	$15, %rsi	#, tmp580
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %esi	#, _124
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rsi, %rdx	# _124, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rsi	# __z, _458
	shrq	$18, %rsi	#, _458
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rsi, %rdx	# _458, __z
	leaq	128(%rsp), %rsi	#, tmp591
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm6, %xmm0	# __z, tmp822, tmp677
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm5, %xmm2	#, __ret, tmp823, tmp654
	vmovsd	.LC173(%rip), %xmm1	#, tmp652
	vblendvpd	%xmm2, %xmm1, %xmm0, %xmm0	# tmp654, tmp652, __ret, __ret
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:(%r12), %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _245
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%r12), %xmm1	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm1, %xmm1	# _245, MEM[(const struct param_type *)&R01]._M_b, tmp588
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm1, %xmm2, %xmm0	# tmp588, _245, _248
# C/parallel-only-omp/collisions.h:164:     double eta = TWO_PI * R01(MTgen);
	vmulsd	.LC196(%rip), %xmm0, %xmm0	#, _248, eta
	call	sincos@PLT	#
# C/parallel-only-omp/collisions.h:169:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	104(%rsp), %xmm6	# %sfp, _883
	vmovsd	128(%rsp), %xmm5	#, sincostmp_445
	vmovsd	72(%rsp), %xmm7	# %sfp, iftmp.169_227
# C/parallel-only-omp/collisions.h:169:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	96(%rsp), %xmm8	# %sfp, cc
	vmovsd	56(%rsp), %xmm9	# %sfp, iftmp.168_226
# C/parallel-only-omp/collisions.h:170:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	80(%rsp), %xmm11	# %sfp, iftmp.170_228
	vmulsd	%xmm11, %xmm7, %xmm2	# iftmp.170_228, iftmp.169_227, tmp596
# C/parallel-only-omp/collisions.h:170:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm9, %xmm11, %xmm0	# iftmp.168_226, iftmp.170_228, tmp597
# C/parallel-only-omp/collisions.h:170:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm6, %xmm0, %xmm0	# _883, tmp597, tmp598
# C/parallel-only-omp/collisions.h:170:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm5, %xmm0, %xmm0	# sincostmp_445, tmp598, tmp599
# C/parallel-only-omp/collisions.h:170:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfmadd231sd	%xmm8, %xmm2, %xmm0	# cc, tmp596, _265
# C/parallel-only-omp/collisions.h:170:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	88(%rsp), %xmm3	# %sfp, iftmp.171_229
	vmovsd	136(%rsp), %xmm4	#, sincostmp_445
	vmulsd	%xmm3, %xmm6, %xmm2	# iftmp.171_229, _883, tmp600
# C/parallel-only-omp/collisions.h:169:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm6, %xmm7, %xmm1	# _883, iftmp.169_227, tmp594
# C/parallel-only-omp/collisions.h:169:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm5, %xmm1, %xmm1	# sincostmp_445, tmp594, tmp595
# C/parallel-only-omp/collisions.h:169:     gx = g * (ct * cc - st * sc * ce);
	vfmsub231sd	%xmm9, %xmm8, %xmm1	# iftmp.168_226, cc, _257
# C/parallel-only-omp/collisions.h:169:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	8(%rsp), %xmm10	# %sfp, g
# C/parallel-only-omp/collisions.h:170:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfnmadd132sd	%xmm4, %xmm0, %xmm2	# sincostmp_445, _265, _269
# C/parallel-only-omp/collisions.h:171:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmovsd	%xmm3, %xmm3, %xmm0	# iftmp.171_229, iftmp.171_229
	vmulsd	%xmm7, %xmm3, %xmm3	# iftmp.169_227, iftmp.171_229, tmp601
# C/parallel-only-omp/collisions.h:171:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm9, %xmm0, %xmm0	# iftmp.168_226, iftmp.171_229, tmp602
# C/parallel-only-omp/collisions.h:171:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm6, %xmm0, %xmm0	# _883, tmp602, tmp603
# C/parallel-only-omp/collisions.h:171:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm5, %xmm0, %xmm0	# sincostmp_445, tmp603, tmp604
# C/parallel-only-omp/collisions.h:171:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd231sd	%xmm8, %xmm3, %xmm0	# cc, tmp601, _276
# C/parallel-only-omp/collisions.h:171:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm11, %xmm6, %xmm3	# iftmp.170_228, _883, tmp605
# C/parallel-only-omp/collisions.h:169:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm10, %xmm1, %xmm1	# g, _257, gx
# C/parallel-only-omp/collisions.h:170:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm10, %xmm2, %xmm2	# g, _269, gy
# C/parallel-only-omp/collisions.h:171:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm3, %xmm0, %xmm4	# tmp605, _276, _279
# C/parallel-only-omp/collisions.h:171:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm10, %xmm4, %xmm0	# g, _279, gz
# C/parallel-only-omp/collisions.h:173:     (*vx_1) = wx + 0.5 * gx;
	vmovsd	.LC45(%rip), %xmm4	#, tmp848
	vfmadd213sd	16(%rsp), %xmm4, %xmm1	# %sfp, tmp848, gx
# C/parallel-only-omp/collisions.h:174:     (*vy_1) = wy + 0.5 * gy;
	vfmadd213sd	24(%rsp), %xmm4, %xmm2	# %sfp, tmp851, gy
# C/parallel-only-omp/collisions.h:175:     (*vz_1) = wz + 0.5 * gz;
	vfmadd213sd	32(%rsp), %xmm4, %xmm0	# %sfp, tmp854, gz
# C/parallel-only-omp/collisions.h:173:     (*vx_1) = wx + 0.5 * gx;
	vmovsd	%xmm1, 8(%rsp)	# gx, %sfp
# C/parallel-only-omp/collisions.h:174:     (*vy_1) = wy + 0.5 * gy;
	vmovsd	%xmm2, 16(%rsp)	# gy, %sfp
# C/parallel-only-omp/collisions.h:175:     (*vz_1) = wz + 0.5 * gz;
	vmovsd	%xmm0, 32(%rsp)	# gz, %sfp
.L1206:
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	64(%rsp), %rdx	# %sfp, _96
# C/parallel-only-omp/collisions.h:135:         *vx_1 = *vx_2;
	leaq	vx_i(%rip), %rax	#, tmp856
	vmovsd	8(%rsp), %xmm3	# %sfp, _84
# C/parallel-only-omp/collisions.h:136:         *vy_1 = *vy_2;
	vmovsd	16(%rsp), %xmm5	# %sfp, _85
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	168+worker_buffers(%rip), %rdx	# MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, _96
# C/parallel-only-omp/collisions.h:135:         *vx_1 = *vx_2;
	vmovsd	%xmm3, (%rax,%r13,8)	# _84, MEM <double[1000000]> [(double *)&vx_i][ki_30]
# C/parallel-only-omp/collisions.h:137:         *vz_1 = *vz_2;
	leaq	vz_i(%rip), %rax	#, tmp859
# C/parallel-only-omp/collisions.h:136:         *vy_1 = *vy_2;
	vmovsd	%xmm5, (%r14,%r13,8)	# _85, MEM <double[1000000]> [(double *)&vy_i][ki_30]
# C/parallel-only-omp/collisions.h:137:         *vz_1 = *vz_2;
	vmovsd	32(%rsp), %xmm6	# %sfp, _24
# C/parallel-only-omp/simulation.h:795:         for (int i = 0; i < local_N_coll; ++i) {
	incl	%r15d	# i
# C/parallel-only-omp/collisions.h:137:         *vz_1 = *vz_2;
	vmovsd	%xmm6, (%rax,%r13,8)	# _24, MEM <double[1000000]> [(double *)&vz_i][ki_30]
# C/parallel-only-omp/simulation.h:814:                 worker_buffers.thread_counters[tid].local_coll_i++;
	incq	40(%rdx)	# _96->local_coll_i
# C/parallel-only-omp/simulation.h:795:         for (int i = 0; i < local_N_coll; ++i) {
	cmpl	%r15d, 52(%rsp)	# i, %sfp
	jne	.L1219	#,
.L1253:
	movslq	116(%rsp), %rbp	# %sfp,
	call	GOMP_single_start@PLT	#
	testb	%al, %al	# tmp665
	je	.L1221	#,
	jmp	.L1262	#
	.p2align 4
	.p2align 3
.L1251:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp738
	vmovsd	%xmm2, 56(%rsp)	# __sum, %sfp
	vmovsd	%xmm1, 24(%rsp)	# p_accept, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp456
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbx), %rsi	# MTgen._M_p, _591
	vmovsd	56(%rsp), %xmm2	# %sfp, __sum
	vmovsd	24(%rsp), %xmm1	# %sfp, p_accept
	jmp	.L1199	#
	.p2align 4
	.p2align 3
.L1250:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp731
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp445
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbx), %rdx	# MTgen._M_p, _587
	vmovsd	24(%rsp), %xmm1	# %sfp, p_accept
	jmp	.L1198	#
	.p2align 4
	.p2align 3
.L1189:
# C/parallel-only-omp/simulation.h:826: }
	movq	296(%rsp), %rax	# D.134507, tmp681
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp681
	jne	.L1248	#,
	addq	$312, %rsp	#,
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
.L1255:
	.cfi_restore_state
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp749
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp481
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbx), %rdx	# MTgen._M_p, _529
	jmp	.L1203	#
	.p2align 4
	.p2align 3
.L1256:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp756
	vmovsd	%xmm1, 72(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp492
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbx), %rsi	# MTgen._M_p, _533
	vmovsd	72(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1204	#
	.p2align 4
	.p2align 3
.L1243:
# C/parallel-only-omp/collisions.h:156:     double ct = (g > 0.0) ? (gx / g) : 1.0;
	movq	.LC10(%rip), %rax	#, tmp785
# C/parallel-only-omp/collisions.h:158:     double cp = (g_perp > 0.0) ? (gy / g_perp) : 1.0;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp786
# C/parallel-only-omp/collisions.h:157:     double st = (g > 0.0) ? (g_perp / g) : 0.0;
	movq	$0x000000000, 72(%rsp)	#, %sfp
# C/parallel-only-omp/collisions.h:158:     double cp = (g_perp > 0.0) ? (gy / g_perp) : 1.0;
	vcomisd	%xmm6, %xmm0	# tmp786, g_perp
# C/parallel-only-omp/collisions.h:156:     double ct = (g > 0.0) ? (gx / g) : 1.0;
	movq	%rax, 56(%rsp)	# tmp785, %sfp
# C/parallel-only-omp/collisions.h:158:     double cp = (g_perp > 0.0) ? (gy / g_perp) : 1.0;
	ja	.L1263	#,
.L1244:
# C/parallel-only-omp/collisions.h:158:     double cp = (g_perp > 0.0) ? (gy / g_perp) : 1.0;
	movq	.LC10(%rip), %rax	#, tmp789
# C/parallel-only-omp/collisions.h:159:     double sp = (g_perp > 0.0) ? (gz / g_perp) : 0.0;
	movq	$0x000000000, 88(%rsp)	#, %sfp
# C/parallel-only-omp/collisions.h:158:     double cp = (g_perp > 0.0) ? (gy / g_perp) : 1.0;
	movq	%rax, 80(%rsp)	# tmp789, %sfp
	jmp	.L1209	#
	.p2align 4
	.p2align 3
.L1259:
# C/parallel-only-omp/collisions.h:162:     double sc = sqrt(std::max(0.0, 1.0 - cc * cc));  // sin(chi)
	vsqrtsd	%xmm0, %xmm0, %xmm4	# _239, _883
	vmovsd	%xmm4, 104(%rsp)	# _883, %sfp
	jmp	.L1214	#
	.p2align 4
	.p2align 3
.L1258:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp797
	vmovsd	%xmm1, 96(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp538
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbx), %rsi	# MTgen._M_p, _475
	vmovsd	96(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1212	#
	.p2align 4
	.p2align 3
.L1261:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp817
	vmovsd	%xmm1, 120(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp572
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbx), %rsi	# MTgen._M_p, _170
	vmovsd	120(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1217	#
	.p2align 4
	.p2align 3
.L1260:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp810
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp561
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbx), %rdx	# MTgen._M_p, _452
	jmp	.L1216	#
	.p2align 4
	.p2align 3
.L1257:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp790
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp527
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%rbx), %rdx	# MTgen._M_p, _471
	jmp	.L1211	#
.L1248:
# C/parallel-only-omp/simulation.h:826: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE9887:
	.size	_Z25step8_collision_ions_bodyiii, .-_Z25step8_collision_ions_bodyiii
	.section	.rodata.str1.8
	.align 8
.LC204:
	.string	" c = %8d  t = %8d  #e = %8d  #i = %8d\n"
	.section	.text._Z12do_one_cyclev._omp_fn.0,"ax",@progbits
	.p2align 4
	.type	_Z12do_one_cyclev._omp_fn.0, @function
_Z12do_one_cyclev._omp_fn.0:
.LFB11230:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA11230
	endbr64	
	leaq	8(%rsp), %r10	#,
	.cfi_def_cfa 10, 0
	andq	$-64, %rsp	#,
	pushq	-8(%r10)	#
	pushq	%rbp	#
	movq	%rsp, %rbp	#,
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15	#
	pushq	%r14	#
	pushq	%r13	#
	pushq	%r12	#
	pushq	%r10	#
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	pushq	%rbx	#
	subq	$384, %rsp	#,
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
# C/parallel-only-omp/simulation.h:878:     #pragma omp parallel
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp1909
	movq	%rax, -56(%rbp)	# tmp1909, D.135303
	xorl	%eax, %eax	# tmp1909
# C/parallel-only-omp/simulation.h:880:         int tid = omp_get_thread_num();
	call	omp_get_thread_num@PLT	#
	movl	%eax, %r12d	# tmp1884, tid
# C/parallel-only-omp/simulation.h:881:         int nthreads = omp_get_num_threads();
	call	omp_get_num_threads@PLT	#
# C/parallel-only-omp/simulation.h:883:         for (int t = 0; t < N_T; t++) {
	movl	$0, -232(%rbp)	#, %sfp
# C/parallel-only-omp/simulation.h:881:         int nthreads = omp_get_num_threads();
	movl	%eax, %ebx	# tmp1885, nthreads
# C/parallel-only-omp/simulation.h:54:     worker_buffers.e_density[tid].fill(0.0);
	movslq	%r12d, %rax	# tid, _123
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	imulq	$3328, %rax, %rsi	#, _123, _125
	leaq	(%rax,%rax,2), %rdx	#, tmp957
	movq	%rsi, -368(%rbp)	# _125, %sfp
	leaq	0(,%rdx,8), %rsi	#, tmp958
	movq	%rsi, -344(%rbp)	# tmp958, %sfp
	movq	%rax, %rsi	# _123, _341
	imulq	$131136, %rax, %rax	#, _123, _228
	salq	$6, %rsi	#, _341
	movq	%rax, -360(%rbp)	# _228, %sfp
	movslq	%ebx, %rax	# nthreads, _1358
	movq	%rsi, -336(%rbp)	# _341, %sfp
	imulq	$416, %rax, %rsi	#, _1358, _1359
	movq	%rsi, -376(%rbp)	# _1359, %sfp
	imulq	$3328, %rax, %rsi	#, _1358, _1666
	movq	%rsi, -384(%rbp)	# _1666, %sfp
	leal	-1(%rbx), %esi	#, _1427
	movl	%esi, %edx	# _1427, bnd.2515
	movl	%esi, -392(%rbp)	# _1427, %sfp
	andl	$-16, %esi	#, tmp.2517
	shrl	$4, %edx	#,
	movl	%esi, -412(%rbp)	# tmp.2517, %sfp
	salq	$10, %rdx	#, bnd.2515
	movq	%rdx, -408(%rbp)	# bnd.2515, %sfp
	leaq	(%rax,%rax,2), %rdx	#, tmp963
	salq	$6, %rax	#, _1358
	leaq	0(,%rdx,8), %rsi	#, tmp964
	movq	%rax, -400(%rbp)	# _1358, %sfp
	movq	%rsi, -424(%rbp)	# tmp964, %sfp
.L1265:
# C/parallel-only-omp/simulation.h:884:             int t_index = t / N_BIN;
	movl	-232(%rbp), %eax	# %sfp, t
	movl	$3435973837, %edx	#, tmp967
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	-368(%rbp), %rcx	# %sfp, _126
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
# C/parallel-only-omp/simulation.h:884:             int t_index = t / N_BIN;
	imulq	%rdx, %rax	# tmp967, tmp966
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movl	$3328, %edx	#,
# C/parallel-only-omp/simulation.h:884:             int t_index = t / N_BIN;
	shrq	$36, %rax	#, tmp966
	movq	%rax, -352(%rbp)	# tmp966, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	leaq	worker_buffers(%rip), %rax	#, tmp2139
	addq	(%rax), %rcx	# worker_buffers.D.102928._M_impl.D.102267._M_start, _126
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%rcx, %rdi	# _126,
	call	memset@PLT	#
# C/parallel-only-omp/simulation.h:56:     int chunk = (N_e + num_threads - 1) / num_threads;
	movl	N_e(%rip), %esi	# N_e, N_e.51_131
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%rax, %rcx	#, _126
# C/parallel-only-omp/simulation.h:56:     int chunk = (N_e + num_threads - 1) / num_threads;
	leal	-1(%rbx,%rsi), %eax	#, tmp982
# C/parallel-only-omp/simulation.h:56:     int chunk = (N_e + num_threads - 1) / num_threads;
	cltd
	idivl	%ebx	# nthreads
# C/parallel-only-omp/simulation.h:57:     int k_start = std::min(tid * chunk, N_e);
	movl	%r12d, %edx	# tid, tmp985
	imull	%eax, %edx	# tmp983, tmp985
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%esi, %edx	# N_e.51_131, tmp985
	cmovg	%esi, %edx	# tmp985,, N_e.51_131, tmp985
# C/parallel-only-omp/simulation.h:58:     int k_end   = std::min(k_start + chunk, N_e);
	addl	%edx, %eax	# _595, tmp986
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	movl	%edx, %r8d	# tmp985, _595
	cmpl	%esi, %eax	# N_e.51_131, tmp986
	cmovg	%esi, %eax	# tmp986,, N_e.51_131, _45
# C/parallel-only-omp/simulation.h:60:     for (int k = k_start; k < k_end; k++) {
	cmpl	%edx, %eax	# _595, _45
	jle	.L1270	#,
	movslq	%edx, %rdi	# _595, _1250
	subl	%r8d, %eax	# _595, tmp996
	leaq	x_e(%rip), %rsi	#, tmp1805
	vmovsd	.LC124(%rip), %xmm2	#, tmp1801
	addq	%rdi, %rax	# _1250, tmp997
	leaq	(%rsi,%rdi,8), %rdx	#, ivtmp.2956
	leaq	(%rsi,%rax,8), %rsi	#, _296
	.p2align 4
	.p2align 3
.L1269:
# C/parallel-only-omp/simulation.h:62:         double c0 = x_e[k] * INV_DX;
	vmovsd	.LC59(%rip), %xmm7	#, tmp2144
# C/parallel-only-omp/simulation.h:64:         double c2 = (c0 - p) * FACTOR_W;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp2145
# C/parallel-only-omp/simulation.h:62:         double c0 = x_e[k] * INV_DX;
	vmulsd	(%rdx), %xmm7, %xmm0	# MEM[(double *)_1198], tmp2144, c0
# C/parallel-only-omp/simulation.h:63:         int p     = int(c0);
	vcvttsd2sil	%xmm0, %eax	# c0, p
# C/parallel-only-omp/simulation.h:66:         worker_buffers.e_density[tid][p]   += c1;
	movslq	%eax, %rdi	# p, _149
# C/parallel-only-omp/simulation.h:64:         double c2 = (c0 - p) * FACTOR_W;
	vcvtsi2sdl	%eax, %xmm5, %xmm1	# p, tmp2145, tmp1893
# C/parallel-only-omp/simulation.h:67:         worker_buffers.e_density[tid][p+1] += c2;
	incl	%eax	# tmp1004
# C/parallel-only-omp/simulation.h:64:         double c2 = (c0 - p) * FACTOR_W;
	vsubsd	%xmm1, %xmm0, %xmm0	# tmp1002, c0, _146
# C/parallel-only-omp/simulation.h:67:         worker_buffers.e_density[tid][p+1] += c2;
	cltq
# C/parallel-only-omp/simulation.h:65:         double c1 = FACTOR_W - c2;
	vmovsd	%xmm0, %xmm0, %xmm1	# _146, c1
# C/parallel-only-omp/simulation.h:60:     for (int k = k_start; k < k_end; k++) {
	addq	$8, %rdx	#, ivtmp.2956
# C/parallel-only-omp/simulation.h:65:         double c1 = FACTOR_W - c2;
	vfnmadd132sd	%xmm2, %xmm2, %xmm1	# tmp1801, tmp1801, c1
# C/parallel-only-omp/simulation.h:67:         worker_buffers.e_density[tid][p+1] += c2;
	vfmadd213sd	(%rcx,%rax,8), %xmm2, %xmm0	# MEM <struct array> [(value_type &)_126]._M_elems[_153], tmp1801, _155
# C/parallel-only-omp/simulation.h:66:         worker_buffers.e_density[tid][p]   += c1;
	vaddsd	(%rcx,%rdi,8), %xmm1, %xmm1	# MEM <struct array> [(value_type &)_126]._M_elems[_149], c1, _151
	vunpcklpd	%xmm0, %xmm1, %xmm0	# _155, _151, tmp1007
	vmovupd	%xmm0, (%rcx,%rdi,8)	# tmp1007, MEM <vector(2) double> [(value_type &)vectp.2643_1784]
# C/parallel-only-omp/simulation.h:60:     for (int k = k_start; k < k_end; k++) {
	cmpq	%rdx, %rsi	# ivtmp.2956, _296
	jne	.L1269	#,
.L1270:
# C/parallel-only-omp/simulation.h:70:     #pragma omp barrier
	call	GOMP_barrier@PLT	#
	movl	$398, %eax	#, q.52_159
	xorl	%edx, %edx	# tt.53_160
	idivl	%ebx	# nthreads
	movl	%eax, %r14d	# q.52_159, q.52_159
	cmpl	%edx, %r12d	# tt.53_160, tid
	jl	.L1486	#,
.L1268:
	movl	%r12d, %r13d	# tid, tmp1009
	imull	%r14d, %r13d	# q.52_159, tmp1009
	addl	%edx, %r13d	# tt.53_160, _165
	leal	(%r14,%r13), %r15d	#, _166
	cmpl	%r15d, %r13d	# _166, _165
	jge	.L1277	#,
	movq	-376(%rbp), %rsi	# %sfp, _1359
	leaq	worker_buffers(%rip), %rax	#, tmp2148
	movl	%r14d, %r9d	# q.52_159, q.52_159
	leaq	cumul_e_density(%rip), %rdi	#, tmp1018
	movq	(%rax), %r8	# worker_buffers.D.102928._M_impl.D.102267._M_start, _1368
	leal	1(%r13), %eax	#, p
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	xorl	%ecx, %ecx	# ivtmp.2949
	cltq
	salq	$3, %r9	#, _884
	addq	%rsi, %rax	# _1359, tmp1013
	leaq	e_density(%rip), %rsi	#, tmp1803
	leaq	(%r8,%rax,8), %rdx	#, ivtmp.2948
	movslq	%r13d, %rax	# _165, _165
	salq	$3, %rax	#, _882
	addq	%rax, %rsi	# _882, _915
	addq	%rax, %rdi	# _882, _908
	leaq	8(%rax,%r8), %r10	#, tmp1859
	.p2align 4
	.p2align 3
.L1276:
# C/parallel-only-omp/simulation.h:76:         for (int t = 0; t < num_threads; t++) {
	testl	%ebx, %ebx	# nthreads
	jle	.L1378	#,
	leaq	(%r10,%rcx), %rax	#, ivtmp.2935
	movq	%rdx, %r8	# ivtmp.2948, tmp1875
# C/parallel-only-omp/simulation.h:75:         double sum = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# sum
	subq	%rax, %r8	# ivtmp.2935, tmp1875
	testl	$256, %r8d	#, tmp1875
	je	.L1275	#,
# C/parallel-only-omp/simulation.h:77:             sum += worker_buffers.e_density[t][p];
	vaddsd	(%rax), %xmm0, %xmm0	# MEM[(value_type &)_618], sum, sum
# C/parallel-only-omp/simulation.h:76:         for (int t = 0; t < num_threads; t++) {
	addq	$3328, %rax	#, ivtmp.2935
	cmpq	%rax, %rdx	# ivtmp.2935, ivtmp.2948
	je	.L1274	#,
	.p2align 4
	.p2align 3
.L1275:
# C/parallel-only-omp/simulation.h:77:             sum += worker_buffers.e_density[t][p];
	vaddsd	(%rax), %xmm0, %xmm0	# MEM[(value_type &)_618], sum, sum
# C/parallel-only-omp/simulation.h:76:         for (int t = 0; t < num_threads; t++) {
	addq	$6656, %rax	#, ivtmp.2935
# C/parallel-only-omp/simulation.h:77:             sum += worker_buffers.e_density[t][p];
	vaddsd	-3328(%rax), %xmm0, %xmm0	# MEM[(value_type &)_618], sum, sum
# C/parallel-only-omp/simulation.h:76:         for (int t = 0; t < num_threads; t++) {
	cmpq	%rax, %rdx	# ivtmp.2935, ivtmp.2948
	jne	.L1275	#,
.L1274:
# C/parallel-only-omp/simulation.h:79:         e_density[p] = sum;
	vmovsd	%xmm0, 8(%rsi,%rcx)	# sum, MEM[(double *)_915 + 8B + ivtmp.2949_925 * 1]
# C/parallel-only-omp/simulation.h:80:         cumul_e_density[p] += sum;
	vaddsd	8(%rdi,%rcx), %xmm0, %xmm0	# MEM[(double *)_908 + 8B + ivtmp.2949_925 * 1], sum, tmp1020
	vmovsd	%xmm0, 8(%rdi,%rcx)	# tmp1020, MEM[(double *)_908 + 8B + ivtmp.2949_925 * 1]
	addq	$8, %rcx	#, ivtmp.2949
	addq	$8, %rdx	#, ivtmp.2948
	cmpq	%rcx, %r9	# ivtmp.2949, _884
	jne	.L1276	#,
.L1277:
# C/parallel-only-omp/simulation.h:83:     if (tid == 0) {
	testl	%r12d, %r12d	# tid
	jne	.L1273	#,
# C/parallel-only-omp/simulation.h:85:         for (int t = 0; t < num_threads; t++) {
	testl	%ebx, %ebx	# nthreads
	jle	.L1379	#,
	leaq	worker_buffers(%rip), %rax	#, tmp2151
	movq	-384(%rbp), %rsi	# %sfp, _1666
# C/parallel-only-omp/simulation.h:84:         double sum0 = 0.0, sumN = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# sumN
# C/parallel-only-omp/simulation.h:84:         double sum0 = 0.0, sumN = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm1	#, sum0
	movq	(%rax), %rax	# worker_buffers.D.102928._M_impl.D.102267._M_start, ivtmp.2928
	leaq	(%rsi,%rax), %rdx	#, _1675
	.p2align 4
	.p2align 3
.L1279:
# C/parallel-only-omp/simulation.h:86:             sum0 += worker_buffers.e_density[t][0];
	vaddsd	(%rax), %xmm1, %xmm1	# MEM[(value_type &)_1794], sum0, sum0
# C/parallel-only-omp/simulation.h:87:             sumN += worker_buffers.e_density[t][N_G - 1];
	vaddsd	3192(%rax), %xmm0, %xmm0	# MEM[(value_type &)_1794 + 3192], sumN, sumN
# C/parallel-only-omp/simulation.h:85:         for (int t = 0; t < num_threads; t++) {
	addq	$3328, %rax	#, ivtmp.2928
	cmpq	%rax, %rdx	# ivtmp.2928, _1675
	jne	.L1279	#,
# C/parallel-only-omp/simulation.h:89:         double val0 = 2.0 * sum0;
	vaddsd	%xmm1, %xmm1, %xmm1	# sum0, sum0, _1199
# C/parallel-only-omp/simulation.h:90:         double valN = 2.0 * sumN;
	vaddsd	%xmm0, %xmm0, %xmm0	# sumN, sumN, _1201
.L1278:
# C/parallel-only-omp/simulation.h:91:         e_density[0] = val0;
	vmovsd	%xmm1, e_density(%rip)	# _1199, e_density[0]
# C/parallel-only-omp/simulation.h:93:         e_density[N_G - 1] = valN;
	vmovsd	%xmm0, 3192+e_density(%rip)	# _1201, e_density[399]
# C/parallel-only-omp/simulation.h:92:         cumul_e_density[0] += val0;
	vaddsd	cumul_e_density(%rip), %xmm1, %xmm1	# cumul_e_density[0], _1199, tmp1026
# C/parallel-only-omp/simulation.h:94:         cumul_e_density[N_G - 1] += valN;
	vaddsd	3192+cumul_e_density(%rip), %xmm0, %xmm0	# cumul_e_density[399], _1201, tmp1031
# C/parallel-only-omp/simulation.h:92:         cumul_e_density[0] += val0;
	vmovsd	%xmm1, cumul_e_density(%rip)	# tmp1026, cumul_e_density[0]
# C/parallel-only-omp/simulation.h:94:         cumul_e_density[N_G - 1] += valN;
	vmovsd	%xmm0, 3192+cumul_e_density(%rip)	# tmp1031, cumul_e_density[399]
.L1273:
# C/parallel-only-omp/simulation.h:96: }
	imull	$-858993459, -232(%rbp), %eax	#, %sfp, tmp1044
	rorx	$2, %eax, %eax	#, tmp1044, tmp1045
# C/parallel-only-omp/simulation.h:124:     if ((t % N_SUB) == 0) {
	cmpl	$214748364, %eax	#, tmp1045
	ja	.L1280	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	-368(%rbp), %rcx	# %sfp, _48
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
	movl	$3328, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	24+worker_buffers(%rip), %rcx	# MEM[(struct vector *)&worker_buffers + 24B].D.102928._M_impl.D.102267._M_start, _48
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%rcx, %rdi	# _48,
	call	memset@PLT	#
# C/parallel-only-omp/simulation.h:127:         int chunk = (N_i + num_threads - 1) / num_threads;
	movl	N_i(%rip), %esi	# N_i, N_i.55_53
# C/parallel-only-omp/simulation.h:128:         int k_start = std::min(tid * chunk, N_i);
	movl	%r12d, %edi	# tid, tmp1057
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%rax, %rcx	#, _48
# C/parallel-only-omp/simulation.h:127:         int chunk = (N_i + num_threads - 1) / num_threads;
	leal	-1(%rbx,%rsi), %eax	#, tmp1054
# C/parallel-only-omp/simulation.h:127:         int chunk = (N_i + num_threads - 1) / num_threads;
	cltd
	idivl	%ebx	# nthreads
# C/parallel-only-omp/simulation.h:128:         int k_start = std::min(tid * chunk, N_i);
	imull	%eax, %edi	# tmp1055, tmp1057
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%esi, %edi	# N_i.55_53, tmp1057
	cmovg	%esi, %edi	# tmp1057,, N_i.55_53, _481
# C/parallel-only-omp/simulation.h:129:         int k_end   = std::min(k_start + chunk, N_i);
	addl	%edi, %eax	# _481, tmp1058
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%esi, %eax	# N_i.55_53, tmp1058
	cmovg	%esi, %eax	# tmp1058,, N_i.55_53, _594
# C/parallel-only-omp/simulation.h:131:         for (int k = k_start; k < k_end; k++) {
	cmpl	%eax, %edi	# _594, _481
	jge	.L1285	#,
	movslq	%edi, %rsi	# _481, _1040
	subl	%edi, %eax	# _481, tmp1062
	leaq	x_i(%rip), %r8	#, tmp1806
	vmovsd	.LC59(%rip), %xmm4	#, tmp1788
	addq	%rsi, %rax	# _1040, tmp1063
	leaq	(%r8,%rsi,8), %rdx	#, ivtmp.2914
	vmovsd	.LC124(%rip), %xmm2	#, tmp1801
	leaq	(%r8,%rax,8), %rdi	#, _1781
	.p2align 4
	.p2align 3
.L1284:
# C/parallel-only-omp/simulation.h:133:             double c0 = x_i[k] * INV_DX;
	vmulsd	(%rdx), %xmm4, %xmm0	# MEM[(double *)_1742], tmp1788, c0
# C/parallel-only-omp/simulation.h:135:             double c2 = (c0 - p) * FACTOR_W;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp2156
# C/parallel-only-omp/simulation.h:134:             int p     = int(c0);
	vcvttsd2sil	%xmm0, %eax	# c0, p
# C/parallel-only-omp/simulation.h:137:             worker_buffers.i_density[tid][p]   += c1;
	movslq	%eax, %rsi	# p, _71
# C/parallel-only-omp/simulation.h:135:             double c2 = (c0 - p) * FACTOR_W;
	vcvtsi2sdl	%eax, %xmm5, %xmm1	# p, tmp2156, tmp1894
# C/parallel-only-omp/simulation.h:138:             worker_buffers.i_density[tid][p+1] += c2;
	incl	%eax	# tmp1070
# C/parallel-only-omp/simulation.h:135:             double c2 = (c0 - p) * FACTOR_W;
	vsubsd	%xmm1, %xmm0, %xmm0	# tmp1068, c0, _68
# C/parallel-only-omp/simulation.h:131:         for (int k = k_start; k < k_end; k++) {
	addq	$8, %rdx	#, ivtmp.2914
# C/parallel-only-omp/simulation.h:138:             worker_buffers.i_density[tid][p+1] += c2;
	cltq
# C/parallel-only-omp/simulation.h:136:             double c1 = FACTOR_W - c2;
	vmovsd	%xmm0, %xmm0, %xmm1	# _68, c1
	vfnmadd132sd	%xmm2, %xmm2, %xmm1	# tmp1801, tmp1801, c1
# C/parallel-only-omp/simulation.h:137:             worker_buffers.i_density[tid][p]   += c1;
	vaddsd	(%rcx,%rsi,8), %xmm1, %xmm1	# MEM <struct array> [(value_type &)_48]._M_elems[_71], c1, _73
# C/parallel-only-omp/simulation.h:138:             worker_buffers.i_density[tid][p+1] += c2;
	vfmadd213sd	(%rcx,%rax,8), %xmm2, %xmm0	# MEM <struct array> [(value_type &)_48]._M_elems[_75], tmp1801, _77
# C/parallel-only-omp/simulation.h:137:             worker_buffers.i_density[tid][p]   += c1;
	vunpcklpd	%xmm0, %xmm1, %xmm0	# _77, _73, tmp1073
	vmovupd	%xmm0, (%rcx,%rsi,8)	# tmp1073, MEM <vector(2) double> [(value_type &)vectp.2645_1799]
# C/parallel-only-omp/simulation.h:131:         for (int k = k_start; k < k_end; k++) {
	cmpq	%rdi, %rdx	# _1781, ivtmp.2914
	jne	.L1284	#,
.L1285:
# C/parallel-only-omp/simulation.h:141:         #pragma omp barrier
	call	GOMP_barrier@PLT	#
	cmpl	%r15d, %r13d	# _166, _165
	jge	.L1282	#,
	movq	-376(%rbp), %rsi	# %sfp, _1359
	movq	24+worker_buffers(%rip), %r9	# MEM[(struct vector *)&worker_buffers + 24B].D.102928._M_impl.D.102267._M_start, _1575
	leal	1(%r13), %eax	#, p
	movl	%r14d, %r8d	# q.52_159, q.52_159
	cltq
	leaq	i_density(%rip), %rcx	#, tmp1784
	leaq	cumul_i_density(%rip), %rdi	#, tmp1808
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	xorl	%edx, %edx	# ivtmp.2907
	salq	$3, %r8	#, _324
	addq	%rsi, %rax	# _1359, tmp1078
	leaq	(%r9,%rax,8), %rsi	#, ivtmp.2906
	movslq	%r13d, %rax	# _165, _165
	salq	$3, %rax	#, _326
	addq	%rax, %rcx	# _326, _633
	addq	%rax, %rdi	# _326, _588
	leaq	8(%rax,%r9), %r10	#, tmp1858
	.p2align 4
	.p2align 3
.L1290:
# C/parallel-only-omp/simulation.h:146:             for (int t2 = 0; t2 < num_threads; t2++) {
	testl	%ebx, %ebx	# nthreads
	jle	.L1380	#,
	leaq	(%r10,%rdx), %rax	#, ivtmp.2893
	movq	%rsi, %r9	# ivtmp.2906, tmp1865
# C/parallel-only-omp/simulation.h:145:             double sum = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# sum
	subq	%rax, %r9	# ivtmp.2893, tmp1865
	testl	$256, %r9d	#, tmp1865
	je	.L1289	#,
# C/parallel-only-omp/simulation.h:147:                 sum += worker_buffers.i_density[t2][p];
	vaddsd	(%rax), %xmm0, %xmm0	# MEM[(value_type &)_897], sum, sum
# C/parallel-only-omp/simulation.h:146:             for (int t2 = 0; t2 < num_threads; t2++) {
	addq	$3328, %rax	#, ivtmp.2893
	cmpq	%rax, %rsi	# ivtmp.2893, ivtmp.2906
	je	.L1288	#,
	.p2align 4
	.p2align 3
.L1289:
# C/parallel-only-omp/simulation.h:147:                 sum += worker_buffers.i_density[t2][p];
	vaddsd	(%rax), %xmm0, %xmm0	# MEM[(value_type &)_897], sum, sum
# C/parallel-only-omp/simulation.h:146:             for (int t2 = 0; t2 < num_threads; t2++) {
	addq	$6656, %rax	#, ivtmp.2893
# C/parallel-only-omp/simulation.h:147:                 sum += worker_buffers.i_density[t2][p];
	vaddsd	-3328(%rax), %xmm0, %xmm0	# MEM[(value_type &)_897], sum, sum
# C/parallel-only-omp/simulation.h:146:             for (int t2 = 0; t2 < num_threads; t2++) {
	cmpq	%rax, %rsi	# ivtmp.2893, ivtmp.2906
	jne	.L1289	#,
.L1288:
# C/parallel-only-omp/simulation.h:149:             i_density[p] = sum;
	vmovsd	%xmm0, 8(%rcx,%rdx)	# sum, MEM[(double *)_633 + 8B + ivtmp.2907_1576 * 1]
# C/parallel-only-omp/simulation.h:150:             cumul_i_density[p] += sum;
	vaddsd	8(%rdi,%rdx), %xmm0, %xmm0	# MEM[(double *)_588 + 8B + ivtmp.2907_1576 * 1], sum, tmp1085
	vmovsd	%xmm0, 8(%rdi,%rdx)	# tmp1085, MEM[(double *)_588 + 8B + ivtmp.2907_1576 * 1]
	addq	$8, %rdx	#, ivtmp.2907
	addq	$8, %rsi	#, ivtmp.2906
	cmpq	%rdx, %r8	# ivtmp.2907, _324
	jne	.L1290	#,
.L1282:
# C/parallel-only-omp/simulation.h:153:         if (tid == 0) {
	testl	%r12d, %r12d	# tid
	jne	.L1291	#,
# C/parallel-only-omp/simulation.h:155:             for (int t2 = 0; t2 < num_threads; t2++) {
	testl	%ebx, %ebx	# nthreads
	jle	.L1381	#,
	movq	24+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 24B].D.102928._M_impl.D.102267._M_start, ivtmp.2886
	movq	-384(%rbp), %rsi	# %sfp, _1666
# C/parallel-only-omp/simulation.h:154:             double sum0 = 0.0, sumN = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# sumN
# C/parallel-only-omp/simulation.h:154:             double sum0 = 0.0, sumN = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm1	#, sum0
	leaq	(%rax,%rsi), %rdx	#, _940
.L1293:
# C/parallel-only-omp/simulation.h:156:                 sum0 += worker_buffers.i_density[t2][0];
	vaddsd	(%rax), %xmm1, %xmm1	# MEM[(value_type &)_1025], sum0, sum0
# C/parallel-only-omp/simulation.h:157:                 sumN += worker_buffers.i_density[t2][N_G - 1];
	vaddsd	3192(%rax), %xmm0, %xmm0	# MEM[(value_type &)_1025 + 3192], sumN, sumN
# C/parallel-only-omp/simulation.h:155:             for (int t2 = 0; t2 < num_threads; t2++) {
	addq	$3328, %rax	#, ivtmp.2886
	cmpq	%rax, %rdx	# ivtmp.2886, _940
	jne	.L1293	#,
# C/parallel-only-omp/simulation.h:159:             double val0 = 2.0 * sum0;
	vaddsd	%xmm1, %xmm1, %xmm1	# sum0, sum0, _1224
# C/parallel-only-omp/simulation.h:160:             double valN = 2.0 * sumN;
	vaddsd	%xmm0, %xmm0, %xmm0	# sumN, sumN, _1226
.L1292:
# C/parallel-only-omp/simulation.h:161:             i_density[0] = val0;
	vmovsd	%xmm1, i_density(%rip)	# _1224, i_density[0]
# C/parallel-only-omp/simulation.h:162:             i_density[N_G - 1] = valN;
	vmovsd	%xmm0, 3192+i_density(%rip)	# _1226, i_density[399]
# C/parallel-only-omp/simulation.h:163:             cumul_i_density[0] += val0;
	vaddsd	cumul_i_density(%rip), %xmm1, %xmm1	# cumul_i_density[0], _1224, tmp1092
# C/parallel-only-omp/simulation.h:164:             cumul_i_density[N_G - 1] += valN;
	vaddsd	3192+cumul_i_density(%rip), %xmm0, %xmm0	# cumul_i_density[399], _1226, tmp1096
# C/parallel-only-omp/simulation.h:163:             cumul_i_density[0] += val0;
	vmovsd	%xmm1, cumul_i_density(%rip)	# tmp1092, cumul_i_density[0]
# C/parallel-only-omp/simulation.h:164:             cumul_i_density[N_G - 1] += valN;
	vmovsd	%xmm0, 3192+cumul_i_density(%rip)	# tmp1096, cumul_i_density[399]
.L1291:
	call	GOMP_single_start@PLT	#
	testb	%al, %al	# tmp1886
	jne	.L1300	#,
.L1376:
	call	GOMP_barrier@PLT	#
# C/parallel-only-omp/simulation.h:898:             step3_move_electrons_body(tid, nthreads, t_index);
	movl	-352(%rbp), %r14d	# %sfp, t_index
	movl	%ebx, %esi	# nthreads,
	movl	%r12d, %edi	# tid,
	movl	%r14d, %edx	# t_index,
	call	_Z25step3_move_electrons_bodyiii	#
# C/parallel-only-omp/simulation.h:899:             step4_move_ions_body(tid, nthreads, t_index, t);
	movl	-232(%rbp), %ecx	# %sfp,
	movl	%r14d, %edx	# t_index,
	movl	%ebx, %esi	# nthreads,
	movl	%r12d, %edi	# tid,
	call	_Z20step4_move_ions_bodyiiii	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	-344(%rbp), %rax	# %sfp, _337
	addq	264+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 264B].D.107139._M_impl.D.106478._M_start, _337
# /usr/include/c++/13/bits/stl_vector.h:1606:       { _M_erase_at_end(this->_M_impl._M_start); }
	movq	(%rax), %rdx	# MEM[(struct vector *)_337].D.110314._M_impl.D.109653._M_start, _338
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	8(%rax), %rdx	# MEM[(struct vector *)_337].D.110314._M_impl.D.109653._M_finish, _338
	je	.L1301	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 8(%rax)	# _338, MEM[(struct vector *)_337].D.110314._M_impl.D.109653._M_finish
.L1301:
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	168+worker_buffers(%rip), %rcx	# MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start
	movq	-336(%rbp), %rax	# %sfp, _341
# C/parallel-only-omp/simulation.h:515:     int chunk = (N_e + num_threads - 1) / num_threads;
	movl	N_e(%rip), %esi	# N_e, N_e.88_343
# C/parallel-only-omp/simulation.h:516:     int k_start = std::min(tid * chunk, N_e);
	movl	%r12d, %r13d	# tid, tmp1160
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	%rcx, %rax	# MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, _342
# C/parallel-only-omp/simulation.h:512:     worker_buffers.thread_counters[tid].local_abs_pow = 0;
	movq	$0, 16(%rax)	#, _342->local_abs_pow
# C/parallel-only-omp/simulation.h:513:     worker_buffers.thread_counters[tid].local_abs_gnd = 0;
	movq	$0, 24(%rax)	#, _342->local_abs_gnd
# C/parallel-only-omp/simulation.h:515:     int chunk = (N_e + num_threads - 1) / num_threads;
	leal	-1(%rbx,%rsi), %eax	#, tmp1157
# C/parallel-only-omp/simulation.h:515:     int chunk = (N_e + num_threads - 1) / num_threads;
	cltd
	idivl	%ebx	# nthreads
# C/parallel-only-omp/simulation.h:516:     int k_start = std::min(tid * chunk, N_e);
	imull	%eax, %r13d	# tmp1158, tmp1160
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%esi, %r13d	# N_e.88_343, tmp1160
	cmovg	%esi, %r13d	# tmp1160,, N_e.88_343, _373
# C/parallel-only-omp/simulation.h:517:     int k_end = std::min(k_start + chunk, N_e);
	addl	%r13d, %eax	# _373, tmp1161
# C/parallel-only-omp/simulation.h:520:     for (int k = k_start; k < k_end; k++) {
	movl	%r13d, -208(%rbp)	# _373, MEM[(int *)_909]
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%esi, %eax	# N_e.88_343, tmp1161
	cmovle	%eax, %esi	# tmp1161,, N_e.88_343
	movl	%esi, %r15d	# N_e.88_343, _464
# C/parallel-only-omp/simulation.h:520:     for (int k = k_start; k < k_end; k++) {
	cmpl	%r13d, %esi	# _373, _464
	jle	.L1314	#,
	movslq	%r13d, %rax	# _373, _373
	leaq	x_e(%rip), %rsi	#, tmp1805
# C/parallel-only-omp/simulation.h:525:         } else if (__builtin_expect(x_e[k] > L, 0)) {
	vmovsd	.LC81(%rip), %xmm2	#, tmp1857
	leaq	(%rsi,%rax,8), %r14	#, ivtmp.2827
	movl	%ebx, %eax	# nthreads, nthreads
	movq	-336(%rbp), %rbx	# %sfp, _341
	.p2align 4
	.p2align 3
.L1313:
# C/parallel-only-omp/simulation.h:522:         if (__builtin_expect(x_e[k] < 0.0, 0)) {
	vmovsd	(%r14), %xmm0	# MEM[(double *)_1084], _354
# C/parallel-only-omp/simulation.h:522:         if (__builtin_expect(x_e[k] < 0.0, 0)) {
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp1165
	vcomisd	%xmm0, %xmm1	# _354, tmp1165
	ja	.L1487	#,
# C/parallel-only-omp/simulation.h:525:         } else if (__builtin_expect(x_e[k] > L, 0)) {
	vcomisd	%xmm2, %xmm0	# tmp1857, _354
	ja	.L1488	#,
.L1309:
# C/parallel-only-omp/simulation.h:520:     for (int k = k_start; k < k_end; k++) {
	incl	%r13d	# _373
# C/parallel-only-omp/simulation.h:520:     for (int k = k_start; k < k_end; k++) {
	addq	$8, %r14	#, ivtmp.2827
# C/parallel-only-omp/simulation.h:520:     for (int k = k_start; k < k_end; k++) {
	movl	%r13d, -208(%rbp)	# _373, MEM[(int *)_909]
# C/parallel-only-omp/simulation.h:520:     for (int k = k_start; k < k_end; k++) {
	cmpl	%r15d, %r13d	# _464, _373
	jne	.L1313	#,
	movl	%eax, %ebx	# nthreads, nthreads
.L1314:
# C/parallel-only-omp/simulation.h:531:     #pragma omp barrier
	call	GOMP_barrier@PLT	#
	call	GOMP_single_start@PLT	#
	vmovdqa64	.LC149(%rip), %zmm3	#, tmp1861
	testb	%al, %al	# tmp1887
	je	.L1315	#,
# C/parallel-only-omp/simulation.h:537:         for (int t = 0; t < num_threads; t++) {
	testl	%ebx, %ebx	# nthreads
	jle	.L1315	#,
	vmovq	N_e_abs_pow(%rip), %xmm5	# N_e_abs_pow, tmp1901
	vmovq	N_e_abs_gnd(%rip), %xmm4	# N_e_abs_gnd, tmp1902
	cmpl	$39, -392(%rbp)	#, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	168+worker_buffers(%rip), %rdx	# MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, _377
	vmovdqa	%xmm5, %xmm12	# tmp1901, N_e_abs_pow_lsm.2394
	vmovdqa	%xmm4, %xmm13	# tmp1902, N_e_abs_gnd_lsm.2395
	jbe	.L1383	#,
	movq	-408(%rbp), %rsi	# %sfp, _1098
	vpxor	%xmm9, %xmm9, %xmm9	# vect__391.2549
	movq	%rdx, %rax	# _377, ivtmp.2820
	vmovdqa64	%zmm9, %zmm8	#, vect__389.2547
	vpxor	%xmm7, %xmm7, %xmm7	# vect_total_abs_387.2545
	leaq	(%rsi,%rdx), %rcx	#, _1093
	.p2align 4
	.p2align 3
.L1317:
# C/parallel-only-omp/simulation.h:538:             total_abs += worker_buffers.thread_counters[t].local_abs_pow + worker_buffers.thread_counters[t].local_abs_gnd;
	vmovdqu64	16(%rax), %zmm2	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 16B], tmp1188
	vmovdqu64	144(%rax), %zmm0	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 144B], tmp1190
	addq	$1024, %rax	#, ivtmp.2820
	vmovdqu64	-624(%rax), %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 400B], tmp1196
	vmovdqa64	.LC150(%rip), %zmm4	#, tmp2179
	vmovdqu64	-112(%rax), %zmm6	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 912B], tmp1230
	vpermt2q	-816(%rax), %zmm3, %zmm0	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 208B], tmp1861, tmp1190
	vpermt2q	-944(%rax), %zmm3, %zmm2	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 80B], tmp1861, tmp1188
	vpermt2q	%zmm0, %zmm3, %zmm2	# tmp1190, tmp1861, tmp1192
	vmovdqu64	-752(%rax), %zmm0	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 272B], tmp1194
	vpermt2q	-560(%rax), %zmm3, %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 464B], tmp1861, tmp1196
	vmovdqa64	%zmm4, %zmm5	# tmp2179, tmp2181
	vpermt2q	-48(%rax), %zmm3, %zmm6	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 976B], tmp1861, tmp1230
	vpermt2q	-688(%rax), %zmm3, %zmm0	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 336B], tmp1861, tmp1194
	vpermt2q	%zmm1, %zmm3, %zmm0	# tmp1196, tmp1861, tmp1198
	vmovdqu64	-880(%rax), %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 144B], tmp1203
	vpermt2q	%zmm0, %zmm3, %zmm2	# tmp1198, tmp1861, vect_perm_even_1474
	vmovdqu64	-1008(%rax), %zmm0	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 16B], tmp1201
	vpermt2q	-816(%rax), %zmm4, %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 208B], tmp2181, tmp1203
	vpermt2q	-944(%rax), %zmm4, %zmm0	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 80B], tmp2179, tmp1201
	vpermt2q	%zmm1, %zmm3, %zmm0	# tmp1203, tmp1861, tmp1205
	vmovdqu64	-752(%rax), %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 272B], tmp1207
	vpermt2q	-688(%rax), %zmm4, %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 336B], tmp2183, tmp1207
	vmovdqu64	-624(%rax), %zmm4	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 400B], tmp1209
	vpermt2q	-560(%rax), %zmm5, %zmm4	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 464B], tmp2185, tmp1209
	vpermt2q	%zmm4, %zmm3, %zmm1	# tmp1209, tmp1861, tmp1211
	vmovdqu64	-496(%rax), %zmm4	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 528B], tmp1222
	vpermt2q	%zmm1, %zmm3, %zmm0	# tmp1211, tmp1861, vect_perm_even_1476
	vmovdqu64	-368(%rax), %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 656B], tmp1224
	vpermt2q	-432(%rax), %zmm3, %zmm4	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 592B], tmp1861, tmp1222
	vpermt2q	-304(%rax), %zmm3, %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 720B], tmp1861, tmp1224
	vpermt2q	%zmm1, %zmm3, %zmm4	# tmp1224, tmp1861, tmp1226
	vmovdqu64	-240(%rax), %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 784B], tmp1228
	vpermt2q	-176(%rax), %zmm3, %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 848B], tmp1861, tmp1228
	vpermt2q	%zmm6, %zmm3, %zmm1	# tmp1230, tmp1861, tmp1232
	vmovdqa64	.LC150(%rip), %zmm6	#, tmp2193
	vpermt2q	%zmm1, %zmm3, %zmm4	# tmp1232, tmp1861, vect_perm_even_1514
	vmovdqu64	-496(%rax), %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 528B], tmp1235
	vpermt2q	-432(%rax), %zmm5, %zmm1	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 592B], tmp2191, tmp1235
	vmovdqu64	-368(%rax), %zmm5	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 656B], tmp1237
	vpermt2q	-304(%rax), %zmm6, %zmm5	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 720B], tmp2193, tmp1237
	vpermt2q	%zmm5, %zmm3, %zmm1	# tmp1237, tmp1861, tmp1239
	vmovdqu64	-240(%rax), %zmm5	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 784B], tmp1241
	vpermt2q	-176(%rax), %zmm6, %zmm5	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 848B], tmp2195, tmp1241
	vmovdqu64	-112(%rax), %zmm6	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 912B], tmp1243
	vmovdqa64	.LC150(%rip), %zmm11	#, tmp2197
# C/parallel-only-omp/simulation.h:538:             total_abs += worker_buffers.thread_counters[t].local_abs_pow + worker_buffers.thread_counters[t].local_abs_gnd;
	vmovdqa32	.LC151(%rip), %zmm10	#, vect_patt_1375.2540
# C/parallel-only-omp/simulation.h:538:             total_abs += worker_buffers.thread_counters[t].local_abs_pow + worker_buffers.thread_counters[t].local_abs_gnd;
	vpermt2q	-48(%rax), %zmm11, %zmm6	# MEM <vector(8) long long unsigned int> [(long long unsigned int *)_1129 + 976B], tmp2197, tmp1243
	vpermt2q	%zmm6, %zmm3, %zmm5	# tmp1243, tmp1861, tmp1245
# C/parallel-only-omp/simulation.h:538:             total_abs += worker_buffers.thread_counters[t].local_abs_pow + worker_buffers.thread_counters[t].local_abs_gnd;
	vmovdqa32	.LC151(%rip), %zmm6	#, vect_patt_1374.2539
# C/parallel-only-omp/simulation.h:538:             total_abs += worker_buffers.thread_counters[t].local_abs_pow + worker_buffers.thread_counters[t].local_abs_gnd;
	vpermt2q	%zmm5, %zmm3, %zmm1	# tmp1245, tmp1861, vect_perm_even_1516
# C/parallel-only-omp/simulation.h:538:             total_abs += worker_buffers.thread_counters[t].local_abs_pow + worker_buffers.thread_counters[t].local_abs_gnd;
	vpermi2d	%zmm1, %zmm0, %zmm10	# vect_perm_even_1516, vect_perm_even_1476, vect_patt_1375.2540
# C/parallel-only-omp/simulation.h:540:             N_e_abs_gnd += worker_buffers.thread_counters[t].local_abs_gnd;
	vpaddq	%zmm1, %zmm0, %zmm0	# vect_perm_even_1516, vect_perm_even_1476, tmp1255
	vpaddq	%zmm0, %zmm9, %zmm9	# tmp1255, vect__391.2549, vect__391.2549
# C/parallel-only-omp/simulation.h:538:             total_abs += worker_buffers.thread_counters[t].local_abs_pow + worker_buffers.thread_counters[t].local_abs_gnd;
	vpermi2d	%zmm4, %zmm2, %zmm6	# vect_perm_even_1514, vect_perm_even_1474, vect_patt_1374.2539
# C/parallel-only-omp/simulation.h:539:             N_e_abs_pow += worker_buffers.thread_counters[t].local_abs_pow;
	vpaddq	%zmm4, %zmm2, %zmm2	# vect_perm_even_1514, vect_perm_even_1474, tmp1254
# C/parallel-only-omp/simulation.h:538:             total_abs += worker_buffers.thread_counters[t].local_abs_pow + worker_buffers.thread_counters[t].local_abs_gnd;
	vpaddd	%zmm10, %zmm6, %zmm6	# vect_patt_1375.2540, vect_patt_1374.2539, vect_patt_1376.2541
# C/parallel-only-omp/simulation.h:539:             N_e_abs_pow += worker_buffers.thread_counters[t].local_abs_pow;
	vpaddq	%zmm2, %zmm8, %zmm8	# tmp1254, vect__389.2547, vect__389.2547
# C/parallel-only-omp/simulation.h:538:             total_abs += worker_buffers.thread_counters[t].local_abs_pow + worker_buffers.thread_counters[t].local_abs_gnd;
	vpaddd	%zmm7, %zmm6, %zmm7	# vect_total_abs_387.2545, vect_patt_1376.2541, vect_total_abs_387.2545
	cmpq	%rax, %rcx	# ivtmp.2820, _1093
	jne	.L1317	#,
	vmovdqa	%ymm9, %ymm1	# vect__391.2549, tmp1256
	vextracti64x4	$0x1, %zmm9, %ymm9	# vect__391.2549, tmp1257
# C/parallel-only-omp/simulation.h:537:         for (int t = 0; t < num_threads; t++) {
	movl	-412(%rbp), %ecx	# %sfp, t
	vpaddq	%ymm9, %ymm1, %ymm1	# tmp1257, tmp1256, _1560
	vmovdqa	%xmm1, %xmm0	# _1560, tmp1258
	vextracti64x2	$0x1, %ymm1, %xmm1	# _1560, tmp1259
	vpaddq	%xmm1, %xmm0, %xmm0	# tmp1259, tmp1258, _1563
	vpsrldq	$8, %xmm0, %xmm1	#, _1563, tmp1261
	vpaddq	%xmm1, %xmm0, %xmm0	# tmp1261, _1563, tmp1262
	vmovdqa	%ymm8, %ymm1	# vect__389.2547, tmp1264
	vextracti64x4	$0x1, %zmm8, %ymm8	# vect__389.2547, tmp1265
	vpaddq	%ymm8, %ymm1, %ymm1	# tmp1265, tmp1264, _1547
	vpaddq	%xmm0, %xmm13, %xmm13	# stmp__391.2550, N_e_abs_gnd_lsm.2395, N_e_abs_gnd_lsm.2395
	vmovdqa	%xmm1, %xmm0	# _1547, tmp1266
	vextracti64x2	$0x1, %ymm1, %xmm1	# _1547, tmp1267
	vpaddq	%xmm1, %xmm0, %xmm0	# tmp1267, tmp1266, _1550
	vpsrldq	$8, %xmm0, %xmm1	#, _1550, tmp1269
	vpaddq	%xmm1, %xmm0, %xmm0	# tmp1269, _1550, tmp1270
	vmovdqa	%ymm7, %ymm1	# vect_total_abs_387.2545, tmp1272
	vextracti32x8	$0x1, %zmm7, %ymm7	# vect_total_abs_387.2545, tmp1273
	vpaddd	%ymm7, %ymm1, %ymm1	# tmp1273, tmp1272, _1533
	vpaddq	%xmm0, %xmm12, %xmm12	# stmp__389.2548, N_e_abs_pow_lsm.2394, N_e_abs_pow_lsm.2394
	vmovdqa	%xmm1, %xmm0	# _1533, tmp1274
	vextracti128	$0x1, %ymm1, %xmm1	# _1533, tmp1275
	vpaddd	%xmm1, %xmm0, %xmm0	# tmp1275, tmp1274, _1536
	vpsrldq	$8, %xmm0, %xmm1	#, _1536, tmp1277
	vpaddd	%xmm1, %xmm0, %xmm0	# tmp1277, _1536, _1538
	vpsrldq	$4, %xmm0, %xmm1	#, _1538, tmp1279
	vpaddd	%xmm1, %xmm0, %xmm0	# tmp1279, _1538, tmp1280
	vmovd	%xmm0, %esi	# tmp1280, stmp_total_abs_387.2546
.L1316:
	movslq	%ecx, %rax	# t, t
	salq	$6, %rax	#, tmp1282
	addq	%rdx, %rax	# _377, ivtmp.2808
	.p2align 4
	.p2align 3
.L1318:
# C/parallel-only-omp/simulation.h:538:             total_abs += worker_buffers.thread_counters[t].local_abs_pow + worker_buffers.thread_counters[t].local_abs_gnd;
	vmovq	16(%rax), %xmm1	# MEM[(long long unsigned int *)_1507 + 16B], tmp1903
# C/parallel-only-omp/simulation.h:538:             total_abs += worker_buffers.thread_counters[t].local_abs_pow + worker_buffers.thread_counters[t].local_abs_gnd;
	vmovq	24(%rax), %xmm0	# MEM[(long long unsigned int *)_1507 + 24B], tmp1904
# C/parallel-only-omp/simulation.h:537:         for (int t = 0; t < num_threads; t++) {
	incl	%ecx	# t
# C/parallel-only-omp/simulation.h:537:         for (int t = 0; t < num_threads; t++) {
	addq	$64, %rax	#, ivtmp.2808
# C/parallel-only-omp/simulation.h:538:             total_abs += worker_buffers.thread_counters[t].local_abs_pow + worker_buffers.thread_counters[t].local_abs_gnd;
	vpaddq	%xmm0, %xmm1, %xmm2	# _1413, _1412, tmp1900
# C/parallel-only-omp/simulation.h:539:             N_e_abs_pow += worker_buffers.thread_counters[t].local_abs_pow;
	vpaddq	%xmm1, %xmm12, %xmm12	# _1412, N_e_abs_pow_lsm.2394, N_e_abs_pow_lsm.2394
# C/parallel-only-omp/simulation.h:540:             N_e_abs_gnd += worker_buffers.thread_counters[t].local_abs_gnd;
	vpaddq	%xmm0, %xmm13, %xmm13	# _1413, N_e_abs_gnd_lsm.2395, N_e_abs_gnd_lsm.2395
# C/parallel-only-omp/simulation.h:538:             total_abs += worker_buffers.thread_counters[t].local_abs_pow + worker_buffers.thread_counters[t].local_abs_gnd;
	vmovq	%xmm2, %rdx	# tmp1900, tmp1283
# C/parallel-only-omp/simulation.h:538:             total_abs += worker_buffers.thread_counters[t].local_abs_pow + worker_buffers.thread_counters[t].local_abs_gnd;
	addl	%esi, %edx	# stmp_total_abs_387.2546, _1417
	movl	%edx, %esi	# _1417, stmp_total_abs_387.2546
# C/parallel-only-omp/simulation.h:537:         for (int t = 0; t < num_threads; t++) {
	cmpl	%ecx, %ebx	# t, nthreads
	jg	.L1318	#,
	vmovq	%xmm12, N_e_abs_pow(%rip)	# N_e_abs_pow_lsm.2394, N_e_abs_pow
	vmovq	%xmm13, N_e_abs_gnd(%rip)	# N_e_abs_gnd_lsm.2395, N_e_abs_gnd
# C/parallel-only-omp/simulation.h:543:         if (total_abs > 0) {
	testl	%edx, %edx	# stmp_total_abs_387.2546
	jle	.L1315	#,
# C/parallel-only-omp/simulation.h:544:             int last_valid = N_e - 1;
	movl	N_e(%rip), %ecx	# N_e, N_e.96_394
	movq	264+worker_buffers(%rip), %r8	# MEM[(struct vector *)&worker_buffers + 264B].D.107139._M_impl.D.106478._M_start, ivtmp.2799
	movq	-424(%rbp), %rsi	# %sfp, tmp964
	leaq	x_e(%rip), %r10	#, tmp1847
# C/parallel-only-omp/simulation.h:552:                         vx_e[dead_idx] = vx_e[last_valid];
	leaq	vx_e(%rip), %r14	#, tmp1850
# C/parallel-only-omp/simulation.h:547:                     while (last_valid > dead_idx && (x_e[last_valid] < 0.0 || x_e[last_valid] > L)) {
	vmovsd	.LC81(%rip), %xmm1	#, tmp1848
# C/parallel-only-omp/simulation.h:554:                         vz_e[dead_idx] = vz_e[last_valid];
	movl	%edx, -216(%rbp)	# _1417, %sfp
# C/parallel-only-omp/simulation.h:553:                         vy_e[dead_idx] = vy_e[last_valid];
	leaq	vy_e(%rip), %r13	#, tmp1851
# C/parallel-only-omp/simulation.h:554:                         vz_e[dead_idx] = vz_e[last_valid];
	leaq	vz_e(%rip), %r11	#, tmp1852
# C/parallel-only-omp/simulation.h:544:             int last_valid = N_e - 1;
	leal	-1(%rcx), %eax	#, last_valid
	leaq	(%r8,%rsi), %r9	#, _1346
	.p2align 4
	.p2align 3
.L1324:
# /usr/include/c++/13/bits/stl_iterator.h:1077:       : _M_current(__i) { }
	movq	(%r8), %r15	# MEM[(int * const &)_681], _401
	movq	8(%r8), %rdx	# MEM[(int * const &)_681 + 8], _402
# C/parallel-only-omp/simulation.h:546:                 for (int dead_idx : worker_buffers.absorbed_indices[t]) {
	cmpq	%rdx, %r15	# _402, _401
	je	.L1319	#,
# C/parallel-only-omp/simulation.h:547:                     while (last_valid > dead_idx && (x_e[last_valid] < 0.0 || x_e[last_valid] > L)) {
	movl	%ecx, %esi	# N_e.96_394, N_e.96_394
	movq	%rdx, %rcx	# _402, _402
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp1841
	.p2align 4
	.p2align 3
.L1323:
# C/parallel-only-omp/simulation.h:546:                 for (int dead_idx : worker_buffers.absorbed_indices[t]) {
	movslq	(%r15), %rdx	# MEM[(int &)_136],
# C/parallel-only-omp/simulation.h:547:                     while (last_valid > dead_idx && (x_e[last_valid] < 0.0 || x_e[last_valid] > L)) {
	cmpl	%eax, %edx	# last_valid, dead_idx
	jge	.L1320	#,
	movslq	%eax, %rdi	# last_valid, last_valid
	leaq	(%r10,%rdi,8), %rdi	#, ivtmp.2790
	.p2align 4
	.p2align 3
.L1321:
# C/parallel-only-omp/simulation.h:547:                     while (last_valid > dead_idx && (x_e[last_valid] < 0.0 || x_e[last_valid] > L)) {
	vmovsd	(%rdi), %xmm0	# MEM[(double *)_355], _407
# C/parallel-only-omp/simulation.h:547:                     while (last_valid > dead_idx && (x_e[last_valid] < 0.0 || x_e[last_valid] > L)) {
	vcomisd	%xmm0, %xmm2	# _407, tmp1841
	ja	.L1322	#,
# C/parallel-only-omp/simulation.h:547:                     while (last_valid > dead_idx && (x_e[last_valid] < 0.0 || x_e[last_valid] > L)) {
	vcomisd	%xmm1, %xmm0	# tmp1848, _407
	jbe	.L1489	#,
.L1322:
# C/parallel-only-omp/simulation.h:548:                         last_valid--;
	decl	%eax	# last_valid
# C/parallel-only-omp/simulation.h:547:                     while (last_valid > dead_idx && (x_e[last_valid] < 0.0 || x_e[last_valid] > L)) {
	subq	$8, %rdi	#, ivtmp.2790
	cmpl	%eax, %edx	# last_valid, dead_idx
	jne	.L1321	#,
.L1320:
# C/parallel-only-omp/simulation.h:546:                 for (int dead_idx : worker_buffers.absorbed_indices[t]) {
	addq	$4, %r15	#, ivtmp.2795
	cmpq	%r15, %rcx	# ivtmp.2795, _402
	jne	.L1323	#,
.L1492:
	movl	%esi, %ecx	# N_e.96_394, N_e.96_394
.L1319:
# C/parallel-only-omp/simulation.h:545:             for (int t = 0; t < num_threads; t++) {
	addq	$24, %r8	#, ivtmp.2799
	cmpq	%r9, %r8	# _1346, ivtmp.2799
	jne	.L1324	#,
# C/parallel-only-omp/simulation.h:559:             N_e -= total_abs;
	movl	-216(%rbp), %edx	# %sfp, _1417
	subl	%edx, %ecx	# _1417, tmp1306
	movl	%ecx, N_e(%rip)	# tmp1306, N_e
.L1315:
	vzeroupper
	call	GOMP_barrier@PLT	#
# C/parallel-only-omp/simulation.h:903:             step6_check_boundaries_ions_body(tid, nthreads, t);
	movl	-232(%rbp), %edx	# %sfp,
	movl	%ebx, %esi	# nthreads,
	movl	%r12d, %edi	# tid,
	call	_Z32step6_check_boundaries_ions_bodyiii	#
# C/parallel-only-omp/state.h:169:     void clear() { count = 0; }
	movq	336+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 336B].D.109241._M_impl.D.108580._M_start, MEM[(struct vector *)&worker_buffers + 336B].D.109241._M_impl.D.108580._M_start
	movq	-360(%rbp), %rsi	# %sfp, _228
# C/parallel-only-omp/simulation.h:695:     int chunk = (N_e + num_threads - 1) / num_threads;
	movl	N_e(%rip), %ecx	# N_e, N_e.134_232
# C/parallel-only-omp/simulation.h:696:     int k_start = std::min(tid * chunk, N_e);
	movl	%r12d, %r8d	# tid, tmp1315
# C/parallel-only-omp/state.h:169:     void clear() { count = 0; }
	movl	$0, 131072(%rax,%rsi)	#, MEM[(struct NewParticles *)_229].count
	movq	360+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 360B].D.109241._M_impl.D.108580._M_start, MEM[(struct vector *)&worker_buffers + 360B].D.109241._M_impl.D.108580._M_start
	movl	$0, 131072(%rax,%rsi)	#, MEM[(struct NewParticles *)_231].count
# C/parallel-only-omp/simulation.h:695:     int chunk = (N_e + num_threads - 1) / num_threads;
	leal	-1(%rbx,%rcx), %eax	#, tmp1312
# C/parallel-only-omp/simulation.h:695:     int chunk = (N_e + num_threads - 1) / num_threads;
	cltd
	idivl	%ebx	# nthreads
# C/parallel-only-omp/simulation.h:696:     int k_start = std::min(tid * chunk, N_e);
	imull	%eax, %r8d	# tmp1313, tmp1315
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%ecx, %r8d	# N_e.134_232, tmp1315
	cmovg	%ecx, %r8d	# tmp1315,, N_e.134_232, _592
# C/parallel-only-omp/simulation.h:697:     int k_end = std::min(k_start + chunk, N_e);
	addl	%r8d, %eax	# _592, tmp1316
# C/parallel-only-omp/simulation.h:698:     int N_local = k_end - k_start;
	movl	%r8d, -216(%rbp)	# _592, %sfp
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%ecx, %eax	# N_e.134_232, tmp1316
	cmovle	%eax, %ecx	# tmp1316,, _26
# C/parallel-only-omp/simulation.h:698:     int N_local = k_end - k_start;
	movl	%ecx, %r11d	# _26, N_local
	movl	%ecx, -228(%rbp)	# _26, %sfp
	subl	%r8d, %r11d	# _592, N_local
# C/parallel-only-omp/simulation.h:700:     if (N_local > 0) {
	testl	%r11d, %r11d	# N_local
	jg	.L1490	#,
.L1325:
# C/parallel-only-omp/simulation.h:728:     #pragma omp barrier
	call	GOMP_barrier@PLT	#
	call	GOMP_single_start@PLT	#
	movb	%al, -244(%rbp)	# _298, %sfp
	testb	%al, %al	# _298
	je	.L1339	#,
# C/parallel-only-omp/simulation.h:731:         for (int t = 0; t < num_threads; ++t) {
	testl	%ebx, %ebx	# nthreads
	jle	.L1339	#,
	movl	N_i(%rip), %esi	# N_i, N_i_lsm.2389
	movq	N_e_coll(%rip), %rax	# N_e_coll, N_e_coll_lsm.2393
	movq	-400(%rbp), %rdi	# %sfp, _859
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	$0, -240(%rbp)	#, %sfp
	movq	336+worker_buffers(%rip), %rdx	# MEM[(struct vector *)&worker_buffers + 336B].D.109241._M_impl.D.108580._M_start, _605
	movb	$0, -260(%rbp)	#, %sfp
	movb	$0, -261(%rbp)	#, %sfp
	movl	%r12d, -248(%rbp)	# tid, %sfp
	movl	%ebx, -388(%rbp)	# nthreads, %sfp
	movl	%esi, -224(%rbp)	# N_i_lsm.2389, %sfp
	movq	168+worker_buffers(%rip), %rsi	# MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, ivtmp.2755
	movq	%rax, -256(%rbp)	# N_e_coll_lsm.2393, %sfp
	movl	N_e(%rip), %eax	# N_e, N_e_lsm.2391
	movq	%rdx, -328(%rbp)	# _605, %sfp
	movq	%rsi, -216(%rbp)	# ivtmp.2755, %sfp
	addq	%rdi, %rsi	# _859, _855
	movl	%eax, -228(%rbp)	# N_e_lsm.2391, %sfp
	movq	360+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 360B].D.109241._M_impl.D.108580._M_start, _137
	movq	%rsi, -272(%rbp)	# _855, %sfp
	leaq	x_e(%rip), %rsi	#, tmp1830
	vmovq	%rsi, %xmm5	# tmp1830, tmp1830
	leaq	vx_e(%rip), %rsi	#, tmp1831
	vmovq	%rsi, %xmm4	# tmp1831, tmp1831
	leaq	vy_e(%rip), %rsi	#, tmp1832
	vmovq	%rsi, %xmm7	# tmp1832, tmp1832
	leaq	vz_e(%rip), %rsi	#, tmp1833
	vmovq	%rsi, %xmm9	# tmp1833, tmp1833
	leaq	x_i(%rip), %rsi	#, tmp1834
	movq	%rax, -320(%rbp)	# _137, %sfp
	vmovq	%rsi, %xmm2	# tmp1834, tmp1834
	leaq	vx_i(%rip), %rsi	#, tmp1835
	vmovq	%rsi, %xmm1	# tmp1835, tmp1835
	leaq	vy_i(%rip), %rsi	#, tmp1836
	vmovq	%rsi, %xmm6	# tmp1836, tmp1836
	leaq	vz_i(%rip), %rsi	#, tmp1837
	vmovq	%rsi, %xmm8	# tmp1837, tmp1837
	.p2align 4
	.p2align 3
.L1359:
# C/parallel-only-omp/simulation.h:732:             N_e_coll += worker_buffers.thread_counters[t].local_coll_e;
	movq	-216(%rbp), %rbx	# %sfp, ivtmp.2755
	movq	-256(%rbp), %rsi	# %sfp, N_e_coll_lsm.2393
	addq	32(%rbx), %rsi	# MEM[(long long unsigned int *)_872 + 32B], N_e_coll_lsm.2393
# C/parallel-only-omp/simulation.h:733:             worker_buffers.thread_counters[t].local_coll_e = 0;
	movq	$0, 32(%rbx)	#, MEM[(long long unsigned int *)_872 + 32B]
# C/parallel-only-omp/simulation.h:732:             N_e_coll += worker_buffers.thread_counters[t].local_coll_e;
	movq	%rsi, -312(%rbp)	# tmp1423, %sfp
	movq	%rsi, -256(%rbp)	# tmp1423, %sfp
# C/parallel-only-omp/state.h:170:     size_t size() const { return (size_t)count; }
	movslq	131072(%rdx), %rsi	# MEM[(int *)_466 + 131072B],
	movq	%rsi, %rdi	#,
# C/parallel-only-omp/simulation.h:734:             for (size_t i = 0; i < worker_buffers.new_electrons[t].size(); ++i) {
	testl	%esi, %esi	# _30
	je	.L1341	#,
	leaq	-1(%rsi), %rbx	#, _875
	movslq	-228(%rbp), %rcx	# %sfp, N_e_lsm.2391
	movq	%rbx, -304(%rbp)	# _875, %sfp
	cmpq	$2, %rbx	#, _875
	jbe	.L1342	#,
	leaq	0(,%rcx,8), %r15	#, _868
	vmovq	%xmm5, %rbx	# tmp1830, tmp1830
	leaq	98368(%rdx), %r14	#, _852
	leaq	(%rbx,%r15), %r9	#, _867
	vmovq	%xmm4, %rbx	# tmp1831, tmp1831
	leaq	64(%r15), %r13	#, _863
	leaq	(%rbx,%r15), %r8	#, _849
	vmovq	%xmm7, %rbx	# tmp1832, tmp1832
	leaq	(%rbx,%r15), %r11	#, _831
	vmovq	%xmm9, %rbx	# tmp1833, tmp1833
	leaq	(%rbx,%r15), %r10	#, _789
	vmovq	%xmm4, %rbx	# tmp1831, tmp1831
	leaq	64(%rbx,%r15), %rbx	#, tmp1429
	cmpq	%rbx, %rdx	# tmp1429, ivtmp.2757
	setnb	%r12b	#, tmp1432
	cmpq	%r14, %r8	# _852, _849
	setnb	%bl	#, tmp1434
	orl	%ebx, %r12d	# tmp1434, tmp1435
	vmovq	%xmm5, %rbx	# tmp1830, tmp1830
	leaq	64(%rbx,%r15), %rbx	#, tmp1436
	cmpq	%rbx, %rdx	# tmp1436, ivtmp.2757
	setnb	%bl	#, tmp1439
	cmpq	%r14, %r9	# _852, _867
	setnb	%r15b	#, tmp1441
	orl	%r15d, %ebx	# tmp1441, tmp1442
	testb	%bl, %r12b	# tmp1442, tmp1435
	je	.L1342	#,
	vmovq	%xmm7, %rbx	# tmp1832, tmp1832
	addq	%rbx, %r13	# tmp1832, tmp1444
	cmpq	%r13, %rdx	# tmp1444, ivtmp.2757
	leaq	8(%rdx), %r13	#, tmp1451
	setnb	%bl	#, tmp1447
	cmpq	%r14, %r11	# _852, _831
	setnb	%r12b	#, tmp1449
	orl	%r12d, %ebx	# tmp1449, tmp1450
	movq	%r10, %r12	# _789, tmp1452
	subq	%r13, %r12	# tmp1451, tmp1452
	cmpq	$98352, %r12	#, tmp1452
	seta	%r12b	#, tmp1454
	testb	%r12b, %bl	# tmp1454, tmp1450
	je	.L1342	#,
	cmpq	$6, -304(%rbp)	#, %sfp
	jbe	.L1389	#,
	movq	%rsi, %r12	# _330, bnd.2464
	leaq	32768(%rdx), %r15	#, vectp.2474
	leaq	65536(%rdx), %r14	#, vectp.2479
	leaq	98304(%rdx), %r13	#, vectp.2484
	shrq	$3, %r12	#, bnd.2464
	salq	$6, %r12	#, _387
	xorl	%ebx, %ebx	# ivtmp.2735
	.p2align 4
	.p2align 3
.L1344:
# C/parallel-only-omp/simulation.h:735:                 x_e[N_e]    = worker_buffers.new_electrons[t].x[i];
	vmovupd	(%rdx,%rbx), %zmm0	# MEM <vector(8) double> [(value_type &)_466 + ivtmp.2735_383 * 1], tmp2292
	vmovupd	%zmm0, (%r9,%rbx)	# tmp2292, MEM <vector(8) double> [(double *)_867 + ivtmp.2735_383 * 1]
# C/parallel-only-omp/simulation.h:736:                 vx_e[N_e]   = worker_buffers.new_electrons[t].vx[i];
	vmovupd	(%r15,%rbx), %zmm0	# MEM <vector(8) double> [(value_type &)vectp.2474_309 + ivtmp.2735_383 * 1], tmp2293
	vmovupd	%zmm0, (%r8,%rbx)	# tmp2293, MEM <vector(8) double> [(double *)_849 + ivtmp.2735_383 * 1]
# C/parallel-only-omp/simulation.h:737:                 vy_e[N_e]   = worker_buffers.new_electrons[t].vy[i];
	vmovupd	(%r14,%rbx), %zmm0	# MEM <vector(8) double> [(value_type &)vectp.2479_184 + ivtmp.2735_383 * 1], tmp2294
	vmovupd	%zmm0, (%r11,%rbx)	# tmp2294, MEM <vector(8) double> [(double *)_831 + ivtmp.2735_383 * 1]
# C/parallel-only-omp/simulation.h:738:                 vz_e[N_e]   = worker_buffers.new_electrons[t].vz[i];
	vmovupd	0(%r13,%rbx), %zmm0	# MEM <vector(8) double> [(value_type &)vectp.2484_90 + ivtmp.2735_383 * 1], tmp2295
	vmovupd	%zmm0, (%r10,%rbx)	# tmp2295, MEM <vector(8) double> [(double *)_789 + ivtmp.2735_383 * 1]
	addq	$64, %rbx	#, ivtmp.2735
	cmpq	%r12, %rbx	# _387, ivtmp.2735
	jne	.L1344	#,
	movl	-228(%rbp), %ebx	# %sfp, N_e_lsm.2391
	movq	%rsi, %r8	# _330, tmp.2491
	andq	$-8, %r8	#, tmp.2491
	leal	(%rbx,%r8), %r10d	#, tmp.2492
	testb	$7, %dil	#, _30
	je	.L1349	#,
	movq	%rsi, %r11	# _330, niters.2488
	subq	%r8, %r11	# tmp.2491, niters.2488
	leaq	-1(%r11), %r9	#, tmp1462
	cmpq	$2, %r9	#, tmp1462
	jbe	.L1346	#,
.L1343:
	movq	-240(%rbp), %rbx	# %sfp, ivtmp.2766
	addq	%r8, %rcx	# tmp.2491, tmp1464
# C/parallel-only-omp/simulation.h:735:                 x_e[N_e]    = worker_buffers.new_electrons[t].x[i];
	vmovq	%xmm5, %r14	# tmp1830, tmp1830
	salq	$3, %rcx	#, _531
	leaq	(%r8,%rbx), %r9	#, tmp1463
	movq	-328(%rbp), %rbx	# %sfp, _605
	salq	$3, %r9	#, _604
	vmovupd	(%rbx,%r9), %ymm0	# MEM <vector(4) double> [(value_type &)vectp.2494_734], MEM <vector(4) double> [(value_type &)vectp.2494_734]
	vmovupd	%ymm0, (%r14,%rcx)	# MEM <vector(4) double> [(value_type &)vectp.2494_734], MEM <vector(4) double> [(double *)vectp_x_e.2497_779]
# C/parallel-only-omp/simulation.h:736:                 vx_e[N_e]   = worker_buffers.new_electrons[t].vx[i];
	vmovupd	32768(%rbx,%r9), %ymm0	# MEM <vector(4) double> [(value_type &)vectp.2499_598], MEM <vector(4) double> [(value_type &)vectp.2499_598]
	vmovq	%xmm4, %r14	# tmp1831, tmp1831
	vmovupd	%ymm0, (%r14,%rcx)	# MEM <vector(4) double> [(value_type &)vectp.2499_598], MEM <vector(4) double> [(double *)vectp_vx_e.2502_1333]
# C/parallel-only-omp/simulation.h:737:                 vy_e[N_e]   = worker_buffers.new_electrons[t].vy[i];
	vmovupd	65536(%rbx,%r9), %ymm0	# MEM <vector(4) double> [(value_type &)vectp.2504_1340], MEM <vector(4) double> [(value_type &)vectp.2504_1340]
	vmovq	%xmm7, %r14	# tmp1832, tmp1832
	vmovupd	%ymm0, (%r14,%rcx)	# MEM <vector(4) double> [(value_type &)vectp.2504_1340], MEM <vector(4) double> [(double *)vectp_vy_e.2507_1349]
# C/parallel-only-omp/simulation.h:738:                 vz_e[N_e]   = worker_buffers.new_electrons[t].vz[i];
	vmovq	%xmm9, %r14	# tmp1833, tmp1833
# C/parallel-only-omp/simulation.h:737:                 vy_e[N_e]   = worker_buffers.new_electrons[t].vy[i];
	vmovapd	%ymm0, -304(%rbp)	# MEM <vector(4) double> [(value_type &)vectp.2504_1340], %sfp
# C/parallel-only-omp/simulation.h:738:                 vz_e[N_e]   = worker_buffers.new_electrons[t].vz[i];
	vmovupd	98304(%rbx,%r9), %ymm0	# MEM <vector(4) double> [(value_type &)vectp.2509_1356], tmp2314
	vmovupd	%ymm0, (%r14,%rcx)	# tmp2314, MEM <vector(4) double> [(double *)vectp_vz_e.2512_1365]
	movq	%r11, %rcx	# niters.2488, niters_vector_mult_vf.2490
	andq	$-4, %rcx	#, niters_vector_mult_vf.2490
	addq	%rcx, %r8	# niters_vector_mult_vf.2490, tmp.2491
	addl	%ecx, %r10d	# niters_vector_mult_vf.2490, tmp.2492
	andl	$3, %r11d	#, niters.2488
	je	.L1349	#,
.L1346:
# C/parallel-only-omp/simulation.h:735:                 x_e[N_e]    = worker_buffers.new_electrons[t].x[i];
	movslq	%r10d, %rcx	# tmp.2492, tmp.2492
	leaq	(%rdx,%r8,8), %r11	#, _1047
	vmovq	%xmm5, %rbx	# tmp1830, tmp1830
# C/parallel-only-omp/simulation.h:734:             for (size_t i = 0; i < worker_buffers.new_electrons[t].size(); ++i) {
	leaq	1(%r8), %r9	#, i
# C/parallel-only-omp/simulation.h:735:                 x_e[N_e]    = worker_buffers.new_electrons[t].x[i];
	vmovsd	(%r11), %xmm0	# *_1047, _1604
	vmovsd	%xmm0, (%rbx,%rcx,8)	# _1604, x_e[N_e_lsm.2391_365]
# C/parallel-only-omp/simulation.h:736:                 vx_e[N_e]   = worker_buffers.new_electrons[t].vx[i];
	vmovq	%xmm4, %rbx	# tmp1831, tmp1831
	vmovsd	32768(%r11), %xmm0	# MEM[(value_type &)_1047 + 32768], _1605
	vmovsd	%xmm0, (%rbx,%rcx,8)	# _1605, vx_e[N_e_lsm.2391_365]
# C/parallel-only-omp/simulation.h:737:                 vy_e[N_e]   = worker_buffers.new_electrons[t].vy[i];
	vmovq	%xmm7, %rbx	# tmp1832, tmp1832
	vmovsd	65536(%r11), %xmm0	# MEM[(value_type &)_1047 + 65536], _1607
	vmovsd	%xmm0, (%rbx,%rcx,8)	# _1607, vy_e[N_e_lsm.2391_365]
# C/parallel-only-omp/simulation.h:738:                 vz_e[N_e]   = worker_buffers.new_electrons[t].vz[i];
	vmovq	%xmm9, %rbx	# tmp1833, tmp1833
	vmovsd	98304(%r11), %xmm0	# MEM[(value_type &)_1047 + 98304], _1478
	vmovsd	%xmm0, (%rbx,%rcx,8)	# _1478, vz_e[N_e_lsm.2391_365]
# C/parallel-only-omp/simulation.h:739:                 N_e++;
	leal	1(%r10), %ecx	#, _1480
# C/parallel-only-omp/simulation.h:734:             for (size_t i = 0; i < worker_buffers.new_electrons[t].size(); ++i) {
	cmpq	%rsi, %r9	# _330, i
	jnb	.L1349	#,
# C/parallel-only-omp/simulation.h:735:                 x_e[N_e]    = worker_buffers.new_electrons[t].x[i];
	movslq	%ecx, %rcx	# _1480, _1480
	vmovq	%xmm5, %rbx	# tmp1830, tmp1830
	vmovsd	8(%r11), %xmm0	# MEM[(value_type &)_1047 + 8], _1513
# C/parallel-only-omp/simulation.h:734:             for (size_t i = 0; i < worker_buffers.new_electrons[t].size(); ++i) {
	addq	$2, %r8	#, i
# C/parallel-only-omp/simulation.h:735:                 x_e[N_e]    = worker_buffers.new_electrons[t].x[i];
	vmovsd	%xmm0, (%rbx,%rcx,8)	# _1513, x_e[_1480]
# C/parallel-only-omp/simulation.h:736:                 vx_e[N_e]   = worker_buffers.new_electrons[t].vx[i];
	vmovq	%xmm4, %rbx	# tmp1831, tmp1831
	vmovsd	32776(%r11), %xmm0	# MEM[(value_type &)_1047 + 32776], _1517
# C/parallel-only-omp/simulation.h:739:                 N_e++;
	addl	$2, %r10d	#, _381
# C/parallel-only-omp/simulation.h:736:                 vx_e[N_e]   = worker_buffers.new_electrons[t].vx[i];
	vmovsd	%xmm0, (%rbx,%rcx,8)	# _1517, vx_e[_1480]
# C/parallel-only-omp/simulation.h:737:                 vy_e[N_e]   = worker_buffers.new_electrons[t].vy[i];
	vmovq	%xmm7, %rbx	# tmp1832, tmp1832
	vmovsd	65544(%r11), %xmm0	# MEM[(value_type &)_1047 + 65544], _1519
	vmovsd	%xmm0, (%rbx,%rcx,8)	# _1519, vy_e[_1480]
# C/parallel-only-omp/simulation.h:738:                 vz_e[N_e]   = worker_buffers.new_electrons[t].vz[i];
	vmovq	%xmm9, %rbx	# tmp1833, tmp1833
	vmovsd	98312(%r11), %xmm0	# MEM[(value_type &)_1047 + 98312], _1521
	vmovsd	%xmm0, (%rbx,%rcx,8)	# _1521, vz_e[_1480]
# C/parallel-only-omp/simulation.h:734:             for (size_t i = 0; i < worker_buffers.new_electrons[t].size(); ++i) {
	cmpq	%rsi, %r8	# _330, i
	jnb	.L1349	#,
# C/parallel-only-omp/simulation.h:735:                 x_e[N_e]    = worker_buffers.new_electrons[t].x[i];
	movslq	%r10d, %r10	# _381, _381
	vmovq	%xmm5, %rsi	# tmp1830, tmp1830
	vmovsd	16(%r11), %xmm0	# MEM[(value_type &)_1047 + 16], _1242
	vmovsd	%xmm0, (%rsi,%r10,8)	# _1242, x_e[_381]
# C/parallel-only-omp/simulation.h:736:                 vx_e[N_e]   = worker_buffers.new_electrons[t].vx[i];
	vmovq	%xmm4, %rsi	# tmp1831, tmp1831
	vmovsd	32784(%r11), %xmm0	# MEM[(value_type &)_1047 + 32784], _1237
	vmovsd	%xmm0, (%rsi,%r10,8)	# _1237, vx_e[_381]
# C/parallel-only-omp/simulation.h:737:                 vy_e[N_e]   = worker_buffers.new_electrons[t].vy[i];
	vmovq	%xmm7, %rsi	# tmp1832, tmp1832
	vmovsd	65552(%r11), %xmm0	# MEM[(value_type &)_1047 + 65552], _1232
	vmovsd	%xmm0, (%rsi,%r10,8)	# _1232, vy_e[_381]
# C/parallel-only-omp/simulation.h:738:                 vz_e[N_e]   = worker_buffers.new_electrons[t].vz[i];
	vmovsd	98320(%r11), %xmm0	# MEM[(value_type &)_1047 + 98320], _1234
	vmovsd	%xmm0, (%rbx,%r10,8)	# _1234, vz_e[_381]
.L1349:
# C/parallel-only-omp/simulation.h:739:                 N_e++;
	movzbl	-244(%rbp), %esi	# %sfp, _298
	addl	%edi, -228(%rbp)	# _30, %sfp
	movb	%sil, -260(%rbp)	# _298, %sfp
.L1341:
# C/parallel-only-omp/state.h:170:     size_t size() const { return (size_t)count; }
	movslq	131072(%rax), %rsi	# MEM[(int *)_689 + 131072B],
	movq	%rsi, %rdi	#,
# C/parallel-only-omp/simulation.h:741:             for (size_t i = 0; i < worker_buffers.new_ions[t].size(); ++i) {
	testl	%esi, %esi	# _157
	je	.L1350	#,
	leaq	-1(%rsi), %rbx	#, _1131
	movslq	-224(%rbp), %rcx	# %sfp, N_i_lsm.2389
	movq	%rbx, -304(%rbp)	# _1131, %sfp
	cmpq	$2, %rbx	#, _1131
	jbe	.L1351	#,
	leaq	0(,%rcx,8), %r15	#, _1124
	vmovq	%xmm2, %rbx	# tmp1834, tmp1834
	leaq	98368(%rax), %r14	#, _833
	leaq	(%rbx,%r15), %r9	#, _1123
	vmovq	%xmm1, %rbx	# tmp1835, tmp1835
	leaq	64(%r15), %r13	#, _1119
	leaq	(%rbx,%r15), %r8	#, _1105
	vmovq	%xmm6, %rbx	# tmp1836, tmp1836
	leaq	(%rbx,%r15), %r11	#, _1087
	vmovq	%xmm8, %rbx	# tmp1837, tmp1837
	leaq	(%rbx,%r15), %r10	#, _1073
	vmovq	%xmm1, %rbx	# tmp1835, tmp1835
	leaq	64(%rbx,%r15), %rbx	#, tmp1510
	cmpq	%rbx, %rax	# tmp1510, ivtmp.2760
	setnb	%r12b	#, tmp1513
	cmpq	%r14, %r8	# _833, _1105
	setnb	%bl	#, tmp1515
	orl	%ebx, %r12d	# tmp1515, tmp1516
	vmovq	%xmm2, %rbx	# tmp1834, tmp1834
	leaq	64(%rbx,%r15), %rbx	#, tmp1517
	cmpq	%rbx, %rax	# tmp1517, ivtmp.2760
	setnb	%bl	#, tmp1520
	cmpq	%r14, %r9	# _833, _1123
	setnb	%r15b	#, tmp1522
	orl	%r15d, %ebx	# tmp1522, tmp1523
	testb	%bl, %r12b	# tmp1523, tmp1516
	je	.L1351	#,
	vmovq	%xmm6, %rbx	# tmp1836, tmp1836
	addq	%rbx, %r13	# tmp1836, tmp1525
	cmpq	%r13, %rax	# tmp1525, ivtmp.2760
	leaq	8(%rax), %r13	#, tmp1532
	setnb	%bl	#, tmp1528
	cmpq	%r14, %r11	# _833, _1087
	setnb	%r12b	#, tmp1530
	orl	%r12d, %ebx	# tmp1530, tmp1531
	movq	%r10, %r12	# _1073, tmp1533
	subq	%r13, %r12	# tmp1532, tmp1533
	cmpq	$98352, %r12	#, tmp1533
	seta	%r12b	#, tmp1535
	testb	%r12b, %bl	# tmp1535, tmp1531
	je	.L1351	#,
	cmpq	$6, -304(%rbp)	#, %sfp
	jbe	.L1390	#,
	movq	%rsi, %r12	# _634, bnd.2414
	leaq	32768(%rax), %r15	#, vectp.2424
	leaq	65536(%rax), %r14	#, vectp.2429
	leaq	98304(%rax), %r13	#, vectp.2434
	shrq	$3, %r12	#, bnd.2414
	salq	$6, %r12	#, _514
	xorl	%ebx, %ebx	# ivtmp.2703
	.p2align 4
	.p2align 3
.L1353:
# C/parallel-only-omp/simulation.h:742:                 x_i[N_i]    = worker_buffers.new_ions[t].x[i];
	vmovupd	(%rax,%rbx), %zmm0	# MEM <vector(8) double> [(value_type &)_689 + ivtmp.2703_1663 * 1], tmp2348
	vmovupd	%zmm0, (%r9,%rbx)	# tmp2348, MEM <vector(8) double> [(double *)_1123 + ivtmp.2703_1663 * 1]
# C/parallel-only-omp/simulation.h:743:                 vx_i[N_i]   = worker_buffers.new_ions[t].vx[i];
	vmovupd	(%r15,%rbx), %zmm0	# MEM <vector(8) double> [(value_type &)vectp.2424_1011 + ivtmp.2703_1663 * 1], tmp2349
	vmovupd	%zmm0, (%r8,%rbx)	# tmp2349, MEM <vector(8) double> [(double *)_1105 + ivtmp.2703_1663 * 1]
# C/parallel-only-omp/simulation.h:744:                 vy_i[N_i]   = worker_buffers.new_ions[t].vy[i];
	vmovupd	(%r14,%rbx), %zmm0	# MEM <vector(8) double> [(value_type &)vectp.2429_998 + ivtmp.2703_1663 * 1], tmp2350
	vmovupd	%zmm0, (%r11,%rbx)	# tmp2350, MEM <vector(8) double> [(double *)_1087 + ivtmp.2703_1663 * 1]
# C/parallel-only-omp/simulation.h:745:                 vz_i[N_i]   = worker_buffers.new_ions[t].vz[i];
	vmovupd	0(%r13,%rbx), %zmm0	# MEM <vector(8) double> [(value_type &)vectp.2434_985 + ivtmp.2703_1663 * 1], tmp2351
	vmovupd	%zmm0, (%r10,%rbx)	# tmp2351, MEM <vector(8) double> [(double *)_1073 + ivtmp.2703_1663 * 1]
	addq	$64, %rbx	#, ivtmp.2703
	cmpq	%rbx, %r12	# ivtmp.2703, _514
	jne	.L1353	#,
	movl	-224(%rbp), %ebx	# %sfp, N_i_lsm.2389
	movq	%rsi, %r8	# _634, niters_vector_mult_vf.2415
	andq	$-8, %r8	#, niters_vector_mult_vf.2415
	leal	(%rbx,%r8), %r10d	#, tmp.2417
	testb	$7, %dil	#, _157
	je	.L1358	#,
	movq	%rsi, %r11	# _634, niters.2438
	subq	%r8, %r11	# niters_vector_mult_vf.2415, niters.2438
	leaq	-1(%r11), %r9	#, tmp1543
	cmpq	$2, %r9	#, tmp1543
	jbe	.L1355	#,
.L1352:
	movq	-240(%rbp), %rbx	# %sfp, ivtmp.2766
	addq	%r8, %rcx	# niters_vector_mult_vf.2415, tmp1545
# C/parallel-only-omp/simulation.h:742:                 x_i[N_i]    = worker_buffers.new_ions[t].x[i];
	vmovq	%xmm2, %r14	# tmp1834, tmp1834
	salq	$3, %rcx	#, _930
	leaq	(%rbx,%r8), %r9	#, tmp1544
	movq	-320(%rbp), %rbx	# %sfp, _137
	salq	$3, %r9	#, _937
	vmovupd	(%rbx,%r9), %ymm0	# MEM <vector(4) double> [(value_type &)vectp.2444_941], MEM <vector(4) double> [(value_type &)vectp.2444_941]
	vmovupd	%ymm0, (%r14,%rcx)	# MEM <vector(4) double> [(value_type &)vectp.2444_941], MEM <vector(4) double> [(double *)vectp_x_i.2447_933]
# C/parallel-only-omp/simulation.h:743:                 vx_i[N_i]   = worker_buffers.new_ions[t].vx[i];
	vmovupd	32768(%rbx,%r9), %ymm0	# MEM <vector(4) double> [(value_type &)vectp.2449_926], MEM <vector(4) double> [(value_type &)vectp.2449_926]
	vmovq	%xmm1, %r14	# tmp1835, tmp1835
	vmovupd	%ymm0, (%r14,%rcx)	# MEM <vector(4) double> [(value_type &)vectp.2449_926], MEM <vector(4) double> [(double *)vectp_vx_i.2452_917]
# C/parallel-only-omp/simulation.h:744:                 vy_i[N_i]   = worker_buffers.new_ions[t].vy[i];
	vmovupd	65536(%rbx,%r9), %ymm0	# MEM <vector(4) double> [(value_type &)vectp.2454_910], MEM <vector(4) double> [(value_type &)vectp.2454_910]
	vmovq	%xmm6, %r14	# tmp1836, tmp1836
	vmovupd	%ymm0, (%r14,%rcx)	# MEM <vector(4) double> [(value_type &)vectp.2454_910], MEM <vector(4) double> [(double *)vectp_vy_i.2457_901]
# C/parallel-only-omp/simulation.h:745:                 vz_i[N_i]   = worker_buffers.new_ions[t].vz[i];
	vmovq	%xmm8, %r14	# tmp1837, tmp1837
# C/parallel-only-omp/simulation.h:744:                 vy_i[N_i]   = worker_buffers.new_ions[t].vy[i];
	vmovapd	%ymm0, -304(%rbp)	# MEM <vector(4) double> [(value_type &)vectp.2454_910], %sfp
# C/parallel-only-omp/simulation.h:745:                 vz_i[N_i]   = worker_buffers.new_ions[t].vz[i];
	vmovupd	98304(%rbx,%r9), %ymm0	# MEM <vector(4) double> [(value_type &)vectp.2459_894], tmp2370
	vmovupd	%ymm0, (%r14,%rcx)	# tmp2370, MEM <vector(4) double> [(double *)vectp_vz_i.2462_885]
	movq	%r11, %rcx	# niters.2438, niters_vector_mult_vf.2440
	andq	$-4, %rcx	#, niters_vector_mult_vf.2440
	addq	%rcx, %r8	# niters_vector_mult_vf.2440, niters_vector_mult_vf.2415
	addl	%ecx, %r10d	# niters_vector_mult_vf.2440, tmp.2417
	andl	$3, %r11d	#, niters.2438
	je	.L1358	#,
.L1355:
# C/parallel-only-omp/simulation.h:742:                 x_i[N_i]    = worker_buffers.new_ions[t].x[i];
	movslq	%r10d, %rcx	# tmp.2417, tmp.2417
	leaq	(%rax,%r8,8), %r11	#, _1300
	vmovq	%xmm2, %rbx	# tmp1834, tmp1834
# C/parallel-only-omp/simulation.h:741:             for (size_t i = 0; i < worker_buffers.new_ions[t].size(); ++i) {
	leaq	1(%r8), %r9	#, i
# C/parallel-only-omp/simulation.h:742:                 x_i[N_i]    = worker_buffers.new_ions[t].x[i];
	vmovsd	(%r11), %xmm0	# *_1300, _1477
	vmovsd	%xmm0, (%rbx,%rcx,8)	# _1477, x_i[N_i_lsm.2389_948]
# C/parallel-only-omp/simulation.h:743:                 vx_i[N_i]   = worker_buffers.new_ions[t].vx[i];
	vmovq	%xmm1, %rbx	# tmp1835, tmp1835
	vmovsd	32768(%r11), %xmm0	# MEM[(value_type &)_1300 + 32768], _332
	vmovsd	%xmm0, (%rbx,%rcx,8)	# _332, vx_i[N_i_lsm.2389_948]
# C/parallel-only-omp/simulation.h:744:                 vy_i[N_i]   = worker_buffers.new_ions[t].vy[i];
	vmovq	%xmm6, %rbx	# tmp1836, tmp1836
	vmovsd	65536(%r11), %xmm0	# MEM[(value_type &)_1300 + 65536], _1698
	vmovsd	%xmm0, (%rbx,%rcx,8)	# _1698, vy_i[N_i_lsm.2389_948]
# C/parallel-only-omp/simulation.h:745:                 vz_i[N_i]   = worker_buffers.new_ions[t].vz[i];
	vmovq	%xmm8, %rbx	# tmp1837, tmp1837
	vmovsd	98304(%r11), %xmm0	# MEM[(value_type &)_1300 + 98304], _494
	vmovsd	%xmm0, (%rbx,%rcx,8)	# _494, vz_i[N_i_lsm.2389_948]
# C/parallel-only-omp/simulation.h:746:                 N_i++;
	leal	1(%r10), %ecx	#, _376
# C/parallel-only-omp/simulation.h:741:             for (size_t i = 0; i < worker_buffers.new_ions[t].size(); ++i) {
	cmpq	%rsi, %r9	# _634, i
	jnb	.L1358	#,
# C/parallel-only-omp/simulation.h:742:                 x_i[N_i]    = worker_buffers.new_ions[t].x[i];
	movslq	%ecx, %rcx	# _376, _376
	vmovq	%xmm2, %rbx	# tmp1834, tmp1834
	vmovsd	8(%r11), %xmm0	# MEM[(value_type &)_1300 + 8], _1471
# C/parallel-only-omp/simulation.h:741:             for (size_t i = 0; i < worker_buffers.new_ions[t].size(); ++i) {
	addq	$2, %r8	#, i
# C/parallel-only-omp/simulation.h:742:                 x_i[N_i]    = worker_buffers.new_ions[t].x[i];
	vmovsd	%xmm0, (%rbx,%rcx,8)	# _1471, x_i[_376]
# C/parallel-only-omp/simulation.h:743:                 vx_i[N_i]   = worker_buffers.new_ions[t].vx[i];
	vmovq	%xmm1, %rbx	# tmp1835, tmp1835
	vmovsd	32776(%r11), %xmm0	# MEM[(value_type &)_1300 + 32776], _1694
# C/parallel-only-omp/simulation.h:746:                 N_i++;
	addl	$2, %r10d	#, _1599
# C/parallel-only-omp/simulation.h:743:                 vx_i[N_i]   = worker_buffers.new_ions[t].vx[i];
	vmovsd	%xmm0, (%rbx,%rcx,8)	# _1694, vx_i[_376]
# C/parallel-only-omp/simulation.h:744:                 vy_i[N_i]   = worker_buffers.new_ions[t].vy[i];
	vmovq	%xmm6, %rbx	# tmp1836, tmp1836
	vmovsd	65544(%r11), %xmm0	# MEM[(value_type &)_1300 + 65544], _1475
	vmovsd	%xmm0, (%rbx,%rcx,8)	# _1475, vy_i[_376]
# C/parallel-only-omp/simulation.h:745:                 vz_i[N_i]   = worker_buffers.new_ions[t].vz[i];
	vmovq	%xmm8, %rbx	# tmp1837, tmp1837
	vmovsd	98312(%r11), %xmm0	# MEM[(value_type &)_1300 + 98312], _117
	vmovsd	%xmm0, (%rbx,%rcx,8)	# _117, vz_i[_376]
# C/parallel-only-omp/simulation.h:741:             for (size_t i = 0; i < worker_buffers.new_ions[t].size(); ++i) {
	cmpq	%rsi, %r8	# _634, i
	jnb	.L1358	#,
# C/parallel-only-omp/simulation.h:742:                 x_i[N_i]    = worker_buffers.new_ions[t].x[i];
	movslq	%r10d, %r10	# _1599, _1599
	vmovq	%xmm2, %rsi	# tmp1834, tmp1834
	vmovsd	16(%r11), %xmm0	# MEM[(value_type &)_1300 + 16], _964
	vmovsd	%xmm0, (%rsi,%r10,8)	# _964, x_i[_1599]
# C/parallel-only-omp/simulation.h:743:                 vx_i[N_i]   = worker_buffers.new_ions[t].vx[i];
	vmovq	%xmm1, %rsi	# tmp1835, tmp1835
	vmovsd	32784(%r11), %xmm0	# MEM[(value_type &)_1300 + 32784], _962
	vmovsd	%xmm0, (%rsi,%r10,8)	# _962, vx_i[_1599]
# C/parallel-only-omp/simulation.h:744:                 vy_i[N_i]   = worker_buffers.new_ions[t].vy[i];
	vmovq	%xmm6, %rsi	# tmp1836, tmp1836
	vmovsd	65552(%r11), %xmm0	# MEM[(value_type &)_1300 + 65552], _960
	vmovsd	%xmm0, (%rsi,%r10,8)	# _960, vy_i[_1599]
# C/parallel-only-omp/simulation.h:745:                 vz_i[N_i]   = worker_buffers.new_ions[t].vz[i];
	vmovsd	98320(%r11), %xmm0	# MEM[(value_type &)_1300 + 98320], _958
	vmovsd	%xmm0, (%rbx,%r10,8)	# _958, vz_i[_1599]
.L1358:
# C/parallel-only-omp/simulation.h:746:                 N_i++;
	movzbl	-244(%rbp), %esi	# %sfp, _298
	addl	%edi, -224(%rbp)	# _157, %sfp
	movb	%sil, -261(%rbp)	# _298, %sfp
.L1350:
# C/parallel-only-omp/simulation.h:731:         for (int t = 0; t < num_threads; ++t) {
	addq	$64, -216(%rbp)	#, %sfp
	movq	-216(%rbp), %rsi	# %sfp, ivtmp.2755
	addq	$131136, %rdx	#, ivtmp.2757
	addq	$131136, %rax	#, ivtmp.2760
	addq	$16392, -240(%rbp)	#, %sfp
	cmpq	%rsi, -272(%rbp)	# ivtmp.2755, %sfp
	jne	.L1359	#,
	movq	-312(%rbp), %rax	# %sfp, tmp1423
	cmpb	$0, -260(%rbp)	#, %sfp
	movl	-248(%rbp), %r12d	# %sfp, tid
	movl	-388(%rbp), %ebx	# %sfp, nthreads
	movq	%rax, N_e_coll(%rip)	# tmp1423, N_e_coll
	je	.L1360	#,
	movl	-228(%rbp), %eax	# %sfp, N_e_lsm.2391
	movl	%eax, N_e(%rip)	# N_e_lsm.2391, N_e
.L1360:
	cmpb	$0, -261(%rbp)	#, %sfp
	je	.L1483	#,
	movl	-224(%rbp), %eax	# %sfp, N_i_lsm.2389
	movl	%eax, N_i(%rip)	# N_i_lsm.2389, N_i
	vzeroupper
.L1339:
	call	GOMP_barrier@PLT	#
# C/parallel-only-omp/simulation.h:907:             step8_collision_ions_body(tid, nthreads, t);
	movl	-232(%rbp), %edx	# %sfp,
	movl	%ebx, %esi	# nthreads,
	movl	%r12d, %edi	# tid,
	call	_Z25step8_collision_ions_bodyiii	#
# C/parallel-only-omp/simulation.h:910:             if (__builtin_expect(measurement_mode || (t % 1000) == 0, 0)) {
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	jne	.L1361	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	imull	$652835029, -232(%rbp), %eax	#, %sfp, tmp1678
	rorx	$3, %eax, %eax	#, tmp1678, tmp1679
# C/parallel-only-omp/simulation.h:910:             if (__builtin_expect(measurement_mode || (t % 1000) == 0, 0)) {
	cmpl	$4294967, %eax	#, tmp1679
	jbe	.L1361	#,
.L1365:
# C/parallel-only-omp/simulation.h:883:         for (int t = 0; t < N_T; t++) {
	incl	-232(%rbp)	# %sfp
	movl	-232(%rbp), %eax	# %sfp, t
# C/parallel-only-omp/simulation.h:883:         for (int t = 0; t < N_T; t++) {
	cmpl	$4000, %eax	#, t
	jne	.L1265	#,
# C/parallel-only-omp/simulation.h:878:     #pragma omp parallel
	movq	-56(%rbp), %rax	# D.135303, tmp1910
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp1910
	jne	.L1491	#,
	addq	$384, %rsp	#,
	popq	%rbx	#
	popq	%r10	#
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	leaq	-8(%r10), %rsp	#,
	.cfi_def_cfa 7, 8
	ret	
	.p2align 4
	.p2align 3
.L1489:
	.cfi_restore_state
# C/parallel-only-omp/simulation.h:550:                     if (last_valid > dead_idx) {
	cmpl	%eax, %edx	# last_valid, dead_idx
	jge	.L1320	#,
# C/parallel-only-omp/simulation.h:551:                         x_e[dead_idx]  = x_e[last_valid];
	movslq	%eax, %rdi	# last_valid, last_valid
# C/parallel-only-omp/simulation.h:546:                 for (int dead_idx : worker_buffers.absorbed_indices[t]) {
	addq	$4, %r15	#, ivtmp.2795
# C/parallel-only-omp/simulation.h:555:                         last_valid--;
	decl	%eax	# last_valid
# C/parallel-only-omp/simulation.h:551:                         x_e[dead_idx]  = x_e[last_valid];
	vmovsd	(%r10,%rdi,8), %xmm0	# x_e[last_valid_468], _409
# C/parallel-only-omp/simulation.h:551:                         x_e[dead_idx]  = x_e[last_valid];
	vmovsd	%xmm0, (%r10,%rdx,8)	# _409, x_e[dead_idx_404]
# C/parallel-only-omp/simulation.h:552:                         vx_e[dead_idx] = vx_e[last_valid];
	vmovsd	(%r14,%rdi,8), %xmm0	# vx_e[last_valid_468], _410
# C/parallel-only-omp/simulation.h:552:                         vx_e[dead_idx] = vx_e[last_valid];
	vmovsd	%xmm0, (%r14,%rdx,8)	# _410, vx_e[dead_idx_404]
# C/parallel-only-omp/simulation.h:553:                         vy_e[dead_idx] = vy_e[last_valid];
	vmovsd	0(%r13,%rdi,8), %xmm0	# vy_e[last_valid_468], _411
# C/parallel-only-omp/simulation.h:553:                         vy_e[dead_idx] = vy_e[last_valid];
	vmovsd	%xmm0, 0(%r13,%rdx,8)	# _411, vy_e[dead_idx_404]
# C/parallel-only-omp/simulation.h:554:                         vz_e[dead_idx] = vz_e[last_valid];
	vmovsd	(%r11,%rdi,8), %xmm0	# vz_e[last_valid_468], _412
# C/parallel-only-omp/simulation.h:554:                         vz_e[dead_idx] = vz_e[last_valid];
	vmovsd	%xmm0, (%r11,%rdx,8)	# _412, vz_e[dead_idx_404]
# C/parallel-only-omp/simulation.h:546:                 for (int dead_idx : worker_buffers.absorbed_indices[t]) {
	cmpq	%r15, %rcx	# ivtmp.2795, _402
	jne	.L1323	#,
	jmp	.L1492	#
	.p2align 4
	.p2align 3
.L1351:
	salq	$3, %rcx	#, _1662
	vmovq	%xmm2, %rbx	# tmp1834, tmp1834
	leaq	(%rbx,%rcx), %r11	#, _499
	vmovq	%xmm1, %rbx	# tmp1835, tmp1835
	leaq	(%rbx,%rcx), %r10	#, _607
	vmovq	%xmm6, %rbx	# tmp1836, tmp1836
	leaq	(%rbx,%rcx), %r9	#, _496
	vmovq	%xmm8, %rbx	# tmp1837, tmp1837
	leaq	(%rbx,%rcx), %r8	#, _1655
# C/parallel-only-omp/simulation.h:741:             for (size_t i = 0; i < worker_buffers.new_ions[t].size(); ++i) {
	xorl	%ecx, %ecx	# i
	.p2align 4
	.p2align 3
.L1357:
# C/parallel-only-omp/simulation.h:742:                 x_i[N_i]    = worker_buffers.new_ions[t].x[i];
	vmovsd	(%rax,%rcx,8), %xmm0	# MEM[(value_type &)_689 + i_1064 * 8], _1061
	vmovsd	%xmm0, (%r11,%rcx,8)	# _1061, MEM[(double *)_499 + i_1064 * 8]
# C/parallel-only-omp/simulation.h:743:                 vx_i[N_i]   = worker_buffers.new_ions[t].vx[i];
	vmovsd	32768(%rax,%rcx,8), %xmm0	# MEM[(value_type &)_689 + 32768 + i_1064 * 8], _1059
	vmovsd	%xmm0, (%r10,%rcx,8)	# _1059, MEM[(double *)_607 + i_1064 * 8]
# C/parallel-only-omp/simulation.h:744:                 vy_i[N_i]   = worker_buffers.new_ions[t].vy[i];
	vmovsd	65536(%rax,%rcx,8), %xmm0	# MEM[(value_type &)_689 + 65536 + i_1064 * 8], _1057
	vmovsd	%xmm0, (%r9,%rcx,8)	# _1057, MEM[(double *)_496 + i_1064 * 8]
# C/parallel-only-omp/simulation.h:745:                 vz_i[N_i]   = worker_buffers.new_ions[t].vz[i];
	vmovsd	98304(%rax,%rcx,8), %xmm0	# MEM[(value_type &)_689 + 98304 + i_1064 * 8], _1055
	vmovsd	%xmm0, (%r8,%rcx,8)	# _1055, MEM[(double *)_1655 + i_1064 * 8]
# C/parallel-only-omp/simulation.h:741:             for (size_t i = 0; i < worker_buffers.new_ions[t].size(); ++i) {
	incq	%rcx	# i
# C/parallel-only-omp/simulation.h:741:             for (size_t i = 0; i < worker_buffers.new_ions[t].size(); ++i) {
	cmpq	%rcx, %rsi	# i, _634
	jne	.L1357	#,
	jmp	.L1358	#
	.p2align 4
	.p2align 3
.L1342:
	salq	$3, %rcx	#, _513
	vmovq	%xmm5, %rbx	# tmp1830, tmp1830
	leaq	(%rbx,%rcx), %r11	#, _1282
	vmovq	%xmm4, %rbx	# tmp1831, tmp1831
	leaq	(%rbx,%rcx), %r10	#, _1611
	vmovq	%xmm7, %rbx	# tmp1832, tmp1832
	leaq	(%rbx,%rcx), %r9	#, _1625
	vmovq	%xmm9, %rbx	# tmp1833, tmp1833
	leaq	(%rbx,%rcx), %r8	#, _1623
# C/parallel-only-omp/simulation.h:734:             for (size_t i = 0; i < worker_buffers.new_electrons[t].size(); ++i) {
	xorl	%ecx, %ecx	# i
	.p2align 4
	.p2align 3
.L1348:
# C/parallel-only-omp/simulation.h:735:                 x_e[N_e]    = worker_buffers.new_electrons[t].x[i];
	vmovsd	(%rdx,%rcx,8), %xmm0	# MEM[(value_type &)_466 + i_754 * 8], _731
	vmovsd	%xmm0, (%r11,%rcx,8)	# _731, MEM[(double *)_1282 + i_754 * 8]
# C/parallel-only-omp/simulation.h:736:                 vx_e[N_e]   = worker_buffers.new_electrons[t].vx[i];
	vmovsd	32768(%rdx,%rcx,8), %xmm0	# MEM[(value_type &)_466 + 32768 + i_754 * 8], _729
	vmovsd	%xmm0, (%r10,%rcx,8)	# _729, MEM[(double *)_1611 + i_754 * 8]
# C/parallel-only-omp/simulation.h:737:                 vy_e[N_e]   = worker_buffers.new_electrons[t].vy[i];
	vmovsd	65536(%rdx,%rcx,8), %xmm0	# MEM[(value_type &)_466 + 65536 + i_754 * 8], _707
	vmovsd	%xmm0, (%r9,%rcx,8)	# _707, MEM[(double *)_1625 + i_754 * 8]
# C/parallel-only-omp/simulation.h:738:                 vz_e[N_e]   = worker_buffers.new_electrons[t].vz[i];
	vmovsd	98304(%rdx,%rcx,8), %xmm0	# MEM[(value_type &)_466 + 98304 + i_754 * 8], _687
	vmovsd	%xmm0, (%r8,%rcx,8)	# _687, MEM[(double *)_1623 + i_754 * 8]
# C/parallel-only-omp/simulation.h:734:             for (size_t i = 0; i < worker_buffers.new_electrons[t].size(); ++i) {
	incq	%rcx	# i
# C/parallel-only-omp/simulation.h:734:             for (size_t i = 0; i < worker_buffers.new_electrons[t].size(); ++i) {
	cmpq	%rcx, %rsi	# i, _330
	jne	.L1348	#,
	jmp	.L1349	#
.L1487:
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	-344(%rbp), %rdi	# %sfp, _359
	addq	264+worker_buffers(%rip), %rdi	# MEM[(struct vector *)&worker_buffers + 264B].D.107139._M_impl.D.106478._M_start, _359
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	movq	8(%rdi), %rsi	# MEM[(struct vector *)_359].D.110314._M_impl.D.109653._M_finish, _421
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	16(%rdi), %rsi	# MEM[(struct vector *)_359].D.110314._M_impl.D.109653._M_end_of_storage, _421
	je	.L1307	#,
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movl	%r13d, (%rsi)	# _373, *_421
# /usr/include/c++/13/bits/stl_vector.h:1288: 	    ++this->_M_impl._M_finish;
	addq	$4, %rsi	#, tmp1168
	movq	%rsi, 8(%rdi)	# tmp1168, MEM[(struct vector *)_359].D.110314._M_impl.D.109653._M_finish
.L1308:
# C/parallel-only-omp/simulation.h:524:             worker_buffers.thread_counters[tid].local_abs_pow++;
	incq	16(%rcx,%rbx)	# _361->local_abs_pow
	jmp	.L1309	#
.L1488:
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	-344(%rbp), %rdi	# %sfp, _368
	addq	264+worker_buffers(%rip), %rdi	# MEM[(struct vector *)&worker_buffers + 264B].D.107139._M_impl.D.106478._M_start, _368
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	movq	8(%rdi), %rsi	# MEM[(struct vector *)_368].D.110314._M_impl.D.109653._M_finish, _425
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	16(%rdi), %rsi	# MEM[(struct vector *)_368].D.110314._M_impl.D.109653._M_end_of_storage, _425
	je	.L1311	#,
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	movl	%r13d, (%rsi)	# _373, *_425
# /usr/include/c++/13/bits/stl_vector.h:1288: 	    ++this->_M_impl._M_finish;
	addq	$4, %rsi	#, tmp1175
	movq	%rsi, 8(%rdi)	# tmp1175, MEM[(struct vector *)_368].D.110314._M_impl.D.109653._M_finish
.L1312:
# C/parallel-only-omp/simulation.h:527:             worker_buffers.thread_counters[tid].local_abs_gnd++;
	incq	24(%rcx,%rbx)	# _370->local_abs_gnd
	jmp	.L1309	#
.L1280:
	movl	$400, %eax	#, q.59_107
	xorl	%edx, %edx	# tt.60_108
	idivl	%ebx	# nthreads
	cmpl	%edx, %r12d	# tt.60_108, tid
	jl	.L1493	#,
.L1294:
	movl	%r12d, %r10d	# tid, _111
	imull	%eax, %r10d	# q.59_107, _111
	leal	(%r10,%rdx), %r8d	#, tmp.2615
	leal	(%rax,%r8), %r13d	#, _114
	cmpl	%r13d, %r8d	# _114, tmp.2615
	jge	.L1291	#,
	leal	-1(%rax), %ecx	#, tmp1104
	cmpl	$6, %ecx	#, tmp1104
	jbe	.L1382	#,
	movslq	%edx, %rcx	# tt.60_108, tt.60_108
	movslq	%r10d, %r9	# _111, _111
	movl	%eax, %r11d	# q.59_107, bnd.2600
	leaq	cumul_i_density(%rip), %rdi	#, tmp1808
	addq	%rcx, %r9	# tt.60_108, tmp1107
	leaq	i_density(%rip), %rcx	#, tmp1784
# C/parallel-only-omp/simulation.h:124:     if ((t % N_SUB) == 0) {
	xorl	%esi, %esi	# ivtmp.2920
	shrl	$3, %r11d	#,
	salq	$3, %r9	#, _1719
	salq	$6, %r11	#, _1790
	leaq	(%rdi,%r9), %r14	#, vectp_cumul_i_density.2604
	addq	%rcx, %r9	# tmp1784, vectp_i_density.2607
.L1296:
# C/parallel-only-omp/simulation.h:170:         for (int p = 0; p < N_G; p++) cumul_i_density[p] += i_density[p];
	vmovupd	(%r14,%rsi), %zmm7	# MEM <vector(8) double> [(double *)vectp_cumul_i_density.2604_1715 + ivtmp.2920_1782 * 1], tmp2163
	vaddpd	(%r9,%rsi), %zmm7, %zmm0	# MEM <vector(8) double> [(double *)vectp_i_density.2607_1723 + ivtmp.2920_1782 * 1], tmp2163, vect__118.2609
	vmovupd	%zmm0, (%r14,%rsi)	# vect__118.2609, MEM <vector(8) double> [(double *)vectp_cumul_i_density.2604_1715 + ivtmp.2920_1782 * 1]
	addq	$64, %rsi	#, ivtmp.2920
	cmpq	%r11, %rsi	# _1790, ivtmp.2920
	jne	.L1296	#,
	movl	%eax, %esi	# q.59_107, niters_vector_mult_vf.2601
	andl	$-8, %esi	#,
	addl	%esi, %r8d	# niters_vector_mult_vf.2601, tmp.2615
	cmpl	%esi, %eax	# niters_vector_mult_vf.2601, q.59_107
	je	.L1482	#,
.L1295:
	subl	%esi, %eax	# niters_vector_mult_vf.2601, niters.2612
	leal	-1(%rax), %r9d	#, tmp1115
	cmpl	$2, %r9d	#, tmp1115
	jbe	.L1298	#,
	movslq	%r10d, %r10	# _111, _111
	movslq	%edx, %rdx	# tt.60_108, tt.60_108
	addq	%r10, %rdx	# _111, tmp1118
	addq	%rsi, %rdx	# niters_vector_mult_vf.2601, tmp1120
	salq	$3, %rdx	#, _1773
	leaq	(%rdi,%rdx), %rsi	#, vectp_cumul_i_density.2617
	vmovupd	(%rcx,%rdx), %ymm7	# MEM <vector(4) double> [(double *)vectp_i_density.2620_1777], tmp2165
	vaddpd	(%rsi), %ymm7, %ymm0	# MEM <vector(4) double> [(double *)vectp_cumul_i_density.2617_1767], tmp2165, vect__1698.2622
	vmovupd	%ymm0, (%rsi)	# vect__1698.2622, MEM <vector(4) double> [(double *)vectp_cumul_i_density.2617_1767]
	testb	$3, %al	#, niters.2612
	je	.L1482	#,
	andl	$-4, %eax	#, niters_vector_mult_vf.2614
	addl	%eax, %r8d	# niters_vector_mult_vf.2614, tmp.2615
.L1298:
	movslq	%r8d, %rax	# tmp.2615, tmp.2615
	vmovsd	(%rdi,%rax,8), %xmm0	# cumul_i_density[p_1760], cumul_i_density[p_1760]
	vaddsd	(%rcx,%rax,8), %xmm0, %xmm0	# i_density[p_1760], cumul_i_density[p_1760], tmp1134
	vmovsd	%xmm0, (%rdi,%rax,8)	# tmp1134, cumul_i_density[p_1760]
	leal	1(%r8), %eax	#, p
	cmpl	%eax, %r13d	# p, _114
	jle	.L1482	#,
	cltq
	addl	$2, %r8d	#, p
	vmovsd	(%rdi,%rax,8), %xmm0	# cumul_i_density[p_1154], cumul_i_density[p_1154]
	vaddsd	(%rcx,%rax,8), %xmm0, %xmm0	# i_density[p_1154], cumul_i_density[p_1154], tmp1142
	vmovsd	%xmm0, (%rdi,%rax,8)	# tmp1142, cumul_i_density[p_1154]
	cmpl	%r8d, %r13d	# p, _114
	jle	.L1482	#,
	movslq	%r8d, %r8	# p, p
	vmovsd	(%rdi,%r8,8), %xmm0	# cumul_i_density[p_1288], cumul_i_density[p_1288]
	vaddsd	(%rcx,%r8,8), %xmm0, %xmm0	# i_density[p_1288], cumul_i_density[p_1288], tmp1150
	vmovsd	%xmm0, (%rdi,%r8,8)	# tmp1150, cumul_i_density[p_1288]
	vzeroupper
	call	GOMP_single_start@PLT	#
	testb	%al, %al	# tmp1886
	je	.L1376	#,
.L1300:
# C/parallel-only-omp/simulation.h:893:                 Time += DT_E;
	vmovsd	.LC52(%rip), %xmm0	#, tmp1681
	vaddsd	Time(%rip), %xmm0, %xmm0	# Time, tmp1681, _15
	vmovsd	%xmm0, Time(%rip)	# _15, Time
# C/parallel-only-omp/poisson.h:45:     pot[0]     = VOLTAGE * cos(OMEGA * tt);         // Potencjał na elektrodzie zasilanej RF (x = 0)
	vmulsd	.LC205(%rip), %xmm0, %xmm0	#, _15, tmp1682
	call	cos@PLT	#
	vbroadcastsd	.LC207(%rip), %zmm1	#, tmp1802
# C/parallel-only-omp/poisson.h:45:     pot[0]     = VOLTAGE * cos(OMEGA * tt);         // Potencjał na elektrodzie zasilanej RF (x = 0)
	leaq	pot(%rip), %r8	#, ivtmp.2830
# C/parallel-only-omp/poisson.h:46:     pot[N_G-1] = 0.0;                               // Potencjał na elektrodzie uziemionej (x = L)
	movl	$8, %eax	#, ivtmp.2882
	leaq	e_density(%rip), %rsi	#, tmp1803
	leaq	i_density(%rip), %rcx	#, tmp1784
	leaq	f_poisson(%rip), %rdi	#, tmp1785
# C/parallel-only-omp/poisson.h:45:     pot[0]     = VOLTAGE * cos(OMEGA * tt);         // Potencjał na elektrodzie zasilanej RF (x = 0)
	vmulsd	.LC87(%rip), %xmm0, %xmm2	#, tmp1891, _511
# C/parallel-only-omp/poisson.h:46:     pot[N_G-1] = 0.0;                               // Potencjał na elektrodzie uziemionej (x = L)
	movq	$0x000000000, 3192+pot(%rip)	#, pot[399]
# C/parallel-only-omp/poisson.h:45:     pot[0]     = VOLTAGE * cos(OMEGA * tt);         // Potencjał na elektrodzie zasilanej RF (x = 0)
	vmovsd	%xmm2, pot(%rip)	# _511, pot[0]
	.p2align 4
	.p2align 3
.L1372:
# C/parallel-only-omp/poisson.h:50:         f_poisson[i] = ALPHA_Q * (i_density[i] - e_density[i]);
	vmovupd	(%rcx,%rax), %zmm4	# MEM <vector(8) double> [(double *)&i_density + ivtmp.2882_1017 * 1], tmp2404
	vsubpd	(%rsi,%rax), %zmm4, %zmm0	# MEM <vector(8) double> [(double *)&e_density + ivtmp.2882_1017 * 1], tmp2404, vect__515.2583
# C/parallel-only-omp/poisson.h:50:         f_poisson[i] = ALPHA_Q * (i_density[i] - e_density[i]);
	vmulpd	%zmm1, %zmm0, %zmm0	# tmp1802, vect__515.2583, vect__516.2584
# C/parallel-only-omp/poisson.h:50:         f_poisson[i] = ALPHA_Q * (i_density[i] - e_density[i]);
	vmovupd	%zmm0, (%rdi,%rax)	# vect__516.2584, MEM <vector(8) double> [(double *)&f_poisson + ivtmp.2882_1017 * 1]
	addq	$64, %rax	#, ivtmp.2882
	cmpq	$3144, %rax	#, ivtmp.2882
	jne	.L1372	#,
# C/parallel-only-omp/poisson.h:50:         f_poisson[i] = ALPHA_Q * (i_density[i] - e_density[i]);
	vmovupd	3144+i_density(%rip), %ymm7	# MEM <vector(4) double> [(double *)&i_density + 3144B], tmp2405
	vsubpd	3144+e_density(%rip), %ymm7, %ymm0	# MEM <vector(4) double> [(double *)&e_density + 3144B], tmp2405, vect__1632.2595
	vmovupd	3176+i_density(%rip), %xmm4	# MEM <vector(2) double> [(double *)&i_density + 3176B], tmp2406
# C/parallel-only-omp/poisson.h:56:     g_poisson[1] = f_poisson[1] * inv_denom_thomas[1];
	movl	$16, %eax	#, ivtmp.2868
	leaq	inv_denom_thomas(%rip), %rcx	#, tmp1780
	leaq	g_poisson(%rip), %rdx	#, tmp1800
# C/parallel-only-omp/poisson.h:50:         f_poisson[i] = ALPHA_Q * (i_density[i] - e_density[i]);
	vmulpd	.LC207(%rip){1to4}, %ymm0, %ymm0	#, vect__1632.2595, vect__1633.2596
# C/parallel-only-omp/poisson.h:50:         f_poisson[i] = ALPHA_Q * (i_density[i] - e_density[i]);
	vmovupd	%ymm0, 3144+f_poisson(%rip)	# vect__1633.2596, MEM <vector(4) double> [(double *)&f_poisson + 3144B]
# C/parallel-only-omp/poisson.h:50:         f_poisson[i] = ALPHA_Q * (i_density[i] - e_density[i]);
	vsubpd	3176+e_density(%rip), %xmm4, %xmm0	# MEM <vector(2) double> [(double *)&e_density + 3176B], tmp2406, vect__1251.2652
# C/parallel-only-omp/poisson.h:50:         f_poisson[i] = ALPHA_Q * (i_density[i] - e_density[i]);
	vmulpd	.LC207(%rip){1to2}, %xmm0, %xmm0	#, vect__1251.2652, vect__1228.2653
# C/parallel-only-omp/poisson.h:50:         f_poisson[i] = ALPHA_Q * (i_density[i] - e_density[i]);
	vmovupd	%xmm0, 3176+f_poisson(%rip)	# vect__1228.2653, MEM <vector(2) double> [(double *)&f_poisson + 3176B]
# C/parallel-only-omp/poisson.h:52:     f_poisson[1] -= pot[0];
	vmovsd	8+f_poisson(%rip), %xmm0	# f_poisson[1], f_poisson[1]
	vsubsd	%xmm2, %xmm0, %xmm0	# _511, f_poisson[1], _519
	vmovsd	%xmm0, 8+f_poisson(%rip)	# _519, f_poisson[1]
# C/parallel-only-omp/poisson.h:56:     g_poisson[1] = f_poisson[1] * inv_denom_thomas[1];
	vmulsd	8+inv_denom_thomas(%rip), %xmm0, %xmm0	# inv_denom_thomas[1], _519, g_poisson_I_lsm0.2638
# C/parallel-only-omp/poisson.h:56:     g_poisson[1] = f_poisson[1] * inv_denom_thomas[1];
	vmovsd	%xmm0, 8+g_poisson(%rip)	# g_poisson_I_lsm0.2638, g_poisson[1]
	.p2align 4
	.p2align 3
.L1373:
# C/parallel-only-omp/poisson.h:58:         g_poisson[i] = (f_poisson[i] - A * g_poisson[i - 1]) * inv_denom_thomas[i];
	vmovsd	(%rdi,%rax), %xmm1	# MEM[(double *)&f_poisson + ivtmp.2868_1016 * 1], MEM[(double *)&f_poisson + ivtmp.2868_1016 * 1]
	vsubsd	%xmm0, %xmm1, %xmm0	# g_poisson_I_lsm0.2638, MEM[(double *)&f_poisson + ivtmp.2868_1016 * 1], tmp1721
# C/parallel-only-omp/poisson.h:58:         g_poisson[i] = (f_poisson[i] - A * g_poisson[i - 1]) * inv_denom_thomas[i];
	vmulsd	(%rcx,%rax), %xmm0, %xmm0	# MEM[(double *)&inv_denom_thomas + ivtmp.2868_1016 * 1], tmp1721, g_poisson_I_lsm0.2638
# C/parallel-only-omp/poisson.h:58:         g_poisson[i] = (f_poisson[i] - A * g_poisson[i - 1]) * inv_denom_thomas[i];
	vmovsd	%xmm0, (%rdx,%rax)	# g_poisson_I_lsm0.2638, MEM[(double *)&g_poisson + ivtmp.2868_1016 * 1]
# C/parallel-only-omp/poisson.h:57:     for (i = 2; i <= N_G - 2; i++){
	addq	$8, %rax	#, ivtmp.2868
	cmpq	$3192, %rax	#, ivtmp.2868
	jne	.L1373	#,
# C/parallel-only-omp/poisson.h:63:     pot[N_G-2] = g_poisson[N_G-2];
	movl	$3176, %eax	#, ivtmp.2853
	leaq	w_thomas(%rip), %rcx	#, tmp1798
# C/parallel-only-omp/poisson.h:63:     pot[N_G-2] = g_poisson[N_G-2];
	vmovsd	3184+g_poisson(%rip), %xmm5	# g_poisson[398], _530
# C/parallel-only-omp/poisson.h:63:     pot[N_G-2] = g_poisson[N_G-2];
	vmovsd	%xmm5, 3184+pot(%rip)	# _530, pot[398]
	vmovsd	%xmm5, %xmm5, %xmm0	# _530, pot_I_lsm0.2637
	.p2align 4
	.p2align 3
.L1374:
# C/parallel-only-omp/poisson.h:65:         pot[i] = g_poisson[i] - w_thomas[i] * pot[i + 1];
	vmovsd	(%rdx,%rax), %xmm6	# MEM[(double *)&g_poisson + ivtmp.2853_1021 * 1], tmp2407
	vfnmadd132sd	(%rcx,%rax), %xmm6, %xmm0	# MEM[(double *)&w_thomas + ivtmp.2853_1021 * 1], tmp2407, pot_I_lsm0.2637
# C/parallel-only-omp/poisson.h:65:         pot[i] = g_poisson[i] - w_thomas[i] * pot[i + 1];
	vmovsd	%xmm0, (%r8,%rax)	# pot_I_lsm0.2637, MEM[(double *)&pot + ivtmp.2853_1021 * 1]
# C/parallel-only-omp/poisson.h:64:     for (i = N_G - 3; i > 0; i--){
	subq	$8, %rax	#, ivtmp.2853
	jne	.L1374	#,
	vbroadcastsd	.LC211(%rip), %zmm1	#, tmp1807
	leaq	pot(%rip), %rax	#, ivtmp.2830
	leaq	8+efield(%rip), %rdx	#, ivtmp.2835
	leaq	3136(%rax), %rcx	#, _1034
	.p2align 4
	.p2align 3
.L1375:
# C/parallel-only-omp/poisson.h:70:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // Wnętrze siatki: E_i = (phi_{i-1} - phi_{i+1}) / (2*DX)
	vmovapd	(%rax), %zmm7	# MEM <vector(8) double> [(double *)_1071], tmp2408
	vsubpd	16(%rax), %zmm7, %zmm0	# MEM <vector(8) double> [(double *)_1071 + 16B], tmp2408, vect__544.2559
	addq	$64, %rax	#, ivtmp.2830
	addq	$64, %rdx	#, ivtmp.2835
# C/parallel-only-omp/poisson.h:70:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // Wnętrze siatki: E_i = (phi_{i-1} - phi_{i+1}) / (2*DX)
	vmulpd	%zmm1, %zmm0, %zmm0	# tmp1807, vect__544.2559, vect__545.2560
# C/parallel-only-omp/poisson.h:70:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // Wnętrze siatki: E_i = (phi_{i-1} - phi_{i+1}) / (2*DX)
	vmovupd	%zmm0, -64(%rdx)	# vect__545.2560, MEM <vector(8) double> [(double *)_1050]
	cmpq	%rax, %rcx	# ivtmp.2830, _1034
	jne	.L1375	#,
# C/parallel-only-omp/poisson.h:70:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // Wnętrze siatki: E_i = (phi_{i-1} - phi_{i+1}) / (2*DX)
	vmovapd	3136+pot(%rip), %ymm7	# MEM <vector(4) double> [(double *)&pot + 3136B], tmp2409
	vsubpd	3152+pot(%rip), %ymm7, %ymm0	# MEM <vector(4) double> [(double *)&pot + 3152B], tmp2409, vect__1577.2571
	vmovapd	3168+pot(%rip), %xmm4	# MEM <vector(2) double> [(double *)&pot + 3168B], tmp2410
# C/parallel-only-omp/poisson.h:71:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - (i_density[0] - e_density[0]) * BETA_Q;   // Elektroda zasilana
	vmovsd	.LC214(%rip), %xmm1	#, tmp1760
# C/parallel-only-omp/poisson.h:71:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - (i_density[0] - e_density[0]) * BETA_Q;   // Elektroda zasilana
	vsubsd	8+pot(%rip), %xmm2, %xmm2	# pot[1], _511, tmp1754
# C/parallel-only-omp/poisson.h:70:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // Wnętrze siatki: E_i = (phi_{i-1} - phi_{i+1}) / (2*DX)
	vmulpd	.LC211(%rip){1to4}, %ymm0, %ymm0	#, vect__1577.2571, vect__1578.2572
# C/parallel-only-omp/poisson.h:70:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // Wnętrze siatki: E_i = (phi_{i-1} - phi_{i+1}) / (2*DX)
	vmovupd	%ymm0, 3144+efield(%rip)	# vect__1578.2572, MEM <vector(4) double> [(double *)&efield + 3144B]
# C/parallel-only-omp/poisson.h:70:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // Wnętrze siatki: E_i = (phi_{i-1} - phi_{i+1}) / (2*DX)
	vsubpd	3184+pot(%rip), %xmm4, %xmm0	# MEM <vector(2) double> [(double *)&pot + 3184B], tmp2410, vect__1425.2662
# C/parallel-only-omp/poisson.h:71:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - (i_density[0] - e_density[0]) * BETA_Q;   // Elektroda zasilana
	vmovsd	.LC59(%rip), %xmm4	#, tmp1788
# C/parallel-only-omp/poisson.h:70:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // Wnętrze siatki: E_i = (phi_{i-1} - phi_{i+1}) / (2*DX)
	vmulpd	.LC211(%rip){1to2}, %xmm0, %xmm0	#, vect__1425.2662, vect__1424.2663
# C/parallel-only-omp/poisson.h:70:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // Wnętrze siatki: E_i = (phi_{i-1} - phi_{i+1}) / (2*DX)
	vmovupd	%xmm0, 3176+efield(%rip)	# vect__1424.2663, MEM <vector(2) double> [(double *)&efield + 3176B]
# C/parallel-only-omp/poisson.h:71:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - (i_density[0] - e_density[0]) * BETA_Q;   // Elektroda zasilana
	vmovsd	i_density(%rip), %xmm0	# i_density[0], i_density[0]
	vsubsd	e_density(%rip), %xmm0, %xmm0	# e_density[0], i_density[0], tmp1757
# C/parallel-only-omp/poisson.h:71:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - (i_density[0] - e_density[0]) * BETA_Q;   // Elektroda zasilana
	vmulsd	%xmm1, %xmm0, %xmm0	# tmp1760, tmp1757, tmp1759
# C/parallel-only-omp/poisson.h:71:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - (i_density[0] - e_density[0]) * BETA_Q;   // Elektroda zasilana
	vfmsub231sd	%xmm4, %xmm2, %xmm0	# tmp1788, tmp1754, _554
# C/parallel-only-omp/poisson.h:71:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - (i_density[0] - e_density[0]) * BETA_Q;   // Elektroda zasilana
	vmovsd	%xmm0, efield(%rip)	# _554, efield[0]
# C/parallel-only-omp/poisson.h:72:     efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + (i_density[N_G-1] - e_density[N_G-1]) * BETA_Q;   // Elektroda uziemiona
	vmovsd	3192+i_density(%rip), %xmm0	# i_density[399], i_density[399]
	vsubsd	3192+e_density(%rip), %xmm0, %xmm0	# e_density[399], i_density[399], tmp1765
# C/parallel-only-omp/poisson.h:72:     efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + (i_density[N_G-1] - e_density[N_G-1]) * BETA_Q;   // Elektroda uziemiona
	vmulsd	%xmm1, %xmm0, %xmm0	# tmp1760, tmp1765, tmp1767
# C/parallel-only-omp/poisson.h:72:     efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + (i_density[N_G-1] - e_density[N_G-1]) * BETA_Q;   // Elektroda uziemiona
	vfmadd231sd	%xmm4, %xmm5, %xmm0	# tmp1788, _530, _563
# C/parallel-only-omp/poisson.h:72:     efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + (i_density[N_G-1] - e_density[N_G-1]) * BETA_Q;   // Elektroda uziemiona
	vmovsd	%xmm0, 3192+efield(%rip)	# _563, efield[399]
	vzeroupper
# C/parallel-only-omp/poisson.h:73: }
	jmp	.L1376	#
.L1378:
# C/parallel-only-omp/simulation.h:75:         double sum = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# sum
	jmp	.L1274	#
.L1490:
# /usr/include/c++/13/bits/random.h:3875: 	  _M_initialize();
	leaq	-208(%rbp), %r13	#, tmp1317
# /usr/include/c++/13/bits/random.h:3870: 	: _M_t(__t), _M_p(__p)
	movl	%r11d, -208(%rbp)	# N_local, MEM[(struct param_type *)_909]._M_t
	movl	%r11d, -224(%rbp)	# N_local, %sfp
# /usr/include/c++/13/bits/random.h:3870: 	: _M_t(__t), _M_p(__p)
	vmovsd	P_star_e(%rip), %xmm0	# P_star_e, P_star_e.135_243
# /usr/include/c++/13/bits/random.h:3875: 	  _M_initialize();
	movq	%r13, %rdi	# tmp1317,
# /usr/include/c++/13/bits/random.h:3870: 	: _M_t(__t), _M_p(__p)
	vmovsd	%xmm0, -200(%rbp)	# P_star_e.135_243, MEM[(struct param_type *)_909]._M_p
# /usr/include/c++/13/bits/random.h:3875: 	  _M_initialize();
	call	_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv	#
# /usr/include/c++/13/bits/random.h:2034: 	: _M_mean(__mean), _M_stddev(__stddev)
	movq	.LC10(%rip), %rax	#, tmp2205
# /usr/include/c++/13/bits/random.h:2034: 	: _M_mean(__mean), _M_stddev(__stddev)
	movq	$0x000000000, -96(%rbp)	#, MEM[(struct param_type *)_909]._M_mean
# /usr/include/c++/13/bits/random.h:2073:       : _M_param(__mean, __stddev)
	movq	$0x000000000, -80(%rbp)	#, MEM[(struct normal_distribution *)_909]._M_saved
	movb	$0, -72(%rbp)	#, MEM[(struct normal_distribution *)_909]._M_saved_available
# /usr/include/c++/13/bits/random.h:2034: 	: _M_mean(__mean), _M_stddev(__stddev)
	movq	%rax, -88(%rbp)	# tmp2205, MEM[(struct param_type *)_909]._M_stddev
# C/parallel-only-omp/simulation.h:703:         int local_N_coll = binom_e(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.h:3981: 	{ return this->operator()(__urng, _M_param); }
	movq	%fs:0, %rax	#, tmp2206
	movq	%r13, %rdx	# tmp1317,
	movq	%r13, %rdi	# tmp1317,
	leaq	MTgen@tpoff(%rax), %rsi	#, tmp1322
	call	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE	#
# C/parallel-only-omp/simulation.h:704:         if (local_N_coll > N_local) local_N_coll = N_local;
	movl	-224(%rbp), %r11d	# %sfp, N_local
	cmpl	%eax, %r11d	# tmp1888, N_local
	cmovle	%r11d, %eax	# N_local,, _245
# C/parallel-only-omp/simulation.h:706:         for (int i = 0; i < local_N_coll; ++i) {
	testl	%eax, %eax	# _245
	jle	.L1325	#,
# C/parallel-only-omp/simulation.h:720:                 collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index,
	movl	-216(%rbp), %r8d	# %sfp, _592
	leaq	R01@tpoff, %r14	#, tmp1804
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp2207
	movl	%ebx, -260(%rbp)	# nthreads, %sfp
	vcvtsi2sdl	%r11d, %xmm7, %xmm0	# N_local, tmp2207, tmp1895
# C/parallel-only-omp/simulation.h:706:         for (int i = 0; i < local_N_coll; ++i) {
	xorl	%r13d, %r13d	# i
	leaq	MTgen@tpoff, %r15	#, tmp1783
# C/parallel-only-omp/simulation.h:720:                 collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index,
	movq	%r14, %rbx	# tmp1804, tmp1804
	vmovsd	%xmm0, -224(%rbp)	# tmp1895, %sfp
	movl	%r12d, -304(%rbp)	# tid, %sfp
	movl	%eax, -240(%rbp)	# _245, %sfp
	movl	%r8d, -244(%rbp)	# _592, %sfp
	jmp	.L1326	#
	.p2align 4
	.p2align 3
.L1327:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rdx	#, _764
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r15,%rax,8), %rax	# MTgen._M_x[prephitmp_1272], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp2213
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, %fs:4992(%r15)	# _764, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp1331
	shrq	$11, %rcx	#, tmp1331
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp1331, _768
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _768, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp1332
	salq	$7, %rcx	#, tmp1332
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _771
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _771, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp1333
	salq	$15, %rcx	#, tmp1333
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _774
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _774, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _776
	shrq	$18, %rcx	#, _776
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _776, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm7, %xmm1	# __z, tmp2213, tmp1896
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp2214
	vaddsd	%xmm7, %xmm1, %xmm1	# tmp2214, tmp1335, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _764
	ja	.L1494	#,
.L1328:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rax	#, tmp1341
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp2220
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:(%rbx), %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _248
# C/parallel-only-omp/simulation.h:712:             int energy_index = min(int(v_sqr * FACTOR_ENERGY_E + 0.5), CS_RANGES - 1);
	vmovsd	.LC45(%rip), %xmm5	#, tmp2230
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, %fs:4992(%r15)	# tmp1341, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r15,%rdx,8), %rax	# MTgen._M_x[prephitmp_1275], __z
# C/parallel-only-omp/simulation.h:708:             if (ki >= k_end) ki = k_end - 1;
	movl	-228(%rbp), %esi	# %sfp, _26
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp1343
	shrq	$11, %rdx	#, tmp1343
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp1343, _797
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _797, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp1344
	salq	$7, %rdx	#, tmp1344
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _800
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _800, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp1345
	salq	$15, %rdx	#, tmp1345
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _803
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _803, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _805
	shrq	$18, %rdx	#, _805
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _805, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm7, %xmm0	# __z, tmp2220, tmp1897
# C/parallel-only-omp/simulation.h:707:             int ki = k_start + (int)(R01(MTgen) * N_local);
	movl	-244(%rbp), %eax	# %sfp, _592
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC10(%rip), %xmm7	#, tmp2221
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm7, %xmm1	#, __ret, tmp2221, tmp1815
	vmovsd	.LC173(%rip), %xmm7	#, tmp2222
	vblendvpd	%xmm1, %xmm7, %xmm0, %xmm0	# tmp1815, tmp2222, __ret, __ret
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%rbx), %xmm1	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm1, %xmm1	# _248, MEM[(const struct param_type *)&R01]._M_b, tmp1353
# C/parallel-only-omp/simulation.h:716:             if (p_accept > 1.0) p_accept = 1.0;
	vmovsd	.LC10(%rip), %xmm7	#, tmp2232
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm1, %xmm2, %xmm0	# tmp1353, _248, _251
# C/parallel-only-omp/simulation.h:707:             int ki = k_start + (int)(R01(MTgen) * N_local);
	vmulsd	-224(%rbp), %xmm0, %xmm0	# %sfp, _251, tmp1356
# C/parallel-only-omp/simulation.h:707:             int ki = k_start + (int)(R01(MTgen) * N_local);
	vcvttsd2sil	%xmm0, %edx	# tmp1356, tmp1357
# C/parallel-only-omp/simulation.h:707:             int ki = k_start + (int)(R01(MTgen) * N_local);
	addl	%eax, %edx	# _592, ki
# C/parallel-only-omp/simulation.h:708:             if (ki >= k_end) ki = k_end - 1;
	leal	-1(%rsi), %eax	#, tmp1822
	cmpl	%edx, %esi	# ki, _26
# C/parallel-only-omp/simulation.h:714:             double real_nu  = sigma_tot_e[energy_index] * velocity;
	leaq	sigma_tot_e(%rip), %rsi	#, tmp2231
# C/parallel-only-omp/simulation.h:708:             if (ki >= k_end) ki = k_end - 1;
	cmovle	%eax, %edx	# tmp1822,, ki
# C/parallel-only-omp/simulation.h:710:             double v_sqr     = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	leaq	vx_e(%rip), %rax	#, tmp2227
	movslq	%edx, %r12	# ki, ki
	vmovsd	(%rax,%r12,8), %xmm0	# vx_e[ki_257], _258
# C/parallel-only-omp/simulation.h:710:             double v_sqr     = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	leaq	vy_e(%rip), %rax	#, tmp2228
	vmovsd	(%rax,%r12,8), %xmm1	# vy_e[ki_257], _260
# C/parallel-only-omp/simulation.h:710:             double v_sqr     = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vmulsd	%xmm1, %xmm1, %xmm1	# _260, _260, tmp1362
# C/parallel-only-omp/simulation.h:710:             double v_sqr     = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vfmadd231sd	%xmm0, %xmm0, %xmm1	# _258, _258, _262
# C/parallel-only-omp/simulation.h:710:             double v_sqr     = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	leaq	vz_e(%rip), %rax	#, tmp2229
	vmovsd	(%rax,%r12,8), %xmm0	# vz_e[ki_257], _263
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	movl	$999999, %eax	#, tmp1908
# C/parallel-only-omp/simulation.h:710:             double v_sqr     = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# _263, _262, v_sqr
# C/parallel-only-omp/simulation.h:711:             double velocity  = sqrt(v_sqr);
	vsqrtsd	%xmm0, %xmm0, %xmm1	# v_sqr, velocity
# C/parallel-only-omp/simulation.h:712:             int energy_index = min(int(v_sqr * FACTOR_ENERGY_E + 0.5), CS_RANGES - 1);
	vfmadd132sd	.LC203(%rip), %xmm5, %xmm0	#, tmp2230, _268
# C/parallel-only-omp/simulation.h:712:             int energy_index = min(int(v_sqr * FACTOR_ENERGY_E + 0.5), CS_RANGES - 1);
	vcvttsd2sil	%xmm0, %r14d	# _268, _431
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%eax, %r14d	# tmp1908, _431
	cmovg	%eax, %r14d	# _431,, tmp1908, _431
# C/parallel-only-omp/simulation.h:714:             double real_nu  = sigma_tot_e[energy_index] * velocity;
	movslq	%r14d, %rax	# _431, _431
# C/parallel-only-omp/simulation.h:714:             double real_nu  = sigma_tot_e[energy_index] * velocity;
	vmulsd	(%rsi,%rax,8), %xmm1, %xmm1	# sigma_tot_e[_431], velocity, real_nu
# C/parallel-only-omp/simulation.h:715:             double p_accept = real_nu / nu_star_e;
	vdivsd	nu_star_e(%rip), %xmm1, %xmm1	# nu_star_e, real_nu, p_accept
# C/parallel-only-omp/simulation.h:716:             if (p_accept > 1.0) p_accept = 1.0;
	vminsd	%xmm1, %xmm7, %xmm1	# p_accept, tmp2232, p_accept
	vmovsd	%xmm1, -216(%rbp)	# p_accept, %sfp
# C/parallel-only-omp/simulation.h:719:             if (R01(MTgen) < p_accept) {
	call	_ZTH3R01	#
# C/parallel-only-omp/simulation.h:719:             if (R01(MTgen) < p_accept) {
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992(%r15), %rax	# MTgen._M_p, _198
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	vmovsd	-216(%rbp), %xmm1	# %sfp, p_accept
	cmpq	$623, %rax	#, _198
	ja	.L1495	#,
.L1332:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rsi	#, _121
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r15,%rax,8), %rax	# MTgen._M_x[prephitmp_1305], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp2238
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp2239
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rsi, %fs:4992(%r15)	# _121, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdi	# __z, tmp1377
	shrq	$11, %rdi	#, tmp1377
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edi, %edi	# tmp1377, _393
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdi, %rax	# _393, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdi	# __z, tmp1378
	salq	$7, %rdi	#, tmp1378
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edi	#, _684
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdi, %rax	# _684, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdi	# __z, tmp1379
	salq	$15, %rdi	#, tmp1379
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edi	#, _474
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdi, %rax	# _474, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdi	# __z, _276
	shrq	$18, %rdi	#, _276
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdi, %rax	# _276, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm2	# __z, tmp2238, tmp1898
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm5, %xmm2, %xmm2	# tmp2239, tmp1381, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rsi	#, _121
	ja	.L1496	#,
.L1333:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rsi), %rax	#, tmp1387
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp2245
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC173(%rip), %xmm5	#, tmp2247
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:(%rbx), %xmm4	# MEM[(const struct param_type *)&R01]._M_a, _278
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, %fs:4992(%r15)	# tmp1387, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r15,%rsi,8), %rax	# MTgen._M_x[prephitmp_1308], __z
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rsi	# __z, tmp1389
	shrq	$11, %rsi	#, tmp1389
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%esi, %esi	# tmp1389, _739
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rsi, %rax	# _739, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rsi	# __z, tmp1390
	salq	$7, %rsi	#, tmp1390
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %esi	#, _742
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rsi, %rax	# _742, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rsi	# __z, tmp1391
	salq	$15, %rsi	#, tmp1391
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %esi	#, _745
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rsi, %rax	# _745, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rsi	# __z, _747
	shrq	$18, %rsi	#, _747
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rsi, %rax	# _747, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm7, %xmm0	# __z, tmp2245, tmp1899
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC10(%rip), %xmm7	#, tmp2246
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC168(%rip), %xmm2, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC169(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm7, %xmm2	#, __ret, tmp2246, tmp1818
	vblendvpd	%xmm2, %xmm5, %xmm0, %xmm0	# tmp1818, tmp2247, __ret, __ret
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%rbx), %xmm2	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm4, %xmm2, %xmm2	# _278, MEM[(const struct param_type *)&R01]._M_b, tmp1399
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm2, %xmm4, %xmm0	# tmp1399, _278, _281
# C/parallel-only-omp/simulation.h:719:             if (R01(MTgen) < p_accept) {
	vcomisd	%xmm0, %xmm1	# _281, p_accept
	ja	.L1497	#,
# C/parallel-only-omp/simulation.h:706:         for (int i = 0; i < local_N_coll; ++i) {
	incl	%r13d	# i
# C/parallel-only-omp/simulation.h:706:         for (int i = 0; i < local_N_coll; ++i) {
	cmpl	%r13d, -240(%rbp)	# i, %sfp
	je	.L1498	#,
.L1326:
# C/parallel-only-omp/simulation.h:707:             int ki = k_start + (int)(R01(MTgen) * N_local);
	call	_ZTH3R01	#
# C/parallel-only-omp/simulation.h:707:             int ki = k_start + (int)(R01(MTgen) * N_local);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992(%r15), %rax	# MTgen._M_p, _760
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, _760
	jbe	.L1327	#,
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp2208
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp1326
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r15), %rax	# MTgen._M_p, _760
	jmp	.L1327	#
.L1497:
# C/parallel-only-omp/simulation.h:720:                 collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index,
	movq	-360(%rbp), %r8	# %sfp, _228
	movq	360+worker_buffers(%rip), %r9	# MEM[(struct vector *)&worker_buffers + 360B].D.109241._M_impl.D.108580._M_start, tmp2252
	leaq	0(,%r12,8), %rax	#, _28
	leaq	vz_e(%rip), %rsi	#, tmp2248
	leaq	(%rsi,%rax), %r10	#, tmp1408
	leaq	vx_e(%rip), %rdi	#, tmp2250
	leaq	vy_e(%rip), %rsi	#, tmp2249
	addq	%rax, %rdi	# _28, tmp1412
	movl	%r14d, %ecx	# _431,
	movq	%r10, %rdx	# tmp1408,
	addq	%rax, %rsi	# _28, tmp1410
	leaq	x_e(%rip), %rax	#, tmp2251
# C/parallel-only-omp/simulation.h:706:         for (int i = 0; i < local_N_coll; ++i) {
	incl	%r13d	# i
# C/parallel-only-omp/simulation.h:720:                 collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index,
	vmovsd	(%rax,%r12,8), %xmm0	# x_e[ki_257], x_e[ki_257]
	addq	%r8, %r9	# _228, tmp2252
	addq	336+worker_buffers(%rip), %r8	# MEM[(struct vector *)&worker_buffers + 336B].D.109241._M_impl.D.108580._M_start, tmp2253
	call	_Z18collision_electrondPdS_S_iR12NewParticlesS1_	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	-336(%rbp), %rax	# %sfp, _293
	addq	168+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, _293
# C/parallel-only-omp/simulation.h:722:                 worker_buffers.thread_counters[tid].local_coll_e++;
	incq	32(%rax)	# _293->local_coll_e
# C/parallel-only-omp/simulation.h:706:         for (int i = 0; i < local_N_coll; ++i) {
	cmpl	%r13d, -240(%rbp)	# i, %sfp
	jne	.L1326	#,
.L1498:
	movl	-304(%rbp), %r12d	# %sfp, tid
	movl	-260(%rbp), %ebx	# %sfp, nthreads
	jmp	.L1325	#
.L1496:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp2240
	vmovsd	%xmm2, -256(%rbp)	# __sum, %sfp
	vmovsd	%xmm1, -216(%rbp)	# p_accept, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp1383
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r15), %rsi	# MTgen._M_p, _121
	vmovsd	-256(%rbp), %xmm2	# %sfp, __sum
	vmovsd	-216(%rbp), %xmm1	# %sfp, p_accept
	jmp	.L1333	#
.L1495:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp2233
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp1372
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r15), %rax	# MTgen._M_p, _198
	vmovsd	-216(%rbp), %xmm1	# %sfp, p_accept
	jmp	.L1332	#
.L1494:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp2215
	vmovsd	%xmm1, -216(%rbp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp1337
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r15), %rdx	# MTgen._M_p, _764
	vmovsd	-216(%rbp), %xmm1	# %sfp, __sum
	jmp	.L1328	#
.L1486:
	incl	%r14d	# q.52_159
# C/parallel-only-omp/simulation.h:70:     #pragma omp barrier
	xorl	%edx, %edx	# tt.53_160
	jmp	.L1268	#
.L1380:
# C/parallel-only-omp/simulation.h:145:             double sum = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# sum
	jmp	.L1288	#
.L1361:
	call	GOMP_single_start@PLT	#
	testb	%al, %al	# tmp1890
	je	.L1371	#,
# C/parallel-only-omp/simulation.h:850:     if (!measurement_mode) return;
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	je	.L1370	#,
	movslq	-352(%rbp), %rax	# %sfp, t_index
	leaq	efield_xt(%rip), %rcx	#, tmp1601
	leaq	pot_xt(%rip), %r9	#, tmp1598
	leaq	ni_xt(%rip), %rdi	#, tmp1599
	leaq	ne_xt(%rip), %rdx	#, tmp1600
	xorl	%r10d, %r10d	# ivtmp.2675
	leaq	e_density(%rip), %rsi	#, tmp1803
	leaq	pot(%rip), %r8	#, ivtmp.2830
	leaq	efield(%rip), %r11	#, tmp1809
	salq	$3, %rax	#, _578
	addq	%rax, %r9	# _578, ivtmp.2668
	addq	%rax, %rdi	# _578, ivtmp.2673
	addq	%rax, %rdx	# _578, ivtmp.2678
	addq	%rcx, %rax	# tmp1601, ivtmp.2682
	leaq	i_density(%rip), %rcx	#, tmp1784
.L1369:
# C/parallel-only-omp/simulation.h:853:         pot_xt   [p][t_index] += pot[p];
	vmovsd	3200(%r9), %xmm0	# MEM[(double *)_313 + 3200B], MEM[(double *)_313 + 3200B]
	vmovhpd	4800(%r9), %xmm0, %xmm1	# MEM[(double *)_313 + 4800B], MEM[(double *)_313 + 3200B], tmp1603
	vmovsd	(%r9), %xmm0	# MEM[(double *)_313], MEM[(double *)_313]
	vmovhpd	1600(%r9), %xmm0, %xmm0	# MEM[(double *)_313 + 1600B], MEM[(double *)_313], tmp1606
	vinsertf128	$0x1, %xmm1, %ymm0, %ymm0	# tmp1603, tmp1606, tmp1602
# C/parallel-only-omp/simulation.h:853:         pot_xt   [p][t_index] += pot[p];
	vaddpd	(%r8,%r10), %ymm0, %ymm0	# MEM <vector(4) double> [(double *)&pot + ivtmp.2675_1744 * 1], tmp1602, vect__498.2400
	addq	$6400, %r9	#, ivtmp.2668
	addq	$6400, %rdi	#, ivtmp.2673
	addq	$6400, %rdx	#, ivtmp.2678
	addq	$6400, %rax	#, ivtmp.2682
	vmovlpd	%xmm0, -6400(%r9)	# tmp1611, MEM[(double *)_313]
	vmovhpd	%xmm0, -4800(%r9)	# tmp1611, MEM[(double *)_313 + 1600B]
	vextractf64x2	$1, %ymm0, %xmm1	#, vect__498.2400, tmp1614
	valignq	$3, %ymm0, %ymm0, %ymm0	#, vect__498.2400, tmp1616
	vmovsd	%xmm1, -3200(%r9)	# tmp1614, MEM[(double *)_313 + 3200B]
	vmovsd	%xmm0, -1600(%r9)	# tmp1616, MEM[(double *)_313 + 4800B]
# C/parallel-only-omp/simulation.h:854:         efield_xt[p][t_index] += efield[p];
	vmovsd	-3200(%rax), %xmm0	# MEM[(double *)_544 + 3200B], MEM[(double *)_544 + 3200B]
	vmovhpd	-1600(%rax), %xmm0, %xmm1	# MEM[(double *)_544 + 4800B], MEM[(double *)_544 + 3200B], tmp1619
	vmovsd	-6400(%rax), %xmm0	# MEM[(double *)_544], MEM[(double *)_544]
	vmovhpd	-4800(%rax), %xmm0, %xmm0	# MEM[(double *)_544 + 1600B], MEM[(double *)_544], tmp1622
	vinsertf128	$0x1, %xmm1, %ymm0, %ymm0	# tmp1619, tmp1622, tmp1618
# C/parallel-only-omp/simulation.h:854:         efield_xt[p][t_index] += efield[p];
	vaddpd	(%r11,%r10), %ymm0, %ymm0	# MEM <vector(4) double> [(double *)&efield + ivtmp.2675_1744 * 1], tmp1618, vect__501.2404
	vmovlpd	%xmm0, -6400(%rax)	# tmp1627, MEM[(double *)_544]
	vmovhpd	%xmm0, -4800(%rax)	# tmp1627, MEM[(double *)_544 + 1600B]
	vextractf64x2	$1, %ymm0, %xmm1	#, vect__501.2404, tmp1630
	valignq	$3, %ymm0, %ymm0, %ymm0	#, vect__501.2404, tmp1632
	vmovsd	%xmm1, -3200(%rax)	# tmp1630, MEM[(double *)_544 + 3200B]
	vmovsd	%xmm0, -1600(%rax)	# tmp1632, MEM[(double *)_544 + 4800B]
# C/parallel-only-omp/simulation.h:855:         ne_xt    [p][t_index] += e_density[p];
	vmovsd	-3200(%rdx), %xmm0	# MEM[(double *)_1571 + 3200B], MEM[(double *)_1571 + 3200B]
	vmovhpd	-1600(%rdx), %xmm0, %xmm1	# MEM[(double *)_1571 + 4800B], MEM[(double *)_1571 + 3200B], tmp1635
	vmovsd	-6400(%rdx), %xmm0	# MEM[(double *)_1571], MEM[(double *)_1571]
	vmovhpd	-4800(%rdx), %xmm0, %xmm0	# MEM[(double *)_1571 + 1600B], MEM[(double *)_1571], tmp1638
	vinsertf128	$0x1, %xmm1, %ymm0, %ymm0	# tmp1635, tmp1638, tmp1634
# C/parallel-only-omp/simulation.h:855:         ne_xt    [p][t_index] += e_density[p];
	vaddpd	(%rsi,%r10), %ymm0, %ymm0	# MEM <vector(4) double> [(double *)&e_density + ivtmp.2675_1744 * 1], tmp1634, vect__504.2408
	vmovlpd	%xmm0, -6400(%rdx)	# tmp1643, MEM[(double *)_1571]
	vmovhpd	%xmm0, -4800(%rdx)	# tmp1643, MEM[(double *)_1571 + 1600B]
	vextractf64x2	$1, %ymm0, %xmm1	#, vect__504.2408, tmp1646
	valignq	$3, %ymm0, %ymm0, %ymm0	#, vect__504.2408, tmp1648
	vmovsd	%xmm1, -3200(%rdx)	# tmp1646, MEM[(double *)_1571 + 3200B]
	vmovsd	%xmm0, -1600(%rdx)	# tmp1648, MEM[(double *)_1571 + 4800B]
# C/parallel-only-omp/simulation.h:856:         ni_xt    [p][t_index] += i_density[p];
	vmovsd	-3200(%rdi), %xmm0	# MEM[(double *)_516 + 3200B], MEM[(double *)_516 + 3200B]
	vmovhpd	-1600(%rdi), %xmm0, %xmm1	# MEM[(double *)_516 + 4800B], MEM[(double *)_516 + 3200B], tmp1651
	vmovsd	-6400(%rdi), %xmm0	# MEM[(double *)_516], MEM[(double *)_516]
	vmovhpd	-4800(%rdi), %xmm0, %xmm0	# MEM[(double *)_516 + 1600B], MEM[(double *)_516], tmp1654
	vinsertf128	$0x1, %xmm1, %ymm0, %ymm0	# tmp1651, tmp1654, tmp1650
# C/parallel-only-omp/simulation.h:856:         ni_xt    [p][t_index] += i_density[p];
	vaddpd	(%rcx,%r10), %ymm0, %ymm0	# MEM <vector(4) double> [(double *)&i_density + ivtmp.2675_1744 * 1], tmp1650, vect__507.2412
	addq	$32, %r10	#, ivtmp.2675
	vmovlpd	%xmm0, -6400(%rdi)	# tmp1659, MEM[(double *)_516]
	vextractf64x2	$1, %ymm0, %xmm1	#, vect__507.2412, tmp1662
	vmovhpd	%xmm0, -4800(%rdi)	# tmp1659, MEM[(double *)_516 + 1600B]
	valignq	$3, %ymm0, %ymm0, %ymm0	#, vect__507.2412, tmp1664
	vmovsd	%xmm1, -3200(%rdi)	# tmp1662, MEM[(double *)_516 + 3200B]
	vmovsd	%xmm0, -1600(%rdi)	# tmp1664, MEM[(double *)_516 + 4800B]
	cmpq	$3200, %r10	#, ivtmp.2675
	jne	.L1369	#,
	vzeroupper
.L1370:
	imull	$652835029, -232(%rbp), %eax	#, %sfp, tmp1595
	rorx	$3, %eax, %eax	#, tmp1595, tmp1596
# C/parallel-only-omp/simulation.h:914:                     if ((t % 1000) == 0) {
	cmpl	$4294967, %eax	#, tmp1596
	jbe	.L1499	#,
.L1371:
	call	GOMP_barrier@PLT	#
	jmp	.L1365	#
.L1390:
# C/parallel-only-omp/simulation.h:741:             for (size_t i = 0; i < worker_buffers.new_ions[t].size(); ++i) {
	movl	-224(%rbp), %r10d	# %sfp, tmp.2417
	movq	%rsi, %r11	# _634, niters.2438
# C/parallel-only-omp/simulation.h:741:             for (size_t i = 0; i < worker_buffers.new_ions[t].size(); ++i) {
	xorl	%r8d, %r8d	# niters_vector_mult_vf.2415
	jmp	.L1352	#
.L1389:
# C/parallel-only-omp/simulation.h:734:             for (size_t i = 0; i < worker_buffers.new_electrons[t].size(); ++i) {
	movl	-228(%rbp), %r10d	# %sfp, tmp.2492
	movq	%rsi, %r11	# _330, niters.2488
# C/parallel-only-omp/simulation.h:734:             for (size_t i = 0; i < worker_buffers.new_electrons[t].size(); ++i) {
	xorl	%r8d, %r8d	# tmp.2491
	jmp	.L1343	#
.L1482:
	vzeroupper
	jmp	.L1291	#
.L1311:
# /usr/include/c++/13/bits/stl_vector.h:1292: 	  _M_realloc_insert(end(), __x);
	leaq	-208(%rbp), %rdx	#, tmp1176
	movl	%eax, -216(%rbp)	# nthreads, %sfp
	call	_ZNSt6vectorIiSaIiEE17_M_realloc_insertIJRKiEEEvN9__gnu_cxx17__normal_iteratorIPiS1_EEDpOT_	#
	movq	168+worker_buffers(%rip), %rcx	# MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start
	movl	-216(%rbp), %eax	# %sfp, nthreads
	vmovsd	.LC81(%rip), %xmm2	#, tmp1857
	jmp	.L1312	#
.L1493:
	incl	%eax	# q.59_107
# C/parallel-only-omp/simulation.h:124:     if ((t % N_SUB) == 0) {
	xorl	%edx, %edx	# tt.60_108
	jmp	.L1294	#
.L1307:
# /usr/include/c++/13/bits/stl_vector.h:1292: 	  _M_realloc_insert(end(), __x);
	leaq	-208(%rbp), %rdx	#, tmp1169
	movl	%eax, -216(%rbp)	# nthreads, %sfp
	call	_ZNSt6vectorIiSaIiEE17_M_realloc_insertIJRKiEEEvN9__gnu_cxx17__normal_iteratorIPiS1_EEDpOT_	#
	movq	168+worker_buffers(%rip), %rcx	# MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start
	movl	-216(%rbp), %eax	# %sfp, nthreads
	vmovsd	.LC81(%rip), %xmm2	#, tmp1857
	jmp	.L1308	#
.L1483:
	vzeroupper
	jmp	.L1339	#
.L1379:
# C/parallel-only-omp/simulation.h:85:         for (int t = 0; t < num_threads; t++) {
	vxorpd	%xmm0, %xmm0, %xmm0	# _1201
	vmovsd	%xmm0, %xmm0, %xmm1	#, _1199
	jmp	.L1278	#
.L1383:
# C/parallel-only-omp/simulation.h:536:         int total_abs = 0;
	xorl	%esi, %esi	# stmp_total_abs_387.2546
# C/parallel-only-omp/simulation.h:537:         for (int t = 0; t < num_threads; t++) {
	xorl	%ecx, %ecx	# t
	jmp	.L1316	#
.L1381:
# C/parallel-only-omp/simulation.h:155:             for (int t2 = 0; t2 < num_threads; t2++) {
	vxorpd	%xmm0, %xmm0, %xmm0	# _1226
	vmovsd	%xmm0, %xmm0, %xmm1	#, _1224
	jmp	.L1292	#
.L1499:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	N_i(%rip), %r9d	# N_i,
	movl	N_e(%rip), %r8d	# N_e,
	movl	-232(%rbp), %ecx	# %sfp,
	leaq	.LC204(%rip), %rsi	#, tmp1669
	movl	cycle(%rip), %edx	# cycle,
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	jmp	.L1371	#
.L1382:
# C/parallel-only-omp/simulation.h:124:     if ((t % N_SUB) == 0) {
	xorl	%esi, %esi	#
	leaq	i_density(%rip), %rcx	#, tmp1784
	leaq	cumul_i_density(%rip), %rdi	#, tmp1808
	jmp	.L1295	#
.L1491:
# C/parallel-only-omp/simulation.h:878:     #pragma omp parallel
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE11230:
	.section	.gcc_except_table._Z12do_one_cyclev._omp_fn.0,"a",@progbits
.LLSDA11230:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE11230-.LLSDACSB11230
.LLSDACSB11230:
.LLSDACSE11230:
	.section	.text._Z12do_one_cyclev._omp_fn.0
	.size	_Z12do_one_cyclev._omp_fn.0, .-_Z12do_one_cyclev._omp_fn.0
	.section	.text.startup._GLOBAL__sub_I_main,"ax",@progbits
	.p2align 4
	.type	_GLOBAL__sub_I_main, @function
_GLOBAL__sub_I_main:
.LFB11229:
	.cfi_startproc
	endbr64	
# C/parallel-only-omp/state.h:257: inline WorkerBuffers worker_buffers;
	cmpb	$0, _ZGV14worker_buffers(%rip)	#, MEM[(char *)&_ZGV14worker_buffers]
	je	.L1503	#,
# C/parallel-only-omp/eduPIC.cc:97: }
	ret	
.L1503:
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	vpxor	%xmm0, %xmm0, %xmm0	# tmp86
# C/parallel-only-omp/state.h:257: inline WorkerBuffers worker_buffers;
	leaq	__dso_handle(%rip), %rdx	#, tmp97
	leaq	worker_buffers(%rip), %rsi	#, tmp85
	leaq	_ZN13WorkerBuffersD1Ev(%rip), %rdi	#, tmp99
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	vmovdqu64	%zmm0, worker_buffers(%rip)	# tmp86, MEM <vector(8) long unsigned int> [(void *)&worker_buffers]
# C/parallel-only-omp/state.h:257: inline WorkerBuffers worker_buffers;
	movb	$1, _ZGV14worker_buffers(%rip)	#, MEM[(char *)&_ZGV14worker_buffers]
# /usr/include/c++/13/bits/stl_vector.h:100: 	: _M_start(), _M_finish(), _M_end_of_storage()
	vmovdqu64	%zmm0, 64+worker_buffers(%rip)	# tmp86, MEM <vector(8) long unsigned int> [(void *)&worker_buffers + 64B]
	vmovdqu64	%zmm0, 128+worker_buffers(%rip)	# tmp86, MEM <vector(8) long unsigned int> [(void *)&worker_buffers + 128B]
	vmovdqu64	%zmm0, 192+worker_buffers(%rip)	# tmp86, MEM <vector(8) long unsigned int> [(void *)&worker_buffers + 192B]
	vmovdqu64	%zmm0, 256+worker_buffers(%rip)	# tmp86, MEM <vector(8) long unsigned int> [(void *)&worker_buffers + 256B]
	vmovdqu64	%zmm0, 320+worker_buffers(%rip)	# tmp86, MEM <vector(8) long unsigned int> [(void *)&worker_buffers + 320B]
# C/parallel-only-omp/state.h:257: inline WorkerBuffers worker_buffers;
	vzeroupper
	jmp	__cxa_atexit@PLT	#
	.cfi_endproc
.LFE11229:
	.size	_GLOBAL__sub_I_main, .-_GLOBAL__sub_I_main
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I_main
	.weak	_ZGV3RMB
	.section	.tbss._ZGV3RMB,"awTG",@nobits,_ZGV3RMB,comdat
	.align 8
	.type	_ZGV3RMB, @gnu_unique_object
	.size	_ZGV3RMB, 8
_ZGV3RMB:
	.zero	8
	.weak	_ZGV3R01
	.section	.tbss._ZGV3R01,"awTG",@nobits,_ZGV3R01,comdat
	.align 8
	.type	_ZGV3R01, @gnu_unique_object
	.size	_ZGV3R01, 8
_ZGV3R01:
	.zero	8
	.weak	_ZGV5MTgen
	.section	.tbss._ZGV5MTgen,"awTG",@nobits,_ZGV5MTgen,comdat
	.align 8
	.type	_ZGV5MTgen, @gnu_unique_object
	.size	_ZGV5MTgen, 8
_ZGV5MTgen:
	.zero	8
	.weak	_ZGV2rd
	.section	.tbss._ZGV2rd,"awTG",@nobits,_ZGV2rd,comdat
	.align 8
	.type	_ZGV2rd, @gnu_unique_object
	.size	_ZGV2rd, 8
_ZGV2rd:
	.zero	8
	.section	.tbss,"awT",@nobits
	.type	__tls_guard, @object
	.size	__tls_guard, 1
__tls_guard:
	.zero	1
	.weak	_ZGV14worker_buffers
	.section	.bss._ZGV14worker_buffers,"awG",@nobits,_ZGV14worker_buffers,comdat
	.align 8
	.type	_ZGV14worker_buffers, @gnu_unique_object
	.size	_ZGV14worker_buffers, 8
_ZGV14worker_buffers:
	.zero	8
	.weak	f_poisson
	.section	.bss.f_poisson,"awG",@nobits,f_poisson,comdat
	.align 64
	.type	f_poisson, @gnu_unique_object
	.size	f_poisson, 3328
f_poisson:
	.zero	3328
	.weak	g_poisson
	.section	.bss.g_poisson,"awG",@nobits,g_poisson,comdat
	.align 64
	.type	g_poisson, @gnu_unique_object
	.size	g_poisson, 3328
g_poisson:
	.zero	3328
	.weak	inv_denom_thomas
	.section	.bss.inv_denom_thomas,"awG",@nobits,inv_denom_thomas,comdat
	.align 64
	.type	inv_denom_thomas, @gnu_unique_object
	.size	inv_denom_thomas, 3328
inv_denom_thomas:
	.zero	3328
	.weak	w_thomas
	.section	.bss.w_thomas,"awG",@nobits,w_thomas,comdat
	.align 64
	.type	w_thomas, @gnu_unique_object
	.size	w_thomas, 3328
w_thomas:
	.zero	3328
	.weak	RMB
	.section	.tbss.RMB,"awTG",@nobits,RMB,comdat
	.align 8
	.type	RMB, @gnu_unique_object
	.size	RMB, 32
RMB:
	.zero	32
	.weak	R01
	.section	.tbss.R01,"awTG",@nobits,R01,comdat
	.align 8
	.type	R01, @gnu_unique_object
	.size	R01, 16
R01:
	.zero	16
	.weak	MTgen
	.section	.tbss.MTgen,"awTG",@nobits,MTgen,comdat
	.align 8
	.type	MTgen, @gnu_unique_object
	.size	MTgen, 5000
MTgen:
	.zero	5000
	.weak	rd
	.section	.tbss.rd,"awTG",@nobits,rd,comdat
	.align 8
	.type	rd, @gnu_unique_object
	.size	rd, 5000
rd:
	.zero	5000
	.weak	worker_buffers
	.section	.bss.worker_buffers,"awG",@nobits,worker_buffers,comdat
	.align 32
	.type	worker_buffers, @gnu_unique_object
	.size	worker_buffers, 384
worker_buffers:
	.zero	384
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
	.align 64
	.type	cumul_i_density, @gnu_unique_object
	.size	cumul_i_density, 3328
cumul_i_density:
	.zero	3328
	.weak	cumul_e_density
	.section	.bss.cumul_e_density,"awG",@nobits,cumul_e_density,comdat
	.align 64
	.type	cumul_e_density, @gnu_unique_object
	.size	cumul_e_density, 3328
cumul_e_density:
	.zero	3328
	.weak	i_density
	.section	.bss.i_density,"awG",@nobits,i_density,comdat
	.align 64
	.type	i_density, @gnu_unique_object
	.size	i_density, 3328
i_density:
	.zero	3328
	.weak	e_density
	.section	.bss.e_density,"awG",@nobits,e_density,comdat
	.align 64
	.type	e_density, @gnu_unique_object
	.size	e_density, 3328
e_density:
	.zero	3328
	.weak	pot
	.section	.bss.pot,"awG",@nobits,pot,comdat
	.align 64
	.type	pot, @gnu_unique_object
	.size	pot, 3328
pot:
	.zero	3328
	.weak	efield
	.section	.bss.efield,"awG",@nobits,efield,comdat
	.align 64
	.type	efield, @gnu_unique_object
	.size	efield, 3328
efield:
	.zero	3328
	.weak	vz_i
	.section	.bss.vz_i,"awG",@nobits,vz_i,comdat
	.align 64
	.type	vz_i, @gnu_unique_object
	.size	vz_i, 8000000
vz_i:
	.zero	8000000
	.weak	vy_i
	.section	.bss.vy_i,"awG",@nobits,vy_i,comdat
	.align 64
	.type	vy_i, @gnu_unique_object
	.size	vy_i, 8000000
vy_i:
	.zero	8000000
	.weak	vx_i
	.section	.bss.vx_i,"awG",@nobits,vx_i,comdat
	.align 64
	.type	vx_i, @gnu_unique_object
	.size	vx_i, 8000000
vx_i:
	.zero	8000000
	.weak	x_i
	.section	.bss.x_i,"awG",@nobits,x_i,comdat
	.align 64
	.type	x_i, @gnu_unique_object
	.size	x_i, 8000000
x_i:
	.zero	8000000
	.weak	vz_e
	.section	.bss.vz_e,"awG",@nobits,vz_e,comdat
	.align 64
	.type	vz_e, @gnu_unique_object
	.size	vz_e, 8000000
vz_e:
	.zero	8000000
	.weak	vy_e
	.section	.bss.vy_e,"awG",@nobits,vy_e,comdat
	.align 64
	.type	vy_e, @gnu_unique_object
	.size	vy_e, 8000000
vy_e:
	.zero	8000000
	.weak	vx_e
	.section	.bss.vx_e,"awG",@nobits,vx_e,comdat
	.align 64
	.type	vx_e, @gnu_unique_object
	.size	vx_e, 8000000
vx_e:
	.zero	8000000
	.weak	x_e
	.section	.bss.x_e,"awG",@nobits,x_e,comdat
	.align 64
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
	.align 64
	.type	sigma_tot_i, @gnu_unique_object
	.size	sigma_tot_i, 8000000
sigma_tot_i:
	.zero	8000000
	.weak	sigma_tot_e
	.section	.bss.sigma_tot_e,"awG",@nobits,sigma_tot_e,comdat
	.align 64
	.type	sigma_tot_e, @gnu_unique_object
	.size	sigma_tot_e, 8000000
sigma_tot_e:
	.zero	8000000
	.weak	sigma
	.section	.bss.sigma,"awG",@nobits,sigma,comdat
	.align 64
	.type	sigma, @gnu_unique_object
	.size	sigma, 40000000
sigma:
	.zero	40000000
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	-1405695074
	.long	1072703736
	.align 8
.LC1:
	.long	-755914244
	.long	1062232653
	.align 8
.LC4:
	.long	1717986918
	.long	1074423398
	.align 8
.LC5:
	.long	0
	.long	1075314688
	.align 8
.LC6:
	.long	1717986918
	.long	1073112678
	.align 8
.LC7:
	.long	0
	.long	1076756480
	.align 8
.LC8:
	.long	858993459
	.long	1072902963
	.align 8
.LC9:
	.long	-1717986918
	.long	1072798105
	.align 8
.LC10:
	.long	0
	.long	1072693248
	.align 8
.LC11:
	.long	0
	.long	1074003968
	.align 8
.LC12:
	.long	0
	.long	1075183616
	.align 8
.LC13:
	.long	1717986918
	.long	1074816614
	.align 8
.LC14:
	.long	0
	.long	1078853632
	.align 8
.LC15:
	.long	0
	.long	1076101120
	.align 8
.LC16:
	.long	0
	.long	1074266112
	.align 8
.LC17:
	.long	0
	.long	1076363264
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC18:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC19:
	.long	-1717986918
	.long	1068079513
	.align 8
.LC20:
	.long	1202590843
	.long	1065646817
	.align 8
.LC21:
	.long	0
	.long	1076297728
	.align 8
.LC22:
	.long	1717986918
	.long	1074161254
	.align 8
.LC23:
	.long	0
	.long	1077346304
	.align 8
.LC24:
	.long	1717986918
	.long	1073636966
	.align 8
.LC25:
	.long	0
	.long	1079246848
	.align 8
.LC26:
	.long	-1340029796
	.long	1067542642
	.align 8
.LC27:
	.long	-549755814
	.long	1066896719
	.align 8
.LC28:
	.long	-1717986918
	.long	1076861337
	.align 8
.LC29:
	.long	210911779
	.long	1002937505
	.align 8
.LC30:
	.long	0
	.long	1079083008
	.section	.rodata.cst16
	.align 16
.LC31:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC32:
	.long	0
	.long	1075970048
	.align 8
.LC33:
	.long	-343597384
	.long	1068415057
	.align 8
.LC34:
	.long	0
	.long	1083068416
	.align 8
.LC35:
	.long	858993459
	.long	1071854387
	.align 8
.LC36:
	.long	-1717986918
	.long	1069128089
	.align 8
.LC37:
	.long	-755914244
	.long	1063281229
	.align 8
.LC39:
	.long	-1717986918
	.long	-1078355559
	.align 8
.LC40:
	.long	-343597384
	.long	1066317905
	.align 8
.LC41:
	.long	0
	.long	-1075838976
	.align 8
.LC42:
	.long	1337381548
	.long	1007518665
	.align 8
.LC43:
	.long	-70705663
	.long	1008083670
	.align 8
.LC44:
	.long	-1320458388
	.long	1010120376
	.align 8
.LC45:
	.long	0
	.long	1071644672
	.align 8
.LC47:
	.long	-192165988
	.long	1146883006
	.align 8
.LC50:
	.long	630504279
	.long	1007133914
	.align 8
.LC51:
	.long	-1008331679
	.long	967997916
	.align 8
.LC52:
	.long	1998452712
	.long	1035224431
	.align 8
.LC53:
	.long	-515044572
	.long	983861149
	.align 8
.LC54:
	.long	1424324066
	.long	1039750859
	.align 8
.LC57:
	.long	1998452712
	.long	-1112259217
	.align 8
.LC58:
	.long	1424324066
	.long	-1107732789
	.align 8
.LC59:
	.long	0
	.long	1087319040
	.align 8
.LC61:
	.long	-328822563
	.long	1074393336
	.align 8
.LC63:
	.long	-1008331679
	.long	966949340
	.align 8
.LC64:
	.long	1889785611
	.long	1065814589
	.align 8
.LC65:
	.long	-1030792150
	.long	1066150133
	.align 8
.LC67:
	.long	547230944
	.long	1062022858
	.align 8
.LC74:
	.long	0
	.long	1085227008
	.align 8
.LC75:
	.long	-251268040
	.long	1034123382
	.align 8
.LC76:
	.long	0
	.long	1097456920
	.align 8
.LC81:
	.long	-1717986918
	.long	1067030937
	.align 8
.LC87:
	.long	0
	.long	1081032704
	.align 8
.LC90:
	.long	0
	.long	1081466880
	.align 8
.LC92:
	.long	0
	.long	1089541888
	.align 8
.LC104:
	.long	-402585907
	.long	1058041040
	.align 8
.LC106:
	.long	-1717986918
	.long	1070176665
	.align 8
.LC112:
	.long	-1971075289
	.long	1077963452
	.align 8
.LC122:
	.long	0
	.long	1080623104
	.align 8
.LC123:
	.long	1424324067
	.long	1039750859
	.align 8
.LC124:
	.long	785383423
	.long	1118065246
	.set	.LC126,.LC31
	.align 8
.LC131:
	.long	-350469331
	.long	1058682594
	.align 8
.LC132:
	.long	-632077287
	.long	1047776206
	.align 8
.LC139:
	.long	0
	.long	1089701888
	.align 8
.LC148:
	.long	724393789
	.long	1049348355
	.section	.rodata
	.align 64
.LC149:
	.quad	0
	.quad	2
	.quad	4
	.quad	6
	.quad	8
	.quad	10
	.quad	12
	.quad	14
	.align 64
.LC150:
	.quad	1
	.quad	3
	.quad	5
	.quad	7
	.quad	9
	.quad	11
	.quad	13
	.quad	15
	.align 64
.LC151:
	.long	0
	.long	2
	.long	4
	.long	6
	.long	8
	.long	10
	.long	12
	.long	14
	.long	16
	.long	18
	.long	20
	.long	22
	.long	24
	.long	26
	.long	28
	.long	30
	.section	.rodata.cst8
	.align 8
.LC152:
	.long	0
	.long	-1074790400
	.align 8
.LC153:
	.long	0
	.long	1075838976
	.align 8
.LC154:
	.long	0
	.long	1077936128
	.align 8
.LC155:
	.long	379996434
	.long	1078972162
	.align 8
.LC156:
	.long	1413754136
	.long	1072243195
	.align 8
.LC157:
	.long	0
	.long	1074790400
	.align 8
.LC158:
	.long	536225542
	.long	1072958867
	.align 8
.LC167:
	.long	-2
	.long	1072693247
	.align 8
.LC168:
	.long	0
	.long	1106247680
	.align 8
.LC169:
	.long	0
	.long	1005584384
	.align 8
.LC170:
	.long	0
	.long	1073741824
	.align 8
.LC171:
	.long	0
	.long	-1073741824
	.align 8
.LC172:
	.long	-4
	.long	1072693247
	.align 8
.LC173:
	.long	-1
	.long	1072693247
	.align 8
.LC174:
	.long	0
	.long	1017118720
	.align 8
.LC175:
	.long	-2097152
	.long	1105199103
	.align 8
.LC176:
	.long	-2
	.long	1071644671
	.align 8
.LC177:
	.long	2066167802
	.long	1078091343
	.align 8
.LC178:
	.long	262559291
	.long	1081138792
	.align 8
.LC195:
	.long	-16936979
	.long	1055706213
	.align 8
.LC196:
	.long	1413754136
	.long	1075388923
	.align 8
.LC197:
	.long	-889002329
	.long	1010892412
	.align 8
.LC198:
	.long	-1413493651
	.long	1178318378
	.align 8
.LC199:
	.long	85752064
	.long	1011308849
	.align 8
.LC200:
	.long	-443332832
	.long	1133597403
	.align 8
.LC201:
	.long	865730819
	.long	1072693219
	.align 8
.LC202:
	.long	405425922
	.long	1058742861
	.align 8
.LC203:
	.long	-1760457317
	.long	1042836330
	.align 8
.LC205:
	.long	-485508795
	.long	1100238897
	.align 8
.LC207:
	.long	-751000001
	.long	-1131120195
	.align 8
.LC211:
	.long	0
	.long	1086270464
	.align 8
.LC214:
	.long	1235563633
	.long	1029960215
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
