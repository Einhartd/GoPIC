// --- Symbol: Step3MoveElectrons ---
TEXT gopic.(*SimulationState).Step3MoveElectrons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/simulation.go
func (sim *SimulationState) Step3MoveElectrons(t_index int) {
  0x4bbd60		55			PUSHQ BP		
  0x4bbd61		4889e5			MOVQ SP, BP		
	for k = 0; k < sim.N_e; k++ { // move all electrons in every time step
  0x4bbd64		31c9			XORL CX, CX		
  0x4bbd66		eb37			JMP 0x4bbd9f		
		sim.Vx_e[k] -= e_x * FACTOR_E
  0x4bbd68		f2440f108cc81090d003	MOVSD_XMM 0x3d09010(AX)(CX*8), X9	
  0x4bbd72		f20f59d6		MULSD X6, X2				
  0x4bbd76		f2440f5cca		SUBSD X2, X9				
  0x4bbd7b		f2440f118cc81090d003	MOVSD_XMM X9, 0x3d09010(AX)(CX*8)	
		sim.X_e[k] += sim.Vx_e[k] * DT_E
  0x4bbd85		f20f1094c8107e5603	MOVSD_XMM 0x3567e10(AX)(CX*8), X2	
  0x4bbd8e		c4c2d9b9d1		VFMADD231SD X9, X4, X2			
  0x4bbd93		f20f1194c8107e5603	MOVSD_XMM X2, 0x3567e10(AX)(CX*8)	
	for k = 0; k < sim.N_e; k++ { // move all electrons in every time step
  0x4bbd9c		48ffc1			INCQ CX			
  0x4bbd9f		8400			TESTB AL, 0(AX)		
  0x4bbda1		483988007e5603		CMPQ 0x3567e00(AX), CX	
  0x4bbda8		0f8e60030000		JLE 0x4bc10e		
		c0 = sim.X_e[k] * INV_DX
  0x4bbdae		4881f940420f00		CMPQ CX, $0xf4240			
  0x4bbdb5		0f838d030000		JAE 0x4bc148				
  0x4bbdbb		f20f1084c8107e5603	MOVSD_XMM 0x3567e10(AX)(CX*8), X0	
  0x4bbdc4		f20f100d6ceb0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4bbdcc		f20f59c1		MULSD X1, X0				
		p = int(c0)
  0x4bbdd0		f2480f2cd0		CVTTSD2SIQ X0, DX	
		c1 = float64(p) + 1.0 - c0
  0x4bbdd5		0f57d2			XORPS X2, X2				
  0x4bbdd8		f2480f2ad2		CVTSI2SDQ DX, X2			
  0x4bbddd		f20f101d53ea0000	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x4bbde5		f20f58da		ADDSD X2, X3				
  0x4bbde9		f20f5cd8		SUBSD X0, X3				
		c2 = c0 - float64(p)
  0x4bbded		f20f5cc2		SUBSD X2, X0		
		e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]
  0x4bbdf1		4881fa90010000		CMPQ DX, $0x190				
  0x4bbdf8		0f8340030000		JAE 0x4bc13e				
  0x4bbdfe		f20f1094d0100e2707	MOVSD_XMM 0x7270e10(AX)(DX*8), X2	
  0x4bbe07		488d7201		LEAQ 0x1(DX), SI			
  0x4bbe0b		f20f59d3		MULSD X3, X2				
  0x4bbe0f		4881fe90010000		CMPQ SI, $0x190				
  0x4bbe16		0f8313030000		JAE 0x4bc12f				
  0x4bbe1c		f20f10a4d0180e2707	MOVSD_XMM 0x7270e18(AX)(DX*8), X4	
  0x4bbe25		c4e2f9b9d4		VFMADD231SD X4, X0, X2			
		if sim.Measurement_mode {
  0x4bbe2a		80b8a020ba0700		CMPB 0x7ba20a0(AX), $0x0	
  0x4bbe31		0f847e020000		JE 0x4bc0b5			
			mean_v = sim.Vx_e[k] - 0.5*e_x*FACTOR_E
  0x4bbe37		f20f10a4c81090d003	MOVSD_XMM 0x3d09010(AX)(CX*8), X4	
  0x4bbe40		f20f102dd8e90000	MOVSD_XMM $f64.3fe0000000000000(SB), X5	
  0x4bbe48		f20f59ea		MULSD X2, X5				
  0x4bbe4c		f20f10353cea0000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x4bbe54		f20f59ee		MULSD X6, X5				
			sim.Counter_e_xt[p][t_index] += c1
  0x4bbe58		4869d240060000		IMULQ $0x640, DX, DX	
			mean_v = sim.Vx_e[k] - 0.5*e_x*FACTOR_E
  0x4bbe5f		f20f5ce5		SUBSD X5, X4		
			sim.Counter_e_xt[p][t_index] += c1
  0x4bbe63		488d3410		LEAQ 0(AX)(DX*1), SI		
  0x4bbe67		488db640d49c07		LEAQ 0x79cd440(SI), SI		
  0x4bbe6e		4881fbc8000000		CMPQ BX, $0xc8			
  0x4bbe75		0f83aa020000		JAE 0x4bc125			
  0x4bbe7b		f20f102cde		MOVSD_XMM 0(SI)(BX*8), X5	
  0x4bbe80		f20f58eb		ADDSD X3, X5			
  0x4bbe84		f20f112cde		MOVSD_XMM X5, 0(SI)(BX*8)	
			sim.Counter_e_xt[p+1][t_index] += c2
  0x4bbe89		488d3402		LEAQ 0(DX)(AX*1), SI		
  0x4bbe8d		488db680da9c07		LEAQ 0x79cda80(SI), SI		
  0x4bbe94		f20f102cde		MOVSD_XMM 0(SI)(BX*8), X5	
  0x4bbe99		f20f58e8		ADDSD X0, X5			
  0x4bbe9d		f20f112cde		MOVSD_XMM X5, 0(SI)(BX*8)	
			sim.Ue_xt[p][t_index] += c1 * mean_v
  0x4bbea2		488d3410		LEAQ 0(AX)(DX*1), SI		
  0x4bbea6		488db640b44e07		LEAQ 0x74eb440(SI), SI		
  0x4bbead		0f10eb			MOVUPS X3, X5			
  0x4bbeb0		f20f59dc		MULSD X4, X3			
  0x4bbeb4		f20f581cde		ADDSD 0(SI)(BX*8), X3		
  0x4bbeb9		f20f111cde		MOVSD_XMM X3, 0(SI)(BX*8)	
			sim.Ue_xt[p+1][t_index] += c2 * mean_v
  0x4bbebe		488d3402		LEAQ 0(DX)(AX*1), SI		
  0x4bbec2		488db680ba4e07		LEAQ 0x74eba80(SI), SI		
  0x4bbec9		0f10d8			MOVUPS X0, X3			
  0x4bbecc		f20f59c4		MULSD X4, X0			
  0x4bbed0		f20f5804de		ADDSD 0(SI)(BX*8), X0		
  0x4bbed5		f20f1104de		MOVSD_XMM X0, 0(SI)(BX*8)	
			v_sqr = mean_v*mean_v + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
  0x4bbeda		f20f1084c810a24a04	MOVSD_XMM 0x44aa210(AX)(CX*8), X0	
  0x4bbee3		f20f59c0		MULSD X0, X0				
  0x4bbee7		c4e2d9b9c4		VFMADD231SD X4, X4, X0			
  0x4bbeec		f20f10a4c810b4c404	MOVSD_XMM 0x4c4b410(AX)(CX*8), X4	
  0x4bbef5		c4e2d9b9c4		VFMADD231SD X4, X4, X0			
			energy = 0.5 * E_MASS * v_sqr / EV_TO_J
  0x4bbefa		f20f102516e80000	MOVSD_XMM $f64.39a279dcc3e61461(SB), X4	
  0x4bbf02		f20f59e0		MULSD X0, X4				
  0x4bbf06		f20f103d3ae80000	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X7	
  0x4bbf0e		f20f5ee7		DIVSD X7, X4				
			sim.Meanee_xt[p][t_index] += c1 * energy
  0x4bbf12		488d3410		LEAQ 0(AX)(DX*1), SI		
  0x4bbf16		488db6404c8907		LEAQ 0x7894c40(SI), SI		
  0x4bbf1d		440f10c5		MOVUPS X5, X8			
  0x4bbf21		f20f59ec		MULSD X4, X5			
  0x4bbf25		f20f582cde		ADDSD 0(SI)(BX*8), X5		
  0x4bbf2a		f20f112cde		MOVSD_XMM X5, 0(SI)(BX*8)	
			sim.Meanee_xt[p+1][t_index] += c2 * energy
  0x4bbf2f		488d3402		LEAQ 0(DX)(AX*1), SI		
  0x4bbf33		488db680528907		LEAQ 0x7895280(SI), SI		
  0x4bbf3a		f20f102cde		MOVSD_XMM 0(SI)(BX*8), X5	
  0x4bbf3f		c4e2e1b9ec		VFMADD231SD X4, X3, X5		
  0x4bbf44		f20f112cde		MOVSD_XMM X5, 0(SI)(BX*8)	
			energy_index = minInt(int(energy/DE_CS+0.5), CS_RANGES-1)
  0x4bbf49		f20f102d77e80000	MOVSD_XMM $f64.3f50624dd2f1a9fc(SB), X5		
  0x4bbf51		440f10cc		MOVUPS X4, X9					
  0x4bbf55		f20f5ee5		DIVSD X5, X4					
  0x4bbf59		f2440f1015bee80000	MOVSD_XMM $f64.3fe0000000000000(SB), X10	
  0x4bbf62		f2410f58e2		ADDSD X10, X4					
  0x4bbf67		f2480f2cf4		CVTTSD2SIQ X4, SI				
	if a < b {
  0x4bbf6c		4881fe3f420f00		CMPQ SI, $0xf423f	
  0x4bbf73		7c05			JL 0x4bbf7a		
  0x4bbf75		be3f420f00		MOVL $0xf423f, SI	
			velocity = math.Sqrt(v_sqr)
  0x4bbf7a		90			NOPL			
  0x4bbf7b		0f1f440000		NOPL 0(AX)(AX*1)	
			rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x4bbf80		4881fe40420f00		CMPQ SI, $0xf4240	
  0x4bbf87		0f838d010000		JAE 0x4bc11a		
			sim.Ioniz_rate_xt[p][t_index] += c1 * rate
  0x4bbf8d		488d3c10		LEAQ 0(AX)(DX*1), DI	
  0x4bbf91		488dbf405cb007		LEAQ 0x7b05c40(DI), DI	
			sim.Ioniz_rate_xt[p+1][t_index] += c2 * rate
  0x4bbf98		488d1402		LEAQ 0(DX)(AX*1), DX	
  0x4bbf9c		488d928062b007		LEAQ 0x7b06280(DX), DX	
	return sqrt(x)
  0x4bbfa3		f20f51c0		SQRTSD X0, X0		
			rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x4bbfa7		f20f5984f00024f400	MULSD 0xf42400(AX)(SI*8), X0			
  0x4bbfb0		f20f1025d0e70000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X4		
  0x4bbfb8		f20f59c4		MULSD X4, X0					
  0x4bbfbc		f2440f101d93e90000	MOVSD_XMM $f64.445c0bbef48bc79c(SB), X11	
  0x4bbfc5		f2410f59c3		MULSD X11, X0					
			sim.Ioniz_rate_xt[p][t_index] += c1 * rate
  0x4bbfca		f2440f59c0		MULSD X0, X8			
  0x4bbfcf		f2440f5804df		ADDSD 0(DI)(BX*8), X8		
  0x4bbfd5		f2440f1104df		MOVSD_XMM X8, 0(DI)(BX*8)	
			sim.Ioniz_rate_xt[p+1][t_index] += c2 * rate
  0x4bbfdb		f2440f1004da		MOVSD_XMM 0(DX)(BX*8), X8	
  0x4bbfe1		c462e1b9c0		VFMADD231SD X0, X3, X8		
  0x4bbfe6		f2440f1104da		MOVSD_XMM X8, 0(DX)(BX*8)	
			if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
  0x4bbfec		f20f1084c8107e5603	MOVSD_XMM 0x3567e10(AX)(CX*8), X0	
  0x4bbff5		f20f101ddbe70000	MOVSD_XMM $f64.3f870a3d70a3d70b(SB), X3	
  0x4bbffd		660f2ec3		UCOMISD X3, X0				
  0x4bc001		0f868f000000		JBE 0x4bc096				
  0x4bc007		f2440f1005d0e70000	MOVSD_XMM $f64.3f8c28f5c28f5c2a(SB), X8	
  0x4bc010		66440f2ec0		UCOMISD X0, X8				
  0x4bc015		0f8684000000		JBE 0x4bc09f				
				energy_index = int(energy / DE_EEPF)
  0x4bc01b		f20f1005dde70000	MOVSD_XMM $f64.3fa999999999999a(SB), X0	
  0x4bc023		450f10e1		MOVUPS X9, X12				
  0x4bc027		f2440f5ec8		DIVSD X0, X9				
  0x4bc02c		f2490f2cd1		CVTTSD2SIQ X9, DX			
				if energy_index < N_EEPF {
  0x4bc031		4881fad0070000		CMPQ DX, $0x7d0		
  0x4bc038		7d30			JGE 0x4bc06a		
  0x4bc03a		660f1f440000		NOPW 0(AX)(AX*1)	
					sim.Eepf[energy_index] += 1.0
  0x4bc040		0f83ca000000		JAE 0x4bc110					
  0x4bc046		f2440f108cd030592707	MOVSD_XMM 0x7275930(AX)(DX*8), X9		
  0x4bc050		f2440f102ddfe70000	MOVSD_XMM $f64.3ff0000000000000(SB), X13	
  0x4bc059		f2450f58cd		ADDSD X13, X9					
  0x4bc05e		f2440f118cd030592707	MOVSD_XMM X9, 0x7275930(AX)(DX*8)		
  0x4bc068		eb09			JMP 0x4bc073					
  0x4bc06a		f2440f102dc5e70000	MOVSD_XMM $f64.3ff0000000000000(SB), X13	
				sim.Mean_energy_accu_center += energy
  0x4bc073		f2440f10884020ba07	MOVSD_XMM 0x7ba2040(AX), X9	
  0x4bc07c		f2450f58cc		ADDSD X12, X9			
  0x4bc081		f2440f11884020ba07	MOVSD_XMM X9, 0x7ba2040(AX)	
				sim.Mean_energy_counter_center++
  0x4bc08a		48ff804820ba07		INCQ 0x7ba2048(AX)			
  0x4bc091		e9d2fcffff		JMP 0x4bbd68				
  0x4bc096		f2440f100541e70000	MOVSD_XMM $f64.3f8c28f5c28f5c2a(SB), X8	
			if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
  0x4bc09f		f20f100559e70000	MOVSD_XMM $f64.3fa999999999999a(SB), X0		
  0x4bc0a7		f2440f102d88e70000	MOVSD_XMM $f64.3ff0000000000000(SB), X13	
  0x4bc0b0		e9b3fcffff		JMP 0x4bbd68					
  0x4bc0b5		f20f100543e70000	MOVSD_XMM $f64.3fa999999999999a(SB), X0		
  0x4bc0bd		f20f101d13e70000	MOVSD_XMM $f64.3f870a3d70a3d70b(SB), X3		
  0x4bc0c5		f20f1025bbe60000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X4		
  0x4bc0cd		f20f102df3e60000	MOVSD_XMM $f64.3f50624dd2f1a9fc(SB), X5		
  0x4bc0d5		f20f1035b3e70000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6		
  0x4bc0dd		f20f103d63e60000	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X7		
  0x4bc0e5		f2440f1005f2e60000	MOVSD_XMM $f64.3f8c28f5c28f5c2a(SB), X8		
  0x4bc0ee		f2440f101529e70000	MOVSD_XMM $f64.3fe0000000000000(SB), X10	
  0x4bc0f7		f2440f101d58e80000	MOVSD_XMM $f64.445c0bbef48bc79c(SB), X11	
  0x4bc100		f2440f102d2fe70000	MOVSD_XMM $f64.3ff0000000000000(SB), X13	
		if sim.Measurement_mode {
  0x4bc109		e95afcffff		JMP 0x4bbd68		
}
  0x4bc10e		5d			POPQ BP			
  0x4bc10f		c3			RET			
					sim.Eepf[energy_index] += 1.0
  0x4bc110		b8d0070000		MOVL $0x7d0, AX			
  0x4bc115		e8e655fcff		CALL runtime.panicBounds(SB)	
			rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x4bc11a		b840420f00		MOVL $0xf4240, AX		
  0x4bc11f		90			NOPL				
  0x4bc120		e8db55fcff		CALL runtime.panicBounds(SB)	
			sim.Counter_e_xt[p][t_index] += c1
  0x4bc125		b8c8000000		MOVL $0xc8, AX			
  0x4bc12a		e8d155fcff		CALL runtime.panicBounds(SB)	
		e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]
  0x4bc12f		b890010000		MOVL $0x190, AX			
  0x4bc134		b990010000		MOVL $0x190, CX			
  0x4bc139		e8c255fcff		CALL runtime.panicBounds(SB)	
  0x4bc13e		b890010000		MOVL $0x190, AX			
  0x4bc143		e8b855fcff		CALL runtime.panicBounds(SB)	
		c0 = sim.X_e[k] * INV_DX
  0x4bc148		b840420f00		MOVL $0xf4240, AX		
  0x4bc14d		e8ae55fcff		CALL runtime.panicBounds(SB)	
  0x4bc152		90			NOPL				


