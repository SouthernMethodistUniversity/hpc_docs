/*
 Simple demonstration of class to implement mathematical vectors

 This file defines (implements) the classes declared in vector_class.hpp


 Useful References:
 * Discovering Modern C++ by Peter Gottschling (amongst many other C++ books)
 * https://en.cppreference.com/
*/

#include <cmath>     // for std::sqrt
#include <iostream>  // for IO
#include <exception> // for throwing exceptions
#include "vector_class.hpp"

// enter our namespace
namespace smu_demo_namespace
{

    // Start by defining our constructor
    // Since all these functions are inside the class
    // we need to address them with ClassName::foo
    // Notice we set a default value in the declaration in the
    // header and omit it here
    Vector::Vector(const std::size_t &num_elements)
    {
        // initialize our array to be all zeros
        m_data.assign(num_elements, 0.0);
    }

    // define our adding operators
    void Vector::add(const Vector &b)
    {

        // use our private helper function to
        // make sure the sizes match
        check_sizes(b);

        for (std::size_t i = 0; i < numElements(); ++i)
        {
            // the .at() checks bounds unless you turn of
            // debug flags
            m_data.at(i) += b[i];
        }
    }

    void Vector::operator+(const Vector &b)
    {
        add(b);
    }

    void Vector::operator=(const Vector &b)
    {
        check_sizes(b);
        for (std::size_t i = 0; i < numElements(); ++i)
        {
            m_data.at(i) = b[i];
        }
    }

    double Vector::dot(const Vector &b) const
    {
        check_sizes(b);
        double dot_prod = 0;
        for (std::size_t i = 0; i < numElements(); ++i)
        {
            // the .at() checks bounds unless you turn of
            // debug flags
            dot_prod += m_data.at(i) * b[i];
        }

        return dot_prod;
    }

    double Vector::norm() const
    {
        double norm = 0;
        for (std::size_t i = 0; i < numElements(); ++i)
        {
            // the .at() checks bounds unless you turn of
            // debug flags
            norm += m_data.at(i) * m_data.at(i);
        }

        return std::sqrt(norm);
    }

    double &Vector::get(const std::size_t &index)
    {
        // the .at will check bounds to we don't need
        // to do our own check
        return m_data.at(index);
    }

    double Vector::get(const std::size_t &index) const
    {
        // the .at will check bounds to we don't need
        // to do our own check
        return m_data.at(index);
    }

    double &Vector::operator[](const std::size_t &index)
    {
        return m_data.at(index);
    }
    double Vector::operator[](const std::size_t &index) const
    {
        return m_data.at(index);
    }

    void Vector::setAllValues(const double &val)
    {
        m_data.assign(numElements(), val);
    }

    void Vector::normalize()
    {
        double norm = this->norm();
        if (norm > 0)
        {
            for (std::size_t i = 0; i < numElements(); ++i)
            {
                // the .at() checks bounds unless you turn of
                // debug flags
                m_data.at(i) /= norm;
            }
        }
        else
        {
            // TODO: maybe this should throw an error
            throw std::logic_error("Norm is not positive");
        }
    }

    void Vector::print() const
    {
        for (std::size_t i = 0; i < numElements() - 1; ++i)
        {
            std::cout << m_data.at(i) << ", ";
        }
        std::cout << m_data.back() << std::endl;
    }

    std::size_t Vector::numElements() const
    {
        return m_data.size();
    }

    void Vector::check_sizes(const Vector &b) const
    {
        if (numElements() != b.numElements())
        {
            throw std::range_error("The vectors are not the same length!");
        }
    }

} // smu_demo_namespace
