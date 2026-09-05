# Function: WorkerBuffers::init_buffers(int)
# Mangled Symbol: _ZN13WorkerBuffers12init_buffersEi
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._ZN13WorkerBuffers12init_buffersEi,"axG",@progbits,_ZN13WorkerBuffers12init_buffersEi,comdat
	.align 2
	.p2align 4
	.weak	_ZN13WorkerBuffers12init_buffersEi
	.type	_ZN13WorkerBuffers12init_buffersEi, @function
_ZN13WorkerBuffers12init_buffersEi:
.LFB9786:
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
	movl	%esi, %r13d	# tmp408, num_threads
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$5675921253449092805, %rsi	#, tmp263
# C/parallel-only-omp/state.h:215:     void init_buffers(int num_threads) {
	subq	$56, %rsp	#,
	.cfi_def_cfa_offset 112
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	8(%rdi), %rcx	# MEM[(const struct vector *)this_21(D)].D.102928._M_impl.D.102267._M_finish, _40
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	(%rdi), %rdx	# MEM[(const struct vector *)this_21(D)].D.102928._M_impl.D.102267._M_start, _43
# C/parallel-only-omp/state.h:215:     void init_buffers(int num_threads) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp425
	movq	%rax, 40(%rsp)	# tmp425, D.133572
	xorl	%eax, %eax	# tmp425
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _40, tmp260
	subq	%rdx, %rax	# _43, tmp260
	sarq	$8, %rax	#, tmp261
	imulq	%rsi, %rax	# tmp263, tmp262
# C/parallel-only-omp/state.h:216:         if ((int)e_density.size() >= num_threads) return;
	cmpl	%eax, %r13d	# tmp262, num_threads
	jg	.L689	#,
.L638:
# C/parallel-only-omp/state.h:254:     }
	movq	40(%rsp), %rax	# D.133572, tmp426
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp426
	jne	.L690	#,
	addq	$56, %rsp	#,
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
.L689:
	.cfi_restore_state
# C/parallel-only-omp/state.h:218:         e_density.resize(num_threads);
	movslq	%r13d, %rbp	# num_threads, _3
	movq	%rdi, %rbx	# tmp407, this
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp262
	jb	.L691	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp262, _3
	jnb	.L641	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3328, %rbp, %rax	#, _3, tmp265
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp265, _177
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _177, _40
	je	.L641	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 8(%rdi)	# _177, MEM[(struct vector *)this_21(D)].D.102928._M_impl.D.102267._M_finish
	.p2align 4
	.p2align 3
.L641:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	32(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 24B].D.102928._M_impl.D.102267._M_finish, _162
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	24(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 24B].D.102928._M_impl.D.102267._M_start, _163
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$5675921253449092805, %rsi	#, tmp269
	movq	%rcx, %rax	# _162, tmp266
	subq	%rdx, %rax	# _163, tmp266
	sarq	$8, %rax	#, tmp267
	imulq	%rsi, %rax	# tmp269, tmp268
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp268
	jb	.L692	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp268, _3
	jnb	.L643	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3328, %rbp, %rax	#, _3, tmp272
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp272, _169
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _169, _162
	je	.L643	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 32(%rbx)	# _169, MEM[(struct vector *)this_21(D) + 24B].D.102928._M_impl.D.102267._M_finish
	.p2align 4
	.p2align 3
