--load("apptainer")

local img_name      = 'mojo-v0.6.1-20241001-2212.sif'
local img_directory = '/hpc/m3/containers'
local img_path      = pathJoin(img_directory, img_name)

function build_command(cmd)
  local cmd_beginning = 'apptainer exec --writable-tmpfs '
  local cmd_ending    = img_path .. ' ' .. cmd
  local sh_ending     = ' "$@"'
  local csh_ending    = ' $*'
  local sh_cmd        = cmd_beginning .. cmd_ending .. sh_ending
  local csh_cmd       = cmd_beginning .. cmd_ending .. csh_ending
  set_shell_function(cmd, sh_cmd, csh_cmd)
end

local executables = {
  'mojo'
}

for _, executable in ipairs(executables) do
  build_command(executable)
end

help([[Name: Mojo
Version: 0.6.1
Website: https://www.modular.com/mojo

Mojo is a new programming language that bridges the gap between research and production by combining Python syntax and ecosystem with systems programming and metaprogramming features.
]])
