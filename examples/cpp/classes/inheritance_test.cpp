/*
 Simple demonstration of classes and inheritance

 This file runs the classes declared in
 simple_inheritance.hpp and implemented in simple_inheritance.cpp

 Useful References:
 * Discovering Modern C++ by Peter Gottschling (amongst many other C++ books)
 * https://en.cppreference.com/
*/

#include <iostream> // for IO (we could use the fmt library)

// include our class declarations
#include "simple_inheritance.hpp"

int main()
{

    // use our namespace so we don't need to append
    // everything with smu_demo_namespace::
    using namespace smu_demo_namespace;

    // Create a triangle:
    Triangle default_triagle;

    // print out area and perimenter
    std::cout << "The default triangle has area: "
              << default_triagle.getArea()
              << " and perimeter: "
              << default_triagle.getPerimeter()
              << std::endl;

    // Create an invalid triangle.
    try
    {
        Triangle bad_triangle(-2, 1, 3);
        std::cout << "The bad triangle has area: "
                  << default_triagle.getArea()
                  << " and perimeter: "
                  << default_triagle.getPerimeter()
                  << std::endl;
    }
    // const std::exception &e covers all types of polymorphic exceptions,
    // but if we wanted to handle different types we could
    // be more precise (here we know it is std::invalid_argument)
    // we can also use (...) as a catchall for any thrown value
    catch (const std::exception &e)
    {
        // print out the error
        // usually you stop the program after an error, but we'll keep going
        std::cerr << "bad triangle: " << e.what() << std::endl;
    }

    try
    {
        Triangle bad_triangle2(2, 1, 5);
        std::cout << "The second bad triangle has area: "
                  << default_triagle.getArea()
                  << " and perimeter: "
                  << default_triagle.getPerimeter()
                  << std::endl;
    }
    // const std::exception &e covers all types of polymorphic exceptions,
    // but if we wanted to handle different types we could
    // be more precise (here we know it is std::invalid_argument)
    // we can also use (...) as a catchall for any thrown value
    catch (const std::exception &e)
    {
        // print out the error
        // usually you stop the program after an error, but we'll keep going
        std::cerr << "bad triangle 2: " << e.what() << std::endl;
    }

    // Create a circle:
    Circle default_circle;

    // print out area and perimenter
    std::cout << "The default circle has area: "
              << default_circle.getArea()
              << " and perimeter: "
              << default_circle.getPerimeter()
              << std::endl;

    Circle test_circle(2);

    // print out area and perimenter
    std::cout << "The test circle has area: "
              << test_circle.getArea()
              << " and perimeter: "
              << test_circle.getPerimeter()
              << std::endl;

    // Create a rectangle:
    Rectangle default_rec;

    // print out area and perimenter
    std::cout << "The default rectangle has area: "
              << default_rec.getArea()
              << " and perimeter: "
              << default_rec.getPerimeter()
              << std::endl;

    Rectangle rect(2, 3);

    // print out area and perimenter
    std::cout << "The rectangle has area: "
              << rect.getArea()
              << " and perimeter: "
              << rect.getPerimeter()
              << std::endl;

    Square default_square;

    // print out area and perimenter
    std::cout << "The default square has area: "
              << default_square.getArea()
              << " and perimeter: "
              << default_square.getPerimeter()
              << std::endl;

    Square square(3);
    std::cout << "The square has area: "
              << square.getArea()
              << " and perimeter: "
              << square.getPerimeter()
              << std::endl;

    // You can use the base class as a datetype for
    // one of its children
    ShapeProperties shape;
    shape = Square(7);
    std::cout << "The shape has area: "
              << shape.getArea()
              << " and perimeter: "
              << shape.getPerimeter()
              << std::endl;
}