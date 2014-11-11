#' function extracting the texts from link data files

link_files_get_text_only <- function(filelist_full, flatten=F){
  worker2 <- function(linkage_env, flatten) {
    link_data_get_text( eval(as.name(linkage_env))$RESULTS)
  }
  tmp <- llply(linkage_env, worker2)
  if ( !flatten ) return(tmp)
  if ( flatten ) {
    tmp2 <- NULL
    for(i in 1:(length(tmp))) tmp2[[i]] <- list()
    for(i in seq_along(tmp)){
      tmp2[[i]]$text <- tmp[[i]]$t1
      tmp2[[i]]$lnr  <- tmp[[i]]$l1
    }
      i <- length(tmp2)+1
      tmp2[[i]]       <- list()
      tmp2[[i]]$text  <- tmp[[i-1]]$t2
      tmp2[[i]]$lnr   <- tmp[[i-1]]$l2
    return(tmp2)
  }
}
