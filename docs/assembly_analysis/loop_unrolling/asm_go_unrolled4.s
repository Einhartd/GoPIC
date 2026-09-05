main.MoveUnrolled4 STEXT nosplit size=393 args=0x38 locals=0x18 funcid=0x0 align=0x0
	0x0000 00000 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:11)	TEXT	main.MoveUnrolled4(SB), NOSPLIT|ABIInternal, $24-56
	0x0000 00000 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:11)	PUSHQ	BP
	0x0001 00001 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:11)	MOVQ	SP, BP
	0x0004 00004 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:11)	SUBQ	$16, SP
	0x0008 00008 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:11)	MOVQ	AX, main.x+32(FP)
	0x000d 00013 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:11)	MOVQ	DI, main.v+56(FP)
	0x0012 00018 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:14)	XORL	CX, CX
	0x0014 00020 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:14)	JMP	46
	0x0016 00022 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:18)	MOVSD	24(DI)(CX*8), X2
	0x001c 00028 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:18)	MULSD	X0, X2
	0x0020 00032 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:18)	ADDSD	X1, X2
	0x0024 00036 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:18)	MOVSD	X2, 24(AX)(CX*8)
	0x002a 00042 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:14)	ADDQ	$4, CX
	0x002e 00046 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:14)	LEAQ	3(CX), DX
	0x0032 00050 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:14)	CMPQ	BX, DX
	0x0035 00053 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:14)	JLE	256
	0x0040 00064 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:15)	CMPQ	BX, CX
	0x0049 00073 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:15)	MOVSD	(AX)(CX*8), X1
	0x0057 00087 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:15)	MOVSD	(DI)(CX*8), X2
	0x005c 00092 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:15)	MULSD	X0, X2
	0x0060 00096 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:15)	ADDSD	X1, X2
	0x0064 00100 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:15)	MOVSD	X2, (AX)(CX*8)
	0x0069 00105 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:16)	LEAQ	1(CX), R8
	0x0076 00118 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:16)	MOVSD	8(AX)(CX*8), X1
	0x0089 00137 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:16)	MOVSD	8(DI)(CX*8), X2
	0x008f 00143 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:16)	MULSD	X0, X2
	0x0093 00147 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:16)	ADDSD	X1, X2
	0x0097 00151 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:16)	MOVSD	X2, 8(AX)(CX*8)
	0x009d 00157 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:17)	LEAQ	2(CX), R8
	0x00aa 00170 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:17)	MOVSD	16(AX)(CX*8), X1
	0x00b9 00185 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:17)	MOVSD	16(DI)(CX*8), X2
	0x00bf 00191 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:17)	MULSD	X0, X2
	0x00c3 00195 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:17)	ADDSD	X1, X2
	0x00c7 00199 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:17)	MOVSD	X2, 16(AX)(CX*8)
	0x00d2 00210 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:18)	MOVSD	24(AX)(CX*8), X1
	0x00e0 00224 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:18)	CMPQ	SI, DX
	0x00e3 00227 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:18)	JHI	22
