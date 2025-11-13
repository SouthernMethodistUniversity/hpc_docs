whatis("Gaussian 16 C.02: Must be member of gaussian group. Request access at help@smu.edu.")

local err_message="To use this module you must be in a particular group\n" ..
                  "Please contact help@smu.edu with HPC in the subject to join gaussian group\n"

local valid_groups = userInGroups("hpc-gaussian")

if (not valid_groups) then
  LmodBreak(err_message)
end

family("gaussian")
load("nvidia/23.5")
local g16root = "/hpc/m3/apps/gaussian/g16c02_zen3"
setenv("g16root", g16root)
setenv("GAUSS_SCRDIR", os.getenv("SCRATCH"))
source_sh('bash', pathJoin(g16root, "g16/bsd/g16.profile"))

help([[Name: Gaussian
Version: g16c
Website: https://gaussian.com/
License Owners: Chemistry

Gaussian series of electronic structure programs, used by chemists, chemical engineers, biochemists, physicists and other scientists worldwide.
]])
