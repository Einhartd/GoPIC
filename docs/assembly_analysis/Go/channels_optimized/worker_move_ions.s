// =============================================================================
// SYMBOL: workerMoveIons
// =============================================================================

TEXT gopic.(*SimulationState).workerMoveIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/worker.go
func (sim *SimulationState) workerMoveIons(workerID int) {
  0x1400c7880		4c8d642480		LEAQ -0x80(SP), R12	
  0x1400c7885		4d3b6610		CMPQ R12, 0x10(R14)	
  0x1400c7889		0f86e6150000		JBE 0x1400c8e75		
  0x1400c788f		55			PUSHQ BP		
  0x1400c7890		4889e5			MOVQ SP, BP		
  0x1400c7893		4881ecf8000000		SUBQ $0xf8, SP		
	chunkSize := sim.IChunkSize
  0x1400c789a		8400			TESTB AL, 0(AX)		
  0x1400c789c		488b90602eba07		MOVQ 0x7ba2e60(AX), DX	
	if chunkSize <= 0 {
  0x1400c78a3		4885d2			TESTQ DX, DX		
  0x1400c78a6		7f3b			JG 0x1400c78e3		
		chunkSize = (sim.N_i + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c78a8		488b90c87e5603		MOVQ 0x3567ec8(AX), DX	
  0x1400c78af		4c8b80482eba07		MOVQ 0x7ba2e48(AX), R8	
  0x1400c78b6		4a8d1402		LEAQ 0(DX)(R8*1), DX	
  0x1400c78ba		488d52ff		LEAQ -0x1(DX), DX	
  0x1400c78be		6690			NOPW			
  0x1400c78c0		4d85c0			TESTQ R8, R8		
  0x1400c78c3		0f84a6150000		JE 0x1400c8e6f		
	if chunkSize <= 0 {
  0x1400c78c9		4889c1			MOVQ AX, CX		
		chunkSize = (sim.N_i + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c78cc		4889d0			MOVQ DX, AX		
  0x1400c78cf		4983f8ff		CMPQ R8, $-0x1		
  0x1400c78d3		7507			JNE 0x1400c78dc		
  0x1400c78d5		48f7d8			NEGQ AX			
  0x1400c78d8		31d2			XORL DX, DX		
  0x1400c78da		eb0d			JMP 0x1400c78e9		
  0x1400c78dc		4899			CQO			
  0x1400c78de		49f7f8			IDIVQ R8		
  0x1400c78e1		eb06			JMP 0x1400c78e9		
	if end > sim.N_i {
  0x1400c78e3		4889c1			MOVQ AX, CX		
	start := workerID * chunkSize
  0x1400c78e6		4889d0			MOVQ DX, AX		
  0x1400c78e9		4889c2			MOVQ AX, DX		
  0x1400c78ec		480fafc3		IMULQ BX, AX		
	end := start + chunkSize
  0x1400c78f0		4801c2			ADDQ AX, DX		
	if end > sim.N_i {
  0x1400c78f3		4c8b81c87e5603		MOVQ 0x3567ec8(CX), R8	
	diag := &sim.WorkerIDiag[workerID]
  0x1400c78fa		4c8b4950		MOVQ 0x50(CX), R9	
	if end > sim.N_i {
  0x1400c78fe		4939d0			CMPQ R8, DX		
	diag := &sim.WorkerIDiag[workerID]
  0x1400c7901		490f4cd0		CMOVL R8, DX		
  0x1400c7905		4c39cb			CMPQ BX, R9		
	if end > sim.N_i {
  0x1400c7908		0f835c150000		JAE 0x1400c8e6a		
	diag := &sim.WorkerIDiag[workerID]
  0x1400c790e		4c8b4148		MOVQ 0x48(CX), R8	
  0x1400c7912		4c69cb40320000		IMULQ $0x3240, BX, R9	
	diag.abs_pow = 0
  0x1400c7919		4f8d1408		LEAQ 0(R8)(R9*1), R10	
  0x1400c791d		4d8d9280250000		LEAQ 0x2580(R10), R10	
  0x1400c7924		450f113a		MOVUPS X15, 0(R10)	
	for idx := 0; idx < N_IFED; idx++ {
  0x1400c7928		4531d2			XORL R10, R10		
  0x1400c792b		eb29			JMP 0x1400c7956		
		diag.ifed_pow[idx] = 0
  0x1400c792d		4f8d1c01		LEAQ 0(R9)(R8*1), R11		
  0x1400c7931		4d8d9b90250000		LEAQ 0x2590(R11), R11		
  0x1400c7938		4bc704d300000000	MOVQ $0x0, 0(R11)(R10*8)	
		diag.ifed_gnd[idx] = 0
  0x1400c7940		4f8d1c01		LEAQ 0(R9)(R8*1), R11		
  0x1400c7944		4d8d9bd02b0000		LEAQ 0x2bd0(R11), R11		
  0x1400c794b		4bc704d300000000	MOVQ $0x0, 0(R11)(R10*8)	
	for idx := 0; idx < N_IFED; idx++ {
  0x1400c7953		49ffc2			INCQ R10		
  0x1400c7956		4981fac8000000		CMPQ R10, $0xc8		
  0x1400c795d		7cce			JL 0x1400c792d		
	dead := sim.WorkerDeadIons[workerID][:0]
  0x1400c795f		4c8b9180000000		MOVQ 0x80(CX), R10	
  0x1400c7966		4c39d3			CMPQ BX, R10		
  0x1400c7969		0f83f6140000		JAE 0x1400c8e65		
	if chunkSize <= 0 {
  0x1400c796f		48898c24f0000000	MOVQ CX, 0xf0(SP)	
  0x1400c7977		48899c2410010000	MOVQ BX, 0x110(SP)	
	diag := &sim.WorkerIDiag[workerID]
  0x1400c797f		4c898424e8000000	MOVQ R8, 0xe8(SP)	
  0x1400c7987		4c898c24b8000000	MOVQ R9, 0xb8(SP)	
  0x1400c798f		4889942498000000	MOVQ DX, 0x98(SP)	
	dead := sim.WorkerDeadIons[workerID][:0]
  0x1400c7997		4c8b5178		MOVQ 0x78(CX), R10		
  0x1400c799b		4c8d1c5b		LEAQ 0(BX)(BX*2), R11		
  0x1400c799f		4c899c24b0000000	MOVQ R11, 0xb0(SP)		
  0x1400c79a7		4f8b24da		MOVQ 0(R10)(R11*8), R12		
  0x1400c79ab		4f8b54da10		MOVQ 0x10(R10)(R11*8), R10	
	if sim.Measurement_mode {
  0x1400c79b0		80b9e02dba0700		CMPB 0x7ba2de0(CX), $0x0	
  0x1400c79b7		0f848f000000		JE 0x1400c7a4c			
	start := workerID * chunkSize
  0x1400c79bd		4889842480000000	MOVQ AX, 0x80(SP)	
		diag.counter_i = [N_G]float64{}
  0x1400c79c5		4b8d3c01		LEAQ 0(R9)(R8*1), DI	
  0x1400c79c9		4889bc24e0000000	MOVQ DI, 0xe0(SP)	
		diag.ui = [N_G]float64{}
  0x1400c79d1		4f8d2c01		LEAQ 0(R9)(R8*1), R13	
  0x1400c79d5		4d8dad800c0000		LEAQ 0xc80(R13), R13	
		diag.meanei = [N_G]float64{}
  0x1400c79dc		4f8d3c01		LEAQ 0(R9)(R8*1), R15	
  0x1400c79e0		4d8dbf00190000		LEAQ 0x1900(R15), R15	
	if chunkSize <= 0 {
  0x1400c79e7		4889ce			MOVQ CX, SI		
		diag.counter_i = [N_G]float64{}
  0x1400c79ea		b990010000		MOVL $0x190, CX		
  0x1400c79ef		31c0			XORL AX, AX		
  0x1400c79f1		f348ab			REP; STOSQ AX, ES:0(DI)	
		diag.ui = [N_G]float64{}
  0x1400c79f4		4c89ef			MOVQ R13, DI		
  0x1400c79f7		b990010000		MOVL $0x190, CX		
  0x1400c79fc		f348ab			REP; STOSQ AX, ES:0(DI)	
		diag.meanei = [N_G]float64{}
  0x1400c79ff		4c89ff			MOVQ R15, DI		
  0x1400c7a02		b990010000		MOVL $0x190, CX		
  0x1400c7a07		f348ab			REP; STOSQ AX, ES:0(DI)	
	diag := &sim.WorkerIDiag[workerID]
  0x1400c7a0a		4c89c0			MOVQ R8, AX		
		if start < end {
  0x1400c7a0d		4c8b842480000000	MOVQ 0x80(SP), R8	
  0x1400c7a15		4c39c2			CMPQ DX, R8		
  0x1400c7a18		7e2b			JLE 0x1400c7a45		
		diag.ui = [N_G]float64{}
  0x1400c7a1a		4c89ac24d8000000	MOVQ R13, 0xd8(SP)	
		diag.meanei = [N_G]float64{}
  0x1400c7a22		4c89bc24d0000000	MOVQ R15, 0xd0(SP)	
	dead := sim.WorkerDeadIons[workerID][:0]
  0x1400c7a2a		4c89d9			MOVQ R11, CX		
			for k := start; k < end; k++ {
  0x1400c7a2d		4531db			XORL R11, R11		
	diag := &sim.WorkerIDiag[workerID]
  0x1400c7a30		4c89cf			MOVQ R9, DI		
			for k := start; k < end; k++ {
  0x1400c7a33		4c8b8c24e0000000	MOVQ 0xe0(SP), R9	
  0x1400c7a3b		0f1f440000		NOPL 0(AX)(AX*1)	
  0x1400c7a40		e9fb0f0000		JMP 0x1400c8a40		
  0x1400c7a45		31c0			XORL AX, AX		
		if start < end {
  0x1400c7a47		e9d90f0000		JMP 0x1400c8a25		
		if end > start {
  0x1400c7a4c		4839c2			CMPQ DX, AX		
  0x1400c7a4f		7e1c			JLE 0x1400c7a6d		
			_ = sim.X_i[end-1]
  0x1400c7a51		4c8d6aff		LEAQ -0x1(DX), R13	
  0x1400c7a55		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x1400c7a5e		6690			NOPW			
  0x1400c7a60		4981fd40420f00		CMPQ R13, $0xf4240	
  0x1400c7a67		0f83aa0f0000		JAE 0x1400c8a17		
		for ; k <= end-4; k += 4 {
  0x1400c7a6d		4c8d6afc		LEAQ -0x4(DX), R13	
  0x1400c7a71		4c89ac24a8000000	MOVQ R13, 0xa8(SP)	
  0x1400c7a79		4531ff			XORL R15, R15		
  0x1400c7a7c		eb17			JMP 0x1400c7a95		
  0x1400c7a7e		4883c004		ADDQ $0x4, AX		
	sim.WorkerDeadIons[workerID] = dead
  0x1400c7a82		4c8b9c24b0000000	MOVQ 0xb0(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c7a8a		4989df			MOVQ BX, R15		
	sim.WorkerDeadIons[workerID] = dead
  0x1400c7a8d		488b9c2410010000	MOVQ 0x110(SP), BX	
		for ; k <= end-4; k += 4 {
  0x1400c7a95		4c39e8			CMPQ AX, R13		
  0x1400c7a98		0f8fa20b0000		JG 0x1400c8640		
  0x1400c7a9e		6690			NOPW			
			c0_0 := sim.X_i[k] * INV_DX
  0x1400c7aa0		483d40420f00		CMPQ AX, $0xf4240			
  0x1400c7aa6		0f83610f0000		JAE 0x1400c8a0d				
  0x1400c7aac		f20f1084c1d0c63e05	MOVSD_XMM 0x53ec6d0(CX)(AX*8), X0	
  0x1400c7ab5		f20f100d8bf80000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c7abd		f20f59c1		MULSD X1, X0				
			p0 := min(max(int(c0_0), 0), N_G-2)
  0x1400c7ac1		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c7ac6		4885f6			TESTQ SI, SI		
  0x1400c7ac9		7d02			JGE 0x1400c7acd		
  0x1400c7acb		31f6			XORL SI, SI		
  0x1400c7acd		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c7ad4		7e05			JLE 0x1400c7adb		
  0x1400c7ad6		be8e010000		MOVL $0x18e, SI		
			d0 := c0_0 - float64(p0)
  0x1400c7adb		0f57d2			XORPS X2, X2		
  0x1400c7ade		f2480f2ad6		CVTSI2SDQ SI, X2	
  0x1400c7ae3		f20f5cc2		SUBSD X2, X0		
			ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x1400c7ae7		f20f1094f1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X2	
  0x1400c7af0		f20f109cf1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X3	
  0x1400c7af9		f20f5cda		SUBSD X2, X3				
			c0_1 := sim.X_i[k+1] * INV_DX
  0x1400c7afd		488d7001		LEAQ 0x1(AX), SI	
			ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x1400c7b01		c4e2f9b9d3		VFMADD231SD X3, X0, X2	
			c0_1 := sim.X_i[k+1] * INV_DX
  0x1400c7b06		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c7b0d		0f83eb0e0000		JAE 0x1400c89fe				
  0x1400c7b13		f20f1084c1d8c63e05	MOVSD_XMM 0x53ec6d8(CX)(AX*8), X0	
  0x1400c7b1c		f20f59c1		MULSD X1, X0				
			p1 := min(max(int(c0_1), 0), N_G-2)
  0x1400c7b20		f2480f2cf8		CVTTSD2SIQ X0, DI	
  0x1400c7b25		4885ff			TESTQ DI, DI		
  0x1400c7b28		7d02			JGE 0x1400c7b2c		
  0x1400c7b2a		31ff			XORL DI, DI		
  0x1400c7b2c		4881ff8e010000		CMPQ DI, $0x18e		
  0x1400c7b33		7e05			JLE 0x1400c7b3a		
  0x1400c7b35		bf8e010000		MOVL $0x18e, DI		
			d1 := c0_1 - float64(p1)
  0x1400c7b3a		0f57db			XORPS X3, X3		
  0x1400c7b3d		f2480f2adf		CVTSI2SDQ DI, X3	
  0x1400c7b42		f20f5cc3		SUBSD X3, X0		
			ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x1400c7b46		f20f109cf9d00e2707	MOVSD_XMM 0x7270ed0(CX)(DI*8), X3	
  0x1400c7b4f		f20f10a4f9d80e2707	MOVSD_XMM 0x7270ed8(CX)(DI*8), X4	
  0x1400c7b58		f20f5ce3		SUBSD X3, X4				
			c0_2 := sim.X_i[k+2] * INV_DX
  0x1400c7b5c		488d7802		LEAQ 0x2(AX), DI	
			ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x1400c7b60		c4e2f9b9dc		VFMADD231SD X4, X0, X3	
			c0_2 := sim.X_i[k+2] * INV_DX
  0x1400c7b65		4881ff40420f00		CMPQ DI, $0xf4240			
  0x1400c7b6c		0f837d0e0000		JAE 0x1400c89ef				
  0x1400c7b72		f20f1084c1e0c63e05	MOVSD_XMM 0x53ec6e0(CX)(AX*8), X0	
  0x1400c7b7b		f20f59c1		MULSD X1, X0				
			p2 := min(max(int(c0_2), 0), N_G-2)
  0x1400c7b7f		f24c0f2cd8		CVTTSD2SIQ X0, R11	
  0x1400c7b84		4d85db			TESTQ R11, R11		
  0x1400c7b87		7d03			JGE 0x1400c7b8c		
  0x1400c7b89		4531db			XORL R11, R11		
  0x1400c7b8c		4981fb8e010000		CMPQ R11, $0x18e	
  0x1400c7b93		7e06			JLE 0x1400c7b9b		
  0x1400c7b95		41bb8e010000		MOVL $0x18e, R11	
			d2 := c0_2 - float64(p2)
  0x1400c7b9b		0f57e4			XORPS X4, X4		
  0x1400c7b9e		f2490f2ae3		CVTSI2SDQ R11, X4	
  0x1400c7ba3		f20f5cc4		SUBSD X4, X0		
			ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x1400c7ba7		f2420f10a4d9d00e2707	MOVSD_XMM 0x7270ed0(CX)(R11*8), X4	
  0x1400c7bb1		f2420f10acd9d80e2707	MOVSD_XMM 0x7270ed8(CX)(R11*8), X5	
  0x1400c7bbb		f20f5cec		SUBSD X4, X5				
			c0_3 := sim.X_i[k+3] * INV_DX
  0x1400c7bbf		4c8d5803		LEAQ 0x3(AX), R11	
			ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x1400c7bc3		c4e2f9b9e5		VFMADD231SD X5, X0, X4	
			c0_3 := sim.X_i[k+3] * INV_DX
  0x1400c7bc8		4981fb40420f00		CMPQ R11, $0xf4240			
  0x1400c7bcf		0f83100e0000		JAE 0x1400c89e5				
  0x1400c7bd5		f20f1084c1e8c63e05	MOVSD_XMM 0x53ec6e8(CX)(AX*8), X0	
  0x1400c7bde		f20f59c1		MULSD X1, X0				
			p3 := min(max(int(c0_3), 0), N_G-2)
  0x1400c7be2		f2480f2cd8		CVTTSD2SIQ X0, BX	
  0x1400c7be7		4885db			TESTQ BX, BX		
  0x1400c7bea		7d02			JGE 0x1400c7bee		
  0x1400c7bec		31db			XORL BX, BX		
  0x1400c7bee		4881fb8e010000		CMPQ BX, $0x18e		
  0x1400c7bf5		7e05			JLE 0x1400c7bfc		
  0x1400c7bf7		bb8e010000		MOVL $0x18e, BX		
		for ; k <= end-4; k += 4 {
  0x1400c7bfc		4889842488000000	MOVQ AX, 0x88(SP)	
			c0_1 := sim.X_i[k+1] * INV_DX
  0x1400c7c04		4889b424a0000000	MOVQ SI, 0xa0(SP)	
			c0_2 := sim.X_i[k+2] * INV_DX
  0x1400c7c0c		4889bc24c8000000	MOVQ DI, 0xc8(SP)	
			c0_3 := sim.X_i[k+3] * INV_DX
  0x1400c7c14		4c899c24c0000000	MOVQ R11, 0xc0(SP)	
			d3 := c0_3 - float64(p3)
  0x1400c7c1c		0f57ed			XORPS X5, X5		
  0x1400c7c1f		f2480f2aeb		CVTSI2SDQ BX, X5	
  0x1400c7c24		f20f5cc5		SUBSD X5, X0		
			ex3 := sim.Efield[p3] + d3*(sim.Efield[p3+1]-sim.Efield[p3])
  0x1400c7c28		f20f10acd9d00e2707	MOVSD_XMM 0x7270ed0(CX)(BX*8), X5	
  0x1400c7c31		f20f10b4d9d80e2707	MOVSD_XMM 0x7270ed8(CX)(BX*8), X6	
  0x1400c7c3a		f20f5cf5		SUBSD X5, X6				
  0x1400c7c3e		c4e2f9b9ee		VFMADD231SD X6, X0, X5			
			vx0 := sim.Vx_i[k] + ex0*FACTOR_I
  0x1400c7c43		f20f100595f50000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x1400c7c4b		f20f59d0		MULSD X0, X2				
  0x1400c7c4f		f20f5894c1d0d8b805	ADDSD 0x5b8d8d0(CX)(AX*8), X2		
  0x1400c7c58		f20f11542470		MOVSD_XMM X2, 0x70(SP)			
			vx1 := sim.Vx_i[k+1] + ex1*FACTOR_I
  0x1400c7c5e		f20f59d8		MULSD X0, X3			
  0x1400c7c62		f20f589cc1d8d8b805	ADDSD 0x5b8d8d8(CX)(AX*8), X3	
  0x1400c7c6b		f20f115c2468		MOVSD_XMM X3, 0x68(SP)		
			vx2 := sim.Vx_i[k+2] + ex2*FACTOR_I
  0x1400c7c71		f20f59e0		MULSD X0, X4			
  0x1400c7c75		f20f58a4c1e0d8b805	ADDSD 0x5b8d8e0(CX)(AX*8), X4	
  0x1400c7c7e		f20f11642460		MOVSD_XMM X4, 0x60(SP)		
			vx3 := sim.Vx_i[k+3] + ex3*FACTOR_I
  0x1400c7c84		f20f59e8		MULSD X0, X5			
  0x1400c7c88		f20f58acc1e8d8b805	ADDSD 0x5b8d8e8(CX)(AX*8), X5	
  0x1400c7c91		f20f116c2458		MOVSD_XMM X5, 0x58(SP)		
			sim.Vx_i[k] = vx0
  0x1400c7c97		f20f1194c1d0d8b805	MOVSD_XMM X2, 0x5b8d8d0(CX)(AX*8)	
			sim.Vx_i[k+1] = vx1
  0x1400c7ca0		f20f119cc1d8d8b805	MOVSD_XMM X3, 0x5b8d8d8(CX)(AX*8)	
			sim.Vx_i[k+2] = vx2
  0x1400c7ca9		f20f11a4c1e0d8b805	MOVSD_XMM X4, 0x5b8d8e0(CX)(AX*8)	
			sim.Vx_i[k+3] = vx3
  0x1400c7cb2		f20f11acc1e8d8b805	MOVSD_XMM X5, 0x5b8d8e8(CX)(AX*8)	
			x0 := sim.X_i[k] + vx0*DT_I
  0x1400c7cbb		f20f10b4c1d0c63e05	MOVSD_XMM 0x53ec6d0(CX)(AX*8), X6	
  0x1400c7cc4		f20f103dccf40000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X7	
  0x1400c7ccc		c4e2e9b9f7		VFMADD231SD X7, X2, X6			
			x1 := sim.X_i[k+1] + vx1*DT_I
  0x1400c7cd1		f2440f1084c1d8c63e05	MOVSD_XMM 0x53ec6d8(CX)(AX*8), X8	
  0x1400c7cdb		c462e1b9c7		VFMADD231SD X7, X3, X8			
  0x1400c7ce0		f2440f11442450		MOVSD_XMM X8, 0x50(SP)			
			x2 := sim.X_i[k+2] + vx2*DT_I
  0x1400c7ce7		f2440f108cc1e0c63e05	MOVSD_XMM 0x53ec6e0(CX)(AX*8), X9	
  0x1400c7cf1		c462d9b9cf		VFMADD231SD X7, X4, X9			
  0x1400c7cf6		f2440f114c2448		MOVSD_XMM X9, 0x48(SP)			
			x3 := sim.X_i[k+3] + vx3*DT_I
  0x1400c7cfd		f2440f1094c1e8c63e05	MOVSD_XMM 0x53ec6e8(CX)(AX*8), X10	
			sim.X_i[k] = x0
  0x1400c7d07		f20f11b4c1d0c63e05	MOVSD_XMM X6, 0x53ec6d0(CX)(AX*8)	
			sim.X_i[k+1] = x1
  0x1400c7d10		f2440f1184c1d8c63e05	MOVSD_XMM X8, 0x53ec6d8(CX)(AX*8)	
			sim.X_i[k+2] = x2
  0x1400c7d1a		f2440f118cc1e0c63e05	MOVSD_XMM X9, 0x53ec6e0(CX)(AX*8)	
			x3 := sim.X_i[k+3] + vx3*DT_I
  0x1400c7d24		c462d1b9d7		VFMADD231SD X7, X5, X10	
  0x1400c7d29		f2440f11542440		MOVSD_XMM X10, 0x40(SP)	
			sim.X_i[k+3] = x3
  0x1400c7d30		f2440f1194c1e8c63e05	MOVSD_XMM X10, 0x53ec6e8(CX)(AX*8)	
			if x0 < 0 {
  0x1400c7d3a		450f57db		XORPS X11, X11		
  0x1400c7d3e		66440f2ede		UCOMISD X6, X11		
  0x1400c7d43		0f862e010000		JBE 0x1400c7e77		
				dead = append(dead, k)
  0x1400c7d49		498d5f01		LEAQ 0x1(R15), BX		
  0x1400c7d4d		4939da			CMPQ R10, BX			
  0x1400c7d50		0f83ae000000		JAE 0x1400c7e04			
  0x1400c7d56		4c89e0			MOVQ R12, AX			
  0x1400c7d59		4c89d1			MOVQ R10, CX			
  0x1400c7d5c		bf01000000		MOVL $0x1, DI			
  0x1400c7d61		488d35105d0f00		LEAQ type:*+95168(SB), SI	
  0x1400c7d68		e8f318fbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c7d6d		488b942498000000	MOVQ 0x98(SP), DX	
				dead = append(dead, k+1)
  0x1400c7d75		488bb424a0000000	MOVQ 0xa0(SP), SI	
				dead = append(dead, k+2)
  0x1400c7d7d		488bbc24c8000000	MOVQ 0xc8(SP), DI	
				diag.abs_pow++
  0x1400c7d85		4c8b8424e8000000	MOVQ 0xe8(SP), R8	
  0x1400c7d8d		4c8b8c24b8000000	MOVQ 0xb8(SP), R9	
				dead = append(dead, k+3)
  0x1400c7d95		4c8b9c24c0000000	MOVQ 0xc0(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c7d9d		4c8bac24a8000000	MOVQ 0xa8(SP), R13			
  0x1400c7da5		f20f100533f40000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x1400c7dad		f20f100d93f50000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
				vSqr := vx0*vx0 + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c7db5		f20f10542470		MOVSD_XMM 0x70(SP), X2	
				vSqr := vx1*vx1 + sim.Vy_i[k+1]*sim.Vy_i[k+1] + sim.Vz_i[k+1]*sim.Vz_i[k+1]
  0x1400c7dbb		f20f105c2468		MOVSD_XMM 0x68(SP), X3	
				vSqr := vx2*vx2 + sim.Vy_i[k+2]*sim.Vy_i[k+2] + sim.Vz_i[k+2]*sim.Vz_i[k+2]
  0x1400c7dc1		f20f10642460		MOVSD_XMM 0x60(SP), X4	
				vSqr := vx3*vx3 + sim.Vy_i[k+3]*sim.Vy_i[k+3] + sim.Vz_i[k+3]*sim.Vz_i[k+3]
  0x1400c7dc7		f20f106c2458		MOVSD_XMM 0x58(SP), X5			
  0x1400c7dcd		f20f103dc3f30000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X7	
			if x1 < 0 {
  0x1400c7dd5		f2440f10442450		MOVSD_XMM 0x50(SP), X8	
			if x2 < 0 {
  0x1400c7ddc		f2440f104c2448		MOVSD_XMM 0x48(SP), X9	
			if x3 < 0 {
  0x1400c7de3		f2440f10542440		MOVSD_XMM 0x40(SP), X10	
  0x1400c7dea		450f57db		XORPS X11, X11		
				diag.abs_pow++
  0x1400c7dee		4989c4			MOVQ AX, R12		
  0x1400c7df1		4989ca			MOVQ CX, R10		
				dead = append(dead, k)
  0x1400c7df4		488b842488000000	MOVQ 0x88(SP), AX	
				vSqr := vx0*vx0 + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c7dfc		488b8c24f0000000	MOVQ 0xf0(SP), CX	
				dead = append(dead, k)
  0x1400c7e04		498944dcf8		MOVQ AX, -0x8(R12)(BX*8)	
				diag.abs_pow++
  0x1400c7e09		4bff840880250000	INCQ 0x2580(R8)(R9*1)	
				vSqr := vx0*vx0 + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c7e11		f20f59d2		MULSD X2, X2				
  0x1400c7e15		f20f10b4c1d0ea3206	MOVSD_XMM 0x632ead0(CX)(AX*8), X6	
  0x1400c7e1e		c4e2c9b9d6		VFMADD231SD X6, X6, X2			
  0x1400c7e23		f20f10b4c1d0fcac06	MOVSD_XMM 0x6acfcd0(CX)(AX*8), X6	
  0x1400c7e2c		c4e2c9b9d6		VFMADD231SD X6, X6, X2			
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
  0x1400c7e31		f20f10357ff30000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X6	
  0x1400c7e39		f20f59d6		MULSD X6, X2				
  0x1400c7e3d		f24c0f2cfa		CVTTSD2SIQ X2, R15			
				if eIdx < N_IFED {
  0x1400c7e42		4981ffc8000000		CMPQ R15, $0xc8		
  0x1400c7e49		0f8d71010000		JGE 0x1400c7fc0		
					diag.ifed_pow[eIdx]++
  0x1400c7e4f		4b8d1401		LEAQ 0(R9)(R8*1), DX	
  0x1400c7e53		488d9290250000		LEAQ 0x2590(DX), DX	
  0x1400c7e5a		660f1f440000		NOPW 0(AX)(AX*1)	
  0x1400c7e60		0f83730b0000		JAE 0x1400c89d9		
  0x1400c7e66		4aff04fa		INCQ 0(DX)(R15*8)	
		for ; k < end; k++ {
  0x1400c7e6a		488b942498000000	MOVQ 0x98(SP), DX	
					diag.ifed_pow[eIdx]++
  0x1400c7e72		e949010000		JMP 0x1400c7fc0		
			} else if x0 > L {
  0x1400c7e77		f2440f102568f20000	MOVSD_XMM runtime.egcbss+10(SB), X12	
  0x1400c7e80		66410f2ef4		UCOMISD X12, X6				
  0x1400c7e85		0f862a010000		JBE 0x1400c7fb5				
				dead = append(dead, k)
  0x1400c7e8b		498d5f01		LEAQ 0x1(R15), BX		
  0x1400c7e8f		4939da			CMPQ R10, BX			
  0x1400c7e92		0f83b7000000		JAE 0x1400c7f4f			
  0x1400c7e98		4c89e0			MOVQ R12, AX			
  0x1400c7e9b		4c89d1			MOVQ R10, CX			
  0x1400c7e9e		bf01000000		MOVL $0x1, DI			
  0x1400c7ea3		488d35ce5b0f00		LEAQ type:*+95168(SB), SI	
  0x1400c7eaa		e8b117fbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c7eaf		488b942498000000	MOVQ 0x98(SP), DX	
				dead = append(dead, k+1)
  0x1400c7eb7		488bb424a0000000	MOVQ 0xa0(SP), SI	
				dead = append(dead, k+2)
  0x1400c7ebf		488bbc24c8000000	MOVQ 0xc8(SP), DI	
				diag.abs_gnd++
  0x1400c7ec7		4c8b8424e8000000	MOVQ 0xe8(SP), R8	
  0x1400c7ecf		4c8b8c24b8000000	MOVQ 0xb8(SP), R9	
				dead = append(dead, k+3)
  0x1400c7ed7		4c8b9c24c0000000	MOVQ 0xc0(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c7edf		4c8bac24a8000000	MOVQ 0xa8(SP), R13			
  0x1400c7ee7		f20f1005f1f20000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x1400c7eef		f20f100d51f40000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
				vSqr := vx0*vx0 + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c7ef7		f20f10542470		MOVSD_XMM 0x70(SP), X2	
				vSqr := vx1*vx1 + sim.Vy_i[k+1]*sim.Vy_i[k+1] + sim.Vz_i[k+1]*sim.Vz_i[k+1]
  0x1400c7efd		f20f105c2468		MOVSD_XMM 0x68(SP), X3	
				vSqr := vx2*vx2 + sim.Vy_i[k+2]*sim.Vy_i[k+2] + sim.Vz_i[k+2]*sim.Vz_i[k+2]
  0x1400c7f03		f20f10642460		MOVSD_XMM 0x60(SP), X4	
				vSqr := vx3*vx3 + sim.Vy_i[k+3]*sim.Vy_i[k+3] + sim.Vz_i[k+3]*sim.Vz_i[k+3]
  0x1400c7f09		f20f106c2458		MOVSD_XMM 0x58(SP), X5			
  0x1400c7f0f		f20f103d81f20000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X7	
			if x1 < 0 {
  0x1400c7f17		f2440f10442450		MOVSD_XMM 0x50(SP), X8	
			if x2 < 0 {
  0x1400c7f1e		f2440f104c2448		MOVSD_XMM 0x48(SP), X9	
			if x3 < 0 {
  0x1400c7f25		f2440f10542440		MOVSD_XMM 0x40(SP), X10			
  0x1400c7f2c		450f57db		XORPS X11, X11				
  0x1400c7f30		f2440f1025aff10000	MOVSD_XMM runtime.egcbss+10(SB), X12	
				diag.abs_gnd++
  0x1400c7f39		4989c4			MOVQ AX, R12		
  0x1400c7f3c		4989ca			MOVQ CX, R10		
				dead = append(dead, k)
  0x1400c7f3f		488b842488000000	MOVQ 0x88(SP), AX	
				vSqr := vx0*vx0 + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c7f47		488b8c24f0000000	MOVQ 0xf0(SP), CX	
				dead = append(dead, k)
  0x1400c7f4f		498944dcf8		MOVQ AX, -0x8(R12)(BX*8)	
				diag.abs_gnd++
  0x1400c7f54		4bff840888250000	INCQ 0x2588(R8)(R9*1)	
				vSqr := vx0*vx0 + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c7f5c		f20f59d2		MULSD X2, X2				
  0x1400c7f60		f20f10b4c1d0ea3206	MOVSD_XMM 0x632ead0(CX)(AX*8), X6	
  0x1400c7f69		c4e2c9b9d6		VFMADD231SD X6, X6, X2			
  0x1400c7f6e		f20f10b4c1d0fcac06	MOVSD_XMM 0x6acfcd0(CX)(AX*8), X6	
  0x1400c7f77		c4e2c9b9d6		VFMADD231SD X6, X6, X2			
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
  0x1400c7f7c		f20f103534f20000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X6	
  0x1400c7f84		f20f59d6		MULSD X6, X2				
  0x1400c7f88		f24c0f2cfa		CVTTSD2SIQ X2, R15			
				if eIdx < N_IFED {
  0x1400c7f8d		4981ffc8000000		CMPQ R15, $0xc8		
  0x1400c7f94		7d2a			JGE 0x1400c7fc0		
					diag.ifed_gnd[eIdx]++
  0x1400c7f96		4b8d1401		LEAQ 0(R9)(R8*1), DX	
  0x1400c7f9a		488d92d02b0000		LEAQ 0x2bd0(DX), DX	
  0x1400c7fa1		0f83280a0000		JAE 0x1400c89cf		
  0x1400c7fa7		4aff04fa		INCQ 0(DX)(R15*8)	
		for ; k < end; k++ {
  0x1400c7fab		488b942498000000	MOVQ 0x98(SP), DX	
					diag.ifed_gnd[eIdx]++
  0x1400c7fb3		eb0b			JMP 0x1400c7fc0				
  0x1400c7fb5		f20f1035fbf10000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X6	
  0x1400c7fbd		4c89fb			MOVQ R15, BX				
			if x1 < 0 {
  0x1400c7fc0		66450f2ed8		UCOMISD X8, X11		
  0x1400c7fc5		0f861c010000		JBE 0x1400c80e7		
				dead = append(dead, k+1)
  0x1400c7fcb		48ffc3			INCQ BX				
  0x1400c7fce		4939da			CMPQ R10, BX			
  0x1400c7fd1		0f83a9000000		JAE 0x1400c8080			
  0x1400c7fd7		4c89e0			MOVQ R12, AX			
  0x1400c7fda		4c89d1			MOVQ R10, CX			
  0x1400c7fdd		bf01000000		MOVL $0x1, DI			
  0x1400c7fe2		488d358f5a0f00		LEAQ type:*+95168(SB), SI	
  0x1400c7fe9		e87216fbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c7fee		488b942498000000	MOVQ 0x98(SP), DX	
				dead = append(dead, k+1)
  0x1400c7ff6		488bb424a0000000	MOVQ 0xa0(SP), SI	
				dead = append(dead, k+2)
  0x1400c7ffe		488bbc24c8000000	MOVQ 0xc8(SP), DI	
				diag.abs_pow++
  0x1400c8006		4c8b8424e8000000	MOVQ 0xe8(SP), R8	
  0x1400c800e		4c8b8c24b8000000	MOVQ 0xb8(SP), R9	
				dead = append(dead, k+3)
  0x1400c8016		4c8b9c24c0000000	MOVQ 0xc0(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c801e		4c8bac24a8000000	MOVQ 0xa8(SP), R13			
  0x1400c8026		f20f1005b2f10000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x1400c802e		f20f100d12f30000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
				vSqr := vx1*vx1 + sim.Vy_i[k+1]*sim.Vy_i[k+1] + sim.Vz_i[k+1]*sim.Vz_i[k+1]
  0x1400c8036		f20f105c2468		MOVSD_XMM 0x68(SP), X3	
				vSqr := vx2*vx2 + sim.Vy_i[k+2]*sim.Vy_i[k+2] + sim.Vz_i[k+2]*sim.Vz_i[k+2]
  0x1400c803c		f20f10642460		MOVSD_XMM 0x60(SP), X4	
				vSqr := vx3*vx3 + sim.Vy_i[k+3]*sim.Vy_i[k+3] + sim.Vz_i[k+3]*sim.Vz_i[k+3]
  0x1400c8042		f20f106c2458		MOVSD_XMM 0x58(SP), X5			
  0x1400c8048		f20f103568f10000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X6	
  0x1400c8050		f20f103d40f10000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X7	
			if x2 < 0 {
  0x1400c8058		f2440f104c2448		MOVSD_XMM 0x48(SP), X9	
			if x3 < 0 {
  0x1400c805f		f2440f10542440		MOVSD_XMM 0x40(SP), X10	
  0x1400c8066		450f57db		XORPS X11, X11		
				diag.abs_pow++
  0x1400c806a		4989c4			MOVQ AX, R12		
  0x1400c806d		4989ca			MOVQ CX, R10		
				vSqr := vx1*vx1 + sim.Vy_i[k+1]*sim.Vy_i[k+1] + sim.Vz_i[k+1]*sim.Vz_i[k+1]
  0x1400c8070		488b842488000000	MOVQ 0x88(SP), AX	
  0x1400c8078		488b8c24f0000000	MOVQ 0xf0(SP), CX	
				dead = append(dead, k+1)
  0x1400c8080		498974dcf8		MOVQ SI, -0x8(R12)(BX*8)	
				diag.abs_pow++
  0x1400c8085		4bff840880250000	INCQ 0x2580(R8)(R9*1)	
				vSqr := vx1*vx1 + sim.Vy_i[k+1]*sim.Vy_i[k+1] + sim.Vz_i[k+1]*sim.Vz_i[k+1]
  0x1400c808d		f20f59db		MULSD X3, X3				
  0x1400c8091		f20f1094c1d8ea3206	MOVSD_XMM 0x632ead8(CX)(AX*8), X2	
  0x1400c809a		c4e2e9b9da		VFMADD231SD X2, X2, X3			
  0x1400c809f		f20f1094c1d8fcac06	MOVSD_XMM 0x6acfcd8(CX)(AX*8), X2	
  0x1400c80a8		c4e2e9b9da		VFMADD231SD X2, X2, X3			
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
  0x1400c80ad		f20f59de		MULSD X6, X3		
  0x1400c80b1		f24c0f2cfb		CVTTSD2SIQ X3, R15	
  0x1400c80b6		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x1400c80bf		90			NOPL			
				if eIdx < N_IFED {
  0x1400c80c0		4981ffc8000000		CMPQ R15, $0xc8		
  0x1400c80c7		0f8d51010000		JGE 0x1400c821e		
					diag.ifed_pow[eIdx]++
  0x1400c80cd		4b8d3401		LEAQ 0(R9)(R8*1), SI	
  0x1400c80d1		488db690250000		LEAQ 0x2590(SI), SI	
  0x1400c80d8		0f83e7080000		JAE 0x1400c89c5		
  0x1400c80de		4aff04fe		INCQ 0(SI)(R15*8)	
  0x1400c80e2		e937010000		JMP 0x1400c821e		
			} else if x1 > L {
  0x1400c80e7		f20f1015f9ef0000	MOVSD_XMM runtime.egcbss+10(SB), X2	
  0x1400c80ef		66440f2ec2		UCOMISD X2, X8				
  0x1400c80f4		0f8624010000		JBE 0x1400c821e				
				dead = append(dead, k+1)
  0x1400c80fa		48ffc3			INCQ BX				
  0x1400c80fd		0f1f00			NOPL 0(AX)			
  0x1400c8100		4939da			CMPQ R10, BX			
  0x1400c8103		0f83b6000000		JAE 0x1400c81bf			
  0x1400c8109		4c89e0			MOVQ R12, AX			
  0x1400c810c		4c89d1			MOVQ R10, CX			
  0x1400c810f		bf01000000		MOVL $0x1, DI			
  0x1400c8114		488d355d590f00		LEAQ type:*+95168(SB), SI	
  0x1400c811b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x1400c8120		e83b15fbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c8125		488b942498000000	MOVQ 0x98(SP), DX	
				dead = append(dead, k+1)
  0x1400c812d		488bb424a0000000	MOVQ 0xa0(SP), SI	
				dead = append(dead, k+2)
  0x1400c8135		488bbc24c8000000	MOVQ 0xc8(SP), DI	
				diag.abs_gnd++
  0x1400c813d		4c8b8424e8000000	MOVQ 0xe8(SP), R8	
  0x1400c8145		4c8b8c24b8000000	MOVQ 0xb8(SP), R9	
				dead = append(dead, k+3)
  0x1400c814d		4c8b9c24c0000000	MOVQ 0xc0(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c8155		4c8bac24a8000000	MOVQ 0xa8(SP), R13			
  0x1400c815d		f20f10057bf00000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x1400c8165		f20f100ddbf10000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c816d		f20f101573ef0000	MOVSD_XMM runtime.egcbss+10(SB), X2	
				vSqr := vx1*vx1 + sim.Vy_i[k+1]*sim.Vy_i[k+1] + sim.Vz_i[k+1]*sim.Vz_i[k+1]
  0x1400c8175		f20f105c2468		MOVSD_XMM 0x68(SP), X3	
				vSqr := vx2*vx2 + sim.Vy_i[k+2]*sim.Vy_i[k+2] + sim.Vz_i[k+2]*sim.Vz_i[k+2]
  0x1400c817b		f20f10642460		MOVSD_XMM 0x60(SP), X4	
				vSqr := vx3*vx3 + sim.Vy_i[k+3]*sim.Vy_i[k+3] + sim.Vz_i[k+3]*sim.Vz_i[k+3]
  0x1400c8181		f20f106c2458		MOVSD_XMM 0x58(SP), X5			
  0x1400c8187		f20f103529f00000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X6	
  0x1400c818f		f20f103d01f00000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X7	
			if x2 < 0 {
  0x1400c8197		f2440f104c2448		MOVSD_XMM 0x48(SP), X9	
			if x3 < 0 {
  0x1400c819e		f2440f10542440		MOVSD_XMM 0x40(SP), X10	
  0x1400c81a5		450f57db		XORPS X11, X11		
				diag.abs_gnd++
  0x1400c81a9		4989c4			MOVQ AX, R12		
  0x1400c81ac		4989ca			MOVQ CX, R10		
				vSqr := vx1*vx1 + sim.Vy_i[k+1]*sim.Vy_i[k+1] + sim.Vz_i[k+1]*sim.Vz_i[k+1]
  0x1400c81af		488b842488000000	MOVQ 0x88(SP), AX	
  0x1400c81b7		488b8c24f0000000	MOVQ 0xf0(SP), CX	
				dead = append(dead, k+1)
  0x1400c81bf		498974dcf8		MOVQ SI, -0x8(R12)(BX*8)	
				diag.abs_gnd++
  0x1400c81c4		4bff840888250000	INCQ 0x2588(R8)(R9*1)	
				vSqr := vx1*vx1 + sim.Vy_i[k+1]*sim.Vy_i[k+1] + sim.Vz_i[k+1]*sim.Vz_i[k+1]
  0x1400c81cc		f20f59db		MULSD X3, X3				
  0x1400c81d0		f2440f1084c1d8ea3206	MOVSD_XMM 0x632ead8(CX)(AX*8), X8	
  0x1400c81da		c4c2b9b9d8		VFMADD231SD X8, X8, X3			
  0x1400c81df		f2440f1084c1d8fcac06	MOVSD_XMM 0x6acfcd8(CX)(AX*8), X8	
  0x1400c81e9		c4c2b9b9d8		VFMADD231SD X8, X8, X3			
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
  0x1400c81ee		f20f59de		MULSD X6, X3		
  0x1400c81f2		f24c0f2cfb		CVTTSD2SIQ X3, R15	
  0x1400c81f7		660f1f840000000000	NOPW 0(AX)(AX*1)	
				if eIdx < N_IFED {
  0x1400c8200		4981ffc8000000		CMPQ R15, $0xc8		
  0x1400c8207		7d15			JGE 0x1400c821e		
					diag.ifed_gnd[eIdx]++
  0x1400c8209		4b8d3401		LEAQ 0(R9)(R8*1), SI	
  0x1400c820d		488db6d02b0000		LEAQ 0x2bd0(SI), SI	
  0x1400c8214		0f839f070000		JAE 0x1400c89b9		
  0x1400c821a		4aff04fe		INCQ 0(SI)(R15*8)	
			if x2 < 0 {
  0x1400c821e		66450f2ed9		UCOMISD X9, X11		
  0x1400c8223		0f86fe000000		JBE 0x1400c8327		
				dead = append(dead, k+2)
  0x1400c8229		48ffc3			INCQ BX				
  0x1400c822c		4939da			CMPQ R10, BX			
  0x1400c822f		0f8394000000		JAE 0x1400c82c9			
  0x1400c8235		4c89e0			MOVQ R12, AX			
  0x1400c8238		4c89d1			MOVQ R10, CX			
  0x1400c823b		bf01000000		MOVL $0x1, DI			
  0x1400c8240		488d3531580f00		LEAQ type:*+95168(SB), SI	
  0x1400c8247		e81414fbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c824c		488b942498000000	MOVQ 0x98(SP), DX	
				dead = append(dead, k+2)
  0x1400c8254		488bbc24c8000000	MOVQ 0xc8(SP), DI	
				diag.abs_pow++
  0x1400c825c		4c8b8424e8000000	MOVQ 0xe8(SP), R8	
  0x1400c8264		4c8b8c24b8000000	MOVQ 0xb8(SP), R9	
				dead = append(dead, k+3)
  0x1400c826c		4c8b9c24c0000000	MOVQ 0xc0(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c8274		4c8bac24a8000000	MOVQ 0xa8(SP), R13			
  0x1400c827c		f20f10055cef0000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x1400c8284		f20f100dbcf00000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
				vSqr := vx2*vx2 + sim.Vy_i[k+2]*sim.Vy_i[k+2] + sim.Vz_i[k+2]*sim.Vz_i[k+2]
  0x1400c828c		f20f10642460		MOVSD_XMM 0x60(SP), X4	
				vSqr := vx3*vx3 + sim.Vy_i[k+3]*sim.Vy_i[k+3] + sim.Vz_i[k+3]*sim.Vz_i[k+3]
  0x1400c8292		f20f106c2458		MOVSD_XMM 0x58(SP), X5			
  0x1400c8298		f20f103518ef0000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X6	
  0x1400c82a0		f20f103df0ee0000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X7	
			if x3 < 0 {
  0x1400c82a8		f2440f10542440		MOVSD_XMM 0x40(SP), X10	
  0x1400c82af		450f57db		XORPS X11, X11		
				diag.abs_pow++
  0x1400c82b3		4989c4			MOVQ AX, R12		
  0x1400c82b6		4989ca			MOVQ CX, R10		
				vSqr := vx2*vx2 + sim.Vy_i[k+2]*sim.Vy_i[k+2] + sim.Vz_i[k+2]*sim.Vz_i[k+2]
  0x1400c82b9		488b842488000000	MOVQ 0x88(SP), AX	
  0x1400c82c1		488b8c24f0000000	MOVQ 0xf0(SP), CX	
				dead = append(dead, k+2)
  0x1400c82c9		49897cdcf8		MOVQ DI, -0x8(R12)(BX*8)	
				diag.abs_pow++
  0x1400c82ce		4bff840880250000	INCQ 0x2580(R8)(R9*1)	
				vSqr := vx2*vx2 + sim.Vy_i[k+2]*sim.Vy_i[k+2] + sim.Vz_i[k+2]*sim.Vz_i[k+2]
  0x1400c82d6		f20f59e4		MULSD X4, X4				
  0x1400c82da		f20f1094c1e0ea3206	MOVSD_XMM 0x632eae0(CX)(AX*8), X2	
  0x1400c82e3		c4e2e9b9e2		VFMADD231SD X2, X2, X4			
  0x1400c82e8		f20f1094c1e0fcac06	MOVSD_XMM 0x6acfce0(CX)(AX*8), X2	
  0x1400c82f1		c4e2e9b9e2		VFMADD231SD X2, X2, X4			
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
  0x1400c82f6		f20f59e6		MULSD X6, X4		
  0x1400c82fa		f24c0f2cfc		CVTTSD2SIQ X4, R15	
  0x1400c82ff		90			NOPL			
				if eIdx < N_IFED {
  0x1400c8300		4981ffc8000000		CMPQ R15, $0xc8		
  0x1400c8307		0f8d31010000		JGE 0x1400c843e		
					diag.ifed_pow[eIdx]++
  0x1400c830d		4b8d3401		LEAQ 0(R9)(R8*1), SI	
  0x1400c8311		488db690250000		LEAQ 0x2590(SI), SI	
  0x1400c8318		0f8391060000		JAE 0x1400c89af		
  0x1400c831e		4aff04fe		INCQ 0(SI)(R15*8)	
  0x1400c8322		e917010000		JMP 0x1400c843e		
			} else if x2 > L {
  0x1400c8327		f20f1015b9ed0000	MOVSD_XMM runtime.egcbss+10(SB), X2	
  0x1400c832f		66440f2eca		UCOMISD X2, X9				
  0x1400c8334		0f8604010000		JBE 0x1400c843e				
				dead = append(dead, k+2)
  0x1400c833a		48ffc3			INCQ BX				
  0x1400c833d		0f1f00			NOPL 0(AX)			
  0x1400c8340		4939da			CMPQ R10, BX			
  0x1400c8343		0f83a1000000		JAE 0x1400c83ea			
  0x1400c8349		4c89e0			MOVQ R12, AX			
  0x1400c834c		4c89d1			MOVQ R10, CX			
  0x1400c834f		bf01000000		MOVL $0x1, DI			
  0x1400c8354		488d351d570f00		LEAQ type:*+95168(SB), SI	
  0x1400c835b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x1400c8360		e8fb12fbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c8365		488b942498000000	MOVQ 0x98(SP), DX	
				dead = append(dead, k+2)
  0x1400c836d		488bbc24c8000000	MOVQ 0xc8(SP), DI	
				diag.abs_gnd++
  0x1400c8375		4c8b8424e8000000	MOVQ 0xe8(SP), R8	
  0x1400c837d		4c8b8c24b8000000	MOVQ 0xb8(SP), R9	
				dead = append(dead, k+3)
  0x1400c8385		4c8b9c24c0000000	MOVQ 0xc0(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c838d		4c8bac24a8000000	MOVQ 0xa8(SP), R13			
  0x1400c8395		f20f100543ee0000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x1400c839d		f20f100da3ef0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c83a5		f20f10153bed0000	MOVSD_XMM runtime.egcbss+10(SB), X2	
				vSqr := vx2*vx2 + sim.Vy_i[k+2]*sim.Vy_i[k+2] + sim.Vz_i[k+2]*sim.Vz_i[k+2]
  0x1400c83ad		f20f10642460		MOVSD_XMM 0x60(SP), X4	
				vSqr := vx3*vx3 + sim.Vy_i[k+3]*sim.Vy_i[k+3] + sim.Vz_i[k+3]*sim.Vz_i[k+3]
  0x1400c83b3		f20f106c2458		MOVSD_XMM 0x58(SP), X5			
  0x1400c83b9		f20f1035f7ed0000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X6	
  0x1400c83c1		f20f103dcfed0000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X7	
			if x3 < 0 {
  0x1400c83c9		f2440f10542440		MOVSD_XMM 0x40(SP), X10	
  0x1400c83d0		450f57db		XORPS X11, X11		
				diag.abs_gnd++
  0x1400c83d4		4989c4			MOVQ AX, R12		
  0x1400c83d7		4989ca			MOVQ CX, R10		
				vSqr := vx2*vx2 + sim.Vy_i[k+2]*sim.Vy_i[k+2] + sim.Vz_i[k+2]*sim.Vz_i[k+2]
  0x1400c83da		488b842488000000	MOVQ 0x88(SP), AX	
  0x1400c83e2		488b8c24f0000000	MOVQ 0xf0(SP), CX	
				dead = append(dead, k+2)
  0x1400c83ea		49897cdcf8		MOVQ DI, -0x8(R12)(BX*8)	
				diag.abs_gnd++
  0x1400c83ef		4bff840888250000	INCQ 0x2588(R8)(R9*1)	
				vSqr := vx2*vx2 + sim.Vy_i[k+2]*sim.Vy_i[k+2] + sim.Vz_i[k+2]*sim.Vz_i[k+2]
  0x1400c83f7		f20f59e4		MULSD X4, X4				
  0x1400c83fb		f20f109cc1e0ea3206	MOVSD_XMM 0x632eae0(CX)(AX*8), X3	
  0x1400c8404		c4e2e1b9e3		VFMADD231SD X3, X3, X4			
  0x1400c8409		f20f109cc1e0fcac06	MOVSD_XMM 0x6acfce0(CX)(AX*8), X3	
  0x1400c8412		c4e2e1b9e3		VFMADD231SD X3, X3, X4			
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
  0x1400c8417		f20f59e6		MULSD X6, X4		
  0x1400c841b		f24c0f2cfc		CVTTSD2SIQ X4, R15	
				if eIdx < N_IFED {
  0x1400c8420		4981ffc8000000		CMPQ R15, $0xc8		
  0x1400c8427		7d15			JGE 0x1400c843e		
					diag.ifed_gnd[eIdx]++
  0x1400c8429		4b8d3401		LEAQ 0(R9)(R8*1), SI	
  0x1400c842d		488db6d02b0000		LEAQ 0x2bd0(SI), SI	
  0x1400c8434		0f836b050000		JAE 0x1400c89a5		
  0x1400c843a		4aff04fe		INCQ 0(SI)(R15*8)	
			if x3 < 0 {
  0x1400c843e		66450f2eda		UCOMISD X10, X11	
  0x1400c8443		0f86e6000000		JBE 0x1400c852f		
				dead = append(dead, k+3)
  0x1400c8449		48ffc3			INCQ BX				
  0x1400c844c		4939da			CMPQ R10, BX			
  0x1400c844f		737f			JAE 0x1400c84d0			
  0x1400c8451		4c89e0			MOVQ R12, AX			
  0x1400c8454		4c89d1			MOVQ R10, CX			
  0x1400c8457		bf01000000		MOVL $0x1, DI			
  0x1400c845c		488d3515560f00		LEAQ type:*+95168(SB), SI	
  0x1400c8463		e8f811fbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c8468		488b942498000000	MOVQ 0x98(SP), DX	
				diag.abs_pow++
  0x1400c8470		4c8b8424e8000000	MOVQ 0xe8(SP), R8	
  0x1400c8478		4c8b8c24b8000000	MOVQ 0xb8(SP), R9	
				dead = append(dead, k+3)
  0x1400c8480		4c8b9c24c0000000	MOVQ 0xc0(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c8488		4c8bac24a8000000	MOVQ 0xa8(SP), R13			
  0x1400c8490		f20f100548ed0000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x1400c8498		f20f100da8ee0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
				vSqr := vx3*vx3 + sim.Vy_i[k+3]*sim.Vy_i[k+3] + sim.Vz_i[k+3]*sim.Vz_i[k+3]
  0x1400c84a0		f20f106c2458		MOVSD_XMM 0x58(SP), X5			
  0x1400c84a6		f20f10350aed0000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X6	
  0x1400c84ae		f20f103de2ec0000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X7	
  0x1400c84b6		450f57db		XORPS X11, X11				
				diag.abs_pow++
  0x1400c84ba		4989c4			MOVQ AX, R12		
  0x1400c84bd		4989ca			MOVQ CX, R10		
				vSqr := vx3*vx3 + sim.Vy_i[k+3]*sim.Vy_i[k+3] + sim.Vz_i[k+3]*sim.Vz_i[k+3]
  0x1400c84c0		488b842488000000	MOVQ 0x88(SP), AX	
  0x1400c84c8		488b8c24f0000000	MOVQ 0xf0(SP), CX	
				dead = append(dead, k+3)
  0x1400c84d0		4d895cdcf8		MOVQ R11, -0x8(R12)(BX*8)	
				diag.abs_pow++
  0x1400c84d5		4bff840880250000	INCQ 0x2580(R8)(R9*1)	
				vSqr := vx3*vx3 + sim.Vy_i[k+3]*sim.Vy_i[k+3] + sim.Vz_i[k+3]*sim.Vz_i[k+3]
  0x1400c84dd		f20f59ed		MULSD X5, X5				
  0x1400c84e1		f20f1094c1e8ea3206	MOVSD_XMM 0x632eae8(CX)(AX*8), X2	
  0x1400c84ea		c4e2e9b9ea		VFMADD231SD X2, X2, X5			
  0x1400c84ef		f20f1094c1e8fcac06	MOVSD_XMM 0x6acfce8(CX)(AX*8), X2	
  0x1400c84f8		c4e2e9b9ea		VFMADD231SD X2, X2, X5			
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
  0x1400c84fd		f20f59ee		MULSD X6, X5		
  0x1400c8501		f24c0f2cdd		CVTTSD2SIQ X5, R11	
				if eIdx < N_IFED {
  0x1400c8506		4981fbc8000000		CMPQ R11, $0xc8		
  0x1400c850d		0f8d6bf5ffff		JGE 0x1400c7a7e		
					diag.ifed_pow[eIdx]++
  0x1400c8513		4f8d3c01		LEAQ 0(R9)(R8*1), R15	
  0x1400c8517		4d8dbf90250000		LEAQ 0x2590(R15), R15	
  0x1400c851e		6690			NOPW			
  0x1400c8520		0f8373040000		JAE 0x1400c8999		
  0x1400c8526		4bff04df		INCQ 0(R15)(R11*8)	
  0x1400c852a		e94ff5ffff		JMP 0x1400c7a7e		
			} else if x3 > L {
  0x1400c852f		f20f1015b1eb0000	MOVSD_XMM runtime.egcbss+10(SB), X2	
  0x1400c8537		66440f2ed2		UCOMISD X2, X10				
  0x1400c853c		0f1f4000		NOPL 0(AX)				
  0x1400c8540		0f8638f5ffff		JBE 0x1400c7a7e				
				dead = append(dead, k+3)
  0x1400c8546		48ffc3			INCQ BX				
  0x1400c8549		4939da			CMPQ R10, BX			
  0x1400c854c		0f8387000000		JAE 0x1400c85d9			
  0x1400c8552		4c89e0			MOVQ R12, AX			
  0x1400c8555		4c89d1			MOVQ R10, CX			
  0x1400c8558		bf01000000		MOVL $0x1, DI			
  0x1400c855d		488d3514550f00		LEAQ type:*+95168(SB), SI	
  0x1400c8564		e8f710fbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c8569		488b942498000000	MOVQ 0x98(SP), DX	
				diag.abs_gnd++
  0x1400c8571		4c8b8424e8000000	MOVQ 0xe8(SP), R8	
  0x1400c8579		4c8b8c24b8000000	MOVQ 0xb8(SP), R9	
				dead = append(dead, k+3)
  0x1400c8581		4c8b9c24c0000000	MOVQ 0xc0(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c8589		4c8bac24a8000000	MOVQ 0xa8(SP), R13			
  0x1400c8591		f20f100547ec0000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x1400c8599		f20f100da7ed0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c85a1		f20f10153feb0000	MOVSD_XMM runtime.egcbss+10(SB), X2	
				vSqr := vx3*vx3 + sim.Vy_i[k+3]*sim.Vy_i[k+3] + sim.Vz_i[k+3]*sim.Vz_i[k+3]
  0x1400c85a9		f20f106c2458		MOVSD_XMM 0x58(SP), X5			
  0x1400c85af		f20f103501ec0000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X6	
  0x1400c85b7		f20f103dd9eb0000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X7	
  0x1400c85bf		450f57db		XORPS X11, X11				
				diag.abs_gnd++
  0x1400c85c3		4989c4			MOVQ AX, R12		
  0x1400c85c6		4989ca			MOVQ CX, R10		
				vSqr := vx3*vx3 + sim.Vy_i[k+3]*sim.Vy_i[k+3] + sim.Vz_i[k+3]*sim.Vz_i[k+3]
  0x1400c85c9		488b842488000000	MOVQ 0x88(SP), AX	
  0x1400c85d1		488b8c24f0000000	MOVQ 0xf0(SP), CX	
				dead = append(dead, k+3)
  0x1400c85d9		4d895cdcf8		MOVQ R11, -0x8(R12)(BX*8)	
				diag.abs_gnd++
  0x1400c85de		4bff840888250000	INCQ 0x2588(R8)(R9*1)	
				vSqr := vx3*vx3 + sim.Vy_i[k+3]*sim.Vy_i[k+3] + sim.Vz_i[k+3]*sim.Vz_i[k+3]
  0x1400c85e6		f20f59ed		MULSD X5, X5				
  0x1400c85ea		f20f109cc1e8ea3206	MOVSD_XMM 0x632eae8(CX)(AX*8), X3	
  0x1400c85f3		c4e2e1b9eb		VFMADD231SD X3, X3, X5			
  0x1400c85f8		f20f109cc1e8fcac06	MOVSD_XMM 0x6acfce8(CX)(AX*8), X3	
  0x1400c8601		c4e2e1b9eb		VFMADD231SD X3, X3, X5			
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
  0x1400c8606		f20f59ee		MULSD X6, X5		
  0x1400c860a		f24c0f2cdd		CVTTSD2SIQ X5, R11	
				if eIdx < N_IFED {
  0x1400c860f		4981fbc8000000		CMPQ R11, $0xc8		
  0x1400c8616		0f8d62f4ffff		JGE 0x1400c7a7e		
					diag.ifed_gnd[eIdx]++
  0x1400c861c		4f8d3c01		LEAQ 0(R9)(R8*1), R15	
  0x1400c8620		4d8dbfd02b0000		LEAQ 0x2bd0(R15), R15	
  0x1400c8627		0f8362030000		JAE 0x1400c898f		
  0x1400c862d		4bff04df		INCQ 0(R15)(R11*8)	
  0x1400c8631		e948f4ffff		JMP 0x1400c7a7e		
		for ; k < end; k++ {
  0x1400c8636		48ffc0			INCQ AX			
  0x1400c8639		4d89ef			MOVQ R13, R15		
  0x1400c863c		0f1f4000		NOPL 0(AX)		
  0x1400c8640		4839d0			CMPQ AX, DX		
  0x1400c8643		0f8ddc020000		JGE 0x1400c8925		
			c0 := sim.X_i[k] * INV_DX
  0x1400c8649		483d40420f00		CMPQ AX, $0xf4240			
  0x1400c864f		0f8330030000		JAE 0x1400c8985				
  0x1400c8655		f20f1084c1d0c63e05	MOVSD_XMM 0x53ec6d0(CX)(AX*8), X0	
  0x1400c865e		f20f100de2ec0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c8666		f20f59c1		MULSD X1, X0				
			p := min(max(int(c0), 0), N_G-2)
  0x1400c866a		f24c0f2ce8		CVTTSD2SIQ X0, R13	
  0x1400c866f		4d85ed			TESTQ R13, R13		
  0x1400c8672		7d0c			JGE 0x1400c8680		
  0x1400c8674		4531ed			XORL R13, R13		
  0x1400c8677		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x1400c8680		4981fd8e010000		CMPQ R13, $0x18e	
  0x1400c8687		7e06			JLE 0x1400c868f		
  0x1400c8689		41bd8e010000		MOVL $0x18e, R13	
		for ; k < end; k++ {
  0x1400c868f		4889842488000000	MOVQ AX, 0x88(SP)	
			d := c0 - float64(p)
  0x1400c8697		0f57d2			XORPS X2, X2		
  0x1400c869a		f2490f2ad5		CVTSI2SDQ R13, X2	
  0x1400c869f		f20f5cc2		SUBSD X2, X0		
			ex := sim.Efield[p] + d*(sim.Efield[p+1]-sim.Efield[p])
  0x1400c86a3		f2420f1094e9d00e2707	MOVSD_XMM 0x7270ed0(CX)(R13*8), X2	
  0x1400c86ad		f2420f109ce9d80e2707	MOVSD_XMM 0x7270ed8(CX)(R13*8), X3	
  0x1400c86b7		f20f5cda		SUBSD X2, X3				
  0x1400c86bb		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
			vx := sim.Vx_i[k] + ex*FACTOR_I
  0x1400c86c0		f20f100518eb0000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x1400c86c8		f20f59d0		MULSD X0, X2				
  0x1400c86cc		f20f5894c1d0d8b805	ADDSD 0x5b8d8d0(CX)(AX*8), X2		
  0x1400c86d5		f20f11542478		MOVSD_XMM X2, 0x78(SP)			
			sim.Vx_i[k] = vx
  0x1400c86db		f20f1194c1d0d8b805	MOVSD_XMM X2, 0x5b8d8d0(CX)(AX*8)	
			x := sim.X_i[k] + vx*DT_I
  0x1400c86e4		f20f109cc1d0c63e05	MOVSD_XMM 0x53ec6d0(CX)(AX*8), X3	
  0x1400c86ed		f20f1025a3ea0000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X4	
  0x1400c86f5		c4e2e9b9dc		VFMADD231SD X4, X2, X3			
			sim.X_i[k] = x
  0x1400c86fa		f20f119cc1d0c63e05	MOVSD_XMM X3, 0x53ec6d0(CX)(AX*8)	
			if x < 0 {
  0x1400c8703		0f57ed			XORPS X5, X5		
  0x1400c8706		660f2eeb		UCOMISD X3, X5		
  0x1400c870a		0f86f7000000		JBE 0x1400c8807		
				dead = append(dead, k)
  0x1400c8710		4d8d6f01		LEAQ 0x1(R15), R13		
  0x1400c8714		4d39ea			CMPQ R10, R13			
  0x1400c8717		737c			JAE 0x1400c8795			
  0x1400c8719		4c89e0			MOVQ R12, AX			
  0x1400c871c		4c89eb			MOVQ R13, BX			
  0x1400c871f		4c89d1			MOVQ R10, CX			
  0x1400c8722		bf01000000		MOVL $0x1, DI			
  0x1400c8727		488d354a530f00		LEAQ type:*+95168(SB), SI	
  0x1400c872e		e82d0ffbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c8733		488b942498000000	MOVQ 0x98(SP), DX	
				diag.abs_pow++
  0x1400c873b		4c8b8424e8000000	MOVQ 0xe8(SP), R8	
  0x1400c8743		4c8b8c24b8000000	MOVQ 0xb8(SP), R9	
	sim.WorkerDeadIons[workerID] = dead
  0x1400c874b		4c8b9c24b0000000	MOVQ 0xb0(SP), R11			
  0x1400c8753		f20f100585ea0000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x1400c875b		f20f100de5eb0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
				vSqr := vx*vx + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c8763		f20f10542478		MOVSD_XMM 0x78(SP), X2			
  0x1400c8769		f20f102527ea0000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X4	
  0x1400c8771		0f57ed			XORPS X5, X5				
				diag.abs_pow++
  0x1400c8774		4989dd			MOVQ BX, R13		
  0x1400c8777		4989c4			MOVQ AX, R12		
  0x1400c877a		4989ca			MOVQ CX, R10		
				dead = append(dead, k)
  0x1400c877d		488b842488000000	MOVQ 0x88(SP), AX	
				vSqr := vx*vx + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c8785		488b8c24f0000000	MOVQ 0xf0(SP), CX	
	sim.WorkerDeadIons[workerID] = dead
  0x1400c878d		488b9c2410010000	MOVQ 0x110(SP), BX	
				dead = append(dead, k)
  0x1400c8795		4b8944ecf8		MOVQ AX, -0x8(R12)(R13*8)	
				diag.abs_pow++
  0x1400c879a		4bff840880250000	INCQ 0x2580(R8)(R9*1)	
				vSqr := vx*vx + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c87a2		f20f59d2		MULSD X2, X2				
  0x1400c87a6		f20f109cc1d0ea3206	MOVSD_XMM 0x632ead0(CX)(AX*8), X3	
  0x1400c87af		c4e2e1b9d3		VFMADD231SD X3, X3, X2			
  0x1400c87b4		f20f109cc1d0fcac06	MOVSD_XMM 0x6acfcd0(CX)(AX*8), X3	
  0x1400c87bd		c4e2e1b9d3		VFMADD231SD X3, X3, X2			
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
  0x1400c87c2		f20f101deee90000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X3	
  0x1400c87ca		f20f59d3		MULSD X3, X2				
  0x1400c87ce		f24c0f2cfa		CVTTSD2SIQ X2, R15			
  0x1400c87d3		660f1f840000000000	NOPW 0(AX)(AX*1)			
  0x1400c87dc		0f1f4000		NOPL 0(AX)				
				if eIdx < N_IFED {
  0x1400c87e0		4981ffc8000000		CMPQ R15, $0xc8		
  0x1400c87e7		0f8d49feffff		JGE 0x1400c8636		
					diag.ifed_pow[eIdx]++
  0x1400c87ed		4b8d3401		LEAQ 0(R9)(R8*1), SI	
  0x1400c87f1		488db690250000		LEAQ 0x2590(SI), SI	
  0x1400c87f8		0f837c010000		JAE 0x1400c897a		
  0x1400c87fe		4aff04fe		INCQ 0(SI)(R15*8)	
  0x1400c8802		e92ffeffff		JMP 0x1400c8636		
			} else if x > L {
  0x1400c8807		f20f1035d9e80000	MOVSD_XMM runtime.egcbss+10(SB), X6	
  0x1400c880f		660f2ede		UCOMISD X6, X3				
  0x1400c8813		0f86f7000000		JBE 0x1400c8910				
				dead = append(dead, k)
  0x1400c8819		4d8d6f01		LEAQ 0x1(R15), R13		
  0x1400c881d		0f1f00			NOPL 0(AX)			
  0x1400c8820		4d39ea			CMPQ R10, R13			
  0x1400c8823		0f8386000000		JAE 0x1400c88af			
  0x1400c8829		4c89e0			MOVQ R12, AX			
  0x1400c882c		4c89eb			MOVQ R13, BX			
  0x1400c882f		4c89d1			MOVQ R10, CX			
  0x1400c8832		bf01000000		MOVL $0x1, DI			
  0x1400c8837		488d353a520f00		LEAQ type:*+95168(SB), SI	
  0x1400c883e		6690			NOPW				
  0x1400c8840		e81b0efbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c8845		488b942498000000	MOVQ 0x98(SP), DX	
				diag.abs_gnd++
  0x1400c884d		4c8b8424e8000000	MOVQ 0xe8(SP), R8	
  0x1400c8855		4c8b8c24b8000000	MOVQ 0xb8(SP), R9	
	sim.WorkerDeadIons[workerID] = dead
  0x1400c885d		4c8b9c24b0000000	MOVQ 0xb0(SP), R11			
  0x1400c8865		f20f100573e90000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x1400c886d		f20f100dd3ea0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
				vSqr := vx*vx + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c8875		f20f10542478		MOVSD_XMM 0x78(SP), X2			
  0x1400c887b		f20f102515e90000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X4	
  0x1400c8883		0f57ed			XORPS X5, X5				
  0x1400c8886		f20f10355ae80000	MOVSD_XMM runtime.egcbss+10(SB), X6	
				diag.abs_gnd++
  0x1400c888e		4989dd			MOVQ BX, R13		
  0x1400c8891		4989c4			MOVQ AX, R12		
  0x1400c8894		4989ca			MOVQ CX, R10		
				dead = append(dead, k)
  0x1400c8897		488b842488000000	MOVQ 0x88(SP), AX	
				vSqr := vx*vx + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c889f		488b8c24f0000000	MOVQ 0xf0(SP), CX	
	sim.WorkerDeadIons[workerID] = dead
  0x1400c88a7		488b9c2410010000	MOVQ 0x110(SP), BX	
				dead = append(dead, k)
  0x1400c88af		4b8944ecf8		MOVQ AX, -0x8(R12)(R13*8)	
				diag.abs_gnd++
  0x1400c88b4		4bff840888250000	INCQ 0x2588(R8)(R9*1)	
				vSqr := vx*vx + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c88bc		f20f59d2		MULSD X2, X2				
  0x1400c88c0		f20f109cc1d0ea3206	MOVSD_XMM 0x632ead0(CX)(AX*8), X3	
  0x1400c88c9		c4e2e1b9d3		VFMADD231SD X3, X3, X2			
  0x1400c88ce		f20f109cc1d0fcac06	MOVSD_XMM 0x6acfcd0(CX)(AX*8), X3	
  0x1400c88d7		c4e2e1b9d3		VFMADD231SD X3, X3, X2			
				eIdx := int(vSqr * FACTOR_ENERGY_IFED)
  0x1400c88dc		f20f101dd4e80000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X3	
  0x1400c88e4		f20f59d3		MULSD X3, X2				
  0x1400c88e8		f24c0f2cfa		CVTTSD2SIQ X2, R15			
				if eIdx < N_IFED {
  0x1400c88ed		4981ffc8000000		CMPQ R15, $0xc8		
  0x1400c88f4		0f8d3cfdffff		JGE 0x1400c8636		
					diag.ifed_gnd[eIdx]++
  0x1400c88fa		4b8d3401		LEAQ 0(R9)(R8*1), SI			
  0x1400c88fe		488db6d02b0000		LEAQ 0x2bd0(SI), SI			
  0x1400c8905		7369			JAE 0x1400c8970				
  0x1400c8907		4aff04fe		INCQ 0(SI)(R15*8)			
  0x1400c890b		e926fdffff		JMP 0x1400c8636				
  0x1400c8910		f20f101da0e80000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X3	
  0x1400c8918		4d89fd			MOVQ R15, R13				
  0x1400c891b		0f1f440000		NOPL 0(AX)(AX*1)			
			} else if x > L {
  0x1400c8920		e911fdffff		JMP 0x1400c8636		
	sim.WorkerDeadIons[workerID] = dead
  0x1400c8925		488b8180000000		MOVQ 0x80(CX), AX			
  0x1400c892c		4839c3			CMPQ BX, AX				
  0x1400c892f		733a			JAE 0x1400c896b				
  0x1400c8931		488b4178		MOVQ 0x78(CX), AX			
  0x1400c8935		4e897cd808		MOVQ R15, 0x8(AX)(R11*8)		
  0x1400c893a		4e8954d810		MOVQ R10, 0x10(AX)(R11*8)		
  0x1400c893f		833d6ab7150000		CMPL runtime.writeBarrier(SB), $0x0	
  0x1400c8946		7416			JE 0x1400c895e				
  0x1400c8948		4a8b0cd8		MOVQ 0(AX)(R11*8), CX			
	dead := sim.WorkerDeadIons[workerID][:0]
  0x1400c894c		4c89da			MOVQ R11, DX		
	sim.WorkerDeadIons[workerID] = dead
  0x1400c894f		e88c57fbff		CALL runtime.gcWriteBarrier2(SB)	
  0x1400c8954		4d8923			MOVQ R12, 0(R11)			
  0x1400c8957		49894b08		MOVQ CX, 0x8(R11)			
  0x1400c895b		4989d3			MOVQ DX, R11				
  0x1400c895e		4e8924d8		MOVQ R12, 0(AX)(R11*8)			
}
  0x1400c8962		4881c4f8000000		ADDQ $0xf8, SP		
  0x1400c8969		5d			POPQ BP			
  0x1400c896a		c3			RET			
	sim.WorkerDeadIons[workerID] = dead
  0x1400c896b		e8105bfbff		CALL runtime.panicBounds(SB)	
					diag.ifed_gnd[eIdx]++
  0x1400c8970		b8c8000000		MOVL $0xc8, AX			
  0x1400c8975		e8065bfbff		CALL runtime.panicBounds(SB)	
					diag.ifed_pow[eIdx]++
  0x1400c897a		b8c8000000		MOVL $0xc8, AX			
  0x1400c897f		90			NOPL				
  0x1400c8980		e8fb5afbff		CALL runtime.panicBounds(SB)	
			c0 := sim.X_i[k] * INV_DX
  0x1400c8985		b940420f00		MOVL $0xf4240, CX		
  0x1400c898a		e8f15afbff		CALL runtime.panicBounds(SB)	
					diag.ifed_gnd[eIdx]++
  0x1400c898f		b8c8000000		MOVL $0xc8, AX			
  0x1400c8994		e8e75afbff		CALL runtime.panicBounds(SB)	
					diag.ifed_pow[eIdx]++
  0x1400c8999		b8c8000000		MOVL $0xc8, AX			
  0x1400c899e		6690			NOPW				
  0x1400c89a0		e8db5afbff		CALL runtime.panicBounds(SB)	
					diag.ifed_gnd[eIdx]++
  0x1400c89a5		b8c8000000		MOVL $0xc8, AX			
  0x1400c89aa		e8d15afbff		CALL runtime.panicBounds(SB)	
					diag.ifed_pow[eIdx]++
  0x1400c89af		b8c8000000		MOVL $0xc8, AX			
  0x1400c89b4		e8c75afbff		CALL runtime.panicBounds(SB)	
					diag.ifed_gnd[eIdx]++
  0x1400c89b9		b8c8000000		MOVL $0xc8, AX			
  0x1400c89be		6690			NOPW				
  0x1400c89c0		e8bb5afbff		CALL runtime.panicBounds(SB)	
					diag.ifed_pow[eIdx]++
  0x1400c89c5		b8c8000000		MOVL $0xc8, AX			
  0x1400c89ca		e8b15afbff		CALL runtime.panicBounds(SB)	
					diag.ifed_gnd[eIdx]++
  0x1400c89cf		b8c8000000		MOVL $0xc8, AX			
  0x1400c89d4		e8a75afbff		CALL runtime.panicBounds(SB)	
					diag.ifed_pow[eIdx]++
  0x1400c89d9		b8c8000000		MOVL $0xc8, AX			
  0x1400c89de		6690			NOPW				
  0x1400c89e0		e89b5afbff		CALL runtime.panicBounds(SB)	
			c0_3 := sim.X_i[k+3] * INV_DX
  0x1400c89e5		b840420f00		MOVL $0xf4240, AX		
  0x1400c89ea		e8915afbff		CALL runtime.panicBounds(SB)	
			c0_2 := sim.X_i[k+2] * INV_DX
  0x1400c89ef		b840420f00		MOVL $0xf4240, AX		
  0x1400c89f4		b940420f00		MOVL $0xf4240, CX		
  0x1400c89f9		e8825afbff		CALL runtime.panicBounds(SB)	
			c0_1 := sim.X_i[k+1] * INV_DX
  0x1400c89fe		b840420f00		MOVL $0xf4240, AX		
  0x1400c8a03		b940420f00		MOVL $0xf4240, CX		
  0x1400c8a08		e8735afbff		CALL runtime.panicBounds(SB)	
			c0_0 := sim.X_i[k] * INV_DX
  0x1400c8a0d		b940420f00		MOVL $0xf4240, CX		
  0x1400c8a12		e8695afbff		CALL runtime.panicBounds(SB)	
			_ = sim.X_i[end-1]
  0x1400c8a17		b840420f00		MOVL $0xf4240, AX		
  0x1400c8a1c		0f1f4000		NOPL 0(AX)			
  0x1400c8a20		e85b5afbff		CALL runtime.panicBounds(SB)	
	sim.WorkerDeadIons[workerID] = dead
  0x1400c8a25		4889f1			MOVQ SI, CX		
  0x1400c8a28		4989c7			MOVQ AX, R15		
  0x1400c8a2b		e9f5feffff		JMP 0x1400c8925		
			for k := start; k < end; k++ {
  0x1400c8a30		49ffc0			INCQ R8			
	sim.WorkerDeadIons[workerID] = dead
  0x1400c8a33		488b8c24b0000000	MOVQ 0xb0(SP), CX	
  0x1400c8a3b		0f1f440000		NOPL 0(AX)(AX*1)	
			for k := start; k < end; k++ {
  0x1400c8a40		4939d0			CMPQ R8, DX		
  0x1400c8a43		0f8df3030000		JGE 0x1400c8e3c		
				c0 = sim.X_i[k] * INV_DX
  0x1400c8a49		4981f840420f00		CMPQ R8, $0xf4240			
  0x1400c8a50		0f8305040000		JAE 0x1400c8e5b				
  0x1400c8a56		f2420f1084c6d0c63e05	MOVSD_XMM 0x53ec6d0(SI)(R8*8), X0	
  0x1400c8a60		f20f100de0e80000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c8a68		f20f59c1		MULSD X1, X0				
				p = min(max(int(c0), 0), N_G-2)
  0x1400c8a6c		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x1400c8a71		4885c9			TESTQ CX, CX		
  0x1400c8a74		7d0a			JGE 0x1400c8a80		
  0x1400c8a76		31c9			XORL CX, CX		
  0x1400c8a78		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x1400c8a80		4881f98e010000		CMPQ CX, $0x18e		
  0x1400c8a87		7e05			JLE 0x1400c8a8e		
  0x1400c8a89		b98e010000		MOVL $0x18e, CX		
			for k := start; k < end; k++ {
  0x1400c8a8e		4c89842490000000	MOVQ R8, 0x90(SP)	
				c1 = float64(p) + 1.0 - c0
  0x1400c8a96		0f57d2			XORPS X2, X2				
  0x1400c8a99		f2480f2ad1		CVTSI2SDQ CX, X2			
  0x1400c8a9e		f20f101db2e70000	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x1400c8aa6		f20f58da		ADDSD X2, X3				
  0x1400c8aaa		f20f5cd8		SUBSD X0, X3				
				c2 = c0 - float64(p)
  0x1400c8aae		f20f5cc2		SUBSD X2, X0		
				e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]
  0x1400c8ab2		f20f1094ced00e2707	MOVSD_XMM 0x7270ed0(SI)(CX*8), X2	
  0x1400c8abb		f20f59d3		MULSD X3, X2				
  0x1400c8abf		f20f10a4ced80e2707	MOVSD_XMM 0x7270ed8(SI)(CX*8), X4	
  0x1400c8ac8		c4e2d9b9d0		VFMADD231SD X0, X4, X2			
				mean_v = sim.Vx_i[k] + 0.5*e_x*FACTOR_I
  0x1400c8acd		f20f10256be70000	MOVSD_XMM $f64.3fe0000000000000(SB), X4	
  0x1400c8ad5		f20f59e2		MULSD X2, X4				
  0x1400c8ad9		f20f102dffe60000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X5	
  0x1400c8ae1		f20f59e5		MULSD X5, X4				
  0x1400c8ae5		f2420f58a4c6d0d8b805	ADDSD 0x5b8d8d0(SI)(R8*8), X4		
				diag.counter_i[p] += c1
  0x1400c8aef		f2410f1034c9		MOVSD_XMM 0(R9)(CX*8), X6	
  0x1400c8af5		f20f58f3		ADDSD X3, X6			
  0x1400c8af9		f2410f1134c9		MOVSD_XMM X6, 0(R9)(CX*8)	
				diag.counter_i[p+1] += c2
  0x1400c8aff		f2410f1074c908		MOVSD_XMM 0x8(R9)(CX*8), X6	
  0x1400c8b06		f20f58f0		ADDSD X0, X6			
  0x1400c8b0a		f2410f1174c908		MOVSD_XMM X6, 0x8(R9)(CX*8)	
				diag.ui[p] += c1 * mean_v
  0x1400c8b11		f2410f1074cd00		MOVSD_XMM 0(R13)(CX*8), X6	
  0x1400c8b18		c4e2e1b9f4		VFMADD231SD X4, X3, X6		
  0x1400c8b1d		f2410f1174cd00		MOVSD_XMM X6, 0(R13)(CX*8)	
				diag.ui[p+1] += c2 * mean_v
  0x1400c8b24		f2410f1074cd08		MOVSD_XMM 0x8(R13)(CX*8), X6	
  0x1400c8b2b		c4e2d9b9f0		VFMADD231SD X0, X4, X6		
  0x1400c8b30		f2410f1174cd08		MOVSD_XMM X6, 0x8(R13)(CX*8)	
				v_sqr = mean_v*mean_v + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c8b37		f20f59e4		MULSD X4, X4				
  0x1400c8b3b		f2420f10b4c6d0ea3206	MOVSD_XMM 0x632ead0(SI)(R8*8), X6	
  0x1400c8b45		c4e2c9b9e6		VFMADD231SD X6, X6, X4			
  0x1400c8b4a		f2420f10b4c6d0fcac06	MOVSD_XMM 0x6acfcd0(SI)(R8*8), X6	
  0x1400c8b54		c4e2c9b9e6		VFMADD231SD X6, X6, X4			
				energy = 0.5 * AR_MASS * v_sqr * INV_EV_TO_J
  0x1400c8b59		f20f1035dfe50000	MOVSD_XMM $f64.3aa4879de14d0b24(SB), X6	
  0x1400c8b61		f20f59e6		MULSD X6, X4				
  0x1400c8b65		f20f103d13e80000	MOVSD_XMM $f64.43d5a792def818e8(SB), X7	
  0x1400c8b6d		f20f59e7		MULSD X7, X4				
				diag.meanei[p] += c1 * energy
  0x1400c8b71		f2450f1004cf		MOVSD_XMM 0(R15)(CX*8), X8	
  0x1400c8b77		c462e1b9c4		VFMADD231SD X4, X3, X8		
  0x1400c8b7c		f2450f1104cf		MOVSD_XMM X8, 0(R15)(CX*8)	
				diag.meanei[p+1] += c2 * energy
  0x1400c8b82		f2410f105ccf08		MOVSD_XMM 0x8(R15)(CX*8), X3	
  0x1400c8b89		c4e2d9b9d8		VFMADD231SD X0, X4, X3		
  0x1400c8b8e		f2410f115ccf08		MOVSD_XMM X3, 0x8(R15)(CX*8)	
				sim.Vx_i[k] += e_x * FACTOR_I
  0x1400c8b95		f2420f1084c6d0d8b805	MOVSD_XMM 0x5b8d8d0(SI)(R8*8), X0	
  0x1400c8b9f		c4e2d1b9c2		VFMADD231SD X2, X5, X0			
  0x1400c8ba4		f2420f1184c6d0d8b805	MOVSD_XMM X0, 0x5b8d8d0(SI)(R8*8)	
				newX := sim.X_i[k] + sim.Vx_i[k]*DT_I
  0x1400c8bae		f2420f1094c6d0c63e05	MOVSD_XMM 0x53ec6d0(SI)(R8*8), X2	
  0x1400c8bb8		f20f101dd8e50000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X3	
  0x1400c8bc0		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
				sim.X_i[k] = newX
  0x1400c8bc5		f2420f1194c6d0c63e05	MOVSD_XMM X2, 0x53ec6d0(SI)(R8*8)	
				if newX < 0 {
  0x1400c8bcf		0f57c0			XORPS X0, X0		
  0x1400c8bd2		660f2ec2		UCOMISD X2, X0		
  0x1400c8bd6		0f861e010000		JBE 0x1400c8cfa		
					dead = append(dead, k)
  0x1400c8bdc		49ffc3			INCQ R11			
  0x1400c8bdf		90			NOPL				
  0x1400c8be0		4d39da			CMPQ R10, R11			
  0x1400c8be3		0f8398000000		JAE 0x1400c8c81			
  0x1400c8be9		4c89e0			MOVQ R12, AX			
  0x1400c8bec		4c89db			MOVQ R11, BX			
  0x1400c8bef		4c89d1			MOVQ R10, CX			
  0x1400c8bf2		bf01000000		MOVL $0x1, DI			
  0x1400c8bf7		488d357a4e0f00		LEAQ type:*+95168(SB), SI	
  0x1400c8bfe		6690			NOPW				
  0x1400c8c00		e85b0afbff		CALL runtime.growslice(SB)	
			for k := start; k < end; k++ {
  0x1400c8c05		488b942498000000	MOVQ 0x98(SP), DX	
					vSqr := sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c8c0d		488bb424f0000000	MOVQ 0xf0(SP), SI	
					diag.abs_pow++
  0x1400c8c15		488bbc24b8000000	MOVQ 0xb8(SP), DI	
					dead = append(dead, k)
  0x1400c8c1d		4c8b842490000000	MOVQ 0x90(SP), R8	
				diag.counter_i[p] += c1
  0x1400c8c25		4c8b8c24e0000000	MOVQ 0xe0(SP), R9	
				diag.ui[p] += c1 * mean_v
  0x1400c8c2d		4c8bac24d8000000	MOVQ 0xd8(SP), R13	
				diag.meanei[p] += c1 * energy
  0x1400c8c35		4c8bbc24d0000000	MOVQ 0xd0(SP), R15			
  0x1400c8c3d		0f57c0			XORPS X0, X0				
  0x1400c8c40		f20f100d00e70000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c8c48		f20f101d48e50000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X3	
  0x1400c8c50		f20f102d88e50000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X5	
  0x1400c8c58		f20f1035e0e40000	MOVSD_XMM $f64.3aa4879de14d0b24(SB), X6	
  0x1400c8c60		f20f103d18e70000	MOVSD_XMM $f64.43d5a792def818e8(SB), X7	
					diag.abs_pow++
  0x1400c8c68		4989db			MOVQ BX, R11		
  0x1400c8c6b		4989c4			MOVQ AX, R12		
  0x1400c8c6e		4989ca			MOVQ CX, R10		
  0x1400c8c71		488b8424e8000000	MOVQ 0xe8(SP), AX	
	sim.WorkerDeadIons[workerID] = dead
  0x1400c8c79		488b9c2410010000	MOVQ 0x110(SP), BX	
					dead = append(dead, k)
  0x1400c8c81		4f8944dcf8		MOVQ R8, -0x8(R12)(R11*8)	
					diag.abs_pow++
  0x1400c8c86		48ff843880250000	INCQ 0x2580(AX)(DI*1)	
					vSqr := sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c8c8e		f2420f1094c6d0d8b805	MOVSD_XMM 0x5b8d8d0(SI)(R8*8), X2	
  0x1400c8c98		f20f59d2		MULSD X2, X2				
  0x1400c8c9c		f2420f10a4c6d0ea3206	MOVSD_XMM 0x632ead0(SI)(R8*8), X4	
  0x1400c8ca6		c4e2d9b9d4		VFMADD231SD X4, X4, X2			
  0x1400c8cab		f2420f10a4c6d0fcac06	MOVSD_XMM 0x6acfcd0(SI)(R8*8), X4	
  0x1400c8cb5		c4e2d9b9d4		VFMADD231SD X4, X4, X2			
					energy_index = int(vSqr * FACTOR_ENERGY_IFED)
  0x1400c8cba		f20f1025f6e40000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X4	
  0x1400c8cc2		f20f59d4		MULSD X4, X2				
  0x1400c8cc6		f2480f2cca		CVTTSD2SIQ X2, CX			
					if energy_index < N_IFED {
  0x1400c8ccb		4881f9c8000000		CMPQ CX, $0xc8		
  0x1400c8cd2		0f8d58fdffff		JGE 0x1400c8a30		
						diag.ifed_pow[energy_index]++
  0x1400c8cd8		488d1c07		LEAQ 0(DI)(AX*1), BX	
  0x1400c8cdc		488d9b90250000		LEAQ 0x2590(BX), BX	
  0x1400c8ce3		0f8368010000		JAE 0x1400c8e51		
  0x1400c8ce9		48ff04cb		INCQ 0(BX)(CX*8)	
	sim.WorkerDeadIons[workerID] = dead
  0x1400c8ced		488b9c2410010000	MOVQ 0x110(SP), BX	
						diag.ifed_pow[energy_index]++
  0x1400c8cf5		e936fdffff		JMP 0x1400c8a30		
				} else if newX > L {
  0x1400c8cfa		f20f1025e6e30000	MOVSD_XMM runtime.egcbss+10(SB), X4	
  0x1400c8d02		660f2ed4		UCOMISD X4, X2				
  0x1400c8d06		0f861a010000		JBE 0x1400c8e26				
					dead = append(dead, k)
  0x1400c8d0c		49ffc3			INCQ R11			
  0x1400c8d0f		4d39da			CMPQ R10, R11			
  0x1400c8d12		0f839e000000		JAE 0x1400c8db6			
  0x1400c8d18		4c89e0			MOVQ R12, AX			
  0x1400c8d1b		4c89db			MOVQ R11, BX			
  0x1400c8d1e		4c89d1			MOVQ R10, CX			
  0x1400c8d21		bf01000000		MOVL $0x1, DI			
  0x1400c8d26		488d354b4d0f00		LEAQ type:*+95168(SB), SI	
  0x1400c8d2d		e82e09fbff		CALL runtime.growslice(SB)	
			for k := start; k < end; k++ {
  0x1400c8d32		488b942498000000	MOVQ 0x98(SP), DX	
					vSqr := sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c8d3a		488bb424f0000000	MOVQ 0xf0(SP), SI	
					diag.abs_gnd++
  0x1400c8d42		488bbc24b8000000	MOVQ 0xb8(SP), DI	
					dead = append(dead, k)
  0x1400c8d4a		4c8b842490000000	MOVQ 0x90(SP), R8	
				diag.counter_i[p] += c1
  0x1400c8d52		4c8b8c24e0000000	MOVQ 0xe0(SP), R9	
				diag.ui[p] += c1 * mean_v
  0x1400c8d5a		4c8bac24d8000000	MOVQ 0xd8(SP), R13	
				diag.meanei[p] += c1 * energy
  0x1400c8d62		4c8bbc24d0000000	MOVQ 0xd0(SP), R15			
  0x1400c8d6a		0f57c0			XORPS X0, X0				
  0x1400c8d6d		f20f100dd3e50000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c8d75		f20f101d1be40000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X3	
  0x1400c8d7d		f20f102563e30000	MOVSD_XMM runtime.egcbss+10(SB), X4	
  0x1400c8d85		f20f102d53e40000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X5	
  0x1400c8d8d		f20f1035abe30000	MOVSD_XMM $f64.3aa4879de14d0b24(SB), X6	
  0x1400c8d95		f20f103de3e50000	MOVSD_XMM $f64.43d5a792def818e8(SB), X7	
					diag.abs_gnd++
  0x1400c8d9d		4989db			MOVQ BX, R11		
  0x1400c8da0		4989c4			MOVQ AX, R12		
  0x1400c8da3		4989ca			MOVQ CX, R10		
  0x1400c8da6		488b8424e8000000	MOVQ 0xe8(SP), AX	
	sim.WorkerDeadIons[workerID] = dead
  0x1400c8dae		488b9c2410010000	MOVQ 0x110(SP), BX	
					dead = append(dead, k)
  0x1400c8db6		4f8944dcf8		MOVQ R8, -0x8(R12)(R11*8)	
					diag.abs_gnd++
  0x1400c8dbb		48ff843888250000	INCQ 0x2588(AX)(DI*1)	
					vSqr := sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c8dc3		f2420f1094c6d0d8b805	MOVSD_XMM 0x5b8d8d0(SI)(R8*8), X2	
  0x1400c8dcd		f20f59d2		MULSD X2, X2				
  0x1400c8dd1		f2460f1084c6d0ea3206	MOVSD_XMM 0x632ead0(SI)(R8*8), X8	
  0x1400c8ddb		c4c2b9b9d0		VFMADD231SD X8, X8, X2			
  0x1400c8de0		f2460f1084c6d0fcac06	MOVSD_XMM 0x6acfcd0(SI)(R8*8), X8	
  0x1400c8dea		c4c2b9b9d0		VFMADD231SD X8, X8, X2			
					energy_index = int(vSqr * FACTOR_ENERGY_IFED)
  0x1400c8def		f2440f1005c0e30000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X8	
  0x1400c8df8		f2410f59d0		MULSD X8, X2				
  0x1400c8dfd		f2480f2cca		CVTTSD2SIQ X2, CX			
					if energy_index < N_IFED {
  0x1400c8e02		4881f9c8000000		CMPQ CX, $0xc8		
  0x1400c8e09		7d24			JGE 0x1400c8e2f		
						diag.ifed_gnd[energy_index]++
  0x1400c8e0b		488d1c07		LEAQ 0(DI)(AX*1), BX	
  0x1400c8e0f		488d9bd02b0000		LEAQ 0x2bd0(BX), BX	
  0x1400c8e16		732f			JAE 0x1400c8e47		
  0x1400c8e18		48ff04cb		INCQ 0(BX)(CX*8)	
	sim.WorkerDeadIons[workerID] = dead
  0x1400c8e1c		488b9c2410010000	MOVQ 0x110(SP), BX	
						diag.ifed_gnd[energy_index]++
  0x1400c8e24		eb09			JMP 0x1400c8e2f				
  0x1400c8e26		f2440f100589e30000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X8	
  0x1400c8e2f		f20f102581e30000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X4	
  0x1400c8e37		e9f4fbffff		JMP 0x1400c8a30				
  0x1400c8e3c		4c89d8			MOVQ R11, AX				
	sim.WorkerDeadIons[workerID] = dead
  0x1400c8e3f		4989cb			MOVQ CX, R11		
			for k := start; k < end; k++ {
  0x1400c8e42		e9defbffff		JMP 0x1400c8a25		
						diag.ifed_gnd[energy_index]++
  0x1400c8e47		b8c8000000		MOVL $0xc8, AX			
  0x1400c8e4c		e82f56fbff		CALL runtime.panicBounds(SB)	
						diag.ifed_pow[energy_index]++
  0x1400c8e51		b8c8000000		MOVL $0xc8, AX			
  0x1400c8e56		e82556fbff		CALL runtime.panicBounds(SB)	
				c0 = sim.X_i[k] * INV_DX
  0x1400c8e5b		b840420f00		MOVL $0xf4240, AX		
  0x1400c8e60		e81b56fbff		CALL runtime.panicBounds(SB)	
	dead := sim.WorkerDeadIons[workerID][:0]
  0x1400c8e65		e81656fbff		CALL runtime.panicBounds(SB)	
	diag := &sim.WorkerIDiag[workerID]
  0x1400c8e6a		e81156fbff		CALL runtime.panicBounds(SB)	
		chunkSize = (sim.N_i + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c8e6f		e82ca4f7ff		CALL runtime.panicdivide(SB)	
  0x1400c8e74		90			NOPL				
func (sim *SimulationState) workerMoveIons(workerID int) {
  0x1400c8e75		4889442408		MOVQ AX, 0x8(SP)				
  0x1400c8e7a		48895c2410		MOVQ BX, 0x10(SP)				
  0x1400c8e7f		90			NOPL						
  0x1400c8e80		e8bb37fbff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x1400c8e85		488b442408		MOVQ 0x8(SP), AX				
  0x1400c8e8a		488b5c2410		MOVQ 0x10(SP), BX				
  0x1400c8e8f		e9ece9ffff		JMP gopic.(*SimulationState).workerMoveIons(SB)	

  0x1400c8e94		cc			INT $0x3		
  0x1400c8e95		cc			INT $0x3		
  0x1400c8e96		cc			INT $0x3		
  0x1400c8e97		cc			INT $0x3		
  0x1400c8e98		cc			INT $0x3		
  0x1400c8e99		cc			INT $0x3		
  0x1400c8e9a		cc			INT $0x3		
  0x1400c8e9b		cc			INT $0x3		
  0x1400c8e9c		cc			INT $0x3		
  0x1400c8e9d		cc			INT $0x3		
  0x1400c8e9e		cc			INT $0x3		
  0x1400c8e9f		cc			INT $0x3		


