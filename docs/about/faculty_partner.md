# Faculty Partner Nodes

There are several faculty partner nodes that have been purchased by
faculty for priority usage, which operate on the M3 cluster.

## Professor Thomas Hagstrom (Mathematics)

Professor Hagstrom has one node that is available as part of M3. This
node has dual  AMD EPYC 7742 64-Core \"Zen 2\"
processors, 512 GB of memory, and an NVIDIA A100 GPU accelerator with 
40 GB of HBM2 memory, 6912 Cuda cores, and 432 tensor cores. 

This node `amd001`, is currently available only with permision
from Dr. Hagstrom.

## Professor Barbara Minsker (Civil and Environmental Engineering)

Professor Minsker has two nodes that are availabe as part of M3. These
nodes each have dual Intel Xeon Gold 6148 2.40 GHz 20-core \"Skylake\"
processors, 384 GB of memory, dual NVIDIA V100 GPU accelerators, and 2
TB of local RAID scratch space. Each GPU has 5,120 CUDA cores, 640
Tensor cores, and 32 GB CoWoS HBM2 memory. The V100 GPU is based on the
Volta architecture and an extremely high bandwidth (900 GB/s) stacked
memory architecture.

The queue for these nodes, `fp-gpgpu-3`, is generally available to M3
users with the following restrictions.

-   The maximum job duration for users not in Dr. Minsker\'s group is 7 days
-   There is no maximum job duration for users in Dr. Minsker\'s group
    when the `--qos qos_clowder` Slurm flag is used
-   Jobs submitted without the `--qos qos_clowder` flag may be queued
    indefinitely until jobs submitted with the flag finish

## Professor Wei Cai (Mathematics)

Professor Cai has one node that is available as part of M3. This node
has dual Intel Xeon Gold 6150 2.70 GHz 18-core \"Skylake\"
processors, 384 GB of memory, dual NVIDIA V100 GPU accelerators, and 2
TB of local RAID scratch space. Each GPU has 5,120 CUDA cores, 640
Tensor cores, and 32 GB CoWoS HBM2 memory. The V100 GPU is based on the
Volta architecture and an extremely high bandwidth (900 GB/s) stacked
memory architecture.

The queue for these nodes, `fp-gpgpu-4`, is generally available to M3
users with the following restrictions.

-   The maximum job duration for users not in Dr. Cai\'s group is 7
    days
-   Members of Dr. Cai\'s group may run upto 2 weeks
    when the `--qos qos_cai` Slurm flag is used
-   Jobs submitted without the `--qos qos_cai` flag may be preempted

## Assistant Professor Devin Matthews (Chemistry)

Dr. Matthews has one node that is available as part of M3. This node has
dual AMD EPYC 7763 2.45 Ghz 64-Core \"Zen 3\" processors, 512 GB of memory,
and AMD Instinct MI210 GPU with 64 GB of HBM2e memory and 6,656 stream processors.
This node is also equipped with AMD/Xilinx Alveo U55C FPGA.

This node `ga001`, is currently available only with permision
from Dr. Matthews. 