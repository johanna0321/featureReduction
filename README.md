# featureReduction

## Overview
  
This package provides a user-friendly function to perform PCA-based a priori based feature-clustering. Example data and my example pipeline are provided.

## Package Updates

This package is not frequently updated. Please contact that author for help or to address bugs. 

## Installation

First, download and install R and RStudio:
  
- [R](https://mirror.las.iastate.edu/CRAN/) 
- [RStudio](https://rstudio.com/products/rstudio/download/) (free version)

Then, open RStudio and install the `devtools` package

```
install.packages("devtools")
```

Finally, install the `featureReduction` package

```
library(devtools)
devtools::install_github("johanna0321/featureReduction")
```

## Usage

The following are included in the package and documentation is accessible using the 
help() function or ? help operator

Data:
```
rat_lipidomics_day0
rat_lipidomics_day3
rat_lipidomics_day14
rat_lipidomics_group_key
rat_meta_data
```
  
Functions: 
```
reduce_features_by_pca()
```