.L643:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	56(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 48B].D.103980._M_impl.D.103319._M_finish, _154
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	48(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 48B].D.103980._M_impl.D.103319._M_start, _155
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp276
	movq	%rcx, %rax	# _154, tmp273
	subq	%rdx, %rax	# _155, tmp273
	sarq	$7, %rax	#, tmp274
	imulq	%rsi, %rax	# tmp276, tmp275
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp275
	jb	.L693	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp275, _3
	jnb	.L645	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbp, %rax	#, _3, tmp279
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp279, _161
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _161, _154
	je	.L645	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 56(%rbx)	# _161, MEM[(struct vector *)this_21(D) + 48B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L645:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	80(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 72B].D.103980._M_impl.D.103319._M_finish, _146
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	72(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 72B].D.103980._M_impl.D.103319._M_start, _147
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp283
	movq	%rcx, %rax	# _146, tmp280
	subq	%rdx, %rax	# _147, tmp280
	sarq	$7, %rax	#, tmp281
	imulq	%rsi, %rax	# tmp283, tmp282
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp282
	jb	.L694	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp282, _3
	jnb	.L647	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbp, %rax	#, _3, tmp286
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp286, _153
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _153, _146
	je	.L647	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 80(%rbx)	# _153, MEM[(struct vector *)this_21(D) + 72B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L647:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	104(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 96B].D.103980._M_impl.D.103319._M_finish, _138
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	96(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 96B].D.103980._M_impl.D.103319._M_start, _139
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp290
	movq	%rcx, %rax	# _138, tmp287
	subq	%rdx, %rax	# _139, tmp287
	sarq	$7, %rax	#, tmp288
	imulq	%rsi, %rax	# tmp290, tmp289
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp289
	jb	.L695	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp289, _3
	jnb	.L649	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbp, %rax	#, _3, tmp293
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp293, _145
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _145, _138
	je	.L649	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 104(%rbx)	# _145, MEM[(struct vector *)this_21(D) + 96B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L649:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	128(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 120B].D.103980._M_impl.D.103319._M_finish, _130
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	120(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 120B].D.103980._M_impl.D.103319._M_start, _131
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp297
	movq	%rcx, %rax	# _130, tmp294
	subq	%rdx, %rax	# _131, tmp294
	sarq	$7, %rax	#, tmp295
	imulq	%rsi, %rax	# tmp297, tmp296
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp296
	jb	.L696	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp296, _3
	jnb	.L651	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbp, %rax	#, _3, tmp300
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp300, _137
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _137, _130
	je	.L651	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 128(%rbx)	# _137, MEM[(struct vector *)this_21(D) + 120B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L651:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	152(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 144B].D.105034._M_impl.D.104373._M_finish, _122
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	144(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 144B].D.105034._M_impl.D.104373._M_start, _123
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$2066035336255469781, %rsi	#, tmp304
	movq	%rcx, %rax	# _122, tmp301
	subq	%rdx, %rax	# _123, tmp301
	sarq	$7, %rax	#, tmp302
	imulq	%rsi, %rax	# tmp304, tmp303
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp303
	jb	.L697	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp303, _3
	jnb	.L653	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$16000, %rbp, %rax	#, _3, tmp307
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp307, _129
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _129, _122
	je	.L653	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 152(%rbx)	# _129, MEM[(struct vector *)this_21(D) + 144B].D.105034._M_impl.D.104373._M_finish
	.p2align 4
	.p2align 3
.L653:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	176(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 168B].D.106084._M_impl.D.105423._M_finish, _114
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	168(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 168B].D.106084._M_impl.D.105423._M_start, _115
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	%rcx, %rax	# _114, tmp308
	subq	%rdx, %rax	# _115, tmp308
	sarq	$6, %rax	#, tmp309
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp309
	jb	.L698	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp309, _3
	jnb	.L655	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	movq	%rbp, %rax	# _3, tmp312
	salq	$6, %rax	#, tmp312
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp312, _121
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _121, _114
	je	.L655	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 176(%rbx)	# _121, MEM[(struct vector *)this_21(D) + 168B].D.106084._M_impl.D.105423._M_finish
	.p2align 4
	.p2align 3
