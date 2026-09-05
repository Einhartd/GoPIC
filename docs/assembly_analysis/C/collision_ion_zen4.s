_Z25step8_collision_ions_bodyiii:
.LFB9886:
	.cfi_startproc
	endbr64	
# C/parallel-only-omp/simulation.h:728:     if ((t % N_SUB) != 0) return;
	movslq	%edx, %rcx	# t, t
# C/parallel-only-omp/simulation.h:727: PIC_STEP void step8_collision_ions_body(int tid, int num_threads, int t) {
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
# C/parallel-only-omp/simulation.h:728:     if ((t % N_SUB) != 0) return;
	imulq	$1717986919, %rcx, %rcx	#, t, tmp378
# C/parallel-only-omp/simulation.h:727: PIC_STEP void step8_collision_ions_body(int tid, int num_threads, int t) {
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
# C/parallel-only-omp/simulation.h:727: PIC_STEP void step8_collision_ions_body(int tid, int num_threads, int t) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp693
	movq	%rax, 296(%rsp)	# tmp693, D.136260
	xorl	%eax, %eax	# tmp693
# C/parallel-only-omp/simulation.h:728:     if ((t % N_SUB) != 0) return;
	movl	%edx, %eax	# t, tmp381
	sarl	$31, %eax	#, tmp381
	sarq	$35, %rcx	#, tmp380
	subl	%eax, %ecx	# tmp381, tmp380
	leal	(%rcx,%rcx,4), %eax	#, tmp384
	sall	$2, %eax	#, tmp385
# C/parallel-only-omp/simulation.h:728:     if ((t % N_SUB) != 0) return;
	subl	%eax, %edx	# tmp385, t
	jne	.L1522	#,
	movslq	%esi, %rbx	# tmp673,
# C/parallel-only-omp/simulation.h:731:     int chunk = (N_i + num_threads - 1) / num_threads;
	movl	N_i(%rip), %esi	# N_i, N_i.166_2
	movl	%edx, %r15d	# t, i
	movslq	%edi, %rbp	# tmp672,
# C/parallel-only-omp/simulation.h:731:     int chunk = (N_i + num_threads - 1) / num_threads;
	leal	-1(%rsi,%rbx), %eax	#, tmp387
# C/parallel-only-omp/simulation.h:731:     int chunk = (N_i + num_threads - 1) / num_threads;
	cltd
	idivl	%ebx	# num_threads
# C/parallel-only-omp/simulation.h:732:     int k_start = std::min(tid * chunk, N_i);
	movl	%eax, %r9d	# tmp388, tmp390
	imull	%ebp, %r9d	# tid, tmp390
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%esi, %r9d	# N_i.166_2, tmp390
	cmovg	%esi, %r9d	# tmp390,, N_i.166_2, _458
# C/parallel-only-omp/simulation.h:733:     int k_end = std::min(k_start + chunk, N_i);
	addl	%r9d, %eax	# _458, tmp391
# C/parallel-only-omp/simulation.h:734:     int N_local = k_end - k_start;
	movl	%r9d, 8(%rsp)	# _458, %sfp
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%esi, %eax	# N_i.166_2, tmp391
	cmovle	%eax, %esi	# tmp391,, N_i.166_2
# C/parallel-only-omp/simulation.h:734:     int N_local = k_end - k_start;
	movl	%esi, %r13d	# _145, N_local
	movl	%esi, 16(%rsp)	# _145, %sfp
	subl	%r9d, %r13d	# _458, N_local
# C/parallel-only-omp/simulation.h:736:     if (N_local > 0) {
	testl	%r13d, %r13d	# N_local
	jg	.L1587	#,
.L1524:
	call	GOMP_single_start@PLT	#
	testb	%al, %al	# tmp679
	je	.L1555	#,
.L1598:
# C/parallel-only-omp/simulation.h:771:         for (int t = 0; t < num_threads; ++t) {
	testl	%ebx, %ebx	# num_threads
	jle	.L1555	#,
	movq	168+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 168B].D.105978._M_impl.D.105317._M_start, ivtmp.2537
	movq	N_i_coll(%rip), %rcx	# N_i_coll, N_i_coll_lsm.2531
	salq	$6, %rbx	#, tmp631
	leaq	(%rbx,%rax), %rdx	#, _925
	.p2align 4
	.p2align 3
.L1556:
# C/parallel-only-omp/simulation.h:772:             N_i_coll += worker_buffers.thread_counters[t].local_coll_i;
	addq	40(%rax), %rcx	# MEM[(long long unsigned int *)_920 + 40B], N_i_coll_lsm.2531
# C/parallel-only-omp/simulation.h:773:             worker_buffers.thread_counters[t].local_coll_i = 0;
	movq	$0, 40(%rax)	#, MEM[(long long unsigned int *)_920 + 40B]
# C/parallel-only-omp/simulation.h:771:         for (int t = 0; t < num_threads; ++t) {
	addq	$64, %rax	#, ivtmp.2537
	cmpq	%rdx, %rax	# _925, ivtmp.2537
	jne	.L1556	#,
	movq	%rcx, N_i_coll(%rip)	# N_i_coll_lsm.2531, N_i_coll
.L1555:
	movq	296(%rsp), %rax	# D.136260, tmp694
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp694
	jne	.L1586	#,
# C/parallel-only-omp/simulation.h:776: }
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
.L1587:
	.cfi_restore_state
# /usr/include/c++/13/bits/random.h:3875: 	  _M_initialize();
	leaq	144(%rsp), %r14	#, tmp392
# /usr/include/c++/13/bits/random.h:3870: 	: _M_t(__t), _M_p(__p)
	vmovsd	P_star_i(%rip), %xmm0	# P_star_i, P_star_i.167_7
# /usr/include/c++/13/bits/random.h:3870: 	: _M_t(__t), _M_p(__p)
	movl	%r13d, 144(%rsp)	# N_local, MEM[(struct param_type *)&binom_i]._M_t
# /usr/include/c++/13/bits/random.h:3870: 	: _M_t(__t), _M_p(__p)
	vmovsd	%xmm0, 152(%rsp)	# P_star_i.167_7, MEM[(struct param_type *)&binom_i]._M_p
