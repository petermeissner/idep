var_desc_isom <- 
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
list(name="erd_pg_mp_matcher"      , from="ERD/ParlGov", group="9 ERD - ParlGov", description="Variable used to merge/join records/observations from ERD with that of ParlGov/CMP dataset after matching them via the date the cabinet went into office."),
list(name="erd_cab_id"             , from="ERD/ISOR",    group="9 ERD - ParlGov", description="Variable used to merge/join records/observations from ERD and ISOR dataset after matching them via reform date and whether or not that falls within the time span of a cabinet. \n\n If however - as was some 20 times the case a Standing Orders reform was made while no cabinet was formally in charge of the government, we looked into the cases and decided upon the situation found and tahn assigning the reform either to the previous or the following cabinet. "),

list(name="cab_id_pg"              , from="ParlGov", group="3 ParlGov", description="ParlGov cabinet ID"),
list(name="cab_id_prev_pg"         , from="ParlGov", group="3 ParlGov", description="ParlGov cabinet ID of previous cabinet"),
list(name="cab_name_pg"            , from="ParlGov", group="3 ParlGov", description="ParlGov cabinet name"),
list(name="cab_start_pg"           , from="ParlGov", group="3 ParlGov", description="ParlGov start date of cabinet"),
list(name="el_date_pg"             , from="ParlGov", group="3 ParlGov", description="ParlGov elections date of cabinet"),
list(name="el_first_pg"            , from="ParlGov", group="3 ParlGov", description="Wether or not this is the first election found in ParlGov data."),
list(name="el_id_pg"               , from="ParlGov", group="3 ParlGov - derived", description="ParlGov election ID"),
list(name="sts_tot_pg"             , from="ParlGov", group="3 ParlGov", description="Seats in parliament."),
list(name="n_parties"              , from="ParlGov", group="3 ParlGov - derived", description="The number of parties in parliament."),
list(name="seats_gov"              , from="ParlGov", group="3 ParlGov - derived", description="Seats of government in parliament."),
list(name="seats_opp"              , from="ParlGov", group="3 ParlGov - derived", description="Seats of opposition in parliament."),
list(name="volatility"             , from="ParlGov", group="3 ParlGov - derived", description="The sum of absolute percentage changes in election results from $t-1$ to $t$ for all parties. $$volatility = \\sum |(seats\\_percent_{i,t} - seats\\_percent_{i,t-1})|$$"),


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
  list(name="pro_minmaj_qual_all", from="ISOR textlines, linelinkage, manual coding", group="ISOR", description="List of all refomrms within cabinet duration. See  pro_minmaj_qual for more details."),
  
  list(name="pro_minmaj_qual"    , from="ISOR textlines, linelinkage, manual coding", group="ISOR", 
    description="Whether or not the reforms amde by the cabinet were in general was pro majority (1), pro minority (-1) or neither (0), 
the decission was made by comparing the number of sub-paragraphs/lines changed in each direction.
If there was no change in favor of majority but changes in favor of minority it was considered minority friendly and vice versa.
If changes in both directions took place the differences in the SO texts were cosidered. 

Below are listed those cabinets that had to be 

|ctr | cab_id|cab_pm         |cab_in     |cab_out    | ...maj | ...min | pro_minmaj_qual|
|:---|------:|:--------------|:----------|:----------|-----------:|-----------:|---------------:|
|bel |    228|Martens V      |1981-12-17 |1985-10-13 |           9|           6|               1|
|fra |    527|de Villepin    |2005-05-31 |2007-05-15 |           1|           2|               0|
|deu |    613|Kiesinger      |1966-12-01 |1969-09-28 |           2|          27|              -1|
|irl |    925|Cowen I        |2008-05-07 |2011-01-23 |           4|           1|               1|
|ita |   1005|De Gasperi VI  |1950-01-21 |1951-07-16 |           4|           1|               1|
|ita |   1036|Spadolini      |1981-06-28 |1982-08-07 |           6|           8|               1|
|ita |   1038|Craxi          |1983-08-04 |1986-07-27 |          25|           8|               1|
|ita |   1042|Andreotti V    |1989-07-23 |1991-03-29 |           5|           5|              -1|
|nld |   1214|Den Uyl        |1973-05-11 |1977-03-22 |           1|           2|               0|
|nld |   1221|Kok I          |1994-08-22 |1998-05-05 |           1|           1|               0|
|nld |   1224|Balkenende II  |2003-05-27 |2006-06-29 |           7|           5|               0|
|nor |   1328|Bondevik II    |2001-10-19 |2005-09-12 |           2|           7|              -1|
|nor |   1329|Stoltenberg II |2005-10-17 |2009-09-14 |           3|           7|              -1|
|prt |   1410|Soares III     |1983-06-09 |1985-07-12 |          10|           8|              -1|
|swe |   1622|Carlsson II    |1988-09-18 |1991-09-15 |           8|           1|               1|
|swe |   1624|Carlsson III   |1994-10-06 |1996-03-18 |          19|          20|               0|
|gbr |   1710|Wilson II      |1966-04-18 |1970-06-18 |           2|           1|               1|
|gbr |   1718|Major I        |1990-11-28 |1992-03-16 |           1|           2|               0|
|gbr |   1719|Major II       |1992-04-27 |1997-05-01 |           2|           2|              -1|
|gbr |   1720|Blair I        |1997-05-02 |2001-06-07 |           1|          15|              -1|
|gbr |   1723|Brown          |2007-06-27 |2010-05-06 |           2|           1|               0|


Correlations:

|                 | pro_minmaj_qual| pro_minmaj_auto1| pro_minmaj_auto2|
|:----------------|---------------:|----------------:|----------------:|
|pro_minmaj_qual  |            1.00|             0.84|             0.78|
|pro_minmaj_auto1 |            0.84|             1.00|             0.85|
|pro_minmaj_auto2 |            0.78|             0.85|             1.00|

    "),
  list(name="pro_minmaj_auto1" , from="ISOR textlines, linelinkage, manual coding", group="ISOR",  description="Whether or not the reform in general was pro majority (1), pro minority (-1) or neither (0), the decission was made autoamitcally by comparing the number of words changed in each direction."),
  list(name="pro_minmaj_auto2" , from="ISOR textlines, linelinkage, manual coding", group="ISOR",  description="Whether or not the reform in general was pro majority (1), pro minority (-1) or neither (0), the decission was made autoamitcally by comparing the number of lines changed in each direction."),
  
  
  list(name="country"          , from="texts", group="ISOR", description="Name of the country."),
  list(name="ctr"              , from="texts", group="ISOR", description="Country shorthand adhering to ISO 3166-1 alpha-3 https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3"),
  
  list(name="ref_id_fst"       , from="texts", group="ISOR", description="Unique identifier of reform by including country shorthand, date, and version counter."),
  list(name="ref_id_lst"       , from="texts", group="ISOR", description="Unique identifier of reform by including country shorthand, date, and version counter."),
  list(name="ref_id_all"       , from="texts", group="ISOR", description="identifier of reform by including country shorthand, date, and version counter."),
  
  list(name="ref_n"       , from="texts", group="ISOR", description="Number of SO reforms within cabinet duration. Equals NA/missing if no information was available."),
  
  list(name="ref_date_fst"           , from="texts", group="ISOR", description="Date of the SO version - equals to (according to availibility) enactment, promulgation, acceptance."),
  list(name="ref_dplus_fst"          , from="texts", group="ISOR", description="Version counter that is zero under normal circumstances but might be higher if more than one version got enacted on the same date.")
)

var_desc_isom <- as.data.frame(var_desc_isom)
var_desc_isom <- 
  data_frame(
    name  = unlist(var_desc_isom$name),
    from  = unlist(var_desc_isom$from),
    group = unlist(var_desc_isom$group), 
    desc  = unlist(var_desc_isom$description)
  )

  
  

















