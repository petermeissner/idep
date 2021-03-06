// script for preparing ERD dataset
// 	- variable selection
// 	- renaming
// 	- observation filtering

// jfk / pm



// setting things up ===========================================================

version 11
set more off
clear all


// loading data ================================================================

use "Z:/Geschäftsordnungen/Database/external_data/ERD/ERD-e_SA_SOE_N-29_2014_A_Stata_version_9.dta"


// varaible selection and renaming

* keep only countries which are in sample
keep if	v001e == 01 | v001e == 02 | v001e == 03 | ///
		v001e == 04 | v001e == 05 | v001e == 06 | ///
		v001e == 08 | v001e == 09 | v001e == 10 | ///
		v001e == 11 | v001e == 12 | v001e == 13 | ///
		v001e == 14 | v001e == 15 | v001e == 16 | ///
		v001e == 17 

* label values of select variables
label define country	01 "Austria" 02 "Belgium" 03 "Denmark" ///
					04 "Finland" 05 "France" 06 "Germany" ///
					08 "Iceland" 09 "Ireland" 10 "Italy" ///
					11 "Luxembourg" 12 "Netherlands" 13 "Norway" ///
					14 "Portugal" 15 "Spain" 16 "Sweden" ///
					17 "United Kingdom"

label define ctr 01 "aut" 02 "bel" 03 "dnk" /// https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3
					04 "fin" 05 "fra" 06 "deu" ///
					08 "isl" 09 "irl" 10 "ita" ///
					11 "lux" 12 "nld" 13 "nor" ///
					14 "prt" 15 "esp" 16 "swe" ///
					17 "gbr"
					
* re-label most important variables
label variable v001e "countries"
label variable v002e "cabinet code"
label variable v003e "cabinet"
label variable v004e "date in"
label variable v005e "date out"
label variable v010e "cabinet composition"
label variable v305e "max possible cab duration"
label variable v306e "number parliamentary parties"
label variable v309e "enp"
label variable v310e "bargaining power fragm"
label variable v312e "largest party seat share"
label variable v316e "coalition cabinet"
label variable v318e "cabinet seat share"
label variable v320e "number cabinet parties"
label variable v323e "single party maj"
label variable v324e "single party min"
label variable v325e "coalition maj"
label variable v326e "coalition min"
label variable v329e "government type"
label variable v406e "parl preference range"
label variable v407e "polarization"
label variable v410e "cab preference range"
label variable v604e "cab duration"




// renaming and labeling of variables ==========================================

rename v002e cab_id
label variable cab_id "cabinet id"

rename v001e country
label variable country "country"
label values country country

gen ctr = country
label values ctr ctr

rename v003e cab_pm
label variable cab_pm "PM of cabinet"

rename v004e cab_in
label variable cab_in "date cabinet in"

rename v005e cab_out
label variable cab_out "date cabinet out"

rename v300e new_gov
label variable new_gov "cabinet is start of new government"

rename v301e next_elect
label variable next_elect "proximity next election"

rename v305e max_cab_dur
label variable max_cab_dur "maximum cabinet duration"

rename v306e abs_no_party
label variable abs_no_party "absolute number of parties"

rename v307e abs_no_party_seat
label variable abs_no_party_seat "absolute number of parties according to seat distribution"

rename v308e abs_no_party_seat_plus
label variable abs_no_party_seat_plus "absolute number of parties according to seat distribution +1"

rename v309e eff_no_party
label variable eff_no_party "effective number of parties"

rename v310e barg_pow
label variable barg_pow "bargaining power fragmentation"

rename v311e eff_no_upper
label variable eff_no_upper "effective number of parties in upper house"

rename v312e largest_seat
label variable largest_seat "largest party seat share"

rename v313e barg_pow_largest
label variable barg_pow_largest "bargaining power of largest party"

rename v314e min_sit
label variable min_sit "minority situation in parliament"

