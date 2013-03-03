select * from point_history order by tstamp desc limit 100;

drop index memo_seq_idx on okboard_memo (seq);

create index memo_seq_idx on okboard_memo (seq);


create reverse index memo_seq_idx_rev on okboard_memo (seq);

select * from db_attribute where class_name = 'point_history'
 
select count(*) from point_history