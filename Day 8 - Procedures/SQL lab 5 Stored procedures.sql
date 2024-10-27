--1--
Use ITI
Create Proc NumStudents
as 
Select Count(St_ID)
From Student 

NumStudents 


--2--
use Company_SD




--3--
use Company_SD
Create Proc EmployeeExit (@OldEmp int, @NewEmp int)
as 
Begin
Update Employee 
set Superssn = @NewEmp
Where Superssn = @OldEmp

Update Departments 
set MGRSSN = @NewEmp
Where MGRSSN = @OldEmp

Update Works_for 
set ESSn = @NewEmp
Where ESSn = @OldEmp

Update Dependent 
set ESSn = @NewEmp
Where ESSn = @OldEmp

Delete Dependent 
Where ESSN  = @OldEmp

Delete Employee 
Where SSN  = @OldEmp
End

EXEC EmployeeExit 112233, 321654 


--4--
Alter table Project 
Add Budget int ;

update Project 
set Budget = PNumber+20*7

create table Audit 
(
	ProjectNo int,
	UserName nvarchar(20),
	ModificationDate Date,
	BudgetOld float,
	BudgetNew float,
	foreign key (ProjectNo) References Project (Pnumber),
	primary key (ProjectNo, UserName)
)


insert into Audit (ProjectNo, UserName, ModificationDate,BudgetOld, BudgetNew)
values(100, 'Dbo', '2008-01-31', 95000, 200000)

---
Create Trigger TBudget
on Project
after update Budget
as 
insert into Audit (ProjectNo, UserName, ModificationDate,BudgetOld, BudgetNew)
values(inserted.Pnumber, 'Dbo', '2008-01-31', 95000, 200000)
--

--5--
use ITI

create trigger TDepartment
on Department
instead of update
as
	select '<!>You are not authroized to add a new record<!>'


--6--
Use Company_SD

Create trigger TEmployee
on Employee
instead of delete
as
	if format(getdate(),'MMMM') = 'March'
		select '<!>Cannot add employees in march<!>'
	else
		insert into Employee
		select * from deleted
		

--7--
create table StudentAudit 
(
	ServerUserName Varchar(20) primary key,
	ActionDate Date,
	Note varchar(100)
)

