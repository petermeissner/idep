# script for joining / merging erd, isor, parlgov, 


#### setting things up =========================================================

setwd("z:/gesch\u00e4ftsordnungen/database/aggregats/")  

library(idep)
library(dplyr)
library(foreign)


#### loading data ==============================================================

load("isor.Rdata")
isor[,1:8]

isor_so <- 
  isor  %>% 
  select(t_id, t_date, t_dplus, t_country, t_daccept, t_dpromul, t_denact)

load("../external_data/erd_cleaned_up.Rdata")
erd[,1:11]
erd <- 
  erd %>% 
  mutate(
    erd_cab_id = cab_id
  )

load("../external_data/cmp_parlgov_cabinets_ideo_confl_volatility.Rdata")
cabinets[,1:10]



#### splitting isor data into changing vars and not-changing vars ==============

isor_names_so <- 
  c(
"t_id", "t_date", "t_dplus", 
"t_daccept", "t_dpromul", "t_denact", "int_dupdate_texts", 
"t_date_lag", "t_date_lead", 
"int_id_texts", "db_version", "db_lastupdate", 
"country", "ctr", "lang", 
"tsb_agc", "ext_tsb_agc1", "ext_tsb_agc2", "ext_tsb_agc4", 
"wdns", "wdns_corr", "wds_clean_rel_wdns_corr", 
"t_snc_lst_ref", "t_to_nxt_ref",
"lns_all", "wds_raw_all", 
"wds_clean_all", "lns_rel", 
"wds_raw_rel", "wds_clean_rel", 
"lns_corp_8", "lns_corp_9", "lns_corp_10", 
"lns_corp_21", "lns_corp_22", "lns_corp_23", "lns_corp_25", 
"lns_corp_26", "lns_corp_27", "lns_corp_28", "lns_corp_29", 
"lns_corp_31", "lns_corp_32", "lns_corp_33", "lns_corp_34", 
"lns_corp_43", "lns_corp_45", "lns_corp_51", "lns_corp_52", 
"lns_corp_53", "lns_corp_54", "lns_corp_55", "lns_corp_56", 
"lns_corp_66", "lns_corp_67", "lns_corp_68", "lns_corp_71", 
"lns_corp_72", "lns_corp_73", "lns_corp_111", "lns_corp_112", 
"lns_corp_113", "lns_corp_114", "lns_corp_121", "lns_corp_122", 
"lns_corp_123", "lns_corp_124", "lns_corp_125", "lns_corp_131", 
"lns_corp_132", "lns_corp_133", "lns_corp_134", "lns_corp_141", 
"lns_corp_142", "lns_corp_143", "lns_corp_144", "lns_corp_145", 
"lns_corp_241", "lns_corp_242", "lns_corp_243", "lns_corp_244", 
"lns_corp_411", "lns_corp_412", "lns_corp_421", "lns_corp_422", 
"lns_corp_441", "lns_corp_442", "lns_corp_611", "lns_corp_612", 
"lns_corp_613", "lns_corp_631", "lns_corp_632", "lns_corp_633", 
"lns_corp_634", "lns_corp_636", "lns_corp_637", "lns_corp_638", 
"lns_corp_639", "lns_corp_641", "lns_corp_642", "lns_corp_643", 
"lns_corp_651", "lns_corp_652", "lns_corp_653", "lns_corp_999", 
"lns_corp_6211", "lns_corp_6212", "lns_corp_6221", "lns_corp_6222", 
"lns_corp_6351", "lns_corp_6352", "wds_corp_8", "wds_corp_9", 
"wds_corp_10", "wds_corp_21", "wds_corp_22", "wds_corp_23", 
"wds_corp_25", "wds_corp_26", "wds_corp_27", "wds_corp_28", 
"wds_corp_29", "wds_corp_31", "wds_corp_32", "wds_corp_33", 
"wds_corp_34", "wds_corp_43", "wds_corp_45", "wds_corp_51", 
"wds_corp_52", "wds_corp_53", "wds_corp_54", "wds_corp_55", 
"wds_corp_56", "wds_corp_66", "wds_corp_67", "wds_corp_68", 
"wds_corp_71", "wds_corp_72", "wds_corp_73", "wds_corp_111", 
"wds_corp_112", "wds_corp_113", "wds_corp_114", "wds_corp_121", 
"wds_corp_122", "wds_corp_123", "wds_corp_124", "wds_corp_125", 
"wds_corp_131", "wds_corp_132", "wds_corp_133", "wds_corp_134", 
"wds_corp_141", "wds_corp_142", "wds_corp_143", "wds_corp_144", 
"wds_corp_145", "wds_corp_241", "wds_corp_242", "wds_corp_243", 
"wds_corp_244", "wds_corp_411", "wds_corp_412", "wds_corp_421", 
"wds_corp_422", "wds_corp_441", "wds_corp_442", "wds_corp_611", 
"wds_corp_612", "wds_corp_613", "wds_corp_631", "wds_corp_632", 
"wds_corp_633", "wds_corp_634", "wds_corp_636", "wds_corp_637", 
"wds_corp_638", "wds_corp_639", "wds_corp_641", "wds_corp_642", 
"wds_corp_643", "wds_corp_651", "wds_corp_652", "wds_corp_653", 
"wds_corp_999", "wds_corp_6211", "wds_corp_6212", "wds_corp_6221", 
"wds_corp_6222", "wds_corp_6351", "wds_corp_6352", "lns_corp_top_1", 
"lns_corp_top_2", "lns_corp_top_3", "lns_corp_top_4", "lns_corp_top_5", 
"lns_corp_top_66", "lns_corp_top_77", "wds_corp_top_1", "wds_corp_top_2", 
"wds_corp_top_3", "wds_corp_top_4", "wds_corp_top_5", "wds_corp_top_66", 
"wds_corp_top_77", "lns_corp_act_1", "lns_corp_act_2", "lns_corp_act_3", 
"lns_corp_act_4", "lns_corp_act_66", "lns_corp_act_77", "wds_corp_act_1", 
"wds_corp_act_2", "wds_corp_act_3", "wds_corp_act_4", "wds_corp_act_66", 
"wds_corp_act_77"
  )

isor_names_chg <- 
  c(
"t_id", "erd_cab_id", "t_date", "t_dplus", "t_country", 
"t_daccept", "t_dpromul", "t_denact", "db_version", "db_lastupdate",
"wds_chg", "wds_ins", "wds_del", "wds_mdf", 
"lns_chg", "lns_ins", "lns_del", "lns_mdf", 
"pro_maj", "pro_min", "pro_non", 
"pro_minmaj_qual", "pro_minmaj_auto1", "pro_minmaj_auto2", 
"pro_maj_mdf", "pro_min_mdf", "pro_non_mdf", 
"wds_pro_maj_mdf", "wds_pro_min_mdf", "wds_pro_non_mdf", 
"pro_maj_ins", "pro_min_ins", "pro_non_ins", 
"wds_pro_maj_ins", "wds_pro_min_ins", "wds_pro_non_ins", 
"pro_maj_del", "pro_min_del", "pro_non_del", 
"wds_pro_maj_del", "wds_pro_min_del", "wds_pro_non_del", 
"wds_pro_maj", "wds_pro_min", "wds_pro_non", 
"wds_corp_mdf_8", "wds_corp_mdf_21", "wds_corp_mdf_25", 
"wds_corp_mdf_51", "wds_corp_mdf_53", "wds_corp_mdf_54", "wds_corp_mdf_55", 
"wds_corp_mdf_56", "wds_corp_mdf_68", "wds_corp_mdf_71", "wds_corp_mdf_73", 
"wds_corp_mdf_111", "wds_corp_mdf_112", "wds_corp_mdf_113", "wds_corp_mdf_121", 
"wds_corp_mdf_122", "wds_corp_mdf_123", "wds_corp_mdf_125", "wds_corp_mdf_133", 
"wds_corp_mdf_134", "wds_corp_mdf_142", "wds_corp_mdf_143", "wds_corp_mdf_611", 
"wds_corp_mdf_612", "wds_corp_mdf_632", "wds_corp_mdf_637", "wds_corp_mdf_651", 
"wds_corp_mdf_6211", "wds_corp_mdf_6212", "wds_corp_mdf_10", "wds_corp_mdf_26", 
"wds_corp_mdf_32", "wds_corp_mdf_34", "wds_corp_mdf_52", "wds_corp_mdf_131", 
"wds_corp_mdf_132", "wds_corp_mdf_412", "wds_corp_mdf_633", "wds_corp_mdf_634", 
"wds_corp_mdf_636", "wds_corp_mdf_652", "wds_corp_mdf_6221", "wds_corp_mdf_6222", 
"wds_corp_mdf_411", "wds_corp_mdf_638", "wds_corp_mdf_641", "wds_corp_mdf_22", 
"wds_corp_mdf_23", "wds_corp_mdf_241", "wds_corp_mdf_613", "wds_corp_mdf_631", 
"wds_corp_mdf_639", "wds_corp_mdf_6352", "wds_corp_mdf_642", "wds_corp_mdf_29", 
"wds_corp_mdf_242", "wds_corp_mdf_124", "wds_corp_mdf_643", "wds_corp_mdf_33", 
"wds_corp_mdf_145", "wds_corp_mdf_72", "wds_corp_mdf_9", "wds_corp_mdf_653", 
"wds_corp_mdf_6351", "wds_corp_mdf_27", "wds_corp_mdf_442", "wds_corp_mdf_114", 
"wds_corp_mdf_141", "wds_corp_mdf_244", "wds_corp_mdf_43", "wds_corp_mdf_45", 
"wds_corp_mdf_31", "wds_corp_mdf_28", "wds_corp_mdf_144", "wds_corp_mdf_421", 
"wds_corp_mdf_422", "wds_corp_mdf_67", "wds_corp_mdf_243", "wds_corp_ins_6211", 
"wds_corp_ins_8", "wds_corp_ins_9", "wds_corp_ins_51", "wds_corp_ins_53", 
"wds_corp_ins_111", "wds_corp_ins_121", "wds_corp_ins_125", "wds_corp_ins_412", 
"wds_corp_ins_632", "wds_corp_ins_633", "wds_corp_ins_634", "wds_corp_ins_637", 
"wds_corp_ins_641", "wds_corp_ins_651", "wds_corp_ins_6221", "wds_corp_ins_6222", 
"wds_corp_ins_10", "wds_corp_ins_21", "wds_corp_ins_25", "wds_corp_ins_26", 
"wds_corp_ins_32", "wds_corp_ins_34", "wds_corp_ins_52", "wds_corp_ins_54", 
"wds_corp_ins_55", "wds_corp_ins_56", "wds_corp_ins_112", "wds_corp_ins_113", 
"wds_corp_ins_123", "wds_corp_ins_131", "wds_corp_ins_142", "wds_corp_ins_411", 
"wds_corp_ins_611", "wds_corp_ins_636", "wds_corp_ins_638", "wds_corp_ins_652", 
"wds_corp_ins_6212", "wds_corp_ins_145", "wds_corp_ins_22", "wds_corp_ins_23", 
"wds_corp_ins_43", "wds_corp_ins_134", "wds_corp_ins_612", "wds_corp_ins_241", 
"wds_corp_ins_243", "wds_corp_ins_72", "wds_corp_ins_114", "wds_corp_ins_242", 
"wds_corp_ins_244", "wds_corp_ins_631", "wds_corp_ins_639", "wds_corp_ins_642", 
"wds_corp_ins_6352", "wds_corp_ins_68", "wds_corp_ins_29", "wds_corp_ins_122", 
"wds_corp_ins_133", "wds_corp_ins_643", "wds_corp_ins_124", "wds_corp_ins_613", 
"wds_corp_ins_33", "wds_corp_ins_71", "wds_corp_ins_132", "wds_corp_ins_143", 
"wds_corp_ins_27", "wds_corp_ins_28", "wds_corp_ins_31", "wds_corp_ins_653", 
"wds_corp_ins_66", "wds_corp_ins_442", "wds_corp_ins_441", "wds_corp_ins_141", 
"wds_corp_ins_73", "wds_corp_ins_6351", "wds_corp_ins_45", "wds_corp_ins_144", 
"wds_corp_ins_422", "wds_corp_ins_67", "wds_corp_ins_421", "wds_corp_del_9", 
"wds_corp_del_51", "wds_corp_del_71", "wds_corp_del_121", "wds_corp_del_651", 
"wds_corp_del_22", "wds_corp_del_23", "wds_corp_del_25", "wds_corp_del_34", 
"wds_corp_del_53", "wds_corp_del_54", "wds_corp_del_55", "wds_corp_del_56", 
"wds_corp_del_111", "wds_corp_del_123", "wds_corp_del_142", "wds_corp_del_143", 
"wds_corp_del_611", "wds_corp_del_612", "wds_corp_del_633", "wds_corp_del_634", 
"wds_corp_del_652", "wds_corp_del_6211", "wds_corp_del_6212", "wds_corp_del_6351", 
"wds_corp_del_113", "wds_corp_del_637", "wds_corp_del_52", "wds_corp_del_241", 
"wds_corp_del_243", "wds_corp_del_26", "wds_corp_del_632", "wds_corp_del_10", 
"wds_corp_del_112", "wds_corp_del_114", "wds_corp_del_122", "wds_corp_del_125", 
"wds_corp_del_132", "wds_corp_del_613", "wds_corp_del_631", "wds_corp_del_639", 
"wds_corp_del_242", "wds_corp_del_68", "wds_corp_del_134", "wds_corp_del_72", 
"wds_corp_del_999", "wds_corp_del_131", "wds_corp_del_124", "wds_corp_del_636", 
"wds_corp_del_21", "wds_corp_del_29", "wds_corp_del_642", "wds_corp_del_8", 
"wds_corp_del_32", "wds_corp_del_33", "wds_corp_del_43", "wds_corp_del_133", 
"wds_corp_del_641", "wds_corp_del_653", "wds_corp_del_244", "wds_corp_del_6221", 
"wds_corp_del_6222", "wds_corp_del_441", "wds_corp_del_6352", "wds_corp_del_73", 
"wds_corp_del_638", "wds_corp_del_45", "wds_corp_del_411", "wds_corp_del_412", 
"wds_corp_del_27", "wds_corp_del_643", "wds_corp_del_28", "wds_corp_del_31", 
"wds_corp_del_421", "wds_corp_del_422", "wds_corp_del_141", "wds_corp_del_144", 
"lns_corp_mdf_8", "lns_corp_ins_8", 
"lns_corp_del_8", "lns_corp_mdf_9", "lns_corp_ins_9", "lns_corp_del_9", 
"lns_corp_mdf_10", "lns_corp_ins_10", "lns_corp_del_10", "lns_corp_mdf_21", 
"lns_corp_ins_21", "lns_corp_del_21", "lns_corp_mdf_22", "lns_corp_ins_22", 
"lns_corp_del_22", "lns_corp_mdf_23", "lns_corp_ins_23", "lns_corp_del_23", 
"lns_corp_mdf_25", "lns_corp_ins_25", "lns_corp_del_25", "lns_corp_mdf_26", 
"lns_corp_ins_26", "lns_corp_del_26", "lns_corp_mdf_27", "lns_corp_ins_27", 
"lns_corp_del_27", "lns_corp_mdf_28", "lns_corp_ins_28", "lns_corp_del_28", 
"lns_corp_mdf_29", "lns_corp_ins_29", "lns_corp_del_29", "lns_corp_mdf_31", 
"lns_corp_ins_31", "lns_corp_del_31", "lns_corp_mdf_32", "lns_corp_ins_32", 
"lns_corp_del_32", "lns_corp_mdf_33", "lns_corp_ins_33", "lns_corp_del_33", 
"lns_corp_mdf_34", "lns_corp_ins_34", "lns_corp_del_34", "lns_corp_mdf_43", 
"lns_corp_ins_43", "lns_corp_del_43", "lns_corp_mdf_45", "lns_corp_ins_45", 
"lns_corp_del_45", "lns_corp_mdf_51", "lns_corp_ins_51", "lns_corp_del_51", 
"lns_corp_mdf_52", "lns_corp_ins_52", "lns_corp_del_52", "lns_corp_mdf_53", 
"lns_corp_ins_53", "lns_corp_del_53", "lns_corp_mdf_54", "lns_corp_ins_54", 
"lns_corp_del_54", "lns_corp_mdf_55", "lns_corp_ins_55", "lns_corp_del_55", 
"lns_corp_mdf_56", "lns_corp_ins_56", "lns_corp_del_56", "wds_corp_mdf_66", 
"wds_corp_del_66", "lns_corp_mdf_66", "lns_corp_ins_66", "lns_corp_del_66", 
"wds_corp_del_67", "lns_corp_mdf_67", "lns_corp_ins_67", "lns_corp_del_67", 
"lns_corp_mdf_68", "lns_corp_ins_68", "lns_corp_del_68", "lns_corp_mdf_71", 
"lns_corp_ins_71", "lns_corp_del_71", "lns_corp_mdf_72", "lns_corp_ins_72", 
"lns_corp_del_72", "lns_corp_mdf_73", "lns_corp_ins_73", "lns_corp_del_73", 
"lns_corp_mdf_111", "lns_corp_ins_111", "lns_corp_del_111", "lns_corp_mdf_112", 
"lns_corp_ins_112", "lns_corp_del_112", "lns_corp_mdf_113", "lns_corp_ins_113", 
"lns_corp_del_113", "lns_corp_mdf_114", "lns_corp_ins_114", "lns_corp_del_114", 
"lns_corp_mdf_121", "lns_corp_ins_121", "lns_corp_del_121", "lns_corp_mdf_122", 
"lns_corp_ins_122", "lns_corp_del_122", "lns_corp_mdf_123", "lns_corp_ins_123", 
"lns_corp_del_123", "lns_corp_mdf_124", "lns_corp_ins_124", "lns_corp_del_124", 
"lns_corp_mdf_125", "lns_corp_ins_125", "lns_corp_del_125", "lns_corp_mdf_131", 
"lns_corp_ins_131", "lns_corp_del_131", "lns_corp_mdf_132", "lns_corp_ins_132", 
"lns_corp_del_132", "lns_corp_mdf_133", "lns_corp_ins_133", "lns_corp_del_133", 
"lns_corp_mdf_134", "lns_corp_ins_134", "lns_corp_del_134", "lns_corp_mdf_141", 
"lns_corp_ins_141", "lns_corp_del_141", "lns_corp_mdf_142", "lns_corp_ins_142", 
"lns_corp_del_142", "lns_corp_mdf_143", "lns_corp_ins_143", "lns_corp_del_143", 
"lns_corp_mdf_144", "lns_corp_ins_144", "lns_corp_del_144", "wds_corp_del_145", 
"lns_corp_mdf_145", "lns_corp_ins_145", "lns_corp_del_145", "lns_corp_mdf_241", 
"lns_corp_ins_241", "lns_corp_del_241", "lns_corp_mdf_242", "lns_corp_ins_242", 
"lns_corp_del_242", "lns_corp_mdf_243", "lns_corp_ins_243", "lns_corp_del_243", 
"lns_corp_mdf_244", "lns_corp_ins_244", "lns_corp_del_244", "lns_corp_mdf_411", 
"lns_corp_ins_411", "lns_corp_del_411", "lns_corp_mdf_412", "lns_corp_ins_412", 
"lns_corp_del_412", "lns_corp_mdf_421", "lns_corp_ins_421", "lns_corp_del_421", 
"lns_corp_mdf_422", "lns_corp_ins_422", "lns_corp_del_422", "wds_corp_mdf_441", 
"lns_corp_mdf_441", "lns_corp_ins_441", "lns_corp_del_441", "wds_corp_del_442", 
"lns_corp_mdf_442", "lns_corp_ins_442", "lns_corp_del_442", "lns_corp_mdf_611", 
"lns_corp_ins_611", "lns_corp_del_611", "lns_corp_mdf_612", "lns_corp_ins_612", 
"lns_corp_del_612", "lns_corp_mdf_613", "lns_corp_ins_613", "lns_corp_del_613", 
"lns_corp_mdf_631", "lns_corp_ins_631", "lns_corp_del_631", "lns_corp_mdf_632", 
"lns_corp_ins_632", "lns_corp_del_632", "lns_corp_mdf_633", "lns_corp_ins_633", 
"lns_corp_del_633", "lns_corp_mdf_634", "lns_corp_ins_634", "lns_corp_del_634", 
"lns_corp_mdf_636", "lns_corp_ins_636", "lns_corp_del_636", "lns_corp_mdf_637", 
"lns_corp_ins_637", "lns_corp_del_637", "lns_corp_mdf_638", "lns_corp_ins_638", 
"lns_corp_del_638", "lns_corp_mdf_639", "lns_corp_ins_639", "lns_corp_del_639", 
"lns_corp_mdf_641", "lns_corp_ins_641", "lns_corp_del_641", "lns_corp_mdf_642", 
"lns_corp_ins_642", "lns_corp_del_642", "lns_corp_mdf_643", "lns_corp_ins_643", 
"lns_corp_del_643", "lns_corp_mdf_651", "lns_corp_ins_651", "lns_corp_del_651", 
"lns_corp_mdf_652", "lns_corp_ins_652", "lns_corp_del_652", "lns_corp_mdf_653", 
"lns_corp_ins_653", "lns_corp_del_653", "wds_corp_mdf_999", "wds_corp_ins_999", 
"lns_corp_mdf_999", "lns_corp_ins_999", "lns_corp_del_999", "lns_corp_mdf_6211", 
"lns_corp_ins_6211", "lns_corp_del_6211", "lns_corp_mdf_6212", "lns_corp_ins_6212", 
"lns_corp_del_6212", "lns_corp_mdf_6221", "lns_corp_ins_6221", "lns_corp_del_6221", 
"lns_corp_mdf_6222", "lns_corp_ins_6222", "lns_corp_del_6222", "lns_corp_mdf_6351", 
"lns_corp_ins_6351", "lns_corp_del_6351", "lns_corp_mdf_6352", "lns_corp_ins_6352", 
"lns_corp_del_6352"
  )

