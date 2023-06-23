
#' Feature Reduction by PCA
#'
#' This function accepts feature data and a predefined feature group key to
#' compute a weighed group value. Within each predefined group, features are
#' weighed by PCA, multiplied by the absolute value of the PCA loading factor to
#' determine its relative contribution to variance, and summed to generate a group
#' value. Each observation is assigned a group value in the dataframe output.
#'
#' @param feature_data Dataframe with columns as features and rows as observations.
#' This function does not perform any data cleaning or normalization. For metabolomics
#' data, it is expected that data is log2 normalized. If `NA` features are present, these
#' will be excluded from PCA analysis and the `NA` value for the will be retained in
#' the output object.
#' @param feature_group_key Dataframe with column 1 as features and column 2 as group ID.
#' Column names in `feature_data` must have exact matches in column 1 of `feature_group_key` to
#' be included in the grouping analysis.
#' @param norm One of `"none"` (default) or `"scale"` to indicate weather features should be scaled
#' prior to weighing. This is helpful for heatmaps. Note that PCA will be performed on the
#' provided `feature_data` values.
#' @returns A matrix with columns as groups (provided group IDs) and rows as observations.
#' @export
reduce_features_by_pca <- function(feature_data = NULL, feature_group_key = NULL,
                                   norm = "none"){

  if(nrow(feature_data)<5){
    warning("This grouping function uses PCA weighing and is not recommended for datasets with less than 5 observations")
  }

  # Assign colnames to feature_group_key and confirm as factor
  if(ncol(feature_group_key)<2){
    stop("feature_group_key requires 2 columns: column 1 is feature and column 2 is the group ID")
  }
  feature_group_key <- as.data.frame(apply(as.data.frame(feature_group_key), 2, as.character))
  colnames(feature_group_key)[1:2] <- c("Feature","Group")
  rownames(feature_group_key) <- feature_group_key[,"Feature"]

  # Confirm that feature_data is numeric and and that colnames (features) exist
  # in feature_group_key
  feature_data_temp <- apply(as.data.frame(feature_data), 2, as.numeric)
  rownames(feature_data_temp) <- rownames(feature_data)
  colnames(feature_data_temp) <- colnames(feature_data)

  if(!any(colnames(feature_data_temp) %in% feature_group_key[,"Feature"])){
    stop("No features (column names) in feature_data found in feature_group_key")
  }
  if(!all(colnames(feature_data_temp) %in% feature_group_key[,"Feature"])){
    warning(paste0("Not all features in feature_data found in feature_group_key. These features will not be included in grouping analyses: ",
                   paste0(colnames(feature_data_temp)[!colnames(feature_data_temp) %in%
                                                       feature_group_key[,"Feature"]],collapse=", ")))
  }

  # Initialize dataframe to store group values
  return_df <- data.frame(matrix(ncol = length(unique(feature_group_key[,"Group"])),
                                 nrow = nrow(feature_data)))
  colnames(return_df) <- unique(feature_group_key[,"Group"])
  rownames(return_df) <- rownames(feature_data)

  # The following loops over each unique group to assign a single value for each observation
  for (g in unique(feature_group_key[,"Group"])) {

    # Get the feature names that correspond to interative loop
    filtered_group_features <- feature_group_key %>%
      dplyr::filter(Group == g) %>%
      dplyr::pull(Feature)

    # Select features from feature_data
    if(any(filtered_group_features %in% colnames(feature_data))){
      filtered_feature_data <- feature_data[,(colnames(feature_data) %in% filtered_group_features)]
    } else {
      message(paste0("Skipping group ", g, "; no group features found in feature_data"))
      next
    }

    print(paste0("For group ", g, ", ", ncol(filtered_feature_data)," features found in feature_data; performing PCA analysis"))

    # Get PC1 rotation from PCA  data
    # Absolute value of the rotation data is extracted because we are using amplification of effect and not direction of effect
    if(sum(is.na(filtered_feature_data))>0){
      message(paste0("For group ", g, ", ", sum(is.na(filtered_feature_data))," NA values; excluding from PCA analysis"))
    }
    pca <- prcomp(na.exclude(filtered_feature_data), scale = T)
    pc1_rotation <- abs(pca$rotation[,1])

    # Individual feature values are multiplied by the absolute values of their PC1
    # rotation/loading factor so that the values are adjusted for their degree
    # of contribution to variation in the data, then summed
    if(norm == "none") {
      pc1_adjusted_values <- t(filtered_feature_data)*pc1_rotation

    } else if(norm == "scale") {
      filtered_feature_data_scale <- apply(filtered_feature_data, 2, function(x) scale(x))
      pc1_adjusted_values <- t(filtered_feature_data_scale)*pc1_rotation

    } else {
      error("Provide one of 'none' or 'scale' for norm option")
    }

    feature_group_data <- as.data.frame(apply(pc1_adjusted_values, 2, function(x) sum(x)))
    return_df[,g] <- feature_group_data
  }
  return(return_df)
}


