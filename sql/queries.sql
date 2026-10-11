-- Required queries for the restaurant database

USE RestaurantDB;

-- 1. Show all tables in the restaurant.

SELECT
    tableID,
    tableNumber,
    capacity,
    location,
    isActive
FROM DiningTable
WHERE restaurantID = 1
ORDER BY tableNumber;

-- 2. Show all bookings for one customer, ordered by date and time.
-- Change the customer ID to test another customer.

SET @customerID = 1;

SELECT
    b.bookingID,
    b.bookingDate,
    b.bookingTime,
    r.name AS restaurant,
    t.tableNumber,
    b.numberOfGuests,
    b.status,
    b.specialRequests
FROM Booking AS b
JOIN DiningTable AS t
    ON b.tableID = t.tableID
JOIN Restaurant AS r
    ON t.restaurantID = r.restaurantID
WHERE b.customerID = @customerID
ORDER BY b.bookingDate, b.bookingTime;

-- 3. Show the bookings and customers for one table on a specific date.
-- Change the table ID and date to test other bookings.

SET @tableID = 3;
SET @bookingDate = '2026-10-10';

SELECT
    b.bookingID,
    b.bookingDate,
    b.bookingTime,
    t.tableNumber,
    c.firstName,
    c.lastName,
    c.email,
    c.phone,
    b.numberOfGuests,
    b.status,
    b.specialRequests
FROM Booking AS b
JOIN Customer AS c
    ON b.customerID = c.customerID
JOIN DiningTable AS t
    ON b.tableID = t.tableID
WHERE b.tableID = @tableID
  AND b.bookingDate = @bookingDate
ORDER BY b.bookingTime;
