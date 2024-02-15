--day02_select.sql
desc dept;
select * from dept;

desc emp;
select * from emp;

--���ǥ������ �����ϴ�.
select ename, job, sal, (sal+300)*2 as salup from  emp order by salup desc;

--[����]--------------------------------------------------
--[1] EMP���̺��� ���(EMPNO), �̸�(ENAME), �޿�(SAL), ���ʽ�(COMM)�� ������ 
--   �����ּ���
select empno, ename,job, sal, comm from emp;
--[2] ������̺��� �����, �޿�, �޿��� 10%�λ���� ������ �����ּ���
select ename, sal, sal+(sal*0.1) as salup, sal*1.1 as "10% �޿��λ��" from emp;
--[3]  ������̺��� �����, �޿�,���ʽ�, 1�� ������ ����� �����ּ���
--     1�� ����=�޿�*12 +���ʽ�(COMM)
select ename, sal, comm, (sal*12)+comm "1�� ����" from emp;
------------------------------------------------------------

--#NULL ó��
-- NULL�� ���������(+, -, * ��)�� �ϸ� ������ ���� null�� ���´�.
-- NVL(�÷���, ��) => �ش� �÷����� null�϶� ������ ��ȯ�ϴ� �Լ�
select ename, sal, comm, (sal*12)+nvl(comm,0) "1�� ����" from emp;
-- NVL2(�÷���, ��1, ��2) => �÷����� null�� �ƴϸ� ��1�� ��ȯ�ϰ�, null�̸� ��2�� ��ȯ�ϴ� �Լ�

--��� ���̺��� ������(MGR)�� �ִ� ���� 1, ������ 0�� ����Ͻÿ�
SELECT ename,mgr, nvl2(mgr,1,0) "������ ���� ����"
FROM emp;

--#���ڿ� ���� 
-- "SMITH IS A CLERK"
SELECT ENAME||' IS A '||JOB "EMPLOYEES DETAIL" FROM EMP;

--#DISTINCT : �ߺ��� ����
SELECT DISTINCT JOB FROM EMP;
-- �μ����� ����ϴ� ����
SELECT DISTINCT DEPTNO, JOB FROM EMP ORDER BY 1 ASC;

--[����]---------------------------------------------------
--	 1] EMP���̺��� �ߺ����� �ʴ� �μ���ȣ�� ����ϼ���.
SELECT DISTINCT DEPTNO FROM EMP ORDER BY 1 ASC;
--	 2] MEMBER���̺��� ȸ���� �̸��� ���� ������ �����ּ���.
SELECT NAME, AGE, JOB FROM MEMBER;
--	 3] CATEGORY ���̺� ����� ��� ������ �����ּ���.
SELECT * FROM CATEGORY;
--	 4] MEMBER���̺��� ȸ���� �̸��� ������ ���ϸ����� �����ֵ�,
--	      ���ϸ����� 13�� ���� ����� "MILE_UP"�̶�� ��Ī����
--	      �Բ� �����ּ���.
SELECT NAME, mileage,(mileage*13) "MILE_UP" FROM MEMBER;
--    5] EMP���̺��� �̸��� ������ "KING: 1 YEAR SALARY = 60000"
--	�������� ����϶�.
SELECT * FROM EMP;
SELECT ENAME, SAL, ENAME||' : 1 YEAR SALARY = '||SAL*12 "����" FROM EMP;
--------------------------------------------------------------

--#WHERE���� �̿��� Ư���� �˻�
--[����]------------------------------------------------------------------
--EMP���� �޿��� 3000�̻��� ����� ���,�̸� ����, �޿��� ����ϼ���
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE SAL>=3000;
--EMP���̺��� �������� MANAGER�� ����� ������ �����ȣ,�̸�,����,�޿�,�μ���ȣ�� ����ϼ���.
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP WHERE JOB=UPPER('manager'); -- manager�� �빮�ڷ�
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP WHERE LOWER(JOB)='manager'; -- JOB�� �ҹ��ڷ�
--EMP���̺��� 1982�� 1��1�� ���Ŀ� �Ի��� ����� �����ȣ,����,����,�޿�,�Ի����ڸ� ����ϼ���. (HIREDATE-�Ի���)
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE FROM EMP WHERE HIREDATE>='1982-01-01' ORDER BY HIREDATE;
--------------------------------------------------------------------------
--[�ǽ�]
--	[1] emp���̺��� �޿��� 1300���� 1500������ ����� �̸�,����,�޿�,
--	�μ���ȣ�� ����ϼ���
SELECT ENAME, JOB, SAL, DEPTNO FROM EMP WHERE SAL BETWEEN 1300 AND 1500; 
--  [2] emp���̺��� �����ȣ�� 7902,7788,7566�� ����� �����ȣ,
--	�̸�,����,�޿�,�Ի����ڸ� ����ϼ���.
SELECT ENAME, JOB, SAL, HIREDATE FROM EMP WHERE EMPNO IN(7902, 7788, 7566); 
--  [3] 10�� �μ��� �ƴ� ����� �̸�,����,�μ���ȣ�� ����ϼ���
SELECT ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO NOT IN 10; 
SELECT ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO != 10;
SELECT ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO <> 10 ORDER BY 3;
--[4] emp���̺��� ������ SALESMAN �̰ų� PRESIDENT��
--	����� �����ȣ,�̸�,����,�޿��� ����ϼ���.
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE JOB IN('SALESMAN', 'PRESIDENT');
--	[5] Ŀ�̼�(COMM)�� 300�̰ų� 500�̰ų� 1400�� ��������� ����ϼ���
SELECT * FROM EMP WHERE COMM IN(300, 400, 1400);
--	[6] Ŀ�̼��� 300,500,1400�� �ƴ� ����� ������ ����ϼ���
SELECT * FROM EMP WHERE COMM NOT IN(300, 400, 1400) ;
SELECT * FROM EMP WHERE NVL(COMM,0) NOT IN(300, 400, 1400) ;

