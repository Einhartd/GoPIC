// =============================================================================
// SYMBOL: workerComputeEDensity
// =============================================================================

TEXT gopic.(*SimulationState).workerComputeEDensity(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/worker.go
func (sim *SimulationState) workerComputeEDensity(workerID int) {
  0x1400c6420		55			PUSHQ BP		
  0x1400c6421		4889e5			MOVQ SP, BP		
	chunkSize := sim.EChunkSize
  0x1400c6424		8400			TESTB AL, 0(AX)		
  0x1400c6426		488b88582eba07		MOVQ 0x7ba2e58(AX), CX	
	if chunkSize <= 0 {
  0x1400c642d		4885c9			TESTQ CX, CX		
  0x1400c6430		7f42			JG 0x1400c6474		
		chunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c6432		488b88c07e5603		MOVQ 0x3567ec0(AX), CX	
  0x1400c6439		488b90482eba07		MOVQ 0x7ba2e48(AX), DX	
  0x1400c6440		488d0c11		LEAQ 0(CX)(DX*1), CX	
  0x1400c6444		488d49ff		LEAQ -0x1(CX), CX	
  0x1400c6448		4885d2			TESTQ DX, DX		
  0x1400c644b		0f8423010000		JE 0x1400c6574		
	if chunkSize <= 0 {
  0x1400c6451		4889c6			MOVQ AX, SI		
		chunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c6454		4889c8			MOVQ CX, AX		
  0x1400c6457		4889d7			MOVQ DX, DI		
  0x1400c645a		660f1f440000		NOPW 0(AX)(AX*1)	
  0x1400c6460		4883ffff		CMPQ DI, $-0x1		
  0x1400c6464		7507			JNE 0x1400c646d		
  0x1400c6466		48f7d8			NEGQ AX			
  0x1400c6469		31d2			XORL DX, DX		
  0x1400c646b		eb0d			JMP 0x1400c647a		
  0x1400c646d		4899			CQO			
  0x1400c646f		48f7ff			IDIVQ DI		
  0x1400c6472		eb06			JMP 0x1400c647a		
	if end > sim.N_e {
  0x1400c6474		4889c6			MOVQ AX, SI		
	start := workerID * chunkSize
  0x1400c6477		4889c8			MOVQ CX, AX		
  0x1400c647a		4889c1			MOVQ AX, CX		
  0x1400c647d		480fafc3		IMULQ BX, AX		
	end := start + chunkSize
  0x1400c6481		4801c1			ADDQ AX, CX		
	if end > sim.N_e {
  0x1400c6484		488b96c07e5603		MOVQ 0x3567ec0(SI), DX	
	densityE := &sim.WorkerEDensity[workerID]
  0x1400c648b		488b7e08		MOVQ 0x8(SI), DI	
	if end > sim.N_e {
  0x1400c648f		4839ca			CMPQ DX, CX		
	densityE := &sim.WorkerEDensity[workerID]
  0x1400c6492		480f4cca		CMOVL DX, CX		
  0x1400c6496		4839fb			CMPQ BX, DI		
	if end > sim.N_e {
  0x1400c6499		0f83d0000000		JAE 0x1400c656f		
	densityE := &sim.WorkerEDensity[workerID]
  0x1400c649f		488b16			MOVQ 0(SI), DX		
  0x1400c64a2		4869db800c0000		IMULQ $0xc80, BX, BX	
  0x1400c64a9		4801da			ADDQ BX, DX		
	for i := 0; i < N_G; i++ {
  0x1400c64ac		31db			XORL BX, BX		
  0x1400c64ae		eb10			JMP 0x1400c64c0		
		densityE[i] = 0.0
  0x1400c64b0		48c704da00000000	MOVQ $0x0, 0(DX)(BX*8)	
	for i := 0; i < N_G; i++ {
  0x1400c64b8		48ffc3			INCQ BX			
  0x1400c64bb		0f1f440000		NOPL 0(AX)(AX*1)	
  0x1400c64c0		4881fb90010000		CMPQ BX, $0x190		
  0x1400c64c7		7ce7			JL 0x1400c64b0		
	if start < end {
  0x1400c64c9		4839c1			CMPQ CX, AX		
  0x1400c64cc		7f4c			JG 0x1400c651a		
}
  0x1400c64ce		5d			POPQ BP			
  0x1400c64cf		c3			RET			
			c2 := (c0 - float64(p)) * FACTOR_W
  0x1400c64d0		0f57d2			XORPS X2, X2				
  0x1400c64d3		f2480f2ad3		CVTSI2SDQ BX, X2			
  0x1400c64d8		f20f5cc2		SUBSD X2, X0				
  0x1400c64dc		f20f10158c0e0100	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X2	
  0x1400c64e4		f20f59d0		MULSD X0, X2				
			c1 := FACTOR_W - c2
  0x1400c64e8		f20f101d800e0100	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X3	
  0x1400c64f0		f20f5cda		SUBSD X2, X3				
			densityE[p] += c1
  0x1400c64f4		f20f581cda		ADDSD 0(DX)(BX*8), X3		
  0x1400c64f9		f20f111cda		MOVSD_XMM X3, 0(DX)(BX*8)	
			densityE[p+1] += c2
  0x1400c64fe		f20f1054da08		MOVSD_XMM 0x8(DX)(BX*8), X2		
  0x1400c6504		f20f101d640e0100	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X3	
  0x1400c650c		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
  0x1400c6511		f20f1154da08		MOVSD_XMM X2, 0x8(DX)(BX*8)		
		for k := start; k < end; k++ {
  0x1400c6517		48ffc0			INCQ AX			
  0x1400c651a		4839c8			CMPQ AX, CX		
  0x1400c651d		7daf			JGE 0x1400c64ce		
  0x1400c651f		90			NOPL			
			c0 := sim.X_e[k] * INV_DX
  0x1400c6520		483d40420f00		CMPQ AX, $0xf4240			
  0x1400c6526		733d			JAE 0x1400c6565				
  0x1400c6528		f20f1084c6d07e5603	MOVSD_XMM 0x3567ed0(SI)(AX*8), X0	
  0x1400c6531		f20f100d0f0e0100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c6539		f20f59c1		MULSD X1, X0				
			p := min(max(int(c0), 0), N_G-2)
  0x1400c653d		f2480f2cd8		CVTTSD2SIQ X0, BX	
  0x1400c6542		4885db			TESTQ BX, BX		
  0x1400c6545		7d02			JGE 0x1400c6549		
  0x1400c6547		31db			XORL BX, BX		
  0x1400c6549		4881fb8e010000		CMPQ BX, $0x18e		
  0x1400c6550		0f8e7affffff		JLE 0x1400c64d0		
  0x1400c6556		bb8e010000		MOVL $0x18e, BX		
  0x1400c655b		0f1f440000		NOPL 0(AX)(AX*1)	
  0x1400c6560		e96bffffff		JMP 0x1400c64d0		
			c0 := sim.X_e[k] * INV_DX
  0x1400c6565		b940420f00		MOVL $0xf4240, CX		
  0x1400c656a		e8117ffbff		CALL runtime.panicBounds(SB)	
	densityE := &sim.WorkerEDensity[workerID]
  0x1400c656f		e80c7ffbff		CALL runtime.panicBounds(SB)	
		chunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c6574		e827cdf7ff		CALL runtime.panicdivide(SB)	
  0x1400c6579		90			NOPL				

  0x1400c657a		cc			INT $0x3		
  0x1400c657b		cc			INT $0x3		
  0x1400c657c		cc			INT $0x3		
  0x1400c657d		cc			INT $0x3		
  0x1400c657e		cc			INT $0x3		
  0x1400c657f		cc			INT $0x3		


// =============================================================================
// SYMBOL: workerComputeIDensity
// =============================================================================

TEXT gopic.(*SimulationState).workerComputeIDensity(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/worker.go
func (sim *SimulationState) workerComputeIDensity(workerID int) {
  0x1400c6580		55			PUSHQ BP		
  0x1400c6581		4889e5			MOVQ SP, BP		
	chunkSize := sim.IChunkSize
  0x1400c6584		8400			TESTB AL, 0(AX)		
  0x1400c6586		488b88602eba07		MOVQ 0x7ba2e60(AX), CX	
	if chunkSize <= 0 {
  0x1400c658d		4885c9			TESTQ CX, CX		
  0x1400c6590		7f42			JG 0x1400c65d4		
		chunkSize = (sim.N_i + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c6592		488b88c87e5603		MOVQ 0x3567ec8(AX), CX	
  0x1400c6599		488b90482eba07		MOVQ 0x7ba2e48(AX), DX	
  0x1400c65a0		488d0c11		LEAQ 0(CX)(DX*1), CX	
  0x1400c65a4		488d49ff		LEAQ -0x1(CX), CX	
  0x1400c65a8		4885d2			TESTQ DX, DX		
  0x1400c65ab		0f8423010000		JE 0x1400c66d4		
	if chunkSize <= 0 {
  0x1400c65b1		4889c6			MOVQ AX, SI		
		chunkSize = (sim.N_i + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c65b4		4889c8			MOVQ CX, AX		
  0x1400c65b7		4889d7			MOVQ DX, DI		
  0x1400c65ba		660f1f440000		NOPW 0(AX)(AX*1)	
  0x1400c65c0		4883ffff		CMPQ DI, $-0x1		
  0x1400c65c4		7507			JNE 0x1400c65cd		
  0x1400c65c6		48f7d8			NEGQ AX			
  0x1400c65c9		31d2			XORL DX, DX		
  0x1400c65cb		eb0d			JMP 0x1400c65da		
  0x1400c65cd		4899			CQO			
  0x1400c65cf		48f7ff			IDIVQ DI		
  0x1400c65d2		eb06			JMP 0x1400c65da		
	if end > sim.N_i {
  0x1400c65d4		4889c6			MOVQ AX, SI		
	start := workerID * chunkSize
  0x1400c65d7		4889c8			MOVQ CX, AX		
  0x1400c65da		4889c1			MOVQ AX, CX		
  0x1400c65dd		480fafc3		IMULQ BX, AX		
	end := start + chunkSize
  0x1400c65e1		4801c1			ADDQ AX, CX		
	if end > sim.N_i {
  0x1400c65e4		488b96c87e5603		MOVQ 0x3567ec8(SI), DX	
	densityI := &sim.WorkerIDensity[workerID]
  0x1400c65eb		488b7e20		MOVQ 0x20(SI), DI	
	if end > sim.N_i {
  0x1400c65ef		4839ca			CMPQ DX, CX		
	densityI := &sim.WorkerIDensity[workerID]
  0x1400c65f2		480f4cca		CMOVL DX, CX		
  0x1400c65f6		4839fb			CMPQ BX, DI		
	if end > sim.N_i {
  0x1400c65f9		0f83d0000000		JAE 0x1400c66cf		
	densityI := &sim.WorkerIDensity[workerID]
  0x1400c65ff		488b5618		MOVQ 0x18(SI), DX	
  0x1400c6603		4869db800c0000		IMULQ $0xc80, BX, BX	
  0x1400c660a		4801da			ADDQ BX, DX		
	for i := 0; i < N_G; i++ {
  0x1400c660d		31db			XORL BX, BX		
  0x1400c660f		eb0f			JMP 0x1400c6620		
		densityI[i] = 0.0
  0x1400c6611		48c704da00000000	MOVQ $0x0, 0(DX)(BX*8)	
	for i := 0; i < N_G; i++ {
  0x1400c6619		48ffc3			INCQ BX			
  0x1400c661c		0f1f4000		NOPL 0(AX)		
  0x1400c6620		4881fb90010000		CMPQ BX, $0x190		
  0x1400c6627		7ce8			JL 0x1400c6611		
	if start < end {
  0x1400c6629		4839c1			CMPQ CX, AX		
  0x1400c662c		7f4c			JG 0x1400c667a		
}
  0x1400c662e		5d			POPQ BP			
  0x1400c662f		c3			RET			
			c2 := (c0 - float64(p)) * FACTOR_W
  0x1400c6630		0f57d2			XORPS X2, X2				
  0x1400c6633		f2480f2ad3		CVTSI2SDQ BX, X2			
  0x1400c6638		f20f5cc2		SUBSD X2, X0				
  0x1400c663c		f20f10152c0d0100	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X2	
  0x1400c6644		f20f59d0		MULSD X0, X2				
			c1 := FACTOR_W - c2
  0x1400c6648		f20f101d200d0100	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X3	
  0x1400c6650		f20f5cda		SUBSD X2, X3				
			densityI[p] += c1
  0x1400c6654		f20f581cda		ADDSD 0(DX)(BX*8), X3		
  0x1400c6659		f20f111cda		MOVSD_XMM X3, 0(DX)(BX*8)	
			densityI[p+1] += c2
  0x1400c665e		f20f1054da08		MOVSD_XMM 0x8(DX)(BX*8), X2		
  0x1400c6664		f20f101d040d0100	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X3	
  0x1400c666c		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
  0x1400c6671		f20f1154da08		MOVSD_XMM X2, 0x8(DX)(BX*8)		
		for k := start; k < end; k++ {
  0x1400c6677		48ffc0			INCQ AX			
  0x1400c667a		4839c8			CMPQ AX, CX		
  0x1400c667d		7daf			JGE 0x1400c662e		
  0x1400c667f		90			NOPL			
			c0 := sim.X_i[k] * INV_DX
  0x1400c6680		483d40420f00		CMPQ AX, $0xf4240			
  0x1400c6686		733d			JAE 0x1400c66c5				
  0x1400c6688		f20f1084c6d0c63e05	MOVSD_XMM 0x53ec6d0(SI)(AX*8), X0	
  0x1400c6691		f20f100daf0c0100	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c6699		f20f59c1		MULSD X1, X0				
			p := min(max(int(c0), 0), N_G-2)
  0x1400c669d		f2480f2cd8		CVTTSD2SIQ X0, BX	
  0x1400c66a2		4885db			TESTQ BX, BX		
  0x1400c66a5		7d02			JGE 0x1400c66a9		
  0x1400c66a7		31db			XORL BX, BX		
  0x1400c66a9		4881fb8e010000		CMPQ BX, $0x18e		
  0x1400c66b0		0f8e7affffff		JLE 0x1400c6630		
  0x1400c66b6		bb8e010000		MOVL $0x18e, BX		
  0x1400c66bb		0f1f440000		NOPL 0(AX)(AX*1)	
  0x1400c66c0		e96bffffff		JMP 0x1400c6630		
			c0 := sim.X_i[k] * INV_DX
  0x1400c66c5		b940420f00		MOVL $0xf4240, CX		
  0x1400c66ca		e8b17dfbff		CALL runtime.panicBounds(SB)	
	densityI := &sim.WorkerIDensity[workerID]
  0x1400c66cf		e8ac7dfbff		CALL runtime.panicBounds(SB)	
		chunkSize = (sim.N_i + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c66d4		e8c7cbf7ff		CALL runtime.panicdivide(SB)	
  0x1400c66d9		90			NOPL				

  0x1400c66da		cc			INT $0x3		
  0x1400c66db		cc			INT $0x3		
  0x1400c66dc		cc			INT $0x3		
  0x1400c66dd		cc			INT $0x3		
  0x1400c66de		cc			INT $0x3		
  0x1400c66df		cc			INT $0x3		


