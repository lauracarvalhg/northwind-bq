-- View de staging: customers do Northwind com colunas em snake_case.
CREATE OR REPLACE VIEW northwind_staging.stg_customers AS
SELECT
  customerID AS customer_id,
  companyName AS company_name,
  contactName AS contact_name,
  contactTitle AS contact_title,
  address,
  city,
  region,
  postalCode AS postal_code,
  country,
  phone,
  fax
FROM northwind_raw.customers;
