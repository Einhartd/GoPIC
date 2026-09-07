# --- Symbol: _Z18collision_electrondPdS_S_i ---
	.section	.text._Z18collision_electrondPdS_S_i,"axG",@progbits,_Z18collision_electrondPdS_S_i,comdat
	.p2align 4
	.weak	_Z18collision_electrondPdS_S_i
	.type	_Z18collision_electrondPdS_S_i, @function
_Z18collision_electrondPdS_S_i:
.LFB3847:
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
	movslq	%ecx, %r15	# tmp338,
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %r12	# tmp335, vxe
	subq	$152, %rsp	#,
	.cfi_def_cfa_offset 208
# collisions.h:14:     gx = (*vxe);
	vmovsd	(%rdi), %xmm1	# *vxe_106(D), gx
# collisions.h:15:     gy = (*vye);
	vmovsd	(%rsi), %xmm2	# *vye_108(D), gy
# collisions.h:17:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vmovsd	%xmm1, %xmm1, %xmm4	# gx, _3
# collisions.h:17:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vmulsd	%xmm2, %xmm2, %xmm5	# gy, gy, _2
# collisions.h:17:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vfmadd132sd	%xmm1, %xmm5, %xmm4	# gx, _2, _3
# collisions.h:16:     gz = (*vze);
	vmovsd	(%rdx), %xmm3	# *vze_110(D), gz
# collisions.h:6: inline void collision_electron (double xe, double *vxe, double *vye, double *vze, int eindex){
	vmovsd	%xmm0, 104(%rsp)	# tmp334, %sfp
	movq	%rsi, %rbp	# tmp336, vye
# collisions.h:17:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vmulsd	%xmm3, %xmm3, %xmm0	# gz, gz, _4
# collisions.h:6: inline void collision_electron (double xe, double *vxe, double *vye, double *vze, int eindex){
	movq	%rdx, %rbx	# tmp337, vze
# collisions.h:17:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vaddsd	%xmm0, %xmm4, %xmm4	# _4, _3, tmp221
	vsqrtsd	%xmm4, %xmm4, %xmm6	# tmp221, g
# collisions.h:18:     wx = F1 * (*vxe);
	vmovsd	.LC180(%rip), %xmm4	#, tmp222
# collisions.h:17:     g  = sqrt(gx * gx + gy * gy + gz * gz);
	vmovsd	%xmm6, (%rsp)	# g, %sfp
# collisions.h:19:     wy = F1 * (*vye);
	vmulsd	%xmm4, %xmm2, %xmm7	# tmp222, gy, wy
# collisions.h:18:     wx = F1 * (*vxe);
	vmulsd	%xmm4, %xmm1, %xmm6	# tmp222, gx, wx
# collisions.h:19:     wy = F1 * (*vye);
	vmovsd	%xmm7, 48(%rsp)	# wy, %sfp
# collisions.h:18:     wx = F1 * (*vxe);
	vmovsd	%xmm6, 40(%rsp)	# wx, %sfp
# collisions.h:20:     wz = F1 * (*vze);
	vmulsd	%xmm4, %xmm3, %xmm6	# tmp222, gz, wz
# collisions.h:24:     if (gx == 0) {theta = 0.5 * PI;}
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp225
# collisions.h:20:     wz = F1 * (*vze);
	vmovsd	%xmm6, 56(%rsp)	# wz, %sfp
# collisions.h:24:     if (gx == 0) {theta = 0.5 * PI;}
	vucomisd	%xmm4, %xmm1	# tmp225, gx
	jp	.L651	#,
# collisions.h:24:     if (gx == 0) {theta = 0.5 * PI;}
	vmovsd	.LC178(%rip), %xmm4	#, theta
# collisions.h:24:     if (gx == 0) {theta = 0.5 * PI;}
	jne	.L651	#,
.L632:
# collisions.h:26:     if (gy == 0) {
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp228
	vucomisd	%xmm0, %xmm2	# tmp228, gy
	jp	.L634	#,
	jne	.L634	#,
# collisions.h:27:         if (gz > 0){phi = 0.5 * PI;} else {phi = - 0.5 * PI;}
	vcomisd	%xmm0, %xmm3	# tmp228, gz
	jbe	.L658	#,
	leaq	136(%rsp), %r13	#, tmp331
	leaq	128(%rsp), %r14	#, tmp333
	vmovsd	.LC179(%rip), %xmm7	#, _279
	vmovsd	%xmm7, 32(%rsp)	# _279, %sfp
	vmovsd	.LC12(%rip), %xmm7	#, _277
	vmovsd	%xmm7, 24(%rsp)	# _277, %sfp
