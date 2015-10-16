# author: pm
# Script, dass die IDEP Daten aggregiert
# um Minderheiten und Mehrheiten freundliche Reformen damit analysieren zu koennen



#### preparations ==============================================================

library(idep)
library(stringr)
library(dplyr)
library(magrittr)
library(foreign)
library(reshape2)
library(testthat)

if(!interactive()){
  options(error = quote({
    email_error("make isor failed")
    q(save = "no")
  }))
}

data_path  <- "z:/gesch\u00e4ftsordnungen/database/extracts/"
setwd(data_path)


# version check 
db_on_disk_version <- 
  str_extract(list.files(), "\\d+\\.\\d+") %>% 
  as.numeric()  %>% 
  max(na.rm=T)
db_on_disk_version



#### loading data ==============================================================

# pick newest view file and load it
fname <- 
  data_path  %>% 
  list.files(pattern="view_linelinkage_db_version_.*Rdata") %>% 
  tail(1) %>% 
  paste0(data_path,.)

load(fname)
view <- as_data_frame(linelinkage)
rm(linelinkage)

Encoding(view$tl_text1) <- "UTF-8"
Encoding(view$tl_text2) <- "UTF-8"


# pick newest texts file and load it
fname <- 
  data_path  %>% 
  list.files(pattern="raw_texts_db_version_.*.Rdata") %>% 
  tail(1) %>% 
  paste0(data_path,.)

load(fname)
texts <- as_data_frame(dbdat)
rm(dbdat)


# pick newest linelinkage file and load it
fname <- 
  data_path  %>% 
  list.files(pattern="raw_linelinkage_db_version_.*.Rdata") %>% 
  tail(1) %>% 
  paste0(data_path,.)

load(fname)
linkage <- as_data_frame(linelinkage)
rm(linelinkage)


# pick newest textline file and load it
fname <- 
  data_path  %>% 
  list.files(pattern="raw_textlines_db_version_.*.Rdata") %>% 
  tail(1) %>% 
  paste0(data_path,.)

load(fname)
lines <- as_data_frame(dbdat)
rm(dbdat)
lines  <-
  lines %>% 
  rename(t_id = tl_t_id)
Encoding(lines$tl_text) <- "UTF-8"

# echo db version in use
message(str_extract(fname, "db_version_\\d*\\.\\d*"))

# remove stuff
rm(data_path)
rm(fname)





#### aggregation of data =======================================================

reforms <- as_data_frame(texts)

reforms$t_date    <- as.Date(reforms$t_date)
reforms$t_denact  <- as.Date(reforms$t_denact)
reforms$t_daccept <- as.Date(reforms$t_daccept)
reforms$t_dpromul <- as.Date(reforms$t_dpromul)


firstids <- character()
for( i in unique(reforms$t_country) ) {
  firstids <- c(firstids, min(reforms$t_id[reforms$t_country==i]))
}


## adding length variables
lines <-  group_by(lines, t_id )

tmp <- 
  lines %>% summarize( 
              lns_all     = n() ,
              wds_raw_all   = sum(tl_wds_raw),
              wds_clean_all = sum(tl_wds_clean)
            )
reforms <- 
  left_join(reforms, tmp) 

tmp <- 
  lines %>% 
  filter( tl_relevant==1 ) %>% 
  summarize( 
    lns_rel     = n() ,
    wds_raw_rel   = sum(tl_wds_raw),
    wds_clean_rel = sum(tl_wds_clean)
  )
reforms <- 
  left_join(reforms, tmp)




## adding difference variables
linkage1 <-  group_by(linkage, ll_t_id1)
linkage2 <-  group_by(linkage, ll_t_id2)



