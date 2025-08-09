execute ace.insert_dept_noauth_proc(320, 'Test02', 1800)

SELECT * FROM kosa.dept_temp;
-- -> 삽입한 데이터 보이지 않음

SELECT * FROM ace.dept_temp
WHERE deptno > 200;
-- -> ace.dept_temp에 데이터가 삽입됨

execute ace.insert_dept_auth_proc(330, 'Test03', 1900)

BEGIN
    ace.insert_dept_auth_proc(330, 'Test03', 1900);
END;

COMMIT;
