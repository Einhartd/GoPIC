// =============================================================================
// SYMBOL: procyield
// =============================================================================

TEXT runtime.procyieldAsm.abi0(SB) C:/Program Files/Go/src/runtime/asm_amd64.s

  0x14007dd40		8b442408		MOVL 0x8(SP), AX	

  0x14007dd44		85c0			TESTL AX, AX		

  0x14007dd46		7407			JE 0x14007dd4f		

  0x14007dd48		f390			PAUSE			

  0x14007dd4a		83e801			SUBL $0x1, AX		

  0x14007dd4d		75f9			JNE 0x14007dd48		

  0x14007dd4f		c3			RET			

  0x14007dd50		cc			INT $0x3		
  0x14007dd51		cc			INT $0x3		
  0x14007dd52		cc			INT $0x3		
  0x14007dd53		cc			INT $0x3		
  0x14007dd54		cc			INT $0x3		
  0x14007dd55		cc			INT $0x3		
  0x14007dd56		cc			INT $0x3		
  0x14007dd57		cc			INT $0x3		
  0x14007dd58		cc			INT $0x3		
  0x14007dd59		cc			INT $0x3		
  0x14007dd5a		cc			INT $0x3		
  0x14007dd5b		cc			INT $0x3		
  0x14007dd5c		cc			INT $0x3		
  0x14007dd5d		cc			INT $0x3		
  0x14007dd5e		cc			INT $0x3		
  0x14007dd5f		cc			INT $0x3		

