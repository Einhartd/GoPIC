CXX = mpicxx
CXXFLAGS = -std=c++17 -O2 -Wall -fopenmp -I..

all: run_tests
	mpirun -np 2 ./run_tests

run_tests: test_hybrid.cc
	$(CXX) $(CXXFLAGS) test_hybrid.cc -lgtest -lpthread -o run_tests

clean:
	rm -f run_tests picdata.bin conv.dat eepf.dat ifed.dat *xt.dat info.txt
