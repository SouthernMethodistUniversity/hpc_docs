# Policies and Guidelines

## SMU Policies

Users must comply with all university regulations, including 
[SMU’s acceptable use policy](https://www.smu.edu/policy/8-information-technology/8-1-acceptable-use) and the 
[ODSRCI Guidelines](https://www.smu.edu/provost/odonnell-institute/hpc/guidelines, when accessing HPC resources.

## Data Restrictions

Please review [SMU's Institutional Data Governance
](https://www.smu.edu/policy/8-information-technology/8-6-institutional-data-governance).

SMU's HPC systems are generally not approved for use with restricted or confidential data.
This includes, but is not limited to:

- personally identifiable data
- protected health information
- FERPA protected data

In most cases, unpublished research is classified as private data according to SMU policies.
Private data can generally be used on the HPC systems.
However, SMU's HPC system is a research and academic tool and may lack adequate protections for some types of
private data.

Data classified as public can always be used on the system as long as owning, storing, or using the data does
not violate other SMU policies, contractual agreements, laws, or other regulations.

Please consult with [SMU's Office of Research and Innovation (ORI)](https://www.smu.edu/provost/research)
to ensure compliance before utilizing HPC resources.

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

## Login Nodes

Running code, tasks, and persitent processes on login nodes is forbidden. The login nodes
are a shared environment and running intensive tasks can make the entire system unstable for
all users. Tasks running on login nodes may be terminated by system adminstrators to preserve
system stability.

Some examples of acceptable use of login nodes:

Allowed: Job submission, text editing, environment building (Conda/UV), and small compiles.
Prohibited: Heavy computation, large-scale make -j commands, and persistent background processes.

If you need assistance submitting jobs, please [contact us](../about/contact.md).

## Account and Account Password Sharing Policy

Sharing accounts or passwords is strictly prohibited. Each user must have their own unique credentials. If a collaborator needs access, please have them request a new account.

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
- Only share data with AI tools that you are legally and ethically permitted to share. Note: Sending unpublished research to public AI models may compromise your Intellectual Property or violate grant requirements. 

We highly recommend reviewing SMU's [Generative AI Guidance](https://www.smu.edu/oit/ai).

Need Assistance?
For questions regarding data compliance, storage limits, or job submission, please Contact the HPC Team.
