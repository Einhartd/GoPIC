// =============================================================================
// SYMBOL: Step4MoveAndBoundariesIons
// =============================================================================

TEXT gopic.(*SimulationState).Step4MoveAndBoundariesIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_optimized/simulation.go
func (sim *SimulationState) Step4MoveAndBoundariesIons(t_index, t int) {
  0x1400c41e0		493b6610		CMPQ SP, 0x10(R14)	
  0x1400c41e4		0f8641010000		JBE 0x1400c432b		
  0x1400c41ea		55			PUSHQ BP		
  0x1400c41eb		4889e5			MOVQ SP, BP		
  0x1400c41ee		4883ec10		SUBQ $0x10, SP		
	if (t % N_SUB) != 0 {
  0x1400c41f2		48bacdcccccccccccccc	MOVQ $0xcccccccccccccccd, DX	
  0x1400c41fc		480fafca		IMULQ DX, CX			
  0x1400c4200		48ba9899999999999919	MOVQ $0x1999999999999998, DX	
  0x1400c420a		4801d1			ADDQ DX, CX			
  0x1400c420d		48c1c13e		ROLQ $0x3e, CX			
  0x1400c4211		48bacccccccccccccc0c	MOVQ $0xccccccccccccccc, DX	
  0x1400c421b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x1400c4220		4839ca			CMPQ DX, CX			
  0x1400c4223		722d			JB 0x1400c4252			
  0x1400c4225		4889442420		MOVQ AX, 0x20(SP)		
  0x1400c422a		48895c2428		MOVQ BX, 0x28(SP)		
	sim.broadcastAndWait(CmdMoveIonsAndBoundaries)
  0x1400c422f		bb03000000		MOVL $0x3, BX						
  0x1400c4234		e847f6ffff		CALL gopic.(*SimulationState).broadcastAndWait(SB)	
	if sim.Measurement_mode {
  0x1400c4239		488b4c2420		MOVQ 0x20(SP), CX		
  0x1400c423e		8401			TESTB AL, 0(CX)			
  0x1400c4240		80b9e02dba0700		CMPB 0x7ba2de0(CX), $0x0	
  0x1400c4247		740f			JE 0x1400c4258			
  0x1400c4249		31c0			XORL AX, AX			
  0x1400c424b		488b542428		MOVQ 0x28(SP), DX		
  0x1400c4250		eb0f			JMP 0x1400c4261			
		return
  0x1400c4252		4883c410		ADDQ $0x10, SP		
  0x1400c4256		5d			POPQ BP			
  0x1400c4257		c3			RET			
}
  0x1400c4258		4883c410		ADDQ $0x10, SP		
  0x1400c425c		5d			POPQ BP			
  0x1400c425d		c3			RET			
		for w := 0; w < sim.NumWorkers; w++ {
  0x1400c425e		48ffc0			INCQ AX			
  0x1400c4261		483981482eba07		CMPQ 0x7ba2e48(CX), AX	
  0x1400c4268		7eee			JLE 0x1400c4258		
			diag := &sim.WorkerIDiag[w]
  0x1400c426a		488b5950		MOVQ 0x50(CX), BX	
  0x1400c426e		4839d8			CMPQ AX, BX		
  0x1400c4271		0f83ae000000		JAE 0x1400c4325		
  0x1400c4277		488b5948		MOVQ 0x48(CX), BX	
  0x1400c427b		4869f040320000		IMULQ $0x3240, AX, SI	
			for p := 0; p < N_G; p++ {
  0x1400c4282		31ff			XORL DI, DI		
  0x1400c4284		eb69			JMP 0x1400c42ef		
				sim.Counter_i_xt[p][t_index] += diag.counter_i[p]
  0x1400c4286		4c8d1433		LEAQ 0(BX)(SI*1), R10		
  0x1400c428a		f2410f1004fa		MOVSD_XMM 0(R10)(DI*8), X0	
  0x1400c4290		f2410f5804d1		ADDSD 0(R9)(DX*8), X0		
  0x1400c4296		f2410f1104d1		MOVSD_XMM X0, 0(R9)(DX*8)	
				sim.Ui_xt[p][t_index] += diag.ui[p]
  0x1400c429c		4e8d0c01		LEAQ 0(CX)(R8*1), R9		
  0x1400c42a0		4d8d8980855807		LEAQ 0x7588580(R9), R9		
  0x1400c42a7		4c8d1433		LEAQ 0(BX)(SI*1), R10		
  0x1400c42ab		4d8d92800c0000		LEAQ 0xc80(R10), R10		
  0x1400c42b2		f2410f1004fa		MOVSD_XMM 0(R10)(DI*8), X0	
  0x1400c42b8		f2410f5804d1		ADDSD 0(R9)(DX*8), X0		
  0x1400c42be		f2410f1104d1		MOVSD_XMM X0, 0(R9)(DX*8)	
				sim.Meanei_xt[p][t_index] += diag.meanei[p]
  0x1400c42c4		4e8d0401		LEAQ 0(CX)(R8*1), R8		
  0x1400c42c8		4d8d80801d9307		LEAQ 0x7931d80(R8), R8		
  0x1400c42cf		4c8d0c33		LEAQ 0(BX)(SI*1), R9		
  0x1400c42d3		4d8d8900190000		LEAQ 0x1900(R9), R9		
  0x1400c42da		f2410f1004f9		MOVSD_XMM 0(R9)(DI*8), X0	
  0x1400c42e0		f2410f5804d0		ADDSD 0(R8)(DX*8), X0		
  0x1400c42e6		f2410f1104d0		MOVSD_XMM X0, 0(R8)(DX*8)	
			for p := 0; p < N_G; p++ {
  0x1400c42ec		48ffc7			INCQ DI			
  0x1400c42ef		4881ff90010000		CMPQ DI, $0x190		
  0x1400c42f6		0f8d62ffffff		JGE 0x1400c425e		
				sim.Counter_i_xt[p][t_index] += diag.counter_i[p]
  0x1400c42fc		4c69c740060000		IMULQ $0x640, DI, R8		
  0x1400c4303		4e8d0c01		LEAQ 0(CX)(R8*1), R9		
  0x1400c4307		4d8d8980a5a607		LEAQ 0x7a6a580(R9), R9		
  0x1400c430e		4881fac8000000		CMPQ DX, $0xc8			
  0x1400c4315		0f826bffffff		JB 0x1400c4286			
  0x1400c431b		b8c8000000		MOVL $0xc8, AX			
  0x1400c4320		e85ba1fbff		CALL runtime.panicBounds(SB)	
			diag := &sim.WorkerIDiag[w]
  0x1400c4325		e856a1fbff		CALL runtime.panicBounds(SB)	
  0x1400c432a		90			NOPL				
func (sim *SimulationState) Step4MoveAndBoundariesIons(t_index, t int) {
  0x1400c432b		4889442408		MOVQ AX, 0x8(SP)						
  0x1400c4330		48895c2410		MOVQ BX, 0x10(SP)						
  0x1400c4335		48894c2418		MOVQ CX, 0x18(SP)						
  0x1400c433a		e80183fbff		CALL runtime.morestack_noctxt.abi0(SB)				
  0x1400c433f		488b442408		MOVQ 0x8(SP), AX						
  0x1400c4344		488b5c2410		MOVQ 0x10(SP), BX						
  0x1400c4349		488b4c2418		MOVQ 0x18(SP), CX						
  0x1400c434e		e98dfeffff		JMP gopic.(*SimulationState).Step4MoveAndBoundariesIons(SB)	

  0x1400c4353		cc			INT $0x3		
  0x1400c4354		cc			INT $0x3		
  0x1400c4355		cc			INT $0x3		
  0x1400c4356		cc			INT $0x3		
  0x1400c4357		cc			INT $0x3		
  0x1400c4358		cc			INT $0x3		
  0x1400c4359		cc			INT $0x3		
  0x1400c435a		cc			INT $0x3		
  0x1400c435b		cc			INT $0x3		
  0x1400c435c		cc			INT $0x3		
  0x1400c435d		cc			INT $0x3		
  0x1400c435e		cc			INT $0x3		
  0x1400c435f		cc			INT $0x3		


