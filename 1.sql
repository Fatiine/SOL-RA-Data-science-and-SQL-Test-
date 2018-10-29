--  1 - Report what is the average salary of men and women in the company, for all time

-- We compute the average salary of every employee and then we compute the average salary of men and women of the company for all time

USE employees;

CREATE OR REPLACE VIEW empl_m_avg_salary AS
    SELECT emp_no, AVG(salary) as salary_m FROM employees.salaries WHERE emp_no in
    (select emp_no from employees where gender ='M') group by emp_no;
  
select AVG(salary_m) from empl_m_avg_salary;


CREATE OR REPLACE VIEW empl_f_avg_salary AS
    SELECT emp_no, AVG(salary) as salary_f FROM employees.salaries WHERE emp_no in
    (select emp_no from employees where gender ='F') group by emp_no;
  
select AVG(salary_f) from empl_f_avg_salary;

-- drop created views

drop view empl_m_avg_salary;
drop view empl_f_avg_salary;
