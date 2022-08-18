#!/bin/bash
#SBATCH -J example
#SBATCH -o example.out
#SBATCH -N 1
#SBATCH -p gpgpu-1
#SBATCH --mem=250G
#SBATCH --gres=gpu:1
#SBATCH --exclusive

module purge
module load namd/2.12/gpu

# set Lustre striping
lfs setstripe -c 2 $SLURM_SUBMIT_DIR

# get number of cores/node
N=$(awk '/processor/{a=$3}END{print a}' /proc/cpuinfo)

# generate NAMD nodelist
for n in `echo $SLURM_NODELIST | scontrol show hostnames`; do
  echo "host $n ++cpus $N" >> nodelist.$SLURM_JOBID
done

# calculate total processes (P) and procs per node (PPN)
PPN=$(($N - 1))
P=$(($PPN * $SLURM_NNODES))

charmrun $(which namd2) ++mpiexec ++p $P ++ppn $PPN ++nodelist nodelist.$SLURM_JOBID +setcpuaffinity +isomalloc_sync example.conf

rm nodelist.$SLURM_JOBID

