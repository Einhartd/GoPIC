# Function: startup.main
# Mangled Symbol: startup.main
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text.startup.main,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB9929:
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
	movq	%rsi, %rbp	# tmp527, argv
	subq	$56, %rsp	#,
	.cfi_def_cfa_offset 112
# C/parallel-only-omp/eduPIC.cc:21: int main (int argc, char *argv[]){
	movl	%edi, %ebx	# tmp526, argc
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC180(%rip), %rsi	#, tmp274
	movl	$2, %edi	#,
# C/parallel-only-omp/eduPIC.cc:21: int main (int argc, char *argv[]){
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp549
	movq	%rax, 40(%rsp)	# tmp549, D.134265
	xorl	%eax, %eax	# tmp549
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	__printf_chk@PLT	#
# C/parallel-only-omp/eduPIC.cc:25:     if (argc == 1) {
	cmpl	$1, %ebx	#, argc
	je	.L1079	#,
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	8(%rbp), %rsi	# MEM[(char * *)argv_29(D) + 8B], MEM[(char * *)argv_29(D) + 8B]
	movl	$80, %edx	#,
	leaq	st0(%rip), %rdi	#, tmp277
	call	__strcpy_chk@PLT	#
# /usr/include/stdlib.h:488:   return strtol (__nptr, (char **) NULL, 10);
	movl	$10, %edx	#,
	xorl	%esi, %esi	#
# /usr/include/x86_64-linux-gnu/bits/string_fortified.h:79:   return __builtin___strcpy_chk (__dest, __src, __glibc_objsize (__dest));
	movq	%rax, %rdi	#, tmp277
# /usr/include/stdlib.h:488:   return strtol (__nptr, (char **) NULL, 10);
	call	__isoc23_strtol@PLT	#
# C/parallel-only-omp/eduPIC.cc:30:         arg1 = atol(st0);
	movl	%eax, arg1(%rip)	# tmp528, arg1
# C/parallel-only-omp/eduPIC.cc:31:         if (argc > 2) {
	cmpl	$2, %ebx	#, argc
	jle	.L1015	#,
# C/parallel-only-omp/eduPIC.cc:32:             if (strcmp (argv[2],"m") == 0){
	movq	16(%rbp), %rdi	# MEM[(char * *)argv_29(D) + 16B], MEM[(char * *)argv_29(D) + 16B]
	leaq	.LC182(%rip), %rsi	#, tmp282
	call	strcmp@PLT	#
# C/parallel-only-omp/eduPIC.cc:32:             if (strcmp (argv[2],"m") == 0){
	testl	%eax, %eax	# tmp529
	jne	.L1016	#,
# C/parallel-only-omp/eduPIC.cc:34:                 measurement_mode = true;
	movb	$1, measurement_mode(%rip)	#, measurement_mode
.L1017:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC183(%rip), %rsi	#, tmp283
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	jmp	.L1019	#
.L1015:
# C/parallel-only-omp/eduPIC.cc:40:     if (measurement_mode) {
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	jne	.L1017	#,
.L1018:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC184(%rip), %rsi	#, tmp284
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
.L1019:
# C/parallel-only-omp/eduPIC.cc:47:     set_electron_cross_sections_ar();
	call	_Z30set_electron_cross_sections_arv	#
# C/parallel-only-omp/eduPIC.cc:48:     set_ion_cross_sections_ar();
	call	_Z25set_ion_cross_sections_arv	#
# C/parallel-only-omp/eduPIC.cc:49:     calc_total_cross_sections();
	call	_Z25calc_total_cross_sectionsv	#
# C/parallel-only-omp/eduPIC.cc:51:     compute_null_collision_params();
	call	_Z29compute_null_collision_paramsv	#
# C/parallel-only-omp/poisson.h:19:     inv_denom_thomas[1] = 1.0 / B;
	movl	$16, %eax	#, ivtmp.2303
	leaq	inv_denom_thomas(%rip), %rcx	#, tmp507
	leaq	w_thomas(%rip), %rdx	#, tmp505
# C/parallel-only-omp/poisson.h:18:     w_thomas[1] = C / B;
	vmovsd	.LC41(%rip), %xmm0	#, tmp286
	vmovsd	.LC171(%rip), %xmm2	#, tmp504
	vmovsd	%xmm0, 8+w_thomas(%rip)	# tmp286, w_thomas[1]
# C/parallel-only-omp/poisson.h:19:     inv_denom_thomas[1] = 1.0 / B;
	vmovsd	%xmm0, 8+inv_denom_thomas(%rip)	# tmp286, inv_denom_thomas[1]
	vmovsd	.LC10(%rip), %xmm1	#, tmp503
	.p2align 4
	.p2align 3