# /usr/include/c++/13/bits/random.h:3875: 	  _M_initialize();
	movq	%r14, %rdi	# tmp392,
	call	_ZNSt21binomial_distributionIiE10param_type13_M_initializeEv	#
# /usr/include/c++/13/bits/random.h:2034: 	: _M_mean(__mean), _M_stddev(__stddev)
	movq	.LC10(%rip), %rax	#, tmp713
# /usr/include/c++/13/bits/random.h:2034: 	: _M_mean(__mean), _M_stddev(__stddev)
	movq	$0x000000000, 256(%rsp)	#, MEM[(struct param_type *)&binom_i + 112B]._M_mean
# /usr/include/c++/13/bits/random.h:2073:       : _M_param(__mean, __stddev)
	movq	$0x000000000, 272(%rsp)	#, MEM[(struct normal_distribution *)&binom_i + 112B]._M_saved
	movb	$0, 280(%rsp)	#, MEM[(struct normal_distribution *)&binom_i + 112B]._M_saved_available
# /usr/include/c++/13/bits/random.h:2034: 	: _M_mean(__mean), _M_stddev(__stddev)
	movq	%rax, 264(%rsp)	# tmp713, MEM[(struct param_type *)&binom_i + 112B]._M_stddev
# C/parallel-only-omp/simulation.h:738:         int local_N_coll = binom_i(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.h:3981: 	{ return this->operator()(__urng, _M_param); }
	movq	%fs:0, %rax	#, tmp714
	movq	%r14, %rdx	# tmp392,
	movq	%r14, %rdi	# tmp392,
	leaq	MTgen@tpoff(%rax), %rsi	#, tmp397
	call	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_RKNS0_10param_typeE	#
# C/parallel-only-omp/simulation.h:739:         if (local_N_coll > N_local) local_N_coll = N_local;
	cmpl	%eax, %r13d	# tmp675, N_local
	cmovle	%r13d, %eax	# N_local,, _68
# C/parallel-only-omp/simulation.h:744:         for (int i = 0; i < local_N_coll; ++i) {
	testl	%eax, %eax	# _68
	jle	.L1524	#,
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	movl	16(%rsp), %r8d	# %sfp, _145
	movl	8(%rsp), %r9d	# %sfp, _458
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp716
	leaq	MTgen@tpoff, %r12	#, tmp647
	vcvtsi2sdl	%r13d, %xmm4, %xmm0	# N_local, tmp716, tmp681
	leaq	vy_i(%rip), %r14	#, tmp652
	vmovsd	%xmm0, 40(%rsp)	# tmp681, %sfp
	movl	%eax, 48(%rsp)	# _68, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	salq	$6, %rbp	#, tid
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	movl	%ebx, 116(%rsp)	# num_threads, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	%rbp, 104(%rsp)	# tid, %sfp
	leaq	R01@tpoff, %rbp	#, tmp643
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	movl	%r8d, 52(%rsp)	# _145, %sfp
	movl	%r9d, 112(%rsp)	# _458, %sfp
	jmp	.L1553	#
	.p2align 4
	.p2align 3