.L655:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	200(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 192B].D.103980._M_impl.D.103319._M_finish, _106
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	192(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 192B].D.103980._M_impl.D.103319._M_start, _107
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp316
	movq	%rcx, %rax	# _106, tmp313
	subq	%rdx, %rax	# _107, tmp313
	sarq	$7, %rax	#, tmp314
	imulq	%rsi, %rax	# tmp316, tmp315
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp315
	jb	.L699	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp315, _3
	jnb	.L657	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbp, %rax	#, _3, tmp319
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp319, _113
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _113, _106
	je	.L657	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 200(%rbx)	# _113, MEM[(struct vector *)this_21(D) + 192B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L657:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	224(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 216B].D.103980._M_impl.D.103319._M_finish, _98
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	216(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 216B].D.103980._M_impl.D.103319._M_start, _99
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp323
	movq	%rcx, %rax	# _98, tmp320
	subq	%rdx, %rax	# _99, tmp320
	sarq	$7, %rax	#, tmp321
	imulq	%rsi, %rax	# tmp323, tmp322
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp322
	jb	.L700	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp322, _3
	jnb	.L659	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbp, %rax	#, _3, tmp326
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp326, _105
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _105, _98
	je	.L659	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 224(%rbx)	# _105, MEM[(struct vector *)this_21(D) + 216B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L659:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	248(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 240B].D.103980._M_impl.D.103319._M_finish, _90
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	240(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 240B].D.103980._M_impl.D.103319._M_start, _91
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp330
	movq	%rcx, %rax	# _90, tmp327
	subq	%rdx, %rax	# _91, tmp327
	sarq	$7, %rax	#, tmp328
	imulq	%rsi, %rax	# tmp330, tmp329
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp329
	jb	.L701	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp329, _3
	jnb	.L661	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$3200, %rbp, %rax	#, _3, tmp333
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp333, _97
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _97, _90
	je	.L661	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 248(%rbx)	# _97, MEM[(struct vector *)this_21(D) + 240B].D.103980._M_impl.D.103319._M_finish
	.p2align 4
	.p2align 3
.L661:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	272(%rbx), %r15	# MEM[(const struct vector *)this_21(D) + 264B].D.107139._M_impl.D.106478._M_finish, _82
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	264(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 264B].D.107139._M_impl.D.106478._M_start, _83
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-6148914691236517205, %rcx	#, tmp337
	movq	%r15, %rax	# _82, tmp334
	subq	%rdx, %rax	# _83, tmp334
	sarq	$3, %rax	#, tmp335
	imulq	%rcx, %rax	# tmp337, tmp336
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp336
	jb	.L702	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp336, _3
	jnb	.L663	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	leaq	0(%rbp,%rbp,2), %rax	#, tmp342
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	leaq	(%rdx,%rax,8), %r14	#, _89
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%r14, %r15	# _89, _82
	je	.L663	#,
	movq	%r14, %r12	# _89, __first
	.p2align 4
	.p2align 3
.L667:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	(%r12), %rdi	# MEM[(int * *)__first_187], _182
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _182
	je	.L664	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	16(%r12), %rsi	# MEM[(int * *)__first_187 + 16B], tmp344
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	addq	$24, %r12	#, __first
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rdi, %rsi	# _182, tmp344
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	cmpq	%r12, %r15	# __first, _82
	jne	.L667	#,
.L666:
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%r14, 272(%rbx)	# _89, MEM[(struct vector *)this_21(D) + 264B].D.107139._M_impl.D.106478._M_finish
	.p2align 4
	.p2align 3
.L663:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	296(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 288B].D.108190._M_impl.D.107529._M_finish, _74
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	288(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 288B].D.108190._M_impl.D.107529._M_start, _75
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp349
	movq	%rcx, %rax	# _74, tmp346
	subq	%rdx, %rax	# _75, tmp346
	sarq	$5, %rax	#, tmp347
	imulq	%rsi, %rax	# tmp349, tmp348
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp348
	jb	.L703	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp348, _3
	jnb	.L669	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$800, %rbp, %rax	#, _3, tmp352
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp352, _81
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _81, _74
	je	.L669	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 296(%rbx)	# _81, MEM[(struct vector *)this_21(D) + 288B].D.108190._M_impl.D.107529._M_finish
	.p2align 4
	.p2align 3
