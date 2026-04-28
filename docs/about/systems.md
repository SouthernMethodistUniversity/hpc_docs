# Systems

SMU's high-performance computing (HPC) clusters, M3 and the NVIDIA DGX
SuperPOD, feature state-of-the-art CPUs, accelerators, and networking
technologies, high memory capacity per node, and advanced interactive
experiences via the Open OnDemand Portal.

The clusters provide a familiar interactive experience for researchers,
including the Ubuntu Linux operating system, the SLURM resource
scheduler, and the Lmod environment module system. Additionally,
familiar development toolchains are available including the GCC, Intel,
and NVIDIA compiler suites. Optimized high-level programming environments
such as MATLAB, Python, and R are available, along with domain-specific software packages.

## ManeFrame III (M3)
ManeFrame III is SMU's primary CPU-based HPC cluster, supporting a wide range of general-purpose workloads. 

### System Configuration

| Resource           | Standard Memory Nodes  | High Memory Nodes  | GPU Nodes            |
|--------------------|-----------------|---------------|----------------------|
| Nodes              | 170             | 8             | 3                    |
| Processor Model         | AMD EPYC 7763   | AMD EPYC 7763 | Intel Xeon Gold 6154 |
| CPU Frequency          | 2.45 GHz        | 2.45 GHz      | 3.00 GHz             |
| CPUs per Node          | 2               | 2             | 2                    |
| Cores per Node         | 128             | 128           | 18                   |
| Memory per Node        | 512 GB          | 2 TB          | 756 GB               |
| Local Scratch per Node | None            | 4.3 TB        | None                 |
| Interconnect Bandwidth    | 200 Gb/s        | 200 Gb/s      | 100 Gb/s             |

## NVIDIA DGX SuperPOD (SuperPOD)
The NVIDIA DGX SuperPOD is SMU's GPU-accelerated system designed for large-scale AI and high-performance workloads. 

### Related Announcements 

* SMU launches a new supercomputing research system with NVIDIA (https://www.smu.edu/News/2021/Featured-News/smu-launches-powerful-new-supercomputing-research-system-with-nvidia)
* $11.5M NVIDIA collaboration advances artificial intelligence research (https://dallasinnovates.com/11-5m-nvidia-collaboration-will-put-smu-in-the-fast-lane-for-artificial-intelligence/)

### Configuration

| Component              | Summary                                     |
|------------------------|---------------------------------------------|
| Peak Computational Performance   | 1,644 TFLOPS                                |
| Number of Nodes        | 20                                          |
| CPU Cores              | 2,560                                       |
| Total GPU CUDA Cores | 1,392,640                                   |
| Total Memory           | 52.5 TB                                     |
| Interconnect Bandwidth | 10x200 Gb/s Infiniband connections Per Node |
| Project Storage        | 3.5 PB (Shared with M3)                     |
| Scratch Storage        | 750 TB (raw capacity)                                |
| Operating System       | Ubuntu 22.04                                |

Detailed DGX Node specifications are provided below.

| Resource           | DGX Node                    |
|--------------------|-----------------------------|
| Nodes              | 20                          |
| Processors         | AMD EPYC 7742               |
| CPUs per Node          | 2                           |
| Cores per Node         | 128                         |
| Memory per Node        | 2 TB                        |
| GPUs               | NVIDIA A100 Tensor Core GPU |
| GPUs per Node          | 8                           |
| GPU Memory per GPU     | 80 GB                       |
| GPU Interconnect   | NVLink                      |
| Local Scratch per Node | 27 TB                       |
| Network            | 10x200 Gb/s                 |

## Acknowledgement

All publications and research supported by SMU HPC resources should include an acknowledgement.

Please use the following ackowledgment statement: 

"Computational resources for this research were
provided by SMU\'s O\'Donnell Data Science and Research Computing Institute."

Proper acknowledgment helps demonstrate the impact of SMU's computational resources and supports continued investment in research infrastructure. 
