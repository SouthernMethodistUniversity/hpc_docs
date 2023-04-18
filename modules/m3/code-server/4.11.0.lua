always_load('singularity')
local sif_file = '/hpc/m3/containers/code-server/code-server_amd64-4.11.0.sif'

local work_dir = os.getenv("WORK")
local scratch_dir = os.getenv("SCRATCH")

function build_command(app)
  local cmd        = 'apptainer run  -B ' .. scratch_dir .. ',' .. work_dir .. ' -B /users/jlagrone/repos/hpc_docs/containers/code-server:/host_pwd --pwd /host_pwd ' .. sif_file .. ' ' .. app
  local sh_ending  = ' ""'
  local csh_ending = ' '
  local sh_cmd     = cmd .. sh_ending
  local csh_cmd    = cmd .. csh_ending
  set_shell_function(app , sh_cmd, csh_cmd)
end

build_command('code-server')
