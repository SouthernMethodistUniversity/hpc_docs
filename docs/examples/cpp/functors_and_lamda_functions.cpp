/*
 Functors and Lambda Functions

 Useful References:
 * Discovering Modern C++ by Peter Gottschling (amongst many other C++ books)
 * https://en.cppreference.com/
*/

#include <iostream> // standard IO
#include <vector>   // standard "vector" library for dynamic arrays
#include <algorithm> // for the transform functions


/*

A functor is essentially a class that has defined the "()" operator.

This lets us define objects that behave like functions.

There are 2 main reasons we might want a function like object:

  1.  function like object allow us to define, use, and modify
      properties, for instance the current state of an object.
      In some applications this may be valueable and simplify
      the code (e.g. the function "knows" informatin that you
      would otherwise have to pass to the function.) This also
      allows you to initialize frequently used values once,
      which is especially useful if they're expensive to compute.

  2.  By using a functor, the compiler is often able to do a
      better job optimizing. Essentially this happens because
      the compiler knows exactly what function is being called,
      whereas if you pass a pointer to a function, the compiler
      just knows a function is being called (but not necessarily
      which one.) This means, for example, the compiler might
      inline a functor.

*/

// example of a simple functor
// You see functors defined as structs instead of classes, classes are
// more general structure with extra features (that we're not using)
class increment
{
private:
    // define a private member variable to hold the amount we will
    // increment by
    // It is common practice to prepend member variables with "m_"
    // but this is purely a style choice.
    int m_increment_amount;

public:

    // constructor. This sets the default values.
    // This needs to be the same name as the class
    // Note we can overload the constructor. Here,
    // we're setting the increment amount to 1 if we're
    // not provided an argument or we're setting it
    // to the inputed value.
    increment() : m_increment_amount(1){};
    increment(const int &n) : m_increment_amount(n){};

    // Now we're going to define the "()" operator 
    // so we can increment the input and return the
    // new value
    int operator()(const int& input_num) const
    {
        // add the increment amount to the inputed value
        // and return that new value
        return m_increment_amount + input_num;
    }

    void changeIncrementAmount(const int &inc) {
        m_increment_amount = inc;
    }
}; // end of increment class. Note, ends with ;


// function to print vectors
void print_vector(const std::vector<int>& v) 
{
    for (const auto& val: v) {
        std::cout << val << ", ";
    }
    std::cout << std::endl;
}


int main() {

    // create an array of values to increment
    std::vector<int> v = {1, 2, 3, 4, 5}; // list initialized requires c++11 or later

    // use our increment functor to add 1
    increment inc_by_one; // initialize the functor with the default 
    for (auto &val : v) {
        val = inc_by_one(val);
    }
    print_vector(v);

    // use our increment functor to subtract 1
    increment dec_by_one(-1); // initialize the functor to subtract one
    for (auto &val : v)
    {
        val = dec_by_one(val);
    }
    print_vector(v);

    // use our increment functor to add 2 to each value using the
    // std::transform function
    //
    // There is a subtlety here. The increment(2) argument here is
    // calling the constructor and setting the increment value. 
    // Inside the transform function, it is calling v[i] = incremnt(v[i])
    std::transform(v.begin(), v.end(), v.begin(), increment(2));
    print_vector(v);

    // subtract 2 from each entry
    std::transform(v.begin(), v.end(), v.begin(), increment(-2));
    print_vector(v);

    // The functor we defined above is a lot of work for something that
    // is pretty trivial (and might be even more work if the function
    // object needed to be more complex).
    //
    // Since C++11, C++ has "lambda expressions," which is basically
    // a way for the compiler to generate a functor for you using some
    // shorthand notation

    // Make a lambda function that adds 1
    // auto requires c++14
    // the [&] specifies we should capture values by reference
    // we could also capture by value, pointer, etc.
    // Then the inputs are in (...), we're taking an int
    // Finally, we define the function in {...} (just returning input + 1)
    auto add_one_lambda = [&](const int& val){return val + 1;};
    std::transform(v.begin(), v.end(), v.begin(), add_one_lambda);
    print_vector(v);

    // subtract 1 using lambdas
    auto dec_one_lambda = [&](const int &val){ return val - 1; };
    std::transform(v.begin(), v.end(), v.begin(), dec_one_lambda);
    print_vector(v);

    // We can also use lambda functions inline. Here, we'll add 2
    // Again, for style preferences, I find it easier to read lambda expressions
    // if they're defined like the above. This example is inline and extactly the
    // same, but more complicated expressions may be difficult to read.
    std::transform(v.begin(), v.end(), v.begin(), [&](const int &val){ return val + 2; });
    print_vector(v);

    // and subtract 3
    std::transform(v.begin(), v.end(), v.begin(), [&](const int &val){ return val - 3; });
    print_vector(v);
}