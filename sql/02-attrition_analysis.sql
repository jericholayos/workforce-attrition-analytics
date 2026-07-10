-- which job role has the highest attrition rate in each department?
WITH CTE AS (
SELECT 
	job_role,
	department_name,
	COUNT(*) AS headcount,
	SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count
FROM employee t1
INNER JOIN job_role t2
	ON t1.job_role_id = t2.job_role_id
INNER JOIN department t3
	ON t3.department_id = t1.department_id
GROUP BY job_role, department_name
),
CTE2 AS (
SELECT
	*,
	ROUND(100.0 * attrition_count / headcount, 1) AS attrition_rate
FROM cte
),
ranked AS (
SELECT
	*,
	DENSE_RANK() OVER(PARTITION BY department_name ORDER BY attrition_rate DESC) AS rn
FROM cte2
)
SELECT
	job_role,
	department_name,
	headcount,
	attrition_count,
	attrition_rate
FROM ranked
WHERE rn = 1
ORDER BY attrition_count DESC;

-- overall attrition rate is 20.66%
SELECT
	ROUND(100.0 * SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS attrition_rate
FROM employee;

-- employee headcount by department
SELECT
	department_name,
	COUNT(*) FILTER(WHERE attrition = 'No') AS headcount
FROM employee t1 
INNER JOIN department t2
	ON t1.department_id = t2.department_id
WHERE employee_status = 'Active'
GROUP BY department_name
ORDER BY headcount DESC;

-- employee headcount by jobrole
SELECT
	department_name,
	job_role,
	COUNT(*) FILTER(WHERE attrition = 'No') AS headcount
FROM employee t1 
INNER JOIN job_role t2
	ON t1.job_role_id = t2.job_role_id
INNER JOIN department t3
	ON t3.department_id = t1.department_id
WHERE employee_status = 'Active'
GROUP BY department_name, job_role
ORDER BY department_name, headcount DESC;

-- Gender distribution by department
SELECT
	gender,
	COUNT(*) FILTER(WHERE attrition = 'No') AS headcount,
	COUNT(*) FILTER(WHERE attrition = 'Yes') AS attrition_count
FROM employee t1
INNER JOIN department t2
	ON t1.department_id = t2.department_id
GROUP BY gender
ORDER BY headcount DESC;

-- Average age by department
SELECT
	department_name,
	ROUND(AVG(age), 2) AS avg_age
FROM employee t1
INNER JOIN department t2
	ON t1.department_id = t2.department_id
GROUP BY department_name
ORDER BY avg_age DESC;

-- Average tenure by department
SELECT
	department_name,
	ROUND(AVG(years_at_company), 2) AS avg_tenure
FROM employee t1
INNER JOIN department t2
	ON t1.department_id = t2.department_id
GROUP BY department_name
ORDER BY avg_tenure DESC;








	