---
title: Quick Start
---

# Quick Start

This guide walks you through accessing the SMU **M3 Cluster** and running your first job using either **SSH** or the **OnDemand Portal**.

---

## Accessing the M3 Cluster via SSH

> Remember to replace example terms (like `username` and `slurm_account_name`) with your own credentials.

### 1. Open a Terminal

- **macOS/Linux:** Open **Terminal**
- **Windows 11+:** Open **PowerShell**

### 2. Connect to M3

```bash
ssh username@m3.smu.edu
```

Enter your SMU password (input will not show on screen)

Authenticate with DUO by pressing 1 for your associated device

### 3. Create a Job Script

Create a new job file using Nano:

```bash
nano my_first_job.sbatch
```

Paste the following contents into the editor:

```bash
#!/bin/bash
#SBATCH -A slurm_account_name
#SBATCH -J my_first_job
#SBATCH -o my_first_job_%j.out
#SBATCH -e my_first_job_%j.err
#SBATCH -p dev
#SBATCH -t 0-00:30:00
#SBATCH --mem=4G
#SBATCH -c 1

# Wait for 100 seconds so you can check the queue using 'squeue -u $USER'
sleep 100
 
# Print a simple message
echo "Hello, World!"
```

Save and exit Nano:

```
Ctrl + X  →  Y  →  Enter
```

### 4. Submit and Monitor Your Job

Submit your job:

```bash
sbatch my_first_job.sbatch
```

Check the job status:

``` bash
squeue -u $USER
After completion, view output and error files:
```

Check the outputs:

``` bash
cat my_first_job_<jobid>.out
cat my_first_job_<jobid>.err
```

## Accessing the M3 Cluster via OnDemand

Connect to PerunaNet or the SMU campus network.

1. Open a browser and visit:
https://hpc.m3.smu.edu/pun/sys/dashboard/

2. Log in using your SMU credentials.

3. From the top menu, select My Interactive Sessions.

4. On the left sidebar, choose an interactive app (e.g., RStudio, Jupyter, etc.).

5. Select your SLURM account and job settings (defaults are fine for testing).

6. Click Launch and wait for the job to start in the queue.

7. Once ready, click Launch again to open the session in your browser.

When finished, delete the job from My Interactive Sessions to free resources.