isor_so  <- 
  isor[,isor_names_so]  %>% 
rename(
  so_t_id    = t_id, 
  so_start   = t_date,
  so_end     = t_date_lead,
  so_dplus   = t_dplus,
  so_daccept = t_daccept, 
  so_dpromul = t_dpromul, 
  so_denact  = t_denact
)

isor_chg <- 
  isor[,isor_names_chg]  %>% 
  rename(
    ref_t_id    = t_id, 
    ref_date    = t_date,
    ref_dplus   = t_dplus,
    ref_daccept = t_daccept, 
    ref_dpromul = t_dpromul, 
    ref_denact  = t_denact
  )





#### merging data:  erd and MP and PG ==========================================

# erd 1:1 parlgov
# -> simply join
#
# erd 1:1 manifesto project
# -> simply join
#
# erd 1:n isor_chg
# -> simply join and aggregate thereafter
#
# erd n:n isor_so
# -> join and aggregate in a separate step

isor_so[1:5]

isom <- 
  erd  %>% 
  left_join(cabinets, by="erd_pg_mp_matcher")   %>% 
  mutate(
    country = country.x,
    ctr     = ctr.x
  ) %>% 
  select(-country.x, -country.y, -ctr.x, -ctr.y)



#### setting variables right ===================================================
# - 88888 and 99999 to NA
# - leap days to Date

isom <- 
  as_data_frame( 
    lapply(
      isom, 
      function(x){ifelse(x %in% c(88888, 99999), NA, x)} 
    )
  )

isom$cab_in  <- as.Date(isom$cab_in,  origin="1970-01-01")
isom$cab_out <- as.Date(isom$cab_out, origin="1970-01-01")

# overview
desc_df(isom)



#### merging erd and isor_chg ==================================================

### preaparations 

isor_chg_joined <- 
  isom["cab_id"]  %>% 
  left_join(isor_chg, by=c(cab_id="erd_cab_id"))


isor_chg_joined %>% desc_df()


### adding number of reforms per cabinet
isor_chg_joined$ref_n <- NA
for(cabid in unique(isor_chg_joined$cab_id) ){
  iffer <- isor_chg_joined$cab_id == cabid
  isor_chg_joined$ref_n[iffer] <- 
    sum( !is.na(isor_chg_joined$ref_date[iffer]) )
}


### joining isom and reforms

#isom_ref_joined <- 
#  isom  %>% 
#  left_join(isor_ref_joined)



### aggregation

