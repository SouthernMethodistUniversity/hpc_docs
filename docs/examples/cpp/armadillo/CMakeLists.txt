cmake_minimum_required(VERSION 3.15.0)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
project(arma_example
  LANGUAGES CXX)

add_executable(arma_example main.cpp)

find_package(Armadillo REQUIRED)
include_directories(${ARMADILLO_INCLUDE_DIRS})
target_link_libraries(arma_example PRIVATE ${ARMADILLO_LIBRARIES})

find_package(fmt REQUIRED)
target_link_libraries(arma_example PUBLIC fmt::fmt)