SELECT *
FROM EMP
WHERE ENAME LIKE 'S%';
SELECT *
FROM EMP
WHERE ENAME LIKE '%S';
SELECT *
FROM EMP
WHERE ENAME LIKE '%S%';
SELECT *
FROM EMP
WHERE ENAME LIKE '_O%';

--[����]
-- �� ���̺� ��� ���� �达�� ����� ������ �����ּ���.
SELECT *
FROM MEMBER
WHERE NAME LIKE '��%';
-- �� ���̺� ��� '����'�� ���Ե� ������ �����ּ���.
SELECT *
FROM MEMBER
WHERE ADDR LIKE '%����%';
-- ī�װ� ���̺� ��� category_code�� 0000�� ���� ��ǰ������ �����ּ���.
SELECT *
FROM CATEGORY
WHERE category_code LIKE '%0000';
-- EMP���̺��� �Ի����ڰ� 82�⵵�� �Ի��� ����� ���,�̸�,����
-- �Ի����ڸ� ����ϼ���.
SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP
WHERE HIREDATE LIKE '82%';
--#��¥ ���� ����
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-YY';
ALTER SESSION SET NLS_DATE_FORMAT='YY/MM/DD';
SELECT ENAME, HIREDATE FROM EMP;

SELECT * FROM EMP WHERE COMM IS NULL;

--[����]
--EMP���̺��� �޿��� 1000�̻� 1500���ϰ� �ƴ� �����
SELECT * FROM EMP WHERE NOT(SAL>=1000 AND SAL<=1500);
SELECT * FROM EMP WHERE SAL NOT BETWEEN 1000 AND 1500;
--EMP���̺��� �̸��� 'S'�ڰ� ���� ���� ����� �̸��� ��� ����ϼ���.
SELECT ENAME FROM EMP WHERE ENAME NOT LIKE '%S%';
--������̺��� ������ PRESIDENT�̰� �޿��� 1500�̻��̰ų�
--������ SALESMAN�� ����� ���,�̸�,����,�޿��� ����ϼ���.
SELECT EMPNO, ENAME, JOB, SAL 
FROM EMP 
WHERE JOB='PRESIDENT' AND SAL>=1500 OR JOB='SALESMAN';
--�� ���̺��� �̸��� ȫ�浿�̸鼭 ������ �л��� ������ ��� �����ּ���.
SELECT * FROM MEMBER WHERE NAME='ȫ�浿' AND JOB='�л�';
--�� ���̺��� �̸��� ȫ�浿�̰ų� ������ �л��� ������ ��� �����ּ���.
SELECT * FROM MEMBER WHERE NAME='ȫ�浿' OR JOB='�л�'; 
--	- ��ǰ ���̺��� �����簡 S�� �Ǵ� D���̸鼭 
--	   �ǸŰ��� 100���� �̸��� ��ǰ ����� �����ּ���.
SELECT * FROM PRODUCTS WHERE (COMPANY='�Ｚ' OR COMPANY='���') AND OUTPUT_PRICE<1000000;

--#ORDER BY
SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP
ORDER BY HIREDATE DESC;
--��� ���̺��� �μ���ȣ�� ������ �� �μ���ȣ�� ���� ���
--�޿��� ���� ������ �����Ͽ� ���,�̸�,����,�μ���ȣ,�޿�������ϼ���.
SELECT EMPNO, ENAME, JOB, DEPTNO, SAL
FROM EMP
ORDER BY DEPTNO ASC, SAL DESC;
--��� ���̺��� ù��° ������ �μ���ȣ��, �ι�° ������ ������, ����° ������ �޿��� ���� ������ �����Ͽ�
--���,�̸�,�Ի�����,�μ���ȣ,����,�޿��� ����ϼ���.
SELECT EMPNO, ENAME, HIREDATE, DEPTNO, JOB, SAL
FROM EMP
ORDER BY EMPNO, JOB, SAL DESC;
--��ǰ ���̺��� ��ۺ��� ������������ �����ϵ�, 
--���� ��ۺ� �ִ� ��쿡�� ���ϸ����� ������������ �����Ͽ� �����ּ���.
SELECT *
FROM PRODUCTS
ORDER BY TRANS_COST DESC, mileage DESC;