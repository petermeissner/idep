#' head method for tabl_df that shows all columns
#' 
#' Internally tbl_df is transformed via as.data.frame() and than the usual 
#' head() function is used.
#' 
#' @param x the tbl_df object for which to show head
#' @param n the amount of rows to show
#' @seealso head()

head.tbl_df <- function(x, n=5) head(as.data.frame(x),n)
