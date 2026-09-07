// =============================================================================
// SYMBOL: workerMoveElectrons
// =============================================================================

TEXT gopic.(*SimulationState).workerMoveElectrons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/worker.go
func (sim *SimulationState) workerMoveElectrons(workerID int) {
  0x1400c66e0		4c8d6424a8		LEAQ -0x58(SP), R12	
  0x1400c66e5		4d3b6610		CMPQ R12, 0x10(R14)	
  0x1400c66e9		0f8666110000		JBE 0x1400c7855		
  0x1400c66ef		55			PUSHQ BP		
  0x1400c66f0		4889e5			MOVQ SP, BP		
  0x1400c66f3		4881ecd0000000		SUBQ $0xd0, SP		
	chunkSize := sim.EChunkSize
  0x1400c66fa		8400			TESTB AL, 0(AX)		
  0x1400c66fc		488b90582eba07		MOVQ 0x7ba2e58(AX), DX	
	if chunkSize <= 0 {
  0x1400c6703		4885d2			TESTQ DX, DX		
  0x1400c6706		7f3b			JG 0x1400c6743		
		chunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c6708		488b90c07e5603		MOVQ 0x3567ec0(AX), DX	
  0x1400c670f		4c8b80482eba07		MOVQ 0x7ba2e48(AX), R8	
  0x1400c6716		4a8d1402		LEAQ 0(DX)(R8*1), DX	
  0x1400c671a		488d52ff		LEAQ -0x1(DX), DX	
  0x1400c671e		6690			NOPW			
  0x1400c6720		4d85c0			TESTQ R8, R8		
  0x1400c6723		0f8426110000		JE 0x1400c784f		
	if chunkSize <= 0 {
  0x1400c6729		4889c1			MOVQ AX, CX		
		chunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c672c		4889d0			MOVQ DX, AX		
  0x1400c672f		4983f8ff		CMPQ R8, $-0x1		
  0x1400c6733		7507			JNE 0x1400c673c		
  0x1400c6735		48f7d8			NEGQ AX			
  0x1400c6738		31d2			XORL DX, DX		
  0x1400c673a		eb0d			JMP 0x1400c6749		
  0x1400c673c		4899			CQO			
  0x1400c673e		49f7f8			IDIVQ R8		
  0x1400c6741		eb06			JMP 0x1400c6749		
	if end > sim.N_e {
  0x1400c6743		4889c1			MOVQ AX, CX		
	start := workerID * chunkSize
  0x1400c6746		4889d0			MOVQ DX, AX		
  0x1400c6749		4889c2			MOVQ AX, DX		
  0x1400c674c		480fafc3		IMULQ BX, AX		
	end := start + chunkSize
  0x1400c6750		4801c2			ADDQ AX, DX		
	if end > sim.N_e {
  0x1400c6753		4c8b81c07e5603		MOVQ 0x3567ec0(CX), R8	
	diag := &sim.WorkerEDiag[workerID]
  0x1400c675a		4c8b4938		MOVQ 0x38(CX), R9	
	if end > sim.N_e {
  0x1400c675e		4939d0			CMPQ R8, DX		
	diag := &sim.WorkerEDiag[workerID]
  0x1400c6761		490f4cd0		CMOVL R8, DX		
  0x1400c6765		4c39cb			CMPQ BX, R9		
	if end > sim.N_e {
  0x1400c6768		0f83dc100000		JAE 0x1400c784a		
	diag := &sim.WorkerEDiag[workerID]
  0x1400c676e		4c8b4130		MOVQ 0x30(CX), R8	
  0x1400c6772		4c69cbc0700000		IMULQ $0x70c0, BX, R9	
	diag.abs_pow = 0
  0x1400c6779		4f8d1408		LEAQ 0(R8)(R9*1), R10	
  0x1400c677d		4d8d9290700000		LEAQ 0x7090(R10), R10	
  0x1400c6784		450f113a		MOVUPS X15, 0(R10)	
	dead := sim.WorkerDeadElectrons[workerID][:0]
  0x1400c6788		4c8b5168		MOVQ 0x68(CX), R10	
	diag := &sim.WorkerEDiag[workerID]
  0x1400c678c		4b8d3c08		LEAQ 0(R8)(R9*1), DI	
	dead := sim.WorkerDeadElectrons[workerID][:0]
  0x1400c6790		4c39d3			CMPQ BX, R10		
  0x1400c6793		0f83ac100000		JAE 0x1400c7845		
	if chunkSize <= 0 {
  0x1400c6799		48898c24c8000000	MOVQ CX, 0xc8(SP)	
  0x1400c67a1		48899c24e8000000	MOVQ BX, 0xe8(SP)	
	diag := &sim.WorkerEDiag[workerID]
  0x1400c67a9		4c898c24b8000000	MOVQ R9, 0xb8(SP)	
  0x1400c67b1		4c898424c0000000	MOVQ R8, 0xc0(SP)	
  0x1400c67b9		4889542468		MOVQ DX, 0x68(SP)	
	dead := sim.WorkerDeadElectrons[workerID][:0]
  0x1400c67be		4c8b5160		MOVQ 0x60(CX), R10		
  0x1400c67c2		4c8d1c5b		LEAQ 0(BX)(BX*2), R11		
  0x1400c67c6		4c899c24b0000000	MOVQ R11, 0xb0(SP)		
  0x1400c67ce		4f8b24da		MOVQ 0(R10)(R11*8), R12		
  0x1400c67d2		4f8b54da10		MOVQ 0x10(R10)(R11*8), R10	
	if sim.Measurement_mode {
  0x1400c67d7		80b9e02dba0700		CMPB 0x7ba2de0(CX), $0x0	
  0x1400c67de		6690			NOPW				
  0x1400c67e0		7424			JE 0x1400c6806			
	if chunkSize <= 0 {
  0x1400c67e2		4889ce			MOVQ CX, SI		
		*diag = electronWorkerDiagnostics{}
  0x1400c67e5		b9180e0000		MOVL $0xe18, CX		
	start := workerID * chunkSize
  0x1400c67ea		4989c5			MOVQ AX, R13		
		*diag = electronWorkerDiagnostics{}
  0x1400c67ed		31c0			XORL AX, AX		
  0x1400c67ef		f348ab			REP; STOSQ AX, ES:0(DI)	
		if start < end {
  0x1400c67f2		4c39ea			CMPQ DX, R13		
  0x1400c67f5		7e08			JLE 0x1400c67ff		
			for k := start; k < end; k++ {
  0x1400c67f7		4531ff			XORL R15, R15		
  0x1400c67fa		e9610b0000		JMP 0x1400c7360		
  0x1400c67ff		31c0			XORL AX, AX		
		if start < end {
  0x1400c6801		e9420b0000		JMP 0x1400c7348		
		if end > start {
  0x1400c6806		4839c2			CMPQ DX, AX		
  0x1400c6809		7e11			JLE 0x1400c681c		
			_ = sim.X_e[end-1]
  0x1400c680b		4c8d6aff		LEAQ -0x1(DX), R13	
  0x1400c680f		4981fd40420f00		CMPQ R13, $0xf4240	
  0x1400c6816		0f83220b0000		JAE 0x1400c733e		
		for ; k <= end-4; k += 4 {
  0x1400c681c		4c8d6afc		LEAQ -0x4(DX), R13	
  0x1400c6820		4c89ac24a8000000	MOVQ R13, 0xa8(SP)	
  0x1400c6828		4531ff			XORL R15, R15		
	dead := sim.WorkerDeadElectrons[workerID][:0]
  0x1400c682b		4c89de			MOVQ R11, SI		
		for ; k <= end-4; k += 4 {
  0x1400c682e		4531db			XORL R11, R11		
	diag := &sim.WorkerEDiag[workerID]
  0x1400c6831		4c89c7			MOVQ R8, DI		
		for ; k <= end-4; k += 4 {
  0x1400c6834		4531c0			XORL R8, R8		
  0x1400c6837		eb27			JMP 0x1400c6860		
  0x1400c6839		4883c004		ADDQ $0x4, AX		
	sim.WorkerDeadElectrons[workerID] = dead
  0x1400c683d		488bb424b0000000	MOVQ 0xb0(SP), SI	
		diag.abs_pow = absPow
  0x1400c6845		488bbc24c0000000	MOVQ 0xc0(SP), DI	
  0x1400c684d		4c8b8c24b8000000	MOVQ 0xb8(SP), R9	
		for ; k <= end-4; k += 4 {
  0x1400c6855		4989df			MOVQ BX, R15		
	sim.WorkerDeadElectrons[workerID] = dead
  0x1400c6858		488b9c24e8000000	MOVQ 0xe8(SP), BX	
		for ; k <= end-4; k += 4 {
  0x1400c6860		4c39e8			CMPQ AX, R13		
  0x1400c6863		0f8f2a080000		JG 0x1400c7093		
			c0_0 := sim.X_e[k] * INV_DX
  0x1400c6869		483d40420f00		CMPQ AX, $0xf4240			
  0x1400c686f		0f83bf0a0000		JAE 0x1400c7334				
  0x1400c6875		f20f1084c1d07e5603	MOVSD_XMM 0x3567ed0(CX)(AX*8), X0	
  0x1400c687e		f20f100dc20a0100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c6886		f20f59c1		MULSD X1, X0				
			p0 := min(max(int(c0_0), 0), N_G-2)
  0x1400c688a		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c688f		4885f6			TESTQ SI, SI		
  0x1400c6892		7d02			JGE 0x1400c6896		
  0x1400c6894		31f6			XORL SI, SI		
  0x1400c6896		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c689d		7e05			JLE 0x1400c68a4		
  0x1400c689f		be8e010000		MOVL $0x18e, SI		
			d0 := c0_0 - float64(p0)
  0x1400c68a4		0f57d2			XORPS X2, X2		
  0x1400c68a7		f2480f2ad6		CVTSI2SDQ SI, X2	
  0x1400c68ac		f20f5cc2		SUBSD X2, X0		
			ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x1400c68b0		f20f1094f1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X2	
  0x1400c68b9		f20f109cf1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X3	
  0x1400c68c2		f20f5cda		SUBSD X2, X3				
			c0_1 := sim.X_e[k+1] * INV_DX
  0x1400c68c6		488d7001		LEAQ 0x1(AX), SI	
			ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x1400c68ca		c4e2f9b9d3		VFMADD231SD X3, X0, X2	
			c0_1 := sim.X_e[k+1] * INV_DX
  0x1400c68cf		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c68d6		0f83490a0000		JAE 0x1400c7325				
  0x1400c68dc		f20f1084c1d87e5603	MOVSD_XMM 0x3567ed8(CX)(AX*8), X0	
  0x1400c68e5		f20f59c1		MULSD X1, X0				
			p1 := min(max(int(c0_1), 0), N_G-2)
  0x1400c68e9		f2480f2cd8		CVTTSD2SIQ X0, BX	
  0x1400c68ee		4885db			TESTQ BX, BX		
  0x1400c68f1		7d02			JGE 0x1400c68f5		
  0x1400c68f3		31db			XORL BX, BX		
  0x1400c68f5		4881fb8e010000		CMPQ BX, $0x18e		
  0x1400c68fc		7e05			JLE 0x1400c6903		
  0x1400c68fe		bb8e010000		MOVL $0x18e, BX		
			d1 := c0_1 - float64(p1)
  0x1400c6903		0f57db			XORPS X3, X3		
  0x1400c6906		f2480f2adb		CVTSI2SDQ BX, X3	
  0x1400c690b		f20f5cc3		SUBSD X3, X0		
			ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x1400c690f		f20f109cd9d00e2707	MOVSD_XMM 0x7270ed0(CX)(BX*8), X3	
  0x1400c6918		f20f10a4d9d80e2707	MOVSD_XMM 0x7270ed8(CX)(BX*8), X4	
  0x1400c6921		f20f5ce3		SUBSD X3, X4				
			c0_2 := sim.X_e[k+2] * INV_DX
  0x1400c6925		488d5802		LEAQ 0x2(AX), BX	
			ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x1400c6929		c4e2f9b9dc		VFMADD231SD X4, X0, X3	
			c0_2 := sim.X_e[k+2] * INV_DX
  0x1400c692e		4881fb40420f00		CMPQ BX, $0xf4240			
  0x1400c6935		0f83d8090000		JAE 0x1400c7313				
  0x1400c693b		f20f1084c1e07e5603	MOVSD_XMM 0x3567ee0(CX)(AX*8), X0	
  0x1400c6944		f20f59c1		MULSD X1, X0				
			p2 := min(max(int(c0_2), 0), N_G-2)
  0x1400c6948		f2480f2cf8		CVTTSD2SIQ X0, DI	
  0x1400c694d		4885ff			TESTQ DI, DI		
  0x1400c6950		7d02			JGE 0x1400c6954		
  0x1400c6952		31ff			XORL DI, DI		
  0x1400c6954		4881ff8e010000		CMPQ DI, $0x18e		
  0x1400c695b		7e05			JLE 0x1400c6962		
  0x1400c695d		bf8e010000		MOVL $0x18e, DI		
			d2 := c0_2 - float64(p2)
  0x1400c6962		0f57e4			XORPS X4, X4		
  0x1400c6965		f2480f2ae7		CVTSI2SDQ DI, X4	
  0x1400c696a		f20f5cc4		SUBSD X4, X0		
			ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x1400c696e		f20f10a4f9d00e2707	MOVSD_XMM 0x7270ed0(CX)(DI*8), X4	
  0x1400c6977		f20f10acf9d80e2707	MOVSD_XMM 0x7270ed8(CX)(DI*8), X5	
  0x1400c6980		f20f5cec		SUBSD X4, X5				
			c0_3 := sim.X_e[k+3] * INV_DX
  0x1400c6984		488d7803		LEAQ 0x3(AX), DI	
			ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x1400c6988		c4e2f9b9e5		VFMADD231SD X5, X0, X4	
			c0_3 := sim.X_e[k+3] * INV_DX
  0x1400c698d		4881ff40420f00		CMPQ DI, $0xf4240			
  0x1400c6994		0f836f090000		JAE 0x1400c7309				
  0x1400c699a		f20f1084c1e87e5603	MOVSD_XMM 0x3567ee8(CX)(AX*8), X0	
  0x1400c69a3		f20f59c1		MULSD X1, X0				
			p3 := min(max(int(c0_3), 0), N_G-2)
  0x1400c69a7		f24c0f2cc8		CVTTSD2SIQ X0, R9	
  0x1400c69ac		4d85c9			TESTQ R9, R9		
  0x1400c69af		7d03			JGE 0x1400c69b4		
  0x1400c69b1		4531c9			XORL R9, R9		
  0x1400c69b4		4981f98e010000		CMPQ R9, $0x18e		
  0x1400c69bb		7e06			JLE 0x1400c69c3		
  0x1400c69bd		41b98e010000		MOVL $0x18e, R9		
		for ; k <= end-4; k += 4 {
  0x1400c69c3		4889442458		MOVQ AX, 0x58(SP)	
			c0_1 := sim.X_e[k+1] * INV_DX
  0x1400c69c8		4889b424a0000000	MOVQ SI, 0xa0(SP)	
			c0_2 := sim.X_e[k+2] * INV_DX
  0x1400c69d0		48899c2498000000	MOVQ BX, 0x98(SP)	
			c0_3 := sim.X_e[k+3] * INV_DX
  0x1400c69d8		4889bc2490000000	MOVQ DI, 0x90(SP)	
		for ; k <= end-4; k += 4 {
  0x1400c69e0		4c89442478		MOVQ R8, 0x78(SP)	
  0x1400c69e5		4c895c2470		MOVQ R11, 0x70(SP)	
			d3 := c0_3 - float64(p3)
  0x1400c69ea		0f57ed			XORPS X5, X5		
  0x1400c69ed		f2490f2ae9		CVTSI2SDQ R9, X5	
  0x1400c69f2		f20f5cc5		SUBSD X5, X0		
			ex3 := sim.Efield[p3] + d3*(sim.Efield[p3+1]-sim.Efield[p3])
  0x1400c69f6		f2420f10acc9d00e2707	MOVSD_XMM 0x7270ed0(CX)(R9*8), X5	
  0x1400c6a00		f2420f10b4c9d80e2707	MOVSD_XMM 0x7270ed8(CX)(R9*8), X6	
  0x1400c6a0a		f20f5cf5		SUBSD X5, X6				
  0x1400c6a0e		c4e2f9b9ee		VFMADD231SD X6, X0, X5			
			vx0 := sim.Vx_e[k] - ex0*FACTOR_E
  0x1400c6a13		f20f1084c1d090d003	MOVSD_XMM 0x3d090d0(CX)(AX*8), X0	
  0x1400c6a1c		f20f10357c080100	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x1400c6a24		f20f59d6		MULSD X6, X2				
  0x1400c6a28		f20f5cc2		SUBSD X2, X0				
			vx1 := sim.Vx_e[k+1] - ex1*FACTOR_E
  0x1400c6a2c		f20f1094c1d890d003	MOVSD_XMM 0x3d090d8(CX)(AX*8), X2	
  0x1400c6a35		f20f59de		MULSD X6, X3				
  0x1400c6a39		f20f5cd3		SUBSD X3, X2				
			vx2 := sim.Vx_e[k+2] - ex2*FACTOR_E
  0x1400c6a3d		f20f109cc1e090d003	MOVSD_XMM 0x3d090e0(CX)(AX*8), X3	
  0x1400c6a46		f20f59e6		MULSD X6, X4				
  0x1400c6a4a		f20f5cdc		SUBSD X4, X3				
			vx3 := sim.Vx_e[k+3] - ex3*FACTOR_E
  0x1400c6a4e		f20f10a4c1e890d003	MOVSD_XMM 0x3d090e8(CX)(AX*8), X4	
			sim.Vx_e[k] = vx0
  0x1400c6a57		f20f1184c1d090d003	MOVSD_XMM X0, 0x3d090d0(CX)(AX*8)	
			sim.Vx_e[k+1] = vx1
  0x1400c6a60		f20f1194c1d890d003	MOVSD_XMM X2, 0x3d090d8(CX)(AX*8)	
			sim.Vx_e[k+2] = vx2
  0x1400c6a69		f20f119cc1e090d003	MOVSD_XMM X3, 0x3d090e0(CX)(AX*8)	
			vx3 := sim.Vx_e[k+3] - ex3*FACTOR_E
  0x1400c6a72		f20f59ee		MULSD X6, X5		
  0x1400c6a76		f20f5ce5		SUBSD X5, X4		
			sim.Vx_e[k+3] = vx3
  0x1400c6a7a		f20f11a4c1e890d003	MOVSD_XMM X4, 0x3d090e8(CX)(AX*8)	
			x0 := sim.X_e[k] + vx0*DT_E
  0x1400c6a83		f20f10acc1d07e5603	MOVSD_XMM 0x3567ed0(CX)(AX*8), X5	
  0x1400c6a8c		f20f103dfc060100	MOVSD_XMM $f64.3db4456f771df7e8(SB), X7	
  0x1400c6a94		c4e2f9b9ef		VFMADD231SD X7, X0, X5			
			x1 := sim.X_e[k+1] + vx1*DT_E
  0x1400c6a99		f20f1084c1d87e5603	MOVSD_XMM 0x3567ed8(CX)(AX*8), X0	
  0x1400c6aa2		c4e2e9b9c7		VFMADD231SD X7, X2, X0			
  0x1400c6aa7		f20f11442450		MOVSD_XMM X0, 0x50(SP)			
			x2 := sim.X_e[k+2] + vx2*DT_E
  0x1400c6aad		f20f1094c1e07e5603	MOVSD_XMM 0x3567ee0(CX)(AX*8), X2	
  0x1400c6ab6		c4e2e1b9d7		VFMADD231SD X7, X3, X2			
  0x1400c6abb		f20f11542448		MOVSD_XMM X2, 0x48(SP)			
			x3 := sim.X_e[k+3] + vx3*DT_E
  0x1400c6ac1		f20f109cc1e87e5603	MOVSD_XMM 0x3567ee8(CX)(AX*8), X3	
			sim.X_e[k] = x0
  0x1400c6aca		f20f11acc1d07e5603	MOVSD_XMM X5, 0x3567ed0(CX)(AX*8)	
			sim.X_e[k+1] = x1
  0x1400c6ad3		f20f1184c1d87e5603	MOVSD_XMM X0, 0x3567ed8(CX)(AX*8)	
			sim.X_e[k+2] = x2
  0x1400c6adc		f20f1194c1e07e5603	MOVSD_XMM X2, 0x3567ee0(CX)(AX*8)	
			x3 := sim.X_e[k+3] + vx3*DT_E
  0x1400c6ae5		c4e2d9b9df		VFMADD231SD X7, X4, X3	
  0x1400c6aea		f20f115c2440		MOVSD_XMM X3, 0x40(SP)	
			sim.X_e[k+3] = x3
  0x1400c6af0		f20f119cc1e87e5603	MOVSD_XMM X3, 0x3567ee8(CX)(AX*8)	
			if x0 < 0 {
  0x1400c6af9		0f57e4			XORPS X4, X4		
  0x1400c6afc		660f2ee5		UCOMISD X5, X4		
  0x1400c6b00		0f86a6000000		JBE 0x1400c6bac		
				dead = append(dead, k)
  0x1400c6b06		4d8d4f01		LEAQ 0x1(R15), R9		
  0x1400c6b0a		4d39ca			CMPQ R10, R9			
  0x1400c6b0d		0f838c000000		JAE 0x1400c6b9f			
  0x1400c6b13		4c89e0			MOVQ R12, AX			
  0x1400c6b16		4c89cb			MOVQ R9, BX			
  0x1400c6b19		4c89d1			MOVQ R10, CX			
  0x1400c6b1c		bf01000000		MOVL $0x1, DI			
  0x1400c6b21		488d35506f0f00		LEAQ type:*+95168(SB), SI	
  0x1400c6b28		e8332bfbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c6b2d		488b542468		MOVQ 0x68(SP), DX	
				dead = append(dead, k+1)
  0x1400c6b32		488bb424a0000000	MOVQ 0xa0(SP), SI	
				dead = append(dead, k+3)
  0x1400c6b3a		488bbc2490000000	MOVQ 0x90(SP), DI	
			if x1 < 0 {
  0x1400c6b42		4c8b442478		MOVQ 0x78(SP), R8	
				absPow++
  0x1400c6b47		4c8b5c2470		MOVQ 0x70(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c6b4c		4c8bac24a8000000	MOVQ 0xa8(SP), R13	
			if x1 < 0 {
  0x1400c6b54		f20f10442450		MOVSD_XMM 0x50(SP), X0			
  0x1400c6b5a		f20f100de6070100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
			if x2 < 0 {
  0x1400c6b62		f20f10542448		MOVSD_XMM 0x48(SP), X2	
			if x3 < 0 {
  0x1400c6b68		f20f105c2440		MOVSD_XMM 0x40(SP), X3			
  0x1400c6b6e		0f57e4			XORPS X4, X4				
  0x1400c6b71		f20f103527070100	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x1400c6b79		f20f103d0f060100	MOVSD_XMM $f64.3db4456f771df7e8(SB), X7	
				absPow++
  0x1400c6b81		4989d9			MOVQ BX, R9		
  0x1400c6b84		4989c4			MOVQ AX, R12		
  0x1400c6b87		4989ca			MOVQ CX, R10		
				dead = append(dead, k)
  0x1400c6b8a		488b442458		MOVQ 0x58(SP), AX	
			c0_0 := sim.X_e[k] * INV_DX
  0x1400c6b8f		488b8c24c8000000	MOVQ 0xc8(SP), CX	
				dead = append(dead, k+2)
  0x1400c6b97		488b9c2498000000	MOVQ 0x98(SP), BX	
				dead = append(dead, k)
  0x1400c6b9f		4b8944ccf8		MOVQ AX, -0x8(R12)(R9*8)	
				absPow++
  0x1400c6ba4		49ffc3			INCQ R11		
  0x1400c6ba7		e9c9000000		JMP 0x1400c6c75		
			} else if x0 > L {
  0x1400c6bac		f2440f100533050100	MOVSD_XMM runtime.egcbss+10(SB), X8	
  0x1400c6bb5		66410f2ee8		UCOMISD X8, X5				
  0x1400c6bba		660f1f440000		NOPW 0(AX)(AX*1)			
  0x1400c6bc0		0f86ac000000		JBE 0x1400c6c72				
				dead = append(dead, k)
  0x1400c6bc6		4d8d4f01		LEAQ 0x1(R15), R9		
  0x1400c6bca		4d39ca			CMPQ R10, R9			
  0x1400c6bcd		0f8395000000		JAE 0x1400c6c68			
  0x1400c6bd3		4c89e0			MOVQ R12, AX			
  0x1400c6bd6		4c89cb			MOVQ R9, BX			
  0x1400c6bd9		4c89d1			MOVQ R10, CX			
  0x1400c6bdc		bf01000000		MOVL $0x1, DI			
  0x1400c6be1		488d35906e0f00		LEAQ type:*+95168(SB), SI	
  0x1400c6be8		e8732afbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c6bed		488b542468		MOVQ 0x68(SP), DX	
				dead = append(dead, k+1)
  0x1400c6bf2		488bb424a0000000	MOVQ 0xa0(SP), SI	
				dead = append(dead, k+3)
  0x1400c6bfa		488bbc2490000000	MOVQ 0x90(SP), DI	
				absGnd++
  0x1400c6c02		4c8b442478		MOVQ 0x78(SP), R8	
			if x1 < 0 {
  0x1400c6c07		4c8b5c2470		MOVQ 0x70(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c6c0c		4c8bac24a8000000	MOVQ 0xa8(SP), R13	
			if x1 < 0 {
  0x1400c6c14		f20f10442450		MOVSD_XMM 0x50(SP), X0			
  0x1400c6c1a		f20f100d26070100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
			if x2 < 0 {
  0x1400c6c22		f20f10542448		MOVSD_XMM 0x48(SP), X2	
			if x3 < 0 {
  0x1400c6c28		f20f105c2440		MOVSD_XMM 0x40(SP), X3			
  0x1400c6c2e		0f57e4			XORPS X4, X4				
  0x1400c6c31		f20f103567060100	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x1400c6c39		f20f103d4f050100	MOVSD_XMM $f64.3db4456f771df7e8(SB), X7	
  0x1400c6c41		f2440f10059e040100	MOVSD_XMM runtime.egcbss+10(SB), X8	
				absGnd++
  0x1400c6c4a		4989d9			MOVQ BX, R9		
  0x1400c6c4d		4989c4			MOVQ AX, R12		
  0x1400c6c50		4989ca			MOVQ CX, R10		
				dead = append(dead, k)
  0x1400c6c53		488b442458		MOVQ 0x58(SP), AX	
			c0_0 := sim.X_e[k] * INV_DX
  0x1400c6c58		488b8c24c8000000	MOVQ 0xc8(SP), CX	
				dead = append(dead, k+2)
  0x1400c6c60		488b9c2498000000	MOVQ 0x98(SP), BX	
				dead = append(dead, k)
  0x1400c6c68		4b8944ccf8		MOVQ AX, -0x8(R12)(R9*8)	
				absGnd++
  0x1400c6c6d		49ffc0			INCQ R8			
  0x1400c6c70		eb03			JMP 0x1400c6c75		
  0x1400c6c72		4d89f9			MOVQ R15, R9		
			if x1 < 0 {
  0x1400c6c75		4c89842488000000	MOVQ R8, 0x88(SP)	
  0x1400c6c7d		4c899c2480000000	MOVQ R11, 0x80(SP)	
  0x1400c6c85		660f2ee0		UCOMISD X0, X4		
  0x1400c6c89		0f86a5000000		JBE 0x1400c6d34		
				dead = append(dead, k+1)
  0x1400c6c8f		49ffc1			INCQ R9				
  0x1400c6c92		4d39ca			CMPQ R10, R9			
  0x1400c6c95		0f838c000000		JAE 0x1400c6d27			
  0x1400c6c9b		4c89e0			MOVQ R12, AX			
  0x1400c6c9e		4c89cb			MOVQ R9, BX			
  0x1400c6ca1		4c89d1			MOVQ R10, CX			
  0x1400c6ca4		bf01000000		MOVL $0x1, DI			
  0x1400c6ca9		488d35c86d0f00		LEAQ type:*+95168(SB), SI	
  0x1400c6cb0		e8ab29fbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c6cb5		488b542468		MOVQ 0x68(SP), DX	
				dead = append(dead, k+1)
  0x1400c6cba		488bb424a0000000	MOVQ 0xa0(SP), SI	
				dead = append(dead, k+3)
  0x1400c6cc2		488bbc2490000000	MOVQ 0x90(SP), DI	
			if x2 < 0 {
  0x1400c6cca		4c8b842488000000	MOVQ 0x88(SP), R8	
				absPow++
  0x1400c6cd2		4c8b9c2480000000	MOVQ 0x80(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c6cda		4c8bac24a8000000	MOVQ 0xa8(SP), R13			
  0x1400c6ce2		f20f100d5e060100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
			if x2 < 0 {
  0x1400c6cea		f20f10542448		MOVSD_XMM 0x48(SP), X2	
			if x3 < 0 {
  0x1400c6cf0		f20f105c2440		MOVSD_XMM 0x40(SP), X3			
  0x1400c6cf6		0f57e4			XORPS X4, X4				
  0x1400c6cf9		f20f10359f050100	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x1400c6d01		f20f103d87040100	MOVSD_XMM $f64.3db4456f771df7e8(SB), X7	
				absPow++
  0x1400c6d09		4989d9			MOVQ BX, R9		
  0x1400c6d0c		4989c4			MOVQ AX, R12		
  0x1400c6d0f		4989ca			MOVQ CX, R10		
		for ; k <= end-4; k += 4 {
  0x1400c6d12		488b442458		MOVQ 0x58(SP), AX	
			c0_0 := sim.X_e[k] * INV_DX
  0x1400c6d17		488b8c24c8000000	MOVQ 0xc8(SP), CX	
				dead = append(dead, k+2)
  0x1400c6d1f		488b9c2498000000	MOVQ 0x98(SP), BX	
				dead = append(dead, k+1)
  0x1400c6d27		4b8974ccf8		MOVQ SI, -0x8(R12)(R9*8)	
				absPow++
  0x1400c6d2c		49ffc3			INCQ R11		
  0x1400c6d2f		e9ba000000		JMP 0x1400c6dee		
			} else if x1 > L {
  0x1400c6d34		f20f102dac030100	MOVSD_XMM runtime.egcbss+10(SB), X5	
  0x1400c6d3c		660f2ec5		UCOMISD X5, X0				
  0x1400c6d40		0f86a8000000		JBE 0x1400c6dee				
				dead = append(dead, k+1)
  0x1400c6d46		49ffc1			INCQ R9				
  0x1400c6d49		4d39ca			CMPQ R10, R9			
  0x1400c6d4c		0f8394000000		JAE 0x1400c6de6			
  0x1400c6d52		4c89e0			MOVQ R12, AX			
  0x1400c6d55		4c89cb			MOVQ R9, BX			
  0x1400c6d58		4c89d1			MOVQ R10, CX			
  0x1400c6d5b		bf01000000		MOVL $0x1, DI			
  0x1400c6d60		488d35116d0f00		LEAQ type:*+95168(SB), SI	
  0x1400c6d67		e8f428fbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c6d6c		488b542468		MOVQ 0x68(SP), DX	
				dead = append(dead, k+1)
  0x1400c6d71		488bb424a0000000	MOVQ 0xa0(SP), SI	
				dead = append(dead, k+3)
  0x1400c6d79		488bbc2490000000	MOVQ 0x90(SP), DI	
				absGnd++
  0x1400c6d81		4c8b842488000000	MOVQ 0x88(SP), R8	
			if x2 < 0 {
  0x1400c6d89		4c8b9c2480000000	MOVQ 0x80(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c6d91		4c8bac24a8000000	MOVQ 0xa8(SP), R13			
  0x1400c6d99		f20f100da7050100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
			if x2 < 0 {
  0x1400c6da1		f20f10542448		MOVSD_XMM 0x48(SP), X2	
			if x3 < 0 {
  0x1400c6da7		f20f105c2440		MOVSD_XMM 0x40(SP), X3			
  0x1400c6dad		0f57e4			XORPS X4, X4				
  0x1400c6db0		f20f102d30030100	MOVSD_XMM runtime.egcbss+10(SB), X5	
  0x1400c6db8		f20f1035e0040100	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x1400c6dc0		f20f103dc8030100	MOVSD_XMM $f64.3db4456f771df7e8(SB), X7	
				absGnd++
  0x1400c6dc8		4989d9			MOVQ BX, R9		
  0x1400c6dcb		4989c4			MOVQ AX, R12		
  0x1400c6dce		4989ca			MOVQ CX, R10		
		for ; k <= end-4; k += 4 {
  0x1400c6dd1		488b442458		MOVQ 0x58(SP), AX	
			c0_0 := sim.X_e[k] * INV_DX
  0x1400c6dd6		488b8c24c8000000	MOVQ 0xc8(SP), CX	
				dead = append(dead, k+2)
  0x1400c6dde		488b9c2498000000	MOVQ 0x98(SP), BX	
				dead = append(dead, k+1)
  0x1400c6de6		4b8974ccf8		MOVQ SI, -0x8(R12)(R9*8)	
				absGnd++
  0x1400c6deb		49ffc0			INCQ R8			
			if x2 < 0 {
  0x1400c6dee		4c89842488000000	MOVQ R8, 0x88(SP)	
  0x1400c6df6		4c899c2480000000	MOVQ R11, 0x80(SP)	
  0x1400c6dfe		660f2ee2		UCOMISD X2, X4		
  0x1400c6e02		0f8693000000		JBE 0x1400c6e9b		
				dead = append(dead, k+2)
  0x1400c6e08		49ffc1			INCQ R9				
  0x1400c6e0b		4d39ca			CMPQ R10, R9			
  0x1400c6e0e		737e			JAE 0x1400c6e8e			
  0x1400c6e10		4c89e0			MOVQ R12, AX			
  0x1400c6e13		4c89cb			MOVQ R9, BX			
  0x1400c6e16		4c89d1			MOVQ R10, CX			
  0x1400c6e19		bf01000000		MOVL $0x1, DI			
  0x1400c6e1e		488d35536c0f00		LEAQ type:*+95168(SB), SI	
  0x1400c6e25		e83628fbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c6e2a		488b542468		MOVQ 0x68(SP), DX	
				dead = append(dead, k+3)
  0x1400c6e2f		488bbc2490000000	MOVQ 0x90(SP), DI	
			if x3 < 0 {
  0x1400c6e37		4c8b842488000000	MOVQ 0x88(SP), R8	
				absPow++
  0x1400c6e3f		4c8b9c2480000000	MOVQ 0x80(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c6e47		4c8bac24a8000000	MOVQ 0xa8(SP), R13			
  0x1400c6e4f		f20f100df1040100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
			if x3 < 0 {
  0x1400c6e57		f20f105c2440		MOVSD_XMM 0x40(SP), X3			
  0x1400c6e5d		0f57e4			XORPS X4, X4				
  0x1400c6e60		f20f103538040100	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x1400c6e68		f20f103d20030100	MOVSD_XMM $f64.3db4456f771df7e8(SB), X7	
				absPow++
  0x1400c6e70		4989d9			MOVQ BX, R9		
  0x1400c6e73		4989c4			MOVQ AX, R12		
  0x1400c6e76		4989ca			MOVQ CX, R10		
		for ; k <= end-4; k += 4 {
  0x1400c6e79		488b442458		MOVQ 0x58(SP), AX	
			c0_0 := sim.X_e[k] * INV_DX
  0x1400c6e7e		488b8c24c8000000	MOVQ 0xc8(SP), CX	
				dead = append(dead, k+2)
  0x1400c6e86		488b9c2498000000	MOVQ 0x98(SP), BX		
  0x1400c6e8e		4b895cccf8		MOVQ BX, -0x8(R12)(R9*8)	
				absPow++
  0x1400c6e93		49ffc3			INCQ R11		
  0x1400c6e96		e9ac000000		JMP 0x1400c6f47		
			} else if x2 > L {
  0x1400c6e9b		f20f100545020100	MOVSD_XMM runtime.egcbss+10(SB), X0	
  0x1400c6ea3		660f2ed0		UCOMISD X0, X2				
  0x1400c6ea7		0f869a000000		JBE 0x1400c6f47				
				dead = append(dead, k+2)
  0x1400c6ead		49ffc1			INCQ R9				
  0x1400c6eb0		4d39ca			CMPQ R10, R9			
  0x1400c6eb3		0f8386000000		JAE 0x1400c6f3f			
  0x1400c6eb9		4c89e0			MOVQ R12, AX			
  0x1400c6ebc		4c89cb			MOVQ R9, BX			
  0x1400c6ebf		4c89d1			MOVQ R10, CX			
  0x1400c6ec2		bf01000000		MOVL $0x1, DI			
  0x1400c6ec7		488d35aa6b0f00		LEAQ type:*+95168(SB), SI	
  0x1400c6ece		e88d27fbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c6ed3		488b542468		MOVQ 0x68(SP), DX	
				dead = append(dead, k+3)
  0x1400c6ed8		488bbc2490000000	MOVQ 0x90(SP), DI	
				absGnd++
  0x1400c6ee0		4c8b842488000000	MOVQ 0x88(SP), R8	
			if x3 < 0 {
  0x1400c6ee8		4c8b9c2480000000	MOVQ 0x80(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c6ef0		4c8bac24a8000000	MOVQ 0xa8(SP), R13			
  0x1400c6ef8		f20f1005e8010100	MOVSD_XMM runtime.egcbss+10(SB), X0	
  0x1400c6f00		f20f100d40040100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
			if x3 < 0 {
  0x1400c6f08		f20f105c2440		MOVSD_XMM 0x40(SP), X3			
  0x1400c6f0e		0f57e4			XORPS X4, X4				
  0x1400c6f11		f20f103587030100	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x1400c6f19		f20f103d6f020100	MOVSD_XMM $f64.3db4456f771df7e8(SB), X7	
				absGnd++
  0x1400c6f21		4989d9			MOVQ BX, R9		
  0x1400c6f24		4989c4			MOVQ AX, R12		
  0x1400c6f27		4989ca			MOVQ CX, R10		
		for ; k <= end-4; k += 4 {
  0x1400c6f2a		488b442458		MOVQ 0x58(SP), AX	
			c0_0 := sim.X_e[k] * INV_DX
  0x1400c6f2f		488b8c24c8000000	MOVQ 0xc8(SP), CX	
				dead = append(dead, k+2)
  0x1400c6f37		488b9c2498000000	MOVQ 0x98(SP), BX		
  0x1400c6f3f		4b895cccf8		MOVQ BX, -0x8(R12)(R9*8)	
				absGnd++
  0x1400c6f44		49ffc0			INCQ R8			
			if x3 < 0 {
  0x1400c6f47		4c89842488000000	MOVQ R8, 0x88(SP)	
  0x1400c6f4f		4c899c2480000000	MOVQ R11, 0x80(SP)	
  0x1400c6f57		660f2ee3		UCOMISD X3, X4		
  0x1400c6f5b		0f1f440000		NOPL 0(AX)(AX*1)	
  0x1400c6f60		0f8680000000		JBE 0x1400c6fe6		
				dead = append(dead, k+3)
  0x1400c6f66		498d5901		LEAQ 0x1(R9), BX		
  0x1400c6f6a		4939da			CMPQ R10, BX			
  0x1400c6f6d		736a			JAE 0x1400c6fd9			
  0x1400c6f6f		4c89e0			MOVQ R12, AX			
  0x1400c6f72		4c89d1			MOVQ R10, CX			
  0x1400c6f75		bf01000000		MOVL $0x1, DI			
  0x1400c6f7a		488d35f76a0f00		LEAQ type:*+95168(SB), SI	
  0x1400c6f81		e8da26fbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c6f86		488b542468		MOVQ 0x68(SP), DX	
				dead = append(dead, k+3)
  0x1400c6f8b		488bbc2490000000	MOVQ 0x90(SP), DI	
  0x1400c6f93		4c8b842488000000	MOVQ 0x88(SP), R8	
				absPow++
  0x1400c6f9b		4c8b9c2480000000	MOVQ 0x80(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c6fa3		4c8bac24a8000000	MOVQ 0xa8(SP), R13			
  0x1400c6fab		f20f100d95030100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c6fb3		0f57e4			XORPS X4, X4				
  0x1400c6fb6		f20f1035e2020100	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x1400c6fbe		f20f103dca010100	MOVSD_XMM $f64.3db4456f771df7e8(SB), X7	
				absPow++
  0x1400c6fc6		4989c4			MOVQ AX, R12		
  0x1400c6fc9		4989ca			MOVQ CX, R10		
		for ; k <= end-4; k += 4 {
  0x1400c6fcc		488b442458		MOVQ 0x58(SP), AX	
			c0_0 := sim.X_e[k] * INV_DX
  0x1400c6fd1		488b8c24c8000000	MOVQ 0xc8(SP), CX	
				dead = append(dead, k+3)
  0x1400c6fd9		49897cdcf8		MOVQ DI, -0x8(R12)(BX*8)	
				absPow++
  0x1400c6fde		49ffc3			INCQ R11		
  0x1400c6fe1		e953f8ffff		JMP 0x1400c6839		
			} else if x3 > L {
  0x1400c6fe6		f20f1005fa000100	MOVSD_XMM runtime.egcbss+10(SB), X0	
  0x1400c6fee		660f2ed8		UCOMISD X0, X3				
  0x1400c6ff2		0f868d000000		JBE 0x1400c7085				
				dead = append(dead, k+3)
  0x1400c6ff8		498d5901		LEAQ 0x1(R9), BX		
  0x1400c6ffc		0f1f4000		NOPL 0(AX)			
  0x1400c7000		4939da			CMPQ R10, BX			
  0x1400c7003		7372			JAE 0x1400c7077			
  0x1400c7005		4c89e0			MOVQ R12, AX			
  0x1400c7008		4c89d1			MOVQ R10, CX			
  0x1400c700b		bf01000000		MOVL $0x1, DI			
  0x1400c7010		488d35616a0f00		LEAQ type:*+95168(SB), SI	
  0x1400c7017		e84426fbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c701c		488b542468		MOVQ 0x68(SP), DX	
				dead = append(dead, k+3)
  0x1400c7021		488bbc2490000000	MOVQ 0x90(SP), DI	
				absGnd++
  0x1400c7029		4c8b842488000000	MOVQ 0x88(SP), R8	
  0x1400c7031		4c8b9c2480000000	MOVQ 0x80(SP), R11	
		for ; k <= end-4; k += 4 {
  0x1400c7039		4c8bac24a8000000	MOVQ 0xa8(SP), R13			
  0x1400c7041		f20f10059f000100	MOVSD_XMM runtime.egcbss+10(SB), X0	
  0x1400c7049		f20f100df7020100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c7051		0f57e4			XORPS X4, X4				
  0x1400c7054		f20f103544020100	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x1400c705c		f20f103d2c010100	MOVSD_XMM $f64.3db4456f771df7e8(SB), X7	
				absGnd++
  0x1400c7064		4989c4			MOVQ AX, R12		
  0x1400c7067		4989ca			MOVQ CX, R10		
		for ; k <= end-4; k += 4 {
  0x1400c706a		488b442458		MOVQ 0x58(SP), AX	
			c0_0 := sim.X_e[k] * INV_DX
  0x1400c706f		488b8c24c8000000	MOVQ 0xc8(SP), CX	
				dead = append(dead, k+3)
  0x1400c7077		49897cdcf8		MOVQ DI, -0x8(R12)(BX*8)	
				absGnd++
  0x1400c707c		49ffc0			INCQ R8			
  0x1400c707f		90			NOPL			
  0x1400c7080		e9b4f7ffff		JMP 0x1400c6839		
  0x1400c7085		4c89cb			MOVQ R9, BX		
			} else if x3 > L {
  0x1400c7088		e9acf7ffff		JMP 0x1400c6839		
		for ; k < end; k++ {
  0x1400c708d		48ffc0			INCQ AX			
  0x1400c7090		4d89ef			MOVQ R13, R15		
  0x1400c7093		4839d0			CMPQ AX, DX		
  0x1400c7096		0f8d11020000		JGE 0x1400c72ad		
  0x1400c709c		0f1f4000		NOPL 0(AX)		
			c0 := sim.X_e[k] * INV_DX
  0x1400c70a0		483d40420f00		CMPQ AX, $0xf4240			
  0x1400c70a6		0f8353020000		JAE 0x1400c72ff				
  0x1400c70ac		f20f1084c1d07e5603	MOVSD_XMM 0x3567ed0(CX)(AX*8), X0	
  0x1400c70b5		f20f100d8b020100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c70bd		f20f59c1		MULSD X1, X0				
			p := min(max(int(c0), 0), N_G-2)
  0x1400c70c1		f24c0f2ce8		CVTTSD2SIQ X0, R13	
  0x1400c70c6		4d85ed			TESTQ R13, R13		
  0x1400c70c9		7d03			JGE 0x1400c70ce		
  0x1400c70cb		4531ed			XORL R13, R13		
  0x1400c70ce		4981fd8e010000		CMPQ R13, $0x18e	
  0x1400c70d5		7e06			JLE 0x1400c70dd		
  0x1400c70d7		41bd8e010000		MOVL $0x18e, R13	
		for ; k < end; k++ {
  0x1400c70dd		4889442458		MOVQ AX, 0x58(SP)	
  0x1400c70e2		4c89442478		MOVQ R8, 0x78(SP)	
  0x1400c70e7		4c895c2470		MOVQ R11, 0x70(SP)	
			d := c0 - float64(p)
  0x1400c70ec		0f57d2			XORPS X2, X2		
  0x1400c70ef		f2490f2ad5		CVTSI2SDQ R13, X2	
  0x1400c70f4		f20f5cc2		SUBSD X2, X0		
			ex := sim.Efield[p] + d*(sim.Efield[p+1]-sim.Efield[p])
  0x1400c70f8		f2420f1094e9d00e2707	MOVSD_XMM 0x7270ed0(CX)(R13*8), X2	
  0x1400c7102		f2420f109ce9d80e2707	MOVSD_XMM 0x7270ed8(CX)(R13*8), X3	
  0x1400c710c		f20f5cda		SUBSD X2, X3				
  0x1400c7110		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
			vx := sim.Vx_e[k] - ex*FACTOR_E
  0x1400c7115		f20f1084c1d090d003	MOVSD_XMM 0x3d090d0(CX)(AX*8), X0	
  0x1400c711e		f20f101d7a010100	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X3	
  0x1400c7126		f20f59d3		MULSD X3, X2				
  0x1400c712a		f20f5cc2		SUBSD X2, X0				
			sim.Vx_e[k] = vx
  0x1400c712e		f20f1184c1d090d003	MOVSD_XMM X0, 0x3d090d0(CX)(AX*8)	
			x := sim.X_e[k] + vx*DT_E
  0x1400c7137		f20f1094c1d07e5603	MOVSD_XMM 0x3567ed0(CX)(AX*8), X2	
  0x1400c7140		f20f102548000100	MOVSD_XMM $f64.3db4456f771df7e8(SB), X4	
  0x1400c7148		c4e2f9b9d4		VFMADD231SD X4, X0, X2			
			sim.X_e[k] = x
  0x1400c714d		f20f1194c1d07e5603	MOVSD_XMM X2, 0x3567ed0(CX)(AX*8)	
			if x < 0 {
  0x1400c7156		0f57c0			XORPS X0, X0		
  0x1400c7159		660f2ec2		UCOMISD X2, X0		
  0x1400c715d		0f1f00			NOPL 0(AX)		
  0x1400c7160		0f8690000000		JBE 0x1400c71f6		
				dead = append(dead, k)
  0x1400c7166		4d8d6f01		LEAQ 0x1(R15), R13		
  0x1400c716a		4d39ea			CMPQ R10, R13			
  0x1400c716d		737a			JAE 0x1400c71e9			
  0x1400c716f		4c89e0			MOVQ R12, AX			
  0x1400c7172		4c89eb			MOVQ R13, BX			
  0x1400c7175		4c89d1			MOVQ R10, CX			
  0x1400c7178		bf01000000		MOVL $0x1, DI			
  0x1400c717d		488d35f4680f00		LEAQ type:*+95168(SB), SI	
  0x1400c7184		e8d724fbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c7189		488b542468		MOVQ 0x68(SP), DX	
	sim.WorkerDeadElectrons[workerID] = dead
  0x1400c718e		488bb424b0000000	MOVQ 0xb0(SP), SI	
		diag.abs_pow = absPow
  0x1400c7196		488bbc24c0000000	MOVQ 0xc0(SP), DI	
  0x1400c719e		4c8b442478		MOVQ 0x78(SP), R8	
  0x1400c71a3		4c8b8c24b8000000	MOVQ 0xb8(SP), R9	
				absPow++
  0x1400c71ab		4c8b5c2470		MOVQ 0x70(SP), R11			
  0x1400c71b0		0f57c0			XORPS X0, X0				
  0x1400c71b3		f20f100d8d010100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c71bb		f20f101ddd000100	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X3	
  0x1400c71c3		f20f1025c5ff0000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X4	
  0x1400c71cb		4989dd			MOVQ BX, R13				
  0x1400c71ce		4989c4			MOVQ AX, R12				
  0x1400c71d1		4989ca			MOVQ CX, R10				
				dead = append(dead, k)
  0x1400c71d4		488b442458		MOVQ 0x58(SP), AX	
			c0 := sim.X_e[k] * INV_DX
  0x1400c71d9		488b8c24c8000000	MOVQ 0xc8(SP), CX	
	sim.WorkerDeadElectrons[workerID] = dead
  0x1400c71e1		488b9c24e8000000	MOVQ 0xe8(SP), BX	
				dead = append(dead, k)
  0x1400c71e9		4b8944ecf8		MOVQ AX, -0x8(R12)(R13*8)	
				absPow++
  0x1400c71ee		49ffc3			INCQ R11		
  0x1400c71f1		e997feffff		JMP 0x1400c708d		
			} else if x > L {
  0x1400c71f6		f20f102deafe0000	MOVSD_XMM runtime.egcbss+10(SB), X5	
  0x1400c71fe		660f2ed5		UCOMISD X5, X2				
  0x1400c7202		0f869d000000		JBE 0x1400c72a5				
				dead = append(dead, k)
  0x1400c7208		4d8d6f01		LEAQ 0x1(R15), R13		
  0x1400c720c		4d39ea			CMPQ R10, R13			
  0x1400c720f		0f8382000000		JAE 0x1400c7297			
  0x1400c7215		4c89e0			MOVQ R12, AX			
  0x1400c7218		4c89eb			MOVQ R13, BX			
  0x1400c721b		4c89d1			MOVQ R10, CX			
  0x1400c721e		bf01000000		MOVL $0x1, DI			
  0x1400c7223		488d354e680f00		LEAQ type:*+95168(SB), SI	
  0x1400c722a		e83124fbff		CALL runtime.growslice(SB)	
		for ; k < end; k++ {
  0x1400c722f		488b542468		MOVQ 0x68(SP), DX	
	sim.WorkerDeadElectrons[workerID] = dead
  0x1400c7234		488bb424b0000000	MOVQ 0xb0(SP), SI	
		diag.abs_pow = absPow
  0x1400c723c		488bbc24c0000000	MOVQ 0xc0(SP), DI	
				absGnd++
  0x1400c7244		4c8b442478		MOVQ 0x78(SP), R8	
		diag.abs_pow = absPow
  0x1400c7249		4c8b8c24b8000000	MOVQ 0xb8(SP), R9			
  0x1400c7251		4c8b5c2470		MOVQ 0x70(SP), R11			
  0x1400c7256		0f57c0			XORPS X0, X0				
  0x1400c7259		f20f100de7000100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c7261		f20f101d37000100	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X3	
  0x1400c7269		f20f10251fff0000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X4	
  0x1400c7271		f20f102d6ffe0000	MOVSD_XMM runtime.egcbss+10(SB), X5	
				absGnd++
  0x1400c7279		4989dd			MOVQ BX, R13		
  0x1400c727c		4989c4			MOVQ AX, R12		
  0x1400c727f		4989ca			MOVQ CX, R10		
				dead = append(dead, k)
  0x1400c7282		488b442458		MOVQ 0x58(SP), AX	
			c0 := sim.X_e[k] * INV_DX
  0x1400c7287		488b8c24c8000000	MOVQ 0xc8(SP), CX	
	sim.WorkerDeadElectrons[workerID] = dead
  0x1400c728f		488b9c24e8000000	MOVQ 0xe8(SP), BX	
				dead = append(dead, k)
  0x1400c7297		4b8944ecf8		MOVQ AX, -0x8(R12)(R13*8)	
				absGnd++
  0x1400c729c		49ffc0			INCQ R8			
  0x1400c729f		90			NOPL			
  0x1400c72a0		e9e8fdffff		JMP 0x1400c708d		
  0x1400c72a5		4d89fd			MOVQ R15, R13		
			} else if x > L {
  0x1400c72a8		e9e0fdffff		JMP 0x1400c708d		
		diag.abs_pow = absPow
  0x1400c72ad		4e899c0f90700000	MOVQ R11, 0x7090(DI)(R9*1)	
		diag.abs_gnd = absGnd
  0x1400c72b5		4e89840f98700000	MOVQ R8, 0x7098(DI)(R9*1)	
	sim.WorkerDeadElectrons[workerID] = dead
  0x1400c72bd		488b4168		MOVQ 0x68(CX), AX			
  0x1400c72c1		4839c3			CMPQ BX, AX				
  0x1400c72c4		7334			JAE 0x1400c72fa				
  0x1400c72c6		488b4160		MOVQ 0x60(CX), AX			
  0x1400c72ca		4c897cf008		MOVQ R15, 0x8(AX)(SI*8)			
  0x1400c72cf		4c8954f010		MOVQ R10, 0x10(AX)(SI*8)		
  0x1400c72d4		833dd5cd150000		CMPL runtime.writeBarrier(SB), $0x0	
  0x1400c72db		7410			JE 0x1400c72ed				
  0x1400c72dd		488b0cf0		MOVQ 0(AX)(SI*8), CX			
  0x1400c72e1		e8fa6dfbff		CALL runtime.gcWriteBarrier2(SB)	
  0x1400c72e6		4d8923			MOVQ R12, 0(R11)			
  0x1400c72e9		49894b08		MOVQ CX, 0x8(R11)			
  0x1400c72ed		4c8924f0		MOVQ R12, 0(AX)(SI*8)			
}
  0x1400c72f1		4881c4d0000000		ADDQ $0xd0, SP		
  0x1400c72f8		5d			POPQ BP			
  0x1400c72f9		c3			RET			
	sim.WorkerDeadElectrons[workerID] = dead
  0x1400c72fa		e88171fbff		CALL runtime.panicBounds(SB)	
			c0 := sim.X_e[k] * INV_DX
  0x1400c72ff		b940420f00		MOVL $0xf4240, CX		
  0x1400c7304		e87771fbff		CALL runtime.panicBounds(SB)	
			c0_3 := sim.X_e[k+3] * INV_DX
  0x1400c7309		b840420f00		MOVL $0xf4240, AX		
  0x1400c730e		e86d71fbff		CALL runtime.panicBounds(SB)	
			c0_2 := sim.X_e[k+2] * INV_DX
  0x1400c7313		b840420f00		MOVL $0xf4240, AX		
  0x1400c7318		b940420f00		MOVL $0xf4240, CX		
  0x1400c731d		0f1f00			NOPL 0(AX)			
  0x1400c7320		e85b71fbff		CALL runtime.panicBounds(SB)	
			c0_1 := sim.X_e[k+1] * INV_DX
  0x1400c7325		b840420f00		MOVL $0xf4240, AX		
  0x1400c732a		b940420f00		MOVL $0xf4240, CX		
  0x1400c732f		e84c71fbff		CALL runtime.panicBounds(SB)	
			c0_0 := sim.X_e[k] * INV_DX
  0x1400c7334		b940420f00		MOVL $0xf4240, CX		
  0x1400c7339		e84271fbff		CALL runtime.panicBounds(SB)	
			_ = sim.X_e[end-1]
  0x1400c733e		b840420f00		MOVL $0xf4240, AX		
  0x1400c7343		e83871fbff		CALL runtime.panicBounds(SB)	
	sim.WorkerDeadElectrons[workerID] = dead
  0x1400c7348		4889f1			MOVQ SI, CX		
  0x1400c734b		4c89de			MOVQ R11, SI		
  0x1400c734e		4989c7			MOVQ AX, R15		
  0x1400c7351		e967ffffff		JMP 0x1400c72bd		
			for k := start; k < end; k++ {
  0x1400c7356		49ffc5			INCQ R13		
  0x1400c7359		0f1f8000000000		NOPL 0(AX)		
  0x1400c7360		4939d5			CMPQ R13, DX		
  0x1400c7363		0f8db0040000		JGE 0x1400c7819		
				c0 = sim.X_e[k] * INV_DX
  0x1400c7369		4981fd40420f00		CMPQ R13, $0xf4240			
  0x1400c7370		0f83c3040000		JAE 0x1400c7839				
  0x1400c7376		f2420f1084eed07e5603	MOVSD_XMM 0x3567ed0(SI)(R13*8), X0	
  0x1400c7380		f20f100dc0ff0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c7388		f20f59c1		MULSD X1, X0				
				p = min(max(int(c0), 0), N_G-2)
  0x1400c738c		f2480f2cc0		CVTTSD2SIQ X0, AX	
  0x1400c7391		4885c0			TESTQ AX, AX		
  0x1400c7394		7d0a			JGE 0x1400c73a0		
  0x1400c7396		31c0			XORL AX, AX		
  0x1400c7398		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x1400c73a0		483d8e010000		CMPQ AX, $0x18e		
  0x1400c73a6		7e05			JLE 0x1400c73ad		
  0x1400c73a8		b88e010000		MOVL $0x18e, AX		
				c1 = float64(p) + 1.0 - c0
  0x1400c73ad		0f57d2			XORPS X2, X2				
  0x1400c73b0		f2480f2ad0		CVTSI2SDQ AX, X2			
  0x1400c73b5		f20f101d9bfe0000	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x1400c73bd		f20f58da		ADDSD X2, X3				
  0x1400c73c1		f20f5cd8		SUBSD X0, X3				
				c2 = c0 - float64(p)
  0x1400c73c5		f20f5cc2		SUBSD X2, X0		
				e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]
  0x1400c73c9		f20f1094c6d00e2707	MOVSD_XMM 0x7270ed0(SI)(AX*8), X2	
  0x1400c73d2		f20f59d3		MULSD X3, X2				
  0x1400c73d6		f20f10a4c6d80e2707	MOVSD_XMM 0x7270ed8(SI)(AX*8), X4	
  0x1400c73df		c4e2d9b9d0		VFMADD231SD X0, X4, X2			
				mean_v = sim.Vx_e[k] - 0.5*e_x*FACTOR_E
  0x1400c73e4		f2420f10a4eed090d003	MOVSD_XMM 0x3d090d0(SI)(R13*8), X4	
  0x1400c73ee		f20f102d4afe0000	MOVSD_XMM $f64.3fe0000000000000(SB), X5	
  0x1400c73f6		f20f59ea		MULSD X2, X5				
  0x1400c73fa		f20f10359efe0000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x1400c7402		f20f59ee		MULSD X6, X5				
  0x1400c7406		f20f5ce5		SUBSD X5, X4				
				diag.counter_e[p] += c1
  0x1400c740a		4b8d0c08		LEAQ 0(R8)(R9*1), CX		
  0x1400c740e		f20f102cc1		MOVSD_XMM 0(CX)(AX*8), X5	
  0x1400c7413		f20f58eb		ADDSD X3, X5			
  0x1400c7417		f20f112cc1		MOVSD_XMM X5, 0(CX)(AX*8)	
				diag.counter_e[p+1] += c2
  0x1400c741c		f20f106cc108		MOVSD_XMM 0x8(CX)(AX*8), X5	
  0x1400c7422		f20f58e8		ADDSD X0, X5			
  0x1400c7426		f20f116cc108		MOVSD_XMM X5, 0x8(CX)(AX*8)	
				diag.ue[p] += c1 * mean_v
  0x1400c742c		4b8d0c08		LEAQ 0(R8)(R9*1), CX		
  0x1400c7430		488d89800c0000		LEAQ 0xc80(CX), CX		
  0x1400c7437		f20f102cc1		MOVSD_XMM 0(CX)(AX*8), X5	
  0x1400c743c		c4e2e1b9ec		VFMADD231SD X4, X3, X5		
  0x1400c7441		f20f112cc1		MOVSD_XMM X5, 0(CX)(AX*8)	
				diag.ue[p+1] += c2 * mean_v
  0x1400c7446		f20f106cc108		MOVSD_XMM 0x8(CX)(AX*8), X5	
  0x1400c744c		c4e2f9b9ec		VFMADD231SD X4, X0, X5		
  0x1400c7451		f20f116cc108		MOVSD_XMM X5, 0x8(CX)(AX*8)	
				v_sqr = mean_v*mean_v + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
  0x1400c7457		f2420f10aceed0a24a04	MOVSD_XMM 0x44aa2d0(SI)(R13*8), X5	
  0x1400c7461		f20f59ed		MULSD X5, X5				
  0x1400c7465		c4e2d9b9ec		VFMADD231SD X4, X4, X5			
  0x1400c746a		f2420f10a4eed0b4c404	MOVSD_XMM 0x4c4b4d0(SI)(R13*8), X4	
  0x1400c7474		c4e2d9b9ec		VFMADD231SD X4, X4, X5			
				energy = 0.5 * E_MASS * v_sqr * INV_EV_TO_J
  0x1400c7479		f20f1025affc0000	MOVSD_XMM $f64.39a279dcc3e61461(SB), X4	
  0x1400c7481		f20f59e5		MULSD X5, X4				
  0x1400c7485		f20f103df3fe0000	MOVSD_XMM $f64.43d5a792def818e8(SB), X7	
  0x1400c748d		f20f59fc		MULSD X4, X7				
				diag.meanee[p] += c1 * energy
  0x1400c7491		4b8d0c08		LEAQ 0(R8)(R9*1), CX		
  0x1400c7495		488d8900190000		LEAQ 0x1900(CX), CX		
  0x1400c749c		f2440f1004c1		MOVSD_XMM 0(CX)(AX*8), X8	
  0x1400c74a2		c462c1b9c3		VFMADD231SD X3, X7, X8		
  0x1400c74a7		f2440f1104c1		MOVSD_XMM X8, 0(CX)(AX*8)	
				diag.meanee[p+1] += c2 * energy
  0x1400c74ad		f2440f1044c108		MOVSD_XMM 0x8(CX)(AX*8), X8	
  0x1400c74b4		c462c1b9c0		VFMADD231SD X0, X7, X8		
  0x1400c74b9		f2440f1144c108		MOVSD_XMM X8, 0x8(CX)(AX*8)	
				energy_index = minInt(int(v_sqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
  0x1400c74c0		f2440f100577fd0000	MOVSD_XMM $f64.3fe0000000000000(SB), X8	
  0x1400c74c9		f2440f100dd6fc0000	MOVSD_XMM $f64.3e286b6a97118d9b(SB), X9	
  0x1400c74d2		c462b1b9c5		VFMADD231SD X5, X9, X8			
  0x1400c74d7		f2490f2cc8		CVTTSD2SIQ X8, CX			
  0x1400c74dc		0f1f4000		NOPL 0(AX)				
	if a < b {
  0x1400c74e0		4881f93f420f00		CMPQ CX, $0xf423f	
  0x1400c74e7		7c05			JL 0x1400c74ee		
  0x1400c74e9		b93f420f00		MOVL $0xf423f, CX	
				velocity = math.Sqrt(v_sqr)
  0x1400c74ee		90			NOPL			
				rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x1400c74ef		4881f940420f00		CMPQ CX, $0xf4240	
  0x1400c74f6		0f8333030000		JAE 0x1400c782f		
				diag.ioniz[p] += c1 * rate
  0x1400c74fc		4b8d3c08		LEAQ 0(R8)(R9*1), DI	
  0x1400c7500		488dbf80250000		LEAQ 0x2580(DI), DI	
	return sqrt(x)
  0x1400c7507		f20f51ed		SQRTSD X5, X5		
				rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x1400c750b		f20f59accec024f400	MULSD 0xf424c0(SI)(CX*8), X5			
  0x1400c7514		f2440f100573fc0000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X8		
  0x1400c751d		f2410f59e8		MULSD X8, X5					
  0x1400c7522		f2440f10155dfe0000	MOVSD_XMM $f64.445c0bbef48bc79c(SB), X10	
  0x1400c752b		f2410f59ea		MULSD X10, X5					
				diag.ioniz[p] += c1 * rate
  0x1400c7530		f20f59dd		MULSD X5, X3			
  0x1400c7534		f20f581cc7		ADDSD 0(DI)(AX*8), X3		
  0x1400c7539		f20f111cc7		MOVSD_XMM X3, 0(DI)(AX*8)	
				diag.ioniz[p+1] += c2 * rate
  0x1400c753e		f20f105cc708		MOVSD_XMM 0x8(DI)(AX*8), X3	
  0x1400c7544		c4e2d1b9d8		VFMADD231SD X0, X5, X3		
  0x1400c7549		f20f115cc708		MOVSD_XMM X3, 0x8(DI)(AX*8)	
				if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
  0x1400c754f		f2420f1084eed07e5603	MOVSD_XMM 0x3567ed0(SI)(R13*8), X0	
  0x1400c7559		f20f101d97fc0000	MOVSD_XMM $f64.3f870a3d70a3d70b(SB), X3	
  0x1400c7561		660f2ec3		UCOMISD X3, X0				
  0x1400c7565		0f868c000000		JBE 0x1400c75f7				
  0x1400c756b		f20f102d8dfc0000	MOVSD_XMM $f64.3f8c28f5c28f5c2a(SB), X5	
  0x1400c7573		660f2ee8		UCOMISD X0, X5				
  0x1400c7577		0f8682000000		JBE 0x1400c75ff				
					energy_index = int(energy * INV_DE_EEPF)
  0x1400c757d		f20f10057bfd0000	MOVSD_XMM $f64.4034000000000000(SB), X0	
  0x1400c7585		f20f59f8		MULSD X0, X7				
  0x1400c7589		f2480f2cc7		CVTTSD2SIQ X7, AX			
					if energy_index < N_EEPF {
  0x1400c758e		483dd0070000		CMPQ AX, $0x7d0		
  0x1400c7594		7d2c			JGE 0x1400c75c2		
						diag.eepf[energy_index] += 1.0
  0x1400c7596		4b8d0c08		LEAQ 0(R8)(R9*1), CX				
  0x1400c759a		488d8900320000		LEAQ 0x3200(CX), CX				
  0x1400c75a1		0f837e020000		JAE 0x1400c7825					
  0x1400c75a7		f20f103cc1		MOVSD_XMM 0(CX)(AX*8), X7			
  0x1400c75ac		f2440f101da3fc0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
  0x1400c75b5		f2410f58fb		ADDSD X11, X7					
  0x1400c75ba		f20f113cc1		MOVSD_XMM X7, 0(CX)(AX*8)			
  0x1400c75bf		90			NOPL						
  0x1400c75c0		eb09			JMP 0x1400c75cb					
  0x1400c75c2		f2440f101d8dfc0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
					diag.accuCenter += energy
  0x1400c75cb		f2430f10bc0880700000	MOVSD_XMM 0x7080(R8)(R9*1), X7			
  0x1400c75d5		f2440f1025a2fd0000	MOVSD_XMM $f64.43d5a792def818e8(SB), X12	
  0x1400c75de		c4e299b9fc		VFMADD231SD X4, X12, X7				
  0x1400c75e3		f2430f11bc0880700000	MOVSD_XMM X7, 0x7080(R8)(R9*1)			
					diag.counterCenter++
  0x1400c75ed		4bff840888700000	INCQ 0x7088(R8)(R9*1)			
  0x1400c75f5		eb22			JMP 0x1400c7619				
  0x1400c75f7		f20f102d01fc0000	MOVSD_XMM $f64.3f8c28f5c28f5c2a(SB), X5	
				if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
  0x1400c75ff		f20f1005f9fc0000	MOVSD_XMM $f64.4034000000000000(SB), X0		
  0x1400c7607		f2440f101d48fc0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
  0x1400c7610		f2440f102567fd0000	MOVSD_XMM $f64.43d5a792def818e8(SB), X12	
			for k := start; k < end; k++ {
  0x1400c7619		4c896c2460		MOVQ R13, 0x60(SP)	
				sim.Vx_e[k] -= e_x * FACTOR_E
  0x1400c761e		f2420f10a4eed090d003	MOVSD_XMM 0x3d090d0(SI)(R13*8), X4	
  0x1400c7628		f20f59d6		MULSD X6, X2				
  0x1400c762c		f20f5ce2		SUBSD X2, X4				
  0x1400c7630		f2420f11a4eed090d003	MOVSD_XMM X4, 0x3d090d0(SI)(R13*8)	
				newX := sim.X_e[k] + sim.Vx_e[k]*DT_E
  0x1400c763a		f2420f1094eed07e5603	MOVSD_XMM 0x3567ed0(SI)(R13*8), X2	
  0x1400c7644		c4e2b9b9d4		VFMADD231SD X4, X8, X2			
				sim.X_e[k] = newX
  0x1400c7649		f2420f1194eed07e5603	MOVSD_XMM X2, 0x3567ed0(SI)(R13*8)	
				if newX < 0 {
  0x1400c7653		0f57e4			XORPS X4, X4		
  0x1400c7656		660f2ee2		UCOMISD X2, X4		
  0x1400c765a		660f1f440000		NOPW 0(AX)(AX*1)	
  0x1400c7660		0f86cb000000		JBE 0x1400c7731		
					dead = append(dead, k)
  0x1400c7666		49ffc7			INCQ R15			
  0x1400c7669		4d39fa			CMPQ R10, R15			
  0x1400c766c		0f83ad000000		JAE 0x1400c771f			
  0x1400c7672		4c89e0			MOVQ R12, AX			
  0x1400c7675		4c89fb			MOVQ R15, BX			
  0x1400c7678		4c89d1			MOVQ R10, CX			
  0x1400c767b		bf01000000		MOVL $0x1, DI			
  0x1400c7680		488d35f1630f00		LEAQ type:*+95168(SB), SI	
  0x1400c7687		e8d41ffbff		CALL runtime.growslice(SB)	
			for k := start; k < end; k++ {
  0x1400c768c		488b542468		MOVQ 0x68(SP), DX	
				c0 = sim.X_e[k] * INV_DX
  0x1400c7691		488bb424c8000000	MOVQ 0xc8(SP), SI	
					diag.abs_pow++
  0x1400c7699		4c8b8424c0000000	MOVQ 0xc0(SP), R8	
  0x1400c76a1		4c8b8c24b8000000	MOVQ 0xb8(SP), R9	
	sim.WorkerDeadElectrons[workerID] = dead
  0x1400c76a9		4c8b9c24b0000000	MOVQ 0xb0(SP), R11	
					dead = append(dead, k)
  0x1400c76b1		4c8b6c2460		MOVQ 0x60(SP), R13				
  0x1400c76b6		f20f100542fc0000	MOVSD_XMM $f64.4034000000000000(SB), X0		
  0x1400c76be		f20f100d82fc0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1		
  0x1400c76c6		f20f101d2afb0000	MOVSD_XMM $f64.3f870a3d70a3d70b(SB), X3		
  0x1400c76ce		0f57e4			XORPS X4, X4					
  0x1400c76d1		f20f102d27fb0000	MOVSD_XMM $f64.3f8c28f5c28f5c2a(SB), X5		
  0x1400c76d9		f20f1035bffb0000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6		
  0x1400c76e1		f2440f1005a6fa0000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X8		
  0x1400c76ea		f2440f100db5fa0000	MOVSD_XMM $f64.3e286b6a97118d9b(SB), X9		
  0x1400c76f3		f2440f10158cfc0000	MOVSD_XMM $f64.445c0bbef48bc79c(SB), X10	
  0x1400c76fc		f2440f101d53fb0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
  0x1400c7705		f2440f102572fc0000	MOVSD_XMM $f64.43d5a792def818e8(SB), X12	
					diag.abs_pow++
  0x1400c770e		4989df			MOVQ BX, R15		
  0x1400c7711		4989c4			MOVQ AX, R12		
  0x1400c7714		4989ca			MOVQ CX, R10		
	sim.WorkerDeadElectrons[workerID] = dead
  0x1400c7717		488b9c24e8000000	MOVQ 0xe8(SP), BX	
					dead = append(dead, k)
  0x1400c771f		4f896cfcf8		MOVQ R13, -0x8(R12)(R15*8)	
					diag.abs_pow++
  0x1400c7724		4bff840890700000	INCQ 0x7090(R8)(R9*1)	
  0x1400c772c		e925fcffff		JMP 0x1400c7356		
				} else if newX > L {
  0x1400c7731		f20f103daff90000	MOVSD_XMM runtime.egcbss+10(SB), X7	
  0x1400c7739		660f2ed7		UCOMISD X7, X2				
  0x1400c773d		0f1f00			NOPL 0(AX)				
  0x1400c7740		0f8610fcffff		JBE 0x1400c7356				
					dead = append(dead, k)
  0x1400c7746		49ffc7			INCQ R15			
  0x1400c7749		4d39fa			CMPQ R10, R15			
  0x1400c774c		0f83b5000000		JAE 0x1400c7807			
  0x1400c7752		4c89e0			MOVQ R12, AX			
  0x1400c7755		4c89fb			MOVQ R15, BX			
  0x1400c7758		4c89d1			MOVQ R10, CX			
  0x1400c775b		bf01000000		MOVL $0x1, DI			
  0x1400c7760		488d3511630f00		LEAQ type:*+95168(SB), SI	
  0x1400c7767		e8f41efbff		CALL runtime.growslice(SB)	
			for k := start; k < end; k++ {
  0x1400c776c		488b542468		MOVQ 0x68(SP), DX	
				c0 = sim.X_e[k] * INV_DX
  0x1400c7771		488bb424c8000000	MOVQ 0xc8(SP), SI	
					diag.abs_gnd++
  0x1400c7779		4c8b8424c0000000	MOVQ 0xc0(SP), R8	
  0x1400c7781		4c8b8c24b8000000	MOVQ 0xb8(SP), R9	
	sim.WorkerDeadElectrons[workerID] = dead
  0x1400c7789		4c8b9c24b0000000	MOVQ 0xb0(SP), R11	
					dead = append(dead, k)
  0x1400c7791		4c8b6c2460		MOVQ 0x60(SP), R13				
  0x1400c7796		f20f100562fb0000	MOVSD_XMM $f64.4034000000000000(SB), X0		
  0x1400c779e		f20f100da2fb0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1		
  0x1400c77a6		f20f101d4afa0000	MOVSD_XMM $f64.3f870a3d70a3d70b(SB), X3		
  0x1400c77ae		0f57e4			XORPS X4, X4					
  0x1400c77b1		f20f102d47fa0000	MOVSD_XMM $f64.3f8c28f5c28f5c2a(SB), X5		
  0x1400c77b9		f20f1035dffa0000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6		
  0x1400c77c1		f20f103d1ff90000	MOVSD_XMM runtime.egcbss+10(SB), X7		
  0x1400c77c9		f2440f1005bef90000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X8		
  0x1400c77d2		f2440f100dcdf90000	MOVSD_XMM $f64.3e286b6a97118d9b(SB), X9		
  0x1400c77db		f2440f1015a4fb0000	MOVSD_XMM $f64.445c0bbef48bc79c(SB), X10	
  0x1400c77e4		f2440f101d6bfa0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
  0x1400c77ed		f2440f10258afb0000	MOVSD_XMM $f64.43d5a792def818e8(SB), X12	
					diag.abs_gnd++
  0x1400c77f6		4989df			MOVQ BX, R15		
  0x1400c77f9		4989c4			MOVQ AX, R12		
  0x1400c77fc		4989ca			MOVQ CX, R10		
	sim.WorkerDeadElectrons[workerID] = dead
  0x1400c77ff		488b9c24e8000000	MOVQ 0xe8(SP), BX	
					dead = append(dead, k)
  0x1400c7807		4f896cfcf8		MOVQ R13, -0x8(R12)(R15*8)	
					diag.abs_gnd++
  0x1400c780c		4bff840898700000	INCQ 0x7098(R8)(R9*1)	
  0x1400c7814		e93dfbffff		JMP 0x1400c7356		
  0x1400c7819		4c89f8			MOVQ R15, AX		
  0x1400c781c		0f1f4000		NOPL 0(AX)		
			for k := start; k < end; k++ {
  0x1400c7820		e923fbffff		JMP 0x1400c7348		
						diag.eepf[energy_index] += 1.0
  0x1400c7825		b9d0070000		MOVL $0x7d0, CX			
  0x1400c782a		e8516cfbff		CALL runtime.panicBounds(SB)	
				rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x1400c782f		b840420f00		MOVL $0xf4240, AX		
  0x1400c7834		e8476cfbff		CALL runtime.panicBounds(SB)	
				c0 = sim.X_e[k] * INV_DX
  0x1400c7839		b840420f00		MOVL $0xf4240, AX		
  0x1400c783e		6690			NOPW				
  0x1400c7840		e83b6cfbff		CALL runtime.panicBounds(SB)	
	dead := sim.WorkerDeadElectrons[workerID][:0]
  0x1400c7845		e8366cfbff		CALL runtime.panicBounds(SB)	
	diag := &sim.WorkerEDiag[workerID]
  0x1400c784a		e8316cfbff		CALL runtime.panicBounds(SB)	
		chunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c784f		e84cbaf7ff		CALL runtime.panicdivide(SB)	
  0x1400c7854		90			NOPL				
func (sim *SimulationState) workerMoveElectrons(workerID int) {
  0x1400c7855		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c785a		48895c2410		MOVQ BX, 0x10(SP)					
  0x1400c785f		90			NOPL							
  0x1400c7860		e8db4dfbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c7865		488b442408		MOVQ 0x8(SP), AX					
  0x1400c786a		488b5c2410		MOVQ 0x10(SP), BX					
  0x1400c786f		e96ceeffff		JMP gopic.(*SimulationState).workerMoveElectrons(SB)	

  0x1400c7874		cc			INT $0x3		
  0x1400c7875		cc			INT $0x3		
  0x1400c7876		cc			INT $0x3		
  0x1400c7877		cc			INT $0x3		
  0x1400c7878		cc			INT $0x3		
  0x1400c7879		cc			INT $0x3		
  0x1400c787a		cc			INT $0x3		
  0x1400c787b		cc			INT $0x3		
  0x1400c787c		cc			INT $0x3		
  0x1400c787d		cc			INT $0x3		
  0x1400c787e		cc			INT $0x3		
  0x1400c787f		cc			INT $0x3		


