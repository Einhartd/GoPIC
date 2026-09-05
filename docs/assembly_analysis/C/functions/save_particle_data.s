# Function: save_particle_data()
# Mangled Symbol: _Z18save_particle_datav
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._Z18save_particle_datav,"axG",@progbits,_Z18save_particle_datav,comdat
	.p2align 4
	.weak	_Z18save_particle_datav
	.type	_Z18save_particle_datav, @function
_Z18save_particle_datav:
.LFB9920:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
# C/parallel-only-omp/io_manager.h:19:     f = fopen(fname,"wb");
	leaq	.LC69(%rip), %rsi	#, tmp113
# C/parallel-only-omp/io_manager.h:13: inline void save_particle_data(){
	subq	$120, %rsp	#,
	.cfi_def_cfa_offset 144
# C/parallel-only-omp/io_manager.h:13: inline void save_particle_data(){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp157
	movq	%rax, 104(%rsp)	# tmp157, D.132246
	xorl	%eax, %eax	# tmp157
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movl	$7235938, 24(%rsp)	#, MEM <char[1:12]> [(void *)&fname]
	leaq	16(%rsp), %rdi	#, tmp110
	movabsq	$3342080360130505072, %rax	#, tmp160
# C/parallel-only-omp/io_manager.h:22:     fwrite(&d,sizeof(double),1,f);
	leaq	8(%rsp), %rbp	#, tmp117
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, 16(%rsp)	# tmp160, MEM <char[1:12]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:19:     f = fopen(fname,"wb");
	call	fopen@PLT	#
# C/parallel-only-omp/io_manager.h:20:     fwrite(&Time,sizeof(double),1,f);
	movl	$1, %edx	#,
	movl	$8, %esi	#,
# C/parallel-only-omp/io_manager.h:19:     f = fopen(fname,"wb");
	movq	%rax, %rbx	# tmp152, tmp114
# C/parallel-only-omp/io_manager.h:20:     fwrite(&Time,sizeof(double),1,f);
	movq	%rax, %rcx	# tmp114,
	leaq	Time(%rip), %rdi	#, tmp115
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:22:     fwrite(&d,sizeof(double),1,f);
	movq	%rbx, %rcx	# tmp114,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	movq	%rbp, %rdi	# tmp117,
# C/parallel-only-omp/io_manager.h:21:     d = (double)(cycles_done);
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp161
	vcvtsi2sdl	cycles_done(%rip), %xmm1, %xmm0	# cycles_done, tmp161, tmp154
	vmovsd	%xmm0, 8(%rsp)	# tmp116, d
# C/parallel-only-omp/io_manager.h:22:     fwrite(&d,sizeof(double),1,f);
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:24:     fwrite(&d,sizeof(double),1,f);
	movq	%rbx, %rcx	# tmp114,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	movq	%rbp, %rdi	# tmp117,
# C/parallel-only-omp/io_manager.h:23:     d = (double)(N_e);
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp162
	vcvtsi2sdl	N_e(%rip), %xmm1, %xmm0	# N_e, tmp162, tmp155
	vmovsd	%xmm0, 8(%rsp)	# tmp118, d
# C/parallel-only-omp/io_manager.h:24:     fwrite(&d,sizeof(double),1,f);
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:25:     fwrite(x_e, sizeof(double),N_e,f);
	movslq	N_e(%rip), %rdx	# N_e, N_e
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	x_e(%rip), %rdi	#, tmp122
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:26:     fwrite(vx_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rdx	# N_e, N_e
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vx_e(%rip), %rdi	#, tmp125
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:27:     fwrite(vy_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rdx	# N_e, N_e
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vy_e(%rip), %rdi	#, tmp128
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:28:     fwrite(vz_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rdx	# N_e, N_e
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vz_e(%rip), %rdi	#, tmp131
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:30:     fwrite(&d,sizeof(double),1,f);
	movq	%rbx, %rcx	# tmp114,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	movq	%rbp, %rdi	# tmp117,
# C/parallel-only-omp/io_manager.h:29:     d = (double)(N_i);
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp163
	vcvtsi2sdl	N_i(%rip), %xmm1, %xmm0	# N_i, tmp163, tmp156
	vmovsd	%xmm0, 8(%rsp)	# tmp132, d
# C/parallel-only-omp/io_manager.h:30:     fwrite(&d,sizeof(double),1,f);
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:31:     fwrite(x_i, sizeof(double),N_i,f);
	movslq	N_i(%rip), %rdx	# N_i, N_i
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	x_i(%rip), %rdi	#, tmp136
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:32:     fwrite(vx_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rdx	# N_i, N_i
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vx_i(%rip), %rdi	#, tmp139
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:33:     fwrite(vy_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rdx	# N_i, N_i
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vy_i(%rip), %rdi	#, tmp142
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:34:     fwrite(vz_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rdx	# N_i, N_i
	movq	%rbx, %rcx	# tmp114,
	movl	$8, %esi	#,
	leaq	vz_i(%rip), %rdi	#, tmp145
	call	fwrite@PLT	#
# C/parallel-only-omp/io_manager.h:35:     fclose(f);
	movq	%rbx, %rdi	# tmp114,
	call	fclose@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	cycles_done(%rip), %r8d	# cycles_done,
	movl	N_i(%rip), %ecx	# N_i,
	leaq	.LC70(%rip), %rsi	#, tmp150
	movl	N_e(%rip), %edx	# N_e,
	movl	$2, %edi	#,
	movl	$1, %eax	#,
	vmovsd	Time(%rip), %xmm0	# Time,
	call	__printf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:37: }
	movq	104(%rsp), %rax	# D.132246, tmp158
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp158
	jne	.L214	#,
	addq	$120, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
.L214:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE9920:
	.size	_Z18save_particle_datav, .-_Z18save_particle_datav
	.section	.rodata._Z18load_particle_datav.str1.1,"aMS",@progbits,1
.LC71:
	.string	"rb"
	.section	.rodata._Z18load_particle_datav.str1.8,"aMS",@progbits,1
	.align 8
.LC72:
	.string	">> eduPIC: ERROR: No particle data file found, try running initial cycle using argument '0'\n"
	.align 8
.LC73:
	.string	">> eduPIC: data loaded : %d electrons %d ions, %d cycles completed before, time is %e [s]\n"
	