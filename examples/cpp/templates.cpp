/*
Test our template class

*/

#include "templates.hpp"

int main()
{

    using namespace smu_demo_namespace;

    // test our max function
    // NOTE: the template parameter is automatically inferred
    // and we didn't need to specify it

    // using braces to scope variables so I can resuse names
    {
        int a = 5;
        int b = 4;

        std::cout << "according to our function, " << custom_max(a, b)
                  << " is the greatest of (" << a << ", " << b << ")"
                  << std::endl;
    }

    {
        char a = 'x';
        char b = 'e';

        std::cout << "according to our function, " << custom_max(a, b)
                  << " is the greatest of (" << a << ", " << b << ")"
                  << std::endl;
    }

    {
        double a = 132.3;
        double b = 12321.1;

        std::cout << "according to our function, " << custom_max(a, b)
                  << " is the greatest of (" << a << ", " << b << ")"
                  << std::endl;
    }

    // Test our class. We need to tell it the dimensions and type
    {
        DumbVector<int, 3> test_vector;

        for (int i=0; i<4; ++i) {
            test_vector.setByIndex(i, i);
        }

        test_vector.print();
    }

    {
        DumbVector<char, 3> test_vector;

        for (int i = 0; i < 4; ++i)
        {
            test_vector.setByIndex(i, 'a');
        }

        test_vector.print();
    }

    {
        DumbVector<double, 3> test_vector;

        for (int i = 0; i < 4; ++i)
        {
            test_vector.setByIndex(i, i*4.5);
        }

        test_vector.print();
    }

    // Test our multiplication
    std::cout << "multiplying 1 * 2 = " << multiply(1,2) << std::endl;
    std::cout << "multiplying 1 * 2 * 3 = " << multiply(1, 2, 3) << std::endl;
    std::cout << "multiplying 1.0 * 2.0 * 3.0 * 4.0 = " << multiply(1.0, 2.0, 3.0, 4.0) << std::endl;
    std::cout << "multiplying 1.0 * 2.0 * 3.0 * 4.0 * 5.0 = " << multiply(1.0, 2.0, 3.0, 4.0, 5.0) << std::endl;
    std::cout << "multiplying 1.0 * 2.0 * 3.0 * 4.0 * 5.0 * 6.0 = " << multiply(1.0, 2.0, 3.0, 4.0, 5.0, 6.0) << std::endl;
}