# ... modifikation  
  tmp <- 
    linkage2  %>% 
    filter(ll_type=="change") %>% 
    summarize(
      lns_mdf      = n(),
      wds_mdf = sum(ll_diff_wd),
      pro_maj_mdf  = sum(ll_minmaj_code==1),
      pro_min_mdf  = sum(ll_minmaj_code==2),
      pro_non_mdf  = sum(ll_minmaj_code==0),
      wds_pro_maj_mdf = sum((ll_minmaj_code==1)*ll_diff_wd),
      wds_pro_min_mdf = sum((ll_minmaj_code==2)*ll_diff_wd),
      wds_pro_non_mdf = sum((ll_minmaj_code==0)*ll_diff_wd)
    )  %>% 
    rename(t_id = ll_t_id2) %>% 
    left_join(reforms[,"t_id"], .)

  tmp[is.na(tmp)]<-0
  
  reforms <- 
    left_join(reforms, tmp)

#   # check : change_summing_up
#     sum_of_its_parts <- tmp$wds_pro_maj_chg + tmp$wds_pro_min_chg + tmp$wds_pro_non_chg != tmp$wds_diff_chg
#     iffer <- na_to_false( sum_of_its_parts )
#     tmp[iffer,]  %>% select(-(pro_maj_chg:pro_non_chg)) # -> should be empty
#     tmp[is.na(sum_of_its_parts), ] # -> should be only SWI


# ... insertion
  tmp <- 
    linkage2  %>% 
    filter(ll_type=="insertion") %>% 
    summarize(
      wds_ins = sum(ll_diff_wd),
      lns_ins = n(),
      pro_maj_ins = sum(ll_minmaj_code==1),
      pro_min_ins = sum(ll_minmaj_code==2),
      pro_non_ins = sum(ll_minmaj_code==0),
      wds_pro_maj_ins = sum((ll_minmaj_code==1)*ll_diff_wd),
      wds_pro_min_ins = sum((ll_minmaj_code==2)*ll_diff_wd),
      wds_pro_non_ins = sum((ll_minmaj_code==0)*ll_diff_wd)
    )  %>% 
    rename(t_id = ll_t_id2) %>% 
    left_join(reforms[,"t_id"], .)
  
  tmp[is.na(tmp)]<-0
  
  reforms <- 
    left_join(reforms, tmp) 

#    # check : insertion_summing_up
# sum_of_its_parts <-tmp$wds_pro_maj_ins + tmp$wds_pro_min_ins + tmp$wds_pro_non_ins != tmp$wds_diff_ins
# iffer <- na_to_false( sum_of_its_parts )
# tmp[iffer,]  %>% select(-(pro_maj_ins:pro_non_ins))
# tmp[is.na(sum_of_its_parts), ]  %>% extract("t_id")  %>% as.data.frame()


# ... deletion
  tmp <- 
    linkage1  %>% 
    filter(ll_type=="deletion") %>% 
    summarize(
      wds_del = sum(ll_diff_wd),
      lns_del = n(),
      pro_maj_del = sum(ll_minmaj_code==1),
      pro_min_del = sum(ll_minmaj_code==2),
      pro_non_del = sum(ll_minmaj_code==0),
      wds_pro_maj_del = sum((ll_minmaj_code==1)*ll_diff_wd),
      wds_pro_min_del = sum((ll_minmaj_code==2)*ll_diff_wd),
      wds_pro_non_del = sum((ll_minmaj_code==0)*ll_diff_wd)
    ) 

  tmp <- 
    left_join(tmp, distinct(select(linkage, ll_t_id1, ll_t_id2), ll_t_id2) )  %>% 
    select(-ll_t_id1)  %>% 
    rename(t_id = ll_t_id2) %>% 
    left_join(reforms[,"t_id"], .)
  tmp[is.na(tmp)]<-0
  
  reforms <- 
    left_join(reforms, tmp)




