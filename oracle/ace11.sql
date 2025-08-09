-- 7/10 (목)

-- employees_temp 생성
CREATE TABLE employees_temp (
  employee_id     NUMBER,
  first_name      VARCHAR2(20),
  last_name       VARCHAR2(25),
  email           VARCHAR2(25),
  phone_number    VARCHAR2(20),
  hire_date       DATE,
  job_id          VARCHAR2(10),
  salary          NUMBER(8,2),
  commission_pct  NUMBER(2,2),
  manager_id      NUMBER,
  department_id   NUMBER
);

-- [실습] -> 에러
CREATE OR REPLACE PROCEDURE at1
IS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  INSERT INTO employees_temp
  VALUES (7777, 'AT', 'AT', 'AT@AT', NULL, SYSDATE, 'IT_PROG', 3333, 0, NULL, NULL);
  
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' inserted...');
  
  COMMIT;
END;
/

-- 수정
CREATE OR REPLACE PROCEDURE at2
IS
BEGIN
  -- MT에서 INSERT
  INSERT INTO employees_temp
  VALUES (7878, 'MT', 'MT', 'MT@MT', NULL, SYSDATE, 'IT_PROG', 2222, 0, NULL, NULL);
  -- 자율 트랜잭션으로 선언된 at1 프로시저 호출
  at1;
  -- MT 롤백
  ROLLBACK;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM(SQLCODE));
  
END;
/

SELECT * FROM employees_temp
WHERE employee_id IN (7777, 7878);

exec at2

SELECT * FROM employees_temp
WHERE employee_id IN (7777, 7878);

-- 16-1 실습
DECLARE
rec_emp employees%ROWTYPE;

BEGIN
  SELECT *
  INTO rec_emp
  FROM employees
  WHERE employee_id = 124;
  
  DBMS_OUTPUT.PUT_LINE (rec_emp.last_name || ' ' || rec_emp.job_id);
  
  -- 추출되는 건수가 하나도 없어 예외가 발생함
  SELECT *
  INTO rec_emp      
  FROM employees
  WHERE employee_id = 300;
  
  DBMS_OUTPUT.PUT_LINE (rec_emp.last_name || ' ' || rec_emp.job_id);

EXCEPTION
   -- 발생 가능한 예외 처리 나열
   WHEN NO_DATA_FOUND THEN    
      DBMS_OUTPUT.PUT_LINE ('한 건도 조회되지 않았습니다.');
   WHEN TOO_MANY_ROWS THEN
      DBMS_OUTPUT.PUT_LINE ('두 건 이상 조회되었습니다.');
   WHEN VALUE_ERROR THEN
      NULL;
   WHEN ZERO_DIVIDE THEN
      NULL;
   WHEN DUP_VAL_ON_INDEX THEN
      NULL;
   -- 위 기술치 못한 예상치 못한 예외 발생 시
   WHEN OTHERS THEN            
      DBMS_OUTPUT.PUT_LINE('outer other exception');
      DBMS_OUTPUT.PUT_LINE('Outer Error : '||SQLERRM(SQLCODE));
end;
/

-- [실습]
CREATE OR REPLACE PROCEDURE at1
IS
    -- 자율 트랜잭션 선언
  PRAGMA AUTONOMOUS_TRANSACTION; 
BEGIN
  UPDATE employees_temp SET salary = 1000 WHERE employee_id = 110;
--  COMMIT;
END;
/

-- 
-- 메인 트랜잭션에서 동일한 자원을 사용하려는 자율트랜잭션 수행
-- 데드락 예외 코드인 -60에러를 deadlock 예외명으로 선언
DECLARE
  deadlock EXCEPTION;
  PRAGMA EXCEPTION_INIT(deadlock, -60);      

BEGIN
  UPDATE employees_temp SET salary = 1600 WHERE employee_id = 110;
   
  -- 동일 사번에 대해 데드락이 발생토록 자율트랜잭션으로 업데이트 수행
  at1;       
 
