-- Dimensao de produtos com categoria e fornecedor.
CREATE OR REPLACE TABLE northwind_dw.dim_products AS
SELECT
  p.product_id,
  p.product_name,
  p.category_id,
  c.category_name,
  p.supplier_id,
  s.company_name AS supplier_name,
  s.country AS supplier_country,
  p.quantity_per_unit,
  p.unit_price AS list_price,
  p.units_in_stock,
  p.units_on_order,
  p.reorder_level,
  p.is_discontinued
FROM northwind_staging.stg_products AS p
LEFT JOIN northwind_staging.stg_categories AS c USING (category_id)
LEFT JOIN northwind_staging.stg_suppliers AS s USING (supplier_id);
