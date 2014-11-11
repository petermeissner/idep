# script for checking link data and uploading it to server

# setting things up
rm(list = ls())
require(idep)
get_ready()




# select linkage files
link_files_select()
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
corpus_file_select()
  corpus_file_full
  corpus_file_fname
  corpus_file_path

# load corpus file
corpus_file_load()
  ls(corpus_env)
  

corpus_env$meta
names(corpus_env$coding)

corpus_env$date  <- unlist(lapply(
                        str_extract_all(corpus_env$coding$date,"\\d+"), 
                        paste, collapse="-")
                      )
corpus_env$dplus <- as.numeric(
                      match(
                        tolower(str_extract(
                          corpus_env$coding$date,
                          "[[:alpha:]]+")),
                      letters)
                      )
corpus_env$dplus <- ifelse(is.na(corpus_env$dplus), 0, corpus_env$dplus)



# meta data
fname_data       <- get_meta_from_fname(filelist_full,T)
within_text_data <- link_files_get_date(filelist_full,T)
data_texts  <- cbind(fname_data, within_text_data)
names(data_texts) <- c("t_id", "t_date", "t_dplus", "t_country", "t_daccept", "t_dpromul", "t_denact")

# text data for upload
data_lines      <- link_files_get_text(filelist_full)
names(data_lines) <- c( "tl_id", "tl_text", "tl_lnr", "tl_t_id", "tl_relevant", "tl_wds_raw", "tl_wds_clean")

# linkage data
data_linkage <- link_files_get_linkage(filelist_full)
names(data_linkage) <- c("ll_tl_id1", "ll_tl_id2", "ll_sim", "ll_sim_wd", "ll_diff", 
                         "ll_diff_wd", "ll_type", "ll_minmaj", "ll_t_id1", "ll_t_id2", 
                         "ll_tl_lnr1", "ll_tl_lnr2", "ll_coder_linkage", "ll_coder_minmaj")


# text data for testing
text_texts <- link_files_get_text_only(filelist_full,T) 
link_texts <- link_files_get_text_only(filelist_full,F) 

# checks : check that all text lines ( max(lnr) ) ar included
dtest(text_meta)

# checks : check that all text lines ( max(lnr) ) ar included
ltest(text_texts)

# checks : check that the second text of version n 
#          is equal to the first text of version n+1
#      ... which should be the case because these are 
#          supposed to be the same texts
ctest(link_texts, filelist_full)

# ?????????????????????????????
# tests for linkage
# ?????????????????????????????



# Writing results to database

system.time(SQL <- genInsertsDKU("data_texts", data_texts))
system.time(dbGetQueries(socon, SQL))

system.time(SQL <- genInsertsDKU("data_textlines", data_lines))
system.time(dbGetQueries(socon, SQL))

system.time(SQL <- genInsertsDKU("data_linelinkage", data_linkage))
system.time(dbGetQueries(socon, SQL))














