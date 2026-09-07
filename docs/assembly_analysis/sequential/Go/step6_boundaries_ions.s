// --- Symbol: Step6CheckBoundariesIons ---
TEXT gopic.(*SimulationState).Step6CheckBoundariesIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/native_version/simulation.go
func (sim *SimulationState) Step6CheckBoundariesIons(t int) {
  0x4bc580		55			PUSHQ BP		
  0x4bc581		4889e5			MOVQ SP, BP		
	if (t % N_SUB) != 0 {
  0x4bc584		48b9cdcccccccccccccc	MOVQ $0xcccccccccccccccd, CX	
  0x4bc58e		480fafd9		IMULQ CX, BX			
  0x4bc592		48b99899999999999919	MOVQ $0x1999999999999998, CX	
  0x4bc59c		4801d9			ADDQ BX, CX			
  0x4bc59f		48c1c13e		ROLQ $0x3e, CX			
  0x4bc5a3		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x4bc5ad		4839ca			CMPQ DX, CX			
  0x4bc5b0		7204			JB 0x4bc5b6			
  0x4bc5b2		31c9			XORL CX, CX			
  0x4bc5b4		eb02			JMP 0x4bc5b8			
		return
  0x4bc5b6		5d			POPQ BP			
  0x4bc5b7		c3			RET			
	for k < sim.N_i {
  0x4bc5b8		8400			TESTB AL, 0(AX)		
  0x4bc5ba		660f1f440000		NOPW 0(AX)(AX*1)	
  0x4bc5c0		483988087e5603		CMPQ 0x3567e08(AX), CX	
  0x4bc5c7		0f8ee8010000		JLE 0x4bc7b5		
		if sim.X_i[k] < 0 { // the ion is out at the powered electrode
  0x4bc5cd		4881f940420f00		CMPQ CX, $0xf4240			
  0x4bc5d4		0f831f020000		JAE 0x4bc7f9				
  0x4bc5da		f20f1084c810c63e05	MOVSD_XMM 0x53ec610(AX)(CX*8), X0	
  0x4bc5e3		0f57c9			XORPS X1, X1				
  0x4bc5e6		660f2ec8		UCOMISD X0, X1				
  0x4bc5ea		767e			JBE 0x4bc66a				
			sim.N_i_abs_pow++
  0x4bc5ec		48ff8020592707		INCQ 0x7275920(AX)	
			v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x4bc5f3		f20f1094c810d8b805	MOVSD_XMM 0x5b8d810(AX)(CX*8), X2	
  0x4bc5fc		f20f59d2		MULSD X2, X2				
  0x4bc600		f20f109cc810ea3206	MOVSD_XMM 0x632ea10(AX)(CX*8), X3	
  0x4bc609		c4e2e1b9d3		VFMADD231SD X3, X3, X2			
  0x4bc60e		f20f109cc810fcac06	MOVSD_XMM 0x6acfc10(AX)(CX*8), X3	
  0x4bc617		c4e2e1b9d3		VFMADD231SD X3, X3, X2			
			energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
  0x4bc61c		f20f101d0ce10000	MOVSD_XMM $f64.3aa4879de14d0b24(SB), X3	
  0x4bc624		f20f59d3		MULSD X3, X2				
  0x4bc628		f20f102518e10000	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X4	
  0x4bc630		f20f5ed4		DIVSD X4, X2				
			energy_index = int(energy / DE_IFED)
  0x4bc634		f2480f2cd2		CVTTSD2SIQ X2, DX	
  0x4bc639		0f1f8000000000		NOPL 0(AX)		
			if energy_index < N_IFED {
  0x4bc640		4881fac8000000		CMPQ DX, $0xc8		
  0x4bc647		7d1b			JGE 0x4bc664		
  0x4bc649		4881fac8000000		CMPQ DX, $0xc8		
				sim.Ifed_pow[energy_index]++ // save IFED at the powered electrode
  0x4bc650		0f8399010000		JAE 0x4bc7ef			
  0x4bc656		48ff84d0b0972707	INCQ 0x72797b0(AX)(DX*8)	
		if sim.X_i[k] < 0 { // the ion is out at the powered electrode
  0x4bc65e		660f2ec8		UCOMISD X0, X1		
				sim.Ifed_pow[energy_index]++ // save IFED at the powered electrode
  0x4bc662		eb16			JMP 0x4bc67a		
		if sim.X_i[k] < 0 { // the ion is out at the powered electrode
  0x4bc664		660f2ec8		UCOMISD X0, X1		
			if energy_index < N_IFED {
  0x4bc668		eb10			JMP 0x4bc67a				
  0x4bc66a		f20f101dbee00000	MOVSD_XMM $f64.3aa4879de14d0b24(SB), X3	
  0x4bc672		f20f1025cee00000	MOVSD_XMM $f64.3c07a4da2594bb57(SB), X4	
		if sim.X_i[k] < 0 { // the ion is out at the powered electrode
  0x4bc67a		0f97c2			SETA DL			
		if sim.X_i[k] > L { // the ion is out at the grounded electrode
  0x4bc67d		f20f1084c810c63e05	MOVSD_XMM 0x53ec610(AX)(CX*8), X0	
  0x4bc686		f20f101542e00000	MOVSD_XMM 0xe042(IP), X2		
  0x4bc68e		660f2ec2		UCOMISD X2, X0				
  0x4bc692		765f			JBE 0x4bc6f3				
			sim.N_i_abs_gnd++
  0x4bc694		48ff8028592707		INCQ 0x7275928(AX)	
			v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x4bc69b		f20f1084c810d8b805	MOVSD_XMM 0x5b8d810(AX)(CX*8), X0	
  0x4bc6a4		f20f59c0		MULSD X0, X0				
  0x4bc6a8		f20f10acc810ea3206	MOVSD_XMM 0x632ea10(AX)(CX*8), X5	
  0x4bc6b1		c4e2d1b9c5		VFMADD231SD X5, X5, X0			
  0x4bc6b6		f20f10acc810fcac06	MOVSD_XMM 0x6acfc10(AX)(CX*8), X5	
  0x4bc6bf		c4e2d1b9c5		VFMADD231SD X5, X5, X0			
			energy = 0.5 * AR_MASS * v_sqr / EV_TO_J
  0x4bc6c4		f20f59c3		MULSD X3, X0		
  0x4bc6c8		f20f5ec4		DIVSD X4, X0		
			energy_index = int(energy / DE_IFED)
  0x4bc6cc		f2480f2cd0		CVTTSD2SIQ X0, DX	
			if energy_index < N_IFED {
  0x4bc6d1		4881fac8000000		CMPQ DX, $0xc8		
  0x4bc6d8		7d14			JGE 0x4bc6ee		
  0x4bc6da		660f1f440000		NOPW 0(AX)(AX*1)	
				sim.Ifed_gnd[energy_index]++ // save IFED at the grounded electrode
  0x4bc6e0		0f83ff000000		JAE 0x4bc7e5			
  0x4bc6e6		48ff84d0f09d2707	INCQ 0x7279df0(AX)(DX*8)	
  0x4bc6ee		ba01000000		MOVL $0x1, DX			
		if out { // delete the ion, if out
  0x4bc6f3		84d2			TESTL DL, DL		
  0x4bc6f5		0f84b2000000		JE 0x4bc7ad		
			sim.X_i[k] = sim.X_i[sim.N_i-1]
  0x4bc6fb		488b90087e5603		MOVQ 0x3567e08(AX), DX			
  0x4bc702		488d5aff		LEAQ -0x1(DX), BX			
  0x4bc706		4881fb40420f00		CMPQ BX, $0xf4240			
  0x4bc70d		0f83c6000000		JAE 0x4bc7d9				
  0x4bc713		f20f1084d008c63e05	MOVSD_XMM 0x53ec608(AX)(DX*8), X0	
  0x4bc71c		f20f1184c810c63e05	MOVSD_XMM X0, 0x53ec610(AX)(CX*8)	
			sim.Vx_i[k] = sim.Vx_i[sim.N_i-1]
  0x4bc725		488b90087e5603		MOVQ 0x3567e08(AX), DX			
  0x4bc72c		488d5aff		LEAQ -0x1(DX), BX			
  0x4bc730		4881fb40420f00		CMPQ BX, $0xf4240			
  0x4bc737		0f8392000000		JAE 0x4bc7cf				
  0x4bc73d		f20f1084d008d8b805	MOVSD_XMM 0x5b8d808(AX)(DX*8), X0	
  0x4bc746		f20f1184c810d8b805	MOVSD_XMM X0, 0x5b8d810(AX)(CX*8)	
			sim.Vy_i[k] = sim.Vy_i[sim.N_i-1]
  0x4bc74f		488b90087e5603		MOVQ 0x3567e08(AX), DX			
  0x4bc756		488d5aff		LEAQ -0x1(DX), BX			
  0x4bc75a		660f1f440000		NOPW 0(AX)(AX*1)			
  0x4bc760		4881fb40420f00		CMPQ BX, $0xf4240			
  0x4bc767		735c			JAE 0x4bc7c5				
  0x4bc769		f20f1084d008ea3206	MOVSD_XMM 0x632ea08(AX)(DX*8), X0	
  0x4bc772		f20f1184c810ea3206	MOVSD_XMM X0, 0x632ea10(AX)(CX*8)	
			sim.Vz_i[k] = sim.Vz_i[sim.N_i-1]
  0x4bc77b		488b90087e5603		MOVQ 0x3567e08(AX), DX			
  0x4bc782		488d5aff		LEAQ -0x1(DX), BX			
  0x4bc786		4881fb40420f00		CMPQ BX, $0xf4240			
  0x4bc78d		7328			JAE 0x4bc7b7				
  0x4bc78f		f20f1084d008fcac06	MOVSD_XMM 0x6acfc08(AX)(DX*8), X0	
  0x4bc798		f20f1184c810fcac06	MOVSD_XMM X0, 0x6acfc10(AX)(CX*8)	
			sim.N_i--
  0x4bc7a1		48ff88087e5603		DECQ 0x3567e08(AX)	
  0x4bc7a8		e90bfeffff		JMP 0x4bc5b8		
			k++
  0x4bc7ad		48ffc1			INCQ CX			
  0x4bc7b0		e903feffff		JMP 0x4bc5b8		
}
  0x4bc7b5		5d			POPQ BP			
  0x4bc7b6		c3			RET			
			sim.Vz_i[k] = sim.Vz_i[sim.N_i-1]
  0x4bc7b7		b840420f00		MOVL $0xf4240, AX		
  0x4bc7bc		0f1f4000		NOPL 0(AX)			
  0x4bc7c0		e83b4ffcff		CALL runtime.panicBounds(SB)	
			sim.Vy_i[k] = sim.Vy_i[sim.N_i-1]
  0x4bc7c5		b840420f00		MOVL $0xf4240, AX		
  0x4bc7ca		e8314ffcff		CALL runtime.panicBounds(SB)	
			sim.Vx_i[k] = sim.Vx_i[sim.N_i-1]
  0x4bc7cf		b840420f00		MOVL $0xf4240, AX		
  0x4bc7d4		e8274ffcff		CALL runtime.panicBounds(SB)	
			sim.X_i[k] = sim.X_i[sim.N_i-1]
  0x4bc7d9		b840420f00		MOVL $0xf4240, AX		
  0x4bc7de		6690			NOPW				
  0x4bc7e0		e81b4ffcff		CALL runtime.panicBounds(SB)	
				sim.Ifed_gnd[energy_index]++ // save IFED at the grounded electrode
  0x4bc7e5		b8c8000000		MOVL $0xc8, AX			
  0x4bc7ea		e8114ffcff		CALL runtime.panicBounds(SB)	
				sim.Ifed_pow[energy_index]++ // save IFED at the powered electrode
  0x4bc7ef		b8c8000000		MOVL $0xc8, AX			
  0x4bc7f4		e8074ffcff		CALL runtime.panicBounds(SB)	
		if sim.X_i[k] < 0 { // the ion is out at the powered electrode
  0x4bc7f9		b840420f00		MOVL $0xf4240, AX		
  0x4bc7fe		6690			NOPW				
  0x4bc800		e8fb4efcff		CALL runtime.panicBounds(SB)	
  0x4bc805		90			NOPL				


