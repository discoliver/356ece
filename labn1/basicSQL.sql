-- 1. Single-Table Queries: Create SQL queries to answer the following:
-- (a) Which departments are in located Waterloo?
select deptName from Department where location = 'waterloo';
+----------+
| deptName |
+----------+
| research |
+----------+
1 row in set (0.00 sec)
-- (b) How many people are employed in each job types in the company, ordered by job type?]
select count(job) as totalEmployee, job
from Employee
group by job order by job;
+------------+------------+
| count(job) | job        |
+------------+------------+
|          1 | analyst    |
|          3 | engineer   |
|          1 | janitor    |
|          1 | programmer |
|          2 | secretary  |
|          1 | technician |
+------------+------------+
6 rows in set (0.00 sec)
-- (c) What are the names and salaries of the engineers?
select empName, salary  from employee where job = 'engineer';
+---------+--------+
| empName | salary |
+---------+--------+
| Kelly   |  37000 |
| Mays    |  45000 |
| Maria   |  32000 |
-- (d) What is the average salary by job type?
mysql> select job, avg(salary) from Employee group by job;
+------------+-------------+
| job        | avg(salary) |
+------------+-------------+
| analyst    |  36000.0000 |
| engineer   |  38000.0000 |
| janitor    |  26000.0000 |
| programmer |  35000.0000 |
| secretary  |  25500.0000 |
| technician |  32000.0000 |
+------------+-------------+
6 rows in set (0.01 sec)
-- (e) What is the ID of the department with the most engineers?
select count(*) as engineerCountTotal, deptID
from Employee where job ='engineer'
group by deptID
order by engineerCountTotal desc
limit 1;
+---------------+--------+
| engineerCount | deptID |
+---------------+--------+
|             2 |      7 |
+---------------+--------+
1 row in set (0.00 sec)
-- (f) What is the ID of the department where the greatest percentage of employees in the
-- department are engineers?
select t1.engNum, t2.totalNum, t1.deptID, t1.engNum/t2.totalNum as ratio
from
(select count(*) as engNum, deptID from employee where job = 'engineer' group by deptID) as t1
join
(select count(*) as totalNum, deptID from employee group by deptID) as t2
on (t1.deptID = t2.deptID)
order by ratio desc
limit 1;
+--------+----------+--------+--------+
| engNum | totalNum | deptID | ratio  |
+--------+----------+--------+--------+
|      1 |        2 |      3 | 0.5000 |
+--------+----------+--------+--------+
1 row in set (0.01 sec)


-- 2. Multi-table Queries:
-- (a) What are the names and IDs of employees who are currently not assigned to any project?
select  empName, empID
from Employee
where empID  not in
(select empID from Assigned);
+---------+-------+
| empName | empID |
+---------+-------+
| Herr    |    56 |
| Morris  |    68 |
| Maria   |    69 |
+---------+-------+
3 rows in set (0.00 sec)
-- (b) What is the name, job and role of all employees whose role is different than their job?
select empName,job, role
from (select empName,job,role from Employee join Assigned on (Employee.empID = Assigned.empID)) as t1
where t1.job != t1.role;
+----------+------------+------------+
| empName  | job        | role       |
+----------+------------+------------+
| Kelly    | engineer   | manager    |
| Williams | analyst    | manager    |
| Hess     | technician | programmer |
+----------+------------+------------+
3 rows in set (0.00 sec)
-- (c) What is the number of employees, by job, who’s role is identical to their job?
select count(job) as numberMatched
from (select empName,job,role from Employee join Assigned on (Employee.empID = Assigned.empID)) as t1
where t1.job = t1.role;
+---------------+
| numberMatched |
+---------------+
|             3 |
+---------------+
1 row in set (0.00 sec)
-- (d) What is the total of the salaries of all employees assigned to each project?
select projID, sum(salary) as totlalSalaries
from (select empName,salary, projID from Employee join Assigned on (Employee.empID = Assigned.empID)) as t1
group by projID;
+--------+----------------+
| projID | totlalSalaries |
+--------+----------------+
|    123 |         142000 |
|    345 |          71000 |
+--------+----------------+
2 rows in set (0.00 sec)
-- (e) Repeat (d) but include a row for the total of the salaries of all employees

?????
select sum(salary)
from (select  empName, empID, salary
      from Employee
      where empID  not in (select empID from Assigned)) as t;

create view new as
select projID, sum(salary) as totlalSalaries
from (select empName,salary, projID from Employee join Assigned on (Employee.empID = Assigned.empID)) as t1
group by projID;

insert into new
value(1,2);


-- (f) Identify any employees (if any), by name and ID, who are assigned to more than one project.


select empName
from Employee join Assigned
on (Employee.empID = Assigned.empID);
