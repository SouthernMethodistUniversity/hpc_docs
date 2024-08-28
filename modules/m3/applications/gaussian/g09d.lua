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

help([[Name: Gaussian
Version: g09
Website: https://gaussian.com/
License Owners: Chemistry

 Gaussian series of electronic structure programs, used by chemists, chemical engineers, biochemists, physicists and other scientists worldwide.
]])