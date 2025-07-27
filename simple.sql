CREATE DATABASE shop;
GO

USE shop;
GO

-- Create Categories table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(200)
);

-- Create Suppliers table
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    CompanyName NVARCHAR(100) NOT NULL,
    ContactName NVARCHAR(100),
    Phone NVARCHAR(20),
    Email NVARCHAR(100)
);

-- Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    UnitPrice DECIMAL(10,2) NOT NULL,
    UnitsInStock INT DEFAULT 0,
    CONSTRAINT CHK_UnitPrice CHECK (UnitPrice >= 0)
);

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE,
    Phone NVARCHAR(20),
    extension varchar (3),
    Address NVARCHAR(200)
);

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2) DEFAULT 0
);

-- Create OrderDetails table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    CONSTRAINT CHK_Quantity CHECK (Quantity > 0)
);

-- Insert sample data into Categories
INSERT INTO Categories (CategoryName, Description) VALUES
('Electronics', 'Electronic devices and accessories'),
('Clothing', 'Apparel and fashion items'),
('Books', 'Books and publications'),
('Home & Garden', 'Home improvement and garden supplies'),
('Sports', 'Sporting goods and equipment'),
('Toys', 'Toys and games');

-- Insert sample data into Suppliers
INSERT INTO Suppliers (CompanyName, ContactName, Phone, Email) VALUES
('Tech Solutions Inc', 'John Smith', '555-0101', 'john@techsolutions.com'),
('Fashion Forward', 'Emma Johnson', '555-0102', 'emma@fashionforward.com'),
('Book World', 'Michael Brown', '555-0103', 'michael@bookworld.com'),
('Garden Plus', 'Sarah Davis', '555-0104', 'sarah@gardenplus.com'),
('Sports Elite', 'David Wilson', '555-0105', 'david@sportselite.com'),
('Toy Universe', 'Lisa Anderson', '555-0106', 'lisa@toyuniverse.com');

-- Insert sample data into Products
INSERT INTO Products (ProductName, CategoryID, SupplierID, UnitPrice, UnitsInStock) VALUES
('Smartphone', 1, 1, 599.99, 50),
('Laptop', 1, 1, 999.99, 30),
('T-Shirt', 2, 2, 19.99, 100),
('Jeans', 2, 2, 49.99, 75),
('Novel Book', 3, 3, 14.99, 200),
('Gardening Tools Set', 4, 4, 79.99, 40),
('Basketball', 5, 5, 29.99, 60),
('Soccer Ball', 5, 5, 24.99, 55),
('Board Game', 6, 6, 34.99, 45),
('Action Figure', 6, 6, 19.99, 80),
('Tablet', 1, 1, 299.99, 35),
('Dress', 2, 2, 79.99, 60),
('Cookbook', 3, 3, 24.99, 90),
('Plant Pots', 4, 4, 9.99, 150),
('Tennis Racket', 5, 5, 89.99, 25),
('Puzzle Set', 6, 6, 14.99, 70);

-- Insert sample data into Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) VALUES
('Alice', 'Johnson', 'alice@email.com', '555-1001', '123 Main St'),
('Bob', 'Smith', 'bob@email.com', '555-1002', '456 Oak Ave'),
('Carol', 'Williams', 'carol@email.com', '555-1003', '789 Pine Rd'),
('David', 'Brown', 'david@email.com', '555-1004', '321 Elm St'),
('Eve', 'Davis', 'eve@email.com', '555-1005', '654 Maple Dr'),
('Frank', 'Miller', 'frank@email.com', '555-1006', '987 Cedar Ln'),
('Grace', 'Wilson', 'grace@email.com', '555-1007', '147 Birch Rd'),
('Henry', 'Moore', 'henry@email.com', '555-1008', '258 Spruce Ave'),
('Ivy', 'Taylor', 'ivy@email.com', '555-1009', '369 Pine St'),
('Jack', 'Anderson', 'jack@email.com', '555-1010', '741 Oak Rd'),
('Kelly', 'Thomas', 'kelly@email.com', '555-1011', '852 Maple St'),
('Leo', 'Jackson', 'leo@email.com', '555-1012', '963 Elm Ave'),
('Mary', 'White', 'mary@email.com', '555-1013', '159 Cedar Dr'),
('Nick', 'Harris', 'nick@email.com', '555-1014', '357 Birch St'),
('Olivia', 'Martin', 'olivia@email.com', '555-1015', '486 Spruce Ln');

-- Insert sample data into Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2025-06-01', 699.99),
(2, '2025-06-02', 149.97),
(3, '2025-06-03', 1299.98),
(4, '2025-06-04', 89.99),
(5, '2025-06-05', 244.95),
(6, '2025-06-06', 129.97),
(7, '2025-06-07', 899.98),
(8, '2025-06-08', 159.96),
(9, '2025-06-09', 449.97),
(10, '2025-06-10', 74.97),
(11, '2025-06-11', 399.98),
(12, '2025-06-12', 189.96),
(13, '2025-06-13', 549.97),
(14, '2025-06-14', 99.96),
(15, '2025-06-15', 299.98);

-- Insert sample data into OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 1, 599.99),
(1, 3, 5, 19.99),
(2, 4, 3, 49.99),
(3, 2, 1, 999.99),
(3, 5, 20, 14.99),
(4, 6, 1, 79.99),
(5, 7, 5, 29.99),
(5, 8, 5, 24.99),
(6, 9, 2, 34.99),
(6, 10, 3, 19.99),
(7, 11, 3, 299.99),
(8, 12, 2, 79.99),
(9, 13, 15, 24.99),
(10, 14, 5, 9.99),
(11, 15, 3, 89.99),
(12, 16, 10, 14.99),
(13, 1, 1, 599.99),
(14, 3, 5, 19.99),
(15, 4, 6, 49.99);
GO
