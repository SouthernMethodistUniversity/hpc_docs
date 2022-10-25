cmake_minimum_required(VERSION 3.18)
project(example LANGUAGES CXX)

find_package(pybind11 REQUIRED)
pybind11_add_module(hello_world hello_world.cpp)

