whatis("Gaussian 16 C.02: Must be member of gaussian group. Request access at smuhpc-admins@smu.edu.")
local groups = capture("groups")
if string.match(groups, "gaussian") == nil then
  LmodError("\n\nUse of Gaussian requires permission.\nRequest permission via help@smu.edu with HPC in the subject line.\n")
end
family("gaussian")
load("hpc-sdk/21.3")
setenv("g16root", "/hpc/mp/apps/gaussian/g16c02")
setenv("GAUSS_SCRDIR", os.getenv("SCRATCH"))
source_sh('bash', '/hpc/mp/apps/gaussian/g16c02/g16/bsd/g16.profile')

