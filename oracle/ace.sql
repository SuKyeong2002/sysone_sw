create table emp_temp 
as 
select last_name, salary, job_id, commission_pct, department_id from employees;

-- * : 모든 데이터 가져오겠다! (필요한 컬럼만 나열하는 게 좋음 -> 리소스 낭비 최소화)
select * from emp_temp;

-- emp_temp 데이터 가져오기 
-- (AS) 변경할이름 : 필드 이름 변경 
SELECT
    last_name AS 이름,
    salary * 12 AS 연봉,
    salary,
    commission_pct "p s t",
    'abcd'
FROM
    emp_temp
WHERE
    salary >= 10000;
    
-- 과제 
-- SQL 에서 NULL = 알 수 없는 값 (공백, O이 아닌 값)
-- NVL(값, 지정값): NULL일 경우 지정값 삽입
--  salary * 12 + salary + 12 * commission_pct 
-- = salary * 12 + (1+NVL(commission_pct, 0))
-- asc: 오름차순(기본), desc: 내림차순
SELECT
    last_name AS 사원명,
    salary AS 월급,
    salary * 12 + (1+NVL(commission_pct, 0)) AS 연봉
FROM
    emp_temp
ORDER BY 
    salary desc;
    
    
				SELECT
				    username,
				    password,
				    email,
				    birth,
				    join_date
				FROM
				    xci_members