#    # check : deletion_summing_up
# sum_of_its_parts <-tmp$wds_pro_maj_del + tmp$wds_pro_min_del + tmp$wds_pro_non_del != tmp$wds_diff_del
# iffer <- na_to_false( sum_of_its_parts )
# tmp[iffer,]  %>% select(-(pro_maj_del:pro_non_del))
# tmp[is.na(sum_of_its_parts), ]  %>% extract("t_id")  %>% as.data.frame()
  
  
# # check : no change hgas no pro-min-maj coding 
# # ... no-change ... only for checking, does not make sense
# tmp <- 
#   linkage2  %>% 
#   filter(ll_type=="no-change") %>% 
#   summarize(
#     wds_diff_non = sum(ll_diff_wd),
#     diff_non = mean(ll_diff),
#     pro_maj_non = sum(ll_minmaj_code==1),
#     pro_min_non = sum(ll_minmaj_code==2),
#     pro_non_non = sum(ll_minmaj_code==0),
#     wds_pro_maj_non = sum((ll_minmaj_code==1)*ll_diff_wd),
#     wds_pro_min_non = sum((ll_minmaj_code==2)*ll_diff_wd),
#     wds_pro_non_nopn = sum((ll_minmaj_code==0)*ll_diff_wd)
#   )  %>% 
#   rename(t_id = ll_t_id2)
 
reforms$pro_maj     <- reforms$pro_maj_mdf + reforms$pro_maj_ins + reforms$pro_maj_del
reforms$pro_min     <- reforms$pro_min_mdf + reforms$pro_min_ins + reforms$pro_min_del
reforms$pro_non     <- reforms$pro_non_mdf + reforms$pro_non_ins + reforms$pro_non_del

reforms$wds_pro_maj <- reforms$wds_pro_maj_mdf + reforms$wds_pro_maj_ins +reforms$wds_pro_maj_del
reforms$wds_pro_min <- reforms$wds_pro_min_mdf + reforms$wds_pro_min_ins +reforms$wds_pro_min_del
reforms$wds_pro_non <- reforms$wds_pro_non_mdf + reforms$wds_pro_non_ins +reforms$wds_pro_non_del

reforms$lns_chg <- reforms$lns_mdf + reforms$lns_ins + reforms$lns_del
reforms$wds_chg <- reforms$wds_mdf + reforms$wds_ins + reforms$wds_del



#### corpus codes ==============================================================

# lines 
  lines_agg <- 
    group_by(lines, t_id, tl_corpus_code ) 
  
  tmp <- 
    aggregate(
      lines_agg$tl_wds_clean, 
      by  = list(lines_agg$t_id, lines_agg$tl_corpus_code), 
      FUN = length 
    ) 
  names(tmp) <- c("t_id","corpus","lns_corp")
  tmp <- 
    reshape(tmp,  idvar="t_id", timevar="corpus", direction="wide", sep="_")  %>% 
    as_data_frame()
  tmp <- 
    left_join(reforms[, "t_id"], tmp)
  tmp[is.na(tmp)] <- 0
  
  reforms <- left_join(reforms, tmp) 

# words 
  tmp <- 
    aggregate(
      lines_agg$tl_wds_clean, 
      by  = list(lines_agg$t_id, lines_agg$tl_corpus_code), 
      FUN = sum, 
      na.rm = TRUE
    ) 
  names(tmp) <- c("t_id","corpus","wds_corp")
  tmp <- reshape(tmp,  idvar="t_id", timevar="corpus", direction="wide", sep="_")
  tmp[is.na(tmp)] <- 0
  
  reforms <- left_join(reforms, tmp)




# lines for code_scheme - topics
  agg_list <- 
    data.frame(ccode_top(lines_agg$tl_corpus_code), t_id=lines_agg$t_id)
  
  agg <- 
    aggregate(
      lines_agg$tl_wds_clean, 
      by   = as.list(agg_list) , 
      FUN  = length
    )
  
    agg_names <- grep("\\d",names(agg), value = TRUE)
  tmp <-
    reforms[,"t_id"]
    tmp[, agg_names] <- 0
  
  for (id in reforms$t_id ) {
    part <- agg[agg$t_id==id ,]
    for(an in agg_names){
      tmp[tmp$t_id == id, an] <- sum(part[part[,an], ]$x)
    } 
  }
  names(tmp) <- c("t_id", paste0("lns_corp_",names(tmp[-1])) )
  
  reforms <- left_join(reforms, tmp)


