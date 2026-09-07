# --- Symbol: _Z26step7_collisions_electronsv ---
	.section	.text._Z26step7_collisions_electronsv,"axG",@progbits,_Z26step7_collisions_electronsv,comdat
	.p2align 4
	.weak	_Z26step7_collisions_electronsv
	.type	_Z26step7_collisions_electronsv, @function
_Z26step7_collisions_electronsv:
.LFB3870:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3870
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
	subq	$264, %rsp	#,
	.cfi_def_cfa_offset 320
# simulation.h:208:     std::binomial_distribution<int> binom_e(N_e, P_star_e);
	movl	N_e(%rip), %esi	# N_e,
	vmovsd	P_star_e(%rip), %xmm0	# P_star_e,
	leaq	96(%rsp), %rbx	#, tmp122
	movq	%rbx, %rdi	# tmp122,
# simulation.h:206: inline void step7_collisions_electrons(){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp193
	movq	%rax, 248(%rsp)	# tmp193, D.83843
	xorl	%eax, %eax	# tmp193
# simulation.h:208:     std::binomial_distribution<int> binom_e(N_e, P_star_e);
	call	_ZNSt21binomial_distributionIiEC1Eid	#
# simulation.h:209:     int N_coll_star_e = binom_e(MTgen);
	leaq	MTgen(%rip), %rsi	#, tmp124
	movq	%rbx, %rdi	# tmp122,
	call	_ZNSt21binomial_distributionIiEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEiRT_	#
# simulation.h:210:     if (N_coll_star_e > N_e) N_coll_star_e = N_e;
	movl	N_e(%rip), %ebp	# N_e, N_e.74_3
# simulation.h:210:     if (N_coll_star_e > N_e) N_coll_star_e = N_e;
	cmpl	%eax, %ebp	# tmp185, N_e.74_3
	cmovle	%ebp, %eax	# N_e.74_3,, tmp185
# simulation.h:212:     if (N_coll_star_e > 0) {
	testl	%eax, %eax	# _33
	jg	.L775	#,
.L759:
# simulation.h:249: }
	movq	248(%rsp), %rax	# D.83843, tmp195
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp195
	jne	.L774	#,
	addq	$264, %rsp	#,
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
.L775:
	.cfi_restore_state
	movl	%eax, %ebx	# tmp185, _33
# simulation.h:213:         std::vector<int> candidates_e;
	leaq	64(%rsp), %rax	#, tmp174
	movq	%rax, %rdi	# tmp174,
	movq	%rax, 24(%rsp)	# tmp174, %sfp
	call	_ZNSt6vectorIiSaIiEEC1Ev	#
# simulation.h:214:         random_sample(N_e, N_coll_star_e, candidates_e);
	movq	24(%rsp), %rdx	# %sfp,
	movl	%ebx, %esi	# _33,
	movl	%ebp, %edi	# N_e.74_3,
.LEHB3:
	call	_Z13random_sampleiiRSt6vectorIiSaIiEE	#
.LEHE3:
# simulation.h:216:         for (int ki : candidates_e) {
	movq	24(%rsp), %rdi	# %sfp,
	leaq	48(%rsp), %rbx	#, tmp179
	call	_ZNSt6vectorIiSaIiEE5beginEv	#
# simulation.h:216:         for (int ki : candidates_e) {
	movq	24(%rsp), %rdi	# %sfp,
# simulation.h:216:         for (int ki : candidates_e) {
	movq	%rax, 48(%rsp)	# tmp186, __for_begin
# simulation.h:216:         for (int ki : candidates_e) {
	call	_ZNSt6vectorIiSaIiEE3endEv	#
	movq	%rax, 56(%rsp)	# tmp187, __for_end
	leaq	56(%rsp), %rax	#, tmp180
	movq	%rax, 16(%rsp)	# tmp180, %sfp
# simulation.h:216:         for (int ki : candidates_e) {
	jmp	.L761	#
	.p2align 4
	.p2align 3
.L763:
# simulation.h:216:         for (int ki : candidates_e) {
	movq	%rbx, %rdi	# tmp179,
	call	_ZN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEppEv.isra.0	#
