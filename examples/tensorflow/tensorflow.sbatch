#!/bin/bash
#SBATCH -J tensorflow        # Job name
#SBATCH -o tensorflow_%j.out # Output file name
#SBATCH -p v100x8            # Queue (partition)
#SBATCH -c 1                 # Cores
#SBATCH --mem=6G             # Memory
#SBATCH --gres=gpu:1         # GPUs
#SBATCH -t 0-1               # Time limit

# Load TensorFlow
module purge
module load tensorflow

# Run Python script
python3 example.py

