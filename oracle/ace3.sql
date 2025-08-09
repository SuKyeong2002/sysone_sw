SELECT *
FROM employees
WHERE department_id = ?;

SELECT *
FROM employees
WHERE  salary > ?
ORDER BY last_name;

SELECT *
FROM employees;

SELECT ROWNUM, departments.*
FROM departments;

DROP TABLE TEST;

CREATE TABLE "From" (no NUMBER);
CREATE TABLE Prop (no NUMBER);

INSERT INTO prop VALUES (1);
INSERT INTO prop VALUES (2);
INSERT INTO prop VALUES (3);

--INSERT INTO from VALUES (1);
INSERT INTO "from" VALUES (1);
INSERT INTO "FROM" VALUES (2);

CREATE TABLE dept90
AS SELECT last_name, salary
    FROM employees
    WHERE department_id=90;
    
DROP TABLE dept90;

CREATE TABLE dept90
SELECT first_name || ' ' || last_name AS name, salary*12 AS annual_salary
    FROM employees
    WHERE department_id=90;
    
SELECT *
FROM annusalvu
WHERE annsal > 100000;

    
-- 문제) 연봉이 10만 달러가 넘는 사원을 보고하세요
CREATE VIEW annusalvu
AS  SELECT last_name, salary, 12*salary AS annsal
    FROM employees;

SELECT last_name, salary, hire_date
FROM employees;

SELECT *
FROM employees
WHERE hire_date = DATE '1998-07-09';  

SELECT UNIQUE job_id
FROM employees;

-- 실습
SELECT Distinct commission_pct
FROM employees;

-- SQL 연산자 실습 1
SELECT employee_id, last_name, salary, salary*12 as "ann_sal"
FROM employees;

-- SQL 연산자 실습 2
SELECT employee_id, last_name, job_id, salary, COMMISSION_PCT
FROM employees;

-- SQL 연산자 실습 3
SELECT  employee_id, last_name, salary, 3 * salary AS quarterly_salary
FROM employees;

-- 연결 연산자
SELECT '[' || department_id || ']' || last_name || '_' || job_id
FROM employees;

desc nls_session_parameters;

SELECT *
FROM nls_session_parameters;

SELECT last_name, hire_date
FROM employees;

SELECT last_name, TO_CHAR(hire_date, 'yyyy-mm-dd') AS 입사일
FROM employees;

SELECT last_name, hire_date
FROM employees
WHERE hire_date > '99.september.09';

-- ALTER SESSION SET
ALTER SESSION SET nls_date_format = 'rr-mon-ddd hh24:mi:ss';
ALTER SESSION SET nls_date_language = 'american';
ALTER SESSION SET nls_date_format = 'rr-Month-dd';

-- AND
SELECT *
FROM employees
WHERE manager_id = 100 AND  manager_id = 101;

-- %
SELECT *
FROM employees
WHERE last_name LIKE '%n%';

-- IS NOT NULL
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

-- IN ()
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IN (SELECT commission_pct FROM employees);

-- NOT 1
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct BETWEEN 0.1 AND 0.2;

SELECT last_name, salary, commission_pct
FROM employees
WHERE NOT commission_pct BETWEEN 0.1 AND 0.2;

-- NOT 2
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct NOT BETWEEN 0.1 AND 0.2;

-- 연봉 구하기
SELECT last_name, salary, 12 * salary * (1 + commission_pct) AS 연봉
FROM employees;

-- dual: 한 건만 검색
SELECT sysdate, current_date 
FROM dual;

--  0 * NULL : NULL
SELECT 0 * NULL 
FROM dual;

-- 의사컬럼
SELECT ROWNUM, SYSDATE
FROM employees;

-- order by 예제
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY last_name DESC, hire_date; 

-- order by 예제
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY LENGTH(last_name);

-- all_objects 상태 확인
desc all_objects

-- all_objects 세부 상태 확인
SELECT owner, object_name, object_type
From all_objects;

-- 이름이 6자인 사원들의 사원번호, 성, 이름을 출력하시오
SELECT employee_id, last_name, first_name
FROM employees
WHERE LENGTH(first_name) = 6;

-- 소수점 이하/이상 몇 째 자리에서 반올림?버림?
SELECT 45.926
    , ROUND(45.926) round1
     , ROUND(45.926, 2) round2
      , ROUND(45.926, -2) round3
FROM dual;
