-- 단문주석
/* 복문주석
    여러 라인 주석 처리
*/
--select count(*) from tab;
--select * from tab;
--select * from dept;
--select * from emp;
--select * from salgrade;
--select * from category;
--select * from products;
--select * from member;
--select * from supply_comp;

--day01.sql

--학생 테이블
create table student(
-- MySQL은 int, 오라클은 number
    no NUMBER(4) primary key, -- primary key : unique + not null
    name VARCHAR2(30) not null,
    addr varchar2(100),
    tel varchar2(16) not null,
    indate date default sysdate, -- 기본값에 등록한 날짜
    sclass varchar2(30),
    sroom number(3)
);
desc student;
-- insert : 메모리에 데이터 삽입
insert into student(no, name, tel)
values(1, '이철수', '010-2222-3333');
-- 영구적으로 데이터베이스에 넣기위해서는 commit을 해줘야 한다.
-- 오라클은 수동 commit, MySQL은 자동 commit
commit;
select * from student;
-- c : create => insert
-- r : read => select
-- u : update => update
-- d : delete => delete

-- 2 김영희 연락처 주소 학급명(백엔드개발자반) 201
insert into student (no, name, tel, addr, sclass, sroom)
values(3,'김길동','010-3333-5555','수원시 영통구','백엔드개발자반', 201);
-- no는 primary key이므로 같은값을 넣을 시 에러발생
rollback; -- commit전 insert 취소 : rollback (commit후 취소는 불가능)
select * from student;
commit;
delete from student where no=3; -- commit 후 삭제(rollback으로 되돌리기 가능)

insert into student
values(5,'홍길동','인천 남동구','010-7777-5555', sysdate,'프런트 개발자반', 202);
select * from student;
rollback;
commit;

-- update : 데이터 수정 (where조건절을 잊지말것)
-- update 테이블명 set 컬럼명1=값, 컬럼명2=값2 where 조건절
update student set addr='서울 강남구', sclass='백앤드 개발자', sroom=201 where no=1;
select * from student order by no;
rollback;

select * from student where sclass ='백엔드개발자반';
select * from student where sroom=201;

-- 학생 테이블을 삭제하고 다시 만들어보자
-- create와 drop은 commit과 rollback 불가능
drop table student;

-- 학급 테이블 생성
create table sclass (
    snum number(4) primary key,
    sname varchar2(30) not null,
    sroom number(3)
);
create table student(
    no number(4) primary key,
    name varchar2(30) not null,
    addr varchar2(100),
    tel varchar2(16) not null,
    indate date default sysdate,
    snum_fk number(4) references sclass(snum)
);

insert into sclass(snum, sname, sroom)
values(10, '벡앤드 개발자반', 201);
insert into sclass
values(20,'프론트엔드 개발자반', 202);
insert into sclass
values(30,'빅데이터반', 203);
select * from sclass;

insert into student(no, name, addr, tel, snum_fk)
values(1,'이철수','서울 마포구','010-2222-3333',10);
insert into student(no, name, addr, tel, snum_fk)
values(2,'김철수','서울 강서구','010-3333-4444',20);
-- ORA-02291: integrity constraint (SCOTT.SYS_C007057) violated - parent key not found
-- 무결성 제약조건 오류(sclass가 가지고있지 않은 데이터를 넣을 수 없다.)
select * from student;

-- join
select student.*, sclass.*
from sclass join student
on sclass.snum = student.snum_fk;

-- 실습
insert into student(no, name, addr, tel, snum_fk)
values(3, '박철수', '서울 강남구','010-4444-5555',10);
insert into student(no, name, addr, tel, snum_fk)
values(4, '최철수', '서울 마포구','010-5555-6666',10);
insert into student(no, name, addr, tel, snum_fk)
values(5, '홍철수', '서울 강서구','010-6666-7777',10);
insert into student(no, name, addr, tel, snum_fk)
values(6, '김영희', '수원시 영통구','010-6666-6666',20);
insert into student(no, name, addr, tel, snum_fk)
values(7, '박영희', '수원시 권선구','010-7777-6666',20);
insert into student(no, name, addr, tel, snum_fk)
values(8, '이영희', '용인시 기흥구','010-6677-7766',20);
insert into student(no, name, addr, tel, snum_fk)
values(9, '최영희', '용인시 처인구','010-8888-9999',30);
select * from student;

update student set snum_fk=20 where no=1;

select student.*
from sclass join student
on sclass.snum = student.snum_fk
where sclass.snum = 10;