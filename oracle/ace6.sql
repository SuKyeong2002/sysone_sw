-- 7/4 
desc recyclebin
SELECT * FROM recyclebin;

-- 프로젝트 할 때 필요 시 뷰 생성도 추천
CREATE OR REPLACE VIEW empvu
AS SELECT 
    employee_id 사원번호,   
    last_name 사원이름, 
    12 * salary 연봉,
    department_name 부서이름
FROM employees JOIN departments USING (department_id);

--
SELECT view_name, text
FROM user_views;

-- 
SELECT * 
FROM user_updatable_columns;

-- 
SELECT last_name, salary
FROM employees
WHERE UPPER(last_name) = 'King';

-- 인덱스 생성
CREATE INDEX emp_last_name_idx
    ON employees(last_name);
    

CREATE INDEX emp_job_sal_idx
    ON employees(job_id, salary);

CREATE UNIQUE INDEX emp_phone_idx
    ON employees(phone_number);
    
CREATE TABLE new_emp (
    employee_id NUMBER(6)
        PRIMARY KEY USING INDEX (
            CREATE INDEX emp_id_idx
                ON new_emp (employee_id)),
    first_name VARCHAR2(20),
    last_name VARCHAR2(25));
    
SELECT index_name, table_name
FROM USER_INDEXES
WHERE table_name = 'NEW_EMP';

-- DROP INDEX
DROP INDEX EMP_LAST_NAME_IDX;

-- LENGTH/LENGTHB
SELECT 
    LENGTH('오라클'), 
    LENGTHB('오라클'),
    LENGTH('Oracle')
FROM dual;

-- SUBSTR
SELECT last_name
    , SUBSTR(last_name, 3) AS name1
    , SUBSTR(last_name, 3, 2) AS name2
    , SUBSTR(last_name, -3, 2) AS name3
    , SUBSTR(last_name, -1, 1) AS name4
    , SUBSTR(last_name, 3, -2) AS name5
FROM employees;

-- INSTR
SELECT street_address
    , INSTR(street_address, 'a') AS name1
    , INSTR(street_address, 'a', 10) AS name2
    , INSTR(street_address, 'a', 1, 2) AS name3
    , INSTR(street_address, 'a', -1, 2) AS name4
    , INSTR(street_address, 'a', -4) AS name5
    , INSTR(street_address, 'an') AS name6
FROM locations;

-- LTRIM, RTRIM
SELECT 'SSESS'
    , LTRIM('SSESS', 'S') 
    , RTRIM('SSESS', 'S') 
    , LTRIM(RTRIM('SSESS', 'S'), 'S') 
FROM dual;

-- TRIM
SELECT 'SSESS'
    , TRIM(leading 'S' FROM 'SSESS') 
    , TRIM(trailing 'S' FROM 'SSESS')
    , TRIM(both 'S' FROM 'SSESS')
    , TRIM('S' FROM 'SSESS')
FROM dual;

-- 문자 함수 예제 1
SELECT employee_id, last_name, first_name
FROM employees
WHERE LENGTH(first_name) = 6;

-- 문자 함수 예제 1
SELECT employee_id, last_name, first_name
FROM employees
WHERE first_name LIKE '______';

-- 문자 함수 예제 2
SELECT employee_id, last_name, first_name
FROM employees
WHERE SUBSTR(last_name, 1, 1) = SUBSTR(last_name, -1, 1);

-- 문자 함수 예제 3
SELECT 
    last_name, 
    first_name, 
   SUBSTR(last_name, 1, 2) || '_' || UPPER(SUBSTR(job_id, 4, 2))
FROM employees;

-- ROUND 
SELECT 45.926
    , ROUND(45.926) round1
    , ROUND(45.926, 2) round2
    , ROUND(45.926, -2) round3
    , TRUNC(45.926, 2) trunc1
    , TRUNC(45.926, -1) trunc2
FROM dual;

-- CEIL, FLOOR
SELECT 45.926
    , CEIL(45.926) ceil1
    , CEIL(-45.926) ceil2
    , FLOOR(45.926) floor1
    , FLOOR(-45.926) floor2
    , TRUNC(45.926) trunc1
    , TRUNC(-45.926) trunc2
FROM dual;

SELECT salary
    , salary / 1000
    , CEIL(salary / 1000) AS 구분1
    , FLOOR(salary / 1000) AS 구분2
FROM employees;

SELECT last_name, job_id, salary
FROM employees
WHERE salary BETWEEN 4000 AND 4999;

SELECT last_name, job_id, salary
FROM employees
WHERE FLOOR(salary / 1000) = 4;

