/*
 Simple demonstration of class to implement mathematical vectors

 Useful References:
 * Discovering Modern C++ by Peter Gottschling (amongst many other C++ books)
 * https://en.cppreference.com/
*/

// This is a header file, so we want to enure if only gets
// included once in the code so we don't end up with multiple
// redefinitions of the same functions in a project.
// On way to do this is to define a uniquely named variable
// using the prepocessor. Here, we name a variable "_SIMPLE_VECTOR_H_"
// If that variable is already defined, then nothing happens.
// Otherwise, we define it and the code defining the class is
// used.
#ifndef _SIMPLE_VECTOR_H_
#define _SIMPLE_VECTOR_H_

// for C++ vectors ... these are arrays not math vectors
#include <vector>

// Next we'll define a namespace. We don't technically have to
// do this, but we might want to use other libraries that have
// the same function or object names, so this will let us
// use both
namespace smu_demo_namespace
{

    // We'll make a class named Vector
    class Vector
    {

        // I like to define all of my member variables
        // at the top of a class. This is a style
        // preference
        //
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
        //
        // Generally speaking, all variables should either
        // be private or protected. The idea is that if you
        // need to access data in this class it should be
        // through a function and not directly.

    private:
        // an array to contain the elements of our vector
        // its under the private heading because nothing outside
        // our class should be able to access it directly
        std::vector<double> m_data;

        // Next we can declare the functions. For this, almost
        // everything will be public because we want to be
        // able to call them, but it is common to have private
        // or protected helper functions that you do not want
        // to be calld directly

        // We'll have a private function to check sizes

    public:
        // Constructors sets default arguments. The compiler automatically
        // makes one that doesn't do anything, but we'll want to initialize
        // our data with a constructor. We'll default to setting the vector
        // to 0 with the specified number of elements.
        // The name of the constructor always matches the name of the class
        Vector(const std::size_t &num_elements = 3);

        // There is always a destructor as well to free memory. We don't need
        // it here, but it's always good to define a virtual destructor
        // in case someone uses this class for something else
        // virtual means it can be redfined.
        // The name is always ~ClassName
        virtual ~Vector(){};

        // now we can define some vector functions, we might want to
        //
        // 1. add 2 vectors
        // 2. compute a dot product
        // 3. compute the norm
        // 4. access elements so we can modify values
        // 6. reset the vector a single value (e.g 0 or 1)
        // 7. normalize the vector
        // etc.
        // We won't implement every possible thing we might want,
        // but just a few to demonstrate the idea

        // First lets define some functions to add vectors
        void add(const Vector &b);      
        void operator+(const Vector &b); 

        // for case 2 to work, we also need to define
        // an = operator
        void operator=(const Vector &b);

        // compute a dot product
        // we shouldn't modify the data so we add const
        double dot(const Vector &b) const;

        // compute the norm
        double norm() const;

        // functions to access elements / change values
        // the first will let us change the value, the
        // second will not
        // The next 2 are the same ... but using the []
        // operator
        double &get(const std::size_t &index);
        double get(const std::size_t &index) const;
        double &operator[](const std::size_t &index);
        double operator[](const std::size_t &index) const;

        // function to set all the values of the vector to
        // something
        void setAllValues(const double &val);

        // function to normalize the vector
        void normalize();

        // function to print the vector
        void print() const;

        // function to get the number of elements
        std::size_t numElements() const;

    private:
        // function to check sizes
        void check_sizes(const Vector &b) const;

    }; // notice this ends with ;

} // smu_demo_namespace

// End the preprocessor header guard if / else
// I like to add a comment after it refering to the variable it set
#endif //_SIMPLE_VECTOR_H_