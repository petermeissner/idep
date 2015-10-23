#' function for extracting dates from link data files
#' 

link_files_get_date <- function(filelist_full, flatten=F){
    worker2 <- function(linkage_env, flatten) {
    res <- eval(as.name(linkage_env))$RESULTS
    link_data_get_date(res, flatten=F)
  }
  tmp <- ldply(linkage_env, worker2)
  for(i in seq_along(tmp[1,])) tmp[,i] <- as.character(tmp[,i])
  
  if ( flatten  ) {
    daccept = ymd(c(tmp$daccept1[1], tmp$daccept2))
    dpromul = ymd(c(tmp$dpromul1[1], tmp$dpromul2))
    denact  = ymd(c(tmp$denact1[1], tmp$denact2))
    return(data.frame(daccept,dpromul,denact))
  }
  if( !flatten ){
    return(tmp)
  }
}
