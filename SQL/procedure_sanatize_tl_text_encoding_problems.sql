DROP PROCEDURE IF EXISTS sanatize_umlaut_in_tl_text ; 
delimiter #
CREATE PROCEDURE sanatize_umlaut_in_tl_text()
  BEGIN
	
    -- A-, O-, U-Umlaut, ß
    SET @numberofloops =  (
		SELECT count(*) from data_textlines 
			where 
				tl_text LIKE "%Ã¤%" OR 
				tl_text LIKE "%Ã„%" OR
				tl_text LIKE "%Ã¶%" OR 
				tl_text LIKE "%Ã–%" OR
				tl_text LIKE "%Ãœ%" OR
				tl_text LIKE "%Ã¼%" OR
				tl_text LIKE "%Â§%" OR
				tl_text LIKE "%ÂŸ%" 
	) ;
    SET @looper = 1;
    
     WHILE @looper <= @numberofloops  DO
		SET @id   = (
			SELECT tl_id from data_textlines 
				where 
					tl_text LIKE "%Ã¤%" OR 
                    tl_text LIKE "%Ã„%" OR
                    tl_text LIKE "%Ã¶%" OR 
					tl_text LIKE "%Ã–%" OR
					tl_text LIKE "%Ãœ%" OR
                    tl_text LIKE "%Ã¼%" OR
                    tl_text LIKE "%Â§%" OR
                    tl_text LIKE "%ÂŸ%" 
                    LIMIT 1
		);
	    SET @text = (SELECT convert(binary tl_text using utf8)  from data_textlines where tl_id = @id);
        UPDATE data_textlines SET tl_text = @text WHERE tl_id = @id;
		SET @looper = @looper + 1 ; 
	END WHILE ;
    
        -- more 1 
    SET @numberofloops =  (
		SELECT count(*) from data_textlines 
			where 
				tl_text LIKE "%Ã©%" OR
				tl_text LIKE "%Ã‰%" OR
				tl_text LIKE "%Ã¨%" OR
				tl_text LIKE "%Ãª%" OR
                tl_text LIKE "%Ãˆ%"
	) ;
    SET @looper = 1;
    
     WHILE @looper <= @numberofloops  DO
		SET @id   = (
			SELECT tl_id from data_textlines 
				where 
                tl_text LIKE "%Ã©%" OR
				tl_text LIKE "%Ã‰%" OR
				tl_text LIKE "%Ã¨%" OR
				tl_text LIKE "%Ãª%" OR
                tl_text LIKE "%Ãˆ%"
                    LIMIT 1
		);
	    SET @text = (SELECT convert(binary tl_text using utf8)  from data_textlines where tl_id = @id);
        UPDATE data_textlines SET tl_text = @text WHERE tl_id = @id;
		SET @looper = @looper + 1 ; 
	END WHILE ;
    
        -- more 2 
    SET @numberofloops =  ( SELECT count(*) from data_textlines where tl_text LIKE "%Å•%") ;
    SET @looper = 1;
    WHILE @looper <= @numberofloops  DO
     SET @id   = ( SELECT tl_id from data_textlines where tl_text LIKE "%Å•%" LIMIT 1) ;
	 SET @text = (SELECT convert(binary tl_text using utf8)  from data_textlines where tl_id = @id);
     UPDATE data_textlines SET tl_text = @text WHERE tl_id = @id;
	 SET @looper = @looper + 1 ; 
	END WHILE ;
    
            -- more 2 
    SET @numberofloops =  ( SELECT count(*) from data_textlines where tl_text LIKE "%Â°%") ;
    SET @looper = 1;
    WHILE @looper <= @numberofloops  DO
     SET @id   = ( SELECT tl_id from data_textlines where tl_text LIKE "%Â°%" LIMIT 1) ;
	 SET @text = (SELECT convert(binary tl_text using utf8)  from data_textlines where tl_id = @id);
     UPDATE data_textlines SET tl_text = @text WHERE tl_id = @id;
	 SET @looper = @looper + 1 ; 
	END WHILE ;
    
                -- more 2 
    SET @numberofloops =  ( SELECT count(*) from data_textlines where tl_text LIKE "%â€%") ;
    SET @looper = 1;
    WHILE @looper <= @numberofloops  DO
     SET @id   = ( SELECT tl_id from data_textlines where tl_text LIKE "%â€%" LIMIT 1) ;
	 SET @text = (SELECT convert(binary tl_text using utf8)  from data_textlines where tl_id = @id);
     UPDATE data_textlines SET tl_text = @text WHERE tl_id = @id;
	 SET @looper = @looper + 1 ; 
	END WHILE ;
    
                    -- more 2 
    SET @numberofloops =  ( SELECT count(*) from data_textlines where tl_text LIKE "%Ã”%") ;
    SET @looper = 1;
    WHILE @looper <= @numberofloops  DO
     SET @id   = ( SELECT tl_id from data_textlines where tl_text LIKE "%Ã”%" LIMIT 1) ;
	 SET @text = (SELECT convert(binary tl_text using utf8)  from data_textlines where tl_id = @id);
     UPDATE data_textlines SET tl_text = @text WHERE tl_id = @id;
	 SET @looper = @looper + 1 ; 
	END WHILE ;
    
                        -- more 2 
    SET @numberofloops =  ( SELECT count(*) from data_textlines where tl_text LIKE "%Ã´%") ;
    SET @looper = 1;
    WHILE @looper <= @numberofloops  DO
     SET @id   = ( SELECT tl_id from data_textlines where tl_text LIKE "%Ã´%" LIMIT 1) ;
	 SET @text = (SELECT convert(binary tl_text using utf8)  from data_textlines where tl_id = @id);
     UPDATE data_textlines SET tl_text = @text WHERE tl_id = @id;
	 SET @looper = @looper + 1 ; 
	END WHILE ;
    
                           -- more 2 
    SET @numberofloops =  ( SELECT count(*) from data_textlines where tl_text LIKE "%Ã  laquelle%") ;
    SET @looper = 1;
    WHILE @looper <= @numberofloops  DO
     SET @id   = ( SELECT tl_id from data_textlines where tl_text LIKE "%Ã  laquelle%" LIMIT 1) ;
	 SET @text = (SELECT convert(binary tl_text using utf8)  from data_textlines where tl_id = @id);
     UPDATE data_textlines SET tl_text = @text WHERE tl_id = @id;
	 SET @looper = @looper + 1 ; 
	END WHILE ;
    
  END #
delimiter ;



-- call sanatize_umlaut_in_tl_text();
-- SELECT tl_id, tl_text from data_textlines where tl_text like "%Â%"


-- SELECT * FROM 
-- 	(SELECT CONVERT(CONVERT(tl_text USING BINARY) USING latin1) AS latin1, 
-- 		   CONVERT(CONVERT(tl_text USING BINARY) USING utf8) AS utf8 
-- 	FROM data_textlines
-- 	WHERE 
-- 		CONVERT(tl_text USING BINARY) RLIKE CONCAT('[', UNHEX('80'), '-', UNHEX('FF'), ']') ) as dings 
-- WHERE utf8 is not null 	LIMIT 100000 
-- ;










