TEXT gopic.(*SimulationState).Step7CollisionsElectrons(SB) /mnt/c/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation_null.go
func (sim *SimulationState) Step7CollisionsElectrons() {
  0x4b8780		493b6610		CMPQ SP, 0x10(R14)	
  0x4b8784		0f863f040000		JBE 0x4b8bc9		
  0x4b878a		55			PUSHQ BP		
  0x4b878b		4889e5			MOVQ SP, BP		
  0x4b878e		4883ec68		SUBQ $0x68, SP		
	nCollStar := min(sim.sampleBinomial(sim.N_e, sim.PStarE), sim.N_e)
  0x4b8792		4889442478		MOVQ AX, 0x78(SP)					
  0x4b8797		8400			TESTB AL, 0(AX)						
  0x4b8799		488b98c07e5603		MOVQ 0x3567ec0(AX), BX					
  0x4b87a0		f20f1080a021ba07	MOVSD_XMM 0x7ba21a0(AX), X0				
  0x4b87a8		e893fdffff		CALL gopic.(*SimulationState).sampleBinomial(SB)	
  0x4b87ad		488b4c2478		MOVQ 0x78(SP), CX					
  0x4b87b2		488b99c07e5603		MOVQ 0x3567ec0(CX), BX					
  0x4b87b9		4839d8			CMPQ AX, BX						
  0x4b87bc		480f4fc3		CMOVG BX, AX						
	if nCollStar == 0 {
  0x4b87c0		4885c0			TESTQ AX, AX		
	nCollStar := min(sim.sampleBinomial(sim.N_e, sim.PStarE), sim.N_e)
  0x4b87c3		741d			JE 0x4b87e2		
  0x4b87c5		4889c2			MOVQ AX, DX		
	candidates := sim.randomSample(sim.N_e, nCollStar)
  0x4b87c8		4889c8			MOVQ CX, AX					
  0x4b87cb		4889d1			MOVQ DX, CX					
  0x4b87ce		e82dfcffff		CALL gopic.(*SimulationState).randomSample(SB)	
	numWorkers := len(sim.WorkerEDensity)
  0x4b87d3		488b542478		MOVQ 0x78(SP), DX	
  0x4b87d8		488b7208		MOVQ 0x8(DX), SI	
  0x4b87dc		31ff			XORL DI, DI		
  0x4b87de		6690			NOPW			
	for w := range numWorkers {
  0x4b87e0		eb1e			JMP 0x4b8800		
		return
  0x4b87e2		4883c468		ADDQ $0x68, SP		
  0x4b87e6		5d			POPQ BP			
  0x4b87e7		c3			RET			
		sim.WorkerNewIons[w] = sim.WorkerNewIons[w][:0]
  0x4b87e8		4c8b8aa8000000		MOVQ 0xa8(DX), R9		
  0x4b87ef		4bc744c10800000000	MOVQ $0x0, 0x8(R9)(R8*8)	
	for w := range numWorkers {
  0x4b87f8		48ffc7			INCQ DI			
  0x4b87fb		0f1f440000		NOPL 0(AX)(AX*1)	
  0x4b8800		4839f7			CMPQ DI, SI		
  0x4b8803		7d35			JGE 0x4b883a		
		sim.WorkerNewElectrons[w] = sim.WorkerNewElectrons[w][:0]
  0x4b8805		4c8b8298000000		MOVQ 0x98(DX), R8		
  0x4b880c		4c39c7			CMPQ DI, R8			
  0x4b880f		0f83a8030000		JAE 0x4b8bbd			
  0x4b8815		4c8d047f		LEAQ 0(DI)(DI*2), R8		
  0x4b8819		4c8b8a90000000		MOVQ 0x90(DX), R9		
  0x4b8820		4bc744c10800000000	MOVQ $0x0, 0x8(R9)(R8*8)	
		sim.WorkerNewIons[w] = sim.WorkerNewIons[w][:0]
  0x4b8829		4c8b8ab0000000		MOVQ 0xb0(DX), R9	
  0x4b8830		4c39cf			CMPQ DI, R9		
  0x4b8833		72b3			JB 0x4b87e8		
  0x4b8835		e978030000		JMP 0x4b8bb2		
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x4b883a		488d3c33		LEAQ 0(BX)(SI*1), DI	
  0x4b883e		488d7fff		LEAQ -0x1(DI), DI	
  0x4b8842		4885f6			TESTQ SI, SI		
  0x4b8845		0f8462030000		JE 0x4b8bad		
	numWorkers := len(sim.WorkerEDensity)
  0x4b884b		4889742450		MOVQ SI, 0x50(SP)	
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x4b8850		48897c2448		MOVQ DI, 0x48(SP)	
	candidates := sim.randomSample(sim.N_e, nCollStar)
  0x4b8855		48895c2430		MOVQ BX, 0x30(SP)	
  0x4b885a		48894c2438		MOVQ CX, 0x38(SP)	
  0x4b885f		4889442458		MOVQ AX, 0x58(SP)	
	var wg sync.WaitGroup
  0x4b8864		488d05f5ba0100		LEAQ 0x1baf5(IP), AX		
  0x4b886b		e8f0d4f5ff		CALL runtime.newobject(SB)	
  0x4b8870		4889442460		MOVQ AX, 0x60(SP)		
  0x4b8875		4889c1			MOVQ AX, CX			
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x4b8878		488b442448		MOVQ 0x48(SP), AX	
  0x4b887d		488b5c2450		MOVQ 0x50(SP), BX	
  0x4b8882		4899			CQO			
  0x4b8884		48f7fb			IDIVQ BX		
  0x4b8887		4889442428		MOVQ AX, 0x28(SP)	
	for w := range numWorkers {
  0x4b888c		488b542430		MOVQ 0x30(SP), DX	
  0x4b8891		31f6			XORL SI, SI		
  0x4b8893		eb0b			JMP 0x4b88a0		
		start := w * chunkSize
  0x4b8895		4c89c8			MOVQ R9, AX		
	for w := range numWorkers {
  0x4b8898		4c89c6			MOVQ R8, SI		
  0x4b889b		0f1f440000		NOPL 0(AX)(AX*1)	
  0x4b88a0		4839de			CMPQ SI, BX		
  0x4b88a3		0f8dd3000000		JGE 0x4b897c		
		start := w * chunkSize
  0x4b88a9		4889f7			MOVQ SI, DI		
  0x4b88ac		480faff0		IMULQ AX, SI		
		end := min((w+1)*chunkSize, totalCandidates)
  0x4b88b0		4c8d4701		LEAQ 0x1(DI), R8	
  0x4b88b4		4989c1			MOVQ AX, R9		
  0x4b88b7		490fafc0		IMULQ R8, AX		
  0x4b88bb		4839c2			CMPQ DX, AX		
  0x4b88be		480f4cc2		CMOVL DX, AX		
		if start >= end {
  0x4b88c2		4839f0			CMPQ AX, SI		
		end := min((w+1)*chunkSize, totalCandidates)
  0x4b88c5		7ece			JLE 0x4b8895		
	for w := range numWorkers {
  0x4b88c7		48897c2448		MOVQ DI, 0x48(SP)	
		start := w * chunkSize
  0x4b88cc		4889742418		MOVQ SI, 0x18(SP)	
		end := min((w+1)*chunkSize, totalCandidates)
  0x4b88d1		4c89442440		MOVQ R8, 0x40(SP)	
  0x4b88d6		4889442420		MOVQ AX, 0x20(SP)	
		wg.Go(func() {
  0x4b88db		488d051e0a0200		LEAQ 0x20a1e(IP), AX							
  0x4b88e2		e879d4f5ff		CALL runtime.newobject(SB)						
  0x4b88e7		488d0df2020000		LEAQ gopic.(*SimulationState).Step7CollisionsElectrons.func1(SB), CX	
  0x4b88ee		488908			MOVQ CX, 0(AX)								
  0x4b88f1		488b542418		MOVQ 0x18(SP), DX							
  0x4b88f6		48895008		MOVQ DX, 0x8(AX)							
  0x4b88fa		488b542420		MOVQ 0x20(SP), DX							
  0x4b88ff		48895010		MOVQ DX, 0x10(AX)							
  0x4b8903		488b542430		MOVQ 0x30(SP), DX							
  0x4b8908		48895020		MOVQ DX, 0x20(AX)							
  0x4b890c		488b5c2438		MOVQ 0x38(SP), BX							
  0x4b8911		48895828		MOVQ BX, 0x28(AX)							
  0x4b8915		833da43f120000		CMPL runtime.writeBarrier(SB), $0x0					
  0x4b891c		750c			JNE 0x4b892a								
  0x4b891e		488b742458		MOVQ 0x58(SP), SI							
  0x4b8923		488b7c2478		MOVQ 0x78(SP), DI							
  0x4b8928		eb16			JMP 0x4b8940								
  0x4b892a		e871bafbff		CALL runtime.gcWriteBarrier2(SB)					
  0x4b892f		488b742458		MOVQ 0x58(SP), SI							
  0x4b8934		498933			MOVQ SI, 0(R11)								
  0x4b8937		488b7c2478		MOVQ 0x78(SP), DI							
  0x4b893c		49897b08		MOVQ DI, 0x8(R11)							
  0x4b8940		48897018		MOVQ SI, 0x18(AX)							
  0x4b8944		48897830		MOVQ DI, 0x30(AX)							
  0x4b8948		488b4c2448		MOVQ 0x48(SP), CX							
  0x4b894d		48894838		MOVQ CX, 0x38(AX)							
  0x4b8951		4889c3			MOVQ AX, BX								
  0x4b8954		488b442460		MOVQ 0x60(SP), AX							
  0x4b8959		e8a20ffcff		CALL sync.(*WaitGroup).Go(SB)						
	wg.Wait()
  0x4b895e		488b4c2460		MOVQ 0x60(SP), CX	
		end := min((w+1)*chunkSize, totalCandidates)
  0x4b8963		488b542430		MOVQ 0x30(SP), DX	
	for w := range numWorkers {
  0x4b8968		488b5c2450		MOVQ 0x50(SP), BX	
  0x4b896d		4c8b442440		MOVQ 0x40(SP), R8	
		start := w * chunkSize
  0x4b8972		4c8b4c2428		MOVQ 0x28(SP), R9	
		wg.Go(func() {
  0x4b8977		e919ffffff		JMP 0x4b8895		
	wg.Wait()
  0x4b897c		4889c8			MOVQ CX, AX			
  0x4b897f		90			NOPL				
  0x4b8980		e85b0efcff		CALL sync.(*WaitGroup).Wait(SB)	
	for w := range numWorkers {
  0x4b8985		488b4c2450		MOVQ 0x50(SP), CX	
  0x4b898a		488b542478		MOVQ 0x78(SP), DX	
  0x4b898f		31c0			XORL AX, AX		
  0x4b8991		eb03			JMP 0x4b8996		
  0x4b8993		48ffc0			INCQ AX			
  0x4b8996		4839c8			CMPQ AX, CX		
  0x4b8999		7d4c			JGE 0x4b89e7		
		for _, p := range sim.WorkerNewElectrons[w] {
  0x4b899b		488b9a98000000		MOVQ 0x98(DX), BX	
  0x4b89a2		4839d8			CMPQ AX, BX		
  0x4b89a5		0f83fa010000		JAE 0x4b8ba5		
  0x4b89ab		488b9a90000000		MOVQ 0x90(DX), BX	
  0x4b89b2		488d3440		LEAQ 0(AX)(AX*2), SI	
  0x4b89b6		488b3cf3		MOVQ 0(BX)(SI*8), DI	
  0x4b89ba		488b5cf308		MOVQ 0x8(BX)(SI*8), BX	
  0x4b89bf		90			NOPL			
  0x4b89c0		eb43			JMP 0x4b8a05		
		for _, p := range sim.WorkerNewIons[w] {
  0x4b89c2		488b9ab0000000		MOVQ 0xb0(DX), BX	
  0x4b89c9		4839d8			CMPQ AX, BX		
  0x4b89cc		0f8393010000		JAE 0x4b8b65		
  0x4b89d2		488b9aa8000000		MOVQ 0xa8(DX), BX	
  0x4b89d9		488b3cf3		MOVQ 0(BX)(SI*8), DI	
  0x4b89dd		488b5cf308		MOVQ 0x8(BX)(SI*8), BX	
  0x4b89e2		e9c2000000		JMP 0x4b8aa9		
}
  0x4b89e7		4883c468		ADDQ $0x68, SP		
  0x4b89eb		5d			POPQ BP			
  0x4b89ec		c3			RET			
			sim.Vz_e[sim.N_e] = p.Vz
  0x4b89ed		f2420f1194c2d0b4c404	MOVSD_XMM X2, 0x4c4b4d0(DX)(R8*8)	
			sim.N_e++
  0x4b89f7		48ff82c07e5603		INCQ 0x3567ec0(DX)	
		for _, p := range sim.WorkerNewElectrons[w] {
  0x4b89fe		4883c720		ADDQ $0x20, DI		
  0x4b8a02		48ffcb			DECQ BX			
  0x4b8a05		4885db			TESTQ BX, BX		
  0x4b8a08		7eb8			JLE 0x4b89c2		
			sim.X_e[sim.N_e] = p.X
  0x4b8a0a		4c8b82c07e5603		MOVQ 0x3567ec0(DX), R8	
		for _, p := range sim.WorkerNewElectrons[w] {
  0x4b8a11		f20f104708		MOVSD_XMM 0x8(DI), X0	
  0x4b8a16		f20f104f10		MOVSD_XMM 0x10(DI), X1	
  0x4b8a1b		f20f105718		MOVSD_XMM 0x18(DI), X2	
			sim.X_e[sim.N_e] = p.X
  0x4b8a20		4981f840420f00		CMPQ R8, $0xf4240	
  0x4b8a27		0f8367010000		JAE 0x4b8b94		
		for _, p := range sim.WorkerNewElectrons[w] {
  0x4b8a2d		f20f101f		MOVSD_XMM 0(DI), X3	
			sim.X_e[sim.N_e] = p.X
  0x4b8a31		f2420f119cc2d07e5603	MOVSD_XMM X3, 0x3567ed0(DX)(R8*8)	
			sim.Vx_e[sim.N_e] = p.Vx
  0x4b8a3b		4c8b82c07e5603		MOVQ 0x3567ec0(DX), R8			
  0x4b8a42		4981f840420f00		CMPQ R8, $0xf4240			
  0x4b8a49		0f8338010000		JAE 0x4b8b87				
  0x4b8a4f		f2420f1184c2d090d003	MOVSD_XMM X0, 0x3d090d0(DX)(R8*8)	
			sim.Vy_e[sim.N_e] = p.Vy
  0x4b8a59		4c8b82c07e5603		MOVQ 0x3567ec0(DX), R8			
  0x4b8a60		4981f840420f00		CMPQ R8, $0xf4240			
  0x4b8a67		0f830d010000		JAE 0x4b8b7a				
  0x4b8a6d		f2420f118cc2d0a24a04	MOVSD_XMM X1, 0x44aa2d0(DX)(R8*8)	
			sim.Vz_e[sim.N_e] = p.Vz
  0x4b8a77		4c8b82c07e5603		MOVQ 0x3567ec0(DX), R8	
  0x4b8a7e		6690			NOPW			
  0x4b8a80		4981f840420f00		CMPQ R8, $0xf4240	
  0x4b8a87		0f8260ffffff		JB 0x4b89ed		
  0x4b8a8d		e9db000000		JMP 0x4b8b6d		
			sim.Vz_i[sim.N_i] = p.Vz
  0x4b8a92		f20f1194f2d0fcac06	MOVSD_XMM X2, 0x6acfcd0(DX)(SI*8)	
			sim.N_i++
  0x4b8a9b		48ff82c87e5603		INCQ 0x3567ec8(DX)	
		for _, p := range sim.WorkerNewIons[w] {
  0x4b8aa2		4883c720		ADDQ $0x20, DI		
  0x4b8aa6		48ffcb			DECQ BX			
  0x4b8aa9		4885db			TESTQ BX, BX		
  0x4b8aac		0f8ee1feffff		JLE 0x4b8993		
			sim.X_i[sim.N_i] = p.X
  0x4b8ab2		488bb2c87e5603		MOVQ 0x3567ec8(DX), SI	
		for _, p := range sim.WorkerNewIons[w] {
  0x4b8ab9		f20f104708		MOVSD_XMM 0x8(DI), X0	
  0x4b8abe		f20f104f10		MOVSD_XMM 0x10(DI), X1	
  0x4b8ac3		f20f105718		MOVSD_XMM 0x18(DI), X2	
			sim.X_i[sim.N_i] = p.X
  0x4b8ac8		4881fe40420f00		CMPQ SI, $0xf4240	
  0x4b8acf		0f837f000000		JAE 0x4b8b54		
		for _, p := range sim.WorkerNewIons[w] {
  0x4b8ad5		f20f101f		MOVSD_XMM 0(DI), X3	
			sim.X_i[sim.N_i] = p.X
  0x4b8ad9		f20f119cf2d0c63e05	MOVSD_XMM X3, 0x53ec6d0(DX)(SI*8)	
			sim.Vx_i[sim.N_i] = p.Vx
  0x4b8ae2		488bb2c87e5603		MOVQ 0x3567ec8(DX), SI			
  0x4b8ae9		4881fe40420f00		CMPQ SI, $0xf4240			
  0x4b8af0		7355			JAE 0x4b8b47				
  0x4b8af2		f20f1184f2d0d8b805	MOVSD_XMM X0, 0x5b8d8d0(DX)(SI*8)	
			sim.Vy_i[sim.N_i] = p.Vy
  0x4b8afb		488bb2c87e5603		MOVQ 0x3567ec8(DX), SI			
  0x4b8b02		4881fe40420f00		CMPQ SI, $0xf4240			
  0x4b8b09		732f			JAE 0x4b8b3a				
  0x4b8b0b		f20f118cf2d0ea3206	MOVSD_XMM X1, 0x632ead0(DX)(SI*8)	
			sim.Vz_i[sim.N_i] = p.Vz
  0x4b8b14		488bb2c87e5603		MOVQ 0x3567ec8(DX), SI		
  0x4b8b1b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x4b8b20		4881fe40420f00		CMPQ SI, $0xf4240		
  0x4b8b27		0f8265ffffff		JB 0x4b8a92			
  0x4b8b2d		4889f0			MOVQ SI, AX			
  0x4b8b30		b940420f00		MOVL $0xf4240, CX		
  0x4b8b35		e806bcfbff		CALL runtime.panicIndex(SB)	
			sim.Vy_i[sim.N_i] = p.Vy
  0x4b8b3a		4889f0			MOVQ SI, AX			
  0x4b8b3d		b940420f00		MOVL $0xf4240, CX		
  0x4b8b42		e8f9bbfbff		CALL runtime.panicIndex(SB)	
			sim.Vx_i[sim.N_i] = p.Vx
  0x4b8b47		4889f0			MOVQ SI, AX			
  0x4b8b4a		b940420f00		MOVL $0xf4240, CX		
  0x4b8b4f		e8ecbbfbff		CALL runtime.panicIndex(SB)	
			sim.X_i[sim.N_i] = p.X
  0x4b8b54		4889f0			MOVQ SI, AX			
  0x4b8b57		b940420f00		MOVL $0xf4240, CX		
  0x4b8b5c		0f1f4000		NOPL 0(AX)			
  0x4b8b60		e8dbbbfbff		CALL runtime.panicIndex(SB)	
		for _, p := range sim.WorkerNewIons[w] {
  0x4b8b65		4889d9			MOVQ BX, CX			
  0x4b8b68		e8d3bbfbff		CALL runtime.panicIndex(SB)	
			sim.Vz_e[sim.N_e] = p.Vz
  0x4b8b6d		4c89c0			MOVQ R8, AX			
  0x4b8b70		b940420f00		MOVL $0xf4240, CX		
  0x4b8b75		e8c6bbfbff		CALL runtime.panicIndex(SB)	
			sim.Vy_e[sim.N_e] = p.Vy
  0x4b8b7a		4c89c0			MOVQ R8, AX			
  0x4b8b7d		b940420f00		MOVL $0xf4240, CX		
  0x4b8b82		e8b9bbfbff		CALL runtime.panicIndex(SB)	
			sim.Vx_e[sim.N_e] = p.Vx
  0x4b8b87		4c89c0			MOVQ R8, AX			
  0x4b8b8a		b940420f00		MOVL $0xf4240, CX		
  0x4b8b8f		e8acbbfbff		CALL runtime.panicIndex(SB)	
			sim.X_e[sim.N_e] = p.X
  0x4b8b94		4c89c0			MOVQ R8, AX			
  0x4b8b97		b940420f00		MOVL $0xf4240, CX		
  0x4b8b9c		0f1f4000		NOPL 0(AX)			
  0x4b8ba0		e89bbbfbff		CALL runtime.panicIndex(SB)	
		for _, p := range sim.WorkerNewElectrons[w] {
  0x4b8ba5		4889d9			MOVQ BX, CX			
  0x4b8ba8		e893bbfbff		CALL runtime.panicIndex(SB)	
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x4b8bad		e82e0bf8ff		CALL runtime.panicdivide(SB)	
		sim.WorkerNewIons[w] = sim.WorkerNewIons[w][:0]
  0x4b8bb2		4889f8			MOVQ DI, AX			
  0x4b8bb5		4c89c9			MOVQ R9, CX			
  0x4b8bb8		e883bbfbff		CALL runtime.panicIndex(SB)	
		sim.WorkerNewElectrons[w] = sim.WorkerNewElectrons[w][:0]
  0x4b8bbd		4889f8			MOVQ DI, AX			
  0x4b8bc0		4c89c1			MOVQ R8, CX			
  0x4b8bc3		e878bbfbff		CALL runtime.panicIndex(SB)	
  0x4b8bc8		90			NOPL				
func (sim *SimulationState) Step7CollisionsElectrons() {
  0x4b8bc9		4889442408		MOVQ AX, 0x8(SP)						
  0x4b8bce		e86d9afbff		CALL runtime.morestack_noctxt.abi0(SB)				
  0x4b8bd3		488b442408		MOVQ 0x8(SP), AX						
  0x4b8bd8		e9a3fbffff		JMP gopic.(*SimulationState).Step7CollisionsElectrons(SB)	

TEXT gopic.(*SimulationState).Step7CollisionsElectrons.func1(SB) /mnt/c/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation_null.go
		wg.Go(func() {
  0x4b8be0		4c8d6424f0		LEAQ -0x10(SP), R12	
  0x4b8be5		4d3b6610		CMPQ R12, 0x10(R14)	
  0x4b8be9		0f86cd010000		JBE 0x4b8dbc		
  0x4b8bef		55			PUSHQ BP		
  0x4b8bf0		4889e5			MOVQ SP, BP		
  0x4b8bf3		4881ec88000000		SUBQ $0x88, SP		
  0x4b8bfa		488b4230		MOVQ 0x30(DX), AX	
  0x4b8bfe		4889442478		MOVQ AX, 0x78(SP)	
  0x4b8c03		488b4a20		MOVQ 0x20(DX), CX	
  0x4b8c07		48894c2470		MOVQ CX, 0x70(SP)	
  0x4b8c0c		488b5a38		MOVQ 0x38(DX), BX	
  0x4b8c10		48895c2440		MOVQ BX, 0x40(SP)	
  0x4b8c15		488b7210		MOVQ 0x10(DX), SI	
  0x4b8c19		4889742468		MOVQ SI, 0x68(SP)	
  0x4b8c1e		488b7a18		MOVQ 0x18(DX), DI	
  0x4b8c22		4889bc2480000000	MOVQ DI, 0x80(SP)	
  0x4b8c2a		488b5208		MOVQ 0x8(DX), DX	
  0x4b8c2e		4531c0			XORL R8, R8		
			for i := s; i < e; i++ {
  0x4b8c31		eb1f			JMP 0x4b8c52		
  0x4b8c33		488b542460		MOVQ 0x60(SP), DX	
  0x4b8c38		48ffc2			INCQ DX			
				k := candidates[i]
  0x4b8c3b		488b4c2470		MOVQ 0x70(SP), CX	
				if sim.WorkerR01(workerID)*sim.NuStarE < realNu {
  0x4b8c40		488b5c2440		MOVQ 0x40(SP), BX	
			for i := s; i < e; i++ {
  0x4b8c45		488b742468		MOVQ 0x68(SP), SI	
				k := candidates[i]
  0x4b8c4a		488bbc2480000000	MOVQ 0x80(SP), DI	
			for i := s; i < e; i++ {
  0x4b8c52		4839f2			CMPQ DX, SI		
  0x4b8c55		0f8d25010000		JGE 0x4b8d80		
  0x4b8c5b		0f1f440000		NOPL 0(AX)(AX*1)	
				k := candidates[i]
  0x4b8c60		4839ca			CMPQ DX, CX		
  0x4b8c63		0f834a010000		JAE 0x4b8db3		
				vSqr := sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
  0x4b8c69		8400			TESTB AL, 0(AX)		
				k := candidates[i]
  0x4b8c6b		4c8b0cd7		MOVQ 0(DI)(DX*8), R9	
				vSqr := sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
  0x4b8c6f		4981f940420f00		CMPQ R9, $0xf4240			
  0x4b8c76		0f832a010000		JAE 0x4b8da6				
  0x4b8c7c		f2420f1084c8d090d003	MOVSD_XMM 0x3d090d0(AX)(R9*8), X0	
  0x4b8c86		f2420f108cc8d0a24a04	MOVSD_XMM 0x44aa2d0(AX)(R9*8), X1	
  0x4b8c90		f20f59c9		MULSD X1, X1				
  0x4b8c94		c4e2f9b9c8f2420f	MOVL $0xf42f2c8, CX			
  0x4b8c9c		1084c8d0b4c404		ADCB AL, 0x4c4b4d0(AX)(CX*8)		
  0x4b8ca3		c4e2f9b9c8f20f10	MOVL $0x100ff2c8, CX			
				eIdx := minInt(int(vSqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
  0x4b8cab		05000e0600		ADDL $0x60e00, AX			
  0x4b8cb0		f20f1015600d0600	MOVSD_XMM $f64.3e286b6a97118d9b(SB), X2	
  0x4b8cb8		c4e2e9b9c1f24c0f	MOVL $0xf4cf2c1, CX			
  0x4b8cc0		2cd0			SUBL $0xd0, AL				
				velocity := math.Sqrt(vSqr)
  0x4b8cc2		90			NOPL			
	if a < b {
  0x4b8cc3		4981fa3f420f00		CMPQ R10, $0xf423f	
  0x4b8cca		7c06			JL 0x4b8cd2		
  0x4b8ccc		41ba3f420f00		MOVL $0xf423f, R10	
				realNu := sim.SigmaTotE[eIdx] * velocity
  0x4b8cd2		4981fa40420f00		CMPQ R10, $0xf4240	
  0x4b8cd9		0f83ba000000		JAE 0x4b8d99		
			for i := s; i < e; i++ {
  0x4b8cdf		4889542460		MOVQ DX, 0x60(SP)	
				k := candidates[i]
  0x4b8ce4		4c894c2458		MOVQ R9, 0x58(SP)	
				eIdx := minInt(int(vSqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
  0x4b8ce9		4c89542438		MOVQ R10, 0x38(SP)	
					localColl++
  0x4b8cee		4c89442450		MOVQ R8, 0x50(SP)	
	return sqrt(x)
  0x4b8cf3		f20f51c1		SQRTSD X1, X0		
				realNu := sim.SigmaTotE[eIdx] * velocity
  0x4b8cf7		f2420f5984d0c05a6202	MULSD 0x2625ac0(AX)(R10*8), X0	
  0x4b8d01		f20f11442448		MOVSD_XMM X0, 0x48(SP)		
				if sim.WorkerR01(workerID)*sim.NuStarE < realNu {
  0x4b8d07		e8b40e0000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x4b8d0c		488b442478		MOVQ 0x78(SP), AX				
  0x4b8d11		f20f59809821ba07	MULSD 0x7ba2198(AX), X0				
  0x4b8d19		f20f104c2448		MOVSD_XMM 0x48(SP), X1				
  0x4b8d1f		660f2ec8		UCOMISD X0, X1					
  0x4b8d23		770a			JA 0x4b8d2f					
					localColl++
  0x4b8d25		4c8b442450		MOVQ 0x50(SP), R8	
				if sim.WorkerR01(workerID)*sim.NuStarE < realNu {
  0x4b8d2a		e904ffffff		JMP 0x4b8c33		
					sim.CollisionElectron(sim.X_e[k], &sim.Vx_e[k], &sim.Vy_e[k], &sim.Vz_e[k], eIdx, workerID)
  0x4b8d2f		488b542458		MOVQ 0x58(SP), DX					
  0x4b8d34		f20f1084d0d07e5603	MOVSD_XMM 0x3567ed0(AX)(DX*8), X0			
  0x4b8d3d		488d1cd0		LEAQ 0(AX)(DX*8), BX					
  0x4b8d41		488d9bd090d003		LEAQ 0x3d090d0(BX), BX					
  0x4b8d48		488d0cd0		LEAQ 0(AX)(DX*8), CX					
  0x4b8d4c		488d89d0a24a04		LEAQ 0x44aa2d0(CX), CX					
  0x4b8d53		488d3cd0		LEAQ 0(AX)(DX*8), DI					
  0x4b8d57		488dbfd0b4c404		LEAQ 0x4c4b4d0(DI), DI					
  0x4b8d5e		488b742438		MOVQ 0x38(SP), SI					
  0x4b8d63		4c8b442440		MOVQ 0x40(SP), R8					
  0x4b8d68		e89375ffff		CALL gopic.(*SimulationState).CollisionElectron(SB)	
					localColl++
  0x4b8d6d		4c8b442450		MOVQ 0x50(SP), R8	
  0x4b8d72		49ffc0			INCQ R8			
				vSqr := sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
  0x4b8d75		488b442478		MOVQ 0x78(SP), AX	
					localColl++
  0x4b8d7a		e9b4feffff		JMP 0x4b8c33		
  0x4b8d7f		90			NOPL			
			if localColl > 0 {
  0x4b8d80		4d85c0			TESTQ R8, R8		
  0x4b8d83		760b			JBE 0x4b8d90		
				atomic.AddUint64(&sim.N_e_coll, localColl)
  0x4b8d85		8400			TESTB AL, 0(AX)			
  0x4b8d87		f04c0fc1801021ba07	LOCK XADDQ R8, 0x7ba2110(AX)	
		})
  0x4b8d90		4881c488000000		ADDQ $0x88, SP		
  0x4b8d97		5d			POPQ BP			
  0x4b8d98		c3			RET			
				realNu := sim.SigmaTotE[eIdx] * velocity
  0x4b8d99		4c89d0			MOVQ R10, AX			
  0x4b8d9c		b940420f00		MOVL $0xf4240, CX		
  0x4b8da1		e89ab9fbff		CALL runtime.panicIndex(SB)	
				vSqr := sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
  0x4b8da6		4c89c8			MOVQ R9, AX			
  0x4b8da9		b940420f00		MOVL $0xf4240, CX		
  0x4b8dae		e88db9fbff		CALL runtime.panicIndex(SB)	
				k := candidates[i]
  0x4b8db3		4889d0			MOVQ DX, AX			
  0x4b8db6		e885b9fbff		CALL runtime.panicIndex(SB)	
  0x4b8dbb		90			NOPL				
		wg.Go(func() {
  0x4b8dbc		0f1f4000		NOPL 0(AX)							
  0x4b8dc0		e8db97fbff		CALL runtime.morestack.abi0(SB)					
  0x4b8dc5		e916feffff		JMP gopic.(*SimulationState).Step7CollisionsElectrons.func1(SB)	
