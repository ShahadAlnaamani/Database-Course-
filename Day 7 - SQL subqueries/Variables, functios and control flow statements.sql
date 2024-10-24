use ITI 

--1--
Create Function ITI.MonthConverter(@input Date)
Returns varchar(20)
AS
Begin
	Return DateName(Month, @input)
End 

DECLARE @date datetime2 = '2018-02-01';
Select ITI.MonthConverter(@date) AS Result;


--2--
create function GetMiddle(@Value1 int, @Value2 int)
returns @t table
(FirstValue int,
SecondValue int,
Result int)

AS
begin 
	Declare @number int
	Declare @Total int
	if @Value1 > @Value2
	begin
		set @number = (@Value1 - @Value2) /2
		set @Total = @Value2 + @number

		insert into @t
		Select @Value1, @Value2, @number
	end

	else 
	begin 
		set @number = (@Value2 - @Value1) /2
		set @Total = @Value1 + @number

		insert into @t
		Select @Value1, @Value2, @number
	end

	return

end 

select * from GetMiddle(4, 10) 

drop function GetMiddle



--3--
Create Function ITI.StudentFinder(@StudentNo int)
returns table   
    as
    return
    (
     select St_Fname + ' ' + St_Lname as 'Student Name', Dept_Name
     from Student S join Department D
	 on S.Dept_Id = D.Dept_Id
     where @StudentNo = St_Id
    )


select * from ITI.StudentFinder(9)   
drop function ITI.StudentFinder


--4--
Create Function ITI.GetStudentName(@ID int)
Returns varchar(20)
AS
Begin
	Declare @Response varchar(20)
	Declare @Fname varchar(20)
	Declare @Lname varchar(20)

	Select @Fname =  St_Fname, @Lname = St_Lname
	From Student 
	Where St_Id = @ID

	if (@Fname IS NULL and @Lname IS NULL )
	Begin
	Set @Response =  'First name & last name are null'
	End

	else if (@Fname IS NULL )
	Begin 
	Set @Response = 'First name is null'
	End

    else if (@Lname IS NULL)
	Begin
	Set @Response = 'Last name is null'
	End

	else 
	Begin 
	Set @Response = 'First name & last name are not null'
	End 

	Return @Response 

End 

Select ITI.GetStudentName(1) AS Result;



--5--
Update Department --Dept managers where null so added value 
Set Dept_Manager = 1
Where  Dept_Id = 10
	
Create Function ITI.GetManagerInfo(@ID int)
Returns table  
    as
    return
    (
     select Dept_Name, Ins_Name, Manager_hiredate      
     from Department join Instructor 
	 on Dept_Manager =  Ins_Id
     where Dept_Manager = @ID
    )

Select * From ITI.GetManagerInfo(1) 


--6--
create function GetStuds(@Format varchar(20))
returns @t table
            (
             fname varchar(20) ,
             sname varchar(20) 
            )
   as
    begin

	        insert into @t
            select IsNull(St_Fname, 'First name null'), IsNull(St_Lname, 'Second name null')
			from Student 
			Where St_Fname = @Format or St_Lname = @Format or @Format = St_Fname+St_Lname
return
end 

    drop function GetStuds

select * from getstuds('Amr')


--7--
Use Company_SD

declare c1 Cursor
for select salary
    from Employee
for update
declare @sal int
open c1
fetch c1 into @sal
while @@fetch_status=0
    begin
        if @sal>=3000
            update Employee
                set salary = @sal+(@sal*0.2)
            where current of c1
        else
            update Employee
                set salary = @sal+(@sal*0.1)
            where current of c1
        fetch c1 into @sal
    end
close c1
deallocate c1


--8--
declare c1 cursor
for select distinct Fname
    from Employee 
    where Fname is not null
for read only
declare @Table table 
(Firstname varchar(20),
Lastname Varchar(20)
)
open c1
fetch c1 into @Table 
while @@FETCH_STATUS=0
    begin
        set @Table.Firstname = Fname
		set @Table.Lastname = Lname 
        fetch c1 into @Table   --Next Row 
    end
select * from @Table 
close c1
deallocate C1


--9--
declare c2 cursor
for select distinct Fname
    from Employee
    where Fname is not null
for read only
declare @name varchar(20),@all_names varchar(300)='' --> initial value
open c2
fetch c2 into @name
while @@FETCH_STATUS=0
    begin
        set @all_names=concat(@all_names,',',@name)
        fetch c2 into @name   --Next Row 
    end
select @all_names
close c2
deallocate C2