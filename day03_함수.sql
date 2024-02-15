--day03_함수.sql
--#단일행 함수
--[1] 문자형 함수
--[2] 숫자형 함수
--[3] 날짜형 함수
--[4] 변환 함수
--[5] 기타 함수

--#[1] 문자형 함수--------------------------------------------------------
--<1> Lower() / Upper() => 소문자/대문자로 변환
-- 오라클은 FROM에 무조건 와야되지만 MySQL은 없어도 값이 나온다.
SELECT * FROM DUAL; -- DUAL : 한개의 행으로 구성된 더미테이블, 간단한 연산 결과를 얻을 때 사용
SELECT LOWER('HAPPY BIRTHDAY') FROM DUAL; 
SELECT UPPER('how are you?') FROM DUAL;

--<2> INITCAP() => 첫 문자만 대문자, 나머지는 소문자
SELECT DEPTNO,INITCAP(DNAME), INITCAP(LOC) FROM DEPT;

--<3> CONCAT(컬럼1, 컬럼2) => 컬럼1과 컬럼2를 연결
SELECT CONCAT('ABCD','1234') FROM DUAL;
SELECT CONCAT(EMPNO, ENAME) A FROM EMP;

--<4> SUBSTR(변수 또는 컬럼, X, Y) 
-- => 문자 X로 시작한 Y개의 문자 길이만큼 출력
-- => X가 0이라면 1로 처리, X가 음수라면 문자 끝에서 시작
SELECT SUBSTR('ABCDEFG',3,2) FROM DUAL; -- 3번째 문자에서 2개 출력
SELECT SUBSTR('ABCDEFG',-3,2) FROM DUAL;
SELECT SUBSTR('990215-101234',-6, 6) FROM DUAL;

--<5> LENGTH(변수 또는 컬럼) =? 문자열 길이 반환
SELECT LENGTH('990215-101234') FROM DUAL;

--[문제]---------------------------------------------------
--상품 테이블에서 판매가를 화면에 보여줄 때 금액의 단위를 함께 붙여서 출력하세요.
SELECT CONCAT(OUTPUT_PRICE,'원'), OUTPUT_PRICE||'원' FROM PRODUCTS;
--고객테이블에서 고객 이름과 나이를 하나의 컬럼으로 만들어 결과값을 화면에 보여주세요.
SELECT CONCAT(NAME, AGE) FROM MEMBER;      
--사원 테이블에서 첫글자가 'K'보다 크고 'Y'보다 작은 사원의
--사번,이름,업무,급여를 출력하세요. 단 이름순으로 정렬하세요. 
SELECT EMPNO, ENAME, JOB, SAL 
FROM EMP
WHERE SUBSTR(ENAME,1,1) > 'K' AND SUBSTR(ENAME,1,1) < 'Y'
ORDER BY ENAME;
--사원테이블에서 부서가 20번인 사원의 사번,이름,이름자릿수,급여,급여의 자릿수를 출력하세요.
SELECT EMPNO, ENAME, LENGTH(ENAME), SAL, LENGTH(SAL)
FROM EMP
WHERE DEPTNO=20;
--사원테이블의 사원이름 중 6자리 이상을 차지하는 사원의이름과 이름자릿수를 보여주세요.
SELECT ENAME, LENGTH(ENAME)
FROM EMP
WHERE LENGTH(ENAME) >=6;
----------------------------------------------------------

--<6> LPAD(컬럼, N, C) / RPAD(컬럼, N, C) => 문자값을 왼쪽/오른쪽부터 채움
SELECT ENAME, LPAD(ENAME, 15, ' ') FROM EMP; -- 문자를 오른쪽 정렬로
SELECT ENAME, SAL, LPAD(CONCAT('$',SAL),10,' ') "급여" FROM EMP;
SELECT RPAD(DNAME, 15, '@') FROM DEPT;

--<7> LTRIM(변수,문자) / RTRIM(변수,문자) 
-- => 변수값 중 주어진 문자와 같은 단어가 있을 경우 그 문자를 삭제한 나머지값 반환
SELECT LTRIM('tttHELLO test','t'), RTRIM('tttHELLO test','t') FROM DUAL;
-- 공백 제거할 때 많이 사용
SELECT '    오늘의 날씨    ', LENGTH('    오늘의 날씨    ') FROM DUAL;
SELECT RTRIM(LTRIM('    오늘의 날씨    ',' '),' ') TITLE, LENGTH(RTRIM(LTRIM('    오늘의 날씨    '))) FROM DUAL;
SELECT TRIM('    오늘의 날씨    ') FROM DUAL; -- 앞 뒤의 공백문자 제거

--<8> REPLACE(컬럼, 값1, 값2) 
-- => 컬럼값 중에 값1이 있으면 값2로 교체
SELECT JOB, REPLACE(JOB,'A','$') FROM EMP;

--[문제]---------------------------------------- 
--고객 테이블의 직업에 해당하는 컬럼에서 직업 정보가 학생인 정보를 모두
--대학생으로 변경해 출력되게 하세요.
SELECT JOB, REPLACE(JOB,'학생','대학생') FROM MEMBER;
--고객 테이블 주소에서 서울시를 서울특별시로 수정하세요.
SELECT ADDR, REPLACE(ADDR, '서울시','서울특별시') FROM MEMBER;
UPDATE MEMBER SET ADDR=REPLACE(ADDR, '서울시','서울특별시');
SELECT * FROM MEMBER;
ROLLBACK;
--사원테이블에서 10번 부서의 사원에 대해 담당업무 중 우측에'T'를
--삭제하고 급여중 우측의 0을 삭제하여 출력하세요.
SELECT JOB, RTRIM(JOB,'T'), SAL ,RTRIM(SAL,0), DEPTNO 
FROM EMP 
WHERE DEPTNO=10;
-------------------------------------------------        