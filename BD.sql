use employees;
create or replace view salaries_employees as 
(SELECT salaries.emp_no, employees.gender, employees.hire_date, salaries.salary,  salaries.from_date salary_from, salaries.to_date salary_to FROM salaries LEFT JOIN employees ON salaries.emp_no = employees.emp_no);

create or replace view complete_employees_DB as 
(select salaries_employees.emp_no, salaries_employees.gender, year(salaries_employees.hire_date) hire_year, month(salaries_employees.hire_date) hire_month,
 titles.title, titles.from_date as title_from , year(salaries_employees.salary_from) - year(titles.from_date) experience_SE, 
 year(salaries_employees.salary_from) - year(salaries_employees.hire_date) experience,  
 salaries_employees.salary from salaries_employees LEFT JOIN titles 
 on salaries_employees.emp_no = titles.emp_no and 
 year(titles.from_date) <= year(salaries_employees.salary_from) and
 year(titles.to_date) >=year(salaries_employees.salary_to) );

-- Create a table with people who were recuited as senior engineer from the first time

create or replace view SE_employees as 
( select emp_no, gender, hire_year, hire_month, experience, salary from complete_employees_DB where title='Senior Engineer' and hire_year = year(title_from) );

create or replace view SE_employees_entry as 
( select * from SE_employees where experience = 0 );




