#!/bin/bash
#SBATCH -J python
#SBATCH -o python_%j.out
#SBATCH -p dev
#SBATCH -c 1
#SBATCH --mem=6G
#SBATCH -t 10

time python3 pi_monte_carlo.py 1000

