whatis("CRYSTAL 23 v1.0.1: Must be member of crystal group. Request access at via help@smu.edu with HPC in the subject line.")
local groups = capture("groups")
if string.match(groups, "crystal") == nil then
   LmodError("\n\nUse of CRYSTAL requires permission.\nRequest permission via help@smu.edu with HPC in the subject line.\n")
else
   family("crystal")
   conflict("crystal")
   load("gcc/11.2.0", "openmpi/4.1.6")
   prepend_path("PATH","/hpc/m3/apps/crystal/23_1")
end

