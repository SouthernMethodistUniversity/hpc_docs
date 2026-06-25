whatis("Miniforge")
family("conda")
extensions("conda/26.3.2", "mamba/2.5.0")

source_sh('bash', '/hpc/m3/apps/miniforge/26.3.2-3/etc/profile.d/conda.sh')
source_sh('bash', '/hpc/m3/apps/miniforge/26.3.2-3/etc/profile.d/mamba.sh')

help([[Name: Miniforge
Version: 26.3.2-3
Website: https://github.com/conda-forge/miniforge

Miniforge provides minimal installations for Conda and Mamba with conda-forge pre-configured.
]])