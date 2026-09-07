# --- Symbol: _Z27step6_check_boundaries_ionsi ---
	.section	.text._Z27step6_check_boundaries_ionsi,"axG",@progbits,_Z27step6_check_boundaries_ionsi,comdat
	.p2align 4
	.weak	_Z27step6_check_boundaries_ionsi
	.type	_Z27step6_check_boundaries_ionsi, @function
_Z27step6_check_boundaries_ionsi:
.LFB3869:
	.cfi_startproc
	endbr64	
# simulation.h:171:     if ((t % N_SUB) != 0) return;
	movslq	%edi, %rdx	# t, t
	movl	%edi, %eax	# t, tmp121
	imulq	$1717986919, %rdx, %rdx	#, t, tmp118
	sarl	$31, %eax	#, tmp121
	sarq	$35, %rdx	#, tmp120
	subl	%eax, %edx	# tmp121, k
	leal	(%rdx,%rdx,4), %eax	#, tmp124
	sall	$2, %eax	#, tmp125
# simulation.h:171:     if ((t % N_SUB) != 0) return;
	subl	%eax, %edi	# tmp125, t
	jne	.L286	#,
# simulation.h:178:     while (k < N_i) {
	movl	N_i(%rip), %esi	# N_i, N_i_lsm.964
	testl	%esi, %esi	# N_i_lsm.964
	jle	.L286	#,
# simulation.h:170: inline void step6_check_boundaries_ions(int t){
	pushq	%r14	#
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movl	%edi, %edx	# t, k
	pushq	%r13	#
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	N_i_abs_gnd(%rip), %r11	# N_i_abs_gnd, N_i_abs_gnd_lsm.962
	pushq	%r12	#
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
# simulation.h:178:     while (k < N_i) {
	xorl	%ecx, %ecx	# N_i_lsm_flag.965
# simulation.h:170: inline void step6_check_boundaries_ions(int t){
	pushq	%rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
# simulation.h:178:     while (k < N_i) {
	xorl	%r12d, %r12d	# N_i_abs_gnd_lsm_flag.963
# simulation.h:170: inline void step6_check_boundaries_ions(int t){
	pushq	%rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
# simulation.h:178:     while (k < N_i) {
	xorl	%ebp, %ebp	# N_i_abs_pow_lsm_flag.961
	movq	N_i_abs_pow(%rip), %rbx	# N_i_abs_pow, N_i_abs_pow_lsm.960
	leaq	x_i(%rip), %rdi	#, tmp184
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	leaq	vx_i(%rip), %r10	#, tmp193
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	leaq	vy_i(%rip), %r9	#, tmp194
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	leaq	vz_i(%rip), %r8	#, tmp195
# simulation.h:188:         if (x_i[k] > L) {
	vmovsd	.LC82(%rip), %xmm4	#, tmp192
# simulation.h:194:             if (energy_index < N_IFED) ifed_gnd[energy_index]++;
	leaq	ifed_gnd(%rip), %r13	#, tmp198
# simulation.h:186:             if (energy_index < N_IFED) ifed_pow[energy_index]++;
	leaq	ifed_pow(%rip), %r14	#, tmp201
# simulation.h:192:             energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vmovsd	.LC53(%rip), %xmm3	#, tmp196
# simulation.h:192:             energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vmovsd	.LC51(%rip), %xmm2	#, tmp197
	jmp	.L267	#
	.p2align 4
	.p2align 3
.L282:
# simulation.h:188:         if (x_i[k] > L) {
	vcomisd	%xmm4, %xmm0	# tmp192, _96
	jbe	.L283	#,
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r10,%rax,8), %xmm0	# vx_i[k_84], _125
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r9,%rax,8), %xmm1	# vy_i[k_84], _127
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmulsd	%xmm1, %xmm1, %xmm1	# _127, _127, tmp153
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd231sd	%xmm0, %xmm0, %xmm1	# _125, _125, _129
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r8,%rax,8), %xmm0	# vz_i[k_84], _130
# simulation.h:191:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# _130, _129, v_sqr
# simulation.h:192:             energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vmulsd	%xmm3, %xmm0, %xmm0	# tmp196, v_sqr, tmp156
# simulation.h:192:             energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vdivsd	%xmm2, %xmm0, %xmm0	# tmp197, tmp156, energy
# simulation.h:193:             energy_index = (int)(energy / DE_IFED);
	vcvttsd2sil	%xmm0, %ecx	# energy, energy_index
# simulation.h:194:             if (energy_index < N_IFED) ifed_gnd[energy_index]++;
	cmpl	$199, %ecx	#, energy_index
	jg	.L265	#,
# simulation.h:194:             if (energy_index < N_IFED) ifed_gnd[energy_index]++;
	movslq	%ecx, %rcx	# energy_index, energy_index
	incl	0(%r13,%rcx,4)	# ifed_gnd[energy_index_135]
.L265:
# simulation.h:189:             N_i_abs_gnd++;
	incq	%r11	# N_i_abs_gnd_lsm.962
	movl	$1, %r12d	#, N_i_abs_gnd_lsm_flag.963
.L261:
# simulation.h:197:             x_i [k] = x_i [N_i-1];
	decl	%esi	# N_i_lsm.964
# simulation.h:197:             x_i [k] = x_i [N_i-1];
	movslq	%esi, %rcx	# N_i_lsm.964, N_i_lsm.964
	vmovsd	(%rdi,%rcx,8), %xmm0	# x_i[_114], _115
