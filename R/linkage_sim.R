#' function for calculating similarity again
#' @param type is one of sim, diff, sim_wd, diff_wd, wds, wd1, wd2

linkage_sim <- function(res, type=c("sim","diff","sim_wd","diff_wd","wds","wd1","wd2")){
  worker <- function(res, type){
    type <- type[1]
    res  <- as.data.frame(as.list(res), stringsAsFactors=F)
    ot   <- tolower(res$Aorigtext)
    nt   <- tolower(res$Borigtext)
    dist <- diffr::distanceFunctions$idep
  
    if ( type=="diff_wd" ) {
      return( as.numeric(dist(ot,nt)) )
    } 
    if ( type=="sim_wd" )  {
      return( as.numeric(( nwords(ot) + nwords(nt) ) - dist(ot,nt)) )
    } 
    if ( type=="wd1" )  {
      return( nwords(ot) )
    } 
    if ( type=="wd2" ) {
      return( nwords(nt) )
    }  
    if ( type=="wds" )  {
      return( nwords(ot) + nwords(nt) )
    } 
    if ( type=="sim" )  {
      return( as.numeric( (( nwords(ot) + nwords(nt) ) - dist(ot,nt)) / 
                           (nwords(ot) + nwords(nt))) 
              )
    } 
    if ( type=="diff" )  {
      return( as.numeric(dist(ot,nt) / (nwords(ot) + nwords(nt))) )
    } 
    stop("linkage_sim says: something went terribly wrong.")
  }
  tmp <- apply(res, 1, worker, type=type )
  names(tmp) <- NULL
  tmp
}

