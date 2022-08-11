#include <iostream>  // standard IO
#include <vector>    // STL arrays
#include <limits>    // get number of digits based on datatype
#include <iomanip>   // for setprecision
#include <numeric>   // for iota, create array of 1 to n
#include <random>    // random number generators
#include <algorithm> // for std::shuffle, random vector order
#include <cmath>     // for acos

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
    T sum = 0;
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
    T sum = 0;
    for (std::size_t n = n_terms; n > 0; --n)
    {
        sum += static_cast<T>(1) / static_cast<T>(n);
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
    //  create a vector of numbers 1 to nterms
    std::vector<std::size_t> denominators(n_terms);
    std::iota(denominators.begin(), denominators.end(), 1);

    // randomly reorder numbers
    std::random_device rd;
    std::mt19937 g(rd());
    std::shuffle(denominators.begin(), denominators.end(), g);

    T sum = 0;
    for (const std::size_t &n : denominators)
    {
        // the static_cast is to convert std::size_t
        // to the desired type before we do any math
        sum += static_cast<T>(1) / static_cast<T>(n);
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
    std::cout << "\t forward sum: " << forward_series<float>(n_terms) << std::endl;
    std::cout << "\t reverse sum: " << reverse_series<float>(n_terms) << std::endl;
    std::cout << "\t random sum : " << random_series<float>(n_terms) << std::endl;
}

int main()
{

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
        print_sums<float>(terms);
        std::cout << "Double: " << std::endl;
        print_sums<double>(terms);
        std::cout << "Long double: " << std::endl;
        print_sums<long double>(terms);

    }

    return 0;
}