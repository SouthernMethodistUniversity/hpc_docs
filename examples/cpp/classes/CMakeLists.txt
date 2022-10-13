cmake_minimum_required(VERSION 3.21)

PROJECT(Class_Demos DESCRIPTION "Examples of C++ Classes" LANGUAGES CXX)

# set the default build type to Release with Debug Info
set(default_build_type "RelWithDebInfo")

# boiler plate so the build type is a list of valid values to choose from
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
    set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE
        STRING "Choose the type of build." FORCE)

    # Set the possible values of build type for cmake-gui
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
        "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# use c++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# look for include files in the current directory
set(CMAKE_INCLUDE_CURRENT_DIR ON)

# find the Eigen Vector library
find_package(Eigen3 NO_MODULE)

# add executables
add_executable(inheritance_test.x inheritance_test.cpp simple_inheritance.cpp)
add_executable(vector_test.x vector_class.cpp vector_test.cpp)

# only build the Eigen example if Eigen was found
if(TARGET Eigen3::Eigen)
    add_executable(eigen_demo.x eigen_demo.cpp)
    target_link_libraries(eigen_demo.x Eigen3::Eigen)
endif(TARGET Eigen3::Eigen)
