# Function: step7_collisions_electrons_body(int, int)
# Mangled Symbol: _Z31step7_collisions_electrons_bodyii
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._Z31step7_collisions_electrons_bodyii,"axG",@progbits,_Z31step7_collisions_electrons_bodyii,comdat
	.p2align 4
	.weak	_Z31step7_collisions_electrons_bodyii
	.type	_Z31step7_collisions_electrons_bodyii, @function
_Z31step7_collisions_electrons_bodyii:
.LFB9884:
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
	movslq	%edi, %rbx	# tmp512,
	subq	$232, %rsp	#,
	.cfi_def_cfa_offset 288
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	leaq	(%rbx,%rbx,2), %r9	#, tmp297
# C/parallel-only-omp/simulation.h:637: PIC_STEP void step7_collisions_electrons_body(int tid, int num_threads) {
	movq	%rbx, %r8	#,
	movl	%esi, 36(%rsp)	# tmp513, %sfp
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp533
	movq	%rax, 216(%rsp)	# tmp533, D.136070
	xorl	%eax, %eax	# tmp533
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	336+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 336B].D.109135._M_impl.D.108474._M_start, _103
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	salq	$5, %r9	#, tmp298
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	%r9, %rax	# tmp298, _103
# /usr/include/c++/13/bits/stl_vector.h:1606:       { _M_erase_at_end(this->_M_impl._M_start); }
	movq	(%rax), %rdx	# MEM[(struct vector *)_103].D.58646._M_impl.D.57959._M_start, _199
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	8(%rax), %rdx	# MEM[(struct vector *)_103].D.58646._M_impl.D.57959._M_finish, _199
	je	.L1468	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 8(%rax)	# _199, MEM[(struct vector *)_103].D.58646._M_impl.D.57959._M_finish
.L1468:
# /usr/include/c++/13/bits/stl_vector.h:1606:       { _M_erase_at_end(this->_M_impl._M_start); }
	movq	24(%rax), %rdx	# MEM[(struct vector *)_103 + 24B].D.58646._M_impl.D.57959._M_start, _201
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	32(%rax), %rdx	# MEM[(struct vector *)_103 + 24B].D.58646._M_impl.D.57959._M_finish, _201
	je	.L1469	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 32(%rax)	# _201, MEM[(struct vector *)_103 + 24B].D.58646._M_impl.D.57959._M_finish
.L1469:
# /usr/include/c++/13/bits/stl_vector.h:1606:       { _M_erase_at_end(this->_M_impl._M_start); }
	movq	48(%rax), %rdx	# MEM[(struct vector *)_103 + 48B].D.58646._M_impl.D.57959._M_start, _203
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	56(%rax), %rdx	# MEM[(struct vector *)_103 + 48B].D.58646._M_impl.D.57959._M_finish, _203
	je	.L1470	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 56(%rax)	# _203, MEM[(struct vector *)_103 + 48B].D.58646._M_impl.D.57959._M_finish
.L1470:
# /usr/include/c++/13/bits/stl_vector.h:1606:       { _M_erase_at_end(this->_M_impl._M_start); }
	movq	72(%rax), %rdx	# MEM[(struct vector *)_103 + 72B].D.58646._M_impl.D.57959._M_start, _205
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	80(%rax), %rdx	# MEM[(struct vector *)_103 + 72B].D.58646._M_impl.D.57959._M_finish, _205
	je	.L1471	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 80(%rax)	# _205, MEM[(struct vector *)_103 + 72B].D.58646._M_impl.D.57959._M_finish
.L1471:
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	360+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 360B].D.109135._M_impl.D.108474._M_start, _107
	addq	%r9, %rax	# tmp298, _107
# /usr/include/c++/13/bits/stl_vector.h:1606:       { _M_erase_at_end(this->_M_impl._M_start); }
	movq	(%rax), %rdx	# MEM[(struct vector *)_107].D.58646._M_impl.D.57959._M_start, _191
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	8(%rax), %rdx	# MEM[(struct vector *)_107].D.58646._M_impl.D.57959._M_finish, _191
	je	.L1472	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 8(%rax)	# _191, MEM[(struct vector *)_107].D.58646._M_impl.D.57959._M_finish
.L1472:
# /usr/include/c++/13/bits/stl_vector.h:1606:       { _M_erase_at_end(this->_M_impl._M_start); }
	movq	24(%rax), %rdx	# MEM[(struct vector *)_107 + 24B].D.58646._M_impl.D.57959._M_start, _193
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	32(%rax), %rdx	# MEM[(struct vector *)_107 + 24B].D.58646._M_impl.D.57959._M_finish, _193
	je	.L1473	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 32(%rax)	# _193, MEM[(struct vector *)_107 + 24B].D.58646._M_impl.D.57959._M_finish
