// =============================================================================
// SYMBOL: Step4MoveIons
// =============================================================================

TEXT gopic.(*SimulationState).Step4MoveIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation.go
func (sim *SimulationState) Step4MoveIons(t_index, t int) {
  0x1400c3a40		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c3a44		0f86c8010000		JBE 0x1400c3c12		
  0x1400c3a4a		55			PUSHQ BP		
  0x1400c3a4b		4889e5			MOVQ SP, BP		
  0x1400c3a4e		4883ec28		SUBQ $0x28, SP		
	if (t % N_SUB) != 0 {
  0x1400c3a52		48bacdcccccccccccccc	MOVQ $0xcccccccccccccccd, DX	
  0x1400c3a5c		480fafca		IMULQ DX, CX			
  0x1400c3a60		48ba9899999999999919	MOVQ $0x1999999999999998, DX	
  0x1400c3a6a		4801d1			ADDQ DX, CX			
  0x1400c3a6d		48c1c13e		ROLQ $0x3e, CX			
  0x1400c3a71		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x1400c3a7b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x1400c3a80		4839ca			CMPQ DX, CX			
  0x1400c3a83		721d			JB 0x1400c3aa2			
  0x1400c3a85		4889442438		MOVQ AX, 0x38(SP)		
  0x1400c3a8a		48895c2440		MOVQ BX, 0x40(SP)		
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c3a8f		8400			TESTB AL, 0(AX)		
	sim.broadcastAndWait(CmdMoveIons)
  0x1400c3a91		90			NOPL			
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c3a92		488b88582eba07		MOVQ 0x7ba2e58(AX), CX	
  0x1400c3a99		48894c2418		MOVQ CX, 0x18(SP)	
  0x1400c3a9e		31d2			XORL DX, DX		
	for w := range numWorkers {
  0x1400c3aa0		eb3e			JMP 0x1400c3ae0		
		return
  0x1400c3aa2		4883c428		ADDQ $0x28, SP		
  0x1400c3aa6		5d			POPQ BP			
  0x1400c3aa7		c3			RET			
	for w := range numWorkers {
  0x1400c3aa8		4889542410		MOVQ DX, 0x10(SP)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3aad		488b88502eba07		MOVQ 0x7ba2e50(AX), CX		
  0x1400c3ab4		488b04d1		MOVQ 0(CX)(DX*8), AX		
  0x1400c3ab8		488d5c2420		LEAQ 0x20(SP), BX		
  0x1400c3abd		0f1f00			NOPL 0(AX)			
  0x1400c3ac0		e83bccf4ff		CALL runtime.chansend1(SB)	
	for w := range numWorkers {
  0x1400c3ac5		488b542410		MOVQ 0x10(SP), DX	
  0x1400c3aca		48ffc2			INCQ DX			
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3acd		488b442438		MOVQ 0x38(SP), AX	
	for w := range numWorkers {
  0x1400c3ad2		488b4c2418		MOVQ 0x18(SP), CX	
				sim.Counter_i_xt[p][t_index] += diag.counter_i[p]
  0x1400c3ad7		488b5c2440		MOVQ 0x40(SP), BX	
  0x1400c3adc		0f1f4000		NOPL 0(AX)		
	for w := range numWorkers {
  0x1400c3ae0		4839ca			CMPQ DX, CX		
  0x1400c3ae3		7d3f			JGE 0x1400c3b24		
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3ae5		48c744242003000000	MOVQ $0x3, 0x20(SP)	
  0x1400c3aee		488bb0582eba07		MOVQ 0x7ba2e58(AX), SI	
  0x1400c3af5		4839f2			CMPQ DX, SI		
  0x1400c3af8		72ae			JB 0x1400c3aa8		
  0x1400c3afa		e90d010000		JMP 0x1400c3c0c		
	for range numWorkers {
  0x1400c3aff		48894c2418		MOVQ CX, 0x18(SP)	
		<-sim.WorkerDoneChan
  0x1400c3b04		488b80682eba07		MOVQ 0x7ba2e68(AX), AX		
  0x1400c3b0b		31db			XORL BX, BX			
  0x1400c3b0d		e86edaf4ff		CALL runtime.chanrecv1(SB)	
	for range numWorkers {
  0x1400c3b12		488b4c2418		MOVQ 0x18(SP), CX	
  0x1400c3b17		48ffc9			DECQ CX			
		<-sim.WorkerDoneChan
  0x1400c3b1a		488b442438		MOVQ 0x38(SP), AX	
				sim.Counter_i_xt[p][t_index] += diag.counter_i[p]
  0x1400c3b1f		488b5c2440		MOVQ 0x40(SP), BX	
	for range numWorkers {
  0x1400c3b24		4885c9			TESTQ CX, CX		
  0x1400c3b27		7fd6			JG 0x1400c3aff		
	if sim.Measurement_mode {
  0x1400c3b29		80b8e02dba0700		CMPB 0x7ba2de0(AX), $0x0	
  0x1400c3b30		740b			JE 0x1400c3b3d			
		numWorkers := len(sim.WorkerCmdChan)
  0x1400c3b32		488b88582eba07		MOVQ 0x7ba2e58(AX), CX	
		for w := range numWorkers {
  0x1400c3b39		31d2			XORL DX, DX		
  0x1400c3b3b		eb09			JMP 0x1400c3b46		
}
  0x1400c3b3d		4883c428		ADDQ $0x28, SP		
  0x1400c3b41		5d			POPQ BP			
  0x1400c3b42		c3			RET			
		for w := range numWorkers {
  0x1400c3b43		48ffc2			INCQ DX			
  0x1400c3b46		4839ca			CMPQ DX, CX		
  0x1400c3b49		7df2			JGE 0x1400c3b3d		
			diag := &sim.WorkerIDiag[w]
  0x1400c3b4b		488b7050		MOVQ 0x50(AX), SI	
  0x1400c3b4f		4839f2			CMPQ DX, SI		
  0x1400c3b52		0f83af000000		JAE 0x1400c3c07		
  0x1400c3b58		488b7048		MOVQ 0x48(AX), SI	
  0x1400c3b5c		4869fa40320000		IMULQ $0x3240, DX, DI	
			for p := range N_G {
  0x1400c3b63		4531c0			XORL R8, R8		
  0x1400c3b66		eb69			JMP 0x1400c3bd1		
				sim.Counter_i_xt[p][t_index] += diag.counter_i[p]
  0x1400c3b68		4c8d1c3e		LEAQ 0(SI)(DI*1), R11		
  0x1400c3b6c		f2430f1004c3		MOVSD_XMM 0(R11)(R8*8), X0	
  0x1400c3b72		f2410f5804da		ADDSD 0(R10)(BX*8), X0		
  0x1400c3b78		f2410f1104da		MOVSD_XMM X0, 0(R10)(BX*8)	
				sim.Ui_xt[p][t_index] += diag.ui[p]
  0x1400c3b7e		4e8d1408		LEAQ 0(AX)(R9*1), R10		
  0x1400c3b82		4d8d9280855807		LEAQ 0x7588580(R10), R10	
  0x1400c3b89		4c8d1c3e		LEAQ 0(SI)(DI*1), R11		
  0x1400c3b8d		4d8d9b800c0000		LEAQ 0xc80(R11), R11		
  0x1400c3b94		f2430f1004c3		MOVSD_XMM 0(R11)(R8*8), X0	
  0x1400c3b9a		f2410f5804da		ADDSD 0(R10)(BX*8), X0		
  0x1400c3ba0		f2410f1104da		MOVSD_XMM X0, 0(R10)(BX*8)	
				sim.Meanei_xt[p][t_index] += diag.meanei[p]
  0x1400c3ba6		4e8d0c08		LEAQ 0(AX)(R9*1), R9		
  0x1400c3baa		4d8d89801d9307		LEAQ 0x7931d80(R9), R9		
  0x1400c3bb1		4c8d143e		LEAQ 0(SI)(DI*1), R10		
  0x1400c3bb5		4d8d9200190000		LEAQ 0x1900(R10), R10		
  0x1400c3bbc		f2430f1004c2		MOVSD_XMM 0(R10)(R8*8), X0	
  0x1400c3bc2		f2410f5804d9		ADDSD 0(R9)(BX*8), X0		
  0x1400c3bc8		f2410f1104d9		MOVSD_XMM X0, 0(R9)(BX*8)	
			for p := range N_G {
  0x1400c3bce		49ffc0			INCQ R8			
  0x1400c3bd1		4981f890010000		CMPQ R8, $0x190		
  0x1400c3bd8		0f8d65ffffff		JGE 0x1400c3b43		
				sim.Counter_i_xt[p][t_index] += diag.counter_i[p]
  0x1400c3bde		4d69c840060000		IMULQ $0x640, R8, R9		
  0x1400c3be5		4e8d1408		LEAQ 0(AX)(R9*1), R10		
  0x1400c3be9		4d8d9280a5a607		LEAQ 0x7a6a580(R10), R10	
  0x1400c3bf0		4881fbc8000000		CMPQ BX, $0xc8			
  0x1400c3bf7		0f826bffffff		JB 0x1400c3b68			
  0x1400c3bfd		b8c8000000		MOVL $0xc8, AX			
  0x1400c3c02		e879a8fbff		CALL runtime.panicBounds(SB)	
			diag := &sim.WorkerIDiag[w]
  0x1400c3c07		e874a8fbff		CALL runtime.panicBounds(SB)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3c0c		e86fa8fbff		CALL runtime.panicBounds(SB)	
  0x1400c3c11		90			NOPL				
func (sim *SimulationState) Step4MoveIons(t_index, t int) {
  0x1400c3c12		4889442408		MOVQ AX, 0x8(SP)				
  0x1400c3c17		48895c2410		MOVQ BX, 0x10(SP)				
  0x1400c3c1c		48894c2418		MOVQ CX, 0x18(SP)				
  0x1400c3c21		e81a8afbff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x1400c3c26		488b442408		MOVQ 0x8(SP), AX				
  0x1400c3c2b		488b5c2410		MOVQ 0x10(SP), BX				
  0x1400c3c30		488b4c2418		MOVQ 0x18(SP), CX				
  0x1400c3c35		e906feffff		JMP gopic.(*SimulationState).Step4MoveIons(SB)	

  0x1400c3c3a		cc			INT $0x3		
  0x1400c3c3b		cc			INT $0x3		
  0x1400c3c3c		cc			INT $0x3		
  0x1400c3c3d		cc			INT $0x3		
  0x1400c3c3e		cc			INT $0x3		
  0x1400c3c3f		cc			INT $0x3		


