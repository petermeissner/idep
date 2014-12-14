-- ----------------------------------------------
-- TEMPORARY TABLES
-- ----------------------------------------------


-- last update of data  ----------------------------------------------
DROP VIEW IF EXISTS view_last_update ; 
CREATE VIEW view_last_update  AS 
	SELECT data_linelinkage.int_dupdate_linelinkage as int_dupdate FROM data_linelinkage 
		UNION select data_texts.int_dupdate_texts as int_dupdate from data_texts 
		UNION select data_textlines.int_dupdate_textlines as int_dupdate from data_textlines
;
-- SELECT max(view_last_update.int_dupdate) FROM view_last_update; 
-- -----------------------------------------------------------------------------------------------------------------------------------------------




-- table of unique linkages between specific country-text-time and second country-text-time
DROP TABLE IF EXISTS temp_changes_t_id ; 
CREATE TABLE temp_changes_t_id AS 
  SELECT DISTINCT ll_t_id1, ll_t_id2 from data_linelinkage ; 

-- lead and lag values of t_id
DROP TABLE IF EXISTS temp_t_id_lags ; 
CREATE TABLE temp_t_id_lags AS
	SELECT 
		temp_changes_t_id.ll_t_id1 as t_id1, temp_changes_t_id.ll_t_id2 as t_id2, 
		temp_changes_t_id2.ll_t_id1 as t_id1_lag1, temp_changes_t_id2.ll_t_id2 as t_id2_lag1, 
		temp_changes_t_id0.ll_t_id1 as t_id1_lead1, temp_changes_t_id0.ll_t_id2 as t_id2_lead1
		FROM      temp_changes_t_id
		LEFT JOIN temp_changes_t_id  as temp_changes_t_id2 on temp_changes_t_id.ll_t_id1 = temp_changes_t_id2.ll_t_id2 
		LEFT JOIN temp_changes_t_id  as temp_changes_t_id0 on temp_changes_t_id.ll_t_id2 = temp_changes_t_id0.ll_t_id1 
	order by temp_changes_t_id.ll_t_id1 
; 
-- SELECT * FROM temp_t_id_lags ; 
-- -----------------------------------------------------------------------------------------------------------------------------------------------



DROP TABLE IF EXISTS temp_linelinkage1_textlines;
CREATE TABLE temp_linelinkage1_textlines AS
	SELECT
		ll_tl_id1, ll_tl_id2, ll_sim, ll_diff, ll_sim_wd, ll_diff_wd, ll_type, data_linelinkage.ll_t_id1, data_linelinkage.ll_t_id2, ll_tl_lnr1, ll_tl_lnr2, ll_minmaj_code, ll_minmaj_coder, ll_minmaj_memo, ll_linkage_coder, int_dupdate_linelinkage, int_id_linelinkage as int_id_1,
		textlines1.tl_id as tl_id1 , textlines1.tl_t_id as tl_t_id1 , textlines1.tl_lnr as tl_lnr1 , textlines1.tl_relevant as tl_relevant1 , textlines1.tl_corpus_code as tl_corpus_code1 , textlines1.tl_text as tl_text1 , textlines1.tl_wds_raw as tl_wds_raw1 , textlines1.tl_wds_clean as tl_wds_clean1 , textlines1.tl_corpus_memo as tl_corpus_memo1 
	FROM data_linelinkage
	LEFT JOIN data_textlines as textlines1 ON textlines1.tl_id = data_linelinkage.ll_tl_id1
;
CREATE INDEX `idx_temp_linelinkage1_textlines_int_id`  ON `temp_linelinkage1_textlines` (int_id_1);
SELECT * FROM temp_linelinkage2_textlines ; 


