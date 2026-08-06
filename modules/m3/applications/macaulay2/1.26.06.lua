whatis("Macaulay2")
family("macaulay2")

help([[Name: Macaulay2 
Version: 1.26.06
Website: https://macaulay2.com/

Macaulay2 is a software system devoted to supporting research in algebraic geometry and commutative algebra, whose creation has been funded by the National Science Foundation since 1992.
]])

local container_name=os.getenv("APPTAINER_CONTAINER") or  ""
local cuda=os.getenv("CUDA_VISIBLE_DEVICES") or  ""
local container_path="/hpc/m3/containers/remote_desktop/remote_desktop_1.3.1.sif"
local flags=""
if (cuda ~= "") then
  container_path="/hpc/m3/containers/remote_desktop/remote_desktop_1.3.1_gpu.sif"
  flags=" --nv "
end
setenv("CONTAINER_IMAGE", container_path)
setenv("CONTAINER_FLAGS", flags)

-- Macaulay2 is currently installed in remote_desktop_1.3.1

if (container_name ~= "remote_desktop_1.3.1.sif" or container_name ~= "remote_desktop_1.3.1_gpu.sif") then
   -- make shell functions that run inside the appropriate container
   always_load('apptainer')

   function build_command(app, app_path)
   local app_command = pathJoin(app_path, app)
   local cmd        = 'apptainer exec  ' .. flags .. container_path .. ' ' .. app_command
   local sh_ending  = ' "$@"'
   local csh_ending = ' $*'
   local sh_cmd     = cmd .. sh_ending
   local csh_cmd    = cmd .. csh_ending
   set_shell_function(app, sh_cmd, csh_cmd)
   end

   build_command("M2", "M2")
end
