whatis("AMPL")
family("ampl")
conflict("ampl")

local home = os.getenv("HOME")
local tmp_hostname = os.getenv('HOSTNAME')
local lic_path = pathJoin(pathJoin(pathJoin(home, '.ampl'), tmp_hostname), 'ampl.lic')

setenv("AMPL_LICFILE", lic_path)
setenv("AMPLKEY_RUNTIME_DIR", pathJoin(home, '.ampl'))

append_path("PATH", "/hpc/m3/apps/ampl/ampl_20260723")

-- local activate_cmd  = '/hpc/m3/apps/ampl/ampl_20260723/ampl < /hpc/m3/apps/ampl/ampl_20260723/activate_key'
-- execute{cmd=activate_cmd, modeA={"load"}}

help([[Name: AMPL
Version: ampl_20260723
Website: https://ampl.com/
License Owners : Eli Olinick

AMPL is an algebraic modeling language to describe and solve high-complexity problems for large-scale mathematical computing.
]])