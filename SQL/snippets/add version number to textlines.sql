-- SQL script for adding version number (n-th unique value of date) to texts

SELECT 0 INTO @x;
SELECT * from data_textlines 
	JOIN (
		SELECT t_id, COUNT(*) as ordercount, (@x:=@x+1) as rownumber FROM data_texts GROUP BY t_id
	) AS TEXTS 
	ON TEXTS.t_id = data_textlines.tl_t_id 
;

