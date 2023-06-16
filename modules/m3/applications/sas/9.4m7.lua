whatis("loads SAS v9.4 executables in current environment")

local container_name=os.getenv("APPTAINER_CONTAINER") or  ""

-- SAS doesn't run on our base Ubuntu 22.04 directly, so this install
-- currently only runs in the remote desktop container. For users 
-- already on the remote desktop, there's no issue. However, we'll
-- provide shell functions for users trying to run from a normal term.

if (container_name == "") then
   -- make shell functions that run inside a container
   local container_path="/hpc/m3/containers/remote_desktop/remote_desktop_1.0.sif"
  
   always_load('apptainer')

   function build_command(app)
   local app_command = pathJoin("/hpc/m3/apps/sas/9.4_m7/SASFoundation/9.4/", app)
   local cmd        = 'apptainer exec  ' .. container_path .. ' ' .. app_command
   local sh_ending  = ' "$@"'
   local csh_ending = ' $*'
   local sh_cmd     = cmd .. sh_ending
   local csh_cmd    = cmd .. csh_ending
   setenv("APPTAINER_SASHOME","/hpc/m3/apps/sas/9.4_m7")
   set_shell_function(app, sh_cmd, csh_cmd)
   end

   build_command("sas")

else

  -- already in a container
  -- note: this does not check for the "correct" container so this might
  -- not work
  setenv("SASHOME","/hpc/m3/apps/sas/9.4_m7")
  prepend_path("PATH", "/hpc/m3/apps/sas/9.4_m7/SASFoundation/9.4")
  prepend_path("MANPATH", "/hpc/m3/apps/sas/9.4_m7/SASFoundation/9.4/utilities/man")
end
