# HPC Portal

HPC OnDemand provides an integrated, single access point for SMU HPC resources.

## Accessing the Portal

Access to the HPC OnDemand web portal requires an existing SMU HPC account,
which can be requested as documented in
{doc}`accounts`.

1.  Go to [hpc.m3.smu.edu](https://hpc.m3.smu.edu/).
2.  Sign in using your SMU ID and SMU password

## Interactive Apps

### Remote Desktop {#portal_remote_desktop}

1.  Select "Remote Desktop" from the "Interactive Apps" drop-down
    menu.
2.  Select options required for your remote desktop instance. These
    options are the same as those requested via a standard Slurm script.
3.  Select "Launch"
4.  Wait for the job to start. When the job starts a new button
    "Launch noVNC in New Tab" button will appear.
5.  Select "Launch noVNC in New Tab"
6.  Graphical applications can be run via the Terminal, e.g.
    `module load comsol && comsol &`.
7.  When finished using the remote desktop instance, return to the "My
    Interactive Sessions" tab in your browser and select "Delete" and
    "Confirm", when prompted, to cancel the job.

```{=html}
<iframe
src="https://smu.hosted.panopto.com/Panopto/Pages/Embed.aspx?id=72acf55b-f2b7-4626-a953-ab58015d1d64&autoplay=false&offerviewer=false&showtitle=true&showbrand=false&start=0&interactivity=all"
width=600 height=338 style="border: 1px solid #464646;" allowfullscreen allow="autoplay">
</iframe>
```
### JupyterLab

1.  Select "JupyterLab" from the "Interactive Apps" drop-down menu.
2.  Select options required for your remote desktop instance. These
    options are similar to those requested via a standard Slurm script.
3.  Select "Launch"
4.  Wait for the job to start. When the job starts a new button
    "Connect to JupyterLab" button will appear.
5.  Select "Connect to JupyterLab"
6.  The Jupyter Notebook graphical interface will be presented and
    running on the resources requested.
7.  When finished using the JupyterLab instance, return to the "My
    Interactive Sessions" tab in your browser and select "Delete" and
    "Confirm", when prompted, to cancel the job.

### RStudio Server

1.  Select "RStudio Server" from the "Interactive Apps" drop-down
    menu.
2.  Select options required for your remote desktop instance. These
    options are the same as those requested via a standard Slurm script.
3.  Select "Launch"
4.  Wait for the job to start. When the job starts a new button
    "Connect to RStudio Server" button will appear.
5.  Select "Connect to RStudio Server"
6.  The RStudio graphical interface will be presented and running on the
    resources requested.
7.  When finished using the RStudio Server instance, return to the "My
    Interactive Sessions" tab in your browser and select "Delete" and
    "Confirm", when prompted, to cancel the job.

## Shell Access

1.  Select "M3 Shell Access" from the "Clusters" drop-down
    menu. Note that this shell access does not provide access to
    graphical applications. If needed, please use a
    `"Remote Desktop" <portal_remote_desktop>`{.interpreted-text
    role="ref"} instance.
2.  When finished using the shell, type `exit` and close the browser
    tab.

## Monitoring Jobs

1.  "Active Jobs" from the "Jobs" drop-down menu.

## File Access

1.  "Home Directory" from the "Files" drop-down menu.

-   You can navigate to specific directories by clicking the directories
    shown.
-   You can go to specific directories using the "Go To..." button.
-   You can upload files simply by dragging them to the window or by
    selecting the "Upload" button.
-   You can download files and directories by selecting them and then
    selecting the "Download" button.

