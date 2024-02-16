--day03_�Լ�.sql
--#������ �Լ�
--[1] ������ �Լ�
--[2] ������ �Լ�
--[3] ��¥�� �Լ�
--[4] ��ȯ �Լ�
--[5] ��Ÿ �Լ�

--#[1] ������ �Լ�--------------------------------------------------------
--<1> Lower() / Upper() => �ҹ���/�빮�ڷ� ��ȯ
-- ����Ŭ�� FROM�� ������ �;ߵ����� MySQL�� ��� ���� ���´�.
SELECT * FROM DUAL; -- DUAL : �Ѱ��� ������ ������ �������̺�, ������ ���� ����� ���� �� ���
SELECT LOWER('HAPPY BIRTHDAY') FROM DUAL; 
SELECT UPPER('how are you?') FROM DUAL;

--<2> INITCAP() => ù ���ڸ� �빮��, �������� �ҹ���
SELECT DEPTNO,INITCAP(DNAME), INITCAP(LOC) FROM DEPT;

--<3> CONCAT(�÷�1, �÷�2) => �÷�1�� �÷�2�� ����
SELECT CONCAT('ABCD','1234') FROM DUAL;
SELECT CONCAT(EMPNO, ENAME) A FROM EMP;

--<4> SUBSTR(���� �Ǵ� �÷�, X, Y) 
-- => ���� X�� ������ Y���� ���� ���̸�ŭ ���
-- => X�� 0�̶�� 1�� ó��, X�� ������� ���� ������ ����
SELECT SUBSTR('ABCDEFG',3,2) FROM DUAL; -- 3��° ���ڿ��� 2�� ���
SELECT SUBSTR('ABCDEFG',-3,2) FROM DUAL;
SELECT SUBSTR('990215-101234',-6, 6) FROM DUAL;

--<5> LENGTH(���� �Ǵ� �÷�) =? ���ڿ� ���� ��ȯ
SELECT LENGTH('990215-101234') FROM DUAL;

--[����]---------------------------------------------------
--��ǰ ���̺��� �ǸŰ��� ȭ�鿡 ������ �� �ݾ��� ������ �Բ� �ٿ��� ����ϼ���.
SELECT CONCAT(OUTPUT_PRICE,'��'), OUTPUT_PRICE||'��' FROM PRODUCTS;
--�����̺��� �� �̸��� ���̸� �ϳ��� �÷����� ����� ������� ȭ�鿡 �����ּ���.
SELECT CONCAT(NAME, AGE) FROM MEMBER;      
--��� ���̺��� ù���ڰ� 'K'���� ũ�� 'Y'���� ���� �����
--���,�̸�,����,�޿��� ����ϼ���. �� �̸������� �����ϼ���. 
SELECT EMPNO, ENAME, JOB, SAL 
FROM EMP
WHERE SUBSTR(ENAME,1,1) > 'K' AND SUBSTR(ENAME,1,1) < 'Y'
ORDER BY ENAME;
--������̺��� �μ��� 20���� ����� ���,�̸�,�̸��ڸ���,�޿�,�޿��� �ڸ����� ����ϼ���.
SELECT EMPNO, ENAME, LENGTH(ENAME), SAL, LENGTH(SAL)
FROM EMP
WHERE DEPTNO=20;
--������̺��� ����̸� �� 6�ڸ� �̻��� �����ϴ� ������̸��� �̸��ڸ����� �����ּ���.
SELECT ENAME, LENGTH(ENAME)
FROM EMP
WHERE LENGTH(ENAME) >=6;
----------------------------------------------------------

--<6> LPAD(�÷�, N, C) / RPAD(�÷�, N, C) => ���ڰ��� ����/�����ʺ��� ä��
SELECT ENAME, LPAD(ENAME, 15, ' ') FROM EMP; -- ���ڸ� ������ ���ķ�
SELECT ENAME, SAL, LPAD(CONCAT('$',SAL),10,' ') "�޿�" FROM EMP;
SELECT RPAD(DNAME, 15, '@') FROM DEPT;

--<7> LTRIM(����,����) / RTRIM(����,����) 
-- => ������ �� �־��� ���ڿ� ���� �ܾ ���� ��� �� ���ڸ� ������ �������� ��ȯ
SELECT LTRIM('tttHELLO test','t'), RTRIM('tttHELLO test','t') FROM DUAL;
-- ���� ������ �� ���� ���
SELECT '    ������ ����    ', LENGTH('    ������ ����    ') FROM DUAL;
SELECT RTRIM(LTRIM('    ������ ����    ',' '),' ') TITLE, LENGTH(RTRIM(LTRIM('    ������ ����    '))) FROM DUAL;
SELECT TRIM('    ������ ����    ') FROM DUAL; -- �� ���� ���鹮�� ����

