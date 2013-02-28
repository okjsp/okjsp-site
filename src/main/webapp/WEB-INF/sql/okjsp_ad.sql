insert into okboard_ad (seq, startdate, enddate, priority) values 
(213309, now(), '2013-03-11 23:59:59', 10);
-- 11 free
-- 185887)

select * from okboard_ad order by aseq;

update okboard_ad set priority = 0
where aseq = 25;

select * from okboard_ad where startdate < sysdatetime and enddate > sysdatetime order by priority desc;

select sysdatetime

commit;
