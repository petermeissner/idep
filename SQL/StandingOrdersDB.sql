create table version (
versionid integer  auto_increment not null ,
changedate datetime,
versionnumber varchar(20),
description varchar(1000),
primary key (versionid)
) ;

-- create table countries (
-- 
-- )

create table metachange (
	ts1 datetime ,
	ts2 datetime ,
	ctr varchar(10),
	`time.1` varchar(100),
	`time.2` varchar(100),
	`y.1` integer,
	`y.2` integer,
	`m.1` integer,
	`m.2` integer,
	`d.1` integer,
	`d.2` integer,
	`tx.1` integer,
	`tx.2` integer,
	`lengthwd.1` integer,
	`lengthwd.2` integer,
	delwd integer,
	inswd integer,
	chngwd integer,
	unchngwd integer,
	allwd integer,
	promin integer,
	promaj integer,
	pronone integer,
	prodontknow integer,
	file varchar(1000),
	cntrID varchar(10),
	`date` varchar(100),
	estlwd1 integer,
	estlwd2 integer,
	estdelwd integer,
	estinswd integer,
	estchngwd integer,
	estallwd integer,
intdatupdate timestamp DEFAULT NOW() ON UPDATE NOW(),
primary key (ts1,ts2,ctr)
) engine=innodb;


CREATE TABLE sources  (
    name                 VARCHAR(100),
    type                 VARCHAR(100),
    tablename            VARCHAR(100),
    description          VARCHAR(1000),
    external             INTEGER(1),
    source               VARCHAR(1000),
	deleted				 INTEGER(1),
    intdatupdate TIMESTAMP DEFAULT NOW() ON UPDATE NOW(),
	Primary KEY (name, type, tabellenname)
) ENGINE = InnoDB;


-- ----------------------------------------------
-- ----------------------------------------------

CREATE TABLE data_texts  (
	t_id  			varchar(30),
    t_date			date,
    t_dplus     	integer,
    t_country   	varchar(10),
    t_daccept   	date,
    t_dpromul   	date,
    t_denact    	date,
	int_dupdate_texts TIMESTAMP DEFAULT NOW() ON UPDATE NOW(),
	Primary KEY (t_id)
) ENGINE = InnoDB;

CREATE INDEX idx_t_id
    ON data_texts (t_id) ;


CREATE TABLE data_textlines  (
	tl_id			varchar(30),
	tl_t_id     	varchar(30),
    tl_lnr      	integer,
	tl_relevant 	integer,
    tl_corpus_code 	integer,
	tl_text			longtext,
    tl_wds_raw      integer,
    tl_wds_clean    integer,
	tl_corpus_memo  longtext,
	int_dupdate_textlines TIMESTAMP DEFAULT NOW() ON UPDATE NOW(),
	Primary KEY (tl_id)
) ENGINE = InnoDB;

CREATE INDEX idx_tl_id
    ON data_textlines (tl_id) ;
CREATE INDEX idx_tl_t_id
    ON data_textlines (tl_t_id) ;
CREATE INDEX idx_tl_corpus_code
    ON data_textlines (tl_corpus_code) ;
CREATE INDEX idx_tl_relevant
    ON data_textlines (tl_relevant) ;


CREATE TABLE data_linelinkage  (
	ll_tl_id1 				varchar(30),
    ll_tl_id2 				varchar(30),
    ll_sim  			float,
    ll_diff 			float,
    ll_sim_wd 			integer,
    ll_diff_wd 			integer,
    ll_type 			varchar(30),
    ll_minmaj 			integer,
    ll_t_id1 			varchar(30),
	ll_t_id2 			varchar(30),
    ll_tl_lnr1 			integer, 
	ll_tl_lnr2 			integer,
	ll_minmaj_code    	integer,
    ll_minmaj_coder     varchar(200),
    ll_minmaj_memo      longtext,
    ll_linkage_coder    varchar(200),
	Primary KEY (ll_tl_id1, ll_tl_id2, ll_type),
	int_dupdate_linelinkage TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
) ENGINE = InnoDB;

CREATE INDEX idx_ll_id1
    ON data_linelinkage (ll_tl_id1) ;
CREATE INDEX idx_ll_id2
    ON data_linelinkage (ll_tl_id2) ;
CREATE INDEX idx_t_id1
    ON data_linelinkage (ll_t_id1) ;
CREATE INDEX idx_t_id2
    ON data_linelinkage (ll_t_id2) ;
CREATE INDEX `idx_data_linelinkage_int_id_linelinkage`  ON `data_linelinkage` (int_id_linelinkage) ;
