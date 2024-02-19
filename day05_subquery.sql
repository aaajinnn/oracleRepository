--day05_subquery.sql


-- [1] 단일행 서브쿼리
-- 단일행 서브쿼리 => 반환되는 결과가 하나의 행
-- 비교연산자 사용 가능
-- 사원테이블에서 scott의 급여보다 많은 사원의 사번, 이름, 업무, 급여를 출력하세요
SELECT SAL FROM EMP
WHERE ENAME='SCOTT';

SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE SAL >(SELECT SAL 
            FROM EMP
            WHERE ENAME='SCOTT');        

--문제2]사원테이블에서 급여의 평균보다 적은 사원의 사번,이름 업무,급여,부서번호를 출력하세요.
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE SAL <(SELECT AVG(SAL) FROM EMP); 

--[문제 3]사원테이블에서 사원의 급여가 20번 부서의 최소급여보다 많은 부서를 출력하세요.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 20);

SELECT DEPTNO, MIN(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING MIN(SAL) > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO = 20);

--[2] 다중행 서브쿼리
-- 한개 이상의 행을 반환하는 서브쿼리
-- 다중행 서브쿼리 연산자가 별도로 있다.(등호 사용 불가)
--  <1> IN
--  <2> ANY
--  <3> ALL
--  <4> EXISTS

--<1> IN 연산자
-- 업무별로 최대 급여를 받는 사원의 사원번호와 이름을 출력하세요.
    SELECT EMPNO, ENAME, JOB
    FROM EMP
    WHERE (JOB,SAL) IN(SELECT JOB,MAX(SAL)
                    FROM EMP
                    GROUP BY JOB);
                    -- => 다중행 서브쿼리는 칼럼 수를 맞춰야만 한다.

--<2> ANY 연산자 : 서브쿼리 결과 값 중 어느 하나값이라도 만족하면 결과값 반환
    SELECT ENAME, SAL, DEPTNO FROM EMP
    WHERE DEPTNO <> 20 
    AND SAL > ANY(SELECT SAL FROM EMP WHERE JOB='SALESMAN');
-- => 단일행 서브쿼리로 바꿔보면
    SELECT ENAME, SAL FROM EMP
    WHERE DEPTNO <> 20 
    AND SAL > (SELECT MIN(SAL) FROM EMP WHERE JOB='SALESMAN');

--<3> ALL 연산자 : 서브쿼리 결과 값 중 모든 결과값이 만족되어야 결과값 반환
    SELECT ENAME, SAL , DEPTNO FROM EMP
    WHERE DEPTNO <> 20 
    AND SAL > ALL(SELECT SAL FROM EMP WHERE JOB='SALESMAN');
    -- => 단일행 서브쿼리로 바꿔보면
    SELECT ENAME, SAL , DEPTNO FROM EMP
    WHERE DEPTNO <> 20 
    AND SAL > (SELECT MAX(SAL) FROM EMP WHERE JOB='SALESMAN');

--<4> EXISTS 연산자 : 서브쿼리 결과 데이터가 존재하는지 여부를 따져서 존재하는 값들만 결과로 반환
-- 예제)사원을 관리할 수 있는 사원의 정보를 보여 줍니다.
    SELECT EMPNO, ENAME, JOB
    FROM EMP E
    WHERE EXISTS (SELECT EMPNO
                    FROM EMP
                    WHERE E.EMPNO = MGR); 
                    
-- [3] 다중열 서브쿼리
-- 실습] 업무별로 최소 급여를 받는 사원의 사번,이름,업무,부서번호를
--	출력하세요. 단 업무별로 정렬하세요.
SELECT EMPNO, ENAME, JOB, DEPTNO, SAL
FROM EMP
WHERE (JOB, SAL) IN (
    SELECT JOB, MIN(SAL)
    FROM EMP
    GROUP BY JOB)
ORDER BY JOB;

--# 1. SELECT문에서 서브쿼리
--84] 고객 테이블에 있는 고객 정보 중 마일리지가 
--	가장 높은 금액의 고객 정보를 보여주세요.
    SELECT *
    FROM MEMBER
    WHERE MILEAGE = (SELECT MAX(MILEAGE) FROM MEMBER);
--	85] 상품 테이블에 있는 전체 상품 정보 중 상품의 판매가격이 
--	    판매가격의 평균보다 큰  상품의 목록을 보여주세요. 
--	    단, 평균을 구할 때와 결과를 보여줄 때의 판매 가격이
--	    50만원을 넘어가는 상품은 제외시키세요.
    SELECT *
    FROM PRODUCTS
    WHERE OUTPUT_PRICE < 500000
    AND OUTPUT_PRICE > (SELECT AVG(OUTPUT_PRICE)
                            FROM PRODUCTS
                            WHERE OUTPUT_PRICE < 500000
                           );
--	86] 상품 테이블에 있는 판매가격에서 평균가격 이상의 상품 목록을 구하되 평균을
--	    구할 때 판매가격이 최대인 상품을 제외하고 평균을 구하세요.
   SELECT *
   FROM PRODUCTS
   WHERE OUTPUT_PRICE >= (SELECT AVG(OUTPUT_PRICE)
                     FROM PRODUCTS
                     WHERE OUTPUT_PRICE < (SELECT MAX(OUTPUT_PRICE) FROM PRODUCTS )
                     );

--# 2. UPDATE문에서 서브쿼리
--89] 고객 테이블에 있는 고객 정보 중 마일리지가 가장 높은 금액을
--	     가지는 고객에게 보너스 마일리지 5000점을 더 주는 SQL을 작성하세요.
SELECT MAX(MILEAGE)
FROM MEMBER;
UPDATE MEMBER SET MILEAGE = MILEAGE+5000
WHERE MILEAGE = (SELECT MAX(MILEAGE)
        FROM MEMBER);
SELECT * FROM MEMBER;
ROLLBACK;
--90] 고객 테이블에서 마일리지가 없는 고객의 등록일자를 고객 테이블의 
--	      등록일자 중 가장 뒤에 등록한 날짜에 속하는 값으로 수정하세요.
UPDATE MEMBER SET REG_DATE=(SELECT MAX(REG_DATE) FROM MEMBER) WHERE MILEAGE=0;
SELECT * FROM MEMBER;
ROLLBACK;
--# 3. DELETE문에서 서브쿼리
--91] 상품 테이블에 있는 상품 정보 중 공급가가 가장 큰 상품은 삭제 시키는 
--	      SQL문을 작성하세요.
SELECT * FROM PRODUCTS;
DELETE FROM PRODUCTS WHERE INPUT_PRICE=(SELECT MAX(INPUT_PRICE) FROM PRODUCTS);
ROLLBACK;
--	92] 상품 테이블에서 상품 목록을 공급 업체별로 정리한 뒤,
--	     각 공급업체별로 최소 판매 가격을 가진 상품을 삭제하세요.
SELECT * FROM PRODUCTS;
DELETE FROM PRODUCTS 
WHERE (EP_CODE_FK, OUTPUT_PRICE) IN (
        SELECT EP_CODE_FK, MIN(OUTPUT_PRICE)
        FROM PRODUCTS  
        GROUP BY EP_CODE_FK);                         
ROLLBACK;