# Frequently Asked Questions

## Rollout and Transition Policies and Guidelines

1. Starting in mid-August, 2024, course-based use requests for HPC resources will require requesting a class project in ColdFront.
Following the submission of a class request, ColdFront will automatically add and/or remove students based on My.SMU enrollment data.
See the [instructor quick start](qs_instructor.md).

2. Starting on November 1, 2024, user access to HPC compute resources will require being a member of an active project and allocation in ColdFront.
See the [quick start](quick_start.md).

3. Personal user and group directories in `$WORK` will be decommissioned before January 15, 2025 (tentative).
All data stored in a personal user or group directories in `$WORK` must be moved into an appropriate new storage allocation specified in ColdFront project(s).
OIT will assist this transition as needed, please submit a STABLE Help Desk ticket if you need assistance.
All data must be moved before January 15, 2025, though quotas on existing spaces may be reduced prior to that date.
HPC users will receive regular communications about the status `$WORK` quotas.

4. During the transition period (tentatively between August 2024 and May 2025), all allocation requests will be approved with the following exceptions:
    * Requests that violate SMU policy (see, for example,  [SMU's acceptable use policy](https://www.smu.edu/policy/8-information-technology/8-1-acceptable-use).
    * Requests that are illegal.
    * Requests that cannot be reasonably accommodated.

5. Allocations can be changed. 
Change requests will be handled in the same way as new requests.  
See [request or change allocations guide](request_change_allocation.md)

6. In instances when a 'Coldfront' allocation cannot be approved, an HPC support representative will schedule a consultation with you to discuss options.
These discussions may be escalated to ODSRCI leadership and other SMU stakeholders as appropriate.

7. HPC is a shared resource and, as such, allocations represent an upper bound on usage. They are not a guarantee that any associated resources will be available at any given time.

8. Project Owners (PIs) are responsible for the usage of any users added to their projects.
    * PIs are responsible for monitoring the usage of users they add to their projects is appropriate for the project(s) those users are a member of.
    * PIs retain access to any data stored in allocations within their project(s), including user generated data with the exemption of allocations associated with classes.

9. External (sponsored) users will be required to provide and confirm additional information to retain access on a regular basis. 
    * An active and monitored email address (preferably at their home institution).
    * Their current place of employment / home institution.
    * Their department at their place of employment / home institution.

10. After the transition to ColdFront is complete, the ODSRCI will develop more formal policies for governing HPC allocation and service requests based on input from users, faculty, OIT, and other campus stakeholders.  
These guidelines are intended to help SMU and ODSRCI foster a smooth implementation of Coldfront services with SMU’s HPC systems.

## FAQ 

### What is ColdFront? 

ColdFront is a web-based application designed to help manage the allocation of high-performance computing (HPC) resources.  The tool provides a platform for institutions to leverage a project-based accounting system for HPC resources to best allocate resources such as computing time, memory, and storage in a shared environment across various projects and users.  The tool is developed by the University of Buffalo. SMU’s Office of Information Technology will leverage Coldfront to manage SMU’s HPC systems as specified by the ODSRCI and other campus research stakeholders. 

### What is project based accounting?

Project based accounting in HPC refers to the practice of automating, managing, and tracking the usage and allocations of computing resources on a per-project basis.  This approach will allow SMU to allocate, monitor, and accurately report on the use of HPC resources for different research projects. This will help SMU better understand how the HPC systems are being utilized and for what research activities. 

### What is a project in ColdFront? 

A project is meant to be associated with an ongoing, distinct research effort or other academic pursuit. Each project contains information about resource allocations associated with the project as well as tools for reporting research outputs and viewing usage. You can make as many projects as you need. 

### What is an allocation in ColdFront? 

An allocation is a set of permissions granted, by request, that allow you to use HPC resources. Allocations have a maximum length of one (1) year and can be renewed and/or updated to more accurately reflect usage need.

### What is a class in ColdFront? 

A class is a special type of project that is automatically established for an active course that is in the official course catalog at the request of an instructor. Classes are automatically granted small allocations that are inline with historical usage, if these are insufficient more resources can be requested. Classes do not have reporting tools for research outputs. 

### What is a CPU hour (cores * Hour)? 

CPU hours are a unit for measuring HPC system usage. CPU hours are computed per job as (number of allocated CPU cores) * (run time in hours). For example, if a job was allocated 64 cores and ran for 30 minutes, it used (64) *(0.5) = 32 CPU hours of compute time. 

### What is a Memory Hour (GB * Hour)? 

Memory hours are a unit for measuring HPC system usage. Memory hours are computed per job as (Amount allocated memory in GB) * (run time in hours). For example, if a job was allocated 128GB of memory and ran for 45 minutes, it used (128) *(0.75) = 96 Memory hours. 

### What is a GPU Hour (GPU * Hour)? 

GPU hours are a unit for measuring HPC system usage. GPU hours are computed per job as (number of allocated GPUs) * (run time in hours). For example, if a job was allocated 4 GPUs and ran for 1 hour and 30 minutes, it used (4) *(1.5) = 6 GPU hours of compute time. 

### Who can create a project? 

Most benefits eligible faculty and staff can create a project. 
Students should be added to projects created by their faculty or staff advisor(s).  
External users, including former students, must be added to project(s) by collaborators at SMU.

### Who can create classes? 

Anyone who is an instructor of record can create a class in ColdFront that is associated with any active course that is in the official course catalog. Instructors wanting to teach a workshop or an informal course should submit STABLE Help Desk Request where a ticket will be routed to the appropriate OIT team. 

### Who can request allocations? 

Allocations can be requested by any project owner or by any user added to a project and granted “manager” status by the project owner. 

### Will I be charged for allocations? 

No. HPC resources are free for SMU researchers and sponsored affiliates. 

### Is my $HOME directory part of an allocation? 

No. All users with an active HPC account will keep or be granted a home directory on M3 and the SuperPOD with 200GB of space on each system. This space is private and backed up with daily snapshots for 7 days. Sharing data in `$HOME` directories is not allowed. 

### Can I add external collaborators? 

Yes; however, external collaborators must be granted SMU credentials before they are eligible to use SMU HPC systems. SMU faculty and staff may requests sponsored user accounts and credentials by submitting a request to the OIT Help Desk / STABLE. 

### How much should I request for my allocation? 

HPC support personnel can provide information about historical usage that can help inform requests. Users can always request more resources if they are running out.  Initial allocation resource requests are often inaccurate, especially during any initial transition period to new systems. Please reach out to the OIT HPC team by submitting an OIT Help Desk request if you would like assistance. 

### How do I use an allocation? 

For storage allocations, you will be provided a path to a directory. Anything stored in this directory will count agains the allocation quota(s). 

For compute allocations, you will be provided a slurm account to use. In SBATCH scripts or with srun, you can add this with 

#SBATCH -A slurm_account 

or 

srun -A slurm_account … 
 
The web portal (hpc.m3.smu.edu) will have a drop down menu where you can select the appropriate account. 

### What if I accidentally use the wrong allocation? 

For storage allocations, simply move the files to the directory associated with the allocation you wanted to use.

For compute allocations, any resources you used will count against the allocation you requested. Please correct your job scripts and/or commands to use the correct allocation in the future.

If more resources are needed because they were used incorrectly, please submit an allocation change request for more resources. Please provide any details you can about what resources were used and which allocation(s) that usage should have been linked to. 

### What if I need more storage space? 

Request more space on an existing allocation or request a new storage allocation.

### What if I need more compute time? 

Request more compute time on an existing allocation or request a new compute allocation.

### What happens when an allocation expires? 

When a storage or compute allocation expires, user access to that allocation is revoked. For compute resources, jobs will no longer run if submitted with an expired SLURM account. For storage resources, write access will be revoked.  

During the ColdFront transition, SMU will not delete any user data except for the existing 60-day `$SCRATCH` purge policy or by request.  More formal data retention policies for SMU HPC systems will be clarified in the future by the ODSRCI.

OIT recommends that all HPC users request allocation renewals in a timely manner to avoid disruptions. 

### How do I make a group folder?

In a project, make sure the users you want to have access to the group folder have been added to the project. Then request a storage allocation with the amount of space needed. In this request, you can add the desired users and set their permissions (either “read only” or “read and write”.)

### What happens when an user is removed from a project? 

They lose access to any allocations they had access to in the project, including access to any files. All files associated with the project will remain in the project. 

### What happens when an user is removed from an allocation? 

The user will no longer be able to use the allocation. All files associated with the allocation will remain in the allocation. 

### How many projects can I create? 

Eligible SMU community members can create as many projects as needed. ColdFront’s project-based HPC resource request process helps incentivize the creation of distinct HPC projects for each distinct research project effort. When in doubt, HPC support personnel recommend that users create a new ColdFront project. 

### How many allocations can I request? 

Eligible SMU community members can request as many allocations as needed. HPC support personnel may request a consult to discuss your individual needs if requested allocations exceed normal use-cases or disrupt system availability. 

### How can I see my usage? 

All allocations have gauges showing the current usage. These will be updated at least once a day.  SMU is working to develop tools to deliver more specific usage and job metrics to users. If there are specific metrics you are interested in, please reach out to the OIT Research Technology Services team by submitting a ticket to the OIT Help Desk. 

### What happens if a project owner leaves SMU? 

If a project owner leaves SMU, all their projects will be set to the “archived” status. This will expire all associated allocations. If someone else needs to take over and continue the project, that individual should schedule a consultation with the OIT Research Technology Services team by submitting a ticket to the OIT Help Desk. Preferably, arrangements should be made before the project owner leaves SMU. 

### What if I need help? 

For all help requests, please open an SMU Help Desk ticket and include [HPC] in the subject line by emailing help@smu.edu.  For general information, users may reach outreach out to the OIT Research Technology Services team directly via email at (oitresearch@smu.edu). 

### Can I request a new feature in ColdFront? 

Absolutely. Please send requests to the OIT Research Technology Services team, oitresearch@smu.edu. 

 