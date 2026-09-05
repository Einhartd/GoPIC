TEXT main.simdLeapFrog@simd256(SB) C:/Users/E14/Documents/GitHub/GoPIC/docs/go_simd/generate_profiles.go
func simdLeapFrog(x, vx []float64, efield []float64, n int) {
  0x1400d5ca0		55			PUSHQ BP		
  0x1400d5ca1		4889e5			MOVQ SP, BP		
  0x1400d5ca4		4883ec20		SUBQ $0x20, SP		
  0x1400d5ca8		4889442438		MOVQ AX, 0x38(SP)	
  0x1400d5cad		48897c2450		MOVQ DI, 0x50(SP)	
  0x1400d5cb2		4c894c2468		MOVQ R9, 0x68(SP)	
	vNegFactor := simd.BroadcastFloat64s(-FACTOR_E)
  0x1400d5cb7		90			NOPL			
	vDt := simd.BroadcastFloat64s(DT_E)
  0x1400d5cb8		90			NOPL			
	for ; k <= n-4; k += 4 {
  0x1400d5cb9		488b542430		MOVQ 0x30(SP), DX	
  0x1400d5cbe		4883c2fc		ADDQ $-0x4, DX		
	return Float64x4(archsimd.BroadcastFloat64x4(x))
  0x1400d5cc2		90			NOPL			
  0x1400d5cc3		90			NOPL			
	var exArr [4]float64
  0x1400d5cc4		488d3424		LEAQ 0(SP), SI		
  0x1400d5cc8		440f113e		MOVUPS X15, 0(SI)	
  0x1400d5ccc		440f117e10		MOVUPS X15, 0x10(SI)	
	return z.SetElem(0, x).broadcast1To4()
  0x1400d5cd1		c5fb100577da0000	VMOVSD 0xda77, X0	
  0x1400d5cd9		c4e27d19c0		VBROADCASTSD X0, Y0	
  0x1400d5cde		c5fb100d32da0000	VMOVSD 0xda32, X1	
  0x1400d5ce6		c4e27d19c9		VBROADCASTSD X1, Y1	
	for ; k <= n-4; k += 4 {
  0x1400d5ceb		31f6			XORL SI, SI		
  0x1400d5ced		eb31			JMP 0x1400d5d20		
	return LoadFloat64x4Array((*[4]float64)(s))
  0x1400d5cef		c5fe6f1424		VMOVDQU 0(SP), Y2	
  0x1400d5cf4		c5fe6f26		VMOVDQU 0(SI), Y4	
	return Float64x4((archsimd.Float64x4(x)).MulAdd(archsimd.Float64x4(y), archsimd.Float64x4(z)))
  0x1400d5cf8		c4e2fda8d4		VFMADD213PD Y4, Y0, Y2		
  0x1400d5cfd		c5fe7fd4		VMOVDQU Y2, Y4			
  0x1400d5d01		c4c2f5a81424		VFMADD213PD 0(R12), Y1, Y2	
		vVxNew := vEx.MulAdd(vNegFactor, vVx)
  0x1400d5d07		90			NOPL			
		vXNew := vVxNew.MulAdd(vDt, vX)
  0x1400d5d08		90			NOPL			
		vVxNew.Store(vx[k : k+4])
  0x1400d5d09		90			NOPL			
	(archsimd.Float64x4(x)).Store(s)
  0x1400d5d0a		90			NOPL			
	x.StoreArray((*[4]float64)(s))
  0x1400d5d0b		c5fe7f26		VMOVDQU Y4, 0(SI)	
		vXNew.Store(x[k : k+4])
  0x1400d5d0f		90			NOPL			
	(archsimd.Float64x4(x)).Store(s)
  0x1400d5d10		90			NOPL			
	x.StoreArray((*[4]float64)(s))
  0x1400d5d11		c4c17e7f1424		VMOVDQU Y2, 0(R12)	
	for ; k <= n-4; k += 4 {
  0x1400d5d17		4c89de			MOVQ R11, SI		
  0x1400d5d1a		660f1f440000		NOPW 0(AX)(AX*1)	
  0x1400d5d20		4839d6			CMPQ SI, DX		
  0x1400d5d23		0f8f19020000		JG 0x1400d5f42		
		c0_0 := x[k] * INV_DX
  0x1400d5d29		4839f3			CMPQ BX, SI				
  0x1400d5d2c		0f865d020000		JBE 0x1400d5f8f				
  0x1400d5d32		f20f1014f0		MOVSD_XMM 0(AX)(SI*8), X2		
  0x1400d5d37		f20f101d01da0000	MOVSD_XMM $f64.40c3880000000000(SB), X3	
  0x1400d5d3f		f20f59d3		MULSD X3, X2				
		p0 := min(max(int(c0_0), 0), N_G-2)
  0x1400d5d43		f24c0f2cda		CVTTSD2SIQ X2, R11	
		c0_0 := x[k] * INV_DX
  0x1400d5d48		4c8d24f0		LEAQ 0(AX)(SI*8), R12	
		p0 := min(max(int(c0_0), 0), N_G-2)
  0x1400d5d4c		4d85db			TESTQ R11, R11		
  0x1400d5d4f		7d03			JGE 0x1400d5d54		
  0x1400d5d51		4531db			XORL R11, R11		
  0x1400d5d54		4981fb8e010000		CMPQ R11, $0x18e	
  0x1400d5d5b		7e06			JLE 0x1400d5d63		
  0x1400d5d5d		41bb8e010000		MOVL $0x18e, R11	
		c1_0 := float64(p0) + 1.0 - c0_0
  0x1400d5d63		0f57e4			XORPS X4, X4				
  0x1400d5d66		f2490f2ae3		CVTSI2SDQ R11, X4			
  0x1400d5d6b		f20f102dc5d90000	MOVSD_XMM $f64.3ff0000000000000(SB), X5	
  0x1400d5d73		f20f58ec		ADDSD X4, X5				
  0x1400d5d77		f20f5cea		SUBSD X2, X5				
		c2_0 := c0_0 - float64(p0)
  0x1400d5d7b		f20f5cd4		SUBSD X4, X2		
  0x1400d5d7f		90			NOPL			
		exArr[0] = c1_0*efield[p0] + c2_0*efield[p0+1]
  0x1400d5d80		4d39da			CMPQ R10, R11			
  0x1400d5d83		0f8601020000		JBE 0x1400d5f8a			
  0x1400d5d89		4d8d6b01		LEAQ 0x1(R11), R13		
  0x1400d5d8d		f2430f592cd9		MULSD 0(R9)(R11*8), X5		
  0x1400d5d93		4d39ea			CMPQ R10, R13			
  0x1400d5d96		0f86e9010000		JBE 0x1400d5f85			
  0x1400d5d9c		f2430f5954d908		MULSD 0x8(R9)(R11*8), X2	
  0x1400d5da3		f20f58d5		ADDSD X5, X2			
  0x1400d5da7		f20f111424		MOVSD_XMM X2, 0(SP)		
		c0_1 := x[k+1] * INV_DX
  0x1400d5dac		4c8d5e01		LEAQ 0x1(SI), R11		
  0x1400d5db0		4c39db			CMPQ BX, R11			
  0x1400d5db3		0f86c5010000		JBE 0x1400d5f7e			
  0x1400d5db9		f20f1054f008		MOVSD_XMM 0x8(AX)(SI*8), X2	
  0x1400d5dbf		f20f59d3		MULSD X3, X2			
		p1 := min(max(int(c0_1), 0), N_G-2)
  0x1400d5dc3		f24c0f2cda		CVTTSD2SIQ X2, R11	
  0x1400d5dc8		4d85db			TESTQ R11, R11		
  0x1400d5dcb		7d03			JGE 0x1400d5dd0		
  0x1400d5dcd		4531db			XORL R11, R11		
  0x1400d5dd0		4981fb8e010000		CMPQ R11, $0x18e	
  0x1400d5dd7		7e06			JLE 0x1400d5ddf		
  0x1400d5dd9		41bb8e010000		MOVL $0x18e, R11	
		c1_1 := float64(p1) + 1.0 - c0_1
  0x1400d5ddf		0f57e4			XORPS X4, X4				
  0x1400d5de2		f2490f2ae3		CVTSI2SDQ R11, X4			
  0x1400d5de7		f20f102d49d90000	MOVSD_XMM $f64.3ff0000000000000(SB), X5	
  0x1400d5def		f20f58ec		ADDSD X4, X5				
  0x1400d5df3		f20f5cea		SUBSD X2, X5				
		c2_1 := c0_1 - float64(p1)
  0x1400d5df7		f20f5cd4		SUBSD X4, X2		
  0x1400d5dfb		0f1f440000		NOPL 0(AX)(AX*1)	
		exArr[1] = c1_1*efield[p1] + c2_1*efield[p1+1]
  0x1400d5e00		4d39da			CMPQ R10, R11			
  0x1400d5e03		0f8670010000		JBE 0x1400d5f79			
  0x1400d5e09		4d8d6b01		LEAQ 0x1(R11), R13		
  0x1400d5e0d		f2430f592cd9		MULSD 0(R9)(R11*8), X5		
  0x1400d5e13		4d39ea			CMPQ R10, R13			
  0x1400d5e16		0f8658010000		JBE 0x1400d5f74			
  0x1400d5e1c		f2430f5954d908		MULSD 0x8(R9)(R11*8), X2	
  0x1400d5e23		f20f58d5		ADDSD X5, X2			
  0x1400d5e27		f20f11542408		MOVSD_XMM X2, 0x8(SP)		
		c0_2 := x[k+2] * INV_DX
  0x1400d5e2d		4c8d5e02		LEAQ 0x2(SI), R11		
  0x1400d5e31		4c39db			CMPQ BX, R11			
  0x1400d5e34		0f8635010000		JBE 0x1400d5f6f			
  0x1400d5e3a		f20f1054f010		MOVSD_XMM 0x10(AX)(SI*8), X2	
  0x1400d5e40		f20f59d3		MULSD X3, X2			
		p2 := min(max(int(c0_2), 0), N_G-2)
  0x1400d5e44		f24c0f2cda		CVTTSD2SIQ X2, R11	
  0x1400d5e49		4d85db			TESTQ R11, R11		
  0x1400d5e4c		7d03			JGE 0x1400d5e51		
  0x1400d5e4e		4531db			XORL R11, R11		
  0x1400d5e51		4981fb8e010000		CMPQ R11, $0x18e	
  0x1400d5e58		7e06			JLE 0x1400d5e60		
  0x1400d5e5a		41bb8e010000		MOVL $0x18e, R11	
		c1_2 := float64(p2) + 1.0 - c0_2
  0x1400d5e60		0f57e4			XORPS X4, X4				
  0x1400d5e63		f2490f2ae3		CVTSI2SDQ R11, X4			
  0x1400d5e68		f20f102dc8d80000	MOVSD_XMM $f64.3ff0000000000000(SB), X5	
  0x1400d5e70		f20f58ec		ADDSD X4, X5				
  0x1400d5e74		f20f5cea		SUBSD X2, X5				
		c2_2 := c0_2 - float64(p2)
  0x1400d5e78		f20f5cd4		SUBSD X4, X2		
  0x1400d5e7c		0f1f4000		NOPL 0(AX)		
		exArr[2] = c1_2*efield[p2] + c2_2*efield[p2+1]
  0x1400d5e80		4d39da			CMPQ R10, R11			
  0x1400d5e83		0f86e1000000		JBE 0x1400d5f6a			
  0x1400d5e89		4d8d6b01		LEAQ 0x1(R11), R13		
  0x1400d5e8d		f2430f592cd9		MULSD 0(R9)(R11*8), X5		
  0x1400d5e93		4d39ea			CMPQ R10, R13			
  0x1400d5e96		0f86c9000000		JBE 0x1400d5f65			
  0x1400d5e9c		f2430f5954d908		MULSD 0x8(R9)(R11*8), X2	
  0x1400d5ea3		f20f58d5		ADDSD X5, X2			
  0x1400d5ea7		f20f11542410		MOVSD_XMM X2, 0x10(SP)		
		c0_3 := x[k+3] * INV_DX
  0x1400d5ead		4c8d5e03		LEAQ 0x3(SI), R11		
  0x1400d5eb1		4c39db			CMPQ BX, R11			
  0x1400d5eb4		0f86a2000000		JBE 0x1400d5f5c			
  0x1400d5eba		f20f1054f018		MOVSD_XMM 0x18(AX)(SI*8), X2	
  0x1400d5ec0		f20f59d3		MULSD X3, X2			
		p3 := min(max(int(c0_3), 0), N_G-2)
  0x1400d5ec4		f24c0f2cda		CVTTSD2SIQ X2, R11	
  0x1400d5ec9		4d85db			TESTQ R11, R11		
  0x1400d5ecc		7d03			JGE 0x1400d5ed1		
  0x1400d5ece		4531db			XORL R11, R11		
  0x1400d5ed1		4981fb8e010000		CMPQ R11, $0x18e	
  0x1400d5ed8		7e06			JLE 0x1400d5ee0		
  0x1400d5eda		41bb8e010000		MOVL $0x18e, R11	
		c1_3 := float64(p3) + 1.0 - c0_3
  0x1400d5ee0		0f57e4			XORPS X4, X4				
  0x1400d5ee3		f2490f2ae3		CVTSI2SDQ R11, X4			
  0x1400d5ee8		f20f102d48d80000	MOVSD_XMM $f64.3ff0000000000000(SB), X5	
  0x1400d5ef0		f20f58ec		ADDSD X4, X5				
  0x1400d5ef4		f20f5cea		SUBSD X2, X5				
		c2_3 := c0_3 - float64(p3)
  0x1400d5ef8		f20f5cd4		SUBSD X4, X2		
  0x1400d5efc		0f1f4000		NOPL 0(AX)		
		exArr[3] = c1_3*efield[p3] + c2_3*efield[p3+1]
  0x1400d5f00		4d39da			CMPQ R10, R11			
  0x1400d5f03		7652			JBE 0x1400d5f57			
  0x1400d5f05		4d8d6b01		LEAQ 0x1(R11), R13		
  0x1400d5f09		f2430f592cd9		MULSD 0(R9)(R11*8), X5		
  0x1400d5f0f		4d39ea			CMPQ R10, R13			
  0x1400d5f12		763e			JBE 0x1400d5f52			
  0x1400d5f14		f2430f5954d908		MULSD 0x8(R9)(R11*8), X2	
  0x1400d5f1b		f20f58d5		ADDSD X5, X2			
  0x1400d5f1f		f20f11542418		MOVSD_XMM X2, 0x18(SP)		
		vVx := simd.LoadFloat64s(vx[k : k+4])
  0x1400d5f25		4c8d5e04		LEAQ 0x4(SI), R11	
		vEx := simd.LoadFloat64s(exArr[:4])
  0x1400d5f29		90			NOPL			
	return Float64x4(archsimd.LoadFloat64x4(s))
  0x1400d5f2a		90			NOPL			
		vVx := simd.LoadFloat64s(vx[k : k+4])
  0x1400d5f2b		4d39d8			CMPQ R8, R11		
  0x1400d5f2e		721d			JB 0x1400d5f4d		
  0x1400d5f30		488d34f7		LEAQ 0(DI)(SI*8), SI	
	return Float64x4(archsimd.LoadFloat64x4(s))
  0x1400d5f34		90			NOPL			
		vX := simd.LoadFloat64s(x[k : k+4])
  0x1400d5f35		4c39d9			CMPQ CX, R11		
  0x1400d5f38		0f83b1fdffff		JAE 0x1400d5cef		
  0x1400d5f3e		6690			NOPW			
  0x1400d5f40		eb06			JMP 0x1400d5f48		
}
  0x1400d5f42		4883c420		ADDQ $0x20, SP		
  0x1400d5f46		5d			POPQ BP			
  0x1400d5f47		c3			RET			
		vX := simd.LoadFloat64s(x[k : k+4])
  0x1400d5f48		e8d3aefaff		CALL runtime.panicBounds(SB)	
		vVx := simd.LoadFloat64s(vx[k : k+4])
  0x1400d5f4d		e8ceaefaff		CALL runtime.panicBounds(SB)	
		exArr[3] = c1_3*efield[p3] + c2_3*efield[p3+1]
  0x1400d5f52		e8c9aefaff		CALL runtime.panicBounds(SB)	
  0x1400d5f57		e8c4aefaff		CALL runtime.panicBounds(SB)	
		c0_3 := x[k+3] * INV_DX
  0x1400d5f5c		0f1f4000		NOPL 0(AX)			
  0x1400d5f60		e8bbaefaff		CALL runtime.panicBounds(SB)	
		exArr[2] = c1_2*efield[p2] + c2_2*efield[p2+1]
  0x1400d5f65		e8b6aefaff		CALL runtime.panicBounds(SB)	
  0x1400d5f6a		e8b1aefaff		CALL runtime.panicBounds(SB)	
		c0_2 := x[k+2] * INV_DX
  0x1400d5f6f		e8acaefaff		CALL runtime.panicBounds(SB)	
		exArr[1] = c1_1*efield[p1] + c2_1*efield[p1+1]
  0x1400d5f74		e8a7aefaff		CALL runtime.panicBounds(SB)	
  0x1400d5f79		e8a2aefaff		CALL runtime.panicBounds(SB)	
		c0_1 := x[k+1] * INV_DX
  0x1400d5f7e		6690			NOPW				
  0x1400d5f80		e89baefaff		CALL runtime.panicBounds(SB)	
		exArr[0] = c1_0*efield[p0] + c2_0*efield[p0+1]
  0x1400d5f85		e896aefaff		CALL runtime.panicBounds(SB)	
  0x1400d5f8a		e891aefaff		CALL runtime.panicBounds(SB)	
		c0_0 := x[k] * INV_DX
  0x1400d5f8f		e88caefaff		CALL runtime.panicBounds(SB)	
  0x1400d5f94		90			NOPL				

  0x1400d5f95		cc			INT $0x3		
  0x1400d5f96		cc			INT $0x3		
  0x1400d5f97		cc			INT $0x3		
  0x1400d5f98		cc			INT $0x3		
  0x1400d5f99		cc			INT $0x3		
  0x1400d5f9a		cc			INT $0x3		
  0x1400d5f9b		cc			INT $0x3		
  0x1400d5f9c		cc			INT $0x3		
  0x1400d5f9d		cc			INT $0x3		
  0x1400d5f9e		cc			INT $0x3		
  0x1400d5f9f		cc			INT $0x3		
