whatis("MATLAB R2025b")
family("matlab")

local container_name=os.getenv("APPTAINER_CONTAINER") or  ""
local cuda_visible=os.getenv("CUDA_VISIBLE_DEVICES") or  ""

-- Matlab R2025B needs dependencies that are not installed so run 
-- through a container

if (container_name == "") then
   -- make shell functions that run inside a container

   local container_path="/hpc/m3/containers/remote_desktop/remote_desktop_1.2.0.sif"
   if (cuda_visible ~= "") then
     container_path="--nv /hpc/m3/containers/remote_desktop/remote_desktop_1.2.0_gpu.sif"
   end

   setenv("APPTAINERENV_GALLIUM_DRIVER","softpipe")
   prepend_path("APPTAINERENV_PREPEND_PATH","/hpc/m3/apps/Matlab/r2025b/bin")
   setenv("APPTAINERENV_MATLABROOT","/hpc/m3/apps/Matlab/r2025b")
  
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

   build_command("matlab", "matlab")

else

  -- already in a container
  -- note: this does not check for the "correct" container so this might
  -- not work
  prepend_path("PATH","/hpc/m3/apps/Matlab/r2025b/bin")
  prepend_path("LD_LIBRARY_PATH","/hpc/m3/apps/Matlab/r2025b/bin/glnxa64/")
  setenv("MATLABROOT","/hpc/m3/apps/Matlab/r2025b")

end

help([[Name: Matlab
Version: 2025b
Website: https://www.mathworks.com/
License Owners: SMU site license


MATLAB is a programming and numeric computing platform used by millions of engineers and scientists to analyze data, develop algorithms, and create models.
]])
