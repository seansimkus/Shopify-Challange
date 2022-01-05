-- Query
-- How many orders were shipped by Speedy Express in total?
SELECT COUNT(*) AS Num_Orders FROM Orders JOIN (
    SELECT * FROM Shippers
    WHERE ShipperName = 'Speedy Express') AS SpeedyExpress
ON Orders.ShipperID = SpeedyExpress.ShipperID;

-- Result
-- Num_Orders: 54


-- What is the last name of the employee with the most orders?
-- Query
SELECT LastName FROM Employees JOIN (
    SELECT EmployeeID, COUNT(*) AS num_orders FROM [Orders]
    GROUP BY EmployeeID
    ORDER BY num_orders DESC
    LIMIT 1) AS TopEmployee
ON Employees.EmployeeID = TopEmployee.EmployeeID;

-- Result
-- LastName: Peacock


-- What product was ordered the most by customers in Germany?
-- Query
Select ProductName FROM Products JOIN (
	Select ProductID, SUM(Quantity) AS AmountOrdered FROM OrderDetails join (
		SELECT OrderID FROM Orders 
        	WHERE CustomerID IN (
        		SELECT CustomerID FROM Customers
			WHERE Country = 'Germany')) AS GermanOrders
	on OrderDetails.OrderID = GermanOrders.OrderID
	GROUP BY ProductID
	ORDER BY AmountOrdered DESC
	LIMIT 1) AS TopGermanOrder
ON Products.ProductID = TopGermanOrder.ProductID;

-- Result
-- ProductName: Boston Crab Meat

