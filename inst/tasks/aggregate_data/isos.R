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


#### creating isos data set ====================================================
 
### getting all spans 
#   (by expanding time spans to single days, 
#    match both data sources on them, 
#    aggregate if possible
#   )

isos <- NULL 
countries <- unique(c(erd$ctr, isor$ctr))
 
for (i in countries ) {
  df1 <- 
    isor  %>% 
    filter(ctr==i) %>% 
    select(so_id, so_start, so_end) %>% 
    as.data.frame()
  
  df2 <- 
    erd  %>% 
    filter(ctr==i) %>% 
    select(cab_id, cab_in, cab_out) %>% 
    as.data.frame()

  isos_tmp     <- merger_for_time_spans(df1, df2) %>% arrange(span_start, so_id, cab_id)  
  isos_tmp$ctr <- i
  isos_tmp$span_id <- isos_tmp$span_id + max(max(isos$span_id, na.rm = TRUE, warn=FALSE), max(isos_tmp$span_id))
  isos <- rbind(isos, isos_tmp )
}
  

#### adding dates of erd and isom to isos
isos <- 
  isos  %>% 
  left_join(isor[, c("so_start", "so_end", "so_id")]) %>% 
  left_join(erd[, c("cab_in", "cab_out", "cab_id")])  

#### decide which spans have a reform // outcome of span 
isos$span_out   <- ifelse(isos$span_end==isos$so_end, 1, 0)
  
### what are checks / what are critical cases to test against ???? 
isos  %>% filter(is.na(so_id)|is.na(cab_id))  %>% head(500)



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























