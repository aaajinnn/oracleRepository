--day09_DCL.sql
conn system/oracle;
show user;
--�ý��� ������ scott���� �ο�����
grant create user, alter user, drop user to scott
with admin option;
-- with admin option �ɼ��� �ָ� scott�� �ٸ� �������� ������ �� �� �ִ�.
