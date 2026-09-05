_Z18collision_electrondPdS_S_iR12NewParticlesS1_:
.LFB9867:
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
	movq	%rdi, %r14	# tmp692, vxe
	pushq	%rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movq	%rsi, %r13	# tmp693, vye
	movq	%rdx, %r12	# tmp694, vze
	subq	$240, %rsp	#,
	.cfi_def_cfa_offset 288
# C/parallel-only-omp/collisions.h:24:     gy = (*vye);
	vmovsd	(%rsi), %xmm2	# *vye_106(D), gy
# C/parallel-only-omp/collisions.h:25:     gz = (*vze);
	vmovsd	(%rdx), %xmm1	# *vze_108(D), gz
# C/parallel-only-omp/collisions.h:23:     gx = (*vxe);
	vmovsd	(%rdi), %xmm3	# *vxe_104(D), gx
# C/parallel-only-omp/collisions.h:14:                                  NewParticles& new_e, NewParticles& new_i) {
	vmovsd	%xmm0, 136(%rsp)	# tmp691, %sfp
# C/parallel-only-omp/collisions.h:26:     double g_perp_sq = gy * gy + gz * gz;
	vmulsd	%xmm1, %xmm1, %xmm0	# gz, gz, tmp414
# C/parallel-only-omp/collisions.h:26:     double g_perp_sq = gy * gy + gz * gz;
	vfmadd231sd	%xmm2, %xmm2, %xmm0	# gy, gy, g_perp_sq
# C/parallel-only-omp/collisions.h:27:     double g_sq      = gx * gx + g_perp_sq;
	vmovsd	%xmm3, %xmm3, %xmm6	# gx, g_sq
# C/parallel-only-omp/collisions.h:14:                                  NewParticles& new_e, NewParticles& new_i) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp716
	movq	%rax, 232(%rsp)	# tmp716, D.135958
	xorl	%eax, %eax	# tmp716
# C/parallel-only-omp/collisions.h:31:     wx = F1 * (*vxe);
	vmovsd	.LC190(%rip), %xmm4	#, tmp415
# C/parallel-only-omp/collisions.h:32:     wy = F1 * (*vye);
	vmulsd	%xmm4, %xmm2, %xmm7	# tmp415, gy, wy
	vmovsd	%xmm7, 80(%rsp)	# wy, %sfp
# C/parallel-only-omp/collisions.h:27:     double g_sq      = gx * gx + g_perp_sq;
	vfmadd132sd	%xmm3, %xmm0, %xmm6	# gx, g_perp_sq, g_sq
# C/parallel-only-omp/collisions.h:29:     double g_perp    = sqrt(g_perp_sq);
	vsqrtsd	%xmm0, %xmm0, %xmm0	# g_perp_sq, g_perp
# C/parallel-only-omp/collisions.h:14:                                  NewParticles& new_e, NewParticles& new_i) {
	movq	%r8, %rbp	# tmp696, new_e
	movq	%r9, %rbx	# tmp697, new_i
# C/parallel-only-omp/collisions.h:28:     g  = sqrt(g_sq);
	vsqrtsd	%xmm6, %xmm6, %xmm5	# g_sq, g
# C/parallel-only-omp/collisions.h:27:     double g_sq      = gx * gx + g_perp_sq;
	vmovsd	%xmm6, 120(%rsp)	# g_sq, %sfp
# C/parallel-only-omp/collisions.h:28:     g  = sqrt(g_sq);
	vmovsd	%xmm5, 64(%rsp)	# g, %sfp
# C/parallel-only-omp/collisions.h:31:     wx = F1 * (*vxe);
	vmulsd	%xmm4, %xmm3, %xmm6	# tmp415, gx, wx
# C/parallel-only-omp/collisions.h:33:     wz = F1 * (*vze);
	vmulsd	%xmm4, %xmm1, %xmm4	# tmp415, gz, wz
# C/parallel-only-omp/collisions.h:31:     wx = F1 * (*vxe);
	vmovsd	%xmm6, 72(%rsp)	# wx, %sfp
# C/parallel-only-omp/collisions.h:33:     wz = F1 * (*vze);
	vmovsd	%xmm4, 88(%rsp)	# wz, %sfp
# C/parallel-only-omp/collisions.h:38:     if (g > 0.0) {
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp418
	vcomisd	%xmm4, %xmm5	# tmp418, g
	jbe	.L1438	#,
# C/parallel-only-omp/collisions.h:39:         ct = gx / g;
	vdivsd	%xmm5, %xmm3, %xmm6	# g, gx, ct
# C/parallel-only-omp/collisions.h:40:         st = g_perp / g;
	vdivsd	%xmm5, %xmm0, %xmm5	# g, g_perp, st
# C/parallel-only-omp/collisions.h:39:         ct = gx / g;
	vmovsd	%xmm6, 24(%rsp)	# ct, %sfp
# C/parallel-only-omp/collisions.h:40:         st = g_perp / g;
	vmovsd	%xmm5, 16(%rsp)	# st, %sfp
	vmovsd	.LC10(%rip), %xmm6	#, tmp674
	vmovsd	%xmm6, 8(%rsp)	# tmp674, %sfp
.L1362:
# C/parallel-only-omp/collisions.h:46:     if (g_perp > 0.0) {
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp419
	vcomisd	%xmm3, %xmm0	# tmp419, g_perp
	jbe	.L1439	#,
# C/parallel-only-omp/collisions.h:47:         cp = gy / g_perp;
	vdivsd	%xmm0, %xmm2, %xmm2	# g_perp, gy, cp
# C/parallel-only-omp/collisions.h:48:         sp = gz / g_perp;
	vdivsd	%xmm0, %xmm1, %xmm5	# g_perp, gz, sp
# C/parallel-only-omp/collisions.h:47:         cp = gy / g_perp;
	vmovsd	%xmm2, 40(%rsp)	# cp, %sfp
# C/parallel-only-omp/collisions.h:48:         sp = gz / g_perp;
	vmovsd	%xmm5, 32(%rsp)	# sp, %sfp
.L1364:
# C/parallel-only-omp/collisions.h:57:     t0   =     sigma[E_ELA][eindex];
	leaq	sigma(%rip), %rax	#, tmp420
	movslq	%ecx, %rcx	# eindex, eindex
	vmovsd	(%rax,%rcx,8), %xmm6	# sigma[0][eindex_123(D)], t0
# C/parallel-only-omp/collisions.h:58:     t1   = t0 +sigma[E_EXC][eindex];
	vaddsd	8000000(%rax,%rcx,8), %xmm6, %xmm7	# sigma[1][eindex_123(D)], t0, t1
# C/parallel-only-omp/collisions.h:57:     t0   =     sigma[E_ELA][eindex];
	vmovsd	%xmm6, 112(%rsp)	# t0, %sfp
# C/parallel-only-omp/collisions.h:59:     t2   = t1 +sigma[E_ION][eindex];
	vaddsd	16000000(%rax,%rcx,8), %xmm7, %xmm4	# sigma[2][eindex_123(D)], t1, t2
# C/parallel-only-omp/collisions.h:58:     t1   = t0 +sigma[E_EXC][eindex];
	vmovsd	%xmm7, 128(%rsp)	# t1, %sfp
# C/parallel-only-omp/collisions.h:59:     t2   = t1 +sigma[E_ION][eindex];
	vmovsd	%xmm4, 48(%rsp)	# t2, %sfp
# C/parallel-only-omp/collisions.h:60:     rnd  = R01(MTgen);
	call	_ZTH3R01	#
# C/parallel-only-omp/collisions.h:60:     rnd  = R01(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_888
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, pretmp_888
	ja	.L1450	#,
.L1366:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rax,8), %rdx	# MTgen._M_x[prephitmp_1024], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rcx	#, prephitmp_910
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp745
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp439
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, %fs:4992+MTgen@tpoff	# prephitmp_910, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rax	# __z, tmp434
	shrq	$11, %rax	#, tmp434
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%eax, %eax	# tmp434, _1019
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp435
	salq	$7, %rdx	#, tmp435
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _1016
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rax, %rdx	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rax	# __z, tmp436
	salq	$15, %rax	#, tmp436
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %eax	#, _1013
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _1011
	shrq	$18, %rdx	#, _1011
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _1011, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm3, %xmm1	# __z, tmp745, tmp706
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm0, %xmm1, %xmm1	# tmp439, tmp438, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, prephitmp_910
	ja	.L1451	#,
