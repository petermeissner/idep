#### script for generating pro_minmaj variable in reforms dataset ==============


#### setup =====================================================================

library(idep)
library(foreign)

setwd("Z:/Gesch\xe4ftsordnungen/Database/aggregats")





#### load data =================================================================

load("Z:/Gesch\xe4ftsordnungen/Database/aggregats/reforms.Rdata")

reforms$pro_minmaj_qual  <- NULL
reforms$pro_minmaj_auto1 <- NULL
reforms$pro_minmaj_auto2 <- NULL


#### DEV Options ===============================================================

if ( exists("DEV") ){
  reforms <- 
    reforms  %>% select(t_id, t_date, t_country, wds_clean_rel, wds_pro_maj, wds_pro_min, lns_rel, lns_chg, pro_maj, pro_min  )  
}




#### pro_minmaj ================================================================

# pro_minmaj should be a variable that is decisive on who profitted from a reform:
# none, majority or minority.
# While most of the time that is easy because changes have a clear tendency 
# sometimes expert judgement is needed 

reforms$pro_minmaj_qual  <- NA # autocoding for trivial cases and expert judgemnt else
reforms$pro_minmaj_auto1 <- NA # autocoding based on words
reforms$pro_minmaj_auto2 <- NA # autocoding based on sub-paragraphs / lines


# autocoding 1 
reforms <- within(reforms, pro_minmaj_auto1 <- ifelse( wds_pro_maj < wds_pro_min                                       , -1, pro_minmaj_auto1))
reforms <- within(reforms, pro_minmaj_auto1 <- ifelse( wds_pro_maj == 0 & wds_pro_min == 0 | wds_pro_maj == wds_pro_min,  0, pro_minmaj_auto1))
reforms <- within(reforms, pro_minmaj_auto1 <- ifelse( wds_pro_maj > wds_pro_min                                       ,  1, pro_minmaj_auto1))

# autocoding 2 
reforms <- within(reforms, pro_minmaj_auto2 <- ifelse( pro_maj < pro_min                               , -1, pro_minmaj_auto2))
reforms <- within(reforms, pro_minmaj_auto2 <- ifelse( pro_maj == 0 & pro_min == 0 | pro_maj == pro_min,  0, pro_minmaj_auto2))
reforms <- within(reforms, pro_minmaj_auto2 <- ifelse( pro_maj > pro_min                               ,  1, pro_minmaj_auto2))


# trivial cases for pro_minmaj_qual
reforms <- within(reforms, pro_minmaj_qual <- ifelse( pro_maj == 0 & pro_min  > 0, -1, pro_minmaj_qual))
reforms <- within(reforms, pro_minmaj_qual <- ifelse( pro_maj == 0 & pro_min == 0,  0, pro_minmaj_qual))
reforms <- within(reforms, pro_minmaj_qual <- ifelse( pro_maj  > 0 & pro_min == 0,  1, pro_minmaj_qual))


# non trivial
non_trivial <- with(reforms, is.na(pro_minmaj_qual) & !is.na(pro_maj))

