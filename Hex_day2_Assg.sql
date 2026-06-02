use ECOMMERCE_ASSIGNMENT_DB;
--Display all products whose price is greater than the average product price.
select * from Product where Price > (select avg(price) from Product);
--Display all products whose stock quantity is less than the average stock quantity.
select * from Product where StockQuantity < (select avg(StockQuantity) from Product);
--Display all customers who placed at least one order.
SELECT *
FROM Customer
WHERE CustomerId IN
(
    SELECT CustomerId
    FROM Orders
);
SELECT *
FROM Customer
WHERE CustomerId NOT IN
(
    SELECT CustomerId
    FROM Orders
)
--Display all products that are ordered at least once.
SELECT *
FROM Product
WHERE ProductId IN
(
    SELECT ProductId
    FROM OrderItem
);
--Display all products that are not  ordered at least once.
SELECT *
FROM Product
WHERE ProductId NOT IN
(
    SELECT ProductId
    FROM OrderItem
);
--Display all sellers who are selling at least one product.
SELECT *
FROM Seller
WHERE SellerId IN
(
    SELECT SellerId
    FROM Product
);
--Display all sellers who are not selling at least one product.
SELECT *
FROM Seller
WHERE SellerId NOT IN
(
    SELECT SellerId
    FROM Product
);
SELECT *
FROM Orders
WHERE CustomerId IN
(
    SELECT CustomerId
    FROM Customer
    WHERE City = 'Chennai'
);
SELECT *
FROM Orders
WHERE CustomerId IN
(
    SELECT CustomerId
    FROM Customer
    WHERE City = 'Bangalore'
);
--Display customer details for customers who have placed orders.
select * from Customer where CustomerId in 
(select CustomerId from Orders);
--Display customer details for customers who have placed orders.
select * from Customer where CustomerId not in 
(select CustomerId from Orders);
--Display product details for products that are available in the OrderItem table.
SELECT *
FROM Product
WHERE ProductId IN
(
    SELECT ProductId
    FROM OrderItem
);
--Display product details for products that are not  available in the OrderItem table.
SELECT *
FROM Product
WHERE ProductId NOT IN
(
    SELECT ProductId
    FROM OrderItem
);
--Display seller details for sellers who have products in the Product table.
SELECT *
FROM Seller
WHERE SellerId IN
(
    SELECT SellerId
    FROM Product
);
--16. Display seller details for sellers who do not have any products.
SELECT *
FROM Seller
WHERE SellerId NOT IN
(
    SELECT SellerId
    FROM Product
);
--Display orders that contain products from the Mobile category.
SELECT *
FROM Orders
WHERE OrderId IN
(
    SELECT OrderId
    FROM OrderItem
    WHERE ProductId IN
    (
        SELECT ProductId
        FROM Product
        WHERE Category = 'Mobile'
    )
);

SELECT *
FROM Orders
WHERE OrderId NOT IN
(
    SELECT OrderId
    FROM OrderItem
    WHERE ProductId IN
    (
        SELECT ProductId
        FROM Product
        WHERE Category = 'Laptop'
    )
);
SELECT *
FROM Product
WHERE Price =
(
    SELECT MAX(Price)
    FROM Product
);
SELECT *
FROM Product
WHERE Price =
(
    SELECT MIN(Price)
    FROM Product
);

SELECT *
FROM Product
WHERE Price >
(
    SELECT AVG(Price)
    FROM Product
);

SELECT *
FROM Product
WHERE Price <
(
    SELECT AVG(Price)
    FROM Product
);
SELECT *
FROM Customer
WHERE CustomerId IN
(
    SELECT o.CustomerId
    FROM Orders o
    INNER JOIN OrderItem oi
        ON o.OrderId = oi.OrderId
    INNER JOIN Product p
        ON oi.ProductId = p.ProductId
    GROUP BY o.CustomerId
    HAVING SUM(p.Price * oi.Quantity) >
    (
        SELECT AVG(OrderAmount)
        FROM
        (
            SELECT SUM(p.Price * oi.Quantity) AS OrderAmount
            FROM Orders o
            INNER JOIN OrderItem oi
                ON o.OrderId = oi.OrderId
            INNER JOIN Product p
                ON oi.ProductId = p.ProductId
            GROUP BY o.OrderId
        ) A
    )
);
SELECT *
FROM Customer
WHERE CustomerId =
(
    SELECT TOP 1 o.CustomerId
    FROM Orders o
    INNER JOIN OrderItem oi
        ON o.OrderId = oi.OrderId
    INNER JOIN Product p
        ON oi.ProductId = p.ProductId
    GROUP BY o.CustomerId
    ORDER BY SUM(p.Price * oi.Quantity) DESC
);
SELECT *
FROM Seller
WHERE SellerId IN
(
    SELECT p.SellerId
    FROM Product p
    INNER JOIN OrderItem oi
    ON p.ProductId = oi.ProductId
    GROUP BY p.SellerId
    HAVING SUM(p.Price * oi.Quantity) > 50000
);

SELECT *
FROM Product
WHERE ProductId IN
(
    SELECT ProductId
    FROM OrderItem
    GROUP BY ProductId
    HAVING SUM(Quantity) >
    (
        SELECT AVG(TotalQty)
        FROM
        (
            SELECT SUM(Quantity) AS TotalQty
            FROM OrderItem
            GROUP BY ProductId
        ) AS A
    )
);

