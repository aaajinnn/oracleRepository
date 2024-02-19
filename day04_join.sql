-- day04_join.sql


--  DEPT와 EMP를 JOIN
-- [1] EQUI JOIN(INNER JOIN)

--<1> OLD VERSION

SELECT EMP.DEPTNO, DNAME,EMPNO, ENAME, JOB
FROM DEPT, EMP
WHERE DEPT.DEPTNO = EMP.DEPTNO
ORDER BY EMP.DEPTNO ASC;

--<2> NEW VERSION - 명시적 JOIN절 이용(표준 SQL)

SELECT D.*, E.*
FROM DEPT D LEFT OUTER JOIN EMP E
ON D.DEPTNO = E.DEPTNO
ORDER BY D.DEPTNO;

--[실습]
    --SALESMAN의 사원번호,이름,급여,부서명,근무지를 출력하여라.
    SELECT * FROM DEPT;
    SELECT D.DEPTNO, E.ENAME, E.SAL, D.DNAME, D.LOC
    FROM EMP E JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    WHERE E.JOB ='SALESMAN';
    
    --서로 연관이 있는 카테고리 테이블과 상품 테이블을 이용하여 각 상품별로 카테고리
    --이름과 상품 이름을 함께 보여주세요.
    SELECT C.CATEGORY_NAME, P.PRODUCTS_NAME, P.OUTPUT_PRICE
    FROM CATEGORY C JOIN PRODUCTS P
    ON C.CATEGORY_CODE = P.CATEGORY_FK
    ORDER BY C.CATEGORY_CODE;
   
    --카테고리 테이블과 상품 테이블을 조인하여 화면에 출력하되 상품의 정보 중
    --제조업체(COMPANY)가 삼성인 상품의 정보만 추출하여 
    --카테고리 이름과 상품이름, 상품가격, 제조사 등의 정보를 화면에 보여주세요.
    SELECT C.CATEGORY_NAME, P.OUTPUT_PRICE, P.COMPANY
    FROM CATEGORY C LEFT OUTER JOIN PRODUCTS P
    ON C.CATEGORY_CODE = P.CATEGORY_FK
    WHERE P.COMPANY = '삼성';
    
    --각 상품별로 카테고리 및 상품명, 가격을 출력하세요. 단 카테고리가 'TV'인 것은 
    --제외하고 나머지 정보는 상품의 가격이 저렴한 순으로 정렬하세요.
    SELECT C.CATEGORY_NAME, P.PRODUCTS_NAME, P.OUTPUT_PRICE
    FROM CATEGORY C LEFT OUTER JOIN PRODUCTS P
    ON C.CATEGORY_CODE = P.CATEGORY_FK
    WHERE C.CATEGORY_NAME <> 'TV'
    ORDER BY P.OUTPUT_PRICE ASC;
    
--[2] NON-EQUI JOIN
-- '='가 아닌 연산기호를 사용하여 조인하는 경우
SELECT * FROM SALGRADE;
SELECT * FROM EMP;

-- 사원정보를 보여주되 사번,이름,업무,급여, 
-- 급여 등급, 급여등급의 최저구간, 급여등급의 최고구간을 함께 보여주세요
SELECT EMPNO, ENAME, JOB, SAL, GRADE, HISAL, LOSAL
FROM EMP E JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL
ORDER BY SAL DESC;

--[3] OUTER JOIN
-- 한쪽 테이블에 일치하는 행이 없으면 다른쪽 테이블을 NULL로 하여 값을 보여줌
-- +기호가 붙은 테이블이 NULL로 표시

--<1>OLD VERSION
    SELECT D.*, ENAME, E.DEPTNO, SAL
    FROM DEPT D, EMP E
    WHERE D.DEPTNO = E.DEPTNO(+)
    ORDER BY 1;

--<2>LEFT OUTER JOIN/RIGHT OUTER JOIN/ FULL OUTER JOIN
    -- LEFT OUTER JOIN
    SELECT D.DEPTNO, DNAME, ENAME, E.DEPTNO, SAL
    FROM DEPT D LEFT OUTER JOIN EMP E
    ON D.DEPTNO = E.DEPTNO
    ORDER BY 1;
    
    -- RIGHT OUTER JOIN
    SELECT DISTINCT(E.DEPTNO), D.DEPTNO
    FROM EMP E RIGHT OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    ORDER BY 1;
    
    -- FULL OUTER JOIN
    SELECT DISTINCT(E.DEPTNO), D.DEPTNO
    FROM EMP E FULL OUTER JOIN DEPT D
    ON E.DEPTNO = D.DEPTNO
    ORDER BY 1;
    
--문제98] 상품테이블의 모든 상품을 공급업체, 공급업체코드, 상품이름, 
--      상품공급가, 상품 판매가 순서로 출력하되 공급업체가 없는
--      상품도 출력하세요(상품을 기준으로).
SELECT * FROM supply_comp;
SELECT s.ep_name, s.ep_code, p.products_name, p.input_price, p.output_price
FROM PRODUCTS P LEFT OUTER JOIN SUPPLY_COMP S
ON p.ep_code_fk = s.ep_code
ORDER BY 1;

