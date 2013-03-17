select sid, sum(point), count(*) from point_history group by sid order by 2 desc

select * from point_history where tstamp < '2013-01-01 00:00:00' order by pseq desc 

insert into point_history_backup 
select * from point_history where tstamp < '2013-01-01 00:00:00' order by pseq 

--delete from point_history where tstamp < '2013-01-01 00:00:00'

--delete from point_history where tstamp < '2013-01-01 00:00:00'
--(372903 rows affected)
