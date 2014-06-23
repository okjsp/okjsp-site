select * from okboard_info;

insert into okboard_info (cseq, bbsid, name, header) 
values (1, 'egov', '전자정부프레임웍', '전자정부프레임웍 관련 게시판입니다.');

select * from okboard_info where bbsid = 'egov';

update okboard_info set name = '구인' where bbsid = 'recruit';
