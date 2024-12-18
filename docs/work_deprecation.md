# Personal $WORK deprecation

:::{important} Personal Work directories are deprecated. Any data you need to keep needs to be moved to a ColdFront project with a storage allocation.
:::

## What is changing

Beginning **January 15, 2025** the quotas for personal `$WORK` directories will be set to current usage plus a small amount. The quotas will then begin decreasing by at least 15% every month (based on the initial quota). Quotas will additionally be updated on a regular basis. When usage is lower than the current quota, the quota will be lowered to match.

By **August 15, 2025**, the quotas for personal `$WORK` directories will be set to 0 allowed files and 0 kB of storage space. At this point in time, data remaining in personal `$WORK` directories will be subject to deprovisioning.

## Known and Possible Impacts

- Personal `$WORK` directories will no longer exist.
- Modifying existing files or creating new files will not be possible when the quota is exceeded.
- Applications depending on files in `$WORK` may behave unexpectedly when the quota is exceeded.
- Many users have Conda environments installed in `$WORK`, we expect these will continue to function during the transition. However, they will need to be rebuilt an another location.

## Required Actions

- Any data currently stored in `$WORK` must be moved to storage allocations managed by ColdFront or to another location off of the HPC systems.
- Any personal software installations in `$WORK`, including Conda environments, will need to be reinstalled in a different location ($HOME directories or ColdFRont managed storage allocations)

:::{important} We strongly recommend taking time to assess which files you need to keep and which files can be deleted. The overall performance of our filesystems is reduced for all users as the storage space fills up.
:::

## Example of Quota changes

If your quota is 8TB (the default) and you have 3.45 TB of data in $WORK:

**January 15, 2025**:
quota = min(current usage + 2%, current usage + 0.2TB) = min(3.45 TB * 1.02, 3.45TB + 0.2TB) = min(3.519TB, 3.65TB) = 3.519 TB

**February 15, 2025**:
quota = (current quota - 15% Jan 15 quota) = 0.85 * (Jan 15 quota) = 0.85 * 3.519 TB = 2.991 TB

**March 15, 2025**:
quota = (current quota - 15% Jan 15 quota) = (2.991 TB - 0.15 * 3.519 TB) = 2.463 TB

**April 15, 2025**:
quota = (current quota - 15% Jan 15 quota) = (2.463 TB - 0.15 * 3.519 TB) = 1.935 TB

**May 15, 2025**:
quota = (current quota - 15% Jan 15 quota) = (1.935 TB - 0.15 * 3.519 TB) = 1.408 TB

**June 15, 2025**:
quota = (current quota - 15% Jan 15 quota) = (1.408 TB - 0.15 * 3.519 TB) = 0.880 TB

**July 15, 2025**:
quota = (current quota - 15% Jan 15 quota) = (0.880 TB - 0.15 * 3.519 TB) = 0.352 TB

**August 15, 2025**:
quota = (current quota - 15% Jan 15 quota) = (0.352 TB - 0.15 * 3.519 TB) = 0

:::{note} Quotas will be assessed on a regular basis and lowered to reflect usage.
:::
