/*
 Simple demonstration of classes and inheritance

 This file defines (implements) the classes declared in
 simple_inheritance.hpp

 Useful References:
 * Discovering Modern C++ by Peter Gottschling (amongst many other C++ books)
 * https://en.cppreference.com/
*/

#include <cmath>     // trig functions, square root function
#include <stdexcept> // so we can "throw" errors for bad inputs

// include our header
// use quotes for local header files
#include "simple_inheritance.hpp"

// next we'll enter out namespace so we don't have to prefix
// everything with it

namespace smu_demo_namespace
{

    // define a helper constexpr function to return pi
    constexpr double pi() { return 3.14159265358979323846; }

    // define the properties class. We just need to define the
    // get perimenter and get area functions
    // They're inside the class, so we prefix with the class
    // name
    double ShapeProperties::getArea() const
    {
        return m_area;
    }

    double ShapeProperties::getPerimeter() const
    {
        return m_perimeter;
    }

    // For the default triangle constructor, we'll just call the constructor
    // with 3 arguments in the initialization list
    Triangle::Triangle() : Triangle(1, 1, 1){};

    // for the constructor that takes arguments, we'll set the sides to those
    // values
    Triangle::Triangle(const double &s1, const double &s2, const double &s3) : ShapeProperties()
    {

        // We can't just pick any side lengths for a triangle, so we should
        // check to see if they're valid
        // They should all be positive
        // They should satisfy the triangle innequality a + b > c
        if (s1 <= 0 || s2 <= 0 || s3 <= 0)
        {
            // throw an error with a descriptive message
            throw std::invalid_argument("Side lengths of a triangle should be positive!");
        }

        if ((s1 + s2 < s3) || (s1 + s3 < s2) || ((s2 + s3 < s1)))
        {
            // throw an error with a descriptive message
            throw std::invalid_argument("Side lengths cannot form a trianlge");
        }

        // we'll set the side lengths to the input values
        m_side1 = s1;
        m_side2 = s2;
        m_side3 = s3;

        // Now we'll compute the area and perimenter
        // (these functions are going to be defined
        // below)
        computeArea();
        computePerimeter();
    }

    // Now define the funciton to compute the area of a triangle
    void Triangle::computeArea()
    {
        // Since we only know the side lengths, we'll use
        // Heron's formula (https://en.wikipedia.org/wiki/Heron%27s_formula)
        // note we have access to m_area because it's a protected member
        // of ShapeProperties and we inheritted it
        double s = 0.5 * (m_side1 + m_side2 + m_side3);
        m_area = std::sqrt(s * (s - m_side1) * (s - m_side2) * (s - m_side3));
    }

    // Function to compute the perimeter of a triangle
    void Triangle::computePerimeter()
    {
        // note we have access to m_perimeter because it's a protected member
        // of ShapeProperties and we inheritted it
        m_perimeter = m_side1 + m_side2 + m_side3;
    }

    // Now define the Circle class.
    Circle::Circle() : Circle(1.0){};

    // since m_radius is a const, we have to set it in the initialization
    // list
    Circle::Circle(const double &r) : ShapeProperties(),
                                      m_radius(r)
    {
        // We want to make sure the radius is positive
        if (r <= 0)
        {
            // throw an error with a descriptive message
            throw std::invalid_argument("Radii of circle should be positive!");
        }

        // Now we'll compute the area and perimenter
        // (these functions are going to be defined
        // below)
        computeArea();
        computePerimeter();
    }

    // Functions to compute area and perimeter of the circle
    void Circle::computeArea()
    {
        m_area = pi() * m_radius * m_radius;
    }
    void Circle::computePerimeter()
    {
        m_perimeter = 2 * pi() * m_radius;
    }

    // Define the rectangle constructors
    Rectangle::Rectangle() : Rectangle(1.0, 1.0){};

    Rectangle::Rectangle(const double &s1, const double &s2) : ShapeProperties()
    {
        // side lengths of a rectangle should be positive
        if (s1 <= 0 || s2 <= 0)
        {
            // throw an error with a descriptive message
            throw std::invalid_argument("Sides of a rectangle should be positive!");
        }

        m_side1 = s1;
        m_side2 = s2;

        // Now we'll compute the area and perimenter
        // (these functions are going to be defined
        // below)
        computeArea();
        computePerimeter();
    }

    // Compute area and perimeter of rectangle
    void Rectangle::computeArea()
    {
        m_area = m_side1 * m_side2;
    }
    void Rectangle::computePerimeter()
    {
        m_perimeter = 2 * (m_side1 + m_side2);
    }

    // Finally, for a square, we're just going to call the Rectangle
    // class
    Square::Square() : Square(1.0){};
    Square::Square(const double &s) : Rectangle(s, s){};

} // smu_demo_namespace