isor_chg_agg <- 
isor_chg_joined  %>% 
  arrange(cab_id, ref_date, ref_dplus) %>% 
  select(cab_id, ref_date, ref_dplus, ref_n, everything()) %>% 
  group_by(cab_id) %>%  
  summarise(
    ref_id_fst             = first(ref_t_id             ),
    ref_id_lst             = last( ref_t_id              ),
    ref_id_all             = paste(ref_t_id, collapse=", "),
    ref_n                  = max(ref_n),

    ref_date_fst             = first(ref_date    ),
    ref_dplus_fst            = first(ref_dplus   ),
    ref_daccept_fst          = first(ref_daccept ),
    ref_dpromul_fst          = first(ref_dpromul ),
    ref_denact_fst           = first(ref_denact  ),
    ref_date_lst             = last(ref_date    ),
    ref_dplus_lst            = last(ref_dplus   ),
    ref_daccept_lst          = last(ref_daccept ),
    ref_dpromul_lst          = last(ref_dpromul ),
    ref_denact_lst           = last(ref_denact  ),
    
    db_version             = first(db_version),
    db_lastupdate          = first(db_lastupdate),
    
    lns_chg_sum                = sum(lns_chg           ,na.rm=TRUE)    ,
    lns_mdf_sum                = sum(lns_mdf           ,na.rm=TRUE)    ,
    lns_ins_sum                = sum(lns_ins           ,na.rm=TRUE)    ,
    lns_del_sum                = sum(lns_del           ,na.rm=TRUE)    ,
    
    pro_maj_sum                = sum(pro_maj           ,na.rm=TRUE)    ,
    pro_min_sum                = sum(pro_min           ,na.rm=TRUE)    ,
    pro_non_sum                = sum(pro_non           ,na.rm=TRUE)    ,
    pro_maj_mdf_sum            = sum(pro_maj_mdf       ,na.rm=TRUE)    ,
    pro_min_mdf_sum            = sum(pro_min_mdf       ,na.rm=TRUE)    ,
    pro_non_mdf_sum            = sum(pro_non_mdf       ,na.rm=TRUE)    ,
    pro_maj_ins_sum            = sum(pro_maj_ins       ,na.rm=TRUE)    ,
    pro_min_ins_sum            = sum(pro_min_ins       ,na.rm=TRUE)    ,
    pro_non_ins_sum            = sum(pro_non_ins       ,na.rm=TRUE)    ,
    pro_maj_del_sum            = sum(pro_maj_del       ,na.rm=TRUE)    ,
    pro_min_del_sum            = sum(pro_min_del       ,na.rm=TRUE)    ,
    pro_non_del_sum            = sum(pro_non_del       ,na.rm=TRUE)    ,
    
    wds_chg_sum                = sum(wds_chg           ,na.rm=TRUE)    ,
    wds_mdf_sum                = sum(wds_mdf           ,na.rm=TRUE)    ,
    wds_ins_sum                = sum(wds_ins           ,na.rm=TRUE)    ,
    wds_del_sum                = sum(wds_del           ,na.rm=TRUE)    ,
    
    wds_pro_maj_sum            = sum(wds_pro_maj       ,na.rm=TRUE)    ,
    wds_pro_min_sum            = sum(wds_pro_min       ,na.rm=TRUE)    ,
    wds_pro_non_sum            = sum(wds_pro_non       ,na.rm=TRUE)    ,
    wds_pro_maj_mdf_sum        = sum(wds_pro_maj_mdf   ,na.rm=TRUE)    ,
    wds_pro_min_mdf_sum        = sum(wds_pro_min_mdf   ,na.rm=TRUE)    ,
    wds_pro_non_mdf_sum        = sum(wds_pro_non_mdf   ,na.rm=TRUE)    ,
    wds_pro_maj_ins_sum        = sum(wds_pro_maj_ins   ,na.rm=TRUE)    ,
    wds_pro_min_ins_sum        = sum(wds_pro_min_ins   ,na.rm=TRUE)    ,
    wds_pro_non_ins_sum        = sum(wds_pro_non_ins   ,na.rm=TRUE)    ,
    wds_pro_maj_del_sum        = sum(wds_pro_maj_del   ,na.rm=TRUE)    ,
    wds_pro_min_del_sum        = sum(wds_pro_min_del   ,na.rm=TRUE)    ,
    wds_pro_non_del_sum        = sum(wds_pro_non_del   ,na.rm=TRUE)    ,
    
    
    wds_corp_del_10_sum        = sum(wds_corp_del_10        , na.rm=TRUE),
    wds_corp_del_111_sum       = sum(wds_corp_del_111       , na.rm=TRUE),
    wds_corp_del_112_sum       = sum(wds_corp_del_112       , na.rm=TRUE),
    wds_corp_del_113_sum       = sum(wds_corp_del_113       , na.rm=TRUE),
    wds_corp_del_114_sum       = sum(wds_corp_del_114       , na.rm=TRUE),
    wds_corp_del_121_sum       = sum(wds_corp_del_121       , na.rm=TRUE),
    wds_corp_del_122_sum       = sum(wds_corp_del_122       , na.rm=TRUE),
    wds_corp_del_123_sum       = sum(wds_corp_del_123       , na.rm=TRUE),
    wds_corp_del_124_sum       = sum(wds_corp_del_124       , na.rm=TRUE),
    wds_corp_del_125_sum       = sum(wds_corp_del_125       , na.rm=TRUE),
    wds_corp_del_131_sum       = sum(wds_corp_del_131       , na.rm=TRUE),
    wds_corp_del_132_sum       = sum(wds_corp_del_132       , na.rm=TRUE),
    wds_corp_del_133_sum       = sum(wds_corp_del_133       , na.rm=TRUE),
    wds_corp_del_134_sum       = sum(wds_corp_del_134       , na.rm=TRUE),
    wds_corp_del_141_sum       = sum(wds_corp_del_141       , na.rm=TRUE),
    wds_corp_del_142_sum       = sum(wds_corp_del_142       , na.rm=TRUE),
    wds_corp_del_143_sum       = sum(wds_corp_del_143       , na.rm=TRUE),
    wds_corp_del_144_sum       = sum(wds_corp_del_144       , na.rm=TRUE),
    wds_corp_del_145_sum       = sum(wds_corp_del_145       , na.rm=TRUE),
    wds_corp_del_21_sum        = sum(wds_corp_del_21        , na.rm=TRUE),
    wds_corp_del_22_sum        = sum(wds_corp_del_22        , na.rm=TRUE),
    wds_corp_del_23_sum        = sum(wds_corp_del_23        , na.rm=TRUE),
    wds_corp_del_241_sum       = sum(wds_corp_del_241       , na.rm=TRUE),
    wds_corp_del_242_sum       = sum(wds_corp_del_242       , na.rm=TRUE),
    wds_corp_del_243_sum       = sum(wds_corp_del_243       , na.rm=TRUE),
    wds_corp_del_244_sum       = sum(wds_corp_del_244       , na.rm=TRUE),
    wds_corp_del_25_sum        = sum(wds_corp_del_25        , na.rm=TRUE),
    wds_corp_del_26_sum        = sum(wds_corp_del_26        , na.rm=TRUE),
    wds_corp_del_27_sum        = sum(wds_corp_del_27        , na.rm=TRUE),
    wds_corp_del_28_sum        = sum(wds_corp_del_28        , na.rm=TRUE),
    wds_corp_del_29_sum        = sum(wds_corp_del_29        , na.rm=TRUE),
    wds_corp_del_31_sum        = sum(wds_corp_del_31        , na.rm=TRUE),
    wds_corp_del_32_sum        = sum(wds_corp_del_32        , na.rm=TRUE),
    wds_corp_del_33_sum        = sum(wds_corp_del_33        , na.rm=TRUE),
    wds_corp_del_34_sum        = sum(wds_corp_del_34        , na.rm=TRUE),
    wds_corp_del_411_sum       = sum(wds_corp_del_411       , na.rm=TRUE),
    wds_corp_del_412_sum       = sum(wds_corp_del_412       , na.rm=TRUE),
    wds_corp_del_421_sum       = sum(wds_corp_del_421       , na.rm=TRUE),
    wds_corp_del_422_sum       = sum(wds_corp_del_422       , na.rm=TRUE),
    wds_corp_del_43_sum        = sum(wds_corp_del_43        , na.rm=TRUE),
    wds_corp_del_441_sum       = sum(wds_corp_del_441       , na.rm=TRUE),
    wds_corp_del_442_sum       = sum(wds_corp_del_442       , na.rm=TRUE),
    wds_corp_del_45_sum        = sum(wds_corp_del_45        , na.rm=TRUE),
    wds_corp_del_51_sum        = sum(wds_corp_del_51        , na.rm=TRUE),
    wds_corp_del_52_sum        = sum(wds_corp_del_52        , na.rm=TRUE),
    wds_corp_del_53_sum        = sum(wds_corp_del_53        , na.rm=TRUE),
    wds_corp_del_54_sum        = sum(wds_corp_del_54        , na.rm=TRUE),
    wds_corp_del_55_sum        = sum(wds_corp_del_55        , na.rm=TRUE),
    wds_corp_del_56_sum        = sum(wds_corp_del_56        , na.rm=TRUE),
    wds_corp_del_611_sum       = sum(wds_corp_del_611       , na.rm=TRUE),
    wds_corp_del_612_sum       = sum(wds_corp_del_612       , na.rm=TRUE),
    wds_corp_del_613_sum       = sum(wds_corp_del_613       , na.rm=TRUE),
    wds_corp_del_6211_sum      = sum(wds_corp_del_6211      , na.rm=TRUE),
    wds_corp_del_6212_sum      = sum(wds_corp_del_6212      , na.rm=TRUE),
    wds_corp_del_6221_sum      = sum(wds_corp_del_6221      , na.rm=TRUE),
    wds_corp_del_6222_sum      = sum(wds_corp_del_6222      , na.rm=TRUE),
    wds_corp_del_631_sum       = sum(wds_corp_del_631       , na.rm=TRUE),
    wds_corp_del_632_sum       = sum(wds_corp_del_632       , na.rm=TRUE),
    wds_corp_del_633_sum       = sum(wds_corp_del_633       , na.rm=TRUE),
    wds_corp_del_634_sum       = sum(wds_corp_del_634       , na.rm=TRUE),
    wds_corp_del_6351_sum      = sum(wds_corp_del_6351      , na.rm=TRUE),
    wds_corp_del_6352_sum      = sum(wds_corp_del_6352      , na.rm=TRUE),
    wds_corp_del_636_sum       = sum(wds_corp_del_636       , na.rm=TRUE),
    wds_corp_del_637_sum       = sum(wds_corp_del_637       , na.rm=TRUE),
    wds_corp_del_638_sum       = sum(wds_corp_del_638       , na.rm=TRUE),
    wds_corp_del_639_sum       = sum(wds_corp_del_639       , na.rm=TRUE),
    wds_corp_del_641_sum       = sum(wds_corp_del_641       , na.rm=TRUE),
    wds_corp_del_642_sum       = sum(wds_corp_del_642       , na.rm=TRUE),
    wds_corp_del_643_sum       = sum(wds_corp_del_643       , na.rm=TRUE),
    wds_corp_del_651_sum       = sum(wds_corp_del_651       , na.rm=TRUE),
    wds_corp_del_652_sum       = sum(wds_corp_del_652       , na.rm=TRUE),
    wds_corp_del_653_sum       = sum(wds_corp_del_653       , na.rm=TRUE),
    wds_corp_del_66_sum        = sum(wds_corp_del_66        , na.rm=TRUE),
    wds_corp_del_67_sum        = sum(wds_corp_del_67        , na.rm=TRUE),
    wds_corp_del_68_sum        = sum(wds_corp_del_68        , na.rm=TRUE),
    wds_corp_del_71_sum        = sum(wds_corp_del_71        , na.rm=TRUE),
    wds_corp_del_72_sum        = sum(wds_corp_del_72        , na.rm=TRUE),
    wds_corp_del_73_sum        = sum(wds_corp_del_73        , na.rm=TRUE),
    wds_corp_del_8_sum         = sum(wds_corp_del_8         , na.rm=TRUE),
    wds_corp_del_999_sum       = sum(wds_corp_del_999       , na.rm=TRUE),
    wds_corp_del_9_sum         = sum(wds_corp_del_9         , na.rm=TRUE),
    wds_corp_ins_10_sum        = sum(wds_corp_ins_10        , na.rm=TRUE),
    wds_corp_ins_111_sum       = sum(wds_corp_ins_111       , na.rm=TRUE),
    wds_corp_ins_112_sum       = sum(wds_corp_ins_112       , na.rm=TRUE),
    wds_corp_ins_113_sum       = sum(wds_corp_ins_113       , na.rm=TRUE),
    wds_corp_ins_114_sum       = sum(wds_corp_ins_114       , na.rm=TRUE),
    wds_corp_ins_121_sum       = sum(wds_corp_ins_121       , na.rm=TRUE),
    wds_corp_ins_122_sum       = sum(wds_corp_ins_122       , na.rm=TRUE),
    wds_corp_ins_123_sum       = sum(wds_corp_ins_123       , na.rm=TRUE),
    wds_corp_ins_124_sum       = sum(wds_corp_ins_124       , na.rm=TRUE),
    wds_corp_ins_125_sum       = sum(wds_corp_ins_125       , na.rm=TRUE),
    wds_corp_ins_131_sum       = sum(wds_corp_ins_131       , na.rm=TRUE),
    wds_corp_ins_132_sum       = sum(wds_corp_ins_132       , na.rm=TRUE),
    wds_corp_ins_133_sum       = sum(wds_corp_ins_133       , na.rm=TRUE),
    wds_corp_ins_134_sum       = sum(wds_corp_ins_134       , na.rm=TRUE),
    wds_corp_ins_141_sum       = sum(wds_corp_ins_141       , na.rm=TRUE),
    wds_corp_ins_142_sum       = sum(wds_corp_ins_142       , na.rm=TRUE),
    wds_corp_ins_143_sum       = sum(wds_corp_ins_143       , na.rm=TRUE),
    wds_corp_ins_144_sum       = sum(wds_corp_ins_144       , na.rm=TRUE),
    wds_corp_ins_145_sum       = sum(wds_corp_ins_145       , na.rm=TRUE),
    wds_corp_ins_21_sum        = sum(wds_corp_ins_21        , na.rm=TRUE),
    wds_corp_ins_22_sum        = sum(wds_corp_ins_22        , na.rm=TRUE),
    wds_corp_ins_23_sum        = sum(wds_corp_ins_23        , na.rm=TRUE),
    wds_corp_ins_241_sum       = sum(wds_corp_ins_241       , na.rm=TRUE),
    wds_corp_ins_242_sum       = sum(wds_corp_ins_242       , na.rm=TRUE),
    wds_corp_ins_243_sum       = sum(wds_corp_ins_243       , na.rm=TRUE),
    wds_corp_ins_244_sum       = sum(wds_corp_ins_244       , na.rm=TRUE),
    wds_corp_ins_25_sum        = sum(wds_corp_ins_25        , na.rm=TRUE),
    wds_corp_ins_26_sum        = sum(wds_corp_ins_26        , na.rm=TRUE),
    wds_corp_ins_27_sum        = sum(wds_corp_ins_27        , na.rm=TRUE),
    wds_corp_ins_28_sum        = sum(wds_corp_ins_28        , na.rm=TRUE),
    wds_corp_ins_29_sum        = sum(wds_corp_ins_29        , na.rm=TRUE),
    wds_corp_ins_31_sum        = sum(wds_corp_ins_31        , na.rm=TRUE),
    wds_corp_ins_32_sum        = sum(wds_corp_ins_32        , na.rm=TRUE),
    wds_corp_ins_33_sum        = sum(wds_corp_ins_33        , na.rm=TRUE),
    wds_corp_ins_34_sum        = sum(wds_corp_ins_34        , na.rm=TRUE),
    wds_corp_ins_411_sum       = sum(wds_corp_ins_411       , na.rm=TRUE),
    wds_corp_ins_412_sum       = sum(wds_corp_ins_412       , na.rm=TRUE),
    wds_corp_ins_421_sum       = sum(wds_corp_ins_421       , na.rm=TRUE),
    wds_corp_ins_422_sum       = sum(wds_corp_ins_422       , na.rm=TRUE),
    wds_corp_ins_43_sum        = sum(wds_corp_ins_43        , na.rm=TRUE),
    wds_corp_ins_441_sum       = sum(wds_corp_ins_441       , na.rm=TRUE),
    wds_corp_ins_442_sum       = sum(wds_corp_ins_442       , na.rm=TRUE),
    wds_corp_ins_45_sum        = sum(wds_corp_ins_45        , na.rm=TRUE),
    wds_corp_ins_51_sum        = sum(wds_corp_ins_51        , na.rm=TRUE),
    wds_corp_ins_52_sum        = sum(wds_corp_ins_52        , na.rm=TRUE),
    wds_corp_ins_53_sum        = sum(wds_corp_ins_53        , na.rm=TRUE),
    wds_corp_ins_54_sum        = sum(wds_corp_ins_54        , na.rm=TRUE),
    wds_corp_ins_55_sum        = sum(wds_corp_ins_55        , na.rm=TRUE),
    wds_corp_ins_56_sum        = sum(wds_corp_ins_56        , na.rm=TRUE),
    wds_corp_ins_611_sum       = sum(wds_corp_ins_611       , na.rm=TRUE),
    wds_corp_ins_612_sum       = sum(wds_corp_ins_612       , na.rm=TRUE),
    wds_corp_ins_613_sum       = sum(wds_corp_ins_613       , na.rm=TRUE),
    wds_corp_ins_6211_sum      = sum(wds_corp_ins_6211      , na.rm=TRUE),
    wds_corp_ins_6212_sum      = sum(wds_corp_ins_6212      , na.rm=TRUE),
    wds_corp_ins_6221_sum      = sum(wds_corp_ins_6221      , na.rm=TRUE),
    wds_corp_ins_6222_sum      = sum(wds_corp_ins_6222      , na.rm=TRUE),
    wds_corp_ins_631_sum       = sum(wds_corp_ins_631       , na.rm=TRUE),
    wds_corp_ins_632_sum       = sum(wds_corp_ins_632       , na.rm=TRUE),
    wds_corp_ins_633_sum       = sum(wds_corp_ins_633       , na.rm=TRUE),
    wds_corp_ins_634_sum       = sum(wds_corp_ins_634       , na.rm=TRUE),
    wds_corp_ins_6351_sum      = sum(wds_corp_ins_6351      , na.rm=TRUE),
    wds_corp_ins_6352_sum      = sum(wds_corp_ins_6352      , na.rm=TRUE),
    wds_corp_ins_636_sum       = sum(wds_corp_ins_636       , na.rm=TRUE),
    wds_corp_ins_637_sum       = sum(wds_corp_ins_637       , na.rm=TRUE),
    wds_corp_ins_638_sum       = sum(wds_corp_ins_638       , na.rm=TRUE),
    wds_corp_ins_639_sum       = sum(wds_corp_ins_639       , na.rm=TRUE),
    wds_corp_ins_641_sum       = sum(wds_corp_ins_641       , na.rm=TRUE),
    wds_corp_ins_642_sum       = sum(wds_corp_ins_642       , na.rm=TRUE),
    wds_corp_ins_643_sum       = sum(wds_corp_ins_643       , na.rm=TRUE),
    wds_corp_ins_651_sum       = sum(wds_corp_ins_651       , na.rm=TRUE),
    wds_corp_ins_652_sum       = sum(wds_corp_ins_652       , na.rm=TRUE),
    wds_corp_ins_653_sum       = sum(wds_corp_ins_653       , na.rm=TRUE),
    wds_corp_ins_66_sum        = sum(wds_corp_ins_66        , na.rm=TRUE),
    wds_corp_ins_67_sum        = sum(wds_corp_ins_67        , na.rm=TRUE),
    wds_corp_ins_68_sum        = sum(wds_corp_ins_68        , na.rm=TRUE),
    wds_corp_ins_71_sum        = sum(wds_corp_ins_71        , na.rm=TRUE),
    wds_corp_ins_72_sum        = sum(wds_corp_ins_72        , na.rm=TRUE),
    wds_corp_ins_73_sum        = sum(wds_corp_ins_73        , na.rm=TRUE),
    wds_corp_ins_8_sum         = sum(wds_corp_ins_8         , na.rm=TRUE),
    wds_corp_ins_999_sum       = sum(wds_corp_ins_999       , na.rm=TRUE),
    wds_corp_ins_9_sum         = sum(wds_corp_ins_9         , na.rm=TRUE),
    wds_corp_mdf_10_sum        = sum(wds_corp_mdf_10        , na.rm=TRUE),
    wds_corp_mdf_111_sum       = sum(wds_corp_mdf_111       , na.rm=TRUE),
    wds_corp_mdf_112_sum       = sum(wds_corp_mdf_112       , na.rm=TRUE),
    wds_corp_mdf_113_sum       = sum(wds_corp_mdf_113       , na.rm=TRUE),
    wds_corp_mdf_114_sum       = sum(wds_corp_mdf_114       , na.rm=TRUE),
    wds_corp_mdf_121_sum       = sum(wds_corp_mdf_121       , na.rm=TRUE),
    wds_corp_mdf_122_sum       = sum(wds_corp_mdf_122       , na.rm=TRUE),
    wds_corp_mdf_123_sum       = sum(wds_corp_mdf_123       , na.rm=TRUE),
    wds_corp_mdf_124_sum       = sum(wds_corp_mdf_124       , na.rm=TRUE),
    wds_corp_mdf_125_sum       = sum(wds_corp_mdf_125       , na.rm=TRUE),
    wds_corp_mdf_131_sum       = sum(wds_corp_mdf_131       , na.rm=TRUE),
    wds_corp_mdf_132_sum       = sum(wds_corp_mdf_132       , na.rm=TRUE),
    wds_corp_mdf_133_sum       = sum(wds_corp_mdf_133       , na.rm=TRUE),
    wds_corp_mdf_134_sum       = sum(wds_corp_mdf_134       , na.rm=TRUE),
    wds_corp_mdf_141_sum       = sum(wds_corp_mdf_141       , na.rm=TRUE),
    wds_corp_mdf_142_sum       = sum(wds_corp_mdf_142       , na.rm=TRUE),
    wds_corp_mdf_143_sum       = sum(wds_corp_mdf_143       , na.rm=TRUE),
    wds_corp_mdf_144_sum       = sum(wds_corp_mdf_144       , na.rm=TRUE),
    wds_corp_mdf_145_sum       = sum(wds_corp_mdf_145       , na.rm=TRUE),
    wds_corp_mdf_21_sum        = sum(wds_corp_mdf_21        ,na.rm=TRUE),
    wds_corp_mdf_22_sum        = sum(wds_corp_mdf_22        , na.rm=TRUE),
    wds_corp_mdf_23_sum        = sum(wds_corp_mdf_23        , na.rm=TRUE),
    wds_corp_mdf_241_sum       = sum(wds_corp_mdf_241       , na.rm=TRUE),
    wds_corp_mdf_242_sum       = sum(wds_corp_mdf_242       , na.rm=TRUE),
    wds_corp_mdf_243_sum       = sum(wds_corp_mdf_243       , na.rm=TRUE),
    wds_corp_mdf_244_sum       = sum(wds_corp_mdf_244       , na.rm=TRUE),
    wds_corp_mdf_25_sum        = sum(wds_corp_mdf_25        ,na.rm=TRUE),
    wds_corp_mdf_26_sum        = sum(wds_corp_mdf_26        , na.rm=TRUE),
    wds_corp_mdf_27_sum        = sum(wds_corp_mdf_27        , na.rm=TRUE),
    wds_corp_mdf_28_sum        = sum(wds_corp_mdf_28        , na.rm=TRUE),
    wds_corp_mdf_29_sum        = sum(wds_corp_mdf_29        , na.rm=TRUE),
    wds_corp_mdf_31_sum        = sum(wds_corp_mdf_31        , na.rm=TRUE),
    wds_corp_mdf_32_sum        = sum(wds_corp_mdf_32        , na.rm=TRUE),
    wds_corp_mdf_33_sum        = sum(wds_corp_mdf_33        , na.rm=TRUE),
    wds_corp_mdf_34_sum        = sum(wds_corp_mdf_34        , na.rm=TRUE),
    wds_corp_mdf_411_sum       = sum(wds_corp_mdf_411       , na.rm=TRUE),
    wds_corp_mdf_412_sum       = sum(wds_corp_mdf_412       , na.rm=TRUE),
    wds_corp_mdf_421_sum       = sum(wds_corp_mdf_421       , na.rm=TRUE),
    wds_corp_mdf_422_sum       = sum(wds_corp_mdf_422       , na.rm=TRUE),
    wds_corp_mdf_43_sum        = sum(wds_corp_mdf_43        , na.rm=TRUE),
    wds_corp_mdf_441_sum       = sum(wds_corp_mdf_441       , na.rm=TRUE),
    wds_corp_mdf_442_sum       = sum(wds_corp_mdf_442       , na.rm=TRUE),
    wds_corp_mdf_45_sum        = sum(wds_corp_mdf_45        , na.rm=TRUE),
    wds_corp_mdf_51_sum        = sum(wds_corp_mdf_51        ,na.rm=TRUE),
    wds_corp_mdf_52_sum        = sum(wds_corp_mdf_52        , na.rm=TRUE),
    wds_corp_mdf_53_sum        = sum(wds_corp_mdf_53        ,na.rm=TRUE),
    wds_corp_mdf_54_sum        = sum(wds_corp_mdf_54        ,na.rm=TRUE),
    wds_corp_mdf_55_sum        = sum(wds_corp_mdf_55        , na.rm=TRUE),
    wds_corp_mdf_56_sum        = sum(wds_corp_mdf_56        , na.rm=TRUE),
    wds_corp_mdf_611_sum       = sum(wds_corp_mdf_611       , na.rm=TRUE),
    wds_corp_mdf_612_sum       = sum(wds_corp_mdf_612       , na.rm=TRUE),
    wds_corp_mdf_613_sum       = sum(wds_corp_mdf_613       , na.rm=TRUE),
    wds_corp_mdf_6211_sum      = sum(wds_corp_mdf_6211      , na.rm=TRUE),
    wds_corp_mdf_6212_sum      = sum(wds_corp_mdf_6212      , na.rm=TRUE),
    wds_corp_mdf_6221_sum      = sum(wds_corp_mdf_6221      , na.rm=TRUE),
    wds_corp_mdf_6222_sum      = sum(wds_corp_mdf_6222      , na.rm=TRUE),
    wds_corp_mdf_631_sum       = sum(wds_corp_mdf_631       , na.rm=TRUE),
    wds_corp_mdf_632_sum       = sum(wds_corp_mdf_632       , na.rm=TRUE),
    wds_corp_mdf_633_sum       = sum(wds_corp_mdf_633       , na.rm=TRUE),
    wds_corp_mdf_634_sum       = sum(wds_corp_mdf_634       , na.rm=TRUE),
    wds_corp_mdf_6351_sum      = sum(wds_corp_mdf_6351      , na.rm=TRUE),
    wds_corp_mdf_6352_sum      = sum(wds_corp_mdf_6352      , na.rm=TRUE),
    wds_corp_mdf_636_sum       = sum(wds_corp_mdf_636       , na.rm=TRUE),
    wds_corp_mdf_637_sum       = sum(wds_corp_mdf_637       , na.rm=TRUE),
    wds_corp_mdf_638_sum       = sum(wds_corp_mdf_638       , na.rm=TRUE),
    wds_corp_mdf_639_sum       = sum(wds_corp_mdf_639       , na.rm=TRUE),
    wds_corp_mdf_641_sum       = sum(wds_corp_mdf_641       , na.rm=TRUE),
    wds_corp_mdf_642_sum       = sum(wds_corp_mdf_642       , na.rm=TRUE),
    wds_corp_mdf_643_sum       = sum(wds_corp_mdf_643       , na.rm=TRUE),
    wds_corp_mdf_651_sum       = sum(wds_corp_mdf_651       , na.rm=TRUE),
    wds_corp_mdf_652_sum       = sum(wds_corp_mdf_652       , na.rm=TRUE),
    wds_corp_mdf_653_sum       = sum(wds_corp_mdf_653       , na.rm=TRUE),
    wds_corp_mdf_66_sum        = sum(wds_corp_mdf_66        , na.rm=TRUE),
    wds_corp_mdf_67_sum        = sum(wds_corp_mdf_67        , na.rm=TRUE),
    wds_corp_mdf_68_sum        = sum(wds_corp_mdf_68        , na.rm=TRUE),
    wds_corp_mdf_71_sum        = sum(wds_corp_mdf_71        , na.rm=TRUE),
    wds_corp_mdf_72_sum        = sum(wds_corp_mdf_72        , na.rm=TRUE),
    wds_corp_mdf_73_sum        = sum(wds_corp_mdf_73        , na.rm=TRUE),
    wds_corp_mdf_8_sum         = sum(wds_corp_mdf_8         ,na.rm=TRUE),
    wds_corp_mdf_999_sum       = sum(wds_corp_mdf_999       , na.rm=TRUE),
    wds_corp_mdf_9_sum         = sum(wds_corp_mdf_9         , na.rm=TRUE),
    
    lns_corp_del_10_sum     = sum(lns_corp_del_10        , na.rm=TRUE),
    lns_corp_del_111_sum    = sum(lns_corp_del_111       , na.rm=TRUE),
    lns_corp_del_112_sum    = sum(lns_corp_del_112       , na.rm=TRUE),
    lns_corp_del_113_sum    = sum(lns_corp_del_113       , na.rm=TRUE),
    lns_corp_del_114_sum    = sum(lns_corp_del_114       , na.rm=TRUE),
    lns_corp_del_121_sum    = sum(lns_corp_del_121       , na.rm=TRUE),
    lns_corp_del_122_sum    = sum(lns_corp_del_122       , na.rm=TRUE),
    lns_corp_del_123_sum    = sum(lns_corp_del_123       , na.rm=TRUE),
    lns_corp_del_124_sum    = sum(lns_corp_del_124       , na.rm=TRUE),
    lns_corp_del_125_sum    = sum(lns_corp_del_125       , na.rm=TRUE),
    lns_corp_del_131_sum    = sum(lns_corp_del_131       , na.rm=TRUE),
    lns_corp_del_132_sum    = sum(lns_corp_del_132       , na.rm=TRUE),
    lns_corp_del_133_sum    = sum(lns_corp_del_133       , na.rm=TRUE),
    lns_corp_del_134_sum    = sum(lns_corp_del_134       , na.rm=TRUE),
    lns_corp_del_141_sum    = sum(lns_corp_del_141       , na.rm=TRUE),
    lns_corp_del_142_sum    = sum(lns_corp_del_142       , na.rm=TRUE),
    lns_corp_del_143_sum    = sum(lns_corp_del_143       , na.rm=TRUE),
    lns_corp_del_144_sum    = sum(lns_corp_del_144       , na.rm=TRUE),
    lns_corp_del_145_sum    = sum(lns_corp_del_145       , na.rm=TRUE),
    lns_corp_del_21_sum     = sum(lns_corp_del_21        , na.rm=TRUE),
    lns_corp_del_22_sum     = sum(lns_corp_del_22        , na.rm=TRUE),
    lns_corp_del_23_sum     = sum(lns_corp_del_23        , na.rm=TRUE),
    lns_corp_del_241_sum    = sum(lns_corp_del_241       , na.rm=TRUE),
    lns_corp_del_242_sum    = sum(lns_corp_del_242       , na.rm=TRUE),
    lns_corp_del_243_sum    = sum(lns_corp_del_243       , na.rm=TRUE),
    lns_corp_del_244_sum    = sum(lns_corp_del_244       , na.rm=TRUE),
    lns_corp_del_25_sum     = sum(lns_corp_del_25        , na.rm=TRUE),
    lns_corp_del_26_sum     = sum(lns_corp_del_26        , na.rm=TRUE),
    lns_corp_del_27_sum     = sum(lns_corp_del_27        , na.rm=TRUE),
    lns_corp_del_28_sum     = sum(lns_corp_del_28        , na.rm=TRUE),
    lns_corp_del_29_sum     = sum(lns_corp_del_29        , na.rm=TRUE),
    lns_corp_del_31_sum     = sum(lns_corp_del_31        , na.rm=TRUE),
    lns_corp_del_32_sum     = sum(lns_corp_del_32        , na.rm=TRUE),
    lns_corp_del_33_sum     = sum(lns_corp_del_33        , na.rm=TRUE),
    lns_corp_del_34_sum     = sum(lns_corp_del_34        , na.rm=TRUE),
    lns_corp_del_411_sum    = sum(lns_corp_del_411       , na.rm=TRUE),
    lns_corp_del_412_sum    = sum(lns_corp_del_412       , na.rm=TRUE),
    lns_corp_del_421_sum    = sum(lns_corp_del_421       , na.rm=TRUE),
    lns_corp_del_422_sum    = sum(lns_corp_del_422       , na.rm=TRUE),
    lns_corp_del_43_sum     = sum(lns_corp_del_43        , na.rm=TRUE),
    lns_corp_del_441_sum    = sum(lns_corp_del_441       , na.rm=TRUE),
    lns_corp_del_442_sum    = sum(lns_corp_del_442       , na.rm=TRUE),
    lns_corp_del_45_sum     = sum(lns_corp_del_45        , na.rm=TRUE),
    lns_corp_del_51_sum     = sum(lns_corp_del_51        , na.rm=TRUE),
    lns_corp_del_52_sum     = sum(lns_corp_del_52        , na.rm=TRUE),
    lns_corp_del_53_sum     = sum(lns_corp_del_53        , na.rm=TRUE),
    lns_corp_del_54_sum     = sum(lns_corp_del_54        , na.rm=TRUE),
    lns_corp_del_55_sum     = sum(lns_corp_del_55        , na.rm=TRUE),
    lns_corp_del_56_sum     = sum(lns_corp_del_56        , na.rm=TRUE),
    lns_corp_del_611_sum    = sum(lns_corp_del_611       , na.rm=TRUE),
    lns_corp_del_612_sum    = sum(lns_corp_del_612       , na.rm=TRUE),
    lns_corp_del_613_sum    = sum(lns_corp_del_613       , na.rm=TRUE),
    lns_corp_del_6211_sum   = sum(lns_corp_del_6211      , na.rm=TRUE),
    lns_corp_del_6212_sum   = sum(lns_corp_del_6212      , na.rm=TRUE),
    lns_corp_del_6221_sum   = sum(lns_corp_del_6221      , na.rm=TRUE),
    lns_corp_del_6222_sum   = sum(lns_corp_del_6222      , na.rm=TRUE),
    lns_corp_del_631_sum    = sum(lns_corp_del_631       , na.rm=TRUE),
    lns_corp_del_632_sum    = sum(lns_corp_del_632       , na.rm=TRUE),
    lns_corp_del_633_sum    = sum(lns_corp_del_633       , na.rm=TRUE),
    lns_corp_del_634_sum    = sum(lns_corp_del_634       , na.rm=TRUE),
    lns_corp_del_6351_sum   = sum(lns_corp_del_6351      , na.rm=TRUE),
    lns_corp_del_6352_sum   = sum(lns_corp_del_6352      , na.rm=TRUE),
    lns_corp_del_636_sum    = sum(lns_corp_del_636       , na.rm=TRUE),
    lns_corp_del_637_sum    = sum(lns_corp_del_637       , na.rm=TRUE),
    lns_corp_del_638_sum    = sum(lns_corp_del_638       , na.rm=TRUE),
    lns_corp_del_639_sum    = sum(lns_corp_del_639       , na.rm=TRUE),
    lns_corp_del_641_sum    = sum(lns_corp_del_641       , na.rm=TRUE),
    lns_corp_del_642_sum    = sum(lns_corp_del_642       , na.rm=TRUE),
    lns_corp_del_643_sum    = sum(lns_corp_del_643       , na.rm=TRUE),
    lns_corp_del_651_sum    = sum(lns_corp_del_651       , na.rm=TRUE),
    lns_corp_del_652_sum    = sum(lns_corp_del_652       , na.rm=TRUE),
    lns_corp_del_653_sum    = sum(lns_corp_del_653       , na.rm=TRUE),
    lns_corp_del_66_sum     = sum(lns_corp_del_66        , na.rm=TRUE),
    lns_corp_del_67_sum     = sum(lns_corp_del_67        , na.rm=TRUE),
    lns_corp_del_68_sum     = sum(lns_corp_del_68        , na.rm=TRUE),
    lns_corp_del_71_sum     = sum(lns_corp_del_71        , na.rm=TRUE),
    lns_corp_del_72_sum     = sum(lns_corp_del_72        , na.rm=TRUE),
    lns_corp_del_73_sum     = sum(lns_corp_del_73        , na.rm=TRUE),
    lns_corp_del_8_sum      = sum(lns_corp_del_8         , na.rm=TRUE),
    lns_corp_del_999_sum    = sum(lns_corp_del_999       , na.rm=TRUE),
    lns_corp_del_9_sum      = sum(lns_corp_del_9         , na.rm=TRUE),
    lns_corp_ins_10_sum     = sum(lns_corp_ins_10        , na.rm=TRUE),
    lns_corp_ins_111_sum    = sum(lns_corp_ins_111       , na.rm=TRUE),
    lns_corp_ins_112_sum    = sum(lns_corp_ins_112       , na.rm=TRUE),
    lns_corp_ins_113_sum    = sum(lns_corp_ins_113       , na.rm=TRUE),
    lns_corp_ins_114_sum    = sum(lns_corp_ins_114       , na.rm=TRUE),
    lns_corp_ins_121_sum    = sum(lns_corp_ins_121       , na.rm=TRUE),
    lns_corp_ins_122_sum    = sum(lns_corp_ins_122       , na.rm=TRUE),
    lns_corp_ins_123_sum    = sum(lns_corp_ins_123       , na.rm=TRUE),
    lns_corp_ins_124_sum    = sum(lns_corp_ins_124       , na.rm=TRUE),
    lns_corp_ins_125_sum    = sum(lns_corp_ins_125       , na.rm=TRUE),
    lns_corp_ins_131_sum    = sum(lns_corp_ins_131       , na.rm=TRUE),
    lns_corp_ins_132_sum    = sum(lns_corp_ins_132       , na.rm=TRUE),
    lns_corp_ins_133_sum    = sum(lns_corp_ins_133       , na.rm=TRUE),
    lns_corp_ins_134_sum    = sum(lns_corp_ins_134       , na.rm=TRUE),
    lns_corp_ins_141_sum    = sum(lns_corp_ins_141       , na.rm=TRUE),
    lns_corp_ins_142_sum    = sum(lns_corp_ins_142       , na.rm=TRUE),
    lns_corp_ins_143_sum    = sum(lns_corp_ins_143       , na.rm=TRUE),
    lns_corp_ins_144_sum    = sum(lns_corp_ins_144       , na.rm=TRUE),
    lns_corp_ins_145_sum    = sum(lns_corp_ins_145       , na.rm=TRUE),
    lns_corp_ins_21_sum     = sum(lns_corp_ins_21        , na.rm=TRUE),
    lns_corp_ins_22_sum     = sum(lns_corp_ins_22        , na.rm=TRUE),
    lns_corp_ins_23_sum     = sum(lns_corp_ins_23        , na.rm=TRUE),
    lns_corp_ins_241_sum    = sum(lns_corp_ins_241       , na.rm=TRUE),
    lns_corp_ins_242_sum    = sum(lns_corp_ins_242       , na.rm=TRUE),
    lns_corp_ins_243_sum    = sum(lns_corp_ins_243       , na.rm=TRUE),
    lns_corp_ins_244_sum    = sum(lns_corp_ins_244       , na.rm=TRUE),
    lns_corp_ins_25_sum     = sum(lns_corp_ins_25        , na.rm=TRUE),
    lns_corp_ins_26_sum     = sum(lns_corp_ins_26        , na.rm=TRUE),
    lns_corp_ins_27_sum     = sum(lns_corp_ins_27        , na.rm=TRUE),
    lns_corp_ins_28_sum     = sum(lns_corp_ins_28        , na.rm=TRUE),
    lns_corp_ins_29_sum     = sum(lns_corp_ins_29        , na.rm=TRUE),
    lns_corp_ins_31_sum     = sum(lns_corp_ins_31        , na.rm=TRUE),
    lns_corp_ins_32_sum     = sum(lns_corp_ins_32        , na.rm=TRUE),
    lns_corp_ins_33_sum     = sum(lns_corp_ins_33        , na.rm=TRUE),
    lns_corp_ins_34_sum     = sum(lns_corp_ins_34        , na.rm=TRUE),
    lns_corp_ins_411_sum    = sum(lns_corp_ins_411       , na.rm=TRUE),
    lns_corp_ins_412_sum    = sum(lns_corp_ins_412       , na.rm=TRUE),
    lns_corp_ins_421_sum    = sum(lns_corp_ins_421       , na.rm=TRUE),
    lns_corp_ins_422_sum    = sum(lns_corp_ins_422       , na.rm=TRUE),
    lns_corp_ins_43_sum     = sum(lns_corp_ins_43        , na.rm=TRUE),
    lns_corp_ins_441_sum    = sum(lns_corp_ins_441       , na.rm=TRUE),
    lns_corp_ins_442_sum    = sum(lns_corp_ins_442       , na.rm=TRUE),
    lns_corp_ins_45_sum     = sum(lns_corp_ins_45        , na.rm=TRUE),
    lns_corp_ins_51_sum     = sum(lns_corp_ins_51        , na.rm=TRUE),
    lns_corp_ins_52_sum     = sum(lns_corp_ins_52        , na.rm=TRUE),
    lns_corp_ins_53_sum     = sum(lns_corp_ins_53        , na.rm=TRUE),
    lns_corp_ins_54_sum     = sum(lns_corp_ins_54        , na.rm=TRUE),
    lns_corp_ins_55_sum     = sum(lns_corp_ins_55        , na.rm=TRUE),
    lns_corp_ins_56_sum     = sum(lns_corp_ins_56        , na.rm=TRUE),
    lns_corp_ins_611_sum    = sum(lns_corp_ins_611       , na.rm=TRUE),
    lns_corp_ins_612_sum    = sum(lns_corp_ins_612       , na.rm=TRUE),
    lns_corp_ins_613_sum    = sum(lns_corp_ins_613       , na.rm=TRUE),
    lns_corp_ins_6211_sum   = sum(lns_corp_ins_6211      , na.rm=TRUE),
    lns_corp_ins_6212_sum   = sum(lns_corp_ins_6212      , na.rm=TRUE),
    lns_corp_ins_6221_sum   = sum(lns_corp_ins_6221      , na.rm=TRUE),
    lns_corp_ins_6222_sum   = sum(lns_corp_ins_6222      , na.rm=TRUE),
    lns_corp_ins_631_sum    = sum(lns_corp_ins_631       , na.rm=TRUE),
    lns_corp_ins_632_sum    = sum(lns_corp_ins_632       , na.rm=TRUE),
    lns_corp_ins_633_sum    = sum(lns_corp_ins_633       , na.rm=TRUE),
    lns_corp_ins_634_sum    = sum(lns_corp_ins_634       , na.rm=TRUE),
    lns_corp_ins_6351_sum   = sum(lns_corp_ins_6351      , na.rm=TRUE),
    lns_corp_ins_6352_sum   = sum(lns_corp_ins_6352      , na.rm=TRUE),
    lns_corp_ins_636_sum    = sum(lns_corp_ins_636       , na.rm=TRUE),
    lns_corp_ins_637_sum    = sum(lns_corp_ins_637       , na.rm=TRUE),
    lns_corp_ins_638_sum    = sum(lns_corp_ins_638       , na.rm=TRUE),
    lns_corp_ins_639_sum    = sum(lns_corp_ins_639       , na.rm=TRUE),
    lns_corp_ins_641_sum    = sum(lns_corp_ins_641       , na.rm=TRUE),
    lns_corp_ins_642_sum    = sum(lns_corp_ins_642       , na.rm=TRUE),
    lns_corp_ins_643_sum    = sum(lns_corp_ins_643       , na.rm=TRUE),
    lns_corp_ins_651_sum    = sum(lns_corp_ins_651       , na.rm=TRUE),
    lns_corp_ins_652_sum    = sum(lns_corp_ins_652       , na.rm=TRUE),
    lns_corp_ins_653_sum    = sum(lns_corp_ins_653       , na.rm=TRUE),
    lns_corp_ins_66_sum     = sum(lns_corp_ins_66        , na.rm=TRUE),
    lns_corp_ins_67_sum     = sum(lns_corp_ins_67        , na.rm=TRUE),
    lns_corp_ins_68_sum     = sum(lns_corp_ins_68        , na.rm=TRUE),
    lns_corp_ins_71_sum     = sum(lns_corp_ins_71        , na.rm=TRUE),
    lns_corp_ins_72_sum     = sum(lns_corp_ins_72        , na.rm=TRUE),
    lns_corp_ins_73_sum     = sum(lns_corp_ins_73        , na.rm=TRUE),
    lns_corp_ins_8_sum      = sum(lns_corp_ins_8         , na.rm=TRUE),
    lns_corp_ins_999_sum    = sum(lns_corp_ins_999       , na.rm=TRUE),
    lns_corp_ins_9_sum      = sum(lns_corp_ins_9         , na.rm=TRUE),
    lns_corp_mdf_10_sum     = sum(lns_corp_mdf_10        , na.rm=TRUE),
    lns_corp_mdf_111_sum    = sum(lns_corp_mdf_111       , na.rm=TRUE),
    lns_corp_mdf_112_sum    = sum(lns_corp_mdf_112       , na.rm=TRUE),
    lns_corp_mdf_113_sum    = sum(lns_corp_mdf_113       , na.rm=TRUE),
    lns_corp_mdf_114_sum    = sum(lns_corp_mdf_114       , na.rm=TRUE),
    lns_corp_mdf_121_sum    = sum(lns_corp_mdf_121       , na.rm=TRUE),
    lns_corp_mdf_122_sum    = sum(lns_corp_mdf_122       , na.rm=TRUE),
    lns_corp_mdf_123_sum    = sum(lns_corp_mdf_123       , na.rm=TRUE),
    lns_corp_mdf_124_sum    = sum(lns_corp_mdf_124       , na.rm=TRUE),
    lns_corp_mdf_125_sum    = sum(lns_corp_mdf_125       , na.rm=TRUE),
    lns_corp_mdf_131_sum    = sum(lns_corp_mdf_131       , na.rm=TRUE),
    lns_corp_mdf_132_sum    = sum(lns_corp_mdf_132       , na.rm=TRUE),
    lns_corp_mdf_133_sum    = sum(lns_corp_mdf_133       , na.rm=TRUE),
    lns_corp_mdf_134_sum    = sum(lns_corp_mdf_134       , na.rm=TRUE),
    lns_corp_mdf_141_sum    = sum(lns_corp_mdf_141       , na.rm=TRUE),
    lns_corp_mdf_142_sum    = sum(lns_corp_mdf_142       , na.rm=TRUE),
    lns_corp_mdf_143_sum    = sum(lns_corp_mdf_143       , na.rm=TRUE),
    lns_corp_mdf_144_sum    = sum(lns_corp_mdf_144       , na.rm=TRUE),
    lns_corp_mdf_145_sum    = sum(lns_corp_mdf_145       , na.rm=TRUE),
    lns_corp_mdf_21_sum     = sum(lns_corp_mdf_21        , na.rm=TRUE),
    lns_corp_mdf_22_sum     = sum(lns_corp_mdf_22        , na.rm=TRUE),
    lns_corp_mdf_23_sum     = sum(lns_corp_mdf_23        , na.rm=TRUE),
    lns_corp_mdf_241_sum    = sum(lns_corp_mdf_241       , na.rm=TRUE),
    lns_corp_mdf_242_sum    = sum(lns_corp_mdf_242       , na.rm=TRUE),
    lns_corp_mdf_243_sum    = sum(lns_corp_mdf_243       , na.rm=TRUE),
    lns_corp_mdf_244_sum    = sum(lns_corp_mdf_244       , na.rm=TRUE),
    lns_corp_mdf_25_sum     = sum(lns_corp_mdf_25        , na.rm=TRUE),
    lns_corp_mdf_26_sum     = sum(lns_corp_mdf_26        , na.rm=TRUE),
    lns_corp_mdf_27_sum     = sum(lns_corp_mdf_27        , na.rm=TRUE),
    lns_corp_mdf_28_sum     = sum(lns_corp_mdf_28        , na.rm=TRUE),
    lns_corp_mdf_29_sum     = sum(lns_corp_mdf_29        , na.rm=TRUE),
    lns_corp_mdf_31_sum     = sum(lns_corp_mdf_31        , na.rm=TRUE),
    lns_corp_mdf_32_sum     = sum(lns_corp_mdf_32        , na.rm=TRUE),
    lns_corp_mdf_33_sum     = sum(lns_corp_mdf_33        , na.rm=TRUE),
    lns_corp_mdf_34_sum     = sum(lns_corp_mdf_34        , na.rm=TRUE),
    lns_corp_mdf_411_sum    = sum(lns_corp_mdf_411       , na.rm=TRUE),
    lns_corp_mdf_412_sum    = sum(lns_corp_mdf_412       , na.rm=TRUE),
    lns_corp_mdf_421_sum    = sum(lns_corp_mdf_421       , na.rm=TRUE),
    lns_corp_mdf_422_sum    = sum(lns_corp_mdf_422       , na.rm=TRUE),
    lns_corp_mdf_43_sum     = sum(lns_corp_mdf_43        , na.rm=TRUE),
    lns_corp_mdf_441_sum    = sum(lns_corp_mdf_441       , na.rm=TRUE),
    lns_corp_mdf_442_sum    = sum(lns_corp_mdf_442       , na.rm=TRUE),
    lns_corp_mdf_45_sum     = sum(lns_corp_mdf_45        , na.rm=TRUE),
    lns_corp_mdf_51_sum     = sum(lns_corp_mdf_51        , na.rm=TRUE),
    lns_corp_mdf_52_sum     = sum(lns_corp_mdf_52        , na.rm=TRUE),
    lns_corp_mdf_53_sum     = sum(lns_corp_mdf_53        , na.rm=TRUE),
    lns_corp_mdf_54_sum     = sum(lns_corp_mdf_54        , na.rm=TRUE),
    lns_corp_mdf_55_sum     = sum(lns_corp_mdf_55        , na.rm=TRUE),
    lns_corp_mdf_56_sum     = sum(lns_corp_mdf_56        , na.rm=TRUE),
    lns_corp_mdf_611_sum    = sum(lns_corp_mdf_611       , na.rm=TRUE),
    lns_corp_mdf_612_sum    = sum(lns_corp_mdf_612       , na.rm=TRUE),
    lns_corp_mdf_613_sum    = sum(lns_corp_mdf_613       , na.rm=TRUE),
    lns_corp_mdf_6211_sum   = sum(lns_corp_mdf_6211      , na.rm=TRUE),
    lns_corp_mdf_6212_sum   = sum(lns_corp_mdf_6212      , na.rm=TRUE),
    lns_corp_mdf_6221_sum   = sum(lns_corp_mdf_6221      , na.rm=TRUE),
    lns_corp_mdf_6222_sum   = sum(lns_corp_mdf_6222      , na.rm=TRUE),
    lns_corp_mdf_631_sum    = sum(lns_corp_mdf_631       , na.rm=TRUE),
    lns_corp_mdf_632_sum    = sum(lns_corp_mdf_632       , na.rm=TRUE),
    lns_corp_mdf_633_sum    = sum(lns_corp_mdf_633       , na.rm=TRUE),
    lns_corp_mdf_634_sum    = sum(lns_corp_mdf_634       , na.rm=TRUE),
    lns_corp_mdf_6351_sum   = sum(lns_corp_mdf_6351      , na.rm=TRUE),
    lns_corp_mdf_6352_sum   = sum(lns_corp_mdf_6352      , na.rm=TRUE),
    lns_corp_mdf_636_sum    = sum(lns_corp_mdf_636       , na.rm=TRUE),
    lns_corp_mdf_637_sum    = sum(lns_corp_mdf_637       , na.rm=TRUE),
    lns_corp_mdf_638_sum    = sum(lns_corp_mdf_638       , na.rm=TRUE),
    lns_corp_mdf_639_sum    = sum(lns_corp_mdf_639       , na.rm=TRUE),
    lns_corp_mdf_641_sum    = sum(lns_corp_mdf_641       , na.rm=TRUE),
    lns_corp_mdf_642_sum    = sum(lns_corp_mdf_642       , na.rm=TRUE),
    lns_corp_mdf_643_sum    = sum(lns_corp_mdf_643       , na.rm=TRUE),
    lns_corp_mdf_651_sum    = sum(lns_corp_mdf_651       , na.rm=TRUE),
    lns_corp_mdf_652_sum    = sum(lns_corp_mdf_652       , na.rm=TRUE),
    lns_corp_mdf_653_sum    = sum(lns_corp_mdf_653       , na.rm=TRUE),
    lns_corp_mdf_66_sum     = sum(lns_corp_mdf_66        , na.rm=TRUE),
    lns_corp_mdf_67_sum     = sum(lns_corp_mdf_67        , na.rm=TRUE),
    lns_corp_mdf_68_sum     = sum(lns_corp_mdf_68        , na.rm=TRUE),
    lns_corp_mdf_71_sum     = sum(lns_corp_mdf_71        , na.rm=TRUE),
    lns_corp_mdf_72_sum     = sum(lns_corp_mdf_72        , na.rm=TRUE),
    lns_corp_mdf_73_sum     = sum(lns_corp_mdf_73        , na.rm=TRUE),
    lns_corp_mdf_8_sum      = sum(lns_corp_mdf_8         , na.rm=TRUE),
    lns_corp_mdf_999_sum    = sum(lns_corp_mdf_999       , na.rm=TRUE),
    lns_corp_mdf_9_sum      = sum(lns_corp_mdf_9         , na.rm=TRUE)
    
  )
