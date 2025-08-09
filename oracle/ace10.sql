SELECT * FROM dept_temp
WHERE deptno > 200;

COMMIT;

SELECT * FROM dept_temp;

--

CREATE OR REPLACE PROCEDURE p (
  a IN PLS_INTEGER,
  b IN PLS_INTEGER,
  c IN OUT PLS_INTEGER,
  d IN OUT BINARY_FLOAT -- 사이즈 지정 X
) IS
BEGIN
  -- 단순히 c와 d 값을 변경
  c := c + b;
  d := d + 10.0;
END;
/


SET SERVEROUTPUT ON;

DECLARE
  aa  CONSTANT PLS_INTEGER := 1;
  bb  PLS_INTEGER := 2;
  cc  PLS_INTEGER := 3;
  dd  BINARY_FLOAT := 4;
  ee  PLS_INTEGER;
  ff  BINARY_FLOAT := 5;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Before invoking procedure p:');
  DBMS_OUTPUT.PUT_LINE('aa = ' || TO_CHAR(aa));
  DBMS_OUTPUT.PUT_LINE('bb = ' || TO_CHAR(bb));
  DBMS_OUTPUT.PUT_LINE('cc = ' || TO_CHAR(cc));
  DBMS_OUTPUT.PUT_LINE('dd = ' || TO_CHAR(dd));

  p(aa, bb, cc, dd);

  DBMS_OUTPUT.PUT_LINE('After invoking procedure p:');
  DBMS_OUTPUT.PUT_LINE('aa = ' || TO_CHAR(aa));
  DBMS_OUTPUT.PUT_LINE('bb = ' || TO_CHAR(bb));
  DBMS_OUTPUT.PUT_LINE('cc = ' || TO_CHAR(cc));
  DBMS_OUTPUT.PUT_LINE('dd = ' || TO_CHAR(dd));

  DBMS_OUTPUT.PUT_LINE('Before invoking procedure p (again):');
  DBMS_OUTPUT.PUT_LINE('ee = ' || TO_CHAR(ee));
  DBMS_OUTPUT.PUT_LINE('ff = ' || TO_CHAR(ff));

  p(1, (bb + 3) * 4, ee, ff);

  DBMS_OUTPUT.PUT_LINE('After invoking procedure p (again):');
  DBMS_OUTPUT.PUT_LINE('ee = ' || TO_CHAR(ee));
  DBMS_OUTPUT.PUT_LINE('ff = ' || TO_CHAR(ff));
END;
/

DECLARE
  TYPE r_type_1 IS RECORD (
    x NUMBER,
    y NUMBER
  );

  TYPE r_type_2 IS TABLE OF VARCHAR2(50) INDEX BY BINARY_INTEGER;

  a r_type_1;
  b r_type_2;
  c VARCHAR(10) := 'Hi';
BEGIN
  a.x := 10;
  a.y := 20;

  b(1) := 'Hello';
  b(2) := 'World';

  DBMS_OUTPUT.PUT_LINE('c = ' || c);
  DBMS_OUTPUT.PUT_LINE('a.x = ' || a.x || ', a.y = ' || a.y);
  DBMS_OUTPUT.PUT_LINE('b(1) = ' || b(1) || ', b(2) = ' || b(2));
END;
/

--
CREATE OR REPLACE PACKAGE emp_info_pkg AS
   
   -- 타입 선언
   TYPE emprectyp IS RECORD (empno employees.employee_id%TYPE, 
                             ename employees.last_name%TYPE,
                             sal employees.salary%TYPE);
   
   -- 함수 선언
   FUNCTION get_ename_func(p_empno NUMBER) 
   RETURN emprectyp;
   
   -- 프로시저 선언
   PROCEDURE get_dname_proc(p_deptno IN NUMBER, p_dname OUT VARCHAR2);   
   PROCEDURE raise_salary_proc(p_emp_id NUMBER, p_grade VARCHAR2, p_amount NUMBER);
   
   -- 전역 변수 선언
   g_hired_cnt NUMBER;  
   
   -- 예외 처리 변수 선언
   invalid_salary EXCEPTION;

END emp_info_pkg;
/

