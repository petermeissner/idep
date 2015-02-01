
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



-- adding text information for first versions of country to id2 (that are otherwise excluded because of not having linkage)
INSERT INTO temp_linelinkage_textlines_texts (ll_tl_id1, ll_t_id1, ll_tl_lnr1, int_dupdate_linelinkage, int_id_1, tl_id1, tl_t_id1, tl_lnr1, tl_relevant1, tl_corpus_code1, tl_text1, tl_wds_raw1, tl_wds_clean1, tl_corpus_memo1, int_id_2, t_t_id1, t_date1, t_dplus1, t_country1, t_daccept1, t_dpromul1, t_denact1 )
	SELECT DISTINCT ll_tl_id2 AS ll_tl_id1, ll_t_id2 AS ll_t_id1, ll_tl_lnr2 AS ll_tl_lnr1, int_dupdate_linelinkage AS int_dupdate_linelinkage, int_id_2 AS int_id_1, tl_id2 AS tl_id1, tl_t_id2 AS tl_t_id1, tl_lnr2 AS tl_lnr1, tl_relevant2 AS tl_relevant1, tl_corpus_code2 AS tl_corpus_code1, tl_text2 AS tl_text1, tl_wds_raw2 AS tl_wds_raw1, tl_wds_clean2 AS tl_wds_clean1, tl_corpus_memo2 AS tl_corpus_memo1, 0 AS int_id_2, t_t_id2 AS t_t_id1, t_date2 AS t_date1, t_dplus2 AS t_dplus1, t_country2 AS t_country1, t_daccept2 AS t_daccept1, t_dpromul2 AS t_dpromul1, t_denact2 AS t_denact1 
		FROM temp_linelinkage_textlines_texts
		WHERE ll_t_id2 IN ( SELECT MAX(tl_t_id2) FROM temp_linelinkage_textlines_texts GROUP BY t_country2 ) 
;