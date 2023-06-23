#' Rat Phenotype Data
#'
#' A dataframe containing the rat meta and phenotype data use for linear regression
#' modeling
#'
#' @format ## `rat_meta_data`
#' A data frame with 60 rows and 4 columns
#' \describe{
#'   \item{Name}{Rat ID for linking data to feature data}
#'   \item{Line}{High Capacity Runner (HCR) or Low Capacity Runner (LCR) rat line identifier}
#'   \item{Sex}{Female or male rat sex identifer}
#'   \item{Diet}{Control, Carbohydrate, or Fat rat diet identifier}
#' }
#' @source University of Michigan Metabolomics Core
"rat_meta_data"


#' Rat Lipidomics Group Key Identifier
#'
#' A dataframe containing the feature names and their corresponding groups IDs
#'
#' @format ## `rat_lipidomics_group_key`
#' A data frame with 302 rows and 2 columns
#' \describe{
#'   \item{Lipid}{Feature name, which corresponds to column names for data files}
#'   \item{Cluster}{Group identifier for PCA feature reduction analysis }
#' }
#' @source University of Michigan Metabolomics Core
"rat_lipidomics_group_key"


#' Rat Plasma Lipidomics (Day 0)
#'
#' A dataframe of raw peak areas from untargeted lipidomics analysis after correcting
#' for batch, drift, and missingness. Features with high variability or unknown lipid
#' identification have been removed.
#'
#' @format ## `rat_lipidomics_day0`
#' A data frame with 60 rows and 302 columns where rows correspond to observations
#' and columns correspond to features
#'
#' @source University of Michigan Metabolomics Core
"rat_lipidomics_day0"




#' Rat Plasma Lipidomics (Day 3)
#'
#' A dataframe of raw peak areas from untargeted lipidomics analysis after correcting
#' for batch, drift, and missingness. Features with high variability or unknown lipid
#' identification have been removed.
#'
#' @format ## `rat_lipidomics_day3`
#' A data frame with 60 rows and 302 columns where rows correspond to observations
#' and columns correspond to features
#'
#' @source University of Michigan Metabolomics Core
"rat_lipidomics_day3"




#' Rat Plasma Lipidomics (Day 14)
#'
#' A dataframe of raw peak areas from untargeted lipidomics analysis after correcting
#' for batch, drift, and missingness. Features with high variability or unknown lipid
#' identification have been removed.
#'
#' @format ## `rat_lipidomics_day0`
#' A data frame with 60 rows and 302 columns where rows correspond to observations
#' and columns correspond to features
#'
#' @source University of Michigan Metabolomics Core
"rat_lipidomics_day14"