.L1020:
# C/parallel-only-omp/poisson.h:21:         double denom = B - A * w_thomas[i - 1];
	vsubsd	%xmm0, %xmm2, %xmm0	# w_thomas_I_lsm0.2278, tmp504, denom
# C/parallel-only-omp/poisson.h:22:         inv_denom_thomas[i] = 1.0 / denom;
	vdivsd	%xmm0, %xmm1, %xmm0	# denom, tmp503, w_thomas_I_lsm0.2278
# C/parallel-only-omp/poisson.h:22:         inv_denom_thomas[i] = 1.0 / denom;
	vmovsd	%xmm0, (%rcx,%rax)	# w_thomas_I_lsm0.2278, MEM[(double *)&inv_denom_thomas + ivtmp.2303_1353 * 1]
# C/parallel-only-omp/poisson.h:23:         w_thomas[i] = C * inv_denom_thomas[i];
	vmovsd	%xmm0, (%rdx,%rax)	# w_thomas_I_lsm0.2278, MEM[(double *)&w_thomas + ivtmp.2303_1353 * 1]
# C/parallel-only-omp/poisson.h:20:     for (int i = 2; i <= N_G - 2; i++) {
	addq	$8, %rax	#, ivtmp.2303
	cmpq	$3192, %rax	#, ivtmp.2303
	jne	.L1020	#,
# C/parallel-only-omp/eduPIC.cc:58:     datafile = fopen("conv.dat","a");
	leaq	.LC185(%rip), %rsi	#, tmp294
	leaq	.LC186(%rip), %rdi	#, tmp295
	call	fopen@PLT	#
# C/parallel-only-omp/eduPIC.cc:58:     datafile = fopen("conv.dat","a");
	movq	%rax, datafile(%rip)	# tmp530, datafile
# C/parallel-only-omp/eduPIC.cc:60:     if (arg1 == 0) {
	movl	arg1(%rip), %eax	# arg1, arg1.1_6
# C/parallel-only-omp/eduPIC.cc:60:     if (arg1 == 0) {
	testl	%eax, %eax	# arg1.1_6
	jne	.L1021	#,
# C/parallel-only-omp/eduPIC.cc:62:         if (FILE *file = fopen("picdata.bin", "r")) { fclose(file);
	leaq	.LC188(%rip), %rdi	#, tmp298
	leaq	.LC187(%rip), %rsi	#, tmp297
	call	fopen@PLT	#
	movq	%rax, %rdi	# tmp531, tmp299
# C/parallel-only-omp/eduPIC.cc:62:         if (FILE *file = fopen("picdata.bin", "r")) { fclose(file);
	testq	%rax, %rax	# tmp299
	je	.L1022	#,
# C/parallel-only-omp/eduPIC.cc:62:         if (FILE *file = fopen("picdata.bin", "r")) { fclose(file);
	call	fclose@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC189(%rip), %rsi	#, tmp300
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
	leaq	.LC190(%rip), %rsi	#, tmp301
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
	movl	$2, %edi	#,
	leaq	.LC191(%rip), %rsi	#, tmp302
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# C/parallel-only-omp/eduPIC.cc:66:             exit(0);
	xorl	%edi, %edi	#
	call	exit@PLT	#
.L1021:
# C/parallel-only-omp/eduPIC.cc:79:         no_of_cycles = arg1;
	movl	%eax, no_of_cycles(%rip)	# arg1.1_6, no_of_cycles
# C/parallel-only-omp/eduPIC.cc:80:         load_particle_data();
	call	_Z18load_particle_datav	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	no_of_cycles(%rip), %edx	# no_of_cycles,
	leaq	.LC193(%rip), %rsi	#, tmp306
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# C/parallel-only-omp/eduPIC.cc:82:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
	movl	cycles_done(%rip), %edx	# cycles_done, cycles_done.4_9
	leal	1(%rdx), %eax	#, tmp307
	movl	%eax, cycle(%rip)	# tmp307, cycle
# C/parallel-only-omp/eduPIC.cc:82:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
	movl	no_of_cycles(%rip), %eax	# no_of_cycles, no_of_cycles.7_93
