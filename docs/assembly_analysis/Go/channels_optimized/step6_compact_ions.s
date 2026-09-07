// =============================================================================
// SYMBOL: Step6CompactIons
// =============================================================================

TEXT gopic.(*SimulationState).Step6CompactIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/simulation.go
func (sim *SimulationState) Step6CompactIons(t int) {
  0x1400c45e0		55			PUSHQ BP		
  0x1400c45e1		4889e5			MOVQ SP, BP		
	if (t % N_SUB) != 0 {
  0x1400c45e4		48b9cdcccccccccccccc	MOVQ $0xcccccccccccccccd, CX	
  0x1400c45ee		480fafd9		IMULQ CX, BX			
  0x1400c45f2		48b99899999999999919	MOVQ $0x1999999999999998, CX	
  0x1400c45fc		4801d9			ADDQ BX, CX			
  0x1400c45ff		48c1c13e		ROLQ $0x3e, CX			
  0x1400c4603		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x1400c460d		4839ca			CMPQ DX, CX			
  0x1400c4610		7206			JB 0x1400c4618			
  0x1400c4612		31c9			XORL CX, CX			
  0x1400c4614		31d2			XORL DX, DX			
  0x1400c4616		eb05			JMP 0x1400c461d			
		return
  0x1400c4618		5d			POPQ BP			
  0x1400c4619		c3			RET			
	for w := 0; w < sim.NumWorkers; w++ {
  0x1400c461a		48ffc1			INCQ CX			
  0x1400c461d		8400			TESTB AL, 0(AX)		
  0x1400c461f		90			NOPL			
  0x1400c4620		483988482eba07		CMPQ 0x7ba2e48(AX), CX	
  0x1400c4627		0f8ead000000		JLE 0x1400c46da		
		p := sim.WorkerIDiag[w].abs_pow
  0x1400c462d		488b5850		MOVQ 0x50(AX), BX		
  0x1400c4631		4839d9			CMPQ CX, BX			
  0x1400c4634		0f83b0020000		JAE 0x1400c48ea			
  0x1400c463a		488b5848		MOVQ 0x48(AX), BX		
  0x1400c463e		4869f140320000		IMULQ $0x3240, CX, SI		
  0x1400c4645		488bbc3380250000	MOVQ 0x2580(BX)(SI*1), DI	
		g := sim.WorkerIDiag[w].abs_gnd
  0x1400c464d		488b9c3388250000	MOVQ 0x2588(BX)(SI*1), BX	
		sim.N_i_abs_pow += p
  0x1400c4655		4801b860662707		ADDQ DI, 0x7276660(AX)	
		sim.N_i_abs_gnd += g
  0x1400c465c		48019868662707		ADDQ BX, 0x7276668(AX)	
		totalAbs += int(p + g)
  0x1400c4663		4801fb			ADDQ DI, BX		
  0x1400c4666		4801da			ADDQ BX, DX		
		for eIdx := 0; eIdx < N_IFED; eIdx++ {
  0x1400c4669		31db			XORL BX, BX		
  0x1400c466b		eb1e			JMP 0x1400c468b		
			sim.Ifed_gnd[eIdx] += sim.WorkerIDiag[w].ifed_gnd[eIdx]
  0x1400c466d		488b7848		MOVQ 0x48(AX), DI		
  0x1400c4671		488d3c37		LEAQ 0(DI)(SI*1), DI		
  0x1400c4675		488dbfd02b0000		LEAQ 0x2bd0(DI), DI		
  0x1400c467c		4c0304df		ADDQ 0(DI)(BX*8), R8		
  0x1400c4680		4c8984d830ab2707	MOVQ R8, 0x727ab30(AX)(BX*8)	
		for eIdx := 0; eIdx < N_IFED; eIdx++ {
  0x1400c4688		48ffc3			INCQ BX			
  0x1400c468b		4881fbc8000000		CMPQ BX, $0xc8		
  0x1400c4692		7d86			JGE 0x1400c461a		
			sim.Ifed_pow[eIdx] += sim.WorkerIDiag[w].ifed_pow[eIdx]
  0x1400c4694		488b7850		MOVQ 0x50(AX), DI		
  0x1400c4698		4c8b84d8f0a42707	MOVQ 0x727a4f0(AX)(BX*8), R8	
  0x1400c46a0		4839f9			CMPQ CX, DI			
  0x1400c46a3		0f833c020000		JAE 0x1400c48e5			
  0x1400c46a9		488b7848		MOVQ 0x48(AX), DI		
  0x1400c46ad		488d3c37		LEAQ 0(DI)(SI*1), DI		
  0x1400c46b1		488dbf90250000		LEAQ 0x2590(DI), DI		
  0x1400c46b8		4c0304df		ADDQ 0(DI)(BX*8), R8		
  0x1400c46bc		4c8984d8f0a42707	MOVQ R8, 0x727a4f0(AX)(BX*8)	
			sim.Ifed_gnd[eIdx] += sim.WorkerIDiag[w].ifed_gnd[eIdx]
  0x1400c46c4		488b7850		MOVQ 0x50(AX), DI		
  0x1400c46c8		4c8b84d830ab2707	MOVQ 0x727ab30(AX)(BX*8), R8	
  0x1400c46d0		4839f9			CMPQ CX, DI			
  0x1400c46d3		7298			JB 0x1400c466d			
  0x1400c46d5		e905020000		JMP 0x1400c48df			
	if totalAbs > 0 {
  0x1400c46da		4885d2			TESTQ DX, DX		
  0x1400c46dd		7e0e			JLE 0x1400c46ed		
		lastValid := sim.N_i - 1
  0x1400c46df		488b88c87e5603		MOVQ 0x3567ec8(AX), CX	
  0x1400c46e6		48ffc9			DECQ CX			
		for w := 0; w < sim.NumWorkers; w++ {
  0x1400c46e9		31db			XORL BX, BX		
  0x1400c46eb		eb15			JMP 0x1400c4702		
}
  0x1400c46ed		5d			POPQ BP			
  0x1400c46ee		c3			RET			
			sim.WorkerIDiag[w].abs_gnd = 0
  0x1400c46ef		488b7048			MOVQ 0x48(AX), SI		
  0x1400c46f3		48c7843e8825000000000000	MOVQ $0x0, 0x2588(SI)(DI*1)	
		for w := 0; w < sim.NumWorkers; w++ {
  0x1400c46ff		48ffc3			INCQ BX			
  0x1400c4702		488bb0482eba07		MOVQ 0x7ba2e48(AX), SI	
  0x1400c4709		4839f3			CMPQ BX, SI		
  0x1400c470c		0f8d46010000		JGE 0x1400c4858		
			for _, deadIdx := range sim.WorkerDeadIons[w] {
  0x1400c4712		488bb080000000		MOVQ 0x80(AX), SI	
  0x1400c4719		0f1f8000000000		NOPL 0(AX)		
  0x1400c4720		4839f3			CMPQ BX, SI		
  0x1400c4723		0f83b1010000		JAE 0x1400c48da		
  0x1400c4729		488b7078		MOVQ 0x78(AX), SI	
  0x1400c472d		488d3c5b		LEAQ 0(BX)(BX*2), DI	
  0x1400c4731		4c8b04fe		MOVQ 0(SI)(DI*8), R8	
  0x1400c4735		488b74fe08		MOVQ 0x8(SI)(DI*8), SI	
  0x1400c473a		4531c9			XORL R9, R9		
  0x1400c473d		eb03			JMP 0x1400c4742		
  0x1400c473f		49ffc1			INCQ R9			
  0x1400c4742		4939f1			CMPQ R9, SI		
  0x1400c4745		0f8dbd000000		JGE 0x1400c4808		
  0x1400c474b		4f8b14c8		MOVQ 0(R8)(R9*8), R10	
				for lastValid > deadIdx && (sim.X_i[lastValid] < 0 || sim.X_i[lastValid] > L) {
  0x1400c474f		eb03			JMP 0x1400c4754		
					lastValid--
  0x1400c4751		48ffc9			DECQ CX			
				for lastValid > deadIdx && (sim.X_i[lastValid] < 0 || sim.X_i[lastValid] > L) {
  0x1400c4754		4c39d1			CMPQ CX, R10				
  0x1400c4757		0f8e9b000000		JLE 0x1400c47f8				
  0x1400c475d		0f1f00			NOPL 0(AX)				
  0x1400c4760		4881f940420f00		CMPQ CX, $0xf4240			
  0x1400c4767		0f8363010000		JAE 0x1400c48d0				
  0x1400c476d		f20f1084c8d0c63e05	MOVSD_XMM 0x53ec6d0(AX)(CX*8), X0	
  0x1400c4776		0f57c9			XORPS X1, X1				
  0x1400c4779		660f2ec8		UCOMISD X0, X1				
  0x1400c477d		77d2			JA 0x1400c4751				
  0x1400c477f		f20f101561290100	MOVSD_XMM runtime.egcbss+10(SB), X2	
  0x1400c4787		660f2ec2		UCOMISD X2, X0				
  0x1400c478b		77c4			JA 0x1400c4751				
  0x1400c478d		4c39d1			CMPQ CX, R10				
				if lastValid > deadIdx {
  0x1400c4790		7ead			JLE 0x1400c473f		
				for lastValid > deadIdx && (sim.X_i[lastValid] < 0 || sim.X_i[lastValid] > L) {
  0x1400c4792		4881f940420f00		CMPQ CX, $0xf4240	
					sim.X_i[deadIdx] = sim.X_i[lastValid]
  0x1400c4799		0f8327010000		JAE 0x1400c48c6				
  0x1400c479f		90			NOPL					
  0x1400c47a0		4981fa40420f00		CMPQ R10, $0xf4240			
  0x1400c47a7		0f830f010000		JAE 0x1400c48bc				
  0x1400c47ad		f2420f1184d0d0c63e05	MOVSD_XMM X0, 0x53ec6d0(AX)(R10*8)	
					sim.Vx_i[deadIdx] = sim.Vx_i[lastValid]
  0x1400c47b7		f20f1084c8d0d8b805	MOVSD_XMM 0x5b8d8d0(AX)(CX*8), X0	
  0x1400c47c0		f2420f1184d0d0d8b805	MOVSD_XMM X0, 0x5b8d8d0(AX)(R10*8)	
					sim.Vy_i[deadIdx] = sim.Vy_i[lastValid]
  0x1400c47ca		f20f1084c8d0ea3206	MOVSD_XMM 0x632ead0(AX)(CX*8), X0	
  0x1400c47d3		f2420f1184d0d0ea3206	MOVSD_XMM X0, 0x632ead0(AX)(R10*8)	
					sim.Vz_i[deadIdx] = sim.Vz_i[lastValid]
  0x1400c47dd		f20f1084c8d0fcac06	MOVSD_XMM 0x6acfcd0(AX)(CX*8), X0	
  0x1400c47e6		f2420f1184d0d0fcac06	MOVSD_XMM X0, 0x6acfcd0(AX)(R10*8)	
					lastValid--
  0x1400c47f0		48ffc9			DECQ CX					
  0x1400c47f3		e947ffffff		JMP 0x1400c473f				
  0x1400c47f8		0f57c9			XORPS X1, X1				
  0x1400c47fb		f20f1015e5280100	MOVSD_XMM runtime.egcbss+10(SB), X2	
				for lastValid > deadIdx && (sim.X_i[lastValid] < 0 || sim.X_i[lastValid] > L) {
  0x1400c4803		e937ffffff		JMP 0x1400c473f		
			sim.WorkerDeadIons[w] = sim.WorkerDeadIons[w][:0]
  0x1400c4808		488bb080000000		MOVQ 0x80(AX), SI		
  0x1400c480f		4839f3			CMPQ BX, SI			
  0x1400c4812		0f839f000000		JAE 0x1400c48b7			
  0x1400c4818		488b7078		MOVQ 0x78(AX), SI		
  0x1400c481c		48c744fe0800000000	MOVQ $0x0, 0x8(SI)(DI*8)	
			sim.WorkerIDiag[w].abs_pow = 0
  0x1400c4825		488b7050			MOVQ 0x50(AX), SI		
  0x1400c4829		4839f3				CMPQ BX, SI			
  0x1400c482c		0f8380000000			JAE 0x1400c48b2			
  0x1400c4832		488b7048			MOVQ 0x48(AX), SI		
  0x1400c4836		4869fb40320000			IMULQ $0x3240, BX, DI		
  0x1400c483d		48c7843e8025000000000000	MOVQ $0x0, 0x2580(SI)(DI*1)	
			sim.WorkerIDiag[w].abs_gnd = 0
  0x1400c4849		488b7050		MOVQ 0x50(AX), SI	
  0x1400c484d		4839f3			CMPQ BX, SI		
  0x1400c4850		0f8299feffff		JB 0x1400c46ef		
  0x1400c4856		eb55			JMP 0x1400c48ad		
		sim.N_i -= totalAbs
  0x1400c4858		488b88c87e5603		MOVQ 0x3567ec8(AX), CX	
  0x1400c485f		4829d1			SUBQ DX, CX		
  0x1400c4862		488988c87e5603		MOVQ CX, 0x3567ec8(AX)	
		sim.UpdateChunkSizes()
  0x1400c4869		90			NOPL			
	if sim.NumWorkers > 0 {
  0x1400c486a		4885f6			TESTQ SI, SI		
  0x1400c486d		0f8e7afeffff		JLE 0x1400c46ed		
		sim.EChunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c4873		488b90c07e5603		MOVQ 0x3567ec0(AX), DX	
  0x1400c487a		488d1432		LEAQ 0(DX)(SI*1), DX	
  0x1400c487e		488d52ff		LEAQ -0x1(DX), DX	
	if (t % N_SUB) != 0 {
  0x1400c4882		4889c3			MOVQ AX, BX		
		sim.EChunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c4885		4889d0			MOVQ DX, AX		
  0x1400c4888		4899			CQO			
  0x1400c488a		48f7fe			IDIVQ SI		
  0x1400c488d		488983582eba07		MOVQ AX, 0x7ba2e58(BX)	
		sim.IChunkSize = (sim.N_i + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c4894		488d0431		LEAQ 0(CX)(SI*1), AX	
  0x1400c4898		488d40ff		LEAQ -0x1(AX), AX	
  0x1400c489c		4899			CQO			
  0x1400c489e		48f7fe			IDIVQ SI		
  0x1400c48a1		488983602eba07		MOVQ AX, 0x7ba2e60(BX)	
  0x1400c48a8		e940feffff		JMP 0x1400c46ed		
			sim.WorkerIDiag[w].abs_gnd = 0
  0x1400c48ad		e8ce9bfbff		CALL runtime.panicBounds(SB)	
			sim.WorkerIDiag[w].abs_pow = 0
  0x1400c48b2		e8c99bfbff		CALL runtime.panicBounds(SB)	
			sim.WorkerDeadIons[w] = sim.WorkerDeadIons[w][:0]
  0x1400c48b7		e8c49bfbff		CALL runtime.panicBounds(SB)	
					sim.X_i[deadIdx] = sim.X_i[lastValid]
  0x1400c48bc		b840420f00		MOVL $0xf4240, AX		
  0x1400c48c1		e8ba9bfbff		CALL runtime.panicBounds(SB)	
  0x1400c48c6		b840420f00		MOVL $0xf4240, AX		
  0x1400c48cb		e8b09bfbff		CALL runtime.panicBounds(SB)	
				for lastValid > deadIdx && (sim.X_i[lastValid] < 0 || sim.X_i[lastValid] > L) {
  0x1400c48d0		b840420f00		MOVL $0xf4240, AX		
  0x1400c48d5		e8a69bfbff		CALL runtime.panicBounds(SB)	
			for _, deadIdx := range sim.WorkerDeadIons[w] {
  0x1400c48da		e8a19bfbff		CALL runtime.panicBounds(SB)	
			sim.Ifed_gnd[eIdx] += sim.WorkerIDiag[w].ifed_gnd[eIdx]
  0x1400c48df		90			NOPL				
  0x1400c48e0		e89b9bfbff		CALL runtime.panicBounds(SB)	
			sim.Ifed_pow[eIdx] += sim.WorkerIDiag[w].ifed_pow[eIdx]
  0x1400c48e5		e8969bfbff		CALL runtime.panicBounds(SB)	
		p := sim.WorkerIDiag[w].abs_pow
  0x1400c48ea		e8919bfbff		CALL runtime.panicBounds(SB)	
  0x1400c48ef		90			NOPL				

  0x1400c48f0		cc			INT $0x3		
  0x1400c48f1		cc			INT $0x3		
  0x1400c48f2		cc			INT $0x3		
  0x1400c48f3		cc			INT $0x3		
  0x1400c48f4		cc			INT $0x3		
  0x1400c48f5		cc			INT $0x3		
  0x1400c48f6		cc			INT $0x3		
  0x1400c48f7		cc			INT $0x3		
  0x1400c48f8		cc			INT $0x3		
  0x1400c48f9		cc			INT $0x3		
  0x1400c48fa		cc			INT $0x3		
  0x1400c48fb		cc			INT $0x3		
  0x1400c48fc		cc			INT $0x3		
  0x1400c48fd		cc			INT $0x3		
  0x1400c48fe		cc			INT $0x3		
  0x1400c48ff		cc			INT $0x3		


