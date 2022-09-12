load('singularity')

local sif_file = '/hpc/mp/apps/amber/amber_16-2022-09-12-1ff1647eed77.simg'

function build_command(name, path)
  local cmd        = 'singularity exec --nv -B /scratch,/work ' .. sif_file .. ' ' .. path
  local sh_ending  = ' "$@"'
  local csh_ending = ' $*'
  local sh_cmd     = cmd .. sh_ending
  local csh_cmd    = cmd .. csh_ending
  set_shell_function(name , sh_cmd, csh_cmd)
end

build_command('pmemd.cuda', '/usr/local/amber/bin/pmemd.cuda')

