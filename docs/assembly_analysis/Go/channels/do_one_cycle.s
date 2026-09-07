// =============================================================================
// SYMBOL: DoOneCycle
// =============================================================================

TEXT gopic.(*SimulationState).DoOneCycle(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation.go
func (sim *SimulationState) DoOneCycle() {
  0x1400c41c0		4c8d6424a8		LEAQ -0x58(SP), R12	
  0x1400c41c5		4d3b6610		CMPQ R12, 0x10(R14)	
  0x1400c41c9		0f865c040000		JBE 0x1400c462b		
  0x1400c41cf		55			PUSHQ BP		
  0x1400c41d0		4889e5			MOVQ SP, BP		
  0x1400c41d3		4881ecd0000000		SUBQ $0xd0, SP		
	for t = range N_T {
  0x1400c41da		48898424e0000000	MOVQ AX, 0xe0(SP)	
  0x1400c41e2		31c9			XORL CX, CX		
  0x1400c41e4		eb04			JMP 0x1400c41ea		
  0x1400c41e6		488d4b01		LEAQ 0x1(BX), CX	
  0x1400c41ea		4881f9a00f0000		CMPQ CX, $0xfa0		
  0x1400c41f1		0f8dc0020000		JGE 0x1400c44b7		
  0x1400c41f7		48894c2448		MOVQ CX, 0x48(SP)	
		sim.Time += DT_E    // Aktualizacja caĹ‚kowitego fizycznego czasu symulacji
  0x1400c41fc		8400			TESTB AL, 0(AX)				
  0x1400c41fe		f20f1080a02dba07	MOVSD_XMM 0x7ba2da0(AX), X0		
  0x1400c4206		f20f100d3a1f0100	MOVSD_XMM $f64.3db4456f771df7e8(SB), X1	
  0x1400c420e		f20f58c1		ADDSD X1, X0				
  0x1400c4212		f20f1180a02dba07	MOVSD_XMM X0, 0x7ba2da0(AX)		
		sim.Step1ComputeElectronDensity()
  0x1400c421a		e8c1f1ffff		CALL gopic.(*SimulationState).Step1ComputeElectronDensity(SB)	
		sim.Step1ComputeIonDensity(t)
  0x1400c421f		488b8424e0000000	MOVQ 0xe0(SP), AX						
  0x1400c4227		488b5c2448		MOVQ 0x48(SP), BX						
  0x1400c422c		e82ff3ffff		CALL gopic.(*SimulationState).Step1ComputeIonDensity(SB)	
		t_index = t / N_BIN // Indeks dla macierzy czasoprzestrzennych XT
  0x1400c4231		48b8cdcccccccccccccc	MOVQ $0xcccccccccccccccd, AX	
  0x1400c423b		488b4c2448		MOVQ 0x48(SP), CX		
  0x1400c4240		48f7e1			MULQ CX				
  0x1400c4243		48c1ea04		SHRQ $0x4, DX			
  0x1400c4247		4889542440		MOVQ DX, 0x40(SP)		
		sim.Step2SolvePoisson(sim.Time)
  0x1400c424c		488b8424e0000000	MOVQ 0xe0(SP), AX					
  0x1400c4254		f20f1080a02dba07	MOVSD_XMM 0x7ba2da0(AX), X0				
  0x1400c425c		0f1f4000		NOPL 0(AX)						
  0x1400c4260		e8dbf4ffff		CALL gopic.(*SimulationState).Step2SolvePoisson(SB)	
		sim.Step3MoveElectrons(t_index)
  0x1400c4265		488b8424e0000000	MOVQ 0xe0(SP), AX					
  0x1400c426d		488b5c2440		MOVQ 0x40(SP), BX					
  0x1400c4272		e869f5ffff		CALL gopic.(*SimulationState).Step3MoveElectrons(SB)	
		sim.Step4MoveIons(t_index, t)
  0x1400c4277		488b8424e0000000	MOVQ 0xe0(SP), AX				
  0x1400c427f		488b5c2440		MOVQ 0x40(SP), BX				
  0x1400c4284		488b4c2448		MOVQ 0x48(SP), CX				
  0x1400c4289		e8b2f7ffff		CALL gopic.(*SimulationState).Step4MoveIons(SB)	
		sim.Step5CheckBoundariesElectrons()
  0x1400c428e		488b8424e0000000	MOVQ 0xe0(SP), AX						
  0x1400c4296		e8a5f9ffff		CALL gopic.(*SimulationState).Step5CheckBoundariesElectrons(SB)	
		sim.Step6CheckBoundariesIons(t)
  0x1400c429b		488b8424e0000000	MOVQ 0xe0(SP), AX						
  0x1400c42a3		488b5c2448		MOVQ 0x48(SP), BX						
  0x1400c42a8		e8f3fbffff		CALL gopic.(*SimulationState).Step6CheckBoundariesIons(SB)	
		sim.Step7CollisionsElectrons()
  0x1400c42ad		488b8424e0000000	MOVQ 0xe0(SP), AX						
  0x1400c42b5		e8a6080000		CALL gopic.(*SimulationState).Step7CollisionsElectrons(SB)	
	if (t%N_SUB) != 0 || sim.N_i == 0 {
  0x1400c42ba		488b4c2440		MOVQ 0x40(SP), CX	
  0x1400c42bf		488d1489		LEAQ 0(CX)(CX*4), DX	
  0x1400c42c3		48c1e202		SHLQ $0x2, DX		
		sim.Step8CollisionIons(t)
  0x1400c42c7		90			NOPL			
	if (t%N_SUB) != 0 || sim.N_i == 0 {
  0x1400c42c8		488b5c2448		MOVQ 0x48(SP), BX	
  0x1400c42cd		4839d3			CMPQ BX, DX		
  0x1400c42d0		740d			JE 0x1400c42df		
	if !sim.Measurement_mode {
  0x1400c42d2		488b8424e0000000	MOVQ 0xe0(SP), AX	
	if (t%N_SUB) != 0 || sim.N_i == 0 {
  0x1400c42da		e9b8000000		JMP 0x1400c4397			
  0x1400c42df		488b8424e0000000	MOVQ 0xe0(SP), AX		
  0x1400c42e7		4883b8c87e560300	CMPQ 0x3567ec8(AX), $0x0	
  0x1400c42ef		0f84a2000000		JE 0x1400c4397			
	sim.broadcastAndWait(CmdCollisionsI)
  0x1400c42f5		90			NOPL			
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c42f6		488b90582eba07		MOVQ 0x7ba2e58(AX), DX	
  0x1400c42fd		4889542450		MOVQ DX, 0x50(SP)	
  0x1400c4302		31f6			XORL SI, SI		
	for w := range numWorkers {
  0x1400c4304		eb3e			JMP 0x1400c4344		
  0x1400c4306		4889742438		MOVQ SI, 0x38(SP)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c430b		488b88502eba07		MOVQ 0x7ba2e50(AX), CX		
  0x1400c4312		488b04f1		MOVQ 0(CX)(SI*8), AX		
  0x1400c4316		488d5c2458		LEAQ 0x58(SP), BX		
  0x1400c431b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x1400c4320		e8dbc3f4ff		CALL runtime.chansend1(SB)	
	for w := range numWorkers {
  0x1400c4325		488b742438		MOVQ 0x38(SP), SI	
  0x1400c432a		48ffc6			INCQ SI			
		sim.WorkerCmdChan[w] <- cmd
  0x1400c432d		488b8424e0000000	MOVQ 0xe0(SP), AX	
		sim.Pot_xt[p][t_index] += sim.Pot[p]
  0x1400c4335		488b4c2440		MOVQ 0x40(SP), CX	
	for w := range numWorkers {
  0x1400c433a		488b542450		MOVQ 0x50(SP), DX	
		if (t % 1000) == 0 {
  0x1400c433f		488b5c2448		MOVQ 0x48(SP), BX	
	for w := range numWorkers {
  0x1400c4344		4839d6			CMPQ SI, DX		
  0x1400c4347		7d49			JGE 0x1400c4392		
		sim.WorkerCmdChan[w] <- cmd
  0x1400c4349		48c744245807000000	MOVQ $0x7, 0x58(SP)	
  0x1400c4352		488bb8582eba07		MOVQ 0x7ba2e58(AX), DI	
  0x1400c4359		4839fe			CMPQ SI, DI		
  0x1400c435c		72a8			JB 0x1400c4306		
  0x1400c435e		6690			NOPW			
  0x1400c4360		e9c0020000		JMP 0x1400c4625		
	for range numWorkers {
  0x1400c4365		4889542450		MOVQ DX, 0x50(SP)	
		<-sim.WorkerDoneChan
  0x1400c436a		488b80682eba07		MOVQ 0x7ba2e68(AX), AX		
  0x1400c4371		31db			XORL BX, BX			
  0x1400c4373		e808d2f4ff		CALL runtime.chanrecv1(SB)	
	for range numWorkers {
  0x1400c4378		488b542450		MOVQ 0x50(SP), DX	
  0x1400c437d		48ffca			DECQ DX			
		<-sim.WorkerDoneChan
  0x1400c4380		488b8424e0000000	MOVQ 0xe0(SP), AX	
		sim.Pot_xt[p][t_index] += sim.Pot[p]
  0x1400c4388		488b4c2440		MOVQ 0x40(SP), CX	
		if (t % 1000) == 0 {
  0x1400c438d		488b5c2448		MOVQ 0x48(SP), BX	
	for range numWorkers {
  0x1400c4392		4885d2			TESTQ DX, DX		
  0x1400c4395		7fce			JG 0x1400c4365		
		sim.Step9CollectXtData(t_index)
  0x1400c4397		90			NOPL			
	if !sim.Measurement_mode {
  0x1400c4398		80b8e02dba0700		CMPB 0x7ba2de0(AX), $0x0	
  0x1400c439f		90			NOPL				
  0x1400c43a0		7407			JE 0x1400c43a9			
  0x1400c43a2		31d2			XORL DX, DX			
  0x1400c43a4		e967020000		JMP 0x1400c4610			
		if (t % 1000) == 0 {
  0x1400c43a9		48b9d578e9263108ac1c	MOVQ $0x1cac083126e978d5, CX	
  0x1400c43b3		480fafcb		IMULQ BX, CX			
  0x1400c43b7		48c1c13d		ROLQ $0x3d, CX			
  0x1400c43bb		48baefa7c64b37894100	MOVQ $0x4189374bc6a7ef, DX	
  0x1400c43c5		4839ca			CMPQ DX, CX			
  0x1400c43c8		0f8218feffff		JB 0x1400c41e6			
			fmt.Printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", sim.Cycle, t, sim.N_e, sim.N_i)
  0x1400c43ce		488d4c2460		LEAQ 0x60(SP), CX		
  0x1400c43d3		440f1139		MOVUPS X15, 0(CX)		
  0x1400c43d7		440f117910		MOVUPS X15, 0x10(CX)		
  0x1400c43dc		440f117920		MOVUPS X15, 0x20(CX)		
  0x1400c43e1		440f117930		MOVUPS X15, 0x30(CX)		
  0x1400c43e6		488b80a82dba07		MOVQ 0x7ba2da8(AX), AX		
  0x1400c43ed		e86e29fbff		CALL runtime.convT64(SB)	
  0x1400c43f2		488d0d5f700f00		LEAQ type:*+94304(SB), CX	
  0x1400c43f9		48894c2460		MOVQ CX, 0x60(SP)		
  0x1400c43fe		4889442468		MOVQ AX, 0x68(SP)		
  0x1400c4403		488b442448		MOVQ 0x48(SP), AX		
  0x1400c4408		e85329fbff		CALL runtime.convT64(SB)	
  0x1400c440d		488d0d44700f00		LEAQ type:*+94304(SB), CX	
  0x1400c4414		48894c2470		MOVQ CX, 0x70(SP)		
  0x1400c4419		4889442478		MOVQ AX, 0x78(SP)		
  0x1400c441e		488b8c24e0000000	MOVQ 0xe0(SP), CX		
  0x1400c4426		488b81c07e5603		MOVQ 0x3567ec0(CX), AX		
  0x1400c442d		e82e29fbff		CALL runtime.convT64(SB)	
  0x1400c4432		488d0d1f700f00		LEAQ type:*+94304(SB), CX	
  0x1400c4439		48898c2480000000	MOVQ CX, 0x80(SP)		
  0x1400c4441		4889842488000000	MOVQ AX, 0x88(SP)		
  0x1400c4449		488b8c24e0000000	MOVQ 0xe0(SP), CX		
  0x1400c4451		488b81c87e5603		MOVQ 0x3567ec8(CX), AX		
  0x1400c4458		e80329fbff		CALL runtime.convT64(SB)	
  0x1400c445d		488d0df46f0f00		LEAQ type:*+94304(SB), CX	
  0x1400c4464		48898c2490000000	MOVQ CX, 0x90(SP)		
  0x1400c446c		4889842498000000	MOVQ AX, 0x98(SP)		
	return Fprintf(os.Stdout, format, a...)
  0x1400c4474		488b1ded6e1100		MOVQ os.Stdout(SB), BX			
  0x1400c447b		488d05968c1000		LEAQ type:*+167200(SB), AX		
  0x1400c4482		488d0d2ed70000		LEAQ runtime.rodata+35767(SB), CX	
  0x1400c4489		bf26000000		MOVL $0x26, DI				
  0x1400c448e		488d742460		LEAQ 0x60(SP), SI			
  0x1400c4493		41b804000000		MOVL $0x4, R8				
  0x1400c4499		4589c1			MOVL R8, R9				
  0x1400c449c		0f1f4000		NOPL 0(AX)				
  0x1400c44a0		e85bd1feff		CALL fmt.Fprintf(SB)			
		sim.Time += DT_E    // Aktualizacja caĹ‚kowitego fizycznego czasu symulacji
  0x1400c44a5		488b8424e0000000	MOVQ 0xe0(SP), AX	
	for t = range N_T {
  0x1400c44ad		488b5c2448		MOVQ 0x48(SP), BX	
			fmt.Printf(" c = %8d  t = %8d  #e = %8d  #i = %8d\n", sim.Cycle, t, sim.N_e, sim.N_i)
  0x1400c44b2		e92ffdffff		JMP 0x1400c41e6		
	fmt.Fprintf(sim.Datafile, "%8d  %8d  %8d\n", sim.Cycle, sim.N_e, sim.N_i)
  0x1400c44b7		488d8c24a0000000	LEAQ 0xa0(SP), CX			
  0x1400c44bf		440f1139		MOVUPS X15, 0(CX)			
  0x1400c44c3		440f117910		MOVUPS X15, 0x10(CX)			
  0x1400c44c8		440f117920		MOVUPS X15, 0x20(CX)			
  0x1400c44cd		8400			TESTB AL, 0(AX)				
  0x1400c44cf		488b80a82dba07		MOVQ 0x7ba2da8(AX), AX			
  0x1400c44d6		e88528fbff		CALL runtime.convT64(SB)		
  0x1400c44db		488d0d766f0f00		LEAQ type:*+94304(SB), CX		
  0x1400c44e2		48898c24a0000000	MOVQ CX, 0xa0(SP)			
  0x1400c44ea		48898424a8000000	MOVQ AX, 0xa8(SP)			
  0x1400c44f2		488b8c24e0000000	MOVQ 0xe0(SP), CX			
  0x1400c44fa		488b81c07e5603		MOVQ 0x3567ec0(CX), AX			
  0x1400c4501		e85a28fbff		CALL runtime.convT64(SB)		
  0x1400c4506		488d0d4b6f0f00		LEAQ type:*+94304(SB), CX		
  0x1400c450d		48898c24b0000000	MOVQ CX, 0xb0(SP)			
  0x1400c4515		48898424b8000000	MOVQ AX, 0xb8(SP)			
  0x1400c451d		488b8c24e0000000	MOVQ 0xe0(SP), CX			
  0x1400c4525		488b81c87e5603		MOVQ 0x3567ec8(CX), AX			
  0x1400c452c		e82f28fbff		CALL runtime.convT64(SB)		
  0x1400c4531		488d0d206f0f00		LEAQ type:*+94304(SB), CX		
  0x1400c4538		48898c24c0000000	MOVQ CX, 0xc0(SP)			
  0x1400c4540		48898424c8000000	MOVQ AX, 0xc8(SP)			
  0x1400c4548		488b8c24e0000000	MOVQ 0xe0(SP), CX			
  0x1400c4550		488b99d82dba07		MOVQ 0x7ba2dd8(CX), BX			
  0x1400c4557		488d05ba8b1000		LEAQ type:*+167200(SB), AX		
  0x1400c455e		488d0de4660000		LEAQ runtime.rodata+7241(SB), CX	
  0x1400c4565		bf0e000000		MOVL $0xe, DI				
  0x1400c456a		488db424a0000000	LEAQ 0xa0(SP), SI			
  0x1400c4572		41b803000000		MOVL $0x3, R8				
  0x1400c4578		4589c1			MOVL R8, R9				
  0x1400c457b		0f1f440000		NOPL 0(AX)(AX*1)			
  0x1400c4580		e87bd0feff		CALL fmt.Fprintf(SB)			
}
  0x1400c4585		4881c4d0000000		ADDQ $0xd0, SP		
  0x1400c458c		5d			POPQ BP			
  0x1400c458d		c3			RET			
		sim.Pot_xt[p][t_index] += sim.Pot[p]
  0x1400c458e		4869f240060000		IMULQ $0x640, DX, SI			
  0x1400c4595		488d3c30		LEAQ 0(AX)(SI*1), DI			
  0x1400c4599		488dbf80b12707		LEAQ 0x727b180(DI), DI			
  0x1400c45a0		f20f1084d0501b2707	MOVSD_XMM 0x7271b50(AX)(DX*8), X0	
  0x1400c45a9		f20f5804cf		ADDSD 0(DI)(CX*8), X0			
  0x1400c45ae		f20f1104cf		MOVSD_XMM X0, 0(DI)(CX*8)		
		sim.Efield_xt[p][t_index] += sim.Efield[p]
  0x1400c45b3		488d3c30		LEAQ 0(AX)(SI*1), DI			
  0x1400c45b7		488dbf80753107		LEAQ 0x7317580(DI), DI			
  0x1400c45be		f20f1084d0d00e2707	MOVSD_XMM 0x7270ed0(AX)(DX*8), X0	
  0x1400c45c7		f20f5804cf		ADDSD 0(DI)(CX*8), X0			
  0x1400c45cc		f20f1104cf		MOVSD_XMM X0, 0(DI)(CX*8)		
		sim.Ne_xt[p][t_index] += sim.E_density[p]
  0x1400c45d1		488d3c30		LEAQ 0(AX)(SI*1), DI			
  0x1400c45d5		488dbf80393b07		LEAQ 0x73b3980(DI), DI			
  0x1400c45dc		f20f1084d0d0272707	MOVSD_XMM 0x72727d0(AX)(DX*8), X0	
  0x1400c45e5		f20f5804cf		ADDSD 0(DI)(CX*8), X0			
  0x1400c45ea		f20f1104cf		MOVSD_XMM X0, 0(DI)(CX*8)		
		sim.Ni_xt[p][t_index] += sim.I_density[p]
  0x1400c45ef		488d3430		LEAQ 0(AX)(SI*1), SI			
  0x1400c45f3		488db680fd4407		LEAQ 0x744fd80(SI), SI			
  0x1400c45fa		f20f1084d050342707	MOVSD_XMM 0x7273450(AX)(DX*8), X0	
  0x1400c4603		f20f5804ce		ADDSD 0(SI)(CX*8), X0			
  0x1400c4608		f20f1104ce		MOVSD_XMM X0, 0(SI)(CX*8)		
	for p := range N_G {
  0x1400c460d		48ffc2			INCQ DX			
  0x1400c4610		4881fa90010000		CMPQ DX, $0x190		
  0x1400c4617		0f8c71ffffff		JL 0x1400c458e		
  0x1400c461d		0f1f00			NOPL 0(AX)		
  0x1400c4620		e984fdffff		JMP 0x1400c43a9		
		sim.WorkerCmdChan[w] <- cmd
  0x1400c4625		e8569efbff		CALL runtime.panicBounds(SB)	
  0x1400c462a		90			NOPL				
func (sim *SimulationState) DoOneCycle() {
  0x1400c462b		4889442408		MOVQ AX, 0x8(SP)				
  0x1400c4630		e80b80fbff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x1400c4635		488b442408		MOVQ 0x8(SP), AX				
  0x1400c463a		e981fbffff		JMP gopic.(*SimulationState).DoOneCycle(SB)	

  0x1400c463f		cc			INT $0x3		