EXCEPTION
  WHEN deadlock THEN
      DBMS_OUTPUT.PUT_LINE('Deadlock detected');
  WHEN others THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM(SQLCODE));      
END;
/

-- [실습] 예외 변수 선언
<<outer>>
DECLARE
   -- 사용자가 fool 예외 변수를 선언함
   fool EXCEPTION;
   
   l_flag BOOLEAN := TRUE;
BEGIN
   DBMS_OUTPUT.PUT_LINE('outer block logic1');
   
    -- 별도의 예외 처리를 위한 내부 PL/SQL 블록을 추가함
    <<inner>>
    DECLARE

      -- 사용자가 fool 예외를 선언함
      fool EXCEPTION;
      
    BEGIN
      DBMS_OUTPUT.PUT_LINE('inner block logic1');      
      

      -- 특정 조건에서 예외를 발생시킴
      IF l_flag THEN
        RAISE fool;
      END IF;
      
      DBMS_OUTPUT.PUT_LINE('inner block logic2');
      
    EXCEPTION
      -- 사용자가 정의한 fool 에러 발생 시 
      WHEN fool THEN
         DBMS_OUTPUT.PUT_LINE('inner fool exception');
         DBMS_OUTPUT.PUT_LINE('Inner Error : '||SQLERRM(SQLCODE));
         
         /* 현재의 예외 상황을 한단계 위인 outer block 으로 전파함.
            outer block 이 없다면 return과 동일한 효과로 프로그램이 종료됨. */
         RAISE; 
     END;
   
   -- 예외가 상위 블록으로 전파됨에 따라 아래 부부은 수행되지 않음
   DBMS_OUTPUT.PUT_LINE('outer block logic2');

EXCEPTION
  WHEN fool THEN            -- 사용자 정의 exception
      DBMS_OUTPUT.PUT_LINE('outer fool exception');

  -- 안쪽 블록에서 예외가 전파됨에 따라 메인 블록의 예외 처리가 수행됨
  WHEN others THEN
      DBMS_OUTPUT.PUT_LINE('outer other exception');
      DBMS_OUTPUT.PUT_LINE('Outer Error : '||SQLERRM(SQLCODE));
END;
/

-- → 위 예에서 RAISE 를 RAISE fool로 변경하면 외부 블록의 WHEN others THEN 예외 처리기가 실행
--                      RAISE outer.fool로 변경하면 외부 블록의 WHEN fool THEN 예외 처리기가 실행
-- [실습] RAISE_APPLICATION_ERROR()
--  - 별도의 예외 변수를 사용하지 않는 방법
BEGIN
    DBMS_OUTPUT.PUT_LINE('어라!');
    RAISE_APPLICATION_ERROR(-20001, '그냥 예외 던져봤어!');
END;
/

-- [실습] DML, DDL using NDS
DECLARE
  l_tab VARCHAR2(10) := 'NDS_TEST';
  l_sqlstmt VARCHAR2(1000);
  l_cnt NUMBER;
  l_id  NUMBER;  
  l_null NUMBER := null;
   
