-- View de staging: products do Northwind com colunas em snake_case.
CREATE OR REPLACE VIEW northwind_staging.stg_products AS
SELECT
  productID AS product_id,
  productName AS product_name,
  supplierID AS supplier_id,
  categoryID AS category_id,
  quantityPerUnit AS quantity_per_unit,
  unitPrice AS unit_price,
  unitsInStock AS units_in_stock,
  unitsOnOrder AS units_on_order,
  reorderLevel AS reorder_level,
  discontinued = 1 AS is_discontinued
FROM northwind_raw.products;
