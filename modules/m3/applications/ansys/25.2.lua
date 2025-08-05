whatis("ANSYS")
family("ansys")
extensions("fluent/25R2, ansys/25R2, mapdl/25R2, autodyn/25R2, cfx5/25R2, ansysedt/25R2, siwave/25R2, polyflow/25R2")

help([[Name: Ansys 
Version: 25R2
Website: https://www.ansys.com/
License Owners : SMU?

Ansys Fluent, Mechanical, Workbench
]])

local container_name=os.getenv("APPTAINER_CONTAINER") or  ""

-- Ansys needs GUI stuff not installed on compute nodes, so this install
-- currently only runs in the remote desktop container. For users 
-- already on the remote desktop, there's no issue. However, we'll
-- provide shell functions for users trying to run from a normal term.

if (container_name == "") then
   -- make shell functions that run inside a container
   local container_path="/hpc/m3/containers/remote_desktop/remote_desktop_1.1.8.sif"
   setenv("APPTAINERENV_GALLIUM_DRIVER","softpipe")
  
   always_load('apptainer')

   function build_command(app, app_path)
   local app_command = pathJoin(app_path, app)
   local cmd        = 'apptainer exec  ' .. container_path .. ' ' .. app_command
   local sh_ending  = ' "$@"'
   local csh_ending = ' $*'
   local sh_cmd     = cmd .. sh_ending
   local csh_cmd    = cmd .. csh_ending
   set_shell_function(app, sh_cmd, csh_cmd)
   end

   build_command("runwb2", "/hpc/m3/apps/ansys/25R2/ansys_inc/v252/Framework/bin/Linux64/")
   build_command("fluent", "/hpc/m3/apps/ansys/25R2/ansys_inc/v252/fluent/bin")
   build_command("mapdl", "/hpc/m3/apps/ansys/25R2/ansys_inc/v252/ansys/bin/")
   build_command("ansys251", "/hpc/m3/apps/ansys/25R2/ansys_inc/v252/ansys/bin/")
   build_command("autodyn", "/hpc/m3/apps/ansys/25R2/ansys_inc/v252/autodyn/bin/")
   build_command("cfx5", "/hpc/m3/apps/ansys/25R2/ansys_inc/v252/CFD-Post/bin/")
   build_command("ansysedt", "/hpc/m3/apps/ansys/25R2/ansys_inc/v252/AnsysEM/")
   build_command("siwave", "/hpc/m3/apps/ansys/25R2/ansys_inc/v252/AnsysEM/")
   build_command("polyflow", "/hpc/m3/apps/ansys/25R2/ansys_inc/v252/polyflow/bin/")

else

  -- already in a container
  -- note: this does not check for the "correct" container so this might
  -- not work


  append_path("PATH", "/hpc/m3/apps/ansys/25R2/ansys_inc/v252/Framework/bin/Linux64/")
  append_path("PATH", "/hpc/m3/apps/ansys/25R2/ansys_inc/v252/fluent/bin/")
  append_path("PATH", "/hpc/m3/apps/ansys/25R2/ansys_inc/v252/ansys/bin/")
  append_path("PATH", "/hpc/m3/apps/ansys/25R2/ansys_inc/v252/autodyn/bin/")
  append_path("PATH", "/hpc/m3/apps/ansys/25R2/ansys_inc/v252/CFD-Post/bin/")
  append_path("PATH", "/hpc/m3/apps/ansys/25R2/ansys_inc/v252/AnsysEM/")
  append_path("PATH", "/hpc/m3/apps/ansys/25R2/ansys_inc/v252/polyflow/bin/")
  
  setenv("GALLIUM_DRIVER","softpipe")
end

-- slurm doesn't work work in the almalinux container
-- this breaks ansys because it tries to call slurm commands internally
if string.find(container_name, "almalinux") then

  LmodMessage("\nAnsys may not work as expected in AlmaLinux.\nYou may need to do the following: \n\nunset $(compgen -v | grep \"SLURM\") \nansysedt -local \n\nInside Ansys make sure the number of cores and gpus in the HPC Options menu of the Simulation tab match your job request.\n")

end
