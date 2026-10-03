-- Dimensao de clientes.
CREATE OR REPLACE TABLE northwind_dw.dim_customers AS
SELECT
  customer_id,
  company_name,
  contact_name,
  contact_title,
  city,
  region,
  postal_code,
  country
FROM northwind_staging.stg_customers;
