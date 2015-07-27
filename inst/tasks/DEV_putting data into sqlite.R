

### cleaning and combining the data

ll_clean <- 
  ll_raw  %>% 
  rename(
    tl_id_1 = ll_tl_id1, 
    tl_id_2 = ll_tl_id2,
    t_id_1  = ll_t_id1,
    t_id_2  = ll_t_id2,
    lnr_1   = ll_tl_lnr1,
    lnr_2   = ll_tl_lnr2,
    diff    = ll_diff,
    sim     = ll_sim,
    diff_wd = ll_diff_wd,
    sim_wd = ll_sim_wd, 
    minmaj = ll_minmaj_code,
    minmaj_coder = ll_minmaj_coder,
    minmaj_memo = ll_minmaj_memo,
    linkage_coder = ll_linkage_coder
  )  


tl_clean <- 
  tl_raw  %>% 
  rename(
    t_id = tl_t_id,
    lnr  = tl_lnr,
    relevant = tl_relevant,
    corpus =  tl_corpus_code,
    corpus_memo = tl_corpus_memo,
    wds_clean = tl_wds_clean,
    wds_raw = tl_wds_raw, 
    text = tl_text
  )
tl_clean_1 <- 
  tl_clean %>% 
  select( -contains("int_"), -contains("db_") , -t_id)
tl_clean_2 <- tl_clean_1
names(tl_clean_1) <- paste0(names(tl_clean_1), "_1")
names(tl_clean_2) <- paste0(names(tl_clean_2), "_2")

t_clean <- 
  t_raw  %>% 
  rename(
    date = t_date,
    date_plus = t_dplus,
    date_accept = t_daccept,
    date_promul = t_dpromul,
    date_enact  = t_denact,
    country     = t_country
  )

t_clean_1 <- 
  t_clean %>% 
  select( -contains("int_"), -contains("db_") )
t_clean_2 <- t_clean_1
names(t_clean_1) <- paste0(names(t_clean_1), "_1")
names(t_clean_2) <- paste0(names(t_clean_2), "_2")





## DEV ## 

ll_clean_ext <- ll_clean

#    -->  in linkage and in textline      : 362733
sum(ll_clean$tl_id_1 %in% tl_clean$tl_id) 

dim(ll_clean_ext)

test1 <- 
  full_join( ll_clean_ext, t_clean_1,   by=c("t_id_1"="t_id_1")  )   

dim(test1)

test1 <- 
  full_join( test1, t_clean_2,   by=c("t_id_2"="t_id_2")  )

dim(test1)


# -->  in linkage but not in textline  :   8601
sum(!(ll_clean$tl_id_1 %in% tl_clean$tl_id))  # -->  in linkage but not in textline  :   8601
test1 <- ll_clean[!(ll_clean$tl_id_1 %in% tl_clean$tl_id),] %>% head()



sum(!(tl_clean$tl_id %in% ll_clean$tl_id_1))  # -->  in linkage but not in textline1 : 167266
sum(!(tl_clean$tl_id %in% ll_clean$tl_id_2))  # -->  in linkage but not in textline2 : 161382
sum(!(tl_clean$tl_id %in% 
        c(ll_clean$tl_id_2, ll_clean$tl_id_1))) # -->  in linkage but not in textline2 : 156519











ll_clean_ext <- ll_clean

ll_clean_ext   %<>%  
  full_join( t_clean_1,   by=c("t_id_1"="t_id_1")  )  

ll_clean_ext %<>% 
  full_join( t_clean_2,  by=c("t_id_2"="t_id_2")  ) 

ll_clean_ext %<>% 
  full_join( tl_clean_1, by=c("tl_id_1"="tl_id_1")) 

ll_clean_ext %<>% 
  full_join( tl_clean_2, by=c("tl_id_2"="tl_id_2")) 












### write neat little sqlite databases - one for each country
countries <- 
  t_raw  %>% 
  select(t_country) %>% 
  distinct() %>% 
  unlist %>% 
  c("all")

if ( files_need_update ) {
  dir.create("sqlite", showWarnings = F)
  
  pb <- create_progress_bar("text")
  pb$init(length(countries))
  for ( country in countries ){
    
    # create db
    path <- paste0("sqlite/",country,"_",db_version,".sqlite")
    suppressWarnings(try( file.remove(path) , silent = TRUE ))
    db <- 
      src_sqlite(
        path, 
        create = TRUE
      )
    if ( country == "all" ) country <- ""
    
    # fill with data
    dbSendQuery(db$con, sql("DROP TABLE IF EXISTS texts"))
    text <- 
      t_raw  %>% 
      filter( grepl(country, .$t_country) )  %>% 
      copy_to(db, ., name = "texts", temporary = FALSE)
    
    dbSendQuery(db$con, sql("DROP TABLE IF EXISTS textlines"))
    textlines <- 
      tl_raw  %>% 
      filter( grepl(country, .$tl_id) )  %>% 
      copy_to(db, ., name = "textlines", temporary = FALSE)
    
    dbSendQuery(db$con, sql("DROP TABLE IF EXISTS linkage"))
    linkage <- 
      ll_raw %>% 
      filter( grepl(country, .$ll_tl_id1) )  %>% 
      copy_to(db, ., name = "linkage", temporary = FALSE)
    
    dbSendQuery(db$con, sql("DROP TABLE IF EXISTS linkage_view"))
    linkage_view <- 
      ll_clean_ext %>% 
      filter( grepl(country, .$t_id_1) )  %>% 
      copy_to(db, ., name = "linkage_view", temporary = FALSE)
    
    pb$step()
  }
}