# simulation.h:197:             x_i [k] = x_i [N_i-1];
	vmovsd	%xmm0, (%rdi,%rax,8)	# _115, x_i[k_84]
# simulation.h:198:             vx_i[k] = vx_i[N_i-1];
	vmovsd	(%r10,%rcx,8), %xmm0	# vx_i[_114], _117
# simulation.h:198:             vx_i[k] = vx_i[N_i-1];
	vmovsd	%xmm0, (%r10,%rax,8)	# _117, vx_i[k_84]
# simulation.h:199:             vy_i[k] = vy_i[N_i-1];
	vmovsd	(%r9,%rcx,8), %xmm0	# vy_i[_114], _119
# simulation.h:199:             vy_i[k] = vy_i[N_i-1];
	vmovsd	%xmm0, (%r9,%rax,8)	# _119, vy_i[k_84]
# simulation.h:200:             vz_i[k] = vz_i[N_i-1];
	vmovsd	(%r8,%rcx,8), %xmm0	# vz_i[_114], _121
# simulation.h:200:             vz_i[k] = vz_i[N_i-1];
	movl	$1, %ecx	#, N_i_lsm_flag.965
	vmovsd	%xmm0, (%r8,%rax,8)	# _121, vz_i[k_84]
# simulation.h:178:     while (k < N_i) {
	cmpl	%esi, %edx	# N_i_lsm.964, k
	jge	.L289	#,
.L267:
# simulation.h:180:         if (x_i[k] < 0) {
	movslq	%edx, %rax	# k, k
# simulation.h:180:         if (x_i[k] < 0) {
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp128
# simulation.h:180:         if (x_i[k] < 0) {
	vmovsd	(%rdi,%rax,8), %xmm0	# x_i[k_84], _96
# simulation.h:180:         if (x_i[k] < 0) {
	vcomisd	%xmm0, %xmm1	# _96, tmp128
	jbe	.L282	#,
# simulation.h:183:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r10,%rax,8), %xmm0	# vx_i[k_84], _141
# simulation.h:183:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r9,%rax,8), %xmm1	# vy_i[k_84], _143
# simulation.h:183:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmulsd	%xmm1, %xmm1, %xmm1	# _143, _143, tmp133
# simulation.h:183:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd231sd	%xmm0, %xmm0, %xmm1	# _141, _141, _145
# simulation.h:183:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vmovsd	(%r8,%rax,8), %xmm0	# vz_i[k_84], _146
# simulation.h:183:             v_sqr  = vx_i[k] * vx_i[k] + vy_i[k] * vy_i[k] + vz_i[k] * vz_i[k];
	vfmadd132sd	%xmm0, %xmm1, %xmm0	# _146, _145, v_sqr
# simulation.h:184:             energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vmulsd	%xmm3, %xmm0, %xmm0	# tmp196, v_sqr, tmp136
# simulation.h:184:             energy = 0.5 * AR_MASS * v_sqr / EV_TO_J;
	vdivsd	%xmm2, %xmm0, %xmm0	# tmp197, tmp136, energy
# simulation.h:185:             energy_index = (int)(energy / DE_IFED);
	vcvttsd2sil	%xmm0, %ecx	# energy, energy_index
# simulation.h:186:             if (energy_index < N_IFED) ifed_pow[energy_index]++;
	cmpl	$199, %ecx	#, energy_index
	jg	.L262	#,
# simulation.h:186:             if (energy_index < N_IFED) ifed_pow[energy_index]++;
	movslq	%ecx, %rcx	# energy_index, energy_index
	incl	(%r14,%rcx,4)	# ifed_pow[energy_index_151]
.L262:
# simulation.h:181:             N_i_abs_pow++;
	incq	%rbx	# N_i_abs_pow_lsm.960
	movl	$1, %ebp	#, N_i_abs_pow_lsm_flag.961
	jmp	.L261	#
	.p2align 4
	.p2align 3
.L283:
# simulation.h:202:         } else k++;
	incl	%edx	# k
# simulation.h:178:     while (k < N_i) {
	cmpl	%esi, %edx	# N_i_lsm.964, k
	jl	.L267	#,
.L289:
	testb	%cl, %cl	# N_i_lsm_flag.965
	je	.L268	#,
	movl	%esi, N_i(%rip)	# N_i_lsm.964, N_i
.L268:
	testb	%r12b, %r12b	# N_i_abs_gnd_lsm_flag.963
	je	.L269	#,
	movq	%r11, N_i_abs_gnd(%rip)	# N_i_abs_gnd_lsm.962, N_i_abs_gnd
.L269:
	testb	%bpl, %bpl	# N_i_abs_pow_lsm_flag.961
	je	.L284	#,
	movq	%rbx, N_i_abs_pow(%rip)	# N_i_abs_pow_lsm.960, N_i_abs_pow
.L284:
# simulation.h:204: }
	popq	%rbx	#
	.cfi_def_cfa_offset 40
	popq	%rbp	#
	.cfi_def_cfa_offset 32
	popq	%r12	#
	.cfi_def_cfa_offset 24
	popq	%r13	#
	.cfi_def_cfa_offset 16
	popq	%r14	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4
	.p2align 3
.L286:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	ret	
	.cfi_endproc
.LFE3869:
	.size	_Z27step6_check_boundaries_ionsi, .-_Z27step6_check_boundaries_ionsi


