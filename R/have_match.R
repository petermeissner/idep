#' function for looking which items of a are contained in b
#' @param a items to be checked
#' @param b items to check against

matched <- function(a,b){
  a[a %in% b]
}

#' @aliases matched 

not_matched <- function(a,b){
  a[!(a %in% b)]
}
