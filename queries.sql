-- 1. List all customers
SELECT * 
FROM Customers;

-- 2. Find all orders placed in January 2023
SELECT * 
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-01-31';

-- For full details
SELECT 
    c.FirstName, 
    c.Email, 
    o.OrderDate 
FROM 
    Orders AS o 
JOIN 
    Customers AS c 
ON 
    c.CustomerID = o.CustomerID 
WHERE 
    o.OrderDate BETWEEN '2023-01-01' AND '2023-01-31';

-- 3. Get the details of each order, including the customer name and email
SELECT 
    o.OrderID,
    o.OrderDate,
    c.FirstName,
    c.LastName,
    c.Email
FROM  
    Orders AS o
JOIN   
    Customers AS c 
ON 
    o.CustomerID = c.CustomerID;

-- 4. List the products purchased in a specific order (e.g., OrderID = 1)
SELECT 
    p.ProductName,
    oi.Quantity
FROM 
    OrderItems AS oi
JOIN 
    Products AS p 
ON 
    oi.ProductID = p.ProductID
WHERE 
    oi.OrderID = 1;

-- 5. Calculate the total amount spent by each customer
SELECT 
    c.CustomerID, 
    c.FirstName,
    c.LastName,
    SUM(p.Price * oi.Quantity) AS TotalSpent
FROM   
    Customers AS c
JOIN 
    Orders AS o 
ON 
    c.CustomerID = o.CustomerID
JOIN 
    OrderItems AS oi 
ON 
    o.OrderID = oi.OrderID
JOIN 
    Products AS p 
ON 
    oi.ProductID = p.ProductID
GROUP BY 
    c.CustomerID,
    c.FirstName,
    c.LastName;

-- 6. Find the most popular product (the one that has been ordered the most)
SELECT 
    p.ProductID,
    p.ProductName,
    SUM(oi.Quantity) AS TotalQuantitySold
FROM 
    Products AS p
JOIN 
    OrderItems AS oi 
ON 
    p.ProductID = oi.ProductID
GROUP BY 
    p.ProductID,
    p.ProductName
ORDER BY 
    TotalQuantitySold DESC
LIMIT 1;

-- 7. Get the total number of orders and the total sales amount for each month in 2023
SELECT 
    DATE_FORMAT(o.OrderDate, '%Y-%m') AS Month,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(p.Price * oi.Quantity) AS TotalSalesAmount
FROM 
    Orders AS o
JOIN 
    OrderItems AS oi 
ON 
    o.OrderID = oi.OrderID
JOIN 
    Products AS p 
ON 
    oi.ProductID = p.ProductID
WHERE 
    YEAR(o.OrderDate) = 2023
GROUP BY 
    DATE_FORMAT(o.OrderDate, '%Y-%m');

-- 8. Find customers who have spent more than $1000
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    SUM(p.Price * oi.Quantity) AS TotalSpent
FROM 
    Customers AS c
JOIN 
    Orders AS o 
ON 
    c.CustomerID = o.CustomerID
JOIN 
    OrderItems AS oi 
ON 
    o.OrderID = oi.OrderID
JOIN 
    Products AS p 
ON 
    oi.ProductID = p.ProductID
GROUP BY 
    c.CustomerID,
    c.FirstName,
    c.LastName
HAVING 
    TotalSpent > 1000;
