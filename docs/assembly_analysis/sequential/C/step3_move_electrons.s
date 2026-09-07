# --- Symbol: _Z20step3_move_electronsi ---
	.section	.text._Z20step3_move_electronsi,"axG",@progbits,_Z20step3_move_electronsi,comdat
	.p2align 4
	.weak	_Z20step3_move_electronsi
	.type	_Z20step3_move_electronsi, @function
_Z20step3_move_electronsi:
.LFB3866:
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
# simulation.h:73: inline void step3_move_electrons(int t_index){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp348
	movq	%rax, 24(%rsp)	# tmp348, D.82720
	xorl	%eax, %eax	# tmp348
# simulation.h:77:     for(k=0; k<N_e; k++){                       // move all electrons in every time step
	movslq	N_e(%rip), %rax	# N_e,
	testl	%eax, %eax	# N_e.53_105
	jle	.L188	#,
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	vxorps	%xmm8, %xmm8, %xmm8	# tmp345
	jne	.L190	#,
	leaq	x_e(%rip), %rdx	#, ivtmp.913
	leaq	vx_e(%rip), %rcx	#, ivtmp.914
	leaq	efield(%rip), %r15	#, tmp324
	vmovsd	.LC67(%rip), %xmm7	#, tmp326
	leaq	(%rdx,%rax,8), %rdi	#, _142
	vmovsd	.LC12(%rip), %xmm6	#, tmp328
	vmovsd	.LC77(%rip), %xmm5	#, tmp339
	vmovsd	.LC69(%rip), %xmm4	#, tmp327
	.p2align 4
	.p2align 3
.L191:
# simulation.h:80:         c0  = x_e[k] * INV_DX;
	vmovsd	(%rdx), %xmm3	# MEM[(double *)_177], _157
# simulation.h:80:         c0  = x_e[k] * INV_DX;
	vmulsd	%xmm7, %xmm3, %xmm1	# tmp326, _157, c0
# simulation.h:81:         p   = int(c0);
	vcvttsd2sil	%xmm1, %eax	# c0, p
# simulation.h:82:         c1  = p + 1.0 - c0;
	vcvtsi2sdl	%eax, %xmm8, %xmm2	# p, tmp345, tmp346
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%eax, %rsi	# p, p
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	incl	%eax	# tmp186
# simulation.h:82:         c1  = p + 1.0 - c0;
	vaddsd	%xmm6, %xmm2, %xmm0	# tmp328, _154, tmp182
# simulation.h:82:         c1  = p + 1.0 - c0;
	vsubsd	%xmm1, %xmm0, %xmm0	# c0, tmp182, c1
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	cltq
# simulation.h:83:         c2  = c0 - p;
	vsubsd	%xmm2, %xmm1, %xmm1	# _154, c0, c2
# simulation.h:77:     for(k=0; k<N_e; k++){                       // move all electrons in every time step
	addq	$8, %rdx	#, ivtmp.913
	addq	$8, %rcx	#, ivtmp.914
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vmulsd	(%r15,%rax,8), %xmm1, %xmm1	# efield[_148], c2, tmp189
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vfmadd132sd	(%r15,%rsi,8), %xmm1, %xmm0	# efield[p_155], tmp189, e_x
# simulation.h:115:         vx_e[k] -= e_x * FACTOR_E;
	vfnmadd213sd	-8(%rcx), %xmm5, %xmm0	# MEM[(double *)_179], tmp339, _187
	vmovsd	%xmm0, -8(%rcx)	# _187, MEM[(double *)_179]
# simulation.h:116:         x_e[k]  += vx_e[k] * DT_E;
	vfmadd132sd	%xmm4, %xmm3, %xmm0	# tmp327, _157, _190
	vmovsd	%xmm0, -8(%rdx)	# _190, MEM[(double *)_177]
# simulation.h:77:     for(k=0; k<N_e; k++){                       // move all electrons in every time step
	cmpq	%rdx, %rdi	# ivtmp.913, _142
	jne	.L191	#,
.L188:
# simulation.h:118: }
	movq	24(%rsp), %rax	# D.82720, tmp349
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp349
	jne	.L206	#,
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
.L190:
	.cfi_restore_state
	leaq	x_e(%rip), %r14	#, ivtmp.920
	leaq	20(%rsp), %rsi	#, tmp333
	movslq	%edi, %r13	# t_index, t_index
	leaq	vx_e(%rip), %rbx	#, ivtmp.921
	leaq	(%r14,%rax,8), %rax	#, _120
	leaq	vy_e(%rip), %r12	#, ivtmp.922
	leaq	vz_e(%rip), %rbp	#, ivtmp.923
	leaq	efield(%rip), %r15	#, tmp324
	movq	%rax, 8(%rsp)	# _120, %sfp
	leaq	sigma(%rip), %rax	#, tmp338
	leaq	counter_e_xt(%rip), %r11	#, tmp325
	leaq	ue_xt(%rip), %r10	#, tmp329
	leaq	meanee_xt(%rip), %r9	#, tmp332
	leaq	16(%rsp), %rdi	#, tmp331
	vmovq	%rax, %xmm9	# tmp338, tmp338
	leaq	ioniz_rate_xt(%rip), %r8	#, tmp323
