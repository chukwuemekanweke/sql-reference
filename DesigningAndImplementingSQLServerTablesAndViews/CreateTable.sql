USE BobsShoes
GO

DROP TABLE IF EXISTS Customers, Stock, Orders, OrderItems, Salutations

CREATE TABLE Salutations(
    SalutationID INT IDENTITY(1,1) NOT NULL 
        CONSTRAINT PK_Salutations_SalutationID 
            PRIMARY KEY CLUSTERED,
    Salutation VARCHAR(5) NOT NULL
        CONSTRAINT UQ_Salutations_Salutation
            UNIQUE NONCLUSTERED
        CONSTRAINT CK_Salutations_Salutation_must_not_be_empty CHECK (Salutation <> ''),
);

CREATE TABLE Customers(
    CustID INT IDENTITY(1,1) NOT NULL 
        CONSTRAINT PK_Customers_CustID PRIMARY KEY CLUSTERED, 
    CustName NVARCHAR(200) NOT NULL,
    CustStreet NVARCHAR(100) NOT NULL,
    CustCity NVARCHAR(100) NOT NULL,
    CustStaeProv NVARCHAR(100) NOT NULL,
    CustCountry NVARCHAR(100) NOT NULL,
    CustPostalCode NVARCHAR(20) NOT NULL,
    CustSalutation CHAR(5) NOT NULL,
    SalutationID INT NOT NULL
        CONSTRAINT FK_Customers_SalutationID_Salutations_SalutationID
            FOREIGN KEY REFERENCES Salutations (SalutationID), 
);

CREATE TABLE Stock(
    StockID INT IDENTITY(1,1) NOT NULL 
        CONSTRAINT PK_Stock_StockID PRIMARY KEY CLUSTERED,
    StockSKU CHAR(8) NOT NULL,
    StockSize VARCHAR(10) NOT NULL,
    StockName VARCHAR(100) NOT NULL,
    StockPrice NUMERIC(7,2) NOT NULL,
        CONSTRAINT UQ_Stock_StockSKU_StockSize
            UNIQUE NONCLUSTERED (StockSKU, StockSize),
        CONSTRAINT CK_Stock_SKU_cannot_equal_description CHECK (StockSKU <> StockName)
    -- CONSTRAINT Pk_Stock_StockSKU_StockSize PRIMARY KEY (StockSKU, StockSize)
);

CREATE TABLE Orders(
    OrderID INT IDENTITY(1,1) NOT NULL 
        CONSTRAINT PK_Orders_OrderID PRIMARY KEY CLUSTERED,
    OrderDate DATE NOT NULL ,
    OrderRequestedDate DATE NOT NULL,
    OrderDeliveryDate DATETIME2(0) NULL,
    CustID INT NOT NULL
        CONSTRAINT FK_Orders_CustID_Customers_CustID
            FOREIGN KEY REFERENCES Customers (CustID),
    OrderIsExpedited BIT NOT NULL
);


CREATE TABLE OrderItems(
   OrderItemID INT IDENTITY(1,1) NOT NULL 
    CONSTRAINT PK_OrderItems_OrderItemID PRIMARY KEY CLUSTERED,
   OrderID INT NOT NULL 
        CONSTRAINT FK_OrderItems_OrderID_Orders_OrderID
                    FOREIGN KEY REFERENCES Orders (OrderID),
   StockID INT NOT NULL
        CONSTRAINT FK_OrderItems_OrderID_Stock_StockID
                FOREIGN KEY REFERENCES Stock (StockID),
   Quantity SMALLINT NOT NULL,
   Discount NUMERIC(4,2) NOT NULL,
    CONSTRAINT UQ_OrderItems_OrderID_StockID
            UNIQUE NONCLUSTERED (OrderID, StockID)
);

ALTER TABLE Orders
    ADD CONSTRAINT DF_Orders_orderDate_getDate
        DEFAULT GETDATE() FOR OrderDate

ALTER TABLE Orders
    ADD CONSTRAINT DF_Orders_OrderIsExpedited_FALSE
        DEFAULT 0 FOR OrderIsExpedited


RETURN;

