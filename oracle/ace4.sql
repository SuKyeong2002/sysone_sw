-- 세션의 날짜/시간 형식 변환
SELECT * 
FROM NLS_SESSION_PARAMETERS
WHERE parameter LIKE '%FORMAT%';

-- 세션의 날짜/시간 형식 변환
ALTER SESSION SET nls_date_format = 'YYYY-MM-DD';

-- 세션의 날짜/시간 형식 변환
ALTER SESSION SET nls_date_format = 'YYYY-MM-DD HH24:MI:SS';

-- 세션의 날짜/시간 형식 변환
ALTER SESSION SET nls_timestamp_tz_format = 'YYYY-MM-DD HH:MI:SS.FF TZH:TZM';

-- 대소동등 연산 비교
SELECT last_name, salary
FROM employees
WHERE salary <= 3000;

-- 대소동등 연산 비교
SELECT last_name, salary
FROM employees
WHERE last_name > 'King';

-- 대소동등 연산 비교
SELECT last_name, salary
FROM employees
WHERE hire_date > '2002/02/01';

-- BETWEEN A AND B
SELECT last_name, salary 
FROM employees 
WHERE salary BETWEEN 2500 AND 3500;

-- BETWEEN A AND B
SELECT last_name, salary 
FROM employees 
WHERE last_name BETWEEN 'Hartstein' AND 'King';

-- BETWEEN A AND B
SELECT last_name, salary 
FROM employees 
WHERE hire_date BETWEEN '2002/01/01' AND '2002/12/31';

-- IN
SELECT employee_id, last_name, salary, manager_id
FROM employees 
WHERE manager_id IN (100, 101, 201);

-- IN
SELECT last_name, salary
FROM employees 
WHERE last_name IN ('King', 'Vargas');

-- IN
SELECT last_name, salary
FROM employees 
WHERE hire_date IN ('2002/02/01', '2001/10/26');

-- LIKE
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'S%';

-- LIKE
SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '_o%';

-- LIKE
SELECT first_name, last_name, salary
FROM employees
WHERE salary LIKE '1%';

-- ESCAPE: 다음에 오는 문자에 특수의미 주지마!
SELECT *
FROM test
WHERE c1 LIKE 'A\_A' ESCAPE '\';

-- NULL 값 비교
SELECT last_name, salary
FROM employees
WHERE commission_pct = NULL;

-- NULL 값 비교
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct < 0.2;

-- NULL 값 비교
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NULL;

-- NULL 값 비교 예외 1
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

-- NULL 값 비교 예외 1
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

-- NULL 값 비교 예외 2
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IN (0.1, NULL, NULL);

-- AND
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >= 10000 AND job_id LIKE '%MAN%';

-- OR
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >= 10000 OR job_id LIKE '%MAN%';

-- NOT
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id NOT IN ('IT_PROG', 'ST_CLERK', 'SA_REP');

-- NOT
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary NOT BETWEEN 10000 AND 15000;

-- NOT
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE last_name NOT LIKE '%A%';

-- NOT
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE commission_pct IS NOT NULL;

-- 우선순위
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = 'SA_REP'
    OR job_id = 'AD_PRES'
    AND salary > 15000;

SELECT * FROM employees;

SELECT salary, salary/1000, FLOOR(salary/1000), TRUNC(salary/1000)
FROM employees
WHERE salary >= 3000 AND salary < 4000
ORDER BY 3;

SELECT DATE '2001-03-01', DATE '2001-03-01' - 1,
        '20010301', '20010301' -1
FROM dual;


SELECT DATE '1234-05-06' AS 기념일, TIMESTAMP '1234-05-06 13:14:15'
FROM dual;

-- 1/24/60 : 24시간의 1시간을 60분으로 나눔 = 1분
-- 15/24/60 : 24시간의 1시간을 60분으로 나누고 15분 곱함 = 15분
-- 24*60 : 24시간 * 60분 = 1440분 (하루를 분 단위로 환산)
-- 14/(24*60) : 하루를 14분 단위로 환산
-- 2/24 + 14/(24*60) : 2시간 14분
SELECT DATE '2001-04-13'
        , DATE '2001-04-13' + 1
        , DATE '2001-04-13' + 1/24
        , DATE '2001-04-13' - 1/24 + 15/24/60
        , TIMESTAMP '2001-04-13 13:12:42' - (2/24 + 14/(24*60))
