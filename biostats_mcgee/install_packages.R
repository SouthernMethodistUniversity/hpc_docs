cran = list(
  packages = c(
    "BiocManager",
    "ade4",
    "vcfR",
    "adegenet",
    "reshape2",
    "ggplot2")
)

bioc = list(
  packages = c(
    "edgeR",
    "AnnotationDbi",
    "org.Hs.eg.db"),
  version = "3.16"
)

install.packages(cran$packages)
BiocManager::install(version = bioc$version)
BiocManager::install(bioc$packages)

