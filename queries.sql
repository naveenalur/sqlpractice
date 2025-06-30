-- 1. Basic SELECT queries for each table
-- Get all categories
SELECT * FROM Categories;

-- Get all products with their categories
SELECT p.ProductID, p.ProductName, c.CategoryName, p.UnitPrice, p.UnitsInStock
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID;

-- 2. Sales Analysis Queries
-- Total sales by category
SELECT 
    c.CategoryName,
    COUNT(DISTINCT o.OrderID) as TotalOrders,
    SUM(od.Quantity * od.UnitPrice) as TotalRevenue
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY c.CategoryName
ORDER BY TotalRevenue DESC;

-- 3. Customer Purchase History
-- Get customer order history with details
SELECT 
    c.FirstName + ' ' + c.LastName as CustomerName,
    o.OrderID,
    o.OrderDate,
    p.ProductName,
    od.Quantity,
    od.UnitPrice,
    (od.Quantity * od.UnitPrice) as SubTotal
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
ORDER BY o.OrderDate DESC;

-- 4. Inventory Management
-- Products with low stock (less than 30 units)
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.UnitsInStock,
    s.CompanyName as Supplier
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE p.UnitsInStock < 30
ORDER BY p.UnitsInStock;

-- 5. Top Selling Products
SELECT 
    p.ProductName,
    c.CategoryName,
    SUM(od.Quantity) as TotalQuantitySold,
    SUM(od.Quantity * od.UnitPrice) as TotalRevenue
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName, c.CategoryName
ORDER BY TotalQuantitySold DESC;

-- 6. Customer Spending Analysis
SELECT 
    c.FirstName + ' ' + c.LastName as CustomerName,
    COUNT(DISTINCT o.OrderID) as NumberOfOrders,
    SUM(o.TotalAmount) as TotalSpent,
    AVG(o.TotalAmount) as AverageOrderValue
FROM Customers c
JOIN Orders o ON c.CustomerID = c.CustomerID
GROUP BY c.FirstName, c.LastName
ORDER BY TotalSpent DESC;

-- 7. Monthly Sales Report
SELECT 
    FORMAT(o.OrderDate, 'yyyy-MM') as Month,
    COUNT(DISTINCT o.OrderID) as TotalOrders,
    SUM(o.TotalAmount) as TotalRevenue,
    AVG(o.TotalAmount) as AverageOrderValue
FROM Orders o
GROUP BY FORMAT(o.OrderDate, 'yyyy-MM')
ORDER BY Month;

-- 8. Category Performance
SELECT 
    c.CategoryName,
    COUNT(DISTINCT p.ProductID) as NumberOfProducts,
    SUM(p.UnitsInStock) as TotalStock,
    AVG(p.UnitPrice) as AveragePrice
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName;

-- 9. Supplier Product Analysis
SELECT 
    s.CompanyName,
    COUNT(p.ProductID) as NumberOfProducts,
    AVG(p.UnitPrice) as AverageProductPrice,
    SUM(p.UnitsInStock) as TotalInventory
FROM Suppliers s
JOIN Products p ON s.SupplierID = p.SupplierID
GROUP BY s.CompanyName
ORDER BY NumberOfProducts DESC;

-- 10. Customer Order Frequency
SELECT 
    c.FirstName + ' ' + c.LastName as CustomerName,
    COUNT(o.OrderID) as NumberOfOrders,
    MIN(o.OrderDate) as FirstOrder,
    MAX(o.OrderDate) as LastOrder,
    DATEDIFF(day, MIN(o.OrderDate), MAX(o.OrderDate)) as DaysBetweenFirstAndLastOrder
FROM Customers c
JOIN Orders o ON c.CustomerID = c.CustomerID
GROUP BY c.FirstName, c.LastName
HAVING COUNT(o.OrderID) > 1
ORDER BY NumberOfOrders DESC;

-- 11. Product Price Range Distribution
SELECT 
    CASE 
        WHEN UnitPrice < 20 THEN 'Under $20'
        WHEN UnitPrice >= 20 AND UnitPrice < 50 THEN '$20-$49.99'
        WHEN UnitPrice >= 50 AND UnitPrice < 100 THEN '$50-$99.99'
        ELSE '$100 and above'
    END as PriceRange,
    COUNT(*) as NumberOfProducts,
    AVG(UnitPrice) as AveragePrice
FROM Products
GROUP BY CASE 
    WHEN UnitPrice < 20 THEN 'Under $20'
    WHEN UnitPrice >= 20 AND UnitPrice < 50 THEN '$20-$49.99'
    WHEN UnitPrice >= 50 AND UnitPrice < 100 THEN '$50-$99.99'
    ELSE '$100 and above'
END
ORDER BY 
    CASE PriceRange
        WHEN 'Under $20' THEN 1
        WHEN '$20-$49.99' THEN 2
        WHEN '$50-$99.99' THEN 3
        ELSE 4
    END;

-- 12. Order Details with Customer and Product Info
SELECT 
    o.OrderID,
    o.OrderDate,
    c.FirstName + ' ' + c.LastName as CustomerName,
    STRING_AGG(p.ProductName + ' (x' + CAST(od.Quantity as varchar) + ')', ', ') as OrderItems,
    o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID, o.OrderDate, c.FirstName, c.LastName, o.TotalAmount
ORDER BY o.OrderDate DESC;
