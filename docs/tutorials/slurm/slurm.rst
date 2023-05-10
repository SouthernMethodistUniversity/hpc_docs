.. _slurm:

:tocdepth: 3

Slurm
#####

Submitting Jobs Using Slurm
===========================

Before beginning this session, first retrieve the corresponding set of
files either by copying the relevant files at the command line:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cp -R /hpc/examples/workshops/hpc/slurm_tutorial .

.. raw:: html

   </div>

Additionally, we need to set up our environment correctly:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ module load python

.. raw:: html

   </div>

The SLURM Job Scheduler
-----------------------

In this tutorial we'll focus on running serial jobs (both batch and
interactive) on ManeFrame II (we'll discuss parallel jobs in later
tutorial sessions).

In general, a *job scheduler* is a program that manages unattended
background program execution (a.k.a. *batch processing*). The basic
features of any job scheduler include:

-  Interfaces which help to define workflows and/or job dependencies.
-  Automatic submission of executions.
-  Interfaces to monitor the executions.
-  Priorities and/or queues to control the execution order of unrelated
   jobs.

In the context of high-throughput and high-performance computing, the
primary role of a job scheduler is to manage the job queue for all of
the compute nodes of the cluster. It's goal is typically to schedule
queued jobs so that all of the compute nodes are utilized to their
capacity, yet doing so in a fair manner that gives priority to users who
have used less resources and/or contributed more to the acquisition of
the system.

ManeFrame II's SLURM Partitions/Queues
--------------------------------------

There are currently 15 partitions also known as queues available on
ManeFrame II. These queues are designed to allow to various usage
scenarios based on the calculations's expected duration, its degree of
parallelization, and its memory requirements with the goal of allowing
fair access to computational resources for all users. The queues are
described in the following table.

.. include:: common/slurm_flag_table.rst

Types of Queues Available
~~~~~~~~~~~~~~~~~~~~~~~~~

Standard-, Medium-, and High- Memory Compute Nodes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Each of the 176 standard compute nodes has 36 cores, 256 GB of memory,
and 100 Gb/s networking. Specifically, these nodes contain dual Intel
Xeon E5-2695v4 2.1 GHz 18-core “Broadwell” processors with 45 MB of
cache each and 256 GB of DDR4-2400 memory. The “Broadwell”
microarchitecture of these processors is four generations newer than the
“Nehalem”-based Xeon processors in ManeFrame. This translates to more
efficient execution per processor cycle and significantly improved
vectorization via the second-generation Advanced Vector Extensions
(AVX2). In addition, there are 35 medium- and five high-memory compute
nodes which have the same processors, but feature 768 GB and 1,536 GB
(1.5 TB) of DDR4-2400 memory respectively and ManeFrame’s new four 768
GB and six 1,536 GB (1.5 TB) nodes also will be added to the new
cluster. The new and more efficient architecture, high core count, and
high memory capacities of these nodes will provide significant
improvements to existing computationally or memory intensive workflows.

Accelerator Nodes with NVIDIA GPUs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The 36 accelerator nodes with NVIDIA GPUs are configured with dual Intel
Xeon E5-2695v4 2.1 GHz 18-core “Broadwell” processors, 256 GB of
DDR4-2400 memory, and one NVIDIA P100 GPU accelerator. Each NVIDIA P100
GPU has 3584 CUDA cores and 16 GB CoWoS HBM2 memory. The P100 GPU is the
based on the new Pascal architecture and an extremely high bandwidth
(732 GB/s) stacked memory architecture. These GPUs, combined with an
ever-broadening set of drop-in replacement libraries and ever easier to
implement CUDA-based programming environments, make GPU-based
acceleration significantly more approachable for many computationally
intensive applications.

