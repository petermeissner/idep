# script for downloading newest data from database and saving it to disk

# setting things up
rm(list = ls())
require(idep)
require(foreign)
get_ready()
setwd("Z:/Gesch\u00e4ftsordnungen")

socon


# listing tables
dbListTables(socon)


# getting data
system.time(textlines <- dbReadTable(socon, "view_textlines"))
head(textlines)
dim(textlines)

# getting version and last update date
version    <- max(dbReadTable(socon, "version")$versionnumber, na.rm=T)
lastupdate <- as.character(max(as.POSIXlt(c(
                    textlines$int_dupdate_texts,
                    textlines$int_dupdate_linelinkage,
                    textlines$int_dupdate_textlines
                    )), na.rm=T ))

textlines$db_version    <- version
textlines$db_lastupdate <- lastupdate


# generating filenames for STATA and R 
r_name     <- paste0("view_textlines_db_version_",version,".Rdata")
stata_name <- paste0("view_textlines_db_version_",version,".dta")

# saving to RData
save(textlines, file=r_name)

# saving to STATA
tmp <- textlines
for(i in 1:length(tmp[1,])){ print(class(tmp[,i]))  }
tmp <- 
  tmp[,-
        match(c("ll_minmaj_memo","tl_corpus_memo","tl_text"), names(tmp))
      ]
for ( i in seq_along(tmp[1,]) ) {
  if( any(class(tmp[,i])=="character") & any(nchar(tmp[,i])>200) ){
    tmp[,i] <- paste( substring(tmp[,i],0,200), " ...") 
  }
  tmp[,i] <- ifelse(tmp[,i]==""," ", tmp[,i])
}
write.dta(tmp, version=10, file=stata_name,convert.dates=F)
message("done")