# simulation.h:106:             if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)){
	vmovq	%rsi, %xmm13	# tmp333, tmp333
	vmovsd	.LC67(%rip), %xmm7	#, tmp326
	vmovsd	.LC12(%rip), %xmm6	#, tmp328
	vmovsd	.LC77(%rip), %xmm5	#, tmp339
	vmovsd	.LC69(%rip), %xmm4	#, tmp327
	vmovsd	.LC46(%rip), %xmm10	#, tmp334
	vmovsd	.LC78(%rip), %xmm16	#, tmp340
	vmovsd	.LC51(%rip), %xmm15	#, tmp330
	vmovsd	.LC3(%rip), %xmm14	#, tmp337
	vmovsd	.LC48(%rip), %xmm12	#, tmp335
	vmovsd	.LC79(%rip), %xmm11	#, tmp341
	vmovsd	.LC80(%rip), %xmm17	#, tmp342
	.p2align 4
	.p2align 3
.L197:
# simulation.h:80:         c0  = x_e[k] * INV_DX;
	vmovsd	(%r14), %xmm18	# MEM[(double *)_129], _1
# simulation.h:80:         c0  = x_e[k] * INV_DX;
	vmulsd	%xmm7, %xmm18, %xmm1	# tmp326, _1, c0
# simulation.h:81:         p   = int(c0);
	vcvttsd2sil	%xmm1, %edx	# c0, p
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	leal	1(%rdx), %ecx	#, _6
# simulation.h:82:         c1  = p + 1.0 - c0;
	vcvtsi2sdl	%edx, %xmm8, %xmm0	# p, tmp345, tmp347
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%ecx, %rcx	# _6, _6
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	movslq	%edx, %rdx	# p, p
# simulation.h:82:         c1  = p + 1.0 - c0;
	vaddsd	%xmm6, %xmm0, %xmm3	# tmp328, _2, tmp195
# simulation.h:90:             mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E;
	vmovsd	(%rbx), %xmm19	# MEM[(double *)_127], pretmp_162
# simulation.h:82:         c1  = p + 1.0 - c0;
	vsubsd	%xmm1, %xmm3, %xmm3	# c0, tmp195, c1
# simulation.h:83:         c2  = c0 - p;
	vsubsd	%xmm0, %xmm1, %xmm1	# _2, c0, c2
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vmulsd	(%r15,%rcx,8), %xmm1, %xmm2	# efield[_6], c2, tmp201
# simulation.h:92:             counter_e_xt[p+1][t_index] += c2;
	imulq	$200, %rcx, %rcx	#, _6, tmp220
# simulation.h:84:         e_x = c1 * efield[p] + c2 * efield[p+1];
	vfmadd231sd	(%r15,%rdx,8), %xmm3, %xmm2	# efield[p_68], c1, e_x
# simulation.h:90:             mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E;
	vmulsd	%xmm10, %xmm2, %xmm0	# tmp334, e_x, tmp202
# simulation.h:90:             mean_v = vx_e[k] - 0.5 * e_x * FACTOR_E;
	vfnmadd132sd	%xmm5, %xmm19, %xmm0	# tmp339, pretmp_162, mean_v
# simulation.h:91:             counter_e_xt[p][t_index]   += c1;
	imulq	$200, %rdx, %rdx	#, p, tmp208
# simulation.h:99:             energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
	vmovq	%xmm13, %rsi	# tmp333,
# simulation.h:97:             meanee_xt[p][t_index]   += c1 * energy;
	vmovsd	%xmm3, %xmm3, %xmm21	# c1, _32
# simulation.h:99:             energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
	movl	$999999, 20(%rsp)	#, D.72182
# simulation.h:92:             counter_e_xt[p+1][t_index] += c2;
	addq	%r13, %rcx	# t_index, tmp221
