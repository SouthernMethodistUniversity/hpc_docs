
help([[
Name: Biostats + R packages
Version: 1.0.0
Website: https://www.r-project.org/

R is a language and environment for statistical computing and graphics.

To use R:

R -- launches an R terminal
Rscript script -- run a script

]])

whatis("Name: Biostats R")
whatis("Version: ml-verse:4.4.1")
whatis("Category: R")
whatis("URL: https://hub.docker.com/r/rocker/ml-verse")
whatis("Description: Provides access to R and Rstudio through a Rocker container built with Apptainer with additional packages for Biostats")
family("R")

extensions("DEMORT, stacks/2.68, freebayes, trimmonatic/0.39, bwa/0.7.18, pear/0.9.11, fastp/0.24.0, dDocent/2.9.8, fastx-toolkit, fastqc, bowtie2, htseq, star/2.7.11b, sra-tools/3.2.0")

always_load('apptainer')
local sif_file = '/hpc/m3/containers/biostats_r/biostats_r_1.0.0.sif'

local work_dir = '/projects'
local lustre_work = '/lustre/work/client'
local scratch_dir = os.getenv("SCRATCH")
local home = os.getenv("HOME")
local user_libs = pathJoin(home, 'R/biostats_r/1.0.0')

function build_command(app)
local cmd        = 'apptainer run  --env R_LIBS_USER=' .. user_libs .. ' -B ' .. scratch_dir .. ',' .. work_dir .. ',' .. lustre_work .. ' ' .. sif_file .. ' ' .. app
local sh_ending  = ' "$@"'
local csh_ending = ' $*'
local sh_cmd     = cmd .. sh_ending
local csh_cmd    = cmd .. csh_ending
set_shell_function(app, sh_cmd, csh_cmd)
end

setenv('CONTAINER_RSESSION', '/usr/lib/rstudio-server/bin/rsession')
setenv('CONTAINER_RSERVER', '/usr/lib/rstudio-server/bin/rserver')
setenv('CONTAINER_R', '/usr/local/bin/R')
setenv('CONTAINER_IMAGE', '/hpc/m3/containers/biostats_r/biostats_r_1.0.0.sif')
setenv('R_LIBS_USER', user_libs)
unsetenv('XDG_RUNTIME_DIR')

build_command('R')
build_command('Rscript')
 