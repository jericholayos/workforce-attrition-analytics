-- Monthly attrition trend (2023-2026)
SELECT
	EXTRACT(YEAR FROM termination_date) AS year,
	EXTRACT(MONTH FROM termination_date) AS month,
	COUNT(*) AS attrition_count
FROM employee
WHERE attrition = 'Yes'
	AND EXTRACT(YEAR FROM termination_date) BETWEEN 2023 AND 2026
GROUP BY 1, 2
ORDER BY 1, 2;  

-- Department ranking by attrition rate
WITH CTE AS (
SELECT
	department_name,
	ROUND(
		100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2
	) AS attrition_rate
FROM employee t1
INNER JOIN department t2
	ON t1.department_id = t2.department_id
GROUP BY 1
)
SELECT
	DENSE_RANK() OVER(ORDER BY attrition_rate DESC) AS rank,	
	department_name,
	attrition_rate
FROM cte;

-- Longest-tenured employee in each department
WITH cte AS (
SELECT
	CONCAT(first_name, ' ', last_name) AS employee_name,
	department_name,
	years_at_company,
	ROW_NUMBER() OVER(PARTITION BY department_name ORDER BY years_at_company DESC) AS rn
FROM employee t1
INNER JOIN department t2
	ON t1.department_id = t2.department_id
)
SELECT
	employee_name,
	department_name,
	years_at_company
FROM cte
WHERE rn = 1
ORDER BY 3 DESC;

-- Employees above their department's average salary
WITH dept_avg AS (
SELECT
	department_id,
	AVG(salary) AS dept_salary
FROM employee
GROUP BY 1
)
SELECT
	CONCAT(first_name, ' ', last_name) AS employee_name,	
	salary
FROM employee t1
INNER JOIN dept_avg t2
	ON t1.department_id = t2.department_id
WHERE t1.salary > t2.dept_salary;

-- running total of hires by month
WITH CTE AS (
SELECT
	TO_CHAR(DATE_TRUNC('month', hire_date), 'YYYY-MM') AS hire_date,
	COUNT(*) AS hire_count
FROM employee
WHERE EXTRACT(YEAR FROM hire_date) BETWEEN 2023 AND 2026
GROUP BY 1
)
SELECT
	*,
	SUM(hire_count) OVER(ORDER BY hire_date) AS running_total
FROM cte;