BEGIN   
  DBMS_OUTPUT.PUT_LINE('[Create Table]');  
  -- 입력 변수에 따라 서로 다른 이름으로 테이블 생성
  EXECUTE IMMEDIATE 'CREATE TABLE '|| l_tab || '(id NUMBER)'; 

  -- 입력 변수에 따라 테이블에 데이터 삽입
  -- using구문을 사용하지 않을 경우 각각 하드 파싱이 되므로 주의가 필요함
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Insert Data]');
   
  FOR i in 1..10 LOOP 
    EXECUTE IMMEDIATE 'INSERT INTO ' || l_tab || ' VALUES(:1)' USING i;
  END LOOP; 

   -- 입력 변수에 따라 데이터 삭제, 삭제 결과를 저장 (with RETURNING INTO)
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Delete]');
  EXECUTE IMMEDIATE ' DELETE FROM ' || l_tab || 
                    ' WHERE id = :id RETURNING id INTO :deleted_id' 
    USING 7 RETURNING INTO l_id;
  
  DBMS_OUTPUT.PUT_LINE('id deleted with returning : '||l_id);
  DBMS_OUTPUT.PUT_LINE('sql%rowcount  : '||sql%ROWCOUNT);
   
  -- -- 입력 변수에 따라 데이터 삭제, 삭제 결과를 저장 (with OUT)
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Delete]');
   
  EXECUTE IMMEDIATE ' DELETE FROM ' || l_tab ||
                    ' WHERE id = :id RETURNING id INTO :deleted_id' 
    USING 8, OUT l_id;
  
  DBMS_OUTPUT.PUT_LINE('id deleted with OUT  : '||l_id);   
  DBMS_OUTPUT.PUT_LINE('sql%rowcount  : '||sql%ROWCOUNT);

  -- 입력 변수에 따라 데이터 업데이트
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Update with NULL]');
   
  EXECUTE IMMEDIATE 'UPDATE  '||l_tab||' set id = :1' USING l_null;
  DBMS_OUTPUT.PUT_LINE('sql%rowcount  : '||sql%ROWCOUNT);
      
  -- 입력 변수에 따라 테이블 삭제
  DBMS_OUTPUT.PUT_LINE('[Drop Table]');
  EXECUTE IMMEDIATE 'DROP TABLE NDS_TEST';
  DBMS_OUTPUT.PUT_LINE('sql%rowcount  : '||sql%ROWCOUNT);   

END;
/

-- [실습] SELECT using NDS and NDS + REF CURSOR
DECLARE
  l_tab VARCHAR2(10) := 'employees';
  l_emp_rec employees%ROWTYPE;
   
  TYPE emptab IS TABLE OF employees%ROWTYPE;
  l_emptab emptab := emptab();
   
  l_sqlstmt VARCHAR2(1000);
  l_cnt NUMBER;
  l_id  NUMBER;  
   
  -- OPEN FOR 사용 시 REF CURSOR 사용 필요
  -- 오라클에서 제공하는 SYS_REFCURSOR 타입 사용
  l_cur SYS_REFCURSOR;
   
BEGIN
  -- 입력 변수에 따라 데이터 조회
  -- 바인드 변수 처리가 되도록 using구문 활용함
  -- using구문을 사용하지 않을 경우 각각 하드 파싱이 되므로 주의가 필요함
  l_sqlstmt := 'SELECT COUNT(*) FROM '||l_tab||' WHERE employee_id <= :id';
  
  EXECUTE IMMEDIATE l_sqlstmt INTO l_cnt USING 103;
   
  DBMS_OUTPUT.PUT_LINE('[Select Into ~ Single Column]');
  DBMS_OUTPUT.PUT_LINE('l_cnt : '||l_cnt);

  -- 멀티 칼럼을 반환 시 레코드 타입 변수에 저장
  l_sqlstmt := 'SELECT * FROM '||l_tab||' WHERE employee_id = :id';
  EXECUTE IMMEDIATE l_sqlstmt INTO l_emp_rec USING 103;
   
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Select Into ~ Multi Column (With Record Type)]');
  DBMS_OUTPUT.PUT_LINE('employee_id : ' || l_emp_rec.employee_id || ' last_name : ' || l_emp_rec.last_name);
   
  -- 멀티 칼럼, 멀티 로우 반환 시 -- 컬렉션 이용(BULK COLLECT INTO)   
  l_sqlstmt := 'SELECT * FROM '||l_tab||' WHERE employee_id <= :id';
  EXECUTE IMMEDIATE l_sqlstmt BULK COLLECT INTO l_emptab USING 103;
   
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[Select Into ~ Multi Row, Multi Column(With bulk collect into)]');
   
  FOR i IN l_emptab.FIRST .. l_emptab.LAST LOOP
    DBMS_OUTPUT.PUT_LINE('employee_id : ' || l_emptab(i).employee_id || ' last_name : ' || l_emptab(i).last_name);
  END LOOP;

  -- Ref커서를 이용하여 SQL 실행
  DBMS_OUTPUT.PUT_LINE('.');
  DBMS_OUTPUT.PUT_LINE('[OPEN ~ REF CURSOR]');
   
  OPEN l_cur FOR l_sqlstmt USING 103; 
  
  LOOP
    FETCH l_cur INTO l_emp_rec; 
    DBMS_OUTPUT.PUT_LINE('employee_id : ' || l_emp_rec.employee_id || ' last_name : ' || l_emp_rec.last_name);

    EXIT WHEN l_cur%NOTFOUND;
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE('l_cur%ROWCOUNT  : '||l_cur%ROWCOUNT);
  
  CLOSE l_cur; 

