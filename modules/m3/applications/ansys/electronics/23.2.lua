whatis("ANSYS Electronics Package R23.2")
family("ansys")

help([[Name: Ansys Electronics Desktop (HFSS)
Version: 23R2
Website: https://www.ansys.com/
License Owners : SMU?

Ansys Electronics
Electromagnetic, Signal Integrity, Thermal and Electro-Mechanical Simulation Solutions
]])

local container_name=os.getenv("APPTAINER_CONTAINER") or  ""

-- Ansys 23.2 needs GUI stuff not installed on compute nodes, so this install
-- currently only runs in the remote desktop container. For users 
-- already on the remote desktop, there's no issue. However, we'll
-- provide shell functions for users trying to run from a normal term.

if (container_name == "") then
   -- make shell functions that run inside a container
   local container_path="/hpc/m3/containers/remote_desktop/remote_desktop_1.1.sif"
   setenv("APPTAINERENV_GALLIUM_DRIVER","softpipe")
  
   always_load('apptainer')

   function build_command(app)
   local app_command = pathJoin("/hpc/m3/apps/ansys/23R2/AnsysEM/v232/Linux64/", app)
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
  append_path("PATH","/hpc/m3/apps/ansys/23R2/AnsysEM/v232/Linux64/")
  setenv("GALLIUM_DRIVER","softpipe")
end

-- slurm doesn't work work in the almalinux container
-- this breaks ansys because it tries to call slurm commands internally
if string.find(container_name, "almalinux") then

  LmodMessage("\nAnsys may not work as expected in AlmaLinux.\nYou may need to do the following: \n\nunset $(compgen -v | grep \"SLURM\") \nansysedt -local \n\nInside Ansys make sure the number of cores and gpus in the HPC Options menu of the Simulation tab match your job request.\n")

end
