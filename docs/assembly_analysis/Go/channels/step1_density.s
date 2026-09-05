TEXT gopic.(*SimulationState).Step1ComputeElectronDensity(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation.go
func (sim *SimulationState) Step1ComputeElectronDensity() {
  0x1400c3640		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c3644		0f8661010000		JBE 0x1400c37ab		
  0x1400c364a		55			PUSHQ BP		
  0x1400c364b		4889e5			MOVQ SP, BP		
  0x1400c364e		4883ec28		SUBQ $0x28, SP		
	for w := range numWorkers {
  0x1400c3652		4889442438		MOVQ AX, 0x38(SP)	
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c3657		8400			TESTB AL, 0(AX)		
	sim.broadcastAndWait(CmdComputeEDensity)
  0x1400c3659		90			NOPL			
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c365a		488b90402eba07		MOVQ 0x7ba2e40(AX), DX	
  0x1400c3661		4889542418		MOVQ DX, 0x18(SP)	
  0x1400c3666		31c9			XORL CX, CX		
	for w := range numWorkers {
  0x1400c3668		eb2d			JMP 0x1400c3697		
  0x1400c366a		48894c2410		MOVQ CX, 0x10(SP)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c366f		488b90382eba07		MOVQ 0x7ba2e38(AX), DX		
  0x1400c3676		488b04ca		MOVQ 0(DX)(CX*8), AX		
  0x1400c367a		488d5c2420		LEAQ 0x20(SP), BX		
  0x1400c367f		90			NOPL				
  0x1400c3680		e87bd0f4ff		CALL runtime.chansend1(SB)	
	for w := range numWorkers {
  0x1400c3685		488b4c2410		MOVQ 0x10(SP), CX	
  0x1400c368a		48ffc1			INCQ CX			
		sim.WorkerCmdChan[w] <- cmd
  0x1400c368d		488b442438		MOVQ 0x38(SP), AX	
	for w := range numWorkers {
  0x1400c3692		488b542418		MOVQ 0x18(SP), DX	
  0x1400c3697		4839d1			CMPQ CX, DX		
  0x1400c369a		7d3a			JGE 0x1400c36d6		
		sim.WorkerCmdChan[w] <- cmd
  0x1400c369c		48c744242000000000	MOVQ $0x0, 0x20(SP)	
  0x1400c36a5		488bb0402eba07		MOVQ 0x7ba2e40(AX), SI	
  0x1400c36ac		4839f1			CMPQ CX, SI		
  0x1400c36af		72b9			JB 0x1400c366a		
  0x1400c36b1		e9ef000000		JMP 0x1400c37a5		
	for range numWorkers {
  0x1400c36b6		4889542418		MOVQ DX, 0x18(SP)	
		<-sim.WorkerDoneChan
  0x1400c36bb		488b80502eba07		MOVQ 0x7ba2e50(AX), AX		
  0x1400c36c2		31db			XORL BX, BX			
  0x1400c36c4		e8b7def4ff		CALL runtime.chanrecv1(SB)	
	for range numWorkers {
  0x1400c36c9		488b542418		MOVQ 0x18(SP), DX	
  0x1400c36ce		48ffca			DECQ DX			
		<-sim.WorkerDoneChan
  0x1400c36d1		488b442438		MOVQ 0x38(SP), AX	
	for range numWorkers {
  0x1400c36d6		4885d2			TESTQ DX, DX		
  0x1400c36d9		7fdb			JG 0x1400c36b6		
	for p := range N_G {
  0x1400c36db		488db8d0272707		LEAQ 0x72727d0(AX), DI	
  0x1400c36e2		b990010000		MOVL $0x190, CX		
	for w := range numWorkers {
  0x1400c36e7		4889c2			MOVQ AX, DX		
	for p := range N_G {
  0x1400c36ea		31c0			XORL AX, AX		
  0x1400c36ec		f348ab			REP; STOSQ AX, ES:0(DI)	
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c36ef		488b9a402eba07		MOVQ 0x7ba2e40(DX), BX	
	for w := range numWorkers {
  0x1400c36f6		31f6			XORL SI, SI		
  0x1400c36f8		eb06			JMP 0x1400c3700		
  0x1400c36fa		48ffc6			INCQ SI			
  0x1400c36fd		0f1f00			NOPL 0(AX)		
  0x1400c3700		4839de			CMPQ SI, BX		
  0x1400c3703		7d42			JGE 0x1400c3747		
			sim.E_density[p] += sim.WorkerEDensity[w][p]
  0x1400c3705		4869c6800c0000		IMULQ $0xc80, SI, AX	
		for p := range N_G {
  0x1400c370c		31c9			XORL CX, CX		
  0x1400c370e		eb17			JMP 0x1400c3727		
			sim.E_density[p] += sim.WorkerEDensity[w][p]
  0x1400c3710		488b3a			MOVQ 0(DX), DI				
  0x1400c3713		4801c7			ADDQ AX, DI				
  0x1400c3716		f20f5804cf		ADDSD 0(DI)(CX*8), X0			
  0x1400c371b		f20f1184cad0272707	MOVSD_XMM X0, 0x72727d0(DX)(CX*8)	
		for p := range N_G {
  0x1400c3724		48ffc1			INCQ CX			
  0x1400c3727		4881f990010000		CMPQ CX, $0x190		
  0x1400c372e		7dca			JGE 0x1400c36fa		
			sim.E_density[p] += sim.WorkerEDensity[w][p]
  0x1400c3730		488b7a08		MOVQ 0x8(DX), DI			
  0x1400c3734		f20f1084cad0272707	MOVSD_XMM 0x72727d0(DX)(CX*8), X0	
  0x1400c373d		0f1f00			NOPL 0(AX)				
  0x1400c3740		4839fe			CMPQ SI, DI				
  0x1400c3743		72cb			JB 0x1400c3710				
  0x1400c3745		eb58			JMP 0x1400c379f				
	sim.E_density[0] *= 2.0
  0x1400c3747		f20f1082d0272707	MOVSD_XMM 0x72727d0(DX), X0	
  0x1400c374f		f20f58c0		ADDSD X0, X0			
  0x1400c3753		f20f1182d0272707	MOVSD_XMM X0, 0x72727d0(DX)	
	sim.E_density[N_G-1] *= 2.0
  0x1400c375b		f20f108248342707	MOVSD_XMM 0x7273448(DX), X0	
  0x1400c3763		f20f58c0		ADDSD X0, X0			
  0x1400c3767		f20f118248342707	MOVSD_XMM X0, 0x7273448(DX)	
	for p := range N_G {
  0x1400c376f		31c0			XORL AX, AX		
  0x1400c3771		eb1e			JMP 0x1400c3791		
		sim.Cumul_e_density[p] += sim.E_density[p]
  0x1400c3773		f20f1084c2d0272707	MOVSD_XMM 0x72727d0(DX)(AX*8), X0	
  0x1400c377c		f20f5884c2d0402707	ADDSD 0x72740d0(DX)(AX*8), X0		
  0x1400c3785		f20f1184c2d0402707	MOVSD_XMM X0, 0x72740d0(DX)(AX*8)	
	for p := range N_G {
  0x1400c378e		48ffc0			INCQ AX			
  0x1400c3791		483d90010000		CMPQ AX, $0x190		
  0x1400c3797		7cda			JL 0x1400c3773		
}
  0x1400c3799		4883c428		ADDQ $0x28, SP		
  0x1400c379d		5d			POPQ BP			
  0x1400c379e		c3			RET			
			sim.E_density[p] += sim.WorkerEDensity[w][p]
  0x1400c379f		90			NOPL				
  0x1400c37a0		e8dbacfbff		CALL runtime.panicBounds(SB)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c37a5		e8d6acfbff		CALL runtime.panicBounds(SB)	
  0x1400c37aa		90			NOPL				
func (sim *SimulationState) Step1ComputeElectronDensity() {
  0x1400c37ab		4889442408		MOVQ AX, 0x8(SP)						
  0x1400c37b0		e88b8efbff		CALL runtime.morestack_noctxt.abi0(SB)				
  0x1400c37b5		488b442408		MOVQ 0x8(SP), AX						
  0x1400c37ba		e981feffff		JMP gopic.(*SimulationState).Step1ComputeElectronDensity(SB)	

  0x1400c37bf		cc			INT $0x3		
