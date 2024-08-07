UNIX & Linux
############

Introduction to UNIX
====================

The internet is full of `useful UNIX/Linux
tutorials <https://www.google.com/search?q=unix+tutorial>`__; this is just one
more, but hopefully it will be brief yet thorough enough to learn the
basics of using UNIX/Linux insofar as will be needed for the remainder of
this documentation. The contents of this tutorial are adapted from an `online
UNIX tutorial <http://www.ee.surrey.ac.uk/Teaching/Unix/>`__ by `Michael
Stonebank <https://www.linkedin.com/in/mstonebank>`__.

Introduction to the UNIX and UNIX-Like Operating Systems
--------------------------------------------------------

What is UNIX/Linux?
~~~~~~~~~~~~~~~~~~~

UNIX is an operating system which was first developed in the 1960s, and
has been under constant development ever since. By operating system, we
mean the suite of programs which make the computer work. It is a stable,
multi-user, multi-tasking system for servers, desktops and laptops.

UNIX systems also have a graphical user interface (GUI) similar to
Microsoft Windows which provides an easy to use environment. However,
knowledge of UNIX is required for operations which aren't covered by a
graphical program, or for when there is no windows interface available,
for example, in a ssh session.

Types of UNIX
~~~~~~~~~~~~~

There are many different versions of UNIX, although they share common
similarities. The most popular varieties of UNIX are GNU/Linux and macOS.
Within the "Linux" category, there are a multitude of flavors: Debian
(Ubuntu, Mint, Crunchbang), RedHat (RHEL, Fedora, CentOS), SuSE, etc.

The UNIX operating system
~~~~~~~~~~~~~~~~~~~~~~~~~

The UNIX operating system is made up of three parts; the kernel, the
shell, and the programs.

The kernel
^^^^^^^^^^

The kernel of UNIX is the hub of the operating system: it allocates time
and memory to programs and handles the filestore and communications in
response to system calls.

As an illustration of the way that the shell and the kernel work
together, suppose a user types

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ rm myfile

.. raw:: html

   </div>

(which has the effect of removing the file ``myfile``). The shell
searches the filestore for the file containing the program ``rm``, and
then requests the kernel, through system calls, to execute the program
``rm`` on ``myfile``. When the process ``rm myfile`` has finished
running, the shell then returns the UNIX prompt ``$`` to the user,
indicating that it is waiting for further commands.

The shell
^^^^^^^^^

The shell acts as an interface between the user and the kernel. When a
user logs in, the login program checks the username and password, and
then starts another program called the shell. The shell is a command
line interpreter (CLI). It interprets the commands the user types in and
arranges for them to be carried out. The commands are themselves
programs: when they terminate, the shell gives the user another prompt.

The adept user can customize his/her own shell, and users can use
different shells on the same machine. Users will typically have the TCSH
shell or Bash shell by default (Bash is typically the default on modern
Linux distributions).

These shells have certain features to help the user inputting commands:

-  **Filename Completion** - By typing part of the name of a command,
   filename or directory and pressing the [Tab] key, the ``tcsh`` and
   ``bash`` shells will complete the rest of the name automatically. If
   the shell finds more than one name beginning with those letters you
   have typed, it will beep, prompting you to type a few more letters
   before pressing the [Tab] key again.
-  **History** - The shell keeps a list of the commands you have typed
   in. If you need to repeat a command, use the cursor keys to scroll up
   and down the list or type history for a list of previous commands.

Files and processes
~~~~~~~~~~~~~~~~~~~

Everything in UNIX is either a file or a process.

A process is an executing program identified by a unique PID (process
identifier).

A file is a collection of data. They are created by users using text
editors, running compilers etc.

Examples of files:

-  a document (report, essay etc.);
-  the text of a program written in some high-level programming language;
-  instructions comprehensible directly to the machine and
   incomprehensible to a casual user, for example, a collection of
   binary digits (an executable or binary file);
-  a directory, containing information about its contents, which may be
   a mixture of other directories (subdirectories) and ordinary files.

The Directory Structure
~~~~~~~~~~~~~~~~~~~~~~~

All the files are grouped together in the directory structure. The
file-system is arranged in a hierarchical structure, like an inverted
tree. The top of the hierarchy is traditionally called *root* (written
as a slash ``/``)

.. raw:: html

   <div class="figure">

|UNIX directory structure example|

UNIX directory structure example

.. raw:: html

   </div>

In the diagram above, we see that the directory ``ee51vn`` contains two
sub-directories (``docs`` and ``pics``) and a file called
``report.doc``.

The full path to the file ``report.doc`` is
``/home/its/ug1/ee51vn/report.doc``.

Moving Around the Filesystem
----------------------------

Listing files and directories
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ls (list)
^^^^^^^^^

When you first login, your current working directory is your home
directory. Your home directory has the same name as your user-name, e.g.
``rkalescky``, and it is where your personal files and subdirectories
are saved.

To find out what is in your home directory, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ls

.. raw:: html

   </div>

The ``ls`` command lists the contents of your current working directory.

