CXX = g++
CXXFLAGS = -std=c++17 -O3 -fopenmp -Wall

TARGET = bench_false_sharing

all: $(TARGET)

$(TARGET): bench_false_sharing.cc
	$(CXX) $(CXXFLAGS) bench_false_sharing.cc -o $(TARGET)

run: $(TARGET)
	./$(TARGET)

perf: $(TARGET)
	perf stat -e task-clock,cycles,instructions,cache-misses,L1-dcache-load-misses,L1-dcache-store-misses ./$(TARGET)

clean:
	rm -f $(TARGET)
