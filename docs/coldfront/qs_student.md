# Getting Started in ColdFront as a Student

These instructions will help you get access to HPC resources in your class.

## Getting to ColdFront

ColdFront is a platform for managing access to our HPC resources. You will need to go to [hpcaccess.smu.edu](hpcaccess.smu.edu) and log in to ColdFront using SSO.

## In Class

You will see your class and associated allocations on your dashboard. 
Your class will have at least one allocation for **Compute** and possibly allocations for **Storage**. 
You will see a button for **Pending EULA** next to each allocation.
You will need to accept the EULA for *each* allocation in order to get access the those resources.

```{note}
Once you accept the EULA, they will be granted an HPC account.
In most cases this process is instantenous, however if your class has a large number of files in a storage allocation, this could take several minutes.
```

If you are using the Open OnDemand portal [hpc.smu.edu](hpc.smu.edu) for your class, you will be able to click on the link in the top menu bar to go directly to the M3 Portal.

If you are using `srun` commands or `sbatch` scripts, you will need to add the following to your commands/scripts in order to utilize the resources.

`#SBATCH -A slurm_account_name`

or

`srun -A slurm_account_name …`

The `slurm_account` can be found in the Information field under Allocations.

```{image} ../images/CF/quick_start/resource_table.png
:alt: resource table
:width: 800px
```

## To view your current usage

1.	Under Allocations select the folder icon
2.	You will see your Allocation details, EULA Agreements, and Usage by Hours


## Concluding the Semester

At the end of the semester, your class will be Archived.
Once you class is successfully archived, you will not be able to access any of the resources on the system. 
Any files you have created that you wish to retain access to should be transferred off the HPC system.
