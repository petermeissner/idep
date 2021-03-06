# script for checking link data and uploading it to server

# setting things up
rm(list = ls())
require(idep)
library(dplyr)
get_ready()
setwd("Z:/Geschäftsordnungen/CodingChanges/NED/coded changes")

# select linkage files
link_files_select( paste0(getwd(), "/", dir(pattern="coded.*\\.Rdata")) )
  head(filelist_full,  1)
  head(filelist_fname, 1)
  head(filelist_path,  1)
  country_path
  country

# load linkage files
link_files_load(filelist_full)
  linkage_env
  ls(linkage_env001)


setwd("Z:/Geschäftsordnungen")
# select corpus file
corpus_file_select("Z:/Geschäftsordnungen/CodingCorpus/CorpusCoding NED.Rdata")
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
data_lines      <- link_files_get_text(linkage_env)
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

# ?????????????????????????????
# tests for linkage
# ?????????????????????????????

# data.frames to tbl_df
data_texts   <- tbl_df(data_texts)
data_lines   <- tbl_df(data_lines)
data_linkage <- tbl_df(data_linkage)


# re-establish connection
get_ready()

# Writing results to database
message("data_texts")
system.time(SQL <- genInsertsDKU("data_texts", data_texts))
system.time(dbGetQueries(socon, SQL))

message("data_textlines")
system.time(SQL <- genInsertsDKU("data_textlines", data_lines))
system.time(dbGetQueries(socon, SQL))

message("data_linkage")
system.time(SQL <- genInsertsDKU("data_linelinkage", data_linkage))
system.time(dbGetQueries(socon, SQL))


sqlVersionTag( con=socon,
               shortdesc=paste0(country,": texts, textlines, linelinkage data upload by check_link_data() [idep package]"))

# MAKE SURE TO generate new temporary tables in db!!!!!