# C/parallel-only-omp/eduPIC.cc:82:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
	testl	%eax, %eax	# no_of_cycles.7_93
	jle	.L1024	#,
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %r12	#, tmp523
.L1068:
# C/parallel-only-omp/simulation.h:874:     int num_threads = omp_get_max_threads();
	call	omp_get_max_threads@PLT	#
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	8+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers].D.102928._M_impl.D.102267._M_finish, _88
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$5675921253449092805, %rsi	#, tmp564
# C/parallel-only-omp/simulation.h:874:     int num_threads = omp_get_max_threads();
	movl	%eax, %r13d	# tmp532, num_threads
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	leaq	worker_buffers(%rip), %rax	#, tmp562
	movq	(%rax), %rdx	# MEM[(const struct vector *)&worker_buffers].D.102928._M_impl.D.102267._M_start, _89
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _88, tmp310
	subq	%rdx, %rax	# _89, tmp310
	sarq	$8, %rax	#, tmp311
	imulq	%rsi, %rax	# tmp564, tmp312
# C/parallel-only-omp/state.h:216:         if ((int)e_density.size() >= num_threads) return;
	cmpl	%eax, %r13d	# tmp312, num_threads
	jle	.L1025	#,
# C/parallel-only-omp/state.h:218:         e_density.resize(num_threads);
	movslq	%r13d, %rbx	# num_threads, _94
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp312
	jb	.L1080	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp312, _94
	jnb	.L1027	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3328, %rbx, %rax	#, _94, tmp316
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp316, _243
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _243, _88
	je	.L1027	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 8+worker_buffers(%rip)	# _243, MEM[(struct vector *)&worker_buffers].D.102928._M_impl.D.102267._M_finish
	.p2align 4
	.p2align 3
.L1027:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	32+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 24B].D.102928._M_impl.D.102267._M_finish, _228
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	24+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 24B].D.102928._M_impl.D.102267._M_start, _229
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$5675921253449092805, %rdi	#, tmp567
	movq	%rcx, %rax	# _228, tmp320
	subq	%rdx, %rax	# _229, tmp320
	sarq	$8, %rax	#, tmp321
	imulq	%rdi, %rax	# tmp567, tmp322
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp322
	jb	.L1081	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp322, _94
	jnb	.L1029	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3328, %rbx, %rax	#, _94, tmp326
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp326, _235
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _235, _228
	je	.L1029	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 32+worker_buffers(%rip)	# _235, MEM[(struct vector *)&worker_buffers + 24B].D.102928._M_impl.D.102267._M_finish
	.p2align 4
	.p2align 3
.L1029:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	56+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 48B].D.103980._M_impl.D.103319._M_finish, _220
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	48+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 48B].D.103980._M_impl.D.103319._M_start, _221
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _220, tmp330
	subq	%rdx, %rax	# _221, tmp330
	sarq	$7, %rax	#, tmp331
	imulq	%r12, %rax	# tmp523, tmp332
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp332
	jb	.L1082	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp332, _94
	jnb	.L1031	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbx, %rax	#, _94, tmp336
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp336, _227
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _227, _220
	je	.L1031	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 56+worker_buffers(%rip)	# _227, MEM[(struct vector *)&worker_buffers + 48B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L1031:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	80+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 72B].D.103980._M_impl.D.103319._M_finish, _212
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	72+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 72B].D.103980._M_impl.D.103319._M_start, _213
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _212, tmp340
	subq	%rdx, %rax	# _213, tmp340
	sarq	$7, %rax	#, tmp341
	imulq	%r12, %rax	# tmp523, tmp342
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp342
	jb	.L1083	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp342, _94
	jnb	.L1033	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbx, %rax	#, _94, tmp346
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp346, _219
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _219, _212
	je	.L1033	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 80+worker_buffers(%rip)	# _219, MEM[(struct vector *)&worker_buffers + 72B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L1033:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	104+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 96B].D.103980._M_impl.D.103319._M_finish, _204
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	96+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 96B].D.103980._M_impl.D.103319._M_start, _205
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _204, tmp350
	subq	%rdx, %rax	# _205, tmp350
	sarq	$7, %rax	#, tmp351
	imulq	%r12, %rax	# tmp523, tmp352
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp352
	jb	.L1084	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp352, _94
	jnb	.L1035	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbx, %rax	#, _94, tmp356
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp356, _211
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _211, _204
	je	.L1035	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 104+worker_buffers(%rip)	# _211, MEM[(struct vector *)&worker_buffers + 96B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L1035:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	128+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 120B].D.103980._M_impl.D.103319._M_finish, _196
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	120+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 120B].D.103980._M_impl.D.103319._M_start, _197
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _196, tmp360
	subq	%rdx, %rax	# _197, tmp360
	sarq	$7, %rax	#, tmp361
	imulq	%r12, %rax	# tmp523, tmp362
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp362
	jb	.L1085	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp362, _94
	jnb	.L1037	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbx, %rax	#, _94, tmp366
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp366, _203
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _203, _196
	je	.L1037	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 128+worker_buffers(%rip)	# _203, MEM[(struct vector *)&worker_buffers + 120B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L1037:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	152+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 144B].D.105034._M_impl.D.104373._M_finish, _188
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	144+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 144B].D.105034._M_impl.D.104373._M_start, _189
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$2066035336255469781, %rdi	#, tmp578
	movq	%rcx, %rax	# _188, tmp370
	subq	%rdx, %rax	# _189, tmp370
	sarq	$7, %rax	#, tmp371
	imulq	%rdi, %rax	# tmp578, tmp372
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp372
	jb	.L1086	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp372, _94
	jnb	.L1039	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$16000, %rbx, %rax	#, _94, tmp376
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp376, _195
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _195, _188
	je	.L1039	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 152+worker_buffers(%rip)	# _195, MEM[(struct vector *)&worker_buffers + 144B].D.105034._M_impl.D.104373._M_finish
	.p2align 4
	.p2align 3