.L1473:
# /usr/include/c++/13/bits/stl_vector.h:1606:       { _M_erase_at_end(this->_M_impl._M_start); }
	movq	48(%rax), %rdx	# MEM[(struct vector *)_107 + 48B].D.58646._M_impl.D.57959._M_start, _195
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	56(%rax), %rdx	# MEM[(struct vector *)_107 + 48B].D.58646._M_impl.D.57959._M_finish, _195
	je	.L1474	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 56(%rax)	# _195, MEM[(struct vector *)_107 + 48B].D.58646._M_impl.D.57959._M_finish
.L1474:
# /usr/include/c++/13/bits/stl_vector.h:1606:       { _M_erase_at_end(this->_M_impl._M_start); }
	movq	72(%rax), %rdx	# MEM[(struct vector *)_107 + 72B].D.58646._M_impl.D.57959._M_start, _197
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	80(%rax), %rdx	# MEM[(struct vector *)_107 + 72B].D.58646._M_impl.D.57959._M_finish, _197
	je	.L1475	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 80(%rax)	# _197, MEM[(struct vector *)_107 + 72B].D.58646._M_impl.D.57959._M_finish
.L1475:
# C/parallel-only-omp/simulation.h:643:     int chunk = (N_e + num_threads - 1) / num_threads;
	movl	N_e(%rip), %ecx	# N_e, N_e.138_3
# C/parallel-only-omp/simulation.h:643:     int chunk = (N_e + num_threads - 1) / num_threads;
	movl	36(%rsp), %edi	# %sfp, num_threads
	movq	%r9, 40(%rsp)	# tmp298, %sfp
	leal	-1(%rcx,%rdi), %eax	#, tmp304
# C/parallel-only-omp/simulation.h:643:     int chunk = (N_e + num_threads - 1) / num_threads;
	cltd
	idivl	%edi	# num_threads
# C/parallel-only-omp/simulation.h:644:     int k_start = std::min(tid * chunk, N_e);
	imull	%eax, %r8d	# tmp305, tmp307
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%ecx, %r8d	# N_e.138_3, tmp307
	cmovg	%ecx, %r8d	# tmp307,, N_e.138_3, _249
# C/parallel-only-omp/simulation.h:645:     int k_end = std::min(k_start + chunk, N_e);
	addl	%r8d, %eax	# _249, tmp308
# C/parallel-only-omp/simulation.h:646:     int N_local = k_end - k_start;
	movl	%r8d, (%rsp)	# _249, %sfp
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%ecx, %eax	# N_e.138_3, tmp308
	cmovle	%eax, %ecx	# tmp308,, _244
# C/parallel-only-omp/simulation.h:646:     int N_local = k_end - k_start;
	movl	%ecx, %r13d	# _244, N_local
	movl	%ecx, 16(%rsp)	# _244, %sfp
	subl	%r8d, %r13d	# _249, N_local
# C/parallel-only-omp/simulation.h:648:     if (N_local > 0) {
	testl	%r13d, %r13d	# N_local
	jg	.L1516	#,
.L1476:
# C/parallel-only-omp/simulation.h:677:     #pragma omp barrier
	call	GOMP_barrier@PLT	#
	call	GOMP_single_start@PLT	#
	movb	%al, 32(%rsp)	# _98, %sfp
	testb	%al, %al	# _98
	je	.L1491	#,
# C/parallel-only-omp/simulation.h:680:         for (int t = 0; t < num_threads; ++t) {
	movslq	36(%rsp), %rax	# %sfp,
	testl	%eax, %eax	# num_threads
	jle	.L1491	#,
	movq	168+worker_buffers(%rip), %r9	# MEM[(struct vector *)&worker_buffers + 168B].D.105978._M_impl.D.105317._M_start, ivtmp.2506
	movq	N_e_coll(%rip), %rbx	# N_e_coll, N_e_coll_lsm.2470
	movl	N_e(%rip), %r11d	# N_e, N_e_lsm.2468
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movb	$0, 36(%rsp)	#, %sfp
	movq	336+worker_buffers(%rip), %r8	# MEM[(struct vector *)&worker_buffers + 336B].D.109135._M_impl.D.108474._M_start, ivtmp.2507
	movq	360+worker_buffers(%rip), %rdi	# MEM[(struct vector *)&worker_buffers + 360B].D.109135._M_impl.D.108474._M_start, ivtmp.2509
	movb	$0, 40(%rsp)	#, %sfp
	salq	$6, %rax	#, tmp421
	addq	%r9, %rax	# ivtmp.2506, _512
	movq	%rbx, 8(%rsp)	# N_e_coll_lsm.2470, %sfp
	movl	N_i(%rip), %ebx	# N_i, N_i_lsm.2466
	movq	%rax, 16(%rsp)	# _512, %sfp
	leaq	x_e(%rip), %rax	#, tmp501
	vmovq	%rax, %xmm14	# tmp501, tmp501
	leaq	vx_e(%rip), %rax	#, tmp502
	vmovq	%rax, %xmm13	# tmp502, tmp502
	leaq	vy_e(%rip), %rax	#, tmp503
	vmovq	%rax, %xmm12	# tmp503, tmp503
	leaq	vz_e(%rip), %rax	#, tmp504
	vmovq	%rax, %xmm11	# tmp504, tmp504
	leaq	x_i(%rip), %rax	#, tmp507
	movl	%ebx, (%rsp)	# N_i_lsm.2466, %sfp
	vmovq	%rax, %xmm10	# tmp507, tmp507
	leaq	vx_i(%rip), %rax	#, tmp508
	vmovq	%rax, %xmm9	# tmp508, tmp508
	leaq	vy_i(%rip), %rax	#, tmp509
	vmovq	%rax, %xmm8	# tmp509, tmp509
	leaq	vz_i(%rip), %rax	#, tmp510
	vmovq	%rax, %xmm7	# tmp510, tmp510
	.p2align 4
	.p2align 3
