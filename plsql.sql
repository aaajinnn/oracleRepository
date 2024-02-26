CREATE OR REPLACE PROCEDURE BBS_ADD
(
    ptitle in bbs.title%type,
    pwriter in bbs.writer%type,
    pcontent in bbs.content%type
)
IS 
BEGIN
    insert into bbs(no, title, writer, content, wdate)
    values(bbs_no_seq.nextval, ptitle, pwriter, pcontent, sysdate);
    commit;
END;
/

EXEC bbs_add('���ν����� ���� ���','kim','���ν����� jdbc�����մϴ�');

select * from bbs order by no desc;
-----------------------------------------------------
-- SYS_REFCURSORŸ���� �̿��ϸ� �ڹٿ��� ResultSet���� ���� �� �ִ�.
-- �˻��� �޾Ƶ��̰�, ��������(out, in �Ѵ� ����ϱ�)
CREATE OR REPLACE PROCEDURE bbs_find 
(mycr OUT SYS_REFCURSOR, pwriter IN bbs.writer%type)
IS
BEGIN
    OPEN mycr FOR
    SELECT no, title, writer, content, wdate FROM bbs
    WHERE writer LIKE '%'|| pwriter ||'%'
    ORDER BY no DESC;
END;
/
--------------------------------------------------------
VARIABLE rs refcursor
EXEC bbs_find(:rs,'k');

print rs