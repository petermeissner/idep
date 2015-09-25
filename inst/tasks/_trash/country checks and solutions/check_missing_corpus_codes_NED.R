# script for checking why corpus codes are missing in netherlands and how 
# this might be fixed

# packages
library(idep)
library(dplyr)
library(stringr)

# data
load("Z:/Geschäftsordnungen/CodingCorpus/DEV/CorpusCoding NED.Rdata")

# the problem: only some lines from the text are included and coded
coding  %>% 
  mutate(coded = !is.na(code) )  %>% 
  group_by(date) %>% 
  summarize(sum(coded)) %>% 
  head(15)

# transfer: no transfer data for 1971 to 1974
transfer  %>% 
  group_by(date1) %>% 
  summarize(sum(N)) %>% 
  mutate(date1 = as.character(date1))  %>% 
  filter(date1 %in%  "1971_03_31")

# transfer: there is transfer data from 1970 to 1971
transfer  %>% 
  group_by(date2) %>% 
  summarize(sum(N)) %>% 
  mutate(date2 = as.character(date2))  %>% 
  filter(date2 %in% "1971_03_31")


load("Z:/Geschäftsordnungen/CodingChanges/NED/coded changes/coded NDL-1971_03_31 VS NDL-1974_05_01.Rdata")
sort(unique(as.numeric(RESULTS$oldline)))
sort(unique(as.numeric(RESULTS$newline)))


# strange ! --> 
RESULTS %>% 
  sort_align_df(first="oldline", second="newline")  %>% 
  select(oldline, newline, oldtext, newtext, similarity, relevant)  %>% 
  htmltable( bgcolor=linkage_type_colors(linkage_type(.)) )

# texts separate --> ok
RESULTS  %>% 
  select(newline, newtext) %>% 
  mutate(newline = as.numeric(.$newline))  %>% 
  arrange(newline)  %>% 
  htmltable()


# texts separate --> ok
RESULTS  %>% 
  select(oldline, oldtext) %>% 
  mutate(oldline = as.numeric(.$oldline))  %>% 
  arrange(oldline)  %>% 
  htmltable()

# sorting? 
tmp <- 
  RESULTS %>% 
  sort_align_df(first="oldline", second="newline")   %>%
  select(oldline, newline)
tmp



### SOLUTION ###


# putting together information for table:coding
coding_1971_03_31 <- 
  RESULTS  %>% 
  filter( !is.na(oldline) ) %>% 
  distinct( oldline )  %>% 
  mutate(
    date = "1971_03_31", 
    fix = FALSE, 
    code=ifelse(relevant==0, 999, -99)  ,
    oldline = as.numeric(oldline), 
    memo = ""
  )  %>% 
  rename(lnr=oldline, text=oldtext) %>% 
  select(lnr, relevant, date, text, fix, code, memo) %>% 
  arrange(lnr) 

# putting together information for table:transfer
transfer_1971_03_31 <- 
  RESULTS %>% 
  filter(similarity > 0)  %>% 
  mutate(
    oldline = as.numeric(oldline), 
    newline = as.numeric(newline), 
    date1   = "1971_03_31",
    date2   = "1974_05_01",
    N       = seq_along(dates)[dates %in% "1971_03_31"]
  )  %>% 
  select(N, oldline, newline, date1, date2, similarity) %>% 
  arrange(oldline, newline)


# merge data
coding <-
  coding  %>% 
  filter( date!="1971_03_31" )  %>% 
  rbind( coding_1971_03_31 )
  
transfer <- 
  transfer %>% 
  filter( (date1!="1971_03_31") ) %>% 
  rbind(transfer_1971_03_31)


# save data 
save(
  coding,
  dates,
  meta,
  transfer,
  file="Z:/Geschäftsordnungen/CodingCorpus/DEV/CorpusCoding NED FIXED.Rdata"
)
















