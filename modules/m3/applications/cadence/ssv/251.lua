whatis("Cadence Silicon Signoff and Verification 25.1")
family("ssv")
conflict("ssv")
extensions("tempus/251, voltus/251, litmus/251")


setenv("LM_LICENSE_FILE","/hpc/m3/apps/cadence/license2.dat")
setenv("CDS_LIC_FILE", "5280@sengr7lic3.smu.edu")

prepend_path("PATH","/hpc/m3/apps/cadence/SSV251/bin")
prepend_path("PATH", "/hpc/m3/apps/cadence/SSV251/share/celtic/scripts")
prepend_path("PATH","/hpc/m3/apps/cadence/SSV251/bin/tools")

help([[Name: Cadence Silicon Signoff and Verification 
Version: 25.1
Website: https://www.cadence.com/
License Owners : SMU?

Cadence Silicon Signoff and Verification  Suite.
]])