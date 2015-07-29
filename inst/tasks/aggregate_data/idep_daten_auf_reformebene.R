# author: pm
# Script, dass die IDEP Daten aggregiert
# um Minderheiten und Mehrheiten freundliche Reformen damit analysieren zu können



#### preparations ====

library(idep)
library(stringr)
library(dplyr)
library(magrittr)

data_path  <- "z:/geschäftsordnungen/database/extracts/"




#### loading data ====

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

# remove stuff
rm(data_path)
rm(fname)





#### aggregation of data ====

reforms <- as_data_frame(texts)




## adding length variables
lines <-  group_by(lines, t_id )

tmp <- 
  lines %>% summarize( 
              lines_all     = n() ,
              wds_raw_all   = sum(tl_wds_raw),
              wds_clean_all = sum(tl_wds_clean)
            )
reforms <- 
  join(reforms, tmp) %>% 
  as_data_frame()

tmp <- 
  lines %>% 
  filter( tl_relevant==1 ) %>% 
  summarize( 
    lines_rel     = n() ,
    wds_raw_rel   = sum(tl_wds_raw),
    wds_clean_rel = sum(tl_wds_clean)
  )
reforms <- 
  join(reforms, tmp) %>% 
  as_data_frame()




## adding difference variables
linkage1 <-  group_by(linkage, ll_t_id1)
linkage2 <-  group_by(linkage, ll_t_id2)



# ... change  
  tmp <- 
    linkage2  %>% 
    filter(ll_type=="change") %>% 
    summarize(
      wds_diff_chg = sum(ll_diff_wd),
      diff_chg = mean(ll_diff),
      wds_sim_chg = sum(ll_sim_wd),
      sim_chg = mean(ll_sim),
      pro_maj_chg = sum(ll_minmaj_code==1),
      pro_min_chg = sum(ll_minmaj_code==2),
      pro_non_chg = sum(ll_minmaj_code==0),
      wds_pro_maj_chg = sum((ll_minmaj_code==1)*ll_diff_wd),
      wds_pro_min_chg = sum((ll_minmaj_code==2)*ll_diff_wd),
      wds_pro_non_chg = sum((ll_minmaj_code==0)*ll_diff_wd)
    )  %>% 
    rename(t_id = ll_t_id2)

  reforms <- 
    join(reforms, tmp) %>% 
    as_data_frame()

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
      wds_diff_ins = sum(ll_diff_wd),
      diff_ins = mean(ll_diff),
      pro_maj_ins = sum(ll_minmaj_code==1),
      pro_min_ins = sum(ll_minmaj_code==2),
      pro_non_ins = sum(ll_minmaj_code==0),
      wds_pro_maj_ins = sum((ll_minmaj_code==1)*ll_diff_wd),
      wds_pro_min_ins = sum((ll_minmaj_code==2)*ll_diff_wd),
      wds_pro_non_ins = sum((ll_minmaj_code==0)*ll_diff_wd)
    )  %>% 
    rename(t_id = ll_t_id2)
    
  reforms <- 
    join(reforms, tmp) %>% 
    as_data_frame()

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
    wds_diff_del = sum(ll_diff_wd),
    diff_del = mean(ll_diff),
    pro_maj_del = sum(ll_minmaj_code==1),
    pro_min_del = sum(ll_minmaj_code==2),
    pro_non_del = sum(ll_minmaj_code==0),
    wds_pro_maj_del = sum((ll_minmaj_code==1)*ll_diff_wd),
    wds_pro_min_del = sum((ll_minmaj_code==2)*ll_diff_wd),
    wds_pro_non_del = sum((ll_minmaj_code==0)*ll_diff_wd)
  )  %>% 
  rename(t_id = ll_t_id1)

reforms <- 
  join(reforms, tmp) %>% 
  as_data_frame()

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
 
reforms$pro_maj     <- reforms$pro_maj_chg + reforms$pro_maj_ins + reforms$pro_maj_del
reforms$pro_min     <- reforms$pro_min_chg + reforms$pro_min_ins + reforms$pro_min_del
reforms$pro_non     <- reforms$pro_non_chg + reforms$pro_non_ins + reforms$pro_non_del
reforms$wds_pro_maj <- reforms$wds_pro_maj_chg + reforms$wds_pro_maj_ins +reforms$wds_pro_maj_del
reforms$wds_pro_min <- reforms$wds_pro_min_chg + reforms$wds_pro_min_ins +reforms$wds_pro_min_del
reforms$wds_pro_non <- reforms$wds_pro_non_chg + reforms$wds_pro_non_ins +reforms$wds_pro_non_del

setwd(Z:/Ge)

        

# adding min_maj variables
for(i in seqalong(reforms))
{
  # pro majority / minority # make sure to get change, del AND ins
  maj_del <- 
    linkage %>% 
    filter(iffer_ll1(i) & ll_type=="deletion" & ll_minmaj_code==1) %>% 
    dim() %>% 
    extract(1)
  maj_ins <- 
    linkage %>% 
    filter(iffer_ll2(i) & ll_type=="insertion"  & ll_minmaj_code==1) %>% 
    dim() %>% 
    extract(1)
  maj_chg <- 
    linkage %>% 
    filter(iffer_ll2(i) & ll_type=="change"  & ll_minmaj_code==1) %>% 
    dim() %>% 
    extract(1)
  reforms$pro_maj_all[i]  <- maj_chg + maj_ins + maj_del
  reforms$pro_maj_ins[i]  <- maj_ins
  reforms$pro_maj_del[i]  <- maj_del
  reforms$pro_maj_chg[i]  <- maj_chg
  
  min_del <- 
    linkage %>% 
    filter(iffer_ll1(i) & ll_type=="deletion" & ll_minmaj_code==2) %>% 
    dim() %>% 
    extract(1)
  min_ins <- 
    linkage %>% 
    filter(iffer_ll2(i) & ll_type=="insertion"  & ll_minmaj_code==2) %>% 
    dim() %>% 
    extract(1)
  min_chg <- 
    linkage %>% 
    filter(iffer_ll2(i) & ll_type=="change"  & ll_minmaj_code==2) %>% 
    dim() %>% 
    extract(1)
  reforms$pro_min_all[i]  <- min_chg + min_ins + min_del
  reforms$pro_min_ins[i]  <- min_ins
  reforms$pro_min_del[i]  <- min_del
  reforms$pro_min_chg[i]  <- min_chg
    
  none_del <- 
    linkage %>% 
    filter(iffer_ll1(i) & ll_type=="deletion" & ll_minmaj_code==0) %>% 
    dim() %>% 
    extract(1)
  none_ins <- 
    linkage %>% 
    filter(iffer_ll2(i) & ll_type=="insertion"  & ll_minmaj_code==0) %>% 
    dim() %>% 
    extract(1)
  none_chg <- 
    linkage %>% 
    filter(iffer_ll2(i) & ll_type=="change"  & ll_minmaj_code==0) %>% 
    dim() %>% 
    extract(1)
  reforms$pro_none_all[i]  <- none_chg + none_ins + none_del
  reforms$pro_none_ins[i]  <- none_ins
  reforms$pro_none_del[i]  <- none_del
  reforms$pro_none_chg[i]  <- none_chg
}  
  


reforms %>% select(1,22:length(reforms[1,]))































