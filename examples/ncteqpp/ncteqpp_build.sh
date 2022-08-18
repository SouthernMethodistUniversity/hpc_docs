#!/bin/bash

module purge
source /hpc/spack/share/spack/setup-env.sh
module load gcc-6.3
spack load --dependencies /b4j4e2j # ROOT
spack load --dependencies /6xpjrpd # Armadillo
spack load --dependencies /oe2qubx # yaml-cpp
spack load --dependencies /mwxg6n4 # OpenBLAS

base_directory=$(pwd)
ncteqpp_directory="${base_directory}/ncteqpp"
applgrid_directory="${base_directory}/applgrid-1.4.97"
lhapdf_directory="${base_directory}/LHAPDF-6.2.1"
minuit2_directory="${base_directory}/Minuit2-5.34.14"
dependencies_directory="${base_directory}/dependencies"

export PATH="${dependencies_directory}/bin:${PATH}"
export CPATH="${dependencies_directory}/include:${CPATH}"
export LD_LIBRARY_PATH="${dependencies_directory}/lib:${LD_LIBRARY_PATH}"
export DEPENDENCIES_DIRECTORY=${dependencies_directory}
export CC=$(which gcc)
export CXX=$(which g++)
export FC=$(which gfortran)

if [ ! -d ncteqpp ]; then
  git clone https://github.com/olness/ncteqpp.git
else
  cd ${ncteqpp_directory}
  git reset --hard
  git clean -d -x -f
  cd ${base_directory}
fi

if [ ! -f applgrid-1.4.97.tgz ]; then
  wget http://www.hepforge.org/archive/applgrid/applgrid-1.4.97.tgz
fi

if [ ! -f LHAPDF-6.2.1.tar.gz ]; then
  wget http://www.hepforge.org/archive/lhapdf/LHAPDF-6.2.1.tar.gz
fi

if [ ! -f Minuit2.tar.gz ]; then
  wget http://project-mathlibs.web.cern.ch/project-mathlibs/sw/Minuit2/Minuit2.tar.gz
fi

cd ${base_directory}
rm -rf ${applgrid_directory} ${dependencies_directory}\
  ${lhapdf_directory} ${minuit2_directory}
tar -xf applgrid-1.4.97.tgz &
tar -xf LHAPDF-6.2.1.tar.gz &
tar -xf Minuit2.tar.gz &
wait

cd ${lhapdf_directory}
./configure --prefix=${dependencies_directory}
make -j
make install

cd ${applgrid_directory}
./configure --prefix=${dependencies_directory}
make -j
make install

cd ${minuit2_directory}
./configure --prefix=${dependencies_directory}
make -j
make install

cd ${ncteqpp_directory}
cp ${base_directory}/CMakeLists.txt .
cmake .
make -j

cd ${base_directory}

