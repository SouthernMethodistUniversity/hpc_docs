whatis("ANSYS Electronics Package R23.1")
family("ansys")

local container_name=os.getenv("APPTAINER_CONTAINER") or  ""

-- Ansys 23.1 doesn't support Ubuntu 22.04 directly, so this install
-- currently only runs in the remote desktop container. For users 
-- already on the remote desktop, there's no issue. However, we'll
-- provide shell functions for users trying to run from a normal term.

if (container_name == "") then
   -- make shell functions that run inside a container
   local container_path="/hpc/m3/containers/remote_desktop/remote_desktop_1.0.sif"
   setenv("APPTAINERENV_GALLIUM_DRIVER","softpipe")
  
   always_load('apptainer')

   function build_command(app)
   local app_command = pathJoin("/hpc/m3/apps/ansys/23R1/v231/Linux64", app)
   local cmd        = 'apptainer exec  ' .. container_path .. ' ' .. app_command
   local sh_ending  = ' "$@"'
   local csh_ending = ' $*'
   local sh_cmd     = cmd .. sh_ending
   local csh_cmd    = cmd .. csh_ending
   set_shell_function(app, sh_cmd, csh_cmd)
   end

   build_command("AnsysECADXplorer")
   build_command("ansysedt")
   build_command("AnsysSIXplorer")
   build_command("hfss_pi_setup")
   build_command("hfss_pi_wrapper")
   build_command("nde")
   build_command("siwave")
   build_command("siwave_ng")
   build_command("siwave_ng_wrapper")
   build_command("SIwaveRegionsExtractor")
   build_command("SIwaveToParasolidExport")
   build_command("SUtility")
   build_command("tpa_ng")

else

  -- already in a container
  -- note: this does not check for the "correct" container so this might
  -- not work
  append_path("PATH","/hpc/m3/apps/ansys/23R1/v231/Linux64")
  setenv("GALLIUM_DRIVER","softpipe")
end
