// =============================================================================
// SYMBOL: Step3MoveElectrons
// =============================================================================

TEXT gopic.(*SimulationState).Step3MoveElectrons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation.go
func (sim *SimulationState) Step3MoveElectrons(t_index int) {
  0x1400c37e0		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c37e4		0f8621020000		JBE 0x1400c3a0b		
  0x1400c37ea		55			PUSHQ BP		
  0x1400c37eb		4889e5			MOVQ SP, BP		
  0x1400c37ee		4883ec28		SUBQ $0x28, SP		
	for w := range numWorkers {
  0x1400c37f2		4889442438		MOVQ AX, 0x38(SP)	
  0x1400c37f7		48895c2440		MOVQ BX, 0x40(SP)	
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c37fc		8400			TESTB AL, 0(AX)		
	sim.broadcastAndWait(CmdMoveElectrons)
  0x1400c37fe		90			NOPL			
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c37ff		488b88582eba07		MOVQ 0x7ba2e58(AX), CX	
  0x1400c3806		48894c2418		MOVQ CX, 0x18(SP)	
  0x1400c380b		31d2			XORL DX, DX		
	for w := range numWorkers {
  0x1400c380d		eb31			JMP 0x1400c3840		
  0x1400c380f		4889542410		MOVQ DX, 0x10(SP)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3814		488b88502eba07		MOVQ 0x7ba2e50(AX), CX		
  0x1400c381b		488b04d1		MOVQ 0(CX)(DX*8), AX		
  0x1400c381f		488d5c2420		LEAQ 0x20(SP), BX		
  0x1400c3824		e8d7cef4ff		CALL runtime.chansend1(SB)	
	for w := range numWorkers {
  0x1400c3829		488b542410		MOVQ 0x10(SP), DX	
  0x1400c382e		48ffc2			INCQ DX			
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3831		488b442438		MOVQ 0x38(SP), AX	
	for w := range numWorkers {
  0x1400c3836		488b4c2418		MOVQ 0x18(SP), CX	
				sim.Counter_e_xt[p][t_index] += diag.counter_e[p]
  0x1400c383b		488b5c2440		MOVQ 0x40(SP), BX	
	for w := range numWorkers {
  0x1400c3840		4839ca			CMPQ DX, CX		
  0x1400c3843		7d3f			JGE 0x1400c3884		
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3845		48c744242002000000	MOVQ $0x2, 0x20(SP)	
  0x1400c384e		488bb0582eba07		MOVQ 0x7ba2e58(AX), SI	
  0x1400c3855		4839f2			CMPQ DX, SI		
  0x1400c3858		72b5			JB 0x1400c380f		
  0x1400c385a		e9a6010000		JMP 0x1400c3a05		
	for range numWorkers {
  0x1400c385f		48894c2418		MOVQ CX, 0x18(SP)	
		<-sim.WorkerDoneChan
  0x1400c3864		488b80682eba07		MOVQ 0x7ba2e68(AX), AX		
  0x1400c386b		31db			XORL BX, BX			
  0x1400c386d		e80eddf4ff		CALL runtime.chanrecv1(SB)	
	for range numWorkers {
  0x1400c3872		488b4c2418		MOVQ 0x18(SP), CX	
  0x1400c3877		48ffc9			DECQ CX			
		<-sim.WorkerDoneChan
  0x1400c387a		488b442438		MOVQ 0x38(SP), AX	
				sim.Counter_e_xt[p][t_index] += diag.counter_e[p]
  0x1400c387f		488b5c2440		MOVQ 0x40(SP), BX	
	for range numWorkers {
  0x1400c3884		4885c9			TESTQ CX, CX		
  0x1400c3887		7fd6			JG 0x1400c385f		
	if sim.Measurement_mode {
  0x1400c3889		80b8e02dba0700		CMPB 0x7ba2de0(AX), $0x0	
  0x1400c3890		740b			JE 0x1400c389d			
		numWorkers := len(sim.WorkerCmdChan)
  0x1400c3892		488b88582eba07		MOVQ 0x7ba2e58(AX), CX	
		for w := range numWorkers {
  0x1400c3899		31d2			XORL DX, DX		
  0x1400c389b		eb38			JMP 0x1400c38d5		
}
  0x1400c389d		4883c428		ADDQ $0x28, SP		
  0x1400c38a1		5d			POPQ BP			
  0x1400c38a2		c3			RET			
			sim.Mean_energy_accu_center += diag.accuCenter
  0x1400c38a3		f20f10843e80700000	MOVSD_XMM 0x7080(SI)(DI*1), X0	
  0x1400c38ac		f20f5880802dba07	ADDSD 0x7ba2d80(AX), X0		
  0x1400c38b4		f20f1180802dba07	MOVSD_XMM X0, 0x7ba2d80(AX)	
			sim.Mean_energy_counter_center += diag.counterCenter
  0x1400c38bc		4c8b80882dba07		MOVQ 0x7ba2d88(AX), R8		
  0x1400c38c3		4c03843e88700000	ADDQ 0x7088(SI)(DI*1), R8	
  0x1400c38cb		4c8980882dba07		MOVQ R8, 0x7ba2d88(AX)		
		for w := range numWorkers {
  0x1400c38d2		48ffc2			INCQ DX			
  0x1400c38d5		4839ca			CMPQ DX, CX		
  0x1400c38d8		7dc3			JGE 0x1400c389d		
			diag := &sim.WorkerEDiag[w]
  0x1400c38da		488b7038		MOVQ 0x38(AX), SI	
  0x1400c38de		6690			NOPW			
  0x1400c38e0		4839f2			CMPQ DX, SI		
  0x1400c38e3		0f8313010000		JAE 0x1400c39fc		
  0x1400c38e9		488b7030		MOVQ 0x30(AX), SI	
  0x1400c38ed		4869fac0700000		IMULQ $0x70c0, DX, DI	
			for p := range N_G {
  0x1400c38f4		4531c0			XORL R8, R8		
  0x1400c38f7		e991000000		JMP 0x1400c398d		
				sim.Counter_e_xt[p][t_index] += diag.counter_e[p]
  0x1400c38fc		4c8d1c3e		LEAQ 0(SI)(DI*1), R11		
  0x1400c3900		f2430f1004c3		MOVSD_XMM 0(R11)(R8*8), X0	
  0x1400c3906		f2410f5804da		ADDSD 0(R10)(BX*8), X0		
  0x1400c390c		f2410f1104da		MOVSD_XMM X0, 0(R10)(BX*8)	
				sim.Ue_xt[p][t_index] += diag.ue[p]
  0x1400c3912		4e8d1408		LEAQ 0(AX)(R9*1), R10		
  0x1400c3916		4d8d9280c14e07		LEAQ 0x74ec180(R10), R10	
  0x1400c391d		4c8d1c3e		LEAQ 0(SI)(DI*1), R11		
  0x1400c3921		4d8d9b800c0000		LEAQ 0xc80(R11), R11		
  0x1400c3928		f2430f1004c3		MOVSD_XMM 0(R11)(R8*8), X0	
  0x1400c392e		f2410f5804da		ADDSD 0(R10)(BX*8), X0		
  0x1400c3934		f2410f1104da		MOVSD_XMM X0, 0(R10)(BX*8)	
				sim.Meanee_xt[p][t_index] += diag.meanee[p]
  0x1400c393a		4e8d1408		LEAQ 0(AX)(R9*1), R10		
  0x1400c393e		4d8d9280598907		LEAQ 0x7895980(R10), R10	
  0x1400c3945		4c8d1c3e		LEAQ 0(SI)(DI*1), R11		
  0x1400c3949		4d8d9b00190000		LEAQ 0x1900(R11), R11		
  0x1400c3950		f2430f1004c3		MOVSD_XMM 0(R11)(R8*8), X0	
  0x1400c3956		f2410f5804da		ADDSD 0(R10)(BX*8), X0		
  0x1400c395c		f2410f1104da		MOVSD_XMM X0, 0(R10)(BX*8)	
				sim.Ioniz_rate_xt[p][t_index] += diag.ioniz[p]
  0x1400c3962		4e8d0c08		LEAQ 0(AX)(R9*1), R9		
  0x1400c3966		4d8d898069b007		LEAQ 0x7b06980(R9), R9		
  0x1400c396d		4c8d143e		LEAQ 0(SI)(DI*1), R10		
  0x1400c3971		4d8d9280250000		LEAQ 0x2580(R10), R10		
  0x1400c3978		f2430f1004c2		MOVSD_XMM 0(R10)(R8*8), X0	
  0x1400c397e		f2410f5804d9		ADDSD 0(R9)(BX*8), X0		
  0x1400c3984		f2410f1104d9		MOVSD_XMM X0, 0(R9)(BX*8)	
			for p := range N_G {
  0x1400c398a		49ffc0			INCQ R8			
  0x1400c398d		4981f890010000		CMPQ R8, $0x190		
  0x1400c3994		7d21			JGE 0x1400c39b7		
				sim.Counter_e_xt[p][t_index] += diag.counter_e[p]
  0x1400c3996		4d69c840060000		IMULQ $0x640, R8, R9		
  0x1400c399d		4e8d1408		LEAQ 0(AX)(R9*1), R10		
  0x1400c39a1		4d8d9280e19c07		LEAQ 0x79ce180(R10), R10	
  0x1400c39a8		4881fbc8000000		CMPQ BX, $0xc8			
  0x1400c39af		0f8247ffffff		JB 0x1400c38fc			
  0x1400c39b5		eb3b			JMP 0x1400c39f2			
			for p := range N_G {
  0x1400c39b7		4531c0			XORL R8, R8		
  0x1400c39ba		eb28			JMP 0x1400c39e4		
				sim.Eepf[eIdx] += diag.eepf[eIdx]
  0x1400c39bc		4c8d0c3e		LEAQ 0(SI)(DI*1), R9			
  0x1400c39c0		4d8d8900320000		LEAQ 0x3200(R9), R9			
  0x1400c39c7		f2430f1004c1		MOVSD_XMM 0(R9)(R8*8), X0		
  0x1400c39cd		f2420f5884c070662707	ADDSD 0x7276670(AX)(R8*8), X0		
  0x1400c39d7		f2420f1184c070662707	MOVSD_XMM X0, 0x7276670(AX)(R8*8)	
			for eIdx := range N_EEPF {
  0x1400c39e1		49ffc0			INCQ R8			
  0x1400c39e4		4981f8d0070000		CMPQ R8, $0x7d0		
  0x1400c39eb		7ccf			JL 0x1400c39bc		
  0x1400c39ed		e9b1feffff		JMP 0x1400c38a3		
				sim.Counter_e_xt[p][t_index] += diag.counter_e[p]
  0x1400c39f2		b8c8000000		MOVL $0xc8, AX			
  0x1400c39f7		e884aafbff		CALL runtime.panicBounds(SB)	
			diag := &sim.WorkerEDiag[w]
  0x1400c39fc		0f1f4000		NOPL 0(AX)			
  0x1400c3a00		e87baafbff		CALL runtime.panicBounds(SB)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3a05		e876aafbff		CALL runtime.panicBounds(SB)	
  0x1400c3a0a		90			NOPL				
func (sim *SimulationState) Step3MoveElectrons(t_index int) {
  0x1400c3a0b		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c3a10		48895c2410		MOVQ BX, 0x10(SP)					
  0x1400c3a15		e8268cfbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c3a1a		488b442408		MOVQ 0x8(SP), AX					
  0x1400c3a1f		488b5c2410		MOVQ 0x10(SP), BX					
  0x1400c3a24		e9b7fdffff		JMP gopic.(*SimulationState).Step3MoveElectrons(SB)	

  0x1400c3a29		cc			INT $0x3		
  0x1400c3a2a		cc			INT $0x3		
  0x1400c3a2b		cc			INT $0x3		
  0x1400c3a2c		cc			INT $0x3		
  0x1400c3a2d		cc			INT $0x3		
  0x1400c3a2e		cc			INT $0x3		
  0x1400c3a2f		cc			INT $0x3		
  0x1400c3a30		cc			INT $0x3		
  0x1400c3a31		cc			INT $0x3		
  0x1400c3a32		cc			INT $0x3		
  0x1400c3a33		cc			INT $0x3		
  0x1400c3a34		cc			INT $0x3		
  0x1400c3a35		cc			INT $0x3		
  0x1400c3a36		cc			INT $0x3		
  0x1400c3a37		cc			INT $0x3		
  0x1400c3a38		cc			INT $0x3		
  0x1400c3a39		cc			INT $0x3		
  0x1400c3a3a		cc			INT $0x3		
  0x1400c3a3b		cc			INT $0x3		
  0x1400c3a3c		cc			INT $0x3		
  0x1400c3a3d		cc			INT $0x3		
  0x1400c3a3e		cc			INT $0x3		
  0x1400c3a3f		cc			INT $0x3		


