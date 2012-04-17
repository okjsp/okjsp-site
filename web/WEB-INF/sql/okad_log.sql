insert into okad_log (credate, url, referer, sid, ip) 
values (now(), 'http://olc.oss.kr/', 'http://www.okjsp.pe.kr/', 0, '0.0.0.0');

select * from okad_log order by lseq desc limit 10;

commit;