.L761:
# simulation.h:216:         for (int ki : candidates_e) {
	movq	16(%rsp), %rsi	# %sfp,
	movq	%rbx, %rdi	# tmp179,
	call	_ZN9__gnu_cxxneIPiSt6vectorIiSaIiEEEEbRKNS_17__normal_iteratorIT_T0_EESA_	#
	testb	%al, %al	# tmp191
	je	.L776	#,
# simulation.h:216:         for (int ki : candidates_e) {
	movq	48(%rsp), %rdi	# MEM[(int * *)&__for_begin],
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	leaq	vx_e(%rip), %r14	#, tmp176
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	leaq	vy_e(%rip), %r15	#, tmp177
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	leaq	vz_e(%rip), %rbp	#, tmp178
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	leaq	44(%rsp), %rsi	#, tmp150
# simulation.h:216:         for (int ki : candidates_e) {
	call	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEdeEv.isra.0	#
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	leaq	40(%rsp), %rdi	#, tmp151
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	movl	$999999, 44(%rsp)	#, D.72492
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	movslq	(%rax), %r13	# *_4, ki
	vmovsd	(%r14,%r13,8), %xmm0	# vx_e[ki_43], _5
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vmovsd	(%r15,%r13,8), %xmm1	# vy_e[ki_43], _7
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vmulsd	%xmm1, %xmm1, %xmm1	# _7, _7, tmp138
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vfmadd231sd	%xmm0, %xmm0, %xmm1	# _5, _5, _9
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vmovsd	0(%rbp,%r13,8), %xmm0	# vz_e[ki_43], _10
# simulation.h:217:             double v_sqr = vx_e[ki]*vx_e[ki] + vy_e[ki]*vy_e[ki] + vz_e[ki]*vz_e[ki];
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# _10, _9, v_sqr
# simulation.h:218:             double velocity = sqrt(v_sqr);
	vsqrtsd	%xmm0, %xmm0, %xmm1	# v_sqr, velocity
# simulation.h:219:             double energy   = 0.5 * E_MASS * v_sqr / EV_TO_J;
	vmulsd	.LC78(%rip), %xmm0, %xmm0	#, v_sqr, tmp141
# simulation.h:219:             double energy   = 0.5 * E_MASS * v_sqr / EV_TO_J;
	vdivsd	.LC51(%rip), %xmm0, %xmm0	#, tmp141, energy
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vdivsd	.LC3(%rip), %xmm0, %xmm0	#, energy, tmp145
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vaddsd	.LC46(%rip), %xmm0, %xmm0	#, tmp145, tmp147
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	vcvttsd2sil	%xmm0, %eax	# tmp147, tmp149
	movl	%eax, 40(%rsp)	# tmp149, D.72491
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	call	_ZSt3minIiERKT_S2_S2_.constprop.0	#
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	movslq	(%rax), %rsi	# *_16,
# simulation.h:222:             double real_nu = sigma_tot_e[energy_index] * velocity;
	leaq	sigma_tot_e(%rip), %rax	#, tmp152
# simulation.h:224:             if (p_accept > 1.0) p_accept = 1.0;
	vmovsd	.LC12(%rip), %xmm0	#, tmp155
# simulation.h:222:             double real_nu = sigma_tot_e[energy_index] * velocity;
	vmulsd	(%rax,%rsi,8), %xmm1, %xmm1	# sigma_tot_e[energy_index_50], velocity, real_nu
# simulation.h:220:             int energy_index = min(int(energy / DE_CS + 0.5), CS_RANGES - 1);
	movq	%rsi, %r12	#,
# simulation.h:223:             double p_accept = real_nu / nu_star_e;
	vdivsd	nu_star_e(%rip), %xmm1, %xmm1	# nu_star_e, real_nu, p_accept
# simulation.h:224:             if (p_accept > 1.0) p_accept = 1.0;
	vminsd	%xmm1, %xmm0, %xmm1	# p_accept, tmp155, p_accept
	vmovsd	%xmm1, 8(%rsp)	# p_accept, %sfp
# simulation.h:226:             if (R01(MTgen) < p_accept) {
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# simulation.h:226:             if (R01(MTgen) < p_accept) {
	vmovsd	8(%rsp), %xmm1	# %sfp, p_accept
	vcomisd	%xmm0, %xmm1	# tmp190, p_accept
	jbe	.L763	#,
	leaq	0(,%r13,8), %rax	#, _66