--
CREATE OR REPLACE PACKAGE BODY emp_info_pkg AS  
   -- 패키지 명세에서 선언한 함수 내용
   -- 사원 정보 조회 함수
   FUNCTION get_ename_func(p_empno NUMBER) 
   -- 리턴될 타입 선언
   RETURN emprectyp 
   IS
     l_emprec emprectyp;
   BEGIN
      -- 암묵적 커서 선언하여 emprectyp 레코드 타입 변수에 결과 저장
      SELECT employee_id, last_name, salary
        INTO l_emprec
        FROM employees
       WHERE employee_id = p_empno;      

      -- 함수가 호출될 때마다 전역변수의 값이 1씩 증가
      g_hired_cnt := g_hired_cnt + 1;      

      -- 사원 레코드 반환
      RETURN l_emprec;
   END get_ename_func;

   -- 패키지 명세에서 선언한 프로시저 내용
   -- 부서 정보 조회 함수
   PROCEDURE get_dname_proc(p_deptno IN NUMBER, p_dname OUT VARCHAR2) 
   IS
   BEGIN
      -- 부서 이름 저장
      SELECT department_name
        INTO p_dname
        FROM departments
       WHERE department_id = p_deptno;
   END get_dname_proc;

   -- 패키지 내부에서만 사용 가능한 함수 선언
   -- salary의 등급이 적정한지 여부 확인하여 Boolean 타입 반환
   FUNCTION sal_ok_func(p_grade VARCHAR2, p_salary NUMBER) 
   RETURN BOOLEAN IS
      l_min_sal NUMBER;
      l_max_sal NUMBER;
   BEGIN
      SELECT min_salary, max_salary
        INTO l_min_sal, l_max_sal
        FROM jobs
       WHERE job_id = p_grade;

      -- 범위 안에 p_salary의 값이 있으면 True, 그렇지 않으면 False 반환
--      RETURN (p_salary >= l_min_sal) AND (p_salary <= l_max_sal);
      RETURN p_salary BETWEEN l_min_sal AND l_max_sal;
   END sal_ok_func;

   -- 패키지 명세에서 선언한 프로시저 내용
   PROCEDURE raise_salary_proc(p_emp_id NUMBER, p_grade VARCHAR2, p_amount NUMBER) 
   IS
      l_salary NUMBER;
   BEGIN
      -- sal정보를 저장
      SELECT salary 
        INTO l_salary 
        FROM employees 
       WHERE employee_id = p_emp_id;
      
      -- SAL 등급을 확인하여 True이면 Update 아니면 예외발생
      IF sal_ok_func(p_grade, l_salary + p_amount) THEN
         UPDATE employees 
         SET salary = salary + p_amount 
         WHERE employee_id = p_emp_id;
      ELSE
         RAISE invalid_salary;
      END IF;
   END raise_salary_proc; 

BEGIN
   -- 패키지 실행 시 초기화
   g_hired_cnt := 0;

END emp_info_pkg;
/

-- [실습] 패키지 확인
desc emp_info_pkg
desc emp_info_pkg.get_dname_proc  -- ERROR

-- [실습] 패키지 내에 정의된 타입 사용 및 중첩 함수 호출
DECLARE
  -- 패키지에서 정의한 레코드 타입 선언
  emp_rec emp_info_pkg.emprectyp;
BEGIN
  BEGIN  -- 내부 블록 시작 (예외처리용)
    -- 레코드 타입 변수에 함수 결과 리턴
    emp_rec := emp_info_pkg.get_ename_func(120);

    DBMS_OUTPUT.PUT_LINE('empno : ' || emp_rec.empno);
    DBMS_OUTPUT.PUT_LINE('ename : ' || emp_rec.ename);
    DBMS_OUTPUT.PUT_LINE('sal   : ' || emp_rec.sal);

    -- 함수가 호출된 카운트를 저장하는 전역변수 출력
    DBMS_OUTPUT.PUT_LINE('g_hired_cnt : ' || emp_info_pkg.g_hired_cnt);

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('해당 사번의 직원이 존재하지 않습니다.');
  END;
END;
/

