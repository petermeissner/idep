# script for solving individual data problems

# solving divided relevance problems for AUT


#### relavence checks ==========================================================

# corpus code = 999 but relevant = 1 ==> relevant <- 0
data_linkage1 <- 
  data_linkage %>% 
  select(ll_tl_id1, ll_tl_id2, ll_type)  %>% 
  mutate(tl_id = ll_tl_id1)

data_linkage2 <- 
  data_linkage %>% 
  select(ll_tl_id1, ll_tl_id2, ll_type)  %>% 
  mutate(tl_id = ll_tl_id2)

type_one <- 
  data_lines  %>% 
  filter( (tl_relevant==1 & tl_corpus_code==999) ) %>% 
  select(tl_id, tl_relevant, tl_corpus_code, tl_text)

type_one_fw <- 
  data_lines  %>% 
  filter( (tl_relevant==1 & tl_corpus_code==999) ) %>% 
  inner_join(data_linkage1, by="tl_id") %>% 
  select(tl_id, tl_relevant, tl_corpus_code, ll_tl_id1, ll_tl_id2, ll_type) 

type_one_bw <- 
  data_lines  %>% 
  filter( (tl_relevant==1 & tl_corpus_code==999) ) %>% 
  inner_join(data_linkage2, by="tl_id") %>% 
  select(tl_id, tl_relevant, tl_corpus_code, ll_tl_id1, ll_tl_id2, ll_type) 

type_one_infos <- rbind(type_one_fw, type_one_bw)
type_one_infos <- type_one_infos[order(type_one_infos$tl_id, type_one_infos$ll_tl_id1),]

for ( i in seqalong(type_one) ){
  if ( type_one$tl_id[i] %in% type_one_infos$tl_id ) {
    data_lines[data_lines$tl_id == type_one$tl_id[i], ]$tl_relevant <- 0 
    data_linkage <- data_linkage[ !(data_linkage$ll_tl_id1 == type_one$tl_id[i] | data_linkage$ll_tl_id2 == type_one$tl_id[i]), ] 
  }
}


# corpus code != 999 but relevant = 0
data_linkage1 <- 
  data_linkage %>% 
  select(ll_tl_id1, ll_tl_id2, ll_type)  %>% 
  mutate(tl_id = ll_tl_id1)

data_linkage2 <- 
  data_linkage %>% 
  select(ll_tl_id1, ll_tl_id2, ll_type)  %>% 
  mutate(tl_id = ll_tl_id2)

type_two <- 
  data_lines  %>% 
  filter( (tl_relevant==0 & tl_corpus_code!=999) ) %>% 
  select(tl_id, tl_relevant, tl_corpus_code, tl_text)

type_two_fw <- 
  data_lines  %>% 
  filter( (tl_relevant==0 & tl_corpus_code!=999) ) %>% 
  inner_join(data_linkage1, by="tl_id") %>% 
  select(tl_id, tl_relevant, tl_corpus_code, ll_tl_id1, ll_tl_id2, ll_type) 

type_two_bw <- 
  data_lines  %>% 
  filter( (tl_relevant==0 & tl_corpus_code!=999) ) %>% 
  inner_join(data_linkage2, by="tl_id") %>% 
  select(tl_id, tl_relevant, tl_corpus_code, ll_tl_id1, ll_tl_id2, ll_type) 

type_two_infos <- rbind(type_two_fw, type_two_bw)
type_two_infos <- type_two_infos[order(type_two_infos$tl_id, type_two_infos$ll_tl_id1),]

write.csv(type_two, paste0(ctr,".csv"))
write.csv(type_two_infos, paste0(ctr,"_infos.csv"))



