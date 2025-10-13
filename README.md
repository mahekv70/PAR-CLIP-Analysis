# PAR-CLIP Analysis
![R](https://img.shields.io/badge/R-4.4.1-blue?logo=r)
![Bash](https://img.shields.io/badge/Bash-Script-green?logo=gnu-bash)
![Platform](https://img.shields.io/badge/Platform-PowerSlurm%20Cluster-orange)
![Status](https://img.shields.io/badge/Status-Active-success)
![License](https://img.shields.io/badge/License-Academic-lightgrey)
![Made-with-love](https://img.shields.io/badge/Made%20with-%E2%9D%A4-red)

This repository contains scripts for processing, analyzing, and visualizing PAR-CLIP (Photoactivatable Ribonucleoside-Enhanced Crosslinking and Immunoprecipitation) data.  
The workflows focus on **k-mer enrichment**, **RNA-binding site analysis**, and **visualization of binding intensity** for RNA-binding proteins.

---

## 📁 Repository Contents

| File | Description |
|------|--------------|
| `boxplot.R` | Generates boxplots of RNA-binding intensity across gene categories (mitochondrial, pseudogenes, nuclear) using **ggplot2**, **ggrepel**, and **ggnewscale**. |
| `clip.sh` | Script to extract bound and input regions from BED files and compute k-mer frequencies for enrichment analysis. |
| `kmer.sh` | Example PBS submission script for running k-mer analysis on a computational cluster (Power/Slurm). |

---

## 🧬 Dependencies

### R packages
```r
install.packages(c("ggplot2", "ggrepel", "ggnewscale", "RColorBrewer", "readxl", "dplyr", "stringr"))
