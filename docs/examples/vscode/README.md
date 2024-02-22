# Visual Studio Code

## Setup

1. Setup SSH keys.
2. Install Visual Studio Code on your local (your machine) as usual and
   then install the "Remote - SSH" extension.

## Using Visual Studio Code with a Cluster Compute Node

1. Log into an SMU HPC cluster.
2. Edit the `vscode.sbatch` with the specific resources needed, e.g.
   cores, memory, GPUs, etc.
3. Submit a job using the edited `vscode.sbatch` script.
4. Once the job is running, add the SSH config entry given in the job's
   output file to your local (your machine) ~/.ssh/config file.
5. Connect to the job's host entry in Visual Studio Code.

