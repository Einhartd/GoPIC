// =============================================================================
// SYMBOL: executeWorkerTask
// =============================================================================

TEXT gopic.(*SimulationState).executeWorkerTask(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/worker.go
func (sim *SimulationState) executeWorkerTask(workerID int, cmd WorkerCommand) {
  0x1400c6380		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c6384		7667			JBE 0x1400c63ed		
  0x1400c6386		55			PUSHQ BP		
  0x1400c6387		4889e5			MOVQ SP, BP		
  0x1400c638a		4883ec10		SUBQ $0x10, SP		
	switch cmd {
  0x1400c638e		4883f902		CMPQ CX, $0x2		
	case CmdMoveElectronsAndBoundaries:
  0x1400c6392		7f2c			JG 0x1400c63c0		
	case CmdComputeEDensity:
  0x1400c6394		4885c9			TESTQ CX, CX		
  0x1400c6397		741b			JE 0x1400c63b4		
	case CmdComputeIDensity:
  0x1400c6399		4883f901		CMPQ CX, $0x1		
  0x1400c639d		740e			JE 0x1400c63ad		
  0x1400c639f		90			NOPL			
	switch cmd {
  0x1400c63a0		4883f902		CMPQ CX, $0x2		
	case CmdMoveElectronsAndBoundaries:
  0x1400c63a4		7541			JNE 0x1400c63e7		
		sim.workerMoveElectrons(workerID)
  0x1400c63a6		e835030000		CALL gopic.(*SimulationState).workerMoveElectrons(SB)	
  0x1400c63ab		eb3a			JMP 0x1400c63e7						
		sim.workerComputeIDensity(workerID)
  0x1400c63ad		e8ce010000		CALL gopic.(*SimulationState).workerComputeIDensity(SB)	
  0x1400c63b2		eb33			JMP 0x1400c63e7						
		sim.workerComputeEDensity(workerID)
  0x1400c63b4		e867000000		CALL gopic.(*SimulationState).workerComputeEDensity(SB)	
  0x1400c63b9		eb2c			JMP 0x1400c63e7						
  0x1400c63bb		0f1f440000		NOPL 0(AX)(AX*1)					
	case CmdMoveIonsAndBoundaries:
  0x1400c63c0		4883f903		CMPQ CX, $0x3		
  0x1400c63c4		741c			JE 0x1400c63e2		
	case CmdCollisionsE:
  0x1400c63c6		4883f904		CMPQ CX, $0x4		
  0x1400c63ca		740d			JE 0x1400c63d9		
	case CmdCollisionsI:
  0x1400c63cc		4883f905		CMPQ CX, $0x5		
  0x1400c63d0		7515			JNE 0x1400c63e7		
		sim.workerCollisionsI(workerID)
  0x1400c63d2		e8092e0000		CALL gopic.(*SimulationState).workerCollisionsI(SB)	
  0x1400c63d7		eb0e			JMP 0x1400c63e7						
		sim.workerCollisionsE(workerID)
  0x1400c63d9		e8c22a0000		CALL gopic.(*SimulationState).workerCollisionsE(SB)	
  0x1400c63de		6690			NOPW							
  0x1400c63e0		eb05			JMP 0x1400c63e7						
		sim.workerMoveIons(workerID)
  0x1400c63e2		e899140000		CALL gopic.(*SimulationState).workerMoveIons(SB)	
}
  0x1400c63e7		4883c410		ADDQ $0x10, SP		
  0x1400c63eb		5d			POPQ BP			
  0x1400c63ec		c3			RET			
func (sim *SimulationState) executeWorkerTask(workerID int, cmd WorkerCommand) {
  0x1400c63ed		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c63f2		48895c2410		MOVQ BX, 0x10(SP)					
  0x1400c63f7		48894c2418		MOVQ CX, 0x18(SP)					
  0x1400c63fc		0f1f4000		NOPL 0(AX)						
  0x1400c6400		e83b62fbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c6405		488b442408		MOVQ 0x8(SP), AX					
  0x1400c640a		488b5c2410		MOVQ 0x10(SP), BX					
  0x1400c640f		488b4c2418		MOVQ 0x18(SP), CX					
  0x1400c6414		e967ffffff		JMP gopic.(*SimulationState).executeWorkerTask(SB)	

  0x1400c6419		cc			INT $0x3		
  0x1400c641a		cc			INT $0x3		
  0x1400c641b		cc			INT $0x3		
  0x1400c641c		cc			INT $0x3		
  0x1400c641d		cc			INT $0x3		
  0x1400c641e		cc			INT $0x3		
  0x1400c641f		cc			INT $0x3		


