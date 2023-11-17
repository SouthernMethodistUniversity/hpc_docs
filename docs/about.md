# About

SMU's high-performance computing (HPC) clusters, M3 and the NVIDIA DGX
SuperPOD, feature state-of-the-art CPUs, accelerators, and networking
technologies, high memory capacity per node, and advanced interactive
experiences via the Open OnDemand Portal.

The clusters provides a familiar interactive experience for researchers,
which includes the Ubuntu Linux operating system, the SLURM resource
scheduler, and the Lmod environment module system. Additionally,
familiar development tool chains are available including the GCC, Intel,
and NVIDIA compiler suites. Optimized high-level programming environments
such as MATLAB, Python, and R are also installed in addition to the
domain specific software packages that SMU researchers depend on for
their work.

| HPC System           | M1                 | M2         | M2         | SuperPOD     | M3           |
|----------------------|--------------------|------------|------------|--------------| -------------|
| Year                 | 2014               | 2017       | 2019       | 2022         | 2023         |
| Compute Ability      | 104 TFLOPS         | 630 TFLOPS | 870 TFLOPS | 1,644 TFLOPS | 1,077 TFLOPS |
| Number of Nodes      | 1,104              | 349        | 354        | 20           | 181          |
| CPU Cores            | 8,832              | 11,088     | 11,276     | 2,560        | 22,892       |
| Total GPU Cores      | 0                  | 132,608    | 275,968    | 1,392,640    | 122,880      |
| Total Memory         | 29.2 TB            | 116.5 TB   | 120 TB     | 52.5 TB      | 103 TB       |
| Network Bandwidth    | 20 Gb/s            | 100 Gb/s   | 100 Gb/s   | 200 Gb/s     | 200 Gb/s     |
| Work Storage         | None               | None       | 768 TB     | 768 TB       | 3.5 PB       |
| Scratch Space        | 1.4 PB             | 1.4 PB     | 2.8 PB     | 750 TB       | 3.5 PB       |
| Archive Capabilities | No                 | Yes        | Yes        | No           | No           |
| Operating System     | Scientific Linux 6 | CentOS 7   | CentOS 7   | Ubuntu 22.04 | Ubuntu 22.04 |

## ManeFrame III (M3)

### Configuration

| Resource           | Standard-Memory | High-Memory   | GPU                  |
|--------------------|-----------------|---------------|----------------------|
| Nodes              | 170             | 8             | 3                    |
| Processors         | AMD EPYC 7763   | AMD EPYC 7763 | Intel Xeon Gold 6154 |
| Frequency          | 2.45 GHz        | 2.45 GHz      | 3.00 GHz             |
| CPUs/Node          | 2               | 2             | 2                    |
| Cores/Node         | 128             | 128           | 18                   |
| Memory/Node        | 512 GB          | 2 TB          | 756 GB               |
| Local Scratch/Node | None            | 4.3 TB        | None                 |
| Interconnect       | 200 Gb/s        | 200 Gb/s      | 100 Gb/s             |

## NVIDIA DGX SuperPOD (MP)

### News

* [SMU launches powerful new supercomputing research system with NVIDIA](https://www.smu.edu/News/2021/Featured-News/smu-launches-powerful-new-supercomputing-research-system-with-nvidia)
* [$11.5M NVIDIA Collaboration Will Put SMU 'in the Fast Lane for Artificial Intelligence'](https://dallasinnovates.com/11-5m-nvidia-collaboration-will-put-smu-in-the-fast-lane-for-artificial-intelligence/)

### Configuration

| Component              | Summary                                     |
|------------------------|---------------------------------------------|
| Computational Ability  | 1,644 TFLOPS                                |
| Number of Nodes        | 20                                          |
| CPU Cores              | 2,560                                       |
| GPU Accelerator Cores  | 1,392,640                                   |
| Total Memory           | 52.5 TB                                     |
| Interconnect Bandwidth | 10x200 Gb/s Infiniband Connections Per Node |
| Work Storage           | 768 TB (Shared)                             |
| Scratch Storage        | 750 TB (Raw)                                |
| Operating System       | Ubuntu 20.04                                |

| Resource           | DGX Node                    |
|--------------------|-----------------------------|
| Nodes              | 20                          |
| Processors         | AMD EPYC 7742               |
| CPUs/Node          | 2                           |
| Cores/Node         | 128                         |
| Memory/Node        | 2 TB                        |
| GPUs               | NVIDIA A100 Tensor Core GPU |
| GPUs/Node          | 8                           |
| GPU Memory/GPU     | 80 GB                       |
| GPU Interconnect   | NVLink                      |
| Local Scratch/Node | 27 TB                       |
| Network            | 10x200 Gb/s                 |

## Faculty Partner Nodes

### Professor Thomas Hagstrom (Mathematics)

Professor Hagstrom has one node that is available as port of M2. This
node has dual Intel Xeon E5-2680v3 2.50 GHz 12-core \"Sandy Bridge\"
processors, 128 GB of memory, and quad NVIDIA K80 GPU accelerators. Each
GPU has 4,992 CUDA cores and 24 GB of GDDR5 memory.

The queue for these nodes, `fp-gpgpu-2`, is generally available to M2
users.

### Professor Barbara Minsker (Civil and Environmental Engineering)

Professor Minsker has two nodes that are availabe as part of M2. These
nodes each have dual Intel Xeon Gold 6148 2.40 GHz 20-core \"Skylake\"
processors, 384 GB of memory, dual NVIDIA V100 GPU accelerators, and 2
TB of local RAID scratch space. Each GPU has 5,120 CUDA cores, 640
Tensor cores, and 32 GB CoWoS HBM2 memory. The V100 GPU is based on the
Volta architecture and an extremely high bandwidth (900 GB/s) stacked
memory architecture.

The queue for these nodes, `fp-gpgpu-3`, is generally available to M2
users with the following restrictions.

-   The maximum job duration for users not in Dr. Minsker\'s group is 24
    hours
-   There is no maximum job duration for users in Dr. Minsker\'s group
    when the `--qos qos_clowder` Slurm flag is used
-   Jobs submitted without the `--qos qos_clowder` flag may be queued
    indefinitely until jobs submitted with the flag finish

## Acknowledgement

If you wish to acknowledge the use of SMU HPC resources in any publication we
suggest the following: \"Computational resources for this research were
provided by SMU\'s Center for Research Computing.\"

