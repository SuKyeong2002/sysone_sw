insert into employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
values (500, 'first_name', 'last_name', 'email', 'phone_number', sysdate, 'FI_MGR', 100000.00, 0.99, 101, 20);

select * from employees;

select DEPARTMENT_ID as departmentId, DEPARTMENT_NAME as departmentName from departments;

				select distinct e1.manager_id as manager_id, e2.first_name as manager_name
				from employees e1
				join employees e2 on e2.employee_id = e1.manager_id
				order by manager_name;

COMMIT;