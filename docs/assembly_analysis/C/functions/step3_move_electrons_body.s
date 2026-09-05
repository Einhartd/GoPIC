# Function: step3_move_electrons_body(int, int, int)
# Mangled Symbol: _Z25step3_move_electrons_bodyiii
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._Z25step3_move_electrons_bodyiii,"axG",@progbits,_Z25step3_move_electrons_bodyiii,comdat
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
	