insert into okboard_ad (seq, startdate, enddate, priority) values 
(185887, '2012-03-23 00:00:00', '2012-03-31 23:59:59', 1);

-- 185887)

select * from okboard_ad order by aseq;

update okboard_ad set enddate = now()
where aseq = 11;

select * from okboard_ad where startdate < sysdatetime and enddate > sysdatetime order by priority desc;

select sysdatetime

commit;
