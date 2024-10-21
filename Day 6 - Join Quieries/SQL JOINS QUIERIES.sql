use Company_SD

-- Display the Department id, name and id and the name of its manager
Select D.Dnum, D.Dname, M.SSN AS 'Manager ID' , M.Fname AS 'Manager Name'
From Departments D inner join Employee M
on D.MGRSSN = M.SSN

--Display the name of the departments and the name of the projects under its control
Select D.Dname, P.Pname
From Departments D inner join Project P
on D.Dnum = P.Dnum


--	Display the full data about all the dependence associated with the name of the employee they depend on
Select D.ESSN, D.Dependent_name, D.Sex, D.Bdate, E.Fname  + ' ' + E.Lname AS 'Employee Name'
From Dependent D inner join Employee E
on D.ESSN = E.SSN


--	Display the Id, name and location of the projects in Cairo or Alex city
Select Pnumber, Pname, City
From Project
Where City = 'cairo' or City = 'alex'


--	Display the Projects full data of the projects with a name starts with "a" letter
Select *
From Project
Where Pname like 'A%'


--	display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
Select *
From Employee
Where Dno = 30 and Salary between 1000 and 2000


--	Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project
Select E.Fname + ' ' + E.Lname AS 'Employee Name'
From Employee E inner join Works_for W on E.SSN = W.ESSn 
 inner join Project P on W.Pno = P.Pnumber
Where E.Dno = 10 and W.Hours >= 10 and P.Pname = 'Al Rabwah'


-- 	Find the names of the employees who directly supervised with Kamel Mohamed
Select E.Fname + ' ' + E.Lname AS 'Employee Name'
From Employee E inner join Employee M
on E.Superssn = M.SSN
Where E.Superssn = M.SSN and M.Fname = 'Kamel' and M.Lname = 'Mohamed'


--	Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name
Select E.Fname + ' ' + E.Lname AS 'Employee Name' , P.Pname
From Employee E inner join  Works_for W on E.SSN = W.ESSn 
inner join Project P on W.Pno = P.Pnumber
order by P.Pname


--	For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate
Select P.Pnumber, D.Dname, E.Lname, E.Address, E.Bdate
From Project P inner join Departments D on P.Dnum = D.Dnum
inner join Employee E on D.MGRSSN = E.SSN
inner join Works_for W on P.Pnumber = W.Pno
Where City = 'Cairo'


--	Display All Data of the managers
Select M.*
From Employee E inner join Employee M
on E.Superssn = M.SSN
Where E.Superssn = M.SSN
order by M.Fname


--	Display All Employees data and the data of their dependents even if they have no dependents
Select *
From Employee E left join Dependent D
on E.SSN = D.ESSN