FROM dual;

-- hire_date + 1 : hire_date에서 1일 더하기
-- hire_date + 7 : hire_date에서 7일 더하기
SELECT last_name, salary, hire_date
    , hire_date + 1
    , hire_date + 7
FROM employees;

SELECT DATE '2001-04-13' - DATE '2001-04-12'
        , DATE '2001-04-13' - DATE '2001-03-12'
        , DATE '2001-04-13' - DATE '2000-04-13'
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

ALTER SESSION SET nls_date_format = 'yyyy-mm-dd hh24:mi:ss';

ALTER SESSION SET nls_language = korean;

SELECT last_name, hire_date
    , NEXT_DAY(hire_date, '금')
    , NEXT_DAY(hire_date, '금요일')
FROM employees;

ALTER SESSION SET nls_language = american;

SELECT last_name, hire_date
    , NEXT_DAY(hire_date, 'fri')
    , NEXT_DAY(hire_date, 'FRI')
    , NEXT_DAY(hire_date, 'friday')
FROM employees;

SELECT sysdate, sysdate + 1, sysdate + 1/24
FROM dual;

-- MONTHS_BETWEEN(SYSDATE, hire_date): 오늘일과 입사일의 차이 
SELECT sysdate, hire_date, MONTHS_BETWEEN(SYSDATE, hire_date)
FROM employees;

SELECT hire_date, ADD_MONTHS(hire_date, 1), ADD_MONTHS(hire_date, -2)
FROM employees;

SELECT hire_date, ADD_MONTHS(hire_date, 1), ADD_MONTHS(hire_date, -2)
FROM employees
WHERE department_id = 30;

SELECT DATE '2001-04-13', NEXT_DAY(DATE '2001-04-13', '금요일') 
FROM dual;


SELECT *
FROM employees
WHERE LAST_DAY(hire_date) = DATE '2002-08-31';

-- ROUND(a, b)
SELECT TIMESTAMP '2001-04-13 12:34:56'
    , ROUND(TIMESTAMP '2001-04-13 12:34:56', 'MONTH')
    , ROUND(TIMESTAMP '2001-04-13 12:34:56', 'YEAR')
    , ROUND(TIMESTAMP '2001-04-13 12:34:56', 'DD')
FROM dual;

-- ROUND(a, b)
SELECT TIMESTAMP '2001-04-11 12:34:56'
    , ROUND(TIMESTAMP '2001-04-11 11:59:59', 'DAY')
    , ROUND(TIMESTAMP '2001-04-11 12:00:00', 'DAY')
    , NEXT_DAY(TIMESTAMP '2001-04-11 12:34:56', '일')
FROM dual;

-- BETWEEN ... AND ...
SELECT *
FROM employees
WHERE hire_date BETWEEN DATE '2002-08-01' AND DATE '2002-08-31';

-- BETWEEN ... AND ...
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date BETWEEN DATE '2006-02-01' AND DATE '2006-02-28';

-- BETWEEN ... AND ...
SELECT *
FROM employees
WHERE hire_date BETWEEN DATE '1998-03-01' AND DATE '1998-03-31';

-- >= AND <
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date >= DATE '2006-02-01' 
    AND hire_date < ADD_MONTHS(DATE '2006-02-01', 1);

-- LAST_DAY
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE LAST_DAY(hire_date) = LAST_DAY(DATE '2006-02-01');

-- TRUNC(a, b)
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE TRUNC(hire_date, 'MONTH') = DATE '2006-02-01';

SELECT *
FROM employees
WHERE hire_date BETWEEN DATE '1998-03-01' AND DATE '1998-03-31';

-- TO_NUMBER
SELECT 
    '1500' AS 문자형, 
    TO_NUMBER('1500') AS 숫자형
FROM dual;

-- 예제 1
SELECT *
FROM employees
WHERE hire_date = TO_DATE('1999-11-16', 'YYYY-MM-DD');

-- 예제 2
SELECT employee_id,
       last_name,
       salary,
       TO_CHAR(hire_date, 'YYYY"년" MM"월" DD"일"') AS hire_date_fmt
FROM employees
WHERE TRUNC(hire_date) = TO_DATE('2005-10-10', 'YYYY-MM-DD');



