-- 5. Which month had the biggest difference between the lowest and highest salary in the company?

use employees;

-- Calculate the difference for every day salary

create or replace view min_max_month as 
(select max(salary)-min(salary) as diff, from_date-day(from_date) as yearandmonth, from_date
from salaries group by from_date);

-- Calculate the difference for every month

create or replace view diff_month as select sum(diff) as diff, from_date from min_max_month group by yearandmonth;  

-- Select the month with the highest difference

select year(from_date) as year, month(from_date) as month from diff_month 
where diff=(select max(diff) from diff_month);

-- drop created views

drop view min_max_month; 
drop view diff_month;