--<8> REPLACE(�÷�, ��1, ��2) 
-- => �÷��� �߿� ��1�� ������ ��2�� ��ü
SELECT JOB, REPLACE(JOB,'A','$') FROM EMP;

--[����]---------------------------------------- 
--�� ���̺��� ������ �ش��ϴ� �÷����� ���� ������ �л��� ������ ���
--���л����� ������ ��µǰ� �ϼ���.
SELECT JOB, REPLACE(JOB,'�л�','���л�') FROM MEMBER;
--�� ���̺� �ּҿ��� ����ø� ����Ư���÷� �����ϼ���.
SELECT ADDR, REPLACE(ADDR, '�����','����Ư����') FROM MEMBER;
UPDATE MEMBER SET ADDR=REPLACE(ADDR, '�����','����Ư����');
SELECT * FROM MEMBER;
ROLLBACK;
--������̺��� 10�� �μ��� ����� ���� ������ �� ������'T'��
--�����ϰ� �޿��� ������ 0�� �����Ͽ� ����ϼ���.
SELECT JOB, RTRIM(JOB,'T'), SAL ,RTRIM(SAL,0), DEPTNO 
FROM EMP 
WHERE DEPTNO=10;
------------------------------------------------- 

--#[2] ������ �Լ�--------------------------------------------------------
--<1>ROUND(��), ROUND(X, Y) : �ݿø� �Լ�
SELECT ROUND(456.678), ROUND(456.678,0), --�Ҽ��� ù°���� �ݿø�
ROUND(456.678,2), -- �Ҽ��� ���� ��°�ڸ����� �ݿø�
ROUND(456.678,-2) -- �Ҽ��� ���� ��°�ڸ����� �ݿø�
FROM DUAL;

--<2>TRUNC(��), TRUNK(X,Y) : ���� �Լ�. ����
SELECT TRUNC(456.678), TRUNC(456.678, 0),
TRUNC(456.678,2), TRUNC(456.678,-2)
FROM DUAL;

--<3> MOD(X,Y) : ���������� ���ϴ� �Լ�
SELECT MOD(10, 3) FROM DUAL;

--<4> ABS(��) : ���밪 ���ϴ� �Լ�
SELECT ABS(-9), ABS(9) FROM DUAL;

--<5> CEIL(��)/FLOOR(��) : �ø��Լ�/�����Լ�
SELECT CEIL(123.0001), FLOOR(123.0001) FROM DUAL;

--<6>CHR(��)/ASCII(��)
SELECT CHR(65), ASCII('F') FROM DUAL;

--[����]------------------------------------------------
--ȸ�� ���̺��� ȸ���� �̸�, ���ϸ���,����, ���ϸ����� ���̷� ���� ���� �ݿø��Ͽ� �����ּ���
SELECT * FROM MEMBER;
SELECT NAME, MILEAGE, AGE, ROUND(MILEAGE/AGE) FROM MEMBER;
--��ǰ ���̺��� ��ǰ ������� ����������� ���� ��ۺ� ���Ͽ� ����ϼ���.
SELECT * FROM PRODUCTS;
SELECT TRANS_COST, TRUNC(TRANS_COST,-3) FROM PRODUCTS;
--������̺��� �μ���ȣ�� 10�� ����� �޿��� 30���� ���� �������� ����ϼ���.
SELECT * FROM EMP;
SELECT SAL, MOD(SAL, 30) FROM EMP WHERE DEPTNO=10;
----------------------------------------------------------
SELECT NAME,AGE,ABS(AGE-40) FROM MEMBER;

--[3] ��¥ �Լ�-----------------------------------------------------------
SELECT SYSDATE, SYSDATE+3, SYSDATE-3, TO_CHAR(SYSDATE +3/24,'YY/MM/DD HH:MI:SS') FROM DUAL;
-- ORACLE�� ���� ǥ���� �� mm

--DATE +- ���� : �ϼ��� ���ϰų� ����.

--DATE-DATE : �ϼ�

SELECT NAME, REG_DATE, FLOOR(SYSDATE-REG_DATE) "��� ���� �ϼ�" FROM MEMBER;

--[�ǽ�]
--	������̺��� ��������� �ٹ� �ϼ��� �� �� �����ΰ��� ����ϼ���.
--	�� �ٹ��ϼ��� ���� ��������� ����ϼ���.
SELECT ENAME, TRUNC((SYSDATE-HIREDATE)/7) WEEKS, TRUNC(MOD(SYSDATE-HIREDATE, 7)) DAYS
FROM EMP
ORDER BY 2 DESC;

