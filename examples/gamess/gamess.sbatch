#!/bin/csh
#SBATCH -J example           # job name
#SBATCH -o example_%j.out    # output file name (%j expands to jobID)
#SBATCH --ntasks-per-node=2  # number of tasks per node requested
#SBATCH -N 1                 # total number of nodes
#SBATCH -p development       # queue (partition)
#SBATCH --mem=20G

module purge
module load gamess

setenv INPUT_FILE "example.inp"
setenv GAMESS_SCRATCH $SLURM_SUBMIT_DIR"/"$SLURM_JOB_NAME"_"$SLURM_JOB_ID

setenv SCR $GAMESS_SCRATCH
setenv USERSCR $GAMESS_SCRATCH
mkdir -p $GAMESS_SCRATCH
lfs setstripe --stripe-count 2 $GAMESS_SCRATCH
setenv JOB `echo $INPUT_FILE | cut -f 1 -d '.'`
cp $INPUT_FILE $GAMESS_SCRATCH/$JOB.F05
source $GMSPATH/gms-files.csh
srun gamess.00.x