.L1527:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rdx	#, tmp417
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC10(%rip), %xmm7	#, tmp730
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp729
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:0(%rbp), %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _82
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, %fs:4992(%r12)	# tmp417, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r12,%rcx,8), %rdx	# MTgen._M_x[prephitmp_842], __z
# C/parallel-only-omp/simulation.h:745:             int ki = k_start + (int)(R01(MTgen) * N_local);
	movl	112(%rsp), %eax	# %sfp, _458
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rcx	# __z, tmp419
	shrq	$11, %rcx	#, tmp419
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%ecx, %ecx	# tmp419, _683
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rcx, %rdx	# _683, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rcx	# __z, tmp420
	salq	$7, %rcx	#, tmp420
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %ecx	#, _686
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rcx, %rdx	# _686, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rcx	# __z, tmp421
	salq	$15, %rcx	#, tmp421
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %ecx	#, _689
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rcx, %rdx	# _689, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rcx	# __z, _691
	shrq	$18, %rcx	#, _691
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rcx, %rdx	# _691, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm6, %xmm0	# __z, tmp729, tmp683
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC163(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC164(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm7, %xmm1	#, __ret, tmp730, tmp656
	vmovsd	.LC168(%rip), %xmm6	#, tmp731
	vblendvpd	%xmm1, %xmm6, %xmm0, %xmm0	# tmp656, tmp731, __ret, __ret
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%rbp), %xmm1	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm1, %xmm1	# _82, MEM[(const struct param_type *)&R01]._M_b, tmp429
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm1, %xmm2, %xmm0	# tmp429, _82, _85
# C/parallel-only-omp/simulation.h:745:             int ki = k_start + (int)(R01(MTgen) * N_local);
	vmulsd	40(%rsp), %xmm0, %xmm0	# %sfp, _85, tmp432
# C/parallel-only-omp/simulation.h:745:             int ki = k_start + (int)(R01(MTgen) * N_local);
	vcvttsd2sil	%xmm0, %ecx	# tmp432, tmp433
# C/parallel-only-omp/simulation.h:745:             int ki = k_start + (int)(R01(MTgen) * N_local);
	leal	(%rcx,%rax), %r13d	#, ki
# C/parallel-only-omp/simulation.h:746:             if (ki >= k_end) ki = k_end - 1;
	movl	52(%rsp), %eax	# %sfp, _145
	leal	-1(%rax), %edx	#, tmp669
	cmpl	%eax, %r13d	# _145, ki
	cmovge	%edx, %r13d	# tmp669,, ki
# C/parallel-only-omp/simulation.h:749:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZTH3RMB	#
# C/parallel-only-omp/simulation.h:749:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0	#
# C/parallel-only-omp/simulation.h:750:             gx = vx_i[ki] - vx_a;
	movslq	%r13d, %r13	# ki, ki
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	vmovsd	%xmm0, 8(%rsp)	# tmp676, %sfp
# C/parallel-only-omp/simulation.h:749:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZTH3RMB	#
# C/parallel-only-omp/simulation.h:749:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0	#
	vmovsd	%xmm0, 16(%rsp)	# tmp677, %sfp
# C/parallel-only-omp/simulation.h:749:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZTH3RMB	#
# C/parallel-only-omp/simulation.h:749:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0	#
# C/parallel-only-omp/simulation.h:750:             gx = vx_i[ki] - vx_a;
	leaq	vx_i(%rip), %rax	#, tmp736
# C/parallel-only-omp/simulation.h:751:             gy = vy_i[ki] - vy_a;
	vmovsd	(%r14,%r13,8), %xmm2	# vy_i[ki_31], vy_i[ki_31]
	vsubsd	16(%rsp), %xmm2, %xmm2	# %sfp, vy_i[ki_31], gy
# C/parallel-only-omp/simulation.h:750:             gx = vx_i[ki] - vx_a;
	vmovsd	(%rax,%r13,8), %xmm1	# vx_i[ki_31], vx_i[ki_31]
# C/parallel-only-omp/simulation.h:753:             g_sqr = gx*gx + gy*gy + gz*gz;
	vmulsd	%xmm2, %xmm2, %xmm2	# gy, gy, tmp443
# C/parallel-only-omp/simulation.h:750:             gx = vx_i[ki] - vx_a;
	vsubsd	8(%rsp), %xmm1, %xmm1	# %sfp, vx_i[ki_31], gx
# C/parallel-only-omp/simulation.h:753:             g_sqr = gx*gx + gy*gy + gz*gz;
	vfmadd132sd	%xmm1, %xmm2, %xmm1	# gx, tmp443, _16
# C/parallel-only-omp/simulation.h:752:             gz = vz_i[ki] - vz_a;
	leaq	vz_i(%rip), %rax	#, tmp739
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	vmovsd	%xmm0, %xmm0, %xmm5	# tmp678, _89
	vmovsd	%xmm0, 32(%rsp)	# _89, %sfp
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	movl	$999999, %edx	#, tmp692
# C/parallel-only-omp/simulation.h:752:             gz = vz_i[ki] - vz_a;
	vmovsd	(%rax,%r13,8), %xmm0	# vz_i[ki_31], vz_i[ki_31]
	vsubsd	%xmm5, %xmm0, %xmm0	# _89, vz_i[ki_31], gz
# C/parallel-only-omp/simulation.h:758:             double real_nu = sigma_tot_i[energy_index] * g;
	leaq	sigma_tot_i(%rip), %rax	#, tmp741
# C/parallel-only-omp/simulation.h:760:             if (p_accept > 1.0) p_accept = 1.0;
	vmovsd	.LC10(%rip), %xmm7	#, tmp742
# C/parallel-only-omp/simulation.h:753:             g_sqr = gx*gx + gy*gy + gz*gz;
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# gz, _16, g_sqr
# C/parallel-only-omp/simulation.h:754:             g = sqrt(g_sqr);
	vsqrtsd	%xmm0, %xmm0, %xmm1	# g_sqr, g
# C/parallel-only-omp/simulation.h:755:             energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J;
	vmulsd	.LC196(%rip), %xmm0, %xmm0	#, g_sqr, tmp444
# C/parallel-only-omp/simulation.h:755:             energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J;
	vdivsd	.LC50(%rip), %xmm0, %xmm0	#, tmp444, energy
# C/parallel-only-omp/simulation.h:756:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vdivsd	.LC1(%rip), %xmm0, %xmm0	#, energy, tmp448
# C/parallel-only-omp/simulation.h:756:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vaddsd	.LC45(%rip), %xmm0, %xmm0	#, tmp448, tmp450
# C/parallel-only-omp/simulation.h:756:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vcvttsd2sil	%xmm0, %ebx	# tmp450, _177
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%edx, %ebx	# tmp692, _177
	cmovg	%edx, %ebx	# _177,, tmp692, _177
# C/parallel-only-omp/simulation.h:758:             double real_nu = sigma_tot_i[energy_index] * g;
	movslq	%ebx, %rbx	# _177, _177
# C/parallel-only-omp/simulation.h:758:             double real_nu = sigma_tot_i[energy_index] * g;
	vmulsd	(%rax,%rbx,8), %xmm1, %xmm1	# sigma_tot_i[_177], g, real_nu
# C/parallel-only-omp/simulation.h:759:             double p_accept = real_nu / nu_star_i;
	vdivsd	nu_star_i(%rip), %xmm1, %xmm1	# nu_star_i, real_nu, p_accept
# C/parallel-only-omp/simulation.h:760:             if (p_accept > 1.0) p_accept = 1.0;
	vminsd	%xmm1, %xmm7, %xmm1	# p_accept, tmp742, p_accept
	vmovsd	%xmm1, 24(%rsp)	# p_accept, %sfp
# C/parallel-only-omp/simulation.h:762:             if (R01(MTgen) < p_accept) {
	call	_ZTH3R01	#
# C/parallel-only-omp/simulation.h:762:             if (R01(MTgen) < p_accept) {
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992(%r12), %rdx	# MTgen._M_p, _588
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	vmovsd	24(%rsp), %xmm1	# %sfp, p_accept
	cmpq	$623, %rdx	#, _588
	ja	.L1588	#,
.L1531:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rsi	#, _592
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r12,%rdx,8), %rdx	# MTgen._M_x[prephitmp_854], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp748
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp749
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rsi, %fs:4992(%r12)	# _592, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rdi	# __z, tmp462
	shrq	$11, %rdi	#, tmp462
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edi, %edi	# tmp462, _596
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdi, %rdx	# _596, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rdi	# __z, tmp463
	salq	$7, %rdi	#, tmp463
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edi	#, _599
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdi, %rdx	# _599, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rdi	# __z, tmp464
	salq	$15, %rdi	#, tmp464
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edi	#, _602
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdi, %rdx	# _602, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rdi	# __z, _604
	shrq	$18, %rdi	#, _604
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdi, %rdx	# _604, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm3, %xmm2	# __z, tmp748, tmp684
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm6, %xmm2, %xmm2	# tmp749, tmp466, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rsi	#, _592
	ja	.L1589	#,
