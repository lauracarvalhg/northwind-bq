-- View de staging: employees do Northwind com colunas em snake_case.
CREATE OR REPLACE VIEW northwind_staging.stg_employees AS
SELECT
  employeeID AS employee_id,
  lastName AS last_name,
  firstName AS first_name,
  title,
  titleOfCourtesy AS title_of_courtesy,
  birthDate AS birth_date,
  hireDate AS hire_date,
  address,
  city,
  region,
  postalCode AS postal_code,
  country,
  homePhone AS home_phone,
  extension,
  notes,
  CAST(reportsTo AS INT64) AS reports_to_employee_id,
  photoPath AS photo_path
FROM northwind_raw.employees;