.L1367:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rax	#, tmp444
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp751
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, %fs:4992+MTgen@tpoff	# tmp444, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rcx,8), %rax	# MTgen._M_x[prephitmp_910], __z
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	8(%rsp), %xmm7	# %sfp, tmp674
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp446
	shrq	$11, %rdx	#, tmp446
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp446, _290
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _290, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp447
	salq	$7, %rdx	#, tmp447
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _293
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _293, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp448
	salq	$15, %rdx	#, tmp448
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _296
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _296, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _298
	shrq	$18, %rdx	#, _298
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _298, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm0	# __z, tmp751, tmp707
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC163(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC164(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm7, %xmm2	#, __ret, tmp674, tmp678
	vmovsd	.LC168(%rip), %xmm1	#, tmp676
	vblendvpd	%xmm2, %xmm1, %xmm0, %xmm0	# tmp678, tmp676, __ret, __ret
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:R01@tpoff, %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _196
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8+R01@tpoff, %xmm1	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm1, %xmm1	# _196, MEM[(const struct param_type *)&R01]._M_b, tmp456
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm0, %xmm2, %xmm1	# __ret, _196, tmp456
	vmovsd	%xmm1, 56(%rsp)	# tmp456, %sfp
# C/parallel-only-omp/collisions.h:62:     double eta = TWO_PI * R01(MTgen);
	call	_ZTH3R01	#
# C/parallel-only-omp/collisions.h:62:     double eta = TWO_PI * R01(MTgen);
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_913
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, pretmp_913
	ja	.L1452	#,
.L1369:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rax,8), %rdx	# MTgen._M_x[prephitmp_1058], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rcx	#, prephitmp_935
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp759
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp469
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, %fs:4992+MTgen@tpoff	# prephitmp_935, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rax	# __z, tmp464
	shrq	$11, %rax	#, tmp464
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%eax, %eax	# tmp464, _1053
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp465
	salq	$7, %rdx	#, tmp465
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _1050
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rax, %rdx	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rax	# __z, tmp466
	salq	$15, %rax	#, tmp466
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %eax	#, _1047
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _1045
	shrq	$18, %rdx	#, _1045
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _1045, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm3, %xmm0	# __z, tmp759, tmp708
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm1, %xmm0, %xmm0	# tmp469, tmp468, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, prephitmp_935
	ja	.L1453	#,
.L1370:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rax	#, tmp474
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp765
	leaq	184(%rsp), %rdi	#, tmp488
	leaq	176(%rsp), %rsi	#, tmp489
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, %fs:4992+MTgen@tpoff	# tmp474, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rcx,8), %rax	# MTgen._M_x[prephitmp_935], __z
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	8(%rsp), %xmm5	# %sfp, tmp674
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp476
	shrq	$11, %rdx	#, tmp476
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp476, _305
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _305, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp477
	salq	$7, %rdx	#, tmp477
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _308
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _308, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp478
	salq	$15, %rdx	#, tmp478
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _311
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _311, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _313
	shrq	$18, %rdx	#, _313
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _313, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm4, %xmm1	# __z, tmp765, tmp709
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC163(%rip), %xmm0, %xmm1	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC164(%rip), %xmm1, %xmm1	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm1, %xmm5, %xmm2	#, __ret, tmp674, tmp681
	vmovsd	.LC168(%rip), %xmm0	#, tmp679
	vblendvpd	%xmm2, %xmm0, %xmm1, %xmm1	# tmp681, tmp679, __ret, __ret
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:R01@tpoff, %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _173
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8+R01@tpoff, %xmm0	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm0, %xmm0	# _173, MEM[(const struct param_type *)&R01]._M_b, tmp486
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm1, %xmm2, %xmm0	# __ret, _173, _193
# C/parallel-only-omp/collisions.h:62:     double eta = TWO_PI * R01(MTgen);
	vmulsd	.LC191(%rip), %xmm0, %xmm0	#, _193, eta
	call	sincos@PLT	#
	vmovsd	176(%rsp), %xmm6	#, sincostmp_1167
	vmovsd	184(%rsp), %xmm3	#, se
# C/parallel-only-omp/collisions.h:66:     if (rnd < (t0 / t2)) {                              // Zderzenie sprężyste (izotropowe)
	vmovsd	112(%rsp), %xmm4	# %sfp, t0
	vmovsd	%xmm6, 104(%rsp)	# sincostmp_1167, %sfp
	vdivsd	48(%rsp), %xmm4, %xmm0	# %sfp, t0, tmp492
	vmovsd	%xmm3, 96(%rsp)	# se, %sfp
# C/parallel-only-omp/collisions.h:66:     if (rnd < (t0 / t2)) {                              // Zderzenie sprężyste (izotropowe)
	vcomisd	56(%rsp), %xmm0	# %sfp, tmp492
	ja	.L1454	#,
# C/parallel-only-omp/collisions.h:70:         energy = 0.5 * E_MASS * g_sq;
	vmovsd	120(%rsp), %xmm6	# %sfp, g_sq
	vmulsd	.LC61(%rip), %xmm6, %xmm0	#, g_sq, _1188
# C/parallel-only-omp/collisions.h:69:     } else if (rnd < (t1 / t2)) {                       // Wzbudzenie (niesprężyste, izotropowe)
	vmovsd	128(%rsp), %xmm6	# %sfp, t1
	vdivsd	48(%rsp), %xmm6, %xmm1	# %sfp, t1, tmp528
# C/parallel-only-omp/collisions.h:69:     } else if (rnd < (t1 / t2)) {                       // Wzbudzenie (niesprężyste, izotropowe)
	vcomisd	56(%rsp), %xmm1	# %sfp, tmp528
	ja	.L1455	#,
# C/parallel-only-omp/collisions.h:77:         energy = fabs(energy - E_ION_TH * EV_TO_J);
	vsubsd	.LC193(%rip), %xmm0, %xmm0	#, _1188, tmp570
# C/parallel-only-omp/collisions.h:77:         energy = fabs(energy - E_ION_TH * EV_TO_J);
	vandpd	.LC18(%rip), %xmm0, %xmm2	#, tmp570, energy
	vmovsd	%xmm2, 48(%rsp)	# energy, %sfp
# C/parallel-only-omp/collisions.h:80:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy / EV_TO_J / 20.0)) * EV_TO_J;
	call	_ZTH3R01	#
# C/parallel-only-omp/collisions.h:80:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy / EV_TO_J / 20.0)) * EV_TO_J;
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_944
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, pretmp_944
	ja	.L1456	#,
.L1387:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rax,8), %rdx	# MTgen._M_x[prephitmp_1090], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rcx	#, prephitmp_966
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm7, %xmm7, %xmm7	# tmp829
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp584
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, %fs:4992+MTgen@tpoff	# prephitmp_966, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rax	# __z, tmp579
	shrq	$11, %rax	#, tmp579
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%eax, %eax	# tmp579, _1085
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp580
	salq	$7, %rdx	#, tmp580
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _1082
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rax, %rdx	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rax	# __z, tmp581
	salq	$15, %rax	#, tmp581
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %eax	#, _1079
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _1077
	shrq	$18, %rdx	#, _1077
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _1077, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm7, %xmm1	# __z, tmp829, tmp714
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm0, %xmm1, %xmm1	# tmp584, tmp583, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, prephitmp_966
	ja	.L1457	#,
