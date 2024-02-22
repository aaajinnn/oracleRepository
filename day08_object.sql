-- day08_object.sql
--# ORACLE�� ��ü
--[1] TABLE
--[2] SEQUENCE
--[3] VIEW
--[4] INDEX
--[5] SYNONYM
--....

--#SEQUENCE
--DEPT�� PK�� ���Ǵ� DEPTNO ������ ����� �������� ������
CREATE SEQUENCE DEPT_DEPTNO_SEQ
START WITH 60 -- ���۰�
INCREMENT BY 10 -- ����ġ
MAXVALUE 99 -- �ִ밪
MINVALUE 60
NOCACHE 
NOCYCLE;

--������ �������� ��ȸ
SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME='DEPT_DEPTNO_SEQ';

SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='SEQUENCE';

--# ������ ����
--- NEXTVAL : ������ �������� ��ȯ
---CURRVAL : �������� ���簪�� ��ȯ
---[���ǻ���] NEXTVAL�� �������� ä�� CURRVAL�� ���� ����� �� ����.

INSERT INTO DEPT(DEPTNO, DNAME, LOC)
VALUES(DEPT_DEPTNO_SEQ.NEXTVAL, 'ȫ����', '��õ');

INSERT INTO DEPT(DEPTNO, DNAME, LOC)
VALUES(DEPT_DEPTNO_SEQ.NEXTVAL, '��ȹ��2', '����');

SELECT * FROM DEPT;
rollback;
DESC DEPT;
SELECT DEPT_DEPTNO_SEQ.CURRVAL FROM DUAL;
----------------------------------------------
-- BBS���̺�(�Խ���)�� ����� �������� �����ϼ���.
SELECT * FROM BBS;
--<1> BBS ���̺�(�Խ���)�� ����� �������� �����ϼ���
--���۰�: n
--����ġ: 1
--�ּҰ�: N
--NOCYCLE
--CACHE n
CREATE SEQUENCE BBS_NO_SEQ
START WITH 4
INCREMENT BY 1
MINVALUE 4
NOCYCLE
NOCACHE;
SELECT*FROM JAVA_MEMBER;
SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME='BBS_NO_SEQ';
--<2> BBS�� �������� �̿��ؼ� �Խñ��� �����ϼ���
INSERT INTO BBS (NO, TITLE, WRITER, CONTENT)
VALUES(BBS_NO_SEQ.NEXTVAL,'�������� �� �� �����','kim','�������� �̿��սô�');

SELECT BBS_NO_SEQ.CURRVAL FROM DUAL;
SELECT * FROM BBS;
-- rollback�� �ص� ������ nextval�� �������� �ٽ� ���ư��� �ʴ´� => ������ ����(gab)�߻�
-- rownum�� ������ �����Ͱ� ������ ���ܼ� ��ȣ�� �ű�
------------------------------------------------------
--DEPT_DEPTNO_SEQ
SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME='DEPT_DEPTNO_SEQ';

-- DEPT_DEPTNO_SEQ�� �Ʒ��� ���� �����ϼ���
--����ġ : 5
--CYCLE �ɼ� �ֱ�
--ĳ�� ������ : 20

--ALTER SEQUENCE ��������
--INCREMENT BY N
--MINVALUE N
--MAXVALUE N
--CYCLE|NOCYCLE
--CACHE N|NOCACHE;
--[����] ���۰��� ������ �� ����
    ALTER SEQUENCE DEPT_DEPTNO_SEQ
--    START WITH 60 -- cannot alter starting sequence number(���۰� ������ �� ����)
    INCREMENT BY 5
    MAXVALUE 150
    CYCLE
    NOCACHE;

SELECT DEPT_DEPTNO_SEQ.NEXTVAL FROM DUAL; -- �ִ밪�Ѿ�� ����Ŭ�� ���ư� ó������ �ٽ� �����

--# ������ ����
--DROP SEQUENCE ��������;
--
--DEPT_DEPTNO_SEQ�� �����ϼ���
DROP SEQUENCE DEPT_DEPTNO_SEQ;
---------------------------------------------
--# VIEW
--������ ���̺�
--CREATE [OR REPLACE] VIEW ���̸�
--AS
--SELECT��
CREATE VIEW EMP20_VIEW
AS
SELECT * FROM EMP
WHERE DEPTNO=20; -- insufficient privileges(���Ѿ���)

-- view�� ����� ���ؼ��� ������ �ʿ�[dba�������� CREATE VIEW������ ����]
--SYSTEMP/ORACLE�� �����ؼ� ������ �ο��Ѵ�.
--GRANT CREATE VIEW TO SCOTT;

CREATE VIEW EMP20_VIEW
AS
SELECT * FROM EMP
WHERE DEPTNO=20;

--VIEW ��ȸ
SELECT * FROM EMP20_VIEW;

--EMP���̺��� 30�� �μ��� EMPNO�� EMP_NO�� ENAME�� NAME����
--	SAL�� SALARY�� �ٲپ� EMP30_VIEW�� �����Ͽ���.
    CREATE OR REPLACE VIEW EMP30_VIEW
    AS
    SELECT EMPNO EMP_NO, ENAME NAME, SAL SALARY, DEPTNO DNO 
    FROM EMP
    WHERE DEPTNO=30;
    
    SELECT * FROM EMP30_VIEW;
    
    -- EMP���̺��� �����Ѵٸ� VIEW�� ���� �����ȴ�.
    UPDATE EMP SET DEPTNO=10 WHERE ENAME='ALLEN';
    -- VIEW�� �����Ѵٸ� EMP���̺� ���� �����ȴ�.
    UPDATE EMP30_VIEW SET SALARY=1550 WHERE NAME='WARD';
    SELECT * FROM EMP;
    -- ���� �並 �������ϰ� �Ϸ��� VIEW�� ������ �� WITH READ ONLY�ɼ��� �ش�.
    
