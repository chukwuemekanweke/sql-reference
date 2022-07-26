USE BobsShoes
GO

DROP TABLE IF EXISTS Orders.Customers, Orders.Stock, Orders.Orders, Orders.OrderItems

CREATE TABLE Orders.Customers(

    CustID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Customers_CustID PRIMARY KEY,
    CustName NVARCHAR(200) NOT NULL,
    CustStreet NVARCHAR(100) NOT NULL,
    CustCity NVARCHAR(100) NOT NULL,
    CustStaeProv NVARCHAR(100) NOT NULL,
    CustCountry NVARCHAR(100) NOT NULL,
    CustPostalCode NVARCHAR(20) NOT NULL,
    CustSalutation CHAR(5) NOT NULL,
);

CREATE TABLE Orders.Stock(
    StockSKU CHAR(8) NOT NULL,
    StockSize VARCHAR(10) NOT NULL,
    StockName VARCHAR(100) NOT NULL,
    StockPrice NUMERIC(7,2) NOT NULL,
    CONSTRAINT Pk_Stock_StockSKU_StockSize PRIMARY KEY (StockSKU, StockSize)
);

CREATE TABLE Orders.Orders(
    OrderID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_Orders_OrderID PRIMARY KEY,
    OrderDate DATE NOT NULL,
    OrderRequestedDate DATE NOT NULL,
    OrderDeliveryDate DATETIME2(0) NULL,
    CustID INT NOT NULL,
    OrderIsExpedited BIT NOT NULL
);


CREATE TABLE Orders.OrderItems(
   OrderItemID int IDENTITY(1,1) NOT NULL CONSTRAINT PK_OrderItems_OrderItemID PRIMARY KEY,
   OrderID int NOT NULL,
   StockSKU CHAR(8) NOT NULL,
   Quantity SMALLINT NOT NULL,
   Discount NUMERIC(4,2) NOT NULL
);
RETURN;




-- CREATE TABLE Orders.OrderTracking(

--     OrderId int IDENTITY(1,1) NOT NULL, --(1,1) - (SEED VALUE, INCREMENT VALUE)
--     OrderDate DATETIME2(0) NOT NULL,
--     RequestedDate DATETIME2(0) NOT NULL,
--     DeliveryDate DATETIME2(0) NULL,
--     CustName NVARCHAR(200) NOT NULL,
--     CustAddress NVARCHAR(200) NOT NULL,
--     ShoeStyle VARCHAR(200) NOT NULL,
--     ShoeSize VARCHAR(10) NOT NULL,
--     SKU CHAR(8) NOT NULL,
--     UnitPrice numeric(7,2) NOT NULL,
--     Quantity SMALLINT NOT NULL,
--     Discount NUMERIC(4,2) NOT NULL,
--     IsExpedited bit NOT NULL,
--     TotalPrice AS (Quantity * UnitPrice * (1.0-Discount)), --PERSISTED 
-- )
-- On BobsData
-- WITH (DATA_COMPRESSION = PAGE)
-- Go

-- ALTER TABLE Orders.OrderTracking
-- ADD CONSTRAINT PK_OrderTracking_OrderId
--     PRIMARY KEY (OrderId)
--         ON [BobsData]
-- GO