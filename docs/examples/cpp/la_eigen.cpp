#include <iostream>
#include <Eigen/Dense>

/*
Introduction to matrix operations using Eigen. Compile via:
c++ la_eigen.cpp -o la_eigen -std=c++11 `pkg-config --cflags eigen3`
*/

int main() {
  Eigen::MatrixXd A = Eigen::MatrixXd::Ones(4, 5);
  Eigen::MatrixXd B = Eigen::MatrixXd::Ones(4, 5);
  std::cout << A+B << std::endl;
  std::cout << A-B << std::endl;
  return 0;
}

