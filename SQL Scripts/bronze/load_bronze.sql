/*
==============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
==============================================================================
Script Purpose:
	This stored procedure loads data into the 'bronze' schema from external 
	MyLA311 files. It performs the following actions:
	- Truncates the bronze tables before loading data.
	- Uses the `BULK INSERT` command to load data from CSV files to bronze tables.

Parameters:
	None.
		This stored procedure does not accept any parameters or return any values.

Usage Example:
	EXEC bronze.load_bronze;
==============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '========================================';
		PRINT 'Loading Bronze Layer';
		PRINT '========================================';

		PRINT '----------------------------------------';
		PRINT 'Loading	LA 311 Data';
		PRINT '----------------------------------------';

		SET @start_time = GETDATE()
		PRINT '>>Truncating Table: bronze.la311_2023';
		TRUNCATE TABLE bronze.la311_2023;
		PRINT '>>Inserting Data Into: bronze.la311_2023';
		BULK INSERT bronze.la311_2023
		FROM 'C:\SQL\311Data\MyLA311_Service_Request_Data_2023_20250831.csv'
		WITH (
			FIRSTROW = 2,
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			CODEPAGE = '65001',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>-------------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: bronze.la311_2024';
		TRUNCATE TABLE bronze.la311_2024;
		PRINT '>>Inserting Data Into: bronze.la311_2024';
		BULK INSERT bronze.la311_2024
		FROM 'C:\SQL\311Data\MyLA311_Service_Request_Data_2024_20250828.csv'
		WITH (
			FIRSTROW = 2,
			FORMAT = 'CSV',
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0a',
			CODEPAGE = '65001',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>-------------------------';

		SET @batch_end_time = GETDATE()
		PRINT '========================================';
		PRINT 'Loading Bronze Layer Is Completed';
		PRINT '	-Total Load Duration: ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '========================================'; 
	END TRY
	BEGIN CATCH
		PRINT '========================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '========================================';
	END CATCH
END