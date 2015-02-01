


-- merging linelinkage and textlines and text data -----------------------------------------------------------------------------------------------
  
-- ll id 1 - textlines 
DROP TABLE IF EXISTS temp_linelinkage1_textlines;
CREATE TABLE temp_linelinkage1_textlines AS
	SELECT
		ll_tl_id1, ll_tl_id2, ll_sim, ll_diff, ll_sim_wd, ll_diff_wd, ll_type, data_linelinkage.ll_t_id1, data_linelinkage.ll_t_id2, ll_tl_lnr1, ll_tl_lnr2, ll_minmaj_code, ll_minmaj_coder, ll_minmaj_memo, ll_linkage_coder, int_dupdate_linelinkage, int_id_linelinkage as int_id_1,
		textlines1.tl_id as tl_id1 , textlines1.tl_t_id as tl_t_id1 , textlines1.tl_lnr as tl_lnr1 , textlines1.tl_relevant as tl_relevant1 , textlines1.tl_corpus_code as tl_corpus_code1 , textlines1.tl_text as tl_text1 , textlines1.tl_wds_raw as tl_wds_raw1 , textlines1.tl_wds_clean as tl_wds_clean1 , textlines1.tl_corpus_memo as tl_corpus_memo1 
	FROM data_linelinkage
	LEFT JOIN data_textlines as textlines1 ON textlines1.tl_id = data_linelinkage.ll_tl_id1
;
CREATE INDEX `idx_temp_linelinkage1_textlines_int_id`  ON `temp_linelinkage1_textlines` (int_id_1);

-- ll id 1 - textlines [ NOT IN ll ] 
DROP TABLE IF EXISTS temp_linelinkage1_textlines_nitl;
CREATE TABLE temp_linelinkage1_textlines_nitl AS
	SELECT
		ll_tl_id1, ll_tl_id2, ll_sim, ll_diff, ll_sim_wd, ll_diff_wd, ll_type, data_linelinkage.ll_t_id1, data_linelinkage.ll_t_id2, ll_tl_lnr1, ll_tl_lnr2, ll_minmaj_code, ll_minmaj_coder, ll_minmaj_memo, ll_linkage_coder, int_dupdate_linelinkage, int_id_linelinkage as int_id_1,
		textlines1.tl_id as tl_id1 , textlines1.tl_t_id as tl_t_id1 , textlines1.tl_lnr as tl_lnr1 , textlines1.tl_relevant as tl_relevant1 , textlines1.tl_corpus_code as tl_corpus_code1 , textlines1.tl_text as tl_text1 , textlines1.tl_wds_raw as tl_wds_raw1 , textlines1.tl_wds_clean as tl_wds_clean1 , textlines1.tl_corpus_memo as tl_corpus_memo1 
	FROM data_linelinkage
	RIGHT JOIN data_textlines as textlines1 ON textlines1.tl_id = data_linelinkage.ll_tl_id1
	WHERE ll_tl_id1 IS NULL
;





-- ids in ll
DROP TABLE IF EXISTS temp_linelinkage2_textlines;
CREATE TABLE temp_linelinkage2_textlines AS
	SELECT
		int_id_linelinkage as int_id_2,
		textlines2.tl_id as tl_id2 , textlines2.tl_t_id as tl_t_id2 , textlines2.tl_lnr as tl_lnr2 , textlines2.tl_relevant as tl_relevant2 , textlines2.tl_corpus_code as tl_corpus_code2 , textlines2.tl_text as tl_text2 , textlines2.tl_wds_raw as tl_wds_raw2 , textlines2.tl_wds_clean as tl_wds_clean2 , textlines2.tl_corpus_memo as tl_corpus_memo2 
	FROM data_linelinkage
	LEFT JOIN data_textlines as textlines2 ON textlines2.tl_id = data_linelinkage.ll_tl_id2
;
CREATE INDEX `idx_temp_linelinkage2_textlines_int_id`  ON `temp_linelinkage2_textlines` (int_id_2);


-- ids not in ll 
DROP TABLE IF EXISTS temp_linelinkage2_textlines_nitl;
CREATE TABLE temp_linelinkage2_textlines_nitl AS
	SELECT
		int_id_linelinkage as int_id_2,
		textlines2.tl_id as tl_id2 , textlines2.tl_t_id as tl_t_id2 , textlines2.tl_lnr as tl_lnr2 , textlines2.tl_relevant as tl_relevant2 , textlines2.tl_corpus_code as tl_corpus_code2 , textlines2.tl_text as tl_text2 , textlines2.tl_wds_raw as tl_wds_raw2 , textlines2.tl_wds_clean as tl_wds_clean2 , textlines2.tl_corpus_memo as tl_corpus_memo2 
	FROM data_linelinkage
	RIGHT JOIN data_textlines as textlines2 ON textlines2.tl_id = data_linelinkage.ll_tl_id2
	WHERE ll_tl_id2 IS NULL
;


-- putting ll_id_tl and ll_id2_tl together
DROP TABLE IF EXISTS temp_linelinkage_textlines;
CREATE TABLE temp_linelinkage_textlines 
AS SELECT * FROM    temp_linelinkage1_textlines AS A
			LEFT JOIN    temp_linelinkage2_textlines AS B 
			ON A.int_id_1 = B.int_id_2
;

-- adding not relevant lines to data
INSERT INTO temp_linelinkage_textlines (ll_tl_id1, ll_tl_id2, ll_sim, ll_diff, ll_sim_wd, ll_diff_wd, ll_type, ll_t_id1, ll_t_id2, ll_tl_lnr1, ll_tl_lnr2, ll_minmaj_code, ll_minmaj_coder, ll_minmaj_memo, ll_linkage_coder, int_dupdate_linelinkage, int_id_1, tl_id1, tl_t_id1, tl_lnr1, tl_relevant1, tl_corpus_code1, tl_text1, tl_wds_raw1, tl_wds_clean1, tl_corpus_memo1, int_id_2, tl_id2, tl_t_id2, tl_lnr2, tl_relevant2, tl_corpus_code2, tl_text2, tl_wds_raw2, tl_wds_clean2, tl_corpus_memo2)
	SELECT tl_id1 AS ll_tl_id1, 		concat(tl_t_id1, '_____') AS ll_tl_id2, 		NULL AS ll_sim, 		NULL AS ll_diff, 		NULL AS ll_sim_wd, 		NULL AS ll_diff_wd, 		'not_relevant' AS ll_type, 		tl_t_id1 AS ll_t_id1, 		NULL AS ll_t_id2, 		tl_lnr1 AS ll_tl_lnr1, 		NULL AS ll_tl_lnr2, 		NULL AS ll_minmaj_code, 		NULL AS ll_minmaj_coder, 		NULL AS ll_minmaj_memo, 		NULL AS ll_linkage_coder, 		NULL AS int_dupdate_linelinkage, 		0 AS int_id_1, 		tl_id1, 		tl_t_id1, 		tl_lnr1, 		tl_relevant1, 		tl_corpus_code1, 		tl_text1, 		tl_wds_raw1, 		tl_wds_clean1, 		tl_corpus_memo1, 		0 AS int_id_2, 		NULL AS tl_id2, 		NULL AS tl_t_id2, 		NULL AS tl_lnr2, 		NULL AS tl_relevant2, 		NULL AS tl_corpus_code2, 		NULL AS tl_text2, 		NULL AS tl_wds_raw2, 		NULL AS tl_wds_clean2, 		NULL AS tl_corpus_memo2
	FROM temp_linelinkage1_textlines_nitl 
