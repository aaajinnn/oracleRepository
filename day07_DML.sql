--day07_DML.sql

--EMP_10 ���̺��� �������� �̿��� �����ϵ� ������
CREATE TABLE EMP_10(ID, NAME, SALARY, HDATE)
AS
SELECT EMPNO, ENAME, SAL, HIREDATE 
FROM EMP
WHERE 1=0;

DESC EMP_10;

SELECT * FROM EMP_10;

--#INSERT������ �������� ���
--INSERT INTO ���̺�� SUBQUERY
INSERT INTO EMP_10
SELECT EMPNO, ENAME, SAL, HIREDATE FROM EMP WHERE DEPTNO=10;

SELECT * FROM EMP_10;

SELECT * FROM EMP ORDER BY DEPTNO;

INSERT INTO EMP_10(NAME, SALARY, ID, HDATE)
VALUES('JAMES',2800, 7999, '85/05/03');

ROLLBACK;
COMMIT;

INSERT INTO EMP_10
VALUES(7998, 'TOM', 3200, TO_DATE('860301','YYMMDD'));

----------------------------------------------
--#UPDATE��

--- UPDATE ���̺�� SET �÷Ÿ�=��1, ��2,...;
--==> ��� �����Ͱ� ����
--- UPDATE ���̺�� SET �÷Ÿ�=��1, ��2,...WHERE ������;
--==> ���ǿ� �´� �����͸� ����

--[�ǽ�]
    --- EMP2���̺��� �����ϰ� EMP�� �����ͱ��� ���Խ��� �����ϼ���
    CREATE TABLE EMP2
    AS
    SELECT * FROM EMP;

--    SELECT* FROM EMP2;
    DROP TABLE EMP2;
    
    --- emp2���̺��� ����� 7788�� ����� �μ���ȣ�� 10���� �����ϼ���.
    UPDATE EMP2 SET DEPTNO=10 WHERE ENAME=7788;
    
    --- emp2 ���̺��� ����� 7499�� ����� �μ��� 20, �޿��� 3500���� �����Ͽ���.   
    UPDATE EMP2 SET SAL=3500, ID=20 WHERE ENAME=7499;
    
    --- emp2���̺��� �μ��� ��� 10���� �����Ͽ���.
    UPDATE EMP2 SET DEPTNO=10;
    ROLLBACK;

--2] ��ϵ� �� ���� �� ���� ���̸� ���� ���̿��� ��� 5�� ���� ������ �����ϼ���.
    SELECT * FROM MEMBER;
    UPDATE MEMBER SET AGE=AGE+5;
--2_1] �� �� 23/09/01���� ����� ������ ���ϸ����� 350���� �÷��ּ���.
    UPDATE MEMBER SET MILEAGE=MILEAGE+350 WHERE REG_DATE>='23/09/01';
--4] ��ϵǾ� �ִ� �� ���� �� �̸��� '��'�ڰ� ����ִ� ��� �̸��� '��' ��� '��'�� �����ϼ���.
    UPDATE MEMBER SET NAME=REPLACE(NAME,'��','��') WHERE NAME LIKE '%��%';
    ROLLBACK;
    
--#UPDATE������ SUBQUERY ���
--EMP2���̺��� SCOTT�� ������ �޿��� ��ġ�ϵ���
--		JONES�� ������ �޿��� �����Ͽ���.
    SELECT* FROM EMP2;
    UPDATE EMP2 SET (JOB, SAL)=
    (SELECT JOB, SAL FROM EMP2 WHERE ENAME='SCOTT')
    WHERE ENAME='JONES'; -- ���߿� ��������
    
    ROLLBACK;
