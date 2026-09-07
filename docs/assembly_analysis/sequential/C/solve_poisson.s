# --- Symbol: _Z13solve_PoissonPdd ---
	.section	.text._Z13solve_PoissonPdd,"axG",@progbits,_Z13solve_PoissonPdd,comdat
	.p2align 4
	.weak	_Z13solve_PoissonPdd
	.type	_Z13solve_PoissonPdd, @function
_Z13solve_PoissonPdd:
.LFB3846:
	.cfi_startproc
	endbr64	
	leaq	8(%rsp), %r10	#,
	.cfi_def_cfa 10, 0
	andq	$-64, %rsp	#,
	pushq	-8(%r10)	#
	pushq	%rbp	#
	movq	%rsp, %rbp	#,
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r10	#
	.cfi_escape 0xf,0x3,0x76,0x78,0x6
	pushq	%rbx	#
	subq	$4096, %rsp	#,
	orq	$0, (%rsp)	#,
	subq	$4096, %rsp	#,
	orq	$0, (%rsp)	#,
	subq	$1504, %rsp	#,
	.cfi_escape 0x10,0x3,0x2,0x76,0x70
# poisson.h:13:     pot[0]     = VOLTAGE * cos(OMEGA * tt);         // potential at the powered electrode
	vmulsd	.LC54(%rip), %xmm0, %xmm0	#, tmp243, tmp147
# poisson.h:6: inline void solve_Poisson (xvector rho1, double tt){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp245
	movq	%rax, -56(%rbp)	# tmp245, D.82580
	xorl	%eax, %eax	# tmp245
	movq	%rdi, %rbx	# tmp242, rho1
# poisson.h:13:     pot[0]     = VOLTAGE * cos(OMEGA * tt);         // potential at the powered electrode
	call	cos@PLT	#
	vbroadcastsd	.LC57(%rip), %zmm1	#, tmp234
# poisson.h:14:     pot[N_G-1] = 0.0;                               // potential at the grounded electrode
	movl	$8, %eax	#, ivtmp.800
	leaq	-9712(%rbp), %rsi	#, tmp240
# poisson.h:13:     pot[0]     = VOLTAGE * cos(OMEGA * tt);         // potential at the powered electrode
	vmulsd	.LC55(%rip), %xmm0, %xmm2	#, tmp244, _3
# poisson.h:14:     pot[N_G-1] = 0.0;                               // potential at the grounded electrode
	movq	$0x000000000, 3192+pot(%rip)	#, pot[399]
# poisson.h:13:     pot[0]     = VOLTAGE * cos(OMEGA * tt);         // potential at the powered electrode
	vmovsd	%xmm2, pot(%rip)	# _3, pot[0]
	.p2align 4
	.p2align 3
.L150:
# poisson.h:18:     for(i=1; i<=N_G-2; i++) f[i] = ALPHA * rho1[i];
	vmulpd	(%rbx,%rax), %zmm1, %zmm0	# MEM <vector(8) double> [(double *)rho1_66(D) + ivtmp.800_104 * 1], tmp234, vect__8.703
# poisson.h:18:     for(i=1; i<=N_G-2; i++) f[i] = ALPHA * rho1[i];
	vmovupd	%zmm0, (%rsi,%rax)	# vect__8.703, MEM <vector(8) double> [(double *)&f + ivtmp.800_104 * 1]
	addq	$64, %rax	#, ivtmp.800
	cmpq	$3144, %rax	#, ivtmp.800
	jne	.L150	#,
# poisson.h:18:     for(i=1; i<=N_G-2; i++) f[i] = ALPHA * rho1[i];
	vbroadcastsd	.LC57(%rip), %ymm0	#, tmp161
	vmulpd	3144(%rbx), %ymm0, %ymm0	# MEM <vector(4) double> [(double *)rho1_66(D) + 3144B], tmp161, vect__154.711
# poisson.h:24:     g[1] = f[1]/B;
	movl	$4, %eax	#, ivtmp.771
	leaq	-3264(%rbp), %rcx	#, tmp239
	leaq	-6464(%rbp), %rdx	#, tmp237
# poisson.h:23:     w[1] = C/B;
	vmovsd	.LC42(%rip), %xmm1	#, tmp167
	vmovsd	.LC60(%rip), %xmm3	#, tmp235
	vmovsd	%xmm1, -3256(%rbp)	# tmp167, w[1]
	vmovsd	.LC12(%rip), %xmm4	#, tmp236
# poisson.h:18:     for(i=1; i<=N_G-2; i++) f[i] = ALPHA * rho1[i];
	vmovupd	%ymm0, -6568(%rbp)	# vect__154.711, MEM <vector(4) double> [(double *)&f + 3144B]
