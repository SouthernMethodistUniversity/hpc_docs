cmake_minimum_required(VERSION 3.18)
project(pet LANGUAGES CXX)

find_package(pybind11 REQUIRED)
pybind11_add_module(pet pet.cpp)

