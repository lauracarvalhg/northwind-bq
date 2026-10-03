-- View de staging: territories do Northwind com colunas em snake_case.
CREATE OR REPLACE VIEW northwind_staging.stg_territories AS
SELECT
  territoryID AS territory_id,
  territoryDescription AS territory_description,
  regionID AS region_id
FROM northwind_raw.territories;
