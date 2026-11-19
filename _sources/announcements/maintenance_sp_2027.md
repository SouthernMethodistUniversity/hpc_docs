# SuperPOD Maintenance, January 4 through January 15

The SuperPOD will be taken offline in early January to perform extensive updates. Tentatively, this is planned for January 4 through January 15.
 
The updates are necessary to maintain Nvidia support, improve security, and provide researchers with access to the most recent versions of Cuda.

## What is changing

- The operating system will be upgraded from DGX OS 6 to DGX OS 7. This will change the base operating system from Ubuntu 22.04 to Ubuntu 24.04.
- Cuda and related GPU drivers will be updated to support Cuda 13.x toolkits.
- Driver and firmware updates for critical components like network adapters and switches.
- Slurm will be updated to a more recent version.

## Impacts

These updates are significant and may impact existing workflows. If your research depends on specific software packages or specific versions currently installed on the system, please let us know so we can include appropriate testing and prioritize reinstalling software packages.

- The system will not be available while the updates are ongoing. 
- We expect most Python, Conda, and similar environments will continue to work.
- Software that depends on specific compilers, operating system versions, etc. may behave differently, stop working entirely, or need to be reinstalled.

## Before the update

In order to facilitate the update and minimize downtime, we will be removing at least one node from the SuperPOD. This node will be used to test the updates and prepare procedures for updating the remaining nodes.

We are actively working with a Nvidia support team to make this update go as efficiently as possible.

## Questions or Concerns

Please [contact us.](about:contact) if you have any questions or concerns about the scheduled maintenance.
