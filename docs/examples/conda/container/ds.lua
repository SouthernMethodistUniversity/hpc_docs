load("apptainer")

local img_name      = 'ds_latest_2023_02_10_16_07_16.sif'
local work          = os.getenv("WORK")
local img_directory = 'images'
local img_path      = pathJoin(work, img_directory, img_name)

function build_command(cmd)
  local cmd_beginning = 'apptainer exec '
  local sh_ending     = ' "$@"'
  local csh_ending    = ' $*'
  local sh_cmd        = cmd_beginning .. cmd .. sh_ending
  local csh_cmd       = cmd_beginning .. cmd .. csh_ending
  set_shell_function(cmd, sh_cmd, csh_cmd)
end

local executables = {
  'python3'
}

for _, executable in ipairs(executables) do
  build_command(executable)
end

