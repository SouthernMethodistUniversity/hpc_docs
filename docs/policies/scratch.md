# $SCRATCH Policies

The `$SCRATCH` (`/scratch/users/<username>`) filesystem is intended to be temporary,
high performance storage for running jobs.
It is not intended for persistent storage.
In order to maintain performance and stability for all users, the `$SCRATCH` filesystem has a
**60 day purge policy** where files older than 60 days will be permanently deleted.
Files are not backed up in `$SCRATCH`, so important data or scripts need to be moved to `/projects` directories (project directories are not backed up) `$HOME` directories (home directories have a 7 day rolling snapshot based backup) or
off of the HPC systems to be retained.

## Changes beginning July 1, 2026

- The 60 day purge policy on `$SCRATCH` will be automated.
- A quota of 50TB and 10,000,000 files per user will be added to `$SCRATCH`.

These changes are meant to improve the performance and availability of the
`$SCRATCH` storage space for all users.

### Planned 60 day purge policy automation rollout and methodology

In order to reduce stress on the HPC storage systems, the `$SCRATCH`
purge automations will begin by deleting the oldest files stored in
`$SCRATCH` over several weeks until the age of all remaining files
are within the 60-day limit.

#### Communications

- All users currently utilizing `$SCRATCH` storage space will receive
personalized emails summarizing their their usage with reminders of
the upcoming changes.

#### Tentative Schedule

Note, the schedule may be slowed or accelerated based on the observed load on
the HPC systems.

##### July 1

Beginning on July 1, 2026, the `$SCRATCH` purge automation will begin.
Initially the purges will be focused on files older than 2 years old.
The maximum age of the files allowed will slowly be decreased from 2 years to the
stated 60 day policy.

##### Fall 2026

The 60 day purge policy will begin to run on a scheduled basis.
Tentatively, this is planned for mid-August, but may occur later
based on how long it takes to run the initial processing needed to
purge the files much older than 60 days.

### Quotas

Quotas will be added on July 1, 2026 with the following limits, per user:

| Soft Quota (TB) | Hard Quota (GB) | Soft Quota (Filecount) | Hard Quota (Filecount) | Grace Period |
|-----------------|-----------------|------------------------|------------------------|--------------|
| 50 TB | 60 TB | 10,000,000 | 11,000,000 | 10 Days |

If an user exceeds a "Soft Quota" (50TB, 10,000,000 files) they will be able to temporarily exceed this quota,
up to the "Hard Quota" (60TB, 11,000,000 files) for up to the "Grace Period" (10 days).

When either the "Hard Quota" is reached or usage has been over the "Soft Quota" for more than the "Grace Period,"
it will not be possible to create or modify files until the user is under the "Soft Quota."
Once usage is below the "Soft Quota," the "Grace Period" will reset.

This structure is intended to allow running jobs to complete without being terminated
due to the quota and allow users time to clean up any excess files.
We will attempt to notify users that have exceeded the "Soft Quota" within 48 hours using
their SMU email address, but it is the responsibility of each user to monitor their own usage.

Users can see their recent usage on ColdFront under [personal storage usage](https://hpcaccess.smu.edu/usage/personal-storage)
or in real-time from the HPC systems with the command

```bash
lfs quota -h -p $(id -u) /scratch
```

#### Quota Exceptions

Temporary exceptions to the quotas may be considered on a case-by-case basis.
Approval of any requests require documentation of at least:

- Your workflow and an explanation of why that workflow is not possible
with the default quota amounts.
- A plan and demonstrable process(es) for using the data within the 60 day purge policy.
Requests that cannot demonstrate that the data will be deleted, used, or moved off of
the HPC systems within 60 days will not be approved.
- Reasonable efforts have been made to reduce storage needs, such as using efficient output file formats
or compression.

## 60 Day Purge Policy

All files stored in the `$SCRATCH` (`/scratch/users/<username>`) are eligible to
be deleted without warning if they are over 60 days old.

### Age determination

Files will be determined to be over 60 days old if all of the following criteria are met:

1. The file's `atime` is greater than or equal to 60 days old.
2. The file's `mtime` is greater than or equal to 60 days old.

Definitions:

- `atime` is "access time" and it the last time the data from a file or directory was accessed (e.g. used directly by a process or through commands and scripts)
- `mtime` is "modification time" and it is the last time the file's contents where modified.

Attempts to circumvent the purge policy by modifying either the `atime` or `mtime` outside of normal usage is a violation of policy and will be reported.

### Transparency

Whenever possible, a manifest of files that are going to be deleted will be available at least 5 days
before the deletion occurs.
These manifests will typically be generated once a week.

We highly recommend reviewing these lists and moving any files you need to retain.
Files on these manifests may be deleted even if the access or modification times change
after the manifest is generated.

### Notifications

By default, users will be sent a notice when a new manifest of files is available
to their SMU email address.
User may opt out of these emails in ColdFront.
More details about opting out will be available soon.
