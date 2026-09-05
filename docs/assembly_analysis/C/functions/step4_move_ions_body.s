# Function: step4_move_ions_body(int, int, int, int)
# Mangled Symbol: _Z20step4_move_ions_bodyiiii
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._Z20step4_move_ions_bodyiiii,"axG",@progbits,_Z20step4_move_ions_bodyiiii,comdat
	.p2align 4
	.weak	_Z20step4_move_ions_bodyiiii
	.type	_Z20step4_move_ions_bodyiiii, @function
_Z20step4_move_ions_bodyiiii:
.LFB9879:
	.cfi_startproc
	endbr64	
# C/parallel-only-omp/simulation.h:387:     if ((t % N_SUB) != 0) return;
	movslq	%ecx, %rax	# t, t
# C/parallel-only-omp/simulation.h:386: PIC_STEP void step4_move_ions_body(int tid, int num_threads, int t_index, int t) {
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
# C/parallel-only-omp/simulation.h:387:     if ((t % N_SUB) != 0) return;
	imulq	$1717986919, %rax, %rax	#, t, tmp305
# C/parallel-only-omp/simulation.h:386: PIC_STEP void step4_move_ions_body(int tid, int num_threads, int t_index, int t) {
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%r15	#
	pushq	%r14	#
	pushq	%r13	#
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	movslq	%edx, %r13	# tmp520,
# C/parallel-only-omp/simulation.h:387:     if ((t % N_SUB) != 0) return;
	movl	%ecx, %edx	# t, tmp308
# C/parallel-only-omp/simulation.h:386: PIC_STEP void step4_move_ions_body(int tid, int num_threads, int t_index, int t) {
	pushq	%r12	#
# C/parallel-only-omp/simulation.h:387:     if ((t % N_SUB) != 0) return;
	sarl	$31, %edx	#, tmp308
	sarq	$35, %rax	#, tmp307
	subl	%edx, %eax	# tmp308, _1
# C/parallel-only-omp/simulation.h:386: PIC_STEP void step4_move_ions_body(int tid, int num_threads, int t_index, int t) {
	pushq	%rbx	#
# C/parallel-only-omp/simulation.h:387:     if ((t % N_SUB) != 0) return;
	leal	(%rax,%rax,4), %eax	#, tmp311
# C/parallel-only-omp/simulation.h:386: PIC_STEP void step4_move_ions_body(int tid, int num_threads, int t_index, int t) {
	andq	$-32, %rsp	#,
# C/parallel-only-omp/simulation.h:387:     if ((t % N_SUB) != 0) return;
	sall	$2, %eax	#, tmp312
# C/parallel-only-omp/simulation.h:386: PIC_STEP void step4_move_ions_body(int tid, int num_threads, int t_index, int t) {
	subq	$32, %rsp	#,
	.cfi_offset 12, -48
	.cfi_offset 3, -56
# C/parallel-only-omp/simulation.h:387:     if ((t % N_SUB) != 0) return;
	cmpl	%eax, %ecx	# tmp312, t
	jne	.L206	#,
# C/parallel-only-omp/simulation.h:389:     if (__builtin_expect(!measurement_mode, 1)) {
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
# C/parallel-only-omp/simulation.h:390:         int chunk = (N_i + num_threads - 1) / num_threads;
	movl	N_i(%rip), %r14d	# N_i, pretmp_543
	movl	%edi, %r8d	# tmp518, tid
	movl	%esi, %r12d	# tmp519, num_threads
	vxorps	%xmm6, %xmm6, %xmm6	# tmp524
# C/parallel-only-omp/simulation.h:389:     if (__builtin_expect(!measurement_mode, 1)) {
	jne	.L184	#,
# C/parallel-only-omp/simulation.h:390:         int chunk = (N_i + num_threads - 1) / num_threads;
	leal	-1(%r14,%rsi), %eax	#, tmp314
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	movl	%r14d, %edi	# pretmp_543, pretmp_543
# C/parallel-only-omp/simulation.h:390:         int chunk = (N_i + num_threads - 1) / num_threads;
	cltd
	idivl	%esi	# num_threads
# C/parallel-only-omp/simulation.h:391:         int k_start = std::min(tid * chunk, N_i);
	imull	%eax, %r8d	# tmp315, tmp317
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%r14d, %r8d	# pretmp_543, tmp317
	movl	%r8d, %esi	# tmp317, tmp317
	cmovg	%r14d, %esi	# tmp317,, pretmp_543, tmp317
# C/parallel-only-omp/simulation.h:392:         int k_end   = std::min(k_start + chunk, N_i);
	addl	%esi, %eax	# k, tmp318
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%r14d, %eax	# pretmp_543, tmp318
	cmovle	%eax, %edi	# tmp318,, pretmp_543
