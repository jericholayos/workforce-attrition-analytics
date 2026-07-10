CREATE TABLE job_role (
	job_role_id INT,
	job_role VARCHAR(50)
);

CREATE TABLE employee (
	employee_id INT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	age INT,
	gender VARCHAR(20),
	department_id INT,
	job_role_id INT,
	education_id INT,
	salary DECIMAL(10,2),
	monthly_income DECIMAL(10,2),
	years_at_company DECIMAL(10,2),
	years_in_current_role DECIMAL(10,2),
	overtime VARCHAR(10),
	distance_from_home INT,
	job_satisfaction INT,
	environment_satisfaction INT,
	performance_rating INT,
	work_life_balance INT,
	hire_date DATE,
	termination_date DATE,
	employee_status VARCHAR(50),
	attrition VARCHAR(20),
	termination_reason VARCHAR(80)
);

CREATE TABLE department (
	department_id INT,
	department_name VARCHAR(50)
);

CREATE table education (
	education_id INT,
	education_level VARCHAR(50)
);



	