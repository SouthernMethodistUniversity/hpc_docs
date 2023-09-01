whatis("CRYSTAL 23 v1.0.1: Must be member of crystal group. Request access at via help@smu.edu with HPC in the subject line.")
local groups = capture("groups")
if string.match(groups, "crystal") == nil then
   LmodError("\n\nUse of CRYSTAL requires permission.\nRequest permission via help@smu.edu with HPC in the subject line.\n")
else
   family("crystal")
   conflict("crystal")
   load("intel/2023.1")
   load("mpi", "mkl")
   prepend_path("PATH","/hpc/m3/apps/crystal/23/bin/Linux-ifort_i64_omp/v1.0.1")
end

