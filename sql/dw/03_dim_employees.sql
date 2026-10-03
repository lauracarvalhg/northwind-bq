-- Dimensao de funcionarios.
CREATE OR REPLACE TABLE northwind_dw.dim_employees AS
SELECT
  employee_id,
  CONCAT(first_name, ' ', last_name) AS employee_name,
  title,
  hire_date,
  city,
  country,
  reports_to_employee_id
FROM northwind_staging.stg_employees;
