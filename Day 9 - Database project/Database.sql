CREATE DATABASE HotelDatabase


use HotelDatabase

CREATE TABLE Hotel
(
	HID int Primary Key Identity(1,1),
	HotelLocation varchar(20),
	HotelName varchar(20), 
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
	foreign key (Hotel_ID) references Hotel(HID)
)

CREATE TABLE Room
(
	RoomNum int Primary Key,
	Room_Type varchar(20), 
	Price_P_Night float, 
	Room_Avail int CONSTRAINT CK_Avail check(Room_Avail between 1 and 0),
	Room_Stat varchar(20),
	H_ID int,
	foreign key (H_ID) references Hotel(HID)
)


CREATE TABLE Guest
(
	GID int Primary Key Identity(1,1), 
	Guest_Contact int, 
	G_First varchar(10),
	G_Last varchar(10),
	Guest_Proof varchar(20)
)


CREATE TABLE Hotel_Contact
(
	Hotel_ID int, 
	PhoneNo int,
	Foreign Key (Hotel_ID) references Hotel(HID)
)


CREATE TABLE Review 
(
	RID int Primary Key Identity(1,1),
	Rev_Comment varchar(20),
	Rev_Rating int CONSTRAINT CK_Rev check(Rev_Rating between 1 and 6),
	Rev_Date Date,
	HotelID int, 
	GuestID int, 
	Foreign Key (HotelID) references Hotel(HID),
	Foreign Key (GuestID) references Guest(GID)
)


CREATE TABLE Booking
(
	BID int Primary Key Identity(1,1), 
	Checkin_Date Date, 
	Booking_Date Date, 
	Booking_Total float,
	Checkout_Date Date, 
	Booking_Status varchar(20),
	G_ID int,
	Room_Num int, 
	Foreign Key (G_ID) references Guest(GID),
	Foreign Key (Room_Num) references Room(RoomNum)
)


CREATE TABLE Payment 
(
	PID int Primary Key Identity(1,1),
	Payment_Date Date, 
	Payment_Amount float, 
	Book_ID int ,
	
	Payment_Method varchar CONSTRAINT CK_Method check(Payment_Method  = 'Debit' or Payment_Method  ='Credit' or Payment_Method  ='Cash'),
	Foreign Key (Book_ID) references Booking(BID),
)