isor_chg_agg <- filter(isor_chg_agg, !is.na(ref_id_fst))

# all variables 
dim(isor_chg)
dim(isor_chg_agg)

# join isom with isor_chg_agg
isom <-
  isom  %>% 
  left_join(isor_chg_agg)

# hacve a glance
isom %>% 
  select( 
    cab_id, cab_pm, cab_in, cab_out, 
    ref_n, ref_id_fst, lns_chg_sum, wds_chg_sum
  )

#### merging erd and isor_so ===================================================

# merge / map / match criteria is whether or not there is some kind of overlap
#
# -> 
# 
# cab_in   <= so_start <= cab_out 
# cab_in   <= so_end   <= cab_out 
# so_start <= cab_in   <= so_start
# so_start <= cab_out  <= so_start


merger <- data_frame(cab_id=character(0), so_id=character(0))

for (i in seq_len(dim(isor_so)[1]) ) {
  # cab_in between so_start and so_end
  so_id    <- isor_so$so_t_id[i]
  so_ctr   <- isor_so$ctr[i]
  so_start <- isor_so$so_start[i]
  so_end   <- 
    is.na(isor_so$so_end[i])  %>% 
    ifelse(Sys.Date(), isor_so$so_end[i]) %>% 
    as.Date(origin="1970-01-01")
  
  
  cab_ids <- 
    erd$cab_id[
    so_start <= erd$cab_in & 
      erd$cab_in <= so_end &
      erd$ctr == so_ctr] %>% 
    .[!is.na(.)]

  # cab_in between so_start and so_end
  cab_ids <- 
    cab_ids  %>% 
    c(
      erd$cab_id[
        so_start <= ifelse(is.na(erd$cab_out), Sys.Date(), erd$cab_out) & 
          erd$cab_out <= so_end &
          erd$ctr == so_ctr]
    ) %>% 
    .[!is.na(.)] %>% 
    unique()
  
  if( length(so_id) > 0 & length(cab_ids) > 0 ){
    merger <- rbind(merger, data_frame(cab_id=cab_ids, so_id=so_id))
  }
}