# words for code_scheme - topics
  agg_list <- 
    data.frame(ccode_top(lines_agg$tl_corpus_code), t_id=lines_agg$t_id)
  
  agg <- 
    aggregate(
      lines_agg$tl_wds_clean, 
      by    = as.list(agg_list) , 
      FUN   = sum,
      na.rm = TRUE
    )
  
    agg_names <- grep("\\d",names(agg), value = TRUE)
  tmp <-
    reforms[,"t_id"]
    tmp[, agg_names] <- 0
  
  for (id in reforms$t_id ) {
    part <- agg[agg$t_id==id ,]
    for(an in agg_names){
      tmp[tmp$t_id == id, an] <- sum(part[part[,an], ]$x)
    } 
  }
  names(tmp) <- c("t_id", paste0("wds_corp_",names(tmp[-1])) )
  
  reforms <- left_join(reforms, tmp)

# lines for code_scheme - actors
  agg_list <- 
    data.frame(ccode_act(lines_agg$tl_corpus_code), t_id=lines_agg$t_id)
  
  agg <- 
    aggregate(
      lines_agg$tl_wds_clean, 
      by   = as.list(agg_list) , 
      FUN  = length
    )
  
  agg_names <- grep("\\d",names(agg), value = TRUE)
  tmp <-
    reforms[,"t_id"]
  tmp[, agg_names] <- 0
  
  
  for (id in reforms$t_id ) {
    part <- agg[agg$t_id==id ,]
    for(an in agg_names){
      tmp[tmp$t_id == id, an] <- sum(part[part[,an], ]$x)
    } 
  }
  names(tmp) <- c("t_id", paste0("lns_corp_",names(tmp[-1])) )
  
  reforms <- left_join(reforms, tmp)


# words for code_scheme - actors
  agg_list <- 
    data.frame(ccode_act(lines_agg$tl_corpus_code), t_id=lines_agg$t_id)
  
  agg <- 
    aggregate(
      lines_agg$tl_wds_clean, 
      by    = as.list(agg_list) , 
      FUN   = sum,
      na.rm = TRUE
    )
  
  agg_names <- grep("\\d",names(agg), value = TRUE)
  tmp <-
    reforms[,"t_id"]
  tmp[, agg_names] <- 0
  
  for (id in reforms$t_id ) {
    part <- agg[agg$t_id==id ,]
    for(an in agg_names){
      tmp[tmp$t_id == id, an] <- sum(part[part[,an], ]$x)
    } 
  }
  names(tmp) <- c("t_id", paste0("wds_corp_",names(tmp[-1])) )
  
  reforms <- left_join(reforms, tmp)
  

  
    
