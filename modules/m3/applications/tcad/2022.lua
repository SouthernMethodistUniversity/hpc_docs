whatis("TCAD: Must be member of tcad group. Request access at smuhpc-admins@smu.edu.")
local groups = capture("groups")
if string.match(groups, "tcad") == nil then
   LmodError("\n\nUse of TCAD requires permission.\nRequest permission via help@smu.edu with HPC in the subject line.\n")
end
family("tcad")
prepend_path("LD_LIBRARY_PATH","/hpc/m3/apps/tcad/2022/lib")
prepend_path("PATH","/hpc/m3/apps/tcad/2022/bin")
setenv("GALLIUM_DRIVER", "softpipe")
