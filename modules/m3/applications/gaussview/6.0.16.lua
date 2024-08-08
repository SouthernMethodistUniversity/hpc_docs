whatis("GaussView")
local err_message="To use this module you must be in a particular group\n" ..
                  "Please contact help@smu.edu with HPC in the subject to join gaussian group\n"

local found = required_group("gaussian")
local found_new = required_group("hpc-gaussian")

if (not found and not found_new) then
  LmodError(err_message)
end

family("gaussview")
LmodWarning("GaussView can only be used from an HPC Portal remote desktop session.")
prepend_path("PATH","/hpc/m3/apps/gaussian/gv")

