# --- Symbol: _Z20step8_collision_ionsi ---
	.section	.text._Z26step7_collisions_electronsv,"axG",@progbits,_Z26step7_collisions_electronsv,comdat
	.size	_Z26step7_collisions_electronsv, .-_Z26step7_collisions_electronsv
	.section	.text._Z20step8_collision_ionsi,"axG",@progbits,_Z20step8_collision_ionsi,comdat
	.p2align 4
	.weak	_Z20step8_collision_ionsi
	.type	_Z20step8_collision_ionsi, @function
_Z20step8_collision_ionsi:
.LFB3871:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3871
	endbr64	
# simulation.h:277:             if (p_accept > 1.0) p_accept = 1.0;
	imull	$-858993459, %edi, %edi	#, tmp206, tmp138
# simulation.h:251: inline void step8_collision_ions(int t){
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
	subq	$280, %rsp	#,
	.cfi_def_cfa_offset 336
# simulation.h:277:             if (p_accept > 1.0) p_accept = 1.0;
	addl	$429496728, %edi	#, tmp139
# simulation.h:251: inline void step8_collision_ions(int t){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp218
	movq	%rax, 264(%rsp)	# tmp218, D.83850
	xorl	%eax, %eax	# tmp218
# simulation.h:277:             if (p_accept > 1.0) p_accept = 1.0;
	rorx	$2, %edi, %edi	#, tmp139, tmp140
# simulation.h:252:     if ((t % N_SUB) != 0) return;
	cmpl	$214748364, %edi	#, tmp140
	jbe	.L794	#,
.L777:
# simulation.h:308: }
	movq	264(%rsp), %rax	# D.83850, tmp220
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp220
	jne	.L793	#,
	addq	$280, %rsp	#,
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
.L794:
	.cfi_restore_state
# simulation.h:255:     std::binomial_distribution<int> binom_i(N_i, P_star_i);
	movl	N_i(%rip), %esi	# N_i,
	leaq	112(%rsp), %rbx	#, tmp143
	vmovsd	P_star_i(%rip), %xmm0	# P_star_i,
	movq	%rbx, %rdi	# tmp143,
	call	_ZNSt21binomial_distributionIiEC1Eid	#
# simulation.h:256:     int N_coll_star_i = binom_i(MTgen);
	movq	%rbx, %rdi	# tmp143,
	leaq	MTgen(%rip), %rsi	#, tmp145
	call	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_	#
# simulation.h:257:     if (N_coll_star_i > N_i) N_coll_star_i = N_i;
	movl	N_i(%rip), %ebp	# N_i, N_i.124_4
# simulation.h:257:     if (N_coll_star_i > N_i) N_coll_star_i = N_i;
	cmpl	%eax, %ebp	# tmp207, N_i.124_4
	cmovle	%ebp, %eax	# N_i.124_4,, tmp207
	movl	%eax, %ebx	# tmp207, _35
# simulation.h:259:     if (N_coll_star_i > 0) {
	testl	%eax, %eax	# _35
	jle	.L777	#,
# simulation.h:260:         std::vector<int> candidates_i;
	leaq	80(%rsp), %rax	#, tmp199
	movq	%rax, %r14	# tmp199, tmp199
	movq	%rax, %rdi	# tmp199,
	movq	%rax, 40(%rsp)	# tmp199, %sfp
	call	_ZNSt6vectorIiSaIiEEC1Ev	#
# simulation.h:261:         random_sample(N_i, N_coll_star_i, candidates_i);
	movq	%r14, %rdx	# tmp199,
	movl	%ebx, %esi	# _35,
	movl	%ebp, %edi	# N_i.124_4,
.LEHB5:
	call	_Z13random_sampleiiRSt6vectorIiSaIiEE	#
.LEHE5:
# simulation.h:265:         for (int ki : candidates_i) {
	movq	40(%rsp), %rdi	# %sfp,
	leaq	64(%rsp), %rbx	#, tmp196
	call	_ZNSt6vectorIiSaIiEE5beginEv	#
# simulation.h:265:         for (int ki : candidates_i) {
	movq	40(%rsp), %rdi	# %sfp,
# simulation.h:265:         for (int ki : candidates_i) {
	movq	%rax, 64(%rsp)	# tmp208, __for_begin
# simulation.h:265:         for (int ki : candidates_i) {
	call	_ZNSt6vectorIiSaIiEE3endEv	#
	movq	%rax, 72(%rsp)	# tmp209, __for_end
	leaq	72(%rsp), %rax	#, tmp198
	movq	%rax, 32(%rsp)	# tmp198, %sfp
