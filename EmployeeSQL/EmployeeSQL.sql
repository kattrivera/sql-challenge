
DROP TABLE employees;
CREATE TABLE employees (
	emp_no INT PRIMARY KEY NOT NULL,
	emp_tit_id VARCHAR(30) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	sex VARCHAR(6) NOT NULL,
	hire_date DATE NOT NULL)
;

SELECT * FROM employees e
;

DROP TABLE salaries;
CREATE TABLE salaries (
 	emp_no INT NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	salary INT NOT NULL,
	PRIMARY KEY (emp_no))
;


SELECT * FROM salaries s
;

DROP TABLE departments;
CREATE TABLE departments(
 	dept_no VARCHAR PRIMARY KEY NOT NULL,
 	dept_name VARCHAR NOT NULL)
;

SELECT * FROM departments d
;

DROP TABLE dept_manager;
CREATE TABLE dept_manager(
 	dept_no VARCHAR NOT NULL,
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
 	emp_no INT NOT NULL,
 	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (dept_no, emp_no))
;
SELECT * FROM dept_manager dm
;

DROP TABLE dept_employees;
CREATE TABLE dept_employees(
	emp_no INTEGER NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR,
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (dept_no, emp_no))
;
SELECT * FROM dept_employees de
;
-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees AS e
INNER JOIN salaries AS s ON
e.emp_no=s.emp_no
;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT last_name, first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01'
;

-- 3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager AS dm
INNER JOIN departments AS d ON d.dept_no=dm.dept_no
INNER JOIN employees AS e ON e.emp_no=dm.emp_no
;

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_employees AS de
INNER JOIN departments AS d ON d.dept_no=de.dept_no
INNER JOIN employees AS e ON e.emp_no=de.emp_no
;

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT last_name, first_name, sex
FROM employees
WHERE last_name LIKE 'B%' AND first_name LIKE 'Hercules%'
;

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_employees AS de
INNER JOIN departments AS d ON d.dept_no=de.dept_no
INNER JOIN employees AS e ON e.emp_no=de.emp_no
WHERE dept_name = 'Sales'
;

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_employees AS de
INNER JOIN departments AS d ON d.dept_no=de.dept_no
INNER JOIN employees AS e ON e.emp_no=de.emp_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'
;

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT COUNT(last_name), last_name
AS last_name
FROM employees
GROUP BY last_name
ORDER BY 1 DESC
;

