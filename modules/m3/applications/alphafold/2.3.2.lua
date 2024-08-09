LmodMessage('The corresponding data directory is /work/data/alphafold/2.3.2,\
 which is also set via the variable `$ALPHAFOLD_DATA`.')

load('apptainer')

local img_name      = 'alphafold_2.3.2_032e2f2_amd64_2024_04_10_14_27_03.sif'
local img_directory = '/hpc/m3/containers/'
local img_path      = pathJoin(img_directory, img_name)

function build_command(name, cmd)
  local cmd_beginning = 'apptainer exec '
  local cmd_ending    = img_path .. ' ' .. cmd
  local sh_ending     = ' "$@"'
  local csh_ending    = ' $*'
  local sh_cmd        = cmd_beginning .. cmd_ending .. sh_ending
  local csh_cmd       = cmd_beginning .. cmd_ending .. csh_ending
  set_shell_function(name, sh_cmd, csh_cmd)
end

setenv('ALPHAFOLD_DATA', '/work/data/alphafold/2.3.2')

build_command('run_alphafold.sh', '/app/run_alphafold.sh')

help([[Name: AlphaFold 
Version: 2.3.2
Website: https://deepmind.google/technologies/alphafold/

AlphaFold is an AI system developed by Google DeepMind that predicts a protein’s 3D structure from its amino acid sequence. It regularly achieves accuracy competitive with experiment.
]])
