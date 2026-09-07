// =============================================================================
// SYMBOL: Step1ComputeElectronDensity
// =============================================================================

TEXT gopic.(*SimulationState).Step1ComputeElectronDensity(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation.go
func (sim *SimulationState) Step1ComputeElectronDensity() {
  0x1400c33e0		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c33e4		0f8661010000		JBE 0x1400c354b		
  0x1400c33ea		55			PUSHQ BP		
  0x1400c33eb		4889e5			MOVQ SP, BP		
  0x1400c33ee		4883ec28		SUBQ $0x28, SP		
	for w := range numWorkers {
  0x1400c33f2		4889442438		MOVQ AX, 0x38(SP)	
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c33f7		8400			TESTB AL, 0(AX)		
	sim.broadcastAndWait(CmdComputeEDensity)
  0x1400c33f9		90			NOPL			
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c33fa		488b90582eba07		MOVQ 0x7ba2e58(AX), DX	
  0x1400c3401		4889542418		MOVQ DX, 0x18(SP)	
  0x1400c3406		31c9			XORL CX, CX		
	for w := range numWorkers {
  0x1400c3408		eb2d			JMP 0x1400c3437		
  0x1400c340a		48894c2410		MOVQ CX, 0x10(SP)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c340f		488b90502eba07		MOVQ 0x7ba2e50(AX), DX		
  0x1400c3416		488b04ca		MOVQ 0(DX)(CX*8), AX		
  0x1400c341a		488d5c2420		LEAQ 0x20(SP), BX		
  0x1400c341f		90			NOPL				
  0x1400c3420		e8dbd2f4ff		CALL runtime.chansend1(SB)	
	for w := range numWorkers {
  0x1400c3425		488b4c2410		MOVQ 0x10(SP), CX	
  0x1400c342a		48ffc1			INCQ CX			
		sim.WorkerCmdChan[w] <- cmd
  0x1400c342d		488b442438		MOVQ 0x38(SP), AX	
	for w := range numWorkers {
  0x1400c3432		488b542418		MOVQ 0x18(SP), DX	
  0x1400c3437		4839d1			CMPQ CX, DX		
  0x1400c343a		7d3a			JGE 0x1400c3476		
		sim.WorkerCmdChan[w] <- cmd
  0x1400c343c		48c744242000000000	MOVQ $0x0, 0x20(SP)	
  0x1400c3445		488bb0582eba07		MOVQ 0x7ba2e58(AX), SI	
  0x1400c344c		4839f1			CMPQ CX, SI		
  0x1400c344f		72b9			JB 0x1400c340a		
  0x1400c3451		e9ef000000		JMP 0x1400c3545		
	for range numWorkers {
  0x1400c3456		4889542418		MOVQ DX, 0x18(SP)	
		<-sim.WorkerDoneChan
  0x1400c345b		488b80682eba07		MOVQ 0x7ba2e68(AX), AX		
  0x1400c3462		31db			XORL BX, BX			
  0x1400c3464		e817e1f4ff		CALL runtime.chanrecv1(SB)	
	for range numWorkers {
  0x1400c3469		488b542418		MOVQ 0x18(SP), DX	
  0x1400c346e		48ffca			DECQ DX			
		<-sim.WorkerDoneChan
  0x1400c3471		488b442438		MOVQ 0x38(SP), AX	
	for range numWorkers {
  0x1400c3476		4885d2			TESTQ DX, DX		
  0x1400c3479		7fdb			JG 0x1400c3456		
	for p := range N_G {
  0x1400c347b		488db8d0272707		LEAQ 0x72727d0(AX), DI	
  0x1400c3482		b990010000		MOVL $0x190, CX		
	for w := range numWorkers {
  0x1400c3487		4889c2			MOVQ AX, DX		
	for p := range N_G {
  0x1400c348a		31c0			XORL AX, AX		
  0x1400c348c		f348ab			REP; STOSQ AX, ES:0(DI)	
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c348f		488b9a582eba07		MOVQ 0x7ba2e58(DX), BX	
	for w := range numWorkers {
  0x1400c3496		31f6			XORL SI, SI		
  0x1400c3498		eb06			JMP 0x1400c34a0		
  0x1400c349a		48ffc6			INCQ SI			
  0x1400c349d		0f1f00			NOPL 0(AX)		
  0x1400c34a0		4839de			CMPQ SI, BX		
  0x1400c34a3		7d42			JGE 0x1400c34e7		
			sim.E_density[p] += sim.WorkerEDensity[w][p]
  0x1400c34a5		4869c6800c0000		IMULQ $0xc80, SI, AX	
		for p := range N_G {
  0x1400c34ac		31c9			XORL CX, CX		
  0x1400c34ae		eb17			JMP 0x1400c34c7		
			sim.E_density[p] += sim.WorkerEDensity[w][p]
  0x1400c34b0		488b3a			MOVQ 0(DX), DI				
  0x1400c34b3		4801c7			ADDQ AX, DI				
  0x1400c34b6		f20f5804cf		ADDSD 0(DI)(CX*8), X0			
  0x1400c34bb		f20f1184cad0272707	MOVSD_XMM X0, 0x72727d0(DX)(CX*8)	
		for p := range N_G {
  0x1400c34c4		48ffc1			INCQ CX			
  0x1400c34c7		4881f990010000		CMPQ CX, $0x190		
  0x1400c34ce		7dca			JGE 0x1400c349a		
			sim.E_density[p] += sim.WorkerEDensity[w][p]
  0x1400c34d0		488b7a08		MOVQ 0x8(DX), DI			
  0x1400c34d4		f20f1084cad0272707	MOVSD_XMM 0x72727d0(DX)(CX*8), X0	
  0x1400c34dd		0f1f00			NOPL 0(AX)				
  0x1400c34e0		4839fe			CMPQ SI, DI				
  0x1400c34e3		72cb			JB 0x1400c34b0				
  0x1400c34e5		eb58			JMP 0x1400c353f				
	sim.E_density[0] *= 2.0
  0x1400c34e7		f20f1082d0272707	MOVSD_XMM 0x72727d0(DX), X0	
  0x1400c34ef		f20f58c0		ADDSD X0, X0			
  0x1400c34f3		f20f1182d0272707	MOVSD_XMM X0, 0x72727d0(DX)	
	sim.E_density[N_G-1] *= 2.0
  0x1400c34fb		f20f108248342707	MOVSD_XMM 0x7273448(DX), X0	
  0x1400c3503		f20f58c0		ADDSD X0, X0			
  0x1400c3507		f20f118248342707	MOVSD_XMM X0, 0x7273448(DX)	
	for p := range N_G {
  0x1400c350f		31c0			XORL AX, AX		
  0x1400c3511		eb1e			JMP 0x1400c3531		
		sim.Cumul_e_density[p] += sim.E_density[p]
  0x1400c3513		f20f1084c2d0272707	MOVSD_XMM 0x72727d0(DX)(AX*8), X0	
  0x1400c351c		f20f5884c2d0402707	ADDSD 0x72740d0(DX)(AX*8), X0		
  0x1400c3525		f20f1184c2d0402707	MOVSD_XMM X0, 0x72740d0(DX)(AX*8)	
	for p := range N_G {
  0x1400c352e		48ffc0			INCQ AX			
  0x1400c3531		483d90010000		CMPQ AX, $0x190		
  0x1400c3537		7cda			JL 0x1400c3513		
}
  0x1400c3539		4883c428		ADDQ $0x28, SP		
  0x1400c353d		5d			POPQ BP			
  0x1400c353e		c3			RET			
			sim.E_density[p] += sim.WorkerEDensity[w][p]
  0x1400c353f		90			NOPL				
  0x1400c3540		e83baffbff		CALL runtime.panicBounds(SB)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3545		e836affbff		CALL runtime.panicBounds(SB)	
  0x1400c354a		90			NOPL				
func (sim *SimulationState) Step1ComputeElectronDensity() {
  0x1400c354b		4889442408		MOVQ AX, 0x8(SP)						
  0x1400c3550		e8eb90fbff		CALL runtime.morestack_noctxt.abi0(SB)				
  0x1400c3555		488b442408		MOVQ 0x8(SP), AX						
  0x1400c355a		e981feffff		JMP gopic.(*SimulationState).Step1ComputeElectronDensity(SB)	

  0x1400c355f		cc			INT $0x3		


// =============================================================================
// SYMBOL: Step1ComputeIonDensity
// =============================================================================

TEXT gopic.(*SimulationState).Step1ComputeIonDensity(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation.go
func (sim *SimulationState) Step1ComputeIonDensity(t int) {
  0x1400c3560		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c3564		0f86a1010000		JBE 0x1400c370b		
  0x1400c356a		55			PUSHQ BP		
  0x1400c356b		4889e5			MOVQ SP, BP		
  0x1400c356e		4883ec28		SUBQ $0x28, SP		
	if (t % N_SUB) == 0 {
  0x1400c3572		48bacdcccccccccccccc	MOVQ $0xcccccccccccccccd, DX	
  0x1400c357c		480fafda		IMULQ DX, BX			
  0x1400c3580		48ba9899999999999919	MOVQ $0x1999999999999998, DX	
  0x1400c358a		4801da			ADDQ BX, DX			
  0x1400c358d		48c1c23e		ROLQ $0x3e, DX			
  0x1400c3591		48becccccccccccccc0c	MOVQ $0xccccccccccccccc, SI	
  0x1400c359b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x1400c35a0		4839d6			CMPQ SI, DX			
  0x1400c35a3		7218			JB 0x1400c35bd			
  0x1400c35a5		4889442438		MOVQ AX, 0x38(SP)		
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c35aa		8400			TESTB AL, 0(AX)		
		sim.broadcastAndWait(CmdComputeIDensity)
  0x1400c35ac		90			NOPL			
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c35ad		488b90582eba07		MOVQ 0x7ba2e58(AX), DX	
  0x1400c35b4		4889542418		MOVQ DX, 0x18(SP)	
  0x1400c35b9		31c9			XORL CX, CX		
	for w := range numWorkers {
  0x1400c35bb		eb63			JMP 0x1400c3620		
	for p := range N_G {
  0x1400c35bd		31c9			XORL CX, CX		
  0x1400c35bf		90			NOPL			
  0x1400c35c0		eb20			JMP 0x1400c35e2		
		sim.Cumul_i_density[p] += sim.I_density[p]
  0x1400c35c2		8400			TESTB AL, 0(AX)				
  0x1400c35c4		f20f1084c850342707	MOVSD_XMM 0x7273450(AX)(CX*8), X0	
  0x1400c35cd		f20f5884c8504d2707	ADDSD 0x7274d50(AX)(CX*8), X0		
  0x1400c35d6		f20f1184c8504d2707	MOVSD_XMM X0, 0x7274d50(AX)(CX*8)	
	for p := range N_G {
  0x1400c35df		48ffc1			INCQ CX			
  0x1400c35e2		4881f990010000		CMPQ CX, $0x190		
  0x1400c35e9		7cd7			JL 0x1400c35c2		
}
  0x1400c35eb		4883c428		ADDQ $0x28, SP		
  0x1400c35ef		5d			POPQ BP			
  0x1400c35f0		c3			RET			
	for w := range numWorkers {
  0x1400c35f1		48894c2410		MOVQ CX, 0x10(SP)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c35f6		488b90502eba07		MOVQ 0x7ba2e50(AX), DX		
  0x1400c35fd		488b04ca		MOVQ 0(DX)(CX*8), AX		
  0x1400c3601		488d5c2420		LEAQ 0x20(SP), BX		
  0x1400c3606		e8f5d0f4ff		CALL runtime.chansend1(SB)	
	for w := range numWorkers {
  0x1400c360b		488b4c2410		MOVQ 0x10(SP), CX	
  0x1400c3610		48ffc1			INCQ CX			
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3613		488b442438		MOVQ 0x38(SP), AX	
	for w := range numWorkers {
  0x1400c3618		488b542418		MOVQ 0x18(SP), DX	
  0x1400c361d		0f1f00			NOPL 0(AX)		
  0x1400c3620		4839d1			CMPQ CX, DX		
  0x1400c3623		7d3b			JGE 0x1400c3660		
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3625		48c744242001000000	MOVQ $0x1, 0x20(SP)	
  0x1400c362e		488bb0582eba07		MOVQ 0x7ba2e58(AX), SI	
  0x1400c3635		4839f1			CMPQ CX, SI		
  0x1400c3638		72b7			JB 0x1400c35f1		
  0x1400c363a		e9c6000000		JMP 0x1400c3705		
	for range numWorkers {
  0x1400c363f		4889542418		MOVQ DX, 0x18(SP)	
		<-sim.WorkerDoneChan
  0x1400c3644		488b80682eba07		MOVQ 0x7ba2e68(AX), AX		
  0x1400c364b		31db			XORL BX, BX			
  0x1400c364d		e82edff4ff		CALL runtime.chanrecv1(SB)	
	for range numWorkers {
  0x1400c3652		488b542418		MOVQ 0x18(SP), DX	
  0x1400c3657		48ffca			DECQ DX			
		<-sim.WorkerDoneChan
  0x1400c365a		488b442438		MOVQ 0x38(SP), AX	
  0x1400c365f		90			NOPL			
	for range numWorkers {
  0x1400c3660		4885d2			TESTQ DX, DX		
  0x1400c3663		7fda			JG 0x1400c363f		
		for p := range N_G {
  0x1400c3665		488db850342707		LEAQ 0x7273450(AX), DI	
  0x1400c366c		b990010000		MOVL $0x190, CX		
	if (t % N_SUB) == 0 {
  0x1400c3671		4889c2			MOVQ AX, DX		
		for p := range N_G {
  0x1400c3674		31c0			XORL AX, AX		
  0x1400c3676		f348ab			REP; STOSQ AX, ES:0(DI)	
		numWorkers := len(sim.WorkerCmdChan)
  0x1400c3679		488b9a582eba07		MOVQ 0x7ba2e58(DX), BX	
		for w := range numWorkers {
  0x1400c3680		31f6			XORL SI, SI		
  0x1400c3682		eb03			JMP 0x1400c3687		
  0x1400c3684		48ffc6			INCQ SI			
  0x1400c3687		4839de			CMPQ SI, BX		
  0x1400c368a		7d40			JGE 0x1400c36cc		
				sim.I_density[p] += sim.WorkerIDensity[w][p]
  0x1400c368c		4869c6800c0000		IMULQ $0xc80, SI, AX	
			for p := range N_G {
  0x1400c3693		31c9			XORL CX, CX		
  0x1400c3695		eb18			JMP 0x1400c36af		
				sim.I_density[p] += sim.WorkerIDensity[w][p]
  0x1400c3697		488b7a18		MOVQ 0x18(DX), DI			
  0x1400c369b		4801c7			ADDQ AX, DI				
  0x1400c369e		f20f5804cf		ADDSD 0(DI)(CX*8), X0			
  0x1400c36a3		f20f1184ca50342707	MOVSD_XMM X0, 0x7273450(DX)(CX*8)	
			for p := range N_G {
  0x1400c36ac		48ffc1			INCQ CX			
  0x1400c36af		4881f990010000		CMPQ CX, $0x190		
  0x1400c36b6		7dcc			JGE 0x1400c3684		
				sim.I_density[p] += sim.WorkerIDensity[w][p]
  0x1400c36b8		488b7a20		MOVQ 0x20(DX), DI			
  0x1400c36bc		f20f1084ca50342707	MOVSD_XMM 0x7273450(DX)(CX*8), X0	
  0x1400c36c5		4839fe			CMPQ SI, DI				
  0x1400c36c8		72cd			JB 0x1400c3697				
  0x1400c36ca		eb30			JMP 0x1400c36fc				
		sim.I_density[0] *= 2.0
  0x1400c36cc		f20f108250342707	MOVSD_XMM 0x7273450(DX), X0	
  0x1400c36d4		f20f58c0		ADDSD X0, X0			
  0x1400c36d8		f20f118250342707	MOVSD_XMM X0, 0x7273450(DX)	
		sim.I_density[N_G-1] *= 2.0
  0x1400c36e0		f20f1082c8402707	MOVSD_XMM 0x72740c8(DX), X0	
  0x1400c36e8		f20f58c0		ADDSD X0, X0			
  0x1400c36ec		f20f1182c8402707	MOVSD_XMM X0, 0x72740c8(DX)	
		sim.Cumul_i_density[p] += sim.I_density[p]
  0x1400c36f4		4889d0			MOVQ DX, AX		
		sim.I_density[N_G-1] *= 2.0
  0x1400c36f7		e9c1feffff		JMP 0x1400c35bd		
				sim.I_density[p] += sim.WorkerIDensity[w][p]
  0x1400c36fc		0f1f4000		NOPL 0(AX)			
  0x1400c3700		e87badfbff		CALL runtime.panicBounds(SB)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c3705		e876adfbff		CALL runtime.panicBounds(SB)	
  0x1400c370a		90			NOPL				
func (sim *SimulationState) Step1ComputeIonDensity(t int) {
  0x1400c370b		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c3710		48895c2410		MOVQ BX, 0x10(SP)					
  0x1400c3715		e8268ffbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c371a		488b442408		MOVQ 0x8(SP), AX					
  0x1400c371f		488b5c2410		MOVQ 0x10(SP), BX					
  0x1400c3724		e937feffff		JMP gopic.(*SimulationState).Step1ComputeIonDensity(SB)	

  0x1400c3729		cc			INT $0x3		
  0x1400c372a		cc			INT $0x3		
  0x1400c372b		cc			INT $0x3		
  0x1400c372c		cc			INT $0x3		
  0x1400c372d		cc			INT $0x3		
  0x1400c372e		cc			INT $0x3		
  0x1400c372f		cc			INT $0x3		
  0x1400c3730		cc			INT $0x3		
  0x1400c3731		cc			INT $0x3		
  0x1400c3732		cc			INT $0x3		
  0x1400c3733		cc			INT $0x3		
  0x1400c3734		cc			INT $0x3		
  0x1400c3735		cc			INT $0x3		
  0x1400c3736		cc			INT $0x3		
  0x1400c3737		cc			INT $0x3		
  0x1400c3738		cc			INT $0x3		
  0x1400c3739		cc			INT $0x3		
  0x1400c373a		cc			INT $0x3		
  0x1400c373b		cc			INT $0x3		
  0x1400c373c		cc			INT $0x3		
  0x1400c373d		cc			INT $0x3		
  0x1400c373e		cc			INT $0x3		
  0x1400c373f		cc			INT $0x3		


