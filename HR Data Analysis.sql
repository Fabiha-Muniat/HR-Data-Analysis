SELECT
	*
FROM
	employee;

DESCRIBE employee ;

SELECT count(*) FROM employee;

-- 1. What is the gender distribution across the company?
SELECT
	gender AS Gender,
	COUNT(emp_id) AS Number_of_Employees
FROM
	employee
GROUP BY
	gender
ORDER BY
	COUNT(emp_id) DESC;

-- 2. How many employees belong to each race?
SELECT
	race AS Race,
	COUNT(emp_id) AS Number_of_Employees
FROM
	employee
GROUP BY
	race
ORDER BY
	COUNT(emp_id) DESC;

-- 3. Which departments have the highest number of employees?
SELECT
	department AS Department,
	COUNT(emp_id) AS Number_of_Employees
FROM
	employee
GROUP BY
	department
ORDER BY
	COUNT(emp_id) DESC;

-- What is the average age of employees by gender?
SELECT
	gender AS Gender,
	FLOOR(AVG(age)) AS Avg_Age
FROM
	employee
GROUP BY
	gender;


-- 4. What are the top 5 most common job titles?
SELECT
	jobtitle AS Job_Title,
	COUNT(emp_id) AS Number_of_Employees
FROM
	employee
GROUP BY
	jobtitle
ORDER BY
	COUNT(emp_id) DESC
LIMIT 5;

-- 5. What is the gender distribution in each department and job title?
SELECT
	department AS Department,
	jobtitle AS Job_Title,
	gender AS Gender, 
	COUNT(emp_id) AS Number_of_Employees
FROM
	employee
GROUP BY
	department,
	jobtitle,
	gender
ORDER BY
	department,
	jobtitle,
	gender;

-- 6. How many employees were hired each year?
SELECT
	YEAR(hire_date) YEAR,
	COUNT(emp_id) AS Number_of_employees_hired
FROM
	employee
GROUP BY
	YEAR(hire_date);

-- 7. How many employees left the company each year?
SELECT
	YEAR(termdate) AS YEAR,
	COUNT(emp_id) AS Number_of_employees_terminated
FROM
	employee
WHERE
	termdate <= CURRENT_DATE()
GROUP BY
	YEAR(termdate)
ORDER BY
	YEAR(termdate);

-- 8. Which departments have the highest turnover rates?
SELECT department, COUNT(*) as total_count, 
    SUM(CASE WHEN termdate <= CURDATE() AND termdate IS NOT NULL THEN 1 ELSE 0 END) as terminated_count, 
    (SUM(CASE WHEN termdate <= CURDATE() THEN 1 ELSE 0 END) / COUNT(*)) as termination_rate
FROM employee
GROUP BY department
ORDER BY termination_rate DESC;

--  What is the termination percentage in departments?
SELECT
	department,
	COUNT(emp_id) AS number_of_terminaiton,
	((COUNT(emp_id)/(
	SELECT
		COUNT(emp_id)
	FROM
		employee
	WHERE
		termdate <= CURRENT_DATE()))* 100) AS Termination_Rate
FROM
	employee
WHERE
	termdate <= CURRENT_DATE()
GROUP BY
	department
ORDER BY
	Termination_Rate DESC ;

-- 9. What is the average length of employment for employees who have been terminated?
SELECT 
	ROUND(AVG(timestampdiff(YEAR,hire_date,termdate))) AS Avg_employment_duration
FROM
	employee
WHERE
	termdate <= CURRENT_DATE();

-- 10. What is the employee count by city and state?
SELECT
	location_state  AS State,
	location_city  AS City, 
	COUNT(emp_id) AS Number_of_Employees
FROM
	employee
GROUP BY
	location_state ,
	location_city 
ORDER BY
	location_state;

-- 11. How many employees work at headquarters versus remote locations?
SELECT location, COUNT(emp_id) AS Number_of_Employees
FROM employee
GROUP BY location;

-- 12. Which states have the most recently hired employees?
SELECT location_state , max(hire_date) AS Last_Hiring_Date
FROM employee
GROUP BY location_state
ORDER BY max(hire_date) DESC;

-- 13. age of current employees
SELECT min(age) FROM employee;
SELECT max(age) FROM employee;
SELECT 
CASE 
	WHEN age>=18 AND age<=29 THEN '18-29'
	WHEN age>=30 AND age<=39 THEN '30-39'
	WHEN age>=40 AND age<=49 THEN '40-49'
	WHEN age>=50 AND age<=59 THEN '50-59'
	ELSE '60+'
END AS age_group,
count(emp_id) AS Number_of_Employees
FROM employee
WHERE termdate>CURRENT_DATE() OR termdate IS NULL
GROUP BY age_group
ORDER BY age_group;

-- age of employees who left
SELECT 
CASE 
	WHEN age>=18 AND age<=29 THEN '18-29'
	WHEN age>=30 AND age<=39 THEN '30-39'
	WHEN age>=40 AND age<=49 THEN '40-49'
	WHEN age>=50 AND age<=59 THEN '50-59'
	ELSE '60+'
END AS age_group,
count(emp_id) AS Number_of_Employees
FROM employee
WHERE termdate<=CURRENT_DATE() AND termdate IS NOT NULL 
GROUP BY age_group
ORDER BY age_group;
 
