#' helper function for accessing environments
env <- function(i,name=F){
  nameval <- paste0("linkage_env", str_pad(i,3,"left",0))
  if (name==T) {
    return(nameval)
  }else{
    return( eval(as.name(nameval)) )
  }
}

#' function for loading a set off link data files

link_files_load <- function(filelist_full){
  # clean up old envs
  rm(list = ls(pattern = "^linkage_env\\d+"))
  # make new envs and load data from filelist_full
  fl_seq    <- seq_along(filelist_full)
  for ( i in fl_seq )  {
    assign( env(i, name=T), new.env(parent=globalenv()), envir=globalenv())
    load(filelist_full[i], env(i))
  }
  # store names
  assign("linkage_env",
         paste0("linkage_env",str_pad(seq_along(filelist_full),3,"left",0)), 
         globalenv() )
  # correct Encoding to latin1 (oldtext / newtext) in case of UTF-8 coding
  for (i in fl_seq) {
    eval(
      expr  = expression(Encoding(RESULTS$newtext) <- "latin1"), 
      envir = eval(as.name( linkage_env[i] ))
    )
    eval(
      expr  = expression(Encoding(RESULTS$oldtext) <- "latin1"), 
      envir = eval(as.name( linkage_env[i] ))
    )
  }
  
  # push meta information to envs
  meta <- get_meta_from_fname(filelist_full)
  for ( i in seq_along(linkage_env)) {
    assign("meta", meta[i,], envir=eval(as.name(linkage_env[i])))
  }
}
