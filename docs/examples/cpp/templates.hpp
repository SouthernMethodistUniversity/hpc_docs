/**
 \brief Overview of C++ templates

 Useful References:
 * Discovering Modern C++ by Peter Gottschling (amongst many other C++ books)
 * https://en.cppreference.com/
*/

// This is a header file, so we want to enure if only gets
// included once in the code so we don't end up with multiple
// redefinitions of the same functions in a project.
// On way to do this is to define a uniquely named variable
// using the prepocessor. Here, we name a variable "_SMU_TEMPLATES_H_"
// If that variable is already defined, then nothing happens.
// Otherwise, we define it and the code defining the class is
// used.
#ifndef _SMU_TEMPLATES_H_
#define _SMU_TEMPLATES_H_

// Includes
#include <iostream> // for cout

// Templates are a way to reduce and optimize code
// The basic use allows us to right a single function
// that operates on multiple data types automatically.
// For example, you might have noticed that C++ STL
// has a single std::abs, unlike C, where you have to
// choose from abs, fabs, etc based on the type.
// The other feature of templated functions is that
// they are expanded at compile time, which can
// drastically impact performance in many cases.
// This is how linear algebra libraries like eigen
// and armadillo are able to combine multiple
// operations into 1.

// enter our namespace
namespace smu_demo_namespace
{

    // template functions and objects start with
    // "template <...>" directive followed by a
    // a function or object declaration
    //
    // Here, we'll create a template over a type
    // which we'll call T. (You can change T to
    // any name you like).
    //
    // Our function will take 2 arguments of
    // as of now unknown type T and return
    // a type T value
    //
    // We'll define this function in place.
    // Note: in most cases templates need to
    // be declared AND defined in header files.
    //
    // If you define templated functions or objects
    // in a compiler file, you need to 
    // explicity instantiate the function(s) in the
    // compiled file so the compiler knows what
    // versions to build
    // e.g.
    // template custom_max<int>
    // template custom_max<double>
    // ... etc
    // Note, you only have to define the function
    // once, this just tells the compiler to 
    // make those variants
    template <typename T>
    T custom_max(const T &a, const T &b)
    {
        // This will work for any type that
        // has the > operator.
        //
        // WARNING: there is also some subtle danger
        // in using a ternary operator with unknown
        // types.
        //
        // The reason this might be an issue is that in C++
        // the type of the ELSE statement is inferred from
        // the type of the THEN expression such that both match.
        // If a and b are different types (which is technically
        // possible here from polymorphism), then b will be
        // converted to the type of a, which may not be desired
        //
        // This can be avoided by using if {} else {} blocks
        return (a > b) ? a : b;
    }

    // Instead of types, we can also create templates based on numerical
    // values. In scientific codes, it is common to see this particulary
    // to specify dimensions (1d, 2d, 3d, 4d, ..., nd)
    //
    // Here, we specify the template argument is an int and set the default
    // to 3. We also specify a type argument
    template <typename T, int DIM = 3>
    class DumbVector
    {

    private:
        T m_data[DIM]; // create an array of the specified dimension and type

        // just some basic getters / setters. We'll use the default constructors
    public:
        // function to set the values based on index
        // we'll define this here.
        void setByIndex(const std::size_t &i, const T &val)
        {
            if (i < DIM)
            {
                m_data[i] = val;
            }
            else
            {
                std::cerr << "Tried to set data outside range" << std::endl;
            }
        };

        // function to print ... we'll define this below
        void print() const;

    }; // end class

    // define print function from class
    // note we need the template directive (with no defaults)
    // and the function is a member of the DumbVector class
    // with template args <T,DIM>
    template <typename T, int DIM>
    void DumbVector<T, DIM>::print() const
    {
        for (std::size_t i = 0; i < DIM - 1; ++i)
        {
            std::cout << m_data[i] << ", ";
        }
        std::cout << m_data[DIM - 1] << std::endl;
    }

    // We can use templates to compute expressions at compile
    // time. For instance, these functions will expand and compute
    // x1 * x2 * x3 * ... * xn if we call our function like
    // multiply(x1 * x2 * x3 * ... * xn )

    // we need a function to return the last entry
    template <typename T>
    T multiply(const T &x1)
    {
        return x1;
    }

    // split the first value from the rest
    template <typename T, typename... Types>
    T multiply(const T &x1, Types... xn)
    {
        return x1 * multiply(xn...);
    }

    
}

#endif //_SMU_TEMPLATES_H_