#!/usr/bin/env Rscript

install.packages("BiocManager")
BiocManager::install(version = "3.16")

packages = c(
  "FastQC",
  "cutadapt",
  "TrimGalore!",
  "STAR",
  "RSEM",
  "edgeR",
  "AnnotationDbi",
  "org.Hs.eg.db"
)

BiocManager::install(packages)