# poisson.h:18:     for(i=1; i<=N_G-2; i++) f[i] = ALPHA * rho1[i];
	vmovddup	.LC57(%rip), %xmm0	#, tmp165
	vmulpd	3176(%rbx), %xmm0, %xmm0	# MEM <vector(2) double> [(double *)rho1_66(D) + 3176B], tmp165, vect__210.728
# poisson.h:18:     for(i=1; i<=N_G-2; i++) f[i] = ALPHA * rho1[i];
	vmovupd	%xmm0, -6536(%rbp)	# vect__210.728, MEM <vector(2) double> [(double *)&f + 3176B]
# poisson.h:19:     f[1] -= pot[0];
	vmovsd	-9704(%rbp), %xmm0	# f[1], f[1]
	vsubsd	%xmm2, %xmm0, %xmm0	# _3, f[1], _10
# poisson.h:24:     g[1] = f[1]/B;
	vmulsd	%xmm1, %xmm0, %xmm0	# tmp167, _10, g_I_lsm0.718
# poisson.h:24:     g[1] = f[1]/B;
	vmovsd	%xmm0, -6456(%rbp)	# g_I_lsm0.718, g[1]
.L151:
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vsubsd	%xmm1, %xmm3, %xmm1	# w_I_lsm0.719, tmp235, _14
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vmovsd	-16(%rsi,%rax,8), %xmm5	# MEM[(double *)&f + -16B + ivtmp.771_17 * 8], MEM[(double *)&f + -16B + ivtmp.771_17 * 8]
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vdivsd	%xmm1, %xmm4, %xmm6	# _14, tmp236, _15
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vsubsd	%xmm0, %xmm5, %xmm5	# g_I_lsm0.718, MEM[(double *)&f + -16B + ivtmp.771_17 * 8], tmp173
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vmovsd	%xmm6, -16(%rcx,%rax,8)	# _15, MEM[(double *)&w + -16B + ivtmp.771_17 * 8]
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vdivsd	%xmm1, %xmm5, %xmm5	# _14, tmp173, _21
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vsubsd	%xmm6, %xmm3, %xmm6	# _15, tmp235, _103
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vmovsd	-8(%rsi,%rax,8), %xmm0	# MEM[(double *)&f + -8B + ivtmp.771_17 * 8], MEM[(double *)&f + -8B + ivtmp.771_17 * 8]
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vmovsd	%xmm5, -16(%rdx,%rax,8)	# _21, MEM[(double *)&g + -16B + ivtmp.771_17 * 8]
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vdivsd	%xmm6, %xmm4, %xmm1	# _103, tmp236, w_I_lsm0.719
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vsubsd	%xmm5, %xmm0, %xmm0	# _21, MEM[(double *)&f + -8B + ivtmp.771_17 * 8], tmp180
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vmovsd	%xmm1, -8(%rcx,%rax,8)	# w_I_lsm0.719, MEM[(double *)&w + -8B + ivtmp.771_17 * 8]
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vdivsd	%xmm6, %xmm0, %xmm0	# _103, tmp180, g_I_lsm0.718
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vmovsd	%xmm0, -8(%rdx,%rax,8)	# g_I_lsm0.718, MEM[(double *)&g + -8B + ivtmp.771_17 * 8]
	addq	$2, %rax	#, ivtmp.771
	cmpq	$400, %rax	#, ivtmp.771
	jne	.L151	#,
# poisson.h:31:     pot[N_G-2] = g[N_G-2];
	movl	$3176, %eax	#, ivtmp.766
	leaq	pot(%rip), %rsi	#, ivtmp.750
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vsubsd	-88(%rbp), %xmm3, %xmm3	# w[397], tmp235, _220
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vmovsd	-6528(%rbp), %xmm0	# f[398], f[398]
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vdivsd	%xmm3, %xmm4, %xmm4	# _220, tmp236, tmp184
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vsubsd	-3288(%rbp), %xmm0, %xmm0	# g[397], f[398], tmp186
# poisson.h:26:         w[i] = C / (B - A * w[i-1]);
	vmovsd	%xmm4, -80(%rbp)	# tmp184, w[398]
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vdivsd	%xmm3, %xmm0, %xmm1	# _220, tmp186, _212
# poisson.h:27:         g[i] = (f[i] - A * g[i-1]) / (B - A * w[i-1]);
	vmovsd	%xmm1, -3280(%rbp)	# _212, g[398]
# poisson.h:31:     pot[N_G-2] = g[N_G-2];
	vmovsd	%xmm1, 3184+pot(%rip)	# _212, pot[398]
	vmovsd	%xmm1, %xmm1, %xmm0	# _212, pot_I_lsm0.721
	.p2align 4
	.p2align 3
