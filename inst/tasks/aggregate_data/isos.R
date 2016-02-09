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


### add minimum date to isor to serve as proxy for reform acceptance
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

### split spans whenever a reform happened
isos_split <- NULL
for( i in seq_dim1(isos)){
  tmp      <- isos[i,]
  tmp_ctr  <- tmp$ctr
  tmp_soid <- tmp$so_id
  
  spl <- 
    isor %>% 
    filter(
      so_mindate %within% interval(tmp$span_start, tmp$span_end),
      ctr   == tmp_ctr,
      so_id != tmp_soid
    ) %>% 
    select(
      so_mindate,
      so_id
    )
  
  tmp_spl <- 
    split_timespan_after(
      start     = tmp$span_start, 
      end       = tmp$span_end,
      splitdate = spl$so_mindate
    )
  
  res <- 
    tmp[rep(1, dim1(tmp_spl)),] 
  
  res$span_start     = tmp_spl$start
  res$span_end       = tmp_spl$end
  
  isos_split <- rbind(isos_split, res)
  if((i %% 100)==0){
    cat(".")
  }
}

#### decide which spans have a reform // outcome of span 
for(ctri in countries){
  isos_split$span_outcome[isos_split$ctr==ctri] <- 
    as.integer(
      isos_split$span_end[isos_split$ctr==ctri] %in% 
      isor$so_mindate[isor$ctr==ctri]
    )  
}






#### add other variables =======================================================

erd_pg <- 
  erd  %>% 
  left_join(cabinets, by="erd_pg_mp_matcher")   %>% 
  mutate(
    country = country.x,
    ctr     = ctr.x
  ) %>% 
  select(-country.x, -country.y, -ctr.x, -ctr.y, -ctr, -cab_in, - cab_out)
  

isos_split <- 
  isos_split %>% 
  left_join(erd_pg)

isor_tmp <- 
  isor  %>% 
  select(-ctr, so_start, -so_end, -so_start, -erd_cab_id, -country)

isos_split <- 
  isos_split  %>% 
  left_join(isor_tmp)




#### adding majority requirement and veto points 

maj_req  <- maj_req %>% select(-ctr)
veto_pts <- veto_pts %>% select(-ctr)

isos_split <- 
  isos_split  %>% 
  left_join(maj_req)
isos <- 
  isos_split  %>% 
  left_join(veto_pts)

# isos_split$veto_pts
# isos_split$maj_req




#### saving to disk ============================================================

save(      isos_split, file = "isos.Rdata")
isos_stata <- as.data.frame(isos_split)
write.dta( isos_stata, file = "isos.dta")




















