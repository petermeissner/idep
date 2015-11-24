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
  so_date    = t_date,
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

isor_chg_joined <- 
  isom["cab_id"]  %>% 
  left_join(isor_chg, by=c(cab_id="erd_cab_id"))

isor_chg_joined %>% desc_df()

isor_chg_joined$ref_n <- NA
for(cabid in unique(isor_chg_joined$cab_id) ){
  iffer <- isor_chg_joined$cab_id == cabid
  isor_chg_joined$ref_n[iffer] <- 
    sum( !is.na(isor_chg_joined$ref_date[iffer]) )
}

isor_chg_agg <- 
isor_chg_joined  %>% 
  arrange(cab_id, ref_date, ref_dplus) %>% 
  select(cab_id, ref_date, ref_dplus, ref_n, everything()) %>% 
  group_by(cab_id) %>%  
  summarise(
    ref_id_fst             = first(ref_t_id             ),
    ref_id_lst             = last( ref_t_id              ),
    ref_id_all             = paste(ref_t_id, collapse=", "),

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
    wds_pro_non_del_sum        = sum(wds_pro_non_del   ,na.rm=TRUE)    
    
  )
isor_chg_agg <- filter(isor_chg_agg, !is.na(ref_id_fst))


#### merging erd and isor_so ===================================================













#### saving non aggregated data for later ======================================

isom_non_agg <- isom




#### aggregation ===============================================================
source(
  system.file(package="idep","tasks/aggregate_data/isom_helper_aggregation.R")
)


#### dichotomize pro_maj / pro_min codings =====================================

isom %>% 
  filter( pro_min_sum > 0, pro_maj_sum > 0 ) %>% 
  select(ctr, cab_id, cab_pm, pro_maj_sum, 
         pro_min_sum, pro_non_sum, pro_minmaj_qual_sum )

isom$pro_minmaj_qual <-
  sapply(
    str_split(isom$pro_minmaj_qual_sum, ", "), 
    function(x){ 
      x <- unique(x[ x != "NA" & !is.null(x) ])
      if( length(x)     ==     0      ) return(  0 )
      if( all(unique(x) ==     0     )) return(  0 )
      if( all(unique(x) %in% c(0, 1) )) return(  1 ) 
      if( all(unique(x) %in% c(0,-1) )) return( -1 )
      -99
    } 
  )

isom$pro_minmaj_qual[isom$cab_id==1720] <- -1
isom$pro_minmaj_qual[isom$cab_id==1622] <-  1
isom$pro_minmaj_qual[isom$cab_id==1329] <- -1 
isom$pro_minmaj_qual[isom$cab_id==1042] <- -1
isom$pro_minmaj_qual[isom$cab_id==1710] <-  1 
isom$pro_minmaj_qual[isom$cab_id==1718] <-  0
isom$pro_minmaj_qual[isom$cab_id==1719] <- -1
isom$pro_minmaj_qual[isom$cab_id==1723] <-  0 
isom$pro_minmaj_qual[isom$cab_id==1410] <- -1
isom$pro_minmaj_qual[isom$cab_id==1214] <-  0
isom$pro_minmaj_qual[isom$cab_id==1221] <-  0
isom$pro_minmaj_qual[isom$cab_id==1224] <-  0
isom$pro_minmaj_qual[isom$cab_id==228]  <-  1 
isom$pro_minmaj_qual[isom$cab_id==527]  <-  0
isom$pro_minmaj_qual[isom$cab_id==613]  <-  2
isom$pro_minmaj_qual[isom$cab_id==925]  <-  1 
isom$pro_minmaj_qual[isom$cab_id==1005] <-  1
isom$pro_minmaj_qual[isom$cab_id==1036] <-  1 
isom$pro_minmaj_qual[isom$cab_id==1038] <-  1 
isom$pro_minmaj_qual[isom$cab_id==1328] <- -1 
isom$pro_minmaj_qual[isom$cab_id==1624] <-  0

isom  <- 
  isom %>% select(-pro_minmaj_qual_sum)
  
isom  %>% 
  select(ctr, cab_in, cab_id, n_reforms, 
         pro_minmaj_qual, pro_min_sum, pro_maj_sum)   %>% 
  filter(n_reforms>0, pro_minmaj_qual==-99) %>% 
  head(400) 
  
  
isom$pro_minmaj_auto1 <- 0 # based on words
isom$pro_minmaj_auto1[ isom$pro_maj_sum > isom$pro_min_sum ] <-  1
isom$pro_minmaj_auto1[ isom$pro_min_sum > isom$pro_maj_sum ] <- -1

isom$pro_minmaj_auto2 <- 0 # based on lines
isom$pro_minmaj_auto2[ isom$wds_pro_maj_sum > isom$wds_pro_min_sum ] <-  1
isom$pro_minmaj_auto2[ isom$wds_pro_min_sum > isom$wds_pro_maj_sum ] <- -1

# correlation
isom  %>% 
  select(pro_minmaj_qual, pro_minmaj_auto1, pro_minmaj_auto2) %>% 
  cor() %>% 
  round(2)


#### fill values for isom ======================================================

isom  %>% 
  select(ctr, cab_id, cab_in, t_date_fst, t_date_lst,
       n_reforms, wds_chg_sum, wds_clean_rel_mn)   %>% 
  head(30)

