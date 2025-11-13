whatis("CRYSTAL 23 v1.0.1: Must be member of crystal group. Request access at via help@smu.edu with HPC in the subject line.")

local err_message="To use this module you must be in a particular group\n" ..
                  "Please contact help@smu.edu with HPC in the subject to join crystal group\n"

local valid_groups = userInGroups("hpc-crystal")

if (not valid_groups) then
  LmodBreak(err_message)
end

family("crystal")
conflict("crystal")
load("gcc/11.2.0", "openmpi/4.1.6")
prepend_path("PATH","/hpc/m3/apps/crystal/23_1")

help([[Name: Crystal 
Version: 23 v1.0.1-1
Website: https://www.crystal.unito.it/
License Owners : CATCO group

CRYSTAL is a quantum chemistry ab initio program, designed primarily for calculations on crystals (3 dimensions), slabs (2 dimensions) and polymers (1 dimension) using translational symmetry, but it can also be used for single molecules.
]])


