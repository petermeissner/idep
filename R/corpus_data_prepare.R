#' function for preparing corpus data to be merged with lines dat

corpus_data_prepare <- function(){
  '%.%' <- function(a,b) paste0(a,b)
  corpus_env$coding$dplus <<- as.numeric(
    match(
      tolower(str_extract(
        corpus_env$coding$date,
        "[[:alpha:]]+")),
      letters)
  )
  
  corpus_env$coding$dplus <<- ifelse(is.na(corpus_env$coding$dplus), 0, corpus_env$coding$dplus)
  corpus_env$coding$date  <<- unlist(lapply(
    str_extract_all(corpus_env$coding$date,"\\d+"), 
    paste, collapse="-")
  )
  
  corpus_env$coding$id  <<-   country                  %.% "_"  %.% 
                              corpus_env$coding$date   %.% "." %.% 
                              corpus_env$coding$dplus  %.% "_"  %.% 
                              str_pad(corpus_env$coding$lnr,4,"left","_")
}    
