
help([[
To use R:

R -- launches an R terminal
Rscript script -- run a scrip

]])
whatis("Name: R")
whatis("Version: geospatial:4.2.3")
whatis("Category: R")
whatis("URL: https://hub.docker.com/r/rocker/geospatial")
whatis("Description: Provides access to R and Rstudio through a Rocker container built with Apptainer")
family("R")

always_load('apptainer')
local sif_file = '/hpc/m3/containers/rocker/rocker_geospatial_4.2.3.sif'

local work_dir = os.getenv("WORK")
local scratch_dir = os.getenv("SCRATCH")
local home = os.getenv("HOME")
local user_libs  = pathJoin(home, 'R/rocker/4.2.3')

function build_command(app)
if app == 'rserver' then
  app = '/usr/lib/rstudio-server/bin/rserver'
end
local cmd        = 'apptainer run  --env R_LIBS_USER=' .. user_libs .. ' -B ' .. scratch_dir .. ',' .. work_dir .. ' ' .. sif_file .. ' ' .. app
local sh_ending  = ' ""'
local csh_ending = ' '
local sh_cmd     = cmd .. sh_ending
local csh_cmd    = cmd .. csh_ending
set_shell_function(app , sh_cmd, csh_cmd)
end

setenv('TMPDIR', '/dev/shm')
setenv('CONTAINER_RSESSION', '/usr/lib/rstudio-server/bin/rsession')
unsetenv('XDG_RUNTIME_DIR')

build_command('R')
build_command('Rscript')
build_command('rserver')
