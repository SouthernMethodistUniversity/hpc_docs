#!/usr/bin/env zsh
#SBATCH -J md_1
#SBATCH -o md_1_%j.out
#SBATCH -G 8
#SBATCH --cpus-per-gpu=32
#SBATCH --mem=0

# Build the container
# Flags:
# --no-container-remap-root : Set actual user inside container (not root)
# --container-image         : Source container image
# --container-mounts        : Mount NeMo repo as workspace inside container
# --no-container-entrypoint : Do not use image entrypoint
# bash -c ...               : Run GROMACS commands inside container

job_dir=${SLURM_SUBMIT_DIR}/${SLURM_JOB_NAME}_${SLURM_JOB_ID}
mkdir ${job_dir}
cp stmv.tpr ${job_dir}
cd ${job_dir}

srun\
 --no-container-remap-root\
 --container-image ${SLURM_SUBMIT_DIR}/hpc+gromacs+2022.1.sqsh\
 --container-mounts ${job_dir}:/data\
 --container-workdir=/data\
 --no-container-entrypoint\
 bash -c "source /usr/local/gromacs/avx2_256/bin/GMXRC.bash &&\
 gmx mdrun -v -nsteps 100000 -resetstep 90000 -noconfout\
 -ntmpi 16 -ntomp 8 -pin on\
 -nb gpu -bonded gpu -pme gpu -npme 1 -nstlist 400 -s stmv.tpr"

