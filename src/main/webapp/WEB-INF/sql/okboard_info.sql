select * from okboard_info;

insert into okboard_info (cseq, bbsid, name, header) 
values (1, 'okhee2', 'OKJSP리뉴얼', 'OKJSP 리뉴얼 프로젝트 관련 게시판입니다.');

select * from okboard_info where bbsid = 'okhee2';

update okboard_info set header = '전자정부 표준프레임워크 관련 게시판입니다.' where bbsid = 'egov';
