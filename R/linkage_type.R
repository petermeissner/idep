#' function returning type of change


linkage_type <- function(res) {
  worker <- function(res){
    res <- as.data.frame(as.list(res), stringsAsFactors=F)
    ol  <- as.numeric(res$oldline)
    nl  <- as.numeric(res$newline)
    sim <- as.numeric(res$similarity)
    rel <- as.numeric(res$relevant)
    if( rel!=1 | is.na(rel) )     return("not-relevant")
    if( !is.na(ol) &  is.na(nl) ) return("deletion")
    if(  is.na(ol) & !is.na(nl) ) return("insertion")
    if( sim==1 )                  return("no-change")
    if( sim < 1 )        return("change")
    return("nonsense")
  }
  tmp <- apply(res, 1, worker)
  names(tmp) <- NULL
  return(tmp)
}