.L1039:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	176+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_finish, _180
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	168+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_start, _181
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _180, tmp380
	subq	%rdx, %rax	# _181, tmp380
	sarq	$6, %rax	#, tmp381
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp381
	jb	.L1087	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp381, _94
	jnb	.L1041	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	movq	%rbx, %rax	# _94, tmp384
	salq	$6, %rax	#, tmp384
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp384, _187
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _187, _180
	je	.L1041	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 176+worker_buffers(%rip)	# _187, MEM[(struct vector *)&worker_buffers + 168B].D.106084._M_impl.D.105423._M_finish
	.p2align 4
	.p2align 3
.L1041:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	200+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 192B].D.103980._M_impl.D.103319._M_finish, _172
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	192+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 192B].D.103980._M_impl.D.103319._M_start, _173
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _172, tmp388
	subq	%rdx, %rax	# _173, tmp388
	sarq	$7, %rax	#, tmp389
	imulq	%r12, %rax	# tmp523, tmp390
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp390
	jb	.L1088	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp390, _94
	jnb	.L1043	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbx, %rax	#, _94, tmp394
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp394, _179
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _179, _172
	je	.L1043	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 200+worker_buffers(%rip)	# _179, MEM[(struct vector *)&worker_buffers + 192B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L1043:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	224+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 216B].D.103980._M_impl.D.103319._M_finish, _164
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	216+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 216B].D.103980._M_impl.D.103319._M_start, _165
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _164, tmp398
	subq	%rdx, %rax	# _165, tmp398
	sarq	$7, %rax	#, tmp399
	imulq	%r12, %rax	# tmp523, tmp400
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp400
	jb	.L1089	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp400, _94
	jnb	.L1045	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbx, %rax	#, _94, tmp404
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp404, _171
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _171, _164
	je	.L1045	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 224+worker_buffers(%rip)	# _171, MEM[(struct vector *)&worker_buffers + 216B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L1045:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	248+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 240B].D.103980._M_impl.D.103319._M_finish, _156
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	240+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 240B].D.103980._M_impl.D.103319._M_start, _157
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _156, tmp408
	subq	%rdx, %rax	# _157, tmp408
	sarq	$7, %rax	#, tmp409
	imulq	%r12, %rax	# tmp523, tmp410
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp410
	jb	.L1090	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp410, _94
	jnb	.L1047	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbx, %rax	#, _94, tmp414
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp414, _163
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _163, _156
	je	.L1047	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 248+worker_buffers(%rip)	# _163, MEM[(struct vector *)&worker_buffers + 240B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L1047:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	272+worker_buffers(%rip), %r15	# MEM[(const struct vector *)&worker_buffers + 264B].D.107139._M_impl.D.106478._M_finish, _148
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	264+worker_buffers(%rip), %r14	# MEM[(const struct vector *)&worker_buffers + 264B].D.107139._M_impl.D.106478._M_start, _149
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-6148914691236517205, %rdi	#, tmp590
	movq	%r15, %rax	# _148, tmp418
	subq	%r14, %rax	# _149, tmp418
	sarq	$3, %rax	#, tmp419
	imulq	%rdi, %rax	# tmp590, tmp420
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp420
	jb	.L1091	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp420, _94
	jnb	.L1049	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$24, %rbx, %rax	#, _94, tmp424
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %r14	# tmp424, _155
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%r14, %r15	# _155, _148
	je	.L1049	#,
	movq	%r14, %rbp	# _155, __first
	.p2align 4
	.p2align 3
.L1053:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	0(%rbp), %rdi	# MEM[(int * *)__first_96], _248
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _248
	je	.L1050	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	16(%rbp), %rsi	# MEM[(int * *)__first_96 + 16B], tmp425
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	addq	$24, %rbp	#, __first
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rdi, %rsi	# _248, tmp425
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	cmpq	%rbp, %r15	# __first, _148
	jne	.L1053	#,
