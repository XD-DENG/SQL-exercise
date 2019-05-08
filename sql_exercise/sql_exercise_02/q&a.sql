# 总结：
# sum是对列的值，count是对列的个数；
select *
from sql_exercise.Employees;
select *
from sql_exercise.Departments;

-- 2.1 Select the last name of all employees.
select sql_exercise.Employees.LastName from Employees;
-- 2.2 Select the last name of all employees, without duplicates.
select sql_exercise.Employees.LastName from Employees group by LastName;
-- 2.3 Select all the data of employees whose last name is "Smith".
select * from sql_exercise.Employees where LastName='Smith';
-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
select * from sql_exercise.Employees where LastName='Smith' or LastName='Doe';
-- 2.5 Select all the data of employees that work in department 14.
select * from Employees where Department=14;
-- 2.6 Select all the data of employees that work in department 37 or department 77.
select * from Employees where Department=37 or Department=77;
-- 2.7 Select all the data of employees whose last name begins with an "S".#模糊查询
select * from Employees where LastName like 'S%';
-- 2.8 Select the sum of all the departments' budgets.
select sum(sql_exercise.Departments.Budget) from Departments;
-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
select Department,count(*) from Employees group by Employees.Department ; #????? 。sum是对列对值，count是对列的个数；
-- 2.10 Select all the data of employees, including each employee's department's data.
select a.* ,b.* from Employees a,Departments b where a.Department=b.Code;
#用left更复合题目要求
select a.* ,b.* from Employees a left join Departments b on a.Department = b.Code;
-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
select a.name,a.LastName,b.Name,b.Budget from sql_exercise.Employees a join sql_exercise.Departments b on a.Department = b.Code;

-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
select a.name,a.LastName,b.Budget from sql_exercise.Employees a join sql_exercise.Departments b on a.Department = b.Code where b.Budget>60000;
-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
select * from sql_exercise.Departments where Budget > (select avg(Budget) from sql_exercise.Departments)
-- 2.14 Select the names of departments with more than two employees.
select b.Name from (select Department from sql_exercise.Employees group by Department having count(*)>2) a,sql_exercise.Departments b where a.Department=b.Code;#inner join
#答案除了上述写法还有一个写法：
SELECT Name FROM Departments
  WHERE Code IN
  (
    SELECT Department
      FROM Employees
      GROUP BY Department
      HAVING COUNT(*) > 2
  );
-- 2.15 Very Important *****- Select the name and last name of employees working for departments with second lowest budget.
select b.Name,b.LastName from (select * from ( select  * from sql_exercise.Departments where Budget>(select min(Budget) from sql_exercise.Departments)) as D order by D.Budget limit 1 ) a , sql_exercise.Employees b where a.Code=b.Department;
#答案1
#通过limit2再倒序limit1非常聪明，这种写法可以推广到第三低，第四低等等。不会造成过重的负担
select name, lastname
from sql_exercise.Employees
where sql_exercise.Employees.Department =(
select temp.code
from (select * from sql_exercise.Departments order by budget limit 2) temp
order by temp.budget desc limit 1
);
#答案2
SELECT e.Name, e.LastName
FROM Employees e
WHERE e.Department = (
       SELECT sub.Code
       FROM (SELECT * FROM Departments d ORDER BY d.budget LIMIT 2) sub
       ORDER BY budget DESC LIMIT 1);
-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11.
insert  sql_exercise.Departments (Code, Name, Budget) values (11,'Quality Assurance',40000);
-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
insert sql_exercise.Employees (SSN, Name, LastName, Department) values (847219811,'Mary','Moore',11);
-- 2.17 Reduce the budget of all departments by 10%.
update sql_exercise.Departments set Budget=Budget*0.9;
-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
update sql_exercise.Employees set Department =14 where Department=77;#外键约束，这里的更新的department值必须在Departments表中是存在的。否则不能更新
-- 2.19 Delete from the table all employees in the IT department (code 14).
delete from sql_exercise.Employees  where Department=14;
-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
delete from sql_exercise.Employees where sql_exercise.Employees.Department in  (select sql_exercise.Departments.Code from sql_exercise.Departments where sql_exercise.Departments.Budget>=60000);
-- 2.21 Delete from the table all employees.
#这我就不写了，太无聊了