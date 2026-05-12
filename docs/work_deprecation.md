# Personal $WORK is End of Life

Personal $WORK directories were retired on August 15, 2025 and are no longer usable. Any remaining data may be removed at any time.

## Personal $WORK deprecation plan

:::{important} Personal Work directories are end of life. Any data you need to keep needs to be moved to a ColdFront project with a storage allocation, your home directory, or off of the 
HPC storage.
:::

### What changed

- Starting January 15, 2025, quotas were set to:
- current usage plus a small buffer

- Quotas then decreased by at least 15% each month

- Quotas may be adjusted regularly based on usage

- If your usage drops below your quota:
- your quota is reduced to match

- By August 15, 2025:
- quotas were reduced to 0 files and 0 kb of storage
- remaining data became subject to removal 
  


### Known and Possible Impacts

- Personal `$WORK` directories no longer exist

- You cannot:
- Create new files
- Modify existing files (if over quota)
- 
- Applications that rely on `$WORK` may:
- Fail
- Behave unexpectedly

- Conda Environments:
- May have worked during the transition
- Must be now rebuilt in another location

### What you must do

- Move all important data out of `$WORK`

- Move files to one of the following:
- ColdFront stoage allocations
- Your home directory
- External/off-system storage

- Reinstall any software previously stored in `$WORK`
- Including Conda environments 


### Example of Quota changes

Your storage limit decreased each month until it reached zero. 

If your quota is 8TB (the default) and you have 3.45 TB of data in `$WORK`:

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
