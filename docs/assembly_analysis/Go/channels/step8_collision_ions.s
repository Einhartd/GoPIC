TEXT gopic.(*SimulationState).Step8CollisionIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/simulation_null.go
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x1400c51e0		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c51e4		0f867c010000		JBE 0x1400c5366		
  0x1400c51ea		55			PUSHQ BP		
  0x1400c51eb		4889e5			MOVQ SP, BP		
  0x1400c51ee		4883ec30		SUBQ $0x30, SP		
	if (t % N_SUB) != 0 {
  0x1400c51f2		48b9cdcccccccccccccc	MOVQ $0xcccccccccccccccd, CX	
  0x1400c51fc		480fafd9		IMULQ CX, BX			
  0x1400c5200		48b99899999999999919	MOVQ $0x1999999999999998, CX	
  0x1400c520a		4801d9			ADDQ BX, CX			
  0x1400c520d		48c1c13e		ROLQ $0x3e, CX			
  0x1400c5211		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x1400c521b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x1400c5220		4839ca			CMPQ DX, CX			
  0x1400c5223		0f82ba000000		JB 0x1400c52e3			
  0x1400c5229		4889442440		MOVQ AX, 0x40(SP)		
	nCollStar := sim.sampleBinomial(sim.N_i, sim.PStarI)
  0x1400c522e		8400			TESTB AL, 0(AX)						
  0x1400c5230		488b98c87e5603		MOVQ 0x3567ec8(AX), BX					
  0x1400c5237		f20f1080282eba07	MOVSD_XMM 0x7ba2e28(AX), X0				
  0x1400c523f		90			NOPL							
  0x1400c5240		e8dbf9ffff		CALL gopic.(*SimulationState).sampleBinomial(SB)	
	if nCollStar > sim.N_i {
  0x1400c5245		488b4c2440		MOVQ 0x40(SP), CX	
  0x1400c524a		488b99c87e5603		MOVQ 0x3567ec8(CX), BX	
  0x1400c5251		4839d8			CMPQ AX, BX		
	if nCollStar == 0 {
  0x1400c5254		480f4fc3		CMOVG BX, AX		
  0x1400c5258		4885c0			TESTQ AX, AX		
	if nCollStar > sim.N_i {
  0x1400c525b		7455			JE 0x1400c52b2		
	if nCollStar == 0 {
  0x1400c525d		4889c2			MOVQ AX, DX		
	sim.CandidatesI = sim.randomSample(sim.N_i, nCollStar)
  0x1400c5260		4889c8			MOVQ CX, AX					
  0x1400c5263		4889d1			MOVQ DX, CX					
  0x1400c5266		e895f8ffff		CALL gopic.(*SimulationState).randomSample(SB)	
  0x1400c526b		488b542440		MOVQ 0x40(SP), DX				
  0x1400c5270		48899a782eba07		MOVQ BX, 0x7ba2e78(DX)				
  0x1400c5277		48898a802eba07		MOVQ CX, 0x7ba2e80(DX)				
  0x1400c527e		833d2bce150000		CMPL runtime.writeBarrier(SB), $0x0		
  0x1400c5285		7413			JE 0x1400c529a					
  0x1400c5287		488b8a702eba07		MOVQ 0x7ba2e70(DX), CX				
  0x1400c528e		e84d8efbff		CALL runtime.gcWriteBarrier2(SB)		
  0x1400c5293		498903			MOVQ AX, 0(R11)					
  0x1400c5296		49894b08		MOVQ CX, 0x8(R11)				
  0x1400c529a		488982702eba07		MOVQ AX, 0x7ba2e70(DX)				
	sim.broadcastAndWait(CmdCollisionsI)
  0x1400c52a1		90			NOPL			
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c52a2		488b8a402eba07		MOVQ 0x7ba2e40(DX), CX	
  0x1400c52a9		48894c2428		MOVQ CX, 0x28(SP)	
  0x1400c52ae		31c0			XORL AX, AX		
	for w := range numWorkers {
  0x1400c52b0		eb65			JMP 0x1400c5317		
		sim.CandidatesI = nil
  0x1400c52b2		440f11b9782eba07	MOVUPS X15, 0x7ba2e78(CX)		
  0x1400c52ba		833defcd150000		CMPL runtime.writeBarrier(SB), $0x0	
  0x1400c52c1		740f			JE 0x1400c52d2				
  0x1400c52c3		488b81702eba07		MOVQ 0x7ba2e70(CX), AX			
  0x1400c52ca		e8f18dfbff		CALL runtime.gcWriteBarrier1(SB)	
  0x1400c52cf		498903			MOVQ AX, 0(R11)				
  0x1400c52d2		48c781702eba0700000000	MOVQ $0x0, 0x7ba2e70(CX)		
		return
  0x1400c52dd		4883c430		ADDQ $0x30, SP		
  0x1400c52e1		5d			POPQ BP			
  0x1400c52e2		c3			RET			
		return
  0x1400c52e3		4883c430		ADDQ $0x30, SP		
  0x1400c52e7		5d			POPQ BP			
  0x1400c52e8		c3			RET			
	for w := range numWorkers {
  0x1400c52e9		4889442418		MOVQ AX, 0x18(SP)	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c52ee		488b8a382eba07		MOVQ 0x7ba2e38(DX), CX		
  0x1400c52f5		488b04c1		MOVQ 0(CX)(AX*8), AX		
  0x1400c52f9		488d5c2420		LEAQ 0x20(SP), BX		
  0x1400c52fe		6690			NOPW				
  0x1400c5300		e8fbb3f4ff		CALL runtime.chansend1(SB)	
	for w := range numWorkers {
  0x1400c5305		488b442418		MOVQ 0x18(SP), AX	
  0x1400c530a		48ffc0			INCQ AX			
  0x1400c530d		488b4c2428		MOVQ 0x28(SP), CX	
		sim.WorkerCmdChan[w] <- cmd
  0x1400c5312		488b542440		MOVQ 0x40(SP), DX	
	for w := range numWorkers {
  0x1400c5317		4839c8			CMPQ AX, CX		
  0x1400c531a		7d37			JGE 0x1400c5353		
		sim.WorkerCmdChan[w] <- cmd
  0x1400c531c		48c744242007000000	MOVQ $0x7, 0x20(SP)	
  0x1400c5325		488bb2402eba07		MOVQ 0x7ba2e40(DX), SI	
  0x1400c532c		4839f0			CMPQ AX, SI		
  0x1400c532f		72b8			JB 0x1400c52e9		
  0x1400c5331		eb2b			JMP 0x1400c535e		
	for range numWorkers {
  0x1400c5333		48894c2428		MOVQ CX, 0x28(SP)	
		<-sim.WorkerDoneChan
  0x1400c5338		488b82502eba07		MOVQ 0x7ba2e50(DX), AX		
  0x1400c533f		31db			XORL BX, BX			
  0x1400c5341		e83ac2f4ff		CALL runtime.chanrecv1(SB)	
	for range numWorkers {
  0x1400c5346		488b4c2428		MOVQ 0x28(SP), CX	
  0x1400c534b		48ffc9			DECQ CX			
		<-sim.WorkerDoneChan
  0x1400c534e		488b542440		MOVQ 0x40(SP), DX	
	for range numWorkers {
  0x1400c5353		4885c9			TESTQ CX, CX		
  0x1400c5356		7fdb			JG 0x1400c5333		
}
  0x1400c5358		4883c430		ADDQ $0x30, SP		
  0x1400c535c		5d			POPQ BP			
  0x1400c535d		c3			RET			
		sim.WorkerCmdChan[w] <- cmd
  0x1400c535e		6690			NOPW				
  0x1400c5360		e81b91fbff		CALL runtime.panicBounds(SB)	
  0x1400c5365		90			NOPL				
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x1400c5366		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c536b		48895c2410		MOVQ BX, 0x10(SP)					
  0x1400c5370		e8cb72fbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c5375		488b442408		MOVQ 0x8(SP), AX					
  0x1400c537a		488b5c2410		MOVQ 0x10(SP), BX					
  0x1400c537f		90			NOPL							
  0x1400c5380		e95bfeffff		JMP gopic.(*SimulationState).Step8CollisionIons(SB)	

  0x1400c5385		cc			INT $0x3		
  0x1400c5386		cc			INT $0x3		
  0x1400c5387		cc			INT $0x3		
  0x1400c5388		cc			INT $0x3		
  0x1400c5389		cc			INT $0x3		
  0x1400c538a		cc			INT $0x3		
  0x1400c538b		cc			INT $0x3		
  0x1400c538c		cc			INT $0x3		
  0x1400c538d		cc			INT $0x3		
  0x1400c538e		cc			INT $0x3		
  0x1400c538f		cc			INT $0x3		
  0x1400c5390		cc			INT $0x3		
  0x1400c5391		cc			INT $0x3		
  0x1400c5392		cc			INT $0x3		
  0x1400c5393		cc			INT $0x3		
  0x1400c5394		cc			INT $0x3		
  0x1400c5395		cc			INT $0x3		
  0x1400c5396		cc			INT $0x3		
  0x1400c5397		cc			INT $0x3		
  0x1400c5398		cc			INT $0x3		
  0x1400c5399		cc			INT $0x3		
  0x1400c539a		cc			INT $0x3		
  0x1400c539b		cc			INT $0x3		
  0x1400c539c		cc			INT $0x3		
  0x1400c539d		cc			INT $0x3		
  0x1400c539e		cc			INT $0x3		
  0x1400c539f		cc			INT $0x3		
