# Function: collision_electron(double, double*, double*, double*, int, NewParticles&, NewParticles&)
# Mangled Symbol: _Z18collision_electrondPdS_S_iR12NewParticlesS1_
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._Z18collision_electrondPdS_S_iR12NewParticlesS1_,"axG",@progbits,_Z18collision_electrondPdS_S_iR12NewParticlesS1_,comdat
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
	