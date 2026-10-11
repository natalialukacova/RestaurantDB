-- Restaurant database setup
-- This file creates the database, tables and test data.


-- Create the database.

DROP DATABASE IF EXISTS RestaurantDB;
CREATE DATABASE RestaurantDB;
USE RestaurantDB;

-- Create the tables without foreign keys first.

CREATE TABLE Restaurant
(
    restaurantID INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(30) NOT NULL,
    email VARCHAR(190) NOT NULL,
    PRIMARY KEY (restaurantID)
);

CREATE TABLE Customer
(
    customerID INT NOT NULL AUTO_INCREMENT,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    email VARCHAR(190) NOT NULL UNIQUE,
    phone VARCHAR(30) NOT NULL,
    PRIMARY KEY (customerID)
);

-- Each dining table belongs to one restaurant.

CREATE TABLE DiningTable
(
    tableID INT NOT NULL AUTO_INCREMENT,
    restaurantID INT NOT NULL,
    tableNumber INT NOT NULL,
    capacity INT NOT NULL,
    location VARCHAR(50) NOT NULL,
    isActive BOOLEAN NOT NULL DEFAULT TRUE,

    PRIMARY KEY (tableID),

    UNIQUE (restaurantID, tableNumber),

    FOREIGN KEY (restaurantID)
        REFERENCES Restaurant (restaurantID),

    CHECK (capacity > 0)
);

-- A booking connects one customer with one dining table.

CREATE TABLE Booking
(
    bookingID INT NOT NULL AUTO_INCREMENT,
    customerID INT NOT NULL,
    tableID INT NOT NULL,
    bookingDate DATE NOT NULL,
    bookingTime TIME NOT NULL,
    numberOfGuests INT NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'Confirmed',
    specialRequests VARCHAR(255) NULL,

    PRIMARY KEY (bookingID),

    UNIQUE (tableID, bookingDate, bookingTime),

    FOREIGN KEY (customerID)
        REFERENCES Customer (customerID),

    FOREIGN KEY (tableID)
        REFERENCES DiningTable (tableID),

    CHECK (numberOfGuests > 0),

    CHECK (
        status IN ('Pending', 'Confirmed', 'Cancelled', 'Completed')
    )
);

-- Test data

INSERT INTO Restaurant (name, address, phone, email)
VALUES
('Nordic Table', 'Torvegade 18, 6700 Esbjerg', '+45 75 12 34 56', 'contact@nordictable.dk');

INSERT INTO DiningTable
    (restaurantID, tableNumber, capacity, location, isActive)
VALUES
(1, 1, 2, 'Window', TRUE),
(1, 2, 2, 'Window', TRUE),
(1, 3, 4, 'Main room', TRUE),
(1, 4, 4, 'Main room', TRUE),
(1, 5, 6, 'Main room', TRUE),
(1, 6, 6, 'Terrace', TRUE),
(1, 7, 8, 'Private room', TRUE),
(1, 8, 4, 'Terrace', FALSE);

INSERT INTO Customer (firstName, lastName, email, phone)
VALUES
('Emma', 'Jensen', 'emma.jensen@example.com', '+45 20 31 42 53'),
('Lucas', 'Nielsen', 'lucas.nielsen@example.com', '+45 22 41 58 67'),
('Sofia', 'Larsen', 'sofia.larsen@example.com', '+45 25 36 47 58'),
('Oliver', 'Hansen', 'oliver.hansen@example.com', '+45 28 39 40 51'),
('Freja', 'Madsen', 'freja.madsen@example.com', '+45 31 42 53 64'),
('Noah', 'Pedersen', 'noah.pedersen@example.com', '+45 34 45 56 67');

INSERT INTO Booking
    (customerID, tableID, bookingDate, bookingTime, numberOfGuests, status, specialRequests)
VALUES
(1, 1, '2026-10-03', '18:00:00', 2, 'Completed', 'Window table if possible'),
(2, 5, '2026-10-09', '19:30:00', 5, 'Confirmed', NULL),
(1, 3, '2026-10-10', '18:00:00', 4, 'Confirmed', 'One vegetarian guest'),
(3, 3, '2026-10-10', '20:00:00', 3, 'Confirmed', 'Birthday dinner'),
(4, 7, '2026-10-10', '19:00:00', 8, 'Pending', NULL),
(5, 2, '2026-10-12', '17:30:00', 2, 'Confirmed', 'High chair needed'),
(6, 6, '2026-10-16', '18:30:00', 6, 'Cancelled', NULL),
(1, 4, '2026-10-24', '20:00:00', 4, 'Confirmed', NULL);
