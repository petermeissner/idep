-- corpus code missing in Norway
SELECT * FROM web234_db3.data_textlines WHERE tl_id LIKE "NOR_1972_10_10.0__%";

-- corpus code missing in NEtherlands
SELECT * FROM web234_db3.data_textlines WHERE tl_id LIKE "NED_1971_03_31.0__%";


-- N CorpusCode missing overall
SELECT count(*) FROM web234_db3.data_textlines WHERE tl_corpus_code IS NULL;
-- -> 502

-- Examples of CorpusCode missing
SELECT * FROM web234_db3.data_textlines WHERE tl_corpus_code IS NULL ORDER BY RAND() LIMIT 100;


