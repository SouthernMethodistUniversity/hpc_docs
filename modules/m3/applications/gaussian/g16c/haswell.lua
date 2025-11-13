whatis("Gaussian 16 C.02: Must be member of gaussian group. Request access at help@smu.edu.")

local err_message="To use this module you must be in a particular group\n" ..
                  "Please contact help@smu.edu with HPC in the subject to join gaussian group\n"

local valid_groups = userInGroups("hpc-gaussian")

if (not valid_groups) then
  LmodBreak(err_message)
end

family("gaussian")
setenv("g16root","/hpc/m3/apps/gaussian/g16c02")
append_path("PERLLIB","/hpc/m3/apps/gaussian/g16c02/gauopen:/hpc/m3/apps/gaussian/g16c02/g16/bsd:/hpc/m3/apps/gaussian/g16c02/g16")
setenv("GAUSS_LFLAGS2","--LindaOptions -s 10000000")
setenv("GAUSS_EXEDIR","/hpc/m3/apps/gaussian/g16c02/g16/bsd:/hpc/m3/apps/gaussian/g16c02/g16")
setenv("GAUSS_BSDDIR","/hpc/m3/apps/gaussian/g16c02/g16/bsd")
setenv("PGI_TERM","trace,abort")
setenv("_DSM_BARRIER","SHM")
append_path("PYTHONPATH","/hpc/m3/apps/gaussian/g16c02/gauopen:/hpc/m3/apps/gaussian/g16c02/g16/bsd:/hpc/m3/apps/gaussian/g16c02/g16")
setenv("GV_DIR","/hpc/m3/apps/gaussian/g16c02/gv")
setenv("G16BASIS","/hpc/m3/apps/gaussian/g16c02/g16/basis")
setenv("GAUSS_ARCHDIR","/hpc/m3/apps/gaussian/g16c02/g16/arch")
append_path("LD_LIBRARY_PATH","/hpc/m3/apps/gaussian/g16c02/g16/bsd:/hpc/m3/apps/gaussian/g16c02/g16:/hpc/m3/apps/gaussian/g16c02/gv/lib")
setenv("GAUSS_LEXEDIR","/hpc/m3/apps/gaussian/g16c02/g16/linda-exe")
append_path("PATH","/hpc/m3/apps/gaussian/g16c02/gauopen:/hpc/m3/apps/gaussian/g16c02/g16/bsd:/hpc/m3/apps/gaussian/g16c02/g16")

help([[Name: Gaussian
Version: g16c
Website: https://gaussian.com/
License Owners: Chemistry

Gaussian series of electronic structure programs, used by chemists, chemical engineers, biochemists, physicists and other scientists worldwide.
]])