SELECT ep_name, ep_code, products_name, input_price, output_price
FROM PRODUCTS P , SUPPLY_COMP S
WHERE P.EP_CODE_FK = s.ep_code
ORDER BY 1;

--	문제99] 상품테이블의 모든 상품을 공급업체, 카테고리명, 상품명, 상품판매가
--		순서로 출력하세요. 단, 공급업체나 상품 카테고리가 없는 상품도
--		출력합니다.
SELECT * FROM CATEGORY;
SELECT * FROM PRODUCTS;
SELECT * FROM supply_comp;

SELECT EP_NAME, CATEGORY_NAME,PRODUCTS_NAME, OUTPUT_PRICE
FROM SUPPLY_COMP S RIGHT OUTER JOIN PRODUCTS P
ON S.EP_CODE = P.EP_CODE_FK
LEFT OUTER JOIN CATEGORY C
ON c.category_code = p.category_fk;

--[4]SELF JOIN
-- 자기 자신의 테이블과 JOIN하는 경우
SELECT * FROM EMP;
SELECT E.EMPNO, E.ENAME, E.MGR "MGR NO", M.ENAME "MGR NAME"
FROM EMP E JOIN EMP M
ON E.MGR = M.EMPNO;

--[문제] emp테이블에서 "누구의 관리자는 누구이다"는 내용을 출력하세요.
    SELECT E.ENAME ||'의 관리자는 '|| M.ENAME ||'이다'
    FROM EMP E JOIN EMP M
    ON E.MGR = M.EMPNO
    ORDER BY 1;

--[5] CARTIESIAN PRODUCT (CROSS JOIN)
-- 모든 행들의 결합 ==> 불필요한 데이터가 나옴
-- 조인 조건을 생략한 경우
-- 조인 조건이 잘못된 경우

SELECT D.DEPTNO,DNAME, E.DEPTNO, ENAME
FROM DEPT D, EMP E
ORDER BY 1, 3;
-- => DEPT 4개 행 *  EMP 14개 행 ==> 56개의 행 출력

--[6] 집합 연산자 - SET OPERATOR
--      SELECT 컬럼명1,... FROM TABLE1
--      집합 연산자(UNION, INTERSECT, MINUS)
--      SELECT 컬럼명1,... FROM TABLE2;

--<1> UNOIN / UNION ALL : 합집합
    -- UNION : 중복되는 값은 한번만 출력
    SELECT DEPTNO FROM DEPT
    UNION
    SELECT DEPTNO FROM EMP;
    
    -- UNION ALL : 모든 값들의 합집합
    SELECT DEPTNO FROM DEPT
    UNION ALL
    SELECT DEPTNO FROM EMP;
    -- => DEPT의 4개 + EMP 14개 ==> 18개 행 출력
    
--<2>교집합(INTERSECT)
SELECT DEPTNO FROM DEPT
INTERSECT
SELECT DEPTNO FROM EMP;

--<3>차집합 (MINUS)
SELECT DEPTNO FROM DEPT
MINUS
SELECT DEPTNO FROM EMP;

--[문제]
--
---  emp테이블에서 NEW YORK에서 근무하고 있는 사원에 대하여 이름,업무,급여,
--    부서명을 출력하는 SELECT문을 작성하세요.
SELECT ENAME, JOB, SAL, DNAME
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE LOC = 'NEW YORK';
--- EMP테이블에서 보너스를 받는 사원에 대하여 이름,부서명,위치를 출력하는
--    SELECT문을 작성하세요.
SELECT ENAME, DNAME, LOC, COMM
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE COMM IS NOT NULL
ORDER BY 4;
--- EMP테이블에서 이름 중 L자가 있는 사원에 대해 이름,업무,부서명,위치를 
--   출력하는 문장을 작성하세요.
SELECT ENAME, JOB, DNAME, LOC
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE ENAME LIKE '%L%';
--- 아래의 결과를 출력하는 문장을 작성하에요(관리자가 없는 King을 포함하여
--	모든 사원을 출력)
--
--	---------------------------------------------
--	Emplyee		Emp#		Manager	Mgr#
--	---------------------------------------------
--	KING		7839
--	BLAKE		7698		KING		7839
--	CKARK		7782		KING		7839
--	.....
--	---------------------------------------------
--	14ROWS SELECTED.
SELECT E.ENAME AS Emplyee, E.EMPNO AS Emp#,
NVL(M.ENAME, ' ') AS Manager, NVL(TO_CHAR(M.EMPNO), ' ') AS Mgr#
FROM EMP E LEFT OUTER JOIN EMP M
ON E.MGR = M.EMPNO
ORDER BY 3;