# C/parallel-only-omp/simulation.h:395:         int k_unroll_end = k_start + ((k_end - k_start) / 4) * 4;
	movl	%edi, %r8d	# _79, tmp319
	subl	%esi, %r8d	# k, tmp319
# C/parallel-only-omp/simulation.h:395:         int k_unroll_end = k_start + ((k_end - k_start) / 4) * 4;
	movl	%r8d, %edx	# tmp319, tmp325
	sarl	$31, %edx	#, tmp325
	shrl	$30, %edx	#, tmp326
	leal	(%r8,%rdx), %eax	#, tmp327
	andl	$3, %eax	#, tmp328
	subl	%edx, %eax	# tmp326, tmp329
	subl	%eax, %r8d	# tmp329, _13
# C/parallel-only-omp/simulation.h:395:         int k_unroll_end = k_start + ((k_end - k_start) / 4) * 4;
	leal	(%r8,%rsi), %eax	#, k_unroll_end
# C/parallel-only-omp/simulation.h:398:         for (; k < k_unroll_end; k += 4) {
	cmpl	%esi, %eax	# k, k_unroll_end
	jle	.L185	#,
	decl	%r8d	# tmp333
	vbroadcastsd	.LC67(%rip), %ymm9	#, tmp516
	vbroadcastsd	.LC54(%rip), %ymm8	#, tmp512
	movslq	%esi, %r9	# k, _490
	shrl	$2, %r8d	#, _464
	vmovsd	.LC59(%rip), %xmm5	#, tmp511
	leaq	0(,%r9,8), %rcx	#, _489
	leaq	vx_i(%rip), %rax	#, tmp332
	leaq	x_i(%rip), %rdx	#, tmp331
	leaq	efield(%rip), %r14	#, tmp515
	addq	%rcx, %rdx	# _489, ivtmp.1200
	addq	%rax, %rcx	# tmp332, ivtmp.1201
	leal	0(,%r8,4), %eax	#, tmp335
	addq	%r9, %rax	# _490, tmp336
	leaq	32+x_i(%rip), %r9	#, tmp338
	leaq	(%r9,%rax,8), %r9	#, _457
	.p2align 4
	.p2align 3
.L186:
# C/parallel-only-omp/simulation.h:399:             double x0 = x_i[k+0], x1 = x_i[k+1], x2 = x_i[k+2], x3 = x_i[k+3];
	vmovupd	(%rdx), %ymm3	# MEM <vector(4) double> [(double *)_481], MEM <vector(4) double> [(double *)_481]
# C/parallel-only-omp/simulation.h:398:         for (; k < k_unroll_end; k += 4) {
	addq	$32, %rdx	#, ivtmp.1200
	addq	$32, %rcx	#, ivtmp.1201
# C/parallel-only-omp/simulation.h:402:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	vextractf64x2	$1, %ymm3, %xmm10	#, MEM <vector(4) double> [(double *)_481], tmp348
# C/parallel-only-omp/simulation.h:402:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	vmulsd	%xmm5, %xmm3, %xmm4	# tmp511, tmp342, c0_0
# C/parallel-only-omp/simulation.h:403:             int p0 = int(c0_0), p1 = int(c0_1), p2 = int(c0_2), p3 = int(c0_3);
	vcvttsd2sil	%xmm4, %ebx	# c0_0, p0
# C/parallel-only-omp/simulation.h:402:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	vunpckhpd	%xmm3, %xmm3, %xmm0	# tmp343, tmp345
	vmulsd	%xmm5, %xmm0, %xmm0	# tmp511, tmp345, c0_1
# C/parallel-only-omp/simulation.h:403:             int p0 = int(c0_0), p1 = int(c0_1), p2 = int(c0_2), p3 = int(c0_3);
	vcvttsd2sil	%xmm0, %r11d	# c0_1, p1
# C/parallel-only-omp/simulation.h:404:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vcvtsi2sdl	%r11d, %xmm6, %xmm1	# p1, tmp524, tmp525
# C/parallel-only-omp/simulation.h:404:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vsubsd	%xmm1, %xmm0, %xmm1	# tmp354, c0_1, c2_1
# C/parallel-only-omp/simulation.h:402:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	valignq	$3, %ymm3, %ymm3, %ymm7	#, MEM <vector(4) double> [(double *)_481], tmp351
# C/parallel-only-omp/simulation.h:402:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	vmulsd	%xmm5, %xmm10, %xmm10	# tmp511, tmp348, c0_2
# C/parallel-only-omp/simulation.h:403:             int p0 = int(c0_0), p1 = int(c0_1), p2 = int(c0_2), p3 = int(c0_3);
	vcvttsd2sil	%xmm10, %r10d	# c0_2, p2