.L1052:
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%r14, 272+worker_buffers(%rip)	# _155, MEM[(struct vector *)&worker_buffers + 264B].D.107139._M_impl.D.106478._M_finish
	.p2align 4
	.p2align 3
.L1049:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	296+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 288B].D.108190._M_impl.D.107529._M_finish, _140
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	288+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 288B].D.108190._M_impl.D.107529._M_start, _141
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _140, tmp430
	subq	%rdx, %rax	# _141, tmp430
	sarq	$5, %rax	#, tmp431
	imulq	%r12, %rax	# tmp523, tmp432
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp432
	jb	.L1092	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp432, _94
	jnb	.L1055	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$800, %rbx, %rax	#, _94, tmp436
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp436, _147
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _147, _140
	je	.L1055	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 296+worker_buffers(%rip)	# _147, MEM[(struct vector *)&worker_buffers + 288B].D.108190._M_impl.D.107529._M_finish
	.p2align 4
	.p2align 3
.L1055:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	320+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 312B].D.108190._M_impl.D.107529._M_finish, _132
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	312+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 312B].D.108190._M_impl.D.107529._M_start, _133
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _132, tmp440
	subq	%rdx, %rax	# _133, tmp440
	sarq	$5, %rax	#, tmp441
	imulq	%r12, %rax	# tmp523, tmp442
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp442
	jb	.L1093	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp442, _94
	jnb	.L1057	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$800, %rbx, %rax	#, _94, tmp446
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp446, _139
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _139, _132
	je	.L1057	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 320+worker_buffers(%rip)	# _139, MEM[(struct vector *)&worker_buffers + 312B].D.108190._M_impl.D.107529._M_finish
	.p2align 4
	.p2align 3
.L1057:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	344+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 336B].D.109241._M_impl.D.108580._M_finish, _124
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	336+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 336B].D.109241._M_impl.D.108580._M_start, _125
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-36011213418661887, %rsi	#, tmp453
	movq	%rcx, %rax	# _124, tmp450
	subq	%rdx, %rax	# _125, tmp450
	sarq	$6, %rax	#, tmp451
	imulq	%rsi, %rax	# tmp453, tmp452
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp452
	jb	.L1094	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp452, _94
	jnb	.L1059	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$131136, %rbx, %rax	#, _94, tmp456
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp456, _131
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _131, _124
	je	.L1059	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 344+worker_buffers(%rip)	# _131, MEM[(struct vector *)&worker_buffers + 336B].D.109241._M_impl.D.108580._M_finish
	.p2align 4
	.p2align 3
.L1059:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	368+worker_buffers(%rip), %rcx	# MEM[(const struct vector *)&worker_buffers + 360B].D.109241._M_impl.D.108580._M_finish, _116
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	360+worker_buffers(%rip), %rdx	# MEM[(const struct vector *)&worker_buffers + 360B].D.109241._M_impl.D.108580._M_start, _117
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-36011213418661887, %rsi	#, tmp463
	movq	%rcx, %rax	# _116, tmp460
	subq	%rdx, %rax	# _117, tmp460
	sarq	$6, %rax	#, tmp461
	imulq	%rsi, %rax	# tmp463, tmp462
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbx, %rax	# _94, tmp462
	jb	.L1095	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbx	# tmp462, _94
	jnb	.L1062	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$131136, %rbx, %rax	#, _94, tmp469
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp469, _123
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _123, _116
	je	.L1062	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 368+worker_buffers(%rip)	# _123, MEM[(struct vector *)&worker_buffers + 360B].D.109241._M_impl.D.108580._M_finish
	.p2align 4
	.p2align 3
.L1062:
# C/parallel-only-omp/state.h:243:         for (int t = 0; t < num_threads; ++t) {
	testl	%r13d, %r13d	# num_threads
	jle	.L1067	#,
	leaq	(%rbx,%rbx,2), %r14	#, tmp473
	xorl	%ebp, %ebp	# ivtmp.2284
	movl	%r13d, 12(%rsp)	# num_threads, %sfp
	salq	$3, %r14	#, tmp474
	jmp	.L1066	#
	.p2align 4
	.p2align 3
.L1063:
	addq	$24, %rbp	#, ivtmp.2284
	cmpq	%r14, %rbp	# tmp474, ivtmp.2284
	je	.L1096	#,
.L1066:
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	264+worker_buffers(%rip), %rbx	# MEM[(struct vector *)&worker_buffers + 264B].D.107139._M_impl.D.106478._M_start, _114
	addq	%rbp, %rbx	# ivtmp.2284, _114