END;
/ 

-- [실습] DML using DBMS_SQL
-- 실습은 DML만 수행했지만 DDL도 같은 방식으로 사용하면 됨
-- 테스트를 위한 빈 임시 테이블 생성
DROP TABLE emp_temp;
CREATE TABLE emp_temp 
AS SELECT * FROM employees WHERE 1 = 2;

DECLARE
  l_rows   NUMBER;
  v_empno  NUMBER := 900;
  v_ename  VARCHAR2(20) := 'Hong';
  v_email  VARCHAR2(20) := 'Hong@test.com';

  g_cursor NUMBER := DBMS_SQL.OPEN_CURSOR;
  
BEGIN
  -- SQL 구문을 커서와 바인딩
  DBMS_SQL.PARSE(g_cursor,
      'INSERT INTO emp_temp(employee_id, last_name, email, hire_date, job_id) VALUES (:1, :2, :3, :hiredate, :job)',
      DBMS_SQL.NATIVE);

  -- 바인드 변수를 SQL과 바인딩
  DBMS_SQL.BIND_VARIABLE(g_cursor, ':1', v_empno);
  DBMS_SQL.BIND_VARIABLE(g_cursor, ':3', v_email);
  DBMS_SQL.BIND_VARIABLE(g_cursor, ':2', v_ename);
  DBMS_SQL.BIND_VARIABLE(g_cursor, ':hiredate', SYSDATE);
  DBMS_SQL.BIND_VARIABLE(g_cursor, ':job', 'IT_PROG');
  
  -- SQL 실행
  l_rows := DBMS_SQL.EXECUTE(g_cursor);
  
  -- 커서 CLOSE
  DBMS_SQL.CLOSE_CURSOR(g_cursor);
  
END;
/

SELECT * FROM emp_temp;

ROLLBACK;

-- [실습] SELECT using DBMS_SQL
DECLARE
  -- 오픈한 커서 포인터를 담을 변수 선언
  l_theCursor INTEGER DEFAULT DBMS_SQL.OPEN_CURSOR;
    
  l_query     VARCHAR2(4000);
    
  l_empno     employees.employee_id%TYPE;
  l_ename     employees.last_name%TYPE;
  l_sal       employees.salary%TYPE;
  l_status    INTEGER;
BEGIN
  l_query := 'SELECT employee_id, last_name, salary ' ||
             'FROM employees ' ||
             'WHERE department_id = :deptno';

  -- SQL 구문을 커서를 파싱
  DBMS_SQL.PARSE(l_theCursor, l_query, DBMS_SQL.NATIVE);

  -- 바인드 변수를 SQL과 바인딩
  DBMS_SQL.BIND_VARIABLE(l_theCursor, ':deptno', 20);

  -- CURSOR로부터 추출된 칼럼의 값을 받는 변수를 지정
  -- 커서명, 상대위치, 변수명, 길이 지정
  DBMS_SQL.DEFINE_COLUMN(l_theCursor, 1, l_empno);   
  DBMS_SQL.DEFINE_COLUMN(l_theCursor, 2, l_ename, 20);  
  DBMS_SQL.DEFINE_COLUMN(l_theCursor, 3, l_sal);

  -- SQL문 실행
  l_status := DBMS_SQL.EXECUTE(l_theCursor);

  -- CURSOR로부터 ROW를 FETCH
  WHILE (DBMS_SQL.FETCH_ROWS(l_theCursor) > 0) LOOP
  
    -- 결과를 변수에 저장 
    DBMS_SQL.COLUMN_VALUE(l_theCursor, 1, l_empno);
    DBMS_SQL.COLUMN_VALUE(l_theCursor, 2, l_ename);
    DBMS_SQL.COLUMN_VALUE(l_theCursor, 3, l_sal); 
      
    DBMS_OUTPUT.PUT_LINE('employee_id : ' || l_empno || ', last_name : ' || l_ename || ', salary : ' || l_sal  );       
  END LOOP;   

  -- 커서 Close
  DBMS_SQL.CLOSE_CURSOR(l_theCursor);
    
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
      
