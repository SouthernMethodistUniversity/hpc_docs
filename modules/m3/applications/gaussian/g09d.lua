whatis("Gaussian 09 D: Must be member of gaussian group. Request access at help@smu.edu.")

local err_message="To use this module you must be in a particular group\n" ..
                  "Please contact help@smu.edu with HPC in the subject to join gaussian group\n"

local found = required_group("gaussian")
local found_new = required_group("hpc-gaussian")

if (not found and not found_new) then
  LmodError(err_message)
end

family("gaussian")
load("apptainer")
prepend_path("PATH", "/hpc/m3/apps/gaussian/g09d/g09")

