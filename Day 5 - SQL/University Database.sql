create database University 

use University 


-- Creating tables and adding required constraints :)
Create Table Instructor 
(
ID int Primary Key Identity, 
FName varchar(10),
LName varchar(10),
BD Date, 
Overtime int Unique, 
Salary float Default 3000  CONSTRAINT SalaryLimit check(Salary between 1000 and 5000), 
HireDate Date Default (GetDate()), 
Address varchar (5) check (Address in ('Alex', 'Cairo')), 
Age AS (DateDiff(year, GetDate(), BD)),
NetSalary AS (Salary + Overtime)
)

Create Table Course 
(
CID int Primary Key Identity,
CName varchar(10),
Duration int Unique 
)


Create Table Instructor_Course
(
IID int, 
CourseID int,
Primary Key (IID, CourseID),
FOREIGN KEY (IID) REFERENCES Instructor(ID),
FOREIGN KEY (CourseID) REFERENCES Course(CID)
)


Create Table Lab
(
LID int Identity, 
SubjectID int, 
Capacity int Default 1 CONSTRAINT CapacityLimit check(Capacity between 0 and 21), 
Primary Key (LID, SubjectID),
FOREIGN KEY (SubjectID) REFERENCES Course(CID)
)