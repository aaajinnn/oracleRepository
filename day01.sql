-- �ܹ��ּ�
/* �����ּ�
    ���� ���� �ּ� ó��
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

--�л� ���̺�
create table student(
-- MySQL�� int, ����Ŭ�� number
    no NUMBER(4) primary key, -- primary key : unique + not null
    name VARCHAR2(30) not null,
    addr varchar2(100),
    tel varchar2(16) not null,
    indate date default sysdate, -- �⺻���� ����� ��¥
    sclass varchar2(30),
    sroom number(3)
);
desc student;
-- insert : �޸𸮿� ������ ����
insert into student(no, name, tel)
values(1, '��ö��', '010-2222-3333');
-- ���������� �����ͺ��̽��� �ֱ����ؼ��� commit�� ����� �Ѵ�.
-- ����Ŭ�� ���� commit, MySQL�� �ڵ� commit
commit;
select * from student;
-- c : create => insert
-- r : read => select
-- u : update => update
-- d : delete => delete

-- 2 �迵�� ����ó �ּ� �б޸�(�鿣�尳���ڹ�) 201
insert into student (no, name, tel, addr, sclass, sroom)
values(3,'��浿','010-3333-5555','������ ���뱸','�鿣�尳���ڹ�', 201);
-- no�� primary key�̹Ƿ� �������� ���� �� �����߻�
rollback; -- commit�� insert ��� : rollback (commit�� ��Ҵ� �Ұ���)
select * from student;
commit;
delete from student where no=3; -- commit �� ����(rollback���� �ǵ����� ����)

insert into student
values(5,'ȫ�浿','��õ ������','010-7777-5555', sysdate,'����Ʈ �����ڹ�', 202);
select * from student;
rollback;
commit;

-- update : ������ ���� (where�������� ��������)
-- update ���̺�� set �÷���1=��, �÷���2=��2 where ������
update student set addr='���� ������', sclass='��ص� ������', sroom=201 where no=1;
select * from student order by no;
rollback;

select * from student where sclass ='�鿣�尳���ڹ�';
select * from student where sroom=201;

-- �л� ���̺��� �����ϰ� �ٽ� ������
-- create�� drop�� commit�� rollback �Ұ���
drop table student;

-- �б� ���̺� ����
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
values(10, '���ص� �����ڹ�', 201);
insert into sclass
values(20,'����Ʈ���� �����ڹ�', 202);
insert into sclass
values(30,'�����͹�', 203);
select * from sclass;

insert into student(no, name, addr, tel, snum_fk)
values(1,'��ö��','���� ������','010-2222-3333',10);
insert into student(no, name, addr, tel, snum_fk)
values(2,'��ö��','���� ������','010-3333-4444',20);
-- ORA-02291: integrity constraint (SCOTT.SYS_C007057) violated - parent key not found
-- ���Ἲ �������� ����(sclass�� ���������� ���� �����͸� ���� �� ����.)
select * from student;

-- join
select student.*, sclass.*
from sclass join student
on sclass.snum = student.snum_fk;

-- �ǽ�
insert into student(no, name, addr, tel, snum_fk)
values(3, '��ö��', '���� ������','010-4444-5555',10);
insert into student(no, name, addr, tel, snum_fk)
values(4, '��ö��', '���� ������','010-5555-6666',10);
insert into student(no, name, addr, tel, snum_fk)
values(5, 'ȫö��', '���� ������','010-6666-7777',10);
insert into student(no, name, addr, tel, snum_fk)
values(6, '�迵��', '������ ���뱸','010-6666-6666',20);
insert into student(no, name, addr, tel, snum_fk)
values(7, '�ڿ���', '������ �Ǽ���','010-7777-6666',20);
insert into student(no, name, addr, tel, snum_fk)
values(8, '�̿���', '���ν� ���ﱸ','010-6677-7766',20);
insert into student(no, name, addr, tel, snum_fk)
values(9, '�ֿ���', '���ν� ó�α�','010-8888-9999',30);
select * from student;

update student set snum_fk=20 where no=1;

select student.*
from sclass join student
on sclass.snum = student.snum_fk
where sclass.snum = 10;