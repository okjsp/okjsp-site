select * from okboard_info;

insert into okboard_info (cseq, bbsid, name, header) 
values (1, 'institute', '학원', '배우고자 하는 학생 모집하는 게시판입니다.');

select * from okboard_info where bbsid = 'bbs4';

update okboard_info set name = 'Java/JSP Tips' where bbsid = 'bbs4';
