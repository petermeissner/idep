# script for checking link data and uploading it to server

# setting things up
rm(list = ls())
require(idep)
library(dplyr)
get_ready()
setwd("Z:/Gesch\u00e4ftsordnungen")

# select linkage files
lfiles <- c(  "Z:/Geschäftsordnungen/CodingChanges/LUX/coded LUX-1985_07_09 VS LUX-1991_01_01.Rdata",
              "Z:/Geschäftsordnungen/CodingChanges/LUX/coded LUX-1991_01_01 VS LUX-1993_01_05.Rdata"     )
link_files_select(lfiles)
  head(filelist_full,  1)
  head(filelist_fname, 1)
  head(filelist_path,  1)
  country_path
  country

# load linkage files
link_files_load(filelist_full)
  linkage_env
  ls(linkage_env001)


# select corpus file
corpus_file_select("Z:/Geschäftsordnungen/CodingCorpus/CorpusCoding LUX.Rdata")
  corpus_file_full
  corpus_file_fname
  corpus_file_path

# load corpus file
corpus_file_load()
  ls(corpus_env)
  
# preapre data for matching
corpus_data_prepare()


# set the right wd
setwd("Z:/Geschäftsordnungen/AggregatedData")

# meta data
fname_data       <- get_meta_from_fname(filelist_full,T)
within_text_data <- link_files_get_date(filelist_full,T)
data_texts  <- cbind(fname_data, within_text_data)
text_meta   <- data_texts
names(data_texts) <- c("t_id", "t_date", "t_dplus", "t_country", "t_daccept", "t_dpromul", "t_denact")

# text data for upload
data_lines      <- link_files_get_text(filelist_full)
  matcher                <- match(data_lines$id, corpus_env$coding$id)
  data_lines$corpus_code <- corpus_env$coding$code[ matcher ]
  data_lines$corpus_memo   <- ifelse( grepl("#§# autocode",corpus_env$coding$memo[ matcher ]), 
                                  "", corpus_env$coding$memo[ matcher ] ) 
  names(data_lines) <- c( "tl_id", "tl_text", "tl_lnr", "tl_t_id", "tl_relevant", "tl_wds_raw",           
                          "tl_wds_clean", "tl_corpus_code", "tl_corpus_memo")


# linkage data
system.time(data_linkage <- link_files_get_linkage() )
names(data_linkage) <- c("ll_tl_id1", "ll_tl_id2", "ll_sim", "ll_sim_wd", "ll_diff", 
                         "ll_diff_wd", "ll_type", "ll_t_id1", "ll_t_id2", 
                         "ll_tl_lnr1", "ll_tl_lnr2", "ll_minmaj_code", "ll_minmaj_coder",
                         "ll_minmaj_memo", "ll_linkage_coder")


# text data for testing
text_texts <- link_files_get_text_only(linkage_env,T) 
link_texts <- link_files_get_text_only(linkage_env,F) 

# checks : dates were extracted as expected? 
dtest(text_meta)

# checks : check that all text lines ( max(lnr) ) ar included
ltest(text_texts)

# checks : check that the second text of version n 
#          is equal to the first text of version n+1
#      ... which should be the case because these are 
#          supposed to be the same texts
ctest <- ctest(link_texts, filelist_full)
ctest



####################################################################

# get LNR with wrong text / good text
index <- grep("1985_07_09 VS 1991_01_01 //  1991_01_01 VS 1993_01_05", unlist(lapply(ctest$problems, `[[`, "name")))
LNR   <- str_extract(ctest$problems[[index]]$t2, "\\d{3}")


# get good text for lines
load("Z:/Geschäftsordnungen/CodingChanges/LUX/coded LUX-1991_01_01 VS LUX-1993_01_05.Rdata")

iffer <- RESULTS$oldline %in% LNR
RESULTS[iffer,]$oldline == LNR

TEXT     <- RESULTS[iffer, "oldtext"]
TEXTorig <- RESULTS[iffer, "Aorigtext"]


# replace bad text 
load("Z:/Geschäftsordnungen/CodingChanges/LUX/coded LUX-1985_07_09 VS LUX-1991_01_01.Rdata")

iffer <- RESULTS$newline %in% LNR
RESULTS[iffer,]$newline == LNR

RESULTS[iffer, "newtext"] <- TEXT
RESULTS[iffer, "Borigtext"] <- TEXTorig


# save corrected file 
save(RESULTS, file="Z:/Geschäftsordnungen/CodingChanges/LUX/coded LUX-1985_07_09 VS LUX-1991_01_01.Rdata")





































