#' function counting the number of words
#' @param text character vector
#' 

nwords <- function(text){
  if ( length(text)==1 ) {
    length(words(text))
  } else {
    unlist(lapply(text, function(text) length(words(text)) ))
  }
}
