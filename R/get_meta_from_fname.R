#' function extracting dates and other information from a link file filename

get_meta_from_fname <- function(fnames , flatten=F, uniq=T){
  worker <- function(fname, flatten=F) {
    tmp     <- unlist(str_split(basename(fname), " VS "))
    tmp     <- str_replace(tmp, "coded ", "")
    dates   <- lubridate::ymd(tmp)
    dplus   <- str_replace(str_extract(tmp,"_[a-zA-Z]"),"_","")
    dplus   <- match(tolower(dplus), letters)
    dplus   <- ifelse(is.na(dplus), 0, dplus)
    ###country <- str_extract(tmp, "^\\w+")
    if ( !exists("country") ) country <- "NA"
    id      <- paste0(country,"_",dates, paste("", dplus, sep="." ))
    if (length(id)==2 & !flatten) {
      return( data_frame(
                id1     = id[1],
                id2     = id[2],
                date1   = dates[1], 
                date2   = dates[2], 
                dplus1  = dplus[1],
                dplus2  = dplus[2],
                country = country)  )
    }
    if ( length(id)==1 | flatten ){
      return(data_frame(id = id, date = dates, dplus = dplus, country = country))
    }
  }
  if ( !flatten ) {
    res <- suppressWarnings(ldply(fnames, worker, flatten) )
    return(res)
  }
  if ( flatten ) {
    tmp <- ldply(fnames, worker, flatten)  
    if ( uniq == T ) tmp <- tmp[!duplicated(tmp$id),]
    rownames(tmp) <- NULL
    return( tmp )
  }
}