.L1532:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rsi), %rdx	#, tmp472
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp755
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC10(%rip), %xmm5	#, tmp756
	vmovsd	.LC168(%rip), %xmm7	#, tmp757
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, %fs:4992(%r12)	# tmp472, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r12,%rsi,8), %rdx	# MTgen._M_x[prephitmp_857], __z
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:0(%rbp), %xmm3	# MEM[(const struct param_type *)&R01]._M_a, _92
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rsi	# __z, tmp474
	shrq	$11, %rsi	#, tmp474
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%esi, %esi	# tmp474, _625
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rsi, %rdx	# _625, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rsi	# __z, tmp475
	salq	$7, %rsi	#, tmp475
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %esi	#, _628
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rsi, %rdx	# _628, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rsi	# __z, tmp476
	salq	$15, %rsi	#, tmp476
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %esi	#, _631
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rsi, %rdx	# _631, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rsi	# __z, _633
	shrq	$18, %rsi	#, _633
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rsi, %rdx	# _633, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm4, %xmm0	# __z, tmp755, tmp685
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC163(%rip), %xmm2, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC164(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm5, %xmm2	#, __ret, tmp756, tmp659
	vblendvpd	%xmm2, %xmm7, %xmm0, %xmm0	# tmp659, tmp757, __ret, __ret
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%rbp), %xmm2	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm3, %xmm2, %xmm2	# _92, MEM[(const struct param_type *)&R01]._M_b, tmp484
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm2, %xmm3, %xmm0	# tmp484, _92, _95
# C/parallel-only-omp/simulation.h:762:             if (R01(MTgen) < p_accept) {
	vcomisd	%xmm0, %xmm1	# _95, p_accept
	ja	.L1590	#,
# C/parallel-only-omp/simulation.h:744:         for (int i = 0; i < local_N_coll; ++i) {
	incl	%r15d	# i
# C/parallel-only-omp/simulation.h:744:         for (int i = 0; i < local_N_coll; ++i) {
	cmpl	%r15d, 48(%rsp)	# i, %sfp
	je	.L1591	#,
.L1553:
# C/parallel-only-omp/simulation.h:745:             int ki = k_start + (int)(R01(MTgen) * N_local);
	call	_ZTH3R01	#
# C/parallel-only-omp/simulation.h:745:             int ki = k_start + (int)(R01(MTgen) * N_local);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992(%r12), %rdx	# MTgen._M_p, _646
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _646
	ja	.L1592	#,
.L1526:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rcx	#, _650
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r12,%rdx,8), %rdx	# MTgen._M_x[prephitmp_839], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp722
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp723
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, %fs:4992(%r12)	# _650, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rsi	# __z, tmp407
	shrq	$11, %rsi	#, tmp407
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%esi, %esi	# tmp407, _654
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rsi, %rdx	# _654, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rsi	# __z, tmp408
	salq	$7, %rsi	#, tmp408
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %esi	#, _657
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rsi, %rdx	# _657, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rsi	# __z, tmp409
	salq	$15, %rsi	#, tmp409
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %esi	#, _660
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rsi, %rdx	# _660, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rsi	# __z, _662
	shrq	$18, %rsi	#, _662
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rsi, %rdx	# _662, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm7, %xmm1	# __z, tmp722, tmp682
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm3, %xmm1, %xmm1	# tmp723, tmp411, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, _650
	jbe	.L1527	#,
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp724
	vmovsd	%xmm1, 8(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp413
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r12), %rcx	# MTgen._M_p, _650
	vmovsd	8(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1527	#
	.p2align 4
	.p2align 3
.L1592:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp717
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp402
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r12), %rdx	# MTgen._M_p, _646
	jmp	.L1526	#
	.p2align 4
	.p2align 3
.L1590:
# C/parallel-only-omp/collisions.h:129:     gx = (*vx_1) - (*vx_2);
	leaq	vx_i(%rip), %rax	#, tmp758
# C/parallel-only-omp/collisions.h:130:     gy = (*vy_1) - (*vy_2);
	vmovsd	(%r14,%r13,8), %xmm6	# MEM <double[1000000]> [(double *)&vy_i][ki_31], _199
# C/parallel-only-omp/collisions.h:130:     gy = (*vy_1) - (*vy_2);
	vmovsd	16(%rsp), %xmm13	# %sfp, _87
# C/parallel-only-omp/collisions.h:131:     gz = (*vz_1) - (*vz_2);
	vmovsd	32(%rsp), %xmm14	# %sfp, _89
# C/parallel-only-omp/collisions.h:129:     gx = (*vx_1) - (*vx_2);
	vmovsd	(%rax,%r13,8), %xmm0	# MEM <double[1000000]> [(double *)&vx_i][ki_31], _196
# C/parallel-only-omp/collisions.h:131:     gz = (*vz_1) - (*vz_2);
	leaq	vz_i(%rip), %rax	#, tmp761
# C/parallel-only-omp/collisions.h:130:     gy = (*vy_1) - (*vy_2);
	vsubsd	%xmm13, %xmm6, %xmm3	# _87, _199, gy
# C/parallel-only-omp/collisions.h:129:     gx = (*vx_1) - (*vx_2);
	vmovsd	8(%rsp), %xmm12	# %sfp, _86
# C/parallel-only-omp/collisions.h:131:     gz = (*vz_1) - (*vz_2);
	vmovsd	(%rax,%r13,8), %xmm5	# MEM <double[1000000]> [(double *)&vz_i][ki_31], _202
# C/parallel-only-omp/collisions.h:131:     gz = (*vz_1) - (*vz_2);
	vsubsd	%xmm14, %xmm5, %xmm2	# _89, _202, gz
# C/parallel-only-omp/collisions.h:132:     double g_perp_sq = gy * gy + gz * gz;
	vmulsd	%xmm2, %xmm2, %xmm1	# gz, gz, tmp492
# C/parallel-only-omp/collisions.h:132:     double g_perp_sq = gy * gy + gz * gz;
	vfmadd231sd	%xmm3, %xmm3, %xmm1	# gy, gy, g_perp_sq
# C/parallel-only-omp/collisions.h:129:     gx = (*vx_1) - (*vx_2);
	vsubsd	%xmm12, %xmm0, %xmm4	# _86, _196, gx
# C/parallel-only-omp/collisions.h:133:     double g_sq      = gx * gx + g_perp_sq;
	vmovsd	%xmm4, %xmm4, %xmm7	# gx, g_sq
# C/parallel-only-omp/collisions.h:137:     wx = 0.5 * ((*vx_1) + (*vx_2));
	vaddsd	%xmm12, %xmm0, %xmm0	# _86, _196, tmp493
