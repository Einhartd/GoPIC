// =============================================================================
// SYMBOL: Step3MoveAndBoundariesElectrons
// =============================================================================

TEXT gopic.(*SimulationState).Step3MoveAndBoundariesElectrons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/simulation.go
func (sim *SimulationState) Step3MoveAndBoundariesElectrons(t_index int) {
  0x1400c4000		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c4004		0f86b4010000		JBE 0x1400c41be		
  0x1400c400a		55			PUSHQ BP		
  0x1400c400b		4889e5			MOVQ SP, BP		
  0x1400c400e		4883ec10		SUBQ $0x10, SP		
	if sim.Measurement_mode {
  0x1400c4012		4889442420		MOVQ AX, 0x20(SP)	
  0x1400c4017		48895c2428		MOVQ BX, 0x28(SP)	
	sim.broadcastAndWait(CmdMoveElectronsAndBoundaries)
  0x1400c401c		bb02000000		MOVL $0x2, BX						
  0x1400c4021		e85af8ffff		CALL gopic.(*SimulationState).broadcastAndWait(SB)	
	if sim.Measurement_mode {
  0x1400c4026		488b4c2420		MOVQ 0x20(SP), CX		
  0x1400c402b		8401			TESTB AL, 0(CX)			
  0x1400c402d		80b9e02dba0700		CMPB 0x7ba2de0(CX), $0x0	
  0x1400c4034		7409			JE 0x1400c403f			
  0x1400c4036		31c0			XORL AX, AX			
  0x1400c4038		488b542428		MOVQ 0x28(SP), DX		
  0x1400c403d		eb41			JMP 0x1400c4080			
}
  0x1400c403f		4883c410		ADDQ $0x10, SP		
  0x1400c4043		5d			POPQ BP			
  0x1400c4044		c3			RET			
			sim.Mean_energy_accu_center += diag.accuCenter
  0x1400c4045		f20f10843380700000	MOVSD_XMM 0x7080(BX)(SI*1), X0	
  0x1400c404e		f20f5881802dba07	ADDSD 0x7ba2d80(CX), X0		
  0x1400c4056		f20f1181802dba07	MOVSD_XMM X0, 0x7ba2d80(CX)	
			sim.Mean_energy_counter_center += diag.counterCenter
  0x1400c405e		488bb9882dba07		MOVQ 0x7ba2d88(CX), DI		
  0x1400c4065		4803bc3388700000	ADDQ 0x7088(BX)(SI*1), DI	
  0x1400c406d		4889b9882dba07		MOVQ DI, 0x7ba2d88(CX)		
		for w := 0; w < sim.NumWorkers; w++ {
  0x1400c4074		48ffc0			INCQ AX			
  0x1400c4077		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x1400c4080		483981482eba07		CMPQ 0x7ba2e48(CX), AX	
  0x1400c4087		7eb6			JLE 0x1400c403f		
			diag := &sim.WorkerEDiag[w]
  0x1400c4089		488b5938		MOVQ 0x38(CX), BX	
  0x1400c408d		4839d8			CMPQ AX, BX		
  0x1400c4090		0f8322010000		JAE 0x1400c41b8		
  0x1400c4096		488b5930		MOVQ 0x30(CX), BX	
  0x1400c409a		4869f0c0700000		IMULQ $0x70c0, AX, SI	
			for p := 0; p < N_G; p++ {
  0x1400c40a1		31ff			XORL DI, DI		
  0x1400c40a3		e998000000		JMP 0x1400c4140		
				sim.Counter_e_xt[p][t_index] += diag.counter_e[p]
  0x1400c40a8		4c8d1433		LEAQ 0(BX)(SI*1), R10		
  0x1400c40ac		f2410f1004fa		MOVSD_XMM 0(R10)(DI*8), X0	
  0x1400c40b2		f2410f5804d1		ADDSD 0(R9)(DX*8), X0		
  0x1400c40b8		f2410f1104d1		MOVSD_XMM X0, 0(R9)(DX*8)	
				sim.Ue_xt[p][t_index] += diag.ue[p]
  0x1400c40be		4e8d0c01		LEAQ 0(CX)(R8*1), R9		
  0x1400c40c2		4d8d8980c14e07		LEAQ 0x74ec180(R9), R9		
  0x1400c40c9		4c8d1433		LEAQ 0(BX)(SI*1), R10		
  0x1400c40cd		4d8d92800c0000		LEAQ 0xc80(R10), R10		
  0x1400c40d4		f2410f1004fa		MOVSD_XMM 0(R10)(DI*8), X0	
  0x1400c40da		f2410f5804d1		ADDSD 0(R9)(DX*8), X0		
  0x1400c40e0		f2410f1104d1		MOVSD_XMM X0, 0(R9)(DX*8)	
				sim.Meanee_xt[p][t_index] += diag.meanee[p]
  0x1400c40e6		4e8d0c01		LEAQ 0(CX)(R8*1), R9		
  0x1400c40ea		4d8d8980598907		LEAQ 0x7895980(R9), R9		
  0x1400c40f1		4c8d1433		LEAQ 0(BX)(SI*1), R10		
  0x1400c40f5		4d8d9200190000		LEAQ 0x1900(R10), R10		
  0x1400c40fc		f2410f1004fa		MOVSD_XMM 0(R10)(DI*8), X0	
  0x1400c4102		f2410f5804d1		ADDSD 0(R9)(DX*8), X0		
  0x1400c4108		f2410f1104d1		MOVSD_XMM X0, 0(R9)(DX*8)	
				sim.Ioniz_rate_xt[p][t_index] += diag.ioniz[p]
  0x1400c410e		4e8d0401		LEAQ 0(CX)(R8*1), R8		
  0x1400c4112		4d8d808069b007		LEAQ 0x7b06980(R8), R8		
  0x1400c4119		4c8d0c33		LEAQ 0(BX)(SI*1), R9		
  0x1400c411d		4d8d8980250000		LEAQ 0x2580(R9), R9		
  0x1400c4124		f2410f1004f9		MOVSD_XMM 0(R9)(DI*8), X0	
  0x1400c412a		f2410f5804d0		ADDSD 0(R8)(DX*8), X0		
  0x1400c4130		f2410f1104d0		MOVSD_XMM X0, 0(R8)(DX*8)	
			for p := 0; p < N_G; p++ {
  0x1400c4136		48ffc7			INCQ DI			
  0x1400c4139		0f1f8000000000		NOPL 0(AX)		
  0x1400c4140		4881ff90010000		CMPQ DI, $0x190		
  0x1400c4147		7d26			JGE 0x1400c416f		
				sim.Counter_e_xt[p][t_index] += diag.counter_e[p]
  0x1400c4149		4c69c740060000		IMULQ $0x640, DI, R8	
  0x1400c4150		4e8d0c01		LEAQ 0(CX)(R8*1), R9	
  0x1400c4154		4d8d8980e19c07		LEAQ 0x79ce180(R9), R9	
  0x1400c415b		0f1f440000		NOPL 0(AX)(AX*1)	
  0x1400c4160		4881fac8000000		CMPQ DX, $0xc8		
  0x1400c4167		0f823bffffff		JB 0x1400c40a8		
  0x1400c416d		eb3f			JMP 0x1400c41ae		
			for p := 0; p < N_G; p++ {
  0x1400c416f		31ff			XORL DI, DI		
  0x1400c4171		eb2d			JMP 0x1400c41a0		
				sim.Eepf[eIdx] += diag.eepf[eIdx]
  0x1400c4173		4c8d0433		LEAQ 0(BX)(SI*1), R8			
  0x1400c4177		4d8d8000320000		LEAQ 0x3200(R8), R8			
  0x1400c417e		f2410f1004f8		MOVSD_XMM 0(R8)(DI*8), X0		
  0x1400c4184		f20f5884f970662707	ADDSD 0x7276670(CX)(DI*8), X0		
  0x1400c418d		f20f1184f970662707	MOVSD_XMM X0, 0x7276670(CX)(DI*8)	
			for eIdx := 0; eIdx < N_EEPF; eIdx++ {
  0x1400c4196		48ffc7			INCQ DI			
  0x1400c4199		0f1f8000000000		NOPL 0(AX)		
  0x1400c41a0		4881ffd0070000		CMPQ DI, $0x7d0		
  0x1400c41a7		7cca			JL 0x1400c4173		
  0x1400c41a9		e997feffff		JMP 0x1400c4045		
				sim.Counter_e_xt[p][t_index] += diag.counter_e[p]
  0x1400c41ae		b8c8000000		MOVL $0xc8, AX			
  0x1400c41b3		e8c8a2fbff		CALL runtime.panicBounds(SB)	
			diag := &sim.WorkerEDiag[w]
  0x1400c41b8		e8c3a2fbff		CALL runtime.panicBounds(SB)	
  0x1400c41bd		90			NOPL				
func (sim *SimulationState) Step3MoveAndBoundariesElectrons(t_index int) {
  0x1400c41be		4889442408		MOVQ AX, 0x8(SP)							
  0x1400c41c3		48895c2410		MOVQ BX, 0x10(SP)							
  0x1400c41c8		e87384fbff		CALL runtime.morestack_noctxt.abi0(SB)					
  0x1400c41cd		488b442408		MOVQ 0x8(SP), AX							
  0x1400c41d2		488b5c2410		MOVQ 0x10(SP), BX							
  0x1400c41d7		e924feffff		JMP gopic.(*SimulationState).Step3MoveAndBoundariesElectrons(SB)	

  0x1400c41dc		cc			INT $0x3		
  0x1400c41dd		cc			INT $0x3		
  0x1400c41de		cc			INT $0x3		
  0x1400c41df		cc			INT $0x3		


