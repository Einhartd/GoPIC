// =============================================================================
// SYMBOL: CollisionElectron
// =============================================================================

TEXT gopic.(*SimulationState).CollisionElectron(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/collisions.go
func (sim *SimulationState) CollisionElectron(xe float64, vxe, vye, vze *float64, eindex int, workerID int) {
  0x1400bde40		4c8da42430ffffff	LEAQ 0xffffff30(SP), R12	
  0x1400bde48		4d3b6610		CMPQ R12, 0x10(R14)		
  0x1400bde4c		0f86b80a0000		JBE 0x1400be90a			
  0x1400bde52		55			PUSHQ BP			
  0x1400bde53		4889e5			MOVQ SP, BP			
  0x1400bde56		4881ec48010000		SUBQ $0x148, SP			
	gx := *vxe
  0x1400bde5d		f20f100b		MOVSD_XMM 0(BX), X1	
	gy := *vye
  0x1400bde61		f20f1011		MOVSD_XMM 0(CX), X2	
	gz := *vze
  0x1400bde65		f20f101f		MOVSD_XMM 0(DI), X3	
	g_perp_sq := gy*gy + gz*gz
  0x1400bde69		0f10e3			MOVUPS X3, X4		
  0x1400bde6c		f20f59db		MULSD X3, X3		
  0x1400bde70		c4e2e9b9da		VFMADD231SD X2, X2, X3	
	g_sq := gx*gx + g_perp_sq
  0x1400bde75		0f10eb			MOVUPS X3, X5		
  0x1400bde78		c4e2f1b9d9		VFMADD231SD X1, X1, X3	
	return sqrt(x)
  0x1400bde7d		f20f51f3		SQRTSD X3, X6		
	g := math.Sqrt(g_sq)
  0x1400bde81		90			NOPL			
	g_perp := math.Sqrt(g_perp_sq)
  0x1400bde82		90			NOPL			
	wx := F1 * (*vxe)
  0x1400bde83		f20f103d35930100	MOVSD_XMM $f64.3eeccc65fefd8fed(SB), X7	
  0x1400bde8b		f20f59f9		MULSD X1, X7				
	wy := F1 * (*vye)
  0x1400bde8f		f2440f100528930100	MOVSD_XMM $f64.3eeccc65fefd8fed(SB), X8	
  0x1400bde98		f2440f59c2		MULSD X2, X8				
	wz := F1 * (*vze)
  0x1400bde9d		f2440f100d1a930100	MOVSD_XMM $f64.3eeccc65fefd8fed(SB), X9	
  0x1400bdea6		f2440f59cc		MULSD X4, X9				
	return sqrt(x)
  0x1400bdeab		f20f51ed		SQRTSD X5, X5		
	if g > 0.0 {
  0x1400bdeaf		450f57d2		XORPS X10, X10		
  0x1400bdeb3		66410f2ef2		UCOMISD X10, X6		
  0x1400bdeb8		760e			JBE 0x1400bdec8		
		ct = gx / g
  0x1400bdeba		f20f5ece		DIVSD X6, X1		
		st = g_perp / g
  0x1400bdebe		440f10dd		MOVUPS X5, X11		
  0x1400bdec2		f20f5eee		DIVSD X6, X5		
  0x1400bdec6		eb0f			JMP 0x1400bded7		
	if g_perp > 0.0 {
  0x1400bdec8		440f10dd		MOVUPS X5, X11				
  0x1400bdecc		0f57ed			XORPS X5, X5				
  0x1400bdecf		f20f100d81930100	MOVSD_XMM $f64.3ff0000000000000(SB), X1	
  0x1400bded7		66450f2eda		UCOMISD X10, X11			
  0x1400bdedc		760c			JBE 0x1400bdeea				
		cp = gy / g_perp
  0x1400bdede		f2410f5ed3		DIVSD X11, X2		
		sp = gz / g_perp
  0x1400bdee3		f2410f5ee3		DIVSD X11, X4				
  0x1400bdee8		eb0b			JMP 0x1400bdef5				
  0x1400bdeea		0f57e4			XORPS X4, X4				
  0x1400bdeed		f20f101563930100	MOVSD_XMM $f64.3ff0000000000000(SB), X2	
	t0 := sim.Sigma[E_ELA][eindex]
  0x1400bdef5		8400			TESTB AL, 0(AX)		
  0x1400bdef7		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x1400bdf00		4881fe40420f00		CMPQ SI, $0xf4240	
  0x1400bdf07		0f83f2090000		JAE 0x1400be8ff		
	if g > 0.0 {
  0x1400bdf0d		4889842458010000	MOVQ AX, 0x158(SP)	
  0x1400bdf15		f20f11842460010000	MOVSD_XMM X0, 0x160(SP)	
  0x1400bdf1e		48899c2468010000	MOVQ BX, 0x168(SP)	
  0x1400bdf26		48898c2470010000	MOVQ CX, 0x170(SP)	
  0x1400bdf2e		4889bc2478010000	MOVQ DI, 0x178(SP)	
  0x1400bdf36		4c89842488010000	MOVQ R8, 0x188(SP)	
	g_sq := gx*gx + g_perp_sq
  0x1400bdf3e		f20f119c24d8000000	MOVSD_XMM X3, 0xd8(SP)	
	return sqrt(x)
  0x1400bdf47		f20f11742458		MOVSD_XMM X6, 0x58(SP)	
	wx := F1 * (*vxe)
  0x1400bdf4d		f20f11bc2490000000	MOVSD_XMM X7, 0x90(SP)	
	wy := F1 * (*vye)
  0x1400bdf56		f2440f11842488000000	MOVSD_XMM X8, 0x88(SP)	
	wz := F1 * (*vze)
  0x1400bdf60		f2440f118c2480000000	MOVSD_XMM X9, 0x80(SP)	
	t0 := sim.Sigma[E_ELA][eindex]
  0x1400bdf6a		f20f11a424b0000000	MOVSD_XMM X4, 0xb0(SP)	
  0x1400bdf73		f20f119424f0000000	MOVSD_XMM X2, 0xf0(SP)	
	if g_perp > 0.0 {
  0x1400bdf7c		f20f11ac24a8000000	MOVSD_XMM X5, 0xa8(SP)	
  0x1400bdf85		f20f118c24e8000000	MOVSD_XMM X1, 0xe8(SP)	
	t0 := sim.Sigma[E_ELA][eindex]
  0x1400bdf8e		f20f1084f0c0000000	MOVSD_XMM 0xc0(AX)(SI*8), X0	
  0x1400bdf97		f20f118424a0000000	MOVSD_XMM X0, 0xa0(SP)		
	t1 := t0 + sim.Sigma[E_EXC][eindex]
  0x1400bdfa0		f20f108cf0c0127a00	MOVSD_XMM 0x7a12c0(AX)(SI*8), X1	
  0x1400bdfa9		f20f58c8		ADDSD X0, X1				
  0x1400bdfad		f20f118c2498000000	MOVSD_XMM X1, 0x98(SP)			
	t2 := t1 + sim.Sigma[E_ION][eindex]
  0x1400bdfb6		f20f1084f0c024f400	MOVSD_XMM 0xf424c0(AX)(SI*8), X0	
  0x1400bdfbf		f20f11842438010000	MOVSD_XMM X0, 0x138(SP)			
	rnd := sim.WorkerR01(workerID)
  0x1400bdfc8		4c89c3			MOVQ R8, BX					
  0x1400bdfcb		e810810000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400bdfd0		f20f118424c8000000	MOVSD_XMM X0, 0xc8(SP)				
	eta := TWO_PI * sim.WorkerR01(workerID)
  0x1400bdfd9		488b842458010000	MOVQ 0x158(SP), AX				
  0x1400bdfe1		488b9c2488010000	MOVQ 0x188(SP), BX				
  0x1400bdfe9		e8f2800000		CALL gopic.(*SimulationState).WorkerR01(SB)	
	t2 := t1 + sim.Sigma[E_ION][eindex]
  0x1400bdfee		f20f108c2438010000	MOVSD_XMM 0x138(SP), X1	
  0x1400bdff7		f20f10942498000000	MOVSD_XMM 0x98(SP), X2	
  0x1400be000		f20f58ca		ADDSD X2, X1		
	r_t2 := rnd * t2
  0x1400be004		f20f109424c8000000	MOVSD_XMM 0xc8(SP), X2	
  0x1400be00d		f20f59ca		MULSD X2, X1		
  0x1400be011		f20f118c24d0000000	MOVSD_XMM X1, 0xd0(SP)	
	eta := TWO_PI * sim.WorkerR01(workerID)
  0x1400be01a		f20f100dae920100	MOVSD_XMM $f64.401921fb54442d18(SB), X1	
  0x1400be022		f20f59c1		MULSD X1, X0				
	se, ce := math.Sincos(eta)
  0x1400be026		e8155efcff		CALL math.Sincos(SB)	
  0x1400be02b		f20f118c2400010000	MOVSD_XMM X1, 0x100(SP)	
  0x1400be034		f20f118424c0000000	MOVSD_XMM X0, 0xc0(SP)	
	if r_t2 < t0 { // Zderzenie sprÄ™ĹĽyste (izotropowe)
  0x1400be03d		f20f109424a0000000	MOVSD_XMM 0xa0(SP), X2	
  0x1400be046		f20f109c24d0000000	MOVSD_XMM 0xd0(SP), X3	
  0x1400be04f		660f2ed3		UCOMISD X3, X2		
  0x1400be053		0f8712070000		JA 0x1400be76b		
	} else if r_t2 < t1 { // Wzbudzenie (niesprÄ™ĹĽyste, izotropowe)
  0x1400be059		f20f10942498000000	MOVSD_XMM 0x98(SP), X2	
  0x1400be062		660f2ed3		UCOMISD X3, X2		
  0x1400be066		0f86d0000000		JBE 0x1400be13c		
		energy := HALF_E_MASS * g_sq
  0x1400be06c		f20f1005bc900100	MOVSD_XMM $f64.39a279dcc3e61461(SB), X0	
  0x1400be074		f20f108c24d8000000	MOVSD_XMM 0xd8(SP), X1			
  0x1400be07d		f20f59c1		MULSD X1, X0				
		energy = math.Abs(energy - E_EXC_TH*EV_TO_J)
  0x1400be081		f20f100def900100	MOVSD_XMM $f64.3c40fe7ccb02e6a7(SB), X1	
  0x1400be089		f20f5cc1		SUBSD X1, X0				
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400be08d		0f57c9			XORPS X1, X1				
  0x1400be090		f20f101500930100	MOVSD_XMM $f64.8000000000000000(SB), X2	
  0x1400be098		660fefca		PXOR X2, X1				
  0x1400be09c		f20f118c2438010000	MOVSD_XMM X1, 0x138(SP)			
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x1400be0a5		66480f7ec1		MOVQ X0, CX		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x1400be0aa		480fbaf13f		BTRQ $0x3f, CX		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x1400be0af		66480f6ec1		MOVQ CX, X0		
		g = math.Sqrt(energy * TWO_OVER_E_MASS)
  0x1400be0b4		f20f100dd4920100	MOVSD_XMM $f64.463bb62aabbfcc6d(SB), X1	
  0x1400be0bc		f20f59c8		MULSD X0, X1				
  0x1400be0c0		f20f114c2478		MOVSD_XMM X1, 0x78(SP)			
		cc = 1.0 - 2.0*sim.WorkerR01(workerID)
  0x1400be0c6		488b842458010000	MOVQ 0x158(SP), AX				
  0x1400be0ce		488b9c2488010000	MOVQ 0x188(SP), BX				
  0x1400be0d6		e805800000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400be0db		f20f58c0		ADDSD X0, X0					
  0x1400be0df		f20f100d71910100	MOVSD_XMM $f64.3ff0000000000000(SB), X1		
  0x1400be0e7		f20f5cc8		SUBSD X0, X1					
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400be0eb		0f10c1			MOVUPS X1, X0				
  0x1400be0ee		f20f59c9		MULSD X1, X1				
  0x1400be0f2		f20f10155e910100	MOVSD_XMM $f64.3ff0000000000000(SB), X2	
  0x1400be0fa		f20f5cd1		SUBSD X1, X2				
  0x1400be0fe		f20f100d92920100	MOVSD_XMM $f64.8000000000000000(SB), X1	
  0x1400be106		660fefd1		PXOR X1, X2				
  0x1400be10a		f20f109c2438010000	MOVSD_XMM 0x138(SP), X3			
  0x1400be113		0f10e3			MOVUPS X3, X4				
  0x1400be116		f20f5dda		MINSD X2, X3				
  0x1400be11a		0f10d3			MOVUPS X3, X2				
  0x1400be11d		f20f5ddc		MINSD X4, X3				
  0x1400be121		660febd3		POR X3, X2				
  0x1400be125		660fefd1		PXOR X1, X2				
	return sqrt(x)
  0x1400be129		f20f104c2478		MOVSD_XMM 0x78(SP), X1	
  0x1400be12f		f20f51c9		SQRTSD X1, X1		
  0x1400be133		f20f51d2		SQRTSD X2, X2		
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400be137		e9a2060000		JMP 0x1400be7de		
		energy := HALF_E_MASS * g_sq
  0x1400be13c		f20f1015ec8f0100	MOVSD_XMM $f64.39a279dcc3e61461(SB), X2	
  0x1400be144		f20f109c24d8000000	MOVSD_XMM 0xd8(SP), X3			
  0x1400be14d		f20f59d3		MULSD X3, X2				
		energy = math.Abs(energy - E_ION_TH*EV_TO_J)
  0x1400be151		f20f101d27900100	MOVSD_XMM $f64.3c475931051c7900(SB), X3	
  0x1400be159		f20f5cd3		SUBSD X3, X2				
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400be15d		0f57db			XORPS X3, X3				
  0x1400be160		f20f102530920100	MOVSD_XMM $f64.8000000000000000(SB), X4	
  0x1400be168		660fefdc		PXOR X4, X3				
  0x1400be16c		f20f119c2438010000	MOVSD_XMM X3, 0x138(SP)			
		se2 := -se
  0x1400be175		660fefe0		PXOR X0, X4		
  0x1400be179		f20f11a424b8000000	MOVSD_XMM X4, 0xb8(SP)	
		ce2 := -ce
  0x1400be182		f20f10050e920100	MOVSD_XMM $f64.8000000000000000(SB), X0	
  0x1400be18a		660fefc1		PXOR X1, X0				
  0x1400be18e		f20f118424f8000000	MOVSD_XMM X0, 0xf8(SP)			
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
  0x1400be197		f20f108424a8000000	MOVSD_XMM 0xa8(SP), X0	
  0x1400be1a0		f20f108c24f0000000	MOVSD_XMM 0xf0(SP), X1	
  0x1400be1a9		0f10d8			MOVUPS X0, X3		
  0x1400be1ac		f20f59c1		MULSD X1, X0		
  0x1400be1b0		f20f11842430010000	MOVSD_XMM X0, 0x130(SP)	
  0x1400be1b9		f20f108424e8000000	MOVSD_XMM 0xe8(SP), X0	
  0x1400be1c2		0f10e0			MOVUPS X0, X4		
  0x1400be1c5		f20f59c1		MULSD X1, X0		
  0x1400be1c9		f20f11842428010000	MOVSD_XMM X0, 0x128(SP)	
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)
  0x1400be1d2		f20f108424b0000000	MOVSD_XMM 0xb0(SP), X0	
  0x1400be1db		f20f59d8		MULSD X0, X3		
  0x1400be1df		f20f119c2420010000	MOVSD_XMM X3, 0x120(SP)	
  0x1400be1e8		f20f59e0		MULSD X0, X4		
  0x1400be1ec		f20f11a42418010000	MOVSD_XMM X4, 0x118(SP)	
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x1400be1f5		66480f7ed1		MOVQ X2, CX		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x1400be1fa		480fbaf13f		BTRQ $0x3f, CX		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x1400be1ff		66480f6ec1		MOVQ CX, X0		
  0x1400be204		f20f118424e0000000	MOVSD_XMM X0, 0xe0(SP)	
		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
  0x1400be20d		f20f100d63910100	MOVSD_XMM $f64.439152dbe5934720(SB), X1		
  0x1400be215		f20f59c8		MULSD X0, X1					
  0x1400be219		f20f114c2470		MOVSD_XMM X1, 0x70(SP)				
  0x1400be21f		488b842458010000	MOVQ 0x158(SP), AX				
  0x1400be227		488b9c2488010000	MOVQ 0x188(SP), BX				
  0x1400be22f		e8ac7e0000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400be234		f20f11842410010000	MOVSD_XMM X0, 0x110(SP)				
	return atan(x)
  0x1400be23d		f20f10442470		MOVSD_XMM 0x70(SP), X0	
  0x1400be243		e83852fcff		CALL math.atan(SB)	
		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
  0x1400be248		f20f108c2410010000	MOVSD_XMM 0x110(SP), X1	
  0x1400be251		f20f59c1		MULSD X1, X0		
	return tan(x)
  0x1400be255		e8a65efcff		CALL math.tan(SB)	
		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
  0x1400be25a		f20f100db68e0100	MOVSD_XMM runtime.egcbss+58(SB), X1	
  0x1400be262		f20f59c8		MULSD X0, X1				
  0x1400be266		f20f1005ea8e0100	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X0	
  0x1400be26e		f20f59c1		MULSD X1, X0				
		e_sc := math.Abs(energy - e_ej)
  0x1400be272		f20f108c24e0000000	MOVSD_XMM 0xe0(SP), X1	
  0x1400be27b		0f10d1			MOVUPS X1, X2		
  0x1400be27e		f20f5cc8		SUBSD X0, X1		
		g2 := math.Sqrt(e_ej * TWO_OVER_E_MASS)
  0x1400be282		f20f101d06910100	MOVSD_XMM $f64.463bb62aabbfcc6d(SB), X3	
  0x1400be28a		f20f59d8		MULSD X0, X3				
		cc2 := math.Sqrt(e_ej / energy)
  0x1400be28e		f20f5ec2		DIVSD X2, X0		
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be292		488b8c2458010000	MOVQ 0x158(SP), CX	
  0x1400be29a		488b9198000000		MOVQ 0x98(CX), DX	
	return sqrt(x)
  0x1400be2a1		f20f51db		SQRTSD X3, X3		
  0x1400be2a5		f20f51c0		SQRTSD X0, X0		
		sc2 := math.Sqrt(max(0.0, 1.0-cc2*cc2))
  0x1400be2a9		0f10e0			MOVUPS X0, X4				
  0x1400be2ac		f20f59c0		MULSD X0, X0				
  0x1400be2b0		f20f102da08f0100	MOVSD_XMM $f64.3ff0000000000000(SB), X5	
  0x1400be2b8		f20f5ce8		SUBSD X0, X5				
  0x1400be2bc		f20f1005d4900100	MOVSD_XMM $f64.8000000000000000(SB), X0	
  0x1400be2c4		660fefe8		PXOR X0, X5				
  0x1400be2c8		f20f10b42438010000	MOVSD_XMM 0x138(SP), X6			
  0x1400be2d1		0f10fe			MOVUPS X6, X7				
  0x1400be2d4		f20f5df5		MINSD X5, X6				
  0x1400be2d8		0f10ee			MOVUPS X6, X5				
  0x1400be2db		f20f5df7		MINSD X7, X6				
  0x1400be2df		660febee		POR X6, X5				
  0x1400be2e3		660fefe8		PXOR X0, X5				
		gx2 := g2 * (ct*cc2 - st*sc2*ce2)
  0x1400be2e7		f20f10b424e8000000	MOVSD_XMM 0xe8(SP), X6	
  0x1400be2f0		440f10c4		MOVUPS X4, X8		
  0x1400be2f4		f20f59e6		MULSD X6, X4		
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
  0x1400be2f8		f2440f108c2430010000	MOVSD_XMM 0x130(SP), X9	
  0x1400be302		f2450f59c8		MULSD X8, X9		
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)
  0x1400be307		f2440f10942420010000	MOVSD_XMM 0x120(SP), X10	
  0x1400be311		f2450f59c2		MULSD X10, X8			
	return sqrt(x)
  0x1400be316		f20f51ed		SQRTSD X5, X5		
		gx2 := g2 * (ct*cc2 - st*sc2*ce2)
  0x1400be31a		f2440f109424a8000000	MOVSD_XMM 0xa8(SP), X10	
  0x1400be324		450f10da		MOVUPS X10, X11		
  0x1400be328		f2440f59d5		MULSD X5, X10		
  0x1400be32d		f2440f10a424f8000000	MOVSD_XMM 0xf8(SP), X12	
  0x1400be337		f2450f59d4		MULSD X12, X10		
  0x1400be33c		f2410f5ce2		SUBSD X10, X4		
  0x1400be341		f20f59e3		MULSD X3, X4		
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
  0x1400be345		f2440f10942428010000	MOVSD_XMM 0x128(SP), X10	
  0x1400be34f		f2440f59d5		MULSD X5, X10			
  0x1400be354		c442a9b9cc		VFMADD231SD X12, X10, X9	
  0x1400be359		f2440f109424b0000000	MOVSD_XMM 0xb0(SP), X10		
  0x1400be363		450f10ea		MOVUPS X10, X13			
  0x1400be367		f2440f59d5		MULSD X5, X10			
  0x1400be36c		f2440f10b424b8000000	MOVSD_XMM 0xb8(SP), X14		
  0x1400be376		f2450f59d6		MULSD X14, X10			
  0x1400be37b		f2450f5cca		SUBSD X10, X9			
  0x1400be380		f2440f59cb		MULSD X3, X9			
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)
  0x1400be385		f2440f10942418010000	MOVSD_XMM 0x118(SP), X10	
  0x1400be38f		f2440f59d5		MULSD X5, X10			
  0x1400be394		c442a9b9c4		VFMADD231SD X12, X10, X8	
  0x1400be399		f2440f109424f0000000	MOVSD_XMM 0xf0(SP), X10		
  0x1400be3a3		f2410f59ea		MULSD X10, X5			
  0x1400be3a8		c442d1b9c6		VFMADD231SD X14, X5, X8		
  0x1400be3ad		f2410f59d8		MULSD X8, X3			
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x1400be3b2		66480f7ece		MOVQ X1, SI		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x1400be3b7		480fbaf63f		BTRQ $0x3f, SI		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x1400be3bc		66480f6ece		MOVQ SI, X1		
		cc = math.Sqrt(e_sc / energy)
  0x1400be3c1		0f10e9			MOVUPS X1, X5		
  0x1400be3c4		f20f5eca		DIVSD X2, X1		
	return sqrt(x)
  0x1400be3c8		f20f51c9		SQRTSD X1, X1		
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400be3cc		0f10d1			MOVUPS X1, X2				
  0x1400be3cf		f20f59c9		MULSD X1, X1				
  0x1400be3d3		f2440f10057c8e0100	MOVSD_XMM $f64.3ff0000000000000(SB), X8	
  0x1400be3dc		f2440f5cc1		SUBSD X1, X8				
  0x1400be3e1		66440fefc0		PXOR X0, X8				
  0x1400be3e6		0f10cf			MOVUPS X7, X1				
  0x1400be3e9		f2410f5df8		MINSD X8, X7				
  0x1400be3ee		440f10c7		MOVUPS X7, X8				
  0x1400be3f2		f20f5df9		MINSD X1, X7				
  0x1400be3f6		66440febc7		POR X7, X8				
		g = math.Sqrt(e_sc * TWO_OVER_E_MASS)
  0x1400be3fb		f20f100d8d8f0100	MOVSD_XMM $f64.463bb62aabbfcc6d(SB), X1	
  0x1400be403		f20f59e9		MULSD X1, X5				
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400be407		66440fefc0		PXOR X0, X8		
			Vx: wx + F2*gx2,
  0x1400be40c		f20f10842490000000	MOVSD_XMM 0x90(SP), X0			
  0x1400be415		f20f100d338e0100	MOVSD_XMM $f64.3fefffe3339a0103(SB), X1	
  0x1400be41d		0f10f8			MOVUPS X0, X7				
  0x1400be420		c4e2f1b9c4		VFMADD231SD X4, X1, X0			
			Vy: wy + F2*gy2,
  0x1400be425		f20f10a42488000000	MOVSD_XMM 0x88(SP), X4	
  0x1400be42e		440f10e4		MOVUPS X4, X12		
  0x1400be432		c4c2f1b9e1		VFMADD231SD X9, X1, X4	
			Vz: wz + F2*gz2,
  0x1400be437		f2440f108c2480000000	MOVSD_XMM 0x80(SP), X9	
  0x1400be441		450f10f1		MOVUPS X9, X14		
  0x1400be445		c462f1b9cb		VFMADD231SD X3, X1, X9	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be44a		488bb42488010000	MOVQ 0x188(SP), SI	
  0x1400be452		4839d6			CMPQ SI, DX		
  0x1400be455		0f839f040000		JAE 0x1400be8fa		
		g = math.Sqrt(e_sc * TWO_OVER_E_MASS)
  0x1400be45b		f20f116c2468		MOVSD_XMM X5, 0x68(SP)	
	return sqrt(x)
  0x1400be461		f20f11942438010000	MOVSD_XMM X2, 0x138(SP)	
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400be46a		f2440f11442460		MOVSD_XMM X8, 0x60(SP)	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be471		488b9190000000		MOVQ 0x90(CX), DX	
  0x1400be478		4c8d0476		LEAQ 0(SI)(SI*2), R8	
  0x1400be47c		4c89842408010000	MOVQ R8, 0x108(SP)	
  0x1400be484		4e8b4cc210		MOVQ 0x10(DX)(R8*8), R9	
  0x1400be489		4a8b5cc208		MOVQ 0x8(DX)(R8*8), BX	
  0x1400be48e		48ffc3			INCQ BX			
  0x1400be491		4a8b04c2		MOVQ 0(DX)(R8*8), AX	
  0x1400be495		4939d9			CMPQ R9, BX		
  0x1400be498		0f83fb000000		JAE 0x1400be599		
  0x1400be49e		4889942440010000	MOVQ DX, 0x140(SP)	
			Vx: wx + F2*gx2,
  0x1400be4a6		f20f11842430010000	MOVSD_XMM X0, 0x130(SP)	
			Vy: wy + F2*gy2,
  0x1400be4af		f20f11a42428010000	MOVSD_XMM X4, 0x128(SP)	
			Vz: wz + F2*gz2,
  0x1400be4b8		f2440f118c2420010000	MOVSD_XMM X9, 0x120(SP)	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be4c2		4c89c9			MOVQ R9, CX				
  0x1400be4c5		bf01000000		MOVL $0x1, DI				
  0x1400be4ca		488d35a77d1000		LEAQ type:*+129984(SB), SI		
  0x1400be4d1		e88ab1fbff		CALL runtime.growslice(SB)		
  0x1400be4d6		488b942408010000	MOVQ 0x108(SP), DX			
  0x1400be4de		4c8b842440010000	MOVQ 0x140(SP), R8			
  0x1400be4e6		49894cd010		MOVQ CX, 0x10(R8)(DX*8)			
  0x1400be4eb		833dbe5b160000		CMPL runtime.writeBarrier(SB), $0x0	
  0x1400be4f2		7410			JE 0x1400be504				
  0x1400be4f4		498b0cd0		MOVQ 0(R8)(DX*8), CX			
  0x1400be4f8		e8e3fbfbff		CALL runtime.gcWriteBarrier2(SB)	
  0x1400be4fd		498903			MOVQ AX, 0(R11)				
  0x1400be500		49894b08		MOVQ CX, 0x8(R11)			
  0x1400be504		498904d0		MOVQ AX, 0(R8)(DX*8)			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be508		488b8c2458010000	MOVQ 0x158(SP), CX	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be510		4c89c2			MOVQ R8, DX		
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be513		488bb42488010000	MOVQ 0x188(SP), SI	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be51b		4c8b842408010000	MOVQ 0x108(SP), R8	
  0x1400be523		f20f10842430010000	MOVSD_XMM 0x130(SP), X0	
  0x1400be52c		f20f10942438010000	MOVSD_XMM 0x138(SP), X2	
  0x1400be535		f20f10a42428010000	MOVSD_XMM 0x128(SP), X4	
	return sqrt(x)
  0x1400be53e		f20f106c2468		MOVSD_XMM 0x68(SP), X5	
	gx = g * (ct*cc - st*sc*ce)
  0x1400be544		f20f10b424e8000000	MOVSD_XMM 0xe8(SP), X6	
	*vxe = wx + F2*gx
  0x1400be54d		f20f10bc2490000000	MOVSD_XMM 0x90(SP), X7	
	return sqrt(x)
  0x1400be556		f2440f10442460		MOVSD_XMM 0x60(SP), X8	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be55d		f2440f108c2420010000	MOVSD_XMM 0x120(SP), X9	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400be567		f2440f109424f0000000	MOVSD_XMM 0xf0(SP), X10	
	gx = g * (ct*cc - st*sc*ce)
  0x1400be571		f2440f109c24a8000000	MOVSD_XMM 0xa8(SP), X11	
	*vye = wy + F2*gy
  0x1400be57b		f2440f10a42488000000	MOVSD_XMM 0x88(SP), X12	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400be585		f2440f10ac24b0000000	MOVSD_XMM 0xb0(SP), X13	
	*vze = wz + F2*gz
  0x1400be58f		f2440f10b42480000000	MOVSD_XMM 0x80(SP), X14	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be599		4a895cc208		MOVQ BX, 0x8(DX)(R8*8)		
  0x1400be59e		488d53ff		LEAQ -0x1(BX), DX		
  0x1400be5a2		48c1e205		SHLQ $0x5, DX			
  0x1400be5a6		f20f108c2460010000	MOVSD_XMM 0x160(SP), X1		
  0x1400be5af		f20f110c10		MOVSD_XMM X1, 0(AX)(DX*1)	
  0x1400be5b4		f20f11441008		MOVSD_XMM X0, 0x8(AX)(DX*1)	
  0x1400be5ba		f20f11641010		MOVSD_XMM X4, 0x10(AX)(DX*1)	
  0x1400be5c0		f2440f114c1018		MOVSD_XMM X9, 0x18(AX)(DX*1)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be5c7		488b91f02dba07		MOVQ 0x7ba2df0(CX), DX	
			Vx: sim.WorkerRMB(workerID),
  0x1400be5ce		90			NOPL			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be5cf		4839d6			CMPQ SI, DX				
  0x1400be5d2		0f831d030000		JAE 0x1400be8f5				
  0x1400be5d8		488b89e82dba07		MOVQ 0x7ba2de8(CX), CX			
  0x1400be5df		488b04f1		MOVQ 0(CX)(SI*8), AX			
  0x1400be5e3		e838eeffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x1400be5e8		488b8c2458010000	MOVQ 0x158(SP), CX			
  0x1400be5f0		488b91f02dba07		MOVQ 0x7ba2df0(CX), DX			
			Vy: sim.WorkerRMB(workerID),
  0x1400be5f7		90			NOPL			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be5f8		f20f590570581600	MULSD gopic.RMB_sigma(SB), X0		
  0x1400be600		488b9c2488010000	MOVQ 0x188(SP), BX			
  0x1400be608		4839d3			CMPQ BX, DX				
  0x1400be60b		0f83df020000		JAE 0x1400be8f0				
  0x1400be611		f20f11442450		MOVSD_XMM X0, 0x50(SP)			
  0x1400be617		488b89e82dba07		MOVQ 0x7ba2de8(CX), CX			
  0x1400be61e		488b04d9		MOVQ 0(CX)(BX*8), AX			
  0x1400be622		e8f9edffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x1400be627		488b8c2458010000	MOVQ 0x158(SP), CX			
  0x1400be62f		488b91f02dba07		MOVQ 0x7ba2df0(CX), DX			
			Vz: sim.WorkerRMB(workerID),
  0x1400be636		90			NOPL			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be637		f20f590531581600	MULSD gopic.RMB_sigma(SB), X0		
  0x1400be63f		488b9c2488010000	MOVQ 0x188(SP), BX			
  0x1400be647		4839d3			CMPQ BX, DX				
  0x1400be64a		0f839b020000		JAE 0x1400be8eb				
  0x1400be650		f20f11442448		MOVSD_XMM X0, 0x48(SP)			
  0x1400be656		488b89e82dba07		MOVQ 0x7ba2de8(CX), CX			
  0x1400be65d		488b04d9		MOVQ 0(CX)(BX*8), AX			
  0x1400be661		e8baedffff		CALL math/rand.(*Rand).NormFloat64(SB)	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x1400be666		488b8c2458010000	MOVQ 0x158(SP), CX	
  0x1400be66e		488b91b0000000		MOVQ 0xb0(CX), DX	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be675		f20f5905f3571600	MULSD gopic.RMB_sigma(SB), X0	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x1400be67d		488b9c2488010000	MOVQ 0x188(SP), BX	
  0x1400be685		4839d3			CMPQ BX, DX		
  0x1400be688		0f8358020000		JAE 0x1400be8e6		
  0x1400be68e		488b91a8000000		MOVQ 0xa8(CX), DX	
  0x1400be695		4c8b842408010000	MOVQ 0x108(SP), R8	
  0x1400be69d		4a8b4cc210		MOVQ 0x10(DX)(R8*8), CX	
  0x1400be6a2		4a8b5cc208		MOVQ 0x8(DX)(R8*8), BX	
  0x1400be6a7		48ffc3			INCQ BX			
  0x1400be6aa		4a8b04c2		MOVQ 0(DX)(R8*8), AX	
  0x1400be6ae		4839d9			CMPQ CX, BX		
  0x1400be6b1		7360			JAE 0x1400be713		
  0x1400be6b3		4889942440010000	MOVQ DX, 0x140(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be6bb		f20f11442440		MOVSD_XMM X0, 0x40(SP)	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x1400be6c1		bf01000000		MOVL $0x1, DI				
  0x1400be6c6		488d35ab7b1000		LEAQ type:*+129984(SB), SI		
  0x1400be6cd		e88eaffbff		CALL runtime.growslice(SB)		
  0x1400be6d2		488b942408010000	MOVQ 0x108(SP), DX			
  0x1400be6da		4c8b842440010000	MOVQ 0x140(SP), R8			
  0x1400be6e2		49894cd010		MOVQ CX, 0x10(R8)(DX*8)			
  0x1400be6e7		833dc259160000		CMPL runtime.writeBarrier(SB), $0x0	
  0x1400be6ee		7410			JE 0x1400be700				
  0x1400be6f0		498b0cd0		MOVQ 0(R8)(DX*8), CX			
  0x1400be6f4		e8e7f9fbff		CALL runtime.gcWriteBarrier2(SB)	
  0x1400be6f9		498903			MOVQ AX, 0(R11)				
  0x1400be6fc		49894b08		MOVQ CX, 0x8(R11)			
  0x1400be700		498904d0		MOVQ AX, 0(R8)(DX*8)			
  0x1400be704		f20f10442440		MOVSD_XMM 0x40(SP), X0			
  0x1400be70a		4889d1			MOVQ DX, CX				
  0x1400be70d		4c89c2			MOVQ R8, DX				
  0x1400be710		4989c8			MOVQ CX, R8				
  0x1400be713		4a895cc208		MOVQ BX, 0x8(DX)(R8*8)			
  0x1400be718		488d4bff		LEAQ -0x1(BX), CX			
  0x1400be71c		48c1e105		SHLQ $0x5, CX				
  0x1400be720		f20f109c2460010000	MOVSD_XMM 0x160(SP), X3			
  0x1400be729		f20f111c08		MOVSD_XMM X3, 0(AX)(CX*1)		
  0x1400be72e		f20f105c2450		MOVSD_XMM 0x50(SP), X3			
  0x1400be734		f20f115c0808		MOVSD_XMM X3, 0x8(AX)(CX*1)		
  0x1400be73a		f20f105c2448		MOVSD_XMM 0x48(SP), X3			
  0x1400be740		f20f115c0810		MOVSD_XMM X3, 0x10(AX)(CX*1)		
  0x1400be746		f20f11440818		MOVSD_XMM X0, 0x18(AX)(CX*1)		
	return sqrt(x)
  0x1400be74c		f20f10442468		MOVSD_XMM 0x68(SP), X0	
  0x1400be752		f20f51c8		SQRTSD X0, X1		
  0x1400be756		f20f10442460		MOVSD_XMM 0x60(SP), X0	
  0x1400be75c		f20f51d0		SQRTSD X0, X2		
  0x1400be760		f20f10842438010000	MOVSD_XMM 0x138(SP), X0	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x1400be769		eb73			JMP 0x1400be7de		
		cc = 1.0 - 2.0*sim.WorkerR01(workerID)
  0x1400be76b		488b842458010000	MOVQ 0x158(SP), AX				
  0x1400be773		488b9c2488010000	MOVQ 0x188(SP), BX				
  0x1400be77b		0f1f440000		NOPL 0(AX)(AX*1)				
  0x1400be780		e85b790000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400be785		f20f58c0		ADDSD X0, X0					
  0x1400be789		f20f100dc78a0100	MOVSD_XMM $f64.3ff0000000000000(SB), X1		
  0x1400be791		f20f5cc8		SUBSD X0, X1					
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400be795		0f57c0			XORPS X0, X0				
  0x1400be798		f20f1015f88b0100	MOVSD_XMM $f64.8000000000000000(SB), X2	
  0x1400be7a0		660fefc2		PXOR X2, X0				
  0x1400be7a4		0f10d9			MOVUPS X1, X3				
  0x1400be7a7		f20f59c9		MULSD X1, X1				
  0x1400be7ab		f20f1025a58a0100	MOVSD_XMM $f64.3ff0000000000000(SB), X4	
  0x1400be7b3		f20f5ce1		SUBSD X1, X4				
  0x1400be7b7		660fefe2		PXOR X2, X4				
  0x1400be7bb		0f10c8			MOVUPS X0, X1				
  0x1400be7be		f20f5dc4		MINSD X4, X0				
  0x1400be7c2		0f10e0			MOVUPS X0, X4				
  0x1400be7c5		f20f5dc1		MINSD X1, X0				
  0x1400be7c9		660febe0		POR X0, X4				
  0x1400be7cd		660fefe2		PXOR X2, X4				
	return sqrt(x)
  0x1400be7d1		f20f51d4		SQRTSD X4, X2		
	gx = g * (ct*cc - st*sc*ce)
  0x1400be7d5		f20f104c2458		MOVSD_XMM 0x58(SP), X1	
  0x1400be7db		0f10c3			MOVUPS X3, X0		
  0x1400be7de		f20f109c24e8000000	MOVSD_XMM 0xe8(SP), X3	
  0x1400be7e7		0f10e3			MOVUPS X3, X4		
  0x1400be7ea		f20f59d8		MULSD X0, X3		
  0x1400be7ee		f20f10ac24a8000000	MOVSD_XMM 0xa8(SP), X5	
  0x1400be7f7		0f10f5			MOVUPS X5, X6		
  0x1400be7fa		f20f59ea		MULSD X2, X5		
  0x1400be7fe		f20f10bc2400010000	MOVSD_XMM 0x100(SP), X7	
  0x1400be807		f20f59ef		MULSD X7, X5		
  0x1400be80b		f20f5cdd		SUBSD X5, X3		
  0x1400be80f		f20f59d9		MULSD X1, X3		
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400be813		f20f10ac24f0000000	MOVSD_XMM 0xf0(SP), X5	
  0x1400be81c		440f10c6		MOVUPS X6, X8		
  0x1400be820		f20f59f5		MULSD X5, X6		
  0x1400be824		f20f59f0		MULSD X0, X6		
  0x1400be828		440f10cc		MOVUPS X4, X9		
  0x1400be82c		f20f59e5		MULSD X5, X4		
  0x1400be830		f20f59e2		MULSD X2, X4		
  0x1400be834		c4e2d9b9f7		VFMADD231SD X7, X4, X6	
  0x1400be839		f20f10a424b0000000	MOVSD_XMM 0xb0(SP), X4	
  0x1400be842		440f10d4		MOVUPS X4, X10		
  0x1400be846		f20f59e2		MULSD X2, X4		
  0x1400be84a		f2440f109c24c0000000	MOVSD_XMM 0xc0(SP), X11	
  0x1400be854		f2410f59e3		MULSD X11, X4		
  0x1400be859		f20f5cf4		SUBSD X4, X6		
  0x1400be85d		f20f59f1		MULSD X1, X6		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x1400be861		f2450f59c2		MULSD X10, X8		
  0x1400be866		f2410f59c0		MULSD X8, X0		
  0x1400be86b		f2450f59ca		MULSD X10, X9		
  0x1400be870		f2440f59ca		MULSD X2, X9		
  0x1400be875		c4e2b1b9c7		VFMADD231SD X7, X9, X0	
  0x1400be87a		f20f59ea		MULSD X2, X5		
  0x1400be87e		c4c2d1b9c3		VFMADD231SD X11, X5, X0	
  0x1400be883		f20f59c1		MULSD X1, X0		
	*vxe = wx + F2*gx
  0x1400be887		f20f108c2490000000	MOVSD_XMM 0x90(SP), X1			
  0x1400be890		f20f1015b8890100	MOVSD_XMM $f64.3fefffe3339a0103(SB), X2	
  0x1400be898		c4e2e1b9ca		VFMADD231SD X2, X3, X1			
  0x1400be89d		488b842468010000	MOVQ 0x168(SP), AX			
  0x1400be8a5		f20f1108		MOVSD_XMM X1, 0(AX)			
	*vye = wy + F2*gy
  0x1400be8a9		f20f108c2488000000	MOVSD_XMM 0x88(SP), X1	
  0x1400be8b2		c4e2c9b9ca		VFMADD231SD X2, X6, X1	
  0x1400be8b7		488b842470010000	MOVQ 0x170(SP), AX	
  0x1400be8bf		f20f1108		MOVSD_XMM X1, 0(AX)	
	*vze = wz + F2*gz
  0x1400be8c3		f20f108c2480000000	MOVSD_XMM 0x80(SP), X1	
  0x1400be8cc		c4e2f9b9ca		VFMADD231SD X2, X0, X1	
  0x1400be8d1		488b842478010000	MOVQ 0x178(SP), AX	
  0x1400be8d9		f20f1108		MOVSD_XMM X1, 0(AX)	
}
  0x1400be8dd		4881c448010000		ADDQ $0x148, SP		
  0x1400be8e4		5d			POPQ BP			
  0x1400be8e5		c3			RET			
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x1400be8e6		e895fbfbff		CALL runtime.panicBounds(SB)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be8eb		e890fbfbff		CALL runtime.panicBounds(SB)	
  0x1400be8f0		e88bfbfbff		CALL runtime.panicBounds(SB)	
  0x1400be8f5		e886fbfbff		CALL runtime.panicBounds(SB)	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be8fa		e881fbfbff		CALL runtime.panicBounds(SB)	
	t0 := sim.Sigma[E_ELA][eindex]
  0x1400be8ff		b840420f00		MOVL $0xf4240, AX		
  0x1400be904		e877fbfbff		CALL runtime.panicBounds(SB)	
  0x1400be909		90			NOPL				
func (sim *SimulationState) CollisionElectron(xe float64, vxe, vye, vze *float64, eindex int, workerID int) {
  0x1400be90a		4889442408		MOVQ AX, 0x8(SP)					
  0x1400be90f		f20f11442410		MOVSD_XMM X0, 0x10(SP)					
  0x1400be915		48895c2418		MOVQ BX, 0x18(SP)					
  0x1400be91a		48894c2420		MOVQ CX, 0x20(SP)					
  0x1400be91f		48897c2428		MOVQ DI, 0x28(SP)					
  0x1400be924		4889742430		MOVQ SI, 0x30(SP)					
  0x1400be929		4c89442438		MOVQ R8, 0x38(SP)					
  0x1400be92e		e80dddfbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400be933		488b442408		MOVQ 0x8(SP), AX					
  0x1400be938		f20f10442410		MOVSD_XMM 0x10(SP), X0					
  0x1400be93e		488b5c2418		MOVQ 0x18(SP), BX					
  0x1400be943		488b4c2420		MOVQ 0x20(SP), CX					
  0x1400be948		488b7c2428		MOVQ 0x28(SP), DI					
  0x1400be94d		488b742430		MOVQ 0x30(SP), SI					
  0x1400be952		4c8b442438		MOVQ 0x38(SP), R8					
  0x1400be957		e9e4f4ffff		JMP gopic.(*SimulationState).CollisionElectron(SB)	

  0x1400be95c		cc			INT $0x3		
  0x1400be95d		cc			INT $0x3		
  0x1400be95e		cc			INT $0x3		
  0x1400be95f		cc			INT $0x3		


