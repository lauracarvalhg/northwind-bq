-- View de staging: categories do Northwind com colunas em snake_case.
CREATE OR REPLACE VIEW northwind_staging.stg_categories AS
SELECT
  categoryID AS category_id,
  categoryName AS category_name,
  description
FROM northwind_raw.categories;
