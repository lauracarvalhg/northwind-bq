-- View de staging: employee_territories do Northwind com colunas em snake_case.
CREATE OR REPLACE VIEW northwind_staging.stg_employee_territories AS
SELECT
  employeeID AS employee_id,
  territoryID AS territory_id
FROM northwind_raw.employee_territories;
