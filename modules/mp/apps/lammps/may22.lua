local sif_file = '/hpc/mp/apps/lammps/lammps_04May2022.sif'

function build_command(app)
  local cmd        = 'srun --mpi=pmi2 /hpc/mp/apps/apptainer/1.1.9/bin/apptainer run --nv -B /scratch,/work -B $PWD:/host_pwd --pwd /host_pwd ' .. sif_file .. ' ' .. app
  local sh_ending  = ' "$@"'
  local csh_ending = ' $*'
  local sh_cmd     = cmd .. sh_ending
  local csh_cmd    = cmd .. csh_ending
  set_shell_function(app , sh_cmd, csh_cmd)
end

build_command('lmp')

help([[Name: LAMMPS
Version: 04May2022
Website: https://www.lammps.org/

LAMMPS is a classical molecular dynamics code with a focus on materials modeling. It's an acronym for Large-scale Atomic/Molecular Massively Parallel Simulator.
]])