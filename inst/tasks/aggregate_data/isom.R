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

last_so <- 
  isor_so %>% 
  arrange(so_t_id)  %>% 
  group_by(ctr)  %>% 
  summarise(id=last(so_t_id), last(so_end)) %>% 
  `[[`("id")

isor_so[isor_so$so_t_id %in% last_so, "so_end"] <- Sys.Date()



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



### aggregation reforms
source(
  system.file(
    "tasks/aggregate_data/isom_helper_aggregate_chg.R", 
    package = "idep"
  )
)
isor_chg_agg <- filter(isor_chg_agg, !is.na(ref_id_fst))



# all variables 
dim(isor_chg)
dim(isor_chg_agg)

# join isom with isor_chg_agg
isom <-
  isom  %>% 
  left_join(isor_chg_agg)

# have a glance
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

  # cab_out between so_start and so_end
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

source(
  system.file(
    "tasks/aggregate_data/isom_helper_aggregate_so.R", 
    package = "idep"
  )
)


isor_so_agg  %>% 
  select(
    cab_id, so_start_fst, so_n, 
    ext_tsb_agc1_fst, ext_tsb_agc1_lst, 
    wds_clean_rel_mn, wds_clean_rel_fst
  )  %>% 
  head(100)


# merging isom and isor_so

isom <- 
  isom  %>% 
  left_join(isor_so_agg, by=c(cab_id="cab_id"))


#### last minute changes =======================================================

# versions 
isom$db_version         <- as.character(max(isom$db_version, na.rm = TRUE))
isom$db_lastupdate      <- as.character(max(isom$db_lastupdate, na.rm = TRUE))
isom$db_isom_lastupdate <- as.character(Sys.Date())
isom <- 
  isom  %>% 
  select(db_isom_lastupdate, db_version, db_lastupdate, everything())

isom$ref_n[!is.na(isom$so_n) & is.na(isom$ref_n)] <- 0

# isom  %>% select(ctr, cab_id, cab_in, cab_out, so_id_fst, so_start_fst, so_end_lst, so_n, ref_n)  %>% head(400)


#### dichotomize pro_maj / pro_min codings =====================================

isom %>% 
  filter( pro_min_sum > 0, pro_maj_sum > 0 ) %>% 
  select(ctr, cab_id, cab_pm, pro_maj_sum, 
         pro_min_sum, pro_non_sum, pro_minmaj_qual_all )

isom$pro_minmaj_qual <-
  sapply(
    str_split(isom$pro_minmaj_qual, ","), 
    function(x){ 
      x <- 
        unique(x[ !is.na(x) & x != "NA" & !is.null(x) ])
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
isom$pro_minmaj_qual[isom$cab_id==613]  <- -1
isom$pro_minmaj_qual[isom$cab_id==925]  <-  1 
isom$pro_minmaj_qual[isom$cab_id==1005] <-  1
isom$pro_minmaj_qual[isom$cab_id==1036] <-  1 
isom$pro_minmaj_qual[isom$cab_id==1038] <-  1 
isom$pro_minmaj_qual[isom$cab_id==1328] <- -1 
isom$pro_minmaj_qual[isom$cab_id==1624] <-  0

isom$pro_minmaj_qual[is.na(isom$ref_n)] <- NA


isom  %>% 
  select(ctr, cab_in, cab_id, ref_n, 
         pro_minmaj_qual, pro_min_sum, pro_maj_sum)   %>% 
  filter(pro_minmaj_qual==-99) %>% 
  head(400) 


isom$pro_minmaj_auto1 <- 0 # based on words
isom$pro_minmaj_auto1[ isom$pro_maj_sum > isom$pro_min_sum ] <-  1
isom$pro_minmaj_auto1[ isom$pro_min_sum > isom$pro_maj_sum ] <- -1
isom$pro_minmaj_auto1[is.na(isom$ref_n)] <- NA

isom$pro_minmaj_auto2 <- 0 # based on lines
isom$pro_minmaj_auto2[ isom$wds_pro_maj_sum > isom$wds_pro_min_sum ] <-  1
isom$pro_minmaj_auto2[ isom$wds_pro_min_sum > isom$wds_pro_maj_sum ] <- -1
isom$pro_minmaj_auto2[is.na(isom$ref_n)] <- NA


# correlation
isom  %>% 
  select(pro_minmaj_qual, pro_minmaj_auto1, pro_minmaj_auto2) %>% 
  cor(use="pairwise.complete.obs") %>% 
  round(2)  %>% knitr::kable()

# manual decisions
# isom %>% 
#   filter(cab_id %in% c(1720,1622,1329,1042,1710,1718,1719,1723,1410,1214,1221,1224,228 ,527 ,613 ,925 ,1005,1036,1038,1328,1624)) %>% 
#   select(ctr, cab_id, cab_pm, cab_in, cab_out, pro_maj_sum, pro_min_sum, pro_minmaj_qual)  %>% 
#   head(100)  %>% 
#   knitr::kable()



#### adding majority requirement and veto points 

load("../external_data/maj_req.Rdata")
load("../external_data/veto_pts.Rdata")

maj_req  <- maj_req %>% select(-ctr)
veto_pts <- veto_pts %>% select(-ctr)

isom <- 
  isom  %>% 
  left_join(maj_req)
isom <- 
  isom  %>% 
  left_join(veto_pts)

# isom$veto_pts
# isom$maj_req


#### saving to disk ============================================================

save(      isom, file = "isom.Rdata")

isom_stata <- as.data.frame(isom)
isom_stata[,"ref_id_all"] <- substring(isom_stata[,"ref_id_all"],0,100)
isom_stata[,"so_id_all"] <- substring(isom_stata[,"so_id_all"],0,100)
write.dta( isom_stata, file = "isom.dta")
