;
INSERT INTO temp_linelinkage_textlines (ll_tl_id1, ll_tl_id2, ll_sim, ll_diff, ll_sim_wd, ll_diff_wd, ll_type, ll_t_id1, ll_t_id2, ll_tl_lnr1, ll_tl_lnr2, ll_minmaj_code, ll_minmaj_coder, ll_minmaj_memo, ll_linkage_coder, int_dupdate_linelinkage, int_id_1, tl_id1, tl_t_id1, tl_lnr1, tl_relevant1, tl_corpus_code1, tl_text1, tl_wds_raw1, tl_wds_clean1, tl_corpus_memo1, int_id_2, tl_id2, tl_t_id2, tl_lnr2, tl_relevant2, tl_corpus_code2, tl_text2, tl_wds_raw2, tl_wds_clean2, tl_corpus_memo2)
	SELECT concat(tl_t_id2, '_____') AS ll_tl_id1, 		tl_id2 AS ll_tl_id2, 		NULL AS ll_sim, 		NULL AS ll_diff, 		NULL AS ll_sim_wd, 		NULL AS ll_diff_wd, 		'not-relevant' AS ll_type, 		NULL AS ll_t_id1, 		tl_t_id2 AS ll_t_id2, 		NULL AS ll_tl_lnr1, 		tl_lnr2 AS ll_tl_lnr2, 		NULL AS ll_minmaj_code, 		NULL AS ll_minmaj_coder, 		NULL AS ll_minmaj_memo, 		NULL AS ll_linkage_coder, 		NULL AS int_dupdate_linelinkage, 		0 AS int_id_1, 		NULL AS tl_id1, 		NULL AS tl_t_id1, 		NULL AS tl_lnr1, 		NULL AS tl_relevant1, 		NULL AS tl_corpus_code1, 		NULL AS tl_text1, 		NULL AS tl_wds_raw1, 		NULL AS tl_wds_clean1, 		NULL AS tl_corpus_memo1, 		0 AS int_id_2, 		tl_id2, 		tl_t_id2, 		tl_lnr2, 		tl_relevant2, 		tl_corpus_code2, 		tl_text2, 		tl_wds_raw2, 		tl_wds_clean2, 		tl_corpus_memo2
	FROM temp_linelinkage2_textlines_nitl 
;

-- indexing for faster usage
CREATE INDEX `idx_temp_linelinkage_textlines_ll_t_id1`  ON `web234_db3`.`temp_linelinkage_textlines` (ll_t_id1) COMMENT '';
CREATE INDEX `idx_temp_linelinkage_textlines_ll_t_id2`  ON `web234_db3`.`temp_linelinkage_textlines` (ll_t_id2) COMMENT '';


-- adding info from texts 
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

-- indexing for faster usage
CREATE INDEX `idx_temp_linelinkage_text_ll_t_id1`  ON `web234_db3`.`temp_linelinkage_textlines_texts` (ll_t_id1) COMMENT '';
CREATE INDEX `idx_temp_linelinkage_text_ll_t_id2`  ON `web234_db3`.`temp_linelinkage_textlines_texts` (ll_t_id2) COMMENT '';



-- adding text information for last versions of country to id1 (that are otherwise excluded because of not having linkage)
DROP TABLE IF EXISTS temp_min_tl_t_id1 ;
CREATE TABLE temp_min_tl_t_id1 AS 
  SELECT MIN(tl_t_id1) AS mins FROM temp_linelinkage_textlines_texts WHERE tl_t_id1 IS NOT NULL GROUP BY t_country1 ;

DROP TABLE IF EXISTS temp_insert_into_temp_linelinkage_textlines_texts_1;
CREATE TABLE temp_insert_into_temp_linelinkage_textlines_texts_1 AS 
    SELECT DISTINCT ll_tl_id1 AS ll_tl_id2, ll_t_id1 AS ll_t_id2, ll_tl_lnr1 AS ll_tl_lnr2, int_dupdate_linelinkage AS int_dupdate_linelinkage, int_id_1 AS int_id_2, tl_id1 AS tl_id2, tl_t_id1 AS tl_t_id2, tl_lnr1 AS tl_lnr2, tl_relevant1 AS tl_relevant2, tl_corpus_code1 AS tl_corpus_code2, tl_text1 AS tl_text2, tl_wds_raw1 AS tl_wds_raw2, tl_wds_clean1 AS tl_wds_clean2, tl_corpus_memo1 AS tl_corpus_memo2, 0 AS int_id_1, t_t_id1 AS t_t_id2, t_date1 AS t_date2, t_dplus1 AS t_dplus2, t_country1 AS t_country2, t_daccept1 AS t_daccept2, t_dpromul1 AS t_dpromul2, t_denact1 AS t_denact2 
      FROM temp_linelinkage_textlines_texts
      WHERE ll_t_id1 IN ( SELECT * FROM temp_min_tl_t_id1 ) 
  ;

INSERT INTO temp_linelinkage_textlines_texts (ll_tl_id2, ll_t_id2, ll_tl_lnr2, int_dupdate_linelinkage, int_id_2, tl_id2, tl_t_id2, tl_lnr2, tl_relevant2, tl_corpus_code2, tl_text2, tl_wds_raw2, tl_wds_clean2, tl_corpus_memo2, int_id_1, t_t_id2, t_date2, t_dplus2, t_country2, t_daccept2, t_dpromul2, t_denact2) 
    SELECT * FROM temp_insert_into_temp_linelinkage_textlines_texts_1
  ;


