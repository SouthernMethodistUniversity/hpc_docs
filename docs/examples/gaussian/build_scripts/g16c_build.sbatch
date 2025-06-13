#!/bin/tcsh
#SBATCH -J g16_build
#SBATCH -o g16_build_%j.out
#SBATCH -e g16_build_%j.out
#SBATCH -p dev
#SBATCH --mem=6G
#SBATCH -c 1
#SBATCH -t 02:00:00
#SBATCH -A jlagrone_demo_project_0002

# Set option to rebuild in current install
# Set this to "true" to use the existing source
# Set to anything else extract new source files
setenv rebuild_existing  "true"

# set the install location.
# This needs to be somewhere you have permissions to create files
# Recommend a ColdFront Project directory with appropriate users
# and permissions
# For testing, John installed in 
# /users/jlagrone/Software/gaussian_16c02_testing
setenv g16root ${HOME}/Software/gaussian_16c02_testing

# set the location of the Gaussian source tbz
# e.g. this if for g16c02
# For testing, John put this 
# /users/jlagrone/gaussian_build/g16c02_source.txz 
# this file is available to users in the in the folder
# /hpc/m3/apps/gaussian/sources
# if they are in the hpc-gaussian_source group
# not used if rebuild_existing is true
setenv g16source ${HOME}/gaussian_build/g16c02_source.txz

# either clean build directory or extract sources
if ("$rebuild_existing" == "true") then

  # run make clean so everything gets recompiled
  cd ${g16root}/g16
  make -f bsd/g16.make clean

else

  # This makes a temporary directory in $SCRATCH to decompress the
  # files to
  setenv g16sourceextract `mktemp -d ${SCRATCH}/XXXXXX`

  # decompress the files into the temp folder
  # for g16c02_source.txz, it should make a folder named
  # g16c02 with the following files:
  # platform_c02.pdf  README.source  release_c02.txt  wkssrc.tbz
  # other versions may be different and may require changes
  cd ${g16sourceextract}
  tar -xf ${g16_source}

  # set the Gaussian source path variable to the extracted folder
  # NOTE: this is version specific
  setenv g16source ${g16sourceextract}/g16c02

  # Delete anything that might exist in the install folder
  # IMPORTANT: this is non-recoverable. It will over-write 
  # an existing installation.
  rm -rf ${g16root} >& /dev/null

  # Make sure the install directory exists and change to it
  mkdir -p ${g16root}
  cd ${g16root}

  # Extract the source code into the install location
  # this will make a g16 folder with the source code
  # in the currect directory
  bzip2 -d -c ${g16source}/*.tbz | tar xvf -

  # We're done with the temporary extracted source, so delete it
  rm -rf ${g16sourceextract}

endif

# set the Python location
# -- John does not know the reason for this. Rob had it in his script
setenv PYTHONPATH ${g16root}/g16

# Change to the appropriate directory for building Linux version
# and update some compile flags to better optimize for M3
cd ${g16root}/g16/bsd

# use whatever was set before if we're not rebuilding
if ("$rebuild_existing" != "true") then
  # Change istanbul-64 to zen3 in the compiler optimization flags
  # M3 CPUs are have AMD Zen3 architecture.
  # The Instanbul architecture was completely discontinued in 2017 (or earlier)
  # the istanbul-64 optimization flags have been removed from most modern compilers
  sed -i.backup -e 's/istanbul-64/zen3/g' setup-make
  sed -i.backup -e 's/istanbul-64/zen3/g' set-mflags

  # Change the linear algebra libraries to use AMD provided libraries
  sed -i.backup -e 's/bsd\/libatlas-amd64k10h64sse3/\/hpc\/m3\/apps\/amd\/aocl\/4.0\/lib_LP64\/libflame/g' setup-make
  sed -i.backup -e 's/bsd\/libf77blas-amd64k10h64sse3/\/hpc\/m3\/apps\/amd\/aocl\/4.0\/lib_LP64\/libblis/g' setup-make
  sed -i.backup -e 's/BLAS1=bsd\/libf77blas-.*/BLAS1=\/hpc\/m3\/apps\/amd\/aocl\/4.0\/lib_ILP64\/libblis.a BLAS2=\/hpc\/m3\/apps\/amd\/aocl\/4.0\/lib_ILP64\/libflame.a"/g' set-mflags

  # Set the correct compiler version.
  # There's some weirdness because Gaussian requires Portland Group Compilers,
  # but Nvidia bought the Portland Group, so they no longer exist.
  # This is how the (basically renamed) Portland Group compilers in the 
  # Nvidia HPC Toolkit identify
  sed -i.backup -e 's/set pver.*/set pver = 21.3/g' set-mflags

endif

# Load the Nvidia HPC Toolkit
# This contains the only compilers we know work
# for building Gaussian
# Newer versions may not work.
module purge
module load nvidia/23.5

# Run configuration steps
cd ${g16root}/g16
bsd/install
source ${g16root}/g16/bsd/g16.login

# Compile
bsd/bldg16 all istanbul
