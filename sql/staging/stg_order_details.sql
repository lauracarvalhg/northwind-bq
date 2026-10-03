-- View de staging: order_details do Northwind com colunas em snake_case.
CREATE OR REPLACE VIEW northwind_staging.stg_order_details AS
SELECT
  orderID AS order_id,
  productID AS product_id,
  unitPrice AS unit_price,
  quantity,
  discount
FROM northwind_raw.order_details;
