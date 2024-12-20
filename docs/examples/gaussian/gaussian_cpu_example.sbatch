#!/usr/bin/env zsh
#SBATCH -J gaussian
#SBATCH -o gaussian_%j.out
#SBATCH -p batch
#SBATCH --exclusive
#SBATCH --gres=gpu:8
#SBATCH --mem=0

input_file=hexakisx.g16_gpu

. /hpc/mp/spack/opt/spack/linux-ubuntu20.04-zen2/gcc-10.3.0/lmod-8.7.2-uutt23puvwraegsi7w7ck3xbhrgk22mu/lmod/lmod/init/zsh
module use /hpc/mp/modules
module purge
module load gaussian

job_dir=${SCRATCH}/${SLURM_ARRAY_JOB_ID}/${SLURM_ARRAY_TASK_ID}
mkdir -p ${job_dir}
cp ${input_file} ${job_dir}
cd ${job_dir}
GAUSS_SCRDIR=${job_dir}

cores_32=$(seq -s ',' 0 4 124)
cores_64=$(seq -s ',' 0 2 124)
cores_128="0-127"

gpus_1="0=48"
gpus_2="0-1=48,52"
gpus_4="0-3=48,52,16,20"
gpus_8="0-7=48,52,16,20,112,116,80,84"

cpu_gpu() {
  sed -i -e "/^%CPU/c\%CPU=${1}" ${input_file}
  sed -i -e "/^%GPU/c\%GPUCPU=${2}" ${input_file}
}

cpu_gpu ${cores_128} ${gpus_8}

g16 < ${input_file}