.. raw:: html

   <div class="figure">

|Unix Terminal - running the ls command|

Unix Terminal - running the ``ls`` command

.. raw:: html

   </div>

There may be no files visible in your home directory, in which case, the
UNIX prompt will be returned. Alternatively, there may already be some
files inserted by the System Administrator when your account was
created.

``ls`` does not, in fact, cause all the files in your home directory to
be listed, but only those ones whose name does not begin with a dot (.)
Files beginning with a dot (.) are "hidden" files and usually contain
important program configuration information. They are hidden because you
should not change them unless you are very familiar with UNIX.

To list all files in your home directory including those whose names
begin with a dot, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ls -a

.. raw:: html

   </div>

As you can see, ``ls -a`` lists files that are normally hidden.

.. raw:: html

   <div class="figure">

|Unix Terminal - running the ls -a command|

Unix Terminal - running the ``ls -a`` command

.. raw:: html

   </div>

``ls`` is an example of a command which can take options: ``-a`` is an
example of an option. The options change the behaviour of the command.
There are online manual pages that tell you which options a particular
command can take, and how each option modifies the behaviour of the
command. (See later in this tutorial).

Making Directories
~~~~~~~~~~~~~~~~~~

mkdir (make directory)
^^^^^^^^^^^^^^^^^^^^^^

We will now make a subdirectory in your home directory to hold the files
you will be creating and using in the course of this tutorial. To make a
subdirectory called ``unixstuff`` in your current working directory type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ mkdir unixstuff

.. raw:: html

   </div>

To see the directory you have just created, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ls

.. raw:: html

   </div>

Or to see what is inside of the directory ``unixstuff``, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ls unixstuff

.. raw:: html

   </div>

Changing to a different directory
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cd (change directory)
^^^^^^^^^^^^^^^^^^^^^

The command ``cd directory`` means change the current working directory
to ``directory``. The current working directory may be thought of as the
directory you are in, i.e. your current position in the file-system
tree.

To change to the directory you have just made, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cd unixstuff

.. raw:: html

   </div>

Type ``ls`` to see the contents (which should be empty).

Exercise
^^^^^^^^

Make another directory inside the ``unixstuff`` directory called
``backups``.

The directories . and ..
~~~~~~~~~~~~~~~~~~~~~~~~

While still in the ``unixstuff`` directory, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ls -a

.. raw:: html

   </div>

As you can see, in the ``unixstuff`` directory (and in all other
directories), there are two special directories called ``.`` and ``..``

. <. (the current directory)>
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In UNIX, ``.`` means the current directory, so typing

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cd .

.. raw:: html

   </div>

.. raw:: html

   <div class="admonition note">

there is a space between ``cd`` and ``.``

.. raw:: html

   </div>

means stay where you are (in the ``unixstuff`` directory).

This may not seem very useful at first, but using ``.`` as the name of
the current directory will save a lot of typing, as we shall see later
in the tutorial.

``..`` (the parent directory)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The other "special" directory in UNIX, ``..``, refers to the parent of
the current directory, so typing

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cd ..

.. raw:: html

   </div>

will take you one directory up the hierarchy (back to your home
directory). Try it now.

.. raw:: html

   <div class="admonition note">

typing ``cd`` with no argument always returns you to your
    home directory. This is very useful if you somehow get lost in the
    file-system.

.. raw:: html

   </div>

Pathnames
~~~~~~~~~

pwd (print working directory)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Pathnames enable you to work out where you are in relation to the whole
file-system. For example, to find out the absolute pathname of your
home-directory, type ``cd`` to get back to your home-directory and then
type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ pwd

.. raw:: html

   </div>

which should give you something like this,

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    /users/rkalescky

.. raw:: html

   </div>

Suppose you were on the computer from our example UNIX directory
structure figure (reproduced again below). There, typing ``pwd`` in the
``ee51vn`` sub-directory would produce

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    /home/its/ug1/ee51vn

.. raw:: html

   </div>

which means that ``ee51vn`` is in the sub-directory ``ug1``, which in
turn is located in the ``its`` sub-directory, which is in the ``home``
sub-directory, which is in the top-level root directory called ``/``.

.. raw:: html

   <div class="figure">

|UNIX directory structure example|

UNIX directory structure example

.. raw:: html

   </div>

.. exercise-1:

Exercise
^^^^^^^^

Use the commands ``cd``, ``ls`` and ``pwd`` to explore the file-system.

(Remember, if you get lost, type ``cd`` by itself to return home).

More about home directories and pathnames
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Understanding pathnames
^^^^^^^^^^^^^^^^^^^^^^^

Go back to your home-directory and then type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ls unixstuff

.. raw:: html

   </div>

to list the contents of your unixstuff directory. Now type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ls backups

.. raw:: html

   </div>

You will get a message like this

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    /bin/ls: cannot access backups: No such file or directory

.. raw:: html

   </div>