.L669:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	320(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 312B].D.108190._M_impl.D.107529._M_finish, _66
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	312(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 312B].D.108190._M_impl.D.107529._M_start, _67
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-8116567392432202711, %rsi	#, tmp356
	movq	%rcx, %rax	# _66, tmp353
	subq	%rdx, %rax	# _67, tmp353
	sarq	$5, %rax	#, tmp354
	imulq	%rsi, %rax	# tmp356, tmp355
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp355
	jb	.L704	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp355, _3
	jnb	.L671	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$800, %rbp, %rax	#, _3, tmp359
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp359, _73
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _73, _66
	je	.L671	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 320(%rbx)	# _73, MEM[(struct vector *)this_21(D) + 312B].D.108190._M_impl.D.107529._M_finish
	.p2align 4
	.p2align 3
.L671:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	344(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 336B].D.109241._M_impl.D.108580._M_finish, _58
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	336(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 336B].D.109241._M_impl.D.108580._M_start, _59
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-36011213418661887, %rsi	#, tmp363
	movq	%rcx, %rax	# _58, tmp360
	subq	%rdx, %rax	# _59, tmp360
	sarq	$6, %rax	#, tmp361
	imulq	%rsi, %rax	# tmp363, tmp362
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp362
	jb	.L705	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp362, _3
	jnb	.L673	#,
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$131136, %rbp, %rax	#, _3, tmp366
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp366, _65
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _65, _58
	je	.L673	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 344(%rbx)	# _65, MEM[(struct vector *)this_21(D) + 336B].D.109241._M_impl.D.108580._M_finish
	.p2align 4
	.p2align 3
.L673:
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	368(%rbx), %rcx	# MEM[(const struct vector *)this_21(D) + 360B].D.109241._M_impl.D.108580._M_finish, _50
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	360(%rbx), %rdx	# MEM[(const struct vector *)this_21(D) + 360B].D.109241._M_impl.D.108580._M_start, _51
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movabsq	$-36011213418661887, %rsi	#, tmp370
	movq	%rcx, %rax	# _50, tmp367
	subq	%rdx, %rax	# _51, tmp367
	sarq	$6, %rax	#, tmp368
	imulq	%rsi, %rax	# tmp370, tmp369
# /usr/include/c++/13/bits/stl_vector.h:1015: 	if (__new_size > size())
	cmpq	%rbp, %rax	# _3, tmp369
	jb	.L706	#,
# /usr/include/c++/13/bits/stl_vector.h:1017: 	else if (__new_size < size())
	cmpq	%rax, %rbp	# tmp369, _3
	jb	.L707	#,
.L676:
# C/parallel-only-omp/state.h:243:         for (int t = 0; t < num_threads; ++t) {
	testl	%r13d, %r13d	# num_threads
	jle	.L681	#,
	leaq	0(%rbp,%rbp,2), %r14	#, tmp378
	xorl	%r12d, %r12d	# ivtmp.1962
	salq	$3, %r14	#, tmp379
	jmp	.L680	#
	.p2align 4
	.p2align 3
.L677:
	addq	$24, %r12	#, ivtmp.1962
	cmpq	%r12, %r14	# ivtmp.1962, tmp379
	je	.L681	#,
.L680:
# /usr/include/c++/13/bits/stl_vector.h:1129: 	return *(this->_M_impl._M_start + __n);
	movq	264(%rbx), %rbp	# MEM[(struct vector *)this_21(D) + 264B].D.107139._M_impl.D.106478._M_start, _48
	addq	%r12, %rbp	# ivtmp.1962, _48
# /usr/include/c++/13/bits/stl_vector.h:1080: 			 - this->_M_impl._M_start); }
	movq	0(%rbp), %rdx	# MEM[(const struct vector *)_48].D.110314._M_impl.D.109653._M_start, _190
# /usr/include/c++/13/bits/stl_vector.h:1080: 			 - this->_M_impl._M_start); }
	movq	16(%rbp), %rax	# MEM[(const struct vector *)_48].D.110314._M_impl.D.109653._M_end_of_storage, tmp381
	subq	%rdx, %rax	# _190, tmp381
