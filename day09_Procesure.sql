-- day09_Procesure.sql
--PL/SQL�� �̿��� ���ν��� �����
--[1] �͸� ������ ���ν��� ����
--[2] �̸��� ���� ���ν��� ����
-------------------------------
--[1] �͸� ������ ���ν��� ����
SET SERVEROUTPUT ON; -- �⺻�� OFF, ON���� ���־�� ��µ�

DECLARE
    --�����
    I_MSG VARCHAR2(100); -- I_MSG ���� ����
    TODAY TIMESTAMP;
BEGIN
    -- �����
    I_MSG := 'Hello World'; -- ������ ���� �Ҵ�
    SELECT SYSTIMESTAMP INTO TODAY
    FROM DUAL;
    DBMS_OUTPUT.PUT_LINE(I_MSG); -- ������ ���
    DBMS_OUTPUT.PUT_LINE(TODAY);
END;
/

--���� �ð����� 1�ð����� 3�ð� ���� �ð��� ���� ����ϴ� ���ν����� �ۼ��ϼ���
    DECLARE
        HOUR1 TIMESTAMP;
        HOUR3 TIMESTAMP;
    BEGIN
        SELECT SYSTIMESTAMP-1/24 INTO HOUR1 FROM DUAL;
        SELECT SYSTIMESTAMP+3/24 INTO HOUR3 FROM DUAL;
        DBMS_OUTPUT.PUT_LINE('1�ð� �� : ' || HOUR1);
        DBMS_OUTPUT.PUT_LINE('3�ð� �� : ' || HOUR3);
    END;
    /
-------------------------------
--[2] �̸��� ���� ���ν��� ����
--JAVA_MEMBER ���̺� �����͸� �����ϴ� ���ν����� �ۼ��ϼ���
--ID,PW,NAME,TEL ==> IN PARAMETER
CREATE OR REPLACE PROCEDURE JAVA_MEMBER_ADD(
    P_ID IN VARCHAR, -- IN:�޾Ƴ���,  OUT:��������
    P_PW IN VARCHAR,
    P_NAME IN VARCHAR,
    P_TEL IN VARCHAR
)
IS
BEGIN
    INSERT INTO JAVA_MEMBER(ID, PW, NAME, TEL)
    VALUES (P_ID, P_PW, P_NAME, P_TEL);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE(P_NAME || '���� ������ ����߾��');
    -- ����ó��
    EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE(P_ID || '���� ���̵� �̹� �����մϴ�. - ��Ͻ���!!');
END;
/
-------------------------------
EXECUTE JAVA_MEMBER_ADD('ccdd','222','�����','010-2222-2222');
EXEC JAVA_MEMBER_ADD('aabb','333','�ֿ��','010-5555-6666');
EXEC JAVA_MEMBER_ADD('hong2','333','ȫ�볲','010-5555-6666'); --����ũŰ �������� ���� => ����ó��

SELECT * FROM JAVA_MEMBER;

--[�ǽ�]
--EMP���� �μ���ȣ�� �λ���(10,20) �� �Ķ���ͷ� �޾Ƽ� 
--�ش� �μ��� ������� �޿��� �λ��� ��ŭ �λ��ϴ� ���ν����� �ۼ��ϼ���
--���ν�����: EMP_SALUP
create or replace procedure EMP_SALUP(
    p_deptno in number,
    p_uprate in number
)
is
begin
    update emp set sal=sal*(1+p_uprate*0.01) where deptno=p_deptno;
    --commit;
    dbms_output.put_line(p_deptno||'�� �μ��� �޿��� '||p_uprate||'% ��ŭ �λ�ƾ��');
end;
/
select ename, sal from emp where deptno=30;
EXEC EMP_SALUP(30,10);

