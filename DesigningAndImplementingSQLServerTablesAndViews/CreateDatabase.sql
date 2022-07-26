-- Create database for Bobs Shoes
USE master
GO
CREATE DATABASE BobsShoes
GO

-- Show entry for BobsShoes in the system table
SELECT * FROM sys.databases WHERE name = 'BobsShoes'

-- Show the layout of files for the database
EXEC SP_HELPFILE;
GO

-- Create schema for Bobs Orders
CREATE SCHEMA Orders AUTHORIZATION dbo;
Go

-- Create new filegrups for data and logs
ALTER DATABASE BobsShoes    
    ADD FILEGROUP BobsData;

ALTER DATABASE BobsShoes
    ADD FILE(
        Name = BobsData,
        FILENAME = 'C:\SQLFiles\BobsShoes\BobsData.mdf'
    )
    TO FILEGROUP BobsData;

ALTER DATABASE BobsShoes
    ADD LOG FILE(
        Name = BobsLogs,
        FILENAME = 'C:\SQLFILES\BobsShoes\BobsLog.ldf'
    );
GO


