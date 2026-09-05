TEXT gopic.(*SimulationState).Step3MoveElectrons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation.go
func (sim *SimulationState) Step3MoveElectrons(t_index int) {
  0x1400c3a40		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c3a44		0f8621020000		JBE 0x1400c3c6b		
  0x1400c3a4a		55			PUSHQ BP		
  0x1400c3a4b		4889e5			MOVQ SP, BP		
  0x1400c3a4e		4883ec28		SUBQ $0x28, SP		
	for w := range numWorkers {
  0x1400c3a52		4889442438		MOVQ AX, 0x38(SP)	
  0x1400c3a57		48895c2440		MOVQ BX, 0x40(SP)	
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c3a5c		8400			TESTB AL, 0(AX)		
	sim.broadcastAndWait(CmdMoveElectrons)
  0x1400c3a5e		90			NOPL			
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c3a5f		488b88402eba07		MOVQ 0x7ba2e40(AX), CX	
  0x1400c3a66		48894c2418		MOVQ CX, 0x18(SP)	
  0x1400c3a6b		31d2			XORL DX, DX		
	for w := range numWorkers {
  0x1400c3a6d		eb31			JMP 0x1400c3aa0		
  0x1400c3a6f		4889542410		MOVQ DX, 0x10(SP)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3a74		488b88382eba07		MOVQ 0x7ba2e38(AX), CX		
  0x1400c3a7b		488b04d1		MOVQ 0(CX)(DX*8), AX		
  0x1400c3a7f		488d5c2420		LEAQ 0x20(SP), BX		
  0x1400c3a84		e877ccf4ff		CALL runtime.chansend1(SB)	
	for w := range numWorkers {
  0x1400c3a89		488b542410		MOVQ 0x10(SP), DX	
  0x1400c3a8e		48ffc2			INCQ DX			
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3a91		488b442438		MOVQ 0x38(SP), AX	
	for w := range numWorkers {
  0x1400c3a96		488b4c2418		MOVQ 0x18(SP), CX	
				sim.Counter_e_xt[p][t_index] += diag.counter_e[p]
  0x1400c3a9b		488b5c2440		MOVQ 0x40(SP), BX	
	for w := range numWorkers {
  0x1400c3aa0		4839ca			CMPQ DX, CX		
  0x1400c3aa3		7d3f			JGE 0x1400c3ae4		
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3aa5		48c744242002000000	MOVQ $0x2, 0x20(SP)	
  0x1400c3aae		488bb0402eba07		MOVQ 0x7ba2e40(AX), SI	
  0x1400c3ab5		4839f2			CMPQ DX, SI		
  0x1400c3ab8		72b5			JB 0x1400c3a6f		
  0x1400c3aba		e9a6010000		JMP 0x1400c3c65		
	for range numWorkers {
  0x1400c3abf		48894c2418		MOVQ CX, 0x18(SP)	
		<-sim.WorkerDoneChan
  0x1400c3ac4		488b80502eba07		MOVQ 0x7ba2e50(AX), AX		
  0x1400c3acb		31db			XORL BX, BX			
  0x1400c3acd		e8aedaf4ff		CALL runtime.chanrecv1(SB)	
	for range numWorkers {
  0x1400c3ad2		488b4c2418		MOVQ 0x18(SP), CX	
  0x1400c3ad7		48ffc9			DECQ CX			
		<-sim.WorkerDoneChan
  0x1400c3ada		488b442438		MOVQ 0x38(SP), AX	
				sim.Counter_e_xt[p][t_index] += diag.counter_e[p]
  0x1400c3adf		488b5c2440		MOVQ 0x40(SP), BX	
	for range numWorkers {
  0x1400c3ae4		4885c9			TESTQ CX, CX		
  0x1400c3ae7		7fd6			JG 0x1400c3abf		
	if sim.Measurement_mode {
  0x1400c3ae9		80b8e02dba0700		CMPB 0x7ba2de0(AX), $0x0	
  0x1400c3af0		740b			JE 0x1400c3afd			
		numWorkers := len(sim.WorkerCmdChan)
  0x1400c3af2		488b88402eba07		MOVQ 0x7ba2e40(AX), CX	
		for w := range numWorkers {
  0x1400c3af9		31d2			XORL DX, DX		
  0x1400c3afb		eb38			JMP 0x1400c3b35		
}
  0x1400c3afd		4883c428		ADDQ $0x28, SP		
  0x1400c3b01		5d			POPQ BP			
  0x1400c3b02		c3			RET			
			sim.Mean_energy_accu_center += diag.accuCenter
  0x1400c3b03		f20f10843e80700000	MOVSD_XMM 0x7080(SI)(DI*1), X0	
  0x1400c3b0c		f20f5880802dba07	ADDSD 0x7ba2d80(AX), X0		
  0x1400c3b14		f20f1180802dba07	MOVSD_XMM X0, 0x7ba2d80(AX)	
			sim.Mean_energy_counter_center += diag.counterCenter
  0x1400c3b1c		4c8b80882dba07		MOVQ 0x7ba2d88(AX), R8		
  0x1400c3b23		4c03843e88700000	ADDQ 0x7088(SI)(DI*1), R8	
  0x1400c3b2b		4c8980882dba07		MOVQ R8, 0x7ba2d88(AX)		
		for w := range numWorkers {
  0x1400c3b32		48ffc2			INCQ DX			
  0x1400c3b35		4839ca			CMPQ DX, CX		
  0x1400c3b38		7dc3			JGE 0x1400c3afd		
			diag := &sim.WorkerEDiag[w]
  0x1400c3b3a		488b7038		MOVQ 0x38(AX), SI	
  0x1400c3b3e		6690			NOPW			
  0x1400c3b40		4839f2			CMPQ DX, SI		
  0x1400c3b43		0f8313010000		JAE 0x1400c3c5c		
  0x1400c3b49		488b7030		MOVQ 0x30(AX), SI	
  0x1400c3b4d		4869fac0700000		IMULQ $0x70c0, DX, DI	
			for p := range N_G {
  0x1400c3b54		4531c0			XORL R8, R8		
  0x1400c3b57		e991000000		JMP 0x1400c3bed		
				sim.Counter_e_xt[p][t_index] += diag.counter_e[p]
  0x1400c3b5c		4c8d1c3e		LEAQ 0(SI)(DI*1), R11		
  0x1400c3b60		f2430f1004c3		MOVSD_XMM 0(R11)(R8*8), X0	
  0x1400c3b66		f2410f5804da		ADDSD 0(R10)(BX*8), X0		
  0x1400c3b6c		f2410f1104da		MOVSD_XMM X0, 0(R10)(BX*8)	
				sim.Ue_xt[p][t_index] += diag.ue[p]
  0x1400c3b72		4e8d1408		LEAQ 0(AX)(R9*1), R10		
  0x1400c3b76		4d8d9280c14e07		LEAQ 0x74ec180(R10), R10	
  0x1400c3b7d		4c8d1c3e		LEAQ 0(SI)(DI*1), R11		
  0x1400c3b81		4d8d9b800c0000		LEAQ 0xc80(R11), R11		
  0x1400c3b88		f2430f1004c3		MOVSD_XMM 0(R11)(R8*8), X0	
  0x1400c3b8e		f2410f5804da		ADDSD 0(R10)(BX*8), X0		
  0x1400c3b94		f2410f1104da		MOVSD_XMM X0, 0(R10)(BX*8)	
				sim.Meanee_xt[p][t_index] += diag.meanee[p]
  0x1400c3b9a		4e8d1408		LEAQ 0(AX)(R9*1), R10		
  0x1400c3b9e		4d8d9280598907		LEAQ 0x7895980(R10), R10	
  0x1400c3ba5		4c8d1c3e		LEAQ 0(SI)(DI*1), R11		
  0x1400c3ba9		4d8d9b00190000		LEAQ 0x1900(R11), R11		
  0x1400c3bb0		f2430f1004c3		MOVSD_XMM 0(R11)(R8*8), X0	
  0x1400c3bb6		f2410f5804da		ADDSD 0(R10)(BX*8), X0		
  0x1400c3bbc		f2410f1104da		MOVSD_XMM X0, 0(R10)(BX*8)	
				sim.Ioniz_rate_xt[p][t_index] += diag.ioniz[p]
  0x1400c3bc2		4e8d0c08		LEAQ 0(AX)(R9*1), R9		
  0x1400c3bc6		4d8d898069b007		LEAQ 0x7b06980(R9), R9		
  0x1400c3bcd		4c8d143e		LEAQ 0(SI)(DI*1), R10		
  0x1400c3bd1		4d8d9280250000		LEAQ 0x2580(R10), R10		
  0x1400c3bd8		f2430f1004c2		MOVSD_XMM 0(R10)(R8*8), X0	
  0x1400c3bde		f2410f5804d9		ADDSD 0(R9)(BX*8), X0		
  0x1400c3be4		f2410f1104d9		MOVSD_XMM X0, 0(R9)(BX*8)	
			for p := range N_G {
  0x1400c3bea		49ffc0			INCQ R8			
  0x1400c3bed		4981f890010000		CMPQ R8, $0x190		
  0x1400c3bf4		7d21			JGE 0x1400c3c17		
				sim.Counter_e_xt[p][t_index] += diag.counter_e[p]
  0x1400c3bf6		4d69c840060000		IMULQ $0x640, R8, R9		
  0x1400c3bfd		4e8d1408		LEAQ 0(AX)(R9*1), R10		
  0x1400c3c01		4d8d9280e19c07		LEAQ 0x79ce180(R10), R10	
  0x1400c3c08		4881fbc8000000		CMPQ BX, $0xc8			
  0x1400c3c0f		0f8247ffffff		JB 0x1400c3b5c			
  0x1400c3c15		eb3b			JMP 0x1400c3c52			
			for p := range N_G {
  0x1400c3c17		4531c0			XORL R8, R8		
  0x1400c3c1a		eb28			JMP 0x1400c3c44		
				sim.Eepf[eIdx] += diag.eepf[eIdx]
  0x1400c3c1c		4c8d0c3e		LEAQ 0(SI)(DI*1), R9			
  0x1400c3c20		4d8d8900320000		LEAQ 0x3200(R9), R9			
  0x1400c3c27		f2430f1004c1		MOVSD_XMM 0(R9)(R8*8), X0		
  0x1400c3c2d		f2420f5884c070662707	ADDSD 0x7276670(AX)(R8*8), X0		
  0x1400c3c37		f2420f1184c070662707	MOVSD_XMM X0, 0x7276670(AX)(R8*8)	
			for eIdx := range N_EEPF {
  0x1400c3c41		49ffc0			INCQ R8			
  0x1400c3c44		4981f8d0070000		CMPQ R8, $0x7d0		
  0x1400c3c4b		7ccf			JL 0x1400c3c1c		
  0x1400c3c4d		e9b1feffff		JMP 0x1400c3b03		
				sim.Counter_e_xt[p][t_index] += diag.counter_e[p]
  0x1400c3c52		b8c8000000		MOVL $0xc8, AX			
  0x1400c3c57		e824a8fbff		CALL runtime.panicBounds(SB)	
			diag := &sim.WorkerEDiag[w]
  0x1400c3c5c		0f1f4000		NOPL 0(AX)			
  0x1400c3c60		e81ba8fbff		CALL runtime.panicBounds(SB)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3c65		e816a8fbff		CALL runtime.panicBounds(SB)	
  0x1400c3c6a		90			NOPL				
func (sim *SimulationState) Step3MoveElectrons(t_index int) {
  0x1400c3c6b		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c3c70		48895c2410		MOVQ BX, 0x10(SP)					
  0x1400c3c75		e8c689fbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c3c7a		488b442408		MOVQ 0x8(SP), AX					
  0x1400c3c7f		488b5c2410		MOVQ 0x10(SP), BX					
  0x1400c3c84		e9b7fdffff		JMP gopic.(*SimulationState).Step3MoveElectrons(SB)	

  0x1400c3c89		cc			INT $0x3		
  0x1400c3c8a		cc			INT $0x3		
  0x1400c3c8b		cc			INT $0x3		
  0x1400c3c8c		cc			INT $0x3		
  0x1400c3c8d		cc			INT $0x3		
  0x1400c3c8e		cc			INT $0x3		
  0x1400c3c8f		cc			INT $0x3		
  0x1400c3c90		cc			INT $0x3		
  0x1400c3c91		cc			INT $0x3		
  0x1400c3c92		cc			INT $0x3		
  0x1400c3c93		cc			INT $0x3		
  0x1400c3c94		cc			INT $0x3		
  0x1400c3c95		cc			INT $0x3		
  0x1400c3c96		cc			INT $0x3		
  0x1400c3c97		cc			INT $0x3		
  0x1400c3c98		cc			INT $0x3		
  0x1400c3c99		cc			INT $0x3		
  0x1400c3c9a		cc			INT $0x3		
  0x1400c3c9b		cc			INT $0x3		
  0x1400c3c9c		cc			INT $0x3		
  0x1400c3c9d		cc			INT $0x3		
  0x1400c3c9e		cc			INT $0x3		
  0x1400c3c9f		cc			INT $0x3		
