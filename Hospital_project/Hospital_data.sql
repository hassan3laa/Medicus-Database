INSERT INTO department (dep_name)
SELECT 
    (ARRAY[
        'Cardiology','Pediatrics','Orthopedics','Neurology','Dermatology',
        'Oncology','Radiology','ENT','Ophthalmology','Urology',
        'General Medicine','Gastroenterology','Psychiatry','Dentistry',
        'Pulmonology','Nephrology','Endocrinology','Rheumatology',
        'Emergency','Surgery','Plastic Surgery','Hematology','ICU','Rehab','Geriatrics'
    ])[g]
FROM generate_series(1,25) AS g;




INSERT INTO doctors (doctor_name, specialization, dep_id, salary)
SELECT
    ('Dr. ' || (ARRAY[
        'Ahmed','Sara','Karim','Mona','Ehab','Laila','Samer','Heba','Ziad',
        'Hossam','Omar','Nour','Fady','Kareem','Ayman','Rania','Youssef',
        'Mahmoud','Dina','Adel','Nader','Rasha','Marwan','Hany','Maged'
    ])[g])::text,

    (ARRAY[
        'Cardiologist','Pediatrician','Orthopedic','Neurologist','Dermatologist',
        'Oncologist','Radiologist','ENT Specialist','Eye Surgeon','Urologist',
        'Physician','Gastro Specialist','Psychiatrist','Dentist','Chest Specialist',
        'Kidney Specialist','Hormone Specialist','Rheumatologist','ER Doctor',
        'Surgeon','Plastic Surgeon','Blood Specialist','ICU Doctor','Rehab Doctor','Geriatrician'
    ])[g]::text,

    g,                                  							-- dept_id = row number
    (15000 + floor(random()*10000))     							-- random salary

FROM generate_series(1,25) g;




INSERT INTO patients (patient_name, age, gender)
SELECT
    (ARRAY[
        'Ali','Fatma','Omar','Yara','Mostafa','Laila','Hassan','Mariam',
        'Khaled','Nada','Rami','Horia','Fares','Salma','Tarek','Eman','Basma',
        'Adham','Reem','Ziad','Nour','Jana','Kareem','Halim','Sahar'
    ])[g],
    (10 + floor(random()*60)),                  					-- age 10 → 70
    (ARRAY['M','F'])[1 + floor(random()*2)]
FROM generate_series(1,25) g;




INSERT INTO appointments (patient_id, doctor_id, app_date, status)
SELECT
    floor(random()*25)+1,        									-- random patient 1–25
    floor(random()*25)+1,        									-- random doctor 1–25
    CURRENT_DATE - (floor(random()*30))::int, 						-- random date last 30 days
    (ARRAY['Completed','Scheduled','Cancelled'])[1 + floor(random()*3)]
FROM generate_series(1,25);



INSERT INTO treatments (app_id, diagnosis, cost)
SELECT
    floor(random()*25)+1,        									-- appointment
    (ARRAY[
        'Flu','Headache','Fracture','Heart issue','Stomach pain','Back pain',
        'Migraine','High blood pressure','Low blood sugar','Knee injury',
        'Skin rash','Depression','Anxiety','Allergy','Infection',
        'Muscle strain','Asthma','Diabetes','Arthritis','COVID-19',
        'Ear infection','Eye irritation','Kidney stone','Lung issue','Fatigue'
    ])[g],
    (200 + floor(random()*2000)) 									-- cost 200 → 2200
FROM generate_series(1,25) g;




INSERT INTO medications (treatment_id, med_name, dose)
SELECT
    floor(random()*25)+1,
    (ARRAY[
        'Panadol','Augmentin','Voltaren','Aspirin','Antinal','MegaVit',
        'Neurofen','Amoxicillin','Ativan','Depakine','Zyrtec','Ventolin',
        'Erythrocin','Cataflam','Xanax','Brufen','Omeprazole','Insulin',
        'Cough syrup','Allergex','Neurobion','Gaviscon','Flagyl','Paracetamol','Cetirizine'
    ])[g],
    (ARRAY['Once daily','Twice daily','Every 8 hours','Every 12 hours'])[1 + floor(random()*4)]
FROM generate_series(1,25) g;