.L1497:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	8(%r8), %r15	# MEM[(double * *)_505 + 8B], _211
# C/parallel-only-omp/simulation.h:681:             N_e_coll += worker_buffers.thread_counters[t].local_coll_e;
	movq	8(%rsp), %rax	# %sfp, N_e_coll_lsm.2470
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	(%r8), %rcx	# MEM[(double * *)_505], _209
# C/parallel-only-omp/simulation.h:681:             N_e_coll += worker_buffers.thread_counters[t].local_coll_e;
	addq	32(%r9), %rax	# MEM[(long long unsigned int *)_502 + 32B], N_e_coll_lsm.2470
# C/parallel-only-omp/simulation.h:682:             worker_buffers.thread_counters[t].local_coll_e = 0;
	movq	$0, 32(%r9)	#, MEM[(long long unsigned int *)_502 + 32B]
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%r15, %rdx	# _211, tmp425
	subq	%rcx, %rdx	# _209, tmp425
# C/parallel-only-omp/simulation.h:681:             N_e_coll += worker_buffers.thread_counters[t].local_coll_e;
	movq	%rax, 24(%rsp)	# tmp423, %sfp
	movq	%rax, 8(%rsp)	# tmp423, %sfp
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	sarq	$3, %rdx	#, tmp426
# C/parallel-only-omp/simulation.h:683:             for (size_t i = 0; i < worker_buffers.new_electrons[t].x.size(); ++i) {
	cmpq	%r15, %rcx	# _211, _209
	je	.L1493	#,
	movslq	%r11d, %r13	# N_e_lsm.2468, N_e_lsm.2468
	vmovq	%xmm14, %rax	# tmp501, tmp501
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	24(%r8), %r14	# MEM[(double * *)_505 + 24B], _145
	movq	48(%r8), %r12	# MEM[(double * *)_505 + 48B], _143
	movq	72(%r8), %rbp	# MEM[(double * *)_505 + 72B], _141
	salq	$3, %r13	#, _482
	leaq	0(%r13,%rax), %rbx	#, _483
	vmovq	%xmm13, %rax	# tmp502, tmp502
	leaq	0(%r13,%rax), %r10	#, _486
	vmovq	%xmm12, %rax	# tmp503, tmp503
	leaq	0(%r13,%rax), %rsi	#, _489
	vmovq	%xmm11, %rax	# tmp504, tmp504
	addq	%rax, %r13	# tmp504, _492
# C/parallel-only-omp/simulation.h:683:             for (size_t i = 0; i < worker_buffers.new_electrons[t].x.size(); ++i) {
	xorl	%eax, %eax	# i
	.p2align 4
	.p2align 3
.L1494:
# C/parallel-only-omp/simulation.h:684:                 x_e[N_e]    = worker_buffers.new_electrons[t].x[i];
	vmovsd	(%rcx,%rax,8), %xmm0	# MEM[(value_type &)_209 + i_259 * 8], _35
	vmovsd	%xmm0, (%rbx,%rax,8)	# _35, MEM[(double *)_483 + i_259 * 8]
# C/parallel-only-omp/simulation.h:685:                 vx_e[N_e]   = worker_buffers.new_electrons[t].vx[i];
	vmovsd	(%r14,%rax,8), %xmm0	# MEM[(value_type &)_145 + i_259 * 8], _36
	vmovsd	%xmm0, (%r10,%rax,8)	# _36, MEM[(double *)_486 + i_259 * 8]
# C/parallel-only-omp/simulation.h:686:                 vy_e[N_e]   = worker_buffers.new_electrons[t].vy[i];
	vmovsd	(%r12,%rax,8), %xmm0	# MEM[(value_type &)_143 + i_259 * 8], _37
	vmovsd	%xmm0, (%rsi,%rax,8)	# _37, MEM[(double *)_489 + i_259 * 8]
