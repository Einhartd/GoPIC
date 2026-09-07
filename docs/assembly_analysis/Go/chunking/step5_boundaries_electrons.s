TEXT gopic.(*SimulationState).Step5CheckBoundariesElectrons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
func (sim *SimulationState) Step5CheckBoundariesElectrons() {
  0x4bcc40		493b6610		CMPQ SP, 0x10(R14)	
  0x4bcc44		0f8670030000		JBE 0x4bcfba		
  0x4bcc4a		55			PUSHQ BP		
  0x4bcc4b		4889e5			MOVQ SP, BP		
  0x4bcc4e		4883ec58		SUBQ $0x58, SP		
	numWorkers := sim.NumWorkers
  0x4bcc52		8400			TESTB AL, 0(AX)		
  0x4bcc54		488b90e82dba07		MOVQ 0x7ba2de8(AX), DX	
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bcc5b		488bb0c07e5603		MOVQ 0x3567ec0(AX), SI	
  0x4bcc62		488d3416		LEAQ 0(SI)(DX*1), SI	
  0x4bcc66		488d76ff		LEAQ -0x1(SI), SI	
  0x4bcc6a		4885d2			TESTQ DX, DX		
  0x4bcc6d		0f8441030000		JE 0x4bcfb4		
  0x4bcc73		4889442468		MOVQ AX, 0x68(SP)	
	numWorkers := sim.NumWorkers
  0x4bcc78		4889542428		MOVQ DX, 0x28(SP)	
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bcc7d		4889742448		MOVQ SI, 0x48(SP)	
	var wg sync.WaitGroup
  0x4bcc82		b810000000		MOVL $0x10, AX				
  0x4bcc87		488d1d3a860f00		LEAQ 0xf863a(IP), BX			
  0x4bcc8e		b901000000		MOVL $0x1, CX				
  0x4bcc93		e88815f6ff		CALL runtime.mallocgcSmallNoScanSC2(SB)	
  0x4bcc98		4889442450		MOVQ AX, 0x50(SP)			
  0x4bcc9d		4889c1			MOVQ AX, CX				
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bcca0		488b442448		MOVQ 0x48(SP), AX	
  0x4bcca5		488b742428		MOVQ 0x28(SP), SI	
  0x4bccaa		4883feff		CMPQ SI, $-0x1		
  0x4bccae		7507			JNE 0x4bccb7		
  0x4bccb0		48f7d8			NEGQ AX			
  0x4bccb3		31d2			XORL DX, DX		
  0x4bccb5		eb05			JMP 0x4bccbc		
  0x4bccb7		4899			CQO			
  0x4bccb9		48f7fe			IDIVQ SI		
  0x4bccbc		4889442438		MOVQ AX, 0x38(SP)	
	for w := range numWorkers {
  0x4bccc1		31d2			XORL DX, DX		
  0x4bccc3		488b7c2468		MOVQ 0x68(SP), DI	
  0x4bccc8		eb03			JMP 0x4bcccd		
  0x4bccca		4c89d2			MOVQ R10, DX		
  0x4bcccd		4839f2			CMPQ DX, SI		
  0x4bccd0		0f8d2f010000		JGE 0x4bce05		
		start := w * chunkSize
  0x4bccd6		4989d0			MOVQ DX, R8		
  0x4bccd9		480fafd0		IMULQ AX, DX		
		end := min((w+1)*chunkSize, sim.N_e)
  0x4bccdd		4d8d4801		LEAQ 0x1(R8), R9	
  0x4bcce1		4d89ca			MOVQ R9, R10		
  0x4bcce4		4c0fafc8		IMULQ AX, R9		
  0x4bcce8		4c8b9fc07e5603		MOVQ 0x3567ec0(DI), R11	
  0x4bccef		4d39cb			CMPQ R11, R9		
		if start >= end {
  0x4bccf2		4d0f4ccb		CMOVL R11, R9		
  0x4bccf6		4939d1			CMPQ R9, DX		
		end := min((w+1)*chunkSize, sim.N_e)
  0x4bccf9		7f6a			JG 0x4bcd65		
			sim.WorkerEDiag[w].abs_pow = 0
  0x4bccfb		488b5738			MOVQ 0x38(DI), DX		
  0x4bccff		90				NOPL				
  0x4bcd00		4939d0				CMPQ R8, DX			
  0x4bcd03		0f83a6020000			JAE 0x4bcfaf			
  0x4bcd09		488b5730			MOVQ 0x30(DI), DX		
  0x4bcd0d		4d69c8c0700000			IMULQ $0x70c0, R8, R9		
  0x4bcd14		4ac7840a9070000000000000	MOVQ $0x0, 0x7090(DX)(R9*1)	
			sim.WorkerEDiag[w].abs_gnd = 0
  0x4bcd20		488b5738			MOVQ 0x38(DI), DX		
  0x4bcd24		4939d0				CMPQ R8, DX			
  0x4bcd27		0f837d020000			JAE 0x4bcfaa			
  0x4bcd2d		488b5730			MOVQ 0x30(DI), DX		
  0x4bcd31		4ac7840a9870000000000000	MOVQ $0x0, 0x7098(DX)(R9*1)	
			sim.WorkerDeadElectrons[w] = sim.WorkerDeadElectrons[w][:0]
  0x4bcd3d		488b5768		MOVQ 0x68(DI), DX		
  0x4bcd41		4939d0			CMPQ R8, DX			
  0x4bcd44		0f835b020000		JAE 0x4bcfa5			
  0x4bcd4a		4b8d1440		LEAQ 0(R8)(R8*2), DX		
  0x4bcd4e		4c8b4760		MOVQ 0x60(DI), R8		
  0x4bcd52		49c744d00800000000	MOVQ $0x0, 0x8(R8)(DX*8)	
  0x4bcd5b		0f1f440000		NOPL 0(AX)(AX*1)		
			continue
  0x4bcd60		e965ffffff		JMP 0x4bccca		
	for w := range numWorkers {
  0x4bcd65		4c89442448		MOVQ R8, 0x48(SP)	
		start := w * chunkSize
  0x4bcd6a		4889542420		MOVQ DX, 0x20(SP)	
		end := min((w+1)*chunkSize, sim.N_e)
  0x4bcd6f		4c89542440		MOVQ R10, 0x40(SP)	
		if start >= end {
  0x4bcd74		4c894c2430		MOVQ R9, 0x30(SP)	
		wg.Go(func() {
  0x4bcd79		b828000000		MOVL $0x28, AX									
  0x4bcd7e		488d1d2ba90f00		LEAQ 0xfa92b(IP), BX								
  0x4bcd85		b901000000		MOVL $0x1, CX									
  0x4bcd8a		e83106f6ff		CALL runtime.mallocgcSmallScanNoHeaderSC5(SB)					
  0x4bcd8f		488d15ea310000		LEAQ gopic.(*SimulationState).Step5CheckBoundariesElectrons.func1(SB), DX	
  0x4bcd96		488910			MOVQ DX, 0(AX)									
  0x4bcd99		833dd000130000		CMPL runtime.writeBarrier(SB), $0x0						
  0x4bcda0		7507			JNE 0x4bcda9									
  0x4bcda2		488b4c2468		MOVQ 0x68(SP), CX								
  0x4bcda7		eb0d			JMP 0x4bcdb6									
  0x4bcda9		e83249fcff		CALL runtime.gcWriteBarrier1(SB)						
  0x4bcdae		488b4c2468		MOVQ 0x68(SP), CX								
  0x4bcdb3		49890b			MOVQ CX, 0(R11)									
  0x4bcdb6		48894808		MOVQ CX, 0x8(AX)								
  0x4bcdba		488b4c2448		MOVQ 0x48(SP), CX								
  0x4bcdbf		48894810		MOVQ CX, 0x10(AX)								
  0x4bcdc3		488b4c2420		MOVQ 0x20(SP), CX								
  0x4bcdc8		48894818		MOVQ CX, 0x18(AX)								
  0x4bcdcc		488b4c2430		MOVQ 0x30(SP), CX								
  0x4bcdd1		48894820		MOVQ CX, 0x20(AX)								
  0x4bcdd5		4889c3			MOVQ AX, BX									
  0x4bcdd8		488b442450		MOVQ 0x50(SP), AX								
  0x4bcddd		0f1f00			NOPL 0(AX)									
  0x4bcde0		e8dbcbfcff		CALL sync.(*WaitGroup).Go(SB)							
		start := w * chunkSize
  0x4bcde5		488b442438		MOVQ 0x38(SP), AX	
	wg.Wait()
  0x4bcdea		488b4c2450		MOVQ 0x50(SP), CX	
	for w := range numWorkers {
  0x4bcdef		488b742428		MOVQ 0x28(SP), SI	
		end := min((w+1)*chunkSize, sim.N_e)
  0x4bcdf4		488b7c2468		MOVQ 0x68(SP), DI	
	for w := range numWorkers {
  0x4bcdf9		4c8b542440		MOVQ 0x40(SP), R10	
  0x4bcdfe		6690			NOPW			
		wg.Go(func() {
  0x4bce00		e9c5feffff		JMP 0x4bccca		
	wg.Wait()
  0x4bce05		4889c8			MOVQ CX, AX			
  0x4bce08		e893cafcff		CALL sync.(*WaitGroup).Wait(SB)	
	for w := range numWorkers {
  0x4bce0d		31c9			XORL CX, CX		
  0x4bce0f		31d2			XORL DX, DX		
  0x4bce11		488b5c2428		MOVQ 0x28(SP), BX	
  0x4bce16		488b742468		MOVQ 0x68(SP), SI	
  0x4bce1b		eb32			JMP 0x4bce4f		
		p := sim.WorkerEDiag[w].abs_pow
  0x4bce1d		488b4630		MOVQ 0x30(SI), AX		
  0x4bce21		4869fac0700000		IMULQ $0x70c0, DX, DI		
  0x4bce28		4c8b843890700000	MOVQ 0x7090(AX)(DI*1), R8	
		g := sim.WorkerEDiag[w].abs_gnd
  0x4bce30		488b843898700000	MOVQ 0x7098(AX)(DI*1), AX	
		sim.N_e_abs_pow += p
  0x4bce38		4c018650662707		ADDQ R8, 0x7276650(SI)	
		sim.N_e_abs_gnd += g
  0x4bce3f		48018658662707		ADDQ AX, 0x7276658(SI)	
		totalAbs += int(p + g)
  0x4bce46		4c01c0			ADDQ R8, AX		
  0x4bce49		4801c1			ADDQ AX, CX		
	for w := range numWorkers {
  0x4bce4c		48ffc2			INCQ DX			
  0x4bce4f		4839da			CMPQ DX, BX		
  0x4bce52		7d11			JGE 0x4bce65		
		p := sim.WorkerEDiag[w].abs_pow
  0x4bce54		488b4638		MOVQ 0x38(SI), AX	
  0x4bce58		4839c2			CMPQ DX, AX		
  0x4bce5b		72c0			JB 0x4bce1d		
  0x4bce5d		0f1f00			NOPL 0(AX)		
  0x4bce60		e939010000		JMP 0x4bcf9e		
	if totalAbs > 0 {
  0x4bce65		4885c9			TESTQ CX, CX		
  0x4bce68		7e0e			JLE 0x4bce78		
		lastValid := sim.N_e - 1
  0x4bce6a		488b86c07e5603		MOVQ 0x3567ec0(SI), AX	
  0x4bce71		48ffc8			DECQ AX			
		for w := range numWorkers {
  0x4bce74		31d2			XORL DX, DX		
  0x4bce76		eb09			JMP 0x4bce81		
}
  0x4bce78		4883c458		ADDQ $0x58, SP		
  0x4bce7c		5d			POPQ BP			
  0x4bce7d		c3			RET			
		for w := range numWorkers {
  0x4bce7e		48ffc2			INCQ DX			
  0x4bce81		4839da			CMPQ DX, BX		
  0x4bce84		0f8de2000000		JGE 0x4bcf6c		
			for _, deadIdx := range sim.WorkerDeadElectrons[w] {
  0x4bce8a		488b7e68		MOVQ 0x68(SI), DI	
  0x4bce8e		4839fa			CMPQ DX, DI		
  0x4bce91		0f8302010000		JAE 0x4bcf99		
  0x4bce97		488b7e60		MOVQ 0x60(SI), DI	
  0x4bce9b		4c8d0452		LEAQ 0(DX)(DX*2), R8	
  0x4bce9f		4e8b0cc7		MOVQ 0(DI)(R8*8), R9	
  0x4bcea3		4a8b7cc708		MOVQ 0x8(DI)(R8*8), DI	
  0x4bcea8		4531c0			XORL R8, R8		
  0x4bceab		eb03			JMP 0x4bceb0		
  0x4bcead		49ffc0			INCQ R8			
  0x4bceb0		4939f8			CMPQ R8, DI		
  0x4bceb3		7dc9			JGE 0x4bce7e		
  0x4bceb5		4f8b14c1		MOVQ 0(R9)(R8*8), R10	
				for lastValid > deadIdx && (sim.X_e[lastValid] < 0 || sim.X_e[lastValid] > L) {
  0x4bceb9		eb05			JMP 0x4bcec0		
					lastValid--
  0x4bcebb		48ffc8			DECQ AX			
  0x4bcebe		6690			NOPW			
				for lastValid > deadIdx && (sim.X_e[lastValid] < 0 || sim.X_e[lastValid] > L) {
  0x4bcec0		4c39d0			CMPQ AX, R10				
  0x4bcec3		0f8e93000000		JLE 0x4bcf5c				
  0x4bcec9		483d40420f00		CMPQ AX, $0xf4240			
  0x4bcecf		0f83ba000000		JAE 0x4bcf8f				
  0x4bced5		f20f1084c6d07e5603	MOVSD_XMM 0x3567ed0(SI)(AX*8), X0	
  0x4bcede		0f57c9			XORPS X1, X1				
  0x4bcee1		660f2ec8		UCOMISD X0, X1				
  0x4bcee5		77d4			JA 0x4bcebb				
  0x4bcee7		f20f101509090100	MOVSD_XMM 0x10909(IP), X2		
  0x4bceef		660f2ec2		UCOMISD X2, X0				
  0x4bcef3		77c6			JA 0x4bcebb				
  0x4bcef5		4c39d0			CMPQ AX, R10				
				if lastValid > deadIdx {
  0x4bcef8		7eb3			JLE 0x4bcead		
  0x4bcefa		660f1f440000		NOPW 0(AX)(AX*1)	
				for lastValid > deadIdx && (sim.X_e[lastValid] < 0 || sim.X_e[lastValid] > L) {
  0x4bcf00		483d40420f00		CMPQ AX, $0xf4240	
					sim.X_e[deadIdx] = sim.X_e[lastValid]
  0x4bcf06		737d			JAE 0x4bcf85				
  0x4bcf08		4981fa40420f00		CMPQ R10, $0xf4240			
  0x4bcf0f		7367			JAE 0x4bcf78				
  0x4bcf11		f2420f1184d6d07e5603	MOVSD_XMM X0, 0x3567ed0(SI)(R10*8)	
					sim.Vx_e[deadIdx] = sim.Vx_e[lastValid]
  0x4bcf1b		f20f1084c6d090d003	MOVSD_XMM 0x3d090d0(SI)(AX*8), X0	
  0x4bcf24		f2420f1184d6d090d003	MOVSD_XMM X0, 0x3d090d0(SI)(R10*8)	
					sim.Vy_e[deadIdx] = sim.Vy_e[lastValid]
  0x4bcf2e		f20f1084c6d0a24a04	MOVSD_XMM 0x44aa2d0(SI)(AX*8), X0	
  0x4bcf37		f2420f1184d6d0a24a04	MOVSD_XMM X0, 0x44aa2d0(SI)(R10*8)	
					sim.Vz_e[deadIdx] = sim.Vz_e[lastValid]
  0x4bcf41		f20f1084c6d0b4c404	MOVSD_XMM 0x4c4b4d0(SI)(AX*8), X0	
  0x4bcf4a		f2420f1184d6d0b4c404	MOVSD_XMM X0, 0x4c4b4d0(SI)(R10*8)	
					lastValid--
  0x4bcf54		48ffc8			DECQ AX				
  0x4bcf57		e951ffffff		JMP 0x4bcead			
  0x4bcf5c		0f57c9			XORPS X1, X1			
  0x4bcf5f		f20f101591080100	MOVSD_XMM 0x10891(IP), X2	
				for lastValid > deadIdx && (sim.X_e[lastValid] < 0 || sim.X_e[lastValid] > L) {
  0x4bcf67		e941ffffff		JMP 0x4bcead		
		sim.N_e -= totalAbs
  0x4bcf6c		48298ec07e5603		SUBQ CX, 0x3567ec0(SI)	
  0x4bcf73		e900ffffff		JMP 0x4bce78		
					sim.X_e[deadIdx] = sim.X_e[lastValid]
  0x4bcf78		b840420f00		MOVL $0xf4240, AX		
  0x4bcf7d		0f1f00			NOPL 0(AX)			
  0x4bcf80		e81b4bfcff		CALL runtime.panicBounds(SB)	
  0x4bcf85		b940420f00		MOVL $0xf4240, CX		
  0x4bcf8a		e8114bfcff		CALL runtime.panicBounds(SB)	
				for lastValid > deadIdx && (sim.X_e[lastValid] < 0 || sim.X_e[lastValid] > L) {
  0x4bcf8f		b940420f00		MOVL $0xf4240, CX		
  0x4bcf94		e8074bfcff		CALL runtime.panicBounds(SB)	
			for _, deadIdx := range sim.WorkerDeadElectrons[w] {
  0x4bcf99		e8024bfcff		CALL runtime.panicBounds(SB)	
		p := sim.WorkerEDiag[w].abs_pow
  0x4bcf9e		6690			NOPW				
  0x4bcfa0		e8fb4afcff		CALL runtime.panicBounds(SB)	
			sim.WorkerDeadElectrons[w] = sim.WorkerDeadElectrons[w][:0]
  0x4bcfa5		e8f64afcff		CALL runtime.panicBounds(SB)	
			sim.WorkerEDiag[w].abs_gnd = 0
  0x4bcfaa		e8f14afcff		CALL runtime.panicBounds(SB)	
			sim.WorkerEDiag[w].abs_pow = 0
  0x4bcfaf		e8ec4afcff		CALL runtime.panicBounds(SB)	
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bcfb4		e86778f8ff		CALL runtime.panicdivide(SB)	
  0x4bcfb9		90			NOPL				
func (sim *SimulationState) Step5CheckBoundariesElectrons() {
  0x4bcfba		4889442408		MOVQ AX, 0x8(SP)						
  0x4bcfbf		90			NOPL								
  0x4bcfc0		e89b2efcff		CALL runtime.morestack_noctxt.abi0(SB)				
  0x4bcfc5		488b442408		MOVQ 0x8(SP), AX						
  0x4bcfca		e971fcffff		JMP gopic.(*SimulationState).Step5CheckBoundariesElectrons(SB)	

TEXT gopic.(*SimulationState).Step5CheckBoundariesElectrons.func1(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
		wg.Go(func() {
  0x4bff80		493b6610		CMPQ SP, 0x10(R14)	
  0x4bff84		0f86d1010000		JBE 0x4c015b		
  0x4bff8a		55			PUSHQ BP		
  0x4bff8b		4889e5			MOVQ SP, BP		
  0x4bff8e		4883ec78		SUBQ $0x78, SP		
  0x4bff92		4c8b4210		MOVQ 0x10(DX), R8	
  0x4bff96		4c8b4a08		MOVQ 0x8(DX), R9	
			diag := &sim.WorkerEDiag[workerID]
  0x4bff9a		4d8b5138		MOVQ 0x38(R9), R10	
		wg.Go(func() {
  0x4bff9e		4c8b5a18		MOVQ 0x18(DX), R11	
  0x4bffa2		488b5220		MOVQ 0x20(DX), DX	
			diag := &sim.WorkerEDiag[workerID]
  0x4bffa6		4d39c2			CMPQ R10, R8		
  0x4bffa9		0f86a6010000		JBE 0x4c0155		
  0x4bffaf		4d8b5130		MOVQ 0x30(R9), R10	
  0x4bffb3		4d69e0c0700000		IMULQ $0x70c0, R8, R12	
			diag.abs_pow = 0
  0x4bffba		4f8d2c22		LEAQ 0(R10)(R12*1), R13	
  0x4bffbe		4d8dad90700000		LEAQ 0x7090(R13), R13	
  0x4bffc5		450f117d00		MOVUPS X15, 0(R13)	
			dead := sim.WorkerDeadElectrons[workerID][:0]
  0x4bffca		4d8b6968		MOVQ 0x68(R9), R13	
  0x4bffce		4d39c5			CMPQ R13, R8		
  0x4bffd1		0f8679010000		JBE 0x4c0150		
		wg.Go(func() {
  0x4bffd7		4c894c2468		MOVQ R9, 0x68(SP)	
  0x4bffdc		4c89442440		MOVQ R8, 0x40(SP)	
  0x4bffe1		4889542450		MOVQ DX, 0x50(SP)	
			diag := &sim.WorkerEDiag[workerID]
  0x4bffe6		4c89542470		MOVQ R10, 0x70(SP)	
  0x4bffeb		4c89642460		MOVQ R12, 0x60(SP)	
			dead := sim.WorkerDeadElectrons[workerID][:0]
  0x4bfff0		4d8b6960		MOVQ 0x60(R9), R13		
  0x4bfff4		4f8d3c40		LEAQ 0(R8)(R8*2), R15		
  0x4bfff8		4c897c2458		MOVQ R15, 0x58(SP)		
  0x4bfffd		4b8b44fd00		MOVQ 0(R13)(R15*8), AX		
  0x4c0002		4b8b4cfd10		MOVQ 0x10(R13)(R15*8), CX	
			for k := s; k < e; k++ {
  0x4c0007		4531ed			XORL R13, R13		
  0x4c000a		eb06			JMP 0x4c0012		
  0x4c000c		49ffc3			INCQ R11		
  0x4c000f		4989dd			MOVQ BX, R13		
  0x4c0012		4939d3			CMPQ R11, DX		
  0x4c0015		0f8dec000000		JGE 0x4c0107		
  0x4c001b		0f1f440000		NOPL 0(AX)(AX*1)	
				if sim.X_e[k] < 0 {
  0x4c0020		4981fb40420f00		CMPQ R11, $0xf4240	
  0x4c0027		0f8319010000		JAE 0x4c0146		
			for k := s; k < e; k++ {
  0x4c002d		4c895c2448		MOVQ R11, 0x48(SP)	
				if sim.X_e[k] < 0 {
  0x4c0032		f2430f1084d9d07e5603	MOVSD_XMM 0x3567ed0(R9)(R11*8), X0	
  0x4c003c		0f57c9			XORPS X1, X1				
  0x4c003f		660f2ec8		UCOMISD X0, X1				
  0x4c0043		7652			JBE 0x4c0097				
					dead = append(dead, k)
  0x4c0045		498d5d01		LEAQ 0x1(R13), BX		
  0x4c0049		4839d9			CMPQ CX, BX			
  0x4c004c		7337			JAE 0x4c0085			
  0x4c004e		bf01000000		MOVL $0x1, DI			
  0x4c0053		488d356edf0e00		LEAQ 0xedf6e(IP), SI		
  0x4c005a		e8c1d5fbff		CALL runtime.growslice(SB)	
			for k := s; k < e; k++ {
  0x4c005f		488b542450		MOVQ 0x50(SP), DX	
			sim.WorkerDeadElectrons[workerID] = dead
  0x4c0064		4c8b442440		MOVQ 0x40(SP), R8	
				if sim.X_e[k] < 0 {
  0x4c0069		4c8b4c2468		MOVQ 0x68(SP), R9	
					diag.abs_pow++
  0x4c006e		4c8b542470		MOVQ 0x70(SP), R10	
					dead = append(dead, k)
  0x4c0073		4c8b5c2448		MOVQ 0x48(SP), R11	
					diag.abs_pow++
  0x4c0078		4c8b642460		MOVQ 0x60(SP), R12	
			sim.WorkerDeadElectrons[workerID] = dead
  0x4c007d		4c8b7c2458		MOVQ 0x58(SP), R15	
  0x4c0082		0f57c9			XORPS X1, X1		
					dead = append(dead, k)
  0x4c0085		4c895cd8f8		MOVQ R11, -0x8(AX)(BX*8)	
					diag.abs_pow++
  0x4c008a		4bff842290700000	INCQ 0x7090(R10)(R12*1)	
  0x4c0092		e975ffffff		JMP 0x4c000c		
				} else if sim.X_e[k] > L {
  0x4c0097		f20f101559d70000	MOVSD_XMM 0xd759(IP), X2	
  0x4c009f		660f2ec2		UCOMISD X2, X0			
  0x4c00a3		765a			JBE 0x4c00ff			
					dead = append(dead, k)
  0x4c00a5		498d5d01		LEAQ 0x1(R13), BX		
  0x4c00a9		4839d9			CMPQ CX, BX			
  0x4c00ac		733f			JAE 0x4c00ed			
  0x4c00ae		bf01000000		MOVL $0x1, DI			
  0x4c00b3		488d350edf0e00		LEAQ 0xedf0e(IP), SI		
  0x4c00ba		e861d5fbff		CALL runtime.growslice(SB)	
			for k := s; k < e; k++ {
  0x4c00bf		488b542450		MOVQ 0x50(SP), DX	
			sim.WorkerDeadElectrons[workerID] = dead
  0x4c00c4		4c8b442440		MOVQ 0x40(SP), R8	
				if sim.X_e[k] < 0 {
  0x4c00c9		4c8b4c2468		MOVQ 0x68(SP), R9	
					diag.abs_gnd++
  0x4c00ce		4c8b542470		MOVQ 0x70(SP), R10	
					dead = append(dead, k)
  0x4c00d3		4c8b5c2448		MOVQ 0x48(SP), R11	
					diag.abs_gnd++
  0x4c00d8		4c8b642460		MOVQ 0x60(SP), R12	
			sim.WorkerDeadElectrons[workerID] = dead
  0x4c00dd		4c8b7c2458		MOVQ 0x58(SP), R15		
  0x4c00e2		0f57c9			XORPS X1, X1			
  0x4c00e5		f20f10150bd70000	MOVSD_XMM 0xd70b(IP), X2	
					dead = append(dead, k)
  0x4c00ed		4c895cd8f8		MOVQ R11, -0x8(AX)(BX*8)	
					diag.abs_gnd++
  0x4c00f2		4bff842298700000	INCQ 0x7098(R10)(R12*1)	
  0x4c00fa		e90dffffff		JMP 0x4c000c		
  0x4c00ff		4c89eb			MOVQ R13, BX		
				} else if sim.X_e[k] > L {
  0x4c0102		e905ffffff		JMP 0x4c000c		
			sim.WorkerDeadElectrons[workerID] = dead
  0x4c0107		498b5168		MOVQ 0x68(R9), DX			
  0x4c010b		4c39c2			CMPQ DX, R8				
  0x4c010e		7631			JBE 0x4c0141				
  0x4c0110		498b5160		MOVQ 0x60(R9), DX			
  0x4c0114		4e896cfa08		MOVQ R13, 0x8(DX)(R15*8)		
  0x4c0119		4a894cfa10		MOVQ CX, 0x10(DX)(R15*8)		
  0x4c011e		833d4bcd120000		CMPL runtime.writeBarrier(SB), $0x0	
  0x4c0125		7410			JE 0x4c0137				
  0x4c0127		4a8b0cfa		MOVQ 0(DX)(R15*8), CX			
  0x4c012b		e8d015fcff		CALL runtime.gcWriteBarrier2(SB)	
  0x4c0130		498903			MOVQ AX, 0(R11)				
  0x4c0133		49894b08		MOVQ CX, 0x8(R11)			
  0x4c0137		4a8904fa		MOVQ AX, 0(DX)(R15*8)			
		})
  0x4c013b		4883c478		ADDQ $0x78, SP		
  0x4c013f		5d			POPQ BP			
  0x4c0140		c3			RET			
			sim.WorkerDeadElectrons[workerID] = dead
  0x4c0141		e85a19fcff		CALL runtime.panicBounds(SB)	
				if sim.X_e[k] < 0 {
  0x4c0146		b840420f00		MOVL $0xf4240, AX		
  0x4c014b		e85019fcff		CALL runtime.panicBounds(SB)	
			dead := sim.WorkerDeadElectrons[workerID][:0]
  0x4c0150		e84b19fcff		CALL runtime.panicBounds(SB)	
			diag := &sim.WorkerEDiag[workerID]
  0x4c0155		e84619fcff		CALL runtime.panicBounds(SB)	
  0x4c015a		90			NOPL				
		wg.Go(func() {
  0x4c015b		0f1f440000		NOPL 0(AX)(AX*1)							
  0x4c0160		e85bfcfbff		CALL runtime.morestack.abi0(SB)						
  0x4c0165		e916feffff		JMP gopic.(*SimulationState).Step5CheckBoundariesElectrons.func1(SB)	
