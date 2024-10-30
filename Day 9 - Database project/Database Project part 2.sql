use HotelDatabase

-- 1. INDEXING REQUIREMENTS--

--Hotel table indexes
CREATE NONCLUSTERED INDEX IDX_Hotel
    ON Hotel (HotelName)


CREATE NONCLUSTERED INDEX IDX_HotelRating
    ON Hotel (HotelRating)


--Room table indexes
DROP TABLE Payment --Need to drop to change PKs 
DROP TABLE Booking


CREATE NONCLUSTERED INDEX IDX_RoomNum ON Room (RoomNum); 

CREATE NONCLUSTERED INDEX IDX_RoomType
    ON Room (Room_Type)


--Booking table indexes
CREATE TABLE Booking
(
	BID int Primary Key Identity(1,1), 
	Checkin_Date Date , 
	Booking_Date Date  Not Null, 
	Booking_Total float,
	Checkout_Date Date, 
	Booking_Status varchar(20) CONSTRAINT CK_Status check(Booking_Status in ( 'Pending', 'Confirmed', 'Canceled', 'Check-in', 'Check-out'))   Not Null ,
	G_ID int,
	Room_Num int, 
	Foreign Key (G_ID) references Guest(GID) ON DELETE CASCADE  ON UPDATE CASCADE,
	Foreign Key (Room_Num) references Room(RoomNum) ON DELETE CASCADE  ON UPDATE CASCADE
)

CREATE NONCLUSTERED INDEX IDX_GuestID
    ON Booking (G_ID)


CREATE NONCLUSTERED INDEX IDX_GuestStatus
    ON Booking (Booking_Status)


CREATE NONCLUSTERED INDEX IDX_Booking
    ON Booking (Room_Num, Checkin_Date, Checkout_Date)

CREATE TABLE Payment 
(
	PID int Primary Key Identity(1,1),
	Payment_Date Date  Not Null, 
	Payment_Amount float  Not Null, 
	Book_ID int ,
	Payment_Method varchar CONSTRAINT CK_Method check(Payment_Method in ( 'Debit', 'Credit', 'Cash')),
	Foreign Key (Book_ID) references Booking(BID) ON DELETE CASCADE  ON UPDATE CASCADE,
)


--ADDING VALUES TO TABLES 
ALTER TABLE Room
DROP CONSTRAINT CK_Avail 

ALTER TABLE Room
ADD CONSTRAINT  CK_Avail check(Room_Avail in ( 1, 0)) 

Drop Table Staff_Member

CREATE TABLE Staff_Member
(
	SID int Primary Key Identity(1,1),
	Staff_Contact  varchar(20),
	FirstName varchar(10),
	LastName varchar(10),
	Staff_Position varchar(20),
	Hotel_ID int,
	foreign key (Hotel_ID) references Hotel(HID)  ON DELETE CASCADE  ON UPDATE CASCADE
)


Drop Table Review

CREATE TABLE Review 
(
	RID int Primary Key Identity(1,1),
	Rev_Comment varchar(MAX) Default('No comments'),
	Rev_Rating int CONSTRAINT CK_Rev check(Rev_Rating between 1 and 6),
	Rev_Date Date  Not Null,
	HotelID int, 
	GuestID int, 
	Foreign Key (HotelID) references Hotel(HID) ON DELETE CASCADE  ON UPDATE CASCADE,
	Foreign Key (GuestID) references Guest(GID) ON DELETE CASCADE  ON UPDATE CASCADE
)


--2. VIEWS--

--Top rated hotels 
---------------------------------------------------
CREATE VIEW VAvgRoomPrice 
AS 
Select H_ID, Avg(Price_P_Night) AS AveragePrice
From Room
Group by H_ID

select * from VAvgRoomPrice

---------------------------------------------------
CREATE VIEW VTotalRooms 
AS 
Select H_ID, Count(RoomNum) AS AvailableRooms
From Room
Group by H_ID

select * from VTotalRooms
---------------------------------------------------
CREATE VIEW VTopHotels
AS
	SELECT *
	FROM Hotel
	WHERE HotelRating >= 4.5


select * from VTopHotels
---------------------------------------------------



--view guest bookinngs
AS
Select GID, Count(Distinct BID) AS 'Total Bookings', Sum(Booking_Total) AS 'Total Spent'
From Guest join Booking on GID = G_ID
Group by GID

select * from ViewGuestBookings


--view available rooms 
CREATE VIEW ViewAvailableRooms
AS 
Select *
From Room Join Hotel on H_ID = HID
Where Room_Avail = 1 --take 1 to be available  
Order by Price_P_Night, Room_Type offset 0 rows


