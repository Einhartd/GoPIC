# --- Symbol: _Z13collision_ionPdS_S_S_S_S_i.isra.0 ---
	.section	.text._Z13collision_ionPdS_S_S_S_S_i.isra.0,"axG",@progbits,_Z20step8_collision_ionsi,comdat
	.p2align 4
	.type	_Z13collision_ionPdS_S_S_S_S_i.isra.0, @function
_Z13collision_ionPdS_S_S_S_S_i.isra.0:
.LFB4768:
	.cfi_startproc
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movslq	%ecx, %r13	# tmp216,
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %r12	# tmp210, vx_1
	subq	$104, %rsp	#,
	.cfi_def_cfa_offset 160
# collisions.h:110:     gx = (*vx_1)-(*vx_2);
	vmovsd	(%rdi), %xmm5	# *vx_1_1(D), _2
# collisions.h:111:     gy = (*vy_1)-(*vy_2);
	vmovsd	(%rsi), %xmm4	# *vy_1_5(D), _6
# collisions.h:110:     gx = (*vx_1)-(*vx_2);
	vsubsd	%xmm0, %xmm5, %xmm7	# ISRA.1670, _2, gx
# collisions.h:111:     gy = (*vy_1)-(*vy_2);
	vsubsd	%xmm1, %xmm4, %xmm6	# ISRA.1671, _6, gy
# collisions.h:113:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vmovsd	%xmm7, %xmm7, %xmm9	# gx, _15
# collisions.h:113:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vmulsd	%xmm6, %xmm6, %xmm10	# gy, gy, _14
# collisions.h:113:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vfmadd132sd	%xmm7, %xmm10, %xmm9	# gx, _14, _15
# collisions.h:112:     gz = (*vz_1)-(*vz_2);
	vmovsd	(%rdx), %xmm3	# *vz_1_9(D), _10
# collisions.h:114:     wx = 0.5 * ((*vx_1) + (*vx_2));
	vaddsd	%xmm0, %xmm5, %xmm5	# ISRA.1670, _2, tmp160
# collisions.h:112:     gz = (*vz_1)-(*vz_2);
	vsubsd	%xmm2, %xmm3, %xmm8	# ISRA.1672, _10, gz
# collisions.h:114:     wx = 0.5 * ((*vx_1) + (*vx_2));
	vmulsd	.LC46(%rip), %xmm5, %xmm5	#, tmp160, wx
# collisions.h:113:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vmulsd	%xmm8, %xmm8, %xmm11	# gz, gz, _16
# collisions.h:115:     wy = 0.5 * ((*vy_1) + (*vy_2));
	vaddsd	%xmm1, %xmm4, %xmm4	# ISRA.1671, _6, tmp162
# collisions.h:116:     wz = 0.5 * ((*vz_1) + (*vz_2));
	vaddsd	%xmm2, %xmm3, %xmm2	# ISRA.1672, _10, tmp164
# collisions.h:115:     wy = 0.5 * ((*vy_1) + (*vy_2));
	vmulsd	.LC46(%rip), %xmm4, %xmm4	#, tmp162, wy
# collisions.h:116:     wz = 0.5 * ((*vz_1) + (*vz_2));
	vmulsd	.LC46(%rip), %xmm2, %xmm3	#, tmp164, wz
# collisions.h:120:     if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp166
# collisions.h:102: inline void collision_ion (double *vx_1, double *vy_1, double *vz_1,
	movq	%rsi, %rbp	# tmp211, vy_1
	movq	%rdx, %rbx	# tmp212, vz_1
# collisions.h:113:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vaddsd	%xmm11, %xmm9, %xmm9	# _16, _15, tmp159
# collisions.h:114:     wx = 0.5 * ((*vx_1) + (*vx_2));
	vmovsd	%xmm5, 8(%rsp)	# wx, %sfp
# collisions.h:113:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vsqrtsd	%xmm9, %xmm9, %xmm13	# tmp159, g
# collisions.h:115:     wy = 0.5 * ((*vy_1) + (*vy_2));
	vmovsd	%xmm4, 16(%rsp)	# wy, %sfp
# collisions.h:113:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vmovsd	%xmm13, (%rsp)	# g, %sfp
# collisions.h:116:     wz = 0.5 * ((*vz_1) + (*vz_2));
	vmovsd	%xmm3, 24(%rsp)	# wz, %sfp
# collisions.h:120:     if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	vucomisd	%xmm0, %xmm7	# tmp166, gx
	jp	.L682	#,
# collisions.h:120:     if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	movq	.LC178(%rip), %r14	#, theta
# collisions.h:120:     if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	jne	.L682	#,
.L671:
# collisions.h:121:     if (gy == 0) {
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp169
	vucomisd	%xmm0, %xmm6	# tmp169, gy
	jp	.L673	#,
	jne	.L673	#,
