// =============================================================================
// SYMBOL: Step7CollisionsElectrons
// =============================================================================

TEXT gopic.(*SimulationState).Step7CollisionsElectrons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation_null.go
func (sim *SimulationState) Step7CollisionsElectrons() {
  0x1400c4b60		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c4b64		0f86b3020000		JBE 0x1400c4e1d		
  0x1400c4b6a		55			PUSHQ BP		
  0x1400c4b6b		4889e5			MOVQ SP, BP		
  0x1400c4b6e		4883ec28		SUBQ $0x28, SP		
	if sim.N_e == 0 {
  0x1400c4b72		8400			TESTB AL, 0(AX)			
  0x1400c4b74		4883b8c07e560300	CMPQ 0x3567ec0(AX), $0x0	
  0x1400c4b7c		7416			JE 0x1400c4b94			
  0x1400c4b7e		4889442438		MOVQ AX, 0x38(SP)		
	sim.broadcastAndWait(CmdCollisionsE)
  0x1400c4b83		90			NOPL			
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c4b84		488b88582eba07		MOVQ 0x7ba2e58(AX), CX	
  0x1400c4b8b		48894c2420		MOVQ CX, 0x20(SP)	
  0x1400c4b90		31d2			XORL DX, DX		
	for w := range numWorkers {
  0x1400c4b92		eb32			JMP 0x1400c4bc6		
		return
  0x1400c4b94		4883c428		ADDQ $0x28, SP		
  0x1400c4b98		5d			POPQ BP			
  0x1400c4b99		c3			RET			
	for w := range numWorkers {
  0x1400c4b9a		4889542410		MOVQ DX, 0x10(SP)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c4b9f		488b88502eba07		MOVQ 0x7ba2e50(AX), CX		
  0x1400c4ba6		488b04d1		MOVQ 0(CX)(DX*8), AX		
  0x1400c4baa		488d5c2418		LEAQ 0x18(SP), BX		
  0x1400c4baf		e84cbbf4ff		CALL runtime.chansend1(SB)	
	for w := range numWorkers {
  0x1400c4bb4		488b542410		MOVQ 0x10(SP), DX	
  0x1400c4bb9		48ffc2			INCQ DX			
		sim.WorkerCmdChan[w] <- cmd
  0x1400c4bbc		488b442438		MOVQ 0x38(SP), AX	
	for w := range numWorkers {
  0x1400c4bc1		488b4c2420		MOVQ 0x20(SP), CX	
  0x1400c4bc6		4839ca			CMPQ DX, CX		
  0x1400c4bc9		7d3f			JGE 0x1400c4c0a		
		sim.WorkerCmdChan[w] <- cmd
  0x1400c4bcb		48c744241806000000	MOVQ $0x6, 0x18(SP)	
  0x1400c4bd4		488bb0582eba07		MOVQ 0x7ba2e58(AX), SI	
  0x1400c4bdb		0f1f440000		NOPL 0(AX)(AX*1)	
  0x1400c4be0		4839f2			CMPQ DX, SI		
  0x1400c4be3		72b5			JB 0x1400c4b9a		
  0x1400c4be5		e92d020000		JMP 0x1400c4e17		
	for range numWorkers {
  0x1400c4bea		48894c2420		MOVQ CX, 0x20(SP)	
		<-sim.WorkerDoneChan
  0x1400c4bef		488b80682eba07		MOVQ 0x7ba2e68(AX), AX		
  0x1400c4bf6		31db			XORL BX, BX			
  0x1400c4bf8		e883c9f4ff		CALL runtime.chanrecv1(SB)	
	for range numWorkers {
  0x1400c4bfd		488b4c2420		MOVQ 0x20(SP), CX	
  0x1400c4c02		48ffc9			DECQ CX			
		<-sim.WorkerDoneChan
  0x1400c4c05		488b442438		MOVQ 0x38(SP), AX	
	for range numWorkers {
  0x1400c4c0a		4885c9			TESTQ CX, CX		
  0x1400c4c0d		7fdb			JG 0x1400c4bea		
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c4c0f		488b88582eba07		MOVQ 0x7ba2e58(AX), CX	
	for w := 0; w < numWorkers; w++ {
  0x1400c4c16		31d2			XORL DX, DX		
  0x1400c4c18		eb06			JMP 0x1400c4c20		
  0x1400c4c1a		48ffc2			INCQ DX			
  0x1400c4c1d		0f1f00			NOPL 0(AX)		
  0x1400c4c20		4839ca			CMPQ DX, CX		
  0x1400c4c23		0f8d8a010000		JGE 0x1400c4db3		
		for _, p := range sim.WorkerNewElectrons[w] {
  0x1400c4c29		488b9898000000		MOVQ 0x98(AX), BX	
  0x1400c4c30		4839da			CMPQ DX, BX		
  0x1400c4c33		0f83d9010000		JAE 0x1400c4e12		
  0x1400c4c39		488b9890000000		MOVQ 0x90(AX), BX	
  0x1400c4c40		488d3452		LEAQ 0(DX)(DX*2), SI	
  0x1400c4c44		488b3cf3		MOVQ 0(BX)(SI*8), DI	
  0x1400c4c48		488b5cf308		MOVQ 0x8(BX)(SI*8), BX	
  0x1400c4c4d		eb18			JMP 0x1400c4c67		
			sim.Vz_e[sim.N_e] = p.Vz
  0x1400c4c4f		f2420f1194c0d0b4c404	MOVSD_XMM X2, 0x4c4b4d0(AX)(R8*8)	
			sim.N_e++
  0x1400c4c59		48ff80c07e5603		INCQ 0x3567ec0(AX)	
		for _, p := range sim.WorkerNewElectrons[w] {
  0x1400c4c60		4883c720		ADDQ $0x20, DI		
  0x1400c4c64		48ffcb			DECQ BX			
  0x1400c4c67		4885db			TESTQ BX, BX		
  0x1400c4c6a		0f8e86000000		JLE 0x1400c4cf6		
			sim.X_e[sim.N_e] = p.X
  0x1400c4c70		4c8b80c07e5603		MOVQ 0x3567ec0(AX), R8	
		for _, p := range sim.WorkerNewElectrons[w] {
  0x1400c4c77		f20f104708		MOVSD_XMM 0x8(DI), X0	
  0x1400c4c7c		f20f104f10		MOVSD_XMM 0x10(DI), X1	
  0x1400c4c81		f20f105718		MOVSD_XMM 0x18(DI), X2	
			sim.X_e[sim.N_e] = p.X
  0x1400c4c86		4981f840420f00		CMPQ R8, $0xf4240	
  0x1400c4c8d		0f8375010000		JAE 0x1400c4e08		
		for _, p := range sim.WorkerNewElectrons[w] {
  0x1400c4c93		f20f101f		MOVSD_XMM 0(DI), X3	
			sim.X_e[sim.N_e] = p.X
  0x1400c4c97		f2420f119cc0d07e5603	MOVSD_XMM X3, 0x3567ed0(AX)(R8*8)	
			sim.Vx_e[sim.N_e] = p.Vx
  0x1400c4ca1		4c8b80c07e5603		MOVQ 0x3567ec0(AX), R8			
  0x1400c4ca8		4981f840420f00		CMPQ R8, $0xf4240			
  0x1400c4caf		0f8349010000		JAE 0x1400c4dfe				
  0x1400c4cb5		f2420f1184c0d090d003	MOVSD_XMM X0, 0x3d090d0(AX)(R8*8)	
			sim.Vy_e[sim.N_e] = p.Vy
  0x1400c4cbf		4c8b80c07e5603		MOVQ 0x3567ec0(AX), R8			
  0x1400c4cc6		4981f840420f00		CMPQ R8, $0xf4240			
  0x1400c4ccd		0f8321010000		JAE 0x1400c4df4				
  0x1400c4cd3		f2420f118cc0d0a24a04	MOVSD_XMM X1, 0x44aa2d0(AX)(R8*8)	
			sim.Vz_e[sim.N_e] = p.Vz
  0x1400c4cdd		4c8b80c07e5603		MOVQ 0x3567ec0(AX), R8	
  0x1400c4ce4		4981f840420f00		CMPQ R8, $0xf4240	
  0x1400c4ceb		0f825effffff		JB 0x1400c4c4f		
  0x1400c4cf1		e9f4000000		JMP 0x1400c4dea		
		for _, p := range sim.WorkerNewIons[w] {
  0x1400c4cf6		488b98b0000000		MOVQ 0xb0(AX), BX	
  0x1400c4cfd		0f1f00			NOPL 0(AX)		
  0x1400c4d00		4839da			CMPQ DX, BX		
  0x1400c4d03		0f83dc000000		JAE 0x1400c4de5		
  0x1400c4d09		488b98a8000000		MOVQ 0xa8(AX), BX	
  0x1400c4d10		488b3cf3		MOVQ 0(BX)(SI*8), DI	
  0x1400c4d14		488b5cf308		MOVQ 0x8(BX)(SI*8), BX	
  0x1400c4d19		eb17			JMP 0x1400c4d32		
			sim.Vz_i[sim.N_i] = p.Vz
  0x1400c4d1b		f20f1194f0d0fcac06	MOVSD_XMM X2, 0x6acfcd0(AX)(SI*8)	
			sim.N_i++
  0x1400c4d24		48ff80c87e5603		INCQ 0x3567ec8(AX)	
		for _, p := range sim.WorkerNewIons[w] {
  0x1400c4d2b		4883c720		ADDQ $0x20, DI		
  0x1400c4d2f		48ffcb			DECQ BX			
  0x1400c4d32		4885db			TESTQ BX, BX		
  0x1400c4d35		0f8edffeffff		JLE 0x1400c4c1a		
			sim.X_i[sim.N_i] = p.X
  0x1400c4d3b		488bb0c87e5603		MOVQ 0x3567ec8(AX), SI	
		for _, p := range sim.WorkerNewIons[w] {
  0x1400c4d42		f20f104708		MOVSD_XMM 0x8(DI), X0	
  0x1400c4d47		f20f104f10		MOVSD_XMM 0x10(DI), X1	
  0x1400c4d4c		f20f105718		MOVSD_XMM 0x18(DI), X2	
			sim.X_i[sim.N_i] = p.X
  0x1400c4d51		4881fe40420f00		CMPQ SI, $0xf4240	
  0x1400c4d58		0f837b000000		JAE 0x1400c4dd9		
		for _, p := range sim.WorkerNewIons[w] {
  0x1400c4d5e		f20f101f		MOVSD_XMM 0(DI), X3	
			sim.X_i[sim.N_i] = p.X
  0x1400c4d62		f20f119cf0d0c63e05	MOVSD_XMM X3, 0x53ec6d0(AX)(SI*8)	
			sim.Vx_i[sim.N_i] = p.Vx
  0x1400c4d6b		488bb0c87e5603		MOVQ 0x3567ec8(AX), SI			
  0x1400c4d72		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c4d79		7354			JAE 0x1400c4dcf				
  0x1400c4d7b		f20f1184f0d0d8b805	MOVSD_XMM X0, 0x5b8d8d0(AX)(SI*8)	
			sim.Vy_i[sim.N_i] = p.Vy
  0x1400c4d84		488bb0c87e5603		MOVQ 0x3567ec8(AX), SI			
  0x1400c4d8b		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c4d92		7331			JAE 0x1400c4dc5				
  0x1400c4d94		f20f118cf0d0ea3206	MOVSD_XMM X1, 0x632ead0(AX)(SI*8)	
			sim.Vz_i[sim.N_i] = p.Vz
  0x1400c4d9d		488bb0c87e5603		MOVQ 0x3567ec8(AX), SI	
  0x1400c4da4		4881fe40420f00		CMPQ SI, $0xf4240	
  0x1400c4dab		0f826affffff		JB 0x1400c4d1b		
  0x1400c4db1		eb06			JMP 0x1400c4db9		
}
  0x1400c4db3		4883c428		ADDQ $0x28, SP		
  0x1400c4db7		5d			POPQ BP			
  0x1400c4db8		c3			RET			
			sim.Vz_i[sim.N_i] = p.Vz
  0x1400c4db9		b840420f00		MOVL $0xf4240, AX		
  0x1400c4dbe		6690			NOPW				
  0x1400c4dc0		e8bb96fbff		CALL runtime.panicBounds(SB)	
			sim.Vy_i[sim.N_i] = p.Vy
  0x1400c4dc5		b840420f00		MOVL $0xf4240, AX		
  0x1400c4dca		e8b196fbff		CALL runtime.panicBounds(SB)	
			sim.Vx_i[sim.N_i] = p.Vx
  0x1400c4dcf		b840420f00		MOVL $0xf4240, AX		
  0x1400c4dd4		e8a796fbff		CALL runtime.panicBounds(SB)	
			sim.X_i[sim.N_i] = p.X
  0x1400c4dd9		b840420f00		MOVL $0xf4240, AX		
  0x1400c4dde		6690			NOPW				
  0x1400c4de0		e89b96fbff		CALL runtime.panicBounds(SB)	
		for _, p := range sim.WorkerNewIons[w] {
  0x1400c4de5		e89696fbff		CALL runtime.panicBounds(SB)	
			sim.Vz_e[sim.N_e] = p.Vz
  0x1400c4dea		b840420f00		MOVL $0xf4240, AX		
  0x1400c4def		e88c96fbff		CALL runtime.panicBounds(SB)	
			sim.Vy_e[sim.N_e] = p.Vy
  0x1400c4df4		b840420f00		MOVL $0xf4240, AX		
  0x1400c4df9		e88296fbff		CALL runtime.panicBounds(SB)	
			sim.Vx_e[sim.N_e] = p.Vx
  0x1400c4dfe		b840420f00		MOVL $0xf4240, AX		
  0x1400c4e03		e87896fbff		CALL runtime.panicBounds(SB)	
			sim.X_e[sim.N_e] = p.X
  0x1400c4e08		b840420f00		MOVL $0xf4240, AX		
  0x1400c4e0d		e86e96fbff		CALL runtime.panicBounds(SB)	
		for _, p := range sim.WorkerNewElectrons[w] {
  0x1400c4e12		e86996fbff		CALL runtime.panicBounds(SB)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c4e17		e86496fbff		CALL runtime.panicBounds(SB)	
  0x1400c4e1c		90			NOPL				
func (sim *SimulationState) Step7CollisionsElectrons() {
  0x1400c4e1d		4889442408		MOVQ AX, 0x8(SP)						
  0x1400c4e22		e81978fbff		CALL runtime.morestack_noctxt.abi0(SB)				
  0x1400c4e27		488b442408		MOVQ 0x8(SP), AX						
  0x1400c4e2c		e92ffdffff		JMP gopic.(*SimulationState).Step7CollisionsElectrons(SB)	

  0x1400c4e31		cc			INT $0x3		
  0x1400c4e32		cc			INT $0x3		
  0x1400c4e33		cc			INT $0x3		
  0x1400c4e34		cc			INT $0x3		
  0x1400c4e35		cc			INT $0x3		
  0x1400c4e36		cc			INT $0x3		
  0x1400c4e37		cc			INT $0x3		
  0x1400c4e38		cc			INT $0x3		
  0x1400c4e39		cc			INT $0x3		
  0x1400c4e3a		cc			INT $0x3		
  0x1400c4e3b		cc			INT $0x3		
  0x1400c4e3c		cc			INT $0x3		
  0x1400c4e3d		cc			INT $0x3		
  0x1400c4e3e		cc			INT $0x3		
  0x1400c4e3f		cc			INT $0x3		


// =============================================================================
// SYMBOL: workerSampleBinomial
// =============================================================================

TEXT gopic.(*SimulationState).workerSampleBinomial(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation_null.go
func (sim *SimulationState) workerSampleBinomial(workerID, n int, p float64) int {
  0x1400c4920		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c4924		0f86fc010000		JBE 0x1400c4b26		
  0x1400c492a		55			PUSHQ BP		
  0x1400c492b		4889e5			MOVQ SP, BP		
  0x1400c492e		4883ec30		SUBQ $0x30, SP		
	if n <= 0 || p <= 0.0 {
  0x1400c4932		4885c9			TESTQ CX, CX		
  0x1400c4935		0f8e64010000		JLE 0x1400c4a9f		
  0x1400c493b		0f57c9			XORPS X1, X1		
  0x1400c493e		660f2ec8		UCOMISD X0, X1		
  0x1400c4942		0f8357010000		JAE 0x1400c4a9f		
	if p >= 1.0 {
  0x1400c4948		f20f100dc0180100	MOVSD_XMM $f64.3ff0000000000000(SB), X1	
  0x1400c4950		660f2ec1		UCOMISD X1, X0				
  0x1400c4954		0f833c010000		JAE 0x1400c4a96				
	rng := sim.RngWorkers[workerID]
  0x1400c495a		8400			TESTB AL, 0(AX)		
  0x1400c495c		488b90f02dba07		MOVQ 0x7ba2df0(AX), DX	
  0x1400c4963		4839d3			CMPQ BX, DX		
  0x1400c4966		0f83b3010000		JAE 0x1400c4b1f		
	if n <= 0 || p <= 0.0 {
  0x1400c496c		f20f11442458		MOVSD_XMM X0, 0x58(SP)	
	rng := sim.RngWorkers[workerID]
  0x1400c4972		488b90e82dba07		MOVQ 0x7ba2de8(AX), DX	
	if float64(n)*p < 5.0 {
  0x1400c4979		0f57d2			XORPS X2, X2		
  0x1400c497c		f2480f2ad1		CVTSI2SDQ CX, X2	
  0x1400c4981		0f10d8			MOVUPS X0, X3		
  0x1400c4984		f20f59c2		MULSD X2, X0		
	rng := sim.RngWorkers[workerID]
  0x1400c4988		488b04da		MOVQ 0(DX)(BX*8), AX	
	if float64(n)*p < 5.0 {
  0x1400c498c		f20f1025dc180100	MOVSD_XMM $f64.4014000000000000(SB), X4	
  0x1400c4994		660f2ee0		UCOMISD X0, X4				
  0x1400c4998		760c			JBE 0x1400c49a6				
	rng := sim.RngWorkers[workerID]
  0x1400c499a		4889442428		MOVQ AX, 0x28(SP)	
  0x1400c499f		31d2			XORL DX, DX		
	if float64(n)*p < 5.0 {
  0x1400c49a1		e927010000		JMP 0x1400c4acd		
	if n <= 0 || p <= 0.0 {
  0x1400c49a6		48894c2450		MOVQ CX, 0x50(SP)	
	if float64(n)*p < 5.0 {
  0x1400c49ab		f20f11542420		MOVSD_XMM X2, 0x20(SP)	
	sigma := math.Sqrt(float64(n) * p * (1.0 - p))
  0x1400c49b1		f20f5ccb		SUBSD X3, X1		
  0x1400c49b5		f20f59c8		MULSD X0, X1		
	return sqrt(x)
  0x1400c49b9		f20f51c1		SQRTSD X1, X0		
  0x1400c49bd		f20f11442408		MOVSD_XMM X0, 0x8(SP)	
	count := int(math.Round(mu + sigma*rng.NormFloat64()))
  0x1400c49c3		e87884ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x1400c49c8		f20f104c2408		MOVSD_XMM 0x8(SP), X1			
  0x1400c49ce		f20f59c8		MULSD X0, X1				
  0x1400c49d2		f20f10442458		MOVSD_XMM 0x58(SP), X0			
  0x1400c49d8		f20f10542420		MOVSD_XMM 0x20(SP), X2			
  0x1400c49de		c4e2f9b9ca		VFMADD231SD X2, X0, X1			
func Float64bits(f float64) uint64 { return *(*uint64)(unsafe.Pointer(&f)) }
  0x1400c49e3		66480f7ec9		MOVQ X1, CX		
	e := uint(bits>>shift) & mask
  0x1400c49e8		4889ca			MOVQ CX, DX		
  0x1400c49eb		48c1e934		SHRQ $0x34, CX		
  0x1400c49ef		81e1ff070000		ANDL $0x7ff, CX		
	bits := Float64bits(x)
  0x1400c49f5		90			NOPL			
	if e < bias {
  0x1400c49f6		4881f9ff030000		CMPQ CX, $0x3ff		
  0x1400c49fd		732a			JAE 0x1400c4a29		
		bits &= signMask // +-0
  0x1400c49ff		48bb0000000000000080	MOVQ $0x8000000000000000, BX	
  0x1400c4a09		4821d3			ANDQ DX, BX			
			bits |= uvone // +-1
  0x1400c4a0c		48ba000000000000f03f	MOVQ $0x3ff0000000000000, DX	
  0x1400c4a16		4809da			ORQ BX, DX			
		if e == bias-1 {
  0x1400c4a19		4881f9fe030000		CMPQ CX, $0x3fe		
  0x1400c4a20		480f44da		CMOVE DX, BX		
	count := int(math.Round(mu + sigma*rng.NormFloat64()))
  0x1400c4a24		4889d9			MOVQ BX, CX		
		if e == bias-1 {
  0x1400c4a27		eb3c			JMP 0x1400c4a65		
	} else if e < bias+shift {
  0x1400c4a29		4881f933040000		CMPQ CX, $0x433		
  0x1400c4a30		7330			JAE 0x1400c4a62		
		e -= bias
  0x1400c4a32		488d9901fcffff		LEAQ 0xfffffc01(CX), BX	
		bits += half >> e
  0x1400c4a39		48be0000000000000800	MOVQ $0x8000000000000, SI	
  0x1400c4a43		c4			?				
  0x1400c4a44		e2e3			LOOP 0x1400c4a29		
  0x1400c4a46		f7f6			DIVL SI				
  0x1400c4a48		4801f2			ADDQ SI, DX			
		bits &^= fracMask >> e
  0x1400c4a4b		48beffffffffffff0f00	MOVQ $0xfffffffffffff, SI	
  0x1400c4a55		c4			?				
  0x1400c4a56		e2e3			LOOP 0x1400c4a3b		
  0x1400c4a58		f7de			NEGL SI				
  0x1400c4a5a		c4			?				
  0x1400c4a5b		e2e0			LOOP 0x1400c4a3d		
  0x1400c4a5d		f2ca90eb		REPNE; LRET $0xeb90		
  0x1400c4a61		034889			ADDL -0x77(AX), CX		
  0x1400c4a64		d16648			SHLL $0x1, 0x48(SI)		
func Float64frombits(b uint64) float64 { return *(*float64)(unsafe.Pointer(&b)) }
  0x1400c4a67		0f6ec1			MOVD CX, M0		
	count := int(math.Round(mu + sigma*rng.NormFloat64()))
  0x1400c4a6a		f2480f2cc0		CVTTSD2SIQ X0, AX	
	return Float64frombits(bits)
  0x1400c4a6f		90			NOPL			
	if count < 0 {
  0x1400c4a70		4885c0			TESTQ AX, AX		
  0x1400c4a73		7c19			JL 0x1400c4a8e		
	if count > n {
  0x1400c4a75		488b4c2450		MOVQ 0x50(SP), CX	
  0x1400c4a7a		4839c1			CMPQ CX, AX		
  0x1400c4a7d		7d09			JGE 0x1400c4a88		
		return n
  0x1400c4a7f		4889c8			MOVQ CX, AX		
  0x1400c4a82		4883c430		ADDQ $0x30, SP		
  0x1400c4a86		5d			POPQ BP			
  0x1400c4a87		c3			RET			
	return count
  0x1400c4a88		4883c430		ADDQ $0x30, SP		
  0x1400c4a8c		5d			POPQ BP			
  0x1400c4a8d		c3			RET			
		return 0
  0x1400c4a8e		31c0			XORL AX, AX		
  0x1400c4a90		4883c430		ADDQ $0x30, SP		
  0x1400c4a94		5d			POPQ BP			
  0x1400c4a95		c3			RET			
		return n
  0x1400c4a96		4889c8			MOVQ CX, AX		
  0x1400c4a99		4883c430		ADDQ $0x30, SP		
  0x1400c4a9d		5d			POPQ BP			
  0x1400c4a9e		c3			RET			
		return 0
  0x1400c4a9f		31c0			XORL AX, AX		
  0x1400c4aa1		4883c430		ADDQ $0x30, SP		
  0x1400c4aa5		5d			POPQ BP			
  0x1400c4aa6		c3			RET			
			if rng.Float64() < p {
  0x1400c4aa7		f20f105c2458		MOVSD_XMM 0x58(SP), X3	
  0x1400c4aad		660f2ed9		UCOMISD X1, X3		
  0x1400c4ab1		0f97c3			SETA BL			
  0x1400c4ab4		0fb6db			MOVZX BL, BX		
  0x1400c4ab7		488b742418		MOVQ 0x18(SP), SI	
  0x1400c4abc		488d141e		LEAQ 0(SI)(BX*1), DX	
		for i := 0; i < n; i++ {
  0x1400c4ac0		488b4c2410		MOVQ 0x10(SP), CX	
  0x1400c4ac5		48ffc9			DECQ CX			
func (r *Rand) Int63() int64 { return r.src.Int63() }
  0x1400c4ac8		488b442428		MOVQ 0x28(SP), AX	
		for i := 0; i < n; i++ {
  0x1400c4acd		4885c9			TESTQ CX, CX		
  0x1400c4ad0		7e44			JLE 0x1400c4b16		
  0x1400c4ad2		48894c2410		MOVQ CX, 0x10(SP)	
  0x1400c4ad7		4889542418		MOVQ DX, 0x18(SP)	
again:
  0x1400c4adc		eb05			JMP 0x1400c4ae3		
func (r *Rand) Int63() int64 { return r.src.Int63() }
  0x1400c4ade		488b442428		MOVQ 0x28(SP), AX	
  0x1400c4ae3		488b08			MOVQ 0(AX), CX		
  0x1400c4ae6		488b4008		MOVQ 0x8(AX), AX	
  0x1400c4aea		488b4918		MOVQ 0x18(CX), CX	
  0x1400c4aee		ffd1			CALL CX			
	f := float64(r.Int63()) / (1 << 63)
  0x1400c4af0		0f57c0			XORPS X0, X0				
  0x1400c4af3		f2480f2ac0		CVTSI2SDQ AX, X0			
  0x1400c4af8		f20f100d08160100	MOVSD_XMM $f64.3c00000000000000(SB), X1	
  0x1400c4b00		f20f59c8		MULSD X0, X1				
	if f == 1 {
  0x1400c4b04		f20f100504170100	MOVSD_XMM $f64.3ff0000000000000(SB), X0	
  0x1400c4b0c		660f2ec8		UCOMISD X0, X1				
  0x1400c4b10		7595			JNE 0x1400c4aa7				
  0x1400c4b12		7bca			JNP 0x1400c4ade				
  0x1400c4b14		eb91			JMP 0x1400c4aa7				
		return count
  0x1400c4b16		4889d0			MOVQ DX, AX		
  0x1400c4b19		4883c430		ADDQ $0x30, SP		
  0x1400c4b1d		5d			POPQ BP			
  0x1400c4b1e		c3			RET			
	rng := sim.RngWorkers[workerID]
  0x1400c4b1f		90			NOPL				
  0x1400c4b20		e85b99fbff		CALL runtime.panicBounds(SB)	
  0x1400c4b25		90			NOPL				
func (sim *SimulationState) workerSampleBinomial(workerID, n int, p float64) int {
  0x1400c4b26		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c4b2b		48895c2410		MOVQ BX, 0x10(SP)					
  0x1400c4b30		48894c2418		MOVQ CX, 0x18(SP)					
  0x1400c4b35		f20f11442420		MOVSD_XMM X0, 0x20(SP)					
  0x1400c4b3b		0f1f440000		NOPL 0(AX)(AX*1)					
  0x1400c4b40		e8fb7afbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c4b45		488b442408		MOVQ 0x8(SP), AX					
  0x1400c4b4a		488b5c2410		MOVQ 0x10(SP), BX					
  0x1400c4b4f		488b4c2418		MOVQ 0x18(SP), CX					
  0x1400c4b54		f20f10442420		MOVSD_XMM 0x20(SP), X0					
  0x1400c4b5a		e9c1fdffff		JMP gopic.(*SimulationState).workerSampleBinomial(SB)	

  0x1400c4b5f		cc			INT $0x3		


