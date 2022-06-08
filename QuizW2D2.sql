/*Soal 1*/
select r.region_id,r.region_name,c.country_id,c.country_name
from regions r join countries c
on r.region_id=c.region_id
where region_name='Europe'

/*Soal 2*/
select r.region_id,r.region_name,count(c.country_id)total_countries
from regions r join countries c
on r.region_id=c.region_id
group by r.region_id,r.region_name
order by r.region_id

/*Soal 3*/
select c.country_id,c.country_name,l.location_id,l.street_address,l.postal_code,l.city,l.state_province
from regions r join countries c
on r.region_id=c.region_id join locations l
on c.country_id=l.country_id
where region_name='Europe'
order by c.country_id

/*Soal 4*/
select d.department_id,d.department_name,l.location_id
from regions r join countries c
on r.region_id=c.region_id join locations l
on c.country_id=l.country_id join departments d
on l.location_id=d.location_id
where region_name='Americas'
order by department_id

/*Soal 5*/
select r.region_name,count(d.department_id)total_departments
from regions r join countries c
on r.region_id=c.region_id join locations l
on c.country_id=l.country_id join departments d
on l.location_id=d.location_id
group by region_name
order by region_name

/*Soal 6*/
select c.country_name,count(d.department_id)total_department
from regions r join countries c
on r.region_id=c.region_id join locations l
on c.country_id=l.country_id join departments d
on l.location_id=d.location_id
group by country_name
order by count(d.department_id)


/*Soal 7*/
select c.country_name,count(d.department_id)total_department
from regions r join countries c
on r.region_id=c.region_id join locations l
on c.country_id=l.country_id join departments d
on l.location_id=d.location_id
group by country_name
order by count(d.department_id) desc limit 1

/*Soal 8*/
select d.department_id,d.department_name,count(e.employee_id)total_employee
from regions r join countries c
on r.region_id=c.region_id join locations l
on c.country_id=l.country_id join departments d
on l.location_id=d.location_id join employees e
on d.department_id=e.department_id
group by d.department_id,department_name
order by count(e.employee_id),d.department_name asc

/*Soal 9*/
select d.department_id,d.department_name,count(e.employee_id)total_employee
from regions r join countries c
on r.region_id=c.region_id join locations l
on c.country_id=l.country_id join departments d
on l.location_id=d.location_id join employees e
on d.department_id=e.department_id
where region_name='Americas'
group by d.department_id,department_name
order by count(e.employee_id) asc

/*Soal 10*/
select employee_id,first_name,last_name,salary,extract(year from age(now(),hire_date))masa_kerja,
case 
	when extract(year from age(now(),hire_date)) >= 25 then salary*5
	when extract(year from age(now(),hire_date)) < 25 then salary*3
end as bonus
from employees

/*Soal 11*/
select extract(year from age(now(),hire_date))masa_kerja,sum(
case 
	when extract(year from age(now(),hire_date)) >= 25 then salary*5
	when extract(year from age(now(),hire_date)) < 25 then salary*3
end) as bonus_per_masa_kerja
from employees
group by extract(year from age(now(),hire_date))
order by extract(year from age(now(),hire_date))

/*Soal 12*/
select 
sum(coalesce(masa_kerja1,0))"15<=masa kerja<=25",
sum(coalesce(masa_kerja2,0))"25<=masa kerja<=30",
sum(coalesce(masa_kerja3,0))"30<=masa kerja<=35"
from (select first_name, case when 15<=extract(year from age(now(),hire_date)) and extract(year from age(now(),hire_date))<=25 then count(1) end masa_kerja1,
	 case when 25<=extract(year from age(now(),hire_date)) and extract(year from age(now(),hire_date))<=30 then count(1) end masa_kerja2,
	 case when 30<=extract(year from age(now(),hire_date)) and extract(year from age(now(),hire_date))<=35 then count(1) end masa_kerja3
	 from employees
	  group by extract(year from age(now(),hire_date)),first_name
)a

/*Soal 13*/
select 
	d.department_id,
	d.department_name,
	coalesce(sum(case when 15<=extract(year from age(now(),e.hire_date)) and extract(year from age(now(),e.hire_date))<=25 then 1 end),0)"15<=masa kerja<=25",
	coalesce(sum(case when 25<=extract(year from age(now(),e.hire_date)) and extract(year from age(now(),e.hire_date))<=30 then 1 end),0)"25<=masa kerja<=30",
	coalesce(sum(case when 30<=extract(year from age(now(),e.hire_date)) and extract(year from age(now(),e.hire_date))<=35 then 1 end),0)"30<=masa kerja<=35"
from departments d join employees e
on d.department_id=e.department_id
group by d.department_id,d.department_name
order by d.department_name 

