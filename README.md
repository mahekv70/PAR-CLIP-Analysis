# PAR-CLIP Analysis

![R](https://img.shields.io/badge/R-4.4.1-blue?logo=r)
![Status](https://img.shields.io/badge/Status-Archived-lightgrey)
![License](https://img.shields.io/badge/License-MIT-lightgrey)
![Made-with-love](https://img.shields.io/badge/Made%20with-%E2%9D%A4-red)

This repository contains an **R-based workflow for visualizing PAR-CLIP data**, with a focus on comparing **RNA-binding intensity across gene categories** such as mitochondrial RNAs, pseudogenes, and nuclear genes.

The analysis is intended for **publication-quality visualization** of RNA–protein interaction datasets.

---

## Repository Contents

| File | Description |
|------|------------|
| `boxplot.R` | Generates boxplots of RNA-binding intensity across gene categories (mitochondrial, pseudogenes, nuclear) using **ggplot2**, **ggrepel**, and **ggnewscale**. |

---

## Dependencies

### R packages

```r
install.packages(c(
  "ggplot2",
  "ggrepel",
  "ggnewscale",
  "RColorBrewer",
  "readxl",
  "dplyr",
  "stringr"
))