-- TO_CHAR(a, b)
SELECT hire_date
    , TO_CHAR(hire_date, 'YYYY yy mm Month mon Mon Day dy')
    , TO_CHAR(hire_date, 'RM Rm rm WW w DDD DD D Q')
    , TO_CHAR(hire_date, 'MM"월의 "DD"일"')
    , TO_CHAR(hire_date, 'Year DDsp ddth Ddspth')
FROM employees;

SELECT 
    last_name
    , UPPER(CONCAT(SUBSTR(last_name, 1, 8), '_US')) AS ncode
FROM employees
WHERE department_id IN (60, 80);

-- 함수 중첩 
SELECT TO_CHAR(ROUND((salary/7), 2), '99G999D99',
                'NLS_NUMERIC_CHARACTERS = '',.'' ') 
                "Formatted Salary"
FROM employees;

-- ADD_MONTHS(hire_date, 3) : 입사한 날로부터 3개월 경과한 날
-- NEXT_DAY(ADD_MONTHS(hire_date, 3), '월요일') : 경과한 날 다음에 오는 월요일 
-- TO_CHAR(
--      NEXT_DAY(ADD_MONTHS(hire_date, 3), '월요일'),
--      'YYYY"년" MM"월" DD"일" DAY'
--  ) : 문자열 '1999년 8월 13일, 월요일' 형태로 출력
SELECT 
    employee_id, 
    last_name,
    hire_date,
    TO_CHAR(
        NEXT_DAY(ADD_MONTHS(hire_date, 3), '월요일'),
        'YYYY"년" MM"월" DD"일" DAY'
    ) AS "입사후 3개월 경과 후 첫 월요일"
FROM employees
ORDER BY hire_date;

SELECT 
    last_name
    , UPPER(CONCAT(SUBSTR(last_NAME, 1, 8), '_US')
    , FLOOR(salary/1000(salary/1000)})
FROM employees;


WHERE salary >= 3000 AND salary < 4000
ORDER BY 3;

-- NVL(a1, a2)
SELECT 
    last_name AS 성, 
    salary AS 급여, 
    NVL(commission_pct, 0) AS 커미션,
    12 * salary * (1 + NVL(commission_pct, 0)) AS 연봉
FROM employees;

-- NVL2(a1, a2, a3)
SELECT 
    last_name, 
    salary,
    commission_pct,
    NVL(commission_pct, 0) NAL버전,
    NVL2(commission_pct, commission_pct, 0) NAL2버전
FROM employees;

-- NVL2(a1, a2, a3)
SELECT 
    last_name, 
    commission_pct,
    NVL(commission_pct, 0) NAL 버전,
    NVL2(commission_pct, commission_pct, 0) NAL2 버전,
    12 * salary * (1 + commission_pct) AS 연봉,
    12 * salary * (1 + NVL(commission_pct, 0)) AS 보완연봉,
    NVL2(commission_pct, 'Y', 'N') AS 커미션여부
FROM employees;

-- COALESCE
SELECT last_name, employee_id,
        commission_pct,
        manager_id,
        COALESCE (TO_CHAR(commission_pct), 
                TO_CHAR(manager_id),
                'No commission and no manager')
        AS 결과
FROM employees;

-- NULLIF
SELECT first_name, LENGTH(first_name) "expr1",
        last_name, LENGTH(last_name) "expr2",
        NULLIF(LENGTH(first_name), LENGTH(last_name))
        AS 결과
FROM employees;

-- LNNVL
SELECT COUNT(*)
FROM employees
WHERE commission_pct < 0.2
    OR commission_pct IS NULL;
    
-- LNNVL
SELECT COUNT(*)
FROM employees
WHERE LNNVL (commission_pct >= 0.2);

-- Simple CASE expression
SELECT last_name, job_id, salary
        , CASE job_id WHEN 'IT_PROG' THEN 1.10*salary
                      WHEN 'ST_CLERK' THEN 1.15*salary
                      WHEN 'SA_REP' THEN 1.20*salary
                                    ELSE salary
        END "REVISED SALARY"
FROM employees;

-- Simple CASE expression 예제
SELECT last_name 성, job_id 직무, salary 급여 
FROM employees
ORDER BY CASE job_id WHEN 'AD_PRES' THEN '0'
                    WHEN 'IT_PROG' THEN '1'
                                ELSE job_id
        END;
        
-- Search CASE expression
SELECT last_name, job_id, salary
        , CASE WHEN job_id = 'IT_PROG' THEN 1.10*salary
                WHEN job_id = 'ST_CLERK' THEN 1.15*salary
                WHEN job_id = 'SA_REP' THEN 1.20*salary
                                        ELSE salary
        END "REVISED SALARY"
