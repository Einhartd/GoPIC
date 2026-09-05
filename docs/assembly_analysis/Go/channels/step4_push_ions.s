TEXT gopic.(*SimulationState).Step4MoveIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation.go
func (sim *SimulationState) Step4MoveIons(t_index, t int) {
  0x1400c3ca0		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c3ca4		0f86c8010000		JBE 0x1400c3e72		
  0x1400c3caa		55			PUSHQ BP		
  0x1400c3cab		4889e5			MOVQ SP, BP		
  0x1400c3cae		4883ec28		SUBQ $0x28, SP		
	if (t % N_SUB) != 0 {
  0x1400c3cb2		48bacdcccccccccccccc	MOVQ $0xcccccccccccccccd, DX	
  0x1400c3cbc		480fafca		IMULQ DX, CX			
  0x1400c3cc0		48ba9899999999999919	MOVQ $0x1999999999999998, DX	
  0x1400c3cca		4801d1			ADDQ DX, CX			
  0x1400c3ccd		48c1c13e		ROLQ $0x3e, CX			
  0x1400c3cd1		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x1400c3cdb		0f1f440000		NOPL 0(AX)(AX*1)		
  0x1400c3ce0		4839ca			CMPQ DX, CX			
  0x1400c3ce3		721d			JB 0x1400c3d02			
  0x1400c3ce5		4889442438		MOVQ AX, 0x38(SP)		
  0x1400c3cea		48895c2440		MOVQ BX, 0x40(SP)		
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c3cef		8400			TESTB AL, 0(AX)		
	sim.broadcastAndWait(CmdMoveIons)
  0x1400c3cf1		90			NOPL			
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c3cf2		488b88402eba07		MOVQ 0x7ba2e40(AX), CX	
  0x1400c3cf9		48894c2418		MOVQ CX, 0x18(SP)	
  0x1400c3cfe		31d2			XORL DX, DX		
	for w := range numWorkers {
  0x1400c3d00		eb3e			JMP 0x1400c3d40		
		return
  0x1400c3d02		4883c428		ADDQ $0x28, SP		
  0x1400c3d06		5d			POPQ BP			
  0x1400c3d07		c3			RET			
	for w := range numWorkers {
  0x1400c3d08		4889542410		MOVQ DX, 0x10(SP)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3d0d		488b88382eba07		MOVQ 0x7ba2e38(AX), CX		
  0x1400c3d14		488b04d1		MOVQ 0(CX)(DX*8), AX		
  0x1400c3d18		488d5c2420		LEAQ 0x20(SP), BX		
  0x1400c3d1d		0f1f00			NOPL 0(AX)			
  0x1400c3d20		e8dbc9f4ff		CALL runtime.chansend1(SB)	
	for w := range numWorkers {
  0x1400c3d25		488b542410		MOVQ 0x10(SP), DX	
  0x1400c3d2a		48ffc2			INCQ DX			
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3d2d		488b442438		MOVQ 0x38(SP), AX	
	for w := range numWorkers {
  0x1400c3d32		488b4c2418		MOVQ 0x18(SP), CX	
				sim.Counter_i_xt[p][t_index] += diag.counter_i[p]
  0x1400c3d37		488b5c2440		MOVQ 0x40(SP), BX	
  0x1400c3d3c		0f1f4000		NOPL 0(AX)		
	for w := range numWorkers {
  0x1400c3d40		4839ca			CMPQ DX, CX		
  0x1400c3d43		7d3f			JGE 0x1400c3d84		
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3d45		48c744242003000000	MOVQ $0x3, 0x20(SP)	
  0x1400c3d4e		488bb0402eba07		MOVQ 0x7ba2e40(AX), SI	
  0x1400c3d55		4839f2			CMPQ DX, SI		
  0x1400c3d58		72ae			JB 0x1400c3d08		
  0x1400c3d5a		e90d010000		JMP 0x1400c3e6c		
	for range numWorkers {
  0x1400c3d5f		48894c2418		MOVQ CX, 0x18(SP)	
		<-sim.WorkerDoneChan
  0x1400c3d64		488b80502eba07		MOVQ 0x7ba2e50(AX), AX		
  0x1400c3d6b		31db			XORL BX, BX			
  0x1400c3d6d		e80ed8f4ff		CALL runtime.chanrecv1(SB)	
	for range numWorkers {
  0x1400c3d72		488b4c2418		MOVQ 0x18(SP), CX	
  0x1400c3d77		48ffc9			DECQ CX			
		<-sim.WorkerDoneChan
  0x1400c3d7a		488b442438		MOVQ 0x38(SP), AX	
				sim.Counter_i_xt[p][t_index] += diag.counter_i[p]
  0x1400c3d7f		488b5c2440		MOVQ 0x40(SP), BX	
	for range numWorkers {
  0x1400c3d84		4885c9			TESTQ CX, CX		
  0x1400c3d87		7fd6			JG 0x1400c3d5f		
	if sim.Measurement_mode {
  0x1400c3d89		80b8e02dba0700		CMPB 0x7ba2de0(AX), $0x0	
  0x1400c3d90		740b			JE 0x1400c3d9d			
		numWorkers := len(sim.WorkerCmdChan)
  0x1400c3d92		488b88402eba07		MOVQ 0x7ba2e40(AX), CX	
		for w := range numWorkers {
  0x1400c3d99		31d2			XORL DX, DX		
  0x1400c3d9b		eb09			JMP 0x1400c3da6		
}
  0x1400c3d9d		4883c428		ADDQ $0x28, SP		
  0x1400c3da1		5d			POPQ BP			
  0x1400c3da2		c3			RET			
		for w := range numWorkers {
  0x1400c3da3		48ffc2			INCQ DX			
  0x1400c3da6		4839ca			CMPQ DX, CX		
  0x1400c3da9		7df2			JGE 0x1400c3d9d		
			diag := &sim.WorkerIDiag[w]
  0x1400c3dab		488b7050		MOVQ 0x50(AX), SI	
  0x1400c3daf		4839f2			CMPQ DX, SI		
  0x1400c3db2		0f83af000000		JAE 0x1400c3e67		
  0x1400c3db8		488b7048		MOVQ 0x48(AX), SI	
  0x1400c3dbc		4869fa40320000		IMULQ $0x3240, DX, DI	
			for p := range N_G {
  0x1400c3dc3		4531c0			XORL R8, R8		
  0x1400c3dc6		eb69			JMP 0x1400c3e31		
				sim.Counter_i_xt[p][t_index] += diag.counter_i[p]
  0x1400c3dc8		4c8d1c3e		LEAQ 0(SI)(DI*1), R11		
  0x1400c3dcc		f2430f1004c3		MOVSD_XMM 0(R11)(R8*8), X0	
  0x1400c3dd2		f2410f5804da		ADDSD 0(R10)(BX*8), X0		
  0x1400c3dd8		f2410f1104da		MOVSD_XMM X0, 0(R10)(BX*8)	
				sim.Ui_xt[p][t_index] += diag.ui[p]
  0x1400c3dde		4e8d1408		LEAQ 0(AX)(R9*1), R10		
  0x1400c3de2		4d8d9280855807		LEAQ 0x7588580(R10), R10	
  0x1400c3de9		4c8d1c3e		LEAQ 0(SI)(DI*1), R11		
  0x1400c3ded		4d8d9b800c0000		LEAQ 0xc80(R11), R11		
  0x1400c3df4		f2430f1004c3		MOVSD_XMM 0(R11)(R8*8), X0	
  0x1400c3dfa		f2410f5804da		ADDSD 0(R10)(BX*8), X0		
  0x1400c3e00		f2410f1104da		MOVSD_XMM X0, 0(R10)(BX*8)	
				sim.Meanei_xt[p][t_index] += diag.meanei[p]
  0x1400c3e06		4e8d0c08		LEAQ 0(AX)(R9*1), R9		
  0x1400c3e0a		4d8d89801d9307		LEAQ 0x7931d80(R9), R9		
  0x1400c3e11		4c8d143e		LEAQ 0(SI)(DI*1), R10		
  0x1400c3e15		4d8d9200190000		LEAQ 0x1900(R10), R10		
  0x1400c3e1c		f2430f1004c2		MOVSD_XMM 0(R10)(R8*8), X0	
  0x1400c3e22		f2410f5804d9		ADDSD 0(R9)(BX*8), X0		
  0x1400c3e28		f2410f1104d9		MOVSD_XMM X0, 0(R9)(BX*8)	
			for p := range N_G {
  0x1400c3e2e		49ffc0			INCQ R8			
  0x1400c3e31		4981f890010000		CMPQ R8, $0x190		
  0x1400c3e38		0f8d65ffffff		JGE 0x1400c3da3		
				sim.Counter_i_xt[p][t_index] += diag.counter_i[p]
  0x1400c3e3e		4d69c840060000		IMULQ $0x640, R8, R9		
  0x1400c3e45		4e8d1408		LEAQ 0(AX)(R9*1), R10		
  0x1400c3e49		4d8d9280a5a607		LEAQ 0x7a6a580(R10), R10	
  0x1400c3e50		4881fbc8000000		CMPQ BX, $0xc8			
  0x1400c3e57		0f826bffffff		JB 0x1400c3dc8			
  0x1400c3e5d		b8c8000000		MOVL $0xc8, AX			
  0x1400c3e62		e819a6fbff		CALL runtime.panicBounds(SB)	
			diag := &sim.WorkerIDiag[w]
  0x1400c3e67		e814a6fbff		CALL runtime.panicBounds(SB)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3e6c		e80fa6fbff		CALL runtime.panicBounds(SB)	
  0x1400c3e71		90			NOPL				
func (sim *SimulationState) Step4MoveIons(t_index, t int) {
  0x1400c3e72		4889442408		MOVQ AX, 0x8(SP)				
  0x1400c3e77		48895c2410		MOVQ BX, 0x10(SP)				
  0x1400c3e7c		48894c2418		MOVQ CX, 0x18(SP)				
  0x1400c3e81		e8ba87fbff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x1400c3e86		488b442408		MOVQ 0x8(SP), AX				
  0x1400c3e8b		488b5c2410		MOVQ 0x10(SP), BX				
  0x1400c3e90		488b4c2418		MOVQ 0x18(SP), CX				
  0x1400c3e95		e906feffff		JMP gopic.(*SimulationState).Step4MoveIons(SB)	

  0x1400c3e9a		cc			INT $0x3		
  0x1400c3e9b		cc			INT $0x3		
  0x1400c3e9c		cc			INT $0x3		
  0x1400c3e9d		cc			INT $0x3		
  0x1400c3e9e		cc			INT $0x3		
  0x1400c3e9f		cc			INT $0x3		