# /usr/include/c++/13/bits/stl_vector.h:1080: 			 - this->_M_impl._M_start); }
	movq	(%rbx), %rdx	# MEM[(const struct vector *)_114].D.110314._M_impl.D.109653._M_start, _256
# /usr/include/c++/13/bits/stl_vector.h:1080: 			 - this->_M_impl._M_start); }
	movq	16(%rbx), %rax	# MEM[(const struct vector *)_114].D.110314._M_impl.D.109653._M_end_of_storage, tmp477
	subq	%rdx, %rax	# _256, tmp477
# /usr/include/c++/13/bits/vector.tcc:72:       if (this->capacity() < __n)
	cmpq	$7996, %rax	#, tmp477
	ja	.L1063	#,
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	8(%rbx), %r15	# MEM[(const struct vector *)_114].D.110314._M_impl.D.109653._M_finish, _261
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movl	$8000, %edi	#,
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	subq	%rdx, %r15	# _256, _261
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	call	_Znwm@PLT	#
# /usr/include/c++/13/bits/vector.tcc:80: 	      _S_relocate(this->_M_impl._M_start, this->_M_impl._M_finish,
	movq	(%rbx), %rdi	# MEM[(struct vector *)_114].D.110314._M_impl.D.109653._M_start, _265
# /usr/include/c++/13/bits/stl_uninitialized.h:1118:       ptrdiff_t __count = __last - __first;
	movq	8(%rbx), %rdx	# MEM[(struct vector *)_114].D.110314._M_impl.D.109653._M_finish, _266
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %r13	# tmp533, _282
# /usr/include/c++/13/bits/stl_uninitialized.h:1118:       ptrdiff_t __count = __last - __first;
	subq	%rdi, %rdx	# _265, _266
# /usr/include/c++/13/bits/stl_uninitialized.h:1119:       if (__count > 0)
	testq	%rdx, %rdx	# _266
	jle	.L1064	#,
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	%rdi, %rsi	# _265,
	movq	%rax, %rdi	# _282,
	call	memmove@PLT	#
# /usr/include/c++/13/bits/vector.tcc:95: 			- this->_M_impl._M_start);
	movq	(%rbx), %rdi	# MEM[(struct vector *)_114].D.110314._M_impl.D.109653._M_start, _265
.L1064:
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _265
	je	.L1065	#,
# /usr/include/c++/13/bits/vector.tcc:95: 			- this->_M_impl._M_start);
	movq	16(%rbx), %rsi	# MEM[(struct vector *)_114].D.110314._M_impl.D.109653._M_end_of_storage, tmp482
	subq	%rdi, %rsi	# _265, tmp482
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L1065:
# /usr/include/c++/13/bits/vector.tcc:97: 	  this->_M_impl._M_finish = __tmp + __old_size;
	addq	%r13, %r15	# _282, tmp485
# /usr/include/c++/13/bits/vector.tcc:96: 	  this->_M_impl._M_start = __tmp;
	vmovq	%r13, %xmm3	# _282, _282
# /usr/include/c++/13/bits/vector.tcc:98: 	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	leaq	8000(%r13), %rcx	#, tmp486
# C/parallel-only-omp/state.h:243:         for (int t = 0; t < num_threads; ++t) {
	addq	$24, %rbp	#, ivtmp.2284
# /usr/include/c++/13/bits/vector.tcc:96: 	  this->_M_impl._M_start = __tmp;
	vpinsrq	$1, %r15, %xmm3, %xmm0	# tmp485, _282, tmp484
# /usr/include/c++/13/bits/vector.tcc:98: 	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	movq	%rcx, 16(%rbx)	# tmp486, MEM[(struct vector *)_114].D.110314._M_impl.D.109653._M_end_of_storage
# /usr/include/c++/13/bits/vector.tcc:96: 	  this->_M_impl._M_start = __tmp;
	vmovdqu	%xmm0, (%rbx)	# tmp484, MEM <vector(2) long unsigned int> [(int * *)_114]
# C/parallel-only-omp/state.h:243:         for (int t = 0; t < num_threads; ++t) {
	cmpq	%r14, %rbp	# tmp474, ivtmp.2284
	jne	.L1066	#,
.L1096:
	movl	12(%rsp), %r13d	# %sfp, num_threads
