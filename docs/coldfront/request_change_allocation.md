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
***CPU hour***, ***GPU hour***, and ***memory hour*** quota's will persist across all M3 queues and SuperPod queues. For example, if you use up your quota of ***GPU hours*** entirely on the gpu-dev queue on M3, then you will not have ***GPU hours*** left to use on M3 or the SuperPod. If you need assistance in determining how many hours to request, please contact [oitresearch@smu.edu](mailto:oitresearch@smu.edu).
```

### Request ***Compute*** Allocation

1. Select ***+ Request Resource Allocation***.

2. Select ***Compute*** as your Resource from the dropwdown.

3. Provide a 2-3 sentence justification for the resources you are requesting.

4. Select a Start Date and End Date for your allocation. The limit is 1 year, but can be renewed.

5. Enter the number of ***CPU hours*** you will need.

    ```{admonition} General Guidelines
    :class: tip
    When requesting ***CPU hours***, you <u>MUST</u> request ***memory hours*** as well. The general guideline is that you need 4 ***memory hours*** for 1 ***CPU hour***. If you need assistance in determining how many hours to request, please contact [oitresearch@smu.edu](mailto:oitresearch@smu.edu).
    ```

6. Enter the number of ***GPU hours*** you will need.

    ```{admonition} General Guidelines
    :class: tip
    When requesting ***GPU hours***, you <u>MUST</u> request both ***CPU hours*** and ***memory hours*** as well. The general guideline is that you need 16 ***CPU hours*** and 96 ***memory hours*** per 1 ***GPU hour***. If you need assistance in determining how many hours to request, please contact [oitresearch@smu.edu](mailto:oitresearch@smu.edu).
    ```

6. Enter the number of ***memory hours*** you will need.

7. If you have users on your project, select which users should have access to the allocation.

8. Please read and acknowledge that you will follow the ODSRCI Community Guidelines.

9. Click on Submit.

10. Wait for your allocation to be approved by HPC Support.

### Change ***Compute*** Allocation

Coming Soon.

## ***Storage*** Allocations

A ***Storage*** allocation is a shared directory with a quota on gigabytes (GB) of storage, and number of files. Every HPC user will still have a `$HOME` directory and a `$SCRATCH` directory that does not count towards the quota. Please see the [Purge Policy](https://southernmethodistuniversity.github.io/hpc_docs/policies/policies.html#purge-policy) for details.

### Request ***Storage*** Allocation

1. Select ***+ Request Resource Allocation***.

2. Select ***Storage*** as your Resource from the dropwdown.

3. Provide what you would like to name the shared folder. If a name is not provided, a generic name will be assigned.

4. Provide a 2-3 sentence justification for the resources you are requesting.

5. Select a Start Date and End Date for your allocation. The limit is 1 year, but can be renewed.

6. Enter the amount of storage you would like in GB.

    ```{note}
    This amount is a storage quota, which means you are capped at the provided GB, but are not guarunteed to get that much.
    ```

7. Enter the number of files you expect to create or use in this allocation.

    ```{admonition} General Guidelines
    :class: tip
    - A conda environment needs about 100,000 files.
    - A safe bet for most people is 500,000 files for a storage allocation.
    ```

8. If you have users on your project, select which users should have access to the shared folder and whether they should have ***Read and Write*** access or ***Read Only*** access. 

    ```{note}
    ***Read Only*** means that they will only be able to see file contents, but not change them or create new files in the shared directory. ***Read and Write*** gives them full editing permissions.
    ```

9. Please read and acknowledge that you will follow the ODSRCI Community Guidelines.

10. Click on Submit.

11. Wait for your allocation to be approved by HPC Support.

### Change ***Storage*** Allocation

Coming Soon.