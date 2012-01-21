select name,email from okmember where mailing = 'Y';


select count(*) cnt, max(sid) from okmember;

update okmember set mailing = 'N' where email in (
'a@orea.com'
);

select name,email from okmember where mailing = 'Y' order by sid;


update okmember set sid = 14901 where sid = 1;

insert into okmember (id,name,password, sid) values ('kenu','kenu',old_password('163'), 163);

select * from okmember