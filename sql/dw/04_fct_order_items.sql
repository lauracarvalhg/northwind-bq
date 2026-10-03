-- Fato no grao item de pedido (order_id + product_id).
CREATE OR REPLACE TABLE northwind_dw.fct_order_items AS
SELECT
  d.order_id,
  d.product_id,
  o.customer_id,
  o.employee_id,
  o.shipper_id,
  o.order_date,
  o.required_date,
  o.shipped_date,
  d.unit_price,
  d.quantity,
  d.discount,
  d.unit_price * d.quantity AS gross_amount,
  d.unit_price * d.quantity * d.discount AS discount_amount,
  d.unit_price * d.quantity * (1 - d.discount) AS net_amount
FROM northwind_staging.stg_order_details AS d
INNER JOIN northwind_staging.stg_orders AS o USING (order_id);