# C/parallel-only-omp/simulation.h:404:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vcvtsi2sdl	%r10d, %xmm6, %xmm0	# p2, tmp524, tmp526
# C/parallel-only-omp/simulation.h:404:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vsubsd	%xmm0, %xmm10, %xmm11	# tmp355, c0_2, c2_2
# C/parallel-only-omp/simulation.h:406:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	movslq	%ebx, %r12	# p0, p0
# C/parallel-only-omp/simulation.h:402:             double c0_0 = x0 * INV_DX, c0_1 = x1 * INV_DX, c0_2 = x2 * INV_DX, c0_3 = x3 * INV_DX;
	vmulsd	%xmm5, %xmm7, %xmm7	# tmp511, tmp351, c0_3
# C/parallel-only-omp/simulation.h:403:             int p0 = int(c0_0), p1 = int(c0_1), p2 = int(c0_2), p3 = int(c0_3);
	vcvttsd2sil	%xmm7, %eax	# c0_3, p3
# C/parallel-only-omp/simulation.h:404:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vcvtsi2sdl	%eax, %xmm6, %xmm0	# p3, tmp524, tmp527
# C/parallel-only-omp/simulation.h:406:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	vmovsd	(%r14,%r12,8), %xmm12	# efield[p0_233], _21
# C/parallel-only-omp/simulation.h:404:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vsubsd	%xmm0, %xmm7, %xmm10	# tmp356, c0_3, c2_3
# C/parallel-only-omp/simulation.h:406:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	leal	1(%rbx), %r12d	#, tmp360
# C/parallel-only-omp/simulation.h:404:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vcvtsi2sdl	%ebx, %xmm6, %xmm7	# p0, tmp524, tmp528
# C/parallel-only-omp/simulation.h:407:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	movslq	%r11d, %rbx	# p1, p1
# C/parallel-only-omp/simulation.h:407:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	incl	%r11d	# tmp369
# C/parallel-only-omp/simulation.h:406:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	movslq	%r12d, %r12	# tmp360, tmp361
# C/parallel-only-omp/simulation.h:404:             double c2_0 = c0_0 - p0, c2_1 = c0_1 - p1, c2_2 = c0_2 - p2, c2_3 = c0_3 - p3;
	vsubsd	%xmm7, %xmm4, %xmm4	# tmp364, c0_0, c2_0
# C/parallel-only-omp/simulation.h:407:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	movslq	%r11d, %r11	# tmp369, tmp370
# C/parallel-only-omp/simulation.h:406:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	vmovsd	(%r14,%r12,8), %xmm0	# efield[_22], efield[_22]
	vsubsd	%xmm12, %xmm0, %xmm0	# _21, efield[_22], tmp362
# C/parallel-only-omp/simulation.h:406:             double ex0 = efield[p0] + c2_0 * (efield[p0+1] - efield[p0]);
	vfmadd132sd	%xmm4, %xmm12, %xmm0	# c2_0, _21, ex0
# C/parallel-only-omp/simulation.h:407:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	vmovsd	(%r14,%r11,8), %xmm4	# efield[_27], efield[_27]
# C/parallel-only-omp/simulation.h:408:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	movslq	%r10d, %r11	# p2, p2
# C/parallel-only-omp/simulation.h:408:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	incl	%r10d	# tmp376
# C/parallel-only-omp/simulation.h:407:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	vmovsd	(%r14,%rbx,8), %xmm7	# efield[p1_234], _26
# C/parallel-only-omp/simulation.h:408:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	movslq	%r10d, %r10	# tmp376, tmp377
# C/parallel-only-omp/simulation.h:407:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	vsubsd	%xmm7, %xmm4, %xmm4	# _26, efield[_27], tmp371
# C/parallel-only-omp/simulation.h:407:             double ex1 = efield[p1] + c2_1 * (efield[p1+1] - efield[p1]);
	vfmadd132sd	%xmm1, %xmm7, %xmm4	# c2_1, _26, ex1
# C/parallel-only-omp/simulation.h:408:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	vmovsd	(%r14,%r11,8), %xmm7	# efield[p2_235], _31
# C/parallel-only-omp/simulation.h:408:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	vmovsd	(%r14,%r10,8), %xmm1	# efield[_32], efield[_32]
# C/parallel-only-omp/simulation.h:409:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	movslq	%eax, %r10	# p3, p3
# C/parallel-only-omp/simulation.h:409:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	incl	%eax	# tmp383
# C/parallel-only-omp/simulation.h:408:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	vsubsd	%xmm7, %xmm1, %xmm1	# _31, efield[_32], tmp378
# C/parallel-only-omp/simulation.h:409:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	cltq
# C/parallel-only-omp/simulation.h:408:             double ex2 = efield[p2] + c2_2 * (efield[p2+1] - efield[p2]);
	vfmadd132sd	%xmm11, %xmm7, %xmm1	# c2_2, _31, ex2