rename v315e non_part_cab
label variable non_part_cab "non-partisan cabinet"

rename v316e coal_cab
label variable coal_cab "coalition cabinet"

rename v317e cab_seats
label variable cab_seats "number of cabinet seats"

rename v318e cab_share
label variable cab_share "cabinet seat share"

rename v319e cab_seats_upp
label variable cab_seats_upp "number of cabinet seats in upper chamber"

rename v320e no_cab_parties
label variable no_cab_parties "number of cabinet parties"

rename v321e change_cab_parties
label variable change_cab_parties "change in number of cabinet parties"

rename v323e single_maj_cab
label variable single_maj_cab "single party majority cabinet"

rename v324e single_min_cab
label variable single_min_cab "single party minority cabinet"

rename v325e coal_min_cab
label variable coal_min_cab "minority coalition cabinet"

rename v326e maj_cab
label variable maj_cab "majority cabinet"

rename v327e mwc_cab
label variable mwc_cab "minimum winning coalition cabinet"

rename v328e smc_cab
label variable smc_cab "surpuls majority cabinet"

rename v329e gov_type
label variable gov_type "government type"

rename v406e parl_pref
label variable parl_pref "parliamentary preference range"

rename v407e polariz
label variable polariz "polarization"

rename v410e cab_pref
label variable cab_pref "cabinet preference range"

rename v413e connect_cab
label variable connect_cab "connected cabinet"

rename v414e mwc_connected_cab
label variable mwc_connected_cab "MWC connected cabinet"

rename v500e low_leg
label variable low_leg "lower chamber decides legislation"

rename v501e const_amend_supermaj
label variable const_amend_supermaj "supermajority needed for constitutional amendment"

rename v502e strong_low
label variable strong_low "strong lower chamber"

rename v503e weak_low
label variable weak_low "weak lower chamber"

rename v504e bicamer
label variable bicamer "bicameralism"

rename v505e pos_parl
label variable pos_parl "positive parliamentarism"

rename v507e no_confid_absmaj
label variable no_confid_absmaj "absolute majority needed for vote of no confidence"

rename v508e no_confid_construct
label variable no_confid_construct "constructive vote of no confidence"

rename v509e cab_unanimity
label variable cab_unanimity "cabinet decision rule is unanimity"

rename v510e cab_pm_cons
label variable cab_pm_cons "cabinet decision rule is PM consensus"

rename v511e cab_leg
label variable cab_leg "cabinet co-decides legislation"

rename v518e semi_pres
label variable semi_pres "semi-presidentialism"

rename v519e seats_low
label variable seats_low "number of seats in lower chamber"

rename v520e seats_upp
label variable seats_upp "number of seats in lower chamber"

rename v601e cab_dur_100
label variable cab_dur_100 "cabinet duration 100%"

rename v603e cab_dur_rel
label variable cab_dur_rel "relative cabinet duration"

rename v605e cab_dur_abs2
label variable cab_dur_abs "absolute cabinet duration"

rename v700e el_volat_cab
label variable el_volat_cab "cabinet electoral volatility"

rename v701e el_volat_ave
label variable el_volat_ave "average electoral volatility"

rename v708e el_perf_cab
label variable el_perf_cab "cabinet electoral performance"


rename  v010e cab_comp


rename v330e      cab_n_members
rename v331e      cab_n_members_change
rename v326e_add  maj_coal
rename v604e      cab_dur_abs1