--<1> MONTHS_BETWEEN(date1, date2) : �� ��¥ ������ ������ ����
-- ���� �κ� => ��, �Ҽ��κ� => ��
SELECT ENAME, MONTHS_BETWEEN(SYSDATE, HIREDATE) 
FROM EMP 
ORDER BY 2 DESC;
SELECT NAME, REG_DATE, MONTHS_BETWEEN(SYSDATE, REG_DATE) 
FROM MEMBER;

--<2> ADD_MONTHS(DATE, M) : ���� ����
SELECT ADD_MONTHS(SYSDATE, 5)"5���� ��", ADD_MONTHS(SYSDATE, -3)"3���� ��" FROM DUAL;
SELECT ADD_MONTHS('22/01/31', 9) FROM DUAL;

--<3>LAST_DAY(DATE) : ���� ������ ��¥�� ���� <== �޷¸��鶧 ����ϱ� ����
SELECT LAST_DAY(SYSDATE), LAST_DAY('23-02-01') FROM DUAL;

--<4> SYSDATE, SYSTIMESTAMP
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD hh24:mi:ss') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'CC YEAR-MONTH-DDD DAY') FROM DUAL;

--[4]��ȯ�Լ� => ���� �����------------------------------------------
--<1> TO_CHAR(��¥)
--<2> TO_DATE(����)
--<3> TO_CHAR(����)
--<4> TO_NUMBER(����)

--[����]------------------------------------
--�����̺��� ������ڸ� 0000-00-00 �� ���·� ����ϼ���.
SELECT TO_CHAR(REG_DATE, 'YYYY-MM-DD') FROM MEMBER;
--�����̺� �ִ� �� ���� �� ��Ͽ����� 2023���� ���� ������ �����ּ���.
SELECT NAME, REG_DATE 
FROM MEMBER 
WHERE TO_CHAR(REG_DATE, 'YYYY')='2023';
--�����̺� �ִ� �� ���� �� ������ڰ� 2023�� 5��1�Ϻ��� ���� ������ ����ϼ���. 
--��, ����� ������ ��, ���� ���̵��� �մϴ�.
SELECT NAME, REG_DATE, TO_CHAR(REG_DATE,'YY/MM') 
FROM MEMBER 
WHERE REG_DATE>='23/05/01';
--------------------------------------------------------------------
--#TO_DATE(����,����) : ���ڿ��� DATE�������� ��ȯ�ϴ� �Լ�
-- SELECT '22-08-19' --�����ͺ��̽��� ���������� ��¥������ ������ �� ����
SELECT TO_DATE('22-08-19', 'YY-MM-DD') + 3 FROM DUAL;
SELECT SYSDATE - TO_DATE('20191107','YYYYMMDD') FROM DUAL;

--#TO_CHAR(����, ����)
SELECT TO_CHAR(1500000,'L9,999,999') FROM DUAL; -- L : ȭ�����

--[����]--------------------------------
--73] ��ǰ ���̺��� ��ǰ�� ���� �ݾ��� ���� ǥ�� ������� ǥ���ϼ���.
--	  õ�ڸ� ���� , �� ǥ���մϴ�
SELECT PRODUCTS_NAME, TO_CHAR(INPUT_PRICE,'9,999,999') ���ް� FROM PRODUCTS;
--  74] ��ǰ ���̺��� ��ǰ�� �ǸŰ��� ����ϵ� ��ȭ�� ǥ���� �� ����ϴ� �����
--	  ����Ͽ� ����ϼ���.[��: \10,000]
SELECT PRODUCTS_NAME, TO_CHAR(OUTPUT_PRICE,'l9,999,999') FROM PRODUCTS;
----------------------------------------
--#TO_NUMBER(����, ����) : CHAR, VARCHAR2�� ���ڷ� ��ȯ
SELECT TO_NUMBER('150,000','999,999')*2 FROM DUAL;
SELECT TO_NUMBER('$450.25','$999.99')*3 FROM DUAL;

SELECT TO_CHAR(-23, 'S99'),TO_CHAR(-23, '99S'), 
TO_CHAR(23,'99D99'), TO_CHAR(23,'99.99EEEE') 
FROM DUAL; -- S:��ȣ

--# �׷��Լ�------------------------------------------------------------------
-- ���� �� �Ǵ� ���̺� ��ü�� �Լ��� ����Ǿ� �ϳ��� ����� �������� �Լ�
--<1>COUNT(�÷���) : NULL���� �����ϰ� ī��Ʈ�� ����
--   COUNT(*) : NULL���� �����Ͽ� ī��Ʈ�� ����
SELECT * FROM EMP;
SELECT COUNT(MGR)"�����ڰ� �ִ� ��� ��", COUNT(COMM)"���ʽ��� �޴� ��� ��" FROM EMP;
SELECT COUNT(DISTINCT MGR)"�����ڼ�" FROM EMP;
SELECT COUNT(EMPNO) FROM EMP;
SELECT COUNT(*) FROM EMP;

