#include <iostream> // for output
#include <vector>   // for std::vector
#include <cmath>    // for sin and cos
#include <chrono>   // for time
#include <omp.h>


constexpr double PI = 3.14159265358979323846;

int main(int argc, char *argv[])
{

    // define the vector size
    const int N = 100000;

    std::vector<double> x, u, f;
    x.assign(N * 3, 0.0);
    u.assign(N * 3, 0.0);
    f.assign(N * 3, 0.0);

    // Now we'll initialize the vectors on the host with some values
    const double radius = 1;
    const double scaling = 2 * PI / static_cast<double>(N);
    #pragma omp parallel for default(shared)
    for (int i = 0; i < N; ++i)
    {
        // just make a helix
        x[3 * i] = radius * std::cos(scaling * i);
        x[3 * i + 1] = radius * std::sin(scaling * i);
        x[3 * i + 2] = 0.75 * i;

        // set the forces to point to the origin
        // with unit magnituge
        const double mag = std::sqrt(x[3 * i] * x[3 * i] + x[3 * i + 1] * x[3 * i + 1] + x[3 * i + 2] * x[3 * i + 2]);
        f[3 * i] = -x[3 * i] / mag;
        f[3 * i + 1] = -x[3 * i + 1] / mag;
        f[3 * i + 2] = -x[3 * i + 2] / mag;
    }

    // compute the sum on the host for a comparison directly
    auto start = std::chrono::steady_clock::now();
    const double eps = 0.01;
    const double eps2 = eps * eps;
    #pragma omp parallel for default(shared)
    for (int i = 0; i < N; ++i)
    {
        u[3 * i] = 0;
        u[3 * i + 1] = 0;
        u[3 * i + 2] = 0;
        for (int j = 0; j < N; ++j)
        {
            const double dx = x[3 * i] - x[3 * j];
            const double dy = x[3 * i + 1] - x[3 * j + 1];
            const double dz = x[3 * i + 2] - x[3 * j + 2];

            const double R2 = dx * dx + dy * dy + dz * dz + eps2;
            const double invR2 = 1.0 / R2;
            const double invR = std::sqrt(invR2);

            const double Hs2 = 0.5 * invR * invR2;
            const double Hs1 = 0.5 * invR + eps2 * Hs2;

            const double fdotx = f[3 * j] * dx + f[3 * j + 1] * dy + f[3 * j + 2] * dz;

            u[3 * i] += f[3 * j] * Hs1 + fdotx * dx * Hs2;
            u[3 * i + 1] += f[3 * j + 1] * Hs1 + fdotx * dy * Hs2;
            u[3 * i + 2] += f[3 * j + 2] * Hs1 + fdotx * dz * Hs2;
        }
    }
    auto end = std::chrono::steady_clock::now();
    std::chrono::duration<double> diff = end - start;
    double host_sum_time = diff.count();

    std::cout << "\nDevice computed values:" << std::endl;
    for (int i = 0; i < 5; ++i)
    {
        std::cout << "i: " << i << " u = (" << u[3 * i] << ", " << u[3 * i + 1] << ", " << u[3 * i + 2] << ")" << std::endl;
    }

    std::cout << "compute time (host): " << host_sum_time << std::endl;

    // return 0 for successfully reaching this point by convention
    return 0;
}