# C/parallel-only-omp/simulation.h:409:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	vmovsd	(%r14,%r10,8), %xmm11	# efield[p3_236], _36
# C/parallel-only-omp/simulation.h:409:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	vmovsd	(%r14,%rax,8), %xmm7	# efield[_37], efield[_37]
	vsubsd	%xmm11, %xmm7, %xmm7	# _36, efield[_37], tmp385
# C/parallel-only-omp/simulation.h:409:             double ex3 = efield[p3] + c2_3 * (efield[p3+1] - efield[p3]);
	vfmadd132sd	%xmm10, %xmm11, %xmm7	# c2_3, _36, ex3
# C/parallel-only-omp/simulation.h:411:             double vn0 = v0 + ex0 * FACTOR_I;
	vunpcklpd	%xmm4, %xmm0, %xmm0	# ex1, ex0, tmp389
	vunpcklpd	%xmm7, %xmm1, %xmm1	# ex3, ex2, tmp388
	vinsertf128	$0x1, %xmm1, %ymm0, %ymm0	# tmp388, tmp389, tmp387
	vfmadd213pd	-32(%rcx), %ymm9, %ymm0	# MEM <vector(4) double> [(double *)_475], tmp516, vect_vn0_245.1175
# C/parallel-only-omp/simulation.h:417:             x_i[k+0] = x0 + vn0 * DT_I;
	vfmadd231pd	%ymm8, %ymm0, %ymm3	# tmp512, vect_vn0_245.1175, vect__46.1180
# C/parallel-only-omp/simulation.h:416:             vx_i[k+0] = vn0; vx_i[k+1] = vn1; vx_i[k+2] = vn2; vx_i[k+3] = vn3;
	vmovupd	%ymm0, -32(%rcx)	# vect_vn0_245.1175, MEM <vector(4) double> [(double *)_475]
# C/parallel-only-omp/simulation.h:417:             x_i[k+0] = x0 + vn0 * DT_I;
	vmovupd	%ymm3, -32(%rdx)	# vect__46.1180, MEM <vector(4) double> [(double *)_481]
# C/parallel-only-omp/simulation.h:398:         for (; k < k_unroll_end; k += 4) {
	cmpq	%rdx, %r9	# ivtmp.1200, _457
	jne	.L186	#,
	leal	4(%rsi,%r8,4), %esi	#, k
	vzeroupper
.L185:
# C/parallel-only-omp/simulation.h:423:         for (; k < k_end; k++) {
	cmpl	%edi, %esi	# _79, k
	jge	.L206	#,
	movslq	%esi, %r8	# k, _301
	subl	%esi, %edi	# k, tmp399
	leaq	x_i(%rip), %rcx	#, tmp396
	leaq	vx_i(%rip), %r9	#, tmp397
	leaq	0(,%r8,8), %rdx	#, _299
	addq	%r8, %rdi	# _301, tmp400
	leaq	efield(%rip), %r14	#, tmp515
	vmovsd	.LC59(%rip), %xmm5	#, tmp511
	leaq	(%rdx,%rcx), %rax	#, ivtmp.1189
	leaq	(%rcx,%rdi,8), %rdi	#, _494
	addq	%r9, %rdx	# tmp397, ivtmp.1190
	vmovsd	.LC67(%rip), %xmm8	#, tmp513
	vmovsd	.LC54(%rip), %xmm9	#, tmp510
	.p2align 4
	.p2align 3
.L188:
# C/parallel-only-omp/simulation.h:424:             double c0 = x_i[k] * INV_DX;
	vmovsd	(%rax), %xmm4	# MEM[(double *)_249], _53
# C/parallel-only-omp/simulation.h:424:             double c0 = x_i[k] * INV_DX;
	vmulsd	%xmm5, %xmm4, %xmm0	# tmp511, _53, c0
# C/parallel-only-omp/simulation.h:425:             int p     = int(c0);
	vcvttsd2sil	%xmm0, %ecx	# c0, p
# C/parallel-only-omp/simulation.h:427:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	movslq	%ecx, %rsi	# p, p
	vmovsd	(%r14,%rsi,8), %xmm7	# efield[p_214], _55
# C/parallel-only-omp/simulation.h:427:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	leal	1(%rcx), %esi	#, tmp407
# C/parallel-only-omp/simulation.h:426:             double c2 = c0 - p;
	vcvtsi2sdl	%ecx, %xmm6, %xmm3	# p, tmp524, tmp529
# C/parallel-only-omp/simulation.h:426:             double c2 = c0 - p;
	vsubsd	%xmm3, %xmm0, %xmm0	# tmp411, c0, c2