CREATE TABLE TEST(
A NUMBER(2),
B CHAR(3),
C VARCHAR2(10)
);
DESC TEST;
SELECT COUNT(*) FROM TEST;
INSERT INTO TEST VALUES(NULL, NULL, NULL);
INSERT INTO TEST VALUES(NULL, NULL, NULL);
SELECT * FROM TEST;

SELECT COUNT(A) FROM TEST; --0
SELECT COUNT(*) FROM TEST; --2 (NULL ����)
COMMIT;
--[�ǽ�]------------------
--emp���̺��� ��� SALESMAN�� ���Ͽ� �޿��� ���,
--�ְ��,������,�հ踦 ���Ͽ� ����ϼ���.
SELECT * FROM EMP;
SELECT AVG(SAL), MAX(SAL), MIN(SAL), SUM(SAL)
FROM EMP 
WHERE JOB='SALESMAN';
--EMP���̺� ��ϵǾ� �ִ� �ο���, ���ʽ��� NULL�� �ƴ� �ο���,
--���ʽ��� ���,��ϵǾ� �ִ� �μ��� ���� ���Ͽ� ����ϼ���.
SELECT COUNT(*), COUNT(COMM), AVG(COMM),COUNT(DISTINCT DEPTNO) 
FROM EMP;
--------------------------

--��� : WGHO
--#GROUP BY ��
SELECT JOB, COUNT(*)
FROM MEMBER
GROUP BY JOB
ORDER BY COUNT(*) DESC;
--17] �� ���̺��� ������ ����, �� ������ ���� �ִ� ���ϸ��� ������ �����ּ���.
SELECT JOB , MAX(MILEAGE)
FROM MEMBER
GROUP BY JOB;
--18] ��ǰ ���̺��� �� ��ǰī�װ����� �� �� ���� ��ǰ�� �ִ��� �����ּ���.
SELECT CATEGORY_FK, COUNT(CATEGORY_FK)
FROM PRODUCTS
GROUP BY CATEGORY_FK
ORDER BY 1;
--19] ��ǰ ���̺��� �� ���޾�ü �ڵ庰�� ������ ��ǰ�� ����԰��� �����ּ���.
SELECT EP_CODE_FK, ROUND(AVG(INPUT_PRICE))
FROM PRODUCTS
GROUP BY EP_CODE_FK;
--����1] ��� ���̺��� �Ի��� �⵵���� ��� ���� �����ּ���.
SELECT TO_CHAR(HIREDATE,'YYYY'), COUNT(*)
FROM EMP
GROUP BY TO_CHAR(HIREDATE,'YYYY')
ORDER BY 1;
--	����2] ��� ���̺��� �ش�⵵ �� ������ �Ի��� ������� �����ּ���.
SELECT TO_CHAR(HIREDATE,'YYYY-MM'), COUNT(*)
FROM EMP
GROUP BY TO_CHAR(HIREDATE,'YYYY-MM')
ORDER BY 1;
--	����3] ��� ���̺��� ������ �ִ� ����, �ּ� ������ ����ϼ���.
SELECT JOB, MAX(SAL*12+NVL(COMM,0)), MIN(SAL*12+NVL(COMM,0))
FROM EMP
GROUP BY JOB;

--#HAVING ��
-- GROUP BY�� ������ �ְ��� �� �� ���
SELECT JOB, COUNT(*)
FROM MEMBER
GROUP BY JOB
HAVING COUNT(*) >= 2;

--21] �� ���̺��� ������ ������ �� ������ ���� �ִ� ���ϸ��� ������ �����ּ���.
--	      ��, �������� �ִ� ���ϸ����� 0�� ���� ���ܽ�ŵ�ô�. 
SELECT JOB, MAX(MILEAGE)
FROM MEMBER
GROUP BY JOB
HAVING MAX(MILEAGE) <> 0 ;
--����2] ��ǰ ���̺��� �� ���޾�ü �ڵ庰�� ��ǰ �ǸŰ��� ��հ� �� ������ 100������ ����
--	      ���� �׸��� ������ �����ּ���.
SELECT EP_CODE_FK, ROUND(AVG(OUTPUT_PRICE))
FROM PRODUCTS
GROUP BY EP_CODE_FK
HAVING MOD(ROUND(AVG(OUTPUT_PRICE)),100)=0;