# script for making a span data set 
# with all variables in isom

# script for joining / merging erd, isor, parlgov, 


#### setting things up =========================================================

setwd("z:/gesch\u00e4ftsordnungen/database/aggregats/")  

library(idep) 
library(dplyr)
library(foreign)


#### loading data ==============================================================


# isor
load("isor.Rdata")
isor[,1:8]

isor  <- 
  isor  %>% 
  rename(
    so_id      = t_id, 
    so_start   = t_date,
    so_end     = t_date_lead,
    so_dplus   = t_dplus,
    so_daccept = t_daccept, 
    so_dpromul = t_dpromul, 
    so_denact  = t_denact
  )

last_so <- 
  isor %>% 
  arrange(so_id)  %>% 
  group_by(ctr)  %>% 
  summarise(id=last(so_id), last(so_end)) %>% 
  `[[`("id")

isor[isor$so_id %in% last_so, "so_end"] <- Sys.Date()


# erd
load("../external_data/erd_cleaned_up.Rdata")
erd[,1:11]
erd <- 
  erd %>% 
  mutate(
    erd_cab_id = cab_id
  )

# pg / mp
load("../external_data/cmp_parlgov_cabinets_ideo_confl_volatility.Rdata")
cabinets[,1:10]





### DEV ### >>>> ===============================================================

# isor <- isor %>% filter(ctr=="deu")  %>%  select(so_id, so_start, so_end, ctr)
# erd  <- erd  %>% filter(ctr=="deu")  %>%  select(cab_id, cab_pm, cab_in, cab_out, ctr)

### DEV ### <<<< ...............................................................





#### gen merger for merging erd and isor into so-cabinet spans =================

# merge / map / match criteria is whether or not there is some kind of overlap
#
# -> 
# 
# cab_in   <= so_start <= cab_out 
# cab_in   <= so_end   <= cab_out 
# so_start <= cab_in   <= so_start
# so_start <= cab_out  <= so_start


merger <- data_frame(cab_id=character(0), so_id=character(0))

for (i in seq_len(dim(isor)[1]) ) {
  # cab_in between so_start and so_end
  so_id    <- isor$so_id[i]
  so_ctr   <- isor$ctr[i]
  so_start <- isor$so_start[i]
  so_end   <- 
    is.na(isor$so_end[i])  %>% 
    ifelse(Sys.Date(), isor$so_end[i]) %>% 
    as.Date(origin="1970-01-01")
  
  cab_ids <- 
    erd$cab_id[
      so_start <= erd$cab_in & 
        erd$cab_in <= so_end &
        erd$ctr == so_ctr] %>% 
    .[!is.na(.)]
  
  # cab_out between so_start and so_end
  cab_ids <- 
    cab_ids  %>% 
    c(
      erd$cab_id[
        so_start <= ifelse(is.na(erd$cab_out), Sys.Date(), erd$cab_out) & 
          erd$cab_out <= so_end &
          erd$ctr == so_ctr]
    ) %>% 
    .[!is.na(.)] %>% 
    unique()
  
  if( length(so_id) > 0 & length(cab_ids) > 0 ){
    merger <- rbind(merger, data_frame(cab_id=cab_ids, so_id=so_id))
  }
}

for (i in seq_len(dim(erd)[1]) ) {
  # so_start between cab_in and cab_out
  erd_id    <- erd$cab_id[i]
  erd_ctr   <- erd$ctr[i]
  erd_start <- erd$cab_in[i]
  erd_end    <- 
    is.na(erd$cab_out[i])  %>% 
    ifelse(Sys.Date(), erd$cab_out[i]) %>% 
    as.Date(origin="1970-01-01")
  
  
  so_ids <- 
    isor$so_id[ 
      erd_start <= isor$so_start & 
        isor$so_start <= erd_end &
        isor$ctr == erd_ctr
      ] %>% 
    .[!is.na(.)]
  
  # so_end between cab_in and cab_out
  so_ids <- 
    so_ids  %>% 
    c(
      isor$so_id[
        erd_start <= ifelse(is.na(isor$so_end), Sys.Date(), isor$so_end) & 
          isor$so_end <= erd_end &
          isor$ctr == erd_ctr]
    ) %>% 
    .[!is.na(.)] %>% 
    unique()
  
  if( length(so_ids) > 0 & length(erd_id) > 0 ){
    merger <- 
      rbind(
        merger, 
        data_frame(cab_id=erd_id, so_id=so_ids)
      )
  }
}

# adding uncatched ids from both
erd_ids_not_in_merger <- erd$cab_id[ !(erd$cab_id %in% merger$cab_id) ]
  if ( length(erd_ids_not_in_merger) > 0 ) {
    merger <- rbind(merger, data.frame(cab_id=erd_ids_not_in_merger, so_id=NA))
  }

so_ids_not_in_merger <- isor$so_id[ !(isor$so_id %in% merger$so_id) ]
  if ( length(so_ids_not_in_merger) > 0 ){
    merger <- rbind(merger, data.frame(cab_id=NA, so_id=so_ids_not_in_merger))
  }

# ensure uniqueness of pairs
(merger <- unique(merger) %>% arrange(so_id, cab_id))




#### merging erd and isor into isos ============================================

isos <- 
  merger  %>% 
  left_join(isor[, c("so_start", "so_end", "so_id")]) %>% 
  left_join(erd[, c("cab_in", "cab_out", "cab_id")])  %>% 
  head(50)


#### isos extending and checking ===============================================

### calculate span_start and span_end
isos$span_start <- apply(isos[, c("so_start","cab_in" )], 1, max, na.rm=TRUE)
isos$span_end   <- apply(isos[, c("so_end"  ,"cab_out")], 1, min, na.rm=TRUE)

### how to get spans in between // missing ???? 




#### decide which spans have a reform


### DEV ### >>>>

merger  %>% 
  filter(so_id=="AUT_1928-02-01.0") %>% 
  head(50)



### DEV ### <<<<


























