CREATE VIEW OrdersView AS SELECT OrderID, Quantity, TotalCost FROM Orders WHERE Quantity >2;

SELECT Customers.CustomerID, CONCAT(Customers.FirstName, ",", Customers.LastName) AS "Full NAme", Orders.OrderID, Orders.TotalCost, MenuItem.CourseName, Menus.MenuName FROM Customers INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN MenuItem ON Orders.OrderID = MenuItem.OrderID INNER JOIN Menus ON MenuItem.MenuItemID = Menus.MenuItemID ORDER BY Orders.TotalCost ASC;

SELECT MenuName FROM Menus WHERE  (SELECT OrderID FROM Orders WHERE Quantity > 2);

CREATE PROCEDURE GetMaxQuantity()
SELECT Quantity FROM Orders Order BY Quantity DESC LIMIT 1;

CALL GetMaxQuantity();

PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, TotalCost FROM Orders WHERE CustomerID = ?';
SET @custormer_id = 1;
EXECUTE GetOrderDetail USING @customer_id;

CREATE PROCEDURE CancelOrder(order_id INT)
DELETE FROM Orders WHERE OrderID = order_id;
CALL CancelOrder(5);


INSERT INTO Bookings(BookingID, BookingDate, TableNo, CustomerID) VALUES (4, "2022-10-13", 2, 1);

DELIMITER //
CREATE PROCEDURE CheckBooking(booking_date DATE, table_no INT)
BEGIN
    DECLARE booking_count INT DEFAULT 0;
    SELECT COUNT(BookingID) INTO booking_count FROM Bookings WHERE booking_date = BookingDate AND table_no = TableNo;
    IF booking_count > 0 THEN
        SELECT CONCAT('Table ', table_no, 'is booked on ', booking_date) AS 'BookingStatus';
    ELSE
        SELECT CONCAT('Table ', table_no, 'is available on ', booking_date) AS 'BookingStatus';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE AddValidBooking(booking_date DATE, table_no INT)
BEGIN
    DECLARE booking_count INT DEFAULT 0;
    START TRANSACTION;
    SELECT COUNT(BookingID) INTO booking_count FROM Bookings WHERE booking_date = booking_date AND table_no = table_no;
    IF booking_count = 0 THEN
        INSERT INTO Bookings (BookingDate, TableNo) VALUES (booking_date, table_no);
        COMMIT;
    ELSE
        ROLLBACK;
        SELECT CONCAT("Table ", table_no, " is already booked on ", booking_date) AS BookingStatus;
    END IF;
END//
DELIMITER ;

CALL AddValidBooking ("2022-12-17", 3);

CREATE PROCEDURE AddBooking(customer INT, booking_date DATE, table_no INT, customer_id INT)
INSERT INTO Bookings (BookingID, BookingDate, TableNo, CustomerID) VALUES (customer, booking_date, table_no, customer_id);

CALL AddBooking(9, "2022-12-30", 4, 3);

CREATE PROCEDURE UpdateBooking(booking_id INT, booking_date DATE)
UPDATE Bookings SET BookingDate = booking_date WHERE BookingID = booking_id;

CALL UpdateBooking(9, "2022-12-31");

CREATE PROCEDURE CancelBooking(booking_id INT)
DELETE FROM Bookings WHERE BookingID = booking_id;

CALL CancelBooking(9);











    




