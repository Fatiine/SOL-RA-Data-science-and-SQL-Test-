-- 2 - What year and month did the company hire the most people

USE employees;

-- we create a view where we stock the number of persons hired in every month and year.

create or replace view hiring_years_months as (select year(hire_date) as year, month(hire_date) as month, count(*) as empl_nbr from employees group by  year(hire_date), month(hire_date));

-- we select the year and month where the company hired the most people 

select year, month, empl_nbr from hiring_years_months where empl_nbr = (select MAX(empl_nbr) from hiring_years_months) ;

-- drop created view 

drop view hiring_years_months;



