-- INNER JOIN
SELECT
    e.department_id AS 현재부서번호,
    e.employee_id AS 사원번호,
    e.last_name AS 성,
    e.job_id AS 현재직무,
    jh.job_id AS 과거직무,
    jh.department_id AS 과거부서번호
FROM employees e
INNER JOIN job_history jh
  ON e.employee_id = jh.employee_id
WHERE e.department_id = 90;


-- INNER JOIN
SELECT
    e.employee_id AS 사원번호,
    e.last_name AS T사원성,
    e.job_id AS 현재직무,
    jh.job_id AS 과거직무,
    jh.start_date AS 시작일,
    jh.end_date AS 종료일
FROM employees e
INNER JOIN job_history jh
  ON e.employee_id = jh.employee_id
WHERE e.first_name = 'Lex' AND e.last_name = 'De Haan';

-- NATURAL INNER JOIN
SELECT 
    department_name AS 부서이름,
    location_id AS 위치ID,
    street_address AS 주소,
    city AS 도시
FROM departments 
NATURAL JOIN locations;

-- NATURAL INNER JOIN
SELECT 
    department_name AS 부서이름,
    last_name AS 사원의성,
    department_id AS 직무ID,
    salary AS 급여
FROM employees
NATURAL JOIN departments;

-- NATURAL INNER JOIN
SELECT 
    department_name AS 부서이름,
    last_name AS 사원의성,
    department_id AS 직무ID,
    salary AS 급여
FROM employees
JOIN departments
USING (department_id, manager_id);

-- NATURAL INNER JOIN
SELECT 
    department_name AS 부서이름,
    last_name AS 사원의성,
    d.department_id AS 직무ID,
    salary AS 급여
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
AND e.manager_id = d.manager_id;

-- NATURAL INNER JOIN
SELECT 
    department_id AS 직무ID,
    manager_id AS 매니저ID,
    d.department_name AS 부서이름,
    e.last_name AS 사원의성
FROM employees e
NATURAL JOIN departments d;

-- NATURAL INNER JOIN
SELECT 
    department_id AS 직무ID,
    d.manager_id AS 매니저ID,
    d.department_name AS 부서이름,
    e.last_name AS 사원의성
FROM employees e
JOIN departments d
USING (department_id);

SELECT 
    employee_id AS 사원번호,
    last_name AS 사원성,
    department_name AS 부서이름,
    city AS 근무도시
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id;

-- NATURAL INNER JOIN
SELECT * 
FROM employees NATURAL INNER JOIN departments;

-- LEFT OUTER JOIN
SELECT 
    e.last_name, 
    e.job_id, 
    e.salary,
    d.department_name
FROM employees e
LEFT OUTER JOIN departments d 
ON e.department_id = d.department_id;


-- LEFT OUTER JOIN
SELECT 
    e.last_name, 
    e.job_id, 
    e.salary,
    d.department_name
FROM employees e, departments d 
WHERE e.department_id = d.department_id(+);

-- INNER JOIN
SELECT *
FROM employees e INNER JOIN departments d
    ON e.department_id = d.department_id
    AND e.manager_id = d.manager_id;
    
-- JOIN USING
SELECT *
FROM employees e JOIN departments d
    USING (department_id);
    
SELECT 
    e.*, 
    d.department_name,
    l.street_address, l.city
FROM employees e
    JOIN departments d
        ON e.department_id = d.department_id
    JOIN locations l
        ON l.location_id = d.location_id;
        
-- 
SELECT e.last_name, e.hire_date
FROM employees e
JOIN employees fox
ON e.hire_date > fox.hire_date
WHERE fox.last_name = 'Fay'
ORDER BY 2;

-- 
--SELECT 
--    e.department_id 부서번호, 
--    e.last_name 사원명,
--    e.hire_date 사원입사일,
--    m.last_name 관리자명,
--    m.hire_date 관리자입사일
--FROM employee e 

-- Abel 사원 정보 조회
SELECT *
FROM employees 
WHERE last_name = 'Abel';

-- Abel 보다 높은 급여 사원 조회 (서브쿼리)
SELECT *
FROM employees 
WHERE salary > (SELECT salary 
                FROM employees 
                WHERE last_name = 'Abel');
                
--
SELECT employee_id, last_name, salary
FROM employees;