-- [실습] 패키지 내의 중첩 프로시저 호출
DECLARE
  l_dname departments.department_name%TYPE;
BEGIN  
  -- 프로시저 호출
  emp_info_pkg.get_dname_proc(10, l_dname);
  
  DBMS_OUTPUT.PUT_LINE('dname : ' || l_dname);
END;
/

-- [실습] 예외가 발생하는 경우
DECLARE
  l_empno  NUMBER := 124;
  l_grade  VARCHAR2(20) := 'ST_MAN';
  l_amount NUMBER := 1000;
BEGIN  
  -- 프로시저 호출
  emp_info_pkg.raise_salary_proc(l_empno, l_grade, l_amount);

END;
/

-- [실습] Basic LOOP
DECLARE
  l_cnt NUMBER := 1;
BEGIN
  -- loop를 돌며 clob데이터 출력
  LOOP
    EXIT WHEN l_cnt > 100;

    DBMS_OUTPUT.PUT_LINE('cnt : ' || l_cnt);
    l_cnt := l_cnt + 1;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('--------------------');
  
  LOOP
    IF l_cnt > 150 THEN
      DBMS_OUTPUT.PUT_LINE('EXIT를 실행하기 직전입니다.');
      EXIT;
    END IF;

    DBMS_OUTPUT.PUT_LINE('cnt : ' || l_cnt);
    l_cnt := l_cnt + 1;
  END LOOP;
  
END;
/

-- [실습] 중첩 루프와 레이블
DECLARE
   -- subtype을 이용한 새로운 변수 타입 설정
  SUBTYPE count_type IS NUMBER(3);  
  l_cnt count_type NOT NULL := 0;
BEGIN
-- goto 활용을 위한 outer 레이블 설정
  <<outer>>     
  LOOP
    DBMS_OUTPUT.PUT_LINE('outer loop1');
    -- inner 레이블 설정
    <<inner>>
    LOOP
      l_cnt := l_cnt + 1;
      DBMS_OUTPUT.PUT_LINE('inner loop : count =' || l_cnt);
       
      -- l_cnt가 5가 되면 outer레이블 밖으로 빠져나감
      EXIT outer WHEN l_cnt = 5;   
      -- l_cnt가 3이면 이전 loop 밖으로 빠져나감
      EXIT WHEN l_cnt = 3;         
    END LOOP;

    -- l_cnt가 100이 되면 이전 loop 밖으로 빠져나감
    EXIT WHEN l_cnt >= 100;

    DBMS_OUTPUT.PUT_LINE('outer loop2 : l_cnt='||l_cnt);
  END LOOP;
   
  DBMS_OUTPUT.PUT_LINE('out of loop : l_cnt='||l_cnt);
   
  -- final 레이블로 분기
  GOTO final;     

  DBMS_OUTPUT.PUT_LINE('Never executed!!!');   

-- final 레이블 설정
  <<final>>
  DBMS_OUTPUT.PUT_LINE('Final');

  RETURN;

  DBMS_OUTPUT.PUT_LINE('Never executed!!!');   

END;
/

-- [실습] WHILE LOOP
DECLARE
  l_cnt NUMBER := 0;
BEGIN  
  WHILE l_cnt <= 3 LOOP
    UPDATE employees
    SET commission_pct = 0 
    WHERE employee_id = 200 + l_cnt;
    
    DBMS_OUTPUT.PUT_LINE('UPDATED!!!');
    l_cnt := l_cnt + 1;
  END LOOP;
  
  ROLLBACK;
END;
/

-- [실습] FOR LOOP 문
DECLARE
  l_ename VARCHAR2(20);
BEGIN
  FOR i IN 1..20 LOOP
    SELECT NVL(MAX(last_name), 'NULL') 
    INTO l_ename
    FROM employees
    WHERE employee_id = 200 + i;   
       
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || l_ename);
    
    -- i := i + 2;  -- FOR 문의 인덱스 변수 i를 수정하면 안됨
  END LOOP;
  
  -- DBMS_OUTPUT.PUT_LINE('i: ' || i); -- FOR 문의 로컬 변수 i는 FOR 문 내에서만 접근 가능
