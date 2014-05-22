select * from okboard_info;

insert into okboard_info (cseq, bbsid, name, header) 
values (1, 'getjob', '구직', '직장을 원하는 프로그래머를 위한 게시판입니다.');

select * from okboard_info where bbsid = 'bbs4';

update okboard_info set name = '구인' where bbsid = 'recruit';
