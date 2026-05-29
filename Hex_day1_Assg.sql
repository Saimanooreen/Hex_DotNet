CREATE DATABASE ECOMMERCE_ASSIGNMENT_DB;
GO

USE ECOMMERCE_ASSIGNMENT_DB;
GO

CREATE TABLE Customer
(
    CustomerId INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    MobileNo BIGINT NOT NULL,
    City VARCHAR(50) NOT NULL,
    Address VARCHAR(200),
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE Seller
(
    SellerId INT PRIMARY KEY IDENTITY(1,1),
    SellerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    MobileNo BIGINT NOT NULL,
    City VARCHAR(50),
    Rating DECIMAL(3,2),
    IsActive BIT DEFAULT 1
);

CREATE TABLE Product
(
    ProductId INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price MONEY CHECK(Price > 0),
    StockQuantity INT CHECK(StockQuantity >= 0),
    SellerId INT,
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY(SellerId) REFERENCES Seller(SellerId)
);

CREATE TABLE Orders
(
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    CustomerId INT,
    OrderDate DATETIME DEFAULT GETDATE(),
    OrderStatus VARCHAR(50) DEFAULT 'Pending',
    PaymentMode VARCHAR(50),
    DeliveryCity VARCHAR(50),
    FOREIGN KEY(CustomerId) REFERENCES Customer(CustomerId)
);

CREATE TABLE OrderItem
(
    OrderItemId INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT,
    ProductId INT,
    Quantity INT CHECK(Quantity > 0),
    UnitPrice MONEY,
    FOREIGN KEY(OrderId) REFERENCES Orders(OrderId),
    FOREIGN KEY(ProductId) REFERENCES Product(ProductId)
);
INSERT INTO Customer(CustomerName,Email,MobileNo,City,Address)
VALUES
('Arun','arun@gmail.com',9876543210,'Chennai','Anna Nagar'),
('Bala','bala@gmail.com',9876543211,'Bangalore','MG Road'),
('Charan','charan@gmail.com',9876543212,'Hyderabad','Ameerpet'),
('Divya','divya@gmail.com',9876543213,'Chennai','Velachery'),
('Esha','esha@gmail.com',9876543214,'Mumbai','Andheri');

INSERT INTO Seller(SellerName,Email,MobileNo,City,Rating)
VALUES
('TechWorld','tech@gmail.com',9991111111,'Chennai',4.5),
('MobileHub','mobile@gmail.com',9992222222,'Bangalore',4.2),
('LaptopStore','laptop@gmail.com',9993333333,'Hyderabad',4.8),
('ElectroMart','electro@gmail.com',9994444444,'Mumbai',4.4);
INSERT INTO Product(ProductName,Category,Price,StockQuantity,SellerId)
VALUES
('iPhone 15','Mobile',75000,20,2),
('Samsung S24','Mobile',65000,15,2),
('Dell Inspiron','Laptop',55000,10,3),
('HP Pavilion','Laptop',60000,12,3),
('Boat Headphone','Accessory',2500,50,1),
('Sony Speaker','Accessory',7000,30,1),
('MacBook Air','Laptop',95000,5,3),
('OnePlus Phone','Mobile',45000,18,2);
INSERT INTO Orders(CustomerId,PaymentMode,DeliveryCity)
VALUES
(1,'UPI','Chennai'),
(2,'Card','Bangalore'),
(3,'Cash','Hyderabad'),
(4,'UPI','Chennai'),
(5,'Card','Mumbai');
INSERT INTO OrderItem(OrderId,ProductId,Quantity,UnitPrice)
VALUES
(1,1,1,75000),
(1,5,2,2500),
(2,3,1,55000),
(2,6,1,7000),
(3,2,1,65000),
(3,5,1,2500),
(4,4,1,60000),
(4,8,1,45000),
(5,7,1,95000),
(5,6,2,7000);
UPDATE Customer
SET City='Coimbatore'
WHERE CustomerId=1;

UPDATE Product
SET Price=80000
WHERE ProductId=1;

UPDATE Orders
SET OrderStatus='Delivered'
WHERE OrderId=1;

INSERT INTO Product(ProductName,Category,Price,StockQuantity,SellerId)
VALUES
('Test Product','Accessory',1000,5,1);

DELETE FROM Product
WHERE ProductName='Test Product';

SELECT * FROM Customer;
SELECT * FROM Seller;
SELECT * FROM Product;
SELECT * FROM Orders;
SELECT * FROM OrderItem;

-- 1. Display all customers from Chennai
SELECT * FROM Customer
WHERE City='Chennai';

-- 2. Display all customers not from Chennai
SELECT * FROM Customer
WHERE City<>'Chennai';

-- 3. Display all products with price greater than 50000
SELECT * FROM Product
WHERE Price > 50000;

-- 4. Display all products with price between 10000 and 60000
SELECT * FROM Product
WHERE Price BETWEEN 10000 AND 60000;

-- 5. Display all products from category Mobile or Laptop
SELECT * FROM Product
WHERE Category IN ('Mobile','Laptop');

-- 6. Display all customers whose name starts with A
SELECT * FROM Customer
WHERE CustomerName LIKE 'A%';

-- 7. Display all customers whose email contains gmail
SELECT * FROM Customer
WHERE Email LIKE '%gmail%';

-- 8. Display all products whose product name contains Phone
SELECT * FROM Product
WHERE ProductName LIKE '%Phone%';

-- 9. Display all orders with status Delivered
SELECT * FROM Orders
WHERE OrderStatus='Delivered';

-- 10. Display all products where stock quantity is less than 10
SELECT * FROM Product
WHERE StockQuantity < 10;

-- 11. Display all customers where mobile number is not null
SELECT * FROM Customer
WHERE MobileNo IS NOT NULL;

-- 12. Display all products where price is not between 10000 and 50000
SELECT * FROM Product
WHERE Price NOT BETWEEN 10000 AND 50000;

-- 13. Display all customers from Chennai or Bangalore
SELECT * FROM Customer
WHERE City IN ('Chennai','Bangalore');

-- 14. Display all customers from Chennai and active status
SELECT * FROM Customer
WHERE City='Chennai'
AND IsActive=1;

-- 15. Display all customers except those from Hyderabad
SELECT * FROM Customer
WHERE City<>'Hyderabad';

-- 1. Count total customers city-wise
SELECT City, COUNT(*) AS TotalCustomers
FROM Customer
GROUP BY City;

-- 2. Count total products category-wise
SELECT Category, COUNT(*) AS TotalProducts
FROM Product
GROUP BY Category;

-- 3. Find total stock quantity category-wise
SELECT Category, SUM(StockQuantity) AS TotalStock
FROM Product
GROUP BY Category;

-- 4. Find maximum product price category-wise
SELECT Category, MAX(Price) AS MaxPrice
FROM Product
GROUP BY Category;

-- 5. Find minimum product price category-wise
SELECT Category, MIN(Price) AS MinPrice
FROM Product
GROUP BY Category;

-- 6. Find average product price category-wise
SELECT Category, AVG(Price) AS AvgPrice
FROM Product
GROUP BY Category;

-- 7. Find total order amount customer-wise
SELECT
C.CustomerName,
SUM(OI.Quantity * OI.UnitPrice) AS TotalAmount
FROM Customer C
JOIN Orders O ON C.CustomerId=O.CustomerId
JOIN OrderItem OI ON O.OrderId=OI.OrderId
GROUP BY C.CustomerName;

-- 8. Find total sales product-wise
SELECT
P.ProductName,
SUM(OI.Quantity * OI.UnitPrice) AS TotalSales
FROM Product P
JOIN OrderItem OI ON P.ProductId=OI.ProductId
GROUP BY P.ProductName;

-- 9. Find total quantity sold product-wise
SELECT
P.ProductName,
SUM(OI.Quantity) AS TotalQuantity
FROM Product P
JOIN OrderItem OI ON P.ProductId=OI.ProductId
GROUP BY P.ProductName;

-- 10. Display only categories having more than 1 product
SELECT Category, COUNT(*) AS ProductCount
FROM Product
GROUP BY Category
HAVING COUNT(*) > 1;

-- 11. Display only customers whose total order amount is greater than 50000
SELECT
C.CustomerName,
SUM(OI.Quantity * OI.UnitPrice) AS TotalAmount
FROM Customer C
JOIN Orders O ON C.CustomerId=O.CustomerId
JOIN OrderItem OI ON O.OrderId=OI.OrderId
GROUP BY C.CustomerName
HAVING SUM(OI.Quantity * OI.UnitPrice) > 50000;

-- 12. Find seller-wise total number of products
SELECT
S.SellerName,
COUNT(P.ProductId) AS TotalProducts
FROM Seller S
LEFT JOIN Product P
ON S.SellerId=P.SellerId
GROUP BY S.SellerName;

-- 13. Find seller-wise total sales amount
SELECT
S.SellerName,
SUM(OI.Quantity * OI.UnitPrice) AS TotalSales
FROM Seller S
JOIN Product P ON S.SellerId=P.SellerId
JOIN OrderItem OI ON P.ProductId=OI.ProductId
GROUP BY S.SellerName;

-- 14. Find order status-wise order count
SELECT
OrderStatus,
COUNT(*) AS OrderCount
FROM Orders
GROUP BY OrderStatus;

-- 15. Find city-wise customer count and sort by highest count
SELECT
City,
COUNT(*) AS CustomerCount
FROM Customer
GROUP BY City
ORDER BY CustomerCount DESC;

-- 1
SELECT * FROM Product
ORDER BY Price ASC;

-- 2
SELECT * FROM Product
ORDER BY Price DESC;

-- 3
SELECT * FROM Customer
ORDER BY City ASC, CustomerName ASC;

-- 4
SELECT * FROM Orders
ORDER BY OrderDate DESC;

-- 5
SELECT * FROM Product
ORDER BY Category ASC, Price DESC;

-- 6
SELECT TOP 3 *
FROM Product
ORDER BY Price DESC;

-- 7
SELECT TOP 5 *
FROM Orders
ORDER BY OrderDate DESC;

-- 8
SELECT *
FROM Customer
ORDER BY IsActive DESC, CustomerName ASC;

SELECT
O.OrderId,
O.OrderDate,
O.OrderStatus,
C.CustomerName,
C.City
FROM Orders O
INNER JOIN Customer C
ON O.CustomerId = C.CustomerId;

SELECT
P.ProductName,
P.Category,
P.Price,
S.SellerName,
S.City
FROM Product P
INNER JOIN Seller S
ON P.SellerId = S.SellerId;

SELECT
OI.OrderItemId,
P.ProductName,
OI.Quantity,
OI.UnitPrice
FROM OrderItem OI
INNER JOIN Product P
ON OI.ProductId = P.ProductId;

SELECT
C.CustomerName,
O.OrderId,
O.OrderDate,
P.ProductName,
OI.Quantity,
OI.UnitPrice,
S.SellerName
FROM Customer C
INNER JOIN Orders O
ON C.CustomerId = O.CustomerId
INNER JOIN OrderItem OI
ON O.OrderId = OI.OrderId
INNER JOIN Product P
ON OI.ProductId = P.ProductId
INNER JOIN Seller S
ON P.SellerId = S.SellerId;

SELECT
C.CustomerName,
O.OrderId,
O.OrderStatus
FROM Customer C
LEFT JOIN Orders O
ON C.CustomerId = O.CustomerId;

SELECT
C.CustomerName,
O.OrderId,
O.OrderStatus
FROM Customer C
RIGHT JOIN Orders O
ON C.CustomerId = O.CustomerId;

SELECT
C.CustomerName,
O.OrderId,
O.OrderStatus
FROM Customer C
FULL OUTER JOIN Orders O
ON C.CustomerId = O.CustomerId;

SELECT
C.CustomerName,
P.ProductName
FROM Customer C
CROSS JOIN Product P;

SELECT
C.CustomerId,
C.CustomerName
FROM Customer C
LEFT JOIN Orders O
ON C.CustomerId = O.CustomerId
WHERE O.OrderId IS NULL;

SELECT
P.ProductId,
P.ProductName
FROM Product P
LEFT JOIN OrderItem OI
ON P.ProductId = OI.ProductId
WHERE OI.ProductId IS NULL;

SELECT
S.SellerName,
P.ProductName
FROM Seller S
INNER JOIN Product P
ON S.SellerId = P.SellerId
ORDER BY S.SellerName;

SELECT
C.CustomerName,
P.ProductName
FROM Customer C
INNER JOIN Orders O
ON C.CustomerId = O.CustomerId
INNER JOIN OrderItem OI
ON O.OrderId = OI.OrderId
INNER JOIN Product P
ON OI.ProductId = P.ProductId;

SELECT
O.OrderId,
SUM(OI.Quantity * OI.UnitPrice) AS TotalAmount
FROM Orders O
INNER JOIN OrderItem OI
ON O.OrderId = OI.OrderId
GROUP BY O.OrderId;

SELECT
S.SellerName,
SUM(OI.Quantity * OI.UnitPrice) AS TotalSales
FROM Seller S
INNER JOIN Product P
ON S.SellerId = P.SellerId
INNER JOIN OrderItem OI
ON P.ProductId = OI.ProductId
GROUP BY S.SellerName;

SELECT
P.ProductName,
SUM(OI.Quantity) AS TotalQuantitySold
FROM Product P
INNER JOIN OrderItem OI
ON P.ProductId = OI.ProductId
GROUP BY P.ProductName;