# simulation.h:227:                 collision_electron(x_e[ki], &vx_e[ki], &vy_e[ki], &vz_e[ki], energy_index);
	movl	%r12d, %ecx	# energy_index,
	leaq	0(%rbp,%rax), %rdx	#, tmp157
	leaq	(%r15,%rax), %rsi	#, tmp159
	leaq	(%r14,%rax), %rdi	#, tmp161
	leaq	x_e(%rip), %rax	#, tmp163
	vmovsd	(%rax,%r13,8), %xmm0	# x_e[ki_43], x_e[ki_43]
	call	_Z18collision_electrondPdS_S_i	#
# simulation.h:228:                 N_e_coll++;
	incq	N_e_coll(%rip)	# N_e_coll
	jmp	.L763	#
	.p2align 4
	.p2align 3
.L776:
# simulation.h:231:     }
	movq	24(%rsp), %rdi	# %sfp,
	call	_ZNSt6vectorIiSaIiEED1Ev	#
# simulation.h:249: }
	jmp	.L759	#
.L766:
# simulation.h:231:     }
	movq	24(%rsp), %rdi	# %sfp,
	vzeroupper
	call	_ZNSt6vectorIiSaIiEED1Ev	#
	movq	248(%rsp), %rax	# D.83843, tmp194
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp194
	je	.L767	#,
.L774:
# simulation.h:249: }
	call	__stack_chk_fail@PLT	#
.L770:
	endbr64	
# simulation.h:231:     }
	movq	%rax, %rbx	# tmp192, tmp171
	jmp	.L766	#
.L767:
	movq	%rbx, %rdi	# tmp171,
.LEHB4:
	call	_Unwind_Resume@PLT	#
.LEHE4:
	.cfi_endproc
.LFE3870:
	.section	.gcc_except_table._Z26step7_collisions_electronsv,"aG",@progbits,_Z26step7_collisions_electronsv,comdat
.LLSDA3870:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3870-.LLSDACSB3870
.LLSDACSB3870:
	.uleb128 .LEHB3-.LFB3870
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L770-.LFB3870
	.uleb128 0
	.uleb128 .LEHB4-.LFB3870
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
.LLSDACSE3870:
	.section	.text._Z26step7_collisions_electronsv,"axG",@progbits,_Z26step7_collisions_electronsv,comdat
	.size	_Z26step7_collisions_electronsv, .-_Z26step7_collisions_electronsv


# --- Symbol: _Z13random_sampleiiRSt6vectorIiSaIiEE ---
	.section	.text._Z13random_sampleiiRSt6vectorIiSaIiEE,"axG",@progbits,_Z13random_sampleiiRSt6vectorIiSaIiEE,comdat
	.p2align 4
	.weak	_Z13random_sampleiiRSt6vectorIiSaIiEE
	.type	_Z13random_sampleiiRSt6vectorIiSaIiEE, @function
_Z13random_sampleiiRSt6vectorIiSaIiEE:
.LFB3850:
	.cfi_startproc
	endbr64	
	pushq	%r14	#
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13	#
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12	#
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdx, %r13	# tmp140, out
	pushq	%rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
# null_collision.h:27:     static std::vector<int> pool;
	movzbl	_ZGVZ13random_sampleiiRSt6vectorIiSaIiEEE4pool(%rip), %eax	#, _1
# null_collision.h:26: inline void random_sample(int n , int count, std::vector<int> &out) {
	movl	%edi, %r12d	# tmp138, n
	movslq	%esi, %rbp	# tmp139,
	leaq	_ZZ13random_sampleiiRSt6vectorIiSaIiEEE4pool(%rip), %r14	#, tmp137
# null_collision.h:27:     static std::vector<int> pool;
# null_collision.h:27:     static std::vector<int> pool;
	testb	%al, %al	# _1
	je	.L757	#,
.L745:
# null_collision.h:29:     if (pool.size() < (size_t)n) {
	movq	8+_ZZ13random_sampleiiRSt6vectorIiSaIiEEE4pool(%rip), %rsi	# MEM[(int * *)&pool + 8B],
	movq	_ZZ13random_sampleiiRSt6vectorIiSaIiEEE4pool(%rip), %rdi	# MEM[(int * *)&pool],
# null_collision.h:29:     if (pool.size() < (size_t)n) {
	movslq	%r12d, %rbx	# n, n
