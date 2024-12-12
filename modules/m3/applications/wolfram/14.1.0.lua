whatis("Wolfram 14.1.0")
family("wolfram")
conflict("mathematica")
conflict("wolfram")

local container_name=os.getenv("APPTAINER_CONTAINER") or  ""
local wolfram_install="/hpc/m3/apps/wolfram/14.1.0"
local wolfram_execs=pathJoin(wolfram_install,"Executables")
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
   local app_command = pathJoin(wolfram_execs, app)
   local cmd        = 'apptainer exec -B /run/user ' .. container_path .. ' ' .. app_command
   local sh_ending  = ' "$@"'
   local csh_ending = ' $*'
   local sh_cmd     = cmd .. sh_ending
   local csh_cmd    = cmd .. csh_ending
   set_shell_function(app, sh_cmd, csh_cmd)
   end

   build_command("math")
   build_command("MathKernel")
   build_command("mcc")
   build_command("wolfram")
   build_command("mcc")
   build_command("wolframnb")
   build_command("WolframNB")
   build_command("WolframKernel")

else

  -- already in a container
  -- note: this does not check for the "correct" container so this might
  -- not work
  append_path("PATH",wolfram_execs)
end

help([[Name: Wolfram
Version: 14.1.0
Website: https://www.wolfram.com/mathematica/
License Owners: SMU site license


Wolfram is a software system with built-in libraries for several areas of technical computing that allow machine learning, statistics, symbolic computation, data manipulation, network analysis, time series analysis, NLP, optimization, plotting functions and various types of data, implementation of algorithms, creation of user interfaces, and interfacing with programs written in other programming languages.
]])