#### modification types per corpus code ========================================

  
  # ... modification
  tmp <- 
    linkage  %>% 
    filter(ll_type=="change") %>% 
    select(ll_diff_wd, ll_tl_id2) %>%
    rename(tl_id = ll_tl_id2) %>% 
    left_join(select(lines, tl_id, t_id, tl_corpus_code)) %>% 
    group_by(t_id, tl_corpus_code) %>% 
    summarize(
      sum(ll_diff_wd)
    )
  
  names(tmp) <- c("t_id", "ccode", "mdf")
  
  tmp <- 
    reshape(as.data.frame(tmp),  idvar="t_id", timevar="ccode", direction="wide", sep="_")  %>% 
    as_data_frame()
  
  tmp[is.na(tmp)] <- 0
  names(tmp)[-1] <- paste0("wds_corp_",names(tmp)[-1])
  
  reforms <- 
    left_join(reforms, tmp)
  
  
  
  # ... insertion
  tmp <- 
    linkage  %>% 
    filter(ll_type=="insertion") %>% 
    select(ll_diff_wd, ll_tl_id2) %>%
    rename(tl_id = ll_tl_id2) %>% 
    left_join(select(lines, tl_id, t_id, tl_corpus_code)) %>% 
    group_by(t_id, tl_corpus_code) %>% 
    summarize(
      sum(ll_diff_wd)
    )
  
  names(tmp) <- c("t_id", "ccode", "ins")
  
  tmp <- 
    reshape(as.data.frame(tmp),  idvar="t_id", timevar="ccode", direction="wide", sep="_")  %>% 
    as_data_frame()
  
  tmp[is.na(tmp)] <- 0
  
  names(tmp)[-1] <- paste0("wds_corp_", names(tmp)[-1] )
  reforms <- 
    left_join(reforms, tmp)
  
  
  # ... deletion
  tmp <- 
    linkage  %>% 
    filter(ll_type=="deletion") %>% 
    select(ll_diff_wd, ll_tl_id1, ll_t_id2) %>%
    rename(tl_id = ll_tl_id1) %>% 
    left_join(select(lines, tl_id, t_id, tl_corpus_code)) 
  
  tmp <- 
    tmp  %>% 
    select(ll_t_id2, ll_diff_wd, tl_corpus_code) %>% 
    rename(t_id = ll_t_id2) %>% 
    group_by(t_id, tl_corpus_code) %>% 
    summarize(
      sum(ll_diff_wd)
    )
  
  names(tmp) <- c("t_id", "ccode", "del")

  tmp <- 
    reshape(as.data.frame(tmp),  idvar="t_id", timevar="ccode", direction="wide", sep="_")  %>% 
    as_data_frame()
  
  tmp[is.na(tmp)] <- 0
  names(tmp)[-1] <- paste0("wds_corp_",names(tmp)[-1])
  
  reforms <- 
    left_join(reforms, tmp)
  

  
#### add correct country variables =============================================
  
  # https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3 
  reforms$country <- NA
  reforms$ctr     <- reforms$t_country
  reforms$ctr[ toupper(reforms$ctr)=="DEN"]      <- tolower("DNK"      )
  reforms$ctr[ toupper(reforms$ctr)=="GER"]      <- tolower("DEU"      )
  reforms$ctr[ toupper(reforms$ctr)=="IRE"]      <- tolower("IRL"      )
  reforms$ctr[ toupper(reforms$ctr)=="NED"]      <- tolower("NLD"      )
  reforms$ctr[ toupper(reforms$ctr)=="POR"]      <- tolower("PRT"      )
  reforms$ctr[ toupper(reforms$ctr)=="SWIGRN"]   <- tolower("CHEGRN"   )
  reforms$ctr[ toupper(reforms$ctr)=="SWIPARLG"] <- tolower("CHEPARLG" )
  reforms$ctr[ toupper(reforms$ctr)=="UK"]       <- tolower("GBR"      )
  
  reforms$country[ toupper(reforms$ctr)=="AUT"      ] <- "Austria"
  reforms$country[ toupper(reforms$ctr)=="BEL"      ] <- "Belgium"
  reforms$country[ toupper(reforms$ctr)=="DNK"      ] <- "Denmark"
  reforms$country[ toupper(reforms$ctr)=="ESP"      ] <- "Spain"
  reforms$country[ toupper(reforms$ctr)=="FRA"      ] <- "France"
  reforms$country[ toupper(reforms$ctr)=="DEU"      ] <- "Germany"
  reforms$country[ toupper(reforms$ctr)=="IRL"      ] <- "Ireland"
  reforms$country[ toupper(reforms$ctr)=="ITA"      ] <- "Italy"
  reforms$country[ toupper(reforms$ctr)=="LUX"      ] <- "Luxembourg"
  reforms$country[ toupper(reforms$ctr)=="NLD"      ] <- "Netherlands"
  reforms$country[ toupper(reforms$ctr)=="NOR"      ] <- "Norway"
  reforms$country[ toupper(reforms$ctr)=="PRT"      ] <- "Portugal"
  reforms$country[ toupper(reforms$ctr)=="SWE"      ] <- "Sweden"
  reforms$country[ toupper(reforms$ctr)=="CHEGRN"   ] <- "Swiss (GRN)"
  reforms$country[ toupper(reforms$ctr)=="CHEPARLG" ] <- "Swiss (Parlg)"
  reforms$country[ toupper(reforms$ctr)=="GBR"      ] <- "United Kingdom"
  
  reforms$ctr <- tolower(reforms$ctr)
  