# C/parallel-only-omp/simulation.h:687:                 vz_e[N_e]   = worker_buffers.new_electrons[t].vz[i];
	vmovsd	0(%rbp,%rax,8), %xmm0	# MEM[(value_type &)_141 + i_259 * 8], _38
	vmovsd	%xmm0, 0(%r13,%rax,8)	# _38, MEM[(double *)_492 + i_259 * 8]
# C/parallel-only-omp/simulation.h:683:             for (size_t i = 0; i < worker_buffers.new_electrons[t].x.size(); ++i) {
	incq	%rax	# i
# C/parallel-only-omp/simulation.h:683:             for (size_t i = 0; i < worker_buffers.new_electrons[t].x.size(); ++i) {
	cmpq	%rdx, %rax	# tmp426, i
	jb	.L1494	#,
# C/parallel-only-omp/simulation.h:688:                 N_e++;
	xorl	%eax, %eax	# tmp653
	decq	%rdx	# tmp433
	cmpq	%r15, %rcx	# _211, _209
	cmove	%eax, %edx	# tmp433,, tmp653, tmp432
	movzbl	32(%rsp), %eax	# %sfp, _98
	leal	1(%r11,%rdx), %r11d	#, N_e_lsm.2468
	movb	%al, 36(%rsp)	# _98, %sfp
.L1493:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	8(%rdi), %r15	# MEM[(double * *)_514 + 8B], _71
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	(%rdi), %r13	# MEM[(double * *)_514], _114
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%r15, %rdx	# _71, tmp435
	subq	%r13, %rdx	# _114, tmp435
	sarq	$3, %rdx	#, tmp436
# C/parallel-only-omp/simulation.h:690:             for (size_t i = 0; i < worker_buffers.new_ions[t].x.size(); ++i) {
	cmpq	%r13, %r15	# _114, _71
	je	.L1495	#,
	movslq	(%rsp), %rcx	# %sfp, N_i_lsm.2466
	vmovq	%xmm10, %rax	# tmp507, tmp507
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	24(%rdi), %rsi	# MEM[(double * *)_514 + 24B], _161
	movq	48(%rdi), %r10	# MEM[(double * *)_514 + 48B], _159
	movq	72(%rdi), %rbx	# MEM[(double * *)_514 + 72B], _157
	salq	$3, %rcx	#, _470
	leaq	(%rcx,%rax), %rbp	#, _471
	vmovq	%xmm9, %rax	# tmp508, tmp508
	leaq	(%rcx,%rax), %r12	#, _474
	vmovq	%xmm8, %rax	# tmp509, tmp509
	leaq	(%rcx,%rax), %r14	#, _477
	vmovq	%xmm7, %rax	# tmp510, tmp510
	addq	%rax, %rcx	# tmp510, _480
# C/parallel-only-omp/simulation.h:690:             for (size_t i = 0; i < worker_buffers.new_ions[t].x.size(); ++i) {
	xorl	%eax, %eax	# i
	.p2align 4
	.p2align 3
.L1496:
# C/parallel-only-omp/simulation.h:691:                 x_i[N_i]    = worker_buffers.new_ions[t].x[i];
	vmovsd	0(%r13,%rax,8), %xmm0	# MEM[(value_type &)_114 + i_260 * 8], _41
	vmovsd	%xmm0, 0(%rbp,%rax,8)	# _41, MEM[(double *)_471 + i_260 * 8]
# C/parallel-only-omp/simulation.h:692:                 vx_i[N_i]   = worker_buffers.new_ions[t].vx[i];
	vmovsd	(%rsi,%rax,8), %xmm0	# MEM[(value_type &)_161 + i_260 * 8], _42
	vmovsd	%xmm0, (%r12,%rax,8)	# _42, MEM[(double *)_474 + i_260 * 8]
# C/parallel-only-omp/simulation.h:693:                 vy_i[N_i]   = worker_buffers.new_ions[t].vy[i];
	vmovsd	(%r10,%rax,8), %xmm0	# MEM[(value_type &)_159 + i_260 * 8], _43
	vmovsd	%xmm0, (%r14,%rax,8)	# _43, MEM[(double *)_477 + i_260 * 8]
# C/parallel-only-omp/simulation.h:694:                 vz_i[N_i]   = worker_buffers.new_ions[t].vz[i];
	vmovsd	(%rbx,%rax,8), %xmm0	# MEM[(value_type &)_157 + i_260 * 8], _44
	vmovsd	%xmm0, (%rcx,%rax,8)	# _44, MEM[(double *)_480 + i_260 * 8]
# C/parallel-only-omp/simulation.h:690:             for (size_t i = 0; i < worker_buffers.new_ions[t].x.size(); ++i) {
	incq	%rax	# i
# C/parallel-only-omp/simulation.h:690:             for (size_t i = 0; i < worker_buffers.new_ions[t].x.size(); ++i) {
	cmpq	%rdx, %rax	# tmp436, i
	jb	.L1496	#,
