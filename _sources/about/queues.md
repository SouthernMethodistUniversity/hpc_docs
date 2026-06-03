(about:queues)=
# Queues

SMU's high-performance computing (HPC) clusters use [SLURM](https://slurm.schedmd.com/)
to schedule and manage resources.

:::{seealso}
For examples and tips on SLURM usage, see [our SLURM documentation](../tutorials/slurm/slurm.md).
:::

:::{note}
The efficiency of SLURM and our HPC systems depend on reasonable resource requests.
Whenever possible, you should request only the resources your job needs including
memory, number of cores, number of gpus, and run time.

Requesting more than you need makes your job and everyone elses jobs run less 
efficiently.
:::


## M3 Queues

M3 has the following queues:

| Partition Name | Number of Nodes  | Cores Per Node | Memory Per Node | Time Limit | Notes                                          |
|----------------|------------------|----------------|-----------------|------------|------------------------------------------------|
| dev            | 4                | 128            | 500GB           | 2 hours    |                                                |
| gpu-dev        | 3                | 36             | 734GB           | 4 hours    | 8 Nvidia V100 GPUs per node                    |
| htc            | 20               | 128            | 500GB           | 24 hours   |                                                |
| standard-s     | 124              | 128            | 500GB           | 24 hours   |                                                |
| standard-l     | 20               | 128            | 500GB           | 7 days     |                                                |
| highmem        | 8                | 128            | 2TB             | 5 days     |                                                |
| dtn            | 2                | 128            | 500GB           | 7 days     | *approval required                             |

All M3 nodes are identical and contain dual AMD EPYC 7763 64-Core Processors with the exception of the
nodes on the `highmem` partition having more memory.

- The `dev` nodes are meant for interactive and development work. There are additional restrictions on this queue
to help keep resources available for all users with lower wait times, see the [extended description.](about:dev_queue)
- The `gpu-dev` nodes are meant for interactive and development work. Production and batch jobs should run on the SuperPod.
- The `htc` nodes are for "High Throughput Computing" and are intended for jobs that typically launch a
large number of tasks that require a single core and a small amount of memory for a short time. This is also an
appropriate queue for many interactive jobs requiring longer than 2 hours.
- The `standard-s` and `standard-l` nodes are where most jobs should be run depending on their duration
- The `highmem` nodes are for jobs requiring more than 500GB of memory
- The `dtn` nodes are "Data Transfer Nodes." Access requires approval. These nodes are meant only for transfering
data to/from M3.

:::{note}
You should select the queue most appropriate for your jobs and not on current availability.
:::

(about:dev_queue)=
### dev queue

The dev queue is intended for interactive work, development, and other short tasks.
The following job restrictions apply:

- 2 hour time limit per job.
- Users are limited to using up to 1000GB and/or up to 256 cores at a time. This is approximately half of all of the resources in the dev queue. Jobs requesting more resources will not start. For example, you may submit 500 (or more)
jobs to the dev queue requesting 1 core each, in which case a maximum of 256 of these jobs could run simultaneously (fewer may run do to resource availability and other factors.)
- A maximum of 4 jobs per user will gain priority based on wait time. Jobs will start if there are idle resources as long
as there are not restricted by other limits. This is to prevent individual users or groups from being able to monopolize
use of the queue for long periods of time.

Users with jobs exceeding the resource limits of 1000GB and/or up to 256 cores at a time will see jobs with the
statuses:

- **QOSMaxMemoryPerUser** -- The means that the job cannot currently start because the combination memory requested for currently running jobs and this job's memory requests is over 1000GB. The job will be allowed to start once enough running jobs complete and relinquish memory. **Individual jobs requesting more than 1000GB will never start.**
- **QOSMaxCpuPerUserLimit** -- This means that the job cannot currently start because the combination of requested CPU cores for currently running jobs and this jobs requested number of CPU cores is more than 256. The job will be allowed
to start as jobs complete and release reserved cores. **Individual jobs requesting more than 256 cores will never start.**

## SuperPod Queues

The SuperPod has 2 queues:

| Partition Name | Number of Nodes | Cores Per Node | Memory Per Node | GPUs Per Node  | Time Limit |
|----------------|-----------------|----------------|-----------------|----------------|------------|
| batch          | 18              | 128            | 2TB             | 8 Nvidia A100s | 48 hours   |
| short          | 2               | 128            | 2TB             | 8 Nvidia A100s | 4 hours    |

All SuperPod nodes are identical and contain dual AMD EPYC 7742 64-Core Processors.

We have partitioned the nodes on the SuperPod, so for every GPU you request, you will also 
receive 16 CPU cores and 96GB of memory automatically.

:::{note}
CPU only jobs should be run on M3 and not the SuperPod
:::

### Short queue

The short queue is intended for interactive work, development, and other short tasks.
The following job restrictions apply:

- 4 hour time limit
- default allocation 1 GPU, 16 cores, 96GB memory, 2 hours
- default of of 96 GB and 16 cores per GPU
- Max 2 GPUs
- Max 128GB per GPU
- Max 16 cores per GPU
- Max 1 running job per user
- ssh access to compute nodes enabled for running jobs

### Special Requests

Exceptions may be requested, for example, to run a job on all 20 SuperPOD nodes.
Approval for any such requests will be the responsibility of the 
[O’Donnell Data Science and Research Computing Institute](https://www.smu.edu/provost/odonnell-institute)
and will be based on demonstrated need and impact to other users.
