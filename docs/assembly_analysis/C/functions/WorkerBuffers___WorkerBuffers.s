# Function: WorkerBuffers::~WorkerBuffers()
# Mangled Symbol: _ZN13WorkerBuffersD2Ev
# Architecture: AMD Zen 4 (znver4) AVX-512 / -O3

.section .text._ZN13WorkerBuffersD2Ev,"axG",@progbits,_ZN13WorkerBuffersD5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZN13WorkerBuffersD2Ev
	.type	_ZN13WorkerBuffersD2Ev, @function
_ZN13WorkerBuffersD2Ev:
.LFB11222:
	.cfi_startproc
	endbr64	
	pushq	%r12	#
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp	#
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp	# tmp186, this
	pushq	%rbx	#
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	360(%rdi), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 360B]._M_impl.D.108580._M_start, _159
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _159
	je	.L13	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	376(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 360B]._M_impl.D.108580._M_end_of_storage, tmp152
# /usr/include/c++/13/bits/new_allocator.h:167: 	    _GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n),
	movl	$64, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rdi, %rsi	# _159, tmp152
# /usr/include/c++/13/bits/new_allocator.h:167: 	    _GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n),
	call	_ZdlPvmSt11align_val_t@PLT	#
.L13:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	336(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 336B]._M_impl.D.108580._M_start, _151
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _151
	je	.L14	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	352(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 336B]._M_impl.D.108580._M_end_of_storage, tmp154
# /usr/include/c++/13/bits/new_allocator.h:167: 	    _GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n),
	movl	$64, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rdi, %rsi	# _151, tmp154
# /usr/include/c++/13/bits/new_allocator.h:167: 	    _GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n),
	call	_ZdlPvmSt11align_val_t@PLT	#
.L14:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	312(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 312B]._M_impl.D.107529._M_start, _143
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _143
	je	.L15	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	328(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 312B]._M_impl.D.107529._M_end_of_storage, tmp156
	subq	%rdi, %rsi	# _143, tmp156
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L15:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	288(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 288B]._M_impl.D.107529._M_start, _135
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _135
	je	.L16	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	304(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 288B]._M_impl.D.107529._M_end_of_storage, tmp158
	subq	%rdi, %rsi	# _135, tmp158
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L16:
# /usr/include/c++/13/bits/stl_vector.h:735: 	std::_Destroy(this->_M_impl._M_start, this->_M_impl._M_finish,
	movq	272(%rbp), %r12	# MEM[(struct vector *)this_17(D) + 264B].D.107139._M_impl.D.106478._M_finish, _124
	movq	264(%rbp), %rbx	# MEM[(struct vector *)this_17(D) + 264B].D.107139._M_impl.D.106478._M_start, __first
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	cmpq	%rbx, %r12	# __first, _124
	je	.L17	#,
	.p2align 4
	.p2align 3
.L21:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	(%rbx), %rdi	# MEM[(int * *)__first_156], _172
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _172
	je	.L18	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	16(%rbx), %rsi	# MEM[(int * *)__first_156 + 16B], tmp160
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	addq	$24, %rbx	#, __first
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rdi, %rsi	# _172, tmp160
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	cmpq	%rbx, %r12	# __first, _124
	jne	.L21	#,
.L20:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	264(%rbp), %rbx	# MEM[(struct _Vector_base *)this_17(D) + 264B]._M_impl.D.106478._M_start, __first
.L17:
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rbx, %rbx	# __first
	je	.L22	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	280(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 264B]._M_impl.D.106478._M_end_of_storage, tmp162
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%rbx, %rdi	# __first,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rbx, %rsi	# __first, tmp162
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L22:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	240(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 240B]._M_impl.D.103319._M_start, _119
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _119
	je	.L23	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	256(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 240B]._M_impl.D.103319._M_end_of_storage, tmp164
	subq	%rdi, %rsi	# _119, tmp164
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L23:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	216(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 216B]._M_impl.D.103319._M_start, _111
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _111
	je	.L24	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	232(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 216B]._M_impl.D.103319._M_end_of_storage, tmp166
	subq	%rdi, %rsi	# _111, tmp166
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L24:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	192(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 192B]._M_impl.D.103319._M_start, _103
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _103
	je	.L25	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	208(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 192B]._M_impl.D.103319._M_end_of_storage, tmp168
	subq	%rdi, %rsi	# _103, tmp168
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L25:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	168(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 168B]._M_impl.D.105423._M_start, _95
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _95
	je	.L26	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	184(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 168B]._M_impl.D.105423._M_end_of_storage, tmp170