DROP TABLE IF EXISTS temp_linelinkage2_textlines;
CREATE TABLE temp_linelinkage2_textlines AS
	SELECT
		int_id_linelinkage as int_id_2,
		textlines2.tl_id as tl_id2 , textlines2.tl_t_id as tl_t_id2 , textlines2.tl_lnr as tl_lnr2 , textlines2.tl_relevant as tl_relevant2 , textlines2.tl_corpus_code as tl_corpus_code2 , textlines2.tl_text as tl_text2 , textlines2.tl_wds_raw as tl_wds_raw2 , textlines2.tl_wds_clean as tl_wds_clean2 , textlines2.tl_corpus_memo as tl_corpus_memo2 
	FROM data_linelinkage
	LEFT JOIN data_textlines as textlines2 ON textlines2.tl_id = data_linelinkage.ll_tl_id2
;
CREATE INDEX `idx_temp_linelinkage2_textlines_int_id`  ON `temp_linelinkage2_textlines` (int_id_2);
SELECT * FROM temp_linelinkage2_textlines ; 



DROP TABLE IF EXISTS temp_linelinkage_textlines;
CREATE TABLE temp_linelinkage_textlines 
AS SELECT * FROM    temp_linelinkage1_textlines AS A
			JOIN    temp_linelinkage2_textlines as B 
			ON A.int_id_1 = B.int_id_2
;

CREATE INDEX `idx_temp_linelinkage_textlines_ll_t_id1`  ON `web234_db3`.`temp_linelinkage_textlines` (ll_t_id1) COMMENT '';
CREATE INDEX `idx_temp_linelinkage_textlines_ll_t_id2`  ON `web234_db3`.`temp_linelinkage_textlines` (ll_t_id2) COMMENT '';

DROP TABLE IF EXISTS temp_linelinkage_textlines_texts;
CREATE TABLE temp_linelinkage_textlines_texts AS
	SELECT * 	FROM temp_linelinkage_textlines AS A
			JOIN 	(	SELECT t_id as t_t_id1, t_date as t_date1, t_dplus as t_dplus1, t_country as t_country1, t_daccept as t_daccept1, t_dpromul as t_dpromul1, t_denact as t_denact1
						FROM data_texts
					) 	AS C
				ON A.ll_t_id1 = C.t_t_id1
			JOIN 	(	SELECT t_id as t_t_id2, t_date as t_date2, t_dplus as t_dplus2, t_country as t_country2, t_daccept as t_daccept2,  t_dpromul as t_dpromul2, t_denact as t_denact2
						FROM data_texts
					) 	AS D
				ON A.ll_t_id2 = D.t_t_id2
;


-- SELECT * FROM temp_linelinkage_textlines_texts ; 
-- SELECT COUNT(*) FROM temp_linelinkage_textlines_texts WHERE ll_type='no-change'; 
-- SELECT COUNT(*) FROM temp_linelinkage_textlines_texts WHERE ll_type='deletion'; 
-- SELECT COUNT(*) FROM temp_linelinkage_textlines_texts WHERE ll_type='insertion'; 
-- SELECT COUNT(*) FROM temp_linelinkage_textlines_texts WHERE ll_type='change'; 
-- -----------------------------------------------------------------------------------------------------------------------------------------------



-- lead and lag values of tl_id
DROP TABLE IF EXISTS temp_tl_id_lags ; 
CREATE TABLE temp_tl_id_lags AS
	SELECT 
		temp_changes_tl_id.ll_tl_id1  as tl_id1, temp_changes_tl_id.ll_tl_id2 as tl_id2, 
		temp_changes_tl_id2.ll_tl_id1 as tl_id1_lag1,  temp_changes_tl_id2.ll_tl_id2 as tl_id2_lag1
		FROM      temp_changes_tl_id
		LEFT JOIN temp_changes_tl_id  as temp_changes_tl_id2 on temp_changes_tl_id.ll_tl_id1 = temp_changes_tl_id2.ll_tl_id2 
; 
-- SELECT * FROM temp_tl_id_lags ; 
-- -----------------------------------------------------------------------------------------------------------------------------------------------



