// --- Symbol: CollisionElectron ---
TEXT gopic.(*SimulationState).CollisionElectron(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/collisions.go
func (sim *SimulationState) CollisionElectron(xe float64, vxe, vye, vze *float64, eindex int) {
  0x4b6320		4c8da42448ffffff	LEAQ 0xffffff48(SP), R12	
  0x4b6328		4d3b6610		CMPQ R12, 0x10(R14)		
  0x4b632c		0f869e0b0000		JBE 0x4b6ed0			
  0x4b6332		55			PUSHQ BP			
  0x4b6333		4889e5			MOVQ SP, BP			
  0x4b6336		4881ec30010000		SUBQ $0x130, SP			
	if gx == 0 {
  0x4b633d		4889842440010000	MOVQ AX, 0x140(SP)	
  0x4b6345		f20f11842448010000	MOVSD_XMM X0, 0x148(SP)	
  0x4b634e		48899c2450010000	MOVQ BX, 0x150(SP)	
  0x4b6356		48898c2458010000	MOVQ CX, 0x158(SP)	
  0x4b635e		4889bc2460010000	MOVQ DI, 0x160(SP)	
  0x4b6366		4889b42468010000	MOVQ SI, 0x168(SP)	
	gx = *vxe
  0x4b636e		f20f100b		MOVSD_XMM 0(BX), X1	
	gy = *vye
  0x4b6372		f20f1011		MOVSD_XMM 0(CX), X2	
	g = math.Sqrt(gx*gx + gy*gy + gz*gz)
  0x4b6376		0f10da			MOVUPS X2, X3		
  0x4b6379		f20f59d2		MULSD X2, X2		
  0x4b637d		0f10e2			MOVUPS X2, X4		
  0x4b6380		c4e2f1b9d1		VFMADD231SD X1, X1, X2	
	gz = *vze
  0x4b6385		f20f102f		MOVSD_XMM 0(DI), X5	
	g = math.Sqrt(gx*gx + gy*gy + gz*gz)
  0x4b6389		c4e2d1b9d5		VFMADD231SD X5, X5, X2	
  0x4b638e		f20f11542448		MOVSD_XMM X2, 0x48(SP)	
	wx = F1 * (*vxe)
  0x4b6394		f20f10350c440100	MOVSD_XMM $f64.3eeccc65fefd8fed(SB), X6	
  0x4b639c		f20f59f1		MULSD X1, X6				
  0x4b63a0		f20f11742460		MOVSD_XMM X6, 0x60(SP)			
	wy = F1 * (*vye)
  0x4b63a6		f20f103dfa430100	MOVSD_XMM $f64.3eeccc65fefd8fed(SB), X7	
  0x4b63ae		f20f59fb		MULSD X3, X7				
  0x4b63b2		f20f117c2458		MOVSD_XMM X7, 0x58(SP)			
	wz = F1 * (*vze)
  0x4b63b8		f2440f1005e7430100	MOVSD_XMM $f64.3eeccc65fefd8fed(SB), X8	
  0x4b63c1		f2440f59c5		MULSD X5, X8				
  0x4b63c6		f2440f11442450		MOVSD_XMM X8, 0x50(SP)			
	if gx == 0 {
  0x4b63cd		450f57c9		XORPS X9, X9				
  0x4b63d1		66440f2ec9		UCOMISD X1, X9				
  0x4b63d6		750f			JNE 0x4b63e7				
  0x4b63d8		7a0d			JP 0x4b63e7				
  0x4b63da		f20f100d76440100	MOVSD_XMM $f64.3ff921fb54442d18(SB), X1	
  0x4b63e2		e983000000		JMP 0x4b646a				
	gy = *vye
  0x4b63e7		f20f119c2428010000	MOVSD_XMM X3, 0x128(SP)	
	gz = *vze
  0x4b63f0		f20f11ac2420010000	MOVSD_XMM X5, 0x120(SP)	
		theta = math.Atan2(math.Sqrt(gy*gy+gz*gz), gx)
  0x4b63f9		c4e2d1b9e5		VFMADD231SD X5, X5, X4	
	return sqrt(x)
  0x4b63fe		f20f51c4		SQRTSD X4, X0		
	return atan2(y, x)
  0x4b6402		e8d9dffcff		CALL math.atan2(SB)	
	t0 = sim.Sigma[E_ELA][eindex]
  0x4b6407		488b842440010000	MOVQ 0x140(SP), AX	
	*vye = wy + F2*gy
  0x4b640f		488b8c2458010000	MOVQ 0x158(SP), CX	
	*vxe = wx + F2*gx
  0x4b6417		488b9c2450010000	MOVQ 0x150(SP), BX	
	t0 = sim.Sigma[E_ELA][eindex]
  0x4b641f		488bb42468010000	MOVQ 0x168(SP), SI	
	*vze = wz + F2*gz
  0x4b6427		488bbc2460010000	MOVQ 0x160(SP), DI	
	return sqrt(x)
  0x4b642f		f20f10542448		MOVSD_XMM 0x48(SP), X2	
	if gy == 0 {
  0x4b6435		f20f109c2428010000	MOVSD_XMM 0x128(SP), X3	
		if gz > 0 {
  0x4b643e		f20f10ac2420010000	MOVSD_XMM 0x120(SP), X5	
	*vxe = wx + F2*gx
  0x4b6447		f20f10742460		MOVSD_XMM 0x60(SP), X6	
	*vye = wy + F2*gy
  0x4b644d		f20f107c2458		MOVSD_XMM 0x58(SP), X7	
	*vze = wz + F2*gz
  0x4b6453		f2440f10442450		MOVSD_XMM 0x50(SP), X8	
  0x4b645a		450f57c9		XORPS X9, X9		
	if gy == 0 {
  0x4b645e		0f10c8			MOVUPS X0, X1		
		sim.X_e[sim.N_e] = xe // add new electron
  0x4b6461		f20f10842448010000	MOVSD_XMM 0x148(SP), X0	
	if gy == 0 {
  0x4b646a		f20f114c2468		MOVSD_XMM X1, 0x68(SP)	
  0x4b6470		66440f2ecb		UCOMISD X3, X9		
  0x4b6475		751f			JNE 0x4b6496		
  0x4b6477		7a1d			JP 0x4b6496		
		if gz > 0 {
  0x4b6479		66410f2ee9		UCOMISD X9, X5				
  0x4b647e		6690			NOPW					
  0x4b6480		760a			JBE 0x4b648c				
  0x4b6482		f20f101dce430100	MOVSD_XMM $f64.3ff921fb54442d18(SB), X3	
  0x4b648a		eb22			JMP 0x4b64ae				
  0x4b648c		f20f101de4440100	MOVSD_XMM $f64.bff921fb54442d18(SB), X3	
  0x4b6494		eb18			JMP 0x4b64ae				
		phi = math.Atan2(gz, gy)
  0x4b6496		90			NOPL			
	return atan2(y, x)
  0x4b6497		0f10c5			MOVUPS X5, X0		
  0x4b649a		0f10cb			MOVUPS X3, X1		
  0x4b649d		0f1f00			NOPL 0(AX)		
  0x4b64a0		e83bdffcff		CALL math.atan2(SB)	
	return sin(x)
  0x4b64a5		f20f104c2468		MOVSD_XMM 0x68(SP), X1	
	st = math.Sin(theta)
  0x4b64ab		0f10d8			MOVUPS X0, X3		
  0x4b64ae		f20f119c2498000000	MOVSD_XMM X3, 0x98(SP)	
	return sin(x)
  0x4b64b7		0f10c1			MOVUPS X1, X0		
  0x4b64ba		e8e1eafcff		CALL math.sin(SB)	
  0x4b64bf		f20f11842480000000	MOVSD_XMM X0, 0x80(SP)	
	ct = math.Cos(theta)
  0x4b64c8		90			NOPL			
	return cos(x)
  0x4b64c9		f20f10442468		MOVSD_XMM 0x68(SP), X0	
  0x4b64cf		e88ce8fcff		CALL math.cos(SB)	
  0x4b64d4		f20f118424c8000000	MOVSD_XMM X0, 0xc8(SP)	
	sp = math.Sin(phi)
  0x4b64dd		90			NOPL			
	return sin(x)
  0x4b64de		f20f10842498000000	MOVSD_XMM 0x98(SP), X0	
  0x4b64e7		e8b4eafcff		CALL math.sin(SB)	
  0x4b64ec		f20f11842488000000	MOVSD_XMM X0, 0x88(SP)	
	cp = math.Cos(phi)
  0x4b64f5		90			NOPL			
	return cos(x)
  0x4b64f6		f20f10842498000000	MOVSD_XMM 0x98(SP), X0	
  0x4b64ff		90			NOPL			
  0x4b6500		e85be8fcff		CALL math.cos(SB)	
	t0 = sim.Sigma[E_ELA][eindex]
  0x4b6505		488b842440010000	MOVQ 0x140(SP), AX	
  0x4b650d		8400			TESTB AL, 0(AX)		
  0x4b650f		488b8c2468010000	MOVQ 0x168(SP), CX	
  0x4b6517		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x4b6520		4881f940420f00		CMPQ CX, $0xf4240	
  0x4b6527		0f8398090000		JAE 0x4b6ec5		
	return cos(x)
  0x4b652d		f20f118424d0000000	MOVSD_XMM X0, 0xd0(SP)	
	t0 = sim.Sigma[E_ELA][eindex]
  0x4b6536		f20f1004c8		MOVSD_XMM 0(AX)(CX*8), X0	
  0x4b653b		f20f11442478		MOVSD_XMM X0, 0x78(SP)		
	t1 = t0 + sim.Sigma[E_EXC][eindex]
  0x4b6541		f20f108cc800127a00	MOVSD_XMM 0x7a1200(AX)(CX*8), X1	
  0x4b654a		f20f58c8		ADDSD X0, X1				
  0x4b654e		f20f114c2470		MOVSD_XMM X1, 0x70(SP)			
	t2 = t1 + sim.Sigma[E_ION][eindex]
  0x4b6554		f20f1084c80024f400	MOVSD_XMM 0xf42400(AX)(CX*8), X0	
  0x4b655d		f20f11842428010000	MOVSD_XMM X0, 0x128(SP)			
	rnd = sim.R01()
  0x4b6566		e835740000		CALL gopic.(*SimulationState).R01(SB)	
	t2 = t1 + sim.Sigma[E_ION][eindex]
  0x4b656b		f20f108c2428010000	MOVSD_XMM 0x128(SP), X1	
  0x4b6574		f20f10542470		MOVSD_XMM 0x70(SP), X2	
  0x4b657a		f20f58ca		ADDSD X2, X1		
	if rnd < (t0 / t2) { // elastic scattering
  0x4b657e		f20f105c2478		MOVSD_XMM 0x78(SP), X3	
  0x4b6584		f20f5ed9		DIVSD X1, X3		
	return sqrt(x)
  0x4b6588		f20f10642448		MOVSD_XMM 0x48(SP), X4	
  0x4b658e		f20f51e4		SQRTSD X4, X4		
	if rnd < (t0 / t2) { // elastic scattering
  0x4b6592		660f2ed8		UCOMISD X0, X3		
  0x4b6596		0f872a060000		JA 0x4b6bc6		
	} else if rnd < (t1 / t2) { // excitation
  0x4b659c		f20f5ed1		DIVSD X1, X2		
  0x4b65a0		660f2ed0		UCOMISD X0, X2		
  0x4b65a4		0f86bb000000		JBE 0x4b6665		
		energy = 0.5 * E_MASS * g * g
  0x4b65aa		f20f100566410100	MOVSD_XMM $f64.39a279dcc3e61461(SB), X0	
  0x4b65b2		f20f59c4		MULSD X4, X0				
  0x4b65b6		f20f59e0		MULSD X0, X4				
		energy = math.Abs(energy - E_EXC_TH*EV_TO_J) // subtract energy loss for excitation
  0x4b65ba		f20f1005a6410100	MOVSD_XMM $f64.3c40fe7ccb02e6a7(SB), X0	
  0x4b65c2		f20f5ce0		SUBSD X0, X4				
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x4b65c6		66480f7ee1		MOVQ X4, CX		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x4b65cb		480fbaf13f		BTRQ $0x3f, CX		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x4b65d0		66480f6ec1		MOVQ CX, X0		
		g = math.Sqrt(2.0 * energy / E_MASS)         // relative velocity after energy loss
  0x4b65d5		f20f58c0		ADDSD X0, X0				
  0x4b65d9		f20f100d3f410100	MOVSD_XMM $f64.39b279dcc3e61461(SB), X1	
  0x4b65e1		f20f5ec1		DIVSD X1, X0				
  0x4b65e5		f20f11442440		MOVSD_XMM X0, 0x40(SP)			
		chi = math.Acos(1.0 - 2.0*sim.R01())         // isotropic scattering
  0x4b65eb		488b842440010000	MOVQ 0x140(SP), AX			
  0x4b65f3		e8a8730000		CALL gopic.(*SimulationState).R01(SB)	
  0x4b65f8		f20f58c0		ADDSD X0, X0				
  0x4b65fc		f20f100d34420100	MOVSD_XMM $f64.3ff0000000000000(SB), X1	
  0x4b6604		f20f5cc8		SUBSD X0, X1				
	return sqrt(x)
  0x4b6608		f20f10442440		MOVSD_XMM 0x40(SP), X0	
  0x4b660e		f20f51c0		SQRTSD X0, X0		
  0x4b6612		f20f118424a8000000	MOVSD_XMM X0, 0xa8(SP)	
	return acos(x)
  0x4b661b		90			NOPL			
	return asin(x)
  0x4b661c		0f10c1			MOVUPS X1, X0		
  0x4b661f		90			NOPL			
  0x4b6620		e8fbd9fcff		CALL math.asin(SB)	
  0x4b6625		f20f11442418		MOVSD_XMM X0, 0x18(SP)	
		eta = TWO_PI * sim.R01()                     // azimuthal angle
  0x4b662b		488b842440010000	MOVQ 0x140(SP), AX			
  0x4b6633		e868730000		CALL gopic.(*SimulationState).R01(SB)	
  0x4b6638		f20f100d80420100	MOVSD_XMM $f64.401921fb54442d18(SB), X1	
  0x4b6640		f20f59c1		MULSD X1, X0				
	return Pi/2 - Asin(x)
  0x4b6644		f20f100d0c420100	MOVSD_XMM $f64.3ff921fb54442d18(SB), X1	
  0x4b664c		f20f10542418		MOVSD_XMM 0x18(SP), X2			
  0x4b6652		f20f5cca		SUBSD X2, X1				
  0x4b6656		f20f109424a8000000	MOVSD_XMM 0xa8(SP), X2			
  0x4b665f		90			NOPL					
		eta = TWO_PI * sim.R01()                     // azimuthal angle
  0x4b6660		e9ca050000		JMP 0x4b6c2f		
		energy = 0.5 * E_MASS * g * g
  0x4b6665		f20f1005ab400100	MOVSD_XMM $f64.39a279dcc3e61461(SB), X0	
  0x4b666d		f20f59c4		MULSD X4, X0				
  0x4b6671		f20f59e0		MULSD X0, X4				
		energy = math.Abs(energy - E_ION_TH*EV_TO_J)                               // subtract energy loss of ionization
  0x4b6675		f20f1005f3400100	MOVSD_XMM $f64.3c475931051c7900(SB), X0	
  0x4b667d		f20f5ce0		SUBSD X0, X4				
		gy = g2 * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b6681		f20f108424d0000000	MOVSD_XMM 0xd0(SP), X0	
  0x4b668a		f20f108c2480000000	MOVSD_XMM 0x80(SP), X1	
  0x4b6693		0f10d0			MOVUPS X0, X2		
  0x4b6696		f20f59c1		MULSD X1, X0		
  0x4b669a		f20f11842428010000	MOVSD_XMM X0, 0x128(SP)	
  0x4b66a3		f20f108424c8000000	MOVSD_XMM 0xc8(SP), X0	
  0x4b66ac		f20f59d0		MULSD X0, X2		
  0x4b66b0		f20f11942420010000	MOVSD_XMM X2, 0x120(SP)	
		gz = g2 * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4b66b9		f20f10942488000000	MOVSD_XMM 0x88(SP), X2	
  0x4b66c2		0f10da			MOVUPS X2, X3		
  0x4b66c5		f20f59d1		MULSD X1, X2		
  0x4b66c9		f20f11942418010000	MOVSD_XMM X2, 0x118(SP)	
  0x4b66d2		f20f59d8		MULSD X0, X3		
  0x4b66d6		f20f119c2410010000	MOVSD_XMM X3, 0x110(SP)	
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x4b66df		66480f7ee1		MOVQ X4, CX		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x4b66e4		480fbaf13f		BTRQ $0x3f, CX		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x4b66e9		66480f6ec1		MOVQ CX, X0		
  0x4b66ee		f20f118424c0000000	MOVSD_XMM X0, 0xc0(SP)	
		e_ej = 10.0 * math.Tan(sim.R01()*math.Atan(energy/EV_TO_J/20.0)) * EV_TO_J // energy of the ejected electron
  0x4b66f7		f20f100d49400100	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X1	
  0x4b66ff		f20f5ec1		DIVSD X1, X0				
  0x4b6703		f20f100de5410100	MOVSD_XMM $f64.4034000000000000(SB), X1	
  0x4b670b		f20f5ec1		DIVSD X1, X0				
  0x4b670f		f20f11442438		MOVSD_XMM X0, 0x38(SP)			
  0x4b6715		488b842440010000	MOVQ 0x140(SP), AX			
  0x4b671d		0f1f00			NOPL 0(AX)				
  0x4b6720		e87b720000		CALL gopic.(*SimulationState).R01(SB)	
  0x4b6725		f20f11842408010000	MOVSD_XMM X0, 0x108(SP)			
	return atan(x)
  0x4b672e		f20f10442438		MOVSD_XMM 0x38(SP), X0	
  0x4b6734		e827dcfcff		CALL math.atan(SB)	
		e_ej = 10.0 * math.Tan(sim.R01()*math.Atan(energy/EV_TO_J/20.0)) * EV_TO_J // energy of the ejected electron
  0x4b6739		f20f108c2408010000	MOVSD_XMM 0x108(SP), X1	
  0x4b6742		f20f59c1		MULSD X1, X0		
	return tan(x)
  0x4b6746		e8d5eafcff		CALL math.tan(SB)	
		e_ej = 10.0 * math.Tan(sim.R01()*math.Atan(energy/EV_TO_J/20.0)) * EV_TO_J // energy of the ejected electron
  0x4b674b		f20f100dad3f0100	MOVSD_XMM 0x13fad(IP), X1		
  0x4b6753		f20f59c8		MULSD X0, X1				
  0x4b6757		f20f1005e93f0100	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X0	
  0x4b675f		f20f59c1		MULSD X1, X0				
		e_sc = math.Abs(energy - e_ej)                                             // energy of scattered electron after the collision
  0x4b6763		f20f109424c0000000	MOVSD_XMM 0xc0(SP), X2	
  0x4b676c		0f10da			MOVUPS X2, X3		
  0x4b676f		f20f5cd0		SUBSD X0, X2		
		g2 = math.Sqrt(2.0 * e_ej / E_MASS)                                        // relative velocity of ejected electron
  0x4b6773		f20f1025cd3f0100	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X4	
  0x4b677b		0f10e8			MOVUPS X0, X5				
  0x4b677e		c4e2d9b9c1		VFMADD231SD X1, X4, X0			
  0x4b6783		f20f100d953f0100	MOVSD_XMM $f64.39b279dcc3e61461(SB), X1	
  0x4b678b		f20f5ec1		DIVSD X1, X0				
		chi2 = math.Acos(math.Sqrt(e_ej / energy))                                 // scattering angle for ejected electrons
  0x4b678f		f20f5eeb		DIVSD X3, X5		
	return sqrt(x)
  0x4b6793		f20f51c0		SQRTSD X0, X0		
  0x4b6797		f20f118424a0000000	MOVSD_XMM X0, 0xa0(SP)	
  0x4b67a0		f20f51c5		SQRTSD X5, X0		
  0x4b67a4		f20f11442428		MOVSD_XMM X0, 0x28(SP)	
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x4b67aa		66480f7ed1		MOVQ X2, CX		
	return Float64frombits(Float64bits(x) &^ signMask)
  0x4b67af		480fbaf13f		BTRQ $0x3f, CX		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x4b67b4		66480f6ec1		MOVQ CX, X0		
		g = math.Sqrt(2.0 * e_sc / E_MASS)                                         // relative velocity of scattered electron
  0x4b67b9		0f10d0			MOVUPS X0, X2		
  0x4b67bc		f20f58c0		ADDSD X0, X0		
		chi = math.Acos(math.Sqrt(e_sc / energy))                                  // scattering angle for scattered electron
  0x4b67c0		f20f5ed3		DIVSD X3, X2		
	return sqrt(x)
  0x4b67c4		f20f51d2		SQRTSD X2, X2		
		g = math.Sqrt(2.0 * e_sc / E_MASS)                                         // relative velocity of scattered electron
  0x4b67c8		f20f5ec1		DIVSD X1, X0		
  0x4b67cc		f20f11442430		MOVSD_XMM X0, 0x30(SP)	
	return acos(x)
  0x4b67d2		90			NOPL			
	return asin(x)
  0x4b67d3		0f10c2			MOVUPS X2, X0		
  0x4b67d6		e845d8fcff		CALL math.asin(SB)	
	return acos(x)
  0x4b67db		90			NOPL			
	return Pi/2 - Asin(x)
  0x4b67dc		f20f100d74400100	MOVSD_XMM $f64.3ff921fb54442d18(SB), X1	
  0x4b67e4		f20f5cc8		SUBSD X0, X1				
  0x4b67e8		f20f118c24e0000000	MOVSD_XMM X1, 0xe0(SP)			
	return asin(x)
  0x4b67f1		f20f10442428		MOVSD_XMM 0x28(SP), X0	
  0x4b67f7		e824d8fcff		CALL math.asin(SB)	
  0x4b67fc		f20f11442410		MOVSD_XMM X0, 0x10(SP)	
		eta = TWO_PI * sim.R01()                                                   // azimuthal angle for scattered electron
  0x4b6802		488b842440010000	MOVQ 0x140(SP), AX			
  0x4b680a		e891710000		CALL gopic.(*SimulationState).R01(SB)	
		eta2 = eta + PI                                                            // azimuthal angle for ejected electron
  0x4b680f		f20f100d71400100	MOVSD_XMM $f64.400921fb54442d18(SB), X1	
  0x4b6817		f20f1015a1400100	MOVSD_XMM $f64.401921fb54442d18(SB), X2	
  0x4b681f		c4e2f9b9ca		VFMADD231SD X2, X0, X1			
  0x4b6824		f20f118c24b0000000	MOVSD_XMM X1, 0xb0(SP)			
	return Pi/2 - Asin(x)
  0x4b682d		f20f100d23400100	MOVSD_XMM $f64.3ff921fb54442d18(SB), X1	
  0x4b6835		f20f105c2410		MOVSD_XMM 0x10(SP), X3			
  0x4b683b		f20f5ccb		SUBSD X3, X1				
  0x4b683f		f20f118c24d8000000	MOVSD_XMM X1, 0xd8(SP)			
		eta = TWO_PI * sim.R01()                                                   // azimuthal angle for scattered electron
  0x4b6848		f20f59c2		MULSD X2, X0		
  0x4b684c		f20f118424b8000000	MOVSD_XMM X0, 0xb8(SP)	
		sc = math.Sin(chi2)
  0x4b6855		90			NOPL			
	return sin(x)
  0x4b6856		0f10c1			MOVUPS X1, X0		
  0x4b6859		e842e7fcff		CALL math.sin(SB)	
		gx = g2 * (ct*cc - st*sc*ce)
  0x4b685e		f20f108c2480000000	MOVSD_XMM 0x80(SP), X1	
  0x4b6867		0f10d0			MOVUPS X0, X2		
  0x4b686a		f20f59c1		MULSD X1, X0		
  0x4b686e		f20f11842408010000	MOVSD_XMM X0, 0x108(SP)	
		gy = g2 * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b6877		f20f10842420010000	MOVSD_XMM 0x120(SP), X0	
  0x4b6880		f20f59c2		MULSD X2, X0		
  0x4b6884		f20f11842420010000	MOVSD_XMM X0, 0x120(SP)	
  0x4b688d		f20f10842488000000	MOVSD_XMM 0x88(SP), X0	
  0x4b6896		0f10ca			MOVUPS X2, X1		
  0x4b6899		f20f59d0		MULSD X0, X2		
  0x4b689d		f20f11942400010000	MOVSD_XMM X2, 0x100(SP)	
		gz = g2 * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4b68a6		f20f10842410010000	MOVSD_XMM 0x110(SP), X0	
  0x4b68af		f20f59c1		MULSD X1, X0		
  0x4b68b3		f20f11842410010000	MOVSD_XMM X0, 0x110(SP)	
  0x4b68bc		f20f108424d0000000	MOVSD_XMM 0xd0(SP), X0	
  0x4b68c5		f20f59c8		MULSD X0, X1		
  0x4b68c9		f20f118c24f8000000	MOVSD_XMM X1, 0xf8(SP)	
		cc = math.Cos(chi2)
  0x4b68d2		90			NOPL			
	return cos(x)
  0x4b68d3		f20f108424d8000000	MOVSD_XMM 0xd8(SP), X0	
  0x4b68dc		0f1f4000		NOPL 0(AX)		
  0x4b68e0		e87be4fcff		CALL math.cos(SB)	
		gx = g2 * (ct*cc - st*sc*ce)
  0x4b68e5		f20f108c24c8000000	MOVSD_XMM 0xc8(SP), X1	
  0x4b68ee		0f10d0			MOVUPS X0, X2		
  0x4b68f1		f20f59c1		MULSD X1, X0		
  0x4b68f5		f20f118424f0000000	MOVSD_XMM X0, 0xf0(SP)	
		gy = g2 * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b68fe		f20f10842428010000	MOVSD_XMM 0x128(SP), X0	
  0x4b6907		f20f59c2		MULSD X2, X0		
  0x4b690b		f20f11842428010000	MOVSD_XMM X0, 0x128(SP)	
		gz = g2 * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4b6914		f20f10842418010000	MOVSD_XMM 0x118(SP), X0	
  0x4b691d		f20f59d0		MULSD X0, X2		
  0x4b6921		f20f11942418010000	MOVSD_XMM X2, 0x118(SP)	
		se = math.Sin(eta2)
  0x4b692a		90			NOPL			
	return sin(x)
  0x4b692b		f20f108424b0000000	MOVSD_XMM 0xb0(SP), X0	
  0x4b6934		e867e6fcff		CALL math.sin(SB)	
  0x4b6939		f20f11842490000000	MOVSD_XMM X0, 0x90(SP)	
		gy = g2 * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b6942		f20f108c2400010000	MOVSD_XMM 0x100(SP), X1	
  0x4b694b		f20f59c8		MULSD X0, X1		
  0x4b694f		f20f118c2400010000	MOVSD_XMM X1, 0x100(SP)	
		ce = math.Cos(eta2)
  0x4b6958		90			NOPL			
	return cos(x)
  0x4b6959		f20f108424b0000000	MOVSD_XMM 0xb0(SP), X0	
  0x4b6962		e8f9e3fcff		CALL math.cos(SB)	
		gx = g2 * (ct*cc - st*sc*ce)
  0x4b6967		f20f108c2408010000	MOVSD_XMM 0x108(SP), X1	
  0x4b6970		f20f59c8		MULSD X0, X1		
  0x4b6974		f20f109424f0000000	MOVSD_XMM 0xf0(SP), X2	
  0x4b697d		f20f5cd1		SUBSD X1, X2		
		gy = g2 * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b6981		f20f108c2428010000	MOVSD_XMM 0x128(SP), X1	
  0x4b698a		f20f109c2420010000	MOVSD_XMM 0x120(SP), X3	
  0x4b6993		c4e2e1b9c8		VFMADD231SD X0, X3, X1	
  0x4b6998		f20f109c2400010000	MOVSD_XMM 0x100(SP), X3	
  0x4b69a1		f20f5ccb		SUBSD X3, X1		
		gz = g2 * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4b69a5		f20f109c2418010000	MOVSD_XMM 0x118(SP), X3	
  0x4b69ae		f20f10a42410010000	MOVSD_XMM 0x110(SP), X4	
  0x4b69b7		c4e2d9b9d8		VFMADD231SD X0, X4, X3	
  0x4b69bc		f20f108424f8000000	MOVSD_XMM 0xf8(SP), X0	
  0x4b69c5		f20f10a42490000000	MOVSD_XMM 0x90(SP), X4	
  0x4b69ce		c4e2f9b9dc		VFMADD231SD X4, X0, X3	
		sim.X_e[sim.N_e] = xe // add new electron
  0x4b69d3		488b8c2440010000	MOVQ 0x140(SP), CX	
  0x4b69db		488b91007e5603		MOVQ 0x3567e00(CX), DX	
		gx = g2 * (ct*cc - st*sc*ce)
  0x4b69e2		f20f108424a0000000	MOVSD_XMM 0xa0(SP), X0	
  0x4b69eb		f20f59d0		MULSD X0, X2		
		gy = g2 * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b69ef		f20f59c8		MULSD X0, X1		
		gz = g2 * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4b69f3		f20f59c3		MULSD X3, X0		
  0x4b69f7		660f1f840000000000	NOPW 0(AX)(AX*1)	
		sim.X_e[sim.N_e] = xe // add new electron
  0x4b6a00		4881fa40420f00		CMPQ DX, $0xf4240			
  0x4b6a07		0f83ac040000		JAE 0x4b6eb9				
  0x4b6a0d		f20f109c2448010000	MOVSD_XMM 0x148(SP), X3			
  0x4b6a16		f20f119cd1107e5603	MOVSD_XMM X3, 0x3567e10(CX)(DX*8)	
		sim.Vx_e[sim.N_e] = wx + F2*gx
  0x4b6a1f		488b91007e5603		MOVQ 0x3567e00(CX), DX			
  0x4b6a26		f20f10642460		MOVSD_XMM 0x60(SP), X4			
  0x4b6a2c		f20f102dfc3d0100	MOVSD_XMM $f64.3fefffe3339a0103(SB), X5	
  0x4b6a34		c4e2d1b9e2		VFMADD231SD X2, X5, X4			
  0x4b6a39		0f1f8000000000		NOPL 0(AX)				
  0x4b6a40		4881fa40420f00		CMPQ DX, $0xf4240			
  0x4b6a47		0f8362040000		JAE 0x4b6eaf				
  0x4b6a4d		f20f11a4d11090d003	MOVSD_XMM X4, 0x3d09010(CX)(DX*8)	
		sim.Vy_e[sim.N_e] = wy + F2*gy
  0x4b6a56		488b91007e5603		MOVQ 0x3567e00(CX), DX			
  0x4b6a5d		f20f10542458		MOVSD_XMM 0x58(SP), X2			
  0x4b6a63		c4e2d1b9d1		VFMADD231SD X1, X5, X2			
  0x4b6a68		4881fa40420f00		CMPQ DX, $0xf4240			
  0x4b6a6f		0f8330040000		JAE 0x4b6ea5				
  0x4b6a75		f20f1194d110a24a04	MOVSD_XMM X2, 0x44aa210(CX)(DX*8)	
		sim.Vz_e[sim.N_e] = wz + F2*gz
  0x4b6a7e		488b91007e5603		MOVQ 0x3567e00(CX), DX			
  0x4b6a85		f20f104c2450		MOVSD_XMM 0x50(SP), X1			
  0x4b6a8b		c4e2d1b9c8		VFMADD231SD X0, X5, X1			
  0x4b6a90		4881fa40420f00		CMPQ DX, $0xf4240			
  0x4b6a97		0f83fc030000		JAE 0x4b6e99				
  0x4b6a9d		f20f118cd110b4c404	MOVSD_XMM X1, 0x4c4b410(CX)(DX*8)	
		sim.N_e++
  0x4b6aa6		48ff81007e5603		INCQ 0x3567e00(CX)	
		sim.X_i[sim.N_i] = xe         // add new ion
  0x4b6aad		488b91087e5603		MOVQ 0x3567e08(CX), DX			
  0x4b6ab4		660f1f840000000000	NOPW 0(AX)(AX*1)			
  0x4b6abd		0f1f00			NOPL 0(AX)				
  0x4b6ac0		4881fa40420f00		CMPQ DX, $0xf4240			
  0x4b6ac7		0f83c2030000		JAE 0x4b6e8f				
  0x4b6acd		f20f119cd110c63e05	MOVSD_XMM X3, 0x53ec610(CX)(DX*8)	
	return sim.Rng.NormFloat64() * RMB_sigma
  0x4b6ad6		488b81a820ba07		MOVQ 0x7ba20a8(CX), AX			
  0x4b6add		0f1f00			NOPL 0(AX)				
  0x4b6ae0		e8dbebffff		CALL math/rand.(*Rand).NormFloat64(SB)	
		sim.Vx_i[sim.N_i] = sim.RMB() // velocity is sampled from background thermal distribution
  0x4b6ae5		488b8c2440010000	MOVQ 0x140(SP), CX	
  0x4b6aed		488b91087e5603		MOVQ 0x3567e08(CX), DX	
  0x4b6af4		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x4b6afd		0f1f00			NOPL 0(AX)		
  0x4b6b00		4881fa40420f00		CMPQ DX, $0xf4240	
  0x4b6b07		0f8378030000		JAE 0x4b6e85		
	return sim.Rng.NormFloat64() * RMB_sigma
  0x4b6b0d		f20f590503111300	MULSD gopic.RMB_sigma(SB), X0	
		sim.Vx_i[sim.N_i] = sim.RMB() // velocity is sampled from background thermal distribution
  0x4b6b15		f20f1184d110d8b805	MOVSD_XMM X0, 0x5b8d810(CX)(DX*8)	
	return sim.Rng.NormFloat64() * RMB_sigma
  0x4b6b1e		488b81a820ba07		MOVQ 0x7ba20a8(CX), AX			
  0x4b6b25		e896ebffff		CALL math/rand.(*Rand).NormFloat64(SB)	
		sim.Vy_i[sim.N_i] = sim.RMB()
  0x4b6b2a		488b8c2440010000	MOVQ 0x140(SP), CX	
  0x4b6b32		488b91087e5603		MOVQ 0x3567e08(CX), DX	
  0x4b6b39		0f1f8000000000		NOPL 0(AX)		
  0x4b6b40		4881fa40420f00		CMPQ DX, $0xf4240	
  0x4b6b47		0f832e030000		JAE 0x4b6e7b		
	return sim.Rng.NormFloat64() * RMB_sigma
  0x4b6b4d		f20f5905c3101300	MULSD gopic.RMB_sigma(SB), X0	
		sim.Vy_i[sim.N_i] = sim.RMB()
  0x4b6b55		f20f1184d110ea3206	MOVSD_XMM X0, 0x632ea10(CX)(DX*8)	
	return sim.Rng.NormFloat64() * RMB_sigma
  0x4b6b5e		488b81a820ba07		MOVQ 0x7ba20a8(CX), AX			
  0x4b6b65		e856ebffff		CALL math/rand.(*Rand).NormFloat64(SB)	
		sim.Vz_i[sim.N_i] = sim.RMB()
  0x4b6b6a		488b8c2440010000	MOVQ 0x140(SP), CX	
  0x4b6b72		488b91087e5603		MOVQ 0x3567e08(CX), DX	
  0x4b6b79		0f1f8000000000		NOPL 0(AX)		
  0x4b6b80		4881fa40420f00		CMPQ DX, $0xf4240	
  0x4b6b87		0f83e4020000		JAE 0x4b6e71		
	return sim.Rng.NormFloat64() * RMB_sigma
  0x4b6b8d		f20f590583101300	MULSD gopic.RMB_sigma(SB), X0	
		sim.Vz_i[sim.N_i] = sim.RMB()
  0x4b6b95		f20f1184d110fcac06	MOVSD_XMM X0, 0x6acfc10(CX)(DX*8)	
		sim.N_i++
  0x4b6b9e		48ff81087e5603		INCQ 0x3567e08(CX)	
	return sqrt(x)
  0x4b6ba5		f20f10542430		MOVSD_XMM 0x30(SP), X2	
  0x4b6bab		f20f51c2		SQRTSD X2, X0		
  0x4b6baf		0f10d0			MOVUPS X0, X2		
  0x4b6bb2		f20f108424b8000000	MOVSD_XMM 0xb8(SP), X0	
  0x4b6bbb		f20f108c24e0000000	MOVSD_XMM 0xe0(SP), X1	
		sim.N_i++
  0x4b6bc4		eb69			JMP 0x4b6c2f		
	return sqrt(x)
  0x4b6bc6		f20f11a424a8000000	MOVSD_XMM X4, 0xa8(SP)	
		chi = math.Acos(1.0 - 2.0*sim.R01()) // isotropic scattering
  0x4b6bcf		488b842440010000	MOVQ 0x140(SP), AX			
  0x4b6bd7		e8c46d0000		CALL gopic.(*SimulationState).R01(SB)	
  0x4b6bdc		f20f58c0		ADDSD X0, X0				
  0x4b6be0		f20f100d503c0100	MOVSD_XMM $f64.3ff0000000000000(SB), X1	
  0x4b6be8		f20f5cc8		SUBSD X0, X1				
	return acos(x)
  0x4b6bec		90			NOPL			
	return asin(x)
  0x4b6bed		0f10c1			MOVUPS X1, X0		
  0x4b6bf0		e82bd4fcff		CALL math.asin(SB)	
  0x4b6bf5		f20f11442420		MOVSD_XMM X0, 0x20(SP)	
		eta = TWO_PI * sim.R01()             // azimuthal angle
  0x4b6bfb		488b842440010000	MOVQ 0x140(SP), AX			
  0x4b6c03		e8986d0000		CALL gopic.(*SimulationState).R01(SB)	
  0x4b6c08		f20f100db03c0100	MOVSD_XMM $f64.401921fb54442d18(SB), X1	
  0x4b6c10		f20f59c1		MULSD X1, X0				
	return Pi/2 - Asin(x)
  0x4b6c14		f20f100d3c3c0100	MOVSD_XMM $f64.3ff921fb54442d18(SB), X1	
  0x4b6c1c		f20f10542420		MOVSD_XMM 0x20(SP), X2			
  0x4b6c22		f20f5cca		SUBSD X2, X1				
	sc = math.Sin(chi)
  0x4b6c26		f20f109424a8000000	MOVSD_XMM 0xa8(SP), X2	
  0x4b6c2f		f20f118c24e0000000	MOVSD_XMM X1, 0xe0(SP)	
  0x4b6c38		f20f119424a8000000	MOVSD_XMM X2, 0xa8(SP)	
  0x4b6c41		f20f118424b8000000	MOVSD_XMM X0, 0xb8(SP)	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b6c4a		f20f109424d0000000	MOVSD_XMM 0xd0(SP), X2	
  0x4b6c53		f20f109c2480000000	MOVSD_XMM 0x80(SP), X3	
  0x4b6c5c		0f10e2			MOVUPS X2, X4		
  0x4b6c5f		f20f59d3		MULSD X3, X2		
  0x4b6c63		f20f11942428010000	MOVSD_XMM X2, 0x128(SP)	
  0x4b6c6c		f20f109424c8000000	MOVSD_XMM 0xc8(SP), X2	
  0x4b6c75		f20f59e2		MULSD X2, X4		
  0x4b6c79		f20f11a42420010000	MOVSD_XMM X4, 0x120(SP)	
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4b6c82		f20f10a42488000000	MOVSD_XMM 0x88(SP), X4	
  0x4b6c8b		0f10ec			MOVUPS X4, X5		
  0x4b6c8e		f20f59e3		MULSD X3, X4		
  0x4b6c92		f20f11a42418010000	MOVSD_XMM X4, 0x118(SP)	
  0x4b6c9b		f20f59ea		MULSD X2, X5		
  0x4b6c9f		f20f11ac2410010000	MOVSD_XMM X5, 0x110(SP)	
	return sin(x)
  0x4b6ca8		0f10c1			MOVUPS X1, X0		
  0x4b6cab		e8f0e2fcff		CALL math.sin(SB)	
	gx = g * (ct*cc - st*sc*ce)
  0x4b6cb0		f20f108c2480000000	MOVSD_XMM 0x80(SP), X1	
  0x4b6cb9		f20f59c8		MULSD X0, X1		
  0x4b6cbd		f20f118c2408010000	MOVSD_XMM X1, 0x108(SP)	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b6cc6		f20f108c2420010000	MOVSD_XMM 0x120(SP), X1	
  0x4b6ccf		f20f59c8		MULSD X0, X1		
  0x4b6cd3		f20f118c2420010000	MOVSD_XMM X1, 0x120(SP)	
  0x4b6cdc		f20f108c2488000000	MOVSD_XMM 0x88(SP), X1	
  0x4b6ce5		f20f59c8		MULSD X0, X1		
  0x4b6ce9		f20f118c2400010000	MOVSD_XMM X1, 0x100(SP)	
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4b6cf2		f20f108c2410010000	MOVSD_XMM 0x110(SP), X1	
  0x4b6cfb		f20f59c8		MULSD X0, X1		
  0x4b6cff		f20f118c2410010000	MOVSD_XMM X1, 0x110(SP)	
  0x4b6d08		f20f108c24d0000000	MOVSD_XMM 0xd0(SP), X1	
  0x4b6d11		f20f59c1		MULSD X1, X0		
  0x4b6d15		f20f118424f8000000	MOVSD_XMM X0, 0xf8(SP)	
	cc = math.Cos(chi)
  0x4b6d1e		90			NOPL			
	return cos(x)
  0x4b6d1f		f20f108424e0000000	MOVSD_XMM 0xe0(SP), X0	
  0x4b6d28		e833e0fcff		CALL math.cos(SB)	
  0x4b6d2d		f20f118424e8000000	MOVSD_XMM X0, 0xe8(SP)	
	gx = g * (ct*cc - st*sc*ce)
  0x4b6d36		f20f108c24c8000000	MOVSD_XMM 0xc8(SP), X1	
  0x4b6d3f		f20f59c8		MULSD X0, X1		
  0x4b6d43		f20f118c24f0000000	MOVSD_XMM X1, 0xf0(SP)	
	se = math.Sin(eta)
  0x4b6d4c		90			NOPL			
	return sin(x)
  0x4b6d4d		f20f108424b8000000	MOVSD_XMM 0xb8(SP), X0	
  0x4b6d56		e845e2fcff		CALL math.sin(SB)	
  0x4b6d5b		f20f11842490000000	MOVSD_XMM X0, 0x90(SP)	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b6d64		f20f108c2400010000	MOVSD_XMM 0x100(SP), X1	
  0x4b6d6d		f20f59c8		MULSD X0, X1		
  0x4b6d71		f20f118c2400010000	MOVSD_XMM X1, 0x100(SP)	
	ce = math.Cos(eta)
  0x4b6d7a		90			NOPL			
	return cos(x)
  0x4b6d7b		f20f108424b8000000	MOVSD_XMM 0xb8(SP), X0	
  0x4b6d84		e8d7dffcff		CALL math.cos(SB)	
	gx = g * (ct*cc - st*sc*ce)
  0x4b6d89		f20f108c2408010000	MOVSD_XMM 0x108(SP), X1	
  0x4b6d92		f20f59c8		MULSD X0, X1		
  0x4b6d96		f20f109424f0000000	MOVSD_XMM 0xf0(SP), X2	
  0x4b6d9f		f20f5cd1		SUBSD X1, X2		
  0x4b6da3		f20f108c24a8000000	MOVSD_XMM 0xa8(SP), X1	
  0x4b6dac		f20f59d1		MULSD X1, X2		
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b6db0		f20f109c2420010000	MOVSD_XMM 0x120(SP), X3	
  0x4b6db9		f20f59d8		MULSD X0, X3		
  0x4b6dbd		f20f10a424e8000000	MOVSD_XMM 0xe8(SP), X4	
  0x4b6dc6		f20f10ac2428010000	MOVSD_XMM 0x128(SP), X5	
  0x4b6dcf		c4e2d9b9dd		VFMADD231SD X5, X4, X3	
  0x4b6dd4		f20f10ac2400010000	MOVSD_XMM 0x100(SP), X5	
  0x4b6ddd		f20f5cdd		SUBSD X5, X3		
  0x4b6de1		f20f59d9		MULSD X1, X3		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4b6de5		f20f10ac2410010000	MOVSD_XMM 0x110(SP), X5	
  0x4b6dee		f20f59e8		MULSD X0, X5		
  0x4b6df2		f20f10b42418010000	MOVSD_XMM 0x118(SP), X6	
  0x4b6dfb		c4e2d9b9ee		VFMADD231SD X6, X4, X5	
  0x4b6e00		f20f10a424f8000000	MOVSD_XMM 0xf8(SP), X4	
  0x4b6e09		f20f10b42490000000	MOVSD_XMM 0x90(SP), X6	
  0x4b6e12		c4e2d9b9ee		VFMADD231SD X6, X4, X5	
  0x4b6e17		f20f59cd		MULSD X5, X1		
	*vxe = wx + F2*gx
  0x4b6e1b		f20f10642460		MOVSD_XMM 0x60(SP), X4			
  0x4b6e21		f20f102d073a0100	MOVSD_XMM $f64.3fefffe3339a0103(SB), X5	
  0x4b6e29		c4e2e9b9e5		VFMADD231SD X5, X2, X4			
  0x4b6e2e		488b842450010000	MOVQ 0x150(SP), AX			
  0x4b6e36		f20f1120		MOVSD_XMM X4, 0(AX)			
	*vye = wy + F2*gy
  0x4b6e3a		f20f10542458		MOVSD_XMM 0x58(SP), X2	
  0x4b6e40		c4e2e1b9d5		VFMADD231SD X5, X3, X2	
  0x4b6e45		488b842458010000	MOVQ 0x158(SP), AX	
  0x4b6e4d		f20f1110		MOVSD_XMM X2, 0(AX)	
	*vze = wz + F2*gz
  0x4b6e51		f20f10542450		MOVSD_XMM 0x50(SP), X2	
  0x4b6e57		c4e2f1b9d5		VFMADD231SD X5, X1, X2	
  0x4b6e5c		488b842460010000	MOVQ 0x160(SP), AX	
  0x4b6e64		f20f1110		MOVSD_XMM X2, 0(AX)	
}
  0x4b6e68		4881c430010000		ADDQ $0x130, SP		
  0x4b6e6f		5d			POPQ BP			
  0x4b6e70		c3			RET			
		sim.Vz_i[sim.N_i] = sim.RMB()
  0x4b6e71		b840420f00		MOVL $0xf4240, AX		
  0x4b6e76		e885a8fcff		CALL runtime.panicBounds(SB)	
		sim.Vy_i[sim.N_i] = sim.RMB()
  0x4b6e7b		b840420f00		MOVL $0xf4240, AX		
  0x4b6e80		e87ba8fcff		CALL runtime.panicBounds(SB)	
		sim.Vx_i[sim.N_i] = sim.RMB() // velocity is sampled from background thermal distribution
  0x4b6e85		b840420f00		MOVL $0xf4240, AX		
  0x4b6e8a		e871a8fcff		CALL runtime.panicBounds(SB)	
		sim.X_i[sim.N_i] = xe         // add new ion
  0x4b6e8f		b840420f00		MOVL $0xf4240, AX		
  0x4b6e94		e867a8fcff		CALL runtime.panicBounds(SB)	
		sim.Vz_e[sim.N_e] = wz + F2*gz
  0x4b6e99		b840420f00		MOVL $0xf4240, AX		
  0x4b6e9e		6690			NOPW				
  0x4b6ea0		e85ba8fcff		CALL runtime.panicBounds(SB)	
		sim.Vy_e[sim.N_e] = wy + F2*gy
  0x4b6ea5		b840420f00		MOVL $0xf4240, AX		
  0x4b6eaa		e851a8fcff		CALL runtime.panicBounds(SB)	
		sim.Vx_e[sim.N_e] = wx + F2*gx
  0x4b6eaf		b840420f00		MOVL $0xf4240, AX		
  0x4b6eb4		e847a8fcff		CALL runtime.panicBounds(SB)	
		sim.X_e[sim.N_e] = xe // add new electron
  0x4b6eb9		b840420f00		MOVL $0xf4240, AX		
  0x4b6ebe		6690			NOPW				
  0x4b6ec0		e83ba8fcff		CALL runtime.panicBounds(SB)	
	t0 = sim.Sigma[E_ELA][eindex]
  0x4b6ec5		b840420f00		MOVL $0xf4240, AX		
  0x4b6eca		e831a8fcff		CALL runtime.panicBounds(SB)	
  0x4b6ecf		90			NOPL				
func (sim *SimulationState) CollisionElectron(xe float64, vxe, vye, vze *float64, eindex int) {
  0x4b6ed0		4889442408		MOVQ AX, 0x8(SP)					
  0x4b6ed5		f20f11442410		MOVSD_XMM X0, 0x10(SP)					
  0x4b6edb		48895c2418		MOVQ BX, 0x18(SP)					
  0x4b6ee0		48894c2420		MOVQ CX, 0x20(SP)					
  0x4b6ee5		48897c2428		MOVQ DI, 0x28(SP)					
  0x4b6eea		4889742430		MOVQ SI, 0x30(SP)					
  0x4b6eef		e8cc8bfcff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x4b6ef4		488b442408		MOVQ 0x8(SP), AX					
  0x4b6ef9		f20f10442410		MOVSD_XMM 0x10(SP), X0					
  0x4b6eff		488b5c2418		MOVQ 0x18(SP), BX					
  0x4b6f04		488b4c2420		MOVQ 0x20(SP), CX					
  0x4b6f09		488b7c2428		MOVQ 0x28(SP), DI					
  0x4b6f0e		488b742430		MOVQ 0x30(SP), SI					
  0x4b6f13		e908f4ffff		JMP gopic.(*SimulationState).CollisionElectron(SB)	


