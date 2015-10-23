#' function extracting words from text
#' @param text a character vector

words <- function(text){
  worker <- function(text){
    text <- unlist(strsplit(text, "[[:space:][:punct:]]"))
    text[text!=""]
  }
  if ( length(text)==1 ) {
    worker(text)
  } else {
    lapply(text, worker)
  }
}

