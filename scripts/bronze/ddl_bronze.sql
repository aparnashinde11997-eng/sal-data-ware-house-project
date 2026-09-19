/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/
create table bronze.crm_cust_info (
cst_id int,
cst_key nvarchar(50),
cst_firstname nvarchar(50),
cst_lastname nvarchar(50),
cst_marital_status nvarchar(50),
cst_gndr nvarchar(50),
cst_create_date date
);

create table bronze.crm_prd_info (
prd_id int,
prd_key	nvarchar(50),
prd_nm nvarchar(50),
prd_cost nvarchar(50),
prd_line nvarchar(50),	
prd_start_dt date,	
prd_end_dt date
);

ALTER TABLE bronze.crm_sales_details
ALTER COLUMN sls_order_dt DATE;
create table bronze.crm_sales_details(
sls_ord_num nvarchar(50),
sls_prd_key nvarchar(50),
sls_cust_id nvarchar(50),
sls_order_dt nvarchar(50),
sls_ship_dt date,
sls_due_dt date,
sls_sales nvarchar(50),
sls_quantity nvarchar(50),
sls_price nvarchar(50)

)


create table bronze.erp_cust_az12(
cid int,
bdate date,
gen nvarchar(50),
);


create table bronze.erp_loc_a101(
 cid int,
 cntry nvarchar(50)
 );


 create table bronze.erp_px_cat_g1v2 (
 id int,
 cat nvarchar(50),
 subcat nvarchar(50),
 maintenance nvarchar(50)
);
