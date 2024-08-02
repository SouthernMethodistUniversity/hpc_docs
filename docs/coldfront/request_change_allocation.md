# Request or Change Resource Allocations

***Managers*** on a project or class can request a ***Compute*** or ***Storage*** Allocation and select which ***User(s)*** should have access to those allocations. All allocation requests will need to be approved by HPC Support.

```{note}
Please see [Add or Remove Users](https://southernmethodistuniversity.github.io/hpc_docs/coldfront/add_remove_users.html) for how to manage ***User*** permissions on an already active allocation.
```

## Resource Types

| Resource        | Description                                                                |
| --------------- | -------------------------------------------------------------------------- |
| ***Compute***   | Allocates compute time quotas for CPU hours, GPU hours, and memory hours.  |
| ***Storage***   | Allocates shared folder with storage quotas on memory and number of files. |

## ***Compute*** Allocations

There are 3 fields to specify when requesting a ***Compute*** allocation: ***CPU hours***, ***GPU hours***, and ***memory hours***. Below are descriptions of each field:

| Field              | Description               |
| ------------------ | ------------------------- |
| ***CPU hours***    | Computed per job as (number of allocated CPU cores) * (run time in hours). For example, if a job was allocated 64 cores and ran for 30 minutes, it used (64) * (0.5) = 32 ***CPU hours*** of compute time.    |
| ***GPU hours***    | Computed per job as (number of allocated GPUs) * (run time in hours). For example, if a job was allocated 4 GPUs and ran for 1 hour and 30 minutes, it used (4) * (1.5) = 6 ***GPU hours*** of compute time. |
| ***Memory hours*** | Computed per job as (amount allocated memory in GB) * (run time in hours). For example, if a job was allocated 128GB of memory and ran for 45 minutes, it used (128) * (0.75) = 96 ***Memory hours***.     |

```{note}
- If you request ***CPU hours***, you <u>MUST</u> request ***memory hours*** as well. The general guideline is that you need 4 ***memory hours*** for 1 ***CPU hour***.
- If you request ***GPU hours***, you <u>MUST</u> request both ***CPU hours*** and ***memory hours*** as well. The general guideline is that you need 16 ***CPU hours*** and 96 ***memory hours*** per 1 ***GPU hour***.
- CPU hour, GPU hour, and memory hour quota's will persist across all M3 queues and SuperPod queues. For example, if you use up your quota of GPU hours entirely on the gpu-dev queue on M3, then you will not have GPU hours left to use on M3 or the SuperPod. If you need assistance in determining how many hours to request, please contact [oitresearch@smu.edu](mailto:oitresearch@smu.edu).
```

### Request ***Compute*** Allocation

### Change ***Compute*** Allocation

## ***Storage*** Allocations

[Add language here]

### Request ***Storage*** Allocation

### Change ***Storage*** Allocation