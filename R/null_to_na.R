#' function transforming NULL (non-values) to NA
#' 
null_to_na  <- function(x) ifelse(is.null(x), NA, x)
