var_desc_erd <- 
rbind(
  # Meta 
list(name="cab_id"                 , from="ERD v002e", group="2 ERD - Cabinet Identification", description="Cabinet Code -- Cabinet code First digits = country code, Second digit = cabinet code (ERD 2014)"),
list(name="cab_pm"                 , from="ERD v003e", group="2 ERD - Cabinet Identification", description="Cabinet -- Occurs at any change of (a) party composition, (b) general election and (c) change of PM. (ERD 2014)"),
list(name="cab_in"                 , from="ERD v004e", group="2 ERD - Cabinet Identification", description="Date in (ERD 2014)"),
list(name="cab_out"                , from="ERD v005e", group="2 ERD - Cabinet Identification", description="Date out (ERD 2014)"),
list(name="cab_comp"               , from="ERD v010e", group="2 ERD - Cabinet Identification", description="Cabinet composition -- Party acronyms -- Party of PM listed first (ERD 2014)"),

list(name="new_gov"                , from="ERD v300e", group="2 ERD - Structural Attributes", description="Does the cabinet represent the start of a new government -- 0=No, 1=Yes (= A new government is only recorded at a change in party composition or a new election), 3=non-partisan cabinet (ERD 2014)"),
list(name="next_elect"             , from="ERD v301e", group="2 ERD - Structural Attributes", description="Proximity to election, popularly elected /lower chamber -- F=Cabinet immediately following an election. E=Cabinet ended by an election. FE=Cabinet immediately following an election and ended by the next election, N=neither immediately following or ended by an election(ERD 2014)"),

list(name="max_cab_dur"            , from="ERD v305e", group="2 ERD - Structural Attributes", description="Max Possible Cab Duration -- (unit = days)  (ERD 2014)"),
list(name="abs_no_party"           , from="ERD v306e", group="2 ERD - Structural Attributes", description="Absolute No. Parl Parties (ERD 2014)"),
list(name="abs_no_party_seat"      , from="ERD v307e", group="2 ERD - Structural Attributes", description="Absolute No. Parl Parties according to recorded seat distribution (ERD 2014)"),
list(name="abs_no_party_seat_plus" , from="ERD v308e", group="2 ERD - Structural Attributes", description="Absolute No. Parl Parties according to recorded seat distribution + 1 if there are others recorded) (ERD 2014)"),
list(name="eff_no_party"           , from="ERD v309e", group="2 ERD - Structural Attributes", description="Effective No. Parl Parties, lower chamber (ERD 2014)"),
list(name="barg_pow"               , from="ERD v310e", group="2 ERD - Structural Attributes", description="Bargaining power fragmentation (ERD 2014)"),
list(name="eff_no_upper"           , from="ERD v311e", group="2 ERD - Structural Attributes", description="Effective number of parliamentary parties, upper chamber (ERD 2014)"),
list(name="largest_seat"           , from="ERD v312e", group="2 ERD - Structural Attributes", description="Largest Party Seat Share   (ERD 2014)"),
list(name="barg_pow_largest"       , from="ERD v313e", group="2 ERD - Structural Attributes", description="Bargaining Power of Largest Party -- (unit = Banzhaf Index) (ERD 2014)"),
list(name="min_sit"                , from="ERD v314e", group="2 ERD - Structural Attributes", description="Minority Situation in Parliament -- 1 = Minority Situation  -- No single party holds 50% plus one seat or more of parliamentary seats (ERD 2014)"),
list(name="non_part_cab"           , from="ERD v315e", group="2 ERD - Structural Attributes", description="Non-partisan cabinet -- 1 = Yes, 0 = No (ERD 2014)"),
list(name="coal_cab"               , from="ERD v316e", group="2 ERD - Structural Attributes", description="Coalition Cabinet --  1 = Yes, 0 = No (ERD 2014)"),
list(name="cab_seats"              , from="ERD v317e", group="2 ERD - Structural Attributes", description="Cabinet strength, lower chamber -- Seats (ERD 2014)"),
list(name="cab_share"              , from="ERD v318e", group="2 ERD - Structural Attributes", description="Cabinet Seat Share -- (unit = % points)  (ERD 2014)"),
list(name="cab_seats_upp"          , from="ERD v319e", group="2 ERD - Structural Attributes", description="Cabinet strength, upper chamber -- Seats  (ERD 2014)"),
list(name="no_cab_parties"         , from="ERD v320e", group="2 ERD - Structural Attributes", description="Number of Cabinet Parties  -- (unit = parties)  (ERD 2014)"),
list(name="change_cab_parties"     , from="ERD v321e", group="2 ERD - Structural Attributes", description="Change in Cabinet Parties  -- 1 = Inc, 0 = No Ch, -1 = Dec (ERD 2014)"),

list(name="single_maj_cab"         , from="ERD v323e", group="2 ERD - Structural Attributes", description="Single Party Majority Cabinet (ERD 2014)"),
list(name="single_min_cab"         , from="ERD v324e", group="2 ERD - Structural Attributes", description="Single Party Minority Cabinet (ERD 2014)"),
list(name="coal_min_cab"           , from="ERD v325e", group="2 ERD - Structural Attributes", description="Minority Coalition   (ERD 2014)"),
list(name="maj_cab"                , from="ERD v326e", group="2 ERD - Structural Attributes", description="Majority Cabinet   (ERD 2014)"),
list(name="maj_coal"               , from="ERD v326e_add", group="2 ERD - Structural Attributes", description="Majority Coalition (ERD 2014)"),
list(name="mwc_cab"                , from="ERD v327e", group="2 ERD - Structural Attributes", description="Minimal Winning Coalition  (ERD 2014)"),
list(name="smc_cab"                , from="ERD v328e", group="2 ERD - Structural Attributes", description="Surplus Majority Cabinet (ERD 2014)"),
list(name="gov_type"               , from="ERD v329e", group="2 ERD - Structural Attributes", description="Government Type -- 1 = Minority, 2 = MWC, 3 = Surplus  (ERD 2014)"),
list(name="cab_n_members"          , from="ERD v330e", group="2 ERD - Structural Attributes", description="Number of Cabinet Members (ministers) (ERD 2014)"),
list(name="cab_n_members_change"   , from="ERD v331e", group="2 ERD - Structural Attributes", description="Change in Number of Cabinet Members (ministers) -- 1 = Inc, 0 = No Ch, -1 = Dec (ERD 2014)"),

list(name="parl_pref"              , from="ERD v406e", group="2 ERD - Preferences", description="Parliamentary Preference Range (ERD 2014)"),
list(name="polariz"                , from="ERD v407e", group="2 ERD - Preferences", description="Polarization (BP Weighted)  -- (manifesto points) -- Party manifesto data. Coded in-house 2012, re-calculated for all cabinets: Polarization is based on the equation presented in Bergman et al. (2008), p. 112, v082y where: b is for bargaining power of party i, x is the left-right position of party i, and x bar is the weighted average left-right positions of all parties.* (ERD 2014)"),
list(name="cab_pref"               , from="ERD v410e", group="2 ERD - Preferences", description="Cabinet Preference Range  -- (manifesto points) -- Party manifesto data. Coded in-house 2012, re-calculated for all cabinets (ERD 2014)"),
list(name="connect_cab"            , from="ERD v413e", group="2 ERD - Preferences", description="Connected Cab -- 1 = Yes, 0 = No -- Single-party cabinets, as well as connected coalitions, are coded as connected. Non-partisan cabinets are coded as Non-applicable (=88888). (ERD 2014)"),
list(name="mwc_connected_cab"      , from="ERD v414e", group="2 ERD - Preferences", description="Minimal Winning Connected Coalition -- 1 = Yes, 0 = No  (ERD 2014)"),

list(name="low_leg"                , from="ERD v500e", group="2 ERD - Institutions", description="Lower Chamber Only Decides Legislation -- 1 = Yes, 0 = No -- 0 = Belgium, Denmark, Finland, Italy, Netherlands, Spain, Sweden (-1970) (ERD 2014)"),
list(name="const_amend_supermaj"   , from="ERD v501e", group="2 ERD - Institutions", description="Supermajority for Const Amend -- 1 = Yes, 0 = No -- 0 = Denmark, France, Iceland, Ireland, Italy, Spain (-1978), Sweden, UK. Assumed constant after 1999. (ERD 2014)"),
list(name="strong_low"             , from="ERD v502e", group="2 ERD - Institutions", description="Strong Second Chamber -- 1 = Yes, 0 = No -- 1 = Belgium (-95), Italy (1948-), Sweden (-70). (ERD 2014)"),
list(name="weak_low"               , from="ERD v503e", group="2 ERD - Institutions", description="Weak Second Chamber  -- 1 = Yes, 0 = No -- 1 = Austria, Belgium (95-), France, Germany, Ireland, Netherlands, Spain (-1978), UK. Assumed constant after 1999. (ERD 2014)"),
list(name="bicamer"                , from="ERD v504e", group="2 ERD - Institutions", description="Bicameralism -- 1 = Yes, 0 = No  -- 1 = Austria, Belgium, Denmark (-70), France, Germany, Ireland, Italy (1948-), Netherlands, Spain (1978-), Sweden (-70), UK (ERD 2014)"),
list(name="pos_parl"               , from="ERD v505e", group="2 ERD - Institutions", description="Positive Parliamentarism -- 1 = Yes, 0 = No -- 1 = Belgium, Germany, Greece, Ireland (1945-), Italy (1948-), Luxembourg, Spain (1978-), Finland (ERD 2014)"),
list(name="no_confid_absmaj"       , from="ERD v507e", group="2 ERD - Institutions", description="Abs Majority No-confidence -- 1 = Yes, 0 = No  -- 1 = Belgium (95-) France, Germany, Greece, Iceland (1945-), Portugal, Spain (1978-), Sweden (71-). Assumed constant after 1999. (ERD 2014)"),
list(name="no_confid_construct"    , from="ERD v508e", group="2 ERD - Institutions", description="Constructive No-Confidence -- 1 = Yes, 0 = No -- 1 = Germany, Spain, Belgium (1995-) (ERD 2014)"), 
list(name="cab_unanimity"          , from="ERD v509e", group="2 ERD - Institutions", description="Cabinet Rule: Unanimity -- 1 = Yes, 0 = No -- 1 = Austria, Italy (1948-), Portugal (ERD 2014)"),
list(name="cab_pm_cons"            , from="ERD v510e", group="2 ERD - Institutions", description="Cabinet Rule: PM Consensus -- 1 = Yes, 0 = No -- 1 = Belgium, Denmark, Spain (1978-), Sweden, UK. Assumed constant after 1999. (ERD 2014)"),
list(name="cab_leg"                , from="ERD v511e", group="2 ERD - Institutions", description="Cabinet Co-decides Leg -- 1 = Yes, 0 = No -- 1 = Denmark, Netherlands, Sweden (-70) (ERD 2014)"),
list(name="semi_pres"              , from="ERD v518e", group="2 ERD - Institutions", description="Semi-Presidentialism  -- 1 = Yes, 0 = No -- 1 = Finland (-2000), France, Greece (-1985), Portugal (-82)  (ERD 2014)"),
list(name="seats_low"              , from="ERD v519e", group="2 ERD - Institutions", description="Size of Lower Chamber (ERD 2014)"),
list(name="seats_upp"              , from="ERD v520e", group="2 ERD - Institutions", description="Size of upper chamber (ERD 2014)"),

list(name="cab_dur_100"            , from="ERD v601e", group="2 ERD - Bargaining environment", description="Relative duration 100 percent -- 0=No, 1=Yes (ERD 2014)"),
list(name="cab_dur_rel"            , from="ERD v603e", group="2 ERD - Bargaining environment", description="Relative Cab Duration  (ERD 2014)"),
list(name="cab_dur_abs1"           , from="ERD v604e", group="2 ERD - Bargaining environment", description="Absolute Cab Duration (ERD 2014)"),
list(name="cab_dur_abs2"           , from="ERD v605e", group="2 ERD - Bargaining environment", description="Absolute Cab Duration (ERD 2014)"),

list(name="el_volat_cab"           , from="ERD v700e", group="2 ERD - Critical Events", description="Total cabinet electoral volatility -- For each cabinet party, the vote support (%) received at the relevant parliamentary election is subtracted from the vote support (%) that the same party received at the immediately preceding election; the absolute value of these scores are summarized for all cabinet parties. Coded in-house 2012, re-calculated for all cabinets(ERD 2014)"),
list(name="el_volat_ave"           , from="ERD v701e", group="2 ERD - Critical Events", description="Average cabinet electoral volatility -- For each cabinet party, the vote support (%) received at the relevant parliamentary election is subtracted from the vote support (%) that the same party received at the immediately preceding election; the absolute value of these scores are summarized for all 11 cabinet parties and then divided by the number of cabinet parties. Coded in-house 2012, re-calculated for all cabinet (ERD 2014)"),
list(name="el_perf_cab"            , from="ERD v708e", group="2 ERD - Critical Events", description="Cabinet El Performance -- For each cabinet party, the vote support (%) that a political party received at the parliamentary election which preceded its cabinet membership is subtracted from the vote support (%) it received at the next (following) parliamentary election; these scores then are summarized. Coded in-house 2012, re-calculated for all cabinets(ERD 2014)"),

list(name="country_id"             , from="ERD derived", group="2 ERD - derived", description="Simply one distinct number per country."),
list(name="policy_conf"            , from="ERD derived", group="2 ERD - derived", description="$$policy\\_conf  = -1 * ( cab\\_pref / parl\\_pref )$$"),
list(name="policy_conf_ch"         , from="ERD derived", group="2 ERD - derived", description="$$policy\\_conf\\_ch = policy\\_conf_t - policy\\_conf_{t-1}$$"),
list(name="cab_pref_ch"            , from="ERD derived", group="2 ERD - derived", description="$$cab\\_pref\\_ch = cab\\_pref_t - cab\\_pref_{t-1}$$"),
list(name="maj_min"                , from="ERD derived", group="2 ERD - derived", description="$$maj\\_min = \\{ \\quad 1 \\quad | \\quad maj\\_cab_{t-1} = 1 \\quad \\& \\quad maj\\_cab_t = 0 \\newline maj\\_min = \\{ \\quad 0 \\quad | \\quad else$$"),
list(name="min_maj"                , from="ERD derived", group="2 ERD - derived", description="$$min\\_maj = \\{ \\quad 1 \\quad | \\quad maj\\_cab_{t-1} = 0 \\quad \\& \\quad maj\\_cab_t = 1 \\newline min\\_maj = \\{ \\quad 0 \\quad | \\quad else$$"),
list(name="opm_coal"               , from="ERD derived", group="2 ERD - derived", description="$$opm\\_coal = \\{  \\quad 1 \\quad | \\quad single\\_maj\\_cab_{t-1} = 1 \\quad \\& \\quad gov\\_type_t = 2 \\newline  opm\\_coal = \\{  \\quad 1 \\quad | \\quad single\\_maj\\_cab_{t-1} = 1 \\quad \\& \\quad gov\\_type_t = 3 \\newline opm\\_coal = \\{  \\quad 0 \\quad | \\quad else$$"),
list(name="coal_opm"               , from="ERD derived", group="2 ERD - derived", description="$$coal\\_opm = \\{  \\quad 1 \\quad | \\quad single\\_maj\\_cab_{t} = 1 \\quad \\& \\quad gov\\_type\\_t = 2 \\newline coal\\_opm = \\{  \\quad 1 \\quad | \\quad single\\_maj\\_cab_{t} = 1 \\quad \\& \\quad gov\\_type\\_t = 3 \\newline  coal\\_opm = \\{  \\quad 0 \\quad | \\quad else$$"),
list(name="erd_pg_mp_matcher"      , from="ERD/ParlGov", group="9 matching variables", description="Variable used to merge/join records/observations from ERD with that of ParlGov/CMP dataset after matching them via the date the cabinet went into office."),
list(name="erd_cab_id"             , from="ERD/ISOR",    group="9 matching variables", description="Variable used to merge/join records/observations from ERD and ISOR dataset after matching them via reform date and whether or not that falls within the time span of a cabinet. \n\n If however - as was some 20 times the case a Standing Orders reform was made while no cabinet was formally in charge of the government, we looked into the cases and decided upon the situation found and tahn assigning the reform either to the previous or the following cabinet. "),

list(name="cab_id_pg"              , from="ParlGov", group="3 ParlGov", description="ParlGov cabinet ID"),
list(name="cab_id_prev_pg"         , from="ParlGov", group="3 ParlGov", description="ParlGov cabinet ID of previous cabinet"),
list(name="cab_name_pg"            , from="ParlGov", group="3 ParlGov", description="ParlGov cabinet name"),
list(name="cab_start_pg"           , from="ParlGov", group="3 ParlGov", description="ParlGov start date of cabinet"),
list(name="el_date_pg"             , from="ParlGov", group="3 ParlGov", description="ParlGov elections date of cabinet"),
list(name="el_first_pg"            , from="ParlGov", group="3 ParlGov", description="Wether or not this is the first election found in ParlGov data."),
list(name="el_id_pg"               , from="ParlGov", group="3 ParlGov - derived", description="ParlGov election ID"),

list(name="idl"                    , from="CMP", group="4 CMP", description="Right-left position of party as given in Michael Laver/Ian Budge (eds.): Party Policy and Government Coalitions, Houndmills, Basingstoke, Hampshire: The MacMillan Press 1992: (per104 + per201 + per203 + per305 + per401 + per402 + per407 + per414 + per505 + per601 + per603 + per605 + per606) - (per103 + per105 + per106 + per107 + per403 + per404 + per406 + per412 + per413 + per504 + per506 + per701 + per202). -- Missing information (eg. if progtype = 99) (CMP 2015)"),

list(name="idl_dist_gop"           , from="CMP derived", group="4 CMP - derived", description="Sum of weighted absolute deviations of opposition parties' ideological positions from the government position.  $$ idl\\_dist\\_gop = mean( |(idl\\_pnt\\_gov - idl_{i|cabinet\\_party==0})| * seats\\_share\\_opp_{i|cabinet\\_party==0}$$"),
list(name="idl_pnt_all"            , from="CMP derived", group="4 CMP - derived", description="Weighted mean of all left-right positions of parties in parliament.  $$idl\\_pnt\\_all = \\sum( idl_i * seats\\_share_i )$$"),
list(name="idl_pnt_gov"            , from="CMP derived", group="4 CMP - derived", description="Weighted mean of left-right positions of parties in parliament given government.  $$idl\\_pnt\\_all = \\sum( idl_{i|cabinet\\_party==1} * seats\\_share_{i|cabinet\\_party==1} )$$"),
list(name="idl_pnt_opp"            , from="CMP derived", group="4 CMP - derived", description="Weighted mean of left-right positions of parties in parliament given opposition.  $$idl\\_pnt\\_all = \\sum( idl_{i|cabinet\\_party==0} * seats\\_share_{i|cabinet\\_party==0} )$$"),
list(name="idl_pol_all"            , from="CMP derived", group="4 CMP - derived", description="Sum of weighted absolut deviations of party ideological positions from overall position  $$idl\\_pol\\_all = \\sum(  | (idl_i - idl\\_pnt\\_all) | * seats\\_share_i )$$"),
list(name="idl_pol_gov"            , from="CMP derived", group="4 CMP - derived", description="Sum of weighted absolut deviations of party ideological positions from overall position  $$idl\\_pol\\_gov = \\sum(  | (idl_{i|cabinet\\_party==1} - idl\\_pnt\\_gov) | * seats\\_share_{i|cabinet\\_party==1} )$$"),
list(name="idl_pol_opp"            , from="CMP derived", group="4 CMP - derived", description="Sum of weighted absolut deviations of party ideological positions from overall position  $$idl\\_pol\\_opp = \\sum(  | (idl_{i|cabinet\\_party==0} - idl\\_pnt\\_opp) | * seats\\_share_{i|cabinet\\_party==0} )$$"),
list(name="idl_rng_all"            , from="CMP derived", group="4 CMP - derived", description="Range of left-right positions  $$idl\\_rng\\_all = max(idl_i) - min(idl_i)$$"),
list(name="idl_rng_gov"            , from="CMP derived", group="4 CMP - derived", description="Range of left-right positions given the parties belong to governemnt  $$idl\\_rng\\_gov = max(idl_{i|cabinet\\_party==1}) - min(idl_{i|cabinet\\_party==1})$$"),
list(name="idl_rng_opp"            , from="CMP derived", group="4 CMP - derived", description="Range of left-right positions given the parties belong to Opposition  $$idl\\_rng\\_opp = max(idl_{i|cabinet\\_party==0}) - min(idl_{i|cabinet\\_party==0})$$"),

list(name="n_parties"              , from="ParlGov derived", group="ParlGov - derived", description="The number of parties in parliament."),
list(name="seats_gov"              , from="ParlGov derived", group="ParlGov - derived", description="Seats of government in parliament."),
list(name="seats_opp"              , from="ParlGov derived", group="ParlGov - derived", description="Seats of opposition in parliament."),
list(name="sts_tot_pg"             , from="ParlGov", group="ParlGov", description="Seats in parliament."),

list(name="volatility"             , from="ParlGov derived", group="ParlGov derived", description="The sum of absolute percentage changes in election results from $t-1$ to $t$ for all parties. $$volatility = \\sum |(seats\\_percent_{i,t} - seats\\_percent_{i,t-1})|$$"),

list(name="tsb_agc"                , from="Tsebelis ",  group="5 Tsebelis", description="Tsebelis original 2002, page 182 governenment control of the legislative agenda measure. See ext_tsb_agc1 for further description."),
  list(name="ext_tsb_agc1"         , from="Tsebelis ",  group="5 Tsebelis derived", 
    description=
    "This variable is based on *George Tsebelis (2002): Veto Players: How Political Institutions Work, Princeton* table 7.3 at page 182 and 
    measures governenment control of the legislative agenda. 
     
The cross section values found in the table were assigned to those SO versions that were enacted in 1985 (when the agenda control measure was gathered).
To extrapolate the measure over time it was: 
1) multiplied by the number of words for those 1985 versions, 
2) the change in majority prone and minority prone words was added (majority words as positives, minority words as negatives)
3) these text lengths were again divided by the lengths of the 1985 versions.

