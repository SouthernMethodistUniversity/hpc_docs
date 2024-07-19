#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --mem=10G
#SBATCH --job-name=OpenFOAM
#SBATCH --output=output_OpenFOAM_%j.out
#SBATCH --time=00:05:00
#SBATCH -p dev

# load openfoam
module purge
module load gcc/11.2.0
module load openfoam/2312-5z7e7ot
module load openmpi/4.1.6-vfi4iwj

# make a test directory in scratch with the Job id
# NOTE: $SCRATCH has a 60 day purge policy
mkdir -p ${SCRATCH}/openfoam/test_run_${SLURM_JOB_ID}/
cd ${SCRATCH}/openfoam/test_run_${SLURM_JOB_ID}/

# copy example from official tutorial
cp -r $FOAM_TUTORIALS/incompressible/simpleFoam/pitzDaily .
chmod 700 -R pitzDaily && cd pitzDaily

# copy our decomposeParDict into the $SCRATCH job folder
cp ${SLURM_SUBMIT_DIR}/decomposeParDict system/decomposeParDict

# run the example
srun blockMesh
srun decomposePar
srun simpleFoam -parallel