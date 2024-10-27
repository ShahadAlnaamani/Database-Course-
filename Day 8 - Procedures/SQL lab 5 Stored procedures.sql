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
use Company_SD

Alter table Project 
Add Budget int ;

update Project 
set Budget = PNumber+20*7

create table Audit 
(
	ProjectNo int,
	UserName varchar(20),
	ModificationDate DateTime,
	BudgetOld float,
	BudgetNew float,
	foreign key (ProjectNo) References Project (Pnumber),
	primary key (ProjectNo, UserName, ModificationDate)
) 


Create trigger TBudget
on Project
after update 
as

begin 
if update (Budget)
begin

insert into Audit (ProjectNo, UserName, ModificationDate,BudgetOld, BudgetNew)
Select i.PNumber, system_user(), GETDATE(), d.Budget, i.Budget
from inserted i join deleted d on i.PNumber = d.PNumber

end 
end 


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
	Note Varchar(20)
)

Create trigger TStudentAudit
on Student 
after insert 
as
	Select * from inserted 
	Select * from deleted

begin
insert into StudentAudit ( suser_name() , getdate() ,  ( suser_name() + 'insert New Row with Key = ' + @@ROWCOUNT + ' in the table Student Table'))
end 

--8--
Use ITI

Create trigger TStudentDelete
on Student 
instead of delete 
as

SELECT @@SERVERNAME AS 'ServerName'; 

insert into StudentAudit( ServerName , getdate(), ( 'try to delete Row with Key' + @@KeyValue)
 