Many-Core Nodes with Intel Xeon Phi Processors
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The 36 many-core nodes are configured with Intel Xeon Phi 7230 (also
known as Knights Landing or KNL) processors and 385 GB of DDR4-2400
memory. Each Xeon Phi has 64 1.30 GHz cores and 16 GB of high bandwidth
(400 GB/s) stacked memory. KNL processors are based on the Intel’s
“Silvermont” Atom processor cores and have hardware-based support for up
to four concurrent threads. A principal benefit of the KNL processors is
that they are based on and binary compatible with x86 architectures and
therefore do not require specialized programming languages or
directives/pragmas.

Virtual Desktop Nodes
^^^^^^^^^^^^^^^^^^^^^

The five virtual desktop nodes will allow researchers remote desktop
access to high-performance compute capability. These nodes can be used
for applications that have demanding remote visualization and/or
rendering requirements. In addition, these virtual desktops can be
configured as either Linux or Windows for a handful of compatible
applications. Each node has dual Intel Xeon E5-2695v4 2.1 GHz 18-core
“Broadwell” processors, 256 GB of DDR4-2400 memory, and one NVIDIA
Quadro M5000 GPU.

SLURM commands
~~~~~~~~~~~~~~

While there are a `multitude of SLURM
commands <https://computing.llnl.gov/linux/slurm/documentation.html>`__,
here we'll focus on those applicable to running batch and interactive
jobs:

-  ``sinfo`` -- displays information about SLURM nodes and partitions
   (queue types). A full list of options is available
   `here <https://computing.llnl.gov/linux/slurm/sinfo.html>`__. The
   usage command (with the most-helpful optional arguments in brackets)
   is

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ sinfo [-a] [-l] [-n <nodes>] [-p <partition>] [-s] [-a] [-a] [-a]

   .. raw:: html

      </div>

   where these options are:

   -  ``-a`` or ``--all`` -- Display information about all partitions
   -  ``-l`` or ``--long`` -- Displays more detailed information
   -  ``-n <nodes>`` or ``--nodes <nodes>`` -- Displays information only
      about the specified node(s). Multiple nodes may be comma separated
      or expressed using a node range expression. For example
      ``mfc[1005-1007].hpc.smu.edu`` would indicate three nodes,
      ``mfc1005.hpc.smu.edu`` through ``mfc1007.hpc.smu.edu``.
   -  ``-p <partition>`` or ``--partition <partition>`` -- Displays
      information only about the specified partition
   -  ``-s`` or ``--summarize`` -- List only a partition state summary
      with no node state details.

   Examples:

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ sinfo --long -p highmem  # long output for all nodes allocated to the "highmem" partition
       $ sinfo -s                 # summarizes output on all nodes on all partitions

   .. raw:: html

      </div>

-  ``squeue`` -- views information about jobs located in the SLURM
   scheduling queue. A full list of options is available
   `here <https://computing.llnl.gov/linux/slurm/squeue.html>`__. The
   usage command (with the most-helpful optional arguments in brackets)
   is

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ squeue [-a] [-j] [-l] [-p] [--start] [-u]

   .. raw:: html

      </div>

   where these options are:

   -  ``-a`` or ``--all`` -- Display information about jobs and job
      steps in all partions.
   -  ``-j <job_id_list>`` or ``--jobs <job_id_list>`` -- Requests a
      comma separated list of job ids to display. Defaults to all jobs.
   -  ``-l`` or ``--long`` -- Reports more of the available information
      for the selected jobs or job steps, subject to any constraints
      specified.
   -  ``-p <part_list>`` or ``--partition <part_list>`` -- Specifies the
      partitions of the jobs or steps to view. Accepts a comma separated
      list of partition names.
   -  ``--start`` -- Reports the *expected* start time of pending jobs,
      in order of increasing start time.
   -  ``-u <user_list>`` or ``--user <user_list>`` -- Requests jobs or
      job steps from a comma separated list of users. The list can
      consist of user names or user id numbers.

   Examples:

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ squeue                            # all jobs
       $ squeue -u rkalescky --start       # anticipated start time of jobs
       $ squeue --jobs 12345,12346,12348   # information on only jobs 12345, 12346 and 12348

   .. raw:: html

      </div>

