# Systems

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

## NVIDIA DGX SuperPOD (SuperPOD)

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
| Project Storage        | 3.5 PB (Shared with M3)                     |
| Scratch Storage        | 750 TB (Raw)                                |
| Operating System       | Ubuntu 22.04                                |

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

## Acknowledgement

We request that all work supported by SMU HPC resources make an appropriate acknowledgement.
We suggest the following: 

\"Computational resources for this research were
provided by SMU\'s O\'Donnell Data Science and Research Computing Institute.\"