# C/parallel-only-omp/collisions.h:137:     wx = 0.5 * ((*vx_1) + (*vx_2));
	vmulsd	.LC45(%rip), %xmm0, %xmm0	#, tmp493, wx
	vmovsd	%xmm0, 16(%rsp)	# wx, %sfp
# C/parallel-only-omp/collisions.h:138:     wy = 0.5 * ((*vy_1) + (*vy_2));
	vaddsd	%xmm13, %xmm6, %xmm0	# _87, _199, tmp495
# C/parallel-only-omp/collisions.h:138:     wy = 0.5 * ((*vy_1) + (*vy_2));
	vmulsd	.LC45(%rip), %xmm0, %xmm6	#, tmp495, wy
# C/parallel-only-omp/collisions.h:139:     wz = 0.5 * ((*vz_1) + (*vz_2));
	vaddsd	%xmm14, %xmm5, %xmm0	# _89, _202, tmp497
# C/parallel-only-omp/collisions.h:138:     wy = 0.5 * ((*vy_1) + (*vy_2));
	vmovsd	%xmm6, 24(%rsp)	# wy, %sfp
# C/parallel-only-omp/collisions.h:139:     wz = 0.5 * ((*vz_1) + (*vz_2));
	vmulsd	.LC45(%rip), %xmm0, %xmm5	#, tmp497, wz
	vmovsd	%xmm5, 32(%rsp)	# wz, %sfp
# C/parallel-only-omp/collisions.h:144:     if (g > 0.0) {
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp772
# C/parallel-only-omp/collisions.h:133:     double g_sq      = gx * gx + g_perp_sq;
	vfmadd132sd	%xmm4, %xmm1, %xmm7	# gx, g_perp_sq, g_sq
# C/parallel-only-omp/collisions.h:135:     double g_perp    = sqrt(g_perp_sq);
	vsqrtsd	%xmm1, %xmm1, %xmm1	# g_perp_sq, g_perp
# C/parallel-only-omp/collisions.h:134:     g  = sqrt(g_sq);
	vsqrtsd	%xmm7, %xmm7, %xmm7	# g_sq, g
	vmovsd	%xmm7, 8(%rsp)	# g, %sfp
# C/parallel-only-omp/collisions.h:144:     if (g > 0.0) {
	vcomisd	%xmm5, %xmm7	# tmp772, g
	jbe	.L1579	#,
# C/parallel-only-omp/collisions.h:145:         ct = gx / g;
	vdivsd	%xmm7, %xmm4, %xmm4	# g, gx, ct
# C/parallel-only-omp/collisions.h:146:         st = g_perp / g;
	vdivsd	%xmm7, %xmm1, %xmm5	# g, g_perp, st
# C/parallel-only-omp/collisions.h:145:         ct = gx / g;
	vmovsd	%xmm4, 72(%rsp)	# ct, %sfp
# C/parallel-only-omp/collisions.h:146:         st = g_perp / g;
	vmovsd	%xmm5, 80(%rsp)	# st, %sfp
.L1536:
# C/parallel-only-omp/collisions.h:152:     if (g_perp > 0.0) {
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp778
	vcomisd	%xmm4, %xmm1	# tmp778, g_perp
	jbe	.L1580	#,
# C/parallel-only-omp/collisions.h:153:         cp = gy / g_perp;
	vdivsd	%xmm1, %xmm3, %xmm3	# g_perp, gy, cp
# C/parallel-only-omp/collisions.h:154:         sp = gz / g_perp;
	vdivsd	%xmm1, %xmm2, %xmm6	# g_perp, gz, sp
# C/parallel-only-omp/collisions.h:153:         cp = gy / g_perp;
	vmovsd	%xmm3, 88(%rsp)	# cp, %sfp
# C/parallel-only-omp/collisions.h:154:         sp = gz / g_perp;
	vmovsd	%xmm6, 96(%rsp)	# sp, %sfp
.L1538:
# C/parallel-only-omp/collisions.h:163:     t1  =      sigma[I_ISO][e_index];
	leaq	sigma(%rip), %rdx	#, tmp501
	vmovsd	24000000(%rdx,%rbx,8), %xmm5	# sigma[3][_177], t1
# C/parallel-only-omp/collisions.h:164:     t2  = t1 + sigma[I_BACK][e_index];
	vaddsd	32000000(%rdx,%rbx,8), %xmm5, %xmm4	# sigma[4][_177], t1, t2
# C/parallel-only-omp/collisions.h:163:     t1  =      sigma[I_ISO][e_index];
	vmovsd	%xmm5, 56(%rsp)	# t1, %sfp
# C/parallel-only-omp/collisions.h:164:     t2  = t1 + sigma[I_BACK][e_index];
	vmovsd	%xmm4, 64(%rsp)	# t2, %sfp
# C/parallel-only-omp/collisions.h:165:     rnd = R01(MTgen);
	call	_ZTH3R01	#
# C/parallel-only-omp/collisions.h:165:     rnd = R01(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992(%r12), %rdx	# MTgen._M_p, _530
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _530
	ja	.L1593	#,
.L1540:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rsi	#, _534
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r12,%rdx,8), %rdx	# MTgen._M_x[prephitmp_863], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp790
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rsi, %fs:4992(%r12)	# _534, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rdi	# __z, tmp513
	shrq	$11, %rdi	#, tmp513
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edi, %edi	# tmp513, _538
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdi, %rdx	# _538, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rdi	# __z, tmp514
	salq	$7, %rdi	#, tmp514
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edi	#, _541
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdi, %rdx	# _541, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rdi	# __z, tmp515
	salq	$15, %rdi	#, tmp515
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edi	#, _544
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdi, %rdx	# _544, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rdi	# __z, _546
	shrq	$18, %rdi	#, _546
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdi, %rdx	# _546, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm4, %xmm1	# __z, tmp790, tmp686
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp791
	vaddsd	%xmm4, %xmm1, %xmm1	# tmp791, tmp517, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rsi	#, _534
	ja	.L1594	#,
