---
title: Quick Start
---

# Quick Start

This guide walks you through accessing the SMU **M3 Cluster** and running your first job using either **SSH** or the **OnDemand Portal**.

---

## Accessing the M3 Cluster via SSH

```{warning}
[Duo](https://www.smu.edu/oit/services/duo) is still required to access HPC resources via SSH. If you are not enrolled, please enroll here: [https://www.smu.edu/oit/services/duo](https://www.smu.edu/oit/services/duo).
```

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

Create a new job file using nano:

```bash
nano my_first_job.sbatch
```

Paste the following contents into the editor:

```bash
#!/bin/bash                       
#SBATCH -A slurm_account_name        # Replace with your faculty /
#SBATCH -J my_first_job              # Name of the job in the queue
#SBATCH -o my_first_job_%j.out       # Standard output file (% j expands)
#SBATCH -e my_first_job_%j.err       # Error file
#SBATCH -p dev                       # Partition (queue) to use
#SBATCH -t 0-00:30:00                # Time limit (DD-HH: MM: SS)
#SBATCH --mem=4G                     # Memory requested
#SBATCH -c 1                         # Number of CPU cores

# Your commands go below this line
echo "Job started at  $ (date)"
sleep 100
echo "Hello, World from Node: $ (hostname)"
```

Save and exit nano:

```
Ctrl + X  →  Y  →  Enter
```

### 4. Submit and Monitor Your Job

Submit your job:

```bash
sbatch my_first_job.sbatch
```

You should see a message like: 

```bash
Submitted batch job 123456
```

Check the job status:

``` bash
squeue --me
```

Check the outputs:

``` bash
cat my_first_job_<jobid>.out
cat my_first_job_<jobid>.err
```

## Accessing the M3 Cluster via OnDemand

Connect to PerunaNet or the SMU campus network.

1. Open a browser and visit:
https://hpc.smu.edu

2. Log in using your SMU credentials.

3. From the top menu, select My Interactive Sessions.

4. On the left sidebar, choose an interactive app (e.g., RStudio, Jupyter, etc.).

5. Configure your session: Enter your SLURM account name, Select dev (best for testing), Number of Hours: 1

6. Launch: Click the blue Launch button. The card will turn from "Queued" to "Starting" and finally to "Running."  

7. Click Launch and wait for the job to start in the queue.

8. Once ready, click Launch again to open the session in your browser.

When finished, delete the job from My Interactive Sessions to free resources.

