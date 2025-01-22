# Curated Python Environments

Multiple Python environments are available to be used out of the box with system level versions of python packages. We recommend using these environments for classes and new HPC users. While all environments should work out of the box, users can install additional packages using `pip`, which will install in your $HOME directory. For example:

```{bash}
pip install pyfiglet
```

If you will need a lot of additional packages that are not in the curated environments, we recommend that users build their own conda/mamba environments. See documentation on how to install conda/mamba environments [here](/examples/conda/README.md).

## Data Science

The Data Science Python environment has a lot of the common packages used for modern data science applications, including `numpy`, `pandas`, and `matplotlib`. This environment should be suitable for a majority of HPC users.

### Use Environment

To use the Data Science Python environment in job submissions:

```{bash}
module purge
module load python/3.11.11/data-science
```

To use the Data Science Python environment in a JupterLab session on the web portal:

### Installed Packages

## Geospatial

The Geospatial Python Environment includes packages for GIS developers working in python, including `geopandas`.

### Use Environment

To use the Geospatial Python environment in job submissions:

```{bash}
module purge
python/3.11.11/geospatial
```

To use the Geospatial Python environment in a JupterLab session on the web portal:

### Installed Packages

## Biology

The Biology Python environment is adequate for most biology applications.

### Use Environment

To use the Biology Python environment in job submissions:

```{bash}
module purge
module load python/3.11.11/biology
```

To use the Biology Python environment in a JupterLab session on the web portal:

### Installed Packages

## Tensorflow

The Tensorflow Python environment contains all the packages needed for a ML/AI workflow using `tensorflow`, which includes packages needed for GPU utilization on the SuperPOD.

### Use Environment

To use the Tensorflow Python environment in job submissions:

```{bash}
module purge
module load python/3.11.11/tensorflow
```

To use the Tensorflow Python environment in a JupterLab session on the web portal:

### Installed Packages

## Pytorch

The Pytorch Python environment contains all the packages needed for a ML/AI workflow using `torch`, which includes packages needed for GPU utilization on the SuperPOD.

### Use Environment

To use the Pytorch Python environment in job submissions:

```{bash}
module purge
module load python/3.11.11/pytorch
```

To use the Pytorch Python environment in a JupterLab session on the web portal:

### Installed Packages