#include <span>

// Dokładny odpowiednik Go slice: []float64 (zawiera wskaźnik + długość)
// - Dokładnie 3 argumenty (brak dodatkowego int n!)
// - Brak słowa kluczowego __restrict__
void MoveStandardCPP(std::span<double> x, std::span<const double> v, double dt) {
    for (size_t i = 0; i < x.size(); i++) {
        x[i] += v[i] * dt;
    }
}
