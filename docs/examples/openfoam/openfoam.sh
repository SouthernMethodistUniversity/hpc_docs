module purge
export HPCX_HOME=/hpc/applications/hpc-x/hpcx-v2.0.0-gcc-MLNX_OFED_LINUX-4.2-1.0.0.0-redhat7.3-x86_64
module use $HPCX_HOME/modulefiles
module load gcc-4.8.5
module load hpcx scotch/6.0.4-ztlbfxi qt/5.9.1-bxmsbfc cmake/3.8.1-ncxngnb
source /hpc/applications/openfoam/OpenFOAM-5.0/etc/bashrc

