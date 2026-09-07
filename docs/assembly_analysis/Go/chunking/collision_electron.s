TEXT gopic.(*SimulationState).CollisionElectron(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/collisions.go
func (sim *SimulationState) CollisionElectron(xe float64, vxe, vye, vze *float64, eindex int, workerID int) {
  0x4b68a0		4c8da42430ffffff	LEAQ 0xffffff30(SP), R12	
  0x4b68a8		4d3b6610		CMPQ R12, 0x10(R14)		
  0x4b68ac		0f86b80a0000		JBE 0x4b736a			
  0x4b68b2		55			PUSHQ BP			
  0x4b68b3		4889e5			MOVQ SP, BP			
  0x4b68b6		4881ec48010000		SUBQ $0x148, SP			
	gx := *vxe
  0x4b68bd		f20f100b		MOVSD_XMM 0(BX), X1	
	gy := *vye
  0x4b68c1		f20f1011		MOVSD_XMM 0(CX), X2	
	gz := *vze
  0x4b68c5		f20f101f		MOVSD_XMM 0(DI), X3	
	g_perp_sq := gy*gy + gz*gz
  0x4b68c9		0f10e3			MOVUPS X3, X4		
  0x4b68cc		f20f59db		MULSD X3, X3		
  0x4b68d0		c4e2e9b9da		VFMADD231SD X2, X2, X3	
	g_sq := gx*gx + g_perp_sq
  0x4b68d5		0f10eb			MOVUPS X3, X5		
  0x4b68d8		c4e2f1b9d9		VFMADD231SD X1, X1, X3	
	return sqrt(x)
  0x4b68dd		f20f51f3		SQRTSD X3, X6		
	g := math.Sqrt(g_sq)
  0x4b68e1		90			NOPL			
	g_perp := math.Sqrt(g_perp_sq)
  0x4b68e2		90			NOPL			
	wx := F1 * (*vxe)
  0x4b68e3		f20f103d2d700100	MOVSD_XMM $f64.3eeccc65fefd8fed(SB), X7	
  0x4b68eb		f20f59f9		MULSD X1, X7				
	wy := F1 * (*vye)
  0x4b68ef		f2440f100520700100	MOVSD_XMM $f64.3eeccc65fefd8fed(SB), X8	
  0x4b68f8		f2440f59c2		MULSD X2, X8				
	wz := F1 * (*vze)
  0x4b68fd		f2440f100d12700100	MOVSD_XMM $f64.3eeccc65fefd8fed(SB), X9	
  0x4b6906		f2440f59cc		MULSD X4, X9				
	return sqrt(x)
  0x4b690b		f20f51ed		SQRTSD X5, X5		
	if g > 0.0 {
  0x4b690f		450f57d2		XORPS X10, X10		
  0x4b6913		66410f2ef2		UCOMISD X10, X6		
  0x4b6918		760e			JBE 0x4b6928		
		ct = gx / g
  0x4b691a		f20f5ece		DIVSD X6, X1		
		st = g_perp / g
  0x4b691e		440f10dd		MOVUPS X5, X11		
  0x4b6922		f20f5eee		DIVSD X6, X5		
  0x4b6926		eb0f			JMP 0x4b6937		
	if g_perp > 0.0 {
  0x4b6928		440f10dd		MOVUPS X5, X11				
  0x4b692c		0f57ed			XORPS X5, X5				
  0x4b692f		f20f100d79700100	MOVSD_XMM $f64.3ff0000000000000(SB), X1	
  0x4b6937		66450f2eda		UCOMISD X10, X11			
  0x4b693c		760c			JBE 0x4b694a				
		cp = gy / g_perp
  0x4b693e		f2410f5ed3		DIVSD X11, X2		
		sp = gz / g_perp
  0x4b6943		f2410f5ee3		DIVSD X11, X4				
  0x4b6948		eb0b			JMP 0x4b6955				
  0x4b694a		0f57e4			XORPS X4, X4				
  0x4b694d		f20f10155b700100	MOVSD_XMM $f64.3ff0000000000000(SB), X2	
	t0 := sim.Sigma[E_ELA][eindex]
  0x4b6955		8400			TESTB AL, 0(AX)		
  0x4b6957		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x4b6960		4881fe40420f00		CMPQ SI, $0xf4240	
  0x4b6967		0f83f2090000		JAE 0x4b735f		
	if g > 0.0 {
  0x4b696d		4889842458010000	MOVQ AX, 0x158(SP)	
  0x4b6975		f20f11842460010000	MOVSD_XMM X0, 0x160(SP)	
  0x4b697e		48899c2468010000	MOVQ BX, 0x168(SP)	
  0x4b6986		48898c2470010000	MOVQ CX, 0x170(SP)	
  0x4b698e		4889bc2478010000	MOVQ DI, 0x178(SP)	
  0x4b6996		4c89842488010000	MOVQ R8, 0x188(SP)	
	g_sq := gx*gx + g_perp_sq
  0x4b699e		f20f119c24d8000000	MOVSD_XMM X3, 0xd8(SP)	
	return sqrt(x)
  0x4b69a7		f20f11742458		MOVSD_XMM X6, 0x58(SP)	
	wx := F1 * (*vxe)
  0x4b69ad		f20f11bc2490000000	MOVSD_XMM X7, 0x90(SP)	
	wy := F1 * (*vye)
  0x4b69b6		f2440f11842488000000	MOVSD_XMM X8, 0x88(SP)	
	wz := F1 * (*vze)
  0x4b69c0		f2440f118c2480000000	MOVSD_XMM X9, 0x80(SP)	
	t0 := sim.Sigma[E_ELA][eindex]
  0x4b69ca		f20f11a424b0000000	MOVSD_XMM X4, 0xb0(SP)	
  0x4b69d3		f20f119424f0000000	MOVSD_XMM X2, 0xf0(SP)	
	if g_perp > 0.0 {
  0x4b69dc		f20f11ac24a8000000	MOVSD_XMM X5, 0xa8(SP)	
  0x4b69e5		f20f118c24e8000000	MOVSD_XMM X1, 0xe8(SP)	
	t0 := sim.Sigma[E_ELA][eindex]
  0x4b69ee		f20f1084f0c0000000	MOVSD_XMM 0xc0(AX)(SI*8), X0	
  0x4b69f7		f20f118424a0000000	MOVSD_XMM X0, 0xa0(SP)		
	t1 := t0 + sim.Sigma[E_EXC][eindex]
  0x4b6a00		f20f108cf0c0127a00	MOVSD_XMM 0x7a12c0(AX)(SI*8), X1	
  0x4b6a09		f20f58c8		ADDSD X0, X1				
  0x4b6a0d		f20f118c2498000000	MOVSD_XMM X1, 0x98(SP)			
	t2 := t1 + sim.Sigma[E_ION][eindex]
  0x4b6a16		f20f1084f0c024f400	MOVSD_XMM 0xf424c0(AX)(SI*8), X0	
  0x4b6a1f		f20f11842438010000	MOVSD_XMM X0, 0x138(SP)			
	rnd := sim.WorkerR01(workerID)
  0x4b6a28		4c89c3			MOVQ R8, BX					
  0x4b6a2b		e8d0870000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x4b6a30		f20f118424c8000000	MOVSD_XMM X0, 0xc8(SP)				
	eta := TWO_PI * sim.WorkerR01(workerID)
  0x4b6a39		488b842458010000	MOVQ 0x158(SP), AX				
  0x4b6a41		488b9c2488010000	MOVQ 0x188(SP), BX				
  0x4b6a49		e8b2870000		CALL gopic.(*SimulationState).WorkerR01(SB)	
	t2 := t1 + sim.Sigma[E_ION][eindex]
  0x4b6a4e		f20f108c2438010000	MOVSD_XMM 0x138(SP), X1	
  0x4b6a57		f20f10942498000000	MOVSD_XMM 0x98(SP), X2	
  0x4b6a60		f20f58ca		ADDSD X2, X1		
	r_t2 := rnd * t2
  0x4b6a64		f20f109424c8000000	MOVSD_XMM 0xc8(SP), X2	
  0x4b6a6d		f20f59ca		MULSD X2, X1		
  0x4b6a71		f20f118c24d0000000	MOVSD_XMM X1, 0xd0(SP)	
	eta := TWO_PI * sim.WorkerR01(workerID)
  0x4b6a7a		f20f100da66f0100	MOVSD_XMM $f64.401921fb54442d18(SB), X1	
  0x4b6a82		f20f59c1		MULSD X1, X0				
	se, ce := math.Sincos(eta)
  0x4b6a86		e835e5fcff		CALL math.Sincos(SB)	
  0x4b6a8b		f20f118c2400010000	MOVSD_XMM X1, 0x100(SP)	
  0x4b6a94		f20f118424c0000000	MOVSD_XMM X0, 0xc0(SP)	
	if r_t2 < t0 { // Zderzenie spr─Ö┼╝yste (izotropowe)
  0x4b6a9d		f20f109424a0000000	MOVSD_XMM 0xa0(SP), X2	
  0x4b6aa6		f20f109c24d0000000	MOVSD_XMM 0xd0(SP), X3	
  0x4b6aaf		660f2ed3		UCOMISD X3, X2		
  0x4b6ab3		0f8712070000		JA 0x4b71cb		
	} else if r_t2 < t1 { // Wzbudzenie (niespr─Ö┼╝yste, izotropowe)
  0x4b6ab9		f20f10942498000000	MOVSD_XMM 0x98(SP), X2	
  0x4b6ac2		660f2ed3		UCOMISD X3, X2		
  0x4b6ac6		0f86d0000000		JBE 0x4b6b9c		
		energy := HALF_E_MASS * g_sq
  0x4b6acc		f20f1005b46d0100	MOVSD_XMM $f64.39a279dcc3e61461(SB), X0	
  0x4b6ad4		f20f108c24d8000000	MOVSD_XMM 0xd8(SP), X1			
  0x4b6add		f20f59c1		MULSD X1, X0				
		energy = math.Abs(energy - E_EXC_TH*EV_TO_J)
  0x4b6ae1		f20f100de76d0100	MOVSD_XMM $f64.3c40fe7ccb02e6a7(SB), X1	
  0x4b6ae9		f20f5cc1		SUBSD X1, X0				
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4b6aed		0f57c9			XORPS X1, X1				
  0x4b6af0		f20f1015f06f0100	MOVSD_XMM $f64.8000000000000000(SB), X2	
  0x4b6af8		660fefca		PXOR X2, X1				
  0x4b6afc		f20f118c2438010000	MOVSD_XMM X1, 0x138(SP)			
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x4b6b05		66480f7ec1		MOVQ X0, CX		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x4b6b0a		480fbaf13f		BTRQ $0x3f, CX		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x4b6b0f		66480f6ec1		MOVQ CX, X0		
		g = math.Sqrt(energy * TWO_OVER_E_MASS)
  0x4b6b14		f20f100dc46f0100	MOVSD_XMM $f64.463bb62aabbfcc6d(SB), X1	
  0x4b6b1c		f20f59c8		MULSD X0, X1				
  0x4b6b20		f20f114c2478		MOVSD_XMM X1, 0x78(SP)			
		cc = 1.0 - 2.0*sim.WorkerR01(workerID)
  0x4b6b26		488b842458010000	MOVQ 0x158(SP), AX				
  0x4b6b2e		488b9c2488010000	MOVQ 0x188(SP), BX				
  0x4b6b36		e8c5860000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x4b6b3b		f20f58c0		ADDSD X0, X0					
  0x4b6b3f		f20f100d696e0100	MOVSD_XMM $f64.3ff0000000000000(SB), X1		
  0x4b6b47		f20f5cc8		SUBSD X0, X1					
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4b6b4b		0f10c1			MOVUPS X1, X0				
  0x4b6b4e		f20f59c9		MULSD X1, X1				
  0x4b6b52		f20f1015566e0100	MOVSD_XMM $f64.3ff0000000000000(SB), X2	
  0x4b6b5a		f20f5cd1		SUBSD X1, X2				
  0x4b6b5e		f20f100d826f0100	MOVSD_XMM $f64.8000000000000000(SB), X1	
  0x4b6b66		660fefd1		PXOR X1, X2				
  0x4b6b6a		f20f109c2438010000	MOVSD_XMM 0x138(SP), X3			
  0x4b6b73		0f10e3			MOVUPS X3, X4				
  0x4b6b76		f20f5dda		MINSD X2, X3				
  0x4b6b7a		0f10d3			MOVUPS X3, X2				
  0x4b6b7d		f20f5ddc		MINSD X4, X3				
  0x4b6b81		660febd3		POR X3, X2				
  0x4b6b85		660fefd1		PXOR X1, X2				
	return sqrt(x)
  0x4b6b89		f20f104c2478		MOVSD_XMM 0x78(SP), X1	
  0x4b6b8f		f20f51c9		SQRTSD X1, X1		
  0x4b6b93		f20f51d2		SQRTSD X2, X2		
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4b6b97		e9a2060000		JMP 0x4b723e		
		energy := HALF_E_MASS * g_sq
  0x4b6b9c		f20f1015e46c0100	MOVSD_XMM $f64.39a279dcc3e61461(SB), X2	
  0x4b6ba4		f20f109c24d8000000	MOVSD_XMM 0xd8(SP), X3			
  0x4b6bad		f20f59d3		MULSD X3, X2				
		energy = math.Abs(energy - E_ION_TH*EV_TO_J)
  0x4b6bb1		f20f101d1f6d0100	MOVSD_XMM $f64.3c475931051c7900(SB), X3	
  0x4b6bb9		f20f5cd3		SUBSD X3, X2				
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4b6bbd		0f57db			XORPS X3, X3				
  0x4b6bc0		f20f1025206f0100	MOVSD_XMM $f64.8000000000000000(SB), X4	
  0x4b6bc8		660fefdc		PXOR X4, X3				
  0x4b6bcc		f20f119c2438010000	MOVSD_XMM X3, 0x138(SP)			
		se2 := -se
  0x4b6bd5		660fefe0		PXOR X0, X4		
  0x4b6bd9		f20f11a424b8000000	MOVSD_XMM X4, 0xb8(SP)	
		ce2 := -ce
  0x4b6be2		f20f1005fe6e0100	MOVSD_XMM $f64.8000000000000000(SB), X0	
  0x4b6bea		660fefc1		PXOR X1, X0				
  0x4b6bee		f20f118424f8000000	MOVSD_XMM X0, 0xf8(SP)			
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
  0x4b6bf7		f20f108424a8000000	MOVSD_XMM 0xa8(SP), X0	
  0x4b6c00		f20f108c24f0000000	MOVSD_XMM 0xf0(SP), X1	
  0x4b6c09		0f10d8			MOVUPS X0, X3		
  0x4b6c0c		f20f59c1		MULSD X1, X0		
  0x4b6c10		f20f11842430010000	MOVSD_XMM X0, 0x130(SP)	
  0x4b6c19		f20f108424e8000000	MOVSD_XMM 0xe8(SP), X0	
  0x4b6c22		0f10e0			MOVUPS X0, X4		
  0x4b6c25		f20f59c1		MULSD X1, X0		
  0x4b6c29		f20f11842428010000	MOVSD_XMM X0, 0x128(SP)	
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)
  0x4b6c32		f20f108424b0000000	MOVSD_XMM 0xb0(SP), X0	
  0x4b6c3b		f20f59d8		MULSD X0, X3		
  0x4b6c3f		f20f119c2420010000	MOVSD_XMM X3, 0x120(SP)	
  0x4b6c48		f20f59e0		MULSD X0, X4		
  0x4b6c4c		f20f11a42418010000	MOVSD_XMM X4, 0x118(SP)	
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x4b6c55		66480f7ed1		MOVQ X2, CX		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x4b6c5a		480fbaf13f		BTRQ $0x3f, CX		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x4b6c5f		66480f6ec1		MOVQ CX, X0		
  0x4b6c64		f20f118424e0000000	MOVSD_XMM X0, 0xe0(SP)	
		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
  0x4b6c6d		f20f100d536e0100	MOVSD_XMM $f64.439152dbe5934720(SB), X1		
  0x4b6c75		f20f59c8		MULSD X0, X1					
  0x4b6c79		f20f114c2470		MOVSD_XMM X1, 0x70(SP)				
  0x4b6c7f		488b842458010000	MOVQ 0x158(SP), AX				
  0x4b6c87		488b9c2488010000	MOVQ 0x188(SP), BX				
  0x4b6c8f		e86c850000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x4b6c94		f20f11842410010000	MOVSD_XMM X0, 0x110(SP)				
	return atan(x)
  0x4b6c9d		f20f10442470		MOVSD_XMM 0x70(SP), X0	
  0x4b6ca3		e858d9fcff		CALL math.atan(SB)	
		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
  0x4b6ca8		f20f108c2410010000	MOVSD_XMM 0x110(SP), X1	
  0x4b6cb1		f20f59c1		MULSD X1, X0		
	return tan(x)
  0x4b6cb5		e8c6e5fcff		CALL math.tan(SB)	
		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
  0x4b6cba		f20f100dae6b0100	MOVSD_XMM 0x16bae(IP), X1		
  0x4b6cc2		f20f59c8		MULSD X0, X1				
  0x4b6cc6		f20f1005e26b0100	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X0	
  0x4b6cce		f20f59c1		MULSD X1, X0				
		e_sc := math.Abs(energy - e_ej)
  0x4b6cd2		f20f108c24e0000000	MOVSD_XMM 0xe0(SP), X1	
  0x4b6cdb		0f10d1			MOVUPS X1, X2		
  0x4b6cde		f20f5cc8		SUBSD X0, X1		
		g2 := math.Sqrt(e_ej * TWO_OVER_E_MASS)
  0x4b6ce2		f20f101df66d0100	MOVSD_XMM $f64.463bb62aabbfcc6d(SB), X3	
  0x4b6cea		f20f59d8		MULSD X0, X3				
		cc2 := math.Sqrt(e_ej / energy)
  0x4b6cee		f20f5ec2		DIVSD X2, X0		
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4b6cf2		488b8c2458010000	MOVQ 0x158(SP), CX	
  0x4b6cfa		488b9198000000		MOVQ 0x98(CX), DX	
	return sqrt(x)
  0x4b6d01		f20f51db		SQRTSD X3, X3		
  0x4b6d05		f20f51c0		SQRTSD X0, X0		
		sc2 := math.Sqrt(max(0.0, 1.0-cc2*cc2))
  0x4b6d09		0f10e0			MOVUPS X0, X4				
  0x4b6d0c		f20f59c0		MULSD X0, X0				
  0x4b6d10		f20f102d986c0100	MOVSD_XMM $f64.3ff0000000000000(SB), X5	
  0x4b6d18		f20f5ce8		SUBSD X0, X5				
  0x4b6d1c		f20f1005c46d0100	MOVSD_XMM $f64.8000000000000000(SB), X0	
  0x4b6d24		660fefe8		PXOR X0, X5				
  0x4b6d28		f20f10b42438010000	MOVSD_XMM 0x138(SP), X6			
  0x4b6d31		0f10fe			MOVUPS X6, X7				
  0x4b6d34		f20f5df5		MINSD X5, X6				
  0x4b6d38		0f10ee			MOVUPS X6, X5				
  0x4b6d3b		f20f5df7		MINSD X7, X6				
  0x4b6d3f		660febee		POR X6, X5				
  0x4b6d43		660fefe8		PXOR X0, X5				
		gx2 := g2 * (ct*cc2 - st*sc2*ce2)
  0x4b6d47		f20f10b424e8000000	MOVSD_XMM 0xe8(SP), X6	
  0x4b6d50		440f10c4		MOVUPS X4, X8		
  0x4b6d54		f20f59e6		MULSD X6, X4		
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
  0x4b6d58		f2440f108c2430010000	MOVSD_XMM 0x130(SP), X9	
  0x4b6d62		f2450f59c8		MULSD X8, X9		
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)
  0x4b6d67		f2440f10942420010000	MOVSD_XMM 0x120(SP), X10	
  0x4b6d71		f2450f59c2		MULSD X10, X8			
	return sqrt(x)
  0x4b6d76		f20f51ed		SQRTSD X5, X5		
		gx2 := g2 * (ct*cc2 - st*sc2*ce2)
  0x4b6d7a		f2440f109424a8000000	MOVSD_XMM 0xa8(SP), X10	
  0x4b6d84		450f10da		MOVUPS X10, X11		
  0x4b6d88		f2440f59d5		MULSD X5, X10		
  0x4b6d8d		f2440f10a424f8000000	MOVSD_XMM 0xf8(SP), X12	
  0x4b6d97		f2450f59d4		MULSD X12, X10		
  0x4b6d9c		f2410f5ce2		SUBSD X10, X4		
  0x4b6da1		f20f59e3		MULSD X3, X4		
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
  0x4b6da5		f2440f10942428010000	MOVSD_XMM 0x128(SP), X10	
  0x4b6daf		f2440f59d5		MULSD X5, X10			
  0x4b6db4		c442a9b9cc		VFMADD231SD X12, X10, X9	
  0x4b6db9		f2440f109424b0000000	MOVSD_XMM 0xb0(SP), X10		
  0x4b6dc3		450f10ea		MOVUPS X10, X13			
  0x4b6dc7		f2440f59d5		MULSD X5, X10			
  0x4b6dcc		f2440f10b424b8000000	MOVSD_XMM 0xb8(SP), X14		
  0x4b6dd6		f2450f59d6		MULSD X14, X10			
  0x4b6ddb		f2450f5cca		SUBSD X10, X9			
  0x4b6de0		f2440f59cb		MULSD X3, X9			
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)
  0x4b6de5		f2440f10942418010000	MOVSD_XMM 0x118(SP), X10	
  0x4b6def		f2440f59d5		MULSD X5, X10			
  0x4b6df4		c442a9b9c4		VFMADD231SD X12, X10, X8	
  0x4b6df9		f2440f109424f0000000	MOVSD_XMM 0xf0(SP), X10		
  0x4b6e03		f2410f59ea		MULSD X10, X5			
  0x4b6e08		c442d1b9c6		VFMADD231SD X14, X5, X8		
  0x4b6e0d		f2410f59d8		MULSD X8, X3			
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x4b6e12		66480f7ece		MOVQ X1, SI		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x4b6e17		480fbaf63f		BTRQ $0x3f, SI		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x4b6e1c		66480f6ece		MOVQ SI, X1		
		cc = math.Sqrt(e_sc / energy)
  0x4b6e21		0f10e9			MOVUPS X1, X5		
  0x4b6e24		f20f5eca		DIVSD X2, X1		
	return sqrt(x)
  0x4b6e28		f20f51c9		SQRTSD X1, X1		
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4b6e2c		0f10d1			MOVUPS X1, X2				
  0x4b6e2f		f20f59c9		MULSD X1, X1				
  0x4b6e33		f2440f1005746b0100	MOVSD_XMM $f64.3ff0000000000000(SB), X8	
  0x4b6e3c		f2440f5cc1		SUBSD X1, X8				
  0x4b6e41		66440fefc0		PXOR X0, X8				
  0x4b6e46		0f10cf			MOVUPS X7, X1				
  0x4b6e49		f2410f5df8		MINSD X8, X7				
  0x4b6e4e		440f10c7		MOVUPS X7, X8				
  0x4b6e52		f20f5df9		MINSD X1, X7				
  0x4b6e56		66440febc7		POR X7, X8				
		g = math.Sqrt(e_sc * TWO_OVER_E_MASS)
  0x4b6e5b		f20f100d7d6c0100	MOVSD_XMM $f64.463bb62aabbfcc6d(SB), X1	
  0x4b6e63		f20f59e9		MULSD X1, X5				
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4b6e67		66440fefc0		PXOR X0, X8		
			Vx: wx + F2*gx2,
  0x4b6e6c		f20f10842490000000	MOVSD_XMM 0x90(SP), X0			
  0x4b6e75		f20f100d2b6b0100	MOVSD_XMM $f64.3fefffe3339a0103(SB), X1	
  0x4b6e7d		0f10f8			MOVUPS X0, X7				
  0x4b6e80		c4e2f1b9c4		VFMADD231SD X4, X1, X0			
			Vy: wy + F2*gy2,
  0x4b6e85		f20f10a42488000000	MOVSD_XMM 0x88(SP), X4	
  0x4b6e8e		440f10e4		MOVUPS X4, X12		
  0x4b6e92		c4c2f1b9e1		VFMADD231SD X9, X1, X4	
			Vz: wz + F2*gz2,
  0x4b6e97		f2440f108c2480000000	MOVSD_XMM 0x80(SP), X9	
  0x4b6ea1		450f10f1		MOVUPS X9, X14		
  0x4b6ea5		c462f1b9cb		VFMADD231SD X3, X1, X9	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4b6eaa		488bb42488010000	MOVQ 0x188(SP), SI	
  0x4b6eb2		4839d6			CMPQ SI, DX		
  0x4b6eb5		0f839f040000		JAE 0x4b735a		
		g = math.Sqrt(e_sc * TWO_OVER_E_MASS)
  0x4b6ebb		f20f116c2468		MOVSD_XMM X5, 0x68(SP)	
	return sqrt(x)
  0x4b6ec1		f20f11942438010000	MOVSD_XMM X2, 0x138(SP)	
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4b6eca		f2440f11442460		MOVSD_XMM X8, 0x60(SP)	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4b6ed1		488b9190000000		MOVQ 0x90(CX), DX	
  0x4b6ed8		4c8d0476		LEAQ 0(SI)(SI*2), R8	
  0x4b6edc		4c89842408010000	MOVQ R8, 0x108(SP)	
  0x4b6ee4		4e8b4cc210		MOVQ 0x10(DX)(R8*8), R9	
  0x4b6ee9		4a8b5cc208		MOVQ 0x8(DX)(R8*8), BX	
  0x4b6eee		48ffc3			INCQ BX			
  0x4b6ef1		4a8b04c2		MOVQ 0(DX)(R8*8), AX	
  0x4b6ef5		4939d9			CMPQ R9, BX		
  0x4b6ef8		0f83fb000000		JAE 0x4b6ff9		
  0x4b6efe		4889942440010000	MOVQ DX, 0x140(SP)	
			Vx: wx + F2*gx2,
  0x4b6f06		f20f11842430010000	MOVSD_XMM X0, 0x130(SP)	
			Vy: wy + F2*gy2,
  0x4b6f0f		f20f11a42428010000	MOVSD_XMM X4, 0x128(SP)	
			Vz: wz + F2*gz2,
  0x4b6f18		f2440f118c2420010000	MOVSD_XMM X9, 0x120(SP)	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4b6f22		4c89c9			MOVQ R9, CX				
  0x4b6f25		bf01000000		MOVL $0x1, DI				
  0x4b6f2a		488d35cff80f00		LEAQ 0xff8cf(IP), SI			
  0x4b6f31		e8ea66fcff		CALL runtime.growslice(SB)		
  0x4b6f36		488b942408010000	MOVQ 0x108(SP), DX			
  0x4b6f3e		4c8b842440010000	MOVQ 0x140(SP), R8			
  0x4b6f46		49894cd010		MOVQ CX, 0x10(R8)(DX*8)			
  0x4b6f4b		833d9e5e130000		CMPL runtime.writeBarrier(SB), $0x0	
  0x4b6f52		7410			JE 0x4b6f64				
  0x4b6f54		498b0cd0		MOVQ 0(R8)(DX*8), CX			
  0x4b6f58		e8a3a7fcff		CALL runtime.gcWriteBarrier2(SB)	
  0x4b6f5d		498903			MOVQ AX, 0(R11)				
  0x4b6f60		49894b08		MOVQ CX, 0x8(R11)			
  0x4b6f64		498904d0		MOVQ AX, 0(R8)(DX*8)			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b6f68		488b8c2458010000	MOVQ 0x158(SP), CX	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4b6f70		4c89c2			MOVQ R8, DX		
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b6f73		488bb42488010000	MOVQ 0x188(SP), SI	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4b6f7b		4c8b842408010000	MOVQ 0x108(SP), R8	
  0x4b6f83		f20f10842430010000	MOVSD_XMM 0x130(SP), X0	
  0x4b6f8c		f20f10942438010000	MOVSD_XMM 0x138(SP), X2	
  0x4b6f95		f20f10a42428010000	MOVSD_XMM 0x128(SP), X4	
	return sqrt(x)
  0x4b6f9e		f20f106c2468		MOVSD_XMM 0x68(SP), X5	
	gx = g * (ct*cc - st*sc*ce)
  0x4b6fa4		f20f10b424e8000000	MOVSD_XMM 0xe8(SP), X6	
	*vxe = wx + F2*gx
  0x4b6fad		f20f10bc2490000000	MOVSD_XMM 0x90(SP), X7	
	return sqrt(x)
  0x4b6fb6		f2440f10442460		MOVSD_XMM 0x60(SP), X8	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4b6fbd		f2440f108c2420010000	MOVSD_XMM 0x120(SP), X9	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b6fc7		f2440f109424f0000000	MOVSD_XMM 0xf0(SP), X10	
	gx = g * (ct*cc - st*sc*ce)
  0x4b6fd1		f2440f109c24a8000000	MOVSD_XMM 0xa8(SP), X11	
	*vye = wy + F2*gy
  0x4b6fdb		f2440f10a42488000000	MOVSD_XMM 0x88(SP), X12	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b6fe5		f2440f10ac24b0000000	MOVSD_XMM 0xb0(SP), X13	
	*vze = wz + F2*gz
  0x4b6fef		f2440f10b42480000000	MOVSD_XMM 0x80(SP), X14	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4b6ff9		4a895cc208		MOVQ BX, 0x8(DX)(R8*8)		
  0x4b6ffe		488d53ff		LEAQ -0x1(BX), DX		
  0x4b7002		48c1e205		SHLQ $0x5, DX			
  0x4b7006		f20f108c2460010000	MOVSD_XMM 0x160(SP), X1		
  0x4b700f		f20f110c10		MOVSD_XMM X1, 0(AX)(DX*1)	
  0x4b7014		f20f11441008		MOVSD_XMM X0, 0x8(AX)(DX*1)	
  0x4b701a		f20f11641010		MOVSD_XMM X4, 0x10(AX)(DX*1)	
  0x4b7020		f2440f114c1018		MOVSD_XMM X9, 0x18(AX)(DX*1)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b7027		488b91f82dba07		MOVQ 0x7ba2df8(CX), DX	
			Vx: sim.WorkerRMB(workerID),
  0x4b702e		90			NOPL			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b702f		4839d6			CMPQ SI, DX				
  0x4b7032		0f831d030000		JAE 0x4b7355				
  0x4b7038		488b89f02dba07		MOVQ 0x7ba2df0(CX), CX			
  0x4b703f		488b04f1		MOVQ 0(CX)(SI*8), AX			
  0x4b7043		e8f8ebffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4b7048		488b8c2458010000	MOVQ 0x158(SP), CX			
  0x4b7050		488b91f82dba07		MOVQ 0x7ba2df8(CX), DX			
			Vy: sim.WorkerRMB(workerID),
  0x4b7057		90			NOPL			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b7058		f20f5905385b1300	MULSD gopic.RMB_sigma(SB), X0		
  0x4b7060		488b9c2488010000	MOVQ 0x188(SP), BX			
  0x4b7068		4839d3			CMPQ BX, DX				
  0x4b706b		0f83df020000		JAE 0x4b7350				
  0x4b7071		f20f11442450		MOVSD_XMM X0, 0x50(SP)			
  0x4b7077		488b89f02dba07		MOVQ 0x7ba2df0(CX), CX			
  0x4b707e		488b04d9		MOVQ 0(CX)(BX*8), AX			
  0x4b7082		e8b9ebffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4b7087		488b8c2458010000	MOVQ 0x158(SP), CX			
  0x4b708f		488b91f82dba07		MOVQ 0x7ba2df8(CX), DX			
			Vz: sim.WorkerRMB(workerID),
  0x4b7096		90			NOPL			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b7097		f20f5905f95a1300	MULSD gopic.RMB_sigma(SB), X0		
  0x4b709f		488b9c2488010000	MOVQ 0x188(SP), BX			
  0x4b70a7		4839d3			CMPQ BX, DX				
  0x4b70aa		0f839b020000		JAE 0x4b734b				
  0x4b70b0		f20f11442448		MOVSD_XMM X0, 0x48(SP)			
  0x4b70b6		488b89f02dba07		MOVQ 0x7ba2df0(CX), CX			
  0x4b70bd		488b04d9		MOVQ 0(CX)(BX*8), AX			
  0x4b70c1		e87aebffff		CALL math/rand.(*Rand).NormFloat64(SB)	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x4b70c6		488b8c2458010000	MOVQ 0x158(SP), CX	
  0x4b70ce		488b91b0000000		MOVQ 0xb0(CX), DX	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b70d5		f20f5905bb5a1300	MULSD gopic.RMB_sigma(SB), X0	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x4b70dd		488b9c2488010000	MOVQ 0x188(SP), BX	
  0x4b70e5		4839d3			CMPQ BX, DX		
  0x4b70e8		0f8358020000		JAE 0x4b7346		
  0x4b70ee		488b91a8000000		MOVQ 0xa8(CX), DX	
  0x4b70f5		4c8b842408010000	MOVQ 0x108(SP), R8	
  0x4b70fd		4a8b4cc210		MOVQ 0x10(DX)(R8*8), CX	
  0x4b7102		4a8b5cc208		MOVQ 0x8(DX)(R8*8), BX	
  0x4b7107		48ffc3			INCQ BX			
  0x4b710a		4a8b04c2		MOVQ 0(DX)(R8*8), AX	
  0x4b710e		4839d9			CMPQ CX, BX		
  0x4b7111		7360			JAE 0x4b7173		
  0x4b7113		4889942440010000	MOVQ DX, 0x140(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b711b		f20f11442440		MOVSD_XMM X0, 0x40(SP)	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x4b7121		bf01000000		MOVL $0x1, DI				
  0x4b7126		488d35d3f60f00		LEAQ 0xff6d3(IP), SI			
  0x4b712d		e8ee64fcff		CALL runtime.growslice(SB)		
  0x4b7132		488b942408010000	MOVQ 0x108(SP), DX			
  0x4b713a		4c8b842440010000	MOVQ 0x140(SP), R8			
  0x4b7142		49894cd010		MOVQ CX, 0x10(R8)(DX*8)			
  0x4b7147		833da25c130000		CMPL runtime.writeBarrier(SB), $0x0	
  0x4b714e		7410			JE 0x4b7160				
  0x4b7150		498b0cd0		MOVQ 0(R8)(DX*8), CX			
  0x4b7154		e8a7a5fcff		CALL runtime.gcWriteBarrier2(SB)	
  0x4b7159		498903			MOVQ AX, 0(R11)				
  0x4b715c		49894b08		MOVQ CX, 0x8(R11)			
  0x4b7160		498904d0		MOVQ AX, 0(R8)(DX*8)			
  0x4b7164		f20f10442440		MOVSD_XMM 0x40(SP), X0			
  0x4b716a		4889d1			MOVQ DX, CX				
  0x4b716d		4c89c2			MOVQ R8, DX				
  0x4b7170		4989c8			MOVQ CX, R8				
  0x4b7173		4a895cc208		MOVQ BX, 0x8(DX)(R8*8)			
  0x4b7178		488d4bff		LEAQ -0x1(BX), CX			
  0x4b717c		48c1e105		SHLQ $0x5, CX				
  0x4b7180		f20f109c2460010000	MOVSD_XMM 0x160(SP), X3			
  0x4b7189		f20f111c08		MOVSD_XMM X3, 0(AX)(CX*1)		
  0x4b718e		f20f105c2450		MOVSD_XMM 0x50(SP), X3			
  0x4b7194		f20f115c0808		MOVSD_XMM X3, 0x8(AX)(CX*1)		
  0x4b719a		f20f105c2448		MOVSD_XMM 0x48(SP), X3			
  0x4b71a0		f20f115c0810		MOVSD_XMM X3, 0x10(AX)(CX*1)		
  0x4b71a6		f20f11440818		MOVSD_XMM X0, 0x18(AX)(CX*1)		
	return sqrt(x)
  0x4b71ac		f20f10442468		MOVSD_XMM 0x68(SP), X0	
  0x4b71b2		f20f51c8		SQRTSD X0, X1		
  0x4b71b6		f20f10442460		MOVSD_XMM 0x60(SP), X0	
  0x4b71bc		f20f51d0		SQRTSD X0, X2		
  0x4b71c0		f20f10842438010000	MOVSD_XMM 0x138(SP), X0	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x4b71c9		eb73			JMP 0x4b723e		
		cc = 1.0 - 2.0*sim.WorkerR01(workerID)
  0x4b71cb		488b842458010000	MOVQ 0x158(SP), AX				
  0x4b71d3		488b9c2488010000	MOVQ 0x188(SP), BX				
  0x4b71db		0f1f440000		NOPL 0(AX)(AX*1)				
  0x4b71e0		e81b800000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x4b71e5		f20f58c0		ADDSD X0, X0					
  0x4b71e9		f20f100dbf670100	MOVSD_XMM $f64.3ff0000000000000(SB), X1		
  0x4b71f1		f20f5cc8		SUBSD X0, X1					
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4b71f5		0f57c0			XORPS X0, X0				
  0x4b71f8		f20f1015e8680100	MOVSD_XMM $f64.8000000000000000(SB), X2	
  0x4b7200		660fefc2		PXOR X2, X0				
  0x4b7204		0f10d9			MOVUPS X1, X3				
  0x4b7207		f20f59c9		MULSD X1, X1				
  0x4b720b		f20f10259d670100	MOVSD_XMM $f64.3ff0000000000000(SB), X4	
  0x4b7213		f20f5ce1		SUBSD X1, X4				
  0x4b7217		660fefe2		PXOR X2, X4				
  0x4b721b		0f10c8			MOVUPS X0, X1				
  0x4b721e		f20f5dc4		MINSD X4, X0				
  0x4b7222		0f10e0			MOVUPS X0, X4				
  0x4b7225		f20f5dc1		MINSD X1, X0				
  0x4b7229		660febe0		POR X0, X4				
  0x4b722d		660fefe2		PXOR X2, X4				
	return sqrt(x)
  0x4b7231		f20f51d4		SQRTSD X4, X2		
	gx = g * (ct*cc - st*sc*ce)
  0x4b7235		f20f104c2458		MOVSD_XMM 0x58(SP), X1	
  0x4b723b		0f10c3			MOVUPS X3, X0		
  0x4b723e		f20f109c24e8000000	MOVSD_XMM 0xe8(SP), X3	
  0x4b7247		0f10e3			MOVUPS X3, X4		
  0x4b724a		f20f59d8		MULSD X0, X3		
  0x4b724e		f20f10ac24a8000000	MOVSD_XMM 0xa8(SP), X5	
  0x4b7257		0f10f5			MOVUPS X5, X6		
  0x4b725a		f20f59ea		MULSD X2, X5		
  0x4b725e		f20f10bc2400010000	MOVSD_XMM 0x100(SP), X7	
  0x4b7267		f20f59ef		MULSD X7, X5		
  0x4b726b		f20f5cdd		SUBSD X5, X3		
  0x4b726f		f20f59d9		MULSD X1, X3		
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b7273		f20f10ac24f0000000	MOVSD_XMM 0xf0(SP), X5	
  0x4b727c		440f10c6		MOVUPS X6, X8		
  0x4b7280		f20f59f5		MULSD X5, X6		
  0x4b7284		f20f59f0		MULSD X0, X6		
  0x4b7288		440f10cc		MOVUPS X4, X9		
  0x4b728c		f20f59e5		MULSD X5, X4		
  0x4b7290		f20f59e2		MULSD X2, X4		
  0x4b7294		c4e2d9b9f7		VFMADD231SD X7, X4, X6	
  0x4b7299		f20f10a424b0000000	MOVSD_XMM 0xb0(SP), X4	
  0x4b72a2		440f10d4		MOVUPS X4, X10		
  0x4b72a6		f20f59e2		MULSD X2, X4		
  0x4b72aa		f2440f109c24c0000000	MOVSD_XMM 0xc0(SP), X11	
  0x4b72b4		f2410f59e3		MULSD X11, X4		
  0x4b72b9		f20f5cf4		SUBSD X4, X6		
  0x4b72bd		f20f59f1		MULSD X1, X6		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4b72c1		f2450f59c2		MULSD X10, X8		
  0x4b72c6		f2410f59c0		MULSD X8, X0		
  0x4b72cb		f2450f59ca		MULSD X10, X9		
  0x4b72d0		f2440f59ca		MULSD X2, X9		
  0x4b72d5		c4e2b1b9c7		VFMADD231SD X7, X9, X0	
  0x4b72da		f20f59ea		MULSD X2, X5		
  0x4b72de		c4c2d1b9c3		VFMADD231SD X11, X5, X0	
  0x4b72e3		f20f59c1		MULSD X1, X0		
	*vxe = wx + F2*gx
  0x4b72e7		f20f108c2490000000	MOVSD_XMM 0x90(SP), X1			
  0x4b72f0		f20f1015b0660100	MOVSD_XMM $f64.3fefffe3339a0103(SB), X2	
  0x4b72f8		c4e2e1b9ca		VFMADD231SD X2, X3, X1			
  0x4b72fd		488b842468010000	MOVQ 0x168(SP), AX			
  0x4b7305		f20f1108		MOVSD_XMM X1, 0(AX)			
	*vye = wy + F2*gy
  0x4b7309		f20f108c2488000000	MOVSD_XMM 0x88(SP), X1	
  0x4b7312		c4e2c9b9ca		VFMADD231SD X2, X6, X1	
  0x4b7317		488b842470010000	MOVQ 0x170(SP), AX	
  0x4b731f		f20f1108		MOVSD_XMM X1, 0(AX)	
	*vze = wz + F2*gz
  0x4b7323		f20f108c2480000000	MOVSD_XMM 0x80(SP), X1	
  0x4b732c		c4e2f9b9ca		VFMADD231SD X2, X0, X1	
  0x4b7331		488b842478010000	MOVQ 0x178(SP), AX	
  0x4b7339		f20f1108		MOVSD_XMM X1, 0(AX)	
}
  0x4b733d		4881c448010000		ADDQ $0x148, SP		
  0x4b7344		5d			POPQ BP			
  0x4b7345		c3			RET			
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x4b7346		e855a7fcff		CALL runtime.panicBounds(SB)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b734b		e850a7fcff		CALL runtime.panicBounds(SB)	
  0x4b7350		e84ba7fcff		CALL runtime.panicBounds(SB)	
  0x4b7355		e846a7fcff		CALL runtime.panicBounds(SB)	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4b735a		e841a7fcff		CALL runtime.panicBounds(SB)	
	t0 := sim.Sigma[E_ELA][eindex]
  0x4b735f		b840420f00		MOVL $0xf4240, AX		
  0x4b7364		e837a7fcff		CALL runtime.panicBounds(SB)	
  0x4b7369		90			NOPL				
func (sim *SimulationState) CollisionElectron(xe float64, vxe, vye, vze *float64, eindex int, workerID int) {
  0x4b736a		4889442408		MOVQ AX, 0x8(SP)					
  0x4b736f		f20f11442410		MOVSD_XMM X0, 0x10(SP)					
  0x4b7375		48895c2418		MOVQ BX, 0x18(SP)					
  0x4b737a		48894c2420		MOVQ CX, 0x20(SP)					
  0x4b737f		48897c2428		MOVQ DI, 0x28(SP)					
  0x4b7384		4889742430		MOVQ SI, 0x30(SP)					
  0x4b7389		4c89442438		MOVQ R8, 0x38(SP)					
  0x4b738e		e8cd8afcff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x4b7393		488b442408		MOVQ 0x8(SP), AX					
  0x4b7398		f20f10442410		MOVSD_XMM 0x10(SP), X0					
  0x4b739e		488b5c2418		MOVQ 0x18(SP), BX					
  0x4b73a3		488b4c2420		MOVQ 0x20(SP), CX					
  0x4b73a8		488b7c2428		MOVQ 0x28(SP), DI					
  0x4b73ad		488b742430		MOVQ 0x30(SP), SI					
  0x4b73b2		4c8b442438		MOVQ 0x38(SP), R8					
  0x4b73b7		e9e4f4ffff		JMP gopic.(*SimulationState).CollisionElectron(SB)	