# simulation.h:91:             counter_e_xt[p][t_index]   += c1;
	addq	%r13, %rdx	# t_index, tmp209
	vaddsd	(%r11,%rdx,8), %xmm3, %xmm20	# counter_e_xt[p_68][t_index_73(D)], c1, tmp215
	vmovsd	%xmm20, (%r11,%rdx,8)	# tmp215, counter_e_xt[p_68][t_index_73(D)]
# simulation.h:92:             counter_e_xt[p+1][t_index] += c2;
	vaddsd	(%r11,%rcx,8), %xmm1, %xmm20	# counter_e_xt[_6][t_index_73(D)], c2, tmp227
	vmovsd	%xmm20, (%r11,%rcx,8)	# tmp227, counter_e_xt[_6][t_index_73(D)]
# simulation.h:93:             ue_xt[p][t_index]   += c1 * mean_v;
	vmovsd	%xmm3, %xmm3, %xmm20	# c1, _19
	vfmadd213sd	(%r10,%rdx,8), %xmm0, %xmm20	# ue_xt[p_68][t_index_73(D)], mean_v, _19
	vmovsd	%xmm20, (%r10,%rdx,8)	# _19, ue_xt[p_68][t_index_73(D)]
# simulation.h:94:             ue_xt[p+1][t_index] += c2 * mean_v;
	vmovsd	%xmm1, %xmm1, %xmm20	# c2, _22
	vfmadd213sd	(%r10,%rcx,8), %xmm0, %xmm20	# ue_xt[_6][t_index_73(D)], mean_v, _22
	vmovsd	%xmm20, (%r10,%rcx,8)	# _22, ue_xt[_6][t_index_73(D)]
# simulation.h:95:             v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vmovsd	(%r12), %xmm20	# MEM[(double *)_125], _24
# simulation.h:95:             v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vmulsd	%xmm20, %xmm20, %xmm20	# _24, _24, tmp249
# simulation.h:95:             v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vfmadd231sd	%xmm0, %xmm0, %xmm20	# mean_v, mean_v, _26
# simulation.h:95:             v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vmovsd	0(%rbp), %xmm0	# MEM[(double *)_124], _27
# simulation.h:95:             v_sqr  = mean_v * mean_v + vy_e[k] * vy_e[k] + vz_e[k] * vz_e[k];
	vfmadd132sd	%xmm0, %xmm20, %xmm0	# _27, _26, v_sqr
# simulation.h:96:             energy = 0.5 * E_MASS * v_sqr / EV_TO_J;
	vmulsd	%xmm16, %xmm0, %xmm20	# tmp340, v_sqr, tmp250
# simulation.h:96:             energy = 0.5 * E_MASS * v_sqr / EV_TO_J;
	vdivsd	%xmm15, %xmm20, %xmm20	# tmp330, tmp250, energy
# simulation.h:97:             meanee_xt[p][t_index]   += c1 * energy;
	vfmadd213sd	(%r9,%rdx,8), %xmm20, %xmm21	# meanee_xt[p_68][t_index_73(D)], energy, _32
	vmovsd	%xmm21, (%r9,%rdx,8)	# _32, meanee_xt[p_68][t_index_73(D)]
# simulation.h:98:             meanee_xt[p+1][t_index] += c2 * energy;
	vmovsd	%xmm1, %xmm1, %xmm21	# c2, _35
	vfmadd213sd	(%r9,%rcx,8), %xmm20, %xmm21	# meanee_xt[_6][t_index_73(D)], energy, _35
	vmovsd	%xmm21, (%r9,%rcx,8)	# _35, meanee_xt[_6][t_index_73(D)]
# simulation.h:99:             energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
	vdivsd	%xmm14, %xmm20, %xmm21	# tmp337, energy, tmp273
# simulation.h:99:             energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
	vaddsd	%xmm10, %xmm21, %xmm21	# tmp334, tmp273, tmp275
# simulation.h:99:             energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
	vcvttsd2sil	%xmm21, %eax	# tmp275, tmp277
	movl	%eax, 16(%rsp)	# tmp277, D.72181
# simulation.h:99:             energy_index = min( int(energy / DE_CS + 0.5), CS_RANGES-1);
	call	_ZSt3minIiERKT_S2_S2_.constprop.0	#
# simulation.h:101:             rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	movslq	(%rax), %rax	# *_39, energy_index
# simulation.h:101:             rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	vmovq	%xmm9, %rsi	# tmp338, tmp338
# simulation.h:100:             velocity = sqrt(v_sqr);
	vsqrtsd	%xmm0, %xmm0, %xmm0	# v_sqr, velocity
# simulation.h:106:             if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)){
	vcomisd	%xmm11, %xmm18	# tmp341, _1
