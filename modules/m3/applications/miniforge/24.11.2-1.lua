whatis("Miniforge")
family("conda")
extensions("conda/24.11.2", "mamba/1.5.12")

source_sh('bash', '/hpc/m3/apps/miniforge/24.11.2-1/etc/profile.d/conda.sh')
source_sh('bash', '/hpc/m3/apps/miniforge/24.11.2-1/etc/profile.d/mamba.sh')

help([[Name: Miniforge
Version: 24.11.2-1
Website: https://github.com/conda-forge/miniforge

Miniforge provides minimal installations for Conda and Mamba with conda-forge pre-configured.
]])