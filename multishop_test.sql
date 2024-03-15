drop table memo;

create table memo(
	no number(8),
	name varchar2(30) not null,
	msg varchar2(100),
	wdate timestamp default systimestamp,
	primary key (no)
);

drop sequence memo_seq;

create sequence memo_seq nocache;

desc memo;
select * from memo;
select * from memo order by wdate;

--����¡ó��(������ ������)
select * from(
            select row_number() over(order by no desc) rn, memo.*
            from memo
             )
where rn > 5 and rn < 11;