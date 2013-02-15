select name,email from okmember where mailing = 'Y';


select count(*) cnt, max(sid) from okmember;

update okmember set mailing = 'N' where email in (
'a@orea.com'
);

select name,email from okmember where mailing = 'Y' order by sid;


update okmember set sid = 14901 where sid = 1;

insert into okmember (id,name,password, sid) values ('kenu','kenu',old_password('163'), 163);

select * from okmember where id like 'sbroh%';
select * from okrole where id like 'mangsang%';

delete from okrole where id = 'mangsang00';
select * from okmember where email like 'loger%';

update okmember set email = 'yjkim_king@lycos.co.kr' where id = 'gatnet19';
update okmember set joindate = '2011-10-28 17:15:27' where id = 'gatnet19';

select * from point_history where sid = 15388;


select * from okmember order by sid;

 kenu1 2f510dbf079b04a2 ÄÉ´©   okjspgwt@gmail.com 2007-10-08 15:02:28.0 okjsp    NULL    Y       N           0 3582

select * from okmember where sid = 20173;