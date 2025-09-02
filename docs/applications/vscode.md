# Visual Studio Code

Visual Studio Code is a popular code editor with extensions for coding
in different languages. We recommend using Visual Studio Code through the
[HPC OnDemand Web Portal](https://hpc.m3.smu.edu/). See instructions
for the using the [portal version](/applications/vscode.md#portal) below.

## Portal

1. Select "Visual Studio Code" from the "Interactive Apps" drop-down menu.
2.  Select options required for your Visual Studio Code instance. These
    options are the same as those requested via a standard Slurm script.
    Any modules that are needed at runtime should be loaded using the
    "Custom environment settings" (i.e. `module load miniforge`).

```{note}
Some modules will not work as anticipated in Visual Studio Code because it
is running in a container. If you need a module that will not load in this
environment, you can still use Visual Studio Code as your code editor, but
run modules and code with the Slurm scheduler from an SSH session.
```

3.  Select "Launch"
4.  Wait for the job to start. When the job starts a new button
    "Connect to Visual Studio Code" button will appear.
5.  Select "Connect to Visual Studio Code"
6.  The Visual Studio Code graphical interface will be presented and running on the
    resources requested.
7.  When finished using the Visual Studio Code instance, return to the "My
    Interactive Sessions" tab in your browser and select "Delete" and
    "Confirm", when prompted, to cancel the job.

## SSH on Login Nodes

```{warning}
As a reminder, running code on login nodes is prohibited. This method
is intended only for code editing. If you want to execute code from
Visual Studio Code, please use the [portal version](/applications/vscode.md#portal).
```

To connect via SSH to a login node, follow the 
[Remove Development using SSH](https://code.visualstudio.com/docs/remote/ssh) instructions
for using the Remote-SSH feature.