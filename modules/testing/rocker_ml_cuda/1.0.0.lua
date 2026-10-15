
help([[
Name: R + CUDA PyTorch
Version: 1.0.0
Website: https://www.r-project.org/

R is a language and environment for statistical computing and graphics.
This container includes GPU-enabled PyTorch (via reticulate) for V100 GPUs.

To use R:

R -- launches an R terminal
Rscript script -- run a script

]])
whatis("Name: R + CUDA PyTorch")
whatis("Version: rocker/ml:py3.14 + torch 2.14.0 (cu126)")
whatis("Category: R")
whatis("URL: https://hub.docker.com/r/rocker/ml")
whatis("Description: Provides access to R and Rstudio with GPU-enabled PyTorch through a Rocker container built with Apptainer")
family("R")

always_load('apptainer')
local sif_file = '/hpc/m3/containers/testing/rocker/rocker_ml_cuda_1.0.0.sif'

local work_dir = '/work'
local lustre_work = '/lustre/work/client'
local scratch_dir = os.getenv("SCRATCH")
local home = os.getenv("HOME")
local user_libs = pathJoin(home, 'R/rocker_ml_cuda/1.0.0')

function build_command(app)
  local cmd        = 'apptainer run --nv  --env R_LIBS_USER=' .. user_libs .. ' -B ' .. scratch_dir .. ',' .. work_dir .. ',' .. lustre_work .. ' ' .. sif_file .. ' ' .. app
  local sh_ending  = ' "$@"'
  local csh_ending = ' $*'
  local sh_cmd     = cmd .. sh_ending
  local csh_cmd    = cmd .. csh_ending
  set_shell_function(app, sh_cmd, csh_cmd)
end

setenv('CONTAINER_RSESSION', '/usr/lib/rstudio-server/bin/rsession')
setenv('CONTAINER_RSERVER', '/usr/lib/rstudio-server/bin/rserver')
setenv('CONTAINER_R', '/usr/bin/R')
setenv('CONTAINER_IMAGE', '/hpc/m3/containers/testing/rocker/rocker_ml_cuda_1.0.0.sif')
setenv('R_LIBS_USER', user_libs)
unsetenv('XDG_RUNTIME_DIR')

build_command('R')
build_command('Rscript')
