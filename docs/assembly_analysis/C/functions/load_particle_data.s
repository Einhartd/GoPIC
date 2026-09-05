# Function: load_particle_data()
# Mangled Symbol: _Z18load_particle_datav
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._Z18load_particle_datav,"axG",@progbits,_Z18load_particle_datav,comdat
	.p2align 4
	.weak	_Z18load_particle_datav
	.type	_Z18load_particle_datav, @function
_Z18load_particle_datav:
.LFB9921:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx	#
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
# C/parallel-only-omp/io_manager.h:49:     f = fopen(fname,"rb");
	leaq	.LC71(%rip), %rsi	#, tmp111
# C/parallel-only-omp/io_manager.h:43: inline void load_particle_data(){
	subq	$120, %rsp	#,
	.cfi_def_cfa_offset 144
# C/parallel-only-omp/io_manager.h:43: inline void load_particle_data(){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp151
	movq	%rax, 104(%rsp)	# tmp151, D.132255
	xorl	%eax, %eax	# tmp151
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movl	$7235938, 24(%rsp)	#, MEM <char[1:12]> [(void *)&fname]
	movabsq	$3342080360130505072, %rax	#, tmp154
	leaq	16(%rsp), %rdi	#, tmp108
	movq	%rax, 16(%rsp)	# tmp154, MEM <char[1:12]> [(void *)&fname]
# C/parallel-only-omp/io_manager.h:49:     f = fopen(fname,"rb");
	call	fopen@PLT	#
# C/parallel-only-omp/io_manager.h:50:     if (f==NULL) {printf(">> eduPIC: ERROR: No particle data file found, try running initial cycle using argument '0'\n"); exit(0); }
	testq	%rax, %rax	# tmp112
	je	.L220	#,
	movq	%rax, %rbx	# tmp150, tmp112
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:212:     return __fread_alias (__ptr, __size, __n, __stream);
	leaq	8(%rsp), %rbp	#, tmp115
	movq	%rax, %rcx	# tmp112,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	leaq	Time(%rip), %rdi	#, tmp114
	call	fread@PLT	#
	movq	%rbx, %rcx	# tmp112,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	movq	%rbp, %rdi	# tmp115,
	call	fread@PLT	#
	movq	%rbx, %rcx	# tmp112,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	movq	%rbp, %rdi	# tmp115,
# C/parallel-only-omp/io_manager.h:53:     cycles_done = int(d);
	vcvttsd2sil	8(%rsp), %eax	# d, tmp117
	movl	%eax, cycles_done(%rip)	# tmp117, cycles_done
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:212:     return __fread_alias (__ptr, __size, __n, __stream);
	call	fread@PLT	#
# C/parallel-only-omp/io_manager.h:55:     N_e = int(d);
	vcvttsd2sil	8(%rsp), %ecx	# d, _4
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	x_e(%rip), %rdi	#, tmp121
# C/parallel-only-omp/io_manager.h:55:     N_e = int(d);
	movl	%ecx, N_e(%rip)	# _4, N_e
# C/parallel-only-omp/io_manager.h:56:     fread(x_e, sizeof(double),N_e,f);
	movslq	%ecx, %rcx	# _4, _4
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	call	__fread_chk@PLT	#
# C/parallel-only-omp/io_manager.h:57:     fread(vx_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rcx	# N_e, N_e
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vx_e(%rip), %rdi	#, tmp124
	call	__fread_chk@PLT	#
# C/parallel-only-omp/io_manager.h:58:     fread(vy_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rcx	# N_e, N_e
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vy_e(%rip), %rdi	#, tmp127
	call	__fread_chk@PLT	#
# C/parallel-only-omp/io_manager.h:59:     fread(vz_e,sizeof(double),N_e,f);
	movslq	N_e(%rip), %rcx	# N_e, N_e
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vz_e(%rip), %rdi	#, tmp130
	call	__fread_chk@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:212:     return __fread_alias (__ptr, __size, __n, __stream);
	movq	%rbx, %rcx	# tmp112,
	movl	$1, %edx	#,
	movl	$8, %esi	#,
	movq	%rbp, %rdi	# tmp115,
	call	fread@PLT	#
