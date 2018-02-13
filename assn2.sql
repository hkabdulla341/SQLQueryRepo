select * from EMPLOYEES;
select * from DEPARTMENTS;

--1.	List all the employees whose commission is NULL
select * from EMPLOYEES where COMMISSION_PCT is NULL;

--2.	List all the employees whose name begin with B
select * from EMPLOYEES where upper(FIRST_NAME) like upper('B%');

--3.	List employees whose joining date is greater than 01-Jan-82
select * from EMPLOYEES where HIRE_DATE > to_date('01-Jan-1982');

--4.	List employees earning more than 2000
select * from EMPLOYEES where SALARY > 2000;

--5.	List employee number, department number and salary for employee no 7900
select EMPLOYEE_ID, DEPARTMENT_ID, SALARY from EMPLOYEES where EMPLOYEE_ID = 7900; -- return row 0

--      List employee number, department number and salary for employee with salary 7900
select EMPLOYEE_ID, DEPARTMENT_ID, SALARY from EMPLOYEES where salary = 7900; -- return row 1

--6.	List all the employees working in department no 20
select * from EMPLOYEES where DEPARTMENT_ID = 20;

--7.	List all employees working in department 10 or 30
select * from EMPLOYEES where DEPARTMENT_ID = 10 OR DEPARTMENT_ID = 20;

--8.	List employees who are earning in the range of  1000  to 3000
select * from EMPLOYEES where SALARY between 1000 and 3000;

--9.	Display the employee name, job, and start date of employees hired between February 20, 80, and May 1, 82. Order the query in ascending order by start date.
select FIRST_NAME, LAST_NAME, JOB_ID, HIRE_DATE from EMPLOYEES where HIRE_DATE between to_date('20-feb-1980') and TO_DATE('01-may-1982') order by HIRE_DATE ASC;

--10.	Display the name and hire date of every employee who was hired in 1982
select FIRST_NAME, LAST_NAME, HIRE_DATE from EMPLOYEES where HIRE_DATE BETWEEN TO_DATE('01-jan-1982') and TO_DATE('31-dec-1982');

--11.	Display the name and job title of all employees who do not have a manager
select FIRST_NAME, LAST_NAME, JOB_ID from EMPLOYEES where MANAGER_ID IS NULL;

--12.	Display the name, job, and salary for all employees whose job is sales man  and whose salary is not equal to 1,600, 3,000, or 1,250.
select FIRST_NAME, LAST_NAME, JOB_ID, SALARY from EMPLOYEES where JOB_ID = 'SA_REP' AND SALARY not in (1600,3000,1250);

--13.	List department name for department no 10
select * from DEPARTMENTS where DEPARTMENT_ID = 10;

--14.	Display unique jobs from emp table
select distinct JOB_ID from EMPLOYEES;

--15.	Display unique combination of department no and jobs
select DISTINCT JOB_ID, DEPARTMENT_ID from EMPLOYEES order by JOB_ID;

--16.	Display unique manager id from emp table
select DISTINCT MANAGER_ID from EMPLOYEES;

--17.	Display maximum and minimum salary in the organization
select min(SALARY), max(SALARY) from EMPLOYEES;

--18.	Display maximum and minimum salary in each department
select DEPARTMENT_ID, min(SALARY), max(SALARY) from EMPLOYEES group by DEPARTMENT_ID order by DEPARTMENT_ID;

--19.	Display how many employees are earning more than 1500
select count(*) as Earn_More_Than_1500 from employees where SALARY > 1500;

--20.	Display how many employees are earning more than 1500 in each department
select department_ID, count(*) as Earn_More_Than_1500 from EMPLOYEES where SALARY > 1500 group by DEPARTMENT_ID order by DEPARTMENT_ID;

--21.	Display maximum salary in department 30
select max(salary) from EMPLOYEES where DEPARTMENT_ID = 30;

--Using Subquery
--1.	Display all the employees in department Sales
select * from EMPLOYEES where DEPARTMENT_ID =
(select DEPARTMENT_ID from departments where upper(DEPARTMENT_NAME) = 'SALES');

--2.	Display all the employees earning more than Blake
select * from EMPLOYEES where SALARY > (
select salary from EMPLOYEES where upper(FIRST_NAME) like upper('%Blake%'));

--3.	Display all the employees who are earning less than average salary
select * from EMPLOYEES where salary < (
select avg(salary) from EMPLOYEES);

--4.	Display the employee who is earning maximum salary in department 30
select * from EMPLOYEES where DEPARTMENT_ID = 30 and salary =
(select max(salary) from EMPLOYEES where DEPARTMENT_ID = 30);

--
--
--Exercise 2
--1.	Write a query to display the  name, department number, and department name for all employees
select e.FIRST_NAME, e.LAST_NAME, e.DEPARTMENT_ID, d.d.DEPARTMENT_NAME from EMPLOYEES e 
left join DEPARTMENTS d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID
order by d.DEPARTMENT_ID
;

--2.	Create a unique listing of all jobs that are in department 30. Include the location of the department in the output.
select distinct e.JOB_ID, l.CITY from EMPLOYEES e 
join DEPARTMENTS d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID 
join LOCATIONS l
on d.LOCATION_ID = l.LOCATION_ID
where e.DEPARTMENT_ID = 30;

--3.	Write a query to display the name, job, department number, and department name for all  employees who work in Toronto

select e.FIRST_NAME, j.JOB_TITLE, e.DEPARTMENT_ID, d.DEPARTMENT_NAME from EMPLOYEES e
inner join DEPARTMENTS d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID
inner join LOCATIONS l
on d.LOCATION_ID = l.LOCATION_ID
inner join JOBS j
on e.JOB_ID = j.JOB_ID
where upper(l.CITY) like '%TORONTO%';

--4.	Display the employee last name and employee number along with their manager’s last name and manager number. 
select e.LAST_NAME as emp_last_name, e.EMPLOYEE_ID as emp_id, m.LAST_NAME as mgr_last_name, m.EMPLOYEE_ID as mgr_id from EMPLOYEES e
left join EMPLOYEES m
on e.MANAGER_ID = m.EMPLOYEE_ID
order by e.EMPLOYEE_ID ASC;