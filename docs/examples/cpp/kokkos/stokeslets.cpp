#include <iostream>   // for output
#include <sys/time.h> // for time
#include <cmath>      // for sin and cos

#include <Kokkos_Core.hpp> // for Kokkos library

constexpr double PI = 3.14159265358979323846;

// note: templating the exec space and the view type
// allows us to change where the execution occurs and
// the datatype / ordering used
template <class ExecSpace, class KokkosVector>
void computeStokeslet(const int &N)
{
    // create a vector with N elements.
    // Kokkos lets you name view, which is usually a good idea
    // for readability and debugging.
    KokkosVector device_x("Positions", N);
    KokkosVector device_u("Velocities", N);
    KokkosVector device_f("Forces", N);

    // The vector above may have been allocated on a GPU or other device
    // to do some operations, like inspect values to print out or to
    // allocate values in some cases
    // To facilitate this, Kokkos has "mirrors"
    auto host_x = Kokkos::create_mirror_view(device_x);
    auto host_u = Kokkos::create_mirror_view(device_u);
    auto host_f = Kokkos::create_mirror_view(device_f);

    // Now we'll initialize the vectors on the host with some values
    const double radius = 1;
    const double scaling = 2 * PI / static_cast<double>(N);
    for (int i = 0; i < N; ++i)
    {
        // just make a helix
        host_x(i, 0) = radius * std::cos(scaling * i);
        host_x(i, 1) = radius * std::sin(scaling * i);
        host_x(i, 2) = 0.75 * i;

        // set velocities to 0;
        host_u(i, 0) = 0;
        host_u(i, 1) = 0;
        host_u(i, 2) = 0;

        // set the forces to point to the origin
        // with unit magnituge
        const double mag = std::sqrt(host_x(i, 0) * host_x(i, 0) + host_x(i, 1) * host_x(i, 1) + host_x(i, 2) * host_x(i, 2));
        host_f(i, 0) = -host_x(i, 0) / mag;
        host_f(i, 1) = -host_x(i, 1) / mag;
        host_f(i, 2) = -host_x(i, 2) / mag;
    }

    // The vector has the correct values on the host now, but not on
    // the device. Kokkos does not hide any data transfers between
    // devices / hosts so you must do this manually. Note that this
    // is a good thing: data transfer is often more expensive than
    // the computations, so care should be taken in designing the
    // the data flow
    // input is (destination, source)
    // We'll also time this operation
    Kokkos::Timer timer_copy;
    Kokkos::deep_copy(device_x, host_x);
    Kokkos::deep_copy(device_u, host_x);
    Kokkos::deep_copy(device_f, host_f);
    Kokkos::fence();
    double copy_time = timer_copy.seconds();

    // compute the sum on the host for a comparison directly
    Kokkos::Timer timer_host_sum;
    const double eps = 0.01;
    const double eps2 = eps * eps;
#pragma omp parallel for default(shared)
    for (int i = 0; i < N; ++i)
    {
        host_u(i, 0) = 0;
        host_u(i, 1) = 0;
        host_u(i, 2) = 0;
        for (int j = 0; j < N; ++j)
        {
            const double dx = host_x(i, 0) - host_x(j, 0);
            const double dy = host_x(i, 1) - host_x(j, 1);
            const double dz = host_x(i, 2) - host_x(j, 2);

            double R2 = dx * dx + dy * dy + dz * dz + eps2;
            double invR2 = 1.0 / R2;
            double invR = std::sqrt(invR2);

            double Hs2 = 0.5 * invR * invR2;
            double Hs1 = 0.5 * invR + eps2 * Hs2;

            double fdotx = host_f(j, 0) * dx + host_f(j, 1) * dy + host_f(j, 2) * dz;

            host_u(i, 0) += host_f(j, 0) * Hs1 + fdotx * dx * Hs2;
            host_u(i, 1) += host_f(j, 1) * Hs1 + fdotx * dy * Hs2;
            host_u(i, 2) += host_f(j, 2) * Hs1 + fdotx * dz * Hs2;
        }
    }
    double host_sum_time = timer_host_sum.seconds();

    // print out a few of the host computed velociteis
    std::cout << "Host computed values:" << std::endl;
    for (int i = 0; i < 5; ++i)
    {
        std::cout << "i: " << i << " u = (" << host_u(i, 0) << ", " << host_u(i, 1) << ", " << host_u(i, 2) << ")" << std::endl;
    }

    // Use a reduction to sum up the vector
    // KOKKOS_LAMBDA is a macro that puts appropriate decorators on
    // the lambda expression (cuda needs stuff like __device__ and/or __host__)
    // depending on where it is running
    using range_policy = Kokkos::RangePolicy<ExecSpace>;
    Kokkos::Timer timer_compute;
    Kokkos::parallel_for(
        "Stokeslet Computation", range_policy( 0, N ), KOKKOS_LAMBDA(const std::size_t i) {
            device_u(i, 0) = 0;
            device_u(i, 1) = 0;
            device_u(i, 2) = 0;
            for (int j = 0; j < N; ++j)
            {
                const double dx = device_x(i, 0) - device_x(j, 0);
                const double dy = device_x(i, 1) - device_x(j, 1);
                const double dz = device_x(i, 2) - device_x(j, 2);

                double r2 = dx*dx + dy*dy + dz*dz + eps2;
                double invR2 = 1.0 / r2;
                double invR = std::sqrt(invR2);

                double Hs2 = 0.5*invR*invR2;
                double Hs1 = 0.5 * invR + eps2 * Hs2;

                double fdotx = device_f(j, 0) * dx + device_f(j, 1) * dy + device_f(j, 2) * dz;

                device_u(i, 0) += device_f(j, 0) * Hs1 + fdotx * dx * Hs2;
                device_u(i, 1) += device_f(j, 1) * Hs1 + fdotx * dy * Hs2;
                device_u(i, 2) += device_f(j, 2) * Hs1 + fdotx * dz * Hs2;
            } });

    // copy values vack
    Kokkos::fence();
    double compute_time = timer_compute.seconds();

    // copy values from device and print out a few
    Kokkos::Timer timer_copy2;
    Kokkos::deep_copy(host_u, device_u);
    Kokkos::fence();
    copy_time += timer_copy2.seconds();
    std::cout << "\nDevice computed values:" << std::endl;
    for (int i = 0; i < 5; ++i)
    {
        std::cout << "i: " << i << " u = (" << host_u(i, 0) << ", " << host_u(i, 1) << ", " << host_u(i, 2) << ")" << std::endl;
    }

    std::cout << "copy time: " << copy_time << std::endl;
    std::cout << "compute time: " << compute_time << " approx speed up: " << host_sum_time / (compute_time + copy_time) << std::endl;
    std::cout << "compute time (host): " << host_sum_time << std::endl;
}

int main(int argc, char *argv[])
{

    // define the vector size
    const int N = 100000;

    // first we need to initialize Kokkos
    Kokkos::initialize(argc, argv);

    // The braces are to scope the variables so we can run
    // diffent things using similar names
    {

      // first we'll use typedef to rename the long templated
      // c++ datatype to something more readable
      //
      // In Kokkos, Views are essentially containers to hold
      // array data with a bit of extra metadata.
      //
      // We'll use the double datatype for our values
      // Then we need to specify a layout:
      // LayoutLeft: leftmost index is stride 1  (column major in 2d)
      // LayoutRight: rightmost index is stride 1 (row major in 2d)
      // Then we need to specify the memory space, this is where the memory
      // will be allocated.
      //
      // This will be a "host" memory space
      typedef Kokkos::View<double *[3], Kokkos::LayoutRight, Kokkos::HostSpace> KokkosVector;

      // set the execution space to be host
      using ExecSpace = Kokkos::HostSpace::execution_space;

      std::cout << "\nusing host space" << std::endl;
      computeStokeslet<ExecSpace, KokkosVector>(N);
    }

    // due the same thing but use the CudaMemory and execution space
    {
      typedef Kokkos::View<double *[3], Kokkos::LayoutRight, Kokkos::CudaSpace> KokkosVector;

      // set the execution space to be cuda
      using ExecSpace = Kokkos::CudaSpace::execution_space;

      std::cout << "\nusing cuda space" << std::endl;
      computeStokeslet<ExecSpace, KokkosVector>(N);
    }

    // Tell Kokkos we're done so it can clean up
    Kokkos::finalize();

    // return 0 for successfully reaching this point by convention
    return 0;
}
