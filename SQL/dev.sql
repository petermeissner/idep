-- linelinkage joined with textlines on id1
DROP TABLE IF EXISTS temp_linelinkage1_textlines ; 
CREATE TABLE temp_linelinkage1_textlines AS 
		SELECT
			ll_tl_id1, ll_tl_id2, ll_sim, ll_diff, ll_sim_wd, ll_diff_wd, ll_type, data_linelinkage.ll_t_id1, data_linelinkage.ll_t_id2, ll_tl_lnr1, ll_tl_lnr2, ll_minmaj_code, ll_minmaj_coder, ll_minmaj_memo, ll_linkage_coder, int_dupdate_linelinkage, int_id_linelinkage,
			textlines1.tl_id as tl_id1 , textlines1.tl_t_id as tl_t_id1 , textlines1.tl_lnr as tl_lnr1 , textlines1.tl_relevant as tl_relevant1 , textlines1.tl_corpus_code as tl_corpus_code1 , textlines1.tl_text as tl_text1 , textlines1.tl_wds_raw as tl_wds_raw1 , textlines1.tl_wds_clean as tl_wds_clean1 , textlines1.tl_corpus_memo as tl_corpus_memo1 
		FROM data_linelinkage
		RIGHT JOIN data_textlines as textlines1 ON textlines1.tl_id = data_linelinkage.ll_tl_id1
;
SELECT * FROM temp_linelinkage1_textlines  ; 
SELECT * FROM temp_linelinkage1_textlines where ll_type ='deletion' ; 



-- linelinkage joined with textlines on id2
DROP TABLE IF EXISTS temp_linelinkage2_textlines ; 
CREATE TABLE temp_linelinkage2_textlines AS 
	SELECT
		ll_tl_id1, ll_tl_id2, ll_sim, ll_diff, ll_sim_wd, ll_diff_wd, ll_type, data_linelinkage.ll_t_id1, data_linelinkage.ll_t_id2, ll_tl_lnr1, ll_tl_lnr2, ll_minmaj_code, ll_minmaj_coder, ll_minmaj_memo, ll_linkage_coder, int_dupdate_linelinkage, int_id_linelinkage,
		textlines2.tl_id as tl_id2 , textlines2.tl_t_id as tl_t_id2 , textlines2.tl_lnr as tl_lnr2 , textlines2.tl_relevant as tl_relevant2 , textlines2.tl_corpus_code as tl_corpus_code2 , textlines2.tl_text as tl_text2 , textlines2.tl_wds_raw as tl_wds_raw2 , textlines2.tl_wds_clean as tl_wds_clean2 , textlines2.tl_corpus_memo as tl_corpus_memo2 
	FROM data_linelinkage
	LEFT JOIN data_textlines as textlines2 ON textlines2.tl_id = data_linelinkage.ll_tl_id2
;
SELECT * FROM temp_linelinkage2_textlines ; 



