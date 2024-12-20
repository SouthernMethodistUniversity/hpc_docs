#!/bin/bash
#SBATCH -J gaussian            # job name shown in queue
#SBATCH -o gaussian_%j.out     # output file, %j is the job id number
#SBATCH -p dev                 # request the dev queue
#SBATCH -c 128                 # request all 128 GPUs
#SBATCH --mem=0                # requests all of the memory
#SBATCH -t 01:00:00            # request 1 hour
#SBATCH -A peruna_project_0001 # example account

# specify the input file
input_file=gaussian_example.cpu

# module purge clears any existing modules so only the modules
# requested will be loaded. This improves reproducibility
module purge

# load gaussian. It is a good practice to include the version
# the default modules without a version may change when software
# is updated
module load gaussian/g16c/zen3

# create a temporary job directory in scratch
# copy the input file and cd into it
# Note: scratch is intended for temporary job storage
# you should move any files you need to keep when the job
# completes and delete unneeded files. Files in $SCRATCH
# are subject to automatic deletion after 60 days.
job_dir=${SCRATCH}/${SLURM_JOB_ID}
mkdir -p ${job_dir}
cp ${input_file} ${job_dir}
cd ${job_dir}
GAUSS_SCRDIR=${job_dir}

# gets requested mem in GB
sleep 5 # to make sure the job info is available
mem=$(sacct -o "ReqMem" --units=G -j ${SLURM_JOB_ID} -n | xargs)

# get the cores assigned to the job
# This is M3 specific, though something similar will work on many systems
cpus=$(cat /sys/fs/cgroup/system.slice/slurmstepd.scope/job_${SLURM_JOB_ID}/cpuset.cpus)

# make sure mem is an int with correct units
mem=${mem%.*}
mem=${mem//[!0-9]/}
mem="${mem}GB"

# this function fills in the cpu and memory information into the
# input file
cpu_mem() {
  sed -i -e "/^%CPU/c\%CPU=${1}" ${input_file}
  sed -i -e "/^%Mem/c\%Mem=${2}" ${input_file}
}

cpu_mem ${cpus} ${mem}

# run gaussian
g16 < ${input_file}

# clean up temp $SCRATCH directory
# this moves the checkpoint file from Gaussian to the
# directory you submitted the job from. 
# Note, if the job runs out of time, memory, or
# fails in some other way, these commands may not be reached
# This assumes the checkpoint file has a .chk extension

# You should make sure you are keeping the files you need
# this is just an example of a plausible workflow.
mv *.chk SLURM_SUBMIT_DIR/
cd SLURM_SUBMIT_DIR
rm -rf ${job_dir}