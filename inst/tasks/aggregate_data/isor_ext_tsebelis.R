#### script for adding tsebelis agendacontrol data to refomrs data set =========


#### setup =====================================================================

library(idep)
library(ggplot2)
library(foreign)

setwd("Z:/Gesch\xe4ftsordnungen/Database/aggregats")





#### load data =================================================================

load("Z:/Gesch\xe4ftsordnungen/Database/aggregats/isor.Rdata")
tsebelis <- 
  read.csv2("Z:/Gesch\xe4ftsordnungen/Database/external_data/Tsebelis agenda Control p105/tsebelis.csv" ) %>% 
  as_data_frame() %>% 
  factors_to_character()  %>% 
  filter(cntrshort!="" & cntrshort!="ICE") 

isor$tsb_agc  <- NULL
isor$ext_tsb_agc1 <- NULL
isor$ext_tsb_agc2 <- NULL
isor$ext_tsb_agc4 <- NULL
isor$minmaj_wds   <- NULL
isor$minmaj_wds1  <- NULL
isor$minmaj_wds2  <- NULL
isor$minmaj_wds4  <- NULL


#### DEV Options ===============================================================

if ( exists("DEV") ){
  isor <- 
    isor  %>% select(t_id, t_date, t_country, wds_clean_rel, wds_pro_maj, wds_pro_min, lns_rel, lns_chg, pro_maj, pro_min  )  
}



#### adjust data ===============================================================

#isor$t_date <- as.POSIXct(isor$t_date)

tsebelis <- 
  tsebelis %>% 
  rbind(filter(tsebelis, cntrshort=="CH")) %>% 
  factors_to_character()

tsebelis[  tsebelis$cntrshort=="CH",  ]$cntrshort <- c("SWIPARLG", "SWIGRN")
tsebelis[  tsebelis$cntrshort=="NDL",  ]$cntrshort <- "NED"
tsebelis[  tsebelis$cntrshort=="GBR",  ]$cntrshort <- "UK"


#### merge data ================================================================

tdate <- as.Date("1985-01-01")
isor$tsb_agc <- NA

countries <- unique(isor$t_country)

for(ctr in countries){
  iffer <- isor$t_country==ctr & isor$t_date <= tdate
  date  <- max(isor[iffer,]$t_date)
  iffer <- isor$t_country==ctr & isor$t_date == date
  isor$tsb_agc[iffer] <-   as.numeric(tsebelis$agenda_control[tsebelis$cntrshort==ctr])
}


#### extrapolate agenda control variables over time ============================
# 
# idea: 
# - because we have changes in min-maj over time we use this information to extrapolate TSB_AGC
# - 1985 is used as an anchor to assign TSB_AGC to our data
# - instead of deviding min-maj words by each version's length we use the anchor verions length always
#   the reason is that we 1) do not know he real extend of min-maj words at anchor but have only the TSB_AGC
#   second, we argue that the absolute number of minmaj words instead of their relative counterpart determines 
#   the relationship between min and maj - dividing by differeing lengths would couse measures to be driven by 
#   overall text lengths instead of by amount of regulations in the on or other direction


isor$minmaj_wds1 <- isor$tsb_agc * isor$wds_clean_rel / 1
isor$minmaj_wds2 <- isor$tsb_agc * isor$wds_clean_rel / 2
isor$minmaj_wds4 <- isor$tsb_agc * isor$wds_clean_rel / 4

