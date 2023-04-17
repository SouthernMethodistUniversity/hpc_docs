#!/usr/bin/env zsh
#SBATCH -J nemo_1
#SBATCH -o nemo_1_%j.out
#SBATCH -c 4
#SBATCH --mem=16G

# Build the container
# Flags:
# --no-container-remap-root : Set actual user inside container (not root)
# --container-image         : Source container image
# --container-save          : Destination container image
# --no-container-entrypoint : Do not use image entrypoint
# --container-mounts        : Mount NeMo repo as workspace inside container
# bash -l -c ./reinstall.sh : Run the NeMo reinstall.sh script path already
#                             in NeMo directory due to --container-mounts

srun\
 --no-container-remap-root\
 --container-image nvcr.io#nvidia/pytorch:22.04-py3\
 --container-save ./nemo-22.06.sqsh\
 --no-container-entrypoint\
 --container-mounts ${SLURM_SUBMIT_DIR}/NeMo:/workspace\
 bash -l -c ./reinstall.sh

