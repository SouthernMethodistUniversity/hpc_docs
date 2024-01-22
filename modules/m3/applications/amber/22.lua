whatis("Amber")
family("amber")
load("gcc/11.2.0")
load("openblas/0.3.21-s5husbk",
     "fftw/3.3.10-gz7qiki",
     "zlib/1.2.13-u7kx7ln",
     "openmpi/4.1.6-a4ksrza",
     "cmake/3.24.3-2buptpk",
     "boost/1.80.0-l5cj6ju",
     "bzip2/1.0.8-ujseine")
source_sh('bash', "/hpc/m3/apps/amber/amber22/amber.sh")

