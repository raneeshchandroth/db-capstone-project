show databases;

-- Use DB
use LittleLemonDB;

-- Create View
create view OrdersView as 
select OrderID, Quantity, TotalCost from Orders where Quantity > 2;

-- Select from View
select * from OrdersView;

-- Join
select c.CustomerID, CustomerName, o.OrderID, o.TotalCost, m.MenuName, mi.CourseName
from Customer_Details c 
join Orders o on o.CustomerID = c.CustomerID
join Menu m on m.MenuID = o.MenuID
join MenuItems mi on mi.MenuItemsID = m.MenuItemsID
where o.TotalCost > 150;

-- ANY
select MenuName from Menu 
where MenuID = ANY (
	select MenuID from Orders where Quantity > 2 
);

-- Create Procedure
DELIMITER //

CREATE PROCEDURE GetMaxQuantity() 
BEGIN
	SELECT MAX(Quantity) FROM Orders;
END //

DELIMITER ;

-- Call the procedure
CALL GetMaxQuantity();

-- Create Prepare statement
PREPARE GetOrderDetail FROM
'SELECT OrderID, Quantity, TotalCost 
FROM Orders WHERE CustomerID = ?';

-- Call the Prepare statement
SET @id = 1;
EXECUTE GetOrderDetail USING @id;

-- Procedure to Delete order
DELIMITER //

CREATE PROCEDURE CancelOrder(IN inputOrderID INT)
BEGIN
    DELETE FROM Orders 
    WHERE OrderID = inputOrderID;
END //

DELIMITER ;

-- Call cancel order
CALL CancelOrder(5);

select * from Booking;
-- update Booking set BookingDate = '2022-10-11', CustomerID = 2 where BookingID = 3;
-- insert into Booking(BookingID, CustomerID, TableNumber, BookingDate) values (4, 1, 2, '2022-10-13');

-- Procedure to Check Booking
DELIMITER //

CREATE PROCEDURE CheckBooking(IN BookingDate DATE, IN TableNum INT)
BEGIN
    DECLARE TableStatus INT;
    
    SELECT COUNT(*) INTO TableStatus
    FROM Booking
    WHERE date(BookingDate) = BookingDate AND TableNumber = TableNum;
    
    IF TableStatus > 0 THEN
        SELECT CONCAT('Table ', TableNum, ' is already booked') AS 'Booking Status';
    ELSE
        SELECT CONCAT('Table ', TableNum, ' is available') AS 'Booking Status';
    END IF;
END //

DELIMITER ;

-- Call the procedure
call CheckBooking('2022-11-12', 3);

-- drop procedure
-- drop procedure CheckBooking;


-- procedure to Add Valid Booking
DELIMITER //

CREATE PROCEDURE AddValidBooking(IN BookingDate DATE, IN TableNum INT)
BEGIN
	DECLARE TableExists INT DEFAULT 0;
    DECLARE MaxBookingID INT;
    START TRANSACTION;
		SELECT MAX(BookingID) INTO MaxBookingID FROM Booking;
    
		INSERT INTO Booking (BookingID, BookingDate, TableNumber, CustomerID) 
        VALUES (MaxBookingID + 1, BookingDate, TableNum, 1);
		
        SELECT COUNT(*) INTO TableExists
        FROM Booking 
        WHERE DATE(BookingDate) = BookingDate AND TableNumber = TableNum;
        
        IF TableExists > 1 THEN
			ROLLBACK;
            SELECT CONCAT('Table ', TableNum, ' is already booked - booking cancelled') AS 'Booking status';
		ELSE
			COMMIT;
            SELECT CONCAT('Table ', TableNum, ' successfully booked') AS 'Booking status';
		END IF;
	END //
    
    DELIMITER ;
    
-- Call the procedure
CALL AddValidBooking('2022-12-17', 6);
    
-- Drop Procedure
-- DROP PROCEDURE AddValidBooking;

-- AddBooking Procedure
DELIMITER //
CREATE PROCEDURE AddBooking(
	IN p_BookingID INT,
    IN p_CustomerID INT,
    IN p_BookingDate DATE,
    IN p_TableNumber INT
)
BEGIN
	INSERT INTO Booking(
		BookingID, 
        CustomerID,
        BookingDate,
        TableNumber
    ) VALUES (
		p_BookingID,
        p_CustomerID,
        p_BookingDate,
        p_TableNumber
    );
SELECT "New booking added successfully" AS Status;
END //

DELIMITER ;

-- CALL Procedure
CALL AddBooking(9, 3, '2022-12-30', 4);

-- UpdateBooking Procedure
DELIMITER //

CREATE PROCEDURE UpdateBooking(IN p_BookingID INT, IN p_BookingDate DATE)
BEGIN
	UPDATE Booking SET BookingDate = p_BookingDate WHERE BookingID = p_BookingID;
    SELECT CONCAT("Booking ", p_BookingID, " Updated successfully") AS Status;
END //

DELIMITER ;

-- CALL Procedure
CALL UpdateBooking(9, '2022-12-17');

-- DROP PROCEDURE UpdateBooking;


-- CancelBooking Procedure
DELIMITER //

CREATE PROCEDURE CancelBooking(IN p_BookingID INT)
BEGIN
	DELETE FROM Booking WHERE BookingID = p_BookingID;
    SELECT CONCAT("Booking ", p_BookingID, " Cancelled successfully") AS Status;
END //

DELIMITER ;
	
-- CALL Procedure 
CALL CancelBooking(9);
