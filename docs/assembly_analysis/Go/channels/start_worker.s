TEXT gopic.(*SimulationState).startWorker(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/worker.go
func (sim *SimulationState) startWorker(workerID int) {
  0x1400c5f40		4c8d6424a0		LEAQ -0x60(SP), R12	
  0x1400c5f45		4d3b6610		CMPQ R12, 0x10(R14)	
  0x1400c5f49		0f869c190000		JBE 0x1400c78eb		
  0x1400c5f4f		55			PUSHQ BP		
  0x1400c5f50		4889e5			MOVQ SP, BP		
  0x1400c5f53		4881ecd8000000		SUBQ $0xd8, SP		
  0x1400c5f5a		48899c24f0000000	MOVQ BX, 0xf0(SP)	
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c5f62		8400			TESTB AL, 0(AX)		
  0x1400c5f64		488b88402eba07		MOVQ 0x7ba2e40(AX), CX	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c5f6b		4839cb			CMPQ BX, CX		
  0x1400c5f6e		0f8371190000		JAE 0x1400c78e5		
  0x1400c5f74		48898424e8000000	MOVQ AX, 0xe8(SP)	
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c5f7c		48898c24c0000000	MOVQ CX, 0xc0(SP)	
  0x1400c5f84		488b90382eba07		MOVQ 0x7ba2e38(AX), DX	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c5f8b		488b14da			MOVQ 0(DX)(BX*8), DX		
  0x1400c5f8f		48899424d0000000		MOVQ DX, 0xd0(SP)		
  0x1400c5f97		eb08				JMP 0x1400c5fa1			
  0x1400c5f99		488b9424d0000000		MOVQ 0xd0(SP), DX		
  0x1400c5fa1		4889d0				MOVQ DX, AX			
  0x1400c5fa4		488d9c24c8000000		LEAQ 0xc8(SP), BX		
  0x1400c5fac		e8efb5f4ff			CALL runtime.chanrecv2(SB)	
  0x1400c5fb1		84c0				TESTL AL, AL			
  0x1400c5fb3		0f84b2040000			JE 0x1400c646b			
  0x1400c5fb9		488b9424c8000000		MOVQ 0xc8(SP), DX		
  0x1400c5fc1		48c78424c800000000000000	MOVQ $0x0, 0xc8(SP)		
		switch cmd {
  0x1400c5fcd		4883fa08		CMPQ DX, $0x8								
  0x1400c5fd1		77c6			JA 0x1400c5f99								
  0x1400c5fd3		488d0526420100		LEAQ internal/runtime/gc/scan.expandAVX512_64_outShufLo+64(SB), AX	
  0x1400c5fda		ff24d0			JMP 0(AX)(DX*8)								
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c5fdd		488b9424e8000000	MOVQ 0xe8(SP), DX	
  0x1400c5fe5		488bb2c07e5603		MOVQ 0x3567ec0(DX), SI	
  0x1400c5fec		4c8b8424c0000000	MOVQ 0xc0(SP), R8	
  0x1400c5ff4		498d0430		LEAQ 0(R8)(SI*1), AX	
  0x1400c5ff8		488d40ff		LEAQ -0x1(AX), AX	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c5ffc		4889d1			MOVQ DX, CX		
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c5fff		4899			CQO			
  0x1400c6001		49f7f8			IDIVQ R8		
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c6004		488b9424f0000000	MOVQ 0xf0(SP), DX	
  0x1400c600c		4c8d4a01		LEAQ 0x1(DX), R9	
  0x1400c6010		4c0fafc8		IMULQ AX, R9		
			densityE := &sim.WorkerEDensity[workerID]
  0x1400c6014		4c8b5108		MOVQ 0x8(CX), R10	
			start := workerID * chunkSize
  0x1400c6018		480fafc2		IMULQ DX, AX		
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c601c		4c39ce			CMPQ SI, R9		
  0x1400c601f		4c0f4cce		CMOVL SI, R9		
			densityE := &sim.WorkerEDensity[workerID]
  0x1400c6023		4939d2			CMPQ R10, DX		
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c6026		0f86b1180000		JBE 0x1400c78dd		
			densityE := &sim.WorkerEDensity[workerID]
  0x1400c602c		488b31			MOVQ 0(CX), SI		
  0x1400c602f		4869d2800c0000		IMULQ $0xc80, DX, DX	
			for i := range N_G {
  0x1400c6036		488d3c16		LEAQ 0(SI)(DX*1), DI	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c603a		4889cb			MOVQ CX, BX		
			for i := range N_G {
  0x1400c603d		b990010000		MOVL $0x190, CX		
			start := workerID * chunkSize
  0x1400c6042		4989c2			MOVQ AX, R10		
			for i := range N_G {
  0x1400c6045		31c0			XORL AX, AX		
  0x1400c6047		f348ab			REP; STOSQ AX, ES:0(DI)	
			densityE := &sim.WorkerEDensity[workerID]
  0x1400c604a		4801f2			ADDQ SI, DX		
			if start < end {
  0x1400c604d		4d39d1			CMPQ R9, R10		
  0x1400c6050		0f8f35180000		JG 0x1400c788b		
  0x1400c6056		e9d2170000		JMP 0x1400c782d		
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x1400c605b		488b9424e8000000	MOVQ 0xe8(SP), DX	
  0x1400c6063		488bb2c87e5603		MOVQ 0x3567ec8(DX), SI	
  0x1400c606a		4c8b8424c0000000	MOVQ 0xc0(SP), R8	
  0x1400c6072		498d0430		LEAQ 0(R8)(SI*1), AX	
  0x1400c6076		488d40ff		LEAQ -0x1(AX), AX	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c607a		4889d1			MOVQ DX, CX		
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x1400c607d		4899			CQO			
  0x1400c607f		49f7f8			IDIVQ R8		
			start := workerID * chunkSize
  0x1400c6082		488b9424f0000000	MOVQ 0xf0(SP), DX	
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c608a		4c8d4a01		LEAQ 0x1(DX), R9	
  0x1400c608e		4c0fafc8		IMULQ AX, R9		
			densityI := &sim.WorkerIDensity[workerID]
  0x1400c6092		4c8b5120		MOVQ 0x20(CX), R10	
			start := workerID * chunkSize
  0x1400c6096		480fafc2		IMULQ DX, AX		
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c609a		4c39ce			CMPQ SI, R9		
  0x1400c609d		4c0f4cce		CMOVL SI, R9		
			densityI := &sim.WorkerIDensity[workerID]
  0x1400c60a1		4939d2			CMPQ R10, DX		
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c60a4		0f867e170000		JBE 0x1400c7828		
			densityI := &sim.WorkerIDensity[workerID]
  0x1400c60aa		488b7118		MOVQ 0x18(CX), SI	
  0x1400c60ae		4869d2800c0000		IMULQ $0xc80, DX, DX	
			for i := range N_G {
  0x1400c60b5		488d3c16		LEAQ 0(SI)(DX*1), DI	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c60b9		4889cb			MOVQ CX, BX		
			for i := range N_G {
  0x1400c60bc		b990010000		MOVL $0x190, CX		
			start := workerID * chunkSize
  0x1400c60c1		4989c2			MOVQ AX, R10		
			for i := range N_G {
  0x1400c60c4		31c0			XORL AX, AX		
  0x1400c60c6		f348ab			REP; STOSQ AX, ES:0(DI)	
			densityI := &sim.WorkerIDensity[workerID]
  0x1400c60c9		4801f2			ADDQ SI, DX		
			if start < end {
  0x1400c60cc		4d39d1			CMPQ R9, R10		
  0x1400c60cf		0f8f03170000		JG 0x1400c77d8		
  0x1400c60d5		e9a4160000		JMP 0x1400c777e		
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c60da		488b9424e8000000	MOVQ 0xe8(SP), DX	
  0x1400c60e2		488bb2c07e5603		MOVQ 0x3567ec0(DX), SI	
  0x1400c60e9		4c8b8424c0000000	MOVQ 0xc0(SP), R8	
  0x1400c60f1		498d0430		LEAQ 0(R8)(SI*1), AX	
  0x1400c60f5		488d40ff		LEAQ -0x1(AX), AX	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c60f9		4889d1			MOVQ DX, CX		
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c60fc		4899			CQO			
  0x1400c60fe		49f7f8			IDIVQ R8		
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c6101		488b9424f0000000	MOVQ 0xf0(SP), DX	
  0x1400c6109		4c8d4a01		LEAQ 0x1(DX), R9	
  0x1400c610d		4c0fafc8		IMULQ AX, R9		
			start := workerID * chunkSize
  0x1400c6111		480fafc2		IMULQ DX, AX		
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c6115		4c39ce			CMPQ SI, R9		
  0x1400c6118		4c0f4cce		CMOVL SI, R9		
			if sim.Measurement_mode {
  0x1400c611c		80b9e02dba0700		CMPB 0x7ba2de0(CX), $0x0	
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c6123		743b			JE 0x1400c6160		
				diag := &sim.WorkerEDiag[workerID]
  0x1400c6125		488b7138		MOVQ 0x38(CX), SI	
  0x1400c6129		4839d6			CMPQ SI, DX		
  0x1400c612c		0f8647160000		JBE 0x1400c7779		
  0x1400c6132		488b7130		MOVQ 0x30(CX), SI	
  0x1400c6136		4869d2c0700000		IMULQ $0x70c0, DX, DX	
  0x1400c613d		488d3c16		LEAQ 0(SI)(DX*1), DI	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c6141		4889cb			MOVQ CX, BX		
				*diag = electronWorkerDiagnostics{}
  0x1400c6144		b9180e0000		MOVL $0xe18, CX		
			start := workerID * chunkSize
  0x1400c6149		4989c2			MOVQ AX, R10		
				*diag = electronWorkerDiagnostics{}
  0x1400c614c		31c0			XORL AX, AX		
  0x1400c614e		f348ab			REP; STOSQ AX, ES:0(DI)	
				if start < end {
  0x1400c6151		4d39d1			CMPQ R9, R10		
  0x1400c6154		0f8f3c130000		JG 0x1400c7496		
  0x1400c615a		e9fa120000		JMP 0x1400c7459		
  0x1400c615f		90			NOPL			
				if end > start {
  0x1400c6160		4939c1			CMPQ R9, AX		
  0x1400c6163		7e11			JLE 0x1400c6176		
					_ = sim.X_e[end-1]
  0x1400c6165		498d51ff		LEAQ -0x1(R9), DX	
  0x1400c6169		4881fa40420f00		CMPQ DX, $0xf4240	
  0x1400c6170		0f83d9120000		JAE 0x1400c744f		
				for ; k <= end-4; k += 4 {
  0x1400c6176		498d51fc		LEAQ -0x4(R9), DX	
  0x1400c617a		e94a100000		JMP 0x1400c71c9		
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x1400c617f		488b9424e8000000	MOVQ 0xe8(SP), DX	
  0x1400c6187		488bb2c87e5603		MOVQ 0x3567ec8(DX), SI	
  0x1400c618e		4c8b8424c0000000	MOVQ 0xc0(SP), R8	
  0x1400c6196		498d0430		LEAQ 0(R8)(SI*1), AX	
  0x1400c619a		488d40ff		LEAQ -0x1(AX), AX	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c619e		4889d1			MOVQ DX, CX		
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x1400c61a1		4899			CQO			
  0x1400c61a3		49f7f8			IDIVQ R8		
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c61a6		488b9424f0000000	MOVQ 0xf0(SP), DX	
  0x1400c61ae		4c8d4a01		LEAQ 0x1(DX), R9	
  0x1400c61b2		4c0fafc8		IMULQ AX, R9		
			start := workerID * chunkSize
  0x1400c61b6		480fafc2		IMULQ DX, AX		
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c61ba		4c39ce			CMPQ SI, R9		
  0x1400c61bd		4c0f4cce		CMOVL SI, R9		
			if sim.Measurement_mode {
  0x1400c61c1		80b9e02dba0700		CMPB 0x7ba2de0(CX), $0x0	
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c61c8		743b			JE 0x1400c6205		
				diag := &sim.WorkerIDiag[workerID]
  0x1400c61ca		488b7150		MOVQ 0x50(CX), SI	
  0x1400c61ce		4839d6			CMPQ SI, DX		
  0x1400c61d1		0f86ee0e0000		JBE 0x1400c70c5		
  0x1400c61d7		488b7148		MOVQ 0x48(CX), SI	
  0x1400c61db		4869d240320000		IMULQ $0x3240, DX, DX	
  0x1400c61e2		488d3c16		LEAQ 0(SI)(DX*1), DI	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c61e6		4889cb			MOVQ CX, BX		
				*diag = ionWorkerDiagnostics{}
  0x1400c61e9		b948060000		MOVL $0x648, CX		
			start := workerID * chunkSize
  0x1400c61ee		4989c2			MOVQ AX, R10		
				*diag = ionWorkerDiagnostics{}
  0x1400c61f1		31c0			XORL AX, AX		
  0x1400c61f3		f348ab			REP; STOSQ AX, ES:0(DI)	
				if start < end {
  0x1400c61f6		4d39d1			CMPQ R9, R10		
  0x1400c61f9		0f8f690e0000		JG 0x1400c7068		
  0x1400c61ff		90			NOPL			
  0x1400c6200		e9140d0000		JMP 0x1400c6f19		
				if end > start {
  0x1400c6205		4939c1			CMPQ R9, AX		
  0x1400c6208		7e11			JLE 0x1400c621b		
					_ = sim.X_i[end-1]
  0x1400c620a		498d51ff		LEAQ -0x1(R9), DX	
  0x1400c620e		4881fa40420f00		CMPQ DX, $0xf4240	
  0x1400c6215		0f83f40c0000		JAE 0x1400c6f0f		
				for ; k <= end-4; k += 4 {
  0x1400c621b		498d51fc		LEAQ -0x4(R9), DX	
  0x1400c621f		90			NOPL			
  0x1400c6220		e96f0a0000		JMP 0x1400c6c94		
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c6225		488b8c24e8000000	MOVQ 0xe8(SP), CX	
  0x1400c622d		488b91c07e5603		MOVQ 0x3567ec0(CX), DX	
  0x1400c6234		488bb424c0000000	MOVQ 0xc0(SP), SI	
  0x1400c623c		488d0416		LEAQ 0(SI)(DX*1), AX	
  0x1400c6240		488d40ff		LEAQ -0x1(AX), AX	
  0x1400c6244		4889d3			MOVQ DX, BX		
  0x1400c6247		4899			CQO			
  0x1400c6249		48f7fe			IDIVQ SI		
			start := workerID * chunkSize
  0x1400c624c		488b9424f0000000	MOVQ 0xf0(SP), DX	
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c6254		488d7a01		LEAQ 0x1(DX), DI	
  0x1400c6258		480faff8		IMULQ AX, DI		
			diag := &sim.WorkerEDiag[workerID]
  0x1400c625c		4c8b4138		MOVQ 0x38(CX), R8	
			start := workerID * chunkSize
  0x1400c6260		480fafc2		IMULQ DX, AX		
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c6264		4839fb			CMPQ BX, DI		
  0x1400c6267		480f4cfb		CMOVL BX, DI		
			diag := &sim.WorkerEDiag[workerID]
  0x1400c626b		4939d0			CMPQ R8, DX		
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c626e		0f862b090000		JBE 0x1400c6b9f		
			diag := &sim.WorkerEDiag[workerID]
  0x1400c6274		4c8b4130		MOVQ 0x30(CX), R8	
  0x1400c6278		4869d2c0700000		IMULQ $0x70c0, DX, DX	
			diag.abs_pow = 0
  0x1400c627f		4d8d0c10		LEAQ 0(R8)(DX*1), R9	
  0x1400c6283		4d8d8990700000		LEAQ 0x7090(R9), R9	
  0x1400c628a		450f1139		MOVUPS X15, 0(R9)	
			if start < end {
  0x1400c628e		4839c7			CMPQ DI, AX		
  0x1400c6291		0f8f76080000		JG 0x1400c6b0d		
  0x1400c6297		e950080000		JMP 0x1400c6aec		
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x1400c629c		488b8c24e8000000	MOVQ 0xe8(SP), CX	
  0x1400c62a4		488b91c87e5603		MOVQ 0x3567ec8(CX), DX	
  0x1400c62ab		488bb424c0000000	MOVQ 0xc0(SP), SI	
  0x1400c62b3		488d0416		LEAQ 0(SI)(DX*1), AX	
  0x1400c62b7		488d40ff		LEAQ -0x1(AX), AX	
  0x1400c62bb		4889d3			MOVQ DX, BX		
  0x1400c62be		4899			CQO			
  0x1400c62c0		48f7fe			IDIVQ SI		
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c62c3		488b9424f0000000	MOVQ 0xf0(SP), DX	
  0x1400c62cb		488d7a01		LEAQ 0x1(DX), DI	
  0x1400c62cf		480faff8		IMULQ AX, DI		
			diag := &sim.WorkerIDiag[workerID]
  0x1400c62d3		4c8b4150		MOVQ 0x50(CX), R8	
			start := workerID * chunkSize
  0x1400c62d7		480fafc2		IMULQ DX, AX		
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c62db		4839fb			CMPQ BX, DI		
  0x1400c62de		480f4cfb		CMOVL BX, DI		
			diag := &sim.WorkerIDiag[workerID]
  0x1400c62e2		4939d0			CMPQ R8, DX		
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c62e5		0f86fc070000		JBE 0x1400c6ae7		
			diag := &sim.WorkerIDiag[workerID]
  0x1400c62eb		4c8b4148		MOVQ 0x48(CX), R8	
  0x1400c62ef		4869d240320000		IMULQ $0x3240, DX, DX	
			diag.abs_pow = 0
  0x1400c62f6		4d8d0c10		LEAQ 0(R8)(DX*1), R9	
  0x1400c62fa		4d8d8980250000		LEAQ 0x2580(R9), R9	
  0x1400c6301		450f1139		MOVUPS X15, 0(R9)	
			for idx := range N_IFED {
  0x1400c6305		4531c9			XORL R9, R9		
  0x1400c6308		e91a060000		JMP 0x1400c6927		
			sim.WorkerNewElectrons[workerID] = sim.WorkerNewElectrons[workerID][:0]
  0x1400c630d		488b8c24e8000000	MOVQ 0xe8(SP), CX		
  0x1400c6315		488b9198000000		MOVQ 0x98(CX), DX		
  0x1400c631c		488bb424f0000000	MOVQ 0xf0(SP), SI		
  0x1400c6324		4839d6			CMPQ SI, DX			
  0x1400c6327		0f83cc050000		JAE 0x1400c68f9			
  0x1400c632d		488d1476		LEAQ 0(SI)(SI*2), DX		
  0x1400c6331		488bb190000000		MOVQ 0x90(CX), SI		
  0x1400c6338		48c744d60800000000	MOVQ $0x0, 0x8(SI)(DX*8)	
			sim.WorkerNewIons[workerID] = sim.WorkerNewIons[workerID][:0]
  0x1400c6341		488b91b0000000		MOVQ 0xb0(CX), DX		
  0x1400c6348		488bb424f0000000	MOVQ 0xf0(SP), SI		
  0x1400c6350		4839d6			CMPQ SI, DX			
  0x1400c6353		0f839b050000		JAE 0x1400c68f4			
  0x1400c6359		488d1476		LEAQ 0(SI)(SI*2), DX		
  0x1400c635d		488bb1a8000000		MOVQ 0xa8(CX), SI		
  0x1400c6364		48c744d60800000000	MOVQ $0x0, 0x8(SI)(DX*8)	
			if len(sim.CandidatesE) > 0 {
  0x1400c636d		488b91602eba07		MOVQ 0x7ba2e60(CX), DX	
  0x1400c6374		4885d2			TESTQ DX, DX		
  0x1400c6377		7453			JE 0x1400c63cc		
				chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x1400c6379		488bb424c0000000	MOVQ 0xc0(SP), SI	
  0x1400c6381		488d0432		LEAQ 0(DX)(SI*1), AX	
  0x1400c6385		488d40ff		LEAQ -0x1(AX), AX	
			if len(sim.CandidatesE) > 0 {
  0x1400c6389		4889d3			MOVQ DX, BX		
				chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x1400c638c		31d2			XORL DX, DX		
  0x1400c638e		48f7f6			DIVQ SI			
				end := min((workerID+1)*chunkSize, totalCandidates)
  0x1400c6391		488b9424f0000000	MOVQ 0xf0(SP), DX	
				start := workerID * chunkSize
  0x1400c6399		4889d7			MOVQ DX, DI		
  0x1400c639c		480fafd0		IMULQ AX, DX		
				end := min((workerID+1)*chunkSize, totalCandidates)
  0x1400c63a0		48ffc7			INCQ DI			
  0x1400c63a3		480faff8		IMULQ AX, DI		
  0x1400c63a7		4839fb			CMPQ BX, DI		
  0x1400c63aa		480f4cfb		CMOVL BX, DI		
				if start < end {
  0x1400c63ae		4839d7			CMPQ DI, DX		
				end := min((workerID+1)*chunkSize, totalCandidates)
  0x1400c63b1		7e12			JLE 0x1400c63c5		
  0x1400c63b3		4889bc24b8000000	MOVQ DI, 0xb8(SP)	
  0x1400c63bb		31c0			XORL AX, AX		
  0x1400c63bd		0f1f00			NOPL 0(AX)		
					for i := start; i < end; i++ {
  0x1400c63c0		e9bc030000		JMP 0x1400c6781		
  0x1400c63c5		31c0			XORL AX, AX		
				end := min((workerID+1)*chunkSize, totalCandidates)
  0x1400c63c7		e968030000		JMP 0x1400c6734		
  0x1400c63cc		31c0			XORL AX, AX		
			if len(sim.CandidatesE) > 0 {
  0x1400c63ce		e961030000		JMP 0x1400c6734		
			sim.WorkerNewIons[workerID] = sim.WorkerNewIons[workerID][:0]
  0x1400c63d3		488b8c24e8000000	MOVQ 0xe8(SP), CX		
  0x1400c63db		488b91b0000000		MOVQ 0xb0(CX), DX		
  0x1400c63e2		488bb424f0000000	MOVQ 0xf0(SP), SI		
  0x1400c63ea		4839d6			CMPQ SI, DX			
  0x1400c63ed		0f833c030000		JAE 0x1400c672f			
  0x1400c63f3		488d1476		LEAQ 0(SI)(SI*2), DX		
  0x1400c63f7		488bb1a8000000		MOVQ 0xa8(CX), SI		
  0x1400c63fe		48c744d60800000000	MOVQ $0x0, 0x8(SI)(DX*8)	
			if len(sim.CandidatesI) > 0 {
  0x1400c6407		488b91782eba07		MOVQ 0x7ba2e78(CX), DX	
  0x1400c640e		4885d2			TESTQ DX, DX		
  0x1400c6411		744a			JE 0x1400c645d		
				chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x1400c6413		488bb424c0000000	MOVQ 0xc0(SP), SI	
  0x1400c641b		488d0432		LEAQ 0(DX)(SI*1), AX	
  0x1400c641f		488d40ff		LEAQ -0x1(AX), AX	
			if len(sim.CandidatesI) > 0 {
  0x1400c6423		4889d3			MOVQ DX, BX		
				chunkSize := (totalCandidates + numWorkers - 1) / numWorkers
  0x1400c6426		31d2			XORL DX, DX		
  0x1400c6428		48f7f6			DIVQ SI			
				end := min((workerID+1)*chunkSize, totalCandidates)
  0x1400c642b		488b9424f0000000	MOVQ 0xf0(SP), DX	
				start := workerID * chunkSize
  0x1400c6433		4889d7			MOVQ DX, DI		
  0x1400c6436		480fafd0		IMULQ AX, DX		
				end := min((workerID+1)*chunkSize, totalCandidates)
  0x1400c643a		48ffc7			INCQ DI			
  0x1400c643d		480faff8		IMULQ AX, DI		
  0x1400c6441		4839fb			CMPQ BX, DI		
  0x1400c6444		480f4cfb		CMOVL BX, DI		
				if start < end {
  0x1400c6448		4839d7			CMPQ DI, DX		
				end := min((workerID+1)*chunkSize, totalCandidates)
  0x1400c644b		7e0c			JLE 0x1400c6459		
  0x1400c644d		4889bc24b0000000	MOVQ DI, 0xb0(SP)	
  0x1400c6455		31c0			XORL AX, AX		
					for i := start; i < end; i++ {
  0x1400c6457		eb68			JMP 0x1400c64c1		
  0x1400c6459		31c0			XORL AX, AX		
				end := min((workerID+1)*chunkSize, totalCandidates)
  0x1400c645b		eb17			JMP 0x1400c6474		
  0x1400c645d		31c0			XORL AX, AX		
  0x1400c645f		90			NOPL			
			if len(sim.CandidatesI) > 0 {
  0x1400c6460		eb12			JMP 0x1400c6474		
			return
  0x1400c6462		4881c4d8000000		ADDQ $0xd8, SP		
  0x1400c6469		5d			POPQ BP			
  0x1400c646a		c3			RET			
}
  0x1400c646b		4881c4d8000000		ADDQ $0xd8, SP		
  0x1400c6472		5d			POPQ BP			
  0x1400c6473		c3			RET			
			if localIColl > 0 {
  0x1400c6474		4885c0			TESTQ AX, AX		
  0x1400c6477		7609			JBE 0x1400c6482		
				atomic.AddUint64(&sim.N_i_coll, localIColl)
  0x1400c6479		f0480fc181982dba07	LOCK XADDQ AX, 0x7ba2d98(CX)	
			sim.WorkerDoneChan <- workerID
  0x1400c6482		488b81502eba07		MOVQ 0x7ba2e50(CX), AX		
  0x1400c6489		488d9c24f0000000	LEAQ 0xf0(SP), BX		
  0x1400c6491		e86aa2f4ff		CALL runtime.chansend1(SB)	
  0x1400c6496		e9fefaffff		JMP 0x1400c5f99			
					for i := start; i < end; i++ {
  0x1400c649b		488b9424a0000000	MOVQ 0xa0(SP), DX	
  0x1400c64a3		48ffc2			INCQ DX			
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c64a6		488bb424c0000000	MOVQ 0xc0(SP), SI	
					for i := start; i < end; i++ {
  0x1400c64ae		488bbc24b0000000	MOVQ 0xb0(SP), DI	
  0x1400c64b6		4889c8			MOVQ CX, AX		
						k := sim.CandidatesI[i]
  0x1400c64b9		488b8c24e8000000	MOVQ 0xe8(SP), CX	
					for i := start; i < end; i++ {
  0x1400c64c1		4839fa			CMPQ DX, DI		
  0x1400c64c4		7dae			JGE 0x1400c6474		
						k := sim.CandidatesI[i]
  0x1400c64c6		488b99782eba07		MOVQ 0x7ba2e78(CX), BX	
  0x1400c64cd		4839da			CMPQ DX, BX		
  0x1400c64d0		0f8354020000		JAE 0x1400c672a		
  0x1400c64d6		488b99702eba07		MOVQ 0x7ba2e70(CX), BX	
						vxA := sim.WorkerRMB(workerID)
  0x1400c64dd		4c8b8424f0000000	MOVQ 0xf0(SP), R8	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400c64e5		4c8b89f02dba07		MOVQ 0x7ba2df0(CX), R9	
						k := sim.CandidatesI[i]
  0x1400c64ec		488b1cd3		MOVQ 0(BX)(DX*8), BX	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400c64f0		4d39c1			CMPQ R9, R8		
  0x1400c64f3		0f862c020000		JBE 0x1400c6725		
						k := sim.CandidatesI[i]
  0x1400c64f9		48899c2490000000	MOVQ BX, 0x90(SP)	
					for i := start; i < end; i++ {
  0x1400c6501		4889842480000000	MOVQ AX, 0x80(SP)	
  0x1400c6509		48899424a0000000	MOVQ DX, 0xa0(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400c6511		488b89e82dba07		MOVQ 0x7ba2de8(CX), CX			
  0x1400c6518		4a8b04c1		MOVQ 0(CX)(R8*8), AX			
  0x1400c651c		0f1f4000		NOPL 0(AX)				
  0x1400c6520		e81b69ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x1400c6525		f20f590543b91500	MULSD gopic.RMB_sigma(SB), X0		
						vxA := sim.WorkerRMB(workerID)
  0x1400c652d		f20f11442468		MOVSD_XMM X0, 0x68(SP)	
						vyA := sim.WorkerRMB(workerID)
  0x1400c6533		488b8c24f0000000	MOVQ 0xf0(SP), CX	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400c653b		488b9424e8000000	MOVQ 0xe8(SP), DX			
  0x1400c6543		488b9af02dba07		MOVQ 0x7ba2df0(DX), BX			
  0x1400c654a		4839cb			CMPQ BX, CX				
  0x1400c654d		0f86cb010000		JBE 0x1400c671e				
  0x1400c6553		488b92e82dba07		MOVQ 0x7ba2de8(DX), DX			
  0x1400c655a		488b04ca		MOVQ 0(DX)(CX*8), AX			
  0x1400c655e		6690			NOPW					
  0x1400c6560		e8db68ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x1400c6565		f20f590503b91500	MULSD gopic.RMB_sigma(SB), X0		
						vyA := sim.WorkerRMB(workerID)
  0x1400c656d		f20f11442460		MOVSD_XMM X0, 0x60(SP)	
						vzA := sim.WorkerRMB(workerID)
  0x1400c6573		488b8c24f0000000	MOVQ 0xf0(SP), CX	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400c657b		488b9424e8000000	MOVQ 0xe8(SP), DX			
  0x1400c6583		488b9af02dba07		MOVQ 0x7ba2df0(DX), BX			
  0x1400c658a		4839cb			CMPQ BX, CX				
  0x1400c658d		0f8686010000		JBE 0x1400c6719				
  0x1400c6593		488b92e82dba07		MOVQ 0x7ba2de8(DX), DX			
  0x1400c659a		488b04ca		MOVQ 0(DX)(CX*8), AX			
  0x1400c659e		6690			NOPW					
  0x1400c65a0		e89b68ffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x1400c65a5		f20f5905c3b81500	MULSD gopic.RMB_sigma(SB), X0		
						vzA := sim.WorkerRMB(workerID)
  0x1400c65ad		f20f11442458		MOVSD_XMM X0, 0x58(SP)	
						gx := sim.Vx_i[k] - vxA
  0x1400c65b3		488b8c2490000000	MOVQ 0x90(SP), CX			
  0x1400c65bb		0f1f440000		NOPL 0(AX)(AX*1)			
  0x1400c65c0		4881f940420f00		CMPQ CX, $0xf4240			
  0x1400c65c7		0f8342010000		JAE 0x1400c670f				
  0x1400c65cd		488b8424e8000000	MOVQ 0xe8(SP), AX			
  0x1400c65d5		f20f108cc8d0d8b805	MOVSD_XMM 0x5b8d8d0(AX)(CX*8), X1	
  0x1400c65de		f20f5c4c2468		SUBSD 0x68(SP), X1			
						gy := sim.Vy_i[k] - vyA
  0x1400c65e4		f20f1094c8d0ea3206	MOVSD_XMM 0x632ead0(AX)(CX*8), X2	
  0x1400c65ed		f20f5c542460		SUBSD 0x60(SP), X2			
						gz := sim.Vz_i[k] - vzA
  0x1400c65f3		f20f109cc8d0fcac06	MOVSD_XMM 0x6acfcd0(AX)(CX*8), X3	
  0x1400c65fc		f20f5cd8		SUBSD X0, X3				
						gSqr := gx*gx + gy*gy + gz*gz
  0x1400c6600		f20f59d2		MULSD X2, X2		
  0x1400c6604		c4e2f1b9d1		VFMADD231SD X1, X1, X2	
  0x1400c6609		c4e2e1b9d3		VFMADD231SD X3, X3, X2	
						eIdx := minInt(int(gSqr*FACTOR_ENERGY_I+0.5), CS_RANGES-1)
  0x1400c660e		f20f100532fc0000	MOVSD_XMM $f64.3fe0000000000000(SB), X0	
  0x1400c6616		f20f100dc2fb0000	MOVSD_XMM $f64.3f1b224d182a4f02(SB), X1	
  0x1400c661e		c4e2f1b9c2		VFMADD231SD X2, X1, X0			
  0x1400c6623		f2480f2cd0		CVTTSD2SIQ X0, DX			
						g := math.Sqrt(gSqr)
  0x1400c6628		90			NOPL			
	if a < b {
  0x1400c6629		4881fa3f420f00		CMPQ DX, $0xf423f	
  0x1400c6630		7c0e			JL 0x1400c6640		
  0x1400c6632		ba3f420f00		MOVL $0xf423f, DX	
  0x1400c6637		660f1f840000000000	NOPW 0(AX)(AX*1)	
						realNu := sim.SigmaTotI[eIdx] * g
  0x1400c6640		4881fa40420f00		CMPQ DX, $0xf4240	
  0x1400c6647		0f83b8000000		JAE 0x1400c6705		
						eIdx := minInt(int(gSqr*FACTOR_ENERGY_I+0.5), CS_RANGES-1)
  0x1400c664d		4889542448		MOVQ DX, 0x48(SP)	
						if sim.WorkerR01(workerID)*sim.NuStarI < realNu {
  0x1400c6652		488b9c24f0000000	MOVQ 0xf0(SP), BX	
	return sqrt(x)
  0x1400c665a		f20f51c2		SQRTSD X2, X0		
						realNu := sim.SigmaTotI[eIdx] * g
  0x1400c665e		f20f5984d0c06cdc02	MULSD 0x2dc6cc0(AX)(DX*8), X0	
  0x1400c6667		f20f11442470		MOVSD_XMM X0, 0x70(SP)		
						if sim.WorkerR01(workerID)*sim.NuStarI < realNu {
  0x1400c666d		e82ef8ffff		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400c6672		488b8424e8000000	MOVQ 0xe8(SP), AX				
  0x1400c667a		f20f5980202eba07	MULSD 0x7ba2e20(AX), X0				
  0x1400c6682		f20f104c2470		MOVSD_XMM 0x70(SP), X1				
  0x1400c6688		660f2ec8		UCOMISD X0, X1					
  0x1400c668c		770d			JA 0x1400c669b					
							sim.CollisionIon(&sim.Vx_i[k], &sim.Vy_i[k], &sim.Vz_i[k], &vxA, &vyA, &vzA, eIdx, workerID)
  0x1400c668e		488b8c2480000000	MOVQ 0x80(SP), CX	
						if sim.WorkerR01(workerID)*sim.NuStarI < realNu {
  0x1400c6696		e900feffff		JMP 0x1400c649b		
							sim.CollisionIon(&sim.Vx_i[k], &sim.Vy_i[k], &sim.Vz_i[k], &vxA, &vyA, &vzA, eIdx, workerID)
  0x1400c669b		4c8b9c24f0000000	MOVQ 0xf0(SP), R11				
  0x1400c66a3		488b942490000000	MOVQ 0x90(SP), DX				
  0x1400c66ab		488d1cd0		LEAQ 0(AX)(DX*8), BX				
  0x1400c66af		488d9bd0d8b805		LEAQ 0x5b8d8d0(BX), BX				
  0x1400c66b6		488d0cd0		LEAQ 0(AX)(DX*8), CX				
  0x1400c66ba		488d89d0ea3206		LEAQ 0x632ead0(CX), CX				
  0x1400c66c1		488d3cd0		LEAQ 0(AX)(DX*8), DI				
  0x1400c66c5		488dbfd0fcac06		LEAQ 0x6acfcd0(DI), DI				
  0x1400c66cc		488d742468		LEAQ 0x68(SP), SI				
  0x1400c66d1		4c8d442460		LEAQ 0x60(SP), R8				
  0x1400c66d6		4c8d4c2458		LEAQ 0x58(SP), R9				
  0x1400c66db		4c8b542448		MOVQ 0x48(SP), R10				
  0x1400c66e0		e8fb7effff		CALL gopic.(*SimulationState).CollisionIon(SB)	
							localIColl++
  0x1400c66e5		488b842480000000	MOVQ 0x80(SP), AX	
  0x1400c66ed		48ffc0			INCQ AX			
							sim.CollisionIon(&sim.Vx_i[k], &sim.Vy_i[k], &sim.Vz_i[k], &vxA, &vyA, &vzA, eIdx, workerID)
  0x1400c66f0		4889c1			MOVQ AX, CX		
						k := sim.CandidatesI[i]
  0x1400c66f3		488b8424e8000000	MOVQ 0xe8(SP), AX	
  0x1400c66fb		0f1f440000		NOPL 0(AX)(AX*1)	
							localIColl++
  0x1400c6700		e996fdffff		JMP 0x1400c649b		
						realNu := sim.SigmaTotI[eIdx] * g
  0x1400c6705		b840420f00		MOVL $0xf4240, AX		
  0x1400c670a		e8717dfbff		CALL runtime.panicBounds(SB)	
						gx := sim.Vx_i[k] - vxA
  0x1400c670f		b840420f00		MOVL $0xf4240, AX		
  0x1400c6714		e8677dfbff		CALL runtime.panicBounds(SB)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400c6719		e8627dfbff		CALL runtime.panicBounds(SB)	
  0x1400c671e		6690			NOPW				
  0x1400c6720		e85b7dfbff		CALL runtime.panicBounds(SB)	
  0x1400c6725		e8567dfbff		CALL runtime.panicBounds(SB)	
						k := sim.CandidatesI[i]
  0x1400c672a		e8517dfbff		CALL runtime.panicBounds(SB)	
			sim.WorkerNewIons[workerID] = sim.WorkerNewIons[workerID][:0]
  0x1400c672f		e84c7dfbff		CALL runtime.panicBounds(SB)	
			if localEColl > 0 {
  0x1400c6734		4885c0			TESTQ AX, AX		
  0x1400c6737		7609			JBE 0x1400c6742		
				atomic.AddUint64(&sim.N_e_coll, localEColl)
  0x1400c6739		f0480fc181902dba07	LOCK XADDQ AX, 0x7ba2d90(CX)	
			sim.WorkerDoneChan <- workerID
  0x1400c6742		488b81502eba07		MOVQ 0x7ba2e50(CX), AX		
  0x1400c6749		488d9c24f0000000	LEAQ 0xf0(SP), BX		
  0x1400c6751		e8aa9ff4ff		CALL runtime.chansend1(SB)	
  0x1400c6756		e93ef8ffff		JMP 0x1400c5f99			
					for i := start; i < end; i++ {
  0x1400c675b		488b9424a8000000	MOVQ 0xa8(SP), DX	
  0x1400c6763		48ffc2			INCQ DX			
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c6766		488bb424c0000000	MOVQ 0xc0(SP), SI	
					for i := start; i < end; i++ {
  0x1400c676e		488bbc24b8000000	MOVQ 0xb8(SP), DI	
  0x1400c6776		4889c8			MOVQ CX, AX		
						k := sim.CandidatesE[i]
  0x1400c6779		488b8c24e8000000	MOVQ 0xe8(SP), CX	
					for i := start; i < end; i++ {
  0x1400c6781		4839fa			CMPQ DX, DI		
  0x1400c6784		7dae			JGE 0x1400c6734		
						k := sim.CandidatesE[i]
  0x1400c6786		4c8b81602eba07		MOVQ 0x7ba2e60(CX), R8	
  0x1400c678d		4c39c2			CMPQ DX, R8		
  0x1400c6790		0f8359010000		JAE 0x1400c68ef		
  0x1400c6796		4c8b81582eba07		MOVQ 0x7ba2e58(CX), R8	
  0x1400c679d		4d8b04d0		MOVQ 0(R8)(DX*8), R8	
						vSqr := sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
  0x1400c67a1		4981f840420f00		CMPQ R8, $0xf4240			
  0x1400c67a8		0f8337010000		JAE 0x1400c68e5				
  0x1400c67ae		f2420f1084c1d090d003	MOVSD_XMM 0x3d090d0(CX)(R8*8), X0	
  0x1400c67b8		f20f59c0		MULSD X0, X0				
  0x1400c67bc		f2420f108cc1d0a24a04	MOVSD_XMM 0x44aa2d0(CX)(R8*8), X1	
  0x1400c67c6		c4e2f1b9c1		VFMADD231SD X1, X1, X0			
  0x1400c67cb		f2420f108cc1d0b4c404	MOVSD_XMM 0x4c4b4d0(CX)(R8*8), X1	
  0x1400c67d5		c4e2f1b9c1		VFMADD231SD X1, X1, X0			
						eIdx := minInt(int(vSqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
  0x1400c67da		f20f100d66fa0000	MOVSD_XMM $f64.3fe0000000000000(SB), X1	
  0x1400c67e2		f20f1015c6f90000	MOVSD_XMM $f64.3e286b6a97118d9b(SB), X2	
  0x1400c67ea		c4e2f9b9ca		VFMADD231SD X2, X0, X1			
  0x1400c67ef		f24c0f2cc9		CVTTSD2SIQ X1, R9			
						velocity := math.Sqrt(vSqr)
  0x1400c67f4		90			NOPL			
	if a < b {
  0x1400c67f5		4981f93f420f00		CMPQ R9, $0xf423f	
  0x1400c67fc		7c06			JL 0x1400c6804		
  0x1400c67fe		41b93f420f00		MOVL $0xf423f, R9	
						realNu := sim.SigmaTotE[eIdx] * velocity
  0x1400c6804		4981f940420f00		CMPQ R9, $0xf4240	
  0x1400c680b		0f83c9000000		JAE 0x1400c68da		
						k := sim.CandidatesE[i]
  0x1400c6811		4c89842498000000	MOVQ R8, 0x98(SP)	
					for i := start; i < end; i++ {
  0x1400c6819		4889842488000000	MOVQ AX, 0x88(SP)	
  0x1400c6821		48899424a8000000	MOVQ DX, 0xa8(SP)	
						eIdx := minInt(int(vSqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
  0x1400c6829		4c894c2450		MOVQ R9, 0x50(SP)	
						if sim.WorkerR01(workerID)*sim.NuStarE < realNu {
  0x1400c682e		488b9c24f0000000	MOVQ 0xf0(SP), BX	
	return sqrt(x)
  0x1400c6836		f20f51c0		SQRTSD X0, X0		
						realNu := sim.SigmaTotE[eIdx] * velocity
  0x1400c683a		f2420f5984c9c05a6202	MULSD 0x2625ac0(CX)(R9*8), X0	
  0x1400c6844		f20f11442478		MOVSD_XMM X0, 0x78(SP)		
						if sim.WorkerR01(workerID)*sim.NuStarE < realNu {
  0x1400c684a		4889c8			MOVQ CX, AX					
  0x1400c684d		e84ef6ffff		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400c6852		488b8424e8000000	MOVQ 0xe8(SP), AX				
  0x1400c685a		f20f5980102eba07	MULSD 0x7ba2e10(AX), X0				
  0x1400c6862		f20f104c2478		MOVSD_XMM 0x78(SP), X1				
  0x1400c6868		660f2ec8		UCOMISD X0, X1					
  0x1400c686c		770d			JA 0x1400c687b					
							sim.CollisionElectron(sim.X_e[k], &sim.Vx_e[k], &sim.Vy_e[k], &sim.Vz_e[k], eIdx, workerID)
  0x1400c686e		488b8c2488000000	MOVQ 0x88(SP), CX	
						if sim.WorkerR01(workerID)*sim.NuStarE < realNu {
  0x1400c6876		e9e0feffff		JMP 0x1400c675b		
							sim.CollisionElectron(sim.X_e[k], &sim.Vx_e[k], &sim.Vy_e[k], &sim.Vz_e[k], eIdx, workerID)
  0x1400c687b		4c8b8424f0000000	MOVQ 0xf0(SP), R8					
  0x1400c6883		488b942498000000	MOVQ 0x98(SP), DX					
  0x1400c688b		f20f1084d0d07e5603	MOVSD_XMM 0x3567ed0(AX)(DX*8), X0			
  0x1400c6894		488d1cd0		LEAQ 0(AX)(DX*8), BX					
  0x1400c6898		488d9bd090d003		LEAQ 0x3d090d0(BX), BX					
  0x1400c689f		488d0cd0		LEAQ 0(AX)(DX*8), CX					
  0x1400c68a3		488d89d0a24a04		LEAQ 0x44aa2d0(CX), CX					
  0x1400c68aa		488d3cd0		LEAQ 0(AX)(DX*8), DI					
  0x1400c68ae		488dbfd0b4c404		LEAQ 0x4c4b4d0(DI), DI					
  0x1400c68b5		488b742450		MOVQ 0x50(SP), SI					
  0x1400c68ba		e80172ffff		CALL gopic.(*SimulationState).CollisionElectron(SB)	
							localEColl++
  0x1400c68bf		488b842488000000	MOVQ 0x88(SP), AX	
  0x1400c68c7		48ffc0			INCQ AX			
							sim.CollisionElectron(sim.X_e[k], &sim.Vx_e[k], &sim.Vy_e[k], &sim.Vz_e[k], eIdx, workerID)
  0x1400c68ca		4889c1			MOVQ AX, CX		
						k := sim.CandidatesE[i]
  0x1400c68cd		488b8424e8000000	MOVQ 0xe8(SP), AX	
							localEColl++
  0x1400c68d5		e981feffff		JMP 0x1400c675b		
						realNu := sim.SigmaTotE[eIdx] * velocity
  0x1400c68da		b840420f00		MOVL $0xf4240, AX		
  0x1400c68df		90			NOPL				
  0x1400c68e0		e89b7bfbff		CALL runtime.panicBounds(SB)	
						vSqr := sim.Vx_e[k]*sim.Vx_e[k] + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
  0x1400c68e5		b840420f00		MOVL $0xf4240, AX		
  0x1400c68ea		e8917bfbff		CALL runtime.panicBounds(SB)	
						k := sim.CandidatesE[i]
  0x1400c68ef		e88c7bfbff		CALL runtime.panicBounds(SB)	
			sim.WorkerNewIons[workerID] = sim.WorkerNewIons[workerID][:0]
  0x1400c68f4		e8877bfbff		CALL runtime.panicBounds(SB)	
			sim.WorkerNewElectrons[workerID] = sim.WorkerNewElectrons[workerID][:0]
  0x1400c68f9		e8827bfbff		CALL runtime.panicBounds(SB)	
				diag.ifed_pow[idx] = 0
  0x1400c68fe		4e8d1402		LEAQ 0(DX)(R8*1), R10	
  0x1400c6902		4d8d9290250000		LEAQ 0x2590(R10), R10	
  0x1400c6909		4bc704ca00000000	MOVQ $0x0, 0(R10)(R9*8)	
				diag.ifed_gnd[idx] = 0
  0x1400c6911		4e8d1402		LEAQ 0(DX)(R8*1), R10	
  0x1400c6915		4d8d92d02b0000		LEAQ 0x2bd0(R10), R10	
  0x1400c691c		4bc704ca00000000	MOVQ $0x0, 0(R10)(R9*8)	
			for idx := range N_IFED {
  0x1400c6924		49ffc1			INCQ R9			
  0x1400c6927		4981f9c8000000		CMPQ R9, $0xc8		
  0x1400c692e		7cce			JL 0x1400c68fe		
			if start < end {
  0x1400c6930		4839c7			CMPQ DI, AX		
  0x1400c6933		7f1c			JG 0x1400c6951		
			sim.WorkerDoneChan <- workerID
  0x1400c6935		488b81502eba07		MOVQ 0x7ba2e50(CX), AX		
  0x1400c693c		488d9c24f0000000	LEAQ 0xf0(SP), BX		
  0x1400c6944		e8b79df4ff		CALL runtime.chansend1(SB)	
  0x1400c6949		e94bf6ffff		JMP 0x1400c5f99			
				for k := start; k < end; k++ {
  0x1400c694e		48ffc0			INCQ AX			
  0x1400c6951		4839f8			CMPQ AX, DI		
  0x1400c6954		7ddf			JGE 0x1400c6935		
  0x1400c6956		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x1400c695f		90			NOPL			
					if sim.X_i[k] < 0 {
  0x1400c6960		483d40420f00		CMPQ AX, $0xf4240			
  0x1400c6966		0f8371010000		JAE 0x1400c6add				
  0x1400c696c		f20f1084c1d0c63e05	MOVSD_XMM 0x53ec6d0(CX)(AX*8), X0	
  0x1400c6975		0f57c9			XORPS X1, X1				
  0x1400c6978		660f2ec8		UCOMISD X0, X1				
  0x1400c697c		0f1f4000		NOPL 0(AX)				
  0x1400c6980		0f8682000000		JBE 0x1400c6a08				
						sim.AbsorbedI[k] = 1
  0x1400c6986		4c8b8980000000		MOVQ 0x80(CX), R9	
  0x1400c698d		4c39c8			CMPQ AX, R9		
  0x1400c6990		0f8342010000		JAE 0x1400c6ad8		
  0x1400c6996		4c8b4978		MOVQ 0x78(CX), R9	
  0x1400c699a		41c6040101		MOVB $0x1, 0(R9)(AX*1)	
						diag.abs_pow++
  0x1400c699f		49ff841080250000	INCQ 0x2580(R8)(DX*1)	
						v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c69a7		f20f1084c1d0d8b805	MOVSD_XMM 0x5b8d8d0(CX)(AX*8), X0	
  0x1400c69b0		f20f59c0		MULSD X0, X0				
  0x1400c69b4		f20f1094c1d0ea3206	MOVSD_XMM 0x632ead0(CX)(AX*8), X2	
  0x1400c69bd		c4e2e9b9c2		VFMADD231SD X2, X2, X0			
  0x1400c69c2		f20f1094c1d0fcac06	MOVSD_XMM 0x6acfcd0(CX)(AX*8), X2	
  0x1400c69cb		c4e2e9b9c2		VFMADD231SD X2, X2, X0			
						energy_index = int(v_sqr * FACTOR_ENERGY_IFED)
  0x1400c69d0		f20f1015e8f70000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X2	
  0x1400c69d8		f20f59c2		MULSD X2, X0				
  0x1400c69dc		f24c0f2cc8		CVTTSD2SIQ X0, R9			
						if energy_index < N_IFED {
  0x1400c69e1		4981f9c8000000		CMPQ R9, $0xc8		
  0x1400c69e8		0f8d60ffffff		JGE 0x1400c694e		
							diag.ifed_pow[energy_index]++
  0x1400c69ee		4e8d1402		LEAQ 0(DX)(R8*1), R10	
  0x1400c69f2		4d8d9290250000		LEAQ 0x2590(R10), R10	
  0x1400c69f9		0f83cf000000		JAE 0x1400c6ace		
  0x1400c69ff		4bff04ca		INCQ 0(R10)(R9*8)	
  0x1400c6a03		e946ffffff		JMP 0x1400c694e		
					} else if sim.X_i[k] > L {
  0x1400c6a08		f20f1015d8f60000	MOVSD_XMM runtime.egcbss+10(SB), X2	
  0x1400c6a10		660f2ec2		UCOMISD X2, X0				
  0x1400c6a14		767a			JBE 0x1400c6a90				
						sim.AbsorbedI[k] = 2
  0x1400c6a16		4c8b8980000000		MOVQ 0x80(CX), R9	
  0x1400c6a1d		0f1f00			NOPL 0(AX)		
  0x1400c6a20		4c39c8			CMPQ AX, R9		
  0x1400c6a23		0f83a0000000		JAE 0x1400c6ac9		
  0x1400c6a29		4c8b4978		MOVQ 0x78(CX), R9	
  0x1400c6a2d		41c6040102		MOVB $0x2, 0(R9)(AX*1)	
						diag.abs_gnd++
  0x1400c6a32		49ff841088250000	INCQ 0x2588(R8)(DX*1)	
						v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c6a3a		f20f1084c1d0d8b805	MOVSD_XMM 0x5b8d8d0(CX)(AX*8), X0	
  0x1400c6a43		f20f59c0		MULSD X0, X0				
  0x1400c6a47		f20f109cc1d0ea3206	MOVSD_XMM 0x632ead0(CX)(AX*8), X3	
  0x1400c6a50		c4e2e1b9c3		VFMADD231SD X3, X3, X0			
  0x1400c6a55		f20f109cc1d0fcac06	MOVSD_XMM 0x6acfcd0(CX)(AX*8), X3	
  0x1400c6a5e		c4e2e1b9c3		VFMADD231SD X3, X3, X0			
						energy_index = int(v_sqr * FACTOR_ENERGY_IFED)
  0x1400c6a63		f20f101d55f70000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X3	
  0x1400c6a6b		f20f59c3		MULSD X3, X0				
  0x1400c6a6f		f24c0f2cc8		CVTTSD2SIQ X0, R9			
						if energy_index < N_IFED {
  0x1400c6a74		4981f9c8000000		CMPQ R9, $0xc8		
  0x1400c6a7b		7d30			JGE 0x1400c6aad		
							diag.ifed_gnd[energy_index]++
  0x1400c6a7d		4e8d1402		LEAQ 0(DX)(R8*1), R10	
  0x1400c6a81		4d8d92d02b0000		LEAQ 0x2bd0(R10), R10	
  0x1400c6a88		7335			JAE 0x1400c6abf		
  0x1400c6a8a		4bff04ca		INCQ 0(R10)(R9*8)	
  0x1400c6a8e		eb1d			JMP 0x1400c6aad		
						sim.AbsorbedI[k] = 0
  0x1400c6a90		4c8b8980000000		MOVQ 0x80(CX), R9			
  0x1400c6a97		4c39c8			CMPQ AX, R9				
  0x1400c6a9a		731e			JAE 0x1400c6aba				
  0x1400c6a9c		4c8b4978		MOVQ 0x78(CX), R9			
  0x1400c6aa0		41c6040100		MOVB $0x0, 0(R9)(AX*1)			
  0x1400c6aa5		f20f101d13f70000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X3	
  0x1400c6aad		f20f10150bf70000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X2	
  0x1400c6ab5		e994feffff		JMP 0x1400c694e				
  0x1400c6aba		e8c179fbff		CALL runtime.panicBounds(SB)		
							diag.ifed_gnd[energy_index]++
  0x1400c6abf		b8c8000000		MOVL $0xc8, AX			
  0x1400c6ac4		e8b779fbff		CALL runtime.panicBounds(SB)	
						sim.AbsorbedI[k] = 2
  0x1400c6ac9		e8b279fbff		CALL runtime.panicBounds(SB)	
							diag.ifed_pow[energy_index]++
  0x1400c6ace		b8c8000000		MOVL $0xc8, AX			
  0x1400c6ad3		e8a879fbff		CALL runtime.panicBounds(SB)	
						sim.AbsorbedI[k] = 1
  0x1400c6ad8		e8a379fbff		CALL runtime.panicBounds(SB)	
					if sim.X_i[k] < 0 {
  0x1400c6add		b940420f00		MOVL $0xf4240, CX		
  0x1400c6ae2		e89979fbff		CALL runtime.panicBounds(SB)	
			diag := &sim.WorkerIDiag[workerID]
  0x1400c6ae7		e89479fbff		CALL runtime.panicBounds(SB)	
			sim.WorkerDoneChan <- workerID
  0x1400c6aec		488b81502eba07		MOVQ 0x7ba2e50(CX), AX		
  0x1400c6af3		488d9c24f0000000	LEAQ 0xf0(SP), BX		
  0x1400c6afb		0f1f440000		NOPL 0(AX)(AX*1)		
  0x1400c6b00		e8fb9bf4ff		CALL runtime.chansend1(SB)	
  0x1400c6b05		e98ff4ffff		JMP 0x1400c5f99			
				for k := start; k < end; k++ {
  0x1400c6b0a		48ffc0			INCQ AX			
  0x1400c6b0d		4839f8			CMPQ AX, DI		
  0x1400c6b10		7dda			JGE 0x1400c6aec		
					if sim.X_e[k] < 0 {
  0x1400c6b12		483d40420f00		CMPQ AX, $0xf4240			
  0x1400c6b18		737b			JAE 0x1400c6b95				
  0x1400c6b1a		f20f1084c1d07e5603	MOVSD_XMM 0x3567ed0(CX)(AX*8), X0	
  0x1400c6b23		0f57c9			XORPS X1, X1				
  0x1400c6b26		660f2ec8		UCOMISD X0, X1				
  0x1400c6b2a		761c			JBE 0x1400c6b48				
						sim.AbsorbedE[k] = 1
  0x1400c6b2c		4c8b4968		MOVQ 0x68(CX), R9	
  0x1400c6b30		4c39c8			CMPQ AX, R9		
  0x1400c6b33		735b			JAE 0x1400c6b90		
  0x1400c6b35		4c8b4960		MOVQ 0x60(CX), R9	
  0x1400c6b39		41c6040101		MOVB $0x1, 0(R9)(AX*1)	
						diag.abs_pow++
  0x1400c6b3e		49ff841090700000	INCQ 0x7090(R8)(DX*1)	
  0x1400c6b46		ebc2			JMP 0x1400c6b0a		
					} else if sim.X_e[k] > L {
  0x1400c6b48		f20f101598f50000	MOVSD_XMM runtime.egcbss+10(SB), X2	
  0x1400c6b50		660f2ec2		UCOMISD X2, X0				
  0x1400c6b54		761c			JBE 0x1400c6b72				
						sim.AbsorbedE[k] = 2
  0x1400c6b56		4c8b4968		MOVQ 0x68(CX), R9	
  0x1400c6b5a		4c39c8			CMPQ AX, R9		
  0x1400c6b5d		732c			JAE 0x1400c6b8b		
  0x1400c6b5f		4c8b4960		MOVQ 0x60(CX), R9	
  0x1400c6b63		41c6040102		MOVB $0x2, 0(R9)(AX*1)	
						diag.abs_gnd++
  0x1400c6b68		49ff841098700000	INCQ 0x7098(R8)(DX*1)	
  0x1400c6b70		eb98			JMP 0x1400c6b0a		
						sim.AbsorbedE[k] = 0
  0x1400c6b72		4c8b4968		MOVQ 0x68(CX), R9		
  0x1400c6b76		4c39c8			CMPQ AX, R9			
  0x1400c6b79		730b			JAE 0x1400c6b86			
  0x1400c6b7b		4c8b4960		MOVQ 0x60(CX), R9		
  0x1400c6b7f		41c6040100		MOVB $0x0, 0(R9)(AX*1)		
  0x1400c6b84		eb84			JMP 0x1400c6b0a			
  0x1400c6b86		e8f578fbff		CALL runtime.panicBounds(SB)	
						sim.AbsorbedE[k] = 2
  0x1400c6b8b		e8f078fbff		CALL runtime.panicBounds(SB)	
						sim.AbsorbedE[k] = 1
  0x1400c6b90		e8eb78fbff		CALL runtime.panicBounds(SB)	
					if sim.X_e[k] < 0 {
  0x1400c6b95		b940420f00		MOVL $0xf4240, CX		
  0x1400c6b9a		e8e178fbff		CALL runtime.panicBounds(SB)	
			diag := &sim.WorkerEDiag[workerID]
  0x1400c6b9f		90			NOPL				
  0x1400c6ba0		e8db78fbff		CALL runtime.panicBounds(SB)	
					d3 := c0_3 - float64(p3)
  0x1400c6ba5		0f57ed			XORPS X5, X5		
  0x1400c6ba8		f2480f2aee		CVTSI2SDQ SI, X5	
  0x1400c6bad		f20f5cc5		SUBSD X5, X0		
					ex3 := sim.Efield[p3] + d3*(sim.Efield[p3+1]-sim.Efield[p3])
  0x1400c6bb1		f20f10acf1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X5	
  0x1400c6bba		f20f10b4f1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X6	
  0x1400c6bc3		f20f5cf5		SUBSD X5, X6				
  0x1400c6bc7		c4e2f9b9ee		VFMADD231SD X6, X0, X5			
					vx0 := sim.Vx_i[k] + ex0*FACTOR_I
  0x1400c6bcc		f20f100514f60000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x1400c6bd4		f20f59d0		MULSD X0, X2				
  0x1400c6bd8		f20f5894c1d0d8b805	ADDSD 0x5b8d8d0(CX)(AX*8), X2		
					vx1 := sim.Vx_i[k+1] + ex1*FACTOR_I
  0x1400c6be1		f20f59d8		MULSD X0, X3			
  0x1400c6be5		f20f589cc1d8d8b805	ADDSD 0x5b8d8d8(CX)(AX*8), X3	
					vx2 := sim.Vx_i[k+2] + ex2*FACTOR_I
  0x1400c6bee		f20f59e0		MULSD X0, X4			
  0x1400c6bf2		f20f58a4c1e0d8b805	ADDSD 0x5b8d8e0(CX)(AX*8), X4	
					vx3 := sim.Vx_i[k+3] + ex3*FACTOR_I
  0x1400c6bfb		f20f59e8		MULSD X0, X5			
  0x1400c6bff		f20f58acc1e8d8b805	ADDSD 0x5b8d8e8(CX)(AX*8), X5	
					sim.Vx_i[k] = vx0
  0x1400c6c08		f20f1194c1d0d8b805	MOVSD_XMM X2, 0x5b8d8d0(CX)(AX*8)	
					sim.Vx_i[k+1] = vx1
  0x1400c6c11		f20f119cc1d8d8b805	MOVSD_XMM X3, 0x5b8d8d8(CX)(AX*8)	
					sim.Vx_i[k+2] = vx2
  0x1400c6c1a		f20f11a4c1e0d8b805	MOVSD_XMM X4, 0x5b8d8e0(CX)(AX*8)	
					sim.Vx_i[k+3] = vx3
  0x1400c6c23		f20f11acc1e8d8b805	MOVSD_XMM X5, 0x5b8d8e8(CX)(AX*8)	
					sim.X_i[k] += vx0 * DT_I
  0x1400c6c2c		f20f10b4c1d0c63e05	MOVSD_XMM 0x53ec6d0(CX)(AX*8), X6	
  0x1400c6c35		f20f103d63f50000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X7	
  0x1400c6c3d		c4e2e9b9f7		VFMADD231SD X7, X2, X6			
  0x1400c6c42		f20f11b4c1d0c63e05	MOVSD_XMM X6, 0x53ec6d0(CX)(AX*8)	
					sim.X_i[k+1] += vx1 * DT_I
  0x1400c6c4b		f20f1094c1d8c63e05	MOVSD_XMM 0x53ec6d8(CX)(AX*8), X2	
  0x1400c6c54		c4e2e1b9d7		VFMADD231SD X7, X3, X2			
  0x1400c6c59		f20f1194c1d8c63e05	MOVSD_XMM X2, 0x53ec6d8(CX)(AX*8)	
					sim.X_i[k+2] += vx2 * DT_I
  0x1400c6c62		f20f1094c1e0c63e05	MOVSD_XMM 0x53ec6e0(CX)(AX*8), X2	
  0x1400c6c6b		c4e2d9b9d7		VFMADD231SD X7, X4, X2			
  0x1400c6c70		f20f1194c1e0c63e05	MOVSD_XMM X2, 0x53ec6e0(CX)(AX*8)	
					sim.X_i[k+3] += vx3 * DT_I
  0x1400c6c79		f20f1094c1e8c63e05	MOVSD_XMM 0x53ec6e8(CX)(AX*8), X2	
  0x1400c6c82		c4e2d1b9d7		VFMADD231SD X7, X5, X2			
  0x1400c6c87		f20f1194c1e8c63e05	MOVSD_XMM X2, 0x53ec6e8(CX)(AX*8)	
				for ; k <= end-4; k += 4 {
  0x1400c6c90		4883c004		ADDQ $0x4, AX		
  0x1400c6c94		4839d0			CMPQ AX, DX		
  0x1400c6c97		0f8fcf010000		JG 0x1400c6e6c		
  0x1400c6c9d		0f1f00			NOPL 0(AX)		
					c0_0 := sim.X_i[k] * INV_DX
  0x1400c6ca0		483d40420f00		CMPQ AX, $0xf4240			
  0x1400c6ca6		0f8359020000		JAE 0x1400c6f05				
  0x1400c6cac		f20f1084c1d0c63e05	MOVSD_XMM 0x53ec6d0(CX)(AX*8), X0	
  0x1400c6cb5		f20f100d93f60000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c6cbd		f20f59c1		MULSD X1, X0				
					p0 := min(max(int(c0_0), 0), N_G-2)
  0x1400c6cc1		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c6cc6		4885f6			TESTQ SI, SI		
  0x1400c6cc9		7d02			JGE 0x1400c6ccd		
  0x1400c6ccb		31f6			XORL SI, SI		
  0x1400c6ccd		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c6cd4		7e05			JLE 0x1400c6cdb		
  0x1400c6cd6		be8e010000		MOVL $0x18e, SI		
					d0 := c0_0 - float64(p0)
  0x1400c6cdb		0f57d2			XORPS X2, X2		
  0x1400c6cde		f2480f2ad6		CVTSI2SDQ SI, X2	
  0x1400c6ce3		f20f5cc2		SUBSD X2, X0		
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x1400c6ce7		f20f1094f1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X2	
  0x1400c6cf0		f20f109cf1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X3	
  0x1400c6cf9		f20f5cda		SUBSD X2, X3				
					c0_1 := sim.X_i[k+1] * INV_DX
  0x1400c6cfd		488d7001		LEAQ 0x1(AX), SI	
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x1400c6d01		c4e2f9b9d3		VFMADD231SD X3, X0, X2	
					c0_1 := sim.X_i[k+1] * INV_DX
  0x1400c6d06		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c6d0d		0f83e1010000		JAE 0x1400c6ef4				
  0x1400c6d13		f20f1084c1d8c63e05	MOVSD_XMM 0x53ec6d8(CX)(AX*8), X0	
  0x1400c6d1c		f20f59c1		MULSD X1, X0				
					p1 := min(max(int(c0_1), 0), N_G-2)
  0x1400c6d20		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c6d25		4885f6			TESTQ SI, SI		
  0x1400c6d28		7d02			JGE 0x1400c6d2c		
  0x1400c6d2a		31f6			XORL SI, SI		
  0x1400c6d2c		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c6d33		7e05			JLE 0x1400c6d3a		
  0x1400c6d35		be8e010000		MOVL $0x18e, SI		
					d1 := c0_1 - float64(p1)
  0x1400c6d3a		0f57db			XORPS X3, X3		
  0x1400c6d3d		f2480f2ade		CVTSI2SDQ SI, X3	
  0x1400c6d42		f20f5cc3		SUBSD X3, X0		
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x1400c6d46		f20f109cf1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X3	
  0x1400c6d4f		f20f10a4f1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X4	
  0x1400c6d58		f20f5ce3		SUBSD X3, X4				
					c0_2 := sim.X_i[k+2] * INV_DX
  0x1400c6d5c		488d7002		LEAQ 0x2(AX), SI	
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x1400c6d60		c4e2f9b9dc		VFMADD231SD X4, X0, X3	
					c0_2 := sim.X_i[k+2] * INV_DX
  0x1400c6d65		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c6d6c		0f8373010000		JAE 0x1400c6ee5				
  0x1400c6d72		f20f1084c1e0c63e05	MOVSD_XMM 0x53ec6e0(CX)(AX*8), X0	
  0x1400c6d7b		f20f59c1		MULSD X1, X0				
					p2 := min(max(int(c0_2), 0), N_G-2)
  0x1400c6d7f		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c6d84		4885f6			TESTQ SI, SI		
  0x1400c6d87		7d02			JGE 0x1400c6d8b		
  0x1400c6d89		31f6			XORL SI, SI		
  0x1400c6d8b		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c6d92		7e05			JLE 0x1400c6d99		
  0x1400c6d94		be8e010000		MOVL $0x18e, SI		
					d2 := c0_2 - float64(p2)
  0x1400c6d99		0f57e4			XORPS X4, X4		
  0x1400c6d9c		f2480f2ae6		CVTSI2SDQ SI, X4	
  0x1400c6da1		f20f5cc4		SUBSD X4, X0		
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x1400c6da5		f20f10a4f1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X4	
  0x1400c6dae		f20f10acf1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X5	
  0x1400c6db7		f20f5cec		SUBSD X4, X5				
					c0_3 := sim.X_i[k+3] * INV_DX
  0x1400c6dbb		488d7003		LEAQ 0x3(AX), SI	
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x1400c6dbf		c4e2f9b9e5		VFMADD231SD X5, X0, X4	
					c0_3 := sim.X_i[k+3] * INV_DX
  0x1400c6dc4		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c6dcb		0f8309010000		JAE 0x1400c6eda				
  0x1400c6dd1		f20f1084c1e8c63e05	MOVSD_XMM 0x53ec6e8(CX)(AX*8), X0	
  0x1400c6dda		f20f59c1		MULSD X1, X0				
					p3 := min(max(int(c0_3), 0), N_G-2)
  0x1400c6dde		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c6de3		4885f6			TESTQ SI, SI		
  0x1400c6de6		7d02			JGE 0x1400c6dea		
  0x1400c6de8		31f6			XORL SI, SI		
  0x1400c6dea		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c6df1		0f8eaefdffff		JLE 0x1400c6ba5		
  0x1400c6df7		be8e010000		MOVL $0x18e, SI		
  0x1400c6dfc		0f1f4000		NOPL 0(AX)		
  0x1400c6e00		e9a0fdffff		JMP 0x1400c6ba5		
					d := c0 - float64(p)
  0x1400c6e05		0f57d2			XORPS X2, X2		
  0x1400c6e08		f2480f2ad2		CVTSI2SDQ DX, X2	
  0x1400c6e0d		f20f5cc2		SUBSD X2, X0		
					ex := sim.Efield[p] + d*(sim.Efield[p+1]-sim.Efield[p])
  0x1400c6e11		f20f1094d1d00e2707	MOVSD_XMM 0x7270ed0(CX)(DX*8), X2	
  0x1400c6e1a		f20f109cd1d80e2707	MOVSD_XMM 0x7270ed8(CX)(DX*8), X3	
  0x1400c6e23		f20f5cda		SUBSD X2, X3				
  0x1400c6e27		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
					sim.Vx_i[k] += ex * FACTOR_I
  0x1400c6e2c		f20f1005b4f30000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x1400c6e34		f20f59d0		MULSD X0, X2				
  0x1400c6e38		f20f5894c1d0d8b805	ADDSD 0x5b8d8d0(CX)(AX*8), X2		
  0x1400c6e41		f20f1194c1d0d8b805	MOVSD_XMM X2, 0x5b8d8d0(CX)(AX*8)	
					sim.X_i[k] += sim.Vx_i[k] * DT_I
  0x1400c6e4a		f20f109cc1d0c63e05	MOVSD_XMM 0x53ec6d0(CX)(AX*8), X3	
  0x1400c6e53		f20f102545f30000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X4	
  0x1400c6e5b		c4e2e9b9dc		VFMADD231SD X4, X2, X3			
  0x1400c6e60		f20f119cc1d0c63e05	MOVSD_XMM X3, 0x53ec6d0(CX)(AX*8)	
				for ; k < end; k++ {
  0x1400c6e69		48ffc0			INCQ AX			
  0x1400c6e6c		4c39c8			CMPQ AX, R9		
  0x1400c6e6f		7d46			JGE 0x1400c6eb7		
					c0 := sim.X_i[k] * INV_DX
  0x1400c6e71		483d40420f00		CMPQ AX, $0xf4240			
  0x1400c6e77		7357			JAE 0x1400c6ed0				
  0x1400c6e79		f20f1084c1d0c63e05	MOVSD_XMM 0x53ec6d0(CX)(AX*8), X0	
  0x1400c6e82		f20f100dc6f40000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c6e8a		f20f59c1		MULSD X1, X0				
					p := min(max(int(c0), 0), N_G-2)
  0x1400c6e8e		f2480f2cd0		CVTTSD2SIQ X0, DX	
  0x1400c6e93		4885d2			TESTQ DX, DX		
  0x1400c6e96		7d08			JGE 0x1400c6ea0		
  0x1400c6e98		31d2			XORL DX, DX		
  0x1400c6e9a		660f1f440000		NOPW 0(AX)(AX*1)	
  0x1400c6ea0		4881fa8e010000		CMPQ DX, $0x18e		
  0x1400c6ea7		0f8e58ffffff		JLE 0x1400c6e05		
  0x1400c6ead		ba8e010000		MOVL $0x18e, DX		
  0x1400c6eb2		e94effffff		JMP 0x1400c6e05		
			sim.WorkerDoneChan <- workerID
  0x1400c6eb7		488b81502eba07		MOVQ 0x7ba2e50(CX), AX		
  0x1400c6ebe		488d9c24f0000000	LEAQ 0xf0(SP), BX		
  0x1400c6ec6		e83598f4ff		CALL runtime.chansend1(SB)	
  0x1400c6ecb		e9c9f0ffff		JMP 0x1400c5f99			
					c0 := sim.X_i[k] * INV_DX
  0x1400c6ed0		b940420f00		MOVL $0xf4240, CX		
  0x1400c6ed5		e8a675fbff		CALL runtime.panicBounds(SB)	
					c0_3 := sim.X_i[k+3] * INV_DX
  0x1400c6eda		b840420f00		MOVL $0xf4240, AX		
  0x1400c6edf		90			NOPL				
  0x1400c6ee0		e89b75fbff		CALL runtime.panicBounds(SB)	
					c0_2 := sim.X_i[k+2] * INV_DX
  0x1400c6ee5		b840420f00		MOVL $0xf4240, AX		
  0x1400c6eea		b940420f00		MOVL $0xf4240, CX		
  0x1400c6eef		e88c75fbff		CALL runtime.panicBounds(SB)	
					c0_1 := sim.X_i[k+1] * INV_DX
  0x1400c6ef4		b840420f00		MOVL $0xf4240, AX		
  0x1400c6ef9		b940420f00		MOVL $0xf4240, CX		
  0x1400c6efe		6690			NOPW				
  0x1400c6f00		e87b75fbff		CALL runtime.panicBounds(SB)	
					c0_0 := sim.X_i[k] * INV_DX
  0x1400c6f05		b940420f00		MOVL $0xf4240, CX		
  0x1400c6f0a		e87175fbff		CALL runtime.panicBounds(SB)	
					_ = sim.X_i[end-1]
  0x1400c6f0f		b840420f00		MOVL $0xf4240, AX		
  0x1400c6f14		e86775fbff		CALL runtime.panicBounds(SB)	
			sim.WorkerDoneChan <- workerID
  0x1400c6f19		4889d9			MOVQ BX, CX		
  0x1400c6f1c		eb99			JMP 0x1400c6eb7		
						c1 = float64(p) + 1.0 - c0
  0x1400c6f1e		0f57d2			XORPS X2, X2				
  0x1400c6f21		f2480f2ad1		CVTSI2SDQ CX, X2			
  0x1400c6f26		f20f101d32f30000	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x1400c6f2e		f20f58da		ADDSD X2, X3				
  0x1400c6f32		f20f5cd8		SUBSD X0, X3				
						c2 = c0 - float64(p)
  0x1400c6f36		f20f5cc2		SUBSD X2, X0		
						e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]
  0x1400c6f3a		f20f1094cbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X2	
  0x1400c6f43		f20f59d3		MULSD X3, X2				
  0x1400c6f47		f20f10a4cbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X4	
  0x1400c6f50		c4e2f9b9d4		VFMADD231SD X4, X0, X2			
						mean_v = sim.Vx_i[k] + 0.5*e_x*FACTOR_I
  0x1400c6f55		f20f1025ebf20000	MOVSD_XMM $f64.3fe0000000000000(SB), X4	
  0x1400c6f5d		f20f59e2		MULSD X2, X4				
  0x1400c6f61		f20f102d7ff20000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X5	
  0x1400c6f69		f20f59e5		MULSD X5, X4				
  0x1400c6f6d		f2420f58a4d3d0d8b805	ADDSD 0x5b8d8d0(BX)(R10*8), X4		
						diag.counter_i[p] += c1
  0x1400c6f77		488d3c32		LEAQ 0(DX)(SI*1), DI		
  0x1400c6f7b		f20f1034cf		MOVSD_XMM 0(DI)(CX*8), X6	
  0x1400c6f80		f20f58f3		ADDSD X3, X6			
  0x1400c6f84		f20f1134cf		MOVSD_XMM X6, 0(DI)(CX*8)	
						diag.counter_i[p+1] += c2
  0x1400c6f89		f20f1074cf08		MOVSD_XMM 0x8(DI)(CX*8), X6	
  0x1400c6f8f		f20f58f0		ADDSD X0, X6			
  0x1400c6f93		f20f1174cf08		MOVSD_XMM X6, 0x8(DI)(CX*8)	
						diag.ui[p] += c1 * mean_v
  0x1400c6f99		488d3c32		LEAQ 0(DX)(SI*1), DI		
  0x1400c6f9d		488dbf800c0000		LEAQ 0xc80(DI), DI		
  0x1400c6fa4		f20f1034cf		MOVSD_XMM 0(DI)(CX*8), X6	
  0x1400c6fa9		c4e2d9b9f3		VFMADD231SD X3, X4, X6		
  0x1400c6fae		f20f1134cf		MOVSD_XMM X6, 0(DI)(CX*8)	
						diag.ui[p+1] += c2 * mean_v
  0x1400c6fb3		f20f1074cf08		MOVSD_XMM 0x8(DI)(CX*8), X6	
  0x1400c6fb9		c4e2d9b9f0		VFMADD231SD X0, X4, X6		
  0x1400c6fbe		f20f1174cf08		MOVSD_XMM X6, 0x8(DI)(CX*8)	
						v_sqr = mean_v*mean_v + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c6fc4		f2420f10b4d3d0ea3206	MOVSD_XMM 0x632ead0(BX)(R10*8), X6	
  0x1400c6fce		f20f59f6		MULSD X6, X6				
  0x1400c6fd2		c4e2d9b9f4		VFMADD231SD X4, X4, X6			
  0x1400c6fd7		f2420f10a4d3d0fcac06	MOVSD_XMM 0x6acfcd0(BX)(R10*8), X4	
  0x1400c6fe1		c4e2d9b9f4		VFMADD231SD X4, X4, X6			
						energy = 0.5 * AR_MASS * v_sqr * INV_EV_TO_J
  0x1400c6fe6		f20f10255af10000	MOVSD_XMM $f64.3aa4879de14d0b24(SB), X4	
  0x1400c6fee		f20f59f4		MULSD X4, X6				
  0x1400c6ff2		f20f103d86f30000	MOVSD_XMM $f64.43d5a792def818e8(SB), X7	
  0x1400c6ffa		f20f59f7		MULSD X7, X6				
						diag.meanei[p] += c1 * energy
  0x1400c6ffe		488d3c32		LEAQ 0(DX)(SI*1), DI		
  0x1400c7002		488dbf00190000		LEAQ 0x1900(DI), DI		
  0x1400c7009		f2440f1004cf		MOVSD_XMM 0(DI)(CX*8), X8	
  0x1400c700f		c462c9b9c3		VFMADD231SD X3, X6, X8		
  0x1400c7014		f2440f1104cf		MOVSD_XMM X8, 0(DI)(CX*8)	
						diag.meanei[p+1] += c2 * energy
  0x1400c701a		f20f105ccf08		MOVSD_XMM 0x8(DI)(CX*8), X3	
  0x1400c7020		c4e2c9b9d8		VFMADD231SD X0, X6, X3		
  0x1400c7025		f20f115ccf08		MOVSD_XMM X3, 0x8(DI)(CX*8)	
						sim.Vx_i[k] += e_x * FACTOR_I
  0x1400c702b		f2420f1084d3d0d8b805	MOVSD_XMM 0x5b8d8d0(BX)(R10*8), X0	
  0x1400c7035		c4e2d1b9c2		VFMADD231SD X2, X5, X0			
  0x1400c703a		f2420f1184d3d0d8b805	MOVSD_XMM X0, 0x5b8d8d0(BX)(R10*8)	
						sim.X_i[k] += sim.Vx_i[k] * DT_I
  0x1400c7044		f2420f1094d3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R10*8), X2	
  0x1400c704e		f20f101d4af10000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X3	
  0x1400c7056		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
  0x1400c705b		f2420f1194d3d0c63e05	MOVSD_XMM X2, 0x53ec6d0(BX)(R10*8)	
					for k := start; k < end; k++ {
  0x1400c7065		49ffc2			INCQ R10		
  0x1400c7068		4d39ca			CMPQ R10, R9		
  0x1400c706b		0f8da8feffff		JGE 0x1400c6f19		
						c0 = sim.X_i[k] * INV_DX
  0x1400c7071		4981fa40420f00		CMPQ R10, $0xf4240			
  0x1400c7078		733d			JAE 0x1400c70b7				
  0x1400c707a		f2420f1084d3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R10*8), X0	
  0x1400c7084		f20f100dc4f20000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c708c		f20f59c1		MULSD X1, X0				
						p = min(max(int(c0), 0), N_G-2)
  0x1400c7090		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x1400c7095		4885c9			TESTQ CX, CX		
  0x1400c7098		7d06			JGE 0x1400c70a0		
  0x1400c709a		31c9			XORL CX, CX		
  0x1400c709c		0f1f4000		NOPL 0(AX)		
  0x1400c70a0		4881f98e010000		CMPQ CX, $0x18e		
  0x1400c70a7		0f8e71feffff		JLE 0x1400c6f1e		
  0x1400c70ad		b98e010000		MOVL $0x18e, CX		
  0x1400c70b2		e967feffff		JMP 0x1400c6f1e		
						c0 = sim.X_i[k] * INV_DX
  0x1400c70b7		b840420f00		MOVL $0xf4240, AX		
  0x1400c70bc		0f1f4000		NOPL 0(AX)			
  0x1400c70c0		e8bb73fbff		CALL runtime.panicBounds(SB)	
				diag := &sim.WorkerIDiag[workerID]
  0x1400c70c5		e8b673fbff		CALL runtime.panicBounds(SB)	
					d3 := c0_3 - float64(p3)
  0x1400c70ca		0f57ed			XORPS X5, X5		
  0x1400c70cd		f2480f2aee		CVTSI2SDQ SI, X5	
  0x1400c70d2		f20f5cc5		SUBSD X5, X0		
					ex3 := sim.Efield[p3] + d3*(sim.Efield[p3+1]-sim.Efield[p3])
  0x1400c70d6		f20f10acf1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X5	
  0x1400c70df		f20f10b4f1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X6	
  0x1400c70e8		f20f5cf5		SUBSD X5, X6				
  0x1400c70ec		c4e2f9b9ee		VFMADD231SD X6, X0, X5			
					vx0 := sim.Vx_e[k] - ex0*FACTOR_E
  0x1400c70f1		f20f1084c1d090d003	MOVSD_XMM 0x3d090d0(CX)(AX*8), X0	
  0x1400c70fa		f20f1035a6f10000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x1400c7102		f20f59d6		MULSD X6, X2				
  0x1400c7106		f20f5cc2		SUBSD X2, X0				
					vx1 := sim.Vx_e[k+1] - ex1*FACTOR_E
  0x1400c710a		f20f1094c1d890d003	MOVSD_XMM 0x3d090d8(CX)(AX*8), X2	
  0x1400c7113		f20f59de		MULSD X6, X3				
  0x1400c7117		f20f5cd3		SUBSD X3, X2				
					vx2 := sim.Vx_e[k+2] - ex2*FACTOR_E
  0x1400c711b		f20f109cc1e090d003	MOVSD_XMM 0x3d090e0(CX)(AX*8), X3	
  0x1400c7124		f20f59e6		MULSD X6, X4				
  0x1400c7128		f20f5cdc		SUBSD X4, X3				
					vx3 := sim.Vx_e[k+3] - ex3*FACTOR_E
  0x1400c712c		f20f10a4c1e890d003	MOVSD_XMM 0x3d090e8(CX)(AX*8), X4	
					sim.Vx_e[k] = vx0
  0x1400c7135		f20f1184c1d090d003	MOVSD_XMM X0, 0x3d090d0(CX)(AX*8)	
					sim.Vx_e[k+1] = vx1
  0x1400c713e		f20f1194c1d890d003	MOVSD_XMM X2, 0x3d090d8(CX)(AX*8)	
					sim.Vx_e[k+2] = vx2
  0x1400c7147		f20f119cc1e090d003	MOVSD_XMM X3, 0x3d090e0(CX)(AX*8)	
					vx3 := sim.Vx_e[k+3] - ex3*FACTOR_E
  0x1400c7150		f20f59ee		MULSD X6, X5		
  0x1400c7154		f20f5ce5		SUBSD X5, X4		
					sim.Vx_e[k+3] = vx3
  0x1400c7158		f20f11a4c1e890d003	MOVSD_XMM X4, 0x3d090e8(CX)(AX*8)	
					sim.X_e[k] += vx0 * DT_E
  0x1400c7161		f20f10acc1d07e5603	MOVSD_XMM 0x3567ed0(CX)(AX*8), X5	
  0x1400c716a		f20f103d26f00000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X7	
  0x1400c7172		c4e2f9b9ef		VFMADD231SD X7, X0, X5			
  0x1400c7177		f20f11acc1d07e5603	MOVSD_XMM X5, 0x3567ed0(CX)(AX*8)	
					sim.X_e[k+1] += vx1 * DT_E
  0x1400c7180		f20f1084c1d87e5603	MOVSD_XMM 0x3567ed8(CX)(AX*8), X0	
  0x1400c7189		c4e2e9b9c7		VFMADD231SD X7, X2, X0			
  0x1400c718e		f20f1184c1d87e5603	MOVSD_XMM X0, 0x3567ed8(CX)(AX*8)	
					sim.X_e[k+2] += vx2 * DT_E
  0x1400c7197		f20f1084c1e07e5603	MOVSD_XMM 0x3567ee0(CX)(AX*8), X0	
  0x1400c71a0		c4e2e1b9c7		VFMADD231SD X7, X3, X0			
  0x1400c71a5		f20f1184c1e07e5603	MOVSD_XMM X0, 0x3567ee0(CX)(AX*8)	
					sim.X_e[k+3] += vx3 * DT_E
  0x1400c71ae		f20f1084c1e87e5603	MOVSD_XMM 0x3567ee8(CX)(AX*8), X0	
  0x1400c71b7		c4e2d9b9c7		VFMADD231SD X7, X4, X0			
  0x1400c71bc		f20f1184c1e87e5603	MOVSD_XMM X0, 0x3567ee8(CX)(AX*8)	
				for ; k <= end-4; k += 4 {
  0x1400c71c5		4883c004		ADDQ $0x4, AX		
  0x1400c71c9		4839d0			CMPQ AX, DX		
  0x1400c71cc		0f8fd7010000		JG 0x1400c73a9		
					c0_0 := sim.X_e[k] * INV_DX
  0x1400c71d2		483d40420f00		CMPQ AX, $0xf4240			
  0x1400c71d8		0f8367020000		JAE 0x1400c7445				
  0x1400c71de		f20f1084c1d07e5603	MOVSD_XMM 0x3567ed0(CX)(AX*8), X0	
  0x1400c71e7		f20f100d61f10000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c71ef		f20f59c1		MULSD X1, X0				
					p0 := min(max(int(c0_0), 0), N_G-2)
  0x1400c71f3		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c71f8		4885f6			TESTQ SI, SI		
  0x1400c71fb		7d03			JGE 0x1400c7200		
  0x1400c71fd		31f6			XORL SI, SI		
  0x1400c71ff		90			NOPL			
  0x1400c7200		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c7207		7e05			JLE 0x1400c720e		
  0x1400c7209		be8e010000		MOVL $0x18e, SI		
					d0 := c0_0 - float64(p0)
  0x1400c720e		0f57d2			XORPS X2, X2		
  0x1400c7211		f2480f2ad6		CVTSI2SDQ SI, X2	
  0x1400c7216		f20f5cc2		SUBSD X2, X0		
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x1400c721a		f20f1094f1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X2	
  0x1400c7223		f20f109cf1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X3	
  0x1400c722c		f20f5cda		SUBSD X2, X3				
					c0_1 := sim.X_e[k+1] * INV_DX
  0x1400c7230		488d7001		LEAQ 0x1(AX), SI	
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x1400c7234		c4e2f9b9d3		VFMADD231SD X3, X0, X2	
  0x1400c7239		0f1f8000000000		NOPL 0(AX)		
					c0_1 := sim.X_e[k+1] * INV_DX
  0x1400c7240		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c7247		0f83e7010000		JAE 0x1400c7434				
  0x1400c724d		f20f1084c1d87e5603	MOVSD_XMM 0x3567ed8(CX)(AX*8), X0	
  0x1400c7256		f20f59c1		MULSD X1, X0				
					p1 := min(max(int(c0_1), 0), N_G-2)
  0x1400c725a		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c725f		90			NOPL			
  0x1400c7260		4885f6			TESTQ SI, SI		
  0x1400c7263		7d02			JGE 0x1400c7267		
  0x1400c7265		31f6			XORL SI, SI		
  0x1400c7267		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c726e		7e05			JLE 0x1400c7275		
  0x1400c7270		be8e010000		MOVL $0x18e, SI		
					d1 := c0_1 - float64(p1)
  0x1400c7275		0f57db			XORPS X3, X3		
  0x1400c7278		f2480f2ade		CVTSI2SDQ SI, X3	
  0x1400c727d		f20f5cc3		SUBSD X3, X0		
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x1400c7281		f20f109cf1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X3	
  0x1400c728a		f20f10a4f1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X4	
  0x1400c7293		f20f5ce3		SUBSD X3, X4				
					c0_2 := sim.X_e[k+2] * INV_DX
  0x1400c7297		488d7002		LEAQ 0x2(AX), SI	
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x1400c729b		c4e2f9b9dc		VFMADD231SD X4, X0, X3	
					c0_2 := sim.X_e[k+2] * INV_DX
  0x1400c72a0		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c72a7		0f8378010000		JAE 0x1400c7425				
  0x1400c72ad		f20f1084c1e07e5603	MOVSD_XMM 0x3567ee0(CX)(AX*8), X0	
  0x1400c72b6		f20f59c1		MULSD X1, X0				
					p2 := min(max(int(c0_2), 0), N_G-2)
  0x1400c72ba		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c72bf		90			NOPL			
  0x1400c72c0		4885f6			TESTQ SI, SI		
  0x1400c72c3		7d02			JGE 0x1400c72c7		
  0x1400c72c5		31f6			XORL SI, SI		
  0x1400c72c7		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c72ce		7e05			JLE 0x1400c72d5		
  0x1400c72d0		be8e010000		MOVL $0x18e, SI		
					d2 := c0_2 - float64(p2)
  0x1400c72d5		0f57e4			XORPS X4, X4		
  0x1400c72d8		f2480f2ae6		CVTSI2SDQ SI, X4	
  0x1400c72dd		f20f5cc4		SUBSD X4, X0		
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x1400c72e1		f20f10a4f1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X4	
  0x1400c72ea		f20f10acf1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X5	
  0x1400c72f3		f20f5cec		SUBSD X4, X5				
					c0_3 := sim.X_e[k+3] * INV_DX
  0x1400c72f7		488d7003		LEAQ 0x3(AX), SI	
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x1400c72fb		c4e2f9b9e5		VFMADD231SD X5, X0, X4	
					c0_3 := sim.X_e[k+3] * INV_DX
  0x1400c7300		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c7307		0f830d010000		JAE 0x1400c741a				
  0x1400c730d		f20f1084c1e87e5603	MOVSD_XMM 0x3567ee8(CX)(AX*8), X0	
  0x1400c7316		f20f59c1		MULSD X1, X0				
					p3 := min(max(int(c0_3), 0), N_G-2)
  0x1400c731a		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c731f		90			NOPL			
  0x1400c7320		4885f6			TESTQ SI, SI		
  0x1400c7323		7d02			JGE 0x1400c7327		
  0x1400c7325		31f6			XORL SI, SI		
  0x1400c7327		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c732e		0f8e96fdffff		JLE 0x1400c70ca		
  0x1400c7334		be8e010000		MOVL $0x18e, SI		
  0x1400c7339		e98cfdffff		JMP 0x1400c70ca		
					d := c0 - float64(p)
  0x1400c733e		0f57d2			XORPS X2, X2		
  0x1400c7341		f2480f2ad2		CVTSI2SDQ DX, X2	
  0x1400c7346		f20f5cc2		SUBSD X2, X0		
					ex := sim.Efield[p] + d*(sim.Efield[p+1]-sim.Efield[p])
  0x1400c734a		f20f1094d1d00e2707	MOVSD_XMM 0x7270ed0(CX)(DX*8), X2	
  0x1400c7353		f20f109cd1d80e2707	MOVSD_XMM 0x7270ed8(CX)(DX*8), X3	
  0x1400c735c		f20f5cda		SUBSD X2, X3				
  0x1400c7360		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
					sim.Vx_e[k] -= ex * FACTOR_E
  0x1400c7365		f20f1084c1d090d003	MOVSD_XMM 0x3d090d0(CX)(AX*8), X0	
  0x1400c736e		f20f101d32ef0000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X3	
  0x1400c7376		f20f59d3		MULSD X3, X2				
  0x1400c737a		f20f5cc2		SUBSD X2, X0				
  0x1400c737e		f20f1184c1d090d003	MOVSD_XMM X0, 0x3d090d0(CX)(AX*8)	
					sim.X_e[k] += sim.Vx_e[k] * DT_E
  0x1400c7387		f20f1094c1d07e5603	MOVSD_XMM 0x3567ed0(CX)(AX*8), X2	
  0x1400c7390		f20f102500ee0000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X4	
  0x1400c7398		c4e2f9b9d4		VFMADD231SD X4, X0, X2			
  0x1400c739d		f20f1194c1d07e5603	MOVSD_XMM X2, 0x3567ed0(CX)(AX*8)	
				for ; k < end; k++ {
  0x1400c73a6		48ffc0			INCQ AX			
  0x1400c73a9		4c39c8			CMPQ AX, R9		
  0x1400c73ac		7d49			JGE 0x1400c73f7		
					c0 := sim.X_e[k] * INV_DX
  0x1400c73ae		483d40420f00		CMPQ AX, $0xf4240			
  0x1400c73b4		735a			JAE 0x1400c7410				
  0x1400c73b6		f20f1084c1d07e5603	MOVSD_XMM 0x3567ed0(CX)(AX*8), X0	
  0x1400c73bf		f20f100d89ef0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c73c7		f20f59c1		MULSD X1, X0				
					p := min(max(int(c0), 0), N_G-2)
  0x1400c73cb		f2480f2cd0		CVTTSD2SIQ X0, DX	
  0x1400c73d0		4885d2			TESTQ DX, DX		
  0x1400c73d3		7d0b			JGE 0x1400c73e0		
  0x1400c73d5		31d2			XORL DX, DX		
  0x1400c73d7		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x1400c73e0		4881fa8e010000		CMPQ DX, $0x18e		
  0x1400c73e7		0f8e51ffffff		JLE 0x1400c733e		
  0x1400c73ed		ba8e010000		MOVL $0x18e, DX		
  0x1400c73f2		e947ffffff		JMP 0x1400c733e		
			sim.WorkerDoneChan <- workerID
  0x1400c73f7		488b81502eba07		MOVQ 0x7ba2e50(CX), AX		
  0x1400c73fe		488d9c24f0000000	LEAQ 0xf0(SP), BX		
  0x1400c7406		e8f592f4ff		CALL runtime.chansend1(SB)	
  0x1400c740b		e989ebffff		JMP 0x1400c5f99			
					c0 := sim.X_e[k] * INV_DX
  0x1400c7410		b940420f00		MOVL $0xf4240, CX		
  0x1400c7415		e86670fbff		CALL runtime.panicBounds(SB)	
					c0_3 := sim.X_e[k+3] * INV_DX
  0x1400c741a		b840420f00		MOVL $0xf4240, AX		
  0x1400c741f		90			NOPL				
  0x1400c7420		e85b70fbff		CALL runtime.panicBounds(SB)	
					c0_2 := sim.X_e[k+2] * INV_DX
  0x1400c7425		b840420f00		MOVL $0xf4240, AX		
  0x1400c742a		b940420f00		MOVL $0xf4240, CX		
  0x1400c742f		e84c70fbff		CALL runtime.panicBounds(SB)	
					c0_1 := sim.X_e[k+1] * INV_DX
  0x1400c7434		b840420f00		MOVL $0xf4240, AX		
  0x1400c7439		b940420f00		MOVL $0xf4240, CX		
  0x1400c743e		6690			NOPW				
  0x1400c7440		e83b70fbff		CALL runtime.panicBounds(SB)	
					c0_0 := sim.X_e[k] * INV_DX
  0x1400c7445		b940420f00		MOVL $0xf4240, CX		
  0x1400c744a		e83170fbff		CALL runtime.panicBounds(SB)	
					_ = sim.X_e[end-1]
  0x1400c744f		b840420f00		MOVL $0xf4240, AX		
  0x1400c7454		e82770fbff		CALL runtime.panicBounds(SB)	
			sim.WorkerDoneChan <- workerID
  0x1400c7459		4889d9			MOVQ BX, CX		
  0x1400c745c		eb99			JMP 0x1400c73f7		
						sim.Vx_e[k] -= e_x * FACTOR_E
  0x1400c745e		f2420f10acd3d090d003	MOVSD_XMM 0x3d090d0(BX)(R10*8), X5	
  0x1400c7468		f20f59d6		MULSD X6, X2				
  0x1400c746c		f20f5cea		SUBSD X2, X5				
  0x1400c7470		f2420f11acd3d090d003	MOVSD_XMM X5, 0x3d090d0(BX)(R10*8)	
						sim.X_e[k] += sim.Vx_e[k] * DT_E
  0x1400c747a		f2420f1094d3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R10*8), X2	
  0x1400c7484		c4c2d1b9d0		VFMADD231SD X8, X5, X2			
  0x1400c7489		f2420f1194d3d07e5603	MOVSD_XMM X2, 0x3567ed0(BX)(R10*8)	
					for k := start; k < end; k++ {
  0x1400c7493		49ffc2			INCQ R10		
  0x1400c7496		4d39ca			CMPQ R10, R9		
  0x1400c7499		7dbe			JGE 0x1400c7459		
  0x1400c749b		0f1f440000		NOPL 0(AX)(AX*1)	
						c0 = sim.X_e[k] * INV_DX
  0x1400c74a0		4981fa40420f00		CMPQ R10, $0xf4240			
  0x1400c74a7		0f83c2020000		JAE 0x1400c776f				
  0x1400c74ad		f2420f1084d3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R10*8), X0	
  0x1400c74b7		f20f100d91ee0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c74bf		f20f59c1		MULSD X1, X0				
						p = min(max(int(c0), 0), N_G-2)
  0x1400c74c3		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x1400c74c8		4885c9			TESTQ CX, CX		
  0x1400c74cb		7d02			JGE 0x1400c74cf		
  0x1400c74cd		31c9			XORL CX, CX		
  0x1400c74cf		4881f98e010000		CMPQ CX, $0x18e		
  0x1400c74d6		7e05			JLE 0x1400c74dd		
  0x1400c74d8		b98e010000		MOVL $0x18e, CX		
						c2 = c0 - float64(p)
  0x1400c74dd		0f57d2			XORPS X2, X2		
  0x1400c74e0		f2480f2ad1		CVTSI2SDQ CX, X2	
						c1 = float64(p) + 1.0 - c0
  0x1400c74e5		f20f101d73ed0000	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x1400c74ed		f20f58da		ADDSD X2, X3				
  0x1400c74f1		f20f5cd8		SUBSD X0, X3				
						c2 = c0 - float64(p)
  0x1400c74f5		f20f5cc2		SUBSD X2, X0		
						e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]
  0x1400c74f9		f20f1094cbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X2	
  0x1400c7502		f20f59d3		MULSD X3, X2				
  0x1400c7506		f20f10a4cbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X4	
  0x1400c750f		c4e2f9b9d4		VFMADD231SD X4, X0, X2			
						mean_v = sim.Vx_e[k] - 0.5*e_x*FACTOR_E
  0x1400c7514		f2420f10a4d3d090d003	MOVSD_XMM 0x3d090d0(BX)(R10*8), X4	
  0x1400c751e		f20f102d22ed0000	MOVSD_XMM $f64.3fe0000000000000(SB), X5	
  0x1400c7526		f20f59ea		MULSD X2, X5				
  0x1400c752a		f20f103576ed0000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x1400c7532		f20f59ee		MULSD X6, X5				
  0x1400c7536		f20f5ce5		SUBSD X5, X4				
						diag.counter_e[p] += c1
  0x1400c753a		488d3c32		LEAQ 0(DX)(SI*1), DI		
  0x1400c753e		f20f102ccf		MOVSD_XMM 0(DI)(CX*8), X5	
  0x1400c7543		f20f58eb		ADDSD X3, X5			
  0x1400c7547		f20f112ccf		MOVSD_XMM X5, 0(DI)(CX*8)	
						diag.counter_e[p+1] += c2
  0x1400c754c		f20f106ccf08		MOVSD_XMM 0x8(DI)(CX*8), X5	
  0x1400c7552		f20f58e8		ADDSD X0, X5			
  0x1400c7556		f20f116ccf08		MOVSD_XMM X5, 0x8(DI)(CX*8)	
						diag.ue[p] += c1 * mean_v
  0x1400c755c		488d3c32		LEAQ 0(DX)(SI*1), DI		
  0x1400c7560		488dbf800c0000		LEAQ 0xc80(DI), DI		
  0x1400c7567		f20f102ccf		MOVSD_XMM 0(DI)(CX*8), X5	
  0x1400c756c		c4e2d9b9eb		VFMADD231SD X3, X4, X5		
  0x1400c7571		f20f112ccf		MOVSD_XMM X5, 0(DI)(CX*8)	
						diag.ue[p+1] += c2 * mean_v
  0x1400c7576		f20f106ccf08		MOVSD_XMM 0x8(DI)(CX*8), X5	
  0x1400c757c		c4e2f9b9ec		VFMADD231SD X4, X0, X5		
  0x1400c7581		f20f116ccf08		MOVSD_XMM X5, 0x8(DI)(CX*8)	
						v_sqr = mean_v*mean_v + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
  0x1400c7587		f20f59e4		MULSD X4, X4				
  0x1400c758b		f2420f10acd3d0a24a04	MOVSD_XMM 0x44aa2d0(BX)(R10*8), X5	
  0x1400c7595		c4e2d1b9e5		VFMADD231SD X5, X5, X4			
  0x1400c759a		f2420f10acd3d0b4c404	MOVSD_XMM 0x4c4b4d0(BX)(R10*8), X5	
  0x1400c75a4		c4e2d1b9e5		VFMADD231SD X5, X5, X4			
						energy = 0.5 * E_MASS * v_sqr * INV_EV_TO_J
  0x1400c75a9		f20f102d87eb0000	MOVSD_XMM $f64.39a279dcc3e61461(SB), X5	
  0x1400c75b1		f20f59ec		MULSD X4, X5				
  0x1400c75b5		f20f103dc3ed0000	MOVSD_XMM $f64.43d5a792def818e8(SB), X7	
  0x1400c75bd		f20f59fd		MULSD X5, X7				
						diag.meanee[p] += c1 * energy
  0x1400c75c1		488d3c32		LEAQ 0(DX)(SI*1), DI		
  0x1400c75c5		488dbf00190000		LEAQ 0x1900(DI), DI		
  0x1400c75cc		f2440f1004cf		MOVSD_XMM 0(DI)(CX*8), X8	
  0x1400c75d2		c462c1b9c3		VFMADD231SD X3, X7, X8		
  0x1400c75d7		f2440f1104cf		MOVSD_XMM X8, 0(DI)(CX*8)	
						diag.meanee[p+1] += c2 * energy
  0x1400c75dd		f2440f1044cf08		MOVSD_XMM 0x8(DI)(CX*8), X8	
  0x1400c75e4		c462c1b9c0		VFMADD231SD X0, X7, X8		
  0x1400c75e9		f2440f1144cf08		MOVSD_XMM X8, 0x8(DI)(CX*8)	
						energy_index = minInt(int(v_sqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
  0x1400c75f0		f2440f10054fec0000	MOVSD_XMM $f64.3fe0000000000000(SB), X8	
  0x1400c75f9		f2440f100daeeb0000	MOVSD_XMM $f64.3e286b6a97118d9b(SB), X9	
  0x1400c7602		c462b1b9c4		VFMADD231SD X4, X9, X8			
  0x1400c7607		f2490f2cf8		CVTTSD2SIQ X8, DI			
	if a < b {
  0x1400c760c		4881ff3f420f00		CMPQ DI, $0xf423f	
  0x1400c7613		7c05			JL 0x1400c761a		
  0x1400c7615		bf3f420f00		MOVL $0xf423f, DI	
						velocity = math.Sqrt(v_sqr)
  0x1400c761a		90			NOPL			
  0x1400c761b		0f1f440000		NOPL 0(AX)(AX*1)	
						rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x1400c7620		4881ff40420f00		CMPQ DI, $0xf4240	
  0x1400c7627		0f8338010000		JAE 0x1400c7765		
						diag.ioniz[p] += c1 * rate
  0x1400c762d		4c8d1c16		LEAQ 0(SI)(DX*1), R11	
  0x1400c7631		4d8d9b80250000		LEAQ 0x2580(R11), R11	
	return sqrt(x)
  0x1400c7638		f20f51e4		SQRTSD X4, X4		
						rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x1400c763c		f20f59a4fbc024f400	MULSD 0xf424c0(BX)(DI*8), X4			
  0x1400c7645		f2440f10054aeb0000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X8		
  0x1400c764e		f2410f59e0		MULSD X8, X4					
  0x1400c7653		f2440f10152ced0000	MOVSD_XMM $f64.445c0bbef48bc79c(SB), X10	
  0x1400c765c		f2410f59e2		MULSD X10, X4					
						diag.ioniz[p] += c1 * rate
  0x1400c7661		f20f59dc		MULSD X4, X3			
  0x1400c7665		f2410f581ccb		ADDSD 0(R11)(CX*8), X3		
  0x1400c766b		f2410f111ccb		MOVSD_XMM X3, 0(R11)(CX*8)	
						diag.ioniz[p+1] += c2 * rate
  0x1400c7671		f2410f105ccb08		MOVSD_XMM 0x8(R11)(CX*8), X3	
  0x1400c7678		c4e2d9b9d8		VFMADD231SD X0, X4, X3		
  0x1400c767d		f2410f115ccb08		MOVSD_XMM X3, 0x8(R11)(CX*8)	
						if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
  0x1400c7684		f2420f1084d3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R10*8), X0	
  0x1400c768e		f20f101d6aeb0000	MOVSD_XMM $f64.3f870a3d70a3d70b(SB), X3	
  0x1400c7696		660f2ec3		UCOMISD X3, X0				
  0x1400c769a		660f1f440000		NOPW 0(AX)(AX*1)			
  0x1400c76a0		0f8689000000		JBE 0x1400c772f				
  0x1400c76a6		f20f10255aeb0000	MOVSD_XMM $f64.3f8c28f5c28f5c2a(SB), X4	
  0x1400c76ae		660f2ee0		UCOMISD X0, X4				
  0x1400c76b2		0f867f000000		JBE 0x1400c7737				
							energy_index = int(energy * INV_DE_EEPF)
  0x1400c76b8		f20f100548ec0000	MOVSD_XMM $f64.4034000000000000(SB), X0	
  0x1400c76c0		f20f59f8		MULSD X0, X7				
  0x1400c76c4		f2480f2ccf		CVTTSD2SIQ X7, CX			
							if energy_index < N_EEPF {
  0x1400c76c9		4881f9d0070000		CMPQ CX, $0x7d0		
  0x1400c76d0		7d27			JGE 0x1400c76f9		
								diag.eepf[energy_index] += 1.0
  0x1400c76d2		488d3c16		LEAQ 0(SI)(DX*1), DI				
  0x1400c76d6		488dbf00320000		LEAQ 0x3200(DI), DI				
  0x1400c76dd		7377			JAE 0x1400c7756					
  0x1400c76df		f20f103ccf		MOVSD_XMM 0(DI)(CX*8), X7			
  0x1400c76e4		f2440f101d73eb0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
  0x1400c76ed		f2410f58fb		ADDSD X11, X7					
  0x1400c76f2		f20f113ccf		MOVSD_XMM X7, 0(DI)(CX*8)			
  0x1400c76f7		eb09			JMP 0x1400c7702					
  0x1400c76f9		f2440f101d5eeb0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
							diag.accuCenter += energy
  0x1400c7702		f20f10bc1680700000	MOVSD_XMM 0x7080(SI)(DX*1), X7			
  0x1400c770b		f2440f10256cec0000	MOVSD_XMM $f64.43d5a792def818e8(SB), X12	
  0x1400c7714		c4e299b9fd		VFMADD231SD X5, X12, X7				
  0x1400c7719		f20f11bc1680700000	MOVSD_XMM X7, 0x7080(SI)(DX*1)			
							diag.counterCenter++
  0x1400c7722		48ff841688700000	INCQ 0x7088(SI)(DX*1)			
  0x1400c772a		e92ffdffff		JMP 0x1400c745e				
  0x1400c772f		f20f1025d1ea0000	MOVSD_XMM $f64.3f8c28f5c28f5c2a(SB), X4	
						if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
  0x1400c7737		f20f1005c9eb0000	MOVSD_XMM $f64.4034000000000000(SB), X0		
  0x1400c773f		f2440f101d18eb0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
  0x1400c7748		f2440f10252fec0000	MOVSD_XMM $f64.43d5a792def818e8(SB), X12	
  0x1400c7751		e908fdffff		JMP 0x1400c745e					
								diag.eepf[energy_index] += 1.0
  0x1400c7756		b8d0070000		MOVL $0x7d0, AX			
  0x1400c775b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x1400c7760		e81b6dfbff		CALL runtime.panicBounds(SB)	
						rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x1400c7765		b840420f00		MOVL $0xf4240, AX		
  0x1400c776a		e8116dfbff		CALL runtime.panicBounds(SB)	
						c0 = sim.X_e[k] * INV_DX
  0x1400c776f		b840420f00		MOVL $0xf4240, AX		
  0x1400c7774		e8076dfbff		CALL runtime.panicBounds(SB)	
				diag := &sim.WorkerEDiag[workerID]
  0x1400c7779		e8026dfbff		CALL runtime.panicBounds(SB)	
			sim.WorkerDoneChan <- workerID
  0x1400c777e		488b83502eba07		MOVQ 0x7ba2e50(BX), AX		
  0x1400c7785		488d9c24f0000000	LEAQ 0xf0(SP), BX		
  0x1400c778d		e86e8ff4ff		CALL runtime.chansend1(SB)	
  0x1400c7792		e902e8ffff		JMP 0x1400c5f99			
					d := c0 - float64(p)
  0x1400c7797		0f57d2			XORPS X2, X2		
  0x1400c779a		f2480f2ad1		CVTSI2SDQ CX, X2	
  0x1400c779f		f20f5cc2		SUBSD X2, X0		
					densityI[p] += (1.0 - d) * FACTOR_W
  0x1400c77a3		f20f1015b5ea0000	MOVSD_XMM $f64.3ff0000000000000(SB), X2	
  0x1400c77ab		f20f5cd0		SUBSD X0, X2				
  0x1400c77af		f20f101db9eb0000	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X3	
  0x1400c77b7		f20f59d3		MULSD X3, X2				
  0x1400c77bb		f20f5814ca		ADDSD 0(DX)(CX*8), X2			
  0x1400c77c0		f20f1114ca		MOVSD_XMM X2, 0(DX)(CX*8)		
					densityI[p+1] += d * FACTOR_W
  0x1400c77c5		f20f59c3		MULSD X3, X0			
  0x1400c77c9		f20f5844ca08		ADDSD 0x8(DX)(CX*8), X0		
  0x1400c77cf		f20f1144ca08		MOVSD_XMM X0, 0x8(DX)(CX*8)	
				for k := start; k < end; k++ {
  0x1400c77d5		49ffc2			INCQ R10		
  0x1400c77d8		4d39ca			CMPQ R10, R9		
  0x1400c77db		7da1			JGE 0x1400c777e		
  0x1400c77dd		0f1f00			NOPL 0(AX)		
					c0 := sim.X_i[k] * INV_DX
  0x1400c77e0		4981fa40420f00		CMPQ R10, $0xf4240			
  0x1400c77e7		7335			JAE 0x1400c781e				
  0x1400c77e9		f2420f1084d3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R10*8), X0	
  0x1400c77f3		f20f100d55eb0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c77fb		f20f59c1		MULSD X1, X0				
					p := min(max(int(c0), 0), N_G-2)
  0x1400c77ff		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x1400c7804		4885c9			TESTQ CX, CX		
  0x1400c7807		7d02			JGE 0x1400c780b		
  0x1400c7809		31c9			XORL CX, CX		
  0x1400c780b		4881f98e010000		CMPQ CX, $0x18e		
  0x1400c7812		7e83			JLE 0x1400c7797		
  0x1400c7814		b98e010000		MOVL $0x18e, CX		
  0x1400c7819		e979ffffff		JMP 0x1400c7797		
					c0 := sim.X_i[k] * INV_DX
  0x1400c781e		b840420f00		MOVL $0xf4240, AX		
  0x1400c7823		e8586cfbff		CALL runtime.panicBounds(SB)	
			densityI := &sim.WorkerIDensity[workerID]
  0x1400c7828		e8536cfbff		CALL runtime.panicBounds(SB)	
			sim.WorkerDoneChan <- workerID
  0x1400c782d		488b83502eba07		MOVQ 0x7ba2e50(BX), AX		
  0x1400c7834		488d9c24f0000000	LEAQ 0xf0(SP), BX		
  0x1400c783c		0f1f4000		NOPL 0(AX)			
  0x1400c7840		e8bb8ef4ff		CALL runtime.chansend1(SB)	
  0x1400c7845		e94fe7ffff		JMP 0x1400c5f99			
					d := c0 - float64(p)
  0x1400c784a		0f57d2			XORPS X2, X2		
  0x1400c784d		f2480f2ad1		CVTSI2SDQ CX, X2	
  0x1400c7852		f20f5cc2		SUBSD X2, X0		
					densityE[p] += (1.0 - d) * FACTOR_W
  0x1400c7856		f20f101502ea0000	MOVSD_XMM $f64.3ff0000000000000(SB), X2	
  0x1400c785e		f20f5cd0		SUBSD X0, X2				
  0x1400c7862		f20f101d06eb0000	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X3	
  0x1400c786a		f20f59d3		MULSD X3, X2				
  0x1400c786e		f20f5814ca		ADDSD 0(DX)(CX*8), X2			
  0x1400c7873		f20f1114ca		MOVSD_XMM X2, 0(DX)(CX*8)		
					densityE[p+1] += d * FACTOR_W
  0x1400c7878		f20f59c3		MULSD X3, X0			
  0x1400c787c		f20f5844ca08		ADDSD 0x8(DX)(CX*8), X0		
  0x1400c7882		f20f1144ca08		MOVSD_XMM X0, 0x8(DX)(CX*8)	
				for k := start; k < end; k++ {
  0x1400c7888		49ffc2			INCQ R10		
  0x1400c788b		4d39ca			CMPQ R10, R9		
  0x1400c788e		7d9d			JGE 0x1400c782d		
					c0 := sim.X_e[k] * INV_DX
  0x1400c7890		4981fa40420f00		CMPQ R10, $0xf4240			
  0x1400c7897		733a			JAE 0x1400c78d3				
  0x1400c7899		f2420f1084d3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R10*8), X0	
  0x1400c78a3		f20f100da5ea0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c78ab		f20f59c1		MULSD X1, X0				
					p := min(max(int(c0), 0), N_G-2)
  0x1400c78af		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x1400c78b4		4885c9			TESTQ CX, CX		
  0x1400c78b7		7d07			JGE 0x1400c78c0		
  0x1400c78b9		31c9			XORL CX, CX		
  0x1400c78bb		0f1f440000		NOPL 0(AX)(AX*1)	
  0x1400c78c0		4881f98e010000		CMPQ CX, $0x18e		
  0x1400c78c7		7e81			JLE 0x1400c784a		
  0x1400c78c9		b98e010000		MOVL $0x18e, CX		
  0x1400c78ce		e977ffffff		JMP 0x1400c784a		
					c0 := sim.X_e[k] * INV_DX
  0x1400c78d3		b840420f00		MOVL $0xf4240, AX		
  0x1400c78d8		e8a36bfbff		CALL runtime.panicBounds(SB)	
			densityE := &sim.WorkerEDensity[workerID]
  0x1400c78dd		0f1f00			NOPL 0(AX)			
  0x1400c78e0		e89b6bfbff		CALL runtime.panicBounds(SB)	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c78e5		e8966bfbff		CALL runtime.panicBounds(SB)	
  0x1400c78ea		90			NOPL				
func (sim *SimulationState) startWorker(workerID int) {
  0x1400c78eb		4889442408		MOVQ AX, 0x8(SP)				
  0x1400c78f0		48895c2410		MOVQ BX, 0x10(SP)				
  0x1400c78f5		e8464dfbff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x1400c78fa		488b442408		MOVQ 0x8(SP), AX				
  0x1400c78ff		488b5c2410		MOVQ 0x10(SP), BX				
  0x1400c7904		e937e6ffff		JMP gopic.(*SimulationState).startWorker(SB)	

  0x1400c7909		cc			INT $0x3		
  0x1400c790a		cc			INT $0x3		
  0x1400c790b		cc			INT $0x3		
  0x1400c790c		cc			INT $0x3		
  0x1400c790d		cc			INT $0x3		
  0x1400c790e		cc			INT $0x3		
  0x1400c790f		cc			INT $0x3		
  0x1400c7910		cc			INT $0x3		
  0x1400c7911		cc			INT $0x3		
  0x1400c7912		cc			INT $0x3		
  0x1400c7913		cc			INT $0x3		
  0x1400c7914		cc			INT $0x3		
  0x1400c7915		cc			INT $0x3		
  0x1400c7916		cc			INT $0x3		
  0x1400c7917		cc			INT $0x3		
  0x1400c7918		cc			INT $0x3		
  0x1400c7919		cc			INT $0x3		
  0x1400c791a		cc			INT $0x3		
  0x1400c791b		cc			INT $0x3		
  0x1400c791c		cc			INT $0x3		
  0x1400c791d		cc			INT $0x3		
  0x1400c791e		cc			INT $0x3		
  0x1400c791f		cc			INT $0x3		
