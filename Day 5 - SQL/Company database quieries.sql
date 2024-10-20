use Company_SD

--Displaying all employee data 
Select * 
From Employee


--Display employee first name, last name, salary, and department no
Select Fname, Lname, Salary, Dno
From Employee

--Display projects names, locations and the department
Select Pname, Plocation, Dnum
From Project

--Display each employees commission 
Select (Fname + ' ' + Lname )  as [Full Name], (10*Salary/100) as [Annual Comm]
From Employee


--	Display the employees Id, name who earns more than 1000 LE monthly
Select SSN, Fname
From Employee
Where Salary/12 >1000 --Dividing salary over 12 months 


--	Display the employees Id, name who earns more than 1000 LE yearly
Select SSN, Fname
From Employee
Where Salary >1000


--	Display the names and salaries of the female employees 
Select Fname, Salary
From Employee
Where Sex  = 'F' 


-- Display each department id, name which managed by a manager with id equals 968574.
Select Dnum, Dname, MGRSSN
From Departments
Where MGRSSN = 968574


--	Dispaly the ids, names and locations of  the pojects which controled with department 10
Select Pnumber, Pname, Plocation
From Project
Where Dnum = 10


--	Insert your personal data to the employee table 
insert into Employee(Fname,Lname,Bdate,Sex,Salary, Dno, SSN, SuperSSn)
values('Shahad','Alnaamani','11-10-2003','F',3000, 30, 102672, 112233)


-- Hiring a friend 
insert into Employee(Fname,Lname,Bdate,Sex,Salary, SSN)
values('Budoor','Alsadi','11-10-1997','F', 30, 102660)


--Salary increase  
update Employee
set Salary+=(Salary*20/100)
Where SSN = 102672
