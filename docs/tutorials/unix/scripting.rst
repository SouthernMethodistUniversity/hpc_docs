Scripting
#########

Scripting with Bash and Python
==============================

Linux Processes
---------------

A process is an executing program identified by a unique PID (process
identifier). To see information about your processes, with their
associated PID and status, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ps

.. raw:: html

   </div>

A process may be run in the foreground, in the background, or be
suspended. Most Linux jobs are run in the foreground; for those jobs the
shell does not return the command prompt until the process has finished
executing.

Some processes take a long time to run and hold up the terminal.
Backgrounding a long process has the effect that the UNIX prompt is
returned immediately, and other tasks can be carried out while the
original process continues executing.

Running Processes in the Background
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To background a new process, type an ``&`` at the end of the command
line when the program is executed. For example, the command ``sleep``
waits a given number of seconds before continuing. Type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ sleep 10

.. raw:: html

   </div>

This will wait 10 seconds before returning the command prompt ``$``.
Until the command prompt is returned, you can do nothing except wait.

To run ``sleep`` in the background, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ sleep 10 &

    [1] 6259

.. raw:: html

   </div>

The ``&`` runs the job in the background and returns the prompt straight
away, allowing you do run other programs while waiting for that one to
finish. Of course, running ``sleep`` in the background defeats the
purpose of this specific program, but you get the idea.

The first line in the above example is typed in by the user; the next
line, indicating job number and PID, is returned by the machine. The
user is be notified of a job number (numbered from 1) enclosed in square
brackets, together with a PID and is notified when a background process
is finished. Backgrounding is useful for jobs which will take a long
time to complete, or for starting graphical programs that you want to
run alongside the command line.

Backgrounding a Foreground Process
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

At the prompt, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ sleep 600

.. raw:: html

   </div>

This will not return to the prompt for 10 minutes. You can suspend the
process running in the foreground by typing ``^z``, i.e. hold down the
"control" key and type "z". This has suspended the job. To put it in the
background, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ bg

.. raw:: html

   </div>

Note: do not background terminal-based programs that require user
interaction e.g. ``vi`` or ``nano``

Listing Processes
~~~~~~~~~~~~~~~~~

When a process is running, backgrounded or suspended, it will be entered
onto a list along with a job number. To examine this list, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ jobs

.. raw:: html

   </div>

An example of a job list could be

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    [1] Suspended sleep 600
    [2] Running firefox
    [3] Running matlab

.. raw:: html

   </div>

To restart (foreground) a suspended or backgrounded processes, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ fg <jobnumber>

.. raw:: html

   </div>

For example, to bring ``sleep 600`` to the foreground, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ fg 1

.. raw:: html

   </div>

Typing ``fg`` with no job number foregrounds the most-recently suspended
or backgrounded process.

Killing a Process
~~~~~~~~~~~~~~~~~