SELECT last_name, job_id, salary
FROM employees
WHERE FLOOR(salary / 1000) IN (4, 6);

-- 날짜 리터럴
SELECT DATE '1234-05-06' AS 기념일,
        TIMESTAMP '1234-05-06 13:14:15.123456789'
FROM dual;

-- 날짜 데이터에 대한 산술 연산
SELECT DATE '2001-04-13'
    , DATE '2001-04-13' + 1
    , DATE '2001-04-13' + 1/24
    , DATE '2001-04-13' - 1/24 + 15/24/60
    , TIMESTAMP '2001-04-13 13:12:42' - (2/24 + 14/(24*60))
FROM dual;

SELECT DATE '2001-04-13'
    , TO_CHAR(TIMESTAMP '2001-04-13 00:00:00' + 1, 'YYYY-MM-DD HH24:MI:SS')
    , TO_CHAR(TIMESTAMP '2001-04-13 00:00:00' + 1/24, 'YYYY-MM-DD HH24:MI:SS')
    , TO_CHAR(TIMESTAMP '2001-04-13 00:00:00' - 1/24 + 15/24/60, 'YYYY-MM-DD HH24:MI:SS')
    , TO_CHAR(TIMESTAMP '2001-04-13 13:12:42' - 2/24 + 14/(24*60), 'YYYY-MM-DD HH24:MI:SS')
FROM dual;

SELECT last_name, salary, hire_date
        , hire_date + 1
        , hire_date + 7
FROM employees;

SELECT DATE '2001-04-13' -  DATE '2001-04-12'
    , DATE '2001-04-13' -  DATE '2001-03-13'
    , DATE '2001-04-13' -  DATE '2000-04-13'
    , TIMESTAMP '2001-04-13 13:12:42' - DATE '2001-04-13'
FROM dual;

SELECT last_name, salary, hire_date
    , (DATE '2020-01-01' - hire_date) / 7
    AS working_weeks
FROM employees
WHERE DATE '2020-01-01' - hire_date > 5000;

SELECT SYSDATE, SYSTIMESTAMP
FROM dual;

SELECT CURRENT_DATE, CURRENT_TIMESTAMP, LOCALTIMESTAMP
FROM dual;

-- DISTINCT
SELECT job_id, COUNT(job_id), COUNT(DISTINCT job_id)
FROM employees
WHERE department_id = 50
GROUP BY job_id;

-- 그룹 함수와 NULL 값
SELECT c1, SUM(c1), AVG(c1), COUNT(c1)
FROM test
GROUP BY c1;

SELECT AVG(commission_pct), 
        SUM(commission_pct) / COUNT(employee_id)
FROM employees;

-- 예외
SELECT c1, COUNT(c1), COUNT(Distinct c1), COUNT(*)
FROM test
GROUP BY c1;

SELECT AVG(commission_pct), 
        SUM(commission_pct) / COUNT(commission_pct),
        SUM(commission_pct) / COUNT(*)
FROM employees;

-- NULL 허용
SELECT AVG(commission_pct), 
        SUM(commission_pct) / COUNT(commission_pct),
        AVG(NVL(commission_pct, 0)),
        SUM(commission_pct) / COUNT(*)
FROM employees;

-- 문제
SELECT COUNT(employee_id)
FROM employees
WHERE MOD(TO_NUMBER(TO_CHAR(hire_date, 'DD')), 2) = 1
    AND (commission_pct IS NOT NULL);
    
-- 예제
SELECT department_id AS 부서번호, AVG(salary) AS 평균급여
FROM employees
GROUP BY department_id;

-- 예제
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY department_id, job_id;

SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id;

SELECT LENGTH(last_name) || '글자' AS 성,
        COUNT(last_name) AS 사원수
FROM employees
GROUP BY LENGTH(last_name);

-- HAVING
SELECT department_id, SUM(salary), COUNT(salary)
FROM employees
WHERE department_id IN (30, 50, 70)
GROUP BY department_id
HAVING COUNT(salary) >= 3;

SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 10000;

SELECT job_id, SUM(salary) AS payroll
FROM employees
WHERE job_id NOT LIKE '%REP%'
GROUP BY job_id
HAVING SUM(salary) > 13000
ORDER BY SUM(salary);

SELECT job_id, SUM(salary) AS payroll, COUNT(salary)
FROM employees
WHERE job_id NOT LIKE '%REP%'
GROUP BY job_id
HAVING COUNT(salary) <= 3
ORDER BY SUM(salary);

SELECT last_name, department_name
FROM employees CROSS JOIN departments;

SELECT last_name, department_name
FROM employees, departments;
