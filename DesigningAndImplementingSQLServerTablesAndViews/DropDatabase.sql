USE master

DROP SCHEMA Orders
GO

USE master;
GO

ALTER DATABASE BobsShoes SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE BobsShoes;
GO
