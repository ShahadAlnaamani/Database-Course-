CREATE DATABASE EmployeeDatabase

use EmployeeDatabase 


CREATE TABLE Employee 
(
 FName varchar(10),
 Minit  varchar(10),
 Lname  varchar(10),
 Ssn  int Primary Key,
 Bdate  Date,
 EAddress  varchar(10),
 Sex  bit,
 Salary  float,
 SuperSsn  int,

 FOREIGN KEY (SuperSsn) REFERENCES Employee(Ssn)
 )


 CREATE TABLE Department 
(
 DName varchar(10),
 DNumber int Primary Key, 
 MgrStartDate Date
 )

  CREATE TABLE DepLocations
(
 DLocation  varchar(10) Primary Key
 )

   CREATE TABLE Project
(
 PName  varchar(10),
 PNumber int Primary Key, 
 PLocation varchar(10)
 )


    CREATE TABLE WorksOn
(
Hours int
 )

     CREATE TABLE Dependant
(
DependantName varchar(10) Primary Key,
Sex  bit,
Bdate  Date,
Relationship  varchar(10)
 )

 DROP TABLE DepLocations;
 DROP TABLE WorksOn;


   CREATE TABLE DepLocations
(
 DLocation  varchar(10)
 )


     CREATE TABLE WorksOn
(
WorkHours int
 )




 ALTER TABLE Employee
ADD Dno int,
FOREIGN KEY (Dno) REFERENCES Department(DNumber)


 ALTER TABLE Department
ADD MgrSsn int,
FOREIGN KEY (MgrSsn) REFERENCES Employee(Ssn)


 ALTER TABLE DepLocations
ADD DNumber int,
PRIMARY KEY (DNumber, DLocation), 
FOREIGN KEY (DNumber) REFERENCES Department(DNumber)


 ALTER TABLE Project
ADD Dnum int,
FOREIGN KEY (Dnum) REFERENCES Department(DNumber)

 ALTER TABLE WorksOn
ADD Essn int,
FOREIGN KEY (Essn) REFERENCES Employee(Ssn)

 ALTER TABLE WorksOn
ADD Pno int,
PRIMARY KEY (Pno, Essn), 
FOREIGN KEY (Pno) REFERENCES Project(PNumber)

 ALTER TABLE Dependant
ADD Essn int,
PRIMARY KEY (Essn, DependantName),
FOREIGN KEY (Essn) REFERENCES Employee(Ssn)

ALTER TABLE DepLocations
ADD CONSTRAINT PK_DepLocations PRIMARY KEY (DLocation, DNumber);

ALTER TABLE DepLocations
ADD CONSTRAINT PK_DepLocations PRIMARY KEY (Essn, Pno);

ALTER TABLE Dependant
ADD CONSTRAINT PK_DepLocations PRIMARY KEY (Essn, DependantName);

