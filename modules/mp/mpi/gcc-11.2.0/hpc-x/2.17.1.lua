whatis("NVIDIA HPC-X toolkit")
family("mpi")
extensions("hcoll/4.8.3223, ucx/1.16.0, ucc/1.3.1, openmpi/4.1.7a1, sharp/3.5.1-rc1")

load("cuda/12.4.1-nsrijq7")

local HPCX_HOME="/hpc/mp/apps/hpcx/hpcx-v2.17.1-gcc-inbox-ubuntu22.04-cuda12-x86_64"
local OMPI_DIR="hpcx-ompi-gcc-11.2.0"
setenv("UCX_NET_DEVICES","mlx5_0:1,mlx5_1:1,mlx5_2:1,mlx5_3:1,mlx5_6:1,mlx5_7:1,mlx5_8:1,mlx5_9:1")

setenv("HPCX_DIR",HPCX_HOME)
setenv("HPCX_HOME",HPCX_HOME)
setenv("HPCX_UCX_DIR",pathJoin(HPCX_HOME,"/ucx/mt"))
setenv("HPCX_UCC_DIR",pathJoin(HPCX_HOME,"/ucc"))
setenv("HPCX_SHARP_DIR",pathJoin(HPCX_HOME,"/sharp"))
setenv("HPCX_HCOLL_DIR",pathJoin(HPCX_HOME,"/hcoll"))
setenv("HPCX_NCCL_RDMA_SHARP_PLUGIN_DIR",pathJoin(HPCX_HOME,"/nccl_rdma_sharp_plugin"))
setenv("HPCX_CLUSTERKIT_DIR",pathJoin(HPCX_HOME,"/clusterkit"))
setenv("HPCX_MPI_DIR",pathJoin(HPCX_HOME,OMPI_DIR))
setenv("HPCX_OSHMEM_DIR",pathJoin(HPCX_HOME,OMPI_DIR))
setenv("HPCX_IPM_DIR",pathJoin(HPCX_HOME,OMPI_DIR,"/tests/ipm-2.0.6"))
setenv("HPCX_IPM_LIB",pathJoin(HPCX_HOME,OMPI_DIR,"/tests/ipm-2.0.6/lib/libipm.so"))
setenv("HPCX_MPI_TESTS_DIR",pathJoin(HPCX_HOME,OMPI_DIR,"/tests"))
setenv("HPCX_OSU_DIR",pathJoin(HPCX_HOME,OMPI_DIR,"/tests/osu-micro-benchmarks-5.8"))
setenv("HPCX_OSU_CUDA_DIR",pathJoin(HPCX_HOME,OMPI_DIR,"/tests/osu-micro-benchmarks-5.8-cuda"))
prepend_path("PATH",pathJoin(HPCX_HOME,"/ucx/mt/bin"))
prepend_path("PATH",pathJoin(HPCX_HOME,"/ucc/bin"))
prepend_path("PATH",pathJoin(HPCX_HOME,"/hcoll/bin"))
prepend_path("PATH",pathJoin(HPCX_HOME,"/sharp/bin"))
prepend_path("PATH",pathJoin(HPCX_HOME,OMPI_DIR,"/tests/imb"))
prepend_path("PATH",pathJoin(HPCX_HOME,"/clusterkit/bin"))
prepend_path("LD_LIBRARY_PATH",pathJoin(HPCX_HOME,"/ucx/mt/lib"))
prepend_path("LD_LIBRARY_PATH",pathJoin(HPCX_HOME,"/ucx/mt/lib/ucx"))
prepend_path("LD_LIBRARY_PATH",pathJoin(HPCX_HOME,"/ucc/lib"))
prepend_path("LD_LIBRARY_PATH",pathJoin(HPCX_HOME,"/ucc/lib/ucc"))
prepend_path("LD_LIBRARY_PATH",pathJoin(HPCX_HOME,"/hcoll/lib"))
prepend_path("LD_LIBRARY_PATH",pathJoin(HPCX_HOME,"/sharp/lib"))
prepend_path("LD_LIBRARY_PATH",pathJoin(HPCX_HOME,"/nccl_rdma_sharp_plugin/lib"))
prepend_path("LIBRARY_PATH",pathJoin(HPCX_HOME,"/ucx/mt/lib"))
prepend_path("LIBRARY_PATH",pathJoin(HPCX_HOME,"/ucc/lib"))
prepend_path("LIBRARY_PATH",pathJoin(HPCX_HOME,"/hcoll/lib"))
prepend_path("LIBRARY_PATH",pathJoin(HPCX_HOME,"/sharp/lib"))
prepend_path("LIBRARY_PATH",pathJoin(HPCX_HOME,"/nccl_rdma_sharp_plugin/lib"))
prepend_path("CPATH",pathJoin(HPCX_HOME,"/hcoll/include"))
prepend_path("CPATH",pathJoin(HPCX_HOME,"/sharp/include"))
prepend_path("CPATH",pathJoin(HPCX_HOME,"/ucx/mt/include"))
prepend_path("CPATH",pathJoin(HPCX_HOME,"/ucc/include"))
prepend_path("CPATH",pathJoin(HPCX_HOME,OMPI_DIR,"/include"))
prepend_path("PKG_CONFIG_PATH",pathJoin(HPCX_HOME,"/hcoll/lib/pkgconfig"))
prepend_path("PKG_CONFIG_PATH",pathJoin(HPCX_HOME,"/sharp/lib/pkgconfig"))
prepend_path("PKG_CONFIG_PATH",pathJoin(HPCX_HOME,"/ucx/mt/lib/pkgconfig"))
prepend_path("PKG_CONFIG_PATH",pathJoin(HPCX_HOME,"/ompi/lib/pkgconfig"))
prepend_path("MANPATH",pathJoin(HPCX_HOME,OMPI_DIR,"/share/man"))
setenv("OPAL_PREFIX",pathJoin(HPCX_HOME,OMPI_DIR))
setenv("PMIX_INSTALL_PREFIX",pathJoin(HPCX_HOME,OMPI_DIR))
setenv("OMPI_HOME",pathJoin(HPCX_HOME,OMPI_DIR))
setenv("MPI_HOME",pathJoin(HPCX_HOME,OMPI_DIR))
setenv("OSHMEM_HOME",pathJoin(HPCX_HOME,OMPI_DIR))
setenv("SHMEM_HOME",pathJoin(HPCX_HOME,OMPI_DIR))
prepend_path("PATH",pathJoin(HPCX_HOME,OMPI_DIR,"/bin"))
prepend_path("LD_LIBRARY_PATH",pathJoin(HPCX_HOME,OMPI_DIR,"/lib"))
prepend_path("LIBRARY_PATH",pathJoin(HPCX_HOME,OMPI_DIR,"/lib"))