.L1388:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rax	#, tmp589
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp835
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, %fs:4992+MTgen@tpoff	# tmp589, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rcx,8), %rax	# MTgen._M_x[prephitmp_966], __z
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	8(%rsp), %xmm6	# %sfp, tmp674
# C/parallel-only-omp/collisions.h:80:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy / EV_TO_J / 20.0)) * EV_TO_J;
	vmovsd	48(%rsp), %xmm4	# %sfp, energy
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp591
	shrq	$11, %rdx	#, tmp591
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp591, _404
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _404, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp592
	salq	$7, %rdx	#, tmp592
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _407
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _407, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp593
	salq	$15, %rdx	#, tmp593
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _410
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _410, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _412
	shrq	$18, %rdx	#, _412
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _412, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm5, %xmm0	# __z, tmp835, tmp715
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC163(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC164(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm6, %xmm2	#, __ret, tmp674, tmp690
	vmovsd	.LC168(%rip), %xmm1	#, tmp688
	vblendvpd	%xmm2, %xmm1, %xmm0, %xmm0	# tmp690, tmp688, __ret, __ret
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:R01@tpoff, %xmm2	# MEM[(const struct param_type *)&R01]._M_a, _221
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8+R01@tpoff, %xmm1	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm2, %xmm1, %xmm1	# _221, MEM[(const struct param_type *)&R01]._M_b, tmp601
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm0, %xmm2, %xmm1	# __ret, _221, tmp601
# C/parallel-only-omp/collisions.h:80:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy / EV_TO_J / 20.0)) * EV_TO_J;
	vdivsd	.LC50(%rip), %xmm4, %xmm0	#, energy, tmp603
# C/parallel-only-omp/collisions.h:80:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy / EV_TO_J / 20.0)) * EV_TO_J;
	vdivsd	.LC194(%rip), %xmm0, %xmm0	#, tmp603, tmp605
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%xmm1, 56(%rsp)	# tmp601, %sfp
# C/parallel-only-omp/collisions.h:80:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy / EV_TO_J / 20.0)) * EV_TO_J;
	call	atan@PLT	#
# C/parallel-only-omp/collisions.h:80:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy / EV_TO_J / 20.0)) * EV_TO_J;
	vmulsd	56(%rsp), %xmm0, %xmm0	# %sfp, tmp698, tmp607
	call	tan@PLT	#
# C/parallel-only-omp/collisions.h:81:         e_sc = fabs(energy - e_ej);
	vmovsd	48(%rsp), %xmm4	# %sfp, energy
# C/parallel-only-omp/collisions.h:80:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy / EV_TO_J / 20.0)) * EV_TO_J;
	vmulsd	.LC15(%rip), %xmm0, %xmm3	#, tmp699, tmp608
# C/parallel-only-omp/collisions.h:80:         e_ej = 10.0 * tan(R01(MTgen) * atan(energy / EV_TO_J / 20.0)) * EV_TO_J;
	vmulsd	.LC50(%rip), %xmm3, %xmm3	#, tmp608, e_ej
# C/parallel-only-omp/collisions.h:81:         e_sc = fabs(energy - e_ej);
	vsubsd	%xmm3, %xmm4, %xmm2	# e_ej, energy, tmp611
# C/parallel-only-omp/collisions.h:81:         e_sc = fabs(energy - e_ej);
	vandpd	.LC18(%rip), %xmm2, %xmm2	#, tmp611, e_sc
# C/parallel-only-omp/collisions.h:83:         g    = sqrt(2.0 * e_sc / E_MASS);
	vmovsd	.LC51(%rip), %xmm1	#, tmp615
# C/parallel-only-omp/collisions.h:84:         g2   = sqrt(2.0 * e_ej / E_MASS);
	vaddsd	%xmm3, %xmm3, %xmm6	# e_ej, e_ej, tmp616
# C/parallel-only-omp/collisions.h:84:         g2   = sqrt(2.0 * e_ej / E_MASS);
	vdivsd	%xmm1, %xmm6, %xmm6	# tmp615, tmp616, _30
# C/parallel-only-omp/collisions.h:83:         g    = sqrt(2.0 * e_sc / E_MASS);
	vaddsd	%xmm2, %xmm2, %xmm0	# e_sc, e_sc, tmp613
# C/parallel-only-omp/collisions.h:83:         g    = sqrt(2.0 * e_sc / E_MASS);
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp615, tmp613, tmp614
	vsqrtsd	%xmm0, %xmm0, %xmm7	# tmp614, g
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp618
	vmovsd	%xmm7, 64(%rsp)	# g, %sfp
	vucomisd	%xmm6, %xmm0	# _30, tmp618
	ja	.L1444	#,
# C/parallel-only-omp/collisions.h:84:         g2   = sqrt(2.0 * e_ej / E_MASS);
	vsqrtsd	%xmm6, %xmm6, %xmm6	# _30, g2
# C/parallel-only-omp/collisions.h:86:         cc   = sqrt(e_sc / energy);                     // cos(chi) dla elektronu rozproszonego
	vdivsd	%xmm4, %xmm2, %xmm2	# energy, e_sc, _319
.L1392:
	vsqrtsd	%xmm2, %xmm2, %xmm2	# _319, cc
# C/parallel-only-omp/collisions.h:87:         sc   = sqrt(std::max(0.0, 1.0 - cc * cc));      // sin(chi)
	vmovsd	8(%rsp), %xmm1	# %sfp, _33
	vfnmadd231sd	%xmm2, %xmm2, %xmm1	# cc, cc, _33
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp620
	vcomisd	%xmm0, %xmm1	# tmp620, _33
	ja	.L1458	#,
	vxorpd	%xmm1, %xmm1, %xmm1	# sc
.L1393:
# C/parallel-only-omp/collisions.h:89:         double cc2 = sqrt(e_ej / energy);               // cos(chi2) dla elektronu wybitego
	vdivsd	48(%rsp), %xmm3, %xmm0	# %sfp, e_ej, _35
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp621
	vucomisd	%xmm0, %xmm3	# _35, tmp621
	ja	.L1446	#,
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _35, cc2
.L1397:
# C/parallel-only-omp/collisions.h:90:         double sc2 = sqrt(std::max(0.0, 1.0 - cc2 * cc2)); // sin(chi2)
	vmovsd	8(%rsp), %xmm3	# %sfp, tmp674
	vfnmadd231sd	%xmm0, %xmm0, %xmm3	# cc2, cc2, tmp674
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp623
	vcomisd	%xmm4, %xmm3	# tmp623, _37
	ja	.L1459	#,
	vxorpd	%xmm3, %xmm3, %xmm3	# _1033
.L1398:
# C/parallel-only-omp/collisions.h:94:         double ce2 = -ce;
	vmovsd	104(%rsp), %xmm7	# %sfp, sincostmp_1167
	vxorpd	.LC31(%rip), %xmm7, %xmm12	#, sincostmp_1167, ce2
# C/parallel-only-omp/collisions.h:96:         double gx2 = g2 * (ct * cc2 - st * sc2 * ce2);
	vmovsd	24(%rsp), %xmm11	# %sfp, ct
# C/parallel-only-omp/collisions.h:96:         double gx2 = g2 * (ct * cc2 - st * sc2 * ce2);
	vmovsd	16(%rsp), %xmm15	# %sfp, st
	vmulsd	%xmm15, %xmm3, %xmm4	# st, _1033, tmp625
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmovsd	40(%rsp), %xmm14	# %sfp, cp
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm11, %xmm14, %xmm5	# ct, cp, _45
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm14, %xmm15, %xmm7	# cp, st, _43
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmovsd	32(%rsp), %xmm10	# %sfp, sp
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmovsd	96(%rsp), %xmm13	# %sfp, se
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm10, %xmm3, %xmm9	# sp, _1033, tmp629
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	movq	8(%rbp), %rsi	# MEM[(struct vector *)new_e_161(D)].D.58646._M_impl.D.57959._M_finish, _434
# C/parallel-only-omp/collisions.h:96:         double gx2 = g2 * (ct * cc2 - st * sc2 * ce2);
	vmulsd	%xmm12, %xmm4, %xmm4	# ce2, tmp625, tmp626
# C/parallel-only-omp/collisions.h:96:         double gx2 = g2 * (ct * cc2 - st * sc2 * ce2);
	vfmsub231sd	%xmm11, %xmm0, %xmm4	# ct, cc2, _42
# C/parallel-only-omp/collisions.h:96:         double gx2 = g2 * (ct * cc2 - st * sc2 * ce2);
	vmulsd	%xmm6, %xmm4, %xmm8	# g2, _42, gx2
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm3, %xmm5, %xmm4	# _1033, _45, tmp627
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm12, %xmm4, %xmm4	# ce2, tmp627, tmp628
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vfmadd231sd	%xmm0, %xmm7, %xmm4	# cc2, _43, _48
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vfmadd132sd	%xmm13, %xmm4, %xmm9	# se, _48, _51
# C/parallel-only-omp/collisions.h:98:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmovsd	%xmm10, %xmm10, %xmm4	# sp, sp
	vmulsd	%xmm15, %xmm10, %xmm10	# st, sp, _52
# C/parallel-only-omp/collisions.h:98:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm11, %xmm4, %xmm4	# ct, sp, _54
# C/parallel-only-omp/collisions.h:98:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm3, %xmm4, %xmm11	# _1033, _54, tmp630
# C/parallel-only-omp/collisions.h:98:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm12, %xmm11, %xmm11	# ce2, tmp630, tmp631
# C/parallel-only-omp/collisions.h:98:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vfmadd132sd	%xmm10, %xmm11, %xmm0	# _52, tmp631, _57
# C/parallel-only-omp/collisions.h:98:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm14, %xmm3, %xmm3	# cp, _1033, tmp632
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm6, %xmm9, %xmm9	# g2, _51, gy2
# C/parallel-only-omp/collisions.h:98:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vfnmadd231sd	%xmm13, %xmm3, %xmm0	# se, tmp632, _60
	vmovsd	136(%rsp), %xmm3	# %sfp, xe
	vmovsd	%xmm3, 200(%rsp)	# xe, MEM[(double *)_889]
# C/parallel-only-omp/collisions.h:98:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm6, %xmm0, %xmm0	# g2, _60, gz2
# C/parallel-only-omp/collisions.h:101:         new_e.push(xe, wx + F2 * gx2, wy + F2 * gy2, wz + F2 * gz2);
	vmovsd	.LC195(%rip), %xmm6	#, tmp671
	vfmadd213sd	88(%rsp), %xmm6, %xmm0	# %sfp, tmp671, _62
	vfmadd213sd	80(%rsp), %xmm6, %xmm9	# %sfp, tmp671, _64
	vfmadd213sd	72(%rsp), %xmm6, %xmm8	# %sfp, tmp671, _66
	vmovsd	%xmm9, 216(%rsp)	# _64, MEM[(double *)_551]
	vmovsd	%xmm8, 208(%rsp)	# _66, MEM[(double *)_914]
	vmovsd	%xmm0, 224(%rsp)	# _62, MEM[(double *)_553]
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	16(%rbp), %rsi	# MEM[(struct vector *)new_e_161(D)].D.58646._M_impl.D.57959._M_end_of_storage, _434
	je	.L1400	#,
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovsd	%xmm3, (%rsi)	# xe, *_434
# /usr/include/c++/13/bits/stl_vector.h:1288: 	    ++this->_M_impl._M_finish;
	addq	$8, %rsi	#, tmp637
	movq	%rsi, 8(%rbp)	# tmp637, MEM[(struct vector *)new_e_161(D)].D.58646._M_impl.D.57959._M_finish
.L1401:
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	movq	32(%rbp), %rsi	# MEM[(struct vector *)new_e_161(D) + 24B].D.58646._M_impl.D.57959._M_finish, _430
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	40(%rbp), %rsi	# MEM[(struct vector *)new_e_161(D) + 24B].D.58646._M_impl.D.57959._M_end_of_storage, _430
	je	.L1402	#,
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovsd	%xmm8, (%rsi)	# _66, *_430
# /usr/include/c++/13/bits/stl_vector.h:1288: 	    ++this->_M_impl._M_finish;
	addq	$8, %rsi	#, tmp639
	movq	%rsi, 32(%rbp)	# tmp639, MEM[(struct vector *)new_e_161(D) + 24B].D.58646._M_impl.D.57959._M_finish
.L1403:
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	movq	56(%rbp), %rsi	# MEM[(struct vector *)new_e_161(D) + 48B].D.58646._M_impl.D.57959._M_finish, _426
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	64(%rbp), %rsi	# MEM[(struct vector *)new_e_161(D) + 48B].D.58646._M_impl.D.57959._M_end_of_storage, _426
	je	.L1404	#,
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovsd	%xmm9, (%rsi)	# _64, *_426
# /usr/include/c++/13/bits/stl_vector.h:1288: 	    ++this->_M_impl._M_finish;
	addq	$8, %rsi	#, tmp642
	movq	%rsi, 56(%rbp)	# tmp642, MEM[(struct vector *)new_e_161(D) + 48B].D.58646._M_impl.D.57959._M_finish
.L1405:
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	movq	80(%rbp), %rsi	# MEM[(struct vector *)new_e_161(D) + 72B].D.58646._M_impl.D.57959._M_finish, _422
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	88(%rbp), %rsi	# MEM[(struct vector *)new_e_161(D) + 72B].D.58646._M_impl.D.57959._M_end_of_storage, _422
	je	.L1406	#,
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovsd	%xmm0, (%rsi)	# _62, *_422
# /usr/include/c++/13/bits/stl_vector.h:1288: 	    ++this->_M_impl._M_finish;
	addq	$8, %rsi	#, tmp645
	movq	%rsi, 80(%rbp)	# tmp645, MEM[(struct vector *)new_e_161(D) + 72B].D.58646._M_impl.D.57959._M_finish
.L1407:
	vmovsd	%xmm6, 160(%rsp)	# tmp671, %sfp
	vmovsd	%xmm2, 152(%rsp)	# cc, %sfp
	vmovsd	%xmm1, 144(%rsp)	# sc, %sfp
	vmovsd	%xmm4, 128(%rsp)	# _54, %sfp
	vmovsd	%xmm10, 120(%rsp)	# _52, %sfp
	vmovsd	%xmm5, 112(%rsp)	# _45, %sfp
	vmovsd	%xmm7, 56(%rsp)	# _43, %sfp
# C/parallel-only-omp/collisions.h:102:         new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
	call	_ZTH3RMB	#
# C/parallel-only-omp/collisions.h:102:         new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0	#
	vmovsd	%xmm0, 48(%rsp)	# tmp702, %sfp
# C/parallel-only-omp/collisions.h:102:         new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
	call	_ZTH3RMB	#
# C/parallel-only-omp/collisions.h:102:         new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0	#
	vmovsd	%xmm0, 8(%rsp)	# tmp703, %sfp
# C/parallel-only-omp/collisions.h:102:         new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
	call	_ZTH3RMB	#
# C/parallel-only-omp/collisions.h:102:         new_i.push(xe, RMB(MTgen), RMB(MTgen), RMB(MTgen));
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.h:2137: 	{ return this->operator()(__urng, _M_param); }
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_RKNS0_10param_typeE.constprop.0	#
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	movq	8(%rbx), %rsi	# MEM[(struct vector *)new_i_164(D)].D.58646._M_impl.D.57959._M_finish, _450
	vmovsd	8(%rsp), %xmm2	# %sfp, _215
	vmovsd	136(%rsp), %xmm3	# %sfp, xe
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	16(%rbx), %rsi	# MEM[(struct vector *)new_i_164(D)].D.58646._M_impl.D.57959._M_end_of_storage, _450
	vmovsd	%xmm2, 216(%rsp)	# _215, MEM[(double *)_551]
	vmovsd	%xmm3, 200(%rsp)	# xe, MEM[(double *)_889]
	vmovsd	48(%rsp), %xmm2	# %sfp, _216
	vmovsd	%xmm0, 208(%rsp)	# _214, MEM[(double *)_914]
	vmovsd	%xmm2, 224(%rsp)	# _216, MEM[(double *)_553]
	vmovsd	56(%rsp), %xmm7	# %sfp, _43
	vmovsd	112(%rsp), %xmm5	# %sfp, _45
	vmovsd	120(%rsp), %xmm10	# %sfp, _52
	vmovsd	128(%rsp), %xmm4	# %sfp, _54
	vmovsd	144(%rsp), %xmm1	# %sfp, sc
	vmovsd	152(%rsp), %xmm2	# %sfp, cc
	vmovsd	160(%rsp), %xmm6	# %sfp, tmp671
	je	.L1408	#,
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovsd	%xmm3, (%rsi)	# xe, *_450
# /usr/include/c++/13/bits/stl_vector.h:1288: 	    ++this->_M_impl._M_finish;
	addq	$8, %rsi	#, tmp648
	movq	%rsi, 8(%rbx)	# tmp648, MEM[(struct vector *)new_i_164(D)].D.58646._M_impl.D.57959._M_finish
.L1409:
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	movq	32(%rbx), %rsi	# MEM[(struct vector *)new_i_164(D) + 24B].D.58646._M_impl.D.57959._M_finish, _446
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	40(%rbx), %rsi	# MEM[(struct vector *)new_i_164(D) + 24B].D.58646._M_impl.D.57959._M_end_of_storage, _446
	je	.L1410	#,
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovsd	%xmm0, (%rsi)	# _214, *_446
# /usr/include/c++/13/bits/stl_vector.h:1288: 	    ++this->_M_impl._M_finish;
	addq	$8, %rsi	#, tmp650
	movq	%rsi, 32(%rbx)	# tmp650, MEM[(struct vector *)new_i_164(D) + 24B].D.58646._M_impl.D.57959._M_finish
.L1411:
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	movq	56(%rbx), %rsi	# MEM[(struct vector *)new_i_164(D) + 48B].D.58646._M_impl.D.57959._M_finish, _442
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	64(%rbx), %rsi	# MEM[(struct vector *)new_i_164(D) + 48B].D.58646._M_impl.D.57959._M_end_of_storage, _442
	je	.L1412	#,
# /usr/include/c++/13/bits/stl_vector.h:1288: 	    ++this->_M_impl._M_finish;
	addq	$8, %rsi	#, tmp653
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovsd	8(%rsp), %xmm3	# %sfp, _215
	vmovsd	%xmm3, -8(%rsi)	# _215, *_442
# /usr/include/c++/13/bits/stl_vector.h:1288: 	    ++this->_M_impl._M_finish;
	movq	%rsi, 56(%rbx)	# tmp653, MEM[(struct vector *)new_i_164(D) + 48B].D.58646._M_impl.D.57959._M_finish
.L1413:
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	movq	80(%rbx), %rsi	# MEM[(struct vector *)new_i_164(D) + 72B].D.58646._M_impl.D.57959._M_finish, _438
# /usr/include/c++/13/bits/stl_vector.h:1283: 	if (this->_M_impl._M_finish != this->_M_impl._M_end_of_storage)
	cmpq	88(%rbx), %rsi	# MEM[(struct vector *)new_i_164(D) + 72B].D.58646._M_impl.D.57959._M_end_of_storage, _438
	je	.L1414	#,
# /usr/include/c++/13/bits/stl_vector.h:1288: 	    ++this->_M_impl._M_finish;
	addq	$8, %rsi	#, tmp656
# /usr/include/c++/13/bits/new_allocator.h:191: 	{ ::new((void *)__p) _Up(std::forward<_Args>(__args)...); }
	vmovsd	48(%rsp), %xmm3	# %sfp, _216
	vmovsd	%xmm3, -8(%rsi)	# _216, *_438
# /usr/include/c++/13/bits/stl_vector.h:1288: 	    ++this->_M_impl._M_finish;
	movq	%rsi, 80(%rbx)	# tmp656, MEM[(struct vector *)new_i_164(D) + 72B].D.58646._M_impl.D.57959._M_finish
.L1379:
# C/parallel-only-omp/collisions.h:108:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	104(%rsp), %xmm13	# %sfp, sincostmp_1167
# C/parallel-only-omp/collisions.h:108:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	16(%rsp), %xmm1, %xmm0	# %sfp, sc, tmp659
# C/parallel-only-omp/collisions.h:109:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm5, %xmm1, %xmm5	# _45, sc, tmp661
# C/parallel-only-omp/collisions.h:108:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm13, %xmm0, %xmm0	# sincostmp_1167, tmp659, tmp660
# C/parallel-only-omp/collisions.h:109:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm13, %xmm5, %xmm5	# sincostmp_1167, tmp661, tmp662
# C/parallel-only-omp/collisions.h:110:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm4, %xmm1, %xmm4	# _54, sc, tmp664
# C/parallel-only-omp/collisions.h:109:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfmadd132sd	%xmm2, %xmm5, %xmm7	# cc, tmp662, _76
# C/parallel-only-omp/collisions.h:108:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	24(%rsp), %xmm3	# %sfp, ct
# C/parallel-only-omp/collisions.h:110:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm13, %xmm4, %xmm4	# sincostmp_1167, tmp664, tmp665
# C/parallel-only-omp/collisions.h:108:     gx = g * (ct * cc - st * sc * ce);
	vfmsub132sd	%xmm2, %xmm0, %xmm3	# cc, tmp660, ct
# C/parallel-only-omp/collisions.h:109:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	96(%rsp), %xmm5	# %sfp, se
# C/parallel-only-omp/collisions.h:109:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	32(%rsp), %xmm1, %xmm0	# %sfp, sc, tmp663
# C/parallel-only-omp/collisions.h:110:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm10, %xmm4, %xmm2	# _52, tmp665, _85
# C/parallel-only-omp/collisions.h:110:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	40(%rsp), %xmm1, %xmm1	# %sfp, sc, tmp666
# C/parallel-only-omp/collisions.h:108:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	64(%rsp), %xmm14	# %sfp, g
# C/parallel-only-omp/collisions.h:109:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfnmadd132sd	%xmm5, %xmm7, %xmm0	# se, _76, _79
# C/parallel-only-omp/collisions.h:108:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm14, %xmm3, %xmm3	# g, _70, gx
# C/parallel-only-omp/collisions.h:112:     (*vxe) = wx + F2 * gx;
	vfmadd213sd	72(%rsp), %xmm6, %xmm3	# %sfp, tmp671, _90
# C/parallel-only-omp/collisions.h:112:     (*vxe) = wx + F2 * gx;
	vmovsd	%xmm3, (%r14)	# _90, *vxe_104(D)
# C/parallel-only-omp/collisions.h:110:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm5, %xmm2, %xmm1	# se, _85, _88
# C/parallel-only-omp/collisions.h:109:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm14, %xmm0, %xmm0	# g, _79, gy
# C/parallel-only-omp/collisions.h:113:     (*vye) = wy + F2 * gy;
	vfmadd213sd	80(%rsp), %xmm6, %xmm0	# %sfp, tmp671, _92
# C/parallel-only-omp/collisions.h:113:     (*vye) = wy + F2 * gy;
	vmovsd	%xmm0, 0(%r13)	# _92, *vye_106(D)
# C/parallel-only-omp/collisions.h:110:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm14, %xmm1, %xmm1	# g, _88, gz
# C/parallel-only-omp/collisions.h:114:     (*vze) = wz + F2 * gz;
	vfmadd213sd	88(%rsp), %xmm6, %xmm1	# %sfp, tmp671, _94
# C/parallel-only-omp/collisions.h:114:     (*vze) = wz + F2 * gz;
	vmovsd	%xmm1, (%r12)	# _94, *vze_108(D)
# C/parallel-only-omp/collisions.h:115: }
	movq	232(%rsp), %rax	# D.135958, tmp717
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp717
	jne	.L1460	#,
	addq	$240, %rsp	#,
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
.L1455:
	.cfi_restore_state
# C/parallel-only-omp/collisions.h:71:         energy = fabs(energy - E_EXC_TH * EV_TO_J);
	vsubsd	.LC192(%rip), %xmm0, %xmm0	#, _1188, tmp529
# C/parallel-only-omp/collisions.h:71:         energy = fabs(energy - E_EXC_TH * EV_TO_J);
	vandpd	.LC18(%rip), %xmm0, %xmm0	#, tmp529, energy
# C/parallel-only-omp/collisions.h:72:         g   = sqrt(2.0 * energy / E_MASS);
	vaddsd	%xmm0, %xmm0, %xmm0	# energy, energy, tmp533
# C/parallel-only-omp/collisions.h:72:         g   = sqrt(2.0 * energy / E_MASS);
	vdivsd	.LC51(%rip), %xmm0, %xmm0	#, tmp533, tmp534
	vsqrtsd	%xmm0, %xmm0, %xmm2	# tmp534, g
	vmovsd	%xmm2, 64(%rsp)	# g, %sfp
# C/parallel-only-omp/collisions.h:73:         cc  = 1.0 - 2.0 * R01(MTgen);                   // cos(chi)
	call	_ZTH3R01	#
# C/parallel-only-omp/collisions.h:73:         cc  = 1.0 - 2.0 * R01(MTgen);                   // cos(chi)
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_1042
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, pretmp_1042
	ja	.L1461	#,
.L1382:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rax,8), %rdx	# MTgen._M_x[prephitmp_1124], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rcx	#, prephitmp_1064
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp805
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp547
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, %fs:4992+MTgen@tpoff	# prephitmp_1064, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rax	# __z, tmp542
	shrq	$11, %rax	#, tmp542
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%eax, %eax	# tmp542, _1119
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp543
	salq	$7, %rdx	#, tmp543
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _1116
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rax, %rdx	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rax	# __z, tmp544
	salq	$15, %rax	#, tmp544
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %eax	#, _1113
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _1111
	shrq	$18, %rdx	#, _1111
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _1111, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm2, %xmm1	# __z, tmp805, tmp712
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm0, %xmm1, %xmm1	# tmp547, tmp546, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, prephitmp_1064
	ja	.L1462	#,
.L1383:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rax	#, tmp552
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm5, %xmm5, %xmm5	# tmp811
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, %fs:4992+MTgen@tpoff	# tmp552, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rcx,8), %rax	# MTgen._M_x[prephitmp_1064], __z
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	8(%rsp), %xmm7	# %sfp, tmp674
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp554
	shrq	$11, %rdx	#, tmp554
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp554, _371
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _371, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp555
	salq	$7, %rdx	#, tmp555
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _374
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _374, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp556
	salq	$15, %rdx	#, tmp556
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _377
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _377, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _379
	shrq	$18, %rdx	#, _379
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _379, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm5, %xmm0	# __z, tmp811, tmp713
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC163(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC164(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm7, %xmm2	#, __ret, tmp674, tmp687
	vmovsd	.LC168(%rip), %xmm1	#, tmp685
	vblendvpd	%xmm2, %xmm1, %xmm0, %xmm0	# tmp687, tmp685, __ret, __ret
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:R01@tpoff, %xmm1	# MEM[(const struct param_type *)&R01]._M_a, _210
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8+R01@tpoff, %xmm2	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm1, %xmm2, %xmm2	# _210, MEM[(const struct param_type *)&R01]._M_b, tmp564
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm0, %xmm1, %xmm2	# __ret, _210, _213
# C/parallel-only-omp/collisions.h:73:         cc  = 1.0 - 2.0 * R01(MTgen);                   // cos(chi)
	vfnmadd132sd	.LC165(%rip), %xmm7, %xmm2	#, tmp674, cc
# C/parallel-only-omp/collisions.h:74:         sc  = sqrt(std::max(0.0, 1.0 - cc * cc));       // sin(chi)
	vfnmadd231sd	%xmm2, %xmm2, %xmm7	# cc, cc, tmp674
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp569
# C/parallel-only-omp/collisions.h:74:         sc  = sqrt(std::max(0.0, 1.0 - cc * cc));       // sin(chi)
	vmovsd	%xmm7, %xmm7, %xmm1	# tmp674, _17
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vcomisd	%xmm0, %xmm7	# tmp569, _17
	ja	.L1463	#,
	vxorpd	%xmm1, %xmm1, %xmm1	# sc
.L1385:
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmovsd	16(%rsp), %xmm6	# %sfp, st
	vmovsd	40(%rsp), %xmm3	# %sfp, cp
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmovsd	24(%rsp), %xmm4	# %sfp, ct
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm3, %xmm6, %xmm7	# cp, st, _43
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm4, %xmm3, %xmm5	# ct, cp, _45
# C/parallel-only-omp/collisions.h:98:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmovsd	32(%rsp), %xmm3	# %sfp, sp
	vmulsd	%xmm3, %xmm6, %xmm10	# sp, st, _52
# C/parallel-only-omp/collisions.h:98:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm4, %xmm3, %xmm4	# ct, sp, _54
	vmovsd	.LC195(%rip), %xmm6	#, tmp671
	jmp	.L1379	#
	.p2align 4
	.p2align 3
.L1439:
# C/parallel-only-omp/collisions.h:50:         cp = 1.0;
	vmovsd	8(%rsp), %xmm2	# %sfp, tmp674
# C/parallel-only-omp/collisions.h:51:         sp = 0.0;
	movq	$0x000000000, 32(%rsp)	#, %sfp
# C/parallel-only-omp/collisions.h:50:         cp = 1.0;
	vmovsd	%xmm2, 40(%rsp)	# tmp674, %sfp
	jmp	.L1364	#
	.p2align 4
	.p2align 3
.L1438:
# C/parallel-only-omp/collisions.h:42:         ct = 1.0;
	vmovsd	.LC10(%rip), %xmm3	#, tmp674
# C/parallel-only-omp/collisions.h:43:         st = 0.0;
	movq	$0x000000000, 16(%rsp)	#, %sfp
# C/parallel-only-omp/collisions.h:42:         ct = 1.0;
	vmovsd	%xmm3, 8(%rsp)	# tmp674, %sfp
	vmovsd	%xmm3, 24(%rsp)	# tmp674, %sfp
	jmp	.L1362	#
	.p2align 4
	.p2align 3
.L1454:
# C/parallel-only-omp/collisions.h:67:         cc = 1.0 - 2.0 * R01(MTgen);                    // cos(chi)
	call	_ZTH3R01	#
# C/parallel-only-omp/collisions.h:67:         cc = 1.0 - 2.0 * R01(MTgen);                    // cos(chi)
	call	_ZTH5MTgen	#
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_1109
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rax	#, pretmp_1109
	ja	.L1464	#,
.L1374:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rax,8), %rdx	# MTgen._M_x[prephitmp_1156], __z
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rax), %rcx	#, prephitmp_1131
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp777
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp504
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rcx, %fs:4992+MTgen@tpoff	# prephitmp_1131, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rdx, %rax	# __z, tmp499
	shrq	$11, %rax	#, tmp499
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%eax, %eax	# tmp499, _1151
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp500
	salq	$7, %rdx	#, tmp500
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _1148
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rax, %rdx	# __z, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rdx, %rax	# __z, tmp501
	salq	$15, %rax	#, tmp501
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %eax	#, _1145
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# __z, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _1143
	shrq	$18, %rdx	#, _1143
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _1143, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm2, %xmm1	# __z, tmp777, tmp710
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vaddsd	%xmm0, %xmm1, %xmm1	# tmp504, tmp503, __sum
# /usr/include/c++/13/bits/random.tcc:458:       if (_M_p >= state_size)
	cmpq	$623, %rcx	#, prephitmp_1131
	ja	.L1465	#,
.L1375:
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	leaq	1(%rcx), %rax	#, tmp509
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp783
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%rax, %fs:4992+MTgen@tpoff	# tmp509, MTgen._M_p
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:MTgen@tpoff(,%rcx,8), %rax	# MTgen._M_x[prephitmp_1131], __z
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vmovsd	8(%rsp), %xmm7	# %sfp, tmp674
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movq	%rax, %rdx	# __z, tmp511
	shrq	$11, %rdx	#, tmp511
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	movl	%edx, %edx	# tmp511, _338
# /usr/include/c++/13/bits/random.tcc:463:       __z ^= (__z >> __u) & __d;
	xorq	%rdx, %rax	# _338, __z
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	movq	%rax, %rdx	# __z, tmp512
	salq	$7, %rdx	#, tmp512
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	andl	$2636928640, %edx	#, _341
# /usr/include/c++/13/bits/random.tcc:464:       __z ^= (__z << __s) & __b;
	xorq	%rdx, %rax	# _341, __z
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	movq	%rax, %rdx	# __z, tmp513
	salq	$15, %rdx	#, tmp513
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	andl	$4022730752, %edx	#, _344
# /usr/include/c++/13/bits/random.tcc:465:       __z ^= (__z << __t) & __c;
	xorq	%rdx, %rax	# _344, __z
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	movq	%rax, %rdx	# __z, _346
	shrq	$18, %rdx	#, _346
# /usr/include/c++/13/bits/random.tcc:466:       __z ^= (__z >> __l);
	xorq	%rdx, %rax	# _346, __z
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vcvtusi2sdq	%rax, %xmm2, %xmm0	# __z, tmp783, tmp711
# /usr/include/c++/13/bits/random.tcc:3367: 	  __sum += _RealType(__urng() - __urng.min()) * __tmp;
	vfmadd132sd	.LC163(%rip), %xmm1, %xmm0	#, __sum, __sum
# /usr/include/c++/13/bits/random.tcc:3370:       __ret = __sum / __tmp;
	vmulsd	.LC164(%rip), %xmm0, %xmm0	#, __sum, __ret
# /usr/include/c++/13/bits/random.tcc:3374: 	  __ret = std::nextafter(_RealType(1), _RealType(0));
	vcmplesd	%xmm0, %xmm7, %xmm2	#, __ret, tmp674, tmp684
	vmovsd	.LC168(%rip), %xmm1	#, tmp682
	vblendvpd	%xmm2, %xmm1, %xmm0, %xmm0	# tmp684, tmp682, __ret, __ret
# /usr/include/c++/13/bits/random.h:1804: 	{ return _M_a; }
	vmovsd	%fs:R01@tpoff, %xmm1	# MEM[(const struct param_type *)&R01]._M_a, _203
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vmovsd	%fs:8+R01@tpoff, %xmm2	# MEM[(const struct param_type *)&R01]._M_b, MEM[(const struct param_type *)&R01]._M_b
	vsubsd	%xmm1, %xmm2, %xmm2	# _203, MEM[(const struct param_type *)&R01]._M_b, tmp521
# /usr/include/c++/13/bits/random.h:1909: 	  return (__aurng() * (__p.b() - __p.a())) + __p.a();
	vfmadd132sd	%xmm0, %xmm1, %xmm2	# __ret, _203, _206
# C/parallel-only-omp/collisions.h:67:         cc = 1.0 - 2.0 * R01(MTgen);                    // cos(chi)
	vfnmadd132sd	.LC165(%rip), %xmm7, %xmm2	#, tmp674, cc
# C/parallel-only-omp/collisions.h:68:         sc = sqrt(std::max(0.0, 1.0 - cc * cc));        // sin(chi)
	vfnmadd231sd	%xmm2, %xmm2, %xmm7	# cc, cc, tmp674
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp526
# C/parallel-only-omp/collisions.h:68:         sc = sqrt(std::max(0.0, 1.0 - cc * cc));        // sin(chi)
	vmovsd	%xmm7, %xmm7, %xmm1	# tmp674, _9
# /usr/include/c++/13/bits/stl_algobase.h:262:       if (__a < __b)
	vcomisd	%xmm0, %xmm7	# tmp526, _9
	ja	.L1466	#,
	vxorpd	%xmm1, %xmm1, %xmm1	# sc
.L1377:
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmovsd	16(%rsp), %xmm6	# %sfp, st
	vmovsd	40(%rsp), %xmm5	# %sfp, cp
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmovsd	24(%rsp), %xmm3	# %sfp, ct
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm5, %xmm6, %xmm7	# cp, st, _43
# C/parallel-only-omp/collisions.h:98:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmovsd	32(%rsp), %xmm4	# %sfp, sp
# C/parallel-only-omp/collisions.h:97:         double gy2 = g2 * (st * cp * cc2 + ct * cp * sc2 * ce2 - sp * sc2 * se2);
	vmulsd	%xmm3, %xmm5, %xmm5	# ct, cp, _45
# C/parallel-only-omp/collisions.h:98:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm4, %xmm6, %xmm10	# sp, st, _52
# C/parallel-only-omp/collisions.h:98:         double gz2 = g2 * (st * sp * cc2 + ct * sp * sc2 * ce2 + cp * sc2 * se2);
	vmulsd	%xmm3, %xmm4, %xmm4	# ct, sp, _54
	vmovsd	.LC195(%rip), %xmm6	#, tmp671
	jmp	.L1379	#
	.p2align 4
	.p2align 3
.L1453:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp760
	vmovsd	%xmm0, 96(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp470
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rcx	# MTgen._M_p, prephitmp_935
	vmovsd	96(%rsp), %xmm0	# %sfp, __sum
	jmp	.L1370	#
	.p2align 4
	.p2align 3
.L1452:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp754
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp459
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_913
	jmp	.L1369	#
	.p2align 4
	.p2align 3
.L1451:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp746
	vmovsd	%xmm1, 56(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp440
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rcx	# MTgen._M_p, prephitmp_910
	vmovsd	56(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1367	#
	.p2align 4
	.p2align 3
.L1450:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp740
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp429
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_888
	jmp	.L1366	#
	.p2align 4
	.p2align 3
.L1458:
# C/parallel-only-omp/collisions.h:87:         sc   = sqrt(std::max(0.0, 1.0 - cc * cc));      // sin(chi)
	vsqrtsd	%xmm1, %xmm1, %xmm1	# _33, sc
	jmp	.L1393	#
	.p2align 4
	.p2align 3
.L1463:
# C/parallel-only-omp/collisions.h:74:         sc  = sqrt(std::max(0.0, 1.0 - cc * cc));       // sin(chi)
	vsqrtsd	%xmm1, %xmm1, %xmm1	# _17, sc
	jmp	.L1385	#
	.p2align 4
	.p2align 3
.L1459:
# C/parallel-only-omp/collisions.h:90:         double sc2 = sqrt(std::max(0.0, 1.0 - cc2 * cc2)); // sin(chi2)
	vsqrtsd	%xmm3, %xmm3, %xmm3	# _37, _1033
	jmp	.L1398	#
	.p2align 4
	.p2align 3
.L1466:
# C/parallel-only-omp/collisions.h:68:         sc = sqrt(std::max(0.0, 1.0 - cc * cc));        // sin(chi)
	vsqrtsd	%xmm1, %xmm1, %xmm1	# _9, sc
	jmp	.L1377	#
	.p2align 4
	.p2align 3
.L1456:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp824
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp574
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_944
	jmp	.L1387	#
	.p2align 4
	.p2align 3
.L1457:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp830
	vmovsd	%xmm1, 56(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp585
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rcx	# MTgen._M_p, prephitmp_966
	vmovsd	56(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1388	#
	.p2align 4
	.p2align 3
.L1461:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp800
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp537
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_1042
	jmp	.L1382	#
	.p2align 4
	.p2align 3
.L1462:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp806
	vmovsd	%xmm1, 48(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp548
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rcx	# MTgen._M_p, prephitmp_1064
	vmovsd	48(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1383	#
	.p2align 4
	.p2align 3
.L1465:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp778
	vmovsd	%xmm1, 48(%rsp)	# __sum, %sfp
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp505
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rcx	# MTgen._M_p, prephitmp_1131
	vmovsd	48(%rsp), %xmm1	# %sfp, __sum
	jmp	.L1375	#
	.p2align 4
	.p2align 3
.L1464:
# /usr/include/c++/13/bits/random.tcc:459: 	_M_gen_rand();
	movq	%fs:0, %rax	#, tmp772
	leaq	MTgen@tpoff(%rax), %rdi	#, tmp494
	call	_ZNSt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EE11_M_gen_randEv	#
# /usr/include/c++/13/bits/random.tcc:462:       result_type __z = _M_x[_M_p++];
	movq	%fs:4992+MTgen@tpoff, %rax	# MTgen._M_p, pretmp_1109
	jmp	.L1374	#
	.p2align 4
	.p2align 3
.L1402:
# /usr/include/c++/13/bits/stl_vector.h:1292: 	  _M_realloc_insert(end(), __x);
	leaq	208(%rsp), %rdx	#, tmp640
# C/parallel-only-omp/state.h:163:         vx.push_back(pvx);
	leaq	24(%rbp), %rdi	#, tmp641
	vmovsd	%xmm6, 160(%rsp)	# tmp671, %sfp
	vmovsd	%xmm2, 152(%rsp)	# cc, %sfp
	vmovsd	%xmm1, 144(%rsp)	# sc, %sfp
	vmovsd	%xmm9, 128(%rsp)	# _64, %sfp
	vmovsd	%xmm0, 120(%rsp)	# _62, %sfp
	vmovsd	%xmm4, 112(%rsp)	# _54, %sfp
	vmovsd	%xmm10, 56(%rsp)	# _52, %sfp
	vmovsd	%xmm5, 48(%rsp)	# _45, %sfp
	vmovsd	%xmm7, 8(%rsp)	# _43, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1292: 	  _M_realloc_insert(end(), __x);
	call	_ZNSt6vectorIdSaIdEE17_M_realloc_insertIJRKdEEEvN9__gnu_cxx17__normal_iteratorIPdS1_EEDpOT_	#
	vmovsd	160(%rsp), %xmm6	# %sfp, tmp671
	vmovsd	152(%rsp), %xmm2	# %sfp, cc
	vmovsd	144(%rsp), %xmm1	# %sfp, sc
	vmovsd	128(%rsp), %xmm9	# %sfp, _64
	vmovsd	120(%rsp), %xmm0	# %sfp, _62
	vmovsd	112(%rsp), %xmm4	# %sfp, _54
	vmovsd	56(%rsp), %xmm10	# %sfp, _52
	vmovsd	48(%rsp), %xmm5	# %sfp, _45
	vmovsd	8(%rsp), %xmm7	# %sfp, _43
	jmp	.L1403	#
	.p2align 4
	.p2align 3
.L1400:
	leaq	200(%rsp), %rdx	#, tmp638
	movq	%rbp, %rdi	# new_e,
	vmovsd	%xmm6, 168(%rsp)	# tmp671, %sfp
	vmovsd	%xmm2, 160(%rsp)	# cc, %sfp
	vmovsd	%xmm1, 152(%rsp)	# sc, %sfp
	vmovsd	%xmm8, 144(%rsp)	# _66, %sfp
	vmovsd	%xmm9, 128(%rsp)	# _64, %sfp
	vmovsd	%xmm0, 120(%rsp)	# _62, %sfp
	vmovsd	%xmm4, 112(%rsp)	# _54, %sfp
	vmovsd	%xmm10, 56(%rsp)	# _52, %sfp
	vmovsd	%xmm5, 48(%rsp)	# _45, %sfp
	vmovsd	%xmm7, 8(%rsp)	# _43, %sfp
	call	_ZNSt6vectorIdSaIdEE17_M_realloc_insertIJRKdEEEvN9__gnu_cxx17__normal_iteratorIPdS1_EEDpOT_	#
	vmovsd	168(%rsp), %xmm6	# %sfp, tmp671
	vmovsd	160(%rsp), %xmm2	# %sfp, cc
	vmovsd	152(%rsp), %xmm1	# %sfp, sc
	vmovsd	144(%rsp), %xmm8	# %sfp, _66
	vmovsd	128(%rsp), %xmm9	# %sfp, _64
	vmovsd	120(%rsp), %xmm0	# %sfp, _62
	vmovsd	112(%rsp), %xmm4	# %sfp, _54
	vmovsd	56(%rsp), %xmm10	# %sfp, _52
	vmovsd	48(%rsp), %xmm5	# %sfp, _45
	vmovsd	8(%rsp), %xmm7	# %sfp, _43
	jmp	.L1401	#
	.p2align 4
	.p2align 3
.L1414:
	leaq	224(%rsp), %rdx	#, tmp657
# C/parallel-only-omp/state.h:165:         vz.push_back(pvz);
	leaq	72(%rbx), %rdi	#, tmp658
	vmovsd	%xmm6, 136(%rsp)	# tmp671, %sfp
	vmovsd	%xmm2, 128(%rsp)	# cc, %sfp
	vmovsd	%xmm1, 120(%rsp)	# sc, %sfp
	vmovsd	%xmm4, 112(%rsp)	# _54, %sfp
	vmovsd	%xmm10, 56(%rsp)	# _52, %sfp
	vmovsd	%xmm5, 48(%rsp)	# _45, %sfp
	vmovsd	%xmm7, 8(%rsp)	# _43, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1292: 	  _M_realloc_insert(end(), __x);
	call	_ZNSt6vectorIdSaIdEE17_M_realloc_insertIJRKdEEEvN9__gnu_cxx17__normal_iteratorIPdS1_EEDpOT_	#
	vmovsd	136(%rsp), %xmm6	# %sfp, tmp671
	vmovsd	128(%rsp), %xmm2	# %sfp, cc
	vmovsd	120(%rsp), %xmm1	# %sfp, sc
	vmovsd	112(%rsp), %xmm4	# %sfp, _54
	vmovsd	56(%rsp), %xmm10	# %sfp, _52
	vmovsd	48(%rsp), %xmm5	# %sfp, _45
	vmovsd	8(%rsp), %xmm7	# %sfp, _43
	jmp	.L1379	#
	.p2align 4
	.p2align 3
.L1412:
	leaq	216(%rsp), %rdx	#, tmp654
# C/parallel-only-omp/state.h:164:         vy.push_back(pvy);
	leaq	48(%rbx), %rdi	#, tmp655
	vmovsd	%xmm6, 144(%rsp)	# tmp671, %sfp
	vmovsd	%xmm2, 136(%rsp)	# cc, %sfp
	vmovsd	%xmm1, 128(%rsp)	# sc, %sfp
	vmovsd	%xmm4, 120(%rsp)	# _54, %sfp
	vmovsd	%xmm10, 112(%rsp)	# _52, %sfp
	vmovsd	%xmm5, 56(%rsp)	# _45, %sfp
	vmovsd	%xmm7, 8(%rsp)	# _43, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1292: 	  _M_realloc_insert(end(), __x);
	call	_ZNSt6vectorIdSaIdEE17_M_realloc_insertIJRKdEEEvN9__gnu_cxx17__normal_iteratorIPdS1_EEDpOT_	#
	vmovsd	144(%rsp), %xmm6	# %sfp, tmp671
	vmovsd	136(%rsp), %xmm2	# %sfp, cc
	vmovsd	128(%rsp), %xmm1	# %sfp, sc
	vmovsd	120(%rsp), %xmm4	# %sfp, _54
	vmovsd	112(%rsp), %xmm10	# %sfp, _52
	vmovsd	56(%rsp), %xmm5	# %sfp, _45
	vmovsd	8(%rsp), %xmm7	# %sfp, _43
	jmp	.L1413	#
	.p2align 4
	.p2align 3
.L1410:
	leaq	208(%rsp), %rdx	#, tmp651
# C/parallel-only-omp/state.h:163:         vx.push_back(pvx);
	leaq	24(%rbx), %rdi	#, tmp652
	vmovsd	%xmm6, 152(%rsp)	# tmp671, %sfp
	vmovsd	%xmm2, 144(%rsp)	# cc, %sfp
	vmovsd	%xmm1, 136(%rsp)	# sc, %sfp
	vmovsd	%xmm4, 128(%rsp)	# _54, %sfp
	vmovsd	%xmm10, 120(%rsp)	# _52, %sfp
	vmovsd	%xmm5, 112(%rsp)	# _45, %sfp
	vmovsd	%xmm7, 56(%rsp)	# _43, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1292: 	  _M_realloc_insert(end(), __x);
	call	_ZNSt6vectorIdSaIdEE17_M_realloc_insertIJRKdEEEvN9__gnu_cxx17__normal_iteratorIPdS1_EEDpOT_	#
	vmovsd	152(%rsp), %xmm6	# %sfp, tmp671
	vmovsd	144(%rsp), %xmm2	# %sfp, cc
	vmovsd	136(%rsp), %xmm1	# %sfp, sc
	vmovsd	128(%rsp), %xmm4	# %sfp, _54
	vmovsd	120(%rsp), %xmm10	# %sfp, _52
	vmovsd	112(%rsp), %xmm5	# %sfp, _45
	vmovsd	56(%rsp), %xmm7	# %sfp, _43
	jmp	.L1411	#
	.p2align 4
	.p2align 3
.L1408:
	leaq	200(%rsp), %rdx	#, tmp649
	movq	%rbx, %rdi	# new_i,
	vmovsd	%xmm6, 160(%rsp)	# tmp671, %sfp
	vmovsd	%xmm0, 152(%rsp)	# _214, %sfp
	vmovsd	%xmm2, 144(%rsp)	# cc, %sfp
	vmovsd	%xmm1, 136(%rsp)	# sc, %sfp
	vmovsd	%xmm4, 128(%rsp)	# _54, %sfp
	vmovsd	%xmm10, 120(%rsp)	# _52, %sfp
	vmovsd	%xmm5, 112(%rsp)	# _45, %sfp
	vmovsd	%xmm7, 56(%rsp)	# _43, %sfp
	call	_ZNSt6vectorIdSaIdEE17_M_realloc_insertIJRKdEEEvN9__gnu_cxx17__normal_iteratorIPdS1_EEDpOT_	#
	vmovsd	160(%rsp), %xmm6	# %sfp, tmp671
	vmovsd	152(%rsp), %xmm0	# %sfp, _214
	vmovsd	144(%rsp), %xmm2	# %sfp, cc
	vmovsd	136(%rsp), %xmm1	# %sfp, sc
	vmovsd	128(%rsp), %xmm4	# %sfp, _54
	vmovsd	120(%rsp), %xmm10	# %sfp, _52
	vmovsd	112(%rsp), %xmm5	# %sfp, _45
	vmovsd	56(%rsp), %xmm7	# %sfp, _43
	jmp	.L1409	#
	.p2align 4
	.p2align 3
.L1406:
	leaq	224(%rsp), %rdx	#, tmp646
# C/parallel-only-omp/state.h:165:         vz.push_back(pvz);
	leaq	72(%rbp), %rdi	#, tmp647
	vmovsd	%xmm6, 144(%rsp)	# tmp671, %sfp
	vmovsd	%xmm2, 128(%rsp)	# cc, %sfp
	vmovsd	%xmm1, 120(%rsp)	# sc, %sfp
	vmovsd	%xmm4, 112(%rsp)	# _54, %sfp
	vmovsd	%xmm10, 56(%rsp)	# _52, %sfp
	vmovsd	%xmm5, 48(%rsp)	# _45, %sfp
	vmovsd	%xmm7, 8(%rsp)	# _43, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1292: 	  _M_realloc_insert(end(), __x);
	call	_ZNSt6vectorIdSaIdEE17_M_realloc_insertIJRKdEEEvN9__gnu_cxx17__normal_iteratorIPdS1_EEDpOT_	#
	vmovsd	144(%rsp), %xmm6	# %sfp, tmp671
	vmovsd	128(%rsp), %xmm2	# %sfp, cc
	vmovsd	120(%rsp), %xmm1	# %sfp, sc
	vmovsd	112(%rsp), %xmm4	# %sfp, _54
	vmovsd	56(%rsp), %xmm10	# %sfp, _52
	vmovsd	48(%rsp), %xmm5	# %sfp, _45
	vmovsd	8(%rsp), %xmm7	# %sfp, _43
	jmp	.L1407	#
	.p2align 4
	.p2align 3
.L1404:
	leaq	216(%rsp), %rdx	#, tmp643
# C/parallel-only-omp/state.h:164:         vy.push_back(pvy);
	leaq	48(%rbp), %rdi	#, tmp644
	vmovsd	%xmm6, 152(%rsp)	# tmp671, %sfp
	vmovsd	%xmm2, 144(%rsp)	# cc, %sfp
	vmovsd	%xmm1, 128(%rsp)	# sc, %sfp
	vmovsd	%xmm0, 120(%rsp)	# _62, %sfp
	vmovsd	%xmm4, 112(%rsp)	# _54, %sfp
	vmovsd	%xmm10, 56(%rsp)	# _52, %sfp
	vmovsd	%xmm5, 48(%rsp)	# _45, %sfp
	vmovsd	%xmm7, 8(%rsp)	# _43, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1292: 	  _M_realloc_insert(end(), __x);
	call	_ZNSt6vectorIdSaIdEE17_M_realloc_insertIJRKdEEEvN9__gnu_cxx17__normal_iteratorIPdS1_EEDpOT_	#
	vmovsd	152(%rsp), %xmm6	# %sfp, tmp671
	vmovsd	144(%rsp), %xmm2	# %sfp, cc
	vmovsd	128(%rsp), %xmm1	# %sfp, sc
	vmovsd	120(%rsp), %xmm0	# %sfp, _62
	vmovsd	112(%rsp), %xmm4	# %sfp, _54
	vmovsd	56(%rsp), %xmm10	# %sfp, _52
	vmovsd	48(%rsp), %xmm5	# %sfp, _45
	vmovsd	8(%rsp), %xmm7	# %sfp, _43
	jmp	.L1405	#
.L1446:
	vmovsd	%xmm6, 112(%rsp)	# g2, %sfp
	vmovsd	%xmm2, 56(%rsp)	# cc, %sfp
	vmovsd	%xmm1, 48(%rsp)	# sc, %sfp
# C/parallel-only-omp/collisions.h:89:         double cc2 = sqrt(e_ej / energy);               // cos(chi2) dla elektronu wybitego
	call	sqrt@PLT	#
	vmovsd	112(%rsp), %xmm6	# %sfp, g2
	vmovsd	56(%rsp), %xmm2	# %sfp, cc
	vmovsd	48(%rsp), %xmm1	# %sfp, sc
	jmp	.L1397	#
.L1460:
# C/parallel-only-omp/collisions.h:115: }
	call	__stack_chk_fail@PLT	#
.L1444:
	vmovsd	%xmm2, 112(%rsp)	# e_sc, %sfp
	vmovsd	%xmm3, 56(%rsp)	# e_ej, %sfp
# C/parallel-only-omp/collisions.h:84:         g2   = sqrt(2.0 * e_ej / E_MASS);
	vmovsd	%xmm6, %xmm6, %xmm0	# _30,
	call	sqrt@PLT	#
	vmovsd	%xmm0, %xmm0, %xmm6	# tmp700, g2
# C/parallel-only-omp/collisions.h:86:         cc   = sqrt(e_sc / energy);                     // cos(chi) dla elektronu rozproszonego
	vmovsd	112(%rsp), %xmm2	# %sfp, e_sc
	vmovsd	56(%rsp), %xmm3	# %sfp, e_ej
	vdivsd	48(%rsp), %xmm2, %xmm2	# %sfp, e_sc, _319
	jmp	.L1392	#
	.cfi_endproc
.LFE9867:
