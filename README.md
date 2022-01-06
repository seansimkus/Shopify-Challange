
# ShopifyDSChallenge

Author: Sean Simkus

Date: Jan 05, 2022

This is my submission for Winter 2022 Data Science Intern Challenge
The Question are split into two seperate files.

- [Question 1](#question-1)
  - [A) Think about what could be going wrong with our calculation](#a-think-about-what-could-be-going-wrong-with-our-calculation)
  - [B) What metric would you report for this dataset?](#b-what-metric-would-you-report-for-this-dataset)
  - [C) What is its value?](#c-what-is-its-value)
- [Question 2](#question-2)
  - [A) How many orders were shipped by Speedy Express in total?](#a-how-many-orders-were-shipped-by-speedy-express-in-total)
  - [B) What is the last name of the employee with the most orders?](#b-what-is-the-last-name-of-the-employee-with-the-most-orders)
  - [C) What product was ordered the most by customers in Germany?](#c-what-product-was-ordered-the-most-by-customers-in-germany)

## Question 1

Code for Question 1 regarding the sneakershop is located in the file DS-Challenge-Question1.ipynb.  

### A) Think about what could be going wrong with our calculation

Due to the average order value (AOV) being so high it is most likely that our data is being affected by outliers assuming that the calcualtions were done correctly. The AOV being so high is a strong indicator that the calculation was done using the mean which is heavily influenced by outliers.

```python
mean_order = store_df['order_amount'].mean()
mean_items = store_df['total_items'].mean()
print(f'The median average of the order is ${mean_order} with an average of {mean_items} items sold')


""" 
returns:
The mean average of the order is $3145.128 with a mean of 8.7872 items sold
"""

```

- After performing some calculations on our data we can see that the mean of the `order_amount` is the same as the reported unresonably high AOV.

---

### B) What metric would you report for this dataset?

- As mention previously a weakness of using a mean calculation is it can be strongly infulenced by outliers. A better way to evaluate this data would be to take the median of the `order_amount` as it is not as affected nearly as much by the outliers.

---

### C) What is its value?

```python
median_order = store_df['order_amount'].median()
median_items = store_df['total_items'].median()
print(f'The median average of the order is ${median_order} with a median of {median_items} items sold')

"""
returns:
The median average of the order is $284.0 with an average of 2.0 items sold
"""
```

- The value for the AOV calculated using the median is $284.00.

---

## Question 2

### A) How many orders were shipped by Speedy Express in total?

```SQL
-- Query
-- How many orders were shipped by Speedy Express in total?
SELECT COUNT(*) AS Num_Orders FROM Orders JOIN (
    SELECT * FROM Shippers
    WHERE ShipperName = 'Speedy Express') AS SpeedyExpress
ON Orders.ShipperID = SpeedyExpress.ShipperID;

/*
Returns:
Num_Orders: 54
*/
```

Speedy Express shipped 54 orders.

---

### B) What is the last name of the employee with the most orders?

```SQL
-- What is the last name of the employee with the most orders?
-- Query
SELECT LastName FROM Employees JOIN (
    SELECT EmployeeID, COUNT(*) AS num_orders FROM [Orders]
    GROUP BY EmployeeID
    ORDER BY num_orders DESC
    LIMIT 1) AS TopEmployee
ON Employees.EmployeeID = TopEmployee.EmployeeID;

/*
Returns:
LastName: Peacock
*/
```

The last name of the employee with the most orders is Peacock.

---

### C) What product was ordered the most by customers in Germany?

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

/*
Returns:
ProductName: Boston Crab Meat
*/
```

The most ordered product by customers in Germany was Boston Crab Meat.

---
