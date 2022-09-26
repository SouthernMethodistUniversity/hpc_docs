/*
 Functions, References, and Pointers

 Useful References:
 * Discovering Modern C++ by Peter Gottschling (amongst many other C++ books)
 * https://en.cppreference.com/
*/

#include <iostream> // standard IO
#include <vector>   // standard "vector" library for dynamic arrays
#include <array>    // standard "array" library for static arrays
#include <memory>   // For different pointer types, e.g. smart pointers

/*

  The general form of a function in C++ is the following:

  [inline] return_type function_name (argument_list)
  {
    body of the function
  }

  From left to right, inline (and other compiler hints and directives) are
  optional and come first. Then the return type, which can typically be any
  datatype, object, or void to return nothing, which is followed by the
  function name. Finally, all arguments to the function are given in a list.

*/

// Function arguments can be passed by value, reference, or pointer.
// The resulting behavior in the function and surrounding code change
// based on that choice.
//
// Pass by value
//
// When you pass by value, the function makes a copy of the input variable
// and uses that copy. When the function completes, the copy will be deleted
// and the original value will be unchanged
//
// Pass by reference
//
// When passing by reference, the function uses the same variable inside the
// function as the input. This means that any changes made to that variable
// will persist after the function is complete
//
// Pass by pointer
//
// You can also pass values using a pointer, which "points" to a specific
// location in memory. Since the memory location is the same inside and
// outside the function, changes to the memory the variable points to
// will persist after the function is complete
//
// Which one should you chose? It depends. For things that are "small"
// like ints, doubles, etc. It doesn't matter too much.
// For large data objects (like a large array), copying the entire array
// may require significantly more resources (time, memory, etc.) So a
// reference or pointer is a better choice.
//
// As an aside. Pointers are the "old" C-style why of doing things. In
// most cases it is better to use a reference. The code is clearer and
// it usually also better for memory management reasons. If you need
// to use pointers, it is usually better to use a smart pointer,
// shared pointer, unique pointer, etc than the C-style pointer.

// pass an int by value. Increment the value in the
// function.
// Expect to see (a+1) inside function, but outside function
// a remains the initial value
// return type = void (no return)
void increment_by_value(int a)
{
  ++a; // this is a copy of the input
  std::cout << "a in function is: " << a << std::endl;
};

// Pass value by reference instead
void increment_by_reference(int &a)
{
  ++a; // this is the same as the input
  std::cout << "a in function is: " << a << std::endl;
};

// pass by points
void increment_by_pointer(int *a)
{
  ++(*a); // this is the same memory location as input
  std::cout << "a in function is: " << *a << std::endl;
};

// arguments to functions can either be mutable (meaning they can change)
// or constant (meaning they cannot be changed by the function)
// Pass by value is automatically constant because the function operates
// on a copy and can't modify the input.
double mutable_compute_norm_squared(std::vector<double> &v)
{
  double solution = 0;
  // loop over each element in the vector
  for (const auto &element : v)
  {
    solution += element * element;
  }

  // add the solution to the vector to show it can change
  v.push_back(solution);

  // return the result
  return solution;
}

double const_compute_norm_squared(const std::vector<double> &v)
{
  double solution = 0;
  // loop over each element in the vector
  for (const auto &element : v)
  {
    solution += element * element;
  }

  // this would cause a compiler error because we
  // cannot change v
  // v.push_back(solution);

  // return the result
  return solution;
}

// We can add default arguments functions.
// Any inputs with a default must be listed last
// This will optionally print the answer from inside the function,
// defaulting to false
double compute_area(const double &radius, bool print = false)
{
  // NOTE: M_PI is defined in most compilers, but not all so use with care
  const double pi = 3.1415926535897932384;
  double area = pi * radius * radius;

  if (print)
  {
    std::cout << "Inside function, area = " << area << std::endl;
  }

  return area;
}

// Overloading.
//
// C++ allows you to have multiple functions with the same name
// as long as the argument list is different.
double add_numbers(int a, int b)
{
  std::cout << "example 1 \n";
  return a + b;
}
double add_numbers(double a, double b)
{
  std::cout << "example 2 \n";
  return a + b;
}
double add_numbers(double a, float b, int c)
{
  std::cout << "example 3 \n";
  return a + b + c;
}
double add_numbers(int a, double b, float c)
{
  std::cout << "example 4 \n";
  return a + b + c;
}

// changing the return type, but not the arguments
// will cause errors
// int add_numbers(int a, double b, float c)
//{
//  return a + b + c;
//}
//
// Similarly, chaning whether the functions are pass by value
// or pass by reference, etc. will cause errors because they
// compiler won't be able to tell which on you wanted.

int main(int argc, char *argv[])
{

  // The main function is special. argv contains a list of command line arguments
  // and argc is the number of arguments. On most systems, there is always 1 argument,
  // the function name
  // print out arguments
  for (int i = 0; i < argc; ++i)
  {
    std::cout << "argument " << i << " = " << argv[i] << std::endl;
  }
  std::cout << "/n/n";

  int i = 4;

  std::cout << "i = " << i << std::endl;

  std::cout << "\nincrement by value" << std::endl;
  increment_by_value(i);
  std::cout << "after function call, i = " << i << std::endl;

  std::cout << "\nincrement by reference" << std::endl;
  increment_by_reference(i);
  std::cout << "after function call, i = " << i << std::endl;

  std::cout << "\nincrement by pointer" << std::endl;
  increment_by_pointer(&i);
  std::cout << "after function call, i = " << i << std::endl;

  // note, this will result in a compiler error
  // increment_by_reference(i + 7);

  // Create a vector containing doubles
  std::vector<double> v = {7, 5, 16, 8}; // list initialized requires c++11 or later

  // compute norm squared
  std::cout << "norm squared: " << mutable_compute_norm_squared(v) << std::endl;
  std::cout << "norm squared: " << const_compute_norm_squared(v) << std::endl;

  // computing the area of a circle
  std::cout << "\nArea of a circle (r = 1) with default args: \n"
            << compute_area(1.0) << std::endl;
  std::cout << "Area of a circle (r = 1) with print = true: \n"
            << compute_area(1.0, true) << std::endl;

  // call overloaded functions
  int a = 2;
  float b = 3;
  double c = 9;

  std::cout << "\nadd_numbers(int, int):  (expect example 1) " << add_numbers(a, a) << std::endl;
  std::cout << "add_numbers(double, double):  (expect example 2) " << add_numbers(c, c) << std::endl;
  std::cout << "add_numbers(double, float, int):  (expect example 3) " << add_numbers(c, b, a) << std::endl;
  std::cout << "add_numbers(int, double, float):  (expect example 4) " << add_numbers(a, c, b) << std::endl;

  // these will work because ints and floats can be promoted to doubles
  std::cout << "add_numbers(float, flaot):  (expect example 2) " << add_numbers(b, b) << std::endl;
  std::cout << "add_numbers(float, int, int):  (expect example 3) " << add_numbers(b, a, a) << std::endl;

  // this will not work becasue we can't convert a float or double to an int (without casting first)
  // compiler error
  // std::cout << "add_numbers(double, double, double): " << add_numbers(c, c, c) << std::endl;

  return 0;
}