TEXT gopic.procyield.abi0(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/procyield_amd64.s

  0x1400c98e0		8b442408		MOVL 0x8(SP), AX	

  0x1400c98e4		f390			PAUSE			

  0x1400c98e6		83e801			SUBL $0x1, AX		

  0x1400c98e9		75f9			JNE 0x1400c98e4		

  0x1400c98eb		c3			RET			

  0x1400c98ec		cc			INT $0x3		
  0x1400c98ed		cc			INT $0x3		
  0x1400c98ee		cc			INT $0x3		
  0x1400c98ef		cc			INT $0x3		
  0x1400c98f0		cc			INT $0x3		
  0x1400c98f1		cc			INT $0x3		
  0x1400c98f2		cc			INT $0x3		
  0x1400c98f3		cc			INT $0x3		
  0x1400c98f4		cc			INT $0x3		
  0x1400c98f5		cc			INT $0x3		
  0x1400c98f6		cc			INT $0x3		
  0x1400c98f7		cc			INT $0x3		
  0x1400c98f8		cc			INT $0x3		
  0x1400c98f9		cc			INT $0x3		
  0x1400c98fa		cc			INT $0x3		
  0x1400c98fb		cc			INT $0x3		
  0x1400c98fc		cc			INT $0x3		
  0x1400c98fd		cc			INT $0x3		
  0x1400c98fe		cc			INT $0x3		
  0x1400c98ff		cc			INT $0x3		


// =============================================================================
// SYMBOL: broadcastAndWait
// =============================================================================

TEXT gopic.(*SimulationState).broadcastAndWait(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/simulation.go
func (sim *SimulationState) broadcastAndWait(cmd WorkerCommand) {
  0x1400c3880		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c3884		0f8623010000		JBE 0x1400c39ad		
  0x1400c388a		55			PUSHQ BP		
  0x1400c388b		4889e5			MOVQ SP, BP		
  0x1400c388e		4883ec38		SUBQ $0x38, SP		
	sim.Barrier.workerDone[0].val.Store(target)
  0x1400c3892		4889442448		MOVQ AX, 0x48(SP)	
	sim.Barrier.cmd.Store(int32(cmd))
  0x1400c3897		8400			TESTB AL, 0(AX)		
  0x1400c3899		488b90502eba07		MOVQ 0x7ba2e50(AX), DX	
  0x1400c38a0		4889d9			MOVQ BX, CX		
  0x1400c38a3		875a08			XCHGL BX, 0x8(DX)	
	target := sim.Barrier.step.Add(1)
  0x1400c38a6		488b90502eba07		MOVQ 0x7ba2e50(AX), DX	
  0x1400c38ad		be01000000		MOVL $0x1, SI		
  0x1400c38b2		f0480fc17210		LOCK XADDQ SI, 0x10(DX)	
func (x *Int64) Add(delta int64) (new int64) { return AddInt64(&x.v, delta) }
  0x1400c38b8		4889742430		MOVQ SI, 0x30(SP)	
	sim.executeWorkerTask(0, cmd)
  0x1400c38bd		31db			XORL BX, BX						
  0x1400c38bf		90			NOPL							
  0x1400c38c0		e8bb2a0000		CALL gopic.(*SimulationState).executeWorkerTask(SB)	
	sim.Barrier.workerDone[0].val.Store(target)
  0x1400c38c5		488b542448		MOVQ 0x48(SP), DX	
  0x1400c38ca		488bb2502eba07		MOVQ 0x7ba2e50(DX), SI	
  0x1400c38d1		48837e2000		CMPQ 0x20(SI), $0x0	
  0x1400c38d6		0f86cb000000		JBE 0x1400c39a7		
  0x1400c38dc		488b4618		MOVQ 0x18(SI), AX	
func (x *Int64) Add(delta int64) (new int64) { return AddInt64(&x.v, delta) }
  0x1400c38e0		488b4c2430		MOVQ 0x30(SP), CX	
  0x1400c38e5		48ffc1			INCQ CX			
  0x1400c38e8		48894c2430		MOVQ CX, 0x30(SP)	
func (x *Int64) Store(val int64) { StoreInt64(&x.v, val) }
  0x1400c38ed		4889cb			MOVQ CX, BX		
  0x1400c38f0		488708			XCHGQ CX, 0(AX)		
	sim.Barrier.workerDone[0].val.Store(target)
  0x1400c38f3		b801000000		MOVL $0x1, AX		
  0x1400c38f8		eb06			JMP 0x1400c3900		
	for i := 1; i < sim.NumWorkers; i++ {
  0x1400c38fa		488d4101		LEAQ 0x1(CX), AX	
  0x1400c38fe		6690			NOPW			
  0x1400c3900		483982482eba07		CMPQ 0x7ba2e48(DX), AX	
  0x1400c3907		0f8e8f000000		JLE 0x1400c399c		
  0x1400c390d		4889442420		MOVQ AX, 0x20(SP)	
		for sim.Barrier.workerDone[i].val.Load() < target {
  0x1400c3912		4889c1			MOVQ AX, CX		
  0x1400c3915		48c1e006		SHLQ $0x6, AX		
  0x1400c3919		4889442428		MOVQ AX, 0x28(SP)	
  0x1400c391e		31f6			XORL SI, SI		
  0x1400c3920		eb17			JMP 0x1400c3939		
  0x1400c3922		488b4c2420		MOVQ 0x20(SP), CX	
  0x1400c3927		488b542448		MOVQ 0x48(SP), DX	
  0x1400c392c		488b5c2430		MOVQ 0x30(SP), BX	
  0x1400c3931		4889c6			MOVQ AX, SI		
func (x *Int64) Load() int64 { return LoadInt64(&x.v) }
  0x1400c3934		488b442428		MOVQ 0x28(SP), AX	
		for sim.Barrier.workerDone[i].val.Load() < target {
  0x1400c3939		488bba502eba07		MOVQ 0x7ba2e50(DX), DI	
  0x1400c3940		4c8b4720		MOVQ 0x20(DI), R8	
  0x1400c3944		4c39c1			CMPQ CX, R8		
  0x1400c3947		7359			JAE 0x1400c39a2		
  0x1400c3949		488b7f18		MOVQ 0x18(DI), DI	
func (x *Int64) Load() int64 { return LoadInt64(&x.v) }
  0x1400c394d		4801c7			ADDQ AX, DI		
  0x1400c3950		488b3f			MOVQ 0(DI), DI		
		for sim.Barrier.workerDone[i].val.Load() < target {
  0x1400c3953		4839df			CMPQ DI, BX		
  0x1400c3956		7da2			JGE 0x1400c38fa		
  0x1400c3958		4889742418		MOVQ SI, 0x18(SP)	
			procyield(30)
  0x1400c395d		c704241e000000		MOVL $0x1e, 0(SP)		
  0x1400c3964		e8775f0000		CALL gopic.procyield.abi0(SB)	
  0x1400c3969		450f57ff		XORPS X15, X15			
  0x1400c396d		4c8b35dc061600		MOVQ runtime.tls_g(SB), R14	
  0x1400c3974		654d8b36		MOVQ GS:0(R14), R14		
  0x1400c3978		4d8b36			MOVQ 0(R14), R14		
			spins++
  0x1400c397b		488b442418		MOVQ 0x18(SP), AX	
  0x1400c3980		48ffc0			INCQ AX			
			if spins > 200 {
  0x1400c3983		483dc8000000		CMPQ AX, $0xc8		
  0x1400c3989		7e97			JLE 0x1400c3922		
				runtime.Gosched()
  0x1400c398b		90			NOPL			
	mcall(gosched_m)
  0x1400c398c		488d0525c51000		LEAQ go:funcdesc+24(SB), AX	
  0x1400c3993		e8e88afbff		CALL runtime.mcall(SB)		
  0x1400c3998		31c0			XORL AX, AX			
		for sim.Barrier.workerDone[i].val.Load() < target {
  0x1400c399a		eb86			JMP 0x1400c3922		
}
  0x1400c399c		4883c438		ADDQ $0x38, SP		
  0x1400c39a0		5d			POPQ BP			
  0x1400c39a1		c3			RET			
		for sim.Barrier.workerDone[i].val.Load() < target {
  0x1400c39a2		e8d9aafbff		CALL runtime.panicBounds(SB)	
	sim.Barrier.workerDone[0].val.Store(target)
  0x1400c39a7		e8d4aafbff		CALL runtime.panicBounds(SB)	
  0x1400c39ac		90			NOPL				
func (sim *SimulationState) broadcastAndWait(cmd WorkerCommand) {
  0x1400c39ad		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c39b2		48895c2410		MOVQ BX, 0x10(SP)					
  0x1400c39b7		e8848cfbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c39bc		488b442408		MOVQ 0x8(SP), AX					
  0x1400c39c1		488b5c2410		MOVQ 0x10(SP), BX					
  0x1400c39c6		e9b5feffff		JMP gopic.(*SimulationState).broadcastAndWait(SB)	

  0x1400c39cb		cc			INT $0x3		
  0x1400c39cc		cc			INT $0x3		
  0x1400c39cd		cc			INT $0x3		
  0x1400c39ce		cc			INT $0x3		
  0x1400c39cf		cc			INT $0x3		
  0x1400c39d0		cc			INT $0x3		
  0x1400c39d1		cc			INT $0x3		
  0x1400c39d2		cc			INT $0x3		
  0x1400c39d3		cc			INT $0x3		
  0x1400c39d4		cc			INT $0x3		
  0x1400c39d5		cc			INT $0x3		
  0x1400c39d6		cc			INT $0x3		
  0x1400c39d7		cc			INT $0x3		
  0x1400c39d8		cc			INT $0x3		
  0x1400c39d9		cc			INT $0x3		
  0x1400c39da		cc			INT $0x3		
  0x1400c39db		cc			INT $0x3		
  0x1400c39dc		cc			INT $0x3		
  0x1400c39dd		cc			INT $0x3		
  0x1400c39de		cc			INT $0x3		
  0x1400c39df		cc			INT $0x3		


// =============================================================================
// SYMBOL: startWorker
// =============================================================================

TEXT gopic.(*SimulationState).startWorker(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/worker.go
func (sim *SimulationState) startWorker(workerID int) {
  0x1400c6240		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c6244		0f8613010000		JBE 0x1400c635d		
  0x1400c624a		55			PUSHQ BP		
  0x1400c624b		4889e5			MOVQ SP, BP		
  0x1400c624e		4883ec28		SUBQ $0x28, SP		
	for {
  0x1400c6252		4889442438		MOVQ AX, 0x38(SP)	
  0x1400c6257		48895c2440		MOVQ BX, 0x40(SP)	
  0x1400c625c		b901000000		MOVL $0x1, CX		
  0x1400c6261		eb1c			JMP 0x1400c627f		
		sim.Barrier.workerDone[workerID].val.Store(myStep)
  0x1400c6263		488b5218		MOVQ 0x18(DX), DX	
  0x1400c6267		4889de			MOVQ BX, SI		
  0x1400c626a		48c1e606		SHLQ $0x6, SI		
func (x *Int64) Store(val int64) { StoreInt64(&x.v, val) }
  0x1400c626e		4801f2			ADDQ SI, DX		
  0x1400c6271		488b4c2420		MOVQ 0x20(SP), CX	
  0x1400c6276		4889ce			MOVQ CX, SI		
  0x1400c6279		488732			XCHGQ SI, 0(DX)		
		myStep++
  0x1400c627c		48ffc1			INCQ CX			
  0x1400c627f		48894c2420		MOVQ CX, 0x20(SP)	
  0x1400c6284		31d2			XORL DX, DX		
		for sim.Barrier.step.Load() < myStep {
  0x1400c6286		eb12			JMP 0x1400c629a		
  0x1400c6288		488b4c2420		MOVQ 0x20(SP), CX	
		sim.executeWorkerTask(workerID, cmd)
  0x1400c628d		488b5c2440		MOVQ 0x40(SP), BX	
		for sim.Barrier.step.Load() < myStep {
  0x1400c6292		4889c2			MOVQ AX, DX		
  0x1400c6295		488b442438		MOVQ 0x38(SP), AX	
  0x1400c629a		8400			TESTB AL, 0(AX)		
  0x1400c629c		488bb0502eba07		MOVQ 0x7ba2e50(AX), SI	
  0x1400c62a3		488b7610		MOVQ 0x10(SI), SI	
  0x1400c62a7		4839ce			CMPQ SI, CX		
  0x1400c62aa		7d44			JGE 0x1400c62f0		
  0x1400c62ac		4889542418		MOVQ DX, 0x18(SP)	
			procyield(30)
  0x1400c62b1		c704241e000000		MOVL $0x1e, 0(SP)		
  0x1400c62b8		e823360000		CALL gopic.procyield.abi0(SB)	
  0x1400c62bd		450f57ff		XORPS X15, X15			
  0x1400c62c1		4c8b3588dd1500		MOVQ runtime.tls_g(SB), R14	
  0x1400c62c8		654d8b36		MOVQ GS:0(R14), R14		
  0x1400c62cc		4d8b36			MOVQ 0(R14), R14		
			spins++
  0x1400c62cf		488b442418		MOVQ 0x18(SP), AX	
  0x1400c62d4		48ffc0			INCQ AX			
			if spins > 200 {
  0x1400c62d7		483dc8000000		CMPQ AX, $0xc8		
  0x1400c62dd		7ea9			JLE 0x1400c6288		
				runtime.Gosched()
  0x1400c62df		90			NOPL			
	mcall(gosched_m)
  0x1400c62e0		488d05d19b1000		LEAQ go:funcdesc+24(SB), AX	
  0x1400c62e7		e89461fbff		CALL runtime.mcall(SB)		
  0x1400c62ec		31c0			XORL AX, AX			
		for sim.Barrier.step.Load() < myStep {
  0x1400c62ee		eb98			JMP 0x1400c6288		
		cmd := WorkerCommand(sim.Barrier.cmd.Load())
  0x1400c62f0		488b90502eba07		MOVQ 0x7ba2e50(AX), DX	
  0x1400c62f7		8b5208			MOVL 0x8(DX), DX	
  0x1400c62fa		4863d2			MOVSXD DX, DX		
  0x1400c62fd		0f1f00			NOPL 0(AX)		
		if cmd == CmdStop {
  0x1400c6300		4883fa06		CMPQ DX, $0x6		
  0x1400c6304		7428			JE 0x1400c632e		
		sim.executeWorkerTask(workerID, cmd)
  0x1400c6306		4889d1			MOVQ DX, CX						
  0x1400c6309		e872000000		CALL gopic.(*SimulationState).executeWorkerTask(SB)	
		sim.Barrier.workerDone[workerID].val.Store(myStep)
  0x1400c630e		488b442438		MOVQ 0x38(SP), AX	
  0x1400c6313		488b90502eba07		MOVQ 0x7ba2e50(AX), DX	
  0x1400c631a		488b7220		MOVQ 0x20(DX), SI	
  0x1400c631e		488b5c2440		MOVQ 0x40(SP), BX	
  0x1400c6323		4839f3			CMPQ BX, SI		
  0x1400c6326		0f8237ffffff		JB 0x1400c6263		
  0x1400c632c		eb29			JMP 0x1400c6357		
			sim.Barrier.workerDone[workerID].val.Store(myStep)
  0x1400c632e		488b80502eba07		MOVQ 0x7ba2e50(AX), AX	
  0x1400c6335		488b5020		MOVQ 0x20(AX), DX	
  0x1400c6339		4839d3			CMPQ BX, DX		
  0x1400c633c		7314			JAE 0x1400c6352		
  0x1400c633e		488b4018		MOVQ 0x18(AX), AX	
  0x1400c6342		48c1e306		SHLQ $0x6, BX		
func (x *Int64) Store(val int64) { StoreInt64(&x.v, val) }
  0x1400c6346		4801d8			ADDQ BX, AX		
  0x1400c6349		488708			XCHGQ CX, 0(AX)		
			return
  0x1400c634c		4883c428		ADDQ $0x28, SP		
  0x1400c6350		5d			POPQ BP			
  0x1400c6351		c3			RET			
			sim.Barrier.workerDone[workerID].val.Store(myStep)
  0x1400c6352		e82981fbff		CALL runtime.panicBounds(SB)	
		sim.Barrier.workerDone[workerID].val.Store(myStep)
  0x1400c6357		e82481fbff		CALL runtime.panicBounds(SB)	
  0x1400c635c		90			NOPL				
func (sim *SimulationState) startWorker(workerID int) {
  0x1400c635d		4889442408		MOVQ AX, 0x8(SP)				
  0x1400c6362		48895c2410		MOVQ BX, 0x10(SP)				
  0x1400c6367		e8d462fbff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x1400c636c		488b442408		MOVQ 0x8(SP), AX				
  0x1400c6371		488b5c2410		MOVQ 0x10(SP), BX				
  0x1400c6376		e9c5feffff		JMP gopic.(*SimulationState).startWorker(SB)	

  0x1400c637b		cc			INT $0x3		
  0x1400c637c		cc			INT $0x3		
  0x1400c637d		cc			INT $0x3		
  0x1400c637e		cc			INT $0x3		
  0x1400c637f		cc			INT $0x3		