It is sometimes necessary to kill a process (for example, when an
executing program is in an infinite loop). To kill a job running in the
foreground, type ``^c`` ([control]-[c]. For example, run

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ sleep 100
    ^c

.. raw:: html

   </div>

To kill a suspended or background process, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ kill %<jobnumber>

.. raw:: html

   </div>

For example, run

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ sleep 100 &
    $ jobs

.. raw:: html

   </div>

If ``sleep 100`` is job number 4, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ kill %4

.. raw:: html

   </div>

To check whether this has worked, examine the job list again to see if
the process has been removed.

Alternatively, any process owned by a user (not just one launched from
that terminal) can be killed by finding the process' corresponding ID
number (PID) and using ``kill``

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ sleep 1000 &
    $ ps

      PID TTY          TIME CMD
    32093 ?        00:00:00 sshd
    32094 pts/3    00:00:00 bash
    32259 pts/3    00:00:00 sleep
    32260 pts/3    00:00:00 ps

.. raw:: html

   </div>

To kill off the process ``sleep 1000``, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ kill 32259

.. raw:: html

   </div>

and then type ``ps`` again to see if it has been removed from the list.

If for some reason a process that you own refuses to be killed, you can
try using the ``-9`` option, i.e. type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ kill -9 32259

.. raw:: html

   </div>

Note: It is not possible to kill off other users' processes, unless you
are a "superuser" on that computer.

Summary of commands for interacting with running processes:

+-------------+--------------------------------------------+
| Command     | Meaning                                    |
+=============+============================================+
| *command* & | run *command* in background                |
+-------------+--------------------------------------------+
| ^c          | kill the job running in the foreground     |
+-------------+--------------------------------------------+
| ^z          | suspend the job in the foreground          |
+-------------+--------------------------------------------+
| bg          | background the currently-suspended job     |
+-------------+--------------------------------------------+
| jobs        | list current jobs launched from this shell |
+-------------+--------------------------------------------+
| fg 1        | foreground job number 1                    |
+-------------+--------------------------------------------+
| kill %1     | kill job number 1                          |
+-------------+--------------------------------------------+
| ps          | list current processes                     |
+-------------+--------------------------------------------+
| kill 26152  | kill process number 26152                  |
+-------------+--------------------------------------------+

Bash Scripts
~~~~~~~~~~~~

Basics of Bash shell scripting:

-  The first line of the shell script file should include the line

   .. raw:: html

      <div class="sourceCode">

   .. code:: bash

       #!/bin/bash

   .. raw:: html

      </div>

   to indicate that the script contents should be executed by the Bash
   shell. This line works on Linux and OS X systems; Bash scripting on
   Windows is an entirely different animal!

-  Lines beginning with a ``#`` character are interpreted as comments
   (except for the first line).

As an example, consider the following script:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    #!/bin/bash

    # define the "odd" function, takes one argument
    odd() {
       echo "  $1 is odd"
    }

    # define the "even" function, takes one argument
    even() {
       echo "  $1 is even"
    }

    # define the "other" function, takes one argument
    other() {
       echo "  $1 is neither even nor odd"
    }

    # loop over some integers, checking even/odd
    for i in {1..20}; do
       m=$(($i % 2))
       if [ $m -eq 0 ]; then
          even $i
       elif [ $m -eq 1 ]; then
          odd $i
       else
          other $i
       fi
    done

.. raw:: html

   </div>

The structure of this example should be obvious from the preceding short
examples, except that there are a few notable exceptions:

-  We perform arithmetic: these operations must be of the form
   ``$(( expression ))``.
-  We use the "modulus" operator, ``%``. Other allowable arithmetic
   operators include ``+``, ``-``, ``*`` and ``/``.
-  We perform the logical "equality" operation via ``-eq``. The
   inequality logical operation is ``-ne``. The mathematical <, ≤, > and
   ≥ operators are given by ``-lt``, ``-le``, ``-gt`` and ``-ge``,
   respectively.
-  Bash logic operations may be performed using the standard ``&&``
   (and), ``||`` (or) and ``!`` (not).
-  Function arguments are passed in following the function name; more
   than one function argument may be supplied (though not shown here).

Python Scripts
~~~~~~~~~~~~~~

Basics of Python shell scripting:

-  The first line of the shell script file can include the line

   .. raw:: html

      <div class="sourceCode">

   .. code:: python

       #!/usr/bin/env python

   .. raw:: html

      </div>

   to indicate that the script contents should be executed by the Python
   shell. Again, the above line is usable on Linux and OS X machines,
   and does not apply to Windows.

-  Lines beginning with a ``#`` character are interpreted as comments
   (except for the first line).

As a more lengthy example (akin to the Bash example above), consider the
following script (in ``python_example.py``):

.. raw:: html

   <div class="sourceCode">

.. code:: python

    #!/usr/bin/env python

    # define the "odd" function, takes one argument
    def odd(val):
       print "  ", val, " is odd"

    # define the "even" function, takes one argument
    def even(val):
       print "  ", val, " is even"

    # define the "other" function, takes one argument
    def other(val):
       print "  ", val, " is neither even nor odd"

    # loop over some integers, checking even/odd
    for i in range(1,21):
       m = i % 2
       if m == 0:
          even(i)
       elif m == 1:
          odd(i)
       else:
          other(i)

.. raw:: html

   </div>

As with the previous Bash example, the structure of this example should
be obvious from the preceding explanations, except that there are a few
notable exceptions:

-  We perform the logical "equality" operation via ``==``. The
   inequality logical operation is ``!=``. Similarly, ``<``, ``<=``,
   ``>`` and ``>=`` correspond to the the mathematical <, ≤, > and ≥
   operators.
-  Python logic operations may be combined using ``and``, ``or`` and
   ``not`` (self-explanatory).

Executing Shell Scripts
-----------------------

Shell scripts may be executed in one of two ways. If the script already
has *execute* permissions (ls -l will show an "x" in the fourth column
from the left), then it may be executed like any other Linux program,
through entering the script name at the command prompt. Alternately, a
script may be executed by supplying the file name as an argument to the
appropriate shell.

For example, you may execute the example Bash script from above via

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ bash bash_example.sh

.. raw:: html

   </div>

Alternately, since the first line of the script was set to

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    #!/bin/bash

.. raw:: html

   </div>

then it may be executed by first changing the file permissions to
"executable"

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ chmod +x bash_example.sh

.. raw:: html

   </div>

and then running it like any other Linux program

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ./bash_example.sh

.. raw:: html

   </div>

Similarly, you may execute the example Python script from above via

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ python python_example.py

.. raw:: html

   </div>

It can also be called from an interactive Python session; first enter an
interactive Python session via the shell command:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ python

.. raw:: html

   </div>

and then at the Python prompt enter the command:

.. raw:: html

   <div class="sourceCode">

.. code:: python

    >>> execfile("python_example.py")

.. raw:: html

   </div>

where the ``>>>`` corresponds to the Python prompt (in contrast with the
Bash prompt, ``$``). To exit the interactive Python session, press
``^d`` (as in [control]-[d]).

Similarly to Bash, since the the first line of this Python script is set
to

.. raw:: html

   <div class="sourceCode">

.. code:: python

    #!/usr/bin/env python

.. raw:: html

   </div>

then it may be given execute permissions and run directly via

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ chmod +x python_example.py
    $ ./python_example.py

.. raw:: html

   </div>

Additional resources on both Bash and Python scripting are provided
below.

Bash resources:

-  A Quick Introduction to Bash Programming: `Part
   1 <http://www.codecoffee.com/tipsforlinux/articles2/043.html>`__ and
   `Part
   2 <http://www.codecoffee.com/tipsforlinux/articles2/044.html>`__
-  `Bash Programming -- Introductory
   How-To <http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html>`__
-  `Advanced Bash-Scripting Guide <http://tldp.org/LDP/abs/html/>`__

Python resources:

-  `Codecademy <http://www.codecademy.com/learn>`__
-  `Python short
   course <http://faculty.washington.edu/rjl/classes/am583s2013/notes/index.html#python>`__
-  `Numpy tutorial <http://www.scipy.org/Tentative_NumPy_Tutorial>`__
-  `Introductory Python Tutorial <http://www.learnpython.org/>`__
-  `The Definitive Python
   Tutorial <http://docs.python.org/2/tutorial/>`__