#### add wordiness variables ===================================================
  
  reforms$lang <- NA
  reforms$lang[reforms$ctr=="aut"      ] <- "German"
  reforms$lang[reforms$ctr=="bel"      ] <- "French"
  reforms$lang[reforms$ctr=="dnk"      ] <- "Danish"
  reforms$lang[reforms$ctr=="esp"      ] <- "Spanish"
  reforms$lang[reforms$ctr=="fra"      ] <- "French"
  reforms$lang[reforms$ctr=="deu"      ] <- "German"
  reforms$lang[reforms$ctr=="irl"      ] <- "English"
  reforms$lang[reforms$ctr=="ita"      ] <- "Italien"
  reforms$lang[reforms$ctr=="lux"      ] <- "French"
  reforms$lang[reforms$ctr=="nld"      ] <- "Dutch"
  reforms$lang[reforms$ctr=="nor"      ] <- "Norwegian"
  reforms$lang[reforms$ctr=="prt"      ] <- "Portuguese"
  reforms$lang[reforms$ctr=="swe"      ] <- "Swedish"
  reforms$lang[reforms$ctr=="chegrn"   ] <- "German"
  reforms$lang[reforms$ctr=="cheparlg" ] <- "German"
  reforms$lang[reforms$ctr=="gbr"      ] <- "English"
  
  reforms$wdns <- NA
  reforms$wdns[reforms$lang=="German"]     <- 0.9
  reforms$wdns[reforms$lang=="French"]     <- 1.01
  reforms$wdns[reforms$lang=="Danish"]     <- 1.05
  reforms$wdns[reforms$lang=="Spanish"]    <- 1.05
  reforms$wdns[reforms$lang=="English"]    <- 1
  reforms$wdns[reforms$lang=="Italien"]    <- 0.95
  reforms$wdns[reforms$lang=="Dutch"]      <- 1
  reforms$wdns[reforms$lang=="Norwegian"]  <- 0.86
  reforms$wdns[reforms$lang=="Portuguese"] <- 0.98
  reforms$wdns[reforms$lang=="Swedish"]    <- 0.86
  
  reforms$wdns_corr <- NA
  reforms$wdns_corr <- 1 / reforms$wdns
  
  reforms$wds_clean_rel_wdns_corr <- reforms$wds_clean_rel * reforms$wdns_corr

    
#### add time since last reform variable =======================================
  
  reforms <- 
    reforms  %>% 
    arrange(ctr, t_date) %>% 
    group_by(ctr) %>% 
    mutate(
      t_date_lag  = lag(t_date),
      t_date_lead = lead(t_date),
      t_snc_lst_ref = t_date - t_date_lag,
      t_to_nxt_ref  = t_date_lead - t_date
    )  

  
  
