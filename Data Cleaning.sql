
------------------------------------------------------ Employee Data Cleaning-------------------------------------------------------------

SELECT
	*
FROM
	employee;

DESCRIBE employee;

-- Change id header
ALTER TABLE employee 
CHANGE COLUMN id emp_id varchar(20) NOT NULL;

-- Format birthdate
UPDATE
	employee
SET
	birthdate = CASE
		WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%y-%m-%d')
		WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%y'), '%y-%m-%d')
		ELSE NULL
	END

UPDATE
	employee
SET
	birthdate = CASE
		WHEN LEFT(birthdate, 2) BETWEEN '60' AND '99' THEN concat(19, birthdate)
		ELSE CONCAT(20, birthdate )
	END;

ALTER TABLE employee 
MODIFY COLUMN birthdate DATE;

-- Format hiredate
UPDATE
	employee
SET
	hire_date = CASE
		WHEN hire_date  LIKE '%/%' THEN date_format(str_to_date(hire_date , '%m/%d/%Y'), '%Y-%m-%d')
		WHEN hire_date  LIKE '%-%' THEN date_format(str_to_date(hire_date , '%m-%d-%Y'), '%Y-%m-%d')
		ELSE NULL
	END;

ALTER TABLE employee 
MODIFY COLUMN hire_date DATE;

-- Format termination date
UPDATE employee 
SET termdate= DATE(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate!='';

UPDATE employee
SET termdate =NULL
WHERE termdate ='';

ALTER TABLE employee 
MODIFY COLUMN termdate DATE;

-- Adding age column
ALTER TABLE employee 
ADD COLUMN age INT;

UPDATE employee
SET age = TIMESTAMPDIFF(YEAR,birthdate,CURRENT_DATE());

DESCRIBE employee;

SELECT * FROM employee;

-- Check numberof NULL or empty values in each column
SELECT 
  SUM(CASE WHEN emp_id IS NULL OR emp_id = '' THEN 1 ELSE 0 END) AS id_missing,
  SUM(CASE WHEN first_name IS NULL OR first_name = '' THEN 1 ELSE 0 END) AS first_name_missing,
  SUM(CASE WHEN last_name IS NULL OR last_name = '' THEN 1 ELSE 0 END) AS last_name_missing,
  SUM(CASE WHEN birthdate IS NULL THEN 1 ELSE 0 END) AS birthdate_missing,
  SUM(CASE WHEN gender IS NULL OR gender = '' THEN 1 ELSE 0 END) AS gender_missing,
  SUM(CASE WHEN race IS NULL OR race = '' THEN 1 ELSE 0 END) AS race_missing,
  SUM(CASE WHEN department IS NULL OR department = '' THEN 1 ELSE 0 END) AS department_missing,
  SUM(CASE WHEN jobtitle IS NULL OR jobtitle = '' THEN 1 ELSE 0 END) AS jobtitle_missing,
  SUM(CASE WHEN location IS NULL OR location = '' THEN 1 ELSE 0 END) AS location_missing,
  SUM(CASE WHEN hire_date IS NULL THEN 1 ELSE 0 END) AS hire_date_missing,
  SUM(CASE WHEN termdate IS NULL THEN 1 ELSE 0 END) AS termdate_missing,
  SUM(CASE WHEN location_city IS NULL OR location_city = '' THEN 1 ELSE 0 END) AS location_city_missing,
  SUM(CASE WHEN location_state IS NULL OR location_state = '' THEN 1 ELSE 0 END) AS location_state_missing,
  SUM(CASE WHEN age IS NULL OR age='' THEN 1 ELSE 0 END) AS age_missing
FROM employee;
