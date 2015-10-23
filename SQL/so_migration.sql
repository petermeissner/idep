-- ----------------------------------------------------------------------------
-- MySQL Workbench Migration
-- Migrated Schemata: web234_db3
-- Source Schemata: web234_db3
-- Created: Fri May 29 11:53:49 2015
-- Workbench Version: 6.3.2
-- ----------------------------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;;

-- ----------------------------------------------------------------------------
-- Schema web234_db3
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS `web234_db3` ;
CREATE SCHEMA IF NOT EXISTS `web234_db3` ;

-- ----------------------------------------------------------------------------
-- Table web234_db3.data_linelinkage
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `web234_db3`.`data_linelinkage` (
  `ll_tl_id1` VARCHAR(30) NOT NULL DEFAULT '',
  `ll_tl_id2` VARCHAR(30) NOT NULL DEFAULT '',
  `ll_sim` FLOAT NULL DEFAULT NULL,
  `ll_diff` FLOAT NULL DEFAULT NULL,
  `ll_sim_wd` INT(11) NULL DEFAULT NULL,
  `ll_diff_wd` INT(11) NULL DEFAULT NULL,
  `ll_type` VARCHAR(30) NOT NULL DEFAULT '',
  `ll_t_id1` VARCHAR(30) NULL DEFAULT NULL,
  `ll_t_id2` VARCHAR(30) NULL DEFAULT NULL,
  `ll_tl_lnr1` INT(11) NULL DEFAULT NULL,
  `ll_tl_lnr2` INT(11) NULL DEFAULT NULL,
  `ll_minmaj_code` INT(11) NULL DEFAULT NULL,
  `ll_minmaj_coder` VARCHAR(200) NULL DEFAULT NULL,
  `ll_minmaj_memo` LONGTEXT NULL DEFAULT NULL,
  `ll_linkage_coder` VARCHAR(200) NULL DEFAULT NULL,
  `int_dupdate_linelinkage` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `int_id_linelinkage` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`ll_tl_id1`, `ll_tl_id2`, `ll_type`),
  INDEX `idx_ll_id1` (`ll_tl_id1` ASC),
  INDEX `idx_ll_id2` (`ll_tl_id2` ASC),
  INDEX `idx_data_linelinkage_int_id_linelinkage` (`int_id_linelinkage` ASC),
  INDEX `idx_t_id1` (`ll_t_id1` ASC),
  INDEX `idx_t_id2` (`ll_t_id2` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 371338
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table web234_db3.data_textlines
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `web234_db3`.`data_textlines` (
  `tl_id` VARCHAR(30) NOT NULL DEFAULT '',
  `tl_t_id` VARCHAR(30) NULL DEFAULT NULL,
  `tl_lnr` INT(11) NULL DEFAULT NULL,
  `tl_relevant` INT(11) NULL DEFAULT NULL,
  `tl_corpus_code` INT(11) NULL DEFAULT NULL,
  `tl_text` LONGTEXT NULL DEFAULT NULL,
  `tl_wds_raw` INT(11) NULL DEFAULT NULL,
  `tl_wds_clean` INT(11) NULL DEFAULT NULL,
  `tl_corpus_memo` LONGTEXT NULL DEFAULT NULL,
  `int_dupdate_textlines` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `int_id_textlines` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`tl_id`),
  UNIQUE INDEX `int_id_textlines_UNIQUE` (`int_id_textlines` ASC),
  INDEX `indexkey` (`int_id_textlines` ASC),
  INDEX `idx_tl_t_id` (`tl_t_id` ASC),
  INDEX `idx_tl_id` (`tl_id` ASC),
  INDEX `idx_tl_corpus_code` (`tl_corpus_code` ASC),
  INDEX `idx_tl_relevant` (`tl_relevant` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 528003
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table web234_db3.data_texts
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `web234_db3`.`data_texts` (
  `t_id` VARCHAR(30) NOT NULL DEFAULT '',
  `t_date` DATE NULL DEFAULT NULL,
  `t_dplus` INT(11) NULL DEFAULT NULL,
  `t_country` VARCHAR(10) NULL DEFAULT NULL,
  `t_daccept` DATE NULL DEFAULT NULL,
  `t_dpromul` DATE NULL DEFAULT NULL,
  `t_denact` DATE NULL DEFAULT NULL,
  `int_dupdate_texts` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `int_id_texts` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`t_id`),
  UNIQUE INDEX `int_id_texts_UNIQUE` (`int_id_texts` ASC),
  INDEX `idkey` (`int_id_texts` ASC),
  INDEX `idx_t_id` (`t_id` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 787
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table web234_db3.metachange
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `web234_db3`.`metachange` (
  `ts1` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ts2` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ctr` VARCHAR(10) NOT NULL DEFAULT '',
  `time.1` VARCHAR(100) NULL DEFAULT NULL,
  `time.2` VARCHAR(100) NULL DEFAULT NULL,
  `y.1` INT(11) NULL DEFAULT NULL,
  `y.2` INT(11) NULL DEFAULT NULL,
  `m.1` INT(11) NULL DEFAULT NULL,
  `m.2` INT(11) NULL DEFAULT NULL,
  `d.1` INT(11) NULL DEFAULT NULL,
  `d.2` INT(11) NULL DEFAULT NULL,
  `tx.1` INT(11) NULL DEFAULT NULL,
  `tx.2` INT(11) NULL DEFAULT NULL,
  `lengthwd.1` INT(11) NULL DEFAULT NULL,
  `lengthwd.2` INT(11) NULL DEFAULT NULL,
  `delwd` INT(11) NULL DEFAULT NULL,
  `inswd` INT(11) NULL DEFAULT NULL,
  `chngwd` INT(11) NULL DEFAULT NULL,
  `unchngwd` INT(11) NULL DEFAULT NULL,
  `allwd` INT(11) NULL DEFAULT NULL,
  `promin` INT(11) NULL DEFAULT NULL,
  `promaj` INT(11) NULL DEFAULT NULL,
  `pronone` INT(11) NULL DEFAULT NULL,
  `prodontknow` INT(11) NULL DEFAULT NULL,
  `file` VARCHAR(1000) NULL DEFAULT NULL,
  `cntrID` VARCHAR(10) NULL DEFAULT NULL,
  `date` VARCHAR(100) NULL DEFAULT NULL,
  `estlwd1` INT(11) NULL DEFAULT NULL,
  `estlwd2` INT(11) NULL DEFAULT NULL,
  `estdelwd` INT(11) NULL DEFAULT NULL,
  `estinswd` INT(11) NULL DEFAULT NULL,
  `estchngwd` INT(11) NULL DEFAULT NULL,
  `estallwd` INT(11) NULL DEFAULT NULL,
  `intdatupdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `prominwords` INT(11) NULL DEFAULT NULL,
  `promajwords` INT(11) NULL DEFAULT NULL,
  `agendacontrol` FLOAT NULL DEFAULT NULL,
  `prononewords` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`ts1`, `ts2`, `ctr`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table web234_db3.sources
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `web234_db3`.`sources` (
  `name` VARCHAR(100) NOT NULL DEFAULT '',
  `type` VARCHAR(100) NULL DEFAULT NULL,
  `iskey` VARCHAR(100) NULL DEFAULT NULL,
  `def` VARCHAR(100) NULL DEFAULT NULL,
  `extra` VARCHAR(100) NULL DEFAULT NULL,
  `empty` VARCHAR(100) NULL DEFAULT NULL,
  `tablename` VARCHAR(100) NOT NULL DEFAULT '',
  `description` VARCHAR(1000) NULL DEFAULT NULL,
  `external` INT(1) NULL DEFAULT NULL,
  `source` VARCHAR(1000) NULL DEFAULT NULL,
  `deleted` INT(1) NULL DEFAULT NULL,
  `intdatupdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`name`, `tablename`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table web234_db3.tsebelis
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `web234_db3`.`tsebelis` (
  `row_names` TEXT NULL DEFAULT NULL,
  `country` TEXT NULL DEFAULT NULL,
  `land` TEXT NULL DEFAULT NULL,
  `cntrshort` TEXT NULL DEFAULT NULL,
  `plenary_agenda` BIGINT(20) NULL DEFAULT NULL,
  `financial_initiative` BIGINT(20) NULL DEFAULT NULL,
  `committee` BIGINT(20) NULL DEFAULT NULL,
  `rewrite` BIGINT(20) NULL DEFAULT NULL,
  `timetable` BIGINT(20) NULL DEFAULT NULL,
  `financial_voting` BIGINT(20) NULL DEFAULT NULL,
  `lapse_bill` BIGINT(20) NULL DEFAULT NULL,
  `agenda_control` TEXT NULL DEFAULT NULL,
  `government_duration_lijphart` TEXT NULL DEFAULT NULL,
  `executive_dominance_lijphart` TEXT NULL DEFAULT NULL)
ENGINE = MyISAM
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- Table web234_db3.version
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS `web234_db3`.`version` (
  `versionid` INT(11) NOT NULL AUTO_INCREMENT,
  `changedate` DATETIME NULL DEFAULT NULL,
  `versionnumber` VARCHAR(20) NULL DEFAULT NULL,
  `description` VARCHAR(1000) NULL DEFAULT NULL,
  `shortdesc` VARCHAR(200) NOT NULL,
  `hash` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`versionid`),
  UNIQUE INDEX `versionid_UNIQUE` (`versionid` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 140
DEFAULT CHARACTER SET = latin1;

-- ----------------------------------------------------------------------------
-- View web234_db3.view_last_update
-- ----------------------------------------------------------------------------
USE `web234_db3`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`web234_3`@`%` SQL SECURITY DEFINER VIEW `web234_db3`.`view_last_update` AS select `web234_db3`.`data_linelinkage`.`int_dupdate_linelinkage` AS `int_dupdate` from `web234_db3`.`data_linelinkage` union select `web234_db3`.`data_texts`.`int_dupdate_texts` AS `int_dupdate` from `web234_db3`.`data_texts` union select `web234_db3`.`data_textlines`.`int_dupdate_textlines` AS `int_dupdate` from `web234_db3`.`data_textlines`;
SET FOREIGN_KEY_CHECKS = 1;;
