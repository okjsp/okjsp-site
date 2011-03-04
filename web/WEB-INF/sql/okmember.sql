select name,email from okmember where mailing = 'Y';


select count(*) cnt, max(sid) from okmember;

update okmember set mailing = 'N' where email in (
'a@orea.com'
);

select name,email from okmember where mailing = 'Y' order by sid;
