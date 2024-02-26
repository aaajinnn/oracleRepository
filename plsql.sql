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

EXEC bbs_add('프로시저로 글을 써요','kim','프로시저와 jdbc연동합니다');

select * from bbs order by no desc;
-----------------------------------------------------
-- SYS_REFCURSOR타입을 이용하면 자바에서 ResultSet으로 받을 수 있다.
-- 검색어 받아들이고, 내보내기(out, in 둘다 사용하기)
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