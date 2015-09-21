
# script for boiling down and aggregating party data set to cabinets ===========


#### setting things up =========================================================

library(idep)
library(stringr)
library(dplyr)
library(foreign)


setwd("Z:/Geschäftsordnungen/Database/external_data")


#### load data =================================================================

# parties data
load("cmp_parlgov_parties_ideo_confl.Rdata")
parties <- as_data_frame(parties)



#### Voaltility calcualtion ====================================================

# V = SUM_1:n_( | delta p_it | )
#
# 
# in words: 
#   volatility 
#   is the sum of absolute percentage changes 
#   in election results 
#   at time t
#   for all party i
#   where i ranges from 1 to n 
#   and n equals the the number of parties turning up to the election
#
# Pedersen, Mogens N. (1979): 
# 'The Dynamics of European Party Systems: Changing Patterns of Electoral Volatility', 
# European Journal of Political Research, 7/1, 1-26.
# 
# e.g.:  http://janda.org/c24/Readings/Pedersen/Pedersen.htm


# calculate seats_percentage and change in seats_percentage
tmp <- 
  parties  %>% 
  arrange(party_id_x ,election_date, start_date) %>% 
  group_by(party_id_x) %>% 
  mutate(
    seats_percentage  = 100 * (seats / election_seats_total), 
    volatility_pi = abs(seats_percentage - ifelse(is.na(lag(seats_percentage)), 0, lag(seats_percentage)) )
  )  

# ensure values to be equal per party and election
tmp <- 
  tmp  %>% 
  group_by(party_id_x, election_date) %>% 
  mutate(
    volatility_pi = max(volatility_pi)
  )

# ensure NAs for first elections in dataset
country <- unique(parties$country)
tmp$first_election <- 0
for (i in seq_along(country)) {
  min_elec <- min(tmp$election_date[tmp$country==country[i]])
  tmp$volatility_pi[tmp$country==country[i] & tmp$election_date==min_elec]  <- NA
  tmp$first_election[tmp$country==country[i] & tmp$election_date==min_elec] <- 1
}

# sum up individual volatilities for cabinets
tmp <- 
  tmp  %>% 
  group_by(cabinet_id) %>% 
  mutate( 
    volatility = sum(volatility_pi) 
  ) %>% 
  arrange(country, election_date, start_date) 


# replace old parties
parties <- 
  tmp %>% group_by()


#### save ======================================================================

write.dta(parties, "cmp_parlgov_parties_ideo_confl_volatility.dta")
write.csv(parties, "cmp_parlgov_parties_ideo_confl_volatility.csv")
save(parties, file="cmp_parlgov_parties_ideo_confl_volatility.Rdata")

















