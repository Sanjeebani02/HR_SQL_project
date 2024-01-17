use hr_project;
select * from hr_csv;

#changing column name
alter table hr_csv
change column ï»¿id emp_id varchar(20) null;

#checking the data type
describe hr_csv;

#changing the date format
select birthdate from hr_csv;
set sql_safe_updates=0;

update hr_csv
set birthdate=case
	when birthdate like '%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
    when birthdate like '%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
    else null
end;    

select hire_date from hr_csv;
update hr_csv
set hire_date=case
	when hire_date like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
    when hire_date like '%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
    else null
end;

select termdate from hr_csv;
set sql_mode='allow_invalid_dates';
UPDATE hr_csv
SET termdate = if(termdate is not null and termdate!=' ',date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')),'0000-00-00')
where true;


#hanging the data type
alter table hr_csv
modify column birthdate date;
alter table hr_csv
modify column termdate date;
alter table hr_csv
modify column hire_date date;


#Adding column
alter table hr_csv
add column age int;
update hr_csv
set age=timestampdiff(year,birthdate,curdate());


select
	min(age) as youngest,
    max(age) as oldest
from hr_csv; 


select count(*) from hr_csv where age<18;

   


	