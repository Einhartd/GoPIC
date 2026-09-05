# Function: do_one_cycle()
# Mangled Symbol: _Z12do_one_cyclev
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._Z12do_one_cyclev,"axG",@progbits,_Z12do_one_cyclev,comdat
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
	