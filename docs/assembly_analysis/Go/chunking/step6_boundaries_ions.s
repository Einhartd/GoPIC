TEXT gopic.(*SimulationState).Step6CheckBoundariesIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
func (sim *SimulationState) Step6CheckBoundariesIons(t int) {
  0x4bcfe0		493b6610		CMPQ SP, 0x10(R14)	
  0x4bcfe4		0f8695040000		JBE 0x4bd47f		
  0x4bcfea		55			PUSHQ BP		
  0x4bcfeb		4889e5			MOVQ SP, BP		
  0x4bcfee		4883ec58		SUBQ $0x58, SP		
	if (t % N_SUB) != 0 {
  0x4bcff2		48bacdcccccccccccccc	MOVQ $0xcccccccccccccccd, DX	
  0x4bcffc		480fafd3		IMULQ BX, DX			
  0x4bd000		48be9899999999999919	MOVQ $0x1999999999999998, SI	
  0x4bd00a		4801f2			ADDQ SI, DX			
  0x4bd00d		48c1c23e		ROLQ $0x3e, DX			
  0x4bd011		48becccccccccccccc0c	MOVQ $0xccccccccccccccc, SI	
  0x4bd01b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x4bd020		4839d6			CMPQ SI, DX			
  0x4bd023		727d			JB 0x4bd0a2			
	numWorkers := sim.NumWorkers
  0x4bd025		8400			TESTB AL, 0(AX)		
  0x4bd027		488b90e82dba07		MOVQ 0x7ba2de8(AX), DX	
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4bd02e		488bb0c87e5603		MOVQ 0x3567ec8(AX), SI	
  0x4bd035		488d3416		LEAQ 0(SI)(DX*1), SI	
  0x4bd039		488d76ff		LEAQ -0x1(SI), SI	
  0x4bd03d		0f1f00			NOPL 0(AX)		
  0x4bd040		4885d2			TESTQ DX, DX		
  0x4bd043		0f8430040000		JE 0x4bd479		
	if (t % N_SUB) != 0 {
  0x4bd049		4889442468		MOVQ AX, 0x68(SP)	
	numWorkers := sim.NumWorkers
  0x4bd04e		4889542428		MOVQ DX, 0x28(SP)	
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4bd053		4889742448		MOVQ SI, 0x48(SP)	
	var wg sync.WaitGroup
  0x4bd058		b810000000		MOVL $0x10, AX				
  0x4bd05d		488d1d64820f00		LEAQ 0xf8264(IP), BX			
  0x4bd064		b901000000		MOVL $0x1, CX				
  0x4bd069		e8b211f6ff		CALL runtime.mallocgcSmallNoScanSC2(SB)	
  0x4bd06e		4889442450		MOVQ AX, 0x50(SP)			
  0x4bd073		4889c1			MOVQ AX, CX				
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4bd076		488b442448		MOVQ 0x48(SP), AX	
  0x4bd07b		488b742428		MOVQ 0x28(SP), SI	
  0x4bd080		4883feff		CMPQ SI, $-0x1		
  0x4bd084		7507			JNE 0x4bd08d		
  0x4bd086		48f7d8			NEGQ AX			
  0x4bd089		31d2			XORL DX, DX		
  0x4bd08b		eb05			JMP 0x4bd092		
  0x4bd08d		4899			CQO			
  0x4bd08f		48f7fe			IDIVQ SI		
  0x4bd092		4889442438		MOVQ AX, 0x38(SP)	
	for w := range numWorkers {
  0x4bd097		31d2			XORL DX, DX		
  0x4bd099		488b7c2468		MOVQ 0x68(SP), DI	
  0x4bd09e		6690			NOPW			
  0x4bd0a0		eb1f			JMP 0x4bd0c1		
		return
  0x4bd0a2		4883c458		ADDQ $0x58, SP		
  0x4bd0a6		5d			POPQ BP			
  0x4bd0a7		c3			RET			
		start := w * chunkSize
  0x4bd0a8		488b442438		MOVQ 0x38(SP), AX	
	wg.Wait()
  0x4bd0ad		488b4c2450		MOVQ 0x50(SP), CX	
	for w := range numWorkers {
  0x4bd0b2		488b742428		MOVQ 0x28(SP), SI	
		end := min((w+1)*chunkSize, sim.N_i)
  0x4bd0b7		488b7c2468		MOVQ 0x68(SP), DI	
	for w := range numWorkers {
  0x4bd0bc		488b542448		MOVQ 0x48(SP), DX	
  0x4bd0c1		4839f2			CMPQ DX, SI		
  0x4bd0c4		0f8dfb000000		JGE 0x4bd1c5		
		start := w * chunkSize
  0x4bd0ca		4989d0			MOVQ DX, R8		
  0x4bd0cd		480fafd0		IMULQ AX, DX		
		end := min((w+1)*chunkSize, sim.N_i)
  0x4bd0d1		4d8d4801		LEAQ 0x1(R8), R9	
  0x4bd0d5		4c894c2448		MOVQ R9, 0x48(SP)	
  0x4bd0da		4d89ca			MOVQ R9, R10		
  0x4bd0dd		4c0fafc8		IMULQ AX, R9		
  0x4bd0e1		4c8b9fc87e5603		MOVQ 0x3567ec8(DI), R11	
  0x4bd0e8		4d39cb			CMPQ R11, R9		
		if start >= end {
  0x4bd0eb		4d0f4ccb		CMOVL R11, R9		
  0x4bd0ef		4939d1			CMPQ R9, DX		
		end := min((w+1)*chunkSize, sim.N_i)
  0x4bd0f2		7f51			JG 0x4bd145		
			sim.WorkerIDiag[w].abs_pow = 0
  0x4bd0f4		488b5750			MOVQ 0x50(DI), DX		
  0x4bd0f8		0f1f840000000000		NOPL 0(AX)(AX*1)		
  0x4bd100		4939d0				CMPQ R8, DX			
  0x4bd103		0f836b030000			JAE 0x4bd474			
  0x4bd109		488b5748			MOVQ 0x48(DI), DX		
  0x4bd10d		4d69c840320000			IMULQ $0x3240, R8, R9		
  0x4bd114		4ac7840a8025000000000000	MOVQ $0x0, 0x2580(DX)(R9*1)	
			sim.WorkerIDiag[w].abs_gnd = 0
  0x4bd120		488b5750			MOVQ 0x50(DI), DX		
  0x4bd124		4939d0				CMPQ R8, DX			
  0x4bd127		0f8342030000			JAE 0x4bd46f			
  0x4bd12d		488b5748			MOVQ 0x48(DI), DX		
  0x4bd131		4ac7840a8825000000000000	MOVQ $0x0, 0x2588(DX)(R9*1)	
			for idx := range N_IFED {
  0x4bd13d		31d2			XORL DX, DX		
  0x4bd13f		90			NOPL			
  0x4bd140		e9bb020000		JMP 0x4bd400		
	for w := range numWorkers {
  0x4bd145		4c89442440		MOVQ R8, 0x40(SP)	
		start := w * chunkSize
  0x4bd14a		4889542420		MOVQ DX, 0x20(SP)	
		if start >= end {
  0x4bd14f		4c894c2430		MOVQ R9, 0x30(SP)	
		wg.Go(func() {
  0x4bd154		b828000000		MOVL $0x28, AX								
  0x4bd159		488d1d50a50f00		LEAQ 0xfa550(IP), BX							
  0x4bd160		b901000000		MOVL $0x1, CX								
  0x4bd165		e85602f6ff		CALL runtime.mallocgcSmallScanNoHeaderSC5(SB)				
  0x4bd16a		488d150f300000		LEAQ gopic.(*SimulationState).Step6CheckBoundariesIons.func1(SB), DX	
  0x4bd171		488910			MOVQ DX, 0(AX)								
  0x4bd174		833df5fc120000		CMPL runtime.writeBarrier(SB), $0x0					
  0x4bd17b		7507			JNE 0x4bd184								
  0x4bd17d		488b4c2468		MOVQ 0x68(SP), CX							
  0x4bd182		eb0d			JMP 0x4bd191								
  0x4bd184		e85745fcff		CALL runtime.gcWriteBarrier1(SB)					
  0x4bd189		488b4c2468		MOVQ 0x68(SP), CX							
  0x4bd18e		49890b			MOVQ CX, 0(R11)								
  0x4bd191		48894808		MOVQ CX, 0x8(AX)							
  0x4bd195		488b4c2440		MOVQ 0x40(SP), CX							
  0x4bd19a		48894810		MOVQ CX, 0x10(AX)							
  0x4bd19e		488b4c2420		MOVQ 0x20(SP), CX							
  0x4bd1a3		48894818		MOVQ CX, 0x18(AX)							
  0x4bd1a7		488b4c2430		MOVQ 0x30(SP), CX							
  0x4bd1ac		48894820		MOVQ CX, 0x20(AX)							
  0x4bd1b0		4889c3			MOVQ AX, BX								
  0x4bd1b3		488b442450		MOVQ 0x50(SP), AX							
  0x4bd1b8		e803c8fcff		CALL sync.(*WaitGroup).Go(SB)						
  0x4bd1bd		0f1f00			NOPL 0(AX)								
  0x4bd1c0		e9e3feffff		JMP 0x4bd0a8								
	wg.Wait()
  0x4bd1c5		4889c8			MOVQ CX, AX			
  0x4bd1c8		e8d3c6fcff		CALL sync.(*WaitGroup).Wait(SB)	
	for w := range numWorkers {
  0x4bd1cd		31c9			XORL CX, CX		
  0x4bd1cf		31d2			XORL DX, DX		
  0x4bd1d1		488b5c2428		MOVQ 0x28(SP), BX	
  0x4bd1d6		488b742468		MOVQ 0x68(SP), SI	
  0x4bd1db		eb06			JMP 0x4bd1e3		
  0x4bd1dd		48ffc1			INCQ CX			
  0x4bd1e0		4889c2			MOVQ AX, DX		
  0x4bd1e3		4839d9			CMPQ CX, BX		
  0x4bd1e6		0f8dae000000		JGE 0x4bd29a		
		p := sim.WorkerIDiag[w].abs_pow
  0x4bd1ec		488b4650		MOVQ 0x50(SI), AX		
  0x4bd1f0		4839c1			CMPQ CX, AX			
  0x4bd1f3		0f83e5010000		JAE 0x4bd3de			
  0x4bd1f9		488b4648		MOVQ 0x48(SI), AX		
  0x4bd1fd		4869f940320000		IMULQ $0x3240, CX, DI		
  0x4bd204		4c8b843880250000	MOVQ 0x2580(AX)(DI*1), R8	
		g := sim.WorkerIDiag[w].abs_gnd
  0x4bd20c		488b843888250000	MOVQ 0x2588(AX)(DI*1), AX	
		sim.N_i_abs_pow += p
  0x4bd214		4c018660662707		ADDQ R8, 0x7276660(SI)	
		sim.N_i_abs_gnd += g
  0x4bd21b		48018668662707		ADDQ AX, 0x7276668(SI)	
		totalAbs += int(p + g)
  0x4bd222		4c01c0			ADDQ R8, AX		
  0x4bd225		4801d0			ADDQ DX, AX		
		for eIdx := range N_IFED {
  0x4bd228		31d2			XORL DX, DX		
  0x4bd22a		eb1e			JMP 0x4bd24a		
			sim.Ifed_gnd[eIdx] += sim.WorkerIDiag[w].ifed_gnd[eIdx]
  0x4bd22c		4c8b4648		MOVQ 0x48(SI), R8		
  0x4bd230		4d8d0438		LEAQ 0(R8)(DI*1), R8		
  0x4bd234		4d8d80d02b0000		LEAQ 0x2bd0(R8), R8		
  0x4bd23b		4d030cd0		ADDQ 0(R8)(DX*8), R9		
  0x4bd23f		4c898cd630ab2707	MOVQ R9, 0x727ab30(SI)(DX*8)	
		for eIdx := range N_IFED {
  0x4bd247		48ffc2			INCQ DX			
  0x4bd24a		4881fac8000000		CMPQ DX, $0xc8		
  0x4bd251		7d8a			JGE 0x4bd1dd		
			sim.Ifed_pow[eIdx] += sim.WorkerIDiag[w].ifed_pow[eIdx]
  0x4bd253		4c8b4650		MOVQ 0x50(SI), R8		
  0x4bd257		4c8b8cd6f0a42707	MOVQ 0x727a4f0(SI)(DX*8), R9	
  0x4bd25f		90			NOPL				
  0x4bd260		4c39c1			CMPQ CX, R8			
  0x4bd263		0f8370010000		JAE 0x4bd3d9			
  0x4bd269		4c8b4648		MOVQ 0x48(SI), R8		
  0x4bd26d		4d8d0438		LEAQ 0(R8)(DI*1), R8		
  0x4bd271		4d8d8090250000		LEAQ 0x2590(R8), R8		
  0x4bd278		4d030cd0		ADDQ 0(R8)(DX*8), R9		
  0x4bd27c		4c898cd6f0a42707	MOVQ R9, 0x727a4f0(SI)(DX*8)	
			sim.Ifed_gnd[eIdx] += sim.WorkerIDiag[w].ifed_gnd[eIdx]
  0x4bd284		4c8b4650		MOVQ 0x50(SI), R8		
  0x4bd288		4c8b8cd630ab2707	MOVQ 0x727ab30(SI)(DX*8), R9	
  0x4bd290		4c39c1			CMPQ CX, R8			
  0x4bd293		7297			JB 0x4bd22c			
  0x4bd295		e93a010000		JMP 0x4bd3d4			
	if totalAbs > 0 {
  0x4bd29a		4885d2			TESTQ DX, DX		
  0x4bd29d		7e0e			JLE 0x4bd2ad		
		lastValid := sim.N_i - 1
  0x4bd29f		488b86c87e5603		MOVQ 0x3567ec8(SI), AX	
  0x4bd2a6		48ffc8			DECQ AX			
		for w := range numWorkers {
  0x4bd2a9		31c9			XORL CX, CX		
  0x4bd2ab		eb09			JMP 0x4bd2b6		
}
  0x4bd2ad		4883c458		ADDQ $0x58, SP		
  0x4bd2b1		5d			POPQ BP			
  0x4bd2b2		c3			RET			
		for w := range numWorkers {
  0x4bd2b3		48ffc1			INCQ CX			
  0x4bd2b6		4839d9			CMPQ CX, BX		
  0x4bd2b9		0f8de6000000		JGE 0x4bd3a5		
			for _, deadIdx := range sim.WorkerDeadIons[w] {
  0x4bd2bf		488bbe80000000		MOVQ 0x80(SI), DI	
  0x4bd2c6		4839f9			CMPQ CX, DI		
  0x4bd2c9		0f8300010000		JAE 0x4bd3cf		
  0x4bd2cf		488b7e78		MOVQ 0x78(SI), DI	
  0x4bd2d3		4c8d0449		LEAQ 0(CX)(CX*2), R8	
  0x4bd2d7		4e8b0cc7		MOVQ 0(DI)(R8*8), R9	
  0x4bd2db		4a8b7cc708		MOVQ 0x8(DI)(R8*8), DI	
  0x4bd2e0		4531c0			XORL R8, R8		
  0x4bd2e3		eb03			JMP 0x4bd2e8		
  0x4bd2e5		49ffc0			INCQ R8			
  0x4bd2e8		4939f8			CMPQ R8, DI		
  0x4bd2eb		7dc6			JGE 0x4bd2b3		
  0x4bd2ed		4f8b14c1		MOVQ 0(R9)(R8*8), R10	
				for lastValid > deadIdx && (sim.X_i[lastValid] < 0 || sim.X_i[lastValid] > L) {
  0x4bd2f1		eb03			JMP 0x4bd2f6		
					lastValid--
  0x4bd2f3		48ffc8			DECQ AX			
				for lastValid > deadIdx && (sim.X_i[lastValid] < 0 || sim.X_i[lastValid] > L) {
  0x4bd2f6		4c39d0			CMPQ AX, R10				
  0x4bd2f9		0f8e95000000		JLE 0x4bd394				
  0x4bd2ff		90			NOPL					
  0x4bd300		483d40420f00		CMPQ AX, $0xf4240			
  0x4bd306		0f83b9000000		JAE 0x4bd3c5				
  0x4bd30c		f20f1084c6d0c63e05	MOVSD_XMM 0x53ec6d0(SI)(AX*8), X0	
  0x4bd315		0f57c9			XORPS X1, X1				
  0x4bd318		660f2ec8		UCOMISD X0, X1				
  0x4bd31c		77d5			JA 0x4bd2f3				
  0x4bd31e		f20f1015d2040100	MOVSD_XMM 0x104d2(IP), X2		
  0x4bd326		660f2ec2		UCOMISD X2, X0				
  0x4bd32a		77c7			JA 0x4bd2f3				
  0x4bd32c		4c39d0			CMPQ AX, R10				
				if lastValid > deadIdx {
  0x4bd32f		7eb4			JLE 0x4bd2e5		
				for lastValid > deadIdx && (sim.X_i[lastValid] < 0 || sim.X_i[lastValid] > L) {
  0x4bd331		483d40420f00		CMPQ AX, $0xf4240	
					sim.X_i[deadIdx] = sim.X_i[lastValid]
  0x4bd337		0f837e000000		JAE 0x4bd3bb				
  0x4bd33d		0f1f00			NOPL 0(AX)				
  0x4bd340		4981fa40420f00		CMPQ R10, $0xf4240			
  0x4bd347		7368			JAE 0x4bd3b1				
  0x4bd349		f2420f1184d6d0c63e05	MOVSD_XMM X0, 0x53ec6d0(SI)(R10*8)	
					sim.Vx_i[deadIdx] = sim.Vx_i[lastValid]
  0x4bd353		f20f1084c6d0d8b805	MOVSD_XMM 0x5b8d8d0(SI)(AX*8), X0	
  0x4bd35c		f2420f1184d6d0d8b805	MOVSD_XMM X0, 0x5b8d8d0(SI)(R10*8)	
					sim.Vy_i[deadIdx] = sim.Vy_i[lastValid]
  0x4bd366		f20f1084c6d0ea3206	MOVSD_XMM 0x632ead0(SI)(AX*8), X0	
  0x4bd36f		f2420f1184d6d0ea3206	MOVSD_XMM X0, 0x632ead0(SI)(R10*8)	
					sim.Vz_i[deadIdx] = sim.Vz_i[lastValid]
  0x4bd379		f20f1084c6d0fcac06	MOVSD_XMM 0x6acfcd0(SI)(AX*8), X0	
  0x4bd382		f2420f1184d6d0fcac06	MOVSD_XMM X0, 0x6acfcd0(SI)(R10*8)	
					lastValid--
  0x4bd38c		48ffc8			DECQ AX				
  0x4bd38f		e951ffffff		JMP 0x4bd2e5			
  0x4bd394		0f57c9			XORPS X1, X1			
  0x4bd397		f20f101559040100	MOVSD_XMM 0x10459(IP), X2	
  0x4bd39f		90			NOPL				
				for lastValid > deadIdx && (sim.X_i[lastValid] < 0 || sim.X_i[lastValid] > L) {
  0x4bd3a0		e940ffffff		JMP 0x4bd2e5		
		sim.N_i -= totalAbs
  0x4bd3a5		482996c87e5603		SUBQ DX, 0x3567ec8(SI)	
  0x4bd3ac		e9fcfeffff		JMP 0x4bd2ad		
					sim.X_i[deadIdx] = sim.X_i[lastValid]
  0x4bd3b1		b840420f00		MOVL $0xf4240, AX		
  0x4bd3b6		e8e546fcff		CALL runtime.panicBounds(SB)	
  0x4bd3bb		b940420f00		MOVL $0xf4240, CX		
  0x4bd3c0		e8db46fcff		CALL runtime.panicBounds(SB)	
				for lastValid > deadIdx && (sim.X_i[lastValid] < 0 || sim.X_i[lastValid] > L) {
  0x4bd3c5		b940420f00		MOVL $0xf4240, CX		
  0x4bd3ca		e8d146fcff		CALL runtime.panicBounds(SB)	
			for _, deadIdx := range sim.WorkerDeadIons[w] {
  0x4bd3cf		e8cc46fcff		CALL runtime.panicBounds(SB)	
			sim.Ifed_gnd[eIdx] += sim.WorkerIDiag[w].ifed_gnd[eIdx]
  0x4bd3d4		e8c746fcff		CALL runtime.panicBounds(SB)	
			sim.Ifed_pow[eIdx] += sim.WorkerIDiag[w].ifed_pow[eIdx]
  0x4bd3d9		e8c246fcff		CALL runtime.panicBounds(SB)	
		p := sim.WorkerIDiag[w].abs_pow
  0x4bd3de		6690			NOPW				
  0x4bd3e0		e8bb46fcff		CALL runtime.panicBounds(SB)	
				sim.WorkerIDiag[w].ifed_gnd[idx] = 0
  0x4bd3e5		4c8b5f48		MOVQ 0x48(DI), R11	
  0x4bd3e9		4f8d1c0b		LEAQ 0(R11)(R9*1), R11	
  0x4bd3ed		4d8d9bd02b0000		LEAQ 0x2bd0(R11), R11	
  0x4bd3f4		49c704d300000000	MOVQ $0x0, 0(R11)(DX*8)	
			for idx := range N_IFED {
  0x4bd3fc		48ffc2			INCQ DX			
  0x4bd3ff		90			NOPL			
  0x4bd400		4881fac8000000		CMPQ DX, $0xc8		
  0x4bd407		7d2b			JGE 0x4bd434		
				sim.WorkerIDiag[w].ifed_pow[idx] = 0
  0x4bd409		4c8b5f50		MOVQ 0x50(DI), R11	
  0x4bd40d		4d39d8			CMPQ R8, R11		
  0x4bd410		7358			JAE 0x4bd46a		
  0x4bd412		4c8b5f48		MOVQ 0x48(DI), R11	
  0x4bd416		4f8d1c0b		LEAQ 0(R11)(R9*1), R11	
  0x4bd41a		4d8d9b90250000		LEAQ 0x2590(R11), R11	
  0x4bd421		49c704d300000000	MOVQ $0x0, 0(R11)(DX*8)	
				sim.WorkerIDiag[w].ifed_gnd[idx] = 0
  0x4bd429		4c8b5f50		MOVQ 0x50(DI), R11	
  0x4bd42d		4d39d8			CMPQ R8, R11		
  0x4bd430		72b3			JB 0x4bd3e5		
  0x4bd432		eb31			JMP 0x4bd465		
			sim.WorkerDeadIons[w] = sim.WorkerDeadIons[w][:0]
  0x4bd434		488b9780000000		MOVQ 0x80(DI), DX		
  0x4bd43b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x4bd440		4939d0			CMPQ R8, DX			
  0x4bd443		7316			JAE 0x4bd45b			
  0x4bd445		4b8d1440		LEAQ 0(R8)(R8*2), DX		
  0x4bd449		4c8b4778		MOVQ 0x78(DI), R8		
  0x4bd44d		49c744d00800000000	MOVQ $0x0, 0x8(R8)(DX*8)	
			continue
  0x4bd456		e94dfcffff		JMP 0x4bd0a8		
			sim.WorkerDeadIons[w] = sim.WorkerDeadIons[w][:0]
  0x4bd45b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x4bd460		e83b46fcff		CALL runtime.panicBounds(SB)	
				sim.WorkerIDiag[w].ifed_gnd[idx] = 0
  0x4bd465		e83646fcff		CALL runtime.panicBounds(SB)	
				sim.WorkerIDiag[w].ifed_pow[idx] = 0
  0x4bd46a		e83146fcff		CALL runtime.panicBounds(SB)	
			sim.WorkerIDiag[w].abs_gnd = 0
  0x4bd46f		e82c46fcff		CALL runtime.panicBounds(SB)	
			sim.WorkerIDiag[w].abs_pow = 0
  0x4bd474		e82746fcff		CALL runtime.panicBounds(SB)	
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4bd479		e8a273f8ff		CALL runtime.panicdivide(SB)	
  0x4bd47e		90			NOPL				
func (sim *SimulationState) Step6CheckBoundariesIons(t int) {
  0x4bd47f		4889442408		MOVQ AX, 0x8(SP)						
  0x4bd484		48895c2410		MOVQ BX, 0x10(SP)						
  0x4bd489		e8d229fcff		CALL runtime.morestack_noctxt.abi0(SB)				
  0x4bd48e		488b442408		MOVQ 0x8(SP), AX						
  0x4bd493		488b5c2410		MOVQ 0x10(SP), BX						
  0x4bd498		e943fbffff		JMP gopic.(*SimulationState).Step6CheckBoundariesIons(SB)	

TEXT gopic.(*SimulationState).Step6CheckBoundariesIons.func1(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
		wg.Go(func() {
  0x4c0180		493b6610		CMPQ SP, 0x10(R14)	
  0x4c0184		0f8606030000		JBE 0x4c0490		
  0x4c018a		55			PUSHQ BP		
  0x4c018b		4889e5			MOVQ SP, BP		
  0x4c018e		4883ec78		SUBQ $0x78, SP		
  0x4c0192		4c8b4210		MOVQ 0x10(DX), R8	
  0x4c0196		4c8b4a08		MOVQ 0x8(DX), R9	
			diag := &sim.WorkerIDiag[workerID]
  0x4c019a		4d8b5150		MOVQ 0x50(R9), R10	
		wg.Go(func() {
  0x4c019e		4c8b5a18		MOVQ 0x18(DX), R11	
  0x4c01a2		488b5220		MOVQ 0x20(DX), DX	
			diag := &sim.WorkerIDiag[workerID]
  0x4c01a6		4d39c2			CMPQ R10, R8		
  0x4c01a9		0f86db020000		JBE 0x4c048a		
  0x4c01af		4d8b5148		MOVQ 0x48(R9), R10	
  0x4c01b3		4d69e040320000		IMULQ $0x3240, R8, R12	
			diag.abs_pow = 0
  0x4c01ba		4f8d2c22		LEAQ 0(R10)(R12*1), R13	
  0x4c01be		4d8dad80250000		LEAQ 0x2580(R13), R13	
  0x4c01c5		450f117d00		MOVUPS X15, 0(R13)	
			for idx := range N_IFED {
  0x4c01ca		4531ed			XORL R13, R13		
  0x4c01cd		eb31			JMP 0x4c0200		
				diag.ifed_pow[idx] = 0
  0x4c01cf		4f8d3c14		LEAQ 0(R12)(R10*1), R15		
  0x4c01d3		4d8dbf90250000		LEAQ 0x2590(R15), R15		
  0x4c01da		4bc704ef00000000	MOVQ $0x0, 0(R15)(R13*8)	
				diag.ifed_gnd[idx] = 0
  0x4c01e2		4f8d3c14		LEAQ 0(R12)(R10*1), R15		
  0x4c01e6		4d8dbfd02b0000		LEAQ 0x2bd0(R15), R15		
  0x4c01ed		4bc704ef00000000	MOVQ $0x0, 0(R15)(R13*8)	
			for idx := range N_IFED {
  0x4c01f5		49ffc5			INCQ R13		
  0x4c01f8		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x4c0200		4981fdc8000000		CMPQ R13, $0xc8		
  0x4c0207		7cc6			JL 0x4c01cf		
			dead := sim.WorkerDeadIons[workerID][:0]
  0x4c0209		4d8ba980000000		MOVQ 0x80(R9), R13	
  0x4c0210		4d39c5			CMPQ R13, R8		
  0x4c0213		0f866c020000		JBE 0x4c0485		
		wg.Go(func() {
  0x4c0219		4c894c2468		MOVQ R9, 0x68(SP)	
  0x4c021e		4c89442440		MOVQ R8, 0x40(SP)	
  0x4c0223		4889542450		MOVQ DX, 0x50(SP)	
			diag := &sim.WorkerIDiag[workerID]
  0x4c0228		4c89542470		MOVQ R10, 0x70(SP)	
  0x4c022d		4c89642460		MOVQ R12, 0x60(SP)	
			dead := sim.WorkerDeadIons[workerID][:0]
  0x4c0232		4d8b6978		MOVQ 0x78(R9), R13		
  0x4c0236		4f8d3c40		LEAQ 0(R8)(R8*2), R15		
  0x4c023a		4c897c2458		MOVQ R15, 0x58(SP)		
  0x4c023f		4b8b44fd00		MOVQ 0(R13)(R15*8), AX		
  0x4c0244		4b8b4cfd10		MOVQ 0x10(R13)(R15*8), CX	
			for k := s; k < e; k++ {
  0x4c0249		4531ed			XORL R13, R13		
  0x4c024c		eb06			JMP 0x4c0254		
  0x4c024e		49ffc3			INCQ R11		
  0x4c0251		4989dd			MOVQ BX, R13		
  0x4c0254		4939d3			CMPQ R11, DX		
  0x4c0257		0f8dc8010000		JGE 0x4c0425		
  0x4c025d		0f1f00			NOPL 0(AX)		
				if sim.X_i[k] < 0 {
  0x4c0260		4981fb40420f00		CMPQ R11, $0xf4240	
  0x4c0267		0f830e020000		JAE 0x4c047b		
			for k := s; k < e; k++ {
  0x4c026d		4c895c2448		MOVQ R11, 0x48(SP)	
				if sim.X_i[k] < 0 {
  0x4c0272		f2430f1084d9d0c63e05	MOVSD_XMM 0x53ec6d0(R9)(R11*8), X0	
  0x4c027c		0f57c9			XORPS X1, X1				
  0x4c027f		660f2ec8		UCOMISD X0, X1				
  0x4c0283		0f86be000000		JBE 0x4c0347				
					dead = append(dead, k)
  0x4c0289		498d5d01		LEAQ 0x1(R13), BX		
  0x4c028d		4839d9			CMPQ CX, BX			
  0x4c0290		7339			JAE 0x4c02cb			
  0x4c0292		bf01000000		MOVL $0x1, DI			
  0x4c0297		488d352add0e00		LEAQ 0xedd2a(IP), SI		
  0x4c029e		6690			NOPW				
  0x4c02a0		e87bd3fbff		CALL runtime.growslice(SB)	
			for k := s; k < e; k++ {
  0x4c02a5		488b542450		MOVQ 0x50(SP), DX	
			sim.WorkerDeadIons[workerID] = dead
  0x4c02aa		4c8b442440		MOVQ 0x40(SP), R8	
					v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x4c02af		4c8b4c2468		MOVQ 0x68(SP), R9	
					diag.abs_pow++
  0x4c02b4		4c8b542470		MOVQ 0x70(SP), R10	
					dead = append(dead, k)
  0x4c02b9		4c8b5c2448		MOVQ 0x48(SP), R11	
					diag.abs_pow++
  0x4c02be		4c8b642460		MOVQ 0x60(SP), R12	
			sim.WorkerDeadIons[workerID] = dead
  0x4c02c3		4c8b7c2458		MOVQ 0x58(SP), R15	
  0x4c02c8		0f57c9			XORPS X1, X1		
					dead = append(dead, k)
  0x4c02cb		4c895cd8f8		MOVQ R11, -0x8(AX)(BX*8)	
					diag.abs_pow++
  0x4c02d0		4bff842280250000	INCQ 0x2580(R10)(R12*1)	
					v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x4c02d8		f2430f1084d9d0d8b805	MOVSD_XMM 0x5b8d8d0(R9)(R11*8), X0	
  0x4c02e2		f20f59c0		MULSD X0, X0				
  0x4c02e6		f2430f1094d9d0ea3206	MOVSD_XMM 0x632ead0(R9)(R11*8), X2	
  0x4c02f0		c4e2e9b9c2		VFMADD231SD X2, X2, X0			
  0x4c02f5		f2430f1094d9d0fcac06	MOVSD_XMM 0x6acfcd0(R9)(R11*8), X2	
  0x4c02ff		c4e2e9b9c2		VFMADD231SD X2, X2, X0			
					energy_index = int(v_sqr * FACTOR_ENERGY_IFED)
  0x4c0304		f20f1015bcd50000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X2	
  0x4c030c		f20f59c2		MULSD X2, X0				
  0x4c0310		f24c0f2ce8		CVTTSD2SIQ X0, R13			
  0x4c0315		660f1f840000000000	NOPW 0(AX)(AX*1)			
  0x4c031e		6690			NOPW					
					if energy_index < N_IFED {
  0x4c0320		4981fdc8000000		CMPQ R13, $0xc8		
  0x4c0327		0f8d21ffffff		JGE 0x4c024e		
						diag.ifed_pow[energy_index]++
  0x4c032d		4b8d3414		LEAQ 0(R12)(R10*1), SI	
  0x4c0331		488db690250000		LEAQ 0x2590(SI), SI	
  0x4c0338		0f8333010000		JAE 0x4c0471		
  0x4c033e		4aff04ee		INCQ 0(SI)(R13*8)	
  0x4c0342		e907ffffff		JMP 0x4c024e		
				} else if sim.X_i[k] > L {
  0x4c0347		f20f1015a9d40000	MOVSD_XMM 0xd4a9(IP), X2	
  0x4c034f		660f2ec2		UCOMISD X2, X0			
  0x4c0353		0f86b1000000		JBE 0x4c040a			
					dead = append(dead, k)
  0x4c0359		498d5d01		LEAQ 0x1(R13), BX		
  0x4c035d		0f1f00			NOPL 0(AX)			
  0x4c0360		4839d9			CMPQ CX, BX			
  0x4c0363		733f			JAE 0x4c03a4			
  0x4c0365		bf01000000		MOVL $0x1, DI			
  0x4c036a		488d3557dc0e00		LEAQ 0xedc57(IP), SI		
  0x4c0371		e8aad2fbff		CALL runtime.growslice(SB)	
			for k := s; k < e; k++ {
  0x4c0376		488b542450		MOVQ 0x50(SP), DX	
			sim.WorkerDeadIons[workerID] = dead
  0x4c037b		4c8b442440		MOVQ 0x40(SP), R8	
					v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x4c0380		4c8b4c2468		MOVQ 0x68(SP), R9	
					diag.abs_gnd++
  0x4c0385		4c8b542470		MOVQ 0x70(SP), R10	
					dead = append(dead, k)
  0x4c038a		4c8b5c2448		MOVQ 0x48(SP), R11	
					diag.abs_gnd++
  0x4c038f		4c8b642460		MOVQ 0x60(SP), R12	
			sim.WorkerDeadIons[workerID] = dead
  0x4c0394		4c8b7c2458		MOVQ 0x58(SP), R15		
  0x4c0399		0f57c9			XORPS X1, X1			
  0x4c039c		f20f101554d40000	MOVSD_XMM 0xd454(IP), X2	
					dead = append(dead, k)
  0x4c03a4		4c895cd8f8		MOVQ R11, -0x8(AX)(BX*8)	
					diag.abs_gnd++
  0x4c03a9		4bff842288250000	INCQ 0x2588(R10)(R12*1)	
					v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x4c03b1		f2430f1084d9d0d8b805	MOVSD_XMM 0x5b8d8d0(R9)(R11*8), X0	
  0x4c03bb		f20f59c0		MULSD X0, X0				
  0x4c03bf		f2430f109cd9d0ea3206	MOVSD_XMM 0x632ead0(R9)(R11*8), X3	
  0x4c03c9		c4e2e1b9c3		VFMADD231SD X3, X3, X0			
  0x4c03ce		f2430f109cd9d0fcac06	MOVSD_XMM 0x6acfcd0(R9)(R11*8), X3	
  0x4c03d8		c4e2e1b9c3		VFMADD231SD X3, X3, X0			
					energy_index = int(v_sqr * FACTOR_ENERGY_IFED)
  0x4c03dd		f20f101de3d40000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X3	
  0x4c03e5		f20f59c3		MULSD X3, X0				
  0x4c03e9		f24c0f2ce8		CVTTSD2SIQ X0, R13			
					if energy_index < N_IFED {
  0x4c03ee		4981fdc8000000		CMPQ R13, $0xc8		
  0x4c03f5		7d1e			JGE 0x4c0415		
						diag.ifed_gnd[energy_index]++
  0x4c03f7		4b8d3414		LEAQ 0(R12)(R10*1), SI			
  0x4c03fb		488db6d02b0000		LEAQ 0x2bd0(SI), SI			
  0x4c0402		7363			JAE 0x4c0467				
  0x4c0404		4aff04ee		INCQ 0(SI)(R13*8)			
  0x4c0408		eb0b			JMP 0x4c0415				
  0x4c040a		f20f101db6d40000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X3	
  0x4c0412		4c89eb			MOVQ R13, BX				
  0x4c0415		f20f1015abd40000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X2	
  0x4c041d		0f1f00			NOPL 0(AX)				
  0x4c0420		e929feffff		JMP 0x4c024e				
			sim.WorkerDeadIons[workerID] = dead
  0x4c0425		498b9180000000		MOVQ 0x80(R9), DX			
  0x4c042c		4c39c2			CMPQ DX, R8				
  0x4c042f		7631			JBE 0x4c0462				
  0x4c0431		498b5178		MOVQ 0x78(R9), DX			
  0x4c0435		4e896cfa08		MOVQ R13, 0x8(DX)(R15*8)		
  0x4c043a		4a894cfa10		MOVQ CX, 0x10(DX)(R15*8)		
  0x4c043f		833d2aca120000		CMPL runtime.writeBarrier(SB), $0x0	
  0x4c0446		7410			JE 0x4c0458				
  0x4c0448		4a8b0cfa		MOVQ 0(DX)(R15*8), CX			
  0x4c044c		e8af12fcff		CALL runtime.gcWriteBarrier2(SB)	
  0x4c0451		498903			MOVQ AX, 0(R11)				
  0x4c0454		49894b08		MOVQ CX, 0x8(R11)			
  0x4c0458		4a8904fa		MOVQ AX, 0(DX)(R15*8)			
		})
  0x4c045c		4883c478		ADDQ $0x78, SP		
  0x4c0460		5d			POPQ BP			
  0x4c0461		c3			RET			
			sim.WorkerDeadIons[workerID] = dead
  0x4c0462		e83916fcff		CALL runtime.panicBounds(SB)	
						diag.ifed_gnd[energy_index]++
  0x4c0467		b8c8000000		MOVL $0xc8, AX			
  0x4c046c		e82f16fcff		CALL runtime.panicBounds(SB)	
						diag.ifed_pow[energy_index]++
  0x4c0471		b8c8000000		MOVL $0xc8, AX			
  0x4c0476		e82516fcff		CALL runtime.panicBounds(SB)	
				if sim.X_i[k] < 0 {
  0x4c047b		b840420f00		MOVL $0xf4240, AX		
  0x4c0480		e81b16fcff		CALL runtime.panicBounds(SB)	
			dead := sim.WorkerDeadIons[workerID][:0]
  0x4c0485		e81616fcff		CALL runtime.panicBounds(SB)	
			diag := &sim.WorkerIDiag[workerID]
  0x4c048a		e81116fcff		CALL runtime.panicBounds(SB)	
  0x4c048f		90			NOPL				
		wg.Go(func() {
  0x4c0490		e82bf9fbff		CALL runtime.morestack.abi0(SB)					
  0x4c0495		e9e6fcffff		JMP gopic.(*SimulationState).Step6CheckBoundariesIons.func1(SB)	
