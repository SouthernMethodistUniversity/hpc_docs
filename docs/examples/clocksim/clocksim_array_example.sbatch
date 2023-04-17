#!/bin/bash
#SBATCH -J clocksim                    # Job name
#SBATCH -o clocksim_%A_%a.out          # Output file name
#SBATCH -p standard-mem-m              # Partition (queue)
#SBATCH --exclusive                    # Exclusivity 
#SBATCH --mem=250G                     # Total memory required per node
#SBATCH --array=1-9                    # Array range
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=7065M


module purge                           # Unload all modules
module load clocksim                   # Load Clocksim, change version as needed

index="1993"
data_directory="/hpc/applications/clocksim/F2014"

if [[ ${SLURM_ARRAY_TASK_ID} == 1 ]]; then
  srun -n 1 clocksim ${data_directory} randominit ${index} 1000
fi

new_index=$((${index} + ${SLURM_ARRAY_TASK_ID}))
parmutprob="0.1"
iters="10000"
swapfreq="10"
savefreq="10"
t1=$((${SLURM_ARRAY_TASK_ID} * 10**-4))
t2=$((${SLURM_ARRAY_TASK_ID} * 10**-3))
t3=$((${SLURM_ARRAY_TASK_ID} * 10**-2))
t4=$((${SLURM_ARRAY_TASK_ID} * 10**-1))
mutationsize="0.03"

srun clocksim ${data_directory} tempering ${index} ${new_index} \
  ${parmutprob} ${iters} ${swapfreq} "${t1},${t2},${t3},${t4}" \
  ${mutationsize}

