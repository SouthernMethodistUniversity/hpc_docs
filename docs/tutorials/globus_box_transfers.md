# Using Globus to transfer data to/from Box

:::{important}
Please review the [OIT Box service page](https://www.smu.edu/oit/services/box) and [Box FAQ](https://www.smu.edu/oit/services/box/faq).

In particular, note the SMU's contract does not allow the use of Box for "primary data back-up repository or for the storage of data that is not intended for regular access and use."
:::

Data can be transferred from M3's Lustre file systems and Box using the Globus service.

## Logging in to Globus

The first step is to login to __[globus.org](https://www.globus.org/)__. 
On the top left of the page, click on the "LOG IN" button and then select *Southern Methodist University*
in the organizational login menu.

```{image} ../images/globus/organizational_login.png
:alt: Globus organizational login
:width: 400px
```

This will take you to an SMU login page, where you will login using your SMU credentials.

## Using the File Manager

Once logged in, the default page is usually the *File Manager* (if it is not, you can select the *File Manager* at the top of the navigation panel on the left side of the page.)

The SMU HPC storage collection is named `SMU#dtn#M3` and Box is named `SMU#BOX.SMU.EDU`.

```{image} ../images/globus/m3.png
:alt: SMU#dtn#M3 search
:width: 400px
```
```{image} ../images/globus/box.png
:alt: SMU#BOX.SMU.EDU search
:width: 400px
```

The first time you access each of these collections, you will be required to give Globus
permission to access them. To do this, select the your account (it will look like your SMU ID number @smu.edu)

```{image} ../images/globus/identity.png
:alt: select identity to give permission to
:width: 400px
```

The you must agree to give Globus the requested permissions. 
The screenshot below is for M3 access.
The permissions for Box are similar.

```{image} ../images/globus/permissions.png
:alt: agree to give Globus permissions
:width: 400px
```

On one side of the *File Manager* select `SMU#dtn#M3` (M3) and on the other side `SMU#BOX.SMU.EDU` (Box).
Then navigate to the path you want to transfer data between on each service.
Select the files you want to transfer, then click the *Transfer or Sync* link in the middle.
If necessary, navigate to where you want the data transferred to.
Click the start button above the side the data is coming from to start the transfer.

:::{Note}
You do not have to stay on the Globus site while the transfer is happening. It will send an email when completed.
:::

:::{Note}
The transfers can be slow. We typically see between 4-5 MBPS.
:::

:::{Note}
Box has a file size limit of 50GB
:::

## Help

If you encounter issues or would like help getting started, please contact the [Help Desk](mailto:help@smu.edu?subject=[HPC]).