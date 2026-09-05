# Function: step8_collision_ions_body(int, int, int)
# Mangled Symbol: _Z25step8_collision_ions_bodyiii
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._Z25step8_collision_ions_bodyiii,"axG",@progbits,_Z25step8_collision_ions_bodyiii,comdat
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
	