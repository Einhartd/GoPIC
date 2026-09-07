// =============================================================================
// SYMBOL: Step5CompactElectrons
// =============================================================================

TEXT gopic.(*SimulationState).Step5CompactElectrons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/simulation.go
func (sim *SimulationState) Step5CompactElectrons() {
  0x1400c4360		55			PUSHQ BP		
  0x1400c4361		4889e5			MOVQ SP, BP		
	for w := 0; w < sim.NumWorkers; w++ {
  0x1400c4364		31c9			XORL CX, CX		
  0x1400c4366		31d2			XORL DX, DX		
  0x1400c4368		eb32			JMP 0x1400c439c		
		p := sim.WorkerEDiag[w].abs_pow
  0x1400c436a		488b5830		MOVQ 0x30(AX), BX		
  0x1400c436e		4869f1c0700000		IMULQ $0x70c0, CX, SI		
  0x1400c4375		488bbc3390700000	MOVQ 0x7090(BX)(SI*1), DI	
		g := sim.WorkerEDiag[w].abs_gnd
  0x1400c437d		488b9c3398700000	MOVQ 0x7098(BX)(SI*1), BX	
		sim.N_e_abs_pow += p
  0x1400c4385		4801b850662707		ADDQ DI, 0x7276650(AX)	
		sim.N_e_abs_gnd += g
  0x1400c438c		48019858662707		ADDQ BX, 0x7276658(AX)	
		totalAbs += int(p + g)
  0x1400c4393		4801fb			ADDQ DI, BX		
  0x1400c4396		4801da			ADDQ BX, DX		
	for w := 0; w < sim.NumWorkers; w++ {
  0x1400c4399		48ffc1			INCQ CX			
  0x1400c439c		8400			TESTB AL, 0(AX)		
  0x1400c439e		6690			NOPW			
  0x1400c43a0		483988482eba07		CMPQ 0x7ba2e48(AX), CX	
  0x1400c43a7		7e0e			JLE 0x1400c43b7		
		p := sim.WorkerEDiag[w].abs_pow
  0x1400c43a9		488b5838		MOVQ 0x38(AX), BX	
  0x1400c43ad		4839d9			CMPQ CX, BX		
  0x1400c43b0		72b8			JB 0x1400c436a		
  0x1400c43b2		e907020000		JMP 0x1400c45be		
	if totalAbs > 0 {
  0x1400c43b7		4885d2			TESTQ DX, DX		
  0x1400c43ba		7e0e			JLE 0x1400c43ca		
		lastValid := sim.N_e - 1
  0x1400c43bc		488b88c07e5603		MOVQ 0x3567ec0(AX), CX	
  0x1400c43c3		48ffc9			DECQ CX			
		for w := 0; w < sim.NumWorkers; w++ {
  0x1400c43c6		31db			XORL BX, BX		
  0x1400c43c8		eb15			JMP 0x1400c43df		
}
  0x1400c43ca		5d			POPQ BP			
  0x1400c43cb		c3			RET			
			sim.WorkerEDiag[w].abs_gnd = 0
  0x1400c43cc		488b7030			MOVQ 0x30(AX), SI		
  0x1400c43d0		48c7843e9870000000000000	MOVQ $0x0, 0x7098(SI)(DI*1)	
		for w := 0; w < sim.NumWorkers; w++ {
  0x1400c43dc		48ffc3			INCQ BX			
  0x1400c43df		488bb0482eba07		MOVQ 0x7ba2e48(AX), SI	
  0x1400c43e6		4839f3			CMPQ BX, SI		
  0x1400c43e9		0f8d40010000		JGE 0x1400c452f		
			for _, deadIdx := range sim.WorkerDeadElectrons[w] {
  0x1400c43ef		488b7068		MOVQ 0x68(AX), SI	
  0x1400c43f3		4839f3			CMPQ BX, SI		
  0x1400c43f6		0f83bd010000		JAE 0x1400c45b9		
  0x1400c43fc		488b7060		MOVQ 0x60(AX), SI	
  0x1400c4400		488d3c5b		LEAQ 0(BX)(BX*2), DI	
  0x1400c4404		4c8b04fe		MOVQ 0(SI)(DI*8), R8	
  0x1400c4408		488b74fe08		MOVQ 0x8(SI)(DI*8), SI	
  0x1400c440d		4531c9			XORL R9, R9		
  0x1400c4410		eb03			JMP 0x1400c4415		
  0x1400c4412		49ffc1			INCQ R9			
  0x1400c4415		4939f1			CMPQ R9, SI		
  0x1400c4418		0f8dbc000000		JGE 0x1400c44da		
  0x1400c441e		4f8b14c8		MOVQ 0(R8)(R9*8), R10	
				for lastValid > deadIdx && (sim.X_e[lastValid] < 0 || sim.X_e[lastValid] > L) {
  0x1400c4422		eb03			JMP 0x1400c4427		
					lastValid--
  0x1400c4424		48ffc9			DECQ CX			
				for lastValid > deadIdx && (sim.X_e[lastValid] < 0 || sim.X_e[lastValid] > L) {
  0x1400c4427		4c39d1			CMPQ CX, R10				
  0x1400c442a		0f8e9a000000		JLE 0x1400c44ca				
  0x1400c4430		4881f940420f00		CMPQ CX, $0xf4240			
  0x1400c4437		0f8372010000		JAE 0x1400c45af				
  0x1400c443d		f20f1084c8d07e5603	MOVSD_XMM 0x3567ed0(AX)(CX*8), X0	
  0x1400c4446		0f57c9			XORPS X1, X1				
  0x1400c4449		660f2ec8		UCOMISD X0, X1				
  0x1400c444d		77d5			JA 0x1400c4424				
  0x1400c444f		f20f1015912c0100	MOVSD_XMM runtime.egcbss+10(SB), X2	
  0x1400c4457		660f2ec2		UCOMISD X2, X0				
  0x1400c445b		77c7			JA 0x1400c4424				
  0x1400c445d		0f1f00			NOPL 0(AX)				
  0x1400c4460		4c39d1			CMPQ CX, R10				
				if lastValid > deadIdx {
  0x1400c4463		7ead			JLE 0x1400c4412		
				for lastValid > deadIdx && (sim.X_e[lastValid] < 0 || sim.X_e[lastValid] > L) {
  0x1400c4465		4881f940420f00		CMPQ CX, $0xf4240	
					sim.X_e[deadIdx] = sim.X_e[lastValid]
  0x1400c446c		0f8333010000		JAE 0x1400c45a5				
  0x1400c4472		4981fa40420f00		CMPQ R10, $0xf4240			
  0x1400c4479		0f8317010000		JAE 0x1400c4596				
  0x1400c447f		f2420f1184d0d07e5603	MOVSD_XMM X0, 0x3567ed0(AX)(R10*8)	
					sim.Vx_e[deadIdx] = sim.Vx_e[lastValid]
  0x1400c4489		f20f1084c8d090d003	MOVSD_XMM 0x3d090d0(AX)(CX*8), X0	
  0x1400c4492		f2420f1184d0d090d003	MOVSD_XMM X0, 0x3d090d0(AX)(R10*8)	
					sim.Vy_e[deadIdx] = sim.Vy_e[lastValid]
  0x1400c449c		f20f1084c8d0a24a04	MOVSD_XMM 0x44aa2d0(AX)(CX*8), X0	
  0x1400c44a5		f2420f1184d0d0a24a04	MOVSD_XMM X0, 0x44aa2d0(AX)(R10*8)	
					sim.Vz_e[deadIdx] = sim.Vz_e[lastValid]
  0x1400c44af		f20f1084c8d0b4c404	MOVSD_XMM 0x4c4b4d0(AX)(CX*8), X0	
  0x1400c44b8		f2420f1184d0d0b4c404	MOVSD_XMM X0, 0x4c4b4d0(AX)(R10*8)	
					lastValid--
  0x1400c44c2		48ffc9			DECQ CX					
  0x1400c44c5		e948ffffff		JMP 0x1400c4412				
  0x1400c44ca		0f57c9			XORPS X1, X1				
  0x1400c44cd		f20f1015132c0100	MOVSD_XMM runtime.egcbss+10(SB), X2	
				for lastValid > deadIdx && (sim.X_e[lastValid] < 0 || sim.X_e[lastValid] > L) {
  0x1400c44d5		e938ffffff		JMP 0x1400c4412		
			sim.WorkerDeadElectrons[w] = sim.WorkerDeadElectrons[w][:0]
  0x1400c44da		488b7068		MOVQ 0x68(AX), SI		
  0x1400c44de		6690			NOPW				
  0x1400c44e0		4839f3			CMPQ BX, SI			
  0x1400c44e3		0f83a8000000		JAE 0x1400c4591			
  0x1400c44e9		488b7060		MOVQ 0x60(AX), SI		
  0x1400c44ed		48c744fe0800000000	MOVQ $0x0, 0x8(SI)(DI*8)	
			sim.WorkerEDiag[w].abs_pow = 0
  0x1400c44f6		488b7038			MOVQ 0x38(AX), SI		
  0x1400c44fa		660f1f440000			NOPW 0(AX)(AX*1)		
  0x1400c4500		4839f3				CMPQ BX, SI			
  0x1400c4503		0f8383000000			JAE 0x1400c458c			
  0x1400c4509		488b7030			MOVQ 0x30(AX), SI		
  0x1400c450d		4869fbc0700000			IMULQ $0x70c0, BX, DI		
  0x1400c4514		48c7843e9070000000000000	MOVQ $0x0, 0x7090(SI)(DI*1)	
			sim.WorkerEDiag[w].abs_gnd = 0
  0x1400c4520		488b7038		MOVQ 0x38(AX), SI	
  0x1400c4524		4839f3			CMPQ BX, SI		
  0x1400c4527		0f829ffeffff		JB 0x1400c43cc		
  0x1400c452d		eb58			JMP 0x1400c4587		
		sim.N_e -= totalAbs
  0x1400c452f		488b88c07e5603		MOVQ 0x3567ec0(AX), CX	
  0x1400c4536		4829d1			SUBQ DX, CX		
  0x1400c4539		488988c07e5603		MOVQ CX, 0x3567ec0(AX)	
		sim.UpdateChunkSizes()
  0x1400c4540		90			NOPL			
	if sim.NumWorkers > 0 {
  0x1400c4541		4885f6			TESTQ SI, SI		
  0x1400c4544		0f8e80feffff		JLE 0x1400c43ca		
		sim.EChunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c454a		488d0c31		LEAQ 0(CX)(SI*1), CX	
  0x1400c454e		488d49ff		LEAQ -0x1(CX), CX	
	for w := 0; w < sim.NumWorkers; w++ {
  0x1400c4552		4889c2			MOVQ AX, DX		
		sim.EChunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c4555		4889c8			MOVQ CX, AX		
	for w := 0; w < sim.NumWorkers; w++ {
  0x1400c4558		4889d1			MOVQ DX, CX		
		sim.EChunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c455b		4899			CQO			
  0x1400c455d		48f7fe			IDIVQ SI		
  0x1400c4560		488981582eba07		MOVQ AX, 0x7ba2e58(CX)	
		sim.IChunkSize = (sim.N_i + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c4567		488b91c87e5603		MOVQ 0x3567ec8(CX), DX	
  0x1400c456e		488d0432		LEAQ 0(DX)(SI*1), AX	
  0x1400c4572		488d40ff		LEAQ -0x1(AX), AX	
  0x1400c4576		4899			CQO			
  0x1400c4578		48f7fe			IDIVQ SI		
  0x1400c457b		488981602eba07		MOVQ AX, 0x7ba2e60(CX)	
  0x1400c4582		e943feffff		JMP 0x1400c43ca		
			sim.WorkerEDiag[w].abs_gnd = 0
  0x1400c4587		e8f49efbff		CALL runtime.panicBounds(SB)	
			sim.WorkerEDiag[w].abs_pow = 0
  0x1400c458c		e8ef9efbff		CALL runtime.panicBounds(SB)	
			sim.WorkerDeadElectrons[w] = sim.WorkerDeadElectrons[w][:0]
  0x1400c4591		e8ea9efbff		CALL runtime.panicBounds(SB)	
					sim.X_e[deadIdx] = sim.X_e[lastValid]
  0x1400c4596		b840420f00		MOVL $0xf4240, AX		
  0x1400c459b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x1400c45a0		e8db9efbff		CALL runtime.panicBounds(SB)	
  0x1400c45a5		b840420f00		MOVL $0xf4240, AX		
  0x1400c45aa		e8d19efbff		CALL runtime.panicBounds(SB)	
				for lastValid > deadIdx && (sim.X_e[lastValid] < 0 || sim.X_e[lastValid] > L) {
  0x1400c45af		b840420f00		MOVL $0xf4240, AX		
  0x1400c45b4		e8c79efbff		CALL runtime.panicBounds(SB)	
			for _, deadIdx := range sim.WorkerDeadElectrons[w] {
  0x1400c45b9		e8c29efbff		CALL runtime.panicBounds(SB)	
		p := sim.WorkerEDiag[w].abs_pow
  0x1400c45be		6690			NOPW				
  0x1400c45c0		e8bb9efbff		CALL runtime.panicBounds(SB)	
  0x1400c45c5		90			NOPL				

  0x1400c45c6		cc			INT $0x3		
  0x1400c45c7		cc			INT $0x3		
  0x1400c45c8		cc			INT $0x3		
  0x1400c45c9		cc			INT $0x3		
  0x1400c45ca		cc			INT $0x3		
  0x1400c45cb		cc			INT $0x3		
  0x1400c45cc		cc			INT $0x3		
  0x1400c45cd		cc			INT $0x3		
  0x1400c45ce		cc			INT $0x3		
  0x1400c45cf		cc			INT $0x3		
  0x1400c45d0		cc			INT $0x3		
  0x1400c45d1		cc			INT $0x3		
  0x1400c45d2		cc			INT $0x3		
  0x1400c45d3		cc			INT $0x3		
  0x1400c45d4		cc			INT $0x3		
  0x1400c45d5		cc			INT $0x3		
  0x1400c45d6		cc			INT $0x3		
  0x1400c45d7		cc			INT $0x3		
  0x1400c45d8		cc			INT $0x3		
  0x1400c45d9		cc			INT $0x3		
  0x1400c45da		cc			INT $0x3		
  0x1400c45db		cc			INT $0x3		
  0x1400c45dc		cc			INT $0x3		
  0x1400c45dd		cc			INT $0x3		
  0x1400c45de		cc			INT $0x3		
  0x1400c45df		cc			INT $0x3		


