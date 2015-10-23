#' function for selecting a bunch of link files and computing other vars
#' 

corpus_file_select <- function(corpus_file_full=NULL) {
  if ( is.null(corpus_file_full) ){
    corpus_file_full <- choose.files()
  }
  corpus_file_full <- stringr::str_replace_all(corpus_file_full,"\\\\","/")
  assign("corpus_file_full", corpus_file_full, envir=globalenv() )
  assign("corpus_file_fname", basename(corpus_file_full), envir=globalenv() )
  assign("corpus_file_path",  dirname(corpus_file_full), envir=globalenv() )
}