-  ``sbatch`` -- submits a batch script to SLURM. A full list of options
   is available
   `here <https://computing.llnl.gov/linux/slurm/sbatch.html>`__. The
   usage command is

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ sbatch [options] `<script>` [args]

   .. raw:: html

      </div>

   where ``<script>`` is a *batch submission script*, and ``[args]`` are
   any optional arguments that should be supplied to ``<script>``. The
   ``sbatch`` command accepts a multitude of options; these options may
   be supplied either at the command-line or inside the batch submission
   script.

   It is recommended that all options be specified *inside* the batch
   submission file, to ensure reproducibility of results (i.e. so that
   the same options are specified on each run, and no options are
   accidentally left out). Any command-line ``sbatch`` option may
   equivalently be specified within this script (at the top, before any
   executable commands), preceded by the text ``#SBATCH``.

   These options are discussed in the following section, batch_file.

   Examples:

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ sbatch ./myscript.sh    # submits the batch submission file "myscript.sh" to SLURM

   .. raw:: html

      </div>

-  ``srun`` -- runs a parallel or interactive job on the worker nodes. A
   full list of options is available
   `here <https://computing.llnl.gov/linux/slurm/srun.html>`__. The
   usage command (with the most-helpful optional arguments in brackets)
   is

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ srun [-D <path>] [-e <errf>] [--epilog=<executable>] [-o <outf>] [-p <part>] [--pty] [--x11] <executable>

   .. raw:: html

      </div>

   where these options are:

   -  ``-D <path>`` or ``--chdir=<path>`` -- have the remote processes
      change directories ``<path>`` before beginning execution. The
      default is to change to the current working directory of the
      ``srun`` process.
   -  ``-e <errf>`` or ``--error=<errf>`` -- redirects stderr to the
      file ``<errf>``
   -  ``--epilog=<executable>`` -- run ``executable`` just after the job
      completes. The command line arguments for ``executable`` will be
      the command and arguments of the job itself. If ``executable`` is
      "none", then no epilog will be run.
   -  ``-I`` or ``--immediate[=secs]`` -- exit if requested resources
      not available in "secs" seconds (useful for interactive jobs).
   -  ``-o <outf>`` or ``--output=<outf>`` -- redirects stdout to the
      file ``<outf>``
   -  ``-p <part>`` or ``--partition=<part>`` -- requests that the job
      be run on the requested partition.
   -  ``-N <num>`` or ``--nodes=<num>`` -- requests that the job be run
      using ``<num>`` nodes. *Primarily useful for running parallel
      jobs*
   -  ``-n <num>`` or ``--ntasks=<num>`` -- requests that the job be run
      using ``<num>`` tasks. The default is one task per node.
      *Primarily useful for running parallel jobs*
   -  ``--pty`` -- requests that the task be run in a pseudo-terminal
   -  ``-t <min>`` or ``--time=<min>`` -- sets a limit on the total run
      time of the job. The default/maximum time limit is defined on a
      per-partition basis.
   -  ``--x11=[batch|first|last|all]`` -- exports the X11 display from
      the firstall allocated node(s), so that graphics displayed by this
      process can be forwarded to your screen.
   -  ``<executable>`` -- the actual program to run.

   Examples:

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ srun -p parallel /bin/program # runs executable /bin/program on "parallel" partition
       $ srun --x11=first --pty emacs  # runs "emacs" and forwards graphics
       $ srun --x11=first --pty $SHELL # runs a the user's current shell and forwards graphics

   .. raw:: html

      </div>

