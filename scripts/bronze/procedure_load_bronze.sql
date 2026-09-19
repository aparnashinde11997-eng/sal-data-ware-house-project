/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/



create or alter procedure bronze.load_bronze As
BEGIN
   DECLARE @start_time datetime,@end_time datetime,@batch_start_time datetime ,@batch_end_time datetime;
 BEGIN TRY
 SET @batch_start_time = GETDATE();
  PRINT'===============================================================================';
  PRINT'Loading Bronze Layer';
  PRINT'===============================================================================';

  PRINT'-------------------------------------------------------------------------------';
  PRINT'Loading CRM Tables';
  PRINT'-------------------------------------------------------------------------------';

  SET @start_time = GETDATE();
  PRINT'>>Truncate table : bronze.crm_cust_info';
	truncate table bronze.crm_cust_info;

  PRINT'>>Inserting Data Into : bronze.crm_cust_info';
	Bulk insert bronze.crm_cust_info
	from 'C:\Users\Akshay Nimbalkar\Downloads\Source crm\cust_info.csv'
	with (
	firstrow = 2,
	fieldterminator = ',',
	tablock
	);
	SET @end_time = GETDATE()
	PRINT '>>LOAD DURATION' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT'--------------';
	

   SET @start_time = GETDATE();
   PRINT'Truncate table : Bronze.crm_prd_info';
	truncate table bronze.crm_prd_info;

	PRINT'>>>Inserting data into bronze.prd_info ';
	Bulk insert bronze.crm_prd_info
	from 'C:\Users\Akshay Nimbalkar\Downloads\source crm\prd_info.csv'
	with (
	firstrow = 2,
	fieldterminator=',',
	tablock
	);
	SET @end_time = GETDATE();
	PRINT '>>LOAD DURATION' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>>-------------';


	SET @start_time = GETDATE();
	PRINT'>>Truncate Table :Bronze.crm_sales_details';
	TRUNCATE TABLE bronze.crm_sales_details;

	PRINT'>>Inserting Data Into : bronze.crm_sales_details';
	BULK INSERT bronze.crm_sales_details
	FROM 'C:\Users\Akshay Nimbalkar\Downloads\Source crm\sales_details.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
	SET @end_time = GETDATE();
	PRINT '>>LOAD DURATION' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>>---------------';

			ALTER TABLE bronze.crm_sales_details
			ALTER COLUMN sls_order_dt nvarchar(50);


      PRINT'-------------------------------------------------------------------------------';
	  PRINT'Loading ERP Tables';
	  PRINT'-------------------------------------------------------------------------------';

    SET @start_time = GETDATE(); 
    PRINT'>>Truncate Table : bronze.erp_cust_az12';
	truncate table bronze.erp_cust_az12

	PRINT'>>Inserting Data Into : bronze.erp_cust_az12';
	bulk insert bronze.erp_cust_az12
	from 'C:\Users\Akshay Nimbalkar\Downloads\source erp\CUST_AZ12.csv'
	with (
	firstrow = 2,
	fieldterminator=',',
	tablock
	);
	SET @end_time = GETDATE();
	PRINT '>>LOAD DURATION' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>>---------------';
	
			ALTER TABLE bronze.erp_cust_az12
			ALTER COLUMN cid VARCHAR(50);
											
    SET @start_time = GETDATE(); 
    PRINT'>>Truncate Table : bronze.erp_loc_a101';
	truncate table bronze.erp_loc_a101

	PRINT'>>Inserting Data Into : bronze.erp_loc_a101';
	bulk insert bronze.erp_loc_a101
	from 'C:\Users\Akshay Nimbalkar\Downloads\source erp\LOC_A101.csv'
	with (
	firstrow = 2,
	fieldterminator=',',
	tablock
	);
	SET @end_time = GETDATE();
	PRINT '>>LOAD DURATION' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>>-------------------'
	
			ALTER TABLE bronze.erp_loc_a101
			ALTER COLUMN cid VARCHAR(50);
	 

    SET @start_time = GETDATE();
    PRINT'>>Truncate Table : erp_px_cat_g1v2';
	truncate table bronze.erp_px_cat_g1v2


	PRINT'>>Inserting Data Into Table : erp_px_cat_g1v2';
	bulk insert bronze.erp_px_cat_g1v2
	from 'C:\Users\Akshay Nimbalkar\Downloads\source erp\PX_CAT_G1V2.csv'
	with (
	firstrow = 2,
	fieldterminator=',',
	tablock
	);
	SET @end_time = GETDATE();
	PRINT '>>LOAD DURATION'+ CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT '>>--------------';


		ALTER TABLE  bronze.erp_px_cat_g1v2
		ALTER COLUMN id VARCHAR(50);

		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
	END TRY
	BEGIN CATCH
	PRINT'==============================================================================';
	PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT'ERROR MESSAGE' + ERROR_MESSAGE();
	PRINT'ERROR MESSAGE'+ CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT'ERROR MESSAGE' +CAST(ERROR_STATE()AS NVARCHAR);
 END CATCH
END


 
