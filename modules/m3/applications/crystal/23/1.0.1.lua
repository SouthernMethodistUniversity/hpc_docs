whatis("CRYSTAL 23 v1.0.1: Must be member of crystal group. Request access at via help@smu.edu with HPC in the subject line.")

local err_message="To use this module you must be in a particular group\n" ..
                  "Please contact smuhpc-admins@smu.edu to join crystal group\n"

local found = required_group("crystal")
local found_new = required_group("hpc-crystal")

if (not found and not found_new) then
  LmodError(err_message)
end

family("crystal")
conflict("crystal")
load("gcc", "openmpi")
append_path("LD_LIBRARY_PATH", "/hpc/m3/apps/intel/oneapi/2023.1/compiler/2023.1.0/linux/compiler/lib/intel64_lin")
prepend_path("PATH","/hpc/m3/apps/crystal/23/v1.0.1")