FROM employees;

-- Search CASE expression
SELECT last_name, job_id, salary
        , (CASE WHEN salary < 5000 THEN 'Low'
                WHEN salary < 10000 THEN 'Medium'
                WHEN salary < 20000 THEN 'Good'
                                          ELSE 'Excellent'
        END) qualified_salary
FROM employees;

-- DECODE
SELECT last_name, job_id, salary
        , DECODE(job_id, 'IT_PROG', 1.10*salary
                        , 'ST_CLERK', 1.15*salary
                        , 'SA_REP', 1.20*salary
                                    , salary)
"REVISED SALARY"
FROM employees;

-- DECODE
SELECT last_name, job_id, salary
        , CASE commission_pct WHEN NULL THEN '노 커미션'
                            WHEN 0.1 THEN '10% 커미션'
                            WHEN 0.2 THEN '20% 커미션'
                                    ELSE '기타 커미션'
        END AS 커미션
FROM employees;

-- DECODE
SELECT last_name, salary
        , DECODE( 
            FLOOR(salary/3000), 
            0, '00%',
            1, '09%',
            2, '20%', 
            3, '30%', 
            4, '40%',
            5, '42%',
                '42%'
        ) AS 세율
FROM employees
WHERE department_id = 80;

-- DECODE 문제
CREATE TABLE local_sales
(no NUMBER(2), city VARCHAR2(10), sale NUMBER(6));
INSERT INTO local_sales VALUES (1, '부산', 18000);
INSERT INTO local_sales VALUES (2, '서울', 25000);
INSERT INTO local_sales VALUES (3, '인천', 14000);
INSERT INTO local_sales VALUES (4, '대구', 13000);
INSERT INTO local_sales VALUES (5, '대전', 11000);

SELECT *
FROM local_sales;

SELECT *
FROM local_sales
ORDER BY DECODE (city, 
                '서울', 1,
                '부산', 2,
                '대구', 3,
                '대전', 4,
                '인천', 5,
                        99
                );
                
                
-- 그룹 함수
SELECT SUM(last_name)
FROM employees;

-- 그룹 함수
SELECT 
    SUM(salary), 
    AVG(salary), 
    MAX(salary), 
    MIN(salary)
FROM employees;

-- 그룹 함수 예제
SELECT AVG(LENGTH(department_name))
FROM departments;

-- 그룹 함수 예제
SELECT ROUND(AVG(LENGTH(department_name)), 2)
FROM departments;

-- 그룹 함수 예제
SELECT MIN(salary), MAX(salary)
FROM employees;

-- 그룹 함수 예제
SELECT MIN(last_name), MAX(last_name)
FROM employees;

-- 그룹 함수 예제
SELECT MIN(hire_date), MAX(hire_date)
FROM employees;

-- 그룹 함수 예제
SELECT COUNT(last_name), COUNT(hire_date)
FROM employees;

-- LONG, LOB 타입
CREATE TABLE t_long (
    c1 NUMBER, c2 LONG, c3 CLOB
);

INSERT INTO t_long VALUES (10, 'Hello', 'World');
INSERT INTO t_long VALUES (20, '서울', '디지털대학교');
INSERT INTO t_long VALUES (30, 'Oracle의 혁신적인 클라우드 데이터베이스는', '수동 데이터 관리를 배제할 수 있도록 설계되었습니다.');
COMMIT;

SELECT *
FROM t_long;

-- 집계 함수
SELECT SUM(c1), COUNT(c1)
FROM t_long;

SELECT MIN(c2)
FROM t_long;

SELECT COUNT(c3)
FROM t_long;

SELECT AVG(salary)
FROM employees
GROUP BY 10;

-- DISTINCT
CREATE TABLE test (
    c1 NUMBER
);

INSERT INTO test VALUES (1000);
INSERT INTO test VALUES (NULL);
INSERT INTO test VALUES (2000);
INSERT INTO test VALUES (NULL);
INSERT INTO test VALUES (1000);
INSERT INTO test VALUES (2000);
COMMIT;

SELECT *
FROM test;

SELECT SUM(c1), 
        SUM(ALL c1), 
        SUM(DISTINCT c1)
FROM test;

-- NULL
SELECT last_name, commission_pct, commission_pct + 0.1
FROM employees;

