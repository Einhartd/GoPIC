_Z25step3_move_electrons_bodyiii:
.LFB9876:
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
	movl	%esi, %ebp	# tmp538, num_threads
	subq	$40, %rsp	#,
	.cfi_def_cfa_offset 96
# C/parallel-only-omp/simulation.h:213:     if (__builtin_expect(!measurement_mode, 1)) {
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
# C/parallel-only-omp/simulation.h:214:         int chunk = (N_e + num_threads - 1) / num_threads;
	movl	N_e(%rip), %ecx	# N_e, pretmp_514
# C/parallel-only-omp/simulation.h:212: PIC_STEP void step3_move_electrons_body(int tid, int num_threads, int t_index) {
	movslq	%edi, %rbx	# tmp537,
# C/parallel-only-omp/simulation.h:213:     if (__builtin_expect(!measurement_mode, 1)) {
	jne	.L161	#,
# C/parallel-only-omp/simulation.h:214:         int chunk = (N_e + num_threads - 1) / num_threads;
	leal	-1(%rcx,%rsi), %eax	#, tmp317
# C/parallel-only-omp/simulation.h:214:         int chunk = (N_e + num_threads - 1) / num_threads;
	cltd
	idivl	%esi	# num_threads
# C/parallel-only-omp/simulation.h:215:         int k_start = std::min(tid * chunk, N_e);
	imull	%eax, %ebx	# tmp318, tmp320
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%ecx, %ebx	# pretmp_514, tmp320
	cmovg	%ecx, %ebx	# tmp320,, pretmp_514, _289
# C/parallel-only-omp/simulation.h:216:         int k_end   = std::min(k_start + chunk, N_e);
	addl	%ebx, %eax	# _289, tmp321
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%ecx, %eax	# pretmp_514, tmp321
	cmovg	%ecx, %eax	# tmp321,, pretmp_514, _27
	cmpl	%ebx, %eax	# _289, _27
	jle	.L207	#,
	movslq	%ebx, %rdi	# _289, _481
	subl	%ebx, %eax	# _289, tmp325
	leaq	x_e(%rip), %rsi	#, tmp322
	leaq	vx_e(%rip), %r8	#, tmp323
	leaq	0(,%rdi,8), %rcx	#, _441
	addq	%rdi, %rax	# _481, tmp326
	vxorps	%xmm7, %xmm7, %xmm7	# tmp543
	vmovsd	.LC59(%rip), %xmm8	#, tmp522
	leaq	(%rcx,%rsi), %rdx	#, ivtmp.1128
	leaq	(%rsi,%rax,8), %rdi	#, _45
	addq	%r8, %rcx	# tmp323, ivtmp.1129
	leaq	efield(%rip), %r8	#, tmp509
	vmovsd	.LC60(%rip), %xmm6	#, tmp516
	vmovsd	.LC52(%rip), %xmm5	#, tmp520
	.p2align 4
	.p2align 3
.L164:
# C/parallel-only-omp/simulation.h:221:             double c0 = x_e[k] * INV_DX;
	vmovsd	(%rdx), %xmm2	# MEM[(double *)_35], _254
# C/parallel-only-omp/simulation.h:221:             double c0 = x_e[k] * INV_DX;
	vmulsd	%xmm8, %xmm2, %xmm1	# tmp522, _254, c0
# C/parallel-only-omp/simulation.h:222:             int p     = int(c0);
	vcvttsd2sil	%xmm1, %eax	# c0, p
# C/parallel-only-omp/simulation.h:223:             double c2 = c0 - p;
	vcvtsi2sdl	%eax, %xmm7, %xmm0	# p, tmp543, tmp544
# C/parallel-only-omp/simulation.h:224:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	movslq	%eax, %rsi	# p, p
# C/parallel-only-omp/simulation.h:224:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	incl	%eax	# tmp335
# C/parallel-only-omp/simulation.h:223:             double c2 = c0 - p;
	vsubsd	%xmm0, %xmm1, %xmm1	# tmp332, c0, c2
	addq	$8, %rdx	#, ivtmp.1128
# C/parallel-only-omp/simulation.h:224:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	cltq
# C/parallel-only-omp/simulation.h:224:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	vmovsd	(%r8,%rsi,8), %xmm3	# efield[p_256], _261
	addq	$8, %rcx	#, ivtmp.1129
# C/parallel-only-omp/simulation.h:224:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	vmovsd	(%r8,%rax,8), %xmm0	# efield[_259], efield[_259]
	vsubsd	%xmm3, %xmm0, %xmm0	# _261, efield[_259], tmp337
# C/parallel-only-omp/simulation.h:224:             double e_x = efield[p] + c2 * (efield[p+1] - efield[p]);
	vfmadd132sd	%xmm1, %xmm3, %xmm0	# c2, _261, e_x
