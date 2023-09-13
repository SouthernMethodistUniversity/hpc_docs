#!/bin/bash
#SBATCH -J test
#SBATCH -o test_%A-%a.out
#SBATCH --array=1-100
#SBATCH -p standard-s
#SBATCH -N 1
#SBATCH --exclusive 

random_data() {
  d=$SCRATCH/$SLURM_ARRAY_JOB_ID/$SLURM_ARRAY_TASK_ID
  mkdir -p $d
  cd $d
  dd if=/dev/urandom of=sample.txt bs=64M count=1600
  rm -rf $d
}

/usr/bin/time random_data

