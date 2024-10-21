use Company_SD


--1.    For each project, list the project name and the total hours per week (for all employees) spent on that project
Select Pname, Hours/4 AS 'Hours Per Week' --to find hours per week
From Project join Works_for on Pnumber = Pno

--2.    For each department, retrieve the department name and the maximum, minimum and average salary of its employees
Select Dname, Min(Salary) As MinSalary, Max(Salary) As MaxSalary, Avg(Salary) As AverageSalary
From Departments join Employee on Dno = Dnum
Group by Dname
