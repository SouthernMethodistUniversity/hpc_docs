#include <iostream>
#include <armadillo>

/*
Introduction to matrix operations using Armadillo. Compile via:
c++ la_arma.cpp -o la_arma -std=c++11 `pkg-config --cflags --libs armadillo`
*/

int main() {
  arma::mat A(4, 5, arma::fill::ones);
  arma::mat B(4, 5, arma::fill::ones);
  std::cout << A+B << std::endl;
  std::cout << A-B << std::endl;

  arma::mat A(5, 5, arma::fill::randu);
  arma::mat B = A.t() * A;
  arma::mat C = inv_sympd(B);
  std::cout << A << std::endl;
  std::cout << B << std::endl;
  std::cout << C << std::endl;

  return 0;
}

