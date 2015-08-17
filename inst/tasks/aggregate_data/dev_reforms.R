### MAKE THIS WORK FOR group_by LL and CORPUS ###

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

