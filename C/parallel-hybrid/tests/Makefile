CXX = mpicxx
CXXFLAGS = -std=c++17 -O2 -Wall -fopenmp -DUSE_NULL_COLLISION -I..

TEST_SRCS = test_hybrid.cc test_poisson.cc test_null_collision.cc test_ions.cc

all: run_tests
	mpirun -np 2 ./run_tests

run_tests: $(TEST_SRCS)
	$(CXX) $(CXXFLAGS) $(TEST_SRCS) -lgtest -lpthread -o run_tests

clean:
	rm -f run_tests picdata.bin conv.dat eepf.dat ifed.dat *xt.dat info.txt
