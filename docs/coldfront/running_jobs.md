# Running Jobs

## Job scripts

To run a job using a ColdFront allocation, you must include the associated
Slurm account in the job submissions script.
For example, if the Slurm account is `peruna_project_0001`, then you should add

```
#SBATCH -A peruna_project_0001 # slurm account to use
```

You can find the Slurm accounts associated with allocations you are on
by going to [**Compute Allocation List**](https://hpcaccess.smu.edu/allocation/?project=&username=&resource_type=&resource_name=1&allocation_attribute_name=&allocation_attribute_value=&end_date=&active_from_now_until_date=)
and clicking on the "Usage Help" link in the last column of the allocation you want to use.

## Open OnDemand Web Portal

On the On Demand Web Portal [hpc.m3.smu.edu](https://hpc.m3.smu.edu/),
simply select the Slurm account from the drop down menu.

```{image} ../images/CF/jobs/ood_slurm.png
:alt: Image dropdown Slurm Account field on Open OnDemand 
:height: 154px
```

:::{note}
The `smu` account shown will not be usable after November 1, 2024.
You must use an account from a ColdFront allocation.
:::
