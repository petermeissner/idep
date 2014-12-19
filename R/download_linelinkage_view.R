#' function that downloads ready made info from the database

download_linelinkage_view <- function(con, saveToFile=F){
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
  
  if ( saveToFile == T ) {
    # generating filenames for STATA and R 
    message("\nsaving data ...")
    r_name      <- paste0("view_linelinkage_db_version_",version,".Rdata")
    stata_name  <- paste0("view_linelinkage_db_version_",version,".dta")
    readme_name <- paste0("view_linelinkage_db_version_README_",version,".txt")
    
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
    "
    Data file \n"  %.% 
      r_name       %.% "\n"  %.% 
    "and \n"       %.% 
      stata_name   %.% "\n"  %.% 
    "entail information on Standing Orders in European Parliaments.
    Collected and provided by IDEP (Institutional Design in European Parliaments) 
    working group.
  
    Both datasets are essential the same except that the storage of text 
    information in DTA-files is limited to 25x characters as well as to 
    non-special characters (there might be more relaxed limitations but where not 
    applicable with standard R (foreign) export capabilities). In the result 
    DTA-files come without the follwoing variables: 'll_minmaj_memo', 
    'tl_corpus_memo1', 'tl_corpus_memo2', 'tl_text1', 'tl_text2'. 
  
    Note, that the data provided is merged / joined / composed of three types 
    of data that refers to different units of analysis: 
    1. versions (the whole Standing Orders of country A at time 1) 
    2. textlines (a specific sub-paragraph / line of text of the Standing Orders 
       of country A at time 1) 
    3. linelinkage (a link between one textline (country A, time 1) and another 
       (country A, time 2)) which might either represent a change or a non-change 
       OR the information whether or not such a link is missing representing 
       insertion, deletions 
  
    The variable names entail the data's origin by starting with 't_' for versions 
    (text), 'tl_' for textlines, and 'll_' for linelinkage
  
    In the following all variables are listed:
  
    ll_tl_id1                :  textline id of version 1 
    
    ll_tl_id2                :  textline id of version 2
    
    ll_sim                   :  similarity between text of textline version 1 and 
                                text of textline version 2 (sum of words equal in 
                                both textlines divided by sum of words in both 
                                texts)
    
    ll_diff                  :  difference between text of textline version 1 and 
                                text of textline version 2 (sum of words only 
                                in either one textline  divided by sum of words 
                                in both texts)
    
    ll_sim_wd                :  number of words equal in both textlines
    
    ll_diff_wd               :  number of words unequal in both textlines
    
    ll_type                  :  type of change: change, no-change, insertion, 
                                deletion, not-relevant
    
    ll_t_id1                 :  text id of version 1 
    
    ll_t_id2                 :  text id of version 2
    
    ll_tl_lnr1               :  line number of textline in text version 1
    
    ll_tl_lnr2               :  line number of textline in text version 2
    
    ll_minmaj_code           :  pro minority versus pro majority (minmaj) coding: 
                                -99 for I do not know, 0 for neither nor, 1 for 
                                pro minority, 2 for pro majority 
    
    ll_minmaj_coder          :  name of the minmaj coder
    
    ll_minmaj_memo           :  possible memo concerning the coding decision
    
    ll_linkage_coder         :  name of the coder that did link textlines decide 
                                upon change/no-change/deletion/insertion
    
    int_id_1                 :  internal database id that is for internal use - 
                                hence the name
    
    tl_id1                   :  textline id of version 1
    
    tl_t_id1                 :  text     id of version 1
    
    tl_lnr1                  :  line number of textline in text version 1
    
    tl_relevant1             :  whether or not the textline was considered 
                                relevant: 0 for not-relevant textlines that are 
                                e.g. empty, contain headlines, or other stuff 
                                that is not part of regulations entailed in the 
                                Standing Orders; 1 for those relevant 
    
    tl_corpus_code1          :  corpus code assigned to textline version 1: 111 - 
                                999, with various information coded
    
    tl_text1                 :  the actual text of textline version 1 
    
    tl_wds_raw1              :  the number of raw (not cleaned up) words entailed 
                                in textline version 1
    
    tl_wds_clean1            :  the number of words entailed in textline version 1 
                                after cleansing away numerations of various form 
                                appearing at the !beginning! of the textline
    
    tl_corpus_memo1          :  possible memo concerning the coding decision that 
                                led to the corpus coding
    
    int_id_2                 :  internal database id that is for internal use - 
                                hence the name
    
    tl_id2                   :  textline id of version 2
    
    tl_t_id2                 :  text     id of version 2
    
    tl_lnr2                  :  line number of textline in text version 2
      
    tl_relevant2             :  whether or not the textline was considered 
                                relevant: 0 for not-relevant textlines that are 
                                e.g. empty, contain headlines, or other stuff that 
                                is not part of regulations entailed in the 
                                Standing Orders; 1 for those relevant 
    
    tl_corpus_code2          :  corpus code assigned to textline version 2: 111 - 
                                999, with various information coded
    
    tl_text2                 :  the actual text of textline version 2 
    
    tl_wds_raw2              :  the number of raw (not cleaned up) words entailed 
                                in textline version 2
    
    tl_wds_clean2            :  the number of words entailed in textline version 2 
                                after cleansing away numerations of various form 
                                appearing at the !beginning! of the textline
    
    tl_corpus_memo2          :  possible memo concerning the coding decision that 
                                led to the corpus coding
    
    t_t_id1                  :  text id of version 1
    
    t_date1                  :  date of the text (if available, date of enactment) 
                                of version 1
    
    t_dplus1                 :  additional date identifier if two or more version 
                                were in force at the same date of version 1
    
    t_country1               :  the country of the text of version 1
    
    t_daccept1               :  the date when the Standing Orders were decided 
                                upon (if available) of version 1
    
    t_dpromul1               :  the date when the Standing Orders were promulgated 
                                (if available) of version 1
    
    t_denact1                :  the date when the Standing Orders came into force 
                                (if available) of version 1
    
    t_t_id2                  :  text id of version 2
    
    t_date2                  :  date of the text (if available, date of enactment) 
                                of version 2
    
    t_dplus2                 :  additional date identifier if two or more version 
                                were in force at the same date of version 2
    
    t_country2               :  the country of the text of version 2
    
    t_daccept2               :  the date when the Standing Orders were decided 
                                upon (if available) of version 2
    
    t_dpromul2               :  the date when the Standing Orders were promulgated 
                                (if available) of version 2
    
    t_denact2                :  the date when the Standing Orders came into force 
                                (if available) of version 2
  
    Konstanz, 2014
    "
    writeLines(readme_text, readme_name)
  }
  
  # return
  invisible(linelinkage)
}


