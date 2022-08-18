local sif_file = '/hpc/mp/apps/lammps/lammps_04May2022.sif'

function build_command(app)
  local cmd        = 'srun --mpi=pmi2 /hpc/mp/apps/apptainer/1.0.2/bin/singularity run --nv -B /scratch,/work -B $PWD:/host_pwd --pwd /host_pwd ' .. sif_file .. ' ' .. app
  local sh_ending  = ' "$@"'
  local csh_ending = ' $*'
  local sh_cmd     = cmd .. sh_ending
  local csh_cmd    = cmd .. csh_ending
  set_shell_function(app , sh_cmd, csh_cmd)
end

build_command('lmp')

