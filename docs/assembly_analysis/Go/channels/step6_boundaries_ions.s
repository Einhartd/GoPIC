// =============================================================================
// SYMBOL: Step6CheckBoundariesIons
// =============================================================================

TEXT gopic.(*SimulationState).Step6CheckBoundariesIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation.go
func (sim *SimulationState) Step6CheckBoundariesIons(t int) {
  0x1400c3ea0		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c3ea4		0f86eb020000		JBE 0x1400c4195		
  0x1400c3eaa		55			PUSHQ BP		
  0x1400c3eab		4889e5			MOVQ SP, BP		
  0x1400c3eae		4883ec28		SUBQ $0x28, SP		
	if (t % N_SUB) != 0 {
  0x1400c3eb2		48b9cdcccccccccccccc	MOVQ $0xcccccccccccccccd, CX	
  0x1400c3ebc		480fafd9		IMULQ CX, BX			
  0x1400c3ec0		48b99899999999999919	MOVQ $0x1999999999999998, CX	
  0x1400c3eca		4801d9			ADDQ BX, CX			
  0x1400c3ecd		48c1c13e		ROLQ $0x3e, CX			
  0x1400c3ed1		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x1400c3edb		0f1f440000		NOPL 0(AX)(AX*1)		
  0x1400c3ee0		4839ca			CMPQ DX, CX			
  0x1400c3ee3		7218			JB 0x1400c3efd			
  0x1400c3ee5		4889442438		MOVQ AX, 0x38(SP)		
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c3eea		8400			TESTB AL, 0(AX)		
	sim.broadcastAndWait(CmdCheckBoundariesI)
  0x1400c3eec		90			NOPL			
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c3eed		488b88582eba07		MOVQ 0x7ba2e58(AX), CX	
  0x1400c3ef4		48894c2418		MOVQ CX, 0x18(SP)	
  0x1400c3ef9		31d2			XORL DX, DX		
	for w := range numWorkers {
  0x1400c3efb		eb32			JMP 0x1400c3f2f		
		return
  0x1400c3efd		4883c428		ADDQ $0x28, SP		
  0x1400c3f01		5d			POPQ BP			
  0x1400c3f02		c3			RET			
	for w := range numWorkers {
  0x1400c3f03		4889542410		MOVQ DX, 0x10(SP)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3f08		488b88502eba07		MOVQ 0x7ba2e50(AX), CX		
  0x1400c3f0f		488b04d1		MOVQ 0(CX)(DX*8), AX		
  0x1400c3f13		488d5c2420		LEAQ 0x20(SP), BX		
  0x1400c3f18		e8e3c7f4ff		CALL runtime.chansend1(SB)	
	for w := range numWorkers {
  0x1400c3f1d		488b542410		MOVQ 0x10(SP), DX	
  0x1400c3f22		48ffc2			INCQ DX			
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3f25		488b442438		MOVQ 0x38(SP), AX	
	for w := range numWorkers {
  0x1400c3f2a		488b4c2418		MOVQ 0x18(SP), CX	
  0x1400c3f2f		4839ca			CMPQ DX, CX		
  0x1400c3f32		7d3e			JGE 0x1400c3f72		
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3f34		48c744242005000000	MOVQ $0x5, 0x20(SP)	
  0x1400c3f3d		488bb0582eba07		MOVQ 0x7ba2e58(AX), SI	
  0x1400c3f44		4839f2			CMPQ DX, SI		
  0x1400c3f47		72ba			JB 0x1400c3f03		
  0x1400c3f49		e941020000		JMP 0x1400c418f		
	for range numWorkers {
  0x1400c3f4e		48894c2418		MOVQ CX, 0x18(SP)	
		<-sim.WorkerDoneChan
  0x1400c3f53		488b80682eba07		MOVQ 0x7ba2e68(AX), AX		
  0x1400c3f5a		31db			XORL BX, BX			
  0x1400c3f5c		0f1f4000		NOPL 0(AX)			
  0x1400c3f60		e81bd6f4ff		CALL runtime.chanrecv1(SB)	
	for range numWorkers {
  0x1400c3f65		488b4c2418		MOVQ 0x18(SP), CX	
  0x1400c3f6a		48ffc9			DECQ CX			
		<-sim.WorkerDoneChan
  0x1400c3f6d		488b442438		MOVQ 0x38(SP), AX	
	for range numWorkers {
  0x1400c3f72		4885c9			TESTQ CX, CX		
  0x1400c3f75		7fd7			JG 0x1400c3f4e		
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c3f77		488b88582eba07		MOVQ 0x7ba2e58(AX), CX	
	for w := range numWorkers {
  0x1400c3f7e		31d2			XORL DX, DX		
  0x1400c3f80		31db			XORL BX, BX		
  0x1400c3f82		eb03			JMP 0x1400c3f87		
  0x1400c3f84		48ffc3			INCQ BX			
  0x1400c3f87		4839cb			CMPQ BX, CX		
  0x1400c3f8a		0f8db0000000		JGE 0x1400c4040		
		p := sim.WorkerIDiag[w].abs_pow
  0x1400c3f90		488b7050		MOVQ 0x50(AX), SI		
  0x1400c3f94		4839f3			CMPQ BX, SI			
  0x1400c3f97		0f83ed010000		JAE 0x1400c418a			
  0x1400c3f9d		488b7048		MOVQ 0x48(AX), SI		
  0x1400c3fa1		4869fb40320000		IMULQ $0x3240, BX, DI		
  0x1400c3fa8		4c8b843e80250000	MOVQ 0x2580(SI)(DI*1), R8	
		g := sim.WorkerIDiag[w].abs_gnd
  0x1400c3fb0		488bb43e88250000	MOVQ 0x2588(SI)(DI*1), SI	
		sim.N_i_abs_pow += p
  0x1400c3fb8		4c018060662707		ADDQ R8, 0x7276660(AX)	
		sim.N_i_abs_gnd += g
  0x1400c3fbf		4801b068662707		ADDQ SI, 0x7276668(AX)	
		totalAbs += int(p + g)
  0x1400c3fc6		4c01c6			ADDQ R8, SI		
  0x1400c3fc9		4801f2			ADDQ SI, DX		
		for eIdx := range N_IFED {
  0x1400c3fcc		31f6			XORL SI, SI		
  0x1400c3fce		eb1e			JMP 0x1400c3fee		
			sim.Ifed_gnd[eIdx] += sim.WorkerIDiag[w].ifed_gnd[eIdx]
  0x1400c3fd0		4c8b4048		MOVQ 0x48(AX), R8		
  0x1400c3fd4		4d8d0438		LEAQ 0(R8)(DI*1), R8		
  0x1400c3fd8		4d8d80d02b0000		LEAQ 0x2bd0(R8), R8		
  0x1400c3fdf		4d030cf0		ADDQ 0(R8)(SI*8), R9		
  0x1400c3fe3		4c898cf030ab2707	MOVQ R9, 0x727ab30(AX)(SI*8)	
		for eIdx := range N_IFED {
  0x1400c3feb		48ffc6			INCQ SI			
  0x1400c3fee		4881fec8000000		CMPQ SI, $0xc8		
  0x1400c3ff5		7d8d			JGE 0x1400c3f84		
			sim.Ifed_pow[eIdx] += sim.WorkerIDiag[w].ifed_pow[eIdx]
  0x1400c3ff7		4c8b4050		MOVQ 0x50(AX), R8		
  0x1400c3ffb		4c8b8cf0f0a42707	MOVQ 0x727a4f0(AX)(SI*8), R9	
  0x1400c4003		4c39c3			CMPQ BX, R8			
  0x1400c4006		0f8379010000		JAE 0x1400c4185			
  0x1400c400c		4c8b4048		MOVQ 0x48(AX), R8		
  0x1400c4010		4d8d0438		LEAQ 0(R8)(DI*1), R8		
  0x1400c4014		4d8d8090250000		LEAQ 0x2590(R8), R8		
  0x1400c401b		4d030cf0		ADDQ 0(R8)(SI*8), R9		
  0x1400c401f		4c898cf0f0a42707	MOVQ R9, 0x727a4f0(AX)(SI*8)	
			sim.Ifed_gnd[eIdx] += sim.WorkerIDiag[w].ifed_gnd[eIdx]
  0x1400c4027		4c8b4050		MOVQ 0x50(AX), R8		
  0x1400c402b		4c8b8cf030ab2707	MOVQ 0x727ab30(AX)(SI*8), R9	
  0x1400c4033		4c39c3			CMPQ BX, R8			
  0x1400c4036		7298			JB 0x1400c3fd0			
  0x1400c4038		e941010000		JMP 0x1400c417e			
  0x1400c403d		0f1f00			NOPL 0(AX)			
	if totalAbs > 0 {
  0x1400c4040		4885d2			TESTQ DX, DX		
  0x1400c4043		7e0e			JLE 0x1400c4053		
		lastValid := sim.N_i - 1
  0x1400c4045		488b98c87e5603		MOVQ 0x3567ec8(AX), BX	
  0x1400c404c		48ffcb			DECQ BX			
		for w := range numWorkers {
  0x1400c404f		31f6			XORL SI, SI		
  0x1400c4051		eb0d			JMP 0x1400c4060		
}
  0x1400c4053		4883c428		ADDQ $0x28, SP		
  0x1400c4057		5d			POPQ BP			
  0x1400c4058		c3			RET			
		for w := range numWorkers {
  0x1400c4059		48ffc6			INCQ SI			
  0x1400c405c		0f1f4000		NOPL 0(AX)		
  0x1400c4060		4839ce			CMPQ SI, CX		
  0x1400c4063		0f8de4000000		JGE 0x1400c414d		
			for _, deadIdx := range sim.WorkerDeadIons[w] {
  0x1400c4069		488bb880000000		MOVQ 0x80(AX), DI	
  0x1400c4070		4839fe			CMPQ SI, DI		
  0x1400c4073		0f8300010000		JAE 0x1400c4179		
  0x1400c4079		488b7878		MOVQ 0x78(AX), DI	
  0x1400c407d		4c8d0476		LEAQ 0(SI)(SI*2), R8	
  0x1400c4081		4e8b0cc7		MOVQ 0(DI)(R8*8), R9	
  0x1400c4085		4a8b7cc708		MOVQ 0x8(DI)(R8*8), DI	
  0x1400c408a		4531c0			XORL R8, R8		
  0x1400c408d		eb03			JMP 0x1400c4092		
  0x1400c408f		49ffc0			INCQ R8			
  0x1400c4092		4939f8			CMPQ R8, DI		
  0x1400c4095		7dc2			JGE 0x1400c4059		
  0x1400c4097		4f8b14c1		MOVQ 0(R9)(R8*8), R10	
				for lastValid > deadIdx && (sim.X_i[lastValid] < 0 || sim.X_i[lastValid] > L) {
  0x1400c409b		eb03			JMP 0x1400c40a0		
					lastValid--
  0x1400c409d		48ffcb			DECQ BX			
				for lastValid > deadIdx && (sim.X_i[lastValid] < 0 || sim.X_i[lastValid] > L) {
  0x1400c40a0		4c39d3			CMPQ BX, R10				
  0x1400c40a3		0f8e94000000		JLE 0x1400c413d				
  0x1400c40a9		4881fb40420f00		CMPQ BX, $0xf4240			
  0x1400c40b0		0f83b9000000		JAE 0x1400c416f				
  0x1400c40b6		f20f1084d8d0c63e05	MOVSD_XMM 0x53ec6d0(AX)(BX*8), X0	
  0x1400c40bf		0f57c9			XORPS X1, X1				
  0x1400c40c2		660f2ec8		UCOMISD X0, X1				
  0x1400c40c6		77d5			JA 0x1400c409d				
  0x1400c40c8		f20f1015c81f0100	MOVSD_XMM runtime.egcbss+10(SB), X2	
  0x1400c40d0		660f2ec2		UCOMISD X2, X0				
  0x1400c40d4		77c7			JA 0x1400c409d				
  0x1400c40d6		4c39d3			CMPQ BX, R10				
				if lastValid > deadIdx {
  0x1400c40d9		7eb4			JLE 0x1400c408f		
  0x1400c40db		0f1f440000		NOPL 0(AX)(AX*1)	
				for lastValid > deadIdx && (sim.X_i[lastValid] < 0 || sim.X_i[lastValid] > L) {
  0x1400c40e0		4881fb40420f00		CMPQ BX, $0xf4240	
					sim.X_i[deadIdx] = sim.X_i[lastValid]
  0x1400c40e7		737c			JAE 0x1400c4165				
  0x1400c40e9		4981fa40420f00		CMPQ R10, $0xf4240			
  0x1400c40f0		7367			JAE 0x1400c4159				
  0x1400c40f2		f2420f1184d0d0c63e05	MOVSD_XMM X0, 0x53ec6d0(AX)(R10*8)	
					sim.Vx_i[deadIdx] = sim.Vx_i[lastValid]
  0x1400c40fc		f20f1084d8d0d8b805	MOVSD_XMM 0x5b8d8d0(AX)(BX*8), X0	
  0x1400c4105		f2420f1184d0d0d8b805	MOVSD_XMM X0, 0x5b8d8d0(AX)(R10*8)	
					sim.Vy_i[deadIdx] = sim.Vy_i[lastValid]
  0x1400c410f		f20f1084d8d0ea3206	MOVSD_XMM 0x632ead0(AX)(BX*8), X0	
  0x1400c4118		f2420f1184d0d0ea3206	MOVSD_XMM X0, 0x632ead0(AX)(R10*8)	
					sim.Vz_i[deadIdx] = sim.Vz_i[lastValid]
  0x1400c4122		f20f1084d8d0fcac06	MOVSD_XMM 0x6acfcd0(AX)(BX*8), X0	
  0x1400c412b		f2420f1184d0d0fcac06	MOVSD_XMM X0, 0x6acfcd0(AX)(R10*8)	
					lastValid--
  0x1400c4135		48ffcb			DECQ BX					
  0x1400c4138		e952ffffff		JMP 0x1400c408f				
  0x1400c413d		0f57c9			XORPS X1, X1				
  0x1400c4140		f20f1015501f0100	MOVSD_XMM runtime.egcbss+10(SB), X2	
				for lastValid > deadIdx && (sim.X_i[lastValid] < 0 || sim.X_i[lastValid] > L) {
  0x1400c4148		e942ffffff		JMP 0x1400c408f		
		sim.N_i -= totalAbs
  0x1400c414d		482990c87e5603		SUBQ DX, 0x3567ec8(AX)	
  0x1400c4154		e9fafeffff		JMP 0x1400c4053		
					sim.X_i[deadIdx] = sim.X_i[lastValid]
  0x1400c4159		b840420f00		MOVL $0xf4240, AX		
  0x1400c415e		6690			NOPW				
  0x1400c4160		e81ba3fbff		CALL runtime.panicBounds(SB)	
  0x1400c4165		b840420f00		MOVL $0xf4240, AX		
  0x1400c416a		e811a3fbff		CALL runtime.panicBounds(SB)	
				for lastValid > deadIdx && (sim.X_i[lastValid] < 0 || sim.X_i[lastValid] > L) {
  0x1400c416f		b840420f00		MOVL $0xf4240, AX		
  0x1400c4174		e807a3fbff		CALL runtime.panicBounds(SB)	
			for _, deadIdx := range sim.WorkerDeadIons[w] {
  0x1400c4179		e802a3fbff		CALL runtime.panicBounds(SB)	
			sim.Ifed_gnd[eIdx] += sim.WorkerIDiag[w].ifed_gnd[eIdx]
  0x1400c417e		6690			NOPW				
  0x1400c4180		e8fba2fbff		CALL runtime.panicBounds(SB)	
			sim.Ifed_pow[eIdx] += sim.WorkerIDiag[w].ifed_pow[eIdx]
  0x1400c4185		e8f6a2fbff		CALL runtime.panicBounds(SB)	
		p := sim.WorkerIDiag[w].abs_pow
  0x1400c418a		e8f1a2fbff		CALL runtime.panicBounds(SB)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c418f		e8eca2fbff		CALL runtime.panicBounds(SB)	
  0x1400c4194		90			NOPL				
func (sim *SimulationState) Step6CheckBoundariesIons(t int) {
  0x1400c4195		4889442408		MOVQ AX, 0x8(SP)						
  0x1400c419a		48895c2410		MOVQ BX, 0x10(SP)						
  0x1400c419f		90			NOPL								
  0x1400c41a0		e89b84fbff		CALL runtime.morestack_noctxt.abi0(SB)				
  0x1400c41a5		488b442408		MOVQ 0x8(SP), AX						
  0x1400c41aa		488b5c2410		MOVQ 0x10(SP), BX						
  0x1400c41af		e9ecfcffff		JMP gopic.(*SimulationState).Step6CheckBoundariesIons(SB)	

  0x1400c41b4		cc			INT $0x3		
  0x1400c41b5		cc			INT $0x3		
  0x1400c41b6		cc			INT $0x3		
  0x1400c41b7		cc			INT $0x3		
  0x1400c41b8		cc			INT $0x3		
  0x1400c41b9		cc			INT $0x3		
  0x1400c41ba		cc			INT $0x3		
  0x1400c41bb		cc			INT $0x3		
  0x1400c41bc		cc			INT $0x3		
  0x1400c41bd		cc			INT $0x3		
  0x1400c41be		cc			INT $0x3		
  0x1400c41bf		cc			INT $0x3		


