whatis("GaussView")
local groups = capture("groups")
if string.match(groups, "gaussian") == nil then
   LmodError("\n\nUse of Gaussian requires permission.\nRequest permission via help@smu.edu with HPC in the subject line.\n")
end
family("gaussview")
prepend_path("PATH","/hpc/applications/gaussian/gv")