# null_collision.h:29:     if (pool.size() < (size_t)n) {
	call	_ZNKSt6vectorIiSaIiEE4sizeEv.isra.0	#
# null_collision.h:29:     if (pool.size() < (size_t)n) {
	cmpq	%rbx, %rax	# n, tmp142
	jb	.L758	#,
.L747:
# null_collision.h:33:     std::iota(pool.begin(), pool.begin() + n, 0);
	call	_ZNSt6vectorIiSaIiEE5beginEv.constprop.0	#
# null_collision.h:33:     std::iota(pool.begin(), pool.begin() + n, 0);
	movq	%rbx, %rsi	# n,
# null_collision.h:33:     std::iota(pool.begin(), pool.begin() + n, 0);
	movq	%rax, %rdi	# tmp143, D.71894
# null_collision.h:33:     std::iota(pool.begin(), pool.begin() + n, 0);
	call	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEplEl.isra.0	#
	movq	%rax, %rbx	# tmp144, D.80637
# null_collision.h:33:     std::iota(pool.begin(), pool.begin() + n, 0);
	call	_ZNSt6vectorIiSaIiEE5beginEv.constprop.0	#
# null_collision.h:33:     std::iota(pool.begin(), pool.begin() + n, 0);
	xorl	%edx, %edx	#
# null_collision.h:33:     std::iota(pool.begin(), pool.begin() + n, 0);
	movq	%rax, %rdi	# tmp145, D.80638
# null_collision.h:33:     std::iota(pool.begin(), pool.begin() + n, 0);
	movq	%rbx, %rsi	# D.80637,
	call	_ZSt4iotaIN9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEEiEvT_S7_T0_	#
# null_collision.h:35:     for (int i = 0; i < count; i++) {
	testl	%ebp, %ebp	# count
	jle	.L748	#,
	xorl	%ebx, %ebx	# ivtmp.1742
	.p2align 4
	.p2align 3
.L749:
# null_collision.h:36:         int j = i + (int)(R01(MTgen) * (n - i));
	call	_ZNSt25uniform_real_distributionIdEclISt23mersenne_twister_engineImLm32ELm624ELm397ELm31ELm2567483615ELm11ELm4294967295ELm7ELm2636928640ELm15ELm4022730752ELm18ELm1812433253EEEEdRT_.constprop.0	#
# null_collision.h:36:         int j = i + (int)(R01(MTgen) * (n - i));
	movl	%r12d, %eax	# n, tmp128
# null_collision.h:36:         int j = i + (int)(R01(MTgen) * (n - i));
	vxorpd	%xmm2, %xmm2, %xmm2	# tmp156
# null_collision.h:36:         int j = i + (int)(R01(MTgen) * (n - i));
	subl	%ebx, %eax	# ivtmp.1742, tmp128
# null_collision.h:36:         int j = i + (int)(R01(MTgen) * (n - i));
	vmovsd	%xmm0, %xmm0, %xmm1	#, tmp146
# null_collision.h:36:         int j = i + (int)(R01(MTgen) * (n - i));
	vcvtsi2sdl	%eax, %xmm2, %xmm0	# tmp128, tmp156, tmp153
	vmulsd	%xmm1, %xmm0, %xmm0	# tmp146, tmp129, tmp130
# null_collision.h:36:         int j = i + (int)(R01(MTgen) * (n - i));
	vcvttsd2sil	%xmm0, %edi	# tmp130, tmp131
# null_collision.h:36:         int j = i + (int)(R01(MTgen) * (n - i));
	addl	%ebx, %edi	# ivtmp.1742, j
# null_collision.h:37:         std::swap(pool[i], pool[j]);
	movslq	%edi, %rdi	# j, j
	call	_ZNSt6vectorIiSaIiEEixEm.constprop.0	#
# null_collision.h:37:         std::swap(pool[i], pool[j]);
	movq	%rbx, %rdi	# ivtmp.1742,
# null_collision.h:37:         std::swap(pool[i], pool[j]);
	movq	%rax, %rsi	# tmp147, _11
# null_collision.h:37:         std::swap(pool[i], pool[j]);
	call	_ZNSt6vectorIiSaIiEEixEm.constprop.0	#
# null_collision.h:37:         std::swap(pool[i], pool[j]);
	vzeroupper
