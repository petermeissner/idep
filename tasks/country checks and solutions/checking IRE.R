# script for checking link data and uploading it to server

# setting things up
rm(list = ls())
require(idep, quietly=T)
library(dplyr, quietly=T)
get_ready()
setwd("Z:/Gesch\u00e4ftsordnungen")

# select linkage files
folder      <- "Z:/geschäftsordnungen/CodingChanges/IRE/Majority-Minority Coded"
link_files  <- paste0(folder,"/", list.files(folder, pattern="^coded "))
link_files  <- link_files[ str_extract(link_files, "\\d{4}")>="1962" & str_extract(link_files, "\\d{4}")<="1962"]

link_files_select(link_files)
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
corpus_file <- "Z:/geschäftsordnungen/CodingCorpus/CorpusCoding IRE.Rdata"

corpus_file_select(corpus_file)
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
text_texts <- link_files_get_text_only(filelist_full,T) 
link_texts <- link_files_get_text_only(filelist_full,F) 


# checks : dates were extracted as expected? 
dtest(text_meta)

# checks : check that all text lines ( max(lnr) ) ar included
ltest(text_texts)

# checks : check that the second text of version n 
#          is equal to the first text of version n+1
#      ... which should be the case because these are 
#          supposed to be the same texts
ctest <- ctest(link_texts, filelist_full)
head(ctest)


# comparing the two versions of the 1962_10_30 version 
v1 <- 
  link_texts[[1]][c("l2","t2","r2")]  %>% 
  as.data.frame() 
names(v1) <- c("lnr","text","relevant") 

v2 <- 
  link_texts[[2]][c("l1","t1","r1")]  %>% 
  as.data.frame() 
names(v2) <- c("lnr","text","relevant") 

sum(!(v1$text %in%  v2$text))
sum(!(v2$text %in%  v1$text))

v1[!(v1$text %in%  v2$text),]
sum(!(v2$text %in%  v1$text))

htmltable(v1[ 150:160 , ])
htmltable(v2[ 150:160 , ])

## -->  two times one line in version 1 has been split into two
##      the correct version of the text is version 2



# checking which version of text has been used in corpus coding 
coding   <- corpus_env$coding
transfer <- corpus_env$transfer

coding %>% 
  filter(date=="1962-10-30", lnr > 150, lnr <= 160)  %>% 
  htmltable()

## -->  version 2 is used
##      


# having a look at linkage in coded files 
linkage_to_html(linkage_env001$RESULTS, out="test.html")










