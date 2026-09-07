// =============================================================================
// SYMBOL: Step7CollisionsElectrons
// =============================================================================

TEXT gopic.(*SimulationState).Step7CollisionsElectrons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/simulation_null.go
func (sim *SimulationState) Step7CollisionsElectrons() {
  0x1400c51e0		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c51e4		0f86af020000		JBE 0x1400c5499		
  0x1400c51ea		55			PUSHQ BP		
  0x1400c51eb		4889e5			MOVQ SP, BP		
  0x1400c51ee		4883ec10		SUBQ $0x10, SP		
	if sim.N_e == 0 {
  0x1400c51f2		8400			TESTB AL, 0(AX)			
  0x1400c51f4		4883b8c07e560300	CMPQ 0x3567ec0(AX), $0x0	
  0x1400c51fc		741a			JE 0x1400c5218			
  0x1400c51fe		4889442420		MOVQ AX, 0x20(SP)		
	sim.broadcastAndWait(CmdCollisionsE)
  0x1400c5203		bb04000000		MOVL $0x4, BX						
  0x1400c5208		e873e6ffff		CALL gopic.(*SimulationState).broadcastAndWait(SB)	
	for w := 0; w < sim.NumWorkers; w++ {
  0x1400c520d		31c9			XORL CX, CX		
  0x1400c520f		31d2			XORL DX, DX		
  0x1400c5211		488b442420		MOVQ 0x20(SP), AX	
  0x1400c5216		eb09			JMP 0x1400c5221		
		return
  0x1400c5218		4883c410		ADDQ $0x10, SP		
  0x1400c521c		5d			POPQ BP			
  0x1400c521d		c3			RET			
	for w := 0; w < sim.NumWorkers; w++ {
  0x1400c521e		48ffc1			INCQ CX			
  0x1400c5221		488b98482eba07		MOVQ 0x7ba2e48(AX), BX	
  0x1400c5228		4839d9			CMPQ CX, BX		
  0x1400c522b		0f8dbe010000		JGE 0x1400c53ef		
		for _, p := range sim.WorkerNewElectrons[w] {
  0x1400c5231		488b9898000000		MOVQ 0x98(AX), BX	
  0x1400c5238		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x1400c5240		4839d9			CMPQ CX, BX		
  0x1400c5243		0f834a020000		JAE 0x1400c5493		
  0x1400c5249		488b9890000000		MOVQ 0x90(AX), BX	
  0x1400c5250		488d3449		LEAQ 0(CX)(CX*2), SI	
  0x1400c5254		488b3cf3		MOVQ 0(BX)(SI*8), DI	
  0x1400c5258		488b5cf308		MOVQ 0x8(BX)(SI*8), BX	
  0x1400c525d		eb21			JMP 0x1400c5280		
			sim.Vz_e[sim.N_e] = p.Vz
  0x1400c525f		f20f1194d0d0b4c404	MOVSD_XMM X2, 0x4c4b4d0(AX)(DX*8)	
			sim.N_e++
  0x1400c5268		48ff80c07e5603		INCQ 0x3567ec0(AX)	
		for _, p := range sim.WorkerNewElectrons[w] {
  0x1400c526f		4883c720		ADDQ $0x20, DI		
  0x1400c5273		48ffcb			DECQ BX			
  0x1400c5276		ba01000000		MOVL $0x1, DX		
  0x1400c527b		0f1f440000		NOPL 0(AX)(AX*1)	
  0x1400c5280		4885db			TESTQ BX, BX		
  0x1400c5283		0f8e89000000		JLE 0x1400c5312		
			sim.X_e[sim.N_e] = p.X
  0x1400c5289		488b90c07e5603		MOVQ 0x3567ec0(AX), DX	
		for _, p := range sim.WorkerNewElectrons[w] {
  0x1400c5290		f20f104708		MOVSD_XMM 0x8(DI), X0	
  0x1400c5295		f20f104f10		MOVSD_XMM 0x10(DI), X1	
  0x1400c529a		f20f105718		MOVSD_XMM 0x18(DI), X2	
  0x1400c529f		90			NOPL			
			sim.X_e[sim.N_e] = p.X
  0x1400c52a0		4881fa40420f00		CMPQ DX, $0xf4240	
  0x1400c52a7		0f83dc010000		JAE 0x1400c5489		
		for _, p := range sim.WorkerNewElectrons[w] {
  0x1400c52ad		f20f101f		MOVSD_XMM 0(DI), X3	
			sim.X_e[sim.N_e] = p.X
  0x1400c52b1		f20f119cd0d07e5603	MOVSD_XMM X3, 0x3567ed0(AX)(DX*8)	
			sim.Vx_e[sim.N_e] = p.Vx
  0x1400c52ba		488b90c07e5603		MOVQ 0x3567ec0(AX), DX			
  0x1400c52c1		4881fa40420f00		CMPQ DX, $0xf4240			
  0x1400c52c8		0f83b1010000		JAE 0x1400c547f				
  0x1400c52ce		f20f1184d0d090d003	MOVSD_XMM X0, 0x3d090d0(AX)(DX*8)	
			sim.Vy_e[sim.N_e] = p.Vy
  0x1400c52d7		488b90c07e5603		MOVQ 0x3567ec0(AX), DX			
  0x1400c52de		6690			NOPW					
  0x1400c52e0		4881fa40420f00		CMPQ DX, $0xf4240			
  0x1400c52e7		0f8388010000		JAE 0x1400c5475				
  0x1400c52ed		f20f118cd0d0a24a04	MOVSD_XMM X1, 0x44aa2d0(AX)(DX*8)	
			sim.Vz_e[sim.N_e] = p.Vz
  0x1400c52f6		488b90c07e5603		MOVQ 0x3567ec0(AX), DX	
  0x1400c52fd		0f1f00			NOPL 0(AX)		
  0x1400c5300		4881fa40420f00		CMPQ DX, $0xf4240	
  0x1400c5307		0f8252ffffff		JB 0x1400c525f		
  0x1400c530d		e959010000		JMP 0x1400c546b		
		for _, p := range sim.WorkerNewIons[w] {
  0x1400c5312		488b98b0000000		MOVQ 0xb0(AX), BX	
  0x1400c5319		0f1f8000000000		NOPL 0(AX)		
  0x1400c5320		4839d9			CMPQ CX, BX		
  0x1400c5323		0f833d010000		JAE 0x1400c5466		
  0x1400c5329		488b98a8000000		MOVQ 0xa8(AX), BX	
  0x1400c5330		488b3cf3		MOVQ 0(BX)(SI*8), DI	
  0x1400c5334		488b5cf308		MOVQ 0x8(BX)(SI*8), BX	
  0x1400c5339		eb25			JMP 0x1400c5360		
			sim.Vz_i[sim.N_i] = p.Vz
  0x1400c533b		f20f1194d0d0fcac06	MOVSD_XMM X2, 0x6acfcd0(AX)(DX*8)	
			sim.N_i++
  0x1400c5344		48ff80c87e5603		INCQ 0x3567ec8(AX)	
		for _, p := range sim.WorkerNewIons[w] {
  0x1400c534b		4883c720		ADDQ $0x20, DI		
  0x1400c534f		48ffcb			DECQ BX			
  0x1400c5352		ba01000000		MOVL $0x1, DX		
  0x1400c5357		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x1400c5360		4885db			TESTQ BX, BX		
  0x1400c5363		0f8eb5feffff		JLE 0x1400c521e		
			sim.X_i[sim.N_i] = p.X
  0x1400c5369		488b90c87e5603		MOVQ 0x3567ec8(AX), DX	
		for _, p := range sim.WorkerNewIons[w] {
  0x1400c5370		f20f104708		MOVSD_XMM 0x8(DI), X0	
  0x1400c5375		f20f104f10		MOVSD_XMM 0x10(DI), X1	
  0x1400c537a		f20f105718		MOVSD_XMM 0x18(DI), X2	
  0x1400c537f		90			NOPL			
			sim.X_i[sim.N_i] = p.X
  0x1400c5380		4881fa40420f00		CMPQ DX, $0xf4240	
  0x1400c5387		0f83cf000000		JAE 0x1400c545c		
		for _, p := range sim.WorkerNewIons[w] {
  0x1400c538d		f20f101f		MOVSD_XMM 0(DI), X3	
			sim.X_i[sim.N_i] = p.X
  0x1400c5391		f20f119cd0d0c63e05	MOVSD_XMM X3, 0x53ec6d0(AX)(DX*8)	
			sim.Vx_i[sim.N_i] = p.Vx
  0x1400c539a		488b90c87e5603		MOVQ 0x3567ec8(AX), DX			
  0x1400c53a1		4881fa40420f00		CMPQ DX, $0xf4240			
  0x1400c53a8		0f83a4000000		JAE 0x1400c5452				
  0x1400c53ae		f20f1184d0d0d8b805	MOVSD_XMM X0, 0x5b8d8d0(AX)(DX*8)	
			sim.Vy_i[sim.N_i] = p.Vy
  0x1400c53b7		488b90c87e5603		MOVQ 0x3567ec8(AX), DX			
  0x1400c53be		6690			NOPW					
  0x1400c53c0		4881fa40420f00		CMPQ DX, $0xf4240			
  0x1400c53c7		737f			JAE 0x1400c5448				
  0x1400c53c9		f20f118cd0d0ea3206	MOVSD_XMM X1, 0x632ead0(AX)(DX*8)	
			sim.Vz_i[sim.N_i] = p.Vz
  0x1400c53d2		488b90c87e5603		MOVQ 0x3567ec8(AX), DX	
  0x1400c53d9		0f1f8000000000		NOPL 0(AX)		
  0x1400c53e0		4881fa40420f00		CMPQ DX, $0xf4240	
  0x1400c53e7		0f824effffff		JB 0x1400c533b		
  0x1400c53ed		eb4f			JMP 0x1400c543e		
	for w := 0; w < sim.NumWorkers; w++ {
  0x1400c53ef		84d2			TESTL DL, DL		
	if created {
  0x1400c53f1		7445			JE 0x1400c5438		
		sim.UpdateChunkSizes()
  0x1400c53f3		90			NOPL			
	if sim.NumWorkers > 0 {
  0x1400c53f4		4885db			TESTQ BX, BX		
  0x1400c53f7		7e3f			JLE 0x1400c5438		
		sim.EChunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c53f9		488b88c07e5603		MOVQ 0x3567ec0(AX), CX	
  0x1400c5400		488d0c19		LEAQ 0(CX)(BX*1), CX	
  0x1400c5404		488d49ff		LEAQ -0x1(CX), CX	
	if sim.N_e == 0 {
  0x1400c5408		4889c2			MOVQ AX, DX		
		sim.EChunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c540b		4889c8			MOVQ CX, AX		
	if sim.N_e == 0 {
  0x1400c540e		4889d1			MOVQ DX, CX		
		sim.EChunkSize = (sim.N_e + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c5411		4899			CQO			
  0x1400c5413		48f7fb			IDIVQ BX		
  0x1400c5416		488981582eba07		MOVQ AX, 0x7ba2e58(CX)	
		sim.IChunkSize = (sim.N_i + sim.NumWorkers - 1) / sim.NumWorkers
  0x1400c541d		488b91c87e5603		MOVQ 0x3567ec8(CX), DX	
  0x1400c5424		488d041a		LEAQ 0(DX)(BX*1), AX	
  0x1400c5428		488d40ff		LEAQ -0x1(AX), AX	
  0x1400c542c		4899			CQO			
  0x1400c542e		48f7fb			IDIVQ BX		
  0x1400c5431		488981602eba07		MOVQ AX, 0x7ba2e60(CX)	
}
  0x1400c5438		4883c410		ADDQ $0x10, SP		
  0x1400c543c		5d			POPQ BP			
  0x1400c543d		c3			RET			
			sim.Vz_i[sim.N_i] = p.Vz
  0x1400c543e		b840420f00		MOVL $0xf4240, AX		
  0x1400c5443		e83890fbff		CALL runtime.panicBounds(SB)	
			sim.Vy_i[sim.N_i] = p.Vy
  0x1400c5448		b840420f00		MOVL $0xf4240, AX		
  0x1400c544d		e82e90fbff		CALL runtime.panicBounds(SB)	
			sim.Vx_i[sim.N_i] = p.Vx
  0x1400c5452		b840420f00		MOVL $0xf4240, AX		
  0x1400c5457		e82490fbff		CALL runtime.panicBounds(SB)	
			sim.X_i[sim.N_i] = p.X
  0x1400c545c		b840420f00		MOVL $0xf4240, AX		
  0x1400c5461		e81a90fbff		CALL runtime.panicBounds(SB)	
		for _, p := range sim.WorkerNewIons[w] {
  0x1400c5466		e81590fbff		CALL runtime.panicBounds(SB)	
			sim.Vz_e[sim.N_e] = p.Vz
  0x1400c546b		b840420f00		MOVL $0xf4240, AX		
  0x1400c5470		e80b90fbff		CALL runtime.panicBounds(SB)	
			sim.Vy_e[sim.N_e] = p.Vy
  0x1400c5475		b840420f00		MOVL $0xf4240, AX		
  0x1400c547a		e80190fbff		CALL runtime.panicBounds(SB)	
			sim.Vx_e[sim.N_e] = p.Vx
  0x1400c547f		b840420f00		MOVL $0xf4240, AX		
  0x1400c5484		e8f78ffbff		CALL runtime.panicBounds(SB)	
			sim.X_e[sim.N_e] = p.X
  0x1400c5489		b840420f00		MOVL $0xf4240, AX		
  0x1400c548e		e8ed8ffbff		CALL runtime.panicBounds(SB)	
		for _, p := range sim.WorkerNewElectrons[w] {
  0x1400c5493		e8e88ffbff		CALL runtime.panicBounds(SB)	
  0x1400c5498		90			NOPL				
func (sim *SimulationState) Step7CollisionsElectrons() {
  0x1400c5499		4889442408		MOVQ AX, 0x8(SP)						
  0x1400c549e		6690			NOPW								
  0x1400c54a0		e89b71fbff		CALL runtime.morestack_noctxt.abi0(SB)				
  0x1400c54a5		488b442408		MOVQ 0x8(SP), AX						
  0x1400c54aa		e931fdffff		JMP gopic.(*SimulationState).Step7CollisionsElectrons(SB)	

  0x1400c54af		cc			INT $0x3		
  0x1400c54b0		cc			INT $0x3		
  0x1400c54b1		cc			INT $0x3		
  0x1400c54b2		cc			INT $0x3		
  0x1400c54b3		cc			INT $0x3		
  0x1400c54b4		cc			INT $0x3		
  0x1400c54b5		cc			INT $0x3		
  0x1400c54b6		cc			INT $0x3		
  0x1400c54b7		cc			INT $0x3		
  0x1400c54b8		cc			INT $0x3		
  0x1400c54b9		cc			INT $0x3		
  0x1400c54ba		cc			INT $0x3		
  0x1400c54bb		cc			INT $0x3		
  0x1400c54bc		cc			INT $0x3		
  0x1400c54bd		cc			INT $0x3		
  0x1400c54be		cc			INT $0x3		
  0x1400c54bf		cc			INT $0x3		


// =============================================================================
// SYMBOL: workerSampleBinomial
// =============================================================================

TEXT gopic.(*SimulationState).workerSampleBinomial(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/simulation_null.go
func (sim *SimulationState) workerSampleBinomial(workerID, n int, p float64) int {
  0x1400c4fa0		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c4fa4		0f86fc010000		JBE 0x1400c51a6		
  0x1400c4faa		55			PUSHQ BP		
  0x1400c4fab		4889e5			MOVQ SP, BP		
  0x1400c4fae		4883ec30		SUBQ $0x30, SP		
	if n <= 0 || p <= 0.0 {
  0x1400c4fb2		4885c9			TESTQ CX, CX		
  0x1400c4fb5		0f8e64010000		JLE 0x1400c511f		
  0x1400c4fbb		0f57c9			XORPS X1, X1		
  0x1400c4fbe		660f2ec8		UCOMISD X0, X1		
  0x1400c4fc2		0f8357010000		JAE 0x1400c511f		
	if p >= 1.0 {
  0x1400c4fc8		f20f100d88220100	MOVSD_XMM $f64.3ff0000000000000(SB), X1	
  0x1400c4fd0		660f2ec1		UCOMISD X1, X0				
  0x1400c4fd4		0f833c010000		JAE 0x1400c5116				
	rng := sim.RngWorkers[workerID]
  0x1400c4fda		8400			TESTB AL, 0(AX)		
  0x1400c4fdc		488b90f02dba07		MOVQ 0x7ba2df0(AX), DX	
  0x1400c4fe3		4839d3			CMPQ BX, DX		
  0x1400c4fe6		0f83b3010000		JAE 0x1400c519f		
	if n <= 0 || p <= 0.0 {
  0x1400c4fec		f20f11442458		MOVSD_XMM X0, 0x58(SP)	
	rng := sim.RngWorkers[workerID]
  0x1400c4ff2		488b90e82dba07		MOVQ 0x7ba2de8(AX), DX	
	if float64(n)*p < 5.0 {
  0x1400c4ff9		0f57d2			XORPS X2, X2		
  0x1400c4ffc		f2480f2ad1		CVTSI2SDQ CX, X2	
  0x1400c5001		0f10d8			MOVUPS X0, X3		
  0x1400c5004		f20f59c2		MULSD X2, X0		
	rng := sim.RngWorkers[workerID]
  0x1400c5008		488b04da		MOVQ 0(DX)(BX*8), AX	
	if float64(n)*p < 5.0 {
  0x1400c500c		f20f1025a4220100	MOVSD_XMM $f64.4014000000000000(SB), X4	
  0x1400c5014		660f2ee0		UCOMISD X0, X4				
  0x1400c5018		760c			JBE 0x1400c5026				
	rng := sim.RngWorkers[workerID]
  0x1400c501a		4889442428		MOVQ AX, 0x28(SP)	
  0x1400c501f		31d2			XORL DX, DX		
	if float64(n)*p < 5.0 {
  0x1400c5021		e927010000		JMP 0x1400c514d		
	if n <= 0 || p <= 0.0 {
  0x1400c5026		48894c2450		MOVQ CX, 0x50(SP)	
	if float64(n)*p < 5.0 {
  0x1400c502b		f20f11542420		MOVSD_XMM X2, 0x20(SP)	
	sigma := math.Sqrt(float64(n) * p * (1.0 - p))
  0x1400c5031		f20f5ccb		SUBSD X3, X1		
  0x1400c5035		f20f59c8		MULSD X0, X1		
	return sqrt(x)
  0x1400c5039		f20f51c1		SQRTSD X1, X0		
  0x1400c503d		f20f11442408		MOVSD_XMM X0, 0x8(SP)	
	count := int(math.Round(mu + sigma*rng.NormFloat64()))
  0x1400c5043		e8d883ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x1400c5048		f20f104c2408		MOVSD_XMM 0x8(SP), X1			
  0x1400c504e		f20f59c8		MULSD X0, X1				
  0x1400c5052		f20f10442458		MOVSD_XMM 0x58(SP), X0			
  0x1400c5058		f20f10542420		MOVSD_XMM 0x20(SP), X2			
  0x1400c505e		c4e2f9b9ca		VFMADD231SD X2, X0, X1			
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x1400c5063		66480f7ec9		MOVQ X1, CX		
	e := uint(bits>>shift) & mask
  0x1400c5068		4889ca			MOVQ CX, DX		
  0x1400c506b		48c1e934		SHRQ $0x34, CX		
  0x1400c506f		81e1ff070000		ANDL $0x7ff, CX		
	bits := Float64bits(x)
  0x1400c5075		90			NOPL			
	if e < bias {
  0x1400c5076		4881f9ff030000		CMPQ CX, $0x3ff		
  0x1400c507d		732a			JAE 0x1400c50a9		
		bits &= signMask // +-0
  0x1400c507f		48bb0000000000000080	MOVQ $0x8000000000000000, BX	
  0x1400c5089		4821d3			ANDQ DX, BX			
			bits |= uvone // +-1
  0x1400c508c		48ba000000000000f03f	MOVQ $0x3ff0000000000000, DX	
  0x1400c5096		4809da			ORQ BX, DX			
		if e == bias-1 {
  0x1400c5099		4881f9fe030000		CMPQ CX, $0x3fe		
  0x1400c50a0		480f44da		CMOVE DX, BX		
	count := int(math.Round(mu + sigma*rng.NormFloat64()))
  0x1400c50a4		4889d9			MOVQ BX, CX		
		if e == bias-1 {
  0x1400c50a7		eb3c			JMP 0x1400c50e5		
	} else if e < bias+shift {
  0x1400c50a9		4881f933040000		CMPQ CX, $0x433		
  0x1400c50b0		7330			JAE 0x1400c50e2		
		e -= bias
  0x1400c50b2		488d9901fcffff		LEAQ 0xfffffc01(CX), BX	
		bits += half >> e
  0x1400c50b9		48be0000000000000800	MOVQ $0x8000000000000, SI	
  0x1400c50c3		c4			?				
  0x1400c50c4		e2e3			LOOP 0x1400c50a9		
  0x1400c50c6		f7f6			DIVL SI				
  0x1400c50c8		4801f2			ADDQ SI, DX			
		bits &^= fracMask >> e
  0x1400c50cb		48beffffffffffff0f00	MOVQ $0xfffffffffffff, SI	
  0x1400c50d5		c4			?				
  0x1400c50d6		e2e3			LOOP 0x1400c50bb		
  0x1400c50d8		f7de			NEGL SI				
  0x1400c50da		c4			?				
  0x1400c50db		e2e0			LOOP 0x1400c50bd		
  0x1400c50dd		f2ca90eb		REPNE; LRET $0xeb90		
  0x1400c50e1		034889			ADDL -0x77(AX), CX		
  0x1400c50e4		d16648			SHLL $0x1, 0x48(SI)		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x1400c50e7		0f6ec1			MOVD CX, M0		
	count := int(math.Round(mu + sigma*rng.NormFloat64()))
  0x1400c50ea		f2480f2cc0		CVTTSD2SIQ X0, AX	
	return Float64frombits(bits)
  0x1400c50ef		90			NOPL			
	if count < 0 {
  0x1400c50f0		4885c0			TESTQ AX, AX		
  0x1400c50f3		7c19			JL 0x1400c510e		
	if count > n {
  0x1400c50f5		488b4c2450		MOVQ 0x50(SP), CX	
  0x1400c50fa		4839c1			CMPQ CX, AX		
  0x1400c50fd		7d09			JGE 0x1400c5108		
		return n
  0x1400c50ff		4889c8			MOVQ CX, AX		
  0x1400c5102		4883c430		ADDQ $0x30, SP		
  0x1400c5106		5d			POPQ BP			
  0x1400c5107		c3			RET			
	return count
  0x1400c5108		4883c430		ADDQ $0x30, SP		
  0x1400c510c		5d			POPQ BP			
  0x1400c510d		c3			RET			
		return 0
  0x1400c510e		31c0			XORL AX, AX		
  0x1400c5110		4883c430		ADDQ $0x30, SP		
  0x1400c5114		5d			POPQ BP			
  0x1400c5115		c3			RET			
		return n
  0x1400c5116		4889c8			MOVQ CX, AX		
  0x1400c5119		4883c430		ADDQ $0x30, SP		
  0x1400c511d		5d			POPQ BP			
  0x1400c511e		c3			RET			
		return 0
  0x1400c511f		31c0			XORL AX, AX		
  0x1400c5121		4883c430		ADDQ $0x30, SP		
  0x1400c5125		5d			POPQ BP			
  0x1400c5126		c3			RET			
			if rng.Float64() < p {
  0x1400c5127		f20f105c2458		MOVSD_XMM 0x58(SP), X3	
  0x1400c512d		660f2ed9		UCOMISD X1, X3		
  0x1400c5131		0f97c3			SETA BL			
  0x1400c5134		0fb6db			MOVZX BL, BX		
  0x1400c5137		488b742418		MOVQ 0x18(SP), SI	
  0x1400c513c		488d141e		LEAQ 0(SI)(BX*1), DX	
		for i := 0; i < n; i++ {
  0x1400c5140		488b4c2410		MOVQ 0x10(SP), CX	
  0x1400c5145		48ffc9			DECQ CX			
func (r *Rand) Int63() int64 { return r.src.Int63() }
  0x1400c5148		488b442428		MOVQ 0x28(SP), AX	
		for i := 0; i < n; i++ {
  0x1400c514d		4885c9			TESTQ CX, CX		
  0x1400c5150		7e44			JLE 0x1400c5196		
  0x1400c5152		48894c2410		MOVQ CX, 0x10(SP)	
  0x1400c5157		4889542418		MOVQ DX, 0x18(SP)	
again:
  0x1400c515c		eb05			JMP 0x1400c5163		
func (r *Rand) Int63() int64 { return r.src.Int63() }
  0x1400c515e		488b442428		MOVQ 0x28(SP), AX	
  0x1400c5163		488b08			MOVQ 0(AX), CX		
  0x1400c5166		488b4008		MOVQ 0x8(AX), AX	
  0x1400c516a		488b4918		MOVQ 0x18(CX), CX	
  0x1400c516e		ffd1			CALL CX			
	f := float64(r.Int63()) / (1 << 63)
  0x1400c5170		0f57c0			XORPS X0, X0				
  0x1400c5173		f2480f2ac0		CVTSI2SDQ AX, X0			
  0x1400c5178		f20f100dd01f0100	MOVSD_XMM $f64.3c00000000000000(SB), X1	
  0x1400c5180		f20f59c8		MULSD X0, X1				
	if f == 1 {
  0x1400c5184		f20f1005cc200100	MOVSD_XMM $f64.3ff0000000000000(SB), X0	
  0x1400c518c		660f2ec8		UCOMISD X0, X1				
  0x1400c5190		7595			JNE 0x1400c5127				
  0x1400c5192		7bca			JNP 0x1400c515e				
  0x1400c5194		eb91			JMP 0x1400c5127				
		return count
  0x1400c5196		4889d0			MOVQ DX, AX		
  0x1400c5199		4883c430		ADDQ $0x30, SP		
  0x1400c519d		5d			POPQ BP			
  0x1400c519e		c3			RET			
	rng := sim.RngWorkers[workerID]
  0x1400c519f		90			NOPL				
  0x1400c51a0		e8db92fbff		CALL runtime.panicBounds(SB)	
  0x1400c51a5		90			NOPL				
func (sim *SimulationState) workerSampleBinomial(workerID, n int, p float64) int {
  0x1400c51a6		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c51ab		48895c2410		MOVQ BX, 0x10(SP)					
  0x1400c51b0		48894c2418		MOVQ CX, 0x18(SP)					
  0x1400c51b5		f20f11442420		MOVSD_XMM X0, 0x20(SP)					
  0x1400c51bb		0f1f440000		NOPL 0(AX)(AX*1)					
  0x1400c51c0		e87b74fbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c51c5		488b442408		MOVQ 0x8(SP), AX					
  0x1400c51ca		488b5c2410		MOVQ 0x10(SP), BX					
  0x1400c51cf		488b4c2418		MOVQ 0x18(SP), CX					
  0x1400c51d4		f20f10442420		MOVSD_XMM 0x20(SP), X0					
  0x1400c51da		e9c1fdffff		JMP gopic.(*SimulationState).workerSampleBinomial(SB)	

  0x1400c51df		cc			INT $0x3		


