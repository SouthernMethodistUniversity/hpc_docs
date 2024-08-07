whatis("CRYSTAL 23 v1.0.1: Must be member of crystal group. Request access at via help@smu.edu with HPC in the subject line.")

local err_message="To use this module you must be in a particular group\n" ..
                  "Please contact help@smu.edu with HPC in the subject to join crystal group\n"

local found = required_group("crystal")
local found_new = required_group("hpc-crystal")

if (not found and not found_new) then
  LmodError(err_message)
end

family("crystal")
conflict("crystal")
load("gcc/11.2.0", "openmpi/4.1.6")
prepend_path("PATH","/hpc/m3/apps/crystal/23_1")


