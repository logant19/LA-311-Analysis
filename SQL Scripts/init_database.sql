/*
=========================================================
Create Database and Schemas
=========================================================
Script Purpose:
	This script creates a new database named 'LA311' after checking if it already exists.
	If the database exists, it is dropped and recreated. Additionally, the script sets up three 
	schemas within the database: 'bronze', 'silver', and 'gold'.

WARNING:
	Running this script will drop the entire 'LA311' database if it exists. 
	All data in the database will be permanently deleted.
*/

USE master;
GO

--Drop and recreate the 'LA311' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'LA311')
BEGIN
	ALTER DATABASE LA311 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE LA311;
END;
GO

--Create the 'LA311' database
CREATE DATABASE LA311;
GO

USE LA311;
GO

--Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO