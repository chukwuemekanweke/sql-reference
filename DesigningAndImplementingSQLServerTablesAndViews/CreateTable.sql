USE BobsShoes
GO

CREATE TABLE Orders.OrderTracking(

    OrderId int IDENTITY(1,1) NOT NULL, --(1,1) - (SEED VALUE, INCREMENT VALUE)
    OrderDate DATETIME2(0) NOT NULL,
    RequestedDate DATETIME2(0) NOT NULL,
    DeliveryDate DATETIME2(0) NULL,
    CustName NVARCHAR(200) NOT NULL,
    CustAddress NVARCHAR(200) NOT NULL,
    ShoeStyle VARCHAR(200) NOT NULL,
    ShoeSize VARCHAR(10) NOT NULL,
    SKU CHAR(8) NOT NULL,
    UnitPrice numeric(7,2) NOT NULL,
    Quantity SMALLINT NOT NULL,
    Discount NUMERIC(4,2) NOT NULL,
    IsExpedited bit NOT NULL,
    TotalPrice AS (Quantity * UnitPrice * (1.0-Discount)), --PERSISTED
)
On BobsData
WITH (DATA_COMPRESSION = PAGE)
Go