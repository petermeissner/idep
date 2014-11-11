#' function extracting the texts from link data files

link_files_get_text <- function(filelist_full){
  # easy paste
  '%.%' <- function(a,b) paste0(a,b)

  # define worker
  worker2 <- function(env_name) {
    res  <- eval(as.name(env_name))$RESULTS
    meta <- eval(as.name(env_name))$meta
    tmp  <- link_data_get_text(res)
    id        <- meta$id1  %.% "_"  %.% str_pad(tmp$l1,4,"left","_")
    id        <- c( id, meta$id2  %.% "_"  %.% str_pad(tmp$l2,4,"left","_") )
    lnr       <- c(tmp$l1, tmp$l2)
    textid    <- c(rep(meta$id1, length(tmp$l1)), rep(meta$id2, length(tmp$l2)))
    text      <- c(tmp$t1, tmp$t2)
    relevant  <- as.numeric(c(tmp$r1,tmp$r2))
    return(data.frame(id, text, lnr, textid, relevant, stringsAsFactors=F))
  }
  
  # do work on Env. 
  tmp <- ldply(linkage_env, worker2)
  tmp <- tmp[!duplicated(tmp$id),]
  tmp$wds_raw   <- nwords(tmp$text)
  tmp$wds_clean <- nwords(diffr::cleanTextFunctions$idep(tmp$text))
  tmp
}
