whatis("Xtrapol8")
family("xtrapol8")

load("phenix/2.1-6048")
load("ccp4/9.0.015")

set_alias("X8", "phenix.python /hpc/m3/apps/xtrapol8/1.2.9/Fextr.py")
set_alias("XG8", "phenix.python /hpc/m3/apps/xtrapol8/1.2.9/X8_gui.py")

help([[Name: Xtrapol8
Version: 1.2.9
Website: https://github.com/ElkeDeZitter/Xtrapol8

Xtrapol8 is software for the calculation of Fourier difference maps, extrapolated structure factor ampltiudes (ESFAs) and estimation of the occupancy of at triggered state that occupies the crystal at low occupancy.
]])