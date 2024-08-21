whatis("Package Name: TeX Live")
whatis("Version: 2023")

prepend_path("PATH", "/hpc/m3/apps/texlive/2023/bin/x86_64-linux")
prepend_path("INFOPATH", "/hpc/m3/apps/texlive/2023/texmf-dist/doc/info")
prepend_path("MANPATH", "/hpc/m3/apps/texlive/2023/texmf-dist/doc/man")

local home = os.getenv("HOME")
local texmfvar = pathJoin(home, '.texlive2023/texmf-var')
local texmfconfig = pathJoin(home, '.texlive2023/texmf-config')
local texmfhome = pathJoin(home, 'texmf')

setenv('TEXDIR', '/hpc/m3/apps/texlive/2023')
setenv('TEXMFLOCAL', '/hpc/m3/apps/texlive/texmf-local')
setenv('TEXMFSYSVAR', '/hpc/m3/apps/texlive/2023/texmf-var')
setenv('TEXMFSYSCONFIG', '/hpc/m3/apps/texlive/2023/texmf-config')
setenv('TEXMFVAR', texmfvar)
setenv('TEXMFCONFIG', texmfconfig)
setenv('TEXMFHOME', texmfhome)

help([[Name: TeX Live
Version: 2023
Website: https://www.tug.org/texlive/

TeX Live is intended to be a straightforward way to get up and running with the TeX document production system
]])