--day09_DCL.sql
conn system/oracle;
show user;
--시스템 권한을 scott에게 부여하자
grant create user, alter user, drop user to scott
with admin option;
-- with admin option 옵션을 주면 scott도 다른 유저에게 권한을 줄 수 있다.
