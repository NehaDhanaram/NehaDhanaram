--Data validation queries for the HR Analytics Tableau dashboard

select * from [HR Data Analytics]..['HR data$']

--Employee Count
select sum([Employee Count]) as Employee_Count 
from [HR Data Analytics]..['HR data$']

--Attrition Count
select count(attrition) 
from [HR Data Analytics]..['HR data$'] 
where attrition='Yes'

--Attrition Rate
Select round (((Select count (Attrition) 
from [HR Data Analytics]..['HR data$']
where Attrition = 'Yes') /
sum([Employee Count])) *100,2)
from [HR Data Analytics]..['HR data$']


--Active Employee
select sum([Employee Count]) - 
(select count(attrition) from [HR Data Analytics]..['HR data$']  
where attrition='Yes') 
from [HR Data Analytics]..['HR data$']

--Average Age
select round(avg(age),0) from [HR Data Analytics]..['HR data$']

--Attrition by Gender
select gender, count(attrition) as attrition_count 
from [HR Data Analytics]..['HR data$']
where attrition='Yes'
group by gender
order by count(attrition) desc

--Department wise Attrition
select department, count(attrition), round((cast (count(attrition) as numeric) / 
(select count(attrition) from [HR Data Analytics]..['HR data$'] where attrition= 'Yes')) * 100, 2) as pct from [HR Data Analytics]..['HR data$']
where attrition='Yes'
group by department 
order by count(attrition) desc

--No of Employee by Age Group
SELECT age, sum([Employee Count])  AS employee_count FROM [HR Data Analytics]..['HR data$']
GROUP BY age
order by age

--Education Field wise Attrition:
select [Education Field], count(attrition) as attrition_count from [HR Data Analytics]..['HR data$']
where attrition='Yes'
group by [Education Field]
order by count(attrition) desc

--Attrition Rate by Gender for different Age Group
select [CF_age band], gender, count(attrition) as attrition, 
round((cast(count(attrition) as numeric) / (select count(attrition) from [HR Data Analytics]..['HR data$'] where attrition = 'Yes')) * 100,2) as pct
from [HR Data Analytics]..['HR data$']
where attrition = 'Yes'
group by [CF_age band], gender
order by [CF_age band], gender desc