/*

// definition of external variables ============================================

* these variables are gathered from external data sources
gen v301=.
label variable v301 "cab_idpt"
notes v301: cabinet ideal point on CMP left-right

rename v301 cab_idpt
label variable cab_idpt "cabinet ideal point"

gen v302=.
label variable v302 "words_const"
notes v302: number of words on parliamentary rules in constitution at start of cabinet

gen v303=.
label variable v303 "words_SO"
notes v303: number of words in parl standing orders at start of cabinet

gen v304=.
label variable v304 "majreq"
notes v304: majority required to change standing orders at start of cabinet
rename v304 majreq
label variable majreq "majority required to change standing orders"

gen v305=.
label variable v305 "veto_pts"
notes v305: number of veto points according to Ganghof 2005
rename v305 veto_pts
label variable veto_pts "number of veto points"

gen v306=.
label variable v306 "cab_alt"
notes v306: average cabinet alternation index AIII (Kaiser 2004) over 10 years before start of cabinet

gen v307=.
label variable v307 "word_corr"
notes v307: correction score for wordiness, based on number of English words in EU Charter
rename v307 word_corr
label variable word_corr "correction score for wordiness"

gen v308=.
label variable v308 "el_vol"
notes v308: electoral volatility
rename v308 el_volat
label variable el_volat "electoral volatility"

rename v302 words_const
label variable words_const "words in constitution"
*/


// generate cariables capturing change =========================================

egen country_id = group(country)
sort country_id cab_id

generate policy_conf = (cab_pref / parl_pref) * (-1)
label variable policy_conf "policy conflict between cabinet and opposition"

by country_id: generate policy_conf_ch = policy_conf[_n] - policy_conf[_n-1]
label variable policy_conf_ch "change in policy conflict between cabinet and opposition"

by country_id: generate cab_pref_ch = cab_pref[_n] - cab_pref[_n-1]
label variable cab_pref_ch "change in cabinet preference range"

generate maj_min = 0
by country_id: replace maj_min = 1 if maj_cab[_n-1] == 1 & maj_cab[_n] == 0
label variable maj_min "change from majority to minority cabinet"

generate min_maj = 0
by country_id: replace min_maj = 1 if maj_cab[_n-1] == 0 & maj_cab[_n] == 1
label variable min_maj "change from minority to majority cabinet"

generate opm_coal = 0
by country_id: replace opm_coal = 1 if single_maj_cab[_n-1] == 1 & gov_type[_n] == 2
by country_id: replace opm_coal = 1 if single_maj_cab[_n-1] == 1 & gov_type[_n] == 3
label variable opm_coal "change from one-party majority to coalition cabinet"

generate coal_opm = 0
by country_id: replace coal_opm = 1 if single_maj_cab[_n] == 1 & gov_type[_n-1] == 2
by country_id: replace coal_opm = 1 if single_maj_cab[_n] == 1 & gov_type[_n-1] == 3
label variable coal_opm "change from coalition to one-party majority cabinet"



// drop irrelevant variables ===================================================

drop v400e v401e v402e v403e v404e v405e    v409e v411e v412e v415e v416e v506e 
drop v512e v513e v514e v515e v516e v517e    v703e v704e v705e v706e v274e v707e 
drop v100e v101e v102e v103e v104e v105e    v107e v108e v109e v110e v111e v112e  
drop v114e v115e v116e v117e v118e v119e    v121e v122e v123e v124e v125e v126e 
drop v128e v129e v130e v131e v132e v133e    v135e v136e v137e v138e v139e v140e 
drop v142e v143e v144e v145e v146e v147e    v201e v202e v203e v204e v205e v206e 
drop v208e v209e v210e v211e v212e v213e    v215e v216e v217e v218e v219e v220e 
drop v222e v223e v224e v225e v226e v227e    v229e v230e v231e v250e v251e v252e 
drop v006e v007e v008e v009e v254e v255e    v257e v258e v259e v260e v261e v262e 
drop v264e v265e v266e v267e v268e v269e    v271e v408e v272e v702e v273e v106e
drop v113e v120e v127e v134e v141e v200e    v207e v214e v221e v228e v253e v256e 
drop v263e v270e  v302e v303e v304e v322e   v600e v602e v303   


// save data ===================================================================

save "Z:/Geschäftsordnungen/Database/external_data/erd_cleaned_up" , replace



