DECLARE
  p1 PLS_INTEGER := 2147483647;
  p2 INTEGER := 1;
  n NUMBER;
BEGIN
  n := p1 + p2;
  DBMS_OUTPUT.PUT_LINE(n);
END;

DECLARE
  -- 새로운 레코드 타입 생성
  TYPE emp_record IS RECORD (empno NUMBER, ename VARCHAR2(20));
  emp_rec emp_record ;
  
  -- 레코드란게 없었다면 필드를 각각 선언해야 함
  empno NUMBER;
  ename VARCHAR2(20);

BEGIN
 -- 레코드 타입 변수에 모든 칼럼의 값을 한번에 입력
  SELECT employee_id, last_name 
    INTO emp_rec
    FROM employees  
   WHERE rownum = 1;
     -- 레코드 내 각 칼럼의 값을 개별적으로 출력
  DBMS_OUTPUT.PUT_LINE('empno : ' || emp_rec.empno);
  DBMS_OUTPUT.PUT_LINE('ename : ' || emp_rec.ename);

  -- 레코드란게 없었다면
  SELECT employee_id, last_name
  INTO empno, ename
  FROM employees
  WHERE ROWNUM = 1;
  
  DBMS_OUTPUT.PUT_LINE('empno : ' || empno);
  DBMS_OUTPUT.PUT_LINE('ename : ' || ename);

END;

-- 3.
DECLARE
  -- DEPT테이블의 DNAME과 같은 타입의 변수 선언
  l_dname  departments.department_name%TYPE;
  
  
  -- DEPT테이블의 행과 같은 레코드 변수 선언
  dept_rec1  departments%ROWTYPE;
  

  -- DEPT테이블에서 일부 칼럼들만 추출하는 커서 선언
  CURSOR c1 IS  
    SELECT  department_id AS deptno, department_name AS dname, location_id AS loc
    FROM departments;
  
  -- C1 커서의 칼럼을 다 담을 수 있는 레코드 변수 선언
  dept_rec2  c1%ROWTYPE;

BEGIN

  -- DEPT 테이블의 한 행의 칼럼을 %ROWTYPE의 레코드 변수에 한번에 저장
  SELECT * 
    INTO dept_rec1
    FROM departments  
   WHERE rownum = 1;

  -- 레코드 내 각 칼럼의 값을 개별적으로 출력함
  DBMS_OUTPUT.PUT_LINE('deptno : ' || dept_rec1.department_id || 
                       ' dname : ' || dept_rec1.department_name);
  
  
  -- DEPT테이블의 dname 칼럼의 값을 %TYPE의 변수에 저장
  l_dname := dept_rec1.department_name;
  
  -- 변수에 저장된 값을 출력함
  DBMS_OUTPUT.PUT_LINE('dname : ' || l_dname);
  
  
  -- 커서에서 추출된 모든 칼럼을 %ROWTYPE의 레코드 변수에 한번에 저장
  OPEN c1;
  FETCH c1 INTO dept_rec2;
  
  -- 레코드 내 각 칼럼의 값을 개별적으로 출력함
  DBMS_OUTPUT.PUT_LINE('deptno : ' || dept_rec2.deptno || ' dname : ' || dept_rec2.dname);
  
  CLOSE c1;

END;

-- 4.
DECLARE
  l_num_empno NUMBER;
  l_var_empno VARCHAR2(100);
  
BEGIN
  -- Number형의 값을 VARCHAR2 형 변수에 입력
  SELECT employee_id
    INTO l_var_empno
    FROM employees
   WHERE ROWNUM = 1;
  
  DBMS_OUTPUT.PUT_LINE('empno (number to varchar2) : ' || l_var_empno);

  -- VARCHAR2형 변수를 이용하여 연산을 수행
  l_num_empno := l_var_empno + 1;
  
  DBMS_OUTPUT.PUT_LINE('empno (varchar2 to number) : ' || l_num_empno);
  
END;

--
DECLARE
  l_num_empno NUMBER;
  l_var_empno VARCHAR2(100);
  
BEGIN
  -- Number형의 값을 VARCHAR2 형 변수에 입력
  SELECT employee_id
    INTO l_var_empno
    FROM employees
   WHERE ROWNUM = 1;
  
  DBMS_OUTPUT.PUT_LINE('empno (number to varchar2) : ' || l_var_empno);

  -- VARCHAR2형 변수를 이용하여 연산을 수행
  l_num_empno := l_var_empno + 1;
  
  DBMS_OUTPUT.PUT_LINE('empno (varchar2 to number) : ' || l_num_empno);
  
END;

--
DECLARE
  l_num_empno NUMBER;
  l_var_empno VARCHAR2(100);
  
BEGIN
  -- Number형의 값을 VARCHAR2 형 변수에 입력
  SELECT employee_id
    INTO l_var_empno
    FROM   employees
   WHERE  rownum = 1;
  
  DBMS_OUTPUT.PUT_LINE('empno (number to varchar2) : ' || l_var_empno);
  

  -- VARCHAR2형 변수에 '+ 1' 문자열을 추가
  l_num_empno := l_var_empno || '+ 1';  -- '100+ 1'
  
  DBMS_OUTPUT.PUT_LINE('empno (varchar2 to number) : ' || l_num_empno);
  
END;

-- Insert 작업
BEGIN
  INSERT INTO employees 
  VALUES (900, 'Test', 'Kim', 'TKIM', NULL, SYSDATE, 'ST_CLERK', 1000, 0, 200, 10);
END;

SELECT * FROM employees;

-- Update 작업
BEGIN
  UPDATE employees
  SET salary = salary + 100
  WHERE employee_id = 900;
END;

SELECT * FROM employees
WHERE employee_id = 900;

SELECT *
FROM employees
WHERE department_id = &deptno
ORDER BY &od;

set verify on

SET SERVEROUTPUT ON;

-- employees 테이블에서 사원번호가 143번인 사원의 사원번호와 이름을 조회해서 
-- 변수에 저장한 후 화면에 출력
SET SERVEROUTPUT ON;

DECLARE
    l_emprec employees%ROWTYPE;
    l_no employees.employee_id%TYPE := 143;
BEGIN
    SELECT *
    INTO l_emprec
    FROM employees
    WHERE employee_id = l_no;

    DBMS_OUTPUT.PUT_LINE('사원번호: ' || l_emprec.employee_id || ' ,  이름: ' || l_emprec.last_name);
END;
/

SELECT *
FROM employees
WHERE last_name = &ename;




