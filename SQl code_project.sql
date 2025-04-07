--Importing the Dataset
USE PROJECT;

--Table Creation and imported data using flat file
SELECT * FROM Bookingdata;

--EDA Process:

--1--Summarizing Key statistics
SELECT COUNT(*) AS Total_Bookings, COUNT(DISTINCT Customer_ID) AS Unique_customers,
	AVG(Duration_mins) AS Avg_duration , 
	AVG(Price) AS Avg_price,
	MIN(Price) AS min_price,
	MAX(Price) AS max_price
FROM Bookingdata;


--2--Finding the status of the booking
SELECT COUNT(*) AS counts , status
FROM bookingdata
GROUP BY status 
ORDER BY counts;

--3--Revenue analysis by service type 
SELECT	Service_Type , COUNT(*) AS booking_count , SUM(Price) AS total_revenue, AVG(Price) AS avg_price
FROM Bookingdata
GROUP BY Service_Type
ORDER BY total_revenue;

--4--Customer Preferences
SELECT * FROM Bookingdata;
SELECT Booking_Type ,Class_Type, COUNT(*) AS Bookings 
FROM Bookingdata
GROUP BY Booking_Type , Class_Type
ORDER BY Bookings;

--5--Most popular time slots
SELECT Time_Slot, COUNT(*) as Booking_Count
FROM Bookingdata
GROUP BY Time_Slot
ORDER BY Booking_Count DESC;

--6--Instructor analysis 
SELECT Instructor , COUNT(*) AS bookings, SUM(Price) AS revenue
FROM Bookingdata
WHERE Instructor != 'Unknown'
GROUP BY Instructor
ORDER BY bookings;

--7--Booking trend over time
SELECT FORMAT(Booking_Date, 'yyyy-MM') AS Booking_Month, COUNT(*) AS Total_Bookings
FROM Bookingdata
GROUP BY FORMAT(Booking_Date, 'yyyy-MM')
ORDER BY Booking_Month DESC;

--8--Services analysis
SELECT Service_Name , Service_Type , COUNT(*) AS bookings , SUM(Price) AS revenue
FROM Bookingdata
GROUP BY Service_Name,Service_Type
ORDER BY bookings DESC, revenue DESC;
