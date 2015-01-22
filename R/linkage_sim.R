#' function for calculating similarity again
#' @param simtype is one of sim, diff, sim_wd, diff_wd, wds, wd1, wd2

linkage_sim <- function(res, 
                        simtype=c("sim","diff","sim_wd","diff_wd","wds","wd1","wd2")){
  worker <- function(res, simtype){
    simtype <- simtype[1]
    res  <- as.data.frame(as.list(res), stringsAsFactors=F)
    
    # ensuring Text is CLEANed UP
    ot   <- clean_text( tolower( res$Aorigtext ))
    nt   <- clean_text( tolower( res$Borigtext ))
      
    if ( simtype=="diff_wd" ) {
      return( as.numeric(text_dist(ot, nt)) )
    } 
    if ( simtype=="sim_wd" )  {
      return( as.numeric(( nwords(ot) + nwords(nt) ) - text_dist(ot, nt)) )
    } 
    if ( simtype=="wd1" )  {
      return( nwords(ot) )
    } 
    if ( simtype=="wd2" ) {
      return( nwords(nt) )
    }  
    if ( simtype=="wds" )  {
      return( nwords(ot) + nwords(nt) )
    } 
    if ( simtype=="sim" )  {
      return( as.numeric( (( nwords(ot) + nwords(nt) ) - text_dist(ot, nt)) / 
                           (nwords(ot) + nwords(nt))) 
              )
    } 
    if ( simtype=="diff" )  {
      return( as.numeric(text_dist(ot, nt) / (nwords(ot) + nwords(nt))) )
    } 
    stop("linkage_sim says: something went terribly wrong.")
  }
  tmp <- apply(res, 1, worker, simtype=simtype )
  names(tmp) <- NULL
  tmp
}

