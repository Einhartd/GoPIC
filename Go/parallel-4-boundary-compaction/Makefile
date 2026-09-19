GO       ?= go
GOFLAGS  ?= -ldflags="-s -w"
TARGET   = edupic_compaction
CMD_SRC  = ./cmd/pic

all: $(TARGET)

$(TARGET): *.go *.s cmd/pic/*.go
	$(GO) build $(GOFLAGS) -o $(TARGET) $(CMD_SRC)

clean:
	rm -rf $(TARGET) picdata.bin conv.dat density.dat eepf.dat ifed.dat info.txt *.xt perf_results_* perf.data*

.PHONY: all clean
