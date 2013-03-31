select * from okboard_info;

insert into okboard_info (cseq, bbsid, name, header) 
values (1, 'pr', '홍보', '행사, 제품, 스터디 등을 널리 알리는 곳입니다.');

select * from okboard_info where bbsid = 'bbs4';

update okboard_info set name = 'Java/JSP Tips' where bbsid = 'bbs4';
