whatis("GaussView")
local err_message="To use this module you must be in a particular group\n" ..
                  "Please contact help@smu.edu with HPC in the subject to join gaussian group\n"

local valid_groups = userInGroups("hpc-gaussian")

if (not valid_groups) then
  LmodBreak(err_message)
end

family("gaussview")
LmodWarning("GaussView can only be used from an HPC Portal remote desktop session.")
prepend_path("PATH","/hpc/m3/apps/gaussian/gv")

help([[Name: GaussView
Version: 6
Website: https://gaussian.com/
License Owners: Chemistry

Graphical interface used with Gaussian
]])