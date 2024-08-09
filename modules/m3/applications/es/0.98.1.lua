load("apptainer")

function build_command(img, cmd)
  local c0  = 'apptainer exec '
  local c1  = ' micromamba run -n base '
  local sh  = ' "$@"'
  local csh = ' $*'
  local c   = c0 .. img .. c1 .. cmd
  set_shell_function(cmd, c .. sh, c .. csh)
end

local img_name      = 'es_latest_amd64_2023_06_21_10_58_08.sif'
local img_directory = '/hpc/m3/containers'
local img_path      = pathJoin(img_directory, img_name)

local executables = {
  'appspack_serial',
  'snprep',
  'syn++'
}

for _, executable in ipairs(executables) do
  build_command(img_path, executable)
end

help([[Name: ES: Elementary Supernova Spectrum Synthesis
Version: 0.98.1
Website: https://c3.lbl.gov/es/

ES: Elementary Supernova Spectrum Synthesis
]])


