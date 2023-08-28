# Best Practices for Jobs

The following are some tips that will help your and everyone elses jobs use HPC resources more efficiently.

## Make accurate resource requests

The job scheduler only knows what you tell it. Being more specific about the resources you need helps SLURM schedule jobs more efficiently. This will help your and everyone elses jobs start sooner.

### Time Limit

You should specify a time limit as low as you realistically believe your job will run in. It is reasonable to be conservative and over-estimate, but if you think your job will take about an hour it makes sense to request 2 or 3 hours, but not 24 hours.

The scheduler can sometimes fit shorter running jobs in between jobs that are waiting for resources based on when those resources are scheduled to become available. This process is refered to as ''backfilling.''

```
#SBATCH --time=0-05:00:00 # time in days-HH:MM:SS
```

### Memory Limit

Making accurate memory requests helps increase the throughput on our machines. It is not uncommon to see jobs use less than 5% of the memory they requested. When this happens, it may delay your or other users' jobs from starting.

Note: memory is often difficult to estimate. If you are running multiple similar jobs, it is worth experimenting to figure out how much memory they usually use.

```
#SBATCH --mem=12G # memory per node in GB
or
#SBATCH --mem-per-cpu=4000M # memory per cpu core in MB
```

### CPU cores

Making accurate core requests helps increase the throughput on our machines. It is not uncommon to see jobs use a single core, but request many more. When this happens, it may delay your or other users' jobs from starting.

NOTE: Using multiple cores makes many programs run faster, but not all programs utilize multiple cores. Furthermore, like all parallelism, using more cores does not always scale well. For example a program may run in 3 hours using 64 core or 2 hours using 128 cores. In this case, it might be better to submit jobs using 64 cores (64 cores * 3 hours = 192 cpu hours) instead of jobs using 128 cores (128 cores * 2 hours = 256 cpu hours.) You should experiment with what works best for your use cases.

```
#SBATCH -c 12 # cpu cores per task
```

## Review usage on completed jobs

In many cases the only way to know what resources your job needs is to run it. You can view some statistics on recently completed jobs using tools like [reportseff](https://github.com/troycomi/reportseff). We have this installed on the systems already, for example:


Load `reportseff` using the module system
```
module load gcc/11.2.0
module load py-reportseff
```

Print out stats about a specific Job ID:

```
$ reportseff 3551880
    JobID   State      Elapsed  TimeEff   CPUEff   MemEff 
  3551880  TIMEOUT    01:00:15  100.4%     0.2%    13.6%  
  ```

Print out stats about your recent jobs:

```
# print out jobs from the last day
$ reportseff -u $USER --since d=1
    JobID    State       Elapsed  TimeEff   CPUEff   MemEff 
  3551880   TIMEOUT     01:00:15  100.4%     0.2%    13.6%  
  3553733  CANCELLED    00:13:18   22.2%     0.8%    13.5%  
  3553746  CANCELLED    00:08:23   14.0%     1.2%    14.0%  
  3554482  CANCELLED    00:03:15   5.4%      3.6%    11.5%  
  3554486  CANCELLED    00:19:03   31.8%     ---      2.0%  
  3561043  CANCELLED    00:13:24   22.3%     0.7%    11.5%  
  3565236  CANCELLED    00:00:19   0.5%     36.8%     0.0%  
  3565357  CANCELLED    00:04:46   7.9%      2.4%    11.4%  
  3567440   FAILED      00:00:08   0.2%     87.5%     0.0%  
  3568040   FAILED      00:00:08   0.2%     87.5%     0.0%  
  3569155  CANCELLED    00:01:07   1.9%     10.4%    11.4%  
  3571944  CANCELLED    00:08:10   13.6%     1.4%    11.3%  
  3574127  CANCELLED    00:15:31   25.9%     0.8%    13.6%  
  3575979  CANCELLED    00:00:43   1.2%     14.0%    12.6%  
```

:::{Note}
If you command outputs a large number of jobs, the formatting is sometimes not clean.
:::

### Time Efficiency

The time efficiency column represents what percentage of your requested time was used by your job. A good target to aim for is about `80%` efficiency. While desireable from a scheduling point of view, approaching `100%` efficiency may result in jobs failing if they take slightly longer than expected.

### CPU efficiency

The CPU efficiency represents what percentage of the CPU cores in your job request where used by your job. You should always want your CPU efficiency to be as high as possible.

If your CPU efficiency is low, you should inspect your program to ensure it is doing what you expect. Many programs require you to explicitly tell them to use multiple cores or specifically code for multiple cores. 

If your program is behaving as expected, consider reducing the number of cores you are requesting. Although this may increase the time required to run your job, it may use fewer resources meaning your and other users' jobs may start sooner.

### Memory Efficiency

The memory efficiency represents the percentage of the requested memory that was used by your job. Realistically, anything about `50%` memory efficiency is good. Due to how memory is measured, programs that dynamically allocate and deallocate memory may fail as a result of running out of memory even if the reported usage is "low." If you know your program allocates most of the memory it uses at the beginning, aiming for `80-90%` efficiency is a good target.

:::{Note}
Memory efficiency is hard to measure. SLURM periodically samples memory usage, so it often misses large spikes of increased memory usage that occurs between samples. It is not unsual for jobs to temporarily use 2x or more memory than reported.
:::

## Use array jobs

If you are submitting a "large" number of jobs with identical resource needs, SLURM can handle these requests more efficiently with Job Arrays.

See our [SLURM examples](slurm.md) and the [SLURM documentation](https://slurm.schedmd.com/job_array.html)

## Only use `--exclusive` when needed

Using the `--exclusive` flag can result in large amounts of computational resources sitting idle.

In general, you should only use the exclusive flag if you have an use case that warrants it. For example, if you need reliable timing data or are working with data that has certain security restrictionns that require you to be the only user on the node.

## Frequently asked questions

### Why isn't my job starting?

Our high performance computing systems are a shared resource and there is no expectation that any particular set of resources is available at any particular time.

You can see your pending jobs by running

```
$ squeue --me --start
             JOBID PARTITION     NAME     USER ST          START_TIME  NODES SCHEDNODES           NODELIST(REASON)
           1023324652 standard- job_a username PD 2023-08-29T16:45:19      1 (null)               (Priority)
           1023511323 standard- job_b username PD 2023-08-29T16:45:19      1 (null)               (Resources)
```

from a terminal. Sometimes an estimated `START_TIME` is shown, usually (but not always) we find that jobs start before this time. The reason this happens is that SLURM basis these times on the requested time in the job script, but many jobs finish well before their allocated time limit. Making more accurate job requests will improve the accuracy of these estimates. It is also possible that a job will start after this time (the order jobs run in is periodically recalculated.)

You should also inspect the `NODELIST(REASON)` column to ensure your job is valid. Most valid jobs will show one of the following:

| Reason Code | Explanation |
|-------------|-------------|
| `Priority` | There are jobs with higher priority than this job in the queue waiting to start. |
| `Resources` | The job is waiting for the requested resources to become available and will start running when that happens. |
| `Depedency` | The job is waiting for a dependent job to complete running |
| `StartTime` | The job has requested to run at a future time. It cannot start until this time is reached, but may still have to wait in the queue |

Most other codes indicate that there is a problem with the job request (for example `PartitionTimeLimit` means the job requested more time than is allowed.)

A complete list of codes is available here: [squeue documentation](https://slurm.schedmd.com/squeue.html#lbAF)