# C/parallel-only-omp/simulation.h:427:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	movslq	%esi, %rsi	# tmp407, tmp408
# C/parallel-only-omp/simulation.h:423:         for (; k < k_end; k++) {
	addq	$8, %rax	#, ivtmp.1189
	addq	$8, %rdx	#, ivtmp.1190
# C/parallel-only-omp/simulation.h:427:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	vmovsd	(%r14,%rsi,8), %xmm1	# efield[_56], efield[_56]
	vsubsd	%xmm7, %xmm1, %xmm1	# _55, efield[_56], tmp409
# C/parallel-only-omp/simulation.h:427:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	vfmadd132sd	%xmm1, %xmm7, %xmm0	# tmp409, _55, e_x
# C/parallel-only-omp/simulation.h:428:             double v   = vx_i[k] + e_x * FACTOR_I;
	vfmadd213sd	-8(%rdx), %xmm8, %xmm0	# MEM[(double *)_255], tmp513, v
# C/parallel-only-omp/simulation.h:429:             vx_i[k]    = v;
	vmovsd	%xmm0, -8(%rdx)	# v, MEM[(double *)_255]
# C/parallel-only-omp/simulation.h:430:             x_i[k]    += v * DT_I;
	vfmadd132sd	%xmm9, %xmm4, %xmm0	# tmp510, _53, _63
	vmovsd	%xmm0, -8(%rax)	# _63, MEM[(double *)_249]
# C/parallel-only-omp/simulation.h:423:         for (; k < k_end; k++) {
	cmpq	%rdi, %rax	# _494, ivtmp.1189
	jne	.L188	#,
.L206:
# C/parallel-only-omp/simulation.h:485: }
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
.L184:
	.cfi_restore_state
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	192+worker_buffers(%rip), %r15	# MEM[(struct vector *)&worker_buffers + 192B].D.103980._M_impl.D.103319._M_start, _263
# C/parallel-only-omp/simulation.h:436:         worker_buffers.counter_i[tid].fill(0.0);
	movslq	%edi, %rbx	# tid, tid
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
	movl	$3200, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	imulq	$3200, %rbx, %rbx	#, tid, _262
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	%rbx, %r15	# _262, _263
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%r15, %rdi	# _263,
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	216+worker_buffers(%rip), %r9	# MEM[(struct vector *)&worker_buffers + 216B].D.103980._M_impl.D.103319._M_start, _209
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
	movl	$3200, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	%rbx, %r9	# _262, _209
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%r9, %rdi	# _209,
	movq	%r9, 16(%rsp)	# _209, %sfp
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	240+worker_buffers(%rip), %rbx	# MEM[(struct vector *)&worker_buffers + 240B].D.103980._M_impl.D.103319._M_start, _165
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movl	$3200, %edx	#,
	xorl	%esi, %esi	#
	movq	%rbx, %rdi	# _165,
	call	memset@PLT	#
	call	omp_get_num_threads@PLT	#
	movl	%eax, 28(%rsp)	# tmp522, %sfp
	call	omp_get_thread_num@PLT	#
	movq	16(%rsp), %r9	# %sfp, _209
	vxorps	%xmm6, %xmm6, %xmm6	# tmp524
	movl	%eax, %r8d	# tmp523, _147
	movl	%r14d, %eax	# pretmp_543, pretmp_543
	cltd
	idivl	28(%rsp)	# %sfp
	cmpl	%edx, %r8d	# tt.87_131, _147
	jl	.L208	#,
.L189:
	movl	%eax, %esi	# q.86_130, tmp439
	imull	%r8d, %esi	# _147, tmp439
	addl	%esi, %edx	# tmp439, _152
	leal	(%rax,%rdx), %ecx	#, tmp440
	cmpl	%ecx, %edx	# tmp440, _152
	jge	.L193	#,
	movslq	%edx, %r10	# _152, _152
	movl	%eax, %eax	# q.86_130, q.86_130
	leaq	x_i(%rip), %rsi	#, tmp442
	leaq	vx_i(%rip), %rcx	#, tmp443
	salq	$3, %r10	#, _420
	movl	%r13d, 16(%rsp)	# t_index, %sfp
	vmovsd	.LC59(%rip), %xmm5	#, tmp511
	vmovsd	.LC67(%rip), %xmm8	#, tmp513
	vmovsd	.LC54(%rip), %xmm9	#, tmp510
	vmovsd	.LC45(%rip), %xmm11	#, tmp507
	vmovsd	.LC53(%rip), %xmm10	#, tmp509
	vmovsd	.LC50(%rip), %xmm7	#, tmp508
	salq	$3, %rax	#, _394
	leaq	vy_i(%rip), %r11	#, tmp445
	leaq	vz_i(%rip), %rdx	#, tmp446
	addq	%r10, %rsi	# _420, ivtmp.1233
	addq	%r10, %rcx	# _420, ivtmp.1234
	addq	%r10, %r11	# _420, _402
	addq	%rdx, %r10	# tmp446, _399
	movl	%r12d, %r13d	# num_threads, num_threads
	xorl	%edi, %edi	# ivtmp.1239
	movl	%r8d, %r12d	# _147, _147
	leaq	efield(%rip), %r14	#, tmp515
	movq	%r11, %r8	# _402, _402
	movq	%r10, %r11	# _399, _399
	movq	%rax, %r10	# _394, _394
	.p2align 4
	.p2align 3
