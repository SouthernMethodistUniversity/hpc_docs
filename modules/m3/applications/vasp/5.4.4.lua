whatis("VASP 5.4.4: Must be member of vasp group. Request access at via help@smu.edu with HPC in the subject line.")

local err_message="To use this module you must be in a particular group\n" ..
                  "Please contact help@smu.edu with HPC in the subject to join vasp group\n"

local found = required_group("vasp")
local found_new = required_group("hpc-vasp")

if (not found and not found_new) then
  LmodError(err_message)
end

family("vasp")
conflict("vasp")
load("gcc/11.2.0", "openmpi/4.1.4-7al4h2x",
      "netlib-scalapack/2.2.0-k6ikp5r", "fftw/3.3.10-gz7qiki",
      "openblas/0.3.21-s5husbk")
prepend_path("PATH","/hpc/m3/apps/vasp/vasp.5.4.4/bin")


