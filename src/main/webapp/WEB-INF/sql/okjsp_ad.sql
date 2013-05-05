insert into okboard_ad (seq, startdate, enddate, priority) values 
(219354, now(), '2013-05-14 19:59:59', 1);
-- 11 free
-- 185887)

select * from okboard_ad order by aseq;

update okboard_ad set priority = 0
where aseq = 25;

select * from okboard_ad where startdate < sysdatetime and enddate > sysdatetime order by priority desc;

select sysdatetime

commit;
