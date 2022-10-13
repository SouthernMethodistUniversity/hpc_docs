/*
 Simple demonstration of the Eigen Library

 Useful References:
 * https://eigen.tuxfamily.org/dox/
 * Discovering Modern C++ by Peter Gottschling (amongst many other C++ books)
 * https://en.cppreference.com/
*/

#include <iostream>    // IO
#include <Eigen/Dense> // The Eigen dense linear algebra library
#include <cmath>       // for trig functions

int main()
{

    // Eigen is a templated linear algebra library. Templating allows
    // the library to change the size and type of various objects at
    // compile time and it also allows the compiler to do some clever
    // optimizations. For instance, it can automatically expand
    // expressiosn like
    //
    // d = a + b + c
    //
    // where the variables are all vectors (or matrices) to
    //
    // for (int i=0; i<n; ++i) {
    //   d[i] = a[i] + b[i] + c[i]
    // }
    //
    // This makes many linear algebra operations much more efficient than
    // traditional blas / lapack routines that may require multiple
    // evaluations

    // For linear algebra, Eigen is built around a Matrix class
    // see https://eigen.tuxfamily.org/dox/classEigen_1_1Matrix.html
    // This class has the form
    //
    // template<typename Scalar_, int Rows_, int Cols_, int Options_, int MaxRows_, int MaxCols_>
    // class Eigen::Matrix<Scalar_, Rows_, Cols_, Options_, MaxRows_, MaxCols_>
    //
    // Scalar is the datatype, e.g. a doulbe
    // Rows and Cols are the number of rows and cols, respectively
    // options lets you set some things like row/col major, alignment, etc.
    //
    // Eigen provides some convenient type defs so you don't need to remember all that, e.g.
    // Matrix2d is a 2x2 square matrix of doubles (Matrix<double, 2, 2>)
    // Vector4f is a vector of 4 floats(Matrix<float, 4, 1>)
    // RowVector3i is a row vector of 3 ints(Matrix<int, 1, 3>)
    // MatrixXf is a dynamic size matrix of floats(Matrix<float, Dynamic, Dynamic>)
    // VectorXf is a dynamic size vector of floats(Matrix<float, Dynamic, 1>)
    // Matrix2Xf is a partially fixed size(dynamic - size) matrix of floats(Matrix<float, 2, Dynamic>)
    // MatrixX3d is a partially dynamic size(fixed - size) matrix of double(Matrix<double, Dynamic, 3>)
    // you can also make your own typedefs, e.g
    // this is the same as Vector3d
    // typedef Eigen::Matrix<double, 3, 1> Vector;

    // Define Vectors a,b,c of length 3
    Eigen::Vector3d a, b, c;

    // set a to (1,2,3)
    a << 1, 2, 3;

    // set b to (4, 5, 6)
    b(0) = 4;
    b(1) = 5;
    b(2) = 6;

    // set c = a + b
    c = a + b;

    // print out a (it's a column vector, so transpose it so it's on 1 line)
    std::cout << "a: " << a.transpose() << std::endl;
    std::cout << "b: " << b.transpose() << std::endl;
    std::cout << "c: " << c.transpose() << std::endl;

    // set c to ones
    c.setOnes();
    std::cout << "c: " << c.transpose() << std::endl;
    c.normalize();
    std::cout << "c: " << c.transpose() << std::endl;
    c = Eigen::Vector3d::Random(3);
    std::cout << "c: " << c.transpose() << std::endl;
    c.normalize();
    std::cout << "c: " << c.transpose() << std::endl;

    // create a 3x3 matrix
    Eigen::Matrix3d A, B;
    double theta = 1.23423; // random angle in radians
    double omega = 3.854;

    // make A & B be a rotation matrix
    // rotates in xy-plane
    A << std::cos(theta), -std::sin(theta), 0,
        std::sin(theta), std::cos(theta), 0,
        0, 0, 1;

    // rotates in xy-plane
    B << std::cos(omega), 0, -std::sin(omega),
        0, 1, 0,
        std::sin(omega), 0, std::cos(omega);

    // create a new rotation matrix that is the combination
    // of A and B
    auto R = A * B;

    std::cout << "R:" << std::endl
              << R << std::endl;

    // rotate some vectors
    std::cout << "a: " << a.transpose() << " (norm = " << a.norm() << ")" << std::endl;
    std::cout << "b: " << b.transpose() << " (norm = " << b.norm() << ")" << std::endl;
    std::cout << "c: " << c.transpose() << " (norm = " << c.norm() << ")" << std::endl;

    a = R * a;
    b = R * b;
    c = R * c;

    std::cout << "after rotating:" << std::endl;
    std::cout << "\ta: " << a.transpose() << " (norm = " << a.norm() << ")" << std::endl;
    std::cout << "\tb: " << b.transpose() << " (norm = " << b.norm() << ")" << std::endl;
    std::cout << "\tc: " << c.transpose() << " (norm = " << c.norm() << ")" << std::endl;

    // the inverse of rotation matrix is it's transpose ...
    a = R.transpose() * a;
    b = R.transpose() * b;
    c = R.transpose() * c;

    std::cout << "after rotating back:" << std::endl;
    std::cout << "\ta: " << a.transpose() << " (norm = " << a.norm() << ")" << std::endl;
    std::cout << "\tb: " << b.transpose() << " (norm = " << b.norm() << ")" << std::endl;
    std::cout << "\tc: " << c.transpose() << " (norm = " << c.norm() << ")" << std::endl;

    // We might want dynamic sizes, so we can do (X is dynamic, where we had 3 above)
    const int n = 1987;
    Eigen::MatrixXd M = Eigen::MatrixXd::Random(n, n);
    Eigen::VectorXd x = Eigen::VectorXd::Random(n);
    Eigen::VectorXd f(n);

    // set f = Mx
    f = M * x;

    // Eigen has solvers built in
    // see https://eigen.tuxfamily.org/dox/group__TutorialLinearAlgebra.html
    // We'll use the CompleteOrthogonalDecomposition method here. It's
    // very accurate and reasonably fast for small to medium matrices
    Eigen::VectorXd y = M.completeOrthogonalDecomposition().solve(f);

    // if everything worked, we expect y = x (up to floating point rounding
    // errors anyway). So lets check that:
    double abs_error = (y - x).norm();
    double rel_error = abs_error / x.norm();

    std::cout << "Solve gave absolute error: " << abs_error
              << " and relative error: " << rel_error << std::endl;

    return 0;
}