# C/parallel-only-omp/simulation.h:695:                 N_i++;
	xorl	%eax, %eax	# tmp661
	decq	%rdx	# tmp443
	cmpq	%r13, %r15	# _114, _71
	cmove	%eax, %edx	# tmp443,, tmp661, tmp442
	movl	(%rsp), %eax	# %sfp, N_i_lsm.2466
	leal	1(%rax,%rdx), %eax	#, N_i_lsm.2466
	movl	%eax, (%rsp)	# N_i_lsm.2466, %sfp
	movzbl	32(%rsp), %eax	# %sfp, _98
	movb	%al, 40(%rsp)	# _98, %sfp
.L1495:
# C/parallel-only-omp/simulation.h:680:         for (int t = 0; t < num_threads; ++t) {
	movq	16(%rsp), %rax	# %sfp, _512
	addq	$64, %r9	#, ivtmp.2506
	addq	$96, %r8	#, ivtmp.2507
	addq	$96, %rdi	#, ivtmp.2509
	cmpq	%rax, %r9	# _512, ivtmp.2506
	jne	.L1497	#,
	movq	24(%rsp), %rax	# %sfp, tmp423
	cmpb	$0, 36(%rsp)	#, %sfp
	movq	%rax, N_e_coll(%rip)	# tmp423, N_e_coll
	je	.L1498	#,
	movl	%r11d, N_e(%rip)	# N_e_lsm.2468, N_e
.L1498:
	cmpb	$0, 40(%rsp)	#, %sfp
	je	.L1491	#,
	movl	(%rsp), %eax	# %sfp, N_i_lsm.2466
	movl	%eax, N_i(%rip)	# N_i_lsm.2466, N_i
.L1491:
	movq	216(%rsp), %rax	# D.136070, tmp534
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp534
	jne	.L1517	#,
# C/parallel-only-omp/simulation.h:699: }
	addq	$232, %rsp	#,
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
.L1516:
	.cfi_restore_state
# /usr/include/c++/13/bits/random.h:3875: 	  _M_initialize();
	leaq	64(%rsp), %rbp	#, tmp309
# /usr/include/c++/13/bits/random.h:3870: 	: _M_t(__t), _M_p(__p)
	vmovsd	P_star_e(%rip), %xmm0	# P_star_e, P_star_e.139_8
# /usr/include/c++/13/bits/random.h:3870: 	: _M_t(__t), _M_p(__p)
	movl	%r13d, 64(%rsp)	# N_local, MEM[(struct param_type *)&binom_e]._M_t
# /usr/include/c++/13/bits/random.h:3870: 	: _M_t(__t), _M_p(__p)
	vmovsd	%xmm0, 72(%rsp)	# P_star_e.139_8, MEM[(struct param_type *)&binom_e]._M_p
# /usr/include/c++/13/bits/random.h:3875: 	  _M_initialize();
	movq	%rbp, %rdi	# tmp309,
	call	_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv	#
# /usr/include/c++/13/bits/random.h:2034: 	: _M_mean(__mean), _M_stddev(__stddev)
	movq	.LC10(%rip), %rax	#, tmp582
# /usr/include/c++/13/bits/random.h:2034: 	: _M_mean(__mean), _M_stddev(__stddev)
	movq	$0x000000000, 176(%rsp)	#, MEM[(struct param_type *)&binom_e + 112B]._M_mean
# /usr/include/c++/13/bits/random.h:2073:       : _M_param(__mean, __stddev)
	movq	$0x000000000, 192(%rsp)	#, MEM[(struct normal_distribution *)&binom_e + 112B]._M_saved
	movb	$0, 200(%rsp)	#, MEM[(struct normal_distribution *)&binom_e + 112B]._M_saved_available
# /usr/include/c++/13/bits/random.h:2034: 	: _M_mean(__mean), _M_stddev(__stddev)
	movq	%rax, 184(%rsp)	# tmp582, MEM[(struct param_type *)&binom_e + 112B]._M_stddev
# C/parallel-only-omp/simulation.h:651:         int local_N_coll = binom_e(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.h:3981: 	{ return this->operator()(__urng, _M_param); }
	movq	%fs:0, %rax	#, tmp583
	movq	%rbp, %rdx	# tmp309,
	movq	%rbp, %rdi	# tmp309,
	leaq	MTgen@tpoff(%rax), %rsi	#, tmp314
	call	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE	#
# C/parallel-only-omp/simulation.h:652:         if (local_N_coll > N_local) local_N_coll = N_local;
	cmpl	%eax, %r13d	# tmp514, N_local
	cmovle	%r13d, %eax	# N_local,, tmp514
# C/parallel-only-omp/simulation.h:654:         for (int i = 0; i < local_N_coll; ++i) {
	testl	%eax, %eax	# _2
	jle	.L1476	#,