# /usr/include/c++/13/bits/vector.tcc:72:       if (this->capacity() < __n)
	cmpq	$7996, %rax	#, tmp381
	ja	.L677	#,
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	movq	8(%rbp), %r15	# MEM[(const struct vector *)_48].D.110314._M_impl.D.109653._M_finish, _195
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movl	$8000, %edi	#,
# /usr/include/c++/13/bits/stl_vector.h:993:       { return size_type(this->_M_impl._M_finish - this->_M_impl._M_start); }
	subq	%rdx, %r15	# _190, _195
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	call	_Znwm@PLT	#
# /usr/include/c++/13/bits/vector.tcc:80: 	      _S_relocate(this->_M_impl._M_start, this->_M_impl._M_finish,
	movq	0(%rbp), %rdi	# MEM[(struct vector *)_48].D.110314._M_impl.D.109653._M_start, _199
# /usr/include/c++/13/bits/stl_uninitialized.h:1118:       ptrdiff_t __count = __last - __first;
	movq	8(%rbp), %rdx	# MEM[(struct vector *)_48].D.110314._M_impl.D.109653._M_finish, _200
# /usr/include/c++/13/bits/new_allocator.h:151: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %rcx	# tmp409, _216
# /usr/include/c++/13/bits/stl_uninitialized.h:1118:       ptrdiff_t __count = __last - __first;
	subq	%rdi, %rdx	# _199, _200
# /usr/include/c++/13/bits/stl_uninitialized.h:1119:       if (__count > 0)
	testq	%rdx, %rdx	# _200
	jle	.L678	#,
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	%rdi, %rsi	# _199,
	movq	%rax, %rdi	# _216,
	call	memmove@PLT	#
# /usr/include/c++/13/bits/vector.tcc:95: 			- this->_M_impl._M_start);
	movq	0(%rbp), %rdi	# MEM[(struct vector *)_48].D.110314._M_impl.D.109653._M_start, _199
# /usr/include/c++/13/bits/stl_uninitialized.h:1131: 	  __builtin_memmove(__result, __first, __count * sizeof(_Tp));
	movq	%rax, %rcx	#, _216
.L678:
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _199
	je	.L679	#,
# /usr/include/c++/13/bits/vector.tcc:95: 			- this->_M_impl._M_start);
	movq	16(%rbp), %rsi	# MEM[(struct vector *)_48].D.110314._M_impl.D.109653._M_end_of_storage, tmp386
	movq	%rcx, 8(%rsp)	# _216, %sfp
	subq	%rdi, %rsi	# _199, tmp386
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
	movq	8(%rsp), %rcx	# %sfp, _216
.L679:
# /usr/include/c++/13/bits/vector.tcc:97: 	  this->_M_impl._M_finish = __tmp + __old_size;
	addq	%rcx, %r15	# _216, tmp389
# /usr/include/c++/13/bits/vector.tcc:96: 	  this->_M_impl._M_start = __tmp;
	vmovq	%rcx, %xmm1	# _216, _216
# C/parallel-only-omp/state.h:243:         for (int t = 0; t < num_threads; ++t) {
	addq	$24, %r12	#, ivtmp.1962
# /usr/include/c++/13/bits/vector.tcc:98: 	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	addq	$8000, %rcx	#, tmp390
# /usr/include/c++/13/bits/vector.tcc:96: 	  this->_M_impl._M_start = __tmp;
	vpinsrq	$1, %r15, %xmm1, %xmm0	# tmp389, _216, tmp388
# /usr/include/c++/13/bits/vector.tcc:98: 	  this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	movq	%rcx, 16(%rbp)	# tmp390, MEM[(struct vector *)_48].D.110314._M_impl.D.109653._M_end_of_storage
# /usr/include/c++/13/bits/vector.tcc:96: 	  this->_M_impl._M_start = __tmp;
	vmovdqu	%xmm0, 0(%rbp)	# tmp388, MEM <vector(2) long unsigned int> [(int * *)_48]
