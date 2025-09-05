whatis("AMPL")
family("ampl")
conflict("ampl")

local home = os.getenv("HOME")
local hostname = os.getenv('HOSTNAME')

local lic_path = pathJoin(pathJoin(pathJoin(home, '.ampl'), hostname), 'ampl.lic')

setenv("AMPL_LICFILE","lic_path")
setenv("AMPLKEY_RUNTIME_DIR", pathJoin(pathJoin(home, '.ampl'))

append_path("PATH", "/hpc/m3/apps/ampl/ampl_20250811")

local cmd  = '/hpc/m3/apps/ampl/ampl_20250811/ampl < /hpc/m3/apps/ampl/ampl_20250811/activate_key'
set_shell_function(app, cmd, cmd)

help([[Name: AMPL
Version: ampl_20250811
Website: https://ampl.com/
License Owners : Merlin / Teaching Eval Version

AMPL is an algebraic modeling language to describe and solve high-complexity problems for large-scale mathematical computing.
]])