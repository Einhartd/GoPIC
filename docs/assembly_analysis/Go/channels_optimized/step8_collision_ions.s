// =============================================================================
// SYMBOL: Step8CollisionIons
// =============================================================================

TEXT gopic.(*SimulationState).Step8CollisionIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/simulation_null.go
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x1400c54c0		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c54c4		7658			JBE 0x1400c551e		
  0x1400c54c6		55			PUSHQ BP		
  0x1400c54c7		4889e5			MOVQ SP, BP		
  0x1400c54ca		4883ec10		SUBQ $0x10, SP		
	if (t%N_SUB) != 0 || sim.N_i == 0 {
  0x1400c54ce		48b9cdcccccccccccccc	MOVQ $0xcccccccccccccccd, CX	
  0x1400c54d8		480fafd9		IMULQ CX, BX			
  0x1400c54dc		48b99899999999999919	MOVQ $0x1999999999999998, CX	
  0x1400c54e6		4801d9			ADDQ BX, CX			
  0x1400c54e9		48c1c13e		ROLQ $0x3e, CX			
  0x1400c54ed		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x1400c54f7		4839ca			CMPQ DX, CX			
  0x1400c54fa		720c			JB 0x1400c5508			
  0x1400c54fc		8400			TESTB AL, 0(AX)			
  0x1400c54fe		4883b8c87e560300	CMPQ 0x3567ec8(AX), $0x0	
  0x1400c5506		7506			JNE 0x1400c550e			
		return
  0x1400c5508		4883c410		ADDQ $0x10, SP		
  0x1400c550c		5d			POPQ BP			
  0x1400c550d		c3			RET			
	sim.broadcastAndWait(CmdCollisionsI)
  0x1400c550e		bb05000000		MOVL $0x5, BX						
  0x1400c5513		e868e3ffff		CALL gopic.(*SimulationState).broadcastAndWait(SB)	
}
  0x1400c5518		4883c410		ADDQ $0x10, SP		
  0x1400c551c		5d			POPQ BP			
  0x1400c551d		c3			RET			
func (sim *SimulationState) Step8CollisionIons(t int) {
  0x1400c551e		4889442408		MOVQ AX, 0x8(SP)					
  0x1400c5523		48895c2410		MOVQ BX, 0x10(SP)					
  0x1400c5528		e81371fbff		CALL runtime.morestack_noctxt.abi0(SB)			
  0x1400c552d		488b442408		MOVQ 0x8(SP), AX					
  0x1400c5532		488b5c2410		MOVQ 0x10(SP), BX					
  0x1400c5537		eb87			JMP gopic.(*SimulationState).Step8CollisionIons(SB)	

  0x1400c5539		cc			INT $0x3		
  0x1400c553a		cc			INT $0x3		
  0x1400c553b		cc			INT $0x3		
  0x1400c553c		cc			INT $0x3		
  0x1400c553d		cc			INT $0x3		
  0x1400c553e		cc			INT $0x3		
  0x1400c553f		cc			INT $0x3		