--�����̺��� �� ���� �� ���̰� 19�� �̻���
--	���� ������
--	Ȯ���ϴ� �並 ��������.
--	�� ���� �̸��� MEMBER_19VIEW�� �ϼ���.
    CREATE OR REPLACE VIEW MEMBER_19VIEW 
    AS
    SELECT * FROM MEMBER
    WHERE AGE>=19
    WITH READ ONLY;
    
    SELECT * FROM MEMBER_19VIEW ORDER BY AGE;
    UPDATE MEMBER SET AGE=17 WHERE USERID='id1';
    SELECT * FROM MEMBER;
    ROLLBACK;
    SELECT * FROM MEMBER_19VIEW;
     
     UPDATE MEMBER_19VIEW SET MILEAGE=MILEAGE+500 WHERE USERID='id3';
     -- => cannot perform a DML operation on a read-only view

-- ī�װ�, ��ǰ, ���޾�ü�� JOIN�� �並 ���弼��
-- ���̸� : PROD_VIEW
    CREATE VIEW PROD_VIEW
    AS
    SELECT * FROM CATEGORY C JOIN PRODUCTS P
    ON C.CATEGORY_CODE = P.CATEGORY_FK
    JOIN SUPPLY_COMP S
    ON S.EP_CODE = P.EP_CODE_FK;
    
    SELECT CATEGORY_NAME, PRODUCTS_NAME, EP_NAME FROM PROD_VIEW;
    -- => JOIN������ ������ ��� �б� �������θ� ��� ����

--# WITH CHECK OPTION
-- WHERE���� ������ �����ϰ� �����ϵ��� ������
CREATE OR REPLACE VIEW EMP20VW
AS 
SELECT * FROM EMP
WHERE DEPTNO=20
WITH CHECK OPTION CONSTRAINT EMP20VW_CK;

SELECT * FROM EMP20VW;

UPDATE EMP20VW SET SAL=SAL+500 WHERE EMPNO=7369;

UPDATE EMP20VW SET DEPTNO=30 WHERE EMPNO=7369;
-- => ORA-01402: view WITH CHECK OPTION where-clause violation
--# ������ ���� ��ȸ
--USER_VIEWS
--USER_OBJECTS
SELECT TEXT FROM USER_VIEWS WHERE VIEW_NAME='EMP20VW';
SELECT * FROM USER_OBJECTS WHERE OBJECT_NAME='EMP20VW';

--#VIEW ����
DROP VIEW EMP20VW;
SELECT * FROM USER_VIEWS;
----------------------------------
--#INDEX
--CREATE [UNIQUE]INDEX �ε����� ON ���̺�� (�÷���)
CREATE INDEX EMP_ENAME_INDEX ON EMP(ENAME); --NON-UNIQUE

--������ �������� ��ȸ
---USER_OBJECTS
---USER_INDEXES
---USER_IND_COLUMNS

SELECT * FROM USER_OBJECTS 
WHERE OBJECT_TYPE='INDEX'AND OBJECT_NAME='EMP_ENAME_INDEX'; -- ���� �빮�ڷ� ����

SELECT * FROM USER_INDEXES
WHERE TABLE_NAME='EMP';

--�����̺��� NAME�� �ε����� �����ϼ���
CREATE INDEX MEMBER_NAME_INDEX ON MEMBER(NAME);

SELECT * FROM USER_INDEXES
WHERE TABLE_NAME='MEMBER';

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME='MEMBER';

SELECT * FROM MEMBER
WHERE NAME LIKE'%�浿%';

--��ǰ ���̺��� �ε����� �ɾ�θ� ���� �÷��� ã�� �ε����� ���弼��.
    -- CATEGORY_FK, EP_CODE_FK
    CREATE INDEX PRODUCTS_INDX1 ON PRODUCTS(CATEGORY_FK);
    CREATE INDEX PRODUCTS_INDX2 ON PRODUCTS(EP_CODE_FK);
    
    SELECT * FROM USER_IND_COLUMNS
    WHERE TABLE_NAME='PRODUCTS';
    
--#�ε��� ������ ���� => �����ϰ� �ٽ� ����

--#�ε��� ����
--DROP INDEX �ε�����;
--MEMBER_NAME_INDEX�� �����ϼ���
    DROP INDEX MEMBER_NAME_INDEX;
    
    SELECT * FROM USER_INDEXES
    WHERE TABLE_NAME='MEMBER';

--#SYNONYM - ���Ǿ�
-- ����Ŭ ��ü(���̺�,��,������,���ν���..) �� ���� ��Ī(ALIAS)
--��ü�� ���� ������ �ǹ�
--CREATE SYNONYM ���Ǿ��̸� FOR ��ü��(��Ű��.���̺��);

--������ �������� ��ȸ
SELECT * FROM USER_OBJECTS
WHERE OBJECT_TYPE='SYNONYM';

--���Ǿ� ����
--DROP SYNONYM ���Ǿ��;
DROP SYNONYM A;

SELECT * FROM A; --table or view does not exist
SELECT * FROM MYSTAR.NOTE;
----------------------------------
--#���ν��� - CRUD

--#DB���� - ���伳��/������/��������, ����ȭ