# simulation.h:101:             rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	vmulsd	16000000(%rsi,%rax,8), %xmm0, %xmm0	# sigma[2][energy_index_84], velocity, tmp283
# simulation.h:101:             rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	vmulsd	%xmm4, %xmm0, %xmm0	# tmp327, tmp283, tmp284
# simulation.h:101:             rate = sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY;
	vmulsd	%xmm12, %xmm0, %xmm0	# tmp335, tmp284, rate
# simulation.h:102:             ioniz_rate_xt[p][t_index]   += c1 * rate;
	vfmadd213sd	(%r8,%rdx,8), %xmm0, %xmm3	# ioniz_rate_xt[p_68][t_index_73(D)], rate, _45
	vmovsd	%xmm3, (%r8,%rdx,8)	# _45, ioniz_rate_xt[p_68][t_index_73(D)]
# simulation.h:103:             ioniz_rate_xt[p+1][t_index] += c2 * rate;
	vfmadd213sd	(%r8,%rcx,8), %xmm1, %xmm0	# ioniz_rate_xt[_6][t_index_73(D)], c2, _48
	vmovsd	%xmm0, (%r8,%rcx,8)	# _48, ioniz_rate_xt[_6][t_index_73(D)]
# simulation.h:106:             if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)){
	jbe	.L193	#,
# simulation.h:106:             if ((MIN_X < x_e[k]) && (x_e[k] < MAX_X)){
	vcomisd	%xmm18, %xmm17	# _1, tmp342
	jbe	.L193	#,
# simulation.h:107:                 energy_index = (int)(energy / DE_EEPF);
	vdivsd	.LC20(%rip), %xmm20, %xmm0	#, energy, tmp309
# simulation.h:107:                 energy_index = (int)(energy / DE_EEPF);
	vcvttsd2sil	%xmm0, %eax	# tmp309, energy_index
# simulation.h:108:                 if (energy_index < N_EEPF) {eepf[energy_index] += 1.0;}
	cmpl	$1999, %eax	#, energy_index
	jle	.L207	#,
.L196:
# simulation.h:109:                 mean_energy_accu_center += energy;
	vaddsd	mean_energy_accu_center(%rip), %xmm20, %xmm20	# mean_energy_accu_center, energy, tmp318
# simulation.h:110:                 mean_energy_counter_center++;
	incq	mean_energy_counter_center(%rip)	# mean_energy_counter_center
# simulation.h:109:                 mean_energy_accu_center += energy;
	vmovsd	%xmm20, mean_energy_accu_center(%rip)	# tmp318, mean_energy_accu_center
	.p2align 4
	.p2align 3
.L193:
# simulation.h:115:         vx_e[k] -= e_x * FACTOR_E;
	vfnmadd132sd	%xmm5, %xmm19, %xmm2	# tmp339, pretmp_162, e_x
# simulation.h:77:     for(k=0; k<N_e; k++){                       // move all electrons in every time step
	addq	$8, %r14	#, ivtmp.920
	addq	$8, %rbx	#, ivtmp.921
	addq	$8, %r12	#, ivtmp.922
	addq	$8, %rbp	#, ivtmp.923
# simulation.h:115:         vx_e[k] -= e_x * FACTOR_E;
	vmovsd	%xmm2, %xmm2, %xmm0	# e_x, _58
# simulation.h:116:         x_e[k]  += vx_e[k] * DT_E;
	vfmadd132sd	%xmm4, %xmm18, %xmm0	# tmp327, _1, _60
# simulation.h:115:         vx_e[k] -= e_x * FACTOR_E;
	vmovsd	%xmm2, -8(%rbx)	# _58, MEM[(double *)_127]
# simulation.h:116:         x_e[k]  += vx_e[k] * DT_E;
	vmovsd	%xmm0, -8(%r14)	# _60, MEM[(double *)_129]
# simulation.h:77:     for(k=0; k<N_e; k++){                       // move all electrons in every time step
	cmpq	%r14, 8(%rsp)	# ivtmp.920, %sfp
	jne	.L197	#,
	jmp	.L188	#
	.p2align 4
	.p2align 3
.L207:
# simulation.h:108:                 if (energy_index < N_EEPF) {eepf[energy_index] += 1.0;}
	leaq	eepf(%rip), %rdx	#, tmp311
	cltq
	vaddsd	(%rdx,%rax,8), %xmm6, %xmm0	# eepf[energy_index_92], tmp328, tmp315
	vmovsd	%xmm0, (%rdx,%rax,8)	# tmp315, eepf[energy_index_92]
	jmp	.L196	#
.L206:
# simulation.h:118: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE3866:
	.size	_Z20step3_move_electronsi, .-_Z20step3_move_electronsi