.L1541:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rsi), %rdx	#, tmp523
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp797
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC168(%rip), %xmm6	#, tmp799
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:0(%rbp), %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _227
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, %fs:4992(%r12)	# tmp523, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r12,%rsi,8), %rdx	# MTgen._M_x[prephitmp_866], __z
# C/parallel-only-omp/collisions.h:167:     if (rnd < (t1 / t2)) {                        // Rozpraszanie izotropowe
	vmovsd	56(%rsp), %xmm5	# %sfp, t1
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rsi	# __z, tmp525
	shrq	$11, %rsi	#, tmp525
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%esi, %esi	# tmp525, _567
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rsi, %rdx	# _567, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rsi	# __z, tmp526
	salq	$7, %rsi	#, tmp526
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %esi	#, _570
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rsi, %rdx	# _570, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rsi	# __z, tmp527
	salq	$15, %rsi	#, tmp527
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %esi	#, _573
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rsi, %rdx	# _573, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rsi	# __z, _575
	shrq	$18, %rsi	#, _575
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rsi, %rdx	# _575, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm4, %xmm0	# __z, tmp797, tmp687
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC10(%rip), %xmm4	#, tmp798
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC163(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC164(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm4, %xmm1	#, __ret, tmp798, tmp662
	vblendvpd	%xmm1, %xmm6, %xmm0, %xmm0	# tmp662, tmp799, __ret, __ret
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%rbp), %xmm1	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm1, %xmm1	# _227, MEM[(const struct param_type *)&R01]._M_b, tmp535
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm1, %xmm2, %xmm0	# tmp535, _227, _230
# C/parallel-only-omp/collisions.h:167:     if (rnd < (t1 / t2)) {                        // Rozpraszanie izotropowe
	vdivsd	64(%rsp), %xmm5, %xmm1	# %sfp, t1, tmp537
# C/parallel-only-omp/collisions.h:167:     if (rnd < (t1 / t2)) {                        // Rozpraszanie izotropowe
	vcomisd	%xmm0, %xmm1	# _230, tmp537
	ja	.L1595	#,
# C/parallel-only-omp/collisions.h:171:         cc = -1.0;                                // cos(PI) = -1
	vmovsd	.LC147(%rip), %xmm3	#, cc
	vmovsd	%xmm3, 56(%rsp)	# cc, %sfp
.L1585:
# C/parallel-only-omp/collisions.h:172:         sc = 0.0;                                 // sin(PI) = 0
	movq	$0x000000000, 64(%rsp)	#, %sfp
.L1543:
# C/parallel-only-omp/collisions.h:175:     double eta = TWO_PI * R01(MTgen);
	call	_ZTH3R01	#
# C/parallel-only-omp/collisions.h:175:     double eta = TWO_PI * R01(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992(%r12), %rdx	# MTgen._M_p, _453
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _453
	ja	.L1596	#,
.L1550:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rsi	#, _175
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r12,%rdx,8), %rdx	# MTgen._M_x[prephitmp_892], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp826
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp827
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rsi, %fs:4992(%r12)	# _175, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rdi	# __z, tmp578
	shrq	$11, %rdi	#, tmp578
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edi, %edi	# tmp578, _128
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdi, %rdx	# _128, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rdi	# __z, tmp579
	salq	$7, %rdi	#, tmp579
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edi	#, _200
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdi, %rdx	# _200, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rdi	# __z, tmp580
	salq	$15, %rdi	#, tmp580
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edi	#, _303
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdi, %rdx	# _303, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rdi	# __z, _225
	shrq	$18, %rdi	#, _225
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdi, %rdx	# _225, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm4, %xmm1	# __z, tmp826, tmp690
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm5, %xmm1, %xmm1	# tmp827, tmp582, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rsi	#, _175
	ja	.L1597	#,
