CXX      = g++
CXXFLAGS = -std=c++17 -O3 -Wall -fno-math-errno
LDFLAGS  = -lm

TARGET   = eduPIC
SRCS     = eduPIC.cc
HEADERS  = constants.h state.h cross_sections.h poisson.h collisions.h simulation.h io_manager.h

all: $(TARGET)

$(TARGET): $(SRCS) $(HEADERS)
	$(CXX) $(CXXFLAGS) $(SRCS) -o $(TARGET) $(LDFLAGS)

clean:
	rm -rf $(TARGET) picdata.bin conv.dat density.dat eepf.dat ifed.dat info.txt *.xt perf_results_* perf.data*

.PHONY: all clean