# collisions.h:122:         if (gz > 0){phi = 0.5 * PI;} else {phi = - 0.5 * PI;}
	vcmpnltsd	%xmm8, %xmm0, %xmm0	#, gz, tmp169, tmp209
	vmovsd	.LC187(%rip), %xmm2	#, tmp207
	vmovsd	.LC178(%rip), %xmm1	#, tmp208
	vblendvpd	%xmm0, %xmm2, %xmm1, %xmm6	# tmp209, tmp207, tmp208, phi
	vmovsd	%xmm6, 32(%rsp)	# phi, %sfp
.L675:
# collisions.h:127:     t1  =      sigma[I_ISO][e_index];
	leaq	sigma(%rip), %rax	#, tmp172
	vmovsd	24000000(%rax,%r13,8), %xmm1	# sigma[3][e_index_29(D)], t1
# collisions.h:128:     t2  = t1 + sigma[I_BACK][e_index];
	vaddsd	32000000(%rax,%r13,8), %xmm1, %xmm6	# sigma[4][e_index_29(D)], t1, t2
	vmovsd	%xmm1, 48(%rsp)	# t1, %sfp
	vmovsd	%xmm6, 40(%rsp)	# t2, %sfp
# collisions.h:129:     rnd = R01(MTgen);
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:130:     if  (rnd < (t1 /t2)){                        // isotropic scattering
	vmovsd	48(%rsp), %xmm1	# %sfp, t1
	vdivsd	40(%rsp), %xmm1, %xmm1	# %sfp, t1, tmp178
# collisions.h:130:     if  (rnd < (t1 /t2)){                        // isotropic scattering
	vcomisd	%xmm0, %xmm1	# tmp219, tmp178
	ja	.L688	#,
# collisions.h:133:         chi = PI;                                // scattering angle
	vmovsd	.LC185(%rip), %xmm5	#, chi
	vmovsd	%xmm5, 40(%rsp)	# chi, %sfp
.L677:
	leaq	88(%rsp), %r13	#, tmp181
	leaq	80(%rsp), %r15	#, tmp182
	vmovsd	32(%rsp), %xmm0	# %sfp,
	movq	%r15, %rsi	# tmp182,
	movq	%r13, %rdi	# tmp181,
	call	sincos@PLT	#
	movq	%r15, %rsi	# tmp182,
	movq	%r13, %rdi	# tmp181,
	vmovq	%r14, %xmm0	# theta,
	vmovsd	80(%rsp), %xmm7	#, sincostmp_11
	vmovsd	88(%rsp), %xmm9	#, sincostmp_11
	vmovsd	%xmm7, 72(%rsp)	# sincostmp_11, %sfp
	vmovsd	%xmm9, 64(%rsp)	# sincostmp_11, %sfp
	call	sincos@PLT	#
	movq	%r15, %rsi	# tmp182,
	movq	%r13, %rdi	# tmp181,
	vmovsd	80(%rsp), %xmm1	#, sincostmp_101
	vmovsd	88(%rsp), %xmm5	#, sincostmp_101
	vmovsd	%xmm1, 56(%rsp)	# sincostmp_101, %sfp
	vmovsd	%xmm5, 48(%rsp)	# sincostmp_101, %sfp
	vmovsd	40(%rsp), %xmm0	# %sfp,
	call	sincos@PLT	#
	vmovsd	80(%rsp), %xmm4	#, sincostmp_102
	vmovsd	88(%rsp), %xmm3	#, sincostmp_102
	vmovsd	%xmm4, 40(%rsp)	# sincostmp_102, %sfp
	vmovsd	%xmm3, 32(%rsp)	# sincostmp_102, %sfp
# collisions.h:135:     eta = TWO_PI * R01(MTgen);                   // azimuthal angle
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
	movq	%r15, %rsi	# tmp182,
	movq	%r13, %rdi	# tmp181,
# collisions.h:135:     eta = TWO_PI * R01(MTgen);                   // azimuthal angle
	vmulsd	.LC181(%rip), %xmm0, %xmm0	#, tmp222, eta
	call	sincos@PLT	#
	vmovsd	80(%rsp), %xmm8	#, sincostmp_7
# collisions.h:147:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	32(%rsp), %xmm3	# %sfp, sincostmp_102
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	72(%rsp), %xmm7	# %sfp, sincostmp_11
# collisions.h:147:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	48(%rsp), %xmm5	# %sfp, sincostmp_101
# collisions.h:147:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	40(%rsp), %xmm4	# %sfp, sincostmp_102
	vmovsd	56(%rsp), %xmm1	# %sfp, sincostmp_101
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	64(%rsp), %xmm9	# %sfp, sincostmp_11
# collisions.h:147:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm5, %xmm3, %xmm0	# sincostmp_101, sincostmp_102, tmp191
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm7, %xmm5, %xmm10	# sincostmp_11, sincostmp_101, tmp193
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm7, %xmm1, %xmm2	# sincostmp_11, sincostmp_101, tmp194
# collisions.h:147:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm8, %xmm0, %xmm0	# sincostmp_7, tmp191, tmp192
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm3, %xmm2, %xmm2	# sincostmp_102, tmp194, tmp195
# collisions.h:147:     gx = g * (ct * cc - st * sc * ce);
	vfmsub231sd	%xmm1, %xmm4, %xmm0	# sincostmp_101, sincostmp_102, _55
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm8, %xmm2, %xmm2	# sincostmp_7, tmp195, tmp196
# collisions.h:149:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm9, %xmm5, %xmm5	# sincostmp_11, sincostmp_101, tmp198
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfmadd132sd	%xmm4, %xmm2, %xmm10	# sincostmp_102, tmp196, _62
# collisions.h:149:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm9, %xmm1, %xmm1	# sincostmp_11, sincostmp_101, tmp199
# collisions.h:149:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm3, %xmm1, %xmm1	# sincostmp_102, tmp199, tmp200
# collisions.h:149:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm8, %xmm1, %xmm1	# sincostmp_7, tmp200, tmp201
# collisions.h:149:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm5, %xmm1, %xmm4	# tmp198, tmp201, _72
	vmovsd	88(%rsp), %xmm6	#, sincostmp_7
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm9, %xmm3, %xmm2	# sincostmp_11, sincostmp_102, tmp197
# collisions.h:149:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm7, %xmm3, %xmm3	# sincostmp_11, sincostmp_102, tmp202
# collisions.h:147:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	(%rsp), %xmm12	# %sfp, g
# collisions.h:153:     (*vx_1) = wx + 0.5 * gx;
	vmovsd	.LC46(%rip), %xmm7	#, tmp237
# collisions.h:147:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm12, %xmm0, %xmm0	# g, _55, gx
# collisions.h:153:     (*vx_1) = wx + 0.5 * gx;
	vfmadd213sd	8(%rsp), %xmm7, %xmm0	# %sfp, tmp237, _78
# collisions.h:153:     (*vx_1) = wx + 0.5 * gx;
	vmovsd	%xmm0, (%r12)	# _78, *vx_1_1(D)
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfnmadd132sd	%xmm6, %xmm10, %xmm2	# sincostmp_7, _62, _65
# collisions.h:149:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm3, %xmm4, %xmm6	# tmp202, _72, _75
# collisions.h:148:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm12, %xmm2, %xmm2	# g, _65, gy
# collisions.h:154:     (*vy_1) = wy + 0.5 * gy;
	vfmadd213sd	16(%rsp), %xmm7, %xmm2	# %sfp, tmp239, _80
# collisions.h:154:     (*vy_1) = wy + 0.5 * gy;
	vmovsd	%xmm2, 0(%rbp)	# _80, *vy_1_5(D)
# collisions.h:149:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm12, %xmm6, %xmm1	# g, _75, gz
# collisions.h:155:     (*vz_1) = wz + 0.5 * gz;
	vfmadd213sd	24(%rsp), %xmm7, %xmm1	# %sfp, tmp241, _82
# collisions.h:155:     (*vz_1) = wz + 0.5 * gz;
	vmovsd	%xmm1, (%rbx)	# _82, *vz_1_9(D)
# collisions.h:156: }
	addq	$104, %rsp	#,
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
.L682:
	.cfi_restore_state
	vmovsd	%xmm8, 40(%rsp)	# gz, %sfp
	vmovsd	%xmm6, 32(%rsp)	# gy, %sfp
# collisions.h:120:     if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	vaddsd	%xmm11, %xmm10, %xmm0	# _16, _14, tmp168
# collisions.h:120:     if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	vmovsd	%xmm7, %xmm7, %xmm1	# gx,
# collisions.h:120:     if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	vsqrtsd	%xmm0, %xmm0, %xmm0	# tmp168, _26
# collisions.h:120:     if (gx == 0) {theta = 0.5 * PI;} else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	call	atan2@PLT	#
	vmovsd	40(%rsp), %xmm8	# %sfp, gz
	vmovsd	32(%rsp), %xmm6	# %sfp, gy
	vmovq	%xmm0, %r14	# tmp217, theta
	jmp	.L671	#
	.p2align 4
	.p2align 3
.L688:
# collisions.h:131:         chi = acos(1.0 - 2.0 * R01(MTgen));      // scattering angle
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:131:         chi = acos(1.0 - 2.0 * R01(MTgen));      // scattering angle
	vmovsd	.LC12(%rip), %xmm6	#, tmp232
	vfnmadd132sd	.LC175(%rip), %xmm6, %xmm0	#, tmp232, _37
	call	acos@PLT	#
	vmovsd	%xmm0, 40(%rsp)	# tmp221, %sfp
	jmp	.L677	#
	.p2align 4
	.p2align 3
.L673:
# collisions.h:123:     } else {phi = atan2(gz, gy);}
	vmovsd	%xmm6, %xmm6, %xmm1	# gy,
	vmovsd	%xmm8, %xmm8, %xmm0	# gz,
	call	atan2@PLT	#
	vmovsd	%xmm0, 32(%rsp)	# tmp218, %sfp
	jmp	.L675	#
	.cfi_endproc
.LFE4768:
	.size	_Z13collision_ionPdS_S_S_S_S_i.isra.0, .-_Z13collision_ionPdS_S_S_S_S_i.isra.0