-- NULL 문제
SELECT 
    last_name AS 성, 
    salary AS 급여, 
    NVL(12*salary*(1+commission_pct), 0) AS 연봉
FROM employees;

-- NULL 에 대한 연결 연산
SELECT first_name || NULL || last_name
FROM employees;

-- NULL 비교 연산
SELECT last_name, salary
FROM employees
WHERE commission_pct = NULL;

SELECT last_name, salary
FROM employees
WHERE commission_pct IS NULL;

-- NULL 비교 연산
SELECT last_name, salary
FROM employees
WHERE commission_pct < 0.2;

SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IN (0.1, NULL, NULL);

-- ROWID
SELECT ROWNUM, ROWID, last_name, salary, department_id
FROM employees
WHERE commission_pct IS NULL;

SELECT ROWNUM, ROWID, 99, 'SDU', salary+100
FROM employees;

SELECT ROWID, last_name, SYSDATE
FROM employees;

SELECT ROWNUM, employee_id, last_name, job_id, salary
FROM employees
WHERE ROWNUM = 1;

SELECT ROWNUM, employee_id, last_name, job_id, salary
FROM employees;

SELECT ROWNUM, employee_id, last_name, job_id, salary
FROM employees 
WHERE ROWNUM < 4;

SELECT ROWNUM, employee_id, last_name, job_id, salary
FROM employees 
WHERE ROWNUM = 2;


SELECT ROWNUM, employee_id, last_name, job_id, salary
FROM employees 
WHERE ROWNUM >= 3;

SELECT ROWNUM, employee_id, last_name, job_id, salary
FROM employees 
WHERE ROWNUM BETWEEN 3 AND 5;

SELECT last_name, department_id, hire_date
FROM employees 
ORDER BY hire_date;

SELECT last_name, department_id, hire_date
FROM employees 
ORDER BY hire_date DESC;

-- NULLS FIRST
SELECT last_name, department_id, hire_date, commission_pct
FROM employees 
ORDER BY commission_pct NULLS FIRST;

-- NULLS LAST
SELECT last_name, department_id, hire_date, commission_pct
FROM employees 
ORDER BY commission_pct NULLS LAST;

-- AS 
SELECT last_name, job_id, salary*12 AS annsal
FROM employees 
ORDER BY annsal;

-- AS
SELECT last_name, job_id, salary*12 AS annsal
FROM employees 
WHERE annsal < 100000
ORDER BY annsal;

-- ORDER BY NUM
SELECT last_name, job_id, salary*12 AS annsal
FROM employees
ORDER BY 3;

-- ORDER BY NUM
SELECT last_name, job_id, salary*12 AS annsal
FROM employees
ORDER BY 1 DESC;

-- 여러 컬럼
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY 2 DESC, hire_date;

-- ORDER BY 절
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY hire_date;

-- ORDER BY 절
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY LENGTH(hire_date);

-- ORDER BY 절
SELECT last_name, job_id, DBMS_RANDOM.value
FROM employees
ORDER BY DBMS_RANDOM.value;

-- LOWER
-- || : 문자열 연결 연산자
SELECT 
    'The job id for' || 
    UPPER(last_name) ||
    'is' || 
    LOWER(job_id) "Employee Details"
FROM employees;

-- UPPER
SELECT *
FROM employees
WHERE UPPER(last_name)  = 'ABEL';

-- INITCAP
SELECT street_address, INITCAP(street_address)
FROM locations;

-- INITCAP
SELECT 'i love you, honey!',
        INITCAP('i love you, honey!')
FROM dual;

SELECT 24*60*60 AS 초
FROM employees
where rownum = 1;

SELECT 24*60*60 AS 초
FROM employees;
WHERE rownum = 1;

CREATE TABLE my_dual (c1 CHAR(1));
INSERT INTO my_dual VALUES ('a');
COMMIT;

SELECT 24*60*60 AS 초
FROM my_dual;

desc dual
SELECT * FROM dual;

desc all_objects
SELECT owner, object_type, object_name 
FROM all_objects
WHERE object_name = 'DUAL';

SELECT AVG(salary)
FROM employees
GROUP BY (); -- 전체 그룹 집합: ()

SELECT job_id, SUM(salary)
FROM employees
GROUP BY job_id;

-- NATURAL INNER JOIN (동등 조인)
SELECT *
FROM departments NATURAL INNER JOIN locations; 