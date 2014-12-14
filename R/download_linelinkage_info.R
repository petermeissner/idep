#' function that downloads ready made info from the database

download_linelinkage_info <- function(con){
  '%.%' <- function(a,b) paste0(a,b)
  # getting data
  message("downloading data ... ")
  report_time( 
    linelinkage <- suppressWarnings(dbReadTable(con, "temp_linelinkage_textlines_texts"))
  )
    
  # getting version and last update date
  version    <- max(dbReadTable(con, "version")$versionnumber, na.rm=T)
  lastupdate <- suppressWarnings(dbGetQuery(con, "SELECT max(int_dupdate) FROM view_last_update"))
  
  linelinkage$db_version    <- as.numeric(version)
  linelinkage$db_lastupdate <- as.character(lastupdate)
  
  
  # generating filenames for STATA and R 
  message("\nsaving data ...")
  r_name     <- paste0("view_linelinkage_db_version_",version,".Rdata")
  stata_name <- paste0("view_linelinkage_db_version_",version,".dta")
  
  # saving to RData
  report_time(save(linelinkage, file=r_name))
  
  # saving to STATA
  tmp <- linelinkage
  #dev# for(i in 1:length(tmp[1,])){ print(class(tmp[,i]))  }
  tmp <- 
    tmp[,-
          match(c("ll_minmaj_memo",
                  "tl_corpus_memo1",
                  "tl_corpus_memo2",
                  "tl_text1",
                  "tl_text2"), names(tmp))
        ]
  for ( i in seq_along(tmp[1,]) ) {
    if( any(class(tmp[,i])=="character") & any(nchar(tmp[,i])>200) ){
      tmp[,i] <- paste( substring(tmp[,i],0,200), " ...") 
    }
    tmp[,i] <- ifelse(tmp[,i]==""," ", tmp[,i])
  }
  report_time(write.dta(tmp, version=10, file=stata_name,convert.dates=F))
  message("done, info wirtten to:")
  message(getwd() %.% "/" %.% r_name)
  message(getwd() %.% "/" %.% stata_name)
}
