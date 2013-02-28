select count(*) FROM okboard WHERE bbsid = 'recruit' and id = 'kenu1' and wtime > (sysdate - 2);


select sysdate, (sysdate - 7), a.* FROM okboard a
WHERE bbsid = 'recruit' and id = 'kenu1'
and wtime > (sysdate - 2)
ORDER BY seq desc 
for orderby_num() between 1 and 100;

select * from okboard_memo ORDER BY seq desc for orderby_num() between 1 and 100;



select * from okboard where seq = 117807;

select * from okboard_info;
