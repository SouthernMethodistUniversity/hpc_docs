# Getting Started in ColdFront as an Instructor

These instructions will help you get access to HPC resources for your class.
If you are the instructor of record in my.smu, much of this process will be easy and automated for you.
If you are not an instructor of record for a course but would like to set up a course (e.g. workshop or bootcamp), 
please reach out to [help@smu.edu](mailto:help%40smu.edu?subject=%5BHPC%5D) and include [HPC] in the subject line.

## Setting up your class

    ```{image} ../images/CF/quick_start/add_class.png
    :alt: add a class button
    :width: 400px
    ```

1. Login to ColdFront via SSO with your SMU ID and Password 
2. Select Add a class 
3. Select your course from the drop down menu
4. Select which sections you would like to have access to HPC resources
5. Mark which additional options you need
6. Select Save once complete.

Once a class is created you will have options to Add additional users and request additional allocations.

## To add Students and Other Users

For classes, the management of students is synched hourly with class enrollment records starting a week before the semester starts.
Once in the , students that add or drop will be added or removed from your class and allocations accordingly.

    ```{note}
    All students will appear 7 days before the semester begins.
    ```

If you wish to add a user who is not enrolled to your class (e.g. a co-instructor), follow the steps below.

    ```{note}
    This is not especially common. Do not add students that will be enrolled in the course as this could disrupt their file permissions.
    ```

1. Once your class is created, select Add Users within the Users section of your class

    ```{image} ../images/CF/quick_start/add_users.png
    :alt: add users
    :width: 400px
    ```

3. If you are searching by “Exact Username Only” search for the user via SMU email alias

    ```{note}
    If you are adding multiple users, you can list them all in the Search String box
    ```

4. If you are searching by “All Fields” you can enter last name or SMU email alias

5. Once you’ve found and selected the user(s), select the role the user should have

    ```{image} ../images/CF/quick_start/user_role.png
    :alt: user role
    :width: 100px
    ```

6. Then Add Selected Users to Project
7. Once complete you will see all users requested under the Users section

## In Class

Once you are ready for your students to use the resources, have them go to [hpcaccess.smu.edu](hpcaccess.smu.edu) and log in to ColdFront.
They will see your class and associated allocations on their dashboard. They will see a button for **Pending EULA** next to each allocation.
They will need to accept the EULA for each allocation in order to get access the those resources.

    ```{note}
    Once a student is in a course and accepts the EULA, they will be granted an HPC account.
    In most cases this process is instantenous, however if you have a large number of files in a storage allocation for a class, this could take several minutes.
    ```
If you are using the Open OnDemand portal [hpc.smu.edu](hpc.smu.edu) for your course, students will be able to click on the link in the top menu bar to go directly to the M3 Portal.

If you are using `srun` commands or `sbatch` scripts, your students will need to add the following to their commands/scripts in order to utilize the resources.

`#SBATCH -A slurm_account_name`

or

`srun -A slurm_account_name …`

The `slurm_account` can be found in the Information field under Allocations.

    ```{image} ../images/CF/quick_start/resource_table.png
    :alt: resource table
    :width: 800px
    ```

## To Request Additional Resource Allocations

All classes are granted a default compute allocation consisting of ***Core Usage (Hours)*** and ***Memory Usage (Hours)***.
Depending on the options chosen at the creation of the project, this may contain ***Accelerator Usage (Hours)*** or a second allocation for Storage.
The Storage allocation is Read-Only for students by default.

If you find your class needing additional resources, you can request additional allocations for either Compute or Storage, by following the instructions below.

    ```{image} ../images/CF/quick_start/request_resource_allocation.png
    :alt: request resource allocation
    :width: 200px
    ```

1.	Next to Allocations, Select the **+Request Resource Allocation button**
2.	Complete all required fields
3.	Select the users you’d like to add to this allocation
4.	Select Submit
5.	Once complete you will see your status request as **Pending Review** under Allocations


## To view your current usage

1.	Under Allocations select the folder icon
2.	You will see your Allocation details, EULA Agreements, and Usage by Hours


## Concluding the Semester

At the end of the semester, your class will be Archived.
Once you class is successfully archived, you will not be able to make any changes but will still be able to view some details at any time

## To view Archive Projects

1.	After logging into ColdFront, select Projects> Projects
2.	Top right of your page, you will see View Archived Projects

    ```{image} ../images/CF/quick_start/view_archived.png
    :alt: view archived
    :width: 200px
    ```