.L152:
# poisson.h:32:     for (i=N_G-3; i>0; i--) pot[i] = g[i] - w[i] * pot[i+1];            // potential at the grid points between the electrodes
	vmovsd	(%rdx,%rax), %xmm7	# MEM[(double *)&g + ivtmp.766_13 * 1], tmp248
	vfnmadd132sd	(%rcx,%rax), %xmm7, %xmm0	# MEM[(double *)&w + ivtmp.766_13 * 1], tmp248, pot_I_lsm0.721
# poisson.h:32:     for (i=N_G-3; i>0; i--) pot[i] = g[i] - w[i] * pot[i+1];            // potential at the grid points between the electrodes
	vmovsd	%xmm0, (%rsi,%rax)	# pot_I_lsm0.721, MEM[(double *)&pot + ivtmp.766_13 * 1]
# poisson.h:32:     for (i=N_G-3; i>0; i--) pot[i] = g[i] - w[i] * pot[i+1];            // potential at the grid points between the electrodes
	subq	$8, %rax	#, ivtmp.766
	jne	.L152	#,
	vbroadcastsd	.LC62(%rip), %zmm3	#, tmp241
	leaq	8+efield(%rip), %rdx	#, ivtmp.746
	leaq	pot(%rip), %rax	#, ivtmp.750
	leaq	3136(%rdx), %rcx	#, _31
	.p2align 4
	.p2align 3
.L153:
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vmovupd	(%rax), %zmm6	# MEM <vector(8) double> [(double *)_175], tmp249
	vsubpd	16(%rax), %zmm6, %zmm0	# MEM <vector(8) double> [(double *)_175 + 16B], tmp249, vect__33.682
	addq	$64, %rdx	#, ivtmp.746
	addq	$64, %rax	#, ivtmp.750
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vmulpd	%zmm3, %zmm0, %zmm0	# tmp241, vect__33.682, vect__34.683
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vmovupd	%zmm0, -64(%rdx)	# vect__34.683, MEM <vector(8) double> [(double *)_180]
	cmpq	%rdx, %rcx	# ivtmp.746, _31
	jne	.L153	#,
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vmovupd	3136+pot(%rip), %ymm4	# MEM <vector(4) double> [(double *)&pot + 3136B], tmp250
	vsubpd	3152+pot(%rip), %ymm4, %ymm0	# MEM <vector(4) double> [(double *)&pot + 3152B], tmp250, vect__103.694
	vmovapd	3168+pot(%rip), %xmm5	# MEM <vector(2) double> [(double *)&pot + 3168B], tmp251
# poisson.h:37:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // powered electrode
	vmovsd	.LC67(%rip), %xmm4	#, tmp223
# poisson.h:37:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // powered electrode
	vsubsd	8+pot(%rip), %xmm2, %xmm2	# pot[1], _3, tmp217
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vmulpd	.LC62(%rip){1to4}, %ymm0, %ymm0	#, vect__103.694, vect__102.695
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vmovupd	%ymm0, 3144+efield(%rip)	# vect__102.695, MEM <vector(4) double> [(double *)&efield + 3144B]
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vsubpd	3184+pot(%rip), %xmm5, %xmm0	# MEM <vector(2) double> [(double *)&pot + 3184B], tmp251, vect__125.737
# poisson.h:37:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // powered electrode
	vmovsd	.LC66(%rip), %xmm5	#, tmp222
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vmulpd	.LC62(%rip){1to2}, %xmm0, %xmm0	#, vect__125.737, vect__228.738
# poisson.h:36:     for(i=1; i<=N_G-2; i++) efield[i] = (pot[i-1] - pot[i+1]) * S;      // electric field at the grid points between the electrodes
	vmovupd	%xmm0, 3176+efield(%rip)	# vect__228.738, MEM <vector(2) double> [(double *)&efield + 3176B]
# poisson.h:37:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // powered electrode
	vmovsd	.LC65(%rip), %xmm0	#, tmp220
	vmulsd	(%rbx), %xmm0, %xmm3	# *rho1_66(D), tmp220, tmp218
# poisson.h:38:     efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + rho1[N_G-1] * DX / (2.0 * EPSILON0);   // grounded electrode
	vmulsd	3192(%rbx), %xmm0, %xmm0	# MEM[(double *)rho1_66(D) + 3192B], tmp220, tmp225
# poisson.h:37:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // powered electrode
	vdivsd	%xmm5, %xmm3, %xmm3	# tmp222, tmp218, tmp221
