TEXT gopic.(*SimulationState).CollisionElectron(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/collisions.go
func (sim *SimulationState) CollisionElectron(xe float64, vxe, vye, vze *float64, eindex int, workerID int) {
  0x1400bdac0		4c8da42430ffffff	LEAQ 0xffffff30(SP), R12	
  0x1400bdac8		4d3b6610		CMPQ R12, 0x10(R14)		
  0x1400bdacc		0f86b80a0000		JBE 0x1400be58a			
  0x1400bdad2		55			PUSHQ BP			
  0x1400bdad3		4889e5			MOVQ SP, BP			
  0x1400bdad6		4881ec48010000		SUBQ $0x148, SP			
	gx := *vxe
  0x1400bdadd		f20f100b		MOVSD_XMM 0(BX), X1	
	gy := *vye
  0x1400bdae1		f20f1011		MOVSD_XMM 0(CX), X2	
	gz := *vze
  0x1400bdae5		f20f101f		MOVSD_XMM 0(DI), X3	
	g_perp_sq := gy*gy + gz*gz
  0x1400bdae9		0f10e3			MOVUPS X3, X4		
  0x1400bdaec		f20f59db		MULSD X3, X3		
  0x1400bdaf0		c4e2e9b9da		VFMADD231SD X2, X2, X3	
	g_sq := gx*gx + g_perp_sq
  0x1400bdaf5		0f10eb			MOVUPS X3, X5		
  0x1400bdaf8		c4e2f1b9d9		VFMADD231SD X1, X1, X3	
	return sqrt(x)
  0x1400bdafd		f20f51f3		SQRTSD X3, X6		
	g := math.Sqrt(g_sq)
  0x1400bdb01		90			NOPL			
	g_perp := math.Sqrt(g_perp_sq)
  0x1400bdb02		90			NOPL			
	wx := F1 * (*vxe)
  0x1400bdb03		f20f103dbd860100	MOVSD_XMM $f64.3eeccc65fefd8fed(SB), X7	
  0x1400bdb0b		f20f59f9		MULSD X1, X7				
	wy := F1 * (*vye)
  0x1400bdb0f		f2440f1005b0860100	MOVSD_XMM $f64.3eeccc65fefd8fed(SB), X8	
  0x1400bdb18		f2440f59c2		MULSD X2, X8				
	wz := F1 * (*vze)
  0x1400bdb1d		f2440f100da2860100	MOVSD_XMM $f64.3eeccc65fefd8fed(SB), X9	
  0x1400bdb26		f2440f59cc		MULSD X4, X9				
	return sqrt(x)
  0x1400bdb2b		f20f51ed		SQRTSD X5, X5		
	if g > 0.0 {
  0x1400bdb2f		450f57d2		XORPS X10, X10		
  0x1400bdb33		66410f2ef2		UCOMISD X10, X6		
  0x1400bdb38		760e			JBE 0x1400bdb48		
		ct = gx / g
  0x1400bdb3a		f20f5ece		DIVSD X6, X1		
		st = g_perp / g
  0x1400bdb3e		440f10dd		MOVUPS X5, X11		
  0x1400bdb42		f20f5eee		DIVSD X6, X5		
  0x1400bdb46		eb0f			JMP 0x1400bdb57		
	if g_perp > 0.0 {
  0x1400bdb48		440f10dd		MOVUPS X5, X11				
  0x1400bdb4c		0f57ed			XORPS X5, X5				
  0x1400bdb4f		f20f100d09870100	MOVSD_XMM $f64.3ff0000000000000(SB), X1	
  0x1400bdb57		66450f2eda		UCOMISD X10, X11			
  0x1400bdb5c		760c			JBE 0x1400bdb6a				
		cp = gy / g_perp
  0x1400bdb5e		f2410f5ed3		DIVSD X11, X2		
		sp = gz / g_perp
  0x1400bdb63		f2410f5ee3		DIVSD X11, X4				
  0x1400bdb68		eb0b			JMP 0x1400bdb75				
  0x1400bdb6a		0f57e4			XORPS X4, X4				
  0x1400bdb6d		f20f1015eb860100	MOVSD_XMM $f64.3ff0000000000000(SB), X2	
	t0 := sim.Sigma[E_ELA][eindex]
  0x1400bdb75		8400			TESTB AL, 0(AX)		
  0x1400bdb77		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x1400bdb80		4881fe40420f00		CMPQ SI, $0xf4240	
  0x1400bdb87		0f83f2090000		JAE 0x1400be57f		
	if g > 0.0 {
  0x1400bdb8d		4889842458010000	MOVQ AX, 0x158(SP)	
  0x1400bdb95		f20f11842460010000	MOVSD_XMM X0, 0x160(SP)	
  0x1400bdb9e		48899c2468010000	MOVQ BX, 0x168(SP)	
  0x1400bdba6		48898c2470010000	MOVQ CX, 0x170(SP)	
  0x1400bdbae		4889bc2478010000	MOVQ DI, 0x178(SP)	
  0x1400bdbb6		4c89842488010000	MOVQ R8, 0x188(SP)	
	g_sq := gx*gx + g_perp_sq
  0x1400bdbbe		f20f119c24d8000000	MOVSD_XMM X3, 0xd8(SP)	
	return sqrt(x)
  0x1400bdbc7		f20f11742458		MOVSD_XMM X6, 0x58(SP)	
	wx := F1 * (*vxe)
  0x1400bdbcd		f20f11bc2490000000	MOVSD_XMM X7, 0x90(SP)	
	wy := F1 * (*vye)
  0x1400bdbd6		f2440f11842488000000	MOVSD_XMM X8, 0x88(SP)	
	wz := F1 * (*vze)
  0x1400bdbe0		f2440f118c2480000000	MOVSD_XMM X9, 0x80(SP)	
	t0 := sim.Sigma[E_ELA][eindex]
  0x1400bdbea		f20f11a424b0000000	MOVSD_XMM X4, 0xb0(SP)	
  0x1400bdbf3		f20f119424f0000000	MOVSD_XMM X2, 0xf0(SP)	
	if g_perp > 0.0 {
  0x1400bdbfc		f20f11ac24a8000000	MOVSD_XMM X5, 0xa8(SP)	
  0x1400bdc05		f20f118c24e8000000	MOVSD_XMM X1, 0xe8(SP)	
	t0 := sim.Sigma[E_ELA][eindex]
  0x1400bdc0e		f20f1084f0c0000000	MOVSD_XMM 0xc0(AX)(SI*8), X0	
  0x1400bdc17		f20f118424a0000000	MOVSD_XMM X0, 0xa0(SP)		
	t1 := t0 + sim.Sigma[E_EXC][eindex]
  0x1400bdc20		f20f108cf0c0127a00	MOVSD_XMM 0x7a12c0(AX)(SI*8), X1	
  0x1400bdc29		f20f58c8		ADDSD X0, X1				
  0x1400bdc2d		f20f118c2498000000	MOVSD_XMM X1, 0x98(SP)			
	t2 := t1 + sim.Sigma[E_ION][eindex]
  0x1400bdc36		f20f1084f0c024f400	MOVSD_XMM 0xf424c0(AX)(SI*8), X0	
  0x1400bdc3f		f20f11842438010000	MOVSD_XMM X0, 0x138(SP)			
	rnd := sim.WorkerR01(workerID)
  0x1400bdc48		4c89c3			MOVQ R8, BX					
  0x1400bdc4b		e850820000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400bdc50		f20f118424c8000000	MOVSD_XMM X0, 0xc8(SP)				
	eta := TWO_PI * sim.WorkerR01(workerID)
  0x1400bdc59		488b842458010000	MOVQ 0x158(SP), AX				
  0x1400bdc61		488b9c2488010000	MOVQ 0x188(SP), BX				
  0x1400bdc69		e832820000		CALL gopic.(*SimulationState).WorkerR01(SB)	
	t2 := t1 + sim.Sigma[E_ION][eindex]
  0x1400bdc6e		f20f108c2438010000	MOVSD_XMM 0x138(SP), X1	
  0x1400bdc77		f20f10942498000000	MOVSD_XMM 0x98(SP), X2	
  0x1400bdc80		f20f58ca		ADDSD X2, X1		
	r_t2 := rnd * t2
  0x1400bdc84		f20f109424c8000000	MOVSD_XMM 0xc8(SP), X2	
  0x1400bdc8d		f20f59ca		MULSD X2, X1		
  0x1400bdc91		f20f118c24d0000000	MOVSD_XMM X1, 0xd0(SP)	
	eta := TWO_PI * sim.WorkerR01(workerID)
  0x1400bdc9a		f20f100d36860100	MOVSD_XMM $f64.401921fb54442d18(SB), X1	
  0x1400bdca2		f20f59c1		MULSD X1, X0				
	se, ce := math.Sincos(eta)
  0x1400bdca6		e81561fcff		CALL math.Sincos(SB)	
  0x1400bdcab		f20f118c2400010000	MOVSD_XMM X1, 0x100(SP)	
  0x1400bdcb4		f20f118424c0000000	MOVSD_XMM X0, 0xc0(SP)	
	if r_t2 < t0 { // Zderzenie spr─Ö┼╝yste (izotropowe)
  0x1400bdcbd		f20f109424a0000000	MOVSD_XMM 0xa0(SP), X2	
  0x1400bdcc6		f20f109c24d0000000	MOVSD_XMM 0xd0(SP), X3	
  0x1400bdccf		660f2ed3		UCOMISD X3, X2		
  0x1400bdcd3		0f8712070000		JA 0x1400be3eb		
	} else if r_t2 < t1 { // Wzbudzenie (niespr─Ö┼╝yste, izotropowe)
  0x1400bdcd9		f20f10942498000000	MOVSD_XMM 0x98(SP), X2	
  0x1400bdce2		660f2ed3		UCOMISD X3, X2		
  0x1400bdce6		0f86d0000000		JBE 0x1400bddbc		
		energy := HALF_E_MASS * g_sq
  0x1400bdcec		f20f100544840100	MOVSD_XMM $f64.39a279dcc3e61461(SB), X0	
  0x1400bdcf4		f20f108c24d8000000	MOVSD_XMM 0xd8(SP), X1			
  0x1400bdcfd		f20f59c1		MULSD X1, X0				
		energy = math.Abs(energy - E_EXC_TH*EV_TO_J)
  0x1400bdd01		f20f100d77840100	MOVSD_XMM $f64.3c40fe7ccb02e6a7(SB), X1	
  0x1400bdd09		f20f5cc1		SUBSD X1, X0				
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400bdd0d		0f57c9			XORPS X1, X1				
  0x1400bdd10		f20f101580860100	MOVSD_XMM $f64.8000000000000000(SB), X2	
  0x1400bdd18		660fefca		PXOR X2, X1				
  0x1400bdd1c		f20f118c2438010000	MOVSD_XMM X1, 0x138(SP)			
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x1400bdd25		66480f7ec1		MOVQ X0, CX		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x1400bdd2a		480fbaf13f		BTRQ $0x3f, CX		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x1400bdd2f		66480f6ec1		MOVQ CX, X0		
		g = math.Sqrt(energy * TWO_OVER_E_MASS)
  0x1400bdd34		f20f100d54860100	MOVSD_XMM $f64.463bb62aabbfcc6d(SB), X1	
  0x1400bdd3c		f20f59c8		MULSD X0, X1				
  0x1400bdd40		f20f114c2478		MOVSD_XMM X1, 0x78(SP)			
		cc = 1.0 - 2.0*sim.WorkerR01(workerID)
  0x1400bdd46		488b842458010000	MOVQ 0x158(SP), AX				
  0x1400bdd4e		488b9c2488010000	MOVQ 0x188(SP), BX				
  0x1400bdd56		e845810000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400bdd5b		f20f58c0		ADDSD X0, X0					
  0x1400bdd5f		f20f100df9840100	MOVSD_XMM $f64.3ff0000000000000(SB), X1		
  0x1400bdd67		f20f5cc8		SUBSD X0, X1					
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400bdd6b		0f10c1			MOVUPS X1, X0				
  0x1400bdd6e		f20f59c9		MULSD X1, X1				
  0x1400bdd72		f20f1015e6840100	MOVSD_XMM $f64.3ff0000000000000(SB), X2	
  0x1400bdd7a		f20f5cd1		SUBSD X1, X2				
  0x1400bdd7e		f20f100d12860100	MOVSD_XMM $f64.8000000000000000(SB), X1	
  0x1400bdd86		660fefd1		PXOR X1, X2				
  0x1400bdd8a		f20f109c2438010000	MOVSD_XMM 0x138(SP), X3			
  0x1400bdd93		0f10e3			MOVUPS X3, X4				
  0x1400bdd96		f20f5dda		MINSD X2, X3				
  0x1400bdd9a		0f10d3			MOVUPS X3, X2				
  0x1400bdd9d		f20f5ddc		MINSD X4, X3				
  0x1400bdda1		660febd3		POR X3, X2				
  0x1400bdda5		660fefd1		PXOR X1, X2				
	return sqrt(x)
  0x1400bdda9		f20f104c2478		MOVSD_XMM 0x78(SP), X1	
  0x1400bddaf		f20f51c9		SQRTSD X1, X1		
  0x1400bddb3		f20f51d2		SQRTSD X2, X2		
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400bddb7		e9a2060000		JMP 0x1400be45e		
		energy := HALF_E_MASS * g_sq
  0x1400bddbc		f20f101574830100	MOVSD_XMM $f64.39a279dcc3e61461(SB), X2	
  0x1400bddc4		f20f109c24d8000000	MOVSD_XMM 0xd8(SP), X3			
  0x1400bddcd		f20f59d3		MULSD X3, X2				
		energy = math.Abs(energy - E_ION_TH*EV_TO_J)
  0x1400bddd1		f20f101daf830100	MOVSD_XMM $f64.3c475931051c7900(SB), X3	
  0x1400bddd9		f20f5cd3		SUBSD X3, X2				
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400bdddd		0f57db			XORPS X3, X3				
  0x1400bdde0		f20f1025b0850100	MOVSD_XMM $f64.8000000000000000(SB), X4	
  0x1400bdde8		660fefdc		PXOR X4, X3				
  0x1400bddec		f20f119c2438010000	MOVSD_XMM X3, 0x138(SP)			
		se2 := -se
  0x1400bddf5		660fefe0		PXOR X0, X4		
  0x1400bddf9		f20f11a424b8000000	MOVSD_XMM X4, 0xb8(SP)	
		ce2 := -ce
  0x1400bde02		f20f10058e850100	MOVSD_XMM $f64.8000000000000000(SB), X0	
  0x1400bde0a		660fefc1		PXOR X1, X0				
  0x1400bde0e		f20f118424f8000000	MOVSD_XMM X0, 0xf8(SP)			
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
  0x1400bde17		f20f108424a8000000	MOVSD_XMM 0xa8(SP), X0	
  0x1400bde20		f20f108c24f0000000	MOVSD_XMM 0xf0(SP), X1	
  0x1400bde29		0f10d8			MOVUPS X0, X3		
  0x1400bde2c		f20f59c1		MULSD X1, X0		
  0x1400bde30		f20f11842430010000	MOVSD_XMM X0, 0x130(SP)	
  0x1400bde39		f20f108424e8000000	MOVSD_XMM 0xe8(SP), X0	
  0x1400bde42		0f10e0			MOVUPS X0, X4		
  0x1400bde45		f20f59c1		MULSD X1, X0		
  0x1400bde49		f20f11842428010000	MOVSD_XMM X0, 0x128(SP)	
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)
  0x1400bde52		f20f108424b0000000	MOVSD_XMM 0xb0(SP), X0	
  0x1400bde5b		f20f59d8		MULSD X0, X3		
  0x1400bde5f		f20f119c2420010000	MOVSD_XMM X3, 0x120(SP)	
  0x1400bde68		f20f59e0		MULSD X0, X4		
  0x1400bde6c		f20f11a42418010000	MOVSD_XMM X4, 0x118(SP)	
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x1400bde75		66480f7ed1		MOVQ X2, CX		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x1400bde7a		480fbaf13f		BTRQ $0x3f, CX		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x1400bde7f		66480f6ec1		MOVQ CX, X0		
  0x1400bde84		f20f118424e0000000	MOVSD_XMM X0, 0xe0(SP)	
		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
  0x1400bde8d		f20f100de3840100	MOVSD_XMM $f64.439152dbe5934720(SB), X1		
  0x1400bde95		f20f59c8		MULSD X0, X1					
  0x1400bde99		f20f114c2470		MOVSD_XMM X1, 0x70(SP)				
  0x1400bde9f		488b842458010000	MOVQ 0x158(SP), AX				
  0x1400bdea7		488b9c2488010000	MOVQ 0x188(SP), BX				
  0x1400bdeaf		e8ec7f0000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400bdeb4		f20f11842410010000	MOVSD_XMM X0, 0x110(SP)				
	return atan(x)
  0x1400bdebd		f20f10442470		MOVSD_XMM 0x70(SP), X0	
  0x1400bdec3		e83855fcff		CALL math.atan(SB)	
		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
  0x1400bdec8		f20f108c2410010000	MOVSD_XMM 0x110(SP), X1	
  0x1400bded1		f20f59c1		MULSD X1, X0		
	return tan(x)
  0x1400bded5		e8a661fcff		CALL math.tan(SB)	
		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
  0x1400bdeda		f20f100d36820100	MOVSD_XMM runtime.egcbss+58(SB), X1	
  0x1400bdee2		f20f59c8		MULSD X0, X1				
  0x1400bdee6		f20f100572820100	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X0	
  0x1400bdeee		f20f59c1		MULSD X1, X0				
		e_sc := math.Abs(energy - e_ej)
  0x1400bdef2		f20f108c24e0000000	MOVSD_XMM 0xe0(SP), X1	
  0x1400bdefb		0f10d1			MOVUPS X1, X2		
  0x1400bdefe		f20f5cc8		SUBSD X0, X1		
		g2 := math.Sqrt(e_ej * TWO_OVER_E_MASS)
  0x1400bdf02		f20f101d86840100	MOVSD_XMM $f64.463bb62aabbfcc6d(SB), X3	
  0x1400bdf0a		f20f59d8		MULSD X0, X3				
		cc2 := math.Sqrt(e_ej / energy)
  0x1400bdf0e		f20f5ec2		DIVSD X2, X0		
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400bdf12		488b8c2458010000	MOVQ 0x158(SP), CX	
  0x1400bdf1a		488b9198000000		MOVQ 0x98(CX), DX	
	return sqrt(x)
  0x1400bdf21		f20f51db		SQRTSD X3, X3		
  0x1400bdf25		f20f51c0		SQRTSD X0, X0		
		sc2 := math.Sqrt(max(0.0, 1.0-cc2*cc2))
  0x1400bdf29		0f10e0			MOVUPS X0, X4				
  0x1400bdf2c		f20f59c0		MULSD X0, X0				
  0x1400bdf30		f20f102d28830100	MOVSD_XMM $f64.3ff0000000000000(SB), X5	
  0x1400bdf38		f20f5ce8		SUBSD X0, X5				
  0x1400bdf3c		f20f100554840100	MOVSD_XMM $f64.8000000000000000(SB), X0	
  0x1400bdf44		660fefe8		PXOR X0, X5				
  0x1400bdf48		f20f10b42438010000	MOVSD_XMM 0x138(SP), X6			
  0x1400bdf51		0f10fe			MOVUPS X6, X7				
  0x1400bdf54		f20f5df5		MINSD X5, X6				
  0x1400bdf58		0f10ee			MOVUPS X6, X5				
  0x1400bdf5b		f20f5df7		MINSD X7, X6				
  0x1400bdf5f		660febee		POR X6, X5				
  0x1400bdf63		660fefe8		PXOR X0, X5				
		gx2 := g2 * (ct*cc2 - st*sc2*ce2)
  0x1400bdf67		f20f10b424e8000000	MOVSD_XMM 0xe8(SP), X6	
  0x1400bdf70		440f10c4		MOVUPS X4, X8		
  0x1400bdf74		f20f59e6		MULSD X6, X4		
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
  0x1400bdf78		f2440f108c2430010000	MOVSD_XMM 0x130(SP), X9	
  0x1400bdf82		f2450f59c8		MULSD X8, X9		
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)
  0x1400bdf87		f2440f10942420010000	MOVSD_XMM 0x120(SP), X10	
  0x1400bdf91		f2450f59c2		MULSD X10, X8			
	return sqrt(x)
  0x1400bdf96		f20f51ed		SQRTSD X5, X5		
		gx2 := g2 * (ct*cc2 - st*sc2*ce2)
  0x1400bdf9a		f2440f109424a8000000	MOVSD_XMM 0xa8(SP), X10	
  0x1400bdfa4		450f10da		MOVUPS X10, X11		
  0x1400bdfa8		f2440f59d5		MULSD X5, X10		
  0x1400bdfad		f2440f10a424f8000000	MOVSD_XMM 0xf8(SP), X12	
  0x1400bdfb7		f2450f59d4		MULSD X12, X10		
  0x1400bdfbc		f2410f5ce2		SUBSD X10, X4		
  0x1400bdfc1		f20f59e3		MULSD X3, X4		
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
  0x1400bdfc5		f2440f10942428010000	MOVSD_XMM 0x128(SP), X10	
  0x1400bdfcf		f2440f59d5		MULSD X5, X10			
  0x1400bdfd4		c442a9b9cc		VFMADD231SD X12, X10, X9	
  0x1400bdfd9		f2440f109424b0000000	MOVSD_XMM 0xb0(SP), X10		
  0x1400bdfe3		450f10ea		MOVUPS X10, X13			
  0x1400bdfe7		f2440f59d5		MULSD X5, X10			
  0x1400bdfec		f2440f10b424b8000000	MOVSD_XMM 0xb8(SP), X14		
  0x1400bdff6		f2450f59d6		MULSD X14, X10			
  0x1400bdffb		f2450f5cca		SUBSD X10, X9			
  0x1400be000		f2440f59cb		MULSD X3, X9			
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)
  0x1400be005		f2440f10942418010000	MOVSD_XMM 0x118(SP), X10	
  0x1400be00f		f2440f59d5		MULSD X5, X10			
  0x1400be014		c442a9b9c4		VFMADD231SD X12, X10, X8	
  0x1400be019		f2440f109424f0000000	MOVSD_XMM 0xf0(SP), X10		
  0x1400be023		f2410f59ea		MULSD X10, X5			
  0x1400be028		c442d1b9c6		VFMADD231SD X14, X5, X8		
  0x1400be02d		f2410f59d8		MULSD X8, X3			
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x1400be032		66480f7ece		MOVQ X1, SI		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x1400be037		480fbaf63f		BTRQ $0x3f, SI		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x1400be03c		66480f6ece		MOVQ SI, X1		
		cc = math.Sqrt(e_sc / energy)
  0x1400be041		0f10e9			MOVUPS X1, X5		
  0x1400be044		f20f5eca		DIVSD X2, X1		
	return sqrt(x)
  0x1400be048		f20f51c9		SQRTSD X1, X1		
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400be04c		0f10d1			MOVUPS X1, X2				
  0x1400be04f		f20f59c9		MULSD X1, X1				
  0x1400be053		f2440f100504820100	MOVSD_XMM $f64.3ff0000000000000(SB), X8	
  0x1400be05c		f2440f5cc1		SUBSD X1, X8				
  0x1400be061		66440fefc0		PXOR X0, X8				
  0x1400be066		0f10cf			MOVUPS X7, X1				
  0x1400be069		f2410f5df8		MINSD X8, X7				
  0x1400be06e		440f10c7		MOVUPS X7, X8				
  0x1400be072		f20f5df9		MINSD X1, X7				
  0x1400be076		66440febc7		POR X7, X8				
		g = math.Sqrt(e_sc * TWO_OVER_E_MASS)
  0x1400be07b		f20f100d0d830100	MOVSD_XMM $f64.463bb62aabbfcc6d(SB), X1	
  0x1400be083		f20f59e9		MULSD X1, X5				
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400be087		66440fefc0		PXOR X0, X8		
			Vx: wx + F2*gx2,
  0x1400be08c		f20f10842490000000	MOVSD_XMM 0x90(SP), X0			
  0x1400be095		f20f100dbb810100	MOVSD_XMM $f64.3fefffe3339a0103(SB), X1	
  0x1400be09d		0f10f8			MOVUPS X0, X7				
  0x1400be0a0		c4e2f1b9c4		VFMADD231SD X4, X1, X0			
			Vy: wy + F2*gy2,
  0x1400be0a5		f20f10a42488000000	MOVSD_XMM 0x88(SP), X4	
  0x1400be0ae		440f10e4		MOVUPS X4, X12		
  0x1400be0b2		c4c2f1b9e1		VFMADD231SD X9, X1, X4	
			Vz: wz + F2*gz2,
  0x1400be0b7		f2440f108c2480000000	MOVSD_XMM 0x80(SP), X9	
  0x1400be0c1		450f10f1		MOVUPS X9, X14		
  0x1400be0c5		c462f1b9cb		VFMADD231SD X3, X1, X9	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be0ca		488bb42488010000	MOVQ 0x188(SP), SI	
  0x1400be0d2		4839d6			CMPQ SI, DX		
  0x1400be0d5		0f839f040000		JAE 0x1400be57a		
		g = math.Sqrt(e_sc * TWO_OVER_E_MASS)
  0x1400be0db		f20f116c2468		MOVSD_XMM X5, 0x68(SP)	
	return sqrt(x)
  0x1400be0e1		f20f11942438010000	MOVSD_XMM X2, 0x138(SP)	
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400be0ea		f2440f11442460		MOVSD_XMM X8, 0x60(SP)	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be0f1		488b9190000000		MOVQ 0x90(CX), DX	
  0x1400be0f8		4c8d0476		LEAQ 0(SI)(SI*2), R8	
  0x1400be0fc		4c89842408010000	MOVQ R8, 0x108(SP)	
  0x1400be104		4e8b4cc210		MOVQ 0x10(DX)(R8*8), R9	
  0x1400be109		4a8b5cc208		MOVQ 0x8(DX)(R8*8), BX	
  0x1400be10e		48ffc3			INCQ BX			
  0x1400be111		4a8b04c2		MOVQ 0(DX)(R8*8), AX	
  0x1400be115		4939d9			CMPQ R9, BX		
  0x1400be118		0f83fb000000		JAE 0x1400be219		
  0x1400be11e		4889942440010000	MOVQ DX, 0x140(SP)	
			Vx: wx + F2*gx2,
  0x1400be126		f20f11842430010000	MOVSD_XMM X0, 0x130(SP)	
			Vy: wy + F2*gy2,
  0x1400be12f		f20f11a42428010000	MOVSD_XMM X4, 0x128(SP)	
			Vz: wz + F2*gz2,
  0x1400be138		f2440f118c2420010000	MOVSD_XMM X9, 0x120(SP)	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be142		4c89c9			MOVQ R9, CX				
  0x1400be145		bf01000000		MOVL $0x1, DI				
  0x1400be14a		488d355f5d1000		LEAQ type:*+128536(SB), SI		
  0x1400be151		e82ab5fbff		CALL runtime.growslice(SB)		
  0x1400be156		488b942408010000	MOVQ 0x108(SP), DX			
  0x1400be15e		4c8b842440010000	MOVQ 0x140(SP), R8			
  0x1400be166		49894cd010		MOVQ CX, 0x10(R8)(DX*8)			
  0x1400be16b		833d3e3f160000		CMPL runtime.writeBarrier(SB), $0x0	
  0x1400be172		7410			JE 0x1400be184				
  0x1400be174		498b0cd0		MOVQ 0(R8)(DX*8), CX			
  0x1400be178		e863fffbff		CALL runtime.gcWriteBarrier2(SB)	
  0x1400be17d		498903			MOVQ AX, 0(R11)				
  0x1400be180		49894b08		MOVQ CX, 0x8(R11)			
  0x1400be184		498904d0		MOVQ AX, 0(R8)(DX*8)			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be188		488b8c2458010000	MOVQ 0x158(SP), CX	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be190		4c89c2			MOVQ R8, DX		
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be193		488bb42488010000	MOVQ 0x188(SP), SI	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be19b		4c8b842408010000	MOVQ 0x108(SP), R8	
  0x1400be1a3		f20f10842430010000	MOVSD_XMM 0x130(SP), X0	
  0x1400be1ac		f20f10942438010000	MOVSD_XMM 0x138(SP), X2	
  0x1400be1b5		f20f10a42428010000	MOVSD_XMM 0x128(SP), X4	
	return sqrt(x)
  0x1400be1be		f20f106c2468		MOVSD_XMM 0x68(SP), X5	
	gx = g * (ct*cc - st*sc*ce)
  0x1400be1c4		f20f10b424e8000000	MOVSD_XMM 0xe8(SP), X6	
	*vxe = wx + F2*gx
  0x1400be1cd		f20f10bc2490000000	MOVSD_XMM 0x90(SP), X7	
	return sqrt(x)
  0x1400be1d6		f2440f10442460		MOVSD_XMM 0x60(SP), X8	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be1dd		f2440f108c2420010000	MOVSD_XMM 0x120(SP), X9	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400be1e7		f2440f109424f0000000	MOVSD_XMM 0xf0(SP), X10	
	gx = g * (ct*cc - st*sc*ce)
  0x1400be1f1		f2440f109c24a8000000	MOVSD_XMM 0xa8(SP), X11	
	*vye = wy + F2*gy
  0x1400be1fb		f2440f10a42488000000	MOVSD_XMM 0x88(SP), X12	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400be205		f2440f10ac24b0000000	MOVSD_XMM 0xb0(SP), X13	
	*vze = wz + F2*gz
  0x1400be20f		f2440f10b42480000000	MOVSD_XMM 0x80(SP), X14	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be219		4a895cc208		MOVQ BX, 0x8(DX)(R8*8)		
  0x1400be21e		488d53ff		LEAQ -0x1(BX), DX		
  0x1400be222		48c1e205		SHLQ $0x5, DX			
  0x1400be226		f20f108c2460010000	MOVSD_XMM 0x160(SP), X1		
  0x1400be22f		f20f110c10		MOVSD_XMM X1, 0(AX)(DX*1)	
  0x1400be234		f20f11441008		MOVSD_XMM X0, 0x8(AX)(DX*1)	
  0x1400be23a		f20f11641010		MOVSD_XMM X4, 0x10(AX)(DX*1)	
  0x1400be240		f2440f114c1018		MOVSD_XMM X9, 0x18(AX)(DX*1)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be247		488b91f02dba07		MOVQ 0x7ba2df0(CX), DX	
			Vx: sim.WorkerRMB(workerID),
  0x1400be24e		90			NOPL			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be24f		4839d6			CMPQ SI, DX				
  0x1400be252		0f831d030000		JAE 0x1400be575				
  0x1400be258		488b89e82dba07		MOVQ 0x7ba2de8(CX), CX			
  0x1400be25f		488b04f1		MOVQ 0(CX)(SI*8), AX			
  0x1400be263		e8d8ebffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x1400be268		488b8c2458010000	MOVQ 0x158(SP), CX			
  0x1400be270		488b91f02dba07		MOVQ 0x7ba2df0(CX), DX			
			Vy: sim.WorkerRMB(workerID),
  0x1400be277		90			NOPL			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be278		f20f5905f03b1600	MULSD gopic.RMB_sigma(SB), X0		
  0x1400be280		488b9c2488010000	MOVQ 0x188(SP), BX			
  0x1400be288		4839d3			CMPQ BX, DX				
  0x1400be28b		0f83df020000		JAE 0x1400be570				
  0x1400be291		f20f11442450		MOVSD_XMM X0, 0x50(SP)			
  0x1400be297		488b89e82dba07		MOVQ 0x7ba2de8(CX), CX			
  0x1400be29e		488b04d9		MOVQ 0(CX)(BX*8), AX			
  0x1400be2a2		e899ebffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x1400be2a7		488b8c2458010000	MOVQ 0x158(SP), CX			
  0x1400be2af		488b91f02dba07		MOVQ 0x7ba2df0(CX), DX			
			Vz: sim.WorkerRMB(workerID),
  0x1400be2b6		90			NOPL			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be2b7		f20f5905b13b1600	MULSD gopic.RMB_sigma(SB), X0		
  0x1400be2bf		488b9c2488010000	MOVQ 0x188(SP), BX			
  0x1400be2c7		4839d3			CMPQ BX, DX				
  0x1400be2ca		0f839b020000		JAE 0x1400be56b				
  0x1400be2d0		f20f11442448		MOVSD_XMM X0, 0x48(SP)			
  0x1400be2d6		488b89e82dba07		MOVQ 0x7ba2de8(CX), CX			
  0x1400be2dd		488b04d9		MOVQ 0(CX)(BX*8), AX			
  0x1400be2e1		e85aebffff		CALL math/rand.(*Rand).NormFloat64(SB)	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x1400be2e6		488b8c2458010000	MOVQ 0x158(SP), CX	
  0x1400be2ee		488b91b0000000		MOVQ 0xb0(CX), DX	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be2f5		f20f5905733b1600	MULSD gopic.RMB_sigma(SB), X0	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x1400be2fd		488b9c2488010000	MOVQ 0x188(SP), BX	
  0x1400be305		4839d3			CMPQ BX, DX		
  0x1400be308		0f8358020000		JAE 0x1400be566		
  0x1400be30e		488b91a8000000		MOVQ 0xa8(CX), DX	
  0x1400be315		4c8b842408010000	MOVQ 0x108(SP), R8	
  0x1400be31d		4a8b4cc210		MOVQ 0x10(DX)(R8*8), CX	
  0x1400be322		4a8b5cc208		MOVQ 0x8(DX)(R8*8), BX	
  0x1400be327		48ffc3			INCQ BX			
  0x1400be32a		4a8b04c2		MOVQ 0(DX)(R8*8), AX	
  0x1400be32e		4839d9			CMPQ CX, BX		
  0x1400be331		7360			JAE 0x1400be393		
  0x1400be333		4889942440010000	MOVQ DX, 0x140(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be33b		f20f11442440		MOVSD_XMM X0, 0x40(SP)	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x1400be341		bf01000000		MOVL $0x1, DI				
  0x1400be346		488d35635b1000		LEAQ type:*+128536(SB), SI		
  0x1400be34d		e82eb3fbff		CALL runtime.growslice(SB)		
  0x1400be352		488b942408010000	MOVQ 0x108(SP), DX			
  0x1400be35a		4c8b842440010000	MOVQ 0x140(SP), R8			
  0x1400be362		49894cd010		MOVQ CX, 0x10(R8)(DX*8)			
  0x1400be367		833d423d160000		CMPL runtime.writeBarrier(SB), $0x0	
  0x1400be36e		7410			JE 0x1400be380				
  0x1400be370		498b0cd0		MOVQ 0(R8)(DX*8), CX			
  0x1400be374		e867fdfbff		CALL runtime.gcWriteBarrier2(SB)	
  0x1400be379		498903			MOVQ AX, 0(R11)				
  0x1400be37c		49894b08		MOVQ CX, 0x8(R11)			
  0x1400be380		498904d0		MOVQ AX, 0(R8)(DX*8)			
  0x1400be384		f20f10442440		MOVSD_XMM 0x40(SP), X0			
  0x1400be38a		4889d1			MOVQ DX, CX				
  0x1400be38d		4c89c2			MOVQ R8, DX				
  0x1400be390		4989c8			MOVQ CX, R8				
  0x1400be393		4a895cc208		MOVQ BX, 0x8(DX)(R8*8)			
  0x1400be398		488d4bff		LEAQ -0x1(BX), CX			
  0x1400be39c		48c1e105		SHLQ $0x5, CX				
  0x1400be3a0		f20f109c2460010000	MOVSD_XMM 0x160(SP), X3			
  0x1400be3a9		f20f111c08		MOVSD_XMM X3, 0(AX)(CX*1)		
  0x1400be3ae		f20f105c2450		MOVSD_XMM 0x50(SP), X3			
  0x1400be3b4		f20f115c0808		MOVSD_XMM X3, 0x8(AX)(CX*1)		
  0x1400be3ba		f20f105c2448		MOVSD_XMM 0x48(SP), X3			
  0x1400be3c0		f20f115c0810		MOVSD_XMM X3, 0x10(AX)(CX*1)		
  0x1400be3c6		f20f11440818		MOVSD_XMM X0, 0x18(AX)(CX*1)		
	return sqrt(x)
  0x1400be3cc		f20f10442468		MOVSD_XMM 0x68(SP), X0	
  0x1400be3d2		f20f51c8		SQRTSD X0, X1		
  0x1400be3d6		f20f10442460		MOVSD_XMM 0x60(SP), X0	
  0x1400be3dc		f20f51d0		SQRTSD X0, X2		
  0x1400be3e0		f20f10842438010000	MOVSD_XMM 0x138(SP), X0	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x1400be3e9		eb73			JMP 0x1400be45e		
		cc = 1.0 - 2.0*sim.WorkerR01(workerID)
  0x1400be3eb		488b842458010000	MOVQ 0x158(SP), AX				
  0x1400be3f3		488b9c2488010000	MOVQ 0x188(SP), BX				
  0x1400be3fb		0f1f440000		NOPL 0(AX)(AX*1)				
  0x1400be400		e89b7a0000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400be405		f20f58c0		ADDSD X0, X0					
  0x1400be409		f20f100d4f7e0100	MOVSD_XMM $f64.3ff0000000000000(SB), X1		
  0x1400be411		f20f5cc8		SUBSD X0, X1					
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x1400be415		0f57c0			XORPS X0, X0				
  0x1400be418		f20f1015787f0100	MOVSD_XMM $f64.8000000000000000(SB), X2	
  0x1400be420		660fefc2		PXOR X2, X0				
  0x1400be424		0f10d9			MOVUPS X1, X3				
  0x1400be427		f20f59c9		MULSD X1, X1				
  0x1400be42b		f20f10252d7e0100	MOVSD_XMM $f64.3ff0000000000000(SB), X4	
  0x1400be433		f20f5ce1		SUBSD X1, X4				
  0x1400be437		660fefe2		PXOR X2, X4				
  0x1400be43b		0f10c8			MOVUPS X0, X1				
  0x1400be43e		f20f5dc4		MINSD X4, X0				
  0x1400be442		0f10e0			MOVUPS X0, X4				
  0x1400be445		f20f5dc1		MINSD X1, X0				
  0x1400be449		660febe0		POR X0, X4				
  0x1400be44d		660fefe2		PXOR X2, X4				
	return sqrt(x)
  0x1400be451		f20f51d4		SQRTSD X4, X2		
	gx = g * (ct*cc - st*sc*ce)
  0x1400be455		f20f104c2458		MOVSD_XMM 0x58(SP), X1	
  0x1400be45b		0f10c3			MOVUPS X3, X0		
  0x1400be45e		f20f109c24e8000000	MOVSD_XMM 0xe8(SP), X3	
  0x1400be467		0f10e3			MOVUPS X3, X4		
  0x1400be46a		f20f59d8		MULSD X0, X3		
  0x1400be46e		f20f10ac24a8000000	MOVSD_XMM 0xa8(SP), X5	
  0x1400be477		0f10f5			MOVUPS X5, X6		
  0x1400be47a		f20f59ea		MULSD X2, X5		
  0x1400be47e		f20f10bc2400010000	MOVSD_XMM 0x100(SP), X7	
  0x1400be487		f20f59ef		MULSD X7, X5		
  0x1400be48b		f20f5cdd		SUBSD X5, X3		
  0x1400be48f		f20f59d9		MULSD X1, X3		
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x1400be493		f20f10ac24f0000000	MOVSD_XMM 0xf0(SP), X5	
  0x1400be49c		440f10c6		MOVUPS X6, X8		
  0x1400be4a0		f20f59f5		MULSD X5, X6		
  0x1400be4a4		f20f59f0		MULSD X0, X6		
  0x1400be4a8		440f10cc		MOVUPS X4, X9		
  0x1400be4ac		f20f59e5		MULSD X5, X4		
  0x1400be4b0		f20f59e2		MULSD X2, X4		
  0x1400be4b4		c4e2d9b9f7		VFMADD231SD X7, X4, X6	
  0x1400be4b9		f20f10a424b0000000	MOVSD_XMM 0xb0(SP), X4	
  0x1400be4c2		440f10d4		MOVUPS X4, X10		
  0x1400be4c6		f20f59e2		MULSD X2, X4		
  0x1400be4ca		f2440f109c24c0000000	MOVSD_XMM 0xc0(SP), X11	
  0x1400be4d4		f2410f59e3		MULSD X11, X4		
  0x1400be4d9		f20f5cf4		SUBSD X4, X6		
  0x1400be4dd		f20f59f1		MULSD X1, X6		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x1400be4e1		f2450f59c2		MULSD X10, X8		
  0x1400be4e6		f2410f59c0		MULSD X8, X0		
  0x1400be4eb		f2450f59ca		MULSD X10, X9		
  0x1400be4f0		f2440f59ca		MULSD X2, X9		
  0x1400be4f5		c4e2b1b9c7		VFMADD231SD X7, X9, X0	
  0x1400be4fa		f20f59ea		MULSD X2, X5		
  0x1400be4fe		c4c2d1b9c3		VFMADD231SD X11, X5, X0	
  0x1400be503		f20f59c1		MULSD X1, X0		
	*vxe = wx + F2*gx
  0x1400be507		f20f108c2490000000	MOVSD_XMM 0x90(SP), X1			
  0x1400be510		f20f1015407d0100	MOVSD_XMM $f64.3fefffe3339a0103(SB), X2	
  0x1400be518		c4e2e1b9ca		VFMADD231SD X2, X3, X1			
  0x1400be51d		488b842468010000	MOVQ 0x168(SP), AX			
  0x1400be525		f20f1108		MOVSD_XMM X1, 0(AX)			
	*vye = wy + F2*gy
  0x1400be529		f20f108c2488000000	MOVSD_XMM 0x88(SP), X1	
  0x1400be532		c4e2c9b9ca		VFMADD231SD X2, X6, X1	
  0x1400be537		488b842470010000	MOVQ 0x170(SP), AX	
  0x1400be53f		f20f1108		MOVSD_XMM X1, 0(AX)	
	*vze = wz + F2*gz
  0x1400be543		f20f108c2480000000	MOVSD_XMM 0x80(SP), X1	
  0x1400be54c		c4e2f9b9ca		VFMADD231SD X2, X0, X1	
  0x1400be551		488b842478010000	MOVQ 0x178(SP), AX	
  0x1400be559		f20f1108		MOVSD_XMM X1, 0(AX)	
}
  0x1400be55d		4881c448010000		ADDQ $0x148, SP		
  0x1400be564		5d			POPQ BP			
  0x1400be565		c3			RET			
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x1400be566		e815fffbff		CALL runtime.panicBounds(SB)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400be56b		e810fffbff		CALL runtime.panicBounds(SB)	
  0x1400be570		e80bfffbff		CALL runtime.panicBounds(SB)	
  0x1400be575		e806fffbff		CALL runtime.panicBounds(SB)	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x1400be57a		e801fffbff		CALL runtime.panicBounds(SB)	
	t0 := sim.Sigma[E_ELA][eindex]
  0x1400be57f		b840420f00		MOVL $0xf4240, AX		
  0x1400be584		e8f7fefbff		CALL runtime.panicBounds(SB)	
  0x1400be589		90			NOPL				
func (sim *SimulationState) CollisionElectron(xe float64, vxe, vye, vze *float64, eindex int, workerID int) {
  0x1400be58a		4889442408		MOVQ AX, 0x8(SP)					
  0x1400be58f		f20f11442410		MOVSD_XMM X0, 0x10(SP)					
  0x1400be595		48895c2418		MOVQ BX, 0x18(SP)					
  0x1400be59a		48894c2420		MOVQ CX, 0x20(SP)					
  0x1400be59f		48897c2428		MOVQ DI, 0x28(SP)					
  0x1400be5a4		4889742430		MOVQ SI, 0x30(SP)					
  0x1400be5a9		4c89442438		MOVQ R8, 0x38(SP)					
  0x1400be5ae		e88de0fbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400be5b3		488b442408		MOVQ 0x8(SP), AX					
  0x1400be5b8		f20f10442410		MOVSD_XMM 0x10(SP), X0					
  0x1400be5be		488b5c2418		MOVQ 0x18(SP), BX					
  0x1400be5c3		488b4c2420		MOVQ 0x20(SP), CX					
  0x1400be5c8		488b7c2428		MOVQ 0x28(SP), DI					
  0x1400be5cd		488b742430		MOVQ 0x30(SP), SI					
  0x1400be5d2		4c8b442438		MOVQ 0x38(SP), R8					
  0x1400be5d7		e9e4f4ffff		JMP gopic.(*SimulationState).CollisionElectron(SB)	

  0x1400be5dc		cc			INT $0x3		
  0x1400be5dd		cc			INT $0x3		
  0x1400be5de		cc			INT $0x3		
  0x1400be5df		cc			INT $0x3		
