-- 7/7(월)
SELECT *
FROM employees
WHERE last_name = 'Hong';

-- FULL SACAN
SELECT *
FROM employees
WHERE LENGTH(last_name) = 4;

CREATE INDEX len_name_ix ON employees (LENGTH(last_name) desc);

CREATE TABLE c_emp
AS SELECT * FROM employees;

-- INDEX 생성
CREATE INDEX len_name_ix 
ON employees (LENGTH(last_name));

--
ALTER INDEX len_name_ix INVISIBLE;

-- 인덱스 못탐
SELECT *
FROM employees
WHERE upper(last_name) = 4;

-- emp90 뷰 생성
CREATE OR REPLACE VIEW emp90(empno, ename, sal, deptno)
AS SELECT employee_id, last_name, salary, department_id
    FROM employees
    WHERE department_id = 90;
    
-- 
SELECT *
FROM emp90;

SELECT view_name
FROM user_views
WHERE view_name = 'EM90';


-- 
INSERT INTO emp90 VALUES (222, 'Hong', 'hong@kosa.kr', sysdate, 'AAA', 90);

-- 홍 사원 데이터가 잘 입력됨
SELECT *
FROM emp90;

-- NULL
SELECT *
FROM emp90
WHERE empno = 333;

-- 기본 테이블 c_emp에 대해 333을 질의했더니 데이터 잘 보관됨
SELECT *
FROM c_emp
WHERE employee_id = 333;

-- WITH CHECK OPTION 제약 사용 시 위 불일치 문제 해결 가능
CREATE OR REPLACE VIEW emp90(empno, ename, email, hdate, job, deptno)
AS SELECT employee_id, last_name, email, hire_date, job_id, department_id
    FROM c_emp
    WHERE department_id = 90
WITH CHECK OPTION;

-- 삽입 실패
INSERT INTO emp90 VALUES (444, 'Kim', 'kim@kosa.kr', sysdate-7, 'CCC', 30);

SELECT *
FROM user_constraints
WHERE table_name = 'EMP90';

-- Subqery Factoring 절 = WITH 절
SELECT last_name, salary, department_id
FROM employees
WHERE ROWNUM <= 5
ORDER BY salary DESC; -- (x) 원하는 결과 아님. 정렬 보다 필터링 먼저 수행 

-- 해결
SELECT last_name, salary
FROM (
    SELECT last_name, salary
    FROM employees
    ORDER BY salary DESC
    )
WHERE ROWNUM <= 5;

-- 
WITH sal_desc(ename, sal, deptno) AS (
    SELECT last_name, salary, department_id
    FROM employees
    ORDER BY salary DESC),
    sal_group AS (
    SELECT deptno, AVG(sal)
    FROM sal_desc
    GROUP BY deptno)
SELECT *
FROM sal_desc, sal_group
WHERE sal_desc.deptno > sal_group.deptno
    AND ROWNUM <= 5;
    
--
WITH test(no, email, sal) AS (
    SELECT 1, 'Kim', 200 FROM dual UNION ALL
    SELECT 2, 'Lee', 300 FROM dual UNION ALL
    SELECT 3, 'Hong', 400 FROM dual)
    SELECT *
    FROM test
    WHERE sal > 300;
