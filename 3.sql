-- 3. What is the expected percentage increase in salary that an employee can expect after working in the company for 3 years?

use employees;

-- Compute for each employee how many years he worked on the company 
create or replace view fro_year as select emp_no as emp, min(year(from_date)) as fr_year, count(emp_no) as cnt 
from salaries group by emp_no;

-- select just the employees that have worked in the company three years or more and the year they received their first salaries
create or replace view from_year as select emp, fr_year from fro_year where cnt>=3;

-- Supposing that the salaries are increasing, we select the salaries of the three first years for each employee and we calculate how much it increases between the min and the max of the salaries on those 3 years.
create or replace view three_years_salary as select emp_no, salary, to_date from salaries 
where year(to_date) <= ((select  fr_year from from_year where emp=emp_no)+3);


create or replace view max_three_years_salary as 
select max(salary) as max_sal, emp_no from three_years_salary group by emp_no;

create or replace view min_three_years_salary as 
select min(salary) as min_sal, emp_no from three_years_salary group by emp_no;


create or replace view max_and_min as select 
max_three_years_salary.emp_no, max_three_years_salary.max_sal,min_three_years_salary.min_sal 
from min_three_years_salary left join max_three_years_salary 
on max_three_years_salary.emp_no=min_three_years_salary.emp_no;


create or replace view percentage as select (100*(max_sal-min_sal)/min_sal) as perc from  max_and_min;

-- The expected percentage increase in salary that an employee can expect after working in the company for 3 years, is the average of the percentages increase in salary of the employees that have been working in the company for 3 years

select AVG(perc) from percentage;

-- drop created views

drop view fro_year;
drop view from_year;
drop view three_years_salary;
drop view max_three_years_salary;
drop view min_three_years_salary;
drop view max_and_min;
drop view percentage;

