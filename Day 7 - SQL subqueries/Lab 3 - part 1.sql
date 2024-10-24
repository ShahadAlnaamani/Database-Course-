-- Part 1 
Use Company_SD

-- Display female Dependent names who depend on female employees and display employee names 
Select Dependent_name as 'Name' , Sex as 'Gender'
From Dependent 
Where Sex = 'F'
union 
Select Fname + ' ' + Lname as 'Name', Sex
From Employee 
Where Sex = 'F'


-- Same as above but for males 
Select Dependent_name as 'Name' , Sex as 'Gender'
From Dependent 
Where Sex = 'M'
union 
Select Fname + ' ' + Lname as 'Name', Sex
From Employee 
Where Sex = 'M'


--List project names and total hours per week spent on it
Select Pname, Sum(Hours)/4
From Project join Works_for on Pnumber = Pno
Group by Pname

-- For each department, retrieve the department name and the max, min and average salary of its employees
Select Dno as Department, Min(Salary) As 'Lowest Salary' , Max(Salary) as 'Highest Salary', Avg(Salary) 'Agerage Salary'
From Employee
Group by Dno


-- List the full name of all managers who have no dependents
Select  Fname + ' ' + Lname as 'Name'
From Employee 
Where SuperSSN not in  (Select Essn
From Dependent)


--For each department-- if its average salary is less than the average salary of all employees
Select Dnum as 'Number', Dname
From Departments 
Where Dnum in
(
Select Dno
from Employee
where Salary < (select avg(Salary) from Employee) )


-- Add department 
insert into Departments 
Values('Dept-IT', 100, 112233, '1-11-2006')


--Managers switching positions 
Update Departments 
set MGRSSN = 102672
Where MGRSSN = 968574

Update Departments 
set MGRSSN = 968574
Where MGRSSN = 112233



--Employee left 
Update Employee 
set Superssn = 102672
Where Superssn = 223344

Update Departments 
set MGRSSN = 102672
Where MGRSSN = 223344

Update Works_for 
set ESSn = 102672
Where ESSn = 223344

Update Dependent 
set ESSn = 0
Where ESSn = 223344

Delete Dependent 
Where ESSN  = 223344

Delete Employee 
Where SSN  = 223344


-- Update Salaries for employees who work in Project ‘Al Rabwah’ by 30%

Update Employee 
Set Salary = Salary + (Salary*0.3)
Where Exists (
	Select * from Works_for Where Exists
		(Select * from Project where Pname = 'Al Rabwah')
		)
