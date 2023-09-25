load("apptainer")

local img_name      = 'molden_6.9_amd64_2023_09_25_14_11_27.sif'
local img_directory = '/hpc/m3/containers/'
local img_path      = pathJoin(img_directory, img_name)

function build_command(cmd)
  local cmd_beginning = 'apptainer exec '
  local cmd_ending    = img_path .. ' ' .. cmd
  local sh_ending     = ' "$@"'
  local csh_ending    = ' $*'
  local sh_cmd        = cmd_beginning .. cmd_ending .. sh_ending
  local csh_cmd       = cmd_beginning .. cmd_ending .. csh_ending
  set_shell_function(cmd, sh_cmd, csh_cmd)
end

local executables = {
  'ambfor',
  'ambmd',
  'gmolden',
  'gmolden.exe',
  'molden',
  'surf'
}

for _, executable in ipairs(executables) do
  build_command(executable)
end

