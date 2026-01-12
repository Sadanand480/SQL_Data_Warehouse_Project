-- Create Silver Tables
-----------------------------

-- Create a Silver.Customer Information-- 
create table silver.cust_info
like bronze.cust_info;

alter table silver.cust_info
modify column etl_load_date datetime default current_timestamp;

-- Create table Silver.Product Information-- 
create table silver.prd_info
like bronze.prd_info;

alter table silver.prd_info
add column etl_load_date datetime default current_timestamp;

show columns from bronze.prd_info;
alter table bronze.prd_info
change column `prd_start_dt_[0]` prd_start_dt_0 text;

alter table silver.prd_info
change column `prd_start_dt_[0]` prd_start_dt_0 text;

-- Create table Silver.Sales Details-- 
create table silver.sales_details
like bronze.sales_details;

alter table silver.sales_details
add column etl_load_date datetime default current_timestamp;

-- Create table Silver.loc_a101-- 
create table silver.loc_a101
like bronze.loc_a101;

alter table silver.loc_a101
add column etl_load_date datetime default current_timestamp;

-- Create table Silver.Customer az12-- 
create table silver.cust_az12
like bronze.cust_az12;

alter table silver.cust_az12
add column etl_load_date datetime default current_timestamp;

-- Create table Silver.px_cat_g1v2-- 
create table silver.px_cat_g1v2
like bronze.px_cat_g1v2;

alter table silver.px_cat_g1v2
add column etl_load_date datetime default current_timestamp;
