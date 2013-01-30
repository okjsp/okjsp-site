select * from okboard where id = '19826' order by seq desc limit 10;


select * from okmember where sid in (
19826,
19765
);

update okmember set password = 'spammer' where sid in (
19826,
19765
);
