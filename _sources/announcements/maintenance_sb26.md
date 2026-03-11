# HPC Maintenance, Spring Break 2026 (March 17-19)

All HPC and related services will be taken offline for maintenance during spring break.

## SuperPOD Maintenance

The SuperPOD will be taken offline for maintenance between 6AM, Tuesday, March 17 and 6PM Thursday, March 19. It will not be possible to access the SuperPOD and no jobs will be allowed to run while maintenance is ongoing.  The primary purpose of the maintenance is to implement vendor recommended updates to the $SCRATCH storage system to improve redundancy and reliability.

## M3 Maintenance

M3 will be taken offline for maintenance between 6AM, Wednesday, March 18 and 6PM Thursday, March 19. It will not be possible to access M3, the SuperPOD, Open OnDemand, or any HPC storage. Jobs will not be allowed to run while maintenance is ongoing. The primary purpose of this maintenance address recent performance issues that require components of the storage systems to be restarted. During this time, the Open OnDemand web portal will also be updated.

## Open OnDemand Maintenance (https://hpc.smu.edu)

The Open OnDemand web portal will be updated for security and bug fixes. The web portal runs on M3, so it will remain offline until the M3 maintenance is completed.

## ColdFront Downtime (https://hpcaccess.smu.edu)

ColdFront relies on services running on M3 and the SuperPOD, so it will be taken offline while the above maintenance is occurring. Any allocations that are scheduled to expire during the maintenance will automatically be extended by 7 days.

## New Login Node Resource Limits

Resource limits will be added to all HPC login nodes the week of March 16.

Login Node Memory limits:

- Users utilizing more than 14GB of RAM on login nodes will automatically have their processes throttled (slowed down)
- Users utilizing more than 16GB of RAM on login nodes will automatically have their processes terminated

Login Node CPU Limits:

- Users will be limited to 400% CPU usage on login nodes (the equivalent of fully utilizing 4 cores.)

These limits are being implemented to maintain the stability of the system for all users.  Running tasks on login nodes remains forbidden and tasks found running on login nodes may be terminated without notice. If you need assistance submitting jobs to the HPC systems, please open a help ticket by emailing help@smu.edu with “[HPC]” included in the subject line or attend one of the regularly scheduled office hours and support sessions.

## Reminder about changes to DUO and Microsoft Authenticator

Most SMU services and logins have transitioned to Microsoft Authenticator. This includes the Open OnDemand web portal (https://hpc.smu.edu) and ColdFront (https://hpcaccess.smu.edu). Please see https://www.smu.edu/oit/services/microsoft-authenticator for more details. Access to HPC systems using SSH will continue to require DUO authentication. Microsoft Authenticator will not work for SSH login sessions. We recommend that you keep the DUO app on your phone or other devices if you plan to use HPC services.

## Questions or Concerns

Please [contact us.](about:contact) if you have any questions or concerns about the scheduled maintenance.
