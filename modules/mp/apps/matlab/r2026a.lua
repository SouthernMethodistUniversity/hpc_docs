whatis("MATLAB R2026a")
family("matlab")

local container_name=os.getenv("APPTAINER_CONTAINER") or  ""
local cuda_visible=os.getenv("CUDA_VISIBLE_DEVICES") or  ""

-- Matlab needs dependencies that are not installed so run 
-- through a container

if (container_name == "") then
   -- make shell functions that run inside a container

   local container_path="/hpc/m3/containers/remote_desktop/remote_desktop_1.3.0.sif"
   if (cuda_visible ~= "") then
     container_path="--nv /hpc/m3/containers/remote_desktop/remote_desktop_1.3.0_gpu.sif"
   end

   setenv("APPTAINERENV_GALLIUM_DRIVER","softpipe")
   prepend_path("APPTAINERENV_PREPEND_PATH","/hpc/mp/apps/matlab/2026a/bin")
   setenv("APPTAINERENV_MATLABROOT","/hpc/mp/apps/matlab/2026a")
  
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

   build_command("matlab", "/hpc/mp/apps/matlab/2026a/bin")

else

  -- already in a container
  -- note: this does not check for the "correct" container so this might
  -- not work
  prepend_path("PATH","/hpc/mp/apps/matlab/2026a/bin")
  prepend_path("LD_LIBRARY_PATH","/hpc/mp/apps/matlab/2026a/bin/glnxa64/")
  setenv("MATLABROOT","/hpc/mp/apps/matlab/2026a")

end

help([[Name: Matlab
Version: 2026a
Website: https://www.mathworks.com/
License Owners: SMU site license


MATLAB is a programming and numeric computing platform used by millions of engineers and scientists to analyze data, develop algorithms, and create models.
]])
