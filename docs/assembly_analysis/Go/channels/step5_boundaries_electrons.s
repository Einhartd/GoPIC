// =============================================================================
// SYMBOL: Step5CheckBoundariesElectrons
// =============================================================================

TEXT gopic.(*SimulationState).Step5CheckBoundariesElectrons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation.go
func (sim *SimulationState) Step5CheckBoundariesElectrons() {
  0x1400c3c40		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c3c44		0f8635020000		JBE 0x1400c3e7f		
  0x1400c3c4a		55			PUSHQ BP		
  0x1400c3c4b		4889e5			MOVQ SP, BP		
  0x1400c3c4e		4883ec28		SUBQ $0x28, SP		
	for w := range numWorkers {
  0x1400c3c52		4889442438		MOVQ AX, 0x38(SP)	
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c3c57		8400			TESTB AL, 0(AX)		
	sim.broadcastAndWait(CmdCheckBoundariesE)
  0x1400c3c59		90			NOPL			
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c3c5a		488b88582eba07		MOVQ 0x7ba2e58(AX), CX	
  0x1400c3c61		48894c2418		MOVQ CX, 0x18(SP)	
  0x1400c3c66		31d2			XORL DX, DX		
	for w := range numWorkers {
  0x1400c3c68		eb2d			JMP 0x1400c3c97		
  0x1400c3c6a		4889542410		MOVQ DX, 0x10(SP)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3c6f		488b88502eba07		MOVQ 0x7ba2e50(AX), CX		
  0x1400c3c76		488b04d1		MOVQ 0(CX)(DX*8), AX		
  0x1400c3c7a		488d5c2420		LEAQ 0x20(SP), BX		
  0x1400c3c7f		90			NOPL				
  0x1400c3c80		e87bcaf4ff		CALL runtime.chansend1(SB)	
	for w := range numWorkers {
  0x1400c3c85		488b542410		MOVQ 0x10(SP), DX	
  0x1400c3c8a		48ffc2			INCQ DX			
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3c8d		488b442438		MOVQ 0x38(SP), AX	
	for w := range numWorkers {
  0x1400c3c92		488b4c2418		MOVQ 0x18(SP), CX	
  0x1400c3c97		4839ca			CMPQ DX, CX		
  0x1400c3c9a		7d3a			JGE 0x1400c3cd6		
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3c9c		48c744242004000000	MOVQ $0x4, 0x20(SP)	
  0x1400c3ca5		488bb0582eba07		MOVQ 0x7ba2e58(AX), SI	
  0x1400c3cac		4839f2			CMPQ DX, SI		
  0x1400c3caf		72b9			JB 0x1400c3c6a		
  0x1400c3cb1		e9c3010000		JMP 0x1400c3e79		
	for range numWorkers {
  0x1400c3cb6		48894c2418		MOVQ CX, 0x18(SP)	
		<-sim.WorkerDoneChan
  0x1400c3cbb		488b80682eba07		MOVQ 0x7ba2e68(AX), AX		
  0x1400c3cc2		31db			XORL BX, BX			
  0x1400c3cc4		e8b7d8f4ff		CALL runtime.chanrecv1(SB)	
	for range numWorkers {
  0x1400c3cc9		488b4c2418		MOVQ 0x18(SP), CX	
  0x1400c3cce		48ffc9			DECQ CX			
		<-sim.WorkerDoneChan
  0x1400c3cd1		488b442438		MOVQ 0x38(SP), AX	
	for range numWorkers {
  0x1400c3cd6		4885c9			TESTQ CX, CX		
  0x1400c3cd9		7fdb			JG 0x1400c3cb6		
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c3cdb		488b88582eba07		MOVQ 0x7ba2e58(AX), CX	
	for w := range numWorkers {
  0x1400c3ce2		31d2			XORL DX, DX		
  0x1400c3ce4		31db			XORL BX, BX		
  0x1400c3ce6		eb32			JMP 0x1400c3d1a		
		p := sim.WorkerEDiag[w].abs_pow
  0x1400c3ce8		488b7030		MOVQ 0x30(AX), SI		
  0x1400c3cec		4869fbc0700000		IMULQ $0x70c0, BX, DI		
  0x1400c3cf3		4c8b843e90700000	MOVQ 0x7090(SI)(DI*1), R8	
		g := sim.WorkerEDiag[w].abs_gnd
  0x1400c3cfb		488bb43e98700000	MOVQ 0x7098(SI)(DI*1), SI	
		sim.N_e_abs_pow += p
  0x1400c3d03		4c018050662707		ADDQ R8, 0x7276650(AX)	
		sim.N_e_abs_gnd += g
  0x1400c3d0a		4801b058662707		ADDQ SI, 0x7276658(AX)	
		totalAbs += int(p + g)
  0x1400c3d11		4c01c6			ADDQ R8, SI		
  0x1400c3d14		4801f2			ADDQ SI, DX		
	for w := range numWorkers {
  0x1400c3d17		48ffc3			INCQ BX			
  0x1400c3d1a		4839cb			CMPQ BX, CX		
  0x1400c3d1d		7d0e			JGE 0x1400c3d2d		
		p := sim.WorkerEDiag[w].abs_pow
  0x1400c3d1f		488b7038		MOVQ 0x38(AX), SI	
  0x1400c3d23		4839f3			CMPQ BX, SI		
  0x1400c3d26		72c0			JB 0x1400c3ce8		
  0x1400c3d28		e947010000		JMP 0x1400c3e74		
	if totalAbs > 0 {
  0x1400c3d2d		4885d2			TESTQ DX, DX		
  0x1400c3d30		7e10			JLE 0x1400c3d42		
		lastValid := sim.N_e - 1
  0x1400c3d32		488b98c07e5603		MOVQ 0x3567ec0(AX), BX	
  0x1400c3d39		48ffcb			DECQ BX			
		for w := range numWorkers {
  0x1400c3d3c		31f6			XORL SI, SI		
  0x1400c3d3e		6690			NOPW			
  0x1400c3d40		eb09			JMP 0x1400c3d4b		
}
  0x1400c3d42		4883c428		ADDQ $0x28, SP		
  0x1400c3d46		5d			POPQ BP			
  0x1400c3d47		c3			RET			
		for w := range numWorkers {
  0x1400c3d48		48ffc6			INCQ SI			
  0x1400c3d4b		4839ce			CMPQ SI, CX		
  0x1400c3d4e		0f8df1000000		JGE 0x1400c3e45		
			for _, deadIdx := range sim.WorkerDeadElectrons[w] {
  0x1400c3d54		488b7868		MOVQ 0x68(AX), DI	
  0x1400c3d58		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x1400c3d60		4839fe			CMPQ SI, DI		
  0x1400c3d63		0f8306010000		JAE 0x1400c3e6f		
  0x1400c3d69		488b7860		MOVQ 0x60(AX), DI	
  0x1400c3d6d		4c8d0476		LEAQ 0(SI)(SI*2), R8	
  0x1400c3d71		4e8b0cc7		MOVQ 0(DI)(R8*8), R9	
  0x1400c3d75		4a8b7cc708		MOVQ 0x8(DI)(R8*8), DI	
  0x1400c3d7a		4531c0			XORL R8, R8		
  0x1400c3d7d		eb03			JMP 0x1400c3d82		
  0x1400c3d7f		49ffc0			INCQ R8			
  0x1400c3d82		4939f8			CMPQ R8, DI		
  0x1400c3d85		7dc1			JGE 0x1400c3d48		
  0x1400c3d87		4f8b14c1		MOVQ 0(R9)(R8*8), R10	
				for lastValid > deadIdx && (sim.X_e[lastValid] < 0 || sim.X_e[lastValid] > L) {
  0x1400c3d8b		eb03			JMP 0x1400c3d90		
					lastValid--
  0x1400c3d8d		48ffcb			DECQ BX			
				for lastValid > deadIdx && (sim.X_e[lastValid] < 0 || sim.X_e[lastValid] > L) {
  0x1400c3d90		4c39d3			CMPQ BX, R10				
  0x1400c3d93		0f8e9b000000		JLE 0x1400c3e34				
  0x1400c3d99		0f1f8000000000		NOPL 0(AX)				
  0x1400c3da0		4881fb40420f00		CMPQ BX, $0xf4240			
  0x1400c3da7		0f83b8000000		JAE 0x1400c3e65				
  0x1400c3dad		f20f1084d8d07e5603	MOVSD_XMM 0x3567ed0(AX)(BX*8), X0	
  0x1400c3db6		0f57c9			XORPS X1, X1				
  0x1400c3db9		660f2ec8		UCOMISD X0, X1				
  0x1400c3dbd		77ce			JA 0x1400c3d8d				
  0x1400c3dbf		f20f1015d1220100	MOVSD_XMM runtime.egcbss+10(SB), X2	
  0x1400c3dc7		660f2ec2		UCOMISD X2, X0				
  0x1400c3dcb		77c0			JA 0x1400c3d8d				
  0x1400c3dcd		4c39d3			CMPQ BX, R10				
				if lastValid > deadIdx {
  0x1400c3dd0		7ead			JLE 0x1400c3d7f		
				for lastValid > deadIdx && (sim.X_e[lastValid] < 0 || sim.X_e[lastValid] > L) {
  0x1400c3dd2		4881fb40420f00		CMPQ BX, $0xf4240	
					sim.X_e[deadIdx] = sim.X_e[lastValid]
  0x1400c3dd9		0f837c000000		JAE 0x1400c3e5b				
  0x1400c3ddf		90			NOPL					
  0x1400c3de0		4981fa40420f00		CMPQ R10, $0xf4240			
  0x1400c3de7		7368			JAE 0x1400c3e51				
  0x1400c3de9		f2420f1184d0d07e5603	MOVSD_XMM X0, 0x3567ed0(AX)(R10*8)	
					sim.Vx_e[deadIdx] = sim.Vx_e[lastValid]
  0x1400c3df3		f20f1084d8d090d003	MOVSD_XMM 0x3d090d0(AX)(BX*8), X0	
  0x1400c3dfc		f2420f1184d0d090d003	MOVSD_XMM X0, 0x3d090d0(AX)(R10*8)	
					sim.Vy_e[deadIdx] = sim.Vy_e[lastValid]
  0x1400c3e06		f20f1084d8d0a24a04	MOVSD_XMM 0x44aa2d0(AX)(BX*8), X0	
  0x1400c3e0f		f2420f1184d0d0a24a04	MOVSD_XMM X0, 0x44aa2d0(AX)(R10*8)	
					sim.Vz_e[deadIdx] = sim.Vz_e[lastValid]
  0x1400c3e19		f20f1084d8d0b4c404	MOVSD_XMM 0x4c4b4d0(AX)(BX*8), X0	
  0x1400c3e22		f2420f1184d0d0b4c404	MOVSD_XMM X0, 0x4c4b4d0(AX)(R10*8)	
					lastValid--
  0x1400c3e2c		48ffcb			DECQ BX					
  0x1400c3e2f		e94bffffff		JMP 0x1400c3d7f				
  0x1400c3e34		0f57c9			XORPS X1, X1				
  0x1400c3e37		f20f101559220100	MOVSD_XMM runtime.egcbss+10(SB), X2	
  0x1400c3e3f		90			NOPL					
				for lastValid > deadIdx && (sim.X_e[lastValid] < 0 || sim.X_e[lastValid] > L) {
  0x1400c3e40		e93affffff		JMP 0x1400c3d7f		
		sim.N_e -= totalAbs
  0x1400c3e45		482990c07e5603		SUBQ DX, 0x3567ec0(AX)	
  0x1400c3e4c		e9f1feffff		JMP 0x1400c3d42		
					sim.X_e[deadIdx] = sim.X_e[lastValid]
  0x1400c3e51		b840420f00		MOVL $0xf4240, AX		
  0x1400c3e56		e825a6fbff		CALL runtime.panicBounds(SB)	
  0x1400c3e5b		b840420f00		MOVL $0xf4240, AX		
  0x1400c3e60		e81ba6fbff		CALL runtime.panicBounds(SB)	
				for lastValid > deadIdx && (sim.X_e[lastValid] < 0 || sim.X_e[lastValid] > L) {
  0x1400c3e65		b840420f00		MOVL $0xf4240, AX		
  0x1400c3e6a		e811a6fbff		CALL runtime.panicBounds(SB)	
			for _, deadIdx := range sim.WorkerDeadElectrons[w] {
  0x1400c3e6f		e80ca6fbff		CALL runtime.panicBounds(SB)	
		p := sim.WorkerEDiag[w].abs_pow
  0x1400c3e74		e807a6fbff		CALL runtime.panicBounds(SB)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3e79		e802a6fbff		CALL runtime.panicBounds(SB)	
  0x1400c3e7e		90			NOPL				
func (sim *SimulationState) Step5CheckBoundariesElectrons() {
  0x1400c3e7f		4889442408		MOVQ AX, 0x8(SP)						
  0x1400c3e84		e8b787fbff		CALL runtime.morestack_noctxt.abi0(SB)				
  0x1400c3e89		488b442408		MOVQ 0x8(SP), AX						
  0x1400c3e8e		e9adfdffff		JMP gopic.(*SimulationState).Step5CheckBoundariesElectrons(SB)	

  0x1400c3e93		cc			INT $0x3		
  0x1400c3e94		cc			INT $0x3		
  0x1400c3e95		cc			INT $0x3		
  0x1400c3e96		cc			INT $0x3		
  0x1400c3e97		cc			INT $0x3		
  0x1400c3e98		cc			INT $0x3		
  0x1400c3e99		cc			INT $0x3		
  0x1400c3e9a		cc			INT $0x3		
  0x1400c3e9b		cc			INT $0x3		
  0x1400c3e9c		cc			INT $0x3		
  0x1400c3e9d		cc			INT $0x3		
  0x1400c3e9e		cc			INT $0x3		
  0x1400c3e9f		cc			INT $0x3		


