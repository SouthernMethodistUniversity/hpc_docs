# rocker_ml_cuda

GPU-enabled RStudio container: `rocker/ml` plus CUDA PyTorch (used from R
through reticulate), `tabpfn`, and tidymodels packages. Currently in testing
for the OOD RStudio app.

## Pins

- **Base image:** `rocker/ml` is pinned by digest in `rocker_ml_cuda.def`
  (it was `py3.14` / `latest` as of 2026-10-04). `rocker/ml` no longer
  publishes R version tags, so a tag alone would change under us on rebuild.
- **PyTorch:** `torch==2.14.0` from the `cu126` index. This is the last
  release with a wheel for Volta (V100) GPUs, so don't upgrade it while
  V100s are in use.
- **Driver:** tested on nodes with NVIDIA driver 525.147.05 (CUDA 12.0).

## Build

On a cluster node with apptainer (needs network access):

```
./build_container.sh
```

This builds the image, checks that `rserver`, `rsession`, `R`, and
`rstudio-server` exist inside it, moves it to
`/hpc/<cluster>/containers/rocker/`, and writes
`modules/testing/rocker_ml_cuda/<version>.lua`.

## Check the GPU

```
apptainer exec --nv /hpc/<cluster>/containers/rocker/rocker_ml_cuda_1.0.0.sif nvidia-smi
apptainer exec --nv /hpc/<cluster>/containers/rocker/rocker_ml_cuda_1.0.0.sif \
  /opt/venv/bin/python -c 'import torch; print(torch.cuda.is_available())'
```

## Notes for OOD

R is installed from apt in this image (`/usr/bin/R`, libR in
`/usr/lib/R/lib`), not under `/usr/local` like other rocker images. The
RStudio app's rsession wrapper must also add `/.singularity.d/libs` and
`/opt/venv/bin` back to the paths after sourcing the host environment, or
the GPU and the Python venv are not visible in RStudio. See
`ood/rstudio/template/script.sh.erb`.