.L192:
# C/parallel-only-omp/simulation.h:446:         c0  = x_i[k] * INV_DX;
	vmulsd	(%rsi), %xmm5, %xmm1	# MEM[(double *)_410], tmp511, c0
# C/parallel-only-omp/simulation.h:447:         p   = int(c0);
	vcvttsd2sil	%xmm1, %edx	# c0, p
# C/parallel-only-omp/simulation.h:448:         c1  = p + 1 - c0;
	leal	1(%rdx), %eax	#, _69
# C/parallel-only-omp/simulation.h:449:         c2  = c0 - p;
	vcvtsi2sdl	%edx, %xmm6, %xmm3	# p, tmp524, tmp531
# C/parallel-only-omp/simulation.h:448:         c1  = p + 1 - c0;
	vcvtsi2sdl	%eax, %xmm6, %xmm0	# _69, tmp524, tmp530
# C/parallel-only-omp/simulation.h:450:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%edx, %rdx	# p, p
# C/parallel-only-omp/simulation.h:450:         e_x = c1 * efield[p] + c2 * efield[p+1];
	cltq
# C/parallel-only-omp/simulation.h:448:         c1  = p + 1 - c0;
	vsubsd	%xmm1, %xmm0, %xmm0	# c0, tmp449, c1
# C/parallel-only-omp/simulation.h:449:         c2  = c0 - p;
	vsubsd	%xmm3, %xmm1, %xmm1	# tmp450, c0, c2
	vunpcklpd	%xmm1, %xmm0, %xmm4	# c2, c1, tmp451
# C/parallel-only-omp/simulation.h:450:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vmulsd	(%r14,%rax,8), %xmm1, %xmm1	# efield[_69], c2, tmp456
# C/parallel-only-omp/simulation.h:450:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vfmadd132sd	(%r14,%rdx,8), %xmm1, %xmm0	# efield[p_155], tmp456, e_x
	salq	$3, %rdx	#, tmp460
# C/parallel-only-omp/simulation.h:452:         mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I;
	vmulsd	%xmm11, %xmm0, %xmm1	# tmp507, e_x, tmp457
# C/parallel-only-omp/simulation.h:452:         mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I;
	vfmadd213sd	(%rcx), %xmm8, %xmm1	# MEM[(double *)_407], tmp513, mean_v
	leaq	(%r15,%rdx), %rax	#, vectp.1166
	addq	$8, %rsi	#, ivtmp.1233
	addq	$8, %rcx	#, ivtmp.1234
# C/parallel-only-omp/simulation.h:454:         worker_buffers.counter_i[tid][p]   += c1;
	vaddpd	(%rax), %xmm4, %xmm3	# MEM <vector(2) double> [(value_type &)vectp.1166_518], tmp451, vect__82.1168
	vmovupd	%xmm3, (%rax)	# vect__82.1168, MEM <vector(2) double> [(value_type &)vectp.1166_518]
	leaq	(%r9,%rdx), %rax	#, vectp.1152
# C/parallel-only-omp/simulation.h:457:         worker_buffers.ui[tid][p]   += c1 * mean_v;
	vmovddup	%xmm1, %xmm3	# mean_v, tmp464
	addq	%rbx, %rdx	# _165, vectp.1159
	vfmadd213pd	(%rax), %xmm4, %xmm3	# MEM <vector(2) double> [(value_type &)vectp.1152_281], tmp451, vect__88.1155
	vmovupd	%xmm3, (%rax)	# vect__88.1155, MEM <vector(2) double> [(value_type &)vectp.1152_281]
# C/parallel-only-omp/simulation.h:460:         v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r8,%rdi), %xmm3	# MEM[(double *)_402 + ivtmp.1239_412 * 1], _93
# C/parallel-only-omp/simulation.h:460:         v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmulsd	%xmm3, %xmm3, %xmm3	# _93, _93, tmp466
# C/parallel-only-omp/simulation.h:460:         v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd231sd	%xmm1, %xmm1, %xmm3	# mean_v, mean_v, _95
# C/parallel-only-omp/simulation.h:460:         v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r11,%rdi), %xmm1	# MEM[(double *)_399 + ivtmp.1239_412 * 1], _96
	addq	$8, %rdi	#, ivtmp.1239
