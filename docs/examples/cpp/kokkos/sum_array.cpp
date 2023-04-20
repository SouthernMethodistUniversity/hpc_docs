#include <iostream>   // for output
#include <sys/time.h> // for time

#include <Kokkos_Core.hpp> // for Kokkos library

int main(int argc, char *argv[])
{

  // define the vector size
  const int N = 100000000;

  // first we need to initialize Kokkos
  Kokkos::initialize(argc, argv);

  // This is just a trick to get all of the allocations
  // from Kokkos we use to go out of scope and
  // deallocate before we finalize without having to
  // do it manually
  {

// Check what compute environments we can use with Kokkos
// This sets a variable to an appropriate memory space.
// For this, we're assuming we can only use one of these
#ifdef KOKKOS_ENABLE_CUDA
#define MemSpace Kokkos::CudaSpace
    std::cout << "using cuda" << std::endl;
#endif
#ifdef KOKKOS_ENABLE_HIP
#define MemSpace Kokkos::Experimental::HIPSpace
    std::cout << "using hip" << std::endl;
#endif
#ifdef KOKKOS_ENABLE_OPENMPTARGET
#define MemSpace Kokkos::OpenMPTargetSpace
    std::cout << "using OpenMPTarget" << std::endl;
#endif
#ifndef MemSpace
#define MemSpace Kokkos::HostSpace
    std::cout << "using host" << std::endl;
#endif

    // shorten the names of some of the things we are going to use
    // this just makes the code a bit cleaner and we have to type less
    using ExecSpace = MemSpace::execution_space;
    using range_policy = Kokkos::RangePolicy<ExecSpace>;

    // Allocate a vector on the device (could be GPU or CPU)
    // first we'll use typedef to rename the long templated
    // c++ datatype to something more readable
    //
    //
    // In Kokkos, Views are essentially containers to hold
    // array data with a bit of extra metadata.
    //
    // We'll use the double datatype for our values
    // Then we need to specify a layout:
    // LayoutLeft: leftmost index is stride 1  (column major in 2d)
    // LayoutRight: rightmost index is stride 1 (row major in 2d)
    // (we're using a 1d array, so it doesn't matter because there
    // is only 1 index; and hence, they are the same)
    // Then we need to specify the memory space, this is where the memory
    // will be allocated.
    typedef Kokkos::View<double *, Kokkos::LayoutLeft, MemSpace> KokkosVector;

    // Use out typedef to create a vector with N elements.
    // Kokkos lets you name view, which is usually a good idea
    // for readability and debugging.
    KokkosVector device_v("test_vector", N);

    // The vector above may have been allocated on a GPU or other device
    // to do some operations, like inspect values to print out or to
    // allocate values in some cases
    // To facilitate this, Kokkos has "mirrors"
    KokkosVector::HostMirror host_v = Kokkos::create_mirror_view(device_v);

    // Now we'll initialize the vector on the host with some value
    for (int i = 0; i < N; ++i)
    {
      host_v(i) = 0.1; // all values are 0.1
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
    Kokkos::deep_copy(device_v, host_v);
    double copy_time = timer_copy.seconds();

    // compute the sum on the host for a comparison using openmp directly
    double host_sum = 0;
    Kokkos::Timer timer_host_sum;
#pragma omp parallel for default(shared) reduction(+ \
                                                   : host_sum)
    for (int i = 0; i < N; ++i)
    {
      host_sum += host_v(i);
    }
    double host_sum_time = timer_host_sum.seconds();

    // Use a reduction to sum up the vector
    // KOKKOS_LAMBDA is a macro that puts appropriate decorators on
    // the lambda expression (cuda needs stuff like __device__ and/or __host__)
    // depending on where it is running
    Kokkos::Timer timer_compute;
    double sum = 0;
    Kokkos::parallel_reduce(
        "vectorsum", N, KOKKOS_LAMBDA(const std::size_t &ind, double &temp_sum) { temp_sum += device_v(ind); }, sum);
    Kokkos::fence();
    double compute_time = timer_compute.seconds();

    std::cout << "sum: " << sum << " expected " << 0.1 * N << " host sum: " << host_sum << std::endl;
    std::cout << "copy time: " << copy_time << std::endl;
    std::cout << "compute time: " << compute_time << " approx speed up: " << host_sum_time / (copy_time + compute_time) << std::endl;
    std::cout << "compute time (host): " << host_sum_time << std::endl;
  }

  // Tell Kokkos we're done so it can clean up
  Kokkos::finalize();

  // return 0 for successfully reaching this point by convention
  return 0;
}
