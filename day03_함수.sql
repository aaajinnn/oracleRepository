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