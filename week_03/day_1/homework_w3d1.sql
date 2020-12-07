/* MVP Questions */
/* 1. Find all the employees who work in the ‘Human Resources’ department. */

SELECT *
FROM employees
WHERE department = 'Human Resources'

/* 2. Get the first_name, last_name, and country of the employees who work in the ‘Legal’ department. */

SELECT
first_name, last_name, country
FROM employees
WHERE department = 'Legal'

/* 3. Count the number of employees based in Portugal. */

SELECT
COUNT(*) AS number_of_portugal_employees
FROM employees
WHERE country = 'Portugal'

/* 4. Count the number of employees based in either Portugal or Spain. */

SELECT
COUNT (*) as number_of_portugal_and_spain_employees
FROM employees
WHERE country = 'Portugal' OR country = 'Spain'

/* 5. Count the number of pay_details records lacking a local_account_no. */

SELECT
COUNT(*)
FROM pay_details
WHERE local_account_no IS NULL

/* 6. Get a table with employees first_name and last_name ordered alphabetically by last_name (put any NULLs last). */

SELECT first_name, last_name
FROM employees
ORDER BY last_name ASC NULLS LAST

/* 7. How many employees have a first_name beginning with ‘F’? */

SELECT 
COUNT(*) AS first_names_starts_with_f
FROM employees
WHERE first_name LIKE 'F_%'

/* 8. Count the number of pension enrolled employees not based in either France or Germany. */

SELECT
COUNT(*)
FROM employees
WHERE country NOT IN ('France', 'Germany') AND pension_enrol = TRUE

/* 9. Obtain a count by department of the employees who started work with the corporation in 2003. */

SELECT
department, COUNT(*) AS employees_2003_start
FROM employees
WHERE start_date BETWEEN '2013-01-01' AND '2013-12-31'
GROUP BY department

/* 10. Obtain a table showing department, fte_hours and the number of employees in each department who work each fte_hours pattern. Order the table alphabetically by department, and then in ascending order of fte_hours. */

SELECT
department, fte_hours, COUNT(fte_hours) AS number_of_employees_in_department
FROM employees
GROUP BY department, fte_hours
ORDER BY department ASC, 
fte_hours ASC

/* 11. Obtain a table showing any departments in which there are two or more employees lacking a stored first name. Order the table in descending order of the number of employees lacking a first name, and then in alphabetical order by department. */

SELECT
department, COUNT(*) 
FROM employees
WHERE first_name IS NULL
GROUP BY department
HAVING COUNT(*) >= 2
ORDER BY COUNT(*) DESC,
department ASC

/* 12. [Tough!] Find the proportion of employees in each department who are grade 1. */

SELECT
department, sum(grade) AS employees_grade_1, count(id) AS number_of_employees,
(CAST((sum(grade)) AS REAL) / CAST (COUNT(id) AS REAL)) AS proportion_of_employees_grade_1
FROM employees
GROUP BY department 
ORDER BY (CAST((sum(grade)) AS REAL) / CAST (COUNT(id) AS REAL)) DESC







