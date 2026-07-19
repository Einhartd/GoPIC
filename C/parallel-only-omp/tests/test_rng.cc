#include <gtest/gtest.h>
#include "../state.h"
#include <omp.h>
#include <vector>
#include <cmath>

TEST(RNGTest, ThreadLocalDeterminismAndUniqueness) {
    const int num_threads = 4;
    const int num_samples = 1000;
    std::vector<std::vector<double>> samples(num_threads, std::vector<double>(num_samples));

    #pragma omp parallel num_threads(num_threads)
    {
        int tid = omp_get_thread_num();
        // Seed each thread deterministically to check for reproducibility and avoid same stream
        MTgen.seed(12345 + tid);
        for (int i = 0; i < num_samples; ++i) {
            samples[tid][i] = R01(MTgen);
        }
    }

    // Check that sequences from different threads are not identical (different seeds)
    for (int t1 = 0; t1 < num_threads; ++t1) {
        for (int t2 = t1 + 1; t2 < num_threads; ++t2) {
            bool identical = true;
            for (int i = 0; i < num_samples; ++i) {
                if (samples[t1][i] != samples[t2][i]) {
                    identical = false;
                    break;
                }
            }
            EXPECT_FALSE(identical) << "Thread " << t1 << " and thread " << t2 << " produced the exact same sequence!";
        }
    }

    // Verify that thread-local generation is statistically correct (e.g. uniform distribution R01 has mean ~0.5)
    for (int t = 0; t < num_threads; ++t) {
        double sum = 0.0;
        for (int i = 0; i < num_samples; ++i) {
            sum += samples[t][i];
        }
        double mean = sum / num_samples;
        EXPECT_NEAR(mean, 0.5, 0.05); // Mean of U(0,1) is 0.5, with 1000 samples standard error is ~0.009
    }
}

TEST(RNGTest, NormalDistributionCorrectness) {
    const int num_threads = 4;
    const int num_samples = 10000;
    std::vector<double> all_samples(num_threads * num_samples);

    #pragma omp parallel num_threads(num_threads)
    {
        int tid = omp_get_thread_num();
        MTgen.seed(98765 + tid);
        for (int i = 0; i < num_samples; ++i) {
            all_samples[tid * num_samples + i] = RMB(MTgen);
        }
    }

    // Verify mean and standard deviation of normal distribution
    // RMB parameter: mean = 0, std = sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS)
    double target_std = sqrt(K_BOLTZMANN * TEMPERATURE / AR_MASS);
    double sum = 0.0;
    for (double val : all_samples) {
        sum += val;
    }
    double mean = sum / all_samples.size();
    EXPECT_NEAR(mean, 0.0, target_std * 0.05);

    double sum_sq = 0.0;
    for (double val : all_samples) {
        sum_sq += (val - mean) * (val - mean);
    }
    double variance = sum_sq / (all_samples.size() - 1);
    double std_dev = sqrt(variance);
    EXPECT_NEAR(std_dev, target_std, target_std * 0.05);
}
