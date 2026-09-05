main.MoveStandard STEXT nosplit size=78 args=0x38 locals=0x18 funcid=0x0 align=0x0
	0x0000 00000 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:4)	TEXT	main.MoveStandard(SB), NOSPLIT|ABIInternal, $24-56
	0x0000 00000 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:4)	PUSHQ	BP
	0x0001 00001 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:4)	MOVQ	SP, BP
	0x0004 00004 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:4)	SUBQ	$16, SP
	0x0008 00008 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:4)	MOVQ	AX, main.x+32(FP)
	0x000d 00013 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:4)	MOVQ	DI, main.v+56(FP)
	0x0012 00018 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:5)	XORL	CX, CX
	0x0014 00020 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:5)	JMP	43
	0x0016 00022 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:6)	MOVSD	(DI)(CX*8), X2
	0x001b 00027 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:6)	MULSD	X0, X2
	0x001f 00031 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:6)	ADDSD	X2, X1
	0x0023 00035 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:6)	MOVSD	X1, (AX)(CX*8)
	0x0028 00040 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:5)	INCQ	CX
	0x002b 00043 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:5)	CMPQ	BX, CX
	0x002e 00046 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:5)	JLE	60
	0x0030 00048 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:6)	MOVSD	(AX)(CX*8), X1
	0x0035 00053 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:6)	CMPQ	SI, CX
	0x0038 00056 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:6)	JHI	22
	0x003a 00058 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:6)	JMP	66
	0x003c 00060 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:8)	ADDQ	$16, SP
	0x0040 00064 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:8)	POPQ	BP
	0x0041 00065 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:8)	RET
	0x0042 00066 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:6)	MOVQ	CX, AX
	0x0045 00069 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:6)	MOVQ	SI, CX
	0x0048 00072 (/mnt/c/Users/E14/Documents/GitHub/GoPIC/docs/assembly_analysis/loop_unrolling/loop_unroll_demo.go:6)	CALL	runtime.panicIndex(SB)
