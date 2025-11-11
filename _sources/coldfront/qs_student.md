# Getting Started in ColdFront as a Student

These instructions will help you get access to HPC resources in your class.

## Getting to ColdFront

[ColdFront](https://www.smu.edu/provost/odonnell-institute/hpc/cf) is a platform for managing access to our HPC resources. You will need to go to [hpcaccess.smu.edu](https://hpcaccess.smu.edu) and log in to ColdFront using SSO.

## In Class

```{dropdown} Video Walkthrough
<iframe src="https://smu.app.box.com/embed/s/duihsm33td92fvwaosw0thpeqld6c2e5?sortColumn=date" width="100%" height="550" frameborder="0" allowfullscreen webkitallowfullscreen msallowfullscreen></iframe>
```

Under <img src="../images/CF/quick_start/allocations.png" alt="Allocations" height="40"> you will see your class and associated allocations on your dashboard.
Your class will have at least one allocation for **Compute** and possibly allocations for **Storage**. 

For *each* allocation:

1. Click on the **Review and Accept policies and guidelines to activate** button.

    ```{image} ../images/CF/quick_start/review_button.png
    :alt: Review and Accept policies and guidelines to activate
    :height: 100px
    ```

2. Read the [HPC policies and guidelines](https://southernmethodistuniversity.github.io/hpc_docs/policies/policies.html), as well as the [ODSRCI guidelines](https://www.smu.edu/provost/odonnell-institute/hpc/guidelines).

3. Click on <img src="../images/CF/quick_start/i_agree.png" alt="I Agree" height="40">.

```{note}
Once you accept the Policies and Guidelines, you will be granted an HPC account.
In most cases this process is instantenous, however if your class has a large number of files in a storage allocation, this could take several minutes.
```

If you are using the Open OnDemand portal [hpc.smu.edu](hpc.smu.edu) for your class, click on <img src="../images/CF/quick_start/ood_logo.png" alt="Open OnDemand Logo" height="40"> to go directly to the M3 Portal.

If you are using `srun` commands or `sbatch` scripts, you will need to add the following to your commands/scripts in order to utilize the resources.

`#SBATCH -A slurm_account_name`

or

`srun -A slurm_account_name …`

The `slurm_account_name` can be found on the project page in the <img src="../images/CF/quick_start/info.png" alt="Information" height="40"> field under <img src="../images/CF/quick_start/alloc_panel.png" alt="Allocations" height="40">.

## To view your current usage

1.	Under <img src="../images/CF/quick_start/alloc_panel.png" alt="Allocations" height="40"> select the folder icon
2.	You will see your Allocation details, Policies and Guidelines Agreements, and Usage by Hours.


## Concluding the Semester

At the end of the semester, your class will be Archived.
Once your class is successfully archived, you will not be able to access any of the resources on the system. 
Any files you have created that you wish to retain access to should be transferred off the HPC system.
