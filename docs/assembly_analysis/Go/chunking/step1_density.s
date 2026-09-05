TEXT gopic.(*SimulationState).Step1ComputeElectronDensity(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
func (sim *SimulationState) Step1ComputeElectronDensity() {
  0x516c1		493b6610		CMPQ SP, 0x10(R14)	
  0x516c5		0f8624020000		JBE 0x518ef		
  0x516cb		55			PUSHQ BP		
  0x516cc		4889e5			MOVQ SP, BP		
  0x516cf		4883ec58		SUBQ $0x58, SP		
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x516d3		4889442468		MOVQ AX, 0x68(SP)	
	numWorkers := sim.NumWorkers
  0x516d8		8400			TESTB AL, 0(AX)		
  0x516da		488b90e82dba07		MOVQ 0x7ba2de8(AX), DX	
  0x516e1		4889542428		MOVQ DX, 0x28(SP)	
	var wg sync.WaitGroup
  0x516e6		b810000000		MOVL $0x10, AX		
  0x516eb		488d1d00000000		LEAQ 0(IP), BX		[3:7]R_PCREL:type:sync.WaitGroup	
  0x516f2		b901000000		MOVL $0x1, CX		
  0x516f7		e800000000		CALL 0x516fc		[1:5]R_CALL:runtime.mallocgcSmallNoScanSC2	
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x516fc		488b542468		MOVQ 0x68(SP), DX	
  0x51701		488bb2c07e5603		MOVQ 0x3567ec0(DX), SI	
  0x51708		488b7c2428		MOVQ 0x28(SP), DI	
  0x5170d		488d343e		LEAQ 0(SI)(DI*1), SI	
  0x51711		488d76ff		LEAQ -0x1(SI), SI	
  0x51715		4885ff			TESTQ DI, DI		
  0x51718		0f84cb010000		JE 0x518e9		
	var wg sync.WaitGroup
  0x5171e		4889442450		MOVQ AX, 0x50(SP)	
  0x51723		4889c1			MOVQ AX, CX		
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x51726		4889f0			MOVQ SI, AX		
  0x51729		4889d3			MOVQ DX, BX		
  0x5172c		4883ffff		CMPQ DI, $-0x1		
  0x51730		7507			JNE 0x51739		
  0x51732		48f7d8			NEGQ AX			
  0x51735		31d2			XORL DX, DX		
  0x51737		eb05			JMP 0x5173e		
  0x51739		4899			CQO			
  0x5173b		48f7ff			IDIVQ DI		
  0x5173e		4889442438		MOVQ AX, 0x38(SP)	
	for w := 0; w < numWorkers; w++ {
  0x51743		31d2			XORL DX, DX		
  0x51745		eb06			JMP 0x5174d		
		start := w * chunkSize
  0x51747		4c89c8			MOVQ R9, AX		
	for w := 0; w < numWorkers; w++ {
  0x5174a		4c89c2			MOVQ R8, DX		
  0x5174d		4839fa			CMPQ DX, DI		
  0x51750		0f8dc2000000		JGE 0x51818		
		start := w * chunkSize
  0x51756		4889d6			MOVQ DX, SI		
  0x51759		480fafd0		IMULQ AX, DX		
		end := (w + 1) * chunkSize
  0x5175d		4c8d4601		LEAQ 0x1(SI), R8	
  0x51761		4989c1			MOVQ AX, R9		
  0x51764		490fafc0		IMULQ R8, AX		
		if end > sim.N_e {
  0x51768		4c8b93c07e5603		MOVQ 0x3567ec0(BX), R10	
  0x5176f		4939c2			CMPQ R10, AX		
		if start >= end {
  0x51772		490f4cc2		CMOVL R10, AX		
  0x51776		4839d0			CMPQ AX, DX		
		if end > sim.N_e {
  0x51779		7ecc			JLE 0x51747		
	for w := 0; w < numWorkers; w++ {
  0x5177b		4889742448		MOVQ SI, 0x48(SP)	
		start := w * chunkSize
  0x51780		4889542420		MOVQ DX, 0x20(SP)	
		end := (w + 1) * chunkSize
  0x51785		4c89442440		MOVQ R8, 0x40(SP)	
		if start >= end {
  0x5178a		4889442430		MOVQ AX, 0x30(SP)	
		wg.Go(func() {
  0x5178f		b828000000		MOVL $0x28, AX		
  0x51794		488d1d00000000		LEAQ 0(IP), BX		[3:7]R_PCREL:type:noalg.struct { F uintptr; X0 *gopic.SimulationState; X1 int; X2 int; X3 int }	
  0x5179b		b901000000		MOVL $0x1, CX		
  0x517a0		90			NOPL			
  0x517a1		e800000000		CALL 0x517a6		[1:5]R_CALL:runtime.mallocgcSmallScanNoHeaderSC5			
  0x517a6		488d1500000000		LEAQ 0(IP), DX		[3:7]R_PCREL:gopic.(*SimulationState).Step1ComputeElectronDensity.func1	
  0x517ad		488910			MOVQ DX, 0(AX)		
  0x517b0		833d0000000000		CMPL 0(IP), $0x0	[2:6]R_PCREL:runtime.writeBarrier+-1	
  0x517b7		7508			JNE 0x517c1		
  0x517b9		488b4c2468		MOVQ 0x68(SP), CX	
  0x517be		eb0e			JMP 0x517ce		
  0x517c0		90			NOPL			
  0x517c1		e800000000		CALL 0x517c6		[1:5]R_CALL:runtime.gcWriteBarrier1<1>	
  0x517c6		488b4c2468		MOVQ 0x68(SP), CX	
  0x517cb		49890b			MOVQ CX, 0(R11)		
  0x517ce		48894808		MOVQ CX, 0x8(AX)	
  0x517d2		488b4c2448		MOVQ 0x48(SP), CX	
  0x517d7		48894810		MOVQ CX, 0x10(AX)	
  0x517db		488b4c2420		MOVQ 0x20(SP), CX	
  0x517e0		48894818		MOVQ CX, 0x18(AX)	
  0x517e4		488b4c2430		MOVQ 0x30(SP), CX	
  0x517e9		48894820		MOVQ CX, 0x20(AX)	
  0x517ed		4889c3			MOVQ AX, BX		
  0x517f0		488b442450		MOVQ 0x50(SP), AX	
  0x517f5		e800000000		CALL 0x517fa		[1:5]R_CALL:sync.(*WaitGroup).Go	
	wg.Wait()
  0x517fa		488b4c2450		MOVQ 0x50(SP), CX	
		if end > sim.N_e {
  0x517ff		488b5c2468		MOVQ 0x68(SP), BX	
	for w := 0; w < numWorkers; w++ {
  0x51804		488b7c2428		MOVQ 0x28(SP), DI	
  0x51809		4c8b442440		MOVQ 0x40(SP), R8	
		start := w * chunkSize
  0x5180e		4c8b4c2438		MOVQ 0x38(SP), R9	
		wg.Go(func() {
  0x51813		e92fffffff		JMP 0x51747		
	wg.Wait()
  0x51818		4889c8			MOVQ CX, AX		
  0x5181b		e800000000		CALL 0x51820		[1:5]R_CALL:sync.(*WaitGroup).Wait	
	for p := range N_G {
  0x51820		488b7c2468		MOVQ 0x68(SP), DI	
  0x51825		488d8fd0272707		LEAQ 0x72727d0(DI), CX	
  0x5182c		31c0			XORL AX, AX		
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x5182e		4889fa			MOVQ DI, DX		
	for p := range N_G {
  0x51831		4889cf			MOVQ CX, DI		
  0x51834		b990010000		MOVL $0x190, CX		
  0x51839		f348ab			REP; STOSQ AX, ES:0(DI)	
	for w := range numWorkers {
  0x5183c		31c9			XORL CX, CX		
  0x5183e		488b5c2428		MOVQ 0x28(SP), BX	
  0x51843		eb03			JMP 0x51848		
  0x51845		48ffc1			INCQ CX			
  0x51848		4839d9			CMPQ CX, BX		
  0x5184b		7d3f			JGE 0x5188c		
			sim.E_density[p] += sim.WorkerEDensity[w][p]
  0x5184d		4869c1800c0000		IMULQ $0xc80, CX, AX	
		for p := range N_G {
  0x51854		31f6			XORL SI, SI		
  0x51856		eb17			JMP 0x5186f		
			sim.E_density[p] += sim.WorkerEDensity[w][p]
  0x51858		488b3a			MOVQ 0(DX), DI				
  0x5185b		4801c7			ADDQ AX, DI				
  0x5185e		f20f5804f7		ADDSD 0(DI)(SI*8), X0			
  0x51863		f20f1184f2d0272707	MOVSD_XMM X0, 0x72727d0(DX)(SI*8)	
		for p := range N_G {
  0x5186c		48ffc6			INCQ SI			
  0x5186f		4881fe90010000		CMPQ SI, $0x190		
  0x51876		7dcd			JGE 0x51845		
			sim.E_density[p] += sim.WorkerEDensity[w][p]
  0x51878		488b7a08		MOVQ 0x8(DX), DI			
  0x5187c		f20f1084f2d0272707	MOVSD_XMM 0x72727d0(DX)(SI*8), X0	
  0x51885		4839f9			CMPQ CX, DI				
  0x51888		72ce			JB 0x51858				
  0x5188a		eb58			JMP 0x518e4				
	sim.E_density[0] *= 2.0
  0x5188c		f20f1082d0272707	MOVSD_XMM 0x72727d0(DX), X0	
  0x51894		f20f58c0		ADDSD X0, X0			
  0x51898		f20f1182d0272707	MOVSD_XMM X0, 0x72727d0(DX)	
	sim.E_density[N_G-1] *= 2.0
  0x518a0		f20f108248342707	MOVSD_XMM 0x7273448(DX), X0	
  0x518a8		f20f58c0		ADDSD X0, X0			
  0x518ac		f20f118248342707	MOVSD_XMM X0, 0x7273448(DX)	
	for p := range N_G {
  0x518b4		31c0			XORL AX, AX		
  0x518b6		eb1e			JMP 0x518d6		
		sim.Cumul_e_density[p] += sim.E_density[p]
  0x518b8		f20f1084c2d0272707	MOVSD_XMM 0x72727d0(DX)(AX*8), X0	
  0x518c1		f20f5884c2d0402707	ADDSD 0x72740d0(DX)(AX*8), X0		
  0x518ca		f20f1184c2d0402707	MOVSD_XMM X0, 0x72740d0(DX)(AX*8)	
	for p := range N_G {
  0x518d3		48ffc0			INCQ AX			
  0x518d6		483d90010000		CMPQ AX, $0x190		
  0x518dc		7cda			JL 0x518b8		
}
  0x518de		4883c458		ADDQ $0x58, SP		
  0x518e2		5d			POPQ BP			
  0x518e3		c3			RET			
			sim.E_density[p] += sim.WorkerEDensity[w][p]
  0x518e4		e800000000		CALL 0x518e9		[1:5]R_CALL:runtime.panicBounds	
	chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x518e9		e800000000		CALL 0x518ee		[1:5]R_CALL:runtime.panicdivide<1>	
  0x518ee		90			NOPL			
func (sim *SimulationState) Step1ComputeElectronDensity() {
  0x518ef		4889442408		MOVQ AX, 0x8(SP)						
  0x518f4		e800000000		CALL 0x518f9							[1:5]R_CALL:runtime.morestack_noctxt	
  0x518f9		488b442408		MOVQ 0x8(SP), AX						
  0x518fe		0f1f00			NOPL 0(AX)							
  0x51901		e9bbfdffff		JMP gopic.(*SimulationState).Step1ComputeElectronDensity(SB)	

TEXT gopic.(*SimulationState).Step1ComputeElectronDensity.func1(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
		wg.Go(func() {
  0x64657		55			PUSHQ BP		
  0x64658		4889e5			MOVQ SP, BP		
  0x6465b		488b5a10		MOVQ 0x10(DX), BX	
  0x6465f		488b7208		MOVQ 0x8(DX), SI	
			density := &sim.WorkerEDensity[workerID]
  0x64663		4c8b4608		MOVQ 0x8(SI), R8	
  0x64667		4939d8			CMPQ R8, BX		
  0x6466a		0f86b8000000		JBE 0x64728		
  0x64670		4c8b06			MOVQ 0(SI), R8		
  0x64673		4869db800c0000		IMULQ $0xc80, BX, BX	
			for p := range N_G {
  0x6467a		498d3c18		LEAQ 0(R8)(BX*1), DI	
		wg.Go(func() {
  0x6467e		4c8b4a18		MOVQ 0x18(DX), R9	
  0x64682		488b5220		MOVQ 0x20(DX), DX	
			for p := range N_G {
  0x64686		b990010000		MOVL $0x190, CX		
  0x6468b		31c0			XORL AX, AX		
  0x6468d		f348ab			REP; STOSQ AX, ES:0(DI)	
			density := &sim.WorkerEDensity[workerID]
  0x64690		4c01c3			ADDQ R8, BX		
			for k := s; k < e; k++ {
  0x64693		eb42			JMP 0x646d7		
				d := c0 - float64(p)
  0x64695		0f57d2			XORPS X2, X2		
  0x64698		f2480f2ad0		CVTSI2SDQ AX, X2	
  0x6469d		f20f5cc2		SUBSD X2, X0		
				density[p] += (1.0 - d) * FACTOR_W
  0x646a1		f20f101500000000	MOVSD_XMM 0(IP), X2		[4:8]R_PCREL:$f64.3ff0000000000000	
  0x646a9		f20f5cd0		SUBSD X0, X2			
  0x646ad		f20f101d00000000	MOVSD_XMM 0(IP), X3		[4:8]R_PCREL:$f64.42a4525e2ecfffff	
  0x646b5		f20f59d3		MULSD X3, X2			
  0x646b9		f20f5814c3		ADDSD 0(BX)(AX*8), X2		
  0x646be		f20f1114c3		MOVSD_XMM X2, 0(BX)(AX*8)	
				density[p+1] += d * FACTOR_W
  0x646c3		f20f59c3		MULSD X3, X0			
  0x646c7		f20f5844c308		ADDSD 0x8(BX)(AX*8), X0		
  0x646cd		f20f1144c308		MOVSD_XMM X0, 0x8(BX)(AX*8)	
			for k := s; k < e; k++ {
  0x646d3		49ffc1			INCQ R9			
  0x646d6		90			NOPL			
  0x646d7		4939d1			CMPQ R9, DX		
  0x646da		7d40			JGE 0x6471c		
				c0 := sim.X_e[k] * INV_DX
  0x646dc		4981f940420f00		CMPQ R9, $0xf4240			
  0x646e3		7339			JAE 0x6471e				
  0x646e5		f2420f1084ced07e5603	MOVSD_XMM 0x3567ed0(SI)(R9*8), X0	
  0x646ef		f20f100d00000000	MOVSD_XMM 0(IP), X1			[4:8]R_PCREL:$f64.40cf2c0000000000	
  0x646f7		f20f59c1		MULSD X1, X0				
				p := min(max(int(c0), 0), N_G-2)
  0x646fb		f2480f2cc0		CVTTSD2SIQ X0, AX	
  0x64700		4885c0			TESTQ AX, AX		
  0x64703		7d02			JGE 0x64707		
  0x64705		31c0			XORL AX, AX		
  0x64707		483d8e010000		CMPQ AX, $0x18e		
  0x6470d		7e86			JLE 0x64695		
  0x6470f		b88e010000		MOVL $0x18e, AX		
  0x64714		0f1f00			NOPL 0(AX)		
  0x64717		e979ffffff		JMP 0x64695		
		})
  0x6471c		5d			POPQ BP			
  0x6471d		c3			RET			
				c0 := sim.X_e[k] * INV_DX
  0x6471e		b840420f00		MOVL $0xf4240, AX	
  0x64723		e800000000		CALL 0x64728		[1:5]R_CALL:runtime.panicBounds	
			density := &sim.WorkerEDensity[workerID]
  0x64728		e800000000		CALL 0x6472d		[1:5]R_CALL:runtime.panicBounds	
  0x6472d		90			NOPL			
