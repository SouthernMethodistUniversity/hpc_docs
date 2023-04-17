#!/bin/bash
#SBATCH -J jupyter
#SBATCH -o jupyter_%j.out
#SBATCH -c 1
#SBATCH --mem=6G

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

declare -A d
d["slurm_cluster"]="m2"
d["nvidia"]="superpod"
d["m3"]="m3"
login=$(printf "%s.%s.smu.edu"\
 $SLURM_SUBMIT_HOST\
 ${d[$SLURM_CLUSTER_NAME]})
port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
jupyter lab --no-browser --ip=127.0.0.1 --port=${port} &
while ! $(jupyter server list 2>&1 | grep -q ${port}); do
  sleep 5s
done
url=$(jupyter server list 2>&1 | grep ${port} | cut -d' ' -f2)

echo "# -----------------------------------------------------------------------------"
echo "Mac/Linux/WSL/PowerShell:"
echo "  1. Open new terminal."
echo "  2. Copy and paste into terminal (without quotes):"
echo "     \"ssh -C -L ${port}:$(hostname):${port} ${USER}@${login}\""
echo "  3. Open \"${url}\" in browser."
echo "# -----------------------------------------------------------------------------"

wait

