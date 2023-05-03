whatis("Gaussian 09 D: Must be member of gaussian group. Request access at smuhpc-admins@smu.edu.")

local err_message="To use this module you must be in a particular group\n" ..
                  "Please contact smuhpc-admins@smu.edu to join gaussian group\n"

local found = required_group("gaussian")

if (not found) then
  LmodError(err_message)
end

family("gaussian")
load("apptainer")
prepend_path("PATH", "/hpc/m3/apps/gaussian/g09d/g09")

