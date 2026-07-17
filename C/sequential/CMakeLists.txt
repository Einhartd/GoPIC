cmake_minimum_required(VERSION 3.14)
project(eduPIC_C_tests CXX)
set(CMAKE_CXX_STANDARD 17)

include(FetchContent)
FetchContent_Declare(googletest
  URL https://github.com/google/googletest/archive/v1.14.0.zip)
FetchContent_MakeAvailable(googletest)

add_executable(run_tests
    tests/test_poisson.cc
    tests/test_density.cc
    tests/test_push.cc
    tests/test_boundaries.cc
    tests/test_cross_sections.cc
)

target_include_directories(run_tests PRIVATE ${CMAKE_SOURCE_DIR})
target_link_libraries(run_tests GTest::gtest_main)

include(GoogleTest)
gtest_discover_tests(run_tests)