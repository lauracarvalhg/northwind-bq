-- View de staging: shippers do Northwind com colunas em snake_case.
CREATE OR REPLACE VIEW northwind_staging.stg_shippers AS
SELECT
  shipperID AS shipper_id,
  companyName AS company_name,
  phone
FROM northwind_raw.shippers;
