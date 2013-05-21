select * from okboard_info;

insert into okboard_info (cseq, bbsid, name, header) 
values (1, 'cooper', '협동조합준비위', '협동조합관련 정보를 널리 알리는 곳입니다.');

select * from okboard_info where bbsid = 'bbs4';

update okboard_info set name = 'Java/JSP Tips' where bbsid = 'bbs4';