# poisson.h:38:     efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + rho1[N_G-1] * DX / (2.0 * EPSILON0);   // grounded electrode
	vdivsd	%xmm5, %xmm0, %xmm0	# tmp222, tmp225, tmp228
# poisson.h:37:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // powered electrode
	vfmsub132sd	%xmm4, %xmm3, %xmm2	# tmp223, tmp221, _42
# poisson.h:38:     efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + rho1[N_G-1] * DX / (2.0 * EPSILON0);   // grounded electrode
	vfmadd132sd	%xmm4, %xmm0, %xmm1	# tmp223, tmp228, _50
# poisson.h:37:     efield[0]     = (pot[0]     - pot[1])     * INV_DX - rho1[0]     * DX / (2.0 * EPSILON0);   // powered electrode
	vmovsd	%xmm2, efield(%rip)	# _42, efield[0]
# poisson.h:38:     efield[N_G-1] = (pot[N_G-2] - pot[N_G-1]) * INV_DX + rho1[N_G-1] * DX / (2.0 * EPSILON0);   // grounded electrode
	vmovsd	%xmm1, 3192+efield(%rip)	# _50, efield[399]
# poisson.h:39: }
	movq	-56(%rbp), %rax	# D.82580, tmp246
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp246
	jne	.L161	#,
	vzeroupper
	addq	$9696, %rsp	#,
	popq	%rbx	#
	popq	%r10	#
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%rbp	#
	leaq	-8(%r10), %rsp	#,
	.cfi_def_cfa 7, 8
	ret	
.L161:
	.cfi_restore_state
	vzeroupper
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE3846:
	.size	_Z13solve_PoissonPdd, .-_Z13solve_PoissonPdd


# --- Symbol: _Z19step2_solve_poissond.isra.0 ---
	.section	.text._Z19step2_solve_poissond.isra.0,"axG",@progbits,_Z12do_one_cyclev,comdat
	.p2align 4
	.type	_Z19step2_solve_poissond.isra.0, @function
_Z19step2_solve_poissond.isra.0:
.LFB4756:
	.cfi_startproc
	leaq	8(%rsp), %r10	#,
	.cfi_def_cfa 10, 0
	andq	$-64, %rsp	#,
	leaq	i_density(%rip), %rcx	#, tmp105
	leaq	e_density(%rip), %rdx	#, tmp102
	pushq	-8(%r10)	#
	pushq	%rbp	#
	movq	%rsp, %rbp	#,
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r10	#
	.cfi_escape 0xf,0x3,0x76,0x78,0x6
	subq	$3304, %rsp	#,
	vbroadcastsd	.LC51(%rip), %zmm1	#, tmp104
	leaq	-3312(%rbp), %rdi	#, tmp103
# simulation.h:64: inline void step2_solve_poisson(double current_time){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp106
	movq	%rax, -56(%rbp)	# tmp106, D.82611
	xorl	%eax, %eax	# tmp106
	.p2align 4
	.p2align 3
.L163:
# simulation.h:68:         rho[p] = E_CHARGE * (i_density[p] - e_density[p]);  // get charge density
	vmovupd	(%rcx,%rax), %zmm2	# MEM <vector(8) double> [(double *)&i_density + ivtmp.819_21 * 1], tmp109
	vsubpd	(%rdx,%rax), %zmm2, %zmm0	# MEM <vector(8) double> [(double *)&e_density + ivtmp.819_21 * 1], tmp109, vect__4.811
# simulation.h:68:         rho[p] = E_CHARGE * (i_density[p] - e_density[p]);  // get charge density
	vmulpd	%zmm1, %zmm0, %zmm0	# tmp104, vect__4.811, vect__5.812
# simulation.h:68:         rho[p] = E_CHARGE * (i_density[p] - e_density[p]);  // get charge density
	vmovapd	%zmm0, (%rdi,%rax)	# vect__5.812, MEM <vector(8) double> [(double *)&rho + ivtmp.819_21 * 1]
	addq	$64, %rax	#, ivtmp.819
	cmpq	$3200, %rax	#, ivtmp.819
	jne	.L163	#,
# simulation.h:70:     solve_Poisson(rho,Time);                                // compute potential and electric field
	vmovsd	Time(%rip), %xmm0	# Time,
	vzeroupper
	call	_Z13solve_PoissonPdd	#
# simulation.h:71: }
	movq	-56(%rbp), %rax	# D.82611, tmp107
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp107
	jne	.L168	#,
	movq	-8(%rbp), %r10	#,
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	leave	
	leaq	-8(%r10), %rsp	#,
	.cfi_def_cfa 7, 8
	ret	
.L168:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE4756:
	.size	_Z19step2_solve_poissond.isra.0, .-_Z19step2_solve_poissond.isra.0


