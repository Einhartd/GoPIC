TEXT gopic.(*SimulationState).CollisionElectron(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/collisions.go
func (sim *SimulationState) CollisionElectron(xe float64, vxe, vye, vze *float64, eindex int, workerID int) {
  0x4b914		4c8da42430ffffff	LEAQ 0xffffff30(SP), R12	
  0x4b91c		4d3b6610		CMPQ R12, 0x10(R14)		
  0x4b920		0f86b80a0000		JBE 0x4c3de			
  0x4b926		55			PUSHQ BP			
  0x4b927		4889e5			MOVQ SP, BP			
  0x4b92a		4881ec48010000		SUBQ $0x148, SP			
	gx := *vxe
  0x4b931		f20f100b		MOVSD_XMM 0(BX), X1	
	gy := *vye
  0x4b935		f20f1011		MOVSD_XMM 0(CX), X2	
	gz := *vze
  0x4b939		f20f101f		MOVSD_XMM 0(DI), X3	
	g_perp_sq := gy*gy + gz*gz
  0x4b93d		0f10e3			MOVUPS X3, X4		
  0x4b940		f20f59db		MULSD X3, X3		
  0x4b944		c4e2e9b9da		VFMADD231SD X2, X2, X3	
	g_sq := gx*gx + g_perp_sq
  0x4b949		0f10eb			MOVUPS X3, X5		
  0x4b94c		c4e2f1b9d9		VFMADD231SD X1, X1, X3	
	return sqrt(x)
  0x4b951		f20f51f3		SQRTSD X3, X6		
	g := math.Sqrt(g_sq)
  0x4b955		90			NOPL			
	g_perp := math.Sqrt(g_perp_sq)
  0x4b956		90			NOPL			
	wx := F1 * (*vxe)
  0x4b957		f20f103d00000000	MOVSD_XMM 0(IP), X7	[4:8]R_PCREL:$f64.3eeccc65fefd8fed	
  0x4b95f		f20f59f9		MULSD X1, X7		
	wy := F1 * (*vye)
  0x4b963		f2440f100500000000	MOVSD_XMM 0(IP), X8	[5:9]R_PCREL:$f64.3eeccc65fefd8fed	
  0x4b96c		f2440f59c2		MULSD X2, X8		
	wz := F1 * (*vze)
  0x4b971		f2440f100d00000000	MOVSD_XMM 0(IP), X9	[5:9]R_PCREL:$f64.3eeccc65fefd8fed	
  0x4b97a		f2440f59cc		MULSD X4, X9		
	return sqrt(x)
  0x4b97f		f20f51ed		SQRTSD X5, X5		
	if g > 0.0 {
  0x4b983		450f57d2		XORPS X10, X10		
  0x4b987		66410f2ef2		UCOMISD X10, X6		
  0x4b98c		760e			JBE 0x4b99c		
		ct = gx / g
  0x4b98e		f20f5ece		DIVSD X6, X1		
		st = g_perp / g
  0x4b992		440f10dd		MOVUPS X5, X11		
  0x4b996		f20f5eee		DIVSD X6, X5		
  0x4b99a		eb0f			JMP 0x4b9ab		
	if g_perp > 0.0 {
  0x4b99c		440f10dd		MOVUPS X5, X11		
  0x4b9a0		0f57ed			XORPS X5, X5		
  0x4b9a3		f20f100d00000000	MOVSD_XMM 0(IP), X1	[4:8]R_PCREL:$f64.3ff0000000000000	
  0x4b9ab		66450f2eda		UCOMISD X10, X11	
  0x4b9b0		760c			JBE 0x4b9be		
		cp = gy / g_perp
  0x4b9b2		f2410f5ed3		DIVSD X11, X2		
		sp = gz / g_perp
  0x4b9b7		f2410f5ee3		DIVSD X11, X4		
  0x4b9bc		eb0b			JMP 0x4b9c9		
  0x4b9be		0f57e4			XORPS X4, X4		
  0x4b9c1		f20f101500000000	MOVSD_XMM 0(IP), X2	[4:8]R_PCREL:$f64.3ff0000000000000	
	t0 := sim.Sigma[E_ELA][eindex]
  0x4b9c9		8400			TESTB AL, 0(AX)		
  0x4b9cb		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x4b9d4		4881fe40420f00		CMPQ SI, $0xf4240	
  0x4b9db		0f83f2090000		JAE 0x4c3d3		
	if g > 0.0 {
  0x4b9e1		4889842458010000	MOVQ AX, 0x158(SP)	
  0x4b9e9		f20f11842460010000	MOVSD_XMM X0, 0x160(SP)	
  0x4b9f2		48899c2468010000	MOVQ BX, 0x168(SP)	
  0x4b9fa		48898c2470010000	MOVQ CX, 0x170(SP)	
  0x4ba02		4889bc2478010000	MOVQ DI, 0x178(SP)	
  0x4ba0a		4c89842488010000	MOVQ R8, 0x188(SP)	
	g_sq := gx*gx + g_perp_sq
  0x4ba12		f20f119c24d8000000	MOVSD_XMM X3, 0xd8(SP)	
	return sqrt(x)
  0x4ba1b		f20f11742458		MOVSD_XMM X6, 0x58(SP)	
	wx := F1 * (*vxe)
  0x4ba21		f20f11bc2490000000	MOVSD_XMM X7, 0x90(SP)	
	wy := F1 * (*vye)
  0x4ba2a		f2440f11842488000000	MOVSD_XMM X8, 0x88(SP)	
	wz := F1 * (*vze)
  0x4ba34		f2440f118c2480000000	MOVSD_XMM X9, 0x80(SP)	
	t0 := sim.Sigma[E_ELA][eindex]
  0x4ba3e		f20f11a424b0000000	MOVSD_XMM X4, 0xb0(SP)	
  0x4ba47		f20f119424f0000000	MOVSD_XMM X2, 0xf0(SP)	
	if g_perp > 0.0 {
  0x4ba50		f20f11ac24a8000000	MOVSD_XMM X5, 0xa8(SP)	
  0x4ba59		f20f118c24e8000000	MOVSD_XMM X1, 0xe8(SP)	
	t0 := sim.Sigma[E_ELA][eindex]
  0x4ba62		f20f1084f0c0000000	MOVSD_XMM 0xc0(AX)(SI*8), X0	
  0x4ba6b		f20f118424a0000000	MOVSD_XMM X0, 0xa0(SP)		
	t1 := t0 + sim.Sigma[E_EXC][eindex]
  0x4ba74		f20f108cf0c0127a00	MOVSD_XMM 0x7a12c0(AX)(SI*8), X1	
  0x4ba7d		f20f58c8		ADDSD X0, X1				
  0x4ba81		f20f118c2498000000	MOVSD_XMM X1, 0x98(SP)			
	t2 := t1 + sim.Sigma[E_ION][eindex]
  0x4ba8a		f20f1084f0c024f400	MOVSD_XMM 0xf424c0(AX)(SI*8), X0	
  0x4ba93		f20f11842438010000	MOVSD_XMM X0, 0x138(SP)			
	rnd := sim.WorkerR01(workerID)
  0x4ba9c		4c89c3			MOVQ R8, BX		
  0x4ba9f		e800000000		CALL 0x4baa4		[1:5]R_CALL:gopic.(*SimulationState).WorkerR01	
  0x4baa4		f20f118424c8000000	MOVSD_XMM X0, 0xc8(SP)	
	eta := TWO_PI * sim.WorkerR01(workerID)
  0x4baad		488b842458010000	MOVQ 0x158(SP), AX	
  0x4bab5		488b9c2488010000	MOVQ 0x188(SP), BX	
  0x4babd		e800000000		CALL 0x4bac2		[1:5]R_CALL:gopic.(*SimulationState).WorkerR01	
	t2 := t1 + sim.Sigma[E_ION][eindex]
  0x4bac2		f20f108c2438010000	MOVSD_XMM 0x138(SP), X1	
  0x4bacb		f20f10942498000000	MOVSD_XMM 0x98(SP), X2	
  0x4bad4		f20f58ca		ADDSD X2, X1		
	r_t2 := rnd * t2
  0x4bad8		f20f109424c8000000	MOVSD_XMM 0xc8(SP), X2	
  0x4bae1		f20f59ca		MULSD X2, X1		
  0x4bae5		f20f118c24d0000000	MOVSD_XMM X1, 0xd0(SP)	
	eta := TWO_PI * sim.WorkerR01(workerID)
  0x4baee		f20f100d00000000	MOVSD_XMM 0(IP), X1	[4:8]R_PCREL:$f64.401921fb54442d18	
  0x4baf6		f20f59c1		MULSD X1, X0		
	se, ce := math.Sincos(eta)
  0x4bafa		e800000000		CALL 0x4baff		[1:5]R_CALL:math.Sincos	
  0x4baff		f20f118c2400010000	MOVSD_XMM X1, 0x100(SP)	
  0x4bb08		f20f118424c0000000	MOVSD_XMM X0, 0xc0(SP)	
	if r_t2 < t0 { // Zderzenie spr─Ö┼╝yste (izotropowe)
  0x4bb11		f20f109424a0000000	MOVSD_XMM 0xa0(SP), X2	
  0x4bb1a		f20f109c24d0000000	MOVSD_XMM 0xd0(SP), X3	
  0x4bb23		660f2ed3		UCOMISD X3, X2		
  0x4bb27		0f8712070000		JA 0x4c23f		
	} else if r_t2 < t1 { // Wzbudzenie (niespr─Ö┼╝yste, izotropowe)
  0x4bb2d		f20f10942498000000	MOVSD_XMM 0x98(SP), X2	
  0x4bb36		660f2ed3		UCOMISD X3, X2		
  0x4bb3a		0f86d0000000		JBE 0x4bc10		
		energy := HALF_E_MASS * g_sq
  0x4bb40		f20f100500000000	MOVSD_XMM 0(IP), X0	[4:8]R_PCREL:$f64.39a279dcc3e61461	
  0x4bb48		f20f108c24d8000000	MOVSD_XMM 0xd8(SP), X1	
  0x4bb51		f20f59c1		MULSD X1, X0		
		energy = math.Abs(energy - E_EXC_TH*EV_TO_J)
  0x4bb55		f20f100d00000000	MOVSD_XMM 0(IP), X1	[4:8]R_PCREL:$f64.3c40fe7ccb02e6a7	
  0x4bb5d		f20f5cc1		SUBSD X1, X0		
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4bb61		0f57c9			XORPS X1, X1		
  0x4bb64		f20f101500000000	MOVSD_XMM 0(IP), X2	[4:8]R_PCREL:$f64.8000000000000000	
  0x4bb6c		660fefca		PXOR X2, X1		
  0x4bb70		f20f118c2438010000	MOVSD_XMM X1, 0x138(SP)	
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x4bb79		66480f7ec1		MOVQ X0, CX		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x4bb7e		480fbaf13f		BTRQ $0x3f, CX		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x4bb83		66480f6ec1		MOVQ CX, X0		
		g = math.Sqrt(energy * TWO_OVER_E_MASS)
  0x4bb88		f20f100d00000000	MOVSD_XMM 0(IP), X1	[4:8]R_PCREL:$f64.463bb62aabbfcc6d	
  0x4bb90		f20f59c8		MULSD X0, X1		
  0x4bb94		f20f114c2478		MOVSD_XMM X1, 0x78(SP)	
		cc = 1.0 - 2.0*sim.WorkerR01(workerID)
  0x4bb9a		488b842458010000	MOVQ 0x158(SP), AX	
  0x4bba2		488b9c2488010000	MOVQ 0x188(SP), BX	
  0x4bbaa		e800000000		CALL 0x4bbaf		[1:5]R_CALL:gopic.(*SimulationState).WorkerR01	
  0x4bbaf		f20f58c0		ADDSD X0, X0		
  0x4bbb3		f20f100d00000000	MOVSD_XMM 0(IP), X1	[4:8]R_PCREL:$f64.3ff0000000000000	
  0x4bbbb		f20f5cc8		SUBSD X0, X1		
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4bbbf		0f10c1			MOVUPS X1, X0		
  0x4bbc2		f20f59c9		MULSD X1, X1		
  0x4bbc6		f20f101500000000	MOVSD_XMM 0(IP), X2	[4:8]R_PCREL:$f64.3ff0000000000000	
  0x4bbce		f20f5cd1		SUBSD X1, X2		
  0x4bbd2		f20f100d00000000	MOVSD_XMM 0(IP), X1	[4:8]R_PCREL:$f64.8000000000000000	
  0x4bbda		660fefd1		PXOR X1, X2		
  0x4bbde		f20f109c2438010000	MOVSD_XMM 0x138(SP), X3	
  0x4bbe7		0f10e3			MOVUPS X3, X4		
  0x4bbea		f20f5dda		MINSD X2, X3		
  0x4bbee		0f10d3			MOVUPS X3, X2		
  0x4bbf1		f20f5ddc		MINSD X4, X3		
  0x4bbf5		660febd3		POR X3, X2		
  0x4bbf9		660fefd1		PXOR X1, X2		
	return sqrt(x)
  0x4bbfd		f20f104c2478		MOVSD_XMM 0x78(SP), X1	
  0x4bc03		f20f51c9		SQRTSD X1, X1		
  0x4bc07		f20f51d2		SQRTSD X2, X2		
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4bc0b		e9a2060000		JMP 0x4c2b2		
		energy := HALF_E_MASS * g_sq
  0x4bc10		f20f101500000000	MOVSD_XMM 0(IP), X2	[4:8]R_PCREL:$f64.39a279dcc3e61461	
  0x4bc18		f20f109c24d8000000	MOVSD_XMM 0xd8(SP), X3	
  0x4bc21		f20f59d3		MULSD X3, X2		
		energy = math.Abs(energy - E_ION_TH*EV_TO_J)
  0x4bc25		f20f101d00000000	MOVSD_XMM 0(IP), X3	[4:8]R_PCREL:$f64.3c475931051c7900	
  0x4bc2d		f20f5cd3		SUBSD X3, X2		
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4bc31		0f57db			XORPS X3, X3		
  0x4bc34		f20f102500000000	MOVSD_XMM 0(IP), X4	[4:8]R_PCREL:$f64.8000000000000000	
  0x4bc3c		660fefdc		PXOR X4, X3		
  0x4bc40		f20f119c2438010000	MOVSD_XMM X3, 0x138(SP)	
		se2 := -se
  0x4bc49		660fefe0		PXOR X0, X4		
  0x4bc4d		f20f11a424b8000000	MOVSD_XMM X4, 0xb8(SP)	
		ce2 := -ce
  0x4bc56		f20f100500000000	MOVSD_XMM 0(IP), X0	[4:8]R_PCREL:$f64.8000000000000000	
  0x4bc5e		660fefc1		PXOR X1, X0		
  0x4bc62		f20f118424f8000000	MOVSD_XMM X0, 0xf8(SP)	
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
  0x4bc6b		f20f108424a8000000	MOVSD_XMM 0xa8(SP), X0	
  0x4bc74		f20f108c24f0000000	MOVSD_XMM 0xf0(SP), X1	
  0x4bc7d		0f10d8			MOVUPS X0, X3		
  0x4bc80		f20f59c1		MULSD X1, X0		
  0x4bc84		f20f11842430010000	MOVSD_XMM X0, 0x130(SP)	
  0x4bc8d		f20f108424e8000000	MOVSD_XMM 0xe8(SP), X0	
  0x4bc96		0f10e0			MOVUPS X0, X4		
  0x4bc99		f20f59c1		MULSD X1, X0		
  0x4bc9d		f20f11842428010000	MOVSD_XMM X0, 0x128(SP)	
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)
  0x4bca6		f20f108424b0000000	MOVSD_XMM 0xb0(SP), X0	
  0x4bcaf		f20f59d8		MULSD X0, X3		
  0x4bcb3		f20f119c2420010000	MOVSD_XMM X3, 0x120(SP)	
  0x4bcbc		f20f59e0		MULSD X0, X4		
  0x4bcc0		f20f11a42418010000	MOVSD_XMM X4, 0x118(SP)	
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x4bcc9		66480f7ed1		MOVQ X2, CX		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x4bcce		480fbaf13f		BTRQ $0x3f, CX		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x4bcd3		66480f6ec1		MOVQ CX, X0		
  0x4bcd8		f20f118424e0000000	MOVSD_XMM X0, 0xe0(SP)	
		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
  0x4bce1		f20f100d00000000	MOVSD_XMM 0(IP), X1	[4:8]R_PCREL:$f64.439152dbe5934720	
  0x4bce9		f20f59c8		MULSD X0, X1		
  0x4bced		f20f114c2470		MOVSD_XMM X1, 0x70(SP)	
  0x4bcf3		488b842458010000	MOVQ 0x158(SP), AX	
  0x4bcfb		488b9c2488010000	MOVQ 0x188(SP), BX	
  0x4bd03		e800000000		CALL 0x4bd08		[1:5]R_CALL:gopic.(*SimulationState).WorkerR01	
  0x4bd08		f20f11842410010000	MOVSD_XMM X0, 0x110(SP)	
	return atan(x)
  0x4bd11		f20f10442470		MOVSD_XMM 0x70(SP), X0	
  0x4bd17		e800000000		CALL 0x4bd1c		[1:5]R_CALL:math.atan	
		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
  0x4bd1c		f20f108c2410010000	MOVSD_XMM 0x110(SP), X1	
  0x4bd25		f20f59c1		MULSD X1, X0		
	return tan(x)
  0x4bd29		e800000000		CALL 0x4bd2e		[1:5]R_CALL:math.tan	
		e_ej := 10.0 * math.Tan(sim.WorkerR01(workerID)*math.Atan(energy*OPAL_FACTOR)) * EV_TO_J
  0x4bd2e		f20f100d00000000	MOVSD_XMM 0(IP), X1	[4:8]R_PCREL:$f64.4024000000000000	
  0x4bd36		f20f59c8		MULSD X0, X1		
  0x4bd3a		f20f100500000000	MOVSD_XMM 0(IP), X0	[4:8]R_PCREL:$f64.3c07a4da2594bb57	
  0x4bd42		f20f59c1		MULSD X1, X0		
		e_sc := math.Abs(energy - e_ej)
  0x4bd46		f20f108c24e0000000	MOVSD_XMM 0xe0(SP), X1	
  0x4bd4f		0f10d1			MOVUPS X1, X2		
  0x4bd52		f20f5cc8		SUBSD X0, X1		
		g2 := math.Sqrt(e_ej * TWO_OVER_E_MASS)
  0x4bd56		f20f101d00000000	MOVSD_XMM 0(IP), X3	[4:8]R_PCREL:$f64.463bb62aabbfcc6d	
  0x4bd5e		f20f59d8		MULSD X0, X3		
		cc2 := math.Sqrt(e_ej / energy)
  0x4bd62		f20f5ec2		DIVSD X2, X0		
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4bd66		488b8c2458010000	MOVQ 0x158(SP), CX	
  0x4bd6e		488b9198000000		MOVQ 0x98(CX), DX	
	return sqrt(x)
  0x4bd75		f20f51db		SQRTSD X3, X3		
  0x4bd79		f20f51c0		SQRTSD X0, X0		
		sc2 := math.Sqrt(max(0.0, 1.0-cc2*cc2))
  0x4bd7d		0f10e0			MOVUPS X0, X4		
  0x4bd80		f20f59c0		MULSD X0, X0		
  0x4bd84		f20f102d00000000	MOVSD_XMM 0(IP), X5	[4:8]R_PCREL:$f64.3ff0000000000000	
  0x4bd8c		f20f5ce8		SUBSD X0, X5		
  0x4bd90		f20f100500000000	MOVSD_XMM 0(IP), X0	[4:8]R_PCREL:$f64.8000000000000000	
  0x4bd98		660fefe8		PXOR X0, X5		
  0x4bd9c		f20f10b42438010000	MOVSD_XMM 0x138(SP), X6	
  0x4bda5		0f10fe			MOVUPS X6, X7		
  0x4bda8		f20f5df5		MINSD X5, X6		
  0x4bdac		0f10ee			MOVUPS X6, X5		
  0x4bdaf		f20f5df7		MINSD X7, X6		
  0x4bdb3		660febee		POR X6, X5		
  0x4bdb7		660fefe8		PXOR X0, X5		
		gx2 := g2 * (ct*cc2 - st*sc2*ce2)
  0x4bdbb		f20f10b424e8000000	MOVSD_XMM 0xe8(SP), X6	
  0x4bdc4		440f10c4		MOVUPS X4, X8		
  0x4bdc8		f20f59e6		MULSD X6, X4		
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
  0x4bdcc		f2440f108c2430010000	MOVSD_XMM 0x130(SP), X9	
  0x4bdd6		f2450f59c8		MULSD X8, X9		
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)
  0x4bddb		f2440f10942420010000	MOVSD_XMM 0x120(SP), X10	
  0x4bde5		f2450f59c2		MULSD X10, X8			
	return sqrt(x)
  0x4bdea		f20f51ed		SQRTSD X5, X5		
		gx2 := g2 * (ct*cc2 - st*sc2*ce2)
  0x4bdee		f2440f109424a8000000	MOVSD_XMM 0xa8(SP), X10	
  0x4bdf8		450f10da		MOVUPS X10, X11		
  0x4bdfc		f2440f59d5		MULSD X5, X10		
  0x4be01		f2440f10a424f8000000	MOVSD_XMM 0xf8(SP), X12	
  0x4be0b		f2450f59d4		MULSD X12, X10		
  0x4be10		f2410f5ce2		SUBSD X10, X4		
  0x4be15		f20f59e3		MULSD X3, X4		
		gy2 := g2 * (st*cp*cc2 + ct*cp*sc2*ce2 - sp*sc2*se2)
  0x4be19		f2440f10942428010000	MOVSD_XMM 0x128(SP), X10	
  0x4be23		f2440f59d5		MULSD X5, X10			
  0x4be28		c442a9b9cc		VFMADD231SD X12, X10, X9	
  0x4be2d		f2440f109424b0000000	MOVSD_XMM 0xb0(SP), X10		
  0x4be37		450f10ea		MOVUPS X10, X13			
  0x4be3b		f2440f59d5		MULSD X5, X10			
  0x4be40		f2440f10b424b8000000	MOVSD_XMM 0xb8(SP), X14		
  0x4be4a		f2450f59d6		MULSD X14, X10			
  0x4be4f		f2450f5cca		SUBSD X10, X9			
  0x4be54		f2440f59cb		MULSD X3, X9			
		gz2 := g2 * (st*sp*cc2 + ct*sp*sc2*ce2 + cp*sc2*se2)
  0x4be59		f2440f10942418010000	MOVSD_XMM 0x118(SP), X10	
  0x4be63		f2440f59d5		MULSD X5, X10			
  0x4be68		c442a9b9c4		VFMADD231SD X12, X10, X8	
  0x4be6d		f2440f109424f0000000	MOVSD_XMM 0xf0(SP), X10		
  0x4be77		f2410f59ea		MULSD X10, X5			
  0x4be7c		c442d1b9c6		VFMADD231SD X14, X5, X8		
  0x4be81		f2410f59d8		MULSD X8, X3			
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x4be86		66480f7ece		MOVQ X1, SI		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x4be8b		480fbaf63f		BTRQ $0x3f, SI		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x4be90		66480f6ece		MOVQ SI, X1		
		cc = math.Sqrt(e_sc / energy)
  0x4be95		0f10e9			MOVUPS X1, X5		
  0x4be98		f20f5eca		DIVSD X2, X1		
	return sqrt(x)
  0x4be9c		f20f51c9		SQRTSD X1, X1		
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4bea0		0f10d1			MOVUPS X1, X2		
  0x4bea3		f20f59c9		MULSD X1, X1		
  0x4bea7		f2440f100500000000	MOVSD_XMM 0(IP), X8	[5:9]R_PCREL:$f64.3ff0000000000000	
  0x4beb0		f2440f5cc1		SUBSD X1, X8		
  0x4beb5		66440fefc0		PXOR X0, X8		
  0x4beba		0f10cf			MOVUPS X7, X1		
  0x4bebd		f2410f5df8		MINSD X8, X7		
  0x4bec2		440f10c7		MOVUPS X7, X8		
  0x4bec6		f20f5df9		MINSD X1, X7		
  0x4beca		66440febc7		POR X7, X8		
		g = math.Sqrt(e_sc * TWO_OVER_E_MASS)
  0x4becf		f20f100d00000000	MOVSD_XMM 0(IP), X1	[4:8]R_PCREL:$f64.463bb62aabbfcc6d	
  0x4bed7		f20f59e9		MULSD X1, X5		
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4bedb		66440fefc0		PXOR X0, X8		
			Vx: wx + F2*gx2,
  0x4bee0		f20f10842490000000	MOVSD_XMM 0x90(SP), X0	
  0x4bee9		f20f100d00000000	MOVSD_XMM 0(IP), X1	[4:8]R_PCREL:$f64.3fefffe3339a0103	
  0x4bef1		0f10f8			MOVUPS X0, X7		
  0x4bef4		c4e2f1b9c4		VFMADD231SD X4, X1, X0	
			Vy: wy + F2*gy2,
  0x4bef9		f20f10a42488000000	MOVSD_XMM 0x88(SP), X4	
  0x4bf02		440f10e4		MOVUPS X4, X12		
  0x4bf06		c4c2f1b9e1		VFMADD231SD X9, X1, X4	
			Vz: wz + F2*gz2,
  0x4bf0b		f2440f108c2480000000	MOVSD_XMM 0x80(SP), X9	
  0x4bf15		450f10f1		MOVUPS X9, X14		
  0x4bf19		c462f1b9cb		VFMADD231SD X3, X1, X9	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4bf1e		488bb42488010000	MOVQ 0x188(SP), SI	
  0x4bf26		4839d6			CMPQ SI, DX		
  0x4bf29		0f839f040000		JAE 0x4c3ce		
		g = math.Sqrt(e_sc * TWO_OVER_E_MASS)
  0x4bf2f		f20f116c2468		MOVSD_XMM X5, 0x68(SP)	
	return sqrt(x)
  0x4bf35		f20f11942438010000	MOVSD_XMM X2, 0x138(SP)	
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4bf3e		f2440f11442460		MOVSD_XMM X8, 0x60(SP)	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4bf45		488b9190000000		MOVQ 0x90(CX), DX	
  0x4bf4c		4c8d0476		LEAQ 0(SI)(SI*2), R8	
  0x4bf50		4c89842408010000	MOVQ R8, 0x108(SP)	
  0x4bf58		4e8b4cc210		MOVQ 0x10(DX)(R8*8), R9	
  0x4bf5d		4a8b5cc208		MOVQ 0x8(DX)(R8*8), BX	
  0x4bf62		48ffc3			INCQ BX			
  0x4bf65		4a8b04c2		MOVQ 0(DX)(R8*8), AX	
  0x4bf69		4939d9			CMPQ R9, BX		
  0x4bf6c		0f83fb000000		JAE 0x4c06d		
  0x4bf72		4889942440010000	MOVQ DX, 0x140(SP)	
			Vx: wx + F2*gx2,
  0x4bf7a		f20f11842430010000	MOVSD_XMM X0, 0x130(SP)	
			Vy: wy + F2*gy2,
  0x4bf83		f20f11a42428010000	MOVSD_XMM X4, 0x128(SP)	
			Vz: wz + F2*gz2,
  0x4bf8c		f2440f118c2420010000	MOVSD_XMM X9, 0x120(SP)	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4bf96		4c89c9			MOVQ R9, CX		
  0x4bf99		bf01000000		MOVL $0x1, DI		
  0x4bf9e		488d3500000000		LEAQ 0(IP), SI		[3:7]R_PCREL:type:gopic.CreatedParticle	
  0x4bfa5		e800000000		CALL 0x4bfaa		[1:5]R_CALL:runtime.growslice<1>	
  0x4bfaa		488b942408010000	MOVQ 0x108(SP), DX	
  0x4bfb2		4c8b842440010000	MOVQ 0x140(SP), R8	
  0x4bfba		49894cd010		MOVQ CX, 0x10(R8)(DX*8)	
  0x4bfbf		833d0000000000		CMPL 0(IP), $0x0	[2:6]R_PCREL:runtime.writeBarrier+-1	
  0x4bfc6		7410			JE 0x4bfd8		
  0x4bfc8		498b0cd0		MOVQ 0(R8)(DX*8), CX	
  0x4bfcc		e800000000		CALL 0x4bfd1		[1:5]R_CALL:runtime.gcWriteBarrier2<1>	
  0x4bfd1		498903			MOVQ AX, 0(R11)		
  0x4bfd4		49894b08		MOVQ CX, 0x8(R11)	
  0x4bfd8		498904d0		MOVQ AX, 0(R8)(DX*8)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4bfdc		488b8c2458010000	MOVQ 0x158(SP), CX	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4bfe4		4c89c2			MOVQ R8, DX		
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4bfe7		488bb42488010000	MOVQ 0x188(SP), SI	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4bfef		4c8b842408010000	MOVQ 0x108(SP), R8	
  0x4bff7		f20f10842430010000	MOVSD_XMM 0x130(SP), X0	
  0x4c000		f20f10942438010000	MOVSD_XMM 0x138(SP), X2	
  0x4c009		f20f10a42428010000	MOVSD_XMM 0x128(SP), X4	
	return sqrt(x)
  0x4c012		f20f106c2468		MOVSD_XMM 0x68(SP), X5	
	gx = g * (ct*cc - st*sc*ce)
  0x4c018		f20f10b424e8000000	MOVSD_XMM 0xe8(SP), X6	
	*vxe = wx + F2*gx
  0x4c021		f20f10bc2490000000	MOVSD_XMM 0x90(SP), X7	
	return sqrt(x)
  0x4c02a		f2440f10442460		MOVSD_XMM 0x60(SP), X8	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4c031		f2440f108c2420010000	MOVSD_XMM 0x120(SP), X9	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4c03b		f2440f109424f0000000	MOVSD_XMM 0xf0(SP), X10	
	gx = g * (ct*cc - st*sc*ce)
  0x4c045		f2440f109c24a8000000	MOVSD_XMM 0xa8(SP), X11	
	*vye = wy + F2*gy
  0x4c04f		f2440f10a42488000000	MOVSD_XMM 0x88(SP), X12	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4c059		f2440f10ac24b0000000	MOVSD_XMM 0xb0(SP), X13	
	*vze = wz + F2*gz
  0x4c063		f2440f10b42480000000	MOVSD_XMM 0x80(SP), X14	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4c06d		4a895cc208		MOVQ BX, 0x8(DX)(R8*8)		
  0x4c072		488d53ff		LEAQ -0x1(BX), DX		
  0x4c076		48c1e205		SHLQ $0x5, DX			
  0x4c07a		f20f108c2460010000	MOVSD_XMM 0x160(SP), X1		
  0x4c083		f20f110c10		MOVSD_XMM X1, 0(AX)(DX*1)	
  0x4c088		f20f11441008		MOVSD_XMM X0, 0x8(AX)(DX*1)	
  0x4c08e		f20f11641010		MOVSD_XMM X4, 0x10(AX)(DX*1)	
  0x4c094		f2440f114c1018		MOVSD_XMM X9, 0x18(AX)(DX*1)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c09b		488b91f82dba07		MOVQ 0x7ba2df8(CX), DX	
			Vx: sim.WorkerRMB(workerID),
  0x4c0a2		90			NOPL			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c0a3		4839d6			CMPQ SI, DX		
  0x4c0a6		0f831d030000		JAE 0x4c3c9		
  0x4c0ac		488b89f02dba07		MOVQ 0x7ba2df0(CX), CX	
  0x4c0b3		488b04f1		MOVQ 0(CX)(SI*8), AX	
  0x4c0b7		e800000000		CALL 0x4c0bc		[1:5]R_CALL:math/rand.(*Rand).NormFloat64	
  0x4c0bc		488b8c2458010000	MOVQ 0x158(SP), CX	
  0x4c0c4		488b91f82dba07		MOVQ 0x7ba2df8(CX), DX	
			Vy: sim.WorkerRMB(workerID),
  0x4c0cb		90			NOPL			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c0cc		f20f590500000000	MULSD 0(IP), X0		[4:8]R_PCREL:gopic.RMB_sigma	
  0x4c0d4		488b9c2488010000	MOVQ 0x188(SP), BX	
  0x4c0dc		4839d3			CMPQ BX, DX		
  0x4c0df		0f83df020000		JAE 0x4c3c4		
  0x4c0e5		f20f11442450		MOVSD_XMM X0, 0x50(SP)	
  0x4c0eb		488b89f02dba07		MOVQ 0x7ba2df0(CX), CX	
  0x4c0f2		488b04d9		MOVQ 0(CX)(BX*8), AX	
  0x4c0f6		e800000000		CALL 0x4c0fb		[1:5]R_CALL:math/rand.(*Rand).NormFloat64	
  0x4c0fb		488b8c2458010000	MOVQ 0x158(SP), CX	
  0x4c103		488b91f82dba07		MOVQ 0x7ba2df8(CX), DX	
			Vz: sim.WorkerRMB(workerID),
  0x4c10a		90			NOPL			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c10b		f20f590500000000	MULSD 0(IP), X0		[4:8]R_PCREL:gopic.RMB_sigma	
  0x4c113		488b9c2488010000	MOVQ 0x188(SP), BX	
  0x4c11b		4839d3			CMPQ BX, DX		
  0x4c11e		0f839b020000		JAE 0x4c3bf		
  0x4c124		f20f11442448		MOVSD_XMM X0, 0x48(SP)	
  0x4c12a		488b89f02dba07		MOVQ 0x7ba2df0(CX), CX	
  0x4c131		488b04d9		MOVQ 0(CX)(BX*8), AX	
  0x4c135		e800000000		CALL 0x4c13a		[1:5]R_CALL:math/rand.(*Rand).NormFloat64	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x4c13a		488b8c2458010000	MOVQ 0x158(SP), CX	
  0x4c142		488b91b0000000		MOVQ 0xb0(CX), DX	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c149		f20f590500000000	MULSD 0(IP), X0		[4:8]R_PCREL:gopic.RMB_sigma	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x4c151		488b9c2488010000	MOVQ 0x188(SP), BX	
  0x4c159		4839d3			CMPQ BX, DX		
  0x4c15c		0f8358020000		JAE 0x4c3ba		
  0x4c162		488b91a8000000		MOVQ 0xa8(CX), DX	
  0x4c169		4c8b842408010000	MOVQ 0x108(SP), R8	
  0x4c171		4a8b4cc210		MOVQ 0x10(DX)(R8*8), CX	
  0x4c176		4a8b5cc208		MOVQ 0x8(DX)(R8*8), BX	
  0x4c17b		48ffc3			INCQ BX			
  0x4c17e		4a8b04c2		MOVQ 0(DX)(R8*8), AX	
  0x4c182		4839d9			CMPQ CX, BX		
  0x4c185		7360			JAE 0x4c1e7		
  0x4c187		4889942440010000	MOVQ DX, 0x140(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c18f		f20f11442440		MOVSD_XMM X0, 0x40(SP)	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x4c195		bf01000000		MOVL $0x1, DI			
  0x4c19a		488d3500000000		LEAQ 0(IP), SI			[3:7]R_PCREL:type:gopic.CreatedParticle	
  0x4c1a1		e800000000		CALL 0x4c1a6			[1:5]R_CALL:runtime.growslice<1>	
  0x4c1a6		488b942408010000	MOVQ 0x108(SP), DX		
  0x4c1ae		4c8b842440010000	MOVQ 0x140(SP), R8		
  0x4c1b6		49894cd010		MOVQ CX, 0x10(R8)(DX*8)		
  0x4c1bb		833d0000000000		CMPL 0(IP), $0x0		[2:6]R_PCREL:runtime.writeBarrier+-1	
  0x4c1c2		7410			JE 0x4c1d4			
  0x4c1c4		498b0cd0		MOVQ 0(R8)(DX*8), CX		
  0x4c1c8		e800000000		CALL 0x4c1cd			[1:5]R_CALL:runtime.gcWriteBarrier2<1>	
  0x4c1cd		498903			MOVQ AX, 0(R11)			
  0x4c1d0		49894b08		MOVQ CX, 0x8(R11)		
  0x4c1d4		498904d0		MOVQ AX, 0(R8)(DX*8)		
  0x4c1d8		f20f10442440		MOVSD_XMM 0x40(SP), X0		
  0x4c1de		4889d1			MOVQ DX, CX			
  0x4c1e1		4c89c2			MOVQ R8, DX			
  0x4c1e4		4989c8			MOVQ CX, R8			
  0x4c1e7		4a895cc208		MOVQ BX, 0x8(DX)(R8*8)		
  0x4c1ec		488d4bff		LEAQ -0x1(BX), CX		
  0x4c1f0		48c1e105		SHLQ $0x5, CX			
  0x4c1f4		f20f109c2460010000	MOVSD_XMM 0x160(SP), X3		
  0x4c1fd		f20f111c08		MOVSD_XMM X3, 0(AX)(CX*1)	
  0x4c202		f20f105c2450		MOVSD_XMM 0x50(SP), X3		
  0x4c208		f20f115c0808		MOVSD_XMM X3, 0x8(AX)(CX*1)	
  0x4c20e		f20f105c2448		MOVSD_XMM 0x48(SP), X3		
  0x4c214		f20f115c0810		MOVSD_XMM X3, 0x10(AX)(CX*1)	
  0x4c21a		f20f11440818		MOVSD_XMM X0, 0x18(AX)(CX*1)	
	return sqrt(x)
  0x4c220		f20f10442468		MOVSD_XMM 0x68(SP), X0	
  0x4c226		f20f51c8		SQRTSD X0, X1		
  0x4c22a		f20f10442460		MOVSD_XMM 0x60(SP), X0	
  0x4c230		f20f51d0		SQRTSD X0, X2		
  0x4c234		f20f10842438010000	MOVSD_XMM 0x138(SP), X0	
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x4c23d		eb73			JMP 0x4c2b2		
		cc = 1.0 - 2.0*sim.WorkerR01(workerID)
  0x4c23f		488b842458010000	MOVQ 0x158(SP), AX	
  0x4c247		488b9c2488010000	MOVQ 0x188(SP), BX	
  0x4c24f		0f1f440000		NOPL 0(AX)(AX*1)	
  0x4c254		e800000000		CALL 0x4c259		[1:5]R_CALL:gopic.(*SimulationState).WorkerR01	
  0x4c259		f20f58c0		ADDSD X0, X0		
  0x4c25d		f20f100d00000000	MOVSD_XMM 0(IP), X1	[4:8]R_PCREL:$f64.3ff0000000000000	
  0x4c265		f20f5cc8		SUBSD X0, X1		
		sc = math.Sqrt(max(0.0, 1.0-cc*cc))
  0x4c269		0f57c0			XORPS X0, X0		
  0x4c26c		f20f101500000000	MOVSD_XMM 0(IP), X2	[4:8]R_PCREL:$f64.8000000000000000	
  0x4c274		660fefc2		PXOR X2, X0		
  0x4c278		0f10d9			MOVUPS X1, X3		
  0x4c27b		f20f59c9		MULSD X1, X1		
  0x4c27f		f20f102500000000	MOVSD_XMM 0(IP), X4	[4:8]R_PCREL:$f64.3ff0000000000000	
  0x4c287		f20f5ce1		SUBSD X1, X4		
  0x4c28b		660fefe2		PXOR X2, X4		
  0x4c28f		0f10c8			MOVUPS X0, X1		
  0x4c292		f20f5dc4		MINSD X4, X0		
  0x4c296		0f10e0			MOVUPS X0, X4		
  0x4c299		f20f5dc1		MINSD X1, X0		
  0x4c29d		660febe0		POR X0, X4		
  0x4c2a1		660fefe2		PXOR X2, X4		
	return sqrt(x)
  0x4c2a5		f20f51d4		SQRTSD X4, X2		
	gx = g * (ct*cc - st*sc*ce)
  0x4c2a9		f20f104c2458		MOVSD_XMM 0x58(SP), X1	
  0x4c2af		0f10c3			MOVUPS X3, X0		
  0x4c2b2		f20f109c24e8000000	MOVSD_XMM 0xe8(SP), X3	
  0x4c2bb		0f10e3			MOVUPS X3, X4		
  0x4c2be		f20f59d8		MULSD X0, X3		
  0x4c2c2		f20f10ac24a8000000	MOVSD_XMM 0xa8(SP), X5	
  0x4c2cb		0f10f5			MOVUPS X5, X6		
  0x4c2ce		f20f59ea		MULSD X2, X5		
  0x4c2d2		f20f10bc2400010000	MOVSD_XMM 0x100(SP), X7	
  0x4c2db		f20f59ef		MULSD X7, X5		
  0x4c2df		f20f5cdd		SUBSD X5, X3		
  0x4c2e3		f20f59d9		MULSD X1, X3		
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4c2e7		f20f10ac24f0000000	MOVSD_XMM 0xf0(SP), X5	
  0x4c2f0		440f10c6		MOVUPS X6, X8		
  0x4c2f4		f20f59f5		MULSD X5, X6		
  0x4c2f8		f20f59f0		MULSD X0, X6		
  0x4c2fc		440f10cc		MOVUPS X4, X9		
  0x4c300		f20f59e5		MULSD X5, X4		
  0x4c304		f20f59e2		MULSD X2, X4		
  0x4c308		c4e2d9b9f7		VFMADD231SD X7, X4, X6	
  0x4c30d		f20f10a424b0000000	MOVSD_XMM 0xb0(SP), X4	
  0x4c316		440f10d4		MOVUPS X4, X10		
  0x4c31a		f20f59e2		MULSD X2, X4		
  0x4c31e		f2440f109c24c0000000	MOVSD_XMM 0xc0(SP), X11	
  0x4c328		f2410f59e3		MULSD X11, X4		
  0x4c32d		f20f5cf4		SUBSD X4, X6		
  0x4c331		f20f59f1		MULSD X1, X6		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4c335		f2450f59c2		MULSD X10, X8		
  0x4c33a		f2410f59c0		MULSD X8, X0		
  0x4c33f		f2450f59ca		MULSD X10, X9		
  0x4c344		f2440f59ca		MULSD X2, X9		
  0x4c349		c4e2b1b9c7		VFMADD231SD X7, X9, X0	
  0x4c34e		f20f59ea		MULSD X2, X5		
  0x4c352		c4c2d1b9c3		VFMADD231SD X11, X5, X0	
  0x4c357		f20f59c1		MULSD X1, X0		
	*vxe = wx + F2*gx
  0x4c35b		f20f108c2490000000	MOVSD_XMM 0x90(SP), X1	
  0x4c364		f20f101500000000	MOVSD_XMM 0(IP), X2	[4:8]R_PCREL:$f64.3fefffe3339a0103	
  0x4c36c		c4e2e1b9ca		VFMADD231SD X2, X3, X1	
  0x4c371		488b842468010000	MOVQ 0x168(SP), AX	
  0x4c379		f20f1108		MOVSD_XMM X1, 0(AX)	
	*vye = wy + F2*gy
  0x4c37d		f20f108c2488000000	MOVSD_XMM 0x88(SP), X1	
  0x4c386		c4e2c9b9ca		VFMADD231SD X2, X6, X1	
  0x4c38b		488b842470010000	MOVQ 0x170(SP), AX	
  0x4c393		f20f1108		MOVSD_XMM X1, 0(AX)	
	*vze = wz + F2*gz
  0x4c397		f20f108c2480000000	MOVSD_XMM 0x80(SP), X1	
  0x4c3a0		c4e2f9b9ca		VFMADD231SD X2, X0, X1	
  0x4c3a5		488b842478010000	MOVQ 0x178(SP), AX	
  0x4c3ad		f20f1108		MOVSD_XMM X1, 0(AX)	
}
  0x4c3b1		4881c448010000		ADDQ $0x148, SP		
  0x4c3b8		5d			POPQ BP			
  0x4c3b9		c3			RET			
		sim.WorkerNewIons[workerID] = append(sim.WorkerNewIons[workerID], CreatedParticle{
  0x4c3ba		e800000000		CALL 0x4c3bf		[1:5]R_CALL:runtime.panicBounds	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c3bf		e800000000		CALL 0x4c3c4		[1:5]R_CALL:runtime.panicBounds	
  0x4c3c4		e800000000		CALL 0x4c3c9		[1:5]R_CALL:runtime.panicBounds	
  0x4c3c9		e800000000		CALL 0x4c3ce		[1:5]R_CALL:runtime.panicBounds	
		sim.WorkerNewElectrons[workerID] = append(sim.WorkerNewElectrons[workerID], CreatedParticle{
  0x4c3ce		e800000000		CALL 0x4c3d3		[1:5]R_CALL:runtime.panicBounds	
	t0 := sim.Sigma[E_ELA][eindex]
  0x4c3d3		b840420f00		MOVL $0xf4240, AX	
  0x4c3d8		e800000000		CALL 0x4c3dd		[1:5]R_CALL:runtime.panicBounds	
  0x4c3dd		90			NOPL			
func (sim *SimulationState) CollisionElectron(xe float64, vxe, vye, vze *float64, eindex int, workerID int) {
  0x4c3de		4889442408		MOVQ AX, 0x8(SP)					
  0x4c3e3		f20f11442410		MOVSD_XMM X0, 0x10(SP)					
  0x4c3e9		48895c2418		MOVQ BX, 0x18(SP)					
  0x4c3ee		48894c2420		MOVQ CX, 0x20(SP)					
  0x4c3f3		48897c2428		MOVQ DI, 0x28(SP)					
  0x4c3f8		4889742430		MOVQ SI, 0x30(SP)					
  0x4c3fd		4c89442438		MOVQ R8, 0x38(SP)					
  0x4c402		e800000000		CALL 0x4c407						[1:5]R_CALL:runtime.morestack_noctxt	
  0x4c407		488b442408		MOVQ 0x8(SP), AX					
  0x4c40c		f20f10442410		MOVSD_XMM 0x10(SP), X0					
  0x4c412		488b5c2418		MOVQ 0x18(SP), BX					
  0x4c417		488b4c2420		MOVQ 0x20(SP), CX					
  0x4c41c		488b7c2428		MOVQ 0x28(SP), DI					
  0x4c421		488b742430		MOVQ 0x30(SP), SI					
  0x4c426		4c8b442438		MOVQ 0x38(SP), R8					
  0x4c42b		e9e4f4ffff		JMP gopic.(*SimulationState).CollisionElectron(SB)	
