GRANT ALL PRIVILEGES ON *.* TO kenu@localhost
IDENTIFIED BY 'okpass' WITH GRANT OPTION;

use test;

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
) COMMENT='»ç¿ëÀÚ';


CREATE TABLE OKROLE (
ID 		VARCHAR(20)	NOT NULL,
ROLE 	VARCHAR(20) 	NOT NULL
);

create index okmember_id_idx on okmember(id);
create index okrole_id_idx on okrole(id);