# C/parallel-only-omp/io_manager.h:61:     N_i = int(d);
	vcvttsd2sil	8(%rsp), %ecx	# d, _13
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	x_i(%rip), %rdi	#, tmp134
# C/parallel-only-omp/io_manager.h:61:     N_i = int(d);
	movl	%ecx, N_i(%rip)	# _13, N_i
# C/parallel-only-omp/io_manager.h:62:     fread(x_i, sizeof(double),N_i,f);
	movslq	%ecx, %rcx	# _13, _13
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	call	__fread_chk@PLT	#
# C/parallel-only-omp/io_manager.h:63:     fread(vx_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rcx	# N_i, N_i
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vx_i(%rip), %rdi	#, tmp137
	call	__fread_chk@PLT	#
# C/parallel-only-omp/io_manager.h:64:     fread(vy_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rcx	# N_i, N_i
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vy_i(%rip), %rdi	#, tmp140
	call	__fread_chk@PLT	#
# C/parallel-only-omp/io_manager.h:65:     fread(vz_i,sizeof(double),N_i,f);
	movslq	N_i(%rip), %rcx	# N_i, N_i
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:215:   return __fread_chk (__ptr, sz, __size, __n, __stream);
	movq	%rbx, %r8	# tmp112,
	movl	$8, %edx	#,
	movl	$8000000, %esi	#,
	leaq	vz_i(%rip), %rdi	#, tmp143
	call	__fread_chk@PLT	#
# C/parallel-only-omp/io_manager.h:66:     fclose(f);
	movq	%rbx, %rdi	# tmp112,
	call	fclose@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	cycles_done(%rip), %r8d	# cycles_done,
	movl	N_i(%rip), %ecx	# N_i,
	leaq	.LC73(%rip), %rsi	#, tmp148
	movl	N_e(%rip), %edx	# N_e,
	movl	$2, %edi	#,
	movl	$1, %eax	#,
	vmovsd	Time(%rip), %xmm0	# Time,
	call	__printf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:68: }
	movq	104(%rsp), %rax	# D.132255, tmp152
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp152
	jne	.L221	#,
	addq	$120, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx	#
	.cfi_def_cfa_offset 16
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
.L220:
	.cfi_restore_state
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$2, %edi	#,
	leaq	.LC72(%rip), %rsi	#, tmp113
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# C/parallel-only-omp/io_manager.h:50:     if (f==NULL) {printf(">> eduPIC: ERROR: No particle data file found, try running initial cycle using argument '0'\n"); exit(0); }
	xorl	%edi, %edi	#
	call	exit@PLT	#
.L221:
# C/parallel-only-omp/io_manager.h:68: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE9921:
	.size	_Z18load_particle_datav, .-_Z18load_particle_datav
	.section	.rodata._Z19check_and_save_infov.str1.1,"aMS",@progbits,1
.LC77:
	.string	"w"
.LC78:
	.string	"info.txt"
	.section	.rodata._Z19check_and_save_infov.str1.8,"aMS",@progbits,1
	.align 8
.LC79:
	.string	"########################## eduPIC simulation report ############################\n"
	.section	.rodata._Z19check_and_save_infov.str1.1
.LC80:
	.string	"Simulation parameters:\n"
	.section	.rodata._Z19check_and_save_infov.str1.8
	.align 8
.LC82:
	.string	"Gap distance                          = %12.3e [m]\n"
	.align 8
.LC83:
	.string	"# of grid divisions                   = %12d\n"
	.align 8
.LC84:
	.string	"Frequency                             = %12.3e [Hz]\n"
	.align 8
.LC85:
	.string	"# of time steps / period              = %12d\n"
	.align 8
.LC86:
	.string	"# of electron / ion time steps        = %12d\n"
	.align 8
.LC88:
	.string	"Voltage amplitude                     = %12.3e [V]\n"
	.align 8
.LC89:
	.string	"Pressure (Ar)                         = %12.3e [Pa]\n"
	.align 8
.LC91:
	.string	"Temperature                           = %12.3e [K]\n"
	.align 8
.LC93:
	.string	"Superparticle weight                  = %12.3e\n"
	.align 8
