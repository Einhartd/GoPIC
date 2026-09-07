TEXT gopic.(*SimulationState).Step7CollisionsElectrons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation_null.go
func (sim *SimulationState) Step7CollisionsElectrons() {
  0x4bdd80		493b6610		CMPQ SP, 0x10(R14)	
  0x4bdd84		0f86e1030000		JBE 0x4be16b		
  0x4bdd8a		55			PUSHQ BP		
  0x4bdd8b		4889e5			MOVQ SP, BP		
  0x4bdd8e		4883ec58		SUBQ $0x58, SP		
	if sim.N_e == 0 {
  0x4bdd92		8400			TESTB AL, 0(AX)			
  0x4bdd94		4883b8c07e560300	CMPQ 0x3567ec0(AX), $0x0	
  0x4bdd9c		740b			JE 0x4bdda9			
	numWorkers := sim.NumWorkers
  0x4bdd9e		488b90e82dba07		MOVQ 0x7ba2de8(AX), DX	
	for w := range numWorkers {
  0x4bdda5		31f6			XORL SI, SI		
  0x4bdda7		eb19			JMP 0x4bddc2		
		return
  0x4bdda9		4883c458		ADDQ $0x58, SP		
  0x4bddad		5d			POPQ BP			
  0x4bddae		c3			RET			
		sim.WorkerNewIons[w] = sim.WorkerNewIons[w][:0]
  0x4bddaf		4c8b80a8000000		MOVQ 0xa8(AX), R8		
  0x4bddb6		49c744f80800000000	MOVQ $0x0, 0x8(R8)(DI*8)	
	for w := range numWorkers {
  0x4bddbf		48ffc6			INCQ SI			
  0x4bddc2		4839d6			CMPQ SI, DX		
  0x4bddc5		7d35			JGE 0x4bddfc		
		sim.WorkerNewElectrons[w] = sim.WorkerNewElectrons[w][:0]
  0x4bddc7		488bb898000000		MOVQ 0x98(AX), DI		
  0x4bddce		4839fe			CMPQ SI, DI			
  0x4bddd1		0f838e030000		JAE 0x4be165			
  0x4bddd7		488d3c76		LEAQ 0(SI)(SI*2), DI		
  0x4bdddb		4c8b8090000000		MOVQ 0x90(AX), R8		
  0x4bdde2		49c744f80800000000	MOVQ $0x0, 0x8(R8)(DI*8)	
		sim.WorkerNewIons[w] = sim.WorkerNewIons[w][:0]
  0x4bddeb		4c8b80b0000000		MOVQ 0xb0(AX), R8	
  0x4bddf2		4c39c6			CMPQ SI, R8		
  0x4bddf5		72b8			JB 0x4bddaf		
  0x4bddf7		e960030000		JMP 0x4be15c		
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bddfc		488bb0c07e5603		MOVQ 0x3567ec0(AX), SI	
  0x4bde03		488d3416		LEAQ 0(SI)(DX*1), SI	
  0x4bde07		488d76ff		LEAQ -0x1(SI), SI	
  0x4bde0b		4885d2			TESTQ DX, DX		
  0x4bde0e		0f8443030000		JE 0x4be157		
	if sim.N_e == 0 {
  0x4bde14		4889442468		MOVQ AX, 0x68(SP)	
	numWorkers := sim.NumWorkers
  0x4bde19		4889542428		MOVQ DX, 0x28(SP)	
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bde1e		4889742448		MOVQ SI, 0x48(SP)	
	var wg sync.WaitGroup
  0x4bde23		b810000000		MOVL $0x10, AX				
  0x4bde28		488d1d99740f00		LEAQ 0xf7499(IP), BX			
  0x4bde2f		b901000000		MOVL $0x1, CX				
  0x4bde34		e8e703f6ff		CALL runtime.mallocgcSmallNoScanSC2(SB)	
  0x4bde39		4889442450		MOVQ AX, 0x50(SP)			
  0x4bde3e		4889c1			MOVQ AX, CX				
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bde41		488b442448		MOVQ 0x48(SP), AX	
  0x4bde46		488b742428		MOVQ 0x28(SP), SI	
  0x4bde4b		4883feff		CMPQ SI, $-0x1		
  0x4bde4f		7507			JNE 0x4bde58		
  0x4bde51		48f7d8			NEGQ AX			
  0x4bde54		31d2			XORL DX, DX		
  0x4bde56		eb05			JMP 0x4bde5d		
  0x4bde58		4899			CQO			
  0x4bde5a		48f7fe			IDIVQ SI		
  0x4bde5d		4889442438		MOVQ AX, 0x38(SP)	
	for w := range numWorkers {
  0x4bde62		31d2			XORL DX, DX		
  0x4bde64		488b7c2468		MOVQ 0x68(SP), DI	
  0x4bde69		eb06			JMP 0x4bde71		
		start := w * chunkSize
  0x4bde6b		4c89d0			MOVQ R10, AX		
	for w := range numWorkers {
  0x4bde6e		4c89ca			MOVQ R9, DX		
  0x4bde71		4839f2			CMPQ DX, SI		
  0x4bde74		0f8dc0000000		JGE 0x4bdf3a		
		start := w * chunkSize
  0x4bde7a		4989d0			MOVQ DX, R8		
  0x4bde7d		480fafd0		IMULQ AX, DX		
		end := min((w+1)*chunkSize, sim.N_e)
  0x4bde81		4d8d4801		LEAQ 0x1(R8), R9	
  0x4bde85		4989c2			MOVQ AX, R10		
  0x4bde88		490fafc1		IMULQ R9, AX		
  0x4bde8c		4c8b9fc07e5603		MOVQ 0x3567ec0(DI), R11	
  0x4bde93		4939c3			CMPQ R11, AX		
		if start >= end {
  0x4bde96		490f4cc3		CMOVL R11, AX		
  0x4bde9a		4839d0			CMPQ AX, DX		
		end := min((w+1)*chunkSize, sim.N_e)
  0x4bde9d		7ecc			JLE 0x4bde6b		
	for w := range numWorkers {
  0x4bde9f		4c89442448		MOVQ R8, 0x48(SP)	
		start := w * chunkSize
  0x4bdea4		4889542420		MOVQ DX, 0x20(SP)	
		end := min((w+1)*chunkSize, sim.N_e)
  0x4bdea9		4c894c2440		MOVQ R9, 0x40(SP)	
		if start >= end {
  0x4bdeae		4889442430		MOVQ AX, 0x30(SP)	
		wg.Go(func() {
  0x4bdeb3		b828000000		MOVL $0x28, AX								
  0x4bdeb8		488d1db9980f00		LEAQ 0xf98b9(IP), BX							
  0x4bdebf		b901000000		MOVL $0x1, CX								
  0x4bdec4		e8f7f4f5ff		CALL runtime.mallocgcSmallScanNoHeaderSC5(SB)				
  0x4bdec9		488d15d0250000		LEAQ gopic.(*SimulationState).Step7CollisionsElectrons.func1(SB), DX	
  0x4bded0		488910			MOVQ DX, 0(AX)								
  0x4bded3		488b542430		MOVQ 0x30(SP), DX							
  0x4bded8		48895008		MOVQ DX, 0x8(AX)							
  0x4bdedc		488b542420		MOVQ 0x20(SP), DX							
  0x4bdee1		48895010		MOVQ DX, 0x10(AX)							
  0x4bdee5		833d84ef120000		CMPL runtime.writeBarrier(SB), $0x0					
  0x4bdeec		7507			JNE 0x4bdef5								
  0x4bdeee		488b4c2468		MOVQ 0x68(SP), CX							
  0x4bdef3		eb0d			JMP 0x4bdf02								
  0x4bdef5		e8e637fcff		CALL runtime.gcWriteBarrier1(SB)					
  0x4bdefa		488b4c2468		MOVQ 0x68(SP), CX							
  0x4bdeff		49890b			MOVQ CX, 0(R11)								
  0x4bdf02		48894818		MOVQ CX, 0x18(AX)							
  0x4bdf06		488b4c2448		MOVQ 0x48(SP), CX							
  0x4bdf0b		48894820		MOVQ CX, 0x20(AX)							
  0x4bdf0f		4889c3			MOVQ AX, BX								
  0x4bdf12		488b442450		MOVQ 0x50(SP), AX							
  0x4bdf17		e8a4bafcff		CALL sync.(*WaitGroup).Go(SB)						
	wg.Wait()
  0x4bdf1c		488b4c2450		MOVQ 0x50(SP), CX	
	for w := range numWorkers {
  0x4bdf21		488b742428		MOVQ 0x28(SP), SI	
		end := min((w+1)*chunkSize, sim.N_e)
  0x4bdf26		488b7c2468		MOVQ 0x68(SP), DI	
	for w := range numWorkers {
  0x4bdf2b		4c8b4c2440		MOVQ 0x40(SP), R9	
		start := w * chunkSize
  0x4bdf30		4c8b542438		MOVQ 0x38(SP), R10	
		wg.Go(func() {
  0x4bdf35		e931ffffff		JMP 0x4bde6b		
	wg.Wait()
  0x4bdf3a		4889c8			MOVQ CX, AX			
  0x4bdf3d		0f1f00			NOPL 0(AX)			
  0x4bdf40		e85bb9fcff		CALL sync.(*WaitGroup).Wait(SB)	
	for w := range numWorkers {
  0x4bdf45		31c9			XORL CX, CX		
  0x4bdf47		488b542428		MOVQ 0x28(SP), DX	
  0x4bdf4c		488b5c2468		MOVQ 0x68(SP), BX	
  0x4bdf51		eb03			JMP 0x4bdf56		
  0x4bdf53		48ffc1			INCQ CX			
  0x4bdf56		4839d1			CMPQ CX, DX		
  0x4bdf59		0f8d94010000		JGE 0x4be0f3		
		for _, p := range sim.WorkerNewElectrons[w] {
  0x4bdf5f		488b8398000000		MOVQ 0x98(BX), AX	
  0x4bdf66		4839c1			CMPQ CX, AX		
  0x4bdf69		0f83e3010000		JAE 0x4be152		
  0x4bdf6f		488b8390000000		MOVQ 0x90(BX), AX	
  0x4bdf76		488d3449		LEAQ 0(CX)(CX*2), SI	
  0x4bdf7a		488b3cf0		MOVQ 0(AX)(SI*8), DI	
  0x4bdf7e		488b44f008		MOVQ 0x8(AX)(SI*8), AX	
  0x4bdf83		eb1b			JMP 0x4bdfa0		
			sim.Vz_e[sim.N_e] = p.Vz
  0x4bdf85		f2420f1194c3d0b4c404	MOVSD_XMM X2, 0x4c4b4d0(BX)(R8*8)	
			sim.N_e++
  0x4bdf8f		48ff83c07e5603		INCQ 0x3567ec0(BX)	
		for _, p := range sim.WorkerNewElectrons[w] {
  0x4bdf96		4883c720		ADDQ $0x20, DI		
  0x4bdf9a		48ffc8			DECQ AX			
  0x4bdf9d		0f1f00			NOPL 0(AX)		
  0x4bdfa0		4885c0			TESTQ AX, AX		
  0x4bdfa3		0f8e89000000		JLE 0x4be032		
			sim.X_e[sim.N_e] = p.X
  0x4bdfa9		4c8b83c07e5603		MOVQ 0x3567ec0(BX), R8	
		for _, p := range sim.WorkerNewElectrons[w] {
  0x4bdfb0		f20f104708		MOVSD_XMM 0x8(DI), X0	
  0x4bdfb5		f20f104f10		MOVSD_XMM 0x10(DI), X1	
  0x4bdfba		f20f105718		MOVSD_XMM 0x18(DI), X2	
  0x4bdfbf		90			NOPL			
			sim.X_e[sim.N_e] = p.X
  0x4bdfc0		4981f840420f00		CMPQ R8, $0xf4240	
  0x4bdfc7		0f837b010000		JAE 0x4be148		
		for _, p := range sim.WorkerNewElectrons[w] {
  0x4bdfcd		f20f101f		MOVSD_XMM 0(DI), X3	
			sim.X_e[sim.N_e] = p.X
  0x4bdfd1		f2420f119cc3d07e5603	MOVSD_XMM X3, 0x3567ed0(BX)(R8*8)	
			sim.Vx_e[sim.N_e] = p.Vx
  0x4bdfdb		4c8b83c07e5603		MOVQ 0x3567ec0(BX), R8			
  0x4bdfe2		4981f840420f00		CMPQ R8, $0xf4240			
  0x4bdfe9		0f834f010000		JAE 0x4be13e				
  0x4bdfef		f2420f1184c3d090d003	MOVSD_XMM X0, 0x3d090d0(BX)(R8*8)	
			sim.Vy_e[sim.N_e] = p.Vy
  0x4bdff9		4c8b83c07e5603		MOVQ 0x3567ec0(BX), R8			
  0x4be000		4981f840420f00		CMPQ R8, $0xf4240			
  0x4be007		0f8327010000		JAE 0x4be134				
  0x4be00d		f2420f118cc3d0a24a04	MOVSD_XMM X1, 0x44aa2d0(BX)(R8*8)	
			sim.Vz_e[sim.N_e] = p.Vz
  0x4be017		4c8b83c07e5603		MOVQ 0x3567ec0(BX), R8	
  0x4be01e		6690			NOPW			
  0x4be020		4981f840420f00		CMPQ R8, $0xf4240	
  0x4be027		0f8258ffffff		JB 0x4bdf85		
  0x4be02d		e9f8000000		JMP 0x4be12a		
		for _, p := range sim.WorkerNewIons[w] {
  0x4be032		488b83b0000000		MOVQ 0xb0(BX), AX	
  0x4be039		0f1f8000000000		NOPL 0(AX)		
  0x4be040		4839c1			CMPQ CX, AX		
  0x4be043		0f83dc000000		JAE 0x4be125		
  0x4be049		488b83a8000000		MOVQ 0xa8(BX), AX	
  0x4be050		488b3cf0		MOVQ 0(AX)(SI*8), DI	
  0x4be054		488b44f008		MOVQ 0x8(AX)(SI*8), AX	
  0x4be059		eb17			JMP 0x4be072		
			sim.Vz_i[sim.N_i] = p.Vz
  0x4be05b		f20f1194f3d0fcac06	MOVSD_XMM X2, 0x6acfcd0(BX)(SI*8)	
			sim.N_i++
  0x4be064		48ff83c87e5603		INCQ 0x3567ec8(BX)	
		for _, p := range sim.WorkerNewIons[w] {
  0x4be06b		4883c720		ADDQ $0x20, DI		
  0x4be06f		48ffc8			DECQ AX			
  0x4be072		4885c0			TESTQ AX, AX		
  0x4be075		0f8ed8feffff		JLE 0x4bdf53		
			sim.X_i[sim.N_i] = p.X
  0x4be07b		488bb3c87e5603		MOVQ 0x3567ec8(BX), SI	
		for _, p := range sim.WorkerNewIons[w] {
  0x4be082		f20f104708		MOVSD_XMM 0x8(DI), X0	
  0x4be087		f20f104f10		MOVSD_XMM 0x10(DI), X1	
  0x4be08c		f20f105718		MOVSD_XMM 0x18(DI), X2	
			sim.X_i[sim.N_i] = p.X
  0x4be091		4881fe40420f00		CMPQ SI, $0xf4240	
  0x4be098		0f837b000000		JAE 0x4be119		
		for _, p := range sim.WorkerNewIons[w] {
  0x4be09e		f20f101f		MOVSD_XMM 0(DI), X3	
			sim.X_i[sim.N_i] = p.X
  0x4be0a2		f20f119cf3d0c63e05	MOVSD_XMM X3, 0x53ec6d0(BX)(SI*8)	
			sim.Vx_i[sim.N_i] = p.Vx
  0x4be0ab		488bb3c87e5603		MOVQ 0x3567ec8(BX), SI			
  0x4be0b2		4881fe40420f00		CMPQ SI, $0xf4240			
  0x4be0b9		7354			JAE 0x4be10f				
  0x4be0bb		f20f1184f3d0d8b805	MOVSD_XMM X0, 0x5b8d8d0(BX)(SI*8)	
			sim.Vy_i[sim.N_i] = p.Vy
  0x4be0c4		488bb3c87e5603		MOVQ 0x3567ec8(BX), SI			
  0x4be0cb		4881fe40420f00		CMPQ SI, $0xf4240			
  0x4be0d2		7331			JAE 0x4be105				
  0x4be0d4		f20f118cf3d0ea3206	MOVSD_XMM X1, 0x632ead0(BX)(SI*8)	
			sim.Vz_i[sim.N_i] = p.Vz
  0x4be0dd		488bb3c87e5603		MOVQ 0x3567ec8(BX), SI	
  0x4be0e4		4881fe40420f00		CMPQ SI, $0xf4240	
  0x4be0eb		0f826affffff		JB 0x4be05b		
  0x4be0f1		eb06			JMP 0x4be0f9		
}
  0x4be0f3		4883c458		ADDQ $0x58, SP		
  0x4be0f7		5d			POPQ BP			
  0x4be0f8		c3			RET			
			sim.Vz_i[sim.N_i] = p.Vz
  0x4be0f9		b840420f00		MOVL $0xf4240, AX		
  0x4be0fe		6690			NOPW				
  0x4be100		e89b39fcff		CALL runtime.panicBounds(SB)	
			sim.Vy_i[sim.N_i] = p.Vy
  0x4be105		b840420f00		MOVL $0xf4240, AX		
  0x4be10a		e89139fcff		CALL runtime.panicBounds(SB)	
			sim.Vx_i[sim.N_i] = p.Vx
  0x4be10f		b840420f00		MOVL $0xf4240, AX		
  0x4be114		e88739fcff		CALL runtime.panicBounds(SB)	
			sim.X_i[sim.N_i] = p.X
  0x4be119		b840420f00		MOVL $0xf4240, AX		
  0x4be11e		6690			NOPW				
  0x4be120		e87b39fcff		CALL runtime.panicBounds(SB)	
		for _, p := range sim.WorkerNewIons[w] {
  0x4be125		e87639fcff		CALL runtime.panicBounds(SB)	
			sim.Vz_e[sim.N_e] = p.Vz
  0x4be12a		b840420f00		MOVL $0xf4240, AX		
  0x4be12f		e86c39fcff		CALL runtime.panicBounds(SB)	
			sim.Vy_e[sim.N_e] = p.Vy
  0x4be134		b840420f00		MOVL $0xf4240, AX		
  0x4be139		e86239fcff		CALL runtime.panicBounds(SB)	
			sim.Vx_e[sim.N_e] = p.Vx
  0x4be13e		b840420f00		MOVL $0xf4240, AX		
  0x4be143		e85839fcff		CALL runtime.panicBounds(SB)	
			sim.X_e[sim.N_e] = p.X
  0x4be148		b840420f00		MOVL $0xf4240, AX		
  0x4be14d		e84e39fcff		CALL runtime.panicBounds(SB)	
		for _, p := range sim.WorkerNewElectrons[w] {
  0x4be152		e84939fcff		CALL runtime.panicBounds(SB)	
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4be157		e8c466f8ff		CALL runtime.panicdivide(SB)	
		sim.WorkerNewIons[w] = sim.WorkerNewIons[w][:0]
  0x4be15c		0f1f4000		NOPL 0(AX)			
  0x4be160		e83b39fcff		CALL runtime.panicBounds(SB)	
		sim.WorkerNewElectrons[w] = sim.WorkerNewElectrons[w][:0]
  0x4be165		e83639fcff		CALL runtime.panicBounds(SB)	
  0x4be16a		90			NOPL				
func (sim *SimulationState) Step7CollisionsElectrons() {
  0x4be16b		4889442408		MOVQ AX, 0x8(SP)						
  0x4be170		e8eb1cfcff		CALL runtime.morestack_noctxt.abi0(SB)				
  0x4be175		488b442408		MOVQ 0x8(SP), AX						
  0x4be17a		e901fcffff		JMP gopic.(*SimulationState).Step7CollisionsElectrons(SB)	

TEXT gopic.(*SimulationState).Step7CollisionsElectrons.func1(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation_null.go
		wg.Go(func() {
  0x4c04a0		4c8d6424e0		LEAQ -0x20(SP), R12	
  0x4c04a5		4d3b6610		CMPQ R12, 0x10(R14)	
  0x4c04a9		0f8645020000		JBE 0x4c06f4		
  0x4c04af		55			PUSHQ BP		
  0x4c04b0		4889e5			MOVQ SP, BP		
  0x4c04b3		4881ec98000000		SUBQ $0x98, SP		
  0x4c04ba		488b4218		MOVQ 0x18(DX), AX	
  0x4c04be		4889842490000000	MOVQ AX, 0x90(SP)	
			localNColl := sim.workerSampleBinomial(workerID, nLocal, sim.PStarE)
  0x4c04c6		8400			TESTB AL, 0(AX)		
		wg.Go(func() {
  0x4c04c8		488b5a20		MOVQ 0x20(DX), BX	
  0x4c04cc		48895c2440		MOVQ BX, 0x40(SP)	
  0x4c04d1		488b7210		MOVQ 0x10(DX), SI	
  0x4c04d5		4889742448		MOVQ SI, 0x48(SP)	
  0x4c04da		488b4a08		MOVQ 0x8(DX), CX	
  0x4c04de		48894c2470		MOVQ CX, 0x70(SP)	
			nLocal := e - s
  0x4c04e3		4889ca			MOVQ CX, DX		
  0x4c04e6		4829f2			SUBQ SI, DX		
  0x4c04e9		4889542458		MOVQ DX, 0x58(SP)	
			localNColl := sim.workerSampleBinomial(workerID, nLocal, sim.PStarE)
  0x4c04ee		f20f1080382eba07	MOVSD_XMM 0x7ba2e38(AX), X0				
  0x4c04f6		4889d1			MOVQ DX, CX						
  0x4c04f9		e842d6ffff		CALL gopic.(*SimulationState).workerSampleBinomial(SB)	
				ki := s + int(sim.WorkerR01(workerID)*float64(nLocal))
  0x4c04fe		488b542458		MOVQ 0x58(SP), DX	
  0x4c0503		0f57c9			XORPS X1, X1		
  0x4c0506		f2480f2aca		CVTSI2SDQ DX, X1	
  0x4c050b		f20f118c2488000000	MOVSD_XMM X1, 0x88(SP)	
					ki = e - 1
  0x4c0514		488b742470		MOVQ 0x70(SP), SI	
  0x4c0519		488d7eff		LEAQ -0x1(SI), DI	
  0x4c051d		48897c2468		MOVQ DI, 0x68(SP)	
			if localNColl > nLocal {
  0x4c0522		4839d0			CMPQ AX, DX		
			var localColl uint64
  0x4c0525		480f4fc2		CMOVG DX, AX		
  0x4c0529		31c9			XORL CX, CX		
			for range localNColl {
  0x4c052b		eb21			JMP 0x4c054e		
  0x4c052d		488b942480000000	MOVQ 0x80(SP), DX	
  0x4c0535		48ffca			DECQ DX			
				if ki >= e {
  0x4c0538		488b742470		MOVQ 0x70(SP), SI	
				vSqr := sim.Vx_e[ki]*sim.Vx_e[ki] + sim.Vy_e[ki]*sim.Vy_e[ki] + sim.Vz_e[ki]*sim.Vz_e[ki]
  0x4c053d		488b7c2468		MOVQ 0x68(SP), DI	
				ki := s + int(sim.WorkerR01(workerID)*float64(nLocal))
  0x4c0542		f20f108c2488000000	MOVSD_XMM 0x88(SP), X1	
			for range localNColl {
  0x4c054b		4889d0			MOVQ DX, AX		
  0x4c054e		4885c0			TESTQ AX, AX		
  0x4c0551		0f8e69010000		JLE 0x4c06c0		
  0x4c0557		4889842480000000	MOVQ AX, 0x80(SP)	
  0x4c055f		48894c2460		MOVQ CX, 0x60(SP)	
				ki := s + int(sim.WorkerR01(workerID)*float64(nLocal))
  0x4c0564		488b842490000000	MOVQ 0x90(SP), AX				
  0x4c056c		488b5c2440		MOVQ 0x40(SP), BX				
  0x4c0571		e86ae8ffff		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x4c0576		f20f108c2488000000	MOVSD_XMM 0x88(SP), X1				
  0x4c057f		f20f59c1		MULSD X1, X0					
  0x4c0583		f2480f2cc8		CVTTSD2SIQ X0, CX				
  0x4c0588		488b542448		MOVQ 0x48(SP), DX				
  0x4c058d		4801d1			ADDQ DX, CX					
				if ki >= e {
  0x4c0590		488b742470		MOVQ 0x70(SP), SI	
  0x4c0595		4839ce			CMPQ SI, CX		
  0x4c0598		7f06			JG 0x4c05a0		
				vSqr := sim.Vx_e[ki]*sim.Vx_e[ki] + sim.Vy_e[ki]*sim.Vy_e[ki] + sim.Vz_e[ki]*sim.Vz_e[ki]
  0x4c059a		488b4c2468		MOVQ 0x68(SP), CX			
  0x4c059f		90			NOPL					
  0x4c05a0		4881f940420f00		CMPQ CX, $0xf4240			
  0x4c05a7		0f833c010000		JAE 0x4c06e9				
  0x4c05ad		488b842490000000	MOVQ 0x90(SP), AX			
  0x4c05b5		f20f1084c8d090d003	MOVSD_XMM 0x3d090d0(AX)(CX*8), X0	
  0x4c05be		f20f1094c8d0a24a04	MOVSD_XMM 0x44aa2d0(AX)(CX*8), X2	
  0x4c05c7		f20f59d2		MULSD X2, X2				
  0x4c05cb		c4e2f9b9d0		VFMADD231SD X0, X0, X2			
  0x4c05d0		f20f1084c8d0b4c404	MOVSD_XMM 0x4c4b4d0(AX)(CX*8), X0	
  0x4c05d9		c4e2f9b9d0		VFMADD231SD X0, X0, X2			
				eIdx := minInt(int(vSqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
  0x4c05de		f20f10056ad30000	MOVSD_XMM $f64.3fe0000000000000(SB), X0	
  0x4c05e6		f20f101dcad20000	MOVSD_XMM $f64.3e286b6a97118d9b(SB), X3	
  0x4c05ee		c4e2e1b9c2		VFMADD231SD X2, X3, X0			
  0x4c05f3		f2480f2cf8		CVTTSD2SIQ X0, DI			
				velocity := math.Sqrt(vSqr)
  0x4c05f8		90			NOPL			
  0x4c05f9		0f1f8000000000		NOPL 0(AX)		
	if a < b {
  0x4c0600		4881ff3f420f00		CMPQ DI, $0xf423f	
  0x4c0607		7c05			JL 0x4c060e		
  0x4c0609		bf3f420f00		MOVL $0xf423f, DI	
				realNu := sim.SigmaTotE[eIdx] * velocity
  0x4c060e		4881ff40420f00		CMPQ DI, $0xf4240	
  0x4c0615		0f83c4000000		JAE 0x4c06df		
				vSqr := sim.Vx_e[ki]*sim.Vx_e[ki] + sim.Vy_e[ki]*sim.Vy_e[ki] + sim.Vz_e[ki]*sim.Vz_e[ki]
  0x4c061b		48894c2478		MOVQ CX, 0x78(SP)	
				eIdx := minInt(int(vSqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
  0x4c0620		48897c2438		MOVQ DI, 0x38(SP)	
	return sqrt(x)
  0x4c0625		f20f51c2		SQRTSD X2, X0		
				realNu := sim.SigmaTotE[eIdx] * velocity
  0x4c0629		f20f5984f8c05a6202	MULSD 0x2625ac0(AX)(DI*8), X0	
  0x4c0632		f20f11442450		MOVSD_XMM X0, 0x50(SP)		
				if sim.WorkerR01(workerID)*sim.NuStarE < realNu {
  0x4c0638		488b5c2440		MOVQ 0x40(SP), BX				
  0x4c063d		0f1f00			NOPL 0(AX)					
  0x4c0640		e89be7ffff		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x4c0645		488b842490000000	MOVQ 0x90(SP), AX				
  0x4c064d		f20f5980302eba07	MULSD 0x7ba2e30(AX), X0				
  0x4c0655		f20f104c2450		MOVSD_XMM 0x50(SP), X1				
  0x4c065b		660f2ec8		UCOMISD X0, X1					
  0x4c065f		90			NOPL						
  0x4c0660		770a			JA 0x4c066c					
  0x4c0662		488b4c2460		MOVQ 0x60(SP), CX				
  0x4c0667		e9c1feffff		JMP 0x4c052d					
					sim.CollisionElectron(sim.X_e[ki], &sim.Vx_e[ki], &sim.Vy_e[ki], &sim.Vz_e[ki], eIdx, workerID)
  0x4c066c		488b542478		MOVQ 0x78(SP), DX					
  0x4c0671		f20f1084d0d07e5603	MOVSD_XMM 0x3567ed0(AX)(DX*8), X0			
  0x4c067a		488d1cd0		LEAQ 0(AX)(DX*8), BX					
  0x4c067e		488d9bd090d003		LEAQ 0x3d090d0(BX), BX					
  0x4c0685		488d0cd0		LEAQ 0(AX)(DX*8), CX					
  0x4c0689		488d89d0a24a04		LEAQ 0x44aa2d0(CX), CX					
  0x4c0690		488d3cd0		LEAQ 0(AX)(DX*8), DI					
  0x4c0694		488dbfd0b4c404		LEAQ 0x4c4b4d0(DI), DI					
  0x4c069b		488b742438		MOVQ 0x38(SP), SI					
  0x4c06a0		4c8b442440		MOVQ 0x40(SP), R8					
  0x4c06a5		e8965fffff		CALL gopic.(*SimulationState).CollisionElectron(SB)	
					localColl++
  0x4c06aa		488b4c2460		MOVQ 0x60(SP), CX	
  0x4c06af		48ffc1			INCQ CX			
				ki := s + int(sim.WorkerR01(workerID)*float64(nLocal))
  0x4c06b2		488b842490000000	MOVQ 0x90(SP), AX	
					localColl++
  0x4c06ba		e96efeffff		JMP 0x4c052d		
  0x4c06bf		90			NOPL			
			if localColl > 0 {
  0x4c06c0		4885c9			TESTQ CX, CX		
  0x4c06c3		7611			JBE 0x4c06d6		
				atomic.AddUint64(&sim.N_e_coll, localColl)
  0x4c06c5		488b842490000000	MOVQ 0x90(SP), AX		
  0x4c06cd		f0480fc188902dba07	LOCK XADDQ CX, 0x7ba2d90(AX)	
		})
  0x4c06d6		4881c498000000		ADDQ $0x98, SP		
  0x4c06dd		5d			POPQ BP			
  0x4c06de		c3			RET			
				realNu := sim.SigmaTotE[eIdx] * velocity
  0x4c06df		b840420f00		MOVL $0xf4240, AX		
  0x4c06e4		e8b713fcff		CALL runtime.panicBounds(SB)	
				vSqr := sim.Vx_e[ki]*sim.Vx_e[ki] + sim.Vy_e[ki]*sim.Vy_e[ki] + sim.Vz_e[ki]*sim.Vz_e[ki]
  0x4c06e9		b840420f00		MOVL $0xf4240, AX		
  0x4c06ee		e8ad13fcff		CALL runtime.panicBounds(SB)	
  0x4c06f3		90			NOPL				
		wg.Go(func() {
  0x4c06f4		e8c7f6fbff		CALL runtime.morestack.abi0(SB)					
  0x4c06f9		e9a2fdffff		JMP gopic.(*SimulationState).Step7CollisionsElectrons.func1(SB)	
