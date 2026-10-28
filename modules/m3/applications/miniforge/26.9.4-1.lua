whatis("Miniforge")
family("conda")
extensions("conda/26.9.4", "mamba/2.9.0")

if not os.getenv("MAMBA_ROOT_PREFIX") then
  setenv("MAMBA_ROOT_PREFIX", pathJoin(home, '.micromamba'))
end
source_sh('bash', '/hpc/m3/apps/miniforge/26.9.4-1/etc/profile.d/conda.sh')
source_sh('bash', '/hpc/m3/apps/miniforge/26.9.4-1/etc/profile.d/mamba.sh')

help([[Name: Miniforge
Version: 26.9.4-1
Website: https://github.com/conda-forge/miniforge

Miniforge provides minimal installations for Conda and Mamba with conda-forge pre-configured.
]])