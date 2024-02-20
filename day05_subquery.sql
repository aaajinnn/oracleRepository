--day05_subquery.sql


-- [1] ������ ��������
-- ������ �������� => ��ȯ�Ǵ� ����� �ϳ��� ��
-- �񱳿����� ��� ����
-- ������̺��� scott�� �޿����� ���� ����� ���, �̸�, ����, �޿��� ����ϼ���
SELECT SAL FROM EMP
WHERE ENAME='SCOTT';

SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE SAL >(SELECT SAL 
            FROM EMP
            WHERE ENAME='SCOTT');        

--����2]������̺��� �޿��� ��պ��� ���� ����� ���,�̸� ����,�޿�,�μ���ȣ�� ����ϼ���.
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE SAL <(SELECT AVG(SAL) FROM EMP); 

--[���� 3]������̺��� ����� �޿��� 20�� �μ��� �ּұ޿����� ���� �μ��� ����ϼ���.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 20);

SELECT DEPTNO, MIN(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING MIN(SAL) > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 20);

--[2] ������ ��������
-- �Ѱ� �̻��� ���� ��ȯ�ϴ� ��������
-- ������ �������� �����ڰ� ������ �ִ�.(��ȣ ��� �Ұ�)
--  <1> IN
--  <2> ANY
--  <3> ALL
--  <4> EXISTS

--<1> IN ������
-- �������� �ִ� �޿��� �޴� ����� �����ȣ�� �̸��� ����ϼ���.
    SELECT EMPNO, ENAME, JOB
    FROM EMP
    WHERE (JOB,SAL) IN(SELECT JOB,MAX(SAL)
                    FROM EMP
                    GROUP BY JOB);
                    -- => ������ ���������� Į�� ���� ����߸� �Ѵ�.

--<2> ANY ������ : �������� ��� �� �� ��� �ϳ����̶� �����ϸ� ����� ��ȯ
    SELECT ENAME, SAL, DEPTNO FROM EMP
    WHERE DEPTNO <> 20 
    AND SAL > ANY(SELECT SAL FROM EMP WHERE JOB='SALESMAN');
-- => ������ ���������� �ٲ㺸��
    SELECT ENAME, SAL FROM EMP
    WHERE DEPTNO <> 20 
    AND SAL > (SELECT MIN(SAL) FROM EMP WHERE JOB='SALESMAN');

--<3> ALL ������ : �������� ��� �� �� ��� ������� �����Ǿ�� ����� ��ȯ
    SELECT ENAME, SAL , DEPTNO FROM EMP
    WHERE DEPTNO <> 20 
    AND SAL > ALL(SELECT SAL FROM EMP WHERE JOB='SALESMAN');
    -- => ������ ���������� �ٲ㺸��
    SELECT ENAME, SAL , DEPTNO FROM EMP
    WHERE DEPTNO <> 20 
    AND SAL > (SELECT MAX(SAL) FROM EMP WHERE JOB='SALESMAN');

--<4> EXISTS ������ : �������� ��� �����Ͱ� �����ϴ��� ���θ� ������ �����ϴ� ���鸸 ����� ��ȯ
-- ����)����� ������ �� �ִ� ����� ������ ���� �ݴϴ�.
    SELECT EMPNO, ENAME, JOB
    FROM EMP E
    WHERE EXISTS (SELECT EMPNO
                    FROM EMP
                    WHERE E.EMPNO = MGR); 
                    
-- [3] ���߿� ��������
-- �ǽ�] �������� �ּ� �޿��� �޴� ����� ���,�̸�,����,�μ���ȣ��
--	����ϼ���. �� �������� �����ϼ���.
SELECT EMPNO, ENAME, JOB, DEPTNO, SAL
FROM EMP
WHERE (JOB, SAL) IN (
    SELECT JOB, MIN(SAL)
    FROM EMP
    GROUP BY JOB)
ORDER BY JOB;

--# 1. SELECT������ ��������
--84] �� ���̺� �ִ� �� ���� �� ���ϸ����� 
--	���� ���� �ݾ��� �� ������ �����ּ���.
    SELECT *
    FROM MEMBER
    WHERE MILEAGE = (SELECT MAX(MILEAGE) FROM MEMBER);
--	85] ��ǰ ���̺� �ִ� ��ü ��ǰ ���� �� ��ǰ�� �ǸŰ����� 
--	    �ǸŰ����� ��պ��� ū  ��ǰ�� ����� �����ּ���. 
--	    ��, ����� ���� ���� ����� ������ ���� �Ǹ� ������
--	    50������ �Ѿ�� ��ǰ�� ���ܽ�Ű����.
    SELECT *
    FROM PRODUCTS
    WHERE OUTPUT_PRICE < 500000
    AND OUTPUT_PRICE > (SELECT AVG(OUTPUT_PRICE)
                            FROM PRODUCTS
                            WHERE OUTPUT_PRICE < 500000
                           );