anchors_index <- which(!is.na(isor$minmaj_wds1))
anchors       <- isor$t_id[anchors_index]

  for (k in anchors_index) {
    i <- k
    while ( empty_to_false( isor$t_country[i] == isor$t_country[i+1] ) )
    {
      isor$minmaj_wds1[i+1] <- (isor$wds_pro_maj[i+1] - isor$wds_pro_min[i+1])  + isor$minmaj_wds1[i]
      isor$minmaj_wds2[i+1] <- (isor$wds_pro_maj[i+1] - isor$wds_pro_min[i+1])  + isor$minmaj_wds2[i]
      isor$minmaj_wds4[i+1] <- (isor$wds_pro_maj[i+1] - isor$wds_pro_min[i+1])  + isor$minmaj_wds4[i]
      i <- i + 1 
    }
    i <- k
    while ( empty_to_false( isor$t_country[i] == isor$t_country[i-1] ) )
    {
      isor$minmaj_wds1[i-1] <-  isor$minmaj_wds1[i] - (isor$wds_pro_maj[i] - isor$wds_pro_min[i]) 
      isor$minmaj_wds2[i-1] <-  isor$minmaj_wds2[i] - (isor$wds_pro_maj[i] - isor$wds_pro_min[i]) 
      isor$minmaj_wds4[i-1] <-  isor$minmaj_wds4[i] - (isor$wds_pro_maj[i] - isor$wds_pro_min[i]) 
      i <- i - 1
    } 
  }

for (i in anchors_index) {
  country              <- isor$t_country[i]
  country_index        <- isor$t_country==country
  anchor_wds_clean_rel <- isor$wds_clean_rel[i] 
  isor$ext_tsb_agc1[country_index] <- isor$minmaj_wds1[country_index] / (anchor_wds_clean_rel / 1)
  isor$ext_tsb_agc2[country_index] <- isor$minmaj_wds2[country_index] / (anchor_wds_clean_rel / 2)
  isor$ext_tsb_agc4[country_index] <- isor$minmaj_wds4[country_index] / (anchor_wds_clean_rel / 4)
}


#### some cleanup ==============================================================

# round agenda control variable to 2 digits 
isor$ext_tsb_agc1 <- round(isor$ext_tsb_agc1, 2)
isor$ext_tsb_agc2 <- round(isor$ext_tsb_agc2, 2)
isor$ext_tsb_agc4 <- round(isor$ext_tsb_agc4, 2)

# drop minmaj_wds variable
isor <- isor  %>% select(-minmaj_wds1, -minmaj_wds2, -minmaj_wds4)



#### plot new variable =========================================================


p <- ggplot( isor ,  aes(x=as.POSIXct(t_date), y=ext_tsb_agc1, group=t_country, color=t_country, label = ifelse(duplicated(ctr),"",ctr) ) )
p +  geom_line(lwd=1.4) + geom_text(hjust=1.2) + theme_bw() + guides(color=FALSE) + 
  ggtitle(paste("extrapolated Tsebelis Agenda Control")) + 
  xlim(as.POSIXct("1920-01-01"), as.POSIXct("2010-01-01"))

p <- ggplot( isor ,  aes(x=as.POSIXct(t_date), y=ext_tsb_agc2, group=t_country, color=t_country, label = ifelse(duplicated(ctr),"",ctr) ) )
p +  geom_line(lwd=1.4) + geom_text(hjust=1.2) + theme_bw() + guides(color=FALSE) + 
  ggtitle(paste("extrapolated Tsebelis Agenda Control")) + 
  xlim(as.POSIXct("1920-01-01"), as.POSIXct("2010-01-01"))

p <- ggplot( isor ,  aes(x=as.POSIXct(t_date), y=ext_tsb_agc4, group=t_country, color=t_country, label = ifelse(duplicated(ctr),"",ctr) ) )
p +  geom_line(lwd=1.4) + geom_text(hjust=1.2) + theme_bw() + guides(color=FALSE) + 
  ggtitle(paste("extrapolated Tsebelis Agenda Control")) + 
  xlim(as.POSIXct("1920-01-01"), as.POSIXct("2010-01-01"))




#### saving ====================================================================

# save isor dataset
setwd("Z:/Gesch\u00e4ftsordnungen/database/aggregats")
save(isor, file="isor.Rdata")
write.dta(isor, file="isor.dta")






















