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


# end dates for last observations -> max of end-of-study or start-of-so
last_so <- 
  isor %>% 
  arrange(so_id)  %>% 
  group_by(ctr)  %>% 
  summarise(id=last(so_id), last(so_end)) %>% 
  `[[`("id")

isor[isor$so_id %in% last_so, "so_end"] <- 
  apply( cbind( isor[isor$so_id %in% last_so, "so_start"], as.Date("2010-01-01")), 1, max)

# isor so_length
isor <- 
  isor  %>% 
  mutate(
    so_length = so_end - so_start
  )



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

# majority requirement
load("../external_data/maj_req.Rdata")

# veto points
load("../external_data/veto_pts.Rdata")



#### creating isos data set ====================================================
 
### getting all spans 
#   (by expanding time spans to single days, 
#    match both data sources on them, 
#    aggregate if possible
#   )

isos <- data_frame()
countries <- sort(unique(c(erd$ctr, isor$ctr)))

for (i in seq_along(countries) ) {
  ctri <- countries[i]
  df1 <- 
    isor  %>% 
    filter(ctr==ctri) %>% 
    select(so_id, so_start, so_end) %>% 
    as.data.frame()

  df2 <- 
    erd  %>% 
    filter(ctr==ctri) %>% 
    select(cab_id, cab_in, cab_out) %>% 
    as.data.frame()

  isos_tmp         <- merger_for_time_spans(df1, df2) %>% arrange(span_start, so_id, cab_id)  
  isos_tmp$ctr     <- ctri
  isos_tmp$span_id <- isos_tmp$span_id + which(sort(unique(c(erd$ctr, isor$ctr))) %in% ctri) * 10000
  isos             <- rbind(isos, isos_tmp )
}
isos <- as_data_frame(isos)

#### adding dates of erd and isom to isos
isos <- 
  isos  %>% 
  left_join(isor[, c("so_start", "so_end", "so_id")]) %>% 
  left_join(erd[, c("cab_in", "cab_out", "cab_id")])  

#### decide which spans have a reform // outcome of span 

#### DEV >>>>

isor$so_mindate <- 
  apply(
    data.frame(
      isor$so_start,
      isor$so_denact,
      isor$so_daccept,
      isor$so_dpromul
      ),
    1,
    min, na.rm=TRUE
  ) %>% 
  as.Date()


# loop initialization
isos_tmp                <- isos
isos_tmp$span_out       <- as.integer(NA)
isos_tmp$span_out_so_id <- as.character("")
splits            <- NULL 
# loop 
for( i in seq_dim1(isor) ){
  # gathering info 
  mindatei <- isor$so_mindate[i]
  ctri     <- isor$ctr[i]
  soidi    <- isor$so_id[i]
  iffer    <- 
    isos_tmp$ctr==ctri & 
    isos_tmp$span_start <= mindatei & 
    mindatei <= isos_tmp$span_end
  # splitting data set into relevant nad not
  to_be_split <- isos_tmp[  iffer , ]
  isos_tmp    <- isos_tmp[ !iffer , ]
  
  to_be_split
  soidi
  mindatei
  
  # splitting 
  tbs_length <- dim1(to_be_split) 
  if ( tbs_length == 1 & all(to_be_split$so_id %in% soidi) ){
    cat(".") # -> do nothing because change has to happen before its implementation
    isos_tmp <- rbind(isos_tmp, to_be_split)  
  }
  if ( tbs_length == 1 & !all(to_be_split$so_id %in% soidi) ){
    cat(".")
    tmp <- to_be_split
    tmp <- rbind(tmp, tmp)
    tmp[1, "span_end"]   <- mindatei
    tmp[2, "span_start"] <- mindatei
    tmp[1, "span_out"]   <- 1
    tmp[1, "span_out_so_id"]   <- soidi
    splits <- rbind(splits, tmp)
    # putting it back together
    isos_tmp <- rbind(isos_tmp, tmp)  
  }
  if ( tbs_length ==  2 ){
    if( to_be_split$span_start[2] == ){
      cat(.)
      isos_tmp <- rbind(isos_tmp, to_be_split)  
    }else{
      cat(paste0(" ", i," "))
    }
    
    
    
  }
  if ( tbs_length  >  2 ){
    cat(paste0(" ", "!"," "))
    isos_tmp <- rbind(isos_tmp, to_be_split)  
  }
}

isos_tmp <- isos_tmp %>% arrange(span_id)
isos_tmp$length = as.integer(isos_tmp$span_end-isos_tmp$span_start)
htab(isos_tmp)


#### <<<< DEV


#     - if span ends with end of so -> outcome 1
isos$span_outcome   <- ifelse(isos$span_end==isos$so_end, 1, 0) 
#     - if span ist last so, we do not know when it stops -> 0 
isos[isos$so_id %in% last_so,]$span_outcome <- 0  


### what are checks / what are critical cases to test against ???? 
isos  %>% filter( is.na(so_id) | is.na(cab_id) )  %>% head(500)



#### add other variables =======================================================

erd_pg <- 
  erd  %>% 
  left_join(cabinets, by="erd_pg_mp_matcher")   %>% 
  mutate(
    country = country.x,
    ctr     = ctr.x
  ) %>% 
  select(-country.x, -country.y, -ctr.x, -ctr.y, -ctr, -cab_in, - cab_out)
  

isos <- 
  isos %>% 
  left_join(erd_pg)

isor_tmp <- 
  isor  %>% 
  select(-ctr, so_start, -so_end, -so_start, -erd_cab_id, -country)

isos <- 
  isos  %>% 
  left_join(isor_tmp)




#### adding majority requirement and veto points 

maj_req  <- maj_req %>% select(-ctr)
veto_pts <- veto_pts %>% select(-ctr)

isos <- 
  isos  %>% 
  left_join(maj_req)
isos <- 
  isos  %>% 
  left_join(veto_pts)

# isos$veto_pts
# isos$maj_req




#### saving to disk ============================================================

save(      isos, file = "isos.Rdata")
isos_stata <- as.data.frame(isos)
write.dta( isos_stata, file = "isos.dta")




















