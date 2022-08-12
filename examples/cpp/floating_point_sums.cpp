#include <iostream>        // standard IO
#include <vector>          // STL arrays
#include <limits>          // get number of digits based on datatype
#include <iomanip>         // for setprecision
#include <numeric>         // for iota, create array of 1 to n
#include <random>          // random number generators
#include <algorithm>       // for std::shuffle, random vector order
#include <cmath>           // for acos
#include "timer/timer.hpp" // our timer class

// Function to sum the first n_terms of the
// series
//
// 1/1 + 1/2 + 1/3 + ... + 1/n_terms
//
// Templated so we can see the effects
// of using different datatypes
template <class T>
T forward_series(const std::size_t &n_terms)
{
    // create a timer
    Timer::Timer timer("Forward Sum");
    T sum = static_cast<T>(0);
    for (std::size_t n = 1; n <= n_terms; ++n)
    {
        sum += static_cast<T>(1) / static_cast<T>(n);
    }
    return sum;
}

// Function to sum the first n_terms of the
// series. Sums from smallest term to largest
//
// 1/n_terms + ... + 1/3 + 1/2 + 1/1
//
// Templated so we can see the effects
// of using different datatypes
template <class T>
T reverse_series(const std::size_t &n_terms)
{
    // create a timer
    Timer::Timer timer("Reverse Sum");
    T sum = static_cast<T>(0);
    for (std::size_t n = n_terms; n > 0; --n)
    {
        sum += static_cast<T>(1) / static_cast<T>(n);
    }
    return sum;
}

// Function to sum the first n_terms of the
// series
//
// 1/1 + 1/2 + 1/3 + ... + 1/n_terms
//
// Using the Kahan summation algorithm see, e.g.
// https://en.wikipedia.org/wiki/Kahan_summation_algorithm
//
//
// Templated so we can see the effects
// of using different datatypes
template <class T>
T kahan_series(const std::size_t &n_terms)
{
    // create a timer
    Timer::Timer timer("Kahan Sum");
    T sum = static_cast<T>(0);
    T c = static_cast<T>(0);

    // NOTE: directly, we just have 1 addition, but here
    // we have 4 addition/subtraction operations, so we'd
    // expect it to be about 4x slower
    for (std::size_t n = n_terms; n > 0; --n)
    {
        T current_term = static_cast<T>(1) / static_cast<T>(n);
        T y = current_term - c; // In exact math, c is always 0!
        T t = sum + y;          // sum is "big" and y is "small"
        c = (t - sum) - y;      // c is approximately the floating error 
        sum = t;                // but is itself a floating point number
    }
    return sum;
}

// Function to sum the first n_terms of the
// series, summed in a random order
//
// 1/1 + 1/2 + 1/3 + ... + 1/n_terms
//
// Templated so we can see the effects
// of using different datatypes
template <class T>
T random_series(const std::size_t &n_terms)
{
    // create a timer
    Timer::Timer timer("Random Sum");

    //  create a vector of numbers 1 to nterms
    std::vector<std::size_t> denominators(n_terms);
    std::iota(denominators.begin(), denominators.end(), 1);

    // randomly reorder numbers
    std::random_device rd;
    std::mt19937 g(rd());
    std::shuffle(denominators.begin(), denominators.end(), g);

    T sum = static_cast<T>(0);
    for (const std::size_t &n : denominators)
    {
        // the static_cast is to convert std::size_t
        // to the desired type before we do any math
        sum += static_cast<T>(1) / static_cast<T>(n);
    }
    return sum;
}

// Function to sum the first n_terms of the
// series, summed in a random order
//
// 1/1 + 1/2 + 1/3 + ... + 1/n_terms
//
// using the Kahan algorithm
//
// Templated so we can see the effects
// of using different datatypes
template <class T>
T random_kahan_series(const std::size_t &n_terms)
{
    // create a timer
    Timer::Timer timer("Random Kahan Sum");

    //  create a vector of numbers 1 to nterms
    std::vector<std::size_t> denominators(n_terms);
    std::iota(denominators.begin(), denominators.end(), 1);

    // randomly reorder numbers
    std::random_device rd;
    std::mt19937 g(rd());
    std::shuffle(denominators.begin(), denominators.end(), g);

    T sum = static_cast<T>(0);
    T c = static_cast<T>(0);

    for (const std::size_t &n : denominators)
    {
        T current_term = static_cast<T>(1) / static_cast<T>(n);
        T y = current_term - c; // In exact math, c is always 0!
        T t = sum + y;          // sum is "big" and y is "small"
        c = (t - sum) - y;      // c is approximately the floating error
        sum = t;                // but is itself a floating point number
    }
    return sum;
}

// Print out the sums using each of the methods
// for the provided type
template <class T>
void print_sums(const std::size_t &n_terms)
{
    // set the cout precision to match the datatype
    std::cout.precision(std::numeric_limits<T>::digits10);
    // compute and print the sums
    std::cout << "\t forward sum      : " << forward_series<float>(n_terms) << std::endl;
    std::cout << "\t reverse sum      : " << reverse_series<float>(n_terms) << std::endl;
    std::cout << "\t Kahan sum        : " << kahan_series<float>(n_terms) << std::endl;
    std::cout << "\t random sum       : " << random_series<float>(n_terms) << std::endl;
    std::cout << "\t random Kahan sum : " << random_kahan_series<float>(n_terms) << std::endl;
}

int main()
{

    // create a timer
    Timer::Timer main_timer("Main");

    // check precision by calculating pi
    std::cout.precision(std::numeric_limits<float>::digits10);
    double PIf = acos(-1.0F); // the F after 1.0 indicates to use float precision
    std::cout << "PIf " << sizeof(float) << " :  " << PIf << std::endl;

    std::cout.precision(std::numeric_limits<double>::digits10);
    double PId = acos(-1.0);
    std::cout << "PId " << sizeof(double) << " :  " << PId << std::endl;

    std::cout.precision(std::numeric_limits<long double>::digits10);
    long double PIl = std::acos(-1.0L); // the L after 1.0 indicates to use long double precision
    std::cout << "PIl " << sizeof(long double) << " : " << PIl << std::endl;

    std::vector<std::size_t> n_terms = {100, 500, 1000, 2000, 5000, 10000, 100000, 1000000, 10000000};

    // loop over the elements of n_terms and try summing that number of terms
    for (const auto &terms : n_terms)
    {
        std::cout << std::endl
                  << "Computing sum (1/n) with " << terms << " terms" << std::endl;
        std::cout << "=========================================" << std::endl;
        std::cout << "Float: " << std::endl;
        Timer::Timer float_timer("Float timer");
        print_sums<float>(terms);
        float_timer.stop();

        std::cout << "Double: " << std::endl;
        Timer::Timer double_timer("Double timer");
        print_sums<double>(terms);
        double_timer.stop();

        Timer::Timer long_double_timer("Long double timer");
        std::cout << "Long double: " << std::endl;
        print_sums<long double>(terms);
        long_double_timer.stop();
    }

    // print out some timing info
    main_timer.stop();
    main_timer.printStats();
    // main_timer.printDebugVariables();

    return 0;
}