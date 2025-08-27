#!/bin/bash
#SBATCH -J g16_test
#SBATCH -o g16_test_%A_%a.out
#SBATCH -e g16_test_%A_%a.out
#SBATCH -p standard-s
#SBATCH --mem=32G
#SBATCH -c 16
#SBATCH -t 00:10:00
#SBATCH -A peruna_0001
#SBATCH --array=1,28,94,155,194,296,302 # numbers correspond to the gaussian test

# based on https://gaussian.com/testjobs/

# Load the Nvidia HPC Toolkit
# This contains the only compilers we know work
# for building Gaussian
# Newer versions may not work.
module purge
module load nvidia/23.5

# set the install location.
export g16root=${HOME}/Software/gaussian_16c02_testing

# load the gaussian commands
source ${g16root}/g16/bsd/g16.profile

# make a temp directory to test in
# running in the source gaussian directory will
# overwrite reference solutions
export TEST_DIR=$(mktemp -d ${SCRATCH}/XXXXXX)

# link to tests
cd ${TEST_DIR}
ln -s ${g16root}/g16/tests/com .

# make directory for tests
# this needs to match the installed system type which should
# be defined by gau-machine
mkdir -p $(gau-machine)

# get the test number from the job arrar id
TEST_NUM="0000$SLURM_ARRAY_TASK_ID"

# run the test
$g16root/g16/tests/submit.csh ${TEST_NUM} ${TEST_NUM}

# print some blanks to make it easier to find results
echo ""
echo ""
echo "------------------------------ Results -------------------------"
echo ""
echo ""

# compare
cd $(gau-machine)
$g16root/g16/tests/d1 ${TEST_NUM} ${TEST_NUM}


# delete the test dir
cd ${SLURM_SUBMIT_DIR}
rm -rf ${TEST_DIR}
