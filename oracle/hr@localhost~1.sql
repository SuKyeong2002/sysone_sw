select count(*) from employees;

select count(*) from employees where department_id = 20;

-- * 지양 (속도 느려짐)
-- 컬럼명 다 쓰는 걸 추천
select * from employees;

select * from employees where EMPLOYEE_ID = 200;

insert into employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
values (600, 'first_name', 'last_name', 'email', 'phone_number', sysdate, 'FI_MGR', 100000.00, 0.99, 101, 20);


update employees 
    set first_name='first_name1', last_name='last_name1', email='email1', salary=120000.00
    where employee_id=600;

delete from employees where employee_id=600 and email='email1';

delete from job_history where employee_id=600;

select DEPARTMENT_ID, DEPARTMENT_NAME from departments;

select JOB_ID, JOB_TITLE from jobs;

select JOB_ID as jobId, JOB_TITLE as jobTitle from jobs;

-- 매니저 아이디와 이름 출력 (중복X) -> 서브쿼리 (속도 느림)
select manager_id,
    (select first_name from employees e2 where e2.employee_id = e1.employee_id) as manager_name
from employees e1;

-- 매니저 아이디와 이름 출력 (중복X) -> 조인 사용 (속도 향상)
select distinct e1.manager_id, e2.first_name as manager_name
from employees e1
join employees e2 on e2.employee_id = e1.manager_id
order by manager_name;