--	86] ��ǰ ���̺� �ִ� �ǸŰ��ݿ��� ��հ��� �̻��� ��ǰ ����� ���ϵ� �����
--	    ���� �� �ǸŰ����� �ִ��� ��ǰ�� �����ϰ� ����� ���ϼ���.
   SELECT *
   FROM PRODUCTS
   WHERE OUTPUT_PRICE >= (SELECT AVG(OUTPUT_PRICE)
                     FROM PRODUCTS
                     WHERE OUTPUT_PRICE < (SELECT MAX(OUTPUT_PRICE) FROM PRODUCTS )
                     );

--# 2. UPDATE������ ��������
--89] �� ���̺� �ִ� �� ���� �� ���ϸ����� ���� ���� �ݾ���
--	     ������ ������ ���ʽ� ���ϸ��� 5000���� �� �ִ� SQL�� �ۼ��ϼ���.
SELECT MAX(MILEAGE)
FROM MEMBER;
UPDATE MEMBER SET MILEAGE = MILEAGE+5000
WHERE MILEAGE = (SELECT MAX(MILEAGE)
        FROM MEMBER);
SELECT * FROM MEMBER;
ROLLBACK;
--90] �� ���̺��� ���ϸ����� ���� ���� ������ڸ� �� ���̺��� 
--	      ������� �� ���� �ڿ� ����� ��¥�� ���ϴ� ������ �����ϼ���.
UPDATE MEMBER SET REG_DATE=(SELECT MAX(REG_DATE) FROM MEMBER) WHERE MILEAGE=0;
SELECT * FROM MEMBER;
ROLLBACK;
--# 3. DELETE������ ��������
--91] ��ǰ ���̺� �ִ� ��ǰ ���� �� ���ް��� ���� ū ��ǰ�� ���� ��Ű�� 
--	      SQL���� �ۼ��ϼ���.
SELECT * FROM PRODUCTS;
DELETE FROM PRODUCTS WHERE INPUT_PRICE=(SELECT MAX(INPUT_PRICE) FROM PRODUCTS);
ROLLBACK;
--	92] ��ǰ ���̺��� ��ǰ ����� ���� ��ü���� ������ ��,
--	     �� ���޾�ü���� �ּ� �Ǹ� ������ ���� ��ǰ�� �����ϼ���.
SELECT * FROM PRODUCTS;
DELETE FROM PRODUCTS 
WHERE (EP_CODE_FK, OUTPUT_PRICE) IN (
        SELECT EP_CODE_FK, MIN(OUTPUT_PRICE)
        FROM PRODUCTS  
        GROUP BY EP_CODE_FK);                         
ROLLBACK;

-- # FROM ������ �������� (INLINE VIEW)
--[�ǽ�]
--	EMP�� DEPT ���̺��� ������ MANAGER�� ����� �̸�, ����,�μ���,
--	�ٹ����� ����ϼ���.
    -- JOIN���� ����� ���
    SELECT ENAME, JOB, DNAME, LOC
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = d.deptno
    WHERE JOB='MANAGER';
    
    -- ���������� �̿��� ���
    SELECT ENAME, JOB, DNAME, LOC 
    FROM
    (SELECT * FROM EMP WHERE JOB ='MANAGER') A JOIN DEPT D
    ON A.DEPTNO = D.DEPTNO;

-- ��Ÿ �Լ�
-- RANK() OVER(�м���)
-- : �м����� �������� ��ŷ�� �ű�� �Լ�
SELECT RANK() OVER(ORDER BY SAL DESC) RNK, EMP.*
FROM EMP;

-- �޿� ���� ���  TOP5�� �̾� ���
SELECT * FROM (
                SELECT RANK() OVER(ORDER BY SAL DESC) RNK, EMP.*
                FROM EMP
                ) A
 WHERE A.RNK<=5;

-- ROWNUM : ���ȣ ==> ���ȣ�� ���� �ű�� �׷� �� ORDER BY ��
SELECT ROWNUM RN,PRODUCTS.* FROM PRODUCTS ORDER BY PNUM DESC;

-- ������ �ѱ�� Ȱ��
-- ROWNUM�� ���ϱ� ���ؼ� ORDER BY�� ���� ���־�߸� �Ѵ�.
-- ==> ������ ���� �� ��, ���ȣ�� �ű���� �Ʒ��� ���� �������� ���
SELECT * FROM (
                SELECT ROWNUM RN, A.* FROM
                (SELECT * FROM PRODUCTS ORDER BY PNUM DESC) A
                )
WHERE RN BETWEEN 1 AND 5; 
    -- FRMO������ ����� ������ ��𼭵� ���� ������ SELECT������ ����� ������ ����� �� ����.
    
-- ROW NUMBER() OVER(�м���) : �м����� �������� ���ȣ�� �Ű��ش�.
SELECT * FROM (
                SELECT ROW_NUMBER() OVER(ORDER BY PNUM DESC) RN, PRODUCTS.*
                FROM PRODUCTS) A
WHERE RN BETWEEN 1 AND 5;


