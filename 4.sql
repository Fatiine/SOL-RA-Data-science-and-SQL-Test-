-- 4. Which employee had the biggest increase in salary during his time in the company?

use employees;

-- Assuming that the salaries increase
-- Compute the max salary for each employee
create or replace view max_salary as 
select max(salary) as max_sal, emp_no from salaries group by emp_no;

-- Compute the min salary for each employee
create or replace view min_salary as 
select min(salary) as min_sal, emp_no from salaries group by emp_no;


create or replace view max_and_min_all as select 
max_salary.emp_no, max_salary.max_sal,min_salary.min_sal 
from min_salary left join max_salary 
on max_salary.emp_no=min_salary.emp_no;

-- Compute the percentage increase in salary for each employee
create or replace view percentage_all as select (100*(max_sal-min_sal)/min_sal) as perc, emp_no from  max_and_min_all;

-- Compute the difference between the min and the max salaries of each employee
create or replace view increase_salary as select (max_sal - min_sal) as increase, emp_no from  max_and_min_all;


select emp_no , perc from percentage_all where perc=(select max(perc) from percentage_all);

select emp_no , increase from increase_salary where increase=(select max(increase) from increase_salary);

-- drop created views

drop view max_salary;
drop view min_salary;
drop view max_and_min_all;
drop view percentage_all;
drop view increase_salary;

