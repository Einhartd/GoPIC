// =============================================================================
// SYMBOL: startWorker
// =============================================================================

TEXT gopic.(*SimulationState).startWorker(SB) C:/Users/E14/Documents/GitHub/GoPIC/Go/parallel_channels/worker.go
func (sim *SimulationState) startWorker(workerID int) {
  0x1400c5aa0		4c8da42440ffffff	LEAQ 0xffffff40(SP), R12	
  0x1400c5aa8		4d3b6610		CMPQ R12, 0x10(R14)		
  0x1400c5aac		0f86681d0000		JBE 0x1400c781a			
  0x1400c5ab2		55			PUSHQ BP			
  0x1400c5ab3		4889e5			MOVQ SP, BP			
  0x1400c5ab6		4881ec38010000		SUBQ $0x138, SP			
  0x1400c5abd		48899c2450010000	MOVQ BX, 0x150(SP)		
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c5ac5		8400			TESTB AL, 0(AX)		
  0x1400c5ac7		488b88582eba07		MOVQ 0x7ba2e58(AX), CX	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c5ace		4839cb			CMPQ BX, CX		
  0x1400c5ad1		0f833d1d0000		JAE 0x1400c7814		
  0x1400c5ad7		4889842448010000	MOVQ AX, 0x148(SP)	
	numWorkers := len(sim.WorkerCmdChan)
  0x1400c5adf		48898c2410010000	MOVQ CX, 0x110(SP)	
  0x1400c5ae7		488b90502eba07		MOVQ 0x7ba2e50(AX), DX	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c5aee		488b14da			MOVQ 0(DX)(BX*8), DX		
  0x1400c5af2		4889942430010000		MOVQ DX, 0x130(SP)		
  0x1400c5afa		eb08				JMP 0x1400c5b04			
  0x1400c5afc		488b942430010000		MOVQ 0x130(SP), DX		
  0x1400c5b04		4889d0				MOVQ DX, AX			
  0x1400c5b07		488d9c2418010000		LEAQ 0x118(SP), BX		
  0x1400c5b0f		e88cbaf4ff			CALL runtime.chanrecv2(SB)	
  0x1400c5b14		84c0				TESTL AL, AL			
  0x1400c5b16		0f84bc050000			JE 0x1400c60d8			
  0x1400c5b1c		488b942418010000		MOVQ 0x118(SP), DX		
  0x1400c5b24		48c784241801000000000000	MOVQ $0x0, 0x118(SP)		
		switch cmd {
  0x1400c5b30		4883fa08		CMPQ DX, $0x8								
  0x1400c5b34		77c6			JA 0x1400c5afc								
  0x1400c5b36		488d0543460100		LEAQ internal/runtime/gc/scan.expandAVX512_64_outShufLo+64(SB), AX	
  0x1400c5b3d		0f1f00			NOPL 0(AX)								
  0x1400c5b40		ff24d0			JMP 0(AX)(DX*8)								
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c5b43		488b942448010000	MOVQ 0x148(SP), DX	
  0x1400c5b4b		488bb2c07e5603		MOVQ 0x3567ec0(DX), SI	
  0x1400c5b52		4c8b842410010000	MOVQ 0x110(SP), R8	
  0x1400c5b5a		498d0430		LEAQ 0(R8)(SI*1), AX	
  0x1400c5b5e		488d40ff		LEAQ -0x1(AX), AX	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c5b62		4889d1			MOVQ DX, CX		
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c5b65		4899			CQO			
  0x1400c5b67		49f7f8			IDIVQ R8		
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c5b6a		488b942450010000	MOVQ 0x150(SP), DX	
  0x1400c5b72		4c8d4a01		LEAQ 0x1(DX), R9	
  0x1400c5b76		4c0fafc8		IMULQ AX, R9		
			densityE := &sim.WorkerEDensity[workerID]
  0x1400c5b7a		4c8b5108		MOVQ 0x8(CX), R10	
			start := workerID * chunkSize
  0x1400c5b7e		480fafc2		IMULQ DX, AX		
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c5b82		4c39ce			CMPQ SI, R9		
  0x1400c5b85		4c0f4cce		CMOVL SI, R9		
			densityE := &sim.WorkerEDensity[workerID]
  0x1400c5b89		4939d2			CMPQ R10, DX		
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c5b8c		0f867d1c0000		JBE 0x1400c780f		
			densityE := &sim.WorkerEDensity[workerID]
  0x1400c5b92		488b31			MOVQ 0(CX), SI		
  0x1400c5b95		4869d2800c0000		IMULQ $0xc80, DX, DX	
			for i := range N_G {
  0x1400c5b9c		488d3c16		LEAQ 0(SI)(DX*1), DI	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c5ba0		4889cb			MOVQ CX, BX		
			for i := range N_G {
  0x1400c5ba3		b990010000		MOVL $0x190, CX		
			start := workerID * chunkSize
  0x1400c5ba8		4989c2			MOVQ AX, R10		
			for i := range N_G {
  0x1400c5bab		31c0			XORL AX, AX		
  0x1400c5bad		f348ab			REP; STOSQ AX, ES:0(DI)	
			densityE := &sim.WorkerEDensity[workerID]
  0x1400c5bb0		4801f2			ADDQ SI, DX		
			if start < end {
  0x1400c5bb3		4d39d1			CMPQ R9, R10		
  0x1400c5bb6		0f8ffe1b0000		JG 0x1400c77ba		
  0x1400c5bbc		0f1f4000		NOPL 0(AX)		
  0x1400c5bc0		e9921b0000		JMP 0x1400c7757		
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x1400c5bc5		488b942448010000	MOVQ 0x148(SP), DX	
  0x1400c5bcd		488bb2c87e5603		MOVQ 0x3567ec8(DX), SI	
  0x1400c5bd4		4c8b842410010000	MOVQ 0x110(SP), R8	
  0x1400c5bdc		498d0430		LEAQ 0(R8)(SI*1), AX	
  0x1400c5be0		488d40ff		LEAQ -0x1(AX), AX	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c5be4		4889d1			MOVQ DX, CX		
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x1400c5be7		4899			CQO			
  0x1400c5be9		49f7f8			IDIVQ R8		
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c5bec		488b942450010000	MOVQ 0x150(SP), DX	
  0x1400c5bf4		4c8d4a01		LEAQ 0x1(DX), R9	
  0x1400c5bf8		4c0fafc8		IMULQ AX, R9		
			densityI := &sim.WorkerIDensity[workerID]
  0x1400c5bfc		4c8b5120		MOVQ 0x20(CX), R10	
			start := workerID * chunkSize
  0x1400c5c00		480fafc2		IMULQ DX, AX		
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c5c04		4c39ce			CMPQ SI, R9		
  0x1400c5c07		4c0f4cce		CMOVL SI, R9		
			densityI := &sim.WorkerIDensity[workerID]
  0x1400c5c0b		4939d2			CMPQ R10, DX		
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c5c0e		0f863e1b0000		JBE 0x1400c7752		
			densityI := &sim.WorkerIDensity[workerID]
  0x1400c5c14		488b7118		MOVQ 0x18(CX), SI	
  0x1400c5c18		4869d2800c0000		IMULQ $0xc80, DX, DX	
			for i := range N_G {
  0x1400c5c1f		488d3c16		LEAQ 0(SI)(DX*1), DI	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c5c23		4889cb			MOVQ CX, BX		
			for i := range N_G {
  0x1400c5c26		b990010000		MOVL $0x190, CX		
			start := workerID * chunkSize
  0x1400c5c2b		4989c2			MOVQ AX, R10		
			for i := range N_G {
  0x1400c5c2e		31c0			XORL AX, AX		
  0x1400c5c30		f348ab			REP; STOSQ AX, ES:0(DI)	
			densityI := &sim.WorkerIDensity[workerID]
  0x1400c5c33		4801f2			ADDQ SI, DX		
			if start < end {
  0x1400c5c36		4d39d1			CMPQ R9, R10		
  0x1400c5c39		0f8fc21a0000		JG 0x1400c7701		
  0x1400c5c3f		90			NOPL			
  0x1400c5c40		e9591a0000		JMP 0x1400c769e		
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c5c45		488b942448010000	MOVQ 0x148(SP), DX	
  0x1400c5c4d		488bb2c07e5603		MOVQ 0x3567ec0(DX), SI	
  0x1400c5c54		4c8b842410010000	MOVQ 0x110(SP), R8	
  0x1400c5c5c		498d0430		LEAQ 0(R8)(SI*1), AX	
  0x1400c5c60		488d40ff		LEAQ -0x1(AX), AX	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c5c64		4889d1			MOVQ DX, CX		
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c5c67		4899			CQO			
  0x1400c5c69		49f7f8			IDIVQ R8		
			start := workerID * chunkSize
  0x1400c5c6c		488b942450010000	MOVQ 0x150(SP), DX	
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c5c74		4c8d4a01		LEAQ 0x1(DX), R9	
  0x1400c5c78		4c0fafc8		IMULQ AX, R9		
			start := workerID * chunkSize
  0x1400c5c7c		480fafc2		IMULQ DX, AX		
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c5c80		4c39ce			CMPQ SI, R9		
  0x1400c5c83		4c0f4cce		CMOVL SI, R9		
			if sim.Measurement_mode {
  0x1400c5c87		80b9e02dba0700		CMPB 0x7ba2de0(CX), $0x0	
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c5c8e		743e			JE 0x1400c5cce		
				diag := &sim.WorkerEDiag[workerID]
  0x1400c5c90		488b7138		MOVQ 0x38(CX), SI	
  0x1400c5c94		4839d6			CMPQ SI, DX		
  0x1400c5c97		0f86fc190000		JBE 0x1400c7699		
  0x1400c5c9d		488b7130		MOVQ 0x30(CX), SI	
  0x1400c5ca1		4869d2c0700000		IMULQ $0x70c0, DX, DX	
  0x1400c5ca8		488d3c16		LEAQ 0(SI)(DX*1), DI	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c5cac		4889cb			MOVQ CX, BX		
				*diag = electronWorkerDiagnostics{}
  0x1400c5caf		b9180e0000		MOVL $0xe18, CX		
			start := workerID * chunkSize
  0x1400c5cb4		4989c2			MOVQ AX, R10		
				*diag = electronWorkerDiagnostics{}
  0x1400c5cb7		31c0			XORL AX, AX		
  0x1400c5cb9		f348ab			REP; STOSQ AX, ES:0(DI)	
  0x1400c5cbc		0f1f4000		NOPL 0(AX)		
				if start < end {
  0x1400c5cc0		4d39d1			CMPQ R9, R10		
  0x1400c5cc3		0f8fed160000		JG 0x1400c73b6		
  0x1400c5cc9		e9ab160000		JMP 0x1400c7379		
				if end > start {
  0x1400c5cce		4939c1			CMPQ R9, AX		
  0x1400c5cd1		7e1a			JLE 0x1400c5ced		
					_ = sim.X_e[end-1]
  0x1400c5cd3		498d51ff		LEAQ -0x1(R9), DX	
  0x1400c5cd7		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x1400c5ce0		4881fa40420f00		CMPQ DX, $0xf4240	
  0x1400c5ce7		0f8382160000		JAE 0x1400c736f		
				for ; k <= end-4; k += 4 {
  0x1400c5ced		498d51fc		LEAQ -0x4(R9), DX	
  0x1400c5cf1		e9f3130000		JMP 0x1400c70e9		
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x1400c5cf6		488b942448010000	MOVQ 0x148(SP), DX	
  0x1400c5cfe		488bb2c87e5603		MOVQ 0x3567ec8(DX), SI	
  0x1400c5d05		4c8b842410010000	MOVQ 0x110(SP), R8	
  0x1400c5d0d		498d0430		LEAQ 0(R8)(SI*1), AX	
  0x1400c5d11		488d40ff		LEAQ -0x1(AX), AX	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c5d15		4889d1			MOVQ DX, CX		
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x1400c5d18		4899			CQO			
  0x1400c5d1a		49f7f8			IDIVQ R8		
			start := workerID * chunkSize
  0x1400c5d1d		488b942450010000	MOVQ 0x150(SP), DX	
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c5d25		4c8d4a01		LEAQ 0x1(DX), R9	
  0x1400c5d29		4c0fafc8		IMULQ AX, R9		
			start := workerID * chunkSize
  0x1400c5d2d		480fafc2		IMULQ DX, AX		
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c5d31		4c39ce			CMPQ SI, R9		
  0x1400c5d34		4c0f4cce		CMOVL SI, R9		
			if sim.Measurement_mode {
  0x1400c5d38		80b9e02dba0700		CMPB 0x7ba2de0(CX), $0x0	
  0x1400c5d3f		90			NOPL				
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c5d40		743e			JE 0x1400c5d80		
				diag := &sim.WorkerIDiag[workerID]
  0x1400c5d42		488b7150		MOVQ 0x50(CX), SI	
  0x1400c5d46		4839d6			CMPQ SI, DX		
  0x1400c5d49		0f8696120000		JBE 0x1400c6fe5		
  0x1400c5d4f		488b7148		MOVQ 0x48(CX), SI	
  0x1400c5d53		4869d240320000		IMULQ $0x3240, DX, DX	
  0x1400c5d5a		488d3c16		LEAQ 0(SI)(DX*1), DI	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c5d5e		4889cb			MOVQ CX, BX		
				*diag = ionWorkerDiagnostics{}
  0x1400c5d61		b948060000		MOVL $0x648, CX		
			start := workerID * chunkSize
  0x1400c5d66		4989c2			MOVQ AX, R10		
				*diag = ionWorkerDiagnostics{}
  0x1400c5d69		31c0			XORL AX, AX		
  0x1400c5d6b		f348ab			REP; STOSQ AX, ES:0(DI)	
				if start < end {
  0x1400c5d6e		4d39d1			CMPQ R9, R10		
  0x1400c5d71		0f8f11120000		JG 0x1400c6f88		
  0x1400c5d77		e9bd100000		JMP 0x1400c6e39		
  0x1400c5d7c		0f1f4000		NOPL 0(AX)		
				if end > start {
  0x1400c5d80		4939c1			CMPQ R9, AX		
  0x1400c5d83		7e11			JLE 0x1400c5d96		
					_ = sim.X_i[end-1]
  0x1400c5d85		498d51ff		LEAQ -0x1(R9), DX	
  0x1400c5d89		4881fa40420f00		CMPQ DX, $0xf4240	
  0x1400c5d90		0f8399100000		JAE 0x1400c6e2f		
				for ; k <= end-4; k += 4 {
  0x1400c5d96		498d51fc		LEAQ -0x4(R9), DX	
  0x1400c5d9a		e9150e0000		JMP 0x1400c6bb4		
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c5d9f		488b942448010000	MOVQ 0x148(SP), DX	
  0x1400c5da7		4c8b82c07e5603		MOVQ 0x3567ec0(DX), R8	
  0x1400c5dae		4c8b8c2410010000	MOVQ 0x110(SP), R9	
  0x1400c5db6		4b8d0401		LEAQ 0(R9)(R8*1), AX	
  0x1400c5dba		488d40ff		LEAQ -0x1(AX), AX	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c5dbe		4889d1			MOVQ DX, CX		
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c5dc1		4899			CQO			
  0x1400c5dc3		49f7f9			IDIVQ R9		
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c5dc6		488b942450010000	MOVQ 0x150(SP), DX	
  0x1400c5dce		4c8d5201		LEAQ 0x1(DX), R10	
  0x1400c5dd2		4c0fafd0		IMULQ AX, R10		
			diag := &sim.WorkerEDiag[workerID]
  0x1400c5dd6		4c8b5938		MOVQ 0x38(CX), R11	
			start := workerID * chunkSize
  0x1400c5dda		480fafc2		IMULQ DX, AX		
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c5dde		4d39d0			CMPQ R8, R10		
  0x1400c5de1		4d0f4cd0		CMOVL R8, R10		
			diag := &sim.WorkerEDiag[workerID]
  0x1400c5de5		4939d3			CMPQ R11, DX		
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c5de8		0f86ce0c0000		JBE 0x1400c6abc		
			diag := &sim.WorkerEDiag[workerID]
  0x1400c5dee		4c8b4130		MOVQ 0x30(CX), R8	
  0x1400c5df2		4869d2c0700000		IMULQ $0x70c0, DX, DX	
			diag.abs_pow = 0
  0x1400c5df9		4d8d1c10		LEAQ 0(R8)(DX*1), R11	
  0x1400c5dfd		4d8d9b90700000		LEAQ 0x7090(R11), R11	
  0x1400c5e04		450f113b		MOVUPS X15, 0(R11)	
			dead := sim.WorkerDeadElectrons[workerID][:0]
  0x1400c5e08		4c8b5968		MOVQ 0x68(CX), R11		
  0x1400c5e0c		4c8ba42450010000	MOVQ 0x150(SP), R12		
  0x1400c5e14		4d39dc			CMPQ R12, R11			
  0x1400c5e17		0f839a0c0000		JAE 0x1400c6ab7			
  0x1400c5e1d		4c8b5960		MOVQ 0x60(CX), R11		
  0x1400c5e21		4f8d2464		LEAQ 0(R12)(R12*2), R12		
  0x1400c5e25		4f8b2ce3		MOVQ 0(R11)(R12*8), R13		
  0x1400c5e29		4f8b5ce310		MOVQ 0x10(R11)(R12*8), R11	
			if start < end {
  0x1400c5e2e		4939c2			CMPQ R10, AX		
  0x1400c5e31		7e20			JLE 0x1400c5e53		
			diag := &sim.WorkerEDiag[workerID]
  0x1400c5e33		4c89842428010000	MOVQ R8, 0x128(SP)	
  0x1400c5e3b		4889942408010000	MOVQ DX, 0x108(SP)	
  0x1400c5e43		4c899424f0000000	MOVQ R10, 0xf0(SP)	
				for k := start; k < end; k++ {
  0x1400c5e4b		4531e4			XORL R12, R12		
  0x1400c5e4e		e92d0b0000		JMP 0x1400c6980		
  0x1400c5e53		31c0			XORL AX, AX		
			if start < end {
  0x1400c5e55		e9b50a0000		JMP 0x1400c690f		
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x1400c5e5a		488b942448010000	MOVQ 0x148(SP), DX	
  0x1400c5e62		4c8b82c87e5603		MOVQ 0x3567ec8(DX), R8	
  0x1400c5e69		4c8b8c2410010000	MOVQ 0x110(SP), R9	
  0x1400c5e71		4b8d0401		LEAQ 0(R9)(R8*1), AX	
  0x1400c5e75		488d40ff		LEAQ -0x1(AX), AX	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c5e79		4889d1			MOVQ DX, CX		
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x1400c5e7c		4899			CQO			
  0x1400c5e7e		49f7f9			IDIVQ R9		
			start := workerID * chunkSize
  0x1400c5e81		488b942450010000	MOVQ 0x150(SP), DX	
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c5e89		4c8d5201		LEAQ 0x1(DX), R10	
  0x1400c5e8d		4c0fafd0		IMULQ AX, R10		
			diag := &sim.WorkerIDiag[workerID]
  0x1400c5e91		4c8b5950		MOVQ 0x50(CX), R11	
			start := workerID * chunkSize
  0x1400c5e95		480fafc2		IMULQ DX, AX		
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c5e99		4d39d0			CMPQ R8, R10		
  0x1400c5e9c		4d0f4cd0		CMOVL R8, R10		
			diag := &sim.WorkerIDiag[workerID]
  0x1400c5ea0		4939d3			CMPQ R11, DX		
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c5ea3		0f86610a0000		JBE 0x1400c690a		
			diag := &sim.WorkerIDiag[workerID]
  0x1400c5ea9		4c8b4148		MOVQ 0x48(CX), R8	
  0x1400c5ead		4869d240320000		IMULQ $0x3240, DX, DX	
			diag.abs_pow = 0
  0x1400c5eb4		4d8d1c10		LEAQ 0(R8)(DX*1), R11	
  0x1400c5eb8		4d8d9b80250000		LEAQ 0x2580(R11), R11	
  0x1400c5ebf		450f113b		MOVUPS X15, 0(R11)	
			for idx := range N_IFED {
  0x1400c5ec3		4531db			XORL R11, R11		
  0x1400c5ec6		e95a070000		JMP 0x1400c6625		
			sim.WorkerNewElectrons[workerID] = sim.WorkerNewElectrons[workerID][:0]
  0x1400c5ecb		488b942448010000	MOVQ 0x148(SP), DX		
  0x1400c5ed3		488bb298000000		MOVQ 0x98(DX), SI		
  0x1400c5eda		488bbc2450010000	MOVQ 0x150(SP), DI		
  0x1400c5ee2		4839f7			CMPQ DI, SI			
  0x1400c5ee5		0f830a070000		JAE 0x1400c65f5			
  0x1400c5eeb		488d347f		LEAQ 0(DI)(DI*2), SI		
  0x1400c5eef		488bba90000000		MOVQ 0x90(DX), DI		
  0x1400c5ef6		48c744f70800000000	MOVQ $0x0, 0x8(DI)(SI*8)	
			sim.WorkerNewIons[workerID] = sim.WorkerNewIons[workerID][:0]
  0x1400c5eff		488bb2b0000000		MOVQ 0xb0(DX), SI		
  0x1400c5f06		488bbc2450010000	MOVQ 0x150(SP), DI		
  0x1400c5f0e		4839f7			CMPQ DI, SI			
  0x1400c5f11		0f83d9060000		JAE 0x1400c65f0			
  0x1400c5f17		488d347f		LEAQ 0(DI)(DI*2), SI		
  0x1400c5f1b		488bbaa8000000		MOVQ 0xa8(DX), DI		
  0x1400c5f22		48c744f70800000000	MOVQ $0x0, 0x8(DI)(SI*8)	
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c5f2b		488b8ac07e5603		MOVQ 0x3567ec0(DX), CX	
  0x1400c5f32		488bb42410010000	MOVQ 0x110(SP), SI	
  0x1400c5f3a		488d0431		LEAQ 0(CX)(SI*1), AX	
  0x1400c5f3e		488d40ff		LEAQ -0x1(AX), AX	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c5f42		4889d3			MOVQ DX, BX		
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c5f45		4899			CQO			
  0x1400c5f47		48f7fe			IDIVQ SI		
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c5f4a		488b942450010000	MOVQ 0x150(SP), DX	
  0x1400c5f52		488d7a01		LEAQ 0x1(DX), DI	
  0x1400c5f56		480faff8		IMULQ AX, DI		
			start := workerID * chunkSize
  0x1400c5f5a		480fafc2		IMULQ DX, AX		
  0x1400c5f5e		6690			NOPW			
			end := min((workerID+1)*chunkSize, sim.N_e)
  0x1400c5f60		4839f9			CMPQ CX, DI		
  0x1400c5f63		7c03			JL 0x1400c5f68		
  0x1400c5f65		4889f9			MOVQ DI, CX		
			nLocal := end - start
  0x1400c5f68		4889cf			MOVQ CX, DI		
  0x1400c5f6b		4829c7			SUBQ AX, DI		
			if nLocal > 0 {
  0x1400c5f6e		4885ff			TESTQ DI, DI		
  0x1400c5f71		7f07			JG 0x1400c5f7a		
  0x1400c5f73		31c9			XORL CX, CX		
  0x1400c5f75		e93b060000		JMP 0x1400c65b5		
			start := workerID * chunkSize
  0x1400c5f7a		4889442470		MOVQ AX, 0x70(SP)	
			nLocal := end - start
  0x1400c5f7f		4889bc2490000000	MOVQ DI, 0x90(SP)	
  0x1400c5f87		48898c24e0000000	MOVQ CX, 0xe0(SP)	
				localNColl := sim.workerSampleBinomial(workerID, nLocal, sim.PStarE)
  0x1400c5f8f		f20f1083302eba07	MOVSD_XMM 0x7ba2e30(BX), X0				
  0x1400c5f97		4889d8			MOVQ BX, AX						
  0x1400c5f9a		4889d3			MOVQ DX, BX						
  0x1400c5f9d		4889f9			MOVQ DI, CX						
  0x1400c5fa0		e87be9ffff		CALL gopic.(*SimulationState).workerSampleBinomial(SB)	
					ki := start + int(sim.WorkerR01(workerID)*float64(nLocal))
  0x1400c5fa5		488b942490000000	MOVQ 0x90(SP), DX	
  0x1400c5fad		0f57c9			XORPS X1, X1		
  0x1400c5fb0		f2480f2aca		CVTSI2SDQ DX, X1	
  0x1400c5fb5		f20f118c2400010000	MOVSD_XMM X1, 0x100(SP)	
						ki = end - 1
  0x1400c5fbe		488bb424e0000000	MOVQ 0xe0(SP), SI	
  0x1400c5fc6		488d7eff		LEAQ -0x1(SI), DI	
  0x1400c5fca		4889bc24b0000000	MOVQ DI, 0xb0(SP)	
				if localNColl > nLocal {
  0x1400c5fd2		4839d0			CMPQ AX, DX		
					localNColl = nLocal
  0x1400c5fd5		480f4fc2		CMOVG DX, AX		
  0x1400c5fd9		31c9			XORL CX, CX		
  0x1400c5fdb		0f1f440000		NOPL 0(AX)(AX*1)	
				if localNColl > nLocal {
  0x1400c5fe0		e927040000		JMP 0x1400c640c		
			sim.WorkerNewIons[workerID] = sim.WorkerNewIons[workerID][:0]
  0x1400c5fe5		488b942448010000	MOVQ 0x148(SP), DX		
  0x1400c5fed		488bb2b0000000		MOVQ 0xb0(DX), SI		
  0x1400c5ff4		488bbc2450010000	MOVQ 0x150(SP), DI		
  0x1400c5ffc		0f1f4000		NOPL 0(AX)			
  0x1400c6000		4839f7			CMPQ DI, SI			
  0x1400c6003		0f83d6030000		JAE 0x1400c63df			
  0x1400c6009		488d347f		LEAQ 0(DI)(DI*2), SI		
  0x1400c600d		488bbaa8000000		MOVQ 0xa8(DX), DI		
  0x1400c6014		48c744f70800000000	MOVQ $0x0, 0x8(DI)(SI*8)	
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x1400c601d		488b8ac87e5603		MOVQ 0x3567ec8(DX), CX	
  0x1400c6024		488bb42410010000	MOVQ 0x110(SP), SI	
  0x1400c602c		488d0431		LEAQ 0(CX)(SI*1), AX	
  0x1400c6030		488d40ff		LEAQ -0x1(AX), AX	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c6034		4889d3			MOVQ DX, BX		
			chunkSize := (sim.N_i + numWorkers - 1) / numWorkers
  0x1400c6037		4899			CQO			
  0x1400c6039		48f7fe			IDIVQ SI		
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c603c		488b942450010000	MOVQ 0x150(SP), DX	
  0x1400c6044		488d7a01		LEAQ 0x1(DX), DI	
  0x1400c6048		480faff8		IMULQ AX, DI		
			start := workerID * chunkSize
  0x1400c604c		480fafc2		IMULQ DX, AX		
			end := min((workerID+1)*chunkSize, sim.N_i)
  0x1400c6050		4839f9			CMPQ CX, DI		
  0x1400c6053		7c03			JL 0x1400c6058		
  0x1400c6055		4889f9			MOVQ DI, CX		
			nLocal := end - start
  0x1400c6058		4889cf			MOVQ CX, DI		
  0x1400c605b		4829c7			SUBQ AX, DI		
  0x1400c605e		6690			NOPW			
			if nLocal > 0 {
  0x1400c6060		4885ff			TESTQ DI, DI		
  0x1400c6063		7f07			JG 0x1400c606c		
  0x1400c6065		31c9			XORL CX, CX		
  0x1400c6067		e929030000		JMP 0x1400c6395		
			start := workerID * chunkSize
  0x1400c606c		4889442468		MOVQ AX, 0x68(SP)	
			nLocal := end - start
  0x1400c6071		4889bc2488000000	MOVQ DI, 0x88(SP)	
  0x1400c6079		48898c24d8000000	MOVQ CX, 0xd8(SP)	
				localNColl := sim.workerSampleBinomial(workerID, nLocal, sim.PStarI)
  0x1400c6081		f20f1083402eba07	MOVSD_XMM 0x7ba2e40(BX), X0				
  0x1400c6089		4889d8			MOVQ BX, AX						
  0x1400c608c		4889d3			MOVQ DX, BX						
  0x1400c608f		4889f9			MOVQ DI, CX						
  0x1400c6092		e889e8ffff		CALL gopic.(*SimulationState).workerSampleBinomial(SB)	
					ki := start + int(sim.WorkerR01(workerID)*float64(nLocal))
  0x1400c6097		488b942488000000	MOVQ 0x88(SP), DX	
  0x1400c609f		0f57c9			XORPS X1, X1		
  0x1400c60a2		f2480f2aca		CVTSI2SDQ DX, X1	
  0x1400c60a7		f20f118c2400010000	MOVSD_XMM X1, 0x100(SP)	
						ki = end - 1
  0x1400c60b0		488bb424d8000000	MOVQ 0xd8(SP), SI	
  0x1400c60b8		488d7eff		LEAQ -0x1(SI), DI	
  0x1400c60bc		4889bc24a8000000	MOVQ DI, 0xa8(SP)	
				if localNColl > nLocal {
  0x1400c60c4		4839d0			CMPQ AX, DX		
					localNColl = nLocal
  0x1400c60c7		480f4fc2		CMOVG DX, AX		
  0x1400c60cb		31c9			XORL CX, CX		
				if localNColl > nLocal {
  0x1400c60cd		eb39			JMP 0x1400c6108		
			return
  0x1400c60cf		4881c438010000		ADDQ $0x138, SP		
  0x1400c60d6		5d			POPQ BP			
  0x1400c60d7		c3			RET			
}
  0x1400c60d8		4881c438010000		ADDQ $0x138, SP		
  0x1400c60df		5d			POPQ BP			
  0x1400c60e0		c3			RET			
				for i := 0; i < localNColl; i++ {
  0x1400c60e1		488b9424c8000000	MOVQ 0xc8(SP), DX	
  0x1400c60e9		48ffca			DECQ DX			
					if ki >= end {
  0x1400c60ec		488bb424d8000000	MOVQ 0xd8(SP), SI	
						ki = end - 1
  0x1400c60f4		488bbc24a8000000	MOVQ 0xa8(SP), DI	
					ki := start + int(sim.WorkerR01(workerID)*float64(nLocal))
  0x1400c60fc		f20f108c2400010000	MOVSD_XMM 0x100(SP), X1	
				for i := 0; i < localNColl; i++ {
  0x1400c6105		4889d0			MOVQ DX, AX		
  0x1400c6108		4885c0			TESTQ AX, AX		
  0x1400c610b		0f8e74020000		JLE 0x1400c6385		
  0x1400c6111		48898c2498000000	MOVQ CX, 0x98(SP)	
  0x1400c6119		48898424c8000000	MOVQ AX, 0xc8(SP)	
					ki := start + int(sim.WorkerR01(workerID)*float64(nLocal))
  0x1400c6121		488b9c2450010000	MOVQ 0x150(SP), BX				
  0x1400c6129		488b842448010000	MOVQ 0x148(SP), AX				
  0x1400c6131		e8caf8ffff		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400c6136		f20f108c2400010000	MOVSD_XMM 0x100(SP), X1				
  0x1400c613f		f20f59c1		MULSD X1, X0					
  0x1400c6143		f2480f2cc8		CVTTSD2SIQ X0, CX				
  0x1400c6148		488b542468		MOVQ 0x68(SP), DX				
  0x1400c614d		4801d1			ADDQ DX, CX					
					if ki >= end {
  0x1400c6150		488bb424d8000000	MOVQ 0xd8(SP), SI	
  0x1400c6158		4839ce			CMPQ SI, CX		
  0x1400c615b		7f08			JG 0x1400c6165		
						ki = end - 1
  0x1400c615d		488b8c24a8000000	MOVQ 0xa8(SP), CX	
					vxA := sim.WorkerRMB(workerID)
  0x1400c6165		488b9c2450010000	MOVQ 0x150(SP), BX	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400c616d		488bbc2448010000	MOVQ 0x148(SP), DI	
  0x1400c6175		4c8b87f02dba07		MOVQ 0x7ba2df0(DI), R8	
  0x1400c617c		0f1f4000		NOPL 0(AX)		
  0x1400c6180		4939d8			CMPQ R8, BX		
  0x1400c6183		0f8651020000		JBE 0x1400c63da		
						ki = end - 1
  0x1400c6189		48898c2408010000	MOVQ CX, 0x108(SP)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400c6191		488b8fe82dba07		MOVQ 0x7ba2de8(DI), CX			
  0x1400c6198		488b04d9		MOVQ 0(CX)(BX*8), AX			
  0x1400c619c		0f1f4000		NOPL 0(AX)				
  0x1400c61a0		e89b6cffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x1400c61a5		f20f5905c3ac1500	MULSD gopic.RMB_sigma(SB), X0		
					vxA := sim.WorkerRMB(workerID)
  0x1400c61ad		f20f11442460		MOVSD_XMM X0, 0x60(SP)	
					vyA := sim.WorkerRMB(workerID)
  0x1400c61b3		488b8c2450010000	MOVQ 0x150(SP), CX	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400c61bb		488b942448010000	MOVQ 0x148(SP), DX			
  0x1400c61c3		488b9af02dba07		MOVQ 0x7ba2df0(DX), BX			
  0x1400c61ca		4839cb			CMPQ BX, CX				
  0x1400c61cd		0f8602020000		JBE 0x1400c63d5				
  0x1400c61d3		488b92e82dba07		MOVQ 0x7ba2de8(DX), DX			
  0x1400c61da		488b04ca		MOVQ 0(DX)(CX*8), AX			
  0x1400c61de		6690			NOPW					
  0x1400c61e0		e85b6cffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x1400c61e5		f20f590583ac1500	MULSD gopic.RMB_sigma(SB), X0		
					vyA := sim.WorkerRMB(workerID)
  0x1400c61ed		f20f11442458		MOVSD_XMM X0, 0x58(SP)	
					vzA := sim.WorkerRMB(workerID)
  0x1400c61f3		488b8c2450010000	MOVQ 0x150(SP), CX	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400c61fb		488b942448010000	MOVQ 0x148(SP), DX			
  0x1400c6203		488b9af02dba07		MOVQ 0x7ba2df0(DX), BX			
  0x1400c620a		4839cb			CMPQ BX, CX				
  0x1400c620d		0f86bd010000		JBE 0x1400c63d0				
  0x1400c6213		488b92e82dba07		MOVQ 0x7ba2de8(DX), DX			
  0x1400c621a		488b04ca		MOVQ 0(DX)(CX*8), AX			
  0x1400c621e		6690			NOPW					
  0x1400c6220		e81b6cffff		CALL math/rand.(*Rand).NormFloat64(SB)	
  0x1400c6225		f20f590543ac1500	MULSD gopic.RMB_sigma(SB), X0		
					vzA := sim.WorkerRMB(workerID)
  0x1400c622d		f20f11442450		MOVSD_XMM X0, 0x50(SP)	
					gx := sim.Vx_i[ki] - vxA
  0x1400c6233		488b8c2408010000	MOVQ 0x108(SP), CX			
  0x1400c623b		0f1f440000		NOPL 0(AX)(AX*1)			
  0x1400c6240		4881f940420f00		CMPQ CX, $0xf4240			
  0x1400c6247		0f8379010000		JAE 0x1400c63c6				
  0x1400c624d		488b842448010000	MOVQ 0x148(SP), AX			
  0x1400c6255		f20f108cc8d0d8b805	MOVSD_XMM 0x5b8d8d0(AX)(CX*8), X1	
  0x1400c625e		f20f5c4c2460		SUBSD 0x60(SP), X1			
					gy := sim.Vy_i[ki] - vyA
  0x1400c6264		f20f1094c8d0ea3206	MOVSD_XMM 0x632ead0(AX)(CX*8), X2	
  0x1400c626d		f20f5c542458		SUBSD 0x58(SP), X2			
					gz := sim.Vz_i[ki] - vzA
  0x1400c6273		f20f109cc8d0fcac06	MOVSD_XMM 0x6acfcd0(AX)(CX*8), X3	
  0x1400c627c		f20f5cd8		SUBSD X0, X3				
					gSqr := gx*gx + gy*gy + gz*gz
  0x1400c6280		f20f59d2		MULSD X2, X2		
  0x1400c6284		c4e2f1b9d1		VFMADD231SD X1, X1, X2	
  0x1400c6289		c4e2e1b9d3		VFMADD231SD X3, X3, X2	
					eIdx := minInt(int(gSqr*FACTOR_ENERGY_I+0.5), CS_RANGES-1)
  0x1400c628e		f20f100562ff0000	MOVSD_XMM $f64.3fe0000000000000(SB), X0	
  0x1400c6296		f20f100df2fe0000	MOVSD_XMM $f64.3f1b224d182a4f02(SB), X1	
  0x1400c629e		c4e2f1b9c2		VFMADD231SD X2, X1, X0			
  0x1400c62a3		f2480f2cd0		CVTTSD2SIQ X0, DX			
					g := math.Sqrt(gSqr)
  0x1400c62a8		90			NOPL			
	if a < b {
  0x1400c62a9		4881fa3f420f00		CMPQ DX, $0xf423f	
  0x1400c62b0		7c0e			JL 0x1400c62c0		
  0x1400c62b2		ba3f420f00		MOVL $0xf423f, DX	
  0x1400c62b7		660f1f840000000000	NOPW 0(AX)(AX*1)	
					realNu := sim.SigmaTotI[eIdx] * g
  0x1400c62c0		4881fa40420f00		CMPQ DX, $0xf4240	
  0x1400c62c7		0f83ef000000		JAE 0x1400c63bc		
					eIdx := minInt(int(gSqr*FACTOR_ENERGY_I+0.5), CS_RANGES-1)
  0x1400c62cd		48899424f8000000	MOVQ DX, 0xf8(SP)	
					if sim.WorkerR01(workerID)*sim.NuStarI < realNu {
  0x1400c62d5		488b9c2450010000	MOVQ 0x150(SP), BX	
	return sqrt(x)
  0x1400c62dd		f20f51c2		SQRTSD X2, X0		
					realNu := sim.SigmaTotI[eIdx] * g
  0x1400c62e1		f20f5984d0c06cdc02	MULSD 0x2dc6cc0(AX)(DX*8), X0	
  0x1400c62ea		f20f11442478		MOVSD_XMM X0, 0x78(SP)		
					if sim.WorkerR01(workerID)*sim.NuStarI < realNu {
  0x1400c62f0		e80bf7ffff		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400c62f5		488b842448010000	MOVQ 0x148(SP), AX				
  0x1400c62fd		f20f5980382eba07	MULSD 0x7ba2e38(AX), X0				
  0x1400c6305		f20f104c2478		MOVSD_XMM 0x78(SP), X1				
  0x1400c630b		660f2ec8		UCOMISD X0, X1					
  0x1400c630f		770d			JA 0x1400c631e					
						sim.CollisionIon(&sim.Vx_i[ki], &sim.Vy_i[ki], &sim.Vz_i[ki], &vxA, &vyA, &vzA, eIdx, workerID)
  0x1400c6311		488b8c2498000000	MOVQ 0x98(SP), CX	
					if sim.WorkerR01(workerID)*sim.NuStarI < realNu {
  0x1400c6319		e9c3fdffff		JMP 0x1400c60e1		
						sim.CollisionIon(&sim.Vx_i[ki], &sim.Vy_i[ki], &sim.Vz_i[ki], &vxA, &vyA, &vzA, eIdx, workerID)
  0x1400c631e		4c8b9c2450010000	MOVQ 0x150(SP), R11				
  0x1400c6326		488b942408010000	MOVQ 0x108(SP), DX				
  0x1400c632e		488d1cd0		LEAQ 0(AX)(DX*8), BX				
  0x1400c6332		488d9bd0d8b805		LEAQ 0x5b8d8d0(BX), BX				
  0x1400c6339		488d0cd0		LEAQ 0(AX)(DX*8), CX				
  0x1400c633d		488d89d0ea3206		LEAQ 0x632ead0(CX), CX				
  0x1400c6344		488d3cd0		LEAQ 0(AX)(DX*8), DI				
  0x1400c6348		488dbfd0fcac06		LEAQ 0x6acfcd0(DI), DI				
  0x1400c634f		488d742460		LEAQ 0x60(SP), SI				
  0x1400c6354		4c8d442458		LEAQ 0x58(SP), R8				
  0x1400c6359		4c8d4c2450		LEAQ 0x50(SP), R9				
  0x1400c635e		4c8b9424f8000000	MOVQ 0xf8(SP), R10				
  0x1400c6366		e81580ffff		CALL gopic.(*SimulationState).CollisionIon(SB)	
						localIColl++
  0x1400c636b		488b8c2498000000	MOVQ 0x98(SP), CX	
  0x1400c6373		48ffc1			INCQ CX			
					ki := start + int(sim.WorkerR01(workerID)*float64(nLocal))
  0x1400c6376		488b842448010000	MOVQ 0x148(SP), AX	
  0x1400c637e		6690			NOPW			
						localIColl++
  0x1400c6380		e95cfdffff		JMP 0x1400c60e1		
				atomic.AddUint64(&sim.N_i_coll, localIColl)
  0x1400c6385		488b9c2448010000	MOVQ 0x148(SP), BX	
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c638d		488bb42410010000	MOVQ 0x110(SP), SI	
			if localIColl > 0 {
  0x1400c6395		4885c9			TESTQ CX, CX		
  0x1400c6398		7609			JBE 0x1400c63a3		
				atomic.AddUint64(&sim.N_i_coll, localIColl)
  0x1400c639a		f0480fc18b982dba07	LOCK XADDQ CX, 0x7ba2d98(BX)	
			sim.WorkerDoneChan <- workerID
  0x1400c63a3		488b83682eba07		MOVQ 0x7ba2e68(BX), AX		
  0x1400c63aa		488d9c2450010000	LEAQ 0x150(SP), BX		
  0x1400c63b2		e849a3f4ff		CALL runtime.chansend1(SB)	
  0x1400c63b7		e940f7ffff		JMP 0x1400c5afc			
					realNu := sim.SigmaTotI[eIdx] * g
  0x1400c63bc		b840420f00		MOVL $0xf4240, AX		
  0x1400c63c1		e8ba80fbff		CALL runtime.panicBounds(SB)	
					gx := sim.Vx_i[ki] - vxA
  0x1400c63c6		b840420f00		MOVL $0xf4240, AX		
  0x1400c63cb		e8b080fbff		CALL runtime.panicBounds(SB)	
	return sim.RngWorkers[workerID].NormFloat64() * RMB_sigma
  0x1400c63d0		e8ab80fbff		CALL runtime.panicBounds(SB)	
  0x1400c63d5		e8a680fbff		CALL runtime.panicBounds(SB)	
  0x1400c63da		e8a180fbff		CALL runtime.panicBounds(SB)	
			sim.WorkerNewIons[workerID] = sim.WorkerNewIons[workerID][:0]
  0x1400c63df		90			NOPL				
  0x1400c63e0		e89b80fbff		CALL runtime.panicBounds(SB)	
				for i := 0; i < localNColl; i++ {
  0x1400c63e5		488b9424d0000000	MOVQ 0xd0(SP), DX	
  0x1400c63ed		48ffca			DECQ DX			
					if ki >= end {
  0x1400c63f0		488bb424e0000000	MOVQ 0xe0(SP), SI	
						ki = end - 1
  0x1400c63f8		488bbc24b0000000	MOVQ 0xb0(SP), DI	
					ki := start + int(sim.WorkerR01(workerID)*float64(nLocal))
  0x1400c6400		f20f108c2400010000	MOVSD_XMM 0x100(SP), X1	
				for i := 0; i < localNColl; i++ {
  0x1400c6409		4889d0			MOVQ DX, AX		
  0x1400c640c		4885c0			TESTQ AX, AX		
  0x1400c640f		0f8e90010000		JLE 0x1400c65a5		
  0x1400c6415		48898c24a0000000	MOVQ CX, 0xa0(SP)	
  0x1400c641d		48898424d0000000	MOVQ AX, 0xd0(SP)	
					ki := start + int(sim.WorkerR01(workerID)*float64(nLocal))
  0x1400c6425		488b9c2450010000	MOVQ 0x150(SP), BX				
  0x1400c642d		488b842448010000	MOVQ 0x148(SP), AX				
  0x1400c6435		e8c6f5ffff		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400c643a		f20f108c2400010000	MOVSD_XMM 0x100(SP), X1				
  0x1400c6443		f20f59c1		MULSD X1, X0					
  0x1400c6447		f2480f2cc8		CVTTSD2SIQ X0, CX				
  0x1400c644c		488b542470		MOVQ 0x70(SP), DX				
  0x1400c6451		4801d1			ADDQ DX, CX					
					if ki >= end {
  0x1400c6454		488bb424e0000000	MOVQ 0xe0(SP), SI	
  0x1400c645c		0f1f4000		NOPL 0(AX)		
  0x1400c6460		4839ce			CMPQ SI, CX		
  0x1400c6463		7f08			JG 0x1400c646d		
						ki = end - 1
  0x1400c6465		488b8c24b0000000	MOVQ 0xb0(SP), CX	
					vSqr := sim.Vx_e[ki]*sim.Vx_e[ki] + sim.Vy_e[ki]*sim.Vy_e[ki] + sim.Vz_e[ki]*sim.Vz_e[ki]
  0x1400c646d		4881f940420f00		CMPQ CX, $0xf4240			
  0x1400c6474		0f836c010000		JAE 0x1400c65e6				
  0x1400c647a		488b842448010000	MOVQ 0x148(SP), AX			
  0x1400c6482		f20f1084c8d090d003	MOVSD_XMM 0x3d090d0(AX)(CX*8), X0	
  0x1400c648b		f20f59c0		MULSD X0, X0				
  0x1400c648f		f20f1094c8d0a24a04	MOVSD_XMM 0x44aa2d0(AX)(CX*8), X2	
  0x1400c6498		c4e2e9b9c2		VFMADD231SD X2, X2, X0			
  0x1400c649d		f20f1094c8d0b4c404	MOVSD_XMM 0x4c4b4d0(AX)(CX*8), X2	
  0x1400c64a6		c4e2e9b9c2		VFMADD231SD X2, X2, X0			
					eIdx := minInt(int(vSqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
  0x1400c64ab		f20f101545fd0000	MOVSD_XMM $f64.3fe0000000000000(SB), X2	
  0x1400c64b3		f20f101da5fc0000	MOVSD_XMM $f64.3e286b6a97118d9b(SB), X3	
  0x1400c64bb		c4e2f9b9d3		VFMADD231SD X3, X0, X2			
  0x1400c64c0		f2480f2cfa		CVTTSD2SIQ X2, DI			
					velocity := math.Sqrt(vSqr)
  0x1400c64c5		90			NOPL			
	if a < b {
  0x1400c64c6		4881ff3f420f00		CMPQ DI, $0xf423f	
  0x1400c64cd		7c11			JL 0x1400c64e0		
  0x1400c64cf		bf3f420f00		MOVL $0xf423f, DI	
  0x1400c64d4		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x1400c64dd		0f1f00			NOPL 0(AX)		
					realNu := sim.SigmaTotE[eIdx] * velocity
  0x1400c64e0		4881ff40420f00		CMPQ DI, $0xf4240	
  0x1400c64e7		0f83ef000000		JAE 0x1400c65dc		
						ki = end - 1
  0x1400c64ed		48898c2408010000	MOVQ CX, 0x108(SP)	
					eIdx := minInt(int(vSqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
  0x1400c64f5		48897c2448		MOVQ DI, 0x48(SP)	
					if sim.WorkerR01(workerID)*sim.NuStarE < realNu {
  0x1400c64fa		488b9c2450010000	MOVQ 0x150(SP), BX	
	return sqrt(x)
  0x1400c6502		f20f51c0		SQRTSD X0, X0		
					realNu := sim.SigmaTotE[eIdx] * velocity
  0x1400c6506		f20f5984f8c05a6202	MULSD 0x2625ac0(AX)(DI*8), X0	
  0x1400c650f		f20f11842480000000	MOVSD_XMM X0, 0x80(SP)		
					if sim.WorkerR01(workerID)*sim.NuStarE < realNu {
  0x1400c6518		e8e3f4ffff		CALL gopic.(*SimulationState).WorkerR01(SB)	
  0x1400c651d		488b842448010000	MOVQ 0x148(SP), AX				
  0x1400c6525		f20f5980282eba07	MULSD 0x7ba2e28(AX), X0				
  0x1400c652d		f20f108c2480000000	MOVSD_XMM 0x80(SP), X1				
  0x1400c6536		660f2ec8		UCOMISD X0, X1					
  0x1400c653a		770d			JA 0x1400c6549					
						sim.CollisionElectron(sim.X_e[ki], &sim.Vx_e[ki], &sim.Vy_e[ki], &sim.Vz_e[ki], eIdx, workerID)
  0x1400c653c		488b8c24a0000000	MOVQ 0xa0(SP), CX	
					if sim.WorkerR01(workerID)*sim.NuStarE < realNu {
  0x1400c6544		e99cfeffff		JMP 0x1400c63e5		
						sim.CollisionElectron(sim.X_e[ki], &sim.Vx_e[ki], &sim.Vy_e[ki], &sim.Vz_e[ki], eIdx, workerID)
  0x1400c6549		4c8b842450010000	MOVQ 0x150(SP), R8					
  0x1400c6551		488b942408010000	MOVQ 0x108(SP), DX					
  0x1400c6559		f20f1084d0d07e5603	MOVSD_XMM 0x3567ed0(AX)(DX*8), X0			
  0x1400c6562		488d1cd0		LEAQ 0(AX)(DX*8), BX					
  0x1400c6566		488d9bd090d003		LEAQ 0x3d090d0(BX), BX					
  0x1400c656d		488d0cd0		LEAQ 0(AX)(DX*8), CX					
  0x1400c6571		488d89d0a24a04		LEAQ 0x44aa2d0(CX), CX					
  0x1400c6578		488d3cd0		LEAQ 0(AX)(DX*8), DI					
  0x1400c657c		488dbfd0b4c404		LEAQ 0x4c4b4d0(DI), DI					
  0x1400c6583		488b742448		MOVQ 0x48(SP), SI					
  0x1400c6588		e8d372ffff		CALL gopic.(*SimulationState).CollisionElectron(SB)	
						localEColl++
  0x1400c658d		488b8c24a0000000	MOVQ 0xa0(SP), CX	
  0x1400c6595		48ffc1			INCQ CX			
					ki := start + int(sim.WorkerR01(workerID)*float64(nLocal))
  0x1400c6598		488b842448010000	MOVQ 0x148(SP), AX	
						localEColl++
  0x1400c65a0		e940feffff		JMP 0x1400c63e5		
				atomic.AddUint64(&sim.N_e_coll, localEColl)
  0x1400c65a5		488b9c2448010000	MOVQ 0x148(SP), BX	
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c65ad		488bb42410010000	MOVQ 0x110(SP), SI	
			if localEColl > 0 {
  0x1400c65b5		4885c9			TESTQ CX, CX		
  0x1400c65b8		7609			JBE 0x1400c65c3		
				atomic.AddUint64(&sim.N_e_coll, localEColl)
  0x1400c65ba		f0480fc18b902dba07	LOCK XADDQ CX, 0x7ba2d90(BX)	
			sim.WorkerDoneChan <- workerID
  0x1400c65c3		488b83682eba07		MOVQ 0x7ba2e68(BX), AX		
  0x1400c65ca		488d9c2450010000	LEAQ 0x150(SP), BX		
  0x1400c65d2		e829a1f4ff		CALL runtime.chansend1(SB)	
  0x1400c65d7		e920f5ffff		JMP 0x1400c5afc			
					realNu := sim.SigmaTotE[eIdx] * velocity
  0x1400c65dc		b840420f00		MOVL $0xf4240, AX		
  0x1400c65e1		e89a7efbff		CALL runtime.panicBounds(SB)	
					vSqr := sim.Vx_e[ki]*sim.Vx_e[ki] + sim.Vy_e[ki]*sim.Vy_e[ki] + sim.Vz_e[ki]*sim.Vz_e[ki]
  0x1400c65e6		b840420f00		MOVL $0xf4240, AX		
  0x1400c65eb		e8907efbff		CALL runtime.panicBounds(SB)	
			sim.WorkerNewIons[workerID] = sim.WorkerNewIons[workerID][:0]
  0x1400c65f0		e88b7efbff		CALL runtime.panicBounds(SB)	
			sim.WorkerNewElectrons[workerID] = sim.WorkerNewElectrons[workerID][:0]
  0x1400c65f5		e8867efbff		CALL runtime.panicBounds(SB)	
				diag.ifed_pow[idx] = 0
  0x1400c65fa		4e8d2402		LEAQ 0(DX)(R8*1), R12		
  0x1400c65fe		4d8da42490250000	LEAQ 0x2590(R12), R12		
  0x1400c6606		4bc704dc00000000	MOVQ $0x0, 0(R12)(R11*8)	
				diag.ifed_gnd[idx] = 0
  0x1400c660e		4e8d2402		LEAQ 0(DX)(R8*1), R12		
  0x1400c6612		4d8da424d02b0000	LEAQ 0x2bd0(R12), R12		
  0x1400c661a		4bc704dc00000000	MOVQ $0x0, 0(R12)(R11*8)	
			for idx := range N_IFED {
  0x1400c6622		49ffc3			INCQ R11		
  0x1400c6625		4981fbc8000000		CMPQ R11, $0xc8		
  0x1400c662c		7ccc			JL 0x1400c65fa		
			dead := sim.WorkerDeadIons[workerID][:0]
  0x1400c662e		4c8b9980000000		MOVQ 0x80(CX), R11		
  0x1400c6635		4c8ba42450010000	MOVQ 0x150(SP), R12		
  0x1400c663d		0f1f00			NOPL 0(AX)			
  0x1400c6640		4d39dc			CMPQ R12, R11			
  0x1400c6643		0f83bc020000		JAE 0x1400c6905			
  0x1400c6649		4c8b5978		MOVQ 0x78(CX), R11		
  0x1400c664d		4f8d2464		LEAQ 0(R12)(R12*2), R12		
  0x1400c6651		4f8b2ce3		MOVQ 0(R11)(R12*8), R13		
  0x1400c6655		4f8b5ce310		MOVQ 0x10(R11)(R12*8), R11	
			if start < end {
  0x1400c665a		4939c2			CMPQ R10, AX		
  0x1400c665d		7e1d			JLE 0x1400c667c		
			diag := &sim.WorkerIDiag[workerID]
  0x1400c665f		4c89842420010000	MOVQ R8, 0x120(SP)	
  0x1400c6667		4889942408010000	MOVQ DX, 0x108(SP)	
  0x1400c666f		4c899424e8000000	MOVQ R10, 0xe8(SP)	
				for k := start; k < end; k++ {
  0x1400c6677		4531e4			XORL R12, R12		
  0x1400c667a		eb69			JMP 0x1400c66e5		
  0x1400c667c		31c0			XORL AX, AX		
			sim.WorkerDeadIons[workerID] = dead
  0x1400c667e		488b9180000000		MOVQ 0x80(CX), DX			
  0x1400c6685		488bb42450010000	MOVQ 0x150(SP), SI			
  0x1400c668d		4839d6			CMPQ SI, DX				
  0x1400c6690		7348			JAE 0x1400c66da				
  0x1400c6692		488b5178		MOVQ 0x78(CX), DX			
  0x1400c6696		488d3476		LEAQ 0(SI)(SI*2), SI			
  0x1400c669a		488944f208		MOVQ AX, 0x8(DX)(SI*8)			
  0x1400c669f		4c895cf210		MOVQ R11, 0x10(DX)(SI*8)		
  0x1400c66a4		833d05aa150000		CMPL runtime.writeBarrier(SB), $0x0	
  0x1400c66ab		7410			JE 0x1400c66bd				
  0x1400c66ad		488b3cf2		MOVQ 0(DX)(SI*8), DI			
  0x1400c66b1		e82a7afbff		CALL runtime.gcWriteBarrier2(SB)	
  0x1400c66b6		4d892b			MOVQ R13, 0(R11)			
  0x1400c66b9		49897b08		MOVQ DI, 0x8(R11)			
  0x1400c66bd		4c892cf2		MOVQ R13, 0(DX)(SI*8)			
			sim.WorkerDoneChan <- workerID
  0x1400c66c1		488b81682eba07		MOVQ 0x7ba2e68(CX), AX		
  0x1400c66c8		488d9c2450010000	LEAQ 0x150(SP), BX		
  0x1400c66d0		e82ba0f4ff		CALL runtime.chansend1(SB)	
  0x1400c66d5		e922f4ffff		JMP 0x1400c5afc			
			sim.WorkerDeadIons[workerID] = dead
  0x1400c66da		e8a17dfbff		CALL runtime.panicBounds(SB)	
				for k := start; k < end; k++ {
  0x1400c66df		48ffc0			INCQ AX			
  0x1400c66e2		4989dc			MOVQ BX, R12		
  0x1400c66e5		4c39d0			CMPQ AX, R10		
  0x1400c66e8		0f8dec010000		JGE 0x1400c68da		
					if sim.X_i[k] < 0 {
  0x1400c66ee		483d40420f00		CMPQ AX, $0xf4240	
  0x1400c66f4		0f83ff010000		JAE 0x1400c68f9		
				for k := start; k < end; k++ {
  0x1400c66fa		48898424b8000000	MOVQ AX, 0xb8(SP)	
					if sim.X_i[k] < 0 {
  0x1400c6702		f20f1084c1d0c63e05	MOVSD_XMM 0x53ec6d0(CX)(AX*8), X0	
  0x1400c670b		0f57c9			XORPS X1, X1				
  0x1400c670e		660f2ec8		UCOMISD X0, X1				
  0x1400c6712		0f86cf000000		JBE 0x1400c67e7				
						dead = append(dead, k)
  0x1400c6718		498d5c2401		LEAQ 0x1(R12), BX		
  0x1400c671d		0f1f00			NOPL 0(AX)			
  0x1400c6720		4939db			CMPQ R11, BX			
  0x1400c6723		7350			JAE 0x1400c6775			
  0x1400c6725		4c89e8			MOVQ R13, AX			
  0x1400c6728		4c89d9			MOVQ R11, CX			
  0x1400c672b		bf01000000		MOVL $0x1, DI			
  0x1400c6730		488d35214d0f00		LEAQ type:*+94304(SB), SI	
  0x1400c6737		e8442ffbff		CALL runtime.growslice(SB)	
						diag.abs_pow++
  0x1400c673c		488b942408010000	MOVQ 0x108(SP), DX	
  0x1400c6744		4c8b842420010000	MOVQ 0x120(SP), R8	
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c674c		4c8b8c2410010000	MOVQ 0x110(SP), R9	
				for k := start; k < end; k++ {
  0x1400c6754		4c8b9424e8000000	MOVQ 0xe8(SP), R10	
  0x1400c675c		0f57c9			XORPS X1, X1		
						dead = append(dead, k)
  0x1400c675f		4989c5			MOVQ AX, R13		
  0x1400c6762		4989cb			MOVQ CX, R11		
  0x1400c6765		488b8424b8000000	MOVQ 0xb8(SP), AX	
						v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c676d		488b8c2448010000	MOVQ 0x148(SP), CX	
						dead = append(dead, k)
  0x1400c6775		498944ddf8		MOVQ AX, -0x8(R13)(BX*8)	
						diag.abs_pow++
  0x1400c677a		49ff841080250000	INCQ 0x2580(R8)(DX*1)	
						v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c6782		f20f1084c1d0d8b805	MOVSD_XMM 0x5b8d8d0(CX)(AX*8), X0	
  0x1400c678b		f20f59c0		MULSD X0, X0				
  0x1400c678f		f20f1094c1d0ea3206	MOVSD_XMM 0x632ead0(CX)(AX*8), X2	
  0x1400c6798		c4e2e9b9c2		VFMADD231SD X2, X2, X0			
  0x1400c679d		f20f1094c1d0fcac06	MOVSD_XMM 0x6acfcd0(CX)(AX*8), X2	
  0x1400c67a6		c4e2e9b9c2		VFMADD231SD X2, X2, X0			
						energy_index = int(v_sqr * FACTOR_ENERGY_IFED)
  0x1400c67ab		f20f1015bdf90000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X2	
  0x1400c67b3		f20f59c2		MULSD X2, X0				
  0x1400c67b7		f24c0f2ce0		CVTTSD2SIQ X0, R12			
  0x1400c67bc		0f1f4000		NOPL 0(AX)				
						if energy_index < N_IFED {
  0x1400c67c0		4981fcc8000000		CMPQ R12, $0xc8		
  0x1400c67c7		0f8d12ffffff		JGE 0x1400c66df		
							diag.ifed_pow[energy_index]++
  0x1400c67cd		4e8d3c02		LEAQ 0(DX)(R8*1), R15	
  0x1400c67d1		4d8dbf90250000		LEAQ 0x2590(R15), R15	
  0x1400c67d8		0f8311010000		JAE 0x1400c68ef		
  0x1400c67de		4bff04e7		INCQ 0(R15)(R12*8)	
  0x1400c67e2		e9f8feffff		JMP 0x1400c66df		
					} else if sim.X_i[k] > L {
  0x1400c67e7		f20f1015a9f80000	MOVSD_XMM runtime.egcbss+10(SB), X2	
  0x1400c67ef		660f2ec2		UCOMISD X2, X0				
  0x1400c67f3		0f86c9000000		JBE 0x1400c68c2				
						dead = append(dead, k)
  0x1400c67f9		498d5c2401		LEAQ 0x1(R12), BX		
  0x1400c67fe		6690			NOPW				
  0x1400c6800		4939db			CMPQ R11, BX			
  0x1400c6803		7358			JAE 0x1400c685d			
  0x1400c6805		4c89e8			MOVQ R13, AX			
  0x1400c6808		4c89d9			MOVQ R11, CX			
  0x1400c680b		bf01000000		MOVL $0x1, DI			
  0x1400c6810		488d35414c0f00		LEAQ type:*+94304(SB), SI	
  0x1400c6817		e8642efbff		CALL runtime.growslice(SB)	
						diag.abs_gnd++
  0x1400c681c		488b942408010000	MOVQ 0x108(SP), DX	
  0x1400c6824		4c8b842420010000	MOVQ 0x120(SP), R8	
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c682c		4c8b8c2410010000	MOVQ 0x110(SP), R9	
				for k := start; k < end; k++ {
  0x1400c6834		4c8b9424e8000000	MOVQ 0xe8(SP), R10			
  0x1400c683c		0f57c9			XORPS X1, X1				
  0x1400c683f		f20f101551f80000	MOVSD_XMM runtime.egcbss+10(SB), X2	
						dead = append(dead, k)
  0x1400c6847		4989c5			MOVQ AX, R13		
  0x1400c684a		4989cb			MOVQ CX, R11		
  0x1400c684d		488b8424b8000000	MOVQ 0xb8(SP), AX	
						v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c6855		488b8c2448010000	MOVQ 0x148(SP), CX	
						dead = append(dead, k)
  0x1400c685d		498944ddf8		MOVQ AX, -0x8(R13)(BX*8)	
						diag.abs_gnd++
  0x1400c6862		49ff841088250000	INCQ 0x2588(R8)(DX*1)	
						v_sqr = sim.Vx_i[k]*sim.Vx_i[k] + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c686a		f20f1084c1d0d8b805	MOVSD_XMM 0x5b8d8d0(CX)(AX*8), X0	
  0x1400c6873		f20f59c0		MULSD X0, X0				
  0x1400c6877		f20f109cc1d0ea3206	MOVSD_XMM 0x632ead0(CX)(AX*8), X3	
  0x1400c6880		c4e2e1b9c3		VFMADD231SD X3, X3, X0			
  0x1400c6885		f20f109cc1d0fcac06	MOVSD_XMM 0x6acfcd0(CX)(AX*8), X3	
  0x1400c688e		c4e2e1b9c3		VFMADD231SD X3, X3, X0			
						energy_index = int(v_sqr * FACTOR_ENERGY_IFED)
  0x1400c6893		f20f101dd5f80000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X3	
  0x1400c689b		f20f59c3		MULSD X3, X0				
  0x1400c689f		f24c0f2ce0		CVTTSD2SIQ X0, R12			
						if energy_index < N_IFED {
  0x1400c68a4		4981fcc8000000		CMPQ R12, $0xc8		
  0x1400c68ab		7d20			JGE 0x1400c68cd		
							diag.ifed_gnd[energy_index]++
  0x1400c68ad		4e8d3c02		LEAQ 0(DX)(R8*1), R15			
  0x1400c68b1		4d8dbfd02b0000		LEAQ 0x2bd0(R15), R15			
  0x1400c68b8		732b			JAE 0x1400c68e5				
  0x1400c68ba		4bff04e7		INCQ 0(R15)(R12*8)			
  0x1400c68be		6690			NOPW					
  0x1400c68c0		eb0b			JMP 0x1400c68cd				
  0x1400c68c2		f20f101da6f80000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X3	
  0x1400c68ca		4c89e3			MOVQ R12, BX				
  0x1400c68cd		f20f10159bf80000	MOVSD_XMM $f64.3e8bc9032b2d5f3d(SB), X2	
  0x1400c68d5		e905feffff		JMP 0x1400c66df				
  0x1400c68da		4c89e0			MOVQ R12, AX				
  0x1400c68dd		0f1f00			NOPL 0(AX)				
				for k := start; k < end; k++ {
  0x1400c68e0		e999fdffff		JMP 0x1400c667e		
							diag.ifed_gnd[energy_index]++
  0x1400c68e5		b8c8000000		MOVL $0xc8, AX			
  0x1400c68ea		e8917bfbff		CALL runtime.panicBounds(SB)	
							diag.ifed_pow[energy_index]++
  0x1400c68ef		b8c8000000		MOVL $0xc8, AX			
  0x1400c68f4		e8877bfbff		CALL runtime.panicBounds(SB)	
					if sim.X_i[k] < 0 {
  0x1400c68f9		b940420f00		MOVL $0xf4240, CX		
  0x1400c68fe		6690			NOPW				
  0x1400c6900		e87b7bfbff		CALL runtime.panicBounds(SB)	
			dead := sim.WorkerDeadIons[workerID][:0]
  0x1400c6905		e8767bfbff		CALL runtime.panicBounds(SB)	
			diag := &sim.WorkerIDiag[workerID]
  0x1400c690a		e8717bfbff		CALL runtime.panicBounds(SB)	
			sim.WorkerDeadElectrons[workerID] = dead
  0x1400c690f		488b5168		MOVQ 0x68(CX), DX			
  0x1400c6913		488bb42450010000	MOVQ 0x150(SP), SI			
  0x1400c691b		0f1f440000		NOPL 0(AX)(AX*1)			
  0x1400c6920		4839d6			CMPQ SI, DX				
  0x1400c6923		734a			JAE 0x1400c696f				
  0x1400c6925		488b5160		MOVQ 0x60(CX), DX			
  0x1400c6929		488d3476		LEAQ 0(SI)(SI*2), SI			
  0x1400c692d		488944f208		MOVQ AX, 0x8(DX)(SI*8)			
  0x1400c6932		4c895cf210		MOVQ R11, 0x10(DX)(SI*8)		
  0x1400c6937		833d72a7150000		CMPL runtime.writeBarrier(SB), $0x0	
  0x1400c693e		6690			NOPW					
  0x1400c6940		7410			JE 0x1400c6952				
  0x1400c6942		488b3cf2		MOVQ 0(DX)(SI*8), DI			
  0x1400c6946		e89577fbff		CALL runtime.gcWriteBarrier2(SB)	
  0x1400c694b		4d892b			MOVQ R13, 0(R11)			
  0x1400c694e		49897b08		MOVQ DI, 0x8(R11)			
  0x1400c6952		4c892cf2		MOVQ R13, 0(DX)(SI*8)			
			sim.WorkerDoneChan <- workerID
  0x1400c6956		488b81682eba07		MOVQ 0x7ba2e68(CX), AX		
  0x1400c695d		488d9c2450010000	LEAQ 0x150(SP), BX		
  0x1400c6965		e8969df4ff		CALL runtime.chansend1(SB)	
  0x1400c696a		e98df1ffff		JMP 0x1400c5afc			
			sim.WorkerDeadElectrons[workerID] = dead
  0x1400c696f		e80c7bfbff		CALL runtime.panicBounds(SB)	
				for k := start; k < end; k++ {
  0x1400c6974		48ffc0			INCQ AX			
  0x1400c6977		4989dc			MOVQ BX, R12		
  0x1400c697a		660f1f440000		NOPW 0(AX)(AX*1)	
  0x1400c6980		4c39d0			CMPQ AX, R10		
  0x1400c6983		0f8d1c010000		JGE 0x1400c6aa5		
					if sim.X_e[k] < 0 {
  0x1400c6989		483d40420f00		CMPQ AX, $0xf4240	
  0x1400c698f		0f8318010000		JAE 0x1400c6aad		
				for k := start; k < end; k++ {
  0x1400c6995		48898424c0000000	MOVQ AX, 0xc0(SP)	
					if sim.X_e[k] < 0 {
  0x1400c699d		f20f1084c1d07e5603	MOVSD_XMM 0x3567ed0(CX)(AX*8), X0	
  0x1400c69a6		0f57c9			XORPS X1, X1				
  0x1400c69a9		660f2ec8		UCOMISD X0, X1				
  0x1400c69ad		766c			JBE 0x1400c6a1b				
						dead = append(dead, k)
  0x1400c69af		498d5c2401		LEAQ 0x1(R12), BX		
  0x1400c69b4		4939db			CMPQ R11, BX			
  0x1400c69b7		7350			JAE 0x1400c6a09			
  0x1400c69b9		4c89e8			MOVQ R13, AX			
  0x1400c69bc		4c89d9			MOVQ R11, CX			
  0x1400c69bf		bf01000000		MOVL $0x1, DI			
  0x1400c69c4		488d358d4a0f00		LEAQ type:*+94304(SB), SI	
  0x1400c69cb		e8b02cfbff		CALL runtime.growslice(SB)	
						diag.abs_pow++
  0x1400c69d0		488b942408010000	MOVQ 0x108(SP), DX	
  0x1400c69d8		4c8b842428010000	MOVQ 0x128(SP), R8	
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c69e0		4c8b8c2410010000	MOVQ 0x110(SP), R9	
				for k := start; k < end; k++ {
  0x1400c69e8		4c8b9424f0000000	MOVQ 0xf0(SP), R10	
  0x1400c69f0		0f57c9			XORPS X1, X1		
						dead = append(dead, k)
  0x1400c69f3		4989c5			MOVQ AX, R13		
  0x1400c69f6		4989cb			MOVQ CX, R11		
  0x1400c69f9		488b8424c0000000	MOVQ 0xc0(SP), AX	
					if sim.X_e[k] < 0 {
  0x1400c6a01		488b8c2448010000	MOVQ 0x148(SP), CX	
						dead = append(dead, k)
  0x1400c6a09		498944ddf8		MOVQ AX, -0x8(R13)(BX*8)	
						diag.abs_pow++
  0x1400c6a0e		49ff841090700000	INCQ 0x7090(R8)(DX*1)	
  0x1400c6a16		e959ffffff		JMP 0x1400c6974		
					} else if sim.X_e[k] > L {
  0x1400c6a1b		f20f101575f60000	MOVSD_XMM runtime.egcbss+10(SB), X2	
  0x1400c6a23		660f2ec2		UCOMISD X2, X0				
  0x1400c6a27		7674			JBE 0x1400c6a9d				
						dead = append(dead, k)
  0x1400c6a29		498d5c2401		LEAQ 0x1(R12), BX		
  0x1400c6a2e		4939db			CMPQ R11, BX			
  0x1400c6a31		7358			JAE 0x1400c6a8b			
  0x1400c6a33		4c89e8			MOVQ R13, AX			
  0x1400c6a36		4c89d9			MOVQ R11, CX			
  0x1400c6a39		bf01000000		MOVL $0x1, DI			
  0x1400c6a3e		488d35134a0f00		LEAQ type:*+94304(SB), SI	
  0x1400c6a45		e8362cfbff		CALL runtime.growslice(SB)	
						diag.abs_gnd++
  0x1400c6a4a		488b942408010000	MOVQ 0x108(SP), DX	
  0x1400c6a52		4c8b842428010000	MOVQ 0x128(SP), R8	
			chunkSize := (sim.N_e + numWorkers - 1) / numWorkers
  0x1400c6a5a		4c8b8c2410010000	MOVQ 0x110(SP), R9	
				for k := start; k < end; k++ {
  0x1400c6a62		4c8b9424f0000000	MOVQ 0xf0(SP), R10			
  0x1400c6a6a		0f57c9			XORPS X1, X1				
  0x1400c6a6d		f20f101523f60000	MOVSD_XMM runtime.egcbss+10(SB), X2	
						dead = append(dead, k)
  0x1400c6a75		4989c5			MOVQ AX, R13		
  0x1400c6a78		4989cb			MOVQ CX, R11		
  0x1400c6a7b		488b8424c0000000	MOVQ 0xc0(SP), AX	
					if sim.X_e[k] < 0 {
  0x1400c6a83		488b8c2448010000	MOVQ 0x148(SP), CX	
						dead = append(dead, k)
  0x1400c6a8b		498944ddf8		MOVQ AX, -0x8(R13)(BX*8)	
						diag.abs_gnd++
  0x1400c6a90		49ff841098700000	INCQ 0x7098(R8)(DX*1)	
  0x1400c6a98		e9d7feffff		JMP 0x1400c6974		
  0x1400c6a9d		4c89e3			MOVQ R12, BX		
					} else if sim.X_e[k] > L {
  0x1400c6aa0		e9cffeffff		JMP 0x1400c6974		
  0x1400c6aa5		4c89e0			MOVQ R12, AX		
				for k := start; k < end; k++ {
  0x1400c6aa8		e962feffff		JMP 0x1400c690f		
					if sim.X_e[k] < 0 {
  0x1400c6aad		b940420f00		MOVL $0xf4240, CX		
  0x1400c6ab2		e8c979fbff		CALL runtime.panicBounds(SB)	
			dead := sim.WorkerDeadElectrons[workerID][:0]
  0x1400c6ab7		e8c479fbff		CALL runtime.panicBounds(SB)	
			diag := &sim.WorkerEDiag[workerID]
  0x1400c6abc		0f1f4000		NOPL 0(AX)			
  0x1400c6ac0		e8bb79fbff		CALL runtime.panicBounds(SB)	
					d3 := c0_3 - float64(p3)
  0x1400c6ac5		0f57ed			XORPS X5, X5		
  0x1400c6ac8		f2480f2aee		CVTSI2SDQ SI, X5	
  0x1400c6acd		f20f5cc5		SUBSD X5, X0		
					ex3 := sim.Efield[p3] + d3*(sim.Efield[p3+1]-sim.Efield[p3])
  0x1400c6ad1		f20f10acf1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X5	
  0x1400c6ada		f20f10b4f1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X6	
  0x1400c6ae3		f20f5cf5		SUBSD X5, X6				
  0x1400c6ae7		c4e2f9b9ee		VFMADD231SD X6, X0, X5			
					vx0 := sim.Vx_i[k] + ex0*FACTOR_I
  0x1400c6aec		f20f1005a4f60000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x1400c6af4		f20f59d0		MULSD X0, X2				
  0x1400c6af8		f20f5894c1d0d8b805	ADDSD 0x5b8d8d0(CX)(AX*8), X2		
					vx1 := sim.Vx_i[k+1] + ex1*FACTOR_I
  0x1400c6b01		f20f59d8		MULSD X0, X3			
  0x1400c6b05		f20f589cc1d8d8b805	ADDSD 0x5b8d8d8(CX)(AX*8), X3	
					vx2 := sim.Vx_i[k+2] + ex2*FACTOR_I
  0x1400c6b0e		f20f59e0		MULSD X0, X4			
  0x1400c6b12		f20f58a4c1e0d8b805	ADDSD 0x5b8d8e0(CX)(AX*8), X4	
					vx3 := sim.Vx_i[k+3] + ex3*FACTOR_I
  0x1400c6b1b		f20f59e8		MULSD X0, X5			
  0x1400c6b1f		f20f58acc1e8d8b805	ADDSD 0x5b8d8e8(CX)(AX*8), X5	
					sim.Vx_i[k] = vx0
  0x1400c6b28		f20f1194c1d0d8b805	MOVSD_XMM X2, 0x5b8d8d0(CX)(AX*8)	
					sim.Vx_i[k+1] = vx1
  0x1400c6b31		f20f119cc1d8d8b805	MOVSD_XMM X3, 0x5b8d8d8(CX)(AX*8)	
					sim.Vx_i[k+2] = vx2
  0x1400c6b3a		f20f11a4c1e0d8b805	MOVSD_XMM X4, 0x5b8d8e0(CX)(AX*8)	
					sim.Vx_i[k+3] = vx3
  0x1400c6b43		f20f11acc1e8d8b805	MOVSD_XMM X5, 0x5b8d8e8(CX)(AX*8)	
					sim.X_i[k] += vx0 * DT_I
  0x1400c6b4c		f20f10b4c1d0c63e05	MOVSD_XMM 0x53ec6d0(CX)(AX*8), X6	
  0x1400c6b55		f20f103df3f50000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X7	
  0x1400c6b5d		c4e2e9b9f7		VFMADD231SD X7, X2, X6			
  0x1400c6b62		f20f11b4c1d0c63e05	MOVSD_XMM X6, 0x53ec6d0(CX)(AX*8)	
					sim.X_i[k+1] += vx1 * DT_I
  0x1400c6b6b		f20f1094c1d8c63e05	MOVSD_XMM 0x53ec6d8(CX)(AX*8), X2	
  0x1400c6b74		c4e2e1b9d7		VFMADD231SD X7, X3, X2			
  0x1400c6b79		f20f1194c1d8c63e05	MOVSD_XMM X2, 0x53ec6d8(CX)(AX*8)	
					sim.X_i[k+2] += vx2 * DT_I
  0x1400c6b82		f20f1094c1e0c63e05	MOVSD_XMM 0x53ec6e0(CX)(AX*8), X2	
  0x1400c6b8b		c4e2d9b9d7		VFMADD231SD X7, X4, X2			
  0x1400c6b90		f20f1194c1e0c63e05	MOVSD_XMM X2, 0x53ec6e0(CX)(AX*8)	
					sim.X_i[k+3] += vx3 * DT_I
  0x1400c6b99		f20f1094c1e8c63e05	MOVSD_XMM 0x53ec6e8(CX)(AX*8), X2	
  0x1400c6ba2		c4e2d1b9d7		VFMADD231SD X7, X5, X2			
  0x1400c6ba7		f20f1194c1e8c63e05	MOVSD_XMM X2, 0x53ec6e8(CX)(AX*8)	
				for ; k <= end-4; k += 4 {
  0x1400c6bb0		4883c004		ADDQ $0x4, AX		
  0x1400c6bb4		4839d0			CMPQ AX, DX		
  0x1400c6bb7		0f8fcf010000		JG 0x1400c6d8c		
  0x1400c6bbd		0f1f00			NOPL 0(AX)		
					c0_0 := sim.X_i[k] * INV_DX
  0x1400c6bc0		483d40420f00		CMPQ AX, $0xf4240			
  0x1400c6bc6		0f8359020000		JAE 0x1400c6e25				
  0x1400c6bcc		f20f1084c1d0c63e05	MOVSD_XMM 0x53ec6d0(CX)(AX*8), X0	
  0x1400c6bd5		f20f100d23f70000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c6bdd		f20f59c1		MULSD X1, X0				
					p0 := min(max(int(c0_0), 0), N_G-2)
  0x1400c6be1		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c6be6		4885f6			TESTQ SI, SI		
  0x1400c6be9		7d02			JGE 0x1400c6bed		
  0x1400c6beb		31f6			XORL SI, SI		
  0x1400c6bed		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c6bf4		7e05			JLE 0x1400c6bfb		
  0x1400c6bf6		be8e010000		MOVL $0x18e, SI		
					d0 := c0_0 - float64(p0)
  0x1400c6bfb		0f57d2			XORPS X2, X2		
  0x1400c6bfe		f2480f2ad6		CVTSI2SDQ SI, X2	
  0x1400c6c03		f20f5cc2		SUBSD X2, X0		
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x1400c6c07		f20f1094f1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X2	
  0x1400c6c10		f20f109cf1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X3	
  0x1400c6c19		f20f5cda		SUBSD X2, X3				
					c0_1 := sim.X_i[k+1] * INV_DX
  0x1400c6c1d		488d7001		LEAQ 0x1(AX), SI	
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x1400c6c21		c4e2f9b9d3		VFMADD231SD X3, X0, X2	
					c0_1 := sim.X_i[k+1] * INV_DX
  0x1400c6c26		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c6c2d		0f83e1010000		JAE 0x1400c6e14				
  0x1400c6c33		f20f1084c1d8c63e05	MOVSD_XMM 0x53ec6d8(CX)(AX*8), X0	
  0x1400c6c3c		f20f59c1		MULSD X1, X0				
					p1 := min(max(int(c0_1), 0), N_G-2)
  0x1400c6c40		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c6c45		4885f6			TESTQ SI, SI		
  0x1400c6c48		7d02			JGE 0x1400c6c4c		
  0x1400c6c4a		31f6			XORL SI, SI		
  0x1400c6c4c		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c6c53		7e05			JLE 0x1400c6c5a		
  0x1400c6c55		be8e010000		MOVL $0x18e, SI		
					d1 := c0_1 - float64(p1)
  0x1400c6c5a		0f57db			XORPS X3, X3		
  0x1400c6c5d		f2480f2ade		CVTSI2SDQ SI, X3	
  0x1400c6c62		f20f5cc3		SUBSD X3, X0		
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x1400c6c66		f20f109cf1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X3	
  0x1400c6c6f		f20f10a4f1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X4	
  0x1400c6c78		f20f5ce3		SUBSD X3, X4				
					c0_2 := sim.X_i[k+2] * INV_DX
  0x1400c6c7c		488d7002		LEAQ 0x2(AX), SI	
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x1400c6c80		c4e2f9b9dc		VFMADD231SD X4, X0, X3	
					c0_2 := sim.X_i[k+2] * INV_DX
  0x1400c6c85		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c6c8c		0f8373010000		JAE 0x1400c6e05				
  0x1400c6c92		f20f1084c1e0c63e05	MOVSD_XMM 0x53ec6e0(CX)(AX*8), X0	
  0x1400c6c9b		f20f59c1		MULSD X1, X0				
					p2 := min(max(int(c0_2), 0), N_G-2)
  0x1400c6c9f		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c6ca4		4885f6			TESTQ SI, SI		
  0x1400c6ca7		7d02			JGE 0x1400c6cab		
  0x1400c6ca9		31f6			XORL SI, SI		
  0x1400c6cab		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c6cb2		7e05			JLE 0x1400c6cb9		
  0x1400c6cb4		be8e010000		MOVL $0x18e, SI		
					d2 := c0_2 - float64(p2)
  0x1400c6cb9		0f57e4			XORPS X4, X4		
  0x1400c6cbc		f2480f2ae6		CVTSI2SDQ SI, X4	
  0x1400c6cc1		f20f5cc4		SUBSD X4, X0		
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x1400c6cc5		f20f10a4f1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X4	
  0x1400c6cce		f20f10acf1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X5	
  0x1400c6cd7		f20f5cec		SUBSD X4, X5				
					c0_3 := sim.X_i[k+3] * INV_DX
  0x1400c6cdb		488d7003		LEAQ 0x3(AX), SI	
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x1400c6cdf		c4e2f9b9e5		VFMADD231SD X5, X0, X4	
					c0_3 := sim.X_i[k+3] * INV_DX
  0x1400c6ce4		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c6ceb		0f8309010000		JAE 0x1400c6dfa				
  0x1400c6cf1		f20f1084c1e8c63e05	MOVSD_XMM 0x53ec6e8(CX)(AX*8), X0	
  0x1400c6cfa		f20f59c1		MULSD X1, X0				
					p3 := min(max(int(c0_3), 0), N_G-2)
  0x1400c6cfe		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c6d03		4885f6			TESTQ SI, SI		
  0x1400c6d06		7d02			JGE 0x1400c6d0a		
  0x1400c6d08		31f6			XORL SI, SI		
  0x1400c6d0a		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c6d11		0f8eaefdffff		JLE 0x1400c6ac5		
  0x1400c6d17		be8e010000		MOVL $0x18e, SI		
  0x1400c6d1c		0f1f4000		NOPL 0(AX)		
  0x1400c6d20		e9a0fdffff		JMP 0x1400c6ac5		
					d := c0 - float64(p)
  0x1400c6d25		0f57d2			XORPS X2, X2		
  0x1400c6d28		f2480f2ad2		CVTSI2SDQ DX, X2	
  0x1400c6d2d		f20f5cc2		SUBSD X2, X0		
					ex := sim.Efield[p] + d*(sim.Efield[p+1]-sim.Efield[p])
  0x1400c6d31		f20f1094d1d00e2707	MOVSD_XMM 0x7270ed0(CX)(DX*8), X2	
  0x1400c6d3a		f20f109cd1d80e2707	MOVSD_XMM 0x7270ed8(CX)(DX*8), X3	
  0x1400c6d43		f20f5cda		SUBSD X2, X3				
  0x1400c6d47		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
					sim.Vx_i[k] += ex * FACTOR_I
  0x1400c6d4c		f20f100544f40000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X0	
  0x1400c6d54		f20f59d0		MULSD X0, X2				
  0x1400c6d58		f20f5894c1d0d8b805	ADDSD 0x5b8d8d0(CX)(AX*8), X2		
  0x1400c6d61		f20f1194c1d0d8b805	MOVSD_XMM X2, 0x5b8d8d0(CX)(AX*8)	
					sim.X_i[k] += sim.Vx_i[k] * DT_I
  0x1400c6d6a		f20f109cc1d0c63e05	MOVSD_XMM 0x53ec6d0(CX)(AX*8), X3	
  0x1400c6d73		f20f1025d5f30000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X4	
  0x1400c6d7b		c4e2e9b9dc		VFMADD231SD X4, X2, X3			
  0x1400c6d80		f20f119cc1d0c63e05	MOVSD_XMM X3, 0x53ec6d0(CX)(AX*8)	
				for ; k < end; k++ {
  0x1400c6d89		48ffc0			INCQ AX			
  0x1400c6d8c		4c39c8			CMPQ AX, R9		
  0x1400c6d8f		7d46			JGE 0x1400c6dd7		
					c0 := sim.X_i[k] * INV_DX
  0x1400c6d91		483d40420f00		CMPQ AX, $0xf4240			
  0x1400c6d97		7357			JAE 0x1400c6df0				
  0x1400c6d99		f20f1084c1d0c63e05	MOVSD_XMM 0x53ec6d0(CX)(AX*8), X0	
  0x1400c6da2		f20f100d56f50000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c6daa		f20f59c1		MULSD X1, X0				
					p := min(max(int(c0), 0), N_G-2)
  0x1400c6dae		f2480f2cd0		CVTTSD2SIQ X0, DX	
  0x1400c6db3		4885d2			TESTQ DX, DX		
  0x1400c6db6		7d08			JGE 0x1400c6dc0		
  0x1400c6db8		31d2			XORL DX, DX		
  0x1400c6dba		660f1f440000		NOPW 0(AX)(AX*1)	
  0x1400c6dc0		4881fa8e010000		CMPQ DX, $0x18e		
  0x1400c6dc7		0f8e58ffffff		JLE 0x1400c6d25		
  0x1400c6dcd		ba8e010000		MOVL $0x18e, DX		
  0x1400c6dd2		e94effffff		JMP 0x1400c6d25		
			sim.WorkerDoneChan <- workerID
  0x1400c6dd7		488b81682eba07		MOVQ 0x7ba2e68(CX), AX		
  0x1400c6dde		488d9c2450010000	LEAQ 0x150(SP), BX		
  0x1400c6de6		e81599f4ff		CALL runtime.chansend1(SB)	
  0x1400c6deb		e90cedffff		JMP 0x1400c5afc			
					c0 := sim.X_i[k] * INV_DX
  0x1400c6df0		b940420f00		MOVL $0xf4240, CX		
  0x1400c6df5		e88676fbff		CALL runtime.panicBounds(SB)	
					c0_3 := sim.X_i[k+3] * INV_DX
  0x1400c6dfa		b840420f00		MOVL $0xf4240, AX		
  0x1400c6dff		90			NOPL				
  0x1400c6e00		e87b76fbff		CALL runtime.panicBounds(SB)	
					c0_2 := sim.X_i[k+2] * INV_DX
  0x1400c6e05		b840420f00		MOVL $0xf4240, AX		
  0x1400c6e0a		b940420f00		MOVL $0xf4240, CX		
  0x1400c6e0f		e86c76fbff		CALL runtime.panicBounds(SB)	
					c0_1 := sim.X_i[k+1] * INV_DX
  0x1400c6e14		b840420f00		MOVL $0xf4240, AX		
  0x1400c6e19		b940420f00		MOVL $0xf4240, CX		
  0x1400c6e1e		6690			NOPW				
  0x1400c6e20		e85b76fbff		CALL runtime.panicBounds(SB)	
					c0_0 := sim.X_i[k] * INV_DX
  0x1400c6e25		b940420f00		MOVL $0xf4240, CX		
  0x1400c6e2a		e85176fbff		CALL runtime.panicBounds(SB)	
					_ = sim.X_i[end-1]
  0x1400c6e2f		b840420f00		MOVL $0xf4240, AX		
  0x1400c6e34		e84776fbff		CALL runtime.panicBounds(SB)	
			sim.WorkerDoneChan <- workerID
  0x1400c6e39		4889d9			MOVQ BX, CX		
  0x1400c6e3c		eb99			JMP 0x1400c6dd7		
						c1 = float64(p) + 1.0 - c0
  0x1400c6e3e		0f57d2			XORPS X2, X2				
  0x1400c6e41		f2480f2ad1		CVTSI2SDQ CX, X2			
  0x1400c6e46		f20f101dc2f30000	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x1400c6e4e		f20f58da		ADDSD X2, X3				
  0x1400c6e52		f20f5cd8		SUBSD X0, X3				
						c2 = c0 - float64(p)
  0x1400c6e56		f20f5cc2		SUBSD X2, X0		
						e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]
  0x1400c6e5a		f20f1094cbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X2	
  0x1400c6e63		f20f59d3		MULSD X3, X2				
  0x1400c6e67		f20f10a4cbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X4	
  0x1400c6e70		c4e2f9b9d4		VFMADD231SD X4, X0, X2			
						mean_v = sim.Vx_i[k] + 0.5*e_x*FACTOR_I
  0x1400c6e75		f20f10257bf30000	MOVSD_XMM $f64.3fe0000000000000(SB), X4	
  0x1400c6e7d		f20f59e2		MULSD X2, X4				
  0x1400c6e81		f20f102d0ff30000	MOVSD_XMM $f64.3f4d2eca209e14e0(SB), X5	
  0x1400c6e89		f20f59e5		MULSD X5, X4				
  0x1400c6e8d		f2420f58a4d3d0d8b805	ADDSD 0x5b8d8d0(BX)(R10*8), X4		
						diag.counter_i[p] += c1
  0x1400c6e97		488d3c32		LEAQ 0(DX)(SI*1), DI		
  0x1400c6e9b		f20f1034cf		MOVSD_XMM 0(DI)(CX*8), X6	
  0x1400c6ea0		f20f58f3		ADDSD X3, X6			
  0x1400c6ea4		f20f1134cf		MOVSD_XMM X6, 0(DI)(CX*8)	
						diag.counter_i[p+1] += c2
  0x1400c6ea9		f20f1074cf08		MOVSD_XMM 0x8(DI)(CX*8), X6	
  0x1400c6eaf		f20f58f0		ADDSD X0, X6			
  0x1400c6eb3		f20f1174cf08		MOVSD_XMM X6, 0x8(DI)(CX*8)	
						diag.ui[p] += c1 * mean_v
  0x1400c6eb9		488d3c32		LEAQ 0(DX)(SI*1), DI		
  0x1400c6ebd		488dbf800c0000		LEAQ 0xc80(DI), DI		
  0x1400c6ec4		f20f1034cf		MOVSD_XMM 0(DI)(CX*8), X6	
  0x1400c6ec9		c4e2d9b9f3		VFMADD231SD X3, X4, X6		
  0x1400c6ece		f20f1134cf		MOVSD_XMM X6, 0(DI)(CX*8)	
						diag.ui[p+1] += c2 * mean_v
  0x1400c6ed3		f20f1074cf08		MOVSD_XMM 0x8(DI)(CX*8), X6	
  0x1400c6ed9		c4e2d9b9f0		VFMADD231SD X0, X4, X6		
  0x1400c6ede		f20f1174cf08		MOVSD_XMM X6, 0x8(DI)(CX*8)	
						v_sqr = mean_v*mean_v + sim.Vy_i[k]*sim.Vy_i[k] + sim.Vz_i[k]*sim.Vz_i[k]
  0x1400c6ee4		f20f59e4		MULSD X4, X4				
  0x1400c6ee8		f2420f10b4d3d0ea3206	MOVSD_XMM 0x632ead0(BX)(R10*8), X6	
  0x1400c6ef2		c4e2c9b9e6		VFMADD231SD X6, X6, X4			
  0x1400c6ef7		f2420f10b4d3d0fcac06	MOVSD_XMM 0x6acfcd0(BX)(R10*8), X6	
  0x1400c6f01		c4e2c9b9e6		VFMADD231SD X6, X6, X4			
						energy = 0.5 * AR_MASS * v_sqr * INV_EV_TO_J
  0x1400c6f06		f20f1035eaf10000	MOVSD_XMM $f64.3aa4879de14d0b24(SB), X6	
  0x1400c6f0e		f20f59e6		MULSD X6, X4				
  0x1400c6f12		f20f103d16f40000	MOVSD_XMM $f64.43d5a792def818e8(SB), X7	
  0x1400c6f1a		f20f59e7		MULSD X7, X4				
						diag.meanei[p] += c1 * energy
  0x1400c6f1e		488d3c32		LEAQ 0(DX)(SI*1), DI		
  0x1400c6f22		488dbf00190000		LEAQ 0x1900(DI), DI		
  0x1400c6f29		f2440f1004cf		MOVSD_XMM 0(DI)(CX*8), X8	
  0x1400c6f2f		c462d9b9c3		VFMADD231SD X3, X4, X8		
  0x1400c6f34		f2440f1104cf		MOVSD_XMM X8, 0(DI)(CX*8)	
						diag.meanei[p+1] += c2 * energy
  0x1400c6f3a		f20f105ccf08		MOVSD_XMM 0x8(DI)(CX*8), X3	
  0x1400c6f40		c4e2d9b9d8		VFMADD231SD X0, X4, X3		
  0x1400c6f45		f20f115ccf08		MOVSD_XMM X3, 0x8(DI)(CX*8)	
						sim.Vx_i[k] += e_x * FACTOR_I
  0x1400c6f4b		f2420f1084d3d0d8b805	MOVSD_XMM 0x5b8d8d0(BX)(R10*8), X0	
  0x1400c6f55		c4e2d1b9c2		VFMADD231SD X2, X5, X0			
  0x1400c6f5a		f2420f1184d3d0d8b805	MOVSD_XMM X0, 0x5b8d8d0(BX)(R10*8)	
						sim.X_i[k] += sim.Vx_i[k] * DT_I
  0x1400c6f64		f2420f1094d3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R10*8), X2	
  0x1400c6f6e		f20f101ddaf10000	MOVSD_XMM $f64.3df956cb54e575e2(SB), X3	
  0x1400c6f76		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
  0x1400c6f7b		f2420f1194d3d0c63e05	MOVSD_XMM X2, 0x53ec6d0(BX)(R10*8)	
					for k := start; k < end; k++ {
  0x1400c6f85		49ffc2			INCQ R10		
  0x1400c6f88		4d39ca			CMPQ R10, R9		
  0x1400c6f8b		0f8da8feffff		JGE 0x1400c6e39		
						c0 = sim.X_i[k] * INV_DX
  0x1400c6f91		4981fa40420f00		CMPQ R10, $0xf4240			
  0x1400c6f98		733d			JAE 0x1400c6fd7				
  0x1400c6f9a		f2420f1084d3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R10*8), X0	
  0x1400c6fa4		f20f100d54f30000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c6fac		f20f59c1		MULSD X1, X0				
						p = min(max(int(c0), 0), N_G-2)
  0x1400c6fb0		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x1400c6fb5		4885c9			TESTQ CX, CX		
  0x1400c6fb8		7d06			JGE 0x1400c6fc0		
  0x1400c6fba		31c9			XORL CX, CX		
  0x1400c6fbc		0f1f4000		NOPL 0(AX)		
  0x1400c6fc0		4881f98e010000		CMPQ CX, $0x18e		
  0x1400c6fc7		0f8e71feffff		JLE 0x1400c6e3e		
  0x1400c6fcd		b98e010000		MOVL $0x18e, CX		
  0x1400c6fd2		e967feffff		JMP 0x1400c6e3e		
						c0 = sim.X_i[k] * INV_DX
  0x1400c6fd7		b840420f00		MOVL $0xf4240, AX		
  0x1400c6fdc		0f1f4000		NOPL 0(AX)			
  0x1400c6fe0		e89b74fbff		CALL runtime.panicBounds(SB)	
				diag := &sim.WorkerIDiag[workerID]
  0x1400c6fe5		e89674fbff		CALL runtime.panicBounds(SB)	
					d3 := c0_3 - float64(p3)
  0x1400c6fea		0f57ed			XORPS X5, X5		
  0x1400c6fed		f2480f2aee		CVTSI2SDQ SI, X5	
  0x1400c6ff2		f20f5cc5		SUBSD X5, X0		
					ex3 := sim.Efield[p3] + d3*(sim.Efield[p3+1]-sim.Efield[p3])
  0x1400c6ff6		f20f10acf1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X5	
  0x1400c6fff		f20f10b4f1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X6	
  0x1400c7008		f20f5cf5		SUBSD X5, X6				
  0x1400c700c		c4e2f9b9ee		VFMADD231SD X6, X0, X5			
					vx0 := sim.Vx_e[k] - ex0*FACTOR_E
  0x1400c7011		f20f1084c1d090d003	MOVSD_XMM 0x3d090d0(CX)(AX*8), X0	
  0x1400c701a		f20f103536f20000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x1400c7022		f20f59d6		MULSD X6, X2				
  0x1400c7026		f20f5cc2		SUBSD X2, X0				
					vx1 := sim.Vx_e[k+1] - ex1*FACTOR_E
  0x1400c702a		f20f1094c1d890d003	MOVSD_XMM 0x3d090d8(CX)(AX*8), X2	
  0x1400c7033		f20f59de		MULSD X6, X3				
  0x1400c7037		f20f5cd3		SUBSD X3, X2				
					vx2 := sim.Vx_e[k+2] - ex2*FACTOR_E
  0x1400c703b		f20f109cc1e090d003	MOVSD_XMM 0x3d090e0(CX)(AX*8), X3	
  0x1400c7044		f20f59e6		MULSD X6, X4				
  0x1400c7048		f20f5cdc		SUBSD X4, X3				
					vx3 := sim.Vx_e[k+3] - ex3*FACTOR_E
  0x1400c704c		f20f10a4c1e890d003	MOVSD_XMM 0x3d090e8(CX)(AX*8), X4	
					sim.Vx_e[k] = vx0
  0x1400c7055		f20f1184c1d090d003	MOVSD_XMM X0, 0x3d090d0(CX)(AX*8)	
					sim.Vx_e[k+1] = vx1
  0x1400c705e		f20f1194c1d890d003	MOVSD_XMM X2, 0x3d090d8(CX)(AX*8)	
					sim.Vx_e[k+2] = vx2
  0x1400c7067		f20f119cc1e090d003	MOVSD_XMM X3, 0x3d090e0(CX)(AX*8)	
					vx3 := sim.Vx_e[k+3] - ex3*FACTOR_E
  0x1400c7070		f20f59ee		MULSD X6, X5		
  0x1400c7074		f20f5ce5		SUBSD X5, X4		
					sim.Vx_e[k+3] = vx3
  0x1400c7078		f20f11a4c1e890d003	MOVSD_XMM X4, 0x3d090e8(CX)(AX*8)	
					sim.X_e[k] += vx0 * DT_E
  0x1400c7081		f20f10acc1d07e5603	MOVSD_XMM 0x3567ed0(CX)(AX*8), X5	
  0x1400c708a		f20f103db6f00000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X7	
  0x1400c7092		c4e2f9b9ef		VFMADD231SD X7, X0, X5			
  0x1400c7097		f20f11acc1d07e5603	MOVSD_XMM X5, 0x3567ed0(CX)(AX*8)	
					sim.X_e[k+1] += vx1 * DT_E
  0x1400c70a0		f20f1084c1d87e5603	MOVSD_XMM 0x3567ed8(CX)(AX*8), X0	
  0x1400c70a9		c4e2e9b9c7		VFMADD231SD X7, X2, X0			
  0x1400c70ae		f20f1184c1d87e5603	MOVSD_XMM X0, 0x3567ed8(CX)(AX*8)	
					sim.X_e[k+2] += vx2 * DT_E
  0x1400c70b7		f20f1084c1e07e5603	MOVSD_XMM 0x3567ee0(CX)(AX*8), X0	
  0x1400c70c0		c4e2e1b9c7		VFMADD231SD X7, X3, X0			
  0x1400c70c5		f20f1184c1e07e5603	MOVSD_XMM X0, 0x3567ee0(CX)(AX*8)	
					sim.X_e[k+3] += vx3 * DT_E
  0x1400c70ce		f20f1084c1e87e5603	MOVSD_XMM 0x3567ee8(CX)(AX*8), X0	
  0x1400c70d7		c4e2d9b9c7		VFMADD231SD X7, X4, X0			
  0x1400c70dc		f20f1184c1e87e5603	MOVSD_XMM X0, 0x3567ee8(CX)(AX*8)	
				for ; k <= end-4; k += 4 {
  0x1400c70e5		4883c004		ADDQ $0x4, AX		
  0x1400c70e9		4839d0			CMPQ AX, DX		
  0x1400c70ec		0f8fd7010000		JG 0x1400c72c9		
					c0_0 := sim.X_e[k] * INV_DX
  0x1400c70f2		483d40420f00		CMPQ AX, $0xf4240			
  0x1400c70f8		0f8367020000		JAE 0x1400c7365				
  0x1400c70fe		f20f1084c1d07e5603	MOVSD_XMM 0x3567ed0(CX)(AX*8), X0	
  0x1400c7107		f20f100df1f10000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c710f		f20f59c1		MULSD X1, X0				
					p0 := min(max(int(c0_0), 0), N_G-2)
  0x1400c7113		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c7118		4885f6			TESTQ SI, SI		
  0x1400c711b		7d03			JGE 0x1400c7120		
  0x1400c711d		31f6			XORL SI, SI		
  0x1400c711f		90			NOPL			
  0x1400c7120		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c7127		7e05			JLE 0x1400c712e		
  0x1400c7129		be8e010000		MOVL $0x18e, SI		
					d0 := c0_0 - float64(p0)
  0x1400c712e		0f57d2			XORPS X2, X2		
  0x1400c7131		f2480f2ad6		CVTSI2SDQ SI, X2	
  0x1400c7136		f20f5cc2		SUBSD X2, X0		
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x1400c713a		f20f1094f1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X2	
  0x1400c7143		f20f109cf1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X3	
  0x1400c714c		f20f5cda		SUBSD X2, X3				
					c0_1 := sim.X_e[k+1] * INV_DX
  0x1400c7150		488d7001		LEAQ 0x1(AX), SI	
					ex0 := sim.Efield[p0] + d0*(sim.Efield[p0+1]-sim.Efield[p0])
  0x1400c7154		c4e2f9b9d3		VFMADD231SD X3, X0, X2	
  0x1400c7159		0f1f8000000000		NOPL 0(AX)		
					c0_1 := sim.X_e[k+1] * INV_DX
  0x1400c7160		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c7167		0f83e7010000		JAE 0x1400c7354				
  0x1400c716d		f20f1084c1d87e5603	MOVSD_XMM 0x3567ed8(CX)(AX*8), X0	
  0x1400c7176		f20f59c1		MULSD X1, X0				
					p1 := min(max(int(c0_1), 0), N_G-2)
  0x1400c717a		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c717f		90			NOPL			
  0x1400c7180		4885f6			TESTQ SI, SI		
  0x1400c7183		7d02			JGE 0x1400c7187		
  0x1400c7185		31f6			XORL SI, SI		
  0x1400c7187		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c718e		7e05			JLE 0x1400c7195		
  0x1400c7190		be8e010000		MOVL $0x18e, SI		
					d1 := c0_1 - float64(p1)
  0x1400c7195		0f57db			XORPS X3, X3		
  0x1400c7198		f2480f2ade		CVTSI2SDQ SI, X3	
  0x1400c719d		f20f5cc3		SUBSD X3, X0		
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x1400c71a1		f20f109cf1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X3	
  0x1400c71aa		f20f10a4f1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X4	
  0x1400c71b3		f20f5ce3		SUBSD X3, X4				
					c0_2 := sim.X_e[k+2] * INV_DX
  0x1400c71b7		488d7002		LEAQ 0x2(AX), SI	
					ex1 := sim.Efield[p1] + d1*(sim.Efield[p1+1]-sim.Efield[p1])
  0x1400c71bb		c4e2f9b9dc		VFMADD231SD X4, X0, X3	
					c0_2 := sim.X_e[k+2] * INV_DX
  0x1400c71c0		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c71c7		0f8378010000		JAE 0x1400c7345				
  0x1400c71cd		f20f1084c1e07e5603	MOVSD_XMM 0x3567ee0(CX)(AX*8), X0	
  0x1400c71d6		f20f59c1		MULSD X1, X0				
					p2 := min(max(int(c0_2), 0), N_G-2)
  0x1400c71da		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c71df		90			NOPL			
  0x1400c71e0		4885f6			TESTQ SI, SI		
  0x1400c71e3		7d02			JGE 0x1400c71e7		
  0x1400c71e5		31f6			XORL SI, SI		
  0x1400c71e7		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c71ee		7e05			JLE 0x1400c71f5		
  0x1400c71f0		be8e010000		MOVL $0x18e, SI		
					d2 := c0_2 - float64(p2)
  0x1400c71f5		0f57e4			XORPS X4, X4		
  0x1400c71f8		f2480f2ae6		CVTSI2SDQ SI, X4	
  0x1400c71fd		f20f5cc4		SUBSD X4, X0		
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x1400c7201		f20f10a4f1d00e2707	MOVSD_XMM 0x7270ed0(CX)(SI*8), X4	
  0x1400c720a		f20f10acf1d80e2707	MOVSD_XMM 0x7270ed8(CX)(SI*8), X5	
  0x1400c7213		f20f5cec		SUBSD X4, X5				
					c0_3 := sim.X_e[k+3] * INV_DX
  0x1400c7217		488d7003		LEAQ 0x3(AX), SI	
					ex2 := sim.Efield[p2] + d2*(sim.Efield[p2+1]-sim.Efield[p2])
  0x1400c721b		c4e2f9b9e5		VFMADD231SD X5, X0, X4	
					c0_3 := sim.X_e[k+3] * INV_DX
  0x1400c7220		4881fe40420f00		CMPQ SI, $0xf4240			
  0x1400c7227		0f830d010000		JAE 0x1400c733a				
  0x1400c722d		f20f1084c1e87e5603	MOVSD_XMM 0x3567ee8(CX)(AX*8), X0	
  0x1400c7236		f20f59c1		MULSD X1, X0				
					p3 := min(max(int(c0_3), 0), N_G-2)
  0x1400c723a		f2480f2cf0		CVTTSD2SIQ X0, SI	
  0x1400c723f		90			NOPL			
  0x1400c7240		4885f6			TESTQ SI, SI		
  0x1400c7243		7d02			JGE 0x1400c7247		
  0x1400c7245		31f6			XORL SI, SI		
  0x1400c7247		4881fe8e010000		CMPQ SI, $0x18e		
  0x1400c724e		0f8e96fdffff		JLE 0x1400c6fea		
  0x1400c7254		be8e010000		MOVL $0x18e, SI		
  0x1400c7259		e98cfdffff		JMP 0x1400c6fea		
					d := c0 - float64(p)
  0x1400c725e		0f57d2			XORPS X2, X2		
  0x1400c7261		f2480f2ad2		CVTSI2SDQ DX, X2	
  0x1400c7266		f20f5cc2		SUBSD X2, X0		
					ex := sim.Efield[p] + d*(sim.Efield[p+1]-sim.Efield[p])
  0x1400c726a		f20f1094d1d00e2707	MOVSD_XMM 0x7270ed0(CX)(DX*8), X2	
  0x1400c7273		f20f109cd1d80e2707	MOVSD_XMM 0x7270ed8(CX)(DX*8), X3	
  0x1400c727c		f20f5cda		SUBSD X2, X3				
  0x1400c7280		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
					sim.Vx_e[k] -= ex * FACTOR_E
  0x1400c7285		f20f1084c1d090d003	MOVSD_XMM 0x3d090d0(CX)(AX*8), X0	
  0x1400c728e		f20f101dc2ef0000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X3	
  0x1400c7296		f20f59d3		MULSD X3, X2				
  0x1400c729a		f20f5cc2		SUBSD X2, X0				
  0x1400c729e		f20f1184c1d090d003	MOVSD_XMM X0, 0x3d090d0(CX)(AX*8)	
					sim.X_e[k] += sim.Vx_e[k] * DT_E
  0x1400c72a7		f20f1094c1d07e5603	MOVSD_XMM 0x3567ed0(CX)(AX*8), X2	
  0x1400c72b0		f20f102590ee0000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X4	
  0x1400c72b8		c4e2f9b9d4		VFMADD231SD X4, X0, X2			
  0x1400c72bd		f20f1194c1d07e5603	MOVSD_XMM X2, 0x3567ed0(CX)(AX*8)	
				for ; k < end; k++ {
  0x1400c72c6		48ffc0			INCQ AX			
  0x1400c72c9		4c39c8			CMPQ AX, R9		
  0x1400c72cc		7d49			JGE 0x1400c7317		
					c0 := sim.X_e[k] * INV_DX
  0x1400c72ce		483d40420f00		CMPQ AX, $0xf4240			
  0x1400c72d4		735a			JAE 0x1400c7330				
  0x1400c72d6		f20f1084c1d07e5603	MOVSD_XMM 0x3567ed0(CX)(AX*8), X0	
  0x1400c72df		f20f100d19f00000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c72e7		f20f59c1		MULSD X1, X0				
					p := min(max(int(c0), 0), N_G-2)
  0x1400c72eb		f2480f2cd0		CVTTSD2SIQ X0, DX	
  0x1400c72f0		4885d2			TESTQ DX, DX		
  0x1400c72f3		7d0b			JGE 0x1400c7300		
  0x1400c72f5		31d2			XORL DX, DX		
  0x1400c72f7		660f1f840000000000	NOPW 0(AX)(AX*1)	
  0x1400c7300		4881fa8e010000		CMPQ DX, $0x18e		
  0x1400c7307		0f8e51ffffff		JLE 0x1400c725e		
  0x1400c730d		ba8e010000		MOVL $0x18e, DX		
  0x1400c7312		e947ffffff		JMP 0x1400c725e		
			sim.WorkerDoneChan <- workerID
  0x1400c7317		488b81682eba07		MOVQ 0x7ba2e68(CX), AX		
  0x1400c731e		488d9c2450010000	LEAQ 0x150(SP), BX		
  0x1400c7326		e8d593f4ff		CALL runtime.chansend1(SB)	
  0x1400c732b		e9cce7ffff		JMP 0x1400c5afc			
					c0 := sim.X_e[k] * INV_DX
  0x1400c7330		b940420f00		MOVL $0xf4240, CX		
  0x1400c7335		e84671fbff		CALL runtime.panicBounds(SB)	
					c0_3 := sim.X_e[k+3] * INV_DX
  0x1400c733a		b840420f00		MOVL $0xf4240, AX		
  0x1400c733f		90			NOPL				
  0x1400c7340		e83b71fbff		CALL runtime.panicBounds(SB)	
					c0_2 := sim.X_e[k+2] * INV_DX
  0x1400c7345		b840420f00		MOVL $0xf4240, AX		
  0x1400c734a		b940420f00		MOVL $0xf4240, CX		
  0x1400c734f		e82c71fbff		CALL runtime.panicBounds(SB)	
					c0_1 := sim.X_e[k+1] * INV_DX
  0x1400c7354		b840420f00		MOVL $0xf4240, AX		
  0x1400c7359		b940420f00		MOVL $0xf4240, CX		
  0x1400c735e		6690			NOPW				
  0x1400c7360		e81b71fbff		CALL runtime.panicBounds(SB)	
					c0_0 := sim.X_e[k] * INV_DX
  0x1400c7365		b940420f00		MOVL $0xf4240, CX		
  0x1400c736a		e81171fbff		CALL runtime.panicBounds(SB)	
					_ = sim.X_e[end-1]
  0x1400c736f		b840420f00		MOVL $0xf4240, AX		
  0x1400c7374		e80771fbff		CALL runtime.panicBounds(SB)	
			sim.WorkerDoneChan <- workerID
  0x1400c7379		4889d9			MOVQ BX, CX		
  0x1400c737c		eb99			JMP 0x1400c7317		
						sim.Vx_e[k] -= e_x * FACTOR_E
  0x1400c737e		f2420f10acd3d090d003	MOVSD_XMM 0x3d090d0(BX)(R10*8), X5	
  0x1400c7388		f20f59d6		MULSD X6, X2				
  0x1400c738c		f20f5cea		SUBSD X2, X5				
  0x1400c7390		f2420f11acd3d090d003	MOVSD_XMM X5, 0x3d090d0(BX)(R10*8)	
						sim.X_e[k] += sim.Vx_e[k] * DT_E
  0x1400c739a		f2420f1094d3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R10*8), X2	
  0x1400c73a4		c4c2d1b9d0		VFMADD231SD X8, X5, X2			
  0x1400c73a9		f2420f1194d3d07e5603	MOVSD_XMM X2, 0x3567ed0(BX)(R10*8)	
					for k := start; k < end; k++ {
  0x1400c73b3		49ffc2			INCQ R10		
  0x1400c73b6		4d39ca			CMPQ R10, R9		
  0x1400c73b9		7dbe			JGE 0x1400c7379		
  0x1400c73bb		0f1f440000		NOPL 0(AX)(AX*1)	
						c0 = sim.X_e[k] * INV_DX
  0x1400c73c0		4981fa40420f00		CMPQ R10, $0xf4240			
  0x1400c73c7		0f83c2020000		JAE 0x1400c768f				
  0x1400c73cd		f2420f1084d3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R10*8), X0	
  0x1400c73d7		f20f100d21ef0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c73df		f20f59c1		MULSD X1, X0				
						p = min(max(int(c0), 0), N_G-2)
  0x1400c73e3		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x1400c73e8		4885c9			TESTQ CX, CX		
  0x1400c73eb		7d02			JGE 0x1400c73ef		
  0x1400c73ed		31c9			XORL CX, CX		
  0x1400c73ef		4881f98e010000		CMPQ CX, $0x18e		
  0x1400c73f6		7e05			JLE 0x1400c73fd		
  0x1400c73f8		b98e010000		MOVL $0x18e, CX		
						c2 = c0 - float64(p)
  0x1400c73fd		0f57d2			XORPS X2, X2		
  0x1400c7400		f2480f2ad1		CVTSI2SDQ CX, X2	
						c1 = float64(p) + 1.0 - c0
  0x1400c7405		f20f101d03ee0000	MOVSD_XMM $f64.3ff0000000000000(SB), X3	
  0x1400c740d		f20f58da		ADDSD X2, X3				
  0x1400c7411		f20f5cd8		SUBSD X0, X3				
						c2 = c0 - float64(p)
  0x1400c7415		f20f5cc2		SUBSD X2, X0		
						e_x = c1*sim.Efield[p] + c2*sim.Efield[p+1]
  0x1400c7419		f20f1094cbd00e2707	MOVSD_XMM 0x7270ed0(BX)(CX*8), X2	
  0x1400c7422		f20f59d3		MULSD X3, X2				
  0x1400c7426		f20f10a4cbd80e2707	MOVSD_XMM 0x7270ed8(BX)(CX*8), X4	
  0x1400c742f		c4e2f9b9d4		VFMADD231SD X4, X0, X2			
						mean_v = sim.Vx_e[k] - 0.5*e_x*FACTOR_E
  0x1400c7434		f2420f10a4d3d090d003	MOVSD_XMM 0x3d090d0(BX)(R10*8), X4	
  0x1400c743e		f20f102db2ed0000	MOVSD_XMM $f64.3fe0000000000000(SB), X5	
  0x1400c7446		f20f59ea		MULSD X2, X5				
  0x1400c744a		f20f103506ee0000	MOVSD_XMM $f64.4009f0f8ec6690dd(SB), X6	
  0x1400c7452		f20f59ee		MULSD X6, X5				
  0x1400c7456		f20f5ce5		SUBSD X5, X4				
						diag.counter_e[p] += c1
  0x1400c745a		488d3c32		LEAQ 0(DX)(SI*1), DI		
  0x1400c745e		f20f102ccf		MOVSD_XMM 0(DI)(CX*8), X5	
  0x1400c7463		f20f58eb		ADDSD X3, X5			
  0x1400c7467		f20f112ccf		MOVSD_XMM X5, 0(DI)(CX*8)	
						diag.counter_e[p+1] += c2
  0x1400c746c		f20f106ccf08		MOVSD_XMM 0x8(DI)(CX*8), X5	
  0x1400c7472		f20f58e8		ADDSD X0, X5			
  0x1400c7476		f20f116ccf08		MOVSD_XMM X5, 0x8(DI)(CX*8)	
						diag.ue[p] += c1 * mean_v
  0x1400c747c		488d3c32		LEAQ 0(DX)(SI*1), DI		
  0x1400c7480		488dbf800c0000		LEAQ 0xc80(DI), DI		
  0x1400c7487		f20f102ccf		MOVSD_XMM 0(DI)(CX*8), X5	
  0x1400c748c		c4e2d9b9eb		VFMADD231SD X3, X4, X5		
  0x1400c7491		f20f112ccf		MOVSD_XMM X5, 0(DI)(CX*8)	
						diag.ue[p+1] += c2 * mean_v
  0x1400c7496		f20f106ccf08		MOVSD_XMM 0x8(DI)(CX*8), X5	
  0x1400c749c		c4e2f9b9ec		VFMADD231SD X4, X0, X5		
  0x1400c74a1		f20f116ccf08		MOVSD_XMM X5, 0x8(DI)(CX*8)	
						v_sqr = mean_v*mean_v + sim.Vy_e[k]*sim.Vy_e[k] + sim.Vz_e[k]*sim.Vz_e[k]
  0x1400c74a7		f20f59e4		MULSD X4, X4				
  0x1400c74ab		f2420f10acd3d0a24a04	MOVSD_XMM 0x44aa2d0(BX)(R10*8), X5	
  0x1400c74b5		c4e2d1b9e5		VFMADD231SD X5, X5, X4			
  0x1400c74ba		f2420f10acd3d0b4c404	MOVSD_XMM 0x4c4b4d0(BX)(R10*8), X5	
  0x1400c74c4		c4e2d1b9e5		VFMADD231SD X5, X5, X4			
						energy = 0.5 * E_MASS * v_sqr * INV_EV_TO_J
  0x1400c74c9		f20f102d17ec0000	MOVSD_XMM $f64.39a279dcc3e61461(SB), X5	
  0x1400c74d1		f20f59ec		MULSD X4, X5				
  0x1400c74d5		f20f103d53ee0000	MOVSD_XMM $f64.43d5a792def818e8(SB), X7	
  0x1400c74dd		f20f59fd		MULSD X5, X7				
						diag.meanee[p] += c1 * energy
  0x1400c74e1		488d3c32		LEAQ 0(DX)(SI*1), DI		
  0x1400c74e5		488dbf00190000		LEAQ 0x1900(DI), DI		
  0x1400c74ec		f2440f1004cf		MOVSD_XMM 0(DI)(CX*8), X8	
  0x1400c74f2		c462c1b9c3		VFMADD231SD X3, X7, X8		
  0x1400c74f7		f2440f1104cf		MOVSD_XMM X8, 0(DI)(CX*8)	
						diag.meanee[p+1] += c2 * energy
  0x1400c74fd		f2440f1044cf08		MOVSD_XMM 0x8(DI)(CX*8), X8	
  0x1400c7504		c462c1b9c0		VFMADD231SD X0, X7, X8		
  0x1400c7509		f2440f1144cf08		MOVSD_XMM X8, 0x8(DI)(CX*8)	
						energy_index = minInt(int(v_sqr*FACTOR_ENERGY_E+0.5), CS_RANGES-1)
  0x1400c7510		f2440f1005dfec0000	MOVSD_XMM $f64.3fe0000000000000(SB), X8	
  0x1400c7519		f2440f100d3eec0000	MOVSD_XMM $f64.3e286b6a97118d9b(SB), X9	
  0x1400c7522		c462b1b9c4		VFMADD231SD X4, X9, X8			
  0x1400c7527		f2490f2cf8		CVTTSD2SIQ X8, DI			
	if a < b {
  0x1400c752c		4881ff3f420f00		CMPQ DI, $0xf423f	
  0x1400c7533		7c05			JL 0x1400c753a		
  0x1400c7535		bf3f420f00		MOVL $0xf423f, DI	
						velocity = math.Sqrt(v_sqr)
  0x1400c753a		90			NOPL			
  0x1400c753b		0f1f440000		NOPL 0(AX)(AX*1)	
						rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x1400c7540		4881ff40420f00		CMPQ DI, $0xf4240	
  0x1400c7547		0f8338010000		JAE 0x1400c7685		
						diag.ioniz[p] += c1 * rate
  0x1400c754d		4c8d1c16		LEAQ 0(SI)(DX*1), R11	
  0x1400c7551		4d8d9b80250000		LEAQ 0x2580(R11), R11	
	return sqrt(x)
  0x1400c7558		f20f51e4		SQRTSD X4, X4		
						rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x1400c755c		f20f59a4fbc024f400	MULSD 0xf424c0(BX)(DI*8), X4			
  0x1400c7565		f2440f1005daeb0000	MOVSD_XMM $f64.3db4456f771df7e8(SB), X8		
  0x1400c756e		f2410f59e0		MULSD X8, X4					
  0x1400c7573		f2440f1015bced0000	MOVSD_XMM $f64.445c0bbef48bc79c(SB), X10	
  0x1400c757c		f2410f59e2		MULSD X10, X4					
						diag.ioniz[p] += c1 * rate
  0x1400c7581		f20f59dc		MULSD X4, X3			
  0x1400c7585		f2410f581ccb		ADDSD 0(R11)(CX*8), X3		
  0x1400c758b		f2410f111ccb		MOVSD_XMM X3, 0(R11)(CX*8)	
						diag.ioniz[p+1] += c2 * rate
  0x1400c7591		f2410f105ccb08		MOVSD_XMM 0x8(R11)(CX*8), X3	
  0x1400c7598		c4e2d9b9d8		VFMADD231SD X0, X4, X3		
  0x1400c759d		f2410f115ccb08		MOVSD_XMM X3, 0x8(R11)(CX*8)	
						if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
  0x1400c75a4		f2420f1084d3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R10*8), X0	
  0x1400c75ae		f20f101dfaeb0000	MOVSD_XMM $f64.3f870a3d70a3d70b(SB), X3	
  0x1400c75b6		660f2ec3		UCOMISD X3, X0				
  0x1400c75ba		660f1f440000		NOPW 0(AX)(AX*1)			
  0x1400c75c0		0f8689000000		JBE 0x1400c764f				
  0x1400c75c6		f20f1025eaeb0000	MOVSD_XMM $f64.3f8c28f5c28f5c2a(SB), X4	
  0x1400c75ce		660f2ee0		UCOMISD X0, X4				
  0x1400c75d2		0f867f000000		JBE 0x1400c7657				
							energy_index = int(energy * INV_DE_EEPF)
  0x1400c75d8		f20f1005d8ec0000	MOVSD_XMM $f64.4034000000000000(SB), X0	
  0x1400c75e0		f20f59f8		MULSD X0, X7				
  0x1400c75e4		f2480f2ccf		CVTTSD2SIQ X7, CX			
							if energy_index < N_EEPF {
  0x1400c75e9		4881f9d0070000		CMPQ CX, $0x7d0		
  0x1400c75f0		7d27			JGE 0x1400c7619		
								diag.eepf[energy_index] += 1.0
  0x1400c75f2		488d3c16		LEAQ 0(SI)(DX*1), DI				
  0x1400c75f6		488dbf00320000		LEAQ 0x3200(DI), DI				
  0x1400c75fd		7377			JAE 0x1400c7676					
  0x1400c75ff		f20f103ccf		MOVSD_XMM 0(DI)(CX*8), X7			
  0x1400c7604		f2440f101d03ec0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
  0x1400c760d		f2410f58fb		ADDSD X11, X7					
  0x1400c7612		f20f113ccf		MOVSD_XMM X7, 0(DI)(CX*8)			
  0x1400c7617		eb09			JMP 0x1400c7622					
  0x1400c7619		f2440f101deeeb0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
							diag.accuCenter += energy
  0x1400c7622		f20f10bc1680700000	MOVSD_XMM 0x7080(SI)(DX*1), X7			
  0x1400c762b		f2440f1025fcec0000	MOVSD_XMM $f64.43d5a792def818e8(SB), X12	
  0x1400c7634		c4e299b9fd		VFMADD231SD X5, X12, X7				
  0x1400c7639		f20f11bc1680700000	MOVSD_XMM X7, 0x7080(SI)(DX*1)			
							diag.counterCenter++
  0x1400c7642		48ff841688700000	INCQ 0x7088(SI)(DX*1)			
  0x1400c764a		e92ffdffff		JMP 0x1400c737e				
  0x1400c764f		f20f102561eb0000	MOVSD_XMM $f64.3f8c28f5c28f5c2a(SB), X4	
						if (MIN_X < sim.X_e[k]) && (sim.X_e[k] < MAX_X) {
  0x1400c7657		f20f100559ec0000	MOVSD_XMM $f64.4034000000000000(SB), X0		
  0x1400c765f		f2440f101da8eb0000	MOVSD_XMM $f64.3ff0000000000000(SB), X11	
  0x1400c7668		f2440f1025bfec0000	MOVSD_XMM $f64.43d5a792def818e8(SB), X12	
  0x1400c7671		e908fdffff		JMP 0x1400c737e					
								diag.eepf[energy_index] += 1.0
  0x1400c7676		b8d0070000		MOVL $0x7d0, AX			
  0x1400c767b		0f1f440000		NOPL 0(AX)(AX*1)		
  0x1400c7680		e8fb6dfbff		CALL runtime.panicBounds(SB)	
						rate = sim.Sigma[E_ION][energy_index] * velocity * DT_E * GAS_DENSITY
  0x1400c7685		b840420f00		MOVL $0xf4240, AX		
  0x1400c768a		e8f16dfbff		CALL runtime.panicBounds(SB)	
						c0 = sim.X_e[k] * INV_DX
  0x1400c768f		b840420f00		MOVL $0xf4240, AX		
  0x1400c7694		e8e76dfbff		CALL runtime.panicBounds(SB)	
				diag := &sim.WorkerEDiag[workerID]
  0x1400c7699		e8e26dfbff		CALL runtime.panicBounds(SB)	
			sim.WorkerDoneChan <- workerID
  0x1400c769e		488b83682eba07		MOVQ 0x7ba2e68(BX), AX		
  0x1400c76a5		488d9c2450010000	LEAQ 0x150(SP), BX		
  0x1400c76ad		e84e90f4ff		CALL runtime.chansend1(SB)	
  0x1400c76b2		e945e4ffff		JMP 0x1400c5afc			
					c2 := (c0 - float64(p)) * FACTOR_W
  0x1400c76b7		0f57d2			XORPS X2, X2				
  0x1400c76ba		f2480f2ad1		CVTSI2SDQ CX, X2			
  0x1400c76bf		f20f5cc2		SUBSD X2, X0				
  0x1400c76c3		f20f101555ec0000	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X2	
  0x1400c76cb		f20f59d0		MULSD X0, X2				
					c1 := FACTOR_W - c2
  0x1400c76cf		f20f101d49ec0000	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X3	
  0x1400c76d7		f20f5cda		SUBSD X2, X3				
					densityI[p] += c1
  0x1400c76db		f20f581cca		ADDSD 0(DX)(CX*8), X3		
  0x1400c76e0		f20f111cca		MOVSD_XMM X3, 0(DX)(CX*8)	
					densityI[p+1] += c2
  0x1400c76e5		f20f1054ca08		MOVSD_XMM 0x8(DX)(CX*8), X2		
  0x1400c76eb		f20f101d2dec0000	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X3	
  0x1400c76f3		c4e2f9b9d3		VFMADD231SD X3, X0, X2			
  0x1400c76f8		f20f1154ca08		MOVSD_XMM X2, 0x8(DX)(CX*8)		
				for k := start; k < end; k++ {
  0x1400c76fe		49ffc2			INCQ R10		
  0x1400c7701		4d39ca			CMPQ R10, R9		
  0x1400c7704		7d98			JGE 0x1400c769e		
					c0 := sim.X_i[k] * INV_DX
  0x1400c7706		4981fa40420f00		CMPQ R10, $0xf4240			
  0x1400c770d		7339			JAE 0x1400c7748				
  0x1400c770f		f2420f1084d3d0c63e05	MOVSD_XMM 0x53ec6d0(BX)(R10*8), X0	
  0x1400c7719		f20f100ddfeb0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c7721		f20f59c1		MULSD X1, X0				
					p := min(max(int(c0), 0), N_G-2)
  0x1400c7725		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x1400c772a		4885c9			TESTQ CX, CX		
  0x1400c772d		7d02			JGE 0x1400c7731		
  0x1400c772f		31c9			XORL CX, CX		
  0x1400c7731		4881f98e010000		CMPQ CX, $0x18e		
  0x1400c7738		0f8e79ffffff		JLE 0x1400c76b7		
  0x1400c773e		b98e010000		MOVL $0x18e, CX		
  0x1400c7743		e96fffffff		JMP 0x1400c76b7		
					c0 := sim.X_i[k] * INV_DX
  0x1400c7748		b840420f00		MOVL $0xf4240, AX		
  0x1400c774d		e82e6dfbff		CALL runtime.panicBounds(SB)	
			densityI := &sim.WorkerIDensity[workerID]
  0x1400c7752		e8296dfbff		CALL runtime.panicBounds(SB)	
			sim.WorkerDoneChan <- workerID
  0x1400c7757		488b83682eba07		MOVQ 0x7ba2e68(BX), AX		
  0x1400c775e		488d9c2450010000	LEAQ 0x150(SP), BX		
  0x1400c7766		e8958ff4ff		CALL runtime.chansend1(SB)	
  0x1400c776b		e98ce3ffff		JMP 0x1400c5afc			
					c2 := (c0 - float64(p)) * FACTOR_W
  0x1400c7770		0f57d2			XORPS X2, X2				
  0x1400c7773		f2480f2ad1		CVTSI2SDQ CX, X2			
  0x1400c7778		f20f5cc2		SUBSD X2, X0				
  0x1400c777c		f20f10159ceb0000	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X2	
  0x1400c7784		f20f59d0		MULSD X0, X2				
					c1 := FACTOR_W - c2
  0x1400c7788		f20f101d90eb0000	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X3	
  0x1400c7790		f20f5cda		SUBSD X2, X3				
					densityE[p] += c1
  0x1400c7794		f20f581cca		ADDSD 0(DX)(CX*8), X3		
  0x1400c7799		f20f111cca		MOVSD_XMM X3, 0(DX)(CX*8)	
					densityE[p+1] += c2
  0x1400c779e		f20f1054ca08		MOVSD_XMM 0x8(DX)(CX*8), X2		
  0x1400c77a4		f20f101d74eb0000	MOVSD_XMM $f64.42a4525e2ecfffff(SB), X3	
  0x1400c77ac		c4e2e1b9d0		VFMADD231SD X0, X3, X2			
  0x1400c77b1		f20f1154ca08		MOVSD_XMM X2, 0x8(DX)(CX*8)		
				for k := start; k < end; k++ {
  0x1400c77b7		49ffc2			INCQ R10		
  0x1400c77ba		4d39ca			CMPQ R10, R9		
  0x1400c77bd		7d98			JGE 0x1400c7757		
  0x1400c77bf		90			NOPL			
					c0 := sim.X_e[k] * INV_DX
  0x1400c77c0		4981fa40420f00		CMPQ R10, $0xf4240			
  0x1400c77c7		733c			JAE 0x1400c7805				
  0x1400c77c9		f2420f1084d3d07e5603	MOVSD_XMM 0x3567ed0(BX)(R10*8), X0	
  0x1400c77d3		f20f100d25eb0000	MOVSD_XMM $f64.40cf2c0000000000(SB), X1	
  0x1400c77db		f20f59c1		MULSD X1, X0				
					p := min(max(int(c0), 0), N_G-2)
  0x1400c77df		f2480f2cc8		CVTTSD2SIQ X0, CX	
  0x1400c77e4		4885c9			TESTQ CX, CX		
  0x1400c77e7		7d02			JGE 0x1400c77eb		
  0x1400c77e9		31c9			XORL CX, CX		
  0x1400c77eb		4881f98e010000		CMPQ CX, $0x18e		
  0x1400c77f2		0f8e78ffffff		JLE 0x1400c7770		
  0x1400c77f8		b98e010000		MOVL $0x18e, CX		
  0x1400c77fd		0f1f00			NOPL 0(AX)		
  0x1400c7800		e96bffffff		JMP 0x1400c7770		
					c0 := sim.X_e[k] * INV_DX
  0x1400c7805		b840420f00		MOVL $0xf4240, AX		
  0x1400c780a		e8716cfbff		CALL runtime.panicBounds(SB)	
			densityE := &sim.WorkerEDensity[workerID]
  0x1400c780f		e86c6cfbff		CALL runtime.panicBounds(SB)	
	for cmd := range sim.WorkerCmdChan[workerID] {
  0x1400c7814		e8676cfbff		CALL runtime.panicBounds(SB)	
  0x1400c7819		90			NOPL				
func (sim *SimulationState) startWorker(workerID int) {
  0x1400c781a		4889442408		MOVQ AX, 0x8(SP)				
  0x1400c781f		48895c2410		MOVQ BX, 0x10(SP)				
  0x1400c7824		e8174efbff		CALL runtime.morestack_noctxt.abi0(SB)		
  0x1400c7829		488b442408		MOVQ 0x8(SP), AX				
  0x1400c782e		488b5c2410		MOVQ 0x10(SP), BX				
  0x1400c7833		e968e2ffff		JMP gopic.(*SimulationState).startWorker(SB)	

  0x1400c7838		cc			INT $0x3		
  0x1400c7839		cc			INT $0x3		
  0x1400c783a		cc			INT $0x3		
  0x1400c783b		cc			INT $0x3		
  0x1400c783c		cc			INT $0x3		
  0x1400c783d		cc			INT $0x3		
  0x1400c783e		cc			INT $0x3		
  0x1400c783f		cc			INT $0x3		


