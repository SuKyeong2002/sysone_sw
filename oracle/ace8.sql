INSERT INTO t_reg
  SELECT 'ABC123' FROM dual UNION ALL
  SELECT 'ABC 123' FROM dual UNION ALL
  SELECT 'ABC  123' FROM dual UNION ALL
  SELECT 'abc 123' FROM dual UNION ALL
  SELECT 'abc  123' FROM dual UNION ALL
  SELECT 'a1b2c3' FROM dual UNION ALL
  SELECT 'aabbcc123' FROM dual UNION ALL
  SELECT '?/!@#$&' FROM dual UNION ALL
  SELECT '|~().,' FROM dual UNION ALL
  SELECT '123123' FROM dual UNION ALL
  SELECT '123abc' FROM dual UNION ALL
  SELECT 'abc' FROM dual;

SELECT * FROM t_reg;

COMMIT;

-- [a-z]: 소문자로 시작 
-- .*: 이어지는 아무 글자 0회 이상 
-- 공백(스페이스): 뒤에 공백이 있는 
SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '[a-z].* ');

-- [:lower:]: 소문자
-- 공백(스페이스): 뒤에 공백이 있는 
SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '[[:lower:]] ');

-- [A-Z]{2}: 대문자가 연속으로 2글자 나오는
SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '[A-Z]{2}');

-- ^: 문자열 시작
-- $: 문자열 끝
-- [abc]{3}: abc 중 연속으로 3글자 나오는 
SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '^[abc]{3}$');

-- [A-Z]: 대문자 한글자 
-- [0-9]{3}: 숫자 3글자 연속
SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '[A-Z][0-9]{3}');

-- [0-9]: 숫자 1글자
-- [A-Z]{3}: 대문자 3글자 연속
SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '[0-9][A-Z]{3}');

-- ^: 문자열의 시작
-- [0-9A-Z]: 숫자 또는 대문자 한 글자
SELECT * FROM t_reg
WHERE REGEXP_LIKE(text, '^[0-9A-Z]');

-- ([0-9]): 0~9 사이의 숫자 한 글자를 캡쳐 그룹으로 잡음
-- \1-*: 찾은 숫자 뒤에 -* 추가
SELECT text, REGEXP_REPLACE(text, '([0-9])', '\1-*')
FROM t_reg;

-- ([0-9]): 0~9 사이의 숫자 한 글자를 캡쳐 그룹으로 잡음
SELECT text, REGEXP_REPLACE(text, '([0-9])([[:alpha:]])', '\1-*')
FROM t_reg;

--
SELECT REGEXP_SUBSTR('sys/oracle@racdb:1521:racdb', '\w+', 1, 3) result1,
     REGEXP_SUBSTR('sys/oracle@racdb:1521:racdb', '[^:]+', 1, 3) result2
FROM dual;

-- 
SELECT LEVEL, last_name 사원명, PRIOR last_name 매니저명
FROM employees 
START WITH last_name = 'King'
CONNECT BY manager_id = PRIOR employee_id;

SELECT LEVEL, LPAD(' ', (LEVEL-1)*2) || last_name 매니저명, PRIOR last_name 사원명
FROM employees 
START WITH last_name = 'Lorentz'
CONNECT BY manager_id = PRIOR employee_id;


CREATE TABLE test10000 (
    no NUMBER
);

INSERT INTO test10000
    SELECT LEVEL
    FROM dual
    CONNECT BY LEVEL <= 10000;

SELECT * 
FROM test10000
ORDER BY 1;

SELECT DBMS_RANDOM.string('U', 20) || ROUND(DBMS_RANDOM.VALUE(1, 10) * 10)
FROM dual
CONNECT BY LEVEL <= 27;

SELECT LEVEL, LPAD(' ', (LEVEL-1)*2) || last_name 사원명, PRIOR last_name 매니저명
FROM employees 
START WITH last_name = 'King'
CONNECT BY manager_id = PRIOR employee_id
ORDER SIBLINGS BY last_name;

SELECT manager_id, last_name, hire_date, salary,
    AVG(salary) OVER (PARTITION BY manager_id ORDER BY hire_date 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS c_mvg
FROM employees
ORDER BY manager_id, hire_date, salary;

SELECT last_name, hire_date,
    lead(hire_date, 1) OVER (ORDER BY hire_date),
    lead(last_name, 1) OVER (ORDER BY hire_date)
FROM employees;

SELECT last_name, hire_date,
    lead(hire_date, 2) OVER (ORDER BY hire_date),
    lead(last_name, 2) OVER (ORDER BY hire_date),
    salary - lag(salary, 2) OVER (ORDER BY hire_date)
FROM employees;

SELECT *
FROM (SELECT ROWNUM AS no, e.*
    FROM (SELECT *
        ORDER BY salary DESC) e)
WHERE R BETWEEN 3 AND 5;

-- 급여가 높은 순으로 3명 출력 (동일 급여도 포함)
SELECT last_name, salary
FROM employees
ORDER BY salary DESC
FETCH FIRST 3 ROWS WITH TIES;

-- OFFSET 위치 뒤에서부터 3개 출력
-- 없을 경우 FIRST 랑 동일하게 출력
SELECT last_name, salary
FROM employees
ORDER BY salary DESC
FETCH NEXT 3 ROWS WITH TIES;

SELECT manager_id, last_name, hire_date, salary,
    AVG(salary) OVER (PARTITION BY manager_id ORDER BY hire_date 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS c_mvg,
            COUNT(*) OVER (PARTITION BY manager_id ORDER BY hire_date 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS c_mvg,
            COUNT(*) OVER (PARTITION BY manager_id ORDER BY hire_date 
        RANGE BETWEEN 365 PRECEDING AND 365 FOLLOWING) AS c_count1,
            COUNT(*) OVER (PARTITION BY manager_id ORDER BY salary
        RANGE BETWEEN 100 PRECEDING AND 100 FOLLOWING) AS c_count2
FROM employees
ORDER BY manager_id, hire_date, salary;
