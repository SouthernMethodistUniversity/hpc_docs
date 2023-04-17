cmake_minimum_required(VERSION 2.8)
project(nCTEQpp)

enable_language(Fortran)
set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -O0 -pg")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -O2 -Wno-comment -Wno-return-type -Wno-unused-value")
set(CMAKE_BUILD_TYPE DEBUG)

# GSL
set(GSL_CONFIG "gsl-config")
exec_program(${GSL_CONFIG} ARGS --libs OUTPUT_VARIABLE GSL_LIBRARIES)

# LHAPDF
set(LHAPDF_CONFIG "lhapdf-config")
exec_program(${LHAPDF_CONFIG} ARGS --libs OUTPUT_VARIABLE LHAPDF_LIB)
exec_program(${LHAPDF_CONFIG} ARGS --incdir OUTPUT_VARIABLE LHAPDF_INCLUDES)

# MINUIT2
SET(DEPENDENCIES_DIRECTORY "$ENV{DEPENDENCIES_DIRECTORY}")
set(MINUIT2_LIB "-L${DEPENDENCIES_DIRECTORY}/lib -lMinuit2")
set(MINUIT2_INC "-I${DEPENDENCIES_DIRECTORY}/include/Minuit2/")

# APPLGRID
set(APPLGRID_CONFIG "applgrid-config")
exec_program(${APPLGRID_CONFIG} ARGS --ldflags OUTPUT_VARIABLE APPLGRID_LIB)
exec_program(${APPLGRID_CONFIG} ARGS --incdir OUTPUT_VARIABLE APPLGRID_INCLUDES)

# ROOT
set(ROOT_CONFIG "root-config")
exec_program(${ROOT_CONFIG} ARGS --libs OUTPUT_VARIABLE ROOT_LIB)
exec_program(${ROOT_CONFIG} ARGS --incdir OUTPUT_VARIABLE ROOT_INC)

# Armadillo
set(ARMADILLO_LIB -L/hpc/spack/opt/spack/linux-centos7-x86_64/gcc-6.3.0/armadillo-8.100.1-6xpjrpda4bx3rtkmstm5w7zcyxluijf7/lib64 -larmadillo)
set(ARMADILLO_INC /hpc/spack/opt/spack/linux-centos7-x86_64/gcc-6.3.0/armadillo-8.100.1-6xpjrpda4bx3rtkmstm5w7zcyxluijf7/include)

# yaml-cpp
set(YAML_CPP_LIB -L/hpc/spack/opt/spack/linux-centos7-x86_64/gcc-6.3.0/yaml-cpp-0.5.3-oe2qubxbmlmn3xvs3rfoabned3uigz5b/lib -lyaml-cpp)
set(YAML_CPP_INC /hpc/spack/opt/spack/linux-centos7-x86_64/gcc-6.3.0/yaml-cpp-0.5.3-oe2qubxbmlmn3xvs3rfoabned3uigz5b/include)

# OpenBLAS
set(OPENBLAS_LIB -L/hpc/spack/opt/spack/linux-centos7-x86_64/gcc-6.3.0/openblas-0.2.20-mwxg6n4hxk5tbwqabs6opn5yuit4r5v5/lib -lopenblas)
set(OPENBLAS_INC /hpc/spack/opt/spack/linux-centos7-x86_64/gcc-6.3.0/openblas-0.2.20-mwxg6n4hxk5tbwqabs6opn5yuit4r5v5/include)

# Collect include directories
include_directories(
        ./
        ./include
        ./src/examples/nvwa
        ./src/theory/vbp/include
        ./src/tools/NHoppet
        ./src/tools/cubature
        ./src/tools/eps09
        ${ARMADILLO_INC}
        ${YAML_CPP_INC}
        ${OPENBLAS_INC}
        )

file(GLOB_RECURSE LIB_SOURCE_FILES "src/core/*.cpp")

file(GLOB_RECURSE LIBF123L_SOURCE_FILES "src/theory/f123/src/*.f")
file(GLOB_RECURSE LIBVBP_SOURCE_FILES "src/theory/vbp/src/*.f")
file(GLOB_RECURSE LIBDIMUON_SOURCE_FILES "src/theory/dimu/src/*.f")

# Cubature library src files (for integartion)
file(GLOB_RECURSE LIB_CUBATURE_SRC "src/tools/cubature/*.c")

