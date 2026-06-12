# HPC Offboarding

When an user's eligibility to use SMU's HPC systems changes, access
to the systems will automatically be disabled or restricted.
Eligibility to SMU's HPC systems is based on the status and permissions
of each users SMU credentials.
The HPC Support and Research Technology Services teams cannot
make exceptions to these processes, but can assist with navigating
the process to request exceptions, which may require approval from
Human Resources, the Office of Research and Innovation, the Office
of Information Technology, and/or other entities on campus.

## Faculty and Staff

Faculty and staff will lose eligibility to use SMU's HPC systems when
they retire or are no longer employed by SMU (other exceptions may exist.)

### Proactive Measures

If you are aware of situation where you expect to lose HPC eligibility,
we strongly suggest proactively managing HPC related items:

- Download data you need off of the HPC systems.
  **Note: taking data generated while employed at SMU may require a
  data transfer agreement, please consult the Office of Research and Innovation.**
- Transfer ownership of any ColdFront managed HPC projects.
  Please send requests to help@smu.edu with "[HPC]" included subject line.
- Schedule a consultation with the Research Technology Services team by
  emailing oitresearch@smu.edu well in advance if you believe there are
  any special circumstances that need to be addressed.

### What will happen

The following assume that all eligibility has been lost.

- Your HPC account will be disabled. It will not be possible to
  log on to the HPC systems.
- If you own any ColdFront managed HPC projects, those projects
  will be deactivated unless prior arrangements have been made to
  transfer ownership. This will deactivate all allocations associated
  with the project(s) which will revoke access to the project resources
  for all users on the project.
- If you are own HPC projects that are owned by someone else,
  your account will be deactivated on those projects and associated allocations.
- Any running or queued jobs on the HPC systems will be cancelled.

### Regaining Access

Former faculty and staff are generally eligible to be sponsored as an
external collaborator.
This requires at least:

- A current faculty or staff member must request to sponsor
  the former faculty member.
- Approval from Human Resources.
- Approval of a HPC eligible sponsored account type.

## Students

Students will lose eligibility to use SMU's HPC systems when
they graduate or are no longer enrolled at SMU (other exceptions may exist.)

### Proactive Measures

If you are aware of situation where you expect to lose HPC eligibility,
we strongly suggest proactively managing HPC related items:

- Download data you need off of the HPC systems.
- Consult with your advisor(s) and professors to identify any
  data or programs that they need to know about and make sure they
  have or know how to access them.

### What will happen

- Your HPC account will be disabled. It will not be possible to
  log on to the HPC systems.
- Your account will be deactivated on all ColdFront projects and
  allocations that you are on.
- Any running or queued jobs on the HPC systems will be cancelled.

### Regaining Access

Former students are generally eligible to be sponsored as an
external collaborator.
This requires at least:

- A current faculty or staff member must request to sponsor
  the former faculty member.
- Approval of a HPC eligible sponsored account type.

## External Collaborators

External collaborators are required to maintain an eligible sponsored account.
External collaborators will lose eligibility to use SMU's HPC systems when their
sponsored account expires or is revoked.
The faculty or staff member sponsoring an external user is responsible for maintaining
and renewing the sponsorship.

Note: sponsored SMU accounts are required for external users to access the HPC systems,
but they are not HPC accounts.

### Proactive Measures

If you are aware of situation where you expect to lose HPC eligibility,
we strongly suggest proactively managing HPC related items:

- Download data you need off of the HPC systems.
- Consult with your sponsor(s) to identify any
  data or programs that they need to know about and make sure they
  have or know how to access them.

### What will happen

- Your HPC account will be disabled. It will not be possible to
  log on to the HPC systems.
- Your account will be deactivated on all ColdFront projects and
  allocations that you are on.
- Any running or queued jobs on the HPC systems will be cancelled.

### Regaining Access

External collaborators are generally eligible to be re-sponsored as an
external collaborator.
This requires at least:

- A current faculty or staff member must request to sponsor
  the former faculty member.
- Approval of a HPC eligible sponsored account type.

## Data

Data stored on the HPC systems by users who are deactivated or
no longer eligible is subject to all current deprovisioning
policies and procedures.
SMU currently has no archival systems for HPC scale data.

### Data in $SCRATCH

Data in `$SCRATCH` storage remains subject to the 60-day purge
policy and files older than 60 days will be automatically and
permanently deleted.

$SCRATCH storage has no backups.

### Data in home directories

Data stored in home directories is retained as long as is reasonably
possible. However, home directories of users who have not been
eligible for HPC access for 6 or more months is subject to deprovisioning
and permanent deletion to maintain system availability and stability
for current users.

Home directories maintain a 7-day rolling, snapshot based backups.

### Data stored in project directories

Data stored in project directories will be retained as long as the
corresponding ColdFront managed storage allocation remains active.

Data stored in expired or revoked project directories is subject to
deprovisioning and permanent deletion to maintain system availability and stability
for current users. When possible, data stored in expired or revoked
project directories will be retained for at least 60 days.

Project directories are redundant, but are not backed up.