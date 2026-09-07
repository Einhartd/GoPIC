TEXT gopic.(*SimulationState).Step3MoveElectrons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
func (sim *SimulationState) Step3MoveElectrons(t_index int) {
  0x4bc820		493b6610		CMPQ SP, 0x10(R14)	
  0x4bc824		0f8670030000		JBE 0x4bcb9a		
  0x4bc82a		55			PUSHQ BP		
  0x4bc82b		4889e5			MOVQ SP, BP		
  0x4bc82e		4883ec58		SUBQ $0x58, SP		
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bc832		4889442468		MOVQ AX, 0x68(SP)	
  0x4bc837		48895c2470		MOVQ BX, 0x70(SP)	
	numWorkers := sim.NumWorkers
  0x4bc83c		8400			TESTB AL, 0(AX)		
  0x4bc83e		488b90e82dba07		MOVQ 0x7ba2de8(AX), DX	
  0x4bc845		4889542428		MOVQ DX, 0x28(SP)	
	var wg sync.WaitGroup
  0x4bc84a		b810000000		MOVL $0x10, AX				
  0x4bc84f		488d1d8a8e0f00		LEAQ 0xf8e8a(IP), BX			
  0x4bc856		b901000000		MOVL $0x1, CX				
  0x4bc85b		0f1f440000		NOPL 0(AX)(AX*1)			
  0x4bc860		e8bb19f6ff		CALL runtime.mallocgcSmallNoScanSC2(SB)	
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bc865		488b542468		MOVQ 0x68(SP), DX	
  0x4bc86a		488bb2c07e5603		MOVQ 0x3567ec0(DX), SI	
  0x4bc871		488b7c2428		MOVQ 0x28(SP), DI	
  0x4bc876		488d343e		LEAQ 0(SI)(DI*1), SI	
  0x4bc87a		488d76ff		LEAQ -0x1(SI), SI	
  0x4bc87e		6690			NOPW			
  0x4bc880		4885ff			TESTQ DI, DI		
  0x4bc883		0f840b030000		JE 0x4bcb94		
	var wg sync.WaitGroup
  0x4bc889		4889442450		MOVQ AX, 0x50(SP)	
  0x4bc88e		4889c1			MOVQ AX, CX		
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bc891		4889f0			MOVQ SI, AX		
  0x4bc894		4889d3			MOVQ DX, BX		
  0x4bc897		4883ffff		CMPQ DI, $-0x1		
  0x4bc89b		7507			JNE 0x4bc8a4		
  0x4bc89d		48f7d8			NEGQ AX			
  0x4bc8a0		31d2			XORL DX, DX		
  0x4bc8a2		eb05			JMP 0x4bc8a9		
  0x4bc8a4		4899			CQO			
  0x4bc8a6		48f7ff			IDIVQ DI		
  0x4bc8a9		4889442438		MOVQ AX, 0x38(SP)	
	for w := range numWorkers {
  0x4bc8ae		31d2			XORL DX, DX		
  0x4bc8b0		eb03			JMP 0x4bc8b5		
  0x4bc8b2		4c89ca			MOVQ R9, DX		
  0x4bc8b5		4839fa			CMPQ DX, DI		
  0x4bc8b8		0f8dc7000000		JGE 0x4bc985		
		start := w * chunkSize
  0x4bc8be		4889d6			MOVQ DX, SI		
  0x4bc8c1		480fafd0		IMULQ AX, DX		
		end := min((w+1)*chunkSize, sim.N_e)
  0x4bc8c5		4c8d4601		LEAQ 0x1(SI), R8	
  0x4bc8c9		4d89c1			MOVQ R8, R9		
  0x4bc8cc		4c0fafc0		IMULQ AX, R8		
  0x4bc8d0		4c8b93c07e5603		MOVQ 0x3567ec0(BX), R10	
  0x4bc8d7		4d39c2			CMPQ R10, R8		
		if start >= end {
  0x4bc8da		4d0f4cc2		CMOVL R10, R8		
  0x4bc8de		6690			NOPW			
  0x4bc8e0		4939d0			CMPQ R8, DX		
		end := min((w+1)*chunkSize, sim.N_e)
  0x4bc8e3		7ecd			JLE 0x4bc8b2		
	for w := range numWorkers {
  0x4bc8e5		4889742448		MOVQ SI, 0x48(SP)	
		start := w * chunkSize
  0x4bc8ea		4889542420		MOVQ DX, 0x20(SP)	
		end := min((w+1)*chunkSize, sim.N_e)
  0x4bc8ef		4c894c2440		MOVQ R9, 0x40(SP)	
		if start >= end {
  0x4bc8f4		4c89442430		MOVQ R8, 0x30(SP)	
		wg.Go(func() {
  0x4bc8f9		b828000000		MOVL $0x28, AX							
  0x4bc8fe		488d1dc3b10f00		LEAQ 0xfb1c3(IP), BX						
  0x4bc905		b901000000		MOVL $0x1, CX							
  0x4bc90a		e8b10af6ff		CALL runtime.mallocgcSmallScanNoHeaderSC5(SB)			
  0x4bc90f		488d158a2d0000		LEAQ gopic.(*SimulationState).Step3MoveElectrons.func1(SB), DX	
  0x4bc916		488910			MOVQ DX, 0(AX)							
  0x4bc919		833dd004130000		CMPL runtime.writeBarrier(SB), $0x0				
  0x4bc920		7507			JNE 0x4bc929							
  0x4bc922		488b4c2468		MOVQ 0x68(SP), CX						
  0x4bc927		eb0d			JMP 0x4bc936							
  0x4bc929		e8b24dfcff		CALL runtime.gcWriteBarrier1(SB)				
  0x4bc92e		488b4c2468		MOVQ 0x68(SP), CX						
  0x4bc933		49890b			MOVQ CX, 0(R11)							
  0x4bc936		48894808		MOVQ CX, 0x8(AX)						
  0x4bc93a		488b4c2448		MOVQ 0x48(SP), CX						
  0x4bc93f		48894810		MOVQ CX, 0x10(AX)						
  0x4bc943		488b4c2420		MOVQ 0x20(SP), CX						
  0x4bc948		48894818		MOVQ CX, 0x18(AX)						
  0x4bc94c		488b4c2430		MOVQ 0x30(SP), CX						
  0x4bc951		48894820		MOVQ CX, 0x20(AX)						
  0x4bc955		4889c3			MOVQ AX, BX							
  0x4bc958		488b442450		MOVQ 0x50(SP), AX						
  0x4bc95d		0f1f00			NOPL 0(AX)							
  0x4bc960		e85bd0fcff		CALL sync.(*WaitGroup).Go(SB)					
		start := w * chunkSize
  0x4bc965		488b442438		MOVQ 0x38(SP), AX	
	wg.Wait()
  0x4bc96a		488b4c2450		MOVQ 0x50(SP), CX	
		end := min((w+1)*chunkSize, sim.N_e)
  0x4bc96f		488b5c2468		MOVQ 0x68(SP), BX	
	for w := range numWorkers {
  0x4bc974		488b7c2428		MOVQ 0x28(SP), DI	
  0x4bc979		4c8b4c2440		MOVQ 0x40(SP), R9	
  0x4bc97e		6690			NOPW			
		wg.Go(func() {
  0x4bc980		e92dffffff		JMP 0x4bc8b2		
	wg.Wait()
  0x4bc985		4889c8			MOVQ CX, AX			
  0x4bc988		e813cffcff		CALL sync.(*WaitGroup).Wait(SB)	
	if sim.Measurement_mode {
  0x4bc98d		488b4c2468		MOVQ 0x68(SP), CX		
  0x4bc992		80b9e02dba0700		CMPB 0x7ba2de0(CX), $0x0	
  0x4bc999		740e			JE 0x4bc9a9			
		for w := range numWorkers {
  0x4bc99b		31c0			XORL AX, AX		
  0x4bc99d		488b542428		MOVQ 0x28(SP), DX	
  0x4bc9a2		488b5c2470		MOVQ 0x70(SP), BX	
  0x4bc9a7		eb43			JMP 0x4bc9ec		
}
  0x4bc9a9		4883c458		ADDQ $0x58, SP		
  0x4bc9ad		5d			POPQ BP			
  0x4bc9ae		c3			RET			
			sim.Mean_energy_accu_center += sim.WorkerEDiag[w].accuCenter
  0x4bc9af		f20f1081802dba07	MOVSD_XMM 0x7ba2d80(CX), X0	
  0x4bc9b7		488b7130		MOVQ 0x30(CX), SI		
  0x4bc9bb		4869f8c0700000		IMULQ $0x70c0, AX, DI		
  0x4bc9c2		f20f58843e80700000	ADDSD 0x7080(SI)(DI*1), X0	
  0x4bc9cb		f20f1181802dba07	MOVSD_XMM X0, 0x7ba2d80(CX)	
			sim.Mean_energy_counter_center += sim.WorkerEDiag[w].counterCenter
  0x4bc9d3		4c8b81882dba07		MOVQ 0x7ba2d88(CX), R8		
  0x4bc9da		4c03843e88700000	ADDQ 0x7088(SI)(DI*1), R8	
  0x4bc9e2		4c8981882dba07		MOVQ R8, 0x7ba2d88(CX)		
		for w := range numWorkers {
  0x4bc9e9		48ffc0			INCQ AX			
  0x4bc9ec		4839d0			CMPQ AX, DX		
  0x4bc9ef		7db8			JGE 0x4bc9a9		
				sim.Counter_e_xt[p][t_index] += sim.WorkerEDiag[w].counter_e[p]
  0x4bc9f1		4869f0c0700000		IMULQ $0x70c0, AX, SI	
			for p := range N_G {
  0x4bc9f8		31ff			XORL DI, DI		
  0x4bc9fa		eb24			JMP 0x4bca20		
				sim.Ioniz_rate_xt[p][t_index] += sim.WorkerEDiag[w].ioniz[p]
  0x4bc9fc		4c8b4930		MOVQ 0x30(CX), R9		
  0x4bca00		4d8d0c31		LEAQ 0(R9)(SI*1), R9		
  0x4bca04		4d8d8980250000		LEAQ 0x2580(R9), R9		
  0x4bca0b		f2410f5804f9		ADDSD 0(R9)(DI*8), X0		
  0x4bca11		f2410f1104d8		MOVSD_XMM X0, 0(R8)(BX*8)	
			for p := range N_G {
  0x4bca17		48ffc7			INCQ DI			
  0x4bca1a		660f1f440000		NOPW 0(AX)(AX*1)	
  0x4bca20		4881ff90010000		CMPQ DI, $0x190		
  0x4bca27		0f8de1000000		JGE 0x4bcb0e		
				sim.Counter_e_xt[p][t_index] += sim.WorkerEDiag[w].counter_e[p]
  0x4bca2d		4c69c740060000		IMULQ $0x640, DI, R8		
  0x4bca34		4e8d0c01		LEAQ 0(CX)(R8*1), R9		
  0x4bca38		4d8d8980e19c07		LEAQ 0x79ce180(R9), R9		
  0x4bca3f		90			NOPL				
  0x4bca40		4881fbc8000000		CMPQ BX, $0xc8			
  0x4bca47		0f833d010000		JAE 0x4bcb8a			
  0x4bca4d		4c8b5138		MOVQ 0x38(CX), R10		
  0x4bca51		f2410f1004d9		MOVSD_XMM 0(R9)(BX*8), X0	
  0x4bca57		660f1f840000000000	NOPW 0(AX)(AX*1)		
  0x4bca60		4c39d0			CMPQ AX, R10			
  0x4bca63		0f831c010000		JAE 0x4bcb85			
  0x4bca69		4c8b5130		MOVQ 0x30(CX), R10		
  0x4bca6d		4901f2			ADDQ SI, R10			
  0x4bca70		f2410f5804fa		ADDSD 0(R10)(DI*8), X0		
  0x4bca76		f2410f1104d9		MOVSD_XMM X0, 0(R9)(BX*8)	
				sim.Ue_xt[p][t_index] += sim.WorkerEDiag[w].ue[p]
  0x4bca7c		4e8d0c01		LEAQ 0(CX)(R8*1), R9		
  0x4bca80		4d8d8980c14e07		LEAQ 0x74ec180(R9), R9		
  0x4bca87		4c8b5138		MOVQ 0x38(CX), R10		
  0x4bca8b		f2410f1004d9		MOVSD_XMM 0(R9)(BX*8), X0	
  0x4bca91		4c39d0			CMPQ AX, R10			
  0x4bca94		0f83e4000000		JAE 0x4bcb7e			
  0x4bca9a		4c8b5130		MOVQ 0x30(CX), R10		
  0x4bca9e		4d8d1432		LEAQ 0(R10)(SI*1), R10		
  0x4bcaa2		4d8d92800c0000		LEAQ 0xc80(R10), R10		
  0x4bcaa9		f2410f5804fa		ADDSD 0(R10)(DI*8), X0		
  0x4bcaaf		f2410f1104d9		MOVSD_XMM X0, 0(R9)(BX*8)	
				sim.Meanee_xt[p][t_index] += sim.WorkerEDiag[w].meanee[p]
  0x4bcab5		4e8d0c01		LEAQ 0(CX)(R8*1), R9		
  0x4bcab9		4d8d8980598907		LEAQ 0x7895980(R9), R9		
  0x4bcac0		4c8b5138		MOVQ 0x38(CX), R10		
  0x4bcac4		f2410f1004d9		MOVSD_XMM 0(R9)(BX*8), X0	
  0x4bcaca		4c39d0			CMPQ AX, R10			
  0x4bcacd		0f83a6000000		JAE 0x4bcb79			
  0x4bcad3		4c8b5130		MOVQ 0x30(CX), R10		
  0x4bcad7		4d8d1432		LEAQ 0(R10)(SI*1), R10		
  0x4bcadb		4d8d9200190000		LEAQ 0x1900(R10), R10		
  0x4bcae2		f2410f5804fa		ADDSD 0(R10)(DI*8), X0		
  0x4bcae8		f2410f1104d9		MOVSD_XMM X0, 0(R9)(BX*8)	
				sim.Ioniz_rate_xt[p][t_index] += sim.WorkerEDiag[w].ioniz[p]
  0x4bcaee		4e8d0401		LEAQ 0(CX)(R8*1), R8		
  0x4bcaf2		4d8d808069b007		LEAQ 0x7b06980(R8), R8		
  0x4bcaf9		4c8b4938		MOVQ 0x38(CX), R9		
  0x4bcafd		f2410f1004d8		MOVSD_XMM 0(R8)(BX*8), X0	
  0x4bcb03		4c39c8			CMPQ AX, R9			
  0x4bcb06		0f82f0feffff		JB 0x4bc9fc			
  0x4bcb0c		eb66			JMP 0x4bcb74			
				sim.Eepf[i] += sim.WorkerEDiag[w].eepf[i]
  0x4bcb0e		4869f0c0700000		IMULQ $0x70c0, AX, SI	
			for p := range N_G {
  0x4bcb15		31ff			XORL DI, DI		
  0x4bcb17		eb27			JMP 0x4bcb40		
				sim.Eepf[i] += sim.WorkerEDiag[w].eepf[i]
  0x4bcb19		4c8b4130		MOVQ 0x30(CX), R8			
  0x4bcb1d		4d8d0430		LEAQ 0(R8)(SI*1), R8			
  0x4bcb21		4d8d8000320000		LEAQ 0x3200(R8), R8			
  0x4bcb28		f2410f5804f8		ADDSD 0(R8)(DI*8), X0			
  0x4bcb2e		f20f1184f970662707	MOVSD_XMM X0, 0x7276670(CX)(DI*8)	
			for i := range N_EEPF {
  0x4bcb37		48ffc7			INCQ DI			
  0x4bcb3a		660f1f440000		NOPW 0(AX)(AX*1)	
  0x4bcb40		4881ffd0070000		CMPQ DI, $0x7d0		
  0x4bcb47		7d14			JGE 0x4bcb5d		
				sim.Eepf[i] += sim.WorkerEDiag[w].eepf[i]
  0x4bcb49		4c8b4138		MOVQ 0x38(CX), R8			
  0x4bcb4d		f20f1084f970662707	MOVSD_XMM 0x7276670(CX)(DI*8), X0	
  0x4bcb56		4c39c0			CMPQ AX, R8				
  0x4bcb59		72be			JB 0x4bcb19				
  0x4bcb5b		eb12			JMP 0x4bcb6f				
			sim.Mean_energy_accu_center += sim.WorkerEDiag[w].accuCenter
  0x4bcb5d		488b7138		MOVQ 0x38(CX), SI		
  0x4bcb61		4839f0			CMPQ AX, SI			
  0x4bcb64		0f8245feffff		JB 0x4bc9af			
  0x4bcb6a		e8314ffcff		CALL runtime.panicBounds(SB)	
				sim.Eepf[i] += sim.WorkerEDiag[w].eepf[i]
  0x4bcb6f		e82c4ffcff		CALL runtime.panicBounds(SB)	
				sim.Ioniz_rate_xt[p][t_index] += sim.WorkerEDiag[w].ioniz[p]
  0x4bcb74		e8274ffcff		CALL runtime.panicBounds(SB)	
				sim.Meanee_xt[p][t_index] += sim.WorkerEDiag[w].meanee[p]
  0x4bcb79		e8224ffcff		CALL runtime.panicBounds(SB)	
				sim.Ue_xt[p][t_index] += sim.WorkerEDiag[w].ue[p]
  0x4bcb7e		6690			NOPW				
  0x4bcb80		e81b4ffcff		CALL runtime.panicBounds(SB)	
				sim.Counter_e_xt[p][t_index] += sim.WorkerEDiag[w].counter_e[p]
  0x4bcb85		e8164ffcff		CALL runtime.panicBounds(SB)	
  0x4bcb8a		b8c8000000		MOVL $0xc8, AX			
  0x4bcb8f		e80c4ffcff		CALL runtime.panicBounds(SB)	
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bcb94		e8877cf8ff		CALL runtime.panicdivide(SB)	
  0x4bcb99		90			NOPL				
func (sim *SimulationState) Step3MoveElectrons(t_index int) {
  0x4bcb9a		4889442408		MOVQ AX, 0x8(SP)					
  0x4bcb9f		48895c2410		MOVQ BX, 0x10(SP)					
  0x4bcba4		e8b732fcff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x4bcba9		488b442408		MOVQ 0x8(SP), AX					
  0x4bcbae		488b5c2410		MOVQ 0x10(SP), BX					
  0x4bcbb3		e968fcffff		JMP gopic.(*SimulationState).Step3MoveElectrons(SB)	

TEXT gopic.(*SimulationState).Step3MoveElectrons.func1(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
		wg.Go(func() {
  0x4bf6a0		55			PUSHQ BP		
  0x4bf6a1		4889e5			MOVQ SP, BP		
  0x4bf6a4		488b5a08		MOVQ 0x8(DX), BX	
			if sim.Measurement_mode {
  0x4bf6a8		8403			TESTB AL, 0(BX)		
		wg.Go(func() {
  0x4bf6aa		488b7220		MOVQ 0x20(DX), SI	
  0x4bf6ae		4c8b4218		MOVQ 0x18(DX), R8	
			if sim.Measurement_mode {
  0x4bf6b2		80bbe02dba0700		CMPB 0x7ba2de0(BX), $0x0	
  0x4bf6b9		742f			JE 0x4bf6ea			
		wg.Go(func() {
  0x4bf6bb		488b5210		MOVQ 0x10(DX), DX	
				diag := &sim.WorkerEDiag[workerID]
  0x4bf6bf		4c8b4b38		MOVQ 0x38(BX), R9	
  0x4bf6c3		4939d1			CMPQ R9, DX		
  0x4bf6c6		0f86ee060000		JBE 0x4bfdba		
  0x4bf6cc		4c8b4b30		MOVQ 0x30(BX), R9	
  0x4bf6d0		4869d2c0700000		IMULQ $0x70c0, DX, DX	
  0x4bf6d7		498d3c11		LEAQ 0(R9)(DX*1), DI	
				*diag = electronWorkerDiagnostics{}
  0x4bf6db		b9180e0000		MOVL $0xe18, CX		
  0x4bf6e0		31c0			XORL AX, AX		
  0x4bf6e2		f348ab			REP; STOSQ AX, ES:0(DI)	
				for k := s; k < e; k++ {
  0x4bf6e5		e9f6030000		JMP 0x4bfae0		
				if e > s {
  0x4bf6ea		4c39c6			CMPQ SI, R8		
  0x4bf6ed		7e10			JLE 0x4bf6ff		
					_ = sim.X_e[e-1]
  0x4bf6ef		488d46ff		LEAQ -0x1(SI), AX	
  0x4bf6f3		483d40420f00		CMPQ AX, $0xf4240	
  0x4bf6f9		0f8398030000		JAE 0x4bfa97		
				for ; k <= e-4; k += 4 {
  0x4bf6ff		488d46fc		LEAQ -0x4(SI), AX	
  0x4bf703		e918010000		JMP 0x4bf820		
					d3 := c0_3 - float64(p3)
  0x4bf708		0f57ed			XORPS X5, X5		
  0x4bf70b		f2480f2ae9		CVTSI2SDQ CX, X5	
  0x4bf710		f20f5cc5		SUBSD X5, X0		
					ex3 := sim.Efield[p3] + d3*(sim.Efield[p3+1]-sim.Efield[p3])
  0x4bf714		f20f10accbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X5	
  0x4bf71d		f20f10b4cbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X6	
  0x4bf726		f20f5cf5		SUBSD X5, X6				
  0x4bf72a		c4e2f9b9ee		VFMADD231SD X6, X0, X5			
					vx0 := sim.Vx_e[k] - ex0*FACTOR_E
  0x4bf72f		f2420f1084c3d090d003	MOVSD_XMM 0x3d090d0(BX)(R8*8), X0	
  0x4bf739		f20f1035b7e20000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x4bf741		f20f59d6		MULSD X6, X2				
  0x4bf745		f20f5cc2		SUBSD X2, X0				
					vx1 := sim.Vx_e[k+1] - ex1*FACTOR_E
  0x4bf749		f2420f1094c3d890d003	MOVSD_XMM 0x3d090d8(BX)(R8*8), X2	
  0x4bf753		f20f59de		MULSD X6, X3				
  0x4bf757		f20f5cd3		SUBSD X3, X2				
					vx2 := sim.Vx_e[k+2] - ex2*FACTOR_E
  0x4bf75b		f2420f109cc3e090d003	MOVSD_XMM 0x3d090e0(BX)(R8*8), X3	
  0x4bf765		f20f59e6		MULSD X6, X4				
  0x4bf769		f20f5cdc		SUBSD X4, X3				
					vx3 := sim.Vx_e[k+3] - ex3*FACTOR_E
  0x4bf76d		f2420f10a4c3e890d003	MOVSD_XMM 0x3d090e8(BX)(R8*8), X4	
					sim.Vx_e[k] = vx0
  0x4bf777		f2420f1184c3d090d003	MOVSD_XMM X0, 0x3d090d0(BX)(R8*8)	
					sim.Vx_e[k+1] = vx1
  0x4bf781		f2420f1194c3d890d003	MOVSD_XMM X2, 0x3d090d8(BX)(R8*8)	
					sim.Vx_e[k+2] = vx2
  0x4bf78b		f2420f119cc3e090d003	MOVSD_XMM X3, 0x3d090e0(BX)(R8*8)	
					vx3 := sim.Vx_e[k+3] - ex3*FACTOR_E
  0x4bf795		f20f59ee		MULSD X6, X5		
  0x4bf799		f20f5ce5		SUBSD X5, X4		
					sim.Vx_e[k+3] = vx3
  0x4bf79d		f2420f11a4c3e890d003	MOVSD_XMM X4, 0x3d090e8(BX)(R8*8)	
					sim.X_e[k] += vx0 * DT_E
  0x4bf7a7		f2420f10acc3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R8*8), X5	
  0x4bf7b1		f20f103d2fe10000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X7	
  0x4bf7b9		c4e2f9b9ef		VFMADD231SD X7, X0, X5			
  0x4bf7be		f2420f11acc3d07e5603	MOVSD_XMM X5, 0x3567ed0(BX)(R8*8)	
					sim.X_e[k+1] += vx1 * DT_E
  0x4bf7c8		f2420f1084c3d87e5603	MOVSD_XMM 0x3567ed8(BX)(R8*8), X0	
  0x4bf7d2		c4e2e9b9c7		VFMADD231SD X7, X2, X0			
  0x4bf7d7		f2420f1184c3d87e5603	MOVSD_XMM X0, 0x3567ed8(BX)(R8*8)	
					sim.X_e[k+2] += vx2 * DT_E
  0x4bf7e1		f2420f1084c3e07e5603	MOVSD_XMM 0x3567ee0(BX)(R8*8), X0	
  0x4bf7eb		c4e2e1b9c7		VFMADD231SD X7, X3, X0			
  0x4bf7f0		f2420f1184c3e07e5603	MOVSD_XMM X0, 0x3567ee0(BX)(R8*8)	
					sim.X_e[k+3] += vx3 * DT_E
  0x4bf7fa		f2420f1084c3e87e5603	MOVSD_XMM 0x3567ee8(BX)(R8*8), X0	
  0x4bf804		c4e2d9b9c7		VFMADD231SD X7, X4, X0			
  0x4bf809		f2420f1184c3e87e5603	MOVSD_XMM X0, 0x3567ee8(BX)(R8*8)	
				for ; k <= e-4; k += 4 {
  0x4bf813		4983c004		ADDQ $0x4, R8		
  0x4bf817		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x4bf820		4939c0			CMPQ R8, AX		
  0x4bf823		0f8fe4010000		JG 0x4bfa0d		
					c0_0 := sim.X_e[k] * INV_DX
  0x4bf829		4981f840420f00		CMPQ R8, $0xf4240			
  0x4bf830		0f8357020000		JAE 0x4bfa8d				
  0x4bf836		f2420f1084c3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R8*8), X0	
  0x4bf840		f20f100d58e20000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4bf848		f20f59c1		MULSD X1, X0				
					p0 := min(max(int(c0_0), 0), N_G-2)
  0x4bf84c		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x4bf851		4885c9			TESTQ CX, CX		
  0x4bf854		7d0a			JGE 0x4bf860		
  0x4bf856		31c9			XORL CX, CX		
  0x4bf858		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x4bf860		4881f98e010000		CMPQ CX, $0x18e		
  0x4bf867		7e05			JLE 0x4bf86e		
  0x4bf869		b98e010000		MOVL $0x18e, CX		
					d0 := c0_0 - float64(p0)
  0x4bf86e		0f57d2			XORPS X2, X2		
  0x4bf871		f2480f2ad1		CVTSI2SDQ CX, X2	
  0x4bf876		f20f5cc2		SUBSD X2, X0		
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x4bf87a		f20f1094cbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X2	
  0x4bf883		f20f109ccbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X3	
  0x4bf88c		f20f5cda		SUBSD X2, X3				
					c0_1 := sim.X_e[k+1] * INV_DX
  0x4bf890		498d4801		LEAQ 0x1(R8), CX	
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x4bf894		c4e2f9b9d3		VFMADD231SD X3, X0, X2	
  0x4bf899		0f1f8000000000		NOPL 0(AX)		
					c0_1 := sim.X_e[k+1] * INV_DX
  0x4bf8a0		4881f940420f00		CMPQ CX, $0xf4240			
  0x4bf8a7		0f83d1010000		JAE 0x4bfa7e				
  0x4bf8ad		f2420f1084c3d87e5603	MOVSD_XMM 0x3567ed8(BX)(R8*8), X0	
  0x4bf8b7		f20f59c1		MULSD X1, X0				
					p1 := min(max(int(c0_1), 0), N_G-2)
  0x4bf8bb		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x4bf8c0		4885c9			TESTQ CX, CX		
  0x4bf8c3		7d02			JGE 0x4bf8c7		
  0x4bf8c5		31c9			XORL CX, CX		
  0x4bf8c7		4881f98e010000		CMPQ CX, $0x18e		
  0x4bf8ce		7e05			JLE 0x4bf8d5		
  0x4bf8d0		b98e010000		MOVL $0x18e, CX		
					d1 := c0_1 - float64(p1)
  0x4bf8d5		0f57db			XORPS X3, X3		
  0x4bf8d8		f2480f2ad9		CVTSI2SDQ CX, X3	
  0x4bf8dd		f20f5cc3		SUBSD X3, X0		
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x4bf8e1		f20f109ccbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X3	
  0x4bf8ea		f20f10a4cbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X4	
  0x4bf8f3		f20f5ce3		SUBSD X3, X4				
					c0_2 := sim.X_e[k+2] * INV_DX
  0x4bf8f7		498d4802		LEAQ 0x2(R8), CX	
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x4bf8fb		c4e2f9b9dc		VFMADD231SD X4, X0, X3	
					c0_2 := sim.X_e[k+2] * INV_DX
  0x4bf900		4881f940420f00		CMPQ CX, $0xf4240			
  0x4bf907		0f8362010000		JAE 0x4bfa6f				
  0x4bf90d		f2420f1084c3e07e5603	MOVSD_XMM 0x3567ee0(BX)(R8*8), X0	
  0x4bf917		f20f59c1		MULSD X1, X0				
					p2 := min(max(int(c0_2), 0), N_G-2)
  0x4bf91b		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x4bf920		4885c9			TESTQ CX, CX		
  0x4bf923		7d02			JGE 0x4bf927		
  0x4bf925		31c9			XORL CX, CX		
  0x4bf927		4881f98e010000		CMPQ CX, $0x18e		
  0x4bf92e		7e05			JLE 0x4bf935		
  0x4bf930		b98e010000		MOVL $0x18e, CX		
					d2 := c0_2 - float64(p2)
  0x4bf935		0f57e4			XORPS X4, X4		
  0x4bf938		f2480f2ae1		CVTSI2SDQ CX, X4	
  0x4bf93d		f20f5cc4		SUBSD X4, X0		
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x4bf941		f20f10a4cbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X4	
  0x4bf94a		f20f10accbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X5	
  0x4bf953		f20f5cec		SUBSD X4, X5				
					c0_3 := sim.X_e[k+3] * INV_DX
  0x4bf957		498d4803		LEAQ 0x3(R8), CX	
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x4bf95b		c4e2f9b9e5		VFMADD231SD X5, X0, X4	
					c0_3 := sim.X_e[k+3] * INV_DX
  0x4bf960		4881f940420f00		CMPQ CX, $0xf4240			
  0x4bf967		0f83f8000000		JAE 0x4bfa65				
  0x4bf96d		f2420f1084c3e87e5603	MOVSD_XMM 0x3567ee8(BX)(R8*8), X0	
  0x4bf977		f20f59c1		MULSD X1, X0				
					p3 := min(max(int(c0_3), 0), N_G-2)
  0x4bf97b		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x4bf980		4885c9			TESTQ CX, CX		
  0x4bf983		7d02			JGE 0x4bf987		
  0x4bf985		31c9			XORL CX, CX		
  0x4bf987		4881f98e010000		CMPQ CX, $0x18e		
  0x4bf98e		0f8e74fdffff		JLE 0x4bf708		
  0x4bf994		b98e010000		MOVL $0x18e, CX		
  0x4bf999		e96afdffff		JMP 0x4bf708		
					d := c0 - float64(p)
  0x4bf99e		0f57d2			XORPS X2, X2		
  0x4bf9a1		f2480f2ad0		CVTSI2SDQ AX, X2	
  0x4bf9a6		f20f5cc2		SUBSD X2, X0		
					ex := sim.Efield[p] + d*(sim.Efield[p+1]-sim.Efield[p])
  0x4bf9aa		f20f1094c3d00e2707	MOVSD_XMM 0x7270ed0(BX)(AX*8), X2	
  0x4bf9b3		f20f109cc3d80e2707	MOVSD_XMM 0x7270ed8(BX)(AX*8), X3	
  0x4bf9bc		f20f5cda		SUBSD X2, X3				
  0x4bf9c0		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
					sim.Vx_e[k] -= ex * FACTOR_E
  0x4bf9c5		f2420f1084c3d090d003	MOVSD_XMM 0x3d090d0(BX)(R8*8), X0	
  0x4bf9cf		f20f101d21e00000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X3	
  0x4bf9d7		f20f59d3		MULSD X3, X2				
  0x4bf9db		f20f5cc2		SUBSD X2, X0				
  0x4bf9df		f2420f1184c3d090d003	MOVSD_XMM X0, 0x3d090d0(BX)(R8*8)	
					sim.X_e[k] += sim.Vx_e[k] * DT_E
  0x4bf9e9		f2420f1094c3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R8*8), X2	
  0x4bf9f3		f20f1025edde0000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X4	
  0x4bf9fb		c4e2f9b9d4		VFMADD231SD X4, X0, X2			
  0x4bfa00		f2420f1194c3d07e5603	MOVSD_XMM X2, 0x3567ed0(BX)(R8*8)	
				for ; k < e; k++ {
  0x4bfa0a		49ffc0			INCQ R8			
  0x4bfa0d		4939f0			CMPQ R8, SI		
  0x4bfa10		7d44			JGE 0x4bfa56		
					c0 := sim.X_e[k] * INV_DX
  0x4bfa12		4981f840420f00		CMPQ R8, $0xf4240			
  0x4bfa19		733d			JAE 0x4bfa58				
  0x4bfa1b		f2420f1084c3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R8*8), X0	
  0x4bfa25		f20f100d73e00000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4bfa2d		f20f59c1		MULSD X1, X0				
					p := min(max(int(c0), 0), N_G-2)
  0x4bfa31		f2480f2cc0		CVTTSD2SIQ X0, AX	
  0x4bfa36		4885c0			TESTQ AX, AX		
  0x4bfa39		7d05			JGE 0x4bfa40		
  0x4bfa3b		31c0			XORL AX, AX		
  0x4bfa3d		0f1f00			NOPL 0(AX)		
  0x4bfa40		483d8e010000		CMPQ AX, $0x18e		
  0x4bfa46		0f8e52ffffff		JLE 0x4bf99e		
  0x4bfa4c		b88e010000		MOVL $0x18e, AX		
  0x4bfa51		e948ffffff		JMP 0x4bf99e		
		})
  0x4bfa56		5d			POPQ BP			
  0x4bfa57		c3			RET			
					c0 := sim.X_e[k] * INV_DX
  0x4bfa58		b840420f00		MOVL $0xf4240, AX		
  0x4bfa5d		0f1f00			NOPL 0(AX)			
  0x4bfa60		e83b20fcff		CALL runtime.panicBounds(SB)	
					c0_3 := sim.X_e[k+3] * INV_DX
  0x4bfa65		b840420f00		MOVL $0xf4240, AX		
  0x4bfa6a		e83120fcff		CALL runtime.panicBounds(SB)	
					c0_2 := sim.X_e[k+2] * INV_DX
  0x4bfa6f		b840420f00		MOVL $0xf4240, AX		
  0x4bfa74		b940420f00		MOVL $0xf4240, CX		
  0x4bfa79		e82220fcff		CALL runtime.panicBounds(SB)	
					c0_1 := sim.X_e[k+1] * INV_DX
  0x4bfa7e		b840420f00		MOVL $0xf4240, AX		
  0x4bfa83		b940420f00		MOVL $0xf4240, CX		
  0x4bfa88		e81320fcff		CALL runtime.panicBounds(SB)	
					c0_0 := sim.X_e[k] * INV_DX
  0x4bfa8d		b840420f00		MOVL $0xf4240, AX		
  0x4bfa92		e80920fcff		CALL runtime.panicBounds(SB)	
					_ = sim.X_e[e-1]
  0x4bfa97		b940420f00		MOVL $0xf4240, CX		
  0x4bfa9c		0f1f4000		NOPL 0(AX)			
  0x4bfaa0		e8fb1ffcff		CALL runtime.panicBounds(SB)	
					sim.Vx_e[k] -= e_x * FACTOR_E
  0x4bfaa5		f2420f10a4c3d090d003	MOVSD_XMM 0x3d090d0(BX)(R8*8), X4	
  0x4bfaaf		f20f59d6		MULSD X6, X2				
  0x4bfab3		f20f5ce2		SUBSD X2, X4				
  0x4bfab7		f2420f11a4c3d090d003	MOVSD_XMM X4, 0x3d090d0(BX)(R8*8)	
					sim.X_e[k] += sim.Vx_e[k] * DT_E
  0x4bfac1		f2420f1094c3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R8*8), X2	
  0x4bfacb		c4c2d9b9d0		VFMADD231SD X8, X4, X2			
  0x4bfad0		f2420f1194c3d07e5603	MOVSD_XMM X2, 0x3567ed0(BX)(R8*8)	
				for k := s; k < e; k++ {
  0x4bfada		49ffc0			INCQ R8			
  0x4bfadd		0f1f00			NOPL 0(AX)		
  0x4bfae0		4939f0			CMPQ R8, SI		
  0x4bfae3		0f8d6dffffff		JGE 0x4bfa56		
					c0 = sim.X_e[k] * INV_DX
  0x4bfae9		4981f840420f00		CMPQ R8, $0xf4240			
  0x4bfaf0		0f83ba020000		JAE 0x4bfdb0				
  0x4bfaf6		f2420f1084c3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R8*8), X0	
  0x4bfb00		f20f100d98df0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4bfb08		f20f59c1		MULSD X1, X0				
					p = min(max(int(c0), 0), N_G-2)
  0x4bfb0c		f2480f2cc0		CVTTSD2SIQ X0, AX	
  0x4bfb11		4885c0			TESTQ AX, AX		
  0x4bfb14		7d0a			JGE 0x4bfb20		
  0x4bfb16		31c0			XORL AX, AX		
  0x4bfb18		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x4bfb20		483d8e010000		CMPQ AX, $0x18e		
  0x4bfb26		7e05			JLE 0x4bfb2d		
  0x4bfb28		b88e010000		MOVL $0x18e, AX		
					c1 = float64(p) + 1.0 - c0
  0x4bfb2d		0f57d2			XORPS X2, X2				
  0x4bfb30		f2480f2ad0		CVTSI2SDQ AX, X2			
  0x4bfb35		f20f101d73de0000	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x4bfb3d		f20f58da		ADDSD X2, X3				
  0x4bfb41		f20f5cd8		SUBSD X0, X3				
					c2 = c0 - float64(p)
  0x4bfb45		f20f5cc2		SUBSD X2, X0		
					e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]
  0x4bfb49		f20f1094c3d00e2707	MOVSD_XMM 0x7270ed0(BX)(AX*8), X2	
  0x4bfb52		f20f59d3		MULSD X3, X2				
  0x4bfb56		f20f10a4c3d80e2707	MOVSD_XMM 0x7270ed8(BX)(AX*8), X4	
  0x4bfb5f		c4e2d9b9d0		VFMADD231SD X0, X4, X2			
					mean_v = sim.Vx_e[k] - 0.5*e_x*FACTOR_E
  0x4bfb64		f2420f10a4c3d090d003	MOVSD_XMM 0x3d090d0(BX)(R8*8), X4	
  0x4bfb6e		f20f102d22de0000	MOVSD_XMM $f64.3fe0000000000000(SB), X5	
  0x4bfb76		f20f59ea		MULSD X2, X5				
  0x4bfb7a		f20f103576de0000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x4bfb82		f20f59ee		MULSD X6, X5				
  0x4bfb86		f20f5ce5		SUBSD X5, X4				
					diag.counter_e[p] += c1
  0x4bfb8a		498d0c11		LEAQ 0(R9)(DX*1), CX		
  0x4bfb8e		f20f102cc1		MOVSD_XMM 0(CX)(AX*8), X5	
  0x4bfb93		f20f58eb		ADDSD X3, X5			
  0x4bfb97		f20f112cc1		MOVSD_XMM X5, 0(CX)(AX*8)	
					diag.counter_e[p+1] += c2
  0x4bfb9c		f20f106cc108		MOVSD_XMM 0x8(CX)(AX*8), X5	
  0x4bfba2		f20f58e8		ADDSD X0, X5			
  0x4bfba6		f20f116cc108		MOVSD_XMM X5, 0x8(CX)(AX*8)	
					diag.ue[p] += c1 * mean_v
  0x4bfbac		498d0c11		LEAQ 0(R9)(DX*1), CX		
  0x4bfbb0		488d89800c0000		LEAQ 0xc80(CX), CX		
  0x4bfbb7		f20f102cc1		MOVSD_XMM 0(CX)(AX*8), X5	
  0x4bfbbc		c4e2e1b9ec		VFMADD231SD X4, X3, X5		
  0x4bfbc1		f20f112cc1		MOVSD_XMM X5, 0(CX)(AX*8)	
					diag.ue[p+1] += c2 * mean_v
  0x4bfbc6		f20f106cc108		MOVSD_XMM 0x8(CX)(AX*8), X5	
  0x4bfbcc		c4e2f9b9ec		VFMADD231SD X4, X0, X5		
  0x4bfbd1		f20f116cc108		MOVSD_XMM X5, 0x8(CX)(AX*8)	
					v_sqr = mean_v*mean_v + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
  0x4bfbd7		f2420f10acc3d0a24a04	MOVSD_XMM 0x44aa2d0(BX)(R8*8), X5	
  0x4bfbe1		f20f59ed		MULSD X5, X5				
  0x4bfbe5		c4e2d9b9ec		VFMADD231SD X4, X4, X5			
  0x4bfbea		f2420f10a4c3d0b4c404	MOVSD_XMM 0x4c4b4d0(BX)(R8*8), X4	
  0x4bfbf4		c4e2d9b9ec		VFMADD231SD X4, X4, X5			
					energy = 0.5 * E_MASS * v_sqr * INV_EV_TO_J
  0x4bfbf9		f20f102587dc0000	MOVSD_XMM $f64.39a279dcc3e61461(SB), X4	
  0x4bfc01		f20f59e5		MULSD X5, X4				
  0x4bfc05		f20f103dc3de0000	MOVSD_XMM $f64.43d5a792def818e8(SB), X7	
  0x4bfc0d		f20f59fc		MULSD X4, X7				
					diag.meanee[p] += c1 * energy
  0x4bfc11		498d0c11		LEAQ 0(R9)(DX*1), CX		
  0x4bfc15		488d8900190000		LEAQ 0x1900(CX), CX		
  0x4bfc1c		f2440f1004c1		MOVSD_XMM 0(CX)(AX*8), X8	
  0x4bfc22		c462c1b9c3		VFMADD231SD X3, X7, X8		
  0x4bfc27		f2440f1104c1		MOVSD_XMM X8, 0(CX)(AX*8)	
					diag.meanee[p+1] += c2 * energy
  0x4bfc2d		f2440f1044c108		MOVSD_XMM 0x8(CX)(AX*8), X8	
  0x4bfc34		c462c1b9c0		VFMADD231SD X0, X7, X8		
  0x4bfc39		f2440f1144c108		MOVSD_XMM X8, 0x8(CX)(AX*8)	
					energy_index = minInt(int(v_sqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
  0x4bfc40		f2440f10054fdd0000	MOVSD_XMM $f64.3fe0000000000000(SB), X8	
  0x4bfc49		f2440f100daedc0000	MOVSD_XMM $f64.3e286b6a97118d9b(SB), X9	
  0x4bfc52		c462b1b9c5		VFMADD231SD X5, X9, X8			
  0x4bfc57		f2490f2cc8		CVTTSD2SIQ X8, CX			
  0x4bfc5c		0f1f4000		NOPL 0(AX)				
	if a < b {
  0x4bfc60		4881f93f420f00		CMPQ CX, $0xf423f	
  0x4bfc67		7c05			JL 0x4bfc6e		
  0x4bfc69		b93f420f00		MOVL $0xf423f, CX	
					velocity = math.Sqrt(v_sqr)
  0x4bfc6e		90			NOPL			
					rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x4bfc6f		4881f940420f00		CMPQ CX, $0xf4240	
  0x4bfc76		0f832a010000		JAE 0x4bfda6		
					diag.ioniz[p] += c1 * rate
  0x4bfc7c		498d3c11		LEAQ 0(R9)(DX*1), DI	
  0x4bfc80		488dbf80250000		LEAQ 0x2580(DI), DI	
	return sqrt(x)
  0x4bfc87		f20f51ed		SQRTSD X5, X5		
					rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x4bfc8b		f20f59accbc024f400	MULSD 0xf424c0(BX)(CX*8), X5			
  0x4bfc94		f2440f10054bdc0000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X8		
  0x4bfc9d		f2410f59e8		MULSD X8, X5					
  0x4bfca2		f2440f10152dde0000	MOVSD_XMM $f64.445c0bbef48bc79c(SB), X10	
  0x4bfcab		f2410f59ea		MULSD X10, X5					
					diag.ioniz[p] += c1 * rate
  0x4bfcb0		f20f59dd		MULSD X5, X3			
  0x4bfcb4		f20f581cc7		ADDSD 0(DI)(AX*8), X3		
  0x4bfcb9		f20f111cc7		MOVSD_XMM X3, 0(DI)(AX*8)	
					diag.ioniz[p+1] += c2 * rate
  0x4bfcbe		f20f105cc708		MOVSD_XMM 0x8(DI)(AX*8), X3	
  0x4bfcc4		c4e2d1b9d8		VFMADD231SD X0, X5, X3		
  0x4bfcc9		f20f115cc708		MOVSD_XMM X3, 0x8(DI)(AX*8)	
					if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
  0x4bfccf		f2420f1084c3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R8*8), X0	
  0x4bfcd9		f20f101d6fdc0000	MOVSD_XMM $f64.3f870a3d70a3d70b(SB), X3	
  0x4bfce1		660f2ec3		UCOMISD X3, X0				
  0x4bfce5		0f868a000000		JBE 0x4bfd75				
  0x4bfceb		f20f102d65dc0000	MOVSD_XMM $f64.3f8c28f5c28f5c2a(SB), X5	
  0x4bfcf3		660f2ee8		UCOMISD X0, X5				
  0x4bfcf7		0f8680000000		JBE 0x4bfd7d				
						energy_index = int(energy * INV_DE_EEPF)
  0x4bfcfd		f20f100553dd0000	MOVSD_XMM $f64.4034000000000000(SB), X0	
  0x4bfd05		f20f59f8		MULSD X0, X7				
  0x4bfd09		f2480f2cc7		CVTTSD2SIQ X7, AX			
						if energy_index < N_EEPF {
  0x4bfd0e		483dd0070000		CMPQ AX, $0x7d0		
  0x4bfd14		7d27			JGE 0x4bfd3d		
							diag.eepf[energy_index] += 1.0
  0x4bfd16		498d0c11		LEAQ 0(R9)(DX*1), CX				
  0x4bfd1a		488d8900320000		LEAQ 0x3200(CX), CX				
  0x4bfd21		7379			JAE 0x4bfd9c					
  0x4bfd23		f20f103cc1		MOVSD_XMM 0(CX)(AX*8), X7			
  0x4bfd28		f2440f101d7fdc0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
  0x4bfd31		f2410f58fb		ADDSD X11, X7					
  0x4bfd36		f20f113cc1		MOVSD_XMM X7, 0(CX)(AX*8)			
  0x4bfd3b		eb09			JMP 0x4bfd46					
  0x4bfd3d		f2440f101d6adc0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
						diag.accuCenter += energy
  0x4bfd46		f2410f10bc1180700000	MOVSD_XMM 0x7080(R9)(DX*1), X7			
  0x4bfd50		f2440f102577dd0000	MOVSD_XMM $f64.43d5a792def818e8(SB), X12	
  0x4bfd59		c4e299b9fc		VFMADD231SD X4, X12, X7				
  0x4bfd5e		f2410f11bc1180700000	MOVSD_XMM X7, 0x7080(R9)(DX*1)			
						diag.counterCenter++
  0x4bfd68		49ff841188700000	INCQ 0x7088(R9)(DX*1)			
  0x4bfd70		e930fdffff		JMP 0x4bfaa5				
  0x4bfd75		f20f102ddbdb0000	MOVSD_XMM $f64.3f8c28f5c28f5c2a(SB), X5	
					if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
  0x4bfd7d		f20f1005d3dc0000	MOVSD_XMM $f64.4034000000000000(SB), X0		
  0x4bfd85		f2440f101d22dc0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
  0x4bfd8e		f2440f102539dd0000	MOVSD_XMM $f64.43d5a792def818e8(SB), X12	
  0x4bfd97		e909fdffff		JMP 0x4bfaa5					
							diag.eepf[energy_index] += 1.0
  0x4bfd9c		b9d0070000		MOVL $0x7d0, CX			
  0x4bfda1		e8fa1cfcff		CALL runtime.panicBounds(SB)	
					rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x4bfda6		b840420f00		MOVL $0xf4240, AX		
  0x4bfdab		e8f01cfcff		CALL runtime.panicBounds(SB)	
					c0 = sim.X_e[k] * INV_DX
  0x4bfdb0		b840420f00		MOVL $0xf4240, AX		
  0x4bfdb5		e8e61cfcff		CALL runtime.panicBounds(SB)	
				diag := &sim.WorkerEDiag[workerID]
  0x4bfdba		e8e11cfcff		CALL runtime.panicBounds(SB)	
  0x4bfdbf		90			NOPL				
