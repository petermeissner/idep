#### script for adding tsebelis agendacontrol data to refomrs data set =========


#### setup =====================================================================

library(idep)

setwd("Z:/Geschäftsordnungen/Database/aggregats")





#### load data =================================================================

load("Z:/Geschäftsordnungen/Database/aggregats/reforms.Rdata")
tsebelis <- 
  read.csv2("Z:/Geschäftsordnungen/Database/external_data/Tsebelis agenda Control p105/tsebelis.csv" ) %>% 
  as_data_frame() %>% 
  factors_to_character()  %>% 
  filter(cntrshort!="" & cntrshort!="ICE") 


reforms <- 
  reforms  %>% select(t_id, t_date, t_country, wds_clean_rel, wds_pro_maj, wds_pro_min, lns_rel, lns_chg, pro_maj, pro_min  )



#### adjust data ===============================================================

reforms$t_date <- as.POSIXlt(reforms$t_date)

tsebelis <- 
  tsebelis %>% 
  rbind(filter(tsebelis, cntrshort=="CH")) %>% 
  factors_to_character()

tsebelis[  tsebelis$cntrshort=="CH",  ]$cntrshort <- c("SWIPARLG", "SWIGRN")
tsebelis[  tsebelis$cntrshort=="NDL",  ]$cntrshort <- "NED"
tsebelis[  tsebelis$cntrshort=="GBR",  ]$cntrshort <- "UK"


#### merge data ================================================================

tdate <- as.POSIXct("1985-01-01 00:00:00")
reforms$ext_tsb_agc <- NA

countries <- unique(reforms$t_country)

for(ctr in countries){
  iffer <- reforms$t_country==ctr & reforms$t_date <= tdate
  date  <- max(reforms[iffer,]$t_date)
  iffer <- reforms$t_country==ctr & reforms$t_date == date
  reforms$ext_tsb_agc[iffer] <-   as.numeric(tsebelis$agenda_control[tsebelis$cntrshort==ctr])
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

reforms$minmaj_wds <- reforms$ext_tsb_agc * reforms$wds_clean_rel 

  for (k in which(!is.na(reforms$minmaj_wds))) {
    i <- k
    while ( empty_to_false( reforms$t_country[i] == reforms$t_country[i+1] ) )
    {
      reforms$minmaj_wds[i+1] <- (reforms$wds_pro_maj[i+1] - reforms$wds_pro_min[i+1])  + reforms$minmaj_wds[i]
      i <- i + 1 
    }
    i <- k
    while ( empty_to_false( reforms$t_country[i] == reforms$t_country[i-1] ) )
    {
      reforms$minmaj_wds[i-1] <-  reforms$minmaj_wds[i] - (reforms$wds_pro_maj[i] - reforms$wds_pro_min[i]) 
      i <- i - 1
    } 
  }

reforms$ext_tsb_agc <- reforms$minmaj_wds / reforms$wds_clean_rel

# -> 


#### plot new variable =========================================================

library(ggplot2)

p <- ggplot( reforms ,  aes(x=t_date, y=ext_tsb_agc, group=t_country, color=t_country, label = ifelse(duplicated(t_country),"",t_country) ) )
p +  geom_line(lwd=1.4) + geom_text(hjust=1.2) + theme_bw() + guides(color=FALSE) + 
  ggtitle("extrapolated Tsebelis Agenda Control")