.L1067:
# C/parallel-only-omp/state.h:247:         #pragma omp parallel for schedule(static)
	leaq	worker_buffers(%rip), %rax	#, tmp601
	leaq	16(%rsp), %rsi	#, tmp467
	xorl	%ecx, %ecx	#
	movl	%r13d, 24(%rsp)	# num_threads, .omp_data_o.177.num_threads
	xorl	%edx, %edx	#
	leaq	_ZN13WorkerBuffers12init_buffersEi._omp_fn.0(%rip), %rdi	#, tmp468
	movq	%rax, 16(%rsp)	# tmp601, .omp_data_o.177.this
	call	GOMP_parallel@PLT	#
.L1025:
	xorl	%ecx, %ecx	#
	xorl	%edx, %edx	#
	xorl	%esi, %esi	#
	leaq	_Z12do_one_cyclev._omp_fn.0(%rip), %rdi	#,
	call	GOMP_parallel@PLT	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:79:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movl	N_i(%rip), %r9d	# N_i,
	movl	N_e(%rip), %r8d	# N_e,
	movl	cycle(%rip), %ecx	# cycle,
	movq	datafile(%rip), %rdi	# datafile,
	leaq	.LC146(%rip), %rdx	#,
	movl	$2, %esi	#,
	xorl	%eax, %eax	#
	call	__fprintf_chk@PLT	#
# C/parallel-only-omp/eduPIC.cc:82:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
	movl	cycle(%rip), %eax	# cycle, tmp608
# C/parallel-only-omp/eduPIC.cc:82:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
	movl	no_of_cycles(%rip), %edx	# no_of_cycles, no_of_cycles
	addl	cycles_done(%rip), %edx	# cycles_done, _15
# C/parallel-only-omp/eduPIC.cc:82:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
	incl	%eax	# _12
	movl	%eax, cycle(%rip)	# _12, cycle
# C/parallel-only-omp/eduPIC.cc:82:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
	cmpl	%edx, %eax	# _15, _12
	jle	.L1068	#,
.L1023:
# C/parallel-only-omp/eduPIC.cc:88:     fclose(datafile);
	movq	datafile(%rip), %rdi	# datafile,
# C/parallel-only-omp/eduPIC.cc:76:         cycles_done = 1;
	movl	%edx, cycles_done(%rip)	# _15, cycles_done
# C/parallel-only-omp/eduPIC.cc:88:     fclose(datafile);
	call	fclose@PLT	#
# C/parallel-only-omp/eduPIC.cc:90:     save_particle_data();
	call	_Z18save_particle_datav	#
# C/parallel-only-omp/eduPIC.cc:93:     if (measurement_mode) {
	cmpb	$0, measurement_mode(%rip)	#, measurement_mode
	jne	.L1097	#,
.L1070:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	no_of_cycles(%rip), %edx	# no_of_cycles,
	leaq	.LC194(%rip), %rsi	#, tmp498
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
# C/parallel-only-omp/eduPIC.cc:97: }
	xorl	%ebx, %ebx	# argc
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	__printf_chk@PLT	#
.L1014:
# C/parallel-only-omp/eduPIC.cc:97: }
	movq	40(%rsp), %rax	# D.134265, tmp550
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp550
	jne	.L1098	#,
	addq	$56, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	movl	%ebx, %eax	# argc,
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
.L1081:
	.cfi_restore_state
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	movq	%rbx, %rsi	# _94, tmp324
	leaq	24+worker_buffers(%rip), %rdi	#, tmp325
	subq	%rax, %rsi	# tmp322, tmp324
	call	_ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1029	#
.L1080:
	movq	%rbx, %rsi	# _94, tmp314
	leaq	worker_buffers(%rip), %rdi	#,
	subq	%rax, %rsi	# tmp312, tmp314
	call	_ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1027	#
.L1095:
	movq	%rbx, %rsi	# _94, tmp464
	leaq	360+worker_buffers(%rip), %rdi	#, tmp465
	subq	%rax, %rsi	# tmp462, tmp464
	call	_ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm	#
	jmp	.L1062	#
.L1094:
	movq	%rbx, %rsi	# _94, tmp454
	leaq	336+worker_buffers(%rip), %rdi	#, tmp455
	subq	%rax, %rsi	# tmp452, tmp454
	call	_ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm	#
	jmp	.L1059	#
.L1085:
	movq	%rbx, %rsi	# _94, tmp364
	leaq	120+worker_buffers(%rip), %rdi	#, tmp365
	subq	%rax, %rsi	# tmp362, tmp364
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1037	#
.L1084:
	movq	%rbx, %rsi	# _94, tmp354
	leaq	96+worker_buffers(%rip), %rdi	#, tmp355
	subq	%rax, %rsi	# tmp352, tmp354
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1035	#
.L1083:
	movq	%rbx, %rsi	# _94, tmp344
	leaq	72+worker_buffers(%rip), %rdi	#, tmp345
	subq	%rax, %rsi	# tmp342, tmp344
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1033	#
.L1082:
	movq	%rbx, %rsi	# _94, tmp334
	leaq	48+worker_buffers(%rip), %rdi	#, tmp335
	subq	%rax, %rsi	# tmp332, tmp334
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1031	#
.L1093:
	movq	%rbx, %rsi	# _94, tmp444
	leaq	312+worker_buffers(%rip), %rdi	#, tmp445
	subq	%rax, %rsi	# tmp442, tmp444
	call	_ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1057	#
