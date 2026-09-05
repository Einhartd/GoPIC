TEXT gopic.(*SimulationState).CollisionIon(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/collisions.go
func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int, workerID int) {
  0x4c430		4c8d6424d8		LEAQ -0x28(SP), R12	
  0x4c435		4d3b6610		CMPQ R12, 0x10(R14)	
  0x4c439		0f8604040000		JBE 0x4c843		
  0x4c43f		55			PUSHQ BP		
  0x4c440		4889e5			MOVQ SP, BP		
  0x4c443		4881eca0000000		SUBQ $0xa0, SP		
	t1 := sim.Sigma[I_ISO][e_index]
  0x4c44a		8400			TESTB AL, 0(AX)				
  0x4c44c		0f1f4000		NOPL 0(AX)				
  0x4c450		4981fa40420f00		CMPQ R10, $0xf4240			
  0x4c457		0f83db030000		JAE 0x4c838				
  0x4c45d		48898424b0000000	MOVQ AX, 0xb0(SP)			
  0x4c465		48899c24b8000000	MOVQ BX, 0xb8(SP)			
  0x4c46d		48898c24c0000000	MOVQ CX, 0xc0(SP)			
  0x4c475		4889bc24c8000000	MOVQ DI, 0xc8(SP)			
  0x4c47d		4889b424d0000000	MOVQ SI, 0xd0(SP)			
  0x4c485		4c898424d8000000	MOVQ R8, 0xd8(SP)			
  0x4c48d		4c898c24e0000000	MOVQ R9, 0xe0(SP)			
  0x4c495		4c899c24f0000000	MOVQ R11, 0xf0(SP)			
  0x4c49d		f2420f1084d0c0366e01	MOVSD_XMM 0x16e36c0(AX)(R10*8), X0	
  0x4c4a7		f20f11442430		MOVSD_XMM X0, 0x30(SP)			
	t2 := t1 + sim.Sigma[I_BACK][e_index]
  0x4c4ad		f2420f1084d0c048e801	MOVSD_XMM 0x1e848c0(AX)(R10*8), X0	
  0x4c4b7		f20f11842498000000	MOVSD_XMM X0, 0x98(SP)			
	rnd := sim.WorkerR01(workerID)
  0x4c4c0		4c89db			MOVQ R11, BX		
  0x4c4c3		e800000000		CALL 0x4c4c8		[1:5]R_CALL:gopic.(*SimulationState).WorkerR01	
	t2 := t1 + sim.Sigma[I_BACK][e_index]
  0x4c4c8		f20f108c2498000000	MOVSD_XMM 0x98(SP), X1	
  0x4c4d1		f20f10542430		MOVSD_XMM 0x30(SP), X2	
  0x4c4d7		f20f58ca		ADDSD X2, X1		
	if rnd*t2 >= t1 {
  0x4c4db		f20f59c1		MULSD X1, X0		
  0x4c4df		660f2ec2		UCOMISD X2, X0		
  0x4c4e3		0f83fe020000		JAE 0x4c7e7		
	gx := (*vx_1) - (*vx_2)
  0x4c4e9		488b8c24b8000000	MOVQ 0xb8(SP), CX	
  0x4c4f1		f20f1001		MOVSD_XMM 0(CX), X0	
  0x4c4f5		488b9424d0000000	MOVQ 0xd0(SP), DX	
  0x4c4fd		f20f100a		MOVSD_XMM 0(DX), X1	
  0x4c501		0f10d0			MOVUPS X0, X2		
  0x4c504		f20f5cc1		SUBSD X1, X0		
	gy := (*vy_1) - (*vy_2)
  0x4c508		488b9424c0000000	MOVQ 0xc0(SP), DX	
  0x4c510		f20f101a		MOVSD_XMM 0(DX), X3	
  0x4c514		488bb424d8000000	MOVQ 0xd8(SP), SI	
  0x4c51c		f20f1026		MOVSD_XMM 0(SI), X4	
  0x4c520		0f10eb			MOVUPS X3, X5		
  0x4c523		f20f5cdc		SUBSD X4, X3		
	gz := (*vz_1) - (*vz_2)
  0x4c527		488bb424c8000000	MOVQ 0xc8(SP), SI	
  0x4c52f		f20f1036		MOVSD_XMM 0(SI), X6	
	wx := 0.5 * ((*vx_1) + (*vx_2))
  0x4c533		f20f58d1		ADDSD X1, X2		
	wy := 0.5 * ((*vy_1) + (*vy_2))
  0x4c537		f20f58e5		ADDSD X5, X4		
	gz := (*vz_1) - (*vz_2)
  0x4c53b		488bbc24e0000000	MOVQ 0xe0(SP), DI	
  0x4c543		f20f100f		MOVSD_XMM 0(DI), X1	
  0x4c547		0f10ee			MOVUPS X6, X5		
  0x4c54a		f20f5cf1		SUBSD X1, X6		
	g_perp_sq := gy*gy + gz*gz
  0x4c54e		0f10fe			MOVUPS X6, X7		
  0x4c551		f20f59f6		MULSD X6, X6		
  0x4c555		c4e2e1b9f3		VFMADD231SD X3, X3, X6	
	g_sq := gx*gx + g_perp_sq
  0x4c55a		440f10c6		MOVUPS X6, X8		
  0x4c55e		c4e2f9b9f0		VFMADD231SD X0, X0, X6	
	wz := 0.5 * ((*vz_1) + (*vz_2))
  0x4c563		f20f58cd		ADDSD X5, X1		
	return sqrt(x)
  0x4c567		f20f51ee		SQRTSD X6, X5		
	g := math.Sqrt(g_sq)
  0x4c56b		90			NOPL			
	g_perp := math.Sqrt(g_perp_sq)
  0x4c56c		90			NOPL			
	wx := 0.5 * ((*vx_1) + (*vx_2))
  0x4c56d		f20f103500000000	MOVSD_XMM 0(IP), X6	[4:8]R_PCREL:$f64.3fe0000000000000	
  0x4c575		f20f59d6		MULSD X6, X2		
	wy := 0.5 * ((*vy_1) + (*vy_2))
  0x4c579		f20f59e6		MULSD X6, X4		
	wz := 0.5 * ((*vz_1) + (*vz_2))
  0x4c57d		f20f59ce		MULSD X6, X1		
	return sqrt(x)
  0x4c581		f2410f51f0		SQRTSD X8, X6		
	if g > 0.0 {
  0x4c586		450f57c0		XORPS X8, X8		
  0x4c58a		66410f2ee8		UCOMISD X8, X5		
  0x4c58f		90			NOPL			
  0x4c590		760e			JBE 0x4c5a0		
		ct = gx / g
  0x4c592		f20f5ec5		DIVSD X5, X0		
		st = g_perp / g
  0x4c596		440f10ce		MOVUPS X6, X9		
  0x4c59a		f20f5ef5		DIVSD X5, X6		
  0x4c59e		eb0f			JMP 0x4c5af		
	if g_perp > 0.0 {
  0x4c5a0		440f10ce		MOVUPS X6, X9		
  0x4c5a4		0f57f6			XORPS X6, X6		
  0x4c5a7		f20f100500000000	MOVSD_XMM 0(IP), X0	[4:8]R_PCREL:$f64.3ff0000000000000	
	return sqrt(x)
  0x4c5af		f20f116c2410		MOVSD_XMM X5, 0x10(SP)	
	wx := 0.5 * ((*vx_1) + (*vx_2))
  0x4c5b5		f20f11542428		MOVSD_XMM X2, 0x28(SP)	
	wy := 0.5 * ((*vy_1) + (*vy_2))
  0x4c5bb		f20f11642420		MOVSD_XMM X4, 0x20(SP)	
	wz := 0.5 * ((*vz_1) + (*vz_2))
  0x4c5c1		f20f114c2418		MOVSD_XMM X1, 0x18(SP)	
	if g_perp > 0.0 {
  0x4c5c7		f20f11742438		MOVSD_XMM X6, 0x38(SP)	
  0x4c5cd		f20f11442448		MOVSD_XMM X0, 0x48(SP)	
  0x4c5d3		66450f2ec8		UCOMISD X8, X9		
  0x4c5d8		760c			JBE 0x4c5e6		
		cp = gy / g_perp
  0x4c5da		f2410f5ed9		DIVSD X9, X3		
		sp = gz / g_perp
  0x4c5df		f2410f5ef9		DIVSD X9, X7		
  0x4c5e4		eb0b			JMP 0x4c5f1		
  0x4c5e6		f20f101d00000000	MOVSD_XMM 0(IP), X3	[4:8]R_PCREL:$f64.3ff0000000000000	
  0x4c5ee		0f57ff			XORPS X7, X7		
	cc := 1.0 - 2.0*sim.WorkerR01(workerID)
  0x4c5f1		f20f117c2440		MOVSD_XMM X7, 0x40(SP)	
  0x4c5f7		f20f115c2450		MOVSD_XMM X3, 0x50(SP)	
  0x4c5fd		488b8424b0000000	MOVQ 0xb0(SP), AX	
  0x4c605		488b9c24f0000000	MOVQ 0xf0(SP), BX	
  0x4c60d		0f1f00			NOPL 0(AX)		
  0x4c610		e800000000		CALL 0x4c615		[1:5]R_CALL:gopic.(*SimulationState).WorkerR01	
  0x4c615		f20f58c0		ADDSD X0, X0		
  0x4c619		f20f100d00000000	MOVSD_XMM 0(IP), X1	[4:8]R_PCREL:$f64.3ff0000000000000	
  0x4c621		f20f5cc8		SUBSD X0, X1		
  0x4c625		f20f114c2458		MOVSD_XMM X1, 0x58(SP)	
	sc := math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4c62b		0f57c0			XORPS X0, X0		
  0x4c62e		f20f101500000000	MOVSD_XMM 0(IP), X2	[4:8]R_PCREL:$f64.8000000000000000	
  0x4c636		660fefc2		PXOR X2, X0		
  0x4c63a		0f10d9			MOVUPS X1, X3		
  0x4c63d		f20f59c9		MULSD X1, X1		
  0x4c641		f20f102500000000	MOVSD_XMM 0(IP), X4	[4:8]R_PCREL:$f64.3ff0000000000000	
  0x4c649		f20f5ce1		SUBSD X1, X4		
  0x4c64d		660fefe2		PXOR X2, X4		
  0x4c651		0f10c8			MOVUPS X0, X1		
  0x4c654		f20f5dc4		MINSD X4, X0		
  0x4c658		0f10e0			MOVUPS X0, X4		
  0x4c65b		f20f5dc1		MINSD X1, X0		
  0x4c65f		660febc4		POR X4, X0		
  0x4c663		660fefc2		PXOR X2, X0		
	gx = g * (ct*cc - st*sc*ce)
  0x4c667		f20f104c2448		MOVSD_XMM 0x48(SP), X1	
  0x4c66d		f20f59d9		MULSD X1, X3		
  0x4c671		f20f119c2498000000	MOVSD_XMM X3, 0x98(SP)	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4c67a		f20f10542438		MOVSD_XMM 0x38(SP), X2	
  0x4c680		f20f105c2450		MOVSD_XMM 0x50(SP), X3	
  0x4c686		0f10e2			MOVUPS X2, X4		
  0x4c689		f20f59d3		MULSD X3, X2		
  0x4c68d		f20f11942490000000	MOVSD_XMM X2, 0x90(SP)	
  0x4c696		0f10d1			MOVUPS X1, X2		
  0x4c699		f20f59cb		MULSD X3, X1		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4c69d		f20f106c2440		MOVSD_XMM 0x40(SP), X5	
  0x4c6a3		0f10f4			MOVUPS X4, X6		
  0x4c6a6		f20f59e5		MULSD X5, X4		
  0x4c6aa		f20f11a42488000000	MOVSD_XMM X4, 0x88(SP)	
  0x4c6b3		f20f59d5		MULSD X5, X2		
	return sqrt(x)
  0x4c6b7		f20f51c0		SQRTSD X0, X0		
	gx = g * (ct*cc - st*sc*ce)
  0x4c6bb		f20f59f0		MULSD X0, X6		
  0x4c6bf		f20f11b42480000000	MOVSD_XMM X6, 0x80(SP)	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4c6c8		f20f59c8		MULSD X0, X1		
  0x4c6cc		f20f114c2478		MOVSD_XMM X1, 0x78(SP)	
  0x4c6d2		f20f59e8		MULSD X0, X5		
  0x4c6d6		f20f116c2470		MOVSD_XMM X5, 0x70(SP)	
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4c6dc		f20f59d0		MULSD X0, X2		
  0x4c6e0		f20f11542468		MOVSD_XMM X2, 0x68(SP)	
  0x4c6e6		f20f59d8		MULSD X0, X3		
  0x4c6ea		f20f115c2460		MOVSD_XMM X3, 0x60(SP)	
	eta := TWO_PI * sim.WorkerR01(workerID)
  0x4c6f0		488b8424b0000000	MOVQ 0xb0(SP), AX	
  0x4c6f8		488b9c24f0000000	MOVQ 0xf0(SP), BX	
  0x4c700		e800000000		CALL 0x4c705		[1:5]R_CALL:gopic.(*SimulationState).WorkerR01	
  0x4c705		f20f100d00000000	MOVSD_XMM 0(IP), X1	[4:8]R_PCREL:$f64.401921fb54442d18		
  0x4c70d		f20f59c1		MULSD X1, X0		
	se, ce := math.Sincos(eta)
  0x4c711		e800000000		CALL 0x4c716		[1:5]R_CALL:math.Sincos	
	gx = g * (ct*cc - st*sc*ce)
  0x4c716		f20f10942480000000	MOVSD_XMM 0x80(SP), X2	
  0x4c71f		f20f59d1		MULSD X1, X2		
  0x4c723		f20f109c2498000000	MOVSD_XMM 0x98(SP), X3	
  0x4c72c		f20f5cda		SUBSD X2, X3		
  0x4c730		f20f10542410		MOVSD_XMM 0x10(SP), X2	
  0x4c736		f20f59da		MULSD X2, X3		
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4c73a		f20f10642478		MOVSD_XMM 0x78(SP), X4	
  0x4c740		f20f59e1		MULSD X1, X4		
  0x4c744		f20f10ac2490000000	MOVSD_XMM 0x90(SP), X5	
  0x4c74d		f20f10742458		MOVSD_XMM 0x58(SP), X6	
  0x4c753		c4e2d1b9e6		VFMADD231SD X6, X5, X4	
  0x4c758		f20f106c2470		MOVSD_XMM 0x70(SP), X5	
  0x4c75e		f20f59e8		MULSD X0, X5		
  0x4c762		f20f5ce5		SUBSD X5, X4		
  0x4c766		f20f59e2		MULSD X2, X4		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4c76a		f20f106c2468		MOVSD_XMM 0x68(SP), X5	
  0x4c770		f20f59e9		MULSD X1, X5		
  0x4c774		f20f108c2488000000	MOVSD_XMM 0x88(SP), X1	
  0x4c77d		c4e2f1b9ee		VFMADD231SD X6, X1, X5	
  0x4c782		f20f104c2460		MOVSD_XMM 0x60(SP), X1	
  0x4c788		c4e2f1b9e8		VFMADD231SD X0, X1, X5	
  0x4c78d		f20f59d5		MULSD X5, X2		
	*vx_1 = wx + 0.5*gx
  0x4c791		f20f10442428		MOVSD_XMM 0x28(SP), X0	
  0x4c797		f20f100d00000000	MOVSD_XMM 0(IP), X1	[4:8]R_PCREL:$f64.3fe0000000000000	
  0x4c79f		c4e2e1b9c1		VFMADD231SD X1, X3, X0	
  0x4c7a4		488b8c24b8000000	MOVQ 0xb8(SP), CX	
  0x4c7ac		f20f1101		MOVSD_XMM X0, 0(CX)	
	*vy_1 = wy + 0.5*gy
  0x4c7b0		f20f10442420		MOVSD_XMM 0x20(SP), X0	
  0x4c7b6		c4e2d9b9c1		VFMADD231SD X1, X4, X0	
  0x4c7bb		488b8c24c0000000	MOVQ 0xc0(SP), CX	
  0x4c7c3		f20f1101		MOVSD_XMM X0, 0(CX)	
	*vz_1 = wz + 0.5*gz
  0x4c7c7		f20f10442418		MOVSD_XMM 0x18(SP), X0	
  0x4c7cd		c4e2e9b9c1		VFMADD231SD X1, X2, X0	
  0x4c7d2		488b8c24c8000000	MOVQ 0xc8(SP), CX	
  0x4c7da		f20f1101		MOVSD_XMM X0, 0(CX)	
}
  0x4c7de		4881c4a0000000		ADDQ $0xa0, SP		
  0x4c7e5		5d			POPQ BP			
  0x4c7e6		c3			RET			
		*vx_1 = *vx_2
  0x4c7e7		488b8424d0000000	MOVQ 0xd0(SP), AX	
  0x4c7ef		f20f1000		MOVSD_XMM 0(AX), X0	
  0x4c7f3		488b8424b8000000	MOVQ 0xb8(SP), AX	
  0x4c7fb		f20f1100		MOVSD_XMM X0, 0(AX)	
		*vy_1 = *vy_2
  0x4c7ff		488b8424d8000000	MOVQ 0xd8(SP), AX	
  0x4c807		f20f1000		MOVSD_XMM 0(AX), X0	
  0x4c80b		488b8424c0000000	MOVQ 0xc0(SP), AX	
  0x4c813		f20f1100		MOVSD_XMM X0, 0(AX)	
		*vz_1 = *vz_2
  0x4c817		488b8424e0000000	MOVQ 0xe0(SP), AX	
  0x4c81f		f20f1000		MOVSD_XMM 0(AX), X0	
  0x4c823		488b8424c8000000	MOVQ 0xc8(SP), AX	
  0x4c82b		f20f1100		MOVSD_XMM X0, 0(AX)	
		return
  0x4c82f		4881c4a0000000		ADDQ $0xa0, SP		
  0x4c836		5d			POPQ BP			
  0x4c837		c3			RET			
	t1 := sim.Sigma[I_ISO][e_index]
  0x4c838		b840420f00		MOVL $0xf4240, AX	
  0x4c83d		e800000000		CALL 0x4c842		[1:5]R_CALL:runtime.panicBounds	
  0x4c842		90			NOPL			
func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int, workerID int) {
  0x4c843		4889442408		MOVQ AX, 0x8(SP)				
  0x4c848		48895c2410		MOVQ BX, 0x10(SP)				
  0x4c84d		48894c2418		MOVQ CX, 0x18(SP)				
  0x4c852		48897c2420		MOVQ DI, 0x20(SP)				
  0x4c857		4889742428		MOVQ SI, 0x28(SP)				
  0x4c85c		4c89442430		MOVQ R8, 0x30(SP)				
  0x4c861		4c894c2438		MOVQ R9, 0x38(SP)				
  0x4c866		4c89542440		MOVQ R10, 0x40(SP)				
  0x4c86b		4c895c2448		MOVQ R11, 0x48(SP)				
  0x4c870		e800000000		CALL 0x4c875					[1:5]R_CALL:runtime.morestack_noctxt	
  0x4c875		488b442408		MOVQ 0x8(SP), AX				
  0x4c87a		488b5c2410		MOVQ 0x10(SP), BX				
  0x4c87f		488b4c2418		MOVQ 0x18(SP), CX				
  0x4c884		488b7c2420		MOVQ 0x20(SP), DI				
  0x4c889		488b742428		MOVQ 0x28(SP), SI				
  0x4c88e		4c8b442430		MOVQ 0x30(SP), R8				
  0x4c893		4c8b4c2438		MOVQ 0x38(SP), R9				
  0x4c898		4c8b542440		MOVQ 0x40(SP), R10				
  0x4c89d		4c8b5c2448		MOVQ 0x48(SP), R11				
  0x4c8a2		e989fbffff		JMP gopic.(*SimulationState).CollisionIon(SB)	

TEXT gopic.(*SimulationState).Step8CollisionIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation_null.go
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x538fc		493b6610		CMPQ SP, 0x10(R14)	
  0x53900		0f860f020000		JBE 0x53b15		
  0x53906		55			PUSHQ BP		
  0x53907		4889e5			MOVQ SP, BP		
  0x5390a		4883ec70		SUBQ $0x70, SP		
	if (t % N_SUB) != 0 {
  0x5390e		48b9cdcccccccccccccc	MOVQ $0xcccccccccccccccd, CX	
  0x53918		480fafcb		IMULQ BX, CX			
  0x5391c		48ba9899999999999919	MOVQ $0x1999999999999998, DX	
  0x53926		4801d1			ADDQ DX, CX			
  0x53929		48c1c13e		ROLQ $0x3e, CX			
  0x5392d		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x53937		0f1f440000		NOPL 0(AX)(AX*1)		
  0x5393c		4839ca			CMPQ DX, CX			
  0x5393f		0f82c1000000		JB 0x53a06			
  0x53945		4889842480000000	MOVQ AX, 0x80(SP)		
	nCollStar := min(sim.sampleBinomial(sim.N_i, sim.PStarI), sim.N_i)
  0x5394d		8400			TESTB AL, 0(AX)			
  0x5394f		488b98c87e5603		MOVQ 0x3567ec8(AX), BX		
  0x53956		f20f1080302eba07	MOVSD_XMM 0x7ba2e30(AX), X0	
  0x5395e		e800000000		CALL 0x53963			[1:5]R_CALL:gopic.(*SimulationState).sampleBinomial	
  0x53963		488b8c2480000000	MOVQ 0x80(SP), CX		
  0x5396b		488b99c87e5603		MOVQ 0x3567ec8(CX), BX		
  0x53972		4839d8			CMPQ AX, BX			
	if nCollStar == 0 {
  0x53975		480f4fc3		CMOVG BX, AX		
  0x53979		0f1f00			NOPL 0(AX)		
  0x5397c		4885c0			TESTQ AX, AX		
	nCollStar := min(sim.sampleBinomial(sim.N_i, sim.PStarI), sim.N_i)
  0x5397f		747f			JE 0x53a00		
	if nCollStar == 0 {
  0x53981		4889c2			MOVQ AX, DX		
	candidates := sim.randomSample(sim.N_i, nCollStar)
  0x53984		4889c8			MOVQ CX, AX		
  0x53987		4889d1			MOVQ DX, CX		
  0x5398a		e800000000		CALL 0x5398f		[1:5]R_CALL:gopic.(*SimulationState).randomSample	
	numWorkers := len(sim.WorkerEDensity)
  0x5398f		488b942480000000	MOVQ 0x80(SP), DX	
  0x53997		488b7208		MOVQ 0x8(DX), SI	
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x5399b		488d3c33		LEAQ 0(BX)(SI*1), DI	
  0x5399f		488d7fff		LEAQ -0x1(DI), DI	
  0x539a3		4885f6			TESTQ SI, SI		
  0x539a6		0f8463010000		JE 0x53b0f		
	candidates := sim.randomSample(sim.N_i, nCollStar)
  0x539ac		4889442460		MOVQ AX, 0x60(SP)	
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x539b1		48897c2458		MOVQ DI, 0x58(SP)	
	numWorkers := len(sim.WorkerEDensity)
  0x539b6		4889742450		MOVQ SI, 0x50(SP)	
	candidates := sim.randomSample(sim.N_i, nCollStar)
  0x539bb		48894c2440		MOVQ CX, 0x40(SP)	
  0x539c0		48895c2438		MOVQ BX, 0x38(SP)	
	var wg sync.WaitGroup
  0x539c5		b810000000		MOVL $0x10, AX		
  0x539ca		488d1d00000000		LEAQ 0(IP), BX		[3:7]R_PCREL:type:sync.WaitGroup	
  0x539d1		b901000000		MOVL $0x1, CX		
  0x539d6		e800000000		CALL 0x539db		[1:5]R_CALL:runtime.mallocgcSmallNoScanSC2	
  0x539db		4889442468		MOVQ AX, 0x68(SP)	
  0x539e0		4889c1			MOVQ AX, CX		
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x539e3		488b442458		MOVQ 0x58(SP), AX	
  0x539e8		488b742450		MOVQ 0x50(SP), SI	
  0x539ed		4899			CQO			
  0x539ef		48f7fe			IDIVQ SI		
  0x539f2		4889442430		MOVQ AX, 0x30(SP)	
	for w := 0; w < numWorkers; w++ {
  0x539f7		31d2			XORL DX, DX		
  0x539f9		488b7c2438		MOVQ 0x38(SP), DI	
  0x539fe		eb0f			JMP 0x53a0f		
		return
  0x53a00		4883c470		ADDQ $0x70, SP		
  0x53a04		5d			POPQ BP			
  0x53a05		c3			RET			
		return
  0x53a06		4883c470		ADDQ $0x70, SP		
  0x53a0a		5d			POPQ BP			
  0x53a0b		c3			RET			
	for w := 0; w < numWorkers; w++ {
  0x53a0c		4c89d2			MOVQ R10, DX		
  0x53a0f		4839f2			CMPQ DX, SI		
  0x53a12		0f8de9000000		JGE 0x53b01		
		start := w * chunkSize
  0x53a18		4989d0			MOVQ DX, R8		
  0x53a1b		480fafd0		IMULQ AX, DX		
		end := min((w+1)*chunkSize, totalCandidates)
  0x53a1f		4d8d4801		LEAQ 0x1(R8), R9	
  0x53a23		4d89ca			MOVQ R9, R10		
  0x53a26		4c0fafc8		IMULQ AX, R9		
  0x53a2a		4c39cf			CMPQ DI, R9		
		if start >= end {
  0x53a2d		4c0f4ccf		CMOVL DI, R9		
  0x53a31		4939d1			CMPQ R9, DX		
		end := min((w+1)*chunkSize, totalCandidates)
  0x53a34		7ed6			JLE 0x53a0c		
	for w := 0; w < numWorkers; w++ {
  0x53a36		4c89442458		MOVQ R8, 0x58(SP)	
		start := w * chunkSize
  0x53a3b		4889542420		MOVQ DX, 0x20(SP)	
		end := min((w+1)*chunkSize, totalCandidates)
  0x53a40		4c89542448		MOVQ R10, 0x48(SP)	
		if start >= end {
  0x53a45		4c894c2428		MOVQ R9, 0x28(SP)	
		wg.Go(func() {
  0x53a4a		b840000000		MOVL $0x40, AX		
  0x53a4f		488d1d00000000		LEAQ 0(IP), BX		[3:7]R_PCREL:type:noalg.struct { F uintptr; X0 int; X1 int; X2 []int; X3 *gopic.SimulationState; X4 int }	
  0x53a56		b901000000		MOVL $0x1, CX		
  0x53a5b		90			NOPL			
  0x53a5c		e800000000		CALL 0x53a61		[1:5]R_CALL:runtime.mallocgcSmallScanNoHeaderSC6		
  0x53a61		488d1500000000		LEAQ 0(IP), DX		[3:7]R_PCREL:gopic.(*SimulationState).Step8CollisionIons.func1	
  0x53a68		488910			MOVQ DX, 0(AX)		
  0x53a6b		488b542420		MOVQ 0x20(SP), DX	
  0x53a70		48895008		MOVQ DX, 0x8(AX)	
  0x53a74		488b542428		MOVQ 0x28(SP), DX	
  0x53a79		48895010		MOVQ DX, 0x10(AX)	
  0x53a7d		488b542438		MOVQ 0x38(SP), DX	
  0x53a82		48895020		MOVQ DX, 0x20(AX)	
  0x53a86		488b742440		MOVQ 0x40(SP), SI	
  0x53a8b		48897028		MOVQ SI, 0x28(AX)	
  0x53a8f		833d0000000000		CMPL 0(IP), $0x0	[2:6]R_PCREL:runtime.writeBarrier+-1	
  0x53a96		750f			JNE 0x53aa7		
  0x53a98		488b4c2460		MOVQ 0x60(SP), CX	
  0x53a9d		488bbc2480000000	MOVQ 0x80(SP), DI	
  0x53aa5		eb19			JMP 0x53ac0		
  0x53aa7		e800000000		CALL 0x53aac		[1:5]R_CALL:runtime.gcWriteBarrier2<1>	
  0x53aac		488b4c2460		MOVQ 0x60(SP), CX	
  0x53ab1		49890b			MOVQ CX, 0(R11)		
  0x53ab4		488bbc2480000000	MOVQ 0x80(SP), DI	
  0x53abc		49897b08		MOVQ DI, 0x8(R11)	
  0x53ac0		48894818		MOVQ CX, 0x18(AX)	
  0x53ac4		48897830		MOVQ DI, 0x30(AX)	
  0x53ac8		488b4c2458		MOVQ 0x58(SP), CX	
  0x53acd		48894838		MOVQ CX, 0x38(AX)	
  0x53ad1		4889c3			MOVQ AX, BX		
  0x53ad4		488b442468		MOVQ 0x68(SP), AX	
  0x53ad9		0f1f00			NOPL 0(AX)		
  0x53adc		e800000000		CALL 0x53ae1		[1:5]R_CALL:sync.(*WaitGroup).Go	
		start := w * chunkSize
  0x53ae1		488b442430		MOVQ 0x30(SP), AX	
	wg.Wait()
  0x53ae6		488b4c2468		MOVQ 0x68(SP), CX	
	for w := 0; w < numWorkers; w++ {
  0x53aeb		488b742450		MOVQ 0x50(SP), SI	
		end := min((w+1)*chunkSize, totalCandidates)
  0x53af0		488b7c2438		MOVQ 0x38(SP), DI	
	for w := 0; w < numWorkers; w++ {
  0x53af5		4c8b542448		MOVQ 0x48(SP), R10	
  0x53afa		6690			NOPW			
		wg.Go(func() {
  0x53afc		e90bffffff		JMP 0x53a0c		
	wg.Wait()
  0x53b01		4889c8			MOVQ CX, AX		
  0x53b04		e800000000		CALL 0x53b09		[1:5]R_CALL:sync.(*WaitGroup).Wait	
}
  0x53b09		4883c470		ADDQ $0x70, SP		
  0x53b0d		5d			POPQ BP			
  0x53b0e		c3			RET			
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x53b0f		e800000000		CALL 0x53b14		[1:5]R_CALL:runtime.panicdivide<1>	
  0x53b14		90			NOPL			
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x53b15		4889442408		MOVQ AX, 0x8(SP)					
  0x53b1a		48895c2410		MOVQ BX, 0x10(SP)					
  0x53b1f		e800000000		CALL 0x53b24						[1:5]R_CALL:runtime.morestack_noctxt	
  0x53b24		488b442408		MOVQ 0x8(SP), AX					
  0x53b29		488b5c2410		MOVQ 0x10(SP), BX					
  0x53b2e		e9c9fdffff		JMP gopic.(*SimulationState).Step8CollisionIons(SB)	

TEXT gopic.(*SimulationState).Step8CollisionIons.func1(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation_null.go
		wg.Go(func() {
  0x666ca		4c8d6424c8		LEAQ -0x38(SP), R12	
  0x666cf		4d3b6610		CMPQ R12, 0x10(R14)	
  0x666d3		0f86dc020000		JBE 0x669b5		
  0x666d9		55			PUSHQ BP		
  0x666da		4889e5			MOVQ SP, BP		
  0x666dd		4881ecb0000000		SUBQ $0xb0, SP		
  0x666e4		488b4a38		MOVQ 0x38(DX), CX	
  0x666e8		48894c2450		MOVQ CX, 0x50(SP)	
  0x666ed		488b5a30		MOVQ 0x30(DX), BX	
  0x666f1		48899c24a0000000	MOVQ BX, 0xa0(SP)	
  0x666f9		488b7220		MOVQ 0x20(DX), SI	
  0x666fd		4889b42498000000	MOVQ SI, 0x98(SP)	
  0x66705		488b7a10		MOVQ 0x10(DX), DI	
  0x66709		4889bc2490000000	MOVQ DI, 0x90(SP)	
  0x66711		4c8b4218		MOVQ 0x18(DX), R8	
  0x66715		4c898424a8000000	MOVQ R8, 0xa8(SP)	
  0x6671d		488b5208		MOVQ 0x8(DX), DX	
  0x66721		31c0			XORL AX, AX		
			for i := s; i < e; i++ {
  0x66723		eb2e			JMP 0x66753		
  0x66725		488b942488000000	MOVQ 0x88(SP), DX	
  0x6672d		48ffc2			INCQ DX			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x66730		4889c3			MOVQ AX, BX		
				k := candidates[i]
  0x66733		488bb42498000000	MOVQ 0x98(SP), SI	
			for i := s; i < e; i++ {
  0x6673b		488bbc2490000000	MOVQ 0x90(SP), DI	
				k := candidates[i]
  0x66743		4c8b8424a8000000	MOVQ 0xa8(SP), R8	
			for i := s; i < e; i++ {
  0x6674b		4889c8			MOVQ CX, AX		
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x6674e		488b4c2450		MOVQ 0x50(SP), CX	
			for i := s; i < e; i++ {
  0x66753		4839fa			CMPQ DX, DI		
  0x66756		0f8d13020000		JGE 0x6696f		
				k := candidates[i]
  0x6675c		4839f2			CMPQ DX, SI		
  0x6675f		0f834a020000		JAE 0x669af		
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x66765		8403			TESTB AL, 0(BX)		
  0x66767		4c8b8bf82dba07		MOVQ 0x7ba2df8(BX), R9	
				k := candidates[i]
  0x6676e		4d8b14d0		MOVQ 0(R8)(DX*8), R10	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x66772		4939c9			CMPQ R9, CX		
  0x66775		0f862b020000		JBE 0x669a6		
			for i := s; i < e; i++ {
  0x6677b		4889942488000000	MOVQ DX, 0x88(SP)	
				k := candidates[i]
  0x66783		4c89942480000000	MOVQ R10, 0x80(SP)	
			for i := s; i < e; i++ {
  0x6678b		4889442478		MOVQ AX, 0x78(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x66790		488b93f02dba07		MOVQ 0x7ba2df0(BX), DX	
  0x66797		488b04ca		MOVQ 0(DX)(CX*8), AX	
  0x6679b		e800000000		CALL 0x667a0		[1:5]R_CALL:math/rand.(*Rand).NormFloat64	
  0x667a0		f20f590500000000	MULSD 0(IP), X0		[4:8]R_PCREL:gopic.RMB_sigma			
				vxA := sim.WorkerRMB(workerID)
  0x667a8		f20f11442468		MOVSD_XMM X0, 0x68(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x667ae		488b8c24a0000000	MOVQ 0xa0(SP), CX	
  0x667b6		488b91f82dba07		MOVQ 0x7ba2df8(CX), DX	
  0x667bd		488b5c2450		MOVQ 0x50(SP), BX	
  0x667c2		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x667ca		4839da			CMPQ DX, BX		
  0x667cd		0f86ce010000		JBE 0x669a1		
  0x667d3		488b89f02dba07		MOVQ 0x7ba2df0(CX), CX	
  0x667da		488b04d9		MOVQ 0(CX)(BX*8), AX	
  0x667de		e800000000		CALL 0x667e3		[1:5]R_CALL:math/rand.(*Rand).NormFloat64	
  0x667e3		f20f590500000000	MULSD 0(IP), X0		[4:8]R_PCREL:gopic.RMB_sigma			
				vyA := sim.WorkerRMB(workerID)
  0x667eb		f20f11442460		MOVSD_XMM X0, 0x60(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x667f1		488b8c24a0000000	MOVQ 0xa0(SP), CX	
  0x667f9		488b91f82dba07		MOVQ 0x7ba2df8(CX), DX	
  0x66800		488b5c2450		MOVQ 0x50(SP), BX	
  0x66805		0f1f440000		NOPL 0(AX)(AX*1)	
  0x6680a		4839da			CMPQ DX, BX		
  0x6680d		0f8689010000		JBE 0x6699c		
  0x66813		488b89f02dba07		MOVQ 0x7ba2df0(CX), CX	
  0x6681a		488b04d9		MOVQ 0(CX)(BX*8), AX	
  0x6681e		e800000000		CALL 0x66823		[1:5]R_CALL:math/rand.(*Rand).NormFloat64	
  0x66823		f20f590500000000	MULSD 0(IP), X0		[4:8]R_PCREL:gopic.RMB_sigma			
				vzA := sim.WorkerRMB(workerID)
  0x6682b		f20f11442458		MOVSD_XMM X0, 0x58(SP)	
				gx := sim.Vx_i[k] - vxA
  0x66831		488b8c2480000000	MOVQ 0x80(SP), CX			
  0x66839		4881f940420f00		CMPQ CX, $0xf4240			
  0x66840		0f834c010000		JAE 0x66992				
  0x66846		488b8424a0000000	MOVQ 0xa0(SP), AX			
  0x6684e		f20f108cc8d0d8b805	MOVSD_XMM 0x5b8d8d0(AX)(CX*8), X1	
  0x66857		f20f5c4c2468		SUBSD 0x68(SP), X1			
				gy := sim.Vy_i[k] - vyA
  0x6685d		f20f1094c8d0ea3206	MOVSD_XMM 0x632ead0(AX)(CX*8), X2	
  0x66866		f20f5c542460		SUBSD 0x60(SP), X2			
				gz := sim.Vz_i[k] - vzA
  0x6686c		f20f109cc8d0fcac06	MOVSD_XMM 0x6acfcd0(AX)(CX*8), X3	
  0x66875		f20f5cd8		SUBSD X0, X3				
				gSqr := gx*gx + gy*gy + gz*gz
  0x66879		f20f59d2		MULSD X2, X2		
  0x6687d		c4e2f1b9d1		VFMADD231SD X1, X1, X2	
  0x66882		c4e2e1b9d3		VFMADD231SD X3, X3, X2	
				eIdx := minInt(int(gSqr*FACTOR_ENERGY_I+0.5), CS_RANGES-1)
  0x66887		f20f100500000000	MOVSD_XMM 0(IP), X0	[4:8]R_PCREL:$f64.3fe0000000000000	
  0x6688f		f20f100d00000000	MOVSD_XMM 0(IP), X1	[4:8]R_PCREL:$f64.3f1b224d182a4f02	
  0x66897		c4e2f1b9c2		VFMADD231SD X2, X1, X0	
  0x6689c		f2480f2cd0		CVTTSD2SIQ X0, DX	
				g := math.Sqrt(gSqr)
  0x668a1		90			NOPL			
  0x668a2		0f1f840000000000	NOPL 0(AX)(AX*1)	
	if a < b {
  0x668aa		4881fa3f420f00		CMPQ DX, $0xf423f	
  0x668b1		7c05			JL 0x668b8		
  0x668b3		ba3f420f00		MOVL $0xf423f, DX	
				realNu := sim.SigmaTotI[eIdx] * g
  0x668b8		4881fa40420f00		CMPQ DX, $0xf4240	
  0x668bf		0f83c3000000		JAE 0x66988		
				eIdx := minInt(int(gSqr*FACTOR_ENERGY_I+0.5), CS_RANGES-1)
  0x668c5		4889542448		MOVQ DX, 0x48(SP)	
	return sqrt(x)
  0x668ca		f20f51c2		SQRTSD X2, X0		
				realNu := sim.SigmaTotI[eIdx] * g
  0x668ce		f20f5984d0c06cdc02	MULSD 0x2dc6cc0(AX)(DX*8), X0	
  0x668d7		f20f11442470		MOVSD_XMM X0, 0x70(SP)		
				if sim.WorkerR01(workerID)*sim.NuStarI < realNu {
  0x668dd		488b5c2450		MOVQ 0x50(SP), BX	
  0x668e2		e800000000		CALL 0x668e7		[1:5]R_CALL:gopic.(*SimulationState).WorkerR01	
  0x668e7		488b8424a0000000	MOVQ 0xa0(SP), AX	
  0x668ef		f20f5980282eba07	MULSD 0x7ba2e28(AX), X0	
  0x668f7		f20f104c2470		MOVSD_XMM 0x70(SP), X1	
  0x668fd		660f2ec8		UCOMISD X0, X1		
  0x66901		770c			JA 0x6690f		
  0x66903		488b4c2478		MOVQ 0x78(SP), CX	
  0x66908		6690			NOPW			
  0x6690a		e916feffff		JMP 0x66725		
					sim.CollisionIon(&sim.Vx_i[k], &sim.Vy_i[k], &sim.Vz_i[k], &vxA, &vyA, &vzA, eIdx, workerID)
  0x6690f		488b942480000000	MOVQ 0x80(SP), DX	
  0x66917		488d1cd0		LEAQ 0(AX)(DX*8), BX	
  0x6691b		488d9bd0d8b805		LEAQ 0x5b8d8d0(BX), BX	
  0x66922		488d0cd0		LEAQ 0(AX)(DX*8), CX	
  0x66926		488d89d0ea3206		LEAQ 0x632ead0(CX), CX	
  0x6692d		488d3cd0		LEAQ 0(AX)(DX*8), DI	
  0x66931		488dbfd0fcac06		LEAQ 0x6acfcd0(DI), DI	
  0x66938		488d742468		LEAQ 0x68(SP), SI	
  0x6693d		4c8d442460		LEAQ 0x60(SP), R8	
  0x66942		4c8d4c2458		LEAQ 0x58(SP), R9	
  0x66947		4c8b542448		MOVQ 0x48(SP), R10	
  0x6694c		4c8b5c2450		MOVQ 0x50(SP), R11	
  0x66951		e800000000		CALL 0x66956		[1:5]R_CALL:gopic.(*SimulationState).CollisionIon	
					localColl++
  0x66956		488b442478		MOVQ 0x78(SP), AX	
  0x6695b		48ffc0			INCQ AX			
  0x6695e		4889c1			MOVQ AX, CX		
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x66961		488b8424a0000000	MOVQ 0xa0(SP), AX	
  0x66969		90			NOPL			
					localColl++
  0x6696a		e9b6fdffff		JMP 0x66725		
			if localColl > 0 {
  0x6696f		4885c0			TESTQ AX, AX		
  0x66972		760b			JBE 0x6697f		
				atomic.AddUint64(&sim.N_i_coll, localColl)
  0x66974		8403			TESTB AL, 0(BX)			
  0x66976		f0480fc183982dba07	LOCK XADDQ AX, 0x7ba2d98(BX)	
		})
  0x6697f		4881c4b0000000		ADDQ $0xb0, SP		
  0x66986		5d			POPQ BP			
  0x66987		c3			RET			
				realNu := sim.SigmaTotI[eIdx] * g
  0x66988		b840420f00		MOVL $0xf4240, AX	
  0x6698d		e800000000		CALL 0x66992		[1:5]R_CALL:runtime.panicBounds	
				gx := sim.Vx_i[k] - vxA
  0x66992		b840420f00		MOVL $0xf4240, AX	
  0x66997		e800000000		CALL 0x6699c		[1:5]R_CALL:runtime.panicBounds	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x6699c		e800000000		CALL 0x669a1		[1:5]R_CALL:runtime.panicBounds	
  0x669a1		e800000000		CALL 0x669a6		[1:5]R_CALL:runtime.panicBounds	
  0x669a6		0f1f4000		NOPL 0(AX)		
  0x669aa		e800000000		CALL 0x669af		[1:5]R_CALL:runtime.panicBounds	
				k := candidates[i]
  0x669af		e800000000		CALL 0x669b4		[1:5]R_CALL:runtime.panicBounds	
  0x669b4		90			NOPL			
		wg.Go(func() {
  0x669b5		e800000000		CALL 0x669ba							[1:5]R_CALL:runtime.morestack	
  0x669ba		e90bfdffff		JMP gopic.(*SimulationState).Step8CollisionIons.func1(SB)	
