#' function like head but working with dplyr

peek        <- function(x,n) head(as.data.frame(x),n=5)
