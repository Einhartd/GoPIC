TEXT gopic.(*SimulationState).Step8CollisionIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation_null.go
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x4be180		493b6610		CMPQ SP, 0x10(R14)	
  0x4be184		0f86a0010000		JBE 0x4be32a		
  0x4be18a		55			PUSHQ BP		
  0x4be18b		4889e5			MOVQ SP, BP		
  0x4be18e		4883ec58		SUBQ $0x58, SP		
	if (t%N_SUB) != 0 || sim.N_i == 0 {
  0x4be192		48bacdcccccccccccccc	MOVQ $0xcccccccccccccccd, DX	
  0x4be19c		480fafd3		IMULQ BX, DX			
  0x4be1a0		48be9899999999999919	MOVQ $0x1999999999999998, SI	
  0x4be1aa		4801f2			ADDQ SI, DX			
  0x4be1ad		48c1c23e		ROLQ $0x3e, DX			
  0x4be1b1		48becccccccccccccc0c	MOVQ $0xccccccccccccccc, SI	
  0x4be1bb		0f1f440000		NOPL 0(AX)(AX*1)		
  0x4be1c0		4839d6			CMPQ SI, DX			
  0x4be1c3		727d			JB 0x4be242			
  0x4be1c5		8400			TESTB AL, 0(AX)			
  0x4be1c7		488b90c87e5603		MOVQ 0x3567ec8(AX), DX		
  0x4be1ce		4885d2			TESTQ DX, DX			
  0x4be1d1		746f			JE 0x4be242			
	numWorkers := sim.NumWorkers
  0x4be1d3		488bb0e82dba07		MOVQ 0x7ba2de8(AX), SI	
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4be1da		488d1432		LEAQ 0(DX)(SI*1), DX	
  0x4be1de		488d52ff		LEAQ -0x1(DX), DX	
  0x4be1e2		4885f6			TESTQ SI, SI		
  0x4be1e5		0f8439010000		JE 0x4be324		
	if (t%N_SUB) != 0 || sim.N_i == 0 {
  0x4be1eb		4889442468		MOVQ AX, 0x68(SP)	
	numWorkers := sim.NumWorkers
  0x4be1f0		4889742428		MOVQ SI, 0x28(SP)	
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4be1f5		4889542448		MOVQ DX, 0x48(SP)	
	var wg sync.WaitGroup
  0x4be1fa		b810000000		MOVL $0x10, AX				
  0x4be1ff		488d1dc2700f00		LEAQ 0xf70c2(IP), BX			
  0x4be206		b901000000		MOVL $0x1, CX				
  0x4be20b		e81000f6ff		CALL runtime.mallocgcSmallNoScanSC2(SB)	
  0x4be210		4889442450		MOVQ AX, 0x50(SP)			
  0x4be215		4889c1			MOVQ AX, CX				
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4be218		488b442448		MOVQ 0x48(SP), AX	
  0x4be21d		488b742428		MOVQ 0x28(SP), SI	
  0x4be222		4883feff		CMPQ SI, $-0x1		
  0x4be226		7507			JNE 0x4be22f		
  0x4be228		48f7d8			NEGQ AX			
  0x4be22b		31d2			XORL DX, DX		
  0x4be22d		eb05			JMP 0x4be234		
  0x4be22f		4899			CQO			
  0x4be231		48f7fe			IDIVQ SI		
  0x4be234		4889442438		MOVQ AX, 0x38(SP)	
	for w := range numWorkers {
  0x4be239		31d2			XORL DX, DX		
  0x4be23b		488b7c2468		MOVQ 0x68(SP), DI	
  0x4be240		eb09			JMP 0x4be24b		
		return
  0x4be242		4883c458		ADDQ $0x58, SP		
  0x4be246		5d			POPQ BP			
  0x4be247		c3			RET			
	for w := range numWorkers {
  0x4be248		4c89d2			MOVQ R10, DX		
  0x4be24b		4839f2			CMPQ DX, SI		
  0x4be24e		0f8dc2000000		JGE 0x4be316		
		start := w * chunkSize
  0x4be254		4989d0			MOVQ DX, R8		
  0x4be257		480fafd0		IMULQ AX, DX		
		end := min((w+1)*chunkSize, sim.N_i)
  0x4be25b		4d8d4801		LEAQ 0x1(R8), R9	
  0x4be25f		4d89ca			MOVQ R9, R10		
  0x4be262		4c0fafc8		IMULQ AX, R9		
  0x4be266		4c8b9fc87e5603		MOVQ 0x3567ec8(DI), R11	
  0x4be26d		4d39cb			CMPQ R11, R9		
		if start >= end {
  0x4be270		4d0f4ccb		CMOVL R11, R9		
  0x4be274		4939d1			CMPQ R9, DX		
		end := min((w+1)*chunkSize, sim.N_i)
  0x4be277		7ecf			JLE 0x4be248		
	for w := range numWorkers {
  0x4be279		4c89442448		MOVQ R8, 0x48(SP)	
		start := w * chunkSize
  0x4be27e		4889542420		MOVQ DX, 0x20(SP)	
		end := min((w+1)*chunkSize, sim.N_i)
  0x4be283		4c89542440		MOVQ R10, 0x40(SP)	
		if start >= end {
  0x4be288		4c894c2430		MOVQ R9, 0x30(SP)	
		wg.Go(func() {
  0x4be28d		b828000000		MOVL $0x28, AX							
  0x4be292		488d1ddf940f00		LEAQ 0xf94df(IP), BX						
  0x4be299		b901000000		MOVL $0x1, CX							
  0x4be29e		6690			NOPW								
  0x4be2a0		e81bf1f5ff		CALL runtime.mallocgcSmallScanNoHeaderSC5(SB)			
  0x4be2a5		488d1554240000		LEAQ gopic.(*SimulationState).Step8CollisionIons.func1(SB), DX	
  0x4be2ac		488910			MOVQ DX, 0(AX)							
  0x4be2af		488b542430		MOVQ 0x30(SP), DX						
  0x4be2b4		48895008		MOVQ DX, 0x8(AX)						
  0x4be2b8		488b542420		MOVQ 0x20(SP), DX						
  0x4be2bd		48895010		MOVQ DX, 0x10(AX)						
  0x4be2c1		833da8eb120000		CMPL runtime.writeBarrier(SB), $0x0				
  0x4be2c8		7507			JNE 0x4be2d1							
  0x4be2ca		488b4c2468		MOVQ 0x68(SP), CX						
  0x4be2cf		eb0d			JMP 0x4be2de							
  0x4be2d1		e80a34fcff		CALL runtime.gcWriteBarrier1(SB)				
  0x4be2d6		488b4c2468		MOVQ 0x68(SP), CX						
  0x4be2db		49890b			MOVQ CX, 0(R11)							
  0x4be2de		48894818		MOVQ CX, 0x18(AX)						
  0x4be2e2		488b4c2448		MOVQ 0x48(SP), CX						
  0x4be2e7		48894820		MOVQ CX, 0x20(AX)						
  0x4be2eb		4889c3			MOVQ AX, BX							
  0x4be2ee		488b442450		MOVQ 0x50(SP), AX						
  0x4be2f3		e8c8b6fcff		CALL sync.(*WaitGroup).Go(SB)					
		start := w * chunkSize
  0x4be2f8		488b442438		MOVQ 0x38(SP), AX	
	wg.Wait()
  0x4be2fd		488b4c2450		MOVQ 0x50(SP), CX	
	for w := range numWorkers {
  0x4be302		488b742428		MOVQ 0x28(SP), SI	
		end := min((w+1)*chunkSize, sim.N_i)
  0x4be307		488b7c2468		MOVQ 0x68(SP), DI	
	for w := range numWorkers {
  0x4be30c		4c8b542440		MOVQ 0x40(SP), R10	
		wg.Go(func() {
  0x4be311		e932ffffff		JMP 0x4be248		
	wg.Wait()
  0x4be316		4889c8			MOVQ CX, AX			
  0x4be319		e882b5fcff		CALL sync.(*WaitGroup).Wait(SB)	
}
  0x4be31e		4883c458		ADDQ $0x58, SP		
  0x4be322		5d			POPQ BP			
  0x4be323		c3			RET			
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4be324		e8f764f8ff		CALL runtime.panicdivide(SB)	
  0x4be329		90			NOPL				
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x4be32a		4889442408		MOVQ AX, 0x8(SP)					
  0x4be32f		48895c2410		MOVQ BX, 0x10(SP)					
  0x4be334		e8271bfcff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x4be339		488b442408		MOVQ 0x8(SP), AX					
  0x4be33e		488b5c2410		MOVQ 0x10(SP), BX					
  0x4be343		e938feffff		JMP gopic.(*SimulationState).Step8CollisionIons(SB)	

TEXT gopic.(*SimulationState).Step8CollisionIons.func1(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation_null.go
		wg.Go(func() {
  0x4c0700		4c8d6424b8		LEAQ -0x48(SP), R12	
  0x4c0705		4d3b6610		CMPQ R12, 0x10(R14)	
  0x4c0709		0f8650030000		JBE 0x4c0a5f		
  0x4c070f		55			PUSHQ BP		
  0x4c0710		4889e5			MOVQ SP, BP		
  0x4c0713		4881ecc0000000		SUBQ $0xc0, SP		
  0x4c071a		488b5a20		MOVQ 0x20(DX), BX	
  0x4c071e		48895c2450		MOVQ BX, 0x50(SP)	
  0x4c0723		488b4218		MOVQ 0x18(DX), AX	
  0x4c0727		48898424b8000000	MOVQ AX, 0xb8(SP)	
			localNColl := sim.workerSampleBinomial(workerID, nLocal, sim.PStarI)
  0x4c072f		8400			TESTB AL, 0(AX)		
		wg.Go(func() {
  0x4c0731		488b7210		MOVQ 0x10(DX), SI	
  0x4c0735		4889742470		MOVQ SI, 0x70(SP)	
  0x4c073a		488b4a08		MOVQ 0x8(DX), CX	
  0x4c073e		48898c2498000000	MOVQ CX, 0x98(SP)	
			nLocal := e - s
  0x4c0746		4889ca			MOVQ CX, DX		
  0x4c0749		4829f2			SUBQ SI, DX		
  0x4c074c		4889942480000000	MOVQ DX, 0x80(SP)	
			localNColl := sim.workerSampleBinomial(workerID, nLocal, sim.PStarI)
  0x4c0754		f20f1080482eba07	MOVSD_XMM 0x7ba2e48(AX), X0				
  0x4c075c		4889d1			MOVQ DX, CX						
  0x4c075f		90			NOPL							
  0x4c0760		e8dbd3ffff		CALL gopic.(*SimulationState).workerSampleBinomial(SB)	
				ki := s + int(sim.WorkerR01(workerID)*float64(nLocal))
  0x4c0765		488b942480000000	MOVQ 0x80(SP), DX	
  0x4c076d		0f57c9			XORPS X1, X1		
  0x4c0770		f2480f2aca		CVTSI2SDQ DX, X1	
  0x4c0775		f20f118c24b0000000	MOVSD_XMM X1, 0xb0(SP)	
					ki = e - 1
  0x4c077e		488bb42498000000	MOVQ 0x98(SP), SI	
  0x4c0786		488d7eff		LEAQ -0x1(SI), DI	
  0x4c078a		4889bc2490000000	MOVQ DI, 0x90(SP)	
			if localNColl > nLocal {
  0x4c0792		4839d0			CMPQ AX, DX		
			var localColl uint64
  0x4c0795		480f4fc2		CMOVG DX, AX		
  0x4c0799		31c9			XORL CX, CX		
			for range localNColl {
  0x4c079b		eb27			JMP 0x4c07c4		
  0x4c079d		488b9424a8000000	MOVQ 0xa8(SP), DX	
  0x4c07a5		48ffca			DECQ DX			
				if ki >= e {
  0x4c07a8		488bb42498000000	MOVQ 0x98(SP), SI	
				vxA := sim.WorkerRMB(workerID)
  0x4c07b0		488bbc2490000000	MOVQ 0x90(SP), DI	
				ki := s + int(sim.WorkerR01(workerID)*float64(nLocal))
  0x4c07b8		f20f108c24b0000000	MOVSD_XMM 0xb0(SP), X1	
			for range localNColl {
  0x4c07c1		4889d0			MOVQ DX, AX		
  0x4c07c4		4885c0			TESTQ AX, AX		
  0x4c07c7		0f8e4a020000		JLE 0x4c0a17		
  0x4c07cd		48898424a8000000	MOVQ AX, 0xa8(SP)	
  0x4c07d5		48898c2488000000	MOVQ CX, 0x88(SP)	
				ki := s + int(sim.WorkerR01(workerID)*float64(nLocal))
  0x4c07dd		488b8424b8000000	MOVQ 0xb8(SP), AX				
  0x4c07e5		488b5c2450		MOVQ 0x50(SP), BX				
  0x4c07ea		e8f1e5ffff		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x4c07ef		f20f108c24b0000000	MOVSD_XMM 0xb0(SP), X1				
  0x4c07f8		f20f59c1		MULSD X1, X0					
  0x4c07fc		f2480f2cc8		CVTTSD2SIQ X0, CX				
  0x4c0801		488b542470		MOVQ 0x70(SP), DX				
  0x4c0806		4801d1			ADDQ DX, CX					
				if ki >= e {
  0x4c0809		488bb42498000000	MOVQ 0x98(SP), SI	
  0x4c0811		4839ce			CMPQ SI, CX		
  0x4c0814		7f08			JG 0x4c081e		
				vxA := sim.WorkerRMB(workerID)
  0x4c0816		488b8c2490000000	MOVQ 0x90(SP), CX	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c081e		488b9c24b8000000	MOVQ 0xb8(SP), BX	
  0x4c0826		488bbbf82dba07		MOVQ 0x7ba2df8(BX), DI	
  0x4c082d		4c8b442450		MOVQ 0x50(SP), R8	
  0x4c0832		4c39c7			CMPQ DI, R8		
  0x4c0835		0f861e020000		JBE 0x4c0a59		
				vxA := sim.WorkerRMB(workerID)
  0x4c083b		48898c24a0000000	MOVQ CX, 0xa0(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c0843		488b8bf02dba07		MOVQ 0x7ba2df0(BX), CX			
  0x4c084a		4a8b04c1		MOVQ 0(CX)(R8*8), AX			
  0x4c084e		e8ed53ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4c0853		f20f5905bdc31200	MULSD gopic.RMB_sigma(SB), X0		
				vxA := sim.WorkerRMB(workerID)
  0x4c085b		f20f11442468		MOVSD_XMM X0, 0x68(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c0861		488b8c24b8000000	MOVQ 0xb8(SP), CX			
  0x4c0869		488b91f82dba07		MOVQ 0x7ba2df8(CX), DX			
  0x4c0870		488b5c2450		MOVQ 0x50(SP), BX			
  0x4c0875		4839da			CMPQ DX, BX				
  0x4c0878		0f86d6010000		JBE 0x4c0a54				
  0x4c087e		488b89f02dba07		MOVQ 0x7ba2df0(CX), CX			
  0x4c0885		488b04d9		MOVQ 0(CX)(BX*8), AX			
  0x4c0889		e8b253ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4c088e		f20f590582c31200	MULSD gopic.RMB_sigma(SB), X0		
				vyA := sim.WorkerRMB(workerID)
  0x4c0896		f20f11442460		MOVSD_XMM X0, 0x60(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c089c		488b8c24b8000000	MOVQ 0xb8(SP), CX			
  0x4c08a4		488b91f82dba07		MOVQ 0x7ba2df8(CX), DX			
  0x4c08ab		488b5c2450		MOVQ 0x50(SP), BX			
  0x4c08b0		4839da			CMPQ DX, BX				
  0x4c08b3		0f8696010000		JBE 0x4c0a4f				
  0x4c08b9		488b89f02dba07		MOVQ 0x7ba2df0(CX), CX			
  0x4c08c0		488b04d9		MOVQ 0(CX)(BX*8), AX			
  0x4c08c4		e87753ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x4c08c9		f20f590547c31200	MULSD gopic.RMB_sigma(SB), X0		
				vzA := sim.WorkerRMB(workerID)
  0x4c08d1		f20f11442458		MOVSD_XMM X0, 0x58(SP)	
				gx := sim.Vx_i[ki] - vxA
  0x4c08d7		488b8c24a0000000	MOVQ 0xa0(SP), CX			
  0x4c08df		90			NOPL					
  0x4c08e0		4881f940420f00		CMPQ CX, $0xf4240			
  0x4c08e7		0f8358010000		JAE 0x4c0a45				
  0x4c08ed		488b8424b8000000	MOVQ 0xb8(SP), AX			
  0x4c08f5		f20f108cc8d0d8b805	MOVSD_XMM 0x5b8d8d0(AX)(CX*8), X1	
  0x4c08fe		f20f5c4c2468		SUBSD 0x68(SP), X1			
				gy := sim.Vy_i[ki] - vyA
  0x4c0904		f20f1094c8d0ea3206	MOVSD_XMM 0x632ead0(AX)(CX*8), X2	
  0x4c090d		f20f5c542460		SUBSD 0x60(SP), X2			
				gz := sim.Vz_i[ki] - vzA
  0x4c0913		f20f109cc8d0fcac06	MOVSD_XMM 0x6acfcd0(AX)(CX*8), X3	
  0x4c091c		f20f5cd8		SUBSD X0, X3				
				gSqr := gx*gx + gy*gy + gz*gz
  0x4c0920		f20f59d2		MULSD X2, X2		
  0x4c0924		c4e2f1b9d1		VFMADD231SD X1, X1, X2	
  0x4c0929		c4e2e1b9d3		VFMADD231SD X3, X3, X2	
				eIdx := minInt(int(gSqr*FACTOR_ENERGY_I+0.5), CS_RANGES-1)
  0x4c092e		f20f10051ad00000	MOVSD_XMM $f64.3fe0000000000000(SB), X0	
  0x4c0936		f20f100daacf0000	MOVSD_XMM $f64.3f1b224d182a4f02(SB), X1	
  0x4c093e		c4e2f1b9c2		VFMADD231SD X2, X1, X0			
  0x4c0943		f2480f2cd0		CVTTSD2SIQ X0, DX			
				g := math.Sqrt(gSqr)
  0x4c0948		90			NOPL			
	if a < b {
  0x4c0949		4881fa3f420f00		CMPQ DX, $0xf423f	
  0x4c0950		7c0e			JL 0x4c0960		
  0x4c0952		ba3f420f00		MOVL $0xf423f, DX	
  0x4c0957		660f1f840000000000	NOPW 0(AX)(AX*1)	
				realNu := sim.SigmaTotI[eIdx] * g
  0x4c0960		4881fa40420f00		CMPQ DX, $0xf4240	
  0x4c0967		0f83c9000000		JAE 0x4c0a36		
				eIdx := minInt(int(gSqr*FACTOR_ENERGY_I+0.5), CS_RANGES-1)
  0x4c096d		4889542448		MOVQ DX, 0x48(SP)	
	return sqrt(x)
  0x4c0972		f20f51c2		SQRTSD X2, X0		
				realNu := sim.SigmaTotI[eIdx] * g
  0x4c0976		f20f5984d0c06cdc02	MULSD 0x2dc6cc0(AX)(DX*8), X0	
  0x4c097f		f20f11442478		MOVSD_XMM X0, 0x78(SP)		
				if sim.WorkerR01(workerID)*sim.NuStarI < realNu {
  0x4c0985		488b5c2450		MOVQ 0x50(SP), BX				
  0x4c098a		e851e4ffff		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x4c098f		488b8424b8000000	MOVQ 0xb8(SP), AX				
  0x4c0997		f20f5980402eba07	MULSD 0x7ba2e40(AX), X0				
  0x4c099f		f20f104c2478		MOVSD_XMM 0x78(SP), X1				
  0x4c09a5		660f2ec8		UCOMISD X0, X1					
  0x4c09a9		770d			JA 0x4c09b8					
  0x4c09ab		488b8c2488000000	MOVQ 0x88(SP), CX				
  0x4c09b3		e9e5fdffff		JMP 0x4c079d					
					sim.CollisionIon(&sim.Vx_i[ki], &sim.Vy_i[ki], &sim.Vz_i[ki], &vxA, &vyA, &vzA, eIdx, workerID)
  0x4c09b8		488b9424a0000000	MOVQ 0xa0(SP), DX				
  0x4c09c0		488d1cd0		LEAQ 0(AX)(DX*8), BX				
  0x4c09c4		488d9bd0d8b805		LEAQ 0x5b8d8d0(BX), BX				
  0x4c09cb		488d0cd0		LEAQ 0(AX)(DX*8), CX				
  0x4c09cf		488d89d0ea3206		LEAQ 0x632ead0(CX), CX				
  0x4c09d6		488d3cd0		LEAQ 0(AX)(DX*8), DI				
  0x4c09da		488dbfd0fcac06		LEAQ 0x6acfcd0(DI), DI				
  0x4c09e1		488d742468		LEAQ 0x68(SP), SI				
  0x4c09e6		4c8d442460		LEAQ 0x60(SP), R8				
  0x4c09eb		4c8d4c2458		LEAQ 0x58(SP), R9				
  0x4c09f0		4c8b542448		MOVQ 0x48(SP), R10				
  0x4c09f5		4c8b5c2450		MOVQ 0x50(SP), R11				
  0x4c09fa		e86167ffff		CALL gopic.(*SimulationState).CollisionIon(SB)	
					localColl++
  0x4c09ff		488b8c2488000000	MOVQ 0x88(SP), CX	
  0x4c0a07		48ffc1			INCQ CX			
				ki := s + int(sim.WorkerR01(workerID)*float64(nLocal))
  0x4c0a0a		488b8424b8000000	MOVQ 0xb8(SP), AX	
					localColl++
  0x4c0a12		e986fdffff		JMP 0x4c079d		
			if localColl > 0 {
  0x4c0a17		4885c9			TESTQ CX, CX		
  0x4c0a1a		7611			JBE 0x4c0a2d		
				atomic.AddUint64(&sim.N_i_coll, localColl)
  0x4c0a1c		488b8424b8000000	MOVQ 0xb8(SP), AX		
  0x4c0a24		f0480fc188982dba07	LOCK XADDQ CX, 0x7ba2d98(AX)	
		})
  0x4c0a2d		4881c4c0000000		ADDQ $0xc0, SP		
  0x4c0a34		5d			POPQ BP			
  0x4c0a35		c3			RET			
				realNu := sim.SigmaTotI[eIdx] * g
  0x4c0a36		b840420f00		MOVL $0xf4240, AX		
  0x4c0a3b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x4c0a40		e85b10fcff		CALL runtime.panicBounds(SB)	
				gx := sim.Vx_i[ki] - vxA
  0x4c0a45		b840420f00		MOVL $0xf4240, AX		
  0x4c0a4a		e85110fcff		CALL runtime.panicBounds(SB)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x4c0a4f		e84c10fcff		CALL runtime.panicBounds(SB)	
  0x4c0a54		e84710fcff		CALL runtime.panicBounds(SB)	
  0x4c0a59		e84210fcff		CALL runtime.panicBounds(SB)	
  0x4c0a5e		90			NOPL				
		wg.Go(func() {
  0x4c0a5f		90			NOPL								
  0x4c0a60		e85bf3fbff		CALL runtime.morestack.abi0(SB)					
  0x4c0a65		e996fcffff		JMP gopic.(*SimulationState).Step8CollisionIons.func1(SB)	
