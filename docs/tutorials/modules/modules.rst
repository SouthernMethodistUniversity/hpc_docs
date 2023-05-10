.. _modules:

:tocdepth: 3

Modules
#######

The *module* system is a command-line tool to help users manage their
Linux environment variables (e.g. ``PATH``, ``LD_LIBRARY_PATH``). It
works by grouping related environment variable settings together based
on various usage scenarios, such as

-  Adding executables to a user's ``PATH``
-  Adding the location of specific software libraries to a user's
   ``LD_LIBRARY_PATH``
-  Adding documentation manual pages "man pages" to a user's ``MANPATH``
-  Creating custom environment variables to define the global path where
   a specific package is installed, e.g. ``FFTWHOME``

These modules may be added/removed dynamically, allowing a user to have
a great amount of control over her/his environment.

Possibly one of the greatest assets of the module system is that it
provides a simple user interface, and can be queried to learn all of the
available modules on a system, making it easier to know which packages
are or aren't already installed on a system.

The module system operates through the Linux executable, ``module``,
followed by the desired command. The primary module commands are as
follows:

-  ``module avail`` -- displays a list of all available modules on the
   system, e.g.

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ module avail

       ------------------------------------ /hpc/modules/applications -------------------------------------
          aimall/17.01.25        gaussian/g16a     (D)    orca/4.0.0        sas/9.4
          allinea/forge-7.0.2    julia/0.5.2              orca/4.0.1 (D)    spack
          autodock_vina/1.1.2    lammps/2016.11.17        python/2          stata/mp-14
          cfour/2.00beta         matlab/r2017a            python/3   (D)    tensorflow/1.2_gpu
          charmm/c41b1           namd/2.12/cpu     (D)    q-chem/5.0        vmd/1.9.3/egl
          gaussian/g03e          namd/2.12/gpu            r/3.4.0           vmd/1.9.3/ogl      (D)
          gaussian/g09d          nbo/6.0                  r/3.4.1    (D)

       -------------------------------------- /hpc/modules/compilers --------------------------------------
          gcc-4.8.5    intel-17.0.4    pgi-12.10    pgi-16.5
          gcc-6.3      llvm-4.0.0      pgi-13.2     pgi-17.4

         Where:
          D:  Default Module

       Use "module spider" to find all possible modules.
       Use "module keyword key1 key2 ..." to search for all possible modules matching any of the "keys".

   .. raw:: html

      </div>

-  ``module list`` -- lists all currently loaded modules in your working
   environment. At first, we have none:

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ module list
       No modules installed

   .. raw:: html

      </div>

-  ``module add`` and ``module load`` -- loads a module into your
   working environment. For example, at the moment matlab is not in our
   PATH:

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ matlab
       -bash: matlab: command not found

   .. raw:: html

      </div>

   but once we load the ``matlab`` module, it is now in our path

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ module load matlab
       $ matlab -nodisplay -nosplash

                                             < M A T L A B (R) >
                                   Copyright 1984-2017 The MathWorks, Inc.
                                    R2017a (9.2.0.556344) 64-bit (glnxa64)
                                                March 27, 2017


       To get started, type one of these: helpwin, helpdesk, or demo.
       For product information, visit www.mathworks.com.

       >> 

   .. raw:: html

      </div>

   and it is listed as being loaded in our environment (after quiting)

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ module list

       Currently Loaded Modules:
         1) matlab/r2017a

   .. raw:: html

      </div>

-  ``module rm`` and ``module unload`` -- undoes a previous "add" or
   "load" command, removing the module from your working environment,
   e.g.

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ module load python
       $ module list

       Currently Loaded Modules:
         1) matlab/r2017a   2) python/3

       $ module unload python
       $ module list

       Currently Loaded Modules:
         1) matlab/r2017a

   .. raw:: html

      </div>

-  ``module switch`` and ``module swap`` -- this does a combination
   unload/load, swapping out one module for another, e.g.

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ module load gcc-6.3 
       $ module load mvapich2
       $ module list

       Currently Loaded Modules:
         1) gcc-6.3   2) mvapich2/2.2-qmt35td

       $ module swap mvapich2 openmpi
       $ module list

       Currently Loaded Modules:
         1) gcc-6.3   2) openmpi/2.1.1-ne4p6t6

   .. raw:: html

      </div>

-  ``module display`` and ``module show`` -- this shows detaled
   information about how a specific module affects your environment,
   e.g.

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ module display r
       ------------------------------------------------------------------------------------------------
          /hpc/modules/applications/r/3.4.1.lua:
       ------------------------------------------------------------------------------------------------
       whatis("Name : r")
       whatis("Version : 3.4.1")
       family("r")
       always_load("gcc-6.3")
       append_path("PATH","/cm/local/apps/curl/bin")
       help([[R is 'GNU S', a freely available language and environment for statistical computing and graphics which provides a wide variety of statistical and graphical techniques: linear and nonlinear modelling, statistical tests, time series analysis, classification, clustering, etc. Please consult the R project homepage for further information.]])
       prepend_path("PATH","/hpc/spack/opt/spack/linux-centos7-x86_64/gcc-6.3.0/r-3.4.1-goez3p22shsw3y54osk56bpiwwjfnjmu/bin")
       prepend_path("CMAKE_PREFIX_PATH","/hpc/spack/opt/spack/linux-centos7-x86_64/gcc-6.3.0/r-3.4.1-goez3p22shsw3y54osk56bpiwwjfnjmu/")
       prepend_path("MANPATH","/hpc/spack/opt/spack/linux-centos7-x86_64/gcc-6.3.0/r-3.4.1-goez3p22shsw3y54osk56bpiwwjfnjmu/share/man")
       prepend_path("XDG_DATA_DIRS","/hpc/spack/opt/spack/linux-centos7-x86_64/gcc-6.3.0/pango-1.40.3-esnuezqtwnztztf5ym5laexnfxyssuj4/share")
       prepend_path("LIBRARY_PATH","/hpc/spack/opt/spack/linux-centos7-x86_64/gcc-6.3.0/r-3.4.1-goez3p22shsw3y54osk56bpiwwjfnjmu/rlib/R/lib")
       prepend_path("LD_LIBRARY_PATH","/hpc/spack/opt/spack/linux-centos7-x86_64/gcc-6.3.0/r-3.4.1-goez3p22shsw3y54osk56bpiwwjfnjmu/rlib/R/lib")
       prepend_path("CPATH","/hpc/spack/opt/spack/linux-centos7-x86_64/gcc-6.3.0/r-3.4.1-goez3p22shsw3y54osk56bpiwwjfnjmu/rlib/R/include")

   .. raw:: html

      </div>

-  ``module help`` -- This displays a set of descriptive information
   about the module (what it does, the version number of the software,
   etc.). This only applies to packages where their "help" pages have
   been installed (none yet on ManeFrame).

Module Example
--------------

As a simple example, let's compare how to do the same task first
without, and then with, the module system. Returning to our previous
example on using Makefiles, we can compile that code using the GCC C++
compiler by using the command

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ /hpc/spack/opt/spack/linux-centos7-x86_64/gcc-4.8.5/gcc-6.3.0-25d5bficqjhp272cil37hy3znbqrqoqj/bin/g++ driver.cpp \
      one_norm.cpp vector_difference.cpp vector_product.cpp \
      vector_sum.cpp -lm -o driver.exe

.. raw:: html

   </div>

While this certainly works, it requires us to know the global PATH to
the ``g++`` compiler. Using the module system, this simplifies to

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ module load gcc-6.3
    $ g++ driver.cpp one_norm.cpp vector_difference.cpp \
      vector_product.cpp vector_sum.cpp -lm -o driver.exe

.. raw:: html

   </div>

Even for this simple example where we only need to add something to our
PATH, the module system can be invaluable since it is rare that you know
the global location of a file when you first log into a new system.

Module Resources:
-----------------

-  `Main Module page <http://modules.sourceforge.net/>`__
-  `Module FAQ <http://sourceforge.net/p/modules/wiki/FAQ/>`__