END;
/

-- 
DECLARE
  -- 오픈한 커서 포인터를 담을 변수 선언
  l_theCursor INTEGER DEFAULT DBMS_SQL.OPEN_CURSOR;
    
  l_query     VARCHAR2(4000);
    
  l_status    INTEGER;
  l_columnValue   VARCHAR2(4000);
  
  l_new_column VARCHAR2(30) := 'job_id';

  -- desc_rec 구조체의 컬렉션형태로 내부적으로 정의된 타입임
  -- 반환되는 칼럼명을 저장하기 위해 컬렉션 타입임
  l_descTbl       DBMS_SQL.DESC_TAB; 
  l_colCnt        NUMBER;
BEGIN
  l_query := 'SELECT employee_id, last_name, salary,' || l_new_column || ' ' ||
             'FROM employees ' ||
             'WHERE department_id = :deptno';
                
  -- SQL 구문을 커서와 바인딩
  DBMS_SQL.PARSE(l_theCursor, l_query, DBMS_SQL.NATIVE);

  -- 바인드 변수를 SQL과 바인딩
  DBMS_SQL.BIND_VARIABLE(l_theCursor, ':deptno', 20);

  -- SQL에서 추출하려는 칼럼 정보를 추출하여 l_descTbl(dbms_sql.desc_tab) 타입에 입력
  -- 칼럼 개수와 컬렉션에 칼럼명을 저장하여 반환
  DBMS_SQL.DESCRIBE_COLUMNS(l_theCursor, l_colCnt, l_descTbl);

  -- 커서로부터 반환된 칼럼의 값을 받는 변수를 지정
  FOR i in 1..l_colCnt LOOP
    DBMS_SQL.DEFINE_COLUMN(l_theCursor, i, l_columnValue, 4000);
  END LOOP;

  -- SQL문을 실행
  l_status := DBMS_SQL.EXECUTE(l_theCursor);

  -- CURSOR로부터 ROW를 FETCH
  WHILE (DBMS_SQL.FETCH_ROWS(l_theCursor) > 0) LOOP
    FOR i IN 1..l_colCnt LOOP
      -- 결과를 변수에 반환 
      DBMS_SQL.COLUMN_VALUE(l_theCursor, i, l_columnValue);          
      DBMS_OUTPUT.PUT_LINE (RPAD(l_descTbl(i).col_name, 30)  -- 칼럼의 이름을 출력
                            || ': ' ||
                            l_columnValue );                  -- 추출된 칼럼 값 출력
    END LOOP;   
  END LOOP;   

  -- 커서 Close
  DBMS_SQL.CLOSE_CURSOR(l_theCursor);
    
  EXCEPTION
    WHEN OTHERS THEN
      RAISE;
END;
/

-- [실습] 문장 레벨 트리거
-- 테스트 테이블 생성
DROP TABLE emp_temp;
CREATE TABLE emp_temp
AS
SELECT * FROM employees
WHERE ROWNUM <= 5;

CREATE OR REPLACE TRIGGER emp_update_trg01
  BEFORE UPDATE ON emp_temp
  FOR EACH ROW
