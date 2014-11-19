SELECT * FROM data_linelinkage ;
SELECT * FROM data_textlines ;
SELECT * FROM data_texts ;

SELECT 
t_id, t_date, t_dplus, t_country, t_daccept, t_dpromul, t_denact,
count(tl_wds_raw )                            as lines_all, 
sum( IF(tl_relevant=1,1,NULL) )                  as lines_rel,
sum( tl_wds_raw )                             as wds_raw_all, 
sum( tl_wds_clean )                           as wds_clean_all,
sum( IF(tl_relevant=1, tl_wds_raw, NULL) )       as wds_raw_rel, 
sum( IF(tl_relevant=1, tl_wds_clean, NULL) )     as wds_clean_rel
FROM data_texts
LEFT JOIN data_textlines on tl_t_id=t_id
GROUP BY t_id
;

SELECT 
t_id, t_date, t_dplus, t_country, t_daccept, t_dpromul, t_denact,
sum( IF(ll_type="no-change",ll_sim_wd,NULL) )                           as wds_no_change,
sum( ll_sim_wd )                                                     as wds_sim_all,
sum( ll_diff_wd )                                                    as wds_diff_all,
sum( IF(ll_type!="no-change",ll_diff_wd,NULL) )                         as wds_change_all,
sum( IF(ll_type="change",ll_diff_wd,NULL) )                             as wds_changed,
sum( IF(ll_type="insertion",ll_diff_wd,NULL) )                          as wds_ins,
sum( IF(ll_type="deletion",ll_diff_wd,NULL) )                           as wds_del
FROM data_texts
LEFT JOIN data_linelinkage on ll_t_id2=t_id
WHERE t_country="BEL"
GROUP BY data_texts.t_id
;