-  ``salloc`` -- obtains a SLURM job allocation (a set of nodes),
   executes a command, and then releases the allocation when the command
   is finished. A full list of options is available
   `here <https://computing.llnl.gov/linux/slurm/salloc.html>`__. The
   usage command is

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ salloc [options] <command> [command args]

   .. raw:: html

      </div>

   where ``<command> [command args]`` specifies the command (and any
   arguments) to run. Available options are almost identical to
   ``srun``, including:

   -  ``-D <path>`` or ``--chdir=<path>`` -- change directory to
      ``<path>`` before beginning execution.
   -  ``-I`` or ``--immediate[=secs]`` -- exit if requested resources
      not available in "secs" seconds (useful for interactive jobs).
   -  ``-p <part>`` or ``--partition=<part>`` -- requests that the job
      be run on the requested partition.
   -  ``-t <min>`` or ``--time=<min>`` -- sets a limit on the total run
      time of the job. The default/maximum time limit is defined on a
      per-partition basis.
   -  ``--x11=[batch|first|last|all]`` -- exports the X11 display from
      the firstall allocated node(s), so that graphics displayed by this
      process can be forwarded to your screen.

-  ``scancel`` -- kills jobs or job steps that are under the control of
   SLURM (and listed by ``squeue``. A full list of options is available
   `here <https://computing.llnl.gov/linux/slurm/scancel.html>`__. The
   usage command (with the most-helpful optional arguments in brackets)
   is

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ scancel [-i] [-n <job_name>] [-p <part>] [-t <state>] [-u <uname>] [jobid]

   .. raw:: html

      </div>

   where these options are:

   -  ``-i`` or ``--interactive`` -- require response from user for each
      job (used when cancelling multiple jobs at once)
   -  ``-n <job_name>`` or ``--name=<job_name>`` -- cancel only on jobs
      with the specified name.
   -  ``-p <part>`` or ``--partition=<part>`` -- cancel only on jobs in
      the specified partition.
   -  ``-t <state>`` or ``--state=<state>`` -- cancel only on jobs in
      the specified state. Valid job states are ``PENDING``, ``RUNNING``
      and ``SUSPENDED``
   -  ``-u <uname>`` or ``--user=<uname>`` -- cancel only on jobs of the
      specified user (note: normal users can only cancel their own
      jobs).
   -  ``jobid`` is the numeric job identifier (as shown by ``squeue``)
      of the job to cancel.

   Examples:

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       $ scancel 1234  # cancel job number 1234
       $ scancel -u rkalescky  # cancel all jobs owned by user "rkalescky"
       $ scancel -t PENDING -u joe  # cancel all pending jobs owned by user "joe"

   .. raw:: html

      </div>

Example: Running Interactive Jobs
---------------------------------

In this example, we'll interactively run the Python script
``pi_monte_carlo.py``, that performs a simple algorithm for
approximating *π* using a Monte Carlo method.

This script accepts a single integer-valued command-line argument,
corresponding to the number of random values to use in the
approximation, with the typical tradeoff that *the harder you work, the
better your answer*.

While you can run this at the command line:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ python ./pi_monte_carlo.py 50

.. raw:: html

   </div>

as we increase the number of random values to obtain a more accurate
approximation it can take longer to run, so as "good citizens" we should
instead run it on dedicated compute nodes instead of the shared login
nodes.

Before running this script on a compute node, we need to ensure that
``myjob.py`` has "executable" permissions:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ chmod +x ./pi_monte_carlo.py

.. raw:: html

   </div>

We'll use ``srun`` to run this script interactively for interval values
of {50,500,5000,50000}. For each run, we'll direct the output to a
separate file:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ srun -o run_50.txt ./pi_monte_carlo.py 50
    $ srun -o run_500.txt ./pi_monte_carlo.py 500
    $ srun -o run_5000.txt ./mpi_monte_carlo.py 5000
    $ srun -o run_50000.txt ./pi_monte_carlo.py 50000

.. raw:: html

   </div>

Upon completion you should have the files ``run_50.txt``,
``run_500.txt``, ``run_5000.txt`` and ``run_50000.txt`` in your
directory. View the results to ensure that things ran properly:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cat run_*

.. raw:: html

   </div>

in the above commands we do not need to directly specify to run on the
"development" SLURM partition, since that is the default partition.

Batch Job Submission File
-------------------------

The standard way that a user submits batch jobs to run on SLURM is
through creating a *job submission file* that describes (and executes)
the job you want to run. This is the ``<script>`` file specified to the
``sbatch`` command.

A batch submission script is just that, a shell script. You are welcome
to use your preferred shell scripting language; in this tutorial we'll
use Bash. As a result, the script typically starts with the line

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    #!/bin/bash

.. raw:: html

   </div>

The following lines (before any executable commands) contain the options
to be supplied to the ``sbatch`` command. Each of these options must be
prepended with the text ``#SBATCH``, e.g.

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    #!/bin/bash
    #SBATCH -J my_program       # job name to display in squeue
    #SBATCH -o output-%j.txt    # standard output file
    #SBATCH -e error-%j.txt     # standard error file
    #SBATCH -p development      # requested partition
    #SBATCH -t 180              # maximum runtime in minutes

.. raw:: html

   </div>

Since each of these ``sbatch`` options begins with the character ``#``,
they are treated as comments by the Bash shell; however ``sbatch``
parses the file to find these and supply them as options for the job.

After all of the requested options have been specified, you can supply
any number of executable lines, variable definitions, and even
functions, as with any other Bash script.

Unlike general Bash scripts, there are a few SLURM replacement symbols
(variables) that may be used within your script:

-  ``%A`` -- the master job allocation number (only meaningful for job
   arrays (advanced usage))
-  ``%a`` -- the job array ID (index) number (also only meaningful for
   job arrays)
-  ``%j`` -- the job allocation number (the number listed by ``squeue``)
-  ``%N`` -- the node name. If running a job on multiple nodes, this
   will map to only the first node on the job (i.e. the node that
   actually runs the script).
-  ``%u`` -- your username

The available options to ``sbatch`` are
`numerous <https://computing.llnl.gov/linux/slurm/sbatch.html>`__. Here
we list the most useful options for running serial batch jobs.

-  ``-D <dir>`` or ``--workdir=<dir>`` -- sets the working directory
   where the batch script should be run, e.g.

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       #SBATCH -D /scratch/users/ezekiel/test_run

   .. raw:: html

      </div>

-  ``-J <name>`` or ``--job-name=<name>`` -- sets the job name as output
   by the ``squeue`` command, e.g.

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       #SBATCH -J test_job

   .. raw:: html

      </div>

-  ``-o <fname>`` -- sets the output file name for stdout and stderr (if
   stderr is left unspecified). The default standard output is directed
   to a file of the name ``slurm-%j.out``, where ``%j`` corresponds to
   the job ID number. You can do something similar, e.g.

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       #SBATCH -o output-%j.txt

   .. raw:: html

      </div>

-  ``-e <fname>`` -- sets the output file name for stderr only. The
   default is to combine this with stdout. An example similar to ``-o``
   above would be

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       #SBATCH -e error-%j.txt

   .. raw:: html

      </div>

-  ``-i <fname>`` or ``--input=<fname>`` -- sets the standard input
   stream for the running job. For example, if an executable program
   will prompt the user for text input, these inputs may be placed in a
   file ``inputs.txt`` and specified to the script via

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       #SBATCH -i inputs.txt

   .. raw:: html

      </div>

-  ``-p <part>`` -- tells SLURM on which partition it should submit the
   job. The options are "interactive", "highmem" or "parallel". For
   example, so submit a batch job to a high-memory node you would use

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       #SBATCH -p highmem

   .. raw:: html

      </div>

-  ``-t <num>`` -- tells SLURM the maximum runtime to be allowed for the
   job (in minutes). For example, to allow a job to run for up to 3
   hours you would use

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       #SBATCH -t 180

   .. raw:: html

      </div>

-  ``--exclusive`` -- tells SLURM that the job can not share nodes with
   other running jobs.

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       #SBATCH --exclusive

   .. raw:: html

      </div>

-  ``-s`` or ``--share`` -- tells SLURM that the job can share nodes
   with other running jobs. This is the opposite of ``--exclusive``,
   whichever option is seen last on the command line will be used. This
   option may result the allocation being granted sooner than if the
   ``--share`` option was not set and allow higher system utilization,
   but application performance will likely suffer due to competition for
   resources within a node.

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       #SBATCH -s

   .. raw:: html

      </div>

-  ``--mail-user <email address>`` -- tells SLURM your email address if
   you'd like to receive job-related email notifications, e.g.

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       #SBATCH --mail-user peruna@smu.edu

   .. raw:: html

      </div>

-  ``--mail-type=<flag>`` -- tells SLURM which types of email
   notification messages you wish to receive. Options include:

   -  ``BEGIN`` -- send a message when the run starts
   -  ``END`` -- send a message when the run ends
   -  ``FAIL`` -- send a message if the run failed for some reason
   -  ``REQUEUE`` -- send a message if and when the job is requeued
   -  ``ALL`` -- send a message for all of the above

   For example,

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       #SBATCH --mail-type=all

   .. raw:: html

      </div>

Running Batch Jobs
------------------

Here we'll look at six ways to run jobs on ManeFrame II using Slurm.

1. Interactive session via srun
2. Single interactive job via srun
3. Single threaded batch job via sbatch's wrapping function
4. Single threaded batch job via batch script
5. Single multi-threaded job via batch script
6. Array of single threaded jobs via batch script

Interactive Session Via ``srun``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    module load python
    srun -p htc --pty $SHELL
    python pi_monte_carlo.py 1000

.. raw:: html

   </div>

This method involves interactively requesting a HTC compute node and
then running the calculation manually.

Single Interactive Job Via ``srun``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    srun -p htc python pi_monte_carlo.py 1000

.. raw:: html

   </div>

This method interactively requests that the calculation be directly run
on the requested resource.

Single-Threaded Batch Job via ``sbatch``'s Wrapping Function
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    sbatch -p htc --wrap "sleep 30; time python pi_monte_carlo.py 1000"

.. raw:: html

   </div>

This method submits a batch job by wrapping the command line that you
wish to run in an ``sbatch`` script that is then submited for you. This
method is non-interactive.

Single Threaded Batch Job via Batch Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    #!/bin/bash
    #SBATCH -J python
    #SBATCH -o python_%j.out
    #SBATCH -p htc

    module purge
    module load python

    time python pi_monte_carlo.py 1000

.. raw:: html

   </div>

This batch script is manually creatd and then submited via
``sbatch 04_sbatch_htc.sbatch``.

Single Multi-Threaded Job via Batch Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    #!/bin/bash
    #SBATCH -J pi
    #SBATCH -o pi_%j.out
    #SBATCH -p development
    #SBATCH -N 1
    #SBATCH --ntasks-per-node=2

    module purge
    module load python

    time python pi_monte_carlo_shared.py 10000000 ${SLURM_NTASKS}

.. raw:: html

   </div>

This batch script runs a parallel version of the Monte Carlo *π*
approximation script on two cores.

Array of Single Threaded Jobs via Batch Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    #!/bin/bash
    #SBATCH -J pi_array
    #SBATCH -o pi_array_%a-%A.out
    #SBATCH --array=1-4%2
    #SBATCH -p development

    module purge
    module load python

    time python pi_monte_carlo.py $((10**${SLURM_ARRAY_JOB_ID}))

.. raw:: html

   </div>

This batch script submits a job that will perform an array of jobs in
parallel as allowed by the queue system.
