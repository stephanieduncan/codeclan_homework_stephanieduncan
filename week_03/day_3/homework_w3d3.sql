-- 1 MVP Questions
-- 1. Are there any pay_details records lacking both a local_account_no and iban number?

SELECT
local_account_no,
iban
FROM pay_details
WHERE  local_account_no IS NULL AND iban IS NULL;

-- 2. Get a table of employees first_name, last_name and country, 
-- ordered alphabetically first by country and then by last_name (put any NULLs last).

SELECT
first_name,
last_name,
country
FROM employees
ORDER BY country, last_name ASC NULLS LAST;

-- 3. Find the details of the top ten highest paid employees in the corporation.

SELECT
*
FROM employees
ORDER BY salary DESC NULLS LAST
LIMIT 10

-- 4. Find the first_name, last_name and salary of the lowest paid employee in Hungary.

SELECT
first_name,
last_name,
salary
FROM employees
WHERE country = 'Hungary'
ORDER BY salary ASC NULLS LAST
LIMIT 1;

-- 5. Find all the details of any employees with a ‘yahoo’ email address?

SELECT *
FROM employees
WHERE email ILIKE '%yahoo%'

-- 6. Provide a breakdown of the numbers of employees enrolled, 
-- not enrolled, and with unknown enrollment status in the corporation pension scheme.

SELECT
count(*),
pension_enrol
FROM employees
GROUP BY pension_enrol;

-- 7. What is the maximum salary among those employees in the ‘Engineering’ 
-- department who work 1.0 full-time equivalent hours (fte_hours)?

SELECT
MAX(salary)
FROM employees
WHERE department = 'Engineering' AND fte_hours = '1.0';

SELECT
*
FROM employees
WHERE department = 'Engineering' AND fte_hours = '1.0'
ORDER BY salary DESC NULLS LAST
LIMIT 1;

-- 8. Get a table of country, number of employees in that country, and 
-- the average salary of employees in that country for any countries in which 
-- more than 30 employees are based. Order the table by average salary descending.

SELECT
country,
count(id) AS number_of_employees,
AVG(salary) AS average_salary
FROM employees
GROUP BY country
HAVING count(id) > 30
ORDER BY AVG(salary) ASC NULLS LAST;

-- 9. Return a table containing each employees first_name, last_name, 
-- full-time equivalent hours (fte_hours), salary, and a new column effective_yearly_salary 
-- which should contain fte_hours multiplied by salary.

SELECT
first_name,
last_name,
fte_hours,
salary,
(fte_hours * salary) AS effective_yearly_salary
FROM employees

-- 10. Find the first name and last name of all employees who lack a local_tax_code.

-- SELECT *
-- FROM pay_details
-- WHERE local_tax_code IS NULL

SELECT
e.first_name,
e.last_name
-- e.id
-- pd.id,
-- pd.local_tax_code
FROM employees AS e
INNER JOIN pay_details AS pd
ON e.id = pd.id
WHERE local_tax_code IS NULL
-- ORDER BY e.last_name ASC NULLS LAST;

-- 11. The expected_profit of an employee is defined as (48 * 35 * charge_cost - salary) * fte_hours, 
-- where charge_cost depends upon the team to which the employee belongs. Get a table showing 
-- expected_profit for each employee.

SELECT
e.first_name,
e.last_name,
-- e.fte_hours,
-- e.salary,
-- t.charge_cost,
(48 * 35 * CAST(charge_cost AS INT) - salary) * fte_hours AS expected_profit
FROM employees AS e
LEFT JOIN teams AS t
ON e.team_id = t.id
ORDER BY expected_profit DESC NULLS LAST

-- * CAST(48 * 35 * charge_cost - salary) * fte_hours) AS INT) AS expected_profit

-- 12. [Bit Tougher] Return a table of those employee first_names shared by more than one employee, 
-- together with a count of the number of times each first_name occurs. Omit employees 
-- without a stored first_name from the table. Order the table descending by count, and then 
-- alphabetically by first_name.

SELECT
first_name,
count(id)
FROM employees
WHERE first_name IS NOT NULL
GROUP BY first_name
HAVING count(id) > 1
ORDER BY count(id) DESC, first_name ASC
