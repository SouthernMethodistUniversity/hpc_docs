#!/bin/bash
#SBATCH -J vscode
#SBATCH -o vscode_%j.out
#SBATCH -c 1
#SBATCH --mem=6G
#SBATCH -t 0-2

module purge
declare -A c
c["m3"]="m3"
c["nvidia"]="mp"

port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
/usr/sbin/sshd -D -p ${port} -f /dev/null -h ${HOME}/.ssh/id_ecdsa &

echo "Add the following entry to your local (your machine) \`~/.ssh/config\`:"
echo "Host vsc_${c[$SLURM_CLUSTER_NAME]}_job_${SLURM_JOB_ID}"
echo "  ProxyCommand ssh ${c[$SLURM_CLUSTER_NAME]} \"nc \\\$(squeue -j ${SLURM_JOB_ID} -h -O NodeList) ${port}\""
echo "  StrictHostKeyChecking no"
wait

