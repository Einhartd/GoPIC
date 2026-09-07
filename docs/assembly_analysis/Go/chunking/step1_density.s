TEXT gopic.(*SimulationState).Step1ComputeElectronDensity(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
func (sim *SimulationState) Step1ComputeElectronDensity() {
  0x4bc020		493b6610		CMPQ SP, 0x10(R14)	
  0x4bc024		0f8624020000		JBE 0x4bc24e		
  0x4bc02a		55			PUSHQ BP		
  0x4bc02b		4889e5			MOVQ SP, BP		
  0x4bc02e		4883ec58		SUBQ $0x58, SP		
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bc032		4889442468		MOVQ AX, 0x68(SP)	
	numWorkers := sim.NumWorkers
  0x4bc037		8400			TESTB AL, 0(AX)		
  0x4bc039		488b90e82dba07		MOVQ 0x7ba2de8(AX), DX	
  0x4bc040		4889542428		MOVQ DX, 0x28(SP)	
	var wg sync.WaitGroup
  0x4bc045		b810000000		MOVL $0x10, AX				
  0x4bc04a		488d1d77920f00		LEAQ 0xf9277(IP), BX			
  0x4bc051		b901000000		MOVL $0x1, CX				
  0x4bc056		e8c521f6ff		CALL runtime.mallocgcSmallNoScanSC2(SB)	
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bc05b		488b542468		MOVQ 0x68(SP), DX	
  0x4bc060		488bb2c07e5603		MOVQ 0x3567ec0(DX), SI	
  0x4bc067		488b7c2428		MOVQ 0x28(SP), DI	
  0x4bc06c		488d343e		LEAQ 0(SI)(DI*1), SI	
  0x4bc070		488d76ff		LEAQ -0x1(SI), SI	
  0x4bc074		4885ff			TESTQ DI, DI		
  0x4bc077		0f84cb010000		JE 0x4bc248		
	var wg sync.WaitGroup
  0x4bc07d		4889442450		MOVQ AX, 0x50(SP)	
  0x4bc082		4889c1			MOVQ AX, CX		
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bc085		4889f0			MOVQ SI, AX		
  0x4bc088		4889d3			MOVQ DX, BX		
  0x4bc08b		4883ffff		CMPQ DI, $-0x1		
  0x4bc08f		7507			JNE 0x4bc098		
  0x4bc091		48f7d8			NEGQ AX			
  0x4bc094		31d2			XORL DX, DX		
  0x4bc096		eb05			JMP 0x4bc09d		
  0x4bc098		4899			CQO			
  0x4bc09a		48f7ff			IDIVQ DI		
  0x4bc09d		4889442438		MOVQ AX, 0x38(SP)	
	for w := 0; w < numWorkers; w++ {
  0x4bc0a2		31d2			XORL DX, DX		
  0x4bc0a4		eb06			JMP 0x4bc0ac		
		start := w * chunkSize
  0x4bc0a6		4c89c8			MOVQ R9, AX		
	for w := 0; w < numWorkers; w++ {
  0x4bc0a9		4c89c2			MOVQ R8, DX		
  0x4bc0ac		4839fa			CMPQ DX, DI		
  0x4bc0af		0f8dc2000000		JGE 0x4bc177		
		start := w * chunkSize
  0x4bc0b5		4889d6			MOVQ DX, SI		
  0x4bc0b8		480fafd0		IMULQ AX, DX		
		end := (w + 1) * chunkSize
  0x4bc0bc		4c8d4601		LEAQ 0x1(SI), R8	
  0x4bc0c0		4989c1			MOVQ AX, R9		
  0x4bc0c3		490fafc0		IMULQ R8, AX		
		if end > sim.N_e {
  0x4bc0c7		4c8b93c07e5603		MOVQ 0x3567ec0(BX), R10	
  0x4bc0ce		4939c2			CMPQ R10, AX		
		if start >= end {
  0x4bc0d1		490f4cc2		CMOVL R10, AX		
  0x4bc0d5		4839d0			CMPQ AX, DX		
		if end > sim.N_e {
  0x4bc0d8		7ecc			JLE 0x4bc0a6		
	for w := 0; w < numWorkers; w++ {
  0x4bc0da		4889742448		MOVQ SI, 0x48(SP)	
		start := w * chunkSize
  0x4bc0df		4889542420		MOVQ DX, 0x20(SP)	
		end := (w + 1) * chunkSize
  0x4bc0e4		4c89442440		MOVQ R8, 0x40(SP)	
		if start >= end {
  0x4bc0e9		4889442430		MOVQ AX, 0x30(SP)	
		wg.Go(func() {
  0x4bc0ee		b828000000		MOVL $0x28, AX								
  0x4bc0f3		488d1db6b50f00		LEAQ 0xfb5b6(IP), BX							
  0x4bc0fa		b901000000		MOVL $0x1, CX								
  0x4bc0ff		90			NOPL									
  0x4bc100		e8bb12f6ff		CALL runtime.mallocgcSmallScanNoHeaderSC5(SB)				
  0x4bc105		488d15b42f0000		LEAQ gopic.(*SimulationState).Step1ComputeElectronDensity.func1(SB), DX	
  0x4bc10c		488910			MOVQ DX, 0(AX)								
  0x4bc10f		833d5a0d130000		CMPL runtime.writeBarrier(SB), $0x0					
  0x4bc116		7508			JNE 0x4bc120								
  0x4bc118		488b4c2468		MOVQ 0x68(SP), CX							
  0x4bc11d		eb0e			JMP 0x4bc12d								
  0x4bc11f		90			NOPL									
  0x4bc120		e8bb55fcff		CALL runtime.gcWriteBarrier1(SB)					
  0x4bc125		488b4c2468		MOVQ 0x68(SP), CX							
  0x4bc12a		49890b			MOVQ CX, 0(R11)								
  0x4bc12d		48894808		MOVQ CX, 0x8(AX)							
  0x4bc131		488b4c2448		MOVQ 0x48(SP), CX							
  0x4bc136		48894810		MOVQ CX, 0x10(AX)							
  0x4bc13a		488b4c2420		MOVQ 0x20(SP), CX							
  0x4bc13f		48894818		MOVQ CX, 0x18(AX)							
  0x4bc143		488b4c2430		MOVQ 0x30(SP), CX							
  0x4bc148		48894820		MOVQ CX, 0x20(AX)							
  0x4bc14c		4889c3			MOVQ AX, BX								
  0x4bc14f		488b442450		MOVQ 0x50(SP), AX							
  0x4bc154		e867d8fcff		CALL sync.(*WaitGroup).Go(SB)						
	wg.Wait()
  0x4bc159		488b4c2450		MOVQ 0x50(SP), CX	
		if end > sim.N_e {
  0x4bc15e		488b5c2468		MOVQ 0x68(SP), BX	
	for w := 0; w < numWorkers; w++ {
  0x4bc163		488b7c2428		MOVQ 0x28(SP), DI	
  0x4bc168		4c8b442440		MOVQ 0x40(SP), R8	
		start := w * chunkSize
  0x4bc16d		4c8b4c2438		MOVQ 0x38(SP), R9	
		wg.Go(func() {
  0x4bc172		e92fffffff		JMP 0x4bc0a6		
	wg.Wait()
  0x4bc177		4889c8			MOVQ CX, AX			
  0x4bc17a		e821d7fcff		CALL sync.(*WaitGroup).Wait(SB)	
	for p := range N_G {
  0x4bc17f		488b7c2468		MOVQ 0x68(SP), DI	
  0x4bc184		488d8fd0272707		LEAQ 0x72727d0(DI), CX	
  0x4bc18b		31c0			XORL AX, AX		
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bc18d		4889fa			MOVQ DI, DX		
	for p := range N_G {
  0x4bc190		4889cf			MOVQ CX, DI		
  0x4bc193		b990010000		MOVL $0x190, CX		
  0x4bc198		f348ab			REP; STOSQ AX, ES:0(DI)	
	for w := range numWorkers {
  0x4bc19b		31c9			XORL CX, CX		
  0x4bc19d		488b5c2428		MOVQ 0x28(SP), BX	
  0x4bc1a2		eb03			JMP 0x4bc1a7		
  0x4bc1a4		48ffc1			INCQ CX			
  0x4bc1a7		4839d9			CMPQ CX, BX		
  0x4bc1aa		7d3f			JGE 0x4bc1eb		
			sim.E_density[p] += sim.WorkerEDensity[w][p]
  0x4bc1ac		4869c1800c0000		IMULQ $0xc80, CX, AX	
		for p := range N_G {
  0x4bc1b3		31f6			XORL SI, SI		
  0x4bc1b5		eb17			JMP 0x4bc1ce		
			sim.E_density[p] += sim.WorkerEDensity[w][p]
  0x4bc1b7		488b3a			MOVQ 0(DX), DI				
  0x4bc1ba		4801c7			ADDQ AX, DI				
  0x4bc1bd		f20f5804f7		ADDSD 0(DI)(SI*8), X0			
  0x4bc1c2		f20f1184f2d0272707	MOVSD_XMM X0, 0x72727d0(DX)(SI*8)	
		for p := range N_G {
  0x4bc1cb		48ffc6			INCQ SI			
  0x4bc1ce		4881fe90010000		CMPQ SI, $0x190		
  0x4bc1d5		7dcd			JGE 0x4bc1a4		
			sim.E_density[p] += sim.WorkerEDensity[w][p]
  0x4bc1d7		488b7a08		MOVQ 0x8(DX), DI			
  0x4bc1db		f20f1084f2d0272707	MOVSD_XMM 0x72727d0(DX)(SI*8), X0	
  0x4bc1e4		4839f9			CMPQ CX, DI				
  0x4bc1e7		72ce			JB 0x4bc1b7				
  0x4bc1e9		eb58			JMP 0x4bc243				
	sim.E_density[0] *= 2.0
  0x4bc1eb		f20f1082d0272707	MOVSD_XMM 0x72727d0(DX), X0	
  0x4bc1f3		f20f58c0		ADDSD X0, X0			
  0x4bc1f7		f20f1182d0272707	MOVSD_XMM X0, 0x72727d0(DX)	
	sim.E_density[N_G-1] *= 2.0
  0x4bc1ff		f20f108248342707	MOVSD_XMM 0x7273448(DX), X0	
  0x4bc207		f20f58c0		ADDSD X0, X0			
  0x4bc20b		f20f118248342707	MOVSD_XMM X0, 0x7273448(DX)	
	for p := range N_G {
  0x4bc213		31c0			XORL AX, AX		
  0x4bc215		eb1e			JMP 0x4bc235		
		sim.Cumul_e_density[p] += sim.E_density[p]
  0x4bc217		f20f1084c2d0272707	MOVSD_XMM 0x72727d0(DX)(AX*8), X0	
  0x4bc220		f20f5884c2d0402707	ADDSD 0x72740d0(DX)(AX*8), X0		
  0x4bc229		f20f1184c2d0402707	MOVSD_XMM X0, 0x72740d0(DX)(AX*8)	
	for p := range N_G {
  0x4bc232		48ffc0			INCQ AX			
  0x4bc235		483d90010000		CMPQ AX, $0x190		
  0x4bc23b		7cda			JL 0x4bc217		
}
  0x4bc23d		4883c458		ADDQ $0x58, SP		
  0x4bc241		5d			POPQ BP			
  0x4bc242		c3			RET			
			sim.E_density[p] += sim.WorkerEDensity[w][p]
  0x4bc243		e85858fcff		CALL runtime.panicBounds(SB)	
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x4bc248		e8d385f8ff		CALL runtime.panicdivide(SB)	
  0x4bc24d		90			NOPL				
func (sim *SimulationState) Step1ComputeElectronDensity() {
  0x4bc24e		4889442408		MOVQ AX, 0x8(SP)						
  0x4bc253		e8083cfcff		CALL runtime.morestack_noctxt.abi0(SB)				
  0x4bc258		488b442408		MOVQ 0x8(SP), AX						
  0x4bc25d		0f1f00			NOPL 0(AX)							
  0x4bc260		e9bbfdffff		JMP gopic.(*SimulationState).Step1ComputeElectronDensity(SB)	

TEXT gopic.(*SimulationState).Step1ComputeIonDensity(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
func (sim *SimulationState) Step1ComputeIonDensity(t int) {
  0x4bc280		493b6610		CMPQ SP, 0x10(R14)	
  0x4bc284		0f8666020000		JBE 0x4bc4f0		
  0x4bc28a		55			PUSHQ BP		
  0x4bc28b		4889e5			MOVQ SP, BP		
  0x4bc28e		4883ec58		SUBQ $0x58, SP		
	if (t % N_SUB) == 0 { // G─Östo┼Ť─ç jon├│w przeliczana w subcyclingu co N_SUB krok├│w
  0x4bc292		48bacdcccccccccccccc	MOVQ $0xcccccccccccccccd, DX	
  0x4bc29c		480fafd3		IMULQ BX, DX			
  0x4bc2a0		48be9899999999999919	MOVQ $0x1999999999999998, SI	
  0x4bc2aa		4801f2			ADDQ SI, DX			
  0x4bc2ad		48c1c23e		ROLQ $0x3e, DX			
  0x4bc2b1		48becccccccccccccc0c	MOVQ $0xccccccccccccccc, SI	
  0x4bc2bb		0f1f440000		NOPL 0(AX)(AX*1)		
  0x4bc2c0		4839d6			CMPQ SI, DX			
  0x4bc2c3		0f82e9010000		JB 0x4bc4b2			
  0x4bc2c9		4889442468		MOVQ AX, 0x68(SP)		
		numWorkers := sim.NumWorkers
  0x4bc2ce		8400			TESTB AL, 0(AX)		
  0x4bc2d0		488b90e82dba07		MOVQ 0x7ba2de8(AX), DX	
  0x4bc2d7		4889542428		MOVQ DX, 0x28(SP)	
		var wg sync.WaitGroup
  0x4bc2dc		b810000000		MOVL $0x10, AX				
  0x4bc2e1		488d1de08f0f00		LEAQ 0xf8fe0(IP), BX			
  0x4bc2e8		b901000000		MOVL $0x1, CX				
  0x4bc2ed		e82e1ff6ff		CALL runtime.mallocgcSmallNoScanSC2(SB)	
		chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4bc2f2		488b542468		MOVQ 0x68(SP), DX	
  0x4bc2f7		488bb2c87e5603		MOVQ 0x3567ec8(DX), SI	
  0x4bc2fe		488b7c2428		MOVQ 0x28(SP), DI	
  0x4bc303		488d343e		LEAQ 0(SI)(DI*1), SI	
  0x4bc307		488d76ff		LEAQ -0x1(SI), SI	
  0x4bc30b		4885ff			TESTQ DI, DI		
  0x4bc30e		0f84d6010000		JE 0x4bc4ea		
		var wg sync.WaitGroup
  0x4bc314		4889442450		MOVQ AX, 0x50(SP)	
  0x4bc319		4889c1			MOVQ AX, CX		
		chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4bc31c		4889f0			MOVQ SI, AX		
	if (t % N_SUB) == 0 { // G─Östo┼Ť─ç jon├│w przeliczana w subcyclingu co N_SUB krok├│w
  0x4bc31f		4889d3			MOVQ DX, BX		
		chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4bc322		4883ffff		CMPQ DI, $-0x1		
  0x4bc326		7507			JNE 0x4bc32f		
  0x4bc328		48f7d8			NEGQ AX			
  0x4bc32b		31d2			XORL DX, DX		
  0x4bc32d		eb05			JMP 0x4bc334		
  0x4bc32f		4899			CQO			
  0x4bc331		48f7ff			IDIVQ DI		
  0x4bc334		4889442438		MOVQ AX, 0x38(SP)	
		for w := range numWorkers {
  0x4bc339		31d2			XORL DX, DX		
  0x4bc33b		eb06			JMP 0x4bc343		
			start := w * chunkSize
  0x4bc33d		4c89c8			MOVQ R9, AX		
		for w := range numWorkers {
  0x4bc340		4c89c2			MOVQ R8, DX		
  0x4bc343		4839fa			CMPQ DX, DI		
  0x4bc346		0f8dc0000000		JGE 0x4bc40c		
			start := w * chunkSize
  0x4bc34c		4889d6			MOVQ DX, SI		
  0x4bc34f		480fafd0		IMULQ AX, DX		
			end := min((w+1)*chunkSize, sim.N_i)
  0x4bc353		4c8d4601		LEAQ 0x1(SI), R8	
  0x4bc357		4989c1			MOVQ AX, R9		
  0x4bc35a		490fafc0		IMULQ R8, AX		
  0x4bc35e		4c8b93c87e5603		MOVQ 0x3567ec8(BX), R10	
  0x4bc365		4939c2			CMPQ R10, AX		
			if start >= end {
  0x4bc368		490f4cc2		CMOVL R10, AX		
  0x4bc36c		4839d0			CMPQ AX, DX		
			end := min((w+1)*chunkSize, sim.N_i)
  0x4bc36f		7ecc			JLE 0x4bc33d		
		for w := range numWorkers {
  0x4bc371		4889742448		MOVQ SI, 0x48(SP)	
			start := w * chunkSize
  0x4bc376		4889542420		MOVQ DX, 0x20(SP)	
			end := min((w+1)*chunkSize, sim.N_i)
  0x4bc37b		4c89442440		MOVQ R8, 0x40(SP)	
			if start >= end {
  0x4bc380		4889442430		MOVQ AX, 0x30(SP)	
			wg.Go(func() {
  0x4bc385		b828000000		MOVL $0x28, AX								
  0x4bc38a		488d1d1fb30f00		LEAQ 0xfb31f(IP), BX							
  0x4bc391		b901000000		MOVL $0x1, CX								
  0x4bc396		e82510f6ff		CALL runtime.mallocgcSmallScanNoHeaderSC5(SB)				
  0x4bc39b		488d151e2e0000		LEAQ gopic.(*SimulationState).Step1ComputeIonDensity.func1(SB), DX	
  0x4bc3a2		488910			MOVQ DX, 0(AX)								
  0x4bc3a5		833dc40a130000		CMPL runtime.writeBarrier(SB), $0x0					
  0x4bc3ac		7507			JNE 0x4bc3b5								
  0x4bc3ae		488b4c2468		MOVQ 0x68(SP), CX							
  0x4bc3b3		eb0d			JMP 0x4bc3c2								
  0x4bc3b5		e82653fcff		CALL runtime.gcWriteBarrier1(SB)					
  0x4bc3ba		488b4c2468		MOVQ 0x68(SP), CX							
  0x4bc3bf		49890b			MOVQ CX, 0(R11)								
  0x4bc3c2		48894808		MOVQ CX, 0x8(AX)							
  0x4bc3c6		488b4c2448		MOVQ 0x48(SP), CX							
  0x4bc3cb		48894810		MOVQ CX, 0x10(AX)							
  0x4bc3cf		488b4c2420		MOVQ 0x20(SP), CX							
  0x4bc3d4		48894818		MOVQ CX, 0x18(AX)							
  0x4bc3d8		488b4c2430		MOVQ 0x30(SP), CX							
  0x4bc3dd		48894820		MOVQ CX, 0x20(AX)							
  0x4bc3e1		4889c3			MOVQ AX, BX								
  0x4bc3e4		488b442450		MOVQ 0x50(SP), AX							
  0x4bc3e9		e8d2d5fcff		CALL sync.(*WaitGroup).Go(SB)						
		wg.Wait()
  0x4bc3ee		488b4c2450		MOVQ 0x50(SP), CX	
			end := min((w+1)*chunkSize, sim.N_i)
  0x4bc3f3		488b5c2468		MOVQ 0x68(SP), BX	
		for w := range numWorkers {
  0x4bc3f8		488b7c2428		MOVQ 0x28(SP), DI	
  0x4bc3fd		4c8b442440		MOVQ 0x40(SP), R8	
			start := w * chunkSize
  0x4bc402		4c8b4c2438		MOVQ 0x38(SP), R9	
			wg.Go(func() {
  0x4bc407		e931ffffff		JMP 0x4bc33d		
		wg.Wait()
  0x4bc40c		4889c8			MOVQ CX, AX			
  0x4bc40f		e88cd4fcff		CALL sync.(*WaitGroup).Wait(SB)	
		for p := range N_G {
  0x4bc414		488b7c2468		MOVQ 0x68(SP), DI	
  0x4bc419		488d8f50342707		LEAQ 0x7273450(DI), CX	
  0x4bc420		31c0			XORL AX, AX		
	if (t % N_SUB) == 0 { // G─Östo┼Ť─ç jon├│w przeliczana w subcyclingu co N_SUB krok├│w
  0x4bc422		4889fa			MOVQ DI, DX		
		for p := range N_G {
  0x4bc425		4889cf			MOVQ CX, DI		
  0x4bc428		b990010000		MOVL $0x190, CX		
  0x4bc42d		f348ab			REP; STOSQ AX, ES:0(DI)	
		for w := range numWorkers {
  0x4bc430		31c9			XORL CX, CX		
  0x4bc432		488b5c2428		MOVQ 0x28(SP), BX	
  0x4bc437		eb07			JMP 0x4bc440		
  0x4bc439		48ffc1			INCQ CX			
  0x4bc43c		0f1f4000		NOPL 0(AX)		
  0x4bc440		4839d9			CMPQ CX, BX		
  0x4bc443		7d42			JGE 0x4bc487		
				sim.I_density[p] += sim.WorkerIDensity[w][p]
  0x4bc445		4869c1800c0000		IMULQ $0xc80, CX, AX	
			for p := range N_G {
  0x4bc44c		31f6			XORL SI, SI		
  0x4bc44e		eb18			JMP 0x4bc468		
				sim.I_density[p] += sim.WorkerIDensity[w][p]
  0x4bc450		488b7a18		MOVQ 0x18(DX), DI			
  0x4bc454		4801c7			ADDQ AX, DI				
  0x4bc457		f20f5804f7		ADDSD 0(DI)(SI*8), X0			
  0x4bc45c		f20f1184f250342707	MOVSD_XMM X0, 0x7273450(DX)(SI*8)	
			for p := range N_G {
  0x4bc465		48ffc6			INCQ SI			
  0x4bc468		4881fe90010000		CMPQ SI, $0x190		
  0x4bc46f		7dc8			JGE 0x4bc439		
				sim.I_density[p] += sim.WorkerIDensity[w][p]
  0x4bc471		488b7a20		MOVQ 0x20(DX), DI			
  0x4bc475		f20f1084f250342707	MOVSD_XMM 0x7273450(DX)(SI*8), X0	
  0x4bc47e		6690			NOPW					
  0x4bc480		4839f9			CMPQ CX, DI				
  0x4bc483		72cb			JB 0x4bc450				
  0x4bc485		eb5e			JMP 0x4bc4e5				
		sim.I_density[0] *= 2.0
  0x4bc487		f20f108250342707	MOVSD_XMM 0x7273450(DX), X0	
  0x4bc48f		f20f58c0		ADDSD X0, X0			
  0x4bc493		f20f118250342707	MOVSD_XMM X0, 0x7273450(DX)	
		sim.I_density[N_G-1] *= 2.0
  0x4bc49b		f20f1082c8402707	MOVSD_XMM 0x72740c8(DX), X0	
  0x4bc4a3		f20f58c0		ADDSD X0, X0			
  0x4bc4a7		f20f1182c8402707	MOVSD_XMM X0, 0x72740c8(DX)	
		sim.Cumul_i_density[p] += sim.I_density[p]
  0x4bc4af		4889d0			MOVQ DX, AX		
	for p := range N_G {
  0x4bc4b2		31c9			XORL CX, CX		
  0x4bc4b4		eb20			JMP 0x4bc4d6		
		sim.Cumul_i_density[p] += sim.I_density[p]
  0x4bc4b6		8400			TESTB AL, 0(AX)				
  0x4bc4b8		f20f1084c850342707	MOVSD_XMM 0x7273450(AX)(CX*8), X0	
  0x4bc4c1		f20f5884c8504d2707	ADDSD 0x7274d50(AX)(CX*8), X0		
  0x4bc4ca		f20f1184c8504d2707	MOVSD_XMM X0, 0x7274d50(AX)(CX*8)	
	for p := range N_G {
  0x4bc4d3		48ffc1			INCQ CX			
  0x4bc4d6		4881f990010000		CMPQ CX, $0x190		
  0x4bc4dd		7cd7			JL 0x4bc4b6		
}
  0x4bc4df		4883c458		ADDQ $0x58, SP		
  0x4bc4e3		5d			POPQ BP			
  0x4bc4e4		c3			RET			
				sim.I_density[p] += sim.WorkerIDensity[w][p]
  0x4bc4e5		e8b655fcff		CALL runtime.panicBounds(SB)	
		chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4bc4ea		e83183f8ff		CALL runtime.panicdivide(SB)	
  0x4bc4ef		90			NOPL				
func (sim *SimulationState) Step1ComputeIonDensity(t int) {
  0x4bc4f0		4889442408		MOVQ AX, 0x8(SP)					
  0x4bc4f5		48895c2410		MOVQ BX, 0x10(SP)					
  0x4bc4fa		e86139fcff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x4bc4ff		488b442408		MOVQ 0x8(SP), AX					
  0x4bc504		488b5c2410		MOVQ 0x10(SP), BX					
  0x4bc509		e972fdffff		JMP gopic.(*SimulationState).Step1ComputeIonDensity(SB)	

TEXT gopic.(*SimulationState).Step1ComputeElectronDensity.func1(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
		wg.Go(func() {
  0x4bf0c0		55			PUSHQ BP		
  0x4bf0c1		4889e5			MOVQ SP, BP		
  0x4bf0c4		488b5a10		MOVQ 0x10(DX), BX	
  0x4bf0c8		488b7208		MOVQ 0x8(DX), SI	
			density := &sim.WorkerEDensity[workerID]
  0x4bf0cc		4c8b4608		MOVQ 0x8(SI), R8	
  0x4bf0d0		4939d8			CMPQ R8, BX		
  0x4bf0d3		0f86cc000000		JBE 0x4bf1a5		
  0x4bf0d9		4c8b06			MOVQ 0(SI), R8		
  0x4bf0dc		4869db800c0000		IMULQ $0xc80, BX, BX	
			for p := range N_G {
  0x4bf0e3		498d3c18		LEAQ 0(R8)(BX*1), DI	
		wg.Go(func() {
  0x4bf0e7		4c8b4a18		MOVQ 0x18(DX), R9	
  0x4bf0eb		488b5220		MOVQ 0x20(DX), DX	
			for p := range N_G {
  0x4bf0ef		b990010000		MOVL $0x190, CX		
  0x4bf0f4		31c0			XORL AX, AX		
  0x4bf0f6		f348ab			REP; STOSQ AX, ES:0(DI)	
			density := &sim.WorkerEDensity[workerID]
  0x4bf0f9		4c01c3			ADDQ R8, BX		
			for k := s; k < e; k++ {
  0x4bf0fc		eb4a			JMP 0x4bf148		
				c2 := (c0 - float64(p)) * FACTOR_W
  0x4bf0fe		0f57d2			XORPS X2, X2				
  0x4bf101		f2480f2ad0		CVTSI2SDQ AX, X2			
  0x4bf106		f20f5cc2		SUBSD X2, X0				
  0x4bf10a		f20f101566e90000	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X2	
  0x4bf112		f20f59d0		MULSD X0, X2				
				c1 := FACTOR_W - c2
  0x4bf116		f20f101d5ae90000	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X3	
  0x4bf11e		f20f5cda		SUBSD X2, X3				
				density[p] += c1
  0x4bf122		f20f581cc3		ADDSD 0(BX)(AX*8), X3		
  0x4bf127		f20f111cc3		MOVSD_XMM X3, 0(BX)(AX*8)	
				density[p+1] += c2
  0x4bf12c		f20f1054c308		MOVSD_XMM 0x8(BX)(AX*8), X2		
  0x4bf132		f20f101d3ee90000	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X3	
  0x4bf13a		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
  0x4bf13f		f20f1154c308		MOVSD_XMM X2, 0x8(BX)(AX*8)		
			for k := s; k < e; k++ {
  0x4bf145		49ffc1			INCQ R9			
  0x4bf148		4939d1			CMPQ R9, DX		
  0x4bf14b		7d49			JGE 0x4bf196		
				c0 := sim.X_e[k] * INV_DX
  0x4bf14d		4981f940420f00		CMPQ R9, $0xf4240			
  0x4bf154		7342			JAE 0x4bf198				
  0x4bf156		f2420f1084ced07e5603	MOVSD_XMM 0x3567ed0(SI)(R9*8), X0	
  0x4bf160		f20f100df0e80000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4bf168		f20f59c1		MULSD X1, X0				
				p := min(max(int(c0), 0), N_G-2)
  0x4bf16c		f2480f2cc0		CVTTSD2SIQ X0, AX	
  0x4bf171		4885c0			TESTQ AX, AX		
  0x4bf174		7d0a			JGE 0x4bf180		
  0x4bf176		31c0			XORL AX, AX		
  0x4bf178		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x4bf180		483d8e010000		CMPQ AX, $0x18e		
  0x4bf186		0f8e72ffffff		JLE 0x4bf0fe		
  0x4bf18c		b88e010000		MOVL $0x18e, AX		
  0x4bf191		e968ffffff		JMP 0x4bf0fe		
		})
  0x4bf196		5d			POPQ BP			
  0x4bf197		c3			RET			
				c0 := sim.X_e[k] * INV_DX
  0x4bf198		b840420f00		MOVL $0xf4240, AX		
  0x4bf19d		0f1f00			NOPL 0(AX)			
  0x4bf1a0		e8fb28fcff		CALL runtime.panicBounds(SB)	
			density := &sim.WorkerEDensity[workerID]
  0x4bf1a5		e8f628fcff		CALL runtime.panicBounds(SB)	
  0x4bf1aa		90			NOPL				

TEXT gopic.(*SimulationState).Step1ComputeIonDensity.func1(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
			wg.Go(func() {
  0x4bf1c0		55			PUSHQ BP		
  0x4bf1c1		4889e5			MOVQ SP, BP		
  0x4bf1c4		488b5a10		MOVQ 0x10(DX), BX	
  0x4bf1c8		488b7208		MOVQ 0x8(DX), SI	
				density := &sim.WorkerIDensity[workerID]
  0x4bf1cc		4c8b4620		MOVQ 0x20(SI), R8	
  0x4bf1d0		4939d8			CMPQ R8, BX		
  0x4bf1d3		0f86cc000000		JBE 0x4bf2a5		
  0x4bf1d9		4c8b4618		MOVQ 0x18(SI), R8	
  0x4bf1dd		4869db800c0000		IMULQ $0xc80, BX, BX	
				for p := range N_G {
  0x4bf1e4		498d3c18		LEAQ 0(R8)(BX*1), DI	
			wg.Go(func() {
  0x4bf1e8		4c8b4a18		MOVQ 0x18(DX), R9	
  0x4bf1ec		488b5220		MOVQ 0x20(DX), DX	
				for p := range N_G {
  0x4bf1f0		b990010000		MOVL $0x190, CX		
  0x4bf1f5		31c0			XORL AX, AX		
  0x4bf1f7		f348ab			REP; STOSQ AX, ES:0(DI)	
				density := &sim.WorkerIDensity[workerID]
  0x4bf1fa		4c01c3			ADDQ R8, BX		
				for k := s; k < e; k++ {
  0x4bf1fd		eb4a			JMP 0x4bf249		
					c2 := (c0 - float64(p)) * FACTOR_W
  0x4bf1ff		0f57d2			XORPS X2, X2				
  0x4bf202		f2480f2ad0		CVTSI2SDQ AX, X2			
  0x4bf207		f20f5cc2		SUBSD X2, X0				
  0x4bf20b		f20f101565e80000	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X2	
  0x4bf213		f20f59d0		MULSD X0, X2				
					c1 := FACTOR_W - c2
  0x4bf217		f20f101d59e80000	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X3	
  0x4bf21f		f20f5cda		SUBSD X2, X3				
					density[p] += c1
  0x4bf223		f20f581cc3		ADDSD 0(BX)(AX*8), X3		
  0x4bf228		f20f111cc3		MOVSD_XMM X3, 0(BX)(AX*8)	
					density[p+1] += c2
  0x4bf22d		f20f1054c308		MOVSD_XMM 0x8(BX)(AX*8), X2		
  0x4bf233		f20f101d3de80000	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X3	
  0x4bf23b		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
  0x4bf240		f20f1154c308		MOVSD_XMM X2, 0x8(BX)(AX*8)		
				for k := s; k < e; k++ {
  0x4bf246		49ffc1			INCQ R9			
  0x4bf249		4939d1			CMPQ R9, DX		
  0x4bf24c		7d48			JGE 0x4bf296		
					c0 := sim.X_i[k] * INV_DX
  0x4bf24e		4981f940420f00		CMPQ R9, $0xf4240			
  0x4bf255		7341			JAE 0x4bf298				
  0x4bf257		f2420f1084ced0c63e05	MOVSD_XMM 0x53ec6d0(SI)(R9*8), X0	
  0x4bf261		f20f100defe70000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4bf269		f20f59c1		MULSD X1, X0				
					p := min(max(int(c0), 0), N_G-2)
  0x4bf26d		f2480f2cc0		CVTTSD2SIQ X0, AX	
  0x4bf272		4885c0			TESTQ AX, AX		
  0x4bf275		7d09			JGE 0x4bf280		
  0x4bf277		31c0			XORL AX, AX		
  0x4bf279		0f1f8000000000		NOPL 0(AX)		
  0x4bf280		483d8e010000		CMPQ AX, $0x18e		
  0x4bf286		0f8e73ffffff		JLE 0x4bf1ff		
  0x4bf28c		b88e010000		MOVL $0x18e, AX		
  0x4bf291		e969ffffff		JMP 0x4bf1ff		
			})
  0x4bf296		5d			POPQ BP			
  0x4bf297		c3			RET			
					c0 := sim.X_i[k] * INV_DX
  0x4bf298		b840420f00		MOVL $0xf4240, AX		
  0x4bf29d		0f1f00			NOPL 0(AX)			
  0x4bf2a0		e8fb27fcff		CALL runtime.panicBounds(SB)	
				density := &sim.WorkerIDensity[workerID]
  0x4bf2a5		e8f627fcff		CALL runtime.panicBounds(SB)	
  0x4bf2aa		90			NOPL				