# C/parallel-only-omp/simulation.h:460:         v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd132sd	%xmm1, %xmm3, %xmm1	# _96, _95, v_sqr
# C/parallel-only-omp/simulation.h:461:         energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vmulsd	%xmm10, %xmm1, %xmm1	# tmp509, v_sqr, tmp467
# C/parallel-only-omp/simulation.h:461:         energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vdivsd	%xmm7, %xmm1, %xmm1	# tmp508, tmp467, energy
# C/parallel-only-omp/simulation.h:463:         worker_buffers.meanei[tid][p]   += c1 * energy;
	vmovddup	%xmm1, %xmm1	# energy, tmp471
	vfmadd213pd	(%rdx), %xmm4, %xmm1	# MEM <vector(2) double> [(value_type &)vectp.1159_525], tmp451, vect__101.1162
	vmovupd	%xmm1, (%rdx)	# vect__101.1162, MEM <vector(2) double> [(value_type &)vectp.1159_525]
# C/parallel-only-omp/simulation.h:467:         vx_i[k] += e_x * FACTOR_I;
	vfmadd213sd	-8(%rcx), %xmm8, %xmm0	# MEM[(double *)_407], tmp513, _107
	vmovsd	%xmm0, -8(%rcx)	# _107, MEM[(double *)_407]
# C/parallel-only-omp/simulation.h:468:         x_i[k]  += vx_i[k] * DT_I;
	vfmadd213sd	-8(%rsi), %xmm9, %xmm0	# MEM[(double *)_410], tmp510, _110
	vmovsd	%xmm0, -8(%rsi)	# _110, MEM[(double *)_410]
	cmpq	%rdi, %r10	# ivtmp.1239, _394
	jne	.L192	#,
	movl	%r12d, %r8d	# _147, _147
	movl	%r13d, %r12d	# num_threads, num_threads
	movslq	16(%rsp), %r13	# %sfp,
.L193:
	movl	%r8d, 16(%rsp)	# _147, %sfp
	call	GOMP_barrier@PLT	#
# C/parallel-only-omp/simulation.h:471:     if (measurement_mode) {
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	movl	16(%rsp), %r8d	# %sfp, _147
	je	.L206	#,
	movl	$400, %eax	#, q.84_128
	xorl	%edx, %edx	# tt.85_129
	idivl	28(%rsp)	# %sfp
	cmpl	%edx, %r8d	# tt.85_129, _147
	jl	.L209	#,
.L194:
	movl	%r8d, %r9d	# _147, _147
	imull	%eax, %r9d	# q.84_128, _147
	addl	%r9d, %edx	# tmp481, _185
	leal	(%rax,%rdx), %ecx	#, tmp482
	cmpl	%ecx, %edx	# tmp482, _185
	jge	.L199	#,
	movslq	%edx, %r9	# _185, _446
	movslq	%r12d, %rdx	# num_threads, num_threads
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	192+worker_buffers(%rip), %r10	# MEM[(struct vector *)&worker_buffers + 192B].D.103980._M_impl.D.103319._M_start, _275
	movq	216+worker_buffers(%rip), %rdi	# MEM[(struct vector *)&worker_buffers + 216B].D.103980._M_impl.D.103319._M_start, _273
	movq	240+worker_buffers(%rip), %rsi	# MEM[(struct vector *)&worker_buffers + 240B].D.103980._M_impl.D.103319._M_start, _271
	movl	%eax, %eax	# q.84_128, q.84_128
	leaq	0(,%r9,8), %r8	#, ivtmp.1224
	imulq	$200, %r9, %rcx	#, _446, tmp489
	leaq	ui_xt(%rip), %rbx	#, tmp506
	leaq	meanei_xt(%rip), %r11	#, tmp514
	imulq	$400, %rdx, %rdx	#, num_threads, tmp487
	addq	%r13, %rcx	# t_index, tmp491
	leaq	counter_i_xt(%rip), %r13	#, tmp517
	addq	%r9, %rdx	# _446, tmp488
	addq	%rax, %r9	# q.84_128, tmp493
	salq	$3, %rdx	#, ivtmp.1225
	salq	$3, %rcx	#, ivtmp.1227
	salq	$3, %r9	#, _425
	.p2align 4
	.p2align 3
.L198:
# C/parallel-only-omp/simulation.h:475:             for (int t2 = 0; t2 < num_threads; t2++) {
	testl	%r12d, %r12d	# num_threads
	jle	.L200	#,
	movq	%r8, %rax	# ivtmp.1224, ivtmp.1214