# C/parallel-only-omp/state.h:243:         for (int t = 0; t < num_threads; ++t) {
	cmpq	%r12, %r14	# ivtmp.1962, tmp379
	jne	.L680	#,
.L681:
	leaq	16(%rsp), %rsi	#, tmp373
	xorl	%ecx, %ecx	#
	xorl	%edx, %edx	#
	leaq	_ZN13WorkerBuffers12init_buffersEi._omp_fn.0(%rip), %rdi	#, tmp374
# C/parallel-only-omp/state.h:247:         #pragma omp parallel for schedule(static)
	movq	%rbx, 16(%rsp)	# this, .omp_data_o.177.this
	movl	%r13d, 24(%rsp)	# num_threads, .omp_data_o.177.num_threads
	call	GOMP_parallel@PLT	#
	jmp	.L638	#
	.p2align 4
	.p2align 3
.L707:
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	imulq	$131136, %rbp, %rax	#, _3, tmp375
# /usr/include/c++/13/bits/stl_vector.h:1018: 	  _M_erase_at_end(this->_M_impl._M_start + __new_size);
	addq	%rax, %rdx	# tmp375, _57
# /usr/include/c++/13/bits/stl_vector.h:1935: 	if (size_type __n = this->_M_impl._M_finish - __pos)
	cmpq	%rdx, %rcx	# _57, _50
	je	.L676	#,
# /usr/include/c++/13/bits/stl_vector.h:1939: 	    this->_M_impl._M_finish = __pos;
	movq	%rdx, 368(%rbx)	# _57, MEM[(struct vector *)this_21(D) + 360B].D.109241._M_impl.D.108580._M_finish
	jmp	.L676	#
	.p2align 4
	.p2align 3
.L664:
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	addq	$24, %r12	#, __first
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	cmpq	%r12, %r15	# __first, _82
	jne	.L667	#,
	jmp	.L666	#
	.p2align 4
	.p2align 3
.L692:
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	movq	%rbp, %rsi	# _3, tmp270
# C/parallel-only-omp/state.h:219:         i_density.resize(num_threads);
	leaq	24(%rbx), %rdi	#, tmp271
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp268, tmp270
	call	_ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm	#
	jmp	.L643	#
	.p2align 4
	.p2align 3
.L691:
	movq	%rbp, %rsi	# _3, tmp264
	subq	%rax, %rsi	# tmp262, tmp264
	call	_ZNSt6vectorISt5arrayIdLm416EESaIS1_EE17_M_default_appendEm	#
	jmp	.L641	#
	.p2align 4
	.p2align 3
.L699:
	movq	%rbp, %rsi	# _3, tmp317
# C/parallel-only-omp/state.h:228:         counter_i.resize(num_threads);
	leaq	192(%rbx), %rdi	#, tmp318
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp315, tmp317
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L657	#
	.p2align 4
	.p2align 3
.L701:
	movq	%rbp, %rsi	# _3, tmp331
# C/parallel-only-omp/state.h:230:         meanei.resize(num_threads);
	leaq	240(%rbx), %rdi	#, tmp332
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp329, tmp331
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L661	#
	.p2align 4
	.p2align 3
.L704:
	movq	%rbp, %rsi	# _3, tmp357
# C/parallel-only-omp/state.h:234:         local_ifed_gnd.resize(num_threads);
	leaq	312(%rbx), %rdi	#, tmp358
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp355, tmp357
	call	_ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm	#
	jmp	.L671	#
	.p2align 4
	.p2align 3
.L703:
	movq	%rbp, %rsi	# _3, tmp350
# C/parallel-only-omp/state.h:233:         local_ifed_pow.resize(num_threads);
	leaq	288(%rbx), %rdi	#, tmp351
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp348, tmp350
	call	_ZNSt6vectorISt5arrayIiLm200EESaIS1_EE17_M_default_appendEm	#
	jmp	.L669	#
	.p2align 4
	.p2align 3
.L706:
	movq	%rbp, %rsi	# _3, tmp371
