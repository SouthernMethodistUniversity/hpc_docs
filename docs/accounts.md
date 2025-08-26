:::{important} Account management for our HPC platforms is migrating to [ColdFront](https://hpcaccess.smu.edu).
See the [frequently asked questions](coldfront/faq.md)
:::

# Accounts

## Creating Accounts

Accounts on SMU HPC clusters can be created via the processes detailed below.

:::{important} As of **November 1, 2024** [running HPC jobs](coldfront/running_jobs.md) 
requires using a slurm account from an active allocation in [ColdFront](https://hpcaccess.smu.edu).
See the [frequently asked questions](coldfront/faq.md)
:::

````{tab-set}
```{tab-item} Faculty/Staff

Most benefits eligible faculty and staff can use the self-service
[ColdFront](https://hpcaccess.smu.edu) platform to create an account for 
themselves, students, and external collaborators with SMU credentials.
In order for an HPC account to be created or reactivated for an user, the following
conditions must be satisfied:

1. The user must create or be added to a project in [ColdFront](https://hpcaccess.smu.edu). 
   See [how to create a project](coldfront/add_change_project.md).
   Note that students cannot create their own projects.

2. The user must be on an active compute and/or storage allocation managed 
   by [ColdFront](https://hpcaccess.smu.edu). See [how to create an allocation](coldfront/request_change_allocation.md)
```
```{tab-item} Postdocs
Postdocs are eligible to use the self-service
[ColdFront](https://hpcaccess.smu.edu) platform to create an account for 
themselves, students, and external collaborators with SMU credentials. However,
we recommend that your advisor be the one to create any ColdFront projects for continuity
of research.

1. The user must create or be added to a project in [ColdFront](https://hpcaccess.smu.edu). 
   See [how to create a project](coldfront/add_change_project.md).
   Note that students cannot create their own projects.

2. The user must be on an active compute and/or storage allocation managed 
   by [ColdFront](https://hpcaccess.smu.edu). See [how to create an allocation](coldfront/request_change_allocation.md)
```
```{tab-item} Student Researchers
Students are not eligible to create their own account. A faculty/staff advisor 
can use the self-service
[ColdFront](https://hpcaccess.smu.edu) platform to create an account for 
students with SMU credentials.
In order for an HPC account to be created or reactivated for a student, the following
conditions must be satisfied:

1. The student must be added to a project in [ColdFront](https://hpcaccess.smu.edu). 
   See [how to create a project](coldfront/add_change_project.md).
   Note that students cannot create their own projects.

2. The student must be on an active compute and/or storage allocation managed 
   by [ColdFront](https://hpcaccess.smu.edu). See [how to create an allocation](coldfront/request_change_allocation.md)

3. The student must login to [ColdFront](https://hpcaccess.smu.edu) and agree to 
the policies and guidelines before their account is provisioned\.
```
```{tab-item} Classes
Accounts for classes are required to use [ColdFront](https://hpcaccess.smu.edu).
Instructors of record will be able to see their courses around the time registration
opens.

1. Once a Class Project is created, ColdFront will automatically add and remove students 
enrolled in the course shortly before the start of the term and periodically update during 
the term based on official enrollment data. 

2. TA's have to be added manually to a project AND its associated allocations 
by the instructor of record. 

3. Both students and TA's will need to agree to the policies and guidelines for each allocation 
before their account is provisioned.

See the [ColdFront quick start guide for instructors](coldfront/qs_instructor.md) and
the [ColdFront quick start guide for students](coldfront/qs_student.md).

If you need help setting up a class, please contact the [Help Desk](mailto:help@smu.edu?subject=[HPC]).
```
```{tab-item} External Collaborators
External research collaborators are permitted to use the systems for research that is being conducted
in collaboration with SMU Faculty/Staff members.

1. The Faculty/Staff sponsor must request an SMU NetID or Sponsored NetID and have that account
   activated before the sponsor can request cluster access for the individual.
   Please submit an Account Request via the
   [Online Service Center](https://www.smu.edu/oit/services/stable).
   - ***Contractor with SMU email*** is the type of account to request.

2. Once the individual\'s SMU NetID or Sponsored NetID has been created and
   activated the sponsor can add them to [ColdFront](https://hpcaccess.smu.edu)
   projects and allocations.

3. The external collaborator will need to be connected to the campus [VPN](https://www.smu.edu/oit/services/vpn)
   and agree to the policies and guidelines in [ColdFront](https://hpcaccess.smu.edu) for their
   account to be provisioned.

:::{note} The HPC and Research support teams are not involved in the process of
creating SMU NetIDs or Sponsored NetIDs. 
:::

```
````

## Checking Account Status

## Access

All access to HPC Resources, including [ColdFront](https://hpcaccess.smu.edu), requires 
connection to [PerunaNet](https://www.smu.edu/oit/services/wifi) or the [VPN](https://www.smu.edu/oit/services/vpn).

### HPC OnDemand Web Portal

````{tab-set}
```{tab-item} M3
M3 can be accessed directly from a browser via the [HPC OnDemand Web Portal](https://hpc.m3.smu.edu/), 
which provides access to files, remote desktops, JupyterLab, and
RStudio.
```
```{tab-item} SuperPOD
The SuperPOD is only accessible via SSH, please see the next section for instructions.
```
````

### SSH

Secure shell access via SSH is available for SMU HPC systems. There are many
SSH clients available for different operating systems. The following instructions 
are for standard OpenSSH installations such as
those found in Linux, macOS, and Windows (>=10) including WSL.

````{tab-set}
```{tab-item} M3
1. Open a terminal (Terminal on macOS, PowerShell on Windows)
2. Type `ssh <your_username>@m3.smu.edu` where `<your_username>` is
   your username, which is usually the first part of your SMU NetID.
3. Type a Duo **passcode** or `1` for a Duo push. The passcode can
   come from an OIT procured hardware token (faculty and
   staff only). Passcodes from the Duo app do not work.
```
```{tab-item} SuperPOD
1. Open a terminal (Terminal on macOS, PowerShell on Windows)
2. Type `ssh <your_username>@superpod.smu.edu` where `<your_username>` is
   your username, which is usually the first part of your SMU NetID.
3. Type a Duo **passcode** or `1` for a Duo push. The passcode can
   come from an OIT procured hardware token (faculty and
   staff only). Passcodes from the Duo app do not work.
```
````

### Advanced

For more advanced access methods, such as x11 forwarding, jumphosts, and SSH keys,
please see more information on the [Access](access.md) page.

## Reset Account Password

SMU HPC clusters use SMU's authentication system, which means that your
username and password are based on your SMU credentials. Your username is the
first part of your SMU NetID, i.e. janeuser for <janeuser@smu.edu>, and
your password is your SMU password. SMU's password tool can be used to change
or reset your password (<https://pwreset.smu.edu>). However, note that this
changes your password for all SMU services such as email as well.

## What happens when I leave SMU?

````{tab-set}
```{tab-item} Faculty/Staff
Faculty and Staff should follow guidance given by SMU Human Resources and the SMU Office of Research
and Innovation for data ownership policies specific to their contract, but in general:

1. All ColdFront projects and allocation will be disabled automatically on termination of
   employment. If you wish to transfer ownership to another SMU faculty/staff member, please open
   a help ticket with the [SMU HPC Admins](mailto:help@smu.edu?subject=[HPC]) *before* termination
   with information about which projects and associated allocation should be transferred and to whom.
2. In accordance with applicable policies, data that you need to retain should be moved off of SMU systems.
```
```{tab-item} Postdocs
Postdoctoral students should follow guidance given by SMU Human Resources and the SMU Office of Research
and Innovation for data ownership policies specific to their contract, but in general:

1. All ColdFront projects and allocation will be disabled automatically on termination of
   employment. We highly recommend that you transfer ownership of any projects to your advisor. To do this, please open
   a help ticket with the [SMU HPC Admins](mailto:help@smu.edu?subject=[HPC]) *before* termination
   with information about which projects and associated allocation should be transferred and to whom.
2. In accordance with applicable policies, data that you need to retain should be moved off of SMU systems.
```
```{tab-item} Student Researchers
1. Student researchers will be disabled on any ColdFront projects and allocations once they are no longer a student.
2. Please make sure that your any data or code that your advisor needs is in a storage allocation owned by your advisor.
   Your advisor will not be able to access your personal $HOME or $SCRATCH directory once you are no longer a student. 
3. With the permission of your advisor, any data or code you want to keep should be copied off of SMU systems prior
   to your graduation date.
```
```{tab-item} Classes
1. Class projects and allocations are tied to enrollment data and automatically expire shortly after the end of
   each term.
2. Instructors that need to re-use files in a storage allocation the following semester should create a 
   new class project for the following semester and copy any files needed to the new storage allocation.
3. Instructors that need to keep files, but are not using HPC for a class the following semester should 
   back up files off of the HPC systems.
```
```{tab-item} External Collaborators
1. SMU Sponsored accounts are renewed yearly and managed by Parking and ID Services. If you lose access, but
   believe you should not have, please first check that you have an active Sponsored Account.
2. If you are disaffiliating with SMU, please make sure your faculty/staff sponsor has access to any files in a
   ColdFront storage allocation. Sponsors will not be given access to your $HOME or $SCRATCH directory once
   your account is terminated.
```
````

## Terminate an Existing Account

Please send a request to the [SMU HPC
Admins](mailto:help@smu.edu?subject=[HPC]) with a short explanation of
reason for the termination.