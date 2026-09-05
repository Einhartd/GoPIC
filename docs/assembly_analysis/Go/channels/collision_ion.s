TEXT gopic.(*SimulationState).CollisionIon(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/collisions.go
func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int, workerID int) {
  0x1400be5e0		4c8d6424d8		LEAQ -0x28(SP), R12	
  0x1400be5e5		4d3b6610		CMPQ R12, 0x10(R14)	
  0x1400be5e9		0f8604040000		JBE 0x1400be9f3		
  0x1400be5ef		55			PUSHQ BP		
  0x1400be5f0		4889e5			MOVQ SP, BP		
  0x1400be5f3		4881eca0000000		SUBQ $0xa0, SP		
	t1 := sim.Sigma[I_ISO][e_index]
  0x1400be5fa		8400			TESTB AL, 0(AX)				
  0x1400be5fc		0f1f4000		NOPL 0(AX)				
  0x1400be600		4981fa40420f00		CMPQ R10, $0xf4240			
  0x1400be607		0f83db030000		JAE 0x1400be9e8				
  0x1400be60d		48898424b0000000	MOVQ AX, 0xb0(SP)			
  0x1400be615		48899c24b8000000	MOVQ BX, 0xb8(SP)			
  0x1400be61d		48898c24c0000000	MOVQ CX, 0xc0(SP)			
  0x1400be625		4889bc24c8000000	MOVQ DI, 0xc8(SP)			
  0x1400be62d		4889b424d0000000	MOVQ SI, 0xd0(SP)			
  0x1400be635		4c898424d8000000	MOVQ R8, 0xd8(SP)			
  0x1400be63d		4c898c24e0000000	MOVQ R9, 0xe0(SP)			
  0x1400be645		4c899c24f0000000	MOVQ R11, 0xf0(SP)			
  0x1400be64d		f2420f1084d0c0366e01	MOVSD_XMM 0x16e36c0(AX)(R10*8), X0	
  0x1400be657		f20f11442430		MOVSD_XMM X0, 0x30(SP)			
	t2 := t1 + sim.Sigma[I_BACK][e_index]
  0x1400be65d		f2420f1084d0c048e801	MOVSD_XMM 0x1e848c0(AX)(R10*8), X0	
  0x1400be667		f20f11842498000000	MOVSD_XMM X0, 0x98(SP)			
	rnd := sim.WorkerR01(workerID)
  0x1400be670		4c89db			MOVQ R11, BX					
  0x1400be673		e828780000		CALL gopic.(*SimulationState).WorkerR01(SB)	
	t2 := t1 + sim.Sigma[I_BACK][e_index]
  0x1400be678		f20f108c2498000000	MOVSD_XMM 0x98(SP), X1	
  0x1400be681		f20f10542430		MOVSD_XMM 0x30(SP), X2	
  0x1400be687		f20f58ca		ADDSD X2, X1		
	if rnd*t2 >= t1 {
  0x1400be68b		f20f59c1		MULSD X1, X0		
  0x1400be68f		660f2ec2		UCOMISD X2, X0		
  0x1400be693		0f83fe020000		JAE 0x1400be997		
	gx := (*vx_1) - (*vx_2)
  0x1400be699		488b8c24b8000000	MOVQ 0xb8(SP), CX	
  0x1400be6a1		f20f1001		MOVSD_XMM 0(CX), X0	
  0x1400be6a5		488b9424d0000000	MOVQ 0xd0(SP), DX	
  0x1400be6ad		f20f100a		MOVSD_XMM 0(DX), X1	
  0x1400be6b1		0f10d0			MOVUPS X0, X2		
  0x1400be6b4		f20f5cc1		SUBSD X1, X0		
	gy := (*vy_1) - (*vy_2)
  0x1400be6b8		488b9424c0000000	MOVQ 0xc0(SP), DX	
  0x1400be6c0		f20f101a		MOVSD_XMM 0(DX), X3	
  0x1400be6c4		488bb424d8000000	MOVQ 0xd8(SP), SI	
  0x1400be6cc		f20f1026		MOVSD_XMM 0(SI), X4	
  0x1400be6d0		0f10eb			MOVUPS X3, X5		
  0x1400be6d3		f20f5cdc		SUBSD X4, X3		
	gz := (*vz_1) - (*vz_2)
  0x1400be6d7		488bb424c8000000	MOVQ 0xc8(SP), SI	
  0x1400be6df		f20f1036		MOVSD_XMM 0(SI), X6	
	wx := 0.5 * ((*vx_1) + (*vx_2))
  0x1400be6e3		f20f58d1		ADDSD X1, X2		
	wy := 0.5 * ((*vy_1) + (*vy_2))
  0x1400be6e7		f20f58e5		ADDSD X5, X4		
	gz := (*vz_1) - (*vz_2)
  0x1400be6eb		488bbc24e0000000	MOVQ 0xe0(SP), DI	
  0x1400be6f3		f20f100f		MOVSD_XMM 0(DI), X1	
  0x1400be6f7		0f10ee			MOVUPS X6, X5		
  0x1400be6fa		f20f5cf1		SUBSD X1, X6		
	g_perp_sq := gy*gy + gz*gz
  0x1400be6fe		0f10fe			MOVUPS X6, X7		
  0x1400be701		f20f59f6		MULSD X6, X6		
  0x1400be705		c4e2e1b9f3		VFMADD231SD X3, X3, X6	
	g_sq := gx*gx + g_perp_sq
  0x1400be70a		440f10c6		MOVUPS X6, X8		
  0x1400be70e		c4e2f9b9f0		VFMADD231SD X0, X0, X6	
	wz := 0.5 * ((*vz_1) + (*vz_2))
  0x1400be713		f20f58cd		ADDSD X5, X1		
	return sqrt(x)
  0x1400be717		f20f51ee		SQRTSD X6, X5		
	g := math.Sqrt(g_sq)
  0x1400be71b		90			NOPL			
	g_perp := math.Sqrt(g_perp_sq)
  0x1400be71c		90			NOPL			
	wx := 0.5 * ((*vx_1) + (*vx_2))
  0x1400be71d		f20f1035237b0100	MOVSD_XMM $f64.3fe0000000000000(SB), X6	
  0x1400be725		f20f59d6		MULSD X6, X2				
	wy := 0.5 * ((*vy_1) + (*vy_2))
  0x1400be729		f20f59e6		MULSD X6, X4		
	wz := 0.5 * ((*vz_1) + (*vz_2))
  0x1400be72d		f20f59ce		MULSD X6, X1		
	return sqrt(x)
  0x1400be731		f2410f51f0		SQRTSD X8, X6		
	if g > 0.0 {
  0x1400be736		450f57c0		XORPS X8, X8		
  0x1400be73a		66410f2ee8		UCOMISD X8, X5		
  0x1400be73f		90			NOPL			
  0x1400be740		760e			JBE 0x1400be750		
		ct = gx / g
  0x1400be742		f20f5ec5		DIVSD X5, X0		
		st = g_perp / g
  0x1400be746		440f10ce		MOVUPS X6, X9		
  0x1400be74a		f20f5ef5		DIVSD X5, X6		
  0x1400be74e		eb0f			JMP 0x1400be75f		
	if g_perp > 0.0 {
  0x1400be750		440f10ce		MOVUPS X6, X9				
  0x1400be754		0f57f6			XORPS X6, X6				
  0x1400be757		f20f1005017b0100	MOVSD_XMM $f64.3ff0000000000000(SB), X0	
	return sqrt(x)
  0x1400be75f		f20f116c2410		MOVSD_XMM X5, 0x10(SP)	
	wx := 0.5 * ((*vx_1) + (*vx_2))
  0x1400be765		f20f11542428		MOVSD_XMM X2, 0x28(SP)	
	wy := 0.5 * ((*vy_1) + (*vy_2))
  0x1400be76b		f20f11642420		MOVSD_XMM X4, 0x20(SP)	
	wz := 0.5 * ((*vz_1) + (*vz_2))
  0x1400be771		f20f114c2418		MOVSD_XMM X1, 0x18(SP)	
	if g_perp > 0.0 {
  0x1400be777		f20f11742438		MOVSD_XMM X6, 0x38(SP)	
  0x1400be77d		f20f11442448		MOVSD_XMM X0, 0x48(SP)	
  0x1400be783		66450f2ec8		UCOMISD X8, X9		
  0x1400be788		760c			JBE 0x1400be796		
		cp = gy / g_perp
  0x1400be78a		f2410f5ed9		DIVSD X9, X3		
		sp = gz / g_perp
  0x1400be78f		f2410f5ef9		DIVSD X9, X7				
  0x1400be794		eb0b			JMP 0x1400be7a1				
  0x1400be796		f20f101dc27a0100	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x1400be79e		0f57ff			XORPS X7, X7				
	cc := 1.0 - 2.0*sim.WorkerR01(workerID)
  0x1400be7a1		f20f117c2440		MOVSD_XMM X7, 0x40(SP)				
  0x1400be7a7		f20f115c2450		MOVSD_XMM X3, 0x50(SP)				
  0x1400be7ad		488b8424b0000000	MOVQ 0xb0(SP), AX				
  0x1400be7b5		488b9c24f0000000	MOVQ 0xf0(SP), BX				
  0x1400be7bd		0f1f00			NOPL 0(AX)					
  0x1400be7c0		e8db760000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400be7c5		f20f58c0		ADDSD X0, X0					
  0x1400be7c9		f20f100d8f7a0100	MOVSD_XMM $f64.3ff0000000000000(SB), X1		
  0x1400be7d1		f20f5cc8		SUBSD X0, X1					
  0x1400be7d5		f20f114c2458		MOVSD_XMM X1, 0x58(SP)				
	sc := math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400be7db		0f57c0			XORPS X0, X0				
  0x1400be7de		f20f1015b27b0100	MOVSD_XMM $f64.8000000000000000(SB), X2	
  0x1400be7e6		660fefc2		PXOR X2, X0				
  0x1400be7ea		0f10d9			MOVUPS X1, X3				
  0x1400be7ed		f20f59c9		MULSD X1, X1				
  0x1400be7f1		f20f1025677a0100	MOVSD_XMM $f64.3ff0000000000000(SB), X4	
  0x1400be7f9		f20f5ce1		SUBSD X1, X4				
  0x1400be7fd		660fefe2		PXOR X2, X4				
  0x1400be801		0f10c8			MOVUPS X0, X1				
  0x1400be804		f20f5dc4		MINSD X4, X0				
  0x1400be808		0f10e0			MOVUPS X0, X4				
  0x1400be80b		f20f5dc1		MINSD X1, X0				
  0x1400be80f		660febc4		POR X4, X0				
  0x1400be813		660fefc2		PXOR X2, X0				
	gx = g * (ct*cc - st*sc*ce)
  0x1400be817		f20f104c2448		MOVSD_XMM 0x48(SP), X1	
  0x1400be81d		f20f59d9		MULSD X1, X3		
  0x1400be821		f20f119c2498000000	MOVSD_XMM X3, 0x98(SP)	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400be82a		f20f10542438		MOVSD_XMM 0x38(SP), X2	
  0x1400be830		f20f105c2450		MOVSD_XMM 0x50(SP), X3	
  0x1400be836		0f10e2			MOVUPS X2, X4		
  0x1400be839		f20f59d3		MULSD X3, X2		
  0x1400be83d		f20f11942490000000	MOVSD_XMM X2, 0x90(SP)	
  0x1400be846		0f10d1			MOVUPS X1, X2		
  0x1400be849		f20f59cb		MULSD X3, X1		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x1400be84d		f20f106c2440		MOVSD_XMM 0x40(SP), X5	
  0x1400be853		0f10f4			MOVUPS X4, X6		
  0x1400be856		f20f59e5		MULSD X5, X4		
  0x1400be85a		f20f11a42488000000	MOVSD_XMM X4, 0x88(SP)	
  0x1400be863		f20f59d5		MULSD X5, X2		
	return sqrt(x)
  0x1400be867		f20f51c0		SQRTSD X0, X0		
	gx = g * (ct*cc - st*sc*ce)
  0x1400be86b		f20f59f0		MULSD X0, X6		
  0x1400be86f		f20f11b42480000000	MOVSD_XMM X6, 0x80(SP)	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400be878		f20f59c8		MULSD X0, X1		
  0x1400be87c		f20f114c2478		MOVSD_XMM X1, 0x78(SP)	
  0x1400be882		f20f59e8		MULSD X0, X5		
  0x1400be886		f20f116c2470		MOVSD_XMM X5, 0x70(SP)	
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x1400be88c		f20f59d0		MULSD X0, X2		
  0x1400be890		f20f11542468		MOVSD_XMM X2, 0x68(SP)	
  0x1400be896		f20f59d8		MULSD X0, X3		
  0x1400be89a		f20f115c2460		MOVSD_XMM X3, 0x60(SP)	
	eta := TWO_PI * sim.WorkerR01(workerID)
  0x1400be8a0		488b8424b0000000	MOVQ 0xb0(SP), AX				
  0x1400be8a8		488b9c24f0000000	MOVQ 0xf0(SP), BX				
  0x1400be8b0		e8eb750000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400be8b5		f20f100d1b7a0100	MOVSD_XMM $f64.401921fb54442d18(SB), X1		
  0x1400be8bd		f20f59c1		MULSD X1, X0					
	se, ce := math.Sincos(eta)
  0x1400be8c1		e8fa54fcff		CALL math.Sincos(SB)	
	gx = g * (ct*cc - st*sc*ce)
  0x1400be8c6		f20f10942480000000	MOVSD_XMM 0x80(SP), X2	
  0x1400be8cf		f20f59d1		MULSD X1, X2		
  0x1400be8d3		f20f109c2498000000	MOVSD_XMM 0x98(SP), X3	
  0x1400be8dc		f20f5cda		SUBSD X2, X3		
  0x1400be8e0		f20f10542410		MOVSD_XMM 0x10(SP), X2	
  0x1400be8e6		f20f59da		MULSD X2, X3		
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400be8ea		f20f10642478		MOVSD_XMM 0x78(SP), X4	
  0x1400be8f0		f20f59e1		MULSD X1, X4		
  0x1400be8f4		f20f10ac2490000000	MOVSD_XMM 0x90(SP), X5	
  0x1400be8fd		f20f10742458		MOVSD_XMM 0x58(SP), X6	
  0x1400be903		c4e2d1b9e6		VFMADD231SD X6, X5, X4	
  0x1400be908		f20f106c2470		MOVSD_XMM 0x70(SP), X5	
  0x1400be90e		f20f59e8		MULSD X0, X5		
  0x1400be912		f20f5ce5		SUBSD X5, X4		
  0x1400be916		f20f59e2		MULSD X2, X4		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x1400be91a		f20f106c2468		MOVSD_XMM 0x68(SP), X5	
  0x1400be920		f20f59e9		MULSD X1, X5		
  0x1400be924		f20f108c2488000000	MOVSD_XMM 0x88(SP), X1	
  0x1400be92d		c4e2f1b9ee		VFMADD231SD X6, X1, X5	
  0x1400be932		f20f104c2460		MOVSD_XMM 0x60(SP), X1	
  0x1400be938		c4e2f1b9e8		VFMADD231SD X0, X1, X5	
  0x1400be93d		f20f59d5		MULSD X5, X2		
	*vx_1 = wx + 0.5*gx
  0x1400be941		f20f10442428		MOVSD_XMM 0x28(SP), X0			
  0x1400be947		f20f100df9780100	MOVSD_XMM $f64.3fe0000000000000(SB), X1	
  0x1400be94f		c4e2e1b9c1		VFMADD231SD X1, X3, X0			
  0x1400be954		488b8c24b8000000	MOVQ 0xb8(SP), CX			
  0x1400be95c		f20f1101		MOVSD_XMM X0, 0(CX)			
	*vy_1 = wy + 0.5*gy
  0x1400be960		f20f10442420		MOVSD_XMM 0x20(SP), X0	
  0x1400be966		c4e2d9b9c1		VFMADD231SD X1, X4, X0	
  0x1400be96b		488b8c24c0000000	MOVQ 0xc0(SP), CX	
  0x1400be973		f20f1101		MOVSD_XMM X0, 0(CX)	
	*vz_1 = wz + 0.5*gz
  0x1400be977		f20f10442418		MOVSD_XMM 0x18(SP), X0	
  0x1400be97d		c4e2e9b9c1		VFMADD231SD X1, X2, X0	
  0x1400be982		488b8c24c8000000	MOVQ 0xc8(SP), CX	
  0x1400be98a		f20f1101		MOVSD_XMM X0, 0(CX)	
}
  0x1400be98e		4881c4a0000000		ADDQ $0xa0, SP		
  0x1400be995		5d			POPQ BP			
  0x1400be996		c3			RET			
		*vx_1 = *vx_2
  0x1400be997		488b8424d0000000	MOVQ 0xd0(SP), AX	
  0x1400be99f		f20f1000		MOVSD_XMM 0(AX), X0	
  0x1400be9a3		488b8424b8000000	MOVQ 0xb8(SP), AX	
  0x1400be9ab		f20f1100		MOVSD_XMM X0, 0(AX)	
		*vy_1 = *vy_2
  0x1400be9af		488b8424d8000000	MOVQ 0xd8(SP), AX	
  0x1400be9b7		f20f1000		MOVSD_XMM 0(AX), X0	
  0x1400be9bb		488b8424c0000000	MOVQ 0xc0(SP), AX	
  0x1400be9c3		f20f1100		MOVSD_XMM X0, 0(AX)	
		*vz_1 = *vz_2
  0x1400be9c7		488b8424e0000000	MOVQ 0xe0(SP), AX	
  0x1400be9cf		f20f1000		MOVSD_XMM 0(AX), X0	
  0x1400be9d3		488b8424c8000000	MOVQ 0xc8(SP), AX	
  0x1400be9db		f20f1100		MOVSD_XMM X0, 0(AX)	
		return
  0x1400be9df		4881c4a0000000		ADDQ $0xa0, SP		
  0x1400be9e6		5d			POPQ BP			
  0x1400be9e7		c3			RET			
	t1 := sim.Sigma[I_ISO][e_index]
  0x1400be9e8		b840420f00		MOVL $0xf4240, AX		
  0x1400be9ed		e88efafbff		CALL runtime.panicBounds(SB)	
  0x1400be9f2		90			NOPL				
func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int, workerID int) {
  0x1400be9f3		4889442408		MOVQ AX, 0x8(SP)				
  0x1400be9f8		48895c2410		MOVQ BX, 0x10(SP)				
  0x1400be9fd		48894c2418		MOVQ CX, 0x18(SP)				
  0x1400bea02		48897c2420		MOVQ DI, 0x20(SP)				
  0x1400bea07		4889742428		MOVQ SI, 0x28(SP)				
  0x1400bea0c		4c89442430		MOVQ R8, 0x30(SP)				
  0x1400bea11		4c894c2438		MOVQ R9, 0x38(SP)				
  0x1400bea16		4c89542440		MOVQ R10, 0x40(SP)				
  0x1400bea1b		4c895c2448		MOVQ R11, 0x48(SP)				
  0x1400bea20		e81bdcfbff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x1400bea25		488b442408		MOVQ 0x8(SP), AX				
  0x1400bea2a		488b5c2410		MOVQ 0x10(SP), BX				
  0x1400bea2f		488b4c2418		MOVQ 0x18(SP), CX				
  0x1400bea34		488b7c2420		MOVQ 0x20(SP), DI				
  0x1400bea39		488b742428		MOVQ 0x28(SP), SI				
  0x1400bea3e		4c8b442430		MOVQ 0x30(SP), R8				
  0x1400bea43		4c8b4c2438		MOVQ 0x38(SP), R9				
  0x1400bea48		4c8b542440		MOVQ 0x40(SP), R10				
  0x1400bea4d		4c8b5c2448		MOVQ 0x48(SP), R11				
  0x1400bea52		e989fbffff		JMP gopic.(*SimulationState).CollisionIon(SB)	

  0x1400bea57		cc			INT $0x3		
  0x1400bea58		cc			INT $0x3		
  0x1400bea59		cc			INT $0x3		
  0x1400bea5a		cc			INT $0x3		
  0x1400bea5b		cc			INT $0x3		
  0x1400bea5c		cc			INT $0x3		
  0x1400bea5d		cc			INT $0x3		
  0x1400bea5e		cc			INT $0x3		
  0x1400bea5f		cc			INT $0x3		

TEXT gopic.(*SimulationState).Step8CollisionIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation_null.go
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x1400c51e0		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c51e4		0f867c010000		JBE 0x1400c5366		
  0x1400c51ea		55			PUSHQ BP		
  0x1400c51eb		4889e5			MOVQ SP, BP		
  0x1400c51ee		4883ec30		SUBQ $0x30, SP		
	if (t % N_SUB) != 0 {
  0x1400c51f2		48b9cdcccccccccccccc	MOVQ $0xcccccccccccccccd, CX	
  0x1400c51fc		480fafd9		IMULQ CX, BX			
  0x1400c5200		48b99899999999999919	MOVQ $0x1999999999999998, CX	
  0x1400c520a		4801d9			ADDQ BX, CX			
  0x1400c520d		48c1c13e		ROLQ $0x3e, CX			
  0x1400c5211		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x1400c521b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x1400c5220		4839ca			CMPQ DX, CX			
  0x1400c5223		0f82ba000000		JB 0x1400c52e3			
  0x1400c5229		4889442440		MOVQ AX, 0x40(SP)		
	nCollStar := sim.sampleBinomial(sim.N_i, sim.PStarI)
  0x1400c522e		8400			TESTB AL, 0(AX)						
  0x1400c5230		488b98c87e5603		MOVQ 0x3567ec8(AX), BX					
  0x1400c5237		f20f1080282eba07	MOVSD_XMM 0x7ba2e28(AX), X0				
  0x1400c523f		90			NOPL							
  0x1400c5240		e8dbf9ffff		CALL gopic.(*SimulationState).sampleBinomial(SB)	
	if nCollStar > sim.N_i {
  0x1400c5245		488b4c2440		MOVQ 0x40(SP), CX	
  0x1400c524a		488b99c87e5603		MOVQ 0x3567ec8(CX), BX	
  0x1400c5251		4839d8			CMPQ AX, BX		
	if nCollStar == 0 {
  0x1400c5254		480f4fc3		CMOVG BX, AX		
  0x1400c5258		4885c0			TESTQ AX, AX		
	if nCollStar > sim.N_i {
  0x1400c525b		7455			JE 0x1400c52b2		
	if nCollStar == 0 {
  0x1400c525d		4889c2			MOVQ AX, DX		
	sim.CandidatesI = sim.randomSample(sim.N_i, nCollStar)
  0x1400c5260		4889c8			MOVQ CX, AX					
  0x1400c5263		4889d1			MOVQ DX, CX					
  0x1400c5266		e895f8ffff		CALL gopic.(*SimulationState).randomSample(SB)	
  0x1400c526b		488b542440		MOVQ 0x40(SP), DX				
  0x1400c5270		48899a782eba07		MOVQ BX, 0x7ba2e78(DX)				
  0x1400c5277		48898a802eba07		MOVQ CX, 0x7ba2e80(DX)				
  0x1400c527e		833d2bce150000		CMPL runtime.writeBarrier(SB), $0x0		
  0x1400c5285		7413			JE 0x1400c529a					
  0x1400c5287		488b8a702eba07		MOVQ 0x7ba2e70(DX), CX				
  0x1400c528e		e84d8efbff		CALL runtime.gcWriteBarrier2(SB)		
  0x1400c5293		498903			MOVQ AX, 0(R11)					
  0x1400c5296		49894b08		MOVQ CX, 0x8(R11)				
  0x1400c529a		488982702eba07		MOVQ AX, 0x7ba2e70(DX)				
	sim.broadcastAndWait(CmdCollisionsI)
  0x1400c52a1		90			NOPL			
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c52a2		488b8a402eba07		MOVQ 0x7ba2e40(DX), CX	
  0x1400c52a9		48894c2428		MOVQ CX, 0x28(SP)	
  0x1400c52ae		31c0			XORL AX, AX		
	for w := range numWorkers {
  0x1400c52b0		eb65			JMP 0x1400c5317		
		sim.CandidatesI = nil
  0x1400c52b2		440f11b9782eba07	MOVUPS X15, 0x7ba2e78(CX)		
  0x1400c52ba		833defcd150000		CMPL runtime.writeBarrier(SB), $0x0	
  0x1400c52c1		740f			JE 0x1400c52d2				
  0x1400c52c3		488b81702eba07		MOVQ 0x7ba2e70(CX), AX			
  0x1400c52ca		e8f18dfbff		CALL runtime.gcWriteBarrier1(SB)	
  0x1400c52cf		498903			MOVQ AX, 0(R11)				
  0x1400c52d2		48c781702eba0700000000	MOVQ $0x0, 0x7ba2e70(CX)		
		return
  0x1400c52dd		4883c430		ADDQ $0x30, SP		
  0x1400c52e1		5d			POPQ BP			
  0x1400c52e2		c3			RET			
		return
  0x1400c52e3		4883c430		ADDQ $0x30, SP		
  0x1400c52e7		5d			POPQ BP			
  0x1400c52e8		c3			RET			
	for w := range numWorkers {
  0x1400c52e9		4889442418		MOVQ AX, 0x18(SP)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c52ee		488b8a382eba07		MOVQ 0x7ba2e38(DX), CX		
  0x1400c52f5		488b04c1		MOVQ 0(CX)(AX*8), AX		
  0x1400c52f9		488d5c2420		LEAQ 0x20(SP), BX		
  0x1400c52fe		6690			NOPW				
  0x1400c5300		e8fbb3f4ff		CALL runtime.chansend1(SB)	
	for w := range numWorkers {
  0x1400c5305		488b442418		MOVQ 0x18(SP), AX	
  0x1400c530a		48ffc0			INCQ AX			
  0x1400c530d		488b4c2428		MOVQ 0x28(SP), CX	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c5312		488b542440		MOVQ 0x40(SP), DX	
	for w := range numWorkers {
  0x1400c5317		4839c8			CMPQ AX, CX		
  0x1400c531a		7d37			JGE 0x1400c5353		
		sim.WorkerCmdChan[w] <- cmd
  0x1400c531c		48c744242007000000	MOVQ $0x7, 0x20(SP)	
  0x1400c5325		488bb2402eba07		MOVQ 0x7ba2e40(DX), SI	
  0x1400c532c		4839f0			CMPQ AX, SI		
  0x1400c532f		72b8			JB 0x1400c52e9		
  0x1400c5331		eb2b			JMP 0x1400c535e		
	for range numWorkers {
  0x1400c5333		48894c2428		MOVQ CX, 0x28(SP)	
		<-sim.WorkerDoneChan
  0x1400c5338		488b82502eba07		MOVQ 0x7ba2e50(DX), AX		
  0x1400c533f		31db			XORL BX, BX			
  0x1400c5341		e83ac2f4ff		CALL runtime.chanrecv1(SB)	
	for range numWorkers {
  0x1400c5346		488b4c2428		MOVQ 0x28(SP), CX	
  0x1400c534b		48ffc9			DECQ CX			
		<-sim.WorkerDoneChan
  0x1400c534e		488b542440		MOVQ 0x40(SP), DX	
	for range numWorkers {
  0x1400c5353		4885c9			TESTQ CX, CX		
  0x1400c5356		7fdb			JG 0x1400c5333		
}
  0x1400c5358		4883c430		ADDQ $0x30, SP		
  0x1400c535c		5d			POPQ BP			
  0x1400c535d		c3			RET			
		sim.WorkerCmdChan[w] <- cmd
  0x1400c535e		6690			NOPW				
  0x1400c5360		e81b91fbff		CALL runtime.panicBounds(SB)	
  0x1400c5365		90			NOPL				
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x1400c5366		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c536b		48895c2410		MOVQ BX, 0x10(SP)					
  0x1400c5370		e8cb72fbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c5375		488b442408		MOVQ 0x8(SP), AX					
  0x1400c537a		488b5c2410		MOVQ 0x10(SP), BX					
  0x1400c537f		90			NOPL							
  0x1400c5380		e95bfeffff		JMP gopic.(*SimulationState).Step8CollisionIons(SB)	

  0x1400c5385		cc			INT $0x3		
  0x1400c5386		cc			INT $0x3		
  0x1400c5387		cc			INT $0x3		
  0x1400c5388		cc			INT $0x3		
  0x1400c5389		cc			INT $0x3		
  0x1400c538a		cc			INT $0x3		
  0x1400c538b		cc			INT $0x3		
  0x1400c538c		cc			INT $0x3		
  0x1400c538d		cc			INT $0x3		
  0x1400c538e		cc			INT $0x3		
  0x1400c538f		cc			INT $0x3		
  0x1400c5390		cc			INT $0x3		
  0x1400c5391		cc			INT $0x3		
  0x1400c5392		cc			INT $0x3		
  0x1400c5393		cc			INT $0x3		
  0x1400c5394		cc			INT $0x3		
  0x1400c5395		cc			INT $0x3		
  0x1400c5396		cc			INT $0x3		
  0x1400c5397		cc			INT $0x3		
  0x1400c5398		cc			INT $0x3		
  0x1400c5399		cc			INT $0x3		
  0x1400c539a		cc			INT $0x3		
  0x1400c539b		cc			INT $0x3		
  0x1400c539c		cc			INT $0x3		
  0x1400c539d		cc			INT $0x3		
  0x1400c539e		cc			INT $0x3		
  0x1400c539f		cc			INT $0x3		
