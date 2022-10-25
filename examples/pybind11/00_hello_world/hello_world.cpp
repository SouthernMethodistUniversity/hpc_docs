#include <pybind11/pybind11.h>
#include <iostream>

void print_hello_world() {
  std::cout << "Hello, World!" << std::endl;
}

PYBIND11_MODULE(hello_world, m) {
  m.def("print_hello_world", &print_hello_world);
}