reforms[reforms$t_id=="AUT_1961-09-01.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="AUT_1975-10-01.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="AUT_1986-09-01.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="AUT_1989-01-01.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="AUT_1993-09-15.0", "pro_minmaj_qual"] <- 1 
reforms[reforms$t_id=="AUT_1996-10-15.0", "pro_minmaj_qual"] <- 1 
reforms[reforms$t_id=="AUT_1998-01-01.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="BEL_1962-02-08.0", "pro_minmaj_qual"] <- 1 
reforms[reforms$t_id=="BEL_1973-04-26.0", "pro_minmaj_qual"] <- 0 
reforms[reforms$t_id=="BEL_1982-10-26.0", "pro_minmaj_qual"] <- 1 
reforms[reforms$t_id=="BEL_1985-04-25.0", "pro_minmaj_qual"] <- 1  
reforms[reforms$t_id=="BEL_1987-01-28.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="BEL_1990-07-12.0", "pro_minmaj_qual"] <- 1 
reforms[reforms$t_id=="BEL_1993-10-27.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="BEL_1995-06-08.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="BEL_1998-10-13.0", "pro_minmaj_qual"] <- 1 
reforms[reforms$t_id=="BEL_2003-10-12.0", "pro_minmaj_qual"] <- 1 
reforms[reforms$t_id=="BEL_2005-05-19.0", "pro_minmaj_qual"] <- 0 
reforms[reforms$t_id=="DEN_1947-10-07.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="DEN_1953-12-17.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="DEN_1959-04-29.0", "pro_minmaj_qual"] <- 1 
reforms[reforms$t_id=="DEN_1966-01-01.0", "pro_minmaj_qual"] <- 0 
reforms[reforms$t_id=="DEN_1969-10-07.0", "pro_minmaj_qual"] <- 0 
reforms[reforms$t_id=="DEN_1971-10-05.0", "pro_minmaj_qual"] <- 0 
reforms[reforms$t_id=="DEN_1972-10-03.0", "pro_minmaj_qual"] <- 0 
reforms[reforms$t_id=="DEN_1976-10-05.0", "pro_minmaj_qual"] <- 1  
reforms[reforms$t_id=="DEN_1981-06-01.0", "pro_minmaj_qual"] <- 1  
reforms[reforms$t_id=="DEN_1986-12-17.0", "pro_minmaj_qual"] <- 0 
reforms[reforms$t_id=="DEN_1989-05-12.0", "pro_minmaj_qual"] <- 1 
reforms[reforms$t_id=="DEN_1997-05-27.0", "pro_minmaj_qual"] <- 0 
reforms[reforms$t_id=="DEN_1999-05-25.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="DEN_2004-01-01.0", "pro_minmaj_qual"] <- 1 
reforms[reforms$t_id=="DEN_2004-12-16.0", "pro_minmaj_qual"] <- 1 
reforms[reforms$t_id=="DEN_2007-06-01.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="ESP_1982-03-06.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="FRA_1969-11-30.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="FRA_1994-03-12.0", "pro_minmaj_qual"] <-  1  
reforms[reforms$t_id=="FRA_1995-11-11.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="FRA_2009-06-25.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="GER_1952-01-01.0", "pro_minmaj_qual"] <- -1
reforms[reforms$t_id=="GER_1970-05-22.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="GER_1972-10-19.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="GER_1980-10-01.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="GER_1986-12-18.0", "pro_minmaj_qual"] <- 1 
reforms[reforms$t_id=="IRE_1996-10-15.0", "pro_minmaj_qual"] <- 0  # extension of accent 2; lessening of quorum 2; majority decision about members of selection commitee 1; more to decide fo president 1; 
reforms[reforms$t_id=="IRE_1997-11-13.0", "pro_minmaj_qual"] <- -1 # 
reforms[reforms$t_id=="IRE_2010-12-02.0", "pro_minmaj_qual"] <- -1 #   
reforms[reforms$t_id=="ITA_1971-04-30.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="ITA_1982-01-12.0", "pro_minmaj_qual"] <- 0  
reforms[reforms$t_id=="ITA_1982-01-16.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="ITA_1982-01-29.0", "pro_minmaj_qual"] <- 1 # more decisiveness for president versus speaking time for minority 
reforms[reforms$t_id=="ITA_1983-11-30.0", "pro_minmaj_qual"] <- 1  
reforms[reforms$t_id=="ITA_1983-12-14.0", "pro_minmaj_qual"] <- -1 # in general more formalization of question times with small gains for president 
reforms[reforms$t_id=="ITA_1986-09-01.2", "pro_minmaj_qual"] <- 1 # change in debate slightly in favor of  divergent positions -1 ; speaking time goes down 1; less possib for obstruction 1; in general more sharpening and less obstruction -> 1
reforms[reforms$t_id=="ITA_1998-01-01.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="LUX_1991-01-01.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="LUX_1998-03-01.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="LUX_2000-07-01.0", "pro_minmaj_qual"] <- 1  
reforms[reforms$t_id=="LUX_2003-11-27.0", "pro_minmaj_qual"] <- 1  
reforms[reforms$t_id=="LUX_2007-03-15.0", "pro_minmaj_qual"] <- 1  
reforms[reforms$t_id=="LUX_2010-07-15.0", "pro_minmaj_qual"] <- 0  
reforms[reforms$t_id=="NED_1947-07-08.0", "pro_minmaj_qual"] <- 1  
reforms[reforms$t_id=="NED_1952-04-01.0", "pro_minmaj_qual"] <- 0 
reforms[reforms$t_id=="NED_1953-07-09.0", "pro_minmaj_qual"] <- -1 # Centrale Afdeling becomes wider (more consensual)  and gains power
reforms[reforms$t_id=="NED_1956-05-03.0", "pro_minmaj_qual"] <- -1 # new regulations on proposals, while some power goes to president their is a super majority hurdle introduced for going forward with proposal 
reforms[reforms$t_id=="NED_1966-07-12.0", "pro_minmaj_qual"] <- 1  
reforms[reforms$t_id=="NED_1986-06-24.0", "pro_minmaj_qual"] <- 1  # bureau gains decisions as well as president as well as the majority of chanmber
reforms[reforms$t_id=="NED_1994-05-17.0", "pro_minmaj_qual"] <- 1  
reforms[reforms$t_id=="NED_2004-03-31.0", "pro_minmaj_qual"] <- -1 # introduction of emergency debate as well as debate after reconciliation  while president gains slightly in power deciding which questions might be asked at question time
reforms[reforms$t_id=="NED_2006-06-29.0", "pro_minmaj_qual"] <- -1 # slight consilidation of power for president but introduction of new instrument for groups to express their will
reforms[reforms$t_id=="NOR_1989-10-02.0", "pro_minmaj_qual"] <- 1  # proportional representation of parties in interim committee, super majority for disabling rule, even distribution of speakers BUT extintion of question to government
reforms[reforms$t_id=="NOR_1996-10-01.0", "pro_minmaj_qual"] <- 1  # shorter time to answer interpellations, more power to president over who might ask questions in question time, more power to president in regulating question time
reforms[reforms$t_id=="NOR_2009-10-01.4", "pro_minmaj_qual"] <- 1  # no even distribution of speakers - if wanting to speak at the same time - among parties, clearer regulation of misc questions at the end of meeting, more power to chair of meeting in case of undecisive votes
reforms[reforms$t_id=="POR_1984-03-16.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="POR_1985-03-06.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="POR_2003-01-17.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="SWE_1949-04-06.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="SWE_1971-01-01.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="SWE_1974-02-28.0", "pro_minmaj_qual"] <- 1 
reforms[reforms$t_id=="SWE_1988-09-01.0", "pro_minmaj_qual"] <- 0 
reforms[reforms$t_id=="SWE_1993-01-01.0", "pro_minmaj_qual"] <- 1 
reforms[reforms$t_id=="SWE_1995-01-01.1", "pro_minmaj_qual"] <- 1 
reforms[reforms$t_id=="SWE_1996-01-01.0", "pro_minmaj_qual"] <- 0 
reforms[reforms$t_id=="SWE_1996-02-01.0", "pro_minmaj_qual"] <- -1 
reforms[reforms$t_id=="SWE_1998-10-01.0", "pro_minmaj_qual"] <- 1  
reforms[reforms$t_id=="SWE_2003-07-01.0", "pro_minmaj_qual"] <- 1  
reforms[reforms$t_id=="SWE_2007-01-01.1", "pro_minmaj_qual"] <- 1  
reforms[reforms$t_id=="SWE_2009-12-01.0", "pro_minmaj_qual"] <- 0 
reforms[reforms$t_id=="UK_1991-01-29.0" , "pro_minmaj_qual"] <- 1 
reforms[reforms$t_id=="UK_2005-10-10.0" , "pro_minmaj_qual"] <- 1 

      dings <- 
      reforms  %>% 
        filter(non_trivial)  %>% 
        #filter(t_country=="NOR") %>% 
        select(t_id, pro_maj, pro_min, pro_non, pro_minmaj_qual)  %>% 
        mutate(
          diff      = pro_maj - pro_min,
          ratio_pro = round((pro_maj - pro_min) / (pro_maj + pro_min),2),
          ratio_all = round((pro_maj - pro_min) / (pro_maj + pro_min + pro_non),2)
        ) %>% 
        arrange(-ratio_pro, -diff,-ratio_all)  %>% 
        head(100)
      dings
      
      knitr::kable(dings)
      

#### saving ====================================================================

# save reforms dataset
setwd("Z:/Gesch\u00e4ftsordnungen/database/aggregats")
save(reforms, file="reforms.Rdata")
write.dta(reforms, file="reforms.dta")



