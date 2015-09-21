# script for merging parlgov data and manifeesto data into new dataset

#### Setting things up =========================================================
library(idep)
library(foreign)
library(reshape)
library(stringr)
library(dplyr)


setwd("Z:/Geschäftsordnungen/Database/external_data")



####  loading data =============================================================
 
manifestos    <- read.csv("MPDS2013b/MPDataset_MPDS2013b.csv", as.is=TRUE) #Manifesto file, change the path to where your file is
parties       <- read.csv("ParlGov2010_12/view_party.csv", as.is=TRUE)        #ParlGov parties file, change the path to where your file is 
cabinets.temp <-read.csv("ParlGov2010_12/view_cabinet.csv", as.is=TRUE) #ParlGov cabinets file, change the path to where your file is  



#### encoding correction =======================================================

if(any(grepl("?",parties$party_name))) {
    for(i in seq_along(parties[1,]))
        if( is.character(parties[,i]) ){
            parties[,i] <- iconv(parties[,i], "utf8", "latin1")
            }
    }

if(any(grepl("?",cabinets.temp$party_name))) {
  for(i in seq_along(cabinets.temp[1,]))
    if( is.character(cabinets.temp[,i]) ){
      cabinets.temp[,i] <- iconv(cabinets.temp[,i], "utf8", "latin1")
    }
}



#### further corrections =======================================================

parties$cmp[ which(parties$party_name_short=='GERB') ] <- 80510 
parties$cmp[parties$party_id==1546 ] <- 11710
parties$cmp[parties$party_id== 376 ] <- 13001
parties$cmp[parties$party_id== 587 ] <- 15430
parties$cmp[parties$party_id== 221 ] <- 21430
parties$cmp[parties$party_id==1501 ] <- 21421
parties$cmp[parties$party_id== 990 ] <- 22951
parties$cmp[parties$party_id==1251 ] <- 22952
parties$cmp[parties$party_id== 457 ] <- 23230
parties$cmp[parties$party_id== 849 ] <- 32221
parties$cmp[parties$party_id== 465 ] <- 32230
parties$cmp[parties$party_id== 737 ] <- 32530
parties$cmp[parties$party_id==1063 ] <- 32903
parties$cmp[parties$party_id==1030 ] <- 32904
parties$cmp[parties$party_id==1979 ] <- 33091
parties$cmp[parties$party_id==1975 ] <- 33092
parties$cmp[parties$party_id== 551 ] <- 33440
parties$cmp[parties$party_id==1978 ] <- 33612
parties$cmp[parties$party_id==1630 ] <- 33910
parties$cmp[parties$party_id== 865 ] <- 41952
parties$cmp[parties$party_id==1536 ] <- 42710
parties$cmp[parties$party_id==1014 ] <- 53230
parties$cmp[parties$party_id== 915 ] <- 21426
parties$cmp[parties$party_id==1113 ] <- 21221
parties$cmp[parties$party_id== 501 ] <- 21916
parties$cmp[parties$party_id== 993 ] <- 21917
parties$cmp[parties$party_id== 310 ] <- 23114
parties$cmp[parties$party_id==  67 ] <- 32061
parties$cmp[parties$party_id== 382 ] <- 32440
parties$cmp[parties$party_id==1246 ] <- 32955
parties$cmp[parties$party_id== 251 ] <- 35520
parties$cmp[parties$party_id==1227 ] <- 41223



#### merge data sets  ==========================================================
           
# merge the party data 
manipart <- merge(parties, manifestos, by.x="cmp", by.y="party") 
         
# apply corrections to dates in ParlGov so that the two data sources match
source('external_script/correction_dates_cabinets_2014.r') 

# index variable
cabinets.temp$new_id <- paste(cabinets.temp$party_id, cabinets.temp$election_date) 

# change the format of the date
manipart$edate2<-as.Date(manipart$edate, "%m/%d/%Y") 

# index variable
manipart$new_id<-paste(manipart$party_id, manipart$edate2) 

# merge parties and cabinets
cabinets<-merge(cabinets.temp, manipart, by.x="new_id", by.y="new_id") 

# seat share
cabinets$seats_share <- (cabinets$seats / cabinets$election_seats_total) * 100 



parties <- 
  as_data_frame(cabinets) %>% 
  arrange(country_name.x, election_date, start_date, -cabinet_party) 


#### saving data ===============================================================

save(parties, file='cmp_parlgov_parties.Rdata')
write.csv(parties, 'cmp_parlgov_parties.csv')
write.dta(parties, file='cmp_parlgov_parties.dta', convert.dates = FALSE)