Because it is unclear which numeric relation the agenda control measure and the change of pro majority / pro minority words might hold 
(one would need a second time point to determine that) the varaible exists in three variations: ext_tsb_agc1, ext_tsb_agc2 and ext_tsb_agc4.
The numbers indicate by which factor the change in majority/minority friendly words was multiplied to give it an higher impact (1, 2, 4) thus increasing the variance
of the agenda control extrapolation. 
     "),
  list(name="ext_tsb_agc2"       , from="Tsebelis ",                             group="5 Tsebelis derived", description="See ext_tsb_agc1."),
  list(name="ext_tsb_agc4"       , from="Tsebelis ",                             group="5 Tsebelis derived", description="See ext_tsb_agc1."),
  list(name="pro_minmaj_qual"    , from="ISOR textlines, linelinkage, manual coding", group="1 ISOR", 
    description="Whether or not the reform in general was pro majority (1), pro minority (-1) or neither (0), 
the decission was made by comparing the number of sub-paragraphs/lines changed in each direction.
If there was no change in favor of majority but changes in favor of minority it was considered minority friendly and vice versa.
If changes in both directions took place there the differences in the SO texts were cosidered. 

Find below the coding of all non-trivial cases ... $$ diff = pro\\_maj - pro\\_min $$ $$ ratio\\_pro = (pro\\_maj - pro\\_min) / (pro\\_maj + pro\\_min) $$ $$ ratio\\_all = (pro\\_maj - pro\\_min) / (pro\\_maj + pro\\_min + pro\\_none) $$ 
    
|t_id               | pro_maj| pro_min| pro_non| pro_minmaj_qual| diff| ratio_pro| ratio_all|
|:------------------|-------:|-------:|-------:|---------------:|----:|---------:|---------:|
|`FRA_1994-03-12.0` |      29|       1|     134|               1|   28|      0.93|      0.17|
|`LUX_2003-11-27.0` |      14|       1|      88|               1|   13|      0.87|      0.13|
|`ITA_1983-11-30.0` |      13|       1|      26|               1|   12|      0.86|      0.30|
|`DEN_1976-10-05.0` |      12|       1|      21|               1|   11|      0.85|      0.32|
|`NED_1947-07-08.0` |       8|       1|      22|               1|    7|      0.78|      0.23|
|`BEL_1985-04-25.0` |       8|       1|     157|               1|    7|      0.78|      0.04|
|`NED_1994-05-17.0` |      21|       3|     347|               1|   18|      0.75|      0.05|
|`LUX_2000-07-01.0` |      24|       4|     150|               1|   20|      0.71|      0.11|
|`DEN_1981-06-01.0` |       9|       2|      54|               1|    7|      0.64|      0.11|
|`SWE_2007-01-01.1` |       4|       1|      16|               1|    3|      0.60|      0.14|
|`SWE_1949-04-06.0` |      10|       3|      53|              -1|    7|      0.54|      0.11|
|`LUX_2007-03-15.0` |       6|       2|      43|               1|    4|      0.50|      0.08|
|`LUX_2010-07-15.0` |       3|       1|       6|               0|    2|      0.50|      0.20|
|`ITA_1982-01-12.0` |       3|       1|       9|               0|    2|      0.50|      0.15|
|`SWE_1998-10-01.0` |       3|       1|      23|               1|    2|      0.50|      0.07|
|`NED_1986-06-24.0` |       3|       1|      53|               1|    2|      0.50|      0.04|
|`NOR_2009-10-01.4` |       3|       1|      96|               1|    2|      0.50|      0.02|
|`ITA_1986-09-01.2` |      11|       5|      16|               1|    6|      0.38|      0.19|
|`GER_1952-01-01.0` |      12|       6|     208|              -1|    6|      0.33|      0.03|
|`ESP_1982-03-06.0` |       8|       4|     705|              -1|    4|      0.33|      0.01|
|`SWE_2003-07-01.0` |       8|       4|     476|               1|    4|      0.33|      0.01|
|`UK_2005-10-10.0 ` |       6|       3|      29|               1|    3|      0.33|      0.08|
|`POR_1984-03-16.0` |       6|       3|      83|              -1|    3|      0.33|      0.03|
|`BEL_2003-10-12.0` |       6|       3|     111|               1|    3|      0.33|      0.02|
|`DEN_1959-04-29.0` |       4|       2|      14|               1|    2|      0.33|      0.10|
|`ITA_1982-01-29.0` |       2|       1|       5|               1|    1|      0.33|      0.12|
|`GER_1986-12-18.0` |       2|       1|      31|               1|    1|      0.33|      0.03|
|`NED_1953-07-09.0` |       2|       1|      35|              -1|    1|      0.33|      0.03|
|`BEL_1990-07-12.0` |       2|       1|      68|               1|    1|      0.33|      0.01|
|`IRE_2010-12-02.0` |       2|       1|     135|              -1|    1|      0.33|      0.01|
|`NED_1966-07-12.0` |      14|       8|     432|               1|    6|      0.27|      0.01|
|`BEL_1962-02-08.0` |      12|       7|     383|               1|    5|      0.26|      0.01|
|`DEN_1997-05-27.0` |       5|       3|      69|               0|    2|      0.25|      0.03|
|`SWE_1974-02-28.0` |       8|       5|     381|               1|    3|      0.23|      0.01|
|`SWE_1996-01-01.0` |       9|       6|      10|               0|    3|      0.20|      0.12|
|`BEL_1998-10-13.0` |       6|       4|     313|               1|    2|      0.20|      0.01|
|`NED_2006-06-29.0` |       3|       2|      21|              -1|    1|      0.20|      0.04|
|`AUT_1986-09-01.0` |       3|       2|      34|              -1|    1|      0.20|      0.03|
|`BEL_1995-06-08.0` |       3|       2|      71|              -1|    1|      0.20|      0.01|
|`AUT_1996-10-15.0` |      32|      23|      90|               1|    9|      0.16|      0.06|
|`DEN_2004-01-01.0` |       4|       3|      31|               1|    1|      0.14|      0.03|
|`SWE_1995-01-01.1` |       4|       3|      60|               1|    1|      0.14|      0.01|
|`DEN_1966-01-01.0` |      10|       8|      69|               0|    2|      0.11|      0.02|
|`DEN_1989-05-12.0` |       5|       4|      48|               1|    1|      0.11|      0.02|
|`LUX_1991-01-01.0` |      44|      40|     271|              -1|    4|      0.05|      0.01|
|`AUT_1993-09-15.0` |      12|      12|      52|               1|    0|      0.00|      0.00|
|`BEL_1973-04-26.0` |       1|       1|      11|               0|    0|      0.00|      0.00|
|`BEL_1982-10-26.0` |       1|       1|      13|               1|    0|      0.00|      0.00|
|`BEL_2005-05-19.0` |       1|       1|       6|               0|    0|      0.00|      0.00|
|`DEN_1969-10-07.0` |       2|       2|      20|               0|    0|      0.00|      0.00|
|`DEN_1986-12-17.0` |       1|       1|       6|               0|    0|      0.00|      0.00|
|`DEN_2004-12-16.0` |       1|       1|      20|               1|    0|      0.00|      0.00|
|`GER_1972-10-19.0` |       1|       1|      17|              -1|    0|      0.00|      0.00|
|`IRE_1996-10-15.0` |       2|       2|     181|               0|    0|      0.00|      0.00|
|`ITA_1983-12-14.0` |       1|       1|       9|              -1|    0|      0.00|      0.00|
|`LUX_1998-03-01.0` |       3|       3|      10|              -1|    0|      0.00|      0.00|
|`NED_1952-04-01.0` |       2|       2|      14|               0|    0|      0.00|      0.00|
|`NED_1956-05-03.0` |       2|       2|      12|              -1|    0|      0.00|      0.00|
|`NOR_1989-10-02.0` |       3|       3|      60|               1|    0|      0.00|      0.00|
|`NOR_1996-10-01.0` |       2|       2|      15|               1|    0|      0.00|      0.00|
|`SWE_1988-09-01.0` |       2|       2|      12|               0|    0|      0.00|      0.00|
|`SWE_1993-01-01.0` |       1|       1|      16|               1|    0|      0.00|      0.00|
|`SWE_2009-12-01.0` |       1|       1|      23|               0|    0|      0.00|      0.00|
|`UK_1991-01-29.0 ` |       1|       1|       4|               1|    0|      0.00|      0.00|
|`SWE_1971-01-01.0` |       3|       4|     180|              -1|   -1|     -0.14|     -0.01|
|`DEN_1972-10-03.0` |       3|       4|      48|               0|   -1|     -0.14|     -0.02|
|`AUT_1989-01-01.0` |      25|      34|     156|              -1|   -9|     -0.15|     -0.04|
|`GER_1970-05-22.0` |       2|       3|      46|              -1|   -1|     -0.20|     -0.02|
|`NED_2004-03-31.0` |       2|       3|      39|              -1|   -1|     -0.20|     -0.02|
|`DEN_2007-06-01.0` |       2|       3|      16|              -1|   -1|     -0.20|     -0.05|
|`BEL_1993-10-27.0` |       3|       5|      87|              -1|   -2|     -0.25|     -0.02|
|`AUT_1975-10-01.0` |      24|      40|     316|              -1|  -16|     -0.25|     -0.04|
|`FRA_1969-11-30.0` |       9|      16|     151|              -1|   -7|     -0.28|     -0.04|
|`POR_2003-01-17.0` |       1|       2|     443|              -1|   -1|     -0.33|      0.00|
|`IRE_1997-11-13.0` |       1|       2|     161|              -1|   -1|     -0.33|     -0.01|
|`FRA_1995-11-11.0` |       1|       2|      53|              -1|   -1|     -0.33|     -0.02|
|`DEN_1971-10-05.0` |       1|       2|      17|               0|   -1|     -0.33|     -0.05|
|`ITA_1971-04-30.0` |       7|      15|     539|              -1|   -8|     -0.36|     -0.01|
|`ITA_1998-01-01.0` |       3|       7|      92|              -1|   -4|     -0.40|     -0.04|
|`POR_1985-03-06.0` |       2|       5|     821|              -1|   -3|     -0.43|      0.00|
|`BEL_1987-01-28.0` |       2|       5|     102|              -1|   -3|     -0.43|     -0.03|
|`DEN_1999-05-25.0` |       2|       5|      34|              -1|   -3|     -0.43|     -0.07|
|`DEN_1953-12-17.0` |      10|      27|     118|              -1|  -17|     -0.46|     -0.11|
|`SWE_1996-02-01.0` |       3|       9|      18|              -1|   -6|     -0.50|     -0.20|
|`AUT_1961-09-01.0` |       4|      13|      95|              -1|   -9|     -0.53|     -0.08|
|`DEN_1947-10-07.0` |       2|       7|      88|              -1|   -5|     -0.56|     -0.05|
|`AUT_1998-01-01.0` |       1|       4|      78|              -1|   -3|     -0.60|     -0.04|
|`ITA_1982-01-16.0` |       1|       6|       3|              -1|   -5|     -0.71|     -0.50|
|`FRA_2009-06-25.0` |       4|      34|     385|              -1|  -30|     -0.79|     -0.07|
|`GER_1980-10-01.0` |       1|       9|     253|              -1|   -8|     -0.80|     -0.03|

    "),
  list(name="pro_minmaj_auto1" , from="ISOR textlines, linelinkage, manual coding", group="1 ISOR",  description="Whether or not the reform in general was pro majority (1), pro minority (-1) or neither (0), the decission was made autoamitcally by comparing the number of words changed in each direction."),
  list(name="pro_minmaj_auto2" , from="ISOR textlines, linelinkage, manual coding", group="1 ISOR",  description="Whether or not the reform in general was pro majority (1), pro minority (-1) or neither (0), the decission was made autoamitcally by comparing the number of lines changed in each direction.")
)

var_desc_erd <- as.data.frame(var_desc_erd)
var_desc_erd <- 
  data_frame(
    name  = unlist(var_desc_erd$name),
    from  = unlist(var_desc_erd$from),
    group = unlist(var_desc_erd$group), 
    desc  = unlist(var_desc_erd$description)
  )





















