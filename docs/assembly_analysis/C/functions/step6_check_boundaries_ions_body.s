# Function: step6_check_boundaries_ions_body(int, int, int)
# Mangled Symbol: _Z32step6_check_boundaries_ions_bodyiii
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._Z32step6_check_boundaries_ions_bodyiii,"axG",@progbits,_Z32step6_check_boundaries_ions_bodyiii,comdat
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
	