DROP PROCEDURE IF EXISTS sanatize_missing_corpus_code ; 
delimiter #
CREATE PROCEDURE sanatize_missing_corpus_code()
  BEGIN

	UPDATE data_textlines set tl_corpus_code = 999 WHERE tl_corpus_code IS NULL AND tl_relevant = 0 ;     
    
    
  END #
delimiter ;


-- call sanatize_missing_corpus_code() ; 