file(GLOB_RECURSE LIB_SOURCE_FILES "src/core/*.cpp")

file(GLOB_RECURSE LIBF123L_SOURCE_FILES "src/theory/f123/src/*.f")

file(GLOB_RECURSE LIBNHOPPET_SOURCE_FILES "src/tools/NHoppet/*.f90" "src/tools/NHoppet/*.f")

file(GLOB_RECURSE LIBADZ_SOURCE_FILES "src/tools/adz/*.f")

file(GLOB_RECURSE LIBALP_SOURCE_FILES "src/tools/alpiNCTEQ15/src/*.f" "src/tools/alpiNCTEQ15/src/wrpperYAML.cpp")

#compile ADZ lib
add_library(ADZ SHARED ${LIBADZ_SOURCE_FILES})
set_target_properties( ADZ PROPERTIES LIBRARY_OUTPUT_DIRECTORY ./lib)

#compile alpiNCTQ15
add_library(alpiNCTEQ STATIC ${LIBALP_SOURCE_FILES})
set_target_properties(alpiNCTEQ PROPERTIES ARCHIVE_OUTPUT_DIRECTORY ./lib)

# compile cubature lib
add_library(cubature SHARED ${LIB_CUBATURE_SRC})
set_target_properties(cubature PROPERTIES LIBRARY_OUTPUT_DIRECTORY ./lib)

#compile vbp
add_library(VBP STATIC ${LIBVBP_SOURCE_FILES})
target_link_libraries(VBP ADZ)
set_target_properties(VBP PROPERTIES ARCHIVE_OUTPUT_DIRECTORY ./lib)
set_target_properties(VBP PROPERTIES COMPILE_FLAGS "-ffixed-line-length-none -finit-local-zero -fno-automatic")

# compile dimuon
add_library(DIMUON STATIC ${LIBDIMUON_SOURCE_FILES})
target_link_libraries(DIMUON ADZ)
set_target_properties(DIMUON PROPERTIES ARCHIVE_OUTPUT_DIRECTORY ./lib)
set_target_properties(DIMUON PROPERTIES COMPILE_FLAGS "-ffixed-line-length-none -finit-local-zero -fno-automatic")

# compile F123L lib
add_library(f123L STATIC ${LIBF123L_SOURCE_FILES})
target_link_libraries(f123L ADZ)
set_target_properties(f123L PROPERTIES ARCHIVE_OUTPUT_DIRECTORY ./lib)

# compile NucHoppet lib
add_library(nhoppet STATIC ${LIBNHOPPET_SOURCE_FILES})
set_target_properties(nhoppet PROPERTIES ARCHIVE_OUTPUT_DIRECTORY ./lib)

# compile cteqcpp lib
add_library(cteqcpp STATIC ${LIB_SOURCE_FILES})
target_link_libraries(cteqcpp nhoppet cubature ${ROOT_LIB} ${YAML_CPP_LIB} ${OPENBLAS_LIB})
set_target_properties(cteqcpp PROPERTIES ARCHIVE_OUTPUT_DIRECTORY ./lib)