The reason is, ``backups`` is not in your current working directory. To
use a command on a file (or directory) not in the current working
directory (the directory you are currently in), you must either ``cd``
to the correct directory, or specify its full pathname. To list the
contents of the ``backups`` directory that we made earlier, you must
instead type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ls unixstuff/backups

.. raw:: html

   </div>

~ (your home directory)
^^^^^^^^^^^^^^^^^^^^^^^

Home directories can also be referred to by the tilde character, ``~``.
It can be used to specify paths starting at your home directory. So
typing

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ls ~/unixstuff

.. raw:: html

   </div>

will list the contents of your ``unixstuff`` directory, *no matter where
you currently are in the file-system*.

What do you imagine that

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ls ~

.. raw:: html

   </div>

would list? What do you think that

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ls ~/..

.. raw:: html

   </div>

would list?

Moving around the filesystem -- summary
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+--------------+--------------------------------------------------------+
| Command      | Meaning                                                |
+==============+========================================================+
| ls           | list files and directories                             |
+--------------+--------------------------------------------------------+
| ls -a        | list all files and directories (including hidden ones) |
+--------------+--------------------------------------------------------+
| mkdir        | make a directory                                       |
+--------------+--------------------------------------------------------+
| cd directory | change to named directory                              |
+--------------+--------------------------------------------------------+
| cd           | change to home-directory                               |
+--------------+--------------------------------------------------------+
| cd ~         | change to home-directory                               |
+--------------+--------------------------------------------------------+
| cd ..        | change to parent directory                             |
+--------------+--------------------------------------------------------+
| pwd          | display the path of the current directory              |
+--------------+--------------------------------------------------------+

Manipulating Files and Directories
----------------------------------

Copying Files
~~~~~~~~~~~~~

cp (copy)
^^^^^^^^^

``cp file1 file2`` is the command which makes a copy of ``file1`` in the
current working directory and calls it ``file2``.

What we are going to do now, is to take a file stored in an open access
area of the file system, and use the ``cp`` command to copy it to your
``unixstuff`` directory.

First, go to your ``unixstuff`` directory.

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cd ~/unixstuff

.. raw:: html

   </div>

Then at the UNIX prompt, type,

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cp /usr/include/sys/types.h types.h

.. raw:: html

   </div>

The above command means copy the file ``types.h`` from the
``/usr/include/sys`` directory to the current directory, keeping the
name the same.

You can accomplish the same thing by typing

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cp /usr/include/sys/types.h .

.. raw:: html

   </div>

Like the previous command, it directs the computer to copy the file
``types.h`` from the ``/usr/include/sys`` directory to the current
directory, ``.``, without changing the file name.

.. exercise-2:

Exercise
^^^^^^^^

Create a backup of your ``types.h`` file by copying it to a file called
``types.bak``.

Moving files
~~~~~~~~~~~~

mv (move)
^^^^^^^^^

To move a file from one place to another, use the ``mv`` command. This
has the effect of moving rather than copying the file, so you end up
with only one file rather than two. The calling sequence is of the form
``mv file1 file2`` which results in moving ``file1`` to ``file2``.

This can be helpful when moving a file from one directory to another. We
are now going to move the file ``types.bak`` to your ``backup``
directory.

First, change directories to your ``unixstuff`` directory (can you
remember how?). Then, inside the ``unixstuff`` directory, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ mv types.bak backups/.

.. raw:: html

   </div>

Type ``ls`` and ``ls backups`` to see if it has worked.

The ``mv`` command can also be used to rename a file, by moving the file
to the same directory, but giving it a different filename.

Removing files and directories
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

rm (remove), rmdir (remove directory)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To delete (remove) a file, use the ``rm`` command. As an example, we are
going to create a copy of the ``types.h`` file then delete it.

Inside your ``unixstuff`` directory, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cp types.h tempfile.txt
    $ ls
    $ rm tempfile.txt
    $ ls

.. raw:: html

   </div>

(after ``rm tempfile.txt`` you may need to answer "y" at the prompt and
hit [Enter] before continuing).

These commands first copied the file ``types.h`` to a copy called
``tempfile.txt``, then showed you the list of files in this directory
(notice the new file), then deleted ``tempfile.txt``, and finally showed
you the updated list of files in this directory.

You can use the ``rmdir`` command to remove a directory (make sure it is
empty first). Try to remove the ``backups`` directory:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ rmdir backups

.. raw:: html

   </div>

Notice that you cannot remove the directory, since UNIX will not let you
remove a non-empty directory.

.. exercise-3:

Exercise
^^^^^^^^

Create a directory called ``tempstuff`` using ``mkdir``, then remove it
using the ``rmdir`` command.

Displaying the contents of a file on the screen
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

clear (clear screen)
^^^^^^^^^^^^^^^^^^^^

Before you start the next section, you may want to clear the terminal
window of the previous commands so the output of the following commands
can be clearly understood.

At the prompt, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ clear

.. raw:: html

   </div>

This will clear all text and leave you with the ``$`` prompt at the top
of the window.

cat (concatenate)
^^^^^^^^^^^^^^^^^

The command ``cat`` can be used to display the contents of a file to the
screen. Type:

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cat types.h

