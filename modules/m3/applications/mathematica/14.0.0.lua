whatis("Mathematica 14.0.0")
family("mathematica")
conflict("mathematica")

local container_name=os.getenv("APPTAINER_CONTAINER") or  ""
local mathematica_install="/hpc/m3/apps/mathematica/14.0.0"
local mathematica_execs=pathJoin(mathematica_install,"executables")
-- needs GUI stuff not installed on compute nodes, so this install
-- currently only runs in the remote desktop container. For users 
-- already on the remote desktop, there's no issue. However, we'll
-- provide shell functions for users trying to run from a normal term.
if (container_name == "") then
   -- make shell functions that run inside a container
   local container_path="/hpc/m3/containers/remote_desktop/remote_desktop_1.1.3_gpu.sif"
   setenv("APPTAINERENV_GALLIUM_DRIVER","softpipe")
  
   always_load('apptainer')

   function build_command(app)
   local app_command = pathJoin(mathematica_execs, app)
   local cmd        = 'apptainer exec -B /run/user ' .. container_path .. ' ' .. app_command
   local sh_ending  = ' "$@"'
   local csh_ending = ' $*'
   local sh_cmd     = cmd .. sh_ending
   local csh_cmd    = cmd .. csh_ending
   set_shell_function(app, sh_cmd, csh_cmd)
   end

   build_command("math")
   build_command("mathematica")
   build_command("Mathematica")
   build_command("MathKernel")
   build_command("mcc")
   build_command("wolfram")
   build_command("WolframKernel")

else

  -- already in a container
  -- note: this does not check for the "correct" container so this might
  -- not work
  append_path("PATH",mathematica_execs)
end
