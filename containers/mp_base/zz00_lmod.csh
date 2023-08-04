#!/bin/csh
# -*- shell-script -*-
########################################################################
#  This is the system wide source file for setting up
#  modules:
#
########################################################################

set MY_NAME="/hpc/mp/spack/opt/spack/linux-ubuntu20.04-zen2/gcc-10.3.0/lmod-8.7.2-uutt23puvwraegsi7w7ck3xbhrgk22mu/lmod/lmod/init/cshrc"



if ( ! $?MODULEPATH_ROOT ) then
    if ( $?USER) then
        setenv USER $LOGNAME
    endif

    set UNAME = `uname`
    setenv LMOD_sys    $UNAME

    setenv LMOD_arch   `uname -m`
    if ( "x$UNAME" == xAIX ) then
        setenv LMOD_arch   rs6k
    endif

    setenv TARG_TITLE_BAR_PAREN " "
    setenv LMOD_FULL_SETTARG_SUPPORT no
    setenv LMOD_SETTARG_CMD     :
    setenv LMOD_COLORIZE        yes
    setenv LMOD_PREPEND_BLOCK   normal
    setenv MODULEPATH_ROOT      ""/hpc/mp/spack/share/spack/modules""
    # setenv MODULEPATH           `/usr/share/lmod/lmod/libexec/addto --append MODULEPATH $MODULEPATH_ROOT/$LMOD_sys $MODULEPATH_ROOT/Core`
    # setenv MODULEPATH           `/usr/share/lmod/lmod/libexec/addto --append MODULEPATH /usr/share/lmod/lmod/modulefiles/Core`
    setenv MODULEPATH           "/hpc/mp/modules"
    setenv MODULESHOME          "/hpc/mp/spack/opt/spack/linux-ubuntu20.04-zen2/gcc-10.3.0/lmod-8.7.2-uutt23puvwraegsi7w7ck3xbhrgk22mu/lmod/lmod"
    setenv BASH_ENV             "$MODULESHOME/init/bash"

    #
    # If MANPATH is empty, Lmod is adding a trailing ":" so that
    # the system MANPATH will be found
    if (! $?MANPATH ) then
      setenv MANPATH :
    endif
    setenv MANPATH `$MODULESHOME/libexec/addto MANPATH $MODULESHOME/share/man`

endif

if ( -f  $MODULESHOME/init/csh  ) then
  source $MODULESHOME/init/csh
endif