.. raw:: html

   </div>

As you can see, the file is longer than than the size of the window, so
it scrolls past making it difficult to read the file from the beginning.

less (view file contents)
^^^^^^^^^^^^^^^^^^^^^^^^^

The command less writes the contents of a file onto the screen one page
at a time. Type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ less types.h

.. raw:: html

   </div>

Press the [space-bar] if you want to see another page, and type [q] if
you want to quit reading.

As you can see, ``less`` can be more useful for reading long files than
``cat``.

head (view top of file)
^^^^^^^^^^^^^^^^^^^^^^^

The ``head`` command writes the first ten lines of a file to the screen.

First clear the screen then type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ head types.h

.. raw:: html

   </div>

Then type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ head -3 types.h

.. raw:: html

   </div>

What difference did the -3 do to the ``head`` command?

tail (view bottom of file)
^^^^^^^^^^^^^^^^^^^^^^^^^^

The ``tail`` command writes the last ten lines of a file to the screen.

Clear the screen and type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ tail types.h

.. raw:: html

   </div>

Q. Can you figure out how to view the last 15 lines of this file?

Searching the contents of a file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Simple searching using less
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Using ``less``, you can search though a text file for a keyword
(pattern). For example, to search through ``types.h`` for the word
``long``, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ less types.h

.. raw:: html

   </div>

then, still in less, type a forward slash [/] followed by the word you
want to search for,

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    /long

.. raw:: html

   </div>

As you can see, ``less`` finds and highlights the keyword. Type [n] to
search for the next occurrence of the word. Type [q] to quit the search.

grep <grep (file search)> (don't ask why it is called grep)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``grep`` is one of many standard UNIX utilities. It searches files for
specified words or patterns. First clear the screen, then type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ grep long types.h

.. raw:: html

   </div>

As you can see, ``grep`` has printed out each line of the file
``types.h`` that contains the word long.

Or has it ????

Try typing

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ grep LONG types.h

.. raw:: html

   </div>

Note that the ``grep`` command is case sensitive; it distinguishes
between ``LONG`` and ``long``.

To ignore upper/lower case distinctions, use the ``-i`` option, i.e.
type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ grep -i long types.h

.. raw:: html

   </div>

To search for a phrase or pattern, you must enclose it in single quotes
(the apostrophe symbol). For example to search for ``long int`` you
would type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ grep -i 'long int' types.h

.. raw:: html

   </div>

Some of the other options of grep are:

    ``-v`` display those lines that do NOT match

    ``-n`` precede each matching line with the line number

    ``-c`` print only the total count of matched lines

Try some of them and see how the results differ. Don't forget, you can
combine options to do more than just one thing at a time. For example,
the number of lines without the words ``long`` or ``LONG`` is

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ grep -ivc long types.h

.. raw:: html

   </div>

wc (word count)
^^^^^^^^^^^^^^^

A handy little utility is the ``wc`` command, short for *word count*. To
do a word count on ``types.h``, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ wc -w types.h

.. raw:: html

   </div>

To find out how many lines the file has, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ wc -l types.h

.. raw:: html

   </div>

Manipulating files and directories -- summary
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+---------------------+------------------------------------------------+
| Command             | Meaning                                        |
+=====================+================================================+
| cp file1 file2      | copy file1 and call it file2                   |
+---------------------+------------------------------------------------+
| mv file1 file2      | move or rename file1 to file2                  |
+---------------------+------------------------------------------------+
| rm file             | remove a file                                  |
+---------------------+------------------------------------------------+
| rmdir directory     | remove a directory                             |
+---------------------+------------------------------------------------+
| cat file            | display a file                                 |
+---------------------+------------------------------------------------+
| less file           | display a file a page at a time                |
+---------------------+------------------------------------------------+
| head file           | display the first few lines of a file          |
+---------------------+------------------------------------------------+
| tail file           | display the last few lines of a file           |
+---------------------+------------------------------------------------+
| grep 'keyword' file | search a file for keywords                     |
+---------------------+------------------------------------------------+
| wc file             | count number of lines/words/characters in file |
+---------------------+------------------------------------------------+

Redirection, Pipes, Wildcards and Getting Help
----------------------------------------------

Redirection
~~~~~~~~~~~

Most processes initiated by UNIX commands write to the standard output
(that is, they write to the terminal screen), and many take their input
from the standard input (that is, they read it from the keyboard). There
is also the standard error, where processes write their error messages,
by default, to the terminal screen.

We have already seen one use of the ``cat`` command to write the
contents of a file to the screen.

Now type ``cat`` without specifing a file to read

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cat

.. raw:: html

   </div>

Then type a few words on the keyboard and press the [Return] key.

Finally hold the [Ctrl] key down and press [d] (written as ``^D`` for
short) to end the input.

What has happened?

If you run the ``cat`` command without specifing a file to read, it
reads from *standard input* (the keyboard), and on receiving the 'end of
file' character (``^D``), copies the input to *standard output* (the
screen).

