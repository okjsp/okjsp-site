insert into okboard_ad (seq, startdate, enddate, priority) values 
(213857, now(), '2013-03-18 23:59:59', 11);
-- 11 free
-- 185887)

select * from okboard_ad order by aseq;

update okboard_ad set priority = 0
where aseq = 25;

select * from okboard_ad where startdate < sysdatetime and enddate > sysdatetime order by priority desc;

select sysdatetime

commit;
