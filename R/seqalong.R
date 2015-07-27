#' convenience function for getting seqence for looping
#'
#' @param x the object to form a sequence along
#' @return a vector of length (or first dimension) of x 


seqalong <- function(x)
{
  if( is.null(dim(x)) ){
    seq_along(x)
  } else {
    seq_len(dim(x)[1])
  }
}
