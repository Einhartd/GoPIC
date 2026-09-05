TEXT main.scalarLeapFrog(SB) C:/Users/E14/Documents/GitHub/GoPIC/docs/go_simd/generate_profiles.go
func scalarLeapFrog(x, vx []float64, efield []float64, n int) {
  0x1400d4e60		55			PUSHQ BP		
  0x1400d4e61		4889e5			MOVQ SP, BP		
  0x1400d4e64		4889442418		MOVQ AX, 0x18(SP)	
  0x1400d4e69		48897c2430		MOVQ DI, 0x30(SP)	
  0x1400d4e6e		4c894c2448		MOVQ R9, 0x48(SP)	
	for ; k <= n-4; k += 4 {
  0x1400d4e73		488b4c2410		MOVQ 0x10(SP), CX	
  0x1400d4e78		4883c1fc		ADDQ $-0x4, CX		
  0x1400d4e7c		31d2			XORL DX, DX		
  0x1400d4e7e		6690			NOPW			
  0x1400d4e80		eb6f			JMP 0x1400d4ef1		
		vx3 := vx[k+3] - ex3*FACTOR_E
  0x1400d4e82		f20f105cd718		MOVSD_XMM 0x18(DI)(DX*8), X3	
		vx[k] = vx0
  0x1400d4e88		f20f112cd7		MOVSD_XMM X5, 0(DI)(DX*8)	
		vx[k+1] = vx1
  0x1400d4e8d		f20f1144d708		MOVSD_XMM X0, 0x8(DI)(DX*8)	
		vx[k+2] = vx2
  0x1400d4e93		f20f1154d710		MOVSD_XMM X2, 0x10(DI)(DX*8)	
		vx3 := vx[k+3] - ex3*FACTOR_E
  0x1400d4e99		f20f59e6		MULSD X6, X4		
  0x1400d4e9d		f20f5cdc		SUBSD X4, X3		
		vx[k+3] = vx3
  0x1400d4ea1		f20f115cd718		MOVSD_XMM X3, 0x18(DI)(DX*8)	
		x[k] += vx0 * DT_E
  0x1400d4ea7		f20f102569e80000	MOVSD_XMM $f64.3d719799812dea11(SB), X4	
  0x1400d4eaf		f20f59ec		MULSD X4, X5				
  0x1400d4eb3		f20f582cd0		ADDSD 0(AX)(DX*8), X5			
  0x1400d4eb8		f20f112cd0		MOVSD_XMM X5, 0(AX)(DX*8)		
		x[k+1] += vx1 * DT_E
  0x1400d4ebd		f20f59c4		MULSD X4, X0			
  0x1400d4ec1		f20f5844d008		ADDSD 0x8(AX)(DX*8), X0		
  0x1400d4ec7		f20f1144d008		MOVSD_XMM X0, 0x8(AX)(DX*8)	
		x[k+2] += vx2 * DT_E
  0x1400d4ecd		f20f59d4		MULSD X4, X2			
  0x1400d4ed1		f20f5854d010		ADDSD 0x10(AX)(DX*8), X2	
  0x1400d4ed7		f20f1154d010		MOVSD_XMM X2, 0x10(AX)(DX*8)	
		x[k+3] += vx3 * DT_E
  0x1400d4edd		f20f59dc		MULSD X4, X3			
  0x1400d4ee1		f20f585cd018		ADDSD 0x18(AX)(DX*8), X3	
  0x1400d4ee7		f20f115cd018		MOVSD_XMM X3, 0x18(AX)(DX*8)	
	for ; k <= n-4; k += 4 {
  0x1400d4eed		4883c204		ADDQ $0x4, DX		
  0x1400d4ef1		4839ca			CMPQ DX, CX		
  0x1400d4ef4		0f8f1c020000		JG 0x1400d5116		
  0x1400d4efa		660f1f440000		NOPW 0(AX)(AX*1)	
		c0_0 := x[k] * INV_DX
  0x1400d4f00		4839d3			CMPQ BX, DX				
  0x1400d4f03		0f8661020000		JBE 0x1400d516a				
  0x1400d4f09		f20f1004d0		MOVSD_XMM 0(AX)(DX*8), X0		
  0x1400d4f0e		f20f100d2ae80000	MOVSD_XMM $f64.40c3880000000000(SB), X1	
  0x1400d4f16		f20f59c1		MULSD X1, X0				
		p0 := min(max(int(c0_0), 0), N_G-2)
  0x1400d4f1a		f24c0f2cc0		CVTTSD2SIQ X0, R8	
  0x1400d4f1f		90			NOPL			
  0x1400d4f20		4d85c0			TESTQ R8, R8		
  0x1400d4f23		7d03			JGE 0x1400d4f28		
  0x1400d4f25		4531c0			XORL R8, R8		
  0x1400d4f28		4981f88e010000		CMPQ R8, $0x18e		
  0x1400d4f2f		7e06			JLE 0x1400d4f37		
  0x1400d4f31		41b88e010000		MOVL $0x18e, R8		
		d0 := c0_0 - float64(p0)
  0x1400d4f37		0f57d2			XORPS X2, X2		
  0x1400d4f3a		f2490f2ad0		CVTSI2SDQ R8, X2	
  0x1400d4f3f		f20f5cc2		SUBSD X2, X0		
		ex0 := efield[p0] + d0*(efield[p0+1]-efield[p0])
  0x1400d4f43		4d39c2			CMPQ R10, R8			
  0x1400d4f46		0f8619020000		JBE 0x1400d5165			
  0x1400d4f4c		4d8d5801		LEAQ 0x1(R8), R11		
  0x1400d4f50		f2430f1014c1		MOVSD_XMM 0(R9)(R8*8), X2	
  0x1400d4f56		4d39da			CMPQ R10, R11			
  0x1400d4f59		0f86ff010000		JBE 0x1400d515e			
  0x1400d4f5f		f2430f105cc108		MOVSD_XMM 0x8(R9)(R8*8), X3	
  0x1400d4f66		f20f5cda		SUBSD X2, X3			
  0x1400d4f6a		f20f59c3		MULSD X3, X0			
		c0_1 := x[k+1] * INV_DX
  0x1400d4f6e		4c8d4201		LEAQ 0x1(DX), R8	
		ex0 := efield[p0] + d0*(efield[p0+1]-efield[p0])
  0x1400d4f72		f20f58c2		ADDSD X2, X0		
		c0_1 := x[k+1] * INV_DX
  0x1400d4f76		4c39c3			CMPQ BX, R8			
  0x1400d4f79		0f86da010000		JBE 0x1400d5159			
  0x1400d4f7f		f20f1054d008		MOVSD_XMM 0x8(AX)(DX*8), X2	
  0x1400d4f85		f20f59d1		MULSD X1, X2			
		p1 := min(max(int(c0_1), 0), N_G-2)
  0x1400d4f89		f24c0f2cda		CVTTSD2SIQ X2, R11	
  0x1400d4f8e		4d85db			TESTQ R11, R11		
  0x1400d4f91		7d03			JGE 0x1400d4f96		
  0x1400d4f93		4531db			XORL R11, R11		
  0x1400d4f96		4981fb8e010000		CMPQ R11, $0x18e	
  0x1400d4f9d		7e06			JLE 0x1400d4fa5		
  0x1400d4f9f		41bb8e010000		MOVL $0x18e, R11	
		d1 := c0_1 - float64(p1)
  0x1400d4fa5		0f57db			XORPS X3, X3		
  0x1400d4fa8		f2490f2adb		CVTSI2SDQ R11, X3	
  0x1400d4fad		f20f5cd3		SUBSD X3, X2		
		ex1 := efield[p1] + d1*(efield[p1+1]-efield[p1])
  0x1400d4fb1		4d39da			CMPQ R10, R11			
  0x1400d4fb4		0f869a010000		JBE 0x1400d5154			
  0x1400d4fba		4d8d6301		LEAQ 0x1(R11), R12		
  0x1400d4fbe		f2430f101cd9		MOVSD_XMM 0(R9)(R11*8), X3	
  0x1400d4fc4		4d39e2			CMPQ R10, R12			
  0x1400d4fc7		0f8682010000		JBE 0x1400d514f			
  0x1400d4fcd		f2430f1064d908		MOVSD_XMM 0x8(R9)(R11*8), X4	
  0x1400d4fd4		f20f5ce3		SUBSD X3, X4			
  0x1400d4fd8		f20f59d4		MULSD X4, X2			
		c0_2 := x[k+2] * INV_DX
  0x1400d4fdc		4c8d5a02		LEAQ 0x2(DX), R11	
		ex1 := efield[p1] + d1*(efield[p1+1]-efield[p1])
  0x1400d4fe0		f20f58d3		ADDSD X3, X2		
		c0_2 := x[k+2] * INV_DX
  0x1400d4fe4		4c39db			CMPQ BX, R11			
  0x1400d4fe7		0f865d010000		JBE 0x1400d514a			
  0x1400d4fed		f20f105cd010		MOVSD_XMM 0x10(AX)(DX*8), X3	
  0x1400d4ff3		f20f59d9		MULSD X1, X3			
		p2 := min(max(int(c0_2), 0), N_G-2)
  0x1400d4ff7		f24c0f2ce3		CVTTSD2SIQ X3, R12	
  0x1400d4ffc		0f1f4000		NOPL 0(AX)		
  0x1400d5000		4d85e4			TESTQ R12, R12		
  0x1400d5003		7d03			JGE 0x1400d5008		
  0x1400d5005		4531e4			XORL R12, R12		
  0x1400d5008		4981fc8e010000		CMPQ R12, $0x18e	
  0x1400d500f		7e06			JLE 0x1400d5017		
  0x1400d5011		41bc8e010000		MOVL $0x18e, R12	
		d2 := c0_2 - float64(p2)
  0x1400d5017		0f57e4			XORPS X4, X4		
  0x1400d501a		f2490f2ae4		CVTSI2SDQ R12, X4	
  0x1400d501f		f20f5cdc		SUBSD X4, X3		
		ex2 := efield[p2] + d2*(efield[p2+1]-efield[p2])
  0x1400d5023		4d39e2			CMPQ R10, R12			
  0x1400d5026		0f8619010000		JBE 0x1400d5145			
  0x1400d502c		4d8d6c2401		LEAQ 0x1(R12), R13		
  0x1400d5031		f2430f1024e1		MOVSD_XMM 0(R9)(R12*8), X4	
  0x1400d5037		660f1f840000000000	NOPW 0(AX)(AX*1)		
  0x1400d5040		4d39ea			CMPQ R10, R13			
  0x1400d5043		0f86f5000000		JBE 0x1400d513e			
  0x1400d5049		f2430f106ce108		MOVSD_XMM 0x8(R9)(R12*8), X5	
  0x1400d5050		f20f5cec		SUBSD X4, X5			
  0x1400d5054		f20f59dd		MULSD X5, X3			
		c0_3 := x[k+3] * INV_DX
  0x1400d5058		4c8d6203		LEAQ 0x3(DX), R12	
		ex2 := efield[p2] + d2*(efield[p2+1]-efield[p2])
  0x1400d505c		f20f58dc		ADDSD X4, X3		
		c0_3 := x[k+3] * INV_DX
  0x1400d5060		4c39e3			CMPQ BX, R12			
  0x1400d5063		0f86d0000000		JBE 0x1400d5139			
  0x1400d5069		f20f1064d018		MOVSD_XMM 0x18(AX)(DX*8), X4	
  0x1400d506f		f20f59e1		MULSD X1, X4			
		p3 := min(max(int(c0_3), 0), N_G-2)
  0x1400d5073		f24c0f2cec		CVTTSD2SIQ X4, R13	
  0x1400d5078		4d85ed			TESTQ R13, R13		
  0x1400d507b		7d03			JGE 0x1400d5080		
  0x1400d507d		4531ed			XORL R13, R13		
  0x1400d5080		4981fd8e010000		CMPQ R13, $0x18e	
  0x1400d5087		7e06			JLE 0x1400d508f		
  0x1400d5089		41bd8e010000		MOVL $0x18e, R13	
		d3 := c0_3 - float64(p3)
  0x1400d508f		0f57ed			XORPS X5, X5		
  0x1400d5092		f2490f2aed		CVTSI2SDQ R13, X5	
  0x1400d5097		f20f5ce5		SUBSD X5, X4		
  0x1400d509b		0f1f440000		NOPL 0(AX)(AX*1)	
		ex3 := efield[p3] + d3*(efield[p3+1]-efield[p3])
  0x1400d50a0		4d39ea			CMPQ R10, R13			
  0x1400d50a3		0f868b000000		JBE 0x1400d5134			
  0x1400d50a9		4d8d7d01		LEAQ 0x1(R13), R15		
  0x1400d50ad		f2430f102ce9		MOVSD_XMM 0(R9)(R13*8), X5	
  0x1400d50b3		4d39fa			CMPQ R10, R15			
  0x1400d50b6		7677			JBE 0x1400d512f			
  0x1400d50b8		f2430f1074e908		MOVSD_XMM 0x8(R9)(R13*8), X6	
  0x1400d50bf		f20f5cf5		SUBSD X5, X6			
  0x1400d50c3		f20f59e6		MULSD X6, X4			
  0x1400d50c7		f20f58e5		ADDSD X5, X4			
		vx0 := vx[k] - ex0*FACTOR_E
  0x1400d50cb		4839d6			CMPQ SI, DX				
  0x1400d50ce		765a			JBE 0x1400d512a				
  0x1400d50d0		f20f102cd7		MOVSD_XMM 0(DI)(DX*8), X5		
  0x1400d50d5		f20f10354be60000	MOVSD_XMM $f64.3fc6834d2c21a9c5(SB), X6	
  0x1400d50dd		f20f59c6		MULSD X6, X0				
  0x1400d50e1		f20f5ce8		SUBSD X0, X5				
		vx1 := vx[k+1] - ex1*FACTOR_E
  0x1400d50e5		4c39c6			CMPQ SI, R8			
  0x1400d50e8		763b			JBE 0x1400d5125			
  0x1400d50ea		f20f1044d708		MOVSD_XMM 0x8(DI)(DX*8), X0	
  0x1400d50f0		f20f59d6		MULSD X6, X2			
  0x1400d50f4		f20f5cc2		SUBSD X2, X0			
		vx2 := vx[k+2] - ex2*FACTOR_E
  0x1400d50f8		4c39de			CMPQ SI, R11			
  0x1400d50fb		7620			JBE 0x1400d511d			
  0x1400d50fd		f20f1054d710		MOVSD_XMM 0x10(DI)(DX*8), X2	
  0x1400d5103		f20f59de		MULSD X6, X3			
  0x1400d5107		f20f5cd3		SUBSD X3, X2			
		vx3 := vx[k+3] - ex3*FACTOR_E
  0x1400d510b		4c39e6			CMPQ SI, R12		
  0x1400d510e		0f876efdffff		JA 0x1400d4e82		
  0x1400d5114		eb02			JMP 0x1400d5118		
}
  0x1400d5116		5d			POPQ BP			
  0x1400d5117		c3			RET			
		vx3 := vx[k+3] - ex3*FACTOR_E
  0x1400d5118		e803bdfaff		CALL runtime.panicBounds(SB)	
		vx2 := vx[k+2] - ex2*FACTOR_E
  0x1400d511d		0f1f00			NOPL 0(AX)			
  0x1400d5120		e8fbbcfaff		CALL runtime.panicBounds(SB)	
		vx1 := vx[k+1] - ex1*FACTOR_E
  0x1400d5125		e8f6bcfaff		CALL runtime.panicBounds(SB)	
		vx0 := vx[k] - ex0*FACTOR_E
  0x1400d512a		e8f1bcfaff		CALL runtime.panicBounds(SB)	
		ex3 := efield[p3] + d3*(efield[p3+1]-efield[p3])
  0x1400d512f		e8ecbcfaff		CALL runtime.panicBounds(SB)	
  0x1400d5134		e8e7bcfaff		CALL runtime.panicBounds(SB)	
		c0_3 := x[k+3] * INV_DX
  0x1400d5139		e8e2bcfaff		CALL runtime.panicBounds(SB)	
		ex2 := efield[p2] + d2*(efield[p2+1]-efield[p2])
  0x1400d513e		6690			NOPW				
  0x1400d5140		e8dbbcfaff		CALL runtime.panicBounds(SB)	
  0x1400d5145		e8d6bcfaff		CALL runtime.panicBounds(SB)	
		c0_2 := x[k+2] * INV_DX
  0x1400d514a		e8d1bcfaff		CALL runtime.panicBounds(SB)	
		ex1 := efield[p1] + d1*(efield[p1+1]-efield[p1])
  0x1400d514f		e8ccbcfaff		CALL runtime.panicBounds(SB)	
  0x1400d5154		e8c7bcfaff		CALL runtime.panicBounds(SB)	
		c0_1 := x[k+1] * INV_DX
  0x1400d5159		e8c2bcfaff		CALL runtime.panicBounds(SB)	
		ex0 := efield[p0] + d0*(efield[p0+1]-efield[p0])
  0x1400d515e		6690			NOPW				
  0x1400d5160		e8bbbcfaff		CALL runtime.panicBounds(SB)	
  0x1400d5165		e8b6bcfaff		CALL runtime.panicBounds(SB)	
		c0_0 := x[k] * INV_DX
  0x1400d516a		e8b1bcfaff		CALL runtime.panicBounds(SB)	
  0x1400d516f		90			NOPL				

  0x1400d5170		cc			INT $0x3		
  0x1400d5171		cc			INT $0x3		
  0x1400d5172		cc			INT $0x3		
  0x1400d5173		cc			INT $0x3		
  0x1400d5174		cc			INT $0x3		
  0x1400d5175		cc			INT $0x3		
  0x1400d5176		cc			INT $0x3		
  0x1400d5177		cc			INT $0x3		
  0x1400d5178		cc			INT $0x3		
  0x1400d5179		cc			INT $0x3		
  0x1400d517a		cc			INT $0x3		
  0x1400d517b		cc			INT $0x3		
  0x1400d517c		cc			INT $0x3		
  0x1400d517d		cc			INT $0x3		
  0x1400d517e		cc			INT $0x3		
  0x1400d517f		cc			INT $0x3		
