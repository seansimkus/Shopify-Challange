# ShopifyDSChallenge

This is my submission for Winter 2022 Data Science Intern Challenge
The Question are split into two seperate files.

- [ShopifyDSChallenge](#shopifydschallenge)
	- [Question 1](#question-1)
		- [Question A](#question-a)
		- [Question B](#question-b)
		- [Question C](#question-c)
	- [Question 2](#question-2)
		- [Question A](#question-a-1)
			- [Result](#result)
		- [Question B](#question-b-1)
			- [Result](#result-1)
		- [Question C](#question-c-1)
			- [Result](#result-2)

## Question 1

Question 1 regarding the sneakershop is located in the file DS-Challenge-Question1.ipynb.  

### Question A

Think about what could be going wrong with our calculation.

- After looking at the data there are values that could be considered outliers. Due to this the AOV was most likely calculcated using the mean which is subscepible to outliers.  

---
### Question B

What metric would you report for this dataset?

- A better way to evaluate this data would be to take the median of the `order_amount` as it is not as affected by the outliers.

---
### Question C

What is its value?

- The value for the AOV calculated using the median is $284.00.

---
## Question 2

Question 2 regarding the SQL questions is located the the file DS-Challenge-Question2.sql

### Question A

```SQL
-- Query
-- How many orders were shipped by Speedy Express in total?
SELECT COUNT(*) AS Num_Orders FROM Orders JOIN (
    SELECT * FROM Shippers
    WHERE ShipperName = 'Speedy Express') AS SpeedyExpress
ON Orders.ShipperID = SpeedyExpress.ShipperID;
```

#### Result

- Num_Orders: 54
  
Speedy Express shipped 54 orders.

---

### Question B

```SQL
-- What is the last name of the employee with the most orders?
-- Query
SELECT LastName FROM Employees JOIN (
    SELECT EmployeeID, COUNT(*) AS num_orders FROM [Orders]
    GROUP BY EmployeeID
    ORDER BY num_orders DESC
    LIMIT 1) AS TopEmployee
ON Employees.EmployeeID = TopEmployee.EmployeeID;
```

#### Result

- LastName: Peacock
  
The last name of the employee with the most orders is Peacock.

---

### Question C

```SQL
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
```

#### Result

- ProductName: Boston Crab Meat

The most ordered product by customer in Germany was Boston Crab Meat.

---
