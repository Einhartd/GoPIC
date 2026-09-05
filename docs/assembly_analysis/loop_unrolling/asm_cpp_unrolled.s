	.file	"loop_unroll_demo.cc"
	.text
	.p2align 4
	.globl	_Z15MoveStandardCPPSt4spanIdLm18446744073709551615EES_IKdLm18446744073709551615EEd
	.type	_Z15MoveStandardCPPSt4spanIdLm18446744073709551615EES_IKdLm18446744073709551615EEd, @function
_Z15MoveStandardCPPSt4spanIdLm18446744073709551615EES_IKdLm18446744073709551615EEd:
.LFB842:
	.cfi_startproc
	endbr64
	movq	%rdi, %rcx
	testq	%rsi, %rsi
	je	.L1
	cmpq	$1, %rsi
	je	.L8
	leaq	8(%rdx), %rdi
	xorl	%eax, %eax
	cmpq	%rdi, %rcx
	jne	.L91
.L58:
	movq	%rsi, %r11
	andl	$7, %r11d
	je	.L6
	cmpq	$1, %r11
	je	.L65
	cmpq	$2, %r11
	je	.L66
	cmpq	$3, %r11
	je	.L67
	cmpq	$4, %r11
	je	.L68
	cmpq	$5, %r11
	je	.L69
	cmpq	$6, %r11
	jne	.L92
.L70:
	movsd	(%rdx,%rax,8), %xmm5
	mulsd	%xmm0, %xmm5
	addsd	(%rcx,%rax,8), %xmm5
	movsd	%xmm5, (%rcx,%rax,8)
	addq	$1, %rax
.L69:
	movsd	(%rdx,%rax,8), %xmm4
	mulsd	%xmm0, %xmm4
	addsd	(%rcx,%rax,8), %xmm4
	movsd	%xmm4, (%rcx,%rax,8)
	addq	$1, %rax
.L68:
	movsd	(%rdx,%rax,8), %xmm6
	mulsd	%xmm0, %xmm6
	addsd	(%rcx,%rax,8), %xmm6
	movsd	%xmm6, (%rcx,%rax,8)
	addq	$1, %rax
.L67:
	movsd	(%rdx,%rax,8), %xmm7
	mulsd	%xmm0, %xmm7
	addsd	(%rcx,%rax,8), %xmm7
	movsd	%xmm7, (%rcx,%rax,8)
	addq	$1, %rax
.L66:
	movsd	(%rdx,%rax,8), %xmm8
	mulsd	%xmm0, %xmm8
	addsd	(%rcx,%rax,8), %xmm8
	movsd	%xmm8, (%rcx,%rax,8)
	addq	$1, %rax
.L65:
	movsd	(%rdx,%rax,8), %xmm9
	mulsd	%xmm0, %xmm9
	addsd	(%rcx,%rax,8), %xmm9
	movsd	%xmm9, (%rcx,%rax,8)
	addq	$1, %rax
	cmpq	%rax, %rsi
	je	.L93
.L6:
	movsd	(%rdx,%rax,8), %xmm10
	mulsd	%xmm0, %xmm10
	addsd	(%rcx,%rax,8), %xmm10
	movsd	%xmm10, (%rcx,%rax,8)
	movsd	8(%rdx,%rax,8), %xmm11
	mulsd	%xmm0, %xmm11
	addsd	8(%rcx,%rax,8), %xmm11
	movsd	%xmm11, 8(%rcx,%rax,8)
	movsd	16(%rdx,%rax,8), %xmm12
	mulsd	%xmm0, %xmm12
	addsd	16(%rcx,%rax,8), %xmm12
	movsd	%xmm12, 16(%rcx,%rax,8)
	movsd	24(%rdx,%rax,8), %xmm13
	mulsd	%xmm0, %xmm13
	addsd	24(%rcx,%rax,8), %xmm13
	movsd	%xmm13, 24(%rcx,%rax,8)
	movsd	32(%rdx,%rax,8), %xmm14
	mulsd	%xmm0, %xmm14
	addsd	32(%rcx,%rax,8), %xmm14
	movsd	%xmm14, 32(%rcx,%rax,8)
	movsd	40(%rdx,%rax,8), %xmm15
	mulsd	%xmm0, %xmm15
	addsd	40(%rcx,%rax,8), %xmm15
	movsd	%xmm15, 40(%rcx,%rax,8)
	movsd	48(%rdx,%rax,8), %xmm2
	mulsd	%xmm0, %xmm2
	addsd	48(%rcx,%rax,8), %xmm2
	movsd	%xmm2, 48(%rcx,%rax,8)
	movsd	56(%rdx,%rax,8), %xmm3
	mulsd	%xmm0, %xmm3
	addsd	56(%rcx,%rax,8), %xmm3
	movsd	%xmm3, 56(%rcx,%rax,8)
	addq	$8, %rax
	cmpq	%rax, %rsi
	jne	.L6
.L1:
	ret
	.p2align 4,,10
	.p2align 3
.L91:
	movq	%rsi, %r8
	movapd	%xmm0, %xmm1
	shrq	%r8
	unpcklpd	%xmm1, %xmm1
	salq	$4, %r8
	leaq	-16(%r8), %r9
	shrq	$4, %r9
	addq	$1, %r9
	andl	$7, %r9d
	je	.L4
	cmpq	$1, %r9
	je	.L59
	cmpq	$2, %r9
	je	.L60
	cmpq	$3, %r9
	je	.L61
	cmpq	$4, %r9
	je	.L62
	cmpq	$5, %r9
	je	.L63
	cmpq	$6, %r9
	jne	.L94