In UNIX, we can redirect both the standard input (*stdin*) and the
standard output (*stdout*) of commands.

Redirecting the Output <> (redirecting output)>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We use the ``>`` symbol to redirect the output of a command. For
example, to create a file called ``list1`` containing a list of fruit,
type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cat > list1

.. raw:: html

   </div>

Then type in the names of some fruit. Press [Return] after each one.

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    pear
    banana
    apple
    ^D        # this means press [Ctrl] and [d] to stop

.. raw:: html

   </div>

What happens is the ``cat`` command reads the standard input (the
keyboard) and the ``>`` redirects the output, which normally goes to the
screen, into a file called ``list1``

To read the contents of the new file, use ``cat`` or ``less``.

.. exercise-4:

Exercise
^^^^^^^^

Using the above method, create another file called ``list2`` containing
the following fruit: orange, plum, mango, grapefruit. Read the contents
of the new file, ``list2``.

Appending to a file <>> (appending output)>
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The double greater-than symbol ``>>`` appends standard output to a file.
So to add more items to the existing file ``list1``, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cat >> list1

.. raw:: html

   </div>

Then type in the names of more fruit

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    peach
    grape
    orange
    ^D

.. raw:: html

   </div>

To read the contents of the file, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cat list1

.. raw:: html

   </div>

You should now have two files: ``list1`` contains six fruit, while
``list2`` contains four.

We will now use the ``cat`` command to join (concatenate) ``list1`` and
``list2`` into a new file called ``biglist``. Type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cat list1 list2 > biglist

.. raw:: html

   </div>

What this is doing is reading the contents of both files ``list1`` and
``list2`` in turn, then outputing the text to the file ``biglist``

To read the contents of this new file, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ cat biglist

.. raw:: html

   </div>

Redirecting the Input << (redirecting input)>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We use the ``<`` symbol to redirect the input of a command.

The command ``sort`` alphabetically or numerically sorts a list. Type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ sort

.. raw:: html

   </div>

Then type in the names of some animals. Press [Return] after each one.

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    dog
    cat
    bird
    ape
    ^D

.. raw:: html

   </div>

The output will be

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    ape
    bird 
    cat 
    dog

.. raw:: html

   </div>

Using ``<`` you can redirect the input to come from a file rather than
the keyboard. For example, to sort the list of fruit, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ sort < biglist

.. raw:: html

   </div>

and the sorted list will be output to the screen.

To output the sorted list to a file, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ sort < biglist > slist

.. raw:: html

   </div>

Use ``cat`` to read the contents of the newly-created file ``slist``.

Pipes <\| (pipes)>
~~~~~~~~~~~~~~~~~~

To see who is logged into the system along with you, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ who

.. raw:: html

   </div>

One method to get a sorted list of those names is to type,

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ who > names.txt
    $ sort < names.txt

.. raw:: html

   </div>

This is a bit slow (two whole steps) and you have to remember to remove
the temporary file ``names`` when you have finished. As truly
lazy/efficient technophiles, what you really want to do is connect the
output of the ``who`` command directly to the input of the ``sort``
command. This is exactly what pipes do. The symbol for a pipe is the
vertical bar ``|``.

For example, typing

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ who | sort

.. raw:: html

   </div>

will give the same result as above, but quicker and cleaner.

To find out how many users are logged on, you can type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ who | wc -l

.. raw:: html

   </div>

.. exercise-5:

Exercise
^^^^^^^^

Using two pipes, display all lines of ``list1`` and ``list2`` containing
the letter "p", and sort the result.

Wildcards
~~~~~~~~~

The \* <\* (wildcard)> wildcard
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The character ``*`` is called a *wildcard*, and will match against none
or more character(s) in a file (or directory) name. For example, in your
``unixstuff`` directory, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ls list*

.. raw:: html

   </div>

This will list all files in the current directory starting with the
characters "list"

Try typing

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ls *list

.. raw:: html

   </div>

This will list all files in the current directory ending with "list"

.. the-wildcard-wildcard-1:

The ? <? (wildcard)> wildcard
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The character ``?`` will match exactly one character, So ``?ouse`` will
match files like ``house`` and ``mouse``, but not ``grouse``.

Try typing

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ls ?list

.. raw:: html

   </div>

File Editing
~~~~~~~~~~~~

While it is technically possible to create text files using ``cat`` and
redirection, these tools are inadequate for creating/editing program
text files. A wide variety of text editors exist within the Linux
ecosystem; a brief overview of the main editors installed on ManeFrame
is given here:

-  GEdit -- This is a simple graphical text editor that should be
   familiar to Windows users, since it uses the same keyboard shortcuts
   as Windows programs (copy/cut/paste/save/find/quit). Newer versions
   even support syntax highlighting in source code files. GEdit may be
   launched at the command line via the command ``gedit``
-  Nano -- This is another simple text editor, but it runs *inside the
   terminal*, so it can be used with broken X11-forwarding or with slow
   network connections. While the keyboard shortcuts differ from
   Windows, they are listed at the bottom of the screen. Nano may be
   launched with the command ``nano``.