# C/parallel-only-omp/state.h:237:         new_ions.resize(num_threads);
	leaq	360(%rbx), %rdi	#, tmp372
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp369, tmp371
	call	_ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm	#
	jmp	.L676	#
	.p2align 4
	.p2align 3
.L705:
	movq	%rbp, %rsi	# _3, tmp364
# C/parallel-only-omp/state.h:236:         new_electrons.resize(num_threads);
	leaq	336(%rbx), %rdi	#, tmp365
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp362, tmp364
	call	_ZNSt6vectorI12NewParticlesSaIS0_EE17_M_default_appendEm	#
	jmp	.L673	#
	.p2align 4
	.p2align 3
.L698:
	movq	%rbp, %rsi	# _3, tmp310
# C/parallel-only-omp/state.h:226:         thread_counters.resize(num_threads);
	leaq	168(%rbx), %rdi	#, tmp311
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp309, tmp310
	call	_ZNSt6vectorI21AlignedThreadCountersSaIS0_EE17_M_default_appendEm	#
	jmp	.L655	#
	.p2align 4
	.p2align 3
.L697:
	movq	%rbp, %rsi	# _3, tmp305
# C/parallel-only-omp/state.h:225:         eepf.resize(num_threads);
	leaq	144(%rbx), %rdi	#, tmp306
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp303, tmp305
	call	_ZNSt6vectorISt5arrayIdLm2000EESaIS1_EE17_M_default_appendEm	#
	jmp	.L653	#
	.p2align 4
	.p2align 3
.L702:
	movq	%rbp, %rsi	# _3, tmp338
# C/parallel-only-omp/state.h:232:         absorbed_indices.resize(num_threads);
	leaq	264(%rbx), %rdi	#, tmp339
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp336, tmp338
	call	_ZNSt6vectorIS_IiSaIiEESaIS1_EE17_M_default_appendEm	#
	jmp	.L663	#
	.p2align 4
	.p2align 3
.L700:
	movq	%rbp, %rsi	# _3, tmp324
# C/parallel-only-omp/state.h:229:         ui.resize(num_threads);
	leaq	216(%rbx), %rdi	#, tmp325
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp322, tmp324
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L659	#
	.p2align 4
	.p2align 3
.L694:
	movq	%rbp, %rsi	# _3, tmp284
# C/parallel-only-omp/state.h:222:         ue.resize(num_threads);
	leaq	72(%rbx), %rdi	#, tmp285
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp282, tmp284
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L647	#
	.p2align 4
	.p2align 3
.L693:
	movq	%rbp, %rsi	# _3, tmp277
# C/parallel-only-omp/state.h:221:         counter_e.resize(num_threads);
	leaq	48(%rbx), %rdi	#, tmp278
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp275, tmp277
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L645	#
	.p2align 4
	.p2align 3
.L696:
	movq	%rbp, %rsi	# _3, tmp298
# C/parallel-only-omp/state.h:224:         ioniz.resize(num_threads);
	leaq	120(%rbx), %rdi	#, tmp299
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp296, tmp298
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L651	#
	.p2align 4
	.p2align 3
.L695:
	movq	%rbp, %rsi	# _3, tmp291
# C/parallel-only-omp/state.h:223:         meanee.resize(num_threads);
	leaq	96(%rbx), %rdi	#, tmp292
# /usr/include/c++/13/bits/stl_vector.h:1016: 	  _M_default_append(__new_size - size());
	subq	%rax, %rsi	# tmp289, tmp291
	call	_ZNSt6vectorISt5arrayIdLm400EESaIS1_EE17_M_default_appendEm	#
	jmp	.L649	#
.L690:
# C/parallel-only-omp/state.h:254:     }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE9786:
	.size	_ZN13WorkerBuffers12init_buffersEi, .-_ZN13WorkerBuffers12init_buffersEi
	.section	.rodata._Z12do_one_cyclev.str1.1,"aMS",@progbits,1
.LC146:
	.string	"%8d  %8d  %8d\n"
	