use HotelDatabase

-- Insert sample data into Hotels
INSERT INTO Hotel (HotelName, HotelLocation, HotelRating)
VALUES 
('Grand Plaza', 'New York', 4.5),
('Royal Inn', 'London', 4.0),
('Ocean Breeze', 'Miami', 4.2),
('Mountain Retreat', 'Denver',  3.9),
('City Lights Hotel', 'Las Vegas',4.7),
('Desert Oasis', 'Phoenix',  4.3),
('Lakeview Lodge', 'Minnesota', 4.1),
('Sunset Resort', 'California',  3.8);


INSERT INTO Hotel_Contact( PhoneNo)
VALUES
('123-456-7890'),
('234-567-8901'),
( '456-789-0123'),
('567-890-1234'),
( '678-901-2345'),
('789-012-3456'),
('890-123-4567'),
('345-678-9012')


-- Insert sample data into Rooms
INSERT INTO Room (H_ID, RoomNum, Room_Type, Price_P_Night, Room_Avail)
VALUES 
(1, 101, 'Single', 100, 1),
(1, 102, 'Double', 150, 1),
(1, 103, 'Suite', 300, 1),
(2, 201, 'Single', 90, 1),
(2, 202, 'Double', 140, 0),
(3, 301, 'Suite', 250, 1),
(4, 401, 'Single', 120, 1),
(4, 402, 'Double', 180, 1),
(5, 501, 'Suite', 350, 1),
(5, 502, 'Single', 130, 0),
(6, 601, 'Double', 200, 1),
(6, 602, 'Suite', 400, 0),
(7, 701, 'Single', 110, 1),
(7, 702, 'Double', 160, 1),
(8, 801, 'Suite', 380, 1),
(8, 802, 'Single', 140, 1);

-- Insert sample data into Guests
INSERT INTO Guest (G_First, G_Last, Guest_Contact, Guest_Proof, Proof_Num)
VALUES 
('John','Doe', '567-890-2234', 'Passport', 1234567),
('Alice','Smith', '678-901-1345', 'Driver License', 8901234),
('Robert','Brown', '789-012-3456', 'ID Card', 567890),
('Sophia','Turner', '212-345-6789', 'Passport', 2345678),
('James','Lee', '123-656-7890', 'ID Card', 890123),
('Emma','White', '934-567-8901', 'Driver License', 3456789),
('Daniel','Kim', '345-678-9212', 'Passport', 3456789),
('Olivia','Harris', '451-789-0123', 'ID Card', 234567),
('Noah','Brown', '567-890-1234', 'Driver License', 4567890),
('Ava','Scott', '678-921-2345', 'Passport', 4567890),
('Mason','Clark', '189-012-3456', 'ID Card', 345678);

-- Insert sample data into Bookings
INSERT INTO Booking (G_ID, Room_Num, Booking_Date, CheckIn_Date, CheckOut_Date, Booking_Status, Booking_Total)
VALUES 
(41, 101, '2024-10-01', '2024-10-05', '2024-10-10', 'Confirmed', 500),
(32, 102, '2024-10-15', '2024-10-20', '2024-10-25', 'Pending', 750),
(33, 103, '2024-10-05', '2024-10-07', '2024-10-09', 'Check-in', 600),
(34, 201, '2024-10-10', '2024-10-12', '2024-10-15', 'Confirmed', 360),
(35, 202, '2024-10-16', '2024-10-18', '2024-10-21', 'Pending', 540),
(36, 301, '2024-10-05', '2024-10-08', '2024-10-12', 'Check-in', 800),
(37, 401, '2024-10-22', '2024-10-25', '2024-10-28', 'Confirmed', 450),
(38, 501, '2024-10-15', '2024-10-18', '2024-10-20', 'Pending', 420),
(41, 701, '2024-10-25', '2024-10-27', '2024-10-29', 'Confirmed', 340),
(32, 801, '2024-10-19', '2024-10-21', '2024-10-24', 'Check-in', 480);

-- Insert sample data into Payments
INSERT INTO Payment (Book_ID, Payment_Date, Payment_Amount, Payment_Method)
VALUES 
(3, '2024-10-02', 250, 'Credit'),
(3, '2024-10-06', 250, 'Credit'),
(4, '2024-10-16', 750, 'Debit'),
(5, '2024-10-11', 180, 'Credit'),
(5, '2024-10-14', 180, 'Credit'),
(6, '2024-10-17', 270, 'Debit'),
(6, '2024-10-20', 270, 'Credit'),
(7, '2024-10-06', 400, 'Cash'),
(7, '2024-10-09', 400, 'Credit'),
(8, '2024-10-23', 450, 'Debit');

-- Insert sample data into Staff
INSERT INTO Staff_Member(FirstName, LastName, Staff_Position, Staff_Contact, Hotel_ID)
VALUES 
('Michael','Johnson', 'Manager', '890-123-4567', 1),
('Emily','Davis', 'Receptionist', '901-234-5678', 2),
('David','Wilson', 'Housekeeper', '012-345-6789', 3),
('Laura','Thompson', 'Manager', '901-234-5678', 4),
('Ryan','Foster', 'Receptionist', '012-345-6789', 5),
('Sophia','Roberts', 'Housekeeper', '123-456-7890', 6),
('Ethan','Walker', 'Chef', '234-567-8901', 7),
('Liam','Mitchell', 'Security', '345-678-9012', 8),
('Isabella','Martinez', 'Manager', '456-789-0123', 1);

-- Insert sample data into Reviews
INSERT INTO Review (GuestID, HotelID, Rev_Rating, Rev_Comment, Rev_Date)
VALUES 
(41, 1, 5, 'Excellent stay!', '2024-10-11'),
(32, 2, 4, 'Good service, but room was small.', '2024-10-26'),
(33, 3, 3, 'Average experience.', '2024-10-12'),
(34, 1, 4, 'Good experience, but room service was slow.', '2024-10-16'),
(35, 2, 5, 'Amazing ambiance and friendly staff.', '2024-10-20'),
(36, 3, 3, 'Decent stay, but room cleanliness needs improvement.', '2024-10-25'),
(37, 4, 4, 'Great location, will visit again!', '2024-10-27'),
(38, 5, 2, 'Not satisfied with the facilities.', '2024-10-29');