cran = list(
  packages = c(
    "BiocManager")
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

