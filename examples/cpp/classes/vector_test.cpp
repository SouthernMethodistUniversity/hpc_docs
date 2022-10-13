/*
 Simple demonstration of our vector class

 This file runs the classes declared in
 vector_class.hpp and implemented in vector_class.cpp

 Useful References:
 * Discovering Modern C++ by Peter Gottschling (amongst many other C++ books)
 * https://en.cppreference.com/
*/

#include <iostream>  // for IO
#include <exception> // for throwing exceptions
#include "vector_class.hpp"

int main()
{

    // use our namespace
    using namespace smu_demo_namespace;

    // create 3 vectors
    Vector a, b, c;

    // set a to (1, 2, 3)
    a[0] = 1;
    a.get(1) = 2;
    a[2] = 3;

    std::cout << "a: " << std::endl;
    a.print();

    // set b to (4, 5, 6)
    b.get(0) = 4;
    b[1] = 5;
    b.get(2) = 6;
    std::cout << "b: " << std::endl;
    b.print();

    // print c
    std::cout << "c: " << std::endl;
    c.print();

    // add b to a
    a + b;
    std::cout << "a: " << std::endl;
    a.print();

    c = a;
    std::cout << "c: " << std::endl;
    c.print();

    for (int i = 0; i < c.numElements(); ++i)
    {
        c[i] = 1;
    }
    std::cout << "c: " << std::endl;
    c.print();

    std::cout << "c norm: " << c.norm() << std::endl;
    std::cout << "normalized c:" << std::endl;
    c.normalize();
    c.print();

    std::cout << "c dot c: " << c.dot(c) << std::endl;

    Vector d(4);

    // this should cause an error, but we can catch it
    // by wrapping it in a try / catch block
    try
    {
        c.dot(d);
    }
    catch (const std::exception &e)
    {
        // print out the error
        // usually you stop the program after an error, but we'll keep going
        std::cerr << e.what() << std::endl;
    }

    return 0;
}
