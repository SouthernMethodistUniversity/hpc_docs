#!/bin/bash
# -*- shell-script -*-
#  Lua based module management.
# -
if [ $(id -u) -ne 0 ] ; then
    export USER=${USER-${LOGNAME}}  # make sure $USER is set
    export LMOD_sys=`uname`

    LMOD_arch=`uname -m`
    if [ "x$LMOD_sys" = xAIX ]; then
      LMOD_arch=rs6k
    fi
    export LMOD_arch
    export LMOD_SETTARG_CMD=":"
    export LMOD_FULL_SETTARG_SUPPORT=no
    export LMOD_COLORIZE=yes
    export LMOD_PREPEND_BLOCK=normal
    export MODULEPATH_ROOT="/hpc/mp/spack/share/spack/modules"
    export MODULEPATH="/hpc/mp/modules"
    export MODULESHOME=/hpc/mp/spack/opt/spack/linux-ubuntu20.04-zen2/gcc-10.3.0/lmod-8.7.2-uutt23puvwraegsi7w7ck3xbhrgk22mu/lmod/lmod
    export BASH_ENV=$MODULESHOME/init/bash
    #
    # If MANPATH is empty, Lmod is adding a trailing ":" so that
    # the system MANPATH will be found
    #
    if [ -z "$MANPATH" ]; then
      export MANPATH=:
    fi
    export MANPATH=$(${MODULESHOME}/libexec/addto MANPATH ${MODULESHOME}/share/man)
    . ${MODULESHOME}/init/bash >/dev/null # Module Support
fi
