whatis("TCAD: Must be member of tcad group. Request access at smuhpc-admins@smu.edu.")
local groups = capture("groups")
if string.match(groups, "tcad") == nil then
   LmodError("\n\nUse of TCAD requires permission.\nRequest permission via help@smu.edu with HPC in the subject line.\n")
end
family("tcad")

local container_name=os.getenv("APPTAINER_CONTAINER") or  ""

-- TCAD doesn't support Ubuntu, so this install currently only
-- runs in the AlmaLinux remote desktop container. For users 
-- already on the remote desktop, there's no issue. However, we'll
-- provide shell functions for users trying to run from a normal term.

if (container_name == "") then
   -- make shell functions that run inside a container
   local container_path="/hpc/m3/containers/remote_desktop/almalinux_remote_desktop_1.0.0.sif"
   setenv("APPTAINERENV_GALLIUM_DRIVER","softpipe")
  
   always_load('apptainer')

   function build_command(app)
   local app_command = pathJoin("/hpc/m3/apps/tcad/2022/bin", app)
   local cmd        = 'apptainer exec  ' .. container_path .. ' ' .. app_command
   local sh_ending  = ' "$@"'
   local csh_ending = ' $*'
   local sh_cmd     = cmd .. sh_ending
   local csh_cmd    = cmd .. csh_ending
   set_shell_function(app, sh_cmd, csh_cmd)
   end

   build_command("acroreaddevedit3d")
   build_command("maskviews")
   build_command("sflm")
   build_command("sman")
   build_command("stopping3d")
   build_command("victorydevice")
   build_command("athena")
   build_command("firebird")
   build_command("mcdevice")
   build_command("sflm_access")
   build_command("smdb")
   build_command("supdate")
   build_command("victorym")
   build_command("athena1d")
   build_command("ghostprint")
   build_command("mocasim")
   build_command("sflm_monitord")
   build_command("smovie")
   build_command("sysname")
   build_command("victorymesh")
   build_command("atlas")
   build_command("gunzip")
   build_command("opticsdb")
   build_command("s_gcc")
   build_command("s_mpirun")
   build_command("tonyplot")
   build_command("victoryp")
   build_command("dbinternal")
   build_command("gzip")
   build_command("radiant")
   build_command("showid")
   build_command("spayn")
   build_command("tonyplot3d")
   build_command("victoryrcx")
   build_command("deckbuild")
   build_command("implant3d")
   build_command("rpc.sflmserverd")
   build_command("silver")
   build_command("spdfviewer")
   build_command("victorya")
   build_command("victorystress")
   build_command("devedit")
   build_command("iworkbench")
   build_command("sedit")
   build_command("sipc")
   build_command("srdb")
   build_command("victoryd")
   build_command("victoryvisual")

elseif string.find(container_name, "almalinux") then

   -- inside an almalinux container. Just set paths
   prepend_path("LD_LIBRARY_PATH","/hpc/m3/apps/tcad/2022/lib")
   prepend_path("PATH","/hpc/m3/apps/tcad/2022/bin")
   setenv("GALLIUM_DRIVER", "softpipe")

else

LmodError("\n\nTCAD currently only runs in an AlmaLinux based container. If you are using the remote desktop you will need to start a new session using AlmaLinux 8\n")

end