-- adding text information for first versions of country to id2 (that are otherwise excluded because of not having linkage)
DROP TABLE IF EXISTS temp_min_tl_t_id2;
CREATE TABLE temp_min_tl_t_id2 AS 
  SELECT MAX(tl_t_id2) as maxs FROM temp_linelinkage_textlines_texts GROUP BY t_country2 ;

DROP TABLE IF EXISTS temp_insert_into_temp_linelinkage_textlines_texts_2;
CREATE TABLE temp_insert_into_temp_linelinkage_textlines_texts_2 AS 
SELECT DISTINCT ll_tl_id2 AS ll_tl_id1, ll_t_id2 AS ll_t_id1, ll_tl_lnr2 AS ll_tl_lnr1, int_dupdate_linelinkage AS int_dupdate_linelinkage, int_id_2 AS int_id_1, tl_id2 AS tl_id1, tl_t_id2 AS tl_t_id1, tl_lnr2 AS tl_lnr1, tl_relevant2 AS tl_relevant1, tl_corpus_code2 AS tl_corpus_code1, tl_text2 AS tl_text1, tl_wds_raw2 AS tl_wds_raw1, tl_wds_clean2 AS tl_wds_clean1, tl_corpus_memo2 AS tl_corpus_memo1, 0 AS int_id_2, t_t_id2 AS t_t_id1, t_date2 AS t_date1, t_dplus2 AS t_dplus1, t_country2 AS t_country1, t_daccept2 AS t_daccept1, t_dpromul2 AS t_dpromul1, t_denact2 AS t_denact1 
		FROM temp_linelinkage_textlines_texts
    WHERE ll_t_id2 IN ( SELECT * FROM temp_min_tl_t_id2 ) 
  ;

INSERT INTO temp_linelinkage_textlines_texts (ll_tl_id1, ll_t_id1, ll_tl_lnr1, int_dupdate_linelinkage, int_id_1, tl_id1, tl_t_id1, tl_lnr1, tl_relevant1, tl_corpus_code1, tl_text1, tl_wds_raw1, tl_wds_clean1, tl_corpus_memo1, int_id_2, t_t_id1, t_date1, t_dplus1, t_country1, t_daccept1, t_dpromul1, t_denact1 )
    SELECT * FROM temp_insert_into_temp_linelinkage_textlines_texts_2
  ;
  
  
  

-- SELECT * FROM temp_linelinkage_textlines_texts ; 
-- SELECT COUNT(*) FROM temp_linelinkage_textlines_texts WHERE ll_type='no-change'; 
-- SELECT COUNT(*) FROM temp_linelinkage_textlines_texts WHERE ll_type='deletion'; 
-- SELECT COUNT(*) FROM temp_linelinkage_textlines_texts WHERE ll_type='insertion'; 
-- SELECT COUNT(*) FROM temp_linelinkage_textlines_texts WHERE ll_type='change'; 
-- -----------------------------------------------------------------------------------------------------------------------------------------------





-- dropping all temp_... tables except : temp_linelinkage_textlines_texts
-- http://stackoverflow.com/a/18625545/1144966
show tables WHERE 
  Tables_in_web234_db3     LIKE "temp_%" AND 
  Tables_in_web234_db3 NOT LIKE "temp_linelinkage_textlines_texts"; 

SET FOREIGN_KEY_CHECKS = 0;  
SET GROUP_CONCAT_MAX_LEN=32768;
SET @tables = NULL; 
SELECT GROUP_CONCAT('`', TABLE_NAME, '`' ) INTO @tables
  FROM information_schema.tables 
  WHERE 
    TABLE_NAME     LIKE "temp_%" AND 
    TABLE_NAME NOT LIKE "temp_linelinkage_textlines_texts" AND
    TABLE_SCHEMA      = "web234_db3"; 
SELECT IFNULL(@tables, 'dummy') INTO @tables;
SET @tables = CONCAT('DROP TABLE IF EXISTS ', @tables);
PREPARE stmt FROM @tables;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
SET FOREIGN_KEY_CHECKS = 1;

-- -----------------------------------------------------------------------------------------------------------------------------------------------





