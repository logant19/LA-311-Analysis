/*
==============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
==============================================================================
Script Purpose:
	This stored procedure performs the ETL (Extract, Transform, Load) process 
	to populate the silver schema tables from the bronze schema.

	It performs the following actions:
	- Truncates the silver tables before loading data.
	- Inserts transformed, cleaned, and standardized data from bronze into silver 
		tables.

Parameters:
	None.
		This stored procedure does not accept any parameters or return any values.

Usage Example:
	EXEC silver.load_silver;
==============================================================================
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE()
		PRINT '========================================';
		PRINT 'Loading Silver Layer';
		PRINT '========================================';

		PRINT '----------------------------------------';
		PRINT 'Loading LA 311 Tables';
		PRINT '----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.la311_2023';
		TRUNCATE TABLE silver.la311_2023;
		PRINT '>>Inserting Data Into: silver.la311_2023';
		INSERT INTO silver.la311_2023 (
			SRnumber,
			CreatedDate,
			UpdatedDate,
			ActionTaken,
			Owner,
			RequestType,
			Status,
			RequestSource,
			CreatedByUserOrganization,
			MobileOS,
			Anonymous,
			AssignTo,
			ServiceDate,
			ClosedDate,
			AddressVerified,
			ApproximateAddress,
			Address,
			HouseNumber,
			Direction,
			StreetName,
			Suffix,
			ZipCode,
			Latitude,
			Longitude,
			Location,
			TBMPage,
			TBMColumn,
			TBMRow,
			APC,
			CD,
			CDMember,
			NC,
			NCName,
			PolicePrecinct
		)
		SELECT
			SRnumber,
			CreatedDate,
			UpdatedDate,
			ActionTaken,
			Owner,
			RequestType,
			Status,
			RequestSource,
			CreatedByUserOrganization,
			MobileOS,
			CASE 
				WHEN Anonymous = 'Y' THEN 'Yes'
				WHEN Anonymous = 'N' THEN 'No'
			END AS Anonymous,
			AssignTo,
			ServiceDate,
			ClosedDate,
			CASE
				WHEN AddressVerified = 'Y' THEN 'Yes'
				WHEN AddressVerified = 'N' THEN 'No'
				WHEN AddressVerified = 'M' THEN 'Manually'
				ELSE NULL
			END AS AddressVerified,
			CASE 
				WHEN ApproximateAddress = 'Y' THEN 'Yes'
				WHEN ApproximateAddress = 'N' THEN 'No'
				ELSE NULL
			END AS ApproximateAddress,
			Address,
			Cast(Replace(HouseNumber, ',','') as int) AS HouseNumber,
			CASE Direction
				WHEN 'E' THEN 'East'
				WHEN 'W' THEN 'West'
				WHEN 'N' THEN 'North'
				WHEN 'S' THEN 'South'
				ELSE Direction
			END AS Direction,
			StreetName,
			Suffix,
			CASE 
				WHEN TRY_CAST(ZipCode AS INT) IS NULL THEN NULL
				ELSE ZipCode
			END AS ZipCode,
			Latitude,
			Longitude,
			Location,
			CAST(REPLACE(TBMPage, ',','') AS INT) AS TBMPage,
			TBMColumn,
			TBMRow,
			APC,
			CD,
			CDMember,
			NC,
			NCName,
			PolicePrecinct
		FROM bronze.la311_2023;
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>-------------------------';

		SET @start_time = GETDATE();
		PRINT '>>Truncating Table: silver.la311_2024';
		TRUNCATE TABLE silver.la311_2024;
		PRINT '>>Inserting Data Into: silver.la311_2024';
		INSERT INTO silver.la311_2024 (
			SRnumber,
			CreatedDate,
			UpdatedDate,
			ActionTaken,
			Owner,
			RequestType,
			Status,
			RequestSource,
			CreatedByUserOrganization,
			MobileOS,
			Anonymous,
			AssignTo,
			ServiceDate,
			ClosedDate,
			AddressVerified,
			ApproximateAddress,
			Address,
			HouseNumber,
			Direction,
			StreetName,
			Suffix,
			ZipCode,
			Latitude,
			Longitude,
			Location,
			TBMPage,
			TBMColumn,
			TBMRow,
			APC,
			CD,
			CDMember,
			NC,
			NCName,
			PolicePrecinct
		)
		SELECT
			SRnumber,
			CreatedDate,
			CASE 
				WHEN CreatedDate > UpdatedDate THEN CreatedDate
				ELSE UpdatedDate
			END AS NewUpdatedDate,
			ActionTaken,
			Owner,
			RequestType,
			Status,
			RequestSource,
			CreatedByUserOrganization,
			MobileOS,
			CASE 
				WHEN Anonymous = 'Y' THEN 'Yes'
				WHEN Anonymous = 'N' THEN 'No'
			END AS Anonymous,
			AssignTo,
			ServiceDate,
			ClosedDate,
			CASE
				WHEN AddressVerified = 'Y' THEN 'Yes'
				WHEN AddressVerified = 'N' THEN 'No'
				WHEN AddressVerified = 'M' THEN 'Manually'
				ELSE NULL
			END AS AddressVerified,
			CASE 
				WHEN ApproximateAddress = 'Y' THEN 'Yes'
				WHEN ApproximateAddress = 'N' THEN 'No'
				ELSE NULL
			END AS ApproximateAddress,
			Address,
			Cast(Replace(HouseNumber, ',','') as int) AS HouseNumber,
			CASE Direction
				WHEN 'E' THEN 'East'
				WHEN 'W' THEN 'West'
				WHEN 'N' THEN 'North'
				WHEN 'S' THEN 'South'
				ELSE Direction
			END AS Direction,
			StreetName,
			Suffix,
			CASE 
				WHEN TRY_CAST(ZipCode AS INT) IS NULL THEN NULL
				ELSE ZipCode
			END AS ZipCode,
			Latitude,
			Longitude,
			Location,
			CAST(REPLACE(TBMPage, ',','') AS INT) AS TBMPage,
			TBMColumn,
			TBMRow,
			APC,
			CD,
			CDMember,
			NC,
			NCName,
			PolicePrecinct
		FROM bronze.la311_2024;
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		PRINT '>>-------------------------';
		
		SET @batch_end_time = GETDATE();
		PRINT '========================================';
		PRINT 'Loading Silver Layer Is Completed';
		PRINT '	-Total Load Duration: ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '========================================'; 
	END TRY
	BEGIN CATCH
		PRINT '========================================';
		PRINT 'ERROR OCCURED DURING LOADING SILVER LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '========================================';
	END CATCH
END