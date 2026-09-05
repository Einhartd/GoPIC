TEXT gopic.(*SimulationState).Step4MoveIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
func (sim *SimulationState) Step4MoveIons(t_index, t int) {
  0x4bd9a0		493b6610		CMPQ SP, 0x10(R14)	
  0x4bd9a4		0f86a4020000		JBE 0x4bdc4e		
  0x4bd9aa		55			PUSHQ BP		
  0x4bd9ab		4889e5			MOVQ SP, BP		
  0x4bd9ae		4883ec58		SUBQ $0x58, SP		
	if (t % N_SUB) != 0 {
  0x4bd9b2		48bacdcccccccccccccc	MOVQ $0xcccccccccccccccd, DX	
  0x4bd9bc		480fafd1		IMULQ CX, DX			
  0x4bd9c0		48be9899999999999919	MOVQ $0x1999999999999998, SI	
  0x4bd9ca		4801f2			ADDQ SI, DX			
  0x4bd9cd		48c1c23e		ROLQ $0x3e, DX			
  0x4bd9d1		48becccccccccccccc0c	MOVQ $0xccccccccccccccc, SI	
  0x4bd9db		0f1f440000		NOPL 0(AX)(AX*1)		
  0x4bd9e0		4839d6			CMPQ SI, DX			
  0x4bd9e3		7279			JB 0x4bda5e			
  0x4bd9e5		4889442468		MOVQ AX, 0x68(SP)		
  0x4bd9ea		48895c2470		MOVQ BX, 0x70(SP)		
	numWorkers := sim.NumWorkers
  0x4bd9ef		8400			TESTB AL, 0(AX)		
  0x4bd9f1		488b90e82dba07		MOVQ 0x7ba2de8(AX), DX	
  0x4bd9f8		4889542428		MOVQ DX, 0x28(SP)	
	var wg sync.WaitGroup
  0x4bd9fd		b810000000		MOVL $0x10, AX				
  0x4bda02		488d1d0f880f00		LEAQ 0xf880f(IP), BX			
  0x4bda09		b901000000		MOVL $0x1, CX				
  0x4bda0e		e8ed0df6ff		CALL runtime.mallocgcSmallNoScanSC2(SB)	
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4bda13		488b542468		MOVQ 0x68(SP), DX	
  0x4bda18		488bb2c87e5603		MOVQ 0x3567ec8(DX), SI	
  0x4bda1f		488b7c2428		MOVQ 0x28(SP), DI	
  0x4bda24		488d343e		LEAQ 0(SI)(DI*1), SI	
  0x4bda28		488d76ff		LEAQ -0x1(SI), SI	
  0x4bda2c		4885ff			TESTQ DI, DI		
  0x4bda2f		0f8413020000		JE 0x4bdc48		
	var wg sync.WaitGroup
  0x4bda35		4889442450		MOVQ AX, 0x50(SP)	
  0x4bda3a		4889c1			MOVQ AX, CX		
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4bda3d		4889f0			MOVQ SI, AX		
	if (t % N_SUB) != 0 {
  0x4bda40		4889d3			MOVQ DX, BX		
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4bda43		4883ffff		CMPQ DI, $-0x1		
  0x4bda47		7507			JNE 0x4bda50		
  0x4bda49		48f7d8			NEGQ AX			
  0x4bda4c		31d2			XORL DX, DX		
  0x4bda4e		eb05			JMP 0x4bda55		
  0x4bda50		4899			CQO			
  0x4bda52		48f7ff			IDIVQ DI		
  0x4bda55		4889442438		MOVQ AX, 0x38(SP)	
	for w := range numWorkers {
  0x4bda5a		31d2			XORL DX, DX		
  0x4bda5c		eb0c			JMP 0x4bda6a		
		return
  0x4bda5e		4883c458		ADDQ $0x58, SP		
  0x4bda62		5d			POPQ BP			
  0x4bda63		c3			RET			
		start := w * chunkSize
  0x4bda64		4c89c8			MOVQ R9, AX		
	for w := range numWorkers {
  0x4bda67		4c89c2			MOVQ R8, DX		
  0x4bda6a		4839fa			CMPQ DX, DI		
  0x4bda6d		0f8dc4000000		JGE 0x4bdb37		
		start := w * chunkSize
  0x4bda73		4889d6			MOVQ DX, SI		
  0x4bda76		480fafd0		IMULQ AX, DX		
		end := min((w+1)*chunkSize, sim.N_i)
  0x4bda7a		4c8d4601		LEAQ 0x1(SI), R8	
  0x4bda7e		4989c1			MOVQ AX, R9		
  0x4bda81		490fafc0		IMULQ R8, AX		
  0x4bda85		4c8b93c87e5603		MOVQ 0x3567ec8(BX), R10	
  0x4bda8c		4939c2			CMPQ R10, AX		
		if start >= end {
  0x4bda8f		490f4cc2		CMOVL R10, AX		
  0x4bda93		4839d0			CMPQ AX, DX		
		end := min((w+1)*chunkSize, sim.N_i)
  0x4bda96		7ecc			JLE 0x4bda64		
	for w := range numWorkers {
  0x4bda98		4889742448		MOVQ SI, 0x48(SP)	
		start := w * chunkSize
  0x4bda9d		4889542420		MOVQ DX, 0x20(SP)	
		end := min((w+1)*chunkSize, sim.N_i)
  0x4bdaa2		4c89442440		MOVQ R8, 0x40(SP)	
		if start >= end {
  0x4bdaa7		4889442430		MOVQ AX, 0x30(SP)	
		wg.Go(func() {
  0x4bdaac		b828000000		MOVL $0x28, AX							
  0x4bdab1		488d1d48ab0f00		LEAQ 0xfab48(IP), BX						
  0x4bdab8		b901000000		MOVL $0x1, CX							
  0x4bdabd		0f1f00			NOPL 0(AX)							
  0x4bdac0		e89bfef5ff		CALL runtime.mallocgcSmallScanNoHeaderSC5(SB)			
  0x4bdac5		488d15742f0000		LEAQ gopic.(*SimulationState).Step4MoveIons.func1(SB), DX	
  0x4bdacc		488910			MOVQ DX, 0(AX)							
  0x4bdacf		833d9a03130000		CMPL runtime.writeBarrier(SB), $0x0				
  0x4bdad6		7508			JNE 0x4bdae0							
  0x4bdad8		488b4c2468		MOVQ 0x68(SP), CX						
  0x4bdadd		eb0e			JMP 0x4bdaed							
  0x4bdadf		90			NOPL								
  0x4bdae0		e85b46fcff		CALL runtime.gcWriteBarrier1(SB)				
  0x4bdae5		488b4c2468		MOVQ 0x68(SP), CX						
  0x4bdaea		49890b			MOVQ CX, 0(R11)							
  0x4bdaed		48894808		MOVQ CX, 0x8(AX)						
  0x4bdaf1		488b4c2448		MOVQ 0x48(SP), CX						
  0x4bdaf6		48894810		MOVQ CX, 0x10(AX)						
  0x4bdafa		488b4c2420		MOVQ 0x20(SP), CX						
  0x4bdaff		48894818		MOVQ CX, 0x18(AX)						
  0x4bdb03		488b4c2430		MOVQ 0x30(SP), CX						
  0x4bdb08		48894820		MOVQ CX, 0x20(AX)						
  0x4bdb0c		4889c3			MOVQ AX, BX							
  0x4bdb0f		488b442450		MOVQ 0x50(SP), AX						
  0x4bdb14		e8a7cbfcff		CALL sync.(*WaitGroup).Go(SB)					
	wg.Wait()
  0x4bdb19		488b4c2450		MOVQ 0x50(SP), CX	
		end := min((w+1)*chunkSize, sim.N_i)
  0x4bdb1e		488b5c2468		MOVQ 0x68(SP), BX	
	for w := range numWorkers {
  0x4bdb23		488b7c2428		MOVQ 0x28(SP), DI	
  0x4bdb28		4c8b442440		MOVQ 0x40(SP), R8	
		start := w * chunkSize
  0x4bdb2d		4c8b4c2438		MOVQ 0x38(SP), R9	
		wg.Go(func() {
  0x4bdb32		e92dffffff		JMP 0x4bda64		
	wg.Wait()
  0x4bdb37		4889c8			MOVQ CX, AX			
  0x4bdb3a		e861cafcff		CALL sync.(*WaitGroup).Wait(SB)	
	if sim.Measurement_mode {
  0x4bdb3f		488b4c2468		MOVQ 0x68(SP), CX		
  0x4bdb44		80b9e02dba0700		CMPB 0x7ba2de0(CX), $0x0	
  0x4bdb4b		740e			JE 0x4bdb5b			
		for w := range numWorkers {
  0x4bdb4d		31c0			XORL AX, AX		
  0x4bdb4f		488b542428		MOVQ 0x28(SP), DX	
  0x4bdb54		488b5c2470		MOVQ 0x70(SP), BX	
  0x4bdb59		eb09			JMP 0x4bdb64		
}
  0x4bdb5b		4883c458		ADDQ $0x58, SP		
  0x4bdb5f		5d			POPQ BP			
  0x4bdb60		c3			RET			
		for w := range numWorkers {
  0x4bdb61		48ffc0			INCQ AX			
  0x4bdb64		4839d0			CMPQ AX, DX		
  0x4bdb67		7df2			JGE 0x4bdb5b		
				sim.Counter_i_xt[p][t_index] += sim.WorkerIDiag[w].counter_i[p]
  0x4bdb69		4869f040320000		IMULQ $0x3240, AX, SI	
			for p := range N_G {
  0x4bdb70		31ff			XORL DI, DI		
  0x4bdb72		eb1e			JMP 0x4bdb92		
				sim.Meanei_xt[p][t_index] += sim.WorkerIDiag[w].meanei[p]
  0x4bdb74		4c8b4948		MOVQ 0x48(CX), R9		
  0x4bdb78		4d8d0c31		LEAQ 0(R9)(SI*1), R9		
  0x4bdb7c		4d8d8900190000		LEAQ 0x1900(R9), R9		
  0x4bdb83		f2410f5804f9		ADDSD 0(R9)(DI*8), X0		
  0x4bdb89		f2410f1104d8		MOVSD_XMM X0, 0(R8)(BX*8)	
			for p := range N_G {
  0x4bdb8f		48ffc7			INCQ DI			
  0x4bdb92		4881ff90010000		CMPQ DI, $0x190		
  0x4bdb99		7dc6			JGE 0x4bdb61		
				sim.Counter_i_xt[p][t_index] += sim.WorkerIDiag[w].counter_i[p]
  0x4bdb9b		4c69c740060000		IMULQ $0x640, DI, R8		
  0x4bdba2		4e8d0c01		LEAQ 0(CX)(R8*1), R9		
  0x4bdba6		4d8d8980a5a607		LEAQ 0x7a6a580(R9), R9		
  0x4bdbad		4881fbc8000000		CMPQ BX, $0xc8			
  0x4bdbb4		0f8384000000		JAE 0x4bdc3e			
  0x4bdbba		4c8b5150		MOVQ 0x50(CX), R10		
  0x4bdbbe		f2410f1004d9		MOVSD_XMM 0(R9)(BX*8), X0	
  0x4bdbc4		4c39d0			CMPQ AX, R10			
  0x4bdbc7		7370			JAE 0x4bdc39			
  0x4bdbc9		4c8b5148		MOVQ 0x48(CX), R10		
  0x4bdbcd		4901f2			ADDQ SI, R10			
  0x4bdbd0		f2410f5804fa		ADDSD 0(R10)(DI*8), X0		
  0x4bdbd6		f2410f1104d9		MOVSD_XMM X0, 0(R9)(BX*8)	
				sim.Ui_xt[p][t_index] += sim.WorkerIDiag[w].ui[p]
  0x4bdbdc		4e8d0c01		LEAQ 0(CX)(R8*1), R9		
  0x4bdbe0		4d8d8980855807		LEAQ 0x7588580(R9), R9		
  0x4bdbe7		4c8b5150		MOVQ 0x50(CX), R10		
  0x4bdbeb		f2410f1004d9		MOVSD_XMM 0(R9)(BX*8), X0	
  0x4bdbf1		4c39d0			CMPQ AX, R10			
  0x4bdbf4		733e			JAE 0x4bdc34			
  0x4bdbf6		4c8b5148		MOVQ 0x48(CX), R10		
  0x4bdbfa		4d8d1432		LEAQ 0(R10)(SI*1), R10		
  0x4bdbfe		4d8d92800c0000		LEAQ 0xc80(R10), R10		
  0x4bdc05		f2410f5804fa		ADDSD 0(R10)(DI*8), X0		
  0x4bdc0b		f2410f1104d9		MOVSD_XMM X0, 0(R9)(BX*8)	
				sim.Meanei_xt[p][t_index] += sim.WorkerIDiag[w].meanei[p]
  0x4bdc11		4e8d0401		LEAQ 0(CX)(R8*1), R8		
  0x4bdc15		4d8d80801d9307		LEAQ 0x7931d80(R8), R8		
  0x4bdc1c		4c8b4950		MOVQ 0x50(CX), R9		
  0x4bdc20		f2410f1004d8		MOVSD_XMM 0(R8)(BX*8), X0	
  0x4bdc26		4c39c8			CMPQ AX, R9			
  0x4bdc29		0f8245ffffff		JB 0x4bdb74			
  0x4bdc2f		e8cc48fcff		CALL runtime.panicBounds(SB)	
				sim.Ui_xt[p][t_index] += sim.WorkerIDiag[w].ui[p]
  0x4bdc34		e8c748fcff		CALL runtime.panicBounds(SB)	
				sim.Counter_i_xt[p][t_index] += sim.WorkerIDiag[w].counter_i[p]
  0x4bdc39		e8c248fcff		CALL runtime.panicBounds(SB)	
  0x4bdc3e		b8c8000000		MOVL $0xc8, AX			
  0x4bdc43		e8b848fcff		CALL runtime.panicBounds(SB)	
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4bdc48		e85376f8ff		CALL runtime.panicdivide(SB)	
  0x4bdc4d		90			NOPL				
func (sim *SimulationState) Step4MoveIons(t_index, t int) {
  0x4bdc4e		4889442408		MOVQ AX, 0x8(SP)				
  0x4bdc53		48895c2410		MOVQ BX, 0x10(SP)				
  0x4bdc58		48894c2418		MOVQ CX, 0x18(SP)				
  0x4bdc5d		0f1f00			NOPL 0(AX)					
  0x4bdc60		e85b2cfcff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x4bdc65		488b442408		MOVQ 0x8(SP), AX				
  0x4bdc6a		488b5c2410		MOVQ 0x10(SP), BX				
  0x4bdc6f		488b4c2418		MOVQ 0x18(SP), CX				
  0x4bdc74		e927fdffff		JMP gopic.(*SimulationState).Step4MoveIons(SB)	

TEXT gopic.(*SimulationState).Step4MoveIons.func1(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
		wg.Go(func() {
  0x4c0a40		55			PUSHQ BP		
  0x4c0a41		4889e5			MOVQ SP, BP		
  0x4c0a44		488b5a08		MOVQ 0x8(DX), BX	
			if sim.Measurement_mode {
  0x4c0a48		8403			TESTB AL, 0(BX)		
		wg.Go(func() {
  0x4c0a4a		488b7220		MOVQ 0x20(DX), SI	
  0x4c0a4e		4c8b4218		MOVQ 0x18(DX), R8	
			if sim.Measurement_mode {
  0x4c0a52		80bbe02dba0700		CMPB 0x7ba2de0(BX), $0x0	
  0x4c0a59		742f			JE 0x4c0a8a			
		wg.Go(func() {
  0x4c0a5b		488b5210		MOVQ 0x10(DX), DX	
				diag := &sim.WorkerIDiag[workerID]
  0x4c0a5f		4c8b4b50		MOVQ 0x50(BX), R9	
  0x4c0a63		4939d1			CMPQ R9, DX		
  0x4c0a66		0f86a3050000		JBE 0x4c100f		
  0x4c0a6c		4c8b4b48		MOVQ 0x48(BX), R9	
  0x4c0a70		4869d240320000		IMULQ $0x3240, DX, DX	
  0x4c0a77		498d3c11		LEAQ 0(R9)(DX*1), DI	
				*diag = ionWorkerDiagnostics{}
  0x4c0a7b		b948060000		MOVL $0x648, CX		
  0x4c0a80		31c0			XORL AX, AX		
  0x4c0a82		f348ab			REP; STOSQ AX, ES:0(DI)	
				for k := s; k < e; k++ {
  0x4c0a85		e926050000		JMP 0x4c0fb0		
				if e > s {
  0x4c0a8a		4c39c6			CMPQ SI, R8		
  0x4c0a8d		7e10			JLE 0x4c0a9f		
					_ = sim.X_i[e-1]
  0x4c0a8f		488d46ff		LEAQ -0x1(SI), AX	
  0x4c0a93		483d40420f00		CMPQ AX, $0xf4240	
  0x4c0a99		0f8398030000		JAE 0x4c0e37		
				for ; k <= e-4; k += 4 {
  0x4c0a9f		488d46fc		LEAQ -0x4(SI), AX	
  0x4c0aa3		e90e010000		JMP 0x4c0bb6		
					d3 := c0_3 - float64(p3)
  0x4c0aa8		0f57ed			XORPS X5, X5		
  0x4c0aab		f2480f2ae9		CVTSI2SDQ CX, X5	
  0x4c0ab0		f20f5ce5		SUBSD X5, X4		
					ex3 := sim.Efield[p3] + d3*(sim.Efield[p3+1]-sim.Efield[p3])
  0x4c0ab4		f20f10accbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X5	
  0x4c0abd		f20f10b4cbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X6	
  0x4c0ac6		f20f5cf5		SUBSD X5, X6				
  0x4c0aca		f20f59e6		MULSD X6, X4				
  0x4c0ace		f20f58e5		ADDSD X5, X4				
					vx0 := sim.Vx_i[k] + ex0*FACTOR_I
  0x4c0ad2		f20f102d5ece0000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X5	
  0x4c0ada		f20f59c5		MULSD X5, X0				
  0x4c0ade		f2420f5884c3d0d8b805	ADDSD 0x5b8d8d0(BX)(R8*8), X0		
					vx1 := sim.Vx_i[k+1] + ex1*FACTOR_I
  0x4c0ae8		f20f59d5		MULSD X5, X2			
  0x4c0aec		f2420f5894c3d8d8b805	ADDSD 0x5b8d8d8(BX)(R8*8), X2	
					vx2 := sim.Vx_i[k+2] + ex2*FACTOR_I
  0x4c0af6		f20f59dd		MULSD X5, X3			
  0x4c0afa		f2420f589cc3e0d8b805	ADDSD 0x5b8d8e0(BX)(R8*8), X3	
					vx3 := sim.Vx_i[k+3] + ex3*FACTOR_I
  0x4c0b04		f20f59e5		MULSD X5, X4			
  0x4c0b08		f2420f58a4c3e8d8b805	ADDSD 0x5b8d8e8(BX)(R8*8), X4	
					sim.Vx_i[k] = vx0
  0x4c0b12		f2420f1184c3d0d8b805	MOVSD_XMM X0, 0x5b8d8d0(BX)(R8*8)	
					sim.Vx_i[k+1] = vx1
  0x4c0b1c		f2420f1194c3d8d8b805	MOVSD_XMM X2, 0x5b8d8d8(BX)(R8*8)	
					sim.Vx_i[k+2] = vx2
  0x4c0b26		f2420f119cc3e0d8b805	MOVSD_XMM X3, 0x5b8d8e0(BX)(R8*8)	
					sim.Vx_i[k+3] = vx3
  0x4c0b30		f2420f11a4c3e8d8b805	MOVSD_XMM X4, 0x5b8d8e8(BX)(R8*8)	
					sim.X_i[k] += vx0 * DT_I
  0x4c0b3a		f2420f10b4c3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R8*8), X6	
  0x4c0b44		f20f103da4cd0000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X7	
  0x4c0b4c		f20f59c7		MULSD X7, X0				
  0x4c0b50		f20f58f0		ADDSD X0, X6				
  0x4c0b54		f2420f11b4c3d0c63e05	MOVSD_XMM X6, 0x53ec6d0(BX)(R8*8)	
					sim.X_i[k+1] += vx1 * DT_I
  0x4c0b5e		f2420f1084c3d8c63e05	MOVSD_XMM 0x53ec6d8(BX)(R8*8), X0	
  0x4c0b68		f20f59d7		MULSD X7, X2				
  0x4c0b6c		f20f58d0		ADDSD X0, X2				
  0x4c0b70		f2420f1194c3d8c63e05	MOVSD_XMM X2, 0x53ec6d8(BX)(R8*8)	
					sim.X_i[k+2] += vx2 * DT_I
  0x4c0b7a		f2420f1084c3e0c63e05	MOVSD_XMM 0x53ec6e0(BX)(R8*8), X0	
  0x4c0b84		f20f59df		MULSD X7, X3				
  0x4c0b88		f20f58d8		ADDSD X0, X3				
  0x4c0b8c		f2420f119cc3e0c63e05	MOVSD_XMM X3, 0x53ec6e0(BX)(R8*8)	
					sim.X_i[k+3] += vx3 * DT_I
  0x4c0b96		f2420f1084c3e8c63e05	MOVSD_XMM 0x53ec6e8(BX)(R8*8), X0	
  0x4c0ba0		f20f59e7		MULSD X7, X4				
  0x4c0ba4		f20f58e0		ADDSD X0, X4				
  0x4c0ba8		f2420f11a4c3e8c63e05	MOVSD_XMM X4, 0x53ec6e8(BX)(R8*8)	
				for ; k <= e-4; k += 4 {
  0x4c0bb2		4983c004		ADDQ $0x4, R8		
  0x4c0bb6		4939c0			CMPQ R8, AX		
  0x4c0bb9		0f8fe9010000		JG 0x4c0da8		
  0x4c0bbf		90			NOPL			
					c0_0 := sim.X_i[k] * INV_DX
  0x4c0bc0		4981f840420f00		CMPQ R8, $0xf4240			
  0x4c0bc7		0f8360020000		JAE 0x4c0e2d				
  0x4c0bcd		f2420f1084c3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R8*8), X0	
  0x4c0bd7		f20f100dc1ce0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4c0bdf		f20f59c1		MULSD X1, X0				
					p0 := min(max(int(c0_0), 0), N_G-2)
  0x4c0be3		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x4c0be8		4885c9			TESTQ CX, CX		
  0x4c0beb		7d02			JGE 0x4c0bef		
  0x4c0bed		31c9			XORL CX, CX		
  0x4c0bef		4881f98e010000		CMPQ CX, $0x18e		
  0x4c0bf6		7e05			JLE 0x4c0bfd		
  0x4c0bf8		b98e010000		MOVL $0x18e, CX		
					d0 := c0_0 - float64(p0)
  0x4c0bfd		0f57d2			XORPS X2, X2		
  0x4c0c00		f2480f2ad1		CVTSI2SDQ CX, X2	
  0x4c0c05		f20f5cc2		SUBSD X2, X0		
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x4c0c09		f20f1094cbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X2	
  0x4c0c12		f20f109ccbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X3	
  0x4c0c1b		f20f5cda		SUBSD X2, X3				
  0x4c0c1f		f20f59c3		MULSD X3, X0				
					c0_1 := sim.X_i[k+1] * INV_DX
  0x4c0c23		498d4801		LEAQ 0x1(R8), CX	
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x4c0c27		f20f58c2		ADDSD X2, X0		
					c0_1 := sim.X_i[k+1] * INV_DX
  0x4c0c2b		4881f940420f00		CMPQ CX, $0xf4240			
  0x4c0c32		0f83e6010000		JAE 0x4c0e1e				
  0x4c0c38		f2420f1094c3d8c63e05	MOVSD_XMM 0x53ec6d8(BX)(R8*8), X2	
  0x4c0c42		f20f59d1		MULSD X1, X2				
					p1 := min(max(int(c0_1), 0), N_G-2)
  0x4c0c46		f2480f2cca		CVTTSD2SIQ X2, CX	
  0x4c0c4b		4885c9			TESTQ CX, CX		
  0x4c0c4e		7d02			JGE 0x4c0c52		
  0x4c0c50		31c9			XORL CX, CX		
  0x4c0c52		4881f98e010000		CMPQ CX, $0x18e		
  0x4c0c59		7e05			JLE 0x4c0c60		
  0x4c0c5b		b98e010000		MOVL $0x18e, CX		
					d1 := c0_1 - float64(p1)
  0x4c0c60		0f57db			XORPS X3, X3		
  0x4c0c63		f2480f2ad9		CVTSI2SDQ CX, X3	
  0x4c0c68		f20f5cd3		SUBSD X3, X2		
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x4c0c6c		f20f109ccbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X3	
  0x4c0c75		f20f10a4cbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X4	
  0x4c0c7e		f20f5ce3		SUBSD X3, X4				
  0x4c0c82		f20f59d4		MULSD X4, X2				
					c0_2 := sim.X_i[k+2] * INV_DX
  0x4c0c86		498d4802		LEAQ 0x2(R8), CX	
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x4c0c8a		f20f58d3		ADDSD X3, X2		
					c0_2 := sim.X_i[k+2] * INV_DX
  0x4c0c8e		4881f940420f00		CMPQ CX, $0xf4240			
  0x4c0c95		0f8374010000		JAE 0x4c0e0f				
  0x4c0c9b		f2420f109cc3e0c63e05	MOVSD_XMM 0x53ec6e0(BX)(R8*8), X3	
  0x4c0ca5		f20f59d9		MULSD X1, X3				
					p2 := min(max(int(c0_2), 0), N_G-2)
  0x4c0ca9		f2480f2ccb		CVTTSD2SIQ X3, CX	
  0x4c0cae		4885c9			TESTQ CX, CX		
  0x4c0cb1		7d02			JGE 0x4c0cb5		
  0x4c0cb3		31c9			XORL CX, CX		
  0x4c0cb5		4881f98e010000		CMPQ CX, $0x18e		
  0x4c0cbc		7e05			JLE 0x4c0cc3		
  0x4c0cbe		b98e010000		MOVL $0x18e, CX		
					d2 := c0_2 - float64(p2)
  0x4c0cc3		0f57e4			XORPS X4, X4		
  0x4c0cc6		f2480f2ae1		CVTSI2SDQ CX, X4	
  0x4c0ccb		f20f5cdc		SUBSD X4, X3		
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x4c0ccf		f20f10a4cbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X4	
  0x4c0cd8		f20f10accbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X5	
  0x4c0ce1		f20f5cec		SUBSD X4, X5				
  0x4c0ce5		f20f59dd		MULSD X5, X3				
					c0_3 := sim.X_i[k+3] * INV_DX
  0x4c0ce9		498d4803		LEAQ 0x3(R8), CX	
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x4c0ced		f20f58dc		ADDSD X4, X3		
					c0_3 := sim.X_i[k+3] * INV_DX
  0x4c0cf1		4881f940420f00		CMPQ CX, $0xf4240			
  0x4c0cf8		0f8307010000		JAE 0x4c0e05				
  0x4c0cfe		f2420f10a4c3e8c63e05	MOVSD_XMM 0x53ec6e8(BX)(R8*8), X4	
  0x4c0d08		f20f59e1		MULSD X1, X4				
					p3 := min(max(int(c0_3), 0), N_G-2)
  0x4c0d0c		f2480f2ccc		CVTTSD2SIQ X4, CX	
  0x4c0d11		4885c9			TESTQ CX, CX		
  0x4c0d14		7d0a			JGE 0x4c0d20		
  0x4c0d16		31c9			XORL CX, CX		
  0x4c0d18		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x4c0d20		4881f98e010000		CMPQ CX, $0x18e		
  0x4c0d27		0f8e7bfdffff		JLE 0x4c0aa8		
  0x4c0d2d		b98e010000		MOVL $0x18e, CX		
  0x4c0d32		e971fdffff		JMP 0x4c0aa8		
					d := c0 - float64(p)
  0x4c0d37		0f57d2			XORPS X2, X2		
  0x4c0d3a		f2480f2ad0		CVTSI2SDQ AX, X2	
  0x4c0d3f		f20f5cc2		SUBSD X2, X0		
					ex := sim.Efield[p] + d*(sim.Efield[p+1]-sim.Efield[p])
  0x4c0d43		f20f1094c3d00e2707	MOVSD_XMM 0x7270ed0(BX)(AX*8), X2	
  0x4c0d4c		f20f109cc3d80e2707	MOVSD_XMM 0x7270ed8(BX)(AX*8), X3	
  0x4c0d55		f20f5cda		SUBSD X2, X3				
  0x4c0d59		f20f59c3		MULSD X3, X0				
  0x4c0d5d		f20f58c2		ADDSD X2, X0				
					sim.Vx_i[k] += ex * FACTOR_I
  0x4c0d61		f20f1015cfcb0000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X2	
  0x4c0d69		f20f59c2		MULSD X2, X0				
  0x4c0d6d		f2420f5884c3d0d8b805	ADDSD 0x5b8d8d0(BX)(R8*8), X0		
  0x4c0d77		f2420f1184c3d0d8b805	MOVSD_XMM X0, 0x5b8d8d0(BX)(R8*8)	
					sim.X_i[k] += sim.Vx_i[k] * DT_I
  0x4c0d81		f2420f109cc3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R8*8), X3	
  0x4c0d8b		f20f10255dcb0000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X4	
  0x4c0d93		f20f59c4		MULSD X4, X0				
  0x4c0d97		f20f58d8		ADDSD X0, X3				
  0x4c0d9b		f2420f119cc3d0c63e05	MOVSD_XMM X3, 0x53ec6d0(BX)(R8*8)	
				for ; k < e; k++ {
  0x4c0da5		49ffc0			INCQ R8			
  0x4c0da8		4939f0			CMPQ R8, SI		
  0x4c0dab		7d49			JGE 0x4c0df6		
					c0 := sim.X_i[k] * INV_DX
  0x4c0dad		4981f840420f00		CMPQ R8, $0xf4240			
  0x4c0db4		7342			JAE 0x4c0df8				
  0x4c0db6		f2420f1084c3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R8*8), X0	
  0x4c0dc0		f20f100dd8cc0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4c0dc8		f20f59c1		MULSD X1, X0				
					p := min(max(int(c0), 0), N_G-2)
  0x4c0dcc		f2480f2cc0		CVTTSD2SIQ X0, AX	
  0x4c0dd1		4885c0			TESTQ AX, AX		
  0x4c0dd4		7d0a			JGE 0x4c0de0		
  0x4c0dd6		31c0			XORL AX, AX		
  0x4c0dd8		0f1f840000000000	NOPL 0(AX)(AX*1)	
  0x4c0de0		483d8e010000		CMPQ AX, $0x18e		
  0x4c0de6		0f8e4bffffff		JLE 0x4c0d37		
  0x4c0dec		b88e010000		MOVL $0x18e, AX		
  0x4c0df1		e941ffffff		JMP 0x4c0d37		
		})
  0x4c0df6		5d			POPQ BP			
  0x4c0df7		c3			RET			
					c0 := sim.X_i[k] * INV_DX
  0x4c0df8		b840420f00		MOVL $0xf4240, AX		
  0x4c0dfd		0f1f00			NOPL 0(AX)			
  0x4c0e00		e8fb16fcff		CALL runtime.panicBounds(SB)	
					c0_3 := sim.X_i[k+3] * INV_DX
  0x4c0e05		b840420f00		MOVL $0xf4240, AX		
  0x4c0e0a		e8f116fcff		CALL runtime.panicBounds(SB)	
					c0_2 := sim.X_i[k+2] * INV_DX
  0x4c0e0f		b840420f00		MOVL $0xf4240, AX		
  0x4c0e14		b940420f00		MOVL $0xf4240, CX		
  0x4c0e19		e8e216fcff		CALL runtime.panicBounds(SB)	
					c0_1 := sim.X_i[k+1] * INV_DX
  0x4c0e1e		b840420f00		MOVL $0xf4240, AX		
  0x4c0e23		b940420f00		MOVL $0xf4240, CX		
  0x4c0e28		e8d316fcff		CALL runtime.panicBounds(SB)	
					c0_0 := sim.X_i[k] * INV_DX
  0x4c0e2d		b840420f00		MOVL $0xf4240, AX		
  0x4c0e32		e8c916fcff		CALL runtime.panicBounds(SB)	
					_ = sim.X_i[e-1]
  0x4c0e37		b940420f00		MOVL $0xf4240, CX		
  0x4c0e3c		0f1f4000		NOPL 0(AX)			
  0x4c0e40		e8bb16fcff		CALL runtime.panicBounds(SB)	
					c1 = float64(p) + 1.0 - c0
  0x4c0e45		0f57d2			XORPS X2, X2				
  0x4c0e48		f2480f2ad0		CVTSI2SDQ AX, X2			
  0x4c0e4d		f20f101d5bcb0000	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x4c0e55		f20f58da		ADDSD X2, X3				
  0x4c0e59		f20f5cd8		SUBSD X0, X3				
					c2 = c0 - float64(p)
  0x4c0e5d		f20f5cc2		SUBSD X2, X0		
					e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]
  0x4c0e61		f20f1094c3d00e2707	MOVSD_XMM 0x7270ed0(BX)(AX*8), X2	
  0x4c0e6a		f20f59d3		MULSD X3, X2				
  0x4c0e6e		f20f10a4c3d80e2707	MOVSD_XMM 0x7270ed8(BX)(AX*8), X4	
  0x4c0e77		f20f59e0		MULSD X0, X4				
  0x4c0e7b		f20f58e2		ADDSD X2, X4				
					mean_v = sim.Vx_i[k] + 0.5*e_x*FACTOR_I
  0x4c0e7f		f20f101511cb0000	MOVSD_XMM $f64.3fe0000000000000(SB), X2	
  0x4c0e87		f20f59d4		MULSD X4, X2				
  0x4c0e8b		f20f102da5ca0000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X5	
  0x4c0e93		f20f59d5		MULSD X5, X2				
  0x4c0e97		f2420f5894c3d0d8b805	ADDSD 0x5b8d8d0(BX)(R8*8), X2		
					diag.counter_i[p] += c1
  0x4c0ea1		498d0c11		LEAQ 0(R9)(DX*1), CX		
  0x4c0ea5		f20f1034c1		MOVSD_XMM 0(CX)(AX*8), X6	
  0x4c0eaa		f20f58f3		ADDSD X3, X6			
  0x4c0eae		f20f1134c1		MOVSD_XMM X6, 0(CX)(AX*8)	
					diag.counter_i[p+1] += c2
  0x4c0eb3		f20f1074c108		MOVSD_XMM 0x8(CX)(AX*8), X6	
  0x4c0eb9		f20f58f0		ADDSD X0, X6			
  0x4c0ebd		f20f1174c108		MOVSD_XMM X6, 0x8(CX)(AX*8)	
					diag.ui[p] += c1 * mean_v
  0x4c0ec3		498d0c11		LEAQ 0(R9)(DX*1), CX		
  0x4c0ec7		488d89800c0000		LEAQ 0xc80(CX), CX		
  0x4c0ece		f20f1034c1		MOVSD_XMM 0(CX)(AX*8), X6	
  0x4c0ed3		0f10fb			MOVUPS X3, X7			
  0x4c0ed6		f20f59da		MULSD X2, X3			
  0x4c0eda		f20f58de		ADDSD X6, X3			
  0x4c0ede		f20f111cc1		MOVSD_XMM X3, 0(CX)(AX*8)	
					diag.ui[p+1] += c2 * mean_v
  0x4c0ee3		f20f105cc108		MOVSD_XMM 0x8(CX)(AX*8), X3	
  0x4c0ee9		0f10f0			MOVUPS X0, X6			
  0x4c0eec		f20f59c2		MULSD X2, X0			
  0x4c0ef0		f20f58c3		ADDSD X3, X0			
  0x4c0ef4		f20f1144c108		MOVSD_XMM X0, 0x8(CX)(AX*8)	
					v_sqr = mean_v*mean_v + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x4c0efa		f20f59d2		MULSD X2, X2				
  0x4c0efe		f2420f1084c3d0ea3206	MOVSD_XMM 0x632ead0(BX)(R8*8), X0	
  0x4c0f08		f20f59c0		MULSD X0, X0				
  0x4c0f0c		f20f58c2		ADDSD X2, X0				
  0x4c0f10		f2420f1094c3d0fcac06	MOVSD_XMM 0x6acfcd0(BX)(R8*8), X2	
  0x4c0f1a		f20f59d2		MULSD X2, X2				
  0x4c0f1e		f20f58c2		ADDSD X2, X0				
					energy = 0.5 * AR_MASS * v_sqr * INV_EV_TO_J
  0x4c0f22		f20f10156ec90000	MOVSD_XMM $f64.3aa4879de14d0b24(SB), X2	
  0x4c0f2a		f20f59c2		MULSD X2, X0				
  0x4c0f2e		f20f101d9acb0000	MOVSD_XMM $f64.43d5a792def818e8(SB), X3	
  0x4c0f36		f20f59c3		MULSD X3, X0				
					diag.meanei[p] += c1 * energy
  0x4c0f3a		498d0c11		LEAQ 0(R9)(DX*1), CX		
  0x4c0f3e		488d8900190000		LEAQ 0x1900(CX), CX		
  0x4c0f45		f2440f1004c1		MOVSD_XMM 0(CX)(AX*8), X8	
  0x4c0f4b		f20f59f8		MULSD X0, X7			
  0x4c0f4f		f2410f58f8		ADDSD X8, X7			
  0x4c0f54		f20f113cc1		MOVSD_XMM X7, 0(CX)(AX*8)	
					diag.meanei[p+1] += c2 * energy
  0x4c0f59		f20f107cc108		MOVSD_XMM 0x8(CX)(AX*8), X7	
  0x4c0f5f		f20f59f0		MULSD X0, X6			
  0x4c0f63		f20f58f7		ADDSD X7, X6			
  0x4c0f67		f20f1174c108		MOVSD_XMM X6, 0x8(CX)(AX*8)	
					sim.Vx_i[k] += e_x * FACTOR_I
  0x4c0f6d		f2420f1084c3d0d8b805	MOVSD_XMM 0x5b8d8d0(BX)(R8*8), X0	
  0x4c0f77		f20f59e5		MULSD X5, X4				
  0x4c0f7b		f20f58c4		ADDSD X4, X0				
  0x4c0f7f		f2420f1184c3d0d8b805	MOVSD_XMM X0, 0x5b8d8d0(BX)(R8*8)	
					sim.X_i[k] += sim.Vx_i[k] * DT_I
  0x4c0f89		f2420f10a4c3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R8*8), X4	
  0x4c0f93		f20f103555c90000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X6	
  0x4c0f9b		f20f59c6		MULSD X6, X0				
  0x4c0f9f		f20f58c4		ADDSD X4, X0				
  0x4c0fa3		f2420f1184c3d0c63e05	MOVSD_XMM X0, 0x53ec6d0(BX)(R8*8)	
				for k := s; k < e; k++ {
  0x4c0fad		49ffc0			INCQ R8			
  0x4c0fb0		4939f0			CMPQ R8, SI		
  0x4c0fb3		0f8d3dfeffff		JGE 0x4c0df6		
  0x4c0fb9		0f1f8000000000		NOPL 0(AX)		
					c0 = sim.X_i[k] * INV_DX
  0x4c0fc0		4981f840420f00		CMPQ R8, $0xf4240			
  0x4c0fc7		733c			JAE 0x4c1005				
  0x4c0fc9		f2420f1084c3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R8*8), X0	
  0x4c0fd3		f20f100dc5ca0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4c0fdb		f20f59c1		MULSD X1, X0				
					p = min(max(int(c0), 0), N_G-2)
  0x4c0fdf		f2480f2cc0		CVTTSD2SIQ X0, AX	
  0x4c0fe4		4885c0			TESTQ AX, AX		
  0x4c0fe7		7d02			JGE 0x4c0feb		
  0x4c0fe9		31c0			XORL AX, AX		
  0x4c0feb		483d8e010000		CMPQ AX, $0x18e		
  0x4c0ff1		0f8e4efeffff		JLE 0x4c0e45		
  0x4c0ff7		b88e010000		MOVL $0x18e, AX		
  0x4c0ffc		0f1f4000		NOPL 0(AX)		
  0x4c1000		e940feffff		JMP 0x4c0e45		
					c0 = sim.X_i[k] * INV_DX
  0x4c1005		b840420f00		MOVL $0xf4240, AX		
  0x4c100a		e8f114fcff		CALL runtime.panicBounds(SB)	
				diag := &sim.WorkerIDiag[workerID]
  0x4c100f		e8ec14fcff		CALL runtime.panicBounds(SB)	
  0x4c1014		90			NOPL				