-  Emacs -- This is a full-featured editor, that may either be launched
   as a graphical editor (``emacs``) or within the terminal
   (``emacs -nw``). The keyboard shortcuts differ from Windows, but when
   launched graphically there are clickable menus.
-  VI -- This is another full-featured editor that runs within the
   terminal (``vi``). Graphical variants of VI exist as well (e.g.
   ``gvim``) but do not seem to be installed on ManeFrame. The keyboard
   shortcuts are different from all other editors, and no menu system is
   available.

.. raw:: html

   <div class="admonition note">

I recommend that new users start with GEdit and/or Nano, and
    move on to Emacs or VI after they are comfortable with Linux.

.. raw:: html

   </div>

Filename conventions
~~~~~~~~~~~~~~~~~~~~

We should note here that a directory is merely a special type of file.
So the rules and conventions for naming files apply also to directories.

In naming files, characters with special meanings such as ``/``, ``*``,
``&``, ``%`` and ``,`` should be avoided. Also, it is best to avoid
using spaces within names. The safest way to name a file is to use only
alphanumeric characters, that is, letters and numbers, together with
``_`` (underscore) and ``.`` (dot).

+------------------+------------------+
| Good filenames   | Bad filenames    |
+==================+==================+
| project.txt      | project          |
+------------------+------------------+
| my_big_program.c | my big program.c |
+------------------+------------------+
| fred_dave.doc    | fred & dave.doc  |
+------------------+------------------+

