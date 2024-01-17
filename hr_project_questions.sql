select * from hr_csv;

# 1. What is the gender breakdown of employees in the company?
select gender,count(*) as COUNT
from hr_csv
where age>=18
group by gender;

# 2. What is the race/ethnicity breakdown of employees in the company?
select race, count(*) as count
from hr_csv
where age>=18
group by race
order by count desc;

# 3. What is the age distribution of employees in the company?
select
	min(age) as yougest,
    max(age) as oldest
from hr_csv
where age>=18;

select
	case
		when age>=18 and age<=24 then '18-24'
        when age>=25 and age<=34 then '25-34'
        when age>=35 and age<=44 then '35-44'
        when age>=45 and age<=54 then '45-54'
        when age>=55 and age<=64 then '55-64'
	    else '65+'
	end as age_group,
    count(*) as count
  from hr_csv 
  where age>18
  group by age_group
  order by age_group desc;
  
  # 4. How many employees work at headquarters versus remote locations?
  select location,count(*) as count from hr_csv
  group by location;
  
  # 5. What is the average length of employment for employees who have been terminated?
  select 
	avg(datediff(termdate,hire_date))/365 as avg_length_employment from hr_csv
    where termdate<=curdate() and termdate <> 0000-00-00 and age>18;
    
# 6. How does the gender distribution vary across departments and job titles?
select department,gender,count(*) as count from hr_csv where age>=18 and termdate=0000-00-00
group by department,gender
order by department desc;

select jobtitle,gender,count(*) as count from hr_csv where age>=18 and termdate=0000-00-00
group by jobtitle,gender
order by jobtitle desc;

# 7. What is the distribution of employees across locations by state?
select location_state,count(*) as count from hr_csv where age>=18 and termdate=0000-00-00
group by location_state
order by location_state desc;

# 8. What is the tenure distribution for each department?
select department, round(avg(datediff(termdate,hire_date)/365),0) as avg_tenure from hr_csv
where termdate<=curdate() and termdate<>0000-00-00 and age>=18
group by department
order by department;

    