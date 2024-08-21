whatis("Synopsys Photonic Solutions")
family("photonicsolutions")

local synopsys_root = "/hpc/m3/apps/synopsys/"
local ps_version = "2021.09-3"
local ps_root = pathJoin(synopsys_root, "photonicsolutions")
local ps_root_version = pathJoin(ps_root, ps_version)
local rsoft_programpath = pathJoin(ps_root_version, "rsoft/bin")
local opto_link_base = pathJoin(ps_root_version, "optodesigner/bin")

setenv("PHOTONICS_SOLUTIONS_ROOT", ps_root)
setenv("PHOTONICS_SOLUTIONS_VERSION", ps_version)
setenv("RSOFT_PROGRAMPATH", rsoft_programpath)
setenv("OPTO_LINK_BASE", opto_link_base)
setenv("SNPSLMD_LICENSE_FILE", "27020@sengr7lic2.smu.edu")

prepend_path("PATH", opto_link_base)
prepend_path("PATH", rsoft_programpath)
append_path("LD_LIBRARY_PATH", rsoft_programpath)

help([[Name: Synopsys Photonic Solutions
Version: 2021.09-3
Website: https://www.synopsys.com/photonic-solutions.html

Synopsys Photonic Solutions
]])