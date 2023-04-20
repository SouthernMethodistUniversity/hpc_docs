#!/usr/bin/env zsh

# Run with GPU allocation, e.g. `srun -c 8 -G 1 --pty ./test.sh`
# proc gives physical ids
# slurm gives logical ids

printf "GPU Index: %s\n" $SLURM_STEP_GPUS

smi() {
  list=$1
  eval "array=(${list//,/ })"
  for cpu in "${array[@]}"; do
    for c in {${cpu//-/..}}; do
      nvidia-smi topo -c $c
    done
  done
}

using_proc() {
  # proc
  cpu_list=$(cat /proc/self/status | grep Cpus_allowed_list | tr -d '[:space:]' | cut -d: -f2)
  printf "Physical IDs from /proc: %s\n" $cpu_list
  smi $cpu_list
}

using_slurm() {
  # slurm
  cpu_list=$(scontrol -d show job $SLURM_JOB_ID | tr '[:space:]' '\n' | grep CPU_IDs | cut -d= -f2)
  printf "Logical IDs from Slurm: %s\n" $cpu_list
  smi $cpu_list
}

using_proc
using_slurm

