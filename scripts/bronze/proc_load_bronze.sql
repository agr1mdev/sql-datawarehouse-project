/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================

Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external
    CSV files.

    It performs the following actions:
    - Truncates the Bronze layer tables before loading new data.
    - Uses the 'BULK INSERT' command to load data from CSV files into
      the Bronze layer tables.

Parameters:
    None.

    This stored procedure does not accept any parameters or return any values.

Usage Example:

    EXEC bronze.load_bronze;

===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME
	DECLARE @start_total_time DATETIME, @end_total_time DATETIME

	SET @start_total_time = GETDATE()
	BEGIN TRY
		PRINT '====================================';
		PRINT 'Loading Bronze Layer';
		PRINT '====================================';

		PRINT '____________________________________';
		PRINT 'Loading CRM Tables';
		PRINT '____________________________________';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\agrim\OneDrive\Documents\DE\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -----------------';

		-- Bulk inserting data in bronze.crm_prd_info
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\agrim\OneDrive\Documents\DE\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -----------------';

		-- Bulk inserting data into bronze.crm_sales_details
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\agrim\OneDrive\Documents\DE\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -----------------';


		PRINT '____________________________________';
		PRINT 'Loading ERP Tables';
		PRINT '____________________________________';
		-- Bulk inserting data into bronze.erp_cust_az12

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\agrim\OneDrive\Documents\DE\SQL\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -----------------';

		-- Bulk inserting data into bronze.erp_loc_a101
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\agrim\OneDrive\Documents\DE\SQL\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -----------------';

		-- Bulk inserting data into bronze.erp_px_cat_g1v2
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\agrim\OneDrive\Documents\DE\SQL\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF (second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -----------------';
		
		SET @end_total_time = GETDATE();
		PRINT '>> Total Duration for loading bronze layer: '+ CAST(DATEDIFF (second,@start_total_time,@end_total_time) AS NVARCHAR) + 'seconds';
		PRINT '>> -----------------';

	END TRY
  BEGIN CATCH
      PRINT '=======================================';
      PRINT 'Error occurred during loading BRONZE Layer';
      PRINT 'Error Message: ' + ERROR_MESSAGE();
      PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
      PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
      PRINT 'Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR);
      PRINT '=======================================';
  END CATCH
END 


EXEC bronze.load_bronze;
-- since the message is not clear after running the SP we will add info to it
-- using the print statements