# C/parallel-only-omp/simulation.h:474:             double c_i = 0.0, u_i = 0.0, m_i = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# m_i
# C/parallel-only-omp/simulation.h:474:             double c_i = 0.0, u_i = 0.0, m_i = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm1	#, u_i
# C/parallel-only-omp/simulation.h:474:             double c_i = 0.0, u_i = 0.0, m_i = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm2	#, c_i
	.p2align 4
	.p2align 3
.L197:
# C/parallel-only-omp/simulation.h:476:                 c_i += worker_buffers.counter_i[t2][p];
	vaddsd	(%r10,%rax), %xmm2, %xmm2	# MEM[(value_type &)_275 + ivtmp.1214_456 * 1], c_i, c_i
# C/parallel-only-omp/simulation.h:477:                 u_i += worker_buffers.ui[t2][p];
	vaddsd	(%rdi,%rax), %xmm1, %xmm1	# MEM[(value_type &)_273 + ivtmp.1214_456 * 1], u_i, u_i
# C/parallel-only-omp/simulation.h:478:                 m_i += worker_buffers.meanei[t2][p];
	vaddsd	(%rsi,%rax), %xmm0, %xmm0	# MEM[(value_type &)_271 + ivtmp.1214_456 * 1], m_i, m_i
# C/parallel-only-omp/simulation.h:475:             for (int t2 = 0; t2 < num_threads; t2++) {
	addq	$3200, %rax	#, ivtmp.1214
	cmpq	%rax, %rdx	# ivtmp.1214, ivtmp.1225
	jne	.L197	#,
.L196:
	addq	$8, %r8	#, ivtmp.1224
# C/parallel-only-omp/simulation.h:480:             counter_i_xt[p][t_index] += c_i;
	vaddsd	0(%r13,%rcx), %xmm2, %xmm2	# MEM[(double *)&counter_i_xt + ivtmp.1227_438 * 1], c_i, tmp496
# C/parallel-only-omp/simulation.h:481:             ui_xt[p][t_index]        += u_i;
	vaddsd	(%rbx,%rcx), %xmm1, %xmm1	# MEM[(double *)&ui_xt + ivtmp.1227_438 * 1], u_i, tmp500
# C/parallel-only-omp/simulation.h:482:             meanei_xt[p][t_index]    += m_i;
	vaddsd	(%r11,%rcx), %xmm0, %xmm0	# MEM[(double *)&meanei_xt + ivtmp.1227_438 * 1], m_i, tmp504
# C/parallel-only-omp/simulation.h:480:             counter_i_xt[p][t_index] += c_i;
	vmovsd	%xmm2, 0(%r13,%rcx)	# tmp496, MEM[(double *)&counter_i_xt + ivtmp.1227_438 * 1]
# C/parallel-only-omp/simulation.h:481:             ui_xt[p][t_index]        += u_i;
	vmovsd	%xmm1, (%rbx,%rcx)	# tmp500, MEM[(double *)&ui_xt + ivtmp.1227_438 * 1]
# C/parallel-only-omp/simulation.h:482:             meanei_xt[p][t_index]    += m_i;
	vmovsd	%xmm0, (%r11,%rcx)	# tmp504, MEM[(double *)&meanei_xt + ivtmp.1227_438 * 1]
	addq	$8, %rdx	#, ivtmp.1225
	addq	$1600, %rcx	#, ivtmp.1227
	cmpq	%r8, %r9	# ivtmp.1224, _425
	jne	.L198	#,
.L199:
# C/parallel-only-omp/simulation.h:485: }
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
.L208:
	.cfi_restore_state
	incl	%eax	# q.86_130
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%edx, %edx	# tt.87_131
	jmp	.L189	#
.L200:
# C/parallel-only-omp/simulation.h:474:             double c_i = 0.0, u_i = 0.0, m_i = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# m_i
# C/parallel-only-omp/simulation.h:474:             double c_i = 0.0, u_i = 0.0, m_i = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm1	#, u_i
# C/parallel-only-omp/simulation.h:474:             double c_i = 0.0, u_i = 0.0, m_i = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm2	#, c_i
	jmp	.L196	#
.L209:
	incl	%eax	# q.84_128
# C/parallel-only-omp/simulation.h:471:     if (measurement_mode) {
	xorl	%edx, %edx	# tt.85_129
	jmp	.L194	#
	.cfi_endproc
.LFE9879:
	.size	_Z20step4_move_ions_bodyiiii, .-_Z20step4_move_ions_bodyiiii
	.section	.rodata._Z18save_particle_datav.str1.1,"aMS",@progbits,1
.LC69:
	.string	"wb"
	.section	.rodata._Z18save_particle_datav.str1.8,"aMS",@progbits,1
	.align 8
.LC70:
	.string	">> eduPIC: data saved : %d electrons %d ions, %d cycles completed, time is %e [s]\n"
	