SMU’s high performance computing (HPC) cluster, ManeFrame II (M2), features
state-of-the-art CPUs, accelerators, and networking technologies, high memory
capacity per node, and advanced interactive GPU-accelerated remote desktop
experiences.

The cluster provides a familiar interactive experience for researchers, which
includes the CentOS 7 operating system, the SLURM resource scheduler, and the
Lmod environment module system. Additionally, familiar development tool chains
are available including the GCC, Intel, and PGI compiler suites. Optimized
high-level programming environments such as MATLAB, Python, and R are also
installed in addition to the domain specific software packages that SMU
researchers depend on for their work.

+-----------------------------+-------------------------+-----------------------+---------------------+-----------------------------------+
|                             | ManeFrame I (*retired*) | ManeFrame II (2017)   | ManeFrame II (2019) | NVIDIA DGX SuperPOD (Coming 2022) |
+=============================+=========================+=======================+=====================+===================================+
| Computational Ability       | 104 TFLOPS              | 630 TFLOPS            | 870 TFLOPS          | 1,644 TFLOPS                      |
+-----------------------------+-------------------------+-----------------------+---------------------+-----------------------------------+
| Number of Nodes             | 1,104                   | 349                   | 354                 | 20                                |
+-----------------------------+-------------------------+-----------------------+---------------------+-----------------------------------+
| CPU Cores (AVX2)            | 8,832                   | 11,088                | 11,276              | 2,560                             |
+-----------------------------+-------------------------+-----------------------+---------------------+-----------------------------------+
| Total Accelerator Cores     | 0                       | 132,608               | 275,968             | 1,392,640                         |
+-----------------------------+-------------------------+-----------------------+---------------------+-----------------------------------+
| Total Memory                | 29.2 TB (29,856 GB)     | 116.5 TB (119,336 GB) | 120 TB (122,880 GB) | 52.5 TB (53,760 GB)               |
+-----------------------------+-------------------------+-----------------------+---------------------+-----------------------------------+
| Node Interconnect Bandwidth | 20 Gb/s                 | 100 Gb/s              | 100 Gb/s            | 200 Gb/s                          |
+-----------------------------+-------------------------+-----------------------+---------------------+-----------------------------------+
| Work Storage                | None                    | None                  | 768 TB (Shared)     | 768 TB (Shared)                   |
+-----------------------------+-------------------------+-----------------------+---------------------+-----------------------------------+
| Scratch Space               | 1.4 PB (1,229 TB)       | 1.4 PB (1,434 TB)     | 2.8 PB (2,867 TB)   | 750 TB (Raw)                      |
+-----------------------------+-------------------------+-----------------------+---------------------+-----------------------------------+
| Archive Capabilities        | No                      | Yes                   | Yes                 | No                                |
+-----------------------------+-------------------------+-----------------------+---------------------+-----------------------------------+
| Operating System            | Scientific Linux 6      | CentOS 7              | CentOS 7            | Ubuntu 20.04                      |
+-----------------------------+-------------------------+-----------------------+---------------------+-----------------------------------+

.. _standard_nodes:

Standard-, Medium-, and High- Memory Compute Nodes
==================================================

Each of the 176 standard compute nodes has 36 cores, 256 GB of memory, and 100
Gb/s networking. Specifically, these nodes contain dual Intel Xeon E5-2695v4
2.1 GHz 18-core “Broadwell” processors with 45 MB of cache each and 256 GB of
DDR4-2400 memory. This translates to efficient execution per processor cycle
and vectorization via the second-generation Advanced Vector Extensions (AVX2).
In addition, there are 35 medium- and five high-memory compute nodes which have
the same processors, but feature 768 GB and 1,536 GB (1.5 TB) of DDR4-2400
memory respectively and ManeFrame I’s four 768 GB and six 1,536 GB (1.5 TB)
nodes are also part of ManeFrame II.

.. _p100_nodes:

Accelerator Nodes with NVIDIA GPUs
==================================

M2 contains 36 accelerator nodes with NVIDIA GPUs are configured with dual
Intel Xeon E5-2695v4 2.1 GHz 18-core “Broadwell” processors, 256 GB of
DDR4-2400 memory, and one NVIDIA P100 GPU accelerator. Each NVIDIA P100 GPU has
3,584 CUDA cores and 16 GB CoWoS HBM2 memory. The P100 GPU is the based on the
Pascal architecture and a high bandwidth (732 GB/s) stacked memory
architecture. In the summer of 2019, three additional nodes were added with
eight NVIDIA Tesla V100 GPUs each. Each GPU has 32 GB of CoWoS HBM2 memory,
5,120 NVIDIA CUDA cores, and 640 NVIDIA Tensor cores. In addition, M2 has one
ever-broadening set of drop-in replacement libraries and ever easier to
implement CUDA-based programming environments, make GPU-based acceleration
significantly more approachable for many computationally intensive
applications.

.. _knl_nodes:

Many-Core Nodes with Intel Xeon Phi Processors
==============================================

The 36 many-core nodes are configured with Intel Xeon Phi 7230 (also
known as Knights Landing or KNL) processors and 385 GB of DDR4-2400
memory. Each Xeon Phi has 64 1.30 GHz cores and 16 GB of high bandwidth
(400 GB/s) stacked memory. KNL processors are based on the Intel’s
“Silvermont” Atom processor cores and have hardware-based support for up
to four concurrent threads. A principal benefit of the KNL processors is
that they are based on and binary compatible with x86 architectures and
therefore do not require specialized programming languages or
directives/pragmas.

Virtual Desktop Nodes
=====================

The five virtual desktop nodes will allow researchers remote desktop
access to high-performance compute capability. These nodes can be used
for applications that have demanding remote visualization and/or
rendering requirements. In addition, these virtual desktops can be
configured as either Linux or Windows for a handful of compatible
applications. Each node has dual Intel Xeon E5-2695v4 2.1 GHz 18-core
“Broadwell” processors, 256 GB of DDR4-2400 memory, and one NVIDIA
Quadro M5000 GPU.

High-Performance Network
========================

The cluster provides high-speed and low-latency EDR InfiniBand
networking. Every node is equipped with a Mellanox ConnectX-5 InfiniBand
adaptor and all nodes are connected via Mellanox Switch-IB 2 switches.
The InfiniBand network provides 100 Gb/s and less than 600 nanosecond
latency. Additionally, the combination of ConnectX-5 and Switch-IB 2
provides network acceleration for applications by off-loading some MPI
calls, thereby reducing the load on the processors, freeing them to work
on other computations.

High-Performance and Archival Storage
=====================================

The cluster has four storage systems. The first storage system is an NFS based
storage providing space for home directories, applications, libraries, and
compilers, etc. This storage system provides 11.4 TB of sold state drive based
usable space and 38.4 TB of usable 7200 RPM SAS storage space. This storage
space will have an automatic retention of 30 days’ worth of changes. The second
storage system provides the high-performance Lustre file system for calculation
scratch space. This storage system provides 2.8 PB of usable space with a write
performance of 56.4 GB/s and read performance of 70.8 GB/s, when used in
parallel. The third storage system is 110 TB of usable disk based archive space
that includes off-site backup for disaster recovery. The fourth storage system,
"work", provides 8 TB of storage per user.

Faculty Partner Nodes
=====================

.. include:: common/faculty_partnership_purpose.rst

See :ref:`Programs and Policies <programs_and_policies>` for more information.

.. _fp_hagstrom:

*Professor Thomas Hagstrom (Mathematics)*
-----------------------------------------

Professor Hagstrom has one node that is available as port of M2. This node has
dual Intel Xeon E5-2680v3 2.50 GHz 12-core "Sandy Bridge" processors, 128 GB of
memory, and quad NVIDIA K80 GPU accelerators. Each GPU has 4,992 CUDA cores and
24 GB of GDDR5 memory.

The queue for these nodes, ``fp-gpgpu-2``, is generally available to M2 users.

.. _fp_minsker:

*Professor Barbara Minsker (Civil and Environmental Engineering)*
-----------------------------------------------------------------

Professor Minsker has two nodes that are availabe as part of M2. These nodes
each have dual Intel Xeon Gold 6148 2.40 GHz 20-core "Skylake" processors, 384
GB of memory, dual NVIDIA V100 GPU accelerators, and 2 TB of local RAID scratch
space. Each GPU has 5,120 CUDA cores, 640 Tensor cores, and 32 GB CoWoS HBM2
memory. The V100 GPU is based on the Volta architecture and an extremely high
bandwidth (900 GB/s) stacked memory architecture.

The queue for these nodes, ``fp-gpgpu-3``, is generally available to M2 users
with the following restrictions.

* The maximum job duration for users not in Dr. Minsker's group is 24 hours
* There is no maximum job duration for users in Dr. Minsker's group when the
  ``--qos qos_clowder`` Slurm flag is used
* Jobs submitted without the ``--qos qos_clowder`` flag may be queued
  indefinitely until jobs submitted with the flag finish

