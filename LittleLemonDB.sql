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

