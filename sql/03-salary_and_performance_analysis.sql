-- Average salary by department
SELECT
	department_name,
	ROUND(AVG(salary), 2) AS avg_salary
FROM employee t1
INNER JOIN department t2
	ON t1.department_id = t2.department_id
GROUP BY department_name
ORDER BY avg_salary DESC;

-- Top 5 highest-paid employees per department
WITH CTE AS (
SELECT
	department_name,
	CONCAT(t1.first_name, ' ', t1.last_name) AS emp_name,
	salary
FROM employee t1
INNER JOIN department t2
	ON t1.department_id = t2.department_id
),
salary_rank AS (
SELECT
	*,
	DENSE_RANK() OVER(PARTITION BY department_name ORDER BY salary DESC) AS rn
FROM cte
)
SELECT
	emp_name,
	salary,
	department_name
FROM salary_rank
WHERE rn <= 5;

-- Average performance rating by department
SELECT
	department_name,
	ROUND(AVG(performance_rating), 2) AS avg_performance_rating
FROM employee t1
INNER JOIN department t2
	ON t1.department_id = t2.department_id	
GROUP BY department_name
ORDER BY 2 DESC;

-- Salary comparison: employees who stayed vs. employees who left
SELECT
	attrition,
	ROUND(AVG(salary), 2) AS avg_salary
FROM employee
GROUP BY 1;