# compile the MainPDF example demonstrating the new structure
add_executable(PDF src/examples/MainPDF.cpp)
target_link_libraries(PDF cteqcpp nhoppet ${LHAPDF_LIB})
set_target_properties(PDF PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

# compile Reader example
add_executable(READER  src/examples/MainReader.cpp)
target_link_libraries(READER cteqcpp)
set_target_properties(READER PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

# compile the Cuts example
add_executable(CUTS src/examples/MainCuts.cpp)
target_link_libraries(CUTS cteqcpp)
set_target_properties(CUTS PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

# compile Chi2 example
add_executable(CHI2 src/examples/MainChi2.cpp)
target_link_libraries(CHI2 cteqcpp f123L DIMUON VBP ${LHAPDF_LIB} ${GSL_LIBRARIES} ${APPLGRID_LIB} ${ARMADILLO_LIB})
set_target_properties(CHI2 PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

# compile the Minimization example
add_executable(MINI src/examples/MainMinimizer.cpp)
target_link_libraries(MINI cteqcpp f123L DIMUON VBP ${LHAPDF_LIB} ${MINUIT2_LIB} ${GSL_LIBRARIES} ${APPLGRID_LIB} ${ARMADILLO_LIB} ${ROOT_LIB})
set_target_properties(MINI PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

# compile the EPS09 example
add_executable(EPS09 src/examples/MainEPS09Param.cpp src/tools/eps09/eps09.cxx)
target_link_libraries(EPS09 cteqcpp f123L DIMUON VBP ${LHAPDF_LIB} ${GSL_LIBRARIES} ${APPLGRID_LIB} ${ARMADILLO_LIB})
set_target_properties(EPS09 PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

# compile the ErrorAnalysis example
add_executable(HESSIAN src/examples/MainHessErrors.cpp)
target_link_libraries(HESSIAN cteqcpp f123L DIMUON VBP ${LHAPDF_LIB} ${GSL_LIBRARIES} ${APPLGRID_LIB} ${ARMADILLO_LIB} ${MINUIT2_LIB} ${ROOT_LIB})
set_target_properties(HESSIAN PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

# compule the Penalty Example
add_executable(PENALTY src/examples/MainPenalty.cpp)
target_link_libraries(PENALTY cteqcpp)
set_target_properties(PENALTY PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

# compile the NCTEQ15 norm Example
add_executable(NCTEQ15NORM src/examples/MainnCTEQ15Norm.cpp)
target_link_libraries(NCTEQ15NORM cteqcpp f123L DIMUON VBP ${LHAPDF_LIB} ${GSL_LIBRARIES} ${APPLGRID_LIB} ${ARMADILLO_LIB})
set_target_properties(NCTEQ15NORM PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

# compile the Check Data Set Example
add_executable(CHECKDATA src/examples/MainDataSetsCheck.cpp)
target_link_libraries(CHECKDATA cteqcpp f123L DIMUON VBP ${LHAPDF_LIB} ${GSL_LIBRARIES} ${ARMADILLO_LIB} ${APPLGRID_LIB})
set_target_properties(CHECKDATA PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

# compile the LHAPDFEVO Set Example
add_executable(LHAPDFEVO src/examples/MainLHAPDFEvo.cpp)
target_link_libraries(LHAPDFEVO cteqcpp f123L DIMUON VBP ${LHAPDF_LIB} ${APPLGRID_LIB})
set_target_properties(LHAPDFEVO PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

# compile the FullNuc check
add_executable(LHAPDFCheck src/examples/MainCheckFullNuc.cpp src/tools/eps09/eps09.cxx)
target_link_libraries(LHAPDFCheck cteqcpp f123L ${LHAPDF_LIB})
set_target_properties(LHAPDFCheck PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

# compile the F123DISFortran
add_executable(F123 src/examples/MainF123.cpp)
target_link_libraries(F123 cteqcpp f123L DIMUON VBP ${LHAPDF_LIB} ${APPLGRID_LIB})
set_target_properties(F123 PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

# compile APPLGrid test
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fopenmp")
add_executable(APPLGRID src/examples/MainAPPLGrid.cpp)
target_link_libraries(APPLGRID cteqcpp f123L DIMUON VBP ${LHAPDF_LIB} ${GSL_LIBRARIES} ${APPLGRID_LIB} ${ARMADILLO_LIB} ${YAML_CPP_LIB} ${OPENBLAS_LIB})
set_target_properties(APPLGRID PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

add_executable(VBPM src/examples/MainVBP.cpp)
target_link_libraries(VBPM cteqcpp VBP f123L DIMUON VBP ${LHAPDF_LIB} ${GSL_LIBRARIES} ${APPLGRID_LIB} ${ARMADILLO_LIB} ${OPENBLAS_LIB})
set_target_properties(VBPM PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

add_executable(DIMU src/examples/MainDiMu.cpp)
target_link_libraries(DIMU cteqcpp f123L DIMUON VBP ${LHAPDF_LIB} ${GSL_LIBRARIES} ${APPLGRID_LIB} ${ARMADILLO_LIB})
set_target_properties(DIMU PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

add_executable(NEU src/examples/MainDISNEU.cpp)
target_link_libraries(NEU cteqcpp f123L DIMUON VBP ${LHAPDF_LIB} ${GSL_LIBRARIES} ${APPLGRID_LIB} ${ARMADILLO_LIB})
set_target_properties(NEU PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin")