# C/parallel-only-omp/simulation.h:225:             double v   = vx_e[k] - e_x * FACTOR_E;
	vfnmadd213sd	-8(%rcx), %xmm6, %xmm0	# MEM[(double *)_162], tmp516, v
# C/parallel-only-omp/simulation.h:226:             vx_e[k]    = v;
	vmovsd	%xmm0, -8(%rcx)	# v, MEM[(double *)_162]
# C/parallel-only-omp/simulation.h:227:             x_e[k]    += v * DT_E;
	vfmadd132sd	%xmm5, %xmm2, %xmm0	# tmp520, _254, _270
	vmovsd	%xmm0, -8(%rdx)	# _270, MEM[(double *)_35]
	cmpq	%rdx, %rdi	# ivtmp.1128, _45
	jne	.L164	#,
.L207:
# C/parallel-only-omp/simulation.h:328: }
	addq	$40, %rsp	#,
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
.L161:
	.cfi_restore_state
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	48+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 48B].D.103874._M_impl.D.103213._M_start, _281
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	imulq	$3200, %rbx, %r13	#, _11, _280
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
	movslq	%edx, %r12	# tmp539,
	movl	$3200, %edx	#,
	movl	%ecx, 12(%rsp)	# pretmp_514, %sfp
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	%r13, %rax	# _280, _281
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%rax, %rdi	# _281,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	%rax, 24(%rsp)	# _281, %sfp
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	72+worker_buffers(%rip), %r15	# MEM[(struct vector *)&worker_buffers + 72B].D.103874._M_impl.D.103213._M_start, _274
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
	movl	$3200, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	%r13, %r15	# _280, _274
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%r15, %rdi	# _274,
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	96+worker_buffers(%rip), %r14	# MEM[(struct vector *)&worker_buffers + 96B].D.103874._M_impl.D.103213._M_start, _137
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
	movl	$3200, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	%r13, %r14	# _280, _137
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%r14, %rdi	# _137,
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	120+worker_buffers(%rip), %r13	# MEM[(struct vector *)&worker_buffers + 120B].D.103874._M_impl.D.103213._M_start, _161
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
	movl	$3200, %edx	#,
	movq	%r13, %rdi	# _161,
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	imulq	$16000, %rbx, %rax	#, _11, tmp370
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	144+worker_buffers(%rip), %rax	# MEM[(struct vector *)&worker_buffers + 144B].D.104928._M_impl.D.104267._M_start, tmp370
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	xorl	%esi, %esi	#
	movl	$16000, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	salq	$6, %rbx	#, tmp378
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	movq	%rax, %rdi	# _181,
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	%rax, 16(%rsp)	# _181, %sfp
# /usr/include/c++/13/bits/stl_algobase.h:931: 	*__first = __tmp;
	call	memset@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	addq	168+worker_buffers(%rip), %rbx	# MEM[(struct vector *)&worker_buffers + 168B].D.105978._M_impl.D.105317._M_start, _211
# C/parallel-only-omp/simulation.h:240:         worker_buffers.thread_counters[tid].accu_center   = 0.0;
	movq	$0x000000000, (%rbx)	#, _211->accu_center
# C/parallel-only-omp/simulation.h:241:         worker_buffers.thread_counters[tid].counter_center = 0;
	movq	$0, 8(%rbx)	#, _211->counter_center
	call	omp_get_num_threads@PLT	#
	movl	%eax, 8(%rsp)	# tmp540, %sfp
	call	omp_get_thread_num@PLT	#
	vxorps	%xmm7, %xmm7, %xmm7	# tmp543
	movl	%eax, %esi	# tmp541, _142
	movl	%eax, 4(%rsp)	# _142, %sfp
	movl	12(%rsp), %eax	# %sfp, pretmp_514
	cltd
	idivl	8(%rsp)	# %sfp
	cmpl	%edx, %esi	# tt.78_117, _142
	jl	.L209	#,
.L166:
	movl	4(%rsp), %ecx	# %sfp, tmp383
	imull	%eax, %ecx	# q.77_116, tmp383
	addl	%ecx, %edx	# tmp383, _147
	leal	(%rax,%rdx), %ecx	#, tmp384
	cmpl	%ecx, %edx	# tmp384, _147
	jge	.L174	#,
	movslq	%edx, %rdx	# _147, _394
	movl	%eax, %eax	# q.77_116, q.77_116
	leaq	x_e(%rip), %r8	#, tmp385
	leaq	vz_e(%rip), %r11	#, tmp388
	leaq	0(,%rdx,8), %rdi	#, _393
	addq	%rdx, %rax	# _394, tmp390
	leaq	vx_e(%rip), %rsi	#, tmp386
	leaq	vy_e(%rip), %r10	#, tmp387
	leaq	(%rdi,%r8), %rcx	#, ivtmp.1186
	leaq	(%r8,%rax,8), %rax	#, _356
	leaq	efield(%rip), %r8	#, tmp509
	addq	%rdi, %rsi	# _393, ivtmp.1187
	addq	%rdi, %r10	# _393, ivtmp.1188
