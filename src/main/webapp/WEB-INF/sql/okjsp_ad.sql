insert into okboard_ad (seq, startdate, enddate, priority) values 
(219160, now(), '2013-05-14 19:59:59', 20);
-- 11 free
-- 185887)

select * from okboard_ad order by aseq;

update okboard_ad set enddate = '2013-05-30 19:59:59'
where aseq = 78;

select * from okboard_ad where startdate < sysdatetime and enddate > sysdatetime order by priority desc;

select sysdatetime

commit;
