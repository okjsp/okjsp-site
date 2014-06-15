GRANT ALL PRIVILEGES ON *.* TO kenu@localhost
IDENTIFIED BY 'okpass' WITH GRANT OPTION;

use test;
/* 
SQLyog v4.0
Host - okjsp.pe.kr : Database - db_kenu
**************************************************************
Server version 4.0.20-max
*/

create database if not exists test;

use test;

/*
Table structure for kcount
*/

CREATE TABLE kcount (
  idx int(11) NOT NULL auto_increment,
  cdate int(11) default NULL,
  ctime int(11) default NULL,
  dayofweek int(11) default NULL,
  ip varchar(20) default NULL,
  referer varchar(200) default NULL,
  browser varchar(20) default NULL,
  os varchar(20) default NULL,
  PRIMARY KEY  (idx),
  KEY kcount_cdate_indx (cdate,idx),
  KEY kcount_dayofweek_indx (dayofweek)
) TYPE=MyISAM;

/*
Table structure for okboard
*/

CREATE TABLE okboard (
  BBSID varchar(50) default NULL,
  SEQ int(11) NOT NULL default '0',
  REF int(11) default NULL,
  STEP tinyint(4) default NULL,
  LEV tinyint(4) default NULL,
  WRITER varchar(50) default NULL,
  SUBJECT varchar(255) default NULL,
  PASSWORD varchar(50) default NULL,
  EMAIL varchar(50) default NULL,
  HIT int(11) default NULL,
  HTML char(1) default NULL,
  HOMEPAGE varchar(255) default NULL,
  STS tinyint(4) default '1',
  WTIME datetime default NULL,
  IP varchar(50) default NULL,
  MEMO int(4) default NULL,
  CONTENT mediumtext,
  PRIMARY KEY  (SEQ),
  KEY okboard_bbsid_idx (BBSID),
  KEY okboard_ref_idx (REF)
) TYPE=MyISAM;

/*
Table structure for okboard_bookmark
*/

CREATE TABLE okboard_bookmark (
  id varchar(20) NOT NULL default '',
  seq int(11) NOT NULL default '0',
  credate datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (id,seq),
  KEY okboard_bookmark_id_idx (id)
) TYPE=MyISAM;

/*
Table structure for okboard_category
*/

CREATE TABLE okboard_category (
  seq int(11) NOT NULL auto_increment,
  category varchar(30) NOT NULL default '',
  PRIMARY KEY  (seq),
  UNIQUE KEY seq (seq),
  KEY seq_2 (seq)
) TYPE=MyISAM COMMENT='게시판 카테고리';

/*
Table structure for okboard_deleted
*/

CREATE TABLE okboard_deleted (
  BBSID varchar(50) default NULL,
  SEQ int(11) NOT NULL default '0',
  REF int(11) NOT NULL default '0',
  STEP int(11) NOT NULL default '0',
  LEV int(11) NOT NULL default '0',
  WRITER varchar(50) default NULL,
  SUBJECT varchar(255) default NULL,
  PASSWORD varchar(50) default NULL,
  EMAIL varchar(50) default NULL,
  HIT int(11) default NULL,
  HTML char(1) default NULL,
  HOMEPAGE varchar(255) default NULL,
  STS int(1) default '1',
  WTIME datetime default NULL,
  IP varchar(50) default NULL,
  MEMO int(11) default NULL,
  CONTENT text,
  PRIMARY KEY  (SEQ)
) TYPE=MyISAM;

/*
Table structure for okboard_file
*/

CREATE TABLE okboard_file (
  FSEQ int(11) NOT NULL default '0',
  SEQ int(11) NOT NULL default '0',
  FILENAME varchar(200) NOT NULL default '',
  MASKNAME varchar(30) NOT NULL default '',
  FILESIZE int(11) NOT NULL default '0',
  DOWNLOAD int(11) NOT NULL default '0',
  sts int(1) NOT NULL default '1',
  PRIMARY KEY  (FSEQ),
  UNIQUE KEY FSEQ (FSEQ)
) TYPE=MyISAM COMMENT='게시물 첨부파일';

/*
Table structure for okboard_info
*/

CREATE TABLE okboard_info (
  cseq int(11) NOT NULL default '0',
  bbsid varchar(20) NOT NULL default '',
  name varchar(30) NOT NULL default '',
  header varchar(200) default NULL,
  PRIMARY KEY  (bbsid)
) TYPE=MyISAM COMMENT='테이블정보';

/*
Table structure for okboard_info_role
*/

CREATE TABLE okboard_info_role (
  bbsid varchar(20) NOT NULL default '',
  role varchar(20) NOT NULL default '',
  PRIMARY KEY  (bbsid,role)
) TYPE=MyISAM;

/*
Table structure for okboard_memo
*/

CREATE TABLE okboard_memo (
  MSEQ int(11) NOT NULL default '0',
  SEQ int(11) NOT NULL default '0',
  WRITER varchar(50) default NULL,
  BCOMMENT text,
  WTIME datetime default NULL,
  MEMOPASS varchar(20) default NULL,
  IP varchar(16) default NULL,
  PRIMARY KEY  (MSEQ),
  UNIQUE KEY MSEQ (MSEQ),
  KEY memo_seq_idx (SEQ)
) TYPE=MyISAM COMMENT='게시물 메모';

/*
Table structure for okmember
*/

CREATE TABLE `okmember` (                                      
`id` varchar(20) NOT NULL default '',                        
`password` varchar(20) NOT NULL default '',                  
`name` varchar(20) NOT NULL default '',                      
`email` varchar(50) default NULL,                            
`joindate` datetime NOT NULL default '0000-00-00 00:00:00',  
`homepage` varchar(50) default NULL,                         
`contact` varchar(20) default NULL,                          
`profile` char(1) default NULL,                              
`mailing` char(1) default 'N',                               
`point` int(10) unsigned NOT NULL default '0',               
UNIQUE KEY `id` (`id`)                                       
) COMMENT='사용자'


/*
Table structure for okrole
*/

CREATE TABLE okrole (
  id varchar(20) NOT NULL default '',
  role varchar(20) NOT NULL default '',
  PRIMARY KEY  (id,role)
) TYPE=MyISAM COMMENT='role table';