BEGIN
  DBMS_OUTPUT.PUT_LINE('변경 전 컬럼 값: ' || :OLD.salary);  -- ERROR
  DBMS_OUTPUT.PUT_LINE('UPDATE BEFORE 문장 레벨 트리거 실행!!!');
  DBMS_OUTPUT.NEW_LINE;
END;
/

CREATE OR REPLACE TRIGGER emp_update_trg02
  AFTER UPDATE ON emp_temp
BEGIN
  DBMS_OUTPUT.PUT_LINE('UPDATE AFTER 문장 레벨 트리거 실행!!!');
  DBMS_OUTPUT.NEW_LINE;
END;
/

-- [테스트]
UPDATE emp_temp
SET salary = salary + 0;

-- [실습] 행 레벨 트리거
-- 급여 변경 로그 테이블 생성
DROP TABLE salary_logs;

CREATE TABLE salary_logs (
  update_time TIMESTAMP(3) WITH TIME ZONE NOT NULL,
  ename VARCHAR2(25) NOT NULL,
  salary_before NUMBER(8, 2),
  salary_after NUMBER(8, 2),
  operation VARCHAR2(3) CHECK (operation IN ('INS', 'UPD', 'DEL')),
  modifier VARCHAR2(30)
);

CREATE OR REPLACE TRIGGER emp_update_trg03
  BEFORE UPDATE ON emp_temp
  FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  DBMS_OUTPUT.PUT_LINE('UPDATE BEFORE 행 레벨 트리거 실행!!!');
  DBMS_OUTPUT.PUT_LINE('급여를 ' || :OLD.salary || '에서 ' || :NEW.salary || '로 변경!!!');
  DBMS_OUTPUT.NEW_LINE;
  
  INSERT INTO salary_logs VALUES (SYSTIMESTAMP, :OLD.last_name, :OLD.salary, :NEW.salary, 'UPD', USER);
  COMMIT;
  
  :NEW.salary := 9999;
END;
/

CREATE OR REPLACE TRIGGER emp_update_row_trg04
  AFTER UPDATE ON emp_temp
  REFERENCING NEW AS REVISED
  FOR EACH ROW
DECLARE
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  DBMS_OUTPUT.PUT_LINE('UPDATE AFTER 행 레벨 트리거 실행!!!');
  DBMS_OUTPUT.PUT_LINE('급여를 ' || :OLD.salary || '에서 ' || :REVISED.salary || '로 변경!!!');
  DBMS_OUTPUT.NEW_LINE;

 -- INSERT INTO salary_logs VALUES (SYSTIMESTAMP, :OLD.last_name, :OLD.salary, :NEW.salary, 'UPD', USER);
  INSERT INTO salary_logs VALUES (SYSTIMESTAMP, :OLD.last_name, :OLD.salary, NULL, 'UPD', USER);
  COMMIT;
  
  -- :REVISED.salary := 1111;
END; 
/

SELECT * FROM emp_temp;
SELECT * FROM salary_logs;

UPDATE emp_temp
SET salary = salary + 100
WHERE employee_id = 100;

SELECT * FROM emp_temp;
SELECT * FROM salary_logs;

ROLLBACK;

SELECT * FROM emp_temp;
SELECT * FROM salary_logs;

-- 트리거 제거
BEGIN
  FOR i IN 1..2 LOOP
    BEGIN
      EXECUTE IMMEDIATE 'DROP TRIGGER emp_update_row_trg0' || i;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;
  END LOOP;
END;
/

-- [실습] DML 종류에 따른 조건 처리
CREATE OR REPLACE TRIGGER emp_dml_trg
  BEFORE UPDATE OF salary OR DELETE OR INSERT ON emp_temp
  FOR EACH ROW
DECLARE
  msg VARCHAR2(1000) := '';
