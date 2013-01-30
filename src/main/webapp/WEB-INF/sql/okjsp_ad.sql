insert into okboard_ad (seq, startdate, enddate, priority) values 
(194750, now(), '2012-07-17 23:59:59', 1);

-- 185887)

select * from okboard_ad order by aseq;

update okboard_ad set priority = 0
where aseq = 25;

select * from okboard_ad where startdate < sysdatetime and enddate > sysdatetime order by priority desc;

select sysdatetime

commit;
