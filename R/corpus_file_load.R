#' loading a corepus file 
#' 

corpus_file_load <- function(){
  suppressWarnings(rm("corpus_env", envir=globalenv()))
  assign( "corpus_env", new.env(parent=globalenv()), envir=globalenv())
  load(corpus_file_full, envir=corpus_env)
}
