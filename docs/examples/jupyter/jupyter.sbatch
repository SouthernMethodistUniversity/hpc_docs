#!/bin/bash
#SBATCH -J jupyter
#SBATCH -o jupyter_%j.out
#SBATCH -G 1
#SBATCH -t 0-1

# Configure resources
# -----------------------------------------------------------------------------
# Edit cluster resources as needed. Add additional flags via command line or
# above prefixed by `#SBATCH`, e.g. adding `-G 1` to request a GPU.
# -----------------------------------------------------------------------------

# Define Jupyter environment
# -----------------------------------------------------------------------------
# See environment setup in `./setup.sh` and `requirements.txt`
# -----------------------------------------------------------------------------

source $WORK/.venv/jupyter/bin/activate # See above as needed

# Launch JupyterLab session (Usually no need to edit below)
# -----------------------------------------------------------------------------

case $SLURM_CLUSTER_NAME in
  slurm_cluster)
    node=$SLURM_SUBMIT_HOST
    name="m2"
    ;;
  nvidia)
    node=$(echo $SLURM_SUBMIT_HOST | tr -d 's-')
    name="superpod"
    ;;
  m3)
    node=$SLURM_SUBMIT_HOST
    name="m3"
    ;;
esac

login=$(printf "%s.%s.smu.edu" ${node} ${name})
port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
jupyter lab --no-browser --ip=127.0.0.1 --port=${port} &
while ! $(jupyter server list 2>&1 | grep -q ${port}); do
  sleep 5s
done
url=$(jupyter server list 2>&1 | awk '/'${port}'/{print $2}')

echo "# -----------------------------------------------------------------------------"
echo "Mac/Linux/WSL/PowerShell:"
echo "  1. Open new terminal."
echo "  2. Copy and paste into terminal (without quotes):"
echo "     \"ssh -C -L ${port}:$(hostname):${port} ${USER}@${login}\""
echo "  3. Open \"${url}\" in browser."
echo "# -----------------------------------------------------------------------------"

wait

