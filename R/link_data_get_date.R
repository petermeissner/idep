#' function for extracting dates from link data texts
#' 

link_data_get_date <- function(RESULTS, flatten=F){
  worker <- function(ftext){
    dtext      <- ftext[ grep("date\\s+[iop][sdf]\\s+acceptance", ftext, ignore.case=T)  ]
      daccept  <- str_extract(dtext, "\\d{1,2}.\\d{1,2}.\\d{4}")
      daccept  <- null_to_na(dmy(daccept[!is.na(dtext)], quiet=T))
      daccept  <- as.POSIXct(daccept, origin="1970-01-01",tz="UTC")
    
    dtext      <- ftext[ grep("date\\s+[iop][sdf]\\s+promulgation", ftext, ignore.case=T)  ]
      dpromul  <- str_extract(dtext, "\\d{1,2}.\\d{1,2}.\\d{4}")
      dpromul  <- null_to_na(dmy(dpromul[!is.na(dtext)], quiet=T))
      dpromul  <- as.POSIXct(dpromul, origin="1970-01-01",tz="UTC")
    
    dtext     <- ftext[ grep("date\\s+[iop][sdf]\\s+enactment",  ftext, ignore.case=T)  ]
      denact  <- str_extract(dtext, "\\d{1,2}.\\d{1,2}.\\d{4}")
      denact  <- null_to_na(dmy(dtext[!is.na(dtext)], quiet=T))
      denact  <- as.POSIXct(denact,  origin="1970-01-01",tz="UTC")
    
    return(data_frame(daccept, dpromul, denact))
  }
  tmp <- ldply(list(RESULTS$oldtext, RESULTS$newtext), worker)
  if ( flatten ) {
    return(tmp)  
  }else{
    return( data.frame(
      daccept1=tmp$daccept[1],
      daccept2=tmp$daccept[2],
      dpromul1=tmp$dpromul[1],
      dpromul2=tmp$dpromul[2],
      denact1=tmp$denact[1],
      denact2=tmp$denact[2]
      ))
  }
}
