TEXT gopic.(*SimulationState).Step3MoveElectrons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
func (sim *SimulationState) Step3MoveElectrons(t_index int) {
  0x4bd600		493b6610		CMPQ SP, 0x10(R14)	
  0x4bd604		0f8670030000		JBE 0x4bd97a		
  0x4bd60a		55			PUSHQ BP		
  0x4bd60b		4889e5			MOVQ SP, BP		
  0x4bd60e		4883ec58		SUBQ $0x58, SP		
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bd612		4889442468		MOVQ AX, 0x68(SP)	
  0x4bd617		48895c2470		MOVQ BX, 0x70(SP)	
	numWorkers := sim.NumWorkers
  0x4bd61c		8400			TESTB AL, 0(AX)		
  0x4bd61e		488b90e82dba07		MOVQ 0x7ba2de8(AX), DX	
  0x4bd625		4889542428		MOVQ DX, 0x28(SP)	
	var wg sync.WaitGroup
  0x4bd62a		b810000000		MOVL $0x10, AX				
  0x4bd62f		488d1de28b0f00		LEAQ 0xf8be2(IP), BX			
  0x4bd636		b901000000		MOVL $0x1, CX				
  0x4bd63b		0f1f440000		NOPL 0(AX)(AX*1)			
  0x4bd640		e8bb11f6ff		CALL runtime.mallocgcSmallNoScanSC2(SB)	
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bd645		488b542468		MOVQ 0x68(SP), DX	
  0x4bd64a		488bb2c07e5603		MOVQ 0x3567ec0(DX), SI	
  0x4bd651		488b7c2428		MOVQ 0x28(SP), DI	
  0x4bd656		488d343e		LEAQ 0(SI)(DI*1), SI	
  0x4bd65a		488d76ff		LEAQ -0x1(SI), SI	
  0x4bd65e		6690			NOPW			
  0x4bd660		4885ff			TESTQ DI, DI		
  0x4bd663		0f840b030000		JE 0x4bd974		
	var wg sync.WaitGroup
  0x4bd669		4889442450		MOVQ AX, 0x50(SP)	
  0x4bd66e		4889c1			MOVQ AX, CX		
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bd671		4889f0			MOVQ SI, AX		
  0x4bd674		4889d3			MOVQ DX, BX		
  0x4bd677		4883ffff		CMPQ DI, $-0x1		
  0x4bd67b		7507			JNE 0x4bd684		
  0x4bd67d		48f7d8			NEGQ AX			
  0x4bd680		31d2			XORL DX, DX		
  0x4bd682		eb05			JMP 0x4bd689		
  0x4bd684		4899			CQO			
  0x4bd686		48f7ff			IDIVQ DI		
  0x4bd689		4889442438		MOVQ AX, 0x38(SP)	
	for w := range numWorkers {
  0x4bd68e		31d2			XORL DX, DX		
  0x4bd690		eb03			JMP 0x4bd695		
  0x4bd692		4c89ca			MOVQ R9, DX		
  0x4bd695		4839fa			CMPQ DX, DI		
  0x4bd698		0f8dc7000000		JGE 0x4bd765		
		start := w * chunkSize
  0x4bd69e		4889d6			MOVQ DX, SI		
  0x4bd6a1		480fafd0		IMULQ AX, DX		
		end := min((w+1)*chunkSize, sim.N_e)
  0x4bd6a5		4c8d4601		LEAQ 0x1(SI), R8	
  0x4bd6a9		4d89c1			MOVQ R8, R9		
  0x4bd6ac		4c0fafc0		IMULQ AX, R8		
  0x4bd6b0		4c8b93c07e5603		MOVQ 0x3567ec0(BX), R10	
  0x4bd6b7		4d39c2			CMPQ R10, R8		
		if start >= end {
  0x4bd6ba		4d0f4cc2		CMOVL R10, R8		
  0x4bd6be		6690			NOPW			
  0x4bd6c0		4939d0			CMPQ R8, DX		
		end := min((w+1)*chunkSize, sim.N_e)
  0x4bd6c3		7ecd			JLE 0x4bd692		
	for w := range numWorkers {
  0x4bd6c5		4889742448		MOVQ SI, 0x48(SP)	
		start := w * chunkSize
  0x4bd6ca		4889542420		MOVQ DX, 0x20(SP)	
		end := min((w+1)*chunkSize, sim.N_e)
  0x4bd6cf		4c894c2440		MOVQ R9, 0x40(SP)	
		if start >= end {
  0x4bd6d4		4c89442430		MOVQ R8, 0x30(SP)	
		wg.Go(func() {
  0x4bd6d9		b828000000		MOVL $0x28, AX							
  0x4bd6de		488d1d1baf0f00		LEAQ 0xfaf1b(IP), BX						
  0x4bd6e5		b901000000		MOVL $0x1, CX							
  0x4bd6ea		e87102f6ff		CALL runtime.mallocgcSmallScanNoHeaderSC5(SB)			
  0x4bd6ef		488d150a2c0000		LEAQ gopic.(*SimulationState).Step3MoveElectrons.func1(SB), DX	
  0x4bd6f6		488910			MOVQ DX, 0(AX)							
  0x4bd6f9		833d7007130000		CMPL runtime.writeBarrier(SB), $0x0				
  0x4bd700		7507			JNE 0x4bd709							
  0x4bd702		488b4c2468		MOVQ 0x68(SP), CX						
  0x4bd707		eb0d			JMP 0x4bd716							
  0x4bd709		e8324afcff		CALL runtime.gcWriteBarrier1(SB)				
  0x4bd70e		488b4c2468		MOVQ 0x68(SP), CX						
  0x4bd713		49890b			MOVQ CX, 0(R11)							
  0x4bd716		48894808		MOVQ CX, 0x8(AX)						
  0x4bd71a		488b4c2448		MOVQ 0x48(SP), CX						
  0x4bd71f		48894810		MOVQ CX, 0x10(AX)						
  0x4bd723		488b4c2420		MOVQ 0x20(SP), CX						
  0x4bd728		48894818		MOVQ CX, 0x18(AX)						
  0x4bd72c		488b4c2430		MOVQ 0x30(SP), CX						
  0x4bd731		48894820		MOVQ CX, 0x20(AX)						
  0x4bd735		4889c3			MOVQ AX, BX							
  0x4bd738		488b442450		MOVQ 0x50(SP), AX						
  0x4bd73d		0f1f00			NOPL 0(AX)							
  0x4bd740		e87bcffcff		CALL sync.(*WaitGroup).Go(SB)					
		start := w * chunkSize
  0x4bd745		488b442438		MOVQ 0x38(SP), AX	
	wg.Wait()
  0x4bd74a		488b4c2450		MOVQ 0x50(SP), CX	
		end := min((w+1)*chunkSize, sim.N_e)
  0x4bd74f		488b5c2468		MOVQ 0x68(SP), BX	
	for w := range numWorkers {
  0x4bd754		488b7c2428		MOVQ 0x28(SP), DI	
  0x4bd759		4c8b4c2440		MOVQ 0x40(SP), R9	
  0x4bd75e		6690			NOPW			
		wg.Go(func() {
  0x4bd760		e92dffffff		JMP 0x4bd692		
	wg.Wait()
  0x4bd765		4889c8			MOVQ CX, AX			
  0x4bd768		e833cefcff		CALL sync.(*WaitGroup).Wait(SB)	
	if sim.Measurement_mode {
  0x4bd76d		488b4c2468		MOVQ 0x68(SP), CX		
  0x4bd772		80b9e02dba0700		CMPB 0x7ba2de0(CX), $0x0	
  0x4bd779		740e			JE 0x4bd789			
		for w := range numWorkers {
  0x4bd77b		31c0			XORL AX, AX		
  0x4bd77d		488b542428		MOVQ 0x28(SP), DX	
  0x4bd782		488b5c2470		MOVQ 0x70(SP), BX	
  0x4bd787		eb43			JMP 0x4bd7cc		
}
  0x4bd789		4883c458		ADDQ $0x58, SP		
  0x4bd78d		5d			POPQ BP			
  0x4bd78e		c3			RET			
			sim.Mean_energy_accu_center += sim.WorkerEDiag[w].accuCenter
  0x4bd78f		f20f1081802dba07	MOVSD_XMM 0x7ba2d80(CX), X0	
  0x4bd797		488b7130		MOVQ 0x30(CX), SI		
  0x4bd79b		4869f8c0700000		IMULQ $0x70c0, AX, DI		
  0x4bd7a2		f20f58843e80700000	ADDSD 0x7080(SI)(DI*1), X0	
  0x4bd7ab		f20f1181802dba07	MOVSD_XMM X0, 0x7ba2d80(CX)	
			sim.Mean_energy_counter_center += sim.WorkerEDiag[w].counterCenter
  0x4bd7b3		4c8b81882dba07		MOVQ 0x7ba2d88(CX), R8		
  0x4bd7ba		4c03843e88700000	ADDQ 0x7088(SI)(DI*1), R8	
  0x4bd7c2		4c8981882dba07		MOVQ R8, 0x7ba2d88(CX)		
		for w := range numWorkers {
  0x4bd7c9		48ffc0			INCQ AX			
  0x4bd7cc		4839d0			CMPQ AX, DX		
  0x4bd7cf		7db8			JGE 0x4bd789		
				sim.Counter_e_xt[p][t_index] += sim.WorkerEDiag[w].counter_e[p]
  0x4bd7d1		4869f0c0700000		IMULQ $0x70c0, AX, SI	
			for p := range N_G {
  0x4bd7d8		31ff			XORL DI, DI		
  0x4bd7da		eb24			JMP 0x4bd800		
				sim.Ioniz_rate_xt[p][t_index] += sim.WorkerEDiag[w].ioniz[p]
  0x4bd7dc		4c8b4930		MOVQ 0x30(CX), R9		
  0x4bd7e0		4d8d0c31		LEAQ 0(R9)(SI*1), R9		
  0x4bd7e4		4d8d8980250000		LEAQ 0x2580(R9), R9		
  0x4bd7eb		f2410f5804f9		ADDSD 0(R9)(DI*8), X0		
  0x4bd7f1		f2410f1104d8		MOVSD_XMM X0, 0(R8)(BX*8)	
			for p := range N_G {
  0x4bd7f7		48ffc7			INCQ DI			
  0x4bd7fa		660f1f440000		NOPW 0(AX)(AX*1)	
  0x4bd800		4881ff90010000		CMPQ DI, $0x190		
  0x4bd807		0f8de1000000		JGE 0x4bd8ee		
				sim.Counter_e_xt[p][t_index] += sim.WorkerEDiag[w].counter_e[p]
  0x4bd80d		4c69c740060000		IMULQ $0x640, DI, R8		
  0x4bd814		4e8d0c01		LEAQ 0(CX)(R8*1), R9		
  0x4bd818		4d8d8980e19c07		LEAQ 0x79ce180(R9), R9		
  0x4bd81f		90			NOPL				
  0x4bd820		4881fbc8000000		CMPQ BX, $0xc8			
  0x4bd827		0f833d010000		JAE 0x4bd96a			
  0x4bd82d		4c8b5138		MOVQ 0x38(CX), R10		
  0x4bd831		f2410f1004d9		MOVSD_XMM 0(R9)(BX*8), X0	
  0x4bd837		660f1f840000000000	NOPW 0(AX)(AX*1)		
  0x4bd840		4c39d0			CMPQ AX, R10			
  0x4bd843		0f831c010000		JAE 0x4bd965			
  0x4bd849		4c8b5130		MOVQ 0x30(CX), R10		
  0x4bd84d		4901f2			ADDQ SI, R10			
  0x4bd850		f2410f5804fa		ADDSD 0(R10)(DI*8), X0		
  0x4bd856		f2410f1104d9		MOVSD_XMM X0, 0(R9)(BX*8)	
				sim.Ue_xt[p][t_index] += sim.WorkerEDiag[w].ue[p]
  0x4bd85c		4e8d0c01		LEAQ 0(CX)(R8*1), R9		
  0x4bd860		4d8d8980c14e07		LEAQ 0x74ec180(R9), R9		
  0x4bd867		4c8b5138		MOVQ 0x38(CX), R10		
  0x4bd86b		f2410f1004d9		MOVSD_XMM 0(R9)(BX*8), X0	
  0x4bd871		4c39d0			CMPQ AX, R10			
  0x4bd874		0f83e4000000		JAE 0x4bd95e			
  0x4bd87a		4c8b5130		MOVQ 0x30(CX), R10		
  0x4bd87e		4d8d1432		LEAQ 0(R10)(SI*1), R10		
  0x4bd882		4d8d92800c0000		LEAQ 0xc80(R10), R10		
  0x4bd889		f2410f5804fa		ADDSD 0(R10)(DI*8), X0		
  0x4bd88f		f2410f1104d9		MOVSD_XMM X0, 0(R9)(BX*8)	
				sim.Meanee_xt[p][t_index] += sim.WorkerEDiag[w].meanee[p]
  0x4bd895		4e8d0c01		LEAQ 0(CX)(R8*1), R9		
  0x4bd899		4d8d8980598907		LEAQ 0x7895980(R9), R9		
  0x4bd8a0		4c8b5138		MOVQ 0x38(CX), R10		
  0x4bd8a4		f2410f1004d9		MOVSD_XMM 0(R9)(BX*8), X0	
  0x4bd8aa		4c39d0			CMPQ AX, R10			
  0x4bd8ad		0f83a6000000		JAE 0x4bd959			
  0x4bd8b3		4c8b5130		MOVQ 0x30(CX), R10		
  0x4bd8b7		4d8d1432		LEAQ 0(R10)(SI*1), R10		
  0x4bd8bb		4d8d9200190000		LEAQ 0x1900(R10), R10		
  0x4bd8c2		f2410f5804fa		ADDSD 0(R10)(DI*8), X0		
  0x4bd8c8		f2410f1104d9		MOVSD_XMM X0, 0(R9)(BX*8)	
				sim.Ioniz_rate_xt[p][t_index] += sim.WorkerEDiag[w].ioniz[p]
  0x4bd8ce		4e8d0401		LEAQ 0(CX)(R8*1), R8		
  0x4bd8d2		4d8d808069b007		LEAQ 0x7b06980(R8), R8		
  0x4bd8d9		4c8b4938		MOVQ 0x38(CX), R9		
  0x4bd8dd		f2410f1004d8		MOVSD_XMM 0(R8)(BX*8), X0	
  0x4bd8e3		4c39c8			CMPQ AX, R9			
  0x4bd8e6		0f82f0feffff		JB 0x4bd7dc			
  0x4bd8ec		eb66			JMP 0x4bd954			
				sim.Eepf[i] += sim.WorkerEDiag[w].eepf[i]
  0x4bd8ee		4869f0c0700000		IMULQ $0x70c0, AX, SI	
			for p := range N_G {
  0x4bd8f5		31ff			XORL DI, DI		
  0x4bd8f7		eb27			JMP 0x4bd920		
				sim.Eepf[i] += sim.WorkerEDiag[w].eepf[i]
  0x4bd8f9		4c8b4130		MOVQ 0x30(CX), R8			
  0x4bd8fd		4d8d0430		LEAQ 0(R8)(SI*1), R8			
  0x4bd901		4d8d8000320000		LEAQ 0x3200(R8), R8			
  0x4bd908		f2410f5804f8		ADDSD 0(R8)(DI*8), X0			
  0x4bd90e		f20f1184f970662707	MOVSD_XMM X0, 0x7276670(CX)(DI*8)	
			for i := range N_EEPF {
  0x4bd917		48ffc7			INCQ DI			
  0x4bd91a		660f1f440000		NOPW 0(AX)(AX*1)	
  0x4bd920		4881ffd0070000		CMPQ DI, $0x7d0		
  0x4bd927		7d14			JGE 0x4bd93d		
				sim.Eepf[i] += sim.WorkerEDiag[w].eepf[i]
  0x4bd929		4c8b4138		MOVQ 0x38(CX), R8			
  0x4bd92d		f20f1084f970662707	MOVSD_XMM 0x7276670(CX)(DI*8), X0	
  0x4bd936		4c39c0			CMPQ AX, R8				
  0x4bd939		72be			JB 0x4bd8f9				
  0x4bd93b		eb12			JMP 0x4bd94f				
			sim.Mean_energy_accu_center += sim.WorkerEDiag[w].accuCenter
  0x4bd93d		488b7138		MOVQ 0x38(CX), SI		
  0x4bd941		4839f0			CMPQ AX, SI			
  0x4bd944		0f8245feffff		JB 0x4bd78f			
  0x4bd94a		e8b14bfcff		CALL runtime.panicBounds(SB)	
				sim.Eepf[i] += sim.WorkerEDiag[w].eepf[i]
  0x4bd94f		e8ac4bfcff		CALL runtime.panicBounds(SB)	
				sim.Ioniz_rate_xt[p][t_index] += sim.WorkerEDiag[w].ioniz[p]
  0x4bd954		e8a74bfcff		CALL runtime.panicBounds(SB)	
				sim.Meanee_xt[p][t_index] += sim.WorkerEDiag[w].meanee[p]
  0x4bd959		e8a24bfcff		CALL runtime.panicBounds(SB)	
				sim.Ue_xt[p][t_index] += sim.WorkerEDiag[w].ue[p]
  0x4bd95e		6690			NOPW				
  0x4bd960		e89b4bfcff		CALL runtime.panicBounds(SB)	
				sim.Counter_e_xt[p][t_index] += sim.WorkerEDiag[w].counter_e[p]
  0x4bd965		e8964bfcff		CALL runtime.panicBounds(SB)	
  0x4bd96a		b8c8000000		MOVL $0xc8, AX			
  0x4bd96f		e88c4bfcff		CALL runtime.panicBounds(SB)	
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bd974		e82779f8ff		CALL runtime.panicdivide(SB)	
  0x4bd979		90			NOPL				
func (sim *SimulationState) Step3MoveElectrons(t_index int) {
  0x4bd97a		4889442408		MOVQ AX, 0x8(SP)					
  0x4bd97f		48895c2410		MOVQ BX, 0x10(SP)					
  0x4bd984		e8372ffcff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x4bd989		488b442408		MOVQ 0x8(SP), AX					
  0x4bd98e		488b5c2410		MOVQ 0x10(SP), BX					
  0x4bd993		e968fcffff		JMP gopic.(*SimulationState).Step3MoveElectrons(SB)	

TEXT gopic.(*SimulationState).Step3MoveElectrons.func1(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
		wg.Go(func() {
  0x4c0300		55			PUSHQ BP		
  0x4c0301		4889e5			MOVQ SP, BP		
  0x4c0304		488b5a08		MOVQ 0x8(DX), BX	
			if sim.Measurement_mode {
  0x4c0308		8403			TESTB AL, 0(BX)		
		wg.Go(func() {
  0x4c030a		488b7220		MOVQ 0x20(DX), SI	
  0x4c030e		4c8b4218		MOVQ 0x18(DX), R8	
			if sim.Measurement_mode {
  0x4c0312		80bbe02dba0700		CMPB 0x7ba2de0(BX), $0x0	
  0x4c0319		742f			JE 0x4c034a			
		wg.Go(func() {
  0x4c031b		488b5210		MOVQ 0x10(DX), DX	
				diag := &sim.WorkerEDiag[workerID]
  0x4c031f		4c8b4b38		MOVQ 0x38(BX), R9	
  0x4c0323		4939d1			CMPQ R9, DX		
  0x4c0326		0f8606070000		JBE 0x4c0a32		
  0x4c032c		4c8b4b30		MOVQ 0x30(BX), R9	
  0x4c0330		4869d2c0700000		IMULQ $0x70c0, DX, DX	
  0x4c0337		498d3c11		LEAQ 0(R9)(DX*1), DI	
				*diag = electronWorkerDiagnostics{}
  0x4c033b		b9180e0000		MOVL $0xe18, CX		
  0x4c0340		31c0			XORL AX, AX		
  0x4c0342		f348ab			REP; STOSQ AX, ES:0(DI)	
				for k := s; k < e; k++ {
  0x4c0345		e900040000		JMP 0x4c074a		
				if e > s {
  0x4c034a		4c39c6			CMPQ SI, R8		
  0x4c034d		7e10			JLE 0x4c035f		
					_ = sim.X_e[e-1]
  0x4c034f		488d46ff		LEAQ -0x1(SI), AX	
  0x4c0353		483d40420f00		CMPQ AX, $0xf4240	
  0x4c0359		0f83a6030000		JAE 0x4c0705		
				for ; k <= e-4; k += 4 {
  0x4c035f		488d46fc		LEAQ -0x4(SI), AX	
  0x4c0363		e91e010000		JMP 0x4c0486		
					d3 := c0_3 - float64(p3)
  0x4c0368		0f57ed			XORPS X5, X5		
  0x4c036b		f2480f2ae9		CVTSI2SDQ CX, X5	
  0x4c0370		f20f5ce5		SUBSD X5, X4		
					ex3 := sim.Efield[p3] + d3*(sim.Efield[p3+1]-sim.Efield[p3])
  0x4c0374		f20f10accbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X5	
  0x4c037d		f20f10b4cbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X6	
  0x4c0386		f20f5cf5		SUBSD X5, X6				
  0x4c038a		f20f59e6		MULSD X6, X4				
  0x4c038e		f20f58e5		ADDSD X5, X4				
					vx0 := sim.Vx_e[k] - ex0*FACTOR_E
  0x4c0392		f2420f10acc3d090d003	MOVSD_XMM 0x3d090d0(BX)(R8*8), X5	
  0x4c039c		f20f103554d60000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x4c03a4		f20f59c6		MULSD X6, X0				
  0x4c03a8		f20f5ce8		SUBSD X0, X5				
					vx1 := sim.Vx_e[k+1] - ex1*FACTOR_E
  0x4c03ac		f2420f1084c3d890d003	MOVSD_XMM 0x3d090d8(BX)(R8*8), X0	
  0x4c03b6		f20f59d6		MULSD X6, X2				
  0x4c03ba		f20f5cc2		SUBSD X2, X0				
					vx2 := sim.Vx_e[k+2] - ex2*FACTOR_E
  0x4c03be		f2420f1094c3e090d003	MOVSD_XMM 0x3d090e0(BX)(R8*8), X2	
  0x4c03c8		f20f59de		MULSD X6, X3				
  0x4c03cc		f20f5cd3		SUBSD X3, X2				
					vx3 := sim.Vx_e[k+3] - ex3*FACTOR_E
  0x4c03d0		f2420f109cc3e890d003	MOVSD_XMM 0x3d090e8(BX)(R8*8), X3	
					sim.Vx_e[k] = vx0
  0x4c03da		f2420f11acc3d090d003	MOVSD_XMM X5, 0x3d090d0(BX)(R8*8)	
					sim.Vx_e[k+1] = vx1
  0x4c03e4		f2420f1184c3d890d003	MOVSD_XMM X0, 0x3d090d8(BX)(R8*8)	
					sim.Vx_e[k+2] = vx2
  0x4c03ee		f2420f1194c3e090d003	MOVSD_XMM X2, 0x3d090e0(BX)(R8*8)	
					vx3 := sim.Vx_e[k+3] - ex3*FACTOR_E
  0x4c03f8		f20f59e6		MULSD X6, X4		
  0x4c03fc		f20f5cdc		SUBSD X4, X3		
					sim.Vx_e[k+3] = vx3
  0x4c0400		f2420f119cc3e890d003	MOVSD_XMM X3, 0x3d090e8(BX)(R8*8)	
					sim.X_e[k] += vx0 * DT_E
  0x4c040a		f2420f10a4c3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R8*8), X4	
  0x4c0414		f20f103dccd40000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X7	
  0x4c041c		f20f59ef		MULSD X7, X5				
  0x4c0420		f20f58e5		ADDSD X5, X4				
  0x4c0424		f2420f11a4c3d07e5603	MOVSD_XMM X4, 0x3567ed0(BX)(R8*8)	
					sim.X_e[k+1] += vx1 * DT_E
  0x4c042e		f2420f10a4c3d87e5603	MOVSD_XMM 0x3567ed8(BX)(R8*8), X4	
  0x4c0438		f20f59c7		MULSD X7, X0				
  0x4c043c		f20f58c4		ADDSD X4, X0				
  0x4c0440		f2420f1184c3d87e5603	MOVSD_XMM X0, 0x3567ed8(BX)(R8*8)	
					sim.X_e[k+2] += vx2 * DT_E
  0x4c044a		f2420f1084c3e07e5603	MOVSD_XMM 0x3567ee0(BX)(R8*8), X0	
  0x4c0454		f20f59d7		MULSD X7, X2				
  0x4c0458		f20f58d0		ADDSD X0, X2				
  0x4c045c		f2420f1194c3e07e5603	MOVSD_XMM X2, 0x3567ee0(BX)(R8*8)	
					sim.X_e[k+3] += vx3 * DT_E
  0x4c0466		f2420f1084c3e87e5603	MOVSD_XMM 0x3567ee8(BX)(R8*8), X0	
  0x4c0470		f20f59df		MULSD X7, X3				
  0x4c0474		f20f58d8		ADDSD X0, X3				
  0x4c0478		f2420f119cc3e87e5603	MOVSD_XMM X3, 0x3567ee8(BX)(R8*8)	
				for ; k <= e-4; k += 4 {
  0x4c0482		4983c004		ADDQ $0x4, R8		
  0x4c0486		4939c0			CMPQ R8, AX		
  0x4c0489		0f8feb010000		JG 0x4c067a		
					c0_0 := sim.X_e[k] * INV_DX
  0x4c048f		4981f840420f00		CMPQ R8, $0xf4240			
  0x4c0496		0f835d020000		JAE 0x4c06f9				
  0x4c049c		f2420f1084c3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R8*8), X0	
  0x4c04a6		f20f100df2d50000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4c04ae		f20f59c1		MULSD X1, X0				
					p0 := min(max(int(c0_0), 0), N_G-2)
  0x4c04b2		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x4c04b7		4885c9			TESTQ CX, CX		
  0x4c04ba		7d04			JGE 0x4c04c0		
  0x4c04bc		31c9			XORL CX, CX		
  0x4c04be		6690			NOPW			
  0x4c04c0		4881f98e010000		CMPQ CX, $0x18e		
  0x4c04c7		7e05			JLE 0x4c04ce		
  0x4c04c9		b98e010000		MOVL $0x18e, CX		
					d0 := c0_0 - float64(p0)
  0x4c04ce		0f57d2			XORPS X2, X2		
  0x4c04d1		f2480f2ad1		CVTSI2SDQ CX, X2	
  0x4c04d6		f20f5cc2		SUBSD X2, X0		
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x4c04da		f20f1094cbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X2	
  0x4c04e3		f20f109ccbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X3	
  0x4c04ec		f20f5cda		SUBSD X2, X3				
  0x4c04f0		f20f59c3		MULSD X3, X0				
					c0_1 := sim.X_e[k+1] * INV_DX
  0x4c04f4		498d4801		LEAQ 0x1(R8), CX	
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x4c04f8		f20f58c2		ADDSD X2, X0		
  0x4c04fc		0f1f4000		NOPL 0(AX)		
					c0_1 := sim.X_e[k+1] * INV_DX
  0x4c0500		4881f940420f00		CMPQ CX, $0xf4240			
  0x4c0507		0f83dd010000		JAE 0x4c06ea				
  0x4c050d		f2420f1094c3d87e5603	MOVSD_XMM 0x3567ed8(BX)(R8*8), X2	
  0x4c0517		f20f59d1		MULSD X1, X2				
					p1 := min(max(int(c0_1), 0), N_G-2)
  0x4c051b		f2480f2cca		CVTTSD2SIQ X2, CX	
  0x4c0520		4885c9			TESTQ CX, CX		
  0x4c0523		7d02			JGE 0x4c0527		
  0x4c0525		31c9			XORL CX, CX		
  0x4c0527		4881f98e010000		CMPQ CX, $0x18e		
  0x4c052e		7e05			JLE 0x4c0535		
  0x4c0530		b98e010000		MOVL $0x18e, CX		
					d1 := c0_1 - float64(p1)
  0x4c0535		0f57db			XORPS X3, X3		
  0x4c0538		f2480f2ad9		CVTSI2SDQ CX, X3	
  0x4c053d		f20f5cd3		SUBSD X3, X2		
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x4c0541		f20f109ccbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X3	
  0x4c054a		f20f10a4cbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X4	
  0x4c0553		f20f5ce3		SUBSD X3, X4				
  0x4c0557		f20f59d4		MULSD X4, X2				
					c0_2 := sim.X_e[k+2] * INV_DX
  0x4c055b		498d4802		LEAQ 0x2(R8), CX	
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x4c055f		f20f58d3		ADDSD X3, X2		
					c0_2 := sim.X_e[k+2] * INV_DX
  0x4c0563		4881f940420f00		CMPQ CX, $0xf4240			
  0x4c056a		0f836b010000		JAE 0x4c06db				
  0x4c0570		f2420f109cc3e07e5603	MOVSD_XMM 0x3567ee0(BX)(R8*8), X3	
  0x4c057a		f20f59d9		MULSD X1, X3				
					p2 := min(max(int(c0_2), 0), N_G-2)
  0x4c057e		f2480f2ccb		CVTTSD2SIQ X3, CX	
  0x4c0583		4885c9			TESTQ CX, CX		
  0x4c0586		7d02			JGE 0x4c058a		
  0x4c0588		31c9			XORL CX, CX		
  0x4c058a		4881f98e010000		CMPQ CX, $0x18e		
  0x4c0591		7e05			JLE 0x4c0598		
  0x4c0593		b98e010000		MOVL $0x18e, CX		
					d2 := c0_2 - float64(p2)
  0x4c0598		0f57e4			XORPS X4, X4		
  0x4c059b		f2480f2ae1		CVTSI2SDQ CX, X4	
  0x4c05a0		f20f5cdc		SUBSD X4, X3		
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x4c05a4		f20f10a4cbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X4	
  0x4c05ad		f20f10accbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X5	
  0x4c05b6		f20f5cec		SUBSD X4, X5				
  0x4c05ba		f20f59dd		MULSD X5, X3				
					c0_3 := sim.X_e[k+3] * INV_DX
  0x4c05be		498d4803		LEAQ 0x3(R8), CX	
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x4c05c2		f20f58dc		ADDSD X4, X3		
					c0_3 := sim.X_e[k+3] * INV_DX
  0x4c05c6		4881f940420f00		CMPQ CX, $0xf4240			
  0x4c05cd		0f83fe000000		JAE 0x4c06d1				
  0x4c05d3		f2420f10a4c3e87e5603	MOVSD_XMM 0x3567ee8(BX)(R8*8), X4	
  0x4c05dd		f20f59e1		MULSD X1, X4				
					p3 := min(max(int(c0_3), 0), N_G-2)
  0x4c05e1		f2480f2ccc		CVTTSD2SIQ X4, CX	
  0x4c05e6		4885c9			TESTQ CX, CX		
  0x4c05e9		7d02			JGE 0x4c05ed		
  0x4c05eb		31c9			XORL CX, CX		
  0x4c05ed		4881f98e010000		CMPQ CX, $0x18e		
  0x4c05f4		0f8e6efdffff		JLE 0x4c0368		
  0x4c05fa		b98e010000		MOVL $0x18e, CX		
  0x4c05ff		90			NOPL			
  0x4c0600		e963fdffff		JMP 0x4c0368		
					d := c0 - float64(p)
  0x4c0605		0f57d2			XORPS X2, X2		
  0x4c0608		f2480f2ad0		CVTSI2SDQ AX, X2	
  0x4c060d		f20f5cc2		SUBSD X2, X0		
					ex := sim.Efield[p] + d*(sim.Efield[p+1]-sim.Efield[p])
  0x4c0611		f20f1094c3d00e2707	MOVSD_XMM 0x7270ed0(BX)(AX*8), X2	
  0x4c061a		f20f109cc3d80e2707	MOVSD_XMM 0x7270ed8(BX)(AX*8), X3	
  0x4c0623		f20f5cda		SUBSD X2, X3				
  0x4c0627		f20f59c3		MULSD X3, X0				
  0x4c062b		f20f58c2		ADDSD X2, X0				
					sim.Vx_e[k] -= ex * FACTOR_E
  0x4c062f		f2420f1094c3d090d003	MOVSD_XMM 0x3d090d0(BX)(R8*8), X2	
  0x4c0639		f20f101db7d30000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X3	
  0x4c0641		f20f59c3		MULSD X3, X0				
  0x4c0645		f20f5cd0		SUBSD X0, X2				
  0x4c0649		f2420f1194c3d090d003	MOVSD_XMM X2, 0x3d090d0(BX)(R8*8)	
					sim.X_e[k] += sim.Vx_e[k] * DT_E
  0x4c0653		f2420f1084c3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R8*8), X0	
  0x4c065d		f20f102583d20000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X4	
  0x4c0665		f20f59d4		MULSD X4, X2				
  0x4c0669		f20f58c2		ADDSD X2, X0				
  0x4c066d		f2420f1184c3d07e5603	MOVSD_XMM X0, 0x3567ed0(BX)(R8*8)	
				for ; k < e; k++ {
  0x4c0677		49ffc0			INCQ R8			
  0x4c067a		4939f0			CMPQ R8, SI		
  0x4c067d		7d46			JGE 0x4c06c5		
  0x4c067f		90			NOPL			
					c0 := sim.X_e[k] * INV_DX
  0x4c0680		4981f840420f00		CMPQ R8, $0xf4240			
  0x4c0687		733e			JAE 0x4c06c7				
  0x4c0689		f2420f1084c3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R8*8), X0	
  0x4c0693		f20f100d05d40000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4c069b		f20f59c1		MULSD X1, X0				
					p := min(max(int(c0), 0), N_G-2)
  0x4c069f		f2480f2cc0		CVTTSD2SIQ X0, AX	
  0x4c06a4		4885c0			TESTQ AX, AX		
  0x4c06a7		7d02			JGE 0x4c06ab		
  0x4c06a9		31c0			XORL AX, AX		
  0x4c06ab		483d8e010000		CMPQ AX, $0x18e		
  0x4c06b1		0f8e4effffff		JLE 0x4c0605		
  0x4c06b7		b88e010000		MOVL $0x18e, AX		
  0x4c06bc		0f1f4000		NOPL 0(AX)		
  0x4c06c0		e940ffffff		JMP 0x4c0605		
		})
  0x4c06c5		5d			POPQ BP			
  0x4c06c6		c3			RET			
					c0 := sim.X_e[k] * INV_DX
  0x4c06c7		b840420f00		MOVL $0xf4240, AX		
  0x4c06cc		e82f1efcff		CALL runtime.panicBounds(SB)	
					c0_3 := sim.X_e[k+3] * INV_DX
  0x4c06d1		b840420f00		MOVL $0xf4240, AX		
  0x4c06d6		e8251efcff		CALL runtime.panicBounds(SB)	
					c0_2 := sim.X_e[k+2] * INV_DX
  0x4c06db		b840420f00		MOVL $0xf4240, AX		
  0x4c06e0		b940420f00		MOVL $0xf4240, CX		
  0x4c06e5		e8161efcff		CALL runtime.panicBounds(SB)	
					c0_1 := sim.X_e[k+1] * INV_DX
  0x4c06ea		b840420f00		MOVL $0xf4240, AX		
  0x4c06ef		b940420f00		MOVL $0xf4240, CX		
  0x4c06f4		e8071efcff		CALL runtime.panicBounds(SB)	
					c0_0 := sim.X_e[k] * INV_DX
  0x4c06f9		b840420f00		MOVL $0xf4240, AX		
  0x4c06fe		6690			NOPW				
  0x4c0700		e8fb1dfcff		CALL runtime.panicBounds(SB)	
					_ = sim.X_e[e-1]
  0x4c0705		b940420f00		MOVL $0xf4240, CX		
  0x4c070a		e8f11dfcff		CALL runtime.panicBounds(SB)	
					sim.Vx_e[k] -= e_x * FACTOR_E
  0x4c070f		f2420f1084c3d090d003	MOVSD_XMM 0x3d090d0(BX)(R8*8), X0	
  0x4c0719		f20f59e6		MULSD X6, X4				
  0x4c071d		f20f5cc4		SUBSD X4, X0				
  0x4c0721		f2420f1184c3d090d003	MOVSD_XMM X0, 0x3d090d0(BX)(R8*8)	
					sim.X_e[k] += sim.Vx_e[k] * DT_E
  0x4c072b		f2420f10a4c3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R8*8), X4	
  0x4c0735		f20f59c2		MULSD X2, X0				
  0x4c0739		f20f58e0		ADDSD X0, X4				
  0x4c073d		f2420f11a4c3d07e5603	MOVSD_XMM X4, 0x3567ed0(BX)(R8*8)	
				for k := s; k < e; k++ {
  0x4c0747		49ffc0			INCQ R8			
  0x4c074a		4939f0			CMPQ R8, SI		
  0x4c074d		0f8d72ffffff		JGE 0x4c06c5		
  0x4c0753		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x4c075c		0f1f4000		NOPL 0(AX)		
					c0 = sim.X_e[k] * INV_DX
  0x4c0760		4981f840420f00		CMPQ R8, $0xf4240			
  0x4c0767		0f83bb020000		JAE 0x4c0a28				
  0x4c076d		f2420f1084c3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R8*8), X0	
  0x4c0777		f20f100d21d30000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4c077f		f20f59c1		MULSD X1, X0				
					p = min(max(int(c0), 0), N_G-2)
  0x4c0783		f2480f2cc0		CVTTSD2SIQ X0, AX	
  0x4c0788		4885c0			TESTQ AX, AX		
  0x4c078b		7d02			JGE 0x4c078f		
  0x4c078d		31c0			XORL AX, AX		
  0x4c078f		483d8e010000		CMPQ AX, $0x18e		
  0x4c0795		7e05			JLE 0x4c079c		
  0x4c0797		b88e010000		MOVL $0x18e, AX		
					c1 = float64(p) + 1.0 - c0
  0x4c079c		0f57d2			XORPS X2, X2				
  0x4c079f		f2480f2ad0		CVTSI2SDQ AX, X2			
  0x4c07a4		f20f101d04d20000	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x4c07ac		f20f58da		ADDSD X2, X3				
  0x4c07b0		f20f5cd8		SUBSD X0, X3				
					c2 = c0 - float64(p)
  0x4c07b4		f20f5cc2		SUBSD X2, X0		
					e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]
  0x4c07b8		f20f1094c3d00e2707	MOVSD_XMM 0x7270ed0(BX)(AX*8), X2	
  0x4c07c1		f20f59d3		MULSD X3, X2				
  0x4c07c5		f20f10a4c3d80e2707	MOVSD_XMM 0x7270ed8(BX)(AX*8), X4	
  0x4c07ce		f20f59e0		MULSD X0, X4				
  0x4c07d2		f20f58e2		ADDSD X2, X4				
					mean_v = sim.Vx_e[k] - 0.5*e_x*FACTOR_E
  0x4c07d6		f2420f1094c3d090d003	MOVSD_XMM 0x3d090d0(BX)(R8*8), X2	
  0x4c07e0		f20f102db0d10000	MOVSD_XMM $f64.3fe0000000000000(SB), X5	
  0x4c07e8		f20f59ec		MULSD X4, X5				
  0x4c07ec		f20f103504d20000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x4c07f4		f20f59ee		MULSD X6, X5				
  0x4c07f8		f20f5cd5		SUBSD X5, X2				
					diag.counter_e[p] += c1
  0x4c07fc		498d0c11		LEAQ 0(R9)(DX*1), CX		
  0x4c0800		f20f102cc1		MOVSD_XMM 0(CX)(AX*8), X5	
  0x4c0805		f20f58eb		ADDSD X3, X5			
  0x4c0809		f20f112cc1		MOVSD_XMM X5, 0(CX)(AX*8)	
					diag.counter_e[p+1] += c2
  0x4c080e		f20f106cc108		MOVSD_XMM 0x8(CX)(AX*8), X5	
  0x4c0814		f20f58e8		ADDSD X0, X5			
  0x4c0818		f20f116cc108		MOVSD_XMM X5, 0x8(CX)(AX*8)	
					diag.ue[p] += c1 * mean_v
  0x4c081e		498d0c11		LEAQ 0(R9)(DX*1), CX		
  0x4c0822		488d89800c0000		LEAQ 0xc80(CX), CX		
  0x4c0829		f20f102cc1		MOVSD_XMM 0(CX)(AX*8), X5	
  0x4c082e		0f10fb			MOVUPS X3, X7			
  0x4c0831		f20f59da		MULSD X2, X3			
  0x4c0835		f20f58dd		ADDSD X5, X3			
  0x4c0839		f20f111cc1		MOVSD_XMM X3, 0(CX)(AX*8)	
					diag.ue[p+1] += c2 * mean_v
  0x4c083e		f20f105cc108		MOVSD_XMM 0x8(CX)(AX*8), X3	
  0x4c0844		0f10e8			MOVUPS X0, X5			
  0x4c0847		f20f59c2		MULSD X2, X0			
  0x4c084b		f20f58c3		ADDSD X3, X0			
  0x4c084f		f20f1144c108		MOVSD_XMM X0, 0x8(CX)(AX*8)	
					v_sqr = mean_v*mean_v + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
  0x4c0855		f20f59d2		MULSD X2, X2				
  0x4c0859		f2420f1084c3d0a24a04	MOVSD_XMM 0x44aa2d0(BX)(R8*8), X0	
  0x4c0863		f20f59c0		MULSD X0, X0				
  0x4c0867		f20f58c2		ADDSD X2, X0				
  0x4c086b		f2420f1094c3d0b4c404	MOVSD_XMM 0x4c4b4d0(BX)(R8*8), X2	
  0x4c0875		f20f59d2		MULSD X2, X2				
  0x4c0879		f20f58c2		ADDSD X2, X0				
					energy = 0.5 * E_MASS * v_sqr * INV_EV_TO_J
  0x4c087d		f20f101503d00000	MOVSD_XMM $f64.39a279dcc3e61461(SB), X2	
  0x4c0885		f20f59d0		MULSD X0, X2				
  0x4c0889		f20f101d3fd20000	MOVSD_XMM $f64.43d5a792def818e8(SB), X3	
  0x4c0891		f20f59d3		MULSD X3, X2				
					diag.meanee[p] += c1 * energy
  0x4c0895		498d0c11		LEAQ 0(R9)(DX*1), CX		
  0x4c0899		488d8900190000		LEAQ 0x1900(CX), CX		
  0x4c08a0		f2440f1004c1		MOVSD_XMM 0(CX)(AX*8), X8	
  0x4c08a6		440f10ca		MOVUPS X2, X9			
  0x4c08aa		f20f59d7		MULSD X7, X2			
  0x4c08ae		f2410f58d0		ADDSD X8, X2			
  0x4c08b3		f20f1114c1		MOVSD_XMM X2, 0(CX)(AX*8)	
					diag.meanee[p+1] += c2 * energy
  0x4c08b8		f20f1054c108		MOVSD_XMM 0x8(CX)(AX*8), X2	
  0x4c08be		450f10c1		MOVUPS X9, X8			
  0x4c08c2		f2440f59cd		MULSD X5, X9			
  0x4c08c7		f2440f58ca		ADDSD X2, X9			
  0x4c08cc		f2440f114cc108		MOVSD_XMM X9, 0x8(CX)(AX*8)	
					energy_index = minInt(int(v_sqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
  0x4c08d3		f20f101525d00000	MOVSD_XMM $f64.3e286b6a97118d9b(SB), X2	
  0x4c08db		f20f59d0		MULSD X0, X2				
  0x4c08df		f2440f100db0d00000	MOVSD_XMM $f64.3fe0000000000000(SB), X9	
  0x4c08e8		f2410f58d1		ADDSD X9, X2				
  0x4c08ed		f2480f2cca		CVTTSD2SIQ X2, CX			
	if a < b {
  0x4c08f2		4881f93f420f00		CMPQ CX, $0xf423f	
  0x4c08f9		7c05			JL 0x4c0900		
  0x4c08fb		b93f420f00		MOVL $0xf423f, CX	
					velocity = math.Sqrt(v_sqr)
  0x4c0900		90			NOPL			
					rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x4c0901		4881f940420f00		CMPQ CX, $0xf4240	
  0x4c0908		0f8310010000		JAE 0x4c0a1e		
					diag.ioniz[p] += c1 * rate
  0x4c090e		498d3c11		LEAQ 0(R9)(DX*1), DI	
  0x4c0912		488dbf80250000		LEAQ 0x2580(DI), DI	
	return sqrt(x)
  0x4c0919		f20f51c0		SQRTSD X0, X0		
					rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x4c091d		f20f5984cbc024f400	MULSD 0xf424c0(BX)(CX*8), X0			
  0x4c0926		f20f1015bacf0000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X2		
  0x4c092e		f20f59c2		MULSD X2, X0					
  0x4c0932		f2440f10159dd10000	MOVSD_XMM $f64.445c0bbef48bc79c(SB), X10	
  0x4c093b		f2410f59c2		MULSD X10, X0					
					diag.ioniz[p] += c1 * rate
  0x4c0940		f20f59f8		MULSD X0, X7			
  0x4c0944		f20f583cc7		ADDSD 0(DI)(AX*8), X7		
  0x4c0949		f20f113cc7		MOVSD_XMM X7, 0(DI)(AX*8)	
					diag.ioniz[p+1] += c2 * rate
  0x4c094e		f20f107cc708		MOVSD_XMM 0x8(DI)(AX*8), X7	
  0x4c0954		f20f59c5		MULSD X5, X0			
  0x4c0958		f20f58c7		ADDSD X7, X0			
  0x4c095c		f20f1144c708		MOVSD_XMM X0, 0x8(DI)(AX*8)	
					if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
  0x4c0962		f2420f1084c3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R8*8), X0	
  0x4c096c		f20f102ddccf0000	MOVSD_XMM $f64.3f870a3d70a3d70b(SB), X5	
  0x4c0974		660f2ec5		UCOMISD X5, X0				
  0x4c0978		0f8680000000		JBE 0x4c09fe				
  0x4c097e		f20f103dd2cf0000	MOVSD_XMM $f64.3f8c28f5c28f5c2a(SB), X7	
  0x4c0986		660f2ef8		UCOMISD X0, X7				
  0x4c098a		767a			JBE 0x4c0a06				
						energy_index = int(energy * INV_DE_EEPF)
  0x4c098c		f20f1005c4d00000	MOVSD_XMM $f64.4034000000000000(SB), X0	
  0x4c0994		f2410f59c0		MULSD X8, X0				
  0x4c0999		f2480f2cc0		CVTTSD2SIQ X0, AX			
  0x4c099e		6690			NOPW					
						if energy_index < N_EEPF {
  0x4c09a0		483dd0070000		CMPQ AX, $0x7d0		
  0x4c09a6		7d27			JGE 0x4c09cf		
							diag.eepf[energy_index] += 1.0
  0x4c09a8		498d0c11		LEAQ 0(R9)(DX*1), CX				
  0x4c09ac		488d8900320000		LEAQ 0x3200(CX), CX				
  0x4c09b3		735f			JAE 0x4c0a14					
  0x4c09b5		f20f1004c1		MOVSD_XMM 0(CX)(AX*8), X0			
  0x4c09ba		f2440f101dedcf0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
  0x4c09c3		f2410f58c3		ADDSD X11, X0					
  0x4c09c8		f20f1104c1		MOVSD_XMM X0, 0(CX)(AX*8)			
  0x4c09cd		eb09			JMP 0x4c09d8					
  0x4c09cf		f2440f101dd8cf0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
						diag.accuCenter += energy
  0x4c09d8		f2410f10841180700000	MOVSD_XMM 0x7080(R9)(DX*1), X0	
  0x4c09e2		f2410f58c0		ADDSD X8, X0			
  0x4c09e7		f2410f11841180700000	MOVSD_XMM X0, 0x7080(R9)(DX*1)	
						diag.counterCenter++
  0x4c09f1		49ff841188700000	INCQ 0x7088(R9)(DX*1)			
  0x4c09f9		e911fdffff		JMP 0x4c070f				
  0x4c09fe		f20f103d52cf0000	MOVSD_XMM $f64.3f8c28f5c28f5c2a(SB), X7	
					if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
  0x4c0a06		f2440f101da1cf0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
  0x4c0a0f		e9fbfcffff		JMP 0x4c070f					
							diag.eepf[energy_index] += 1.0
  0x4c0a14		b9d0070000		MOVL $0x7d0, CX			
  0x4c0a19		e8e21afcff		CALL runtime.panicBounds(SB)	
					rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x4c0a1e		b840420f00		MOVL $0xf4240, AX		
  0x4c0a23		e8d81afcff		CALL runtime.panicBounds(SB)	
					c0 = sim.X_e[k] * INV_DX
  0x4c0a28		b840420f00		MOVL $0xf4240, AX		
  0x4c0a2d		e8ce1afcff		CALL runtime.panicBounds(SB)	
				diag := &sim.WorkerEDiag[workerID]
  0x4c0a32		e8c91afcff		CALL runtime.panicBounds(SB)	
  0x4c0a37		90			NOPL				