.L636:
	movq	%r14, %rsi	# tmp333,
	movq	%r13, %rdi	# tmp331,
	vmovsd	%xmm4, %xmm4, %xmm0	# theta,
	call	sincos@PLT	#
# collisions.h:39:     t0   =     sigma[E_ELA][eindex];
	leaq	sigma(%rip), %rdx	#, tmp235
	vmovsd	128(%rsp), %xmm7	#, sincostmp_221
	vmovsd	136(%rsp), %xmm6	#, st
	vmovsd	(%rdx,%r15,8), %xmm1	# sigma[0][eindex_126(D)], t0
	vmovsd	%xmm7, 16(%rsp)	# sincostmp_221, %sfp
# collisions.h:40:     t1   = t0 +sigma[E_EXC][eindex];
	vaddsd	8000000(%rdx,%r15,8), %xmm1, %xmm2	# sigma[1][eindex_126(D)], t0, t1
	vmovsd	%xmm1, 80(%rsp)	# t0, %sfp
# collisions.h:41:     t2   = t1 +sigma[E_ION][eindex];
	vaddsd	16000000(%rdx,%r15,8), %xmm2, %xmm3	# sigma[2][eindex_126(D)], t1, t2
	vmovsd	%xmm2, 72(%rsp)	# t1, %sfp
	vmovsd	%xmm3, 64(%rsp)	# t2, %sfp
	vmovsd	%xmm6, 8(%rsp)	# st, %sfp
