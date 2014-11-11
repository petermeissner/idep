#' loading a corepus file 
#' 

corpus_file_load <- function(){
  rm("corpus_env", envir=globalenv())
  corpus_env <<- new.env()
  load(corpus_file_full, envir=corpus_env)
}
