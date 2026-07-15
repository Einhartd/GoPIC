CXX      = g++
CXXFLAGS = -std=c++17 -O2 -Wall
LDFLAGS  = -lgtest -lgtest_main -lpthread

TEST_SRCS = test_poisson.cc test_density.cc test_push.cc \
            test_boundaries.cc test_cross_sections.cc

all: run_tests
	./run_tests

# Kompilacja: dołączamy tylko źródła testów.
# Cała logika symulacji jest wciągana automatycznie z nagłówków w test_helpers.h
run_tests: $(TEST_SRCS) test_helpers.h ../constants.h ../state.h ../poisson.h ../collisions.h ../simulation.h ../io_manager.h
	$(CXX) $(CXXFLAGS) $(TEST_SRCS) $(LDFLAGS) -I.. -o run_tests

regression:
	bash run_regression.sh

clean:
	rm -f run_tests