# null_collision.h:37:         std::swap(pool[i], pool[j]);
	movq	%rax, %rdi	# tmp148, _13
# null_collision.h:35:     for (int i = 0; i < count; i++) {
	incq	%rbx	# ivtmp.1742
# null_collision.h:37:         std::swap(pool[i], pool[j]);
	call	_ZSt4swapIiENSt9enable_ifIXsrSt6__and_IJSt6__not_ISt15__is_tuple_likeIT_EESt21is_move_constructibleIS4_ESt18is_move_assignableIS4_EEE5valueEvE4typeERS4_SE_	#
# null_collision.h:35:     for (int i = 0; i < count; i++) {
	cmpq	%rbp, %rbx	# count, ivtmp.1742
	jne	.L749	#,
.L748:
# null_collision.h:39:     out.assign(pool.begin(), pool.begin() + count);
	call	_ZNSt6vectorIiSaIiEE5beginEv.constprop.0	#
# null_collision.h:39:     out.assign(pool.begin(), pool.begin() + count);
	movq	%rbp, %rsi	# count,
# null_collision.h:39:     out.assign(pool.begin(), pool.begin() + count);
	movq	%rax, %rdi	# tmp149, D.72046
# null_collision.h:39:     out.assign(pool.begin(), pool.begin() + count);
	call	_ZNK9__gnu_cxx17__normal_iteratorIPiSt6vectorIiSaIiEEEplEl.isra.0	#
	movq	%rax, %rbx	# tmp150, D.80639
# null_collision.h:39:     out.assign(pool.begin(), pool.begin() + count);
	call	_ZNSt6vectorIiSaIiEE5beginEv.constprop.0	#
# null_collision.h:39:     out.assign(pool.begin(), pool.begin() + count);
	movq	%r13, %rdi	# out,
	movq	%rbx, %rdx	# D.80639,
# null_collision.h:40: }
	popq	%rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp	#
	.cfi_def_cfa_offset 32
# null_collision.h:39:     out.assign(pool.begin(), pool.begin() + count);
	movq	%rax, %rsi	# tmp151, D.80640
# null_collision.h:40: }
	popq	%r12	#
	.cfi_def_cfa_offset 24
	popq	%r13	#
	.cfi_def_cfa_offset 16
	popq	%r14	#
	.cfi_def_cfa_offset 8
# null_collision.h:39:     out.assign(pool.begin(), pool.begin() + count);
	jmp	_ZNSt6vectorIiSaIiEE6assignIN9__gnu_cxx17__normal_iteratorIPiS1_EEvEEvT_S7_	#
	.p2align 4
	.p2align 3
.L757:
	.cfi_restore_state
# null_collision.h:27:     static std::vector<int> pool;
	leaq	_ZGVZ13random_sampleiiRSt6vectorIiSaIiEEE4pool(%rip), %rbx	#, tmp116
	leaq	_ZZ13random_sampleiiRSt6vectorIiSaIiEEE4pool(%rip), %r14	#, tmp137
	movq	%rbx, %rdi	# tmp116,
	call	__cxa_guard_acquire@PLT	#
	testl	%eax, %eax	# tmp141
	je	.L745	#,
# null_collision.h:27:     static std::vector<int> pool;
	movq	%r14, %rdi	# tmp137,
	call	_ZNSt6vectorIiSaIiEEC1Ev	#
# null_collision.h:27:     static std::vector<int> pool;
	leaq	__dso_handle(%rip), %rdx	#, tmp118
	movq	%r14, %rsi	# tmp137,
	leaq	_ZNSt6vectorIiSaIiEED1Ev(%rip), %rdi	#, tmp120
	call	__cxa_atexit@PLT	#
# null_collision.h:27:     static std::vector<int> pool;
	movq	%rbx, %rdi	# tmp116,
	call	__cxa_guard_release@PLT	#
	jmp	.L745	#
	.p2align 4
	.p2align 3
.L758:
# null_collision.h:30:         pool.resize(n);
	movq	%rbx, %rsi	# n,
	movq	%r14, %rdi	# tmp137,
	call	_ZNSt6vectorIiSaIiEE6resizeEm	#
	jmp	.L747	#
	.cfi_endproc
.LFE3850:
	.size	_Z13random_sampleiiRSt6vectorIiSaIiEE, .-_Z13random_sampleiiRSt6vectorIiSaIiEE


