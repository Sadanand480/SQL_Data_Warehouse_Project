-- DDL Script: Create Gold Views

-- Create Gold.Dim_Cumstomer View
 create view gold.dim_customer as
    select
		row_number() over (order by sc.cst_id) as customer_key,
		sc.cst_id as customer_id,
		sc.cst_key as customer_number,
		sc.cst_firstname as first_name,
		sc.cst_lastname as last_name,
		sca.birth_date as birth_date,
        sl.cntry as country,
        case 
			when sc.cst_gndr != 'N/A' then sc.cst_gndr
			else coalesce(sca.gen)
		end as gender,
		sc.cst_marital_status as marital_status,
		sc.cst_create_date as create_date
	from silver.cust_info as sc
	left join silver.cust_az12 as sca
	on sc.cst_key= sca.cst_key
	left join silver.loc_a101 as sl
	on sc.cst_key=sl.cid;

-- Create Gold.Dim_Products View
create view gold.dim_products as
select
	row_number() over(order by sp.prd_start_date,sp.prd_key) as product_key,
	sp.prd_id as product_id,
    sp.prd_key as product_number,
    sp.prd_nm as product_name,
	sp.cat_id as category_id,
    sg.CAT as category,
    sg.SUBCAT as subcategory,
	sg.MAINTENANCE,
    sp.prd_cost as cost,
	sp.prd_line as product_line,
    sp.prd_start_date as start_date,
    sp.prd_end_dt as end_date
from silver.prd_info as sp
left join silver.px_cat_g1v2 as sg
on sp.cat_id = sg.id;

-- Create Gold.Fact_Sales View
create view gold.fact_sales as
select
	sd.sls_ord_num as order_number,
    pr.product_key,
    cu.customer_key,
    sd.sls_cust_id,
    sd.sls_order_date,
    sd.sls_ship_date as shipping_date,
    sd.sls_due_date,
    sd.sls_sales as sales_amount,
    sd.sls_quantity,
    sd.sls_price
from silver.sales_details as sd
left join gold.dim_products as pr
on sd.sls_prd_key = pr.product_number
left join gold.dim_customer as cu
on sd.sls_cust_id = cu.customer_id;
