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
select * from okmember where sid = 21027

update okmember set email = 'y@lycos.co.kr' where id = 'y';
update okmember set joindate = '2011-10-28 17:15:27' where id = 'y';

select * from okmember where joindate = '1970-01-02 00:00:00' limit 10;

select count(*) from okmember where joindate = '1970-01-02 00:00:00';
-- 1450
update okmember set joindate = '2011-09-18 01:23:32' where joindate = '1970-01-02 00:00:00';
-- 2011-01-13 01:23:32 to 2011-09-18 01:23:32

select * from point_history where sid = 15388;

select * from okmember order by sid;