# C/parallel-only-omp/simulation.h:669:                 collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index,
	movl	(%rsp), %r8d	# %sfp, _249
	movq	40(%rsp), %r9	# %sfp, tmp298
	leaq	MTgen@tpoff, %r12	#, tmp457
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp586
# C/parallel-only-omp/simulation.h:654:         for (int i = 0; i < local_N_coll; ++i) {
	xorl	%ebp, %ebp	# i
	vcvtsi2sdl	%r13d, %xmm3, %xmm0	# N_local, tmp586, tmp517
	leaq	vx_e(%rip), %r15	#, tmp461
	vmovsd	%xmm0, 8(%rsp)	# tmp517, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	salq	$6, %rbx	#, _1
# C/parallel-only-omp/simulation.h:669:                 collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index,
	movl	%eax, 32(%rsp)	# _2, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	%rbx, 48(%rsp)	# _1, %sfp
# C/parallel-only-omp/simulation.h:669:                 collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index,
	movq	%r12, %r14	# tmp457, tmp457
	leaq	R01@tpoff, %rbx	#, tmp453
	movl	%r8d, 24(%rsp)	# _249, %sfp
	movq	%r9, 56(%rsp)	# tmp298, %sfp
	jmp	.L1488	#
	.p2align 4
	.p2align 3
.L1478:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rdx	#, _351
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r14,%rax,8), %rax	# MTgen._M_x[prephitmp_541], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp592
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp593
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, %fs:4992(%r14)	# _351, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rcx	# __z, tmp323
	shrq	$11, %rcx	#, tmp323
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp323, _355
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rax	# _355, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rcx	# __z, tmp324
	salq	$7, %rcx	#, tmp324
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _358
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rax	# _358, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rcx	# __z, tmp325
	salq	$15, %rcx	#, tmp325
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _361
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rax	# _361, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rcx	# __z, _363
	shrq	$18, %rcx	#, _363
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rax	# _363, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm1	# __z, tmp592, tmp518
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm5, %xmm1, %xmm1	# tmp593, tmp327, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _351
	ja	.L1518	#,
