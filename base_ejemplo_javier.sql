-- 1.
SELECT COUNT(*) AS total_empleados FROM employees;

-- 2.
SELECT MAX(salary) AS salario_mas_alto, MIN(salary) AS salario_mas_bajo FROM salaries;

-- 3.
SELECT AVG(salary) AS salario_promedio FROM salaries;

-- 4.
SELECT gender, COUNT(*) AS numero_de_empleados FROM employees GROUP BY gender;

-- 5.
SELECT title, COUNT(*) AS numero_de_empleados FROM titles GROUP BY title ORDER BY numero_de_empleados DESC;

-- 6.
SELECT title, COUNT(*) AS numero_de_empleados FROM titles GROUP BY title HAVING COUNT(*) > 75000;

-- 7.
SELECT t.title, e.gender, COUNT(e.emp_no) AS numero_de_empleados FROM titles AS t JOIN employees AS e ON t.emp_no = e.emp_no GROUP BY t.title, e.gender ORDER BY t.title, e.gender;

-- 8.
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name FROM employees AS e JOIN current_dept_emp AS cde ON e.emp_no = cde.emp_no JOIN departments AS d ON cde.dept_no = d.dept_no;

-- 9.
SELECT e.first_name, e.last_name FROM employees AS e JOIN current_dept_emp AS cde ON e.emp_no = cde.emp_no JOIN departments AS d ON cde.dept_no = d.dept_no WHERE d.dept_name = 'Marketing';

-- 10.
SELECT e.emp_no, e.first_name, e.last_name, d.dept_name FROM employees AS e JOIN dept_manager AS dm ON e.emp_no = dm.emp_no JOIN departments AS d ON dm.dept_no = d.dept_no WHERE dm.to_date = '9999-01-01';

-- 11.
SELECT d.dept_name, AVG(s.salary) AS salario_promedio FROM departments AS d JOIN current_dept_emp AS cde ON d.dept_no = cde.dept_no JOIN salaries AS s ON cde.emp_no = s.emp_no WHERE s.to_date = '9999-01-01' GROUP BY d.dept_name ORDER BY salario_promedio DESC;

-- 12.
SELECT title, from_date, to_date FROM titles WHERE emp_no = 10006 ORDER BY from_date;

-- 13.
SELECT d.dept_name FROM departments AS d LEFT JOIN dept_emp AS de ON d.dept_no = de.dept_no WHERE de.emp_no IS NULL;

-- 14.
SELECT e.first_name, e.last_name, s.salary FROM employees AS e JOIN salaries AS s ON e.emp_no = s.emp_no WHERE s.to_date = '9999-01-01'ORDER BY e.last_name;

-- 15.
SELECT e.first_name, e.last_name, s.salary FROM employees AS e JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01' AND s.salary > (SELECT AVG(salary) FROM salaries WHERE to_date = '9999-01-01')
ORDER BY s.salary DESC;

-- 16.
SELECT first_name, last_name FROM employees
WHERE emp_no IN ( SELECT emp_no FROM dept_manager );

-- 17.
SELECT first_name, last_name FROM employees
WHERE emp_no NOT IN (SELECT emp_no FROM dept_manager);

-- 18.
SELECT first_name, last_name, hire_date FROM employees ORDER BY hire_date DESC LIMIT 1;

-- 19. 
SELECT e.first_name, e.last_name FROM employees AS e JOIN dept_manager AS dm ON e.emp_no = dm.emp_no JOIN departments
AS d ON dm.dept_no = d.dept_no WHERE d.dept_name = 'Development' GROUP BY e.first_name, e.last_name;

-- 20.
SELECT e.first_name, e.last_name, s.salary FROM employees AS e JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE s.salary = (SELECT MAX(salary) FROM salaries)
GROUP BY e.first_name, e.last_name, s.salary;
  
-- 21.
SELECT CONCAT(first_name, ' ', last_name) AS nombre_completo FROM employees LIMIT 100;

-- 22.
SELECT emp_no, TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS antiguedad_en_anos FROM employees;

-- 23.
SELECT e.first_name, e.last_name, s.salary,
  CASE WHEN s.salary < 50000
    THEN 'Bajo'
    WHEN s.salary >= 50000 AND s.salary <= 90000
    THEN 'Medio'
    ELSE 'Alto'
  END AS categoria_salario
FROM employees AS e JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01'
ORDER BY s.salary DESC;

-- 24.
SELECT MONTH(hire_date) AS mes, COUNT(*) AS numero_de_contrataciones FROM employees GROUP BY mes ORDER BY mes;

-- 25.
SELECT CONCAT(LEFT(first_name, 1), '.', LEFT(last_name, 1), '.') AS iniciales FROM employees;

-- 26.
SELECT d.dept_name FROM departments AS d JOIN current_dept_emp AS cde ON d.dept_no = cde.dept_no JOIN salaries AS s ON cde.emp_no = s.emp_no
WHERE s.to_date = '9999-01-01' GROUP BY d.dept_name ORDER BY AVG(s.salary) DESC LIMIT 1;

-- 27.
SELECT e.first_name, e.last_name, DATEDIFF( dm.to_date, dm.from_date ) AS dias_en_el_cargo
FROM employees AS e JOIN dept_manager AS dm ON e.emp_no = dm.emp_no ORDER BY dias_en_el_cargo DESC LIMIT 1;

-- 28.
SELECT((SELECT salary FROM salaries WHERE emp_no = 10001 ORDER BY from_date DESC LIMIT 1)) - (
    (SELECT salary FROM salaries WHERE emp_no = 10001 ORDER BY from_date ASC LIMIT 1)) AS incremento_salarial;

-- 29.
SELECT e1.first_name AS empleado1_nombre, e1.last_name AS empleado1_apellido, e2.first_name AS empleado2_nombre, e2.last_name AS empleado2_apellido,e1.hire_date
FROM employees AS e1 JOIN employees AS e2 ON e1.hire_date = e2.hire_date AND e1.emp_no < e2.emp_no ORDER BY e1.hire_date;

-- 30.
SELECT e.first_name, e.last_name, s.salary FROM employees AS e JOIN titles AS t ON e.emp_no = t.emp_no
JOIN salaries AS s ON e.emp_no = s.emp_no WHERE t.title = 'Senior Engineer' AND t.to_date = '9999-01-01' AND s.to_date = '9999-01-01'
ORDER BY s.salary DESC LIMIT 1;