-- day08_object.sql
--# ORACLE의 객체
--[1] TABLE
--[2] SEQUENCE
--[3] VIEW
--[4] INDEX
--[5] SYNONYM
--....

--#SEQUENCE
--DEPT의 PK로 사용되는 DEPTNO 값으로 사용할 시퀀스를 만들어보자
CREATE SEQUENCE DEPT_DEPTNO_SEQ
START WITH 60 -- 시작값
INCREMENT BY 10 -- 증가치
MAXVALUE 99 -- 최대값
MINVALUE 60
NOCACHE 
NOCYCLE;

--데이터 사전에서 조회
SELECT * FROM USER_SEQUENCES WHERE SEQUENCE_NAME='DEPT_DEPTNO_SEQ';

SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE='SEQUENCE';

--# 시퀀스 사용법
--- NEXTVAL : 시퀀스 다음값을 반환
---CURRVAL : 시퀀스의 현재값을 반환
---[주의사항] NEXTVAL을 하지않은 채로 CURRVAL을 먼저 사용할 수 없다.

INSERT INTO DEPT(DEPTNO, DNAME, LOC)
VALUES(DEPT_DEPTNO_SEQ.NEXTVAL, '홍보부', '인천');

INSERT INTO DEPT(DEPTNO, DNAME, LOC)
VALUES(DEPT_DEPTNO_SEQ.NEXTVAL, '기획부2', '수원');

SELECT * FROM DEPT;
rollback;
DESC DEPT;
SELECT DEPT_DEPTNO_SEQ.CURRVAL FROM DUAL;
----------------------------------------------
-- BBS테이블(게시판)에 사용할 시퀀스를 생성하세요.
SELECT * FROM BBS;
--<1> BBS 테이블(게시판)에 사용할 시퀀스를 생성하세요
--시작값: n
--증가치: 1
--최소값: N
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
--<2> BBS에 시퀀스를 이용해서 게시글을 삽입하세요
INSERT INTO BBS (NO, TITLE, WRITER, CONTENT)
VALUES(BBS_NO_SEQ.NEXTVAL,'시퀀스를 또 또 써봐요','kim','시퀀스를 이용합시다');

SELECT BBS_NO_SEQ.CURRVAL FROM DUAL;
SELECT * FROM BBS;
-- rollback을 해도 시퀀스 nextval은 이전으로 다시 돌아가지 않는다 => 시퀀스 간격(gab)발생
-- rownum은 누락된 데이터가 있으면 땡겨서 번호를 매김
------------------------------------------------------
--DEPT_DEPTNO_SEQ
SELECT * FROM USER_SEQUENCES
WHERE SEQUENCE_NAME='DEPT_DEPTNO_SEQ';

-- DEPT_DEPTNO_SEQ를 아래와 같이 수정하세요
--증가치 : 5
--CYCLE 옵션 주기
--캐시 사이즈 : 20

--ALTER SEQUENCE 시퀀스명
--INCREMENT BY N
--MINVALUE N
--MAXVALUE N
--CYCLE|NOCYCLE
--CACHE N|NOCACHE;
--[주의] 시작값은 수정할 수 없음
    ALTER SEQUENCE DEPT_DEPTNO_SEQ
--    START WITH 60 -- cannot alter starting sequence number(시작값 변경할 수 없음)
    INCREMENT BY 5
    MAXVALUE 150
    CYCLE
    NOCACHE;

SELECT DEPT_DEPTNO_SEQ.NEXTVAL FROM DUAL; -- 최대값넘어가면 사이클로 돌아가 처음부터 다시 실행됨

--# 시퀀스 삭제
--DROP SEQUENCE 시퀀스명;
--
--DEPT_DEPTNO_SEQ를 삭제하세요
DROP SEQUENCE DEPT_DEPTNO_SEQ;
---------------------------------------------
--# VIEW
--가상의 테이블
--CREATE [OR REPLACE] VIEW 뷰이름
--AS
--SELECT문
CREATE VIEW EMP20_VIEW
AS
SELECT * FROM EMP
WHERE DEPTNO=20; -- insufficient privileges(권한없음)

-- view를 만들기 위해서는 권한이 필요[dba권한으로 CREATE VIEW권한을 주자]
--SYSTEMP/ORACLE로 접속해서 권한을 부여한다.
--GRANT CREATE VIEW TO SCOTT;

CREATE VIEW EMP20_VIEW
AS
SELECT * FROM EMP
WHERE DEPTNO=20;

--VIEW 조회
SELECT * FROM EMP20_VIEW;

--EMP테이블에서 30번 부서만 EMPNO를 EMP_NO로 ENAME을 NAME으로
--	SAL를 SALARY로 바꾸어 EMP30_VIEW를 생성하여라.
    CREATE OR REPLACE VIEW EMP30_VIEW
    AS
    SELECT EMPNO EMP_NO, ENAME NAME, SAL SALARY, DEPTNO DNO 
    FROM EMP
    WHERE DEPTNO=30;
    
    SELECT * FROM EMP30_VIEW;
    
    -- EMP테이블을 수정한다면 VIEW도 같이 수정된다.
    UPDATE EMP SET DEPTNO=10 WHERE ENAME='ALLEN';
    -- VIEW를 수정한다면 EMP테이블도 같이 수정된다.
    UPDATE EMP30_VIEW SET SALARY=1550 WHERE NAME='WARD';
    SELECT * FROM EMP;
    -- 만약 뷰를 수정못하게 하려면 VIEW를 생성할 때 WITH READ ONLY옵션을 준다.
    
--고객테이블의 고객 정보 중 나이가 19세 이상인
--	고객의 정보를
--	확인하는 뷰를 만들어보세요.
--	단 뷰의 이름은 MEMBER_19VIEW로 하세요.
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

-- 카테고리, 상품, 공급업체를 JOIN한 뷰를 만드세요
-- 뷰이름 : PROD_VIEW
    CREATE VIEW PROD_VIEW
    AS
    SELECT * FROM CATEGORY C JOIN PRODUCTS P
    ON C.CATEGORY_CODE = P.CATEGORY_FK
    JOIN SUPPLY_COMP S
    ON S.EP_CODE = P.EP_CODE_FK;
    
    SELECT CATEGORY_NAME, PRODUCTS_NAME, EP_NAME FROM PROD_VIEW;
    -- => JOIN문으로 생성한 뷰는 읽기 전용으로만 사용 가능

--# WITH CHECK OPTION
-- WHERE절의 조건을 엄격하게 유지하도록 제한함
CREATE OR REPLACE VIEW EMP20VW
AS 
SELECT * FROM EMP
WHERE DEPTNO=20
WITH CHECK OPTION CONSTRAINT EMP20VW_CK;

SELECT * FROM EMP20VW;

UPDATE EMP20VW SET SAL=SAL+500 WHERE EMPNO=7369;

UPDATE EMP20VW SET DEPTNO=30 WHERE EMPNO=7369;
-- => ORA-01402: view WITH CHECK OPTION where-clause violation
--# 데이터 사전 조회
--USER_VIEWS
--USER_OBJECTS
SELECT TEXT FROM USER_VIEWS WHERE VIEW_NAME='EMP20VW';
SELECT * FROM USER_OBJECTS WHERE OBJECT_NAME='EMP20VW';

--#VIEW 삭제
DROP VIEW EMP20VW;
SELECT * FROM USER_VIEWS;
----------------------------------
--#INDEX

--#SYNONYM
----------------------------------
--#프로시저 - CRUD

--#DB설계 - 개념설계/논리설계/물리설계, 정규화