# C/parallel-only-omp/simulation.h:279:             energy_index = (int)(energy / DE_EEPF);
	movl	%ebp, 12(%rsp)	# num_threads, %sfp
	addq	%r11, %rdi	# tmp388, ivtmp.1189
	leaq	sigma(%rip), %r9	#, tmp511
	movq	24(%rsp), %r11	# %sfp, _281
	movq	%rax, %rbp	# _356, _356
	movl	%r12d, 24(%rsp)	# t_index, %sfp
	movq	%rbx, %r12	# _211, _211
	movq	%r8, %rbx	# tmp509, tmp509
	vmovsd	.LC59(%rip), %xmm8	#, tmp522
	vmovsd	.LC60(%rip), %xmm6	#, tmp516
	vmovsd	.LC52(%rip), %xmm5	#, tmp520
	vmovsd	.LC10(%rip), %xmm9	#, tmp510
	vmovsd	.LC45(%rip), %xmm3	#, tmp523
	vmovsd	.LC61(%rip), %xmm15	#, tmp517
	vmovsd	.LC50(%rip), %xmm14	#, tmp519
	vmovsd	.LC1(%rip), %xmm12	#, tmp512
	vmovsd	.LC47(%rip), %xmm11	#, tmp524
	vmovsd	.LC62(%rip), %xmm10	#, tmp518
# C/parallel-only-omp/simulation.h:278:         if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)) {
	vmovsd	.LC63(%rip), %xmm16	#, tmp525
# C/parallel-only-omp/simulation.h:279:             energy_index = (int)(energy / DE_EEPF);
	vmovsd	.LC19(%rip), %xmm17	#, tmp526
	.p2align 4
	.p2align 3
.L173:
# C/parallel-only-omp/simulation.h:250:         c0  = x_e[k] * INV_DX;
	vmulsd	(%rcx), %xmm8, %xmm0	# MEM[(double *)_373], tmp522, c0
# C/parallel-only-omp/simulation.h:251:         p   = int(c0);
	vcvttsd2sil	%xmm0, %edx	# c0, p
# C/parallel-only-omp/simulation.h:252:         c1  = p + 1.0 - c0;
	vcvtsi2sdl	%edx, %xmm7, %xmm2	# p, tmp543, tmp545
# C/parallel-only-omp/simulation.h:254:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%edx, %rax	# p, p
# C/parallel-only-omp/simulation.h:254:         e_x = c1 * efield[p] + c2 * efield[p+1];
	incl	%edx	# tmp401
# C/parallel-only-omp/simulation.h:252:         c1  = p + 1.0 - c0;
	vaddsd	%xmm9, %xmm2, %xmm1	# tmp510, _501, tmp395
# C/parallel-only-omp/simulation.h:252:         c1  = p + 1.0 - c0;
	vsubsd	%xmm0, %xmm1, %xmm1	# c0, tmp395, c1
# C/parallel-only-omp/simulation.h:253:         c2  = c0 - p;
	vsubsd	%xmm2, %xmm0, %xmm0	# _501, c0, c2
# C/parallel-only-omp/simulation.h:254:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%edx, %rdx	# tmp401, tmp402
	vunpcklpd	%xmm0, %xmm1, %xmm18	# c2, c1, tmp397
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	movl	$999999, %r8d	#, tmp546
# C/parallel-only-omp/simulation.h:254:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vmulsd	(%rbx,%rdx,8), %xmm0, %xmm0	# efield[_503], c2, tmp403
# C/parallel-only-omp/simulation.h:254:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vfmadd132sd	(%rbx,%rax,8), %xmm0, %xmm1	# efield[p_497], tmp403, e_x
	salq	$3, %rax	#, tmp407
# C/parallel-only-omp/simulation.h:256:         mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E;
	vmulsd	%xmm3, %xmm1, %xmm0	# tmp523, e_x, tmp404
# C/parallel-only-omp/simulation.h:256:         mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E;
	vfnmadd213sd	(%rsi), %xmm6, %xmm0	# MEM[(double *)_369], tmp516, mean_v
	leaq	(%r11,%rax), %rdx	#, vectp.1119
# C/parallel-only-omp/simulation.h:258:         worker_buffers.counter_e[tid][p]   += c1;
	vaddpd	(%rdx), %xmm18, %xmm2	# MEM <vector(2) double> [(value_type &)vectp.1119_154], tmp397, vect__185.1121
	vmovupd	%xmm2, (%rdx)	# vect__185.1121, MEM <vector(2) double> [(value_type &)vectp.1119_154]
	leaq	(%r15,%rax), %rdx	#, vectp.1112
# C/parallel-only-omp/simulation.h:261:         worker_buffers.ue[tid][p]   += c1 * mean_v;
	vmovddup	%xmm0, %xmm2	# mean_v, tmp411
	vfmadd213pd	(%rdx), %xmm18, %xmm2	# MEM <vector(2) double> [(value_type &)vectp.1112_20], tmp397, vect__482.1115
	vmovupd	%xmm2, (%rdx)	# vect__482.1115, MEM <vector(2) double> [(value_type &)vectp.1112_20]
# C/parallel-only-omp/simulation.h:264:         v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vmovsd	(%r10), %xmm2	# MEM[(double *)_366], _475
# C/parallel-only-omp/simulation.h:264:         v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vmulsd	%xmm2, %xmm2, %xmm2	# _475, _475, tmp413
# C/parallel-only-omp/simulation.h:264:         v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vfmadd231sd	%xmm0, %xmm0, %xmm2	# mean_v, mean_v, _473
# C/parallel-only-omp/simulation.h:264:         v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vmovsd	(%rdi), %xmm0	# MEM[(double *)_365], _472
	leaq	(%r14,%rax), %rdx	#, vectp.1098
# C/parallel-only-omp/simulation.h:264:         v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vfmadd132sd	%xmm0, %xmm2, %xmm0	# _472, _473, v_sqr
# C/parallel-only-omp/simulation.h:265:         energy = 0.5 * E_MASS * v_sqr / EV_TO_J;
	vmulsd	%xmm15, %xmm0, %xmm2	# tmp517, v_sqr, tmp414
# C/parallel-only-omp/simulation.h:265:         energy = 0.5 * E_MASS * v_sqr / EV_TO_J;
	vdivsd	%xmm14, %xmm2, %xmm2	# tmp519, tmp414, energy
# C/parallel-only-omp/simulation.h:267:         worker_buffers.meanee[tid][p]   += c1 * energy;
	vmovddup	%xmm2, %xmm19	# energy, tmp418
	vfmadd213pd	(%rdx), %xmm18, %xmm19	# MEM <vector(2) double> [(value_type &)vectp.1098_276], tmp397, vect__463.1101
	vmovupd	%xmm19, (%rdx)	# vect__463.1101, MEM <vector(2) double> [(value_type &)vectp.1098_276]
# C/parallel-only-omp/simulation.h:270:         energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES-1);
	vdivsd	%xmm12, %xmm2, %xmm19	# tmp512, energy, tmp422
# C/parallel-only-omp/simulation.h:270:         energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES-1);
	vaddsd	%xmm3, %xmm19, %xmm19	# tmp523, tmp422, tmp424
# C/parallel-only-omp/simulation.h:270:         energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES-1);
	vcvttsd2sil	%xmm19, %edx	# tmp424, tmp421
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmpl	%r8d, %edx	# tmp546, tmp421
# C/parallel-only-omp/simulation.h:271:         velocity = sqrt(v_sqr);
	vsqrtsd	%xmm0, %xmm0, %xmm0	# v_sqr, velocity
# /usr/include/c++/13/bits/stl_algobase.h:238:       if (__b < __a)
	cmovg	%r8d, %edx	# tmp421,, tmp546, tmp421
	addq	%r13, %rax	# _161, vectp.1105
# C/parallel-only-omp/simulation.h:272:         rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	movslq	%edx, %rdx	# tmp421, tmp426
# C/parallel-only-omp/simulation.h:272:         rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	vmulsd	16000000(%r9,%rdx,8), %xmm0, %xmm0	# sigma[2][_454], velocity, tmp428
# C/parallel-only-omp/simulation.h:272:         rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	vmulsd	%xmm5, %xmm0, %xmm0	# tmp520, tmp428, tmp429
# C/parallel-only-omp/simulation.h:272:         rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	vmulsd	%xmm11, %xmm0, %xmm0	# tmp524, tmp429, rate
# C/parallel-only-omp/simulation.h:274:         worker_buffers.ioniz[tid][p]   += c1 * rate;
	vmovddup	%xmm0, %xmm0	# rate, tmp433
	vfmadd213pd	(%rax), %xmm18, %xmm0	# MEM <vector(2) double> [(value_type &)vectp.1105_16], tmp397, vect__446.1108
	vmovupd	%xmm0, (%rax)	# vect__446.1108, MEM <vector(2) double> [(value_type &)vectp.1105_16]
# C/parallel-only-omp/simulation.h:278:         if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)) {
	vmovsd	(%rcx), %xmm18	# MEM[(double *)_373], prephitmp_423
# C/parallel-only-omp/simulation.h:278:         if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)) {
	vcomisd	%xmm10, %xmm18	# tmp518, prephitmp_423
	jbe	.L169	#,
# C/parallel-only-omp/simulation.h:278:         if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)) {
	vcomisd	%xmm18, %xmm16	# prephitmp_423, tmp525
	jbe	.L169	#,
# C/parallel-only-omp/simulation.h:279:             energy_index = (int)(energy / DE_EEPF);
	vdivsd	%xmm17, %xmm2, %xmm0	# tmp526, energy, tmp437
# C/parallel-only-omp/simulation.h:279:             energy_index = (int)(energy / DE_EEPF);
	vcvttsd2sil	%xmm0, %eax	# tmp437, energy_index
# C/parallel-only-omp/simulation.h:280:             if (energy_index < N_EEPF) {
	cmpl	$1999, %eax	#, energy_index
	jg	.L172	#,
# C/parallel-only-omp/simulation.h:281:                 worker_buffers.eepf[tid][energy_index] += 1.0;
	movq	16(%rsp), %rdx	# %sfp, _181
# C/parallel-only-omp/simulation.h:281:                 worker_buffers.eepf[tid][energy_index] += 1.0;
	cltq
# C/parallel-only-omp/simulation.h:281:                 worker_buffers.eepf[tid][energy_index] += 1.0;
	vaddsd	(%rdx,%rax,8), %xmm9, %xmm0	# MEM <struct array> [(value_type &)_181]._M_elems[_429], tmp510, tmp439
	vmovsd	%xmm0, (%rdx,%rax,8)	# tmp439, MEM <struct array> [(value_type &)_181]._M_elems[_429]
.L172:
# C/parallel-only-omp/simulation.h:283:             worker_buffers.thread_counters[tid].accu_center   += energy;
	vaddsd	(%r12), %xmm2, %xmm2	# _211->accu_center, energy, tmp442
# C/parallel-only-omp/simulation.h:284:             worker_buffers.thread_counters[tid].counter_center++;
	incq	8(%r12)	# _211->counter_center
# C/parallel-only-omp/simulation.h:283:             worker_buffers.thread_counters[tid].accu_center   += energy;
	vmovsd	%xmm2, (%r12)	# tmp442, _211->accu_center
# C/parallel-only-omp/simulation.h:289:         x_e[k]  += vx_e[k] * DT_E;
	vmovsd	(%rcx), %xmm18	# MEM[(double *)_373], prephitmp_423
.L169:
# C/parallel-only-omp/simulation.h:288:         vx_e[k] -= e_x * FACTOR_E;
	vfnmadd213sd	(%rsi), %xmm6, %xmm1	# MEM[(double *)_369], tmp516, e_x
	vmovsd	%xmm1, %xmm1, %xmm0	# e_x, _420
# C/parallel-only-omp/simulation.h:289:         x_e[k]  += vx_e[k] * DT_E;
	vfmadd132sd	%xmm5, %xmm18, %xmm0	# tmp520, prephitmp_423, _417
	addq	$8, %rcx	#, ivtmp.1186
# C/parallel-only-omp/simulation.h:288:         vx_e[k] -= e_x * FACTOR_E;
	vmovsd	%xmm1, (%rsi)	# _420, MEM[(double *)_369]
	addq	$8, %r10	#, ivtmp.1188
	addq	$8, %rsi	#, ivtmp.1187
	addq	$8, %rdi	#, ivtmp.1189
# C/parallel-only-omp/simulation.h:289:         x_e[k]  += vx_e[k] * DT_E;
	vmovsd	%xmm0, -8(%rcx)	# _417, MEM[(double *)_373]
	cmpq	%rcx, %rbp	# ivtmp.1186, _356
	jne	.L173	#,
	movl	12(%rsp), %ebp	# %sfp, num_threads
	movslq	24(%rsp), %r12	# %sfp,
.L174:
	call	GOMP_barrier@PLT	#
# C/parallel-only-omp/simulation.h:292:     if (measurement_mode) {
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	je	.L207	#,
	movl	$400, %eax	#, q.75_114
	xorl	%edx, %edx	# tt.76_115
	idivl	8(%rsp)	# %sfp
	cmpl	%edx, 4(%rsp)	# tt.76_115, %sfp
	jl	.L210	#,
.L175:
	movl	4(%rsp), %ecx	# %sfp, tmp452
	imull	%eax, %ecx	# q.75_114, tmp452
	addl	%ecx, %edx	# tmp452, _202
	leal	(%rax,%rdx), %ecx	#, tmp453
	cmpl	%ecx, %edx	# tmp453, _202
	jge	.L182	#,
	movslq	%edx, %r13	# _202, _79
	movslq	%ebp, %rdx	# num_threads, num_threads
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	48+worker_buffers(%rip), %rbx	# MEM[(struct vector *)&worker_buffers + 48B].D.103874._M_impl.D.103213._M_start, _304
	movq	72+worker_buffers(%rip), %r11	# MEM[(struct vector *)&worker_buffers + 72B].D.103874._M_impl.D.103213._M_start, _302
	movq	96+worker_buffers(%rip), %r10	# MEM[(struct vector *)&worker_buffers + 96B].D.103874._M_impl.D.103213._M_start, _300
	movq	120+worker_buffers(%rip), %r8	# MEM[(struct vector *)&worker_buffers + 120B].D.103874._M_impl.D.103213._M_start, _298
	movl	%eax, %edi	# q.75_114, q.75_114
	leaq	0(,%r13,8), %rsi	#, ivtmp.1177
	addq	%r13, %rdi	# _79, tmp471
	leaq	counter_e_xt(%rip), %r15	#, tmp514
	imulq	$200, %r13, %rcx	#, _79, tmp467
	leaq	ue_xt(%rip), %r14	#, tmp515
	imulq	$400, %rdx, %rdx	#, num_threads, tmp465
	salq	$3, %rdi	#, _398
	addq	%r13, %rdx	# _79, tmp466
	addq	%r12, %rcx	# t_index, tmp469
	leaq	meanee_xt(%rip), %r13	#, tmp521
	leaq	ioniz_rate_xt(%rip), %r12	#, tmp513
	salq	$3, %rdx	#, ivtmp.1178
	salq	$3, %rcx	#, ivtmp.1180
	.p2align 4
	.p2align 3
.L181:
# C/parallel-only-omp/simulation.h:297:             for (int t = 0; t < num_threads; t++) {
	testl	%ebp, %ebp	# num_threads
	jle	.L191	#,
	movq	%rsi, %rax	# ivtmp.1177, ivtmp.1166
# C/parallel-only-omp/simulation.h:296:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# iz
# C/parallel-only-omp/simulation.h:296:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm1	#, m_e
# C/parallel-only-omp/simulation.h:296:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm2	#, u_e
# C/parallel-only-omp/simulation.h:296:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm3	#, c_e
	.p2align 4
	.p2align 3
.L180:
# C/parallel-only-omp/simulation.h:298:                 c_e += worker_buffers.counter_e[t][p];
	vaddsd	(%rbx,%rax), %xmm3, %xmm3	# MEM[(value_type &)_304 + ivtmp.1166_193 * 1], c_e, c_e
# C/parallel-only-omp/simulation.h:299:                 u_e += worker_buffers.ue[t][p];
	vaddsd	(%r11,%rax), %xmm2, %xmm2	# MEM[(value_type &)_302 + ivtmp.1166_193 * 1], u_e, u_e
# C/parallel-only-omp/simulation.h:300:                 m_e += worker_buffers.meanee[t][p];
	vaddsd	(%r10,%rax), %xmm1, %xmm1	# MEM[(value_type &)_300 + ivtmp.1166_193 * 1], m_e, m_e
# C/parallel-only-omp/simulation.h:301:                 iz  += worker_buffers.ioniz[t][p];
	vaddsd	(%r8,%rax), %xmm0, %xmm0	# MEM[(value_type &)_298 + ivtmp.1166_193 * 1], iz, iz
# C/parallel-only-omp/simulation.h:297:             for (int t = 0; t < num_threads; t++) {
	addq	$3200, %rax	#, ivtmp.1166
	cmpq	%rax, %rdx	# ivtmp.1166, ivtmp.1178
	jne	.L180	#,
.L179:
	addq	$8, %rsi	#, ivtmp.1177
# C/parallel-only-omp/simulation.h:303:             counter_e_xt[p][t_index]   += c_e;
	vaddsd	(%r15,%rcx), %xmm3, %xmm3	# MEM[(double *)&counter_e_xt + ivtmp.1180_506 * 1], c_e, tmp474
# C/parallel-only-omp/simulation.h:304:             ue_xt[p][t_index]          += u_e;
	vaddsd	(%r14,%rcx), %xmm2, %xmm2	# MEM[(double *)&ue_xt + ivtmp.1180_506 * 1], u_e, tmp478
# C/parallel-only-omp/simulation.h:305:             meanee_xt[p][t_index]      += m_e;
	vaddsd	0(%r13,%rcx), %xmm1, %xmm1	# MEM[(double *)&meanee_xt + ivtmp.1180_506 * 1], m_e, tmp482
# C/parallel-only-omp/simulation.h:306:             ioniz_rate_xt[p][t_index]  += iz;
	vaddsd	(%r12,%rcx), %xmm0, %xmm0	# MEM[(double *)&ioniz_rate_xt + ivtmp.1180_506 * 1], iz, tmp486
# C/parallel-only-omp/simulation.h:303:             counter_e_xt[p][t_index]   += c_e;
	vmovsd	%xmm3, (%r15,%rcx)	# tmp474, MEM[(double *)&counter_e_xt + ivtmp.1180_506 * 1]
# C/parallel-only-omp/simulation.h:304:             ue_xt[p][t_index]          += u_e;
	vmovsd	%xmm2, (%r14,%rcx)	# tmp478, MEM[(double *)&ue_xt + ivtmp.1180_506 * 1]
# C/parallel-only-omp/simulation.h:305:             meanee_xt[p][t_index]      += m_e;
	vmovsd	%xmm1, 0(%r13,%rcx)	# tmp482, MEM[(double *)&meanee_xt + ivtmp.1180_506 * 1]
# C/parallel-only-omp/simulation.h:306:             ioniz_rate_xt[p][t_index]  += iz;
	vmovsd	%xmm0, (%r12,%rcx)	# tmp486, MEM[(double *)&ioniz_rate_xt + ivtmp.1180_506 * 1]
	addq	$8, %rdx	#, ivtmp.1178
	addq	$1600, %rcx	#, ivtmp.1180
	cmpq	%rdi, %rsi	# _398, ivtmp.1177
	jne	.L181	#,
.L182:
	movl	$2000, %eax	#, q.73_112
	xorl	%edx, %edx	# tt.74_113
	idivl	8(%rsp)	# %sfp
	cmpl	%edx, 4(%rsp)	# tt.74_113, %sfp
	jl	.L211	#,
.L178:
	movl	4(%rsp), %r9d	# %sfp, _142
	imull	%eax, %r9d	# q.73_112, _142
	addl	%r9d, %edx	# tmp488, _228
	leal	(%rax,%rdx), %ecx	#, tmp489
	cmpl	%ecx, %edx	# tmp489, _228
	jge	.L189	#,
	movslq	%ebp, %rdi	# num_threads, _129
	movslq	%edx, %rsi	# _228, _62
	movq	144+worker_buffers(%rip), %r9	# MEM[(struct vector *)&worker_buffers + 144B].D.104928._M_impl.D.104267._M_start, MEM[(struct vector *)&worker_buffers + 144B].D.104928._M_impl.D.104267._M_start
	leaq	eepf(%rip), %r8	#, tmp491
	imulq	$2000, %rdi, %rdx	#, _129, tmp492
	movl	%eax, %eax	# q.73_112, q.73_112
	leaq	(%r8,%rsi,8), %rcx	#, ivtmp.1150
	addq	%rsi, %rax	# _62, tmp498
	leaq	(%r8,%rax,8), %r8	#, _191
	addq	%rsi, %rdx	# _62, tmp493
	imulq	$-16000, %rdi, %rsi	#, _129, _72
	leaq	(%r9,%rdx,8), %rdx	#, ivtmp.1154
	.p2align 4
	.p2align 3
.L188:
# C/parallel-only-omp/simulation.h:313:             for (int t = 0; t < num_threads; t++) {
	testl	%ebp, %ebp	# num_threads
	jle	.L192	#,
	movq	%rsi, %rdi	# _72, tmp528
	leaq	(%rsi,%rdx), %rax	#, ivtmp.1144
# C/parallel-only-omp/simulation.h:312:             double sum_eepf = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# sum_eepf
	negq	%rdi	# tmp528
	andl	$128, %edi	#, tmp528
	je	.L187	#,
# C/parallel-only-omp/simulation.h:314:                 sum_eepf += worker_buffers.eepf[t][i];
	vaddsd	(%rax), %xmm0, %xmm0	# MEM[(value_type &)_177], sum_eepf, sum_eepf
# C/parallel-only-omp/simulation.h:313:             for (int t = 0; t < num_threads; t++) {
	addq	$16000, %rax	#, ivtmp.1144
	cmpq	%rdx, %rax	# ivtmp.1154, ivtmp.1144
	je	.L186	#,
	.p2align 4
	.p2align 3
.L187:
# C/parallel-only-omp/simulation.h:314:                 sum_eepf += worker_buffers.eepf[t][i];
	vaddsd	(%rax), %xmm0, %xmm0	# MEM[(value_type &)_177], sum_eepf, sum_eepf
# C/parallel-only-omp/simulation.h:313:             for (int t = 0; t < num_threads; t++) {
	addq	$32000, %rax	#, ivtmp.1144
# C/parallel-only-omp/simulation.h:314:                 sum_eepf += worker_buffers.eepf[t][i];
	vaddsd	-16000(%rax), %xmm0, %xmm0	# MEM[(value_type &)_177], sum_eepf, sum_eepf
# C/parallel-only-omp/simulation.h:313:             for (int t = 0; t < num_threads; t++) {
	cmpq	%rdx, %rax	# ivtmp.1154, ivtmp.1144
	jne	.L187	#,
.L186:
# C/parallel-only-omp/simulation.h:316:             eepf[i] += sum_eepf;
	vaddsd	(%rcx), %xmm0, %xmm0	# MEM[(double *)_340], sum_eepf, tmp501
	addq	$8, %rcx	#, ivtmp.1150
	vmovsd	%xmm0, -8(%rcx)	# tmp501, MEM[(double *)_340]
	addq	$8, %rdx	#, ivtmp.1154
	cmpq	%r8, %rcx	# _191, ivtmp.1150
	jne	.L188	#,
.L189:
	call	GOMP_barrier@PLT	#
	call	GOMP_single_start@PLT	#
	testb	%al, %al	# tmp542
	je	.L185	#,
# C/parallel-only-omp/simulation.h:322:             for (int t = 0; t < num_threads; t++) {
	testl	%ebp, %ebp	# num_threads
	jle	.L185	#,
	movq	168+worker_buffers(%rip), %rdx	# MEM[(struct vector *)&worker_buffers + 168B].D.105978._M_impl.D.105317._M_start, ivtmp.1137
	movq	mean_energy_counter_center(%rip), %rcx	# mean_energy_counter_center, mean_energy_counter_center_lsm.1094
	movslq	%ebp, %rax	# num_threads, num_threads
	vmovsd	mean_energy_accu_center(%rip), %xmm0	# mean_energy_accu_center, mean_energy_accu_center_lsm.1093
	salq	$6, %rax	#, tmp505
	addq	%rdx, %rax	# ivtmp.1137, _50
	.p2align 4
	.p2align 3
.L190:
# C/parallel-only-omp/simulation.h:324:                 mean_energy_counter_center += worker_buffers.thread_counters[t].counter_center;
	addq	8(%rdx), %rcx	# MEM[(long long unsigned int *)_47 + 8B], mean_energy_counter_center_lsm.1094
# C/parallel-only-omp/simulation.h:323:                 mean_energy_accu_center    += worker_buffers.thread_counters[t].accu_center;
	vaddsd	(%rdx), %xmm0, %xmm0	# MEM[(double *)_47], mean_energy_accu_center_lsm.1093, mean_energy_accu_center_lsm.1093
# C/parallel-only-omp/simulation.h:322:             for (int t = 0; t < num_threads; t++) {
	addq	$64, %rdx	#, ivtmp.1137
	cmpq	%rax, %rdx	# _50, ivtmp.1137
	jne	.L190	#,
	vmovsd	%xmm0, mean_energy_accu_center(%rip)	# mean_energy_accu_center_lsm.1093, mean_energy_accu_center
	movq	%rcx, mean_energy_counter_center(%rip)	# mean_energy_counter_center_lsm.1094, mean_energy_counter_center
.L185:
# C/parallel-only-omp/simulation.h:328: }
	addq	$40, %rsp	#,
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
.L211:
	.cfi_restore_state
	incl	%eax	# q.73_112
# C/parallel-only-omp/simulation.h:296:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	xorl	%edx, %edx	# tt.74_113
	jmp	.L178	#
.L210:
	incl	%eax	# q.75_114
# C/parallel-only-omp/simulation.h:292:     if (measurement_mode) {
	xorl	%edx, %edx	# tt.76_115
	jmp	.L175	#
.L209:
	incl	%eax	# q.77_116
# C/parallel-only-omp/simulation.h:241:         worker_buffers.thread_counters[tid].counter_center = 0;
	xorl	%edx, %edx	# tt.78_117
	jmp	.L166	#
.L192:
# C/parallel-only-omp/simulation.h:312:             double sum_eepf = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# sum_eepf
	jmp	.L186	#
.L191:
# C/parallel-only-omp/simulation.h:296:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	vxorpd	%xmm0, %xmm0, %xmm0	# iz
# C/parallel-only-omp/simulation.h:296:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm1	#, m_e
# C/parallel-only-omp/simulation.h:296:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm2	#, u_e
# C/parallel-only-omp/simulation.h:296:             double c_e = 0.0, u_e = 0.0, m_e = 0.0, iz = 0.0;
	vmovsd	%xmm0, %xmm0, %xmm3	#, c_e
	jmp	.L179	#
	.cfi_endproc
.LFE9876:
