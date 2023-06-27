whatis("Gaussian 16 C.02: Must be member of gaussian group. Request access at smuhpc-admins@smu.edu.")
local groups = capture("groups")
if string.match(groups, "gaussian") == nil then
  LmodError("\n\nUse of Gaussian requires permission.\nRequest permission via help@smu.edu with HPC in the subject line.\n")
end
family("gaussian")
load("nvidia/23.5")
local g16root = "/hpc/m3/apps/gaussian/g16c02_zen3"
setenv("g16root", g16root)
setenv("GAUSS_SCRDIR", os.getenv("SCRATCH"))
source_sh('bash', pathJoin(g16root, "g16/bsd/g16.profile"))

