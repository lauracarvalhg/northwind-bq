-- View de staging: orders do Northwind com colunas em snake_case.
CREATE OR REPLACE VIEW northwind_staging.stg_orders AS
SELECT
  orderID AS order_id,
  customerID AS customer_id,
  employeeID AS employee_id,
  orderDate AS order_date,
  requiredDate AS required_date,
  shippedDate AS shipped_date,
  shipVia AS shipper_id,
  freight,
  shipName AS ship_name,
  shipAddress AS ship_address,
  shipCity AS ship_city,
  shipRegion AS ship_region,
  shipPostalCode AS ship_postal_code,
  shipCountry AS ship_country
FROM northwind_raw.orders;
