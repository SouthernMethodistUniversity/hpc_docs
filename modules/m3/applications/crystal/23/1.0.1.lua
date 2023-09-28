whatis("CRYSTAL 23 v1.0.1: Must be member of crystal group. Request access at via help@smu.edu with HPC in the subject line.")
local groups = capture("groups")
if string.match(groups, "crystal") == nil then
   LmodError("\n\nUse of CRYSTAL requires permission.\nRequest permission via help@smu.edu with HPC in the subject line.\n")
else
   family("crystal")
   conflict("crystal")
   load("gcc", "openmpi")
   append_path("LD_LIBRARY_PATH", "/hpc/m3/apps/intel/oneapi/2023.1/compiler/2023.1.0/linux/compiler/lib/intel64_lin")
   prepend_path("PATH","/hpc/m3/apps/crystal/23/v1.0.1")
end