# collisions.h:42:     rnd  = R01(MTgen);
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:43:     if (rnd < (t0/t2)){                              // elastic scattering
	vmovsd	64(%rsp), %xmm3	# %sfp, t2
	vmovsd	80(%rsp), %xmm1	# %sfp, t0
# collisions.h:43:     if (rnd < (t0/t2)){                              // elastic scattering
	vmovsd	72(%rsp), %xmm2	# %sfp, t1
# collisions.h:43:     if (rnd < (t0/t2)){                              // elastic scattering
	vdivsd	%xmm3, %xmm1, %xmm1	# t2, t0, tmp243
# collisions.h:43:     if (rnd < (t0/t2)){                              // elastic scattering
	vcomisd	%xmm0, %xmm1	# _131, tmp243
	ja	.L664	#,
# collisions.h:47:         energy = 0.5 * E_MASS * g * g;               // electron energy
	vmovsd	(%rsp), %xmm7	# %sfp, g
# collisions.h:46:     } else if (rnd < (t1/t2)){                       // excitation
	vdivsd	%xmm3, %xmm2, %xmm2	# t2, t1, tmp249
# collisions.h:47:         energy = 0.5 * E_MASS * g * g;               // electron energy
	vmulsd	.LC78(%rip), %xmm7, %xmm1	#, g, tmp247
# collisions.h:46:     } else if (rnd < (t1/t2)){                       // excitation
	vcomisd	%xmm0, %xmm2	# _131, tmp249
# collisions.h:47:         energy = 0.5 * E_MASS * g * g;               // electron energy
	vmulsd	%xmm7, %xmm1, %xmm1	# g, tmp247, _294
# collisions.h:46:     } else if (rnd < (t1/t2)){                       // excitation
	jbe	.L660	#,
# collisions.h:48:         energy = fabs(energy - E_EXC_TH * EV_TO_J);  // subtract energy loss for excitation
	vsubsd	.LC182(%rip), %xmm1, %xmm1	#, _294, tmp250
# collisions.h:48:         energy = fabs(energy - E_EXC_TH * EV_TO_J);  // subtract energy loss for excitation
	vandpd	.LC0(%rip), %xmm1, %xmm1	#, tmp250, energy
# collisions.h:49:         g   = sqrt(2.0 * energy / E_MASS);           // relative velocity after energy loss
	vaddsd	%xmm1, %xmm1, %xmm1	# energy, energy, tmp254
# collisions.h:49:         g   = sqrt(2.0 * energy / E_MASS);           // relative velocity after energy loss
	vdivsd	.LC52(%rip), %xmm1, %xmm1	#, tmp254, tmp255
	vsqrtsd	%xmm1, %xmm1, %xmm7	# tmp255, g
	vmovsd	%xmm7, (%rsp)	# g, %sfp
# collisions.h:50:         chi = acos(1.0 - 2.0 * R01(MTgen));          // isotropic scattering
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:50:         chi = acos(1.0 - 2.0 * R01(MTgen));          // isotropic scattering
	vmovsd	.LC12(%rip), %xmm6	#, tmp389
	vfnmadd132sd	.LC175(%rip), %xmm6, %xmm0	#, tmp389, _19
	call	acos@PLT	#
	vmovsd	%xmm0, 64(%rsp)	# tmp346, %sfp
# collisions.h:51:         eta = TWO_PI * R01(MTgen);                   // azimuthal angle
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	16(%rsp), %xmm5	# %sfp, sincostmp_221
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	8(%rsp), %xmm6	# %sfp, st
	vmovsd	32(%rsp), %xmm4	# %sfp, _279
# collisions.h:51:         eta = TWO_PI * R01(MTgen);                   // azimuthal angle
	vmulsd	.LC181(%rip), %xmm0, %xmm2	#, tmp347, eta
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm4, %xmm6, %xmm7	# _279, st, _282
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm5, %xmm4, %xmm3	# sincostmp_221, _279, _285
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	%xmm7, 72(%rsp)	# _282, %sfp
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	%xmm3, 80(%rsp)	# _285, %sfp
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmovsd	24(%rsp), %xmm3	# %sfp, _277
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm5, %xmm3, %xmm7	# sincostmp_221, _277, _291
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm3, %xmm6, %xmm6	# _277, st, _288
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmovsd	%xmm7, 96(%rsp)	# _291, %sfp
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmovsd	%xmm6, 88(%rsp)	# _288, %sfp
	vmovsd	.LC186(%rip), %xmm5	#, tmp332
.L640:
	movq	%r14, %rsi	# tmp333,
	movq	%r13, %rdi	# tmp331,
	vmovsd	%xmm5, 120(%rsp)	# tmp332, %sfp
	vmovsd	%xmm2, %xmm2, %xmm0	# eta,
	call	sincos@PLT	#
	movq	%r14, %rsi	# tmp333,
	movq	%r13, %rdi	# tmp331,
	vmovsd	128(%rsp), %xmm6	#, sincostmp_274
	vmovsd	136(%rsp), %xmm7	#, sincostmp_274
	vmovsd	%xmm6, 112(%rsp)	# sincostmp_274, %sfp
	vmovsd	%xmm7, 104(%rsp)	# sincostmp_274, %sfp
	vmovsd	64(%rsp), %xmm0	# %sfp,
	call	sincos@PLT	#
	vmovsd	136(%rsp), %xmm0	#, sincostmp_275
	vmovsd	128(%rsp), %xmm4	#, sincostmp_275
# collisions.h:91:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	112(%rsp), %xmm6	# %sfp, sincostmp_274
# collisions.h:91:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	8(%rsp), %xmm0, %xmm1	# %sfp, sincostmp_275, tmp320
# collisions.h:91:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	16(%rsp), %xmm2	# %sfp, sincostmp_221
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	72(%rsp), %xmm3	# %sfp, _282
# collisions.h:91:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm6, %xmm1, %xmm1	# sincostmp_274, tmp320, tmp321
# collisions.h:91:     gx = g * (ct * cc - st * sc * ce);
	vfmsub132sd	%xmm4, %xmm1, %xmm2	# sincostmp_275, tmp321, sincostmp_221
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	80(%rsp), %xmm0, %xmm1	# %sfp, sincostmp_275, tmp322
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm6, %xmm1, %xmm1	# sincostmp_274, tmp322, tmp323
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfmadd132sd	%xmm4, %xmm1, %xmm3	# sincostmp_275, tmp323, _282
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	104(%rsp), %xmm7	# %sfp, sincostmp_274
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	24(%rsp), %xmm0, %xmm1	# %sfp, sincostmp_275, tmp324
# collisions.h:91:     gx = g * (ct * cc - st * sc * ce);
	vmovsd	(%rsp), %xmm5	# %sfp, g
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfnmadd132sd	%xmm7, %xmm3, %xmm1	# sincostmp_274, _78, _81
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	96(%rsp), %xmm0, %xmm3	# %sfp, sincostmp_275, tmp325
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	32(%rsp), %xmm0, %xmm0	# %sfp, sincostmp_275, tmp327
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm6, %xmm3, %xmm3	# sincostmp_274, tmp325, tmp326
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	88(%rsp), %xmm3, %xmm4	# %sfp, tmp326, _87
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm7, %xmm4, %xmm0	# sincostmp_274, _87, _90
# collisions.h:91:     gx = g * (ct * cc - st * sc * ce);
	vmulsd	%xmm5, %xmm2, %xmm2	# g, _72, gx
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm5, %xmm1, %xmm1	# g, _81, gy
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm5, %xmm0, %xmm0	# g, _90, gz
# collisions.h:97:     (*vxe) = wx + F2 * gx;
	vmovsd	120(%rsp), %xmm5	# %sfp, tmp332
	vfmadd213sd	40(%rsp), %xmm5, %xmm2	# %sfp, tmp332, _92
# collisions.h:98:     (*vye) = wy + F2 * gy;
	vfmadd213sd	48(%rsp), %xmm5, %xmm1	# %sfp, tmp332, _94
# collisions.h:97:     (*vxe) = wx + F2 * gx;
	vmovsd	%xmm2, (%r12)	# _92, *vxe_106(D)
# collisions.h:99:     (*vze) = wz + F2 * gz;
	vfmadd213sd	56(%rsp), %xmm5, %xmm0	# %sfp, tmp332, _96
# collisions.h:98:     (*vye) = wy + F2 * gy;
	vmovsd	%xmm1, 0(%rbp)	# _94, *vye_108(D)
# collisions.h:99:     (*vze) = wz + F2 * gz;
	vmovsd	%xmm0, (%rbx)	# _96, *vze_110(D)
# collisions.h:100: }
	addq	$152, %rsp	#,
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
.L658:
	.cfi_restore_state
	vmovsd	.LC179(%rip), %xmm2	#, _279
	vmovsd	.LC176(%rip), %xmm5	#, _277
	leaq	136(%rsp), %r13	#, tmp331
	leaq	128(%rsp), %r14	#, tmp333
	vmovsd	%xmm2, 32(%rsp)	# _279, %sfp
	vmovsd	%xmm5, 24(%rsp)	# _277, %sfp
	jmp	.L636	#
	.p2align 4
	.p2align 3
.L660:
# collisions.h:54:         energy = fabs(energy - E_ION_TH * EV_TO_J);  // subtract energy loss of ionization
	vsubsd	.LC183(%rip), %xmm1, %xmm1	#, _294, tmp260
# collisions.h:54:         energy = fabs(energy - E_ION_TH * EV_TO_J);  // subtract energy loss of ionization
	vmovq	.LC0(%rip), %xmm3	#, tmp262
	vandpd	%xmm3, %xmm1, %xmm7	# tmp262, tmp260, energy
	vmovsd	%xmm7, 72(%rsp)	# energy, %sfp
# collisions.h:55:         e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:55:         e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
	vmovsd	72(%rsp), %xmm7	# %sfp, energy
# collisions.h:55:         e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
	vmovsd	%xmm0, (%rsp)	# tmp348, %sfp
# collisions.h:55:         e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
	vdivsd	.LC51(%rip), %xmm7, %xmm0	#, energy, tmp263
# collisions.h:55:         e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
	vdivsd	.LC184(%rip), %xmm0, %xmm0	#, tmp263, tmp265
	call	atan@PLT	#
# collisions.h:55:         e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
	vmulsd	(%rsp), %xmm0, %xmm0	# %sfp, tmp349, tmp267
	call	tan@PLT	#
# collisions.h:56:         e_sc = fabs(energy - e_ej);                  // energy of scattered electron after the collision
	vmovq	.LC0(%rip), %xmm3	#, tmp262
# collisions.h:55:         e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
	vmulsd	.LC17(%rip), %xmm0, %xmm1	#, tmp350, tmp268
# collisions.h:56:         e_sc = fabs(energy - e_ej);                  // energy of scattered electron after the collision
	vmovsd	72(%rsp), %xmm7	# %sfp, energy
# collisions.h:55:         e_ej  = 10.0 * tan(R01(MTgen) * atan(energy/EV_TO_J / 20.0)) * EV_TO_J; // energy of the ejected electron
	vmulsd	.LC51(%rip), %xmm1, %xmm1	#, tmp268, e_ej
# collisions.h:56:         e_sc = fabs(energy - e_ej);                  // energy of scattered electron after the collision
	vsubsd	%xmm1, %xmm7, %xmm2	# e_ej, energy, tmp271
# collisions.h:56:         e_sc = fabs(energy - e_ej);                  // energy of scattered electron after the collision
	vandpd	%xmm3, %xmm2, %xmm2	# tmp262, tmp271, e_sc
# collisions.h:57:         g    = sqrt(2.0 * e_sc / E_MASS);            // relative velocity of scattered electron
	vaddsd	%xmm2, %xmm2, %xmm0	# e_sc, e_sc, tmp273
# collisions.h:57:         g    = sqrt(2.0 * e_sc / E_MASS);            // relative velocity of scattered electron
	vmovsd	.LC52(%rip), %xmm3	#, tmp275
	vdivsd	%xmm3, %xmm0, %xmm0	# tmp275, tmp273, tmp274
	vsqrtsd	%xmm0, %xmm0, %xmm6	# tmp274, g
# collisions.h:58:         g2   = sqrt(2.0 * e_ej / E_MASS);            // relative velocity of ejected electron
	vaddsd	%xmm1, %xmm1, %xmm0	# e_ej, e_ej, tmp276
# collisions.h:57:         g    = sqrt(2.0 * e_sc / E_MASS);            // relative velocity of scattered electron
	vmovsd	%xmm6, (%rsp)	# g, %sfp
# collisions.h:58:         g2   = sqrt(2.0 * e_ej / E_MASS);            // relative velocity of ejected electron
	vdivsd	%xmm3, %xmm0, %xmm0	# tmp275, tmp276, _32
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp278
	vucomisd	%xmm0, %xmm3	# _32, tmp278
	ja	.L661	#,
	vsqrtsd	%xmm0, %xmm0, %xmm6	# _32, g2
# collisions.h:59:         chi  = acos(sqrt(e_sc / energy));            // scattering angle for scattered electron
	vdivsd	%xmm7, %xmm2, %xmm2	# energy, e_sc, _224
# collisions.h:58:         g2   = sqrt(2.0 * e_ej / E_MASS);            // relative velocity of ejected electron
	vmovsd	%xmm6, 80(%rsp)	# g2, %sfp
.L645:
	vmovsd	%xmm1, 88(%rsp)	# e_ej, %sfp
# collisions.h:59:         chi  = acos(sqrt(e_sc / energy));            // scattering angle for scattered electron
	vsqrtsd	%xmm2, %xmm2, %xmm0	# _224, _34
# collisions.h:59:         chi  = acos(sqrt(e_sc / energy));            // scattering angle for scattered electron
	call	acos@PLT	#
# collisions.h:60:         chi2 = acos(sqrt(e_ej / energy));            // scattering angle for ejected electrons
	vmovsd	88(%rsp), %xmm1	# %sfp, e_ej
# collisions.h:59:         chi  = acos(sqrt(e_sc / energy));            // scattering angle for scattered electron
	vmovsd	%xmm0, 64(%rsp)	# tmp352, %sfp
# collisions.h:60:         chi2 = acos(sqrt(e_ej / energy));            // scattering angle for ejected electrons
	vdivsd	72(%rsp), %xmm1, %xmm1	# %sfp, e_ej, _35
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp279
	vucomisd	%xmm1, %xmm0	# _35, tmp279
	ja	.L662	#,
	vsqrtsd	%xmm1, %xmm1, %xmm0	# _35, _36
.L648:
# collisions.h:60:         chi2 = acos(sqrt(e_ej / energy));            // scattering angle for ejected electrons
	call	acos@PLT	#
	movq	%r14, %rsi	# tmp333,
	movq	%r13, %rdi	# tmp331,
	call	sincos@PLT	#
	vmovsd	128(%rsp), %xmm4	#, sincostmp_229
	vmovsd	136(%rsp), %xmm1	#, sincostmp_229
	vmovsd	%xmm4, 88(%rsp)	# sincostmp_229, %sfp
	vmovsd	%xmm1, 72(%rsp)	# sincostmp_229, %sfp
# collisions.h:61:         eta  = TWO_PI * R01(MTgen);                  // azimuthal angle for scattered electron
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
	movq	%r14, %rsi	# tmp333,
	movq	%r13, %rdi	# tmp331,
# collisions.h:61:         eta  = TWO_PI * R01(MTgen);                  // azimuthal angle for scattered electron
	vmulsd	.LC181(%rip), %xmm0, %xmm2	#, tmp355, eta
# collisions.h:62:         eta2 = eta + PI;                             // azimuthal angle for ejected electron
	vaddsd	.LC185(%rip), %xmm2, %xmm0	#, eta, eta2
	vmovsd	%xmm2, 120(%rsp)	# eta, %sfp
	call	sincos@PLT	#
	vmovsd	128(%rsp), %xmm6	#, sincostmp_276
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vmovsd	72(%rsp), %xmm1	# %sfp, sincostmp_229
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vmovsd	80(%rsp), %xmm9	# %sfp, g2
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vmovsd	16(%rsp), %xmm8	# %sfp, sincostmp_221
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	32(%rsp), %xmm10	# %sfp, _279
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vmovsd	88(%rsp), %xmm4	# %sfp, sincostmp_229
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm8, %xmm10, %xmm5	# sincostmp_221, _279, _285
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vmovsd	8(%rsp), %xmm2	# %sfp, st
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	%xmm5, 80(%rsp)	# _285, %sfp
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm10, %xmm2, %xmm3	# _279, st, _282
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm5, %xmm1, %xmm5	# _285, sincostmp_229, tmp289
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm6, %xmm5, %xmm5	# sincostmp_276, tmp289, tmp290
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfmadd231sd	%xmm3, %xmm4, %xmm5	# _282, sincostmp_229, _46
	vmovsd	136(%rsp), %xmm7	#, sincostmp_276
# collisions.h:70:         x_e[N_e]  = xe;                              // add new electron
	movslq	N_e(%rip), %rdx	# N_e,
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	24(%rsp), %xmm11	# %sfp, _277
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vmulsd	%xmm2, %xmm1, %xmm0	# st, sincostmp_229, tmp287
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	%xmm3, 72(%rsp)	# _282, %sfp
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm2, %xmm11, %xmm2	# st, _277, _288
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm11, %xmm1, %xmm3	# _277, sincostmp_229, tmp291
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vmulsd	%xmm6, %xmm0, %xmm0	# sincostmp_276, tmp287, tmp288
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vfmsub231sd	%xmm8, %xmm4, %xmm0	# sincostmp_221, sincostmp_229, _40
# collisions.h:75:         x_i[N_i]  = xe;                              // add new ion
	movslq	N_i(%rip), %r15	# N_i,
# collisions.h:70:         x_e[N_e]  = xe;                              // add new electron
	leaq	x_e(%rip), %rcx	#, tmp295
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmovsd	%xmm2, 88(%rsp)	# _288, %sfp
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vfnmadd132sd	%xmm7, %xmm5, %xmm3	# sincostmp_276, _46, _49
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm8, %xmm11, %xmm5	# sincostmp_221, _277, _291
	vmovsd	%xmm5, 96(%rsp)	# _291, %sfp
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm5, %xmm1, %xmm5	# _291, sincostmp_229, tmp292
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm6, %xmm5, %xmm5	# sincostmp_276, tmp292, tmp293
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm2, %xmm5, %xmm4	# _288, tmp293, _55
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm10, %xmm1, %xmm1	# _279, sincostmp_229, tmp294
# collisions.h:70:         x_e[N_e]  = xe;                              // add new electron
	vmovsd	104(%rsp), %xmm6	# %sfp, xe
	vmovsd	%xmm6, (%rcx,%rdx,8)	# xe, x_e[N_e.112_59]
# collisions.h:71:         vx_e[N_e] = wx + F2 * gx;
	leaq	vx_e(%rip), %rcx	#, tmp298
# collisions.h:71:         vx_e[N_e] = wx + F2 * gx;
	vmovsd	.LC186(%rip), %xmm5	#, tmp332
# collisions.h:67:         gx  = g2 * (ct * cc - st * sc * ce);
	vmulsd	%xmm9, %xmm0, %xmm0	# g2, _40, gx
# collisions.h:71:         vx_e[N_e] = wx + F2 * gx;
	vfmadd213sd	40(%rsp), %xmm5, %xmm0	# %sfp, tmp332, _61
# collisions.h:71:         vx_e[N_e] = wx + F2 * gx;
	vmovsd	%xmm0, (%rcx,%rdx,8)	# _61, vx_e[N_e.112_59]
# collisions.h:72:         vy_e[N_e] = wy + F2 * gy;
	leaq	vy_e(%rip), %rcx	#, tmp301
# collisions.h:70:         x_e[N_e]  = xe;                              // add new electron
	movq	%rdx, %rax	#,
# collisions.h:68:         gy  = g2 * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm9, %xmm3, %xmm3	# g2, _49, gy
# collisions.h:72:         vy_e[N_e] = wy + F2 * gy;
	vfmadd213sd	48(%rsp), %xmm5, %xmm3	# %sfp, tmp332, _63
# collisions.h:72:         vy_e[N_e] = wy + F2 * gy;
	vmovsd	%xmm3, (%rcx,%rdx,8)	# _63, vy_e[N_e.112_59]
# collisions.h:73:         vz_e[N_e] = wz + F2 * gz;
	leaq	vz_e(%rip), %rcx	#, tmp304
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vfmadd132sd	%xmm7, %xmm4, %xmm1	# sincostmp_276, _55, _58
# collisions.h:74:         N_e++;
	incl	%eax	# tmp306
# collisions.h:73:         vz_e[N_e] = wz + F2 * gz;
	vmovsd	%xmm5, 112(%rsp)	# tmp332, %sfp
# collisions.h:75:         x_i[N_i]  = xe;                              // add new ion
	movl	%r15d, 104(%rsp)	# N_i.117_67, %sfp
# collisions.h:74:         N_e++;
	movl	%eax, N_e(%rip)	# tmp306, N_e
# collisions.h:69:         gz  = g2 * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm9, %xmm1, %xmm1	# g2, _58, gz
# collisions.h:73:         vz_e[N_e] = wz + F2 * gz;
	vfmadd213sd	56(%rsp), %xmm5, %xmm1	# %sfp, tmp332, _65
# collisions.h:73:         vz_e[N_e] = wz + F2 * gz;
	vmovsd	%xmm1, (%rcx,%rdx,8)	# _65, vz_e[N_e.112_59]
# collisions.h:75:         x_i[N_i]  = xe;                              // add new ion
	leaq	x_i(%rip), %rdx	#, tmp307
	vmovsd	%xmm6, (%rdx,%r15,8)	# xe, x_i[N_i.117_67]
# collisions.h:76:         vx_i[N_i] = RMB(MTgen);                      // velocity is sampled from background thermal distribution
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:76:         vx_i[N_i] = RMB(MTgen);                      // velocity is sampled from background thermal distribution
	leaq	vx_i(%rip), %rdx	#, tmp309
	vmovsd	%xmm0, (%rdx,%r15,8)	# tmp356, vx_i[N_i.117_67]
# collisions.h:77:         vy_i[N_i] = RMB(MTgen);
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:77:         vy_i[N_i] = RMB(MTgen);
	leaq	vy_i(%rip), %rdx	#, tmp311
	vmovsd	%xmm0, (%rdx,%r15,8)	# tmp357, vy_i[N_i.117_67]
# collisions.h:78:         vz_i[N_i] = RMB(MTgen);
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:79:         N_i++;
	movl	104(%rsp), %eax	# %sfp, N_i.117_67
# collisions.h:78:         vz_i[N_i] = RMB(MTgen);
	leaq	vz_i(%rip), %rdx	#, tmp313
	vmovsd	%xmm0, (%rdx,%r15,8)	# tmp358, vz_i[N_i.117_67]
# collisions.h:79:         N_i++;
	vmovsd	120(%rsp), %xmm2	# %sfp, eta
	vmovsd	112(%rsp), %xmm5	# %sfp, tmp332
	incl	%eax	# tmp315
	movl	%eax, N_i(%rip)	# tmp315, N_i
	jmp	.L640	#
	.p2align 4
	.p2align 3
.L664:
# collisions.h:44:         chi = acos(1.0 - 2.0 * R01(MTgen));          // isotropic scattering
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:44:         chi = acos(1.0 - 2.0 * R01(MTgen));          // isotropic scattering
	vmovsd	.LC12(%rip), %xmm5	#, tmp373
	vfnmadd132sd	.LC175(%rip), %xmm5, %xmm0	#, tmp373, _12
	call	acos@PLT	#
	vmovsd	%xmm0, 64(%rsp)	# tmp343, %sfp
# collisions.h:45:         eta = TWO_PI * R01(MTgen);                   // azimuthal angle
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	8(%rsp), %xmm7	# %sfp, st
	vmovsd	32(%rsp), %xmm4	# %sfp, _279
# collisions.h:45:         eta = TWO_PI * R01(MTgen);                   // azimuthal angle
	vmulsd	.LC181(%rip), %xmm0, %xmm2	#, tmp344, eta
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmulsd	%xmm4, %xmm7, %xmm6	# _279, st, _282
	vmovsd	.LC186(%rip), %xmm5	#, tmp332
	vmovsd	%xmm6, 72(%rsp)	# _282, %sfp
# collisions.h:92:     gy = g * (st * cp * cc + ct * cp * sc * ce - sp * sc * se);
	vmovsd	16(%rsp), %xmm6	# %sfp, sincostmp_221
	vmulsd	%xmm6, %xmm4, %xmm4	# sincostmp_221, _279, _285
	vmovsd	%xmm4, 80(%rsp)	# _285, %sfp
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmovsd	24(%rsp), %xmm4	# %sfp, _277
	vmulsd	%xmm4, %xmm7, %xmm7	# _277, st, _288
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmulsd	%xmm6, %xmm4, %xmm3	# sincostmp_221, _277, _291
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmovsd	%xmm7, 88(%rsp)	# _288, %sfp
# collisions.h:93:     gz = g * (st * sp * cc + ct * sp * sc * ce + cp * sc * se);
	vmovsd	%xmm3, 96(%rsp)	# _291, %sfp
	jmp	.L640	#
	.p2align 4
	.p2align 3
.L634:
	leaq	136(%rsp), %r13	#, tmp331
	leaq	128(%rsp), %r14	#, tmp333
	vmovsd	%xmm4, 8(%rsp)	# theta, %sfp
# collisions.h:28:     } else {phi = atan2(gz, gy);}
	vmovsd	%xmm2, %xmm2, %xmm1	# gy,
	vmovsd	%xmm3, %xmm3, %xmm0	# gz,
	call	atan2@PLT	#
	movq	%r14, %rsi	# tmp333,
	movq	%r13, %rdi	# tmp331,
	call	sincos@PLT	#
	vmovsd	136(%rsp), %xmm2	#, _277
# collisions.h:32:     cp  = cos(phi);
	vmovsd	128(%rsp), %xmm3	#, _279
	vmovsd	%xmm2, 24(%rsp)	# _277, %sfp
	vmovsd	%xmm3, 32(%rsp)	# _279, %sfp
	vmovsd	8(%rsp), %xmm4	# %sfp, theta
	jmp	.L636	#
	.p2align 4
	.p2align 3
.L651:
	vmovsd	%xmm3, 16(%rsp)	# gz, %sfp
	vmovsd	%xmm2, 8(%rsp)	# gy, %sfp
# collisions.h:25:     else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	vaddsd	%xmm0, %xmm5, %xmm0	# _4, _2, tmp227
	vsqrtsd	%xmm0, %xmm0, %xmm0	# tmp227, _7
# collisions.h:25:     else {theta = atan2(sqrt(gy * gy + gz * gz),gx);}
	call	atan2@PLT	#
	vmovsd	16(%rsp), %xmm3	# %sfp, gz
	vmovsd	8(%rsp), %xmm2	# %sfp, gy
	vmovsd	%xmm0, %xmm0, %xmm4	# tmp339, theta
	jmp	.L632	#
.L661:
	vmovsd	%xmm2, 88(%rsp)	# e_sc, %sfp
	vmovsd	%xmm1, 64(%rsp)	# e_ej, %sfp
# collisions.h:58:         g2   = sqrt(2.0 * e_ej / E_MASS);            // relative velocity of ejected electron
	call	sqrt@PLT	#
# collisions.h:59:         chi  = acos(sqrt(e_sc / energy));            // scattering angle for scattered electron
	vmovsd	88(%rsp), %xmm2	# %sfp, e_sc
# collisions.h:58:         g2   = sqrt(2.0 * e_ej / E_MASS);            // relative velocity of ejected electron
	vmovsd	%xmm0, 80(%rsp)	# tmp351, %sfp
# collisions.h:59:         chi  = acos(sqrt(e_sc / energy));            // scattering angle for scattered electron
	vdivsd	72(%rsp), %xmm2, %xmm2	# %sfp, e_sc, _224
	vmovsd	64(%rsp), %xmm1	# %sfp, e_ej
	jmp	.L645	#
.L662:
# collisions.h:60:         chi2 = acos(sqrt(e_ej / energy));            // scattering angle for ejected electrons
	vmovsd	%xmm1, %xmm1, %xmm0	# _35,
	call	sqrt@PLT	#
	jmp	.L648	#
	.cfi_endproc
.LFE3847:
	.size	_Z18collision_electrondPdS_S_i, .-_Z18collision_electrondPdS_S_i