BEGIN
  -- 특정 사번의 급여 업데이트 방지
  IF UPDATING THEN
    IF :OLD.employee_id = 100 THEN
      msg := '사번 100번 사원의 급여는 수정할 수 없습니다';
      RAISE_APPLICATION_ERROR(-20001, msg);
    END IF;
  END IF;
  
  -- 특정 사번에 대한 삭제 방지
  IF DELETING THEN
    IF :OLD.employee_id = 100 THEN
      msg := '사번 100 번 사원은 삭제할 수 없습니다';
      RAISE_APPLICATION_ERROR(-20002, msg);
    END IF;
  END IF;

  -- 특정 사번에 대한 입력 방지
  IF INSERTING THEN
    IF :NEW.employee_id = 300 THEN
      msg := '300 번 사번은 입력할 수 없습니다';
      RAISE_APPLICATION_ERROR(-20003, msg);
    END IF;
  END IF;
END;
/

-- [테스트]
UPDATE emp_temp
SET commission_pct = 0.1
WHERE employee_id = 100;

UPDATE emp_temp
SET salary = salary + 1000
WHERE employee_id = 100;

SELECT * FROM emp_temp;

INSERT INTO emp_temp(employee_id, last_name, email, hire_date, job_id) 
  VALUES (300, 'Hong', 'Hong@test', SYSDATE, 'IT_PROG');

INSERT INTO emp_temp(employee_id, last_name, email, hire_date, job_id) 
  VALUES (301, 'Hong', 'Hong@test', SYSDATE, 'IT_PROG');

SELECT * FROM emp_temp;

DELETE FROM emp_temp
WHERE employee_id = 100;

DELETE FROM emp_temp
WHERE employee_id = 301;

-- [실습] DDL 트리거
-- DDL 이벤트는 PL/SQL 매뉴얼 참조

CREATE OR REPLACE TRIGGER event_create
  AFTER CREATE ON SCHEMA
BEGIN
  DBMS_OUTPUT.PUT_LINE('CREATE OBJECT TYPE : ' || ORA_DICT_OBJ_TYPE) ;
  DBMS_OUTPUT.PUT_LINE('CREATE OBJECT NAME : ' || ORA_DICT_OBJ_NAME) ;
END ;
/


-- [실습] DDL 트리거 + 예외 발생
CREATE OR REPLACE TRIGGER event_drop
  BEFORE DROP OR TRUNCATE ON SCHEMA
BEGIN   
  RAISE_APPLICATION_ERROR(-20000, 'You can''t drop or truncate  a named ' ||  ORA_DICT_OBJ_NAME || ' requeted by ' || ORA_DICT_OBJ_OWNER );
END ;
/

-- [실습] 데이터베이스 트리거: 계정 로그인/로그아웃 트리거
CREATE OR REPLACE TRIGGER logon_trig
  AFTER LOGON ON SCHEMA
BEGIN
  INSERT INTO log_trig_table(user_id, log_date, action)
  VALUES (USER, SYSDATE, 'Logging on');
END;
/

-- 추가
CREATE TABLE log_trig_table (
  user_id VARCHAR2(30),
  log_date DATE,
  action VARCHAR2(20)
);

-- [실습] INSTEAD OF Trigger
-- 테스트 용 테이블 생성
DROP TABLE emp_test;
CREATE TABLE emp_test(empno, ename, sal, deptno)
AS 
SELECT employee_id, last_name, salary, department_id
WHERE ROWNUM <= 10;

DROP TABLE dept_test;
CREATE TABLE dept_test(deptno, dname)
AS
SELECT department_id, department_name
FROM departments
WHERE ROWNUM <= 5;

-- 테스트 용 뷰 생성
CREATE OR REPLACE VIEW emp_dept_vu(department_name, employee_id, employee_name)
AS
SELECT d.dname, e.empno, e.ename
FROM dept_test d, emp_test e
WHERE d.deptno = e.deptno;

-- 뷰를 통해 DML 시도
INSERT INTO emp_dept_vu VALUES (...);

CREATE OR REPLACE TRIGGER emp_dept_trg
  INSTEAD OF INSERT ON emp_dept_vu
BEGIN
  INSERT INTO departments VALUES (
  INSERT INTO employees VALUES (
END;
/