END;
/

-- [실습] FOR LOOP with REVERSE
DECLARE
  l_ename VARCHAR2(20);
BEGIN
  FOR i IN REVERSE 1..20 LOOP
    SELECT NVL(MAX(last_name), 'NULL') 
    INTO l_ename
    FROM employees
    WHERE employee_id = 200 + i;   
       
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || l_ename);
  END LOOP; 
END;
/

-- [실습] 커서에서 한 건만 추출
CREATE OR REPLACE FUNCTION get_ename_func(p_empno IN NUMBER) 
RETURN VARCHAR2
IS   
   -- 명시적 커서 선언
  CURSOR c1 IS                    
    SELECT last_name 
    FROM employees
    WHERE employee_id = p_empno;
  -- 추출 칼럼과 같은 타입의 변수 선언
  l_ename employees.last_name%TYPE;      
BEGIN   
  -- 커서 오픈
  OPEN c1;       
  -- 데이터 추출 후 INTO절 안의 변수에 입력
  FETCH c1 INTO l_ename;
  -- 추출 결과 건수가 0일 경우 
  IF c1%NOTFOUND THEN
    l_ename := NULL;
  END IF;
  -- 커서 닫기
  CLOSE c1;

  RETURN l_ename;
END;
/


--
SELECT get_ename_func(employee_id)
FROM employees
WHERE job_id = 'IT_PROG';

-- [실습] 근면성실한 방법: 커서 OPEN - LOOP - FETCH - CLOSE
DECLARE
  -- 명시적 커서 선언 (매개변수 전달)
  CURSOR c1(p_deptno NUMBER,      
            p_job    VARCHAR2)     
  IS                          
    SELECT *
    FROM employees
    WHERE department_id = p_deptno
      AND job_id = p_job;  
  -- 커서 c1과 같은 레코드 타입 선언
  emp_rec c1%ROWTYPE;
BEGIN
  -- 방법 1. 커서 OPEN, LOOP, FETCH, CLOSE를 이용한 데이터 추출
  -- 커서 오픈 (매개변수 전달)
  OPEN c1(80, 'SA_REP');
  -- 커서 내 데이터 반복 추출
  LOOP
    -- 커서 결과를 c1%ROWTYPE 변수에 입력 
    FETCH c1 INTO emp_rec;
    -- 커서 내 추출 데이터가 없을 경우 LOOP 빠져나감
    EXIT WHEN c1%NOTFOUND;
    -- 데이터 처리
    DBMS_OUTPUT.PUT_LINE('Name = ' || emp_rec.last_name || 
                         ', salary = ' || emp_rec.salary || 
                         ', Job Id = ' || emp_rec.job_id );
  END LOOP;
  
  -- 커서 닫기
  CLOSE c1;  
END;
/

-- [실습] 명시적 커서 FOR LOOP
DECLARE
  -- 명시적 커서 선언 (매개변수 전달)
  CURSOR c1(p_deptno NUMBER,      
            p_job    VARCHAR2)     
  IS                          
    SELECT *
    FROM employees
    WHERE department_id = p_deptno
      AND job_id = p_job;  
BEGIN
  FOR emp_rec IN c1(80, 'SA_REP') LOOP
    -- 데이터 처리
    DBMS_OUTPUT.PUT_LINE('Name = ' || emp_rec.last_name || 
                         ', salary = ' || emp_rec.salary || 
                         ', Job Id = ' || emp_rec.job_id );
  END LOOP;
END;
/

-- [실습] 암시적 커서 FOR LOOP
BEGIN
  FOR emp_rec IN (SELECT *
                  FROM employees   
                  WHERE department_id = 80
                  AND job_id = 'SA_REP') LOOP
    -- 데이터 처리
    DBMS_OUTPUT.PUT_LINE('Name = ' || emp_rec.last_name || 
                         ', salary = ' || emp_rec.salary || 
                         ', Job Id = ' || emp_rec.job_id );
  END LOOP;
END;
/

