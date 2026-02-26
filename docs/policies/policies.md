# Policies and Guidelines

## SMU Policies

Users must comply with all applicable laws, regulations, and SMU policies
when using HPC resources. This includes, but is not limited to, 
[SMU’s acceptable use policy](https://www.smu.edu/policy/8-information-technology/8-1-acceptable-use)

### O’Donnell Data Science and Research Computing Institute Community Guidelines

Please review the
[ODSRCI Guidelines](https://www.smu.edu/provost/odonnell-institute/hpc/guidelines)

## Purge Policy

Data stored in `$SCRATCH` on M3 or the SuperPod has a time based quota.
Data older than 60 days will be purged (deleted) without warning.
`$SCRATCH` is intended as high performance, temporary storage for jobs.

If data is needed for a longer period of time, it should be stored in
ColdFront storage allocations (limits vary and require justification) or `$HOME` directories (200 GB). If those are also
insufficient, please contact us to discuss options.

:::{important} SMU does not currently have facilities for archival storage of large datasets.
Most of our HPC storage is redundant, but it is not (and cannot) be backed up.
Storage space is also limited and current and active usage is prioritized.
Please [contact us](../about/contact.md) to discuss needs and potential options.
:::

## Account and Account Password Sharing Policy

No two individuals should share the same HPC account, nor
should two individuals share the password of the same account. Each
individual is entitled to have their own account hence please request
one.

## Data Transfer Nodes

Access to data transfer nodes is available by request and legitimate need.
These nodes are meant only for transferring large amounts data to/from HPC resources.
They should not be used for computational jobs.

## AI Guidance

We realize that AI can play an important role in research. AI can
also impact HPC services, security, data, and compliance with funding agencies,
laws, and university policies.

The following are some key points to consider when using AI tools. While we
direct these specifically at AI, they also apply to any software, tools, or commands
run on SMU HPC systems.

- Providing an AI with your SMU or HPC credentials or using AI tools to circumvent
  system logins is a violation of [SMU policy](https://www.smu.edu/policy/8-information-technology/8-1-acceptable-use).
- Users are responsible for actions taken by any AI they choose to use. AI tools are
  often stochastic in nature and may not behave as expected. It is possible that an AI tool
  may take unexpected actions that adversely impact research (for example, AI tools
  may corrupt or permanently delete data even if explicitly instructed not to.)
- Only share data with AI tools that you are allowed to share. Even if you are allowed to
  share data, we recommend exercising caution, especially if the data is sent to a third
  party service (these services may use your research to train their models or for other
  purposes.)

We highly recommend reviewing SMU's [Generative AI Guidance](https://www.smu.edu/oit/ai).
