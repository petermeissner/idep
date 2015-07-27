#' ---
#' title: "Deutschlandinfos"
#' date: 2015-05-15
#' output:
#'  html_document:
#'   number_sections: true
#'   toc: true
#' ---



#' # Vorbereitung
#' 
#' ##  setting things up
rm(list = ls())
require(idep)
library(dplyr)
get_ready()
setwd("Z:/Gesch\u00e4ftsordnungen/Reports")

dbPeak <- function(con, sql, n=10){
  res   <- dbSendQuery(con, sql)
  res_n <- dbFetch(res, n)
  dbClearResult(res)
  res_n
}

options("width"=90)


#' ## check connection and list tables of Database
socon
dbListTables(socon)


#' ## read in information
sql <- 
  "SELECT * FROM data_texts
    WHERE t_id = 'GER_1949-09-20.0' OR 
    t_id = 'GER_1952-01-01.0' "
texts <- dbGetQuery( socon, sql)
texts


sql <- 
  "SELECT * FROM data_textlines 
    WHERE tl_t_id = 'GER_1949-09-20.0' OR 
    tl_t_id = 'GER_1952-01-01.0' "
lines <- dbGetQuery( socon, sql)
head(lines,2)


sql <- 
  "SELECT * FROM data_linelinkage 
    WHERE ll_t_id1 = 'GER_1949-09-20.0' OR 
    ll_t_id2 = 'GER_1952-01-01.0' "
    changes <- dbGetQuery( socon, sql)
    head(changes,2)


#' # Ergebnisse

#' ## Veränderungsauszählungen
    
#' ### Textlängen in Worten (alle)
aggregate(cbind(tl_wds_clean, tl_wds_raw)~tl_t_id , data=lines, sum)

#' ### Textlängen in Worten (nach Relevanz)
aggregate(cbind(tl_wds_clean, tl_wds_raw)~tl_t_id + tl_relevant, data=lines, sum)
        
    
#' ### Veränderungen/Keine für Paragraphen
c(
  table(changes$ll_type),
  sum=sum(table(changes$ll_type))
)


#' ### Veränderungen für  Worte
rbind(
  aggregate( 
    cbind(ll_diff_wd) ~ ll_type, 
    function(x) sum(x, na.rm=T), 
    data= changes),
  c("sum",sum(changes$ll_diff_wd))
)

#' ### Keine Veränderungen für  Worte
rbind(
  aggregate( 
    cbind(ll_sim_wd) ~ ll_type, 
    function(x) sum(x, na.rm=T), 
    data= changes),
  c("sum",sum(changes$ll_sim_wd))
)
    

#' ## Mehrheits / Minderheitscodierung

#' ### Auszählung
    table(changes$ll_minmaj_code) # 0 = none, 1 = pro Maj, 2 = pro Min

#' ### Kommentare
changes %>% select(ll_minmaj_code, ll_minmaj_memo)  %>% distinct
    
    
