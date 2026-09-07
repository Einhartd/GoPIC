// --- Symbol: CollisionIon ---
TEXT gopic.(*SimulationState).CollisionIon(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/collisions.go
func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int) {
  0x4b6f20		4c8d6424c8		LEAQ -0x38(SP), R12	
  0x4b6f25		4d3b6610		CMPQ R12, 0x10(R14)	
  0x4b6f29		0f86b7040000		JBE 0x4b73e6		
  0x4b6f2f		55			PUSHQ BP		
  0x4b6f30		4889e5			MOVQ SP, BP		
  0x4b6f33		4881ecb0000000		SUBQ $0xb0, SP		
	if gx == 0 {
  0x4b6f3a		48898424c0000000	MOVQ AX, 0xc0(SP)	
  0x4b6f42		48899c24c8000000	MOVQ BX, 0xc8(SP)	
  0x4b6f4a		48898c24d0000000	MOVQ CX, 0xd0(SP)	
  0x4b6f52		4889bc24d8000000	MOVQ DI, 0xd8(SP)	
  0x4b6f5a		4c899424f8000000	MOVQ R10, 0xf8(SP)	
	gz = (*vz_1) - (*vz_2)
  0x4b6f62		f20f1007		MOVSD_XMM 0(DI), X0	
  0x4b6f66		f2410f1011		MOVSD_XMM 0(R9), X2	
  0x4b6f6b		0f10d8			MOVUPS X0, X3		
  0x4b6f6e		f20f5cda		SUBSD X2, X3		
	gx = (*vx_1) - (*vx_2)
  0x4b6f72		f20f100b		MOVSD_XMM 0(BX), X1	
  0x4b6f76		f20f1026		MOVSD_XMM 0(SI), X4	
  0x4b6f7a		0f10e9			MOVUPS X1, X5		
  0x4b6f7d		f20f5cec		SUBSD X4, X5		
	wx = 0.5 * ((*vx_1) + (*vx_2))
  0x4b6f81		f20f58e1		ADDSD X1, X4		
	gy = (*vy_1) - (*vy_2)
  0x4b6f85		f20f1009		MOVSD_XMM 0(CX), X1	
  0x4b6f89		f2410f1030		MOVSD_XMM 0(R8), X6	
  0x4b6f8e		0f10f9			MOVUPS X1, X7		
  0x4b6f91		f20f5cfe		SUBSD X6, X7		
	g = math.Sqrt(gx*gx + gy*gy + gz*gz)
  0x4b6f95		440f10c7		MOVUPS X7, X8		
  0x4b6f99		f20f59ff		MULSD X7, X7		
  0x4b6f9d		440f10cf		MOVUPS X7, X9		
  0x4b6fa1		c4e2d1b9fd		VFMADD231SD X5, X5, X7	
	wy = 0.5 * ((*vy_1) + (*vy_2))
  0x4b6fa6		f20f58f1		ADDSD X1, X6		
	wz = 0.5 * ((*vz_1) + (*vz_2))
  0x4b6faa		f20f58d0		ADDSD X0, X2		
	g = math.Sqrt(gx*gx + gy*gy + gz*gz)
  0x4b6fae		c4e2e1b9fb		VFMADD231SD X3, X3, X7	
  0x4b6fb3		f20f117c2410		MOVSD_XMM X7, 0x10(SP)	
	wx = 0.5 * ((*vx_1) + (*vx_2))
  0x4b6fb9		f2440f10155e380100	MOVSD_XMM $f64.3fe0000000000000(SB), X10	
  0x4b6fc2		f2410f59e2		MULSD X10, X4					
  0x4b6fc7		f20f11642428		MOVSD_XMM X4, 0x28(SP)				
	wy = 0.5 * ((*vy_1) + (*vy_2))
  0x4b6fcd		f2410f59f2		MULSD X10, X6		
  0x4b6fd2		f20f11742420		MOVSD_XMM X6, 0x20(SP)	
	wz = 0.5 * ((*vz_1) + (*vz_2))
  0x4b6fd8		f2410f59d2		MULSD X10, X2		
  0x4b6fdd		f20f11542418		MOVSD_XMM X2, 0x18(SP)	
	if gx == 0 {
  0x4b6fe3		450f57d2		XORPS X10, X10				
  0x4b6fe7		66410f2eea		UCOMISD X10, X5				
  0x4b6fec		750c			JNE 0x4b6ffa				
  0x4b6fee		7a0a			JP 0x4b6ffa				
  0x4b6ff0		f20f100560380100	MOVSD_XMM $f64.3ff921fb54442d18(SB), X0	
  0x4b6ff8		eb76			JMP 0x4b7070				
	gy = (*vy_1) - (*vy_2)
  0x4b6ffa		f2440f118424a8000000	MOVSD_XMM X8, 0xa8(SP)	
	gz = (*vz_1) - (*vz_2)
  0x4b7004		f20f115c2460		MOVSD_XMM X3, 0x60(SP)	
		theta = math.Atan2(math.Sqrt(gy*gy+gz*gz), gx)
  0x4b700a		c462e1b9cb		VFMADD231SD X3, X3, X9	
	return sqrt(x)
  0x4b700f		f2410f51c1		SQRTSD X9, X0		
	return atan2(y, x)
  0x4b7014		0f10cd			MOVUPS X5, X1		
  0x4b7017		e8c4d3fcff		CALL math.atan2(SB)	
	t1 = sim.Sigma[I_ISO][e_index]
  0x4b701c		488b8424c0000000	MOVQ 0xc0(SP), AX	
	*vy_1 = wy + 0.5*gy
  0x4b7024		488b8c24d0000000	MOVQ 0xd0(SP), CX	
	*vx_1 = wx + 0.5*gx
  0x4b702c		488b9c24c8000000	MOVQ 0xc8(SP), BX	
	*vz_1 = wz + 0.5*gz
  0x4b7034		488bbc24d8000000	MOVQ 0xd8(SP), DI	
	t1 = sim.Sigma[I_ISO][e_index]
  0x4b703c		4c8b9424f8000000	MOVQ 0xf8(SP), R10	
	*vz_1 = wz + 0.5*gz
  0x4b7044		f20f10542418		MOVSD_XMM 0x18(SP), X2	
		if gz > 0 {
  0x4b704a		f20f105c2460		MOVSD_XMM 0x60(SP), X3	
	*vx_1 = wx + 0.5*gx
  0x4b7050		f20f10642428		MOVSD_XMM 0x28(SP), X4	
	*vy_1 = wy + 0.5*gy
  0x4b7056		f20f10742420		MOVSD_XMM 0x20(SP), X6	
	return sqrt(x)
  0x4b705c		f20f107c2410		MOVSD_XMM 0x10(SP), X7	
	if gy == 0 {
  0x4b7062		f2440f108424a8000000	MOVSD_XMM 0xa8(SP), X8	
  0x4b706c		450f57d2		XORPS X10, X10		
  0x4b7070		f20f11442430		MOVSD_XMM X0, 0x30(SP)	
  0x4b7076		66450f2ec2		UCOMISD X10, X8		
  0x4b707b		751d			JNE 0x4b709a		
  0x4b707d		7a1b			JP 0x4b709a		
		if gz > 0 {
  0x4b707f		66410f2eda		UCOMISD X10, X3				
  0x4b7084		760a			JBE 0x4b7090				
  0x4b7086		f20f100dca370100	MOVSD_XMM $f64.3ff921fb54442d18(SB), X1	
  0x4b708e		eb60			JMP 0x4b70f0				
  0x4b7090		f20f100de0380100	MOVSD_XMM $f64.bff921fb54442d18(SB), X1	
  0x4b7098		eb56			JMP 0x4b70f0				
		phi = math.Atan2(gz, gy)
  0x4b709a		90			NOPL			
	return atan2(y, x)
  0x4b709b		0f10c3			MOVUPS X3, X0		
  0x4b709e		410f10c8		MOVUPS X8, X1		
  0x4b70a2		e839d3fcff		CALL math.atan2(SB)	
	t1 = sim.Sigma[I_ISO][e_index]
  0x4b70a7		488b8424c0000000	MOVQ 0xc0(SP), AX	
	*vy_1 = wy + 0.5*gy
  0x4b70af		488b8c24d0000000	MOVQ 0xd0(SP), CX	
	*vx_1 = wx + 0.5*gx
  0x4b70b7		488b9c24c8000000	MOVQ 0xc8(SP), BX	
	*vz_1 = wz + 0.5*gz
  0x4b70bf		488bbc24d8000000	MOVQ 0xd8(SP), DI	
	t1 = sim.Sigma[I_ISO][e_index]
  0x4b70c7		4c8b9424f8000000	MOVQ 0xf8(SP), R10	
	*vz_1 = wz + 0.5*gz
  0x4b70cf		f20f10542418		MOVSD_XMM 0x18(SP), X2	
	*vx_1 = wx + 0.5*gx
  0x4b70d5		f20f10642428		MOVSD_XMM 0x28(SP), X4	
	*vy_1 = wy + 0.5*gy
  0x4b70db		f20f10742420		MOVSD_XMM 0x20(SP), X6	
	return sqrt(x)
  0x4b70e1		f20f107c2410		MOVSD_XMM 0x10(SP), X7	
	t1 = sim.Sigma[I_ISO][e_index]
  0x4b70e7		0f10c8			MOVUPS X0, X1		
	return sin(x)
  0x4b70ea		f20f10442430		MOVSD_XMM 0x30(SP), X0	
	t1 = sim.Sigma[I_ISO][e_index]
  0x4b70f0		8400			TESTB AL, 0(AX)				
  0x4b70f2		4981fa40420f00		CMPQ R10, $0xf4240			
  0x4b70f9		0f83dc020000		JAE 0x4b73db				
  0x4b70ff		f20f114c2458		MOVSD_XMM X1, 0x58(SP)			
  0x4b7105		f2420f1084d000366e01	MOVSD_XMM 0x16e3600(AX)(R10*8), X0	
  0x4b710f		f20f11442438		MOVSD_XMM X0, 0x38(SP)			
	t2 = t1 + sim.Sigma[I_BACK][e_index]
  0x4b7115		f2420f1084d00048e801	MOVSD_XMM 0x1e84800(AX)(R10*8), X0	
  0x4b711f		f20f118424a8000000	MOVSD_XMM X0, 0xa8(SP)			
	rnd = sim.R01()
  0x4b7128		e873680000		CALL gopic.(*SimulationState).R01(SB)	
	t2 = t1 + sim.Sigma[I_BACK][e_index]
  0x4b712d		f20f108c24a8000000	MOVSD_XMM 0xa8(SP), X1	
  0x4b7136		f20f10542438		MOVSD_XMM 0x38(SP), X2	
  0x4b713c		f20f58ca		ADDSD X2, X1		
	if rnd < (t1 / t2) { // isotropic scattering
  0x4b7140		f20f5ed1		DIVSD X1, X2				
  0x4b7144		660f2ed0		UCOMISD X0, X2				
  0x4b7148		770a			JA 0x4b7154				
  0x4b714a		f20f100d36370100	MOVSD_XMM $f64.400921fb54442d18(SB), X1	
  0x4b7152		eb36			JMP 0x4b718a				
		chi = math.Acos(1.0 - 2.0*sim.R01()) // scattering angle
  0x4b7154		488b8424c0000000	MOVQ 0xc0(SP), AX			
  0x4b715c		0f1f4000		NOPL 0(AX)				
  0x4b7160		e83b680000		CALL gopic.(*SimulationState).R01(SB)	
  0x4b7165		f20f58c0		ADDSD X0, X0				
  0x4b7169		f20f100dc7360100	MOVSD_XMM $f64.3ff0000000000000(SB), X1	
  0x4b7171		f20f5cc8		SUBSD X0, X1				
	return acos(x)
  0x4b7175		90			NOPL			
	return asin(x)
  0x4b7176		0f10c1			MOVUPS X1, X0		
  0x4b7179		e8a2cefcff		CALL math.asin(SB)	
	return Pi/2 - Asin(x)
  0x4b717e		f20f100dd2360100	MOVSD_XMM $f64.3ff921fb54442d18(SB), X1	
  0x4b7186		f20f5cc8		SUBSD X0, X1				
	eta = TWO_PI * sim.R01() // azimuthal angle
  0x4b718a		f20f118c2480000000	MOVSD_XMM X1, 0x80(SP)			
  0x4b7193		488b8424c0000000	MOVQ 0xc0(SP), AX			
  0x4b719b		0f1f440000		NOPL 0(AX)(AX*1)			
  0x4b71a0		e8fb670000		CALL gopic.(*SimulationState).R01(SB)	
  0x4b71a5		f20f100d13370100	MOVSD_XMM $f64.401921fb54442d18(SB), X1	
  0x4b71ad		f20f59c8		MULSD X0, X1				
  0x4b71b1		f20f114c2470		MOVSD_XMM X1, 0x70(SP)			
	return sqrt(x)
  0x4b71b7		f20f10442410		MOVSD_XMM 0x10(SP), X0	
  0x4b71bd		f20f51c0		SQRTSD X0, X0		
  0x4b71c1		f20f11442468		MOVSD_XMM X0, 0x68(SP)	
	sc = math.Sin(chi)
  0x4b71c7		90			NOPL			
	return sin(x)
  0x4b71c8		f20f10842480000000	MOVSD_XMM 0x80(SP), X0	
  0x4b71d1		e8caddfcff		CALL math.sin(SB)	
  0x4b71d6		f20f11442450		MOVSD_XMM X0, 0x50(SP)	
	cc = math.Cos(chi)
  0x4b71dc		90			NOPL			
	return cos(x)
  0x4b71dd		f20f10842480000000	MOVSD_XMM 0x80(SP), X0	
  0x4b71e6		e875dbfcff		CALL math.cos(SB)	
  0x4b71eb		f20f11842490000000	MOVSD_XMM X0, 0x90(SP)	
	se = math.Sin(eta)
  0x4b71f4		90			NOPL			
	return sin(x)
  0x4b71f5		f20f10442470		MOVSD_XMM 0x70(SP), X0	
  0x4b71fb		0f1f440000		NOPL 0(AX)(AX*1)	
  0x4b7200		e89bddfcff		CALL math.sin(SB)	
  0x4b7205		f20f11442448		MOVSD_XMM X0, 0x48(SP)	
	ce = math.Cos(eta)
  0x4b720b		90			NOPL			
	return cos(x)
  0x4b720c		f20f10442470		MOVSD_XMM 0x70(SP), X0	
  0x4b7212		e849dbfcff		CALL math.cos(SB)	
  0x4b7217		f20f11842488000000	MOVSD_XMM X0, 0x88(SP)	
	st = math.Sin(theta)
  0x4b7220		90			NOPL			
	return sin(x)
  0x4b7221		f20f10442430		MOVSD_XMM 0x30(SP), X0	
  0x4b7227		e874ddfcff		CALL math.sin(SB)	
  0x4b722c		f20f11442440		MOVSD_XMM X0, 0x40(SP)	
	gx = g * (ct*cc - st*sc*ce)
  0x4b7232		f20f104c2450		MOVSD_XMM 0x50(SP), X1	
  0x4b7238		f20f59c1		MULSD X1, X0		
  0x4b723c		f20f108c2488000000	MOVSD_XMM 0x88(SP), X1	
  0x4b7245		f20f59c1		MULSD X1, X0		
  0x4b7249		f20f118424a8000000	MOVSD_XMM X0, 0xa8(SP)	
	ct = math.Cos(theta)
  0x4b7252		90			NOPL			
	return cos(x)
  0x4b7253		f20f10442430		MOVSD_XMM 0x30(SP), X0	
  0x4b7259		e802dbfcff		CALL math.cos(SB)	
  0x4b725e		f20f11442478		MOVSD_XMM X0, 0x78(SP)	
	gx = g * (ct*cc - st*sc*ce)
  0x4b7264		f20f108c2490000000	MOVSD_XMM 0x90(SP), X1	
  0x4b726d		f20f59c1		MULSD X1, X0		
  0x4b7271		f20f108c24a8000000	MOVSD_XMM 0xa8(SP), X1	
  0x4b727a		f20f5cc1		SUBSD X1, X0		
  0x4b727e		f20f104c2468		MOVSD_XMM 0x68(SP), X1	
  0x4b7284		f20f59c1		MULSD X1, X0		
	*vx_1 = wx + 0.5*gx
  0x4b7288		f20f104c2428		MOVSD_XMM 0x28(SP), X1			
  0x4b728e		f20f10158a350100	MOVSD_XMM $f64.3fe0000000000000(SB), X2	
  0x4b7296		c4e2f9b9ca		VFMADD231SD X2, X0, X1			
  0x4b729b		f20f118c24a8000000	MOVSD_XMM X1, 0xa8(SP)			
	sp = math.Sin(phi)
  0x4b72a4		90			NOPL			
	return sin(x)
  0x4b72a5		f20f10442458		MOVSD_XMM 0x58(SP), X0	
  0x4b72ab		e8f0dcfcff		CALL math.sin(SB)	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b72b0		f20f104c2450		MOVSD_XMM 0x50(SP), X1	
  0x4b72b6		0f10d0			MOVUPS X0, X2		
  0x4b72b9		f20f59c1		MULSD X1, X0		
  0x4b72bd		f20f105c2448		MOVSD_XMM 0x48(SP), X3	
  0x4b72c3		f20f59c3		MULSD X3, X0		
  0x4b72c7		f20f118424a0000000	MOVSD_XMM X0, 0xa0(SP)	
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4b72d0		f20f10442440		MOVSD_XMM 0x40(SP), X0	
  0x4b72d6		0f10da			MOVUPS X2, X3		
  0x4b72d9		f20f59d0		MULSD X0, X2		
  0x4b72dd		f20f10442478		MOVSD_XMM 0x78(SP), X0	
  0x4b72e3		f20f59d8		MULSD X0, X3		
  0x4b72e7		f20f59d9		MULSD X1, X3		
  0x4b72eb		f20f10842488000000	MOVSD_XMM 0x88(SP), X0	
  0x4b72f4		f20f59d8		MULSD X0, X3		
  0x4b72f8		f20f10842490000000	MOVSD_XMM 0x90(SP), X0	
  0x4b7301		c4e2e9b9d8		VFMADD231SD X0, X2, X3	
  0x4b7306		f20f119c2498000000	MOVSD_XMM X3, 0x98(SP)	
	cp = math.Cos(phi)
  0x4b730f		90			NOPL			
	return cos(x)
  0x4b7310		f20f10442458		MOVSD_XMM 0x58(SP), X0	
  0x4b7316		e845dafcff		CALL math.cos(SB)	
	*vx_1 = wx + 0.5*gx
  0x4b731b		f20f108c24a8000000	MOVSD_XMM 0xa8(SP), X1	
  0x4b7324		488b8c24c8000000	MOVQ 0xc8(SP), CX	
  0x4b732c		f20f1109		MOVSD_XMM X1, 0(CX)	
	gy = g * (st*cp*cc + ct*cp*sc*ce - sp*sc*se)
  0x4b7330		f20f104c2440		MOVSD_XMM 0x40(SP), X1	
  0x4b7336		f20f59c8		MULSD X0, X1		
  0x4b733a		f20f10542478		MOVSD_XMM 0x78(SP), X2	
  0x4b7340		f20f59d0		MULSD X0, X2		
  0x4b7344		f20f105c2450		MOVSD_XMM 0x50(SP), X3	
  0x4b734a		f20f59d3		MULSD X3, X2		
  0x4b734e		f20f10a42488000000	MOVSD_XMM 0x88(SP), X4	
  0x4b7357		f20f59d4		MULSD X4, X2		
  0x4b735b		f20f10a42490000000	MOVSD_XMM 0x90(SP), X4	
  0x4b7364		c4e2f1b9d4		VFMADD231SD X4, X1, X2	
  0x4b7369		f20f108c24a0000000	MOVSD_XMM 0xa0(SP), X1	
  0x4b7372		f20f5cd1		SUBSD X1, X2		
  0x4b7376		f20f104c2468		MOVSD_XMM 0x68(SP), X1	
  0x4b737c		f20f59d1		MULSD X1, X2		
	gz = g * (st*sp*cc + ct*sp*sc*ce + cp*sc*se)
  0x4b7380		f20f59c3		MULSD X3, X0		
  0x4b7384		f20f109c2498000000	MOVSD_XMM 0x98(SP), X3	
  0x4b738d		f20f10642448		MOVSD_XMM 0x48(SP), X4	
  0x4b7393		c4e2f9b9dc		VFMADD231SD X4, X0, X3	
  0x4b7398		f20f59cb		MULSD X3, X1		
	*vy_1 = wy + 0.5*gy
  0x4b739c		f20f10442420		MOVSD_XMM 0x20(SP), X0			
  0x4b73a2		f20f101d76340100	MOVSD_XMM $f64.3fe0000000000000(SB), X3	
  0x4b73aa		c4e2e9b9c3		VFMADD231SD X3, X2, X0			
  0x4b73af		488b8c24d0000000	MOVQ 0xd0(SP), CX			
  0x4b73b7		f20f1101		MOVSD_XMM X0, 0(CX)			
	*vz_1 = wz + 0.5*gz
  0x4b73bb		f20f10442418		MOVSD_XMM 0x18(SP), X0	
  0x4b73c1		c4e2f1b9c3		VFMADD231SD X3, X1, X0	
  0x4b73c6		488b8c24d8000000	MOVQ 0xd8(SP), CX	
  0x4b73ce		f20f1101		MOVSD_XMM X0, 0(CX)	
}
  0x4b73d2		4881c4b0000000		ADDQ $0xb0, SP		
  0x4b73d9		5d			POPQ BP			
  0x4b73da		c3			RET			
	t1 = sim.Sigma[I_ISO][e_index]
  0x4b73db		b840420f00		MOVL $0xf4240, AX		
  0x4b73e0		e81ba3fcff		CALL runtime.panicBounds(SB)	
  0x4b73e5		90			NOPL				
func (sim *SimulationState) CollisionIon(vx_1, vy_1, vz_1, vx_2, vy_2, vz_2 *float64, e_index int) {
  0x4b73e6		4889442408		MOVQ AX, 0x8(SP)				
  0x4b73eb		48895c2410		MOVQ BX, 0x10(SP)				
  0x4b73f0		48894c2418		MOVQ CX, 0x18(SP)				
  0x4b73f5		48897c2420		MOVQ DI, 0x20(SP)				
  0x4b73fa		4889742428		MOVQ SI, 0x28(SP)				
  0x4b73ff		4c89442430		MOVQ R8, 0x30(SP)				
  0x4b7404		4c894c2438		MOVQ R9, 0x38(SP)				
  0x4b7409		4c89542440		MOVQ R10, 0x40(SP)				
  0x4b740e		e8ad86fcff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x4b7413		488b442408		MOVQ 0x8(SP), AX				
  0x4b7418		488b5c2410		MOVQ 0x10(SP), BX				
  0x4b741d		488b4c2418		MOVQ 0x18(SP), CX				
  0x4b7422		488b7c2420		MOVQ 0x20(SP), DI				
  0x4b7427		488b742428		MOVQ 0x28(SP), SI				
  0x4b742c		4c8b442430		MOVQ 0x30(SP), R8				
  0x4b7431		4c8b4c2438		MOVQ 0x38(SP), R9				
  0x4b7436		4c8b542440		MOVQ 0x40(SP), R10				
  0x4b743b		0f1f440000		NOPL 0(AX)(AX*1)				
  0x4b7440		e9dbfaffff		JMP gopic.(*SimulationState).CollisionIon(SB)	

TEXT gopic.(*SimulationState).Step8CollisionIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/simulation_null.go
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x4bd440		4c8d6424e8		LEAQ -0x18(SP), R12	
  0x4bd445		4d3b6610		CMPQ R12, 0x10(R14)	
  0x4bd449		0f86f7020000		JBE 0x4bd746		
  0x4bd44f		55			PUSHQ BP		
  0x4bd450		4889e5			MOVQ SP, BP		
  0x4bd453		4881ec90000000		SUBQ $0x90, SP		
	if (t % N_SUB) != 0 {
  0x4bd45a		48b9cdcccccccccccccc	MOVQ $0xcccccccccccccccd, CX	
  0x4bd464		480fafd9		IMULQ CX, BX			
  0x4bd468		48b99899999999999919	MOVQ $0x1999999999999998, CX	
  0x4bd472		4801d9			ADDQ BX, CX			
  0x4bd475		48c1c13e		ROLQ $0x3e, CX			
  0x4bd479		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x4bd483		4839ca			CMPQ DX, CX			
  0x4bd486		7265			JB 0x4bd4ed			
  0x4bd488		48898424a0000000	MOVQ AX, 0xa0(SP)		
	nCollStar := sim.sampleBinomial(sim.N_i, sim.PStarI)
  0x4bd490		8400			TESTB AL, 0(AX)						
  0x4bd492		488b98087e5603		MOVQ 0x3567e08(AX), BX					
  0x4bd499		f20f1080d020ba07	MOVSD_XMM 0x7ba20d0(AX), X0				
  0x4bd4a1		e81afbffff		CALL gopic.(*SimulationState).sampleBinomial(SB)	
	if nCollStar > sim.N_i {
  0x4bd4a6		488b8c24a0000000	MOVQ 0xa0(SP), CX	
  0x4bd4ae		488b99087e5603		MOVQ 0x3567e08(CX), BX	
  0x4bd4b5		4839d8			CMPQ AX, BX		
	if nCollStar == 0 {
  0x4bd4b8		480f4fc3		CMOVG BX, AX		
  0x4bd4bc		0f1f4000		NOPL 0(AX)		
  0x4bd4c0		4885c0			TESTQ AX, AX		
	if nCollStar > sim.N_i {
  0x4bd4c3		741f			JE 0x4bd4e4		
	if nCollStar == 0 {
  0x4bd4c5		4889c2			MOVQ AX, DX		
	candidates := sim.randomSample(sim.N_i, nCollStar)
  0x4bd4c8		4889c8			MOVQ CX, AX					
  0x4bd4cb		4889d1			MOVQ DX, CX					
  0x4bd4ce		e8edf9ffff		CALL gopic.(*SimulationState).randomSample(SB)	
  0x4bd4d3		4889842488000000	MOVQ AX, 0x88(SP)				
  0x4bd4db		48895c2470		MOVQ BX, 0x70(SP)				
  0x4bd4e0		31c9			XORL CX, CX					
	for _, k := range candidates {
  0x4bd4e2		eb27			JMP 0x4bd50b		
		return
  0x4bd4e4		4881c490000000		ADDQ $0x90, SP		
  0x4bd4eb		5d			POPQ BP			
  0x4bd4ec		c3			RET			
		return
  0x4bd4ed		4881c490000000		ADDQ $0x90, SP		
  0x4bd4f4		5d			POPQ BP			
  0x4bd4f5		c3			RET			
	for _, k := range candidates {
  0x4bd4f6		488b4c2478		MOVQ 0x78(SP), CX	
  0x4bd4fb		48ffc1			INCQ CX			
  0x4bd4fe		488b842488000000	MOVQ 0x88(SP), AX	
  0x4bd506		488b5c2470		MOVQ 0x70(SP), BX	
  0x4bd50b		4839cb			CMPQ BX, CX		
  0x4bd50e		0f8e11020000		JLE 0x4bd725		
  0x4bd514		48894c2478		MOVQ CX, 0x78(SP)	
  0x4bd519		488b0cc8		MOVQ 0(AX)(CX*8), CX	
  0x4bd51d		48894c2468		MOVQ CX, 0x68(SP)	
	return sim.Rng.NormFloat64() * RMB_sigma
  0x4bd522		488b8c24a0000000	MOVQ 0xa0(SP), CX			
  0x4bd52a		488b81a820ba07		MOVQ 0x7ba20a8(CX), AX			
  0x4bd531		e88a81ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4bd536		f20f5905daa61200	MULSD gopic.RMB_sigma(SB), X0		
		vxA := sim.RMB()
  0x4bd53e		f20f11442458		MOVSD_XMM X0, 0x58(SP)	
	return sim.Rng.NormFloat64() * RMB_sigma
  0x4bd544		488b8c24a0000000	MOVQ 0xa0(SP), CX			
  0x4bd54c		488b81a820ba07		MOVQ 0x7ba20a8(CX), AX			
  0x4bd553		e86881ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4bd558		f20f5905b8a61200	MULSD gopic.RMB_sigma(SB), X0		
		vyA := sim.RMB()
  0x4bd560		f20f11442450		MOVSD_XMM X0, 0x50(SP)	
	return sim.Rng.NormFloat64() * RMB_sigma
  0x4bd566		488b8c24a0000000	MOVQ 0xa0(SP), CX			
  0x4bd56e		488b81a820ba07		MOVQ 0x7ba20a8(CX), AX			
  0x4bd575		e84681ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4bd57a		f20f590596a61200	MULSD gopic.RMB_sigma(SB), X0		
		vzA := sim.RMB()
  0x4bd582		f20f11442448		MOVSD_XMM X0, 0x48(SP)	
		gx := sim.Vx_i[k] - vxA
  0x4bd588		488b4c2468		MOVQ 0x68(SP), CX			
  0x4bd58d		4881f940420f00		CMPQ CX, $0xf4240			
  0x4bd594		0f839e010000		JAE 0x4bd738				
  0x4bd59a		488b9424a0000000	MOVQ 0xa0(SP), DX			
  0x4bd5a2		f20f108cca10d8b805	MOVSD_XMM 0x5b8d810(DX)(CX*8), X1	
  0x4bd5ab		f20f5c4c2458		SUBSD 0x58(SP), X1			
		gy := sim.Vy_i[k] - vyA
  0x4bd5b1		f20f1094ca10ea3206	MOVSD_XMM 0x632ea10(DX)(CX*8), X2	
  0x4bd5ba		f20f5c542450		SUBSD 0x50(SP), X2			
		gz := sim.Vz_i[k] - vzA
  0x4bd5c0		f20f109cca10fcac06	MOVSD_XMM 0x6acfc10(DX)(CX*8), X3	
  0x4bd5c9		f20f5cd8		SUBSD X0, X3				
		gSqr := gx*gx + gy*gy + gz*gz
  0x4bd5cd		f20f59d2		MULSD X2, X2		
  0x4bd5d1		c4e2f1b9d1		VFMADD231SD X1, X1, X2	
  0x4bd5d6		c4e2e1b9d3		VFMADD231SD X3, X3, X2	
		energy := 0.5 * MU_ARAR * gSqr / EV_TO_J
  0x4bd5db		f20f100545d10000	MOVSD_XMM $f64.3a94879de14d0b24(SB), X0	
  0x4bd5e3		f20f59c2		MULSD X2, X0				
  0x4bd5e7		f20f100d59d10000	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X1	
  0x4bd5ef		f20f5ec1		DIVSD X1, X0				
		eIdx := minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
  0x4bd5f3		f20f100dcdd10000	MOVSD_XMM $f64.3f50624dd2f1a9fc(SB), X1	
  0x4bd5fb		f20f5ec1		DIVSD X1, X0				
  0x4bd5ff		f20f100d19d20000	MOVSD_XMM $f64.3fe0000000000000(SB), X1	
  0x4bd607		f20f58c8		ADDSD X0, X1				
  0x4bd60b		f2480f2cd9		CVTTSD2SIQ X1, BX			
		g := math.Sqrt(gSqr)
  0x4bd610		90			NOPL			
	if a < b {
  0x4bd611		4881fb3f420f00		CMPQ BX, $0xf423f	
  0x4bd618		7c06			JL 0x4bd620		
  0x4bd61a		bb3f420f00		MOVL $0xf423f, BX	
  0x4bd61f		90			NOPL			
		realNu := sim.SigmaTotI[eIdx] * g
  0x4bd620		4881fb40420f00		CMPQ BX, $0xf4240	
  0x4bd627		0f8301010000		JAE 0x4bd72e		
	return sqrt(x)
  0x4bd62d		f20f51c2		SQRTSD X2, X0		
		realNu := sim.SigmaTotI[eIdx] * g
  0x4bd631		f20f5984da006cdc02	MULSD 0x2dc6c00(DX)(BX*8), X0	
		pAccept := realNu / sim.NuStarI
  0x4bd63a		f20f5e82c820ba07	DIVSD 0x7ba20c8(DX), X0	
		if pAccept > 1.0 {
  0x4bd642		f20f100deed10000	MOVSD_XMM $f64.3ff0000000000000(SB), X1	
  0x4bd64a		660f2ec1		UCOMISD X1, X0				
  0x4bd64e		7608			JBE 0x4bd658				
  0x4bd650		f20f1005e0d10000	MOVSD_XMM $f64.3ff0000000000000(SB), X0	
		eIdx := minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
  0x4bd658		48895c2440		MOVQ BX, 0x40(SP)	
		if sim.Rng.Float64() < pAccept {
  0x4bd65d		f20f11442460		MOVSD_XMM X0, 0x60(SP)	
  0x4bd663		488bb2a820ba07		MOVQ 0x7ba20a8(DX), SI	
  0x4bd66a		4889b42480000000	MOVQ SI, 0x80(SP)	
again:
  0x4bd672		eb08			JMP 0x4bd67c		
func (r *Rand) Int63() int64 { return r.src.Int63() }
  0x4bd674		488bb42480000000	MOVQ 0x80(SP), SI	
  0x4bd67c		488b0e			MOVQ 0(SI), CX		
  0x4bd67f		488b4608		MOVQ 0x8(SI), AX	
  0x4bd683		488b4918		MOVQ 0x18(CX), CX	
  0x4bd687		ffd1			CALL CX			
	f := float64(r.Int63()) / (1 << 63)
  0x4bd689		0f57c0			XORPS X0, X0				
  0x4bd68c		f2480f2ac0		CVTSI2SDQ AX, X0			
  0x4bd691		f20f100da7d00000	MOVSD_XMM $f64.3c00000000000000(SB), X1	
  0x4bd699		f20f59c8		MULSD X0, X1				
	if f == 1 {
  0x4bd69d		f20f100593d10000	MOVSD_XMM $f64.3ff0000000000000(SB), X0	
  0x4bd6a5		660f2ec8		UCOMISD X0, X1				
  0x4bd6a9		7502			JNE 0x4bd6ad				
  0x4bd6ab		7bc7			JNP 0x4bd674				
		if sim.Rng.Float64() < pAccept {
  0x4bd6ad		f20f10442460		MOVSD_XMM 0x60(SP), X0	
  0x4bd6b3		660f2ec1		UCOMISD X1, X0		
  0x4bd6b7		770d			JA 0x4bd6c6		
	return sim.Rng.NormFloat64() * RMB_sigma
  0x4bd6b9		488b9424a0000000	MOVQ 0xa0(SP), DX	
		if sim.Rng.Float64() < pAccept {
  0x4bd6c1		e930feffff		JMP 0x4bd4f6		
			sim.CollisionIon(&sim.Vx_i[k], &sim.Vy_i[k], &sim.Vz_i[k], &vxA, &vyA, &vzA, eIdx)
  0x4bd6c6		488b542468		MOVQ 0x68(SP), DX				
  0x4bd6cb		488b8424a0000000	MOVQ 0xa0(SP), AX				
  0x4bd6d3		488d1cd0		LEAQ 0(AX)(DX*8), BX				
  0x4bd6d7		488d9b10d8b805		LEAQ 0x5b8d810(BX), BX				
  0x4bd6de		488d0cd0		LEAQ 0(AX)(DX*8), CX				
  0x4bd6e2		488d8910ea3206		LEAQ 0x632ea10(CX), CX				
  0x4bd6e9		488d3cd0		LEAQ 0(AX)(DX*8), DI				
  0x4bd6ed		488dbf10fcac06		LEAQ 0x6acfc10(DI), DI				
  0x4bd6f4		488d742458		LEAQ 0x58(SP), SI				
  0x4bd6f9		4c8d442450		LEAQ 0x50(SP), R8				
  0x4bd6fe		4c8d4c2448		LEAQ 0x48(SP), R9				
  0x4bd703		4c8b542440		MOVQ 0x40(SP), R10				
  0x4bd708		e81398ffff		CALL gopic.(*SimulationState).CollisionIon(SB)	
			sim.N_i_coll++
  0x4bd70d		488b9424a0000000	MOVQ 0xa0(SP), DX	
  0x4bd715		48ff825820ba07		INCQ 0x7ba2058(DX)	
  0x4bd71c		0f1f4000		NOPL 0(AX)		
  0x4bd720		e9d1fdffff		JMP 0x4bd4f6		
}
  0x4bd725		4881c490000000		ADDQ $0x90, SP		
  0x4bd72c		5d			POPQ BP			
  0x4bd72d		c3			RET			
		realNu := sim.SigmaTotI[eIdx] * g
  0x4bd72e		b840420f00		MOVL $0xf4240, AX		
  0x4bd733		e8c83ffcff		CALL runtime.panicBounds(SB)	
		gx := sim.Vx_i[k] - vxA
  0x4bd738		b840420f00		MOVL $0xf4240, AX		
  0x4bd73d		0f1f00			NOPL 0(AX)			
  0x4bd740		e8bb3ffcff		CALL runtime.panicBounds(SB)	
  0x4bd745		90			NOPL				
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x4bd746		4889442408		MOVQ AX, 0x8(SP)					
  0x4bd74b		48895c2410		MOVQ BX, 0x10(SP)					
  0x4bd750		e86b23fcff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x4bd755		488b442408		MOVQ 0x8(SP), AX					
  0x4bd75a		488b5c2410		MOVQ 0x10(SP), BX					
  0x4bd75f		90			NOPL							
  0x4bd760		e9dbfcffff		JMP gopic.(*SimulationState).Step8CollisionIons(SB)	


