# script for downloading newest data from database and saving it to disk

#### setting things up =========================================================

# packages 
library(idep)
library(foreign)
library(stringr)
library(magrittr)
library(car)

# convenience paste function 
`%.%` <- function(a,b) paste0(a,b)

# set WD
setwd("Z:/Gesch\u00e4ftsordnungen/database/extracts")
getwd()



#### loading data ==============================================================

fnames <- 
  list.files(pattern="(.*pre_correct.*)(.*Rdata.*)")

ll_raw_fname  <- str_replace(grep("raw_linelinkage",fnames, value=TRUE), "pre_correct_", "")
tl_raw_fname  <- str_replace(grep("raw_textlines",fnames, value=TRUE), "pre_correct_", "")
t_raw_fname   <- str_replace(grep("raw_texts",fnames, value=TRUE), "pre_correct_", "")
ll_view_fname <- str_replace(grep("view_linelinkage",fnames, value=TRUE), "pre_correct_", "")

for(i in seq_along(fnames)) load(fnames[i])



#### corrections ===============================================================

# linelinkage raw corrections
ll_raw <- ll_raw

# textline raw corrections
tl_raw <- tl_raw

# texts corrections
t_raw <- t_raw

# linelinkage view corrections
ll_view <- ll_view



#### date of corection =========================================================

ll_view$llv_lastcorrect <- Sys.Date()
t_raw$t_lastcorrect     <- Sys.Date()
tl_raw$tl_lastcorrect   <- Sys.Date()
ll_raw$ll_lastcorrect   <- Sys.Date()


#### saving data ===============================================================

save(ll_raw , file=ll_raw_fname)
tmp <- 
  tmp[,-match(c("ll_minmaj_memo"), names(tmp))
      ] 
for ( i in seq_along(tmp[1,]) ) {
  if( any(class(tmp[,i])=="character") & any(nchar(tmp[,i])>200) ){
    tmp[,i] <- paste( substring(tmp[,i],0,200), " ...") 
  }
  tmp[,i] <- ifelse(tmp[,i]==""," ", tmp[,i])
}
report_time(write.dta(tmp, version=10, file=stata_name,convert.dates=F))

save(tl_raw , file=tl_raw_fname)
tmp <- 
  tmp[,-match(c("ll_minmaj_memo"), names(tmp))
      ] 
for ( i in seq_along(tmp[1,]) ) {
  if( any(class(tmp[,i])=="character") & any(nchar(tmp[,i])>200) ){
    tmp[,i] <- paste( substring(tmp[,i],0,200), " ...") 
  }
  tmp[,i] <- ifelse(tmp[,i]==""," ", tmp[,i])
}
report_time(write.dta(tmp, version=10, file=stata_name,convert.dates=F))

save(t_raw  , file=t_raw_fname)
tmp <- 
  tmp[,-match(c("ll_minmaj_memo"), names(tmp))
      ] 
for ( i in seq_along(tmp[1,]) ) {
  if( any(class(tmp[,i])=="character") & any(nchar(tmp[,i])>200) ){
    tmp[,i] <- paste( substring(tmp[,i],0,200), " ...") 
  }
  tmp[,i] <- ifelse(tmp[,i]==""," ", tmp[,i])
}
report_time(write.dta(tmp, version=10, file=stata_name,convert.dates=F))

save(ll_view, file=ll_view_fname)
tmp <- 
  tmp[,-match(c("ll_minmaj_memo"), names(tmp))
      ] 
for ( i in seq_along(tmp[1,]) ) {
  if( any(class(tmp[,i])=="character") & any(nchar(tmp[,i])>200) ){
    tmp[,i] <- paste( substring(tmp[,i],0,200), " ...") 
  }
  tmp[,i] <- ifelse(tmp[,i]==""," ", tmp[,i])
}
report_time(write.dta(tmp, version=10, file=stata_name,convert.dates=F))





