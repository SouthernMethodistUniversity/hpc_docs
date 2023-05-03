whatis("VASP 5.4.4: Must be member of vasp group. Request access at via help@smu.edu with HPC in the subject line.")
local groups = capture("groups")
if string.match(groups, "vasp") == nil then
   LmodError("\n\nUse of VASP requires permission.\nRequest permission via help@smu.edu with HPC in the subject line.\n")
else
   family("vasp")
   conflict("vasp")
   load("gcc/11.2.0", "openmpi/4.1.4-7al4h2x",
        "netlib-scalapack/2.2.0-k6ikp5r", "fftw/3.3.10-gz7qiki",
        "openblas/0.3.21-s5husbk")
   prepend_path("PATH","/hpc/m3/apps/vasp/vasp.5.4.4/bin")
end

