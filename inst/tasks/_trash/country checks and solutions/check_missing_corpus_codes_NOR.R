# script for checking why corpus codes are missing in netherlands and how 
# this might be fixed

# packages
library(idep)
library(plyr)
library(dplyr)
library(stringr)

# data
load("Z:/Geschäftsordnungen/CodingCorpus/DEV/CorpusCoding NOR.Rdata")


# problem: the date is 1972 instead of 1972_10_10

# ok, actually everything was coded
coding  %>% 
  mutate(coded = !is.na(code) )  %>% 
  group_by(date) %>% 
  summarize(sum(coded)) %>% 
  head(70)

# ok, there is transfer data
transfer  %>% 
  group_by(date1) %>% 
  summarize(sum(N)) %>% 
  mutate(date1 = as.character(date1))  %>% 
  filter(date1 > "1970_01_01" , date1 < "1973_01_01")

# ok, there is transfer data
transfer  %>% 
  group_by(date2) %>% 
  summarize(sum(N)) %>% 
  mutate(date2 = as.character(date2))  %>% 
  filter(date2 > "1970_01_01" , date2 < "1973_01_01")


### Solution: replacing 1972 by 1972_10_10 ### 

# ... in coding
coding$date <- revalue(coding$date, c("1972" = "1972_10_10") )

# ... in transfer
transfer$date1 <- revalue(transfer$date1, c("1972" = "1972_10_10") )
transfer$date2 <- revalue(transfer$date2, c("1972" = "1972_10_10") )

# ... in meta
meta[meta$date1=="1972",]$date1 <- "1972_10_10"
meta[meta$date2=="1972",]$date2 <- "1972_10_10"

# ... in dates
dates[dates=="1972"] <- "1972_10_10"



# save results
save(
  meta,
  dates, 
  coding,
  transfer,
  file = "Z:/Geschäftsordnungen/CodingCorpus/DEV/CorpusCoding NOR FIXED.Rdata"
)














