
**** Setup ================================================================================

version 11
set more off
clear all
set linesize 80

**** open dataset =========================================================================
cd  "Z:/Geschäftsordnungen/Database/external_data/Manifesto Project and ParlGov/"
use "cmp_parlgov_parties.dta"



**** task 1: calculate ideological ideal position and polarization of government ==========

sort cabinet_id
by cabinet_id: egen seats_gov_b = total(seats) if cabinet_party == 1
by cabinet_id: egen seats_gov = max(seats_gov_b)

generate seat_share_gov = seats/seats_gov if cabinet_party == 1

by cabinet_id: egen seats_opp_b = total(seats) if cabinet_party == 0
by cabinet_id: egen seats_opp = max(seats_opp_b)

generate seat_share_opp = seats/seats_opp if cabinet_party == 0

by cabinet_id: egen ideal_gov = total(rile * seat_share_gov) if cabinet_party == 1


* polarization of government 

by cabinet_id: egen ideal_gov_2 = total(rile * seat_share_gov) if cabinet_party == 1

generate polar_gov_1 = ((rile - ideal_gov_2)^2) * seat_share_gov if cabinet_party == 1

by cabinet_id: egen polar_gov_2 = total(polar_gov_1)

by cabinet_id: generate polar_gov = sqrt(polar_gov_2)



**** task 2: calculate ideological range and polarization of opposition ===================================


* ideological range of opposition
sort cabinet_id

by cabinet_id: egen max = max(rile) if cabinet_party == 0
by cabinet_id: egen min = min(rile) if cabinet_party == 0

generate range_opp_2 = max-min

by cabinet_id: egen range_opp = max(range_opp_2)


* polarization of opposition

by cabinet_id: egen ideal_opp_2 = total(abs(rile * seat_share_opp)) if cabinet_party == 0

generate polar_opp_1 = ((rile - ideal_opp_2)^2) * seat_share_opp if cabinet_party == 0

by cabinet_id: egen polar_opp_2 = total(polar_opp_1)

by cabinet_id: generate polar_opp = sqrt(polar_opp_2)




**** task 3: calculate distance between ideal position of opposition and government ========================

* version a: calculate ideal position of opposition just like the ideological position of government,
*	then take difference between the two positions
sort cabinet_id

by cabinet_id: egen ideal_gov_tot = max(ideal_gov)
by cabinet_id: egen ideal_opp_tot = max(ideal_opp)

generate opp_gov_dist_a = ideal_gov_tot - ideal_opp_tot
replace opp_gov_dist_a = 0 if opp_gov_dist_a == .


* version b: calculate distance between opposition and government by summing up the weighted distances
*	of each individual opposition party to the governmental ideal point
by cabinet_id: egen ideal_gov_b = max(ideal_gov)
by cabinet_id: egen opp_gov_dist_b = total((abs(ideal_gov_b - rile)) * seat_share_opp) if cabinet_party == 0
by cabinet_id: egen dist_b = max(opp_gov_dist_b)

replace opp_gov_dist_b = dist_b if cabinet_party == 1


* comparison of version a and b
corr opp_gov_dist_a opp_gov_dist_b // correlation of -0.27 --> both variables do indeed measure different things





**** task 4: saving =========================================================================================

save "cmp_parlgov_parties_ideo_confl.dta", replace













