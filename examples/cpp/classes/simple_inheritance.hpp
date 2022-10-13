/*
 Simple demonstration of classes and inheritance

 Useful References:
 * Discovering Modern C++ by Peter Gottschling (amongst many other C++ books)
 * https://en.cppreference.com/
*/

// This is a header file, so we want to enure if only gets
// included once in the code so we don't end up with multiple
// redefinitions of the same functions in a project.
// On way to do this is to define a uniquely named variable
// using the prepocessor. Here, we name a variable "_SIMPLE_INHERITANCE_H_"
// If that variable is already defined, then nothing happens.
// Otherwise, we define it and the code defining the class is
// used.
#ifndef _SIMPLE_INHERITANCE_H_
#define _SIMPLE_INHERITANCE_H_

// Next we'll define a namespace. We don't technically have to
// do this, but we might want to use other libraries that have
// the same function or object names, so this will let us
// use both
namespace smu_demo_namespace
{

    // Now we'll declare our first class in our smu_demo_namespace
    // A class is an object that can container variables, objects,
    // and functions.
    //
    // This is a simple class to define some properties of 2D shapes
    class ShapeProperties
    {
        // in a class functions, variables, and objects
        // can be private, public, or protected
        //
        // private means only other members of this class
        // can modify or call
        //
        // protected means that other classes that this is
        // a sub class (also commonly called child) can modify
        // or call
        //
        // public means anything can modify or call.

        // we'll say that out shape has a few properties,
        // namely perimeter and area. These will be protected
        // because we're going to want anohter class to be
        // able to change them.
    protected:
        // everything below this is protected until we get
        // to another designation
        double m_area;
        double m_perimeter;

        // we might want to be able to print this values out,
        // so we'll make some functions. In order to call these
        // functions outside of the class, we need to make them
        // public
    public:
        // the const after the function tells the compiler
        // that these functions will not modify any of the
        // variables or objects in this class. They are
        // only returning a copy of the values.
        double getArea() const;
        double getPerimeter() const;

    }; // notice the the class ends with ;

    // Now we have a shape class, but it's not really usable.
    // What shape is it? A triangle, square, circle ...
    // We can use the shape class above as a base to define
    // specific shapes
    class Triangle : public ShapeProperties
    {
        // a triangle has 3 sides so we'll want
        // variables to hold those lengths
    private:
        double m_side1;
        double m_side2;
        double m_side3;

    public:
        // classes create objects using constructors
        // The compiler will make a default constructor with no
        // arguments (that doesn't set anything). So we'll make
        // our own.
        // First a default constructor with no arguments ... when
        // we define this, we'll set all the sides to 1 by default
        // Second, we'll make constructor that takes 3 sides lenghts
        //
        // The constructor is always named the same as the class
        Triangle();
        Triangle(const double &s1, const double &s2, const double &s3);

        // we might want some helper functions to compute area and
        // perimeter. These only need to be called by other members
        // of the class, so we'll make them private
    private:
        void computeArea();
        void computePerimeter();
    };

    class Circle : public ShapeProperties
    {
        // we just need a radius
        // we'll make this const so it can't be changed
    private:
        const double m_radius;

    public:
        // classes create objects using constructors
        // The compiler will make a default constructor with no
        // arguments (that doesn't set anything). So we'll make
        // our own.
        // First a default constructor with no arguments ... when
        // we define this, we'll set the radius to 1 by default
        // Second, we'll make constructor that takes 1 radius arg
        //
        // The constructor is always named the same as the class
        Circle();
        Circle(const double &r);

        // we might want some helper functions to compute area and
        // perimeter. These only need to be called by other members
        // of the class, so we'll make them private
    private:
        void computeArea();
        void computePerimeter();
    };

    class Rectangle : public ShapeProperties
    {
        // We need the 2 side lengths
    private:
        double m_side1;
        double m_side2;

    public:
        // classes create objects using constructors
        // The compiler will make a default constructor with no
        // arguments (that doesn't set anything). So we'll make
        // our own.
        // First a default constructor with no arguments ... when
        // we define this, we'll set both sides to 1 by default
        // Second, we'll make constructor that takes the 2 side
        // lengths as arguments

        // The constructor is always named the same as the class
        Rectangle();
        Rectangle(const double &s1, const double &s2);

        // we might want some helper functions to compute area and
        // perimeter. These only need to be called by other members
        // of the class, so we'll make them private
    private:
        void computeArea();
        void computePerimeter();
    };

    // A square is a special case of a rectangle
    class Square : public Rectangle
    {

    public:
        // classes create objects using constructors
        // The compiler will make a default constructor with no
        // arguments (that doesn't set anything). So we'll make
        // our own.
        // First a default constructor with no arguments ... when
        // we define this, we'll set the sides to 1 by default
        // Second, we'll make constructor that takes the a side
        // length as arguments

        // The constructor is always named the same as the class
        Square();
        Square(const double &s);
    };

} // namespace smu_demo_namespace

// End the preprocessor header guard if / else
// I like to add a comment after it refering to the variable it set
#endif //_SIMPLE_INHERITANCE_H_