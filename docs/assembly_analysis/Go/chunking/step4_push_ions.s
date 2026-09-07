TEXT gopic.(*SimulationState).Step4MoveIons(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
func (sim *SimulationState) Step4MoveIons(t_index, t int) {
  0x4bcbc0		493b6610		CMPQ SP, 0x10(R14)	
  0x4bcbc4		0f86a4020000		JBE 0x4bce6e		
  0x4bcbca		55			PUSHQ BP		
  0x4bcbcb		4889e5			MOVQ SP, BP		
  0x4bcbce		4883ec58		SUBQ $0x58, SP		
	if (t % N_SUB) != 0 {
  0x4bcbd2		48bacdcccccccccccccc	MOVQ $0xcccccccccccccccd, DX	
  0x4bcbdc		480fafd1		IMULQ CX, DX			
  0x4bcbe0		48be9899999999999919	MOVQ $0x1999999999999998, SI	
  0x4bcbea		4801f2			ADDQ SI, DX			
  0x4bcbed		48c1c23e		ROLQ $0x3e, DX			
  0x4bcbf1		48becccccccccccccc0c	MOVQ $0xccccccccccccccc, SI	
  0x4bcbfb		0f1f440000		NOPL 0(AX)(AX*1)		
  0x4bcc00		4839d6			CMPQ SI, DX			
  0x4bcc03		7279			JB 0x4bcc7e			
  0x4bcc05		4889442468		MOVQ AX, 0x68(SP)		
  0x4bcc0a		48895c2470		MOVQ BX, 0x70(SP)		
	numWorkers := sim.NumWorkers
  0x4bcc0f		8400			TESTB AL, 0(AX)		
  0x4bcc11		488b90e82dba07		MOVQ 0x7ba2de8(AX), DX	
  0x4bcc18		4889542428		MOVQ DX, 0x28(SP)	
	var wg sync.WaitGroup
  0x4bcc1d		b810000000		MOVL $0x10, AX				
  0x4bcc22		488d1db78a0f00		LEAQ 0xf8ab7(IP), BX			
  0x4bcc29		b901000000		MOVL $0x1, CX				
  0x4bcc2e		e8ed15f6ff		CALL runtime.mallocgcSmallNoScanSC2(SB)	
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4bcc33		488b542468		MOVQ 0x68(SP), DX	
  0x4bcc38		488bb2c87e5603		MOVQ 0x3567ec8(DX), SI	
  0x4bcc3f		488b7c2428		MOVQ 0x28(SP), DI	
  0x4bcc44		488d343e		LEAQ 0(SI)(DI*1), SI	
  0x4bcc48		488d76ff		LEAQ -0x1(SI), SI	
  0x4bcc4c		4885ff			TESTQ DI, DI		
  0x4bcc4f		0f8413020000		JE 0x4bce68		
	var wg sync.WaitGroup
  0x4bcc55		4889442450		MOVQ AX, 0x50(SP)	
  0x4bcc5a		4889c1			MOVQ AX, CX		
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4bcc5d		4889f0			MOVQ SI, AX		
	if (t % N_SUB) != 0 {
  0x4bcc60		4889d3			MOVQ DX, BX		
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4bcc63		4883ffff		CMPQ DI, $-0x1		
  0x4bcc67		7507			JNE 0x4bcc70		
  0x4bcc69		48f7d8			NEGQ AX			
  0x4bcc6c		31d2			XORL DX, DX		
  0x4bcc6e		eb05			JMP 0x4bcc75		
  0x4bcc70		4899			CQO			
  0x4bcc72		48f7ff			IDIVQ DI		
  0x4bcc75		4889442438		MOVQ AX, 0x38(SP)	
	for w := range numWorkers {
  0x4bcc7a		31d2			XORL DX, DX		
  0x4bcc7c		eb0c			JMP 0x4bcc8a		
		return
  0x4bcc7e		4883c458		ADDQ $0x58, SP		
  0x4bcc82		5d			POPQ BP			
  0x4bcc83		c3			RET			
		start := w * chunkSize
  0x4bcc84		4c89c8			MOVQ R9, AX		
	for w := range numWorkers {
  0x4bcc87		4c89c2			MOVQ R8, DX		
  0x4bcc8a		4839fa			CMPQ DX, DI		
  0x4bcc8d		0f8dc4000000		JGE 0x4bcd57		
		start := w * chunkSize
  0x4bcc93		4889d6			MOVQ DX, SI		
  0x4bcc96		480fafd0		IMULQ AX, DX		
		end := min((w+1)*chunkSize, sim.N_i)
  0x4bcc9a		4c8d4601		LEAQ 0x1(SI), R8	
  0x4bcc9e		4989c1			MOVQ AX, R9		
  0x4bcca1		490fafc0		IMULQ R8, AX		
  0x4bcca5		4c8b93c87e5603		MOVQ 0x3567ec8(BX), R10	
  0x4bccac		4939c2			CMPQ R10, AX		
		if start >= end {
  0x4bccaf		490f4cc2		CMOVL R10, AX		
  0x4bccb3		4839d0			CMPQ AX, DX		
		end := min((w+1)*chunkSize, sim.N_i)
  0x4bccb6		7ecc			JLE 0x4bcc84		
	for w := range numWorkers {
  0x4bccb8		4889742448		MOVQ SI, 0x48(SP)	
		start := w * chunkSize
  0x4bccbd		4889542420		MOVQ DX, 0x20(SP)	
		end := min((w+1)*chunkSize, sim.N_i)
  0x4bccc2		4c89442440		MOVQ R8, 0x40(SP)	
		if start >= end {
  0x4bccc7		4889442430		MOVQ AX, 0x30(SP)	
		wg.Go(func() {
  0x4bcccc		b828000000		MOVL $0x28, AX							
  0x4bccd1		488d1df0ad0f00		LEAQ 0xfadf0(IP), BX						
  0x4bccd8		b901000000		MOVL $0x1, CX							
  0x4bccdd		0f1f00			NOPL 0(AX)							
  0x4bcce0		e8db06f6ff		CALL runtime.mallocgcSmallScanNoHeaderSC5(SB)			
  0x4bcce5		488d15d4300000		LEAQ gopic.(*SimulationState).Step4MoveIons.func1(SB), DX	
  0x4bccec		488910			MOVQ DX, 0(AX)							
  0x4bccef		833dfa00130000		CMPL runtime.writeBarrier(SB), $0x0				
  0x4bccf6		7508			JNE 0x4bcd00							
  0x4bccf8		488b4c2468		MOVQ 0x68(SP), CX						
  0x4bccfd		eb0e			JMP 0x4bcd0d							
  0x4bccff		90			NOPL								
  0x4bcd00		e8db49fcff		CALL runtime.gcWriteBarrier1(SB)				
  0x4bcd05		488b4c2468		MOVQ 0x68(SP), CX						
  0x4bcd0a		49890b			MOVQ CX, 0(R11)							
  0x4bcd0d		48894808		MOVQ CX, 0x8(AX)						
  0x4bcd11		488b4c2448		MOVQ 0x48(SP), CX						
  0x4bcd16		48894810		MOVQ CX, 0x10(AX)						
  0x4bcd1a		488b4c2420		MOVQ 0x20(SP), CX						
  0x4bcd1f		48894818		MOVQ CX, 0x18(AX)						
  0x4bcd23		488b4c2430		MOVQ 0x30(SP), CX						
  0x4bcd28		48894820		MOVQ CX, 0x20(AX)						
  0x4bcd2c		4889c3			MOVQ AX, BX							
  0x4bcd2f		488b442450		MOVQ 0x50(SP), AX						
  0x4bcd34		e887ccfcff		CALL sync.(*WaitGroup).Go(SB)					
	wg.Wait()
  0x4bcd39		488b4c2450		MOVQ 0x50(SP), CX	
		end := min((w+1)*chunkSize, sim.N_i)
  0x4bcd3e		488b5c2468		MOVQ 0x68(SP), BX	
	for w := range numWorkers {
  0x4bcd43		488b7c2428		MOVQ 0x28(SP), DI	
  0x4bcd48		4c8b442440		MOVQ 0x40(SP), R8	
		start := w * chunkSize
  0x4bcd4d		4c8b4c2438		MOVQ 0x38(SP), R9	
		wg.Go(func() {
  0x4bcd52		e92dffffff		JMP 0x4bcc84		
	wg.Wait()
  0x4bcd57		4889c8			MOVQ CX, AX			
  0x4bcd5a		e841cbfcff		CALL sync.(*WaitGroup).Wait(SB)	
	if sim.Measurement_mode {
  0x4bcd5f		488b4c2468		MOVQ 0x68(SP), CX		
  0x4bcd64		80b9e02dba0700		CMPB 0x7ba2de0(CX), $0x0	
  0x4bcd6b		740e			JE 0x4bcd7b			
		for w := range numWorkers {
  0x4bcd6d		31c0			XORL AX, AX		
  0x4bcd6f		488b542428		MOVQ 0x28(SP), DX	
  0x4bcd74		488b5c2470		MOVQ 0x70(SP), BX	
  0x4bcd79		eb09			JMP 0x4bcd84		
}
  0x4bcd7b		4883c458		ADDQ $0x58, SP		
  0x4bcd7f		5d			POPQ BP			
  0x4bcd80		c3			RET			
		for w := range numWorkers {
  0x4bcd81		48ffc0			INCQ AX			
  0x4bcd84		4839d0			CMPQ AX, DX		
  0x4bcd87		7df2			JGE 0x4bcd7b		
				sim.Counter_i_xt[p][t_index] += sim.WorkerIDiag[w].counter_i[p]
  0x4bcd89		4869f040320000		IMULQ $0x3240, AX, SI	
			for p := range N_G {
  0x4bcd90		31ff			XORL DI, DI		
  0x4bcd92		eb1e			JMP 0x4bcdb2		
				sim.Meanei_xt[p][t_index] += sim.WorkerIDiag[w].meanei[p]
  0x4bcd94		4c8b4948		MOVQ 0x48(CX), R9		
  0x4bcd98		4d8d0c31		LEAQ 0(R9)(SI*1), R9		
  0x4bcd9c		4d8d8900190000		LEAQ 0x1900(R9), R9		
  0x4bcda3		f2410f5804f9		ADDSD 0(R9)(DI*8), X0		
  0x4bcda9		f2410f1104d8		MOVSD_XMM X0, 0(R8)(BX*8)	
			for p := range N_G {
  0x4bcdaf		48ffc7			INCQ DI			
  0x4bcdb2		4881ff90010000		CMPQ DI, $0x190		
  0x4bcdb9		7dc6			JGE 0x4bcd81		
				sim.Counter_i_xt[p][t_index] += sim.WorkerIDiag[w].counter_i[p]
  0x4bcdbb		4c69c740060000		IMULQ $0x640, DI, R8		
  0x4bcdc2		4e8d0c01		LEAQ 0(CX)(R8*1), R9		
  0x4bcdc6		4d8d8980a5a607		LEAQ 0x7a6a580(R9), R9		
  0x4bcdcd		4881fbc8000000		CMPQ BX, $0xc8			
  0x4bcdd4		0f8384000000		JAE 0x4bce5e			
  0x4bcdda		4c8b5150		MOVQ 0x50(CX), R10		
  0x4bcdde		f2410f1004d9		MOVSD_XMM 0(R9)(BX*8), X0	
  0x4bcde4		4c39d0			CMPQ AX, R10			
  0x4bcde7		7370			JAE 0x4bce59			
  0x4bcde9		4c8b5148		MOVQ 0x48(CX), R10		
  0x4bcded		4901f2			ADDQ SI, R10			
  0x4bcdf0		f2410f5804fa		ADDSD 0(R10)(DI*8), X0		
  0x4bcdf6		f2410f1104d9		MOVSD_XMM X0, 0(R9)(BX*8)	
				sim.Ui_xt[p][t_index] += sim.WorkerIDiag[w].ui[p]
  0x4bcdfc		4e8d0c01		LEAQ 0(CX)(R8*1), R9		
  0x4bce00		4d8d8980855807		LEAQ 0x7588580(R9), R9		
  0x4bce07		4c8b5150		MOVQ 0x50(CX), R10		
  0x4bce0b		f2410f1004d9		MOVSD_XMM 0(R9)(BX*8), X0	
  0x4bce11		4c39d0			CMPQ AX, R10			
  0x4bce14		733e			JAE 0x4bce54			
  0x4bce16		4c8b5148		MOVQ 0x48(CX), R10		
  0x4bce1a		4d8d1432		LEAQ 0(R10)(SI*1), R10		
  0x4bce1e		4d8d92800c0000		LEAQ 0xc80(R10), R10		
  0x4bce25		f2410f5804fa		ADDSD 0(R10)(DI*8), X0		
  0x4bce2b		f2410f1104d9		MOVSD_XMM X0, 0(R9)(BX*8)	
				sim.Meanei_xt[p][t_index] += sim.WorkerIDiag[w].meanei[p]
  0x4bce31		4e8d0401		LEAQ 0(CX)(R8*1), R8		
  0x4bce35		4d8d80801d9307		LEAQ 0x7931d80(R8), R8		
  0x4bce3c		4c8b4950		MOVQ 0x50(CX), R9		
  0x4bce40		f2410f1004d8		MOVSD_XMM 0(R8)(BX*8), X0	
  0x4bce46		4c39c8			CMPQ AX, R9			
  0x4bce49		0f8245ffffff		JB 0x4bcd94			
  0x4bce4f		e84c4cfcff		CALL runtime.panicBounds(SB)	
				sim.Ui_xt[p][t_index] += sim.WorkerIDiag[w].ui[p]
  0x4bce54		e8474cfcff		CALL runtime.panicBounds(SB)	
				sim.Counter_i_xt[p][t_index] += sim.WorkerIDiag[w].counter_i[p]
  0x4bce59		e8424cfcff		CALL runtime.panicBounds(SB)	
  0x4bce5e		b8c8000000		MOVL $0xc8, AX			
  0x4bce63		e8384cfcff		CALL runtime.panicBounds(SB)	
	chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x4bce68		e8b379f8ff		CALL runtime.panicdivide(SB)	
  0x4bce6d		90			NOPL				
func (sim *SimulationState) Step4MoveIons(t_index, t int) {
  0x4bce6e		4889442408		MOVQ AX, 0x8(SP)				
  0x4bce73		48895c2410		MOVQ BX, 0x10(SP)				
  0x4bce78		48894c2418		MOVQ CX, 0x18(SP)				
  0x4bce7d		0f1f00			NOPL 0(AX)					
  0x4bce80		e8db2ffcff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x4bce85		488b442408		MOVQ 0x8(SP), AX				
  0x4bce8a		488b5c2410		MOVQ 0x10(SP), BX				
  0x4bce8f		488b4c2418		MOVQ 0x18(SP), CX				
  0x4bce94		e927fdffff		JMP gopic.(*SimulationState).Step4MoveIons(SB)	

TEXT gopic.(*SimulationState).Step4MoveIons.func1(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_chunking/simulation.go
		wg.Go(func() {
  0x4bfdc0		55			PUSHQ BP		
  0x4bfdc1		4889e5			MOVQ SP, BP		
  0x4bfdc4		488b5a08		MOVQ 0x8(DX), BX	
			if sim.Measurement_mode {
  0x4bfdc8		8403			TESTB AL, 0(BX)		
		wg.Go(func() {
  0x4bfdca		488b7220		MOVQ 0x20(DX), SI	
  0x4bfdce		4c8b4218		MOVQ 0x18(DX), R8	
			if sim.Measurement_mode {
  0x4bfdd2		80bbe02dba0700		CMPB 0x7ba2de0(BX), $0x0	
  0x4bfdd9		742f			JE 0x4bfe0a			
		wg.Go(func() {
  0x4bfddb		488b5210		MOVQ 0x10(DX), DX	
				diag := &sim.WorkerIDiag[workerID]
  0x4bfddf		4c8b4b50		MOVQ 0x50(BX), R9	
  0x4bfde3		4939d1			CMPQ R9, DX		
  0x4bfde6		0f8663050000		JBE 0x4c034f		
  0x4bfdec		4c8b4b48		MOVQ 0x48(BX), R9	
  0x4bfdf0		4869d240320000		IMULQ $0x3240, DX, DX	
  0x4bfdf7		498d3c11		LEAQ 0(R9)(DX*1), DI	
				*diag = ionWorkerDiagnostics{}
  0x4bfdfb		b948060000		MOVL $0x648, CX		
  0x4bfe00		31c0			XORL AX, AX		
  0x4bfe02		f348ab			REP; STOSQ AX, ES:0(DI)	
				for k := s; k < e; k++ {
  0x4bfe05		e9e5040000		JMP 0x4c02ef		
				if e > s {
  0x4bfe0a		4c39c6			CMPQ SI, R8		
  0x4bfe0d		7e10			JLE 0x4bfe1f		
					_ = sim.X_i[e-1]
  0x4bfe0f		488d46ff		LEAQ -0x1(SI), AX	
  0x4bfe13		483d40420f00		CMPQ AX, $0xf4240	
  0x4bfe19		0f8378030000		JAE 0x4c0197		
				for ; k <= e-4; k += 4 {
  0x4bfe1f		488d46fc		LEAQ -0x4(SI), AX	
  0x4bfe23		e9ff000000		JMP 0x4bff27		
					d3 := c0_3 - float64(p3)
  0x4bfe28		0f57ed			XORPS X5, X5		
  0x4bfe2b		f2480f2ae9		CVTSI2SDQ CX, X5	
  0x4bfe30		f20f5cc5		SUBSD X5, X0		
					ex3 := sim.Efield[p3] + d3*(sim.Efield[p3+1]-sim.Efield[p3])
  0x4bfe34		f20f10accbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X5	
  0x4bfe3d		f20f10b4cbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X6	
  0x4bfe46		f20f5cf5		SUBSD X5, X6				
  0x4bfe4a		c4e2f9b9ee		VFMADD231SD X6, X0, X5			
					vx0 := sim.Vx_i[k] + ex0*FACTOR_I
  0x4bfe4f		f20f1005e1da0000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x4bfe57		f20f59d0		MULSD X0, X2				
  0x4bfe5b		f2420f5894c3d0d8b805	ADDSD 0x5b8d8d0(BX)(R8*8), X2		
					vx1 := sim.Vx_i[k+1] + ex1*FACTOR_I
  0x4bfe65		f20f59d8		MULSD X0, X3			
  0x4bfe69		f2420f589cc3d8d8b805	ADDSD 0x5b8d8d8(BX)(R8*8), X3	
					vx2 := sim.Vx_i[k+2] + ex2*FACTOR_I
  0x4bfe73		f20f59e0		MULSD X0, X4			
  0x4bfe77		f2420f58a4c3e0d8b805	ADDSD 0x5b8d8e0(BX)(R8*8), X4	
					vx3 := sim.Vx_i[k+3] + ex3*FACTOR_I
  0x4bfe81		f20f59e8		MULSD X0, X5			
  0x4bfe85		f2420f58acc3e8d8b805	ADDSD 0x5b8d8e8(BX)(R8*8), X5	
					sim.Vx_i[k] = vx0
  0x4bfe8f		f2420f1194c3d0d8b805	MOVSD_XMM X2, 0x5b8d8d0(BX)(R8*8)	
					sim.Vx_i[k+1] = vx1
  0x4bfe99		f2420f119cc3d8d8b805	MOVSD_XMM X3, 0x5b8d8d8(BX)(R8*8)	
					sim.Vx_i[k+2] = vx2
  0x4bfea3		f2420f11a4c3e0d8b805	MOVSD_XMM X4, 0x5b8d8e0(BX)(R8*8)	
					sim.Vx_i[k+3] = vx3
  0x4bfead		f2420f11acc3e8d8b805	MOVSD_XMM X5, 0x5b8d8e8(BX)(R8*8)	
					sim.X_i[k] += vx0 * DT_I
  0x4bfeb7		f2420f10b4c3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R8*8), X6	
  0x4bfec1		f20f103d27da0000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X7	
  0x4bfec9		c4e2e9b9f7		VFMADD231SD X7, X2, X6			
  0x4bfece		f2420f11b4c3d0c63e05	MOVSD_XMM X6, 0x53ec6d0(BX)(R8*8)	
					sim.X_i[k+1] += vx1 * DT_I
  0x4bfed8		f2420f1094c3d8c63e05	MOVSD_XMM 0x53ec6d8(BX)(R8*8), X2	
  0x4bfee2		c4e2e1b9d7		VFMADD231SD X7, X3, X2			
  0x4bfee7		f2420f1194c3d8c63e05	MOVSD_XMM X2, 0x53ec6d8(BX)(R8*8)	
					sim.X_i[k+2] += vx2 * DT_I
  0x4bfef1		f2420f1094c3e0c63e05	MOVSD_XMM 0x53ec6e0(BX)(R8*8), X2	
  0x4bfefb		c4e2d9b9d7		VFMADD231SD X7, X4, X2			
  0x4bff00		f2420f1194c3e0c63e05	MOVSD_XMM X2, 0x53ec6e0(BX)(R8*8)	
					sim.X_i[k+3] += vx3 * DT_I
  0x4bff0a		f2420f1094c3e8c63e05	MOVSD_XMM 0x53ec6e8(BX)(R8*8), X2	
  0x4bff14		c4e2d1b9d7		VFMADD231SD X7, X5, X2			
  0x4bff19		f2420f1194c3e8c63e05	MOVSD_XMM X2, 0x53ec6e8(BX)(R8*8)	
				for ; k <= e-4; k += 4 {
  0x4bff23		4983c004		ADDQ $0x4, R8		
  0x4bff27		4939c0			CMPQ R8, AX		
  0x4bff2a		0f8fd9010000		JG 0x4c0109		
					c0_0 := sim.X_i[k] * INV_DX
  0x4bff30		4981f840420f00		CMPQ R8, $0xf4240			
  0x4bff37		0f8350020000		JAE 0x4c018d				
  0x4bff3d		f2420f1084c3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R8*8), X0	
  0x4bff47		f20f100d51db0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4bff4f		f20f59c1		MULSD X1, X0				
					p0 := min(max(int(c0_0), 0), N_G-2)
  0x4bff53		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x4bff58		4885c9			TESTQ CX, CX		
  0x4bff5b		7d03			JGE 0x4bff60		
  0x4bff5d		31c9			XORL CX, CX		
  0x4bff5f		90			NOPL			
  0x4bff60		4881f98e010000		CMPQ CX, $0x18e		
  0x4bff67		7e05			JLE 0x4bff6e		
  0x4bff69		b98e010000		MOVL $0x18e, CX		
					d0 := c0_0 - float64(p0)
  0x4bff6e		0f57d2			XORPS X2, X2		
  0x4bff71		f2480f2ad1		CVTSI2SDQ CX, X2	
  0x4bff76		f20f5cc2		SUBSD X2, X0		
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x4bff7a		f20f1094cbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X2	
  0x4bff83		f20f109ccbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X3	
  0x4bff8c		f20f5cda		SUBSD X2, X3				
					c0_1 := sim.X_i[k+1] * INV_DX
  0x4bff90		498d4801		LEAQ 0x1(R8), CX	
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x4bff94		c4e2f9b9d3		VFMADD231SD X3, X0, X2	
  0x4bff99		0f1f8000000000		NOPL 0(AX)		
					c0_1 := sim.X_i[k+1] * INV_DX
  0x4bffa0		4881f940420f00		CMPQ CX, $0xf4240			
  0x4bffa7		0f83d1010000		JAE 0x4c017e				
  0x4bffad		f2420f1084c3d8c63e05	MOVSD_XMM 0x53ec6d8(BX)(R8*8), X0	
  0x4bffb7		f20f59c1		MULSD X1, X0				
					p1 := min(max(int(c0_1), 0), N_G-2)
  0x4bffbb		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x4bffc0		4885c9			TESTQ CX, CX		
  0x4bffc3		7d02			JGE 0x4bffc7		
  0x4bffc5		31c9			XORL CX, CX		
  0x4bffc7		4881f98e010000		CMPQ CX, $0x18e		
  0x4bffce		7e05			JLE 0x4bffd5		
  0x4bffd0		b98e010000		MOVL $0x18e, CX		
					d1 := c0_1 - float64(p1)
  0x4bffd5		0f57db			XORPS X3, X3		
  0x4bffd8		f2480f2ad9		CVTSI2SDQ CX, X3	
  0x4bffdd		f20f5cc3		SUBSD X3, X0		
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x4bffe1		f20f109ccbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X3	
  0x4bffea		f20f10a4cbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X4	
  0x4bfff3		f20f5ce3		SUBSD X3, X4				
					c0_2 := sim.X_i[k+2] * INV_DX
  0x4bfff7		498d4802		LEAQ 0x2(R8), CX	
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x4bfffb		c4e2f9b9dc		VFMADD231SD X4, X0, X3	
					c0_2 := sim.X_i[k+2] * INV_DX
  0x4c0000		4881f940420f00		CMPQ CX, $0xf4240			
  0x4c0007		0f8362010000		JAE 0x4c016f				
  0x4c000d		f2420f1084c3e0c63e05	MOVSD_XMM 0x53ec6e0(BX)(R8*8), X0	
  0x4c0017		f20f59c1		MULSD X1, X0				
					p2 := min(max(int(c0_2), 0), N_G-2)
  0x4c001b		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x4c0020		4885c9			TESTQ CX, CX		
  0x4c0023		7d02			JGE 0x4c0027		
  0x4c0025		31c9			XORL CX, CX		
  0x4c0027		4881f98e010000		CMPQ CX, $0x18e		
  0x4c002e		7e05			JLE 0x4c0035		
  0x4c0030		b98e010000		MOVL $0x18e, CX		
					d2 := c0_2 - float64(p2)
  0x4c0035		0f57e4			XORPS X4, X4		
  0x4c0038		f2480f2ae1		CVTSI2SDQ CX, X4	
  0x4c003d		f20f5cc4		SUBSD X4, X0		
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x4c0041		f20f10a4cbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X4	
  0x4c004a		f20f10accbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X5	
  0x4c0053		f20f5cec		SUBSD X4, X5				
					c0_3 := sim.X_i[k+3] * INV_DX
  0x4c0057		498d4803		LEAQ 0x3(R8), CX	
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x4c005b		c4e2f9b9e5		VFMADD231SD X5, X0, X4	
					c0_3 := sim.X_i[k+3] * INV_DX
  0x4c0060		4881f940420f00		CMPQ CX, $0xf4240			
  0x4c0067		0f83f8000000		JAE 0x4c0165				
  0x4c006d		f2420f1084c3e8c63e05	MOVSD_XMM 0x53ec6e8(BX)(R8*8), X0	
  0x4c0077		f20f59c1		MULSD X1, X0				
					p3 := min(max(int(c0_3), 0), N_G-2)
  0x4c007b		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x4c0080		4885c9			TESTQ CX, CX		
  0x4c0083		7d02			JGE 0x4c0087		
  0x4c0085		31c9			XORL CX, CX		
  0x4c0087		4881f98e010000		CMPQ CX, $0x18e		
  0x4c008e		0f8e94fdffff		JLE 0x4bfe28		
  0x4c0094		b98e010000		MOVL $0x18e, CX		
  0x4c0099		e98afdffff		JMP 0x4bfe28		
					d := c0 - float64(p)
  0x4c009e		0f57d2			XORPS X2, X2		
  0x4c00a1		f2480f2ad0		CVTSI2SDQ AX, X2	
  0x4c00a6		f20f5cc2		SUBSD X2, X0		
					ex := sim.Efield[p] + d*(sim.Efield[p+1]-sim.Efield[p])
  0x4c00aa		f20f1094c3d00e2707	MOVSD_XMM 0x7270ed0(BX)(AX*8), X2	
  0x4c00b3		f20f109cc3d80e2707	MOVSD_XMM 0x7270ed8(BX)(AX*8), X3	
  0x4c00bc		f20f5cda		SUBSD X2, X3				
  0x4c00c0		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
					sim.Vx_i[k] += ex * FACTOR_I
  0x4c00c5		f20f10056bd80000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x4c00cd		f20f59d0		MULSD X0, X2				
  0x4c00d1		f2420f5894c3d0d8b805	ADDSD 0x5b8d8d0(BX)(R8*8), X2		
  0x4c00db		f2420f1194c3d0d8b805	MOVSD_XMM X2, 0x5b8d8d0(BX)(R8*8)	
					sim.X_i[k] += sim.Vx_i[k] * DT_I
  0x4c00e5		f2420f109cc3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R8*8), X3	
  0x4c00ef		f20f1025f9d70000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X4	
  0x4c00f7		c4e2e9b9dc		VFMADD231SD X4, X2, X3			
  0x4c00fc		f2420f119cc3d0c63e05	MOVSD_XMM X3, 0x53ec6d0(BX)(R8*8)	
				for ; k < e; k++ {
  0x4c0106		49ffc0			INCQ R8			
  0x4c0109		4939f0			CMPQ R8, SI		
  0x4c010c		7d48			JGE 0x4c0156		
					c0 := sim.X_i[k] * INV_DX
  0x4c010e		4981f840420f00		CMPQ R8, $0xf4240			
  0x4c0115		7341			JAE 0x4c0158				
  0x4c0117		f2420f1084c3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R8*8), X0	
  0x4c0121		f20f100d77d90000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4c0129		f20f59c1		MULSD X1, X0				
					p := min(max(int(c0), 0), N_G-2)
  0x4c012d		f2480f2cc0		CVTTSD2SIQ X0, AX	
  0x4c0132		4885c0			TESTQ AX, AX		
  0x4c0135		7d09			JGE 0x4c0140		
  0x4c0137		31c0			XORL AX, AX		
  0x4c0139		0f1f8000000000		NOPL 0(AX)		
  0x4c0140		483d8e010000		CMPQ AX, $0x18e		
  0x4c0146		0f8e52ffffff		JLE 0x4c009e		
  0x4c014c		b88e010000		MOVL $0x18e, AX		
  0x4c0151		e948ffffff		JMP 0x4c009e		
		})
  0x4c0156		5d			POPQ BP			
  0x4c0157		c3			RET			
					c0 := sim.X_i[k] * INV_DX
  0x4c0158		b840420f00		MOVL $0xf4240, AX		
  0x4c015d		0f1f00			NOPL 0(AX)			
  0x4c0160		e83b19fcff		CALL runtime.panicBounds(SB)	
					c0_3 := sim.X_i[k+3] * INV_DX
  0x4c0165		b840420f00		MOVL $0xf4240, AX		
  0x4c016a		e83119fcff		CALL runtime.panicBounds(SB)	
					c0_2 := sim.X_i[k+2] * INV_DX
  0x4c016f		b840420f00		MOVL $0xf4240, AX		
  0x4c0174		b940420f00		MOVL $0xf4240, CX		
  0x4c0179		e82219fcff		CALL runtime.panicBounds(SB)	
					c0_1 := sim.X_i[k+1] * INV_DX
  0x4c017e		b840420f00		MOVL $0xf4240, AX		
  0x4c0183		b940420f00		MOVL $0xf4240, CX		
  0x4c0188		e81319fcff		CALL runtime.panicBounds(SB)	
					c0_0 := sim.X_i[k] * INV_DX
  0x4c018d		b840420f00		MOVL $0xf4240, AX		
  0x4c0192		e80919fcff		CALL runtime.panicBounds(SB)	
					_ = sim.X_i[e-1]
  0x4c0197		b940420f00		MOVL $0xf4240, CX		
  0x4c019c		0f1f4000		NOPL 0(AX)			
  0x4c01a0		e8fb18fcff		CALL runtime.panicBounds(SB)	
					c1 = float64(p) + 1.0 - c0
  0x4c01a5		0f57d2			XORPS X2, X2				
  0x4c01a8		f2480f2ad0		CVTSI2SDQ AX, X2			
  0x4c01ad		f20f101dfbd70000	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x4c01b5		f20f58da		ADDSD X2, X3				
  0x4c01b9		f20f5cd8		SUBSD X0, X3				
					c2 = c0 - float64(p)
  0x4c01bd		f20f5cc2		SUBSD X2, X0		
					e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]
  0x4c01c1		f20f1094c3d00e2707	MOVSD_XMM 0x7270ed0(BX)(AX*8), X2	
  0x4c01ca		f20f59d3		MULSD X3, X2				
  0x4c01ce		f20f10a4c3d80e2707	MOVSD_XMM 0x7270ed8(BX)(AX*8), X4	
  0x4c01d7		c4e2d9b9d0		VFMADD231SD X0, X4, X2			
					mean_v = sim.Vx_i[k] + 0.5*e_x*FACTOR_I
  0x4c01dc		f20f1025b4d70000	MOVSD_XMM $f64.3fe0000000000000(SB), X4	
  0x4c01e4		f20f59e2		MULSD X2, X4				
  0x4c01e8		f20f102d48d70000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X5	
  0x4c01f0		f20f59e5		MULSD X5, X4				
  0x4c01f4		f2420f58a4c3d0d8b805	ADDSD 0x5b8d8d0(BX)(R8*8), X4		
					diag.counter_i[p] += c1
  0x4c01fe		498d0c11		LEAQ 0(R9)(DX*1), CX		
  0x4c0202		f20f1034c1		MOVSD_XMM 0(CX)(AX*8), X6	
  0x4c0207		f20f58f3		ADDSD X3, X6			
  0x4c020b		f20f1134c1		MOVSD_XMM X6, 0(CX)(AX*8)	
					diag.counter_i[p+1] += c2
  0x4c0210		f20f1074c108		MOVSD_XMM 0x8(CX)(AX*8), X6	
  0x4c0216		f20f58f0		ADDSD X0, X6			
  0x4c021a		f20f1174c108		MOVSD_XMM X6, 0x8(CX)(AX*8)	
					diag.ui[p] += c1 * mean_v
  0x4c0220		498d0c11		LEAQ 0(R9)(DX*1), CX		
  0x4c0224		488d89800c0000		LEAQ 0xc80(CX), CX		
  0x4c022b		f20f1034c1		MOVSD_XMM 0(CX)(AX*8), X6	
  0x4c0230		c4e2e1b9f4		VFMADD231SD X4, X3, X6		
  0x4c0235		f20f1134c1		MOVSD_XMM X6, 0(CX)(AX*8)	
					diag.ui[p+1] += c2 * mean_v
  0x4c023a		f20f1074c108		MOVSD_XMM 0x8(CX)(AX*8), X6	
  0x4c0240		c4e2d9b9f0		VFMADD231SD X0, X4, X6		
  0x4c0245		f20f1174c108		MOVSD_XMM X6, 0x8(CX)(AX*8)	
					v_sqr = mean_v*mean_v + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x4c024b		f20f59e4		MULSD X4, X4				
  0x4c024f		f2420f10b4c3d0ea3206	MOVSD_XMM 0x632ead0(BX)(R8*8), X6	
  0x4c0259		c4e2c9b9e6		VFMADD231SD X6, X6, X4			
  0x4c025e		f2420f10b4c3d0fcac06	MOVSD_XMM 0x6acfcd0(BX)(R8*8), X6	
  0x4c0268		c4e2c9b9e6		VFMADD231SD X6, X6, X4			
					energy = 0.5 * AR_MASS * v_sqr * INV_EV_TO_J
  0x4c026d		f20f103523d60000	MOVSD_XMM $f64.3aa4879de14d0b24(SB), X6	
  0x4c0275		f20f59e6		MULSD X6, X4				
  0x4c0279		f20f103d4fd80000	MOVSD_XMM $f64.43d5a792def818e8(SB), X7	
  0x4c0281		f20f59e7		MULSD X7, X4				
					diag.meanei[p] += c1 * energy
  0x4c0285		498d0c11		LEAQ 0(R9)(DX*1), CX		
  0x4c0289		488d8900190000		LEAQ 0x1900(CX), CX		
  0x4c0290		f2440f1004c1		MOVSD_XMM 0(CX)(AX*8), X8	
  0x4c0296		c462e1b9c4		VFMADD231SD X4, X3, X8		
  0x4c029b		f2440f1104c1		MOVSD_XMM X8, 0(CX)(AX*8)	
					diag.meanei[p+1] += c2 * energy
  0x4c02a1		f20f105cc108		MOVSD_XMM 0x8(CX)(AX*8), X3	
  0x4c02a7		c4e2d9b9d8		VFMADD231SD X0, X4, X3		
  0x4c02ac		f20f115cc108		MOVSD_XMM X3, 0x8(CX)(AX*8)	
					sim.Vx_i[k] += e_x * FACTOR_I
  0x4c02b2		f2420f1084c3d0d8b805	MOVSD_XMM 0x5b8d8d0(BX)(R8*8), X0	
  0x4c02bc		c4e2d1b9c2		VFMADD231SD X2, X5, X0			
  0x4c02c1		f2420f1184c3d0d8b805	MOVSD_XMM X0, 0x5b8d8d0(BX)(R8*8)	
					sim.X_i[k] += sim.Vx_i[k] * DT_I
  0x4c02cb		f2420f1094c3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R8*8), X2	
  0x4c02d5		f20f101d13d60000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X3	
  0x4c02dd		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
  0x4c02e2		f2420f1194c3d0c63e05	MOVSD_XMM X2, 0x53ec6d0(BX)(R8*8)	
				for k := s; k < e; k++ {
  0x4c02ec		49ffc0			INCQ R8			
  0x4c02ef		4939f0			CMPQ R8, SI		
  0x4c02f2		0f8d5efeffff		JGE 0x4c0156		
  0x4c02f8		0f1f840000000000	NOPL 0(AX)(AX*1)	
					c0 = sim.X_i[k] * INV_DX
  0x4c0300		4981f840420f00		CMPQ R8, $0xf4240			
  0x4c0307		733c			JAE 0x4c0345				
  0x4c0309		f2420f1084c3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R8*8), X0	
  0x4c0313		f20f100d85d70000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x4c031b		f20f59c1		MULSD X1, X0				
					p = min(max(int(c0), 0), N_G-2)
  0x4c031f		f2480f2cc0		CVTTSD2SIQ X0, AX	
  0x4c0324		4885c0			TESTQ AX, AX		
  0x4c0327		7d02			JGE 0x4c032b		
  0x4c0329		31c0			XORL AX, AX		
  0x4c032b		483d8e010000		CMPQ AX, $0x18e		
  0x4c0331		0f8e6efeffff		JLE 0x4c01a5		
  0x4c0337		b88e010000		MOVL $0x18e, AX		
  0x4c033c		0f1f4000		NOPL 0(AX)		
  0x4c0340		e960feffff		JMP 0x4c01a5		
					c0 = sim.X_i[k] * INV_DX
  0x4c0345		b840420f00		MOVL $0xf4240, AX		
  0x4c034a		e85117fcff		CALL runtime.panicBounds(SB)	
				diag := &sim.WorkerIDiag[workerID]
  0x4c034f		e84c17fcff		CALL runtime.panicBounds(SB)	
  0x4c0354		90			NOPL				
