#!/bin/bash
#SBATCH -J nvshmem_pi        # Job name
#SBATCH -o nvshmem_pi_%j.out # Output file name
#SBATCH -p amd               # Queue (partition)
#SBATCH -c 1                 # Cores
#SBATCH --mem=6G             # Memory
#SBATCH --gres=gpu:1         # GPUs
#SBATCH -t 5                 # Time limit

echo $SLURM_JOB_PARTITION

module purge
module load nvhpc-22.2       # Alternatively nvhpc-21.2, nvhpc-21.9

NVSHMEM_HOME=/hpc/applications/nvidia/hpc_sdk/2022_22.2/Linux_x86_64/22.2/comm_libs/11.2/nvshmem
GCC_HOME=/hpc/spack/opt/spack/linux-centos7-x86_64/gcc-7.3.0/gcc-9.2.0-6zgrndxveon2m5mjhltrqccdcewrdktx/bin

nvcc -ccbin=$GCC_HOME -x cu -arch=sm_60 -rdc=true -I $NVSHMEM_HOME/include\
 -L $NVSHMEM_HOME/lib -lnvshmem -lcuda -o nvshmem_pi nvshmem_pi.cpp
# CUDA Compute Capabilities
# P100 sm_60
# V100 sm_70
# A100 sm_80

srun nvshmem_pi

