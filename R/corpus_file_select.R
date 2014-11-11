#' function for selecting a bunch of link files and computing other vars
#' 

corpus_file_select <- function() {
  tempwd <- getwd()
  setwd("Z:/Gesch\u00e4ftsordnungen/CodingCorpus/")
  corpus_file_full  <<- choose.files()
  setwd(tempwd)
  corpus_file_full  <<- stringr::str_replace_all(corpus_file_full,"\\\\","/")
  corpus_file_fname <<- basename(corpus_file_full)
  corpus_file_path  <<- dirname(corpus_file_full)
}
