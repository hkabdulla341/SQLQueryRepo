--Create the following tables

Create table Employee
(
   Empno INT,
   Emp_name varchar(50) NOT NULL,
   Emp_Status varchar(1),
   
   Constraint Invalid_Emp_Staus CHECK(EMP_Status in ('P', 'C','R'))
);

Alter table employee add Emp_Join_date date default sysdate;

Create table Project
(
Project_Code varchar(50),
Project_Description varchar(100) NOT NULL,
Project_Start_Date Date NOT NULL,
Project_End_Date Date,
Constraint Unique_Prj_Desc Unique  (Project_Description)
);

Create table project_allocation
(
ProjectAlloc_Code varchar(50),
ProjectAlloc_Empno INT,
Emp_Porj_Alloc_date Date,
Emp_Proj_Release_Date date
);

--2. Insert the following data in Employee table
Insert into employee(empno, emp_name, emp_join_date, emp_status) values ('101', 'Jhonny', TO_DATE('01-Jul-2005'), 'C');
Insert into employee(empno, emp_name, emp_join_date, emp_status) values ('116', 'Nayak', TO_DATE('16-Aug-2005'), 'C');
Insert into employee(empno, emp_name, emp_join_date, emp_status) values ('202', 'Meera', TO_DATE('30-Jan-2006'), 'C');
Insert into employee(empno, emp_name, emp_join_date, emp_status) values ('205', 'Ravi', TO_DATE('11-Feb-2006'), 'C');
Insert into employee(empno, emp_name, emp_join_date, emp_status) values ('304', 'Hari', TO_DATE('25-Nov-2006'), 'P');
Insert into employee(empno, emp_name, emp_join_date, emp_status) values ('307', 'Nancy', TO_DATE('15-Jan-2007'), 'P');
Insert into employee(empno, emp_name, emp_join_date, emp_status) values ('403', 'Nick', TO_DATE('21-Jan-2007'), 'P');

--3. Insert the following data in Project table
insert into project(project_code, project_description, project_start_date, project_end_date) values ('P001','Environment Pollution', to_date('02-Aug-2005'), to_date('11-Dec-2006'));
insert into project(project_code, project_description, project_start_date) values ('P002','Learning Curve', to_date('01-Feb-2006'));
insert into project(project_code, project_description, project_start_date) values ('P003','Effects of IT', to_date('03-Jan-2007'));

--Insert the following data in Project_Allocation table
Insert into project_allocation(PROJECTALLOC_CODE,PROJECTALLOC_EMPNO, EMP_PORJ_ALLOC_DATE, EMP_PROJ_RELEASE_DATE) values ('P001', '101', to_date('01-Aug-2005'), to_date('11-Dec-2006'));
Insert into project_allocation(PROJECTALLOC_CODE,PROJECTALLOC_EMPNO, EMP_PORJ_ALLOC_DATE, EMP_PROJ_RELEASE_DATE) values ('P001', '116', to_date('16-Aug-2005'), to_date('11-Dec-2006'));
Insert into project_allocation(PROJECTALLOC_CODE,PROJECTALLOC_EMPNO, EMP_PORJ_ALLOC_DATE, EMP_PROJ_RELEASE_DATE) values ('P002', '202', to_date('01-Feb-2006'), to_date('14-Jan-2007'));
Insert into project_allocation(PROJECTALLOC_CODE,PROJECTALLOC_EMPNO, EMP_PORJ_ALLOC_DATE) values ('P002', '307', to_date('15-Jan-2007'));
Insert into project_allocation(PROJECTALLOC_CODE,PROJECTALLOC_EMPNO, EMP_PORJ_ALLOC_DATE) values ('P002', '205', to_date('11-Feb-2006'));
Insert into project_allocation(PROJECTALLOC_CODE,PROJECTALLOC_EMPNO, EMP_PORJ_ALLOC_DATE) values ('P003', '403', to_date('21-Jan-2007'));
Insert into project_allocation(PROJECTALLOC_CODE,PROJECTALLOC_EMPNO, EMP_PORJ_ALLOC_DATE) values ('P003', '304', to_date('03-Jan-2007'));
Insert into project_allocation(PROJECTALLOC_CODE,PROJECTALLOC_EMPNO, EMP_PORJ_ALLOC_DATE) values ('P003', '101', to_date('03-Jan-2007'));
Insert into project_allocation(PROJECTALLOC_CODE,PROJECTALLOC_EMPNO, EMP_PORJ_ALLOC_DATE) values ('P003', '116', to_date('03-Jan-2007'));
Insert into project_allocation(PROJECTALLOC_CODE,PROJECTALLOC_EMPNO, EMP_PORJ_ALLOC_DATE) values ('P003', '202', to_date('15-Jan-2007'));

commit;

--Q5

--a)	List all the Projects
select * from project;

--b)	List the Employees
select * from employee;

--c)	Display the name of employees who are Confirmed
select * from employee where upper(EMP_status) = 'C';

--d)	List the employees who have joined after 1st Nov 2006
select * from employee where EMP_JOIN_DATE > TO_DATE('01-nov-2006');

--e)	List the projects which have started after 1st Jan 2006
select * from PROJECT where PROJECT_START_DATE > TO_DATE('01-jan-2006');

--f)	Display the  Employees who are in project code P003
select p_a.PROJECTALLOC_CODE, e.* from PROJECT_ALLOCATION p_a 
join employee e 
on p_a.PROJECTALLOC_EMPNO = e.EMPNO
where upper(p_a.PROJECTALLOC_CODE) = 'P003';

--g)	Display the Projects which have not yet completed
select * from project where PROJECT_END_DATE IS NULL;

--h)	Display the Employees who are released from project code P002
select e.* from project p 
join  PROJECT_ALLOCATION p_a 
on p.PROJECT_CODE = p_a.PROJECTALLOC_CODE 
join EMPLOYEE e
on p_a.PROJECTALLOC_EMPNO = e.EMPNO 
where upper(p.PROJECT_CODE) = 'P002' and p_a.EMP_PROJ_RELEASE_DATE IS NOT NULL;

--i)	Display how many days it took to complete project P001
select PROJECT_CODE, PROJECT_END_DATE-PROJECT_START_DATE as Length_Of_Project from project where upper(PROJECT_CODE) = 'P001';

--j)	Display for how many days are employees working on the allocated projects
select p_a.PROJECTALLOC_EMPNO, e.EMP_NAME, trunc(sysdate-p_a.EMP_PORJ_ALLOC_DATE) as Working_for_Days from PROJECT_ALLOCATION p_a 
join employee e
on p_a.PROJECTALLOC_EMPNO = e.EMPNO
where EMP_PROJ_RELEASE_DATE IS NULL;

--6. Add a column Project_Manager in the Projects table
alter table project add project_manager INT;

--7. Update the Projects table with the following data 
Update project set PROJECT_MANAGER = '101' where upper(PROJECT_CODE) = 'P001';
Update project set PROJECT_MANAGER = '202' where upper(PROJECT_CODE) = 'P002';
Update project set PROJECT_MANAGER = '116' where upper(PROJECT_CODE) = 'P003';

--8. Details about  new project  named “Election Rage”  which is starting on 1st March 2007 is received . Add the details in Projects table
Insert into PROJECT(PROJECT_DESCRIPTION, PROJECT_START_DATE) values ('Election Rage', to_date('01-mar-2007'));

--9. Project  named “Election Rage”   is cancelled. Remove the details from the Projects table
delete from PROJECT where upper(PROJECT_DESCRIPTION) = upper('Election Rage');

commit;