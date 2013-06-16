insert into okad_log (credate, url, referer, sid, ip) 
values (now(), 'http://olc.oss.kr/', 'http://www.okjsp.pe.kr/', 0, '0.0.0.0');

select * from okad_log order by lseq desc limit 10;

select * from okad_log order by lseq desc limit 10,10;

select * from okad_log order by lseq desc limit 20,10;

commit;

select date_format(credate, '%Y-%m-%d') as ldate,
count(date_format(credate, '%Y-%m-%d')) as lcount
from okad_log
group by date_format(credate, '%Y-%m-%d')
order by 1 desc
;

select date_format(credate, '%Y-%m-%d') as ldate,
url,
count(date_format(credate, '%Y-%m-%d')) as lcount
from okad_log
group by date_format(credate, '%Y-%m-%d'), url
order by 1 desc, 3 desc
;

select * from okad_log where credate between '2012-05-01' and '2012-05-02' order by url desc

--
select date_format(credate, '%Y-%m-%d') as ldate, 
count(date_format(credate, '%Y-%m-%d')) as lcount 
from okad_log 
where credate between CAST(TO_DATE('201306','YYYYMM') AS TIMESTAMP)
and CAST(TO_DATE('201307','YYYYMM') AS TIMESTAMP)
group by date_format(credate, '%Y-%m-%d') order by 1 desc