# simulation.h:265:         for (int ki : candidates_i) {
	jmp	.L780	#
	.p2align 4
	.p2align 3
.L782:
# simulation.h:265:         for (int ki : candidates_i) {
	movq	%rbx, %rdi	# tmp196,
	call	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEppEv.isra.0	#
.L780:
# simulation.h:265:         for (int ki : candidates_i) {
	movq	32(%rsp), %rsi	# %sfp,
	movq	%rbx, %rdi	# tmp196,
	call	_ZN9__gnu_cxxneIPiSt6vectorIiSaIiEEEEbRKNS_17__normal_iteratorIT_T0_EESA_	#
	testb	%al, %al	# tmp216
	je	.L795	#,
# simulation.h:265:         for (int ki : candidates_i) {
	movq	64(%rsp), %rdi	# MEM[(int * *)&__for_begin],
# simulation.h:267:             gx = vx_i[ki] - vx_a;
	leaq	vx_i(%rip), %r14	#, tmp195
# simulation.h:268:             gy = vy_i[ki] - vy_a;
	leaq	vy_i(%rip), %r15	#, tmp201
# simulation.h:269:             gz = vz_i[ki] - vz_a;
	leaq	vz_i(%rip), %rbp	#, tmp197
# simulation.h:265:         for (int ki : candidates_i) {
	call	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEdeEv.isra.0	#
	movslq	(%rax), %r13	# *_5,
# simulation.h:266:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
	vmovsd	%xmm0, (%rsp)	# tmp211, %sfp
# simulation.h:266:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
	vmovsd	%xmm0, 8(%rsp)	# tmp212, %sfp
# simulation.h:266:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	call	_ZNSt19normal_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# simulation.h:273:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	leaq	60(%rsp), %rsi	#, tmp174
	leaq	56(%rsp), %rdi	#, tmp175
# simulation.h:266:             vx_a = RMB(MTgen); vy_a = RMB(MTgen); vz_a = RMB(MTgen);
	vmovsd	%xmm0, %xmm0, %xmm2	# tmp213, _56
# simulation.h:273:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	movl	$999999, 60(%rsp)	#, D.72523
# simulation.h:269:             gz = vz_i[ki] - vz_a;
	vmovsd	%xmm2, 24(%rsp)	# _56, %sfp
# simulation.h:267:             gx = vx_i[ki] - vx_a;
	vmovsd	(%r14,%r13,8), %xmm1	# vx_i[ki_48], vx_i[ki_48]
# simulation.h:268:             gy = vy_i[ki] - vy_a;
	vmovsd	(%r15,%r13,8), %xmm3	# vy_i[ki_48], vy_i[ki_48]
# simulation.h:267:             gx = vx_i[ki] - vx_a;
	vsubsd	(%rsp), %xmm1, %xmm1	# %sfp, vx_i[ki_48], gx
# simulation.h:268:             gy = vy_i[ki] - vy_a;
	vsubsd	8(%rsp), %xmm3, %xmm3	# %sfp, vy_i[ki_48], gy
# simulation.h:270:             g_sqr = gx*gx + gy*gy + gz*gz;
	vmulsd	%xmm3, %xmm3, %xmm3	# gy, gy, tmp164
# simulation.h:270:             g_sqr = gx*gx + gy*gy + gz*gz;
	vfmadd132sd	%xmm1, %xmm3, %xmm1	# gx, tmp164, _11
# simulation.h:269:             gz = vz_i[ki] - vz_a;
	vmovsd	0(%rbp,%r13,8), %xmm0	# vz_i[ki_48], vz_i[ki_48]
	vsubsd	%xmm2, %xmm0, %xmm0	# _56, vz_i[ki_48], gz
# simulation.h:270:             g_sqr = gx*gx + gy*gy + gz*gz;
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# gz, _11, g_sqr
# simulation.h:271:             g = sqrt(g_sqr);
	vsqrtsd	%xmm0, %xmm0, %xmm1	# g_sqr, g
# simulation.h:272:             energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J;
	vmulsd	.LC189(%rip), %xmm0, %xmm0	#, g_sqr, tmp165
# simulation.h:272:             energy = 0.5 * MU_ARAR * g_sqr / EV_TO_J;
	vdivsd	.LC51(%rip), %xmm0, %xmm0	#, tmp165, energy