.L1551:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rsi), %rdx	#, tmp588
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp833
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC10(%rip), %xmm4	#, tmp834
	leaq	136(%rsp), %rdi	#, tmp602
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, %fs:4992(%r12)	# tmp588, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r12,%rsi,8), %rdx	# MTgen._M_x[prephitmp_895], __z
# C/parallel-only-omp/simulation.h:744:         for (int i = 0; i < local_N_coll; ++i) {
	incl	%r15d	# i
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rsi	# __z, tmp590
	shrq	$11, %rsi	#, tmp590
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%esi, %esi	# tmp590, _51
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rsi	# __z, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rsi, %rdx	# __z, tmp591
	salq	$7, %rdx	#, tmp591
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _56
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rsi, %rdx	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rsi	# __z, tmp592
	salq	$15, %rsi	#, tmp592
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %esi	#, _126
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rsi, %rdx	# _126, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rsi	# __z, _459
	shrq	$18, %rsi	#, _459
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rsi, %rdx	# _459, __z
	leaq	128(%rsp), %rsi	#, tmp603
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm3, %xmm0	# __z, tmp833, tmp691
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC163(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC164(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm4, %xmm2	#, __ret, tmp834, tmp668
	vmovsd	.LC168(%rip), %xmm1	#, tmp666
	vblendvpd	%xmm2, %xmm1, %xmm0, %xmm0	# tmp668, tmp666, __ret, __ret
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:0(%rbp), %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _247
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%rbp), %xmm1	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm1, %xmm1	# _247, MEM[(const struct param_type *)&R01]._M_b, tmp600
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm1, %xmm2, %xmm0	# tmp600, _247, _250
# C/parallel-only-omp/collisions.h:175:     double eta = TWO_PI * R01(MTgen);
	vmulsd	.LC191(%rip), %xmm0, %xmm0	#, _250, eta
	call	sincos@PLT	#
	vmovsd	128(%rsp), %xmm5	#, sincostmp_178
# C/parallel-only-omp/collisions.h:182:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	64(%rsp), %xmm7	# %sfp, sc
	vmovsd	80(%rsp), %xmm3	# %sfp, st
# C/parallel-only-omp/collisions.h:182:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	72(%rsp), %xmm6	# %sfp, ct
	vmovsd	56(%rsp), %xmm8	# %sfp, cc
# C/parallel-only-omp/collisions.h:183:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	88(%rsp), %xmm10	# %sfp, cp
	vmulsd	%xmm10, %xmm3, %xmm2	# cp, st, tmp608
# C/parallel-only-omp/collisions.h:183:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm6, %xmm10, %xmm0	# ct, cp, tmp609
# C/parallel-only-omp/collisions.h:183:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm7, %xmm0, %xmm0	# sc, tmp609, tmp610
# C/parallel-only-omp/collisions.h:183:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm5, %xmm0, %xmm0	# sincostmp_178, tmp610, tmp611
# C/parallel-only-omp/collisions.h:183:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfmadd231sd	%xmm8, %xmm2, %xmm0	# cc, tmp608, _269
	vmovsd	136(%rsp), %xmm4	#, sincostmp_178
# C/parallel-only-omp/collisions.h:183:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	96(%rsp), %xmm11	# %sfp, sp
# C/parallel-only-omp/collisions.h:182:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm7, %xmm3, %xmm1	# sc, st, tmp606
# C/parallel-only-omp/collisions.h:183:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm11, %xmm7, %xmm2	# sp, sc, tmp612
# C/parallel-only-omp/collisions.h:184:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm3, %xmm11, %xmm3	# st, sp, tmp613
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	104(%rsp), %rdx	# %sfp, _98
# C/parallel-only-omp/collisions.h:182:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm5, %xmm1, %xmm1	# sincostmp_178, tmp606, tmp607
# C/parallel-only-omp/collisions.h:182:     gx = g * (ct * cc - st * sc * ce);
	vfmsub231sd	%xmm8, %xmm6, %xmm1	# cc, ct, _261
# C/parallel-only-omp/collisions.h:186:     (*vx_1) = wx + 0.5 * gx;
	leaq	vx_i(%rip), %rax	#, tmp860
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	168+worker_buffers(%rip), %rdx	# MEM[(struct vector *)&worker_buffers + 168B].D.105978._M_impl.D.105317._M_start, _98
# C/parallel-only-omp/collisions.h:182:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	8(%rsp), %xmm9	# %sfp, g
# C/parallel-only-omp/collisions.h:183:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfnmadd132sd	%xmm4, %xmm0, %xmm2	# sincostmp_178, _269, _273
# C/parallel-only-omp/collisions.h:184:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm6, %xmm11, %xmm0	# ct, sp, tmp614
# C/parallel-only-omp/collisions.h:184:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm7, %xmm0, %xmm0	# sc, tmp614, tmp615
# C/parallel-only-omp/collisions.h:184:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm5, %xmm0, %xmm0	# sincostmp_178, tmp615, tmp616
# C/parallel-only-omp/collisions.h:184:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm8, %xmm0, %xmm3	# cc, tmp616, _280
# C/parallel-only-omp/collisions.h:184:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm10, %xmm7, %xmm0	# cp, sc, tmp617
# C/parallel-only-omp/collisions.h:182:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm9, %xmm1, %xmm1	# g, _261, gx
# C/parallel-only-omp/collisions.h:183:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm9, %xmm2, %xmm2	# g, _273, gy
# C/parallel-only-omp/collisions.h:184:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm0, %xmm3, %xmm4	# tmp617, _280, _283
# C/parallel-only-omp/collisions.h:184:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm9, %xmm4, %xmm0	# g, _283, gz
# C/parallel-only-omp/collisions.h:186:     (*vx_1) = wx + 0.5 * gx;
	vmovsd	.LC45(%rip), %xmm4	#, tmp858
	vfmadd213sd	16(%rsp), %xmm4, %xmm1	# %sfp, tmp858, _286
# C/parallel-only-omp/collisions.h:186:     (*vx_1) = wx + 0.5 * gx;
	vmovsd	%xmm1, (%rax,%r13,8)	# _286, MEM <double[1000000]> [(double *)&vx_i][ki_31]
# C/parallel-only-omp/collisions.h:188:     (*vz_1) = wz + 0.5 * gz;
	leaq	vz_i(%rip), %rax	#, tmp865
# C/parallel-only-omp/collisions.h:187:     (*vy_1) = wy + 0.5 * gy;
	vfmadd213sd	24(%rsp), %xmm4, %xmm2	# %sfp, tmp861, _288
# C/parallel-only-omp/collisions.h:188:     (*vz_1) = wz + 0.5 * gz;
	vfmadd213sd	32(%rsp), %xmm4, %xmm0	# %sfp, tmp863, _290
# C/parallel-only-omp/collisions.h:187:     (*vy_1) = wy + 0.5 * gy;
	vmovsd	%xmm2, (%r14,%r13,8)	# _288, MEM <double[1000000]> [(double *)&vy_i][ki_31]
# C/parallel-only-omp/collisions.h:188:     (*vz_1) = wz + 0.5 * gz;
	vmovsd	%xmm0, (%rax,%r13,8)	# _290, MEM <double[1000000]> [(double *)&vz_i][ki_31]
# C/parallel-only-omp/simulation.h:764:                 worker_buffers.thread_counters[tid].local_coll_i++;
	incq	40(%rdx)	# _98->local_coll_i
# C/parallel-only-omp/simulation.h:744:         for (int i = 0; i < local_N_coll; ++i) {
	cmpl	%r15d, 48(%rsp)	# i, %sfp
	jne	.L1553	#,
.L1591:
	movslq	116(%rsp), %rbx	# %sfp,
	call	GOMP_single_start@PLT	#
	testb	%al, %al	# tmp679
	je	.L1555	#,
	jmp	.L1598	#
	.p2align 4
	.p2align 3
.L1589:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp750
	vmovsd	%xmm2, 56(%rsp)	# __sum, %sfp
	vmovsd	%xmm1, 24(%rsp)	# p_accept, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp468
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r12), %rsi	# MTgen._M_p, _592
	vmovsd	56(%rsp), %xmm2	# %sfp, __sum
	vmovsd	24(%rsp), %xmm1	# %sfp, p_accept
	jmp	.L1532	#
	.p2align 4
	.p2align 3
.L1588:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp743
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp457
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r12), %rdx	# MTgen._M_p, _588
	vmovsd	24(%rsp), %xmm1	# %sfp, p_accept
	jmp	.L1531	#
	.p2align 4
	.p2align 3
.L1522:
# C/parallel-only-omp/simulation.h:776: }
	movq	296(%rsp), %rax	# D.136260, tmp695
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp695
	jne	.L1586	#,
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
.L1580:
	.cfi_restore_state
# C/parallel-only-omp/collisions.h:156:         cp = 1.0;
	movq	.LC10(%rip), %rax	#, tmp781