for (i in seq_len(dim(erd)[1]) ) {
  # so_start between cab_in and cab_out
  erd_id    <- erd$cab_id[i]
  erd_ctr   <- erd$ctr[i]
  erd_start <- erd$cab_in[i]
  erd_end    <- 
    is.na(erd$cab_out[i])  %>% 
    ifelse(Sys.Date(), erd$cab_out[i]) %>% 
    as.Date(origin="1970-01-01")
  
  
  so_ids <- 
    isor_so$so_t_id[ 
      erd_start <= isor_so$so_start & 
        isor_so$so_start <= erd_end &
        isor_so$ctr == erd_ctr
    ] %>% 
    .[!is.na(.)]
  
  # so_end between cab_in and cab_out
  so_ids <- 
    so_ids  %>% 
    c(
      isor_so$so_t_id[
        erd_start <= ifelse(is.na(isor_so$so_end), Sys.Date(), isor_so$so_end) & 
          isor_so$so_end <= erd_end &
          isor_so$ctr == erd_ctr]
    ) %>% 
    .[!is.na(.)] %>% 
    unique()
  
  if( length(so_ids) > 0 & length(erd_id) > 0 ){
    merger <- 
      rbind(
        merger, 
        data_frame(cab_id=erd_id, so_id=so_ids)
      )
  }
}