# simulation.h:273:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vdivsd	.LC3(%rip), %xmm0, %xmm0	#, energy, tmp169
# simulation.h:273:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vaddsd	.LC46(%rip), %xmm0, %xmm0	#, tmp169, tmp171
# simulation.h:273:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vcvttsd2sil	%xmm0, %eax	# tmp171, tmp173
	movl	%eax, 56(%rsp)	# tmp173, D.72522
# simulation.h:273:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	call	_ZSt3minIiERKT_S2_S2_.constprop.0	#
# simulation.h:273:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	movslq	(%rax), %rsi	# *_17,
# simulation.h:275:             double real_nu = sigma_tot_i[energy_index] * g;
	leaq	sigma_tot_i(%rip), %rax	#, tmp176
# simulation.h:277:             if (p_accept > 1.0) p_accept = 1.0;
	vmovsd	.LC12(%rip), %xmm0	#, tmp179
# simulation.h:275:             double real_nu = sigma_tot_i[energy_index] * g;
	vmulsd	(%rax,%rsi,8), %xmm1, %xmm1	# sigma_tot_i[energy_index_67], g, real_nu
# simulation.h:273:             energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	movq	%rsi, %r12	#,
# simulation.h:276:             double p_accept = real_nu / nu_star_i;
	vdivsd	nu_star_i(%rip), %xmm1, %xmm1	# nu_star_i, real_nu, p_accept
# simulation.h:277:             if (p_accept > 1.0) p_accept = 1.0;
	vminsd	%xmm1, %xmm0, %xmm1	# p_accept, tmp179, p_accept
	vmovsd	%xmm1, 16(%rsp)	# p_accept, %sfp
# simulation.h:279:             if (R01(MTgen) < p_accept) {
	vzeroupper
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# simulation.h:279:             if (R01(MTgen) < p_accept) {
	vmovsd	16(%rsp), %xmm1	# %sfp, p_accept
	vmovsd	24(%rsp), %xmm2	# %sfp, _56
	vcomisd	%xmm0, %xmm1	# tmp215, p_accept
	jbe	.L782	#,
	salq	$3, %r13	#, _84
# simulation.h:280:                 collision_ion(&vx_i[ki], &vy_i[ki], &vz_i[ki], &vx_a, &vy_a, &vz_a, energy_index);
	vmovsd	8(%rsp), %xmm1	# %sfp,
	vmovsd	(%rsp), %xmm0	# %sfp,
	leaq	0(%rbp,%r13), %rdx	#, tmp181
	leaq	(%r15,%r13), %rsi	#, tmp183
	leaq	(%r14,%r13), %rdi	#, tmp185
	movl	%r12d, %ecx	# energy_index,
	call	_Z13collision_ionPdS_S_S_S_S_i.isra.0	#
# simulation.h:281:                 N_i_coll++;
	incq	N_i_coll(%rip)	# N_i_coll
	jmp	.L782	#
	.p2align 4
	.p2align 3
.L795:
# simulation.h:284:     }
	movq	40(%rsp), %rdi	# %sfp,
	call	_ZNSt6vectorIiSaIiEED1Ev	#
	jmp	.L777	#
.L785:
	movq	40(%rsp), %rdi	# %sfp,
	vzeroupper
	call	_ZNSt6vectorIiSaIiEED1Ev	#
	movq	264(%rsp), %rax	# D.83850, tmp219
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp219
	je	.L786	#,
.L793:
# simulation.h:308: }
	call	__stack_chk_fail@PLT	#
.L789:
	endbr64	
# simulation.h:284:     }
	movq	%rax, %rbx	# tmp217, tmp192
	jmp	.L785	#
.L786:
	movq	%rbx, %rdi	# tmp192,
.LEHB6:
	call	_Unwind_Resume@PLT	#
.LEHE6:
	.cfi_endproc
.LFE3871:
	.section	.gcc_except_table._Z20step8_collision_ionsi,"aG",@progbits,_Z20step8_collision_ionsi,comdat
.LLSDA3871:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3871-.LLSDACSB3871
.LLSDACSB3871:
	.uleb128 .LEHB5-.LFB3871
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L789-.LFB3871
	.uleb128 0
	.uleb128 .LEHB6-.LFB3871
	.uleb128 .LEHE6-.LEHB6
	.uleb128 0
	.uleb128 0
.LLSDACSE3871:
	.section	.text._Z20step8_collision_ionsi,"axG",@progbits,_Z20step8_collision_ionsi,comdat
	.size	_Z20step8_collision_ionsi, .-_Z20step8_collision_ionsi


