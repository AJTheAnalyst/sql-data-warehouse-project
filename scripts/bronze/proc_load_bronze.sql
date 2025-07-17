/*
================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
================================================================
Scripts Purpose:
  This Stored Procedure loads data into the 'bronze' schema from external csv files . 
  It Performs the following actions:
  - Truncates the bronze table before loading
  - Using the 'BULK INSERT' command to load data from csv files to bronze tables.

Parameters:
  None.
  This Stored Procedure does not accept any parameters or return any values.

Usage Example:
    EXEC dbo.load_bronze;

==================================================================
*/
CREATE OR ALTER PROCEDURE dbo.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME , @end_time DATETIME , @batch_start_time DATETIME , @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT('=====================')
		PRINT('Loading Bronze Layer')
		PRINT('=====================')


		PRINT('-----------------------')
		PRINT('Loading CRM Tables')
		PRINT('------------------------')

		SET @start_time = GETDATE();

		PRINT('>> Truncating Table: bronze_crm_cust_info ')
		TRUNCATE TABLE dbo.bronze_crm_cust_info

		PRINT('>> Inserting Data Into: bronze_crm_cust_info ')
		BULK INSERT dbo.bronze_crm_cust_info
		FROM 'C:\Users\Ajays\OneDrive - Metro Shipping\Desktop\Data With Baara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH
			(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>----------------------------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT('>> Truncating Table: bronze_crm_prd_info')
		TRUNCATE TABLE dbo.bronze_crm_prd_info

		PRINT('>> Inserting Data Into: bronze_crm_prd_info ')
		BULK INSERT dbo.bronze_crm_prd_info
		FROM 'C:\Users\Ajays\OneDrive - Metro Shipping\Desktop\Data With Baara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH
			(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>----------------------------------------------------------------------------------------';
		
		SET @start_time = GETDATE();
		PRINT('>> Truncating Table: bronze_crm_sales_details')
		TRUNCATE TABLE dbo.bronze_crm_sales_details

		PRINT('>> Inserting Data Into: bronze_crm_sales_details')
		BULK INSERT dbo.bronze_crm_sales_details
		FROM 'C:\Users\Ajays\OneDrive - Metro Shipping\Desktop\Data With Baara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH
			(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>----------------------------------------------------------------------------------------';
	
		PRINT('-----------------------')
		PRINT('Loading ERP Tables')
		PRINT('------------------------')

		SET @start_time = GETDATE();
		PRINT('>> Truncating Table: bronze_erp_cust_az12')
		TRUNCATE TABLE dbo.bronze_erp_cust_az12

		PRINT('>> Inserting Data Into: bronze_erp_cust_az12')
		BULK INSERT dbo.bronze_erp_cust_az12
		FROM 'C:\Users\Ajays\OneDrive - Metro Shipping\Desktop\Data With Baara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH
			(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>----------------------------------------------------------------------------------------';
		
		SET @start_time = GETDATE();
		PRINT('>> Truncating Table: bronze_erp_loc_a101')
		TRUNCATE TABLE dbo.bronze_erp_loc_a101

		PRINT('>> Inserting Data Into: bronze_erp_loc_a101')
		BULK INSERT dbo.bronze_erp_loc_a101
		FROM 'C:\Users\Ajays\OneDrive - Metro Shipping\Desktop\Data With Baara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH
			(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>----------------------------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT('>> Truncating Table: bronze_erp_px_cat_g1v2')
		TRUNCATE TABLE dbo.bronze_erp_px_cat_g1v2

		PRINT('>> Inserting Data Into: bronze_erp_px_cat_g1v2')
		BULK INSERT dbo.bronze_erp_px_cat_g1v2
		FROM 'C:\Users\Ajays\OneDrive - Metro Shipping\Desktop\Data With Baara\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH
			(
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
			);
		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		PRINT '>>----------------------------------------------------------------------------------------';

		SET @batch_end_time = GETDATE();
		PRINT '======================================';
		PRINT 'Loading Bronze Layer is Completed';
		PRINT ' - Total Load Duration: ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR) + 'seconds' ;
		PRINT '======================================';
	END TRY
	BEGIN CATCH
		PRINT '=============================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() as NVARCHAR);
		PRINT '=============================';
	END CATCH
END