.LC94:
	.string	"# of simulation cycles in this run    = %12d\n"
	.align 8
.LC95:
	.string	"--------------------------------------------------------------------------------\n"
	.section	.rodata._Z19check_and_save_infov.str1.1
.LC96:
	.string	"Plasma characteristics:\n"
	.section	.rodata._Z19check_and_save_infov.str1.8
	.align 8
.LC97:
	.string	"Electron density @ center             = %12.3e [m^{-3}]\n"
	.align 8
.LC98:
	.string	"Plasma frequency @ center             = %12.3e [rad/s]\n"
	.align 8
.LC99:
	.string	"Debye length @ center                 = %12.3e [m]\n"
	.align 8
.LC100:
	.string	"Electron collision frequency          = %12.3e [1/s]\n"
	.align 8
.LC101:
	.string	"Ion collision frequency               = %12.3e [1/s]\n"
	.align 8
.LC102:
	.string	"Stability and accuracy conditions:\n"
	.align 8
.LC103:
	.string	"Plasma frequency @ center * DT_E      = %12.3f (OK if less than 0.20)\n"
	.align 8
.LC105:
	.string	"DX / Debye length @ center            = %12.3f (OK if less than 1.00)\n"
	.align 8
.LC107:
	.string	"Max. electron coll. frequency * DT_E  = %12.3f (OK if less than 0.05)\n"
	.align 8
.LC108:
	.string	"Max. ion coll. frequency * DT_I       = %12.3f (OK if less than 0.05)\n"
	.align 8
.LC109:
	.string	"** STABILITY AND ACCURACY CONDITION(S) VIOLATED - REFINE SIMULATION SETTINGS! **\n"
	.align 8
.LC110:
	.string	">> eduPIC: ERROR: STABILITY AND ACCURACY CONDITION(S) VIOLATED!\n"
	.align 8
.LC111:
	.string	">> eduPIC: for details see 'info.txt' and refine simulation settings!\n"
	.align 8
.LC113:
	.string	"Max e- energy for CFL condition       = %12.3f [eV]\n"
	.align 8
.LC114:
	.string	"Check EEPF to ensure that CFL is fulfilled for the majority of the electrons!\n"
	.align 8
.LC115:
	.string	">> eduPIC: saving diagnostics data\n"
	.section	.rodata._Z19check_and_save_infov.str1.1
.LC116:
	.string	"density.dat"
.LC117:
	.string	"%8.5f  %12e  %12e\n"
.LC118:
	.string	"eepf.dat"
.LC119:
	.string	"%e  %e\n"
.LC120:
	.string	"ifed.dat"
.LC121:
	.string	"%6.2f %10.6f %10.6f\n"
.LC128:
	.string	"%e  "
.LC129:
	.string	"\n"
	.section	.rodata._Z19check_and_save_infov.str1.8
	.align 8
.LC130:
	.string	"Particle characteristics at the electrodes:\n"
	.align 8
.LC133:
	.string	"Ion flux at powered electrode         = %12.3e [m^{-2} s^{-1}]\n"
	.align 8
.LC134:
	.string	"Ion flux at grounded electrode        = %12.3e [m^{-2} s^{-1}]\n"
	.align 8
.LC135:
	.string	"Mean ion energy at powered electrode  = %12.3e [eV]\n"
	.align 8
.LC136:
	.string	"Mean ion energy at grounded electrode = %12.3e [eV]\n"
	.align 8
.LC137:
	.string	"Electron flux at powered electrode    = %12.3e [m^{-2} s^{-1}]\n"
	.align 8
.LC138:
	.string	"Electron flux at grounded electrode   = %12.3e [m^{-2} s^{-1}]\n"
	.align 8
.LC140:
	.string	"Absorbed power calculated as <j*E>:\n"
	.align 8
.LC141:
	.string	"Electron power density (average)      = %12.3e [W m^{-3}]\n"
	.align 8
.LC142:
	.string	"Ion power density (average)           = %12.3e [W m^{-3}]\n"
	.align 8
.LC143:
	.string	"Total power density(average)          = %12.3e [W m^{-3}]\n"
	