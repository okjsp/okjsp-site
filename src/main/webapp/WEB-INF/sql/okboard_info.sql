select * from okboard_info;

insert into okboard_info (cseq, bbsid, name, header) 
values (1, 'guideline', '프리랜서 가이드라인', '프리랜서 가이드라인 연재 게시판입니다.');

select * from okboard_info where bbsid = 'guideline';

update okboard_info set header = '전자정부 표준프레임워크 관련 게시판입니다.' where bbsid = 'egov';
