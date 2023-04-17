# SeisBench on ManeFrame II (M2)

## Initial Setup

On M2 via a terminal session run `./initial_setup.sh`. This script takes about
five minutes to complete.

## Usage

`source ./activate_env.sh` will load the Python environment. In the Portal, the
script can be used as well, but with the full path to the script's location
given, *.e.g.* `/hpc/examples/hpc_docs/examples/seisbench/activate_env.sh`.

### HPC Portal

Using the environment with JupyterLab via the HPC Portal:

1. Set "Select Python Environment" to "Custom Environment - only use what is
   specified below".
2. In the "Custom environment settings" field do either
   `source /hpc/examples/hpc_docs/examples/seisbench/activate_env.sh` or paste
   the contents of the `activate_env.sh` script minus the first line into the
   field.