(merger <- unique(merger) %>% arrange(cab_id, so_id))



### merge isor_so to merger

isor_so_joined <- 
  left_join( merger, isor_so, by=c(so_id="so_t_id") )  %>% 
  arrange(cab_id, so_id) %>% 
  group_by(cab_id) %>% 
  select(cab_id, so_id, so_start, so_end, wds_clean_rel, everything(), -t_date_lag)

names(isor_so_joined)



### adding number of so per cabinet

isor_so_joined$so_n <- NA
for(cabid in unique(isor_so_joined$cab_id) ){
  iffer <- isor_so_joined$cab_id == cabid
  isor_so_joined$so_n[iffer] <- 
    sum( !is.na(isor_so_joined$so_start[iffer]) )
}


### isom_so_joined

#isom_so_joined <- 
#  isom  %>% 
#  left_join(isor_so_joined)



### aggregate 

isor_so_agg <- 
  isor_so_joined  %>% 
  arrange(cab_id, so_id) %>% 
  select(
    cab_id, 
    so_start, 
    so_end, 
    so_n, 
    wds_clean_rel, 
    so_daccept, 
    so_dpromul,  
    so_denact, 
    so_id, 
    so_dplus, 
    everything()
  ) %>% 
  group_by(cab_id) %>%  
  summarise(
    so_id_fst             = first(so_id             ),
    so_id_lst             = last( so_id              ),
    so_id_all             = paste(so_id, collapse=", "),
    so_n                  = max(so_n),
    
    so_start_fst             = first(so_start    ),
    so_end_fst             = first(so_end    ),
    so_dplus_fst            = first(so_dplus   ),
    so_daccept_fst          = first(so_daccept ),
    so_dpromul_fst          = first(so_dpromul ),
    so_denact_fst           = first(so_denact  ),
    so_start_lst             = last(so_start    ),
    so_end_lst               = last(so_end    ),
    so_dplus_lst            = last(so_dplus   ),
    so_daccept_lst          = last(so_daccept ),
    so_dpromul_lst          = last(so_dpromul ),
    so_denact_lst           = last(so_denact  ),

    lang                   = first(lang),
    wdns                   = first(wdns),
    wdns_corr              = first(wdns_corr),
    
    wds_clean_rel_wdns_corr_fst = first(wds_clean_rel_wdns_corr),
    wds_clean_rel_wdns_corr_lst = last(wds_clean_rel_wdns_corr),
    wds_clean_rel_wdns_corr_mn  = mean(wds_clean_rel_wdns_corr  , na.rm=TRUE),
    
    tsb_agc                = first(tsb_agc),
    
    ext_tsb_agc1_fst   = first(ext_tsb_agc1),
    ext_tsb_agc2_fst   = first(ext_tsb_agc2),
    ext_tsb_agc4_fst   = first(ext_tsb_agc4),
    
    ext_tsb_agc1_lst   = last(ext_tsb_agc1),
    ext_tsb_agc2_lst   = last(ext_tsb_agc2),
    ext_tsb_agc4_lst   = last(ext_tsb_agc4),
    
    ext_tsb_agc1_mn    = mean(ext_tsb_agc1 , na.rm=TRUE),
    ext_tsb_agc2_mn    = mean(ext_tsb_agc2 , na.rm=TRUE),
    ext_tsb_agc4_mn    = mean(ext_tsb_agc4,  na.rm=TRUE),
    
    lns_all_mn                = mean(lns_all        ,na.rm=TRUE),
    wds_raw_all_mn            = mean(wds_raw_all    ,na.rm=TRUE),
    wds_clean_all_mn          = mean(wds_clean_all  ,na.rm=TRUE),
    lns_rel_mn                = mean(lns_rel        ,na.rm=TRUE),
    wds_raw_rel_mn            = mean(wds_raw_rel    ,na.rm=TRUE),
    wds_clean_rel_mn          = mean(wds_clean_rel  ,na.rm=TRUE),
    
    lns_all_fst                = first(lns_all        ),
    wds_raw_all_fst            = first(wds_raw_all    ),
    wds_clean_all_fst          = first(wds_clean_all  ),
    lns_rel_fst                = first(lns_rel        ),
    wds_raw_rel_fst            = first(wds_raw_rel    ),
    wds_clean_rel_fst          = first(wds_clean_rel  ),
    
    lns_all_lst                = last(lns_all        ),
    wds_raw_all_lst            = last(wds_raw_all    ),
    wds_clean_all_lst          = last(wds_clean_all  ),
    lns_rel_lst                = last(lns_rel        ),
    wds_raw_rel_lst            = last(wds_raw_rel    ),
    wds_clean_rel_lst          = last(wds_clean_rel  ),
    
    lns_corp_8_fst             = first(lns_corp_8            ),
    lns_corp_9_fst             = first(lns_corp_9            ),
    lns_corp_10_fst            = first(lns_corp_10           ),
    lns_corp_21_fst            = first(lns_corp_21           ),
    lns_corp_22_fst            = first(lns_corp_22           ),
    lns_corp_23_fst            = first(lns_corp_23           ),
    lns_corp_25_fst            = first(lns_corp_25           ),
    lns_corp_26_fst            = first(lns_corp_26           ),
    lns_corp_27_fst            = first(lns_corp_27           ),
    lns_corp_28_fst            = first(lns_corp_28           ),
    lns_corp_29_fst            = first(lns_corp_29           ),
    lns_corp_31_fst            = first(lns_corp_31           ),
    lns_corp_32_fst            = first(lns_corp_32           ),
    lns_corp_33_fst            = first(lns_corp_33           ),
    lns_corp_34_fst            = first(lns_corp_34           ),
    lns_corp_43_fst            = first(lns_corp_43           ),
    lns_corp_45_fst            = first(lns_corp_45           ),
    lns_corp_51_fst            = first(lns_corp_51           ),
    lns_corp_52_fst            = first(lns_corp_52           ),
    lns_corp_53_fst            = first(lns_corp_53           ),
    lns_corp_54_fst            = first(lns_corp_54           ),
    lns_corp_55_fst            = first(lns_corp_55           ),
    lns_corp_56_fst            = first(lns_corp_56           ),
    lns_corp_66_fst            = first(lns_corp_66           ),
    lns_corp_67_fst            = first(lns_corp_67           ),
    lns_corp_68_fst            = first(lns_corp_68           ),
    lns_corp_71_fst            = first(lns_corp_71           ),
    lns_corp_72_fst            = first(lns_corp_72           ),
    lns_corp_73_fst            = first(lns_corp_73           ),
    lns_corp_111_fst           = first(lns_corp_111          ),
    lns_corp_112_fst           = first(lns_corp_112          ),
    lns_corp_113_fst           = first(lns_corp_113          ),
    lns_corp_114_fst           = first(lns_corp_114          ),
    lns_corp_121_fst           = first(lns_corp_121          ),
    lns_corp_122_fst           = first(lns_corp_122          ),
    lns_corp_123_fst           = first(lns_corp_123          ),
    lns_corp_124_fst           = first(lns_corp_124          ),
    lns_corp_125_fst           = first(lns_corp_125          ),
    lns_corp_131_fst           = first(lns_corp_131          ),
    lns_corp_132_fst           = first(lns_corp_132          ),
    lns_corp_133_fst           = first(lns_corp_133          ),
    lns_corp_134_fst           = first(lns_corp_134          ),
    lns_corp_141_fst           = first(lns_corp_141          ),
    lns_corp_142_fst           = first(lns_corp_142          ),
    lns_corp_143_fst           = first(lns_corp_143          ),
    lns_corp_144_fst           = first(lns_corp_144          ),
    lns_corp_145_fst           = first(lns_corp_145          ),
    lns_corp_241_fst           = first(lns_corp_241          ),
    lns_corp_242_fst           = first(lns_corp_242          ),
    lns_corp_243_fst           = first(lns_corp_243          ),
    lns_corp_244_fst           = first(lns_corp_244          ),
    lns_corp_411_fst           = first(lns_corp_411          ),
    lns_corp_412_fst           = first(lns_corp_412          ),
    lns_corp_421_fst           = first(lns_corp_421          ),
    lns_corp_422_fst           = first(lns_corp_422          ),
    lns_corp_441_fst           = first(lns_corp_441          ),
    lns_corp_442_fst           = first(lns_corp_442          ),
    lns_corp_611_fst           = first(lns_corp_611          ),
    lns_corp_612_fst           = first(lns_corp_612          ),
    lns_corp_613_fst           = first(lns_corp_613          ),
    lns_corp_631_fst           = first(lns_corp_631          ),
    lns_corp_632_fst           = first(lns_corp_632          ),
    lns_corp_633_fst           = first(lns_corp_633          ),
    lns_corp_634_fst           = first(lns_corp_634          ),
    lns_corp_636_fst           = first(lns_corp_636          ),
    lns_corp_637_fst           = first(lns_corp_637          ),
    lns_corp_638_fst           = first(lns_corp_638          ),
    lns_corp_639_fst           = first(lns_corp_639          ),
    lns_corp_641_fst           = first(lns_corp_641          ),
    lns_corp_642_fst           = first(lns_corp_642          ),
    lns_corp_643_fst           = first(lns_corp_643          ),
    lns_corp_651_fst           = first(lns_corp_651          ),
    lns_corp_652_fst           = first(lns_corp_652          ),
    lns_corp_653_fst           = first(lns_corp_653          ),
    lns_corp_999_fst           = first(lns_corp_999          ),
    lns_corp_6211_fst          = first(lns_corp_6211         ),
    lns_corp_6212_fst          = first(lns_corp_6212         ),
    lns_corp_6221_fst          = first(lns_corp_6221         ),
    lns_corp_6222_fst          = first(lns_corp_6222         ),
    lns_corp_6351_fst          = first(lns_corp_6351         ),
    lns_corp_6352_fst          = first(lns_corp_6352         ),
    wds_corp_8_fst             = first(wds_corp_8            ),
    wds_corp_9_fst             = first(wds_corp_9            ),
    wds_corp_10_fst            = first(wds_corp_10           ),
    wds_corp_21_fst            = first(wds_corp_21           ),
    wds_corp_22_fst            = first(wds_corp_22           ),
    wds_corp_23_fst            = first(wds_corp_23           ),
    wds_corp_25_fst            = first(wds_corp_25           ),
    wds_corp_26_fst            = first(wds_corp_26           ),
    wds_corp_27_fst            = first(wds_corp_27           ),
    wds_corp_28_fst            = first(wds_corp_28           ),
    wds_corp_29_fst            = first(wds_corp_29           ),
    wds_corp_31_fst            = first(wds_corp_31           ),
    wds_corp_32_fst            = first(wds_corp_32           ),
    wds_corp_33_fst            = first(wds_corp_33           ),
    wds_corp_34_fst            = first(wds_corp_34           ),
    wds_corp_43_fst            = first(wds_corp_43           ),
    wds_corp_45_fst            = first(wds_corp_45           ),
    wds_corp_51_fst            = first(wds_corp_51           ),
    wds_corp_52_fst            = first(wds_corp_52           ),
    wds_corp_53_fst            = first(wds_corp_53           ),
    wds_corp_54_fst            = first(wds_corp_54           ),
    wds_corp_55_fst            = first(wds_corp_55           ),
    wds_corp_56_fst            = first(wds_corp_56           ),
    wds_corp_66_fst            = first(wds_corp_66           ),
    wds_corp_67_fst            = first(wds_corp_67           ),
    wds_corp_68_fst            = first(wds_corp_68           ),
    wds_corp_71_fst            = first(wds_corp_71           ),
    wds_corp_72_fst            = first(wds_corp_72           ),
    wds_corp_73_fst            = first(wds_corp_73           ),
    wds_corp_111_fst           = first(wds_corp_111          ),
    wds_corp_112_fst           = first(wds_corp_112          ),
    wds_corp_113_fst           = first(wds_corp_113          ),
    wds_corp_114_fst           = first(wds_corp_114          ),
    wds_corp_121_fst           = first(wds_corp_121          ),
    wds_corp_122_fst           = first(wds_corp_122          ),
    wds_corp_123_fst           = first(wds_corp_123          ),
    wds_corp_124_fst           = first(wds_corp_124          ),
    wds_corp_125_fst           = first(wds_corp_125          ),
    wds_corp_131_fst           = first(wds_corp_131          ),
    wds_corp_132_fst           = first(wds_corp_132          ),
    wds_corp_133_fst           = first(wds_corp_133          ),
    wds_corp_134_fst           = first(wds_corp_134          ),
    wds_corp_141_fst           = first(wds_corp_141          ),
    wds_corp_142_fst           = first(wds_corp_142          ),
    wds_corp_143_fst           = first(wds_corp_143          ),
    wds_corp_144_fst           = first(wds_corp_144          ),
    wds_corp_145_fst           = first(wds_corp_145          ),
    wds_corp_241_fst           = first(wds_corp_241          ),
    wds_corp_242_fst           = first(wds_corp_242          ),
    wds_corp_243_fst           = first(wds_corp_243          ),
    wds_corp_244_fst           = first(wds_corp_244          ),
    wds_corp_411_fst           = first(wds_corp_411          ),
    wds_corp_412_fst           = first(wds_corp_412          ),
    wds_corp_421_fst           = first(wds_corp_421          ),
    wds_corp_422_fst           = first(wds_corp_422          ),
    wds_corp_441_fst           = first(wds_corp_441          ),
    wds_corp_442_fst           = first(wds_corp_442          ),
    wds_corp_611_fst           = first(wds_corp_611          ),
    wds_corp_612_fst           = first(wds_corp_612          ),
    wds_corp_613_fst           = first(wds_corp_613          ),
    wds_corp_631_fst           = first(wds_corp_631          ),
    wds_corp_632_fst           = first(wds_corp_632          ),
    wds_corp_633_fst           = first(wds_corp_633          ),
    wds_corp_634_fst           = first(wds_corp_634          ),
    wds_corp_636_fst           = first(wds_corp_636          ),
    wds_corp_637_fst           = first(wds_corp_637          ),
    wds_corp_638_fst           = first(wds_corp_638          ),
    wds_corp_639_fst           = first(wds_corp_639          ),
    wds_corp_641_fst           = first(wds_corp_641          ),
    wds_corp_642_fst           = first(wds_corp_642          ),
    wds_corp_643_fst           = first(wds_corp_643          ),
    wds_corp_651_fst           = first(wds_corp_651          ),
    wds_corp_652_fst           = first(wds_corp_652          ),
    wds_corp_653_fst           = first(wds_corp_653          ),
    wds_corp_999_fst           = first(wds_corp_999          ),
    wds_corp_6211_fst          = first(wds_corp_6211         ),
    wds_corp_6212_fst          = first(wds_corp_6212         ),
    wds_corp_6221_fst          = first(wds_corp_6221         ),
    wds_corp_6222_fst          = first(wds_corp_6222         ),
    wds_corp_6351_fst          = first(wds_corp_6351         ),
    wds_corp_6352_fst          = first(wds_corp_6352         ),
    lns_corp_top_1_fst         = first(lns_corp_top_1        ),
    lns_corp_top_2_fst         = first(lns_corp_top_2        ),
    lns_corp_top_3_fst         = first(lns_corp_top_3        ),
    lns_corp_top_4_fst         = first(lns_corp_top_4        ),
    lns_corp_top_5_fst         = first(lns_corp_top_5        ),
    lns_corp_top_66_fst        = first(lns_corp_top_66       ),
    lns_corp_top_77_fst        = first(lns_corp_top_77       ),
    wds_corp_top_1_fst         = first(wds_corp_top_1        ),
    wds_corp_top_2_fst         = first(wds_corp_top_2        ),
    wds_corp_top_3_fst         = first(wds_corp_top_3        ),
    wds_corp_top_4_fst         = first(wds_corp_top_4        ),
    wds_corp_top_5_fst         = first(wds_corp_top_5        ),
    wds_corp_top_66_fst        = first(wds_corp_top_66       ),
    wds_corp_top_77_fst        = first(wds_corp_top_77       ),
    lns_corp_act_1_fst         = first(lns_corp_act_1        ),
    lns_corp_act_2_fst         = first(lns_corp_act_2        ),
    lns_corp_act_3_fst         = first(lns_corp_act_3        ),
    lns_corp_act_4_fst         = first(lns_corp_act_4        ),
    lns_corp_act_66_fst        = first(lns_corp_act_66       ),
    lns_corp_act_77_fst        = first(lns_corp_act_77       ),
    wds_corp_act_1_fst         = first(wds_corp_act_1        ),
    wds_corp_act_2_fst         = first(wds_corp_act_2        ),
    wds_corp_act_3_fst         = first(wds_corp_act_3        ),
    wds_corp_act_4_fst         = first(wds_corp_act_4        ),
    wds_corp_act_66_fst        = first(wds_corp_act_66       ),
    wds_corp_act_77_fst        = first(wds_corp_act_77       ),
    
    lns_corp_8_lst             = last(lns_corp_8            ),
    lns_corp_9_lst             = last(lns_corp_9            ),
    lns_corp_10_lst            = last(lns_corp_10           ),
    lns_corp_21_lst            = last(lns_corp_21           ),
    lns_corp_22_lst            = last(lns_corp_22           ),
    lns_corp_23_lst            = last(lns_corp_23           ),
    lns_corp_25_lst            = last(lns_corp_25           ),
    lns_corp_26_lst            = last(lns_corp_26           ),
    lns_corp_27_lst            = last(lns_corp_27           ),
    lns_corp_28_lst            = last(lns_corp_28           ),
    lns_corp_29_lst            = last(lns_corp_29           ),
    lns_corp_31_lst            = last(lns_corp_31           ),
    lns_corp_32_lst            = last(lns_corp_32           ),
    lns_corp_33_lst            = last(lns_corp_33           ),
    lns_corp_34_lst            = last(lns_corp_34           ),
    lns_corp_43_lst            = last(lns_corp_43           ),
    lns_corp_45_lst            = last(lns_corp_45           ),
    lns_corp_51_lst            = last(lns_corp_51           ),
    lns_corp_52_lst            = last(lns_corp_52           ),
    lns_corp_53_lst            = last(lns_corp_53           ),
    lns_corp_54_lst            = last(lns_corp_54           ),
    lns_corp_55_lst            = last(lns_corp_55           ),
    lns_corp_56_lst            = last(lns_corp_56           ),
    lns_corp_66_lst            = last(lns_corp_66           ),
    lns_corp_67_lst            = last(lns_corp_67           ),
    lns_corp_68_lst            = last(lns_corp_68           ),
    lns_corp_71_lst            = last(lns_corp_71           ),
    lns_corp_72_lst            = last(lns_corp_72           ),
    lns_corp_73_lst            = last(lns_corp_73           ),
    lns_corp_111_lst           = last(lns_corp_111          ),
    lns_corp_112_lst           = last(lns_corp_112          ),
    lns_corp_113_lst           = last(lns_corp_113          ),
    lns_corp_114_lst           = last(lns_corp_114          ),
    lns_corp_121_lst           = last(lns_corp_121          ),
    lns_corp_122_lst           = last(lns_corp_122          ),
    lns_corp_123_lst           = last(lns_corp_123          ),
    lns_corp_124_lst           = last(lns_corp_124          ),
    lns_corp_125_lst           = last(lns_corp_125          ),
    lns_corp_131_lst           = last(lns_corp_131          ),
    lns_corp_132_lst           = last(lns_corp_132          ),
    lns_corp_133_lst           = last(lns_corp_133          ),
    lns_corp_134_lst           = last(lns_corp_134          ),
    lns_corp_141_lst           = last(lns_corp_141          ),
    lns_corp_142_lst           = last(lns_corp_142          ),
    lns_corp_143_lst           = last(lns_corp_143          ),
    lns_corp_144_lst           = last(lns_corp_144          ),
    lns_corp_145_lst           = last(lns_corp_145          ),
    lns_corp_241_lst           = last(lns_corp_241          ),
    lns_corp_242_lst           = last(lns_corp_242          ),
    lns_corp_243_lst           = last(lns_corp_243          ),
    lns_corp_244_lst           = last(lns_corp_244          ),
    lns_corp_411_lst           = last(lns_corp_411          ),
    lns_corp_412_lst           = last(lns_corp_412          ),
    lns_corp_421_lst           = last(lns_corp_421          ),
    lns_corp_422_lst           = last(lns_corp_422          ),
    lns_corp_441_lst           = last(lns_corp_441          ),
    lns_corp_442_lst           = last(lns_corp_442          ),
    lns_corp_611_lst           = last(lns_corp_611          ),
    lns_corp_612_lst           = last(lns_corp_612          ),
    lns_corp_613_lst           = last(lns_corp_613          ),
    lns_corp_631_lst           = last(lns_corp_631          ),
    lns_corp_632_lst           = last(lns_corp_632          ),
    lns_corp_633_lst           = last(lns_corp_633          ),
    lns_corp_634_lst           = last(lns_corp_634          ),
    lns_corp_636_lst           = last(lns_corp_636          ),
    lns_corp_637_lst           = last(lns_corp_637          ),
    lns_corp_638_lst           = last(lns_corp_638          ),
    lns_corp_639_lst           = last(lns_corp_639          ),
    lns_corp_641_lst           = last(lns_corp_641          ),
    lns_corp_642_lst           = last(lns_corp_642          ),
    lns_corp_643_lst           = last(lns_corp_643          ),
    lns_corp_651_lst           = last(lns_corp_651          ),
    lns_corp_652_lst           = last(lns_corp_652          ),
    lns_corp_653_lst           = last(lns_corp_653          ),
    lns_corp_999_lst           = last(lns_corp_999          ),
    lns_corp_6211_lst          = last(lns_corp_6211         ),
    lns_corp_6212_lst          = last(lns_corp_6212         ),
    lns_corp_6221_lst          = last(lns_corp_6221         ),
    lns_corp_6222_lst          = last(lns_corp_6222         ),
    lns_corp_6351_lst          = last(lns_corp_6351         ),
    lns_corp_6352_lst          = last(lns_corp_6352         ),
    wds_corp_8_lst             = last(wds_corp_8            ),
    wds_corp_9_lst             = last(wds_corp_9            ),
    wds_corp_10_lst            = last(wds_corp_10           ),
    wds_corp_21_lst            = last(wds_corp_21           ),
    wds_corp_22_lst            = last(wds_corp_22           ),
    wds_corp_23_lst            = last(wds_corp_23           ),
    wds_corp_25_lst            = last(wds_corp_25           ),
    wds_corp_26_lst            = last(wds_corp_26           ),
    wds_corp_27_lst            = last(wds_corp_27           ),
    wds_corp_28_lst            = last(wds_corp_28           ),
    wds_corp_29_lst            = last(wds_corp_29           ),
    wds_corp_31_lst            = last(wds_corp_31           ),
    wds_corp_32_lst            = last(wds_corp_32           ),
    wds_corp_33_lst            = last(wds_corp_33           ),
    wds_corp_34_lst            = last(wds_corp_34           ),
    wds_corp_43_lst            = last(wds_corp_43           ),
    wds_corp_45_lst            = last(wds_corp_45           ),
    wds_corp_51_lst            = last(wds_corp_51           ),
    wds_corp_52_lst            = last(wds_corp_52           ),
    wds_corp_53_lst            = last(wds_corp_53           ),
    wds_corp_54_lst            = last(wds_corp_54           ),
    wds_corp_55_lst            = last(wds_corp_55           ),
    wds_corp_56_lst            = last(wds_corp_56           ),
    wds_corp_66_lst            = last(wds_corp_66           ),
    wds_corp_67_lst            = last(wds_corp_67           ),
    wds_corp_68_lst            = last(wds_corp_68           ),
    wds_corp_71_lst            = last(wds_corp_71           ),
    wds_corp_72_lst            = last(wds_corp_72           ),
    wds_corp_73_lst            = last(wds_corp_73           ),
    wds_corp_111_lst           = last(wds_corp_111          ),
    wds_corp_112_lst           = last(wds_corp_112          ),
    wds_corp_113_lst           = last(wds_corp_113          ),
    wds_corp_114_lst           = last(wds_corp_114          ),
    wds_corp_121_lst           = last(wds_corp_121          ),
    wds_corp_122_lst           = last(wds_corp_122          ),
    wds_corp_123_lst           = last(wds_corp_123          ),
    wds_corp_124_lst           = last(wds_corp_124          ),
    wds_corp_125_lst           = last(wds_corp_125          ),
    wds_corp_131_lst           = last(wds_corp_131          ),
    wds_corp_132_lst           = last(wds_corp_132          ),
    wds_corp_133_lst           = last(wds_corp_133          ),
    wds_corp_134_lst           = last(wds_corp_134          ),
    wds_corp_141_lst           = last(wds_corp_141          ),
    wds_corp_142_lst           = last(wds_corp_142          ),
    wds_corp_143_lst           = last(wds_corp_143          ),
    wds_corp_144_lst           = last(wds_corp_144          ),
    wds_corp_145_lst           = last(wds_corp_145          ),
    wds_corp_241_lst           = last(wds_corp_241          ),
    wds_corp_242_lst           = last(wds_corp_242          ),
    wds_corp_243_lst           = last(wds_corp_243          ),
    wds_corp_244_lst           = last(wds_corp_244          ),
    wds_corp_411_lst           = last(wds_corp_411          ),
    wds_corp_412_lst           = last(wds_corp_412          ),
    wds_corp_421_lst           = last(wds_corp_421          ),
    wds_corp_422_lst           = last(wds_corp_422          ),
    wds_corp_441_lst           = last(wds_corp_441          ),
    wds_corp_442_lst           = last(wds_corp_442          ),
    wds_corp_611_lst           = last(wds_corp_611          ),
    wds_corp_612_lst           = last(wds_corp_612          ),
    wds_corp_613_lst           = last(wds_corp_613          ),
    wds_corp_631_lst           = last(wds_corp_631          ),
    wds_corp_632_lst           = last(wds_corp_632          ),
    wds_corp_633_lst           = last(wds_corp_633          ),
    wds_corp_634_lst           = last(wds_corp_634          ),
    wds_corp_636_lst           = last(wds_corp_636          ),
    wds_corp_637_lst           = last(wds_corp_637          ),
    wds_corp_638_lst           = last(wds_corp_638          ),
    wds_corp_639_lst           = last(wds_corp_639          ),
    wds_corp_641_lst           = last(wds_corp_641          ),
    wds_corp_642_lst           = last(wds_corp_642          ),
    wds_corp_643_lst           = last(wds_corp_643          ),
    wds_corp_651_lst           = last(wds_corp_651          ),
    wds_corp_652_lst           = last(wds_corp_652          ),
    wds_corp_653_lst           = last(wds_corp_653          ),
    wds_corp_999_lst           = last(wds_corp_999          ),
    wds_corp_6211_lst          = last(wds_corp_6211         ),
    wds_corp_6212_lst          = last(wds_corp_6212         ),
    wds_corp_6221_lst          = last(wds_corp_6221         ),
    wds_corp_6222_lst          = last(wds_corp_6222         ),
    wds_corp_6351_lst          = last(wds_corp_6351         ),
    wds_corp_6352_lst          = last(wds_corp_6352         ),
    lns_corp_top_1_lst         = last(lns_corp_top_1        ),
    lns_corp_top_2_lst         = last(lns_corp_top_2        ),
    lns_corp_top_3_lst         = last(lns_corp_top_3        ),
    lns_corp_top_4_lst         = last(lns_corp_top_4        ),
    lns_corp_top_5_lst         = last(lns_corp_top_5        ),
    lns_corp_top_66_lst        = last(lns_corp_top_66       ),
    lns_corp_top_77_lst        = last(lns_corp_top_77       ),
    wds_corp_top_1_lst         = last(wds_corp_top_1        ),
    wds_corp_top_2_lst         = last(wds_corp_top_2        ),
    wds_corp_top_3_lst         = last(wds_corp_top_3        ),
    wds_corp_top_4_lst         = last(wds_corp_top_4        ),
    wds_corp_top_5_lst         = last(wds_corp_top_5        ),
    wds_corp_top_66_lst        = last(wds_corp_top_66       ),
    wds_corp_top_77_lst        = last(wds_corp_top_77       ),
    lns_corp_act_1_lst         = last(lns_corp_act_1        ),
    lns_corp_act_2_lst         = last(lns_corp_act_2        ),
    lns_corp_act_3_lst         = last(lns_corp_act_3        ),
    lns_corp_act_4_lst         = last(lns_corp_act_4        ),
    lns_corp_act_66_lst        = last(lns_corp_act_66       ),
    lns_corp_act_77_lst        = last(lns_corp_act_77       ),
    wds_corp_act_1_lst         = last(wds_corp_act_1        ),
    wds_corp_act_2_lst         = last(wds_corp_act_2        ),
    wds_corp_act_3_lst         = last(wds_corp_act_3        ),
    wds_corp_act_4_lst         = last(wds_corp_act_4        ),
    wds_corp_act_66_lst        = last(wds_corp_act_66       ),
    wds_corp_act_77_lst        = last(wds_corp_act_77       ),
    
    lns_corp_8_mn             = mean(lns_corp_8            ,na.rm=TRUE),
    lns_corp_9_mn             = mean(lns_corp_9            ,na.rm=TRUE),
    lns_corp_10_mn            = mean(lns_corp_10           ,na.rm=TRUE),
    lns_corp_21_mn            = mean(lns_corp_21           ,na.rm=TRUE),
    lns_corp_22_mn            = mean(lns_corp_22           ,na.rm=TRUE),
    lns_corp_23_mn            = mean(lns_corp_23           ,na.rm=TRUE),
    lns_corp_25_mn            = mean(lns_corp_25           ,na.rm=TRUE),
    lns_corp_26_mn            = mean(lns_corp_26           ,na.rm=TRUE),
    lns_corp_27_mn            = mean(lns_corp_27           ,na.rm=TRUE),
    lns_corp_28_mn            = mean(lns_corp_28           ,na.rm=TRUE),
    lns_corp_29_mn            = mean(lns_corp_29           ,na.rm=TRUE),
    lns_corp_31_mn            = mean(lns_corp_31           ,na.rm=TRUE),
    lns_corp_32_mn            = mean(lns_corp_32           ,na.rm=TRUE),
    lns_corp_33_mn            = mean(lns_corp_33           ,na.rm=TRUE),
    lns_corp_34_mn            = mean(lns_corp_34           ,na.rm=TRUE),
    lns_corp_43_mn            = mean(lns_corp_43           ,na.rm=TRUE),
    lns_corp_45_mn            = mean(lns_corp_45           ,na.rm=TRUE),
    lns_corp_51_mn            = mean(lns_corp_51           ,na.rm=TRUE),
    lns_corp_52_mn            = mean(lns_corp_52           ,na.rm=TRUE),
    lns_corp_53_mn            = mean(lns_corp_53           ,na.rm=TRUE),
    lns_corp_54_mn            = mean(lns_corp_54           ,na.rm=TRUE),
    lns_corp_55_mn            = mean(lns_corp_55           ,na.rm=TRUE),
    lns_corp_56_mn            = mean(lns_corp_56           ,na.rm=TRUE),
    lns_corp_66_mn            = mean(lns_corp_66           ,na.rm=TRUE),
    lns_corp_67_mn            = mean(lns_corp_67           ,na.rm=TRUE),
    lns_corp_68_mn            = mean(lns_corp_68           ,na.rm=TRUE),
    lns_corp_71_mn            = mean(lns_corp_71           ,na.rm=TRUE),
    lns_corp_72_mn            = mean(lns_corp_72           ,na.rm=TRUE),
    lns_corp_73_mn            = mean(lns_corp_73           ,na.rm=TRUE),
    lns_corp_111_mn           = mean(lns_corp_111          ,na.rm=TRUE),
    lns_corp_112_mn           = mean(lns_corp_112          ,na.rm=TRUE),
    lns_corp_113_mn           = mean(lns_corp_113          ,na.rm=TRUE),
    lns_corp_114_mn           = mean(lns_corp_114          ,na.rm=TRUE),
    lns_corp_121_mn           = mean(lns_corp_121          ,na.rm=TRUE),
    lns_corp_122_mn           = mean(lns_corp_122          ,na.rm=TRUE),
    lns_corp_123_mn           = mean(lns_corp_123          ,na.rm=TRUE),
    lns_corp_124_mn           = mean(lns_corp_124          ,na.rm=TRUE),
    lns_corp_125_mn           = mean(lns_corp_125          ,na.rm=TRUE),
    lns_corp_131_mn           = mean(lns_corp_131          ,na.rm=TRUE),
    lns_corp_132_mn           = mean(lns_corp_132          ,na.rm=TRUE),
    lns_corp_133_mn           = mean(lns_corp_133          ,na.rm=TRUE),
    lns_corp_134_mn           = mean(lns_corp_134          ,na.rm=TRUE),
    lns_corp_141_mn           = mean(lns_corp_141          ,na.rm=TRUE),
    lns_corp_142_mn           = mean(lns_corp_142          ,na.rm=TRUE),
    lns_corp_143_mn           = mean(lns_corp_143          ,na.rm=TRUE),
    lns_corp_144_mn           = mean(lns_corp_144          ,na.rm=TRUE),
    lns_corp_145_mn           = mean(lns_corp_145          ,na.rm=TRUE),
    lns_corp_241_mn           = mean(lns_corp_241          ,na.rm=TRUE),
    lns_corp_242_mn           = mean(lns_corp_242          ,na.rm=TRUE),
    lns_corp_243_mn           = mean(lns_corp_243          ,na.rm=TRUE),
    lns_corp_244_mn           = mean(lns_corp_244          ,na.rm=TRUE),
    lns_corp_411_mn           = mean(lns_corp_411          ,na.rm=TRUE),
    lns_corp_412_mn           = mean(lns_corp_412          ,na.rm=TRUE),
    lns_corp_421_mn           = mean(lns_corp_421          ,na.rm=TRUE),
    lns_corp_422_mn           = mean(lns_corp_422          ,na.rm=TRUE),
    lns_corp_441_mn           = mean(lns_corp_441          ,na.rm=TRUE),
    lns_corp_442_mn           = mean(lns_corp_442          ,na.rm=TRUE),
    lns_corp_611_mn           = mean(lns_corp_611          ,na.rm=TRUE),
    lns_corp_612_mn           = mean(lns_corp_612          ,na.rm=TRUE),
    lns_corp_613_mn           = mean(lns_corp_613          ,na.rm=TRUE),
    lns_corp_631_mn           = mean(lns_corp_631          ,na.rm=TRUE),
    lns_corp_632_mn           = mean(lns_corp_632          ,na.rm=TRUE),
    lns_corp_633_mn           = mean(lns_corp_633          ,na.rm=TRUE),
    lns_corp_634_mn           = mean(lns_corp_634          ,na.rm=TRUE),
    lns_corp_636_mn           = mean(lns_corp_636          ,na.rm=TRUE),
    lns_corp_637_mn           = mean(lns_corp_637          ,na.rm=TRUE),
    lns_corp_638_mn           = mean(lns_corp_638          ,na.rm=TRUE),
    lns_corp_639_mn           = mean(lns_corp_639          ,na.rm=TRUE),
    lns_corp_641_mn           = mean(lns_corp_641          ,na.rm=TRUE),
    lns_corp_642_mn           = mean(lns_corp_642          ,na.rm=TRUE),
    lns_corp_643_mn           = mean(lns_corp_643          ,na.rm=TRUE),
    lns_corp_651_mn           = mean(lns_corp_651          ,na.rm=TRUE),
    lns_corp_652_mn           = mean(lns_corp_652          ,na.rm=TRUE),
    lns_corp_653_mn           = mean(lns_corp_653          ,na.rm=TRUE),
    lns_corp_999_mn           = mean(lns_corp_999          ,na.rm=TRUE),
    lns_corp_6211_mn          = mean(lns_corp_6211         ,na.rm=TRUE),
    lns_corp_6212_mn          = mean(lns_corp_6212         ,na.rm=TRUE),
    lns_corp_6221_mn          = mean(lns_corp_6221         ,na.rm=TRUE),
    lns_corp_6222_mn          = mean(lns_corp_6222         ,na.rm=TRUE),
    lns_corp_6351_mn          = mean(lns_corp_6351         ,na.rm=TRUE),
    lns_corp_6352_mn          = mean(lns_corp_6352         ,na.rm=TRUE),
    wds_corp_8_mn             = mean(wds_corp_8            ,na.rm=TRUE),
    wds_corp_9_mn             = mean(wds_corp_9            ,na.rm=TRUE),
    wds_corp_10_mn            = mean(wds_corp_10           ,na.rm=TRUE),
    wds_corp_21_mn            = mean(wds_corp_21           ,na.rm=TRUE),
    wds_corp_22_mn            = mean(wds_corp_22           ,na.rm=TRUE),
    wds_corp_23_mn            = mean(wds_corp_23           ,na.rm=TRUE),
    wds_corp_25_mn            = mean(wds_corp_25           ,na.rm=TRUE),
    wds_corp_26_mn            = mean(wds_corp_26           ,na.rm=TRUE),
    wds_corp_27_mn            = mean(wds_corp_27           ,na.rm=TRUE),
    wds_corp_28_mn            = mean(wds_corp_28           ,na.rm=TRUE),
    wds_corp_29_mn            = mean(wds_corp_29           ,na.rm=TRUE),
    wds_corp_31_mn            = mean(wds_corp_31           ,na.rm=TRUE),
    wds_corp_32_mn            = mean(wds_corp_32           ,na.rm=TRUE),
    wds_corp_33_mn            = mean(wds_corp_33           ,na.rm=TRUE),
    wds_corp_34_mn            = mean(wds_corp_34           ,na.rm=TRUE),
    wds_corp_43_mn            = mean(wds_corp_43           ,na.rm=TRUE),
    wds_corp_45_mn            = mean(wds_corp_45           ,na.rm=TRUE),
    wds_corp_51_mn            = mean(wds_corp_51           ,na.rm=TRUE),
    wds_corp_52_mn            = mean(wds_corp_52           ,na.rm=TRUE),
    wds_corp_53_mn            = mean(wds_corp_53           ,na.rm=TRUE),
    wds_corp_54_mn            = mean(wds_corp_54           ,na.rm=TRUE),
    wds_corp_55_mn            = mean(wds_corp_55           ,na.rm=TRUE),
    wds_corp_56_mn            = mean(wds_corp_56           ,na.rm=TRUE),
    wds_corp_66_mn            = mean(wds_corp_66           ,na.rm=TRUE),
    wds_corp_67_mn            = mean(wds_corp_67           ,na.rm=TRUE),
    wds_corp_68_mn            = mean(wds_corp_68           ,na.rm=TRUE),
    wds_corp_71_mn            = mean(wds_corp_71           ,na.rm=TRUE),
    wds_corp_72_mn            = mean(wds_corp_72           ,na.rm=TRUE),
    wds_corp_73_mn            = mean(wds_corp_73           ,na.rm=TRUE),
    wds_corp_111_mn           = mean(wds_corp_111          ,na.rm=TRUE),
    wds_corp_112_mn           = mean(wds_corp_112          ,na.rm=TRUE),
    wds_corp_113_mn           = mean(wds_corp_113          ,na.rm=TRUE),
    wds_corp_114_mn           = mean(wds_corp_114          ,na.rm=TRUE),
    wds_corp_121_mn           = mean(wds_corp_121          ,na.rm=TRUE),
    wds_corp_122_mn           = mean(wds_corp_122          ,na.rm=TRUE),
    wds_corp_123_mn           = mean(wds_corp_123          ,na.rm=TRUE),
    wds_corp_124_mn           = mean(wds_corp_124          ,na.rm=TRUE),
    wds_corp_125_mn           = mean(wds_corp_125          ,na.rm=TRUE),
    wds_corp_131_mn           = mean(wds_corp_131          ,na.rm=TRUE),
    wds_corp_132_mn           = mean(wds_corp_132          ,na.rm=TRUE),
    wds_corp_133_mn           = mean(wds_corp_133          ,na.rm=TRUE),
    wds_corp_134_mn           = mean(wds_corp_134          ,na.rm=TRUE),
    wds_corp_141_mn           = mean(wds_corp_141          ,na.rm=TRUE),
    wds_corp_142_mn           = mean(wds_corp_142          ,na.rm=TRUE),
    wds_corp_143_mn           = mean(wds_corp_143          ,na.rm=TRUE),
    wds_corp_144_mn           = mean(wds_corp_144          ,na.rm=TRUE),
    wds_corp_145_mn           = mean(wds_corp_145          ,na.rm=TRUE),
    wds_corp_241_mn           = mean(wds_corp_241          ,na.rm=TRUE),
    wds_corp_242_mn           = mean(wds_corp_242          ,na.rm=TRUE),
    wds_corp_243_mn           = mean(wds_corp_243          ,na.rm=TRUE),
    wds_corp_244_mn           = mean(wds_corp_244          ,na.rm=TRUE),
    wds_corp_411_mn           = mean(wds_corp_411          ,na.rm=TRUE),
    wds_corp_412_mn           = mean(wds_corp_412          ,na.rm=TRUE),
    wds_corp_421_mn           = mean(wds_corp_421          ,na.rm=TRUE),
    wds_corp_422_mn           = mean(wds_corp_422          ,na.rm=TRUE),
    wds_corp_441_mn           = mean(wds_corp_441          ,na.rm=TRUE),
    wds_corp_442_mn           = mean(wds_corp_442          ,na.rm=TRUE),
    wds_corp_611_mn           = mean(wds_corp_611          ,na.rm=TRUE),
    wds_corp_612_mn           = mean(wds_corp_612          ,na.rm=TRUE),
    wds_corp_613_mn           = mean(wds_corp_613          ,na.rm=TRUE),
    wds_corp_631_mn           = mean(wds_corp_631          ,na.rm=TRUE),
    wds_corp_632_mn           = mean(wds_corp_632          ,na.rm=TRUE),
    wds_corp_633_mn           = mean(wds_corp_633          ,na.rm=TRUE),
    wds_corp_634_mn           = mean(wds_corp_634          ,na.rm=TRUE),
    wds_corp_636_mn           = mean(wds_corp_636          ,na.rm=TRUE),
    wds_corp_637_mn           = mean(wds_corp_637          ,na.rm=TRUE),
    wds_corp_638_mn           = mean(wds_corp_638          ,na.rm=TRUE),
    wds_corp_639_mn           = mean(wds_corp_639          ,na.rm=TRUE),
    wds_corp_641_mn           = mean(wds_corp_641          ,na.rm=TRUE),
    wds_corp_642_mn           = mean(wds_corp_642          ,na.rm=TRUE),
    wds_corp_643_mn           = mean(wds_corp_643          ,na.rm=TRUE),
    wds_corp_651_mn           = mean(wds_corp_651          ,na.rm=TRUE),
    wds_corp_652_mn           = mean(wds_corp_652          ,na.rm=TRUE),
    wds_corp_653_mn           = mean(wds_corp_653          ,na.rm=TRUE),
    wds_corp_999_mn           = mean(wds_corp_999          ,na.rm=TRUE),
    wds_corp_6211_mn          = mean(wds_corp_6211         ,na.rm=TRUE),
    wds_corp_6212_mn          = mean(wds_corp_6212         ,na.rm=TRUE),
    wds_corp_6221_mn          = mean(wds_corp_6221         ,na.rm=TRUE),
    wds_corp_6222_mn          = mean(wds_corp_6222         ,na.rm=TRUE),
    wds_corp_6351_mn          = mean(wds_corp_6351         ,na.rm=TRUE),
    wds_corp_6352_mn          = mean(wds_corp_6352         ,na.rm=TRUE),
    lns_corp_top_1_mn         = mean(lns_corp_top_1        ,na.rm=TRUE),
    lns_corp_top_2_mn         = mean(lns_corp_top_2        ,na.rm=TRUE),
    lns_corp_top_3_mn         = mean(lns_corp_top_3        ,na.rm=TRUE),
    lns_corp_top_4_mn         = mean(lns_corp_top_4        ,na.rm=TRUE),
    lns_corp_top_5_mn         = mean(lns_corp_top_5        ,na.rm=TRUE),
    lns_corp_top_66_mn        = mean(lns_corp_top_66       ,na.rm=TRUE),
    lns_corp_top_77_mn        = mean(lns_corp_top_77       ,na.rm=TRUE),
    wds_corp_top_1_mn         = mean(wds_corp_top_1        ,na.rm=TRUE),
    wds_corp_top_2_mn         = mean(wds_corp_top_2        ,na.rm=TRUE),
    wds_corp_top_3_mn         = mean(wds_corp_top_3        ,na.rm=TRUE),
    wds_corp_top_4_mn         = mean(wds_corp_top_4        ,na.rm=TRUE),
    wds_corp_top_5_mn         = mean(wds_corp_top_5        ,na.rm=TRUE),
    wds_corp_top_66_mn        = mean(wds_corp_top_66       ,na.rm=TRUE),
    wds_corp_top_77_mn        = mean(wds_corp_top_77       ,na.rm=TRUE),
    lns_corp_act_1_mn         = mean(lns_corp_act_1        ,na.rm=TRUE),
    lns_corp_act_2_mn         = mean(lns_corp_act_2        ,na.rm=TRUE),
    lns_corp_act_3_mn         = mean(lns_corp_act_3        ,na.rm=TRUE),
    lns_corp_act_4_mn         = mean(lns_corp_act_4        ,na.rm=TRUE),
    lns_corp_act_66_mn        = mean(lns_corp_act_66       ,na.rm=TRUE),
    lns_corp_act_77_mn        = mean(lns_corp_act_77       ,na.rm=TRUE),
    wds_corp_act_1_mn         = mean(wds_corp_act_1        ,na.rm=TRUE),
    wds_corp_act_2_mn         = mean(wds_corp_act_2        ,na.rm=TRUE),
    wds_corp_act_3_mn         = mean(wds_corp_act_3        ,na.rm=TRUE),
    wds_corp_act_4_mn         = mean(wds_corp_act_4        ,na.rm=TRUE),
    wds_corp_act_66_mn        = mean(wds_corp_act_66       ,na.rm=TRUE),
    wds_corp_act_77_mn        = mean(wds_corp_act_77       ,na.rm=TRUE)
)

isor_so_agg  %>% 
  select(
    cab_id, so_start_fst, so_n, 
    ext_tsb_agc1_fst, ext_tsb_agc1_lst, 
    wds_clean_rel_mn, wds_clean_rel_fst, 
    wds_clean_rel_wdns_corr_fst
  )  %>% 
  head(100)


# merging isom and isor_so

isom <- 
  isom  %>% 
  left_join(isor_so_agg, by=c(cab_id="cab_id"))



#### last minute changes =======================================================

isom$db_version         <- max(isom$db_version, na.rm = TRUE)
isom$db_lastupdate      <- max(isom$db_lastupdate, na.rm = TRUE)
isom$db_isom_lastupdate <- Sys.time()
isom <- 
  isom  %>% 
  select(db_isom_lastupdate, db_version, db_lastupdate, everything())


#### saving to disk ============================================================

save(      isom, file = "isom.Rdata")
write.dta( isom, file = "isom.dta")
















