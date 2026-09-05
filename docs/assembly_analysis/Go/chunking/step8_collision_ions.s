TEXT gopic.(*SimulationState).Step8CollisionIons(SB) /mnt/c/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation_null.go
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x4b8de0		493b6610		CMPQ SP, 0x10(R14)	
  0x4b8de4		0f86ef010000		JBE 0x4b8fd9		
  0x4b8dea		55			PUSHQ BP		
  0x4b8deb		4889e5			MOVQ SP, BP		
  0x4b8dee		4883ec70		SUBQ $0x70, SP		
	if (t % N_SUB) != 0 {
  0x4b8df2		4889d9			MOVQ BX, CX			
  0x4b8df5		48c1fb3f		SARQ $0x3f, BX			
  0x4b8df9		4889c2			MOVQ AX, DX			
  0x4b8dfc		48b8cdcccccccccccccc	MOVQ $0xcccccccccccccccd, AX	
  0x4b8e06		4889d6			MOVQ DX, SI			
  0x4b8e09		48f7e9			IMULQ CX			
  0x4b8e0c		4801ca			ADDQ CX, DX			
  0x4b8e0f		48c1fa04		SARQ $0x4, DX			
  0x4b8e13		4829da			SUBQ BX, DX			
  0x4b8e16		488d1492		LEAQ 0(DX)(DX*4), DX		
  0x4b8e1a		48c1e202		SHLQ $0x2, DX			
  0x4b8e1e		6690			NOPW				
  0x4b8e20		4839d1			CMPQ CX, DX			
  0x4b8e23		0f85b0000000		JNE 0x4b8ed9			
  0x4b8e29		4889742460		MOVQ SI, 0x60(SP)		
	nCollStar := min(sim.sampleBinomial(sim.N_i, sim.PStarI), sim.N_i)
  0x4b8e2e		8406			TESTB AL, 0(SI)						
  0x4b8e30		488b9ec87e5603		MOVQ 0x3567ec8(SI), BX					
  0x4b8e37		f20f1086b021ba07	MOVSD_XMM 0x7ba21b0(SI), X0				
  0x4b8e3f		4889f0			MOVQ SI, AX						
  0x4b8e42		e8f9f6ffff		CALL gopic.(*SimulationState).sampleBinomial(SB)	
  0x4b8e47		488b4c2460		MOVQ 0x60(SP), CX					
  0x4b8e4c		488b99c87e5603		MOVQ 0x3567ec8(CX), BX					
  0x4b8e53		4839d8			CMPQ AX, BX						
  0x4b8e56		480f4fc3		CMOVG BX, AX						
	if nCollStar == 0 {
  0x4b8e5a		4885c0			TESTQ AX, AX		
	nCollStar := min(sim.sampleBinomial(sim.N_i, sim.PStarI), sim.N_i)
  0x4b8e5d		7474			JE 0x4b8ed3		
  0x4b8e5f		4889c2			MOVQ AX, DX		
	candidates := sim.randomSample(sim.N_i, nCollStar)
  0x4b8e62		4889c8			MOVQ CX, AX					
  0x4b8e65		4889d1			MOVQ DX, CX					
  0x4b8e68		e893f5ffff		CALL gopic.(*SimulationState).randomSample(SB)	
	numWorkers := len(sim.WorkerEDensity)
  0x4b8e6d		488b542460		MOVQ 0x60(SP), DX	
  0x4b8e72		488b7208		MOVQ 0x8(DX), SI	
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x4b8e76		488d3c33		LEAQ 0(BX)(SI*1), DI	
  0x4b8e7a		488d7fff		LEAQ -0x1(DI), DI	
  0x4b8e7e		6690			NOPW			
  0x4b8e80		4885f6			TESTQ SI, SI		
  0x4b8e83		0f844a010000		JE 0x4b8fd3		
	candidates := sim.randomSample(sim.N_i, nCollStar)
  0x4b8e89		4889442458		MOVQ AX, 0x58(SP)	
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x4b8e8e		48897c2450		MOVQ DI, 0x50(SP)	
	numWorkers := len(sim.WorkerEDensity)
  0x4b8e93		4889742448		MOVQ SI, 0x48(SP)	
	candidates := sim.randomSample(sim.N_i, nCollStar)
  0x4b8e98		48894c2438		MOVQ CX, 0x38(SP)	
  0x4b8e9d		48895c2430		MOVQ BX, 0x30(SP)	
	var wg sync.WaitGroup
  0x4b8ea2		488d05b7b40100		LEAQ 0x1b4b7(IP), AX		
  0x4b8ea9		e8b2cef5ff		CALL runtime.newobject(SB)	
  0x4b8eae		4889442468		MOVQ AX, 0x68(SP)		
  0x4b8eb3		4889c1			MOVQ AX, CX			
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x4b8eb6		488b442450		MOVQ 0x50(SP), AX	
  0x4b8ebb		488b5c2448		MOVQ 0x48(SP), BX	
  0x4b8ec0		4899			CQO			
  0x4b8ec2		48f7fb			IDIVQ BX		
  0x4b8ec5		4889442428		MOVQ AX, 0x28(SP)	
	for w := 0; w < numWorkers; w++ {
  0x4b8eca		488b542430		MOVQ 0x30(SP), DX	
  0x4b8ecf		31f6			XORL SI, SI		
  0x4b8ed1		eb0f			JMP 0x4b8ee2		
		return
  0x4b8ed3		4883c470		ADDQ $0x70, SP		
  0x4b8ed7		5d			POPQ BP			
  0x4b8ed8		c3			RET			
		return
  0x4b8ed9		4883c470		ADDQ $0x70, SP		
  0x4b8edd		5d			POPQ BP			
  0x4b8ede		c3			RET			
	for w := 0; w < numWorkers; w++ {
  0x4b8edf		4c89ce			MOVQ R9, SI		
  0x4b8ee2		4839de			CMPQ SI, BX		
  0x4b8ee5		0f8dda000000		JGE 0x4b8fc5		
		start := w * chunkSize
  0x4b8eeb		4889f7			MOVQ SI, DI		
  0x4b8eee		480faff0		IMULQ AX, SI		
		end := min((w+1)*chunkSize, totalCandidates)
  0x4b8ef2		4c8d4701		LEAQ 0x1(DI), R8	
  0x4b8ef6		4d89c1			MOVQ R8, R9		
  0x4b8ef9		4c0fafc0		IMULQ AX, R8		
  0x4b8efd		4c39c2			CMPQ DX, R8		
  0x4b8f00		4c0f4cc2		CMOVL DX, R8		
		if start >= end {
  0x4b8f04		4939f0			CMPQ R8, SI		
		end := min((w+1)*chunkSize, totalCandidates)
  0x4b8f07		7ed6			JLE 0x4b8edf		
	for w := 0; w < numWorkers; w++ {
  0x4b8f09		48897c2450		MOVQ DI, 0x50(SP)	
		start := w * chunkSize
  0x4b8f0e		4889742418		MOVQ SI, 0x18(SP)	
		end := min((w+1)*chunkSize, totalCandidates)
  0x4b8f13		4c894c2440		MOVQ R9, 0x40(SP)	
  0x4b8f18		4c89442420		MOVQ R8, 0x20(SP)	
		wg.Go(func() {
  0x4b8f1d		488d05dc030200		LEAQ 0x203dc(IP), AX						
  0x4b8f24		e837cef5ff		CALL runtime.newobject(SB)					
  0x4b8f29		488d0dd0000000		LEAQ gopic.(*SimulationState).Step8CollisionIons.func1(SB), CX	
  0x4b8f30		488908			MOVQ CX, 0(AX)							
  0x4b8f33		488b542418		MOVQ 0x18(SP), DX						
  0x4b8f38		48895008		MOVQ DX, 0x8(AX)						
  0x4b8f3c		488b542420		MOVQ 0x20(SP), DX						
  0x4b8f41		48895010		MOVQ DX, 0x10(AX)						
  0x4b8f45		488b542430		MOVQ 0x30(SP), DX						
  0x4b8f4a		48895020		MOVQ DX, 0x20(AX)						
  0x4b8f4e		488b5c2438		MOVQ 0x38(SP), BX						
  0x4b8f53		48895828		MOVQ BX, 0x28(AX)						
  0x4b8f57		833d6239120000		CMPL runtime.writeBarrier(SB), $0x0				
  0x4b8f5e		6690			NOPW								
  0x4b8f60		750c			JNE 0x4b8f6e							
  0x4b8f62		488b742458		MOVQ 0x58(SP), SI						
  0x4b8f67		488b7c2460		MOVQ 0x60(SP), DI						
  0x4b8f6c		eb16			JMP 0x4b8f84							
  0x4b8f6e		e82db4fbff		CALL runtime.gcWriteBarrier2(SB)				
  0x4b8f73		488b742458		MOVQ 0x58(SP), SI						
  0x4b8f78		498933			MOVQ SI, 0(R11)							
  0x4b8f7b		488b7c2460		MOVQ 0x60(SP), DI						
  0x4b8f80		49897b08		MOVQ DI, 0x8(R11)						
  0x4b8f84		48897018		MOVQ SI, 0x18(AX)						
  0x4b8f88		48897830		MOVQ DI, 0x30(AX)						
  0x4b8f8c		488b4c2450		MOVQ 0x50(SP), CX						
  0x4b8f91		48894838		MOVQ CX, 0x38(AX)						
  0x4b8f95		4889c3			MOVQ AX, BX							
  0x4b8f98		488b442468		MOVQ 0x68(SP), AX						
  0x4b8f9d		0f1f00			NOPL 0(AX)							
  0x4b8fa0		e85b09fcff		CALL sync.(*WaitGroup).Go(SB)					
		start := w * chunkSize
  0x4b8fa5		488b442428		MOVQ 0x28(SP), AX	
	wg.Wait()
  0x4b8faa		488b4c2468		MOVQ 0x68(SP), CX	
		end := min((w+1)*chunkSize, totalCandidates)
  0x4b8faf		488b542430		MOVQ 0x30(SP), DX	
	for w := 0; w < numWorkers; w++ {
  0x4b8fb4		488b5c2448		MOVQ 0x48(SP), BX	
  0x4b8fb9		4c8b4c2440		MOVQ 0x40(SP), R9	
  0x4b8fbe		6690			NOPW			
		wg.Go(func() {
  0x4b8fc0		e91affffff		JMP 0x4b8edf		
	wg.Wait()
  0x4b8fc5		4889c8			MOVQ CX, AX			
  0x4b8fc8		e81308fcff		CALL sync.(*WaitGroup).Wait(SB)	
}
  0x4b8fcd		4883c470		ADDQ $0x70, SP		
  0x4b8fd1		5d			POPQ BP			
  0x4b8fd2		c3			RET			
	chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x4b8fd3		e80807f8ff		CALL runtime.panicdivide(SB)	
  0x4b8fd8		90			NOPL				
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x4b8fd9		4889442408		MOVQ AX, 0x8(SP)					
  0x4b8fde		48895c2410		MOVQ BX, 0x10(SP)					
  0x4b8fe3		e85896fbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x4b8fe8		488b442408		MOVQ 0x8(SP), AX					
  0x4b8fed		488b5c2410		MOVQ 0x10(SP), BX					
  0x4b8ff2		e9e9fdffff		JMP gopic.(*SimulationState).Step8CollisionIons(SB)	

TEXT gopic.(*SimulationState).Step8CollisionIons.func1(SB) /mnt/c/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation_null.go
		wg.Go(func() {
  0x4b9000		4c8d6424c8		LEAQ -0x38(SP), R12	
  0x4b9005		4d3b6610		CMPQ R12, 0x10(R14)	
  0x4b9009		0f86ef020000		JBE 0x4b92fe		
  0x4b900f		55			PUSHQ BP		
  0x4b9010		4889e5			MOVQ SP, BP		
  0x4b9013		4881ecb0000000		SUBQ $0xb0, SP		
  0x4b901a		488b4238		MOVQ 0x38(DX), AX	
  0x4b901e		4889442450		MOVQ AX, 0x50(SP)	
  0x4b9023		488b5a30		MOVQ 0x30(DX), BX	
  0x4b9027		48899c24a0000000	MOVQ BX, 0xa0(SP)	
  0x4b902f		488b4a20		MOVQ 0x20(DX), CX	
  0x4b9033		48898c2498000000	MOVQ CX, 0x98(SP)	
  0x4b903b		488b7210		MOVQ 0x10(DX), SI	
  0x4b903f		4889b42490000000	MOVQ SI, 0x90(SP)	
  0x4b9047		488b7a18		MOVQ 0x18(DX), DI	
  0x4b904b		4889bc24a8000000	MOVQ DI, 0xa8(SP)	
  0x4b9053		488b5208		MOVQ 0x8(DX), DX	
  0x4b9057		4531c0			XORL R8, R8		
			for i := s; i < e; i++ {
  0x4b905a		eb30			JMP 0x4b908c		
  0x4b905c		488b942488000000	MOVQ 0x88(SP), DX	
  0x4b9064		48ffc2			INCQ DX			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b9067		488b442450		MOVQ 0x50(SP), AX	
				k := candidates[i]
  0x4b906c		488b8c2498000000	MOVQ 0x98(SP), CX	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b9074		488b9c24a0000000	MOVQ 0xa0(SP), BX	
			for i := s; i < e; i++ {
  0x4b907c		488bb42490000000	MOVQ 0x90(SP), SI	
				k := candidates[i]
  0x4b9084		488bbc24a8000000	MOVQ 0xa8(SP), DI	
			for i := s; i < e; i++ {
  0x4b908c		4839f2			CMPQ DX, SI		
  0x4b908f		0f8d13020000		JGE 0x4b92a8		
				k := candidates[i]
  0x4b9095		4839ca			CMPQ DX, CX		
  0x4b9098		0f8357020000		JAE 0x4b92f5		
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b909e		8403			TESTB AL, 0(BX)		
  0x4b90a0		4c8b8b7821ba07		MOVQ 0x7ba2178(BX), R9	
				k := candidates[i]
  0x4b90a7		4c8b14d7		MOVQ 0(DI)(DX*8), R10	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b90ab		4939c1			CMPQ R9, AX		
  0x4b90ae		0f8639020000		JBE 0x4b92ed		
			for i := s; i < e; i++ {
  0x4b90b4		4889942488000000	MOVQ DX, 0x88(SP)	
				k := candidates[i]
  0x4b90bc		4c89942480000000	MOVQ R10, 0x80(SP)	
					localColl++
  0x4b90c4		4c89442478		MOVQ R8, 0x78(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b90c9		488b8b7021ba07		MOVQ 0x7ba2170(BX), CX			
  0x4b90d0		488b04c1		MOVQ 0(CX)(AX*8), AX			
  0x4b90d4		e88765ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4b90d9		f20f590597351200	MULSD gopic.RMB_sigma(SB), X0		
				vxA := sim.WorkerRMB(workerID)
  0x4b90e1		f20f11442468		MOVSD_XMM X0, 0x68(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b90e7		488b8c24a0000000	MOVQ 0xa0(SP), CX			
  0x4b90ef		488b917821ba07		MOVQ 0x7ba2178(CX), DX			
  0x4b90f6		488b442450		MOVQ 0x50(SP), AX			
  0x4b90fb		0f1f440000		NOPL 0(AX)(AX*1)			
  0x4b9100		4839c2			CMPQ DX, AX				
  0x4b9103		0f86dc010000		JBE 0x4b92e5				
  0x4b9109		488b897021ba07		MOVQ 0x7ba2170(CX), CX			
  0x4b9110		488b04c1		MOVQ 0(CX)(AX*8), AX			
  0x4b9114		e84765ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4b9119		f20f590557351200	MULSD gopic.RMB_sigma(SB), X0		
				vyA := sim.WorkerRMB(workerID)
  0x4b9121		f20f11442460		MOVSD_XMM X0, 0x60(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b9127		488b8c24a0000000	MOVQ 0xa0(SP), CX			
  0x4b912f		488b917821ba07		MOVQ 0x7ba2178(CX), DX			
  0x4b9136		488b442450		MOVQ 0x50(SP), AX			
  0x4b913b		0f1f440000		NOPL 0(AX)(AX*1)			
  0x4b9140		4839c2			CMPQ DX, AX				
  0x4b9143		0f868f010000		JBE 0x4b92d8				
  0x4b9149		488b897021ba07		MOVQ 0x7ba2170(CX), CX			
  0x4b9150		488b04c1		MOVQ 0(CX)(AX*8), AX			
  0x4b9154		e80765ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4b9159		f20f590517351200	MULSD gopic.RMB_sigma(SB), X0		
				vzA := sim.WorkerRMB(workerID)
  0x4b9161		f20f11442458		MOVSD_XMM X0, 0x58(SP)	
				gx := sim.Vx_i[k] - vxA
  0x4b9167		488b842480000000	MOVQ 0x80(SP), AX			
  0x4b916f		483d40420f00		CMPQ AX, $0xf4240			
  0x4b9175		0f8353010000		JAE 0x4b92ce				
  0x4b917b		488b9424a0000000	MOVQ 0xa0(SP), DX			
  0x4b9183		f20f108cc2d0d8b805	MOVSD_XMM 0x5b8d8d0(DX)(AX*8), X1	
  0x4b918c		f20f5c4c2468		SUBSD 0x68(SP), X1			
				gy := sim.Vy_i[k] - vyA
  0x4b9192		f20f1094c2d0ea3206	MOVSD_XMM 0x632ead0(DX)(AX*8), X2	
  0x4b919b		f20f5c542460		SUBSD 0x60(SP), X2			
				gz := sim.Vz_i[k] - vzA
  0x4b91a1		f20f109cc2d0fcac06	MOVSD_XMM 0x6acfcd0(DX)(AX*8), X3	
  0x4b91aa		f20f5cd8		SUBSD X0, X3				
				gSqr := gx*gx + gy*gy + gz*gz
  0x4b91ae		f20f59d2		MULSD X2, X2		
  0x4b91b2		c4e2f1b9d1c4e2e1	MOVL $-0x1e1d3b2f, CX	
  0x4b91ba		b9d3f20f10		MOVL $0x100ff2d3, CX	
				eIdx := minInt(int(gSqr*FACTOR_ENERGY_I+0.5), CS_RANGES-1)
  0x4b91bf		05ec080600		ADDL $0x608ec, AX			
  0x4b91c4		f20f100d7c080600	MOVSD_XMM $f64.3f1b224d182a4f02(SB), X1	
  0x4b91cc		c4e2f1b9c2f2480f	MOVL $0xf48f2c2, CX			
  0x4b91d4		2cf0			SUBL $0xf0, AL				
				g := math.Sqrt(gSqr)
  0x4b91d6		90			NOPL			
  0x4b91d7		660f1f840000000000	NOPW 0(AX)(AX*1)	
	if a < b {
  0x4b91e0		4881fe3f420f00		CMPQ SI, $0xf423f	
  0x4b91e7		7c05			JL 0x4b91ee		
  0x4b91e9		be3f420f00		MOVL $0xf423f, SI	
				realNu := sim.SigmaTotI[eIdx] * g
  0x4b91ee		4881fe40420f00		CMPQ SI, $0xf4240	
  0x4b91f5		0f83c6000000		JAE 0x4b92c1		
				eIdx := minInt(int(gSqr*FACTOR_ENERGY_I+0.5), CS_RANGES-1)
  0x4b91fb		4889742448		MOVQ SI, 0x48(SP)	
	return sqrt(x)
  0x4b9200		f20f51c2		SQRTSD X2, X0		
				realNu := sim.SigmaTotI[eIdx] * g
  0x4b9204		f20f5984f2c06cdc02	MULSD 0x2dc6cc0(DX)(SI*8), X0	
  0x4b920d		f20f11442470		MOVSD_XMM X0, 0x70(SP)		
				if sim.WorkerR01(workerID)*sim.NuStarI < realNu {
  0x4b9213		4889d0			MOVQ DX, AX					
  0x4b9216		488b5c2450		MOVQ 0x50(SP), BX				
  0x4b921b		0f1f440000		NOPL 0(AX)(AX*1)				
  0x4b9220		e89b090000		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x4b9225		488b8424a0000000	MOVQ 0xa0(SP), AX				
  0x4b922d		f20f5980a821ba07	MULSD 0x7ba21a8(AX), X0				
  0x4b9235		f20f104c2470		MOVSD_XMM 0x70(SP), X1				
  0x4b923b		660f2ec8		UCOMISD X0, X1					
  0x4b923f		90			NOPL						
  0x4b9240		770a			JA 0x4b924c					
					localColl++
  0x4b9242		4c8b442478		MOVQ 0x78(SP), R8	
				if sim.WorkerR01(workerID)*sim.NuStarI < realNu {
  0x4b9247		e910feffff		JMP 0x4b905c		
					sim.CollisionIon(&sim.Vx_i[k], &sim.Vy_i[k], &sim.Vz_i[k], &vxA, &vyA, &vzA, eIdx, workerID)
  0x4b924c		488b942480000000	MOVQ 0x80(SP), DX				
  0x4b9254		488d1cd0		LEAQ 0(AX)(DX*8), BX				
  0x4b9258		488d9bd0d8b805		LEAQ 0x5b8d8d0(BX), BX				
  0x4b925f		488d0cd0		LEAQ 0(AX)(DX*8), CX				
  0x4b9263		488d89d0ea3206		LEAQ 0x632ead0(CX), CX				
  0x4b926a		488d3cd0		LEAQ 0(AX)(DX*8), DI				
  0x4b926e		488dbfd0fcac06		LEAQ 0x6acfcd0(DI), DI				
  0x4b9275		488d742468		LEAQ 0x68(SP), SI				
  0x4b927a		4c8d442460		LEAQ 0x60(SP), R8				
  0x4b927f		4c8d4c2458		LEAQ 0x58(SP), R9				
  0x4b9284		4c8b542448		MOVQ 0x48(SP), R10				
  0x4b9289		4c8b5c2450		MOVQ 0x50(SP), R11				
  0x4b928e		e8ed7bffff		CALL gopic.(*SimulationState).CollisionIon(SB)	
					localColl++
  0x4b9293		4c8b442478		MOVQ 0x78(SP), R8	
  0x4b9298		49ffc0			INCQ R8			
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b929b		488b8424a0000000	MOVQ 0xa0(SP), AX	
					localColl++
  0x4b92a3		e9b4fdffff		JMP 0x4b905c		
			if localColl > 0 {
  0x4b92a8		4d85c0			TESTQ R8, R8		
  0x4b92ab		760b			JBE 0x4b92b8		
				atomic.AddUint64(&sim.N_i_coll, localColl)
  0x4b92ad		8403			TESTB AL, 0(BX)			
  0x4b92af		f04c0fc1831821ba07	LOCK XADDQ R8, 0x7ba2118(BX)	
		})
  0x4b92b8		4881c4b0000000		ADDQ $0xb0, SP		
  0x4b92bf		5d			POPQ BP			
  0x4b92c0		c3			RET			
				realNu := sim.SigmaTotI[eIdx] * g
  0x4b92c1		4889f0			MOVQ SI, AX			
  0x4b92c4		b940420f00		MOVL $0xf4240, CX		
  0x4b92c9		e872b4fbff		CALL runtime.panicIndex(SB)	
				gx := sim.Vx_i[k] - vxA
  0x4b92ce		b940420f00		MOVL $0xf4240, CX		
  0x4b92d3		e868b4fbff		CALL runtime.panicIndex(SB)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4b92d8		4889d1			MOVQ DX, CX			
  0x4b92db		0f1f440000		NOPL 0(AX)(AX*1)		
  0x4b92e0		e85bb4fbff		CALL runtime.panicIndex(SB)	
  0x4b92e5		4889d1			MOVQ DX, CX			
  0x4b92e8		e853b4fbff		CALL runtime.panicIndex(SB)	
  0x4b92ed		4c89c9			MOVQ R9, CX			
  0x4b92f0		e84bb4fbff		CALL runtime.panicIndex(SB)	
				k := candidates[i]
  0x4b92f5		4889d0			MOVQ DX, AX			
  0x4b92f8		e843b4fbff		CALL runtime.panicIndex(SB)	
  0x4b92fd		90			NOPL				
		wg.Go(func() {
  0x4b92fe		6690			NOPW								
  0x4b9300		e89b92fbff		CALL runtime.morestack.abi0(SB)					
  0x4b9305		e9f6fcffff		JMP gopic.(*SimulationState).Step8CollisionIons.func1(SB)	