.L1479:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rax	#, tmp333
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp599
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC10(%rip), %xmm4	#, tmp600
	vmovsd	.LC168(%rip), %xmm5	#, tmp601
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, %fs:4992(%r14)	# tmp333, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r14,%rdx,8), %rax	# MTgen._M_x[prephitmp_544], __z
# C/parallel-only-omp/simulation.h:656:             if (ki >= k_end) ki = k_end - 1;
	movl	16(%rsp), %edi	# %sfp, _244
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:(%rbx), %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _121
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp335
	shrq	$11, %rdx	#, tmp335
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp335, _384
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _384, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp336
	salq	$7, %rdx	#, tmp336
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _387
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _387, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp337
	salq	$15, %rdx	#, tmp337
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _390
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _390, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _392
	shrq	$18, %rdx	#, _392
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _392, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm6, %xmm0	# __z, tmp599, tmp519
# C/parallel-only-omp/simulation.h:655:             int ki = k_start + (int)(R01(MTgen) * N_local);
	movl	24(%rsp), %eax	# %sfp, _249
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC163(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC164(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm4, %xmm1	#, __ret, tmp600, tmp473
	vblendvpd	%xmm1, %xmm5, %xmm0, %xmm0	# tmp473, tmp601, __ret, __ret
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%rbx), %xmm1	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm1, %xmm1	# _121, MEM[(const struct param_type *)&R01]._M_b, tmp345
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm1, %xmm2, %xmm0	# tmp345, _121, _101
# C/parallel-only-omp/simulation.h:655:             int ki = k_start + (int)(R01(MTgen) * N_local);
	vmulsd	8(%rsp), %xmm0, %xmm0	# %sfp, _101, tmp348
# C/parallel-only-omp/simulation.h:655:             int ki = k_start + (int)(R01(MTgen) * N_local);
	vcvttsd2sil	%xmm0, %edx	# tmp348, tmp349
# C/parallel-only-omp/simulation.h:655:             int ki = k_start + (int)(R01(MTgen) * N_local);
	addl	%eax, %edx	# _249, ki
# C/parallel-only-omp/simulation.h:656:             if (ki >= k_end) ki = k_end - 1;
	leal	-1(%rdi), %eax	#, tmp487
	cmpl	%edi, %edx	# _244, ki
# C/parallel-only-omp/simulation.h:663:             double real_nu  = sigma_tot_e[energy_index] * velocity;
	leaq	sigma_tot_e(%rip), %rdi	#, tmp608
# C/parallel-only-omp/simulation.h:656:             if (ki >= k_end) ki = k_end - 1;
	cmovge	%eax, %edx	# tmp487,, ki
# C/parallel-only-omp/simulation.h:658:             double v_sqr     = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	leaq	vy_e(%rip), %rax	#, tmp606
# C/parallel-only-omp/simulation.h:658:             double v_sqr     = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	movslq	%edx, %r13	# ki, ki
	vmovsd	(%r15,%r13,8), %xmm0	# vx_e[ki_47], _12
# C/parallel-only-omp/simulation.h:658:             double v_sqr     = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vmovsd	(%rax,%r13,8), %xmm1	# vy_e[ki_47], _14
# C/parallel-only-omp/simulation.h:658:             double v_sqr     = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vmulsd	%xmm1, %xmm1, %xmm1	# _14, _14, tmp354
# C/parallel-only-omp/simulation.h:658:             double v_sqr     = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vfmadd231sd	%xmm0, %xmm0, %xmm1	# _12, _12, _16
# C/parallel-only-omp/simulation.h:658:             double v_sqr     = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	leaq	vz_e(%rip), %rax	#, tmp607
	vmovsd	(%rax,%r13,8), %xmm0	# vz_e[ki_47], _17
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	movl	$999999, %eax	#, tmp532
# C/parallel-only-omp/simulation.h:658:             double v_sqr     = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# _17, _16, v_sqr
# C/parallel-only-omp/simulation.h:659:             double velocity  = sqrt(v_sqr);
	vsqrtsd	%xmm0, %xmm0, %xmm1	# v_sqr, velocity
# C/parallel-only-omp/simulation.h:660:             double energy    = 0.5 * E_MASS * v_sqr / EV_TO_J;
	vmulsd	.LC61(%rip), %xmm0, %xmm0	#, v_sqr, tmp357
# C/parallel-only-omp/simulation.h:660:             double energy    = 0.5 * E_MASS * v_sqr / EV_TO_J;
	vdivsd	.LC50(%rip), %xmm0, %xmm0	#, tmp357, energy
# C/parallel-only-omp/simulation.h:661:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vdivsd	.LC1(%rip), %xmm0, %xmm0	#, energy, tmp361
# C/parallel-only-omp/simulation.h:661:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vaddsd	.LC45(%rip), %xmm0, %xmm0	#, tmp361, tmp363
# C/parallel-only-omp/simulation.h:661:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vcvttsd2sil	%xmm0, %r12d	# tmp363, _88
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%eax, %r12d	# tmp532, _88
	cmovg	%eax, %r12d	# _88,, tmp532, _88
# C/parallel-only-omp/simulation.h:663:             double real_nu  = sigma_tot_e[energy_index] * velocity;
	movslq	%r12d, %rax	# _88, _88
# C/parallel-only-omp/simulation.h:663:             double real_nu  = sigma_tot_e[energy_index] * velocity;
	vmulsd	(%rdi,%rax,8), %xmm1, %xmm1	# sigma_tot_e[_88], velocity, real_nu
# C/parallel-only-omp/simulation.h:664:             double p_accept = real_nu / nu_star_e;
	vdivsd	nu_star_e(%rip), %xmm1, %xmm1	# nu_star_e, real_nu, p_accept
# C/parallel-only-omp/simulation.h:665:             if (p_accept > 1.0) p_accept = 1.0;
	vminsd	%xmm1, %xmm4, %xmm1	# p_accept, tmp609, p_accept
	vmovsd	%xmm1, (%rsp)	# p_accept, %sfp
# C/parallel-only-omp/simulation.h:668:             if (R01(MTgen) < p_accept) {
	call	_ZTH3R01	#
# C/parallel-only-omp/simulation.h:668:             if (R01(MTgen) < p_accept) {
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992(%r14), %rax	# MTgen._M_p, _251
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	vmovsd	(%rsp), %xmm1	# %sfp, p_accept
	cmpq	$623, %rax	#, _251
	ja	.L1519	#,
.L1483:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rsi	#, _299
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r14,%rax,8), %rax	# MTgen._M_x[prephitmp_576], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp615
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp616
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rsi, %fs:4992(%r14)	# _299, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdi	# __z, tmp375
	shrq	$11, %rdi	#, tmp375
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edi, %edi	# tmp375, _190
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rax, %rdi	# __z, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdi, %rax	# __z, tmp376
	salq	$7, %rax	#, tmp376
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %eax	#, _64
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdi, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdi	# __z, tmp377
	salq	$15, %rdi	#, tmp377
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edi	#, _303
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdi, %rax	# _303, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdi	# __z, _305
	shrq	$18, %rdi	#, _305
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdi, %rax	# _305, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm2	# __z, tmp615, tmp520
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm5, %xmm2, %xmm2	# tmp616, tmp379, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rsi	#, _299
	ja	.L1520	#,