select * from ViewAvailableRooms



--view boking summary
CREATE VIEW ViewBookingSummary 
AS

Select *
From Booking

Select *
From Booking join Room on Room_Num = RoomNum
Order by H_ID 


Select H_ID, Count(*) AS 'Total Bookings' , Count('Confirmed') AS 'Confirmed Bookings', Count('Pending') AS 'Pending', Count('Canceled') AS Canceled
From Booking join Room on Room_Num = RoomNum
Group by H_ID  


--view payment history
CREATE VIEW ViewPaymentHistory 
AS
Select P.*, G_First, G_Last, HotelName, Booking_Status, Booking_Total
From Payment P Join Booking on Book_ID = BID Join Guest on G_ID = GID Join Room on  Room_Num = RoomNum Join Hotel on H_ID = HID

select * from ViewPaymentHistory



--3. FUNCTIONS--

--Get hotel average rating 
CREATE FUNCTION GetHotelRating(@id int)
Returns table 
AS
Return (Select HotelID, Avg(Rev_Rating)  AS AverageRating
From Review 
Where HotelID = @id
Group by  HotelID )

Select * from GetHotelRating(2)


--Get next availale room
CREATE FUNCTION AvailableRoom(@id int)
Returns table 
AS
Return (Select Top(1) *
From Room
Where H_ID = @id and Room_Avail = 1
)

Select * from AvailableRoom(4)


--Calculate occupancy rate 
CREATE FUNCTION GetOccupancy(@id int)
Returns table 
AS
Return (Select Count(BID) AS 'Occupancy rate'
From Booking Join Room on RoomNum = Room_Num
Where H_ID = @id
Group by H_ID)

Select * from GetOccupancy(2)


--4. STORED PROCEDURE--

--mark room as unavailable 
create Proc RoomUnavailable   @room int
as
	Update Room
	Set Room_Avail = 0
	Where RoomNum = @room


RoomUnavailable 103


--Update booking status
create Proc UpdateBooking   @BookingID int
as
DECLARE @Checkin_Date Date
DECLARE @Checkout_Date Date
DECLARE @Status VarChar(20)

Select 
@Checkin_Date = Checkin_Date,
@Checkout_Date = Checkout_Date,
@Status  = Booking_Status

From Booking 
Where  @BookingID  = BID
	
	if (GETDATE() > @Checkin_Date and GetDate() < @Checkout_Date)
	Update Booking
	Set Booking_Status  = 'Check_in'
	Where BID = @BookingID

	else if (GETDATE() > @Checkin_Date and GetDate() > @Checkout_Date and @Status = 'Pending')
	Update Booking
	Set Booking_Status = 'Canceled'
	Where BID = @BookingID

	else if (GETDATE() > @Checkin_Date and GetDate() > @Checkout_Date and (@Status = 'Check-in' or Booking_Status = 'Confirmed' ))
	Update Booking
	Set Booking_Status = 'Check-out'
	Where BID = @BookingID

Execute UpdateBooking 


Select *
From Booking


--Rank Guests by Spending 
Select G_ID, Sum(Booking_Total) AS 'Total Spent'
From Booking
Group by G_ID
Order by 'Total Spent' Desc




--5.TRIGGERS--

--Update room Availablity 
CREATE TRIGGER TUpdateRoomAvailability
ON Booking 
AFTER INSERT 
AS 
DECLARE @PlaceHolder int

Select  Room_Num = @PlaceHolder
From inserted 

RoomUnavailable Select @PlaceHolder


--Calculate total revenue 
CREATE TRIGGER TTotalRevenue
ON Payment 
AFTER INSERT 
AS 
Select Sum(Payment_Amount) AS Revenue
From Payment 

Select *
From Payment

INSERT INTO Payment (Book_ID, Payment_Date, Payment_Amount, Payment_Method)
VALUES 
(3, '2024-10-02', 250, 'Credit')


--Check in date validation 
CREATE TRIGGER TCheckInValidation
on Booking
instead of insert
as
begin
if exists(
Select * 
from inserted 
Where(Checkin_Date > Checkout_Date ))
Begin
select '<!>Check in date must be less than check out date<!>'
End

else
Begin
	insert into Booking (G_ID, Room_Num, Booking_Date, CheckIn_Date, CheckOut_Date, Booking_Status, Booking_Total)
	Select G_ID, Room_Num, Booking_Date, CheckIn_Date, CheckOut_Date, Booking_Status, Booking_Total
	From inserted
End
End
