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
***CPU hour***, ***GPU hour***, and ***memory hour*** quota's will persist across all M3 queues and SuperPod queues. For example, if you use up your quota of ***GPU hours*** entirely on the gpu-dev queue on M3, then you will not have ***GPU hours*** left to use on M3 or the SuperPod. If you need assistance in determining how many hours to request, please submit a help desk ticket to [help@smu.edu](mailto:help@smu.edu) with [HPC] in the subject line.
```

### Request ***Compute*** Allocation

```{dropdown} Video Walkthrough
<iframe src="https://smu.app.box.com/embed/s/vk5v4eacfl1eoi06l2uurvgaapvcwci9?sortColumn=date" width="100%" height="550" frameborder="0" allowfullscreen webkitallowfullscreen msallowfullscreen></iframe>
```

1. Click on <img src="../images/CF/request_change_allocation/request_resource.png" alt="Request Resource Allocation" height="40"> in the Allocations box on your project page.

2. Select ***Compute*** as your Resource from the dropwdown.

    ```{image} ../images/CF/request_change_allocation/select_compute.png
    :alt: Compute selected on Resource dropdown
    :width: 800px
    ```

3. Provide a short description to make your allocation easier to identify.

4. Provide a 2-3 sentence justification for the resources you are requesting.

5. Select a Start Date and End Date for your allocation. The limit is 1 year, but will be renewable when the end date is near.

6. Enter the number of ***CPU hours*** you will need.

    ```{admonition} General Guidelines
    :class: tip
    When requesting ***CPU hours***, you <u>MUST</u> request ***memory hours*** as well. The general guideline is that you need 4 ***memory hours*** for 1 ***CPU hour***. If you need assistance in determining how many hours to request, please submit a help desk ticket to [help@smu.edu](mailto:help@smu.edu) with [HPC] in the subject line.
    ```

7. Enter the number of ***GPU hours*** you will need.

    ```{admonition} General Guidelines
    :class: tip
    When requesting ***GPU hours***, you <u>MUST</u> request both ***CPU hours*** and ***memory hours*** as well. The general guideline is that you need 16 ***CPU hours*** and 96 ***memory hours*** per 1 ***GPU hour***. If you need assistance in determining how many hours to request, please submit a help desk ticket to [help@smu.edu](mailto:help@smu.edu) with [HPC] in the subject line.
    ```

8. Enter the number of ***memory hours*** you will need.

9. If you have users on your project, select which users should have access to the allocation.

10. Please read and acknowledge that you will follow the ODSRCI Community Guidelines.

11. Click on <img src="../images/CF/request_change_allocation/submit.png" alt="Submit" height="40">.

12. Wait for your allocation to be approved by HPC Support.

### Change ***Compute*** Allocation

To change a the ***CPU hours***, ***GPU hours***, or ***memory hours*** on a ***Compute*** Allocation,

1. On your project page, select the Allocation you would like to change under ***Information*** in the Allocations panel.

2. Click on <img src="../images/CF/request_change_allocation/request_change.png" alt="Request Change" height="40">.

3. If needed, request an extension to your allocation date **Request End Date Extension** for 30, 60, or 90 days.

    ```{image} ../images/CF/request_change_allocation/extension.png
    :alt: Request End Date Extension
    :height: 100px
    ```

    ```{note}
    When the End Date is approaching, you will be able to renew the project for another cycle. We encourage users to do this rather than extending the current cycle by 30-90 days.
    ```

4. If needed, update your ***CPU hours***, ***GPU hours***, and ***memory hours*** under <img src="../images/CF/request_change_allocation/attributes.png" alt="Allocation Attributes" height="40">.

    ```{note}
    Your _usage_ for ***CPU hours***, ***GPU hours***, and ***memory hours*** will reset to 0, and you will have the new quota you request available to you. For example, if you have 30000 ***CPU hours*** and only need 2000 more hours, you would request 2000 ***CPU hours***, _not_ 32000. This works differently than ***Storage*** Allocations.
    ```

5. Provide a justification for the change in your allocation.

6. Click on <img src="../images/CF/request_change_allocation/submit.png" alt="Submit" height="40"> to submit your change request.

7. Check that your change has been requested on the **Allocation Details** page under **Allocation Change Requests**. It will show as Pending

    ```{image} ../images/CF/request_change_allocation/request_pending.png
    :alt: Allocation Change Request Pending
    :width: 800px
    ```

8. You will recieve an email when your allocation change request is approved.

## ***Storage*** Allocations

A ***Storage*** allocation is a shared directory with a quota on gigabytes (GB) of storage, and number of files. Every HPC user will still have a `$HOME` directory and a `$SCRATCH` directory that does not count towards the quota. Please see the [Purge Policy](https://southernmethodistuniversity.github.io/hpc_docs/policies/policies.html#purge-policy) for details.

### Request ***Storage*** Allocation

```{dropdown} Video Walkthrough
<iframe src="https://smu.app.box.com/embed/s/leu8vk5f416lmcjchc3ojdp379pl922p?sortColumn=date" width="100%" height="550" frameborder="0" allowfullscreen webkitallowfullscreen msallowfullscreen></iframe>
```

1. Click on <img src="../images/CF/request_change_allocation/request_resource.png" alt="Request Resource Allocation" height="40"> in the Allocations box on your project page.

2. Select ***Storage*** as your Resource from the dropwdown.

    ```{image} ../images/CF/request_change_allocation/select_storage.png
    :alt: Storage selected on Resource dropdown
    :width: 800px
    ```

3. Provide a short description to make your allocation easier to identify.

4. Provide what you would like to name the shared folder. If a name is not provided, a generic name will be assigned.

5. Provide a 2-3 sentence justification for the resources you are requesting.

6. Select a Start Date and End Date for your allocation. The limit is 1 year, but can be renewed.

7. Enter the amount of storage you would like in GB.

    ```{note}
    This amount is a storage quota, which means you are capped at the provided GB, but are not guarunteed to get that much.
    ```

8. Enter the number of files you expect to create or use in this allocation.

    ```{admonition} General Guidelines
    :class: tip
    - A conda environment needs about 100,000 files.
    - A safe bet for most people is 500,000 files for a storage allocation.
    ```

9. If you have users on your project, select which users should have access to the shared folder and whether they should have ***Read and Write*** access or ***Read Only*** access. 

    ```{image} ../images/CF/request_change_allocation/permissions.png
    :alt: Permissions dropdown
    :height: 100px
    ```

    ```{note}
    ***Read Only*** means that they will only be able to see file contents, but not change them or create new files in the shared directory. ***Read and Write*** gives them full editing permissions.
    ```

10. Please read and acknowledge that you will follow the ODSRCI Community Guidelines.

11. Click on <img src="../images/CF/request_change_allocation/submit.png" alt="Submit" height="40">.

12. Wait for your allocation to be approved by HPC Support.

### Change ***Storage*** Allocation

To change the storage size or number of files in a ***Storage*** Allocation,

1. On your project page, select the Allocation you would like to change under ***Information*** in the Allocations panel.

2. Click on <img src="../images/CF/request_change_allocation/request_change.png" alt="Request Change" height="40">.

3. If needed, request an extension to your allocation date **Request End Date Extension** for 30, 60, or 90 days.

    ```{image} ../images/CF/request_change_allocation/extension.png
    :alt: Request End Date Extension
    :height: 100px
    ```

    ```{note}
    When the End Date is approaching, you will be able to renew the project for another cycle. We encourage users to do this rather than extending the current cycle by 30-90 days.
    ```

4. If needed, update your storage size and file count under <img src="../images/CF/request_change_allocation/attributes.png" alt="Allocation Attributes" height="40">.

    ```{note}
    Please request the total amount of storage and file count you need. For example, if you previously had 200GB and a 1000 file count and you need to add 100GB and 500 to your file count, you will need to request 300GB and 1500 for your file count.
    ```

5. Provide a justification for the change in your allocation.

6. Click on <img src="../images/CF/request_change_allocation/submit.png" alt="Submit" height="40"> to submit your change request.

7. Check that your change has been requested on the **Allocation Details** page under **Allocation Change Requests**. It will show as Pending

    ```{image} ../images/CF/request_change_allocation/request_pending.png
    :alt: Allocation Change Request Pending
    :width: 800px
    ```

8. You will recieve an email when your allocation change request is approved.