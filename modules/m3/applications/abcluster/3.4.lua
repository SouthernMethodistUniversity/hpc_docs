whatis("ABCluster")

load("gcc/13.4.0", "boost/1.90.0-uav42vk")
append_path("PATH", "/hpc/m3/apps/abcluster/abcluster-source-env-3.4/abcluster-Release")
append_path("LD_LIBRARY_PATH", "/hpc/m3/apps/abcluster/abcluster-source-env-3.4/abcluster-Release")

help([[Name: ABCluster
Version: 3.4
Website: https://zhjun-sci.com/abcluster.html

ABCluster is a powerful and popular program for the global optimization of chemical cluster structures using the artificial bee colony algorithm 
]])
