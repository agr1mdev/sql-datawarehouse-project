/*
===============================================================================
DDL Script: Create Bronze Layer Tables
===============================================================================

Script Purpose:
    This script creates the required tables within the 'bronze' schema.
    Existing tables are dropped before creation to ensure a clean and
    consistent table structure.

    Run this script whenever you need to recreate or reset the Bronze layer
    table definitions.
===============================================================================
*/

-- ddl for cust_info

IF OBJECT_ID ('bronze.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
GO

CREATE TABLE bronze.crm_cust_info(
	cst_id               INT,
	cst_key              NVARCHAR(50),
	cst_firstname        NVARCHAR(50),
	cst_lastname         NVARCHAR(50),
	cst_marital_status   NVARCHAR (50),
	cst_gndr             NVARCHAR (50),
	cst_create_date      DATE
);
GO

IF OBJECT_ID ('bronze.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;
GO
-- ddl for prd_info
CREATE TABLE bronze.crm_prd_info(
	prd_id        INT,
	prd_key       NVARCHAR(50),
	prd_nm        NVARCHAR(50),
	prd_cost      INT,
	prd_line      NVARCHAR(50),
	prd_start_dt  DATETIME,
	prd_end_dt    DATETIME
);
GO

IF OBJECT_ID ('bronze.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;
GO
-- ddl for sales_details
CREATE TABLE bronze.crm_sales_details(
	sls_ord_num  NVARCHAR(50),
	sls_prd_key  NVARCHAR(50),
	sls_cust_id  INT,
	sls_order_dt INT,
	sls_ship_dt  INT,
	sls_due_dt   INT,
	sls_sales    INT,
	sls_quantity INT,
	sls_price    INT
);

GO

IF OBJECT_ID ('bronze.erp_cust_az12', 'U') IS NOT NULL
	DROP TABLE bronze.erp_cust_az12;

GO
-- ddl for CUST_AZ12
CREATE TABLE bronze.erp_cust_az12(
	cid   NVARCHAR(50),
	bdate DATE,
	gen   NVARCHAR(50)
);

GO

IF OBJECT_ID ('bronze.erp_loc_a101', 'U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;

GO
-- ddl for LOC_A101
CREATE TABLE bronze.erp_loc_a101(
	cid   NVARCHAR(50),
	cntry NVARCHAR(30)
);
GO

IF OBJECT_ID ('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;
GO
-- ddl for PX_CATE_G1V2
CREATE TABLE bronze.erp_px_cat_g1v2(
	id          NVARCHAR(50),
	cat         NVARCHAR(50),
	subcat      NVARCHAR(50),
	maintenance NVARCHAR(50)
);