.L1484:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rsi), %rax	#, tmp385
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp622
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC168(%rip), %xmm7	#, tmp624
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:(%rbx), %xmm3	# MEM[(const struct param_type *)&R01]._M_a, _72
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, %fs:4992(%r14)	# tmp385, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r14,%rsi,8), %rax	# MTgen._M_x[prephitmp_579], __z
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rsi	# __z, tmp387
	shrq	$11, %rsi	#, tmp387
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%esi, %esi	# tmp387, _326
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rsi, %rax	# _326, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rsi	# __z, tmp388
	salq	$7, %rsi	#, tmp388
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %esi	#, _329
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rsi, %rax	# _329, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rsi	# __z, tmp389
	salq	$15, %rsi	#, tmp389
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %esi	#, _332
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rsi, %rax	# _332, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rsi	# __z, _334
	shrq	$18, %rsi	#, _334
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rsi, %rax	# _334, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm6, %xmm0	# __z, tmp622, tmp521
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC10(%rip), %xmm6	#, tmp623
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC163(%rip), %xmm2, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC164(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm6, %xmm2	#, __ret, tmp623, tmp476
	vblendvpd	%xmm2, %xmm7, %xmm0, %xmm0	# tmp476, tmp624, __ret, __ret
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%rbx), %xmm2	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm3, %xmm2, %xmm2	# _72, MEM[(const struct param_type *)&R01]._M_b, tmp397
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm2, %xmm3, %xmm0	# tmp397, _72, _61
# C/parallel-only-omp/simulation.h:668:             if (R01(MTgen) < p_accept) {
	vcomisd	%xmm0, %xmm1	# _61, p_accept
	ja	.L1521	#,
.L1486:
# C/parallel-only-omp/simulation.h:654:         for (int i = 0; i < local_N_coll; ++i) {
	incl	%ebp	# i
# C/parallel-only-omp/simulation.h:654:         for (int i = 0; i < local_N_coll; ++i) {
	cmpl	%ebp, 32(%rsp)	# i, %sfp
	je	.L1476	#,
.L1488:
# C/parallel-only-omp/simulation.h:655:             int ki = k_start + (int)(R01(MTgen) * N_local);
	call	_ZTH3R01	#
# C/parallel-only-omp/simulation.h:655:             int ki = k_start + (int)(R01(MTgen) * N_local);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992(%r14), %rax	# MTgen._M_p, _347
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, _347
	jbe	.L1478	#,
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp587
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp318
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r14), %rax	# MTgen._M_p, _347
	jmp	.L1478	#
	.p2align 4
	.p2align 3
.L1521:
# C/parallel-only-omp/simulation.h:669:                 collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index,
	movq	56(%rsp), %r8	# %sfp, tmp298
	movq	360+worker_buffers(%rip), %r9	# MEM[(struct vector *)&worker_buffers + 360B].D.109135._M_impl.D.108474._M_start, tmp628
	leaq	0(,%r13,8), %rax	#, _272
	leaq	vz_e(%rip), %rdi	#, tmp625
	leaq	(%rdi,%rax), %r11	#, tmp406
	leaq	vy_e(%rip), %rdi	#, tmp626
	leaq	(%rdi,%rax), %rsi	#, tmp408
	movl	%r12d, %ecx	# _88,
	leaq	(%r15,%rax), %rdi	#, tmp410
	movq	%r11, %rdx	# tmp406,
	leaq	x_e(%rip), %rax	#, tmp627
	vmovsd	(%rax,%r13,8), %xmm0	# x_e[ki_47], x_e[ki_47]
	addq	%r8, %r9	# tmp298, tmp628
	addq	336+worker_buffers(%rip), %r8	# MEM[(struct vector *)&worker_buffers + 336B].D.109135._M_impl.D.108474._M_start, tmp629
	call	_Z18collision_electrondPdS_S_iR12NewParticlesS1_	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	48(%rsp), %rax	# %sfp, _137
	addq	168+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 168B].D.105978._M_impl.D.105317._M_start, _137
# C/parallel-only-omp/simulation.h:671:                 worker_buffers.thread_counters[tid].local_coll_e++;
	incq	32(%rax)	# _137->local_coll_e
	jmp	.L1486	#
	.p2align 4
	.p2align 3
.L1520:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp617
	vmovsd	%xmm2, 40(%rsp)	# __sum, %sfp
	vmovsd	%xmm1, (%rsp)	# p_accept, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp381
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r14), %rsi	# MTgen._M_p, _299
	vmovsd	40(%rsp), %xmm2	# %sfp, __sum
	vmovsd	(%rsp), %xmm1	# %sfp, p_accept
	jmp	.L1484	#
	.p2align 4
	.p2align 3
.L1519:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp610
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp370
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r14), %rax	# MTgen._M_p, _251
	vmovsd	(%rsp), %xmm1	# %sfp, p_accept
	jmp	.L1483	#
	.p2align 4
	.p2align 3
.L1518:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp594
	vmovsd	%xmm1, (%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp329
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r14), %rdx	# MTgen._M_p, _351
	vmovsd	(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1479	#
.L1517:
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE9884:
	.size	_Z31step7_collisions_electrons_bodyii, .-_Z31step7_collisions_electrons_bodyii
	