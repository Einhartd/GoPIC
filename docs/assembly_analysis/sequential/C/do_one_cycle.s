# --- Symbol: _Z12do_one_cyclev ---
	.section	.text._Z12do_one_cyclev,"axG",@progbits,_Z12do_one_cyclev,comdat
	.p2align 4
	.weak	_Z12do_one_cyclev
	.type	_Z12do_one_cyclev, @function
_Z12do_one_cyclev:
.LFB3873:
	.cfi_startproc
	endbr64	
	pushq	%r13	#
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12	#
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp	#
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
# simulation.h:327:         t_index = t / N_BIN;        // index for XT distributions        
	movl	$3435973837, %r12d	#, tmp99
# simulation.h:321: inline void do_one_cycle (void){
	pushq	%rbx	#
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC190(%rip), %r13	#, tmp126
# simulation.h:325:     for (t=0; t<N_T; t++){          // the RF period is divided into N_T equal time intervals (time step DT_E)
	xorl	%ebx, %ebx	# t
# simulation.h:321: inline void do_one_cycle (void){
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 48
	jmp	.L798	#
	.p2align 4
	.p2align 3
.L797:
# simulation.h:325:     for (t=0; t<N_T; t++){          // the RF period is divided into N_T equal time intervals (time step DT_E)
	incl	%ebx	# t
# simulation.h:325:     for (t=0; t<N_T; t++){          // the RF period is divided into N_T equal time intervals (time step DT_E)
	cmpl	$4000, %ebx	#, t
	je	.L801	#,
.L798:
# simulation.h:327:         t_index = t / N_BIN;        // index for XT distributions        
	movl	%ebx, %ebp	# t, t
# simulation.h:326:         Time += DT_E;               // update of the total simulated time
	vmovsd	.LC69(%rip), %xmm1	#, tmp128
	vaddsd	Time(%rip), %xmm1, %xmm0	# Time, tmp128, tmp94
	vmovsd	%xmm0, Time(%rip)	# tmp94, Time
# simulation.h:327:         t_index = t / N_BIN;        // index for XT distributions        
	imulq	%r12, %rbp	# tmp99, tmp98
# simulation.h:329:         step1_compute_electron_density();
	call	_Z30step1_compute_electron_densityv	#
# simulation.h:330:         step1_compute_ion_density(t);
	movl	%ebx, %edi	# t,
	call	_Z25step1_compute_ion_densityi	#
# simulation.h:331:         step2_solve_poisson(Time);
	call	_Z19step2_solve_poissond.isra.0	#
# simulation.h:327:         t_index = t / N_BIN;        // index for XT distributions        
	shrq	$36, %rbp	#, t_index
# simulation.h:333:         step3_move_electrons(t_index);
	movl	%ebp, %edi	# t_index,
	call	_Z20step3_move_electronsi	#
# simulation.h:334:         step4_move_ions(t_index, t);
	movl	%ebx, %esi	# t,
	movl	%ebp, %edi	# t_index,
	call	_Z15step4_move_ionsii	#
# simulation.h:336:         step5_check_boundaries_electrons();
	call	_Z32step5_check_boundaries_electronsv	#
# simulation.h:337:         step6_check_boundaries_ions(t);
	movl	%ebx, %edi	# t,
	call	_Z27step6_check_boundaries_ionsi	#
# simulation.h:339:         step7_collisions_electrons();
	call	_Z26step7_collisions_electronsv	#
# simulation.h:340:         step8_collision_ions(t);
	movl	%ebx, %edi	# t,
	call	_Z20step8_collision_ionsi	#
# simulation.h:342:         step9_collect_xt_data(t_index);
	movl	%ebp, %edi	# t_index,
	call	_Z21step9_collect_xt_datai	#
	imull	$652835029, %ebx, %eax	#, t, tmp114
	rorx	$3, %eax, %eax	#, tmp114, tmp115
# simulation.h:344:         if ((t % 1000) == 0){
	cmpl	$4294967, %eax	#, tmp115
	ja	.L797	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	N_i(%rip), %r9d	# N_i,
	movl	N_e(%rip), %r8d	# N_e,
	movl	cycle(%rip), %edx	# cycle,
	movl	%ebx, %ecx	# t,
	movq	%r13, %rsi	# tmp126,
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
# simulation.h:325:     for (t=0; t<N_T; t++){          // the RF period is divided into N_T equal time intervals (time step DT_E)
	incl	%ebx	# t
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	__printf_chk@PLT	#
# simulation.h:325:     for (t=0; t<N_T; t++){          // the RF period is divided into N_T equal time intervals (time step DT_E)
	cmpl	$4000, %ebx	#, t
	jne	.L798	#,
.L801:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movl	N_i(%rip), %r9d	# N_i,
	movl	N_e(%rip), %r8d	# N_e,
	movl	cycle(%rip), %ecx	# cycle,
	leaq	.LC191(%rip), %rdx	#, tmp124
	movq	datafile(%rip), %rdi	# datafile,
# simulation.h:349: }
	addq	$8, %rsp	#,
	.cfi_def_cfa_offset 40
	popq	%rbx	#
	.cfi_def_cfa_offset 32
	popq	%rbp	#
	.cfi_def_cfa_offset 24
	popq	%r12	#
	.cfi_def_cfa_offset 16
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movl	$2, %esi	#,
# simulation.h:349: }
	popq	%r13	#
	.cfi_def_cfa_offset 8
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	xorl	%eax, %eax	#
	jmp	__fprintf_chk@PLT	#
	.cfi_endproc
.LFE3873:
	.size	_Z12do_one_cyclev, .-_Z12do_one_cyclev


