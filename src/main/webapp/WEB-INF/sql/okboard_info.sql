select * from okboard_info;

insert into okboard_info (cseq, bbsid, name, header) 
values (1, 'review', 'OKJSP 리뷰', 'OKJSP 리뷰 게시판입니다.');

select * from okboard_info where bbsid = 'review';

update okboard_info set header = '전자정부 표준프레임워크 관련 게시판입니다.' where bbsid = 'egov';
