whatis("SNID 5.0")

always_load("apptainer")

local snid = "apptainer run --app snid /hpc/m3/containers/snid/snid_pgplot.simg"
local logwave = "apptainer run --app logwave /hpc/m3/containers/snid/snid_pgplot.simg"
local plotlnw = "apptainer run --app plotlnw /hpc/m3/containers/snid/snid_pgplot.simg"

set_shell_function("snid", snid, snid)
set_shell_function("logwave", logwave, logwave)
set_shell_function("plotlnw", plotlnw, plotlnw)