SELECT *
FROM Product
WHERE ProductId =
(
    SELECT TOP 1 oi.ProductId
    FROM OrderItem oi
    INNER JOIN Product p
    ON oi.ProductId = p.ProductId
    GROUP BY oi.ProductId
    ORDER BY SUM(p.Price * oi.Quantity) DESC
);

SELECT *
FROM Seller
WHERE SellerId =
(
    SELECT TOP 1 p.SellerId
    FROM Product p
    INNER JOIN OrderItem oi
    ON p.ProductId = oi.ProductId
    GROUP BY p.SellerId
    ORDER BY SUM(p.Price * oi.Quantity) DESC
);
select * from Orders;
-- correlated subqueries
SELECT *
FROM Product p1
WHERE Price >
(
    SELECT AVG(Price)
    FROM Product p2
    WHERE p2.Category = p1.Category
);
SELECT *
FROM Product p1
WHERE Price <
(
    SELECT AVG(Price)
    FROM Product p2
    WHERE p2.Category = p1.Category
);

SELECT *
FROM Seller s
WHERE
(
    SELECT COUNT(*)
    FROM Product p
    WHERE p.SellerId = s.SellerId
) > 2;

SELECT *
FROM Customer c
WHERE
(
    SELECT COUNT(*)
    FROM Orders o
    WHERE o.CustomerId = c.CustomerId
) > 1;

SELECT *
FROM Product p1
WHERE StockQuantity >
(
    SELECT AVG(StockQuantity)
    FROM Product p2
    WHERE p2.Category = p1.Category
);

SELECT *
FROM Customer c
WHERE EXISTS
(
    SELECT *
    FROM Orders o
    WHERE o.CustomerId = c.CustomerId
);
SELECT *
FROM Customer c
WHERE NOT EXISTS
(
    SELECT *
    FROM Orders o
    WHERE o.CustomerId = c.CustomerId
);
SELECT *
FROM Product p
WHERE EXISTS
(
    SELECT *
    FROM OrderItem oi
    WHERE oi.ProductId = p.ProductId
);
SELECT *
FROM Product p
WHERE NOT EXISTS
(
    SELECT *
    FROM OrderItem oi
    WHERE oi.ProductId = p.ProductId
);
--stored Procedure 
CREATE PROCEDURE sp_GetAllCustomers
AS
BEGIN
    SELECT *
    FROM Customer;
END;
EXEC sp_GetAllCustomers;


CREATE PROCEDURE sp_GetAllProducts
AS
BEGIN
    SELECT *
    FROM Product;
END;

CREATE PROCEDURE sp_GetAllSellers
AS
BEGIN
    SELECT *
    FROM Seller;
END;

CREATE PROCEDURE sp_GetAllOrders
AS
BEGIN
    SELECT *
    FROM Orders;
END;

CREATE PROCEDURE sp_GetAllOrderItems
AS
BEGIN
    SELECT *
    FROM OrderItem;
END;

--with parameters
CREATE PROCEDURE sp_GetCustomerById
    @CustomerId INT
AS
BEGIN
    SELECT *
    FROM Customer
    WHERE CustomerId = @CustomerId;
END;

CREATE PROCEDURE sp_GetProductById
    @ProductId INT
AS
BEGIN
    SELECT *
    FROM Product
    WHERE ProductId = @ProductId;
END;

CREATE PROCEDURE sp_GetSellerById
    @SellerId INT
AS
BEGIN
    SELECT *
    FROM Seller
    WHERE SellerId = @SellerId;
END;

CREATE PROCEDURE sp_GetOrderById
    @OrderId INT
AS
BEGIN
    SELECT *
    FROM Orders
    WHERE OrderId = @OrderId;
END;

CREATE PROCEDURE sp_GetCustomersByCity
    @City VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Customer
    WHERE City = @City;
END;
CREATE PROCEDURE sp_InsertCustomer
    @CustomerName VARCHAR(100),
    @Email VARCHAR(100),
    @MobileNo VARCHAR(15),
    @City VARCHAR(50)
AS
BEGIN
    INSERT INTO Customer
    (
        CustomerName,
        Email,
        MobileNo,
        City
    )
    VALUES
    (
        @CustomerName,
        @Email,
        @MobileNo,
        @City
    );
END;
EXEC sp_InsertCustomer
'Saima',
'saima@gmail.com',
'9876543210',
'Chennai';

CREATE PROCEDURE sp_InsertSeller
    @SellerName VARCHAR(100),
    @Email VARCHAR(100),
    @MobileNo VARCHAR(15),
    @City VARCHAR(50)
AS
BEGIN
    INSERT INTO Seller
    (
        SellerName,
        Email,
        MobileNo,
        City
    )
    VALUES
    (
        @SellerName,
        @Email,
        @MobileNo,
        @City
    );
END;

EXEC sp_InsertSeller
'ABC Stores',
'abc@gmail.com',
'9876543211',
'Bangalore';

--update
CREATE PROCEDURE sp_UpdateCustomerCity
    @CustomerId INT,
    @City VARCHAR(50)
AS
BEGIN
    UPDATE Customer
    SET City = @City
    WHERE CustomerId = @CustomerId;
END;

EXEC sp_UpdateCustomerCity
1,
'Hyderabad';

CREATE PROCEDURE sp_UpdateCustomerMobile
    @CustomerId INT,
    @MobileNo VARCHAR(15)
AS
BEGIN
    UPDATE Customer
    SET MobileNo = @MobileNo
    WHERE CustomerId = @CustomerId;
END;

EXEC sp_UpdateCustomerMobile
1,
'9999999999';