# /usr/include/c++/13/bits/new_allocator.h:167: 	    _GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n),
	movl	$64, %edx	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rdi, %rsi	# _95, tmp170
# /usr/include/c++/13/bits/new_allocator.h:167: 	    _GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n),
	call	_ZdlPvmSt11align_val_t@PLT	#
.L26:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	144(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 144B]._M_impl.D.104373._M_start, _87
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _87
	je	.L27	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	160(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 144B]._M_impl.D.104373._M_end_of_storage, tmp172
	subq	%rdi, %rsi	# _87, tmp172
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L27:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	120(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 120B]._M_impl.D.103319._M_start, _79
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _79
	je	.L28	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	136(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 120B]._M_impl.D.103319._M_end_of_storage, tmp174
	subq	%rdi, %rsi	# _79, tmp174
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L28:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	96(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 96B]._M_impl.D.103319._M_start, _71
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _71
	je	.L29	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	112(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 96B]._M_impl.D.103319._M_end_of_storage, tmp176
	subq	%rdi, %rsi	# _71, tmp176
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L29:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	72(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 72B]._M_impl.D.103319._M_start, _63
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _63
	je	.L30	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	88(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 72B]._M_impl.D.103319._M_end_of_storage, tmp178
	subq	%rdi, %rsi	# _63, tmp178
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L30:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	48(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 48B]._M_impl.D.103319._M_start, _55
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _55
	je	.L31	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	64(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 48B]._M_impl.D.103319._M_end_of_storage, tmp180
	subq	%rdi, %rsi	# _55, tmp180
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L31:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	24(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D) + 24B]._M_impl.D.102267._M_start, _47
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _47
	je	.L32	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	40(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D) + 24B]._M_impl.D.102267._M_end_of_storage, tmp182
	subq	%rdi, %rsi	# _47, tmp182
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	call	_ZdlPvm@PLT	#
.L32:
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	0(%rbp), %rdi	# MEM[(struct _Vector_base *)this_17(D)]._M_impl.D.102267._M_start, _39
# /usr/include/c++/13/bits/stl_vector.h:389: 	if (__p)
	testq	%rdi, %rdi	# _39
	je	.L79	#,
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	movq	16(%rbp), %rsi	# MEM[(struct _Vector_base *)this_17(D)]._M_impl.D.102267._M_end_of_storage, MEM[(struct _Vector_base *)this_17(D)]._M_impl.D.102267._M_end_of_storage
# C/parallel-only-omp/state.h:179: struct WorkerBuffers {
	popq	%rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
# /usr/include/c++/13/bits/stl_vector.h:370: 		      _M_impl._M_end_of_storage - _M_impl._M_start);
	subq	%rdi, %rsi	# _39, tmp184
# /usr/include/c++/13/bits/new_allocator.h:172: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	jmp	_ZdlPvm@PLT	#
	.p2align 4
	.p2align 3
.L18:
	.cfi_restore_state
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	addq	$24, %rbx	#, __first
# /usr/include/c++/13/bits/stl_construct.h:162: 	  for (; __first != __last; ++__first)
	cmpq	%rbx, %r12	# __first, _124
	jne	.L21	#,
	jmp	.L20	#
	.p2align 4
	.p2align 3
.L79:
# C/parallel-only-omp/state.h:179: struct WorkerBuffers {
	popq	%rbx	#
	.cfi_def_cfa_offset 24
	popq	%rbp	#
	.cfi_def_cfa_offset 16
	popq	%r12	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE11222:
	.size	_ZN13WorkerBuffersD2Ev, .-_ZN13WorkerBuffersD2Ev
	.weak	_ZN13WorkerBuffersD1Ev
	.set	_ZN13WorkerBuffersD1Ev,_ZN13WorkerBuffersD2Ev
	.section	.rodata._Z30set_electron_cross_sections_arv.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	">> eduPIC: Setting e- / Ar cross sections\n"
	