# HPC_Application_Containers
Container definitions and objects in use on SMU HPC clusters

# R / Rstudio

The R and RStutio containers are converted from [Rocker containers](https://github.com/rocker-org/rocker-versioned2). 
In particular, we are pulling the `ml-verse` variants of the containers because the contain many of the popular packages along with Cuda libraries.
They are built like the following using Singularity:

```
singularity build shiny-verse+rstudio_4.2.0.sif docker://rocker/ml-verse:4.2.0
```
