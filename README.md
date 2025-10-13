# PAR-CLIP Analysis
![R](https://img.shields.io/badge/R-4.4.1-lightblue)
![HPC](https://img.shields.io/badge/Cluster-PowerSlurm-green)
![TAU](https://img.shields.io/badge/Institute-Tel%20Aviv%20University-darkblue)
![LCRB Lab](https://img.shields.io/badge/Lab-LCRB@TAU-8A2BE2)
![Bedtools](https://img.shields.io/badge/Tool-Bedtools-red)
![Cutadapt](https://img.shields.io/badge/Tool-Cutadapt-orange)
![STAR](https://img.shields.io/badge/Tool-STAR--aligner-green)

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
