// =============================================================================
// SYMBOL: CollisionIon
// =============================================================================

TEXT gopic.(*SimulationState).CollisionIon(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/collisions.go
func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int, workerID int) {
  0x1400be380		4c8d6424d8		LEAQ -0x28(SP), R12	
  0x1400be385		4d3b6610		CMPQ R12, 0x10(R14)	
  0x1400be389		0f8604040000		JBE 0x1400be793		
  0x1400be38f		55			PUSHQ BP		
  0x1400be390		4889e5			MOVQ SP, BP		
  0x1400be393		4881eca0000000		SUBQ $0xa0, SP		
	t1 := sim.Sigma[I_ISO][e_index]
  0x1400be39a		8400			TESTB AL, 0(AX)				
  0x1400be39c		0f1f4000		NOPL 0(AX)				
  0x1400be3a0		4981fa40420f00		CMPQ R10, $0xf4240			
  0x1400be3a7		0f83db030000		JAE 0x1400be788				
  0x1400be3ad		48898424b0000000	MOVQ AX, 0xb0(SP)			
  0x1400be3b5		48899c24b8000000	MOVQ BX, 0xb8(SP)			
  0x1400be3bd		48898c24c0000000	MOVQ CX, 0xc0(SP)			
  0x1400be3c5		4889bc24c8000000	MOVQ DI, 0xc8(SP)			
  0x1400be3cd		4889b424d0000000	MOVQ SI, 0xd0(SP)			
  0x1400be3d5		4c898424d8000000	MOVQ R8, 0xd8(SP)			
  0x1400be3dd		4c898c24e0000000	MOVQ R9, 0xe0(SP)			
  0x1400be3e5		4c899c24f0000000	MOVQ R11, 0xf0(SP)			
  0x1400be3ed		f2420f1084d0c0366e01	MOVSD_XMM 0x16e36c0(AX)(R10*8), X0	
  0x1400be3f7		f20f11442430		MOVSD_XMM X0, 0x30(SP)			
	t2 := t1 + sim.Sigma[I_BACK][e_index]
  0x1400be3fd		f2420f1084d0c048e801	MOVSD_XMM 0x1e848c0(AX)(R10*8), X0	
  0x1400be407		f20f11842498000000	MOVSD_XMM X0, 0x98(SP)			
	rnd := sim.WorkerR01(workerID)
  0x1400be410		4c89db			MOVQ R11, BX					
  0x1400be413		e8e8750000		CALL gopic.(*SimulationState).WorkerR01(SB)	
	t2 := t1 + sim.Sigma[I_BACK][e_index]
  0x1400be418		f20f108c2498000000	MOVSD_XMM 0x98(SP), X1	
  0x1400be421		f20f10542430		MOVSD_XMM 0x30(SP), X2	
  0x1400be427		f20f58ca		ADDSD X2, X1		
	if rnd*t2 >= t1 {
  0x1400be42b		f20f59c1		MULSD X1, X0		
  0x1400be42f		660f2ec2		UCOMISD X2, X0		
  0x1400be433		0f83fe020000		JAE 0x1400be737		
	gx := (*vx_1) - (*vx_2)
  0x1400be439		488b8c24b8000000	MOVQ 0xb8(SP), CX	
  0x1400be441		f20f1001		MOVSD_XMM 0(CX), X0	
  0x1400be445		488b9424d0000000	MOVQ 0xd0(SP), DX	
  0x1400be44d		f20f100a		MOVSD_XMM 0(DX), X1	
  0x1400be451		0f10d0			MOVUPS X0, X2		
  0x1400be454		f20f5cc1		SUBSD X1, X0		
	gy := (*vy_1) - (*vy_2)
  0x1400be458		488b9424c0000000	MOVQ 0xc0(SP), DX	
  0x1400be460		f20f101a		MOVSD_XMM 0(DX), X3	
  0x1400be464		488bb424d8000000	MOVQ 0xd8(SP), SI	
  0x1400be46c		f20f1026		MOVSD_XMM 0(SI), X4	
  0x1400be470		0f10eb			MOVUPS X3, X5		
  0x1400be473		f20f5cdc		SUBSD X4, X3		
	gz := (*vz_1) - (*vz_2)
  0x1400be477		488bb424c8000000	MOVQ 0xc8(SP), SI	
  0x1400be47f		f20f1036		MOVSD_XMM 0(SI), X6	
	wx := 0.5 * ((*vx_1) + (*vx_2))
  0x1400be483		f20f58d1		ADDSD X1, X2		
	wy := 0.5 * ((*vy_1) + (*vy_2))
  0x1400be487		f20f58e5		ADDSD X5, X4		
	gz := (*vz_1) - (*vz_2)
  0x1400be48b		488bbc24e0000000	MOVQ 0xe0(SP), DI	
  0x1400be493		f20f100f		MOVSD_XMM 0(DI), X1	
  0x1400be497		0f10ee			MOVUPS X6, X5		
  0x1400be49a		f20f5cf1		SUBSD X1, X6		
	g_perp_sq := gy*gy + gz*gz
  0x1400be49e		0f10fe			MOVUPS X6, X7		
  0x1400be4a1		f20f59f6		MULSD X6, X6		
  0x1400be4a5		c4e2e1b9f3		VFMADD231SD X3, X3, X6	
	g_sq := gx*gx + g_perp_sq
  0x1400be4aa		440f10c6		MOVUPS X6, X8		
  0x1400be4ae		c4e2f9b9f0		VFMADD231SD X0, X0, X6	
	wz := 0.5 * ((*vz_1) + (*vz_2))
  0x1400be4b3		f20f58cd		ADDSD X5, X1		
	return sqrt(x)
  0x1400be4b7		f20f51ee		SQRTSD X6, X5		
	g := math.Sqrt(g_sq)
  0x1400be4bb		90			NOPL			
	g_perp := math.Sqrt(g_perp_sq)
  0x1400be4bc		90			NOPL			
	wx := 0.5 * ((*vx_1) + (*vx_2))
  0x1400be4bd		f20f1035337d0100	MOVSD_XMM $f64.3fe0000000000000(SB), X6	
  0x1400be4c5		f20f59d6		MULSD X6, X2				
	wy := 0.5 * ((*vy_1) + (*vy_2))
  0x1400be4c9		f20f59e6		MULSD X6, X4		
	wz := 0.5 * ((*vz_1) + (*vz_2))
  0x1400be4cd		f20f59ce		MULSD X6, X1		
	return sqrt(x)
  0x1400be4d1		f2410f51f0		SQRTSD X8, X6		
	if g > 0.0 {
  0x1400be4d6		450f57c0		XORPS X8, X8		
  0x1400be4da		66410f2ee8		UCOMISD X8, X5		
  0x1400be4df		90			NOPL			
  0x1400be4e0		760e			JBE 0x1400be4f0		
		ct = gx / g
  0x1400be4e2		f20f5ec5		DIVSD X5, X0		
		st = g_perp / g
  0x1400be4e6		440f10ce		MOVUPS X6, X9		
  0x1400be4ea		f20f5ef5		DIVSD X5, X6		
  0x1400be4ee		eb0f			JMP 0x1400be4ff		
	if g_perp > 0.0 {
  0x1400be4f0		440f10ce		MOVUPS X6, X9				
  0x1400be4f4		0f57f6			XORPS X6, X6				
  0x1400be4f7		f20f1005117d0100	MOVSD_XMM $f64.3ff0000000000000(SB), X0	
	return sqrt(x)
  0x1400be4ff		f20f116c2410		MOVSD_XMM X5, 0x10(SP)	
	wx := 0.5 * ((*vx_1) + (*vx_2))
  0x1400be505		f20f11542428		MOVSD_XMM X2, 0x28(SP)	
	wy := 0.5 * ((*vy_1) + (*vy_2))
  0x1400be50b		f20f11642420		MOVSD_XMM X4, 0x20(SP)	
	wz := 0.5 * ((*vz_1) + (*vz_2))
  0x1400be511		f20f114c2418		MOVSD_XMM X1, 0x18(SP)	
	if g_perp > 0.0 {
  0x1400be517		f20f11742438		MOVSD_XMM X6, 0x38(SP)	
  0x1400be51d		f20f11442448		MOVSD_XMM X0, 0x48(SP)	
  0x1400be523		66450f2ec8		UCOMISD X8, X9		
  0x1400be528		760c			JBE 0x1400be536		
		cp = gy / g_perp
  0x1400be52a		f2410f5ed9		DIVSD X9, X3		
		sp = gz / g_perp
  0x1400be52f		f2410f5ef9		DIVSD X9, X7				
  0x1400be534		eb0b			JMP 0x1400be541				
  0x1400be536		f20f101dd27c0100	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x1400be53e		0f57ff			XORPS X7, X7				
	cc := 1.0 - 2.0*sim.WorkerR01(workerID)
  0x1400be541		f20f117c2440		MOVSD_XMM X7, 0x40(SP)				
  0x1400be547		f20f115c2450		MOVSD_XMM X3, 0x50(SP)				
  0x1400be54d		488b8424b0000000	MOVQ 0xb0(SP), AX				
  0x1400be555		488b9c24f0000000	MOVQ 0xf0(SP), BX				
  0x1400be55d		0f1f00			NOPL 0(AX)					
  0x1400be560		e89b740000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400be565		f20f58c0		ADDSD X0, X0					
  0x1400be569		f20f100d9f7c0100	MOVSD_XMM $f64.3ff0000000000000(SB), X1		
  0x1400be571		f20f5cc8		SUBSD X0, X1					
  0x1400be575		f20f114c2458		MOVSD_XMM X1, 0x58(SP)				
	sc := math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400be57b		0f57c0			XORPS X0, X0				
  0x1400be57e		f20f1015c27d0100	MOVSD_XMM $f64.8000000000000000(SB), X2	
  0x1400be586		660fefc2		PXOR X2, X0				
  0x1400be58a		0f10d9			MOVUPS X1, X3				
  0x1400be58d		f20f59c9		MULSD X1, X1				
  0x1400be591		f20f1025777c0100	MOVSD_XMM $f64.3ff0000000000000(SB), X4	
  0x1400be599		f20f5ce1		SUBSD X1, X4				
  0x1400be59d		660fefe2		PXOR X2, X4				
  0x1400be5a1		0f10c8			MOVUPS X0, X1				
  0x1400be5a4		f20f5dc4		MINSD X4, X0				
  0x1400be5a8		0f10e0			MOVUPS X0, X4				
  0x1400be5ab		f20f5dc1		MINSD X1, X0				
  0x1400be5af		660febc4		POR X4, X0				
  0x1400be5b3		660fefc2		PXOR X2, X0				
	gx = g * (ct*cc - st*sc*ce)
  0x1400be5b7		f20f104c2448		MOVSD_XMM 0x48(SP), X1	
  0x1400be5bd		f20f59d9		MULSD X1, X3		
  0x1400be5c1		f20f119c2498000000	MOVSD_XMM X3, 0x98(SP)	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400be5ca		f20f10542438		MOVSD_XMM 0x38(SP), X2	
  0x1400be5d0		f20f105c2450		MOVSD_XMM 0x50(SP), X3	
  0x1400be5d6		0f10e2			MOVUPS X2, X4		
  0x1400be5d9		f20f59d3		MULSD X3, X2		
  0x1400be5dd		f20f11942490000000	MOVSD_XMM X2, 0x90(SP)	
  0x1400be5e6		0f10d1			MOVUPS X1, X2		
  0x1400be5e9		f20f59cb		MULSD X3, X1		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x1400be5ed		f20f106c2440		MOVSD_XMM 0x40(SP), X5	
  0x1400be5f3		0f10f4			MOVUPS X4, X6		
  0x1400be5f6		f20f59e5		MULSD X5, X4		
  0x1400be5fa		f20f11a42488000000	MOVSD_XMM X4, 0x88(SP)	
  0x1400be603		f20f59d5		MULSD X5, X2		
	return sqrt(x)
  0x1400be607		f20f51c0		SQRTSD X0, X0		
	gx = g * (ct*cc - st*sc*ce)
  0x1400be60b		f20f59f0		MULSD X0, X6		
  0x1400be60f		f20f11b42480000000	MOVSD_XMM X6, 0x80(SP)	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400be618		f20f59c8		MULSD X0, X1		
  0x1400be61c		f20f114c2478		MOVSD_XMM X1, 0x78(SP)	
  0x1400be622		f20f59e8		MULSD X0, X5		
  0x1400be626		f20f116c2470		MOVSD_XMM X5, 0x70(SP)	
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x1400be62c		f20f59d0		MULSD X0, X2		
  0x1400be630		f20f11542468		MOVSD_XMM X2, 0x68(SP)	
  0x1400be636		f20f59d8		MULSD X0, X3		
  0x1400be63a		f20f115c2460		MOVSD_XMM X3, 0x60(SP)	
	eta := TWO_PI * sim.WorkerR01(workerID)
  0x1400be640		488b8424b0000000	MOVQ 0xb0(SP), AX				
  0x1400be648		488b9c24f0000000	MOVQ 0xf0(SP), BX				
  0x1400be650		e8ab730000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400be655		f20f100d2b7c0100	MOVSD_XMM $f64.401921fb54442d18(SB), X1		
  0x1400be65d		f20f59c1		MULSD X1, X0					
	se, ce := math.Sincos(eta)
  0x1400be661		e85a57fcff		CALL math.Sincos(SB)	
	gx = g * (ct*cc - st*sc*ce)
  0x1400be666		f20f10942480000000	MOVSD_XMM 0x80(SP), X2	
  0x1400be66f		f20f59d1		MULSD X1, X2		
  0x1400be673		f20f109c2498000000	MOVSD_XMM 0x98(SP), X3	
  0x1400be67c		f20f5cda		SUBSD X2, X3		
  0x1400be680		f20f10542410		MOVSD_XMM 0x10(SP), X2	
  0x1400be686		f20f59da		MULSD X2, X3		
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400be68a		f20f10642478		MOVSD_XMM 0x78(SP), X4	
  0x1400be690		f20f59e1		MULSD X1, X4		
  0x1400be694		f20f10ac2490000000	MOVSD_XMM 0x90(SP), X5	
  0x1400be69d		f20f10742458		MOVSD_XMM 0x58(SP), X6	
  0x1400be6a3		c4e2d1b9e6		VFMADD231SD X6, X5, X4	
  0x1400be6a8		f20f106c2470		MOVSD_XMM 0x70(SP), X5	
  0x1400be6ae		f20f59e8		MULSD X0, X5		
  0x1400be6b2		f20f5ce5		SUBSD X5, X4		
  0x1400be6b6		f20f59e2		MULSD X2, X4		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x1400be6ba		f20f106c2468		MOVSD_XMM 0x68(SP), X5	
  0x1400be6c0		f20f59e9		MULSD X1, X5		
  0x1400be6c4		f20f108c2488000000	MOVSD_XMM 0x88(SP), X1	
  0x1400be6cd		c4e2f1b9ee		VFMADD231SD X6, X1, X5	
  0x1400be6d2		f20f104c2460		MOVSD_XMM 0x60(SP), X1	
  0x1400be6d8		c4e2f1b9e8		VFMADD231SD X0, X1, X5	
  0x1400be6dd		f20f59d5		MULSD X5, X2		
	*vx_1 = wx + 0.5*gx
  0x1400be6e1		f20f10442428		MOVSD_XMM 0x28(SP), X0			
  0x1400be6e7		f20f100d097b0100	MOVSD_XMM $f64.3fe0000000000000(SB), X1	
  0x1400be6ef		c4e2e1b9c1		VFMADD231SD X1, X3, X0			
  0x1400be6f4		488b8c24b8000000	MOVQ 0xb8(SP), CX			
  0x1400be6fc		f20f1101		MOVSD_XMM X0, 0(CX)			
	*vy_1 = wy + 0.5*gy
  0x1400be700		f20f10442420		MOVSD_XMM 0x20(SP), X0	
  0x1400be706		c4e2d9b9c1		VFMADD231SD X1, X4, X0	
  0x1400be70b		488b8c24c0000000	MOVQ 0xc0(SP), CX	
  0x1400be713		f20f1101		MOVSD_XMM X0, 0(CX)	
	*vz_1 = wz + 0.5*gz
  0x1400be717		f20f10442418		MOVSD_XMM 0x18(SP), X0	
  0x1400be71d		c4e2e9b9c1		VFMADD231SD X1, X2, X0	
  0x1400be722		488b8c24c8000000	MOVQ 0xc8(SP), CX	
  0x1400be72a		f20f1101		MOVSD_XMM X0, 0(CX)	
}
  0x1400be72e		4881c4a0000000		ADDQ $0xa0, SP		
  0x1400be735		5d			POPQ BP			
  0x1400be736		c3			RET			
		*vx_1 = *vx_2
  0x1400be737		488b8424d0000000	MOVQ 0xd0(SP), AX	
  0x1400be73f		f20f1000		MOVSD_XMM 0(AX), X0	
  0x1400be743		488b8424b8000000	MOVQ 0xb8(SP), AX	
  0x1400be74b		f20f1100		MOVSD_XMM X0, 0(AX)	
		*vy_1 = *vy_2
  0x1400be74f		488b8424d8000000	MOVQ 0xd8(SP), AX	
  0x1400be757		f20f1000		MOVSD_XMM 0(AX), X0	
  0x1400be75b		488b8424c0000000	MOVQ 0xc0(SP), AX	
  0x1400be763		f20f1100		MOVSD_XMM X0, 0(AX)	
		*vz_1 = *vz_2
  0x1400be767		488b8424e0000000	MOVQ 0xe0(SP), AX	
  0x1400be76f		f20f1000		MOVSD_XMM 0(AX), X0	
  0x1400be773		488b8424c8000000	MOVQ 0xc8(SP), AX	
  0x1400be77b		f20f1100		MOVSD_XMM X0, 0(AX)	
		return
  0x1400be77f		4881c4a0000000		ADDQ $0xa0, SP		
  0x1400be786		5d			POPQ BP			
  0x1400be787		c3			RET			
	t1 := sim.Sigma[I_ISO][e_index]
  0x1400be788		b840420f00		MOVL $0xf4240, AX		
  0x1400be78d		e8eefcfbff		CALL runtime.panicBounds(SB)	
  0x1400be792		90			NOPL				
func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int, workerID int) {
  0x1400be793		4889442408		MOVQ AX, 0x8(SP)				
  0x1400be798		48895c2410		MOVQ BX, 0x10(SP)				
  0x1400be79d		48894c2418		MOVQ CX, 0x18(SP)				
  0x1400be7a2		48897c2420		MOVQ DI, 0x20(SP)				
  0x1400be7a7		4889742428		MOVQ SI, 0x28(SP)				
  0x1400be7ac		4c89442430		MOVQ R8, 0x30(SP)				
  0x1400be7b1		4c894c2438		MOVQ R9, 0x38(SP)				
  0x1400be7b6		4c89542440		MOVQ R10, 0x40(SP)				
  0x1400be7bb		4c895c2448		MOVQ R11, 0x48(SP)				
  0x1400be7c0		e87bdefbff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x1400be7c5		488b442408		MOVQ 0x8(SP), AX				
  0x1400be7ca		488b5c2410		MOVQ 0x10(SP), BX				
  0x1400be7cf		488b4c2418		MOVQ 0x18(SP), CX				
  0x1400be7d4		488b7c2420		MOVQ 0x20(SP), DI				
  0x1400be7d9		488b742428		MOVQ 0x28(SP), SI				
  0x1400be7de		4c8b442430		MOVQ 0x30(SP), R8				
  0x1400be7e3		4c8b4c2438		MOVQ 0x38(SP), R9				
  0x1400be7e8		4c8b542440		MOVQ 0x40(SP), R10				
  0x1400be7ed		4c8b5c2448		MOVQ 0x48(SP), R11				
  0x1400be7f2		e989fbffff		JMP gopic.(*SimulationState).CollisionIon(SB)	

  0x1400be7f7		cc			INT $0x3		
  0x1400be7f8		cc			INT $0x3		
  0x1400be7f9		cc			INT $0x3		
  0x1400be7fa		cc			INT $0x3		
  0x1400be7fb		cc			INT $0x3		
  0x1400be7fc		cc			INT $0x3		
  0x1400be7fd		cc			INT $0x3		
  0x1400be7fe		cc			INT $0x3		
  0x1400be7ff		cc			INT $0x3		


