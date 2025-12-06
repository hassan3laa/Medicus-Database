
-- Q1 : get each dodctor and the number of patient they have treated


-- solve :


select d.doctor_name, count(a.app_id) as total_patients
from doctors d
left join appointments a
on d.doctor_id = a.doctor_id
group by doctor_name
order by total_patients desc;



-- Q2 : find patients whose number of visits is above the average number of visits for all patients


-- solve :

select patient_id, count(*) as visits
from appointments
group by patient_id
having count(*) > 
(
	select avg(vv) 
	from 
		(
			select count(*) as vv
			from appointments
			group by patient_id
		)x
);







-- Q3 : find patients who visited doctors of the same specialty more than once

-- solve :




select p.patient_name, d.specialization, count(*)
from appointments a
join patients p 
	on a.patient_id = p.patient_id
join doctors d
	on a.doctor_id = d.doctor_id
group by p.patient_name, d.
having count(*) > 1;







-- Q4 : get all doctors who have no appointments 

-- solve: 





select d.doctor_id, d.doctor_name
from doctors d
where not exists 
(
	select 1 
	from appointments a
	where a.doctor_id = d.doctor_id
);







-- Q5 : find patient who paid more than 2000 in total

-- solve :




select p.patient_name, sum(t.cost) as total_paid
from treatments t
join appointments a on t.app_id = a.app_id
join patients p on a.patient_id = p.patient_id
group by p.patient_name
having sum(t.cost) > 2000;







-- Q6 : Get the most requested medical specialty (by number of appointments)

--solve :




SELECT d.specialization, COUNT(*) AS total_visits
FROM appointments a
JOIN doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.specialization
ORDER BY total_visits DESC
LIMIT 1;








-- Q7 : Find patients who visited more than 3 different doctors

-- solve :





select p.patient_name, count(distinct a.doctor_id) as doctor_seen
from appointments a
join patients p 
on a.patient_id = p.patient_id
group by p.patient_name
having count(distinct a.doctor_id) > 3;









-- Q8 : Get the next upcoming appointment for each patient



-- solve :




SELECT p.patient_name, MIN(a.app_date) AS next_appointment
FROM appointments a
JOIN patients p ON p.patient_id = a.patient_id
WHERE a.app_date > CURRENT_DATE
GROUP BY p.patient_name;







-- Q9 : Find doctors whose patients have an average bill amount higher than 300


-- solve :





select d.doctor_name, avg(t.cost) as avg_cost
from treatments t
join appointments a on t.app_id = a.app_id
join doctors d on d.doctor_id = a.doctor_id
group by d.doctor_name
having avg(t.cost) > 300






-- Q10 : Get patients who visited only Cardiology doctors

-- solve : 




select p.patient_name
from patients p
where exists (
	select 1 
	from appointments a
	join doctors d
	on d.doctor_id = a.doctor_id
	where p.patient_id = a.patient_id
		and d.specialization = 'Cardiology'
)
and not exists
(
	select 1 
	from appointments a2
	join doctors d2
	on d2.doctor_id = a2.doctor_id
	where a2.patient_id = p.patient_id
		and d2.specialization != 'Cardiology'
);







-- Q11 : Find the patient with the highest total treatment cost


--solve : 



select p.patient_name, sum(t.cost) as total_cost
from treatments t
join appointments a on t.app_id = a.app_id
join patients p on a.patient_id = p.patient_id
group by p.patient_name
order by total_cost desc
limit 1;






-- Q12 : Find doctors with more patients than the average doctor



-- solve : 



select d.doctor_name, count(*) as total
from appointments a
join doctors d on d.doctor_id = a.doctor_id
group by doctor_name
having count(*) >
	(
		select avg(cnt)
		from 
			(
				select count(*) as cnt
				from appointments
				group by doctor_id
			) x
	);







-- Q13 : Find patients who received more than one type of medication

--solve : 




select p.patient_name, count(distinct m.med_name) as med_types
from medications m
join treatments t on m.treat_id = t.treat_id
join appointments a on t.app_id = a.app_id
join patients p on p.patient_id = a.patient_id
group by p.patient_name
having count(distinct m.med_name) > 1;

