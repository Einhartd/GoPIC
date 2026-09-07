TEXT gopic.(*SimulationState).CollisionIon(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/collisions.go
func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int, workerID int) {
  0x4b73c0		4c8d6424d8		LEAQ -0x28(SP), R12	
  0x4b73c5		4d3b6610		CMPQ R12, 0x10(R14)	
  0x4b73c9		0f8604040000		JBE 0x4b77d3		
  0x4b73cf		55			PUSHQ BP		
  0x4b73d0		4889e5			MOVQ SP, BP		
  0x4b73d3		4881eca0000000		SUBQ $0xa0, SP		
	t1 := sim.Sigma[I_ISO][e_index]
  0x4b73da		8400			TESTB AL, 0(AX)				
  0x4b73dc		0f1f4000		NOPL 0(AX)				
  0x4b73e0		4981fa40420f00		CMPQ R10, $0xf4240			
  0x4b73e7		0f83db030000		JAE 0x4b77c8				
  0x4b73ed		48898424b0000000	MOVQ AX, 0xb0(SP)			
  0x4b73f5		48899c24b8000000	MOVQ BX, 0xb8(SP)			
  0x4b73fd		48898c24c0000000	MOVQ CX, 0xc0(SP)			
  0x4b7405		4889bc24c8000000	MOVQ DI, 0xc8(SP)			
  0x4b740d		4889b424d0000000	MOVQ SI, 0xd0(SP)			
  0x4b7415		4c898424d8000000	MOVQ R8, 0xd8(SP)			
  0x4b741d		4c898c24e0000000	MOVQ R9, 0xe0(SP)			
  0x4b7425		4c899c24f0000000	MOVQ R11, 0xf0(SP)			
  0x4b742d		f2420f1084d0c0366e01	MOVSD_XMM 0x16e36c0(AX)(R10*8), X0	
  0x4b7437		f20f11442430		MOVSD_XMM X0, 0x30(SP)			
	t2 := t1 + sim.Sigma[I_BACK][e_index]
  0x4b743d		f2420f1084d0c048e801	MOVSD_XMM 0x1e848c0(AX)(R10*8), X0	
  0x4b7447		f20f11842498000000	MOVSD_XMM X0, 0x98(SP)			
	rnd := sim.WorkerR01(workerID)
  0x4b7450		4c89db			MOVQ R11, BX					
  0x4b7453		e8a87d0000		CALL gopic.(*SimulationState).WorkerR01(SB)	
	t2 := t1 + sim.Sigma[I_BACK][e_index]
  0x4b7458		f20f108c2498000000	MOVSD_XMM 0x98(SP), X1	
  0x4b7461		f20f10542430		MOVSD_XMM 0x30(SP), X2	
  0x4b7467		f20f58ca		ADDSD X2, X1		
	if rnd*t2 >= t1 {
  0x4b746b		f20f59c1		MULSD X1, X0		
  0x4b746f		660f2ec2		UCOMISD X2, X0		
  0x4b7473		0f83fe020000		JAE 0x4b7777		
	gx := (*vx_1) - (*vx_2)
  0x4b7479		488b8c24b8000000	MOVQ 0xb8(SP), CX	
  0x4b7481		f20f1001		MOVSD_XMM 0(CX), X0	
  0x4b7485		488b9424d0000000	MOVQ 0xd0(SP), DX	
  0x4b748d		f20f100a		MOVSD_XMM 0(DX), X1	
  0x4b7491		0f10d0			MOVUPS X0, X2		
  0x4b7494		f20f5cc1		SUBSD X1, X0		
	gy := (*vy_1) - (*vy_2)
  0x4b7498		488b9424c0000000	MOVQ 0xc0(SP), DX	
  0x4b74a0		f20f101a		MOVSD_XMM 0(DX), X3	
  0x4b74a4		488bb424d8000000	MOVQ 0xd8(SP), SI	
  0x4b74ac		f20f1026		MOVSD_XMM 0(SI), X4	
  0x4b74b0		0f10eb			MOVUPS X3, X5		
  0x4b74b3		f20f5cdc		SUBSD X4, X3		
	gz := (*vz_1) - (*vz_2)
  0x4b74b7		488bb424c8000000	MOVQ 0xc8(SP), SI	
  0x4b74bf		f20f1036		MOVSD_XMM 0(SI), X6	
	wx := 0.5 * ((*vx_1) + (*vx_2))
  0x4b74c3		f20f58d1		ADDSD X1, X2		
	wy := 0.5 * ((*vy_1) + (*vy_2))
  0x4b74c7		f20f58e5		ADDSD X5, X4		
	gz := (*vz_1) - (*vz_2)
  0x4b74cb		488bbc24e0000000	MOVQ 0xe0(SP), DI	
  0x4b74d3		f20f100f		MOVSD_XMM 0(DI), X1	
  0x4b74d7		0f10ee			MOVUPS X6, X5		
  0x4b74da		f20f5cf1		SUBSD X1, X6		
	g_perp_sq := gy*gy + gz*gz
  0x4b74de		0f10fe			MOVUPS X6, X7		
  0x4b74e1		f20f59f6		MULSD X6, X6		
  0x4b74e5		c4e2e1b9f3		VFMADD231SD X3, X3, X6	
	g_sq := gx*gx + g_perp_sq
  0x4b74ea		440f10c6		MOVUPS X6, X8		
  0x4b74ee		c4e2f9b9f0		VFMADD231SD X0, X0, X6	
	wz := 0.5 * ((*vz_1) + (*vz_2))
  0x4b74f3		f20f58cd		ADDSD X5, X1		
	return sqrt(x)
  0x4b74f7		f20f51ee		SQRTSD X6, X5		
	g := math.Sqrt(g_sq)
  0x4b74fb		90			NOPL			
	g_perp := math.Sqrt(g_perp_sq)
  0x4b74fc		90			NOPL			
	wx := 0.5 * ((*vx_1) + (*vx_2))
  0x4b74fd		f20f103593640100	MOVSD_XMM $f64.3fe0000000000000(SB), X6	
  0x4b7505		f20f59d6		MULSD X6, X2				
	wy := 0.5 * ((*vy_1) + (*vy_2))
  0x4b7509		f20f59e6		MULSD X6, X4		
	wz := 0.5 * ((*vz_1) + (*vz_2))
  0x4b750d		f20f59ce		MULSD X6, X1		
	return sqrt(x)
  0x4b7511		f2410f51f0		SQRTSD X8, X6		
	if g > 0.0 {
  0x4b7516		450f57c0		XORPS X8, X8		
  0x4b751a		66410f2ee8		UCOMISD X8, X5		
  0x4b751f		90			NOPL			
  0x4b7520		760e			JBE 0x4b7530		
		ct = gx / g
  0x4b7522		f20f5ec5		DIVSD X5, X0		
		st = g_perp / g
  0x4b7526		440f10ce		MOVUPS X6, X9		
  0x4b752a		f20f5ef5		DIVSD X5, X6		
  0x4b752e		eb0f			JMP 0x4b753f		
	if g_perp > 0.0 {
  0x4b7530		440f10ce		MOVUPS X6, X9				
  0x4b7534		0f57f6			XORPS X6, X6				
  0x4b7537		f20f100571640100	MOVSD_XMM $f64.3ff0000000000000(SB), X0	
	return sqrt(x)
  0x4b753f		f20f116c2410		MOVSD_XMM X5, 0x10(SP)	
	wx := 0.5 * ((*vx_1) + (*vx_2))
  0x4b7545		f20f11542428		MOVSD_XMM X2, 0x28(SP)	
	wy := 0.5 * ((*vy_1) + (*vy_2))
  0x4b754b		f20f11642420		MOVSD_XMM X4, 0x20(SP)	
	wz := 0.5 * ((*vz_1) + (*vz_2))
  0x4b7551		f20f114c2418		MOVSD_XMM X1, 0x18(SP)	
	if g_perp > 0.0 {
  0x4b7557		f20f11742438		MOVSD_XMM X6, 0x38(SP)	
  0x4b755d		f20f11442448		MOVSD_XMM X0, 0x48(SP)	
  0x4b7563		66450f2ec8		UCOMISD X8, X9		
  0x4b7568		760c			JBE 0x4b7576		
		cp = gy / g_perp
  0x4b756a		f2410f5ed9		DIVSD X9, X3		
		sp = gz / g_perp
  0x4b756f		f2410f5ef9		DIVSD X9, X7				
  0x4b7574		eb0b			JMP 0x4b7581				
  0x4b7576		f20f101d32640100	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x4b757e		0f57ff			XORPS X7, X7				
	cc := 1.0 - 2.0*sim.WorkerR01(workerID)
  0x4b7581		f20f117c2440		MOVSD_XMM X7, 0x40(SP)				
  0x4b7587		f20f115c2450		MOVSD_XMM X3, 0x50(SP)				
  0x4b758d		488b8424b0000000	MOVQ 0xb0(SP), AX				
  0x4b7595		488b9c24f0000000	MOVQ 0xf0(SP), BX				
  0x4b759d		0f1f00			NOPL 0(AX)					
  0x4b75a0		e85b7c0000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x4b75a5		f20f58c0		ADDSD X0, X0					
  0x4b75a9		f20f100dff630100	MOVSD_XMM $f64.3ff0000000000000(SB), X1		
  0x4b75b1		f20f5cc8		SUBSD X0, X1					
  0x4b75b5		f20f114c2458		MOVSD_XMM X1, 0x58(SP)				
	sc := math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4b75bb		0f57c0			XORPS X0, X0				
  0x4b75be		f20f101522650100	MOVSD_XMM $f64.8000000000000000(SB), X2	
  0x4b75c6		660fefc2		PXOR X2, X0				
  0x4b75ca		0f10d9			MOVUPS X1, X3				
  0x4b75cd		f20f59c9		MULSD X1, X1				
  0x4b75d1		f20f1025d7630100	MOVSD_XMM $f64.3ff0000000000000(SB), X4	
  0x4b75d9		f20f5ce1		SUBSD X1, X4				
  0x4b75dd		660fefe2		PXOR X2, X4				
  0x4b75e1		0f10c8			MOVUPS X0, X1				
  0x4b75e4		f20f5dc4		MINSD X4, X0				
  0x4b75e8		0f10e0			MOVUPS X0, X4				
  0x4b75eb		f20f5dc1		MINSD X1, X0				
  0x4b75ef		660febc4		POR X4, X0				
  0x4b75f3		660fefc2		PXOR X2, X0				
	gx = g * (ct*cc - st*sc*ce)
  0x4b75f7		f20f104c2448		MOVSD_XMM 0x48(SP), X1	
  0x4b75fd		f20f59d9		MULSD X1, X3		
  0x4b7601		f20f119c2498000000	MOVSD_XMM X3, 0x98(SP)	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b760a		f20f10542438		MOVSD_XMM 0x38(SP), X2	
  0x4b7610		f20f105c2450		MOVSD_XMM 0x50(SP), X3	
  0x4b7616		0f10e2			MOVUPS X2, X4		
  0x4b7619		f20f59d3		MULSD X3, X2		
  0x4b761d		f20f11942490000000	MOVSD_XMM X2, 0x90(SP)	
  0x4b7626		0f10d1			MOVUPS X1, X2		
  0x4b7629		f20f59cb		MULSD X3, X1		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4b762d		f20f106c2440		MOVSD_XMM 0x40(SP), X5	
  0x4b7633		0f10f4			MOVUPS X4, X6		
  0x4b7636		f20f59e5		MULSD X5, X4		
  0x4b763a		f20f11a42488000000	MOVSD_XMM X4, 0x88(SP)	
  0x4b7643		f20f59d5		MULSD X5, X2		
	return sqrt(x)
  0x4b7647		f20f51c0		SQRTSD X0, X0		
	gx = g * (ct*cc - st*sc*ce)
  0x4b764b		f20f59f0		MULSD X0, X6		
  0x4b764f		f20f11b42480000000	MOVSD_XMM X6, 0x80(SP)	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b7658		f20f59c8		MULSD X0, X1		
  0x4b765c		f20f114c2478		MOVSD_XMM X1, 0x78(SP)	
  0x4b7662		f20f59e8		MULSD X0, X5		
  0x4b7666		f20f116c2470		MOVSD_XMM X5, 0x70(SP)	
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4b766c		f20f59d0		MULSD X0, X2		
  0x4b7670		f20f11542468		MOVSD_XMM X2, 0x68(SP)	
  0x4b7676		f20f59d8		MULSD X0, X3		
  0x4b767a		f20f115c2460		MOVSD_XMM X3, 0x60(SP)	
	eta := TWO_PI * sim.WorkerR01(workerID)
  0x4b7680		488b8424b0000000	MOVQ 0xb0(SP), AX				
  0x4b7688		488b9c24f0000000	MOVQ 0xf0(SP), BX				
  0x4b7690		e86b7b0000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x4b7695		f20f100d8b630100	MOVSD_XMM $f64.401921fb54442d18(SB), X1		
  0x4b769d		f20f59c1		MULSD X1, X0					
	se, ce := math.Sincos(eta)
  0x4b76a1		e81ad9fcff		CALL math.Sincos(SB)	
	gx = g * (ct*cc - st*sc*ce)
  0x4b76a6		f20f10942480000000	MOVSD_XMM 0x80(SP), X2	
  0x4b76af		f20f59d1		MULSD X1, X2		
  0x4b76b3		f20f109c2498000000	MOVSD_XMM 0x98(SP), X3	
  0x4b76bc		f20f5cda		SUBSD X2, X3		
  0x4b76c0		f20f10542410		MOVSD_XMM 0x10(SP), X2	
  0x4b76c6		f20f59da		MULSD X2, X3		
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b76ca		f20f10642478		MOVSD_XMM 0x78(SP), X4	
  0x4b76d0		f20f59e1		MULSD X1, X4		
  0x4b76d4		f20f10ac2490000000	MOVSD_XMM 0x90(SP), X5	
  0x4b76dd		f20f10742458		MOVSD_XMM 0x58(SP), X6	
  0x4b76e3		c4e2d1b9e6		VFMADD231SD X6, X5, X4	
  0x4b76e8		f20f106c2470		MOVSD_XMM 0x70(SP), X5	
  0x4b76ee		f20f59e8		MULSD X0, X5		
  0x4b76f2		f20f5ce5		SUBSD X5, X4		
  0x4b76f6		f20f59e2		MULSD X2, X4		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4b76fa		f20f106c2468		MOVSD_XMM 0x68(SP), X5	
  0x4b7700		f20f59e9		MULSD X1, X5		
  0x4b7704		f20f108c2488000000	MOVSD_XMM 0x88(SP), X1	
  0x4b770d		c4e2f1b9ee		VFMADD231SD X6, X1, X5	
  0x4b7712		f20f104c2460		MOVSD_XMM 0x60(SP), X1	
  0x4b7718		c4e2f1b9e8		VFMADD231SD X0, X1, X5	
  0x4b771d		f20f59d5		MULSD X5, X2		
	*vx_1 = wx + 0.5*gx
  0x4b7721		f20f10442428		MOVSD_XMM 0x28(SP), X0			
  0x4b7727		f20f100d69620100	MOVSD_XMM $f64.3fe0000000000000(SB), X1	
  0x4b772f		c4e2e1b9c1		VFMADD231SD X1, X3, X0			
  0x4b7734		488b8c24b8000000	MOVQ 0xb8(SP), CX			
  0x4b773c		f20f1101		MOVSD_XMM X0, 0(CX)			
	*vy_1 = wy + 0.5*gy
  0x4b7740		f20f10442420		MOVSD_XMM 0x20(SP), X0	
  0x4b7746		c4e2d9b9c1		VFMADD231SD X1, X4, X0	
  0x4b774b		488b8c24c0000000	MOVQ 0xc0(SP), CX	
  0x4b7753		f20f1101		MOVSD_XMM X0, 0(CX)	
	*vz_1 = wz + 0.5*gz
  0x4b7757		f20f10442418		MOVSD_XMM 0x18(SP), X0	
  0x4b775d		c4e2e9b9c1		VFMADD231SD X1, X2, X0	
  0x4b7762		488b8c24c8000000	MOVQ 0xc8(SP), CX	
  0x4b776a		f20f1101		MOVSD_XMM X0, 0(CX)	
}
  0x4b776e		4881c4a0000000		ADDQ $0xa0, SP		
  0x4b7775		5d			POPQ BP			
  0x4b7776		c3			RET			
		*vx_1 = *vx_2
  0x4b7777		488b8424d0000000	MOVQ 0xd0(SP), AX	
  0x4b777f		f20f1000		MOVSD_XMM 0(AX), X0	
  0x4b7783		488b8424b8000000	MOVQ 0xb8(SP), AX	
  0x4b778b		f20f1100		MOVSD_XMM X0, 0(AX)	
		*vy_1 = *vy_2
  0x4b778f		488b8424d8000000	MOVQ 0xd8(SP), AX	
  0x4b7797		f20f1000		MOVSD_XMM 0(AX), X0	
  0x4b779b		488b8424c0000000	MOVQ 0xc0(SP), AX	
  0x4b77a3		f20f1100		MOVSD_XMM X0, 0(AX)	
		*vz_1 = *vz_2
  0x4b77a7		488b8424e0000000	MOVQ 0xe0(SP), AX	
  0x4b77af		f20f1000		MOVSD_XMM 0(AX), X0	
  0x4b77b3		488b8424c8000000	MOVQ 0xc8(SP), AX	
  0x4b77bb		f20f1100		MOVSD_XMM X0, 0(AX)	
		return
  0x4b77bf		4881c4a0000000		ADDQ $0xa0, SP		
  0x4b77c6		5d			POPQ BP			
  0x4b77c7		c3			RET			
	t1 := sim.Sigma[I_ISO][e_index]
  0x4b77c8		b840420f00		MOVL $0xf4240, AX		
  0x4b77cd		e8cea2fcff		CALL runtime.panicBounds(SB)	
  0x4b77d2		90			NOPL				
func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int, workerID int) {
  0x4b77d3		4889442408		MOVQ AX, 0x8(SP)				
  0x4b77d8		48895c2410		MOVQ BX, 0x10(SP)				
  0x4b77dd		48894c2418		MOVQ CX, 0x18(SP)				
  0x4b77e2		48897c2420		MOVQ DI, 0x20(SP)				
  0x4b77e7		4889742428		MOVQ SI, 0x28(SP)				
  0x4b77ec		4c89442430		MOVQ R8, 0x30(SP)				
  0x4b77f1		4c894c2438		MOVQ R9, 0x38(SP)				
  0x4b77f6		4c89542440		MOVQ R10, 0x40(SP)				
  0x4b77fb		4c895c2448		MOVQ R11, 0x48(SP)				
  0x4b7800		e85b86fcff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x4b7805		488b442408		MOVQ 0x8(SP), AX				
  0x4b780a		488b5c2410		MOVQ 0x10(SP), BX				
  0x4b780f		488b4c2418		MOVQ 0x18(SP), CX				
  0x4b7814		488b7c2420		MOVQ 0x20(SP), DI				
  0x4b7819		488b742428		MOVQ 0x28(SP), SI				
  0x4b781e		4c8b442430		MOVQ 0x30(SP), R8				
  0x4b7823		4c8b4c2438		MOVQ 0x38(SP), R9				
  0x4b7828		4c8b542440		MOVQ 0x40(SP), R10				
  0x4b782d		4c8b5c2448		MOVQ 0x48(SP), R11				
  0x4b7832		e989fbffff		JMP gopic.(*SimulationState).CollisionIon(SB)	

TEXT gopic.(*SimulationState).Step8CollisionIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation_null.go
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x4be560		493b6610		CMPQ SP, 0x10(R14)	
  0x4be564		0f860f020000		JBE 0x4be779		
  0x4be56a		55			PUSHQ BP		
  0x4be56b		4889e5			MOVQ SP, BP		
  0x4be56e		4883ec70		SUBQ $0x70, SP		
	if (t % N_SUB) != 0 {
  0x4be572		48b9cdcccccccccccccc	MOVQ $0xcccccccccccccccd, CX	
  0x4be57c		480fafcb		IMULQ BX, CX			
  0x4be580		48ba9899999999999919	MOVQ $0x1999999999999998, DX	
  0x4be58a		4801d1			ADDQ DX, CX			
  0x4be58d		48c1c13e		ROLQ $0x3e, CX			
  0x4be591		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x4be59b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x4be5a0		4839ca			CMPQ DX, CX			
  0x4be5a3		0f82c1000000		JB 0x4be66a			
  0x4be5a9		4889842480000000	MOVQ AX, 0x80(SP)		
	nCollStar := min(sim.sampleBinomial(sim.N_i, sim.PStarI), sim.N_i)
  0x4be5b1		8400			TESTB AL, 0(AX)						
  0x4be5b3		488b98c87e5603		MOVQ 0x3567ec8(AX), BX					
  0x4be5ba		f20f1080302eba07	MOVSD_XMM 0x7ba2e30(AX), X0				
  0x4be5c2		e8f9f8ffff		CALL gopic.(*SimulationState).sampleBinomial(SB)	
  0x4be5c7		488b8c2480000000	MOVQ 0x80(SP), CX					
  0x4be5cf		488b99c87e5603		MOVQ 0x3567ec8(CX), BX					
  0x4be5d6		4839d8			CMPQ AX, BX						
	if nCollStar == 0 {
  0x4be5d9		480f4fc3		CMOVG BX, AX		
  0x4be5dd		0f1f00			NOPL 0(AX)		
  0x4be5e0		4885c0			TESTQ AX, AX		
	nCollStar := min(sim.sampleBinomial(sim.N_i, sim.PStarI), sim.N_i)
  0x4be5e3		747f			JE 0x4be664		
	if nCollStar == 0 {
  0x4be5e5		4889c2			MOVQ AX, DX		
	candidates := sim.randomSample(sim.N_i, nCollStar)
  0x4be5e8		4889c8			MOVQ CX, AX					
  0x4be5eb		4889d1			MOVQ DX, CX					
  0x4be5ee		e8adf7ffff		CALL gopic.(*SimulationState).randomSample(SB)	
	numWorkers := len(sim.WorkerEDensity)
  0x4be5f3		488b942480000000	MOVQ 0x80(SP), DX	
  0x4be5fb		488b7208		MOVQ 0x8(DX), SI	
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x4be5ff		488d3c33		LEAQ 0(BX)(SI*1), DI	
  0x4be603		488d7fff		LEAQ -0x1(DI), DI	
  0x4be607		4885f6			TESTQ SI, SI		
  0x4be60a		0f8463010000		JE 0x4be773		
	candidates := sim.randomSample(sim.N_i, nCollStar)
  0x4be610		4889442460		MOVQ AX, 0x60(SP)	
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x4be615		48897c2458		MOVQ DI, 0x58(SP)	
	numWorkers := len(sim.WorkerEDensity)
  0x4be61a		4889742450		MOVQ SI, 0x50(SP)	
	candidates := sim.randomSample(sim.N_i, nCollStar)
  0x4be61f		48894c2440		MOVQ CX, 0x40(SP)	
  0x4be624		48895c2438		MOVQ BX, 0x38(SP)	
	var wg sync.WaitGroup
  0x4be629		b810000000		MOVL $0x10, AX				
  0x4be62e		488d1dab700f00		LEAQ 0xf70ab(IP), BX			
  0x4be635		b901000000		MOVL $0x1, CX				
  0x4be63a		e8e1fbf5ff		CALL runtime.mallocgcSmallNoScanSC2(SB)	
  0x4be63f		4889442468		MOVQ AX, 0x68(SP)			
  0x4be644		4889c1			MOVQ AX, CX				
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x4be647		488b442458		MOVQ 0x58(SP), AX	
  0x4be64c		488b742450		MOVQ 0x50(SP), SI	
  0x4be651		4899			CQO			
  0x4be653		48f7fe			IDIVQ SI		
  0x4be656		4889442430		MOVQ AX, 0x30(SP)	
	for w := 0; w < numWorkers; w++ {
  0x4be65b		31d2			XORL DX, DX		
  0x4be65d		488b7c2438		MOVQ 0x38(SP), DI	
  0x4be662		eb0f			JMP 0x4be673		
		return
  0x4be664		4883c470		ADDQ $0x70, SP		
  0x4be668		5d			POPQ BP			
  0x4be669		c3			RET			
		return
  0x4be66a		4883c470		ADDQ $0x70, SP		
  0x4be66e		5d			POPQ BP			
  0x4be66f		c3			RET			
	for w := 0; w < numWorkers; w++ {
  0x4be670		4c89d2			MOVQ R10, DX		
  0x4be673		4839f2			CMPQ DX, SI		
  0x4be676		0f8de9000000		JGE 0x4be765		
		start := w * chunkSize
  0x4be67c		4989d0			MOVQ DX, R8		
  0x4be67f		480fafd0		IMULQ AX, DX		
		end := min((w+1)*chunkSize, totalCandidates)
  0x4be683		4d8d4801		LEAQ 0x1(R8), R9	
  0x4be687		4d89ca			MOVQ R9, R10		
  0x4be68a		4c0fafc8		IMULQ AX, R9		
  0x4be68e		4c39cf			CMPQ DI, R9		
		if start >= end {
  0x4be691		4c0f4ccf		CMOVL DI, R9		
  0x4be695		4939d1			CMPQ R9, DX		
		end := min((w+1)*chunkSize, totalCandidates)
  0x4be698		7ed6			JLE 0x4be670		
	for w := 0; w < numWorkers; w++ {
  0x4be69a		4c89442458		MOVQ R8, 0x58(SP)	
		start := w * chunkSize
  0x4be69f		4889542420		MOVQ DX, 0x20(SP)	
		end := min((w+1)*chunkSize, totalCandidates)
  0x4be6a4		4c89542448		MOVQ R10, 0x48(SP)	
		if start >= end {
  0x4be6a9		4c894c2428		MOVQ R9, 0x28(SP)	
		wg.Go(func() {
  0x4be6ae		b840000000		MOVL $0x40, AX							
  0x4be6b3		488d1da6a00f00		LEAQ 0xfa0a6(IP), BX						
  0x4be6ba		b901000000		MOVL $0x1, CX							
  0x4be6bf		90			NOPL								
  0x4be6c0		e8fbf0f5ff		CALL runtime.mallocgcSmallScanNoHeaderSC6(SB)			
  0x4be6c5		488d1594230000		LEAQ gopic.(*SimulationState).Step8CollisionIons.func1(SB), DX	
  0x4be6cc		488910			MOVQ DX, 0(AX)							
  0x4be6cf		488b542420		MOVQ 0x20(SP), DX						
  0x4be6d4		48895008		MOVQ DX, 0x8(AX)						
  0x4be6d8		488b542428		MOVQ 0x28(SP), DX						
  0x4be6dd		48895010		MOVQ DX, 0x10(AX)						
  0x4be6e1		488b542438		MOVQ 0x38(SP), DX						
  0x4be6e6		48895020		MOVQ DX, 0x20(AX)						
  0x4be6ea		488b742440		MOVQ 0x40(SP), SI						
  0x4be6ef		48897028		MOVQ SI, 0x28(AX)						
  0x4be6f3		833df6e6120000		CMPL runtime.writeBarrier(SB), $0x0				
  0x4be6fa		750f			JNE 0x4be70b							
  0x4be6fc		488b4c2460		MOVQ 0x60(SP), CX						
  0x4be701		488bbc2480000000	MOVQ 0x80(SP), DI						
  0x4be709		eb19			JMP 0x4be724							
  0x4be70b		e8f02ffcff		CALL runtime.gcWriteBarrier2(SB)				
  0x4be710		488b4c2460		MOVQ 0x60(SP), CX						
  0x4be715		49890b			MOVQ CX, 0(R11)							
  0x4be718		488bbc2480000000	MOVQ 0x80(SP), DI						
  0x4be720		49897b08		MOVQ DI, 0x8(R11)						
  0x4be724		48894818		MOVQ CX, 0x18(AX)						
  0x4be728		48897830		MOVQ DI, 0x30(AX)						
  0x4be72c		488b4c2458		MOVQ 0x58(SP), CX						
  0x4be731		48894838		MOVQ CX, 0x38(AX)						
  0x4be735		4889c3			MOVQ AX, BX							
  0x4be738		488b442468		MOVQ 0x68(SP), AX						
  0x4be73d		0f1f00			NOPL 0(AX)							
  0x4be740		e87bb2fcff		CALL sync.(*WaitGroup).Go(SB)					
		start := w * chunkSize
  0x4be745		488b442430		MOVQ 0x30(SP), AX	
	wg.Wait()
  0x4be74a		488b4c2468		MOVQ 0x68(SP), CX	
	for w := 0; w < numWorkers; w++ {
  0x4be74f		488b742450		MOVQ 0x50(SP), SI	
		end := min((w+1)*chunkSize, totalCandidates)
  0x4be754		488b7c2438		MOVQ 0x38(SP), DI	
	for w := 0; w < numWorkers; w++ {
  0x4be759		4c8b542448		MOVQ 0x48(SP), R10	
  0x4be75e		6690			NOPW			
		wg.Go(func() {
  0x4be760		e90bffffff		JMP 0x4be670		
	wg.Wait()
  0x4be765		4889c8			MOVQ CX, AX			
  0x4be768		e833b1fcff		CALL sync.(*WaitGroup).Wait(SB)	
}
  0x4be76d		4883c470		ADDQ $0x70, SP		
  0x4be771		5d			POPQ BP			
  0x4be772		c3			RET			
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x4be773		e8a860f8ff		CALL runtime.panicdivide(SB)	
  0x4be778		90			NOPL				
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x4be779		4889442408		MOVQ AX, 0x8(SP)					
  0x4be77e		48895c2410		MOVQ BX, 0x10(SP)					
  0x4be783		e8d816fcff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x4be788		488b442408		MOVQ 0x8(SP), AX					
  0x4be78d		488b5c2410		MOVQ 0x10(SP), BX					
  0x4be792		e9c9fdffff		JMP gopic.(*SimulationState).Step8CollisionIons(SB)	

TEXT gopic.(*SimulationState).Step8CollisionIons.func1(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation_null.go
		wg.Go(func() {
  0x4c0a60		4c8d6424c8		LEAQ -0x38(SP), R12	
  0x4c0a65		4d3b6610		CMPQ R12, 0x10(R14)	
  0x4c0a69		0f86dc020000		JBE 0x4c0d4b		
  0x4c0a6f		55			PUSHQ BP		
  0x4c0a70		4889e5			MOVQ SP, BP		
  0x4c0a73		4881ecb0000000		SUBQ $0xb0, SP		
  0x4c0a7a		488b4a38		MOVQ 0x38(DX), CX	
  0x4c0a7e		48894c2450		MOVQ CX, 0x50(SP)	
  0x4c0a83		488b5a30		MOVQ 0x30(DX), BX	
  0x4c0a87		48899c24a0000000	MOVQ BX, 0xa0(SP)	
  0x4c0a8f		488b7220		MOVQ 0x20(DX), SI	
  0x4c0a93		4889b42498000000	MOVQ SI, 0x98(SP)	
  0x4c0a9b		488b7a10		MOVQ 0x10(DX), DI	
  0x4c0a9f		4889bc2490000000	MOVQ DI, 0x90(SP)	
  0x4c0aa7		4c8b4218		MOVQ 0x18(DX), R8	
  0x4c0aab		4c898424a8000000	MOVQ R8, 0xa8(SP)	
  0x4c0ab3		488b5208		MOVQ 0x8(DX), DX	
  0x4c0ab7		31c0			XORL AX, AX		
			for i := s; i < e; i++ {
  0x4c0ab9		eb2e			JMP 0x4c0ae9		
  0x4c0abb		488b942488000000	MOVQ 0x88(SP), DX	
  0x4c0ac3		48ffc2			INCQ DX			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c0ac6		4889c3			MOVQ AX, BX		
				k := candidates[i]
  0x4c0ac9		488bb42498000000	MOVQ 0x98(SP), SI	
			for i := s; i < e; i++ {
  0x4c0ad1		488bbc2490000000	MOVQ 0x90(SP), DI	
				k := candidates[i]
  0x4c0ad9		4c8b8424a8000000	MOVQ 0xa8(SP), R8	
			for i := s; i < e; i++ {
  0x4c0ae1		4889c8			MOVQ CX, AX		
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c0ae4		488b4c2450		MOVQ 0x50(SP), CX	
			for i := s; i < e; i++ {
  0x4c0ae9		4839fa			CMPQ DX, DI		
  0x4c0aec		0f8d13020000		JGE 0x4c0d05		
				k := candidates[i]
  0x4c0af2		4839f2			CMPQ DX, SI		
  0x4c0af5		0f834a020000		JAE 0x4c0d45		
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c0afb		8403			TESTB AL, 0(BX)		
  0x4c0afd		4c8b8bf82dba07		MOVQ 0x7ba2df8(BX), R9	
				k := candidates[i]
  0x4c0b04		4d8b14d0		MOVQ 0(R8)(DX*8), R10	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c0b08		4939c9			CMPQ R9, CX		
  0x4c0b0b		0f862b020000		JBE 0x4c0d3c		
			for i := s; i < e; i++ {
  0x4c0b11		4889942488000000	MOVQ DX, 0x88(SP)	
				k := candidates[i]
  0x4c0b19		4c89942480000000	MOVQ R10, 0x80(SP)	
			for i := s; i < e; i++ {
  0x4c0b21		4889442478		MOVQ AX, 0x78(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c0b26		488b93f02dba07		MOVQ 0x7ba2df0(BX), DX			
  0x4c0b2d		488b04ca		MOVQ 0(DX)(CX*8), AX			
  0x4c0b31		e80a51ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4c0b36		f20f59055ac01200	MULSD gopic.RMB_sigma(SB), X0		
				vxA := sim.WorkerRMB(workerID)
  0x4c0b3e		f20f11442468		MOVSD_XMM X0, 0x68(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c0b44		488b8c24a0000000	MOVQ 0xa0(SP), CX			
  0x4c0b4c		488b91f82dba07		MOVQ 0x7ba2df8(CX), DX			
  0x4c0b53		488b5c2450		MOVQ 0x50(SP), BX			
  0x4c0b58		0f1f840000000000	NOPL 0(AX)(AX*1)			
  0x4c0b60		4839da			CMPQ DX, BX				
  0x4c0b63		0f86ce010000		JBE 0x4c0d37				
  0x4c0b69		488b89f02dba07		MOVQ 0x7ba2df0(CX), CX			
  0x4c0b70		488b04d9		MOVQ 0(CX)(BX*8), AX			
  0x4c0b74		e8c750ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4c0b79		f20f590517c01200	MULSD gopic.RMB_sigma(SB), X0		
				vyA := sim.WorkerRMB(workerID)
  0x4c0b81		f20f11442460		MOVSD_XMM X0, 0x60(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c0b87		488b8c24a0000000	MOVQ 0xa0(SP), CX			
  0x4c0b8f		488b91f82dba07		MOVQ 0x7ba2df8(CX), DX			
  0x4c0b96		488b5c2450		MOVQ 0x50(SP), BX			
  0x4c0b9b		0f1f440000		NOPL 0(AX)(AX*1)			
  0x4c0ba0		4839da			CMPQ DX, BX				
  0x4c0ba3		0f8689010000		JBE 0x4c0d32				
  0x4c0ba9		488b89f02dba07		MOVQ 0x7ba2df0(CX), CX			
  0x4c0bb0		488b04d9		MOVQ 0(CX)(BX*8), AX			
  0x4c0bb4		e88750ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4c0bb9		f20f5905d7bf1200	MULSD gopic.RMB_sigma(SB), X0		
				vzA := sim.WorkerRMB(workerID)
  0x4c0bc1		f20f11442458		MOVSD_XMM X0, 0x58(SP)	
				gx := sim.Vx_i[k] - vxA
  0x4c0bc7		488b8c2480000000	MOVQ 0x80(SP), CX			
  0x4c0bcf		4881f940420f00		CMPQ CX, $0xf4240			
  0x4c0bd6		0f834c010000		JAE 0x4c0d28				
  0x4c0bdc		488b8424a0000000	MOVQ 0xa0(SP), AX			
  0x4c0be4		f20f108cc8d0d8b805	MOVSD_XMM 0x5b8d8d0(AX)(CX*8), X1	
  0x4c0bed		f20f5c4c2468		SUBSD 0x68(SP), X1			
				gy := sim.Vy_i[k] - vyA
  0x4c0bf3		f20f1094c8d0ea3206	MOVSD_XMM 0x632ead0(AX)(CX*8), X2	
  0x4c0bfc		f20f5c542460		SUBSD 0x60(SP), X2			
				gz := sim.Vz_i[k] - vzA
  0x4c0c02		f20f109cc8d0fcac06	MOVSD_XMM 0x6acfcd0(AX)(CX*8), X3	
  0x4c0c0b		f20f5cd8		SUBSD X0, X3				
				gSqr := gx*gx + gy*gy + gz*gz
  0x4c0c0f		f20f59d2		MULSD X2, X2		
  0x4c0c13		c4e2f1b9d1		VFMADD231SD X1, X1, X2	
  0x4c0c18		c4e2e1b9d3		VFMADD231SD X3, X3, X2	
				eIdx := minInt(int(gSqr*FACTOR_ENERGY_I+0.5), CS_RANGES-1)
  0x4c0c1d		f20f100573cd0000	MOVSD_XMM $f64.3fe0000000000000(SB), X0	
  0x4c0c25		f20f100d03cd0000	MOVSD_XMM $f64.3f1b224d182a4f02(SB), X1	
  0x4c0c2d		c4e2f1b9c2		VFMADD231SD X2, X1, X0			
  0x4c0c32		f2480f2cd0		CVTTSD2SIQ X0, DX			
				g := math.Sqrt(gSqr)
  0x4c0c37		90			NOPL			
  0x4c0c38		0f1f840000000000	NOPL 0(AX)(AX*1)	
	if a < b {
  0x4c0c40		4881fa3f420f00		CMPQ DX, $0xf423f	
  0x4c0c47		7c05			JL 0x4c0c4e		
  0x4c0c49		ba3f420f00		MOVL $0xf423f, DX	
				realNu := sim.SigmaTotI[eIdx] * g
  0x4c0c4e		4881fa40420f00		CMPQ DX, $0xf4240	
  0x4c0c55		0f83c3000000		JAE 0x4c0d1e		
				eIdx := minInt(int(gSqr*FACTOR_ENERGY_I+0.5), CS_RANGES-1)
  0x4c0c5b		4889542448		MOVQ DX, 0x48(SP)	
	return sqrt(x)
  0x4c0c60		f20f51c2		SQRTSD X2, X0		
				realNu := sim.SigmaTotI[eIdx] * g
  0x4c0c64		f20f5984d0c06cdc02	MULSD 0x2dc6cc0(AX)(DX*8), X0	
  0x4c0c6d		f20f11442470		MOVSD_XMM X0, 0x70(SP)		
				if sim.WorkerR01(workerID)*sim.NuStarI < realNu {
  0x4c0c73		488b5c2450		MOVQ 0x50(SP), BX				
  0x4c0c78		e883e5ffff		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x4c0c7d		488b8424a0000000	MOVQ 0xa0(SP), AX				
  0x4c0c85		f20f5980282eba07	MULSD 0x7ba2e28(AX), X0				
  0x4c0c8d		f20f104c2470		MOVSD_XMM 0x70(SP), X1				
  0x4c0c93		660f2ec8		UCOMISD X0, X1					
  0x4c0c97		770c			JA 0x4c0ca5					
  0x4c0c99		488b4c2478		MOVQ 0x78(SP), CX				
  0x4c0c9e		6690			NOPW						
  0x4c0ca0		e916feffff		JMP 0x4c0abb					
					sim.CollisionIon(&sim.Vx_i[k], &sim.Vy_i[k], &sim.Vz_i[k], &vxA, &vyA, &vzA, eIdx, workerID)
  0x4c0ca5		488b942480000000	MOVQ 0x80(SP), DX				
  0x4c0cad		488d1cd0		LEAQ 0(AX)(DX*8), BX				
  0x4c0cb1		488d9bd0d8b805		LEAQ 0x5b8d8d0(BX), BX				
  0x4c0cb8		488d0cd0		LEAQ 0(AX)(DX*8), CX				
  0x4c0cbc		488d89d0ea3206		LEAQ 0x632ead0(CX), CX				
  0x4c0cc3		488d3cd0		LEAQ 0(AX)(DX*8), DI				
  0x4c0cc7		488dbfd0fcac06		LEAQ 0x6acfcd0(DI), DI				
  0x4c0cce		488d742468		LEAQ 0x68(SP), SI				
  0x4c0cd3		4c8d442460		LEAQ 0x60(SP), R8				
  0x4c0cd8		4c8d4c2458		LEAQ 0x58(SP), R9				
  0x4c0cdd		4c8b542448		MOVQ 0x48(SP), R10				
  0x4c0ce2		4c8b5c2450		MOVQ 0x50(SP), R11				
  0x4c0ce7		e8d466ffff		CALL gopic.(*SimulationState).CollisionIon(SB)	
					localColl++
  0x4c0cec		488b442478		MOVQ 0x78(SP), AX	
  0x4c0cf1		48ffc0			INCQ AX			
  0x4c0cf4		4889c1			MOVQ AX, CX		
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c0cf7		488b8424a0000000	MOVQ 0xa0(SP), AX	
  0x4c0cff		90			NOPL			
					localColl++
  0x4c0d00		e9b6fdffff		JMP 0x4c0abb		
			if localColl > 0 {
  0x4c0d05		4885c0			TESTQ AX, AX		
  0x4c0d08		760b			JBE 0x4c0d15		
				atomic.AddUint64(&sim.N_i_coll, localColl)
  0x4c0d0a		8403			TESTB AL, 0(BX)			
  0x4c0d0c		f0480fc183982dba07	LOCK XADDQ AX, 0x7ba2d98(BX)	
		})
  0x4c0d15		4881c4b0000000		ADDQ $0xb0, SP		
  0x4c0d1c		5d			POPQ BP			
  0x4c0d1d		c3			RET			
				realNu := sim.SigmaTotI[eIdx] * g
  0x4c0d1e		b840420f00		MOVL $0xf4240, AX		
  0x4c0d23		e8780dfcff		CALL runtime.panicBounds(SB)	
				gx := sim.Vx_i[k] - vxA
  0x4c0d28		b840420f00		MOVL $0xf4240, AX		
  0x4c0d2d		e86e0dfcff		CALL runtime.panicBounds(SB)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c0d32		e8690dfcff		CALL runtime.panicBounds(SB)	
  0x4c0d37		e8640dfcff		CALL runtime.panicBounds(SB)	
  0x4c0d3c		0f1f4000		NOPL 0(AX)			
  0x4c0d40		e85b0dfcff		CALL runtime.panicBounds(SB)	
				k := candidates[i]
  0x4c0d45		e8560dfcff		CALL runtime.panicBounds(SB)	
  0x4c0d4a		90			NOPL				
		wg.Go(func() {
  0x4c0d4b		e870f0fbff		CALL runtime.morestack.abi0(SB)					
  0x4c0d50		e90bfdffff		JMP gopic.(*SimulationState).Step8CollisionIons.func1(SB)	
