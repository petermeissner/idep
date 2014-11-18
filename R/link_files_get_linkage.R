#' function for extracting dates from link data files
#' 

link_files_get_linkage <- function(){
  # apply function definition
  worker2 <- function(linkage_env) {
    res  <- eval(as.name(linkage_env))$RESULTS
    meta <- eval(as.name(linkage_env))$meta
    link_data_get_linkage(res, meta) 
  }
  # data extraction  
  ldply(linkage_env, worker2, .progress="text")
}
