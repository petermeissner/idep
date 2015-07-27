# script for checking if sending back and forth special characters to DB does work

# setting things up ====
rm(list = ls())
library(idep)
library(dplyr)

setwd("Z:/Gesch\u00e4ftsordnungen")


# choose DB ====
con <- get_ready(4)


# make data ====
text <-
  c(
    a = 
      str_c(
        str_c(letters, collapse=""), 
        str_c(LETTERS, collapse=""), 
        collapse = " ", sep=" "
      ),
    b = " ' , \" ; '''asd'",
    c = "äüöß",
    d = "\u00FF \u0152 \u0141\u0142 \u2013 \u2014"
  )
table <- 
  data.frame(
    numbers_int = 1:4, 
    numbers_dbl = 1:4/9, 
    time        = Sys.time(),
    text  , 
    stringsAsFactors = FALSE
  )


# write data ====
dbRemoveTable(con, "encoding_test_auto")
dbWriteTable(con, "encoding_test_auto", table)
dbReadTable(con, "encoding_test_auto")


# read back and test data  ====
dbReadTable(con, "encoding_test_auto")
dbReadTable(con, "encoding_test_auto")$text == text

back <- dbGetQuery(con, "SELECT text FROM encoding_test_auto")$text
Encoding(back) <- c("latin1","latin1","latin1","UTF-8")
back
dbGetQuery(con, "SELECT text FROM encoding_test_auto")$text == text


# RESULTS ====

## # get_ready(3) -> WEB / Linux ==== 
# works out of the box with all characters back and forth

## # get_ready(3) -> WEB / Windows ==== 
# works out of the box with all characters back and forth

## # get_ready(2) -> local_latin1 / Windows ==== 
# works kind of:
# - data gets tranfered into DB without losses 
# - but only gibberish comes back
# - which actually seems to be solid UTF-8 encoded text





















