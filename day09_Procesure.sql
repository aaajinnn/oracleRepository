-- day09_Procesure.sql
--PL/SQL을 이용한 프로시저 만들기
--[1] 익명 블럭으로 프로시저 생성
--[2] 이름을 갖는 프로시저 생성
-------------------------------
--[1] 익명 블럭으로 프로시저 생성
SET SERVEROUTPUT ON; -- 기본값 OFF, ON으로 해주어야 출력됨

DECLARE
    --선언부
    I_MSG VARCHAR2(100); -- I_MSG 변수 선언
    TODAY TIMESTAMP;
BEGIN
    -- 실행부
    I_MSG := 'Hello World'; -- 변수에 값을 할당
    SELECT SYSTIMESTAMP INTO TODAY
    FROM DUAL;
    DBMS_OUTPUT.PUT_LINE(I_MSG); -- 변수값 출력
    DBMS_OUTPUT.PUT_LINE(TODAY);
END;
/

--현재 시간에서 1시간전과 3시간 후의 시각을 구해 출력하는 프로시저를 작성하세요
    DECLARE
        HOUR1 TIMESTAMP;
        HOUR3 TIMESTAMP;
    BEGIN
        SELECT SYSTIMESTAMP-1/24 INTO HOUR1 FROM DUAL;
        SELECT SYSTIMESTAMP+3/24 INTO HOUR3 FROM DUAL;
        DBMS_OUTPUT.PUT_LINE('1시간 전 : ' || HOUR1);
        DBMS_OUTPUT.PUT_LINE('3시간 후 : ' || HOUR3);
    END;
    /
-------------------------------
--[2] 이름을 갖는 프로시저 생성
--JAVA_MEMBER 테이블에 데이터를 삽입하는 프로시저를 작성하세요
--ID,PW,NAME,TEL ==> IN PARAMETER
CREATE OR REPLACE PROCEDURE JAVA_MEMBER_ADD(
    P_ID IN VARCHAR, -- IN:받아내기,  OUT:내보내기
    P_PW IN VARCHAR,
    P_NAME IN VARCHAR,
    P_TEL IN VARCHAR
)
IS
BEGIN
    INSERT INTO JAVA_MEMBER(ID, PW, NAME, TEL)
    VALUES (P_ID, P_PW, P_NAME, P_TEL);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE(P_NAME || '님의 정보를 등록했어요');
    -- 예외처리
    EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE(P_ID || '님의 아이디가 이미 존재합니다. - 등록실패!!');
END;
/
-------------------------------
EXECUTE JAVA_MEMBER_ADD('ccdd','222','김새롬','010-2222-2222');
EXEC JAVA_MEMBER_ADD('aabb','333','최용길','010-5555-6666');
EXEC JAVA_MEMBER_ADD('hong2','333','홍용남','010-5555-6666'); --유닉크키 제약조건 위배 => 예외처리

SELECT * FROM JAVA_MEMBER;

--[실습]
--EMP에서 부서번호와 인상율(10,20) 인 파라미터로 받아서 
--해당 부서의 사원들의 급여를 인상율 만큼 인상하는 프로시저를 작성하세요
--프로시저명: EMP_SALUP
create or replace procedure EMP_SALUP(
    p_deptno in number,
    p_uprate in number
)
is
begin
    update emp set sal=sal*(1+p_uprate*0.01) where deptno=p_deptno;
    --commit;
    dbms_output.put_line(p_deptno||'번 부서의 급여가 '||p_uprate||'% 만큼 인상됐어요');
end;
/
select ename, sal from emp where deptno=30;
EXEC EMP_SALUP(30,10);