-- [실습] 커서 속성: %NOTFOUND, %ROWCOUNT
DECLARE
  -- dept 테이블 관련 커서 선언
  -- 커서 안에 p_deptno 변수를 이용해 매개변수를 전달함
  CURSOR c1(p_deptno NUMBER) 
  IS 
    SELECT * 
    FROM departments 
    WHERE department_id > p_deptno; 
   -- c1커서에서 반환되는 레코드 타입 변수 선언
   dept_rec c1%ROWTYPE;  
BEGIN
   -- 테스트 #1 (커서 ROWTYPE 변수를 이용한 OPEN, LOOP, FETCH, CLOSE를 활용한 데이터 추출 )
   DBMS_OUTPUT.PUT_LINE('<Test #1 - Open Cursor>');
   
   -- 매개변수와 함께 커서 오픈 
   OPEN c1(0);                 
   
   LOOP                         
      -- C1 Cursor를 Fetch하여 dept_rec 커서 변수에 입력
      FETCH c1 INTO dept_rec;  
      -- Cursor내 Data가 존재하는지 확인 후 없으면 빠져나감
      EXIT WHEN c1%NOTFOUND;      
      -- 직전 실행된 수행 건수   
      DBMS_OUTPUT.PUT_LINE(c1%ROWCOUNT || 'th row, deptno -> ' || dept_rec.department_id);  
   END LOOP; 
   
   -- 커서 결과 건수 확인
   DBMS_OUTPUT.PUT_LINE('Total rows : ' || c1%ROWCOUNT);
   
   -- 커서 CLOSE                      
   CLOSE c1;                  
   
END;
/

-- [실습] CURSOR FOR LOOP 바깥에서 커서 속성 접근 → 에러
DECLARE
  -- dept 테이블 관련 커서 선언
  -- 커서 안에 p_deptno 변수를 이용해 매개변수를 전달함
  CURSOR c1(p_deptno NUMBER) 
  IS
    SELECT * 
    FROM departments 
    WHERE department_id > p_deptno; 
BEGIN
  -- 테스트 #2 (FOR LOOP와 명시적 커서를 이용한 데이터 추출 )   
  DBMS_OUTPUT.PUT_LINE('<Test #2 - For Loop>');
   
  -- FOR LOOP 사용 시 자동으로 커서를 OPEN-FETCH-CLOSE 시킴
  FOR dept_rec IN c1(20) 
  LOOP
    DBMS_OUTPUT.PUT_LINE(c1%ROWCOUNT||'th row, deptno -> '||dept_rec.deptno);
  END LOOP;
  
  -- 커서가 자동으로 닫히므로 아래 주석 제거시 에러가 발생함
  DBMS_OUTPUT.PUT_LINE('Total rows : ' || c1%rowcount);     
   
END;
/

-- 암시적 커서 실습
DECLARE
  l_empno employees.employee_id%TYPE;
BEGIN
  -- SELECT 시 암시적 커서 사용
  -- SQL의 OPEN/FETCH/CLOSE가 자동으로 수행됨
  SELECT employee_id 
    INTO l_empno 
    FROM employees
   WHERE ROWNUM = 1; 
  
  -- DML시 암시적 커서 사용
  UPDATE employees
     SET salary = salary * 1.1 
   WHERE employee_id = 900;
  
  -- 수행 건수가 존재하는지 여부 확인
  IF SQL%FOUND THEN
    DBMS_OUTPUT.PUT_LINE ('Update succeeded');
  ELSE
    DBMS_OUTPUT.PUT_LINE ('Update failed');
  END IF;
  
  INSERT INTO employees 
  VALUES (900, 'Test', 'Kim', 'TKIM', NULL, SYSDATE, 'ST_CLERK', 1000, 0, 200, 10);
  
  DELETE FROM employees
  WHERE employee_id = 900;
  
  -- 최종 수행된 SQL문의 결과 건수만 반영
  DBMS_OUTPUT.PUT_LINE ('Number of rows deleted : ' || SQL%ROWCOUNT);
  
  ROLLBACK;
  
  -- COMMIT이나 ROLLBACK 수행 후 %ROWCOUNT 초기화
  DBMS_OUTPUT.PUT_LINE ('After commit or rollback : ' || SQL%ROWCOUNT);

