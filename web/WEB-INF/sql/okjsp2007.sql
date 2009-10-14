/*
SQLyog Community Edition- MySQL GUI v5.32
Host - 4.1.22-standard : Database - db_kenu
*********************************************************************
Server version : 4.1.22-standard
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

create database if not exists `test`;

/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

GRANT ALL PRIVILEGES ON *.* TO okjsp@localhost
IDENTIFIED BY 'okpass' WITH GRANT OPTION;

/*Table structure for table `kcount` */

CREATE TABLE `kcount` (
  `idx` int(11) NOT NULL auto_increment,
  `cdate` int(11) default NULL,
  `ctime` int(11) default NULL,
  `dayofweek` int(11) default NULL,
  `ip` varchar(20) default NULL,
  `referer` varchar(200) default NULL,
  `browser` varchar(20) default NULL,
  `os` varchar(20) default NULL,
  PRIMARY KEY  (`idx`),
  KEY `kcount_cdate_indx` (`cdate`,`idx`),
  KEY `kcount_dayofweek_indx` (`dayofweek`)
) ENGINE=MyISAM AUTO_INCREMENT=2063355 DEFAULT CHARSET=latin1;

/*Table structure for table `okboard` */

CREATE TABLE `okboard` (
  `BBSID` varchar(50) default NULL,
  `SEQ` int(11) NOT NULL default '0',
  `REF` int(11) default NULL,
  `STEP` tinyint(4) default NULL,
  `LEV` tinyint(4) default NULL,
  `WRITER` varchar(50) default NULL,
  `SUBJECT` varchar(255) default NULL,
  `PASSWORD` varchar(50) default NULL,
  `EMAIL` varchar(50) default NULL,
  `HIT` int(11) default NULL,
  `HTML` char(1) default NULL,
  `HOMEPAGE` varchar(255) default NULL,
  `STS` tinyint(4) default '1',
  `WTIME` datetime default NULL,
  `IP` varchar(50) default NULL,
  `MEMO` int(4) default NULL,
  `CONTENT` mediumtext,
  `CCL_ID` char(1) default '0',
  PRIMARY KEY  (`SEQ`),
  KEY `okboard_bbsid_idx` (`BBSID`),
  KEY `okboard_ref_idx` (`REF`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `okboard_bookmark` */

CREATE TABLE `okboard_bookmark` (
  `id` varchar(20) NOT NULL default '',
  `seq` int(11) NOT NULL default '0',
  `credate` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`,`seq`),
  KEY `okboard_bookmark_id_idx` (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `okboard_category` */

CREATE TABLE `okboard_category` (
  `seq` int(11) NOT NULL auto_increment,
  `category` varchar(30) NOT NULL default '',
  PRIMARY KEY  (`seq`),
  UNIQUE KEY `seq` (`seq`),
  KEY `seq_2` (`seq`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COMMENT='category';

/*Table structure for table `okboard_deleted` */

CREATE TABLE `okboard_deleted` (
  `BBSID` varchar(50) default NULL,
  `SEQ` int(11) NOT NULL default '0',
  `REF` int(11) NOT NULL default '0',
  `STEP` int(11) NOT NULL default '0',
  `LEV` int(11) NOT NULL default '0',
  `WRITER` varchar(50) default NULL,
  `SUBJECT` varchar(255) default NULL,
  `PASSWORD` varchar(50) default NULL,
  `EMAIL` varchar(50) default NULL,
  `HIT` int(11) default NULL,
  `HTML` char(1) default NULL,
  `HOMEPAGE` varchar(255) default NULL,
  `STS` int(1) default '1',
  `WTIME` datetime default NULL,
  `IP` varchar(50) default NULL,
  `MEMO` int(11) default NULL,
  `CONTENT` mediumtext,
  `CCL_ID` char(1) default '0',
  PRIMARY KEY  (`SEQ`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `okboard_file` */

CREATE TABLE `okboard_file` (
  `FSEQ` int(11) NOT NULL default '0',
  `SEQ` int(11) NOT NULL default '0',
  `FILENAME` varchar(200) NOT NULL default '',
  `MASKNAME` varchar(30) NOT NULL default '',
  `FILESIZE` int(11) NOT NULL default '0',
  `DOWNLOAD` int(11) NOT NULL default '0',
  `sts` int(1) NOT NULL default '1',
  PRIMARY KEY  (`FSEQ`),
  UNIQUE KEY `FSEQ` (`FSEQ`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='file info';

/*Table structure for table `okboard_info` */

CREATE TABLE `okboard_info` (
  `cseq` int(11) NOT NULL default '0',
  `bbsid` varchar(20) NOT NULL default '',
  `name` varchar(30) NOT NULL default '',
  `header` varchar(200) default NULL,
  PRIMARY KEY  (`bbsid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='board info';

/*Table structure for table `okboard_info_role` */

CREATE TABLE `okboard_info_role` (
  `bbsid` varchar(20) NOT NULL default '',
  `role` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`bbsid`,`role`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `okboard_memo` */

CREATE TABLE `okboard_memo` (
  `MSEQ` int(11) NOT NULL default '0',
  `SEQ` int(11) NOT NULL default '0',
  `WRITER` varchar(50) default NULL,
  `BCOMMENT` text,
  `WTIME` datetime default NULL,
  `MEMOPASS` varchar(20) default NULL,
  `IP` varchar(16) default NULL,
  PRIMARY KEY  (`MSEQ`),
  UNIQUE KEY `MSEQ` (`MSEQ`),
  KEY `memo_seq_idx` (`SEQ`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='memo';

/*Table structure for table `okboard_tag` */

CREATE TABLE `okboard_tag` (
  `tagseq` int(11) NOT NULL default '0',
  `tag` varchar(100) NOT NULL default '',
  `cnt` int(11) default NULL,
  `credate` datetime default NULL,
  PRIMARY KEY  (`tagseq`),
  UNIQUE KEY `tag` (`tag`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `okboard_tag_user` */

CREATE TABLE `okboard_tag_user` (
  `tagseq` int(11) NOT NULL default '0',
  `userid` varchar(20) NOT NULL default '',
  `seq` int(11) NOT NULL default '0',
  `credate` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`tagseq`,`userid`,`seq`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `okmember` */

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='»ç¿ëÀÚ'        

/*Table structure for table `okrole` */

CREATE TABLE `okrole` (
  `id` varchar(20) NOT NULL default '',
  `role` varchar(20) NOT NULL default '',
  PRIMARY KEY  (`id`,`role`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='role table';

/*Table structure for table `poll_data` */

CREATE TABLE `poll_data` (
  `qseq` int(10) unsigned default NULL,
  `seq` bigint(20) unsigned NOT NULL auto_increment,
  `answer` text,
  `logtime` datetime default NULL,
  PRIMARY KEY  (`seq`)
) ENGINE=MyISAM AUTO_INCREMENT=3741 DEFAULT CHARSET=latin1 COMMENT='poll';

/*Table structure for table `poll_group` */

CREATE TABLE `poll_group` (
  `seq` int(10) unsigned default NULL,
  `gquery` text,
  UNIQUE KEY `seq` (`seq`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='poll_group';

/*Table structure for table `poll_item` */

CREATE TABLE `poll_item` (
  `pseq` int(10) unsigned default NULL,
  `seq` int(10) unsigned default NULL,
  `item` varchar(255) default NULL,
  `hit` bigint(20) unsigned default NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `poll_query` */

CREATE TABLE `poll_query` (
  `gseq` int(11) unsigned default NULL,
  `seq` int(10) unsigned default NULL,
  `query` text NOT NULL,
  `querytype` char(1) default NULL,
  UNIQUE KEY `seq` (`seq`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='poll info';

/*Table structure for table `poll_user` */

CREATE TABLE `poll_user` (
  `seq` bigint(20) unsigned NOT NULL auto_increment,
  `ip` varchar(16) default NULL,
  `logtime` datetime default NULL,
  `session` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`seq`)
) ENGINE=MyISAM AUTO_INCREMENT=304 DEFAULT CHARSET=latin1 COMMENT='poll logger';

/*Table structure for table `pollitem` */

CREATE TABLE `pollitem` (
  `seq` int(11) NOT NULL default '0',
  `itemseq` int(11) default NULL,
  `item` varchar(200) default NULL,
  `hit` int(11) default '0',
  KEY `idx_pollitem` (`seq`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `polllist` */

CREATE TABLE `polllist` (
  `seq` int(11) NOT NULL default '0',
  `question` text NOT NULL,
  `sdate` datetime default NULL,
  `edate` datetime default NULL,
  `active` char(1) default '1',
  `vtype` int(11) NOT NULL default '1',
  `wtime` datetime default NULL,
  KEY `idx_polllist` (`seq`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;