File names conventionally end with a dot followed by a group of letters
indicating the contents of the file, although this is not at all
required in Linux. For example, all files consisting of C code may be
named with the ending .c, for example, ``prog1.c``. Then in order to
list all files containing C code in your home directory, you need only
type ``ls ~/*.c``

Getting Help
~~~~~~~~~~~~

On-line Manuals
^^^^^^^^^^^^^^^

There are built-in manuals which give information about most commands.
The manual pages <man (manual)> tell you which options a particular
command can take, and how each option modifies the behaviour of the
command. Type "man *command*" to read the manual page for a particular
*command*.

For example, to find out more about the ``wc`` (word count) command,
type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ man wc

.. raw:: html

   </div>

Alternatively

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ whatis wc

.. raw:: html

   </div>

gives a one-line description <whatis (brief manual)> of the command, but
omits any information about options etc.

Apropos <apropos (command search)>
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When you are not sure of the exact name of a command, "apropos
*keyword*" will give you the commands with *keyword* in their manual
page header. For example, try typing

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ apropos copy

.. raw:: html

   </div>

Redirection, pipes, wildcards and help -- summary
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

+-----------------------------------+-----------------------------------+
| Command                           | Meaning                           |
+===================================+===================================+
| command > file                    | redirect standard output to a     |
|                                   | file                              |
+-----------------------------------+-----------------------------------+
| command >> file                   | append standard output to a file  |
+-----------------------------------+-----------------------------------+
| command < file                    | redirect standard input from a    |
|                                   | file                              |
+-----------------------------------+-----------------------------------+
| command1 \| command2              | pipe the output of command1 to    |
|                                   | the input of command2             |
+-----------------------------------+-----------------------------------+
| cat file1 file2 > file0           | concatenate file1 and file2 to    |
|                                   | file0                             |
+-----------------------------------+-----------------------------------+
| sort                              | sort data                         |
+-----------------------------------+-----------------------------------+
| who                               | list users currently logged in    |
+-----------------------------------+-----------------------------------+
| \*                                | match any number of characters    |
+-----------------------------------+-----------------------------------+
| ?                                 | match one character               |
+-----------------------------------+-----------------------------------+
| man command                       | read the online manual page for a |
|                                   | command                           |
+-----------------------------------+-----------------------------------+
| whatis command                    | brief description of a command    |
+-----------------------------------+-----------------------------------+
| apropos keyword                   | match commands with keyword in    |
|                                   | their man pages                   |
+-----------------------------------+-----------------------------------+

Permissions and Security
------------------------

File system security (access rights)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In your ``unixstuff`` directory, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ ls -l

.. raw:: html

   </div>

The ``-l`` stands for 'long' listing. You will see that you now get lots
of details about the contents of your directory, similar to the example
below.

.. raw:: html

   <div class="figure">

|File and directory access rights|

File and directory access rights

.. raw:: html

   </div>

Each file (and directory) has associated access rights, which may be
found by typing ``ls -l``. Also, ``ls -lg`` gives additional information
as to which group owns the file (``beng95`` in the following example):

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    -rwxrw-r-- 1 ee51ab beng95 2450 Sept29 11:52 file1

.. raw:: html

   </div>

In the left-hand column is a 10 symbol string consisting of the symbols
``d``, ``r``, ``w``, ``x``, ``-``, and, occasionally, ``s`` or ``S``. If
``d`` is present, it will be at the left hand end of the string, and
indicates a directory: otherwise ``-`` will be the starting symbol of
the string.

The 9 remaining symbols indicate the permissions, or access rights, and
are taken as three groups of 3.

-  The left group of 3 gives the file permissions for the user that owns
   the file (or directory) (``ee51ab`` in the above example);
-  the middle group gives the permissions for the group of people to
   whom the file (or directory) belongs (``eebeng95`` in the above
   example);
-  the rightmost group gives the permissions for all other users.

The symbols ``r``, ``w``, etc., have slightly different meanings
depending on whether they refer to a simple file or to a directory.

Access rights on files
^^^^^^^^^^^^^^^^^^^^^^

-  ``r`` (or ``-``), indicates read permission (or otherwise), that is,
   the presence or absence of permission to read and copy the file
-  ``w`` (or ``-``), indicates write permission (or otherwise), that is,
   the permission (or otherwise) to change a file
-  ``x`` (or ``-``), indicates execution permission (or otherwise), that
   is, the permission to execute/run a file, where appropriate

Access rights on directories
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  ``r`` allows users to list files in the directory
-  ``w`` means that users may delete files from the directory or move
   files into it
-  ``x`` means the right to access files in the directory. This implies
   that you may read files in the directory provided you have read
   permission on the individual files.

So, in order to read a file, you must have execute permission on the
directory containing that file, and hence on any directory containing
that directory as a subdirectory, and so on, up the tree.

Some examples
^^^^^^^^^^^^^

+-----------------------------------+-----------------------------------+
| Permissions                       | Meaning                           |
+===================================+===================================+
| ``-rwxrwxrwx``                    | a file that everyone can read,    |
|                                   | write and execute (and delete)    |
+-----------------------------------+-----------------------------------+
| ``-rw-------``                    | a file that only the owner can    |
|                                   | read and write - no-one else can  |
|                                   | read or write and no-one has      |
|                                   | execution rights (e.g. your       |
|                                   | mailbox file)                     |
+-----------------------------------+-----------------------------------+
| ``drwxr-x---``                    | a directory that the owner can    |
|                                   | read/write/enter, that the group  |
|                                   | can read/enter, but others are    |
|                                   | denied access                     |
+-----------------------------------+-----------------------------------+
| ``drwx--x--x``                    | a directory that the owner may    |
|                                   | read/write/enter, and all others  |
|                                   | can enter (but do nothing else)   |
+-----------------------------------+-----------------------------------+

Changing access rights
~~~~~~~~~~~~~~~~~~~~~~

chmod (change permissions)
^^^^^^^^^^^^^^^^^^^^^^^^^^

Only the owner of a file can use ``chmod`` to change the permissions of
a file. The options of ``chmod`` are as follows

+--------+--------------------------------+
| Symbol | Meaning                        |
+========+================================+
| u      | user                           |
+--------+--------------------------------+
| g      | group                          |
+--------+--------------------------------+
| o      | other                          |
+--------+--------------------------------+
| a      | all                            |
+--------+--------------------------------+
| r      | read                           |
+--------+--------------------------------+
| w      | write (and delete)             |
+--------+--------------------------------+
| x      | execute (and access directory) |
+--------+--------------------------------+
| +      | add permission                 |
+--------+--------------------------------+
| -      | take away permission           |
+--------+--------------------------------+

For example, to remove read write and execute permissions on the file
``biglist`` for the group and others, type

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ chmod go-rwx biglist

.. raw:: html

   </div>

This will leave the other permissions unaffected.

To give read and write permissions on the file ``biglist`` to all,

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ chmod a+rw biglist

.. raw:: html

   </div>

Alternatively, you may use a three-digit number to specify the access
permissions. The numerical values for the permissions are

+------+-------+---------+
| Read | Write | Execute |
+======+=======+=========+
| 4    | 2     | 1       |
+------+-------+---------+

Add up the desired permissions for the user to form the first digit, add
up the desired permissions for the group to form the second digit, and
add up the desired permissions for others to form the third digit.

For example, to grant read and write permissions to the user (4+2=6),
read permissions (4) to the group, and no permissions to others (0), for
the file ``biglist``, use the command

.. raw:: html

   <div class="sourceCode">

.. code:: bash

    $ chmod 640 biglist

.. raw:: html

   </div>

.. exercise-6:

Exercise
^^^^^^^^

Try changing access permissions on the file ``types.h`` and on the
directory ``backups``.

Use ``ls -l`` to check that the permissions have changed.

.. |UNIX directory structure example| image:: data:image/png;base64,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iNFoxGw2Dwswbrf7slaYvr4+Tpw4gclkYsGCBd+6iJnNZkOn06HX68nLy2PGjBnXPQ3X1/oSGRnpDzBqtRqNRkNiYiJqtZr4+HiioqJQqVTSAiPEJCMBRogJzuv14na7cTqd2Gw2rFar/2az2XA4HJcFmL6+Purr6/n666+56667uPnmm6/pPbu7u/n888+xWCzccMMNzJ8//5qDzNAA4+sGi42NJT4+ntjY2GGtLzILSYjJRwKMEJOAL8S4XC6cTicOhwO73T4svHg8Hjo7O9m3bx8tLS3k5+ezbNmyUS1k1tLSwgcffMC3WK4AACAASURBVIDFYmHJkiXcdttt33j80BDiW/MlIiLC3woz9OZbxVbCixCTkwQYISYJX3eSx+Pxhxm3243b7aa3t5cPP/yQxsZGFixYwLJly9BqtQF771OnTrFp0yYGBgZYs2YNN91007e+ZuiidREREf5bZGSkv9XFd5wQYvKRACPEJOPrJvJ6vdjtdl599VUOHz7MwoULKS0tJS0tbUyWtvd4PHzxxRfs2LEDgEceeYSCgoLLjrs0kPhaWIYGmisdJ4SYXCTACDFJbdq0iddff50777yT1atXk5aWNi7va7PZOHDgAB988AFqtZpHHnmEuXPnBnT6tRBi4pMAI8QkYjab+eSTT9i6dSs33XQTq1evZsqUKUFpzbDb7ezZs4dNmzaxYMECnnzySbKyssa9DiFEeJIAI8QkYLPZOHToEH/84x9Rq9V897vfZcaM0Nmh+r333uPFF19k+fLlrFq1imnTpgW7JCFEiJMAI8QE5na72bt3L7t27SIyMpJVq1ZdcdxJKLBarWzdupWjR48yf/58HnzwQWmREUJclQQYISaow4cP8x//8R8oFAoqKipYtGhRsEsakc7OTnbs2EFrayt5eXk89NBDpKaG/g7aQojxJQFGiAlGp9OxZcsWXC4X99xzDyUlJWG51H5rayvbt2/n5MmTLF26lO9+97uoVKpglyWECBESYISYIM6dO8fmzZsxm83ce++93HrrrcTExAS7rFFraWmhpqaGgwcP8sMf/pD77rsv2CUJIUKABBghwlxHRwevv/46f/7zn3n00Ue54447UKvVwS4roLxeLy0tLWzevJmzZ8+yatWqUa8SLIQIbxJghAhTPT09bNq0id///vc8++yzPPHEE8Euacy53W5OnDjB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TN/f4/Fw9uxZ3n77bfr7+1m5ciVLliy5rIvq0t2mh85KGvq8GDsOh4Pf/va37Nmzhx/96EffuKmkEOL6SIAR4hro9Xo+/vhj9u7dy7x581i9evVVFzYbS19++SWvv/46sbGx3HvvvSxatCikF6ObrM6cOUNNTQ2RkZGUl5ePeDC3EOLbSYARYgSsVit1dXUcPHgQtVrNypUrQ+LD6IsvvuB3v/sdMTExPPHEE9x6663BLklcwUcffURtbS233347f//3fy+L3QkRABJghPgWO3bs4KOPPiIxMZHVq1czb968YJd0mU8++YTNmzeTkZHB9773PebMmRPsksQlrFYrL730Ep999hkvvPACS5cuDXZJQoQ1CTBCXMVnn33GG2+8gUKh4B/+4R9YsGBBsEv6RlarlX379rFr1y5SU1N55JFHJMiEGI/Hw9GjR9m+fTsqlYrVq1eTm5sb7LKECEsSYIS4xNGjR3n77bdRq9WUlJSwePHisBpfYjKZ+OSTT9i/fz/Z2dk88cQTpKenB7ssMYTVamXXrl3s3buXxYsXs3z5chISEoJdlhBhRQKMEPx1s7533nkHs9nM/fffz5IlS0a8eFwoMhgMvP/++7z55pvcd999PPvsszL2IsS0t7fz+uuvc+7cOZ555hkWLVoU7JKECBsSYMSk19fXx29+8xtOnz7N448/zp133jmqnaFD0SuvvMIbb7xBRUUFK1askCXvQ8y+ffvYunUrWVlZVFRUfOOeWUKIiyTAiEmrtbWVLVu2sGPHDp5//nkeeeSRYJc0pvR6PW+88QaNjY387d/+LXfffXdQpoCLKzObzezcuZMvvviCZcuWcdddd0m3khDfQAKMmHTa29vZuXMnJ06cYOHChTz66KOTau+ac+fO8e6772I2m8nPz+fuu+9GrVYHuyzxF42Njbz11lu43W4efvhhbrrppmCXJERIkgAjJg2DwcDOnTs5fvw4M2bMYPny5ZO6qf7UqVNs3bqV7u5u7rnnHh566KFglySG2LdvH//7f/9v7r77bp599tlJFbKFGAkJMGLCczqdbN68mUOHDpGbm8vKlStl6uoQX375JS+99BJWq5WKigqWLVsW7JLEX1itVjZt2sSnn37K448/TlFRkQzEFuIvJMCICe3DDz/k//2//8fixYspLy8nJycn2CWFJLfbzVdffcXmzZux2+08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
.. |Unix Terminal - running the ls command| image:: data:image/gif;base64,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
.. |Unix Terminal - running the ls -a command| image:: data:image/gif;base64,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
.. |File and directory access rights| image:: data:image/gif;base64,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