END;
/

-- 
SELECT *
FROM employees
WHERE employee_id = 900;

-- 
DELETE FROM employees
WHERE employee_id = 900;

-- [예제] 동시성 문제를 내포하고 있는 CURSOR FOR LOOP + DML
DECLARE
  -- FOR UPDATE를 사용하지 않아 동시성 문제가 발생할 수 있음
  CURSOR c IS 
    SELECT * FROM employees;
BEGIN
  FOR rec IN c LOOP           
    -- empno에 해당하는 인덱스를 이용하여 업데이트 수행
    UPDATE employees          
    SET salary = salary + 0
    WHERE employee_id = rec.employee_id; 
  END LOOP; 
  
  COMMIT;
END;
/

-- [실습] 문제 1 해결: 커서에 FOR UPDATE 절 사용
DECLARE
  -- FOR UPDATE를 사용하지 않아 동시성 문제가 발생할 수 있음
  CURSOR c IS 
    SELECT * FROM employees
    FOR UPDATE NOWAIT;
BEGIN
  FOR rec IN c LOOP           
    -- empno에 해당하는 인덱스를 이용하여 업데이트 수행
    UPDATE employees          
    SET salary = salary + 0
    WHERE employee_id = rec.employee_id; 
  END LOOP; 
  
  COMMIT;
END;
/

-- [실습] 문제 2 해결 1) 커서에 ROWID 사용하여 DML 시 ROWID로 대상 행에 바로 접근
DECLARE
  CURSOR c IS 
    SELECT e.*, ROWID 
    FROM employees e;
BEGIN
  FOR rec IN c LOOP           
    -- rec.rowid 덕분에 인덱스를 거치지 않고 바로 테이블에 접근: 성능 향상 기대
    UPDATE employees          
    SET salary = salary + 0
    WHERE ROWID = rec.rowid; 
  END LOOP; 
  
  COMMIT;
END;
/

-- [실습] 문제 2 해결 2) CURRENT OF 절 사용, 커서에 FOR UPDATE 절 필요
DECLARE
  CURSOR c IS 
    SELECT * 
    FROM employees
    FOR UPDATE;
BEGIN
  FOR rec IN c LOOP           
    -- FOR UPDATE와 CURRENT OF 덕분에 인덱스를 거치지 않고 바로 테이블에 접근: 성능 향상 기대
    UPDATE employees          
    SET salary = salary + 0
    WHERE CURRENT OF c; 
  END LOOP; 
  
  COMMIT;
END;

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
<<outer>> 
DECLARE 
BEGIN 
  DBMS_OUTPUT.PUT_LINE('outer block logic1'); 
  
  <<inner>> 
  DECLARE 
    emp_no PLS_INTEGER;
  
    /* 에러코드(ORA-100)와 예외명(nodata)을 매핑하는 역할 */   
    nodata EXCEPTION;
    PRAGMA EXCEPTION_INIT(nodata, 100);      
  
  BEGIN 
    DBMS_OUTPUT.PUT_LINE('inner block logic1'); 
    SELECT employee_id INTO emp_no FROM employees WHERE employee_id = 333;
  
  EXCEPTION 
    -- NO_DATA_FOUND에 해당하는 NODATA 예외발생 시
    WHEN nodata THEN 
      DBMS_OUTPUT.PUT_LINE('inner nodata exception'); 
      DBMS_OUTPUT.PUT_LINE('Inner Error : '||SQLERRM(SQLCODE)); 
  END; 
  
  DBMS_OUTPUT.PUT_LINE('outer block logic2'); 

EXCEPTION 
  WHEN others THEN 
    DBMS_OUTPUT.PUT_LINE('outer other exception'); 
    DBMS_OUTPUT.PUT_LINE('Outer Error : '||SQLERRM(SQLCODE)); 
END; 
/

--
CREATE OR REPLACE PROCEDURE at1
IS
    -- 자율 트랜잭션 선언
  PRAGMA AUTONOMOUS_TRANSACTION; 
BEGIN
  UPDATE employees_temp SET salary = 1000 WHERE employee_id = 110;
--  COMMIT;
END;
/

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








