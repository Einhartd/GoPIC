// =============================================================================
// SYMBOL: CollisionIon
// =============================================================================

TEXT gopic.(*SimulationState).CollisionIon(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/collisions.go
func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int, workerID int) {
  0x1400be960		4c8d6424d8		LEAQ -0x28(SP), R12	
  0x1400be965		4d3b6610		CMPQ R12, 0x10(R14)	
  0x1400be969		0f8604040000		JBE 0x1400bed73		
  0x1400be96f		55			PUSHQ BP		
  0x1400be970		4889e5			MOVQ SP, BP		
  0x1400be973		4881eca0000000		SUBQ $0xa0, SP		
	t1 := sim.Sigma[I_ISO][e_index]
  0x1400be97a		8400			TESTB AL, 0(AX)				
  0x1400be97c		0f1f4000		NOPL 0(AX)				
  0x1400be980		4981fa40420f00		CMPQ R10, $0xf4240			
  0x1400be987		0f83db030000		JAE 0x1400bed68				
  0x1400be98d		48898424b0000000	MOVQ AX, 0xb0(SP)			
  0x1400be995		48899c24b8000000	MOVQ BX, 0xb8(SP)			
  0x1400be99d		48898c24c0000000	MOVQ CX, 0xc0(SP)			
  0x1400be9a5		4889bc24c8000000	MOVQ DI, 0xc8(SP)			
  0x1400be9ad		4889b424d0000000	MOVQ SI, 0xd0(SP)			
  0x1400be9b5		4c898424d8000000	MOVQ R8, 0xd8(SP)			
  0x1400be9bd		4c898c24e0000000	MOVQ R9, 0xe0(SP)			
  0x1400be9c5		4c899c24f0000000	MOVQ R11, 0xf0(SP)			
  0x1400be9cd		f2420f1084d0c0366e01	MOVSD_XMM 0x16e36c0(AX)(R10*8), X0	
  0x1400be9d7		f20f11442430		MOVSD_XMM X0, 0x30(SP)			
	t2 := t1 + sim.Sigma[I_BACK][e_index]
  0x1400be9dd		f2420f1084d0c048e801	MOVSD_XMM 0x1e848c0(AX)(R10*8), X0	
  0x1400be9e7		f20f11842498000000	MOVSD_XMM X0, 0x98(SP)			
	rnd := sim.WorkerR01(workerID)
  0x1400be9f0		4c89db			MOVQ R11, BX					
  0x1400be9f3		e8e8760000		CALL gopic.(*SimulationState).WorkerR01(SB)	
	t2 := t1 + sim.Sigma[I_BACK][e_index]
  0x1400be9f8		f20f108c2498000000	MOVSD_XMM 0x98(SP), X1	
  0x1400bea01		f20f10542430		MOVSD_XMM 0x30(SP), X2	
  0x1400bea07		f20f58ca		ADDSD X2, X1		
	if rnd*t2 >= t1 {
  0x1400bea0b		f20f59c1		MULSD X1, X0		
  0x1400bea0f		660f2ec2		UCOMISD X2, X0		
  0x1400bea13		0f83fe020000		JAE 0x1400bed17		
	gx := (*vx_1) - (*vx_2)
  0x1400bea19		488b8c24b8000000	MOVQ 0xb8(SP), CX	
  0x1400bea21		f20f1001		MOVSD_XMM 0(CX), X0	
  0x1400bea25		488b9424d0000000	MOVQ 0xd0(SP), DX	
  0x1400bea2d		f20f100a		MOVSD_XMM 0(DX), X1	
  0x1400bea31		0f10d0			MOVUPS X0, X2		
  0x1400bea34		f20f5cc1		SUBSD X1, X0		
	gy := (*vy_1) - (*vy_2)
  0x1400bea38		488b9424c0000000	MOVQ 0xc0(SP), DX	
  0x1400bea40		f20f101a		MOVSD_XMM 0(DX), X3	
  0x1400bea44		488bb424d8000000	MOVQ 0xd8(SP), SI	
  0x1400bea4c		f20f1026		MOVSD_XMM 0(SI), X4	
  0x1400bea50		0f10eb			MOVUPS X3, X5		
  0x1400bea53		f20f5cdc		SUBSD X4, X3		
	gz := (*vz_1) - (*vz_2)
  0x1400bea57		488bb424c8000000	MOVQ 0xc8(SP), SI	
  0x1400bea5f		f20f1036		MOVSD_XMM 0(SI), X6	
	wx := 0.5 * ((*vx_1) + (*vx_2))
  0x1400bea63		f20f58d1		ADDSD X1, X2		
	wy := 0.5 * ((*vy_1) + (*vy_2))
  0x1400bea67		f20f58e5		ADDSD X5, X4		
	gz := (*vz_1) - (*vz_2)
  0x1400bea6b		488bbc24e0000000	MOVQ 0xe0(SP), DI	
  0x1400bea73		f20f100f		MOVSD_XMM 0(DI), X1	
  0x1400bea77		0f10ee			MOVUPS X6, X5		
  0x1400bea7a		f20f5cf1		SUBSD X1, X6		
	g_perp_sq := gy*gy + gz*gz
  0x1400bea7e		0f10fe			MOVUPS X6, X7		
  0x1400bea81		f20f59f6		MULSD X6, X6		
  0x1400bea85		c4e2e1b9f3		VFMADD231SD X3, X3, X6	
	g_sq := gx*gx + g_perp_sq
  0x1400bea8a		440f10c6		MOVUPS X6, X8		
  0x1400bea8e		c4e2f9b9f0		VFMADD231SD X0, X0, X6	
	wz := 0.5 * ((*vz_1) + (*vz_2))
  0x1400bea93		f20f58cd		ADDSD X5, X1		
	return sqrt(x)
  0x1400bea97		f20f51ee		SQRTSD X6, X5		
	g := math.Sqrt(g_sq)
  0x1400bea9b		90			NOPL			
	g_perp := math.Sqrt(g_perp_sq)
  0x1400bea9c		90			NOPL			
	wx := 0.5 * ((*vx_1) + (*vx_2))
  0x1400bea9d		f20f10359b870100	MOVSD_XMM $f64.3fe0000000000000(SB), X6	
  0x1400beaa5		f20f59d6		MULSD X6, X2				
	wy := 0.5 * ((*vy_1) + (*vy_2))
  0x1400beaa9		f20f59e6		MULSD X6, X4		
	wz := 0.5 * ((*vz_1) + (*vz_2))
  0x1400beaad		f20f59ce		MULSD X6, X1		
	return sqrt(x)
  0x1400beab1		f2410f51f0		SQRTSD X8, X6		
	if g > 0.0 {
  0x1400beab6		450f57c0		XORPS X8, X8		
  0x1400beaba		66410f2ee8		UCOMISD X8, X5		
  0x1400beabf		90			NOPL			
  0x1400beac0		760e			JBE 0x1400bead0		
		ct = gx / g
  0x1400beac2		f20f5ec5		DIVSD X5, X0		
		st = g_perp / g
  0x1400beac6		440f10ce		MOVUPS X6, X9		
  0x1400beaca		f20f5ef5		DIVSD X5, X6		
  0x1400beace		eb0f			JMP 0x1400beadf		
	if g_perp > 0.0 {
  0x1400bead0		440f10ce		MOVUPS X6, X9				
  0x1400bead4		0f57f6			XORPS X6, X6				
  0x1400bead7		f20f100579870100	MOVSD_XMM $f64.3ff0000000000000(SB), X0	
	return sqrt(x)
  0x1400beadf		f20f116c2410		MOVSD_XMM X5, 0x10(SP)	
	wx := 0.5 * ((*vx_1) + (*vx_2))
  0x1400beae5		f20f11542428		MOVSD_XMM X2, 0x28(SP)	
	wy := 0.5 * ((*vy_1) + (*vy_2))
  0x1400beaeb		f20f11642420		MOVSD_XMM X4, 0x20(SP)	
	wz := 0.5 * ((*vz_1) + (*vz_2))
  0x1400beaf1		f20f114c2418		MOVSD_XMM X1, 0x18(SP)	
	if g_perp > 0.0 {
  0x1400beaf7		f20f11742438		MOVSD_XMM X6, 0x38(SP)	
  0x1400beafd		f20f11442448		MOVSD_XMM X0, 0x48(SP)	
  0x1400beb03		66450f2ec8		UCOMISD X8, X9		
  0x1400beb08		760c			JBE 0x1400beb16		
		cp = gy / g_perp
  0x1400beb0a		f2410f5ed9		DIVSD X9, X3		
		sp = gz / g_perp
  0x1400beb0f		f2410f5ef9		DIVSD X9, X7				
  0x1400beb14		eb0b			JMP 0x1400beb21				
  0x1400beb16		f20f101d3a870100	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x1400beb1e		0f57ff			XORPS X7, X7				
	cc := 1.0 - 2.0*sim.WorkerR01(workerID)
  0x1400beb21		f20f117c2440		MOVSD_XMM X7, 0x40(SP)				
  0x1400beb27		f20f115c2450		MOVSD_XMM X3, 0x50(SP)				
  0x1400beb2d		488b8424b0000000	MOVQ 0xb0(SP), AX				
  0x1400beb35		488b9c24f0000000	MOVQ 0xf0(SP), BX				
  0x1400beb3d		0f1f00			NOPL 0(AX)					
  0x1400beb40		e89b750000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400beb45		f20f58c0		ADDSD X0, X0					
  0x1400beb49		f20f100d07870100	MOVSD_XMM $f64.3ff0000000000000(SB), X1		
  0x1400beb51		f20f5cc8		SUBSD X0, X1					
  0x1400beb55		f20f114c2458		MOVSD_XMM X1, 0x58(SP)				
	sc := math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400beb5b		0f57c0			XORPS X0, X0				
  0x1400beb5e		f20f101532880100	MOVSD_XMM $f64.8000000000000000(SB), X2	
  0x1400beb66		660fefc2		PXOR X2, X0				
  0x1400beb6a		0f10d9			MOVUPS X1, X3				
  0x1400beb6d		f20f59c9		MULSD X1, X1				
  0x1400beb71		f20f1025df860100	MOVSD_XMM $f64.3ff0000000000000(SB), X4	
  0x1400beb79		f20f5ce1		SUBSD X1, X4				
  0x1400beb7d		660fefe2		PXOR X2, X4				
  0x1400beb81		0f10c8			MOVUPS X0, X1				
  0x1400beb84		f20f5dc4		MINSD X4, X0				
  0x1400beb88		0f10e0			MOVUPS X0, X4				
  0x1400beb8b		f20f5dc1		MINSD X1, X0				
  0x1400beb8f		660febc4		POR X4, X0				
  0x1400beb93		660fefc2		PXOR X2, X0				
	gx = g * (ct*cc - st*sc*ce)
  0x1400beb97		f20f104c2448		MOVSD_XMM 0x48(SP), X1	
  0x1400beb9d		f20f59d9		MULSD X1, X3		
  0x1400beba1		f20f119c2498000000	MOVSD_XMM X3, 0x98(SP)	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400bebaa		f20f10542438		MOVSD_XMM 0x38(SP), X2	
  0x1400bebb0		f20f105c2450		MOVSD_XMM 0x50(SP), X3	
  0x1400bebb6		0f10e2			MOVUPS X2, X4		
  0x1400bebb9		f20f59d3		MULSD X3, X2		
  0x1400bebbd		f20f11942490000000	MOVSD_XMM X2, 0x90(SP)	
  0x1400bebc6		0f10d1			MOVUPS X1, X2		
  0x1400bebc9		f20f59cb		MULSD X3, X1		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x1400bebcd		f20f106c2440		MOVSD_XMM 0x40(SP), X5	
  0x1400bebd3		0f10f4			MOVUPS X4, X6		
  0x1400bebd6		f20f59e5		MULSD X5, X4		
  0x1400bebda		f20f11a42488000000	MOVSD_XMM X4, 0x88(SP)	
  0x1400bebe3		f20f59d5		MULSD X5, X2		
	return sqrt(x)
  0x1400bebe7		f20f51c0		SQRTSD X0, X0		
	gx = g * (ct*cc - st*sc*ce)
  0x1400bebeb		f20f59f0		MULSD X0, X6		
  0x1400bebef		f20f11b42480000000	MOVSD_XMM X6, 0x80(SP)	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400bebf8		f20f59c8		MULSD X0, X1		
  0x1400bebfc		f20f114c2478		MOVSD_XMM X1, 0x78(SP)	
  0x1400bec02		f20f59e8		MULSD X0, X5		
  0x1400bec06		f20f116c2470		MOVSD_XMM X5, 0x70(SP)	
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x1400bec0c		f20f59d0		MULSD X0, X2		
  0x1400bec10		f20f11542468		MOVSD_XMM X2, 0x68(SP)	
  0x1400bec16		f20f59d8		MULSD X0, X3		
  0x1400bec1a		f20f115c2460		MOVSD_XMM X3, 0x60(SP)	
	eta := TWO_PI * sim.WorkerR01(workerID)
  0x1400bec20		488b8424b0000000	MOVQ 0xb0(SP), AX				
  0x1400bec28		488b9c24f0000000	MOVQ 0xf0(SP), BX				
  0x1400bec30		e8ab740000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400bec35		f20f100d93860100	MOVSD_XMM $f64.401921fb54442d18(SB), X1		
  0x1400bec3d		f20f59c1		MULSD X1, X0					
	se, ce := math.Sincos(eta)
  0x1400bec41		e8fa51fcff		CALL math.Sincos(SB)	
	gx = g * (ct*cc - st*sc*ce)
  0x1400bec46		f20f10942480000000	MOVSD_XMM 0x80(SP), X2	
  0x1400bec4f		f20f59d1		MULSD X1, X2		
  0x1400bec53		f20f109c2498000000	MOVSD_XMM 0x98(SP), X3	
  0x1400bec5c		f20f5cda		SUBSD X2, X3		
  0x1400bec60		f20f10542410		MOVSD_XMM 0x10(SP), X2	
  0x1400bec66		f20f59da		MULSD X2, X3		
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400bec6a		f20f10642478		MOVSD_XMM 0x78(SP), X4	
  0x1400bec70		f20f59e1		MULSD X1, X4		
  0x1400bec74		f20f10ac2490000000	MOVSD_XMM 0x90(SP), X5	
  0x1400bec7d		f20f10742458		MOVSD_XMM 0x58(SP), X6	
  0x1400bec83		c4e2d1b9e6		VFMADD231SD X6, X5, X4	
  0x1400bec88		f20f106c2470		MOVSD_XMM 0x70(SP), X5	
  0x1400bec8e		f20f59e8		MULSD X0, X5		
  0x1400bec92		f20f5ce5		SUBSD X5, X4		
  0x1400bec96		f20f59e2		MULSD X2, X4		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x1400bec9a		f20f106c2468		MOVSD_XMM 0x68(SP), X5	
  0x1400beca0		f20f59e9		MULSD X1, X5		
  0x1400beca4		f20f108c2488000000	MOVSD_XMM 0x88(SP), X1	
  0x1400becad		c4e2f1b9ee		VFMADD231SD X6, X1, X5	
  0x1400becb2		f20f104c2460		MOVSD_XMM 0x60(SP), X1	
  0x1400becb8		c4e2f1b9e8		VFMADD231SD X0, X1, X5	
  0x1400becbd		f20f59d5		MULSD X5, X2		
	*vx_1 = wx + 0.5*gx
  0x1400becc1		f20f10442428		MOVSD_XMM 0x28(SP), X0			
  0x1400becc7		f20f100d71850100	MOVSD_XMM $f64.3fe0000000000000(SB), X1	
  0x1400beccf		c4e2e1b9c1		VFMADD231SD X1, X3, X0			
  0x1400becd4		488b8c24b8000000	MOVQ 0xb8(SP), CX			
  0x1400becdc		f20f1101		MOVSD_XMM X0, 0(CX)			
	*vy_1 = wy + 0.5*gy
  0x1400bece0		f20f10442420		MOVSD_XMM 0x20(SP), X0	
  0x1400bece6		c4e2d9b9c1		VFMADD231SD X1, X4, X0	
  0x1400beceb		488b8c24c0000000	MOVQ 0xc0(SP), CX	
  0x1400becf3		f20f1101		MOVSD_XMM X0, 0(CX)	
	*vz_1 = wz + 0.5*gz
  0x1400becf7		f20f10442418		MOVSD_XMM 0x18(SP), X0	
  0x1400becfd		c4e2e9b9c1		VFMADD231SD X1, X2, X0	
  0x1400bed02		488b8c24c8000000	MOVQ 0xc8(SP), CX	
  0x1400bed0a		f20f1101		MOVSD_XMM X0, 0(CX)	
}
  0x1400bed0e		4881c4a0000000		ADDQ $0xa0, SP		
  0x1400bed15		5d			POPQ BP			
  0x1400bed16		c3			RET			
		*vx_1 = *vx_2
  0x1400bed17		488b8424d0000000	MOVQ 0xd0(SP), AX	
  0x1400bed1f		f20f1000		MOVSD_XMM 0(AX), X0	
  0x1400bed23		488b8424b8000000	MOVQ 0xb8(SP), AX	
  0x1400bed2b		f20f1100		MOVSD_XMM X0, 0(AX)	
		*vy_1 = *vy_2
  0x1400bed2f		488b8424d8000000	MOVQ 0xd8(SP), AX	
  0x1400bed37		f20f1000		MOVSD_XMM 0(AX), X0	
  0x1400bed3b		488b8424c0000000	MOVQ 0xc0(SP), AX	
  0x1400bed43		f20f1100		MOVSD_XMM X0, 0(AX)	
		*vz_1 = *vz_2
  0x1400bed47		488b8424e0000000	MOVQ 0xe0(SP), AX	
  0x1400bed4f		f20f1000		MOVSD_XMM 0(AX), X0	
  0x1400bed53		488b8424c8000000	MOVQ 0xc8(SP), AX	
  0x1400bed5b		f20f1100		MOVSD_XMM X0, 0(AX)	
		return
  0x1400bed5f		4881c4a0000000		ADDQ $0xa0, SP		
  0x1400bed66		5d			POPQ BP			
  0x1400bed67		c3			RET			
	t1 := sim.Sigma[I_ISO][e_index]
  0x1400bed68		b840420f00		MOVL $0xf4240, AX		
  0x1400bed6d		e80ef7fbff		CALL runtime.panicBounds(SB)	
  0x1400bed72		90			NOPL				
func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int, workerID int) {
  0x1400bed73		4889442408		MOVQ AX, 0x8(SP)				
  0x1400bed78		48895c2410		MOVQ BX, 0x10(SP)				
  0x1400bed7d		48894c2418		MOVQ CX, 0x18(SP)				
  0x1400bed82		48897c2420		MOVQ DI, 0x20(SP)				
  0x1400bed87		4889742428		MOVQ SI, 0x28(SP)				
  0x1400bed8c		4c89442430		MOVQ R8, 0x30(SP)				
  0x1400bed91		4c894c2438		MOVQ R9, 0x38(SP)				
  0x1400bed96		4c89542440		MOVQ R10, 0x40(SP)				
  0x1400bed9b		4c895c2448		MOVQ R11, 0x48(SP)				
  0x1400beda0		e89bd8fbff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x1400beda5		488b442408		MOVQ 0x8(SP), AX				
  0x1400bedaa		488b5c2410		MOVQ 0x10(SP), BX				
  0x1400bedaf		488b4c2418		MOVQ 0x18(SP), CX				
  0x1400bedb4		488b7c2420		MOVQ 0x20(SP), DI				
  0x1400bedb9		488b742428		MOVQ 0x28(SP), SI				
  0x1400bedbe		4c8b442430		MOVQ 0x30(SP), R8				
  0x1400bedc3		4c8b4c2438		MOVQ 0x38(SP), R9				
  0x1400bedc8		4c8b542440		MOVQ 0x40(SP), R10				
  0x1400bedcd		4c8b5c2448		MOVQ 0x48(SP), R11				
  0x1400bedd2		e989fbffff		JMP gopic.(*SimulationState).CollisionIon(SB)	

  0x1400bedd7		cc			INT $0x3		
  0x1400bedd8		cc			INT $0x3		
  0x1400bedd9		cc			INT $0x3		
  0x1400bedda		cc			INT $0x3		
  0x1400beddb		cc			INT $0x3		
  0x1400beddc		cc			INT $0x3		
  0x1400beddd		cc			INT $0x3		
  0x1400bedde		cc			INT $0x3		
  0x1400beddf		cc			INT $0x3		

TEXT gopic.(*SimulationState).Step8CollisionIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/simulation_null.go
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x1400c54c0		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c54c4		7658			JBE 0x1400c551e		
  0x1400c54c6		55			PUSHQ BP		
  0x1400c54c7		4889e5			MOVQ SP, BP		
  0x1400c54ca		4883ec10		SUBQ $0x10, SP		
	if (t%N_SUB) != 0 || sim.N_i == 0 {
  0x1400c54ce		48b9cdcccccccccccccc	MOVQ $0xcccccccccccccccd, CX	
  0x1400c54d8		480fafd9		IMULQ CX, BX			
  0x1400c54dc		48b99899999999999919	MOVQ $0x1999999999999998, CX	
  0x1400c54e6		4801d9			ADDQ BX, CX			
  0x1400c54e9		48c1c13e		ROLQ $0x3e, CX			
  0x1400c54ed		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x1400c54f7		4839ca			CMPQ DX, CX			
  0x1400c54fa		720c			JB 0x1400c5508			
  0x1400c54fc		8400			TESTB AL, 0(AX)			
  0x1400c54fe		4883b8c87e560300	CMPQ 0x3567ec8(AX), $0x0	
  0x1400c5506		7506			JNE 0x1400c550e			
		return
  0x1400c5508		4883c410		ADDQ $0x10, SP		
  0x1400c550c		5d			POPQ BP			
  0x1400c550d		c3			RET			
	sim.broadcastAndWait(CmdCollisionsI)
  0x1400c550e		bb05000000		MOVL $0x5, BX						
  0x1400c5513		e868e3ffff		CALL gopic.(*SimulationState).broadcastAndWait(SB)	
}
  0x1400c5518		4883c410		ADDQ $0x10, SP		
  0x1400c551c		5d			POPQ BP			
  0x1400c551d		c3			RET			
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x1400c551e		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c5523		48895c2410		MOVQ BX, 0x10(SP)					
  0x1400c5528		e81371fbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c552d		488b442408		MOVQ 0x8(SP), AX					
  0x1400c5532		488b5c2410		MOVQ 0x10(SP), BX					
  0x1400c5537		eb87			JMP gopic.(*SimulationState).Step8CollisionIons(SB)	

  0x1400c5539		cc			INT $0x3		
  0x1400c553a		cc			INT $0x3		
  0x1400c553b		cc			INT $0x3		
  0x1400c553c		cc			INT $0x3		
  0x1400c553d		cc			INT $0x3		
  0x1400c553e		cc			INT $0x3		
  0x1400c553f		cc			INT $0x3		


