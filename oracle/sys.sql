SELECT *
FROM cdb_pdbs;

show user

SELECT *
FROM dba_users
WHERE username = 'ACE';

CREATE USER kosa
IDENTIFIED BY kosa123 ACCOUNT UNLOCK;

GRANT CREATE SESSION TO kosa;

GRANT CREATE TABLE TO kosa;

ALTER USER kosa QUOTA 10M ON USERS;

-- 추가
GRANT RESOURCE TO kosa;

SELECT *
FROM dba_roles;

desc dba_role_sys;

SELECT * FROM role_sys_privs
WHERE role IN ('CONNECT', 'RESOURCE');

-- 추가
SELECT username, sid, serial# 
FROM v$session
WHERE username = 'KOSA';

-- 추가
ALTER SYSTEM KILL SESSION '386,1207' IMMEDIATE;

--
DROP USER kosa CASCADE;


-- 복붙
DROP TABLE t_reg;

CREATE TABLE t_reg (
  text VARCHAR2(20)
);