no_change_vars <- 
  grep(
    "_mdf|_chg|_ins|_del|pro_", names(isom), 
    value=TRUE, invert=TRUE
  )

change_vars <- 
  grep(
    "_mdf|_chg|_ins|_del|pro_", names(isom), 
    value=TRUE
  )

# change vars should be 0 by default 
isom[,change_vars] %>% head(10)

# non_change vars should be filled with previous value
isom[,no_change_vars] %>% head(10)

# filling for non-change vars
isom <-
  isom %>% 
  arrange(ctr, cab_in)

for( i in seq_len(dim(isom)[1]) ){
  for( var in no_change_vars ){
    if( 
      i > 1 & 
      as.vector(is.na(isom[i,var])) &
      null_to_false(isom$ctr[i] == isom$ctr[i-1])
    ) 
    {
      isom[i, var] <- isom[i-1, var]
    }
  }
}


#### fill values for isom_non_agg ==============================================

# n_reforms
isom_non_agg$n_reforms <- ifelse(is.na(isom_non_agg$t_date), 0, 1)
isom_non_agg$n_reforms <- ifelse(
                            isom_non_agg$cab_in > isom_non_agg$t_date & 
                              !is.na(isom_non_agg$t_date), 
                            0, 
                            isom_non_agg$n_reforms
                          )

# show some data
isom_non_agg  %>% 
  select(ctr, cab_id, cab_in, t_date, n_reforms, wds_chg, wds_clean_rel)   %>% 
  head(30)

# gen change and non-change-vars
no_change_vars <- 
  grep(
    "_mdf|_chg|_ins|_del|pro_", names(isom_non_agg), 
    value=TRUE, invert=TRUE
  )

change_vars <- 
  grep(
    "_mdf|_chg|_ins|_del|pro_", names(isom_non_agg), 
    value=TRUE
  )

# change vars should be 0 by default 
isom_non_agg[,change_vars] %>% head(10)

# non_change vars should be filled with previous value
isom_non_agg[,no_change_vars] %>% head(10)

# filling for non-change vars
isom_non_agg <-
  isom_non_agg %>% 
  arrange(ctr, cab_in)

for( i in seq_len(dim(isom_non_agg)[1]) ){
  for( var in no_change_vars ){
    if( 
      i > 1 & 
      as.vector(is.na(isom_non_agg[i,var])) &
      null_to_false(isom_non_agg$ctr[i] == isom_non_agg$ctr[i-1])
    ) 
    {
      isom_non_agg[i, var] <- isom_non_agg[i-1, var]
    }
  }
}


#### save data =================================================================
save(      isom, file = "isom.Rdata")
write.dta( isom, file = "isom.dta")

save(      isom_non_agg, file = "isom_non_agg.Rdata")
write.dta( isom_non_agg, file = "isom_non_agg.dta")



#### expanding isor data for missing values (if applicaple) ====================
# if(1 == 2){
# isom <- 
#   isom  %>% 
#   arrange(country, cab_in)
# 
# desc_df(isom, cols=90:120)
# 
# # fill holes with lag values 
# for(i in seq_len(dim(isom)[1]) ){
#   isom$t_id[i] <- 
#     ifelse( 
#       is.na(isom$t_id[i]) & isom$ctr[i] == lag(isom$ctr)[i], 
#       lag(isom$t_id)[i], 
#       isom$t_id[i] 
#     )                   
# }
# 
# 
# # fill start values with SOs before cabinet
# for ( i in which(is.na(isom$t_id)) ){
#   isom$t_id[i] <- 
#     suppressWarnings(
#       max(isor$t_id[ isor$ctr == isom$ctr[i] & 
#                        isor$t_date <= isom$cab_out[i] ]        ,
#           na.rm=TRUE))
# }
# 
# variables <- 
#   names(isom)[
#     names(isom) %in% names(isor) & 
#       !(names(isom) %in% c("ctr", "country", "t_id"))
#     ]
# 
# isom <- 
#   isom[ , -which(names(isom) %in% variables)]
# 
# isom <- 
#   left_join( isom, isor[, c("t_id", variables)], by="t_id" )
# 
# 
# isom %>% 
#   select(ctr, cab_in, t_id, wds_clean_rel, wds_chg)  %>% 
#   head(50)
# 
# # NAs to 0 for all change variables
# for (var in grep("_del|_ins|_mdf|_chg", names(isom), value = TRUE) ) {
#   isom[is.na(isom[, var]) & !is.na(isom$wds_raw_all), var] <- 0 
# }
# 
# # non-change to 0 for all change varaibles
# var <- grep("_del|_ins|_mdf|_chg", names(isom), value = TRUE)
# for (i in seq_len(dim(isom)[1])[-1] ) {
#   if ( isom$t_id[i] == isom$t_id[i-1] & all(!is.na(isom$t_id[i:(i-1)])) ){
#     isom[i, "wds_chg"] <- 0 
#   }
#   if ( isom$ctr[i] == isom$ctr[i-1] & is.na(isom$t_id[i-1]) ){
#     isom[i, "wds_chg"] <- NA
#   }
# }
# 
# 
# }















