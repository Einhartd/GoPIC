# Function: WorkerBuffers::init_buffers(int) [clone ._omp_fn.0]
# Mangled Symbol: _ZN13WorkerBuffers12init_buffersEi._omp_fn.0
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._ZN13WorkerBuffers12init_buffersEi._omp_fn.0,"ax",@progbits
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
	