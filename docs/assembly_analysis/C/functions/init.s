# Function: init(int)
# Mangled Symbol: _Z4initi
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._Z4initi,"axG",@progbits,_Z4initi,comdat
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
	