.L1092:
	movq	%rbx, %rsi	# _94, tmp434
	leaq	288+worker_buffers(%rip), %rdi	#, tmp435
	subq	%rax, %rsi	# tmp432, tmp434
	call	_ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1055	#
.L1091:
	movq	%rbx, %rsi	# _94, tmp422
	leaq	264+worker_buffers(%rip), %rdi	#, tmp423
	subq	%rax, %rsi	# tmp420, tmp422
	call	_ZNSt6vectorIS_IiSaIiEESaIS1_EE17_M_default_appendEm	#
	jmp	.L1049	#
.L1090:
	movq	%rbx, %rsi	# _94, tmp412
	leaq	240+worker_buffers(%rip), %rdi	#, tmp413
	subq	%rax, %rsi	# tmp410, tmp412
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1047	#
.L1089:
	movq	%rbx, %rsi	# _94, tmp402
	leaq	216+worker_buffers(%rip), %rdi	#, tmp403
	subq	%rax, %rsi	# tmp400, tmp402
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1045	#
.L1088:
	movq	%rbx, %rsi	# _94, tmp392
	leaq	192+worker_buffers(%rip), %rdi	#, tmp393
	subq	%rax, %rsi	# tmp390, tmp392
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1043	#
.L1087:
	movq	%rbx, %rsi	# _94, tmp382
	leaq	168+worker_buffers(%rip), %rdi	#, tmp383
	subq	%rax, %rsi	# tmp381, tmp382
	call	_ZNSt6vectorI21AlignedThreadCountersSaIS0_EE17_M_default_appendEm	#
	jmp	.L1041	#
.L1086:
	movq	%rbx, %rsi	# _94, tmp374
	leaq	144+worker_buffers(%rip), %rdi	#, tmp375
	subq	%rax, %rsi	# tmp372, tmp374
	call	_ZNSt6vectorISt5arrayIdLm2000EESaIS1_EE17_M_default_appendEm	#
	jmp	.L1039	#
.L1079:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC181(%rip), %rsi	#, tmp275
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# C/parallel-only-omp/eduPIC.cc:27:         return 1;
	jmp	.L1014	#
.L1016:
# C/parallel-only-omp/eduPIC.cc:36:                 measurement_mode = false;
	movb	$0, measurement_mode(%rip)	#, measurement_mode
	jmp	.L1018	#
.L1097:
# C/parallel-only-omp/eduPIC.cc:94:         check_and_save_info();
	call	_Z19check_and_save_infov	#
	jmp	.L1070	#
.L1050:
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	addq	$24, %rbp	#, __first
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	cmpq	%rbp, %r15	# __first, _148
	jne	.L1053	#,
	jmp	.L1052	#
.L1024:
# C/parallel-only-omp/eduPIC.cc:82:         for (cycle=cycles_done+1;cycle<=cycles_done+no_of_cycles;cycle++) {
	addl	%eax, %edx	# no_of_cycles.7_93, _15
	jmp	.L1023	#
.L1022:
# C/parallel-only-omp/eduPIC.cc:72:         init(N_INIT);
	movl	$1000, %edi	#,
# C/parallel-only-omp/eduPIC.cc:68:         no_of_cycles = 1;
	movl	$1, no_of_cycles(%rip)	#, no_of_cycles
# C/parallel-only-omp/eduPIC.cc:69:         cycle = 1;
	movl	$1, cycle(%rip)	#, cycle
# C/parallel-only-omp/eduPIC.cc:72:         init(N_INIT);
	call	_Z4initi	#
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC192(%rip), %rsi	#, tmp303
	movl	$2, %edi	#,
	xorl	%eax, %eax	#
	call	__printf_chk@PLT	#
# C/parallel-only-omp/eduPIC.cc:74:         Time = 0;
	movq	$0x000000000, Time(%rip)	#, Time
# C/parallel-only-omp/eduPIC.cc:75:         do_one_cycle();
	call	_Z12do_one_cyclev	#
	movl	$1, %edx	#, _15
	jmp	.L1023	#
.L1098:
# C/parallel-only-omp/eduPIC.cc:97: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE9929:
	.size	main, .-main
	