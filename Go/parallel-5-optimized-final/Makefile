GO       ?= go
GOAMD64  ?= v4
GOFLAGS  ?= -ldflags="-s -w"
TARGET   = edupic_optimized
CMD_SRC  = ./cmd/pic

all: $(TARGET)

$(TARGET): *.go *.s cmd/pic/*.go
	GOAMD64=$(GOAMD64) $(GO) build $(GOFLAGS) -o $(TARGET) $(CMD_SRC)

check_bce:
	GOAMD64=$(GOAMD64) $(GO) build -gcflags="-d=ssa/check_bce/debug=1" $(CMD_SRC)

clean:
	rm -rf $(TARGET) picdata.bin conv.dat density.dat eepf.dat ifed.dat info.txt *.xt perf_results_* perf.data*

.PHONY: all check_bce clean
