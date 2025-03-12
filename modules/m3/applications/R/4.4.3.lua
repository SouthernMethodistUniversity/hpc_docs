
help([[
Name: R
Version: 4.4.3
Website: https://www.r-project.org/

R is a language and environment for statistical computing and graphics.

To use R:

R -- launches an R terminal
Rscript script -- run a script

]])
whatis("Name: R")
whatis("Version: geospatial:4.4.3")
whatis("Category: R")
whatis("URL: https://hub.docker.com/r/rocker/geospatial")
whatis("Description: Provides access to R and Rstudio through a Rocker container built with Apptainer")
family("R")

always_load('apptainer')
local sif_file = '/hpc/m3/containers/rocker/rocker_geospatial_4.4.3.sif'

local work_dir = '/work'
local scratch_dir = os.getenv("SCRATCH")
local home = os.getenv("HOME")
local user_libs = pathJoin(home, 'R/rocker/4.4.3')

function build_command(app)
local cmd        = 'apptainer run  --env R_LIBS_USER=' .. user_libs .. ' -B ' .. scratch_dir .. ',' .. work_dir .. ' ' .. sif_file .. ' ' .. app
local sh_ending  = ' "$@"'
local csh_ending = ' $*'
local sh_cmd     = cmd .. sh_ending
local csh_cmd    = cmd .. csh_ending
set_shell_function(app, sh_cmd, csh_cmd)
end

setenv('CONTAINER_RSESSION', '/usr/lib/rstudio-server/bin/rsession')
setenv('CONTAINER_RSERVER', '/usr/lib/rstudio-server/bin/rserver')
setenv('CONTAINER_R', '/usr/local/bin/R')
setenv('CONTAINER_IMAGE', '/hpc/m3/containers/rocker/rocker_geospatial_4.4.3.sif')
setenv('R_LIBS_USER', user_libs)
unsetenv('XDG_RUNTIME_DIR')

build_command('R')
build_command('Rscript')