# C/parallel-only-omp/collisions.h:157:         sp = 0.0;
	movq	$0x000000000, 96(%rsp)	#, %sfp
# C/parallel-only-omp/collisions.h:156:         cp = 1.0;
	movq	%rax, 88(%rsp)	# tmp781, %sfp
	jmp	.L1538	#
	.p2align 4
	.p2align 3
.L1579:
# C/parallel-only-omp/collisions.h:148:         ct = 1.0;
	movq	.LC10(%rip), %rax	#, tmp777
# C/parallel-only-omp/collisions.h:149:         st = 0.0;
	movq	$0x000000000, 80(%rsp)	#, %sfp
# C/parallel-only-omp/collisions.h:148:         ct = 1.0;
	movq	%rax, 72(%rsp)	# tmp777, %sfp
	jmp	.L1536	#
	.p2align 4
	.p2align 3
.L1594:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp792
	vmovsd	%xmm1, 120(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp519
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r12), %rsi	# MTgen._M_p, _534
	vmovsd	120(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1541	#
	.p2align 4
	.p2align 3
.L1593:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp785
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp508
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r12), %rdx	# MTgen._M_p, _530
	jmp	.L1540	#
	.p2align 4
	.p2align 3
.L1597:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp828
	vmovsd	%xmm1, 120(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp584
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r12), %rsi	# MTgen._M_p, _175
	vmovsd	120(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1551	#
	.p2align 4
	.p2align 3
.L1596:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp821
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp573
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r12), %rdx	# MTgen._M_p, _453
	jmp	.L1550	#
	.p2align 4
	.p2align 3
.L1595:
# C/parallel-only-omp/collisions.h:168:         cc = 1.0 - 2.0 * R01(MTgen);              // cos(chi)
	call	_ZTH3R01	#
# C/parallel-only-omp/collisions.h:168:         cc = 1.0 - 2.0 * R01(MTgen);              // cos(chi)
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992(%r12), %rdx	# MTgen._M_p, _472
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rdx	#, _472
	ja	.L1599	#,
.L1545:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rdx), %rsi	#, _476
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r12,%rdx,8), %rdx	# MTgen._M_x[prephitmp_872], __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp807
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp549
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rsi, %fs:4992(%r12)	# _476, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rdi	# __z, tmp544
	shrq	$11, %rdi	#, tmp544
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edi, %edi	# tmp544, _480
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdi, %rdx	# _480, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rdi	# __z, tmp545
	salq	$7, %rdi	#, tmp545
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edi	#, _483
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdi, %rdx	# _483, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rdi	# __z, tmp546
	salq	$15, %rdi	#, tmp546
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edi	#, _486
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdi, %rdx	# _486, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rdi	# __z, _488
	shrq	$18, %rdi	#, _488
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdi, %rdx	# _488, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm3, %xmm1	# __z, tmp807, tmp688
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm0, %xmm1, %xmm1	# tmp549, tmp548, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rsi	#, _476
	ja	.L1600	#,
.L1546:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rsi), %rdx	#, tmp554
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	.LC10(%rip), %xmm6	#, tmp814
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp813
# C/parallel-only-omp/collisions.h:168:         cc = 1.0 - 2.0 * R01(MTgen);              // cos(chi)
	vmovsd	%xmm6, %xmm6, %xmm4	# tmp814, tmp816
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rdx, %fs:4992(%r12)	# tmp554, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:(%r12,%rsi,8), %rdx	# MTgen._M_x[prephitmp_875], __z
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rsi	# __z, tmp556
	shrq	$11, %rsi	#, tmp556
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%esi, %esi	# tmp556, _509
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rsi, %rdx	# _509, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rdx, %rsi	# __z, tmp557
	salq	$7, %rsi	#, tmp557
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %esi	#, _512
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rsi, %rdx	# _512, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rsi	# __z, tmp558
	salq	$15, %rsi	#, tmp558
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %esi	#, _515
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rsi, %rdx	# _515, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rdx, %rsi	# __z, _517
	shrq	$18, %rsi	#, _517
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rsi, %rdx	# _517, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rdx, %xmm5, %xmm0	# __z, tmp813, tmp689
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC163(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC164(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm6, %xmm2	#, __ret, tmp814, tmp665
	vmovsd	.LC168(%rip), %xmm1	#, tmp663
	vblendvpd	%xmm2, %xmm1, %xmm0, %xmm0	# tmp665, tmp663, __ret, __ret
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:0(%rbp), %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _234
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8(%rbp), %xmm1	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm1, %xmm1	# _234, MEM[(const struct param_type *)&R01]._M_b, tmp566
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm1, %xmm2, %xmm0	# tmp566, _234, _237
# C/parallel-only-omp/collisions.h:168:         cc = 1.0 - 2.0 * R01(MTgen);              // cos(chi)
	vfnmadd132sd	.LC165(%rip), %xmm6, %xmm0	#, tmp816, _237
	vmovsd	%xmm0, %xmm0, %xmm6	# _237, cc
	vmovsd	%xmm0, 56(%rsp)	# cc, %sfp
# C/parallel-only-omp/collisions.h:169:         sc = sqrt(std::max(0.0, 1.0 - cc * cc));  // sin(chi)
	vmovsd	%xmm4, %xmm4, %xmm0	# tmp816, _241
	vfnmadd231sd	%xmm6, %xmm6, %xmm0	# cc, cc, _241
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp571
	vcomisd	%xmm1, %xmm0	# tmp571, _241
	jbe	.L1585	#,
# C/parallel-only-omp/collisions.h:169:         sc = sqrt(std::max(0.0, 1.0 - cc * cc));  // sin(chi)
	vsqrtsd	%xmm0, %xmm0, %xmm6	# _241, sc
	vmovsd	%xmm6, 64(%rsp)	# sc, %sfp
	jmp	.L1543	#
	.p2align 4
	.p2align 3
.L1600:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp808
	vmovsd	%xmm1, 56(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp550
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r12), %rsi	# MTgen._M_p, _476
	vmovsd	56(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1546	#
	.p2align 4
	.p2align 3
.L1599:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp802
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp539
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992(%r12), %rdx	# MTgen._M_p, _472
	jmp	.L1545	#
.L1586:
# C/parallel-only-omp/simulation.h:776: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE9886:
