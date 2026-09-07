# --- Symbol: _Z15step4_move_ionsii ---
	.section	.text._Z15step4_move_ionsii,"axG",@progbits,_Z15step4_move_ionsii,comdat
	.p2align 4
	.weak	_Z15step4_move_ionsii
	.type	_Z15step4_move_ionsii, @function
_Z15step4_move_ionsii:
.LFB3867:
	.cfi_startproc
	endbr64	
# simulation.h:133:         if (measurement_mode) {
	imull	$-858993459, %esi, %eax	#, tmp280, tmp159
	addl	$429496728, %eax	#, tmp160
	rorx	$2, %eax, %eax	#, tmp160, tmp161
# simulation.h:121:     if ((t % N_SUB) != 0) return;
	cmpl	$214748364, %eax	#, tmp161
	ja	.L219	#,
# simulation.h:126:     for(k=0; k<N_i; k++){
	movslq	N_i(%rip), %r8	# N_i,
	testl	%r8d, %r8d	# N_i.55_69
	jle	.L219	#,
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	vxorps	%xmm5, %xmm5, %xmm5	# tmp281
	jne	.L211	#,
	leaq	x_i(%rip), %rax	#, ivtmp.933
	leaq	vx_i(%rip), %rcx	#, ivtmp.934
	leaq	efield(%rip), %rsi	#, tmp268
	vmovsd	.LC67(%rip), %xmm8	#, tmp264
	leaq	(%rax,%r8,8), %r9	#, _88
	vmovsd	.LC81(%rip), %xmm6	#, tmp278
	vmovsd	.LC70(%rip), %xmm7	#, tmp267
	.p2align 4
	.p2align 3
.L212:
# simulation.h:127:         c0  = x_i[k] * INV_DX;
	vmovsd	(%rax), %xmm3	# MEM[(double *)_95], _115
# simulation.h:127:         c0  = x_i[k] * INV_DX;
	vmulsd	%xmm8, %xmm3, %xmm1	# tmp264, _115, c0
# simulation.h:128:         p   = int(c0);
	vcvttsd2sil	%xmm1, %edi	# c0, p
# simulation.h:129:         c1  = p + 1 - c0;
	leal	1(%rdi), %edx	#, _112
# simulation.h:129:         c1  = p + 1 - c0;
	vcvtsi2sdl	%edx, %xmm5, %xmm0	# _112, tmp281, tmp282
# simulation.h:131:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%edi, %r8	# p, p
# simulation.h:131:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%edx, %rdx	# _112, _112
# simulation.h:129:         c1  = p + 1 - c0;
	vsubsd	%xmm1, %xmm0, %xmm0	# c0, tmp167, c1
# simulation.h:130:         c2  = c0 - p;
	vcvtsi2sdl	%edi, %xmm5, %xmm2	# p, tmp281, tmp283
# simulation.h:130:         c2  = c0 - p;
	vsubsd	%xmm2, %xmm1, %xmm1	# tmp169, c0, c2
# simulation.h:131:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vmulsd	(%rsi,%rdx,8), %xmm1, %xmm1	# efield[_112], c2, tmp173
# simulation.h:131:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vfmadd132sd	(%rsi,%r8,8), %xmm1, %xmm0	# efield[p_113], tmp173, e_x
# simulation.h:147:         vx_i[k] += e_x * FACTOR_I;
	vfmadd213sd	(%rcx), %xmm6, %xmm0	# MEM[(double *)_93], tmp278, _11
	vmovsd	%xmm0, (%rcx)	# _11, MEM[(double *)_93]
# simulation.h:148:         x_i[k]  += vx_i[k] * DT_I;
	vfmadd132sd	%xmm7, %xmm3, %xmm0	# tmp267, _115, _122
# simulation.h:126:     for(k=0; k<N_i; k++){
	addq	$8, %rax	#, ivtmp.933
	addq	$8, %rcx	#, ivtmp.934
# simulation.h:148:         x_i[k]  += vx_i[k] * DT_I;
	vmovsd	%xmm0, -8(%rax)	# _122, MEM[(double *)_95]
# simulation.h:126:     for(k=0; k<N_i; k++){
	cmpq	%rax, %r9	# ivtmp.933, _88
	jne	.L212	#,
	ret	
	.p2align 4
	.p2align 3
.L211:
	salq	$3, %r8	#, _84
	vmovsd	.LC67(%rip), %xmm8	#, tmp264
	vmovsd	.LC81(%rip), %xmm6	#, tmp278
	vmovsd	.LC70(%rip), %xmm7	#, tmp267
	vmovsd	.LC46(%rip), %xmm12	#, tmp265
	vmovsd	.LC53(%rip), %xmm11	#, tmp274
	vmovsd	.LC51(%rip), %xmm10	#, tmp273
# simulation.h:120: inline void step4_move_ions(int t_index, int t){
	pushq	%r13	#
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movslq	%edi, %r11	# t_index, t_index
	pushq	%r12	#
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
# simulation.h:133:         if (measurement_mode) {
	xorl	%ecx, %ecx	# ivtmp.945
# simulation.h:120: inline void step4_move_ions(int t_index, int t){
	pushq	%rbp	#
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	leaq	efield(%rip), %rsi	#, tmp268
	pushq	%rbx	#
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	leaq	x_i(%rip), %rbp	#, tmp276
	leaq	vx_i(%rip), %rbx	#, tmp271
	leaq	counter_i_xt(%rip), %r10	#, tmp277
	leaq	ui_xt(%rip), %r9	#, tmp266
	leaq	vy_i(%rip), %r13	#, tmp270
	leaq	vz_i(%rip), %r12	#, tmp269
	leaq	meanei_xt(%rip), %rdi	#, tmp275
	.p2align 4
	.p2align 3
.L214:
# simulation.h:127:         c0  = x_i[k] * INV_DX;
	vmovsd	0(%rbp,%rcx), %xmm13	# MEM[(double *)&x_i + ivtmp.945_87 * 1], _2
# simulation.h:127:         c0  = x_i[k] * INV_DX;
	vmulsd	%xmm8, %xmm13, %xmm0	# tmp264, _2, c0
# simulation.h:128:         p   = int(c0);
	vcvttsd2sil	%xmm0, %eax	# c0, p
# simulation.h:129:         c1  = p + 1 - c0;
	leal	1(%rax), %edx	#, _3
# simulation.h:129:         c1  = p + 1 - c0;
	vcvtsi2sdl	%edx, %xmm5, %xmm2	# _3, tmp281, tmp284
# simulation.h:130:         c2  = c0 - p;
	vcvtsi2sdl	%eax, %xmm5, %xmm1	# p, tmp281, tmp285
# simulation.h:131:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%edx, %rdx	# _3, _3
# simulation.h:131:         e_x = c1 * efield[p] + c2 * efield[p+1];
	cltq
# simulation.h:129:         c1  = p + 1 - c0;
	vsubsd	%xmm0, %xmm2, %xmm4	# c0, tmp179, c1
# simulation.h:135:             mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I;
	vmovsd	(%rbx,%rcx), %xmm14	# MEM[(double *)&vx_i + ivtmp.945_87 * 1], pretmp_120
# simulation.h:130:         c2  = c0 - p;
	vsubsd	%xmm1, %xmm0, %xmm0	# tmp180, c0, c2
# simulation.h:131:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vmulsd	(%rsi,%rdx,8), %xmm0, %xmm9	# efield[_3], c2, tmp185
# simulation.h:137:             counter_i_xt[p+1][t_index] += c2;
	imulq	$200, %rdx, %rdx	#, _3, tmp205
# simulation.h:131:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vfmadd231sd	(%rsi,%rax,8), %xmm4, %xmm9	# efield[p_50], c1, e_x
# simulation.h:135:             mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I;
	vmulsd	%xmm12, %xmm9, %xmm1	# tmp265, e_x, tmp187
# simulation.h:135:             mean_v = vx_i[k] + 0.5 * e_x * FACTOR_I;
	vfmadd132sd	%xmm6, %xmm14, %xmm1	# tmp278, pretmp_120, mean_v
# simulation.h:136:             counter_i_xt[p][t_index]   += c1;
	imulq	$200, %rax, %rax	#, p, tmp193
# simulation.h:140:             v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	0(%r13,%rcx), %xmm3	# MEM[(double *)&vy_i + ivtmp.945_87 * 1], _25
# simulation.h:140:             v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmulsd	%xmm3, %xmm3, %xmm3	# _25, _25, tmp235
# simulation.h:137:             counter_i_xt[p+1][t_index] += c2;
	addq	%r11, %rdx	# t_index, tmp206
# simulation.h:136:             counter_i_xt[p][t_index]   += c1;
	addq	%r11, %rax	# t_index, tmp194
	vaddsd	(%r10,%rax,8), %xmm4, %xmm2	# counter_i_xt[p_50][t_index_55(D)], c1, tmp200
	vmovsd	%xmm2, (%r10,%rax,8)	# tmp200, counter_i_xt[p_50][t_index_55(D)]
# simulation.h:137:             counter_i_xt[p+1][t_index] += c2;
	vaddsd	(%r10,%rdx,8), %xmm0, %xmm2	# counter_i_xt[_3][t_index_55(D)], c2, tmp212
	vmovsd	%xmm2, (%r10,%rdx,8)	# tmp212, counter_i_xt[_3][t_index_55(D)]
# simulation.h:138:             ui_xt[p][t_index]   += c1 * mean_v;
	vmovsd	%xmm4, %xmm4, %xmm2	# c1, _20
	vfmadd213sd	(%r9,%rax,8), %xmm1, %xmm2	# ui_xt[p_50][t_index_55(D)], mean_v, _20
	vmovsd	%xmm2, (%r9,%rax,8)	# _20, ui_xt[p_50][t_index_55(D)]
# simulation.h:139:             ui_xt[p+1][t_index] += c2 * mean_v;
	vmovsd	%xmm0, %xmm0, %xmm2	# c2, _23
	vfmadd213sd	(%r9,%rdx,8), %xmm1, %xmm2	# ui_xt[_3][t_index_55(D)], mean_v, _23
	vmovsd	%xmm2, (%r9,%rdx,8)	# _23, ui_xt[_3][t_index_55(D)]
# simulation.h:140:             v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	%xmm1, %xmm1, %xmm2	# mean_v, mean_v
	vfmadd132sd	%xmm1, %xmm3, %xmm2	# mean_v, tmp235, mean_v
# simulation.h:140:             v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r12,%rcx), %xmm1	# MEM[(double *)&vz_i + ivtmp.945_87 * 1], _28
# simulation.h:140:             v_sqr  = mean_v * mean_v + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd132sd	%xmm1, %xmm2, %xmm1	# _28, _27, v_sqr
# simulation.h:141:             energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vmulsd	%xmm11, %xmm1, %xmm1	# tmp274, v_sqr, tmp237
# simulation.h:141:             energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vdivsd	%xmm10, %xmm1, %xmm1	# tmp273, tmp237, energy
# simulation.h:142:             meanei_xt[p][t_index]   += c1 * energy;
	vfmadd213sd	(%rdi,%rax,8), %xmm1, %xmm4	# meanei_xt[p_50][t_index_55(D)], energy, _33
	vmovsd	%xmm4, (%rdi,%rax,8)	# _33, meanei_xt[p_50][t_index_55(D)]
# simulation.h:143:             meanei_xt[p+1][t_index] += c2 * energy;
	vfmadd213sd	(%rdi,%rdx,8), %xmm1, %xmm0	# meanei_xt[_3][t_index_55(D)], energy, _36
	vmovsd	%xmm0, (%rdi,%rdx,8)	# _36, meanei_xt[_3][t_index_55(D)]
# simulation.h:147:         vx_i[k] += e_x * FACTOR_I;
	vmovsd	%xmm9, %xmm9, %xmm0	# e_x, e_x
	vfmadd132sd	%xmm6, %xmm14, %xmm0	# tmp278, pretmp_120, e_x
	vmovsd	%xmm0, (%rbx,%rcx)	# _39, MEM[(double *)&vx_i + ivtmp.945_87 * 1]
# simulation.h:148:         x_i[k]  += vx_i[k] * DT_I;
	vfmadd132sd	%xmm7, %xmm13, %xmm0	# tmp267, _2, _41
	vmovsd	%xmm0, 0(%rbp,%rcx)	# _41, MEM[(double *)&x_i + ivtmp.945_87 * 1]
# simulation.h:126:     for(k=0; k<N_i; k++){
	addq	$8, %rcx	#, ivtmp.945
	cmpq	%rcx, %r8	# ivtmp.945, _84
	jne	.L214	#,
# simulation.h:150: }
	popq	%rbx	#
	.cfi_def_cfa_offset 32
	popq	%rbp	#
	.cfi_def_cfa_offset 24
	popq	%r12	#
	.cfi_def_cfa_offset 16
	popq	%r13	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4
	.p2align 3
.L219:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret	
	.cfi_endproc
.LFE3867:
	.size	_Z15step4_move_ionsii, .-_Z15step4_move_ionsii


