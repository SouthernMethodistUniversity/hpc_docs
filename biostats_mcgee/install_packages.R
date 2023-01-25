#!/usr/bin/env Rscript

packages_cran = c(
  "FastQC",
  "cutadapt",
  "TrimGalore!",
  "STAR",
  "RSEM",
  "BiocManager"
)

bioc_version = "3.16"
packages_bioc = c(
  "edgeR",
  "AnnotationDbi",
  "org.Hs.eg.db"
)

install.packages(packages_cran)
BiocManager::install(version = bioc_version)
BiocManager::install(packages_bioc)

