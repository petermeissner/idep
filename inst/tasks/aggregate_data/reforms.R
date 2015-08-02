# author: pm
# Script, dass die IDEP Daten aggregiert
# um Minderheiten und Mehrheiten freundliche Reformen damit analysieren zu k?nnen



#### preparations ==============================================================

library(idep)
library(stringr)
library(dplyr)
library(magrittr)
library(foreign)
library(reshape2)

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



# ... change  
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
  tmp[is.na(tmp)] <- 0

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
  tmp[is.na(tmp)] <- 0
  
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
  )  %>% 
  rename(t_id = ll_t_id1) %>% 
  left_join(reforms[,"t_id"], .)
tmp[is.na(tmp)] <- 0

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



#### setting NA ================================================================
# names(reforms)

reforms[
  reforms$t_id %in% firstids,
  which(colnames(reforms)=="lns_mdf"):
    which(colnames(reforms)=="wds_pro_non")
  ] <- NA

reforms[
  grep("^SWI", reforms$t_id),
  grep("pro_", colnames(reforms))
  ] <- NA



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


# lines for code_scheme
tmp <- 
  aggregate(
    lines_agg$tl_wds_clean, 
    by   = list(lines_agg$t_id, ccode_corpus_recode(lines_agg$tl_corpus_code)), 
    FUN  = length
  )
names(tmp) <- c("t_id","corp_agg","lns_corp_agg")
tmp <- reshape(tmp,  idvar="t_id", timevar="corp_agg", direction="wide", sep="_")
tmp[is.na(tmp)] <- 0

reforms <- left_join(reforms, tmp)


# wds for code_scheme
tmp <- 
  aggregate(
    lines_agg$tl_wds_clean, 
    by    = list(lines_agg$t_id, ccode_corpus_recode(lines_agg$tl_corpus_code)), 
    FUN   = sum,
    na.rm = TRUE
  )
names(tmp) <- c("t_id","corp_agg","wds_corp_agg")
tmp <- reshape(tmp,  idvar="t_id", timevar="corp_agg", direction="wide", sep="_")
tmp[is.na(tmp)] <- 0

reforms <- left_join(reforms, tmp)


  


#### saving ====================================================================

# save overview HTML
setwd("Z:/Gesch?ftsordnungen/database/outputs")
htmltable(reforms, file=paste0("reforms.htm"))

# save reforms dataset
setwd("Z:/Gesch?ftsordnungen/database/aggregats")
save(reforms, file="reforms.Rdata")
write.dta(reforms, file="reforms.dta")

































