// =============================================================================
// SYMBOL: CollisionElectron
// =============================================================================

TEXT gopic.(*SimulationState).CollisionElectron(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/collisions.go
func (sim *SimulationState) CollisionElectron(xe float64, vxe, vye, vze *float64, eindex int, workerID int) {
  0x1400bd860		4c8da42430ffffff	LEAQ 0xffffff30(SP), R12	
  0x1400bd868		4d3b6610		CMPQ R12, 0x10(R14)		
  0x1400bd86c		0f86b80a0000		JBE 0x1400be32a			
  0x1400bd872		55			PUSHQ BP			
  0x1400bd873		4889e5			MOVQ SP, BP			
  0x1400bd876		4881ec48010000		SUBQ $0x148, SP			
	gx := *vxe
  0x1400bd87d		f20f100b		MOVSD_XMM 0(BX), X1	
	gy := *vye
  0x1400bd881		f20f1011		MOVSD_XMM 0(CX), X2	
	gz := *vze
  0x1400bd885		f20f101f		MOVSD_XMM 0(DI), X3	
	g_perp_sq := gy*gy + gz*gz
  0x1400bd889		0f10e3			MOVUPS X3, X4		
  0x1400bd88c		f20f59db		MULSD X3, X3		
  0x1400bd890		c4e2e9b9da		VFMADD231SD X2, X2, X3	
	g_sq := gx*gx + g_perp_sq
  0x1400bd895		0f10eb			MOVUPS X3, X5		
  0x1400bd898		c4e2f1b9d9		VFMADD231SD X1, X1, X3	
	return sqrt(x)
  0x1400bd89d		f20f51f3		SQRTSD X3, X6		
	g := math.Sqrt(g_sq)
  0x1400bd8a1		90			NOPL			
	g_perp := math.Sqrt(g_perp_sq)
  0x1400bd8a2		90			NOPL			
	wx := F1 * (*vxe)
  0x1400bd8a3		f20f103dcd880100	MOVSD_XMM $f64.3eeccc65fefd8fed(SB), X7	
  0x1400bd8ab		f20f59f9		MULSD X1, X7				
	wy := F1 * (*vye)
  0x1400bd8af		f2440f1005c0880100	MOVSD_XMM $f64.3eeccc65fefd8fed(SB), X8	
  0x1400bd8b8		f2440f59c2		MULSD X2, X8				
	wz := F1 * (*vze)
  0x1400bd8bd		f2440f100db2880100	MOVSD_XMM $f64.3eeccc65fefd8fed(SB), X9	
  0x1400bd8c6		f2440f59cc		MULSD X4, X9				
	return sqrt(x)
  0x1400bd8cb		f20f51ed		SQRTSD X5, X5		
	if g > 0.0 {
  0x1400bd8cf		450f57d2		XORPS X10, X10		
  0x1400bd8d3		66410f2ef2		UCOMISD X10, X6		
  0x1400bd8d8		760e			JBE 0x1400bd8e8		
		ct = gx / g
  0x1400bd8da		f20f5ece		DIVSD X6, X1		
		st = g_perp / g
  0x1400bd8de		440f10dd		MOVUPS X5, X11		
  0x1400bd8e2		f20f5eee		DIVSD X6, X5		
  0x1400bd8e6		eb0f			JMP 0x1400bd8f7		
	if g_perp > 0.0 {
  0x1400bd8e8		440f10dd		MOVUPS X5, X11				
  0x1400bd8ec		0f57ed			XORPS X5, X5				
  0x1400bd8ef		f20f100d19890100	MOVSD_XMM $f64.3ff0000000000000(SB), X1	
  0x1400bd8f7		66450f2eda		UCOMISD X10, X11			
  0x1400bd8fc		760c			JBE 0x1400bd90a				
		cp = gy / g_perp
  0x1400bd8fe		f2410f5ed3		DIVSD X11, X2		
		sp = gz / g_perp
  0x1400bd903		f2410f5ee3		DIVSD X11, X4				
  0x1400bd908		eb0b			JMP 0x1400bd915				
  0x1400bd90a		0f57e4			XORPS X4, X4				
  0x1400bd90d		f20f1015fb880100	MOVSD_XMM $f64.3ff0000000000000(SB), X2	
	t0 := sim.Sigma[E_ELA][eindex]
  0x1400bd915		8400			TESTB AL, 0(AX)		
  0x1400bd917		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x1400bd920		4881fe40420f00		CMPQ SI, $0xf4240	
  0x1400bd927		0f83f2090000		JAE 0x1400be31f		
	if g > 0.0 {
  0x1400bd92d		4889842458010000	MOVQ AX, 0x158(SP)	
  0x1400bd935		f20f11842460010000	MOVSD_XMM X0, 0x160(SP)	
  0x1400bd93e		48899c2468010000	MOVQ BX, 0x168(SP)	
  0x1400bd946		48898c2470010000	MOVQ CX, 0x170(SP)	
  0x1400bd94e		4889bc2478010000	MOVQ DI, 0x178(SP)	
  0x1400bd956		4c89842488010000	MOVQ R8, 0x188(SP)	
	g_sq := gx*gx + g_perp_sq
  0x1400bd95e		f20f119c24d8000000	MOVSD_XMM X3, 0xd8(SP)	
	return sqrt(x)
  0x1400bd967		f20f11742458		MOVSD_XMM X6, 0x58(SP)	
	wx := F1 * (*vxe)
  0x1400bd96d		f20f11bc2490000000	MOVSD_XMM X7, 0x90(SP)	
	wy := F1 * (*vye)
  0x1400bd976		f2440f11842488000000	MOVSD_XMM X8, 0x88(SP)	
	wz := F1 * (*vze)
  0x1400bd980		f2440f118c2480000000	MOVSD_XMM X9, 0x80(SP)	
	t0 := sim.Sigma[E_ELA][eindex]
  0x1400bd98a		f20f11a424b0000000	MOVSD_XMM X4, 0xb0(SP)	
  0x1400bd993		f20f119424f0000000	MOVSD_XMM X2, 0xf0(SP)	
	if g_perp > 0.0 {
  0x1400bd99c		f20f11ac24a8000000	MOVSD_XMM X5, 0xa8(SP)	
  0x1400bd9a5		f20f118c24e8000000	MOVSD_XMM X1, 0xe8(SP)	
	t0 := sim.Sigma[E_ELA][eindex]
  0x1400bd9ae		f20f1084f0c0000000	MOVSD_XMM 0xc0(AX)(SI*8), X0	
  0x1400bd9b7		f20f118424a0000000	MOVSD_XMM X0, 0xa0(SP)		
	t1 := t0 + sim.Sigma[E_EXC][eindex]
  0x1400bd9c0		f20f108cf0c0127a00	MOVSD_XMM 0x7a12c0(AX)(SI*8), X1	
  0x1400bd9c9		f20f58c8		ADDSD X0, X1				
  0x1400bd9cd		f20f118c2498000000	MOVSD_XMM X1, 0x98(SP)			
	t2 := t1 + sim.Sigma[E_ION][eindex]
  0x1400bd9d6		f20f1084f0c024f400	MOVSD_XMM 0xf424c0(AX)(SI*8), X0	
  0x1400bd9df		f20f11842438010000	MOVSD_XMM X0, 0x138(SP)			
	rnd := sim.WorkerR01(workerID)
  0x1400bd9e8		4c89c3			MOVQ R8, BX					
  0x1400bd9eb		e810800000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400bd9f0		f20f118424c8000000	MOVSD_XMM X0, 0xc8(SP)				
	eta := TWO_PI * sim.WorkerR01(workerID)
  0x1400bd9f9		488b842458010000	MOVQ 0x158(SP), AX				
  0x1400bda01		488b9c2488010000	MOVQ 0x188(SP), BX				
  0x1400bda09		e8f27f0000		CALL gopic.(*SimulationState).WorkerR01(SB)	
	t2 := t1 + sim.Sigma[E_ION][eindex]
  0x1400bda0e		f20f108c2438010000	MOVSD_XMM 0x138(SP), X1	
  0x1400bda17		f20f10942498000000	MOVSD_XMM 0x98(SP), X2	
  0x1400bda20		f20f58ca		ADDSD X2, X1		
	r_t2 := rnd * t2
  0x1400bda24		f20f109424c8000000	MOVSD_XMM 0xc8(SP), X2	
  0x1400bda2d		f20f59ca		MULSD X2, X1		
  0x1400bda31		f20f118c24d0000000	MOVSD_XMM X1, 0xd0(SP)	
	eta := TWO_PI * sim.WorkerR01(workerID)
  0x1400bda3a		f20f100d46880100	MOVSD_XMM $f64.401921fb54442d18(SB), X1	
  0x1400bda42		f20f59c1		MULSD X1, X0				
	se, ce := math.Sincos(eta)
  0x1400bda46		e87563fcff		CALL math.Sincos(SB)	
  0x1400bda4b		f20f118c2400010000	MOVSD_XMM X1, 0x100(SP)	
  0x1400bda54		f20f118424c0000000	MOVSD_XMM X0, 0xc0(SP)	
	if r_t2 < t0 { // Zderzenie sprÄ™ĹĽyste (izotropowe)
  0x1400bda5d		f20f109424a0000000	MOVSD_XMM 0xa0(SP), X2	
  0x1400bda66		f20f109c24d0000000	MOVSD_XMM 0xd0(SP), X3	
  0x1400bda6f		660f2ed3		UCOMISD X3, X2		
  0x1400bda73		0f8712070000		JA 0x1400be18b		
	} else if r_t2 < t1 { // Wzbudzenie (niesprÄ™ĹĽyste, izotropowe)
  0x1400bda79		f20f10942498000000	MOVSD_XMM 0x98(SP), X2	
  0x1400bda82		660f2ed3		UCOMISD X3, X2		
  0x1400bda86		0f86d0000000		JBE 0x1400bdb5c		
		energy := HALF_E_MASS * g_sq
  0x1400bda8c		f20f100554860100	MOVSD_XMM $f64.39a279dcc3e61461(SB), X0	
  0x1400bda94		f20f108c24d8000000	MOVSD_XMM 0xd8(SP), X1			
  0x1400bda9d		f20f59c1		MULSD X1, X0				
		energy = math.Abs(energy - E_EXC_TH*EV_TO_J)
  0x1400bdaa1		f20f100d87860100	MOVSD_XMM $f64.3c40fe7ccb02e6a7(SB), X1	
  0x1400bdaa9		f20f5cc1		SUBSD X1, X0				
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400bdaad		0f57c9			XORPS X1, X1				
  0x1400bdab0		f20f101590880100	MOVSD_XMM $f64.8000000000000000(SB), X2	
  0x1400bdab8		660fefca		PXOR X2, X1				
  0x1400bdabc		f20f118c2438010000	MOVSD_XMM X1, 0x138(SP)			
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x1400bdac5		66480f7ec1		MOVQ X0, CX		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x1400bdaca		480fbaf13f		BTRQ $0x3f, CX		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x1400bdacf		66480f6ec1		MOVQ CX, X0		
		g = math.Sqrt(energy * TWO_OVER_E_MASS)
  0x1400bdad4		f20f100d64880100	MOVSD_XMM $f64.463bb62aabbfcc6d(SB), X1	
  0x1400bdadc		f20f59c8		MULSD X0, X1				
  0x1400bdae0		f20f114c2478		MOVSD_XMM X1, 0x78(SP)			
		cc = 1.0 - 2.0*sim.WorkerR01(workerID)
  0x1400bdae6		488b842458010000	MOVQ 0x158(SP), AX				
  0x1400bdaee		488b9c2488010000	MOVQ 0x188(SP), BX				
  0x1400bdaf6		e8057f0000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400bdafb		f20f58c0		ADDSD X0, X0					
  0x1400bdaff		f20f100d09870100	MOVSD_XMM $f64.3ff0000000000000(SB), X1		
  0x1400bdb07		f20f5cc8		SUBSD X0, X1					
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400bdb0b		0f10c1			MOVUPS X1, X0				
  0x1400bdb0e		f20f59c9		MULSD X1, X1				
  0x1400bdb12		f20f1015f6860100	MOVSD_XMM $f64.3ff0000000000000(SB), X2	
  0x1400bdb1a		f20f5cd1		SUBSD X1, X2				
  0x1400bdb1e		f20f100d22880100	MOVSD_XMM $f64.8000000000000000(SB), X1	
  0x1400bdb26		660fefd1		PXOR X1, X2				
  0x1400bdb2a		f20f109c2438010000	MOVSD_XMM 0x138(SP), X3			
  0x1400bdb33		0f10e3			MOVUPS X3, X4				
  0x1400bdb36		f20f5dda		MINSD X2, X3				
  0x1400bdb3a		0f10d3			MOVUPS X3, X2				
  0x1400bdb3d		f20f5ddc		MINSD X4, X3				
  0x1400bdb41		660febd3		POR X3, X2				
  0x1400bdb45		660fefd1		PXOR X1, X2				
	return sqrt(x)
  0x1400bdb49		f20f104c2478		MOVSD_XMM 0x78(SP), X1	
  0x1400bdb4f		f20f51c9		SQRTSD X1, X1		
  0x1400bdb53		f20f51d2		SQRTSD X2, X2		
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400bdb57		e9a2060000		JMP 0x1400be1fe		
		energy := HALF_E_MASS * g_sq
  0x1400bdb5c		f20f101584850100	MOVSD_XMM $f64.39a279dcc3e61461(SB), X2	
  0x1400bdb64		f20f109c24d8000000	MOVSD_XMM 0xd8(SP), X3			
  0x1400bdb6d		f20f59d3		MULSD X3, X2				
		energy = math.Abs(energy - E_ION_TH*EV_TO_J)
  0x1400bdb71		f20f101dbf850100	MOVSD_XMM $f64.3c475931051c7900(SB), X3	
  0x1400bdb79		f20f5cd3		SUBSD X3, X2				
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400bdb7d		0f57db			XORPS X3, X3				
  0x1400bdb80		f20f1025c0870100	MOVSD_XMM $f64.8000000000000000(SB), X4	
  0x1400bdb88		660fefdc		PXOR X4, X3				
  0x1400bdb8c		f20f119c2438010000	MOVSD_XMM X3, 0x138(SP)			
		se2 := -se
  0x1400bdb95		660fefe0		PXOR X0, X4		
  0x1400bdb99		f20f11a424b8000000	MOVSD_XMM X4, 0xb8(SP)	
		ce2 := -ce
  0x1400bdba2		f20f10059e870100	MOVSD_XMM $f64.8000000000000000(SB), X0	
  0x1400bdbaa		660fefc1		PXOR X1, X0				
  0x1400bdbae		f20f118424f8000000	MOVSD_XMM X0, 0xf8(SP)			
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
  0x1400bdbb7		f20f108424a8000000	MOVSD_XMM 0xa8(SP), X0	
  0x1400bdbc0		f20f108c24f0000000	MOVSD_XMM 0xf0(SP), X1	
  0x1400bdbc9		0f10d8			MOVUPS X0, X3		
  0x1400bdbcc		f20f59c1		MULSD X1, X0		
  0x1400bdbd0		f20f11842430010000	MOVSD_XMM X0, 0x130(SP)	
  0x1400bdbd9		f20f108424e8000000	MOVSD_XMM 0xe8(SP), X0	
  0x1400bdbe2		0f10e0			MOVUPS X0, X4		
  0x1400bdbe5		f20f59c1		MULSD X1, X0		
  0x1400bdbe9		f20f11842428010000	MOVSD_XMM X0, 0x128(SP)	
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)
  0x1400bdbf2		f20f108424b0000000	MOVSD_XMM 0xb0(SP), X0	
  0x1400bdbfb		f20f59d8		MULSD X0, X3		
  0x1400bdbff		f20f119c2420010000	MOVSD_XMM X3, 0x120(SP)	
  0x1400bdc08		f20f59e0		MULSD X0, X4		
  0x1400bdc0c		f20f11a42418010000	MOVSD_XMM X4, 0x118(SP)	
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x1400bdc15		66480f7ed1		MOVQ X2, CX		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x1400bdc1a		480fbaf13f		BTRQ $0x3f, CX		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x1400bdc1f		66480f6ec1		MOVQ CX, X0		
  0x1400bdc24		f20f118424e0000000	MOVSD_XMM X0, 0xe0(SP)	
		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
  0x1400bdc2d		f20f100df3860100	MOVSD_XMM $f64.439152dbe5934720(SB), X1		
  0x1400bdc35		f20f59c8		MULSD X0, X1					
  0x1400bdc39		f20f114c2470		MOVSD_XMM X1, 0x70(SP)				
  0x1400bdc3f		488b842458010000	MOVQ 0x158(SP), AX				
  0x1400bdc47		488b9c2488010000	MOVQ 0x188(SP), BX				
  0x1400bdc4f		e8ac7d0000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400bdc54		f20f11842410010000	MOVSD_XMM X0, 0x110(SP)				
	return atan(x)
  0x1400bdc5d		f20f10442470		MOVSD_XMM 0x70(SP), X0	
  0x1400bdc63		e89857fcff		CALL math.atan(SB)	
		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
  0x1400bdc68		f20f108c2410010000	MOVSD_XMM 0x110(SP), X1	
  0x1400bdc71		f20f59c1		MULSD X1, X0		
	return tan(x)
  0x1400bdc75		e80664fcff		CALL math.tan(SB)	
		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
  0x1400bdc7a		f20f100d46840100	MOVSD_XMM runtime.egcbss+58(SB), X1	
  0x1400bdc82		f20f59c8		MULSD X0, X1				
  0x1400bdc86		f20f100582840100	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X0	
  0x1400bdc8e		f20f59c1		MULSD X1, X0				
		e_sc := math.Abs(energy - e_ej)
  0x1400bdc92		f20f108c24e0000000	MOVSD_XMM 0xe0(SP), X1	
  0x1400bdc9b		0f10d1			MOVUPS X1, X2		
  0x1400bdc9e		f20f5cc8		SUBSD X0, X1		
		g2 := math.Sqrt(e_ej * TWO_OVER_E_MASS)
  0x1400bdca2		f20f101d96860100	MOVSD_XMM $f64.463bb62aabbfcc6d(SB), X3	
  0x1400bdcaa		f20f59d8		MULSD X0, X3				
		cc2 := math.Sqrt(e_ej / energy)
  0x1400bdcae		f20f5ec2		DIVSD X2, X0		
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400bdcb2		488b8c2458010000	MOVQ 0x158(SP), CX	
  0x1400bdcba		488b9198000000		MOVQ 0x98(CX), DX	
	return sqrt(x)
  0x1400bdcc1		f20f51db		SQRTSD X3, X3		
  0x1400bdcc5		f20f51c0		SQRTSD X0, X0		
		sc2 := math.Sqrt(max(0.0, 1.0-cc2*cc2))
  0x1400bdcc9		0f10e0			MOVUPS X0, X4				
  0x1400bdccc		f20f59c0		MULSD X0, X0				
  0x1400bdcd0		f20f102d38850100	MOVSD_XMM $f64.3ff0000000000000(SB), X5	
  0x1400bdcd8		f20f5ce8		SUBSD X0, X5				
  0x1400bdcdc		f20f100564860100	MOVSD_XMM $f64.8000000000000000(SB), X0	
  0x1400bdce4		660fefe8		PXOR X0, X5				
  0x1400bdce8		f20f10b42438010000	MOVSD_XMM 0x138(SP), X6			
  0x1400bdcf1		0f10fe			MOVUPS X6, X7				
  0x1400bdcf4		f20f5df5		MINSD X5, X6				
  0x1400bdcf8		0f10ee			MOVUPS X6, X5				
  0x1400bdcfb		f20f5df7		MINSD X7, X6				
  0x1400bdcff		660febee		POR X6, X5				
  0x1400bdd03		660fefe8		PXOR X0, X5				
		gx2 := g2 * (ct*cc2 - st*sc2*ce2)
  0x1400bdd07		f20f10b424e8000000	MOVSD_XMM 0xe8(SP), X6	
  0x1400bdd10		440f10c4		MOVUPS X4, X8		
  0x1400bdd14		f20f59e6		MULSD X6, X4		
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
  0x1400bdd18		f2440f108c2430010000	MOVSD_XMM 0x130(SP), X9	
  0x1400bdd22		f2450f59c8		MULSD X8, X9		
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)
  0x1400bdd27		f2440f10942420010000	MOVSD_XMM 0x120(SP), X10	
  0x1400bdd31		f2450f59c2		MULSD X10, X8			
	return sqrt(x)
  0x1400bdd36		f20f51ed		SQRTSD X5, X5		
		gx2 := g2 * (ct*cc2 - st*sc2*ce2)
  0x1400bdd3a		f2440f109424a8000000	MOVSD_XMM 0xa8(SP), X10	
  0x1400bdd44		450f10da		MOVUPS X10, X11		
  0x1400bdd48		f2440f59d5		MULSD X5, X10		
  0x1400bdd4d		f2440f10a424f8000000	MOVSD_XMM 0xf8(SP), X12	
  0x1400bdd57		f2450f59d4		MULSD X12, X10		
  0x1400bdd5c		f2410f5ce2		SUBSD X10, X4		
  0x1400bdd61		f20f59e3		MULSD X3, X4		
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
  0x1400bdd65		f2440f10942428010000	MOVSD_XMM 0x128(SP), X10	
  0x1400bdd6f		f2440f59d5		MULSD X5, X10			
  0x1400bdd74		c442a9b9cc		VFMADD231SD X12, X10, X9	
  0x1400bdd79		f2440f109424b0000000	MOVSD_XMM 0xb0(SP), X10		
  0x1400bdd83		450f10ea		MOVUPS X10, X13			
  0x1400bdd87		f2440f59d5		MULSD X5, X10			
  0x1400bdd8c		f2440f10b424b8000000	MOVSD_XMM 0xb8(SP), X14		
  0x1400bdd96		f2450f59d6		MULSD X14, X10			
  0x1400bdd9b		f2450f5cca		SUBSD X10, X9			
  0x1400bdda0		f2440f59cb		MULSD X3, X9			
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)
  0x1400bdda5		f2440f10942418010000	MOVSD_XMM 0x118(SP), X10	
  0x1400bddaf		f2440f59d5		MULSD X5, X10			
  0x1400bddb4		c442a9b9c4		VFMADD231SD X12, X10, X8	
  0x1400bddb9		f2440f109424f0000000	MOVSD_XMM 0xf0(SP), X10		
  0x1400bddc3		f2410f59ea		MULSD X10, X5			
  0x1400bddc8		c442d1b9c6		VFMADD231SD X14, X5, X8		
  0x1400bddcd		f2410f59d8		MULSD X8, X3			
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x1400bddd2		66480f7ece		MOVQ X1, SI		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x1400bddd7		480fbaf63f		BTRQ $0x3f, SI		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x1400bdddc		66480f6ece		MOVQ SI, X1		
		cc = math.Sqrt(e_sc / energy)
  0x1400bdde1		0f10e9			MOVUPS X1, X5		
  0x1400bdde4		f20f5eca		DIVSD X2, X1		
	return sqrt(x)
  0x1400bdde8		f20f51c9		SQRTSD X1, X1		
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400bddec		0f10d1			MOVUPS X1, X2				
  0x1400bddef		f20f59c9		MULSD X1, X1				
  0x1400bddf3		f2440f100514840100	MOVSD_XMM $f64.3ff0000000000000(SB), X8	
  0x1400bddfc		f2440f5cc1		SUBSD X1, X8				
  0x1400bde01		66440fefc0		PXOR X0, X8				
  0x1400bde06		0f10cf			MOVUPS X7, X1				
  0x1400bde09		f2410f5df8		MINSD X8, X7				
  0x1400bde0e		440f10c7		MOVUPS X7, X8				
  0x1400bde12		f20f5df9		MINSD X1, X7				
  0x1400bde16		66440febc7		POR X7, X8				
		g = math.Sqrt(e_sc * TWO_OVER_E_MASS)
  0x1400bde1b		f20f100d1d850100	MOVSD_XMM $f64.463bb62aabbfcc6d(SB), X1	
  0x1400bde23		f20f59e9		MULSD X1, X5				
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400bde27		66440fefc0		PXOR X0, X8		
			Vx: wx + F2*gx2,
  0x1400bde2c		f20f10842490000000	MOVSD_XMM 0x90(SP), X0			
  0x1400bde35		f20f100dcb830100	MOVSD_XMM $f64.3fefffe3339a0103(SB), X1	
  0x1400bde3d		0f10f8			MOVUPS X0, X7				
  0x1400bde40		c4e2f1b9c4		VFMADD231SD X4, X1, X0			
			Vy: wy + F2*gy2,
  0x1400bde45		f20f10a42488000000	MOVSD_XMM 0x88(SP), X4	
  0x1400bde4e		440f10e4		MOVUPS X4, X12		
  0x1400bde52		c4c2f1b9e1		VFMADD231SD X9, X1, X4	
			Vz: wz + F2*gz2,
  0x1400bde57		f2440f108c2480000000	MOVSD_XMM 0x80(SP), X9	
  0x1400bde61		450f10f1		MOVUPS X9, X14		
  0x1400bde65		c462f1b9cb		VFMADD231SD X3, X1, X9	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400bde6a		488bb42488010000	MOVQ 0x188(SP), SI	
  0x1400bde72		4839d6			CMPQ SI, DX		
  0x1400bde75		0f839f040000		JAE 0x1400be31a		
		g = math.Sqrt(e_sc * TWO_OVER_E_MASS)
  0x1400bde7b		f20f116c2468		MOVSD_XMM X5, 0x68(SP)	
	return sqrt(x)
  0x1400bde81		f20f11942438010000	MOVSD_XMM X2, 0x138(SP)	
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400bde8a		f2440f11442460		MOVSD_XMM X8, 0x60(SP)	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400bde91		488b9190000000		MOVQ 0x90(CX), DX	
  0x1400bde98		4c8d0476		LEAQ 0(SI)(SI*2), R8	
  0x1400bde9c		4c89842408010000	MOVQ R8, 0x108(SP)	
  0x1400bdea4		4e8b4cc210		MOVQ 0x10(DX)(R8*8), R9	
  0x1400bdea9		4a8b5cc208		MOVQ 0x8(DX)(R8*8), BX	
  0x1400bdeae		48ffc3			INCQ BX			
  0x1400bdeb1		4a8b04c2		MOVQ 0(DX)(R8*8), AX	
  0x1400bdeb5		4939d9			CMPQ R9, BX		
  0x1400bdeb8		0f83fb000000		JAE 0x1400bdfb9		
  0x1400bdebe		4889942440010000	MOVQ DX, 0x140(SP)	
			Vx: wx + F2*gx2,
  0x1400bdec6		f20f11842430010000	MOVSD_XMM X0, 0x130(SP)	
			Vy: wy + F2*gy2,
  0x1400bdecf		f20f11a42428010000	MOVSD_XMM X4, 0x128(SP)	
			Vz: wz + F2*gz2,
  0x1400bded8		f2440f118c2420010000	MOVSD_XMM X9, 0x120(SP)	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400bdee2		4c89c9			MOVQ R9, CX				
  0x1400bdee5		bf01000000		MOVL $0x1, DI				
  0x1400bdeea		488d359f5b1000		LEAQ type:*+128664(SB), SI		
  0x1400bdef1		e88ab7fbff		CALL runtime.growslice(SB)		
  0x1400bdef6		488b942408010000	MOVQ 0x108(SP), DX			
  0x1400bdefe		4c8b842440010000	MOVQ 0x140(SP), R8			
  0x1400bdf06		49894cd010		MOVQ CX, 0x10(R8)(DX*8)			
  0x1400bdf0b		833d9e31160000		CMPL runtime.writeBarrier(SB), $0x0	
  0x1400bdf12		7410			JE 0x1400bdf24				
  0x1400bdf14		498b0cd0		MOVQ 0(R8)(DX*8), CX			
  0x1400bdf18		e8c301fcff		CALL runtime.gcWriteBarrier2(SB)	
  0x1400bdf1d		498903			MOVQ AX, 0(R11)				
  0x1400bdf20		49894b08		MOVQ CX, 0x8(R11)			
  0x1400bdf24		498904d0		MOVQ AX, 0(R8)(DX*8)			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400bdf28		488b8c2458010000	MOVQ 0x158(SP), CX	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400bdf30		4c89c2			MOVQ R8, DX		
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400bdf33		488bb42488010000	MOVQ 0x188(SP), SI	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400bdf3b		4c8b842408010000	MOVQ 0x108(SP), R8	
  0x1400bdf43		f20f10842430010000	MOVSD_XMM 0x130(SP), X0	
  0x1400bdf4c		f20f10942438010000	MOVSD_XMM 0x138(SP), X2	
  0x1400bdf55		f20f10a42428010000	MOVSD_XMM 0x128(SP), X4	
	return sqrt(x)
  0x1400bdf5e		f20f106c2468		MOVSD_XMM 0x68(SP), X5	
	gx = g * (ct*cc - st*sc*ce)
  0x1400bdf64		f20f10b424e8000000	MOVSD_XMM 0xe8(SP), X6	
	*vxe = wx + F2*gx
  0x1400bdf6d		f20f10bc2490000000	MOVSD_XMM 0x90(SP), X7	
	return sqrt(x)
  0x1400bdf76		f2440f10442460		MOVSD_XMM 0x60(SP), X8	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400bdf7d		f2440f108c2420010000	MOVSD_XMM 0x120(SP), X9	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400bdf87		f2440f109424f0000000	MOVSD_XMM 0xf0(SP), X10	
	gx = g * (ct*cc - st*sc*ce)
  0x1400bdf91		f2440f109c24a8000000	MOVSD_XMM 0xa8(SP), X11	
	*vye = wy + F2*gy
  0x1400bdf9b		f2440f10a42488000000	MOVSD_XMM 0x88(SP), X12	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400bdfa5		f2440f10ac24b0000000	MOVSD_XMM 0xb0(SP), X13	
	*vze = wz + F2*gz
  0x1400bdfaf		f2440f10b42480000000	MOVSD_XMM 0x80(SP), X14	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400bdfb9		4a895cc208		MOVQ BX, 0x8(DX)(R8*8)		
  0x1400bdfbe		488d53ff		LEAQ -0x1(BX), DX		
  0x1400bdfc2		48c1e205		SHLQ $0x5, DX			
  0x1400bdfc6		f20f108c2460010000	MOVSD_XMM 0x160(SP), X1		
  0x1400bdfcf		f20f110c10		MOVSD_XMM X1, 0(AX)(DX*1)	
  0x1400bdfd4		f20f11441008		MOVSD_XMM X0, 0x8(AX)(DX*1)	
  0x1400bdfda		f20f11641010		MOVSD_XMM X4, 0x10(AX)(DX*1)	
  0x1400bdfe0		f2440f114c1018		MOVSD_XMM X9, 0x18(AX)(DX*1)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400bdfe7		488b91f02dba07		MOVQ 0x7ba2df0(CX), DX	
			Vx: sim.WorkerRMB(workerID),
  0x1400bdfee		90			NOPL			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400bdfef		4839d6			CMPQ SI, DX				
  0x1400bdff2		0f831d030000		JAE 0x1400be315				
  0x1400bdff8		488b89e82dba07		MOVQ 0x7ba2de8(CX), CX			
  0x1400bdfff		488b04f1		MOVQ 0(CX)(SI*8), AX			
  0x1400be003		e838eeffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x1400be008		488b8c2458010000	MOVQ 0x158(SP), CX			
  0x1400be010		488b91f02dba07		MOVQ 0x7ba2df0(CX), DX			
			Vy: sim.WorkerRMB(workerID),
  0x1400be017		90			NOPL			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be018		f20f5905502e1600	MULSD gopic.RMB_sigma(SB), X0		
  0x1400be020		488b9c2488010000	MOVQ 0x188(SP), BX			
  0x1400be028		4839d3			CMPQ BX, DX				
  0x1400be02b		0f83df020000		JAE 0x1400be310				
  0x1400be031		f20f11442450		MOVSD_XMM X0, 0x50(SP)			
  0x1400be037		488b89e82dba07		MOVQ 0x7ba2de8(CX), CX			
  0x1400be03e		488b04d9		MOVQ 0(CX)(BX*8), AX			
  0x1400be042		e8f9edffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x1400be047		488b8c2458010000	MOVQ 0x158(SP), CX			
  0x1400be04f		488b91f02dba07		MOVQ 0x7ba2df0(CX), DX			
			Vz: sim.WorkerRMB(workerID),
  0x1400be056		90			NOPL			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be057		f20f5905112e1600	MULSD gopic.RMB_sigma(SB), X0		
  0x1400be05f		488b9c2488010000	MOVQ 0x188(SP), BX			
  0x1400be067		4839d3			CMPQ BX, DX				
  0x1400be06a		0f839b020000		JAE 0x1400be30b				
  0x1400be070		f20f11442448		MOVSD_XMM X0, 0x48(SP)			
  0x1400be076		488b89e82dba07		MOVQ 0x7ba2de8(CX), CX			
  0x1400be07d		488b04d9		MOVQ 0(CX)(BX*8), AX			
  0x1400be081		e8baedffff		CALL math/rand.(*Rand).NormFloat64(SB)	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x1400be086		488b8c2458010000	MOVQ 0x158(SP), CX	
  0x1400be08e		488b91b0000000		MOVQ 0xb0(CX), DX	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be095		f20f5905d32d1600	MULSD gopic.RMB_sigma(SB), X0	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x1400be09d		488b9c2488010000	MOVQ 0x188(SP), BX	
  0x1400be0a5		4839d3			CMPQ BX, DX		
  0x1400be0a8		0f8358020000		JAE 0x1400be306		
  0x1400be0ae		488b91a8000000		MOVQ 0xa8(CX), DX	
  0x1400be0b5		4c8b842408010000	MOVQ 0x108(SP), R8	
  0x1400be0bd		4a8b4cc210		MOVQ 0x10(DX)(R8*8), CX	
  0x1400be0c2		4a8b5cc208		MOVQ 0x8(DX)(R8*8), BX	
  0x1400be0c7		48ffc3			INCQ BX			
  0x1400be0ca		4a8b04c2		MOVQ 0(DX)(R8*8), AX	
  0x1400be0ce		4839d9			CMPQ CX, BX		
  0x1400be0d1		7360			JAE 0x1400be133		
  0x1400be0d3		4889942440010000	MOVQ DX, 0x140(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be0db		f20f11442440		MOVSD_XMM X0, 0x40(SP)	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x1400be0e1		bf01000000		MOVL $0x1, DI				
  0x1400be0e6		488d35a3591000		LEAQ type:*+128664(SB), SI		
  0x1400be0ed		e88eb5fbff		CALL runtime.growslice(SB)		
  0x1400be0f2		488b942408010000	MOVQ 0x108(SP), DX			
  0x1400be0fa		4c8b842440010000	MOVQ 0x140(SP), R8			
  0x1400be102		49894cd010		MOVQ CX, 0x10(R8)(DX*8)			
  0x1400be107		833da22f160000		CMPL runtime.writeBarrier(SB), $0x0	
  0x1400be10e		7410			JE 0x1400be120				
  0x1400be110		498b0cd0		MOVQ 0(R8)(DX*8), CX			
  0x1400be114		e8c7fffbff		CALL runtime.gcWriteBarrier2(SB)	
  0x1400be119		498903			MOVQ AX, 0(R11)				
  0x1400be11c		49894b08		MOVQ CX, 0x8(R11)			
  0x1400be120		498904d0		MOVQ AX, 0(R8)(DX*8)			
  0x1400be124		f20f10442440		MOVSD_XMM 0x40(SP), X0			
  0x1400be12a		4889d1			MOVQ DX, CX				
  0x1400be12d		4c89c2			MOVQ R8, DX				
  0x1400be130		4989c8			MOVQ CX, R8				
  0x1400be133		4a895cc208		MOVQ BX, 0x8(DX)(R8*8)			
  0x1400be138		488d4bff		LEAQ -0x1(BX), CX			
  0x1400be13c		48c1e105		SHLQ $0x5, CX				
  0x1400be140		f20f109c2460010000	MOVSD_XMM 0x160(SP), X3			
  0x1400be149		f20f111c08		MOVSD_XMM X3, 0(AX)(CX*1)		
  0x1400be14e		f20f105c2450		MOVSD_XMM 0x50(SP), X3			
  0x1400be154		f20f115c0808		MOVSD_XMM X3, 0x8(AX)(CX*1)		
  0x1400be15a		f20f105c2448		MOVSD_XMM 0x48(SP), X3			
  0x1400be160		f20f115c0810		MOVSD_XMM X3, 0x10(AX)(CX*1)		
  0x1400be166		f20f11440818		MOVSD_XMM X0, 0x18(AX)(CX*1)		
	return sqrt(x)
  0x1400be16c		f20f10442468		MOVSD_XMM 0x68(SP), X0	
  0x1400be172		f20f51c8		SQRTSD X0, X1		
  0x1400be176		f20f10442460		MOVSD_XMM 0x60(SP), X0	
  0x1400be17c		f20f51d0		SQRTSD X0, X2		
  0x1400be180		f20f10842438010000	MOVSD_XMM 0x138(SP), X0	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x1400be189		eb73			JMP 0x1400be1fe		
		cc = 1.0 - 2.0*sim.WorkerR01(workerID)
  0x1400be18b		488b842458010000	MOVQ 0x158(SP), AX				
  0x1400be193		488b9c2488010000	MOVQ 0x188(SP), BX				
  0x1400be19b		0f1f440000		NOPL 0(AX)(AX*1)				
  0x1400be1a0		e85b780000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400be1a5		f20f58c0		ADDSD X0, X0					
  0x1400be1a9		f20f100d5f800100	MOVSD_XMM $f64.3ff0000000000000(SB), X1		
  0x1400be1b1		f20f5cc8		SUBSD X0, X1					
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400be1b5		0f57c0			XORPS X0, X0				
  0x1400be1b8		f20f101588810100	MOVSD_XMM $f64.8000000000000000(SB), X2	
  0x1400be1c0		660fefc2		PXOR X2, X0				
  0x1400be1c4		0f10d9			MOVUPS X1, X3				
  0x1400be1c7		f20f59c9		MULSD X1, X1				
  0x1400be1cb		f20f10253d800100	MOVSD_XMM $f64.3ff0000000000000(SB), X4	
  0x1400be1d3		f20f5ce1		SUBSD X1, X4				
  0x1400be1d7		660fefe2		PXOR X2, X4				
  0x1400be1db		0f10c8			MOVUPS X0, X1				
  0x1400be1de		f20f5dc4		MINSD X4, X0				
  0x1400be1e2		0f10e0			MOVUPS X0, X4				
  0x1400be1e5		f20f5dc1		MINSD X1, X0				
  0x1400be1e9		660febe0		POR X0, X4				
  0x1400be1ed		660fefe2		PXOR X2, X4				
	return sqrt(x)
  0x1400be1f1		f20f51d4		SQRTSD X4, X2		
	gx = g * (ct*cc - st*sc*ce)
  0x1400be1f5		f20f104c2458		MOVSD_XMM 0x58(SP), X1	
  0x1400be1fb		0f10c3			MOVUPS X3, X0		
  0x1400be1fe		f20f109c24e8000000	MOVSD_XMM 0xe8(SP), X3	
  0x1400be207		0f10e3			MOVUPS X3, X4		
  0x1400be20a		f20f59d8		MULSD X0, X3		
  0x1400be20e		f20f10ac24a8000000	MOVSD_XMM 0xa8(SP), X5	
  0x1400be217		0f10f5			MOVUPS X5, X6		
  0x1400be21a		f20f59ea		MULSD X2, X5		
  0x1400be21e		f20f10bc2400010000	MOVSD_XMM 0x100(SP), X7	
  0x1400be227		f20f59ef		MULSD X7, X5		
  0x1400be22b		f20f5cdd		SUBSD X5, X3		
  0x1400be22f		f20f59d9		MULSD X1, X3		
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400be233		f20f10ac24f0000000	MOVSD_XMM 0xf0(SP), X5	
  0x1400be23c		440f10c6		MOVUPS X6, X8		
  0x1400be240		f20f59f5		MULSD X5, X6		
  0x1400be244		f20f59f0		MULSD X0, X6		
  0x1400be248		440f10cc		MOVUPS X4, X9		
  0x1400be24c		f20f59e5		MULSD X5, X4		
  0x1400be250		f20f59e2		MULSD X2, X4		
  0x1400be254		c4e2d9b9f7		VFMADD231SD X7, X4, X6	
  0x1400be259		f20f10a424b0000000	MOVSD_XMM 0xb0(SP), X4	
  0x1400be262		440f10d4		MOVUPS X4, X10		
  0x1400be266		f20f59e2		MULSD X2, X4		
  0x1400be26a		f2440f109c24c0000000	MOVSD_XMM 0xc0(SP), X11	
  0x1400be274		f2410f59e3		MULSD X11, X4		
  0x1400be279		f20f5cf4		SUBSD X4, X6		
  0x1400be27d		f20f59f1		MULSD X1, X6		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x1400be281		f2450f59c2		MULSD X10, X8		
  0x1400be286		f2410f59c0		MULSD X8, X0		
  0x1400be28b		f2450f59ca		MULSD X10, X9		
  0x1400be290		f2440f59ca		MULSD X2, X9		
  0x1400be295		c4e2b1b9c7		VFMADD231SD X7, X9, X0	
  0x1400be29a		f20f59ea		MULSD X2, X5		
  0x1400be29e		c4c2d1b9c3		VFMADD231SD X11, X5, X0	
  0x1400be2a3		f20f59c1		MULSD X1, X0		
	*vxe = wx + F2*gx
  0x1400be2a7		f20f108c2490000000	MOVSD_XMM 0x90(SP), X1			
  0x1400be2b0		f20f1015507f0100	MOVSD_XMM $f64.3fefffe3339a0103(SB), X2	
  0x1400be2b8		c4e2e1b9ca		VFMADD231SD X2, X3, X1			
  0x1400be2bd		488b842468010000	MOVQ 0x168(SP), AX			
  0x1400be2c5		f20f1108		MOVSD_XMM X1, 0(AX)			
	*vye = wy + F2*gy
  0x1400be2c9		f20f108c2488000000	MOVSD_XMM 0x88(SP), X1	
  0x1400be2d2		c4e2c9b9ca		VFMADD231SD X2, X6, X1	
  0x1400be2d7		488b842470010000	MOVQ 0x170(SP), AX	
  0x1400be2df		f20f1108		MOVSD_XMM X1, 0(AX)	
	*vze = wz + F2*gz
  0x1400be2e3		f20f108c2480000000	MOVSD_XMM 0x80(SP), X1	
  0x1400be2ec		c4e2f9b9ca		VFMADD231SD X2, X0, X1	
  0x1400be2f1		488b842478010000	MOVQ 0x178(SP), AX	
  0x1400be2f9		f20f1108		MOVSD_XMM X1, 0(AX)	
}
  0x1400be2fd		4881c448010000		ADDQ $0x148, SP		
  0x1400be304		5d			POPQ BP			
  0x1400be305		c3			RET			
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x1400be306		e87501fcff		CALL runtime.panicBounds(SB)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be30b		e87001fcff		CALL runtime.panicBounds(SB)	
  0x1400be310		e86b01fcff		CALL runtime.panicBounds(SB)	
  0x1400be315		e86601fcff		CALL runtime.panicBounds(SB)	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be31a		e86101fcff		CALL runtime.panicBounds(SB)	
	t0 := sim.Sigma[E_ELA][eindex]
  0x1400be31f		b840420f00		MOVL $0xf4240, AX		
  0x1400be324		e85701fcff		CALL runtime.panicBounds(SB)	
  0x1400be329		90			NOPL				
func (sim *SimulationState) CollisionElectron(xe float64, vxe, vye, vze *float64, eindex int, workerID int) {
  0x1400be32a		4889442408		MOVQ AX, 0x8(SP)					
  0x1400be32f		f20f11442410		MOVSD_XMM X0, 0x10(SP)					
  0x1400be335		48895c2418		MOVQ BX, 0x18(SP)					
  0x1400be33a		48894c2420		MOVQ CX, 0x20(SP)					
  0x1400be33f		48897c2428		MOVQ DI, 0x28(SP)					
  0x1400be344		4889742430		MOVQ SI, 0x30(SP)					
  0x1400be349		4c89442438		MOVQ R8, 0x38(SP)					
  0x1400be34e		e8ede2fbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400be353		488b442408		MOVQ 0x8(SP), AX					
  0x1400be358		f20f10442410		MOVSD_XMM 0x10(SP), X0					
  0x1400be35e		488b5c2418		MOVQ 0x18(SP), BX					
  0x1400be363		488b4c2420		MOVQ 0x20(SP), CX					
  0x1400be368		488b7c2428		MOVQ 0x28(SP), DI					
  0x1400be36d		488b742430		MOVQ 0x30(SP), SI					
  0x1400be372		4c8b442438		MOVQ 0x38(SP), R8					
  0x1400be377		e9e4f4ffff		JMP gopic.(*SimulationState).CollisionElectron(SB)	

  0x1400be37c		cc			INT $0x3		
  0x1400be37d		cc			INT $0x3		
  0x1400be37e		cc			INT $0x3		
  0x1400be37f		cc			INT $0x3		


