CXX      = g++
CXXFLAGS = -std=c++17 -O2 -Wall -fopenmp
LDFLAGS  = -lgtest -lgtest_main -lpthread -fopenmp

TEST_SRCS = test_rng.cc test_density.cc test_push.cc test_boundaries.cc test_collisions.cc

all: run_tests
	./run_tests

run_tests: $(TEST_SRCS) ../constants.h ../state.h ../simulation.h test_helpers.h
	$(CXX) $(CXXFLAGS) $(TEST_SRCS) $(LDFLAGS) -I.. -o run_tests

clean:
	rm -f run_tests
