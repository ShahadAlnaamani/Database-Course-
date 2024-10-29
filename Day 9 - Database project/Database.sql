CREATE DATABASE HotelDatabase


use HotelDatabase


CREATE TABLE Hotel
(
	HID int Primary Key Identity(1,1),
	HotelLocation varchar(20)  Not Null,
	HotelName varchar(20) Unique Not Null, 
	HotelRating int CONSTRAINT CK_Rating check(HotelRating between 1 and 6) 
)


CREATE TABLE Staff_Member
(
	SID int Primary Key Identity(1,1),
	Staff_Contact int,
	FirstName varchar(10),
	LastName varchar(10),
	Staff_Position varchar(20),
	Hotel_ID int,
	foreign key (Hotel_ID) references Hotel(HID)  ON DELETE CASCADE  ON UPDATE CASCADE
)


CREATE TABLE Room
(
	RoomNum int Primary Key  Not Null,
	Room_Type varchar(20)  Not Null CONSTRAINT CK_Room check(Room_Type in ( 'Single', 'Double', 'Suite')), 
	Price_P_Night float CONSTRAINT CK_Price check(Price_P_Night > 0), 
	Room_Avail int CONSTRAINT CK_Avail check(Room_Avail between 1 and 0) Default(0),
	Room_Stat varchar(20),
	H_ID int,
	foreign key (H_ID) references Hotel(HID) ON DELETE CASCADE  ON UPDATE CASCADE
)


CREATE TABLE Guest
(
	GID int Primary Key Identity(1,1), 
	Guest_Contact varchar(20) Unique, 
	G_First varchar(10),
	G_Last varchar(10),
	Guest_Proof varchar(20)  Not Null,
	Proof_Num int  Not Null
)


CREATE TABLE Hotel_Contact
(
	Hotel_ID int, 
	PhoneNo int  Not Null,
	Foreign Key (Hotel_ID) references Hotel(HID) ON DELETE CASCADE  ON UPDATE CASCADE
)


CREATE TABLE Review 
(
	RID int Primary Key Identity(1,1),
	Rev_Comment varchar(20) Default('No comments'),
	Rev_Rating int CONSTRAINT CK_Rev check(Rev_Rating between 1 and 6),
	Rev_Date Date  Not Null,
	HotelID int, 
	GuestID int, 
	Foreign Key (HotelID) references Hotel(HID) ON DELETE CASCADE  ON UPDATE CASCADE,
	Foreign Key (GuestID) references Guest(GID) ON DELETE CASCADE  ON UPDATE CASCADE
)


CREATE TABLE Booking
(
	BID int Primary Key Identity(1,1), 
	Checkin_Date Date  CONSTRAINT CK_Date check(Checkin_Date < Checkout_Date or Checkin_Date = Checkout_Date), 
	Booking_Date Date  Not Null, 
	Booking_Total float,
	Checkout_Date Date, 
	Booking_Status varchar(20) CONSTRAINT CK_Status check(Booking_Status in ( 'Pending', 'Confirmed', 'Canceled', 'Check-in', 'Check-out'))   Not Null ,
	G_ID int,
	Room_Num int, 
	Foreign Key (G_ID) references Guest(GID) ON DELETE CASCADE  ON UPDATE CASCADE,
	Foreign Key (Room_Num) references Room(RoomNum) ON DELETE CASCADE  ON UPDATE CASCADE
)


CREATE TABLE Payment 
(
	PID int Primary Key Identity(1,1),
	Payment_Date Date  Not Null, 
	Payment_Amount float  Not Null, 
	Book_ID int ,
	Payment_Method varchar CONSTRAINT CK_Method check(Payment_Method  = 'Debit' or Payment_Method  ='Credit' or Payment_Method  ='Cash'),
	Foreign Key (Book_ID) references Booking(BID) ON DELETE CASCADE  ON UPDATE CASCADE,
)