#### some cleanup ==============================================================
  
  
  # ensuring all corpus variables exist
  for (code in ccodes) {
    if ( !(paste0("wds_corp_mdf_",code) %in% names(reforms)) ) reforms[,paste0("wds_corp_mdf_",code)] <- 0
    if ( !(paste0("wds_corp_ins_",code) %in% names(reforms)) ) reforms[,paste0("wds_corp_ins_",code)] <- 0
    if ( !(paste0("wds_corp_del_",code) %in% names(reforms)) ) reforms[,paste0("wds_corp_del_",code)] <- 0
    if ( !(paste0("lns_corp_mdf_",code) %in% names(reforms)) ) reforms[,paste0("lns_corp_mdf_",code)] <- 0
    if ( !(paste0("lns_corp_ins_",code) %in% names(reforms)) ) reforms[,paste0("lns_corp_ins_",code)] <- 0
    if ( !(paste0("lns_corp_del_",code) %in% names(reforms)) ) reforms[,paste0("lns_corp_del_",code)] <- 0
    if ( !(paste0("wds_corp_",code)     %in% names(reforms)) ) reforms[,paste0("wds_corp_",code)]     <- 0
    if ( !(paste0("wds_corp_",code)     %in% names(reforms)) ) reforms[,paste0("wds_corp_",code)]     <- 0
  }
  
  # ensuring all change variables have either value or 0 
  for (var in grep("pro_|chg|mdf|ins|del",names(reforms)) ) {
    reforms[ is.na(reforms[, var] ) , var] <- 0
  }
  
  
  # ensuring all change varaibales are NA for first versions of SO
  reforms[ reforms$t_id %in% firstids,  grep("ins",colnames(reforms),value = T)  ] <- NA
  reforms[ reforms$t_id %in% firstids,  grep("del",colnames(reforms),value = T)  ] <- NA
  reforms[ reforms$t_id %in% firstids,  grep("mdf",colnames(reforms),value = T)  ] <- NA
  reforms[ reforms$t_id %in% firstids,  grep("chg",colnames(reforms),value = T)  ] <- NA
  reforms[ reforms$t_id %in% firstids,  grep("pro",colnames(reforms),value = T)  ] <- NA
  
  
  # ensuring that for Swiss there are no information on MinMaj Coding
  reforms[ grep("^SWI", reforms$t_id),  grep("pro_", colnames(reforms))          ] <- NA

  
  
#### testing ===================================================================

test_that(
  "general lengths have reasonable values",
  {
  expect_true( all(reforms$wds_raw_all   >= reforms$wds_raw_rel    ) )
  expect_true( all(reforms$wds_raw_all   >= reforms$wds_clean_all  ) )
  expect_true( all(reforms$wds_raw_rel   >= reforms$wds_clean_rel  ) )
  expect_true( all(reforms$wds_clean_all >= reforms$wds_clean_rel  ) )
  }
)

test_that(
  "change counts have reasonable values", 
  {
  expect_true( all(is_true_or_na(reforms$wds_ins <= reforms$wds_clean_rel)) )
  expect_true( all(is_true_or_na(reforms$wds_del <= reforms$wds_clean_rel)) )
  expect_true( all(is_true_or_na(reforms$wds_mdf <= reforms$wds_clean_rel)) )
  expect_true( all(is_true_or_na(with(reforms, wds_ins+wds_del+wds_mdf == wds_chg))) )
  }
)

test_that(
  "N_NAs is constant AND equal to N_country",
  {
    expect_true(
      unique( c( 
        sum(is.na(reforms$wds_mdf)), sum(is.na(reforms$wds_del)), 
        sum(is.na(reforms$wds_ins)), sum(is.na(reforms$wds_chg))
      ) ) == 
      length(unique(reforms$t_country))
    )
  }
)


test_that(
  "corpus coded lines sum up to all lines",
  {
    all(reforms$lns_all == reforms[,grep("lns_corp_\\d+", names(reforms), value=T)] %>% apply(1, sum)) 
  }
)

test_that(
  "corpus coded words sum up overall lengths",
  {
    wds_corp_rel <- 
      (grepl("(wds_corp_\\d+)",names(reforms)) & names(reforms)!="wds_corp_999")  %>% 
      reforms[, .] %>% 
      apply(1, sum)
    wds_corp_all <- 
      (grepl("(wds_corp_\\d+)",names(reforms)))  %>% 
      reforms[, .] %>% 
      apply(1, sum)
    expect_true( all(reforms$wds_clean_all == wds_corp_all) )
    expect_true( all(reforms$wds_clean_rel == wds_corp_rel) )
  }
)



#### saving ====================================================================

isor <- reforms

# save reforms dataset
setwd("Z:/Gesch\u00e4ftsordnungen/database/aggregats")

save(isor, file="isor.Rdata")
write.dta(isor, file="isor.dta")




































