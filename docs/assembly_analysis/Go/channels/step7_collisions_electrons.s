TEXT gopic.(*SimulationState).Step7CollisionsElectrons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation_null.go
func (sim *SimulationState) Step7CollisionsElectrons() {
  0x1400c4e60		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c4e64		0f8650030000		JBE 0x1400c51ba		
  0x1400c4e6a		55			PUSHQ BP		
  0x1400c4e6b		4889e5			MOVQ SP, BP		
  0x1400c4e6e		4883ec30		SUBQ $0x30, SP		
	if nCollStar > sim.N_e {
  0x1400c4e72		4889442440		MOVQ AX, 0x40(SP)	
	nCollStar := sim.sampleBinomial(sim.N_e, sim.PStarE)
  0x1400c4e77		8400			TESTB AL, 0(AX)						
  0x1400c4e79		488b98c07e5603		MOVQ 0x3567ec0(AX), BX					
  0x1400c4e80		f20f1080182eba07	MOVSD_XMM 0x7ba2e18(AX), X0				
  0x1400c4e88		e893fdffff		CALL gopic.(*SimulationState).sampleBinomial(SB)	
	if nCollStar > sim.N_e {
  0x1400c4e8d		488b4c2440		MOVQ 0x40(SP), CX	
  0x1400c4e92		488b99c07e5603		MOVQ 0x3567ec0(CX), BX	
  0x1400c4e99		4839d8			CMPQ AX, BX		
	if nCollStar == 0 {
  0x1400c4e9c		480f4fc3		CMOVG BX, AX		
  0x1400c4ea0		4885c0			TESTQ AX, AX		
	if nCollStar > sim.N_e {
  0x1400c4ea3		7455			JE 0x1400c4efa		
	if nCollStar == 0 {
  0x1400c4ea5		4889c2			MOVQ AX, DX		
	sim.CandidatesE = sim.randomSample(sim.N_e, nCollStar)
  0x1400c4ea8		4889c8			MOVQ CX, AX					
  0x1400c4eab		4889d1			MOVQ DX, CX					
  0x1400c4eae		e84dfcffff		CALL gopic.(*SimulationState).randomSample(SB)	
  0x1400c4eb3		488b542440		MOVQ 0x40(SP), DX				
  0x1400c4eb8		48899a602eba07		MOVQ BX, 0x7ba2e60(DX)				
  0x1400c4ebf		48898a682eba07		MOVQ CX, 0x7ba2e68(DX)				
  0x1400c4ec6		833de3d1150000		CMPL runtime.writeBarrier(SB), $0x0		
  0x1400c4ecd		7413			JE 0x1400c4ee2					
  0x1400c4ecf		488b8a582eba07		MOVQ 0x7ba2e58(DX), CX				
  0x1400c4ed6		e80592fbff		CALL runtime.gcWriteBarrier2(SB)		
  0x1400c4edb		498903			MOVQ AX, 0(R11)					
  0x1400c4ede		49894b08		MOVQ CX, 0x8(R11)				
  0x1400c4ee2		488982582eba07		MOVQ AX, 0x7ba2e58(DX)				
	sim.broadcastAndWait(CmdCollisionsE)
  0x1400c4ee9		90			NOPL			
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c4eea		488b8a402eba07		MOVQ 0x7ba2e40(DX), CX	
  0x1400c4ef1		48894c2420		MOVQ CX, 0x20(SP)	
  0x1400c4ef6		31c0			XORL AX, AX		
	for w := range numWorkers {
  0x1400c4ef8		eb5d			JMP 0x1400c4f57		
		sim.CandidatesE = nil
  0x1400c4efa		440f11b9602eba07	MOVUPS X15, 0x7ba2e60(CX)		
  0x1400c4f02		833da7d1150000		CMPL runtime.writeBarrier(SB), $0x0	
  0x1400c4f09		740f			JE 0x1400c4f1a				
  0x1400c4f0b		488b81582eba07		MOVQ 0x7ba2e58(CX), AX			
  0x1400c4f12		e8a991fbff		CALL runtime.gcWriteBarrier1(SB)	
  0x1400c4f17		498903			MOVQ AX, 0(R11)				
  0x1400c4f1a		48c781582eba0700000000	MOVQ $0x0, 0x7ba2e58(CX)		
		return
  0x1400c4f25		4883c430		ADDQ $0x30, SP		
  0x1400c4f29		5d			POPQ BP			
  0x1400c4f2a		c3			RET			
	for w := range numWorkers {
  0x1400c4f2b		4889442418		MOVQ AX, 0x18(SP)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c4f30		488b8a382eba07		MOVQ 0x7ba2e38(DX), CX		
  0x1400c4f37		488b04c1		MOVQ 0(CX)(AX*8), AX		
  0x1400c4f3b		488d5c2428		LEAQ 0x28(SP), BX		
  0x1400c4f40		e8bbb7f4ff		CALL runtime.chansend1(SB)	
	for w := range numWorkers {
  0x1400c4f45		488b442418		MOVQ 0x18(SP), AX	
  0x1400c4f4a		48ffc0			INCQ AX			
  0x1400c4f4d		488b4c2420		MOVQ 0x20(SP), CX	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c4f52		488b542440		MOVQ 0x40(SP), DX	
	for w := range numWorkers {
  0x1400c4f57		4839c8			CMPQ AX, CX		
  0x1400c4f5a		7d3a			JGE 0x1400c4f96		
		sim.WorkerCmdChan[w] <- cmd
  0x1400c4f5c		48c744242806000000	MOVQ $0x6, 0x28(SP)	
  0x1400c4f65		488bb2402eba07		MOVQ 0x7ba2e40(DX), SI	
  0x1400c4f6c		4839f0			CMPQ AX, SI		
  0x1400c4f6f		72ba			JB 0x1400c4f2b		
  0x1400c4f71		e93e020000		JMP 0x1400c51b4		
	for range numWorkers {
  0x1400c4f76		48894c2420		MOVQ CX, 0x20(SP)	
		<-sim.WorkerDoneChan
  0x1400c4f7b		488b82502eba07		MOVQ 0x7ba2e50(DX), AX		
  0x1400c4f82		31db			XORL BX, BX			
  0x1400c4f84		e8f7c5f4ff		CALL runtime.chanrecv1(SB)	
	for range numWorkers {
  0x1400c4f89		488b4c2420		MOVQ 0x20(SP), CX	
  0x1400c4f8e		48ffc9			DECQ CX			
		<-sim.WorkerDoneChan
  0x1400c4f91		488b542440		MOVQ 0x40(SP), DX	
	for range numWorkers {
  0x1400c4f96		4885c9			TESTQ CX, CX		
  0x1400c4f99		7fdb			JG 0x1400c4f76		
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c4f9b		488b82402eba07		MOVQ 0x7ba2e40(DX), AX	
	for w := 0; w < numWorkers; w++ {
  0x1400c4fa2		31c9			XORL CX, CX		
  0x1400c4fa4		eb03			JMP 0x1400c4fa9		
  0x1400c4fa6		48ffc1			INCQ CX			
  0x1400c4fa9		4839c1			CMPQ CX, AX		
  0x1400c4fac		0f8d9d010000		JGE 0x1400c514f		
		for _, p := range sim.WorkerNewElectrons[w] {
  0x1400c4fb2		488b9a98000000		MOVQ 0x98(DX), BX	
  0x1400c4fb9		0f1f8000000000		NOPL 0(AX)		
  0x1400c4fc0		4839d9			CMPQ CX, BX		
  0x1400c4fc3		0f83e6010000		JAE 0x1400c51af		
  0x1400c4fc9		488b9a90000000		MOVQ 0x90(DX), BX	
  0x1400c4fd0		488d3449		LEAQ 0(CX)(CX*2), SI	
  0x1400c4fd4		488b3cf3		MOVQ 0(BX)(SI*8), DI	
  0x1400c4fd8		488b5cf308		MOVQ 0x8(BX)(SI*8), BX	
  0x1400c4fdd		eb21			JMP 0x1400c5000		
			sim.Vz_e[sim.N_e] = p.Vz
  0x1400c4fdf		f2420f1194c2d0b4c404	MOVSD_XMM X2, 0x4c4b4d0(DX)(R8*8)	
			sim.N_e++
  0x1400c4fe9		48ff82c07e5603		INCQ 0x3567ec0(DX)	
		for _, p := range sim.WorkerNewElectrons[w] {
  0x1400c4ff0		4883c720		ADDQ $0x20, DI		
  0x1400c4ff4		48ffcb			DECQ BX			
  0x1400c4ff7		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x1400c5000		4885db			TESTQ BX, BX		
  0x1400c5003		0f8e89000000		JLE 0x1400c5092		
			sim.X_e[sim.N_e] = p.X
  0x1400c5009		4c8b82c07e5603		MOVQ 0x3567ec0(DX), R8	
		for _, p := range sim.WorkerNewElectrons[w] {
  0x1400c5010		f20f104708		MOVSD_XMM 0x8(DI), X0	
  0x1400c5015		f20f104f10		MOVSD_XMM 0x10(DI), X1	
  0x1400c501a		f20f105718		MOVSD_XMM 0x18(DI), X2	
  0x1400c501f		90			NOPL			
			sim.X_e[sim.N_e] = p.X
  0x1400c5020		4981f840420f00		CMPQ R8, $0xf4240	
  0x1400c5027		0f8378010000		JAE 0x1400c51a5		
		for _, p := range sim.WorkerNewElectrons[w] {
  0x1400c502d		f20f101f		MOVSD_XMM 0(DI), X3	
			sim.X_e[sim.N_e] = p.X
  0x1400c5031		f2420f119cc2d07e5603	MOVSD_XMM X3, 0x3567ed0(DX)(R8*8)	
			sim.Vx_e[sim.N_e] = p.Vx
  0x1400c503b		4c8b82c07e5603		MOVQ 0x3567ec0(DX), R8			
  0x1400c5042		4981f840420f00		CMPQ R8, $0xf4240			
  0x1400c5049		0f834a010000		JAE 0x1400c5199				
  0x1400c504f		f2420f1184c2d090d003	MOVSD_XMM X0, 0x3d090d0(DX)(R8*8)	
			sim.Vy_e[sim.N_e] = p.Vy
  0x1400c5059		4c8b82c07e5603		MOVQ 0x3567ec0(DX), R8			
  0x1400c5060		4981f840420f00		CMPQ R8, $0xf4240			
  0x1400c5067		0f8322010000		JAE 0x1400c518f				
  0x1400c506d		f2420f118cc2d0a24a04	MOVSD_XMM X1, 0x44aa2d0(DX)(R8*8)	
			sim.Vz_e[sim.N_e] = p.Vz
  0x1400c5077		4c8b82c07e5603		MOVQ 0x3567ec0(DX), R8	
  0x1400c507e		6690			NOPW			
  0x1400c5080		4981f840420f00		CMPQ R8, $0xf4240	
  0x1400c5087		0f8252ffffff		JB 0x1400c4fdf		
  0x1400c508d		e9f3000000		JMP 0x1400c5185		
		for _, p := range sim.WorkerNewIons[w] {
  0x1400c5092		488b9ab0000000		MOVQ 0xb0(DX), BX	
  0x1400c5099		0f1f8000000000		NOPL 0(AX)		
  0x1400c50a0		4839d9			CMPQ CX, BX		
  0x1400c50a3		0f83d4000000		JAE 0x1400c517d		
  0x1400c50a9		488b9aa8000000		MOVQ 0xa8(DX), BX	
  0x1400c50b0		488b3cf3		MOVQ 0(BX)(SI*8), DI	
  0x1400c50b4		488b5cf308		MOVQ 0x8(BX)(SI*8), BX	
  0x1400c50b9		eb17			JMP 0x1400c50d2		
			sim.Vz_i[sim.N_i] = p.Vz
  0x1400c50bb		f20f1194f2d0fcac06	MOVSD_XMM X2, 0x6acfcd0(DX)(SI*8)	
			sim.N_i++
  0x1400c50c4		48ff82c87e5603		INCQ 0x3567ec8(DX)	
		for _, p := range sim.WorkerNewIons[w] {
  0x1400c50cb		4883c720		ADDQ $0x20, DI		
  0x1400c50cf		48ffcb			DECQ BX			
  0x1400c50d2		4885db			TESTQ BX, BX		
  0x1400c50d5		0f8ecbfeffff		JLE 0x1400c4fa6		
			sim.X_i[sim.N_i] = p.X
  0x1400c50db		488bb2c87e5603		MOVQ 0x3567ec8(DX), SI	
		for _, p := range sim.WorkerNewIons[w] {
  0x1400c50e2		f20f104708		MOVSD_XMM 0x8(DI), X0	
  0x1400c50e7		f20f104f10		MOVSD_XMM 0x10(DI), X1	
  0x1400c50ec		f20f105718		MOVSD_XMM 0x18(DI), X2	
			sim.X_i[sim.N_i] = p.X
  0x1400c50f1		4881fe40420f00		CMPQ SI, $0xf4240	
  0x1400c50f8		7379			JAE 0x1400c5173		
		for _, p := range sim.WorkerNewIons[w] {
  0x1400c50fa		f20f101f		MOVSD_XMM 0(DI), X3	
			sim.X_i[sim.N_i] = p.X
  0x1400c50fe		f20f119cf2d0c63e05	MOVSD_XMM X3, 0x53ec6d0(DX)(SI*8)	
			sim.Vx_i[sim.N_i] = p.Vx
  0x1400c5107		488bb2c87e5603		MOVQ 0x3567ec8(DX), SI			
  0x1400c510e		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c5115		7352			JAE 0x1400c5169				
  0x1400c5117		f20f1184f2d0d8b805	MOVSD_XMM X0, 0x5b8d8d0(DX)(SI*8)	
			sim.Vy_i[sim.N_i] = p.Vy
  0x1400c5120		488bb2c87e5603		MOVQ 0x3567ec8(DX), SI			
  0x1400c5127		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c512e		732f			JAE 0x1400c515f				
  0x1400c5130		f20f118cf2d0ea3206	MOVSD_XMM X1, 0x632ead0(DX)(SI*8)	
			sim.Vz_i[sim.N_i] = p.Vz
  0x1400c5139		488bb2c87e5603		MOVQ 0x3567ec8(DX), SI	
  0x1400c5140		4881fe40420f00		CMPQ SI, $0xf4240	
  0x1400c5147		0f826effffff		JB 0x1400c50bb		
  0x1400c514d		eb06			JMP 0x1400c5155		
}
  0x1400c514f		4883c430		ADDQ $0x30, SP		
  0x1400c5153		5d			POPQ BP			
  0x1400c5154		c3			RET			
			sim.Vz_i[sim.N_i] = p.Vz
  0x1400c5155		b840420f00		MOVL $0xf4240, AX		
  0x1400c515a		e82193fbff		CALL runtime.panicBounds(SB)	
			sim.Vy_i[sim.N_i] = p.Vy
  0x1400c515f		b840420f00		MOVL $0xf4240, AX		
  0x1400c5164		e81793fbff		CALL runtime.panicBounds(SB)	
			sim.Vx_i[sim.N_i] = p.Vx
  0x1400c5169		b840420f00		MOVL $0xf4240, AX		
  0x1400c516e		e80d93fbff		CALL runtime.panicBounds(SB)	
			sim.X_i[sim.N_i] = p.X
  0x1400c5173		b840420f00		MOVL $0xf4240, AX		
  0x1400c5178		e80393fbff		CALL runtime.panicBounds(SB)	
		for _, p := range sim.WorkerNewIons[w] {
  0x1400c517d		0f1f00			NOPL 0(AX)			
  0x1400c5180		e8fb92fbff		CALL runtime.panicBounds(SB)	
			sim.Vz_e[sim.N_e] = p.Vz
  0x1400c5185		b840420f00		MOVL $0xf4240, AX		
  0x1400c518a		e8f192fbff		CALL runtime.panicBounds(SB)	
			sim.Vy_e[sim.N_e] = p.Vy
  0x1400c518f		b840420f00		MOVL $0xf4240, AX		
  0x1400c5194		e8e792fbff		CALL runtime.panicBounds(SB)	
			sim.Vx_e[sim.N_e] = p.Vx
  0x1400c5199		b840420f00		MOVL $0xf4240, AX		
  0x1400c519e		6690			NOPW				
  0x1400c51a0		e8db92fbff		CALL runtime.panicBounds(SB)	
			sim.X_e[sim.N_e] = p.X
  0x1400c51a5		b840420f00		MOVL $0xf4240, AX		
  0x1400c51aa		e8d192fbff		CALL runtime.panicBounds(SB)	
		for _, p := range sim.WorkerNewElectrons[w] {
  0x1400c51af		e8cc92fbff		CALL runtime.panicBounds(SB)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c51b4		e8c792fbff		CALL runtime.panicBounds(SB)	
  0x1400c51b9		90			NOPL				
func (sim *SimulationState) Step7CollisionsElectrons() {
  0x1400c51ba		4889442408		MOVQ AX, 0x8(SP)						
  0x1400c51bf		90			NOPL								
  0x1400c51c0		e87b74fbff		CALL runtime.morestack_noctxt.abi0(SB)				
  0x1400c51c5		488b442408		MOVQ 0x8(SP), AX						
  0x1400c51ca		e991fcffff		JMP gopic.(*SimulationState).Step7CollisionsElectrons(SB)	

  0x1400c51cf		cc			INT $0x3		
  0x1400c51d0		cc			INT $0x3		
  0x1400c51d1		cc			INT $0x3		
  0x1400c51d2		cc			INT $0x3		
  0x1400c51d3		cc			INT $0x3		
  0x1400c51d4		cc			INT $0x3		
  0x1400c51d5		cc			INT $0x3		
  0x1400c51d6		cc			INT $0x3		
  0x1400c51d7		cc			INT $0x3		
  0x1400c51d8		cc			INT $0x3		
  0x1400c51d9		cc			INT $0x3		
  0x1400c51da		cc			INT $0x3		
  0x1400c51db		cc			INT $0x3		
  0x1400c51dc		cc			INT $0x3		
  0x1400c51dd		cc			INT $0x3		
  0x1400c51de		cc			INT $0x3		
  0x1400c51df		cc			INT $0x3		