-- lead and lag values of tl_id
DROP TABLE IF EXISTS temp_tl_id_leads ; 
CREATE TABLE temp_tl_id_leads AS
	SELECT 
		temp_changes_tl_id.ll_tl_id1  as tl_id1, temp_changes_tl_id.ll_tl_id2 as tl_id2, 
		temp_changes_tl_id0.ll_tl_id1 as tl_id1_lead1, temp_changes_tl_id0.ll_tl_id2 as tl_id2_lead1
		FROM      temp_changes_tl_id
		LEFT JOIN temp_changes_tl_id  as temp_changes_tl_id0 on temp_changes_tl_id.ll_tl_id2 = temp_changes_tl_id0.ll_tl_id1 
; 
-- SELECT * FROM temp_tl_id_leads ; 
-- -----------------------------------------------------------------------------------------------------------------------------------------------



-- texts joined with textlines  ----------------------------------------------
DROP TABLE IF EXISTS temp_texts_textlines ; 
CREATE TABLE temp_texts_textlines AS 
	SELECT
	data_texts.t_id, 
	data_texts.t_date, 
	data_texts.t_dplus, 
	data_texts.t_country, 
	data_texts.t_daccept, 
	data_texts.t_dpromul, 
	data_texts.t_denact,
	sum(data_textlines.tl_relevant)  as lines_relevant,
	sum(data_textlines.tl_wds_raw)   as wds_raw, 
	sum(data_textlines.tl_wds_clean) as wds_clean, 
	sum( if(data_textlines.tl_relevant=1, data_textlines.tl_wds_clean, 0) )  as wds_clean_relevant,
	sum( if(data_textlines.tl_relevant=1, data_textlines.tl_wds_raw  , 0) )    as wds_raw_relevant,
	sum( if(data_textlines.tl_corpus_code!=999, data_textlines.tl_wds_clean, 0) )  as wds_clean_not_cc999,
	sum( if(data_textlines.tl_corpus_code!=999, data_textlines.tl_wds_raw  , 0) )    as wds_raw_not_cc999,
    sum( if(data_textlines.tl_corpus_code = 111, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_111,  sum(if(data_textlines.tl_corpus_code = 112, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_112,  sum(if(data_textlines.tl_corpus_code = 113, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_113,  sum(if(data_textlines.tl_corpus_code = 114, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_114,  sum(if(data_textlines.tl_corpus_code = 121, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_121,  sum(if(data_textlines.tl_corpus_code = 122, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_122,  sum(if(data_textlines.tl_corpus_code = 123, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_123,  sum(if(data_textlines.tl_corpus_code = 124, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_124,  sum(if(data_textlines.tl_corpus_code = 125, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_125,  sum(if(data_textlines.tl_corpus_code = 131, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_131,  sum(if(data_textlines.tl_corpus_code = 132, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_132,  sum(if(data_textlines.tl_corpus_code = 133, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_133,  sum(if(data_textlines.tl_corpus_code = 134, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_134,  sum(if(data_textlines.tl_corpus_code = 141, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_141,  sum(if(data_textlines.tl_corpus_code = 142, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_142,  sum(if(data_textlines.tl_corpus_code = 143, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_143,  sum(if(data_textlines.tl_corpus_code = 144, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_144,  sum(if(data_textlines.tl_corpus_code = 145, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_145,  sum(if(data_textlines.tl_corpus_code = 21, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_21,  sum(if(data_textlines.tl_corpus_code = 22, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_22,  sum(if(data_textlines.tl_corpus_code = 23, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_23,  sum(if(data_textlines.tl_corpus_code = 241, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_241,  sum(if(data_textlines.tl_corpus_code = 242, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_242,  sum(if(data_textlines.tl_corpus_code = 243, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_243,  sum(if(data_textlines.tl_corpus_code = 244, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_244,  sum(if(data_textlines.tl_corpus_code = 25, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_25,  sum(if(data_textlines.tl_corpus_code = 26, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_26,  sum(if(data_textlines.tl_corpus_code = 27, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_27,  sum(if(data_textlines.tl_corpus_code = 28, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_28,  sum(if(data_textlines.tl_corpus_code = 29, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_29,  sum(if(data_textlines.tl_corpus_code = 31, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_31,  sum(if(data_textlines.tl_corpus_code = 32, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_32,  sum(if(data_textlines.tl_corpus_code = 33, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_33,  sum(if(data_textlines.tl_corpus_code = 34, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_34,  sum(if(data_textlines.tl_corpus_code = 411, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_411,  sum(if(data_textlines.tl_corpus_code = 412, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_412,  sum(if(data_textlines.tl_corpus_code = 421, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_421,  sum(if(data_textlines.tl_corpus_code = 422, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_422,  sum(if(data_textlines.tl_corpus_code = 43, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_43,  sum(if(data_textlines.tl_corpus_code = 441, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_441,  sum(if(data_textlines.tl_corpus_code = 442, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_442,  sum(if(data_textlines.tl_corpus_code = 45, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_45,  sum(if(data_textlines.tl_corpus_code = 51, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_51,  sum(if(data_textlines.tl_corpus_code = 52, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_52,  sum(if(data_textlines.tl_corpus_code = 53, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_53,  sum(if(data_textlines.tl_corpus_code = 54, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_54,  sum(if(data_textlines.tl_corpus_code = 55, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_55,  sum(if(data_textlines.tl_corpus_code = 56, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_56,  sum(if(data_textlines.tl_corpus_code = 611, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_611,  sum(if(data_textlines.tl_corpus_code = 612, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_612,  sum(if(data_textlines.tl_corpus_code = 613, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_613,  sum(if(data_textlines.tl_corpus_code = 6211, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_6211,  sum(if(data_textlines.tl_corpus_code = 6212, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_6212,  sum(if(data_textlines.tl_corpus_code = 6221, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_6221,  sum(if(data_textlines.tl_corpus_code = 6222, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_6222,  sum(if(data_textlines.tl_corpus_code = 631, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_631,  sum(if(data_textlines.tl_corpus_code = 632, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_632,  sum(if(data_textlines.tl_corpus_code = 633, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_633,  sum(if(data_textlines.tl_corpus_code = 634, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_634,  sum(if(data_textlines.tl_corpus_code = 6351, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_6351,  sum(if(data_textlines.tl_corpus_code = 6352, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_6352,  sum(if(data_textlines.tl_corpus_code = 636, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_636,  sum(if(data_textlines.tl_corpus_code = 637, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_637,  sum(if(data_textlines.tl_corpus_code = 638, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_638,  sum(if(data_textlines.tl_corpus_code = 639, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_639,  sum(if(data_textlines.tl_corpus_code = 641, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_641,  sum(if(data_textlines.tl_corpus_code = 642, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_642,  sum(if(data_textlines.tl_corpus_code = 643, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_643,  sum(if(data_textlines.tl_corpus_code = 651, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_651,  sum(if(data_textlines.tl_corpus_code = 652, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_652,  sum(if(data_textlines.tl_corpus_code = 653, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_653,  sum(if(data_textlines.tl_corpus_code = 66, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_66,  sum(if(data_textlines.tl_corpus_code = 67, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_67,  sum(if(data_textlines.tl_corpus_code = 68, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_68,  sum(if(data_textlines.tl_corpus_code = 71, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_71,  sum(if(data_textlines.tl_corpus_code = 72, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_72,  sum(if(data_textlines.tl_corpus_code = 73, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_73,  sum(if(data_textlines.tl_corpus_code = 8, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_8,  sum(if(data_textlines.tl_corpus_code = 9, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_9,  sum(if(data_textlines.tl_corpus_code = 10, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_10,  sum(if(data_textlines.tl_corpus_code = 999, data_textlines.tl_wds_clean, 0)) as wds_clean_cc_999
FROM data_texts
LEFT JOIN data_textlines ON data_texts.t_id = data_textlines.tl_t_id 
GROUP BY data_texts.t_id
;









