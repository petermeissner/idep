#' function that downloads ready made info from the database

download_linelinkage_info <- function(con){
  '%.%' <- function(a,b) paste0(a,b)
  # getting data
  message("downloading data ... ")
  report_time( 
    linelinkage <- suppressWarnings(dbReadTable(con, "temp_linelinkage_textlines_texts"))
  )
  
  # dropping unwanted variables
  linelinkage <- 
    linelinkage[, -match("int_dupdate_linelinkage", names(linelinkage))]
  
  # getting version and last update date
  version    <- max(dbReadTable(con, "version")$versionnumber, na.rm=T)
  lastupdate <- suppressWarnings(dbGetQuery(con, "SELECT max(int_dupdate) FROM view_last_update"))
  
  linelinkage$db_version    <- as.numeric(version)
  linelinkage$db_lastupdate <- as.character(lastupdate)
  
  
  # generating filenames for STATA and R 
  message("\nsaving data ...")
  r_name      <- paste0("view_linelinkage_db_version_",version,".Rdata")
  stata_name  <- paste0("view_linelinkage_db_version_",version,".dta")
  readme_name <- paste0("README_view_linelinkage_db_version_",version,".txt")
  
  # saving to RData
  report_time(save(linelinkage, file=r_name))
  
  # saving to STATA
  tmp <- linelinkage
  #dev# for(i in 1:length(tmp[1,])){ print(class(tmp[,i]))  }
  # remove some variables for STATA
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
  
  # make README
  readme_text <- 
  "data file "  %.% r_name  %.% 
  "and"  %.% stata_name  %.% 
  "Entail information on Standing Orders in European Parliaments.
  Collected and provided by IDEP (Institutional Design in European Parliaments) working group.

  Both datasets are essential the same except that the storage of text information in DTA-files is limited to 25x characters as well as to non-special characters (there might be more relaxed limitations but where not applicable with standard R (foreign) export capabilities). In the result DTA-files come without the follwoing variables: 'll_minmaj_memo', 'tl_corpus_memo1', 'tl_corpus_memo2', 'tl_text1', 'tl_text2'. 

  Note, that the data provided is merged / joined / composed of three types of data that refers to different units of analysis: 
  1. versions (the whole Standing Orders of country A at time 1) 
  2. textlines (a specific sub-paragraph / line of text of the Standing Orders of country A at time 1) 
  3. linelinkage (a link between one textline (country A, time 1) and another (country A, time 2)) which might either represent a change or a non-change OR the information whether or not such a link is missing representing insertion, deletions 

  The variable names entail the data's origin by starting with 't_' for versions (text), 'tl_' for textlines, and 'll_' for linelinkage

  In the following all variables are listed:

  ll_tl_id1
  ll_tl_id2
  ll_sim
  ll_diff
  ll_sim_wd
  ll_diff_wd
  ll_type
  ll_t_id1
  ll_t_id2
  ll_tl_lnr1
  ll_tl_lnr2
  ll_minmaj_code
  ll_minmaj_coder
  ll_minmaj_memo
  ll_linkage_coder
  int_id_1
  tl_id1
  tl_t_id1
  tl_lnr1
  tl_relevant1
  tl_corpus_code1
  tl_text1
  tl_wds_raw1
  tl_wds_clean1
  tl_corpus_memo1
  int_id_2
  tl_id2
  tl_t_id2
  tl_lnr2
  tl_relevant2
  tl_corpus_code2
  tl_text2
  tl_wds_raw2
  tl_wds_clean2
  tl_corpus_memo2
  t_t_id1
  t_date1
  t_dplus1
  t_country1
  t_daccept1
  t_dpromul1
  t_denact1
  t_t_id2
  t_date2
  t_dplus2
  t_country2
  t_daccept2
  t_dpromul2
  t_denact2
  "
    
    
  writeLines(readme_text, readme_name)
}
