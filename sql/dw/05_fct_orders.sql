-- Fato no grao pedido, com receita liquida e prazos de entrega.
CREATE OR REPLACE TABLE northwind_dw.fct_orders AS
WITH itens AS (
  SELECT
    order_id,
    COUNT(*) AS distinct_products,
    SUM(quantity) AS total_quantity,
    SUM(gross_amount) AS gross_amount,
    SUM(discount_amount) AS discount_amount,
    SUM(net_amount) AS net_amount
  FROM northwind_dw.fct_order_items
  GROUP BY order_id
)

SELECT
  o.order_id,
  o.customer_id,
  o.employee_id,
  o.shipper_id,
  o.order_date,
  o.required_date,
  o.shipped_date,
  DATE_DIFF(o.shipped_date, o.order_date, DAY) AS days_to_ship,
  o.shipped_date > o.required_date AS shipped_late,
  o.freight,
  o.ship_country,
  i.distinct_products,
  i.total_quantity,
  i.gross_amount,
  i.discount_amount,
  i.net_amount
FROM northwind_staging.stg_orders AS o
LEFT JOIN itens AS i USING (order_id);