.L64:
	movupd	(%rdx,%rax), %xmm5
	movupd	(%rcx,%rax), %xmm4
	mulpd	%xmm1, %xmm5
	addpd	%xmm4, %xmm5
	movups	%xmm5, (%rcx,%rax)
	addq	$16, %rax
.L63:
	movupd	(%rdx,%rax), %xmm6
	movupd	(%rcx,%rax), %xmm7
	mulpd	%xmm1, %xmm6
	addpd	%xmm7, %xmm6
	movups	%xmm6, (%rcx,%rax)
	addq	$16, %rax
.L62:
	movupd	(%rdx,%rax), %xmm8
	movupd	(%rcx,%rax), %xmm9
	mulpd	%xmm1, %xmm8
	addpd	%xmm9, %xmm8
	movups	%xmm8, (%rcx,%rax)
	addq	$16, %rax
.L61:
	movupd	(%rdx,%rax), %xmm10
	movupd	(%rcx,%rax), %xmm11
	mulpd	%xmm1, %xmm10
	addpd	%xmm11, %xmm10
	movups	%xmm10, (%rcx,%rax)
	addq	$16, %rax
.L60:
	movupd	(%rdx,%rax), %xmm12
	movupd	(%rcx,%rax), %xmm13
	mulpd	%xmm1, %xmm12
	addpd	%xmm13, %xmm12
	movups	%xmm12, (%rcx,%rax)
	addq	$16, %rax
.L59:
	movupd	(%rdx,%rax), %xmm14
	movupd	(%rcx,%rax), %xmm15
	mulpd	%xmm1, %xmm14
	addpd	%xmm15, %xmm14
	movups	%xmm14, (%rcx,%rax)
	addq	$16, %rax
	cmpq	%rax, %r8
	je	.L89
.L4:
	movupd	(%rdx,%rax), %xmm2
	movupd	(%rcx,%rax), %xmm3
	movupd	16(%rax,%rcx), %xmm4
	movupd	32(%rax,%rcx), %xmm7
	mulpd	%xmm1, %xmm2
	movupd	48(%rax,%rcx), %xmm9
	movupd	64(%rax,%rcx), %xmm11
	movupd	80(%rax,%rcx), %xmm13
	movupd	96(%rax,%rcx), %xmm15
	addpd	%xmm3, %xmm2
	movupd	112(%rax,%rcx), %xmm3
	movups	%xmm2, (%rcx,%rax)
	movupd	16(%rax,%rdx), %xmm5
	subq	$-128, %rax
	mulpd	%xmm1, %xmm5
	addpd	%xmm4, %xmm5
	movups	%xmm5, -112(%rax,%rcx)
	movupd	-96(%rax,%rdx), %xmm6
	mulpd	%xmm1, %xmm6
	addpd	%xmm7, %xmm6
	movups	%xmm6, -96(%rax,%rcx)
	movupd	-80(%rax,%rdx), %xmm8
	mulpd	%xmm1, %xmm8
	addpd	%xmm9, %xmm8
	movups	%xmm8, -80(%rax,%rcx)
	movupd	-64(%rax,%rdx), %xmm10
	mulpd	%xmm1, %xmm10
	addpd	%xmm11, %xmm10
	movups	%xmm10, -64(%rax,%rcx)
	movupd	-48(%rax,%rdx), %xmm12
	mulpd	%xmm1, %xmm12
	addpd	%xmm13, %xmm12
	movups	%xmm12, -48(%rax,%rcx)
	movupd	-32(%rax,%rdx), %xmm14
	mulpd	%xmm1, %xmm14
	addpd	%xmm15, %xmm14
	movups	%xmm14, -32(%rax,%rcx)
	movupd	-16(%rax,%rdx), %xmm2
	mulpd	%xmm1, %xmm2
	addpd	%xmm3, %xmm2
	movups	%xmm2, -16(%rax,%rcx)
	cmpq	%rax, %r8
	jne	.L4
.L89:
	movq	%rsi, %r10
	andq	$-2, %r10
	andl	$1, %esi
	je	.L1
	mulsd	(%rdx,%r10,8), %xmm0
	leaq	(%rcx,%r10,8), %rsi
	addsd	(%rsi), %xmm0
	movsd	%xmm0, (%rsi)
	ret
	.p2align 4,,10
	.p2align 3
.L8:
	xorl	%eax, %eax
	jmp	.L58
	.p2align 4,,10
	.p2align 3
.L92:
	movsd	(%rdx), %xmm1
	movl	$1, %eax
	mulsd	%xmm0, %xmm1
	addsd	(%rcx), %xmm1
	movsd	%xmm1, (%rcx)
	jmp	.L70
.L93:
	ret
.L94:
	movupd	(%rdx), %xmm2
	movupd	(%rcx), %xmm3
	movl	$16, %eax
	mulpd	%xmm1, %xmm2
	addpd	%xmm3, %xmm2
	movups	%xmm2, (%rcx)
	jmp	.L64
	.cfi_endproc
.LFE842:
	.size	_Z15MoveStandardCPPSt4spanIdLm18446744073709551615EES_IKdLm18446744073709551615EEd, .-_Z15MoveStandardCPPSt4spanIdLm18446744073709551615EES_IKdLm18446744073709551615EEd
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
