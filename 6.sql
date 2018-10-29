use employees;

-- Create table with only sales employees. d007 is the number of the sales department
create or replace view sales_empl as select * from dept_emp where dept_no = 'd007';

-- Calculate salaries for every day 
create or replace view sal_day as select sum(salary) as sal, from_date-day(from_date) as year_month_sal, 
year(from_date) as yr, month(from_date) as mt from salaries group by from_date;

-- Calculate salaries for every month 
create or replace view sal_month as select sum(sal) as sal, year_month_sal, yr, mt from sal_day group by year_month_sal;

-- Calculate nbr of sales employees for every month
create or replace view sales_empl_month as select year_month_sal, (select count(*) from sales_empl 
where (sales_empl.to_date-day(sales_empl.to_date)>=sal_month.year_month_sal) 
and (sal_month.year_month_sal>=(sales_empl.from_date-day(sales_empl.from_date)))) as nbr from sal_month;


-- create the situation table containing for every month the nbr of sales empl and the salaries amount

create or replace view situation_month as select sal_month.sal, sal_month.year_month_sal, sal_month.yr, sal_month.mt, sales_empl_month.nbr 

from sal_month inner join sales_empl_month on sales_empl_month.year_month_sal=sal_month.year_month_sal;

-- Calculate the loss or profit for every month

select (nbr*150000)-sal as result, yr as year, mt as month from situation_month;

-- drop created views

drop view sales_empl;
drop view sales_empl_month;
drop view sal_day;
drop view sal_month;
drop view situation_month;