UPDATE DEPT SET DEPTNO=50, DNAME='EDUCATION', LOC='SEOUL';
INSERT INTO DEPT VALUES(10, 'ACCOUNTING','NEWYORK');
INSERT INTO DEPT VALUES(20, 'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES(30, 'SALES','CHICAGO');
INSERT INTO DEPT VALUES(40, 'OPERATIONS','BOSTION');
INSERT INTO DEPT VALUES(50, 'EDUCATION','SEOUL');
DELETE FROM DEPT WHERE DEPTNO=50;
CREATE TABLE DEPT2
AS
SELECT * FROM DEPT;

SELECT * FROM DEPT2;

-- -DEPT2�� DEPTNO�÷��� ���� PRIMARY KEY ���������� �߰��ϼ���
ALTER TABLE DEPT ADD CONSTRAINT DEPT_DEPTNO_PK PRIMARY KEY(DEPTNO);
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT';

-- -EMP2�� DEPTNO �÷��� ���� FOREIGN KEY �߰��ϵ� DEPT2�� DEPTNO�� �ܷ�Ű�� �����ϵ���
ALTER TABLE EMP2 ADD CONSTRAINT EMP2_DEPTNO_FK FOREIGN KEY(DEPTNO)
REFERENCES DEPT2(DEPTNO);
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMP2';

--EMP2���� �μ���ȣ�� 10���� ������� �μ���ȣ�� 40������ �����ϼ���
    UPDATE EMP2 SET DEPTNO=40 WHERE DEPTNO=10;
    SELECT * FROM EMP2 ORDER BY DEPTNO DESC;

--EMP2���� ������� 'WARD'�� �μ���ȣ�� 90������ �����ϼ���
    UPDATE EMP2 SET DEPTNO=90 WHERE ENAME='WARD'; --==>ERROR
    
    ROLLBACK;
    
-- #DELETE ��
-- DELETE FROM ���̺��;
-- => ��� ������ ����
-- DELETE FROM ���̺�� WHERE ������;
-- => ���ǿ� �´� �����͸� ����

--#DELETE ���̺� ��������
-- 1] ��ǰ ���̺� �ִ� ��ǰ �� ��ǰ�� �Ǹ� ������ 10000�� ������ ��ǰ�� ��� 
--	      �����ϼ���.
    SELECT * FROM PRODUCTS;
    SELECT * FROM CATEGORY;
    DELETE FROM PRODUCTS WHERE OUTPUT_PRICE<=10000;
    ROLLBACK;
--	2] ��ǰ ���̺� �ִ� ��ǰ �� ��ǰ�� ��з��� ������ ��ǰ�� �����ϼ���.
    DELETE FROM PRODUCTS 
    WHERE CATEGORY_FK = 
            (SELECT CATEGORY_CODE FROM CATEGORY WHERE CATEGORY_NAME='����');
    
--	3] ��ǰ ���̺� �ִ� ��� ������ �����ϼ���.
    DELETE FROM PRODUCTS;
   
 -- EMP2���� NEW YORK �� �ٹ��ϴ� ������� ������ �����ϼ���
    DELETE FROM EMP2 WHERE DEPTNO = 
        (SELECT DEPTNO FROM DEPT2 WHERE LOC='NEWYORK');
    SELECT * FROM EMP2;
UPDATE DEPT2 SET LOC='NEW YORK' WHERE LOC='NEWYORK'; 
SELECT * FROM DEPT;
DESC DEPT;
COMMIT;
--#DELETE�� ���Ἲ �������� ����
--DEPT2���� 30�� �μ��� �����ϼ���
DELETE FROM DEPT2 WHERE DEPTNO=30; -- child record found

UPDATE EMP2 SET DEPTNO=40 WHERE DEPTNO=30;
DELETE FROM DEPT2 WHERE DEPTNO=30;
ROLLBACK;

SELECT * FROM DEPT2;
SELECT * FROM EMP2;

----------------------------------------
--#TCL - TRANSACTION CONTROL LAGUAGE
-- COMMIT
-- ROLLBACK
-- SAVEPOINT (ORACLE����)

--#SAVEPOINT ��� - ǥ�� SQL���� �ƴ�
UPDATE EMP2 SET ENAME='CHARSE' WHERE EMPNO =7788;
SELECT * FROM EMP2;
UPDATE EMP2 SET DEPTNO=30 WHERE EMPNO=7788;

-- ������ ����
-- SAVEPOINT �������̸�;
SAVEPOINT POINT1;

UPDATE EMP2 SET JOB='MANAGER';
SELECT * FROM EMP2;

ROLLBACK; --> ���� �۾� ��� ���
ROLLBACK TO SAVEPOINT POINT1; --> POINT1 ������������ ���
SELECT * FROM EMP2;

