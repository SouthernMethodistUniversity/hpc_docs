#!/usr/bin/env zsh
#SBATCH -J nemo_2
#SBATCH -o nemo_2_%j.out
#SBATCH -N 1
#SBATCH -G 8
#SBATCH --ntasks-per-node=8
#SBATCH -c 1
#SBATCH --mem=0

# Run Python script inside container
# Flags:
# --no-container-remap-root : Set actual user inside container (not root)
# --container-image         : Source container image
# --no-container-entrypoint : Do not use image entrypoint
# --container-mounts        : Mount NeMo repo as workspace inside container
# bash -l -c <command>      : Command to run inside container

srun\
 --no-container-remap-root\
 --container-image ${SLURM_SUBMIT_DIR}/nemo-22.06.sqsh\
 --no-container-entrypoint\
 --container-mounts ${SLURM_SUBMIT_DIR}/NeMo:/workspace\
 bash -l -c 'python3\
 /workspace/examples/nlp/text_classification/text_classification_with_bert.py'

